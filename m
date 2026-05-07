Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AFFCD3446
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 06:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKsYe-0000yi-42; Thu, 07 May 2026 02:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wKsYa-0000xi-Uc
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:50:00 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wKsYV-0006Bj-Tc
 for qemu-devel@nongnu.org; Thu, 07 May 2026 02:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1778136597; x=1809672597;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=oth0cDOrHpRfSAPiGcVF0N3UjOt6Wn8gAEruDTLzh/w=;
 b=BYjbX0vG/3bytmj1ll7o00yL60iWCtjN69E6S2XLI0H66rdYQykUHweM
 XZOrSC0QAG7LgFMwXKPyPW1w4MwieWc4QU27z9t9tZGkcgHrOzwhoHjp/
 a7uL4URqz6ZYGfXG+X4KXAK2NCMjfFtPKNPdkElHrhn68M0aElDxN/hMe
 q8MGFmznzxTW7ULbAbQ8H5QkunZIUhPGwzKNnWxgO2BbXhfJsW1EyGjNO
 n4SIJOsOcTVxcDMlhLbU9ircEnOxjL6BzSPEb0thYtqU/YZjZ71NcLr9L
 QxePJbfJFGIqbeBtFYSv5y9cEao1n3K3cIeT1jZ0lHgHi/lzE3ZVUgCwz g==;
X-CSE-ConnectionGUID: c2ikX2n0T1yljve9h6ihjA==
X-CSE-MsgGUID: cmSlvCznR+qIzlaQc5Vifg==
IronPort-SDR: 69fc3576_Ofj4maXAak7dVEGKjl9eP640bTHbIPqsIDIU2vUln2X/E8q
 n/Gl1i6aK2WySoHjXrPTZNPKe1cskz8We4wC04g==
X-IronPort-AV: E=Sophos;i="6.23,220,1770591600"; d="scan'208";a="47904339"
X-MGA-submission: =?us-ascii?q?MDEZ0hzf+TvTtTHvV5i3SO1X75XkC/ktDXlACd?=
 =?us-ascii?q?M8XE6Y0Tyuu+8/02TDDVSdf8UaKzp2EH6GJUep9gfzo0XXUvBH0tKXBR?=
 =?us-ascii?q?FLP1J5bUYz2naK2GB3kfYNIQLot4zo6qdQwj2tIEc41tS5wqTtFesOKV?=
 =?us-ascii?q?s0I9M9N89G/z6+RVxIzdon3A=3D=3D?=
Received: from mail-swedencentralazon11013018.outbound.protection.outlook.com
 (HELO GVXPR05CU001.outbound.protection.outlook.com) ([52.101.83.18])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 07 May 2026 08:47:17 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OliQBfeSGxHLin8uFBqs/zRk9kHIkkj9RkaWdfiujKKREwhTx0tSdXUXMUCwSXZNs7P6A4qtSKi7iJ2+XZ5MpfXilR9jEekegHcGrWMJUBjqOwic5iRBo6C44OIbz6xOqXVsPeB1APhF56/Tq8J+vYuXeSt7cdBYNXTNYX7PMG6vGIf9KL8aF/8EGnTPukzWs/C0H6mv8itX2B/guHNtfXv05L6hmEsEa2krK6lgTOwJ1/kYTGIRrKjnY+lKJ1NRQrxVAHaOBTMBDveWlIpSnZI9phnozcdMDTplD/nUaLDIcc8hdFPFJHXVMPrZF/gA7A7dgcfKzk1LkMuifSp6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oth0cDOrHpRfSAPiGcVF0N3UjOt6Wn8gAEruDTLzh/w=;
 b=EP2PnD4a707dkumyHQvxYo1u98abOCz9BzxTqKBR2Na0Iy450ubAKGK6TGBUGf4Q5Cc9V347hmT8r6A1VLBXe9vxyEDzODGEWoCIWGbg50LjTzOgmBRLsn/FL2VZeM2v2d2wNxJZbuT8wouthyLA22CvXFpTXyceoHe9kHOHfIl68NzN26qywPBwK6kIEfDl59hI9lX1E4SBgmzmFMLzqS06xEuOoMXHPwy5YMvcRFxjgvc0cxNxzq0E1Oq+ZjQgN2hXpGxCZsY+nkvTlVRaABLhMmnom9ID0EgIhGXBcPI23qNmf7gWKsVBjrfnvMioHKBAGk05AdXD2dRXlGvlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVUPR07MB11897.eurprd07.prod.outlook.com (2603:10a6:150:33f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 06:47:10 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 06:47:10 +0000
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
Thread-Index: AQHc2HDw15Tr3wTsJk+meiMDmTyHcbYCKZEA
Date: Thu, 7 May 2026 06:47:10 +0000
Message-ID: <b92a2bf357a436a40f4bc2f955fa7589d41c6564.camel@bull.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-9-zhenzhong.duan@intel.com>
In-Reply-To: <20260430071315.354333-9-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVUPR07MB11897:EE_
x-ms-office365-filtering-correlation-id: 22e0c20c-d3d9-4c7b-ad88-08deac0476e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: NHc8jNhhnNJA6nNqipCs4uDYkTqVl4Ya1oPgFbgJFSCyN5lYY6K7CGsv1lRy8eZ40WmJgq82PDYFgXsFFl7PSX+e7wPBgEY/EmeX10oqM9h1i50/L4kRYF66WCJLHsZYB60MC+MNJYbBOc5ZwY4N0QySMo00aiHYSK8SNbuNS1rzx1T+sQWmQr1Z/ubqd5tIMkiyT8O7GbqCGr7nNmiz5sNVt89mN5Eqqa7zSocKT22IK+Op4eQcIUrgn6IxpZIxNFF3jjSEuHoUzfgIUwJGJXk4zyvR3mD3cCtgBGqBtiJbAwtwZx51plq+z+XbrMEfqwD/5d4su9H1CloqGfsdzxGxbVsklQ2qhdc00ngivx9fsNZZPIisQCudP0PRrCkloVk68kDh+oSCOrXd5p4Yt2XPm4aGPLcuQtjeOGUrFcGMlGT5XvARfC+PZXz2lJ7UTlzrV3FvFSmW9z5cV57WVx3PmQn6L6ipzwqqz7v+OIjAHAhyY7HzlN2Gf1o+3uVU3tN5B22zZd5EU9YY/4BSeFgCkv8Fhj99eRuKsPjaYl1xHPgLft0dz1awcZ8T5aGxRCWk000yeXlRYTKQQPbcbMuVASdBmm6GUH+lyGU8yaOk7fe5vVcVJdyZ3LEBonrjm4BC2UBvxXhml61NoyCLvNj4JkFpMFkSTapqUe1aCGINU2CLr9PYqpS3d8v1O5MghXHKAycBp4jVR25fsmENzluj8XglVfu0sU4z7jiWjTsOdNHb7XAc2GlYTr+vuCic
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlFGeUdnZURiRjk2eGVkRkNhRWcvWXQ1TEEwak1HUXd6WXpoaUJMN3Rza0tE?=
 =?utf-8?B?V0FsRm9XSHJJZGNKY0NEdWFjZlBaQU5yZTFPQmRmWnBQZGdoWkN1bmN4REQ1?=
 =?utf-8?B?UHl4aWMyMlh6R3BYeS9JcFFNcWtrOGd5MU0wKzYxNkJKSFd0cE9XaFhQNHhI?=
 =?utf-8?B?T1cxY05jTis1VGo4VWZzUU5sNjhYaktPVTVDbVJ5WWtOMXNFeTI2cWdYQWpD?=
 =?utf-8?B?MFVEWjd6NXh2U2ludDJLZHMrK2hwY3JvaHlSU3o2OWE2SWVJbS80MHY5N095?=
 =?utf-8?B?K3JRTXZENTFiY3FOTDNxeUxaa2UyYTFLQTB5ZEZWY005UHVXN1RqS1JXdFd1?=
 =?utf-8?B?TkowYi85ckVueEtrRklWQTlyTCtVNVpDSDBTd3FCbkFQMGlobEhIUU43REdh?=
 =?utf-8?B?dXZOclZIM1lRTG9pUGxvN3RNeDB5SnphMnVnaXRwbDBYQUxPSFdPWWV1WWx0?=
 =?utf-8?B?amcrY3k0M1MrVGkxYVlFZHpKYjdMbWFoV2lHSm9pNWtKU0dkZlBwZ202dTda?=
 =?utf-8?B?YTdlSnowQ3BHMkN0TGwzcklBTkcyZnVQbWxNNmFxS0tmNWJBQXR2MEZRdnB0?=
 =?utf-8?B?UXpoSWJkUkpyRVZWaEU1Z2JEU0NkTWE5ZXpZMVVpY09nVlV3MnY3R0FPeU1M?=
 =?utf-8?B?bEhzc25YRTl0a1pwNUhncFJJaEdDMDBPUzJwWTJTazZjZkpEdUdLWFpyellQ?=
 =?utf-8?B?V0pIdzJiTTludXhVNDNLVTVvNmJ0WG95MFZ0RWpSSi9kOTZZd25wWnphNStt?=
 =?utf-8?B?OTlzNkFsQld1Zm4rNHZWQUxkeFNUbWRYRUJpVXI3UHVaQmw4aS9INnI4UTVK?=
 =?utf-8?B?UnlQd0N6azlHWk1tWGZYVW5HL3JSK1ZXKzVBRjlobHBML2d0QkFJSHNxbzlC?=
 =?utf-8?B?VmhiVGtJaVF4dEhFRUdueHFRckZBbURwQ2J2WkxzZkh0Z1BJYWRFZWdiZ1V2?=
 =?utf-8?B?eGJNRlFTQXNhYm5kbDZBMkNXcFF6SVhncEhVeXl2dWxYM2JLUXgwSjJobGI5?=
 =?utf-8?B?ZFhHWkJ5LzJJZWxXK09oWUNPakU0ZzRZMjM1OURSOUdYRURRRGlzbXp2OEpv?=
 =?utf-8?B?MjdWaVZDbS8xRU1mYTlBeW5ncFdMMGxtTW1VM1VBeDJGZ29acVhPMzNYUXF0?=
 =?utf-8?B?QUI5RjZsUFM5OFp4bTd5eWFkMWVqemdidnB0NUNpQWtOM2pDSy8yMDA2dEtl?=
 =?utf-8?B?RHNsUW40Z1U0NGh5SDdKNkFlZ3JmRHlzNkhwYzhqSkxaeFZ1blhQcDRXbXN0?=
 =?utf-8?B?a2VYdDc0UnVhbmtGZ2tLaDBPN0haVFhwTVQ0d05XRVZrRUZ0enhBTjFwNEJ5?=
 =?utf-8?B?UE9JTVJ6d01HeGpJM0h3bHoza3NhNk9KK2hiNFJRUmo2SVFsZ0JWWjlFVnRX?=
 =?utf-8?B?c0VWT2VSaFpTNnY0LzZ4RVUwdzcrRm5ZVEc3S2FlcVJFNnBPRkgzRHpVelh6?=
 =?utf-8?B?YUZiVm9ZZHFUSm1HdlJyVW5wMk9nb2RUa0Q0Qm0wZ3ZqdkdEb2ppKzM0Ky9K?=
 =?utf-8?B?QXRISG9OTVM2cmEvcDQ2Vml1WTZROE9JU1grVnYwU3A5aHdXTDlzRUg3K3Vo?=
 =?utf-8?B?QWN3dFhrcWZaS1AzUHdzNzd4Wmk0Wkh6b015YjV1SXNoS1FTeXBWUVFheGIy?=
 =?utf-8?B?MFpscHMxY0JLMkFzckdTRnRFMXR3M0lPeWJJY1orR3VwMUpkS2s0YjFQcWlJ?=
 =?utf-8?B?d29TOHFEZ2ltV0xHZWtueW9jOTB3QzUwa0o1MHZRQVVha2pjY2xudlFPbVdT?=
 =?utf-8?B?M3J2dlUrOW4xQlIvNTdzamd2SEJXTkNyMGdPUWFkckhZdnhsZkEzSzVTSHdm?=
 =?utf-8?B?ckt2dlNDQklnbi9yUmNOQ1gremdFYW9YQmhGUlBDcmRZclB5V2J5dHVFWGN6?=
 =?utf-8?B?aEFxeDhZYklsMXd3ZjZMdzN3NTFKYlN1VDdTS2lHaVpvZUxHYmR3VEN1YWdK?=
 =?utf-8?B?Zmo4dHQvQUZGWTUvOGlWZEhna0tSUmVmbXN3bml4N0hFcTl2Sm9ickpEaEMy?=
 =?utf-8?B?RHZkSjRvYzBpT3JJZGtDWWV4REphQTR0a0tNY1gxNkJKeDF6N2VJVFV6Q3Jn?=
 =?utf-8?B?REM2dTg1WGlPem5oWnIyN0VXMmhXVS9VSFZwRFZHV2lLQy94Q3EvU21jRkJj?=
 =?utf-8?B?b015UXlNeUd4NWpCTWlrOWpFT2FzRWhWcHBYamQzeWlTNGtkZjQ4YTUzd2tk?=
 =?utf-8?B?VG5wTk1WaEphZkVmRmFjY0orOGYyMUJkVHZJdkxwek84UFgreTRNM1huM2RF?=
 =?utf-8?B?Y0FvZzFQYjh4T21CRGlwU1grcjBGMXBhWkFZVUFiNTFWR1BrYkwxMEp2TnRs?=
 =?utf-8?B?Vm5xc0pzWmNETmd3RW13c3hKRDF0SWR5UXMzdXlkK2tOR0pNN3MrRG1jTEN2?=
 =?utf-8?Q?972MJzGTEXsubcx4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <227E77048369D84B9197A26AA3B10563@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TDzzwtdczMZ4Ejnl+SZpAQCgZHDOnk7pW6FnfIvPZtO3g5Lilk9kIVsJNbXEfqpY25Q6D+/LMii5DsoReKSvRA5oZssIaQ9xdGvc0hhx99NH1R/RRsCBjD3GDZ4sq8Dxop2CPpXem4Kc87IiCQvAY20xCjN4AcMO3XLUz8EjDbbCh6IBd8s8jrFDnJqX6gOKxu76HI7js1vYpBH0a5TbvpATwrzksAfzjU7FyM7+grORfMvWrfOAY8CmAO45vvqtEkrHUwY5cKBCNb8Oi/bCf5oavKVGnxYQYNJPTAXZOiAykpS4s5Cn5eUzJPLcQxTH3a/3R6nrZRCTywK5SaRqqw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e0c20c-d3d9-4c7b-ad88-08deac0476e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 06:47:10.7811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37enzNyJLAVVbj/puSvYCz8iXYk9wgxGbb9QlWgvZ8QRCnG5Tl2BLqzF30Qj3wGnDN9HXhz23vb2eyoY8xYLUOp8ysCFGVZ06euDjn00BHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR07MB11897
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

SGkgWmhlbnpob25nLA0KDQpIYXZlIHlvdSBjaGVja2VkIHRoZXNlIGtpbmQgb2YgY2FsbHM/DQoN
CmBgYA0KICAgIGlmIChwYXNpZCA9PSBQQ0lfTk9fUEFTSUQgJiYgcy0+cm9vdF9zY2FsYWJsZSkg
ew0KICAgICAgICBwYXNpZCA9IElPTU1VX05PX1BBU0lEOw0KICAgIH0NCg0KICAgIC8qIC4uLi4u
Li4gKi8NCg0KICAgIGlmIChyZXRfZnIpIHsNCiAgICAgICAgaWYgKCF2dGRfaXNfcmVjb3ZlcmFi
bGVfZmF1bHQoLXJldF9mciwgaW9tbXVfaWR4KSkgew0KICAgICAgICAgICAgdnRkX3JlcG9ydF9m
YXVsdChzLCAtcmV0X2ZyLCBpc19mcGRfc2V0LCBzb3VyY2VfaWQsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYWRkciwgaXNfd3JpdGUsIHBhc2lkICE9IFBDSV9OT19QQVNJRCwgcGFzaWQp
Ow0KICAgICAgICB9DQogICAgICAgIGdvdG8gZXJyb3I7DQogICAgfQ0KYGBgDQoNCmNtZA0KDQpP
biBUaHUsIDIwMjYtMDQtMzAgYXQgMDM6MTMgLTA0MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0K
PiBJbiBwcmV2aW91cyBwYXRjaCB3ZSBpbnRyb2R1Y2VkIGEgZ2xvYmFsIG1hY3JvIElPTU1VX05P
X1BBU0lEKDApIGZvciAgDQo+IFJlcXVlc3RzLXdpdGhvdXQtUEFTSUQsIHRoaXMgbWFrZXMgdGhl
IGxvY2FsIG1hY3JvIFBBU0lEXzAgcmVkdW5kYW50LiAgDQo+IERlbGV0ZSBpdCBhbmQgdXNlIElP
TU1VX05PX1BBU0lEIGluc3RlYWQuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFlpIExpdSA8W3lpLmwu
bGl1QGludGVsLmNvbV0obWFpbHRvOnlpLmwubGl1QGludGVsLmNvbSk+ICANCj4gU2lnbmVkLW9m
Zi1ieTogWmhlbnpob25nIER1YW4gPFt6aGVuemhvbmcuZHVhbkBpbnRlbC5jb21dKG1haWx0bzp6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20pPiAgDQo+IFRlc3RlZC1ieTogWHVkb25nIEhhbyA8W3h1
ZG9uZy5oYW9AaW50ZWwuY29tXShtYWlsdG86eHVkb25nLmhhb0BpbnRlbC5jb20pPiAgDQo+IC0t
LSAgDQo+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHzCoCAxIC0gIA0KPiDCoGh3
L2kzODYvaW50ZWxfaW9tbXUuY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDIxICsrKysrKysrKysrLS0t
LS0tLS0tLSAgDQo+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jwqDCoMKgIHzCoCAyICst
ICANCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCAgDQo+IGluZGV4IGM3ZTEwN2ZlODcuLjAxNDEz
MTZmODMgMTAwNjQ0ICANCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oICAN
Cj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oICANCj4gQEAgLTYxNSw3ICs2
MTUsNiBAQCB0eXBlZGVmIHN0cnVjdCBWVERSb290RW50cnkgVlREUm9vdEVudHJ5OyAgDQo+IMKg
I2RlZmluZSBWVERfQ1RYX0VOVFJZX0xFR0FDWV9TSVpFwqDCoMKgwqAgMTYgIA0KPiDCoCNkZWZp
bmUgVlREX0NUWF9FTlRSWV9TQ0FMQUJMRV9TSVpFwqDCoCAzMiAgDQo+IMKgICANCj4gLSNkZWZp
bmUgUEFTSURfMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDAgIA0KPiDCoCNkZWZpbmUgVlREX1NNX0NPTlRFWFRfRU5UUllfUlNWRF9WQUww
KGF3KcKgICgweDFlMFVMTCB8IH5WVERfSEFXX01BU0soYXcpKSAgDQo+IMKgI2RlZmluZSBWVERf
U01fQ09OVEVYVF9FTlRSWV9SU1ZEX1ZBTDHCoMKgwqDCoMKgIDB4ZmZmZmZmZmZmZmUwMDAwMFVM
TCAgDQo+IMKgI2RlZmluZSBWVERfU01fQ09OVEVYVF9FTlRSWV9QUkXCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDB4MTBVTEwgIA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jICANCj4gaW5kZXggNzQ2NDJkODEyMy4uNGQxYjI2MmQ1NiAx
MDA2NDQgIA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMgIA0KPiArKysgYi9ody9pMzg2
L2ludGVsX2lvbW11LmMgIA0KPiBAQCAtMTAwLDcgKzEwMCw4IEBAIHN0YXRpYyB2b2lkIHZ0ZF9w
YXNpZF9jYWNoZV9yZXNldF9sb2NrZWQoSW50ZWxJT01NVVN0YXRlICpzKSAgDQo+IMKgICogIA0K
PiDCoCAqIFJlcXVlc3RzLXdpdGhvdXQtUEFTSUQ6ICANCj4gwqAgKsKgwqAgLSBQQ0kgc3Vic3lz
dGVtOiBVc2VzIFBDSV9OT19QQVNJRCAoLTEpIHRvIGluZGljYXRlIG5vIFBBU0lEIHByZXNlbnQg
IA0KPiAtICrCoMKgIC0gVlQtZCBJT01NVTrCoMKgwqAgVXNlcyBQQVNJRF8wICgwKSB0byBpbmRl
eCB0aGUgUEFTSUQgdGFibGUgZm9yIHRyYW5zbGF0aW9uICANCj4gKyAqwqDCoCAtIFZULWQgSU9N
TVU6wqDCoMKgIFVzZXMgSU9NTVVfTk9fUEFTSUQgKDApIHRvIGluZGV4IHRoZSBQQVNJRCB0YWJs
ZSBmb3IgIA0KPiArICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cmFu
c2xhdGlvbiAgDQo+IMKgICogIA0KPiDCoCAqIFJlcXVlc3RzLXdpdGgtUEFTSUQ6ICANCj4gwqAg
KsKgwqAgLSBCb3RoIHN1YnN5c3RlbXMgdXNlIGlkZW50aWNhbCBQQVNJRCB2YWx1ZXMgKDEtMHhG
RkZGRikgIA0KPiBAQCAtMTE0LDcgKzExNSw3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9wYXNpZF9jYWNo
ZV9yZXNldF9sb2NrZWQoSW50ZWxJT01NVVN0YXRlICpzKSAgDQo+IMKgICovICANCj4gwqBzdGF0
aWMgdWludDMyX3QgdnRkX3Bhc2lkX3RvX3BjaV9wYXNpZCh1aW50MzJfdCBwYXNpZCkgIA0KPiDC
oHsgIA0KPiAtwqDCoMKgIGlmIChwYXNpZCA9PSBQQVNJRF8wKSB7ICANCj4gK8KgwqDCoCBpZiAo
cGFzaWQgPT0gSU9NTVVfTk9fUEFTSUQpIHsgIA0KPiDCoMKgwqDCoMKgwqDCoMKgIHBhc2lkID0g
UENJX05PX1BBU0lEOyAgDQo+IMKgwqDCoMKgIH0gIA0KPiDCoMKgwqDCoCByZXR1cm4gcGFzaWQ7
ICANCj4gQEAgLTk2OSw3ICs5NzAsNyBAQCBpbnQgdnRkX2NlX2dldF9wYXNpZF9lbnRyeShJbnRl
bElPTU1VU3RhdGUgKnMsIFZURENvbnRleHRFbnRyeSAqY2UsICANCj4gwqDCoMKgwqAgZG1hX2Fk
ZHJfdCBwYXNpZF9kaXJfYmFzZTsgIA0KPiDCoCAgDQo+IMKgwqDCoMKgIGlmIChwYXNpZCA9PSBQ
Q0lfTk9fUEFTSUQpIHsgIA0KPiAtwqDCoMKgwqDCoMKgwqAgcGFzaWQgPSBQQVNJRF8wOyAgDQo+
ICvCoMKgwqDCoMKgwqDCoCBwYXNpZCA9IElPTU1VX05PX1BBU0lEOyAgDQo+IMKgwqDCoMKgIH0g
IA0KPiDCoMKgwqDCoCBwYXNpZF9kaXJfYmFzZSA9IFZURF9DRV9HRVRfUEFTSURfRElSX1RBQkxF
KGNlKTsgIA0KPiDCoMKgwqDCoCByZXR1cm4gdnRkX2dldF9wZV9mcm9tX3Bhc2lkX3RhYmxlKHMs
IHBhc2lkX2Rpcl9iYXNlLCBwYXNpZCwgcGUpOyAgDQo+IEBAIC05ODYsNyArOTg3LDcgQEAgc3Rh
dGljIGludCB2dGRfY2VfZ2V0X3Bhc2lkX2ZwZChJbnRlbElPTU1VU3RhdGUgKnMsICANCj4gwqDC
oMKgwqAgVlREUEFTSURFbnRyeSBwZTsgIA0KPiDCoCAgDQo+IMKgwqDCoMKgIGlmIChwYXNpZCA9
PSBQQ0lfTk9fUEFTSUQpIHsgIA0KPiAtwqDCoMKgwqDCoMKgwqAgcGFzaWQgPSBQQVNJRF8wOyAg
DQo+ICvCoMKgwqDCoMKgwqDCoCBwYXNpZCA9IElPTU1VX05PX1BBU0lEOyAgDQo+IMKgwqDCoMKg
IH0gIA0KPiDCoMKgwqDCoCBwYXNpZF9kaXJfYmFzZSA9IFZURF9DRV9HRVRfUEFTSURfRElSX1RB
QkxFKGNlKTsgIA0KPiDCoCAgDQo+IEBAIC0xNTI5LDkgKzE1MzAsOSBAQCBzdGF0aWMgaW50IHZ0
ZF9jZV9wYXNpZF8wX2NoZWNrKEludGVsSU9NTVVTdGF0ZSAqcywgVlREQ29udGV4dEVudHJ5ICpj
ZSkgIA0KPiDCoCAgDQo+IMKgwqDCoMKgIC8qICANCj4gwqDCoMKgwqDCoCAqIE1ha2Ugc3VyZSBp
biBTY2FsYWJsZSBNb2RlLCBhIHByZXNlbnQgY29udGV4dCBlbnRyeSAgDQo+IC3CoMKgwqDCoCAq
IGhhcyB2YWxpZCBwYXNpZCBlbnRyeSBzZXR0aW5nIGF0IFBBU0lEXzAuICANCj4gK8KgwqDCoMKg
ICogaGFzIHZhbGlkIHBhc2lkIGVudHJ5IHNldHRpbmcgYXQgSU9NTVVfTk9fUEFTSUQuICANCj4g
wqDCoMKgwqDCoCAqLyAgDQo+IC3CoMKgwqAgcmV0dXJuIHZ0ZF9jZV9nZXRfcGFzaWRfZW50cnko
cywgY2UsICZwZSwgUEFTSURfMCk7ICANCj4gK8KgwqDCoCByZXR1cm4gdnRkX2NlX2dldF9wYXNp
ZF9lbnRyeShzLCBjZSwgJnBlLCBJT01NVV9OT19QQVNJRCk7ICANCj4gwqB9ICANCj4gwqAgIA0K
PiDCoC8qIE1hcCBhIGRldmljZSB0byBpdHMgY29ycmVzcG9uZGluZyBkb21haW4gKGNvbnRleHQt
ZW50cnkpICovICANCj4gQEAgLTE1OTIsNyArMTU5Myw3IEBAIGludCB2dGRfZGV2X3RvX2NvbnRl
eHRfZW50cnkoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50OF90IGJ1c19udW0sICANCj4gwqDCoMKg
wqDCoMKgwqDCoCB9ICANCj4gwqDCoMKgwqAgfSBlbHNlIHsgIA0KPiDCoMKgwqDCoMKgwqDCoMKg
IC8qICANCj4gLcKgwqDCoMKgwqDCoMKgwqAgKiBDaGVjayBpZiB0aGUgcHJvZ3JhbW1pbmcgb2Yg
cGFzaWQgc2V0dGluZyBvZiBQQVNJRF8wICANCj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBDaGVjayBp
ZiB0aGUgcHJvZ3JhbW1pbmcgb2YgcGFzaWQgc2V0dGluZyBvZiBJT01NVV9OT19QQVNJRCAgDQo+
IMKgwqDCoMKgwqDCoMKgwqDCoCAqIGlzIHZhbGlkLCBhbmQgdGh1cyBhdm9pZHMgdG8gY2hlY2sg
cGFzaWQgZW50cnkgZmV0Y2hpbmcgIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqAgKiByZXN1bHQgaW4g
ZnV0dXJlIGhlbHBlciBmdW5jdGlvbiBjYWxsaW5nLiAgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoCAq
LyAgDQo+IEBAIC0yMTUwLDcgKzIxNTEsNyBAQCBzdGF0aWMgYm9vbCB2dGRfZG9faW9tbXVfdHJh
bnNsYXRlKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBQQ0lCdXMgKmJ1cywgIA0KPiDCoMKgwqDC
oCB2dGRfaW9tbXVfbG9jayhzKTsgIA0KPiDCoCAgDQo+IMKgwqDCoMKgIGlmIChwYXNpZCA9PSBQ
Q0lfTk9fUEFTSUQgJiYgcy0+cm9vdF9zY2FsYWJsZSkgeyAgDQo+IC3CoMKgwqDCoMKgwqDCoCBw
YXNpZCA9IFBBU0lEXzA7ICANCj4gK8KgwqDCoMKgwqDCoMKgIHBhc2lkID0gSU9NTVVfTk9fUEFT
SUQ7ICANCj4gwqDCoMKgwqAgfSAgDQo+IMKgICANCj4gwqDCoMKgwqAgLyogVHJ5IHRvIGZldGNo
IHB0ZSBmcm9tIElPVExCICovICANCj4gQEAgLTI1MTUsNyArMjUxNiw3IEBAIHN0YXRpYyB2b2lk
IHZ0ZF9pb3RsYl9kb21haW5faW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90
IGRvbWFpbl9pZCkgIA0KPiDCoH0gIA0KPiDCoCAgDQo+IMKgLyogIA0KPiAtICogVGhlcmUgaXMg
bm8gcGFzaWQgZmllbGQgaW4gaW90bGIgaW52YWxpZGF0aW9uIGRlc2NyaXB0b3IsIHNvIFBBU0lE
XzAgIA0KPiArICogVGhlcmUgaXMgbm8gcGFzaWQgZmllbGQgaW4gaW90bGIgaW52YWxpZGF0aW9u
IGRlc2NyaXB0b3IsIHNvIElPTU1VX05PX1BBU0lEICANCj4gwqAgKiBpcyBwYXNzZWQgYXMgcGFy
YW1ldGVyLiBQaW90bGIgaW52YWxpZGF0aW9uIHN1cHBvcnRzIHBhc2lkLCBwYXNpZCBpbiBpdHMg
IA0KPiDCoCAqIGRlc2NyaXB0b3IgaXMgcGFzc2VkLiBJbiBib3RoIGNhc2VzLCBwYXNpZCBpcyBj
b252ZXJ0ZWQgdG8gUENJIHBhc2lkICANCj4gwqAgKiBiZWZvcmUgY2hlY2tpbmcgd2l0aCB2dGRf
YXMtPnBhc2lkLiAgDQo+IEBAIC0yNTg2LDcgKzI1ODcsNyBAQCBzdGF0aWMgdm9pZCB2dGRfaW90
bGJfcGFnZV9pbnZhbGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2X3QgZG9tYWluX2lk
LCAgDQo+IMKgwqDCoMKgIHZ0ZF9pb21tdV9sb2NrKHMpOyAgDQo+IMKgwqDCoMKgIGdfaGFzaF90
YWJsZV9mb3JlYWNoX3JlbW92ZShzLT5pb3RsYiwgdnRkX2hhc2hfcmVtb3ZlX2J5X3BhZ2UsICZp
bmZvKTsgIA0KPiDCoMKgwqDCoCB2dGRfaW9tbXVfdW5sb2NrKHMpOyAgDQo+IC3CoMKgwqAgdnRk
X2lvdGxiX3BhZ2VfaW52YWxpZGF0ZV9ub3RpZnkocywgZG9tYWluX2lkLCBhZGRyLCBhbSwgUEFT
SURfMCk7ICANCj4gK8KgwqDCoCB2dGRfaW90bGJfcGFnZV9pbnZhbGlkYXRlX25vdGlmeShzLCBk
b21haW5faWQsIGFkZHIsIGFtLCBJT01NVV9OT19QQVNJRCk7ICANCj4gwqB9ICANCj4gwqAgIA0K
PiDCoC8qIEZsdXNoIElPVExCICANCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVf
YWNjZWwuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyAgDQo+IGluZGV4IGJkMTIzNmMw
NzAuLjg5NDBkMjQwYTEgMTAwNjQ0ICANCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2Nl
bC5jICANCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jICANCj4gQEAgLTIxNyw3
ICsyMTcsNyBAQCBzdGF0aWMgdm9pZCB2dGRfZmx1c2hfaG9zdF9waW90bGJfbG9ja2VkKGdwb2lu
dGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsICANCj4gwqAgIA0KPiDCoMKgwqDCoCBkaWQgPSBWVERf
U01fUEFTSURfRU5UUllfRElEKCZwY19lbnRyeS0+cGFzaWRfZW50cnkpOyAgDQo+IMKgICANCj4g
LcKgwqDCoCBpZiAocGlvdGxiX2luZm8tPmRvbWFpbl9pZCA9PSBkaWQgJiYgcGlvdGxiX2luZm8t
PnBhc2lkID09IFBBU0lEXzApIHsgIA0KPiArwqDCoMKgIGlmIChwaW90bGJfaW5mby0+ZG9tYWlu
X2lkID09IGRpZCAmJiBwaW90bGJfaW5mby0+cGFzaWQgPT0gSU9NTVVfTk9fUEFTSUQpIHsgIA0K
PiDCoMKgwqDCoMKgwqDCoMKgIEhvc3RJT01NVURldmljZUlPTU1VRkQgKmhpb2RpID0gIA0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRCh2dGRfaGlv
ZC0+aGlvZCk7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBlbnRyeV9udW0gPSAxOyAv
KiBPbmx5IGltcGxlbWVudCBvbmUgcmVxdWVzdCBmb3Igc2ltcGxpY2l0eSAqLw==

