Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C95BC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 18:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMWxf-0002MF-AY; Wed, 26 Jun 2024 14:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sMWxY-0002LG-Tv; Wed, 26 Jun 2024 14:01:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sMWxV-0001uD-LF; Wed, 26 Jun 2024 14:01:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W8TxB0ZSdz6K9LZ;
 Thu, 27 Jun 2024 01:59:42 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (unknown [7.191.162.67])
 by mail.maildlp.com (Postfix) with ESMTPS id C5C4E140A87;
 Thu, 27 Jun 2024 02:01:24 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 19:01:24 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Wed, 26 Jun 2024 19:01:24 +0100
To: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>
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
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
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
Subject: RE: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8 Arch
Thread-Topic: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8
 Arch
Thread-Index: AQHaveq2F6TAeAWelEWGVYAetyN5RLHZ0LIAgACXIUA=
Date: Wed, 26 Jun 2024 18:01:24 +0000
Message-ID: <e3668ef162b5428ba2422bb7607d20b4@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <3d4692d4-b802-4367-87f8-411a8a7b6b3f@amperemail.onmicrosoft.com>
In-Reply-To: <3d4692d4-b802-4367-87f8-411a8a7b6b3f@amperemail.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.33.18]
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

SGkgVmlzaG51LA0KIA0KPiBGcm9tOiBWaXNobnUgUGFqanVyaSA8dmlzaG51QGFtcGVyZW1haWwu
b25taWNyb3NvZnQuY29tPiANCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDI2LCAyMDI0IDEwOjUz
IEFNDQo+IFRvOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT47IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZzsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb20NCj4gDQo+
IEhpIFNhbGlsLA0KPiBPbiAxNC0wNi0yMDI0IDA1OjA2LCBTYWxpbCBNZWh0YSB3cm90ZToNCj4g
UFJPTE9HVUUNCj4gPT09PT09PT0NCj4gDQo+IFRvIGFzc2lzdCBpbiByZXZpZXcgYW5kIHNldCB0
aGUgcmlnaHQgZXhwZWN0YXRpb25zIGZyb20gdGhpcyBSRkMsIHBsZWFzZSBmaXJzdA0KPiByZWFk
IHRoZSBzZWN0aW9ucyAqQVBQRU5ERUQgQVQgVEhFIEVORCogb2YgdGhpcyBjb3ZlciBsZXR0ZXI6
DQo+IA0KPiAxLiBJbXBvcnRhbnQgKkRJU0NMQUlNRVIqIFtTZWN0aW9uIChYKV0NCj4gMi4gV29y
ayBwcmVzZW50ZWQgYXQgS1ZNRm9ydW0gQ29uZmVyZW5jZSAoc2xpZGVzIGF2YWlsYWJsZSkgW1Nl
Y3Rpb24gKFYpRl0NCj4gMy4gT3JnYW5pemF0aW9uIG9mIHBhdGNoZXMgW1NlY3Rpb24gKFhJKV0N
Cj4gNC4gUmVmZXJlbmNlcyBbU2VjdGlvbiAoWElJKV0NCj4gNS4gRGV0YWlsZWQgVE9ETyBsaXN0
IG9mIGxlZnRvdmVyIHdvcmsgb3Igd29yay1pbi1wcm9ncmVzcyBbU2VjdGlvbiAoSVgpXQ0KPiAN
Cj4gVGhlcmUgaGFzIGJlZW4gaW50ZXJlc3Qgc2hvd24gYnkgb3RoZXIgb3JnYW5pemF0aW9ucyBp
biBhZGFwdGluZyB0aGlzIHNlcmllcw0KPiBmb3IgdGhlaXIgYXJjaGl0ZWN0dXJlLiBIZW5jZSwg
UkZDIFYyIFsyMV0gaGFzIGJlZW4gc3BsaXQgaW50byBhcmNoaXRlY3R1cmUNCj4gKmFnbm9zdGlj
KiBbMjJdIGFuZCAqc3BlY2lmaWMqIHBhdGNoIHNldHMuDQo+IA0KPiBUaGlzIGlzIGFuIEFSTSBh
cmNoaXRlY3R1cmUtc3BlY2lmaWMgcGF0Y2ggc2V0IGNhcnZlZCBvdXQgb2YgUkZDIFYyLiBQbGVh
c2UNCj4gY2hlY2sgc2VjdGlvbiAoWEkpQiBmb3IgZGV0YWlscyBvZiBhcmNoaXRlY3R1cmUgYWdu
b3N0aWMgcGF0Y2hlcy4NCj4gDQo+IFNFQ1RJT05TIFtJIC0gWElJSV0gYXJlIGFzIGZvbGxvd3M6
DQo+IA0KPiAoSSkgS2V5IENoYW5nZXMgW2RldGFpbHMgaW4gbGFzdCBzZWN0aW9uIChYSVYpXQ0K
PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IA0KPiBS
RkMgVjIgLT4gUkZDIFYzDQo+IA0KPiAxLiBTcGxpdCBpbnRvIEFyY2hpdGVjdHVyZSAqYWdub3N0
aWMqIChWMTMpIFsyMl0gYW5kICpzcGVjaWZpYyogKFJGQyBWMykgcGF0Y2ggc2V0cy4NCj4gMi4g
QWRkcmVzc2VkIGNvbW1lbnRzIGJ5IEdhdmluIFNoYW4gKFJlZEhhdCksIFNoYW9xaW4gSHVhbmcg
KFJlZEhhdCksIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIChMaW5hcm8pLA0KPiA+IEpvbmF0aGFu
IENhbWVyb24gKEh1YXdlaSksIFpoYW8gTGl1IChJbnRlbCkuDQo+IEkgdHJpZWQgZm9sbG93aW5n
IHRlc3QgY2FzZXMgd2l0aCByZmMtdjMgYW5kIGtlcm5lbCBwYXRjaGVzIHYxMCwgYW5kIGl0J3Mg
bG9va2luZyBnb29kIG9uIEFtcGVyZSBwbGF0Zm9ybXMuDQo+IOKAoiBSZWd1bGFyIGhvdHBsdWcg
YW5kIGhvdCB1bnBsdWcgdGVzdHMNCj4g4oCiIExpdmUgbWlncmF0aW9uIHdpdGggYW5kIHdpdGgg
b3V0IGhvdC1wbHVnZ2luZyB2Y3B1cyB0ZXN0cw0KPiBQbGVhc2UgZmVlbCBmcmVlIHRvIGFkZCwN
Cj4gVGVzdGVkLWJ5OiBWaXNobnUgUGFqanVyaSBtYWlsdG86dmlzaG51QG9zLmFtcGVyZWNvbXB1
dGluZy5jb20NCg0KDQpNYW55IHRoYW5rcyBmb3IgdGVzdGluZyBhbmQgY29uZmlybWluZyB0aGUg
ZnVuY3Rpb25hbGl0eS4gUmVhbGx5IGFwcHJlY2lhdGUgdGhpcyENCg0KQmVzdA0KU2FsaWwuDQoN
Cg0KPiANCj4gUmVnYXJkcywNCj4gLVZpc2hudS4NCj4gDQo+IFJGQyBWMSAtPiBSRkMgVjINCj4g
DQo=

