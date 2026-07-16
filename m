Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D587C4450E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkIbB-0001fR-0h; Thu, 16 Jul 2026 05:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harry.vanhaaren@openchip.com>)
 id 1wkIb8-0001et-Ki
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 05:41:42 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harry.vanhaaren@openchip.com>)
 id 1wkIb5-0000NU-TC
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 05:41:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGa2xkCOlz0KKMKosWmoSl9Z2ap37LQD5xnPxWfbWA8Wz6ifgqjRgHSHD9ilhbx5JV/6IcHuxv2FdcTPC1c9rm9Kfp5ktIJD4tVfsg4uQsaMYmHGGDMh5qoJD/x/18uTMw0J0z2u4DYz50kn47RjAhjAqgPGK+rnO1ocfXvDURcN7Bs+AYFGM+N1izUMRihxrj3KCuUbT3rObxUaNB3ersidj5zZVs1PeIAScR0mJJq+4aflQXn+3aXpfvmQfM+8tXTuTUkuNynAlhSLDkFJYPmeiL4GRlEORCJ3VZqp+glVFgKZjqeqnwM+O+X8E5Z4CPe0fTMs5tMHUNtQuDEsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kz49DH0+pUAcGRSIZFS81xzlesqoFiXQQaGyfqRnIQ=;
 b=oecnrTDmhxRGggRKao4h2kVq2P+NgD5XcGSm9/zlaJrmU6q8A43XDQieME6RzfHkfaXldxnuyxUsPONgQBZ2pSybDh6teH3YmWQrW8izRZ5IqZc4Nl6nhCmGrOyNS8UUwMO9SN27taDRnGJ7Zbxrpfw3AKEn/G6n5I5enuUESzsYAF4bHnME0XA4mh6gKs5bLg1b9IwcjIzNSih64kxzHYLdoa3OjPejaDDZWNWdFk5vdG4S4THVrN5Yrjkfch2JkRuKibh7yJxZvGc8N+BehxrQ6PMEyINC6z2dD5xpPUyuqmLWULJyrCIbxXzzFrM03/Mj2++eKCaRcyfrGQpXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openchip.com; dmarc=pass action=none header.from=openchip.com;
 dkim=pass header.d=openchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kz49DH0+pUAcGRSIZFS81xzlesqoFiXQQaGyfqRnIQ=;
 b=KKE/tMFGHF7YJbg5FUcfYEL0D2BHCWbBGbH1+Q3uvG1Af9ZCCcaV8++Wp00Hjb7jqMYY6qLV0eahz57U8wAIUtaBXtyZT3OdTSUPmbEXtE6jndRjXLdN/zdR10V5V9fp6u2iTXOrSZ/GpPKs+Kv+d8EECqjrRBmnt5qaNl7TzcUOgOIAIPBqL052JrJhSZ/cX250iBlKpIfo+dBE9HmATiDNyu1BL4VVq2MSNHiBJDZMRFw7AOxITz1v6NsdLG0Phd4GVsEC6naOLP2rUfiw/5dqpDMcUJ9iaZMp3wp5lW1eyzXnFetj1oPDDBwf+hza4P4m3yLw7uw3BoUAsie+Ug==
Received: from GV2P192MB3464.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:328::6)
 by VI1P192MB2186.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 09:41:32 +0000
Received: from GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
 ([fe80::7ed0:3600:9df4:af64]) by GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
 ([fe80::7ed0:3600:9df4:af64%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 09:41:32 +0000
From: Harry van Haaren <harry.vanhaaren@openchip.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: BALATON Zoltan <balaton@eik.bme.hu>, Alexandre Iooss <erdnaxe@crans.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Harry van Haaren
 <harry.vanhaaren@openchip.com>
Subject: [PATCH v2 0/2] plugins/execlog: fix segfault and flush output on vcpu
 exit
Thread-Topic: [PATCH v2 0/2] plugins/execlog: fix segfault and flush output on
 vcpu exit
Thread-Index: AQHdFQdJu/FiksvJv0eX2zuIpJXEzw==
Date: Thu, 16 Jul 2026 09:41:32 +0000
Message-ID: <20260716094126.787556-1-harry.vanhaaren@openchip.com>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
In-Reply-To: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=openchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2P192MB3464:EE_|VI1P192MB2186:EE_
x-ms-office365-filtering-correlation-id: 356b123b-3d72-4b6c-a0ab-08dee31e6b82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|3023799007|6133799003|11063799006|56012099006|10067099003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: HpRlVZi3d+GGf058GulkzfQgdUalOOlPenAg5qX/EMLsEXjeHx/QPvLfDkSNQsB4xKhK9JZUsRQ9LLdCY3AbIYMbUhdoEr0+UC9Nmfi7n+VNEzq5c92qcep50UFzCMdhvB37hk7lEp7tSsZ8gzfUk7SIp1Vv1ZXnDKIKg4ewPgABI1R1WZmRdLFm2k4iASFwQmWKdDI4Ox5J+dan/lKAyYskhnzlBs92QFFpGrbzWaWb5Wul6uj8/mkHzyfat3otdZ9q3xgviXjngorLWmZQ0QygLzcBtFwjZYXeY/tfmsR+4e6AO1aSClYfSrrWInTFJeA+Pnt2iQc8bOueSkqsvqMrbU+uUoVyGklB/fJV0Y8B7LbMdknwizA4W/oxMq0LEo5xrDa4yXYowoDgD1HzHX9n6d1UBIU6gnwz8Z4UqxWRyiXPaN6c3TvIT8wrFW6uTMb/TibEFnSKjCooJ71bG84ttlwb0vhpG0uw9sm/aYSz9+HYZIB6ttuNjHUgqklrSftV8ZUpRmp4YmDFCDgmwXQLu5NHagROYoKoqltsKusj3kfx34otyD+ZDOJSh5S6KP4xKr4G52nRlxVs4Z/QP33LK5E2nGxJDO/heg7dX81gpkT75QI+jPm2Ff69qt3HdIqDkqGhAbqx1rAi2uVEYOtlJTOAAjYPo2YGL77dUYIzptYmWhVfYSrmYTHdRHSZqBApNxo3WsmSuR2UcEet11rzMOurSvlsJaZZYIQOMj4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2P192MB3464.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(3023799007)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekx1NzcyNUtOc2xmUW1rUDRYamdLbGRTYlBwcTRRSXpaSFBIRUtmNUhYTjVW?=
 =?utf-8?B?aHJiTlF2R0o5bjduUUwwN2Fuak8wcmd0OGl0N3J5QkFIbXJCVGVWVDNsVC8w?=
 =?utf-8?B?MHZsQmtrUUozUHhnc3lkRmkyQ1JmcUExSW41cGdaUTY5d2tzR2hVczhtcUh4?=
 =?utf-8?B?WXR2ZTRueWdHdkxSejE2Mk56ajhPVGJqRDdkeGdUSmljYnhKYzNOdERmdHhy?=
 =?utf-8?B?Vkt2ek1jMXRoRzQwWmUyQ0krSDNGZjBZbXM4NEh6Yy9oSGVjMWpnS21IdnBk?=
 =?utf-8?B?K0tDRzZDeURlc0craXJuYS9SeFJWa0NtR3JKbWJMM0sxMHY4N0RSMWxRV3hp?=
 =?utf-8?B?Y2tNY01RZ2UrZXRqMFNiU095RS9SZW15a3J4ZWY3U0Y5SFFYYTNHRS9Qa0JH?=
 =?utf-8?B?NEczdjlyZHl4WmZWWnQyRjdxaFRnbENTU2ZHVWVDdTE5enkrL0pkSWM2NmxX?=
 =?utf-8?B?UndEUk9vMHVRUU5Ua1B0Z2NDRWVEMGVzZEhydkVZempMK0UrQTN0ME1RcEVE?=
 =?utf-8?B?VGh6RmdtaXFpdzhSOUUzcmE3UjFVWVlQQytFekRsQ0ZMMG1ySXpaNURha1o3?=
 =?utf-8?B?WXJGOWlTYkx3QU1PUFE1ai85YVBqTkZnZGpXS2h1VUhnTWRQbGI0Nk5Rb0x1?=
 =?utf-8?B?ZUtta1A1T291SVk5RFNyNGU3UFhScTNTY04xR1FOMndXMDdOY3JFK2UvQkdC?=
 =?utf-8?B?cldqSm1NbVBNV3hzd3ZJdlNtczZkYWVLa2ZQdVM1YUNFQno3YWNCQTgrTTdP?=
 =?utf-8?B?aDg4WU53MzR2TzZCWXlXY1BpbEFzMW1aSVNGSDliem9WLzNxL1VBZjJ0eUVT?=
 =?utf-8?B?SGU1WkJlVkdLbXJWTXhaM25aSzFhL1FNdlFvMXV6VUJueDJ0REV6dkxWSGQw?=
 =?utf-8?B?SThWS0I5WDlPUHpaNms1cGI2RHN0ekJwT2x0c0kvNU85V2oyaTh5Vmk1dnB1?=
 =?utf-8?B?Y1FtejRvOWlTYk92UnhhMEVLazZWWTh4ZVI2dTAvMWRGZEwvMDR1MGxObE5t?=
 =?utf-8?B?L3YvRWxtWmZPd1FCalhoeGU1VlJGSlVUZGlLVzJOVnhXR21NclpjeVc2cGFR?=
 =?utf-8?B?cmVUam1jYnVlZ25TSnliTE52ZHk3TFJyTkZ3MFNlYk04NVdmNU1PSnQzY2Zw?=
 =?utf-8?B?MStjckZiaG00TzFjVGlJN043MjBSZnBDS0lwQXJFcWVmUDFwNm5nU1oyWHRo?=
 =?utf-8?B?SXkvRWlaa1ZoSjI1TE1PQjZ2Yk9iZ2hIV0I3bUgwSSt6VDY4azM5YXozNTBu?=
 =?utf-8?B?SlV3dnFDMk8zMzVsSFZkQlpxSmFrSnJnS3hKY3U2VFlIK1lpUkJqRytNWndm?=
 =?utf-8?B?cXlzSklQbGgybkJGSDR2WUhYNm5CMkVUQUhMbjZGWUNSMmpESS9oei9VQk1M?=
 =?utf-8?B?MmhwbUVOVTdSOFlQRms5dVRKVjF5dWIvcnZPYkpCMVVIeHhSREIvMSsrMUEw?=
 =?utf-8?B?cTJZZXZwZ0U4aXBNeG5MdlpuemZEdGhMRHVjVjM0NUVPZWF2RnZSTWY4ODZy?=
 =?utf-8?B?UTdHM3RjaXhlcGpDUGdCSWVxRjYzQkVFYjNuWVZhK1lFc2NhSlRFbmJyVlRk?=
 =?utf-8?B?eWloQ3A4SkFGUGhuRzRXb1hBN3pSdExlajNKTUh1QitYZS9OVm5ZK1ZwNW5q?=
 =?utf-8?B?M0lydFl3QzI0SnVERkxkSE5XZ1Bkek1TS2s1U0d2VjRwUzI2cTF0TXZhUlJP?=
 =?utf-8?B?VlVaU1lydU44ZC94Vytid1ZjNzh4bmJEZFU2S1M4QmovOUgxOVA0ZXJTbGRm?=
 =?utf-8?B?VnBPY1kwNWFUQzhocHZtYnEveEpSQjhEajFsOTNDMEhMQlBrSVdoazhIcW5F?=
 =?utf-8?B?YWtXby9vN2MzNG8rdmx3VUx2aHZwdmdoYU80YkpzRVdGb1NkQ3Zsb1BWZXBY?=
 =?utf-8?B?RFJBeGYzZEdiTmF2Y2hmQjYzb2kwbm1vQmFwUHM1b0NGaXNwcmlqWS83Zzdj?=
 =?utf-8?B?K1BwOW01dVkvQzArcmU5M3BKa0JWaTRKcHAxeDFPaWliTng2Q0FXZWxkdk1l?=
 =?utf-8?B?UzFUNGRBWUFTeUd0M1lKdlJTYk01VStoUTFUd2ppb0RheEZ0aHkrYjFObHlW?=
 =?utf-8?B?SjByYjNWS3JRVm5QbjNEMVBwdm9iWEZSL3dqdWZZMVBlZzJweGZnb0R3Y0dw?=
 =?utf-8?B?WG93cWpRcU9OeXhFNFJoUXlrc0kzejJmcFR1K0pRclFjSWhab1FxeisvZVRM?=
 =?utf-8?B?S3dtazZFei9JU0EwQkN5NjVwaVh2bk1qNEl5WXRxMzVuWXc0bXZCb25xWUxk?=
 =?utf-8?B?MWMzZ013aUlHUDhTMTlBTDIwQjhOQUpYQWc5NEsrUFM3cTNRQ3JEYlN0TGZu?=
 =?utf-8?B?TWs4M05tTFZVdkNkYVhqVUVsc0VsREErVFUrMVdwQUdLUzkvSHBIZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D72677E21C02A04FA4A27A1D0EF16C75@EURP192.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 356b123b-3d72-4b6c-a0ab-08dee31e6b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 09:41:32.4811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dfdd4aff-e2c9-4e1a-8642-7f6cc6bbbe6d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oarxJ3tNlz9NjVrPRQyrz6x0G/nEZQMYM2LU9nXzbZzagIXXrBBHnZSZAAfnrvtRkxK7tAZDHrPwJmqdWMtMFgm6Cj/0IL1H5GuXsPLFsKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB2186
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=harry.vanhaaren@openchip.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

RnJvbTogSGFycnkgdmFuIEhhYXJlbiA8aGFycnkudmFuaGFhcmVuQG9wZW5jaGlwLmNvbT4KCkhp
IFFlbXUtRGV2ICYgQ0NzLAoKVGhpcyBpcyBteSBmaXJzdCBjb250cmlidXRpb24gdG8gUUVNVSBp
dHNlbGYsIGJ1dCBJIGhhdmUgd29ya2VkIG9uCkRQREssIE9WUywgYW5kIFFFTVUtUlMgYSBiaXQg
aW4gdGhlIHBhc3QuIEkgaGF2ZSBleHBlcmllbmNlIHdpdGgKbWFpbGluZyBsaXN0cyBmb3IgcGF0
Y2hlcyBhbmQgc29tZSBRRU1VIGludGVybmFscy4KClRoaXMgaXMgYSAiZ2l0IHB1Ymxpc2giIHJl
cGx5IHRvIHRoZSBvcmlnaW5hbCBwYXRjaGVzIHRoYXQgd2VyZW4ndCBpbiBhIHBhdGNoc2V0Ogpo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1kZXZlbC9wYXRjaC8yMDI2
MDYxNjE2MTI0Mi4yNjczMTUtMS1oYXJyeS52YW5oYWFyZW5Ab3BlbmNoaXAuY29tLwpodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1kZXZlbC9wYXRjaC8yMDI2MDYxNjE2
MTI0Mi4yNjczMTUtMi1oYXJyeS52YW5oYWFyZW5Ab3BlbmNoaXAuY29tLwoKVGhhbmtzIGZvciBy
ZXZpZXdzIGFuZCBpbnB1dCwgdGhlIHYyIHJld29ya3MgYXMgZm9sbG93czoKLSBJIGV4cGVjdCBl
bWFpbCB0byBubyBsb25nZXIgaGF2ZSAifCBPUEVOQ0hJUCIgaW4gbXkgbmFtZSwgYW5kIHRoZSBl
bWFpbCBmb290ZXIgcmVtb3ZlZAotIGdpdCBwdWJsaXNoIHVzZWQgdG8gc2VuZCwgd2l0aCAiLS1u
dW1iZXIgMiIgdG8gaG9wZWZ1bGx5IGdldCBhIHYyIHBhdGNoc2V0IG91dAotIHJlYmFzZWQgdG8g
bGF0ZXN0IGJyYW5jaCwgYXRleGl0KCkgZnVuY3Rpb24gc2lnbmF0dXJlcyBjaGFuZ2VkCi0gYXZv
aWQgYWRkaW5nIG11dGV4IGZvciBvdXRwdXQsIHJlbHkgb24gUUVNVXMgbG9nZ2luZyBtdXRleCAo
dGhhbmtzIFBpZXJyaWNrKQotLS0gdXNlIHNpbmdsZSBjYWxsIHRvIGxvZyB0byBhdm9pZCBsaW5l
LWJyZWFrcyBjb3JydXB0aW5nIG91dHB1dAoKUGxlYXNlIG5vdGUgdGhhdCBMTE1zIHdlcmUgdXNl
ZCB0byBpbnZlc3RpZ2F0ZSBhbmQgZml4IHRoaXMgYnVnLApidXQgYWxsIGNvZGUgaW4gdGhpcyBw
YXRjaCBoYXMgYmVlbiByZXZpZXdlZCBieSBtZSwgYW5kIEkgYmVsaWV2ZQppdCB0byBiZSBhIGdv
b2Qgc29sdXRpb24uCgpSZWdhcmRzLCAtSGFycnkKCkhhcnJ5IHZhbiBIYWFyZW4gKDIpOgogIHBs
dWdpbnMvZXhlY2xvZzogZml4IHNlZ2ZhdWx0L3JhY2UtY29uZCBvbiBwZXItdkNQVSBzdHJ1Y3R1
cmVzCiAgcGx1Z2lucy9leGVjbG9nOiBmaXggZXhlY2xvZyB2Y3B1X2V4aXQgZXhlY3V0aW9uIHBy
aW50IGxvc3MKCiBjb250cmliL3BsdWdpbnMvZXhlY2xvZy5jIHwgODggKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygr
KSwgNDUgZGVsZXRpb25zKC0pCgotLSAKMi41NC4wCgo=

