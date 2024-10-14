Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71C8D1813F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 20:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0RDw-0002Ky-Da; Mon, 14 Oct 2024 15:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0RDs-0002KI-9Q
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 15:59:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0RDo-0000gG-MA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 15:59:18 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS7H653VSz6LCXr;
 Tue, 15 Oct 2024 03:54:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 4B17C140B55;
 Tue, 15 Oct 2024 03:59:10 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 21:59:10 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 14 Oct 2024 21:59:10 +0200
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
Thread-Index: AQHa3O9tCa8bLr9rS0OXX2Adjxk3G7KGUYWAgADadNA=
Date: Mon, 14 Oct 2024 19:59:09 +0000
Message-ID: <30c0297bd01f48868694e47e18841fab@huawei.com>
References: <cover.1721731723.git.mst@redhat.com>
 <549c9a9dcbc1592ea79496f7b3ab234f366adeba.1721731723.git.mst@redhat.com>
 <ac9244d8-660a-ade6-9987-352c3c646a76@loongson.cn>
In-Reply-To: <ac9244d8-660a-ade6-9987-352c3c646a76@loongson.cn>
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
bnQ6IE1vbmRheSwgT2N0b2JlciAxNCwgMjAyNCA5OjUzIEFNDQo+ICBUbzogcWVtdS1kZXZlbEBu
b25nbnUub3JnOyBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gIENjOiBN
aWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiAgPHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWku
Y29tPjsNCj4gIHpodWtlcWlhbiA8emh1a2VxaWFuMUBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2Ft
ZXJvbg0KPiAgPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IEdhdmluIFNoYW4gPGdzaGFu
QHJlZGhhdC5jb20+Ow0KPiAgVmlzaG51IFBhamp1cmkgPHZpc2hudUBvcy5hbXBlcmVjb21wdXRp
bmcuY29tPjsgWGlhbmdsYWkgTGkNCj4gIDxsaXhpYW5nbGFpQGxvb25nc29uLmNuPjsgTWlndWVs
IEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+OyBTaGFvcWluDQo+ICBIdWFuZyA8c2hhaHVh
bmdAcmVkaGF0LmNvbT47IFpoYW8gTGl1IDx6aGFvMS5saXVAaW50ZWwuY29tPjsgSWdvcg0KPiAg
TWFtbWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+OyBBbmkgU2luaGEgPGFuaXNpbmhhQHJlZGhh
dC5jb20+DQo+ICBTdWJqZWN0OiBSZTogW1BVTEwgdjIgNDAvNjFdIGh3L2FjcGk6IFVwZGF0ZSBH
RUQgX0VWVCBtZXRob2QgQU1MIHdpdGgNCj4gIENQVSBzY2FuDQo+ICANCj4gIEhpIFNhbGlsLA0K
PiAgDQo+ICBXaGVuIEkgZGVidWcgY3B1IGhvdHBsdWcgb24gTG9vbmdBcmNoIHN5c3RlbSwgSXQg
cmVwb3J0cyBlcnJvciBsaWtlIHRoaXM6DQo+ICAgICAgIEFDUEkgQklPUyBFcnJvciAoYnVnKTog
Q291bGQgbm90IHJlc29sdmUgc3ltYm9sIFtcX1NCLkdFRC5DU0NOXSwNCj4gIEFFX05PVF9GT1VO
RA0KPiAgICAgICBBQ1BJIEVycm9yOiBBYm9ydGluZyBtZXRob2QgXF9TQi5HRUQuX0VWVCBkdWUg
dG8gcHJldmlvdXMgZXJyb3INCj4gIChBRV9OT1RfRk9VTkQpDQo+ICAgICAgIGFjcGktZ2VkIEFD
UEkwMDEzOjAwOiBJUlEgbWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQNCj4gIA0KPiAgDQo+ICBXaXRo
IHRoaXMgcGF0Y2gsIEdFRCBDUFUgY2FsbCBtZXRob2QgaXMgIlxcX1NCLkdFRC5DU0NOIiwgaG93
ZXZlciBpbg0KPiAgZnVuY3Rpb24gYnVpbGRfY3B1c19hbWwoKSwgaXRzIG1ldGhvZCBuYW1lIGlz
ICJcXF9TQi5DUFVTLkNTQ04iLg0KPiAgICAgICBtZXRob2QgPSBhbWxfbWV0aG9kKGV2ZW50X2hh
bmRsZXJfbWV0aG9kLCAwLA0KPiAgQU1MX05PVFNFUklBTElaRUQpOw0KPiAgICAgICBhbWxfYXBw
ZW5kKG1ldGhvZCwgYW1sX2NhbGwwKCJcXF9TQi5DUFVTLiIgQ1BVX1NDQU5fTUVUSE9EKSk7DQo+
ICAgICAgIGFtbF9hcHBlbmQodGFibGUsIG1ldGhvZCk7DQo+ICANCj4gIEl0IHNlZW1zIHRoYXQg
Q1BVIHNjYW5uaW5nIG1ldGhvZCBuYW1lIGlzIG5vdCBjb25zaXN0ZW50IGJldHdlZW4NCj4gIGZ1
bmN0aW9uIGJ1aWxkX2NwdXNfYW1sKCkgYW5kIGJ1aWxkX2dlZF9hbWwoKS4NCg0KDQpJIGJlbGll
dmUgeW91ciBxdWVzdGlvbiBzdGVtcyBmcm9tIHRoZSBmb2xsb3dpbmcgcGF0Y2ggSSd2ZSBzZW50
IHJlY2VudGx5Og0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQxMDA5
MDMxODE1LjI1MDA5Ni0xNi1zYWxpbC5tZWh0YUBodWF3ZWkuY29tLw0KDQpJ4oCZdmUgYWxyZWFk
eSBwcm9wb3NlZCBhIGZpeCBmb3IgdGhpcyBpc3N1ZS4gRG9lcyB0aGF0IG5vdCB3b3JrIGZvciB5
b3U/DQoNClRoYW5rcw0KU2FsaWwuDQoNCg0KPiAgDQo+ICBSZWdhcmRzDQo+ICBCaWJvIE1hbw0K
PiAgDQo+ICBPbiAyMDI0LzcvMjMg5LiL5Y2INjo1OSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Og0KPiAgPiBGcm9tOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gID4N
Cj4gID4gT1NQTSBldmFsdWF0ZXMgX0VWVCBtZXRob2QgdG8gbWFwIHRoZSBldmVudC4gVGhlIENQ
VSBob3RwbHVnIGV2ZW50DQo+ICA+IGV2ZW50dWFsbHkgcmVzdWx0cyBpbiBzdGFydCBvZiB0aGUg
Q1BVIHNjYW4uIFNjYW4gZmlndXJlcyBvdXQgdGhlIENQVQ0KPiAgPiBhbmQgdGhlIGtpbmQgb2YN
Cj4gID4gZXZlbnQocGx1Zy91bnBsdWcpIGFuZCBub3RpZmllcyBpdCBiYWNrIHRvIHRoZSBndWVz
dC4gVXBkYXRlIHRoZSBHRUQNCj4gID4gQU1MIF9FVlQgbWV0aG9kIHdpdGggdGhlIGNhbGwgdG8g
bWV0aG9kIFxcX1NCLkNQVVMuQ1NDTiAodmlhDQo+ICA+IFxcX1NCLkdFRC5DU0NOKQ0KPiAgPg0K
PiAgPiBBcmNoaXRlY3R1cmUgc3BlY2lmaWMgY29kZSBbMV0gbWlnaHQgaW5pdGlhbGl6ZSBpdHMg
Q1BVcyBBTUwgY29kZSBieQ0KPiAgPiBjYWxsaW5nIGNvbW1vbiBmdW5jdGlvbiBidWlsZF9jcHVz
X2FtbCgpIGxpa2UgYmVsb3cgZm9yIEFSTToNCj4gID4NCj4gID4gYnVpbGRfY3B1c19hbWwoc2Nv
cGUsIG1zLCBvcHRzLCB4eF9tYWR0X2NwdV9lbnRyeSwNCj4gIG1lbW1hcFtWSVJUX0NQVUhQX0FD
UEldLmJhc2UsDQo+ICA+ICAgICAgICAgICAgICAgICAiXFxfU0IiLCAiXFxfU0IuR0VELkNTQ04i
LCBBTUxfU1lTVEVNX01FTU9SWSk7DQo+ICA+DQo+ICA+IFsxXQ0KPiAgPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQwNjEzMjMzNjM5LjIwMjg5Ni0xMy1zYWxpbC5tZWh0
DQo+ICA+IGFAaHVhd2VpLmNvbS8NCj4gID4NCj4gID4gQ28tZGV2ZWxvcGVkLWJ5OiBLZXFpYW4g
Wmh1IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+DQo+ICA+IFNpZ25lZC1vZmYtYnk6IEtlcWlhbiBa
aHUgPHpodWtlcWlhbjFAaHVhd2VpLmNvbT4NCj4gID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICA+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBD
YW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+ICA+IFJldmlld2VkLWJ5OiBH
YXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPg0KPiAgPiBUZXN0ZWQtYnk6IFZpc2hudSBQYWpq
dXJpIDx2aXNobnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT4NCj4gID4gVGVzdGVkLWJ5OiBYaWFu
Z2xhaSBMaSA8bGl4aWFuZ2xhaUBsb29uZ3Nvbi5jbj4NCj4gID4gVGVzdGVkLWJ5OiBNaWd1ZWwg
THVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4NCj4gID4gUmV2aWV3ZWQtYnk6IFNoYW9xaW4g
SHVhbmcgPHNoYWh1YW5nQHJlZGhhdC5jb20+DQo+ICA+IFRlc3RlZC1ieTogWmhhbyBMaXUgPHpo
YW8xLmxpdUBpbnRlbC5jb20+DQo+ICA+IFJldmlld2VkLWJ5OiBJZ29yIE1hbW1lZG92IDxpbWFt
bWVkb0ByZWRoYXQuY29tPg0KPiAgPiBNZXNzYWdlLUlkOiA8MjAyNDA3MTYxMTE1MDIuMjAyMzQ0
LTUtc2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gID4gUmV2aWV3ZWQtYnk6IE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+ICA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+ICA+IC0tLQ0KPiAgPiAgIGluY2x1ZGUvaHcvYWNw
aS9nZW5lcmljX2V2ZW50X2RldmljZS5oIHwgMSArDQo+ICA+ICAgaHcvYWNwaS9nZW5lcmljX2V2
ZW50X2RldmljZS5jICAgICAgICAgfCAzICsrKw0KPiAgPiAgIDIgZmlsZXMgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspDQo+ICA+DQo+ICA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FjcGkvZ2Vu
ZXJpY19ldmVudF9kZXZpY2UuaA0KPiAgPiBiL2luY2x1ZGUvaHcvYWNwaS9nZW5lcmljX2V2ZW50
X2RldmljZS5oDQo+ICA+IGluZGV4IGUwOTFhYzIxMDguLjQwYWYzNTUwYjUgMTAwNjQ0DQo+ICA+
IC0tLSBhL2luY2x1ZGUvaHcvYWNwaS9nZW5lcmljX2V2ZW50X2RldmljZS5oDQo+ICA+ICsrKyBi
L2luY2x1ZGUvaHcvYWNwaS9nZW5lcmljX2V2ZW50X2RldmljZS5oDQo+ICA+IEBAIC04Nyw2ICs4
Nyw3IEBAIE9CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEFjcGlHZWRTdGF0ZSwNCj4gIEFDUElf
R0VEKQ0KPiAgPiAgICNkZWZpbmUgR0VEX0RFVklDRSAgICAgICJHRUQiDQo+ICA+ICAgI2RlZmlu
ZSBBTUxfR0VEX0VWVF9SRUcgIkVSRUciDQo+ICA+ICAgI2RlZmluZSBBTUxfR0VEX0VWVF9TRUwg
IkVTRUwiDQo+ICA+ICsjZGVmaW5lIEFNTF9HRURfRVZUX0NQVV9TQ0FOX01FVEhPRCAiXFxfU0Iu
R0VELkNTQ04iDQo+ICA+DQo+ICA+ICAgLyoNCj4gID4gICAgKiBQbGF0Zm9ybXMgbmVlZCB0byBz
cGVjaWZ5IHRoZSBHRUQgZXZlbnQgYml0bWFwIGRpZmYgLS1naXQNCj4gID4gYS9ody9hY3BpL2dl
bmVyaWNfZXZlbnRfZGV2aWNlLmMgYi9ody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmMNCj4g
ID4gaW5kZXggNDY0MTkzM2EwZi4uMTViNGMzZWJiZiAxMDA2NDQNCj4gID4gLS0tIGEvaHcvYWNw
aS9nZW5lcmljX2V2ZW50X2RldmljZS5jDQo+ICA+ICsrKyBiL2h3L2FjcGkvZ2VuZXJpY19ldmVu
dF9kZXZpY2UuYw0KPiAgPiBAQCAtMTA4LDYgKzEwOCw5IEBAIHZvaWQgYnVpbGRfZ2VkX2FtbChB
bWwgKnRhYmxlLCBjb25zdCBjaGFyICpuYW1lLA0KPiAgSG90cGx1Z0hhbmRsZXIgKmhvdHBsdWdf
ZGV2LA0KPiAgPiAgICAgICAgICAgICAgICAgICBhbWxfYXBwZW5kKGlmX2N0eCwgYW1sX2NhbGww
KE1FTU9SWV9ERVZJQ0VTX0NPTlRBSU5FUg0KPiAgIi4iDQo+ICA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVNT1JZX1NMT1RfU0NBTl9NRVRIT0QpKTsN
Cj4gID4gICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICA+ICsgICAgICAgICAgICBjYXNlIEFD
UElfR0VEX0NQVV9IT1RQTFVHX0VWVDoNCj4gID4gKyAgICAgICAgICAgICAgICBhbWxfYXBwZW5k
KGlmX2N0eCwNCj4gIGFtbF9jYWxsMChBTUxfR0VEX0VWVF9DUFVfU0NBTl9NRVRIT0QpKTsNCj4g
ID4gKyAgICAgICAgICAgICAgICBicmVhazsNCj4gID4gICAgICAgICAgICAgICBjYXNlIEFDUElf
R0VEX1BXUl9ET1dOX0VWVDoNCj4gID4gICAgICAgICAgICAgICAgICAgYW1sX2FwcGVuZChpZl9j
dHgsDQo+ICA+DQo+ICA+IGFtbF9ub3RpZnkoYW1sX25hbWUoQUNQSV9QT1dFUl9CVVRUT05fREVW
SUNFKSwNCj4gID4NCg0K

