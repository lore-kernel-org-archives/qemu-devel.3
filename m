Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54810CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v12gV-0004QV-Qb; Tue, 23 Sep 2025 09:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhaoxin04@baidu.com>)
 id 1v11VD-0008RF-8U
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:48:11 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhaoxin04@baidu.com>)
 id 1v11Uy-0001bp-Mn
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:48:10 -0400
To: Stefano Garzarella <sgarzare@redhat.com>, Cindy Lu <lulu@redhat.com>
CC: qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, "Gao, Shiyuan" <gaoshiyuan@baidu.com>, "Li, Zhaoxin(ACG CCN)"
 <lizhaoxin04@baidu.com>
Subject: Re: [PATCH] vhost: Do not actively send a config interrupt
Thread-Topic: [PATCH] vhost: Do not actively send a config interrupt
Thread-Index: AQHcLH2wF/bELexHwkqw5/pJbz2kZQ==
Date: Tue, 23 Sep 2025 11:32:06 +0000
Message-ID: <B01AB465-37DF-468F-9B76-2FC3D59E4749@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.127.72.28]
Content-Type: text/plain; charset="utf-8"
Content-ID: <54C0FFEE9BE8E548A87B6A2F33983B5D@baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.12
X-FE-Last-Public-Client-IP: ::1
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185;
 envelope-from=lizhaoxin04@baidu.com; helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 23 Sep 2025 09:03:53 -0400
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
Reply-to:  "Li,Zhaoxin(ACG CCN)" <lizhaoxin04@baidu.com>
From:  "Li,Zhaoxin(ACG CCN)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gMjAyNS85LzIzIDE3OjA277yM4oCcU3RlZmFubyBHYXJ6YXJlbGxh4oCdPHNnYXJ6YXJlQHJl
ZGhhdC5jb20gPG1haWx0bzpzZ2FyemFyZUByZWRoYXQuY29tPj4gd3JvdGU6DQoNCj5DQ2luZyBD
aW5keSBzaW5jZSBzaGUgaW50cm9kdWNlZCB0aGlzIGNvZGUgd2l0aCBjb21taXQNCj5mOWEwOWNh
M2VhICgidmhvc3Q6IGFkZCBzdXBwb3J0IGZvciBjb25maWd1cmUgaW50ZXJydXB0IiksIHNvIHNo
ZSBjYW4gDQo+aGVscCB0byByZXZpZXcgdGhpcywgc2luY2UgSSBkb24ndCByZWFsbHkgZ2V0IHRo
aXMgY2hhbmdlLg0KDQo+T24gTW9uLCBTZXAgMjIsIDIwMjUgYXQgMTE6MTk6MzJQTSArMDgwMCwg
TGkgWmhhb3hpbiB3cm90ZToNCj4+RnJvbTogbGl6aGFveGluIDxsaXpoYW94aW4wNEBiYWlkdS5j
b20gPG1haWx0bzpsaXpoYW94aW4wNEBiYWlkdS5jb20+Pg0KPj4NCj4+QWZ0ZXIgdGhlIFZNIGlz
IHN1c3BlbmRlZC9yZXN1bWVkIG9yIGxpdmUtbWlncmF0ZWQsDQo+PndlIGRvIG5vdCB3YW50IHRo
ZSBndWVzdCB0byBvdXRwdXQgaW5mb3JtYXRpb24gc3VjaCBhcw0KPj50aGUgY2FwYWNpdHkgb2Yg
dGhlIGJsb2NrIGRldmljZSwgYXMgdGhpcyBpcyBub3RpY2VhYmxlIHRvIHRoZSB0ZW5hbnQuDQo+
PkFsc28sIHRoZXJlIGlzIG5vIG5lZWQgdG8gaW1tZWRpYXRlbHkgc2VuZCBhIGNvbmZpZyBub3Rp
Zmllcg0KPj5mb3IgdGhlIHZpcnRpbyBkZXZpY2UgYWZ0ZXIgdmhvc3RfZGV2X3N0YXJ0Lg0KDQo+
Q2FuIHlvdSBleHBsYWluIG1vcmUgY2xlYXJseSB3aGF0IHlvdXIgcHJvYmxlbSBpcyBhbmQgd2h5
IHRoaXMgcGF0Y2ggDQo+c29sdmVzIGl0Pw0KDQo+VGhhbmtzLA0KPlN0ZWZhbm8NCg0KSGkgU3Rl
ZmFubyBhbmQgQ2luZHksDQoNCkluIHRoZSB2aG9zdC12ZHBhIHNjZW5hcmlvLCBhZnRlciBleGVj
dXRpbmcgdmlyc2ggc3VzcGVuZCB2bSBmb2xsb3dlZCBieSB2aXJzaCByZXN1bWUgdm0sIG9yIHdo
ZW4gbGl2ZSBtaWdyYXRpbmcgdGhlIFZNIHRvIHRoZSBkZXN0aW5hdGlvbiBob3N0LCB0aGUgZ3Vl
c3Qga2VybmVsIHdpbGwgb3V0cHV0IHRoZSBmb2xsb3dpbmcgYWRkaXRpb25hbCBsb2dzOg0KDQpb
VHVlIFNlcCAyMyAxOTowNzowNCAyMDI1XSB2aXJ0aW9fYmxrIHZpcnRpbzE6IFt2ZGFdIG5ldyBz
aXplOiAyMDk3MTUyMCA1MTItYnl0ZSBsb2dpY2FsIGJsb2NrcyAoMTAuNyBHQi8xMC4wIEdpQikN
CltUdWUgU2VwIDIzIDE5OjA3OjA0IDIwMjVdIHZpcnRpb19ibGsgdmlydGlvMzogW3ZkYl0gbmV3
IHNpemU6IDIwOTcxNTIwIDUxMi1ieXRlIGxvZ2ljYWwgYmxvY2tzICgxMC43IEdCLzEwLjAgR2lC
KQ0KDQpUaGlzIG9jY3VycyBiZWNhdXNlIHdoZW4gdGhlIHZob3N0IGRldmljZSBpcyBzdGFydGVk
LCB0aGUgc2VxdWVuY2Ugdmhvc3RfZGV2X3N0YXJ0IC0+IHZob3N0X3N0YXJ0X2NvbmZpZ19pbnRy
IC0+IGV2ZW50X25vdGlmaWVyX3NldCgmZGV2LT52ZGV2LT5jb25maWdfbm90aWZpZXIpIGlzIHRy
aWdnZXJlZCwgd2hpY2ggc2VuZHMgYSBjb25maWd1cmF0aW9uIGNoYW5nZSBub3RpZmljYXRpb24g
KGNvbmZpZyBub3RpZmljYXRpb24pIHRvIHRoZSBndWVzdC4gSG93ZXZlciwgaXQgYXBwZWFycyB0
aGF0IGFjdGl2ZWx5IHNlbmRpbmcgdGhpcyBub3RpZmljYXRpb24gaXMgY3VycmVudGx5IHVubmVj
ZXNzYXJ5LCBhbmQgbm8gYWRkaXRpb25hbCBwcm9jZXNzaW5nIGlzIHBlcmZvcm1lZCBpbiB0aGUg
ZXZlbnQgb2YgYSBzZW5kaW5nIGZhaWx1cmUuIFNvLCB3ZSByZW1vdmVkIHRoZSBjYWxsIHRvIGV2
ZW50X25vdGlmaWVyX3NldCgmZGV2LT52ZGV2LT5jb25maWdfbm90aWZpZXIpLg0KDQpUaGFua3Ms
DQpMaSBaaGFveGluDQoNCj4+DQo+PkNvLWRldmVsb3BlZC1ieTogR2FvIFNoaXl1YW4gPGdhb3No
aXl1YW5AYmFpZHUuY29tIDxtYWlsdG86Z2Fvc2hpeXVhbkBiYWlkdS5jb20+Pg0KPj5TaWduZWQt
b2ZmLWJ5OiBHYW8gU2hpeXVhbiA8Z2Fvc2hpeXVhbkBiYWlkdS5jb20gPG1haWx0bzpnYW9zaGl5
dWFuQGJhaWR1LmNvbT4+DQo+PlNpZ25lZC1vZmYtYnk6IExpIFpoYW94aW4gPGxpemhhb3hpbjA0
QGJhaWR1LmNvbSA8bWFpbHRvOmxpemhhb3hpbjA0QGJhaWR1LmNvbT4+DQo+Pi0tLQ0KPj4gaHcv
dmlydGlvL3Zob3N0LmMgfCA3ICstLS0tLS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qu
YyBiL2h3L3ZpcnRpby92aG9zdC5jDQo+PmluZGV4IDY1NTdjNThkMTIuLjFmOGE0OTVlZjggMTAw
NjQ0DQo+Pi0tLSBhL2h3L3ZpcnRpby92aG9zdC5jDQo+PisrKyBiL2h3L3ZpcnRpby92aG9zdC5j
DQo+PkBAIC0xODQ3LDE1ICsxODQ3LDEwIEBAIHN0YXRpYyB2b2lkIHZob3N0X3N0b3BfY29uZmln
X2ludHIoc3RydWN0IHZob3N0X2RldiAqZGV2KQ0KPj4NCj4+IHN0YXRpYyB2b2lkIHZob3N0X3N0
YXJ0X2NvbmZpZ19pbnRyKHN0cnVjdCB2aG9zdF9kZXYgKmRldikNCj4+IHsNCj4+LSBpbnQgcjsN
Cj4+LQ0KPj4gYXNzZXJ0KGRldi0+dmhvc3Rfb3BzKTsNCj4+IGludCBmZCA9IGV2ZW50X25vdGlm
aWVyX2dldF9mZCgmZGV2LT52ZGV2LT5jb25maWdfbm90aWZpZXIpOw0KPj4gaWYgKGRldi0+dmhv
c3Rfb3BzLT52aG9zdF9zZXRfY29uZmlnX2NhbGwpIHsNCj4+LSByID0gZGV2LT52aG9zdF9vcHMt
PnZob3N0X3NldF9jb25maWdfY2FsbChkZXYsIGZkKTsNCj4+LSBpZiAoIXIpIHsNCj4+LSBldmVu
dF9ub3RpZmllcl9zZXQoJmRldi0+dmRldi0+Y29uZmlnX25vdGlmaWVyKTsNCj4+LSB9DQo+Pisg
ZGV2LT52aG9zdF9vcHMtPnZob3N0X3NldF9jb25maWdfY2FsbChkZXYsIGZkKTsNCj4+IH0NCj4+
IH0NCj4+DQo+Pi0tIA0KPj4yLjM0LjENCj4+DQoNCg0KDQoNCg0K

