Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B51CE83EE4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8z-00062e-Jd; Wed, 04 Feb 2026 02:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZK-0004dS-B0; Wed, 04 Feb 2026 01:40:54 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZH-0004HR-MB; Wed, 04 Feb 2026 01:40:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfzjgJ1QPyhQFloFyNw38aJ8mYR+rS7/U31SESk+almB2/jTdDS1p23PcWFfguBNpQ5RYZJZmRhmPTBpdqm0zOJ1M6fa940OtKKtFL/S6RjkcdQeSs0LT1U2YURcqd9rBc5X2sbmLiVYDvZE5TxnhD+lM/QdU1k/LxFI+oleqapcgRINfYeT7BivWf5JdiJ8rOhRjH5Kbvco8pExPglHildZ9DZtgVqb5uCH4eazy+CF/pFZId9WCx//XXTwbOEnyLogclqR+VvHlzHeo2LCaUYQ76aJn4od/CBtbz+ETidUPzBvC5IziHHd3gCnHel/EDQ/FS/1KHm+AuC9JQ3vGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dFDxrN+3crO7fDKASYayAUGE+YGgyYOWupcdjzMmog=;
 b=LJtMHbJgXDGUPwbxJ0m62JzIW7qIH7JG7h6etjH2x9CBkOsHBertu2PARkg2ivROWvySzV3yW1WF09t0RvEhQM+C2vuT3zZAlSZ7NGDzMNbDY9dCQqyzGCRrzBH1vKQnugN8YtzOjG1Ym21AqqtsPX2SCJnBFLangUjyiOzuYI2XO2wTifyuhrXvf13lJkeZ+zQUO+GXRmR1ynbNhilFvdbQZRj40Zy+bRHnMVQFqgbKR2Td7VZrcJvN0DQD9Xq53YM+eBvD/PH4JWRtNwwEu0ZrPTpUVXsCkirKrvqOrJzce4N7CnWBzP+5UAbOYgTPJCouJ8li180V/7aCNj8zog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dFDxrN+3crO7fDKASYayAUGE+YGgyYOWupcdjzMmog=;
 b=TBmYvhlREJCJrytkIZXXc9xekjCpo1BndbiJ2OwYS/I1p4oDxPx4gD0yraTtplEA8LS2uuI8TZQHV9BLU84tdsfK4KqEPhObxx7n7mFi9UmFA40d/pp2DJZ23wJ8ofjryMzJZwfWtyFdP1rsP2N5ydj9muDpB1Fd1ZZJ6L0O0T61O0bn5z25dnoN5uApZmJedTXxscDBNyKvilYGpmvPq2Z0C4CEHTVyTYnF7D8yHgpLeOqFcAKawuWtPanD2d3mITpidS1lOjm9xAZRBP/iHccYq8NXys+KJNhp6EyBOWit8imfm+JV9+tw4BjloNFFjO2FvX0UF8Zu5WpbyKLk6A==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:35 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:35 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 13/22] hw/arm/aspeed: Attach GPIO device to AST1700 model
Thread-Topic: [PATCH v6 13/22] hw/arm/aspeed: Attach GPIO device to AST1700
 model
Thread-Index: AQHclaEq4T1cQOYXlEORcFVNvNe+Jg==
Date: Wed, 4 Feb 2026 06:40:35 +0000
Message-ID: <20260204064016.3515639-14-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: edf853a2-002c-4e46-bf3b-08de63b84d60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U1FQUENjT0VpVGtzR3grQzNhSnQwQlRsenVyNmpNV1pQblNYSEhmT0NSaWRq?=
 =?utf-8?B?dWoveHgvQUEvSlFBMkxZN1lGSGtUNkt4Sjloa21MaWNqbmVmNHpiWjI4SUk0?=
 =?utf-8?B?OGl6Qkh3TUZkc2dMV3d2OGptenVLenRKNGRCY1l4YVdQemgwVHFTSkJLNGtt?=
 =?utf-8?B?Q2Q2SEt2Yk1BY2g0U3h4UjZWaGhLOGcrbCtzc1E3Y0NHRHFIaThuekdQWlI3?=
 =?utf-8?B?TytNL0NXTGQwNEh3QXJ3MmkxRnVUSXovNXdoU0xrZExqQlN0UHpWUVNJZ0R5?=
 =?utf-8?B?VWt3eGNlODhlMCtib1hZQVQzMXI4WERwYTA0aXlqTWljTU01OGc0TWxIZFdD?=
 =?utf-8?B?SCtQSHRUWXdFaE8yNWxqQ0RLNWtDRTdQT3o4cThhTTcreHBDQUd5ZG1Mbkpr?=
 =?utf-8?B?U09tZjFWQi9RWUV6NVk0aUVjTnhBS290WGEwZ3FVeFZTMjJ6bytFclY1S1kr?=
 =?utf-8?B?eHJ1S0tMZGJWb2hiUy82YitjdTI3aWY3SXhXUlRtcFVPLzRUa0ZETG40dWxo?=
 =?utf-8?B?WDZpNlJkRXB1R3FQT01VNjAyNkFRbFVCaDhOR1E0cXVkVXlXTW4rQjV5K1FG?=
 =?utf-8?B?VnRybEp5aWZ2YUpGeVhISnNzcHpkQWpwUzZXY0tKS0VtQ2xIUE9VVHNFWVBZ?=
 =?utf-8?B?TGpTZ0R5ZGllS1R3TE83bWZEWmJDZkJLbjRJTlk3bG9zNloyMEpwcGw1cXZz?=
 =?utf-8?B?NGlSaW93NC9vbWNOTjVHb0NGL1J1MWErQlYzMGZTbVJNbnRSSFo2SWM4MXdN?=
 =?utf-8?B?bGJYTGozUWxzTE5HMUE2cVl6MnVVN04xNm5tSkJwbjJER20ya3lweUkraVZ2?=
 =?utf-8?B?R1pLeFR4WFRxMG1ibFJFQmdiaTBWZVJpZFFWM3JLcHZjeGhqS2VyV01vQXNB?=
 =?utf-8?B?OFVzdEt6Mi9JRE9OTkZMMy9XVkg5YjVXaGMrT2RJWlB4R0pEZlpueFJsa2U5?=
 =?utf-8?B?U3BQaDlYRnlDZG40TG9yaHJqVC8zTlVjRlFkMTNlNUV6Q2hhWlB1d2E5N0Mv?=
 =?utf-8?B?Z1IwdG9oL2wwMzJxdHpEVHZGakVmWnJNTG9neHdCQTViTjFZU1VIemxhTERw?=
 =?utf-8?B?aldIclZyTWUzNGdtbDhrWitINFZvZUwyTDRVV0dKbE1DbmxHZGpGK3ZXY1pG?=
 =?utf-8?B?Wkd0S3hvYy9ORHowL3N6RnIzK0lnbUJVeThuQUFQZVNKSld2bTdDa2hKbHA5?=
 =?utf-8?B?YjlzYjYvcEkyTWxDSFpTUmZpa29FRE1kZVk1TWZGNDA4dUZVcjE2dGNZR2Zj?=
 =?utf-8?B?OWsxbWdFZmxPaVoya1FJYjIvUkxlOFhKY1Z1NFh5elZZUlBENVF4OXBpTVQ1?=
 =?utf-8?B?dUF2eDQ2cTd4QVRJMGdMSk43enFnU21nb1lPREkxeGlHWUhCWUQ3OHN1SXRt?=
 =?utf-8?B?ZGlnQk1rS3MwRVlmeXZxbU1wS1kyZVMxMnk2MmdiVWFKNDJmM090ZWRjVUFD?=
 =?utf-8?B?by9ScWN0NUFHK3VaVTVzUEpPNG9qdWJEbDRhZ0wxTW85aWRhVnNpbThERzRW?=
 =?utf-8?B?OWRLVjdYY1F6Z25mWGE3cUlYRjRZRVIwOTJFN2RCUVhYVzJ1ZzNKTGljZTA1?=
 =?utf-8?B?dzJqbkVtbnJ4T3hhZytxbmo0SmJER21JM0VTTVZrYkEvd0Z5dUF5eUx1V05k?=
 =?utf-8?B?UDN2L3h5RW45ektxQkxmR0JITXl6WENUSlM2YkEwRWNxdHFNQVJkeTA3VGtz?=
 =?utf-8?B?R1hLd25CZm0rc25VN0EwTnM0UEtXSlB1TDh0WHJlYUg5cXR6TWowTFk0SUIv?=
 =?utf-8?B?WWJ2QzhFeWs1ZzVjTFMySDJQaXdvZExIVWErcHNZZm1ZR3NUTytKazJGTVdS?=
 =?utf-8?B?cUJZamtLNmxTUWtCMjRjYXhmTE5sTGlIV0JkWnlTcVNIUzFWMHE1OER5Vld3?=
 =?utf-8?B?M1dRTThkQVQ2eTdGQVFOK2hLeWpLMDhKSUYwTDZXbmlPd2F5Z3Q2dVJqRkEv?=
 =?utf-8?B?S3hLblpGZldNZTVWVVlyZ3lpUFVpOXpqSC91WU4wbGx5ckZWMjZpWlU2WUp6?=
 =?utf-8?B?VUw1a1hNTTQ5UWxFTll3VUljMHFSMXA3cFhyTjh2ME9FemlnVCtwU2xHS2Zs?=
 =?utf-8?B?U3lPZ3FpS21PUlVtOGRGQ2t5SUgzUUs3VHllZFE5bGNQOFZ2N0dMMkJER09N?=
 =?utf-8?B?Y3lFY2gvcHZNOUhFbnAvZ1hHK2lTZUJpV05pdC91UW12WjRuemQvNGNaTjh3?=
 =?utf-8?Q?PBt7Pg7G6U9cewvjaw3Xfzk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzA1Wk5KajR6bmkrTExUQkdFY3FLRmZXQzR6L2x1NHRBYURiQjVLOEEwNElj?=
 =?utf-8?B?Smg3azZnZHNKS1NGWGRSbGp1WE1VcFBsUm5kOEwvY0laSXQ3bXVhRHB5elFU?=
 =?utf-8?B?YnJzbTNRQ0VuNDRZd1NtbGJFejlVMnRtS25iRkUxRkFiRTJGdEpvQWdoTU9z?=
 =?utf-8?B?c090RXhJdWpqZU9saUdCWWFVN3FIdWxEVmxxSjlRL3RIL0lUV1I5QnpUMTVw?=
 =?utf-8?B?dFZSRTNtUUFmbklNT3FGMjZqT05FdWQ1eU9OdDJLOU13YWo4OGlRcjZWcWEx?=
 =?utf-8?B?MjZCcjcyQ1VUd09RdndyaUJyTDY2K3M1ME4xb3VReW0wU0JKV1o2ei9nQzU5?=
 =?utf-8?B?Z2RROWpiNDA1Mmc5Vm93QTJwS0gvT2FsT2JJOHh0dW1BTDZrOUpsL1lUaits?=
 =?utf-8?B?Uk9ZN2hUczd5R214ZHpKcVlXU1NpYVVpK2dlVHU4REhNYlpFa3MzRE1VbVFX?=
 =?utf-8?B?alkxNk5XSnptalVWMy9JaTA0U09HeWtrYllkTFN2akpBOVlaZlVUbGUwQ0Zu?=
 =?utf-8?B?ZFdtZGN0M1NWRGVNNTVEcHBDQTdPZFJDVWNVcGhxMHRHazFFdnRiVnlRUVlz?=
 =?utf-8?B?QS9NdVhDbjBPZE13RnFXY1JTbnhpYVAvRXhRb2VrdXNtMGFZUFIrWGJLdXlH?=
 =?utf-8?B?UTBCQjVCaUhSb2RvWU9OM0IzRjVMVFUvb1ZNMEhnaUM1QkZqTkpiYnpTQWVj?=
 =?utf-8?B?V21PTVBMUzZ1RmQ1U0wwV3krckdjcWtzK3pXUTNJN0NPc29NaVFZZTh1cTBU?=
 =?utf-8?B?eGZCQlY5UHhJb2lqYlV4SzhUd2p2UXNoTjE4aXIrOHFXRkwzZHBZVjNlM1Z3?=
 =?utf-8?B?UjBaL21nbzFLdmU4RXVVeHV2MnEwaDllQ21aeGpiYWVXMXNaNjJUYVUxOEVz?=
 =?utf-8?B?b2dqRFhDWm1RcUVjVU1kOFhua21lQXNJNGJzR05VQUZQcTE1ZXVXUWxMVUgy?=
 =?utf-8?B?cGp5anVsYlNvVEd0MTRiVFdwL3pnOUxCNndNcHFzK1FEMzNkeGZVVjZkODlw?=
 =?utf-8?B?YTk4MkMzSXg2VlJxTmpDL245M2FDZi90Y2xVU0k2bEZtSFh4SGxZVHhuSlBZ?=
 =?utf-8?B?Z2RtMzhDZnRQN3hmdHR4WXNtTE5kM3pRVG9RTTk3MmpDS1VHdVhIY0FsSDY1?=
 =?utf-8?B?OHE5ZDQ1RHFLdVJHcDlZV1dJcWJRamRLbFFEK1pxVGZMYWo3UGtlRDljTHYw?=
 =?utf-8?B?K2U3OGI0MHgxcFpuZkJTVjNlYk5EVTRRbUZYam8vS2trWnFwN1hwN2FvSlo1?=
 =?utf-8?B?Ty9oQVJnTmRucm5VMTZVbFVyNXlEamdtQjZ0ZVdldUx4eVRmbUp1RUxuVis5?=
 =?utf-8?B?RDV5R1RtbURXMnBIK3lhL2VOV01mNDNzSEx5ZFAySkRHRUU5MnV0VnhpZU5V?=
 =?utf-8?B?ZG1Ta0hRVVVNbUxRTHhWSHNERFZ2Y2wyQkxPRUpvUmpuRVd1VXNKazFkSk9B?=
 =?utf-8?B?WHlMdjNRS2ZiVEFZbW90a24yMjZqZy9qRUszZnhjaVJsdVpvdm84SFE2U0M4?=
 =?utf-8?B?dktPdGI4UCtwaHFNUlBBLzZpTHRqbVpmSmxscWN5YXBuMGgvMkhlZEh4MEQw?=
 =?utf-8?B?ejB0Q1N6VitjM3RTMGdMeWVvVjhvanNYKzhISEx1NzVTcDVYOUhQWkRTaE9l?=
 =?utf-8?B?dUtSMWRXTGUxQ1R1azNGZEtkdU9zZFZtSkRhTTFrYXhMOWs5Y1BFem13bXVZ?=
 =?utf-8?B?UC9DMGE4Q2xrK1FxU09zNWF4cDVJMHBnMUxRVGgrUkRudDJ0YU1XRFZpNWVl?=
 =?utf-8?B?N01jSzkycW9vZ2FVNzZsZVp6clNuQmVMdmgwWGlLeFNLMktaRXN6WlA2NUgx?=
 =?utf-8?B?bWt3MEM2eklTQlBTQ0R2eHdoc055TjRXamxERlZrZmw0TjNXMjZXaGQzYzk1?=
 =?utf-8?B?VFJ5R25EM0dGVVFEZHIvOGxWUUVuR2ZPUWpyVWRLODdDNG0xWlZDRjUxSVox?=
 =?utf-8?B?Q0kwd1M2TGhUSlMyV3ExaWJHclB4YklzNm5BUmt0VERXaVY3aEdTWTVJRmF5?=
 =?utf-8?B?OTVlbFhFaGdpYjg2RzE1Z1pXRHM3WUpjQndVT2k4Z1dIejhGdER5MlVvOUdm?=
 =?utf-8?B?ZWVXb1FJVXpvazMvUzFqc2NQSFZFVmt0N2NpSFJUWjJNSlkrQk9sdlRRWnor?=
 =?utf-8?B?bk40ZFpoOUtJOXE1eEJVamIwZTRYd0gxVUpZMDZtcHRGOW5jci9HTkE1KzZU?=
 =?utf-8?B?T1B3aERtNU5jQlVyNjRvTkdoZFZBbWJVNlJVL1AzeVJQdEFhVmN6Y3pJN3Na?=
 =?utf-8?B?Q29sdnd6SFBINTR3M2srWjZkS2prLzVYaCtGcGgyK0JxMW9Sd0R1YS9CbDhJ?=
 =?utf-8?B?TzU2dWJsbUdtdnBsWUNmVHFEY1dlODJZZHpFUDVPVnJwNmoyVk1rdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf853a2-002c-4e46-bf3b-08de63b84d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:35.6044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nT+jaloAbNJBZkqKO67+yYIaD9gMwQRWR7uVq/jmu1F1PscHF9Gg1Ci3xjRZCcMQ2X3eylCbxhiEMAuh9eAF8AF6eVSmdR7ZO0LopvERuiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:21 -0500
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

Q29ubmVjdCB0aGUgR1BJTyBjb250cm9sbGVyIHRvIHRoZSBBU1QxNzAwIG1vZGVsIGJ5IG1hcHBp
bmcgaXRzIE1NSU8KcmVnaW9uIGFuZCB3aXJpbmcgaXRzIGludGVycnVwdCBsaW5lLgoKU2lnbmVk
LW9mZi1ieTogS2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+ClJldmlld2Vk
LWJ5OiBD77+9ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogTmFi
aWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+ClRlc3RlZC1ieTogTmFiaWggRXN0
ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+Ci0tLQogaW5jbHVkZS9ody9hcm0vYXNwZWVk
X2FzdDE3MDAuaCB8ICAyICsrCiBody9hcm0vYXNwZWVkX2FzdDE3MDAuYyAgICAgICAgIHwgMTQg
KysrKysrKysrKysrKysKIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jICAgICAgICAgfCAgNCArKysr
CiAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAu
aAppbmRleCA2NWYxNDk3YTJkLi42M2NmY2I0YzI0IDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L2Fy
bS9hc3BlZWRfYXN0MTcwMC5oCisrKyBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmgK
QEAgLTExLDYgKzExLDcgQEAKICNpbmNsdWRlICJody9jb3JlL3N5c2J1cy5oIgogI2luY2x1ZGUg
Imh3L21pc2MvYXNwZWVkX3NjdS5oIgogI2luY2x1ZGUgImh3L2FkYy9hc3BlZWRfYWRjLmgiCisj
aW5jbHVkZSAiaHcvZ3Bpby9hc3BlZWRfZ3Bpby5oIgogI2luY2x1ZGUgImh3L21pc2MvYXNwZWVk
X2x0cGkuaCIKICNpbmNsdWRlICJody9zc2kvYXNwZWVkX3NtYy5oIgogI2luY2x1ZGUgImh3L2No
YXIvc2VyaWFsLW1tLmgiCkBAIC0zMyw2ICszNCw3IEBAIHN0cnVjdCBBc3BlZWRBU1QxNzAwU29D
U3RhdGUgewogICAgIEFzcGVlZFNNQ1N0YXRlIHNwaTsKICAgICBBc3BlZWRBRENTdGF0ZSBhZGM7
CiAgICAgQXNwZWVkU0NVU3RhdGUgc2N1OworICAgIEFzcGVlZEdQSU9TdGF0ZSBncGlvOwogfTsK
IAogI2VuZGlmIC8qIEFTUEVFRF9BU1QxNzAwX0ggKi8KZGlmZiAtLWdpdCBhL2h3L2FybS9hc3Bl
ZWRfYXN0MTcwMC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMKaW5kZXggNDlhMjQyZjNkZS4u
N2VmY2U0NTBmNiAxMDA2NDQKLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMKKysrIGIvaHcv
YXJtL2FzcGVlZF9hc3QxNzAwLmMKQEAgLTIxLDYgKzIxLDcgQEAgZW51bSB7CiAgICAgQVNQRUVE
X0FTVDE3MDBfREVWX1NSQU0sCiAgICAgQVNQRUVEX0FTVDE3MDBfREVWX0FEQywKICAgICBBU1BF
RURfQVNUMTcwMF9ERVZfU0NVLAorICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9HUElPLAogICAgIEFT
UEVFRF9BU1QxNzAwX0RFVl9VQVJUMTIsCiAgICAgQVNQRUVEX0FTVDE3MDBfREVWX0xUUElfQ1RS
TCwKICAgICBBU1BFRURfQVNUMTcwMF9ERVZfU1BJMF9NRU0sCkBAIC0zMSw2ICszMiw3IEBAIHN0
YXRpYyBjb25zdCBod2FkZHIgYXNwZWVkX2FzdDE3MDBfaW9fbWVtbWFwW10gPSB7CiAgICAgW0FT
UEVFRF9BU1QxNzAwX0RFVl9TUkFNXSAgICAgID0gIDB4MDBCQzAwMDAsCiAgICAgW0FTUEVFRF9B
U1QxNzAwX0RFVl9BRENdICAgICAgID0gIDB4MDBDMDAwMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAw
X0RFVl9TQ1VdICAgICAgID0gIDB4MDBDMDIwMDAsCisgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9H
UElPXSAgICAgID0gIDB4MDBDMEIwMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9VQVJUMTJd
ICAgID0gIDB4MDBDMzNCMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9MVFBJX0NUUkxdID0g
IDB4MDBDMzQwMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9TUEkwX01FTV0gID0gIDB4MDQw
MDAwMDAsCkBAIC0xMDMsNiArMTA1LDE0IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9hc3QxNzAwX3Jl
YWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQogICAgICAgICAgICAgICAgICAg
ICAgICAgYXNwZWVkX2FzdDE3MDBfaW9fbWVtbWFwW0FTUEVFRF9BU1QxNzAwX0RFVl9TQ1VdLAog
ICAgICAgICAgICAgICAgICAgICAgICAgc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihTWVNfQlVTX0RF
VklDRSgmcy0+c2N1KSwgMCkpOwogCisgICAgLyogR1BJTyAqLworICAgIGlmICghc3lzYnVzX3Jl
YWxpemUoU1lTX0JVU19ERVZJQ0UoJnMtPmdwaW8pLCBlcnJwKSkgeworICAgICAgICByZXR1cm47
CisgICAgfQorICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbigmcy0+aW9tZW0sCisgICAg
ICAgICAgICAgICAgICAgICAgICBhc3BlZWRfYXN0MTcwMF9pb19tZW1tYXBbQVNQRUVEX0FTVDE3
MDBfREVWX0dQSU9dLAorICAgICAgICAgICAgICAgICAgICAgICAgc3lzYnVzX21taW9fZ2V0X3Jl
Z2lvbihTWVNfQlVTX0RFVklDRSgmcy0+Z3BpbyksIDApKTsKKwogICAgIC8qIExUUEkgY29udHJv
bGxlciAqLwogICAgIGlmICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoJnMtPmx0cGkp
LCBlcnJwKSkgewogICAgICAgICByZXR1cm47CkBAIC0xMzIsNiArMTQyLDEwIEBAIHN0YXRpYyB2
b2lkIGFzcGVlZF9hc3QxNzAwX2luc3RhbmNlX2luaXQoT2JqZWN0ICpvYmopCiAgICAgb2JqZWN0
X2luaXRpYWxpemVfY2hpbGQob2JqLCAiaW9leHAtc2N1IiwgJnMtPnNjdSwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBUWVBFX0FTUEVFRF8yNzAwX1NDVSk7CiAKKyAgICAvKiBHUElPICov
CisgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAiaW9leHAtZ3BpbyIsICZzLT5ncGlv
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhc3BlZWQuZ3Bpby1hc3QyNzAwIik7CisK
ICAgICAvKiBMVFBJIGNvbnRyb2xsZXIgKi8KICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChv
YmosICJsdHBpLWN0cmwiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzLT5sdHBpLCBU
WVBFX0FTUEVFRF9MVFBJKTsKZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGIv
aHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMKaW5kZXggY2RhODQxZTEwMy4uY2Q0MDI4ZmNkNCAxMDA2
NDQKLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMKKysrIGIvaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwLmMKQEAgLTEwNTMsNiArMTA1MywxMCBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfc29jX2FzdDI3
MDBfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCiAgICAgICAgIHN5c2J1
c19jb25uZWN0X2lycShTWVNfQlVTX0RFVklDRSgmcy0+aW9leHBbaV0uYWRjKSwgMCwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFzcGVlZF9zb2NfYXN0MjcwMF9nZXRfaXJxKHMsIEFTUEVF
RF9ERVZfQURDKSk7CiAKKyAgICAgICAgLyogR1BJTyAqLworICAgICAgICBzeXNidXNfY29ubmVj
dF9pcnEoU1lTX0JVU19ERVZJQ0UoJnMtPmlvZXhwW2ldLmdwaW8pLCAwLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYXNwZWVkX3NvY19hc3QyNzAwX2dldF9pcnEocywgQVNQRUVEX0RFVl9H
UElPKSk7CisKICAgICB9CiAKICAgICBhc3BlZWRfbW1pb19tYXBfdW5pbXBsZW1lbnRlZChzLT5t
ZW1vcnksIFNZU19CVVNfREVWSUNFKCZzLT5kcG1jdSksCi0tIAoyLjQzLjAK

