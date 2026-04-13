Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EE9E9381A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 05:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC9gZ-0007bS-UK; Mon, 13 Apr 2026 01:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wC9gY-0007ak-BS; Mon, 13 Apr 2026 01:18:10 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wC9gW-0002mP-Hy; Mon, 13 Apr 2026 01:18:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7pb6k5XOoqfGMBAtMq10ELJ79G4uUkJTSdthwi7KeWWfzO4yhiENCI61SndkXygAjjqgxneAMPFeU/mU6PzlxAOH3ztJc9zueE4WW5/dDFnRLHxdF9pUpOHOCZgC/V7F7DXGyeZJBGDY2UwvwS4NeCJYCeWoe/xJ39MTaq12SEeHChQ5RMPDILtICyq/BkYRUzvUyAi/5TpeZpUsatYR8yhxAxSJeRGpvjmL9Bx/44OEZs2sWh3gbIIEx+5i178Vw3MFwE8K+3tHo5ReeYj8bj7GVrjdToBXVUvDKiIeYuXRluywZxcaS9mRsoO2g3eTg/AOn30xOG+huYZwm5SzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK4G9Md1XGQN64ZIONY1jXr06cH+5Jjxzyz1rj8UtFg=;
 b=qBJVLrh1uS55+281D6g/vRNr0bBueKxfySdInm7pgqTbapoL6uFqzHl6TZdERkAsArM+g9ob2RH70X4SQNG0Ahp6n7FWvVi/CH2yOo3FA9rtoCHeQGvLtxjIm95D3Lzesl7MHdDJc8PqW97X+TapPISWF2jSG8X8ZXLfAxdxtuLtBMcQmWmyYZzkLnYxKJG/Qv64UU+MhI3tS7y8ViQQ2j+1PiEGlGwKNMNnGw62Gl/Nd9tqX9VB49mvHXVrXjYrneclYoqKuVglxoIMdlfct7cvYCJgmaHiPJTVgE6emWA6S6OlCHLIDdIG8VlxwuwXFrcfHRTn4H5Xd/kX6LpVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK4G9Md1XGQN64ZIONY1jXr06cH+5Jjxzyz1rj8UtFg=;
 b=IRe/1M6YzSYoS3dvIhgBQvV1ZJxdnBvzMfG/GSirgbFOjGIG5cjiKFdFmGKHoHMZeMYjkGH8Z366VtVRMHnKXkl2W7gWM38uY21XjYs4rsRIcrDrBhYHtyEG+6KGNxZTf6lUDvtWcTu7Q8rhSCjuY3p26R429ATq6hImGwb0ATod3ZGOTGCcrtX69Q0WpjYNzaueEMkkNDA+HGDDUmGK49ICqbJSyszV6Is7T7JzUVWKLrDIAdInu14bwd2HIH0bVMkYWW7bCsf2kCaykpKwzuRCSRaB62RXRCFEqf+BMqdtzycuhNg3AnWtu3SqLp/6iG472yna8OC9OyeSxw0rMA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8226.apcprd06.prod.outlook.com (2603:1096:604:45b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 05:18:03 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 05:18:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v1 04/13] hw/usb/trace-events: Print EHCI queue and
 transfer addresses as 64-bit
Thread-Topic: [PATCH v1 04/13] hw/usb/trace-events: Print EHCI queue and
 transfer addresses as 64-bit
Thread-Index: AQHcsShbJnX4/GuM80W2I7JPs5eLhrXb1m2AgADQ3IA=
Date: Mon, 13 Apr 2026 05:18:02 +0000
Message-ID: <TYPPR06MB8206B143B522B7B8B4BABD69FC242@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-5-jamin_lin@aspeedtech.com>
 <b2cc5d66-ee2b-4f65-840d-839891ca2b90@kaod.org>
In-Reply-To: <b2cc5d66-ee2b-4f65-840d-839891ca2b90@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8226:EE_
x-ms-office365-filtering-correlation-id: 007a29c8-8003-4354-3bd3-08de991c0965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 7NmjcTL4oo7aLi99ygeqlTdrytmtd7K9KPMm+BBhhoZuCTESEf+7sZUHZ1yb2pHE1sAiV3AkPsoJSXbCd5Jbxwj0SehncYpQFnwGFhCSMM09g4aSHiKOHlUnRsTmlnncECpD67LqbB1trJ2P0kaSyYWDt5HsRZFKvjfp4SjZjU9iuyEjP6xSxj9e4Tmn1ZKBXCDHTeCjh5PjkaLHlHcQITlCaGiZnOXU4gXnNt8uR+1VBQK6MDhe6r1lAZc/uC4B99LhwVsfrM121MRpYU0ESQ1ZpEiPDTAlJ6KKTP5iYBLz7ZX1NqLD4BFnL8+6JnCMV7wuXFJGR1gI9gAeWNs7zGm4aGsHa831YEJ7iAWQSdsVcidmMGVv91tqyve9/kfxFvXHg2smhhnMbUeo4RDWpWJ7NAPM+4F6mXTxvAeXg/jciTFO8zdbqSPB10Ad0wBNlFLt6+FJUjCeX37WE5bRfWsCjBKyh1owWBUnQzDCFq4+7LIu1ve3ekOzPXv/YGmMxQfao3zRNVrm5RA1ldJB4fIeA3XlYsY8mSs0h7tEYbxDwzT+TblOYFPp2Itnv/Anp2O3/hagjzuH8ymW0IZMhmjdea3jOkrGIbQRhQDII4niUWmfU23TxcZATs6oqS2VKGoptBTcMsN9jW3E0wQgmksEqEf/dT15iDXk/CeHOtV3L/w7oI/chfm88Fj7FW1DBl2et4hM/6WHmftzt73eF9lE3k0QT/+9iNheBK5SSNy2qY9gR/1AxEsDGu0zWPvyNpCwwB8n6119lbkFm75IDZcySySHWMUsX9ejDNg1UhQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUNKMElhaU1FOVV3TlF0a01qZ2YwSlN5Z1VDejZYK2wvUjhkbWhmdndzMXlp?=
 =?utf-8?B?SHpyU3A1QlloSXpxZ2tNUlkwNGhOZVRMK28xbS8zSnY2THEzU2JxWEJWUVNi?=
 =?utf-8?B?S3dkbW8rcUg4bDlBZUl2RWJuWjdEZnhZSE5WWU9KYkgwdGRZbWlzbnhtUFVu?=
 =?utf-8?B?Y2JYYjJNQWphN0x2KzlyWUZuYkUzU3VQMVNMZ2ZJVVNSbG5heEhWOFR0dklD?=
 =?utf-8?B?RUx1WEdzVFJtSXZ4RWxjR0NkWEFQZXVYMnNXR3VVMVhPTldZOXBVeWZuaTBu?=
 =?utf-8?B?WEZ6aWtFKzJhU0FEblZMbzl2UFhKeTArVkkwOFg5Z2lEbFl2eFhJaVNJY053?=
 =?utf-8?B?a3ZxZnR4bnJ1STVUZmFIRnNQUmxMVVMwaTY5eEFjVEZpYldTS21pQ3VidytX?=
 =?utf-8?B?aVd1ZUtWS1czWllKSkZRRmloVXVDN0lGeXNXSkQ4UUIyUjBpNUwzWEozSHdO?=
 =?utf-8?B?OWZHYTVzdTU3ZFU4MDE2c0EwQ0RlWnVQdHZ5WkRFbXp1NG50ZGZpNU45RVNp?=
 =?utf-8?B?dmdzb0J5YThhSnlCclo2RCtCR096bXRFNlZqVm00Wlh4am93Zm5pSWlvb3d3?=
 =?utf-8?B?ckE3bjNIN3NpRGVMcHNHdDVtNVI2ZVlMbVlGdDcwZFZmcW8wWFUwZmRudzd1?=
 =?utf-8?B?ZUhmbkxSbVBGeHp3eHIrWks2VkZ2dlUveXFWUlo2NXdBZHI4bTNtUjRPdzRv?=
 =?utf-8?B?SVRSNUJxbjF2ZDIxVjM1NU03U1kzdFNnekN6MnVyaWFNWjlnNm9DelBzTUw1?=
 =?utf-8?B?aThPaE1MVmh3VGwwVE4vTnhrWGVPWEFhSlRzeDRLUERKOW9hdUpOT3pqUUhV?=
 =?utf-8?B?MnpFcnArbWV1ZnZJczFkWjJhVGRZKzZpSFJLdkVndVExSlJUQUFpOG56ZHFq?=
 =?utf-8?B?bGpralNpSGlUL2llYm04ZWl2eXlRdlEzTkx1ZzVRN2pJYk5ySW51NjAreENG?=
 =?utf-8?B?ODR6NHdsYU8zWFRkSjFTOWl2WW9KUkxET2Z1aEpRTTdUdDdOMzMzUUFmRFBx?=
 =?utf-8?B?cXlEMHEyRHA4aHVLbVFNL2JTeG1lQUxnaXUwZHp0YjRkdzRIeHVhdFBjZnpO?=
 =?utf-8?B?RDQ2WEJZZ05BeC8rOFRRZTZmUDZUWFNrVVZlSkxoQU1ETUxjb3hDUzFnRjRE?=
 =?utf-8?B?ajg3RXpDNG1FWmxDaUdmcC9wL0IzNis5b2syVzZ4bWZHeTZkVjFmWkNpN095?=
 =?utf-8?B?Y3pBUTJySVJKNGxId1ZaanNmVFpaRVI0T1VsRzJoQzl6OHlweXB2OTR4TzNI?=
 =?utf-8?B?Q0lFY2dHRGp5eEVlQUNUNUtSaXgxT1doNnArOGlZd1YzTm9UQ29YZ2tDQmY5?=
 =?utf-8?B?VVZYOXVTaENyK2l5NXRTWWt0TjhKWjZCcVVwNVFWN3dwZTlXN0NodWxRR2s3?=
 =?utf-8?B?VlRZdFJvVVF6Ryt1Mk8zWGhUcnAycnVhMnh5Y3hiL0k2WUdWTkNYd1UzdlU3?=
 =?utf-8?B?YUNXMnJwUFArNVVqYXNUMVdTaGEyNTVaUTJacXozZFZFMk4wODA1bDVsVmJY?=
 =?utf-8?B?SUExODFld2I0ckFTZlBmYkZhQUxvcW9RSTJMVE80enI5UmtQeFdHdG8xS0wr?=
 =?utf-8?B?UzJzOWNGVng3Wkx0dm03MHdqY0VHdnhReXVZZWhXUm03TVN1ZndLOWh0czFL?=
 =?utf-8?B?YUpNcDB3S2JaMVovL21PN1M4R3Awd2N3bzFLWTA4Y3FvelVqL3p0S2FDb3Ji?=
 =?utf-8?B?Z2hxZFBnRVQ5bUIvazVpUnJqVzNTYjUxQ0JYbFlIV1RFNndmdmZraUFTOFU4?=
 =?utf-8?B?dWJ6YmJ3RDM0d094VERhcTRTTHFqTWRqTnFCcFE5bDc3ajJUOFR0dWtmbVlm?=
 =?utf-8?B?NjY3Q3g4dEhvWXdBSm9UMHhRYndKbGFWK1IrcUNtaU5JNnVPV3dxVjF4dHRU?=
 =?utf-8?B?UWZUYmJIVTYwZGo2b01WQXQvd1dkRzY0ZmpodUc4Rzg0MnlWYjNhTmFYRFg0?=
 =?utf-8?B?MklLN25zSzhzcjQ4U045VjdiWFdiVTNnVm53RTZFSXB4ZTM3Q01XT2V5R0RO?=
 =?utf-8?B?VWUwekRyWXpUbHFOZkRUMTJDMHhlZi8rMElQWWxpNmFJTkd4MTVIekpZOHRM?=
 =?utf-8?B?RktQZXk2MUhTd01CdnNyd1RHam5MM1ZPc3VzTnAwYldwM254ejBHYzNic092?=
 =?utf-8?B?akp4bXRPUUtDN1RJZ3ZpSVlnTWxXTWZDaU9Hb2U4RHQ0ZTIxQmZXUEt4TE4r?=
 =?utf-8?B?NHFLNWswdzlWSGZ3c2xwdUh6d2NwNXVRZXlPYXpRR3dCUS9xMmZUcVorS2pi?=
 =?utf-8?B?ZGxGd1ZtK1RVdkphTWdZTmNnRTR6SWoyTU1HMjZFVzV2Z29zVUpmNlFWY0M1?=
 =?utf-8?B?NEtZL3liNUlETE1uZGFKWWhOQVVpSTd4Yjhvc3VPRlArNGJCZDBMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZbZ9QPfWP7qf1AQMHRDdu9Db95LZz7yGT7moQX9gqYj26jxpBkPJ7zcxm611D8NugKOlWm91o1lY0ipABy4bp4Wy1qy3/l9Bu3/smEML4eWqWpS17wBBCzm1Y63r28saE+d2w7csTQnVRJc1hCM+9cbMddMZ58EHYYwEh/xEtgyZRfFVXcw/+esqfDRrXRaWvOaVWM6EyG8tfLIgMFkDnx8Gj/HOncO25imvi6EVcPFJO5DrzkSfdoFqqb9CUZB67GNiHU2VHp8Ltx90f0gzljnWcsxq3OUOLpxTocIpt2s+NtIj7nkRepfxskHDg9QB8C9hIP6Op9qlylYKXFTGog==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007a29c8-8003-4354-3bd3-08de991c0965
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 05:18:02.8804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +CIDN6cdJ7xks9BWAQT/B+nIqyP9awjj/DlMNqnF8bYLLVGA/PuQlO/5pLpT0uuRTXkWvwPf/LUk1p/H4BzDmKay0r7PY8+I5OAaR6upKas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8226
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDQvMTNdIGh3L3VzYi90cmFj
ZS1ldmVudHM6IFByaW50IEVIQ0kgcXVldWUgYW5kDQo+IHRyYW5zZmVyIGFkZHJlc3NlcyBhcyA2
NC1iaXQNCj4gDQo+IE9uIDMvMTEvMjYgMDg6MjYsIEphbWluIExpbiB3cm90ZToNCj4gPiBVcGRh
dGUgdGhlIEVIQ0kgdHJhY2UtZXZlbnRzIHByb3RvdHlwZXMgZm9yIFFILCBxVEQsIGlURCwgYW5k
IHNpVEQgdG8NCj4gPiB1c2UgdWludDY0X3QgZm9yIHRoZSBhZGRyZXNzIGFyZ3VtZW50IGFuZCBw
cmludCBpdCB3aXRoIFBSSXg2NC4gVGhpcw0KPiA+IGVuc3VyZXMgZnVsbCA2NC1iaXQgYWRkcmVz
c2VzIGFyZSBzaG93biBpbiB0cmFjZSBvdXRwdXQgYW5kIGltcHJvdmVzDQo+ID4gZGVidWdnaW5n
IG9mIHF1ZXVlIGhlYWRzIGFuZCB0cmFuc2ZlciBkZXNjcmlwdG9ycy4NCj4gPg0KPiA+IFRoaXMg
Y2hhbmdlIG9ubHkgYWZmZWN0cyB0cmFjZSBmb3JtYXR0aW5nIGFuZCBkb2VzIG5vdCBtb2RpZnkg
dGhlIEVIQ0kNCj4gPiBkYXRhIHN0cnVjdHVyZSBsYXlvdXQgb3IgYmVoYXZpb3IuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4g
DQo+IEkgdGhpbmsgdGhpcyBjaGFuZ2Ugc2hvdWxkIGJlIG1lcmdlZCBpbiB0aGUgcHJldmlvdXMg
cGF0Y2guDQo+IA0KDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlvbnMuDQpX
aWxsIG1lcmdlIHRoZW0uDQoNCkphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+ID4g
LS0tDQo+ID4gICBody91c2IvdHJhY2UtZXZlbnRzIHwgMTYgKysrKysrKystLS0tLS0tLQ0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9ody91c2IvdHJhY2UtZXZlbnRzIGIvaHcvdXNiL3RyYWNlLWV2ZW50
cyBpbmRleA0KPiA+IGRkMDRmMTRhZGQuLmVjZDg0ZTU0YzAgMTAwNjQ0DQo+ID4gLS0tIGEvaHcv
dXNiL3RyYWNlLWV2ZW50cw0KPiA+ICsrKyBiL2h3L3VzYi90cmFjZS1ldmVudHMNCj4gPiBAQCAt
ODYsMTQgKzg2LDE0IEBAIHVzYl9laGNpX3BvcnRzY193cml0ZSh1aW50MzJfdCBhZGRyLCB1aW50
MzJfdCBwb3J0LA0KPiB1aW50MzJfdCB2YWwpICJ3ciBtbWlvIDB4JTA0DQo+ID4gICB1c2JfZWhj
aV9wb3J0c2NfY2hhbmdlKHVpbnQzMl90IGFkZHIsIHVpbnQzMl90IHBvcnQsIHVpbnQzMl90IG5l
dywNCj4gdWludDMyX3Qgb2xkKSAiY2ggbW1pbyAweCUwNHggW3BvcnQgJWRdID0gMHgleCAob2xk
OiAweCV4KSINCj4gPiAgIHVzYl9laGNpX3VzYnN0cyhjb25zdCBjaGFyICpzdHMsIGludCBzdGF0
ZSkgInVzYnN0cyAlcyAlZCINCj4gPiAgIHVzYl9laGNpX3N0YXRlKGNvbnN0IGNoYXIgKnNjaGVk
dWxlLCBjb25zdCBjaGFyICpzdGF0ZSkgIiVzIHNjaGVkdWxlICVzIg0KPiA+IC11c2JfZWhjaV9x
aF9wdHJzKHZvaWQgKnEsIHVpbnQzMl90IGFkZHIsIHVpbnQzMl90IG54dCwgdWludDMyX3QgY19x
dGQsDQo+IHVpbnQzMl90IG5fcXRkLCB1aW50MzJfdCBhX3F0ZCkgInEgJXAgLSBRSCBAIDB4JTA4
eDogbmV4dCAweCUwOHggcXRkcw0KPiAweCUwOHgsMHglMDh4LDB4JTA4eCINCj4gPiAtdXNiX2Vo
Y2lfcWhfZmllbGRzKHVpbnQzMl90IGFkZHIsIGludCBybCwgaW50IG1wbGVuLCBpbnQgZXBzLCBp
bnQgZXAsIGludA0KPiBkZXZhZGRyKSAiUUggQCAweCUwOHggLSBybCAlZCwgbXBsZW4gJWQsIGVw
cyAlZCwgZXAgJWQsIGRldiAlZCINCj4gPiAtdXNiX2VoY2lfcWhfYml0cyh1aW50MzJfdCBhZGRy
LCBpbnQgYywgaW50IGgsIGludCBkdGMsIGludCBpKSAiUUggQCAweCUwOHggLSBjDQo+ICVkLCBo
ICVkLCBkdGMgJWQsIGkgJWQiDQo+ID4gLXVzYl9laGNpX3F0ZF9wdHJzKHZvaWQgKnEsIHVpbnQz
Ml90IGFkZHIsIHVpbnQzMl90IG54dCwgdWludDMyX3QgYWx0bmV4dCkgInENCj4gJXAgLSBRVEQg
QCAweCUwOHg6IG5leHQgMHglMDh4IGFsdG5leHQgMHglMDh4Ig0KPiA+IC11c2JfZWhjaV9xdGRf
ZmllbGRzKHVpbnQzMl90IGFkZHIsIGludCB0Ynl0ZXMsIGludCBjcGFnZSwgaW50IGNlcnIsIGlu
dCBwaWQpDQo+ICJRVEQgQCAweCUwOHggLSB0Ynl0ZXMgJWQsIGNwYWdlICVkLCBjZXJyICVkLCBw
aWQgJWQiDQo+ID4gLXVzYl9laGNpX3F0ZF9iaXRzKHVpbnQzMl90IGFkZHIsIGludCBpb2MsIGlu
dCBhY3RpdmUsIGludCBoYWx0LCBpbnQgYmFiYmxlLCBpbnQNCj4geGFjdGVycikgIlFURCBAIDB4
JTA4eCAtIGlvYyAlZCwgYWN0aXZlICVkLCBoYWx0ICVkLCBiYWJibGUgJWQsIHhhY3RlcnIgJWQi
DQo+ID4gLXVzYl9laGNpX2l0ZCh1aW50MzJfdCBhZGRyLCB1aW50MzJfdCBueHQsIHVpbnQzMl90
IG1wbGVuLCB1aW50MzJfdCBtdWx0LA0KPiB1aW50MzJfdCBlcCwgdWludDMyX3QgZGV2YWRkcikg
IklURCBAIDB4JTA4eDogbmV4dCAweCUwOHggLSBtcGxlbiAlZCwgbXVsdA0KPiAlZCwgZXAgJWQs
IGRldiAlZCINCj4gPiAtdXNiX2VoY2lfc2l0ZCh1aW50MzJfdCBhZGRyLCB1aW50MzJfdCBueHQs
IHVpbnQzMl90IGFjdGl2ZSkgIklURCBAIDB4JTA4eDoNCj4gbmV4dCAweCUwOHggLSBhY3RpdmUg
JWQiDQo+ID4gK3VzYl9laGNpX3FoX3B0cnModm9pZCAqcSwgdWludDY0X3QgYWRkciwgdWludDMy
X3Qgbnh0LCB1aW50MzJfdCBjX3F0ZCwNCj4gdWludDMyX3Qgbl9xdGQsIHVpbnQzMl90IGFfcXRk
KSAicSAlcCAtIFFIIEAgMHglIiBQUkl4NjQgIjogbmV4dCAweCUwOHggcXRkcw0KPiAweCUwOHgs
MHglMDh4LDB4JTA4eCINCj4gPiArdXNiX2VoY2lfcWhfZmllbGRzKHVpbnQ2NF90IGFkZHIsIGlu
dCBybCwgaW50IG1wbGVuLCBpbnQgZXBzLCBpbnQgZXAsIGludA0KPiBkZXZhZGRyKSAiUUggQCAw
eCUiIFBSSXg2NCAiIC0gcmwgJWQsIG1wbGVuICVkLCBlcHMgJWQsIGVwICVkLCBkZXYgJWQiDQo+
ID4gK3VzYl9laGNpX3FoX2JpdHModWludDY0X3QgYWRkciwgaW50IGMsIGludCBoLCBpbnQgZHRj
LCBpbnQgaSkgIlFIIEAgMHglIg0KPiBQUkl4NjQgIiAtIGMgJWQsIGggJWQsIGR0YyAlZCwgaSAl
ZCINCj4gPiArdXNiX2VoY2lfcXRkX3B0cnModm9pZCAqcSwgdWludDY0X3QgYWRkciwgdWludDMy
X3Qgbnh0LCB1aW50MzJfdCBhbHRuZXh0KSAicQ0KPiAlcCAtIFFURCBAIDB4JSIgUFJJeDY0ICI6
IG5leHQgMHglMDh4IGFsdG5leHQgMHglMDh4Ig0KPiA+ICt1c2JfZWhjaV9xdGRfZmllbGRzKHVp
bnQ2NF90IGFkZHIsIGludCB0Ynl0ZXMsIGludCBjcGFnZSwgaW50IGNlcnIsIGludCBwaWQpDQo+
ICJRVEQgQCAweCUiIFBSSXg2NCAiIC0gdGJ5dGVzICVkLCBjcGFnZSAlZCwgY2VyciAlZCwgcGlk
ICVkIg0KPiA+ICt1c2JfZWhjaV9xdGRfYml0cyh1aW50NjRfdCBhZGRyLCBpbnQgaW9jLCBpbnQg
YWN0aXZlLCBpbnQgaGFsdCwgaW50IGJhYmJsZSwgaW50DQo+IHhhY3RlcnIpICJRVEQgQCAweCUi
IFBSSXg2NCAiIC0gaW9jICVkLCBhY3RpdmUgJWQsIGhhbHQgJWQsIGJhYmJsZSAlZCwgeGFjdGVy
cg0KPiAlZCINCj4gPiArdXNiX2VoY2lfaXRkKHVpbnQ2NF90IGFkZHIsIHVpbnQzMl90IG54dCwg
dWludDMyX3QgbXBsZW4sIHVpbnQzMl90IG11bHQsDQo+IHVpbnQzMl90IGVwLCB1aW50MzJfdCBk
ZXZhZGRyKSAiSVREIEAgMHglIiBQUkl4NjQgIjogbmV4dCAweCUwOHggLSBtcGxlbiAlZCwNCj4g
bXVsdCAlZCwgZXAgJWQsIGRldiAlZCINCj4gPiArdXNiX2VoY2lfc2l0ZCh1aW50NjRfdCBhZGRy
LCB1aW50MzJfdCBueHQsIHVpbnQzMl90IGFjdGl2ZSkgIlNJVEQgQCAweCUiDQo+IFBSSXg2NCAi
OiBuZXh0IDB4JTA4eCAtIGFjdGl2ZSAlZCINCj4gPiAgIHVzYl9laGNpX3BvcnRfYXR0YWNoKHVp
bnQzMl90IHBvcnQsIGNvbnN0IGNoYXIgKm93bmVyLCBjb25zdCBjaGFyDQo+ICpkZXZpY2UpICJh
dHRhY2ggcG9ydCAjJWQsIG93bmVyICVzLCBkZXZpY2UgJXMiDQo+ID4gICB1c2JfZWhjaV9wb3J0
X2RldGFjaCh1aW50MzJfdCBwb3J0LCBjb25zdCBjaGFyICpvd25lcikgImRldGFjaCBwb3J0DQo+
ICMlZCwgb3duZXIgJXMiDQo+ID4gICB1c2JfZWhjaV9wb3J0X3Jlc2V0KHVpbnQzMl90IHBvcnQs
IGludCBlbmFibGUpICJyZXNldCBwb3J0ICMlZCAtICVkIg0KDQo=

