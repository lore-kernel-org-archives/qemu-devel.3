Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403BFC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 13:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbghK-0001QV-33; Wed, 07 Aug 2024 09:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sbghF-0001N5-90; Wed, 07 Aug 2024 09:27:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sbghA-0002yB-N0; Wed, 07 Aug 2024 09:27:20 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wf9qs3Db4z6K71N;
 Wed,  7 Aug 2024 21:24:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 5FF8C1400D9;
 Wed,  7 Aug 2024 21:27:03 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 14:27:02 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Wed, 7 Aug 2024 14:27:02 +0100
To: Gavin Shan <gshan@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8 Arch
Thread-Topic: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8
 Arch
Thread-Index: AQHaveq2F6TAeAWelEWGVYAetyN5RLIb0soAgABLdWA=
Date: Wed, 7 Aug 2024 13:27:02 +0000
Message-ID: <ed0a5631e0674c2aa4679f2388f40127@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <41fbfa5a-a10f-4ca0-8a52-e447043ff306@redhat.com>
In-Reply-To: <41fbfa5a-a10f-4ca0-8a52-e447043ff306@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.88]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgR2F2aW4sDQoNCkxldCBtZSBmaWd1cmUgb3V0IHRoaXMuIEhhdmUgeW91IGFsc28gaW5jbHVk
ZWQgdGhlIGJlbG93IHBhdGNoIGFsb25nIHdpdGggdGhlDQphcmNoaXRlY3R1cmUgYWdub3N0aWMg
cGF0Y2gtc2V0IGFjY2VwdGVkIGluIHRoaXMgUWVtdSBjeWNsZT8NCg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjQwODAxMTQyMzIyLjM5NDg4NjYtMy1wZXRlci5tYXlkZWxsQGxpbmFy
by5vcmcvDQoNCg0KVGhhbmtzDQpTYWxpbC4NCg0KPiAgRnJvbTogR2F2aW4gU2hhbiA8Z3NoYW5A
cmVkaGF0LmNvbT4NCj4gIFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDcsIDIwMjQgMTA6NTQgQU0N
Cj4gIFRvOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT47IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsNCj4gIHFlbXUtYXJtQG5vbmdudS5vcmc7IG1zdEByZWRoYXQuY29tDQo+ICAN
Cj4gIEhpIFNhbGlsLA0KPiAgDQo+ICBXaXRoIHRoaXMgc2VyaWVzIGFuZCBsYXRlc3QgdXBzdHJl
YW0gTGludXgga2VybmVsIChob3N0KSwgSSByYW4gaW50byBjb3JlDQo+ICBkdW1wIGFzIGJlbG93
Lg0KPiAgSSdtIG5vdCBzdXJlIGlmIGl0J3MgYSBrbm93biBpc3N1ZSBvciBub3QuDQo+ICANCj4g
ICMgdW5hbWUgLXINCj4gIDYuMTEuMC1yYzItZ2F2aW4rDQo+ICAjIC9ob21lL2dhdmluL3NhbmRi
b3gvcWVtdS5tYWluL2J1aWxkL3FlbXUtc3lzdGVtLWFhcmNoNjQgLWFjY2VsDQo+ICBrdm0gXA0K
PiAgICAgLW1hY2hpbmUgdmlydCxnaWMtdmVyc2lvbj1ob3N0LG52ZGltbT1vbiAtY3B1IGhvc3Qg
ICAgICAgICAgICAgICAgIFwNCj4gICAgIC1zbXAgbWF4Y3B1cz0yLGNwdXM9MSxzb2NrZXRzPTIs
Y2x1c3RlcnM9MSxjb3Jlcz0xLHRocmVhZHM9MSAgICAgICBcDQo+ICAgICAtbSA0MDk2TSxzbG90
cz0xNixtYXhtZW09MTI4RyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiAgICAgLW9iamVjdCBtZW1vcnktYmFja2VuZC1yYW0saWQ9bWVtMCxzaXplPTIwNDhNICAgICAg
ICAgICAgICAgICAgICAgIFwNCj4gICAgIC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtcmFtLGlkPW1l
bTEsc2l6ZT0yMDQ4TSAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAtbnVtYSBub2RlLG5v
ZGVpZD0wLG1lbWRldj1tZW0wLGNwdXM9MC0wICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiAgICAgLW51bWEgbm9kZSxub2RlaWQ9MSxtZW1kZXY9bWVtMSxjcHVzPTEtMSAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwNCj4gICAgICAgOg0KPiAgcWVtdS1zeXN0ZW0tYWFyY2g2NDogRmFp
bGVkIHRvIGluaXRpYWxpemUgaG9zdCB2Y3B1IDEgQWJvcnRlZCAoY29yZQ0KPiAgZHVtcGVkKQ0K
PiAgDQo+ICAjIGdkYiAvdmFyL2xpYi9zeXN0ZW1kL2NvcmVkdW1wL2NvcmUuMA0KPiAgL2hvbWUv
Z2F2aW4vc2FuZGJveC9xZW11Lm1haW4vYnVpbGQvcWVtdS1zeXN0ZW0tYWFyY2g2NA0KPiAgKGdk
YikgYnQNCj4gICMwICAweDAwMDBmZmZmOWVlYzQyZTggaW4gX19wdGhyZWFkX2tpbGxfaW1wbGVt
ZW50YXRpb24gKCkgYXQNCj4gIC9saWI2NC9saWJjLnNvLjYNCj4gICMxICAweDAwMDBmZmZmOWVl
N2M3M2MgaW4gcmFpc2UgKCkgYXQgL2xpYjY0L2xpYmMuc28uNg0KPiAgIzIgIDB4MDAwMGZmZmY5
ZWU2OTAzNCBpbiBhYm9ydCAoKSBhdCAvbGliNjQvbGliYy5zby42DQo+ICAjMyAgMHgwMDAwYWFh
YWM3MTE1MmMwIGluIGt2bV9hcm1fY3JlYXRlX2hvc3RfdmNwdQ0KPiAgKGNwdT0weGFhYWFlNGMw
Y2I4MCkNCj4gICAgICAgYXQgLi4vdGFyZ2V0L2FybS9rdm0uYzoxMDkzDQo+ICAjNCAgMHgwMDAw
YWFhYWM3MDU3NTIwIGluIG1hY2h2aXJ0X2luaXQgKG1hY2hpbmU9MHhhYWFhZTQ4MTk4YzApIGF0
DQo+ICAuLi9ody9hcm0vdmlydC5jOjI1MzQNCj4gICM1ICAweDAwMDBhYWFhYzZiMGQzMWMgaW4g
bWFjaGluZV9ydW5fYm9hcmRfaW5pdA0KPiAgICAgICAobWFjaGluZT0weGFhYWFlNDgxOThjMCwg
bWVtX3BhdGg9MHgwLCBlcnJwPTB4ZmZmZmY3NTRlZTM4KSBhdA0KPiAgLi4vaHcvY29yZS9tYWNo
aW5lLmM6MTU3Ng0KPiAgIzYgIDB4MDAwMGFhYWFjNmY1OGQ3MCBpbiBxZW11X2luaXRfYm9hcmQg
KCkgYXQgLi4vc3lzdGVtL3ZsLmM6MjYyMA0KPiAgIzcgIDB4MDAwMGFhYWFjNmY1OTBkYyBpbiBx
bXBfeF9leGl0X3ByZWNvbmZpZyAoZXJycD0weGFhYWFjODkxMTEyMA0KPiAgPGVycm9yX2ZhdGFs
PikNCj4gICAgICAgYXQgLi4vc3lzdGVtL3ZsLmM6MjcxMg0KPiAgIzggIDB4MDAwMGFhYWFjNmY1
YjcyOCBpbiBxZW11X2luaXQgKGFyZ2M9ODIsIGFyZ3Y9MHhmZmZmZjc1NGYxZDgpIGF0DQo+ICAu
Li9zeXN0ZW0vdmwuYzozNzU4DQo+ICAjOSAgMHgwMDAwYWFhYWM2YTUzMTVjIGluIG1haW4gKGFy
Z2M9ODIsIGFyZ3Y9MHhmZmZmZjc1NGYxZDgpIGF0DQo+ICAuLi9zeXN0ZW0vbWFpbi5jOjQ3DQo+
ICANCj4gIFRoYW5rcywNCj4gIEdhdmluDQo+ICANCg0K

