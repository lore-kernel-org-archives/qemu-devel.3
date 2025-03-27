Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EE9C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 11:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txlk5-0003tu-IJ; Thu, 27 Mar 2025 07:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangjinqian1@huawei.com>)
 id 1txlk2-0003sq-HV; Thu, 27 Mar 2025 07:49:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangjinqian1@huawei.com>)
 id 1txljz-0000vT-Sj; Thu, 27 Mar 2025 07:49:46 -0400
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZNhf74bwmz1jBVp;
 Thu, 27 Mar 2025 19:44:47 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
 by mail.maildlp.com (Postfix) with ESMTPS id 372E61402CD;
 Thu, 27 Mar 2025 19:49:28 +0800 (CST)
Received: from kwepemg100001.china.huawei.com (7.202.181.18) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 27 Mar 2025 19:49:27 +0800
Received: from kwepemg100001.china.huawei.com ([7.202.181.18]) by
 kwepemg100001.china.huawei.com ([7.202.181.18]) with mapi id 15.02.1544.011;
 Thu, 27 Mar 2025 19:49:27 +0800
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, lex Williamson
 <alex.williamson@redhat.com>
CC: "Wangzhou (B)" <wangzhou1@hisilicon.com>, liuyonglong
 <liuyonglong@huawei.com>, jiangkunkun <jiangkunkun@huawei.com>, "libai (G)"
 <libai12@huawei.com>, tangchengchang <tangchengchang@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: Re: Questions about vfio-pci
Thread-Topic: Questions about vfio-pci
Thread-Index: AdufDTdm4raav9tJRXuEMJF2Lkz38w==
Date: Thu, 27 Mar 2025 11:49:27 +0000
Message-ID: <04da2c1331e049c69d3fb3330403724d@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.121.183]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=yangjinqian1@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  yangjinqian <yangjinqian1@huawei.com>
From:  yangjinqian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiANCj4gSGVsbG8gSmlucWlhbg0KPiANCj4gT24gMy8yNS8yNSAwOTowMCwgeWFuZ2ppbnFpYW4g
dmlhIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4gSSdtIG9ic2VydmluZyBpbnRlcm1pdHRlbnQg
ZmFpbHVyZXMgd2hlbiBlbmFibGluZyB0aGUgSE5TMyBuZXR3b3JrDQo+ID4gcG9ydCBpbiBWTSB1
c2luZw0KPiA+DQo+ID4gUUVNVSB3aXRoIHRoZSBtYWlubGluZSBrZXJuZWwuDQo+IA0KPiANCj4g
V291bGQgeW91IG1pbmQgb3BlbmluZyBhIGdpdGxhYiBpc3N1ZSB3aXRoIG1vcmUgZGV0YWlscyBv
biB0aGUgY29udGV4dCwgaG9zdCwNCj4gZ3Vlc3QsIEhXID8NCj4gDQo+ICAgICBodHRwczovL2dp
dGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvDQo+IA0KPiBUaGFua3MsDQo+IA0K
PiBDLg0KPiANCj4gDQpIaSwgQ8OpZHJpYw0KDQpJJ3ZlIGFkZGVkIHRoZSBkZXRhaWxzIHRvIHRo
ZSBnaXRsYWIgaXNzdWUuDQoNCmh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8t
L2lzc3Vlcy8yODg0DQoNCnRoYW5rcywNCkppbnFpYW4NCj4gDQo+IA0KPiA+IEhOUzMgZHJpdmUg
aW4ga2VybmVsOg0KPiA+DQo+ID4gc3RhdGljIGludCBobnMzX25pY19uZXRfdXAoc3RydWN0IG5l
dF9kZXZpY2UgKm5ldGRldikNCj4gPg0KPiA+IHsNCj4gPg0KPiA+IC4uLi4uLg0KPiA+DQo+ID4g
IMKgwqDCoMKgwqDCoCAvKiBlbmFibGUgdGhlIHZlY3RvcnMgKi8NCj4gPg0KPiA+ICDCoMKgwqDC
oMKgwqAgZm9yIChpID0gMDsgaSA8IHZlY3Rvcl9udW07IGkrKykNCj4gPg0KPiA+IHsNCj4gPg0K
PiA+IG5hcGlfZW5hYmxlKG5hcGkpOw0KPiA+DQo+ID4gIMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKg
IGVuYWJsZV9pcnEodmVjdG9yX2lycSk7DQo+ID4NCj4gPiAgwqDCoMKgwqDCoMKgIMKgwqDCoMKg
wqAgaG5zM19tYXNrX3ZlY3Rvcl9pcnEodHFwX3ZlY3RvciwgMSk7DQo+ID4NCj4gPiAgwqDCoMKg
wqDCoMKgIH0NCj4gPg0KPiA+IC4uLi4uLg0KPiA+DQo+ID4gfQ0KPiA+DQo+ID4gV2hlbiB0aGUg
Vk0gaGFzIHR3byB2Q1BVcywgdGhlIGd1ZXN0IEhOUzMgZHJpdmVyIHBlcmZvcm1zIHR3bw0KPiA+
IHNlcXVlbnRpYWwNCj4gPg0KPiA+IGVuYWJsZV9pcnEgb3BlcmF0aW9ucyAodmVjdG9yX251bT0y
KS4gVGhlIGVuYWJsZV9pcnEgd2lsbCB0cmFwIGludG8NCj4gPiBLVk0gZm9yIGludGVycnVwdA0K
PiA+DQo+ID4gY29uZmlndXJhdGlvbiBhbmQgZXhpdCB0byBRRU1VIGZvciBQQ0kgZGV2aWNlIGVt
dWxhdGlvbi4gV2hlbg0KPiA+IGVtdWxhdGluZyBpbnRlcnJ1cHQNCj4gPg0KPiA+IGVuYWJsaW5n
IGluIFFFTVUsIHZmaW9fW2ludHgvbXNpL21zaXhdX2VuYWJsZSBjYWxscw0KPiA+IHZmaW9fZGlz
YWJsZV9pbnRlcnJ1cHRzIHRvIGRpc2FibGUNCj4gPg0KPiA+IGFsbCBpbnRlcnJ1cHRzIG9uIHRo
ZSB2ZGV2Lg0KPiA+DQo+ID4gVGhlIHF1ZXN0aW9ucyBhcmU6DQo+ID4NCj4gPiAxLldoeSBkb2Vz
IHRoZSB2ZmlvLXBjaSBkaXNhYmxlIGFsbCBpbnRlcnJ1cHRzIG9mIHRoZSBkZXZpY2UgYmVmb3Jl
IGVuYWJsaW5nDQo+IGlycXM/DQo+ID4NCj4gPiAyLklzIHRoaXMgYSBub3JtYWwgdmZpby1wY2kg
cHJvY2VzcyBvciBhIHByb2JsZW0/DQo+ID4NCj4gPiBUaGFua3MNCj4gPg0KPiA+IEppbnFpYW4N
Cj4gPg0KPiANCj4gV291bGQNCj4gDQoNCg==

