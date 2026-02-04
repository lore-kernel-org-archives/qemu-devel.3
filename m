Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D6DE8B383
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 01:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnRJD-0003oL-Pk; Tue, 03 Feb 2026 20:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vnRJC-0003o8-IB; Tue, 03 Feb 2026 20:03:54 -0500
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vnRJ9-0000Xq-RD; Tue, 03 Feb 2026 20:03:54 -0500
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4f5MYS3v2Wz5BNRf;
 Wed, 04 Feb 2026 09:03:40 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
 by mse-fl2.zte.com.cn with SMTP id 61413TBX082219;
 Wed, 4 Feb 2026 09:03:29 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp02[null]) by mapi (Zmail) with MAPI id mid32;
 Wed, 4 Feb 2026 09:03:30 +0800 (CST)
X-Zmail-TransId: 2afa69829ae23a9-f67ea
X-Mailer: Zmail v1.0
Message-ID: <20260204090330375y0v2aPy7n9usQq7mAyk4T@zte.com.cn>
In-Reply-To: <20260203094546-mutt-send-email-mst@kernel.org>
References: 2025111309270952219AjKpVEnbJXB7fcGTE4g@zte.com.cn,
 20260203094546-mutt-send-email-mst@kernel.org
Date: Wed, 4 Feb 2026 09:03:30 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <mst@redhat.com>
Cc: <imammedo@redhat.com>, <alistair.francis@wdc.com>,
 <dbarboza@ventanamicro.com>, <sunilvl@ventanamicro.com>,
 <anisinha@redhat.com>, <pbonzini@redhat.com>, <palmer@dabbelt.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NCBSRVNFTkQgMC8yXSBody9yaXNjdi92aXJ0OiBBZGQgYWNwaSBnZWQgYW5kIHBvd2VyZG93biBzdXBwb3J0?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 61413TBX082219
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Feb 2026 09:03:40 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69829AEC.000/4f5MYS3v2Wz5BNRf
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBGZWIgMywgMjAyNiBhdCAxMDo0NjowOVBNLCAgTWljaGFlbFMuVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOg0KPj4gRnJvbTogWHVlbWVpIExpdSA8bGl1Lnh1ZW1laTFAenRl
LmNvbS5jbj4NCj4+IA0KPj4gQWRkIHJpc2N2IGFjcGkgcG93ZXJkb3duIHN1cHBvcnQNCj4NCj4N
Cj5kaWQgeW91IGFiYW5kb24gdGhpcyBvciBkbyB5b3UgcGxhbiB0byBhZGRyZXNzIElnb3IncyBj
b21tZW50cz8NCg0KVGhhbmsgeW91IGZvciB0aGUgcmVtaW5kZXIuIFNvcnJ5IGZvciB0aGUgZGVs
YXkg4oCUIEknbGwgc2VuZCB2NSBzaG9ydGx5Lg0KDQpUaGFua3MsDQpKZXNzaWNhDQoNCj4NCj4+
IENoYW5nZXMgaW4gdjQ6DQo+PiAtIEFkZGVkIG1vZGlmaWVzIG9mIERTRFQgYmxvYiBpbiBhbm90
aGVyIHBhdGNoDQo+PiAtIExpbmsgdG8gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUt
cmlzY3YvMjAyNTA3MjMxMTM3Mzk3NTFDT1o1UGtSeng2YVhFdUt6c0hobV9AenRlLmNvbS5jbi8N
Cj4+IA0KPj4gQ2hhbmdlcyBpbiB2MzoNCj4+IC0gQWRkZWQgbWlzc2luZyBwYXJhbSB0byB2aXJ0
X2lzX2FjcGlfZW5hYmxlZA0KPj4gLSBGaXhlZCBmYWlsdXJlIG9mIGJpb3MtdGFibGVzLXRlc3QN
Cj4+IC0gTGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1yaXNjdi8yMDI1
MDYyMDExMzAwOTk4NjFsVGtEODM5SGg2b2tvOEpvMlcySEB6dGUuY29tLmNuLw0KPj4gDQo+PiBD
aGFuZ2VzIGluIHYyOg0KPj4gLSBVbndyYXBwZXJlZCBhY3BpX2RzZHRfYWRkX2dlZCBmdW5jdGlv
bg0KPj4gLSBNb2RpZmllZCBiYXNlIGFkZHJlc3Mgb2YgVklSVF9BQ1BJX0dFRA0KPj4gLSBBZGRl
ZCBjb25kaXRpb25zIGZvciBmdW5jdGlvbiBjYWxscw0KPj4gLSBBZGp1c3RlZCBjb2RlIGZvcm1h
dHRpbmcNCj4+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1yaXNj
di8yMDI1MDYxOTE1NTYyNjA3MzVReFdDOHN4UndGVVJZRXZsRDI0eUB6dGUuY29tLmNuLw0KPj4g
DQo+PiBYdWVtZWkgTGl1ICgyKToNCj4+ICAgaHcvcmlzY3YvdmlydDogQWRkIGFjcGkgZ2VkIGFu
ZCBwb3dlcmRvd24gc3VwcG9ydA0KPj4gICB0ZXN0cy9hY3BpOiBBZGQgYWNwaSBnZWQgYW5kIHBv
d2VyIGJ1dHRvbiBpbiBEU0RUIGZvciBSSVNDLVYNCj4+IA0KPj4gIGh3L3Jpc2N2L0tjb25maWcg
ICAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgaHcvcmlzY3YvdmlydC1hY3BpLWJ1aWxkLmMg
ICAgICAgIHwgIDEwICsrKysrKysrKw0KPj4gIGh3L3Jpc2N2L3ZpcnQuYyAgICAgICAgICAgICAg
ICAgICB8ICAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICBpbmNsdWRlL2h3
L3Jpc2N2L3ZpcnQuaCAgICAgICAgICAgfCAgIDQgKysrKw0KPj4gIHRlc3RzL2RhdGEvYWNwaS9y
aXNjdjY0L3ZpcnQvRFNEVCB8IEJpbiAzNTM4IC0+IDM2ODEgYnl0ZXMNCj4+ICA1IGZpbGVzIGNo
YW5nZWQsIDUwIGluc2VydGlvbnMoKykNCj4+IA0KPj4gLS0gDQo+PiAyLjI3LjA=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPk9uIFR1ZSwgRmViIDMsIDIwMjYgYXQgMTA6NDY6
MDlQTSwgJm5ic3A7TWljaGFlbFMuVHNpcmtpbiAmbHQ7bXN0QHJlZGhhdC5jb20mZ3Q7Jm5ic3A7
d3JvdGU6PC9wPjxwPiZndDsmZ3Q7IEZyb206IFh1ZW1laSBMaXUgJmx0O2xpdS54dWVtZWkxQHp0
ZS5jb20uY24mZ3Q7PC9wPjxwPiZndDsmZ3Q7Jm5ic3A7PC9wPjxwPiZndDsmZ3Q7IEFkZCByaXNj
diBhY3BpIHBvd2VyZG93biBzdXBwb3J0PC9wPjxwPiZndDs8L3A+PHA+Jmd0OzwvcD48cD4mZ3Q7
ZGlkIHlvdSBhYmFuZG9uIHRoaXMgb3IgZG8geW91IHBsYW4gdG8gYWRkcmVzcyBJZ29yJ3MgY29t
bWVudHM/PC9wPjxwPjxicj48L3A+PHA+VGhhbmsgeW91IGZvciB0aGUgcmVtaW5kZXIuIFNvcnJ5
IGZvciB0aGUgZGVsYXkg4oCUIEknbGwgc2VuZCB2NSBzaG9ydGx5LjwvcD48cD48YnI+PC9wPjxw
PlRoYW5rcyw8L3A+PHA+SmVzc2ljYTwvcD48cD48YnI+PC9wPjxwPiZndDs8L3A+PHA+Jmd0OyZn
dDsgQ2hhbmdlcyBpbiB2NDo8L3A+PHA+Jmd0OyZndDsgLSBBZGRlZCBtb2RpZmllcyBvZiBEU0RU
IGJsb2IgaW4gYW5vdGhlciBwYXRjaDwvcD48cD4mZ3Q7Jmd0OyAtIExpbmsgdG8gdjM6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtcmlzY3YvMjAyNTA3MjMxMTM3Mzk3NTFDT1o1UGtSeng2
YVhFdUt6c0hobV9AenRlLmNvbS5jbi88L3A+PHA+Jmd0OyZndDsmbmJzcDs8L3A+PHA+Jmd0OyZn
dDsgQ2hhbmdlcyBpbiB2Mzo8L3A+PHA+Jmd0OyZndDsgLSBBZGRlZCBtaXNzaW5nIHBhcmFtIHRv
IHZpcnRfaXNfYWNwaV9lbmFibGVkPC9wPjxwPiZndDsmZ3Q7IC0gRml4ZWQgZmFpbHVyZSBvZiBi
aW9zLXRhYmxlcy10ZXN0PC9wPjxwPiZndDsmZ3Q7IC0gTGluayB0byB2MjogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1yaXNjdi8yMDI1MDYyMDExMzAwOTk4NjFsVGtEODM5SGg2b2tvOEpv
MlcySEB6dGUuY29tLmNuLzwvcD48cD4mZ3Q7Jmd0OyZuYnNwOzwvcD48cD4mZ3Q7Jmd0OyBDaGFu
Z2VzIGluIHYyOjwvcD48cD4mZ3Q7Jmd0OyAtIFVud3JhcHBlcmVkIGFjcGlfZHNkdF9hZGRfZ2Vk
IGZ1bmN0aW9uPC9wPjxwPiZndDsmZ3Q7IC0gTW9kaWZpZWQgYmFzZSBhZGRyZXNzIG9mIFZJUlRf
QUNQSV9HRUQ8L3A+PHA+Jmd0OyZndDsgLSBBZGRlZCBjb25kaXRpb25zIGZvciBmdW5jdGlvbiBj
YWxsczwvcD48cD4mZ3Q7Jmd0OyAtIEFkanVzdGVkIGNvZGUgZm9ybWF0dGluZzwvcD48cD4mZ3Q7
Jmd0OyAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtcmlzY3YvMjAy
NTA2MTkxNTU2MjYwNzM1UXhXQzhzeFJ3RlVSWUV2bEQyNHlAenRlLmNvbS5jbi88L3A+PHA+Jmd0
OyZndDsmbmJzcDs8L3A+PHA+Jmd0OyZndDsgWHVlbWVpIExpdSAoMik6PC9wPjxwPiZndDsmZ3Q7
Jm5ic3A7ICZuYnNwO2h3L3Jpc2N2L3ZpcnQ6IEFkZCBhY3BpIGdlZCBhbmQgcG93ZXJkb3duIHN1
cHBvcnQ8L3A+PHA+Jmd0OyZndDsmbmJzcDsgJm5ic3A7dGVzdHMvYWNwaTogQWRkIGFjcGkgZ2Vk
IGFuZCBwb3dlciBidXR0b24gaW4gRFNEVCBmb3IgUklTQy1WPC9wPjxwPiZndDsmZ3Q7Jm5ic3A7
PC9wPjxwPiZndDsmZ3Q7Jm5ic3A7IGh3L3Jpc2N2L0tjb25maWcmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyB8Jm5ic3A7ICZuYnNw
OzEgKzwvcD48cD4mZ3Q7Jmd0OyZuYnNwOyBody9yaXNjdi92aXJ0LWFjcGktYnVpbGQuYyZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyB8Jm5ic3A7IDEwICsrKysrKysrKzwvcD48cD4mZ3Q7Jmd0
OyZuYnNwOyBody9yaXNjdi92aXJ0LmMmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDt8Jm5ic3A7IDM1ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKzwvcD48cD4mZ3Q7Jmd0OyZuYnNwOyBpbmNsdWRlL2h3L3Jpc2N2
L3ZpcnQuaCZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7fCZuYnNwOyAm
bmJzcDs0ICsrKys8L3A+PHA+Jmd0OyZndDsmbmJzcDsgdGVzdHMvZGF0YS9hY3BpL3Jpc2N2NjQv
dmlydC9EU0RUIHwgQmluIDM1MzggLSZndDsgMzY4MSBieXRlczwvcD48cD4mZ3Q7Jmd0OyZuYnNw
OyA1IGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyk8L3A+PHA+Jmd0OyZndDsmbmJzcDs8
L3A+PHA+Jmd0OyZndDsgLS0mbmJzcDs8L3A+PHA+Jmd0OyZndDsgMi4yNy4wPC9wPjxwIHN0eWxl
PSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVp
OyI+PGJyPjwvcD48cCBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF
6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+PHAgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2Zv
bnQtZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7Ij48YnI+PC9wPjxwIHN0eWxl
PSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVp
OyI+PGJyPjwvcD48cD48YnI+PC9wPjwvZGl2Pg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


