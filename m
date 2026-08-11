Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85316C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtskU-0000Uj-2I; Tue, 11 Aug 2026 16:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtskI-0000SQ-QV; Tue, 11 Aug 2026 16:06:46 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtskH-00018e-AN; Tue, 11 Aug 2026 16:06:46 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 91F65EC0113;
 Tue, 11 Aug 2026 16:06:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 16:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478804; x=1786565204; bh=ac5wYbknZYrqAypsZIZD7rhgMMIYjgZ/
 nRYBoVFbN4Y=; b=feW3i0J2nd0sHE0Ogo8lSPRCWJO/IkxLUlzYhjbEICAMDtns
 Z0TJ7Z3ATdDm6aonPOqAW0EiV3EFV4Fw5PPUselyjl4VD1frAABRoH9R1N/SRbx7
 pKFBHmY9d5ikkHggkN49lhYcCA/YELIRvDDvyFxghwX0vDkJ4+BobCJkIrzTMWej
 /dYAPFxWJEFxyF+P9mYeQkIxkC/a/ljPejMS/rMC1mR5olG1XeiW0TgvWjC9Rnf7
 xbro/wzD+Q3nZODiL6RawbCGntK0feRiHSVHE0yrSqKXA08VQO1qcnTwHts2hJTj
 2jBa0G6FDNWiyHSrCpPBc4xdHlQ6/AZh7zERbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478804; x=
 1786565204; bh=ac5wYbknZYrqAypsZIZD7rhgMMIYjgZ/nRYBoVFbN4Y=; b=Y
 mJsRSM2kIT228il3qJzZ51/qgXq/Jp8CcczM2iMs22z6JWePWIzAhW7dYVy0MT9d
 Adoq2catEiGiYRzDczIGAvKHoRN4WsS5qwvPE6VN4Lfakcb1XsLTvBJHaC6nN7CP
 +GxZoWyMdJYuEKdoQID/n6DBxbwalyVSoX39hCr2XfkPF/ZQAh0fIa7PBZTW069J
 PuDyGdyAzWF1MHejkIF5citkshanBHcE0cBvUxsw2TCL4qqGOJ49XmF/JDOhj89V
 IG7R61ihh8ARbywCfPGirevQkhsg+ZOMn1dJItExLbNW2kANqtOshInvslq0ykAl
 qlZhWjNyoykl5iLT24j5A==
X-ME-Sender: <xms:1IB7airk9fU5mDPG0lXCSjHgEAQ8ATz51b_K4e1cLBts5HFm6-xnDQ>
 <xme:1IB7ak_N_wROpmNy7qsekIAncRKIXbxDQQybSut7mzvuCq2iVSGFsx7k4wjLJVkJL
 IHSgZWtZkPNdsKdcdzkLT1k7ee6FpZ7S_d6CHxn73z4NUkqk3kY-vc>
X-ME-Received: <xmr:1IB7amUXyJW5XcPlPHXa8ZbgTRg2kGdtYHpwbOluK0HENlMF6JYa4tmxYjD8E75WaL4ZZg>
X-ME-Proxy-Cause: dmFkZTEk0NvhYgDdFRhySClqUZl7Do4b4Yw6wPiTMDxzfjVl4fHfsePpV1CkS3y0nS+zAB
 YuDBwCQDkdmdz+scwUU4DQjBV8T2KN0wpXzMrSUjgseP3T6uUXkRzj/lUuXmihIhozEPEX
 zAro/lWNqw+V/gSK4qD5rP81vzShLOd7lNy65EWoQSCx79JlUb7YfFGQW2C2xwEwhm7q8w
 C+OYfcA01l4ko73n5iJrMXN5DCI7b3N6PEH4m8fJWoaYk1EDMJa5+Hdk8nzF1n13D4h5Jq
 jGfUSSl9PyK5M58sxx6Go/Gq4hzxzU+M0OIlxBS4kgybWKeSW86Izy/JQyf03r7qBhwLht
 K4WHMJHESQ9BAqx9sXU0Z3NiYlXOwqayV1IuyFaEVNHOmS5giOwH5VbuXJg0/taRPAriox
 buEEf06Zq48EV5GqC97uXGtrFOaKrsLxy1ViD+YEYahxXVDTpM0Myuc6A+tOD7pSu0o2NR
 7EOraEKFsarYs6kcXjMY7sYbY4QyKQ28d5ro8eCMWOs7gkuHbTt13EygU6xzKnRf+Epe6G
 DR7dNSd41IAsBfq41vNvruqiUGw/zGBejFqIbW6kFUhMsOjKPpWAs9S3fz1B1tIgtm06S8
 TUpQ/kowZ8XKOuskL/5W/9TrwexxWbQ6bM5WtBS4SHRRIEAP8RsVPzcrUq8g
X-ME-Proxy: <xmx:1IB7aqCrJGR2RKncSFwveNM9VXn0gh5nq84GYRvMkraYATh9Efrq-g>
 <xmx:1IB7anzbzMHBDnXcZmOSkg-JH_Xlt21_WQOGxnSS6cYawOmtwqy2nA>
 <xmx:1IB7anBfhVhhVFxcI5oFevxk8YVd_mRBwjOmhPg-J9QoYHRoQXQQUQ>
 <xmx:1IB7aka-KQo6osoXZkWALop0yw8gznypHuxm196usoOkuiHN1fBtKA>
 <xmx:1IB7auc9ftU1AmFuR1-jm5dfEh41yHe1HWyDcl3kPy7cRqJkXLOyiifs>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:06:44 -0400 (EDT)
Message-ID: <afb8af51b6647adb3b4a8b4f0be5a76b8799d25d.camel@alistair23.me>
Subject: Re: [PATCH 12/56] disas/riscv: Pass rv_opcode_data pointer to
 format_inst
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:06:43 +1000
In-Reply-To: <20260809223545.730664-13-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-13-richard.henderson@linaro.org>
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
Y2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGRpc2FzL3Jpc2N2LmMgfCAxMSArKysr
Ky0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkKPiAKPiBkaWZmIC0tZ2l0IGEvZGlzYXMvcmlzY3YuYyBiL2Rpc2FzL3Jpc2N2LmMKPiBpbmRl
eCAwYmUyZjA3NjEyLi43MGVhNDFmMTI1IDEwMDY0NAo+IC0tLSBhL2Rpc2FzL3Jpc2N2LmMKPiAr
KysgYi9kaXNhcy9yaXNjdi5jCj4gQEAgLTUxMTEsMTcgKzUxMTEsMTYgQEAgc3RhdGljIHNpemVf
dCBpbnN0X2xlbmd0aChydl9pbnN0IGluc3QpCj4gwqAKPiDCoC8qIGZvcm1hdCBpbnN0cnVjdGlv
biAqLwo+IMKgCj4gLXN0YXRpYyBHU3RyaW5nICpmb3JtYXRfaW5zdChzaXplX3QgdGFiLCBydl9k
ZWNvZGUgKmRlYykKPiArc3RhdGljIEdTdHJpbmcgKmZvcm1hdF9pbnN0KHNpemVfdCB0YWIsIHJ2
X2RlY29kZSAqZGVjLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY29uc3QgcnZfb3Bjb2RlX2RhdGEgKm9wKQo+IMKgewo+IC3CoMKgwqAg
Y29uc3QgcnZfb3Bjb2RlX2RhdGEgKm9wY29kZV9kYXRhID0gZGVjLT5vcGNvZGVfZGF0YTsKPiDC
oMKgwqDCoCBHU3RyaW5nICpidWYgPSBnX3N0cmluZ19zaXplZF9uZXcoNjQpOwo+IC3CoMKgwqAg
Y29uc3QgY2hhciAqZm10Owo+ICvCoMKgwqAgY29uc3QgY2hhciAqZm10ID0gb3AtPmZvcm1hdDsK
PiDCoAo+IC3CoMKgwqAgZm10ID0gb3Bjb2RlX2RhdGFbZGVjLT5vcF0uZm9ybWF0Owo+IMKgwqDC
oMKgIHdoaWxlICgqZm10KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKCpmbXQpIHsKPiDC
oMKgwqDCoMKgwqDCoMKgIGNhc2UgJ08nOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdfc3Ry
aW5nX2FwcGVuZChidWYsIG9wY29kZV9kYXRhW2RlYy0+b3BdLm5hbWUpOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdfc3RyaW5nX2FwcGVuZChidWYsIG9wLT5uYW1lKTsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqDCoCBjYXNlICcoJzoKPiDCoMKg
wqDCoMKgwqDCoMKgIGNhc2UgJywnOgo+IEBAIC01NDY2LDcgKzU0NjUsNyBAQCBzdGF0aWMgR1N0
cmluZyAqZGlzYXNtX2luc3QocnZfaXNhIGlzYSwKPiB1aW50NjRfdCBwYywgcnZfaW5zdCBpbnN0
LAo+IMKgwqDCoMKgIGRlY29kZV9pbnN0X29wZXJhbmRzKCZkZWMsIGlzYSwgb3ApOwo+IMKgwqDC
oMKgIG9wID0gZGVjb2RlX2luc3RfZGVjb21wcmVzcygmZGVjLCBpc2EsIG9wKTsKPiDCoMKgwqDC
oCBvcCA9IGRlY29kZV9pbnN0X2xpZnRfcHNldWRvKCZkZWMsIG9wKTsKPiAtwqDCoMKgIHJldHVy
biBmb3JtYXRfaW5zdCgyNCwgJmRlYyk7Cj4gK8KgwqDCoCByZXR1cm4gZm9ybWF0X2luc3QoMjQs
ICZkZWMsIG9wKTsKPiDCoH0KPiDCoAo+IMKgI2RlZmluZSBJTlNUX0ZNVF8yICIlMDR4wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgIgo=


