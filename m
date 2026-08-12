Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A119C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8P3-0007Uo-Bx; Wed, 12 Aug 2026 08:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8Oz-0007UK-Uj; Wed, 12 Aug 2026 08:49:50 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8Oy-0000Ln-K5; Wed, 12 Aug 2026 08:49:49 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 835AEEC018A;
 Wed, 12 Aug 2026 08:49:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 12 Aug 2026 08:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786538987; x=1786625387; bh=3uFfDkNnuNw+liwmKckX5bJ+ZPNHJxbS
 5zGGNr2vHwo=; b=Zmiv1FfmjImtFQIl86XpBmp4WoSdf/QjDV1Bn0JzPBbSp0Qz
 pCIOWRHLUro8OCzMaALimFGhiEyRdZR/1x3d3PbuTSXAg0LMrr7eyh5sHDE9YmIm
 CvoKaxzqzwycmPk0zap8RNpJCssMBh6DKI7T/dAXTx9QC3jj2FJ3nxg8tbHrxqwP
 XR1HObI5cD1rHHjOu2VZTNMtOkCkw0sR/JSNs2QmKzSRpYZcd6bx9AabQ8xSAj4i
 iyhSXaUA4cC17r532WtH9+KNFuj9+Q4ZoNNcYajf/ymd16/l5QSf8GSVHBS1/8+d
 AbsTIgjVLZ041hxVlxu/roWU8l3yKmj2LO/uQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786538987; x=
 1786625387; bh=3uFfDkNnuNw+liwmKckX5bJ+ZPNHJxbS5zGGNr2vHwo=; b=C
 eb8Cs5MHHgEEDVo0AuBFlCOp9iWhm2Nnaj5z6MZCf6a7Q9XW0AiXSbIMDGtHyPv0
 UK7Jk5mFzr+LjUMqfthVrshqvpvuPMGOIKWR46Op4KSHMRUIMeUmnVouyPiCBYyx
 +qkJxphIXVTgTVWrSuDZ21agLiQ2FRMzgAXCP1irDp+Eroo8kqSAXiuGNm+GJQ/1
 sUx9XwyVypAlgZojlI25/Ba5ZcgPQQi9a+lvc3xh+B1WeO6KUj0bgQ5VExl+Luw0
 vkglM3gFf5LeQTmzNS1t86J16yvBxmZilTJUk976v3EVv5xHDRNqbmO9rKzmfaBr
 v+zdGiHSBGkQy044dFDOQ==
X-ME-Sender: <xms:62t8ah5CU3_iE6LudtknP90bsX2Zlbi7yf0lb4xxm2e_ErFuCBLWQw>
 <xme:62t8avCbEwZLO_K5qkrZ7YWBWoO0Bktcx-Sx-8l4a5Ks_e4MYxse-hXSpQI33jcvU
 0i3BxQK_6tnDwcfcCAU1IqbeKi6q7VtxRem0QEYty8VPcss9Z-q-VQ>
X-ME-Received: <xmr:62t8agYPhoMsYJVF5PdUakhTXfE_BZ8_5sv1Q0Vx8d2vYgEWuVcayqBUq6MSrfp7tkCurw>
X-ME-Proxy-Cause: dmFkZTF4h0IkpqtSbk/3mvIC32NCwDgM98chb1qg+KPXJobl8eBBKF+HoMKtBxqd4xo28w
 u7SAQuCv/anQ5M3MsOP/md9gbf7yokDaBm2j1acXeZKluhdHo3OUxSLSUvdxd9dDHVkg2G
 nP64bRCaVUdORneNBtWU5VtqCzj+J7l4x5CiOXPH94luHBjQaY7lU0fyl7Y81RcAPpD0Qx
 vXo8TKP36fF6ZiSU1XsNNv3aCVromDSoFj/FJgqsyrwV0i8+e2/P82tKooLgI+RJ+LOPoP
 yj/u9yBIyYGd77FKe/uTIrbrvdVYtXvIu8CWLO+berYKt5pSZaH3ETBJD2JvVZT5Wq6YT5
 zf+j5BWL3nhF2C24OAWMsiVt+esPMyUq3nrTC1arFsukjcv50BYlBO2S24YzMSN822ohJh
 UJMd5rqbqrBNGQIciawQnriTVlPy5+Cu1E1u8nHLvbqHlW+R4rdDIbZN+u4eSPVkp/wBX3
 l51cekKRTJAcQJ7AftaqP0y80g3rRe+bIB8+1DgEcvBak0eXYb05pEfW8tqGSFko/aWPws
 rif4UvnC8FedGnK9MBv8y/po9O/YpUOYB5K8dtcB0CkJsGUdVxtp2kEWK6WRppMb5aClih
 LUmcMlAU5QrXX/fSLBABN+/SYc9HX9X/k5f9pqpShmjzvJF50YKsnR2O9m3g
X-ME-Proxy: <xmx:62t8aiaKSuLNXurt1jo52DWQr0b8NO-HhkXR2mDV4UbrUx6ZYGyVoA>
 <xmx:62t8av8DzQ4fr79iHUwUGVpASUMg8aimNaPGo5E7EEFsLq5J7WiYiw>
 <xmx:62t8apjbFSlCCB6oZGJjR-Ob3sbQYNBjTYE0nqLqNbpRQX_J1Fh32g>
 <xmx:62t8andF-g6TbXKIlj-_uJTHPFOi75LXpPn9zV9x9dh4t9igQ1co3g>
 <xmx:62t8amTmKFF1ZDoMayU2wA2n5RCD0Q91hRv6PgZy2M5m6UnnU8MKcpCf>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 08:49:47 -0400 (EDT)
Message-ID: <527b6d7168471d34ae700942d183e270fc4f505e.camel@alistair23.me>
Subject: Re: [PATCH 42/56] disas/riscv: Fix rv32 encoding of zext.h
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-stable@nongnu.org
Date: Wed, 12 Aug 2026 22:49:46 +1000
In-Reply-To: <20260809223545.730664-43-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=alistair@alistair23.me; helo=fout-a2-smtp.messagingengine.com
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
ZToKPiBGb3IgcnY2NCwgcGFjayB3aXRoIHJzMiA9IDAgZG9lcyBub3QgZW5jb2RlIHpleHQuaC4K
PiAKPiBDYzogcWVtdS1zdGFibGVAbm9uZ251Lm9yZwo+IEZpeGVzOiAwMmMxYjU2OWExNSAoImRp
c2FzL3Jpc2N2OiBBZGQgWmJbYWJjc10gaW5zdHJ1Y3Rpb25zIikKPiBTaWduZWQtb2ZmLWJ5OiBS
aWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KClJldmlld2Vk
LWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+CgpBbGlzdGFp
cgoKPiAtLS0KPiDCoGRpc2FzL3Jpc2N2LmMgfCA3ICsrKystLS0KPiDCoDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Rpc2Fz
L3Jpc2N2LmMgYi9kaXNhcy9yaXNjdi5jCj4gaW5kZXggZjUxZDQ1Njc0ZS4uOTQ0MmE2YzExNSAx
MDA2NDQKPiAtLS0gYS9kaXNhcy9yaXNjdi5jCj4gKysrIGIvZGlzYXMvcmlzY3YuYwo+IEBAIC0z
NTA2LDkgKzM1MDYsMTAgQEAgc3RhdGljIGNvbnN0IHJ2X29wY29kZV9kYXRhCj4gKmRlY29kZV9p
bnN0X29wY29kZShydl9kZWNvZGUgKmRlYywgcnZfaXNhIGlzYSkKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY2FzZSAxNDogb3AgPSBydl9vcF9yZW07IGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjYXNlIDE1OiBvcCA9IHJ2X29wX3JlbXU7IGJyZWFrOwo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjYXNlIDM2Ogo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3dpdGNoICgoaW5zdCA+PiAyMCkgJiAwYjExMTExKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjYXNlIDA6IG9wID0gcnZfb3BfemV4dF9oOyBicmVhazsKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlZmF1bHQ6IG9wID0gcnZfb3BfcGFjazsgYnJlYWs7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaXNhID09IHJ2MzIgJiYgISgoaW5z
dCA+PiAyMCkgJiAwYjExMTExKSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBvcCA9IHJ2X29wX3pleHRfaDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0gZWxzZSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9w
ID0gcnZfb3BfcGFjazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNhc2UgMzk6IG9wID0gcnZfb3BfcGFja2g7IGJyZWFrOwo=


