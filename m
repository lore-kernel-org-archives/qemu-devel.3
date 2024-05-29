Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C79C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 08:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCEhO-0001Us-MZ; Wed, 29 May 2024 04:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sCEhM-0001Ti-HD; Wed, 29 May 2024 04:30:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sCEhJ-0006db-NF; Wed, 29 May 2024 04:30:16 -0400
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Vq2YH0qX8z1ysWw;
 Wed, 29 May 2024 16:26:59 +0800 (CST)
Received: from dggpeml100005.china.huawei.com (unknown [7.185.36.185])
 by mail.maildlp.com (Postfix) with ESMTPS id 501D11A016C;
 Wed, 29 May 2024 16:30:08 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpeml100005.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 29 May 2024 16:30:08 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Wed, 29 May 2024 16:30:01 +0800
To: Greg Sword <gregsword0@gmail.com>, Jinpu Wang <jinpu.wang@ionos.com>
CC: Peter Xu <peterx@redhat.com>, Yu Zhang <yu.zhang@ionos.com>, "Michael
 Galaxy" <mgalaxy@akamai.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Zhijian Li
 (Fujitsu)" <lizhijian@fujitsu.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf
 <kwolf@redhat.com>, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>, Hanna Reitz
 <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Song Gao
 <gaosong@loongson.cn>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pannengyuan <pannengyuan@huawei.com>,
 Xiexiangyou <xiexiangyou@huawei.com>, Fabiano Rosas <farosas@suse.de>, "RDMA
 mailing list" <linux-rdma@vger.kernel.org>, "shefty@nvidia.com"
 <shefty@nvidia.com>
Subject: RE: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Topic: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Index: AQHaib4eb+nVph6utEe7HatbjXSGr7FeBxGAgAD/kQCAAM0PAIAAcGaAgAC+EICAAZsBgIAAJisAgBwPpQCAAB5mAIABl4t9//+GhYCAAhAsgIAHeqWwgABddICAATP+EIAAcc0AgAKnDgCAAFgYAIAH7hYAgANI14CAAUekgIAG49qAgAqnmyD//+59gIABNomA//+dcAAAAzlpgAAVpXFA
Date: Wed, 29 May 2024 08:30:01 +0000
Message-ID: <e0fa7fc42118407f8731c34f8c192fda@huawei.com>
References: <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com> <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com> <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
 <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
 <Zk0c51D1Oo6NdIxR@x1n> <2308a8b894244123b638038e40a33990@huawei.com>
 <ZlX-Swq4Hi-0iHeh@x1n> <7bf81ccee4bd4b0e81e3893ef43502a8@huawei.com>
 <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com>
 <CAEz=LcuNM-j=1txyiL4_A89vZLxTicOFHXLC0=piamvqF4gu0g@mail.gmail.com>
In-Reply-To: <CAEz=LcuNM-j=1txyiL4_A89vZLxTicOFHXLC0=piamvqF4gu0g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.124.235]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=arei.gonglei@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  "Gonglei (Arei)" <arei.gonglei@huawei.com>
From:  "Gonglei (Arei)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBTd29yZCBbbWFp
bHRvOmdyZWdzd29yZDBAZ21haWwuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAyOSwgMjAy
NCAyOjA2IFBNDQo+IFRvOiBKaW5wdSBXYW5nIDxqaW5wdS53YW5nQGlvbm9zLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSC1mb3ItOS4xIHYyIDIvM10gbWlncmF0aW9uOiBSZW1vdmUgUkRNQSBw
cm90b2NvbCBoYW5kbGluZw0KPiANCj4gT24gV2VkLCBNYXkgMjksIDIwMjQgYXQgMTI6MzPigK9Q
TSBKaW5wdSBXYW5nIDxqaW5wdS53YW5nQGlvbm9zLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBP
biBXZWQsIE1heSAyOSwgMjAyNCBhdCA0OjQz4oCvQU0gR29uZ2xlaSAoQXJlaSkgPGFyZWkuZ29u
Z2xlaUBodWF3ZWkuY29tPg0KPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBIaSwNCj4gPiA+DQo+ID4g
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IFBldGVyIFh1IFtt
YWlsdG86cGV0ZXJ4QHJlZGhhdC5jb21dDQo+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIE1heSAyOCwg
MjAyNCAxMTo1NSBQTQ0KPiA+ID4gPiA+ID4gPiBFeGFjdGx5LCBub3Qgc28gY29tcGVsbGluZywg
YXMgSSBkaWQgaXQgZmlyc3Qgb25seSBvbg0KPiA+ID4gPiA+ID4gPiBzZXJ2ZXJzIHdpZGVseSB1
c2VkIGZvciBwcm9kdWN0aW9uIGluIG91ciBkYXRhIGNlbnRlci4gVGhlDQo+ID4gPiA+ID4gPiA+
IG5ldHdvcmsgYWRhcHRlcnMgYXJlDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEV0aGVy
bmV0IGNvbnRyb2xsZXI6IEJyb2FkY29tIEluYy4gYW5kIHN1YnNpZGlhcmllcw0KPiA+ID4gPiA+
ID4gPiBOZXRYdHJlbWUNCj4gPiA+ID4gPiA+ID4gQkNNNTcyMCAyLXBvcnQgR2lnYWJpdCBFdGhl
cm5ldCBQQ0llDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSG1tLi4uIEkgZGVmaW5pdGVseSB0
aGlua3MgSmlucHUncyBNZWxsYW5veCBDb25uZWN0WC02IGxvb2tzDQo+ID4gPiA+ID4gPiBtb3Jl
DQo+ID4gPiA+IHJlYXNvbmFibGUuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4N
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9DQU1HZmZFbi1ES3BNWjR0QTcx
TUpZZHllbWcwWmRhDQo+ID4gPiA+IDE1DQo+ID4gPiA+ID4gPiB3VkFxazgxdlh0S3p4LUxmSlFA
bWFpbC5nbWFpbC5jb20vDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQXBwcmVjaWF0ZSBhIGxv
dCBmb3IgZXZlcnlvbmUgaGVscGluZyBvbiB0aGUgdGVzdGluZ3MuDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiBJbmZpbmlCYW5kIGNvbnRyb2xsZXI6IE1lbGxhbm94IFRlY2hub2xvZ2llcyBN
VDI3ODAwIEZhbWlseQ0KPiA+ID4gPiA+ID4gPiBbQ29ubmVjdFgtNV0NCj4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gd2hpY2ggZG9lc24ndCBtZWV0IG91ciBwdXJwb3NlLiBJIGNhbiBjaG9v
c2UgUkRNQSBvciBUQ1AgZm9yDQo+ID4gPiA+ID4gPiA+IFZNIG1pZ3JhdGlvbi4gUkRNQSB0cmFm
ZmljIGlzIHRocm91Z2ggSW5maW5pQmFuZCBhbmQgVENQDQo+ID4gPiA+ID4gPiA+IHRocm91Z2gg
RXRoZXJuZXQgb24gdGhlc2UgdHdvIGhvc3RzLiBPbmUgaXMgc3RhbmRieSB3aGlsZSB0aGUgb3Ro
ZXINCj4gaXMgYWN0aXZlLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBOb3cgSSdsbCB0
cnkgb24gYSBzZXJ2ZXIgd2l0aCBtb3JlIHJlY2VudCBFdGhlcm5ldCBhbmQNCj4gPiA+ID4gPiA+
ID4gSW5maW5pQmFuZCBuZXR3b3JrIGFkYXB0ZXJzLiBPbmUgb2YgdGhlbSBoYXM6DQo+ID4gPiA+
ID4gPiA+IEJDTTU3NDE0IE5ldFh0cmVtZS1FIDEwR2IvMjVHYiBSRE1BIEV0aGVybmV0IENvbnRy
b2xsZXIgKHJldg0KPiA+ID4gPiA+ID4gPiAwMSkNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
ID4gVGhlIGNvbXBhcmlzb24gYmV0d2VlbiBSRE1BIGFuZCBUQ1Agb24gdGhlIHNhbWUgTklDIGNv
dWxkDQo+ID4gPiA+ID4gPiA+IG1ha2UgbW9yZQ0KPiA+ID4gPiA+ID4gc2Vuc2UuDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gSXQgbG9va3MgdG8gbWUgTklDcyBhcmUgcG93ZXJmdWwgbm93LCBi
dXQgYWdhaW4gYXMgSSBtZW50aW9uZWQNCj4gPiA+ID4gPiA+IEkgZG9uJ3QgdGhpbmsgaXQncyBh
IHJlYXNvbiB3ZSBuZWVkIHRvIGRlcHJlY2F0ZSByZG1hLA0KPiA+ID4gPiA+ID4gZXNwZWNpYWxs
eSBpZiBRRU1VJ3MgcmRtYSBtaWdyYXRpb24gaGFzIHRoZSBjaGFuY2UgdG8gYmUgcmVmYWN0b3Jl
ZA0KPiB1c2luZyByc29ja2V0Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IElzIHRoZXJlIGFu
eW9uZSB3aG8gc3RhcnRlZCBsb29raW5nIGludG8gdGhhdCBkaXJlY3Rpb24/DQo+ID4gPiA+ID4g
PiBXb3VsZCBpdCBtYWtlIHNlbnNlIHdlIHN0YXJ0IHNvbWUgUG9DIG5vdz8NCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBNeSB0ZWFtIGhhcyBmaW5pc2hlZCB0aGUgUG9DIHJlZmFj
dG9yaW5nIHdoaWNoIHdvcmtzIHdlbGwuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBQcm9ncmVzczoN
Cj4gPiA+ID4gPiAxLiAgSW1wbGVtZW50IGlvL2NoYW5uZWwtcmRtYS5jLCAyLiAgQWRkIHVuaXQg
dGVzdA0KPiA+ID4gPiA+IHRlc3RzL3VuaXQvdGVzdC1pby1jaGFubmVsLXJkbWEuYyBhbmQgdmVy
aWZ5aW5nIGl0IGlzDQo+ID4gPiA+ID4gc3VjY2Vzc2Z1bCwgMy4gIFJlbW92ZSB0aGUgb3JpZ2lu
YWwgY29kZSBmcm9tIG1pZ3JhdGlvbi9yZG1hLmMsIDQuDQo+ID4gPiA+ID4gUmV3cml0ZSB0aGUg
cmRtYV9zdGFydF9vdXRnb2luZ19taWdyYXRpb24gYW5kDQo+ID4gPiA+ID4gcmRtYV9zdGFydF9p
bmNvbWluZ19taWdyYXRpb24gbG9naWMsIDUuICBSZW1vdmUgYWxsIHJkbWFfeHh4DQo+ID4gPiA+
ID4gZnVuY3Rpb25zIGZyb20gbWlncmF0aW9uL3JhbS5jLiAodG8gcHJldmVudCBSRE1BIGxpdmUg
bWlncmF0aW9uDQo+ID4gPiA+ID4gZnJvbSBwb2xsdXRpbmcgdGhlDQo+ID4gPiA+IGNvcmUgbG9n
aWMgb2YgbGl2ZSBtaWdyYXRpb24pLCA2LiAgVGhlIHNvZnQtUm9DRSBpbXBsZW1lbnRlZCBieQ0K
PiA+ID4gPiBzb2Z0d2FyZSBpcyB1c2VkIHRvIHRlc3QgdGhlIFJETUEgbGl2ZSBtaWdyYXRpb24u
IEl0J3Mgc3VjY2Vzc2Z1bC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdlIHdpbGwgYmUgc3VibWl0
IHRoZSBwYXRjaHNldCBsYXRlci4NCj4gPiA+ID4NCj4gPiA+ID4gVGhhdCdzIGdyZWF0IG5ld3Ms
IHRoYW5rIHlvdSENCj4gPiA+ID4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gUGV0ZXIgWHUNCj4gPiA+
DQo+ID4gPiBGb3IgcmRtYSBwcm9ncmFtbWluZywgdGhlIGN1cnJlbnQgbWFpbnN0cmVhbSBpbXBs
ZW1lbnRhdGlvbiBpcyB0byB1c2UNCj4gcmRtYV9jbSB0byBlc3RhYmxpc2ggYSBjb25uZWN0aW9u
LCBhbmQgdGhlbiB1c2UgdmVyYnMgdG8gdHJhbnNtaXQgZGF0YS4NCj4gPiA+DQo+ID4gPiByZG1h
X2NtIGFuZCBpYnZlcmJzIGNyZWF0ZSB0d28gRkRzIHJlc3BlY3RpdmVseS4gVGhlIHR3byBGRHMg
aGF2ZQ0KPiA+ID4gZGlmZmVyZW50IHJlc3BvbnNpYmlsaXRpZXMuIHJkbWFfY20gZmQgaXMgdXNl
ZCB0byBub3RpZnkgY29ubmVjdGlvbg0KPiA+ID4gZXN0YWJsaXNobWVudCBldmVudHMsIGFuZCB2
ZXJicyBmZCBpcyB1c2VkIHRvIG5vdGlmeSBuZXcgQ1FFcy4gV2hlbg0KPiBwb2xsL2Vwb2xsIG1v
bml0b3JpbmcgaXMgZGlyZWN0bHkgcGVyZm9ybWVkIG9uIHRoZSByZG1hX2NtIGZkLCBvbmx5IGEg
cG9sbGluDQo+IGV2ZW50IGNhbiBiZSBtb25pdG9yZWQsIHdoaWNoIG1lYW5zIHRoYXQgYW4gcmRt
YV9jbSBldmVudCBvY2N1cnMuIFdoZW4NCj4gdGhlIHZlcmJzIGZkIGlzIGRpcmVjdGx5IHBvbGxl
ZC9lcG9sbGVkLCBvbmx5IHRoZSBwb2xsaW4gZXZlbnQgY2FuIGJlIGxpc3RlbmVkLA0KPiB3aGlj
aCBpbmRpY2F0ZXMgdGhhdCBhIG5ldyBDUUUgaXMgZ2VuZXJhdGVkLg0KPiA+ID4NCj4gPiA+IFJz
b2NrZXQgaXMgYSBzdWItbW9kdWxlIGF0dGFjaGVkIHRvIHRoZSByZG1hX2NtIGxpYnJhcnkgYW5k
IHByb3ZpZGVzDQo+ID4gPiByZG1hIGNhbGxzIHRoYXQgYXJlIGNvbXBsZXRlbHkgc2ltaWxhciB0
byBzb2NrZXQgaW50ZXJmYWNlcy4NCj4gPiA+IEhvd2V2ZXIsIHRoaXMgbGlicmFyeSByZXR1cm5z
IG9ubHkgdGhlIHJkbWFfY20gZmQgZm9yIGxpc3RlbmluZyB0byBsaW5rDQo+IHNldHVwLXJlbGF0
ZWQgZXZlbnRzIGFuZCBkb2VzIG5vdCBleHBvc2UgdGhlIHZlcmJzIGZkIChyZWFkYWJsZSBhbmQg
d3JpdGFibGUNCj4gZXZlbnRzIGZvciBsaXN0ZW5pbmcgdG8gZGF0YSkuIE9ubHkgdGhlIHJwb2xs
IGludGVyZmFjZSBwcm92aWRlZCBieSB0aGUgUlNvY2tldA0KPiBjYW4gYmUgdXNlZCB0byBsaXN0
ZW4gdG8gcmVsYXRlZCBldmVudHMuIEhvd2V2ZXIsIFFFTVUgdXNlcyB0aGUgcHBvbGwNCj4gaW50
ZXJmYWNlIHRvIGxpc3RlbiB0byB0aGUgcmRtYV9jbSBmZCAoZ290dGVuIGJ5IHJhY2NlcHQgQVBJ
KS4NCj4gPiA+IEFuZCBjYW5ub3QgbGlzdGVuIHRvIHRoZSB2ZXJicyBmZCBldmVudC4gT25seSBz
b21lIGhhY2tpbmcgbWV0aG9kcyBjYW4gYmUNCj4gdXNlZCB0byBhZGRyZXNzIHRoaXMgcHJvYmxl
bS4NCj4gPiA+DQo+ID4gPiBEbyB5b3UgZ3V5cyBoYXZlIGFueSBpZGVhcz8gVGhhbmtzLg0KPiA+
ICtjYyBsaW51eC1yZG1hDQo+IA0KPiBXaHkgaW5jbHVkZSByZG1hIGNvbW11bml0eT8NCj4gDQoN
CkNhbiByZG1hL3Jzb2NrZXQgcHJvdmlkZSBhbiBBUEkgdG8gZXhwb3NlIHRoZSB2ZXJicyBmZD8g
DQoNCg0KUmVnYXJkcywNCi1Hb25nbGVpDQoNCj4gPiArY2MgU2Vhbg0KPiA+DQo+ID4NCj4gPg0K
PiA+ID4NCj4gPiA+DQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gLUdvbmdsZWkNCj4gPg0K

