Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA629C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 12:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdr5X-00064i-4w; Tue, 13 Aug 2024 08:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=94890f287=graf@amazon.de>)
 id 1sdr5U-00063N-6U
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:57:20 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=94890f287=graf@amazon.de>)
 id 1sdr5R-0007Ph-5Y
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1723553837; x=1755089837;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=sXHlVCz9Ha8PyDiW2iFU5thB8k2YDON4wDIIbQpS92M=;
 b=GfvLodRCWFt6WbjOIQwNKOnsoeAlet5TXeoEr8s0nZnkEbcqtHW2DnaN
 8MFyJGSW5Kds5ooEDG0sgLiRCId6CbGnJXjMCucoseRx/STqpHAXqh9ad
 f0FCTvNeUuazOMW0vs+c+V9sX2tQf+pr2wqgZCd3Zy+eG/tqpaGSiZuVI c=;
X-IronPort-AV: E=Sophos;i="6.09,285,1716249600"; d="scan'208";a="362025175"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-33001.sea14.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 12:57:09 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:42742]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.82:2525]
 with esmtp (Farcaster)
 id 63e943ba-533a-4c08-ae0a-e8755ade9659; Tue, 13 Aug 2024 12:57:08 +0000 (UTC)
X-Farcaster-Flow-ID: 63e943ba-533a-4c08-ae0a-e8755ade9659
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 12:57:08 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Tue, 13 Aug 2024
 12:57:05 +0000
Message-ID: <ebe8952e-239a-4a93-ba90-e7f633046eef@amazon.com>
Date: Tue, 13 Aug 2024 14:57:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, <qemu-devel@nongnu.org>
CC: <agraf@csgraf.de>, <stefanha@redhat.com>, <pbonzini@redhat.com>,
 <slp@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>,
 <philmd@linaro.org>
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
 <20240810164502.19693-5-dorjoychy111@gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240810164502.19693-5-dorjoychy111@gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.171.190.10;
 envelope-from=prvs=94890f287=graf@amazon.de; helo=smtp-fw-33001.amazon.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ck9uIDEwLjA4LjI0IDE4OjQ1LCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+IEFXUyBOaXRybyBF
bmNsYXZlcyBoYXZlIGJ1aWx0LWluIE5pdHJvIFNlY3VyZSBNb2R1bGUgKE5TTSkgZGV2aWNlIHdo
aWNoCj4gaXMgdXNlZCBmb3Igc3RyaXBwZWQgZG93biBUUE0gZnVuY3Rpb25hbGl0eSBsaWtlIGF0
dGVzdGF0aW9uLiBUaGlzIGNvbW1pdAo+IGFkZHMgdGhlIGJ1aWx0LWluIE5TTSBkZXZpY2UgaW4g
dGhlIG5pdHJvLWVuY2xhdmUgbWFjaGluZSB0eXBlLgo+Cj4gSW4gTml0cm8gRW5jbGF2ZXMsIGFs
bCB0aGUgUENScyBzdGFydCBpbiBhIGtub3duIHplcm8gc3RhdGUgYW5kIHRoZSBmaXJzdAo+IDE2
IFBDUnMgYXJlIGxvY2tlZCBmcm9tIGJvb3QgYW5kIHJlc2VydmVkLiBUaGUgUENSMCwgUENSMSwg
UENSMiBhbmQgUENSOAo+IGNvbnRhaW4gdGhlIFNIQTM4NCBoYXNoZXMgcmVsYXRlZCB0byB0aGUg
RUlGIGZpbGUgdXNlZCB0byBib290IHRoZQo+IFZNIGZvciB2YWxpZGF0aW9uLgo+Cj4gQSBuZXcg
b3B0aW9uYWwgbml0cm8tZW5jbGF2ZSBtYWNoaW5lIG9wdGlvbiAnaWQnIGhhcyBiZWVuIGFkZGVk
IHdoaWNoIHdpbGwKPiBiZSB0aGUgZW5jbGF2ZSBpZGVudGlmaWVyIHJlZmxlY3RlZCBpbiB0aGUg
bW9kdWxlLWlkIG9mIHRoZSBOU00gZGV2aWNlLgo+IE90aGVyd2lzZSwgdGhlIGRldmljZSB3aWxs
IGhhdmUgYSBkZWZhdWx0IGlkIHNldC4KPgo+IFNpZ25lZC1vZmYtYnk6IERvcmpveSBDaG93ZGh1
cnkgPGRvcmpveWNoeTExMUBnbWFpbC5jb20+Cj4gLS0tCj4gICBody9jb3JlL2VpZi5jICAgICAg
ICAgICAgICAgICAgIHwgMjA1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gICBo
dy9jb3JlL2VpZi5oICAgICAgICAgICAgICAgICAgIHwgICA1ICstCj4gICBody9jb3JlL21lc29u
LmJ1aWxkICAgICAgICAgICAgIHwgICA0ICstCj4gICBody9pMzg2L0tjb25maWcgICAgICAgICAg
ICAgICAgIHwgICAxICsKPiAgIGh3L2kzODYvbml0cm9fZW5jbGF2ZS5jICAgICAgICAgfCAgODUg
KysrKysrKysrKysrLQo+ICAgaW5jbHVkZS9ody9pMzg2L25pdHJvX2VuY2xhdmUuaCB8ICAxOSAr
KysKPiAgIDYgZmlsZXMgY2hhbmdlZCwgMzEwIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0p
Cj4KClsuLi5dCgoKPiBAQCAtODcsMTAgKzEwNiw0NiBAQCBzdGF0aWMgdm9pZCBuaXRyb19lbmNs
YXZlX21hY2hpbmVfc3RhdGVfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpCj4gICAgICAgbml0
cm9fZW5jbGF2ZV9kZXZpY2VzX2luaXQobmVfc3RhdGUpOwo+ICAgfQo+Cj4gK3N0YXRpYyB2b2lk
IG5pdHJvX2VuY2xhdmVfbWFjaGluZV9yZXNldChNYWNoaW5lU3RhdGUgKm1hY2hpbmUsCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTaHV0ZG93bkNhdXNlIHJlYXNv
bikKPiArewo+ICsgICAgTml0cm9FbmNsYXZlTWFjaGluZUNsYXNzICpuZV9jbGFzcyA9Cj4gKyAg
ICAgICAgTklUUk9fRU5DTEFWRV9NQUNISU5FX0dFVF9DTEFTUyhtYWNoaW5lKTsKPiArICAgIE5p
dHJvRW5jbGF2ZU1hY2hpbmVTdGF0ZSAqbmVfc3RhdGUgPSBOSVRST19FTkNMQVZFX01BQ0hJTkUo
bWFjaGluZSk7Cj4gKwo+ICsgICAgbmVfY2xhc3MtPnBhcmVudF9yZXNldChtYWNoaW5lLCByZWFz
b24pOwo+ICsKPiArICAgIG1lbXNldChuZV9zdGF0ZS0+dm5zbS0+cGNycywgMCwgc2l6ZW9mKG5l
X3N0YXRlLT52bnNtLT5wY3JzKSk7Cj4gKwo+ICsgICAgLyogUENSMCAqLwo+ICsgICAgbmVfc3Rh
dGUtPnZuc20tPmV4dGVuZF9wY3IobmVfc3RhdGUtPnZuc20sIDAsIG5lX3N0YXRlLT5pbWFnZV9z
aGEzODQsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTSEEzODRfQllURV9MRU4p
Owo+ICsgICAgLyogUENSMSAqLwo+ICsgICAgbmVfc3RhdGUtPnZuc20tPmV4dGVuZF9wY3IobmVf
c3RhdGUtPnZuc20sIDEsIG5lX3N0YXRlLT5ib290c3RyYXBfc2hhMzg0LAo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgU0hBMzg0X0JZVEVfTEVOKTsKPiArICAgIC8qIFBDUjIgKi8K
PiArICAgIG5lX3N0YXRlLT52bnNtLT5leHRlbmRfcGNyKG5lX3N0YXRlLT52bnNtLCAyLCBuZV9z
dGF0ZS0+YXBwX3NoYTM4NCwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNIQTM4
NF9CWVRFX0xFTik7CgoKV2hhdCBhYm91dCBQQ1IzIGFuZCBQQ1I0PyBCb3RoIGFyZSBqdXN0IHNo
YTM4NCB2YWx1ZXMgb2YgaW5wdXQgCnN0cmluZ3NbMV0uIENhbiB5b3UgbWFrZSB0aGVzZSBpbnB1
dCBzdHJpbmdzIE5TTSBkZXZpY2UgYXMgd2VsbCBhcyAKbWFjaGluZSBwcm9wZXJ0aWVzIGFzIHdl
bGw/CgpbMV0gaHR0cHM6Ly9kb2NzLmF3cy5hbWF6b24uY29tL2VuY2xhdmVzL2xhdGVzdC91c2Vy
L3NldC11cC1hdHRlc3RhdGlvbi5odG1sCgoKCkFsZXgKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMg
RGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJs
aW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlz
cwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3
NzY0IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


