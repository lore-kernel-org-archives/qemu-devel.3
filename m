Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDA9C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PIA-00006T-6C; Tue, 21 May 2024 09:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHU-0007i5-JW
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:55 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHQ-0001aP-0l
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297108; x=1747833108;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gogYq9bIMph+X6X2cL9HJLg/M0kvP6UJCrNM9EgvxWI=;
 b=PoLEN/l/fFOcxW2vpphkj2lTkUTkeU1995F0CxYWRwHBwqwl2MRO0PM4
 +CnJef2npKCvHLPVehfk3e02cp7973x+XHsuYaufZ5mBowZ0HUndD9sk+
 WnBNYP02QGqQsDdfBw6O9X31XdY6n0TYjDaXwvbI+Ms4Km507WkNYkJ5+
 D5ZLGEQaU9G+nZUT/6m9ppCcuoRqm9gUeN7EIt2pqRPkbiGOvTVeO/PMu
 HW7BX3U/ZqiDDaL9AGEPaGtp6E0EYn1c+raeS8DGHypRHfpM5Ao6D5xTQ
 uC/YSRWvArCXXGsDFgkqr3Jtg2qP9eezhLpochcwx0t7vW0pO3RMnXBv1 g==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13007991"
X-MGA-submission: =?us-ascii?q?MDF+t46JSy2INbCKVkeiLjIuxG+MdU7esKIcv9?=
 =?us-ascii?q?tiQfCuWskyVavi0QYZbdpdf0UA2HSnxOEPp9ZnzC8/y6HZBD6WwGD1ZZ?=
 =?us-ascii?q?h1xXy5vpjgQSoFZ04d1Zjz7y2h1Twf6AwaxRXLrD8wwICL3X75gMHyLj?=
 =?us-ascii?q?QCqpGlRUgsF0dNeJ8UjS+97g=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:40 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBwpdSAwZ9ij62Z22z6HKg2koDYm819pFlgsTlnlT7mF4TT5JQzGzZOnNQ0+p7fRfvl4KCE1KSwKCQVTWm8v/XOrnalkeYN6yn4TYwCeHPn+H0A5z8eFaTyj1CdmqgUCTdqKeEeopO4RsAlHRiG/F70kHapTCwNSyS7H1SlToi473ZBCD37+4IzhF1b0mqMyPOwALfQo+6UxoAKCfdsJhhdobsXdmenGQs9RgdlTeuo5Ow8FwEZzJyq71LxbWC8EndbA0OxkRR7tdKDdNJvNT1mwZyLfxSz6dxBkKQTV6pa7Ao8+aZrcjl5ih0+i6YN4/QmBLRSLOmzrCTK2dIAzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gogYq9bIMph+X6X2cL9HJLg/M0kvP6UJCrNM9EgvxWI=;
 b=JFLokBlGT5ATauK+ym59v5l19KM8d7JHVc+tFB46QDU9deo6tsQhiqlLKmeXqed3oEklxEdpcsxzh3/fg1vZQg662mGAdvIrGOGX56OnoLz1oHF9HuaU4x7yVlNeADuUbEmuO4MEt638+/OKig++elf9EhdZSi0OC8Z3jFpeJylmcta1j/AG6GaIpZVT89I3pRMtolnyj2q3ep/cb7rpt2RPWpQKSD8LJAbZ7MvWnQubW9ywP7YPpM5OTEstQ0RIpVIzLeIPJG1f/NyJy0TeLmmL9r5HRWFmPvm19VZhyDGEZXWnw0yQjMyDUGZhNkTyKIPsND78Gi4YbAqvUpk1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8148.eurprd07.prod.outlook.com (2603:10a6:20b:323::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:11:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:39 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 02/22] intel_iommu: make types match
Thread-Topic: [PATCH ats_vtd 02/22] intel_iommu: make types match
Thread-Index: AQHaq4BqDI0m4GPHTEuIK2r15OBdQA==
Date: Tue, 21 May 2024 13:11:39 +0000
Message-ID: <20240521130946.117849-3-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8148:EE_
x-ms-office365-filtering-correlation-id: 8b8052db-3298-479b-c042-08dc79978cfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WHJ0cnA2MTFBdVYweVEwME1zeFlha21FNjJGK1Q1QW5jQ2VZRTZ4OUtjVlNJ?=
 =?utf-8?B?Zkp2OHdOS1UvaUx6bjJvN1RnVnk2ckhQSmZKc2J3M2U0TkRRUFJxeFA0R0kv?=
 =?utf-8?B?U3pMUHA1VE9iM1RhL3VVMFdOQlk4bzlvZUZnM29ZWmZ6T1U0dmZMQjdaclJo?=
 =?utf-8?B?dU80RUlzb3hiS0xIdHBNREd2WEdTa2tzVlZNREI3SjZlOGc1YlRGbXVJNWlt?=
 =?utf-8?B?czFvRnl3UVd6ZEtPWERod3ZMNCtQRzNIU3QvSG1KSVZxb2Y3VUUrV2RXV2J3?=
 =?utf-8?B?NXdXWkhyajNwSUtFSWlxNXlwN1Nwczc2dUJ2QjRtbGErSGxxTmszekl3WjJX?=
 =?utf-8?B?QUdCazNFSFN1bFQwSVBWaTArWEVuVEhGL09oc0V4T0dsZVhVUUY2aVR2M1p5?=
 =?utf-8?B?NStXTTdqQ2prUUo4SWVhbkNmekt1Ykd0ajcvYjZCQzNMazRKMy9hRk4vK1lM?=
 =?utf-8?B?dVY1dGpUdWpHOWJ5VEZwOU8vbGVwQ0JXSzRBZkp2enI5WWZKb2NMQlFXR2gx?=
 =?utf-8?B?NEVXczhBVVdkRzhxOUJzeG1HN2pSYVdHQ04yc1k4bVVieTJvUGxyakRsMUJh?=
 =?utf-8?B?T0xjNTNiRHZZejhIVjdKUnVYYXpYblR3aU9HLzlheldqR3ptS0Y2VHBVa3Vr?=
 =?utf-8?B?SzVTTFRFUkF5OURnejlVMjIzMEI3VGxEc1FpRGtxZDBJdVBaeCtzUzY2aEp2?=
 =?utf-8?B?WkVYR0VTSGc4QXYxcU8velpFdTlQa2pieUNPTDlyWUtOVHNOaUFPRWFuN2dx?=
 =?utf-8?B?TWhaTGozNm1ZS1BuWnMrcjUxVHNIVmxQK2E4SXMwY1o5OUFIWk84T25rcFEy?=
 =?utf-8?B?amEwbVp2MklCa0g3eUR6SXNhMmRIR2pSTHlRMzZLdDloWUFQY3ZNRDZoZDBl?=
 =?utf-8?B?UE5DcFZjNGlFb0JEb2R0ZEpsZkdsUnFvVVJtR0t1RFVhbEZLb3ZRbm1sbUh6?=
 =?utf-8?B?dlc3c2M4ODIwV29Vcko1dnRUTjZrQ1M3cHh5K2Y4WW4xTk9aMnRNUDBKcHgv?=
 =?utf-8?B?YmpTYWE4UXJkTHZwSlMwQjhvTkxiS0xJM0VlbnNMT2hlV3hVV3o4L1NNMVh2?=
 =?utf-8?B?Y0ZJTm9uakowNE45eGJiZ0cvYjkvQUV3ZEpDSmRtMmJKZEtobkRkYmdGY3U4?=
 =?utf-8?B?VzZHRzJtQTZna2RhQVhEdXlEQ1JqUjFhTnp2Qkx0amdYTnREcWtiNTgwUjI1?=
 =?utf-8?B?K0VsWUdkRExCMDhreUJQbE1TYitpRDlUS1hMTmI3UGhiTThNbEk4UVg0dXNi?=
 =?utf-8?B?YThQSU4vTEZpNEFVbFFyNHpXZXRLR050OUZuR0ZDZEF5VTJzQzRtMlE0cUpP?=
 =?utf-8?B?S2Z4Y1BRZWxLV0pFekNXanhwYlNEZ1poSFEwNDJJUVJ5Q0x3d3FuT25Ia2Yx?=
 =?utf-8?B?WG1MQkUwT1NwMlFjdjdDRmZwTk9TTDJPdk5oUzJ5QUF6eW5NQWpVQzkrY1V0?=
 =?utf-8?B?Y1BrOENWb2xpUGhOa09KdDdMKytWZkFQSTFDYW9WYm1xWDRyUDB6K283WVpx?=
 =?utf-8?B?M1h0Z1pnQ3pxdmN2RURJc2FzVkRlUWhxaVpGaEdFN3dxOTlmWHBHenBFZjdi?=
 =?utf-8?B?OHR6bnJ6U0hBUlRDQytGZmUwU0dUTXhMSnlJRGxtc1FQUzRoWHRCWXNYanh5?=
 =?utf-8?B?U0NzM1VSWVZVQnBES3JJUVhNQ2JTVlRkbE1VTTZjcUQwd2dTbE14SVEyYkNB?=
 =?utf-8?B?alBqazlpb2FlNFl5dFNlcm5rSG4xNFJJejNaai9jZGcveVVsNTBSakpWQ1Fh?=
 =?utf-8?B?b01wbVlCOXpXYlhyby9PUVlFQWcveEVqRDNraGxQcVUybnRXaE5IenhBeEFS?=
 =?utf-8?B?cFRYeHl5SHFsQWNQanJOQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlluSXBQeWw2VSttd1Y4QmwrYVhVVVVSeGJHY0pGREJsUUFUZHhzb09oUWRY?=
 =?utf-8?B?MVhXd0syajdoSThCU05FVkNVT3hTTDFwN0lId1BBSU5wcTN3WFVoc2pKQlJP?=
 =?utf-8?B?TmpHOXNrZDAxOHViajgvRzZGM3JmSDlkMU9YeDZvZWV6MjV1cDV4ZkJNSS91?=
 =?utf-8?B?SkxWaFU5ZGhremVwM0ZVTGI1bVFqc0F6a3kxOGFOdmdOQkdlbUtXQU9wTjB0?=
 =?utf-8?B?MXdOeUp3QUgzNElQZGVCeExNZ3NXQW5hNTJWZ1puYUV1SjhHZ0Q3Mm41RWpl?=
 =?utf-8?B?ZGM4RU5YS2lOVzl3ZzRZdVhaYlZDaWVwZmIzYVcyZnNZc2JYWlA0ZGw4S2hs?=
 =?utf-8?B?Y1B3ZDRnNGE0VUlBNmM5ZXpST2RYNWVldXlRZlNkbXBaZTJRK1RNdWVUWVVW?=
 =?utf-8?B?RlQ4aytiU0Nka2RJakkxZzJ6QlUzMDJOTUpsOU5pSnFZanVzeEdhWWFQV3Iy?=
 =?utf-8?B?eG04bXNjdVJzQzZIU2d1WGR4K3orU1NmdWlCcVE1SGFhMlhNOUwxQzlaWHBO?=
 =?utf-8?B?dmVYOExLNGdEb2F4Q3hPNWdlOUJacE5lUlBEclIxWWJzS1Q1L0ZoNnNRTU1I?=
 =?utf-8?B?OUsyZGlpRXhmTTl2NmgrZm14MDRiRHNoRmlnekhRQktReGxrNzN5UG5hMnBj?=
 =?utf-8?B?alhnK3VvUHRzWHd6TThGQm0vd3Fmb0RZc0pXMEZmb3lmQi9YWWpzMGY5M0pR?=
 =?utf-8?B?SElBOXBRUUJLQ1NSMjFqYko3MDJDVGRBd1ptR25ZVE84RDNJci9WNU11THZo?=
 =?utf-8?B?c29kZ2ZFcG14aEVidlhnS1pxV1l4N3N4VTlsZWZwSm9ZVkg0bGhuMVZ0aWNl?=
 =?utf-8?B?T1N2cFc0dU9nUjFFZEpLM1FQb2xDbHpycXhYLzhUbEhnVUZhSnRWa05sT3k2?=
 =?utf-8?B?d2dmZFBCTERhT1lvdXBCZDY2UXM2cUI4RkdSSG5ISnZ6RHB0S2RaYWN4dG9q?=
 =?utf-8?B?WUZTWWhCR0xaeWdYc1lMelZPczEwVUVGNTlBakR2cllXaVdRczhPUmY3Z3lC?=
 =?utf-8?B?ckRGQ0lXZDRabkJoemd1a1ExZ2psN0pXWUtNY0NXWTRhaHFSdThzV2NDN0Fq?=
 =?utf-8?B?MWVBNFJLTmxsMEZQeFVGZjhLaGhBL2x3OVBsUFJKUEpLZkRZTkNWMk1JdTRJ?=
 =?utf-8?B?Q2YvcVAzdm5rekNFdEg3K2lFTEozWDU4akpDdFJKN1F4eUJxVGhzTUFvYW54?=
 =?utf-8?B?akJ4QjE3K2x6RFExbWg0UzN2WDcrcmRYcSs3OUdZclVtNWt4S2RHOGRnMGlS?=
 =?utf-8?B?V1AwMEtWMVViSm1pNStTVGRTaCtGaTZ5OVNiN1pvdk1uWlpKb0s4czZobjZk?=
 =?utf-8?B?Y01BQUR6NnhCdEJxSEV5SGJTK2lOZW53VGc1WGo4ZmVlYjNoTnJOUUc3MU9o?=
 =?utf-8?B?OXdEMW1jQS96M01VWlpHYnVRSTRibDZ2bTdKQjJPc2lzcUNBUEJPRlpDM0Ux?=
 =?utf-8?B?enFCK2RKdDd1azhXR2Q0ZHZKVGpKcUNqaUxmOXFmNjU1R21QcW5DQTIxbm0w?=
 =?utf-8?B?aGpyWXAyZnZpZWtOcXEwTFlKcUo2NCtPcGphbFlHN05YeE1hMGUrNW95TDE2?=
 =?utf-8?B?NlpPcEU1bEdQZHVYdk03aDJIaHNYQ0xrUUtRenMwVUs0ZVJOWkNPRk4rdmRa?=
 =?utf-8?B?TVlEZFVqU1Fka0JlOHNWdEt3UXRnZGpnTjhhYllxODl0ZXZaZ3p1dDhnaXRq?=
 =?utf-8?B?am1sb3RObXVnYytWT3RSZFg5Qnc0OGkwOGRwYVZ0NmhxOThoU2hNL21OZkJk?=
 =?utf-8?B?MWo1THZMcXp2NEhrLzlSZ1VRaGU4Y1pXNDEyM0hlS2ZxQnlPVitvRVJnK2Jj?=
 =?utf-8?B?M0xrdmpJcUpSLzBNTTk0b0hyN1FLTlpSbGhXRlVqRnBjM1hNRElIWXVpa1Js?=
 =?utf-8?B?a3ZLSTRaUEJFajFRTFpCTGRHUlNHcVVrNkxUUnR5UTEvanVNQVRuYk5OM3ZG?=
 =?utf-8?B?Z284YXpuY2ZJZXRlaUJWWlZycDdic05ydUVqdjUvYmRvajcrbWxFM25DU1F2?=
 =?utf-8?B?T0pNbEQ1bFpmQTZ1Y0p3YjlkUFV2cVJoUTVzeVZVUWc2eXdTcE90S1p0V3NZ?=
 =?utf-8?B?dGtOQUw2SFByR3hNWTdEVjJPTDNGQ2VpbGd1T1pjdVlvQW9VMlhMUU5hVXBK?=
 =?utf-8?B?ZDNDamtsT3hNM0tDZUxGVVR3UXVJb29OTVpqQmRuQjE5bmNyakxIODhpemNn?=
 =?utf-8?Q?AfwzgPQg4+Q90NRQzKnNCtI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05092B6E552A1844BDC6E58B62E34B5B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8052db-3298-479b-c042-08dc79978cfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:39.1616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mgvs2Uwxt1tvBrVx7OF5J+pkzOcUxMpbXRyUcXlEzYLBa4BfK5CLB5jTtwVPrpTNjM1hviYwm5Zn/xs7I86Kj8Kv9V3u5BJJmQADzXQ6CETywQkVqil5+CTgbCjS+SV8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8148
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

VGhlICdsZXZlbCcgZmllbGQgaW4gdnRkX2lvdGxiX2tleSBpcyBhbiB1aW50OF90Lg0KV2UgZG9u
J3QgbmVlZCB0byBzdG9yZSBsZXZlbCBhcyBhbiBpbnQgaW4gdnRkX2xvb2t1cF9pb3RsYiAoYXZv
aWRzIGENCidsb29zaW5nIHByZWNpc2lvbicgd2FybmluZykuDQoNClZURElPVExCUGFnZUludklu
Zm8ubWFzayBpcyB1c2VkIGluIGJpbmFyeSBvcGVyYXRpb25zIHdpdGggYWRkcmVzc2VzLg0KDQpT
aWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRy
aWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDIg
Ky0NCiBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAyICstDQogMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IGI0YmJkODM5
ZDkuLmZjODg5MGY0ZTYgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTM5NSw3ICszOTUsNyBAQCBzdGF0aWMgVlRESU9U
TEJFbnRyeSAqdnRkX2xvb2t1cF9pb3RsYihJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IHNv
dXJjZV9pZCwNCiB7DQogICAgIHN0cnVjdCB2dGRfaW90bGJfa2V5IGtleTsNCiAgICAgVlRESU9U
TEJFbnRyeSAqZW50cnk7DQotICAgIGludCBsZXZlbDsNCisgICAgdWludDhfdCBsZXZlbDsNCiAN
CiAgICAgZm9yIChsZXZlbCA9IFZURF9TTF9QVF9MRVZFTDsgbGV2ZWwgPCBWVERfU0xfUE1MNF9M
RVZFTDsgbGV2ZWwrKykgew0KICAgICAgICAga2V5LmdmbiA9IHZ0ZF9nZXRfaW90bGJfZ2ZuKGFk
ZHIsIGxldmVsKTsNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IDFlMzdiOThjNjUuLmM5YTY3
MzU4NWYgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTQ4OCw3ICs0ODgsNyBAQCBzdHJ1
Y3QgVlRESU9UTEJQYWdlSW52SW5mbyB7DQogICAgIHVpbnQxNl90IGRvbWFpbl9pZDsNCiAgICAg
dWludDMyX3QgcGFzaWQ7DQogICAgIHVpbnQ2NF90IGFkZHI7DQotICAgIHVpbnQ4X3QgbWFzazsN
CisgICAgdWludDY0X3QgbWFzazsNCiB9Ow0KIHR5cGVkZWYgc3RydWN0IFZURElPVExCUGFnZUlu
dkluZm8gVlRESU9UTEJQYWdlSW52SW5mbzsNCiANCi0tIA0KMi40NC4wDQo=

