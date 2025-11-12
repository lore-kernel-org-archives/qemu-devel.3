Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957ADCCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 02:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ0Ix-00073q-1n; Tue, 11 Nov 2025 21:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJ0Iq-00071F-9g; Tue, 11 Nov 2025 21:09:46 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJ0In-0005cO-TZ; Tue, 11 Nov 2025 21:09:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kN2zcBLQb2sQ7IShbyqqxcXmjCMR7IEJ4o5JjWPvy63LEG3wLcqSJtluziHvQ9Uvv4zbV838bQdM1Z8px5ewGpsemTwEBfDFOvs+P4ndd89tzLi2nvq5Xe2geixo6IOrrShVQ9oq53GtQhncymn1diiMIfrPRL/gLV8Sl56mHvqZz2idE7M6u4y6mak2U31ONOVKlt9udfkbTy6vqGDR/JjZSXyyo9jRsnLzqSbio8JxqW7xC2m9N6BHKQRcEFeUofyEJm+UQhrzfwG3fFv0IiJuouGzBNAIrCSskrYIc8Wy5luQkzMQJMUIAj2qYHBWCwDyPwtZbEiZG1OAkWaPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHgAtzUina025OXWOpwxcwNB67dXne04w2z1cdg+mu4=;
 b=AisqG4/AtwegL6Muo1ykYfHf6vi9O/x2mZYYmyusXSRgxrWduifU3eeNj15YoZdf6UezD8cDh35gjs/CpPXIy4rzdRtqOOUcK4kDcTrc9WzbPUr9BjiOeHUlNMGGwLGaraOrlzuenwp+7TUQANTwc3Dg7pSMzApK4r2oufU3AWf9mjQpZ2VdLUvRZhSjYg5pVMyW+Y2q7B83z0sfcj7V5CNyQWu/yGzRedVqoFq7JeSubWRJNA2c3McoYLyVRu+x04Qh0uSJ5NX1J3d5qIvFw2cMj0cYgbvF0vtgXYDH7+lim+BRrFbkI+A7895RmTP+0DgDakz7E6lsaWNlytinRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHgAtzUina025OXWOpwxcwNB67dXne04w2z1cdg+mu4=;
 b=VoWiKxj7nTmEOvOJ/HLY/xro1PL31QKAM2hjd7XdCffRSAQcuJfcWaD02EYixxi478mPBVkIWBECVDcTMil6eTfTNdwHoEVyR0496SOA+lEWFNnTorlSqeB+Ss9wzjFbbHnDPudwQ4IC28ubWfVc61bbQzQJAgw7su/lVQvclWp4/v3pONWaQV2hAIZhJiHaEfJ47C1yxUYQZDcEkM2bZTdV3wfS67Hpr5oCygCwJyJOfE1hgQvulBAu1Y+MTS1eiWyUNsYoTVdsGGHNUG3yKSbeXde4wMljpjzr6aSA/QmTl3hjPBbmhL1QvUmkjtXlPhy8s64hipC2mRIwCRckvw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5493.apcprd06.prod.outlook.com (2603:1096:400:264::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 02:09:30 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9298.010; Wed, 12 Nov 2025
 02:09:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 12/12] docs/system/arm/aspeed: Update Aspeed MiniBMC
 section to include AST1060 PFR processor
Thread-Topic: [PATCH v1 12/12] docs/system/arm/aspeed: Update Aspeed MiniBMC
 section to include AST1060 PFR processor
Thread-Index: AQHcTvpLBZj4uK0SgUK+hE7tg6ko2bTt0uqAgAB/zjA=
Date: Wed, 12 Nov 2025 02:09:29 +0000
Message-ID: <TYPPR06MB8206EFFA6DD7D7576A540C5CFCCCA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
 <20251106084925.1253704-13-jamin_lin@aspeedtech.com>
 <1ad39032-6b9a-4736-921e-b383d883ace8@kaod.org>
In-Reply-To: <1ad39032-6b9a-4736-921e-b383d883ace8@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5493:EE_
x-ms-office365-filtering-correlation-id: eb800c41-6f21-495a-f153-08de21908365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?eUJuVTFTSXBjd1c2d3dYM3I0U3h4aDFmM3QzVlRUSWd1RmZ0SGw1UFc0TG56?=
 =?utf-8?B?N3gwNGtnb0VwK1hYeHp3TU1RVFlKTHZRbmFtTXUzQnhuVUhsZllQdytaVE84?=
 =?utf-8?B?MldGcnRLRVIxMVozOUM1eEpNTHZQcU9PT3Z4WStWZDBYelg0R3FuUU5pcmJ6?=
 =?utf-8?B?UllraGdlWDlFdEQxNW9ZRm1hcWlVTUxNKzFKQ2FIZE0wMDhBT1l5Yy9xRFJk?=
 =?utf-8?B?VXBuRERiWDNQa3M2eUN0bVpZVVBNaFltY2VTZk1mUXVMblNwa3lKUTRCeHdT?=
 =?utf-8?B?Z05tR1RLS3QwRXc3b2tjS2ZMcERFajFSZ094OFg3Mjhscysweml0bXBmdFFo?=
 =?utf-8?B?UEE0ZWxHQ0Y3VDhOV0FBNnRKdEtBbHd4Z1IxN0ZkdDVDazNJUWtKQWpVeGZM?=
 =?utf-8?B?OGRGY1RuQld4R0MxbEVEckJYTGtXTy9NcndWZkVFYU1uaHd0QUx4N1BIcHBi?=
 =?utf-8?B?eGJvYWR1L0FUaW5IUmp5b3pqYzdYVUQrcTlFcDAxeUR6RG1NSHRyQVBlZEZo?=
 =?utf-8?B?aDNYemhwWDFJQ3VMKzM4aFRpa3lpNXpoVTdvVURSNmlYNzRqR1pua1dRbGxn?=
 =?utf-8?B?OU9OVHN5eE5BVkZvVGVzbU85MUthQXEycUhYdXdKQ05KTW42ZnlXaEIxR1pz?=
 =?utf-8?B?RFduM2hGUDNUaTd2TXB3TGtYMDUxcGtKUjloVWlTOCtpQ2Z6MEJsc0RtQ2Rk?=
 =?utf-8?B?cFdtSWh0bFJmR0hFWFRiQ1o3cHRjOTJQSW0vQ0swRHo3aUptR0xjZ3kvMGpx?=
 =?utf-8?B?Vm00VWljUlpKUHF0UVhiWDJjRjJHZVZ5OWZxYmYwMmpEaHVIYXRUcVZTMjZD?=
 =?utf-8?B?U1Q2RlloTmdQUTg0bnZiUFBvczQ2NHI3YWdHQWxpd3hBMW9STThteHN5V2hZ?=
 =?utf-8?B?bDhXVk0vTE95VkRpcXJJTys0aUtDWkUyejUrOU1zZHlKQXpjZGRFU0t3aTk1?=
 =?utf-8?B?MVNWRUc2d24vb2FOVXBpQjJFeVE2aDlpemI3UXZYSWhuY2Y1Y3ZWemwrRUts?=
 =?utf-8?B?d0tlTVMvblhFSjk3SGtMTUtvcmtZV3dGcllMRGpiQkxwNXRsTVJJQjZYMDI4?=
 =?utf-8?B?ZHRVUk1xek9IdzlDQkV4a0JUdnJ5NHdnUVB0d3EweU5TOGpmcVZJaEtFOUlk?=
 =?utf-8?B?TVp5eVNiTWV0a2FEWlVEVGV5clR4UVNrc3J6djYrR2ZRQVBTWmx0RlV5OUEw?=
 =?utf-8?B?SkcyQlAzZGpRdGhONmQ0M0w4bVh6elZ0R3RaZXpKY3VVL0RubWp4YnZEcGFZ?=
 =?utf-8?B?SWRrSDlsTW8wd0Q3dzFnK0pXSmZqN2R1akk3eXdrck9ENThKcU52ZjBrUUR3?=
 =?utf-8?B?RlVmRDVWdlNjdm12d2c3UmtsNVRjMWlySW5IM2ZOQUt4aitzeTlCNmYxK0Jn?=
 =?utf-8?B?QVpDSjNteXhqVFJkQlVOMkZPREZtdkFUWXhyNEd2S3Q4M20xaTYrR25BeHNX?=
 =?utf-8?B?dFY3THVEekg1TysxUW4vQm1yWUdOMHFmc3U1YVZmWVNnVXptS0VCdVJHU1NK?=
 =?utf-8?B?bmxwdGQraXV2bTN3Rm9rTkdHTzNKdEFneFc0VWltUnc3akNhVWJaM0M0dDRq?=
 =?utf-8?B?RDZQY3lkT0hYL2xFS0lOc1l4YitQck11T3NQTWxSUWMwSkZrUnVCM0h4QW9U?=
 =?utf-8?B?R3lvRHhzQXZKem4vSUFOOWdLSDNpeDlTeDBzSUhZUVA3cU5NMGMwZlpib0xX?=
 =?utf-8?B?aUFiZVVaWEdObXJaKzREZ1dNdzltM1JiUmROL1pxOEZaT0RncUgvdXk1eXl6?=
 =?utf-8?B?ZDdRVXJwLys1UEdKM2RwSmgzUkUzRTNKNlF0aEVVWUVRSFA0aWJBU0IxTVAy?=
 =?utf-8?B?TFFRdXZ3ZzdWNlczeVRMYkhKZnJiZWtabDBwdXFLWE5LT2F4VUNTQkRyTVJv?=
 =?utf-8?B?bjFmV0hsNGVRN3h0NCtDc3FOZGEwV1Z1N3NMMkdjNysySjFIeElMVWdldGpB?=
 =?utf-8?B?VHU1TGZYeXZ3SWVuNkd6T2lIM0lGNHVXc0ZkcjVpNFBrRkg4Z1hyUkxBODBN?=
 =?utf-8?B?WkhnUnd5T2RKdmhWWnE3YnJvek5zV2pENG05eWtrdk9sdnJGZkN4THU4TlFn?=
 =?utf-8?B?WXhIK0Q3K1l5c2h5QUJjSVM1ZXBrZWM4MEt4MFcxSjZtODI2eEpBb1dzUTZw?=
 =?utf-8?Q?6viI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tis2WU1kcDRIZElCcUFxdHJpTDgrOFlvNGZ3ZzZ2SHQ2bjlDTGIyWGtjSnNh?=
 =?utf-8?B?d0owSVJXcFVjVVg0d1lGcDQ1NWJ0aCtxbFY0VkVkdkRLcVRYNUxYWnNaZk9T?=
 =?utf-8?B?NldzRGRFS0ZIR1pTQlhGQ0d6cEp3T2s3cWpxYWhjbndmWkJaNUg5SkdZZDlO?=
 =?utf-8?B?blU2SDZiSmlDRCtZczFQVjBlTVJZbXZlMlAzQXhDL1poekFzQjBoUlBHUHZr?=
 =?utf-8?B?V3J5RmdiOWV4YVFzcjRhV3MxSGlLaFdWeElvRVZXWXB6NkZTVFJPTnVDdmpF?=
 =?utf-8?B?Q2VpRUd6akdWNGFFbmkrbWQzT084ZkZkWEJmTmdKK1phV2tTTEF2RDFZQzlY?=
 =?utf-8?B?dXVVVlo5ak42Rnk5K0F3dkpyd3FrZ0wyMDJ6Rm9ZU1RwR1FQbENNMFNLNG1G?=
 =?utf-8?B?MnpVbzZJdlgwcHBoK3U4QmJJa2kvb2R5UkhUbDMxQlE5MVVHK3loUTZRRFdl?=
 =?utf-8?B?UzVmcHZRSUZTYjJ1VU9pd2M3NWpmT3VoSjZOK2Zpd3EzUEd1TnQ0V2E0RDBD?=
 =?utf-8?B?M29QZ3phRGIvMlA4d0w2WkhZdGJ6MUU4N3U0SmszaHN3L3hiek5xL3ZUVXh0?=
 =?utf-8?B?YTNuaURlbWtFQ0dXL2JBWGEzaFphL2tUZU4vdmRRU1FRVENUOHFLYThMM0tz?=
 =?utf-8?B?ZTh3KzFxcXVmNmJjYXc2QVpIVm5lOGRyY3llL0xwUXlGUG5oMnMvakJvcnJO?=
 =?utf-8?B?YkVUOGNRN3k2emRqNEMyRlFCUTZNbC9JaXFDcEZNRFI0Vm9NVy9mZThNTlpl?=
 =?utf-8?B?aWdUQjNEQTMxOFVQZVZiNUNjOExldlArc3RMK1hUNjNMNVJoVmNWQ29tL3R2?=
 =?utf-8?B?Y3Q2UVNOZ01jc0dpd2hNMkJuTUY3MnExS0hnNUw4OEw1TFNTakt0T0VaVUtV?=
 =?utf-8?B?WjBXNDJDV3BDMkkzSTNBN3hBMkw5SnlpYi9mY1FTeW9OU0RzNm80MU0rSEEy?=
 =?utf-8?B?ZllVb0dMeks4YldJQ0w1bEQza0lpTHgwRmhMZEZzMGhYYVRMYWk2QWtuWGJU?=
 =?utf-8?B?UFhTaDQxRWpCdmlTU1RjS04rSGN4L1VidVc5aXdCL0N2VVdYQk1odWxNRnlS?=
 =?utf-8?B?dHQyd1hYYVFDSkU2NWRqa3d0VFJaa3R5UG5tZlk5dnpaNXRNaXFUNloycGI2?=
 =?utf-8?B?UjV3UUgxbW9iWU5JNVAzZy9tMVF0WFd3N0prL3B6Nlo5Q3Q3MHVaRG1DYjRU?=
 =?utf-8?B?TzJZbFZ5NlVyODBQKytYL2NNVTdtb2lVek85NktUYmVUcTYvdEJnQmoxVmV1?=
 =?utf-8?B?MDQ3ZFdreHRhY053SHJHUTZqVTdLK2hIRFYvdHZ3NU1FdkpGZ3F6WlBZazIx?=
 =?utf-8?B?RjRIOW9ENmprQ0o5TEVsZ0xpWmlqM2t1bGt3cFZnWDBNSE5VU1lwVElBZm5G?=
 =?utf-8?B?U3ExVmN6dGpLdmkvRHBvdWNVbitKWktlNHl0Mjc4QXZHT2pGZ2txKzRiQkM1?=
 =?utf-8?B?RmZGWUc4dEd1aXN4SEZ3eVd2b1BWNDkzSU5RMVBJSDJzakF6c0tlZithNk4w?=
 =?utf-8?B?Z0ZEY2lBRnBWYjdYVHVJcm5WRm5sbmNVa1lxQzFBb3k1UThJVVRVK1JHQW95?=
 =?utf-8?B?ekxRYWx3SEliVFIrMzRJeXduOFh6Y0ZEcnRpdDlRbk5BWDBSbHppeHdrbDZ6?=
 =?utf-8?B?TlJGS1FGR3hZaDc1YWJLK1VEZURoZDhndFhHY21CS05CYjlqWVVFMEVXRHow?=
 =?utf-8?B?YWQ4SHB5dGNrOCt5ZDE4Yjg3N1JFb1o5dktLNG5zajFyOTcxVjBuNGFEV3Bo?=
 =?utf-8?B?aWpMT0xOaXRwc0tkZkhzYUl3RDlnV2VCTURDTVc5QXN6b1k5OXoydDR6L2hD?=
 =?utf-8?B?RGdkbUMxRDQ5KzdMRG1sSlVHMy9yd0tWMTJwSXh6QTQ0RDMxMW1paEdLRG03?=
 =?utf-8?B?MzBmcEZLUVNkOWRtaUJOLzJVeUppdTMzT0J2VUlPK3N5RVIxdHpUV3hvUlhU?=
 =?utf-8?B?Z0JXY3VHeFNRc3A3MGdBaVdTZjNjeWIrdDk3eDhSWFM1SzlNbit2RDRLWnJy?=
 =?utf-8?B?SmQ4eVlJTUZVWjdQdEpwWTRkV1MvVjBiTTI0VzZwM2d2WTlHazBMV3hXaFZG?=
 =?utf-8?B?WXJNbWFudmEyb1NkYy94d3R4NGtxSVR4QUZZbS9vSHA2bkVJSVhoRC9wY3hi?=
 =?utf-8?Q?N70FYGJFh6cIxNUcMdbKWHVjt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb800c41-6f21-495a-f153-08de21908365
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 02:09:29.6376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bvRpqGr8jSC5J79iMET7u4bNiQWsl6O+nuIRj0D+//VUmbfcYzFAd/9jJrTDq53a7L4V5auXLj8CAWmzanDUxiy2TAdGY4wS2homMODEGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5493
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTIvMTJdIGRvY3Mvc3lzdGVt
L2FybS9hc3BlZWQ6IFVwZGF0ZSBBc3BlZWQNCj4gTWluaUJNQyBzZWN0aW9uIHRvIGluY2x1ZGUg
QVNUMTA2MCBQRlIgcHJvY2Vzc29yDQo+IA0KPiBPbiAxMS82LzI1IDA5OjQ5LCBKYW1pbiBMaW4g
d3JvdGU6DQo+ID4gQWRkZWQgZGV0YWlscyBkZXNjcmliaW5nIEFTVDEwNjAgYXMgYSBQRlIgcHJv
Y2Vzc29yIGJvYXJkIGFsb25nc2lkZQ0KPiANCj4gUGxlYXNlIGV4cGxhaW4gd2hhdCB0aGUgVExB
ICdQRlInIG1lYW5zLg0KDQpQRlIgaXMgdGhlIGFiYnJldmlhdGlvbiBmb3IgUGxhdGZvcm0gRmly
bXdhcmUgUmVzaWxpZW5jZSwgYXMgZGVmaW5lZCBpbiB0aGUgTklTVCBTUCA4MDAtMTkzDQooUGxh
dGZvcm0gRmlybXdhcmUgUmVzaWxpZW5jeSBHdWlkZWxpbmVzLCBodHRwczovL2NzcmMubmlzdC5n
b3YvcHVicy9zcC84MDAvMTkzL2ZpbmFsICkNClRoZSBBU1QxMDYwIGltcGxlbWVudHMgdGhlIE5J
U1QgU1AgODAwLTE5MyBQRlIgZnVuY3Rpb25hbGl0eSBhbmQgZWZmZWN0aXZlbHkgc2VydmVzIGFz
IHRoZSBQbGF0Zm9ybSBSb290IG9mIFRydXN0Lg0KU28sIEkgd2lsbCB1cGRhdGUgdG8gdXNlICIg
UGxhdGZvcm0gUm9vdCBvZiBUcnVzdCIgaW5zdGVhZCBvZiBQRlIuDQoNCj4gDQo+ID4gQVNUMTAz
MCBNaW5pQk1DLCBhbmQgZXh0ZW5kZWQgdGhlIGxpc3Qgb2YgbWlzc2luZyBkZXZpY2VzIHRvIGlu
Y2x1ZGUNCj4gPiBTTUJ1cyBGaWx0ZXIgYW5kIFFTUEkgTW9uaXRvciBjb250cm9sbGVycy4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29t
Pg0KPiA+IC0tLQ0KPiA+ICAgZG9jcy9zeXN0ZW0vYXJtL2FzcGVlZC5yc3QgfCAyNCArKysrKysr
KysrKysrKystLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
LCA5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2FybS9h
c3BlZWQucnN0IGIvZG9jcy9zeXN0ZW0vYXJtL2FzcGVlZC5yc3QNCj4gPiBpbmRleCBhMGMwNWE2
ZjczLi5mZmE1ZjRiMzcyIDEwMDY0NA0KPiA+IC0tLSBhL2RvY3Mvc3lzdGVtL2FybS9hc3BlZWQu
cnN0DQo+ID4gKysrIGIvZG9jcy9zeXN0ZW0vYXJtL2FzcGVlZC5yc3QNCj4gPiBAQCAtNDQ4LDIz
ICs0NDgsMjUgQEAgVXNlIGBgdGlvYGAgb3IgYW5vdGhlciB0ZXJtaW5hbCBlbXVsYXRvciB0bw0K
PiBjb25uZWN0IHRvIHRoZSBjb25zb2xlczoNCj4gPiAgICAgICQgdGlvIC9kZXYvcHRzLzU3DQo+
ID4NCj4gPg0KPiA+IC1Bc3BlZWQgbWluaWJtYyBmYW1pbHkgYm9hcmRzIChgYGFzdDEwMzAtZXZi
YGApDQo+ID4NCj4gLT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KPiA9PT0NCj4gPiArQXNwZWVkIG1pbmlibWMgYW5kIFBGUiBw
cm9jZXNzb3IgZmFtaWx5IGJvYXJkcyAoYGBhc3QxMDMwLWV2YmBgLA0KPiA+ICtgYGFzdDEwNjAt
ZXZiYGApDQo+ID4NCj4gKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiA9PT09PT0NCj4gPiArPT09PT09PT09PT09DQo+ID4N
Cj4gPiAtVGhlIFFFTVUgQXNwZWVkIG1hY2hpbmVzIG1vZGVsIG1pbmkgQk1DcyBvZiB2YXJpb3Vz
IEFzcGVlZA0KPiBldmFsdWF0aW9uDQo+ID4gLWJvYXJkcy4gVGhleSBhcmUgYmFzZWQgb24gZGlm
ZmVyZW50IHJlbGVhc2VzIG9mIHRoZSAtQXNwZWVkIFNvQyA6IHRoZQ0KPiA+IEFTVDEwMzAgaW50
ZWdyYXRpbmcgYW4gQVJNIENvcnRleCBNNEYgQ1BVICgyMDBNSHopLg0KPiA+ICtUaGUgUUVNVSBB
c3BlZWQgbWFjaGluZXMgbW9kZWwgbWluaSBCTUNzIGFuZCBQRlIgcHJvY2Vzc29ycyBvZg0KPiA+
ICt2YXJpb3VzIEFzcGVlZCBldmFsdWF0aW9uIGJvYXJkcy4gVGhleSBhcmUgYmFzZWQgb24gZGlm
ZmVyZW50DQo+ID4gK3JlbGVhc2VzIG9mIHRoZSBBc3BlZWQgU29DIDogdGhlIEFTVDEwMzAgKE1p
bmlCTUMpIGFuZCBBU1QxMDYwIChQRlINCj4gPiArUHJvY2Vzc29yKSwgYm90aCBpbnRlZ3JhdGlu
ZyBhbiBBUk0gQ29ydGV4IE00RiBDUFUgKDIwME1IeikuDQo+ID4NCj4gPiAgIFRoZSBTb0MgY29t
ZXMgd2l0aCBTUkFNLCBTUEksIEkyQywgZXRjLg0KPiA+DQo+ID4gLUFTVDEwMzAgU29DIGJhc2Vk
IG1hY2hpbmVzIDoNCj4gPiArQVNUMTB4MCBTb0MgYmFzZWQgbWFjaGluZXMgOg0KPiA+DQo+ID4g
LS0gYGBhc3QxMDMwLWV2YmBgICAgICAgICAgIEFzcGVlZCBBU1QxMDMwIEV2YWx1YXRpb24gYm9h
cmQNCj4gKENvcnRleC1NNEYpDQo+ID4gKy0gYGBhc3QxMDMwLWV2YmBgICAgICAgICAgIEFzcGVl
ZCBBU1QxMDMwIE1pbmlCTUMgRXZhbHVhdGlvbiBib2FyZA0KPiAoQ29ydGV4LU00RikNCj4gPiAr
LSBgYGFzdDEwNjAtZXZiYGAJICAgQXNwZWVkIEFTVDEwNjAgUEZSIFByb2Nlc3NvciBFdmFsdWF0
aW9uIGJvYXJkDQo+IChDb3J0ZXgtTTRGKQ0KPiA+DQo+ID4gICBTdXBwb3J0ZWQgZGV2aWNlcw0K
PiA+ICAgLS0tLS0tLS0tLS0tLS0tLS0NCj4gPg0KPiA+IC0gKiBTTVAgKGZvciB0aGUgQVNUMTAz
MCBDb3J0ZXgtTTRGKQ0KPiA+ICsgKiBTTVAgKGZvciB0aGUgQ29ydGV4LU00RikNCj4gPiAgICAq
IEludGVycnVwdCBDb250cm9sbGVyIChWSUMpDQo+ID4gICAgKiBUaW1lciBDb250cm9sbGVyDQo+
ID4gICAgKiBJMkMgQ29udHJvbGxlcg0KPiA+IEBAIC00OTIsNiArNDk0LDggQEAgTWlzc2luZyBk
ZXZpY2VzDQo+ID4gICAgKiBWaXJ0dWFsIFVBUlQNCj4gPiAgICAqIGVTUEkgQ29udHJvbGxlcg0K
PiA+ICAgICogSTNDIENvbnRyb2xsZXINCj4gPiArICogU01CdXMgRmlsdGVyIENvbnRyb2xsZXIN
Cj4gPiArICogUVNQSSBNb25pdG9yIENvbnRyb2xsZXINCj4gPg0KPiA+ICAgQm9vdCBvcHRpb25z
DQo+ID4gICAtLS0tLS0tLS0tLS0NCj4gPiBAQCAtNTAyLDkgKzUwNiwxMSBAQCBBU1BFRUQgR2l0
SHViIHJlbGVhc2UgcmVwb3NpdG9yeSA6DQo+ID4NCj4gPiAgICAgIGh0dHBzOi8vZ2l0aHViLmNv
bS9Bc3BlZWRUZWNoLUJNQy96ZXBoeXIvcmVsZWFzZXMNCj4gPg0KPiA+ICsgICBodHRwczovL2dp
dGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvYXNwZWVkLXplcGh5ci1wcm9qZWN0L3JlbGVhc2VzDQo+
ID4gKw0KPiANCj4gU2hvdWxkIHdlIGtlZXAgYSByZWZlcmVuY2UgdG8gYm90aCBVUkxzID8NCj4g
DQpXaWxsIHJlbW92ZSBpdC4NClRoYW5rcy1KYW1pbg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiAN
Cj4gDQo+ID4gICBUbyBib290IGEga2VybmVsIGRpcmVjdGx5IGZyb20gYSBaZXBoeXIgYnVpbGQg
dHJlZToNCj4gPg0KPiA+ICAgLi4gY29kZS1ibG9jazo6IGJhc2gNCj4gPg0KPiA+ICAgICAkIHFl
bXUtc3lzdGVtLWFybSAtTSBhc3QxMDMwLWV2YiAtbm9ncmFwaGljIFwNCj4gPiAtICAgICAgICAt
a2VybmVsIHplcGh5ci5lbGYNCj4gPiArICAgICAgICAta2VybmVsIHplcGh5ci5iaW4NCg0K

