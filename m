Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA606CFC276
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 09:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dwS-00044a-HM; Tue, 15 Oct 2024 05:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0dwR-00044F-2E
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:34:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0dwO-0005dV-E4
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:34:10 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSTMM03sGz6J7m2;
 Tue, 15 Oct 2024 17:29:35 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 51C4E1400D9;
 Tue, 15 Oct 2024 17:34:03 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 11:34:03 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 15 Oct 2024 11:34:03 +0200
To: maobibo <maobibo@loongson.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, zhukeqian <zhukeqian1@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Gavin Shan <gshan@redhat.com>,
 "Vishnu Pajjuri" <vishnu@os.amperecomputing.com>, Xianglai Li
 <lixianglai@loongson.cn>, Miguel Luis <miguel.luis@oracle.com>, Shaoqin Huang
 <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: RE: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with CPU scan
Thread-Topic: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with CPU scan
Thread-Index: AQHa3O9tCa8bLr9rS0OXX2Adjxk3G7KGUYWAgADadNCAADlegIAAqq7g
Date: Tue, 15 Oct 2024 09:34:02 +0000
Message-ID: <0681ec0c5f3544c58c2e87cd18ff6cc7@huawei.com>
References: <cover.1721731723.git.mst@redhat.com>
 <549c9a9dcbc1592ea79496f7b3ab234f366adeba.1721731723.git.mst@redhat.com>
 <ac9244d8-660a-ade6-9987-352c3c646a76@loongson.cn>
 <30c0297bd01f48868694e47e18841fab@huawei.com>
 <d6c51e74-5e11-e375-30fd-6d6fb23c7271@loongson.cn>
In-Reply-To: <d6c51e74-5e11-e375-30fd-6d6fb23c7271@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.146.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQmlibywNCg0KPiAgRnJvbTogbWFvYmlibyA8bWFvYmlib0Bsb29uZ3Nvbi5jbj4NCj4gIFNl
bnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTUsIDIwMjQgMjoyMCBBTQ0KPiAgVG86IFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ICANCj4g
IEhpIFNhbGlsLA0KPiAgDQo+ICBPbiAyMDI0LzEwLzE1IOS4iuWNiDM6NTksIFNhbGlsIE1laHRh
IHdyb3RlOg0KPiAgPiBIaSBCaWJvLA0KPiAgPg0KPiAgPj4gICBGcm9tOiBtYW9iaWJvIDxtYW9i
aWJvQGxvb25nc29uLmNuPg0KPiAgPj4gICBTZW50OiBNb25kYXksIE9jdG9iZXIgMTQsIDIwMjQg
OTo1MyBBTQ0KPiAgPj4gICBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBTYWxpbCBNZWh0YSA8
c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gID4+ICAgQ2M6IE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+OyBQZXRlciBNYXlkZWxsDQo+ICA+PiAgIDxwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmc+OyBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT47DQo+ICA+PiAg
IHpodWtlcWlhbiA8emh1a2VxaWFuMUBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiAg
Pj4gICA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgR2F2aW4gU2hhbiA8Z3NoYW5AcmVk
aGF0LmNvbT47DQo+ICA+PiAgIFZpc2hudSBQYWpqdXJpIDx2aXNobnVAb3MuYW1wZXJlY29tcHV0
aW5nLmNvbT47IFhpYW5nbGFpIExpDQo+ICA+PiAgIDxsaXhpYW5nbGFpQGxvb25nc29uLmNuPjsg
TWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+Ow0KPiAgU2hhb3Fpbg0KPiAgPj4g
ICBIdWFuZyA8c2hhaHVhbmdAcmVkaGF0LmNvbT47IFpoYW8gTGl1IDx6aGFvMS5saXVAaW50ZWwu
Y29tPjsgSWdvcg0KPiAgPj4gICBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT47IEFuaSBT
aW5oYQ0KPiAgPGFuaXNpbmhhQHJlZGhhdC5jb20+DQo+ICA+PiAgIFN1YmplY3Q6IFJlOiBbUFVM
TCB2MiA0MC82MV0gaHcvYWNwaTogVXBkYXRlIEdFRCBfRVZUIG1ldGhvZCBBTUwNCj4gIHdpdGgN
Cj4gID4+ICAgQ1BVIHNjYW4NCj4gID4+DQo+ICA+PiAgIEhpIFNhbGlsLA0KPiAgPj4NCj4gID4+
ICAgV2hlbiBJIGRlYnVnIGNwdSBob3RwbHVnIG9uIExvb25nQXJjaCBzeXN0ZW0sIEl0IHJlcG9y
dHMgZXJyb3IgbGlrZQ0KPiAgdGhpczoNCj4gID4+ICAgICAgICBBQ1BJIEJJT1MgRXJyb3IgKGJ1
Zyk6IENvdWxkIG5vdCByZXNvbHZlIHN5bWJvbCBbXF9TQi5HRUQuQ1NDTl0sDQo+ICA+PiAgIEFF
X05PVF9GT1VORA0KPiAgPj4gICAgICAgIEFDUEkgRXJyb3I6IEFib3J0aW5nIG1ldGhvZCBcX1NC
LkdFRC5fRVZUIGR1ZSB0byBwcmV2aW91cyBlcnJvcg0KPiAgPj4gICAoQUVfTk9UX0ZPVU5EKQ0K
PiAgPj4gICAgICAgIGFjcGktZ2VkIEFDUEkwMDEzOjAwOiBJUlEgbWV0aG9kIGV4ZWN1dGlvbiBm
YWlsZWQNCj4gID4+DQo+ICA+Pg0KPiAgPj4gICBXaXRoIHRoaXMgcGF0Y2gsIEdFRCBDUFUgY2Fs
bCBtZXRob2QgaXMgIlxcX1NCLkdFRC5DU0NOIiwgaG93ZXZlciBpbg0KPiAgPj4gICBmdW5jdGlv
biBidWlsZF9jcHVzX2FtbCgpLCBpdHMgbWV0aG9kIG5hbWUgaXMgIlxcX1NCLkNQVVMuQ1NDTiIu
DQo+ICA+PiAgICAgICAgbWV0aG9kID0gYW1sX21ldGhvZChldmVudF9oYW5kbGVyX21ldGhvZCwg
MCwNCj4gID4+ICAgQU1MX05PVFNFUklBTElaRUQpOw0KPiAgPj4gICAgICAgIGFtbF9hcHBlbmQo
bWV0aG9kLCBhbWxfY2FsbDAoIlxcX1NCLkNQVVMuIg0KPiAgQ1BVX1NDQU5fTUVUSE9EKSk7DQo+
ICA+PiAgICAgICAgYW1sX2FwcGVuZCh0YWJsZSwgbWV0aG9kKTsNCj4gID4+DQo+ICA+PiAgIEl0
IHNlZW1zIHRoYXQgQ1BVIHNjYW5uaW5nIG1ldGhvZCBuYW1lIGlzIG5vdCBjb25zaXN0ZW50IGJl
dHdlZW4NCj4gID4+ICAgZnVuY3Rpb24gYnVpbGRfY3B1c19hbWwoKSBhbmQgYnVpbGRfZ2VkX2Ft
bCgpLg0KPiAgPg0KPiAgPg0KPiAgPiBJIGJlbGlldmUgeW91ciBxdWVzdGlvbiBzdGVtcyBmcm9t
IHRoZSBmb2xsb3dpbmcgcGF0Y2ggSSd2ZSBzZW50IHJlY2VudGx5Og0KPiAgPg0KPiAgPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQxMDA5MDMxODE1LjI1MDA5Ni0xNi1z
YWxpbC5tZWh0DQo+ICA+IGFAaHVhd2VpLmNvbS8NCj4gID4NCj4gID4gSeKAmXZlIGFscmVhZHkg
cHJvcG9zZWQgYSBmaXggZm9yIHRoaXMgaXNzdWUuIERvZXMgdGhhdCBub3Qgd29yayBmb3IgeW91
Pw0KPiAgeWVzLCBpdCB3b3JrcyBmb3IgbWUgaWYgQU1MX0dFRF9FVlRfQ1BVX1NDQU5fTUVUSE9E
IGlzIHVzZWQgYXMNCj4gIHBhcmFtZXRlciBpbiBmdW5jdGlvbiBidWlsZF9jcHVzX2FtbCgpLg0K
PiAgDQo+ICBTb3JyeSBmb3IgdGhlIG5vaXNlLg0KDQoNCk5vIGlzc3Vlcy4gR29vZCB0aGF0IGl0
IGdvdCBzb3J0ZWQg8J+Yig0KDQpDaGVlcnMNClNhbGlsLg0KDQo+ICANCj4gIFJlZ2FyZHMNCj4g
IEJpYm8gTWFvDQo+ICA+DQo+ICA+IFRoYW5rcw0KPiAgPiBTYWxpbC4NCj4gID4NCj4gID4NCj4g
ID4+DQo+ICA+PiAgIFJlZ2FyZHMNCj4gID4+ICAgQmlibyBNYW8NCj4gID4+DQo+ICA+PiAgIE9u
IDIwMjQvNy8yMyDkuIvljYg2OjU5LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+ICA+PiAg
ID4gRnJvbTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICA+PiAgID4N
Cj4gID4+ICAgPiBPU1BNIGV2YWx1YXRlcyBfRVZUIG1ldGhvZCB0byBtYXAgdGhlIGV2ZW50LiBU
aGUgQ1BVIGhvdHBsdWcNCj4gIGV2ZW50DQo+ICA+PiAgID4gZXZlbnR1YWxseSByZXN1bHRzIGlu
IHN0YXJ0IG9mIHRoZSBDUFUgc2Nhbi4gU2NhbiBmaWd1cmVzIG91dCB0aGUgQ1BVDQo+ICA+PiAg
ID4gYW5kIHRoZSBraW5kIG9mDQo+ICA+PiAgID4gZXZlbnQocGx1Zy91bnBsdWcpIGFuZCBub3Rp
ZmllcyBpdCBiYWNrIHRvIHRoZSBndWVzdC4gVXBkYXRlIHRoZSBHRUQNCj4gID4+ICAgPiBBTUwg
X0VWVCBtZXRob2Qgd2l0aCB0aGUgY2FsbCB0byBtZXRob2QgXFxfU0IuQ1BVUy5DU0NOICh2aWEN
Cj4gID4+ICAgPiBcXF9TQi5HRUQuQ1NDTikNCj4gID4+ICAgPg0KPiAgPj4gICA+IEFyY2hpdGVj
dHVyZSBzcGVjaWZpYyBjb2RlIFsxXSBtaWdodCBpbml0aWFsaXplIGl0cyBDUFVzIEFNTCBjb2Rl
IGJ5DQo+ICA+PiAgID4gY2FsbGluZyBjb21tb24gZnVuY3Rpb24gYnVpbGRfY3B1c19hbWwoKSBs
aWtlIGJlbG93IGZvciBBUk06DQo+ICA+PiAgID4NCj4gID4+ICAgPiBidWlsZF9jcHVzX2FtbChz
Y29wZSwgbXMsIG9wdHMsIHh4X21hZHRfY3B1X2VudHJ5LA0KPiAgPj4gICBtZW1tYXBbVklSVF9D
UFVIUF9BQ1BJXS5iYXNlLA0KPiAgPj4gICA+ICAgICAgICAgICAgICAgICAiXFxfU0IiLCAiXFxf
U0IuR0VELkNTQ04iLCBBTUxfU1lTVEVNX01FTU9SWSk7DQo+ICA+PiAgID4NCj4gID4+ICAgPiBb
MV0NCj4gID4+ICAgPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQwNjEz
MjMzNjM5LjIwMjg5Ni0xMy0NCj4gIHNhbGlsLm1laHQNCj4gID4+ICAgPiBhQGh1YXdlaS5jb20v
DQo+ICA+PiAgID4NCj4gID4+ICAgPiBDby1kZXZlbG9wZWQtYnk6IEtlcWlhbiBaaHUgPHpodWtl
cWlhbjFAaHVhd2VpLmNvbT4NCj4gID4+ICAgPiBTaWduZWQtb2ZmLWJ5OiBLZXFpYW4gWmh1IDx6
aHVrZXFpYW4xQGh1YXdlaS5jb20+DQo+ICA+PiAgID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICA+PiAgID4gUmV2aWV3ZWQtYnk6IEpvbmF0
aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gID4+ICAgPiBSZXZp
ZXdlZC1ieTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4gID4+ICAgPiBUZXN0ZWQt
Ynk6IFZpc2hudSBQYWpqdXJpIDx2aXNobnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT4NCj4gID4+
ICAgPiBUZXN0ZWQtYnk6IFhpYW5nbGFpIExpIDxsaXhpYW5nbGFpQGxvb25nc29uLmNuPg0KPiAg
Pj4gICA+IFRlc3RlZC1ieTogTWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+DQo+
ICA+PiAgID4gUmV2aWV3ZWQtYnk6IFNoYW9xaW4gSHVhbmcgPHNoYWh1YW5nQHJlZGhhdC5jb20+
DQo+ICA+PiAgID4gVGVzdGVkLWJ5OiBaaGFvIExpdSA8emhhbzEubGl1QGludGVsLmNvbT4NCj4g
ID4+ICAgPiBSZXZpZXdlZC1ieTogSWdvciBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT4N
Cj4gID4+ICAgPiBNZXNzYWdlLUlkOiA8MjAyNDA3MTYxMTE1MDIuMjAyMzQ0LTUtc2FsaWwubWVo
dGFAaHVhd2VpLmNvbT4NCj4gID4+ICAgPiBSZXZpZXdlZC1ieTogTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4NCj4gID4+ICAgPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRz
aXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiAgPj4gICA+IC0tLQ0KPiAgPj4gICA+ICAgaW5jbHVk
ZS9ody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmggfCAxICsNCj4gID4+ICAgPiAgIGh3L2Fj
cGkvZ2VuZXJpY19ldmVudF9kZXZpY2UuYyAgICAgICAgIHwgMyArKysNCj4gID4+ICAgPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ICA+PiAgID4NCj4gID4+ICAgPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9ody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmgNCj4gID4+ICAg
PiBiL2luY2x1ZGUvaHcvYWNwaS9nZW5lcmljX2V2ZW50X2RldmljZS5oDQo+ICA+PiAgID4gaW5k
ZXggZTA5MWFjMjEwOC4uNDBhZjM1NTBiNSAxMDA2NDQNCj4gID4+ICAgPiAtLS0gYS9pbmNsdWRl
L2h3L2FjcGkvZ2VuZXJpY19ldmVudF9kZXZpY2UuaA0KPiAgPj4gICA+ICsrKyBiL2luY2x1ZGUv
aHcvYWNwaS9nZW5lcmljX2V2ZW50X2RldmljZS5oDQo+ICA+PiAgID4gQEAgLTg3LDYgKzg3LDcg
QEAgT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoQWNwaUdlZFN0YXRlLA0KPiAgPj4gICBBQ1BJ
X0dFRCkNCj4gID4+ICAgPiAgICNkZWZpbmUgR0VEX0RFVklDRSAgICAgICJHRUQiDQo+ICA+PiAg
ID4gICAjZGVmaW5lIEFNTF9HRURfRVZUX1JFRyAiRVJFRyINCj4gID4+ICAgPiAgICNkZWZpbmUg
QU1MX0dFRF9FVlRfU0VMICJFU0VMIg0KPiAgPj4gICA+ICsjZGVmaW5lIEFNTF9HRURfRVZUX0NQ
VV9TQ0FOX01FVEhPRCAiXFxfU0IuR0VELkNTQ04iDQo+ICA+PiAgID4NCj4gID4+ICAgPiAgIC8q
DQo+ICA+PiAgID4gICAgKiBQbGF0Zm9ybXMgbmVlZCB0byBzcGVjaWZ5IHRoZSBHRUQgZXZlbnQg
Yml0bWFwIGRpZmYgLS1naXQNCj4gID4+ICAgPiBhL2h3L2FjcGkvZ2VuZXJpY19ldmVudF9kZXZp
Y2UuYw0KPiAgYi9ody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmMNCj4gID4+ICAgPiBpbmRl
eCA0NjQxOTMzYTBmLi4xNWI0YzNlYmJmIDEwMDY0NA0KPiAgPj4gICA+IC0tLSBhL2h3L2FjcGkv
Z2VuZXJpY19ldmVudF9kZXZpY2UuYw0KPiAgPj4gICA+ICsrKyBiL2h3L2FjcGkvZ2VuZXJpY19l
dmVudF9kZXZpY2UuYw0KPiAgPj4gICA+IEBAIC0xMDgsNiArMTA4LDkgQEAgdm9pZCBidWlsZF9n
ZWRfYW1sKEFtbCAqdGFibGUsIGNvbnN0IGNoYXINCj4gICpuYW1lLA0KPiAgPj4gICBIb3RwbHVn
SGFuZGxlciAqaG90cGx1Z19kZXYsDQo+ICA+PiAgID4gICAgICAgICAgICAgICAgICAgYW1sX2Fw
cGVuZChpZl9jdHgsDQo+ICBhbWxfY2FsbDAoTUVNT1JZX0RFVklDRVNfQ09OVEFJTkVSDQo+ICA+
PiAgICIuIg0KPiAgPj4gICA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTUVNT1JZX1NMT1RfU0NBTl9NRVRIT0QpKTsNCj4gID4+ICAgPiAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gID4+ICAgPiArICAgICAgICAgICAgY2FzZSBBQ1BJX0dFRF9DUFVf
SE9UUExVR19FVlQ6DQo+ICA+PiAgID4gKyAgICAgICAgICAgICAgICBhbWxfYXBwZW5kKGlmX2N0
eCwNCj4gID4+ICAgYW1sX2NhbGwwKEFNTF9HRURfRVZUX0NQVV9TQ0FOX01FVEhPRCkpOw0KPiAg
Pj4gICA+ICsgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICA+PiAgID4gICAgICAgICAgICAgICBj
YXNlIEFDUElfR0VEX1BXUl9ET1dOX0VWVDoNCj4gID4+ICAgPiAgICAgICAgICAgICAgICAgICBh
bWxfYXBwZW5kKGlmX2N0eCwNCj4gID4+ICAgPg0KPiAgPj4gICA+IGFtbF9ub3RpZnkoYW1sX25h
bWUoQUNQSV9QT1dFUl9CVVRUT05fREVWSUNFKSwNCj4gID4+ICAgPg0KPiAgPg0KDQo=

