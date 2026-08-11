Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8D8C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtssF-00062j-2v; Tue, 11 Aug 2026 16:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtssC-00061v-Va; Tue, 11 Aug 2026 16:14:57 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtssB-00034U-In; Tue, 11 Aug 2026 16:14:56 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BDFE0140010C;
 Tue, 11 Aug 2026 16:14:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 16:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479294; x=1786565694; bh=BKJGtSgH1ZLQxOWjd04NukmNoq05iY7s
 Kif4wzlHA80=; b=iQ/W6RL/xnmIxnN5Rz7oOa2XZkj0OkYu/XLoAg5uNpcutPnY
 THV2K2tJRvTP0/+TLsn+ddSIkxWXDmhWQp2OfFH9mV1Szo1NdozOw2cNez4n0PZa
 aXfSNUfPbH2VFFx6a9A3CZONK7Vx5ipWG4S5j4MfX7qPPclhAEoG/4wHDlCteiFD
 k065UqbtadaVpecONs7oENxE0aUO330+2+RDbJ0mTNjU2R0ejUikqRWAlCpxzzcu
 T/XLROgUjODu0Fl+Z6eWTD3xAUi8L3HMy0ZS0IMRS6KB14/c+u5zqxuF8EsiANRK
 CKCVKQfSOJQms4ipRDJjf6PA08ICdcYnIrzAAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479294; x=
 1786565694; bh=BKJGtSgH1ZLQxOWjd04NukmNoq05iY7sKif4wzlHA80=; b=E
 +Lh9KGxPk0yLffxTwGMps7SC7TDE0n73ZYtD7SuKeFxIHnvWED4kDHg3UlouDkM1
 Pa/bAB6oc1amhnyqaczOCNypzyrFQq3U6XHnVIuE+StFBcbWa28RsqKm9UWG6TIr
 +55upg6wa12xVAwUiS68aaCj2l+E7+DanRaO9zM7yMrnB1stEcID91ZqsdPV87lk
 lt5B5LyH0CcK/Ui6fU5gGlfmIU0Gheg5uAlPHxAK2r8hON5bLcH0Ni3IOJU4CXYL
 4uPrBHXPzUrDU/NKlhuX6NLyxPkxyhCYUAb8F0oFSpaikDy3iMnh4rK8h6Bl5P88
 IYSx1PSHfAOAgLd+VfDoQ==
X-ME-Sender: <xms:voJ7amWKo7izJXhsKTln-yl3AMHkDVPzYgjrfHF0h4Idy9kuhan5Jg>
 <xme:voJ7am6WrFTQ3g_mjkOQ7E4gnJjPzX0IeR779O-R3DPkgX-bAv-800PmpJ1JtC0Zl
 Da2f72pQjgVFw0dbymmPU13FN6jS-rQB-297eTUbJ9zI8Y_17_gPJ4>
X-ME-Received: <xmr:voJ7apiTnwkqgr4bGW3lSXR8_iANsGej7suAA507u-llThXW4QPgxblWLhBEzHfvwpfXyg>
X-ME-Proxy-Cause: dmFkZTFZta5UxaGGIApcvgv1y3lZRIpz4NgU/tMknmwewHM6JYvuiT0ElGm9QBqsKK6eUT
 nlfSLf6+mmR0AhSio7FaZo5kY6yN518M5Zid9rBvLaQP3GZUNZjRMT6a7bPYfnEu2UHdpR
 zMEuLEUWm2Wkd1HKVvTyvHmfHOtKUVUgk0K1uLDD4DBou7g3/pHMmihgbLYK7KRKSmgjYQ
 pucba7K+FYGk+Jdoq2FNlIK21c3IasXlrfhwGeKv2INKABZTiTZ6kJ3e/391CDVrUoGzoW
 LhXvpLsSltsIHNIVY8mul5KVY8cCmFBnfuI3z1T33dBq/FfSs3WvKvhaY6s5jrVmX5JZdk
 eenLH1H7KJ/Fn+NPjj36esNG22cL6TO3S6zgfy0tUCmNG8VdHj0GPwKISdMzHEpCZl7cKy
 xZniMNaBwQlqiy+RdZv64uiYRW+4BpS0udyPCPzUBA/pE5zcX2Roc/Ro6xQjhOrReGigpc
 djNL0Gpky2+Ome4OOX9G+xrFE6iL1FmIN0uctTX0y4s5wPSkHQ+f5EaqD0Ymm/CHrxBkxs
 GS2nceWdyA7o7ZiHCcGScsKMBTiYlFjOlSbsOzRwFVatcNSxKj1vHX84Nt4iglRs0FcU6z
 f9ZRm797yijvqwE3ozpkadAFz8V3K+EbyTDZXHVF1sV0YLe/n1JrnYihPcqQ
X-ME-Proxy: <xmx:voJ7aldffgnpM7c4nixC7qMp1wBoPlcQ9ntgi-29aMZOz24awAB8lg>
 <xmx:voJ7amfKKB-1VIvT8Kpbbd1b_p5k5WUqBInnk-FSDUnIQ2NKgSZELw>
 <xmx:voJ7an879btcA5II0i_jvXtH1DigJhG2UyQ6rG3D0GimVHw38hc-VQ>
 <xmx:voJ7aqnqU8BAg0U-dsfuZVXe0X-f1ZeF0S_BG5L9zD-6nWLbvM349A>
 <xmx:voJ7ag4Vcl9CrUHeJxZYkLfU3SImNfZWl6XJJB9ohusnumeDYJNKkRKL>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:14:54 -0400 (EDT)
Message-ID: <cc45daab1c272162f1ae088c837f3629426b4cba.camel@alistair23.me>
Subject: Re: [PATCH 20/56] disas/riscv: Handle c.lui imm != 0 during decode
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:14:54 +1000
In-Reply-To: <20260809223545.730664-21-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-21-richard.henderson@linaro.org>
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
Y2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGRpc2FzL3Jpc2N2LmMgfCAxMiArKysr
KysrLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Rpc2FzL3Jpc2N2LmMgYi9kaXNhcy9yaXNjdi5jCj4gaW5k
ZXggNzk3OGZmYjM3OC4uZDZmYmIzYmNhNiAxMDA2NDQKPiAtLS0gYS9kaXNhcy9yaXNjdi5jCj4g
KysrIGIvZGlzYXMvcmlzY3YuYwo+IEBAIC0xOTAyLDkgKzE5MDIsOSBAQCBzdGF0aWMgY29uc3Qg
cnZfb3Bjb2RlX2RhdGEgcnZpX29wY29kZV9kYXRhW10gPQo+IHsKPiDCoMKgwqDCoCB7ICJjLmxp
IiwgcnZfY29kZWNfY2lfbGksIHJ2X2ZtdF9yZF9yczFfaW1tLCBOVUxMLCBydl9vcF9hZGRpLAo+
IHJ2X29wX2FkZGksCj4gwqDCoMKgwqDCoMKgIHJ2X29wX2FkZGkgfSwKPiDCoMKgwqDCoCB7ICJj
LmFkZGkxNnNwIiwgcnZfY29kZWNfY2lfMTZzcCwgcnZfZm10X3JkX3JzMV9pbW0sIE5VTEwsCj4g
cnZfb3BfYWRkaSwKPiAtwqDCoMKgwqDCoCBydl9vcF9hZGRpLCBydl9vcF9hZGRpLCBydmNkX2lt
bV9ueiB9LAo+ICvCoMKgwqDCoMKgIHJ2X29wX2FkZGksIHJ2X29wX2FkZGkgfSwKPiDCoMKgwqDC
oCB7ICJjLmx1aSIsIHJ2X2NvZGVjX2NpX2x1aSwgcnZfZm10X3JkX3VpbW0sIE5VTEwsIHJ2X29w
X2x1aSwKPiBydl9vcF9sdWksCj4gLcKgwqDCoMKgwqAgcnZfb3BfbHVpLCBydmNkX2ltbV9ueiB9
LAo+ICvCoMKgwqDCoMKgIHJ2X29wX2x1aSB9LAo+IMKgwqDCoMKgIHsgImMuc3JsaSIsIHJ2X2Nv
ZGVjX2NiX3NoNiwgcnZfZm10X3JkX3JzMV9pbW0sIE5VTEwsCj4gcnZfb3Bfc3JsaSwKPiDCoMKg
wqDCoMKgwqAgcnZfb3Bfc3JsaSwgcnZfb3Bfc3JsaSwgcnZjZF9pbW1fbnogfSwKPiDCoMKgwqDC
oCB7ICJjLnNyYWkiLCBydl9jb2RlY19jYl9zaDYsIHJ2X2ZtdF9yZF9yczFfaW1tLCBOVUxMLAo+
IHJ2X29wX3NyYWksCj4gQEAgLTMwMzIsOSArMzAzMiwxMSBAQCBzdGF0aWMgdm9pZCBkZWNvZGVf
aW5zdF9vcGNvZGUocnZfZGVjb2RlICpkZWMsCj4gcnZfaXNhIGlzYSkKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN3aXRjaCAoKGluc3QgPj4gNykgJiAwYjExMTExKSB7Cj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY2FzZSAyOiBvcCA9IHJ2X29wX2NfYWRkaTE2c3A7IGJyZWFrOwo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlZmF1bHQ6IG9wID0gcnZfb3BfY19sdWk7IGJyZWFrOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpbnN0ICYgKCgxIDw8IDEyKSB8ICgweDFmIDw8
IDIpKSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3dpdGNoICgoaW5zdCA+
PiA3KSAmIDBiMTExMTEpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2Ug
Mjogb3AgPSBydl9vcF9jX2FkZGkxNnNwOyBicmVhazsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRlZmF1bHQ6IG9wID0gcnZfb3BfY19sdWk7IGJyZWFrOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqAgY2FzZSA0Ogo=


