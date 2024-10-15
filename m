Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133BED216BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ika-0000VR-1X; Tue, 15 Oct 2024 10:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0ikY-0000VB-TN
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:42:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0ikW-0006OV-2f
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:42:14 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XScHG2NTHz6D8ht;
 Tue, 15 Oct 2024 22:41:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 06F88140A34;
 Tue, 15 Oct 2024 22:42:05 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 16:42:04 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 15 Oct 2024 16:42:04 +0200
To: Igor Mammedov <imammedo@redhat.com>
CC: maobibo <maobibo@loongson.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, zhukeqian <zhukeqian1@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Gavin Shan <gshan@redhat.com>,
 "Vishnu Pajjuri" <vishnu@os.amperecomputing.com>, Xianglai Li
 <lixianglai@loongson.cn>, Miguel Luis <miguel.luis@oracle.com>, Shaoqin Huang
 <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: RE: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with CPU scan
Thread-Topic: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with CPU scan
Thread-Index: AQHa3O9tCa8bLr9rS0OXX2Adjxk3G7KGUYWAgAAMgQCAAM83sIAAwUeAgAAi7BCAADHJAIAAI11w
Date: Tue, 15 Oct 2024 14:42:04 +0000
Message-ID: <6b7a6baa539e4396b2371348e1f293b1@huawei.com>
References: <cover.1721731723.git.mst@redhat.com>
 <549c9a9dcbc1592ea79496f7b3ab234f366adeba.1721731723.git.mst@redhat.com>
 <ac9244d8-660a-ade6-9987-352c3c646a76@loongson.cn>
 <20241014113740.6f8305be@imammedo.users.ipa.redhat.com>
 <f134c3491a4143269eb24d3023be82e6@huawei.com>
 <20241015113105.121216e5@imammedo.users.ipa.redhat.com>
 <bb1fcf595ac04cac95bb3cc86ff9d242@huawei.com>
 <20241015163416.36da248a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241015163416.36da248a@imammedo.users.ipa.redhat.com>
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

SGkgSWdvciwNCg0KPiAgRnJvbTogSWdvciBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT4N
Cj4gIFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTUsIDIwMjQgMzozNCBQTQ0KPiAgVG86IFNhbGls
IE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiAgDQo+ICBPbiBUdWUsIDE1IE9jdCAy
MDI0IDA5OjQxOjI0ICswMDAwDQo+ICBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNv
bT4gd3JvdGU6DQo+ICANCj4gID4gSEkgSWdvciwNCj4gID4NCj4gID4gPiAgRnJvbTogSWdvciBN
YW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT4NCj4gID4gPiAgU2VudDogVHVlc2RheSwgT2N0
b2JlciAxNSwgMjAyNCAxMDozMSBBTQ0KPiAgPiA+ICBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1l
aHRhQGh1YXdlaS5jb20+DQo+ICA+ID4gIENjOiBtYW9iaWJvIDxtYW9iaWJvQGxvb25nc29uLmNu
PjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiAgTWljaGFlbA0KPiAgPiA+IFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiAgPiA+IDxwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmc+OyAgemh1a2VxaWFuIDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+Ow0KPiAgPiA+IEpv
bmF0aGFuIENhbWVyb24gIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBHYXZpbiBTaGFu
DQo+ICA+ID4gPGdzaGFuQHJlZGhhdC5jb20+OyAgVmlzaG51IFBhamp1cmkNCj4gIDx2aXNobnVA
b3MuYW1wZXJlY29tcHV0aW5nLmNvbT47DQo+ICA+ID4gWGlhbmdsYWkgTGkgIDxsaXhpYW5nbGFp
QGxvb25nc29uLmNuPjsgTWlndWVsIEx1aXMNCj4gID4gPiA8bWlndWVsLmx1aXNAb3JhY2xlLmNv
bT47IFNoYW9xaW4gIEh1YW5nIDxzaGFodWFuZ0ByZWRoYXQuY29tPjsNCj4gIFpoYW8NCj4gID4g
PiBMaXUgPHpoYW8xLmxpdUBpbnRlbC5jb20+OyBBbmkgU2luaGEgIDxhbmlzaW5oYUByZWRoYXQu
Y29tPg0KPiAgPiA+ICBTdWJqZWN0OiBSZTogW1BVTEwgdjIgNDAvNjFdIGh3L2FjcGk6IFVwZGF0
ZSBHRUQgX0VWVCBtZXRob2QgQU1MDQo+ICA+ID4gd2l0aCAgQ1BVIHNjYW4NCj4gID4gPg0KPiAg
PiA+ICBPbiBNb24sIDE0IE9jdCAyMDI0IDIwOjA1OjU4ICswMDAwDQo+ICA+ID4gIFNhbGlsIE1l
aHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPiB3cm90ZToNCj4gID4gPg0KPiAgPiA+ICA+IEhp
IElnb3IsDQo+ICA+ID4gID4NCj4gID4gPiAgPiA+ICBGcm9tOiBxZW11LWRldmVsLWJvdW5jZXMr
c2FsaWwubWVodGE9aHVhd2VpLmNvbUBub25nbnUub3JnDQo+ICA+ID4gIDxxZW11LQ0KPiAgPiA+
ICA+ID4gZGV2ZWwtYm91bmNlcytzYWxpbC5tZWh0YT1odWF3ZWkuY29tQG5vbmdudS5vcmc+IE9u
IEJlaGFsZg0KPiAgT2YNCj4gID4gPiBJZ29yICA+ID4gTWFtbWVkb3YgID4gPiAgU2VudDogTW9u
ZGF5LCBPY3RvYmVyIDE0LCAyMDI0IDEwOjM4IEFNICA+DQo+ICA+ID4gPiAgPiA+ICBPbiBNb24s
IDE0IE9jdCAyMDI0IDE2OjUyOjU1ICswODAwICA+ID4gIG1hb2JpYm8NCj4gID4gPiA8bWFvYmli
b0Bsb29uZ3Nvbi5jbj4gd3JvdGU6DQo+ICA+ID4gID4gPg0KPiAgPiA+ICA+ID4gID4gSGkgU2Fs
aWwsDQo+ICA+ID4gID4gPiAgPg0KPiAgPiA+ICA+ID4gID4gV2hlbiBJIGRlYnVnIGNwdSBob3Rw
bHVnIG9uIExvb25nQXJjaCBzeXN0ZW0sIEl0IHJlcG9ydHMNCj4gID4gPiBlcnJvciBsaWtlDQo+
ICA+ID4gIHRoaXM6DQo+ICA+ID4gID4gPiAgPiAgICAgIEFDUEkgQklPUyBFcnJvciAoYnVnKTog
Q291bGQgbm90IHJlc29sdmUgc3ltYm9sDQo+ICBbXF9TQi5HRUQuQ1NDTl0sDQo+ICA+ID4gID4g
PiAgPiBBRV9OT1RfRk9VTkQNCj4gID4gPiAgPiA+ICA+ICAgICAgQUNQSSBFcnJvcjogQWJvcnRp
bmcgbWV0aG9kIFxfU0IuR0VELl9FVlQgZHVlIHRvIHByZXZpb3VzDQo+ICBlcnJvcg0KPiAgPiA+
ICA+ID4gID4gKEFFX05PVF9GT1VORCkNCj4gID4gPiAgPiA+ICA+ICAgICAgYWNwaS1nZWQgQUNQ
STAwMTM6MDA6IElSUSBtZXRob2QgZXhlY3V0aW9uIGZhaWxlZA0KPiAgPiA+ICA+ID4gID4NCj4g
ID4gPiAgPiA+ICA+DQo+ICA+ID4gID4gPiAgPiBXaXRoIHRoaXMgcGF0Y2gsIEdFRCBDUFUgY2Fs
bCBtZXRob2QgaXMgIlxcX1NCLkdFRC5DU0NOIiwNCj4gID4gPiBob3dldmVyICA+ID4gaW4gID4g
ZnVuY3Rpb24gYnVpbGRfY3B1c19hbWwoKSwgaXRzIG1ldGhvZCBuYW1lIGlzDQo+ICAiXFxfU0Iu
Q1BVUy5DU0NOIi4NCj4gID4gPiAgPiA+ICA+ICAgICAgbWV0aG9kID0gYW1sX21ldGhvZChldmVu
dF9oYW5kbGVyX21ldGhvZCwgMCwNCj4gID4gPiAgPiA+ICBBTUxfTk9UU0VSSUFMSVpFRCk7DQo+
ICA+ID4gID4gPiAgPiAgICAgIGFtbF9hcHBlbmQobWV0aG9kLCBhbWxfY2FsbDAoIlxcX1NCLkNQ
VVMuIg0KPiAgPiA+ICBDUFVfU0NBTl9NRVRIT0QpKTsNCj4gID4gPiAgPiA+ICA+ICAgICAgYW1s
X2FwcGVuZCh0YWJsZSwgbWV0aG9kKTsNCj4gID4gPiAgPiA+ICA+DQo+ICA+ID4gID4gPiAgPiBJ
dCBzZWVtcyB0aGF0IENQVSBzY2FubmluZyBtZXRob2QgbmFtZSBpcyBub3QgY29uc2lzdGVudA0K
PiAgPiA+IGJldHdlZW4gID4gPiA+IGZ1bmN0aW9uIGJ1aWxkX2NwdXNfYW1sKCkgYW5kIGJ1aWxk
X2dlZF9hbWwoKS4NCj4gID4gPiAgPiA+ICA+DQo+ICA+ID4gID4gPiAgPiBSZWdhcmRzDQo+ICA+
ID4gID4gPiAgPiBCaWJvIE1hbw0KPiAgPiA+ICA+ID4gID4NCj4gID4gPiAgPiA+ICA+IE9uIDIw
MjQvNy8yMyDkuIvljYg2OjU5LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+ICA+ID4gID4g
PiAgPiA+IEZyb206IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPiAgPiA+ICA+
ID4gT1NQTQ0KPiAgPiA+ID4gPiBldmFsdWF0ZXMgX0VWVCBtZXRob2QgdG8gbWFwIHRoZSBldmVu
dC4gVGhlIENQVSBob3RwbHVnICBldmVudA0KPiAgPiA+ID4gPiAgPiA+IGV2ZW50dWFsbHkgcmVz
dWx0cyBpbiBzdGFydCBvZiB0aGUgQ1BVIHNjYW4uIFNjYW4gZmlndXJlcw0KPiAgPiA+IG91dCB0
aGUgID4gID4gPiA+IENQVSBhbmQgdGhlIGtpbmQgb2YgID4gPiBldmVudChwbHVnL3VucGx1Zykg
YW5kDQo+ICA+ID4gbm90aWZpZXMgaXQgYmFjayAgPiA+IHRvIHRoZSBndWVzdC4gVXBkYXRlIHRo
ZSBHRUQgID4gPiBBTUwgX0VWVA0KPiAgPiA+IG1ldGhvZCB3aXRoIHRoZSBjYWxsIHRvICA+ID4g
bWV0aG9kIFxcX1NCLkNQVVMuQ1NDTiAodmlhICA+ID4NCj4gID4gPiBcXF9TQi5HRUQuQ1NDTikg
ID4gPiAgPiA+ICA+ID4gQXJjaGl0ZWN0dXJlIHNwZWNpZmljIGNvZGUgWzFdIG1pZ2h0DQo+ICA+
ID4gaW5pdGlhbGl6ZSBpdHMgQ1BVcyBBTUwgY29kZSBieSAgPiA+ID4gPiBjYWxsaW5nIGNvbW1v
biBmdW5jdGlvbg0KPiAgYnVpbGRfY3B1c19hbWwoKSBsaWtlIGJlbG93IGZvciBBUk06DQo+ICA+
ID4gID4gPiAgPiA+DQo+ICA+ID4gID4gPiAgPiA+IGJ1aWxkX2NwdXNfYW1sKHNjb3BlLCBtcywg
b3B0cywgeHhfbWFkdF9jcHVfZW50cnksICA+ID4NCj4gID4gPiBtZW1tYXBbVklSVF9DUFVIUF9B
Q1BJXS5iYXNlLA0KPiAgPiA+ICA+ID4gID4gPiAgICAgICAgICAgICAgICAgIlxcX1NCIiwgIlxc
X1NCLkdFRC5DU0NOIiwgQU1MX1NZU1RFTV9NRU1PUlkpOw0KPiAgPiA+ICA+ID4NCj4gID4gPiAg
PiA+ICBpdCBzaG91bGQgYmUgXFxfU0IuQ1BVUy5DU0NOICA+ICA+ICA+IEkgZ3Vlc3Mgd2UgYXJl
IGdldHRpbmcNCj4gID4gPiBiYWNrIHRvIHdoZXJlIHdlIHN0YXJ0ZWQgdGhlbj8NCj4gID4gPiAg
Pg0KPiAgPiA+ICA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtDQo+ICA+ID4gIGRldmVs
LzIwMjQwNzA2MTYyODQ1LjNiYWY1NTY4QGltYW1tZWRvLnVzDQo+ICA+ID4gID4gZXJzLmlwYS5y
ZWRoYXQuY29tLw0KPiAgPiA+ICA+DQo+ICA+ID4NCj4gID4gPiAgSW5kZWVkLCBDU0NOIGluIG5h
bWUgaGFkIG1lIGNvbmZ1c2VkLCAgcGVyaGFwcyBpdCB3b3VsZCBiZSBiZXR0ZXINCj4gID4gPiB0
byByZW5hbWUgdGhhdCBzb21ldGhpbmcgZWxzZS4NCj4gID4gPiAgbWF5YmUgc29tZXRoaW5nIGxp
a2Ugcy9fU0IuR0VELkNTQ04vX1NCLkdFRC5FQ1BVLw0KPiAgPg0KPiAgPg0KPiAgPiBTdXJlLCB3
ZSBjYW4gZGVmaW5pdGVseSBpbXByb3ZlLiBCdXQgd2UgYXJlIGluZGVlZCB0cmlnZ2VyaW5nIENQ
VSBTY2FuDQo+ICA+IGhlcmUgc28gSSBkb27igJl0IHVuZGVyc3RhbmQgaG93IHdpbGwgYEVDUFVg
IGJlIG1vcmUgaW50dWl0aXZlIHRoYW4NCj4gID4gYENTQ05gLiAgd2hhdCBhYm91dCBiZWxvdz8N
Cj4gID4NCj4gID4gcy9fU0IuR0VELkNTQ04vX1NCLkdFRC5DUFVTQ0FOLw0KPiAgDQo+ICBBQ1BJ
IG5hbWUgc2VnbWVudCBpcyBsaW1pdGVkIHRvIDQgY2hhcmFjdGVycyBvbmx5Lg0KDQpJIHNlZS4N
Cg0KDQo+ICANCj4gIEVDUFUgLSBFdmVudCBoYW5kbGVyIGZvciBDUFUNCj4gIGl0IGNvdWxkIGJl
IHNvbWV0aGluZyBlbHNlIHRob3VnaA0KPiAgDQo+ICB0aGUgcG9pbnQgaXMgbm90IGNvbmZ1c2Ug
aXQgd2l0aCBDU0NOIChhcHBhcmVudGx5IGRpZmZlcmVudCBuYW1lc3BhY2UgYnV0DQo+ICBzdGls
bCBpdCBjb3VsZCBsZWFkIHRvIGNvbmZ1c2lvbiBhcyBhYm92ZSBzaG93cyApDQoNCg0KTm8gcHJv
YmxlbS4gSSdsbCBzZW5kIGEgcGF0Y2ggdG9kYXkuDQoNClRoYW5rcyENCg0KDQo+ICANCj4gID4N
Cj4gID4NCj4gID4gVGhhbmtzDQo+ICA+IFNhbGlsLg0KPiAgPg0KPiAgPiA+DQo+ICA+ID4gID4g
RXhjZXJwdCBmcm9tIGFib3ZlIGRpc2N1c3Npb24gYW5kIHlvdXIgc3VnZ2VzdGlvbjoNCj4gID4g
PiAgPiBbLi4uXQ0KPiAgPiA+ICA+DQo+ICA+ID4gID4gSSBkb24ndCBwYXJ0aWN1bGFybHkgbGlr
ZSBleHBvc2luZyBjcHUgaG90cGx1ZyBpbnRlcm5hbHMgZm9yDQo+ICA+ID4gb3V0c2lkZSAgPiBj
b2RlIGFuZCB0aGVuIG1ha2luZyB0aGF0IGNvZGUgZG8gcGx1bWJpbmcgaG9waW5nIHRoYXQNCj4g
ID4gPiBub3RoaW5nIHdpbGwgID4gZXhwbG9kZSBpbiB0aGUgZnV0dXJlLg0KPiAgPiA+ICA+DQo+
ICA+ID4gID4gYnVpbGRfY3B1c19hbWwoKSB0YWtlcyBldmVudF9oYW5kbGVyX21ldGhvZCB0byBj
cmVhdGUgYSBtZXRob2QNCj4gID4gPiB0aGF0ICA+IGNhbiBiZSBjYWxsZWQgYnkgcGxhdGZvcm0u
IFdoYXQgSSBzdWdnZXN0IGlzIHRvIGNhbGwgdGhhdA0KPiAgPiA+IG1ldGhvZCBoZXJlICA+IGlu
c3RlYWQgb2YgdHJ5aW5nIHRvIGV4cG9zZSBDUFUgaG90cGx1ZyBpbnRlcm5hbHMgYW5kDQo+ICA+
ID4gbWFudWFsbHkgID4gYnVpbGRpbmcgY2FsbCBwYXRoIGhlcmUuDQo+ICA+ID4gID4gYWthOg0K
PiAgPiA+ICA+ICAgYnVpbGRfY3B1c19hbWwoZXZlbnRfaGFuZGxlcl9tZXRob2QgPQ0KPiAgPiA+
ICBQQVRIX1RPX0dFRF9ERVZJQ0UuQ1NDTikgYW5kDQo+ICA+ID4gID4gdGhlbiBjYWxsIGhlcmUN
Cj4gID4gPiAgPiAgIGFtbF9hcHBlbmQoaWZfY3R4LCBhbWxfY2FsbDAoQ1NDTikpOyB3aGljaCB3
aWxsIGNhbGwgIENTQ04gaW4gR0VEDQo+ICA+ID4gID4gc2NvcGUsIHRoYXQgd2FzIGJlIHBvcHVs
YXRlZCBieQ0KPiAgPiA+ICA+IGJ1aWxkX2NwdXNfYW1sKCkgdG8gZG8gY3B1IHNjYW4gcHJvcGVy
bHkgd2l0aG91dCBuZWVkIHRvIGV4cG9zZQ0KPiAgPiA+IGNwdSAgPiBob3RwbHVnIGludGVybmFs
IG5hbWVzIGFuZCB0aGVuIHRyeWluZyB0byBmaXh1cCBjb25mbGljdHMgY2F1c2VkDQo+ICBieSB0
aGF0Lg0KPiAgPiA+ICA+DQo+ICA+ID4gID4gUFM6DQo+ICA+ID4gID4gd2Ugc2hvdWxkIGRvIHRo
ZSBzYW1lIGZvciBtZW1vcnkgaG90cGx1Zywgd2Ugc2VlIGluIGNvbnRleHQgYWJvdmUNCj4gID4g
PiA+ICA+IFsuLi5dICA+ICA+ICA+IFNvbHV0aW9uOg0KPiAgPiA+ICA+IEkndmUgYXZvaWRlZCBh
Ym92ZSBlcnJvciBpbiBkaWZmZXJlbnQgd2F5IGFuZCBrZWVwaW5nIGV4YWN0bHkNCj4gID4gPiB3
aGF0IHlvdSAgPiBzdWdnZXN0ZWQgXF9TQi5QQVRIX1RPX0dFRF9ERVZJQ0UuQ1NDTiBpLmUuDQo+
ICA+ID4gXF9TQi5HRUQuQ1NDTiBQbGVhc2UgIGhhdmUgID4gYSBsb29rOg0KPiAgPiA+ICA+DQo+
ICA+ID4gID4NCj4gID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQx
MDA5MDMxODE1LjI1MDA5Ni0xNi1zYWxpbC5tZQ0KPiAgPiA+IGh0DQo+ICA+ID4gID4gYUBodWF3
ZWkuY29tLw0KPiAgPiA+ICA+DQo+ICA+ID4gID4gTWFueSB0aGFua3MhDQo+ICA+ID4gID4NCj4g
ID4gPiAgPg0KPiAgPiA+ICA+IEJlc3QgcmVnYXJkcw0KPiAgPiA+ICA+IFNhbGlsLg0KPiAgPiA+
ICA+DQo+ICA+ID4NCj4gID4NCj4gIA0KDQo=

