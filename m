Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CB8C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsu0-0006pL-DS; Tue, 11 Aug 2026 16:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtstu-0006lB-26; Tue, 11 Aug 2026 16:16:42 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtstr-0003Oa-7Q; Tue, 11 Aug 2026 16:16:41 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D55611400030;
 Tue, 11 Aug 2026 16:16:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 16:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479396; x=1786565796; bh=NR46g3liP2Syf5dLCi9XtGnekYcUAFXJ
 PqEYtJdaJjE=; b=bwAfljaxlEwe3rGac3cNoeakDqkjiw6wQt3yx4ZFzJhfYTSG
 4zr10vEtGeKwvQS3ZcTOSt+a1tnOdZe2HONJeLd03WGT87N4V4QaekGpAvHj3K2s
 nzRC61F8ZknkV8Cf9oZdFn/YELp4WpgD6beTpb8FCWqhlnoogNeGc5ynbtDP2mJ4
 5ZylNuHMX3ImVledZCsGunr/OPOXdXA9DU2VAvLNwGFG3G093H2gFuJk7ybrFdht
 9FFMO9D7d1u0AWL0X2NHa1F0v9M/EG1hKmlOakyU4WYKTaPtZp0QtWIQNAkMb63g
 YRcIjxv4UFYAeomn9RAgy5Iee8arYLBAcs5R6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479396; x=
 1786565796; bh=NR46g3liP2Syf5dLCi9XtGnekYcUAFXJPqEYtJdaJjE=; b=e
 OyF/pGiAVpHchENkrw3eN0Kix4BiOFyliVus1Q3RUVYhIH7XJfKxqzf4wp148EHp
 A1MdlatgzPb+0V/dn/4JyH4HE+hbyzCxqpIAiLbeWXwHLfEnOmimccsVhyvfLdYD
 rD5a1EDXRaLiUyMZ3cjQ1sGaps+MQBWCTejWiT97VmJ0uxvO2UKvATQ0p6HjcO8k
 aZ32CEYF1AdJQE5x4KtVw10Z3H9yDiekxPi7HOgCRPT6avn7XRQgboraygCvlr7m
 ILL6XHr0nj8LYtwTm8WvUGWhf9BWyq0frgd5ivQok5q7aHhUkp+FrpYaymMwGGaR
 JchD4MVvPq+RQfl9FLfNw==
X-ME-Sender: <xms:JIN7akKH84yqNrO9MkQWEuikFA--v1LS-IBV-HoqVyZuKmeNTo9OqA>
 <xme:JIN7aofOpVnD2Lg_VhlaXaVBReSuvGftYijHl2QV58J8_LkaW4p0JhnC0wFS9-htM
 B89I4wSRW0xGr2f5g2s28jAbIVwQIJK7Hp70MVWBzSc86PzUiyz-x4>
X-ME-Received: <xmr:JIN7aj3sLnVGw2mQwAPO0wVOYrHXTPNRi6dcpkmv7fmpPwoP63fRUUU5nLAw0wY9zxjThQ>
X-ME-Proxy-Cause: dmFkZTFZta5UxaGGIApcvgv1y3lZRIpz4NgU/tMknmwewHM6JYvuiT0ElGm9QBqsKK6eUT
 nlfSLf6+mmR0AhSio7FaZo5kY6yN518M5Zid9rBvLaQP3GZUNZjRMT6a7bPYfnEu2UHdpR
 zMEuLEUWm2Wkd1HKVvTyvHmfHOtKUVUgk0K1uLDD4DBou7g3/pHMmihgbLYK7KRKSmgjYQ
 pucba7K+FYGk+Jdoq2FNlIK21c3IasXlrfhwGeKv2INKABZTiTZ6kJ3e/391CDVrUoGzoW
 LhXvpLsSltsIHNIVY8mul5KVY8cCmFBnfuI3z1T33dBq/FfSs3WvKvhaY6s5jrVmX5JZBg
 /DE+oj5b2OjrXbPfbVWWYZmqg0aFfMBelBTFp7/bicXAlVFdNkE2XMRWl+P6d3n8R1n3Jz
 OMPk0GZSSjSoB9O9/65IPLtXNKWHtDgHfrn+baQhbsI0hEXvOya7+WX8EX0eJrdm9f0+rc
 bsMkXNtCNWr/5bunTFws8AAe10wo6JCrhPuC199JhNJMV555Z4eaYPD+u/qYbtC92+K+PL
 sMDQiNWresgz91DBuDI4w3aNGqGgWh4t+0eoHz1+bjR0IsLwYMXhfNHUMUTSRwWHoIJoqG
 3Bevz3/A5+fKS/QMyWJ6Do7eEVAk741mlZfbMV5ZW5xin+3ZtYXW2clknJTA
X-ME-Proxy: <xmx:JIN7aphbR20BWLWUWO38_TAYerOdL_amz4j4huON8Bt4bZ0mMO-5pA>
 <xmx:JIN7ahSYShhhW9b8Uo31kvXzwIxC0Q7L1px8kvLYgTv_Tuu5hhJFGA>
 <xmx:JIN7aig8n8_DSSl9ALzwsboG0wOETJGjSV6yuPPj8DpMiFisTndl8w>
 <xmx:JIN7ap4IGgZ4-2rx2bUd8RLbfflrze0xZxCP2Z3GaHFvggA2CXBoYQ>
 <xmx:JIN7al8tCdlhfLgPveLhRjMlJbw5Ua9jbmZNQ3YbyZna9zOjvIihwNeN>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:16:36 -0400 (EDT)
Message-ID: <12ca5333c52f90eac8cae9248460b37437f3217e.camel@alistair23.me>
Subject: Re: [PATCH 22/56] disas/riscv: Handle c.slli imm != 0 during decode
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:16:36 +1000
In-Reply-To: <20260809223545.730664-23-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=alistair@alistair23.me; helo=fhigh-a6-smtp.messagingengine.com
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
Y2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGRpc2FzL3Jpc2N2LmMgfCA2ICsrKyst
LQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvZGlzYXMvcmlzY3YuYyBiL2Rpc2FzL3Jpc2N2LmMKPiBpbmRleCBhOGZi
ZWZiOWJkLi43NzM0N2I1NTdkIDEwMDY0NAo+IC0tLSBhL2Rpc2FzL3Jpc2N2LmMKPiArKysgYi9k
aXNhcy9yaXNjdi5jCj4gQEAgLTE5MzAsNyArMTkzMCw3IEBAIHN0YXRpYyBjb25zdCBydl9vcGNv
ZGVfZGF0YSBydmlfb3Bjb2RlX2RhdGFbXSA9Cj4gewo+IMKgwqDCoMKgIHsgImMuYm5leiIsIHJ2
X2NvZGVjX2NiLCBydl9mbXRfcnMxX3JzMl9vZmZzZXQsIE5VTEwsIHJ2X29wX2JuZSwKPiBydl9v
cF9ibmUsCj4gwqDCoMKgwqDCoMKgIHJ2X29wX2JuZSB9LAo+IMKgwqDCoMKgIHsgImMuc2xsaSIs
IHJ2X2NvZGVjX2NpX3NoNiwgcnZfZm10X3JkX3JzMV9pbW0sIE5VTEwsCj4gcnZfb3Bfc2xsaSwK
PiAtwqDCoMKgwqDCoCBydl9vcF9zbGxpLCBydl9vcF9zbGxpLCBydmNkX2ltbV9ueiB9LAo+ICvC
oMKgwqDCoMKgIHJ2X29wX3NsbGksIHJ2X29wX3NsbGkgfSwKPiDCoMKgwqDCoCB7ICJjLmZsZHNw
IiwgcnZfY29kZWNfY2lfbGRzcCwgcnZfZm10X2ZyZF9vZmZzZXRfcnMxLCBOVUxMLAo+IHJ2X29w
X2ZsZCwKPiDCoMKgwqDCoMKgwqAgcnZfb3BfZmxkLCBydl9vcF9mbGQgfSwKPiDCoMKgwqDCoCB7
ICJjLmx3c3AiLCBydl9jb2RlY19jaV9sd3NwLCBydl9mbXRfcmRfb2Zmc2V0X3JzMSwgTlVMTCwK
PiBydl9vcF9sdywKPiBAQCAtMzA4NSw3ICszMDg1LDkgQEAgc3RhdGljIHZvaWQgZGVjb2RlX2lu
c3Rfb3Bjb2RlKHJ2X2RlY29kZSAqZGVjLAo+IHJ2X2lzYSBpc2EpCj4gwqDCoMKgwqAgY2FzZSAy
Ogo+IMKgwqDCoMKgwqDCoMKgwqAgc3dpdGNoICgoaW5zdCA+PiAxMykgJiAwYjExMSkgewo+IMKg
wqDCoMKgwqDCoMKgwqAgY2FzZSAwOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wID0gcnZf
b3BfY19zbGxpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpc2EgIT0gcnYzMiB8fCAo
aW5zdCAmIDB4MTAwMCkgPT0gMCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
b3AgPSBydl9vcF9jX3NsbGk7IC8qIG9yIHVuc3BlY2lmaWVkIEhJTlQgKi8KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IMKgwqDC
oMKgwqDCoMKgwqAgY2FzZSAxOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaXNhID09
IHJ2MTI4KSB7Cg==


