Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B06C5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsux-00079A-Fx; Tue, 11 Aug 2026 16:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsuQ-00071O-Pd; Tue, 11 Aug 2026 16:17:20 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsuO-0003UE-P5; Tue, 11 Aug 2026 16:17:14 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D3E2614000D7;
 Tue, 11 Aug 2026 16:17:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 16:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479431; x=1786565831; bh=Zq+1FF2Mdbr4WwA+N+KN4s2muT19L5Ro
 mLsImZYy0og=; b=hshnhv8bqucA6Z5tlZcQeCv7CD1vCBpUZOHBFNgwpyuvCKx6
 T7kan4K9By0LbVN0HF5RFyPRJfsGurHjVb8+eROBhaoF1xox6JqPcCbZJwRrT+rX
 2VGcimdnlX27r7I+g8LGQmSFEbCfB+i5ZrFBPVfBOKV4N6wfPytdNFqGZa0MWfeP
 hjbGPPyNydGknXdT0+WQvSmIZAw1yl3uNmnkONSMelAjNbSGPG+leElI23AE89hI
 9d8V4wvNRohHeDla8WVvkkLgM8KjT9okpv9Uhabe/82vTfFPQYbtjrus+fOzhrvf
 PVeWAu4n8D/QjGp9TUe76ohOEOH2FSsvtI3jVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479431; x=
 1786565831; bh=Zq+1FF2Mdbr4WwA+N+KN4s2muT19L5RomLsImZYy0og=; b=R
 Xq/yfByJLJ5e+OIg99l7DI4krMhKYOU5K9zC2+vQVAhzg6EDFVHNNStXAgN9wSeP
 6tiq3AhWl5CbDtheRAgjSIfsZgO8QhVOB3VDNv4WGAQH4BM2XT/HmNLMG+MrkgAV
 EX1vUzX3hGN8KiCZlGoeykw+VNj8l/0S39wXeQ141nIRFScBaW7oGe7yQlWshb/8
 PPl/ktceKEuMGu1QGLLDtvbbQOclzis8EciAt1YC/gEFfrTUOz24iwCend3+2QLj
 RwlT/j+Pu2HKmJKZY95fb6GDm8oPOly7Vmqit+lqVnG3CCUm8EbzPEHuanSPyAFk
 zeucNyQnG8a0dhNFnVuGg==
X-ME-Sender: <xms:R4N7akw53erukX_bth3fa1RSdz5mHEdbCwaXzMMI1N8ho0MlP4QXbQ>
 <xme:R4N7asmYUxkiHGSIXlP_USDdIHEQkazb5NskeHyJ8GWgXXr1DhKAaPpKPXyAvWhGb
 buoz17LGNkYWYy6--8JgYCeUdRwHVyIPG7XDJZL-XZR2frT8ACv8Q>
X-ME-Received: <xmr:R4N7aldWvealyTI6mG6Jmn6v7aqRkNcPIFGSPKB6CL0fZF0AxxtEuE5LlIM98xYWG0n_0g>
X-ME-Proxy-Cause: dmFkZTErKXul0Ur76yammtRiDIBB7QxDnKDTUBeU/L6MhEuwbl+cLUtNwqP3CA7/U9ggBC
 qTXJHPYuEGMoyTW/zMSLK52l4DL8R72eCYH4B4FypDWfOfDCNSM2TJUz8O7HoWvk8JGAnq
 yZnTPEaCPDzmh1sRAaSIm5dSHXYc+0SMRe2xB1Q54WV2yejj3b5TOa7ACzqRbv40fyOGwy
 k826IuqEUMD0pU3BjQseFS3CiW/gUegi/4muhUWHdwsRad01qFMOfsT6sCvCcAvgfgH517
 CavR6rRHMy41jVL6MSZyzgyRh43PQLSgnOu+GsQiZ0ynBGdBwxKK0vbU3yER96tOTfMrXw
 sXUgx8SBrbXtGRtuLsIuKXaCYjEGA7s2sUWTWsYsemJAmp7ifRbOeeF7gARRK+HSsdJb6m
 Pl/5U+EdElKvhGgz40cTW1suyOkhExy19hzz0994melFEfFUqqJihFdIKxp0yi80/l2XVP
 VV9QxBrnZqIRVopYqJCCS5w4m5alcZGbKTdcmUy5MbxqliKpjeMDcaK59JD7AMJp0drThQ
 W3eFfxFXYMbuMYSQglAf8diPoNScjpD1E3vvN13VpEFiCtd6HIseSwilVvDPtWdIaMmtNn
 nGvBDY8UZDvzdQ2jhyFJpZanU+N2UDwMX1hIFkTnS4YDyFUJxZEI1gp2mlmA
X-ME-Proxy: <xmx:R4N7aqrkNRaILaWiMFvAciaItEAvc2jROZ5VglVAFRVjZZjzgt9mLQ>
 <xmx:R4N7ar4gmU1Na4DtFLYicsg8VoghY2C-_mOruujpdzfeb9HrT_6_cA>
 <xmx:R4N7aoookHlwYQSe3arilBqqq-yz90TzVqrEZhqPAEfuyA_dto491A>
 <xmx:R4N7ali6ZrxXpvgcE3XWj2Fcb7-B_Uq45in7JlWhmu78fD-3i3qjgA>
 <xmx:R4N7apF3jmFnsIRY0oKDXts6Ro0SAXeIix-PcGlZsKvR3M9KiXsLshci>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:17:11 -0400 (EDT)
Message-ID: <cae3cfe375e13b5f1c7bb09daf9646f6c0304961.camel@alistair23.me>
Subject: Re: [PATCH 23/56] disas/riscv: Do not recognize c.{addw,subw} with
 rv32
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:17:11 +1000
In-Reply-To: <20260809223545.730664-24-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-24-richard.henderson@linaro.org>
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
ZToKPiBUaGVzZSBjb2RlIHBvaW50cyBhcmUgcmVzZXJ2ZWQgd2l0aCBSVjMyLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3Jn
PgoKUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNv
bT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKgZGlzYXMvcmlzY3YuYyB8IDEyICsrKysrKysrKystLQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2Rpc2FzL3Jpc2N2LmMgYi9kaXNhcy9yaXNjdi5jCj4gaW5kZXggNzczNDdi
NTU3ZC4uZGRjMmY3M2VhZSAxMDA2NDQKPiAtLS0gYS9kaXNhcy9yaXNjdi5jCj4gKysrIGIvZGlz
YXMvcmlzY3YuYwo+IEBAIC0zMDYwLDggKzMwNjAsMTYgQEAgc3RhdGljIHZvaWQgZGVjb2RlX2lu
c3Rfb3Bjb2RlKHJ2X2RlY29kZSAqZGVjLAo+IHJ2X2lzYSBpc2EpCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAxOiBvcCA9IHJ2X29wX2NfeG9yOyBicmVhazsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDI6IG9wID0gcnZfb3BfY19vcjsgYnJl
YWs7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAzOiBvcCA9IHJ2X29w
X2NfYW5kOyBicmVhazsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgNDog
b3AgPSBydl9vcF9jX3N1Ync7IGJyZWFrOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY2FzZSA1OiBvcCA9IHJ2X29wX2NfYWRkdzsgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjYXNlIDQ6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChpc2EgIT0gcnYzMikgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG9wID0gcnZfb3BfY19zdWJ3Owo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSA1
Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaXNhICE9IHJ2
MzIpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBv
cCA9IHJ2X29wX2NfYWRkdzsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDY6IG9wID0gcnZfb3BfY19tdWw7
IGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgNzoKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN3aXRjaCAoKGluc3QgPj4gMikg
JiAwYjExMSkgewo=


