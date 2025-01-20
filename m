Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8F6C02185
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmi-0004mj-FM; Mon, 20 Jan 2025 12:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmd-0004e5-1K
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:55 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmZ-0000YG-CE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394911; x=1768930911;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rPkEds8qIZp9TtuHjcRhlqEFYcVgIFkbOepMRSmEI7s=;
 b=b+2jMOhjEgjokUzn9/ysLQv1yapM9QMUQg3yfxyI0yovwnTd842FcPGP
 V0TqXo3KEIRLt6dcPnzuWwCUbSdBnGD7bJ4q7EkHsIa7sbsVP5utBiPLj
 nzysO7Oz+C58JIdjDa3rhUt5uBj8XkFQwFXtCflXl9KR5nB/UWQI6jWWB
 1bsK0gRK5zj5bZjW3co64/Ud3DPr8NPCKMZqoeOj9lNw+Lhn2H2jGl1Ya
 Q5nYm9trNBL73MW54gRmI7DkOVrcEgise+/hhTbtNSyNF1BB4Docl/NhZ
 Gx6zCnGmUjE5BXRQXvQuk23awm3GoILnWHrYyrt8J9GEzP5fh4CmOl/qN Q==;
X-CSE-ConnectionGUID: BM7uEzDQRXenTiS/GdwBsw==
X-CSE-MsgGUID: /B8S6bAcRmeVlC2t8tA5Kw==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29125397"
X-MGA-submission: =?us-ascii?q?MDHnk0s8qWZbw1BrlGt9IYR+THA0M0DDyYTKj6?=
 =?us-ascii?q?JAIDD9IzEzk7y+FLx0C/PVz4+uLhDhpmlykOEeub8R7rU0ur1KINHMVM?=
 =?us-ascii?q?0TRDX/CJxud/K+gy3eW3cxa0B1YaT/LDx0XgxLOMP4g8jQ495Jzd0eLj?=
 =?us-ascii?q?giBNBiMzBeW8WHZlKOiw2BCg=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:48 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTQT2KdyyOKNHsOCJz4VLnkEAlIIlO9VuKSYiuCiqQZa/oWFxYifVh/MtwePVNuAUOV+VKoyrlsLwdE8elW+wxo1vO5k6qIV3if6youtMEWScng7arseJo6EsZqjBsZeIJCEAm+xaUEO7PBw7c/1M6EshDs5Y80es5TWVefsz8l0KYO2W0QUcstI5aV3MFg97B8XQseliD8dxt6e0grKDMPv6RH8ikd0qevjmW7LK6udvUhCI5fn7yV8AwLYm+s1KaXfgeO+5PmK/mUwrcrNqN02/hzaicqZtrhxSFhBJd/3QPk24S2xL5PSzooPiPXy1vlc8OxzJJjXZdNIzUEkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIAdhx2JHVjQ7wp//+y78pr/QiWJCBXfQSzY33lVXdM=;
 b=Egt5hAduivSlEP9es6MEyC5zM9Dpdl32xRhDq8Y6QUGKjDVjHpd/4NPB5OF4M0kAZTJnBH8tQzVjVk0w5li1/Pz+ruP16IkOnQfIcpHlbBVlyGP6BpVq5bUezUTirtrFZj37F9rcuarRmpuHe20i57GMU2V6eHNCMdHsYC2WGrMLIpVDQ05LXTlSCixyG6zeEduMIYkljG2Kgew5cxbmayXerWx4KBNFPLOay+PdDwCrLQ2wo6B4r9038rAEJu7QuKr8IbA4xPNZ4Mp8t1Z91ZcvHYN1FwtqcmN5MtGZ0DBJFy2vJB9HmhrPCzuR4+7WJ0d0fLvVPW487qNykCdBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIAdhx2JHVjQ7wp//+y78pr/QiWJCBXfQSzY33lVXdM=;
 b=po8H3mMk0tnfUhiQ0U4ghctTa/SXWbu5H0GQ8cjYT0TxQBGpnyTPs0qU38eIqwlT0pvP24RqTpzb7mhedSGWuJfbZaSywIYDryzCyKk/VxA8BT79SmYUIGRkqVyc8ldOe6sLCOyhACvGfdvaz+ZkiVDGHAfU6awi6oSpU2GvJmI38bWPsL6e4JatdmWcGyY34lvHqqwrNSGPmlYlf+Uta884oTVdjWqMBxVhxf77oWbi8ogE81B3SFg0TpE1B8+FpEgoWVQWIKfzlQXrZ2UmLjAaYOPPuF6YSM6doF5vEkuIEHS67NdxpXgJKs84AN2IZRpFhbHTfB8Fdp8xnFss+w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 09/19] pci: Add IOMMU operations to get memory regions with
 PASID
Thread-Topic: [PATCH v2 09/19] pci: Add IOMMU operations to get memory regions
 with PASID
Thread-Index: AQHba2KUJdA6wV4bfU+cysc549ov3g==
Date: Mon, 20 Jan 2025 17:41:47 +0000
Message-ID: <20250120174033.308518-10-clement.mathieu--drif@eviden.com>
References: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7548:EE_
x-ms-office365-filtering-correlation-id: e7fcad6b-09f8-4d07-b5de-08dd3979b6d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3ecSMNxJk1wR1RnNawbgqeovNrHml1mCDSj9mNgjcvmjWgRgm+lfATSydm?=
 =?iso-8859-1?Q?WeYKQprlty57cSVPAFftg9o50aD3d4IetT5g6qBBzerBuLoSfIaVBh0V/A?=
 =?iso-8859-1?Q?Sh8e5iDsH3LPWhEcQfUx/IcXWuRNZBrOBGaGW9itJmmiRUlv83iy4vlw4E?=
 =?iso-8859-1?Q?F1DVl+NuuayI57J7MV0V71ov4IYsIIFT7bpxmfdjVV89qBOLQdEH0PeHcl?=
 =?iso-8859-1?Q?hjWNmfVgX+rq9uvPI3bIqzw3jmfCHcFdXTms7TJSknLBuO+YCCuANX6LSe?=
 =?iso-8859-1?Q?xH/sYlZUrIrASSo6s5jV0Q2mentfQN1d6mpKd3wOWzaR9q2QaDv3FmSkSq?=
 =?iso-8859-1?Q?COjb6kHsb+X9+592xrjXCIs1R0VC6/5CuihR7OTSriZxYvIradPr51wuxa?=
 =?iso-8859-1?Q?9K/oms09I/9WP8mj28iXOh75YueqJWKMt5t0KhGd0yYc/URWBCwaHIgmRq?=
 =?iso-8859-1?Q?lzMYU5E71tQbQQiLtgBoVz+1i2FQXHjevM8Crr6H/OXTeTMnKRCb7Fvfcr?=
 =?iso-8859-1?Q?dIDTXYazOR3+qzINJ9ADkOjtwmG/0GpUVabWA9FX+Yi+8OYxFdHqgUXi/B?=
 =?iso-8859-1?Q?XmsZKfIUoThNpL0QKWUjQWYP+RUHdQidZu0lSgKfusonXu7wVW2CTuL10e?=
 =?iso-8859-1?Q?mDCTZM2s2E2pQ229KY3lMmCpyhargMI30l5n7HetaMoIFzvciqjqhrPQO8?=
 =?iso-8859-1?Q?e7pEHnn3WmpObAz6bT1JhCjPwsal0JEnI1CxH1zHkKir2s1MGd8vUMfssA?=
 =?iso-8859-1?Q?NKIaeVKoFygi6Of2Ch2FvrYvsZ9cpG1ST/g55QVGjpDWyMNAZ9ntfAHBps?=
 =?iso-8859-1?Q?1sQULr6MyZc1Z1nzifJsFkeQMH1k0hsyGoxopNmpg1P6XWK70SKCwlS/oB?=
 =?iso-8859-1?Q?bOIGV7o4+uRl5NqqpbObf99s8P1LqWr3mPRs1yszIe7adkTGWf8pBxZsMz?=
 =?iso-8859-1?Q?A84Vx6zytnVo+CFq5FNQmhiO4jCRoLea5VhvhwIJVziKRA2unO1rw+wf0R?=
 =?iso-8859-1?Q?fkMcotUO8pk+n3EZ9Anx69Lbxqr3L7mrUgmSXWou8rjKcxWtwzQNVlSaXq?=
 =?iso-8859-1?Q?UqNqBMQgTU9taJ2cDBVq/VOhzbnaoXeLuMSFzpt5B/UUqqB5qIowIPSO0G?=
 =?iso-8859-1?Q?rDAXCvRLQwiKdho32TnE0TGaiuL2kLClEs8lZVCSM0MrdCCM3VF4wYHNA1?=
 =?iso-8859-1?Q?mrxeZnhuNPytx4Ae3bOUa4nkrgxuQgGsrhHZ0Xq9J1T+N+Dm0e65dtmU7s?=
 =?iso-8859-1?Q?Fx/1yN4tmCXWQ5gXIQIfklDfDSsoLzRjBGhCnS4XwydEe2tVvvIA4np3gd?=
 =?iso-8859-1?Q?Lc5ZZ8QfGsjZJU/o+Zh87d9SKN8erYK9gFy3YiphXbaiiZECOJRsjkpQgD?=
 =?iso-8859-1?Q?RPGmJ0wm75QijvhtrvVyj+/2GnLz93fcT0KYVwq9YqhKnX6HZ6TVej1idP?=
 =?iso-8859-1?Q?PILZgX0CHM/FawN5nwPI1hb4J/+mxd2OpWG70+UTK0Qm7lIsqaXwHuis6R?=
 =?iso-8859-1?Q?8J1l2E32Pj7frAYoIonFp5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UQe5nPZwPmP1UJR/97Ok4yaOaBHGg5bZO5z19Eg5vakmmG8p8+qGMKNWSI?=
 =?iso-8859-1?Q?h7S8dYkhs2Zkau4qxpef6Wp4sC5OdN3F8zeXcc3/tUZ1fetTNXSB/BLlG/?=
 =?iso-8859-1?Q?Fk2ns4F3Z1yW8O08f3hLPoSdEOeAwbarhKT8Z8eXq2KdmCGuXNDyV5DABt?=
 =?iso-8859-1?Q?sr+a4gKWeUQhgVVXSsOhxKt+ktdSOWQdvmrvjxeehjDE6DrpETztf7Ii2T?=
 =?iso-8859-1?Q?pKdJ2GDUiUmvEvxLl4dJdRV+ioMc4nufXkvo9X0X1UoDmugIYAdsOkcDrm?=
 =?iso-8859-1?Q?nRh+kn2CtsGZw/ipFhEpOZZg/jNufAeAfKXy8GB2nklXvvkgLEafWB5fXN?=
 =?iso-8859-1?Q?i+MnUSP7yHlCUhXRLgqj842bYlp+c9yZ0l6hCT0sAbQxNscxO2RXvqcb9T?=
 =?iso-8859-1?Q?ZRbuwXo7zJLuy8AeqESreYldjW0L9J7udoGWInHUVulWiop9uISlws5hH+?=
 =?iso-8859-1?Q?POgNF+2XaBvzsT5qixarrGt4wYS2Ofo9YQgeJ4weKkolV65wbTctmsdi+T?=
 =?iso-8859-1?Q?eG0h5gheY9b5DdUUbd5OyU1h+2oSGJOjfZMAufRM/W2X+hIajK+Usp2bX1?=
 =?iso-8859-1?Q?zB6eUr00xTQ0tgFLHfdR8ZJTQS6I1HC6yNhQZTgUNXf0ogpHeOVpdtU2W3?=
 =?iso-8859-1?Q?/opoNIk7AZcqET6OPmckwhuFZ1MnTtvTApjyknIvard9RMQkPwk3OqsaGb?=
 =?iso-8859-1?Q?oQCx/3LtSBsKjhMVUH++WfQgLnpBhYuQWa1v1qF45AdOw8uPHxgOrf0K/r?=
 =?iso-8859-1?Q?+Xhc/rJ9K/iGPUUtJiTmLp3SvKFWigeiBC3N29hFau/ix4FSlPWyktlJBG?=
 =?iso-8859-1?Q?pjFX+v9GMW1ynUbRj+1ENbQNdnhwcrAG+Q4r59esftxM1lutxVvq5sGt1E?=
 =?iso-8859-1?Q?8q9wR1fbGWAZI7JblZi0J++/C6FSIxCxOdv1/aIyhLzxnNV2VioPfX3j97?=
 =?iso-8859-1?Q?WS7H8X5EgDugmlBCEO6e5Kli82D2SJkPpeJvQvtb9CZ1FO1d4alnYPjC88?=
 =?iso-8859-1?Q?0LBmCqqs4DFJsD5h06BPPcG5lRfqgKs0z+TKqQM9fqcm4WE+hI/dERpQYO?=
 =?iso-8859-1?Q?LSXGPzmNCmMPTKC+qH1Z9N6OZis1h77fBqqU0ysbhCWeFzU7t31f09B2Vk?=
 =?iso-8859-1?Q?V/6EhYmNmLhEgv7ec1G9SqIEyZ7kn7pOoWM+3UfiBCnNfScIEnyl4a1Hg6?=
 =?iso-8859-1?Q?Mzn4xXVXtCIUk4e0rg3UkfPkHbMR0E/ruK/5j3vU2bGHJZXtVIbE63XnxS?=
 =?iso-8859-1?Q?bDXrz8Q6TceDmzBz01HItM7ka7USpKqJav/0cnDI/FdgQqJXXHQ66ROhuM?=
 =?iso-8859-1?Q?XQRfspyGOGF0D+ZqqSiQCNeB7kAsrwuEEGZPihkhef0mdoXec5WLypfcNA?=
 =?iso-8859-1?Q?+jAAyi7d/vlwXvIB4gZIpjvsrUtxoCZ2+97aCFmQV7/fdMzbDL+lI6/EKl?=
 =?iso-8859-1?Q?lO+Yhh/kamKjOaBo/HtXeVfJCz9UgzPFmFw7EQvLbhbSBg5wHJRB8WMx8j?=
 =?iso-8859-1?Q?bBUw4gDa0etLThH+6XgU3eVtbU4I5rdwIUUgzRuVxFSXmso/WOsYGQlDj0?=
 =?iso-8859-1?Q?WNnQka/4mBwgOITUwdCnf99DEWy10m1P7/VRdTkc3U+/DDdi8AluEEWokZ?=
 =?iso-8859-1?Q?1TTKN1X1SGtD/7o2VemD6/XbkhWsk2AtQxkhAB5WvM1lbI+3p/fP/Ykr/L?=
 =?iso-8859-1?Q?70S2WEsAhUN3g+H/ON0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fcad6b-09f8-4d07-b5de-08dd3979b6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:47.7939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Loib89T37uEn7S8mZIJy5H2BtT0w+tMlZ4xLrjBVW4yA6nD74RVmHEXypyVcc25I2fcMvVmvDKZkjU50EuV2JSt4gvtkp0eMeKVlJHqvmfn5/RQBtwBr+iylrzOnsvWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

The region returned by this operation will be used as the input region
for ATS.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/hw/pci/pci.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 4002bbeebd..644551550b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -391,6 +391,22 @@ typedef struct PCIIOMMUOps {
      * @devfn: device and function number
      */
     AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int dev=
fn);
+    /**
+     * @get_memory_region_pasid: get the iommu memory region for a given
+     * device and pasid
+     *
+     * @bus: the #PCIBus being accessed.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number
+     *
+     * @pasid: the pasid associated with the requested memory region
+     */
+    IOMMUMemoryRegion * (*get_memory_region_pasid)(PCIBus *bus,
+                                                   void *opaque,
+                                                   int devfn,
+                                                   uint32_t pasid);
     /**
      * @set_iommu_device: attach a HostIOMMUDevice to a vIOMMU
      *
--=20
2.47.1

