Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948C1C54E5D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 01:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkwCZ-0004Ji-HA; Thu, 14 Mar 2024 21:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1rkwCX-0004JG-Fa; Thu, 14 Mar 2024 21:17:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1rkwCU-0001Qd-MU; Thu, 14 Mar 2024 21:17:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TwmYq1S60z6K6Sd;
 Fri, 15 Mar 2024 09:17:03 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (unknown [7.191.160.210])
 by mail.maildlp.com (Postfix) with ESMTPS id AAF92140A36;
 Fri, 15 Mar 2024 09:16:57 +0800 (CST)
Received: from kwepemi500026.china.huawei.com (7.221.188.247) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 01:16:41 +0000
Received: from kwepemi500026.china.huawei.com ([7.221.188.247]) by
 kwepemi500026.china.huawei.com ([7.221.188.247]) with mapi id 15.01.2507.035; 
 Fri, 15 Mar 2024 09:16:39 +0800
To: Salil Mehta <salil.mehta@huawei.com>, "qemu-devel@nongnu.org"
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
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)"
 <wangyanan55@huawei.com>, "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "Wanghaibin (D)" <wanghaibin.wang@huawei.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>, yuzenghui <yuzenghui@huawei.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFY4IDYvOF0gcGh5c21lbTogQWRkIGhlbHBlciBmdW5j?=
 =?gb2312?Q?tion_to_destroy_CPU_AddressSpace?=
Thread-Topic: [PATCH V8 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Index: AQHadCFYAMQRhS7fMEqlDm9aYjar8rE4AmeQ
Date: Fri, 15 Mar 2024 01:16:39 +0000
Message-ID: <7bccde5479f044dc87679236b736b861@huawei.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-7-salil.mehta@huawei.com>
In-Reply-To: <20240312020000.12992-7-salil.mehta@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.187.224]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56; envelope-from=zhukeqian1@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  zhukeqian <zhukeqian1@huawei.com>
From:  zhukeqian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgU2FsaWwsDQoNClsuLi5dDQoNCit2b2lkIGNwdV9hZGRyZXNzX3NwYWNlX2Rlc3Ryb3koQ1BV
U3RhdGUgKmNwdSwgaW50IGFzaWR4KSB7DQorICAgIENQVUFkZHJlc3NTcGFjZSAqY3B1YXM7DQor
DQorICAgIGFzc2VydChjcHUtPmNwdV9hc2VzKTsNCisgICAgYXNzZXJ0KGFzaWR4ID49IDAgJiYg
YXNpZHggPCBjcHUtPm51bV9hc2VzKTsNCisgICAgLyogS1ZNIGNhbm5vdCBjdXJyZW50bHkgc3Vw
cG9ydCBtdWx0aXBsZSBhZGRyZXNzIHNwYWNlcy4gKi8NCisgICAgYXNzZXJ0KGFzaWR4ID09IDAg
fHwgIWt2bV9lbmFibGVkKCkpOw0KKw0KKyAgICBjcHVhcyA9ICZjcHUtPmNwdV9hc2VzW2FzaWR4
XTsNCisgICAgaWYgKHRjZ19lbmFibGVkKCkpIHsNCisgICAgICAgIG1lbW9yeV9saXN0ZW5lcl91
bnJlZ2lzdGVyKCZjcHVhcy0+dGNnX2FzX2xpc3RlbmVyKTsNCisgICAgfQ0KKw0KKyAgICBhZGRy
ZXNzX3NwYWNlX2Rlc3Ryb3koY3B1YXMtPmFzKTsNCisgICAgZ19mcmVlX3JjdShjcHVhcy0+YXMs
IHJjdSk7DQoNCkluIGFkZHJlc3Nfc3BhY2VfZGVzdHJveSgpLCBpdCBjYWxscyBjYWxsX3JjdTEo
KSBvbiBjcHVhcy0+YXMgd2hpY2ggd2lsbCBzZXQgZG9fYWRkcmVzc19zcGFjZV9kZXN0cm95KCkg
YXMgdGhlIHJjdSBmdW5jLg0KQW5kIGdfZnJlZV9yY3UoKSBhbHNvIGNhbGxzIGNhbGxfcmN1MSgp
IG9uIGNwdWFzLT5hcyB3aGljaCB3aWxsIG92ZXJ3cml0ZSB0aGUgcmN1IGZ1bmMgYXMgZ19mcmVl
KCkuDQoNClRoZW4gSSB0aGluayB0aGUgZ19mcmVlKCkgbWF5IGJlIGNhbGxlZCB0d2ljZSBpbiBy
Y3UgdGhyZWFkLCBwbGVhc2UgdmVyaWZ5IHRoYXQuDQoNClRoZSBzb3VyY2UgY29kZSBvZiBjYWxs
X3JjdTE6DQoNCnZvaWQgY2FsbF9yY3UxKHN0cnVjdCByY3VfaGVhZCAqbm9kZSwgdm9pZCAoKmZ1
bmMpKHN0cnVjdCByY3VfaGVhZCAqbm9kZSkpDQp7DQogICAgbm9kZS0+ZnVuYyA9IGZ1bmM7DQog
ICAgZW5xdWV1ZShub2RlKTsNCiAgICBxYXRvbWljX2luYygmcmN1X2NhbGxfY291bnQpOw0KICAg
IHFlbXVfZXZlbnRfc2V0KCZyY3VfY2FsbF9yZWFkeV9ldmVudCk7DQp9DQoNClRoYW5rcywNCktl
cWlhbg0KDQorDQorICAgIGlmIChhc2lkeCA9PSAwKSB7DQorICAgICAgICAvKiByZXNldCB0aGUg
Y29udmVuaWVuY2UgYWxpYXMgZm9yIGFkZHJlc3Mgc3BhY2UgMCAqLw0KKyAgICAgICAgY3B1LT5h
cyA9IE5VTEw7DQorICAgIH0NCisNCisgICAgaWYgKC0tY3B1LT5jcHVfYXNlc19jb3VudCA9PSAw
KSB7DQorICAgICAgICBnX2ZyZWUoY3B1LT5jcHVfYXNlcyk7DQorICAgICAgICBjcHUtPmNwdV9h
c2VzID0gTlVMTDsNCisgICAgfQ0KK30NCisNCiBBZGRyZXNzU3BhY2UgKmNwdV9nZXRfYWRkcmVz
c19zcGFjZShDUFVTdGF0ZSAqY3B1LCBpbnQgYXNpZHgpICB7DQogICAgIC8qIFJldHVybiB0aGUg
QWRkcmVzc1NwYWNlIGNvcnJlc3BvbmRpbmcgdG8gdGhlIHNwZWNpZmllZCBpbmRleCAqLw0KLS0N
CjIuMzQuMQ0KDQo=

