Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BD9CFC27E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 09:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0e3W-0005h7-Aw; Tue, 15 Oct 2024 05:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0e3U-0005gx-OF
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:41:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0e3S-0006xy-Qm
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:41:28 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSTWr19B7z6J7lq;
 Tue, 15 Oct 2024 17:36:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 796441404F5;
 Tue, 15 Oct 2024 17:41:24 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 11:41:24 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 15 Oct 2024 11:41:24 +0200
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
Thread-Index: AQHa3O9tCa8bLr9rS0OXX2Adjxk3G7KGUYWAgAAMgQCAAM83sIAAwUeAgAAi7BA=
Date: Tue, 15 Oct 2024 09:41:24 +0000
Message-ID: <bb1fcf595ac04cac95bb3cc86ff9d242@huawei.com>
References: <cover.1721731723.git.mst@redhat.com>
 <549c9a9dcbc1592ea79496f7b3ab234f366adeba.1721731723.git.mst@redhat.com>
 <ac9244d8-660a-ade6-9987-352c3c646a76@loongson.cn>
 <20241014113740.6f8305be@imammedo.users.ipa.redhat.com>
 <f134c3491a4143269eb24d3023be82e6@huawei.com>
 <20241015113105.121216e5@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241015113105.121216e5@imammedo.users.ipa.redhat.com>
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

SEkgSWdvciwNCg0KPiAgRnJvbTogSWdvciBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT4N
Cj4gIFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTUsIDIwMjQgMTA6MzEgQU0NCj4gIFRvOiBTYWxp
bCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gIENjOiBtYW9iaWJvIDxtYW9iaWJv
QGxvb25nc29uLmNuPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBNaWNoYWVsDQo+ICBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz47DQo+ICB6aHVrZXFpYW4gPHpodWtlcWlhbjFAaHVhd2VpLmNvbT47IEpvbmF0aGFuIENh
bWVyb24NCj4gIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBHYXZpbiBTaGFuIDxnc2hh
bkByZWRoYXQuY29tPjsNCj4gIFZpc2hudSBQYWpqdXJpIDx2aXNobnVAb3MuYW1wZXJlY29tcHV0
aW5nLmNvbT47IFhpYW5nbGFpIExpDQo+ICA8bGl4aWFuZ2xhaUBsb29uZ3Nvbi5jbj47IE1pZ3Vl
bCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUuY29tPjsgU2hhb3Fpbg0KPiAgSHVhbmcgPHNoYWh1
YW5nQHJlZGhhdC5jb20+OyBaaGFvIExpdSA8emhhbzEubGl1QGludGVsLmNvbT47IEFuaSBTaW5o
YQ0KPiAgPGFuaXNpbmhhQHJlZGhhdC5jb20+DQo+ICBTdWJqZWN0OiBSZTogW1BVTEwgdjIgNDAv
NjFdIGh3L2FjcGk6IFVwZGF0ZSBHRUQgX0VWVCBtZXRob2QgQU1MIHdpdGgNCj4gIENQVSBzY2Fu
DQo+ICANCj4gIE9uIE1vbiwgMTQgT2N0IDIwMjQgMjA6MDU6NTggKzAwMDANCj4gIFNhbGlsIE1l
aHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPiB3cm90ZToNCj4gIA0KPiAgPiBIaSBJZ29yLA0K
PiAgPg0KPiAgPiA+ICBGcm9tOiBxZW11LWRldmVsLWJvdW5jZXMrc2FsaWwubWVodGE9aHVhd2Vp
LmNvbUBub25nbnUub3JnDQo+ICA8cWVtdS0NCj4gID4gPiBkZXZlbC1ib3VuY2VzK3NhbGlsLm1l
aHRhPWh1YXdlaS5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxmIE9mDQo+ICBJZ29yDQo+ICA+ID4g
TWFtbWVkb3YNCj4gID4gPiAgU2VudDogTW9uZGF5LCBPY3RvYmVyIDE0LCAyMDI0IDEwOjM4IEFN
DQo+ICA+ID4NCj4gID4gPiAgT24gTW9uLCAxNCBPY3QgMjAyNCAxNjo1Mjo1NSArMDgwMA0KPiAg
PiA+ICBtYW9iaWJvIDxtYW9iaWJvQGxvb25nc29uLmNuPiB3cm90ZToNCj4gID4gPg0KPiAgPiA+
ICA+IEhpIFNhbGlsLA0KPiAgPiA+ICA+DQo+ICA+ID4gID4gV2hlbiBJIGRlYnVnIGNwdSBob3Rw
bHVnIG9uIExvb25nQXJjaCBzeXN0ZW0sIEl0IHJlcG9ydHMgZXJyb3IgbGlrZQ0KPiAgdGhpczoN
Cj4gID4gPiAgPiAgICAgIEFDUEkgQklPUyBFcnJvciAoYnVnKTogQ291bGQgbm90IHJlc29sdmUg
c3ltYm9sIFtcX1NCLkdFRC5DU0NOXSwNCj4gID4gPiAgPiBBRV9OT1RfRk9VTkQNCj4gID4gPiAg
PiAgICAgIEFDUEkgRXJyb3I6IEFib3J0aW5nIG1ldGhvZCBcX1NCLkdFRC5fRVZUIGR1ZSB0byBw
cmV2aW91cyBlcnJvcg0KPiAgPiA+ICA+IChBRV9OT1RfRk9VTkQpDQo+ICA+ID4gID4gICAgICBh
Y3BpLWdlZCBBQ1BJMDAxMzowMDogSVJRIG1ldGhvZCBleGVjdXRpb24gZmFpbGVkDQo+ICA+ID4g
ID4NCj4gID4gPiAgPg0KPiAgPiA+ICA+IFdpdGggdGhpcyBwYXRjaCwgR0VEIENQVSBjYWxsIG1l
dGhvZCBpcyAiXFxfU0IuR0VELkNTQ04iLCBob3dldmVyDQo+ICA+ID4gaW4gID4gZnVuY3Rpb24g
YnVpbGRfY3B1c19hbWwoKSwgaXRzIG1ldGhvZCBuYW1lIGlzICJcXF9TQi5DUFVTLkNTQ04iLg0K
PiAgPiA+ICA+ICAgICAgbWV0aG9kID0gYW1sX21ldGhvZChldmVudF9oYW5kbGVyX21ldGhvZCwg
MCwNCj4gID4gPiAgQU1MX05PVFNFUklBTElaRUQpOw0KPiAgPiA+ICA+ICAgICAgYW1sX2FwcGVu
ZChtZXRob2QsIGFtbF9jYWxsMCgiXFxfU0IuQ1BVUy4iDQo+ICBDUFVfU0NBTl9NRVRIT0QpKTsN
Cj4gID4gPiAgPiAgICAgIGFtbF9hcHBlbmQodGFibGUsIG1ldGhvZCk7DQo+ICA+ID4gID4NCj4g
ID4gPiAgPiBJdCBzZWVtcyB0aGF0IENQVSBzY2FubmluZyBtZXRob2QgbmFtZSBpcyBub3QgY29u
c2lzdGVudCBiZXR3ZWVuDQo+ICA+ID4gPiBmdW5jdGlvbiBidWlsZF9jcHVzX2FtbCgpIGFuZCBi
dWlsZF9nZWRfYW1sKCkuDQo+ICA+ID4gID4NCj4gID4gPiAgPiBSZWdhcmRzDQo+ICA+ID4gID4g
QmlibyBNYW8NCj4gID4gPiAgPg0KPiAgPiA+ICA+IE9uIDIwMjQvNy8yMyDkuIvljYg2OjU5LCBN
aWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+ICA+ID4gID4gPiBGcm9tOiBTYWxpbCBNZWh0YSA8
c2FsaWwubWVodGFAaHVhd2VpLmNvbT4gID4gPiAgPiA+IE9TUE0NCj4gID4gPiBldmFsdWF0ZXMg
X0VWVCBtZXRob2QgdG8gbWFwIHRoZSBldmVudC4gVGhlIENQVSBob3RwbHVnICBldmVudCAgPiA+
DQo+ICA+ID4gZXZlbnR1YWxseSByZXN1bHRzIGluIHN0YXJ0IG9mIHRoZSBDUFUgc2Nhbi4gU2Nh
biBmaWd1cmVzIG91dCB0aGUgID4NCj4gID4gPiA+IENQVSBhbmQgdGhlIGtpbmQgb2YgID4gPiBl
dmVudChwbHVnL3VucGx1ZykgYW5kIG5vdGlmaWVzIGl0IGJhY2sNCj4gID4gPiB0byB0aGUgZ3Vl
c3QuIFVwZGF0ZSB0aGUgR0VEICA+ID4gQU1MIF9FVlQgbWV0aG9kIHdpdGggdGhlIGNhbGwgdG8N
Cj4gID4gPiBtZXRob2QgXFxfU0IuQ1BVUy5DU0NOICh2aWEgID4gPiBcXF9TQi5HRUQuQ1NDTikg
ID4gPiAgPiA+DQo+ICA+ID4gQXJjaGl0ZWN0dXJlIHNwZWNpZmljIGNvZGUgWzFdIG1pZ2h0IGlu
aXRpYWxpemUgaXRzIENQVXMgQU1MIGNvZGUgYnkNCj4gID4gPiA+ID4gY2FsbGluZyBjb21tb24g
ZnVuY3Rpb24gYnVpbGRfY3B1c19hbWwoKSBsaWtlIGJlbG93IGZvciBBUk06DQo+ICA+ID4gID4g
Pg0KPiAgPiA+ICA+ID4gYnVpbGRfY3B1c19hbWwoc2NvcGUsIG1zLCBvcHRzLCB4eF9tYWR0X2Nw
dV9lbnRyeSwNCj4gID4gPiBtZW1tYXBbVklSVF9DUFVIUF9BQ1BJXS5iYXNlLA0KPiAgPiA+ICA+
ID4gICAgICAgICAgICAgICAgICJcXF9TQiIsICJcXF9TQi5HRUQuQ1NDTiIsIEFNTF9TWVNURU1f
TUVNT1JZKTsNCj4gID4gPg0KPiAgPiA+ICBpdCBzaG91bGQgYmUgXFxfU0IuQ1BVUy5DU0NODQo+
ICA+DQo+ICA+DQo+ICA+IEkgZ3Vlc3Mgd2UgYXJlIGdldHRpbmcgYmFjayB0byB3aGVyZSB3ZSBz
dGFydGVkIHRoZW4/DQo+ICA+DQo+ICA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtDQo+
ICBkZXZlbC8yMDI0MDcwNjE2Mjg0NS4zYmFmNTU2OEBpbWFtbWVkby51cw0KPiAgPiBlcnMuaXBh
LnJlZGhhdC5jb20vDQo+ICA+DQo+ICANCj4gIEluZGVlZCwgQ1NDTiBpbiBuYW1lIGhhZCBtZSBj
b25mdXNlZCwNCj4gIHBlcmhhcHMgaXQgd291bGQgYmUgYmV0dGVyIHRvIHJlbmFtZSB0aGF0IHNv
bWV0aGluZyBlbHNlLg0KPiAgbWF5YmUgc29tZXRoaW5nIGxpa2Ugcy9fU0IuR0VELkNTQ04vX1NC
LkdFRC5FQ1BVLw0KDQoNClN1cmUsIHdlIGNhbiBkZWZpbml0ZWx5IGltcHJvdmUuIEJ1dCB3ZSBh
cmUgaW5kZWVkIHRyaWdnZXJpbmcgQ1BVIFNjYW4NCmhlcmUgc28gSSBkb27igJl0IHVuZGVyc3Rh
bmQgaG93IHdpbGwgYEVDUFVgIGJlIG1vcmUgaW50dWl0aXZlIHRoYW4NCmBDU0NOYC4gIHdoYXQg
YWJvdXQgYmVsb3c/DQoNCnMvX1NCLkdFRC5DU0NOL19TQi5HRUQuQ1BVU0NBTi8NCg0KDQpUaGFu
a3MNClNhbGlsLg0KDQo+ICANCj4gID4gRXhjZXJwdCBmcm9tIGFib3ZlIGRpc2N1c3Npb24gYW5k
IHlvdXIgc3VnZ2VzdGlvbjoNCj4gID4gWy4uLl0NCj4gID4NCj4gID4gSSBkb24ndCBwYXJ0aWN1
bGFybHkgbGlrZSBleHBvc2luZyBjcHUgaG90cGx1ZyBpbnRlcm5hbHMgZm9yIG91dHNpZGUNCj4g
ID4gY29kZSBhbmQgdGhlbiBtYWtpbmcgdGhhdCBjb2RlIGRvIHBsdW1iaW5nIGhvcGluZyB0aGF0
IG5vdGhpbmcgd2lsbA0KPiAgPiBleHBsb2RlIGluIHRoZSBmdXR1cmUuDQo+ICA+DQo+ICA+IGJ1
aWxkX2NwdXNfYW1sKCkgdGFrZXMgZXZlbnRfaGFuZGxlcl9tZXRob2QgdG8gY3JlYXRlIGEgbWV0
aG9kIHRoYXQNCj4gID4gY2FuIGJlIGNhbGxlZCBieSBwbGF0Zm9ybS4gV2hhdCBJIHN1Z2dlc3Qg
aXMgdG8gY2FsbCB0aGF0IG1ldGhvZCBoZXJlDQo+ICA+IGluc3RlYWQgb2YgdHJ5aW5nIHRvIGV4
cG9zZSBDUFUgaG90cGx1ZyBpbnRlcm5hbHMgYW5kIG1hbnVhbGx5DQo+ICA+IGJ1aWxkaW5nIGNh
bGwgcGF0aCBoZXJlLg0KPiAgPiBha2E6DQo+ICA+ICAgYnVpbGRfY3B1c19hbWwoZXZlbnRfaGFu
ZGxlcl9tZXRob2QgPQ0KPiAgUEFUSF9UT19HRURfREVWSUNFLkNTQ04pIGFuZA0KPiAgPiB0aGVu
IGNhbGwgaGVyZQ0KPiAgPiAgIGFtbF9hcHBlbmQoaWZfY3R4LCBhbWxfY2FsbDAoQ1NDTikpOyB3
aGljaCB3aWxsIGNhbGwgIENTQ04gaW4gR0VEDQo+ICA+IHNjb3BlLCB0aGF0IHdhcyBiZSBwb3B1
bGF0ZWQgYnkNCj4gID4gYnVpbGRfY3B1c19hbWwoKSB0byBkbyBjcHUgc2NhbiBwcm9wZXJseSB3
aXRob3V0IG5lZWQgdG8gZXhwb3NlIGNwdQ0KPiAgPiBob3RwbHVnIGludGVybmFsIG5hbWVzIGFu
ZCB0aGVuIHRyeWluZyB0byBmaXh1cCBjb25mbGljdHMgY2F1c2VkIGJ5IHRoYXQuDQo+ICA+DQo+
ICA+IFBTOg0KPiAgPiB3ZSBzaG91bGQgZG8gdGhlIHNhbWUgZm9yIG1lbW9yeSBob3RwbHVnLCB3
ZSBzZWUgaW4gY29udGV4dCBhYm92ZQ0KPiAgPg0KPiAgPiBbLi4uXQ0KPiAgPg0KPiAgPg0KPiAg
PiBTb2x1dGlvbjoNCj4gID4gSSd2ZSBhdm9pZGVkIGFib3ZlIGVycm9yIGluIGRpZmZlcmVudCB3
YXkgYW5kIGtlZXBpbmcgZXhhY3RseSB3aGF0IHlvdQ0KPiAgPiBzdWdnZXN0ZWQgXF9TQi5QQVRI
X1RPX0dFRF9ERVZJQ0UuQ1NDTiBpLmUuIFxfU0IuR0VELkNTQ04gUGxlYXNlDQo+ICBoYXZlDQo+
ICA+IGEgbG9vazoNCj4gID4NCj4gID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC8yMDI0MTAwOTAzMTgxNS4yNTAwOTYtMTYtc2FsaWwubWVodA0KPiAgPiBhQGh1YXdlaS5jb20v
DQo+ICA+DQo+ICA+IE1hbnkgdGhhbmtzIQ0KPiAgPg0KPiAgPg0KPiAgPiBCZXN0IHJlZ2FyZHMN
Cj4gID4gU2FsaWwuDQo+ICA+DQo+ICANCg0K

