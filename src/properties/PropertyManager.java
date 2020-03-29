/* FeatureIDE - A Framework for Feature-Oriented Software Development
 * Copyright (C) 2005-2019  FeatureIDE team, University of Magdeburg, Germany
 *
 * This file is part of FeatureIDE.
 * 
 * FeatureIDE is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * FeatureIDE is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with FeatureIDE.  If not, see <http://www.gnu.org/licenses/>.
 *
 * See http://featureide.cs.ovgu.de/ for further information.
 */
package properties;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

/**
 * Class generated by FeatureIDE to read feature selections from property files.
 * 
 * @author Matthias Quaas
 * @author Kai Wolf
 */
public class PropertyManager {

	private static final String RUNTIME_PROPERTIES = "runtime.properties";
	private static Properties property = new Properties();

	private PropertyManager() {}

	static {
		try {
			File file = new File(RUNTIME_PROPERTIES);
			if (!file.exists()) {
				file.createNewFile();
			}
			try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(RUNTIME_PROPERTIES))) {
				property.load(bis);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Gets value for queried property. Throws error message if it does not exists.
	 * 
	 * @param propertyName
	 * @return Value of property.
	 */
	public static boolean getProperty(String propertyName) {

		if (property.getProperty(propertyName) == null) {
			System.err.println("Queried Property '"
				+ propertyName + "' does not exist!");
		}

		return Boolean.valueOf(property.getProperty(propertyName));

	}

}
