Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE37C369D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 05:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Sof-0002Lr-8j; Wed, 23 Apr 2025 01:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u7Sob-0002LX-Pg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 01:38:34 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u7SoX-00065x-43
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 01:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1745386709; x=1776922709;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=HzL4LvuinUD18kk5FLWji/0iUHhZCS/PqnfwsprGir0=;
 b=UUqQdKNiA8Srl16MhrZ1MnlL/XqjPdwstUNH6L31iqx2mIQYjpDfpb8p
 nPF7YY6ROf5Jpx9yQMsFAgaZIT6M8NvOGcEBAcQxPS8W2WRwFZWfvCnXq
 JK5Kz33M8OVC7eQJMfObezjgj6UXp/BLdE6qvOXrvfZFtOD3rs8FPECDw
 fHfnj+UK1QDCmOfWJyTHJE7K622g28zVjUYZYFVSl7QEculvJk+NP9Wpq
 3oTHpjUSW6b6IE0WAQT1RtwBg1VEEfLJ+88V6o+kbeny3lRYYtiCcMeva
 gxWbMXMCKBJGahPeHcm2qwTTY1AQVU6DqLoub6Dn4fkokwdRdzfwhEQ7a g==;
X-CSE-ConnectionGUID: O67X+/OcTdy5RIgEG6ljww==
X-CSE-MsgGUID: H/PNVOKnTGi4MtgQQXPDBA==
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; d="scan'208";a="35542795"
X-MGA-submission: =?us-ascii?q?MDFN80XCnuoNSZUKS8US7Xz26jGfoWQkPz2BQn?=
 =?us-ascii?q?UdP658/36xec1ji7lqPfCgxfG7WLtZTIFwT0IX9f6A6DvhlcVC13Vakh?=
 =?us-ascii?q?BDDPsQKdDnfIkQQuYuRbUrnHcH5EE7z6lPb/1WyLwkQbDGyhyjJr47xa?=
 =?us-ascii?q?kzIGYpK1DyDm+hxTdkFL1teg=3D=3D?=
Received: from mail-vi1eur05lp2169.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.169])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 23 Apr 2025 07:38:22 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XO+dza1cSYoNVS0Tt2UkWDSBCp4AFsnpSHXx47HcWJ83ePvzzz5XIeIvVeMZpXY+UlaDAeNOHM9Xmrqgl+yqh9N1WILijvWHpIbQ2dstrXOpZc9IDMRzFVqnFJrRkxTnJKtNYQklQFcftWhdshJ+1JopqnGn0r1WLu98PrWDslJOpUIH2p/67tE2S2lespGto1NWj6xT5T4dKkpIXougSm1bPEv/26ckUQ3V3ZqQffBFeN3mDtT7tCpDoxqkrN6eYBBdsRihVERNVysA6isosaEKyigJ7gbDaPgyq6M5NPqrwSAORJId3VkmbnOD0zkqGiUXQ5s/mlPAzoR9N1Ff9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9R1StYdnKqfE1N4pNHnY8WbGGb1Fh3240stUPWYpCk=;
 b=rlKvGMWfCsBxexM1GPOX8M9/1FtgRMkLES6YjlVoX/WLB6L2O5ejPk7hKUUrfJqGCdM5aIgqsU/NMQREMfBoIywG/FEgCdTt2X3T32QPYPSqdAsNpvx2ADffjbN9jsDBUryuL6JS53JVv0Gj9dv85eUSooJk7B6i0HN1J3R4swCVTHSPk2BJfRlN53NwUIGr243cmrVEzONeVqPyGyVgc82gsui8n9gWQSr8ZOwKalAqPq75EX5yUDUuEbBWoNBmkoc0fdqcS3YoObboNtH+2w4Dl7Yo+eBGRmCTikFsnZXFify+BNLFGCQmTEZSmC8/QRjnnBoFPdJuG/Gsr1wZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9R1StYdnKqfE1N4pNHnY8WbGGb1Fh3240stUPWYpCk=;
 b=JmSmgqu97uT2A3MOK6a/Dyv7iBa2YgHS4rJzOBc475nNpKpFBuZvZymhyXjvSAQgSQndjY82jPbDtTzhVW0KVMnxKV/BAPbbSNbPpMHdLO7wjSbBV1OMGDLeRKvV+ZFziSaqyaky111GAHUIMjLjemOCmk1uggwJv8tz2ILrLNthblhx/qBtGndcop+Q/EDOnFxuDCbyUzhrkGsgM+X1shX0W6zFnTaORrH3SFO71CqNd7iuYCPHppECcS7Ctout6zNeY8YIuOMdDHRJF1S5mE2xw3wAhSK7N2dM+hi3B6HHkMTpCHpSAuUQUiX/feLCUBugc2KfQIYINoI5kKYvFA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB8516.eurprd07.prod.outlook.com (2603:10a6:10:35b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 05:38:20 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 05:38:20 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 1/2] intel_iommu: Take the bql before registering a new
 address space
Thread-Topic: [PATCH v3 1/2] intel_iommu: Take the bql before registering a
 new address space
Thread-Index: AQHbtBHswoqaONJjl0KQ7HZVe2CuOg==
Date: Wed, 23 Apr 2025 05:38:20 +0000
Message-ID: <20250423053742.65401-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB8516:EE_
x-ms-office365-filtering-correlation-id: 3a11cdee-96bc-4d4d-f323-08dd82290e8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+kh8gG7EVkCZnQy4IT5Uz4+iSU6oJOcfmGz5pE5FWg2aj7fK8mgesx+llb?=
 =?iso-8859-1?Q?ZIaVkX82dWriJiFjWXIB6q8dSViYRizcGcp4uXp+OHGBGiHYDpfKaM9kp8?=
 =?iso-8859-1?Q?pf6hnBHfibciAkituFHLASVJekCIbjitxk6eJDA+sZNjRoqpW5pGL2lwVE?=
 =?iso-8859-1?Q?f+SeeJlchp2Yw9Nme3OPg/r+oBxQ6eRSZx9AhecDHnGZTi73MYwKbMDVfb?=
 =?iso-8859-1?Q?BaBCDkMdTd2VG69QGiwb6+/0PT9vwChh9aE04QR/YlG84H8pUQcW2SJDvG?=
 =?iso-8859-1?Q?0kU7so1mSG7ISKdNW8+n+OGRLhhyqF272UQjWCwzNDrugBsXd77Ey8f0C4?=
 =?iso-8859-1?Q?cUUoH7rLOp6dRoe514Z3kxaFQx1k0+27t1ggRQ/SPzgViTDSoWWWAE1Vxg?=
 =?iso-8859-1?Q?OVbwgbVrQsgzgyLSUz+EPiDC9UzrIBicVT2iGWg+GjqS+DK7l62Md/IN9s?=
 =?iso-8859-1?Q?ijYX1WgHWEvyMhS4VPwG07uujI7yQDuOnke4YPBCSAW/JBpyKCi6gMn6kK?=
 =?iso-8859-1?Q?kVur0mWpUYzZOQa0+AVDLE90q/DRCAOHMfP3GZ0Kva0mOhdd+cV1Zn79OQ?=
 =?iso-8859-1?Q?ze1KwPbbxML0LVr5YJfqSRTMWaIXwqQxOtRDznX2KzmMJRsJxilsAuqawP?=
 =?iso-8859-1?Q?4q/cFrveMm072MMuG0NgPv628M57sWZXP3zAyjvUyGxLZImodul1+L6CFg?=
 =?iso-8859-1?Q?x1OgmDMnQY6gmxnYbeBghKmbqdZNecbwb1X19IJhzyHzzeTQD91PCm/5uB?=
 =?iso-8859-1?Q?nRAMzu8Uqgxia1/73DAt2tONjqjjrghJdTskgZ18PfXr6YZAl47GqBc81C?=
 =?iso-8859-1?Q?NzykgnBU+sfhtaeBEtJaFSkxuAcamMBwigEKITWGoN1SSpCw/FizwQVQwJ?=
 =?iso-8859-1?Q?T1qZs7DdE1dAsyC+5KlTJGr/PSqfS2LDNc780IN6bb/HxqtNwD7+yt+FB5?=
 =?iso-8859-1?Q?RNal9p0vSSudWAkfEKQ5I8dl9zBioGU7ieIw4c1j5uGaNYW41sUsAbTLVy?=
 =?iso-8859-1?Q?2PiCvaQ8mwnFoERODt6AV4usIvY3tWOHstrAwmvEcDlF2w/NXsDCgw2kwx?=
 =?iso-8859-1?Q?ZqI/5xky+7T4hJHC9mTO3KmbeTfezVw7cLTbjM7Xzp6kfGvkpaY1zw9LKR?=
 =?iso-8859-1?Q?NOYwNOozK221afrLa9DB1kB8vZobmEIB57BGvhlRAmgnHHAsd3xosYqz7M?=
 =?iso-8859-1?Q?MIDyikRdTJZ6DoZxfW4sHj+1cKrwa9ys2LGibYfkLbThVdRh3wUUpkp9Mh?=
 =?iso-8859-1?Q?qRyuCGZNHoM0zTgP9rSkZhz1TiQTsYQ45folg5C2CkIILgf5+C8mOLlzLI?=
 =?iso-8859-1?Q?caR9gtNfv0P83xc2fiZbnslfJqEFlLAb1/sOcqj83FQ95ClMlEYax5PBNT?=
 =?iso-8859-1?Q?YRAa6XQLrTnpKYzJUnx8dv+9gQz6LK3hFmqvaQb4NpeU8AO4ywOE3hU7mM?=
 =?iso-8859-1?Q?pg8ZoWXbNzu5SYrxcsUzRzvLk8mfNlXdBAZnoOygFnCXXf1+CvH5tBENCK?=
 =?iso-8859-1?Q?Yw8t2fa2XOyAAF7kmcIE45A++9CEhEZEcofD9eBOFGeeIGHDlTn+AcYSbG?=
 =?iso-8859-1?Q?8OX0s+I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rpJBruBJxbpsMx17xYwvLTxPeES9uXwtQ7sYUnOC9YO34Jw7uq5lxN2ip2?=
 =?iso-8859-1?Q?8jUoqrYi3mQlZOU7olThJXGIsS5fpZiGlSpXC9YajFxVls2c+DVqLWBfdF?=
 =?iso-8859-1?Q?ZuvPwMvzKk64BM/jWcIDH3Q553AmE4kxJwA1OgX9nhw6w/zkYmvreS7Sp9?=
 =?iso-8859-1?Q?znSa/qWNGCrjMRyt/oinvFftp33/0xaE9uPCbm/GPNsPQx5dh0rIW9nBfo?=
 =?iso-8859-1?Q?5ALg31RZ7QM0KvPmpJfp3w3qEM39shrdWgzwBsMTMsuHWZfsgw1KcFRx4X?=
 =?iso-8859-1?Q?x8RZw94K/Q8y1Xxb9+z+T1x3jyTKt2NO9radc95pLUl2X9sE11ANv3Svc8?=
 =?iso-8859-1?Q?IJ5qLKbj1qO/IKxwqqbHa9UEWKuFZP0XI/MTsqB3upZINt3c/H9oAaBn67?=
 =?iso-8859-1?Q?W5ZF/3tpVjERhgZQJ/h/4ALstznjFWUsUaIPjsYGzwVfFO1UWjAOt2RsI7?=
 =?iso-8859-1?Q?SOk3cuPCPWiil2XsAGCWBKmxBYFUfgM6jwilsZa/qCEcaD2MoiOgDlhbXw?=
 =?iso-8859-1?Q?BtKyKbg70Tt3Kje4+pa5zkBMlmjqdf37sDPOohRDdqneNirbO0kdefeifu?=
 =?iso-8859-1?Q?Ua74A38LQpTB17yw6MDpSWDayEBBZ773otPG7DvCfJQOozWeOhaLhmuxww?=
 =?iso-8859-1?Q?Oo+xE3tuXFp4sIfmYGFAnIj9rkaF8tEIXtYXW6eRv950o9qJf6YagW/3xk?=
 =?iso-8859-1?Q?ptUeFxRasqkvfUwaJSfRveLcRdRN/twan1/ORQpUvOXu6FpFQaSP0E+NnJ?=
 =?iso-8859-1?Q?K+urQ3iYzUirE9Oj5YVn40tTC9Jpl0ZN8e8JUg/FW3xAjM5TxP37D8ikMD?=
 =?iso-8859-1?Q?mPkWpgATW4VK3xj6K4St3fndpgRvTUAqLX6785/bTuSNjjJOyVLYqixLB/?=
 =?iso-8859-1?Q?ZcYSZxAfmypm3X6ekp2baLOba065zAYgCk/97ukWm5ytKBvYGkBPkswzhI?=
 =?iso-8859-1?Q?tgjY/TFdqP7DiqBgH6d1T+icKzK396vTgdXVCdtvEL53s30khaGld+8iOl?=
 =?iso-8859-1?Q?x2x7tUtZlMEBNnThQwNm1bXzhe5BICRne2gw1jSCz+2VNN8162/IJ9FkMH?=
 =?iso-8859-1?Q?fbm0g5AYtaXSfNDrnEJHVVkYncO+G10E20J+fSlFlXpwtSZpWSI2giTfPW?=
 =?iso-8859-1?Q?bF2VBl3oqDxHj9l27JtLDCWOLCrEffTZKGkdBpAGg34JQJ3hE4MXE/aDt3?=
 =?iso-8859-1?Q?i+t5xLOTQm/Otsu+mppucUrLn7KLCT7pR9JQwkIHXMwxK992IDtw6lGKNO?=
 =?iso-8859-1?Q?Ntjuu4Skl7sLqghq91BOY17YlP3tsokWJqBEFPTMdcPHBjYMwES9hHMLTb?=
 =?iso-8859-1?Q?N5+Mz8uvg6nse0tpQM7Sfv/xPAlp49tF4Xuv75PP10WtSzvErPG2QAbOsm?=
 =?iso-8859-1?Q?qQl0U0LVRm3fVK2KF+fk7fmpnvY4yBbmuSPjfW15eu1HeBR1+n06K//Kwn?=
 =?iso-8859-1?Q?e655e6KOcMqy1DHtG90OnIqj7Pxes7NQWidHtpE89vI6wMcONIDiQBJ6vM?=
 =?iso-8859-1?Q?NBp/W9DqnJSBlJsQj1+4sLlFy5L7aOrWo/WatH4nqakOVQE2zoyUserBNF?=
 =?iso-8859-1?Q?APMSVqehFXH7Rrp9sxs4aVa6zJ96nBgOnqj5laTnfARxopfdCOin/GDDct?=
 =?iso-8859-1?Q?y5AzyZBul1CWZtlUbk3Hr2uZrb6rZfI9yYbdw8V2TSsh1iUHTqxNWm3XYH?=
 =?iso-8859-1?Q?h13K2PieulCXqZXh3G0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a11cdee-96bc-4d4d-f323-08dd82290e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 05:38:20.5713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Ue5IsWWrQ2ZfpfIrbazBqdxvzRgVerc1OzbMdpYPeephj77cZDZ61kwnUp/PEixHtXbbzCASqXI+avWt+IyQjNKHzDj6r8jK7WAXra29YLfYxnvnvdfNqxX2MkD8Jzt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8516
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Address space creation might end up being called without holding the
bql as it is exposed through the IOMMU ops.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dffd7ee885..cc8c9857e1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4238,6 +4238,12 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s,=
 PCIBus *bus,
         vtd_dev_as->context_cache_entry.context_cache_gen =3D 0;
         vtd_dev_as->iova_tree =3D iova_tree_new();
=20
+        /*
+         * memory_region_add_subregion_overlap requires the bql,
+         * make sure we own it.
+         */
+        BQL_LOCK_GUARD();
+
         memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX)=
;
         address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root")=
;
=20
--=20
2.49.0

