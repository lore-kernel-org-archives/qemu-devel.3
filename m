Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3038EC1E9A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 10:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnx4G-000144-TH; Thu, 05 Feb 2026 05:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1vnx4E-00012Y-7P
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:58:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1vnx4B-00006s-8U
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:58:33 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6Dh23fDCzJ46ly;
 Thu,  5 Feb 2026 18:57:22 +0800 (CST)
Received: from dubpeml100006.china.huawei.com (unknown [7.214.145.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 0FF2040570;
 Thu,  5 Feb 2026 18:58:13 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (7.214.146.94) by
 dubpeml100006.china.huawei.com (7.214.145.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 5 Feb 2026 10:58:12 +0000
Received: from dubpeml500008.china.huawei.com ([7.214.146.94]) by
 dubpeml500008.china.huawei.com ([7.214.146.94]) with mapi id 15.02.1544.011;
 Thu, 5 Feb 2026 10:58:12 +0000
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
CC: Michael Tsirkin <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, Linuxarm
 <linuxarm@huawei.com>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, Ravi Shankar <venkataravis@micron.com>
Subject: RE: [PATCH qemu v4 3/5] hw/cxl/events: Updates for rev3.2 general
 media event record
Thread-Topic: [PATCH qemu v4 3/5] hw/cxl/events: Updates for rev3.2 general
 media event record
Thread-Index: AQHciTUr4LxvIobS5kmrIl1k4W36E7VzK8UAgADdjxA=
Date: Thu, 5 Feb 2026 10:58:12 +0000
Message-ID: <36df3469e1ac47d2a0474329a0f3c47c@huawei.com>
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com>
 <20260119111542.788389-4-Jonathan.Cameron@huawei.com>
 <CALa+Y15jKXUH=9k5aBveN4WN0AK1QW6VHGLHTVVgTF+-2hXvhA@mail.gmail.com>
In-Reply-To: <CALa+Y15jKXUH=9k5aBveN4WN0AK1QW6VHGLHTVVgTF+-2hXvhA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.158.31]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Shiju Jose <shiju.jose@huawei.com>
From:  Shiju Jose via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJhdmkgSm9ubmFsYWdhZGRh
IDxyYXZpcy5vcGVuc3JjQGdtYWlsLmNvbT4NCj5TZW50OiAwNCBGZWJydWFyeSAyMDI2IDIxOjQy
DQo+VG86IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT4NCj5D
YzogTWljaGFlbCBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
ZzsgU2hpanUgSm9zZQ0KPjxzaGlqdS5qb3NlQGh1YXdlaS5jb20+OyBhcm1icnVAcmVkaGF0LmNv
bTsgTGludXhhcm0NCj48bGludXhhcm1AaHVhd2VpLmNvbT47IGxpbnV4LWN4bEB2Z2VyLmtlcm5l
bC5vcmc7IFJhdmkgU2hhbmthcg0KPjx2ZW5rYXRhcmF2aXNAbWljcm9uLmNvbT4NCj5TdWJqZWN0
OiBSZTogW1BBVENIIHFlbXUgdjQgMy81XSBody9jeGwvZXZlbnRzOiBVcGRhdGVzIGZvciByZXYz
LjIgZ2VuZXJhbA0KPm1lZGlhIGV2ZW50IHJlY29yZA0KPg0KPk9uIE1vbiwgSmFuIDE5LCAyMDI2
IGF0IDM6MjHigK9BTSBKb25hdGhhbiBDYW1lcm9uDQo+PEpvbmF0aGFuLkNhbWVyb25AaHVhd2Vp
LmNvbT4gd3JvdGU6DQo+Pg0KPj4gRnJvbTogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWku
Y29tPg0KPj4NCj4+IENYTCBzcGVjIHJldjMuMiBzZWN0aW9uIDguMi4xMC4yLjEuMSBUYWJsZSA4
LTU3LCBnZW5lcmFsIG1lZGlhIGV2ZW50DQo+PiB0YWJsZSBoYXMgdXBkYXRlZCB3aXRoIGZvbGxv
d2luZyBuZXcgZmllbGRzLg0KPj4gMS4gQWR2YW5jZWQgUHJvZ3JhbW1hYmxlIENvcnJlY3RlZCBN
ZW1vcnkgRXJyb3IgVGhyZXNob2xkIEV2ZW50IEZsYWdzDQo+PiAyLiBDb3JyZWN0ZWQgTWVtb3J5
IEVycm9yIENvdW50IGF0IEV2ZW50IDMuIE1lbW9yeSBFdmVudCBTdWItVHlwZSA0Lg0KPj4gU3Vw
cG9ydCBmb3IgY29tcG9uZW50IElEIGluIHRoZSBQTERNIGZvcm1hdC4NCj4+DQo+PiBBZGQgdXBk
YXRlcyBmb3IgdGhlIGFib3ZlIHNwZWMgY2hhbmdlcyBpbiB0aGUgQ1hMIGdlbmVyYWwgbWVkaWEg
ZXZlbnQNCj4+IHJlcG9ydGluZyBhbmQgUU1QIGNvbW1hbmQgdG8gaW5qZWN0IGdlbmVyYWwgbWVk
aWEgZXZlbnQuDQo+Pg0KPj4gSW4gb3JkZXIgdG8gaGF2ZSBvbmUgY29uc2lzdGVudCBzb3VyY2Ug
b2YgcmVmZXJlbmNlcywgdXBkYXRlIGFsbCB0bw0KPj4gcmVmZXJlbmNlcyBmb3IgdGhpcyBjb21t
YW5kIHRvIENYTCByMy4yLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoaWp1IEpvc2UgPHNoaWp1
Lmpvc2VAaHVhd2VpLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpv
bmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4+IC0tLQ0KPj4gdjQ6IFVwZGF0ZSB0aGUgc3Bl
YyByZWZlcmVuY2UgaW4gdGhlIHJlbGF0ZWQgY29tbWFuZCB0byAzLjIgYXMgd2VsbC4NCj4+IChN
YXJrdXMpDQo+PiB2MzogVXBkYXRlIGFsbCByZWZlcmVuY2VzIHRvIDMuMiBmb3IgY29uc2lzdGVu
Y3kuDQo+PiAtLS0NCj4+ICBxYXBpL2N4bC5qc29uICAgICAgICAgICAgICAgfCAyOSArKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLQ0KPj4gIGluY2x1ZGUvaHcvY3hsL2N4bF9ldmVudHMuaCB8
ICA3ICsrKysrLS0NCj4+ICBody9tZW0vY3hsX3R5cGUzLmMgICAgICAgICAgfCAyOSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4gIGh3L21lbS9jeGxfdHlwZTNfc3R1YnMuYyAgICB8
ICA2ICsrKysrKw0KPj4gIDQgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3FhcGkvY3hsLmpzb24gYi9xYXBpL2N4bC5q
c29uIGluZGV4DQo+PiA4MjAwMWMwNTkxZDguLjRmZjY2ZmM2YzE2YyAxMDA2NDQNCj4+IC0tLSBh
L3FhcGkvY3hsLmpzb24NCj4+ICsrKyBiL3FhcGkvY3hsLmpzb24NCj4+DQo+PiAgICAgIHN0d19s
ZV9wKCZnZW0udmFsaWRpdHlfZmxhZ3MsIHZhbGlkX2ZsYWdzKTsNCj4+DQo+PiArICAgIGlmICho
YXNfY21lX2V2X2ZsYWdzKSB7DQo+PiArICAgICAgICBnZW0uY21lX2V2X2ZsYWdzID0gY21lX2V2
X2ZsYWdzOw0KPj4gKyAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgZ2VtLmNtZV9ldl9mbGFncyA9
IDA7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgaWYgKGhhc19jbWVfY291bnQpIHsNCj4+ICsg
ICAgICAgIGRlc2NyaXB0b3IgfD0gQ1hMX0dNRVJfRVZfREVTQ19USFJFU0hPTERfRVZFTlQ7DQo+
DQo+VGhlIG1vZGlmaWNhdGlvbiB0byAnZGVzY3JpcHRvcicgaGVyZSBpcyBub3Qgd3JpdHRlbiBi
YWNrIHRvIGdlbS5kZXNjcmlwdG9yIHdoaWNoDQo+d2FzIGFzc2lnbmVkIGVhcmxpZXIgaW4gdGhp
cyBmdW5jdGlvbi4NCj4NCj5TdWdnZXN0IG1vdmluZyBnZW0uZGVzY3JpcHRvciBhc3NpZ25tZW50
IGFmdGVyIHRoaXMgYmxvY2ssIHNpbWlsYXIgdG8gaG93DQo+dmFsaWRfZmxhZ3MgaXMgaGFuZGxl
ZCBpbiB0aGlzIHNhbWUgZnVuY3Rpb24uDQo+DQpUaGFua3MgUmF2aS4NCldpbGwgIGZpeC4NCg0K
Pj4gIHZvaWQgcW1wX2N4bF9pbmplY3RfZHJhbV9ldmVudChjb25zdCBjaGFyICpwYXRoLCBDeGxF
dmVudExvZyBsb2csDQo+PiAtLQ0KPj4gMi40OC4xDQo+Pg0KPj4NCg0KVGhhbmtzLA0KU2hpanUN
Cg==

