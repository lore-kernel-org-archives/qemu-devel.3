Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE2DC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvpfN-0007ek-A0; Mon, 17 Aug 2026 01:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvpfL-0007eL-Gl
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 01:13:43 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvpfI-0007vg-VO
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 01:13:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faXKk0O1RSv81/Drw5W4ZeOEN4uKnFfZ/7oMVTN/gGhHGU7Ve25LjerqP1kGlAj/QcCC+BXDLusGRXv/gUcs4T64Uu0Z4mMzGG834OCBAiNxrU5/p9y+2uVZ4E74DmMXbTwE2P/1NjnGwVRrm7Ty72oPD07Lehl6kHo4SBP0SgjWJSPloIFGceDjahLBeUoRBW8E5SVP/Eq9aVSji18KuQ74+UZ+zMGRkV1JJEqRV13Wvsm+71dKkkn/k/FX5KwON7/8WJt0D4SiLegnOkWsqCF7KFojh++nYjkOnCmrhs4G1sLnT7rE1phZp0xuSWV7dbCQWiquOnGhXC+GNnEtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwhnvQ2LB3oDmOZQ7TQJQnrURLLtzcTNqQc2jaASZ5s=;
 b=ceKpPLIRTjgQPEfsZtHXzuKigUefY/1E3H01wCEsRPd7+0GBiAetwlZ8YZWmJNOXRUEmYVatRMiz591HjYuBJeT7kIMz7X0OnDnKSWt/stCq84ouh4ASxMEcRFFpf7P95nANtpFVWP1dzYtfvLQB8qJgRaImW6B+cBSqanIu4nfUQZBJePq5cONovsgBRvWfFl8zalb3OGZ4mFUMdPjWntgiQD5HXG30WNCKxoAQZVUysodCCwRWIhwuwyN+4rwshBE9zhY1xaOMZ4VKAFgO9eb+aW7+4plhrmpJQ9dJF/jS9Epr5iZCH0CtnFwFfw62aAMmTW0bJeA640BiSkl5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwhnvQ2LB3oDmOZQ7TQJQnrURLLtzcTNqQc2jaASZ5s=;
 b=KLCXYrjIlYKC7S119EaRIDx46wP+NkBl6GedAJosyY258MAV6sXoXQkfgHa/UipPYUzID31ZT5OMsV7MdVwdxzCqUw1zrwvslE72nom7rfUCS90TZvbdCk/0jLDHvrP5KkvpUuqFCURv5XJDk1IV3wUKIyHL5g6u/ku8pbUC0BcYyPihY4zaGGoGmuGXChr8VuYDcFeq6lVn2KGmL1lJX4Ku6nnlmXbRpoWRWM6/tugMM6iBggUskfktE6oULeWpSmdVQ2L/LNCVxCIlLGx0XjIWDl/OSr8odZ1C1CLAMo9bJ2a+u6QJPP0d7cV7ocCiq3UOJCjhNnFX+Y3oJVgIBA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF8519E92E6.apcprd06.prod.outlook.com (2603:1096:108:1::7df)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:13:33 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:13:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 "clg@redhat.com" <clg@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "philmd@mailo.com" <philmd@mailo.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 2/2] hw/usb/hcd-ehci: Check for DMA errors in
 get_dwords()/put_dwords()
Thread-Topic: [PATCH v2 2/2] hw/usb/hcd-ehci: Check for DMA errors in
 get_dwords()/put_dwords()
Thread-Index: AQHdLfE7QS49U63b40eQy3mrFdSRpbahouOAgAAPAVA=
Date: Mon, 17 Aug 2026 05:13:33 +0000
Message-ID: <TYZPR06MB4980319952614591129AD7F0FCA72@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260817023637.3082135-1-jamin_lin@aspeedtech.com>
 <20260817023637.3082135-3-jamin_lin@aspeedtech.com>
 <5980ddfc-63cb-43ce-a36c-537667255d91@oss.qualcomm.com>
In-Reply-To: <5980ddfc-63cb-43ce-a36c-537667255d91@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE2PPF8519E92E6:EE_
x-ms-office365-filtering-correlation-id: b93165bc-d3e0-4188-0973-08defc1e48c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: M+Gcjj0Fn9uqmza8kCm+MfPjUUQz8xuBs4MUVxreRlKAry4wrBhk+dXAcAtHAkq0efyZKXVcBAiwesjZMUL+CYLZsUIHP74OnpTBv1axdKFMRrdzR3qjTmIXZ9YKsyJV5jtdzhuPRIdg7sfsCsGE+XXlJtlD3DMCHOFl66t/zV/1XZsaJq0nTuD6iSwkjnIwx36FWGNtkjwKud3b+5fhfPI/Mv43fcgX0uyHY3Gu2pT3e/FDlJr98FjgjM8un/8MxwIifl3vWwilBqScnvdmt5uMyxkuyPfsRdc+/dOPG8mk0coBuKyKHaljAb8R9mbiyF3AAcJRFBLGtTVnxKpRZn6xKu09rrLsh5sgtuPoMx5zpC5aSZtSvbGJEQHvSZ6Aqb2Ao8D7b259RHy9GWCPIChZmCmsFyvlWrQyGTrZrBXVnxq2/HVaiEKI6Rz9hbjb0/apfR5fK9V+DvrHJH6v3BhrZMmli6ojbyRVUpS+8BQ7xW5OeX016uWwNJpCf0e7V1f6EwZSbXXAW9BNMOUMXg7qiXYfcoRDw2HTQLy2rrRp6M+LZABu4Yt/ICeq09zL1s15f0GpaCH45ZifH/Og9K9GYUxTi9i3hMu7G7z4w25Bbm+vNjf0UgvPKuAEaiGetdlamqojRWnpQdXIb7qpT+3vr7A/tI7aIwkV3MLpiMtTyAXxt5k22eURtUIzZaGFNgQdWokV2qjX8u6Qw0um0EkK4+eXPmkzk58wajrZx04=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1ZNTWs4WDByMkU1eXIxZTFIb2NzaU1CaDNiQU1uSmtrWWNGelFiSUF5eXcz?=
 =?utf-8?B?dGhkMStYOUlTTGNTRW9CMjVJWTBxOGkyWGR5eEp0V2NvdEN1MlQ0Tll0dGtZ?=
 =?utf-8?B?VEVmRG84Wmw4aUpGbzJQS3dOQUdBRUdyN0UxTjZqdFhHeThyR3hyVWF2bjBm?=
 =?utf-8?B?UEVvQzZ5d1Exc1FOR1J3akFpQUtRMlBJVHNNMWNBbE9UYkFNbnhIRFhFVHN4?=
 =?utf-8?B?M2ErdVIzUmoxYlRjWklBSmNGd042UTlqenNyckdqaHZtOXRIQk1mbHpXdUoy?=
 =?utf-8?B?a1FGL2pYdVVGUk5HL1pqSU5PWTdHLytrYVQ1bVhRSVUzQUFYUzdwbkpBbXND?=
 =?utf-8?B?NEZQck1lNldFdzRWUGMxVVNMS09PUUs0enBHSFhBa3VKb2FNTFZieTJJZ1hT?=
 =?utf-8?B?b0N0U1BXa3ZuSzdzcU1meWhVSW5CTTNRTVJ0OWNwOVlTblpJLzhQUEt5alc0?=
 =?utf-8?B?dFlhTW9Zd21YMmdJQW5Yak1GNlA0S3BXd21Sc3BQb0laNXdvVlVaenVFS2RE?=
 =?utf-8?B?anJjdUI3NitNL05aVG5Pa2JiRDg3WGtWL0c1dVFicDVsd1puR2NnYWxPUHVS?=
 =?utf-8?B?QXREbjFjUlNWMkkrUzJYQjdZazdOVlIxM05zN0VsWjc3ZGZjVWo2T0ZPbHFq?=
 =?utf-8?B?blpBb2NHdEliR00ra0M2KzFWa2NOall0Tnp0N0hGSjlQY2l2V2Rpc2E1UEcv?=
 =?utf-8?B?cGFJaDBmWjA5bjM3Y2c5clpkaW1MQmlBNnZnNGNPT3o2cmRWaFRjTFRBb212?=
 =?utf-8?B?T2dWLzlzQjNuWDlMY2txdms3UTlQKzZPeWJITXJoOEh0bmczUi9jYlVZbWJS?=
 =?utf-8?B?ZG5JRnREbFZSaDRXWkNtL3g3RUFwTjhxekpwVGhPR1JsYmpyQ0hVQXR4SEp0?=
 =?utf-8?B?Q3cyODB0UytGakZvSGg1Mmt3MHhDNXZ3VXhrT3MvUVhxamxUa1FBZEhtQlpO?=
 =?utf-8?B?MDZUZWt4VnZ4U1VTRWFwUjc5eEZmRlJMMnVaM1E1VkplaFlJRVlKR1lQVUlh?=
 =?utf-8?B?dko3bVVhMHBoSS9qbFNVRVNkd3RmaE81RkJKR2hWUElpdG5FT3B1TXhoVEUv?=
 =?utf-8?B?dDJTMlYyTDJwSnVqMC9WUEZ4eXVTTFZyNE5STWhFU1I1UDNRS3RLU0MrMUFo?=
 =?utf-8?B?T21VSnNqemo4L2twQThDVjIyT3VhQTNiUXRFNmpSTTdqc1hlTlBpQm5OYWg5?=
 =?utf-8?B?bGhZNEhURXN6ME5MQUN0UzYwbTFueGNxUFJ1Umxld0tXZWM4djJwRXBndWVa?=
 =?utf-8?B?VjZhSWNDaCt6U1pQeEkwY04vMGJ5WEw1SzFUc1JWWEs2WkNKZERWemdlay9j?=
 =?utf-8?B?Vk5iNllIQTZUMjEvUStWMXg3UXpXVk9DdkxEYk1HOTBnTDlXTHk5bllpWjla?=
 =?utf-8?B?R2pQWjFCd3Fnb2djaHVIWjJTaitONnc4Qzk5bVpRK1pXTUluWXV5alNnWWUv?=
 =?utf-8?B?NG0xeFVRYmxjRG9jdzArY00vaWJyTG9EYkJmZHkzTnZFUldNUTBzQ3hNQkg5?=
 =?utf-8?B?aXVXSlVGbm1JdDF0VlFkK0F5azA0d3BYbUtZdFBpRkRmZXZUanFuR1duRC9y?=
 =?utf-8?B?cEdTUmdTMTcxL0lWcEdtSmRQdGlRL01BdENndGt4NUxHRFp2NGlkbjVXbVRO?=
 =?utf-8?B?dlV5WVRmeTU0NGo1TmovbE1MdUptaEcvblRmbXF6eEkvWnNlNWpmcnVwRDFK?=
 =?utf-8?B?QXY0TnJPZW5TMGRtL2NGZ0FmWHlLZ1VxcDQ1U1BNaFBiVEpER1BWRVlPRis4?=
 =?utf-8?B?NERpQXhhdjdTSUdZRVhzVHdNSHJoS29sNzFiOEZVVVJmaUNpOS8vNmM4Q2lC?=
 =?utf-8?B?MVRFYlY0R0FCTXZCRFg4Nm4xTDRDNCt6M3BRZHlURjI0K3BKVUtxMlJRei9n?=
 =?utf-8?B?SEY5WGJ0UlY3cW9nNTcrS2F3TDg3dzhaZUpUZU9Kb1QwVEpYaldLbjJ2aHFi?=
 =?utf-8?B?WnRzc3Zsc2JPQ3ZtNnYxSEltNG9MVnpRSW43N01aMlg5aktxY2lCWXI4Qll2?=
 =?utf-8?B?ZTNGcHQxWmI5c1hMbm5tZUlRcThkd1FiY3Z0bzRtVFY0QjN6aXVQZ0hVdGFX?=
 =?utf-8?B?T0RSbXowQ0R2UFhoTmlrRm5nZEo5V2x1SFNtdm4wOEFCejNpOFJiRXUyNzNs?=
 =?utf-8?B?bjFmNmlldU1EdVdLOUJpYTFuM2VjT3hXZ1NGQ0FaZExFc1l1bHgxTUNUZEJ2?=
 =?utf-8?B?cU1tTmZCRzF2UEt3TjJ6NFVhTlJ2U0Ywc21ROHJ2ZVk0ZGZUaUJpQVhRL3lN?=
 =?utf-8?B?RVdpVTFiVzU3OUN3WTRtd1BzVDhvVUxOVzFjazBJTTZMSmM3NndOUmhVcjdz?=
 =?utf-8?B?Y0xlRXc3bUV6K1czUVkyMTZUNmUrYUJESkhsWEh1d1p3UlBxdGJqZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93165bc-d3e0-4188-0973-08defc1e48c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 05:13:33.2734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nT98h44bCAMkU5R9XoH9lLDVlvKTONNcMzgyXJmIsNh+imlU3qnnvAsH1jpZIPgmNz78RJd7eKvFH0McQuNelVx4HXWlB0pGa4cDp6H/65A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF8519E92E6
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

SGkgUGhpbGlwcGUNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gaHcvdXNiL2hjZC1l
aGNpOiBDaGVjayBmb3IgRE1BIGVycm9ycyBpbg0KPiBnZXRfZHdvcmRzKCkvcHV0X2R3b3Jkcygp
DQo+IA0KPiBPbiAxNy84LzI2IDA0OjM2LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gZ2V0X2R3b3Jk
cygpIGFuZCBwdXRfZHdvcmRzKCkgcmV0dXJuIC0xIHdoZW4gZWhjaS0+YXMgaXMgTlVMTCwgYnV0
DQo+ID4gdGhhdCBjYW4gbm8gbG9uZ2VyIGhhcHBlbi4gVGhlIHN5c2J1cyB2YXJpYW50cyBzZXQg
aXQgaW4gaW5zdGFuY2VfaW5pdA0KPiA+IChlaGNpX3N5c2J1c19pbml0KCkpLCB0aGUgUENJIHZh
cmlhbnQgc2V0cyBpdCBpbiByZWFsaXplDQo+ID4gKHVzYl9laGNpX3BjaV9yZWFsaXplKCkpLCBh
bmQgdXNiX2VoY2lfcGNpX3dyaXRlX2NvbmZpZygpIG9ubHkNCj4gPiBzd2l0Y2hlcyBiZXR3ZWVu
IHRoZSBidXMgbWFzdGVyIGFkZHJlc3Mgc3BhY2UgYW5kDQo+IGFkZHJlc3Nfc3BhY2VfbWVtb3J5
Lg0KPiA+DQo+ID4gTWVhbndoaWxlIHRoZSByZXN1bHRzIG9mIGRtYV9tZW1vcnlfcmVhZCgpIGFu
ZCBkbWFfbWVtb3J5X3dyaXRlKCkNCj4gYXJlDQo+ID4gaWdub3JlZCwgc28gYSBmYWlsZWQgZ3Vl
c3QgbWVtb3J5IGFjY2VzcyBpcyBzaWxlbnRseSB0cmVhdGVkIGFzIHN1Y2Nlc3MuDQo+ID4NCj4g
PiBEcm9wIHRoZSBkZWFkIE5VTEwgdGVzdCBhbmQgY2hlY2sgdGhlIE1lbVR4UmVzdWx0IG9mIGVh
Y2ggYWNjZXNzDQo+ID4gaW5zdGVhZCwgc28gdGhhdCB0aGUgZXhpc3RpbmcgLTEgZXJyb3IgcGF0
aCByZXBvcnRzIHJlYWwgRE1BIGVycm9yczoNCj4gPiByYWlzZSBVU0JTVFNfSFNFLCBjbGVhciBV
U0JDTURfUlVOU1RPUCBhbmQgc3RvcCBwcm9jZXNzaW5nIHRoZQ0KPiA+IGRlc2NyaXB0b3IsIGFz
IHRoZSBOVUxMIHBhdGggdXNlZCB0byBkby4gQWxsIDExIGdldF9kd29yZHMoKSBjYWxsZXJzDQo+
ID4gYWxyZWFkeSBjaGVjayB0aGUgcmV0dXJuIHZhbHVlLg0KPiA+DQo+ID4gcHV0X2R3b3Jkcygp
IG5vdyByZXR1cm5zIHZvaWQ6IG5vbmUgb2YgaXRzIGZvdXIgY2FsbGVycw0KPiA+IChlaGNpX2Zs
dXNoX3FoKCksDQo+ID4gZWhjaV9zdGF0ZV9mZXRjaGl0ZCgpIGFuZCB0d2ljZSBpbiBlaGNpX3N0
YXRlX3dyaXRlYmFjaygpKSBsb29rcyBhdA0KPiA+IHRoZSBzdGF0dXMuDQo+ID4NCj4gDQo+IFN1
Z2dlc3RlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGh3L3VzYi9oY2QtZWhjaS5jIHwgMzggKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCAyMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody91c2IvaGNkLWVo
Y2kuYyBiL2h3L3VzYi9oY2QtZWhjaS5jIGluZGV4DQo+ID4gZDQzOTUxOTc1YS4uZGFhYjU3ODNi
YyAxMDA2NDQNCj4gPiAtLS0gYS9ody91c2IvaGNkLWVoY2kuYw0KPiA+ICsrKyBiL2h3L3VzYi9o
Y2QtZWhjaS5jDQo+ID4gQEAgLTQyMSwxNiArNDIxLDE0IEBAIHN0YXRpYyBpbmxpbmUgaW50IGdl
dF9kd29yZHMoRUhDSVN0YXRlICplaGNpLA0KPiB1aW50NjRfdCBhZGRyLA0KPiA+ICAgew0KPiA+
ICAgICAgIGludCBpOw0KPiA+DQo+ID4gLSAgICBpZiAoIWVoY2ktPmFzKSB7DQo+ID4gLSAgICAg
ICAgZWhjaV9yYWlzZV9pcnEoZWhjaSwgVVNCU1RTX0hTRSk7DQo+ID4gLSAgICAgICAgZWhjaS0+
dXNiY21kICY9IH5VU0JDTURfUlVOU1RPUDsNCj4gPiAtICAgICAgICB0cmFjZV91c2JfZWhjaV9k
bWFfZXJyb3IoKTsNCj4gPiAtICAgICAgICByZXR1cm4gLTE7DQo+ID4gLSAgICB9DQo+ID4gLQ0K
PiA+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBudW07IGkrKywgYnVmKyssIGFkZHIgKz0gc2l6ZW9m
KCpidWYpKSB7DQo+ID4gLSAgICAgICAgZG1hX21lbW9yeV9yZWFkKGVoY2ktPmFzLCBhZGRyLCBi
dWYsIHNpemVvZigqYnVmKSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgTUVNVFhBVFRS
U19VTlNQRUNJRklFRCk7DQo+ID4gKyAgICAgICAgaWYgKGRtYV9tZW1vcnlfcmVhZChlaGNpLT5h
cywgYWRkciwgYnVmLCBzaXplb2YoKmJ1ZiksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVEKSAhPQ0KPiBNRU1UWF9PSykgew0KPiA+ICsgICAg
ICAgICAgICBlaGNpX3JhaXNlX2lycShlaGNpLCBVU0JTVFNfSFNFKTsNCj4gPiArICAgICAgICAg
ICAgZWhjaS0+dXNiY21kICY9IH5VU0JDTURfUlVOU1RPUDsNCj4gPiArICAgICAgICAgICAgdHJh
Y2VfdXNiX2VoY2lfZG1hX2Vycm9yKCk7DQo+ID4gKyAgICAgICAgICAgIHJldHVybiAtMTsNCj4g
PiArICAgICAgICB9DQo+ID4gICAgICAgICAgICpidWYgPSBsZTMyX3RvX2NwdSgqYnVmKTsNCj4g
PiAgICAgICB9DQo+IA0KPiBNYXliZSByZW9yZGVyIGJlZm9yZSBwcmV2aW91cyBwYXRjaD8NCj4g
DQpXaWxsIHJlc2VuZCB2My4NCg0KPiBOb3RlLCBmb3IgRUhDSSBnZXRfZHdvcmRzKCkgaXMgb25s
eSB1c2VkIGFzIHJldHVybmluZyBhIGJvb2xlYW4sIHdoaWNoIHdvdWxkDQo+IG1hdGNoIHdpdGgg
eW91ciBjb252ZXJzaW9uIG9mIHB1dF9kd29yZHMgdG8gdm9pZC4gV2hpbGUgdGhlIGNoYW5nZSBp
bnZvbHZlcw0KPiBzb21lIGNvZGUgY2h1cm4sIHRoZSByZXN1bHQgd291bGQgYmUgY2xlYXJlciBJ
TUhPLiBBbnl3YXkgY2FuIGJlIGRvbmUgbGF0ZXIuDQo+IA0KV2lsbCBhZGQgbmV3IHBhdGNoIGlu
IHYzIGFuZCBjaGFuZ2UgZ2V0X2R3b3JkcyByZXR1cm4gdHlwZSB0byBhIGJvb2xlYW4uDQpUaGFu
a3MsDQpKYW1pbg0KDQo+IFJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQG9zcy5xdWFsY29tbS5jb20+DQoNCg==

