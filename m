Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB95C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvyY-0007DR-Bb; Mon, 22 Apr 2024 11:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ryvyW-0007DB-2p
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:53:00 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ryvyU-0007bS-46
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1713801178; x=1745337178;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=/VWap17kGxEX0rbNFsPIxcanCyMV/Wijnh/mMwEyXMg=;
 b=jGQZzcTun19p+QpI0p7WbTISdMFIgl4VhIaLV89aLSVapiAu+7yhSl87
 vQOW/lVa0Mv/7XJJPp8ijyrwYAv0QguHaHN59pvAaEzfrx3yS9vcJbkQ5
 +68P5d4iFn4GhJXcOu/gdQF6XVYYQ0o8hlDuYamoXTjVT4ivs43kLcMAO
 f+jUVctDRfLl2QSbYxcCuA2YBRtTjACvJfvgDPIgkjxbfTgfEfmXUi26K
 w0wGOGTxdzVcKT9KG/xHQ7+FagdbQlWTUWP98ydOy4uUm1hnz0qKg4LJZ
 dmgCQZyFhKajBLcKePIURTggVcuemZbRxw0kDH+z19Kj6XlWG9hfCJIiJ Q==;
X-IronPort-AV: E=Sophos;i="6.07,220,1708383600"; d="scan'208";a="11027664"
X-MGA-submission: =?us-ascii?q?MDFSlyJ22P+2476gyz6ubEpwj1+L4omaOTRuCr?=
 =?us-ascii?q?OHPdqZWCVGreV14B/GGyRlbEuGnDSXJ7TxXkqPvCEtX4Wz4YqHY1LH/q?=
 =?us-ascii?q?AtGIeH1M0D4AQX72lpZ0vrfSbUc6BOvGhM5VAbbYOexodBU0JFT3xWhZ?=
 =?us-ascii?q?2tXmWS+M4QpQRCzLuQUksIMw=3D=3D?=
Received: from mail-am0eur02lp2233.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.233])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2024 17:52:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GromZcNgKszSrAM/ueaxvraH6xDj2o55AC8BmRwSB65l+YCEKQS98d3onUZCZIcW5WdI10ORcwF/3m9oGzdC7lGny1g13OAy6ZaFJCjHI4g5HzxFAqBW1anhlNmFRgM0u7aenwB+d4F99+xR2Vm8eTxoVd4mhBRI4VZWM+bgTSXnw2bmUcvZw8bwpDurpEbNzrfVbsqib1nD+gtVNElFDhFRAQJwn/Hj7Y0C56O2KOtknvuJf6ZcIwDDxQexuW1IV4UR/9i4hbBy0Hhs+UyrXex+D037+POntBUpRfiXHXa5kokGoqe8hO5jYIAIXm2qBAfIsZ4HCfSRJCc+4KBfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VWap17kGxEX0rbNFsPIxcanCyMV/Wijnh/mMwEyXMg=;
 b=jNoeD2f4COodaaB6g/dmNEyqE9Y4M9b4Xr+/wb7AYtcb9olhEeMv3suKFAUA1kfRd3QtAqZwuj4j0JzIoLLn3r+goYQ470/4hSDbRGO0izQQlooNKoLuWq2Phpc6nDt9Jvtrv7zkd0RsGH6CX073x5RTTaC/rBtZ1j7R562+XtY6o5WIzU6PV0jAZakw214CQhnf3XUBchAK7oOm4aA9LzPkMbLuqwPsVFUlCs9g1e7kmMgBhUhG/pQhNFXUAD/k/JcbsgFAvtAOhs3TDMrT2Luna4izOekBYfbniRfg9wlI+7juNa1+a+3QjsoCOcSZ8hPTt3EYj0sNOWiZ2Pamjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB9626.eurprd07.prod.outlook.com (2603:10a6:10:31e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:52:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:52:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Topic: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Index: AQHalM0ix1VtZwm0bkmmtp6S6avLxA==
Date: Mon, 22 Apr 2024 15:52:52 +0000
Message-ID: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB9626:EE_
x-ms-office365-filtering-correlation-id: 459b25da-d9f7-4a71-3e9f-08dc62e444b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?ZnVyd2drbFZGSzl5a251TmN1M3RXSmVGZ3pUdkJmY0VKeFJvTElqWGlxQndU?=
 =?utf-8?B?RE1vcDdoMGZRTWRpMnBab0NPQVRuOTQ5ZEpiTkM3aUNkMHducGFiazFGQkpP?=
 =?utf-8?B?ODlGNWtmTXdUV1R3Y0RIRk03U09LUXhLekdDRE9RWDNRQUhPS1VubnZPSkRr?=
 =?utf-8?B?WFFSOUkyVStBZ0d2Y2FkODAyRkdPQ2haVlNoM2xVNDg1VzdPT2R2UVVxR2Vk?=
 =?utf-8?B?cHBKNndUVGdYVWtiM2V1NW93Z3prR09QU1k4V1gyZXlSdlJWSkREKzEyMDJp?=
 =?utf-8?B?MlFZbzZybE5ac1pNZ1VkUjRmNUFSYmFrMmVJWXhiK2tKWCtQbmZGb0VPMkY1?=
 =?utf-8?B?U3ZrMHFOenpyRTN0Q0JPTHNRaVVwKzhMR0pMM205a21UL0dpZy9zK1ZOa3Jy?=
 =?utf-8?B?VUlwdEF5WFhnN0p3NDRad296THEza1B5bjRyNXpyamZpZzdXZGdXcXdFYUda?=
 =?utf-8?B?SW5vTzFYWkVmRm10U2xhazRxNkJNRERId1ZKWkdWYlhvT085elFEdVp5NmJL?=
 =?utf-8?B?NUZYWFRkNGhibFVTamZkcW1Qb1FKOUJHMkZTQldBK0FsZ3ZEcis5TVBRb0Q4?=
 =?utf-8?B?bnBNeHhBQW5uSUcwTXVlRUd5QjMxL21sK0d5N1BqM2dsbURQRkpVK2VJMnlB?=
 =?utf-8?B?N3cvZ2Z2MjRRN3crT3BFN1BMMmR6dzBmcjFhdTk2ZjN4TG50azBhdVo3aUhp?=
 =?utf-8?B?T1ZrRnJKV3hGR0Y1V0ZzWTNTbzJPMEptK1p6Zkp1ZXM0VGR3N2F6U2MzWVRO?=
 =?utf-8?B?OVFUMk1PaFpGUFFaS3J6YTJBb3laRVpNTndIbTltVkh5ZFo4UnpJMHloTkVN?=
 =?utf-8?B?NTQ3Rzl6b0ZGUTVscEs0M1M3U0p1RUdXeDVwV2ptQzRkM3VWUHVmZ0tPQ2N5?=
 =?utf-8?B?OUhxYm9VZExlbU84b2RXcXlTMHJFSmNLS2FuN2FmTG9QYzJFZm9HVEh6TkVt?=
 =?utf-8?B?WHZLTHJkVnkyNENscW1kYWtsc09Oc2h3bjJPTStYTzZNQU1oQXAyNXVJQ0F4?=
 =?utf-8?B?eUNsZ211Qng5ZVRrbHp3QUw1emNFalBVTGhybGJMQ3hqLzRxai9ZSkVXaWtm?=
 =?utf-8?B?MGg0Q1NGdm9ZTlp0b0RiUXRhcTZjT25WS3FpVEt2SGNoMEp3L3d4dDE2eWJ1?=
 =?utf-8?B?SkFQaG45SHNkUFZEMWhVOE4xUGRKK1g4bW9QcU9YRTUzT09vSGdFRWFpRG5o?=
 =?utf-8?B?Y0RQd0VtTzdqNm1ZQzhvU1VBYUF0UjlvNGlMWkRTQTlKcTNpd2oyS3F3ZGNM?=
 =?utf-8?B?cE1TcmRLcnFQZEt4N08vbTFMYjBoM3lPU1hNNWtzQTF5cmdVV2I4UlhYOXNx?=
 =?utf-8?B?UUJXaGxCcVdWZ3ZpYm40YU1HNE5nWm1sdzREeXVqd25GQlRsYWVoejBjVzlk?=
 =?utf-8?B?QjR1SlI3U1BtZVllaHdIQktsTGpVT1Zpd1NnNnJ4RENIVWlSL0RyK3lnT3NQ?=
 =?utf-8?B?NnJQRFl2NFlGSVRFSkRyQjh5VytCS09jVXRGaWI0MTRLUEVEcjkwNDRCa0NF?=
 =?utf-8?B?YUVMY0pmTTVURGV2NUt3TjJteHhReXIralZxZjk1dHNWY3NxbnRhRElxSTBN?=
 =?utf-8?B?NVUwejBuUXNkTExPcXRwYUx2VUVHTjJUeVpHYW01cVFrRGxPTWhjWEx1bVpx?=
 =?utf-8?B?NXcyNkJWWFl4Wlo3MTZ1bGp0bVFNM0F3L2xiY0ZoNjZibFdTUDlYQXR6dmFG?=
 =?utf-8?B?S3gxRnByWllVNDV4QXpnbHF6SFhVZ29lb1Y4Q3R6bzA0NE9UYUZKc2NwTzJu?=
 =?utf-8?B?MlcxMU4rMmRyczZUUUQzUlA2UnZqMGNuNlRiMXdxUzl4NU1ZeXdCaWNmd1Y4?=
 =?utf-8?B?ZUxIeTFVcElkWjlLRDRsUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXpLWjh5ZENodk5zS0ROemJnVTY5bERJdkJYajlEWW1MaDhqL2MzMG1ia3Ju?=
 =?utf-8?B?eEswWkpXWlNLVytSM3NMU2NQSk1NRTE4S2JJM3lMUXZoTlgyYzA5aUJKYUM5?=
 =?utf-8?B?clg5WDJ2UnlvVnJ2MDVTdjR6VjFhU1hPd3J2YlhSWVZCUlVsMlpqMXBFMXQ5?=
 =?utf-8?B?aWk2a0kyZE13TEo5bWpISkpJOHNFOHRHNlJMTWhMQ3BFNWtCQ1pKc1JBMWo2?=
 =?utf-8?B?bWh2ZkVnTms0L3ArOG16WFMrR3I0cHcvakdTTUpkYXd2MFNLUC9vU3MxRG9w?=
 =?utf-8?B?emZ2OGQ1bXUxckp6VVJUb3lLYmZCUHpzL2FqY2w2a1JxSTJpUXlTeXdlWjJN?=
 =?utf-8?B?WFRoMWhPRnNlYUdqSXBWUTV6OHdIc1IwSklMaTV6RFg3UWV2TUtIcEIyUGlh?=
 =?utf-8?B?V2h3VHZBNU53dEYwQkVyYUJqR0JlU0hFN3BYdHo5ZEgya1J5WXRsZ2JhdGc1?=
 =?utf-8?B?ZFZ4NTBTVG4xOUlPdzBMOHVPM01lYzRBR2N2QldGLzN0VzNIRVdqSXdYaGxm?=
 =?utf-8?B?UDZob1YydmR6b3NKOWtuR1RuWFZ1VXd0cG9kdXhWaDBsckp5S01nRGMrTFFS?=
 =?utf-8?B?WTlHMVhicDc1MjRCWUNpTTlTNTlldCtiU3BYdWpFb3VWWE9aandremd4TVBQ?=
 =?utf-8?B?b1crdmRvWm5xUnN2ZWM5UXpPQ285Rjd6WjBSU3pmQnh0U08xV0hDVG1sV3BH?=
 =?utf-8?B?OFM1UlpIT0U4UW9CZ3hzMXZlVTdlcnYwVDVYVUFmUVRWNU5sQWlLN0oySDJk?=
 =?utf-8?B?cU82RXE2TVBsbGp2RjA4Q1FwcEtWa3c4eGExUEsxVVYzVVhKSUl3VEh0bWxS?=
 =?utf-8?B?a2ZMdDJUZ3F6czNWeXlhN3o1TlEwdGhHSE1PbWhDNHczZGtSeFZhVGp1RGtO?=
 =?utf-8?B?MkIrNjQvM01XUGc4YWQrSm1tdHNtV3ZCeE1hZUFoOTg2MkZDNENDVWM4UmFI?=
 =?utf-8?B?RzRwSEpRWFFNamh6UVBvTlRodWFNMGI5aTNic1dXT2g2WnpzaTB6VjZVaUNm?=
 =?utf-8?B?TWNBQ01ZZ2R3YmNsUjJ1S2w4ZjYvbG95a2NwbUpIZFBXWEpzN1B1NU5XRVZo?=
 =?utf-8?B?ZUZHMUt1NGVBQ0pKZWpJbkQwMnBhOHRCcTN1cUlOa2ZiOERVODlsWGJ3VW14?=
 =?utf-8?B?MXJ1bE5rNjJFQVBRbVVqUmlnaWJGLzlrRnQzVEluajZpc2dqUEFwbWJiUFJE?=
 =?utf-8?B?bjdqbmNwdWZMUXBaNDlrSFZpdnVub3RwRUkzWklyejd2TTB1a2dIMWtYcEo4?=
 =?utf-8?B?L2tWSjJaMVdZdENXM1dYUkMrTjBBa2FyVnJ4NldXYWFZeXk2RWEvTi9oc0Jm?=
 =?utf-8?B?MXRhOUxvUDlvbHhxWVZFQXBDdEVka202MlIyeVJhZWJudHZvTHpzdVdkdndt?=
 =?utf-8?B?WjRrOWtxK2NoQkE3OHJ5cklLR0pyb1ZLU0NpSUtsQ1NCaFB6R0xiK3VCN3V2?=
 =?utf-8?B?MUFjRUVNU3ExVk5MMkJmZ0FJNDQ5RDdNMVhVM0JXRFdnZUl6M3ZiM2ZGMTZJ?=
 =?utf-8?B?YlNvU3BMZ0dVZ3ZWNWFCblZxVzBzL0xaNHBHOE1LRXRDZ0dnaENJVjkwUHVx?=
 =?utf-8?B?VmZsVEdoYmJHSmlzSTlHcVpQR24wM21ReVBlM3dwYS9HcGJaeVJ2cktxb2Ji?=
 =?utf-8?B?YWlpT3V4Yi9oMmlTSWxGaENtYnZVdXNrT1RyendLZG51REVFOWg5S1FpdWVE?=
 =?utf-8?B?YXY0MEJTTWI1c3h1OVBndnVkMnQwTGtydHZjL2xUTktLUGZwcFcxdjQwUkVv?=
 =?utf-8?B?S1pBMlhmc2RzUUIwNldzZSs2ek0xNjBIN21teVl5dU9SQ0F5eU1Od1JoQkwy?=
 =?utf-8?B?TDE2bCtvNlRqVEVWMThLeGllN3NkVHo3WUlObFAwMEE2a0ZyRnRiN0JhL0xj?=
 =?utf-8?B?RzBBOVp1NlNVQTkyYU5VSHFpaWZmY2lvMDJvR2FUVWlmUXFBREgxTXhSSWZl?=
 =?utf-8?B?c0trdHVOK1VUTWU1RlA1T0x1R2Q1NEhpbE5xQ0MwWUY5bmRjZXFYRTNTUDhk?=
 =?utf-8?B?UjFKejl6eWtFVnJnem1SODFhR2RWcFJUakp3aVNxUjNvcFFLcGJxRTVLZGFr?=
 =?utf-8?B?dlU4b3NRZXB1endCcWdJTEdzazJ6bzJWbTFSNitac3Y2TFRSSXF5Ty8vaVZz?=
 =?utf-8?B?eHBoaVVVZWNLNVBrc29FRFVtekg1SkQ5dG1hSnJDWFZjNE9ZTFB6M3hJZSto?=
 =?utf-8?Q?Q/TFq3hU9jGP3pleOiUHtbI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E4FEC0E51CB7E449FFFEEE23C21B594@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459b25da-d9f7-4a71-3e9f-08dc62e444b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 15:52:52.4451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFYS8TyTUldLDh9dZDZPNNUL1V9wg63ghYxnMABaATSHcJcqyyPvjJ3YdWFEhcvsrpbyK3oTac+W2NcadUYhbNTP4k1Te+K75/MY+YIM9esY+ZzQ+XjomwNYZtyjTeym
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9626
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

VGhpcyBzZXJpZXMgaXMgdGhlIGZpcnN0IG9mIGEgbGlzdCB0aGF0IGFkZCBzdXBwb3J0IGZvciBT
Vk0gaW4gdGhlIEludGVsIElPTU1VLg0KDQpIZXJlLCB3ZSBpbXBsZW1lbnQgc3VwcG9ydCBmb3Ig
Zmlyc3Qtc3RhZ2UgdHJhbnNsYXRpb24gaW4gVlQtZC4NClRoZSBQQVNJRC1iYXNlZCBJT1RMQiBp
bnZhbGlkYXRpb24gaXMgYWxzbyBhZGRlZCBpbiB0aGlzIHNlcmllcyBhcyBpdCBpcyBhDQpyZXF1
aXJlbWVudCBvZiBGTFRTLg0KDQpUaGUgbGFzdCBwYXRjaCBpbnRyb2R1Y2VzIHRoZSAnZmx0cycg
b3B0aW9uIHRvIGVuYWJsZSB0aGUgZmVhdHVyZSBmcm9tDQp0aGUgY29tbWFuZCBsaW5lLg0KT25j
ZSBlbmFibGVkLCBzZXZlcmFsIGRyaXZlcnMgb2YgdGhlIExpbnV4IGtlcm5lbCB1c2UgdGhpcyBm
ZWF0dXJlLg0KDQpUaGlzIHdvcmsgaXMgYmFzZWQgb24gdGhlIFZULWQgc3BlY2lmaWNhdGlvbiB2
ZXJzaW9uIDQuMSAoTWFyY2ggMjAyMykNCg0KSGVyZSBpcyBhIGxpbmsgdG8gYSBHaXRIdWIgcmVw
b3NpdG9yeSB3aGVyZSB5b3UgY2FuIGZpbmQgdGhlIGZvbGxvd2luZyBlbGVtZW50cyA6DQogICAg
LSBRZW11IHdpdGggYWxsIHRoZSBwYXRjaGVzIGZvciBTVk0NCiAgICAgICAgLSBBVFMNCiAgICAg
ICAgLSBQUkkNCiAgICAgICAgLSBQQVNJRCBiYXNlZCBJT1RMQiBpbnZhbGlkYXRpb24NCiAgICAg
ICAgLSBEZXZpY2UgSU9UTEIgaW52YWxpZGF0aW9ucw0KICAgICAgICAtIEZpcnN0LXN0YWdlIHRy
YW5zbGF0aW9ucw0KICAgICAgICAtIFJlcXVlc3RzIHdpdGggYWxyZWFkeSB0cmFuc2xhdGVkIGFk
ZHJlc3Nlcw0KICAgIC0gQSBkZW1vIGRldmljZQ0KICAgIC0gQSBzaW1wbGUgZHJpdmVyIGZvciB0
aGUgZGVtbyBkZXZpY2UNCiAgICAtIEEgdXNlcnNwYWNlIHByb2dyYW0gKGZvciB0ZXN0aW5nIGFu
ZCBkZW1vbnN0cmF0aW9uIHB1cnBvc2VzKQ0KDQpodHRwczovL2dpdGh1Yi5jb20vQnVsbFNlcXVh
bmEvUWVtdS1pbi1ndWVzdC1TVk0tZGVtbw0KDQpDbMOpbWVudCBNYXRoaWV1LS1EcmlmICg3KToN
CiAgaW50ZWxfaW9tbXU6IGZpeCBGUkNEIGNvbnN0cnVjdGlvbiBtYWNyby4NCiAgaW50ZWxfaW9t
bXU6IHJlbmFtZSBzbHB0ZSB0byBwdGUgYmVmb3JlIGFkZGluZyBGTFRTDQogIGludGVsX2lvbW11
OiBtYWtlIHR5cGVzIG1hdGNoDQogIGludGVsX2lvbW11OiBhZGQgc3VwcG9ydCBmb3IgZmlyc3Qt
c3RhZ2UgdHJhbnNsYXRpb24NCiAgaW50ZWxfaW9tbXU6IGV4dHJhY3QgZGV2aWNlIElPVExCIGlu
dmFsaWRhdGlvbiBsb2dpYw0KICBpbnRlbF9pb21tdTogYWRkIFBBU0lELWJhc2VkIElPVExCIGlu
dmFsaWRhdGlvbg0KICBpbnRlbF9pb21tdTogYWRkIGEgQ0xJIG9wdGlvbiB0byBlbmFibGUgRkxU
Uw0KDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgNjU1ICsrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDEx
NCArKysrLS0NCiBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgIDMgKy0NCiAzIGZp
bGVzIGNoYW5nZWQsIDYwOSBpbnNlcnRpb25zKCspLCAxNjMgZGVsZXRpb25zKC0pDQoNCi0tIA0K
Mi40NC4wDQo=

