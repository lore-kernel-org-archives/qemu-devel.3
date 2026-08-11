Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EEEC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsdk-0005d8-T2; Tue, 11 Aug 2026 16:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsdj-0005cr-UA; Tue, 11 Aug 2026 15:59:59 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsdi-0000J2-ET; Tue, 11 Aug 2026 15:59:59 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id B0083EC0190;
 Tue, 11 Aug 2026 15:59:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 15:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478397; x=1786564797; bh=N+4O2kn5sZ+j5wgAUNN+oSXeIGWgkXBK
 l6rgiIwvR/g=; b=c//Nefh87sqa30Rlom18nDBhQ8pmoK5RLos0Lt3ap1LphZbQ
 S940GkeBWXDas7zdCDB/B1t1GRv1V3c5T2mOIRDyhJ1i6ocKZ+zJwUOozRVss9nB
 vyLB8iU2TGRV1DDid+k2t1jurBbuNRuDJSTQwRCQOh7LmsW5oAbpBSCn7rTO8oWL
 /x2i+DU5X4RX0Bw/9oIFCYsuLTqQYJ4BJNS/G2EHW9cB41hPmlsqXup/3SNn/yIr
 ifePIK2/RgmRzoOpGjo8XsxfTOBI2x5VEJnLo1/5uBZJTNJ8lhoN0/7JPrAmuNYE
 zcoKjgxykHKUGugLhlt7ObqK/t+b3qSbQZwS8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478397; x=
 1786564797; bh=N+4O2kn5sZ+j5wgAUNN+oSXeIGWgkXBKl6rgiIwvR/g=; b=H
 xhx2DASo2/luj5Q9okChitmdmQAMmiaud09PctYUtXtX4m3MAa2uSFMfMKUSeZqm
 b7OSQ3Shm8Uc77XTteJpiOW57EUwoGMRRSaWwnAxJXw5lm/unXh+1V3kn/GNINkg
 1ztQaeMuDtHYuV+g7bvxJ89pCUur7aZcWkZssLk/zzf8yoYww6iylxaTz4aZcD1D
 xKz3MKYSif7Hcj/D1d9vABB1PvsF7nodc9U0XeTM2Jbb2jtwwl9FvlaLZth3k6QQ
 CpnQ8RcctDsDGoKpEox5Lohq2vEw4/sr1KWvgDNvQyG9uVnABYH9EsYJzYYvXGfj
 MYB5YEpi1omQXYPCnG50A==
X-ME-Sender: <xms:PX97akJoihySIbPiuwzLHFY1ngoIM6FuizD_kFB36j4OIGwkMeiCuA>
 <xme:PX97aoebCXf2tmzYA_BUSzK8IG03YPDb9RVhaWN9l9YXGTl-sXjC6UnNc6Pa3W8Pe
 gybFX4ktIR8Gvm1In8aVgyMHLhShMXTRSWQxB9LsMOyRCIKEslWOw>
X-ME-Received: <xmr:PX97aj01254GlcZu8AbJyY4Fqhg1kKTlhJuDyuD75bbwywL1iH_Njcr3Wg9eH4dlbPVkdQ>
X-ME-Proxy-Cause: dmFkZTECvURETSaS1LWppBzxw9fQ/4Ka/J4hSBSmr1AXFCEIPkilWGtETGFm6gZiqROT30
 7IQJt2XSE52sichpy3bzC5BD+NbS4jZgRHd9lqzj3DvUFiIHwH7s4+Xc0HNSXYlnbcfnH1
 H7y5liumNqFdGAaKvlg5otXUa3ZDHYR4uLrzGSqhmgYzjrsB8WJ6GImXXkAXFfnnYTuQhK
 +/NSTS4ddupQyNpl4qMptOkPtciAigf7rA+bIZOYxMKNDPV4odZajK0w9Jr1+OLRLBiyTJ
 zHqszNOuonfgEJPDOO6SAJvDOJd/eV3hI5Jh+yOHeAKVdXLD4UCZtMKn/xFHRzPtXQVdMk
 /iHctzx6WiX4SEh0yyKbGnfoncS+GvtzmtA+cU0GBq4ig/P6YfbYiTG/LtKLcnAZTKXuN0
 Usqmyj2dMGEhZwagzUn9xjHrYMl8RUlsMEVamf6ZEo6XLyeA1XIcNkQD9lbW5pTfjjgl9p
 0w1/iVMEXZhShrL22xdBEKN+6fdYWDOP0c4Tx26kqadIrgp9vP/6LXOWhvWX2ZSMGlIri1
 w/tYSMmwVBQPB7jFtZIntKSdR+BGzb34AcBzP0vxU695b22o4JYB7X/98JPtTXV43Gmhy1
 XekgkBYKbSZLZQ4ojWW2LhK4X9P3bV+qvxX891OmKwc+tX9a0JgHqRlmtvew
X-ME-Proxy: <xmx:PX97aphwOEEwqLq9qnb92sRBxCGTm7lOHRMpxpy_znyh3iwhwYRulw>
 <xmx:PX97ahSJzkrwyMuj_1H7y8xUuHyqk9qo6-vlCTplExa3nICwjsCbew>
 <xmx:PX97aijZUggKepCYph3kk_KX-VJhVdDGqYLZUCBzprHcqaSbbhl4bQ>
 <xmx:PX97ap7hoUWew8Ca7zASugtO39jHbdlJR8rjHsqJn2w-1jlDsYlavQ>
 <xmx:PX97al-SQ_NICQenNniUJHiQRrWl6dMOzKMLqq-4Ixspi6kyhJmhDvqT>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:59:57 -0400 (EDT)
Message-ID: <6570b7fdcb45ff0027fc2adb4c7a0b66bfe9d48b.camel@alistair23.me>
Subject: Re: [PATCH 07/56] disas/riscv: Reduce rv_insn to uint32_t
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 05:59:57 +1000
In-Reply-To: <20260809223545.730664-8-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-8-richard.henderson@linaro.org>
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

T24gU3VuLCAyMDI2LTA4LTA5IGF0IDE1OjM0IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBTaW5jZSA3NThkY2U5Yzk4YSwgdGhlIG9ubHkgcG9zc2libGUgdmFsdWVzIGZvcgo+IGlu
c3RydWN0aW9uIGxlbmd0aCBhcmUgMiBhbmQgNC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJk
IEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KClJldmlld2VkLWJ5OiBB
bGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAt
LS0KPiDCoGRpc2FzL3Jpc2N2LmggfMKgIDIgKy0KPiDCoGRpc2FzL3Jpc2N2LmMgfCAxMiArKyst
LS0tLS0tLS0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZGlzYXMvcmlzY3YuaCBiL2Rpc2FzL3Jpc2N2LmgKPiBp
bmRleCA5MWFkYThiNTMxLi5lYWJlMTkzYjRmIDEwMDY0NAo+IC0tLSBhL2Rpc2FzL3Jpc2N2LmgK
PiArKysgYi9kaXNhcy9yaXNjdi5oCj4gQEAgLTExLDcgKzExLDcgQEAKPiDCoAo+IMKgLyogdHlw
ZXMgKi8KPiDCoAo+IC10eXBlZGVmIHVpbnQ2NF90IHJ2X2luc3Q7Cj4gK3R5cGVkZWYgdWludDMy
X3QgcnZfaW5zdDsKPiDCoHR5cGVkZWYgdWludDE2X3QgcnZfb3Bjb2RlOwo+IMKgCj4gwqAvKiBl
bnVtcyAqLwo+IGRpZmYgLS1naXQgYS9kaXNhcy9yaXNjdi5jIGIvZGlzYXMvcmlzY3YuYwo+IGlu
ZGV4IGUzZmJjMjY2MjYuLjAxMmY5MGZjZTYgMTAwNjQ0Cj4gLS0tIGEvZGlzYXMvcmlzY3YuYwo+
ICsrKyBiL2Rpc2FzL3Jpc2N2LmMKPiBAQCAtNTQ5MSwxMCArNTQ5MSw4IEBAIHN0YXRpYyBHU3Ry
aW5nICpkaXNhc21faW5zdChydl9pc2EgaXNhLAo+IHVpbnQ2NF90IHBjLCBydl9pbnN0IGluc3Qs
Cj4gwqDCoMKgwqAgcmV0dXJuIGZvcm1hdF9pbnN0KDI0LCAmZGVjKTsKPiDCoH0KPiDCoAo+IC0j
ZGVmaW5lIElOU1RfRk1UXzIgIiUwNCIgUFJJeDY0ICLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAiCj4gLSNkZWZpbmUgSU5TVF9GTVRfNCAiJTA4IiBQUkl4NjQgIsKgwqDCoMKgwqDCoMKgwqDC
oCAiCj4gLSNkZWZpbmUgSU5TVF9GTVRfNiAiJTAxMiIgUFJJeDY0ICLCoMKgwqDCoMKgICIKPiAt
I2RlZmluZSBJTlNUX0ZNVF84ICIlMDE2IiBQUkl4NjQgIsKgICIKPiArI2RlZmluZSBJTlNUX0ZN
VF8yICIlMDR4wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIgo+ICsjZGVmaW5lIElOU1RfRk1U
XzQgIiUwOHjCoMKgwqDCoMKgwqDCoMKgwqAgIgo+IMKgCj4gwqBzdGF0aWMgaW50Cj4gwqBwcmlu
dF9pbnNuX3Jpc2N2KGJmZF92bWEgbWVtYWRkciwgc3RydWN0IGRpc2Fzc2VtYmxlX2luZm8gKmlu
Zm8sCj4gcnZfaXNhIGlzYSkKPiBAQCAtNTUzMCwxMiArNTUyOCw4IEBAIHByaW50X2luc25fcmlz
Y3YoYmZkX3ZtYSBtZW1hZGRyLCBzdHJ1Y3QKPiBkaXNhc3NlbWJsZV9pbmZvICppbmZvLCBydl9p
c2EgaXNhKQo+IMKgwqDCoMKgwqDCoMKgwqAgY2FzZSA0Ogo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAoKmluZm8tPmZwcmludGZfZnVuYykoaW5mby0+c3RyZWFtLCBJTlNUX0ZNVF80LCBpbnN0
KTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gLcKgwqDCoMKgwqDCoMKgIGNh
c2UgNjoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKmluZm8tPmZwcmludGZfZnVuYykoaW5m
by0+c3RyZWFtLCBJTlNUX0ZNVF82LCBpbnN0KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
cmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgIGRlZmF1bHQ6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKCppbmZvLT5mcHJpbnRmX2Z1bmMpKGluZm8tPnN0cmVhbSwgSU5TVF9GTVRfOCwgaW5zdCk7
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKPiDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDC
oCB9Cj4gwqAK


