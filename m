Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DB4C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 01:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7NTg-0006zy-Pe; Thu, 17 Sep 2026 21:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=md1715FC36BB=lirongqing@baidu.com>)
 id 1x7NTa-0006zi-Rs
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 21:33:22 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=outbound.baidu.com)
 by eggs.gnu.org with smtp (Exim 4.90_1)
 (envelope-from <prvs=md1715FC36BB=lirongqing@baidu.com>)
 id 1x7NTU-0007NI-TW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 21:33:18 -0400
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.46
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIHBjaWVfc3Jpb3Y6IGZpeCB3cm9u?=
 =?gb2312?Q?g_write_width_and_off-by-one_in_pf=5Freset?=
Thread-Topic: [????] Re: [PATCH] pcie_sriov: fix wrong write width and
 off-by-one in pf_reset
Thread-Index: AQHdRmbDW/vAvH20xkyUoLoMFn6w4bbSfcsAgAEQdQA=
Date: Fri, 18 Sep 2026 01:33:00 +0000
Message-ID: <3394886bda904bd79a49ff6de6c17438@baidu.com>
References: <20260917053818.2565-1-lirongqing@baidu.com>
 <20260917131304-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260917131304-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.127.72.25]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1789695183;
 bh=ZRu54IkBneOM1lrKV3LI0ZZI8UU4svplW6EVUBkP4Xo=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=E/VSrC42lUwiDH66E+nPCnta4LYpJid/tflvTyNOPqlehrLh0dtoaQl5PmE78VIh/
 nEqvvuD4kRCGHcCpQxIjqilr53xd92lX8twVx81KmT7TeWzME2bgyiyRrPup2JIixu
 0Xcl+4/2h3ZeqWnpByQtW8hfpv/RQkUZBQmLEBM+2rZ3hgZRPuxkIAi9wBrOL+fmIV
 Gh72UFeSu2sxytU8AV9X+XVzOvLjoODR7BVUAO/G+2c5SsI6tcP9w24ASXVjvXXga+
 J2A1j+zhIEmyLDiGtmyLDyMqEdTC4nDNZoXGOGAFeszHMUJr6BYvAQx/yxsIy0vMYk
 E88/YabtATUMA==
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=prvs=md1715FC36BB=lirongqing@baidu.com; helo=outbound.baidu.com
X-Spam_score_int: 29
X-Spam_score: 2.9
X-Spam_bar: ++
X-Spam_report: (2.9 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

DQo+IE9uIFRodSwgU2VwIDE3LCAyMDI2IGF0IDAxOjM4OjE4UE0gKzA4MDAsIGxpcm9uZ3Fpbmcg
d3JvdGU6DQo+ID4gRnJvbTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+
DQo+ID4gcGNpZV9zcmlvdl9wZl9yZXNldCgpIHJlc3RvcmVzIHRoZSBWRiBCQVIgdHlwZSByZWdp
c3RlcnMgdXNpbmcNCj4gPiBwY2lfc2V0X3F1YWQoKSB3aXRoIGEgNC1ieXRlIHN0cmlkZS4gU2lu
Y2UgZWFjaCBWRiBCQVIgcmVnaXN0ZXIgaXMNCj4gPiA0IGJ5dGVzIHdpZGUsIHRoZSA4LWJ5dGUg
d3JpdGUgYWxzbyBjb3ZlcnMgdGhlIGZvbGxvd2luZyBCQVIgcmVnaXN0ZXIuDQo+ID4gQWx0aG91
Z2ggc3Vic2VxdWVudCBpdGVyYXRpb25zIG92ZXJ3cml0ZSBtb3N0IG9mIHRoZSB1bmludGVuZGVk
DQo+ID4gd3JpdGVzLCB0aGUgYWNjZXNzIGlzIGluY29ycmVjdCBhbmQgdGhlIGZpbmFsIGl0ZXJh
dGlvbiBjYW4gd3JpdGUNCj4gPiBiZXlvbmQgdGhlIFZGIEJBUiByZWdpc3RlcnMuDQo+ID4NCj4g
PiBTUi1JT1YgZGVmaW5lcyBzaXggVkYgQkFSIHJlZ2lzdGVycyBhbmQgZG9lcyBub3QgcHJvdmlk
ZSBhIFZGIFJPTSBCQVIuDQo+ID4gSG93ZXZlciwgc2V2ZXJhbCBTUi1JT1YgY29kZSBwYXRocyB1
c2UgUENJX05VTV9SRUdJT05TLCB3aGljaCBpbmNsdWRlcw0KPiA+IHRoZSBST00gc2xvdCBhbmQg
dGhlcmVmb3JlIGhhcyBhIHZhbHVlIG9mIHNldmVuLg0KPiA+DQo+ID4gSW4gcGFydGljdWxhciwg
dGhlIGZpbmFsIGl0ZXJhdGlvbiBpbiBwY2llX3NyaW92X3BmX3Jlc2V0KCkgY3VycmVudGx5DQo+
ID4gd3JpdGVzIGEgcXVhZHdvcmQgYXQgdGhlIG9mZnNldCBvZiB0aGUgc2V2ZW50aCByZWdpb24u
IFRoaXMgc3RhcnRzIGF0DQo+ID4gdGhlIGJ5dGUgaW1tZWRpYXRlbHkgZm9sbG93aW5nIHRoZSBz
aXggVkYgQkFSIHJlZ2lzdGVycyBhbmQgY2FuDQo+ID4gb3ZlcndyaXRlIHN1YnNlcXVlbnQgZmll
bGRzIGluIHRoZSBTUi1JT1YgY2FwYWJpbGl0eS4NCj4gPg0KPiA+IFVzZSBwY2lfc2V0X2xvbmco
KSB0byBtYXRjaCB0aGUgNC1ieXRlIFZGIEJBUiByZWdpc3RlciB3aWR0aCwgYW5kIHVzZQ0KPiA+
IFBDSV9TUklPVl9OVU1fQkFSUyB3aGVuIGl0ZXJhdGluZyBvdmVyIFNSLUlPViBWRiBCQVJzLiBU
aGlzIGFsc28gbWFrZXMNCj4gPiB0aGUgQkFSIGNvdW50IGNvbnNpc3RlbnQgd2l0aCB0aGUgYXNz
ZXJ0aW9uIGluDQo+ID4gcGNpZV9zcmlvdl9wZl9pbml0X3ZmX2JhcigpLg0KPiA+DQo+ID4gRml4
ZXM6IDdjMGZhOGRmZjgxMWI1ICgicGNpZTogQWRkIHN1cHBvcnQgZm9yIFNpbmdsZSBSb290IEkv
Tw0KPiA+IFZpcnR1YWxpemF0aW9uIChTUi9JT1YpIikNCj4gDQo+IGkgZG8gbm90IHNlZSB0aGUg
YnVnIGluIHRoYXQgdmVyc2lvbi4NCj4gZG8gdSBtZWFuIDE5ZTU1NDcxZDRlOCBtYXliZT8NCj4g
DQoNCllvdSBhcmUgcmlnaHQuIFRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhhdCEgVGhlIGlzc3VlIHdh
cyBpbmRlZWQgaW50cm9kdWNlZCBieSBjb21taXQgMTllNTU0NzFkNGU4LCBub3QgdGhlIGluaXRp
YWwgU1IvSU9WIHN1cHBvcnQgY29tbWl0Lg0KDQp0aGFua3MNCg0KW0xpLFJvbmdxaW5nXSANCg0K
DQo+ID4gRml4ZXM6IGM4YmM0ZGI0MDNlMTc2ICgicGNpZV9zcmlvdjogUmVzZXQgU1ItSU9WIGV4
dGVuZGVkIGNhcGFiaWxpdHkiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IExpIFJvbmdRaW5nIDxsaXJv
bmdxaW5nQGJhaWR1LmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvcGNpL3BjaWVfc3Jpb3YuYyB8IDEw
ICsrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9wY2kvcGNpZV9zcmlvdi5jIGIvaHcv
cGNpL3BjaWVfc3Jpb3YuYyBpbmRleA0KPiA+IGM0MWFjOTUuLjYxMjJhMjYgMTAwNjQ0DQo+ID4g
LS0tIGEvaHcvcGNpL3BjaWVfc3Jpb3YuYw0KPiA+ICsrKyBiL2h3L3BjaS9wY2llX3NyaW92LmMN
Cj4gPiBAQCAtMjI5LDcgKzIyOSw3IEBAIHZvaWQgcGNpZV9zcmlvdl9wZl9pbml0X3ZmX2JhcihQ
Q0lEZXZpY2UgKmRldiwgaW50DQo+ID4gcmVnaW9uX251bSwNCj4gPg0KPiA+ICAgICAgYXNzZXJ0
KHNyaW92X2NhcCA+IDApOw0KPiA+ICAgICAgYXNzZXJ0KHJlZ2lvbl9udW0gPj0gMCk7DQo+ID4g
LSAgICBhc3NlcnQocmVnaW9uX251bSA8IFBDSV9OVU1fUkVHSU9OUyk7DQo+ID4gKyAgICBhc3Nl
cnQocmVnaW9uX251bSA8IFBDSV9TUklPVl9OVU1fQkFSUyk7DQo+ID4gICAgICBhc3NlcnQocmVn
aW9uX251bSAhPSBQQ0lfUk9NX1NMT1QpOw0KPiA+DQo+ID4gICAgICB3bWFzayA9IH4oc2l6ZSAt
IDEpOw0KPiA+IEBAIC0zMDgsNyArMzA4LDcgQEAgaW50MTZfdA0KPiBwY2llX3NyaW92X3BmX2lu
aXRfZnJvbV91c2VyX2NyZWF0ZWRfdmZzKFBDSURldmljZSAqZGV2LA0KPiA+ICAgICAgICAgICAg
ICByZXR1cm4gLTE7DQo+ID4gICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICAgZm9yIChzaXpl
X3QgaiA9IDA7IGogPCBQQ0lfTlVNX1JFR0lPTlM7IGorKykgew0KPiA+ICsgICAgICAgIGZvciAo
c2l6ZV90IGogPSAwOyBqIDwgUENJX1NSSU9WX05VTV9CQVJTOyBqKyspIHsNCj4gPiAgICAgICAg
ICAgICAgaWYgKHZmc1tpXS0+aW9fcmVnaW9uc1tqXS5zaXplICE9IHZmc1swXS0+aW9fcmVnaW9u
c1tqXS5zaXplIHx8DQo+ID4gICAgICAgICAgICAgICAgICB2ZnNbaV0tPmlvX3JlZ2lvbnNbal0u
dHlwZSAhPSB2ZnNbMF0tPmlvX3JlZ2lvbnNbal0udHlwZSkgew0KPiA+ICAgICAgICAgICAgICAg
ICAgZXJyb3Jfc2V0ZyhlcnJwLCAiaW5jb25zaXN0ZW50IFNSLUlPViBCQVJzIik7IEBADQo+ID4g
LTM0NCw3ICszNDQsNyBAQCBpbnQxNl90DQo+IHBjaWVfc3Jpb3ZfcGZfaW5pdF9mcm9tX3VzZXJf
Y3JlYXRlZF92ZnMoUENJRGV2aWNlICpkZXYsDQo+ID4gICAgICBkZXYtPmV4cC5zcmlvdl9wZi52
ZiA9IHZmczsNCj4gPiAgICAgIGRldi0+ZXhwLnNyaW92X3BmLnZmX3VzZXJfY3JlYXRlZCA9IHRy
dWU7DQo+ID4NCj4gPiAtICAgIGZvciAoaSA9IDA7IGkgPCBQQ0lfTlVNX1JFR0lPTlM7IGkrKykg
ew0KPiA+ICsgICAgZm9yIChpID0gMDsgaSA8IFBDSV9TUklPVl9OVU1fQkFSUzsgaSsrKSB7DQo+
ID4gICAgICAgICAgUENJSU9SZWdpb24gKnJlZ2lvbiA9ICZ2ZnNbMF0tPmlvX3JlZ2lvbnNbaV07
DQo+ID4NCj4gPiAgICAgICAgICBpZiAocmVnaW9uLT5zaXplKSB7DQo+ID4gQEAgLTQ2Myw4ICs0
NjMsOCBAQCB2b2lkIHBjaWVfc3Jpb3ZfcGZfcmVzZXQoUENJRGV2aWNlICpkZXYpDQo+ID4gICAg
ICAgKi8NCj4gPiAgICAgIHBjaV9zZXRfd29yZChkZXYtPmNvbmZpZyArIHNyaW92X2NhcCArIFBD
SV9TUklPVl9TWVNfUEdTSVpFLA0KPiA+IDB4MSk7DQo+ID4NCj4gPiAtICAgIGZvciAodWludDE2
X3QgaSA9IDA7IGkgPCBQQ0lfTlVNX1JFR0lPTlM7IGkrKykgew0KPiA+IC0gICAgICAgIHBjaV9z
ZXRfcXVhZChkZXYtPmNvbmZpZyArIHNyaW92X2NhcCArIFBDSV9TUklPVl9CQVIgKyBpICogNCwN
Cj4gPiArICAgIGZvciAodWludDE2X3QgaSA9IDA7IGkgPCBQQ0lfU1JJT1ZfTlVNX0JBUlM7IGkr
Kykgew0KPiA+ICsgICAgICAgIHBjaV9zZXRfbG9uZyhkZXYtPmNvbmZpZyArIHNyaW92X2NhcCAr
IFBDSV9TUklPVl9CQVIgKyBpICogNCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgZGV2LT5l
eHAuc3Jpb3ZfcGYudmZfYmFyX3R5cGVbaV0pOw0KPiA+ICAgICAgfQ0KPiA+ICB9DQo+ID4gLS0N
Cj4gPiAyLjkuNA0KDQo=

