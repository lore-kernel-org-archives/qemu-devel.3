Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A99C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 10:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA4hr-0001hx-Aa; Wed, 30 Apr 2025 06:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uA4hn-0001gU-M6; Wed, 30 Apr 2025 06:30:19 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uA4hk-0002yf-P1; Wed, 30 Apr 2025 06:30:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kG1r3fIu8LCVofHNRP3b0xVaiax/Ea1qxBznjv1uha+gUMP/oEsJhVgVknh42ZpW4mk5ZdY9S9hsEyWdrt7NxPS+MMy0UQvl2at1Vc64VmIfgU5eD4gq2YuzNax8qiVy4YhCDxGjqGayljVsh1r6vNK5DiRBPMnH1rGsQZs80oT897W9xOQ1P+//Xbsi6+sG8qknLIcHMYrILhQArVI76manxf4PRamsucROwaEYrugb76jhiUozbrBiwj1xcRlFpP0+lqvTbH0X5vAAxnOZQwkYkbIwuOMFJRbh0E7tj+nxrDkQc8RPrfqyu2NQHeT3V+K4X89jL/b5M2JU3p0SlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A96S4yKhuAIYQDoy5PtRrYWfmsoYVpJK9O+qW8vRrY=;
 b=XQdutuT0oJxwWQ/tJybLxkrg4LvsSeUTPrr5DFheMv7yGxVHqTtzNxEyK24FNgdgyMZfqoW+HoK/ztIgi9XlZYLuTYnXPtE5ufWxEn8E+sXkSmiS+FKTSuC0oO+px/JHTZZcQgc7thLa0YOAfYIS6MKY/nMak0u7Ijcjtnuve2eRjxanlXfMS6FnvnDFSJnkfY9C+JSxynpdXQP9SvSx9fv42M/8OP9kVCeJdRoixFf0zNdggxgoquIfv5kRyI/XbXB6aQiLAAI+0F5YiK9wHVaw/2iCguNCBJ6E1B7ZsRS5A0o2IjvsUEfsMcYXOPn3uR+eKEatvsOHZZIttHy8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A96S4yKhuAIYQDoy5PtRrYWfmsoYVpJK9O+qW8vRrY=;
 b=J2IYRAwTYK5AIHlQ0f7EtO5ua6YLJvr4cCOGe2SOGvFGwpu3gVOUUIy8HQ6fnjlIYsKYJfxVogBfcSOBo0A62hGuiL3AxopqC2EHNjdDKsE8wTca5AGMXGeommWDNxXmZYdLhyyscuPZDThEYn+vMH5u3aolpmYMfNKPzSlaQ3BtCz9OW1td5gSzWL5oLOysXc6v6xcKxxIvBfPuRagIe7ZOhGuzsoPdZ1Py4PPOCvxzG8S47JKmWNIn1eNAZRqy9JBS+j9TC4SVg1iGBFz5k1O4R1Qm2tMwbXdg9QDRomUEel40UjzOMlKuJVJ/6k/Xngu5Frav27WR4J9WiJk2qA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB5250.apcprd06.prod.outlook.com (2603:1096:400:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Wed, 30 Apr
 2025 10:30:06 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%4]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 10:30:05 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 3/3] hw/arm: Integrate Aspeed OTP memory into AST10x0
 and AST2600 SoCs
Thread-Topic: [PATCH v3 3/3] hw/arm: Integrate Aspeed OTP memory into AST10x0
 and AST2600 SoCs
Thread-Index: AQHbs/tcXU6vRffvC0+zacS0f0KZJ7O4ueyAgAALyLCAACv3AIAA6XjQgACIowCAAaRQwA==
Date: Wed, 30 Apr 2025 10:30:05 +0000
Message-ID: <SI6PR06MB7631CA6AA68535099796E989F7832@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250423025651.189702-1-kane_chen@aspeedtech.com>
 <20250423025651.189702-4-kane_chen@aspeedtech.com>
 <e3d35357-de8c-44da-b54e-7ec2761f513b@kaod.org>
 <SI6PR06MB76317C8FAC3EBF18AAF632ECF7812@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <2a85d0c5-0606-411d-b8c5-4b8806182384@kaod.org>
 <SI6PR06MB76310DFCE06AC5FB55CD3AE6F7802@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <683e0219-ad4f-40cc-b541-c533487ce8dd@kaod.org>
In-Reply-To: <683e0219-ad4f-40cc-b541-c533487ce8dd@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB5250:EE_
x-ms-office365-filtering-correlation-id: 04451f9d-397e-4cf6-0584-08dd87d1f948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NWxIWmNBRFl1UVprZnRBYXJ1d01nK0N5NkhWL2VKbkVsT0pTVHY4d1RSTmJy?=
 =?utf-8?B?QnFUV1o2dnNMTUZHOG9BeVZIQkRTZy85SnlEN2E2SkliUVFXL1AzVkVQS3FC?=
 =?utf-8?B?MmtyNDR2STJBTVRsM292UVR3eS9Ma25aa3NtVU5ueEZwT05SL3gwVmFQd2tD?=
 =?utf-8?B?YjlaSXpXMnI3NlRqVURQQU9FOTUvWFdPdWVpWGlaRjJQMi9TblJFcGhIS0M1?=
 =?utf-8?B?dTNsV2dHSWJZOWtsVFB4YXZ0U3RYV2twSmVUY2NyNzBKMTRLd0g4TXczT0M1?=
 =?utf-8?B?WFBMYjVMWEFiK2ZNclpRMjNDZ3gvOHl0NE1mb0VOb0dFcUl0ZmFhWVRHZkty?=
 =?utf-8?B?Z2srZEwzUmxobVJ0QlJxaTVycE9DT3dBaVFlcjZONFJNM1JmUTk0TEZiZVRi?=
 =?utf-8?B?TXJtUVJwcXJSd1VhWGNRZU5zbVJJVmNCM2x0NVhCbWc1ZGFTY0RnZWdEbklM?=
 =?utf-8?B?NnZBSndVdCtYaVZMZS9mcG1GUm5sVjFmYWdtODRSaEx1Vnh2SnRlV0NkNExE?=
 =?utf-8?B?ZGJOWHJnSklBZnErOFRhYVBINmR5cVpMREJTZGg1dzhQOFBmdWZYZW92Z3hQ?=
 =?utf-8?B?V3JZRmxEajJZWXQvS0ZJMnVISXJid2VTUHFheUcrWVV5aldqSjhjU1JTKzJF?=
 =?utf-8?B?cUpaUTkydEtYR0o3YURIQ2pIdzFOaHpvREJlUUVvT2x5QzZHVnBJNmwzNU84?=
 =?utf-8?B?TlV5c3VuWG9vbzZKcGhad2V6MkhKRHpUKzlFdnFWM1BObGJHa1dEUjVHZDlE?=
 =?utf-8?B?cXN0Q3Y0RFZHTnRsTFczUzgwRmRRdHNrdGwybmpsRUlPOXFYVEVLeWEycVh1?=
 =?utf-8?B?L29KcWJaZXFlVDlsQzlHZHdrR0xESnVJQzdtQWFTVG5tdysyRGovQmxYLzdq?=
 =?utf-8?B?SDVLbXVkZWNSbURDS0V2MlJpRlhDeE1xN3pGdi9ZMGNjN0JVSjU1S09BWDBw?=
 =?utf-8?B?RXJad3JPOWFTU3BTVTdCYTRESm5wQ0lvcm9oNWFoQmp2QUpXc1F2eUhweWM4?=
 =?utf-8?B?blhxS25iMDI0bk5UL2VaTHJHUlA0ck1taE9EWFFSRlRLVDBpamJDUTZmN01P?=
 =?utf-8?B?YXhNYUJ0R21JdlQwY3ZCWE1lNy91bXBDOCtlS1dTZnhjNWhOUGFXN3lFdTJw?=
 =?utf-8?B?NTB0ajhqQUk0eGhPdTFMbWhzQXNpd3ZjYWswb0NMeThIRHN3WDJWYks0ejVx?=
 =?utf-8?B?Smw0ZkcwT09KWEJiM2M0ODN4aW1zbWV1S0tPejlDMEZZejU4OTE5cW9QeWtj?=
 =?utf-8?B?NVE1b3hZVXpsMjRiZDZxazhIWHRteWtpRjBlOFZPT3pmd3RIbndzaHRlWHo4?=
 =?utf-8?B?SUJpR3BKaXBuWldUUkJ1cElWZmhQTUxJejVGSTlRVDVVNlNMQ2JjT1ZuU2J6?=
 =?utf-8?B?RWpvdDJUYUNSUytiYXlJZlBDeGVVcEJveDJiMzhhcldLMy9rcW1Sb3ZKdkJM?=
 =?utf-8?B?eCs1aU5sdFJ2MkU4c3Flekoza1hOSVAyNU90YldsQUpYcWltbTZla0J4ajJX?=
 =?utf-8?B?R0FIMlJmSUJpR05ySGFOTCtnS0VjN0hwTCtQLzlrekltdkVvYlVZM0thK2o2?=
 =?utf-8?B?bTMzWWhSUXR5M3IwUXFNMXNiVFk2TElyM09pNXVmc2dKM1Z3UXJReHp5bkZh?=
 =?utf-8?B?dTJoTjQyMWxRTCtScXBSMlBxeWtUejVhUDNQSmhHaEpSa0plTG5IUnptckxn?=
 =?utf-8?B?ZmJFaHJvek9pWDQycHNibXdhNU9kQUkyMENxRmplVDhRS1ZCWXF3akdwTHd5?=
 =?utf-8?B?RVRoWDBBYmVVT0ZHWVpWMlFyQTdoN1VBb3VDMU9ad1RJUXVzZHp6UGdhcFVO?=
 =?utf-8?B?c2djT0dFOElGTnFBUmpBQnJyTTFwYWVMTnZpMXk0YXBYUUNpWVVENmx4OXli?=
 =?utf-8?B?RUt4a1FFRHYwemxyY1lhY0Y0SHVvanNRdHd1dllRSkEvUGFNTXNnVk9XMEcz?=
 =?utf-8?B?TXdIV0hQT1dhS215L2dVRWQ4a21zdlhTVTdYTityRFowUVlpZ0NJUmp3NHd4?=
 =?utf-8?B?YmRuWmxtTVBBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1l0MzRPMVcwQnRleHpYSXZlUWxpL3hpeTZaajlNak0yRGgvQk1DRm9DbW80?=
 =?utf-8?B?OWowdTZTVUNLU1U4dkVyTGNUSlN6L2lkK09YQkpBQVFRRDBDcHp4c3FielRq?=
 =?utf-8?B?RVpoSlNPWTRuR3FyRVpVNjlSR25uTU9oZlJHVE1hcVlVU0s3ZGZvMEc3VTJZ?=
 =?utf-8?B?d2dkWjlMT1U0SW1iZXQ5R2NOWkxRMnFEenhBZEMyT25lWk1pQ0w2TCtYZHFB?=
 =?utf-8?B?amhSZ2VDd0l5OS9neGNPZ21DUDdOR1pZMUo2Tm9icDB2dmRvRXRIK09Ja1RV?=
 =?utf-8?B?NmJjQWxtdkJKNTNZaTRUYWxlY09ZL3A3V1cvNlgreVBlM042SDhDYzYxb2pq?=
 =?utf-8?B?WW9Sb0w0UmFtZE1JUjdidWtOZExjTTNjNms5K3h1NHg3aTBVY3h0Q2FaYWxT?=
 =?utf-8?B?ZTZKblhabkQ2YnVBNFJzM1I4VWdsV29ndEdXbDIrRTJSQ25kZCtxRVpOdExs?=
 =?utf-8?B?WWY3ZUhnRVpvNUQzOFFzQWQyYzEwMU9pK1N1MXU1TTRJQ2YzWlBzWTZUL1Fo?=
 =?utf-8?B?SjlFZ1JiRGx5dXJ4NWVqOGlwVkd0b2RsbTFvN3ZONVdqUithRXZLM1pKeW9x?=
 =?utf-8?B?alhuWFdldG03ZkVydDB5SkpJeEZDNGRNekE0dVZ6QVpWOUwyQUpxMlk2bW0w?=
 =?utf-8?B?aG9MZjJLR05ta3lJNGtiQnJ0MEhmVzN5dUlCRUZFeGR1VDQ0a3FtVHhKWWpB?=
 =?utf-8?B?N1l3SHFJTDhOeml5Qkt3c3psNEVaMGRabk5BS1VIeHdhbTl6SnpGYzk3KzNX?=
 =?utf-8?B?SzNCNWNUUlAyTXpBZ012dkhDREQyazBXcU93WXAvSDQyNGRVcTcrTkpaZnF6?=
 =?utf-8?B?VTUvR3d0dndPYktRRnIrME54UDRzVld3Mi9hVGFLcHVIUGlWeFJCT3NuejVK?=
 =?utf-8?B?T1RDeGxSSm56TFhsUUc5ZGV3UmZmNSs4RUs3ZmVvUHRiWVlhWDJ0SWVSdVc5?=
 =?utf-8?B?WXV2ZnFzRHZGZ25VaWtua2dkeFk0TjI5UFBDS29XUmpnMVRXU1VSUll6VWpR?=
 =?utf-8?B?UjFGTXhibUFJdmwwMERTSWN2WS9RdkNVZGZ5SlF1YytpZWRsZFdpYXFjcC9h?=
 =?utf-8?B?K2pQbFR0T3E0K24wK2Z0cTJwbkUvd21hQkFzZXZDSmtjOGRhMDRtNHNFK2VK?=
 =?utf-8?B?QTBiWGdNZW5vM250MXJTWjYxVjZjU0s1RVQ5eVM0TGk0YzBwaTlIV3RES29M?=
 =?utf-8?B?Qms5dFBhTkJkWW1UeDRVck1PRTJYbUx5aDczRDBENHc3K3ZwMG9xS09xcUF6?=
 =?utf-8?B?UDVpQ1hxeEFQSEpmcURja3VqSUhxMy9IVmVocHByNXRKM3J3QzBGZmJQYm5U?=
 =?utf-8?B?MFpQcUVTWHRsZnpQb1ViZFIvaFhqaGtadzhLUHphaWFJajZnbmpra0o4MW0x?=
 =?utf-8?B?MTJYNXo2UXhRUVpQTWZtaW9NRUNOaUZIL0ZEVUJEZVJ6dWcwT1JoL3UyTFl6?=
 =?utf-8?B?cTJLelpEeFFjcmgxd1UvWDlRdGs2czJiMG9jdEE2WFRFZFhyanM1NXZEbWls?=
 =?utf-8?B?cVNDUjNSVGgxRmhmNHhtbW1ndVpENjhoWWJRcCtyVkl1SnB4UjYwZDRBenky?=
 =?utf-8?B?ZGEzMkFPQ2dmQStGei9OQTNEUG94amlOTjBWVDdBbHg3NHlnaVdsb1BBVTZQ?=
 =?utf-8?B?VEdSYlp1dldrZjRKaC9LVE5rRTgyUFUwN2tGU21pWmJwWnI5Si9mdE9TTGJi?=
 =?utf-8?B?UDlPVFFqRmhjbFpORmtLVmp1UklHZ0dEV1VpYlZGS2VSbE5TTjBYL2hDM1lk?=
 =?utf-8?B?NVYxaXJpUzVuZFVIRDNMZVBqbHRwZXdaRnRLN0VJR3pYN3Q5eDI2S3Z4OUg0?=
 =?utf-8?B?emQ1dkNKc3h0NVdaSWpGRkw5YXVOajdiRXliV0NlR3VReWE3VHdUUDhhTHZG?=
 =?utf-8?B?dldLaGJnQ01TaisvcGxPTFE5c1JRemRScVUveW5YbnRxL3JPbnFOSzQ2ZVMr?=
 =?utf-8?B?WlhPQWxaMFRvYW1UTHU2bWNnT0RmV0hRQ1JSYzVJVFZ6U2RmNnpPVjhwS0p4?=
 =?utf-8?B?d2hiL2JaaDdobzZuKzVSS1dZMmtJUnpIcjZDY1JKYk15ODYwWmtoZ0xKV2xM?=
 =?utf-8?B?RWpzKytVVE9ITmcxeVdtUU5ER05oK0c4dHlMSnk1bGt5TWlRdURVcUlxWGNL?=
 =?utf-8?Q?uNpcG4NgduBmkJbxbmASe3DIy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04451f9d-397e-4cf6-0584-08dd87d1f948
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 10:30:05.6613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kUo6NLQMy4O1vVqZMP2UPgr1fk/yhPDKmgOMEn6SfApSwXAonLUf/3AULVQCcj4BjE88hYiv/yt+KHcnlGXsbISOr36Xay2IlCjg+NbAOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5250
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KQ3VycmVudGx5LCB0aGUgT1RQIG1lbW9yeSBpcyBub3Qgc3VwcG9ydGVk
LCBidXQgdGhlIGd1ZXN0IGZpcm13YXJlDQpzdGlsbCBhdHRlbXB0cyB0byBhY2Nlc3MgaXQsIGV2
ZW4gdGhvdWdoIG5vIGZ1bmN0aW9uYWxpdHkgaXMNCmF2YWlsYWJsZS4NCg0KVG8gaGFuZGxlIHRo
aXMgY2FzZSwgSSB3aWxsIHNpbGVudGx5IGRpc2NhcmQgdGhvc2Ugb3BlcmF0aW9ucyB3aGVuIG5v
DQpiYWNrZW5kIGlzIHByZXNlbnQsIHNvIHRoYXQgdGhlIG1hY2hpbmUgY2FuIHN0aWxsIGJvb3Qg
YW5kIHJ1biB3aXRob3V0DQplcnJvci4NCg0KSWYgeW91IHdvdWxkIHByZWZlciB0byBoYXZlIGEg
bWVzc2FnZSBsb2dnZWQsIHBsZWFzZSBsZXQgbWUga25vdy4NCg0KQmVzdCBSZWdhcmRzLA0KS2Fu
ZQ0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAyOSwgMjAyNSA1OjA2IFBN
DQo+IFRvOiBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRl
bGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVA
YXNwZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdA
Y29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Bl
bg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFs
bCBwYXRjaGVzIENDIGhlcmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kg
TGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAz
LzNdIGh3L2FybTogSW50ZWdyYXRlIEFzcGVlZCBPVFAgbWVtb3J5IGludG8NCj4gQVNUMTB4MCBh
bmQgQVNUMjYwMCBTb0NzDQo+IA0KPiBIZWxsbyBLYW5lLA0KPiANCj4gWyAuLi4gXQ0KPiANCj4g
PiBUaGUgU2VjdXJlIEJvb3QgQ29udHJvbGxlciAoU0JDKSBpbmNsdWRlcyBzb21lIGNvbXBvbmVu
dHMgbGlrZSBPVFANCj4gPiBtZW1vcnksIGNyeXB0byBlbmdpbmUsIGJvb3QgY29udHJvbGxlciwg
YW5kIHNvIG9uLiBBbGwgY29tcG9uZW50cw0KPiA+IHdpdGhpbiB0aGUgU0JDIGFyZSBmaXhlZCBh
bmQgY2Fubm90IGJlIGNoYW5nZWQuIElmIHdlIGFsbG93IGFuIG90cG1lbQ0KPiA+IG1hY2hpbmUg
b3B0aW9uLCBpdCBtYXkgaW1wbHkgdGhhdCBkaWZmZXJlbnQgdHlwZXMgb3Igc2l6ZXMgb2YgT1RQ
DQo+ID4gbWVtb3J5IG1vZGVscyBhcmUgc3VwcG9ydGVkLCBzdWNoIGFzOg0KPiA+DQo+ID4gKiBE
aWZmZXJlbnQgc2l6ZTogLU0gYXN0MjYwMC1ldmIsb3RwbWVtPW90cG1lbS02NGstZHJpdmUNCj4g
PiAqIERpZmZlcmVudCBtb2RlbDogLU0gYXN0MjYwMC1ldmIsb3RwbWVtPWZsYXNoLWRyaXZlDQo+
IA0KPiBUaGUgb3B0bWVtIG1vZGVsIHNob3VsZCBjaGVjayB0aGUgc2l6ZSBhbmQgZmFpbCB0byBy
ZWFsaXplIGluIHRoYXQgY2FzZS4gVGhpcw0KPiB3b3VsZCBzdG9wIHRoZSBtYWNoaW5lIGJlZm9y
ZSByZXNldC4gVGhpcyBpcyBhIGNvbW1vbiBwYXR0ZXJuIGluIFFFTVUuIFNlZQ0KPiBtMjVwODBf
cmVhbGl6ZSgpLg0KPiANCj4gQWxzbywgSSB0aGluayB3ZSB3b3VsZCBsaWtlIHRoZSBtYWNoaW5l
IHRvIHN0YXJ0IGV2ZW4gaWYgdGhlcmUgaXMgbm8gYmxvY2sNCj4gYmFja2VuZC4gUGxlYXNlIGNo
ZWNrIGhvdyBtMjVwODAgbW9kZWxzIHRoYXQgYmVoYXZpb3IuDQo+IA0KPiBUaGFua3MsDQo+IA0K
PiBDLg0KDQo=

