Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1829C531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 15:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgQsd-00082b-9U; Tue, 20 Aug 2024 11:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sgQsb-00081L-QK; Tue, 20 Aug 2024 11:34:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sgQsY-0003eK-Rc; Tue, 20 Aug 2024 11:34:41 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WpD2f5ccNz6K9VG;
 Tue, 20 Aug 2024 23:31:22 +0800 (CST)
Received: from lhrpeml100005.china.huawei.com (unknown [7.191.160.25])
 by mail.maildlp.com (Postfix) with ESMTPS id 62AE0140B63;
 Tue, 20 Aug 2024 23:34:27 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100005.china.huawei.com (7.191.160.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 16:34:27 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Tue, 20 Aug 2024 16:34:27 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm
 <linuxarm@huawei.com>
Subject: RE: [PATCH RFC V3 24/29] target/arm: Add support of *unrealize*
 ARMCPU during vCPU Hot-unplug
Thread-Topic: [PATCH RFC V3 24/29] target/arm: Add support of *unrealize*
 ARMCPU during vCPU Hot-unplug
Thread-Index: AQHavev6H7OxF7zZK02qabf2MUOdZrIqaJGS///y5oCABJZOYP///iIAgAG9M6A=
Date: Tue, 20 Aug 2024 15:34:26 +0000
Message-ID: <7005be32578e46728e9d58ea9c64a7a8@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-25-salil.mehta@huawei.com>
 <87v800wkb1.fsf@draig.linaro.org>
 <CAFEAcA9A9Oq0nURkiLNWZNC=P7KQGyr8TjjfOmEq+squwF+xog@mail.gmail.com>
 <0059c598676a4b9d8e34b9c0dc62b09e@huawei.com>
 <CAFEAcA9jm8RD0FF4fo7YPCHwaC9FwEG0q1EYce-OmrD1J--iWw@mail.gmail.com>
In-Reply-To: <CAFEAcA9jm8RD0FF4fo7YPCHwaC9FwEG0q1EYce-OmrD1J--iWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.151.47]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SEkgUGV0ZXIsDQoNCj4gIEZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz4NCj4gIFNlbnQ6IE1vbmRheSwgQXVndXN0IDE5LCAyMDI0IDI6NDcgUE0NCj4gIFRvOiBT
YWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gIA0KPiAgT24gTW9uLCAxOSBB
dWcgMjAyNCBhdCAxMzo1OCwgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+
ICB3cm90ZToNCj4gID4NCj4gID4gSGkgUGV0ZXIsDQo+ICA+DQo+ICA+ID4gIEZyb206IFBldGVy
IE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gID4gPg0KPiAgPiA+ICBXZSBz
aG91bGRuJ3QgbmVlZCB0byBleHBsaWNpdGx5IGNhbGwgY3B1X2FkZHJlc3Nfc3BhY2VfZGVzdHJv
eSgpDQo+ICA+ID4gZnJvbSBhICB0YXJnZXQtc3BlY2lmaWMgdW5yZWFsaXplIGFueXdheTogd2Ug
Y2FuIGRvIGl0IGFsbCBmcm9tIHRoZQ0KPiAgPiA+IGJhc2UgY2xhc3MgKGFuZCBJICB0aGluayB0
aGlzIHdvdWxkIGZpeCBzb21lIGxlYWtzIGluIGN1cnJlbnQgY29kZQ0KPiAgPiA+IGZvciB0YXJn
ZXRzIHRoYXQgaG90LXVucGx1ZywgIHRob3VnaCBJIHNob3VsZCBjaGVjayB0aGF0KS4gT3RoZXJ3
aXNlDQo+ICA+ID4geW91IG5lZWQgdG8gZHVwbGljYXRlIGFsbCB0aGUgbG9naWMgZm9yICBmaWd1
cmluZyBvdXQgd2hpY2ggYWRkcmVzcw0KPiAgPiA+IHNwYWNlcyB3ZSBjcmVhdGVkIGluIHJlYWxp
emUsIHdoaWNoIGlzIGZyYWdpbGUgYW5kICBub3QgbmVjZXNzYXJ5DQo+ICA+ID4gd2hlbiBhbGwg
d2Ugd2FudCB0byBkbyBpcyAiZGVsZXRlIGV2ZXJ5IGFkZHJlc3Mgc3BhY2UgdGhlICBDUFUgb2Jq
ZWN0DQo+ICBoYXMiDQo+ICA+ID4gIGFuZCB3ZSB3YW50IHRvIGRvIHRoYXQgZm9yIGV2ZXJ5IHRh
cmdldCBhcmNoaXRlY3R1cmUgYWx3YXlzLg0KPiAgPg0KPiAgPg0KPiAgPiBBZ3JlZWQgYnV0IEkg
d291bGQgc3VnZ2VzdCB0byBtYWtlIGl0IG9wdGlvbmFsIGkuZS4gaW4gY2FzZQ0KPiAgPiBhcmNo
aXRlY3R1cmUgd2FudCB0byByZWxlYXNlIHRvIGZyb20gaXRzIGNvZGUuIEl0IHNob3VsZCBiZSBh
bGxvd2VkLg0KPiAgPiBUaGlzIGFsc28gZW5zdXJlcyBjbGFyaXR5IG9mIHRoZSBmbG93cywNCj4g
ID4NCj4gID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS0NCj4gIGRldmVsL2EzMDhlMWY0
ZjA2ZjRlM2FiNmFiNTFmMzUzNjAxZjQzQGh1DQo+ICA+IGF3ZWkuY29tLw0KPiAgDQo+ICBEbyB5
b3UgaGF2ZSBhbnkgY29uY3JldGUgZXhhbXBsZXMgd2hlcmUgYSB0YXJnZXQgYXJjaCB3b3VsZCB3
YW50IHRvDQo+ICBleHBsaWNpdGx5IHJlbGVhc2UgYW4gQVMgZnJvbSBpdHMgb3duIGNvZGU/IA0K
DQoNCk5vLCBJIGRvbuKAmXQgaGF2ZSBidXQgc29tZSBvZiB0aGUgcmVhc29ucyBJIHRob3VnaHQg
d2VyZToNCg0KMS4gT3JkZXIgb2YgZGVzdHJ1Y3Rpb24gb2YgYWRkcmVzcyBzcGFjZS4gQ2FuIGl0
IGJlIGRpZmZlcmVudCB0aGFuIHdoYXQgd2lsbDsgYmUgYXNzdW1lZCBpbiB0aGUgbG9vcD8NCjIu
IFdoYXQgaWYgc29tZXRoaW5nIG5lZWRzIHRvIGJlIGRvbmUgb3IgaGFuZGxlZCBiZWZvcmUgZGVz
dHJveWluZyBlYWNoIGFkZHJlc3Mgc3BhY2U/DQozLiB0aGUgZmxvdw0KDQoNClVubGVzcyB0aGVy
ZSdzIGEgcmVhbCB1c2UgY2FzZSBmb3INCj4gIGRvaW5nIHRoYXQsIEkgdGhpbmsgdGhhdCAiY29t
bW9uIGNvZGUgYWx3YXlzIGRvZXMgdGhlIGNsZWFudXAgb2YgdGhlIEFTZXMsDQo+ICBub3RoaW5n
IGVsc2UgZXZlciBkb2VzIiBpcyBhIHNpbXBsZSBkZXNpZ24gcnVsZSB0aGF0IGF2b2lkcyB0aGUg
bmVlZCBmb3INCj4gIHRhcmdldC1zcGVjaWZpYyBjb2RlIGFuZCBtZWFucyB3ZSBkb24ndCBuZWVk
IGNvbXBsaWNhdGVkIGhhbmRsaW5nIGZvcg0KPiAgInNvbWUgb2YgdGhlIEFTZXMgaW4gY3B1LT5j
cHVfYXNlcyBhcmUgbGl2ZSBhbmQgc29tZSBoYXZlIGJlZW4NCj4gIHJlbGVhc2VkIjoNCj4gIGVp
dGhlciB0aGUgQ1BVIGlzIHJlYWxpemVkIGFuZCB0aGV5J3JlIGFsbCB2YWxpZCwgb3IgZWxzZSB3
ZSdyZSBpbiB0aGUgcHJvY2VzcyBvZg0KPiAgdW5yZWFsaXppbmcgdGhlIENQVSBhbmQgd2UgZ2V0
IHJpZCBvZiB0aGVtIGFsbCBhdCBvbmNlLg0KDQpJIGRvbuKAmXQgaGF2ZSBoYXJkIG9waW5pb25z
IG9uIHRoaXMuIFlvdSBjYW4gc2hhcmUgdGhlIHBhdGNoLiBJJ2xsIHRlc3Qgd2l0aCBteSBicmFu
Y2gNCm9mIHZDUFUgaG90cGx1Zw0KDQpUaGFua3MNClNhbGlsLg0KDQo+ICANCj4gIHRoYW5rcw0K
PiAgLS0gUE1NDQo=

