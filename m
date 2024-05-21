Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA05DC25B7B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PI6-0008Gr-Sc; Tue, 21 May 2024 09:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHW-0007ie-5u
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:55 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHS-0001an-Cy
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297110; x=1747833110;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3fCaFwfQGrgfgVmWEfraFRxRnf0Uq2+4zgU97Hu//68=;
 b=FxXprDypM58Fv+2fVgDwnfi4Detzeblh/2sa32IlvBVFIkuzSwCZU9Uv
 r1BSkcNxYHVtBIzJNGXhM5n0626m/oARDx6F/D7TlMYhDEnDsZZ5ugjIE
 uSVLF6kVYWb+jalO/CnKDmmzrxSf/tBkqnRTkO9VlWV0RBZ64bw/NktvL
 zVmIEsP3Fx/T4WVm+Df6yBrsPVN9KaqZg2ideNkCwiHMfcQYQPHXGeJn2
 C+LHKRlGQFF3W0ZQNz/Y05Tx+U0IE2gsGod71lqCXv4oc86vhnp2s2AZ+
 iRn7fNg3ZOlMr2rSsGk5UFFu7ihvMlBkey80SXFsYyrKJK2TSQ17S4MFK g==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13061506"
X-MGA-submission: =?us-ascii?q?MDGtbafTfxr6W+lytm0q9PlnLtGNa92s91gC8m?=
 =?us-ascii?q?D7cSpxrwq2t8cf/60yNH9sIbbcn0WC4rkjL3B+G8c0r+pJKpzi3u9YJ8?=
 =?us-ascii?q?f/uDd2YUDgf2ofg285NQ0C8vrJEyv3FD+vCWzfDSCHAGxjhob0xRdhkw?=
 =?us-ascii?q?EpqsXWY4tYXVW8hr3UllutZA=3D=3D?=
Received: from mail-dbaeur03lp2169.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.169])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:46 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNaGI7trFtK/3iS+7Xo+1SIwAM7h11sz7cXb6D/JeJYqr8RtBh/5KBudMW3XCjPzxOFAK5iEennjAOzf7ODd2Sbmpjuy4aiwPi0AqPUaZCzQfEXkYZIPqDrjiSAm0laNG/2vXeFy2M2dO4m+34cIEccKcbx0juOqNPImc42/XAuOTyjRWk1Xc5/2iPylJAxLPQe+ymdxkKbyP3loXtlPH3zZd0OW/0ltnzCg9sQGMqCEwd5KhA08pMHwCy1+8EjkEye4wZrJKjO2FZsa0r9WCuvVfLo1JSkJrjyYgacdMj/aC7/bhqT4cBUj8f76AOwWCjBJvDJwn44RkbTFLnvpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fCaFwfQGrgfgVmWEfraFRxRnf0Uq2+4zgU97Hu//68=;
 b=inaqWLOiOYdQW3nGfvKNtJLVqxTXldDXk2D4kLHIPzzzxwDI1hekFgDLUJf1koDAER//Rs35YiW8b1ykEEfzrai8RiJutZEOE90vl3UWWFbabf7u39iDsy/VXHiUVC4mgBjjQQ+8mD2qL5yxtJ8d3UugP0O9j6z8jHfMlWQCKXNABrvnUNPy5AEzLiLB3EGy3ACOazyMHNuj17yofwzB5uATQ4Hhj0j9UArtGllaNL4o9t3ditV8Y7IBoDPFAa5kL9hZd2wHb3VkEkZiPmm3+8cqfcwbvMhBFJ+6LtJynPR1QZxCxNvU2faco47VoC+e+x+1bE7X5hsAAEJZ2hImUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6249.eurprd07.prod.outlook.com (2603:10a6:10:140::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 21 May
 2024 13:11:44 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:44 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 10/22] pci: add IOMMU operations to get address spaces
 and memory regions with PASID
Thread-Topic: [PATCH ats_vtd 10/22] pci: add IOMMU operations to get address
 spaces and memory regions with PASID
Thread-Index: AQHaq4BtilJD6RPkfkmwyxJZ52pxwA==
Date: Tue, 21 May 2024 13:11:44 +0000
Message-ID: <20240521130946.117849-11-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6249:EE_
x-ms-office365-filtering-correlation-id: a52fbe34-9bcd-479a-ad27-08dc79979033
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?a3RySXFiRWlNc2Y3Z3pkT29YNHgxN2MzRWxSM0hkVEx1T2hwYlVHNjZsVU5K?=
 =?utf-8?B?WGZaMlUxdnA1OUdBdVJZcEZUWXI4Y0VSVGFuaE1MSVRPZW05a0RmVWtBbXM5?=
 =?utf-8?B?bGxLZE9zbFVSN2VyWWNKWG1HcmZ5VGJCY05NRkx3NitLT0NkWVFwTDFSYWdX?=
 =?utf-8?B?SDBITzJIaG1wZGJ1VndlYXBzZjBkdnJOaHd3TWdIMmd1UU5IU2FsOEdRbFZ4?=
 =?utf-8?B?a3NLcXd6cVh2WUh3eEQyVGxRanVzRGpwU2p1TXlWS2tYUFFvOWJrZ2tyUG1K?=
 =?utf-8?B?d2N3N1NBUWEybUFWNVN2SE1pVjRiUkM3anY3SHZDSHRDbWhwQ0pBNTd2Mitk?=
 =?utf-8?B?Y0JzVndWSkkxQWNFMUJ2MVkvVGI2Y2s5NTZDOVZGY0x0ZllhOStuKzFIWXN0?=
 =?utf-8?B?NDU5bUVIb2Q5bjFWV0hWdlhrclVzNjJxQjB5LzNLVXJTS0xTVmE1NlJvSWZL?=
 =?utf-8?B?RkhRM2hVVzR6V1RxeHI5MnpFM1V3QXdvd3VKaDJ4OTZNU3pZZUQrbWF1Szcx?=
 =?utf-8?B?SUxpcE1KRlNZSXZzUzZlTHhFRmc5bG9HMlp2L1gwTjQwWFY5eHNyL0p1VFpm?=
 =?utf-8?B?U2xQRHVuZDJmczA3Z3orWkJtazVHQmNUTitRZFFPT0c3TjhtL2gzMXBiUlZh?=
 =?utf-8?B?NGM5N2RxUS9pOVlqd0tOYmZJVmJaRHFqRWJXcDhlaThOakdkNXlpVDV5OC9U?=
 =?utf-8?B?L3dvVHhxYVFaSFRJL202dUpJU3pOQURGOUM1LzVyTlM2VURhMFNaOGREdzhY?=
 =?utf-8?B?WkZlOHUrcjVnRkJNMEdMUjF0bFVEcmpPb2t2TlVUeXoycGcwR0YzbDk1QTNa?=
 =?utf-8?B?QUlKM2kxa2djUEE4aHEzNGRPNU1zOU1Sc3JCZUlGUW9OUVlsRm1DWkFQQ2hJ?=
 =?utf-8?B?Z00yNkQ5dkdsRW5EVHR3VDNBT2xneGU1U0pWQjVUSHpncjZ6dzQ4RlBTc3ky?=
 =?utf-8?B?ZDdMbW9lYUlaam1zOEV1MnA1UU03Q2sxZE1SMHZTWTdoZDhpbUxyMTQ3ckJY?=
 =?utf-8?B?aS9rT3hUSm1YYTVoQjErOVJLM3krbXZDQVo2MVR3bTBMNWRLRVdOY3N5WXJo?=
 =?utf-8?B?UHVvc0k4U3RDZUxBV3g3Uyt3cHFtbVNseERpMTF4c1AwbjYrUnhId1NlMFpT?=
 =?utf-8?B?ZThSN0hsaUZUNWc1ZjdiUVA5MWFPSFAxb1Z4a2JlVWc1ai9vandSK1pSVjNo?=
 =?utf-8?B?eE1tbDRhT1dWZmswYXRtWncwRlB1WXB3WkhYSEdQMW4yN3lJMytEMWI2eEF3?=
 =?utf-8?B?Z0ErRmtDZWxFVFhBT1FHNXdZQmx6TTZCR2xaNVAwMXd1WVZZMGx0WmVkWUNp?=
 =?utf-8?B?TnRWMjliNGRaUFpXcVdYVUIzMjE0N2k2ZWovajl5NnRwdHRzVy9XeVc2b21k?=
 =?utf-8?B?bmFVcUUrakd0aGNVbDR5aVh1cnJGVStqaDBmSjM4V0VtVk43b3pkRVBZMmFD?=
 =?utf-8?B?L1hxbGhZV293bWlYSm5FVlp4YTRkc2tra1dhNzg3UmhLdDdTOXRXYXVMcmI4?=
 =?utf-8?B?S2txd3dvU0FJN3VRMlpFdUpobzJHSEI0SzQycjdIZ3BPNUs4K2VxYlpSSG1O?=
 =?utf-8?B?WitwSFVITFBkLzVFY0twVzJ3WWtUbGhINHIyVjY1Uk0xUCtLejNDajNMemtQ?=
 =?utf-8?B?ZzFKTW96Q2Q4NFBHQ2wwMGpvN29md1Q0MWJvbTRwY3lrcXNnai9obTJzcFlk?=
 =?utf-8?B?VXpUakprRVJEY1VjMmtJN2QvOXgyZ1ZWK3lRanNsYlBQQXJNT2NrK1IrbmRq?=
 =?utf-8?B?TDdrNGMyOFFuM3dQTjZTSmlsT20ydjlSdFYzdlE5eDM0QVpPdC9OUjNabWhw?=
 =?utf-8?B?ZkVCUVBaV1ZGWWdoSXgzQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFVzV3UzeVJPZG9MVW1FMjByZmVMNmF2UE9KejhQUjFsMExncjJycDNlMFR0?=
 =?utf-8?B?cEplN2c2Vm5laU9GbGFKRWtiU3ZBMk9wai9teWVaVmROdzVSMndXY0NJWjBy?=
 =?utf-8?B?SVg2bklXajBtemFudHczVDVpOVFVTU5acjVZQThVWGNWTHNmUGZVb254cXZW?=
 =?utf-8?B?azlIZUVoVGFJb0hpZmRGUGk1YVBZWHgxeW9ZWTFMM1ltR3dmblJaUEhMZWtl?=
 =?utf-8?B?RE1vNjhReHpXaUdQaURPMEZSWkJRak1aWmtuRjlMK3lnOE56aWdiekp1N3VH?=
 =?utf-8?B?eHR2QlU5VFAvUDBiNGNDdE13Y1RSeFdwbDdmbUJzVHRITGJ0N1RPMkNQRlQr?=
 =?utf-8?B?cVdqdzJrTytuZ25JR1FUajIvS2lVUXc2RnhQOS9VUWFSMG1oOENCb3krZXMx?=
 =?utf-8?B?YU5STWdIUGFSUE5LM2Y3dzVHMVVVMVRjQi9MRXpWMFd4Z3dJWVJtUUdCTkhY?=
 =?utf-8?B?ZVgrVUtBYTJZRjJSNW05Q0dxUk0ybnYvalNGQ3RDZVJBaGp2bVhOQllwTldT?=
 =?utf-8?B?bS96RFVWK0dVWmZpdmhoaVp0V1hBWXQ4TjIwK0xocmgxdWlXcHpteU1BNmtY?=
 =?utf-8?B?ZWV0aWpmM1hiVlRrdytNeXN4WHh5bHVDTGlOcHM5YVZsYU5zdkJPbVM4YklX?=
 =?utf-8?B?cjRxbjh0NmEwNFhtcUQ0bGJGNWRJSmRBMGhEb3hqOWRGVlZNWXRIWmlVOExv?=
 =?utf-8?B?U2FkWHliL2NnMFEyOUZMR1Q3Wnk2bUQwbFVUVmZUSWlqcGZTRnRzUFBvTjhp?=
 =?utf-8?B?MXNPMXprM2FkMVlEeXU3VzVxdVlva2ZOL3lTdlpWc0VycFgxeWY1eVhLT1Z2?=
 =?utf-8?B?Ly9qa1I5emNDOGEvaldGeFlYdGtYcFRhaWY3dVZSVkZ6SW80anZNWHRBSEpz?=
 =?utf-8?B?aUk2YlBVdEtQR2FlN0w4bzNVNzZKcG40ZmMyWWd6c05QcFZ0eDIxUXlucU9h?=
 =?utf-8?B?T0Z6WEhoeG04OHJ5ZWs4R1ZrMHBJd1Zobm91NGZZd1B2RFl3ckkyYzZXTnFD?=
 =?utf-8?B?YlF4MWdiWkxEeUtFV2h5OFpVSHVWb3Y2bitRK2ZtV3d4QXRCNU0rYlkzWGVv?=
 =?utf-8?B?cHZIM1hDMHZ1c2VBN2I1ZHN5UHJhQUZyWWd0c20zUDFIb09HaHRydVd2ZE0r?=
 =?utf-8?B?Q2xKU0N3UXUwWmFIOFVsSUt0dXphSkExYndDQ3BWNEVaUnU3ZFpRamRVOGc5?=
 =?utf-8?B?cDRQbTFFbHgwUEw0dkVHa3FIblQrelVvUUxSSjJFUzczc3h6QnFCcTZ4S1dY?=
 =?utf-8?B?Wnd5UW1lcHNsZnpMY3R3MnROL0NMM1dGbkE4N2NkZlQ3UGs1eW9LV0pWSUFu?=
 =?utf-8?B?SFNrazlrUVZwOURHWERrbzhJbHZYQzhpaXlSTkl1Z1VZY0pwdGhqTmdmckVW?=
 =?utf-8?B?Q1ZQcExhREhrOUE1RENkWXVxZ2dSUVMvbC96ZG5GQjNpOWVUcFlyZHlLU0U3?=
 =?utf-8?B?S3UvZWZUSHY0citySDRKbFU4Z3hOdWx1QllYaEt6N2ZGWFE5T0xRNzIxdnkr?=
 =?utf-8?B?eFdBZUtKNlhwODd5ZmFweHlXY1VmY1lUcG5tNzhDMVNlUUV1NmZFODdUUis4?=
 =?utf-8?B?WnVjK2ZTQVFQSzdGTXBiMFk5YjcwRTBnQjNFcVVydWMxK2pTQlpoKzlRSklz?=
 =?utf-8?B?VUVEK3Y0b21zK1h3MDFYN2hjN0NubC9iUkV5QjVraDBORmFFa3M1VEJKd2hO?=
 =?utf-8?B?cm5tRkdmd2N5anhMbUx6cHNFMC9sMjlYZ2FRSlFaM09Ld1lWTlRJQndmb003?=
 =?utf-8?B?em1aRDQrLzhUK2JNSlNyZlVMKzNjQldvQTVsQ2JjaXMrWVZFOHVVbERTblh3?=
 =?utf-8?B?R1FRNThDYldySFk1WXBjTS9uMjZqQ1hoS3h6UlB6V1BxcUovQXNDbHppZ0hG?=
 =?utf-8?B?eUhORzlFR1BiOE0rNTlOWG1aVlRRbWxqekFIaGZPbFBzdGhVOFMveEhFaGMy?=
 =?utf-8?B?NUFqaVp2cVYwVFU1WW5EajMxK2Q5a011U0tmS3Z4dStZZTZVRUFkOXQreFRQ?=
 =?utf-8?B?SGE5eXhuSmZmZDl1Z3Q5bkU4TnJaZFpBTVNrdm56eDZiQUhNTkx6R0QrbVcz?=
 =?utf-8?B?ZHdtMkNKaWZRSTQxMnIvZ2F2UUtncmpOTXhhNDliTTdKaktLRUQyNDFSOTBR?=
 =?utf-8?B?RUsxS010MVdpMGhrK1QybE8rSWJuSE9NcG5aREt3bTAzK1liYU44VWJmbmRx?=
 =?utf-8?Q?hYdHdsh2DC4sSCkkLhaF8cg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D8919986CC53C4D9298509CB75EEAF4@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52fbe34-9bcd-479a-ad27-08dc79979033
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:44.5708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+cdNNKT3sf224fwfkKY6m/E6dbSCotR/F/KwvQ1EWeRAm+NrOEF7VjQ2E+MxPaoWqlUumzdKEvJddg2QVcHS/YKMmkZchX+i+ktfvAKdi364Yps4SSOoZu5pYMnsrfk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6249
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpLmMgICAgICAgICB8IDE5ICsrKysrKysr
KysrKysrKysrKysNCiBpbmNsdWRlL2h3L3BjaS9wY2kuaCB8IDM0ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYw0KaW5kZXggNTFmZWVkZTNj
Zi4uM2ZlNDdkNDAwMiAxMDA2NDQNCi0tLSBhL2h3L3BjaS9wY2kuYw0KKysrIGIvaHcvcGNpL3Bj
aS5jDQpAQCAtMjc0Nyw2ICsyNzQ3LDI1IEBAIEFkZHJlc3NTcGFjZSAqcGNpX2RldmljZV9pb21t
dV9hZGRyZXNzX3NwYWNlKFBDSURldmljZSAqZGV2KQ0KICAgICByZXR1cm4gJmFkZHJlc3Nfc3Bh
Y2VfbWVtb3J5Ow0KIH0NCiANCitBZGRyZXNzU3BhY2UgKnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVz
c19zcGFjZV9wYXNpZChQQ0lEZXZpY2UgKmRldiwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwYXNpZCkNCit7DQorICAgIFBDSUJ1
cyAqYnVzOw0KKyAgICBQQ0lCdXMgKmlvbW11X2J1czsNCisgICAgaW50IGRldmZuOw0KKw0KKyAg
ICBpZiAoIWRldi0+aXNfbWFzdGVyIHx8ICFwY2llX3Bhc2lkX2VuYWJsZWQoZGV2KSB8fCBwYXNp
ZCA9PSBQQ0lfTk9fUEFTSUQpIHsNCisgICAgICAgIHJldHVybiBOVUxMOw0KKyAgICB9DQorDQor
ICAgIHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbihkZXYsICZidXMsICZpb21tdV9idXMs
ICZkZXZmbik7DQorICAgIGlmIChpb21tdV9idXMgJiYgaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdl
dF9hZGRyZXNzX3NwYWNlX3Bhc2lkKSB7DQorICAgICAgICByZXR1cm4gaW9tbXVfYnVzLT5pb21t
dV9vcHMtPmdldF9hZGRyZXNzX3NwYWNlX3Bhc2lkKGJ1cywNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpb21tdV9idXMtPmlvbW11X29wYXF1ZSwgZGV2Zm4sIHBhc2lkKTsN
CisgICAgfQ0KKyAgICByZXR1cm4gTlVMTDsNCit9DQorDQogYm9vbCBwY2lfZGV2aWNlX3NldF9p
b21tdV9kZXZpY2UoUENJRGV2aWNlICpkZXYsIEhvc3RJT01NVURldmljZSAqaGlvZCwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQogew0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCmluZGV4IGM4
NGNjOWI5OWEuLjZjNjBmN2E3YzUgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2kuaA0K
KysrIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCkBAIC0zODUsNiArMzg1LDM4IEBAIHR5cGVkZWYg
c3RydWN0IFBDSUlPTU1VT3BzIHsNCiAgICAgICogQGRldmZuOiBkZXZpY2UgYW5kIGZ1bmN0aW9u
IG51bWJlcg0KICAgICAgKi8NCiAgICAgQWRkcmVzc1NwYWNlICogKCpnZXRfYWRkcmVzc19zcGFj
ZSkoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZuKTsNCisgICAgLyoqDQorICAg
ICAqIEBnZXRfYWRkcmVzc19zcGFjZV9wYXNpZDogc2FtZSBhcyBnZXRfYWRkcmVzc19zcGFjZSBi
dXQgcmV0dXJucyBhbg0KKyAgICAgKiBhZGRyZXNzIHNwYWNlIHdpdGggdGhlIHJlcXVlc3RlZCBQ
QVNJRA0KKyAgICAgKg0KKyAgICAgKiBUaGlzIGNhbGxiYWNrIGlzIHJlcXVpcmVkIGZvciBQQVNJ
RC1iYXNlZCBvcGVyYXRpb25zDQorICAgICAqDQorICAgICAqIEBidXM6IHRoZSAjUENJQnVzIGJl
aW5nIGFjY2Vzc2VkLg0KKyAgICAgKg0KKyAgICAgKiBAb3BhcXVlOiB0aGUgZGF0YSBwYXNzZWQg
dG8gcGNpX3NldHVwX2lvbW11KCkuDQorICAgICAqDQorICAgICAqIEBkZXZmbjogZGV2aWNlIGFu
ZCBmdW5jdGlvbiBudW1iZXINCisgICAgICoNCisgICAgICogQHBhc2lkOiB0aGUgcGFzaWQgYXNz
b2NpYXRlZCB3aXRoIHRoZSByZXF1ZXN0ZWQgbWVtb3J5IHJlZ2lvbg0KKyAgICAgKi8NCisgICAg
QWRkcmVzc1NwYWNlICogKCpnZXRfYWRkcmVzc19zcGFjZV9wYXNpZCkoUENJQnVzICpidXMsIHZv
aWQgKm9wYXF1ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaW50IGRldmZuLCB1aW50MzJfdCBwYXNpZCk7DQorICAgIC8qKg0KKyAgICAgKiBAZ2V0X21l
bW9yeV9yZWdpb25fcGFzaWQ6IGdldCB0aGUgaW9tbXUgbWVtb3J5IHJlZ2lvbiBmb3IgYSBnaXZl
bg0KKyAgICAgKiBkZXZpY2UgYW5kIHBhc2lkDQorICAgICAqDQorICAgICAqIEBidXM6IHRoZSAj
UENJQnVzIGJlaW5nIGFjY2Vzc2VkLg0KKyAgICAgKg0KKyAgICAgKiBAb3BhcXVlOiB0aGUgZGF0
YSBwYXNzZWQgdG8gcGNpX3NldHVwX2lvbW11KCkuDQorICAgICAqDQorICAgICAqIEBkZXZmbjog
ZGV2aWNlIGFuZCBmdW5jdGlvbiBudW1iZXINCisgICAgICoNCisgICAgICogQHBhc2lkOiB0aGUg
cGFzaWQgYXNzb2NpYXRlZCB3aXRoIHRoZSByZXF1ZXN0ZWQgbWVtb3J5IHJlZ2lvbg0KKyAgICAg
Ki8NCisgICAgSU9NTVVNZW1vcnlSZWdpb24gKiAoKmdldF9tZW1vcnlfcmVnaW9uX3Bhc2lkKShQ
Q0lCdXMgKmJ1cywNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2b2lkICpvcGFxdWUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW50IGRldmZuLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkKTsNCiAgICAgLyoqDQogICAg
ICAqIEBzZXRfaW9tbXVfZGV2aWNlOiBhdHRhY2ggYSBIb3N0SU9NTVVEZXZpY2UgdG8gYSB2SU9N
TVUNCiAgICAgICoNCkBAIC00MjAsNiArNDUyLDggQEAgdHlwZWRlZiBzdHJ1Y3QgUENJSU9NTVVP
cHMgew0KIH0gUENJSU9NTVVPcHM7DQogDQogQWRkcmVzc1NwYWNlICpwY2lfZGV2aWNlX2lvbW11
X2FkZHJlc3Nfc3BhY2UoUENJRGV2aWNlICpkZXYpOw0KK0FkZHJlc3NTcGFjZSAqcGNpX2Rldmlj
ZV9pb21tdV9hZGRyZXNzX3NwYWNlX3Bhc2lkKFBDSURldmljZSAqZGV2LA0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkKTsN
CiBib29sIHBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldiwgSG9zdElP
TU1VRGV2aWNlICpoaW9kLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9y
ICoqZXJycCk7DQogdm9pZCBwY2lfZGV2aWNlX3Vuc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2Ug
KmRldik7DQotLSANCjIuNDQuMA0K

