Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE950C3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKsn-0006Sd-O7; Thu, 04 Jul 2024 07:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sPKsf-0006I1-DG; Thu, 04 Jul 2024 07:44:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sPKsc-0006DE-Bh; Thu, 04 Jul 2024 07:44:05 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFF9g1gQYz6K99n;
 Thu,  4 Jul 2024 19:41:59 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (unknown [7.191.160.210])
 by mail.maildlp.com (Postfix) with ESMTPS id 51A5B140B63;
 Thu,  4 Jul 2024 19:43:53 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 12:43:52 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Thu, 4 Jul 2024 12:43:52 +0100
To: Nicholas Piggin <npiggin@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
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
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, Linuxarm
 <linuxarm@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Shaoqin Huang <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: RE: [PATCH V13 3/8] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Thread-Topic: [PATCH V13 3/8] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Thread-Index: AQHauNIRAeRMruTFh0K+ZTjTNpSYCbHl+vuAgACeIgA=
Date: Thu, 4 Jul 2024 11:43:52 +0000
Message-ID: <5539e63ff2e8409f94edf210ad9d7a21@huawei.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-4-salil.mehta@huawei.com>
 <D2GF5O8SP4Q8.38I35G35K74OG@gmail.com>
In-Reply-To: <D2GF5O8SP4Q8.38I35G35K74OG@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.159.88]
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

SEkgTmljaywNCg0KPiAgRnJvbTogTmljaG9sYXMgUGlnZ2luIDxucGlnZ2luQGdtYWlsLmNvbT4N
Cj4gIFNlbnQ6IFRodXJzZGF5LCBKdWx5IDQsIDIwMjQgNDowMyBBTQ0KPiAgVG86IFNhbGlsIE1l
aHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiAg
cWVtdS1hcm1Abm9uZ251Lm9yZw0KPiAgDQo+ICBPbiBGcmkgSnVuIDcsIDIwMjQgYXQgOTo1NiBQ
TSBBRVNULCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gID4gQEAgLTQwMCw2ICs0MTEsMTIgQEAgc3Rh
dGljIHZvaWQgYWNwaV9nZWRfaW5pdGZuKE9iamVjdCAqb2JqKQ0KPiAgPiAgICAgIG1lbW9yeV9y
ZWdpb25faW5pdF9pbygmZ2VkX3N0LT5yZWdzLCBvYmosICZnZWRfcmVnc19vcHMsIGdlZF9zdCwN
Cj4gID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9BQ1BJX0dFRCAiLXJlZ3MiLCBB
Q1BJX0dFRF9SRUdfQ09VTlQpOw0KPiAgPiAgICAgIHN5c2J1c19pbml0X21taW8oc2JkLCAmZ2Vk
X3N0LT5yZWdzKTsNCj4gID4gKw0KPiAgPiArICAgIG1lbW9yeV9yZWdpb25faW5pdCgmcy0+Y29u
dGFpbmVyX2NwdWhwLCBPQkpFQ1QoZGV2KSwgImNwdWhwDQo+ICBjb250YWluZXIiLA0KPiAgPiAr
ICAgICAgICAgICAgICAgICAgICAgICBBQ1BJX0NQVV9IT1RQTFVHX1JFR19MRU4pOw0KPiAgPiAr
ICAgIHN5c2J1c19pbml0X21taW8oc2JkLCAmcy0+Y29udGFpbmVyX2NwdWhwKTsNCj4gID4gKyAg
ICBjcHVfaG90cGx1Z19od19pbml0KCZzLT5jb250YWluZXJfY3B1aHAsIE9CSkVDVChkZXYpLA0K
PiAgPiArICAgICAgICAgICAgICAgICAgICAgICAgJnMtPmNwdWhwX3N0YXRlLCAwKTsNCj4gID4g
IH0NCj4gIA0KPiAgQ291bGQgdGhlIEFDUEkgcGVyc2lzdGVudCBwcmVzZW5jZSBBUk0gcmVxdWly
ZXMgYmUgYSBwcm9wZXJ0eSBvZiB0aGUgQUNQSQ0KPiAgZGV2aWNlPw0KDQoNCkkgdGhpbmsgaXQg
aXMgbW9yZSBvZiBhIENQVSBwcm9wZXJ0eSByYXRoZXIgdGhhbiBhIEdFRCBkZXZpY2U/IA0KDQoN
Cj4gIA0KPiAgVGhhbmtzLA0KPiAgTmljaw0K

