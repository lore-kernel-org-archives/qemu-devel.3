Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015FCC27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgM2-0002WA-4h; Thu, 30 May 2024 10:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sCgM0-0002Vy-Ev
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:02:04 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sCgLw-0007vy-6P
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:02:04 -0400
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Vqnrh2Rwlz1S8YX;
 Thu, 30 May 2024 21:57:56 +0800 (CST)
Received: from dggems706-chm.china.huawei.com (unknown [10.3.19.183])
 by mail.maildlp.com (Postfix) with ESMTPS id 1E5A318007F;
 Thu, 30 May 2024 22:01:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 22:01:26 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039; 
 Thu, 30 May 2024 15:01:23 +0100
To: "Liu, Yuan1" <yuan1.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm
 <linuxarm@huawei.com>, "linwenkai (C)" <linwenkai6@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, huangchenghai
 <huangchenghai2@huawei.com>
Subject: RE: [PATCH 1/7] docs/migration: add uadk compression feature
Thread-Topic: [PATCH 1/7] docs/migration: add uadk compression feature
Thread-Index: AQHasa1Ec5rdzCzKwE2A9W6CZA+a0bGvtXyAgAAVcDA=
Date: Thu, 30 May 2024 14:01:23 +0000
Message-ID: <e2637ebede1947d99549fe6db38325fb@huawei.com>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
 <20240529094435.11140-2-shameerali.kolothum.thodi@huawei.com>
 <PH7PR11MB59417BE6DD3AE194C24E8367A3F32@PH7PR11MB5941.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB59417BE6DD3AE194C24E8367A3F32@PH7PR11MB5941.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.28]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=shameerali.kolothum.thodi@huawei.com; helo=szxga08-in.huawei.com
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGl1LCBZdWFuMSA8eXVh
bjEubGl1QGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1heSAzMCwgMjAyNCAyOjI1IFBN
DQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRo
b2RpQGh1YXdlaS5jb20+Ow0KPiBwZXRlcnhAcmVkaGF0LmNvbTsgZmFyb3Nhc0BzdXNlLmRlDQo+
IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29t
PjsgbGlud2Vua2FpIChDKQ0KPiA8bGlud2Vua2FpNkBoaXNpbGljb24uY29tPjsgemhhbmdmZWku
Z2FvQGxpbmFyby5vcmc7IGh1YW5nY2hlbmdoYWkNCj4gPGh1YW5nY2hlbmdoYWkyQGh1YXdlaS5j
b20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMS83XSBkb2NzL21pZ3JhdGlvbjogYWRkIHVhZGsg
Y29tcHJlc3Npb24gZmVhdHVyZQ0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IFNoYW1lZXIgS29sb3RodW0gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVh
d2VpLmNvbT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIE1heSAyOSwgMjAyNCA1OjQ0IFBNDQo+ID4g
VG86IHBldGVyeEByZWRoYXQuY29tOyBmYXJvc2FzQHN1c2UuZGU7IExpdSwgWXVhbjEgPHl1YW4x
LmxpdUBpbnRlbC5jb20+DQo+ID4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgbGludXhhcm1A
aHVhd2VpLmNvbTsNCj4gbGlud2Vua2FpNkBoaXNpbGljb24uY29tOw0KPiA+IHpoYW5nZmVpLmdh
b0BsaW5hcm8ub3JnOyBodWFuZ2NoZW5naGFpMkBodWF3ZWkuY29tDQo+ID4gU3ViamVjdDogW1BB
VENIIDEvN10gZG9jcy9taWdyYXRpb246IGFkZCB1YWRrIGNvbXByZXNzaW9uIGZlYXR1cmUNCg0K
Wy4uLl0NCg0KPiA+ICtTaW5jZSBVQURLIHVzZXMgU2hhcmVkIFZpcnR1YWwgQWRkcmVzc2luZyhT
VkEpIGFuZCBkZXZpY2UgYWNjZXNzIHZpcnR1YWwNCj4gPiBtZW1vcnkNCj4gPiArZGlyZWN0bHkg
aXQgaXMgcG9zc2libGUgdGhhdCBTTU1VdjMgbWF5IGVub3VudGVyIHBhZ2UgZmF1bHRzIHdoaWxl
DQo+ID4gd2Fsa2luZyB0aGUNCj4gPiArSU8gcGFnZSB0YWJsZXMuIFRoaXMgbWF5IGltcGFjdCB0
aGUgcGVyZm9ybWFuY2UuIEluIG9yZGVyIHRvIG1pdGlnYXRlDQo+ID4gdGhpcywNCj4gPiArcGxl
YXNlIG1ha2Ugc3VyZSB0byBzcGVjaWZ5IGBgLW1lbS1wcmVhbGxvY2BgIHBhcmFtZXRlciB0byB0
aGUNCj4gPiBkZXN0aW5hdGlvbiBWTQ0KPiA+ICtib290IHBhcmFtZXRlcnMuDQo+IA0KPiBUaGFu
ayB5b3Ugc28gbXVjaCBmb3IgcHV0dGluZyB0aGUgSUFBIHNvbHV0aW9uIGF0IHRoZSB0b3AgYW5k
IGNjIG1lLg0KPiANCj4gSSB0aGluayBtaWdyYXRpb24gcGVyZm9ybWFuY2Ugd2lsbCBiZSBiZXR0
ZXIgd2l0aCAnLW1lbS1wcmVhbGxvYycgb3B0aW9uLA0KPiBidXQgSSBhbSBjb25zaWRlcmluZyB3
aGV0aGVyICctbWVtLXByZWFsbG9jJyBpcyBhIG1hbmRhdG9yeSBvcHRpb24sIGZyb20gbXkNCj4g
ZXhwZXJpZW5jZSwgU1ZBIHBlcmZvcm1hbmNlIGRyb3BzIG1haW5seSBjYXVzZWQgYnkgSU9UTEIg
Zmx1c2ggYW5kIElPIHBhZ2UNCj4gZmF1bHQsDQo+IEkgaGFkIHNvbWUgZGlzY3Vzc2lvbnMgd2l0
aCBQZXRlciBYdSBhYm91dCB0aGUgSU9UTEIgZmx1c2ggaXNzdWUsIGFuZCBpdCBoYXMNCj4gYmVl
biBpbXByb3ZlZC4NCj4gaHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VL1BIN1BSMTFNQjU5NDFGMDRG
QkZCOTY0Q0IyQzk2ODg2NkEzM0UyQA0KPiBQSDdQUjExTUI1OTQxLm5hbXByZDExLnByb2Qub3V0
bG9vay5jb20vDQoNClRoYW5rcyBmb3IgdGhlIGxpbmsuIFllcyBJIGhhdmUgc2VlbiB0aGF0IGRp
c2N1c3Npb24gYW5kIHRoaXMgc2VyaWVzIGlzIG9uIHRvcCBvZiAgdGhhdA0KcGF0Y2ggZm9yIGF2
b2lkaW5nIHRoZSB6ZXJvIHBhZ2UgcmVhZCBmYXVsdC4NCg0KPiANCj4gRm9yIElPIHBhZ2UgZmF1
bHQsIHRoZSBRUEwoSUFBIHVzZXJzcGFjZSBsaWJyYXJ5KSBjYW4gcHJvY2VzcyBwYWdlIGZhdWx0
DQo+IHJlcXVlc3QgaW5zdGVhZCBvZiBJT01NVSwNCg0KU29ycnkgSSBkaWRuJ3QgZ2V0IHRoaXMg
cGFydCBjb21wbGV0ZWx5LiBTbyBpZiB0aGUgcGFnZSBmYXVsdCBoYXBwZW5zIGhvdyB0aGUgbGli
cmFyeQ0KY2FuIGhhbmRsZSBpdCB3aXRob3V0IElPTU1VPyBPciB5b3UgbWVhbnQgbGlicmFyeSB3
aWxsIGRvIG1lbW9yeSBwZXJmZWN0aW5nIGJlZm9yZQ0KdG8gYXZvaWQgdGhlIHBhZ2UgZmF1bHQ/
DQoNCiBpdCBtZWFucyB3ZSBjYW4gZGlzYWJsZSB0aGUgSS9PIHBhZ2UgZmF1bHQgZmVhdHVyZQ0K
PiBvbiB0aGUgSUFBIGRldmljZSwgYW5kIGxldCB0aGUgZGV2aWNlIHN0aWxsIHVzZSBTVkEgdGVj
aG5vbG9neSB0byBhdm9pZCBtZW1vcnkNCj4gY29weS4NCj4gDQo+IEkgd2lsbCBwcm92aWRlIHRo
ZSB0ZXN0IHJlc3VsdHMgaW4gbXkgbmV4dCB2ZXJzaW9uLCBkbyB5b3UgaGF2ZSBhbnkgaWRlYXMg
b3INCj4gc3VnZ2VzdGlvbnMgYWJvdXQgdGhpcywgdGhhbmtzLg0KDQpJIHRoaW5rIG91ciBVQURL
IHRlc3QgdG9vbCBoYWQgYW4gb3B0aW9uIHRvIHByZWZlY3QgdGhlIG1lbW9yeSh3cml0ZSBzb21l
IHJhbmRvbSBkYXRhDQp0byBtZW1vcnkpIHRvIGF2b2lkIHBhZ2UgZmF1bHQgcGVuYWx0eS4gSSBh
bSBub3Qgc3VyZSB0aGF0IGlzIGV4cG9zZWQgdGhyb3VnaCB0aGUgQVBJIG9yIG5vdC4NCkkgd2ls
bCBjaGVjayB3aXRoIG91ciBVQURLIHRlYW0uDQoNClBsZWFzZSBkbyBDQyBtZSB3aGVuIHlvdSBw
b3N0IHlvdXIgbmV4dCByZXZpc2lvbi4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

