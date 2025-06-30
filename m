Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669BCC7EE39
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 07:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW8gs-0006ri-1O; Mon, 30 Jun 2025 03:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uW8gg-0006Ur-TG; Mon, 30 Jun 2025 03:12:26 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uW8gc-0004V9-LR; Mon, 30 Jun 2025 03:12:22 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bVy2Y3MZgz6L55K;
 Mon, 30 Jun 2025 15:09:25 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 4BD1E1402EC;
 Mon, 30 Jun 2025 15:12:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 09:12:12 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 30 Jun 2025 09:12:12 +0200
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v5 00/11] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Thread-Topic: [PATCH v5 00/11] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Thread-Index: AQHb5C8S0d/fYPGiP0CF8356U8e6vbQW1lEAgAR9sXA=
Date: Mon, 30 Jun 2025 07:12:12 +0000
Message-ID: <942853c1cd54409480fa4136e45e7db8@huawei.com>
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <7a878419-d709-4da7-8b06-2c36a2b05287@redhat.com>
In-Reply-To: <7a878419-d709-4da7-8b06-2c36a2b05287@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBGcmlkYXksIEp1bmUgMjcsIDIwMjUgMTozNyBQ
TQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1
bS50aG9kaUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4gcWVtdS1kZXZlbEBu
b25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpnZ0BudmlkaWEuY29t
OyBuaWNvbGluY0BudmlkaWEuY29tOw0KPiBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJl
ZGhhdC5jb207IGltYW1tZWRvQHJlZGhhdC5jb207DQo+IG5hdGhhbmNAbnZpZGlhLmNvbTsgbW9j
aHNAbnZpZGlhLmNvbTsgc21vc3RhZmFAZ29vZ2xlLmNvbTsNCj4gZ3VzdGF2by5yb21lcm9AbGlu
YXJvLm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBXYW5nemhvdQ0KPiAoQikg
PHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsgamlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdl
aS5jb20+Ow0KPiBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+
Ow0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAw
LzExXSBody9hcm0vdmlydDogQWRkIHN1cHBvcnQgZm9yIHVzZXIgY3JlYXRhYmxlDQo+IFNNTVV2
MyBkZXZpY2UNCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiA2LzIzLzI1IDExOjQyIEFNLCBT
aGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEhpIEFsbCwNCj4gPg0KPiA+IENoYW5nZXMgZnJv
bSB2NDoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUwNjEzMTQ0
NDQ5LjYwMTU2LTEtDQo+IHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbS8NCj4g
Pg0KPiA+IE1ham9yIGNoYW5nZXMgZnJvbSB2NDoNCj4gdGhpcyB3aWxsIG5lZWQgYSByZXNwaW4g
YWZ0ZXIgbWVyZ2Ugb2YNCj4gZjVlYzc1MWVlNzBkwqAgaHcvYXJtL3ZpcnQ6IENoZWNrIGJ5cGFz
cyBpb21tdSBpcyBub3Qgc2V0IGZvciBpb21tdS1tYXANCj4gRFQgcHJvcGVydHkNCg0KWWVzLiBN
aXNzZWQgdGhhdC4gV2lsbCBkby4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQo=

