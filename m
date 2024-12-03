Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E460E64A85
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 12:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIRtj-0003U7-Bo; Tue, 03 Dec 2024 07:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1tIRth-0003Tu-JI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 07:20:57 -0500
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1tIRtf-000780-5g
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 07:20:57 -0500
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "eduardo@habkost.net" <eduardo@habkost.net>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/1] pcie-root-port: Fast PCIe root ports for new machine
Thread-Topic: [PATCH 1/1] pcie-root-port: Fast PCIe root ports for new machine
Thread-Index: AQHbRX2/fC8FNue/40yeOjgxK7k8Og==
Date: Tue, 3 Dec 2024 12:20:32 +0000
Message-ID: <404E454C-329D-456E-9F64-38DD650B9AD5@baidu.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.193.14]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9382370DB31EC94DA0BFACE7A853B3CB@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.45
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pg0KPiBUaGVyZSB3YXMgYSBxdWVzdGlvbiBmcm9tIEpvbmF0aGFuIENhbWVyb24gb24gdGhlIG9y
aWdpbmFsIHBvc3Rpbmcgb2YgdGhpcw0KPiBwYXRjaCB0aGF0IGlzIGF3YWl0aW5nIHlvdXIgYW5z
d2VyLi4uLg0KDQpTb3JyeSwgdGhlIHJlcGx5IGlzIGZvcmdvdHRlbiB0byBjYyBxZW11LWRldmVs
LCBJIGhhdmUgcmVzZW5kIGl0Lg0KDQo+DQo+DQo+IFJlZ2FyZGxlc3MsIGF0IHRoaXMgdGltZSBp
biB0aGUgcmVsZWFzZSBjeWNsZSBpdHMgdG9vIGxhdGUgZm9yIDkuMiwgc28gdGhpcw0KPiBwYXRj
aCB3b3VsZCBsaWtlbHkgbmVlZCB0byBiZSBhZGFwdGVkIGZvciB0aGUgMTAuMCByZWxlYXNlIGFu
ZCB0byB1c2UgdGhlDQo+IGh3X2NvbXBhdF85XzIgdGhhdCB3aWxsIHRoZW4gYmUgYWRkZWQuDQo+
DQoNClRoYW5rcywgSSdsbCBhZGFwdCBmb3IgdGhlIDEwLjAgcmVsZWFzZS4NCg0K

