Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB438FD45F8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 22:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvMwm-0001vg-NN; Wed, 25 Feb 2026 17:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=509822c20=graf@amazon.de>)
 id 1vvMwk-0001uY-CO; Wed, 25 Feb 2026 17:01:30 -0500
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.1.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=509822c20=graf@amazon.de>)
 id 1vvMwi-0007Pi-GU; Wed, 25 Feb 2026 17:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1772056888; x=1803592888;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ndRtJSbo3YPB6zFN2D5RvTASYhp3oic7wHCDZXyffr0=;
 b=s5LD6xZOCVNcO2pRrjeBQMDixQqIBQSoZcptFbSU0XUnnMI3Y3TcGKft
 5Gq2VItfkmhL2nhk4LgSylH1NwiAH9ovG3sfLKQI2XM7HU10+IpYVM/Qx
 pexonxTroX7+jqU1TJHoljCWQOmrbzn1VXgDRGhEWg29jYP7063QAHm2O
 TWUv2y+NZ8YIJ7KOxs9LMn9L1bNAT1EI8yAtFRINcXAETlXXzLEpU7NkJ
 wAtjxpvikNgAAm7va8ZXF/TXa5i8mcAHKX0z+r0ynmZNRp82cQQfCJbla
 8gpeSM11oRbbLqGRbZzpE3Je4ATh9mcyJT8MyGgZqSU2yTdcVwwG8ysWD w==;
X-CSE-ConnectionGUID: 4v9BPXUQSoWIXWbKMRlMuA==
X-CSE-MsgGUID: uhGYFebeQ6SjAtE7w+tNIA==
X-IronPort-AV: E=Sophos;i="6.21,311,1763424000"; d="scan'208";a="13797641"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 22:01:22 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:31711]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.226:2525]
 with esmtp (Farcaster)
 id 83962ae8-7940-4a39-a6b3-7c5ae598b6dd; Wed, 25 Feb 2026 22:01:21 +0000 (UTC)
X-Farcaster-Flow-ID: 83962ae8-7940-4a39-a6b3-7c5ae598b6dd
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 25 Feb 2026 22:01:21 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 25 Feb 2026
 22:01:18 +0000
Message-ID: <c8f55b8d-f5be-47fd-b2b9-a9359011ff88@amazon.com>
Date: Wed, 25 Feb 2026 23:01:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] hw/nitro: Enable direct kernel boot
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 <alex.bennee@linaro.org>, <philmd@linaro.org>, <berrange@redhat.com>,
 <marcandre.lureau@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 <mst@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Tyler Fanelli <tfanelli@redhat.com>,
 <mknaust@amazon.com>, <nh-open-source@amazon.com>
References: <20260225144532.84673-1-graf@amazon.com>
 <20260225144532.84673-11-graf@amazon.com>
 <CAFfO_h4RaLGni60-EitiqBPZn08gem20McpHpLqcSU07rAEzgw@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAFfO_h4RaLGni60-EitiqBPZn08gem20McpHpLqcSU07rAEzgw@mail.gmail.com>
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=44.246.1.125;
 envelope-from=prvs=509822c20=graf@amazon.de;
 helo=pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ck9uIDI1LjAyLjI2IDE3OjI4LCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+IE9uIFdlZCwgRmVi
IDI1LCAyMDI2IGF0IDg6NDfigK9QTSBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPiB3
cm90ZToKPj4gTml0cm8gRW5jbGF2ZXMgY2FuIG9ubHkgYm9vdCBFSUYgZmlsZXMgd2hpY2ggYXJl
IGEgY29tYmluYXRpb24gb2YKPj4ga2VybmVsLCBpbml0cmFtZnMgYW5kIGNtZGxpbmUgaW4gYSBz
aW5nbGUgZmlsZS4gV2hlbiB0aGUga2VybmVsIGltYWdlIGlzCj4+IG5vdCBhbiBFSUYsIHRyZWF0
IGl0IGxpa2UgYSBrZXJuZWwgaW1hZ2UgYW5kIGFzc2VtYmxlIGFuIEVJRiBpbWFnZSBvbgo+PiB0
aGUgZmx5LiBUaGlzIHdheSwgdXNlcnMgY2FuIGNhbGwgUUVNVSB3aXRoIGEgZGlyZWN0Cj4+IGtl
cm5lbC9pbml0cmQvY21kbGluZSBjb21iaW5hdGlvbiBhbmQgZXZlcnl0aGluZyAianVzdCB3b3Jr
cyIuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+
Cj4+IC0tLQo+PiAgIGh3L2NvcmUvZWlmLmggICAgICAgIHwgICAzICsrCj4+ICAgaHcvbml0cm8v
bWFjaGluZS5jICAgfCAxMTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+PiAgIGh3L25pdHJvL21lc29uLmJ1aWxkIHwgICAyICstCj4+ICAgMyBmaWxlcyBjaGFu
Z2VkLCAxMjAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
aHcvY29yZS9laWYuaCBiL2h3L2NvcmUvZWlmLmgKPj4gaW5kZXggYTM0MTIzNzdhOS4uMGM0MzJk
YmMyZCAxMDA2NDQKPj4gLS0tIGEvaHcvY29yZS9laWYuaAo+PiArKysgYi9ody9jb3JlL2VpZi5o
Cj4+IEBAIC0xMiw2ICsxMiw3IEBACj4+ICAgI2RlZmluZSBIV19DT1JFX0VJRl9ICj4+Cj4+ICAg
I2RlZmluZSBNQVhfU0VDVElPTlMgMzIKPj4gKyNkZWZpbmUgRUlGX0hEUl9BUkNIX0FSTTY0IDB4
MQo+Pgo+PiAgIC8qIG1lbWJlcnMgYXJlIG9yZGVyZWQgYWNjb3JkaW5nIHRvIGZpZWxkIG9yZGVy
IGluIC5laWYgZmlsZSAqLwo+PiAgIHR5cGVkZWYgc3RydWN0IEVpZkhlYWRlciB7Cj4+IEBAIC00
OSw2ICs1MCw4IEBAIGVudW0gRWlmU2VjdGlvblR5cGVzIHsKPj4gICAgICAgRUlGX1NFQ1RJT05f
TUFYID0gNiwKPj4gICB9Owo+Pgo+PiArI2RlZmluZSBFSUZfTUFHSUMgeyAnLicsICdlJywgJ2kn
LCAnZicgfQo+PiArCj4+ICAgYm9vbCByZWFkX2VpZl9maWxlKGNvbnN0IGNoYXIgKmVpZl9wYXRo
LCBjb25zdCBjaGFyICptYWNoaW5lX2luaXRyZCwKPj4gICAgICAgICAgICAgICAgICAgICAgY2hh
ciAqKmtlcm5lbF9wYXRoLCBjaGFyICoqaW5pdHJkX3BhdGgsCj4+ICAgICAgICAgICAgICAgICAg
ICAgIGNoYXIgKiprZXJuZWxfY21kbGluZSwgdWludDhfdCAqaW1hZ2Vfc2hhMzg0LAo+PiBkaWZm
IC0tZ2l0IGEvaHcvbml0cm8vbWFjaGluZS5jIGIvaHcvbml0cm8vbWFjaGluZS5jCj4+IGluZGV4
IGUyOGM4ZTliZjUuLjg4NDk5NTkzNTkgMTAwNjQ0Cj4+IC0tLSBhL2h3L25pdHJvL21hY2hpbmUu
Ywo+PiArKysgYi9ody9uaXRyby9tYWNoaW5lLmMKPj4gQEAgLTMyLDkgKzMyLDEwNCBAQAo+PiAg
ICNpbmNsdWRlICJzeXN0ZW0vbml0cm8tYWNjZWwuaCIKPj4gICAjaW5jbHVkZSAicWVtdS9hY2Nl
bC5oIgo+PiAgICNpbmNsdWRlICJody9hcm0vbWFjaGluZXMtcW9tLmgiCj4+ICsjaW5jbHVkZSAi
aHcvY29yZS9laWYuaCIKPj4gKyNpbmNsdWRlIDx6bGliLmg+IC8qIGZvciBjcmMzMiAqLwo+Pgo+
PiAgICNkZWZpbmUgRUlGX0xPQURfQUREUiAgICg4ICogMTAyNCAqIDEwMjQpCj4+Cj4+ICtzdGF0
aWMgYm9vbCBpc19laWYoY2hhciAqZWlmLCBnc2l6ZSBsZW4pCj4+ICt7Cj4+ICsgICAgY29uc3Qg
Y2hhciBlaWZfbWFnaWNbXSA9IEVJRl9NQUdJQzsKPj4gKwo+PiArICAgIHJldHVybiBsZW4gPj0g
c2l6ZW9mKGVpZl9tYWdpYykgJiYKPj4gKyAgICAgICAgICAgIW1lbWNtcChlaWYsIGVpZl9tYWdp
Yywgc2l6ZW9mKGVpZl9tYWdpYykpOwo+PiArfQo+PiArCj4+ICtzdGF0aWMgdm9pZCBidWlsZF9l
aWZfc2VjdGlvbihFaWZIZWFkZXIgKmhkciwgR0J5dGVBcnJheSAqYnVmLCB1aW50MTZfdCB0eXBl
LAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqZGF0YSwgdWlu
dDY0X3Qgc2l6ZSkKPj4gK3sKPj4gKyAgICB1aW50MTZfdCBzZWN0aW9uID0gYmUxNl90b19jcHUo
aGRyLT5zZWN0aW9uX2NudCk7Cj4+ICsgICAgRWlmU2VjdGlvbkhlYWRlciBzaGRyID0gewo+PiAr
ICAgICAgICAuc2VjdGlvbl90eXBlID0gY3B1X3RvX2JlMTYodHlwZSksCj4+ICsgICAgICAgIC5m
bGFncyA9IDAsCj4+ICsgICAgICAgIC5zZWN0aW9uX3NpemUgPSBjcHVfdG9fYmU2NChzaXplKSwK
Pj4gKyAgICB9Owo+PiArCj4+ICsgICAgaGRyLT5zZWN0aW9uX29mZnNldHNbc2VjdGlvbl0gPSBj
cHVfdG9fYmU2NChidWYtPmxlbik7Cj4+ICsgICAgaGRyLT5zZWN0aW9uX3NpemVzW3NlY3Rpb25d
ID0gY3B1X3RvX2JlNjQoc2l6ZSk7Cj4+ICsKPj4gKyAgICBnX2J5dGVfYXJyYXlfYXBwZW5kKGJ1
ZiwgKGNvbnN0IHVpbnQ4X3QgKikmc2hkciwgc2l6ZW9mKHNoZHIpKTsKPj4gKyAgICBpZiAoc2l6
ZSkgewo+PiArICAgICAgICBnX2J5dGVfYXJyYXlfYXBwZW5kKGJ1ZiwgKGNvbnN0IHVpbnQ4X3Qg
KilkYXRhLCBzaXplKTsKPj4gKyAgICB9Cj4+ICsKPj4gKyAgICBoZHItPnNlY3Rpb25fY250ID0g
Y3B1X3RvX2JlMTYoc2VjdGlvbiArIDEpOwo+PiArfQo+PiArCj4+ICsvKgo+PiArICogTml0cm8g
RW5jbGF2ZXMgb25seSBzdXBwb3J0IGxvYWRpbmcgRUlGIGZpbGVzLiBXaGVuIHRoZSB1c2VyIHBy
b3ZpZGVzCj4+ICsgKiBhIExpbnV4IGtlcm5lbCwgaW5pdHJkIGFuZCBjbWRsaW5lLCBjb252ZXJ0
IHRoZW0gaW50byBFSUYgZm9ybWF0Lgo+PiArICovCj4+ICtzdGF0aWMgY2hhciAqYnVpbGRfZWlm
KGNvbnN0IGNoYXIgKmtlcm5lbF9kYXRhLCBnc2l6ZSBrZXJuZWxfc2l6ZSwKPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgY29uc3QgY2hhciAqaW5pdHJkX3BhdGgsIGNvbnN0IGNoYXIgKmNtZGxp
bmUsCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGdzaXplICpvdXRfc2l6ZSwgRXJyb3IgKipl
cnJwKQo+PiArewo+PiArICAgIGdfYXV0b2ZyZWUgY2hhciAqaW5pdHJkX2RhdGEgPSBOVUxMOwo+
PiArICAgIHN0YXRpYyBjb25zdCBjaGFyIG1ldGFkYXRhW10gPSAie30iOwo+PiArICAgIHNpemVf
dCBtZXRhZGF0YV9sZW4gPSBzaXplb2YobWV0YWRhdGEpIC0gMTsKPj4gKyAgICBnc2l6ZSBpbml0
cmRfc2l6ZSA9IDA7Cj4+ICsgICAgR0J5dGVBcnJheSAqYnVmOwo+PiArICAgIEVpZkhlYWRlciBo
ZHI7Cj4+ICsgICAgdWludDMyX3QgY3JjID0gMDsKPj4gKyAgICBzaXplX3QgY21kbGluZV9sZW47
Cj4+ICsKPj4gKyAgICBpZiAoaW5pdHJkX3BhdGgpIHsKPj4gKyAgICAgICAgaWYgKCFnX2ZpbGVf
Z2V0X2NvbnRlbnRzKGluaXRyZF9wYXRoLCAmaW5pdHJkX2RhdGEsCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAmaW5pdHJkX3NpemUsIE5VTEwpKSB7Cj4+ICsgICAgICAgICAg
ICBlcnJvcl9zZXRnKGVycnAsICJGYWlsZWQgdG8gcmVhZCBpbml0cmQgJyVzJyIsIGluaXRyZF9w
YXRoKTsKPj4gKyAgICAgICAgICAgIHJldHVybiBOVUxMOwo+PiArICAgICAgICB9Cj4+ICsgICAg
fQo+PiArCj4+ICsgICAgYnVmID0gZ19ieXRlX2FycmF5X25ldygpOwo+PiArCj4+ICsgICAgY21k
bGluZV9sZW4gPSBjbWRsaW5lID8gc3RybGVuKGNtZGxpbmUpIDogMDsKPj4gKwo+PiArICAgIGhk
ciA9IChFaWZIZWFkZXIpIHsKPj4gKyAgICAgICAgLm1hZ2ljID0gRUlGX01BR0lDLAo+PiArICAg
ICAgICAudmVyc2lvbiA9IGNwdV90b19iZTE2KDQpLAo+PiArICAgICAgICAuZmxhZ3MgPSBjcHVf
dG9fYmUxNih0YXJnZXRfYWFyY2g2NCgpID8gRUlGX0hEUl9BUkNIX0FSTTY0IDogMCksCj4+ICsg
ICAgfTsKPj4gKwo+PiArICAgIGdfYnl0ZV9hcnJheV9hcHBlbmQoYnVmLCAoY29uc3QgdWludDhf
dCAqKSZoZHIsIHNpemVvZihoZHIpKTsKPj4gKwo+PiArICAgIC8qIEtlcm5lbCAqLwo+PiArICAg
IGJ1aWxkX2VpZl9zZWN0aW9uKCZoZHIsIGJ1ZiwgRUlGX1NFQ1RJT05fS0VSTkVMLCBrZXJuZWxf
ZGF0YSwga2VybmVsX3NpemUpOwo+PiArCj4+ICsgICAgLyogQ29tbWFuZCBsaW5lICovCj4+ICsg
ICAgYnVpbGRfZWlmX3NlY3Rpb24oJmhkciwgYnVmLCBFSUZfU0VDVElPTl9DTURMSU5FLCBjbWRs
aW5lLCBjbWRsaW5lX2xlbik7Cj4+ICsKPj4gKyAgICAvKiBJbml0cmFtZnMgKi8KPj4gKyAgICBi
dWlsZF9laWZfc2VjdGlvbigmaGRyLCBidWYsIEVJRl9TRUNUSU9OX1JBTURJU0ssIGluaXRyZF9k
YXRhLCBpbml0cmRfc2l6ZSk7Cj4+ICsKPj4gKyAgICAvKiBNZXRhZGF0YSAqLwo+PiArICAgIGJ1
aWxkX2VpZl9zZWN0aW9uKCZoZHIsIGJ1ZiwgRUlGX1NFQ1RJT05fTUVUQURBVEEsIG1ldGFkYXRh
LCBtZXRhZGF0YV9sZW4pOwo+PiArCj4+ICsgICAgLyoKPj4gKyAgICAgKiBQYXRjaCB0aGUgaGVh
ZGVyIGludG8gdGhlIGJ1ZmZlciBmaXJzdCAod2l0aCByZWFsIHNlY3Rpb24gb2Zmc2V0cwo+PiAr
ICAgICAqIGFuZCBzaXplcyksIHRoZW4gY29tcHV0ZSBDUkMgb3ZlciBldmVyeXRoaW5nIGV4Y2Vw
dCB0aGUgQ1JDIGZpZWxkLgo+PiArICAgICAqLwo+PiArICAgIG1lbWNweShidWYtPmRhdGEsICZo
ZHIsIHNpemVvZihoZHIpKTsKPj4gKyAgICBjcmMgPSBjcmMzMihjcmMsIGJ1Zi0+ZGF0YSwgb2Zm
c2V0b2YoRWlmSGVhZGVyLCBlaWZfY3JjMzIpKTsKPj4gKyAgICBjcmMgPSBjcmMzMihjcmMsICZi
dWYtPmRhdGFbc2l6ZW9mKGhkcildLCBidWYtPmxlbiAtIHNpemVvZihoZHIpKTsKPj4gKwo+PiAr
ICAgIC8qIEZpbmFsbHkgd3JpdGUgdGhlIENSQyBpbnRvIHRoZSBpbi1idWZmZXIgaGVhZGVyICov
Cj4+ICsgICAgKChFaWZIZWFkZXIgKilidWYtPmRhdGEpLT5laWZfY3JjMzIgPSBjcHVfdG9fYmUz
MihjcmMpOwo+PiArCj4+ICsgICAgKm91dF9zaXplID0gYnVmLT5sZW47Cj4+ICsgICAgcmV0dXJu
IChjaGFyICopZ19ieXRlX2FycmF5X2ZyZWUoYnVmLCBmYWxzZSk7Cj4+ICt9Cj4+ICsKPiBNYXli
ZSB0aGVzZSBlaWYgYnVpbGRpbmcgZnVuY3Rpb25zIG1ha2Ugc2Vuc2UgaW4gdGhlIGh3L2NvcmUv
ZWlmLmMKPiBmaWxlLiBUaGVyZSB3ZSBhbHJlYWR5IGhhdmUgdGhlIHBhcnNpbmcgY29kZSwgc28g
bWF5YmUgdGhlc2UgZnVuY3Rpb25zCj4gY29tcGxlbWVudCB0aGUgY29kZSB0aGVyZS4gVGhhdCB3
YXkgd2Ugd291bGRuJ3QgbmVlZCB0byBtb3ZlIHRoZSBFSUYKPiBzdHJ1Y3R1cmVzIGV0YyBpbnRv
IHRoZSBoZWFkZXIgZmlsZSBpbiB0aGUgcHJldmlvdXMgY29tbWl0LgoKClRoZXNlIGZ1bmN0aW9u
cyBzdGFydGVkIG9mZiBpbiBlaWYuYyBldmVuLiBCdXQgdGhlbiBJIHJlYWxpemVkIHRoYXQgCmVp
Zi5jIGlzIGZhaXJseSB0aWVkIHRvIHRoZSBuaXRybyBlbmNsYXZlIGVtdWxhdGVkIG1hY2hpbmUg
d2hpY2ggaXMgeDg2IApvbmx5IGF0bS4gQW5kIEkgd2FudCB0byBnZW5lcmF0ZSBFSUZzIGFsc28g
b24gYWFyY2g2NC4KCklNSE8gdGhlIGRlZmluaXRpb25zIGFyZSBiZXR0ZXIgZml0IGluIHRoZSBo
ZWFkZXIgYW55d2F5LiBBbmQgSSdkIHJhdGhlciAKbGlrZSB0byBsZWF2ZSB0aGUgRUlGIGdlbmVy
YXRpb24gc2VsZi1jb250YWluZWQgaGVyZSBmb3Igbm93IHVudGlsIHdlIApkZWNpZGUgdG8gYWRk
IHN1cHBvcnQgZm9yIGxpdmUgRUlGIGFzc2VtYmx5IGluIHRoZSBlbXVsYXRlZCBtYWNoaW5lIGFz
IAp3ZWxsLiBBdCB0aGF0IHBvaW50IHdlIGNhbiB0aGluayBvZiBtZXJnaW5nIHRoZW0gOikKCgpB
bGV4CgoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdt
YkgKVGFtYXJhLURhbnotU3RyLiAxMwoxMDI0MyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBD
aHJpc3RvZiBIZWxsbWlzLCBBbmRyZWFzIFN0aWVnZXIKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmlj
aHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6
IERFIDM2NSA1MzggNTk3Cg==


