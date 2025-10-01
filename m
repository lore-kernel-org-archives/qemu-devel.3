Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4850CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 23:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v46Bw-0002WR-O2; Wed, 01 Oct 2025 19:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1v46Bt-0002VW-4g; Wed, 01 Oct 2025 19:24:57 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1v46Ba-0007Zc-Eq; Wed, 01 Oct 2025 19:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1759361043;
 bh=CfNV5E5gep0TBIY3oXbFoFIKMWGummq+On+ZKn8y93o=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=Y5ni8wkjvpjcZfsco3rp0URBZ4nvbrYKKyM/3HpEkaaTSChS+7FfN+VMTCmeB+SJZ
 6pfS8LAZ8ZmjbFEnoPcMDuUTiATHnwCPYMQJn/gFaqzfVDFt0kMbz5lnlUxiEi4yMV
 vUXqhE9TLQN+IScYkBi5Wadlbh4yl2Pa2hkg1yzY0oAu8BI2KgAGCVzG3kV5J1qqby
 NnqYJSdaieXkq2bA7qG8MJKSTlzdaCVkpgG17uGmLotw8/JAzGygiKEe2h3XG63zXj
 FuKC3xNWCsUckkdwdAQGVeI9N5Ef1BxzehRhnTBCXUWPeyw6BCkykUHY9T4YlRm8F3
 ZLgKZlme/B1Rw==
Received: from [192.168.68.113] (unknown [180.150.112.213])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5146864741;
 Thu,  2 Oct 2025 07:24:02 +0800 (AWST)
Message-ID: <b601f750adc19ea0fe8ec8f2c578f9f23d7259cc.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 1/5] hw/gpio: Add property for ASPEED GPIO in 32 bits
 basis
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Coco Li <lixiaoyan@google.com>, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, flwu@google.com, Peter
 Maydell	 <peter.maydell@linaro.org>
Date: Thu, 02 Oct 2025 08:54:01 +0930
In-Reply-To: <20250925005832.3708492-2-lixiaoyan@google.com>
References: <20250925005832.3708492-1-lixiaoyan@google.com>
 <20250925005832.3708492-2-lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.1-1 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

T24gVGh1LCAyMDI1LTA5LTI1IGF0IDAwOjU4ICswMDAwLCBDb2NvIExpIHdyb3RlOgo+IEZyb206
IEZlbGl4IFd1IDxmbHd1QGdvb2dsZS5jb20+Cj4gCj4gQWRkZWQgMzIgYml0cyBwcm9wZXJ0eSBm
b3IgQVNQRUVEIEdQSU8uIFByZXZpb3VzbHkgaXQgY2FuIG9ubHkgYmUgYWNjZXNzIGluIGJpdHdp
c2UgbWFubmVyLgo+IAo+IFRoaXMgY2hhbmdlIGdpdmVzIEFTUEVFRCBzaW1pbGFyIGJlaGF2aW9y
IGFzIE51dm90b24uCgpJIGRvbid0IHRoaW5rIHRoaXMgaGFzIGFkZXF1YXRlbHkgYWRkcmVzc2Vk
IG15IHJlcXVlc3Qgb24gdGhlIHByaW9yCnNlcmllczoKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9lMjQ0ZmRiNWQyZDg4OTY3NGE1ODNkZjhmOGI5YmM0YmY4ZDQ3NmY0LmNhbWVsQGNvZGVj
b25zdHJ1Y3QuY29tLmF1LwoKQ2FuIHlvdSBwbGVhc2UgaW1wcm92ZSB0aGUgY29tbWl0IG1lc3Nh
Z2U/CgpJIGRvbid0IGhhdmUgYW55IHBhcnRpY3VsYXIgY29uY2VybiB3aXRoIHRoZSBpbXBsZW1l
bnRhdGlvbiwgb3RoZXIgdGhhbgp1bmRlcnN0YW5kaW5nIHdoZXRoZXIgaXQncyBzb21ldGhpbmcg
dGhhdCdzIHJlYXNvbmFibGUgdG8gYWRkIHRvIGJlZ2luCndpdGguIFRoZSAic2V0cyIgYW5kIHRo
ZWlyIGluZGV4ZXMgYXJlIHNvbWV3aGF0IGFuIGltcGxlbWVudGF0aW9uCmRldGFpbC4gRXhwb3Np
bmcgdGhlbSBtaWdodCBwcmVjbHVkZSBhIGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbiBkZXNpZ24s
CnRob3VnaCBJJ20gYWxzbyBub3Qgc3VyZSB3aHkgd2UnZCBjaGFuZ2UgYXQgdGhpcyBwb2ludC4K
CkFuZHJldwoKPiAKPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBXdSA8Zmx3dUBnb29nbGUuY29tPgo+
IC0tLQo+IMKgaHcvZ3Bpby9hc3BlZWRfZ3Bpby5jIHwgNTcgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDU3IGluc2VydGlvbnMo
KykKPiAKPiBkaWZmIC0tZ2l0IGEvaHcvZ3Bpby9hc3BlZWRfZ3Bpby5jIGIvaHcvZ3Bpby9hc3Bl
ZWRfZ3Bpby5jCj4gaW5kZXggNjA5YTU1NjkwOC4uMmQ3OGJmOTUxNSAxMDA2NDQKPiAtLS0gYS9o
dy9ncGlvL2FzcGVlZF9ncGlvLmMKPiArKysgYi9ody9ncGlvL2FzcGVlZF9ncGlvLmMKPiBAQCAt
MTMwOCw2ICsxMzA4LDU3IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9ncGlvXzI3MDBfd3JpdGUodm9p
ZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LAo+IMKgfQo+IMKgCj4gwqAvKiBTZXR1cCBmdW5jdGlv
bnMgKi8KPiArc3RhdGljIHZvaWQgYXNwZWVkX2dwaW9fc2V0X3NldChPYmplY3QgKm9iaiwgVmlz
aXRvciAqdiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQg
Km9wYXF1ZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVycm9yICoqZXJycCkKPiArewo+ICvC
oMKgwqAgdWludDMyX3Qgc2V0X3ZhbCA9IDA7Cj4gK8KgwqDCoCBBc3BlZWRHUElPU3RhdGUgKnMg
PSBBU1BFRURfR1BJTyhvYmopOwo+ICvCoMKgwqAgQXNwZWVkR1BJT0NsYXNzICphZ2MgPSBBU1BF
RURfR1BJT19HRVRfQ0xBU1Mocyk7Cj4gK8KgwqDCoCBpbnQgc2V0X2lkeCA9IDA7Cj4gKwo+ICvC
oMKgwqAgaWYgKCF2aXNpdF90eXBlX3VpbnQzMih2LCBuYW1lLCAmc2V0X3ZhbCwgZXJycCkpIHsK
PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ICvCoMKgwqAgfQo+ICsKPiArwqDCoMKgIGlmIChz
c2NhbmYobmFtZSwgImdwaW8tc2V0WyVkXSIsICZzZXRfaWR4KSAhPSAxKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgIGVycm9yX3NldGcoZXJycCwgIiVzOiBlcnJvciByZWFkaW5nICVzIiwgX19mdW5jX18s
IG5hbWUpOwo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4gK8KgwqDCoCB9Cj4gKwo+ICvCoMKg
wqAgaWYgKHNldF9pZHggPj0gYWdjLT5ucl9ncGlvX3NldHMgfHwgc2V0X2lkeCA8IDApIHsKPiAr
wqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAiJXM6IGludmFsaWQgc2V0X2lkeCAlcyIs
IF9fZnVuY19fLCBuYW1lKTsKPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ICvCoMKgwqAgfQo+
ICsKPiArwqDCoMKgIGFzcGVlZF9ncGlvX3VwZGF0ZShzLCAmcy0+c2V0c1tzZXRfaWR4XSwgc2V0
X3ZhbCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfnMt
PnNldHNbc2V0X2lkeF0uZGlyZWN0aW9uKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgYXNwZWVk
X2dwaW9fZ2V0X3NldChPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQgKm9wYXF1ZSwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIEVycm9yICoqZXJycCkKPiArewo+ICvCoMKgwqAgdWludDMyX3Qgc2V0X3ZhbCA9IDA7
Cj4gK8KgwqDCoCBBc3BlZWRHUElPU3RhdGUgKnMgPSBBU1BFRURfR1BJTyhvYmopOwo+ICvCoMKg
wqAgQXNwZWVkR1BJT0NsYXNzICphZ2MgPSBBU1BFRURfR1BJT19HRVRfQ0xBU1Mocyk7Cj4gK8Kg
wqDCoCBpbnQgc2V0X2lkeCA9IDA7Cj4gKwo+ICvCoMKgwqAgaWYgKHNzY2FuZihuYW1lLCAiZ3Bp
by1zZXRbJWRdIiwgJnNldF9pZHgpICE9IDEpIHsKPiArwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0
ZyhlcnJwLCAiJXM6IGVycm9yIHJlYWRpbmcgJXMiLCBfX2Z1bmNfXywgbmFtZSk7Cj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybjsKPiArwqDCoMKgIH0KPiArCj4gK8KgwqDCoCBpZiAoc2V0X2lkeCA+
PSBhZ2MtPm5yX2dwaW9fc2V0cyB8fCBzZXRfaWR4IDwgMCkgewo+ICvCoMKgwqDCoMKgwqDCoCBl
cnJvcl9zZXRnKGVycnAsICIlczogaW52YWxpZCBzZXRfaWR4ICVzIiwgX19mdW5jX18sIG5hbWUp
Owo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4gK8KgwqDCoCB9Cj4gKwo+ICvCoMKgwqAgc2V0
X3ZhbCA9IHMtPnNldHNbc2V0X2lkeF0uZGF0YV92YWx1ZTsKPiArwqDCoMKgIHZpc2l0X3R5cGVf
dWludDMyKHYsIG5hbWUsICZzZXRfdmFsLCBlcnJwKTsKPiArfQo+ICsKPiArLyoqKioqKioqKioq
KioqKioqKiBTZXR1cCBmdW5jdGlvbnMgKioqKioqKioqKioqKioqKioqLwo+IMKgc3RhdGljIGNv
bnN0IEdQSU9TZXRQcm9wZXJ0aWVzIGFzdDI0MDBfc2V0X3Byb3BzW0FTUEVFRF9HUElPX01BWF9O
Ul9TRVRTXSA9IHsKPiDCoMKgwqDCoCBbMF0gPSB7MHhmZmZmZmZmZizCoCAweGZmZmZmZmZmLMKg
IHsiQSIsICJCIiwgIkMiLCAiRCJ9IH0sCj4gwqDCoMKgwqAgWzFdID0gezB4ZmZmZmZmZmYswqAg
MHhmZmZmZmZmZizCoCB7IkUiLCAiRiIsICJHIiwgIkgifSB9LAo+IEBAIC0xNDM1LDYgKzE0ODYs
MTIgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2dwaW9faW5pdChPYmplY3QgKm9iaikKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZ19mcmVlKG5hbWUpOwo+IMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKg
wqDCoMKgIH0KPiArCj4gK8KgwqDCoCBmb3IgKGludCBpID0gMDsgaSA8IGFnYy0+bnJfZ3Bpb19z
ZXRzOyBpKyspIHsKPiArwqDCoMKgwqDCoMKgwqAgY2hhciAqbmFtZSA9IGdfc3RyZHVwX3ByaW50
ZigiZ3Bpby1zZXRbJWRdIiwgaSk7Cj4gK8KgwqDCoMKgwqDCoMKgIG9iamVjdF9wcm9wZXJ0eV9h
ZGQob2JqLCBuYW1lLCAidWludDMyIiwgYXNwZWVkX2dwaW9fZ2V0X3NldCwKPiArwqDCoMKgwqDC
oMKgwqAgYXNwZWVkX2dwaW9fc2V0X3NldCwgTlVMTCwgTlVMTCk7Cj4gK8KgwqDCoCB9Cj4gwqB9
Cj4gwqAKPiDCoHN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9ncGlvX3Jl
Z3MgPSB7Cg==


