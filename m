Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02FEC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 09:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBsmz-0000xZ-Mx; Tue, 28 May 2024 05:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sBsmo-0000vz-Bz; Tue, 28 May 2024 05:06:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sBsmk-0001Bg-Sq; Tue, 28 May 2024 05:06:26 -0400
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VpRPD6phyz1ysWV;
 Tue, 28 May 2024 17:02:56 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (unknown [7.185.36.76])
 by mail.maildlp.com (Postfix) with ESMTPS id 149CF180066;
 Tue, 28 May 2024 17:06:05 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 May 2024 17:06:04 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Tue, 28 May 2024 17:06:04 +0800
To: Peter Xu <peterx@redhat.com>, Yu Zhang <yu.zhang@ionos.com>
CC: Michael Galaxy <mgalaxy@akamai.com>, Jinpu Wang <jinpu.wang@ionos.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>, zhengchuan <zhengchuan@huawei.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, "Zhijian Li (Fujitsu)"
 <lizhijian@fujitsu.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>, "Prasanna Kumar
 Kalever" <prasanna4324@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "devel@lists.libvirt.org"
 <devel@lists.libvirt.org>, Hanna Reitz <hreitz@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake
 <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Wainer dos Santos
 Moschetta" <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Pannengyuan <pannengyuan@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Topic: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Index: AQHaib4eb+nVph6utEe7HatbjXSGr7FeBxGAgAD/kQCAAM0PAIAAcGaAgAC+EICAAZsBgIAAJisAgBwPpQCAAB5mAIABl4t9//+GhYCAAhAsgIAHeqWwgABddICAATP+EIAAcc0AgAKnDgCAAFgYAIAH7hYAgANI14CAAUekgIAG49qAgAqnmyA=
Date: Tue, 28 May 2024 09:06:04 +0000
Message-ID: <2308a8b894244123b638038e40a33990@huawei.com>
References: <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com> <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com> <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com> <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
 <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
 <Zk0c51D1Oo6NdIxR@x1n>
In-Reply-To: <Zk0c51D1Oo6NdIxR@x1n>
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

SGkgUGV0ZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIg
WHUgW21haWx0bzpwZXRlcnhAcmVkaGF0LmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjIs
IDIwMjQgNjoxNSBBTQ0KPiBUbzogWXUgWmhhbmcgPHl1LnpoYW5nQGlvbm9zLmNvbT4NCj4gQ2M6
IE1pY2hhZWwgR2FsYXh5IDxtZ2FsYXh5QGFrYW1haS5jb20+OyBKaW5wdSBXYW5nDQo+IDxqaW5w
dS53YW5nQGlvbm9zLmNvbT47IEVsbWFyIEdlcmRlcyA8ZWxtYXIuZ2VyZGVzQGlvbm9zLmNvbT47
DQo+IHpoZW5nY2h1YW4gPHpoZW5nY2h1YW5AaHVhd2VpLmNvbT47IEdvbmdsZWkgKEFyZWkpDQo+
IDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdl
QHJlZGhhdC5jb20+Ow0KPiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+OyBa
aGlqaWFuIExpIChGdWppdHN1KQ0KPiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPjsgcWVtdS1kZXZl
bEBub25nbnUub3JnOyBZdXZhbCBTaGFpYQ0KPiA8eXV2YWwuc2hhaWEubWxAZ21haWwuY29tPjsg
S2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT47IFByYXNhbm5hDQo+IEt1bWFyIEthbGV2ZXIg
PHByYXNhbm5hLmthbGV2ZXJAcmVkaGF0LmNvbT47IENvcm5lbGlhIEh1Y2sNCj4gPGNvaHVja0By
ZWRoYXQuY29tPjsgTWljaGFlbCBSb3RoIDxtaWNoYWVsLnJvdGhAYW1kLmNvbT47IFByYXNhbm5h
DQo+IEt1bWFyIEthbGV2ZXIgPHByYXNhbm5hNDMyNEBnbWFpbC5jb20+OyBQYW9sbyBCb256aW5p
DQo+IDxwYm9uemluaUByZWRoYXQuY29tPjsgcWVtdS1ibG9ja0Bub25nbnUub3JnOyBkZXZlbEBs
aXN0cy5saWJ2aXJ0Lm9yZzsNCj4gSGFubmEgUmVpdHogPGhyZWl0ekByZWRoYXQuY29tPjsgTWlj
aGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47DQo+IFRob21hcyBIdXRoIDx0aHV0aEBy
ZWRoYXQuY29tPjsgRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+OyBTb25nDQo+IEdhbyA8
Z2Fvc29uZ0Bsb29uZ3Nvbi5jbj47IE1hcmMtQW5kcsOpIEx1cmVhdQ0KPiA8bWFyY2FuZHJlLmx1
cmVhdUByZWRoYXQuY29tPjsgQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPjsN
Cj4gV2FpbmVyIGRvcyBTYW50b3MgTW9zY2hldHRhIDx3YWluZXJzbUByZWRoYXQuY29tPjsgQmVy
YWxkbyBMZWFsDQo+IDxibGVhbEByZWRoYXQuY29tPjsgUGFubmVuZ3l1YW4gPHBhbm5lbmd5dWFu
QGh1YXdlaS5jb20+Ow0KPiBYaWV4aWFuZ3lvdSA8eGlleGlhbmd5b3VAaHVhd2VpLmNvbT47IEZh
Ymlhbm8gUm9zYXMgPGZhcm9zYXNAc3VzZS5kZT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSC1mb3It
OS4xIHYyIDIvM10gbWlncmF0aW9uOiBSZW1vdmUgUkRNQSBwcm90b2NvbCBoYW5kbGluZw0KPiAN
Cj4gT24gRnJpLCBNYXkgMTcsIDIwMjQgYXQgMDM6MDE6NTlQTSArMDIwMCwgWXUgWmhhbmcgd3Jv
dGU6DQo+ID4gSGVsbG8gTWljaGFlbCBhbmQgUGV0ZXIsDQo+IA0KPiBIaSwNCj4gDQo+ID4NCj4g
PiBFeGFjdGx5LCBub3Qgc28gY29tcGVsbGluZywgYXMgSSBkaWQgaXQgZmlyc3Qgb25seSBvbiBz
ZXJ2ZXJzIHdpZGVseQ0KPiA+IHVzZWQgZm9yIHByb2R1Y3Rpb24gaW4gb3VyIGRhdGEgY2VudGVy
LiBUaGUgbmV0d29yayBhZGFwdGVycyBhcmUNCj4gPg0KPiA+IEV0aGVybmV0IGNvbnRyb2xsZXI6
IEJyb2FkY29tIEluYy4gYW5kIHN1YnNpZGlhcmllcyBOZXRYdHJlbWUgQkNNNTcyMA0KPiA+IDIt
cG9ydCBHaWdhYml0IEV0aGVybmV0IFBDSWUNCj4gDQo+IEhtbS4uLiBJIGRlZmluaXRlbHkgdGhp
bmtzIEppbnB1J3MgTWVsbGFub3ggQ29ubmVjdFgtNiBsb29rcyBtb3JlIHJlYXNvbmFibGUuDQo+
IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL0NBTUdmZkVuLURLcE1aNHRB
NzFNSllkeWVtZzBaZGExNQ0KPiB3VkFxazgxdlh0S3p4LUxmSlFAbWFpbC5nbWFpbC5jb20vDQo+
IA0KPiBBcHByZWNpYXRlIGEgbG90IGZvciBldmVyeW9uZSBoZWxwaW5nIG9uIHRoZSB0ZXN0aW5n
cy4NCj4gDQo+ID4gSW5maW5pQmFuZCBjb250cm9sbGVyOiBNZWxsYW5veCBUZWNobm9sb2dpZXMg
TVQyNzgwMCBGYW1pbHkNCj4gPiBbQ29ubmVjdFgtNV0NCj4gPg0KPiA+IHdoaWNoIGRvZXNuJ3Qg
bWVldCBvdXIgcHVycG9zZS4gSSBjYW4gY2hvb3NlIFJETUEgb3IgVENQIGZvciBWTQ0KPiA+IG1p
Z3JhdGlvbi4gUkRNQSB0cmFmZmljIGlzIHRocm91Z2ggSW5maW5pQmFuZCBhbmQgVENQIHRocm91
Z2ggRXRoZXJuZXQNCj4gPiBvbiB0aGVzZSB0d28gaG9zdHMuIE9uZSBpcyBzdGFuZGJ5IHdoaWxl
IHRoZSBvdGhlciBpcyBhY3RpdmUuDQo+ID4NCj4gPiBOb3cgSSdsbCB0cnkgb24gYSBzZXJ2ZXIg
d2l0aCBtb3JlIHJlY2VudCBFdGhlcm5ldCBhbmQgSW5maW5pQmFuZA0KPiA+IG5ldHdvcmsgYWRh
cHRlcnMuIE9uZSBvZiB0aGVtIGhhczoNCj4gPiBCQ001NzQxNCBOZXRYdHJlbWUtRSAxMEdiLzI1
R2IgUkRNQSBFdGhlcm5ldCBDb250cm9sbGVyIChyZXYgMDEpDQo+ID4NCj4gPiBUaGUgY29tcGFy
aXNvbiBiZXR3ZWVuIFJETUEgYW5kIFRDUCBvbiB0aGUgc2FtZSBOSUMgY291bGQgbWFrZSBtb3Jl
DQo+IHNlbnNlLg0KPiANCj4gSXQgbG9va3MgdG8gbWUgTklDcyBhcmUgcG93ZXJmdWwgbm93LCBi
dXQgYWdhaW4gYXMgSSBtZW50aW9uZWQgSSBkb24ndCB0aGluayBpdCdzDQo+IGEgcmVhc29uIHdl
IG5lZWQgdG8gZGVwcmVjYXRlIHJkbWEsIGVzcGVjaWFsbHkgaWYgUUVNVSdzIHJkbWEgbWlncmF0
aW9uIGhhcw0KPiB0aGUgY2hhbmNlIHRvIGJlIHJlZmFjdG9yZWQgdXNpbmcgcnNvY2tldC4NCj4g
DQo+IElzIHRoZXJlIGFueW9uZSB3aG8gc3RhcnRlZCBsb29raW5nIGludG8gdGhhdCBkaXJlY3Rp
b24/ICBXb3VsZCBpdCBtYWtlIHNlbnNlDQo+IHdlIHN0YXJ0IHNvbWUgUG9DIG5vdz8NCj4gDQoN
Ck15IHRlYW0gaGFzIGZpbmlzaGVkIHRoZSBQb0MgcmVmYWN0b3Jpbmcgd2hpY2ggd29ya3Mgd2Vs
bC4gDQoNClByb2dyZXNzOg0KMS4gIEltcGxlbWVudCBpby9jaGFubmVsLXJkbWEuYywNCjIuICBB
ZGQgdW5pdCB0ZXN0IHRlc3RzL3VuaXQvdGVzdC1pby1jaGFubmVsLXJkbWEuYyBhbmQgdmVyaWZ5
aW5nIGl0IGlzIHN1Y2Nlc3NmdWwsDQozLiAgUmVtb3ZlIHRoZSBvcmlnaW5hbCBjb2RlIGZyb20g
bWlncmF0aW9uL3JkbWEuYywNCjQuICBSZXdyaXRlIHRoZSByZG1hX3N0YXJ0X291dGdvaW5nX21p
Z3JhdGlvbiBhbmQgcmRtYV9zdGFydF9pbmNvbWluZ19taWdyYXRpb24gbG9naWMsDQo1LiAgUmVt
b3ZlIGFsbCByZG1hX3h4eCBmdW5jdGlvbnMgZnJvbSBtaWdyYXRpb24vcmFtLmMuICh0byBwcmV2
ZW50IFJETUEgbGl2ZSBtaWdyYXRpb24gZnJvbSBwb2xsdXRpbmcgdGhlIGNvcmUgbG9naWMgb2Yg
bGl2ZSBtaWdyYXRpb24pLA0KNi4gIFRoZSBzb2Z0LVJvQ0UgaW1wbGVtZW50ZWQgYnkgc29mdHdh
cmUgaXMgdXNlZCB0byB0ZXN0IHRoZSBSRE1BIGxpdmUgbWlncmF0aW9uLiBJdCdzIHN1Y2Nlc3Nm
dWwuDQoNCldlIHdpbGwgYmUgc3VibWl0IHRoZSBwYXRjaHNldCBsYXRlci4NCg0KDQpSZWdhcmRz
LA0KLUdvbmdsZWkNCg0KPiBUaGFua3MsDQo+IA0KPiAtLQ0KPiBQZXRlciBYdQ0KDQo=

