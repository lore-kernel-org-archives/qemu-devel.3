Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F97C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 13:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3yHb-0000kc-Vb; Mon, 06 May 2024 09:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1s3nke-0003k4-QJ; Sun, 05 May 2024 22:06:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1s3nkb-0001l9-7j; Sun, 05 May 2024 22:06:48 -0400
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VXl9V5cclzcdcy;
 Mon,  6 May 2024 10:05:18 +0800 (CST)
Received: from dggpemm100004.china.huawei.com (unknown [7.185.36.189])
 by mail.maildlp.com (Postfix) with ESMTPS id C4213140158;
 Mon,  6 May 2024 10:06:28 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:06:28 +0800
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:06:28 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Mon, 6 May 2024 10:06:28 +0800
To: Peter Xu <peterx@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>, Michael Galaxy
 <mgalaxy@akamai.com>, Yu Zhang <yu.zhang@ionos.com>, "Zhijian Li (Fujitsu)"
 <lizhijian@fujitsu.com>, Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes
 <elmar.gerdes@ionos.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>, "Prasanna Kumar
 Kalever" <prasanna4324@gmail.com>, "integration@gluster.org"
 <integration@gluster.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "devel@lists.libvirt.org"
 <devel@lists.libvirt.org>, Hanna Reitz <hreitz@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake
 <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Wainer dos Santos
 Moschetta" <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Pannengyuan <pannengyuan@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>
Subject: RE: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Topic: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Index: AQHaib4eb+nVph6utEe7HatbjXSGr7FeBxGAgAD/kQCAAM0PAIAAcGaAgAC+EICAAZsBgIAAJisAgBwPpQCAAB5mAIABl4t9//+GhYCAAhAsgIAHeqWw
Date: Mon, 6 May 2024 02:06:28 +0000
Message-ID: <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
References: <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n> <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com> <Zi-1OvxA5MIHjklU@x1n>
 <877cgfe2yw.fsf@pond.sub.org> <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n>
In-Reply-To: <ZjJgQcPQ29HJsTpY@x1n>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.124.235]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=arei.gonglei@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 May 2024 09:21:26 -0400
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

SGksIFBldGVyDQoNClJETUEgZmVhdHVyZXMgaGlnaCBiYW5kd2lkdGgsIGxvdyBsYXRlbmN5IChp
biBub24tYmxvY2tpbmcgbG9zc2xlc3MgbmV0d29yayksIGFuZCBkaXJlY3QgcmVtb3RlIA0KbWVt
b3J5IGFjY2VzcyBieSBieXBhc3NpbmcgdGhlIENQVSAoQXMgeW91IGtub3csIENQVSByZXNvdXJj
ZXMgYXJlIGV4cGVuc2l2ZSBmb3IgY2xvdWQgdmVuZG9ycywgDQp3aGljaCBpcyBvbmUgb2YgdGhl
IHJlYXNvbnMgd2h5IHdlIGludHJvZHVjZWQgb2ZmbG9hZCBjYXJkcy4pLCB3aGljaCBUQ1AgZG9l
cyBub3QgaGF2ZS4gDQoNCkluIHNvbWUgc2NlbmFyaW9zIHdoZXJlIGZhc3QgbGl2ZSBtaWdyYXRp
b24gaXMgbmVlZGVkIChleHRyZW1lbHkgc2hvcnQgaW50ZXJydXB0aW9uIGR1cmF0aW9uIGFuZCBt
aWdyYXRpb24gDQpkdXJhdGlvbikgaXMgdmVyeSB1c2VmdWwuIFRvIHRoaXMgZW5kLCB3ZSBoYXZl
IGFsc28gZGV2ZWxvcGVkIFJETUEgc3VwcG9ydCBmb3IgbXVsdGlmZC4NCg0KUmVnYXJkcywNCi1H
b25nbGVpDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgWHUg
W21haWx0bzpwZXRlcnhAcmVkaGF0LmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMSwgMjAy
NCAxMTozMSBQTQ0KPiBUbzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNv
bT4NCj4gQ2M6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT47IE1pY2hhZWwg
R2FsYXh5DQo+IDxtZ2FsYXh5QGFrYW1haS5jb20+OyBZdSBaaGFuZyA8eXUuemhhbmdAaW9ub3Mu
Y29tPjsgWmhpamlhbiBMaSAoRnVqaXRzdSkNCj4gPGxpemhpamlhbkBmdWppdHN1LmNvbT47IEpp
bnB1IFdhbmcgPGppbnB1LndhbmdAaW9ub3MuY29tPjsgRWxtYXIgR2VyZGVzDQo+IDxlbG1hci5n
ZXJkZXNAaW9ub3MuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBZdXZhbCBTaGFpYQ0KPiA8
eXV2YWwuc2hhaWEubWxAZ21haWwuY29tPjsgS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT47
IFByYXNhbm5hDQo+IEt1bWFyIEthbGV2ZXIgPHByYXNhbm5hLmthbGV2ZXJAcmVkaGF0LmNvbT47
IENvcm5lbGlhIEh1Y2sNCj4gPGNvaHVja0ByZWRoYXQuY29tPjsgTWljaGFlbCBSb3RoIDxtaWNo
YWVsLnJvdGhAYW1kLmNvbT47IFByYXNhbm5hDQo+IEt1bWFyIEthbGV2ZXIgPHByYXNhbm5hNDMy
NEBnbWFpbC5jb20+OyBpbnRlZ3JhdGlvbkBnbHVzdGVyLm9yZzsgUGFvbG8NCj4gQm9uemluaSA8
cGJvbnppbmlAcmVkaGF0LmNvbT47IHFlbXUtYmxvY2tAbm9uZ251Lm9yZzsNCj4gZGV2ZWxAbGlz
dHMubGlidmlydC5vcmc7IEhhbm5hIFJlaXR6IDxocmVpdHpAcmVkaGF0LmNvbT47IE1pY2hhZWwg
Uy4gVHNpcmtpbg0KPiA8bXN0QHJlZGhhdC5jb20+OyBUaG9tYXMgSHV0aCA8dGh1dGhAcmVkaGF0
LmNvbT47IEVyaWMgQmxha2UNCj4gPGVibGFrZUByZWRoYXQuY29tPjsgU29uZyBHYW8gPGdhb3Nv
bmdAbG9vbmdzb24uY24+OyBNYXJjLUFuZHLDqQ0KPiBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVA
cmVkaGF0LmNvbT47IEFsZXggQmVubsOpZQ0KPiA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz47IFdh
aW5lciBkb3MgU2FudG9zIE1vc2NoZXR0YQ0KPiA8d2FpbmVyc21AcmVkaGF0LmNvbT47IEJlcmFs
ZG8gTGVhbCA8YmxlYWxAcmVkaGF0LmNvbT47IEdvbmdsZWkgKEFyZWkpDQo+IDxhcmVpLmdvbmds
ZWlAaHVhd2VpLmNvbT47IFBhbm5lbmd5dWFuIDxwYW5uZW5neXVhbkBodWF3ZWkuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENILWZvci05LjEgdjIgMi8zXSBtaWdyYXRpb246IFJlbW92ZSBSRE1B
IHByb3RvY29sIGhhbmRsaW5nDQo+IA0KPiBPbiBUdWUsIEFwciAzMCwgMjAyNCBhdCAwOTowMDo0
OUFNICswMTAwLCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPiA+IE9uIFR1ZSwgQXByIDMw
LCAyMDI0IGF0IDA5OjE1OjAzQU0gKzAyMDAsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiA+
ID4gUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPiB3cml0ZXM6DQo+ID4gPg0KPiA+ID4gPiBP
biBNb24sIEFwciAyOSwgMjAyNCBhdCAwODowODoxMEFNIC0wNTAwLCBNaWNoYWVsIEdhbGF4eSB3
cm90ZToNCj4gPiA+ID4+IEhpIEFsbCAoYW5kIFBldGVyKSwNCj4gPiA+ID4NCj4gPiA+ID4gSGks
IE1pY2hhZWwsDQo+ID4gPiA+DQo+ID4gPiA+Pg0KPiA+ID4gPj4gTXkgbmFtZSBpcyBNaWNoYWVs
IEdhbGF4eSAoZm9ybWVybHkgSGluZXMpLiBZZXMsIEkgY2hhbmdlZCBteQ0KPiA+ID4gPj4gbGFz
dCBuYW1lIChoaWdobHkgaXJyZWd1bGFyIGZvciBhIG1hbGUpIGFuZCB5ZXMsIHRoYXQncyBteSBy
ZWFsIGxhc3QgbmFtZToNCj4gPiA+ID4+IGh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9pbi9tcmdh
bGF4eS8pDQo+ID4gPiA+Pg0KPiA+ID4gPj4gSSdtIHRoZSBvcmlnaW5hbCBhdXRob3Igb2YgdGhl
IFJETUEgaW1wbGVtZW50YXRpb24uIEkndmUgYmVlbg0KPiA+ID4gPj4gZGlzY3Vzc2luZyB3aXRo
IFl1IFpoYW5nIGZvciBhIGxpdHRsZSBiaXQgYWJvdXQgcG90ZW50aWFsbHkNCj4gPiA+ID4+IGhh
bmRpbmcgb3ZlciBtYWludGFpbmVyc2hpcCBvZiB0aGUgY29kZWJhc2UgdG8gaGlzIHRlYW0uDQo+
ID4gPiA+Pg0KPiA+ID4gPj4gSSBzaW1wbHkgaGF2ZSB6ZXJvIGFjY2VzcyB0byBSb0NFIG9yIElu
ZmluaWJhbmQgaGFyZHdhcmUgYXQgYWxsLA0KPiA+ID4gPj4gdW5mb3J0dW5hdGVseS4gc28gSSd2
ZSBuZXZlciBiZWVuIGFibGUgdG8gcnVuIHRlc3RzIG9yIHVzZSB3aGF0IEkNCj4gPiA+ID4+IHdy
b3RlIGF0IHdvcmssIGFuZCBhcyBhbGwgb2YgeW91IGtub3csIGlmIHlvdSBkb24ndCBoYXZlIGEg
d2F5IHRvDQo+ID4gPiA+PiB0ZXN0IHNvbWV0aGluZywgdGhlbiB5b3UgY2FuJ3QgbWFpbnRhaW4g
aXQuDQo+ID4gPiA+Pg0KPiA+ID4gPj4gWXUgWmhhbmcgcHV0IGEgKHZlcnkga2luZCkgcHJvcG9z
YWwgZm9yd2FyZCB0byBtZSB0byBhc2sgdGhlDQo+ID4gPiA+PiBjb21tdW5pdHkgaWYgdGhleSBm
ZWVsIGNvbWZvcnRhYmxlIHRyYWluaW5nIGhpcyB0ZWFtIHRvIG1haW50YWluDQo+ID4gPiA+PiB0
aGUgY29kZWJhc2UgKGFuZCBydW4NCj4gPiA+ID4+IHRlc3RzKSB3aGlsZSB0aGV5IGxlYXJuIGFi
b3V0IGl0Lg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgIndoaWxlIGxlYXJuaW5nIiBwYXJ0IGlzIGZp
bmUgYXQgbGVhc3QgdG8gbWUuICBJTUhPIHRoZQ0KPiA+ID4gPiAib3duZXJzaGlwIiB0byB0aGUg
Y29kZSwgb3Igc2F5LCB0YWtpbmcgb3ZlciB0aGUgcmVzcG9uc2liaWxpdHksDQo+ID4gPiA+IG1h
eSBvciBtYXkgbm90IG5lZWQgMTAwJSBtYXN0ZXJpbmcgdGhlIGNvZGUgYmFzZSBmaXJzdC4gIFRo
ZXJlDQo+ID4gPiA+IHNob3VsZCBzdGlsbCBiZSBzb21lIGZ1bmRhbWVudGFsIGNvbmZpZGVuY2Ug
dG8gd29yayBvbiB0aGUgY29kZQ0KPiA+ID4gPiB0aG91Z2ggYXMgYSBzdGFydGluZyBwb2ludCwg
dGhlbiBpdCdzIGFib3V0IHNlcmlvdXMgdXNlIGNhc2UgdG8NCj4gPiA+ID4gYmFjayB0aGlzIHVw
LCBhbmQgY2FyZWZ1bCB0ZXN0aW5ncyB3aGlsZSBnZXR0aW5nIG1vcmUgZmFtaWxpYXIgd2l0aCBp
dC4NCj4gPiA+DQo+ID4gPiBIb3cgbXVjaCBleHBlcmllbmNlIHdlIGV4cGVjdCBvZiBtYWludGFp
bmVycyBkZXBlbmRzIG9uIHRoZQ0KPiA+ID4gc3Vic3lzdGVtIGFuZCBvdGhlciBjaXJjdW1zdGFu
Y2VzLiAgVGhlIGhhcmQgcmVxdWlyZW1lbnQgaXNuJ3QNCj4gPiA+IGV4cGVyaWVuY2UsIGl0J3Mg
dHJ1c3QuICBTZWUgdGhlIHJlY2VudCBhdHRhY2sgb24geHouDQo+ID4gPg0KPiA+ID4gSSBkbyBu
b3QgbWVhbiB0byBleHByZXNzIGFueSBkb3VidHMgd2hhdHNvZXZlciBvbiBZdSBaaGFuZydzIGlu
dGVncml0eSENCj4gPiA+IEknbSBtZXJlbHkgcmVtaW5kaW5nIHknYWxsIHdoYXQncyBhdCBzdGFr
ZS4NCj4gPg0KPiA+IEkgdGhpbmsgd2Ugc2hvdWxkbid0IG92ZXJseSBvYnNlc3NbMV0gYWJvdXQg
J3h6JywgYmVjYXVzZSB0aGUNCj4gPiBvdmVyd2hlYWxtaW5nbHkgY29tbW9uIHNjZW5hcmlvIGlz
IHRoYXQgdm9sdW50ZWVyIG1haW50YWluZXJzIGFyZQ0KPiA+IGhvbmVzdCBwZW9wbGUuIFFFTVUg
aXMgaW4gYSBtYXNzaXZlbHkgYmV0dGVyIHBlZXIgcmV2aWV3IHNpdHVhdGlvbi4NCj4gPiBXaXRo
IHh6IHRoZXJlIHdhcyBiYXNpY2FsbHkgbm8gb3ZlcnNpZ2h0IG9mIHRoZSBuZXcgbWFpbnRhaW5l
ci4gV2l0aA0KPiA+IFFFTVUsIHdlIGhhdmUgb3ZlcnNpZ2h0IGZyb20gMTAwMCdzIG9mIHBlb3Bs
ZSBvbiB0aGUgbGlzdCwgYSBodWdlIHBvb2wNCj4gPiBvZiBnZW5lcmFsIG1haW50YWluZXJzLCB0
aGUgc3BlY2lmaWMgbWlncmF0aW9uIG1haW50YWluZXJzLCBhbmQgdGhlIHJlbGVhc2UNCj4gbWFu
YWdlciBtZXJnaW5nIGNvZGUuDQo+ID4NCj4gPiBXaXRoIGEgbGFjayBvZiBoaXN0b3JpY2FsIGV4
cGVyaWFuY2Ugd2l0aCBRRU1VIG1haW50YWluZXJzaGlwLCBJJ2QNCj4gPiBzdWdnZXN0IHRoYXQg
bmV3IFJETUEgdm9sdW50ZWVycyB3b3VsZCBzdGFydCBieSBhZGRpbmcgdGhlbXNlbHZlcyB0byB0
aGUNCj4gIk1BSU5UQUlORVJTIg0KPiA+IGZpbGUgd2l0aCBvbmx5IHRoZSAnUmV2aWV3ZXInIGNs
YXNzaWZpY2F0aW9uLiBUaGUgbWFpbiBtaWdyYXRpb24NCj4gPiBtYWludGFpbmVycyB3b3VsZCBz
dGlsbCBoYW5kbGUgcHVsbCByZXF1ZXN0cywgYnV0IHdhaXQgZm9yIGEgUi1iIGZyb20NCj4gPiBv
bmUgb2YgdGhlIFJNREEgdm9sdW50ZWVycy4gQWZ0ZXIgc29tZSBwZXJpb2Qgb2YgdGltZSB0aGUg
UkRNQSBmb2xrcw0KPiA+IGNvdWxkIGdyYWR1YXRlIHRvIGZ1bGwgbWFpbnRhaW5lciBzdGF0dXMg
aWYgdGhlIG1pZ3JhdGlvbiBtYWludGFpbmVycyBuZWVkZWQNCj4gdG8gcmVkdWNlIHRoZWlyIGxv
YWQuDQo+ID4gSSBzdXNwZWN0IHRoYXQgbWlnaHQgcHJvdmUgdW5uZWNjZXNhcnkgdGhvdWdoLCBn
aXZlbiBSRE1BIGlzbid0IGFuDQo+ID4gYXJlYSBvZiBjb2RlIHdpdGggYSBoaWdoIHR1cm5vdmVy
IG9mIHBhdGNoZXMuDQo+IA0KPiBSaWdodCwgYW5kIHdlIGNhbiBkbyB0aGF0IGFzIGEgc3RhcnQs
IGl0IGFsc28gZm9sbG93cyBvdXIgbm9ybWFsIHJ1bGVzIG9mIHN0YXJ0aW5nDQo+IGZyb20gUmV2
aWV3ZXJzIHRvIG1haW50YWluIHNvbWV0aGluZy4gIEkgZXZlbiBjb25zaWRlcmVkIFpoaWppYW4g
dG8gYmUgdGhlDQo+IHByZXZpb3VzIHJkbWEgZ290byBndXkgLyBtYWludGFpbmVyIG5vIG1hdHRl
ciB3aGF0IHJvbGUgaGUgdXNlZCB0byBoYXZlIGluDQo+IHRoZSBNQUlOVEFJTkVSUyBmaWxlLg0K
PiANCj4gSGVyZSBJTUhPIGl0J3MgbW9yZSBhYm91dCB3aGV0aGVyIGFueSBjb21wYW55IHdvdWxk
IGxpa2UgdG8gc3RhbmQgdXAgYW5kDQo+IHByb3ZpZGUgaGVscCwgd2l0aG91dCB5ZXQgYmluZGlu
ZyB0aGF0IHRvIGJlIGFibGUgdG8gc2VuZCBwdWxsIHJlcXVlc3RzIGluIHRoZQ0KPiBuZWFyIGZ1
dHVyZSBvciBldmVuIGxvbmdlciB0ZXJtLg0KPiANCj4gV2hhdCBJIHdvcnJ5IG1vcmUgaXMgd2hl
dGhlciB0aGlzIGlzIHJlYWxseSB3aGF0IHdlIHdhbnQgdG8ga2VlcCByZG1hIGluDQo+IHFlbXUs
IGFuZCB0aGF0J3MgYWxzbyB3aHkgSSB3YXMgdHJ5aW5nIHRvIHJlcXVlc3QgZm9yIHNvbWUgc2Vy
aW91cw0KPiBwZXJmb3JtYW5jZSBtZWFzdXJlbWVudHMgY29tcGFyaW5nIHJkbWEgdi5zLiBuaWNz
LiAgQW5kIGhlcmUgd2hlbiBJIHNhaWQNCj4gIndlIiBJIG1lYW4gYm90aCBRRU1VIGNvbW11bml0
eSBhbmQgYW55IGNvbXBhbnkgdGhhdCB3aWxsIHN1cHBvcnQNCj4ga2VlcGluZyByZG1hIGFyb3Vu
ZC4NCj4gDQo+IFRoZSBwcm9ibGVtIGlzIGlmIE5JQ3Mgbm93IGFyZSBmYXN0IGVub3VnaCB0byBw
ZXJmb3JtIGF0IGxlYXN0IGVxdWFsbHkgYWdhaW5zdA0KPiByZG1hLCBhbmQgaWYgaXQgaGFzIGEg
bG93ZXIgY29zdCBvZiBvdmVyYWxsIG1haW50ZW5hbmNlLCBkb2VzIGl0IG1lYW4gdGhhdCByZG1h
DQo+IG1pZ3JhdGlvbiB3aWxsIG9ubHkgYmUgdXNlZCBieSB3aG9ldmVyIHdhbnRzIHRvIGtlZXAg
dGhlbSBpbiB0aGUgcHJvZHVjdHMgYW5kDQo+IGV4aXN0ZWQgYWxyZWFkeT8gIEluIHRoYXQgY2Fz
ZSB3ZSBzaG91bGQgc2ltcGx5IGFzayBuZXcgdXNlcnMgdG8gc3RpY2sgd2l0aCB0Y3AsDQo+IGFu
ZCByZG1hIHVzZXJzIHNob3VsZCBvbmx5IGRyb3AgYnV0IG5vdCBpbmNyZWFzZS4NCj4gDQo+IEl0
IHNlZW1zIGFsc28gZGVzdGluZWQgdGhhdCBtb3N0IG5ldyBtaWdyYXRpb24gZmVhdHVyZXMgd2ls
bCBub3Qgc3VwcG9ydA0KPiByZG1hOiBzZWUgaG93IG11Y2ggd2UgZHJvcCBvbGQgZmVhdHVyZXMg
aW4gbWlncmF0aW9uIG5vdyAod2hpY2ggcmRtYQ0KPiBfbWlnaHRfIHN0aWxsIGxldmVyYWdlLCBi
dXQgbWF5YmUgbm90KSwgYW5kIGhvdyBtdWNoIHdlIGFkZCBtb3N0bHkgbXVsdGlmZA0KPiByZWxl
dmFudCB3aGljaCB3aWxsIHByb2JhYmx5IG5vdCBhcHBseSB0byByZG1hIGF0IGFsbC4gIFNvIGlu
IGdlbmVyYWwgd2hhdCBJIGFtDQo+IHdvcnJ5aW5nIGlzIGEgYm90aC1sb3NzIGNvbmRpdGlvbiwg
aWYgdGhlIGNvbXBhbnkgbWlnaHQgYmUgZWFzaWVyIHRvIGVpdGhlciBzdGljaw0KPiB3aXRoIGFu
IG9sZCBxZW11IChkZXBlbmRpbmcgb24gd2hldGhlciBvdGhlciBuZXcgZmVhdHVyZXMgYXJlIHJl
cXVlc3RlZCB0bw0KPiBiZSB1c2VkIGJlc2lkZXMgUkRNQSBhbG9uZSksIG9yIGRvIHBlcmlvZGlj
IHJlYmFzZSB3aXRoIFJETUEgZG93bnN0cmVhbQ0KPiBvbmx5Lg0KPiANCj4gU28gZXZlbiBpZiB3
ZSB3YW50IHRvIGtlZXAgUkRNQSBhcm91bmQgSSBob3BlIHdpdGggdGhpcyBjaGFuY2Ugd2UgY2Fu
IGF0DQo+IGxlYXN0IGhhdmUgY2xlYXIgcGljdHVyZSBvbiB3aGVuIHdlIHNob3VsZCBzdGlsbCBz
dWdnZXN0IGFueSBuZXcgdXNlciB0byB1c2UNCj4gUkRNQSAod2l0aCB0aGUgcmVhc29ucyBiZWhp
bmQpLiAgT3Igd2Ugc2ltcGx5IHNob3VsZG4ndCBzdWdnZXN0IGFueSBuZXcNCj4gdXNlciB0byB1
c2UgUkRNQSBhdCBhbGwgKGJlY2F1c2UgYXQgbGVhc3QgaXQnbGwgbG9zZSBtYW55IG5ldyBtaWdy
YXRpb24NCj4gZmVhdHVyZXMpLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gLS0NCj4gUGV0ZXIgWHUN
Cg0K

