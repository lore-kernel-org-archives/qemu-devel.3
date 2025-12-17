Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3B7D6552C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 10:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVoJg-0002uS-Dt; Wed, 17 Dec 2025 04:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vVoJf-0002si-4b; Wed, 17 Dec 2025 04:59:31 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vVoJc-0000p6-SP; Wed, 17 Dec 2025 04:59:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLYFHHuUe9f0NIuFx0fb4/uihyZSt3RW+UNL3NSU+sVWXaSnjUG7v9w80D51x+U5KD+7NgKPKLZ8N2uTZJNAUTx9tm9LPlLHksgVLLz00fengiooJrpil9fpHi9S7KE8NA1xy83/x9u22ShT5Id+Q4uDfqQW/8kt50P6PSGhbYS7zLpjJqlLxNAP6kZ/lKuP5KZsNxmBTqwcmeZIIdsKGmRC9WcKv9C1pu1uzo8KiE8qAf1T+VxfOmtePr7AkyAGzioixgdMnw5SuDfL1Y/wBFwxCDpsyjp3B8rZz+HjwafE9K41u+wpCAYMeXLi6NT7GfnscIYQMyCBBjR7oHXqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBV8/uSKh/rx3GkiaYWw5J4YW0h8hWBvTW0+yICKJu8=;
 b=bwj1mEmp/g/YylwO3NYl07dVKZ+SiwNjdOvizCRQC18FZ6E55tGEtnCZE4AXXdOd4ShFFCgnC1YKVoYlsapSV7t1ECLW3cZ8bSJ/Z1U+qIfBJO8Ptzom9BfvZ51gf2Uhx/c1xenqHSX4ICn/fJTH6vn9+ZV0XmArhV9AflDbCHMuP91SQoI+eENA3Jreh3WRkZmgOpr9lo3UolbH+dVRmV6mk6098rVzG2DIHlTmTkpDZ4X5Xn4i0FPQvWknqZIL9gpCpKZJouCaMQbRRDhNrOkGlsFEAMQUbX4uzPjuBdHm+Vv0dOsBR2XCTjNfZvRJ4BadA/Rg/BeAwGS27Rn36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBV8/uSKh/rx3GkiaYWw5J4YW0h8hWBvTW0+yICKJu8=;
 b=G151bPlw7nM8d0qx+C2DSn1BDd7OUq4eRMbl7OfmyGC1Gc+JH1IfHXGcr/kfrDnddDbxf6xrGF2b0dixy8gVgooEptrDHY8f5kb6/i3YDkiBSuIbUhag708YKe1TftAz6tW/ncptw6GdO2a4gyJ0xWRm3dtkOi7OQe8+SVh85jkv0QBJ4UdpJaT6U48DHmxTKHN8Ke+IXb3vntlIuviBHHKhpSARTLLbCSedA85JKAvvEB2evHz8KB1ukgRtvGj090XYWKICC2Y4hNL0/VaUHldBsVlZjMQrV80H3MocYCs/scQkG2JsnSLb0/s2IuQ1taAKiAd6AeU6Ab5c3BWkSQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYSPR06MB6390.apcprd06.prod.outlook.com (2603:1096:400:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:59:24 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:59:24 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Yubin Zou <yubinz@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Nabih Estefan <nabihestefan@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v4 0/6] hw/gpio/aspeed_sgpio: Add Aspeed Serial GPIO
 (SGPIO) controller model
Thread-Topic: [PATCH v4 0/6] hw/gpio/aspeed_sgpio: Add Aspeed Serial GPIO
 (SGPIO) controller model
Thread-Index: AQHcbus5Vot5wC0ipUqPqTX6TNSnmLUllOqA
Date: Wed, 17 Dec 2025 09:59:24 +0000
Message-ID: <SI6PR06MB763111A8CD474CBA2E52FE2CF7ABA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251217-aspeed-sgpio-v4-0-28bbb8dcab30@google.com>
In-Reply-To: <20251217-aspeed-sgpio-v4-0-28bbb8dcab30@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYSPR06MB6390:EE_
x-ms-office365-filtering-correlation-id: 35fe0f7e-73da-491f-a9b7-08de3d52f513
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?V0VUR0RjSUpHbU5xS013SnNGNnZKczhubVg2YnZkWVpVMXFSTERIOUVwd2Uy?=
 =?utf-8?B?LzI5SlV3V1E3N0pOWVdhRkl5cEJCTTN1d3FSVURmR1FwVVhMNHBUbktqSmNW?=
 =?utf-8?B?b3lBTnVYMTh1WXZ3MjlOSWdYTXk4ZGY3cFZnWXM4MnZRQzgyNXkwYXY3YmdP?=
 =?utf-8?B?Z0YyZElGY2sreVBVZ0N2bXYraFFlbld1dHBkTFJnQ0tVNmc5OE9ud0xyV0tW?=
 =?utf-8?B?Z1pSQ2dUNGJnQ0RMOVMzclUxUU9GYzkydERhcHlHd01QakNDM1JJU3RoZHpL?=
 =?utf-8?B?Wkh1SlA3Z3ljdmJEVDgxYWZWaDVBU1FpdTdYNW5NZnEzM2VPRlFKNGdkV3F6?=
 =?utf-8?B?Rk1VSnVwUUJiV05sNHRsUm5zTFJMT09jNWwzVmJMdm9hWmZkRlNCUnlrVjVQ?=
 =?utf-8?B?c1g1SFZuK1lVSHZwT0xBVFZHSFhBTXQ1UldaOGtVN1lSR1BmajJhaGtNQmRC?=
 =?utf-8?B?Tkt1SmdCMUVuS3VUUmZnTENRVXBIZzhKZk1YL080MXMvNUJPam1mdEFDSC82?=
 =?utf-8?B?NWhXOU9Dakt4NjlxcVBKam5yeVM5YVk2bnBlSVgyelRjeUNTZGhHNE9mY25n?=
 =?utf-8?B?aGdRVHVGKys2WVR5NHY1N2ZiRUhzRnNFcXdtOXlqUzhKL0MzRWtSYzZjWEtL?=
 =?utf-8?B?V25xMitySEZTSWZBcU9yOXRBOVVPSWVoYTgyS3VMczdDOUROdTZBUjUzZkRv?=
 =?utf-8?B?c0N5OFdBWjYzSEhQdzZYL2owOWJLMmEzaXMwSGJCcmtpaUNJNzV4R3RhYm9m?=
 =?utf-8?B?RHdpMXF1RWxXN0U0T2pZUDdWVzlxQnZ6VHozNEY4djlqR0dLam1PS3cxRjhh?=
 =?utf-8?B?Wm9ITVN6eE5vVkYzYlhETGlFQk44SXdOcVRyNGtpMk5XdXJFWFdXNm1rdWpC?=
 =?utf-8?B?NHZEOUJPR0RpTFZ2SWhGOWZ6YWJ2M3ZYejFweHNuMEJLdmN0VzRQeE05YWdQ?=
 =?utf-8?B?VklaSkpIM1JJZFkvcDlyeTVVZlVES1VZbjhSbW40Z2ppRmVBYlBIellIa2d3?=
 =?utf-8?B?b2JlNk9NNS94MzNiSWhQSnhZZys1WURMRkdOZGVmTFM0WVpXOHVETUo1TEdj?=
 =?utf-8?B?Mi8rNG9PMjRIYmtFZlpORFYwVERYa1d5bEc0TzdHbHpOS0lqQ1ByQjkxQjVB?=
 =?utf-8?B?am5qZEhpRTBKSE90OXg1TEgwaGRGZ1huV251akV3cm9PR0ZvY1I3NHk2bitj?=
 =?utf-8?B?N0hXNFppcXBkMmkxVEtkbG4xMGs0SFBYeE4ydVk2TDIvR2RmdUdIMkRNMy9J?=
 =?utf-8?B?QUJQNy9WdVFsZ2gwT2M4eVR5SXJsVWxVRnBxam5kNjBVOHIvT2lsWSs0c2J2?=
 =?utf-8?B?eWRmaW03R2hNYVd2SDI5WTkrNUVJeklINHU5aHFub3RlSi9IUGNPcjA5bFdY?=
 =?utf-8?B?RWNDMUxPSDhPN2M3TExkc2tjbWRrWHhzaExwNjN0dVV2bFNFUktQZnkvaTkw?=
 =?utf-8?B?UzdiSWlDeWZPNWlWWFArZ0J4Qk5VUHpwWUZsMjNrZExsRGtqN1M0c2s3aTY3?=
 =?utf-8?B?RmRRSmRYYjV3aUc2SUp5a1RjOG5kTGJQdWpHaHRqTE1TUlpIa0dER0VueUlx?=
 =?utf-8?B?WndoRGxKRERYVHpMZjNzOFBRdDlmaUxkS2pCanVBenZFT0hzQ2R0Szc5c2Ur?=
 =?utf-8?B?SzFTVWR0aEhhOGFuZjlkbGFQTnZuQzJLLzJSckN1NjdmbDBiZkN3L3ptOWFD?=
 =?utf-8?B?ZlYwZTdzRkx0OXJBYVAzYXdoOFZaenJPdWw5OU5uNDBzMWF0bVBjcEdtbTVX?=
 =?utf-8?B?Q25aM3VVcFl1SFlXVUNiN0Uzc01NVmJsRzJvU0wzekdPS0JxTDhxVnUzcTlk?=
 =?utf-8?B?SjJ5MEg0TnVYQWN6MFNJZ0hUelNremdhZGZWQ0I4Mzlmc0dBNjlRUGUwbzls?=
 =?utf-8?B?aG1ZM0tZdVE0UTY0S2FxQkx0MC8yTGNwaENpS3Z0RHB5UDNyWnNaNFp6eEtx?=
 =?utf-8?B?MWdidkxGU1hEWitOZEUzWCtvQmk4OWFsbGw1QXV3ejdXQmRhc3N3bkNpM1R3?=
 =?utf-8?B?bmExVzZXRVVlQkxXRmpTUXZFN0xmbEZOdUNTVUN2QVgrMWZRUDkzNFNrVkRK?=
 =?utf-8?B?aWRkRGhWSmIyRDNISkNrNjlVUURPUy9HUitMQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUt3TmNlY0c5OE9uOU1zRm5XMDd5clZMUnVYYlV5WGkvdGFsWDBYU0lPZCtw?=
 =?utf-8?B?NXBpakQ4N0pPd0pMWFNheDd0dGZXS1hnRWtiTUVUMFlVSVhPSmVsYW5pUEd5?=
 =?utf-8?B?VUY5U3d2WUpZMDAwYUpCMFU0ZU9NSEY2TWNnYTl3VFZKMTlTVXY4dmwwYkdi?=
 =?utf-8?B?NlBNMHVRWWhBYmIzQzBsQ1lodS92WVJhMy9MeGVvMm5OblhqSlczdGo1a3V0?=
 =?utf-8?B?OW1pdlNrb0FBbmJhZ3ZEUTVOOHhEVnU2ODZlbWVFVUxSUllZTVdQenVPTkg2?=
 =?utf-8?B?a1VVSnlzR29ucmt6dDNUamt5RXEyUFBaUE9wdE1WT3pJdzVEdGpQNGt4UXBT?=
 =?utf-8?B?Rk1LQ0N6NlZUTVNwYVo1RWVSZjB6dHREd09EWTc4Zi8vbk1hUVozVWMxYkhq?=
 =?utf-8?B?WUF6S3M2aXROZEZTaDh1YUNEc1U0UmxGZUs3ekMySngycFdST2ZtOW8zazJy?=
 =?utf-8?B?ZlNMU01ueU02RTZrQ1d0T1c1TWd1TjdBbDQxYXNXRVVINlBZQ2xHN1RLd08r?=
 =?utf-8?B?MXBvc3E5dUdHUVVjTnFsYUs2dG5XMlJmL3RmRVBSRnpnVUp0eVhsU2ZIRnBM?=
 =?utf-8?B?Y1g5VGFJaHJaY3FlcStHY2RFcDlyZ1BKSE9vWFZFVG5GZGRMYjRoSnpmQ3dO?=
 =?utf-8?B?NklReE9XWVFPS2w0eDdySU5zZjZUKzFUbEtWNUNuSHhlOTE3QVhiQjdzZmFI?=
 =?utf-8?B?amNDckFUcmtwUk0vckx3bnBsV1VsOFlhTHRGRzZhRG5YMmJyYXNwc3EvOC9l?=
 =?utf-8?B?VWNMajg4VlpXMmx1RjdqQzJKL1FOVkx5Mk1VYmRIRmN6UlBLT0I5NXVkT2h0?=
 =?utf-8?B?U0VCL0NvWmFiUzlaTFJ5S2Z0MytnS1BQNHYrT0EwU0Flc2tpZld0T1BETTU4?=
 =?utf-8?B?c3pmbGcwM1RkRGVPVXlnR0Z4NXpNVVhsbDhQeDhtRjRZWG00SHp5VHJjSDRm?=
 =?utf-8?B?bmE3TXpLbTE5aFg2TUtoUXNkNStVSkkzVTY3T3pWclBNN0lReHNVZm9ucTZU?=
 =?utf-8?B?Ym1NemozSndnUkZGbDBwb2gxYkVWZ2xXR2pocXA2ZlgzcFBkS2xYZmNsdm5N?=
 =?utf-8?B?WUFHZGhWUDArZmNibjVtcWZuWE1ubkk5ZW1vT1pDWjN1c05sTG55dFd4M2Ev?=
 =?utf-8?B?bS9DcWpCRU9wMFZlRHFHS2M4RGpicU9FbGtSN3M2ZDFsSkFueDZoLzlYTlNq?=
 =?utf-8?B?MXhldmdicm1YQm1lOGxYUmRiUEQwS1FhQ0pkMytHdjFaTHNFUEY5eU1hVWdj?=
 =?utf-8?B?WEtxcWI0RmVsQzZ3Wk10QUp5UUYzaDExZTgrRElxOGtEeXpvOThIRXJnSDdP?=
 =?utf-8?B?bHZ2UDh4MisyVmsyUEFrRE8yYnZwS0RPYjY2OFl3R0M4SmgwUm9zVmZRb1A2?=
 =?utf-8?B?THNiOGZQSVJIc1RXdTJPQWRwTjJPeDZDWTNMeDh0WnI0TjU3eHZnQTZUUW5E?=
 =?utf-8?B?RTdZdVlQSWR5VmtVYW1yZ1RZSHo1RHVxNG9WN2NzTUd2Q0EyV0ZRdW1NN1Jl?=
 =?utf-8?B?WCtWVURwYnlDSjRhcHhCVTd6VjlmUGpsbEk4ZXFUNDhHN3hLVVdoTlM0ZWlq?=
 =?utf-8?B?WTMzTXBKT2RhV28xZnJtajJDSDdkN2I2akFTaEFGb0plQklxcXpsTzRRek4x?=
 =?utf-8?B?NUZjWE5IeVBPYVRtWHd3MWl2aGxPajFpR2k5WEkyMmhscE5EUmkxcnhrOXNw?=
 =?utf-8?B?T1BpYWlKRXdJaFBoeXczTFMwR0sza0lnTDBUK0t5UjdjVktnajViTnpIbHha?=
 =?utf-8?B?UHg3RFhZazMvbnBWcGJSMnFSeUZPMEpWZGFCSnNsRncwaUVWUFZlV1Y2cWs0?=
 =?utf-8?B?dko4RGVqZkxYT3BQNWVnNXRlSHhUaGYvb21rMGJBbFlsaThVWlUzaFY5OGRy?=
 =?utf-8?B?VzBKbFJqZmpFdkM2QlB1RWpkS2VVU3lNUnZUL2p3Z0J5WGlRYjVMSEVYN2h2?=
 =?utf-8?B?eHRWS0RjczdmdFV6TGJja1BmL2RpME1ucUNZZXlOUHF4L2kvZjZEM28zTjNw?=
 =?utf-8?B?dGhsaFZSTjV0aE93WnhPZXgwbkdIejNZZEg3QjdBUVcwK2JQVHpTVGl3MHlO?=
 =?utf-8?B?c1hEOUE5Skg2UnZUelRrek1uNllZc3VEa1g5ZlpkbkROZWdyQm0zUmJZRnFs?=
 =?utf-8?Q?NeNtZOQobFhUPYO6wMRz6Z1AY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fe0f7e-73da-491f-a9b7-08de3d52f513
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 09:59:24.1105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gouzj2/YaREsZUAUtgC8RC5c3hz9ykouVxNSpwkO5RDCURkCb+V9hKXqSrBe2z+NYdinK9T0//c2PuP9gqcq+CxjY+qCvVChWSPWDJgkA4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6390
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZdWJpbiBab3UgPHl1YmluekBn
b29nbGUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDE3LCAyMDI1IDg6MjIgQU0N
Cj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNs
Z0BrYW9kLm9yZz47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47
IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVl
dHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFu
ZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5s
ZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4gRmFiaWFubyBSb3NhcyA8ZmFyb3Nhc0BzdXNlLmRlPjsg
TGF1cmVudCBWaXZpZXIgPGx2aXZpZXJAcmVkaGF0LmNvbT47DQo+IFBhb2xvIEJvbnppbmkgPHBi
b256aW5pQHJlZGhhdC5jb20+OyBLYW5lIENoZW4NCj4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNv
bT47IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPjsNCj4gcWVtdS1hcm1A
bm9uZ251Lm9yZzsgWXViaW4gWm91IDx5dWJpbnpAZ29vZ2xlLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIHY0IDAvNl0gaHcvZ3Bpby9hc3BlZWRfc2dwaW86IEFkZCBBc3BlZWQgU2VyaWFsIEdQSU8N
Cj4gKFNHUElPKSBjb250cm9sbGVyIG1vZGVsDQo+IA0KPiBUaGlzIHNlcmllcyBpbnRyb2R1Y2Vz
IGEgbW9kZWwgZm9yIHRoZSBBc3BlZWQgU2VyaWFsIEdQSU8gKFNHUElPKSBjb250cm9sbGVyLA0K
PiBjb21tb25seSBmb3VuZCBvbiBBc3BlZWQgU29DcyBzdWNoIGFzIHRoZSBBU1QyNzAwLiBUaGUg
U0dQSU8gcGVyaXBoZXJhbA0KPiBwcm92aWRlcyBhIGxhcmdlIG51bWJlciBvZiBHUElPIHBpbnMg
dGhhdCBjYW4gYmUgY29udHJvbGxlZCBhbmQgbW9uaXRvcmVkDQo+IHNlcmlhbGx5Lg0KPiANCj4g
SW1wcm92ZW1lbnQgdG8gUUVNVToNCj4gVGhlc2UgcGF0Y2hlcyBlbmhhbmNlIFFFTVUncyBoYXJk
d2FyZSBlbXVsYXRpb24gY2FwYWJpbGl0aWVzIGZvciBwbGF0Zm9ybXMNCj4gdXNpbmcgQXNwZWVk
IFNvQ3MsIHBhcnRpY3VsYXJseSBmb3IgQk1DIHNpbXVsYXRpb25zLiBCeSBtb2RlbGluZyB0aGUg
U0dQSU8NCj4gY29udHJvbGxlciwgUUVNVSBjYW4gbW9yZSBhY2N1cmF0ZWx5IHJlcHJlc2VudCB0
aGUgaGFyZHdhcmUsIGFsbG93aW5nIGZvcg0KPiBiZXR0ZXIgZGV2ZWxvcG1lbnQgYW5kIHRlc3Rp
bmcgb2YgZmlybXdhcmUgYW5kIHNvZnR3YXJlIHRoYXQgcmVsaWVzIG9uIHRoZXNlDQo+IEdQSU9z
IGZvciB2YXJpb3VzIGZ1bmN0aW9ucyBsaWtlIHNlbnNvciBtb25pdG9yaW5nLCBwcmVzZW5jZSBk
ZXRlY3QsIGFuZA0KPiBzeXN0ZW0gY29udHJvbCBzaWduYWxzLg0KPiANCj4gSW1wYWN0IChCZWZv
cmUvQWZ0ZXIpOg0KPiANCj4gQmVmb3JlOg0KPiBRRU1VIGxhY2tlZCBhIG1vZGVsIGZvciB0aGUg
QXNwZWVkIFNHUElPIGNvbnRyb2xsZXIuIEFueSBndWVzdCBzb2Z0d2FyZQ0KPiBhdHRlbXB0aW5n
IHRvIGludGVyYWN0IHdpdGggdGhlIFNHUElPIHJlZ2lzdGVyIHNwYWNlIHdvdWxkIGZpbmQgbm8g
ZGV2aWNlLg0KPiBGaXJtd2FyZSBmZWF0dXJlcyBkZXBlbmRpbmcgb24gU0dQSU8gcGluIHN0YXRl
cyBvciBpbnRlcnJ1cHRzIGNvdWxkIG5vdCBiZQ0KPiB0ZXN0ZWQgaW4gUUVNVS4NCj4gDQo+IEFm
dGVyOg0KPiBRRU1VIGVtdWxhdGVzIHRoZSBBc3BlZWQgU0dQSU8gY29udHJvbGxlciBvbiBzdXBw
b3J0ZWQgbWFjaGluZXMgKGUuZy4sDQo+IGFzdDI3MDAtZXZiKS4NCj4gLSBHdWVzdCBmaXJtd2Fy
ZSBjYW4gY29uZmlndXJlIFNHUElPIHBpbnMsIHNldCBvdXRwdXQgdmFsdWVzLCBhbmQgcmVhZCBp
bnB1dA0KPiAgIHZhbHVlcyB0aHJvdWdoIHRoZSBtZW1vcnktbWFwcGVkIHJlZ2lzdGVycy4NCj4g
LSBFeHRlcm5hbCBlbnRpdGllcyAobGlrZSB0ZXN0IHNjcmlwdHMgb3Igb3RoZXIgUUVNVSBjb21w
b25lbnRzKSBjYW4gaW50ZXJhY3QNCj4gICB3aXRoIHRoZSBwaW5zIHZpYSBRT00gcHJvcGVydGll
cyAoZS5nLiwgdG8gc2ltdWxhdGUgZXh0ZXJuYWwgc2lnbmFsIGNoYW5nZXMpLg0KPiAgIFBhdGgg
ZXhhbXBsZTogL21hY2hpbmUvc29jL3NncGlvWzBdL3NncGlvMA0KPiAtIFRoZSBtb2RlbCBnZW5l
cmF0ZXMgaW50ZXJydXB0cyBiYXNlZCBvbiBpbnB1dCBwaW4gdHJhbnNpdGlvbnMsIGFjY29yZGlu
ZyB0bw0KPiAgIHRoZSBjb25maWd1cmVkIG1vZGUgKGxldmVsL2VkZ2UpLCBlbmFibGluZyB0ZXN0
aW5nIG9mIGludGVycnVwdCBoYW5kbGVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFl1YmluIFpv
dSA8eXViaW56QGdvb2dsZS5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHY0Og0KPiAtIEZpeCBp
bmRlbnRhdGlvbiBpc3N1ZSwgcmVwbGFjZSBTeXNCdXNEZXZpY2UgYnkgU3lzQnVzRGV2aWNlQ2xh
c3MsDQo+ICAgcmVtb3ZlIHVudXNlZCBmdW5jdGlvbiBpbiAxLzYuDQo+IC0gRml4IGdfYXV0b2Zy
ZWUgdXNhZ2UgaW4gMi82Lg0KPiAtIFN3aXRjaCB0byB1c2UgICUwM2QgaW4gdW5pdCB0ZXN0LCBy
ZW1vdmUgdW51c2VkIGhlYWRlcnMgaW4gNi82Lg0KPiAtIExpbmsgdG8gdjM6DQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTEyMTAtYXNwZWVkLXNncGlvLXYzLTAtZWI4
YjBjZjNkZA0KPiA1MUBnb29nbGUuY29tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEZpeCBj
b21taXQgbWVzc2FnZSB0eXBvIGFuZCBhZGRyZXNzIHNldmVyYWwgcmV2aWV3IGZlZWRiYWNrIGlu
DQo+ICAgY29tbWl0IDIvNi4NCj4gLSBTd2l0Y2ggdG8gdXNlIGdfYXV0b2ZyZWUgYW5kIGRyb3Ag
Z19mcmVlLg0KPiAtIFVzZSAiJTAzZCIgaW5zdGVhZCBvZiAiJWQiLg0KPiAtIExpbmsgdG8gdjI6
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTEyMDktYXNwZWVkLXNn
cGlvLXYyLTAtOTc2ZTVmNTc5MA0KPiBjMkBnb29nbGUuY29tDQo+IA0KPiBDaGFuZ2VzIGluIHYy
Og0KPiBTcGxpdCB0aGUgdjEgaW50byBzbWFsbGVyIGNvbW1pdHMgYW5kIHJlb3JkZXIgaXQgZm9y
IGJldHRlciByZXZpZXc6DQo+IC0gTGluayB0byB2MToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDI1MTEwNi1hc3BlZWQtc2dwaW8tdjEtMC1iMDI2MDkzNzENCj4gNmZh
QGdvb2dsZS5jb20NCj4gDQo+IC0tLQ0KPiBZdWJpbiBab3UgKDYpOg0KPiAgICAgICBody9ncGlv
L2FzcGVlZF9zZ3BpbzogQWRkIGJhc2ljIGRldmljZSBtb2RlbCBmb3IgQXNwZWVkIFNHUElPDQo+
ICAgICAgIGh3L2dwaW8vYXNwZWVkX3NncGlvOiBBZGQgUU9NIHByb3BlcnR5IGFjY2Vzc29ycyBm
b3IgU0dQSU8gcGlucw0KPiAgICAgICBody9ncGlvL2FzcGVlZF9zZ3BpbzogSW1wbGVtZW50IFNH
UElPIGludGVycnVwdCBoYW5kbGluZw0KPiAgICAgICBody9hcm0vYXNwZWVkX3NvYzogVXBkYXRl
IEFzcGVlZCBTb0MgdG8gc3VwcG9ydCB0d28gU0dQSU8NCj4gY29udHJvbGxlcnMNCj4gICAgICAg
aHcvYXJtL2FzcGVlZF9hc3QyN3gwOiBXaXJlIFNHUElPIGNvbnRyb2xsZXIgdG8gQVNUMjcwMCBT
b0MNCj4gICAgICAgdGVzdC9xdGVzdDogQWRkIFVuaXQgdGVzdCBmb3IgQXNwZWVkIFNHUElPDQo+
IA0KPiAgaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oICAgICAgfCAgIDggKy0NCj4gIGluY2x1
ZGUvaHcvZ3Bpby9hc3BlZWRfc2dwaW8uaCAgIHwgIDY4ICsrKysrKysrDQo+ICBody9hcm0vYXNw
ZWVkX2FzdDEweDAuYyAgICAgICAgICB8ICAgNiArLQ0KPiAgaHcvYXJtL2FzcGVlZF9hc3QyN3gw
LmMgICAgICAgICAgfCAgMjYgKysrDQo+ICBody9ncGlvL2FzcGVlZF9zZ3Bpby5jICAgICAgICAg
ICB8IDM0Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIHRl
c3RzL3F0ZXN0L2FzdDI3MDAtc2dwaW8tdGVzdC5jIHwgMTY2ICsrKysrKysrKysrKysrKysrKysN
Cj4gIGh3L2dwaW8vbWVzb24uYnVpbGQgICAgICAgICAgICAgIHwgICAxICsNCj4gIHRlc3RzL3F0
ZXN0L21lc29uLmJ1aWxkICAgICAgICAgIHwgICAxICsNCj4gIDggZmlsZXMgY2hhbmdlZCwgNjE4
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogOTE3
YWMwN2Y5YWVmNTc5Yjk1MzhhODFkNDVmNDU4NTBhYmE0MjkwNg0KPiBjaGFuZ2UtaWQ6IDIwMjUx
MTA1LWFzcGVlZC1zZ3Bpby0xZDQ5ZGU2Y2VhNjYNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0N
Cj4gWXViaW4gWm91IDx5dWJpbnpAZ29vZ2xlLmNvbT4NCg0KSGkgWXViaW4sDQoNCllvdSBjYW4g
a2VlcCB0aGUgcmV2aWV3IHRhZyBpZiB0aGVyZSBhcmUgbm8gc2lnbmlmaWNhbnQgY2hhbmdlcyBp
biB0aGUgcGF0Y2guDQpGb3IgZXhhbXBsZSwgcGF0Y2hlcyA0LzYgYW5kIDUvNiBsb29rIHVuY2hh
bmdlZCBjb21wYXJlZCB0byB0aGUgZWFybGllcg0KdmVyc2lvbnMsIHNvIHRoZSBwcmV2aW91cyBy
ZXZpZXcgdGFncyBjYW4gYmUgcmV0YWluZWQuIEkgYWxzbyBhZGRlZCBzb21lDQpjb21tZW50cyBv
biB0aGUgaW5kaXZpZHVhbCBwYXRjaCB0aHJlYWRz4oCUcGxlYXNlIHRha2UgYSBsb29rLiBUaGFu
ayB5b3UuDQoNCkJlc3QgUmVnYXJkcywNCkthbmUNCg==

