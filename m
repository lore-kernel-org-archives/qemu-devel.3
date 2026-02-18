Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E5EE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdjk-0001g0-2i; Wed, 18 Feb 2026 04:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=502105d20=graf@amazon.de>)
 id 1vsdje-0001fD-7A; Wed, 18 Feb 2026 04:20:42 -0500
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=502105d20=graf@amazon.de>)
 id 1vsdjb-00017M-Vj; Wed, 18 Feb 2026 04:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1771406440; x=1802942440;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qoGnJZonRPfLVJUCYhWdxEpfJv69uikk6SbYk3FpHFA=;
 b=eZDils1aNhFl5bzRvc9UIUeo6MYxuqvaSwo8eyErD++HQjEWYFTW4jCn
 +egev0qPwhIzoCySbjYY8g1WxyHI+GMRiCsUOxdinQxZt3oNc5NaKPAzi
 UBtcuUrDzHbLA+ucN4iOQtj1GVP5F72tfRlzs+4+hWjxntg0FRCMxKCW+
 TPO21dx+kB+OauFz17QZVBqFfMhuRFGGuwasHNm2HqOJNlMWL5XCe3gTM
 NDI1CshAGAdhYUyetcKCtd56pEakXMCmOmMiCl14U+T0jTA+MPn6R38Cu
 inyXqu/bypzJauDING8FwRhHPi0pjR4B3sJ+Du6zBpuhkEpb6vDkA+ERl A==;
X-CSE-ConnectionGUID: PHmf4ZwURAmE/l6HN1rEQA==
X-CSE-MsgGUID: otFvaxQZQO+8iIfbiE9i1Q==
X-IronPort-AV: E=Sophos;i="6.21,297,1763424000"; d="scan'208";a="12808045"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 09:20:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:27918]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.107:2525]
 with esmtp (Farcaster)
 id 2e46c855-1d40-4161-9b1e-7fe89e8c3e32; Wed, 18 Feb 2026 09:20:34 +0000 (UTC)
X-Farcaster-Flow-ID: 2e46c855-1d40-4161-9b1e-7fe89e8c3e32
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 09:20:33 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Wed, 18 Feb 2026
 09:20:29 +0000
Message-ID: <8feaefae-42fe-470c-b839-19d356e5416c@amazon.com>
Date: Wed, 18 Feb 2026 10:20:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] hw/nitro: Add nitro machine
To: Mohamed Mediouni <mohamed@unpredictable.fr>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 <alex.bennee@linaro.org>, <philmd@linaro.org>, <berrange@redhat.com>,
 <marcandre.lureau@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 <mst@redhat.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Tyler
 Fanelli" <tfanelli@redhat.com>, <mknaust@amazon.com>,
 <nh-open-source@amazon.com>
References: <20260218015151.4052-1-graf@amazon.com>
 <20260218015151.4052-8-graf@amazon.com>
 <D0E52BB9-72B7-4844-85D3-79A29F51AD17@unpredictable.fr>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <D0E52BB9-72B7-4844-85D3-79A29F51AD17@unpredictable.fr>
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=44.245.243.92;
 envelope-from=prvs=502105d20=graf@amazon.de;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

SGkgTW9oYW1lZCwKCk9uIDE4LjAyLjI2IDA0OjI3LCBNb2hhbWVkIE1lZGlvdW5pIHdyb3RlOgo+
PiBPbiAxOC4gRmViIDIwMjYsIGF0IDAyOjUxLCBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24u
Y29tPiB3cm90ZToKPj4KPj4gQWRkIGEgbWFjaGluZSBtb2RlbCB0byBzcGF3biBhIE5pdHJvIEVu
Y2xhdmUuIFVubGlrZSB0aGUgZXhpc3RpbmcgLU0KPj4gbml0cm8tZW5jbGF2ZSwgdGhpcyBtYWNo
aW5lIG1vZGVsIHdvcmtzIGV4Y2x1c2l2ZWx5IHdpdGggdGhlIC1hY2NlbAo+PiBuaXRybyBhY2Nl
bGVyYXRvciB0byBkcml2ZSByZWFsIE5pdHJvIEVuY2xhdmUgY3JlYXRpb24uIEl0IHN1cHBvcnRz
Cj4+IG1lbW9yeSBhbGxvY2F0aW9uLCBudW1iZXIgb2YgQ1BVIHNlbGVjdGlvbiwgYm90aCB4ODZf
NjQgYXMgd2VsbCBhcwo+PiBhYXJjaDY0LCBpbXBsZW1lbnRzIHRoZSBFbmNsYXZlIGhlYXJ0YmVh
dCBsb2dpYyBhbmQgZGVidWcgc2VyaWFsCj4+IGNvbnNvbGUuCj4+Cj4+IFRvIHVzZSBpdCwgY3Jl
YXRlIGFuIEVJRiBmaWxlIGFuZCBydW4KPj4KPj4gICAkIHFlbXUtc3lzdGVtLXg4Nl82NCAtYWNj
ZWwgbml0cm8sZGVidWctbW9kZT1vbiAtTSBuaXRybyAtbm9ncmFwaGljIFwKPj4gICAgICAgICAg
ICAgICAgICAgICAgICAta2VybmVsIHRlc3QuZWlmCj4+Cj4+IG9yCj4+Cj4+ICAgJCBxZW11LXN5
c3RlbS1hYXJjaDY0IC1hY2NlbCBuaXRybyxkZWJ1Zy1tb2RlPW9uIC1NIG5pdHJvIC1ub2dyYXBo
aWMgXAo+PiAgICAgICAgICAgICAgICAgICAgICAgIC1rZXJuZWwgdGVzdC5laWYKPj4KPj4gU2ln
bmVkLW9mZi1ieTogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4KPiBIaSwKPgo+IFRo
ZSBzZXBhcmF0aW9uIGJldHdlZW4gLU0gbml0cm8gYW5kIC1NIG5pdHJvLWVuY2xhdmUgbG9va3Mg
cG90ZW50aWFsbHkgY29uZnVzaW5nCj4gdG8gdXNlcnMuIENvdWxkIGl0IHBvdGVudGlhbGx5IG1h
a2Ugc2Vuc2UgdG8gc2hhcmUgdGhlIG5hbWUgb3IgaXMgdGhhdCBhbiBvcHRpb24gbm90Cj4gb24g
dGhlIGNhcmRzPwoKCkkgb3JpZ2luYWxseSBidWlsdCBhbGwgb2YgdGhpcyBpbnNpZGUgdGhlIG5p
dHJvLWVuY2xhdmUgbWFjaGluZSwgYnV0IAp0aGF0IHR1cm5lZCBvdXQgc3VwZXIgYXdrd2FyZCBh
cyB3ZWxsLCBiZWNhdXNlIGl0cyBjb21wbGV0ZSAKaW5pdGlhbGl6YXRpb24gaXMgZGlmZmVyZW50
LiBUaGUgbml0cm8tZW5jbGF2ZSBtYWNoaW5lIGlzIGRlcml2ZWQgZnJvbSAKdGhlIE1pY3JvVk0g
bWFjaGluZSB0eXBlLCB3aGljaCBpcyBub3QgYXQgYWxsIHdoYXQgd2UgbmVlZCBmb3IgdGhlIGFj
Y2VsIApiYXNlZCB2YXJpYW50LiBBbmQgb24gdG9wIG9mIHRoYXQgbWFrZXMgaXQgc3VwZXIgZGlm
ZmljdWx0IHRvIGVuYWJsZSAKYWFyY2g2NCBzdXBwb3J0LgoKU28gSSBvcHRlZCB0byBnbyB3aXRo
IHRoZSBzZXBhcmF0ZSBtYWNoaW5lIG5hbWUgaW5zdGVhZC4KCgpBbGV4CgoKCgpBbWF6b24gV2Vi
IFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKVGFtYXJhLURhbnotU3Ry
LiAxMwoxMDI0MyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RvZiBIZWxsbWlzLCBB
bmRyZWFzIFN0aWVnZXIKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcg
dW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


