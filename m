Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C1FC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8OO-0006HV-1Y; Wed, 12 Aug 2026 08:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8ON-0006Fx-8B; Wed, 12 Aug 2026 08:49:11 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8OL-0000EJ-SC; Wed, 12 Aug 2026 08:49:11 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 15264EC018A;
 Wed, 12 Aug 2026 08:49:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 08:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786538949; x=1786625349; bh=wxHD3RKW5lPKGsonLiQO4ZCTTYZnmZ5u
 pgqTxi7fZdo=; b=BgwcHSWecEQY4AnlJntI2OlTSgzNwjSkReyk3ZEyADIJ1Y06
 /BwyZ3LkjSvBnmmr5FU85pBH9/XmMpazsBudpQxBIZxTQGVM9Jaiz5PEESxQObGK
 Y9TPuQW96KkrsofF9aVE6KkLB6zsiqW9MEREozFBfpQakfW36l6Uo+HQGJMbd5yq
 By4bJXyGOpTmimM6N+Cb3uARCplI/If+4e45DH854ZZlcM0TQ+cbaqmYg8Y4Tgt7
 uDPyG9Ev389268BXWwXBx88N1sBCUIEYz3AXJlRTagnbUy6BWp3gAuqZVsbzL4dQ
 rCPMDaFKl0IjqRM2FBdV5Hb47+4Bwwi2b6VIyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786538949; x=
 1786625349; bh=wxHD3RKW5lPKGsonLiQO4ZCTTYZnmZ5upgqTxi7fZdo=; b=X
 xGvrncerpWrbR/KuHVLPnZIfQlnzTPArwc0FQsZsVLlfi/XcwclHUL4SM6GBmHzZ
 kLVuglyWTmaKMctHkcaOO3P8eDxiipFCSSKhCkzdEx04DzGyXT8IEK7N9c5mSH91
 ve31Sqn4GeRxf4ExhlSZ7SnXoz+Hubkfr/08h+rtZL04b88BEODH0PlPxMvANrym
 1vxlYqEdj4BxdTlj+ADYJjIYpqgQ13kSCz+AaeSzpBiU3tucZ8f3vmSEr3HrYlRQ
 7hcDTPLlseRSZAdHFiYyKFdwUyPOHmPfWjDNJDKS1px5vKTbq2onE9UgfVZ2CKF8
 sp9nCv9MvoLBaUedAhuBg==
X-ME-Sender: <xms:xWt8ai42xDOL_pkT6yj5QwpoNrAjRAQ-6AG4Xg-T6gXYNJ0e6UMMlg>
 <xme:xWt8agNROMf4pf1i2xM_r2u-RSt5wDw91zGJAnA77lb0gnlLbu3phWzpw30riJhmz
 5dYEsUTguDEvTSDRK3VhzjisXzQOWDkFcG95QQIE7l4ooRkz-BmfKZb>
X-ME-Received: <xmr:xWt8agnjG5C8ubgTPzHMyu-5vHc8912XR3cn5x-qW6TfC3qdGqH5usW0zUqU9spoFU0dbg>
X-ME-Proxy-Cause: dmFkZTFYuMQJ3MQNB7TCUpq0nuiJPCpyO+v1PS8hSOOEItZixY5ngZpELD3hIQx9oMuMtm
 4vvxpTkonFucnXXgNeBXdS0jeUN/e6rbxtiPO+tyKYLYs0t0UaqpRw4iNGzs0aQUXb/H7K
 f3vHF7fdHuw29bAgvYpuml51uFcs1ow3QWgyRT3mSFyQw6HUXtTKJ0AGLarnWnswCqbUgP
 RsApr+YY8OHSR/NXfQX2Jc1SClrk/JYZqVE/iDSSIMP89mSA+5JgpDyy95LBjDMIkTllIe
 9KrRaOUEmudDYGXTrU2GGSfJv5eBSSkb5CwHYpKOSE9U5yyBuqTDVePaGYAnINq7fxGzDk
 i55IWkkyjmcFsJjTYeQPcTkDwcA8e0zx5lWgH/eKZy16RLmncadhZuAnkN8R/kXIdau4o9
 +s7zj1bczLez0EsF/+dLqjK3YEY+9qrlH8dfuExSKFb2HK5Q09oi13Ph5le1Xgy4hg8UVd
 TQMEdE4vGGapG4PG4kIcBQDbS1EkzLbp/XLOpJQeJDSv6fzDI+fCICTAc37/7nm/zQu8Nr
 uf/FRNj/LsX0A+UlLbnOgGXEOmgUZo7oeNCWXvLA7mdhCMPizRIIJJASxb+Hv6PR0dI0sN
 o1TkOWzWc8ReZBQaHn8cUCzbRQpX+P1TQt794qt4j7m14RqGAcu4HIFcgaPQ
X-ME-Proxy: <xmx:xWt8anS49zVJvwGDR1VKLO4yUwSZdnGId7B2XSxQmaDY8yhKWtBoeA>
 <xmx:xWt8asDJn2HMt_-e-3pYuYhIQ-lOJhHkjg9ZrPW5YX6ETnxh6jIQ0A>
 <xmx:xWt8amTqFYbJXI_5Xj41_sk5FiX1iaUmgtMqnLNSF577RMC3gjBFIA>
 <xmx:xWt8aiogfP7NDQ3-WLkJIwnQCUGynOsME55Zjn3-LHPQxC2-vyNDjw>
 <xmx:xWt8avv3iiFh_yxbj5oxLnv8RLOLUCx1hgtp2-nK_gctf-3dTxBxeyGI>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 08:49:08 -0400 (EDT)
Message-ID: <114c72d72fdcd320afd1c1a042fdb60c7be83e89.camel@alistair23.me>
Subject: Re: [PATCH 41/56] disas/riscv: Reject all of OP-32 and OP-IMM-32
 for RV32
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 22:49:08 +1000
In-Reply-To: <20260809223545.730664-42-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-42-richard.henderson@linaro.org>
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
ZToKPiBUaGVzZSBlbnRpcmUgYmFzZSBvcGNvZGVzIGFyZSBSVjY0LsKgIFJlamVjdCB0aGVtIGFs
bCBhdCBvbmNlCj4gcmF0aGVyIHRoYW4gb25lIGF0IGEgdGltZS4KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KClJldmll
d2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+CgpBbGlz
dGFpcgoKPiAtLS0KPiDCoGRpc2FzL3Jpc2N2LmMgfCA4ICsrKysrKysrCj4gwqAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2Rpc2FzL3Jpc2N2LmMgYi9k
aXNhcy9yaXNjdi5jCj4gaW5kZXggYzRiOGVlN2QwNy4uZjUxZDQ1Njc0ZSAxMDA2NDQKPiAtLS0g
YS9kaXNhcy9yaXNjdi5jCj4gKysrIGIvZGlzYXMvcmlzY3YuYwo+IEBAIC0zMzExLDYgKzMzMTEs
MTAgQEAgc3RhdGljIGNvbnN0IHJ2X29wY29kZV9kYXRhCj4gKmRlY29kZV9pbnN0X29wY29kZShy
dl9kZWNvZGUgKmRlYywgcnZfaXNhIGlzYSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgIGNhc2Ug
NjoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBPUC1JTU0tMzIgKi8KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoaXNhID09IHJ2MzIpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3dpdGNoICgoaW5zdCA+PiAxMikgJiAwYjExMSkgewo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjYXNlIDA6IG9wID0gcnZfb3BfYWRkaXc7IGJyZWFrOwo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDE6Cj4gQEAgLTM1NTcsNiArMzU2MSwxMCBAQCBzdGF0
aWMgY29uc3QgcnZfb3Bjb2RlX2RhdGEKPiAqZGVjb2RlX2luc3Rfb3Bjb2RlKHJ2X2RlY29kZSAq
ZGVjLCBydl9pc2EgaXNhKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDCoMKg
wqDCoMKgwqDCoMKgIGNhc2UgMTM6IG9wID0gcnZfb3BfbHVpOyBicmVhazsKPiDCoMKgwqDCoMKg
wqDCoMKgIGNhc2UgMTQ6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogT1AtMzIgKi8KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaXNhID09IHJ2MzIpIHsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3dpdGNoICgoKGluc3QgPj4gMjIpICYgMGIxMTExMTEx
MDAwKSB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKGluc3Qg
Pj4gMTIpICYgMGIwMDAwMDAwMTExKSkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNl
IDA6IG9wID0gcnZfb3BfYWRkdzsgYnJlYWs7Cg==


