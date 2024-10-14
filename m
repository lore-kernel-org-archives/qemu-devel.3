Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58929D1813F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 20:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0RKU-00041A-4z; Mon, 14 Oct 2024 16:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0RKR-00040q-Rx
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 16:06:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0RKO-0001YR-Qy
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 16:06:07 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS7WV5W8mz6K8yJ;
 Tue, 15 Oct 2024 04:05:26 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id 5D51A140445;
 Tue, 15 Oct 2024 04:05:59 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 22:05:58 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 14 Oct 2024 22:05:58 +0200
To: Igor Mammedov <imammedo@redhat.com>, maobibo <maobibo@loongson.cn>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, zhukeqian
 <zhukeqian1@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Gavin Shan <gshan@redhat.com>, Vishnu Pajjuri
 <vishnu@os.amperecomputing.com>, Xianglai Li <lixianglai@loongson.cn>,
 "Miguel Luis" <miguel.luis@oracle.com>, Shaoqin Huang <shahuang@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>
Subject: RE: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with CPU scan
Thread-Topic: [PULL v2 40/61] hw/acpi: Update GED _EVT method AML with CPU scan
Thread-Index: AQHa3O9tCa8bLr9rS0OXX2Adjxk3G7KGUYWAgAAMgQCAAM83sA==
Date: Mon, 14 Oct 2024 20:05:58 +0000
Message-ID: <f134c3491a4143269eb24d3023be82e6@huawei.com>
References: <cover.1721731723.git.mst@redhat.com>
 <549c9a9dcbc1592ea79496f7b3ab234f366adeba.1721731723.git.mst@redhat.com>
 <ac9244d8-660a-ade6-9987-352c3c646a76@loongson.cn>
 <20241014113740.6f8305be@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241014113740.6f8305be@imammedo.users.ipa.redhat.com>
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

SGkgSWdvciwNCg0KPiAgRnJvbTogcWVtdS1kZXZlbC1ib3VuY2VzK3NhbGlsLm1laHRhPWh1YXdl
aS5jb21Abm9uZ251Lm9yZyA8cWVtdS0NCj4gIGRldmVsLWJvdW5jZXMrc2FsaWwubWVodGE9aHVh
d2VpLmNvbUBub25nbnUub3JnPiBPbiBCZWhhbGYgT2YgSWdvcg0KPiAgTWFtbWVkb3YNCj4gIFNl
bnQ6IE1vbmRheSwgT2N0b2JlciAxNCwgMjAyNCAxMDozOCBBTQ0KPiAgDQo+ICBPbiBNb24sIDE0
IE9jdCAyMDI0IDE2OjUyOjU1ICswODAwDQo+ICBtYW9iaWJvIDxtYW9iaWJvQGxvb25nc29uLmNu
PiB3cm90ZToNCj4gIA0KPiAgPiBIaSBTYWxpbCwNCj4gID4NCj4gID4gV2hlbiBJIGRlYnVnIGNw
dSBob3RwbHVnIG9uIExvb25nQXJjaCBzeXN0ZW0sIEl0IHJlcG9ydHMgZXJyb3IgbGlrZSB0aGlz
Og0KPiAgPiAgICAgIEFDUEkgQklPUyBFcnJvciAoYnVnKTogQ291bGQgbm90IHJlc29sdmUgc3lt
Ym9sIFtcX1NCLkdFRC5DU0NOXSwNCj4gID4gQUVfTk9UX0ZPVU5EDQo+ICA+ICAgICAgQUNQSSBF
cnJvcjogQWJvcnRpbmcgbWV0aG9kIFxfU0IuR0VELl9FVlQgZHVlIHRvIHByZXZpb3VzIGVycm9y
DQo+ICA+IChBRV9OT1RfRk9VTkQpDQo+ICA+ICAgICAgYWNwaS1nZWQgQUNQSTAwMTM6MDA6IElS
USBtZXRob2QgZXhlY3V0aW9uIGZhaWxlZA0KPiAgPg0KPiAgPg0KPiAgPiBXaXRoIHRoaXMgcGF0
Y2gsIEdFRCBDUFUgY2FsbCBtZXRob2QgaXMgIlxcX1NCLkdFRC5DU0NOIiwgaG93ZXZlciBpbg0K
PiAgPiBmdW5jdGlvbiBidWlsZF9jcHVzX2FtbCgpLCBpdHMgbWV0aG9kIG5hbWUgaXMgIlxcX1NC
LkNQVVMuQ1NDTiIuDQo+ICA+ICAgICAgbWV0aG9kID0gYW1sX21ldGhvZChldmVudF9oYW5kbGVy
X21ldGhvZCwgMCwNCj4gIEFNTF9OT1RTRVJJQUxJWkVEKTsNCj4gID4gICAgICBhbWxfYXBwZW5k
KG1ldGhvZCwgYW1sX2NhbGwwKCJcXF9TQi5DUFVTLiIgQ1BVX1NDQU5fTUVUSE9EKSk7DQo+ICA+
ICAgICAgYW1sX2FwcGVuZCh0YWJsZSwgbWV0aG9kKTsNCj4gID4NCj4gID4gSXQgc2VlbXMgdGhh
dCBDUFUgc2Nhbm5pbmcgbWV0aG9kIG5hbWUgaXMgbm90IGNvbnNpc3RlbnQgYmV0d2Vlbg0KPiAg
PiBmdW5jdGlvbiBidWlsZF9jcHVzX2FtbCgpIGFuZCBidWlsZF9nZWRfYW1sKCkuDQo+ICA+DQo+
ICA+IFJlZ2FyZHMNCj4gID4gQmlibyBNYW8NCj4gID4NCj4gID4gT24gMjAyNC83LzIzIOS4i+WN
iDY6NTksIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gID4gPiBGcm9tOiBTYWxpbCBNZWh0
YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gID4gPg0KPiAgPiA+IE9TUE0gZXZhbHVhdGVz
IF9FVlQgbWV0aG9kIHRvIG1hcCB0aGUgZXZlbnQuIFRoZSBDUFUgaG90cGx1Zw0KPiAgZXZlbnQN
Cj4gID4gPiBldmVudHVhbGx5IHJlc3VsdHMgaW4gc3RhcnQgb2YgdGhlIENQVSBzY2FuLiBTY2Fu
IGZpZ3VyZXMgb3V0IHRoZQ0KPiAgPiA+IENQVSBhbmQgdGhlIGtpbmQgb2YNCj4gID4gPiBldmVu
dChwbHVnL3VucGx1ZykgYW5kIG5vdGlmaWVzIGl0IGJhY2sgdG8gdGhlIGd1ZXN0LiBVcGRhdGUg
dGhlIEdFRA0KPiAgPiA+IEFNTCBfRVZUIG1ldGhvZCB3aXRoIHRoZSBjYWxsIHRvIG1ldGhvZCBc
XF9TQi5DUFVTLkNTQ04gKHZpYQ0KPiAgPiA+IFxcX1NCLkdFRC5DU0NOKQ0KPiAgPiA+DQo+ICA+
ID4gQXJjaGl0ZWN0dXJlIHNwZWNpZmljIGNvZGUgWzFdIG1pZ2h0IGluaXRpYWxpemUgaXRzIENQ
VXMgQU1MIGNvZGUgYnkNCj4gID4gPiBjYWxsaW5nIGNvbW1vbiBmdW5jdGlvbiBidWlsZF9jcHVz
X2FtbCgpIGxpa2UgYmVsb3cgZm9yIEFSTToNCj4gID4gPg0KPiAgPiA+IGJ1aWxkX2NwdXNfYW1s
KHNjb3BlLCBtcywgb3B0cywgeHhfbWFkdF9jcHVfZW50cnksDQo+ICBtZW1tYXBbVklSVF9DUFVI
UF9BQ1BJXS5iYXNlLA0KPiAgPiA+ICAgICAgICAgICAgICAgICAiXFxfU0IiLCAiXFxfU0IuR0VE
LkNTQ04iLCBBTUxfU1lTVEVNX01FTU9SWSk7DQo+ICANCj4gIGl0IHNob3VsZCBiZSBcXF9TQi5D
UFVTLkNTQ04NCg0KDQpJIGd1ZXNzIHdlIGFyZSBnZXR0aW5nIGJhY2sgdG8gd2hlcmUgd2Ugc3Rh
cnRlZCB0aGVuPw0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQwNzA2
MTYyODQ1LjNiYWY1NTY4QGltYW1tZWRvLnVzZXJzLmlwYS5yZWRoYXQuY29tLw0KDQoNCkV4Y2Vy
cHQgZnJvbSBhYm92ZSBkaXNjdXNzaW9uIGFuZCB5b3VyIHN1Z2dlc3Rpb246DQpbLi4uXQ0KDQpJ
IGRvbid0IHBhcnRpY3VsYXJseSBsaWtlIGV4cG9zaW5nIGNwdSBob3RwbHVnIGludGVybmFscyBm
b3Igb3V0c2lkZSBjb2RlDQphbmQgdGhlbiBtYWtpbmcgdGhhdCBjb2RlIGRvIHBsdW1iaW5nIGhv
cGluZyB0aGF0IG5vdGhpbmcgd2lsbCBleHBsb2RlDQppbiB0aGUgZnV0dXJlLg0KDQpidWlsZF9j
cHVzX2FtbCgpIHRha2VzIGV2ZW50X2hhbmRsZXJfbWV0aG9kIHRvIGNyZWF0ZSBhIG1ldGhvZCB0
aGF0DQpjYW4gYmUgY2FsbGVkIGJ5IHBsYXRmb3JtLiBXaGF0IEkgc3VnZ2VzdCBpcyB0byBjYWxs
IHRoYXQgbWV0aG9kIGhlcmUNCmluc3RlYWQgb2YgdHJ5aW5nIHRvIGV4cG9zZSBDUFUgaG90cGx1
ZyBpbnRlcm5hbHMgYW5kIG1hbnVhbGx5IGJ1aWxkaW5nDQpjYWxsIHBhdGggaGVyZS4NCmFrYToN
CiAgYnVpbGRfY3B1c19hbWwoZXZlbnRfaGFuZGxlcl9tZXRob2QgPSBQQVRIX1RPX0dFRF9ERVZJ
Q0UuQ1NDTikNCmFuZCB0aGVuIGNhbGwgaGVyZSANCiAgYW1sX2FwcGVuZChpZl9jdHgsIGFtbF9j
YWxsMChDU0NOKSk7DQp3aGljaCB3aWxsIGNhbGwgIENTQ04gaW4gR0VEIHNjb3BlLCB0aGF0IHdh
cyBiZSBwb3B1bGF0ZWQgYnkNCmJ1aWxkX2NwdXNfYW1sKCkgdG8gZG8gY3B1IHNjYW4gcHJvcGVy
bHkgd2l0aG91dCBuZWVkIHRvIGV4cG9zZQ0KY3B1IGhvdHBsdWcgaW50ZXJuYWwgbmFtZXMgYW5k
IHRoZW4gdHJ5aW5nIHRvIGZpeHVwIGNvbmZsaWN0cyBjYXVzZWQgYnkgdGhhdC4NCg0KUFM6DQp3
ZSBzaG91bGQgZG8gdGhlIHNhbWUgZm9yIG1lbW9yeSBob3RwbHVnLCB3ZSBzZWUgaW4gY29udGV4
dCBhYm92ZQ0KDQpbLi4uXQ0KDQoNClNvbHV0aW9uOg0KSSd2ZSBhdm9pZGVkIGFib3ZlIGVycm9y
IGluIGRpZmZlcmVudCB3YXkgYW5kIGtlZXBpbmcgZXhhY3RseSB3aGF0IHlvdQ0Kc3VnZ2VzdGVk
IFxfU0IuUEFUSF9UT19HRURfREVWSUNFLkNTQ04gaS5lLiBcX1NCLkdFRC5DU0NODQpQbGVhc2Ug
aGF2ZSBhIGxvb2s6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNDEw
MDkwMzE4MTUuMjUwMDk2LTE2LXNhbGlsLm1laHRhQGh1YXdlaS5jb20vDQoNCk1hbnkgdGhhbmtz
IQ0KDQoNCkJlc3QgcmVnYXJkcw0KU2FsaWwuDQoNCg==

