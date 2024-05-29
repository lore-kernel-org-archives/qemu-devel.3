Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C29EC27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 02:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC9II-00010I-4l; Tue, 28 May 2024 22:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sC9IF-0000yz-PQ; Tue, 28 May 2024 22:43:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sC9IC-0002DN-AN; Tue, 28 May 2024 22:43:59 -0400
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VptvN08nQz1HCtJ;
 Wed, 29 May 2024 10:42:08 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (unknown [7.185.36.147])
 by mail.maildlp.com (Postfix) with ESMTPS id 5B7FE1A016C;
 Wed, 29 May 2024 10:43:47 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpeml500008.china.huawei.com (7.185.36.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 29 May 2024 10:43:47 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Wed, 29 May 2024 10:43:47 +0800
To: Peter Xu <peterx@redhat.com>
CC: Yu Zhang <yu.zhang@ionos.com>, Michael Galaxy <mgalaxy@akamai.com>, "Jinpu
 Wang" <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
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
 Xiexiangyou <xiexiangyou@huawei.com>, Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Topic: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Index: AQHaib4eb+nVph6utEe7HatbjXSGr7FeBxGAgAD/kQCAAM0PAIAAcGaAgAC+EICAAZsBgIAAJisAgBwPpQCAAB5mAIABl4t9//+GhYCAAhAsgIAHeqWwgABddICAATP+EIAAcc0AgAKnDgCAAFgYAIAH7hYAgANI14CAAUekgIAG49qAgAqnmyD//+59gIABNomA
Date: Wed, 29 May 2024 02:43:46 +0000
Message-ID: <7bf81ccee4bd4b0e81e3893ef43502a8@huawei.com>
References: <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com> <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com> <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
 <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
 <Zk0c51D1Oo6NdIxR@x1n> <2308a8b894244123b638038e40a33990@huawei.com>
 <ZlX-Swq4Hi-0iHeh@x1n>
In-Reply-To: <ZlX-Swq4Hi-0iHeh@x1n>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.124.235]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=arei.gonglei@huawei.com; helo=szxga05-in.huawei.com
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgWHUgW21h
aWx0bzpwZXRlcnhAcmVkaGF0LmNvbV0NCj4gU2VudDogVHVlc2RheSwgTWF5IDI4LCAyMDI0IDEx
OjU1IFBNDQo+ID4gPiA+IEV4YWN0bHksIG5vdCBzbyBjb21wZWxsaW5nLCBhcyBJIGRpZCBpdCBm
aXJzdCBvbmx5IG9uIHNlcnZlcnMNCj4gPiA+ID4gd2lkZWx5IHVzZWQgZm9yIHByb2R1Y3Rpb24g
aW4gb3VyIGRhdGEgY2VudGVyLiBUaGUgbmV0d29yaw0KPiA+ID4gPiBhZGFwdGVycyBhcmUNCj4g
PiA+ID4NCj4gPiA+ID4gRXRoZXJuZXQgY29udHJvbGxlcjogQnJvYWRjb20gSW5jLiBhbmQgc3Vi
c2lkaWFyaWVzIE5ldFh0cmVtZQ0KPiA+ID4gPiBCQ001NzIwIDItcG9ydCBHaWdhYml0IEV0aGVy
bmV0IFBDSWUNCj4gPiA+DQo+ID4gPiBIbW0uLi4gSSBkZWZpbml0ZWx5IHRoaW5rcyBKaW5wdSdz
IE1lbGxhbm94IENvbm5lY3RYLTYgbG9va3MgbW9yZQ0KPiByZWFzb25hYmxlLg0KPiA+ID4NCj4g
PiA+DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FNR2ZmRW4tREtwTVo0
dEE3MU1KWWR5ZW1nMFpkYTE1DQo+ID4gPiB3VkFxazgxdlh0S3p4LUxmSlFAbWFpbC5nbWFpbC5j
b20vDQo+ID4gPg0KPiA+ID4gQXBwcmVjaWF0ZSBhIGxvdCBmb3IgZXZlcnlvbmUgaGVscGluZyBv
biB0aGUgdGVzdGluZ3MuDQo+ID4gPg0KPiA+ID4gPiBJbmZpbmlCYW5kIGNvbnRyb2xsZXI6IE1l
bGxhbm94IFRlY2hub2xvZ2llcyBNVDI3ODAwIEZhbWlseQ0KPiA+ID4gPiBbQ29ubmVjdFgtNV0N
Cj4gPiA+ID4NCj4gPiA+ID4gd2hpY2ggZG9lc24ndCBtZWV0IG91ciBwdXJwb3NlLiBJIGNhbiBj
aG9vc2UgUkRNQSBvciBUQ1AgZm9yIFZNDQo+ID4gPiA+IG1pZ3JhdGlvbi4gUkRNQSB0cmFmZmlj
IGlzIHRocm91Z2ggSW5maW5pQmFuZCBhbmQgVENQIHRocm91Z2gNCj4gPiA+ID4gRXRoZXJuZXQg
b24gdGhlc2UgdHdvIGhvc3RzLiBPbmUgaXMgc3RhbmRieSB3aGlsZSB0aGUgb3RoZXIgaXMgYWN0
aXZlLg0KPiA+ID4gPg0KPiA+ID4gPiBOb3cgSSdsbCB0cnkgb24gYSBzZXJ2ZXIgd2l0aCBtb3Jl
IHJlY2VudCBFdGhlcm5ldCBhbmQgSW5maW5pQmFuZA0KPiA+ID4gPiBuZXR3b3JrIGFkYXB0ZXJz
LiBPbmUgb2YgdGhlbSBoYXM6DQo+ID4gPiA+IEJDTTU3NDE0IE5ldFh0cmVtZS1FIDEwR2IvMjVH
YiBSRE1BIEV0aGVybmV0IENvbnRyb2xsZXIgKHJldiAwMSkNCj4gPiA+ID4NCj4gPiA+ID4gVGhl
IGNvbXBhcmlzb24gYmV0d2VlbiBSRE1BIGFuZCBUQ1Agb24gdGhlIHNhbWUgTklDIGNvdWxkIG1h
a2UNCj4gPiA+ID4gbW9yZQ0KPiA+ID4gc2Vuc2UuDQo+ID4gPg0KPiA+ID4gSXQgbG9va3MgdG8g
bWUgTklDcyBhcmUgcG93ZXJmdWwgbm93LCBidXQgYWdhaW4gYXMgSSBtZW50aW9uZWQgSQ0KPiA+
ID4gZG9uJ3QgdGhpbmsgaXQncyBhIHJlYXNvbiB3ZSBuZWVkIHRvIGRlcHJlY2F0ZSByZG1hLCBl
c3BlY2lhbGx5IGlmDQo+ID4gPiBRRU1VJ3MgcmRtYSBtaWdyYXRpb24gaGFzIHRoZSBjaGFuY2Ug
dG8gYmUgcmVmYWN0b3JlZCB1c2luZyByc29ja2V0Lg0KPiA+ID4NCj4gPiA+IElzIHRoZXJlIGFu
eW9uZSB3aG8gc3RhcnRlZCBsb29raW5nIGludG8gdGhhdCBkaXJlY3Rpb24/ICBXb3VsZCBpdA0K
PiA+ID4gbWFrZSBzZW5zZSB3ZSBzdGFydCBzb21lIFBvQyBub3c/DQo+ID4gPg0KPiA+DQo+ID4g
TXkgdGVhbSBoYXMgZmluaXNoZWQgdGhlIFBvQyByZWZhY3RvcmluZyB3aGljaCB3b3JrcyB3ZWxs
Lg0KPiA+DQo+ID4gUHJvZ3Jlc3M6DQo+ID4gMS4gIEltcGxlbWVudCBpby9jaGFubmVsLXJkbWEu
YywNCj4gPiAyLiAgQWRkIHVuaXQgdGVzdCB0ZXN0cy91bml0L3Rlc3QtaW8tY2hhbm5lbC1yZG1h
LmMgYW5kIHZlcmlmeWluZyBpdA0KPiA+IGlzIHN1Y2Nlc3NmdWwsIDMuICBSZW1vdmUgdGhlIG9y
aWdpbmFsIGNvZGUgZnJvbSBtaWdyYXRpb24vcmRtYS5jLCA0Lg0KPiA+IFJld3JpdGUgdGhlIHJk
bWFfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uIGFuZA0KPiA+IHJkbWFfc3RhcnRfaW5jb21pbmdf
bWlncmF0aW9uIGxvZ2ljLCA1LiAgUmVtb3ZlIGFsbCByZG1hX3h4eCBmdW5jdGlvbnMNCj4gPiBm
cm9tIG1pZ3JhdGlvbi9yYW0uYy4gKHRvIHByZXZlbnQgUkRNQSBsaXZlIG1pZ3JhdGlvbiBmcm9t
IHBvbGx1dGluZyB0aGUNCj4gY29yZSBsb2dpYyBvZiBsaXZlIG1pZ3JhdGlvbiksIDYuICBUaGUg
c29mdC1Sb0NFIGltcGxlbWVudGVkIGJ5IHNvZnR3YXJlIGlzDQo+IHVzZWQgdG8gdGVzdCB0aGUg
UkRNQSBsaXZlIG1pZ3JhdGlvbi4gSXQncyBzdWNjZXNzZnVsLg0KPiA+DQo+ID4gV2Ugd2lsbCBi
ZSBzdWJtaXQgdGhlIHBhdGNoc2V0IGxhdGVyLg0KPiANCj4gVGhhdCdzIGdyZWF0IG5ld3MsIHRo
YW5rIHlvdSENCj4gDQo+IC0tDQo+IFBldGVyIFh1DQoNCkZvciByZG1hIHByb2dyYW1taW5nLCB0
aGUgY3VycmVudCBtYWluc3RyZWFtIGltcGxlbWVudGF0aW9uIGlzIHRvIHVzZSByZG1hX2NtIHRv
IGVzdGFibGlzaCBhIGNvbm5lY3Rpb24sIGFuZCB0aGVuIHVzZSB2ZXJicyB0byB0cmFuc21pdCBk
YXRhLg0KDQpyZG1hX2NtIGFuZCBpYnZlcmJzIGNyZWF0ZSB0d28gRkRzIHJlc3BlY3RpdmVseS4g
VGhlIHR3byBGRHMgaGF2ZSBkaWZmZXJlbnQgcmVzcG9uc2liaWxpdGllcy4gcmRtYV9jbSBmZCBp
cyB1c2VkIHRvIG5vdGlmeSBjb25uZWN0aW9uIGVzdGFibGlzaG1lbnQgZXZlbnRzLCANCmFuZCB2
ZXJicyBmZCBpcyB1c2VkIHRvIG5vdGlmeSBuZXcgQ1FFcy4gV2hlbiBwb2xsL2Vwb2xsIG1vbml0
b3JpbmcgaXMgZGlyZWN0bHkgcGVyZm9ybWVkIG9uIHRoZSByZG1hX2NtIGZkLCBvbmx5IGEgcG9s
bGluIGV2ZW50IGNhbiBiZSBtb25pdG9yZWQsIHdoaWNoIG1lYW5zDQp0aGF0IGFuIHJkbWFfY20g
ZXZlbnQgb2NjdXJzLiBXaGVuIHRoZSB2ZXJicyBmZCBpcyBkaXJlY3RseSBwb2xsZWQvZXBvbGxl
ZCwgb25seSB0aGUgcG9sbGluIGV2ZW50IGNhbiBiZSBsaXN0ZW5lZCwgd2hpY2ggaW5kaWNhdGVz
IHRoYXQgYSBuZXcgQ1FFIGlzIGdlbmVyYXRlZC4NCg0KUnNvY2tldCBpcyBhIHN1Yi1tb2R1bGUg
YXR0YWNoZWQgdG8gdGhlIHJkbWFfY20gbGlicmFyeSBhbmQgcHJvdmlkZXMgcmRtYSBjYWxscyB0
aGF0IGFyZSBjb21wbGV0ZWx5IHNpbWlsYXIgdG8gc29ja2V0IGludGVyZmFjZXMuIEhvd2V2ZXIs
IHRoaXMgbGlicmFyeSByZXR1cm5zIA0Kb25seSB0aGUgcmRtYV9jbSBmZCBmb3IgbGlzdGVuaW5n
IHRvIGxpbmsgc2V0dXAtcmVsYXRlZCBldmVudHMgYW5kIGRvZXMgbm90IGV4cG9zZSB0aGUgdmVy
YnMgZmQgKHJlYWRhYmxlIGFuZCB3cml0YWJsZSBldmVudHMgZm9yIGxpc3RlbmluZyB0byBkYXRh
KS4gT25seSB0aGUgcnBvbGwgDQppbnRlcmZhY2UgcHJvdmlkZWQgYnkgdGhlIFJTb2NrZXQgY2Fu
IGJlIHVzZWQgdG8gbGlzdGVuIHRvIHJlbGF0ZWQgZXZlbnRzLiBIb3dldmVyLCBRRU1VIHVzZXMg
dGhlIHBwb2xsIGludGVyZmFjZSB0byBsaXN0ZW4gdG8gdGhlIHJkbWFfY20gZmQgKGdvdHRlbiBi
eSByYWNjZXB0IEFQSSkuIA0KQW5kIGNhbm5vdCBsaXN0ZW4gdG8gdGhlIHZlcmJzIGZkIGV2ZW50
LiBPbmx5IHNvbWUgaGFja2luZyBtZXRob2RzIGNhbiBiZSB1c2VkIHRvIGFkZHJlc3MgdGhpcyBw
cm9ibGVtLiANCg0KRG8geW91IGd1eXMgaGF2ZSBhbnkgaWRlYXM/IFRoYW5rcy4NCg0KDQpSZWdh
cmRzLA0KLUdvbmdsZWkNCg==

