Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2A0F5513F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 14:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzEfN-0004q3-5D; Sun, 08 Mar 2026 09:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bestwow2014@outlook.com>)
 id 1vz8OF-0005xW-0H
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:17:27 -0400
Received: from mail-australiaeastazolkn19011063.outbound.protection.outlook.com
 ([52.103.72.63] helo=SY2PR01CU004.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bestwow2014@outlook.com>)
 id 1vz8OD-0000b1-5u
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:17:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyZdZ0XdS66LC15+YgcGAOddPM7Ro6G84+GvuXBZQC0hTsPv/laUpmV5rGYiXrYgb0JVPTY91/e0y6uNYFkOfT63PfNVPr+hVWjBYYJy5e3VYB4oGztG7hYAaNXpyRFHM6MW00fZUTlIYrBs575lELuRD7jSqRKBjDTJhk3Lv2dfJ6fYE6AZR4BDh35rm14I4Q9T4w4dKt/GayrSSaTSPWELVPUa7842HqkVNm8x0m3jwne0lSND4vBtlSjI64L4YaeZ+RjyClrwM8M37gh/t0BfUD2FeRPOg2R1CLlJnsE+imWPjulNSLQEUBClhlhqKkzOcm2IdnE2iADbCN3F9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATEka79QgKeZJfiYGA6OXlQ8i653F2AdtV8NCUH5no8=;
 b=Z7Zdu9Ph4FC5mqOd2ksPgboFHPCd38dam6GnMaGf3ajZ4/0kc0YMu8lgkM03E4u1Fx1tzfVWYH8gsN2C8+x14GHDQOpY7Rf2H+qXdbFiUzfsqLZPEjq/BT/Zx00kl+WJmU0SPIYqxJrYfM9AszJ9W46zbMH6sZJOc382dRALUKej0Rk4TBv38rR/JCuj3IMsrbV+OTkgIam1okS4gBVifGewXtJ0MRn/aqegB6PsfGYaO627plmmjNzIp3ntjTkHbv+17F7Zic/Ktpk9kXJNrGo8PuNoYSUM6JWHmkB3/wMtRAJE6YWIY/kNU0UJ6D9ErHWrpXtUQcxKhRxAfry0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATEka79QgKeZJfiYGA6OXlQ8i653F2AdtV8NCUH5no8=;
 b=P9nqaYjFs6UaYRdhfASbMPk0d4SOAFJT0kylpy9Gv4D+0iNBOzuPmIYcfJh3rWdnKa3r0Zd9nj8usvnSZranOLCDLp3kb7aa/Dtd9EqGux0N5eeYc5i+Ri5JaeyKjdu7SMGUW462utmEiNujGEKW5NjFxsOgSCFhK0s8d4dAFefsJZBMCx2w2q//QPrTbVr9F7ip8QF/DSf7q94P6dCMiwu6ckW80uCZ/IKElhhQ90q/+4SWCS7zmoYAUPtYb8uF9xb2J1WAFlXPYr4QogUU9OG0GlH62sorP7Q5UporOqt+fiE4bI1XE/yRbnBTZubPy5+B+LE+xtaxIbpsvQN+TA==
Received: from SY8P300MB0571.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:299::14)
 by SY7P300MB1337.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 07:12:17 +0000
Received: from SY8P300MB0571.AUSP300.PROD.OUTLOOK.COM
 ([fe80::a79f:f09c:4a49:2b9d]) by SY8P300MB0571.AUSP300.PROD.OUTLOOK.COM
 ([fe80::a79f:f09c:4a49:2b9d%6]) with mapi id 15.20.9700.006; Sun, 8 Mar 2026
 07:12:17 +0000
From: =?utf-8?B?5bi4IOW+kOa1tw==?= <bestwow2014@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: GSoC 2026: Interest in vhost-user memory isolation
Thread-Topic: GSoC 2026: Interest in vhost-user memory isolation
Thread-Index: AQHcrsrlFWz8HOef60esJPWcPMoCmw==
Date: Sun, 8 Mar 2026 07:12:16 +0000
Message-ID: <161E6C95-BA0D-472A-AFE3-56ACBF88A44F@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY8P300MB0571:EE_|SY7P300MB1337:EE_
x-ms-office365-filtering-correlation-id: 9208b27b-8927-4f76-f105-08de7ce207e2
x-microsoft-antispam: BCL:0;
 ARA:14566002|19110799012|8062599012|8060799015|12121999013|15080799012|461199028|41001999006|31061999003|11091999009|55001999003|25031999004|39105399006|20031999003|10035399007|4302099013|3412199025|440099028|102099032|1602099012|40105399003;
x-microsoft-antispam-message-info: =?utf-8?B?U0lXTHI2a0JnRjRyN2dJWmZvRGpNTlc1L0M3ektRcXNQbkVGWE1keTJ5czZh?=
 =?utf-8?B?NlJzVEh2WW5OeDFDOXZEODJSb3hmUmpXYWgyTzZMdkZqWkl4MzlpSE0ra1lx?=
 =?utf-8?B?dDhFUW0rOTVmazMyYUVzdk5pajZhTER4bk9pT1ZZalJ2M2h6alVhQnIwK1VV?=
 =?utf-8?B?YWU5NVJieHBNOU5oR1NLWnZJNGR4NW5FMXZOeUg2MktwRFlxSUxOcTd2SGsw?=
 =?utf-8?B?ZFBkbTZwNVpmUDBSbzdibmdPV3FKbnh4UGNoQ0dsdFZOaW9yYWJ1T1ZGZ2ps?=
 =?utf-8?B?TUJ4WnpkTmlWQWY5d2ZQd04xTVFRRk9nWlc5dWVOT0kzTTVJaHJCemphYm82?=
 =?utf-8?B?MnJBRFhXRlZ0aDFGTTB5QU00Qk5PMzZVa2JtNDZCME9zeHVUSDFCVlhTbFd2?=
 =?utf-8?B?RDdFRzIrNWhRRHhQTUZpY0RlRGVrelVzUm14RTRjamU0YWJjV2U1VWo4Y2lv?=
 =?utf-8?B?K2JTUSs3WDNCTlcrQ2hleUdaMnd3aS80enMzbWFJTExvNFVjLzE5WWRUM0Ir?=
 =?utf-8?B?ZmxyZDV1UmJ6dGl4Q0JnZXZ6NTNEaE9yY0pHZnBVUWdVVXEzU0JwTUFxdEdp?=
 =?utf-8?B?QXo1Tk1WNGtCSDJKdlZwRXVzU0U3RVhoN0t4dE82SWZpKzVVdGszV3plTDhR?=
 =?utf-8?B?V05Ld0k3T2JQdCtNTE45UXNobzEzUDUyb0QvbHFFbklLalczMFArRE45Qk1Y?=
 =?utf-8?B?dXJ0S29iOEdzNWRET3NEaHJrazEya2tZVFB5ckEwNEpMemNEYktFRnBqcDhT?=
 =?utf-8?B?ODRoV3lGY2VDc0ZmUVJ1ZFl6Z2FWWHRGbW9qOXVrV0dyMXhISW40SEdEYnha?=
 =?utf-8?B?VFVlRVQwRm1LNG1va0lNSWdOV0M4R0VtY2I4VS9vSTR2bW1ReVYzang5Y2sx?=
 =?utf-8?B?bTRsbDU2cnlaS0xpU21udmsrMGZvb3h4bUM4dXc2akFKVlNQSzM2R2dGR011?=
 =?utf-8?B?WmRma1h1bXZkK0pFcjM2SUhZaUExWU0rUjQyL1NQNFZjSU5zVWJ3V2ZQWG1S?=
 =?utf-8?B?cnExQmdiSDVad2lzeUdjU0QyL0J6VkNabXN1VVhkbFlVSGMveUxLajRjem5N?=
 =?utf-8?B?TWJPYmV3K2NnbUExS3AzK1ZTUWJVN3RDck5NRVpVYStPQ2VwY05WRkM1Z25l?=
 =?utf-8?B?YUZPaFR5dUhxa25iZVY0MVF5R1M1RmlWUjAvU2R6eUpWZGNWeXFnNGgwUE55?=
 =?utf-8?B?RCtuRGlwQitVQVlXV2tUSGt3VXVHYW5CbFFIL2d3WEVtWmNUbmlobGdFSjhD?=
 =?utf-8?B?OXhXa3hHOXdRcnBWY00waUpBUk1yTzBDK0ROdFcvY0dRN0RNZ0N4U2tpTVAv?=
 =?utf-8?B?NTVyVHJENXhnNm5hTU9Gd0JNS1RUd0xNRy9FZTRTWHM1VHpZcVU4YnZ5NXhH?=
 =?utf-8?B?VmIwd2FXeGtzdm80b3FwVWsyS2VXQjh1NE90Y3hxc1Q2a0R6aUhVQXR2TFVn?=
 =?utf-8?B?NUZwbk5kY0kzRzhka0hKb2xIY3ZxRm5sZVpqYlR6MXVYaGZNRTF0MDdGNDlY?=
 =?utf-8?B?T0QxK1gwWDcxY3o1QzhHdmJWSnloYlJGNzFTa241SXUrRW5YSmpjbEdGbWRz?=
 =?utf-8?Q?iFkTw2P9XHSWG8gGcdEmHcoIo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0FSRmlHNVVRN3h1VHViMHNJcE40bmtWTTNRMGpvd2xHSkIzdFg5ZmtVZ0wr?=
 =?utf-8?B?bzFzTFQ0aTl5aEFEbVdIbmVIMndKYmIwa0hLL2ZkYnRRWGpGWk4xWjJpNzZj?=
 =?utf-8?B?bmZRZlpxNHVrVEFWUUF0d1pBVnBDdkNHaHBObG5lcjg5REJnMnVXVkYyOXBD?=
 =?utf-8?B?RkZhc1l4QmRSdnlON2NQcEYwWmNLZGJ6d05SeVpOM3lUMGhnZUZpaHltRVlF?=
 =?utf-8?B?ZnJGQlVBMVF5RkRMcFkyRzRxWFQ4T3ZycmhzUzFJd21ta3htWmtqK3c4QTFk?=
 =?utf-8?B?UnBKcG0wUVVTNkJQK2FZajd2czQrMjc4ZGJWcXJzbDJpWXphdFI1blhyVWI5?=
 =?utf-8?B?WnhMb3NOR2w1dkFxUTdQQlJ4SUk4cXhkUnFOdWtIaGt1aSs2cjRJV3NTdjVT?=
 =?utf-8?B?WUppQnE1U2hlU2c2L25DS3Y1UzlIb2pJajFWVW9sV0JhWnpLMWV3VFJuMm1R?=
 =?utf-8?B?RDdZRG1hVHRJT3ZJS2ZpbzJqTTFEUCtsZlVTTmljdXQwQTQvejluN2hTaXh4?=
 =?utf-8?B?WTFyaDFGSjl6aXVwc3pibWxKL3l4QmNHT0RzYkZ5TlZDbC9xRGdwYXJoWUVM?=
 =?utf-8?B?a283TUJ4cVhWeUo0UDFwa09TNG1rTW5xVWNEaEphekFibCtod0k5djFZbU1j?=
 =?utf-8?B?YXlveThsTVc2NjBKc1pIMGdOenI4QWFCVzRVdlI3U3BUa2t4WnFVVGJEeUlv?=
 =?utf-8?B?RndyanNtcVlkSjlHSGpKYzhscEpLY2I0Q2V6ZURFVGFKQU1aQjlqU0lHUWNm?=
 =?utf-8?B?MVZGK2owN1NhRU5aUjkrMkZxQ1kxbXF4UURXU0FKdUM3SXp1Sk1sazhLMmhZ?=
 =?utf-8?B?MHg4b1V2bzd4ZTdaTWNtdHV2RGlRelgyMlZPaXJzRWoxeURiV3NRNFhXMTM3?=
 =?utf-8?B?U0IwLzdvQk0ralV2T2ViOXpDNUJNMUZYWHZRc3hJclJJaVpRdy9VNE9HN3E0?=
 =?utf-8?B?WmlXSjc5VS9KVHRQN1FVNVdvWlpoNzZFTG1vaXNDVm0xV3RjTHVWdE9kSWJ3?=
 =?utf-8?B?ZGdvZFJPeXJ4eHdFZ0plRU5iVjRTTzRmT0NXK2R5eEh1N2UrYXljSHBXcS9Z?=
 =?utf-8?B?UHNZSVgzZWVDWVlEKzZHWXRobzBGRW5DSHNvSU95dit4ZnRTMDFjdXAxSzRu?=
 =?utf-8?B?L1FvTmgrdnpKQ2V2TlZpTE1XNU1wcVQ2OXpmM0I1YVVQVkpUWVc5MU1UeVF3?=
 =?utf-8?B?TFFQdUZ3NFJIbTFzR2E3UFArZkFIdzR1dnRXUldkdysvQWdEV0lZbDQ1YXAr?=
 =?utf-8?B?R1Q3VjdnTlpYbkJKcDc1SGcveFI5RWRpQ25wYlF4S1ZFblJYR2c5dWhLeCs0?=
 =?utf-8?B?SzZ0cHh2RzNTa0JaUTl2Z0VOOGRMNEF6OVZJMU5IUzZxU3RQbUFhUWtnVzdr?=
 =?utf-8?B?ZGJYRlR2TzdHN0ViUTlvWkQzZmtOYnhoTWwvTi9lRnFjZElnM0pmb0VzY3BJ?=
 =?utf-8?B?QndjUEZrM0NpbDBNd1RKOExRM2ptSnk1eFRFWkFteGQ0OEFwa1NQWW1WTGs3?=
 =?utf-8?B?ZG1MSjRQNm9sMmZWVGE2TlNFN0VGU2FjUnRHNTZSRDJDTzJoaHNEZE9jSVZN?=
 =?utf-8?B?UWNwaS80VU1DaFlEYThrN2grNEdLT3NMZnEvT0c5YWpxbXFoUWswYlJ5dHU1?=
 =?utf-8?B?d3R5N1hwVUZIbXFPN0NhaGVrOVFJSnJLcWhVODFZNURXa0dPRXJjSGkra0Jk?=
 =?utf-8?B?ZEZVaUVJTUVkMW94cUx0bGJpWGN1Q2tBak11LzgyNWt5SE9vT29OcW4vRFlO?=
 =?utf-8?B?NlRqME5hSGtUVXNJVm80T3VZSmh5dWQ3Zkk4VXpSN0E5MWJMdHFzTTR0anB1?=
 =?utf-8?B?eGZZdGFTWEFoRmZUcis3aWlmUlJ5Mi95VVVCN2dsK1BIRFVXQ0NDazZZb1Z1?=
 =?utf-8?B?bS9tT1k1Vy9EVHNFem9pRGg1azhRM00zaU9SQnBEZEl4MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F51154DAD4E2584CBE4D7636E128CA3E@AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY8P300MB0571.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9208b27b-8927-4f76-f105-08de7ce207e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2026 07:12:16.9579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1337
Received-SPF: pass client-ip=52.103.72.63;
 envelope-from=bestwow2014@outlook.com;
 helo=SY2PR01CU004.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 08 Mar 2026 09:59:31 -0400
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

SGksDQoNCkknZCBsaWtlIHRvIGV4cHJlc3MgbXkgaW50ZXJlc3QgaW4gdGhlIHZob3N0LXVzZXIg
bWVtb3J5IGlzb2xhdGlvbiBwcm9qZWN0IGZvciBHU29DIDIwMjYuDQoNCk15IGJhY2tncm91bmQg
aXMgbW9zdGx5IGluIHN5c3RlbXMgcHJvZ3JhbW1pbmcgYW5kIE9TLWxldmVsIHdvcmsuIExhc3Qg
eWVhciBJIHBvcnRlZCBOZXN0T1MgKGEgY2xvdWQtbmF0aXZlIGNvbnRhaW5lciBPUykgdG8gYSBu
ZXcgYXJjaGl0ZWN0dXJlIGFzIHBhcnQgb2YgT1NQUCBbMV0sIGR1cmluZyB3aGljaCBJIHVzZWQg
UUVNVSBleHRlbnNpdmVseSBmb3IgYm9vdCB0ZXN0aW5nIGFuZCBkZWJ1Z2dpbmcuIEFzIHBhcnQg
b2YgdGhlIHNhbWUgZWZmb3J0LCBJIGJhY2twb3J0ZWQgdGhlIFFFTVUgZndfY2ZnIHBhdGNoIHRv
IHRoZSBvcGVuRXVsZXIga2VybmVsLCBlbmFibGluZyB0aGUgZndfY2ZnIHN5c2ZzIGludGVyZmFj
ZSBzbyB0aGF0IGd1ZXN0IGtlcm5lbHMgY2FuIHJlYWQgY29uZmlndXJhdGlvbiBkYXRhIGZyb20g
UUVNVSBbMl0uIEkndmUgd29ya2VkIHRocm91Z2ggeHY2IGFzIHdlbGwsIHNvIEknbSBjb21mb3J0
YWJsZSB3aXRoIG1lbW9yeSBtYW5hZ2VtZW50IGZ1bmRhbWVudGFscyAocGFnZSB0YWJsZXMsIGFk
ZHJlc3Mgc3BhY2Ugc2VwYXJhdGlvbiwgbW1hcCkuIEkgYWxzbyBoYXZlIGEgY29tcGV0aXRpdmUg
cHJvZ3JhbW1pbmcgYmFja2dyb3VuZCAoSUNQQyByZWdpb25hbCBzaWx2ZXIgbWVkYWxpc3QpLCB3
aGljaCBoYXMgYmVlbiBoZWxwZnVsIGZvciByZWFzb25pbmcgYWJvdXQgc3RhdGUgdHJhY2tpbmcg
YW5kIGNvbmN1cnJlbnQgZGF0YSBzdHJ1Y3R1cmUgZGVzaWduLg0KDQpGcm9tIG15IHJlYWRpbmcg
b2YgdGhlIHByb2plY3QgZGVzY3JpcHRpb24sIHRoZSBjb3JlIGlkZWEgaXMgdG8gYWRkIGFuIG9w
dC1pbiBtb2RlIHdoZXJlIFFFTVUgaW50ZXJwb3NlcyBpdHNlbGYgb24gdGhlIGRhdGEgcGF0aCB1
c2luZyBTaGFkb3cgVmlydHF1ZXVlcyAoU1ZRKS4gQ3VycmVudGx5IHRoZSBiYWNrZW5kIHJlY2Vp
dmVzIGd1ZXN0IFJBTSBmaWxlIGRlc2NyaXB0b3JzIHZpYSBWSE9TVF9VU0VSX1NFVF9NRU1fVEFC
TEUgYW5kIG1hcHMgdGhlbSBkaXJlY3RseSwgZ2l2aW5nIGl0IGZ1bGwgYWNjZXNzIHRvIHRoZSBl
bnRpcmUgZ3Vlc3QgYWRkcmVzcyBzcGFjZS4gSW4gbWVtb3J5LWlzb2xhdGlvbiBtb2RlLCBRRU1V
IHdvdWxkIGluc3RlYWQgaW50ZXJjZXB0IHRoZSBraWNrZmQvY2FsbGZkIGV2ZW50ZmQgbm90aWZp
Y2F0aW9ucywgcmVhZCB0aGUgZ3Vlc3QncyB2aXJ0cXVldWUgZGVzY3JpcHRvcnMsIGNvcHkgdGhl
IHJlbGV2YW50IGRhdGEgYnVmZmVycyBiZXR3ZWVuIGd1ZXN0IFJBTSBhbmQgYSBzZXBhcmF0ZSBp
c29sYXRlZCBtZW1vcnkgcmVnaW9uLCBhbmQgcHJlc2VudCB0aGUgYmFja2VuZCB3aXRoIGFuIFNW
USBiYWNrZWQgYnkgdGhhdCBpc29sYXRlZCByZWdpb24uIFRoZSBiYWNrZW5kIG5ldmVyIHJlY2Vp
dmVzIHRoZSBndWVzdCBSQU0gZmRzIOKAlCBpdCBvbmx5IHNlZXMgdGhlIGlzb2xhdGVkIGFyZWEu
IFRoaXMga2VlcHMgdGhlIGNoYW5nZSB0cmFuc3BhcmVudCB0byBib3RoIGd1ZXN0IGRyaXZlcnMg
YW5kIGV4aXN0aW5nIHZob3N0LXVzZXIgYmFja2VuZHMsIHNpbmNlIHRoZSB2aG9zdC11c2VyIHBy
b3RvY29sIGl0c2VsZiBpcyB1bmNoYW5nZWQuDQoNCkEgZmV3IHRoaW5ncyBJJ3ZlIGJlZW4gdGhp
bmtpbmcgYWJvdXQ6DQoNClRoZSBwcm9qZWN0IGRlc2NyaXB0aW9uIG1lbnRpb25zIGludGVncmF0
aW5nIHRoZSBleGlzdGluZyBTVlEgY29kZSBmcm9tIHZob3N0LXNoYWRvdy12aXJ0cXVldWUuYyBp
bnRvIHZob3N0LXVzZXIuYy4gSSB1bmRlcnN0YW5kIFNWUSBpcyBjdXJyZW50bHkgdXNlZCBmb3Ig
dkRQQSBsaXZlIG1pZ3JhdGlvbiwgd2hlcmUgaXQgdGVtcG9yYXJpbHkgaW50ZXJwb3NlcyBvbiB0
aGUgZGF0YSBwYXRoIHRvIHRyYWNrIGRpcnR5IHBhZ2VzLiBUaGUgbWFpbiB3b3JrIGhlcmUgc2Vl
bXMgdG8gYmUgYWRhcHRpbmcgdGhhdCBtYWNoaW5lcnkgZm9yIG1lbW9yeSBpc29sYXRpb246IFFF
TVUgd291bGQgYWxsb2NhdGUgYW4gaXNvbGF0ZWQgbWVtb3J5IHJlZ2lvbiBhdCBkZXZpY2Ugc3Rh
cnR1cCwgcmVwbGFjZSB0aGUgZ3Vlc3QgUkFNIG1hcHBpbmdzIGluIFZIT1NUX1VTRVJfU0VUX01F
TV9UQUJMRSB3aXRoIHRoaXMgaXNvbGF0ZWQgcmVnaW9uLCBhbmQgdGhlbiBvbiBlYWNoIGtpY2ss
IHdhbGsgdGhlIGd1ZXN0IHZpcnRxdWV1ZSBkZXNjcmlwdG9ycywgbWVtY3B5IHRoZSByZWxldmFu
dCBidWZmZXJzIGZyb20gZ3Vlc3QgUkFNIGludG8gdGhlIGlzb2xhdGVkIGFyZWEgKGZvciBUWCkg
b3IgYmFjayBmcm9tIHRoZSBpc29sYXRlZCBhcmVhIGludG8gZ3Vlc3QgUkFNIChmb3IgUlgpLCBh
bmQgZm9yd2FyZCB0aGUgb3BlcmF0aW9uIHRocm91Z2ggdGhlIFNWUSB0byB0aGUgYmFja2VuZC4N
Cg0KT24gdGhlIHBlcmZvcm1hbmNlIHNpZGUsIHRoZSBwZXItSS9PIG1lbWNweSBpcyB1bmF2b2lk
YWJsZSBieSBkZXNpZ24sIGJ1dCBmb3IgdHlwaWNhbCBuZXR3b3JrIHBhY2tldHMgKDY0QuKAkzE1
MDBCKSB0aGUgY29zdCBzaG91bGQgc3RheSB3aXRoaW4gTDEvTDIgY2FjaGUgYW5kIGJlIGZhaXJs
eSBzbWFsbC4gTGFyZ2VyIHRyYW5zZmVycyAoZS5nLiB2aXJ0aW8tYmxrIHdpdGggMTI4S0IrIHJl
cXVlc3RzKSBtaWdodCBiZSBtb3JlIG5vdGljZWFibGUuIEkgd29uZGVyIGlmIHRoZXJlIGFyZSB3
YXlzIHRvIGFtb3J0aXplIHRoZSBjb3N0IOKAlCBiYXRjaGluZyBtdWx0aXBsZSBkZXNjcmlwdG9y
cyBiZWZvcmUgZm9yd2FyZGluZywgb3Igc2l6aW5nIHRoZSBpc29sYXRlZCByZWdpb24gdG8gc3Rh
eSBjYWNoZS1mcmllbmRseS4NCg0KQSBmZXcgcXVlc3Rpb25zOg0KLSBJcyB0aGlzIGV4cGVjdGVk
IHRvIHdvcmsgd2l0aCBhbGwgdmhvc3QtdXNlciBkZXZpY2UgdHlwZXMgKG5ldCwgYmxrLCBldGMu
KSwgb3IgaXMgaXQgc2NvcGVkIHRvIGEgc3BlY2lmaWMgZGV2aWNlIGluaXRpYWxseT8NCi0gVGhl
IGV4aXN0aW5nIFNWUSBjb2RlIGlzIHVzZWQgZm9yIHZEUEEgbGl2ZSBtaWdyYXRpb24sIHdoZXJl
IGl0IHRlbXBvcmFyaWx5IGludGVycG9zZXMgZHVyaW5nIHRoZSBtaWdyYXRpb24gd2luZG93IGFu
ZCBpcyB0aGVuIHJlbW92ZWQuIEluIG1lbW9yeS1pc29sYXRpb24gbW9kZSwgdGhlIFNWUSB3b3Vs
ZCBuZWVkIHRvIHN0YXkgb24gdGhlIGRhdGEgcGF0aCBwZXJtYW5lbnRseS4gQXJlIHRoZXJlIGFu
eSBhc3BlY3RzIG9mIHRoZSBjdXJyZW50IFNWUSBpbXBsZW1lbnRhdGlvbiB0aGF0IGFzc3VtZSB0
ZW1wb3JhcnkgdXNlIGFuZCB3b3VsZCBuZWVkIHJldGhpbmtpbmcgZm9yIGEgcGVyc2lzdGVudCBt
b2RlPw0KLSBGb3IgdGVzdGluZywgdGhlIHByb2plY3QgZGVzY3JpcHRpb24gbWVudGlvbnMgZXh0
ZW5kaW5nIHZob3N0LXVzZXItdGVzdC5jLiBCZXlvbmQgZnVuY3Rpb25hbCBjb3JyZWN0bmVzcyAo
ZGF0YSBpbnRlZ3JpdHkgd2l0aCBpc29sYXRpb24gb24pLCB3b3VsZCB5b3UgYWxzbyB3YW50IHBl
cmZvcm1hbmNlIHJlZ3Jlc3Npb24gZGF0YSBjb21wYXJpbmcgaXNvbGF0aW9uIG9uIHZzLiBvZmYg
KHRocm91Z2hwdXQsIGxhdGVuY3kpPw0KDQpJJ20gY29tZm9ydGFibGUgd2l0aCBDIGFuZCBoYXZl
IGV4cGVyaWVuY2Ugd2l0aCBtZW1vcnkgbWFuYWdlbWVudCBhbmQgbG93LWxldmVsIGRlYnVnZ2lu
ZyBmcm9tIG15IE9TIHdvcmsuIEkgaGF2ZW4ndCB3b3JrZWQgb24gUUVNVSdzIGNvZGViYXNlIGRp
cmVjdGx5LCBidXQgSSd2ZSB1c2VkIGl0IGV4dGVuc2l2ZWx5IGFuZCBJJ20gbG9va2luZyBmb3J3
YXJkIHRvIGRpZ2dpbmcgaW50byB0aGUgaW50ZXJuYWxzLg0KDQpUaGFua3MsDQpYdWhhaSBDaGFu
Zw0KDQpbMV0gaHR0cHM6Ly9naXRlZS5jb20vb3BlbmV1bGVyL25lc3Rvcy1hc3NlbWJsZXIvcHVs
bHMvMTQ0ICANClsyXSBodHRwczovL2dpdGh1Yi5jb20vUlZDSy1Qcm9qZWN0L3J2Y2stb2xrL3B1
bGwvMTA3IChiYWNrcG9ydCBvZiBtYWlubGluZSBsaW51eCBjb21taXQgZjJkZTM3YTU3Mjg1M2Qp

