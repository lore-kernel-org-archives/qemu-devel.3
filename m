Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9F3CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKtbd-00026L-UL; Thu, 07 May 2026 03:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wKtbb-00025n-K1
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:57:11 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wKtbY-0002qC-FV
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1778140628; x=1809676628;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XpBohnk3c8soJjMqX0li/aJxCIDTpEq1jVxvcfxhy50=;
 b=tGSHOwnqASXyQVf1LAZATn4m2f14UPYFBZbbVLtsJIIhzizcZfQmUB68
 F3lbWRdohCMkSq7S3leBSfhdUfkfM0DSvBM40Q9upo0A8FbKo8Ux+oOLX
 XCNnLqxz029+Q1LcXM++mqQPGr7bRpAVnCNQslD8t4j1JxLideBW1lxWH
 rLKJvmSpBki0J5BTG8o6t56nY7bI9eKKnaS/c9z2ezA4UgGe/rgwk/6GY
 RTIcmbnBmC8LmhWDbWb/dTtZcbxSQP/4WNigUsbcd2h0UrW6jwP4mxFCy
 iHFEHk0NRs+U4gkpaCgFhLNS1bN4vLIUdq3m5vqZYiQPrMIxdBdKkFUrM g==;
X-CSE-ConnectionGUID: c3E47P91Q1a66bBwWnfnbg==
X-CSE-MsgGUID: WcKWTi45Rlat72g8NxNqqg==
IronPort-SDR: 69fc45cf_/PJmrGMkHMccQW76uq32cmKJ1DNjHn8CXwVjjKlrAZtbaCr
 1ZrSY14ZejDiT8lKxGJtwrH+1Mwy9BPExOspFNA==
X-IronPort-AV: E=Sophos;i="6.23,221,1770591600"; d="scan'208";a="47905729"
X-MGA-submission: =?us-ascii?q?MDGkBc9eTcgyjJqQMkdZJ0dv/NYmS4xPYc77aA?=
 =?us-ascii?q?ii2uL7CW6fONE754xkOCN25MQyqH+zxL3jVnRP4VJCQaVxm2jgc2+Krf?=
 =?us-ascii?q?3sZZ11pBobdukfTB4ZTQx+gw7BO928WQoiYYmJ+FO1ZgMuu+A4ojm+fk?=
 =?us-ascii?q?yyI5XczHz7fA1+2awPsOEqnQ=3D=3D?=
Received: from mail-francesouthazon11011033.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.33])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 07 May 2026 09:57:02 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXHmaiaeZMpg/wTQ9b/Mpl2nyuJCa1OSRV70g1tHgCcMALMR285H9udy5kNZs1INGeR2CCUEOdE5PgzGGBs4ymUszzSI46ztD69zDsqgJb7U4Oovrnc37MeD+++Wu5NOvZdgmJ2VzexdcX8j8WTa+z+n08zR3TbGiFr5wycw9ICpPt/CzCrjXN3yvmyYD60UmurJApEDH8okx7ubx/GDkwRi0KprgEGcyv6xBA7uWkh/gg8agu/+N6kGvSaG2mXn0/zmwyl3PQICnCvTc6RZvjJcp/7jXnBwwp/gHRHgmpbv3F07zm2waMEooQNnjMY0F43yY4XVUGoE2VMz6KB0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpBohnk3c8soJjMqX0li/aJxCIDTpEq1jVxvcfxhy50=;
 b=oWJiovpY6W675sitkrALr4QXoAuGmqtRu43rilukmguaIB8Rjg9V+b9FCx18s9Tr1Nle/z/J5Suln5NQQuX+ARuMpwmom3cqTbMRJzVF7qT+Zr1Z0ar3YwNAMr1oGvLYYF16lgKR+RCxi2CNCj2sydBLooJ7JpRE++GT+nYymouhMTXfQRLZdssafMlFsZL1/ttZJa+24spMHknU8NHSqnwIh8AKB8uvC0TpVHhuehHE7bNYqAJX0dldCcK/im1Yd68xc1tRb0JCVoiCUbARq1kKGDP5d1KYCkyAEB9Qpo+IEkx/zrWhdDO2wnA+PObk0N/DKLm09Tyqh+9goWiO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM0PR07MB6419.eurprd07.prod.outlook.com (2603:10a6:20b:144::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 07:57:00 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 07:56:59 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Topic: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Index: AQHc2HDw15Tr3wTsJk+meiMDmTyHcbYCPRQA
Date: Thu, 7 May 2026 07:56:59 +0000
Message-ID: <66b8667d439df5f17a760870eaa7ddd56cea786f.camel@bull.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-9-zhenzhong.duan@intel.com>
In-Reply-To: <20260430071315.354333-9-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM0PR07MB6419:EE_
x-ms-office365-filtering-correlation-id: 044392c6-6dbf-4d32-2748-08deac0e37c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 1IJ/OqxKA+LBp6VyFI2Tkn0/Mgyxlc9oqvbWWa2S7mgcSa73x+AZBjJBMc2EJHUDHUVbdHjEeAHl9KCOiSZ+eDKWEQ9bsxS8j9wjNURUmmxlwgeqL0Jxaw7jwubZcJSYMap5y70UCs38hX6z9eTj0/hA08XUZIGR8ROtuRBtv8eTVYMuq0tyNYhO5x5L691U+7E0PZzC4lZPxha9vbnr1vxywiSG/5JDnDI5ZyH4h8/IMnk/Q/aNQlcvgIfknaxkzI4+PaD8uz7PbUYNa4kPQAhu36/Uc6ZRM3CGKmBEI7sqI+fUYP4L42msXosJgSD/MeSygsZM+LAlrWm2FrR2PuAvYIdquAOsZ4nexjexxbkqafKY1nHL6x77r6CwhOcZrZNOB14IK25aomXtyIjc0L/p8IPFto+WLa+af0R20TZpMs8LO5cliwtHTNYq/Jl4WZLU0AT6wUDChvi5nUy8LPQoQ/dLhIeiQGY5+uv/Yxl5sm9BGYelybLfRitJf9PmYekaB8UKcZUFlks3NSdprFtOwU5FNoWLHjWy4DoCsEf9IrjVnYt4fy2B4d9FScr2opqzBnKAnjX8DS3ZBnNSJj/l04tAYRoaTEhgxT6Czb31NcsGQEmT1/WkxK0ioMhP9l6L8DbSdjfWc92K4WxAXrsFjzF6gBDi14APtJR90ONi75bmAF1rvbkvSHpNmzHaFKoBaxiB/CowcC4ZYiPw4pM7bknd/zeG7c4DcCEapXG6vZIRDD+h68JaITGmGRQC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWNadXkvQzFaZFBkZG5uYk5iM2xFRnVvK2hHSnFWcm5FWjVtdkdsSit3blVN?=
 =?utf-8?B?aVNOYkEwR2x3RjRjclN5MzN6RTJWYWh0bnlKWEx4SHNGYlhyWTZ4cGp0SFFB?=
 =?utf-8?B?RW50QjdYTjlZQlN0MWppemFTQmMzanJFNFlQbFd1bDQ1VnA5R2xUdEtIbHlx?=
 =?utf-8?B?WGJBcmZmUDRMd0I1cW4rSVpyeDlHdjJnaEJYM0VDVExjSTJBcTAwY3p3b0JB?=
 =?utf-8?B?dER4WGZ1cGxkczJhU3hIa2lGNjBTTmZSbXNDMTF1a0dFVjFyZXNCeFZpWlkw?=
 =?utf-8?B?MkF2ekNBMlhzM3JuVkRLT1hYc085R0pxYVRIazcrOUdMbTR0VUNxaFlKelB3?=
 =?utf-8?B?RlVYUS82bjZUTWFYV21MbjZNMDAvY01MSUJ2SnAwVU9jRTVnQVhSQWFjVHBr?=
 =?utf-8?B?MEIzLzJxSGFqTlZkYUlXU2Y1TmRpRmMrdlB5eFhWK1EyaXdlSEpzd1VvYTdI?=
 =?utf-8?B?TndWbm9JSlBVY0w3SUlHdFdCZDU4dmNTOC8wQWoxNGx0VTV4azBDV0NLenZZ?=
 =?utf-8?B?YlFBYUVvSWtncTNhNnVnZEFRbjFTaTVCSWRIZFBjNnhGaVZLQUduNWJkdFJi?=
 =?utf-8?B?T2I2b1lKWXlZVTdxMkgrRlIwZjNycXAxTVpnWXEyYWJvSHVuQzRRbGU2V2gz?=
 =?utf-8?B?dllzcmprR0M2QkFYWWsxWFJkOE4xSHdaSVlFMGYxb1I3Kyt3U2d0VGtXVUEv?=
 =?utf-8?B?MnhLL2lvR1A2M21qMXc2ZlBCL2hYcWhNWVF3L2FwaXR3V0dkNWtwWWRpekRu?=
 =?utf-8?B?MUFDS3FoK2dmcXFwRmpsQXUrZW9lRU1KTFo0dzIwcVlXNmlEeFhVTWdjdjRC?=
 =?utf-8?B?cW1YMzN5ZlVNQzNXY1VsR0RQV3dqd1h1MFAwOWQzR2R2akxyNTBZeHZGeWJp?=
 =?utf-8?B?ZnVnRy9xb0Y3RTlqNUgxMGdVZC9GbmErdnR6aHorSjhOY2tOZFhzQkVNLys2?=
 =?utf-8?B?RDEra2ZOTUhqcDE2cmpIaHk4RGRXOVZENGcrUzdMYlFncDBqQUR5ak1HbW5h?=
 =?utf-8?B?a3RrZU1kVnBwWnJnYUZhL3JIZy94MzcrRVZya1RHK1VXT0xtMlhJUkZ4ZzBv?=
 =?utf-8?B?dTJHZi9UQi9uOWlDbC8vUGlHSG94TnJjY0JXbWR2SWFTTm9NZlVBTGhsZVZa?=
 =?utf-8?B?cUpSVERjbDFYWk1KOHYyWEI1MldNMlNFalFmN09aUHVLQktEUnI1Sndwc0VH?=
 =?utf-8?B?RUQ5ZnpHaHlmaVcvb3FQTG5DSE9qc3BvUEFrK3BPUW11MFRQbThaU0JhL0lu?=
 =?utf-8?B?RnFXMXROUmVnWWErMUtpeFh1UzdXZXFIQi82eThXNzJXd3dSNWRERzVVSzEw?=
 =?utf-8?B?a1h4NW90MW1Mb3NzNWovNm9hd285SVpCTGxUZ0JERTR5Z1daeWtzb3NOTXBX?=
 =?utf-8?B?K3lZcHdUY24xOVV0Y2xqL01VSGhTRXFBbWNsZmhWOGpxZklpYUhoQTNRVWFt?=
 =?utf-8?B?MHV4c3RqWlZLQUlhWHZicm5PZ1JlVVhJSjlielVRcFQ5SjJmcVBzczczV0Jo?=
 =?utf-8?B?cmpud1p4T01VZ1V5ZVR2UkEyZ1lCWEdidlNhTTUyQTIxQk5GMkVFQkN3My9n?=
 =?utf-8?B?YVRCbU85Z05IRE1OTGFjV2U3NDVpNHp1YnFOZTVUcjdPT3UwNkc3YmFpaUxL?=
 =?utf-8?B?VkZSQzFtUlhWTDhNZVBaelR0SmtoSmhVZFlsOVJYWFhJN3ZtTFh4R3pEbHZP?=
 =?utf-8?B?RXloQ0VvSXZNUWFKemUzY3VaYkZha2VTWFFybTFJV0dSQmV6ZnZlQ1V1c2o3?=
 =?utf-8?B?N2pQbFZvY3pTWDdPcHh0S2RocWo2ZXRKRWNYYXN6dm82Y0s2b2hjaE1ldG1s?=
 =?utf-8?B?S1Y3NFpuMlFaY2RXUDM3T045VHpBbEMvZ3BtcWhPSTNrQ2hTUE9qdndEN1lG?=
 =?utf-8?B?ZDMzUmEyNGl3ZmpCYmp5S292YnlSVGpseWxpeURRdGpEK1Iwc3ZmWjVzS1RF?=
 =?utf-8?B?cVJTKy9UT2RJa3oxWm5wYTlrcDM5bEM4Y1hTQnJ5cFpOeVpUamNmdTZyNVIw?=
 =?utf-8?B?K0UwVlFMVllsa2o4WDVaVllNS1hmNkM0eTdCZDJVcXdpSWRpWkw3RHhkbUlN?=
 =?utf-8?B?dGFBWS82WnFjUUxqLzdNU05ja0IwV3hKSTQ5blMzckszTWl0cVF3STBDU3hF?=
 =?utf-8?B?THV5c2dnZHBzUGN3QVhHKytOTitncXB3UU1WRTI2MDlSMDM2SE94dDVwbjBr?=
 =?utf-8?B?S3BlSGV5Z2ppdi9SbGZYbzVaY2I4dVdRc1E5VjB4L21FRkpIYkVIa00zS2RN?=
 =?utf-8?B?aFFtMVRlV2tvcTNaWUV0YzFBQnBtL2ZWZnZUbmZwWjlodkY5d0VXb0I4MDVZ?=
 =?utf-8?B?RnFxYW1qTE9JN0tOVUMxZ09Wa3lFMzk4UENDeHpCRkxPS0pwbnJESTQ3VTho?=
 =?utf-8?Q?UD5Y9N69PtfLF8Qg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CFA4FBCC1E93543864B4696384298A7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aPQGkSDPnyVQYaA0OVFPSIaCH4X9CmXyNVYxfTxEjByBUu9ixeugg3cjUzV+OWw1uevk7EViFwQjpJkb8fADX8TYyMwY8qvevn9xnGFXLXGTmpXboId9CB2uJTIJaM5JVqLUH85RRiZ/osTUNSRaoo1rBlHmBjatHsPBh70xYmoA1AiqOuLtU4jpMPQoZKIsDynKTkMh2m2JZ2Lisy8erJqzkeaMwJxjn5YpH6jKGk99nbiFk4SsdlaZIT5HZSdmhR75PaNQb9NsmY0UBs5ugoxT6JB1YjWNfzwNaUvFYal457vFLLX62+tbfqHRWZSh977NraKAtSVlIzrqU0OTlA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044392c6-6dbf-4d32-2748-08deac0e37c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 07:56:59.8150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxIzgI1axS0QBpfgiEsOI7oNkUufhL8EWGCDKT4S0DM67GcYZmu37BL7oFtDMAAjHWVJhHUapx9KlDHajBfMdGlwsEiZmu39/Gy6BIQLgfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6419
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

TWF5YmUgd2Ugc2hvdWxkIHVwZGF0ZSB0aGlzIGFzIHdlbGw6DQoNCmBgYA0KICAgICAgICBwY19p
bmZvLnBhc2lkID0gcGFzaWQgPzogUENJX05PX1BBU0lEOw0KYGBgDQoNCk90aGVyIHF1ZXN0aW9u
OiBpcyB0aGlzIGNvcnJlY3Q/DQoNCmBgYA0KICAgICAgICBwYXNpZCA9IFZURF9JTlZfREVTQ19Q
QVNJRF9ERVZJQ0VfSU9UTEJfUEFTSUQoaW52X2Rlc2MtPmxvKTsNCiAgICAgICAgdnRkX2Rldl9h
cyA9IHZ0ZF9nZXRfYXNfYnlfc2lkX2FuZF9wYXNpZChzLCBzaWQsIHBhc2lkKTsNCmBgYA0KDQpj
bWQNCg0KT24gVGh1LCAyMDI2LTA0LTMwIGF0IDAzOjEzIC0wNDAwLCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4gSW4gcHJldmlvdXMgcGF0Y2ggd2UgaW50cm9kdWNlZCBhIGdsb2JhbCBtYWNybyBJ
T01NVV9OT19QQVNJRCgwKSBmb3IgIA0KPiBSZXF1ZXN0cy13aXRob3V0LVBBU0lELCB0aGlzIG1h
a2VzIHRoZSBsb2NhbCBtYWNybyBQQVNJRF8wIHJlZHVuZGFudC4gIA0KPiBEZWxldGUgaXQgYW5k
IHVzZSBJT01NVV9OT19QQVNJRCBpbnN0ZWFkLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBZaSBMaXUg
PFt5aS5sLmxpdUBpbnRlbC5jb21dKG1haWx0bzp5aS5sLmxpdUBpbnRlbC5jb20pPiAgDQo+IFNp
Z25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDxbemhlbnpob25nLmR1YW5AaW50ZWwuY29tXSht
YWlsdG86emhlbnpob25nLmR1YW5AaW50ZWwuY29tKT4gIA0KPiBUZXN0ZWQtYnk6IFh1ZG9uZyBI
YW8gPFt4dWRvbmcuaGFvQGludGVsLmNvbV0obWFpbHRvOnh1ZG9uZy5oYW9AaW50ZWwuY29tKT4g
IA0KPiAtLS0gIA0KPiDCoGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8wqAgMSAtICAN
Cj4gwqBody9pMzg2L2ludGVsX2lvbW11LmPCoMKgwqDCoMKgwqDCoMKgwqAgfCAyMSArKysrKysr
KysrKy0tLS0tLS0tLS0gIA0KPiDCoGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuY8KgwqDCoCB8
wqAgMiArLSAgDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggIA0KPiBpbmRleCBjN2UxMDdmZTg3
Li4wMTQxMzE2ZjgzIDEwMDY0NCAgDQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaCAgDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCAgDQo+IEBAIC02
MTUsNyArNjE1LDYgQEAgdHlwZWRlZiBzdHJ1Y3QgVlREUm9vdEVudHJ5IFZURFJvb3RFbnRyeTsg
IA0KPiDCoCNkZWZpbmUgVlREX0NUWF9FTlRSWV9MRUdBQ1lfU0laRcKgwqDCoMKgIDE2ICANCj4g
wqAjZGVmaW5lIFZURF9DVFhfRU5UUllfU0NBTEFCTEVfU0laRcKgwqAgMzIgIA0KPiDCoCAgDQo+
IC0jZGVmaW5lIFBBU0lEXzDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAwICANCj4gwqAjZGVmaW5lIFZURF9TTV9DT05URVhUX0VOVFJZX1JT
VkRfVkFMMChhdynCoCAoMHgxZTBVTEwgfCB+VlREX0hBV19NQVNLKGF3KSkgIA0KPiDCoCNkZWZp
bmUgVlREX1NNX0NPTlRFWFRfRU5UUllfUlNWRF9WQUwxwqDCoMKgwqDCoCAweGZmZmZmZmZmZmZl
MDAwMDBVTEwgIA0KPiDCoCNkZWZpbmUgVlREX1NNX0NPTlRFWFRfRU5UUllfUFJFwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAweDEwVUxMICANCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9t
bXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYyAgDQo+IGluZGV4IDc0NjQyZDgxMjMuLjRkMWIy
NjJkNTYgMTAwNjQ0ICANCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jICANCj4gKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jICANCj4gQEAgLTEwMCw3ICsxMDAsOCBAQCBzdGF0aWMgdm9p
ZCB2dGRfcGFzaWRfY2FjaGVfcmVzZXRfbG9ja2VkKEludGVsSU9NTVVTdGF0ZSAqcykgIA0KPiDC
oCAqICANCj4gwqAgKiBSZXF1ZXN0cy13aXRob3V0LVBBU0lEOiAgDQo+IMKgICrCoMKgIC0gUENJ
IHN1YnN5c3RlbTogVXNlcyBQQ0lfTk9fUEFTSUQgKC0xKSB0byBpbmRpY2F0ZSBubyBQQVNJRCBw
cmVzZW50ICANCj4gLSAqwqDCoCAtIFZULWQgSU9NTVU6wqDCoMKgIFVzZXMgUEFTSURfMCAoMCkg
dG8gaW5kZXggdGhlIFBBU0lEIHRhYmxlIGZvciB0cmFuc2xhdGlvbiAgDQo+ICsgKsKgwqAgLSBW
VC1kIElPTU1VOsKgwqDCoCBVc2VzIElPTU1VX05PX1BBU0lEICgwKSB0byBpbmRleCB0aGUgUEFT
SUQgdGFibGUgZm9yICANCj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdHJhbnNsYXRpb24gIA0KPiDCoCAqICANCj4gwqAgKiBSZXF1ZXN0cy13aXRoLVBBU0lEOiAg
DQo+IMKgICrCoMKgIC0gQm90aCBzdWJzeXN0ZW1zIHVzZSBpZGVudGljYWwgUEFTSUQgdmFsdWVz
ICgxLTB4RkZGRkYpICANCj4gQEAgLTExNCw3ICsxMTUsNyBAQCBzdGF0aWMgdm9pZCB2dGRfcGFz
aWRfY2FjaGVfcmVzZXRfbG9ja2VkKEludGVsSU9NTVVTdGF0ZSAqcykgIA0KPiDCoCAqLyAgDQo+
IMKgc3RhdGljIHVpbnQzMl90IHZ0ZF9wYXNpZF90b19wY2lfcGFzaWQodWludDMyX3QgcGFzaWQp
ICANCj4gwqB7ICANCj4gLcKgwqDCoCBpZiAocGFzaWQgPT0gUEFTSURfMCkgeyAgDQo+ICvCoMKg
wqAgaWYgKHBhc2lkID09IElPTU1VX05PX1BBU0lEKSB7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCBw
YXNpZCA9IFBDSV9OT19QQVNJRDsgIA0KPiDCoMKgwqDCoCB9ICANCj4gwqDCoMKgwqAgcmV0dXJu
IHBhc2lkOyAgDQo+IEBAIC05NjksNyArOTcwLDcgQEAgaW50IHZ0ZF9jZV9nZXRfcGFzaWRfZW50
cnkoSW50ZWxJT01NVVN0YXRlICpzLCBWVERDb250ZXh0RW50cnkgKmNlLCAgDQo+IMKgwqDCoMKg
IGRtYV9hZGRyX3QgcGFzaWRfZGlyX2Jhc2U7ICANCj4gwqAgIA0KPiDCoMKgwqDCoCBpZiAocGFz
aWQgPT0gUENJX05PX1BBU0lEKSB7ICANCj4gLcKgwqDCoMKgwqDCoMKgIHBhc2lkID0gUEFTSURf
MDsgIA0KPiArwqDCoMKgwqDCoMKgwqAgcGFzaWQgPSBJT01NVV9OT19QQVNJRDsgIA0KPiDCoMKg
wqDCoCB9ICANCj4gwqDCoMKgwqAgcGFzaWRfZGlyX2Jhc2UgPSBWVERfQ0VfR0VUX1BBU0lEX0RJ
Ul9UQUJMRShjZSk7ICANCj4gwqDCoMKgwqAgcmV0dXJuIHZ0ZF9nZXRfcGVfZnJvbV9wYXNpZF90
YWJsZShzLCBwYXNpZF9kaXJfYmFzZSwgcGFzaWQsIHBlKTsgIA0KPiBAQCAtOTg2LDcgKzk4Nyw3
IEBAIHN0YXRpYyBpbnQgdnRkX2NlX2dldF9wYXNpZF9mcGQoSW50ZWxJT01NVVN0YXRlICpzLCAg
DQo+IMKgwqDCoMKgIFZURFBBU0lERW50cnkgcGU7ICANCj4gwqAgIA0KPiDCoMKgwqDCoCBpZiAo
cGFzaWQgPT0gUENJX05PX1BBU0lEKSB7ICANCj4gLcKgwqDCoMKgwqDCoMKgIHBhc2lkID0gUEFT
SURfMDsgIA0KPiArwqDCoMKgwqDCoMKgwqAgcGFzaWQgPSBJT01NVV9OT19QQVNJRDsgIA0KPiDC
oMKgwqDCoCB9ICANCj4gwqDCoMKgwqAgcGFzaWRfZGlyX2Jhc2UgPSBWVERfQ0VfR0VUX1BBU0lE
X0RJUl9UQUJMRShjZSk7ICANCj4gwqAgIA0KPiBAQCAtMTUyOSw5ICsxNTMwLDkgQEAgc3RhdGlj
IGludCB2dGRfY2VfcGFzaWRfMF9jaGVjayhJbnRlbElPTU1VU3RhdGUgKnMsIFZURENvbnRleHRF
bnRyeSAqY2UpICANCj4gwqAgIA0KPiDCoMKgwqDCoCAvKiAgDQo+IMKgwqDCoMKgwqAgKiBNYWtl
IHN1cmUgaW4gU2NhbGFibGUgTW9kZSwgYSBwcmVzZW50IGNvbnRleHQgZW50cnkgIA0KPiAtwqDC
oMKgwqAgKiBoYXMgdmFsaWQgcGFzaWQgZW50cnkgc2V0dGluZyBhdCBQQVNJRF8wLiAgDQo+ICvC
oMKgwqDCoCAqIGhhcyB2YWxpZCBwYXNpZCBlbnRyeSBzZXR0aW5nIGF0IElPTU1VX05PX1BBU0lE
LiAgDQo+IMKgwqDCoMKgwqAgKi8gIA0KPiAtwqDCoMKgIHJldHVybiB2dGRfY2VfZ2V0X3Bhc2lk
X2VudHJ5KHMsIGNlLCAmcGUsIFBBU0lEXzApOyAgDQo+ICvCoMKgwqAgcmV0dXJuIHZ0ZF9jZV9n
ZXRfcGFzaWRfZW50cnkocywgY2UsICZwZSwgSU9NTVVfTk9fUEFTSUQpOyAgDQo+IMKgfSAgDQo+
IMKgICANCj4gwqAvKiBNYXAgYSBkZXZpY2UgdG8gaXRzIGNvcnJlc3BvbmRpbmcgZG9tYWluIChj
b250ZXh0LWVudHJ5KSAqLyAgDQo+IEBAIC0xNTkyLDcgKzE1OTMsNyBAQCBpbnQgdnRkX2Rldl90
b19jb250ZXh0X2VudHJ5KEludGVsSU9NTVVTdGF0ZSAqcywgdWludDhfdCBidXNfbnVtLCAgDQo+
IMKgwqDCoMKgwqDCoMKgwqAgfSAgDQo+IMKgwqDCoMKgIH0gZWxzZSB7ICANCj4gwqDCoMKgwqDC
oMKgwqDCoCAvKiAgDQo+IC3CoMKgwqDCoMKgwqDCoMKgICogQ2hlY2sgaWYgdGhlIHByb2dyYW1t
aW5nIG9mIHBhc2lkIHNldHRpbmcgb2YgUEFTSURfMCAgDQo+ICvCoMKgwqDCoMKgwqDCoMKgICog
Q2hlY2sgaWYgdGhlIHByb2dyYW1taW5nIG9mIHBhc2lkIHNldHRpbmcgb2YgSU9NTVVfTk9fUEFT
SUQgIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpcyB2YWxpZCwgYW5kIHRodXMgYXZvaWRzIHRv
IGNoZWNrIHBhc2lkIGVudHJ5IGZldGNoaW5nICANCj4gwqDCoMKgwqDCoMKgwqDCoMKgICogcmVz
dWx0IGluIGZ1dHVyZSBoZWxwZXIgZnVuY3Rpb24gY2FsbGluZy4gIA0KPiDCoMKgwqDCoMKgwqDC
oMKgwqAgKi8gIA0KPiBAQCAtMjE1MCw3ICsyMTUxLDcgQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lv
bW11X3RyYW5zbGF0ZShWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsICANCj4g
wqDCoMKgwqAgdnRkX2lvbW11X2xvY2socyk7ICANCj4gwqAgIA0KPiDCoMKgwqDCoCBpZiAocGFz
aWQgPT0gUENJX05PX1BBU0lEICYmIHMtPnJvb3Rfc2NhbGFibGUpIHsgIA0KPiAtwqDCoMKgwqDC
oMKgwqAgcGFzaWQgPSBQQVNJRF8wOyAgDQo+ICvCoMKgwqDCoMKgwqDCoCBwYXNpZCA9IElPTU1V
X05PX1BBU0lEOyAgDQo+IMKgwqDCoMKgIH0gIA0KPiDCoCAgDQo+IMKgwqDCoMKgIC8qIFRyeSB0
byBmZXRjaCBwdGUgZnJvbSBJT1RMQiAqLyAgDQo+IEBAIC0yNTE1LDcgKzI1MTYsNyBAQCBzdGF0
aWMgdm9pZCB2dGRfaW90bGJfZG9tYWluX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLCB1
aW50MTZfdCBkb21haW5faWQpICANCj4gwqB9ICANCj4gwqAgIA0KPiDCoC8qICANCj4gLSAqIFRo
ZXJlIGlzIG5vIHBhc2lkIGZpZWxkIGluIGlvdGxiIGludmFsaWRhdGlvbiBkZXNjcmlwdG9yLCBz
byBQQVNJRF8wICANCj4gKyAqIFRoZXJlIGlzIG5vIHBhc2lkIGZpZWxkIGluIGlvdGxiIGludmFs
aWRhdGlvbiBkZXNjcmlwdG9yLCBzbyBJT01NVV9OT19QQVNJRCAgDQo+IMKgICogaXMgcGFzc2Vk
IGFzIHBhcmFtZXRlci4gUGlvdGxiIGludmFsaWRhdGlvbiBzdXBwb3J0cyBwYXNpZCwgcGFzaWQg
aW4gaXRzICANCj4gwqAgKiBkZXNjcmlwdG9yIGlzIHBhc3NlZC4gSW4gYm90aCBjYXNlcywgcGFz
aWQgaXMgY29udmVydGVkIHRvIFBDSSBwYXNpZCAgDQo+IMKgICogYmVmb3JlIGNoZWNraW5nIHdp
dGggdnRkX2FzLT5wYXNpZC4gIA0KPiBAQCAtMjU4Niw3ICsyNTg3LDcgQEAgc3RhdGljIHZvaWQg
dnRkX2lvdGxiX3BhZ2VfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IGRv
bWFpbl9pZCwgIA0KPiDCoMKgwqDCoCB2dGRfaW9tbXVfbG9jayhzKTsgIA0KPiDCoMKgwqDCoCBn
X2hhc2hfdGFibGVfZm9yZWFjaF9yZW1vdmUocy0+aW90bGIsIHZ0ZF9oYXNoX3JlbW92ZV9ieV9w
YWdlLCAmaW5mbyk7ICANCj4gwqDCoMKgwqAgdnRkX2lvbW11X3VubG9jayhzKTsgIA0KPiAtwqDC
oMKgIHZ0ZF9pb3RsYl9wYWdlX2ludmFsaWRhdGVfbm90aWZ5KHMsIGRvbWFpbl9pZCwgYWRkciwg
YW0sIFBBU0lEXzApOyAgDQo+ICvCoMKgwqAgdnRkX2lvdGxiX3BhZ2VfaW52YWxpZGF0ZV9ub3Rp
ZnkocywgZG9tYWluX2lkLCBhZGRyLCBhbSwgSU9NTVVfTk9fUEFTSUQpOyAgDQo+IMKgfSAgDQo+
IMKgICANCj4gwqAvKiBGbHVzaCBJT1RMQiAgDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVs
X2lvbW11X2FjY2VsLmMgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgIA0KPiBpbmRleCBi
ZDEyMzZjMDcwLi44OTQwZDI0MGExIDEwMDY0NCAgDQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9t
bXVfYWNjZWwuYyAgDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyAgDQo+IEBA
IC0yMTcsNyArMjE3LDcgQEAgc3RhdGljIHZvaWQgdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2xvY2tl
ZChncG9pbnRlciBrZXksIGdwb2ludGVyIHZhbHVlLCAgDQo+IMKgICANCj4gwqDCoMKgwqAgZGlk
ID0gVlREX1NNX1BBU0lEX0VOVFJZX0RJRCgmcGNfZW50cnktPnBhc2lkX2VudHJ5KTsgIA0KPiDC
oCAgDQo+IC3CoMKgwqAgaWYgKHBpb3RsYl9pbmZvLT5kb21haW5faWQgPT0gZGlkICYmIHBpb3Rs
Yl9pbmZvLT5wYXNpZCA9PSBQQVNJRF8wKSB7ICANCj4gK8KgwqDCoCBpZiAocGlvdGxiX2luZm8t
PmRvbWFpbl9pZCA9PSBkaWQgJiYgcGlvdGxiX2luZm8tPnBhc2lkID09IElPTU1VX05PX1BBU0lE
KSB7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCBIb3N0SU9NTVVEZXZpY2VJT01NVUZEICpoaW9kaSA9
ICANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQo
dnRkX2hpb2QtPmhpb2QpOyAgDQo+IMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgZW50cnlfbnVt
ID0gMTsgLyogT25seSBpbXBsZW1lbnQgb25lIHJlcXVlc3QgZm9yIHNpbXBsaWNpdHkgKi8=

