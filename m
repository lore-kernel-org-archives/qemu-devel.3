Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECAFC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 08:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFVPr-0004mH-BZ; Fri, 07 Jun 2024 04:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sFVPp-0004hj-87; Fri, 07 Jun 2024 04:57:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sFVPk-0001zl-2S; Fri, 07 Jun 2024 04:57:40 -0400
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwZj25rf5zmXl6;
 Fri,  7 Jun 2024 16:52:54 +0800 (CST)
Received: from dggpeml100008.china.huawei.com (unknown [7.185.36.48])
 by mail.maildlp.com (Postfix) with ESMTPS id E682B18007B;
 Fri,  7 Jun 2024 16:57:30 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (7.185.36.61) by
 dggpeml100008.china.huawei.com (7.185.36.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 16:57:30 +0800
Received: from dggpemf200006.china.huawei.com ([7.185.36.61]) by
 dggpemf200006.china.huawei.com ([7.185.36.61]) with mapi id 15.02.1544.011;
 Fri, 7 Jun 2024 16:57:30 +0800
To: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
CC: Michael Galaxy <mgalaxy@akamai.com>, zhengchuan <zhengchuan@huawei.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, Yu Zhang <yu.zhang@ionos.com>, "Zhijian Li
 (Fujitsu)" <lizhijian@fujitsu.com>, Jinpu Wang <jinpu.wang@ionos.com>, "Elmar
 Gerdes" <elmar.gerdes@ionos.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf
 <kwolf@redhat.com>, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>, "integration@gluster.org"
 <integration@gluster.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "devel@lists.libvirt.org"
 <devel@lists.libvirt.org>, Hanna Reitz <hreitz@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake
 <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Wainer dos Santos
 Moschetta" <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Pannengyuan <pannengyuan@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>,
 Wangjialin <wangjialin23@huawei.com>
Subject: RE: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Topic: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Index: AQHaib4eb+nVph6utEe7HatbjXSGr7FeBxGAgAD/kQCAAM0PAIAAcGaAgAC+EICAAZsBgIAAJisAgBwPpQCAAB5mAIABl4t9//+GhYCAAhAsgIAHeqWwgABddICAATP+EIAAcc0AgAKnDgCABu9BgIAi8iQAgADk1YCAAG8QAIAACG4AgALZd7A=
Date: Fri, 7 Jun 2024 08:57:30 +0000
Message-ID: <36fc28e07101464db670eebc3833baac@huawei.com>
References: <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com> <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com> <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <cd93922f-cf58-4a42-854d-0b39c6941905@akamai.com>
 <Zl-x_Az8i4jOwitt@gallifrey> <ZmBx8UDDmO-C1Oqu@x1n>
 <ZmDPHKLkzBO47XRc@gallifrey> <ZmDWLkBKISvQcA8I@x1n>
In-Reply-To: <ZmDWLkBKISvQcA8I@x1n>
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  "Gonglei (Arei)" <arei.gonglei@huawei.com>
From:  "Gonglei (Arei)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgWHUgW21h
aWx0bzpwZXRlcnhAcmVkaGF0LmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgNiwgMjAyNCA1
OjE5IEFNDQo+IFRvOiBEci4gRGF2aWQgQWxhbiBHaWxiZXJ0IDxkYXZlQHRyZWJsaWcub3JnPg0K
PiBDYzogTWljaGFlbCBHYWxheHkgPG1nYWxheHlAYWthbWFpLmNvbT47IHpoZW5nY2h1YW4NCj4g
PHpoZW5nY2h1YW5AaHVhd2VpLmNvbT47IEdvbmdsZWkgKEFyZWkpIDxhcmVpLmdvbmdsZWlAaHVh
d2VpLmNvbT47DQo+IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+OyBN
YXJrdXMgQXJtYnJ1c3Rlcg0KPiA8YXJtYnJ1QHJlZGhhdC5jb20+OyBZdSBaaGFuZyA8eXUuemhh
bmdAaW9ub3MuY29tPjsgWmhpamlhbiBMaSAoRnVqaXRzdSkNCj4gPGxpemhpamlhbkBmdWppdHN1
LmNvbT47IEppbnB1IFdhbmcgPGppbnB1LndhbmdAaW9ub3MuY29tPjsgRWxtYXIgR2VyZGVzDQo+
IDxlbG1hci5nZXJkZXNAaW9ub3MuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBZdXZhbCBT
aGFpYQ0KPiA8eXV2YWwuc2hhaWEubWxAZ21haWwuY29tPjsgS2V2aW4gV29sZiA8a3dvbGZAcmVk
aGF0LmNvbT47IFByYXNhbm5hDQo+IEt1bWFyIEthbGV2ZXIgPHByYXNhbm5hLmthbGV2ZXJAcmVk
aGF0LmNvbT47IENvcm5lbGlhIEh1Y2sNCj4gPGNvaHVja0ByZWRoYXQuY29tPjsgTWljaGFlbCBS
b3RoIDxtaWNoYWVsLnJvdGhAYW1kLmNvbT47IFByYXNhbm5hDQo+IEt1bWFyIEthbGV2ZXIgPHBy
YXNhbm5hNDMyNEBnbWFpbC5jb20+OyBpbnRlZ3JhdGlvbkBnbHVzdGVyLm9yZzsgUGFvbG8NCj4g
Qm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IHFlbXUtYmxvY2tAbm9uZ251Lm9yZzsNCj4g
ZGV2ZWxAbGlzdHMubGlidmlydC5vcmc7IEhhbm5hIFJlaXR6IDxocmVpdHpAcmVkaGF0LmNvbT47
IE1pY2hhZWwgUy4gVHNpcmtpbg0KPiA8bXN0QHJlZGhhdC5jb20+OyBUaG9tYXMgSHV0aCA8dGh1
dGhAcmVkaGF0LmNvbT47IEVyaWMgQmxha2UNCj4gPGVibGFrZUByZWRoYXQuY29tPjsgU29uZyBH
YW8gPGdhb3NvbmdAbG9vbmdzb24uY24+OyBNYXJjLUFuZHLDqQ0KPiBMdXJlYXUgPG1hcmNhbmRy
ZS5sdXJlYXVAcmVkaGF0LmNvbT47IEFsZXggQmVubsOpZQ0KPiA8YWxleC5iZW5uZWVAbGluYXJv
Lm9yZz47IFdhaW5lciBkb3MgU2FudG9zIE1vc2NoZXR0YQ0KPiA8d2FpbmVyc21AcmVkaGF0LmNv
bT47IEJlcmFsZG8gTGVhbCA8YmxlYWxAcmVkaGF0LmNvbT47IFBhbm5lbmd5dWFuDQo+IDxwYW5u
ZW5neXVhbkBodWF3ZWkuY29tPjsgWGlleGlhbmd5b3UgPHhpZXhpYW5neW91QGh1YXdlaS5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gtZm9yLTkuMSB2MiAyLzNdIG1pZ3JhdGlvbjogUmVtb3Zl
IFJETUEgcHJvdG9jb2wgaGFuZGxpbmcNCj4gDQo+IE9uIFdlZCwgSnVuIDA1LCAyMDI0IGF0IDA4
OjQ4OjI4UE0gKzAwMDAsIERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgd3JvdGU6DQo+ID4gPiA+IEkg
anVzdCBub3RpY2VkIHRoaXMgdGhyZWFkOyBzb21lIHJhbmRvbSBub3RlcyBmcm9tIGEgc29tZXdo
YXQNCj4gPiA+ID4gZnJhZ21lbnRlZCBtZW1vcnkgb2YgdGhpczoNCj4gPiA+ID4NCj4gPiA+ID4g
ICBhKSBMb25nIGxvbmcgYWdvLCBJIGFsc28gdHJpZWQgcnNvY2tldDsNCj4gPiA+ID4NCj4gaHR0
cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTUtMDEvbXNnMDIw
NDAuaHRtbA0KPiA+ID4gPiAgICAgIGFzIEkgcmVtZW1iZXIgdGhlIGxpYnJhcnkgd2FzIHF1aXRl
IGZsYWt5IGF0IHRoZSB0aW1lLg0KPiA+ID4NCj4gPiA+IEhtbSBpbnRlcmVzdGluZy4gIFRoZXJl
IGFsc28gbG9va3MgbGlrZSBhIHRocmVhZCBkb2luZyBycG9sbCgpLg0KPiA+DQo+ID4gWWVoLCBJ
IGNhbid0IGFjdHVhbGx5IHJlbWVtYmVyIG11Y2ggbW9yZSBhYm91dCB3aGF0IEkgZGlkIGJhY2sg
dGhlbiENCj4gDQo+IEhlaCwgdGhhdCdzIHVuZGVyc3RhbmRhYmxlIGFuZCBmYWlyLiA6KQ0KPiAN
Cj4gPiA+IEkgaG9wZSBMZWkgYW5kIGhpcyB0ZWFtIGhhcyB0ZXN0ZWQgPjRHIG1lbSwgb3RoZXJ3
aXNlIGRlZmluaXRlbHkNCj4gPiA+IHdvcnRoIGNoZWNraW5nLiAgTGVpIGFsc28gbWVudGlvbmVk
IHRoZXJlJ3JlIHJzb2NrZXQgYnVncyB0aGV5IGZvdW5kDQo+ID4gPiBpbiB0aGUgY292ZXIgbGV0
dGVyLCBidXQgbm90IHN1cmUgd2hhdCdzIHRoYXQgYWJvdXQuDQo+ID4NCj4gPiBJdCB3b3VsZCBw
cm9iYWJseSBiZSBhIGdvb2QgaWRlYSB0byBrZWVwIHRyYWNrIG9mIHdoYXQgYnVncyBhcmUgaW4N
Cj4gPiBmbGlnaHQgd2l0aCBpdCwgYW5kIHRyeSBpdCBvbiBhIGZldyBSRE1BIGNhcmRzIHRvIHNl
ZSB3aGF0IHByb2JsZW1zDQo+ID4gZ2V0IHRyaWdnZXJlZC4NCj4gPiBJIHRoaW5rIEkgcmVwb3J0
ZWQgYSBmZXcgYXQgdGhlIHRpbWUsIGJ1dCBJIGdhdmUgdXAgYWZ0ZXIgZmVlbGluZyBpdA0KPiA+
IHdhcyBnZXR0aW5nIHZlcnkgaGFja3kuDQo+IA0KPiBBZ3JlZWQuICBNYXliZSB3ZSBjYW4gaGF2
ZSBhIGxpc3Qgb2YgdGhhdCBpbiB0aGUgY292ZXIgbGV0dGVyIG9yIGV2ZW4gUUVNVSdzDQo+IG1p
Z3JhdGlvbi9ybWRhIGRvYyBwYWdlLg0KPiANCj4gTGVpLCBpZiB5b3UgdGhpbmsgdGhhdCBtYWtl
cyBzZW5zZSBwbGVhc2UgZG8gc28gaW4geW91ciB1cGNvbWluZyBwb3N0cy4NCj4gVGhlcmUnbGwg
bmVlZCB0byBoYXZlIGEgbGlzdCBvZiB0aGluZ3MgeW91IGVuY291bnRlcmVkIGluIHRoZSBrZXJu
ZWwgZHJpdmVyIGFuZA0KPiBpdCdsbCBiZSBldmVuIGJldHRlciBpZiB0aGVyZSdyZSBmdXJ0aGVy
IGxpbmtzIHRvIHJlYWQgb24gZWFjaCBwcm9ibGVtLg0KPiANCk9LLCBubyBwcm9ibGVtLiBUaGVy
ZSBhcmUgdHdvIGJ1Z3M6DQoNCkJ1ZyAxOg0KDQpodHRwczovL2dpdGh1Yi5jb20vbGludXgtcmRt
YS9yZG1hLWNvcmUvY29tbWl0LzIzOTg1ZTI1YWViYjU1OWI3NjE4NzIzMTNmOGNhYjRlODExYzVh
M2QjZGlmZi01ZGRiZjgzYzZmMDIxNjg4MTY2MDk2Y2E5NmM5YmJhODc0ZGZmYzNjYWI4OGRlZDJl
OWQ4YjIxNzZmYWEwODRjUjMzMDItUjMzMDMNCg0KaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIGEgYnVn
IHRoYXQgY2F1c2VzIFFFTVUgc3VzcGVuc2lvbi4NCldoZW4gdGhlIHRpbWVvdXQgcGFyYW1ldGVy
IG9mIHRoZSBycG9sbCBpcyBub3QgLTEgb3IgMCwgdGhlIHByb2dyYW0gaXMgc3VzcGVuZGVkIG9j
Y2FzaW9uYWxseS4NCg0KUHJvYmxlbSBhbmFseXNpczoNCkR1cmluZyB0aGUgZmlyc3QgcnBvbGws
DQpJbiBsaW5lIDMyOTcsIHJzX3BvbGxfZW50ZXIgKCkgcGVyZm9ybXMgcG9sbGNudCsrLiBJbiB0
aGlzIGNhc2UsIHRoZSB2YWx1ZSBvZiBwb2xsY250IGlzIDEuDQpJbiBsaW5lIDMzMDIsIHRpbWVv
dXQgZXhwaXJlcyBhbmQgdGhlIGZ1bmN0aW9uIGV4aXRzLiBOb3RlIHRoYXQgcnNfcG9sbF9leGl0
ICgpIGlzIG5vdCAtLXBvbGxjbnQgaGVyZS4NCkluIHRoaXMgY2FzZSwgdGhlIHZhbHVlIG9mIHBv
bGxjbnQgaXMgMS4NCkR1cmluZyB0aGUgc2Vjb25kIHJwb2xsLCBwb2xsY250KysgaXMgcGVyZm9y
bWVkIGluIGxpbmUgMzI5NyByc19wb2xsX2VudGVyICgpLiBJbiB0aGlzIGNhc2UsIHRoZSB2YWx1
ZSBvZiBwb2xsY250IGlzIDIuDQpJZiBubyB0aW1lb3V0IGV4cGlyZXMgYW5kIHRoZSBwb2xsIHJl
dHVybiB2YWx1ZSBpcyBncmVhdGVyIHRoYW4gMCwgdGhlIHJzX3BvbGxfc3RvcCAoKSBmdW5jdGlv
biBpcyBleGVjdXRlZC4gQmVjYXVzZSB0aGUgaWYgKC0tcG9sbGNudCkgY29uZGl0aW9uIGlzIGZh
bHNlLCBzdXNwZW5kcG9sbCA9IDEgaXMgZXhlY3V0ZWQuDQpHbyBiYWNrIHRvIHRoZSBkbyB3aGls
ZSBsb29wIGluc2lkZSBycG9sbCwgYWdhaW4gcnNfcG9sbF9lbnRlciAoKSBub3cgaWYgKHN1c3Bl
bmRwb2xsKSBjb25kaXRpb24gaXMgdHJ1ZSwgZXhlY3V0ZSBwdGhyZWFkX3lpZWxkICgpOyBhbmQg
cmV0dXJuIC1FQlVTWSwgVGhlbiwgdGhlIGRvIHdoaWxlIGxvb3AgaW4gdGhlIHJwb2xsIGlzIHJl
dHVybmVkLiBCZWNhdXNlIHRoZSBpZiAocnNfcG9sbF9lbnRlciAoKSkgY29uZGl0aW9uIGlzIHRy
dWUsIHRoZSByc19wb2xsX2VudGVyICgpIGZ1bmN0aW9uIGlzIGV4ZWN1dGVkIGFnYWluIGFmdGVy
IHRoZSBjb250aW51ZSBvcGVyYXRpb24uIEFzIGEgcmVzdWx0LCB0aGUgcHJvZ3JhbSBpcyBzdXNw
ZW5kZWQuDQoNClJvb3QgY2F1c2U6IEluIGxpbmUgMzMwMiwgcnNfcG9sbF9leGl0ICgpIGlzIG5v
dCBleGVjdXRlZCBiZWZvcmUgdGhlIHRpbWVvdXQgZXhwaXJlcyBmdW5jdGlvbiBleGl0cy4NCg0K
DQpCdWcgMjoNCg0KSW4gcnNvY2tldC5jLCB0aGVyZSBpcyBhIHJlY2VpdmUgcXVldWUgaW50IGFj
Y2VwdF9xdWV1ZVsyXSBpbXBsZW1lbnRlZCBieSBzb2NrZXRwYWlyLiBUaGUgbGlzdGVuX3N2YyB0
aHJlYWQgaW4gcnNvY2tldC5jIGlzIHJlc3BvbnNpYmxlIGZvciByZWNlaXZpbmcgY29ubmVjdGlv
bnMgYW5kIHdyaXRpbmcgdGhlbSB0byB0aGUgYWNjZXB0X3F1ZXVlWzFdLiBXaGVuIHJhY2NlcHQg
KCkgaXMgY2FsbGVkLCBhIGNvbm5lY3Rpb24gaXMgcmVjZWl2ZWQgZnJvbSBhY2NlcHRfcXVldWVb
MF0uDQpJbiB0aGUgdGVzdCBjYXNlLCBxaW9fY2hhbm5lbF93YWl0KFFJT19DSEFOTkVMKGxpb2Mp
LCBHX0lPX0lOKTsgd2FpdHMgZm9yIGEgcmVhZGFibGUgZXZlbnQgKHdhaXRpbmcgZm9yIGEgY29u
bmVjdGlvbiksIHJwb2xsICgpIGNoZWNrcyBpZiBhY2NlcHRfcXVldWVbMF0gaGFzIGEgcmVhZGFi
bGUgZXZlbnQsIEhvd2V2ZXIsIHRoaXMgcG9sbCBkb2VzIG5vdCBwb2xsIGFjY2VwdF9xdWV1ZVsw
XS4gQWZ0ZXIgdGhlIHRpbWVvdXQgZXhwaXJlcywgcnBvbGwgKCkgb2J0YWlucyB0aGUgcmVhZGFi
bGUgZXZlbnQgb2YgYWNjZXB0X3F1ZXVlWzBdIGZyb20gcnNfcG9sbF9hcm0gYWdhaW4uDQoNCklt
cGFjdGlvbjogDQpUaGUgYWNjZXB0IG9wZXJhdGlvbiBjYW4gYmUgcGVyZm9ybWVkIG9ubHkgYWZ0
ZXIgNTAwMCBtcy4gT2YgY291cnNlLCB3ZSBjYW4gc2hvcnRlbiB0aGlzIHRpbWUgYnkgZWNob2lu
ZyB0aGUgbWlsbGlzZWNvbmQgdGltZSA+IC9ldGMvcmRtYS9yc29ja2V0L3dha2VfdXBfaW50ZXJ2
YWwuDQoNCg0KUmVnYXJkcywNCi1Hb25nbGVpDQoNCj4gPiA+ID4NCj4gPiA+ID4gICBlKSBTb21l
b25lIG1hZGUgYSBnb29kIHN1Z2dlc3Rpb24gKHNvcnJ5IGNhbid0IHJlbWVtYmVyIHdobykgLQ0K
PiB0aGF0IHRoZQ0KPiA+ID4gPiAgICAgIFJETUEgbWlncmF0aW9uIHN0cnVjdHVyZSB3YXMgdGhl
IHdyb25nIHdheSBhcm91bmQgLSBpdCBzaG91bGQNCj4gYmUgdGhlDQo+ID4gPiA+ICAgICAgZGVz
dGluYXRpb24gd2hpY2ggaW5pdGlhdGVzIGFuIFJETUEgcmVhZCwgcmF0aGVyIHRoYW4gdGhlIHNv
dXJjZQ0KPiA+ID4gPiAgICAgIGRvaW5nIGEgd3JpdGU7IHRoZW4gdGhpbmdzIG1pZ2h0IGJlY29t
ZSBhIExPVCBzaW1wbGVyOyB5b3UganVzdA0KPiBuZWVkDQo+ID4gPiA+ICAgICAgdG8gc2VuZCBw
YWdlIHJhbmdlcyB0byB0aGUgZGVzdGluYXRpb24gYW5kIGl0IGNhbiBwdWxsIGl0Lg0KPiA+ID4g
PiAgICAgIFRoYXQgbWlnaHQgd29yayBuaWNlbHkgZm9yIHBvc3Rjb3B5Lg0KPiA+ID4NCj4gPiA+
IEknbSBub3Qgc3VyZSB3aGV0aGVyIGl0J2xsIHN0aWxsIGJlIGEgcHJvYmxlbSBpZiByZG1hIHJl
Y3Ygc2lkZSBpcw0KPiA+ID4gYmFzZWQgb24gemVyby1jb3B5LiAgSXQgd291bGQgYmUgYSBtYXR0
ZXIgb2Ygd2hldGhlciBhdG9taWNpdHkgY2FuDQo+ID4gPiBiZSBndWFyYW50ZWVkIHNvIHRoYXQg
d2UgZG9uJ3Qgd2FudCB0aGUgZ3Vlc3QgdmNwdXMgdG8gc2VlIGENCj4gPiA+IHBhcnRpYWxseSBj
b3BpZWQgcGFnZSBkdXJpbmcgb24tZmxpZ2h0IERNQXMuICBVRkZESU9fQ09QWSAob3INCj4gPiA+
IGZyaWVuZCkgaXMgY3VycmVudGx5IHRoZSBvbmx5IHNvbHV0aW9uIGZvciB0aGF0Lg0KPiA+DQo+
ID4gWWVzLCBidXQgZXZlbiBpZ25vcmluZyB0aGF0IChhbmQgdGhlIFVGRkRJT19DT05USU5VRSBp
ZGVhIHlvdQ0KPiA+IG1lbnRpb24pLCBpZiB0aGUgZGVzdGluYXRpb24gY2FuIGlzc3VlIGFuIFJE
TUEgcmVhZCBpdHNlbGYsIGl0IGRvZXNuJ3QNCj4gPiBuZWVkIHRvIHNlbmQgbWVzc2FnZXMgdG8g
dGhlIHNvdXJjZSB0byBhc2sgZm9yIGEgcGFnZSBmZXRjaDsgaXQganVzdA0KPiA+IGdvZXMgYW5k
IGdyYWJzIGl0IGl0c2VsZiwgdGhhdCdzIGdvdCB0byBiZSBnb29kIGZvciBsYXRlbmN5Lg0KPiAN
Cj4gT2gsIHRoYXQncyBwcmV0dHkgaW50ZXJuYWwgc3R1ZmYgb2YgcmRtYSB0byBtZSBhbmQgYmV5
b25kIG15IGtub3dsZWRnZS4uDQo+IGJ1dCBmcm9tIHdoYXQgSSBjYW4gdGVsbCBpdCBzb3VuZHMg
dmVyeSByZWFzb25hYmxlIGluZGVlZCENCj4gDQo+IFRoYW5rcyENCj4gDQo+IC0tDQo+IFBldGVy
IFh1DQo+IA0KDQo=

