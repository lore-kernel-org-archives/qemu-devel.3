Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A40C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsjH-0008Sx-9v; Tue, 11 Aug 2026 16:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsjG-0008Sk-Gs; Tue, 11 Aug 2026 16:05:42 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsjF-00013v-1p; Tue, 11 Aug 2026 16:05:42 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 10757EC0123;
 Tue, 11 Aug 2026 16:05:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 16:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478740; x=1786565140; bh=SaVBIfh3NzGCHvxL0dgXL7b2q4oZ4MvB
 h1zpIfAdci0=; b=cRWLGcf0ATTgqShZtcDOZ5ZinnZqaqXKtdosk2+nqRUwhIHh
 2pH1g5aM7h94xB0JzRhR9FNVomwPjZQfxY2/m7neDknj0dZjVSixwSwyGUZ/J3A+
 KVgiCtjduXZ+Mds4cAhXPJ6LtMEEdRBFCaisiZj/ajO+iw1JA3S+QbLpW4fnpL6o
 Xzv9hw4AwaedOA5i8zZGlrldxOxR5s845hV1+W3K6OFiwx6kxwLQ7JX2Jy8XXMAP
 QAy3q02CqWIxBefV1zpU6GmMQpd3qRKDv/Nig6/JoY3WHFKOz9jmEUxWG8NIyrPP
 krbQ7NnEm61VM8A2a1ihfR0AFrIbiX1Z4eyXig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478740; x=
 1786565140; bh=SaVBIfh3NzGCHvxL0dgXL7b2q4oZ4MvBh1zpIfAdci0=; b=e
 rC8Tte/aKnRiPq9+DdI7l2ht8HzDUFVO1LC7nabMY2PiSTmOnoldMWxRNrK4yIaL
 YqqjcaLY+muo7m5M78yhRq1YCROuLN3qgav/JhuY365ieVw4fPOonM1Bf7i+jnG0
 ywx0XqF0mlfHZhzY8N2i1BKUu9mXN7DTSwlxgoJbp+xyzMIOT312qjxi5R6slcfK
 NdOv7PJAIKLRVEnwp3FdyYKDboH1z3buhd8SEjPtFr25Vszr4PDTCkLlK664mpy/
 cspAKfe3CDpo2HctSa3De4isr7StLqCS11DXhFEeoFK8URqnmy5rmsrmMFAiJPur
 gsjCYl6IPx5IirazTEKgw==
X-ME-Sender: <xms:k4B7anwb__hAfYLTXShk8lDRUJGGw1uQQfktZA9oFeusGvKaYcU-AA>
 <xme:k4B7ajkHOLNpzPojVOpE_afjfZ5sFXruPZOU06GzsIn6ngrLA9jBAt6s-SdaOa8AS
 fcqHojwRKq-4Esw7S5vK0z82F6VnvpWSPXyrdTEXDYVEBybUzB_2Is>
X-ME-Received: <xmr:k4B7agf8eJd9q0jvkOSlqDtRhLwbFAl8n5ryXegZGLHlog5KfKzWPr4SsAu91wPG99O1og>
X-ME-Proxy-Cause: dmFkZTEk0NvhYgDdFRhySClqUZl7Do4b4Yw6wPiTMDxzfjVl4fHfsePpV1CkS3y0nS+zAB
 YuDBwCQDkdmdz+scwUU4DQjBV8T2KN0wpXzMrSUjgseP3T6uUXkRzj/lUuXmihIhozEPEX
 zAro/lWNqw+V/gSK4qD5rP81vzShLOd7lNy65EWoQSCx79JlUb7YfFGQW2C2xwEwhm7q8w
 C+OYfcA01l4ko73n5iJrMXN5DCI7b3N6PEH4m8fJWoaYk1EDMJa5+Hdk8nzF1n13D4h5Jq
 jGfUSSl9PyK5M58sxx6Go/Gq4hzxzU+M0OIlxBS4kgybWKeSW86Izy/JQyf03r7qBhwLDO
 TUAlyqOLmzM2Amp0J//KF0jkd/H44t4otIC1mnYS0zjiQjnO/2UNZxH2kSxXrbhtTF6sqa
 K++ulymhdh4KdjucKRZwAKEHo4yCJfvZjQCiahwd7mslU3r6UMJRmhCxQDVk8OjIkjEDN4
 fybhqKuNAvoIn/oz+MRKDIT46PSTjzVQXu65q80ru7PESkmZXhsd9iK02hAECzIQVP4ar+
 HoDKB0d3vYQ7OKytTrMyV1/oZyks8WoG2WnpnM/hZDDifftOJuk2NFNpKrY4qMobWJu786
 tzuOy+luiiAVxH/phU1mkux0Wp/MGxxMMjEljLXnKJIt2EBB7bUZch+UJt7A
X-ME-Proxy: <xmx:lIB7apqQN0v2ODnvmfnfxAoyXjGBaCiYQhWU5ABQZH4WCNAFBWZaWg>
 <xmx:lIB7au71CAGnbtYIQI7Ma1u_g9w8ui28ATL05Fgm7vK51eBafsi_iA>
 <xmx:lIB7avoN94F3a1d7E5KZwe3Za6TzWb41517SuYrZWUchv9Den-41mw>
 <xmx:lIB7aggLmWUFTUYogc2Iqqi-Q6QIHU-xvrknF1mX4hokWmqK4ABfdg>
 <xmx:lIB7aoFiRdH2vKoWm4CFTQxhI5IbG4mPoLg63_dPx6h_dl7dj11M2rmJ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:05:39 -0400 (EDT)
Message-ID: <6d1458c9899c367299c0c94995c43034fefdec0d.camel@alistair23.me>
Subject: Re: [PATCH 11/56] disas/riscv: Pass rv_opcode_data pointer to/from
 decode_inst_lift_pseudo
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:05:39 +1000
In-Reply-To: <20260809223545.730664-12-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=alistair@alistair23.me; helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gU3VuLCAyMDI2LTA4LTA5IGF0IDE1OjM1IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25A
bGluYXJvLm9yZz4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFu
Y2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGRpc2FzL3Jpc2N2LmMgfCAyNyArKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspLCAxMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZGlzYXMvcmlzY3YuYyBiL2Rp
c2FzL3Jpc2N2LmMKPiBpbmRleCA0N2ZhZTczMTZjLi4wYmUyZjA3NjEyIDEwMDY0NAo+IC0tLSBh
L2Rpc2FzL3Jpc2N2LmMKPiArKysgYi9kaXNhcy9yaXNjdi5jCj4gQEAgLTUzNTgsMjEgKzUzNTgs
MjIgQEAgc3RhdGljIEdTdHJpbmcgKmZvcm1hdF9pbnN0KHNpemVfdCB0YWIsCj4gcnZfZGVjb2Rl
ICpkZWMpCj4gwqAKPiDCoC8qIGxpZnQgaW5zdHJ1Y3Rpb24gdG8gcHNldWRvLWluc3RydWN0aW9u
ICovCj4gwqAKPiAtc3RhdGljIHZvaWQgZGVjb2RlX2luc3RfbGlmdF9wc2V1ZG8ocnZfZGVjb2Rl
ICpkZWMpCj4gK3N0YXRpYyBjb25zdCBydl9vcGNvZGVfZGF0YSAqZGVjb2RlX2luc3RfbGlmdF9w
c2V1ZG8ocnZfZGVjb2RlICpkZWMsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbnN0Cj4gcnZfb3Bjb2RlX2RhdGEgKm9wKQo+IMKgewo+IC3CoMKg
wqAgY29uc3QgcnZfb3Bjb2RlX2RhdGEgKm9wY29kZV9kYXRhID0gZGVjLT5vcGNvZGVfZGF0YTsK
PiAtwqDCoMKgIGNvbnN0IHJ2X2NvbXBfZGF0YSAqY29tcF9kYXRhID0gb3Bjb2RlX2RhdGFbZGVj
LT5vcF0ucHNldWRvOwo+IC3CoMKgwqAgaWYgKCFjb21wX2RhdGEpIHsKPiAtwqDCoMKgwqDCoMKg
wqAgcmV0dXJuOwo+IC3CoMKgwqAgfQo+IC3CoMKgwqAgd2hpbGUgKGNvbXBfZGF0YS0+Y29uc3Ry
YWludHMpIHsKPiAtwqDCoMKgwqDCoMKgwqAgaWYgKGNoZWNrX2NvbnN0cmFpbnRzKGRlYywgY29t
cF9kYXRhLT5jb25zdHJhaW50cykpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZWMtPm9w
ID0gY29tcF9kYXRhLT5vcDsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZWMtPmNvZGVjID0g
b3Bjb2RlX2RhdGFbZGVjLT5vcF0uY29kZWM7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuOwo+ICvCoMKgwqAgY29uc3QgcnZfY29tcF9kYXRhICpjb21wX2RhdGEgPSBvcC0+cHNldWRv
Owo+ICvCoMKgwqAgaWYgKGNvbXBfZGF0YSkgewo+ICvCoMKgwqDCoMKgwqDCoCB3aGlsZSAoY29t
cF9kYXRhLT5jb25zdHJhaW50cykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChjaGVj
a19jb25zdHJhaW50cyhkZWMsIGNvbXBfZGF0YS0+Y29uc3RyYWludHMpKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZWMtPm9wID0gY29tcF9kYXRhLT5vcDsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wID0gJmRlYy0+b3Bjb2RlX2RhdGFbZGVjLT5vcF07
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZWMtPmNvZGVjID0gb3AtPmNvZGVj
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBfZGF0YSsrOwo+IMKg
wqDCoMKgwqDCoMKgwqAgfQo+IC3CoMKgwqDCoMKgwqDCoCBjb21wX2RhdGErKzsKPiDCoMKgwqDC
oCB9Cj4gK8KgwqDCoCByZXR1cm4gb3A7Cj4gwqB9Cj4gwqAKPiDCoC8qIGRlY29tcHJlc3MgaW5z
dHJ1Y3Rpb24gKi8KPiBAQCAtNTQ2NCw3ICs1NDY1LDcgQEAgc3RhdGljIEdTdHJpbmcgKmRpc2Fz
bV9pbnN0KHJ2X2lzYSBpc2EsCj4gdWludDY0X3QgcGMsIHJ2X2luc3QgaW5zdCwKPiDCoMKgwqDC
oCBvcCA9ICZkZWMub3Bjb2RlX2RhdGFbZGVjLm9wXTsKPiDCoMKgwqDCoCBkZWNvZGVfaW5zdF9v
cGVyYW5kcygmZGVjLCBpc2EsIG9wKTsKPiDCoMKgwqDCoCBvcCA9IGRlY29kZV9pbnN0X2RlY29t
cHJlc3MoJmRlYywgaXNhLCBvcCk7Cj4gLcKgwqDCoCBkZWNvZGVfaW5zdF9saWZ0X3BzZXVkbygm
ZGVjKTsKPiArwqDCoMKgIG9wID0gZGVjb2RlX2luc3RfbGlmdF9wc2V1ZG8oJmRlYywgb3ApOwo+
IMKgwqDCoMKgIHJldHVybiBmb3JtYXRfaW5zdCgyNCwgJmRlYyk7Cj4gwqB9Cj4gwqAK


