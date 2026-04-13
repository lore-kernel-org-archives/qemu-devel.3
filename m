Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD984E9381A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 05:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC9mA-0000cG-CW; Mon, 13 Apr 2026 01:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wC9m6-0000ag-Am; Mon, 13 Apr 2026 01:23:54 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wC9m3-0004ih-BN; Mon, 13 Apr 2026 01:23:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmU3W0+Uy2svMLkyJD5BMEMmALxB0QbwfcxsFvCxCBbD9StrpYAkPdBMaMh1onVWAlDEY4pBpmWRb1yPd6lrrVD1JUv5w1vTAlyqpj5/WvCZdEy9MjfQvZhz8Ernqd7HkUtHt8S/K5I62pyIUVeqzO/wrSqKxX1VJAR7dXVB9NxJ5leF1MbXDvPVjR5lsg80I/cPzBC13yY8lpKylvlYiHu0MU6rABEuQwozUqXCzDo0x4ClyN/h4HDUoVDMoRz01pDFcF3HuVxfSABYsrEPKkEm8aG+Tq+a8JWdFOVfZ+jvQzDoz3DdK5LBSbgvc8QmbRfCkobTEW+CD6X9t7BlKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQm8K/A5QnIStIYkmWCZ1iO6EzB7P8k2TsQ11QhmOUU=;
 b=oEEUgEjw+iqIftYEYkzrzkJSRa82WohVUlHCRN7VlkvX7EX928RHKNQuftiWkQumt65DAD0ffX0WdkyG3uUaa6tWPQj3V43o3qjsc8rZOtZK1x8ssROkmKQzcDPf3TPx+cJkI9Bre6Iao5x0B6/dVJJkiO+CMBOwTmqdkIGGRYNuLc7vbSIcf/EDotHXwC0QAWjRHCEf+xZ+jrEW2Kzkpwg4dqBbOxqT83quLNBK1717vEum5DHLP0kI+J9pmoBUkclnQNDdLwkIzcgOr88JeTYhyyKQSodHAHobt++kf70dNVnNOw2ZSWML3N23RnCvDMD6YJyUK6Ij25Ec+4cMRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQm8K/A5QnIStIYkmWCZ1iO6EzB7P8k2TsQ11QhmOUU=;
 b=jYJ/JqkOxwUl50JLZx4vd8QaqQno0rIl4bJeW265HnMVno8zKawQ+jAMCrSfQN4mdHLOjx4kxtfn+XY+R0WaTDyvvdWia8whbKqgNOA8748Laef+4qGrAfjUQZIUgUACK2vIVfz3Cyh/n+bX5yaFNXItuHKSu43uiJqjJ8TVhf1sL6sWufRuQX+BNybF/rptbxeFnIhRX9gtgpUQuG3d2Ka44o4Rmn6+CaGrgw4UAMFtfQGQqEGA7b4lublOx5+LDV0shjysTU7G8HnBjsdOslppzlc3nHpEk6Y4qAAIjdT/ZBh5RXqo/r+prcarH0/zhFGosbwt+J6UEPJomaVIPQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB7226.apcprd06.prod.outlook.com (2603:1096:101:234::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 05:23:46 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 05:23:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v1 06/13] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes
 without 64-bit capability
Thread-Topic: [PATCH v1 06/13] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes
 without 64-bit capability
Thread-Index: AQHcsShdLGpD8fDkyk64iqNp0KDcw7XcFuaAgACSCTA=
Date: Mon, 13 Apr 2026 05:23:46 +0000
Message-ID: <TYPPR06MB8206179AAAAE93B093AF6410FC242@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-7-jamin_lin@aspeedtech.com>
 <1ec64a4c-b648-4b79-a3a1-ca938ef4b7ae@linaro.org>
In-Reply-To: <1ec64a4c-b648-4b79-a3a1-ca938ef4b7ae@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB7226:EE_
x-ms-office365-filtering-correlation-id: 651ae701-b76c-446e-7216-08de991cd605
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 0IFkc5lHUdo5PiGxhptMNQiiCnOH6mchytDY8mBOYyxkiSaeuAa79Jri5sDrbhRm/bcjc6kIlFbwSwX8706X1f3OTSDVYyea9P31ayrpzE8rAppdcqhO47gvHURd39qZ2XtjU6K5x4Qxp2eV8M2tv8oYbElFi9vI6qpNGk65XJGFx7INjqqbr1J0aC4qhwWVT/tOvU1Yi/x9T379XvwzFXO4zUBDk6/4nzUvh3vF/mUEHzks/GXE+0nFR5dYW/Rp5w1JaKwj/Hu9uo7pJXORsjnbHzgdJWAnhmToR4VSWomG6ZWM1/P5ML0w2N/sjYm89hQKSdx6qz6Flh/bKcJVnJGRFchxiJGUqQ2u673qmeKB1ourlWTDL3chI7h3n69C+XJBL4QYU/BVT8obgWp8bDV1OZP7c/9S5fOV68PMzOvNKl9HF122htL3jQvGzLqo4gv0Fp3ibaW1VQmD2WS8GEUsRxiU34ace4CQgyNtDu4Hcg68vcLfWPZFyVsIJVV1jNOeesEVkSgPjH4Ext08U30AsojxSjZ9aoZST7e6d71LTp/qzKZj2LfMz5aUU4vj5XeprD6p00KWNFhWBRZNxLzil91FD/6c9kNvmEdD11YlLD2fMY8gcKsM7WyWMHPcnElK5i2AEUqlhMux6vkKDJgDesTELVh1h5Pw1tdMG7W/clZ5IBD6yJfWx5vNyOoBR6ZerluR28WYYUV60OmN8jOdLtmw2XX88PPktFttwU3h62YiJRWOhnKD+KYIxpMSW1bwG16Hd/hu9lJAX6udLOHCmRsiEC1pCHFwM1W8pLs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0tPUldOUlpuVnRkTVpHejZaM01tUHU3ajc5LzREVjc4djFrNlBPTUhLWXE3?=
 =?utf-8?B?M3dvWHlVdmV5WjV1VEVVem0ybjFITDgzMHVvUzdkdnZPS0k0QnhjVlFWaWV5?=
 =?utf-8?B?cGg2OEd4QzRNdjJDUDV2am1VUWpvWDdBVFcvV1hiWHdlbnFkdHRxM1Q0Ym5T?=
 =?utf-8?B?Z3ZVdzNnMHcxN09yUmZ6UTgySXh3eERWbGgySytMbE52SmxUcDdOajVrSy9k?=
 =?utf-8?B?T0RtSzQ4NDlGU2RyTGJONXF2RWpzMDNPeGxma0g0YkdSRm5FZWZXOXlYWkVU?=
 =?utf-8?B?VHRqRDdwMEJkZDkzYXBMbmpXWFMzVmZOdHphY1g4RDBnWnJGWHFscDEwQTBM?=
 =?utf-8?B?eWVJMUJvKzFaNmhCU2liMlZYenVKTzZVWUZFanhmQWpDcHk5VnlWc3hkTnlS?=
 =?utf-8?B?Q092b2hndWJFNDNFYmk1YjdMaUR6dUtUdmRoOW9wdzNnWGFmbm1mVEtWTWN5?=
 =?utf-8?B?L0NnY0xrdTZrdS9UM3hFd0phaDhzVWl6eXJNREl3Z0VwZnVxeXdqcEpBUy9N?=
 =?utf-8?B?OG54eGJ2M2tOMFU3ZEw1TWs1ZHNOdmFDNTdhQm1ZRmFhNXpjLy8vVDBGN1Az?=
 =?utf-8?B?emNLa09QVElPZldEWUthaHNPY1J2SFV1Sk9HcHlXc2V2NUkwejIzTU4yMXNI?=
 =?utf-8?B?NEh5aVl6ZFpFbHljZWZMcE1HM3lybUo5VDk5VHY1TzcxajFsSGd0TUxwTWtx?=
 =?utf-8?B?WndBVGJvOUVBSXd2V01LbjlqT0ZveWpUaWZKdGdoSWhReWJiOWx6ZXdzZkhY?=
 =?utf-8?B?TkkrNUo4U3F3UWptKzFYTURZbUJRSUFQZnp6VnVhanVHY3BsSzJhNHpJT0E4?=
 =?utf-8?B?dFNabFhtejNxNFF5THBhdUdaZlZ0U2RjVGV3NldyRmptVFRPMDlBNmdoUXNs?=
 =?utf-8?B?ek54SFVET0JGUmJLM2ZsY1grc2N2MnZ1UnM5RjhaRDZ5dVFpWERrTU54MnAx?=
 =?utf-8?B?MEFMYk1RaGRFdGVSUjdOclE2bFFCVjQ2Tkd6MVJVdHFsRDBiWUVvUENTYW5m?=
 =?utf-8?B?NWhxN1NDdmRVeWFlT2FtOWoyNmJ2c2NNeS9jWWZHWjBoSk9RMlA0SklQdWZ4?=
 =?utf-8?B?NDJKTjFSa2t1WFNWNWZKUTl2RStSLzZIUjFzTmJqMmo2TTdRZ1lXakpFd29I?=
 =?utf-8?B?NkZnSE43WTZsLzJGcXAyNTlNd2ZvQ1N4VkxZRFljRUJBcXAvSnBsUUFsTEQw?=
 =?utf-8?B?TkI3WVBJdk5LeFZUNTV2Y1laL3VmWlpOdGtVQVpzMmdMWVl0MnBDN2xGK1cz?=
 =?utf-8?B?d3o5MlFZVmNqbWVCOHpNTGlHZTVIK1pBQkh1T2RncXRaNjZVUk9URXViU3FU?=
 =?utf-8?B?T25FU3A5R0RJWjhzaStoZ0FIdFFXWGsreis5Z2ZxeTBqVzduOWRoS1hYbXRv?=
 =?utf-8?B?eER2M2czUUc2dmU5enZlU1JiR21raS9mYUVjZ3crREdXVkQ0cjNkQTYzUzhC?=
 =?utf-8?B?U291azU3V2l4TVBGdklVU2Z6cm80UXlTRlQ1YWltVFpPbzh6NFpmblBsc1N0?=
 =?utf-8?B?Q1gveGs5NW5tWGZJSnBlZC9DRHFDT0c5TGV2VWhsOHN4aVFhU2thWmZrVWY4?=
 =?utf-8?B?RnkwMGo3cjVFUVRuY1pFUDNhWlduRk1pV2xHalVFOG94Y2c3VDdraEhiVTBx?=
 =?utf-8?B?aTdzMGFtVTNXcUxtRUJsK1hueXYvVnlyd1R0U1ZtOTZBc0xPOEZWVnpRWDg3?=
 =?utf-8?B?NEkwUzM2enIyRzJjODNCRjZ5R0w3NkQ2cUNpSWplVUJRdXVLVzU2N2ZJRkhF?=
 =?utf-8?B?SU5jSStYbndXeHBvRUpOZW4wVU1SMXZlc0g4Uk1ad21YbnRwMlIzSjVKVEJX?=
 =?utf-8?B?U3VZNmdrNWNCaTF1QWJDSmx4UWN2RThMdXUrQUJOTk1tUm01VGFESHFiVDBB?=
 =?utf-8?B?eThHSEgzUnhsamFQbUlLUHBtSUd2UDNJRU9PK2xKZDVBeExieFNtWlc0TWVt?=
 =?utf-8?B?VFJsL3pKRVR3b0pJUHJScnNKdVh4L2NXQVVlWW94UGNaNXVORzZJSHo5eWdY?=
 =?utf-8?B?aWRsdVN6Q3RFQUhDWi92TXBHbzRIbHdSZXBuSWVkUVk4ZE5RVWF2d2VyT1ly?=
 =?utf-8?B?VU1tSlVGaTVsRFZYM3ZqOTBFU05GL2YwUjlkcEZGaC95TTVCTXZza1F0eVlt?=
 =?utf-8?B?T213OVBrazZmTzRaWjgyZnBZdHc0ZlJyeWErZ2RlYkxJUmlJU1lKSzlIdDN3?=
 =?utf-8?B?T1M0UFZiUFVjT2ROOThMbGVmNC9ZcHJhclZ4eVdFSEFLQUVkbkUwcHBXd2Fu?=
 =?utf-8?B?UzZMUWlNck9WOHIwTU1Ub0dnSW53WU0rVjlpRWZDS04zQXVlbjhNNE1XMFVS?=
 =?utf-8?B?YVNjRmVlSXY1dEl0TmdsSFdydkdkeFZmWDRPenAvSElWT3NIcGpvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ta26TJZQ7yKBMM+c1Cw+SwyMILEcZXrYkSmYnHPsn71SzetGIT/T58cuGrEjp/mMZQ/zl58SZPn/OQtUqzWJ0lQoeGVy1w1+viuUgusRrnj3k2Cckr59nhsKxlDIJK4Q7rmZP+Mn1AR+9qMFSCKHcKCHfqiZDb5RgdJIFdlacUq2FnpsUH5WlYLwN2GJrj+5yKm3aH/3o2CZBV4SQbmP8HsDycjw5Gu9nQpN9nwk/jG7Rxn4lItSV/Ta2iDyD7Zy16+xWGDre8jZxyz8RdCUQ6EqnhmOq4adSRjXjNqXVOXpE4/rDO0I6pTMz7pEmv1rqXFzJasUKVegHXOc59BjWg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651ae701-b76c-446e-7216-08de991cd605
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 05:23:46.1295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71w6Z6zG03Xr/qUOOMpB+5ebPO0zV1mv1Zrby4kYbgaR8b8sMrsrsyl9hfp1sGj24PXONcqOw2oVU27647ewGRTCNzS5yxB6ZRZ8vSd6igQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7226
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgUGhpbGlwcGUNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA2LzEzXSBody91c2IvaGNk
LWVoY2k6IFJlamVjdCBDVFJMRFNTRUdNRU5UDQo+IHdyaXRlcyB3aXRob3V0IDY0LWJpdCBjYXBh
YmlsaXR5DQo+IA0KPiBPbiAxMS8zLzI2IDA4OjI2LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gVGhl
IEVIQ0kgQ1RSTERTU0VHTUVOVCByZWdpc3RlciBwcm92aWRlcyB0aGUgdXBwZXIgMzIgYml0cyBb
NjM6MzJdDQo+ID4gdXNlZCB0byBmb3JtIDY0LWJpdCBhZGRyZXNzZXMgZm9yIEVIQ0kgY29udHJv
bCBkYXRhIHN0cnVjdHVyZXMuIFBlcg0KPiA+IEVIQ0kgMS4wIHNwZWMgc2VjdGlvbiAyLjMuNSwg
d2hlbiB0aGUgSENDUEFSQU1TIDY0LWJpdCBBZGRyZXNzaW5nDQo+ID4gQ2FwYWJpbGl0eSBiaXQg
aXMgemVybywgQ1RSTERTU0VHTUVOVCBpcyBub3QgdXNlZDogc29mdHdhcmUgY2Fubm90DQo+ID4g
d3JpdGUgaXQgYW5kIHJlYWRzIG11c3QgcmV0dXJuIHplcm8uDQo+ID4NCj4gPiBBZGQgYSBjYXBh
YmlsaXR5IGNoZWNrIGluIHRoZSBvcGVyYXRpb25hbCByZWdpc3RlciB3cml0ZSBoYW5kbGVyIGFu
ZA0KPiA+IHJlamVjdCBndWVzdCB3cml0ZXMgdG8gQ1RSTERTU0VHTUVOVCB3aGVuIDY0LWJpdCBh
ZGRyZXNzaW5nIGlzIG5vdA0KPiA+IGVuYWJsZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
YW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L3Vz
Yi9oY2QtZWhjaS5jIHwgOSArKysrKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody91c2IvaGNk
LWVoY2kuYyBiL2h3L3VzYi9oY2QtZWhjaS5jIGluZGV4DQo+ID4gOWU4MjMyODExNi4uZDdhMDkx
N2NhZiAxMDA2NDQNCj4gPiAtLS0gYS9ody91c2IvaGNkLWVoY2kuYw0KPiA+ICsrKyBiL2h3L3Vz
Yi9oY2QtZWhjaS5jDQo+ID4gQEAgLTExMDYsNyArMTEwNiwxNCBAQCBzdGF0aWMgdm9pZCBlaGNp
X29wcmVnX3dyaXRlKHZvaWQgKnB0ciwgaHdhZGRyDQo+IGFkZHIsDQo+ID4gICAgICAgICAgICAg
ICAgICIgICAgICBpcyBlbmFibGVkIGFuZCBIQyBpcyBlbmFibGVkXG4iKTsNCj4gPiAgICAgICAg
ICAgfQ0KPiA+ICAgICAgICAgICBicmVhazsNCj4gPiAtDQo+ID4gKyAgICBjYXNlIENUUkxEU1NF
R01FTlQ6DQo+ID4gKyAgICAgICAgaWYgKCFzLT5jYXBzXzY0Yml0X2FkZHIpIHsNCj4gPiArICAg
ICAgICAgICAgZnByaW50ZihzdGRlcnIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgImVoY2k6
IHdyaXRlIHRvIENUUkxEU1NFR01FTlQgd2hpbGUgIg0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICI2NC1iaXQgYWRkcmVzc2luZyBjYXBhYmlsaXR5IGlzIGRpc2FibGVkXG4iKTsNCj4gDQo+IHFl
bXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAuLi4pLg0KDQpUaGFua3MgZm9yIHRoZSByZXZp
ZXcgYW5kIHN1Z2dlc3Rpb24NCldpbGwgZml4IGl0Lg0KSmFtaW4NCj4gDQo+ID4gKyAgICAgICAg
ICAgIHJldHVybjsNCj4gPiArICAgICAgICB9DQo+ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gICAg
ICAgY2FzZSBBU1lOQ0xJU1RBRERSOg0KPiA+ICAgICAgICAgICBpZiAoZWhjaV9hc3luY19lbmFi
bGVkKHMpKSB7DQo+ID4gICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwNCg0K

