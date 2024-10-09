Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DA0CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sySY8-0007XX-J6; Wed, 09 Oct 2024 05:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sySXu-0007XG-1U
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:59:50 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sySXp-0003SG-NK
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:59:49 -0400
To: Zhao Liu <zhao1.liu@intel.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] x86: Add support save/load HWCR MSR
Thread-Topic: [PATCH v1 1/1] x86: Add support save/load HWCR MSR
Thread-Index: AQHbGimJGzzAu7a83kSSJ9vdQ5PkZA==
Date: Wed, 9 Oct 2024 08:59:24 +0000
Message-ID: <7AEC3E01-EDA4-4507-8FD8-E14CA59A9D45@baidu.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.154]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C793F23FC709542AE759AC8321A4B61@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.14
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiA+IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9jcHUuYyBiL3RhcmdldC9pMzg2L2NwdS5jDQo+
ID4gaW5kZXggODVlZjc0NTJjMC4uMzM5MTMxYTM5YSAxMDA2NDQNCj4gPiAtLS0gYS90YXJnZXQv
aTM4Ni9jcHUuYw0KPiA+ICsrKyBiL3RhcmdldC9pMzg2L2NwdS5jDQo+ID4gQEAgLTcwOTMsNiAr
NzA5Myw3IEBAIHN0YXRpYyB2b2lkIHg4Nl9jcHVfcmVzZXRfaG9sZChPYmplY3QgKm9iaiwgUmVz
ZXRUeXBlIHR5cGUpDQo+ID4gZW52LT5hMjBfbWFzayA9IH4weDA7DQo+ID4gZW52LT5zbWJhc2Ug
PSAweDMwMDAwOw0KPiA+IGVudi0+bXNyX3NtaV9jb3VudCA9IDA7DQo+ID4gKyBlbnYtPmh3Y3Ig
PSAwOw0KPg0KPg0KPiBXaHkgd2UgbmVlZCB0byBjbGVhciBpdCBoZXJlPyBUaGlzIG5lZWRzIHRv
IGJlIGV4cGxhaW5lZCBpbiB0aGUgY29tbWl0DQo+IG1lc3NhZ2UuDQoNCkkgbWlzdW5kZXJzdG9v
ZCwgdGhlcmXigJlzIG5vIG5lZWQgdG8gY2xlYXIgaGVyZS4NCg0KPiA+DQo+ID4gKyNkZWZpbmUg
TVNSX0s3X0hXQ1IgMHhjMDAxMDAxNQ0KPiA+ICsNCj4gPiAjZGVmaW5lIE1TUl9WTV9IU0FWRV9Q
QSAweGMwMDEwMTE3DQo+ID4NCj4gPiAjZGVmaW5lIE1TUl9JQTMyX1hGRCAweDAwMDAwMWM0DQo+
ID4gQEAgLTE4NTksNiArMTg2MSw5IEBAIHR5cGVkZWYgc3RydWN0IENQVUFyY2hTdGF0ZSB7DQo+
ID4gdWludDY0X3QgbXNyX2xicl9kZXB0aDsNCj4gPiBMQlJFbnRyeSBsYnJfcmVjb3Jkc1tBUkNI
X0xCUl9OUl9FTlRSSUVTXTsNCj4gPg0KPiA+ICsgLyogSGFyZHdhcmUgQ29uZmlndXJhdGlvbiBN
U1IgKi8NCj4NCj4NCj4gV2UgY2FuIGtlZXAgdGhlIHNhbWUgY29tbWVudCBhcyBtc3JfaHdjciBp
biBLVk0gdG8gZW1waGFzaXplIHRoaXMgaXMgYW4NCj4gQU1ELXNwZWNpZmljIE1TUiwgaS5lLiwN
Cj4NCj4NCj4gLyogQU1EIE1TUkMwMDFfMDAxNSBIYXJkd2FyZSBDb25maWd1cmF0aW9uICovDQo+
DQo+DQo+ID4gKyB1aW50NjRfdCBod2NyOw0KPg0KPg0KPiBBZGQgdGhlIG1zcl8gcHJlZml4IHRv
IGluZGljYXRlIHRoYXQgdGhpcyB2YWx1ZSBpcyBvbmx5IGludGVuZGVkIHRvDQo+IHN0b3JlIHRo
ZSBNU1IuIEN1cnJlbnRseSwgZm9yIHNpbWlsYXIgbWVtYmVycywgc29tZSBoYXZlIHRoZSBtc3Jf
IHByZWZpeA0KPiBhbmQgc29tZSBkbyBub3QsIGJ1dCBpdCBpcyBiZXR0ZXIgdG8gaGF2ZSBpdCBm
b3IgY2xhcml0eS4NCj4NCg0KVGhhbmtzLCBJIHdpbGwgbW9kaWZ5IGl0Lg0KDQo=

