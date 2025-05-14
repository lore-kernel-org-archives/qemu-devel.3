Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F74C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFCTK-0006jb-6F; Wed, 14 May 2025 09:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uFCTH-0006gI-Fr; Wed, 14 May 2025 09:48:31 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uFCTE-0000OR-9S; Wed, 14 May 2025 09:48:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZyF3333rdz6H7jl;
 Wed, 14 May 2025 21:45:19 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id E8EF01400DC;
 Wed, 14 May 2025 21:48:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 May 2025 15:47:53 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 14 May 2025 15:47:53 +0200
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "maz@kernel.org"
 <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "sebott@redhat.com" <sebott@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>, "jdenemar@redhat.com"
 <jdenemar@redhat.com>
CC: "agraf@csgraf.de" <agraf@csgraf.de>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Thread-Topic: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Thread-Index: AQHbrVvRKlWe4qTsaku+jGkyYZoxlrPQu3UAgAGVOyA=
Date: Wed, 14 May 2025 13:47:52 +0000
Message-ID: <4fcfb4624f90491ebb238de76f04e4e5@huawei.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
 <dadc4acd-97c8-4647-9467-89cd1966a6f2@redhat.com>
In-Reply-To: <dadc4acd-97c8-4647-9467-89cd1966a6f2@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMTMsIDIwMjUgNDozMCBQ
TQ0KPiBUbzogQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+OyBlcmljLmF1Z2VyLnBy
b0BnbWFpbC5jb207IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc7IHFlbXUtYXJtQG5vbmdudS5v
cmc7IGt2bWFybUBsaXN0cy5saW51eC5kZXY7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsg
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gYWxleC5iZW5uZWVAbGluYXJvLm9yZzsg
bWF6QGtlcm5lbC5vcmc7IG9saXZlci51cHRvbkBsaW51eC5kZXY7DQo+IHNlYm90dEByZWRoYXQu
Y29tOyBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRo
b2RpQGh1YXdlaS5jb20+OyBhcm1icnVAcmVkaGF0LmNvbTsNCj4gYmVycmFuZ2VAcmVkaGF0LmNv
bTsgYWJvbG9nbmFAcmVkaGF0LmNvbTsgamRlbmVtYXJAcmVkaGF0LmNvbQ0KPiBDYzogYWdyYWZA
Y3NncmFmLmRlOyBzaGFodWFuZ0ByZWRoYXQuY29tOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4g
cGhpbG1kQGxpbmFyby5vcmc7IHBib256aW5pQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAwMC8xMF0ga3ZtL2FybTogSW50cm9kdWNlIGEgY3VzdG9taXphYmxlIGFhcmNoNjQN
Cj4gS1ZNIGhvc3QgbW9kZWwNCg0KWy4uLl0NCg0KPiA+IFdlIHN0aWxsIGhhdmUgdG8gZGVhbCB3
aXRoIE1JRFIvUkVWSURSL0FJRFIgZGlmZmVyZW5jZXMgYnkgZXhwbG9pdGluZw0KPiA+DQo+IGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xp
bnV4LmdpdC9jb21taXQ/aQ0KPiBkPWQzMDBiMDE2OGVhOGZkNTAyMmExNDEzYmQzN2FiNjNmNGU1
YTdkNGQNCj4gPiAoaW4gYSBkaWZmZXJlbnQgc2VyaWVzLikNCj4gU2hhbWVlciwgZG8geW91IHBs
YW4gdG8gY29udHJpYnV0ZSB0aGUgcWVtdSBpbnRlZ3JhdGlvbiBvZiB0aGlzIGZlYXR1cmUNCj4g
eW91IGRldmVsb3BwZWQgb24ga2VybmVsIHNpZGU7IG9yIGRvIHlvdSBhbGxvdyB1cyB0byBpbnRl
Z3JhdGUgaXQgaW4NCj4gdGhpcyBzZXJpZXM/DQoNClllcywgaXQncyBvbiBteSBUb0RvIGxpc3Qu
IEknbGwgZmlyc3QgZ28gdGhyb3VnaCB0aGlzIHNlcmllcyBhbmQgdGhlbiB3b3JrIG9uDQphZGRp
bmcgdGhlIGFib3ZlIHN1cHBvcnQgb24gdG9wIG9mIGl0Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoN
Cg==

