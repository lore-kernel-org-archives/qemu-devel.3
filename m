Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A45C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXc-0004h6-Pp; Thu, 27 Feb 2025 05:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXa-0004cN-K1
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:54 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXY-0005o1-M4
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653693; x=1772189693;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PiyTkK6hdM98UWkbkeuE8WtZivWls1Pdx4DsUKcW/KM=;
 b=hEnjO1kK+b6eVmmpWY+QrBJp2JScFYJCNRdUTYgekrZmC0GKGaVS+EN+
 IjrVCJy5EzIk4W6XB/7xdCUdUwzBdtBXL+j0k+slfJQNmkdTcuMqJVGaP
 2bVSUqU5kpd/ylDUZinooNZMYZy8DUTEAeFJezzdq4mwNl/drSJqkeIwC
 opQBk1mSz/qc0k+vOn84GXeUcUq6VrFBDCpEcTTe6R0nKJPRClqGWo8Ek
 dGnj17UuT/sOgxBuF35+Jb24iV/Rv9p5nUDifO56HuCd6GvCO3qNW52iZ
 k+eTHNLG8MYDfyPH1CN55cZv55PYI4BGuyOKhdOQkU00m1lajJ0BhG3G9 g==;
X-CSE-ConnectionGUID: kBBLYQpuSMy4kFsXOx259g==
X-CSE-MsgGUID: FCl89dMdQPWAy7HDGFBU2g==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331845"
X-MGA-submission: =?us-ascii?q?MDG8kUYEK5jbB2TkgYNF2zots/lMNnKzH0AZN0?=
 =?us-ascii?q?3Q/Hu1SaiXLoyJWSFuZEhN6rnXL2MaKp0YGo0jgmxKZyroEKv3vba2gc?=
 =?us-ascii?q?JrfTGu2l8tAndy55jUxGjo3rCafJb12+nf+7iFo9r4gq6z1Ra66n381g?=
 =?us-ascii?q?hVCRsh8kVulvYfvk6QYnT5SQ=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:48 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNNXoWFJIfDOjiYzSErc/vrt83oS6oLHWywYOajdtW4E7nVX49QxE5+423K4ehO8WSmdO5O/rp9PLcwNAPMpYMUv/HqcM/fNjtRaDrJ3xZsoTS6bR52YAG7DDgVT/ZGXP+PU8pumI8WG65tiU3yFXOvtsIat7XleV+MchqHupiR8d6yP4nf/zdNRNmghL4DTwZ3TrAAANQY6KXYMq6ALcd8XQ4mw32k+Q+/zwGF88cLmC1NY+MmWJ5rM7B9yRcaPFb7KDTYb4DADIAn31nJkEohV4sL3nqDzQukcus7qTVFyjNv6frdU35KCV96ajPBBh8s74R2bvnzYCgAEu5NGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EcOu+TOcfbfDadm1pZd77Y5A6tl5Nr6dRcZJCVh2AY=;
 b=j9FgwrZlY//mpkjt2n2P4EKGhakujCyWvDy1WsCdWOP97HYo0Z4deJnFUZjlMPsU5TW5s5btFy85j7GaWrGWmIDD5t5jKGW4WtLSsiUeHtPhefUHCwGA/XwdM7AJHr/WOXLi5DcvxdydGYBQ8no7gEvwj6RMTxb75KRNUE7BB1nHs7BiHmk2b4D7i8/+nbaHqZhH6Kktm78jhMMVaCaJmvEw75U7pW9IlTqZPIXHZ8Xuj76VtJ63RmI24TQenRx7ijZhx3hepN9sScKumMxVSxT/4lijk7Wl9oH4olfL2ep9UfWZC74CN+EDM/Qmx9C3d6KZ3x6w+pjTxJMrc38FKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EcOu+TOcfbfDadm1pZd77Y5A6tl5Nr6dRcZJCVh2AY=;
 b=Qz06hx1/bAUqL/qOezbjEj7bbwQdjobMUmlEcBCKGCupUvmUxpzKMqINH4m2UQNB7gML4uPJqvT8KoFBpOIBbSwU7PRh7a1RZRD7XsnjzFehB6TIc1Ygy3hzCBJy2YMCIkv9kSFeVVMMvfUXg9g8oUROBgMDr6xmcO2PrK/QBVYVOwyEdbcXNxalmssfOapnhWJ4JIy9ZZHDvIClsizihYMqwpHjZlAzkqAYsJz7Xjx5pNuUtlIwB8TxzOHkEOH2W9zi2kPQnZyHwi0CtsdU7du82xoDxbSVDl4TWdQLkrJGofB0w+LjBzXnBk71wS4Qwl3zp6MY7y9xx1m9O+pDAA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9097.eurprd07.prod.outlook.com (2603:10a6:20b:558::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:46 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:46 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 12/19] pci: Add a pci-level initialization function for
 iommu notifiers
Thread-Topic: [PATCH v4 12/19] pci: Add a pci-level initialization function
 for iommu notifiers
Thread-Index: AQHbiQYDp5Ri8/0j4Uey1wj09Ce2TQ==
Date: Thu, 27 Feb 2025 10:54:45 +0000
Message-ID: <20250227105339.388598-13-clement.mathieu--drif@eviden.com>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS2PR07MB9097:EE_
x-ms-office365-filtering-correlation-id: cf5a4072-52af-40f8-eb9a-08dd571d2670
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/gGQXpcct+t1VmjW7GNgesqZHb5TLk2xKEEIfOHi27J0512GONeO1RAot+?=
 =?iso-8859-1?Q?AuG62abB47dgwgzixD/QfHijTOiScLmWEfjn3YubBbvLCXxmMlitrQYFr8?=
 =?iso-8859-1?Q?z3h2LDWhR4gvz7cu/8UVDeTwZAY+Bvo08DfCRyCN20h9XLe40Gx8tMwL5Y?=
 =?iso-8859-1?Q?JkUC2KnFLT7Y3mwXG17ImAPEQWPy8F3+UoFAGfObwiRKiMtOP+yzfMBdw2?=
 =?iso-8859-1?Q?CtW8NQsXlY0XUC6uTocrH41S95H34McfjBVeWiTDnTAfVAeCQ2CcrTfpHF?=
 =?iso-8859-1?Q?Q/u8RMCGGvfo5zzGJSKF2GSoRxfhXV2c4xcZ5z97eYtGC/JrTmBnG2rTl8?=
 =?iso-8859-1?Q?jwFk4poGJXGKXj4ZES0Dv7+08B6RjTQ3W0uQ758vYWnm9LRJ5/oT3Jtl3/?=
 =?iso-8859-1?Q?C1CJnwgQe/QX0hRkx6QIxexCKpDJN1N8wZY+TY2Zh9hZkd1BewHZaqAmGw?=
 =?iso-8859-1?Q?ATt0Ni6KAxYZ6gb2+jhK5pXys4BuLYAem5T2RtYv9cOYxzCpDWZIY88006?=
 =?iso-8859-1?Q?UJeRQHJWmwZHixHGSBtcathIfnLW54vNyqbyQhlZuXPHJ+M9t2F59U+3y+?=
 =?iso-8859-1?Q?zsGAncukxuv6/2nBstedsw3IAWu9xmOSe67gAb+iDikBVZDKviZn9qASou?=
 =?iso-8859-1?Q?LZ1Ta2eMC6xnDRJryj1xrVoUsZRItP26+r6NjuwS9t5WCVn1WUpuI2G2ek?=
 =?iso-8859-1?Q?fsmXRHxGQHLZB847k9Os5E/dfHLISxGR/HdTPNA+cRcYQ94SokzcuGg+iJ?=
 =?iso-8859-1?Q?Md3G1Cjhot9dL0Eup0gwkcBTcVchrwwBTGgXHubfjJsfFPYI/4c+ACPfVA?=
 =?iso-8859-1?Q?5qsj+1mCTfSb2QlJfcMPaTSZxlPbNKz0h48lo4wL6XqpxuVrNiAnTgO6u5?=
 =?iso-8859-1?Q?NCU4MUh6OOmXKMTCTuDGsb7B+vdYEFve4CPo8yW/hpJZu2Qj0sQr8GuBpt?=
 =?iso-8859-1?Q?JT3NtPcCCFASTp/uOGmXk86oR2ZK8SNkVOWTj9qnBgvxVpqKZA7EvOxqgn?=
 =?iso-8859-1?Q?BFDuoHq8VzqbWeagTH5Zb4WOP10AYBvK1to9JqxnPRUdVniWER90e2dqxJ?=
 =?iso-8859-1?Q?lPDkDcwvgX2+E4D/Bf3u5gRhBYwf6DaOgD0ayAtMsnZUUMwNLUv4b8QmTV?=
 =?iso-8859-1?Q?O1UnYBTgjDMYu4JSun7qOL9BnQAAX1v14Km30xn6bmbJWnk2bIVKogBamz?=
 =?iso-8859-1?Q?VUHOSROLvXXDGgwXKpzaYmtffD+gNS5BbEqbN7wSs1BiIvL95hNg2eGrVk?=
 =?iso-8859-1?Q?baoL6SCKCXAD8yw3smvyqK8nQZwDRTbbxhGTsPEHoScqVQOhk/xu2H4k8W?=
 =?iso-8859-1?Q?4FHRbN1cwLSlea96MMulHuOsEI/2J0fMV7M//XnajbOPxDkDW5I6x4EwnE?=
 =?iso-8859-1?Q?rgCcph48V3cAoblxgrGl/rQYc/+B3/ukaEu/pOePtyt6I7jy3JZBqTPQ8H?=
 =?iso-8859-1?Q?ZD6DWHJeRb7VnGwfkU0zd/kYU2euu0pfpEK/3wA4n2yrCkRE46HJ0wJ+Eo?=
 =?iso-8859-1?Q?2BjJuOqdkSj1a10fOt7+M9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PVeldNkfW+QpQ7Eps+i4MQ1X0UCl/upZMLEQ6ikh9oLwH/YpwbTc9mt7/d?=
 =?iso-8859-1?Q?Ckle4iljdvgZfeydKB1fvZrOOGeHojwwoH4qO8RpnPZ/vJmNSkITwyqlcs?=
 =?iso-8859-1?Q?gfokZPV3zHNxilApD7Q4zrAuBIsqBx7k26lp/0nSFlQcPxmWfidxGapXbp?=
 =?iso-8859-1?Q?yaNkWK1pBpv1kEecjiPl7k7iZJSWcaBZF8QNXkfnnat8IUB/5hMRij4a6A?=
 =?iso-8859-1?Q?rgasLq8YORzNb/pHYJ2lnMkfPq0crIpE7LJ8Xy0yNYgDXBE6ieAUEGXeI1?=
 =?iso-8859-1?Q?pWQp/6GhFyZQqruPOscjN6pKZuH2h+P5OrP+0P8Z2wt56xv6eqfPusYSE7?=
 =?iso-8859-1?Q?UMYcS48hf+AI2EgRK5ExiZT6yFtwsf6mDfYVNYtrevMxQFeOCLjhhShXcG?=
 =?iso-8859-1?Q?+Q3wCvihfUIq8B2oUJ9thz8q3bNrHmfiaKoqT47S9YqOfyDwO0Y0myg1Nc?=
 =?iso-8859-1?Q?3sVVhWX7XMYTWfUEtKC78UgkCXcsvqJEdoohK4mkcaaAnCVOT1JECJ/xoi?=
 =?iso-8859-1?Q?r5AslRRzIS9+hduWsEM/Vj42GCqXAwwdlFvbBm8zEzq4pNec5FOKVerjii?=
 =?iso-8859-1?Q?JD33PSppFGduQLcbxv4PFUFSJ6yVOXmeuFSM1AEjPo2fnz5JuL7/JOZrac?=
 =?iso-8859-1?Q?sjCh1D8fpwL97Rwfm4bs5NWJQGXhUUDkctopm/EIRx9naozgKlPvv98GBO?=
 =?iso-8859-1?Q?lyii0B2YEN4PstFa9diJrss2w4eXaD0e/9dYucuBTUtNzsB7Lg/j5LHnKl?=
 =?iso-8859-1?Q?awouFNLVGrAdy0lhXiaWqsNgls8zaYzieXoAQ9qRy8qyzvs7htex4iYNGr?=
 =?iso-8859-1?Q?yauGMY5vVut7o2W+q4hO3EeGkcmjHoY8gqN2IVsG26rJQHYpQ/TkN3R8qp?=
 =?iso-8859-1?Q?sI+g/G8TGpCWHSxsA4u/qOHuyxAPs3e3Cu6RE8OlPLdNi68MW2kWN+MHVv?=
 =?iso-8859-1?Q?WhE/ina12sf+ztzukdjYC1aWRql4Sjet3DzQoq3Z1mY94yBXExvrX7xqYO?=
 =?iso-8859-1?Q?Wu3Ldvb+FjhFkfNAn+0XVHnP5ok+ctpTVBiK3GCeLOch86R3M6vjedU0af?=
 =?iso-8859-1?Q?/cdSE5XXiYCZhiZS0vM5fYW5+IYlodzCc+Ao45H7Oo0ELYe1qVcrm+npDy?=
 =?iso-8859-1?Q?pp28DGwG5XZl6vgewmyQKcV/9oyZQxo7JRN7JO2U4rualDQVUDRFQyGaZ3?=
 =?iso-8859-1?Q?6wW/BWbUhl3//VtI6goKFr9NY+PUaRGAEoxjXud/uxr61KdxCxO9BkYdqx?=
 =?iso-8859-1?Q?GXdMAvJSAnMrZSrHwMETEBpkjDmItpAwQ3tTYnwInAvs54f6MB3wVGPzgn?=
 =?iso-8859-1?Q?jDeLte6/jWFRBOdLFSanPWrZ1W9aeoMYTTjhI2jHhtuC6GakAH7PnG+pu6?=
 =?iso-8859-1?Q?4G2IYdBrzYk0AGwlGM8M+XeX4wOhwBftWqakNqbRQBc0vIYz+MeNugSGBe?=
 =?iso-8859-1?Q?3r4cZLSKn5puZGamz/INgcOTb6o2ke/VZ+zhuCuhBRFE/GPDItm2o7SZB5?=
 =?iso-8859-1?Q?RCOA8v7dMvB5Qeaj/1+72JoUPgUn33Bm8GZOujdONKrNXzCy5C1YZRlBz1?=
 =?iso-8859-1?Q?DHvuu+qsKcBckcLbJyoC0h3gEMPufMqtt6iLf921nYBGa50HYf+66LNMcr?=
 =?iso-8859-1?Q?zF4VEbZDN3kfS9GzSYVLwkzVF0T7exyJvCfbLIxNbSVUpOfaF4Erp21Wcf?=
 =?iso-8859-1?Q?bRpD3rA0Hl/Zb6jQxBE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5a4072-52af-40f8-eb9a-08dd571d2670
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:45.9890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcBh7ORwigPRDEdNeW1PGa0ViPlZLSNn8YxLS7yaB7kK+Uc1uHcbQIlTA0/B6qT+ZyCyx4vypH+xRUCwE3TlJxwhBkAe7o0/85UlSvKA+mZhBdXogvbVN/V4z6N6cX8K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9097
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

We add a convenient way to initialize an device-iotlb notifier.
This is meant to be used by ATS-capable devices.

pci_device_iommu_memory_region_pasid is introduces in this commit and
will be used in several other SVM-related functions exposed in
the PCI API.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h | 15 +++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 164bb22e05..be29c0375f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2825,6 +2825,46 @@ AddressSpace *pci_device_iommu_address_space(PCIDevi=
ce *dev)
     return &address_space_memory;
 }
=20
+static IOMMUMemoryRegion *pci_device_iommu_memory_region_pasid(PCIDevice *=
dev,
+                                                               uint32_t pa=
sid)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    /*
+     * This function is for internal use in the module,
+     * we can call it with PCI_NO_PASID
+     */
+    if (!dev->is_master ||
+            ((pasid !=3D PCI_NO_PASID) && !pcie_pasid_enabled(dev))) {
+        return NULL;
+    }
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->get_memory_region_pasid) {
+        return iommu_bus->iommu_ops->get_memory_region_pasid(bus,
+                                 iommu_bus->iommu_opaque, devfn, pasid);
+    }
+    return NULL;
+}
+
+bool pci_iommu_init_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                   IOMMUNotifier *n, IOMMUNotify fn,
+                                   void *opaque)
+{
+    IOMMUMemoryRegion *iommu_mr =3D pci_device_iommu_memory_region_pasid(d=
ev,
+                                                                        pa=
sid);
+    if (!iommu_mr) {
+        return false;
+    }
+    iommu_notifier_init(n, fn, IOMMU_NOTIFIER_DEVIOTLB_EVENTS, 0, HWADDR_M=
AX,
+                        memory_region_iommu_attrs_to_index(iommu_mr,
+                                                       MEMTXATTRS_UNSPECIF=
IED));
+    n->opaque =3D opaque;
+    return true;
+}
+
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp)
 {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 644551550b..a11366e08d 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -446,6 +446,21 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostI=
OMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
=20
+/**
+ * pci_iommu_init_iotlb_notifier: initialize an IOMMU notifier
+ *
+ * This function is used by devices before registering an IOTLB notifier
+ *
+ * @dev: the device
+ * @pasid: the pasid of the address space to watch
+ * @n: the notifier to initialize
+ * @fn: the callback to be installed
+ * @opaque: user pointer that can be used to store a state
+ */
+bool pci_iommu_init_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                   IOMMUNotifier *n, IOMMUNotify fn,
+                                   void *opaque);
+
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
  *
--=20
2.48.1

