Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963A5C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwAZ4-0001d2-6B; Mon, 17 Aug 2026 23:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wwAYu-0001Wl-TS; Mon, 17 Aug 2026 23:32:28 -0400
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wwAYt-0007Wn-CB; Mon, 17 Aug 2026 23:32:28 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 124ED1D0004B;
 Mon, 17 Aug 2026 23:32:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 17 Aug 2026 23:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1787023945; x=1787110345; bh=J+oP1YeSpJysHkBhy46hHtGeEiUpiQEi
 WqC9r9t5nNk=; b=gbg6YDFAUG/Dl1rf3pj/EtgZFUad3vW4xzZpSmdKTqhvQUZU
 C2dI9yiKSeJ1O7O60DwizvgU7AaNfpFN6uhFAquBavxz74WVHlGFlZ8A33rcTbMW
 fKm2Tl9Si7xLQT2vQBSUQFBYrBC3ksIHbb4r1sIutJ1MceDPkBBcZs1NYde/U/6e
 Scjgn07VsIjCRx/eE9OAmm3oD1zqQNrVHNAstGUSxUGVDaxawYAcxTCknOw3LF0r
 +rOOn0WacBkU7lHSDjrnz66jlqpwhUU01muj9ffRz7XrwKmj6KiztXbcbjxiOKT5
 Lxc6/0sR5qnCDjeojJWg+uTJWNglEXxkyLdbXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787023945; x=
 1787110345; bh=J+oP1YeSpJysHkBhy46hHtGeEiUpiQEiWqC9r9t5nNk=; b=E
 8eA35q8vc6ijR3c8C8laqnQjLPFY2//UI1Mlu75R9fGGUXtN3saGqy4sWmWY2MrT
 YidrtejRTiCmqop737xLPe73IzTv37AtZ+kBZyTTr321WpH2i8AXDlzVn4R6JcY+
 09wumnRGrT13pzQZA7hbXsKf+8gU6bchcoaA80q0KMhDyaDXF/+NdPJMXn086izu
 JlKmloQAESU7CFibvw1UcCyItRFZl012Qtc9I/25CERCH9f6Qo9mVrdYHHgFQZre
 mU0WOCz4ErIS4IVvkkhn0RhT1fy1BwCBMQdZxe5TrQFNzFhItkcaTeAv74jb2Ccd
 bz/n/G2X1LhC7fx07hZpA==
X-ME-Sender: <xms:SdKDajb0eiQX6B9Ht0H-GaZCAIWTGn1hpOWwvxoeQAeTcj0a2a7W9g>
 <xme:SdKDaigAHADDycKWFvHkxVQiRo681qNEc19PWIRqklo0Bu9rY5QmEhZndO7vn4U71
 wjsxVo6XrDQjgQQmWdqHybo7jtnhStTnx0FuzMF7e47F49AMmyvhxA>
X-ME-Received: <xmr:SdKDat4Kw3ZY87N01VQzm_cj3aw5pqkvdsZeqQ1tudwoWI21CdAftkjdLQFoMmxj-yuIxqvapNcLPitlcYYFAkFMlhY>
X-ME-Proxy-Cause: dmFkZTGPFYID+zTiYQaqLZYysGzD6u8s2u5JFzTDdL+uP08foKUR6FQRRcGFuf+DiztYEi
 Jk1yx1EaFZ4j+OWoMGUdyeHfsPkbMa2TVqWU3edDO6SbbnNk+9KzUuXdbJdLCSgYEocT3B
 hdAayYNaTY/+dPaz5sVlGeZyq6E2D8STT85Ibmd1BCTTX8fmN2YvRmrygDyqom09xAjSFy
 iM6vZRcekPKjOwEV5v6Kg6+nq9iPvCv5veOwl8zWqfTchsaa0C1Xq5rAIIJNt5iJRJPlIF
 /LzuXkumz10ROfaEaZfn5MGgRKFXYDi9oIejoLOi7RSSko9sFIwiPAZ+UspKai3vp2SBq7
 VluejUAVWzFD5+n5WUceepFJan06xYPRtdGJnQ7C4OuwGDust+w17Bt5iTdJd9fgdrOTAt
 WRisLp9jmcEfaKcUDbpcvNchC/fPoQeGdyVeHABAeoQAJNGJh5z476pKwrgYeXgmsRGeVV
 YPaSIY/FxgFoIL0VIomvQ7mAOeMHU+BbbxcGhuPkBbwx3YmHjkk6pL9lrlmYnmqaIpY+Ik
 SmN+y983b8ZL9aPv6TGqxxgr/pwU+a5P6a9G6nHLKI0uEjc+hgQGyuPI7DEcbryBPeaFxK
 DkC+gyMrtrmSemuNyqWsCFutAWm6z7l2zBSP/qw64uNGKa5n3wJUZW6pLzcw
X-ME-Proxy: <xmx:SdKDah7Vpbi5WrzQkOzBH03k6tlsZWyUjuZ-NYOTUtf_YXIjg3jQqw>
 <xmx:SdKDape_poXUBCiXZkIXJKzZJJOnaV_NwPDxE0TzsBSbAdgp73FkaA>
 <xmx:SdKDalBLdSJnofA8lSJ96291MDEsUl4f8qO3dDybCceUIR_fVOTluQ>
 <xmx:SdKDas8mnIjFMzYTCp6hVyvDDyW9vUGlkN1PLDwkl4C-0yxlyTUcdQ>
 <xmx:SdKDauu_fDyC7ItNcJJXx7up_Aa_S81P-O4l9SEisJIT52npnnMdXKsT>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 23:32:24 -0400 (EDT)
Message-ID: <bbffcf904f22fb15cd459c59f783faee7966cacf.camel@alistair23.me>
Subject: Re: [RFC PATCH 15/18] target/riscv: Use boolean logic in
 pmp_hart_has_privs
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Date: Tue, 18 Aug 2026 13:32:22 +1000
In-Reply-To: <20260815203730.1468365-16-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.148;
 envelope-from=alistair@alistair23.me; helo=fout-b5-smtp.messagingengine.com
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

T24gU2F0LCAyMDI2LTA4LTE1IGF0IDEzOjM3IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBXaGlsZSBhZGRpdGlvbiB3aXRoIGJvb2wgdmFyaWFibGVzIGlzbid0IHdyb25nLCBhcyB0
aGV5IHByb21vdGUKPiB0byBpbnQsIGl0J3Mgb2RkLsKgIFVzZSBub3JtYWwgYm9vbGVhbiBvcGVy
YXRvcnMgaW5zdGVhZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmlj
aGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lz
IDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoHRhcmdldC9y
aXNjdi90Y2cvcG1wLmMgfCAxOCArKysrKysrKystLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Rhcmdl
dC9yaXNjdi90Y2cvcG1wLmMgYi90YXJnZXQvcmlzY3YvdGNnL3BtcC5jCj4gaW5kZXggNWVhMGU1
YjZjMy4uZmMwMzVjOTVjZiAxMDA2NDQKPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL3BtcC5jCj4g
KysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuYwo+IEBAIC00MTMsMTYgKzQxMyw4IEBAIGJvb2wg
cG1wX2hhcnRfaGFzX3ByaXZzKENQVVJJU0NWU3RhdGUgKmVudiwKPiBod2FkZHIgYWRkciwKPiDC
oMKgwqDCoMKgwqDCoMKgIHMgPSBwbXBfaXNfaW5fcmFuZ2UoZW52LCBpLCBhZGRyKTsKPiDCoMKg
wqDCoMKgwqDCoMKgIGUgPSBwbXBfaXNfaW5fcmFuZ2UoZW52LCBpLCBhZGRyICsgcG1wX3NpemUg
LSAxKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoCAvKiBwYXJ0aWFsbHkgaW5zaWRlICovCj4gLcKg
wqDCoMKgwqDCoMKgIGlmICgocyArIGUpID09IDEpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInBtcCB2aW9sYXRpb24gLSBhY2Nlc3MgaXMg
cGFydGlhbGx5Cj4gaW5zaWRlXG4iKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqYWxsb3dl
ZF9wcml2cyA9IDA7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+IC3C
oMKgwqDCoMKgwqDCoCB9Cj4gLQo+IMKgwqDCoMKgwqDCoMKgwqAgLyogZnVsbHkgaW5zaWRlICov
Cj4gLcKgwqDCoMKgwqDCoMKgIGlmIChzICsgZSA9PSAyKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIGlm
IChzICYmIGUpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqIElmIHRoZSBQTVAgZW50cnkgaXMgbm90IG9mZiBhbmQgdGhlIGFkZHJl
c3MgaXMgaW4KPiByYW5nZSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGRvIHRoZSBw
cml2IGNoZWNrCj4gQEAgLTUxNyw2ICs1MDksMTQgQEAgYm9vbCBwbXBfaGFydF9oYXNfcHJpdnMo
Q1BVUklTQ1ZTdGF0ZSAqZW52LAo+IGh3YWRkciBhZGRyLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICovCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAocHJpdnMgJiAqYWxs
b3dlZF9wcml2cykgPT0gcHJpdnM7Cj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4gKwo+ICvCoMKgwqDC
oMKgwqDCoCAvKiBwYXJ0aWFsbHkgaW5zaWRlICovCj4gK8KgwqDCoMKgwqDCoMKgIGlmIChzIHx8
IGUpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9F
UlJPUiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgInBtcCB2aW9sYXRpb24gLSBhY2Nlc3MgaXMgcGFydGlhbGx5Cj4gaW5zaWRlXG4iKTsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqYWxsb3dlZF9wcml2cyA9IDA7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+ICvCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqAg
fQo+IMKgCj4gwqDCoMKgwqAgLyogTm8gcnVsZSBtYXRjaGVkICovCg==


