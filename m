Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DF1C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsq8-0003Z6-AJ; Tue, 11 Aug 2026 16:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsq4-0003We-MR; Tue, 11 Aug 2026 16:12:44 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsq0-0002Zn-Pj; Tue, 11 Aug 2026 16:12:43 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C3DFC1400106;
 Tue, 11 Aug 2026 16:12:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 16:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479159; x=1786565559; bh=itLpEMn5RwBYgxEuJx3kiGJm+UE6UTb8
 318EzyzCW/c=; b=XZdHzrbr1Duihj7ASySOlYUWnBELipQOZ77wQLw64WNlKRiL
 COswuk7zPHn5ecuD7gYdGx3sDXlt3tOKByRz5VE7d9WjO+M8rJiv4SQLDkPOocov
 rbNTfvYmCkqeZc1QuH2iL8tauz8+aBOOnCKQDj7NJ9p84T8Xdz7DGtv626+Q1ei4
 rZFYsdliMhskeyXUwPPPhw2X/HLYlQL/IqBurSb3qIz9qeCFE31T7Evr3vpGNPeA
 Wvd+smmHg3w9Ff+qMLGu2GfcdRUUZEsrwLyalJCzPPCS7d5P9sknkg69M2bpG/ti
 OqfPvZJ13HSWs67+eLUwJaLJ5aK3Q1fmaL+l1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479159; x=
 1786565559; bh=itLpEMn5RwBYgxEuJx3kiGJm+UE6UTb8318EzyzCW/c=; b=D
 TeRakCZ26g/I+1gWpa0gwUzcZF+Y6lLWZ2g9llE6/5ptrbE7+P6XAm1zF+WQsIQt
 Ln+iUDqOanpgwDdfjLmdp1UswNq89qGpU+i/CmJpKl1FMco39DkEeum1qY6iewbl
 RHElpmhJwHzG7NvOwLaJENtCERFSJJ53fTcRL9Gif+eslLz5hcrkBxi9zBAiWRlM
 9dLZrS09+M+77OcyI3rkGyYM/Rmr4+wcnv3RMTIVCyFiFWZxoDhEB/9dZ5ARmeFI
 azS87SaLQQji7ZVGkSPPTtw1lUok77E1JzpHb5cMl5jOCvzxOI2VUWxhb/3md6Pt
 mkgC3qky5znqU8ox7TGMg==
X-ME-Sender: <xms:N4J7ao3gXY56tISrJgP5oSxbhMQx_RUy2H_eDcLuOdRA8wwwpats2w>
 <xme:N4J7anY1S9tCS1VmHdeYuz3Zf_L919VvPvV9ZMpL8C0eOQQjtb2Ol5zl7vwtwwJj4
 JSXFDu1WMgWcSxV4blvpYE87OBNdOjUt4s6KDyXzPvG-I-fKaKFwA>
X-ME-Received: <xmr:N4J7agB6amlU3mrHr6ULwjzhRYVnlDnotAPisxNEh7eA1F7H0K9jPlAIkIeTy_FTW1POCw>
X-ME-Proxy-Cause: dmFkZTFZta5UxaGGIApcvgv1y3lZRIpz4NgU/tMknmwewHM6JYvuiT0ElGm9QBqsKK6eUT
 nlfSLf6+mmR0AhSio7FaZo5kY6yN518M5Zid9rBvLaQP3GZUNZjRMT6a7bPYfnEu2UHdpR
 zMEuLEUWm2Wkd1HKVvTyvHmfHOtKUVUgk0K1uLDD4DBou7g3/pHMmihgbLYK7KRKSmgjYQ
 pucba7K+FYGk+Jdoq2FNlIK21c3IasXlrfhwGeKv2INKABZTiTZ6kJ3e/391CDVrUoGzoW
 LhXvpLsSltsIHNIVY8mul5KVY8cCmFBnfuI3z1T33dBq/FfSs3WvKvhaY6s5jrVmX5JZLt
 RAskpWeJ0XywOnZnJxTLWppJl4Q0d24XtgUxVb2/N4/I9tGh3w/TyIqAKH6eNULwop1W2A
 mV51/GfTmZ1BmeY2Hwy5TVx49Z2laIi3A38hf/fOwp908aB6/n9jy6rV3TFj0+rOBqFE2k
 tcpYPQorR0xPclgPE6btDwbeGhmeIvfTcPyG8v2afdBFVu7VMaPJJQRXduCJ6J9wEyKj/7
 XPt/zPjjWYIHWDy2gsS5CclX1ZZ61JndmUUA55ivvWvNRSS/RAPu6BEEzgNsA9XqiQhTh7
 f1UMEpMDuHW79/S4ymyMX0wPyehX630FgYgA/qILyHSP4AsobtUlmkoM44CA
X-ME-Proxy: <xmx:N4J7ap_pw7Vk2qSLU14rndgH9Ct5XnFAdAEhnN_lDXWt9d3cqPK8KA>
 <xmx:N4J7ag9bYd2rqr0-ncCWcurvysXaRk2F8a64QDqIr5FdMGgHvezW4g>
 <xmx:N4J7agfD4ZaBIGkDWMJOXyTsfp6Euc9QFAbI-p7vhxNbDMck0I4E5w>
 <xmx:N4J7apHPLVr9lJsuleh_sG3yBGgTIf2OtJlBJnXR346FxlapM0scdQ>
 <xmx:N4J7atYD2S1_Ch0Bj5hnqFW3zsLtILvTMOrXNqLheBM5pJmvYr5oJOoV>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:12:39 -0400 (EDT)
Message-ID: <d0a84fec05b3fcc32eaab44e5a9f4267b65a380f.camel@alistair23.me>
Subject: Re: [PATCH 18/56] disas/riscv: Handle c.addi4spn imm != 0 during
 decode
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:12:39 +1000
In-Reply-To: <20260809223545.730664-19-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-19-richard.henderson@linaro.org>
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
Y2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGRpc2FzL3Jpc2N2LmMgfCA4ICsrKysr
Ky0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+
IAo+IGRpZmYgLS1naXQgYS9kaXNhcy9yaXNjdi5jIGIvZGlzYXMvcmlzY3YuYwo+IGluZGV4IDk4
MTNkNzVmZWIuLjhhOTU3ZTZhMWUgMTAwNjQ0Cj4gLS0tIGEvZGlzYXMvcmlzY3YuYwo+ICsrKyBi
L2Rpc2FzL3Jpc2N2LmMKPiBAQCAtMTg4NSw3ICsxODg1LDcgQEAgc3RhdGljIGNvbnN0IHJ2X29w
Y29kZV9kYXRhIHJ2aV9vcGNvZGVfZGF0YVtdID0KPiB7Cj4gwqDCoMKgwqAgeyAiZm12LngucSIs
IHJ2X2NvZGVjX3IsIHJ2X2ZtdF9yZF9mcnMxIH0sCj4gwqDCoMKgwqAgeyAiZm12LnEueCIsIHJ2
X2NvZGVjX3IsIHJ2X2ZtdF9mcmRfcnMxIH0sCj4gwqDCoMKgwqAgeyAiYy5hZGRpNHNwbiIsIHJ2
X2NvZGVjX2Npd180c3BuLCBydl9mbXRfcmRfcnMxX2ltbSwgTlVMTCwKPiBydl9vcF9hZGRpLAo+
IC3CoMKgwqDCoMKgIHJ2X29wX2FkZGksIHJ2X29wX2FkZGksIHJ2Y2RfaW1tX256IH0sCj4gK8Kg
wqDCoMKgwqAgcnZfb3BfYWRkaSwgcnZfb3BfYWRkaSB9LAo+IMKgwqDCoMKgIHsgImMuZmxkIiwg
cnZfY29kZWNfY2xfbGQsIHJ2X2ZtdF9mcmRfb2Zmc2V0X3JzMSwgTlVMTCwKPiBydl9vcF9mbGQs
Cj4gwqDCoMKgwqDCoMKgIHJ2X29wX2ZsZCwgMCB9LAo+IMKgwqDCoMKgIHsgImMubHciLCBydl9j
b2RlY19jbF9sdywgcnZfZm10X3JkX29mZnNldF9yczEsIE5VTEwsIHJ2X29wX2x3LAo+IHJ2X29w
X2x3LAo+IEBAIC0yOTUyLDcgKzI5NTIsMTEgQEAgc3RhdGljIHZvaWQgZGVjb2RlX2luc3Rfb3Bj
b2RlKHJ2X2RlY29kZSAqZGVjLAo+IHJ2X2lzYSBpc2EpCj4gwqDCoMKgwqAgc3dpdGNoICgoaW5z
dCA+PiAwKSAmIDBiMTEpIHsKPiDCoMKgwqDCoCBjYXNlIDA6Cj4gwqDCoMKgwqDCoMKgwqDCoCBz
d2l0Y2ggKChpbnN0ID4+IDEzKSAmIDBiMTExKSB7Cj4gLcKgwqDCoMKgwqDCoMKgIGNhc2UgMDog
b3AgPSBydl9vcF9jX2FkZGk0c3BuOyBicmVhazsKPiArwqDCoMKgwqDCoMKgwqAgY2FzZSAwOgo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgoaW5zdCA+PiA1KSAmIDB4ZmYpIHsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wID0gcnZfb3BfY19hZGRpNHNwbjsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4g
wqDCoMKgwqDCoMKgwqDCoCBjYXNlIDE6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChp
c2EgPT0gcnYxMjgpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcCA9IHJ2
X29wX2NfbHE7Cg==


