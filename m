Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBB5C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 01:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vheFx-0001Y6-MG; Sun, 18 Jan 2026 20:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vheFo-0001UP-0y
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:40:29 -0500
Received: from mail-koreacentralazon11023115.outbound.protection.outlook.com
 ([40.107.44.115] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vheFk-0006m7-1S
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:40:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALNR4HK3994gp5Lo/ieuk1vPWGSgNN/sWuOrbqls/2lcR4CNVD60w6cpJ8YWS16vTZ6Hs9LRE8z2Lfnw8EQ8WAxvsELXBz4n0hm/PNhHrXttZfu/ND6FUcnlffq89HJ7Q6FZEvk9QskAOM9JMSDjCxmi7x8LMEx/zj0bGgbXATs1bZC72kY6mNQjO5D/AFEpsaX0APtHvCx+1LIPyvTkKUFLgOrXRyKeBgHasBh8mZbbGW9NfPOegemj7A45X+Exd1YbGKTLe3QbdqdMo3AG9w7BK5BsKBmnNxn3C54A+cTCfFZiml/FWjl2Gqov6VN3/9rHqv+q+P8x8jVIt71vrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAjq7BOQohb9mN5XgIqBWXdWd8fEuFdGfAVgq5Ov25U=;
 b=tZRXz2v7eIrH9HHGfcqDxYULijWIS0AQ2kcg35mako83yz2n+9Ayg/MBXjiOYTpZ1+/d/p9LifDks5kG7V4I4922iFnnAxBezz45e1mmUqme0raPzRPLzk4kRPEAEDDSm2h+vf9uFhjQEo2FVsmoXKeorskMrKyInWkPs/EBiaf18YRrCNco1jhpJdWnVN+AhrEC0i25iE7XgazJf7sBKnHlprWPA9wshUJ7CrJ0ahleclC3fewdM59Vz9F9og0OpZ3+wLfEpdEXQccYD7apsXT5FTM6LkU9s2xSl1GKOMQhPE6S+B0V7CERsCHdBEPc6Y3U6wGTl+zL6JjvPjAt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAjq7BOQohb9mN5XgIqBWXdWd8fEuFdGfAVgq5Ov25U=;
 b=FLswGmir6zhCEbhLOpa5IMgeONxKLQXMIQvwSZZa9LpTRQflhwHOcdvhezb8cCrCoJo/XIYr6lEM3EdJA31MYgdh5THTIIxnexGzhpIZX7kEUYfQBFJfTWvM2jPf/dWcYMkF0RIZLl6bDRTnTMXz/gffynlcbC8/Fy7g53CHQJlob4t7tbtKj57/b0bfZInKboXEILT5zQCUe27W+nuCQq98UdPLhzsyBfgDxdH0yza43ewmid8srcLJiD32sR8NT0aq+nHmME0QmLKh/z1bWy5DpiQz+86bD1C72d9qB6PBAQeP2Y6WQu3Klw3Q+Hs4Dn4oUiEjWRmSg76Jh7mVQg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6323.apcprd06.prod.outlook.com (2603:1096:820:e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 01:35:13 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 01:35:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Michael Tokarev <mjt@tls.msk.ru>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>
Subject: RE: [PULL 0/3] Update vbootrom image to commit 1c8e9510b22c
Thread-Topic: [PULL 0/3] Update vbootrom image to commit 1c8e9510b22c
Thread-Index: AQHchrn9D+vfYwM4mk6SyACbYX4WXrVUoqKAgAQSGeA=
Date: Mon, 19 Jan 2026 01:35:12 +0000
Message-ID: <TYPPR06MB82061980D169464392781CC9FC88A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260116073024.3485812-1-jamin_lin@aspeedtech.com>
 <ce304e18-b28c-4a85-a765-4a3f2680901e@tls.msk.ru>
In-Reply-To: <ce304e18-b28c-4a85-a765-4a3f2680901e@tls.msk.ru>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6323:EE_
x-ms-office365-filtering-correlation-id: 3269159e-9003-4476-cbc0-08de56fafd84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NzN2c3dBbkdURGlVb21URHRlV1FjWmpNL21YbW53L1Q5QlZUd0xzb0R4eHds?=
 =?utf-8?B?ZXlucUJvdS8ycFpnMnhrV2RzR1BFdVozY0NVTXdPSEJnRDg1WWhtUEV0Vm4y?=
 =?utf-8?B?YzZOVEF1d3JoL2VlSU9yRDl5Kzc1N3JFUE5YZHF3cVdMZGUzQVRFRUNodWpn?=
 =?utf-8?B?Q3pQUlIxUXJUREVYMEYyL3F6NGZPdXZKN1NpRzFlQUQwQVgvOUxkSDFiRHdh?=
 =?utf-8?B?ckcxR0hOMVVCUGRldFM1aXhvSCtOdU05Ujg4dXB4NmZYQnpUbUcvMFFJSWJn?=
 =?utf-8?B?QXpzWk9YU2NCY1Q2S2tzT2hHbWpZVk01WVk3b1Viby9CRVNXa3BWSHc1QXAz?=
 =?utf-8?B?YmFrL1FIUTkrbkp5R2FTN3BXOHRncnNEQ25ncThCZ3d2b2hIMlFDcUNHeVdL?=
 =?utf-8?B?UU51VU53NG9oczdpLzlVZTdXemRIb29NS2VCMXJhKzkvclBueW85U2psT0hx?=
 =?utf-8?B?RWFJMU5JT3pFaktrcTFRRXhKRkkzSmVvRDJlK08vLzAxK1ZjOWIrekZUV1JJ?=
 =?utf-8?B?L2dlcEVETU05QTQrWStXS3drNExMNFJ4aEFFREZoemlnZEdjRG1oUFJLbkpD?=
 =?utf-8?B?aFVFYWJWTUtqUDNPTC9HZG4yS2FXdU9XcDc4TXVLd0V2NkR0Y2MwSHdoUW50?=
 =?utf-8?B?L084MGxYVUx4Q3lncGFGTlNwYnlwN3VLYkNycHltd21xaE5RNmpCNWpjMk1S?=
 =?utf-8?B?SS80K1JTeGN0MnlLdWRUSnZ4Rk5VUjBhbDk2Nm1UWUpIcHlnOHhnTHFPa1pO?=
 =?utf-8?B?Q3IrUnR2UXFDTkdMM3l6OVJmS2dsSWxZL3J1NVg2c3FJY216K3NKdmVEallE?=
 =?utf-8?B?V3hDYm9saldIL2FWdUZsZUdpRzlFc2psUW1JNHJGZzVPa29sVHZrUU1IY0dq?=
 =?utf-8?B?SldqUHJUbHk3WUtHNzRkVnFHbHN5MEFNckNCYUhDTVNCbWkxeVlVQ3h6UUVt?=
 =?utf-8?B?QUxWMEQ3ZU1nZmFna2FMMy9PMkdVbitMSTJEb3o2cWpaYVZBYWwvREpZSS90?=
 =?utf-8?B?RHBTUFpqSjhXYmY4WGh3VHhXc2hFTW9ydG9zYW50bmF4TVl4cHl4Rllud3h0?=
 =?utf-8?B?UVlzUGVzNGdiUjdNUzRqa3ZFUUY5elNheTkreFB4b3NtNVFadGxIMjB4dUUx?=
 =?utf-8?B?UnRXTHFmMTgzWGJMMERkMmo1MDNVd2VkbWJpWEFCVEZLdkY5czljcHNRL1RJ?=
 =?utf-8?B?UllzZXR6U3R5cXFyb05zRUxyek45eExwUDZNaTRweWRrcC9HMnBiaW83Z3l1?=
 =?utf-8?B?cUNmTGU3cVF3ekk0dVhnVy9SMjVmOXo3eVV1NFNhYUN0RVFkdnlWSDVSa0VQ?=
 =?utf-8?B?WWlGeG1BLzM4N25uZ05BZVh5NmZQcWF5Z3o3WFppV1krSXpiZzFLdEE3czYw?=
 =?utf-8?B?VDU5RXB0ZDM5OG1XenNkVTY1dCtoZ3ZGaUlnRjZwcmxOcW1QZ21BUllCMFlo?=
 =?utf-8?B?cmNBb2gvbHBxSWREV3BZczE3YVhhY0hwZ1B1YU8yM0hWZnczUmx1N0NXZ2hS?=
 =?utf-8?B?czFaTDlOVWFwNVhKR2dZcXREUlNDK0tLVVFyRkJ2cnd2NkNvSEJtVDI1ZXdC?=
 =?utf-8?B?WmZ3N2JjdmxlTEVhZXMxNWtyaG9uUWZZT1lROHBtQmlhR3Q2TU9BY3B3enNG?=
 =?utf-8?B?a29Pc0IzTFV3azZURDltTVlNWUpBc29sNkFwK2dZWXZTcVJScitQcGdwcHZq?=
 =?utf-8?B?VkdMR0FabG9XdUN5aEU5MUZ0QkVWUmR1Q0lSeFc5dW5MZC92ck5QNWpvYTQy?=
 =?utf-8?B?eTA2U0oraU41ZFRlZExEVGFMRC91TnhwOGM0ZVp2UElqOVVSRjNJQzdpb08x?=
 =?utf-8?B?eHl5NXI1VWhrRHk2ZmNKU3BUMXlXOFJRN3pITjI5bklNQVBIZysrcWxBSG8x?=
 =?utf-8?B?d1psdE9DdTRuQTVsNDhGTUhNaGkzbjYvSXFUNVZ2L0RqNFg1U0hvNGFMVUJi?=
 =?utf-8?B?WWhQRHc3NllQNXpCT0cwZkVydkZtR2Q0WGdBSk1EUUJDNDNiK25selFDditx?=
 =?utf-8?B?ai9vdTdRSTR5K0h3NmtsYjYzbHh5aGNlekM4blpZSC9lVTJveGl3ZWxZQ1Q1?=
 =?utf-8?B?c3g1azY5M2hWQ2ZTSDlKSDU1NGUrT3hqUlhVU2twQjQ4dXVMTitDOFI0VGtC?=
 =?utf-8?B?Q2NCdTNSZlpnd1NESFBCVFAraGl1ZHVVQnhoN2tkbUNUUFNCWGRmMlVBVUdZ?=
 =?utf-8?Q?RV/i9NZbQ0Ptw2Tns8JRixQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzI5TWtseFhSZUJnelAvcnZ5aFBreXFlZ2krUS9iclVRQzJlZ3FPbG1tUUZk?=
 =?utf-8?B?SitYZWwvUWExcDFGbWZZK1pzMlMyYkEvM1VXb1pBdnNsMkp1RlBlSHczZTVB?=
 =?utf-8?B?U254SG5pbVdzNnFoVnNVeEhjditXMUhsS3Y2YXhJU1l2YXE3NmdpS2ZTRXh3?=
 =?utf-8?B?S09ZRXJWdlRhYUU4aTdReWFvTFhxbHgrZlZURVIxNytDalVMcXk0S2lpdDVT?=
 =?utf-8?B?djU0bXdlaGtwc1hxTFFha24wYkk1YkRzaDJNOWFnb2JCRDVNOWZxdVI1UlUz?=
 =?utf-8?B?eTZJcFZzNmYxNGFVbG9DZWlranE0UkZRQkJ6czEyVndFMDZFeG1hbDg1eW9J?=
 =?utf-8?B?TVgvaXc4NFZYYjViSHR1WE1KVWZZV1I5ckZSc21vZG10TTlTak42dkRjYnVj?=
 =?utf-8?B?aXo4a3dNUmRrZ3VwdnIwSDZaUnk3ZTZNZGlJTHBEdjV5S3pHSitBbkUzTDBP?=
 =?utf-8?B?bUMvd3JsZFVybWYyYW1mWmVLcVFHZUNKZEt3OGVzbm9TMTJnNmNIK2NrWEJx?=
 =?utf-8?B?VXU5UW1tSFo5bUx0cGxlRnJiNkhCQUYwaG9jUE44QyswTklGT3JQVjNlODdF?=
 =?utf-8?B?YU5lTzhPY2lVakNWVGpaK3VKZ3g0QjQ4eWY0MU1jWldLMHVZbmFiaCtOVUMy?=
 =?utf-8?B?eE42Q2pOeENad21ockdkRkZCeldvR2o4UmN2eVdzL0lHUWhGNmQyUld3U0xE?=
 =?utf-8?B?WjRTbDRsZzE1Q2RHdXdZZ3Q2dEpZTWN3MnFvQXcxOEViakVncHJmZlEzaU5s?=
 =?utf-8?B?Wi8rOVg4d3VFTWg2UFNORFFmNmxsTFVjOTBsNW50UVNwZUZkZDhXVHlxS1ND?=
 =?utf-8?B?ZFg1Z0s0emRvREhoV2lwVE8yNEN1VlBUZENjQk5kSUlEeHZmUmk0RlpQelRF?=
 =?utf-8?B?VkxUeW5PVU1aUStyZUZ4UjZaMHBST2tOc2dqM0pGdk9pdGZjbHNWSlNPS3BB?=
 =?utf-8?B?cDNvZ285WXExa1BZSlNYblkrd0pUSkFrSk50aDBzQVZteEM2REc2K2I0N0R1?=
 =?utf-8?B?alZGblBPclhNdTNnOXlSeURjbDY3bXViUnphMmJ6VkdMaHYwK2U1WWQ0WVV3?=
 =?utf-8?B?b3pMZS9GUUo3V2RZZnRtNEpSV3RoYVhJNkhJNjYrU1Y0Q3lFdkhCZXp1VkFK?=
 =?utf-8?B?VzdMdGpHcFlmaWJMRE9aVFc2a1gwS01EMDdvaWtLbVdzRDM2SGFWNUpNYXcx?=
 =?utf-8?B?VW9xR0RsQTFHeWFJUGlvMUhCMm50bXJZaTZlZ1F4VHdsc0dtRy9FWDVJUDlW?=
 =?utf-8?B?S3pFOHJqeEx6b3JQVTB4QkpUb25TTGkvNCtDUEY1VHVFZmdNRUpiTHpsaG1T?=
 =?utf-8?B?cnpaaU5EWHhsQmlzM2Zrc1F5TUVKeVhKZmRNb1hZSTZOTmF3WEpKS0lnQU9T?=
 =?utf-8?B?dFl2UGE1aVU0Tnl2U3VkR2p5TXBHNjdzOUIwVDdWc3hvakpEcVQ4T2g0eng1?=
 =?utf-8?B?b1YrMzRhYloxekFGTTU4bTZMT0toZzB1SUdxME5VcjdTSmxmRW5VaEtYT1VG?=
 =?utf-8?B?NTJpNUlJRDJrbC9QSVZ2bWk0QTBUc1M3aUZFbFlDdy9KT3ppbk9XS1ZGZ1g0?=
 =?utf-8?B?SVFCVlJBcjM5SVlZOGJBQkZEU2RCczJnZ25qU1RyTC9EL3BPaHB2Z2lGRHhD?=
 =?utf-8?B?OWYrb3pCUDRDaW91OVYwVFdZWEJmY2ZUNmFlaEJ5L1ZDOVMzVjZmcDBzTWtn?=
 =?utf-8?B?KzRBWGhhRko1YUgvQnBPL0xOMzM0TXdzbDZ1Z2V2b0Y0eUQ1TitTaEpBd0xo?=
 =?utf-8?B?R1cxYjJrWGM0QkNIR0dLZFQxUCtZK1U2Nm93b01zWGpmdnpSR3BiT0tLYy9o?=
 =?utf-8?B?MEFOWDhEbk5SQndkTzdNL3FOTU1TR0g1TnBHQXBvLzN1VFRsWUFtR2twZWtm?=
 =?utf-8?B?Nmd6UHU2RHhRY3lmOVQ1QWIvSStYR0dqeWErNjlBL0lHY1EyeXhsWkZQc2ZK?=
 =?utf-8?B?a1VydFBubWN5UCtwL1ZyQzZmSTJLRHZrLzBEaHhRQ2swai9zTk9LQTZ4UTA2?=
 =?utf-8?B?QVlVcG5ZeFhMT1dMc1hETHNlM3dyU0M1YlRYS0tqa2pLWkxDUHQ1VytMekNT?=
 =?utf-8?B?aWFjUzVLNkNHVnpoWW5uOHJROElBV1hXMGsrLzd0ZGFWbUdxTHdDOVNDdXVI?=
 =?utf-8?B?RWFQZnc4czhvcmZsSkVmeTFVc3FlVHBoMjRHcHVxeURuTmVyR2ZvMC9HcVJ2?=
 =?utf-8?B?Uy9TRDB0WjJoV0hZcFh6NlE1d1hwRG9wM1pQS2phTEhqcU5jV2Flb0RINEZl?=
 =?utf-8?B?UjNCWVZZbnUvWGh2dkJ6V1NzZ1EwUjQzZFdob3dKbldvVHZna21zSEJSUWhO?=
 =?utf-8?B?Wk1UbmNqeGdyUUJCWDNlRnp6NFR2MHp2TmljMksrcW9uVWJMeFd1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3269159e-9003-4476-cbc0-08de56fafd84
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 01:35:12.8147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZn+ke5frY/NV5AAWKhv4fXgBrewzIou++wPdXHaS2R257fNgzW4OFbds4WqsP2u+44YAIn0UuKcGADIbemd6Ws3gXYG6X6y5usoKj0xgMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6323
Received-SPF: pass client-ip=40.107.44.115;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

KyBDZWRyaWMNCg0KSGkgTWljaGFlbCwNCg0KPiBTdWJqZWN0OiBSZTogW1BVTEwgMC8zXSBVcGRh
dGUgdmJvb3Ryb20gaW1hZ2UgdG8gY29tbWl0IDFjOGU5NTEwYjIyYw0KPiANCj4gT24gMS8xNi8y
NiAxMDozMCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiB2Ym9vdHJvbSB1cGRh
dGUgcHVsbCByZXF1ZXN0DQo+ID4NCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiBIaSBKYW1pbiENCj4gDQo+
IEkndmUgYmVjb21lIGN1cmlvdXMuDQo+IA0KPiBZb3Ugc2VudCBhIHB1bGwgcmVxdWVzdCAoYW5k
IHNlY29uZCBvbmUpLCBsaXN0aW5nIG11bHRpcGxlIHBlb3BsZSBpbiBUbzogYW5kIENjOg0KPiBm
aWVsZHMuICBVc3VhbGx5LCB0aGlzIGlzIGRvbmUgd2hlbiB5b3UncmUgc2VuZGluZyBhIHBhdGNo
IHNlcmllcyBmb3IgcmV2aWV3Lg0KPiBGb3IgYSBwdWxsIHJlcXVlc3QsIHVzdWFsbHkgaXQncyBl
bm91Z2ggdG8gbGlzdCBxZW11LWRldmVsQG5vbmdudS5vcmcgaW4gdGhlIFRvOg0KPiBmaWVsZCwg
YW5kIG1heWJlIHRoZSBjdXJyZW50IHBlcnNvbiB3aG8ncyBtYW5hZ2luZyB0aGUgbWFzdGVyIGJy
YW5jaCwgd2hvJ3MNCj4gbWVyZ2luZyB0aGUgcHVsbCByZXF1ZXN0cy4gIExpc3RpbmcgbXVsdGlw
bGUgcGVvcGxlIGZvciB0aGUgcHVsbCByZXF1ZXN0IG1ha2VzDQo+IG5vdCBtdWNoIHNlbnNlLCBz
aW5jZSBhIHB1bGxyZXEgaXMgc29tZXRoaW5nIHdoaWNoIGlzIChhbG1vc3QpIGNhc3QgaW4gc3Rv
bmUNCj4gYWxyZWFkeSwgaXQgaXMgYmVpbmcgbWVyZ2VkIGFzLWlzLCB0aGVyZSdzIG5vIHdheSB0
byBjb21tZW50IG9uIGl0IG9yIHRvIG1vZGlmeQ0KPiBpdCAtIHNpbmNlIHRoZSB3aG9sZSBwdWxs
IHJlcXVlc3QgaXMgYmVpbmcgYXBwbGllZCB0byB0aGUgbWFzdGVyIGJyYW5jaCBhcy1pcy4NCj4g
DQpHb3QgaXQsIHRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uDQpUaGlzIGlzIG15IGZpcnN0
IHRpbWUgc2VuZGluZyBhIHB1bGwgcmVxdWVzdCwgc28gSeKAmW0gc3RpbGwgbGVhcm5pbmcgdGhl
IFFFTVUgUFIgd29ya2Zsb3cuDQpUaGFuayB5b3UgZm9yIHBvaW50aW5nIHRoaXMgb3V0Lg0KDQpJ
IGNyZWF0ZWQgdGhpcyBwdWxsIHJlcXVlc3QgYmVjYXVzZSBpdCB1cGRhdGVzIHRoZSBwcmUtYnVp
bHQgVkJPT1RST00gaW1hZ2UuDQpUaGUgcGF0Y2ggc2l6ZSBpcyBxdWl0ZSBsYXJnZSwgYW5kIGJv
dGggbXkgbWFpbnRhaW5lciBhbmQgcmV2aWV3ZXIgKENlZHJpYykgc3VnZ2VzdGVkIHRoYXQgSSBz
dWJtaXQgaXQgYXMgYSBwdWxsIHJlcXVlc3QgaW5zdGVhZCBvZiBhIHJlZ3VsYXIgcGF0Y2ggc2Vy
aWVzLg0KU2luY2UgSSB1bmRlcnN0b29kIHRoYXQgdGhlIHB1bGwgcmVxdWVzdCBzdGlsbCBuZWVk
cyB0byBiZSByZXZpZXdlZCwgSSB1c2VkIGdpdCBzZW5kLWVtYWlsIHRvZ2V0aGVyIHdpdGggZ2V0
X21haW50YWluZXIucGwgdG8gaW5jbHVkZSB0aGUgcmVsZXZhbnQgbWFpbnRhaW5lcnMgYW5kIHJl
dmlld2Vycy4NCg0KZ2l0IHNlbmQtZW1haWwgLWNjIGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbSAt
Y2MgdHJveV9sZWVAYXNwZWVkdGVjaC5jb20gLWNjIGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbSAt
LXRvLWNtZCAiLi9zY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIC4uL3YzLXBhdGNoLyoucGF0Y2gi
DQoNCj4gQW5kIGFub3RoZXIgcXVlc3Rpb24gaXMgd2h5IGRpZCB5b3UgYWRkIG15IGFkZHJlc3Mg
dG8gdGhlIGxpc3Qgb2YgcmVjaXBpZW50cz8NCj4gSXMgaXQgZm9yIG1lIHRvIHJldmlldyB0aGUg
Y2hhbmdlcywgb3IgdG8gcGljayB0aGVtIHVwIHRocm91Z2ggcWVtdS10cml2aWFsIHRyZWUNCj4g
KGluIHdoaWNoIGNhc2UgaXQgc2hvdWxkbid0IGJlIHB1bGwgcmVxdWVzdCksIG9yIHRvIHBpY2sg
aXQgdXAgZm9yIHFlbXUtc3RhYmxlPw0KPiANCg0KDQpJIGFkZGVkIHlvdXIgYWRkcmVzcyBiZWNh
dXNlIGl0IHdhcyBhdXRvbWF0aWNhbGx5IGluY2x1ZGVkIGJ5IGdldF9tYWludGFpbmVyLnBsLg0K
VGhpcyBwdWxsIHJlcXVlc3QgaXMgaW50ZW5kZWQgZm9yIHRoZSBtYXN0ZXIgYnJhbmNoIG9ubHku
DQoNClRoYW5rcy1KYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IC9tanQNCg0K

