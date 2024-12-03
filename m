Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21096E69EA6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 10:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIQcH-0000Px-Ji; Tue, 03 Dec 2024 05:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1tIQcF-0000Pm-5a
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:58:51 -0500
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1tIQcC-0004vK-J3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:58:50 -0500
To: "eduardo@habkost.net" <eduardo@habkost.net>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH 1/1] pcie-root-port: Fast PCIe root ports for new machine
Thread-Topic: [PATCH 1/1] pcie-root-port: Fast PCIe root ports for new machine
Thread-Index: AQHbRXJEfC8FNue/40yeOjgxK7k8Og==
Date: Tue, 3 Dec 2024 10:58:22 +0000
Message-ID: <BB513C15-DFE1-40B0-91B6-914D70D3EFB2@baidu.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.193.14]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F01014E639865E4E9CA4CDCB1EBEAC31@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.11
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

PiBTb21lIGhhcmR3YXJlIGRldmljZXMgbm93IHN1cHBvcnQgUENJZSA1LjAsIHNvIGNoYW5nZSB0
aGUgZGVmYXVsdA0KPiBzcGVlZCBvZiB0aGUgUENJZSByb290IHBvcnQgb24gbmV3IG1hY2hpbmUg
dHlwZXMuDQo+DQo+IEZvciBwYXNzdGhyb3VnaCBOdmlkaWEgSDIwLCB0aGlzIHdpbGwgYmUgYWJs
ZSB0byBpbmNyZWFzZSB0aGUgaDJkL2QyaA0KPiBiYW5kd2lkdGggfjE3JS4NCj4NCj4gT3JpZ2lu
Og0KPiBbQ1VEQSBCYW5kd2lkdGggVGVzdF0gLSBTdGFydGluZy4uLg0KPiBSdW5uaW5nIG9uLi4u
DQo+DQo+IERldmljZSAwOiBOVklESUEgSDIwDQo+IFF1aWNrIE1vZGUNCj4NCj4gSG9zdCB0byBE
ZXZpY2UgQmFuZHdpZHRoLCAxIERldmljZShzKQ0KPiBQSU5ORUQgTWVtb3J5IFRyYW5zZmVycw0K
PiAgICBUcmFuc2ZlciBTaXplIChCeXRlcykgICAgQmFuZHdpZHRoKE1CL3MpDQo+ICAgIDMzNTU0
NDMyICAgICAgICAgICAgNDU5MTUuNA0KPg0KPiBEZXZpY2UgdG8gSG9zdCBCYW5kd2lkdGgsIDEg
RGV2aWNlKHMpDQo+IFBJTk5FRCBNZW1vcnkgVHJhbnNmZXJzDQo+ICAgIFRyYW5zZmVyIFNpemUg
KEJ5dGVzKSAgICBCYW5kd2lkdGgoTUIvcykNCj4gICAgMzM1NTQ0MzIgICAgICAgICAgICA0NTk4
MC4zDQo+DQo+IERldmljZSB0byBEZXZpY2UgQmFuZHdpZHRoLCAxIERldmljZShzKQ0KPiBQSU5O
RUQgTWVtb3J5IFRyYW5zZmVycw0KPiAgICBUcmFuc2ZlciBTaXplIChCeXRlcykgICAgQmFuZHdp
ZHRoKE1CL3MpDQo+ICAgIDMzNTU0NDMyICAgICAgICAgICAgMTg0Mjg4Ni44DQo+DQo+IFJlc3Vs
dCA9IFBBU1MNCj4NCj4gV2l0aCB0aGlzIHBhdGNoOg0KPiBbQ1VEQSBCYW5kd2lkdGggVGVzdF0g
LSBTdGFydGluZy4uLg0KPiBSdW5uaW5nIG9uLi4uDQo+DQo+IERldmljZSAwOiBOVklESUEgSDIw
DQo+IFF1aWNrIE1vZGUNCj4NCj4gSG9zdCB0byBEZXZpY2UgQmFuZHdpZHRoLCAxIERldmljZShz
KQ0KPiBQSU5ORUQgTWVtb3J5IFRyYW5zZmVycw0KPiAgICBUcmFuc2ZlciBTaXplIChCeXRlcykJ
QmFuZHdpZHRoKE1CL3MpDQo+ICAgIDMzNTU0NDMyCQkJNTM2ODIuMA0KPg0KPiBEZXZpY2UgdG8g
SG9zdCBCYW5kd2lkdGgsIDEgRGV2aWNlKHMpDQo+IFBJTk5FRCBNZW1vcnkgVHJhbnNmZXJzDQo+
ICAgIFRyYW5zZmVyIFNpemUgKEJ5dGVzKQlCYW5kd2lkdGgoTUIvcykNCj4gICAgMzM1NTQ0MzIJ
CQk1Mzc2Ni4wDQo+DQo+IERldmljZSB0byBEZXZpY2UgQmFuZHdpZHRoLCAxIERldmljZShzKQ0K
PiBQSU5ORUQgTWVtb3J5IFRyYW5zZmVycw0KPiAgICBUcmFuc2ZlciBTaXplIChCeXRlcykJQmFu
ZHdpZHRoKE1CL3MpDQo+ICAgIDMzNTU0NDMyCQkJMTg0MjU1NS4xDQo+DQo+IFJlc3VsdCA9IFBB
U1MNCj4NCj4gU2lnbmVkLW9mZi1ieTogR2FvIFNoaXl1YW4gPGdhb3NoaXl1YW5AYmFpZHUuY29t
Pg0KPiAtLS0NCj4gaHcvY29yZS9tYWNoaW5lLmMgICAgICAgICAgICAgICAgICB8IDEgKw0KPiBo
dy9wY2ktYnJpZGdlL2dlbl9wY2llX3Jvb3RfcG9ydC5jIHwgMiArLQ0KPiAyIGZpbGVzIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcv
Y29yZS9tYWNoaW5lLmMgYi9ody9jb3JlL21hY2hpbmUuYw0KPiBpbmRleCBhMzVjNGE4ZmFlLi5h
ZmVmNTU2MjZkIDEwMDY0NA0KPiAtLS0gYS9ody9jb3JlL21hY2hpbmUuYw0KPiArKysgYi9ody9j
b3JlL21hY2hpbmUuYw0KPiBAQCAtMzgsNiArMzgsNyBAQA0KPg0KPiBHbG9iYWxQcm9wZXJ0eSBo
d19jb21wYXRfOV8xW10gPSB7DQo+ICAgICAgeyBUWVBFX1BDSV9ERVZJQ0UsICJ4LXBjaWUtZXh0
LXRhZyIsICJmYWxzZSIgfSwNCj4gKyAgICB7ICJwY2llLXJvb3QtcG9ydCIsICJ4LXNwZWVkIiwg
IjE2IiB9LA0KPiB9Ow0KPiBjb25zdCBzaXplX3QgaHdfY29tcGF0XzlfMV9sZW4gPSBHX05fRUxF
TUVOVFMoaHdfY29tcGF0XzlfMSk7DQo+DQo+IGRpZmYgLS1naXQgYS9ody9wY2ktYnJpZGdlL2dl
bl9wY2llX3Jvb3RfcG9ydC5jIGIvaHcvcGNpLWJyaWRnZS9nZW5fcGNpZV9yb290X3BvcnQuYw0K
PiBpbmRleCA3ODQ1MDdjODI2Li5jMjRjZTFmMmQxIDEwMDY0NA0KPiAtLS0gYS9ody9wY2ktYnJp
ZGdlL2dlbl9wY2llX3Jvb3RfcG9ydC5jDQo+ICsrKyBiL2h3L3BjaS1icmlkZ2UvZ2VuX3BjaWVf
cm9vdF9wb3J0LmMNCj4gQEAgLTE0Miw3ICsxNDIsNyBAQCBzdGF0aWMgUHJvcGVydHkgZ2VuX3Jw
X3Byb3BzW10gPSB7DQo+ICAgICAgREVGSU5FX1BST1BfU0laRSgicHJlZjY0LXJlc2VydmUiLCBH
ZW5QQ0lFUm9vdFBvcnQsDQo+ICAgICAgICAgICAgICAgICAgICAgICByZXNfcmVzZXJ2ZS5tZW1f
cHJlZl82NCwgLTEpLA0KPiAgICAgIERFRklORV9QUk9QX1BDSUVfTElOS19TUEVFRCgieC1zcGVl
ZCIsIFBDSUVTbG90LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcGVlZCwg
UENJRV9MSU5LX1NQRUVEXzE2KSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3BlZWQsIFBDSUVfTElOS19TUEVFRF8zMiksDQo+ICAgICAgREVGSU5FX1BST1BfUENJRV9MSU5L
X1dJRFRIKCJ4LXdpZHRoIiwgUENJRVNsb3QsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHdpZHRoLCBQQ0lFX0xJTktfV0lEVEhfMzIpLA0KPiAgICAgIERFRklORV9QUk9QX0VO
RF9PRl9MSVNUKCkNCj4gLS0NCj4gMi4zNC4xDQoNClBpbmcuDQoNCg==

