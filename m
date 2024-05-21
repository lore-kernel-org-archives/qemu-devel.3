Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81636C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PIH-0000ip-Rp; Tue, 21 May 2024 09:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHk-00080J-RX
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:12:09 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHX-0001a9-Kt
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297115; x=1747833115;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OYW6nDkzOmyJAYhlc9/fa1EDVXZlqVKe7EKbL9TNrZk=;
 b=DmXLKpuYbMHb5wNrlo7W+hIlfo6d4b4wEdDQMOHy1eqaaFaJ2QKCdvTJ
 b8UbawVlJsLAFQAbsbKqncQsGInfklkvsGrmUSRj05nK4AW04p7TLFfX5
 vQki8ZZKmdDBmUQewBN+8pz/oySYb+RbXPR8v35hRA+KyqSGdreUbY4dC
 AEx0OsA3yxBjR7MZH5CwxrHMxw88maIOHI0OCbvrYITO5FNLLkV4huEeR
 fKEc9X0JO9HY8vQxLJPCT9aPx5u+Z2z9eDRlVvoxQJTX3jjQyCFr3ASWC
 Oq5f+09yF7TTfhh0+fOhDEVcy+A2ao/3BeDqZ3iE4EWKvtiA5RNSP1nRg w==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13011538"
X-MGA-submission: =?us-ascii?q?MDFXN0FrgkUGvL6RFU9+0ZjBjEznCVzp8ehWHn?=
 =?us-ascii?q?5K4xQlObfTmn5H4npf1weu0fAp2s2+yZ+R7PVbG2aeYCRVsmUZV7Rrk/?=
 =?us-ascii?q?Z0AzBRwctD+VdwGq+yVixnLy5OxSPYB4nKpyXwUojyQSNFRAujevSzGm?=
 =?us-ascii?q?GPfsppAn1uQW2fzLEFQ3haUA=3D=3D?=
Received: from mail-dbaeur03lp2169.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.169])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRwQuYaF/hXovTJ5LZ9Nkv9wWtjdndcBcNrbHEKapDH/LMczQOlOx2QQTrBCyLUpT9iuh5Soz0086/hjYbzl0eL08/zmErVIJyD7KxDtKk5NKoC16Yzwvn9lfjfBJ/0D8Q1ZL9Uxx+gZkuuvolCrE9MksclnMr49WntGCF6PsQUdBiTYyYEFUxRyRHcYmceFonUWYv8uVwtIXEyAtW2tZ+zdOrAkQ4TUrTeq/zlmmuLltG2j8r6Bnb3TVDTfQv0ZZkMdUK9DJajAVzBfDllJpXb+stCX/GVbYqzPTcx1h3EMVW+1wB78FR7T1PB1rP245GcF0NZpUUXR9+G1O6wu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYW6nDkzOmyJAYhlc9/fa1EDVXZlqVKe7EKbL9TNrZk=;
 b=gSVQhUKHsBPtQ/PPVXD1Cfraaq37QY19QWYykYuHzqvU/g25xQM6rT2cgq1ddoI4kaO3W9juillbjtKS/IqJzwDBW4Hb7fsZyF44nhNJ0gebelYX8Bex7hI2UrRKgi5BWl9TKXKdatR99rcsfr0BDhptHBpJkvoSE/Zo0aWpOxbwNVEX2ypxNNR/USteiQm2s56q804HmC1EMPTaiMo9dxMKf48UzvPYy10KdIEedwGl3ulXCepOyWocXVi+4rwCrl+qmE/yGnPKtRlLqSkftcVcm0SS9jiNxlvubB8vnrN7vJxs0kiWLE7lhe1GazAXfOx6XlXh3erI/4+DazI6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6249.eurprd07.prod.outlook.com (2603:10a6:10:140::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 21 May
 2024 13:11:53 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:53 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 21/22] intel_iommu: set the address mask even when a
 translation fails
Thread-Topic: [PATCH ats_vtd 21/22] intel_iommu: set the address mask even
 when a translation fails
Thread-Index: AQHaq4Bz7Ru33W1vwk2nGsDl0E/tfg==
Date: Tue, 21 May 2024 13:11:53 +0000
Message-ID: <20240521130946.117849-22-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 86b9ede9-775f-49bc-6050-08dc79979593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bitxaytCYXpWNlVza0ZieVU2OW1OSGVYT3BwWHBkQzd0YWVaWWFBblpsbVB1?=
 =?utf-8?B?WUxYL0F6TEtyUCs0djc0T2FKUXFTZGZsS2cxNmFEV0I3QTFmWFNNekFORXJJ?=
 =?utf-8?B?U3NmQXdhWFM1SXR6SmlFNmlxc0cwcStZWlZ6aGdadlByZ2doLzJJay96cCtR?=
 =?utf-8?B?Y1pWSlp6VVo4MEpiRGluTG1pcFhhNEhJem5QWGtmOWNvY0UramsxbHppNVd2?=
 =?utf-8?B?d09FaTJOY201SFF2Y2wyRHl4eC85RzdCTnczUWtkektKY2VZQjl5SFgyUkJQ?=
 =?utf-8?B?dHE5TkEzNWtIbXVoS3pGb2dLVFVTUXhINmQ0TXJzaGtoYTVkKzR5TjhVdXgv?=
 =?utf-8?B?djZTSVNURlVQQXBoT3F1SDNSc09qd3dTbXNRSTl4YUxFZ2VWY0tSNU04cnlR?=
 =?utf-8?B?d1l3WVArUHprTVlicXVFR0ZUNEdMOFpNVnRrdVVQRUYrSHdqSDlPQS93b2Ny?=
 =?utf-8?B?NjM0cnBCTlFvYlV2cjh4T0I3SVdyV2NIeW95ZTB3N2U4MUdHK3lCRU5iU2lU?=
 =?utf-8?B?YVcwUWFuYWRCRk00eVlkcTF6WENlcDJhTlNMeUQyUEc4VG51ZFB6QkJWN0ZD?=
 =?utf-8?B?RGFYM3pldGFVbXlaSXJVUG1wenl0U2VEM1pwaUYrSGFzK2dSUVpUeHZtaGM2?=
 =?utf-8?B?NjBGSEFuUnV6RTdwamw5YmQzY3BuSjYrQ1pEaWlwVEZuUXUyYW9lb05sWDJo?=
 =?utf-8?B?a2E1TkFqZUhha0kyOXFqNUdETmRvaWY0WUorNU5KNzBXUFFuNGNoUittWk9r?=
 =?utf-8?B?eGN5NWNTU09sYTkxNzBkQnZjUXFrMm1GbzAwVU93QVJYdlcvV1MwM256WVpD?=
 =?utf-8?B?YUZZUG9ZM3RHVlJKT3hpdy9DZEhpTGdNUlY0Z1B6RUkyZG83N0kyNkoyM0Ji?=
 =?utf-8?B?QkxaMXp2aWRJWm9kRlRKYlVTZTNjdXZxcnY1Y2JGWmRPNWladEc5NFNRY1Rt?=
 =?utf-8?B?d1N6bGdJWjJsdW95aENqUGlWTUVsc3JJSlkxU3V0aTF1ZlhDYzhsL0FrWUlk?=
 =?utf-8?B?eVM4N3ZINGxoQmo2YjNrYWw3ODhxOFdCUHRFRG9ZcURjTkRVOE10SG5iNXFE?=
 =?utf-8?B?M3o2Z2ZrNkkyaDJKQU1McDZRSVBzNTM3SEU1eXNrVjZrWTRoeFlweVVDYzNk?=
 =?utf-8?B?RU1oMU5GcVNqMStxM2lleGhaTnY2eWRxRk9Db2hGY285dUdMTzhKMFN2aXcv?=
 =?utf-8?B?Rk5sdlNVeU9FN3E2RWtsQXRCZEhNQ3h0WHFPOTl3Wk5qNkoxSkxCWFp2R05h?=
 =?utf-8?B?U2g4VzFRbnFSUm1KdEM2Ym95SllWbzFNS3I3a0tQN3M0QzhUZjFySGw1WWRy?=
 =?utf-8?B?NHhYbk9scDBtbm15RTUzdlBmb2NEeHNqamNGNFZ4OHNodzVVS1lzYWhHM1Bw?=
 =?utf-8?B?c2ZRL0Rta0xOQTdlL1lId1hVclFZY1BEWnBxYUxGc0tJZjc0YmkrdFlzUlNV?=
 =?utf-8?B?YkhQTVZ3dGNaT2ZDT3lLR3RTODZZTnp6YkRhTDIwc2xKNnRJV2kyaHY2L1hD?=
 =?utf-8?B?ekdobnJrZmdsWWdOVFlselRwdDYwUWFTbVQ2eTBuR1VGbW83d0txVVZ3d25o?=
 =?utf-8?B?T2RsbzcyYXJtc1RrREFyb29lQkh6V0UyWHdicHg1bDBPVHhXZzY1aGVUR1lZ?=
 =?utf-8?B?ZUJ6R2JrZWJPUWE0QVk4OU9ic0p6ZFNKNXl5dGl5cGI0SDV1YjFZd0RJUU5l?=
 =?utf-8?B?cFJPRThYSUtrSytLRTV2cGFJL0ZQeEN0aU5sdmJvSGZ2MFFxOGY4b1dEK3dx?=
 =?utf-8?B?NCtrbWZ0Z1B0T3lSM0VmeGdrb09JWU5Oc3pzaTV5blVYdDFkSmY2djEybm1D?=
 =?utf-8?B?WU5MaEpOQlVWRjBpbHlnUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXlYUXc3ZHZYeXRyaUo1SXl4dGMvMjZmbU1YdTFwN09nQUwwQ3ZnMkZaaWlz?=
 =?utf-8?B?SktHUVhCVzM4ZFlxOFMvaFRxR2U1Qm16elRHeG41MkMyTFlGRGFqNkNpaTRv?=
 =?utf-8?B?SXFjZ0ZOb0lDanpWbkJPQ2tMaXFXNU5laW9kb0x3bWM2VUNyd3lqM3N6c3hp?=
 =?utf-8?B?dEE1Z01Bc1ViOEFBenR3NGxUSC93UlprTDFRZjJjQktOQ2xaZjFDb3lKbUQ2?=
 =?utf-8?B?N3dIRE1MaTVMQWZpZUVOK093dzFta3pNVEozUTVOZlI1d2xlOVdVV1N6aW1M?=
 =?utf-8?B?elFOK09LSzkxVFBaS1VzV09CL2NNTjFuU0EzOVcya1IzWDVxWVlsSXhSMW0x?=
 =?utf-8?B?c2s4dGVhd0ZQTGZqM1BwZXc0K3QwMC80MlBPVWlqTVl0UDRJUEJXVWtnN0Rv?=
 =?utf-8?B?MkZnT3RYZTRwSTgrck9NNkNjQit1ck13QmRrbmZuV0JLaUN0bzdBVGRDRGFF?=
 =?utf-8?B?WUNXVDZtZnpUZGFTbDVjSUNIYm5KQjY2ekpFVlZJYkdoQVlWYWpjTFVCWjVt?=
 =?utf-8?B?SGMwa21SVy9Ga2U0ZCs1OUtrelZpMFYxaEJhVG1FT1MxMjhiTjNZallEVkRv?=
 =?utf-8?B?eGF5bzQ0L2k0UUpNeGc5TjZlS2dPL0I4MkdhZjRmdm9YZ0JqcU1VM2l2d2E5?=
 =?utf-8?B?djJaYWtBWUs4Y0hBcVZkQVpIRk9HSlFqVGlRZ0FadkJMSmNEcy9NK1hRYVoz?=
 =?utf-8?B?c0VPT0NsSWVuTUlBUmZZV0V0QTVpUkw4SEZUSmlZUldTMW9kMS9IaHhLT3BB?=
 =?utf-8?B?UVM0UFM3VVkrMDNhWHBvYk5VQWtjN255bEdaTWxDMTA2Ym9RQm1GelVWbnV4?=
 =?utf-8?B?eEs4Uzd0dWdnR1FvS2dWalA4ZGtIMFlXakRJcnNtNG5pV2dnNENOU2xJdjZM?=
 =?utf-8?B?RTN4Slk4SGVmUHA2ZnhiY1lUaWU0T2FKQjBUN0FrdEpEZnhZbHcyMU5ldGMr?=
 =?utf-8?B?dkZ4ZnNuOURwempnZExrNU80T3NlNmo1eGJjZnQ2UFNNQTR1ZEovWElCbGpK?=
 =?utf-8?B?QUp5NlAxMHpDemEwcEQzTmFHTFBuNkFHY3ZyYmQvejl6R3BCMnRUWnFaei9L?=
 =?utf-8?B?VW5LNk9vb0VCaUdqcnJVdlc2ZlhzT2NQR29oRjRwWGFpMURUTFRMclo2SG5l?=
 =?utf-8?B?MUxjZU5lQjNVUHo3SmE3RUlGQkEwMWNvaytLQzNUTGFNaVNSNWdQU2Q2QlZa?=
 =?utf-8?B?dEZDR1BFdSt2YkhLUUZUd25GS3YzOUt4bGRtM0FLNlZMMStyRDYxcTNBcGdr?=
 =?utf-8?B?NjJQVXZVU2l4MW5qMzFVNFU2YXVXQnRDUEFJSzlUNDNqMVZ1SXh4b1FXYmlh?=
 =?utf-8?B?R2NUa3U5WUczUmhsRnc0WGFwVnlpeEJMQ0xPVVk0SmE1YzU0V1V5V1NUMDVC?=
 =?utf-8?B?WkRKQ1kxQkxPTEplWW5EZ01ybE01Z0hIVkFqTHQwREN0OGJhb0JTSTgyMjZU?=
 =?utf-8?B?cTArNG4wbE9uT0pUdEYrY0FHd0hkV01EUlphMDBUMG9Md0s2OXVOSDBkRTRu?=
 =?utf-8?B?cThiZFREY3l3OWJxTXErZ3Z6dnlFVlBQNitjVjBNTTZCRm8wZ1RrYzZVakxz?=
 =?utf-8?B?S1c0ekl1N3c0V3p3Rjc4SmN5VUMwbVhPYklOS041NWZSMDdVU3RKcXlqcmFj?=
 =?utf-8?B?UXNwZXczcW5QR0JXS0U2dHRESFJzdERXU3Joc3VBMWhtS2RwTTZlUHZJRVZ1?=
 =?utf-8?B?YTV4SlUyTVcvYnh1NnJoR1hYZFRoNVRQYldERFNHTlRSWkhINGlhWFUxWFd0?=
 =?utf-8?B?NlFUS1ZJclJtRHRQc0hoQ1EwNTMyR1dCOGNXUnJuUUhuODFJd2VHMTBKQ1NU?=
 =?utf-8?B?YmpYcmdBZHViR3l3NGNtUDU1dVhnYWpiMlFLRk9lbmlOU2NRRkRNMERZTmpr?=
 =?utf-8?B?TGlLejJzaFpIUEJnZnFzRnR3dHRyTS85TXBGcVo0RitOYm9OeStjUDkwdUti?=
 =?utf-8?B?VVl0cHRjVGM4L0RqRVBGZ25sSnppYU9CMFA3WHFRZ3FtbjNhRUZ0OG1JdERY?=
 =?utf-8?B?b20wZktTZTNKZFQrcFNXaVFJWjVtQTd6RS9xc1VydE9kaU5uQjRxK21SM09k?=
 =?utf-8?B?d3A0aGNPdSswTjJTSzJ5VDJFQjlOY3hFZUZLNmgySFdtcFRIZ3Z0OWMvWTBr?=
 =?utf-8?B?d21vUjBHbHc2bVNaME9WeWFZQXBLc3dURmF0QVZHRFJuVzF3SE1xekRTYUFF?=
 =?utf-8?Q?pScfYiDlIqntluKwjT7lPd8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A0A7C391FD5994FACA7E7235A4942D0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b9ede9-775f-49bc-6050-08dc79979593
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:53.6044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqI2dHeXg0p5H8vyyXC9OnxCiCe53T8uy4ROpK9Svni4IOi+IL70VlhMWTxpvN5S4Gl+rYo3b3/H32TDp7IxUEnQ684wivDR8asXYLoJ/MyD6LGveF0L6CSWWYMJPod9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6249
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

SW1wbGVtZW50cyB0aGUgYmVoYXZpb3IgZGVmaW5lZCBpbiBzZWN0aW9uIDEwLjIuMy41IG9mIFBD
SWUgc3BlYyByZXYgNS4NClRoaXMgaXMgbmVlZGVkIGJ5IGRldmljZXMgdGhhdCBzdXBwb3J0IEFU
Uy4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRo
aWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCAxMCAr
KysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KaW5kZXggZjA4YzNlOGYwMC4uNDk2YmVkOTQ0NyAxMDA2NDQNCi0tLSBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtMjE2OSw3
ICsyMTY5LDggQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lvbW11X3RyYW5zbGF0ZShWVERBZGRyZXNz
U3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsDQogICAgIHVpbnQ4X3QgYnVzX251bSA9IHBjaV9i
dXNfbnVtKGJ1cyk7DQogICAgIFZURENvbnRleHRDYWNoZUVudHJ5ICpjY19lbnRyeTsNCiAgICAg
dWludDY0X3QgcHRlLCBwYWdlX21hc2s7DQotICAgIHVpbnQzMl90IGxldmVsLCBwYXNpZCA9IHZ0
ZF9hcy0+cGFzaWQ7DQorICAgIHVpbnQzMl90IGxldmVsID0gVUlOVDMyX01BWDsNCisgICAgdWlu
dDMyX3QgcGFzaWQgPSB2dGRfYXMtPnBhc2lkOw0KICAgICB1aW50MTZfdCBzb3VyY2VfaWQgPSBQ
Q0lfQlVJTERfQkRGKGJ1c19udW0sIGRldmZuKTsNCiAgICAgaW50IHJldF9mcjsNCiAgICAgYm9v
bCBpc19mcGRfc2V0ID0gZmFsc2U7DQpAQCAtMjMxNCw3ICsyMzE1LDEyIEBAIGVycm9yOg0KICAg
ICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KICAgICBlbnRyeS0+aW92YSA9IDA7DQogICAgIGVudHJ5
LT50cmFuc2xhdGVkX2FkZHIgPSAwOw0KLSAgICBlbnRyeS0+YWRkcl9tYXNrID0gMDsNCisgICAg
LyoNCisgICAgICogU2V0IHRoZSBtYXNrIGZvciBBVFMgKHRoZSByYW5nZSBtdXN0IGJlIHByZXNl
bnQgZXZlbiB3aGVuIHRoZQ0KKyAgICAgKiB0cmFuc2xhdGlvbiBmYWlscyA6IFBDSWUgcmV2IDUg
MTAuMi4zLjUpDQorICAgICAqLw0KKyAgICBlbnRyeS0+YWRkcl9tYXNrID0gKGxldmVsICE9IFVJ
TlQzMl9NQVgpID8NCisgICAgICAgICAgICAgICAgICAgICAgICh+dnRkX3NscHRfbGV2ZWxfcGFn
ZV9tYXNrKGxldmVsKSkgOiAoflZURF9QQUdFX01BU0tfNEspOw0KICAgICBlbnRyeS0+cGVybSA9
IElPTU1VX05PTkU7DQogICAgIGVudHJ5LT5wYXNpZCA9IFBDSV9OT19QQVNJRDsNCiAgICAgcmV0
dXJuIGZhbHNlOw0KLS0gDQoyLjQ0LjANCg==

