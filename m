Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D88C56206
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS6W-0004br-J7; Fri, 20 Feb 2026 10:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=50468f4b5=graf@amazon.de>)
 id 1vtS6J-0004Ye-VM; Fri, 20 Feb 2026 10:07:29 -0500
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.34.181.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=50468f4b5=graf@amazon.de>)
 id 1vtS6G-0004P9-Rm; Fri, 20 Feb 2026 10:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1771600044; x=1803136044;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cjl2MgjXEErjFfKv+r56ubT5PuROvPF3mMZdX8Y44LU=;
 b=Aw+9ikLOHTJEsZ3BwvahgyHa+GULqZQzqjkjnuj8tmyHiBzc11VE0/0s
 SNijct+8lVAiJCcEopVqw7Jv76R/7/0mxVB3QRh+0Db5HvmckyMjEMaNT
 dfQVIkYr/Qyoo0Dop6lCQYgMVraItFxetGwhKH2x0Og81lfpyUlFy5tuk
 loXhtl4us/5wTl4/S9YDBKfYm1ZS1qjGShOwvlmuCjYhfZQJ9XQOKChq+
 QV9jHiW7PvgvoaT0Fmb7ItdiWSicgsflip3uzt5pM3RQYU1fip0BWTEH1
 MUi/Y+BaQER/f4PhGmuaGsut0n2csrYO7jKIcsLrkqBkuRd+ba/ywbtza g==;
X-CSE-ConnectionGUID: aWwdUtHtTdG+2s7c2QjcaQ==
X-CSE-MsgGUID: pzkamuDaTDaim8y4Ae+zRg==
X-IronPort-AV: E=Sophos;i="6.21,302,1763424000"; d="scan'208";a="13432558"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 15:07:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:7790]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.60:2525]
 with esmtp (Farcaster)
 id 0dd3a033-595e-4278-b0b3-f6492765a07b; Fri, 20 Feb 2026 15:07:17 +0000 (UTC)
X-Farcaster-Flow-ID: 0dd3a033-595e-4278-b0b3-f6492765a07b
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 20 Feb 2026 15:07:16 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 20 Feb 2026
 15:07:12 +0000
Message-ID: <85e58c20-dfc5-4bc2-911e-ecdac3b922c4@amazon.com>
Date: Fri, 20 Feb 2026 16:07:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] hw/nitro: Add nitro machine
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 <alex.bennee@linaro.org>, <philmd@linaro.org>, <berrange@redhat.com>,
 <marcandre.lureau@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dorjoy
 Chowdhury" <dorjoychy111@gmail.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Tyler
 Fanelli" <tfanelli@redhat.com>, <mknaust@amazon.com>,
 <nh-open-source@amazon.com>
References: <20260218015151.4052-1-graf@amazon.com>
 <20260218015151.4052-8-graf@amazon.com>
 <20260220095806-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20260220095806-mutt-send-email-mst@kernel.org>
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=52.34.181.151;
 envelope-from=prvs=50468f4b5=graf@amazon.de;
 helo=pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

SGV5IE1pY2hhZWwsCgpPbiAyMC4wMi4yNiAxNTo1OSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+IE9uIFdlZCwgRmViIDE4LCAyMDI2IGF0IDAxOjUxOjQ3QU0gKzAwMDAsIEFsZXhhbmRlciBH
cmFmIHdyb3RlOgo+PiBBZGQgYSBtYWNoaW5lIG1vZGVsIHRvIHNwYXduIGEgTml0cm8gRW5jbGF2
ZS4gVW5saWtlIHRoZSBleGlzdGluZyAtTQo+PiBuaXRyby1lbmNsYXZlLCB0aGlzIG1hY2hpbmUg
bW9kZWwgd29ya3MgZXhjbHVzaXZlbHkgd2l0aCB0aGUgLWFjY2VsCj4+IG5pdHJvIGFjY2VsZXJh
dG9yIHRvIGRyaXZlIHJlYWwgTml0cm8gRW5jbGF2ZSBjcmVhdGlvbi4gSXQgc3VwcG9ydHMKPj4g
bWVtb3J5IGFsbG9jYXRpb24sIG51bWJlciBvZiBDUFUgc2VsZWN0aW9uLCBib3RoIHg4Nl82NCBh
cyB3ZWxsIGFzCj4+IGFhcmNoNjQsIGltcGxlbWVudHMgdGhlIEVuY2xhdmUgaGVhcnRiZWF0IGxv
Z2ljIGFuZCBkZWJ1ZyBzZXJpYWwKPj4gY29uc29sZS4KPj4KPj4gVG8gdXNlIGl0LCBjcmVhdGUg
YW4gRUlGIGZpbGUgYW5kIHJ1bgo+Pgo+PiAgICAkIHFlbXUtc3lzdGVtLXg4Nl82NCAtYWNjZWwg
bml0cm8sZGVidWctbW9kZT1vbiAtTSBuaXRybyAtbm9ncmFwaGljIFwKPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgLWtlcm5lbCB0ZXN0LmVpZgo+Pgo+PiBvcgo+Pgo+PiAgICAkIHFlbXUtc3lz
dGVtLWFhcmNoNjQgLWFjY2VsIG5pdHJvLGRlYnVnLW1vZGU9b24gLU0gbml0cm8gLW5vZ3JhcGhp
YyBcCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIC1rZXJuZWwgdGVzdC5laWYKPj4KPj4gU2ln
bmVkLW9mZi1ieTogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4KCgpbLi4uXQoKCj4+
ICsKPj4gKyAgICAvKgo+PiArICAgICAqIEluIGRlYnVnIG1vZGUsIE5pdHJvIEVuY2xhdmVzIGV4
cG9zZSB0aGUgZ3Vlc3QncyBzZXJpYWwgb3V0cHV0IHZpYQo+PiArICAgICAqIHZzb2NrLiBXaGVu
IHRoZSBhY2NlbCBpcyBpbiBkZWJ1ZyBtb2RlLCB3aXJlIHRoZSB2c29jayBzZXJpYWwgdG8KPj4g
KyAgICAgKiB0aGUgbWFjaGluZSdzIHNlcmlhbCBwb3J0IHNvIHRoYXQgLW5vZ3JhcGhpYyBhdXRv
bWF0aWNhbGx5IHdvcmtzCj4+ICsgICAgICovCj4+ICsgICAgaWYgKG9iamVjdF9wcm9wZXJ0eV9n
ZXRfYm9vbChPQkpFQ1QoY3VycmVudF9hY2NlbCgpKSwgImRlYnVnLW1vZGUiLCBOVUxMKSkgewo+
PiArICAgICAgICBDaGFyZGV2ICpjaHIgPSBzZXJpYWxfaGQoMCk7Cj4+ICsKPj4gKyAgICAgICAg
aWYgKGNocikgewo+PiArICAgICAgICAgICAgRGV2aWNlU3RhdGUgKmRldiA9IHFkZXZfbmV3KFRZ
UEVfTklUUk9fU0VSSUFMX1ZTT0NLKTsKPj4gKwo+PiArICAgICAgICAgICAgcWRldl9wcm9wX3Nl
dF9jaHIoZGV2LCAiY2hhcmRldiIsIGNocik7Cj4+ICsgICAgICAgICAgICBzeXNidXNfcmVhbGl6
ZV9hbmRfdW5yZWYoU1lTX0JVU19ERVZJQ0UoZGV2KSwgJmVycm9yX2ZhdGFsKTsKPj4gKyAgICAg
ICAgfQo+PiArICAgIH0KPgo+IFdvdWxkICByZXNwZWN0aW5nIC1ub2RlZmF1bHRzIGFuZCB0aGVu
IG1heWJlIG5vdCB3aXJpbmcgdXAgYWxsIHRoZQo+IHZzb2NrIHRoaW5ncyBtYWtlIHNlbnNlPyBh
bGxvd3MgdXNlcnMgdG8gc2V0IGl0IHVwIGFueSB3YXkKPiB0aGV5IHdhbnQgLi4uCgoKU28geW91
IHdvdWxkIHNldCB1cCB0aGUgaW5kaXZpZHVhbCBzcGVjaWFsLXB1cnBvc2Ugbml0cm8gZGV2aWNl
cyB2aWEgCi1kZXZpY2Ugb3IgaGFuZGxlIHRoZSByZXNwZWN0aXZlIHZpcnRpbyBzdHJlYW1zIGV4
dGVybmFsbHkgaW5zdGVhZD8gVGhhdCAKZGVmaW5pdGVseSBtYWtlcyBhIGxvdCBvZiBzZW5zZSEg
SGFwcHkgdG8gYWRkIGluIHYyLgoKCkFsZXgKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxv
cG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxp
bgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdG9mIEhlbGxtaXMsIEFuZHJlYXMgU3RpZWdlcgpF
aW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0
IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


