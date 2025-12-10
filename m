Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA17D3C521
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 02:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTA99-0004j6-8d; Tue, 09 Dec 2025 21:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vTA94-0004eZ-Cn; Tue, 09 Dec 2025 21:41:38 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vTA91-00074L-Er; Tue, 09 Dec 2025 21:41:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfKn1t9N7w0Xh2v17cqOmDO5Sx03GjVUNO01B1PEvvU+sJXbavNbEiooo88OnOVZyO6QVC9Q43lu0DodEa+PGyC5ughBW0TtCVaFzl6j8qCAp63rheTUVCBaKYJHJsM3Am6R4+6uF/TFlhKEFFzvKZnymNJjwxAbwqWSvMkqT7DOAuIdS4WzNgd96XIsz4afNj4AggPAcYxDoOWNVnzbUk944NsQ5oGOB3OatJr5FdZRUaq6kP4/OK7ziD+jh9WhHYZNB3yb4mU6nNfUocwivWBKtZWcGSp1sJGJKUx7R+Gkh/ZKGj9CCcVAoQS/QPzzSYWaegZOKf56oRVg9IsHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DIpSzbUoyjixVSPX/XOnHs3kXXSKXpw09S3AvxI5s8=;
 b=tPYSn0bMGApOjD0xfBBIWYsCH5Pp+o9Xbu4fPyWvx2qeP3gB4ZJefXBqHa/AujzIZ/aRjGoWClqUWNFsILCK8v/iOwNFFQRA5TIgG9qkkOe75tx4uCFVemCN8NsGkJIQB+xi1uLko5+nD/K5NFCxz1MjWYuBKUlrc7DwGRQZ/wbQaWNTHhkIuhBO6QIyusvYvgX7780FY+/LpYI2HOcd6mrbxn99Y2QBAH5RgQkzWr7WegNSrjnQgz4aqVuefNBmARHn8t+Z/F2AlXJ6dB+MVtOUlWyCDe9LYhz21Rr4sp6MISjCgKbZj82Lp+ZLgh55zDWedm67fb0F56s1i2c41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DIpSzbUoyjixVSPX/XOnHs3kXXSKXpw09S3AvxI5s8=;
 b=nRcZoXCTMcUzHZHAOcsFjcM23rq2BIaRs99HVbvLu0wlQcGxNaJgLfi/CNzkcUxiuaHFLiHsu56S3pF4Cl1fCcdiuvfHeT7guKv/6mp5rhNYg3HhcAfHYhqpl+wB74PFC2KUMjFhAQWz3FCizwJU02xI7ylSgcdgDtyQUgVV35x7g6+OY+2C+xBjT/sy2AT8kMdwvVnbdQ3l6YQU+3lJ2gMXolyv5z9sZlxEym16Br/HDyZIcCF/LBW96FjGmqG2QuiJM0xvePSWKogqTdgCZ32FdRmzU60e8cGwMBawi5TgeEVxe6aeDIKFPBgS36kkE+I5Mxv42lBdwaphX/A9oA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB8196.apcprd06.prod.outlook.com (2603:1096:101:2f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 02:41:25 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 02:41:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Nabih Estefan
 <nabihestefan@google.com>, Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi
 <komlodi@google.com>, Yubin Zou <yubinz@google.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 17/18] hw/arm/aspeed: Attach SGPIOM device to AST1700
 model
Thread-Topic: [PATCH v3 17/18] hw/arm/aspeed: Attach SGPIOM device to AST1700
 model
Thread-Index: AQHcaBaMy2keevX/wECwreZZKAiQCrUYDsGAgADyaQCAASpL8A==
Date: Wed, 10 Dec 2025 02:41:25 +0000
Message-ID: <TYPPR06MB8206024BFE41DF1B6B26DF43FCA0A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-18-kane_chen@aspeedtech.com>
 <CA+QoejXUfmJfuWSPndkuF=Dqu7QBJF7ACgH90Wmfshr4+3pDoA@mail.gmail.com>
 <1891c6bf-9dfd-429b-9fdd-130233a01d96@kaod.org>
In-Reply-To: <1891c6bf-9dfd-429b-9fdd-130233a01d96@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB8196:EE_
x-ms-office365-filtering-correlation-id: 1046b60a-2b3a-4463-d42a-08de37959cd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WW5IQzdtSVZmR2lqZjhPNkppYWNzaldobHp3L2UxaFg3RUVIZ1k5aWRDZGRT?=
 =?utf-8?B?QUNtZWwvSTRtalZpZ0g3SmtTMWxJaUhiS29jaFEzSnlTeGNuSHgvcVBlR3Bi?=
 =?utf-8?B?Z3JDUGkvWWF1aXgrSWoveVVRQUMyU2R1eC9oY1Urc1kyRVA4T2JDdFhBc2xa?=
 =?utf-8?B?OXlmdE0wYWJyUnNMcFN3ekpPZlRlN08vY2lIdkV5cUpha2RwdUFXK1dkSlBx?=
 =?utf-8?B?dmZoem1RbG00R3ZubUVPekRBWGwzQWIwTytZNjBQSmVmU3dHS3Q3T2Z2YWlr?=
 =?utf-8?B?a2dNVCtCU0RVZ0c3VGp1TkdCS3VHV2cvaU0rZjZzd0RwNE5BeHE0dVBQU0ph?=
 =?utf-8?B?V0daZ0pqSW5oNkRDNFZNVVk5STBTVnJydVF1TDRVUmkwSTEzT1J2MmxpZUFN?=
 =?utf-8?B?c0xsZmIrSEVaejAyWTJIMG5MMVZkcHFmUUN6RURhT2tVVitvOW44Tjd6aFV0?=
 =?utf-8?B?cE81N3B1UlJLOS9JVURiU2RSNGZWM1VvUDJJdGdkTzU2N1Z4MklzcHR5cmxZ?=
 =?utf-8?B?V0FKODQwS0xFbnhNSTE1VzlPMTY3M0Z0dmNKSmZWcjNwZ1dwTGVmWVozd1Np?=
 =?utf-8?B?bHhvY1RrT3d5eVdJZkFIRFBWRmZBZHFtNzNTTGdFSVU0ZFp2djAweXpwYnB1?=
 =?utf-8?B?NVVQMG9KMmdQS0ZNd2NXUzlqeno3UWJBUTRwY1o3Q2FncjFtMlM4T1lSRHAx?=
 =?utf-8?B?c3RRY2F3REU5UjdKbFBpRFZIS1FmNk5FYTg3cUdqdFNseVlKVG4yeGRPWW9s?=
 =?utf-8?B?WDFnTXBtT0drc2x4cmtsL2dkZXIyRDZObm9tZlpPSzJsMXAxVjg4bmFGeTVy?=
 =?utf-8?B?UkNsOS9rRE5rbFBuV09DZlVBVC9UMGJPcGdyTzJwa1NYQStCdlhEeE43KzRN?=
 =?utf-8?B?eW4vejRTN0dBS2NyaEorT0tHSTlMeVpPWmdnSGY2azFDV085Z3QzMUZMb1RC?=
 =?utf-8?B?cEkzU00vNXRLckhRNkZubmd4RDFuQXI0dklUN05JbjFvOGtOK1I0RlhFdjkv?=
 =?utf-8?B?WWREeHpQTEZxZ29EZklmVjZSaXZ5UUxDTElDM1hsVGk4S3JpK0pCUVJSaHNV?=
 =?utf-8?B?Qm9DKzFIbGNFUmpONHQ4WnBYbm80aG5JR0tSdlErYWxZcDNnMGtzNDhrV3dp?=
 =?utf-8?B?dTl6cjJ5SXpnT3l2VEpKVnZqTE4vWVlBUDdNeGloWVJHUlpJU216MjB6My9D?=
 =?utf-8?B?YWJoM2ZBZFJQb0NIWG92KzNmQmoxMjBwUUpCQVI5bTNKb293MFBJYkpRUElu?=
 =?utf-8?B?Q1BYTGtSN2VrWVJkNERKbWZVVFBRVURMU2VPaTlDd1RtSDYvaXI3SkU2Qm1Q?=
 =?utf-8?B?cWZNVFljTUc5ejYvcWp0ZVk2b2toMXlHSjlCaEdvU095aXNmUGxtamhHWUxo?=
 =?utf-8?B?bk5neExEL1BLZlBhbzFld25Zc2xra1Q1Mm9NdjJRSko1Ym9ycHUyQjd0cDd4?=
 =?utf-8?B?NTZ5NHRXdFBEaTZ5SmJWRHgyY3Q3ZmFhMEtKS3BjQXNmWnFPRGQyakIyNlVR?=
 =?utf-8?B?bHVMVkhHU2lTbm9ubzVPaE93SlZDR3U3WUxlQy9OYnNJL3VibmJWdWw1L2R5?=
 =?utf-8?B?alFnTnZmZXovdXhWNHN2OXBtbEZQTFdET0kxYTVWWHFzVWt5WEx4eXFwbEtC?=
 =?utf-8?B?TkVUV2JoR21UbXhJYUE2THc3aFdrL1JvZ041L2dXek8wYVdMZXJMclJtVGM3?=
 =?utf-8?B?S1VaYnFBQm45eHVkK1ZvQ1RoNWVEY0xUemFnTHl3QU5QdG10QU9xQzBoaDRn?=
 =?utf-8?B?ZkJ5TmlPekFYMmI2cHoyakJ0T1ZKMXpHN3RGOFN1U3VWWWNBQ2JhUG1ZMkhs?=
 =?utf-8?B?N3JReVdGMHoxUG15NEhheE9mbWRNNFFMMlZNVDUrckZVazlwRWhGNEVkNEJa?=
 =?utf-8?B?YWh3UGRhTHBhV3cvcE5NUmk0YnhFSHNKbm1mK25qVEdqc295MnNLSllVb1Js?=
 =?utf-8?B?MFo0VzlwZ0VaUjVQZmVDM0ZLTkRIZjJIK2dmTkZuVVBEK0NBcnl3YlliaG5n?=
 =?utf-8?B?VG1oSXBBZXAvNy9iRWo3d1VqN1hsOUZndFJZSW8xck1wUkFUOUpGcnA5MTJO?=
 =?utf-8?Q?Z9EWl4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGJ3QXlVN3VyL0J4UXlRSWJmRUhTRG80cUw0bkJWMzhWTEZaV0pWeHAveURl?=
 =?utf-8?B?NU9XYnpwYTN4NXdPdFI5a29mZFJwSlBRdDJJWGF6dFYrazJWa2dVQ3pSNjFh?=
 =?utf-8?B?aFdubkNLTU9USjZqelFvUEtCakNWZ0lPeGxacjdsMnE0TVhncWphS1I0ai93?=
 =?utf-8?B?UWhXUngvYzFhVUt3MVBUU1llR1A3cGxxSno4ZTlpMVdHY0tkb2Q5ZitJaStD?=
 =?utf-8?B?Vzd5VkpDcmVVbzdPUXZsSndSc1FjbTNnUUVKRi8xU0lybzZFNURFUklPbEpQ?=
 =?utf-8?B?RWpnbTFEaERTR2N3MHhrb2ZURVVrQnRVOTNtaW5wS1NqdjVLdHd5QUtoSjdJ?=
 =?utf-8?B?YzNRRFZobHZiNm8rYlpMWmJZV29lVXNrOVJMYU03UGpod085ZkxQa21xQkNC?=
 =?utf-8?B?WVhNVXBGWGdubHdRdkJGOFB1TjlNRXdWYTdtVjVkY1l2SExsa1FXdU1Zb2R6?=
 =?utf-8?B?cEJhNFllU1cwQVJUSEYzV3BhR3J6Y09sUytFNFV6TWl2TUVIQXlMeDBkb2tE?=
 =?utf-8?B?TC9kVXBRRjB5cDkyNTdGMWV3c3RnUU52dFVtN25ieUFuNy9WSWFGK0VNZTZ3?=
 =?utf-8?B?V3FHa2pjQmc3OWhZOEdNL0srdTRqWVU1aGRTdmZyaEk5QTJtaTlQN1FudkZt?=
 =?utf-8?B?U2YrT2l2NjdJSUZ2bEtlbXVLNnNKd3RVSkxmTDcxOXpGeGdKWXEyRWRSRGNV?=
 =?utf-8?B?VEU0RUMrcGRWNlRhMml0WG9NbTdmMWI3U0JRbVpGYlNkL2RlMGZSaEZUKzB4?=
 =?utf-8?B?QjYwR3UxSm5DN2VQd3V4ZGJJNkFEQXozZXEvYWsxR0NnS2lPNDBoSTZ2S2M3?=
 =?utf-8?B?R2dJOG5rTnFycHIxU1ZWWXFMalM1TWpPWEZNRHJ1dFpXQjVFbzVlajBudGFF?=
 =?utf-8?B?M1l6ZGRDV2p4Y0N2VTZsbGF6VU1ZdlNueFlDZStTM1N6U0R1SHJHNkFqRnRx?=
 =?utf-8?B?VS9nbWpEV3FZV1huSFpCb1IxUjZJdzY0Ym1LQzNvMWw2QmtWVzF2SDAyUzB4?=
 =?utf-8?B?N2RtRnYvdkhIY1ArSE4rNE92aWRRZzh6MStJcnZ1K1l3S1hBUkdGSzhTMEpl?=
 =?utf-8?B?ak9nSk1JNnR1L3RCWmJ5bTlnc2pmd3I0N1JVb1dGQnc5YVNzLzV1UEl1R2Nu?=
 =?utf-8?B?OE5Udk9kRkVpS21McGQxVzlrMjNWcVhyeUNWQ0FMdWtVMkZTcTh3V0VxWEFr?=
 =?utf-8?B?RTY3UlV4QytRYlN2NG9XZlFWOXR3Sm1BeHBqeDB1dzdZU2FvK1dvU3AzTzNR?=
 =?utf-8?B?dUg2dWY1b3FJUzJrNTZkQ3cwWVhMbUVrRWo1ZnlIaytWMGJ6TWpSWEtoTnBQ?=
 =?utf-8?B?d0ZpRllseklQZW5JSlZNOU1mQmZwYTQyaEFhaEpVRDd4TEVESnM5K0dsRFhX?=
 =?utf-8?B?bXRsSmJXM1FkZUUwaCtiRTRuSjFNR2V6TW96NmxPc0FHZE9LTGw2aDZaT25x?=
 =?utf-8?B?ZXVLV0ZTNFlBTjdGTys4SWJNd3c5bVQ2bkU4VzhKazF5Nm9uSFk0R3NMZnd6?=
 =?utf-8?B?UzlOY1ZQbWFnc3JzbjRIZFE1ME9aK2VwV2dIUkhhRHA5Z252azVJcXBoaFVI?=
 =?utf-8?B?UGVXeDZoK1VoQWhRT1QxRENON0hJM01kVlVYN05zME04aWNSMFo4YmJmM2xn?=
 =?utf-8?B?OVJSVnRPK1pWODJxOHY2akUzdUI2RWRNZ29TbWZzK25OL2ZUYjBTOHFZUTJL?=
 =?utf-8?B?MitZNlVmNmh1OEdTemxUdlBQaGNvRi85cHByZElxcVZtS2sxSm5zeWFaTU45?=
 =?utf-8?B?UVk1THdGelNqU1ZqS05VSU43WFovZFNIcVFDK0VtM1N6YUZuWThRS0FjbWJL?=
 =?utf-8?B?RjlxRVpFYXlWaDdBOEk1U09tMzI4NFJ5OW5ETzdRSENLRmFHUHlQRUhBTzdS?=
 =?utf-8?B?cjRtTzVXR3VneGtESlpMWGtBSVN3aFJmRlZRWXZERjFWd1ZYd2txUHNlQndm?=
 =?utf-8?B?ZERpbnU5QkxrK2NtTDRCbTdtbnM5V0RLZkVDTEhRdmhlYzV1NlpSN0FuZUtH?=
 =?utf-8?B?R1c0SzYyelZSTVEySHFwSnBBYjA5Z01POGhGdWt1L0pnUGxFOGhKcXpQQzAx?=
 =?utf-8?B?SDRzamdyekFXV3NBa3ZvVUJnK2EzeUVyN203cXYxZEZEd0xQTUxXSDNuOGtS?=
 =?utf-8?Q?1c/scDNk1xpUjSxYWRzzxbood?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1046b60a-2b3a-4463-d42a-08de37959cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 02:41:25.3733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mfmz8zFDixGJgw7v3Jeh71La3dA2nQyLDV2s9MTq/Y9OBZnMrdmsRarUy3C8gCYn4++kG6oiUzbhxhNdVuSBApEWyT4GubH6QhlVj5/6YlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8196
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTcvMThdIGh3L2FybS9hc3Bl
ZWQ6IEF0dGFjaCBTR1BJT00gZGV2aWNlIHRvDQo+IEFTVDE3MDAgbW9kZWwNCj4gDQo+IE9uIDEy
LzgvMjUgMTk6MjEsIE5hYmloIEVzdGVmYW4gd3JvdGU6DQo+ID4gT24gU3VuLCBEZWMgNywgMjAy
NSBhdCAxMTo0OOKAr1BNIEthbmUgQ2hlbiB2aWEgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4g
d3JvdGU6DQo+ID4+DQo+ID4+IEZyb206IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRl
Y2guY29tPg0KPiA+Pg0KPiA+PiBDb25uZWN0IHRoZSBTR1BJT00gZGV2aWNlIHRvIEFTVDE3MDAg
bW9kZWwuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVu
QGFzcGVlZHRlY2guY29tPg0KPiA+PiAtLS0NCj4gPj4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWRf
YXN0MTcwMC5oIHwgIDMgKysrDQo+ID4+ICAgaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMgICAgICAg
ICB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ID4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMyBp
bnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9hc3Bl
ZWRfYXN0MTcwMC5oDQo+ID4+IGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaCBpbmRl
eCA3MjkyNzE5ZGMyLi40OTBmMmEzYjA1DQo+IDEwMDY0NA0KPiA+PiAtLS0gYS9pbmNsdWRlL2h3
L2FybS9hc3BlZWRfYXN0MTcwMC5oDQo+ID4+ICsrKyBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9h
c3QxNzAwLmgNCj4gPj4gQEAgLTEyLDYgKzEyLDcgQEANCj4gPj4gICAjaW5jbHVkZSAiaHcvbWlz
Yy9hc3BlZWRfc2N1LmgiDQo+ID4+ICAgI2luY2x1ZGUgImh3L2FkYy9hc3BlZWRfYWRjLmgiDQo+
ID4+ICAgI2luY2x1ZGUgImh3L2dwaW8vYXNwZWVkX2dwaW8uaCINCj4gPj4gKyNpbmNsdWRlICJo
dy9ncGlvL2FzcGVlZF9zZ3Bpby5oIg0KPiA+DQo+ID4gQXMgZmFyIGFzIEkgY2FuIHRlbGwgdGhp
cyBkZXBlbmRzIG9uIFl1YmluIFpvdSdzIFNHUElPIHNlcmllcyAobGluayBiZWxvdyk/DQo+ID4g
RG9lcyB0aGF0IG1lYW4gdGhlIHNlcmllcyBsb29rcyBnb29kPyBDYW4geW91IHJlcGx5IHRvIHRo
ZSBzZXJpZXMNCj4gPiBpdHNlbGYgaWYgaXQgaXM/DQo+ID4NCj4gPg0KPiA+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnLy9xZW11LWRldmVsLzIwMjUxMTA2LWFzcGVlZC1zZ3Bpby12MS0wLWIwMjYw
OTMNCj4gPiA3MTZmYUBnb29nbGUuY29tDQo+IA0KPiANCj4gTmFiaWgsIEthbmUsIEphbWluLA0K
PiANCj4gQ291bGQgeW91IHBsZWFzZSBoZWxwIHJldmlldyBZdWJpbidzIHNlcmllcyA/DQo+IA0K
DQpDw6lkcmljLCBOYWJpaA0KDQpTb3JyeSwgSeKAmW0gY3VycmVudGx5IHN0dWNrIHdpdGggQVNU
MjcwMCBBMiBTREsgZGV2ZWxvcG1lbnQuDQpJ4oCZdmUgYXNrZWQgS2FuZSB0byBoZWxwIHRlc3Qg
dGhlIFl1YmluJ3MgU0dQSU8gbW9kZWwuDQpPbmNlIEkgaGF2ZSB0aW1lLCBJIHdpbGwgdHJ5IHRv
IHRlc3QgSm9l4oCZcyBJM0MgbW9kZWwuDQoNCkphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4N
Cj4gDQo+IA0KPiA+PiAgICNpbmNsdWRlICJody9pMmMvYXNwZWVkX2kyYy5oIg0KPiA+PiAgICNp
bmNsdWRlICJody9taXNjL2FzcGVlZF9sdHBpLmgiDQo+ID4+ICAgI2luY2x1ZGUgImh3L21pc2Mv
YXNwZWVkX3B3bS5oIg0KPiA+PiBAQCAtMTksNiArMjAsNyBAQA0KPiA+PiAgICNpbmNsdWRlICJo
dy93YXRjaGRvZy93ZHRfYXNwZWVkLmgiDQo+ID4+ICAgI2luY2x1ZGUgImh3L2NoYXIvc2VyaWFs
LW1tLmgiDQo+ID4+DQo+ID4+ICsjZGVmaW5lIEFTVDE3MDBfU0dQSU9fTlVNICAgICAgICAgICAg
Mg0KPiA+PiAgICNkZWZpbmUgQVNUMTcwMF9XRFRfTlVNICAgICAgICAgICAgICA5DQo+ID4+DQo+
ID4+ICAgI2RlZmluZSBUWVBFX0FTUEVFRF9BU1QxNzAwICJhc3BlZWQuYXN0MTcwMCINCj4gPj4g
QEAgLTM5LDYgKzQxLDcgQEAgc3RydWN0IEFzcGVlZEFTVDE3MDBTb0NTdGF0ZSB7DQo+ID4+ICAg
ICAgIEFzcGVlZEFEQ1N0YXRlIGFkYzsNCj4gPj4gICAgICAgQXNwZWVkU0NVU3RhdGUgc2N1Ow0K
PiA+PiAgICAgICBBc3BlZWRHUElPU3RhdGUgZ3BpbzsNCj4gPj4gKyAgICBBc3BlZWRTR1BJT1N0
YXRlIHNncGlvbVtBU1QxNzAwX1NHUElPX05VTV07DQo+ID4+ICAgICAgIEFzcGVlZEkyQ1N0YXRl
IGkyYzsNCj4gPj4gICAgICAgQXNwZWVkUFdNU3RhdGUgcHdtOw0KPiA+PiAgICAgICBBc3BlZWRX
RFRTdGF0ZSB3ZHRbQVNUMTcwMF9XRFRfTlVNXTsgZGlmZiAtLWdpdA0KPiA+PiBhL2h3L2FybS9h
c3BlZWRfYXN0MTcwMC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMgaW5kZXgNCj4gPj4gYzlk
N2E5N2E4MC4uZTAyN2FlMDJhZCAxMDA2NDQNCj4gPj4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3Qx
NzAwLmMNCj4gPj4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMNCj4gPj4gQEAgLTIzLDYg
KzIzLDggQEAgZW51bSB7DQo+ID4+ICAgICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9BREMsDQo+ID4+
ICAgICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9TQ1UsDQo+ID4+ICAgICAgIEFTUEVFRF9BU1QxNzAw
X0RFVl9HUElPLA0KPiA+PiArICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9TR1BJT00wLA0KPiA+PiAr
ICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9TR1BJT00xLA0KPiA+PiAgICAgICBBU1BFRURfQVNUMTcw
MF9ERVZfSTJDLA0KPiA+PiAgICAgICBBU1BFRURfQVNUMTcwMF9ERVZfVUFSVDEyLA0KPiA+PiAg
ICAgICBBU1BFRURfQVNUMTcwMF9ERVZfTFRQSV9DVFJMLA0KPiA+PiBAQCAtMzcsNiArMzksOCBA
QCBzdGF0aWMgY29uc3QgaHdhZGRyIGFzcGVlZF9hc3QxNzAwX2lvX21lbW1hcFtdID0NCj4gew0K
PiA+PiAgICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX0FEQ10gICAgICAgPSAgMHgwMEMwMDAwMCwN
Cj4gPj4gICAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9TQ1VdICAgICAgID0gIDB4MDBDMDIwMDAs
DQo+ID4+ICAgICAgIFtBU1BFRURfQVNUMTcwMF9ERVZfR1BJT10gICAgICA9ICAweDAwQzBCMDAw
LA0KPiA+PiArICAgIFtBU1BFRURfQVNUMTcwMF9ERVZfU0dQSU9NMF0gICA9ICAweDAwQzBDMDAw
LA0KPiA+PiArICAgIFtBU1BFRURfQVNUMTcwMF9ERVZfU0dQSU9NMV0gICA9ICAweDAwQzBEMDAw
LA0KPiA+PiAgICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX0kyQ10gICAgICAgPSAgMHgwMEMwRjAw
MCwNCj4gPj4gICAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9VQVJUMTJdICAgID0gIDB4MDBDMzNC
MDAsDQo+ID4+ICAgICAgIFtBU1BFRURfQVNUMTcwMF9ERVZfTFRQSV9DVFJMXSA9ICAweDAwQzM0
MDAwLCBAQCAtMTQyLDYNCj4gKzE0NiwxNg0KPiA+PiBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfYXN0
MTcwMF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCj4gPj4NCj4gYXNw
ZWVkX2FzdDE3MDBfaW9fbWVtbWFwW0FTUEVFRF9BU1QxNzAwX0RFVl9MVFBJX0NUUkxdLA0KPiA+
Pg0KPiA+PiBzeXNidXNfbW1pb19nZXRfcmVnaW9uKFNZU19CVVNfREVWSUNFKCZzLT5sdHBpKSwg
MCkpOw0KPiA+Pg0KPiA+PiArICAgIC8qIFNHUElPTSAqLw0KPiA+PiArICAgIGZvciAoaW50IGkg
PSAwOyBpIDwgQVNUMTcwMF9TR1BJT19OVU07IGkrKykgew0KPiA+PiArICAgICAgICBpZiAoIXN5
c2J1c19yZWFsaXplKFNZU19CVVNfREVWSUNFKCZzLT5zZ3Bpb21baV0pLCBlcnJwKSkgew0KPiA+
PiArICAgICAgICAgICAgcmV0dXJuOw0KPiA+PiArICAgICAgICB9DQo+ID4+ICsgICAgICAgIG1l
bW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbigmcy0+aW9tZW0sDQo+ID4+ICsNCj4gYXNwZWVkX2Fz
dDE3MDBfaW9fbWVtbWFwW0FTUEVFRF9BU1QxNzAwX0RFVl9TR1BJT00wICsgaV0sDQo+ID4+ICsN
Cj4gc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihTWVNfQlVTX0RFVklDRSgmcy0+c2dwaW9tW2ldKSwg
MCkpOw0KPiA+PiArICAgIH0NCj4gPj4gKw0KPiA+PiAgICAgICAvKiBXRFQgKi8NCj4gPj4gICAg
ICAgZm9yIChpbnQgaSA9IDA7IGkgPCBBU1QxNzAwX1dEVF9OVU07IGkrKykgew0KPiA+PiAgICAg
ICAgICAgQXNwZWVkV0RUQ2xhc3MgKmF3YyA9DQo+IEFTUEVFRF9XRFRfR0VUX0NMQVNTKCZzLT53
ZHRbaV0pOyBAQA0KPiA+PiAtMTk0LDYgKzIwOCwxMiBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfYXN0
MTcwMF9pbnN0YW5jZV9pbml0KE9iamVjdCAqb2JqKQ0KPiA+PiAgICAgICBvYmplY3RfaW5pdGlh
bGl6ZV9jaGlsZChvYmosICJsdHBpLWN0cmwiLA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmcy0+bHRwaSwgVFlQRV9BU1BFRURfTFRQSSk7DQo+ID4+DQo+ID4+ICsgICAgLyog
U0dQSU9NICovDQo+ID4+ICsgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBBU1QxNzAwX1NHUElPX05V
TTsgaSsrKSB7DQo+ID4+ICsgICAgICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImlv
ZXhwLXNncGlvbVsqXSIsICZzLT5zZ3Bpb21baV0sDQo+ID4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJhc3BlZWQuc2dwaW8tYXN0MjcwMCIpOw0KPiA+PiArICAgIH0NCj4gPj4g
Kw0KPiA+PiAgICAgICAvKiBXRFQgKi8NCj4gPj4gICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBB
U1QxNzAwX1dEVF9OVU07IGkrKykgew0KPiA+PiAgICAgICAgICAgb2JqZWN0X2luaXRpYWxpemVf
Y2hpbGQob2JqLCAiaW9leHAtd2R0WypdIiwNCj4gPj4gLS0NCj4gPj4gMi40My4wDQo+ID4+DQo+
ID4+DQoNCg==

