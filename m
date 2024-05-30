Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3ACDC25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 08:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCbAg-00006a-Ip; Thu, 30 May 2024 04:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sCbAd-00005i-KH
 for qemu-devel@nongnu.org; Thu, 30 May 2024 04:29:59 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sCbAa-0003HW-6i
 for qemu-devel@nongnu.org; Thu, 30 May 2024 04:29:59 -0400
To: "imammedo@redhat.com" <imammedo@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Failed to hot-plug device to pxb bridge
Thread-Topic: Failed to hot-plug device to pxb bridge
Thread-Index: AQHasmuEmcbCvhjMUEOOMo3lPlKtLw==
Date: Thu, 30 May 2024 08:29:41 +0000
Message-ID: <3A8D097B-3BA7-40DC-8DDF-D79B7BEE5CEE@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.86]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B55069CA2EDEF04080248D1CF0D10B1F@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.13
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgSWdvciwgRGFuaWVsIGFuZCBhbGw6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDIyMDQyMjEzNTEwMS42NTc5NjgyM0ByZWRoYXQuY29tL3QvI3I4MzFkNTg5ZjI0M2MyNDMzNGEw
OTk5NTYyMGI3NDQwODg0N2E4N2EwDQoNClRoaXMgbWVzc2FnZSBkaXNjdXNzIGhvdHBsdWcgZGV2
aWNlIHRvIHB4YiBicmlkZ2UuIEF0IHRoZSBlbmQsIElnb3Igc3VnZ2VzdGVkIGVuYWJsZSBzaHBj
IG9uIHB4YiBicmlkZ2U6DQogIHB4Yl9kZXZfcmVhbGl6ZV9jb21tb24oKToNCiAgICAgcWRldl9w
cm9wX3NldF9iaXQoYmRzLCBQQ0lfQlJJREdFX0RFVl9QUk9QX1NIUEMsIHRydWUpOw0KDQpIb3dl
cnZlciwgSSB0cmllZCBpdCBhbmQgdGhlIGd1ZXN0IGNhbid0IGZpbmQgdGhlIGRldmljZSBvbiBw
eGIgYnJpZGdlLiBBZGQgc29tZSBsb2csIFFFTVUgdXNlIGhvdHBsdWcgaGFuZGxlciBzaHBjX2Rl
dmljZV9wbHVnX2NiLg0KDQpRRU1VIGNvbW1hbmQgbGluZToNCi1kZXZpY2UgcHhiLGJ1c19ucj05
NixpZD1wY2kuMSxudW1hX25vZGU9MCxidXM9cGNpLjAsYWRkcj0weDMNCi1kZXZpY2UgcHhiLGJ1
c19ucj0xMjgsaWQ9cGNpLjIsbnVtYV9ub2RlPTEsYnVzPXBjaS4wLGFkZHI9MHg0DQotZGV2aWNl
IHBjaS1icmlkZ2UsY2hhc3Npc19ucj0zLGlkPXBjaS4zLGJ1cz1wY2kuMCxhZGRyPTB4NQ0KLWRl
dmljZSBwY2ktYnJpZGdlLGNoYXNzaXNfbnI9NCxpZD1wY2kuNCxidXM9cGNpLjAsYWRkcj0weDYg
DQotZGV2aWNlIHBjaS1icmlkZ2UsY2hhc3Npc19ucj01LGlkPXBjaS41LGJ1cz1wY2kuMSxhZGRy
PTB4MSANCi1kZXZpY2UgcGNpLWJyaWRnZSxjaGFzc2lzX25yPTYsaWQ9cGNpLjYsYnVzPXBjaS4y
LGFkZHI9MHgxDQoNCkhvdHBsdWcgY29tbWFuZDoNCnsiZXhlY3V0ZSI6Imh1bWFuLW1vbml0b3It
Y29tbWFuZCIsImFyZ3VtZW50cyI6eyJjb21tYW5kLWxpbmUiOiJkcml2ZV9hZGQgZHVtbXkgZmls
ZT0vaG9tZS90ZXN0L2RhdGExLmltZyxmb3JtYXQ9cWNvdzIsaWY9bm9uZSxpZD1kcml2ZS12aXJ0
aW8tZGlzazEsY2FjaGU9bm9uZSJ9fQ0KeyJleGVjdXRlIjoiZGV2aWNlX2FkZCIsImFyZ3VtZW50
cyI6eyJkcml2ZXIiOiJ2aXJ0aW8tYmxrLXBjaSIsInNjc2kiOiJvZmYiLCJidXMiOiJwY2kuNSIs
ImFkZHIiOiIweDEiLCJkcml2ZSI6ImRyaXZlLXZpcnRpby1kaXNrMSIsImlkIjoidmlydGlvLWRp
c2sxIn19DQoNClNvbWUgaW5mbyBpbiB0aGUgZ3Vlc3Q6DQpbcm9vdEBsb2NhbGhvc3Qgfl0jIGxz
cGNpIC10dg0KLSstWzAwMDA6ODBdLS0tMDAuMC1bODEtODJdLS0tLTAxLjAtWzgyXS0tDQogKy1b
MDAwMDo2MF0tLS0wMC4wLVs2MS02Ml0tLS0tMDEuMC1bNjJdLS0NCiBcLVswMDAwOjAwXS0rLTAw
LjAgIEludGVsIENvcnBvcmF0aW9uIDQ0MEZYIC0gODI0NDFGWCBQTUMgW05hdG9tYV0NCiAgICAg
ICAgICAgICArLTAxLjAgIEludGVsIENvcnBvcmF0aW9uIDgyMzcxU0IgUElJWDMgSVNBIFtOYXRv
bWEvVHJpdG9uIElJXQ0KICAgICAgICAgICAgICstMDEuMSAgSW50ZWwgQ29ycG9yYXRpb24gODIz
NzFTQiBQSUlYMyBJREUgW05hdG9tYS9Ucml0b24gSUldDQogICAgICAgICAgICAgKy0wMS4yICBJ
bnRlbCBDb3Jwb3JhdGlvbiA4MjM3MVNCIFBJSVgzIFVTQiBbTmF0b21hL1RyaXRvbiBJSV0NCiAg
ICAgICAgICAgICArLTAxLjMgIEludGVsIENvcnBvcmF0aW9uIDgyMzcxQUIvRUIvTUIgUElJWDQg
QUNQSQ0KICAgICAgICAgICAgICstMDIuMCAgQ2lycnVzIExvZ2ljIEdEIDU0NDYNCiAgICAgICAg
ICAgICArLTAzLjAgIFJlZCBIYXQsIEluYy4gUUVNVSBQQ0kgRXhwYW5kZXIgYnJpZGdlDQogICAg
ICAgICAgICAgKy0wNC4wICBSZWQgSGF0LCBJbmMuIFFFTVUgUENJIEV4cGFuZGVyIGJyaWRnZQ0K
ICAgICAgICAgICAgICstMDUuMC1bMDFdLS0NCiAgICAgICAgICAgICArLTA2LjAtWzAyXS0tDQog
ICAgICAgICAgICAgKy0wNy4wICBSZWQgSGF0LCBJbmMuIFZpcnRpbyBuZXR3b3JrIGRldmljZQ0K
ICAgICAgICAgICAgICstMDguMCAgUmVkIEhhdCwgSW5jLiBWaXJ0aW8gYmxvY2sgZGV2aWNlDQog
ICAgICAgICAgICAgXC0wOS4wICBSZWQgSGF0LCBJbmMuIFZpcnRpbyBtZW1vcnkgYmFsbG9vbg0K
W3Jvb3RAbG9jYWxob3N0IGJvb3RdIyBncmVwIC1pICdzaHBjJyBjb25maWctMy4xMC4wLTExNjAu
ODMuMS5lbDcueDg2XzY0DQpDT05GSUdfSE9UUExVR19QQ0lfU0hQQz15DQpbcm9vdEBsb2NhbGhv
c3QgYm9vdF0jIHVuYW1lIC1yDQozLjEwLjAtMTE2MC44My4xLmVsNy54ODZfNjQNCg0KVGhhbmtz
Lg0KDQoNCg==

