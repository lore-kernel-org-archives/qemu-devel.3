Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA463C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNZ-0003oq-Ef; Thu, 02 May 2024 11:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNY-0003oK-G6
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:48 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNW-0005z0-OK
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663786; x=1746199786;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zqR+oUgPhCm/33BfTla3yWvDsBBPd/qhyF4tDdgXLp4=;
 b=J5pNvBfgORB1KG4b0iFeiCCD6i1byLAxL0C2cq690EDmY1QWuZecWp9+
 ZjI5KgOjzvGyD4FTHUPqdL654H+JeBghhQBbmtfRfpcyRvHI9HKRhVXNd
 PY546j71P7Pc0OM7JNDGT1FD8I2dLyhWpv+T/Pn17wW2d8EJtLDOJYPiE
 h9+La1V4ianjpMGPQRx9+btrTdKX0L8QYvupn74ezkdFKESvL4EgWm91D
 eApFLO96MzGF8MfG2e18TTPXIuLdkLHq9fO+RJ3Wk4jW8lUAHIHJI9hwQ
 dPIv853L68LmzX2IyZXFCOatpKMK8Cej8Jy1h9xCFk413kqqJ3VKLQor6 w==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785882"
X-MGA-submission: =?us-ascii?q?MDEi3xao4Kvt3rZqQl4rQRyfQwqymbsETIJfFS?=
 =?us-ascii?q?AaoA+1VbM3T7iHtqPhbP+zUbYLC/o97e1jUw+fyVau0/Ayt38ApENTFz?=
 =?us-ascii?q?qxboxWJ7coyKQaSv1JekeL3TQpdpAWKET2CJpPhJWKRFCNBquWGUQ4Ci?=
 =?us-ascii?q?n8p6CdT7PQp9vAU6PaDQMOeg=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:21 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfhgJobScCgThDBrbXxtYrx9BgpCgCm0bT14JFPpdhRiZr7efy5lparmiqvtHY6HuzzbUJmj1ImG6Iw/KufC7pHvevgydS9la9RRTm+xXdz7mbg6HcoNJ4/LcsehQ29z8co68yhq4bXZ5IusVYDjBEGaPgOThtQUi62kXENmNTfuctPUQqff/ek7OUZkR2j4IgELx+JiSDKf4/U+efygVZDZPcso7cSJ6ZeXVJHc8lv0hXhZFPMIti8M76PriVj21nAdRrOSeTrWv4SOXv+9eWzplojQi67wffVqZydw2+kwkrC46FJ2mjXtrd7h0b+oFiy4oG8X+BRMfXKOu5Ti4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqR+oUgPhCm/33BfTla3yWvDsBBPd/qhyF4tDdgXLp4=;
 b=ETUIJlqWVCWulWE0lAFJ3O7OQNxrYVm1509sejEMRDtxOCtbCU6eLZ1gigmvOflaCn3TyvF2UKKJeZA9CNK3ltK7r+BlZwegrFC4kEkibde727Te2b34gZAMkcRvxZTyVEgxb567Em9uYrSjxmzxrPYU3qdeXDLUxKDJ1gCYQ0QHarr4CGR7wfAVOEJkWplevA6rgABH1DvyKbg6MRrIzp5lE2DvT2eLKYXsPUAQ+plkF2IxI52L/JDGf6vuk1q7cQIqycEnqPk7bDGYLsfjwTDBBhv/rz9QlxaqfZtWmrqmLNiCcIOPJSR16y5JfZWZH7YP8bquV6mYpwt7ZYDrVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:18 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:18 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 09/24] pcie: helper functions to check if PASID and
 ATS are enabled
Thread-Topic: [PATCH ats_vtd v1 09/24] pcie: helper functions to check if
 PASID and ATS are enabled
Thread-Index: AQHanKV/PXYNdBYXO0q7q3BlD52Syg==
Date: Thu, 2 May 2024 15:29:18 +0000
Message-ID: <20240502152810.187492-10-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: bab55448-ca26-4b8a-44eb-08dc6abca239
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VW9DY3ZIWDhod1JkYWMwcktIaWc1R2xZczBQSyttTUpkT0JEM1hQTzJDVUNV?=
 =?utf-8?B?QXhMTzhEZkhsRk5jWVU5aUtNODZuanFZalY0cmJmRG54NTRPbkdwK3hUYzBq?=
 =?utf-8?B?L2ZuMkVRbVpUMUxJeEVsdi8xSkEzNjJlcExreVFSODZEMlFaZ0NWUHZybXBN?=
 =?utf-8?B?bFI0UHNJS1QvSVhPc2dXaXFaaHhGUS9YeXI5VzVMZ0ZGSFdMOVZmSjNrQmNV?=
 =?utf-8?B?cG1tYmkwWUV5djVlRDJWc0t0RmlkSHB6QjZVY05VbU1IYUt6Vlc2NnlTWTJ5?=
 =?utf-8?B?UGVLSnpoalBJeUE2MlpYLzVja25lUVVOa2d4eVlzS3VPeVk2N0QyZWZ1UXIv?=
 =?utf-8?B?NWFpUUtBRXp4c05NSmZhTUtUWlJQa1FUbnRwbUt5UXVDYitQcGpHUVJ0VG9h?=
 =?utf-8?B?enV4UmhLZjZCcUFLVVVKZ1lYeThERkdMUThmUGFOeVBqZDlXRXJaeElHM0Zt?=
 =?utf-8?B?eEhaUTB5blBiaTZEUEY0alZHVGdaQUdSbU01UFlzZk9qSThKWU9CbXM3dGdy?=
 =?utf-8?B?UjZwbWI5VEpUWmFLbGM0ejhpY2ltMDN5N0pEL2hmbko0ZHczWTRtblZ2RkpE?=
 =?utf-8?B?Q1VEYU9PQXltdzAzNU5oRXBVYjQzODJNdjBhdnR2b3hGV2xFMU9sZEtpVmpu?=
 =?utf-8?B?ZTFnSituWFJia1ErYk1kamJ6ZFZuVllPV0JvYWlldmJVTEhnUHpPelByV1lV?=
 =?utf-8?B?b2ptQ1p2ME5LdGdFakttUmNpbnpFMExocVRCMnM0cll3WTBjY3pPRjNLc05W?=
 =?utf-8?B?YW53dEdsU29Lc3R5REhCWmdKRW96aUljYmlBei9kMGxQNU9obEVLQTdJejBJ?=
 =?utf-8?B?bk03eDdtVnFmR3dqWkdSOExIK2VEVDVTcjdkWnlRck16UVFhUVJpZVIrQXZU?=
 =?utf-8?B?L0pySmFqZ3ZYdkQ3b3F4UkpqTlV6K3M5MDBMOVVydG5oc05iNllYMml6RC9p?=
 =?utf-8?B?QVNBNWlPTzVvUmMrbDNGbllaNFd6SElaMDI4U05YSW5HS0d1ZFNZdlp5Q0Ry?=
 =?utf-8?B?QmxmZ3NtZjVxL1RSUTdXMVpYZjMwemlVZzZQMVZQTFkraURKRTlobE16WHFO?=
 =?utf-8?B?cUFnMnZyMXIwbUwxemYvOHlDOG5lN3I5aDNzM013UEZramNqQTlnZWpSejhO?=
 =?utf-8?B?T0kxU2pqUnJCMm1PU2hNdUVsNmhHT1czNE4vT3pSTTVjcm85VForVVVWdk1n?=
 =?utf-8?B?TnBoakgxcjlZQ1lrenloRUIvZmoxa0F4YllBV0gwcEttdSs2eFpjaUloWWpp?=
 =?utf-8?B?VHRrS3g1azhGMXFIQTJ2MkNyVFNnZFFZM1YzMm9BMjVvVVJhR2gzR0RxMDJI?=
 =?utf-8?B?SkpUZ3FqVUVZYXhPRmZZYnlzTVhoWmVBRWxVTVdRN1Y4cnpXNW9yaXgraXln?=
 =?utf-8?B?Rnd1QkV1M3V0ZjFZWnRkNVhMQnZrRVZZMGdiamJvYm1Wam1OczRSZkFOdEx6?=
 =?utf-8?B?a052MnllNHIzOTJBVjlpejZ3Snk2Ykx0R2xtKzIrQkVwSVVTci8zZkQvem1T?=
 =?utf-8?B?MWJNMmFQOWhjc2VQZ2h2aDJXeXBUdmtXZEpFTzlLd2pxYk5IUTBEN2FaSDBJ?=
 =?utf-8?B?RUpoTzB4NjJGa2d6T1hhRFBRblJGRTRDdlcwNlZRbjV0Vk9uV3BiVS9VRDlS?=
 =?utf-8?B?VkgxemQ2cHBGdlVUcU8waVVlNnEzckdWWDVpdEp4US9oZmwvcnZ6U2UvcVJP?=
 =?utf-8?B?bWxCVFlsUlNUeHVGVUdrejhYRTZFVE83cHRvVURZUXI3WFB5cjgzOTRDYzZy?=
 =?utf-8?B?OXdrQWRvaFd5TlJKS290MGQrOExzcVBmUlR0OE90cFFjc3NYbmVJcmNDWHNa?=
 =?utf-8?B?WHROd2syV3JHR25aUStnUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXh4YVlCYU5qbkNVWFhldjNjK05aaTMxMjRlcWljM0tPSVp3MGdMdmVxb28y?=
 =?utf-8?B?TlB3ZnVYYlV6N3BGYXh3SWJISE9sV0xDUmh4NDdkWmppaFp1N1ppMHBadlVs?=
 =?utf-8?B?T1VmY05sVi9uaU9idG9HTUhld3FkaXZXbkUvR1JMOWc2VUFlV1VNTjgwTHAx?=
 =?utf-8?B?L29PaXZQN1NPRTFwVlNRM1Z2SXkzSmJoeFovWm9OdmpmNTN6QyswcDdkeFZL?=
 =?utf-8?B?ZTViWlpOMGdxa0w3UE9KNEppby9xazBIdGlldnNWOTI5enRwdDE3T0xDeWxE?=
 =?utf-8?B?Zy9JVUsrYWREQy9Ia2ZjS0ZtaElaSEszbUt4dzR4YW9WUWkvZ0ZQNG1RcFdF?=
 =?utf-8?B?MzFsZHdXaVN6U0NUeHVrUHY0Z2VqVXZYOWkxM0hTQlN0aTVsWU5DU2Y5UmpQ?=
 =?utf-8?B?VGRWa2FjeEp5eGthYlZBUjk5WElMZ2Z5OFVadndDUXQ0eGZ4SVVPWGw4N00z?=
 =?utf-8?B?ODJ1Q2JYOGZtM0pGVUVjWVVDMkovcC9mZzhWaERnWTM4QncwRmN6VUo5aFBq?=
 =?utf-8?B?OUMvQ0YvSThkdERWWktHc25US24yZSt4S05OZUtoTDN3Zi9xRWtuVVpBdm1u?=
 =?utf-8?B?SkVROEk5R080M3V5N0x5aGhJVm9KU0xuMnpMVkhGZGtSREVOQjlINVo4bDZ3?=
 =?utf-8?B?aHFCVEl2WG40OW9USjF1UXdVWVllcVBQbFo0UmlydUdyR3JuSWRLZksxbnll?=
 =?utf-8?B?V2ZaUVdTQUhnV3pSdTVOekF1QWxWKzIwWUMzN3VpOWdUNGhwT3JsOEFZekhT?=
 =?utf-8?B?MnBUaytPNUo3VXNrZU9lSW1zNVZRRXhRTHJ3bzBRUHp3ZHN5THl5QW1NWVZu?=
 =?utf-8?B?YS9GMW55cGNOT3NHNGQ3czRZbzNJeW9ZejZ3UHUxdXV0NGtta3FkQWlYT3Bu?=
 =?utf-8?B?MzkyNStNOU51eHdQbE5aVWpIbHM0MmhjUExIa1NEL0I4ejFXaWY5bmdrV2hT?=
 =?utf-8?B?emsyaCtVelRxTUxicFNMZ2l5QnBNOVBvMmtmV2FFbmU4OEkxZEl3cU5zTGJQ?=
 =?utf-8?B?dmRXVE4remIrNHBuVFZDd3hJanNkd0Z6dHE2ek1oS3RyY0tqaWtSWHN0VXc1?=
 =?utf-8?B?Q2h2S3l0bGNBdnphcTZ4WFJtQ0xlREdHemlkbEhDT0poN1FZaGpTYXJ6Vitu?=
 =?utf-8?B?NFJsMmpQYkVwd2dBL3hVVVVBZzFSUjh5VDQxajZXaGU2SkduenJjZmFMbEYv?=
 =?utf-8?B?d2xieGpPdDJzalFqVU5NTnlmcTcwWXJCTW5MbTRKMlpoZ0ExdGpmVVZNSzVC?=
 =?utf-8?B?UEM2U0xLU2I5N1NqL3NzcXN0eE1ONUFPQlBQR2h4c0VzRmVlbndoUmVSa0pm?=
 =?utf-8?B?V1pSN3FkNVdRZVhwOXROQVpvUDlOYXh2Z1NESlAzYnJ0YndUaHZSU29HakZC?=
 =?utf-8?B?cjNUNWlGUXJBKzFkMWI2UkhyaHlMR0NjN2hZNVZ5UWlEMDVBdVVmYk4xYk1I?=
 =?utf-8?B?RGk5YStPTkNoV3I2MnVtVEF0eUFYWnAvVFlDVFhtSHowWkpzdU13aWZseHZm?=
 =?utf-8?B?V0xaY0o2TmhKWm9uUlpreDZVaDE5bmVab0tuUDNoMzdWdVNtc2RMekQ3djd3?=
 =?utf-8?B?TC9ESHZjMnhQKzg4SWpSTklJKzV1WlZQY1ZhbkJORTRjRkRsV3oyVzdUb09p?=
 =?utf-8?B?aTdzV0FyUENNN09vaGcrMmdOTWpGRnl2SDZEbXF5eUxCS0UvaW51dHBYRWE0?=
 =?utf-8?B?WSt0V0FtQjFIYis4QmRNVGdlSkorYWVVdmlJZ0Fab2hiMlNzWVJXdFBWNFZy?=
 =?utf-8?B?OXFHVCt4ZGpkdVpRemlLTWRaZ3RyYmt0elBZajZLb1dMZ0NneFdJaGE2dWUz?=
 =?utf-8?B?T1RBa20wUTMxb2kvOWc0NGhGNXhzbU83cDFpQVk2djlIa1NZZ0FSbkNES2xl?=
 =?utf-8?B?SGY0VE9XREw1NjFFU2hqOGlUN0U2b21HbDU3bjFBenhac21ML3p1cDlrNVAr?=
 =?utf-8?B?MnhYN3FnUXlnN2FDWCtKQ0o1VmgycGNXcWhhVjZhcm1TN2syRUNXcGRidVN2?=
 =?utf-8?B?ZThlUEtTbjlwdXY2VmF4MWEvWE5Fbmw5QSs5Z0E5cE5xSlZYT1BFaGVnVzgy?=
 =?utf-8?B?K3BDbEJacWE1QTcySWZjOWl6VXo3U1d4VEJYc1o5c1Y3cEVlU1BBU29zTUVq?=
 =?utf-8?B?VThaNFN4MnBqcldwdHJNY3pPaGtpN09uNVZVcEF3cFM3V29pT2Q4a3ArVHdl?=
 =?utf-8?Q?fv56zcliX08NclIh2JpmcbM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4ABB942C095514DBB68C39A2201CD1B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab55448-ca26-4b8a-44eb-08dc6abca239
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:18.7369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVwWyWk9Isj0OcV1iP7e+HezX01lgg0hI1MolJoIB1eu+1ax8zXspwT+iLBEQ5PHGB/skWR298uMjqNG1DewU2Nt50ZCfdOmhHIUPrhom3eI6wTPSO6ejSl2Phkfz+ft
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
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

YXRzX2VuYWJsZWQgYW5kIHBhc2lkX2VuYWJsZWQgY2hlY2sgd2hldGhlciB0aGUgY2FwYWJpbGl0
aWVzIGFyZQ0KcHJlc2VudCBvciBub3QuIElmIHNvLCB3ZSByZWFkIHRoZSBjb25maWd1cmF0aW9u
IHNwYWNlIHRvIGdldA0KdGhlIHN0YXR1cyBvZiB0aGUgZmVhdHVyZSAoZW5hYmxlZCBvciBub3Qp
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhp
ZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGh3L3BjaS9wY2llLmMgICAgICAgICB8IDE4ICsr
KysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvaHcvcGNpL3BjaWUuaCB8ICAzICsrKw0KIDIgZmls
ZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaWUu
YyBiL2h3L3BjaS9wY2llLmMNCmluZGV4IGM4ZTlkNGMwZjcuLjJhNjM4YTljM2YgMTAwNjQ0DQot
LS0gYS9ody9wY2kvcGNpZS5jDQorKysgYi9ody9wY2kvcGNpZS5jDQpAQCAtMTIwMSwzICsxMjAx
LDIxIEBAIHZvaWQgcGNpZV9wYXNpZF9pbml0KFBDSURldmljZSAqZGV2LCB1aW50MTZfdCBvZmZz
ZXQsIHVpbnQ4X3QgcGFzaWRfd2lkdGgsDQogDQogICAgIGRldi0+ZXhwLnBhc2lkX2NhcCA9IG9m
ZnNldDsNCiB9DQorDQorYm9vbCBwY2llX3Bhc2lkX2VuYWJsZWQoY29uc3QgUENJRGV2aWNlICpk
ZXYpDQorew0KKyAgICBpZiAoIXBjaV9pc19leHByZXNzKGRldikgfHwgIWRldi0+ZXhwLnBhc2lk
X2NhcCkgew0KKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KKyAgICB9DQorICAgIHJldHVybiAocGNp
X2dldF93b3JkKGRldi0+Y29uZmlnICsgZGV2LT5leHAucGFzaWRfY2FwICsgUENJX1BBU0lEX0NU
UkwpICYNCisgICAgICAgICAgICAgICAgUENJX1BBU0lEX0NUUkxfRU5BQkxFKSAhPSAwOw0KK30N
CisNCitib29sIHBjaWVfYXRzX2VuYWJsZWQoY29uc3QgUENJRGV2aWNlICpkZXYpDQorew0KKyAg
ICBpZiAoIXBjaV9pc19leHByZXNzKGRldikgfHwgIWRldi0+ZXhwLmF0c19jYXApIHsNCisgICAg
ICAgIHJldHVybiBmYWxzZTsNCisgICAgfQ0KKyAgICByZXR1cm4gKHBjaV9nZXRfd29yZChkZXYt
PmNvbmZpZyArIGRldi0+ZXhwLmF0c19jYXAgKyBQQ0lfQVRTX0NUUkwpICYNCisgICAgICAgICAg
ICAgICAgUENJX0FUU19DVFJMX0VOQUJMRSkgIT0gMDsNCit9DQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody9wY2kvcGNpZS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQppbmRleCBjNTk2MjdkNTU2
Li44YzIyMmYwOWRhIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQorKysgYi9p
bmNsdWRlL2h3L3BjaS9wY2llLmgNCkBAIC0xNTEsNCArMTUxLDcgQEAgdm9pZCBwY2llX2NhcF9z
bG90X3VucGx1Z19yZXF1ZXN0X2NiKEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwNCiANCiB2
b2lkIHBjaWVfcGFzaWRfaW5pdChQQ0lEZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50
OF90IHBhc2lkX3dpZHRoLA0KICAgICAgICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBi
b29sIHByaXZfbW9kKTsNCisNCitib29sIHBjaWVfcGFzaWRfZW5hYmxlZChjb25zdCBQQ0lEZXZp
Y2UgKmRldik7DQorYm9vbCBwY2llX2F0c19lbmFibGVkKGNvbnN0IFBDSURldmljZSAqZGV2KTsN
CiAjZW5kaWYgLyogUUVNVV9QQ0lFX0ggKi8NCi0tIA0KMi40NC4wDQo=

