Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3F3C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsiE-0007cS-QZ; Tue, 11 Aug 2026 16:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtshu-0007Uv-ER; Tue, 11 Aug 2026 16:04:19 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtshs-0000mq-KA; Tue, 11 Aug 2026 16:04:17 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9981414000D7;
 Tue, 11 Aug 2026 16:04:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 11 Aug 2026 16:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478655; x=1786565055; bh=dHClpRtYuvM2BPy5EoH0vuZzYxCH6SUH
 0FgewbkKWfU=; b=zIOgFYqbeMteg7bQK5cqEQ/wWWL1jPIwPAO1Af2xAVt3Pkhm
 45Ad+pLVi2I9xSV+IySU4wcrtKg9awAIyUmre4Z9MDnuHj3XFhvkJi5o+28ZNrGj
 kloqW5sNCL/MxEQ60d64Q8jk7+df5pHKykXWivceMiU6DyIEaloK0TVtVEzLAX2r
 Sq6Jl1zJApvXx3qg82boOLl0GiU19wiVcrNiiGg+KzsJIXqI6fNgvi1DtpGeBRoa
 u9TPYGmIoEo+QThwr7Uao6qwQmvz41xIf8cMNC1HnTItF4JnQmNuKCgjVP2OpHvi
 cj9JMnBB5tnoZjAqMg0ykwgXt95vxsbgGFSVwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478655; x=
 1786565055; bh=dHClpRtYuvM2BPy5EoH0vuZzYxCH6SUH0FgewbkKWfU=; b=F
 iWo6MPMnsTO7RtjmLJ6OAy5A8P4ATxsiEHeayGSmlMAtnCBmY7COMmasLeoS6yRU
 pbZf6iVlsi5zKV4b/kFVB/3Cp1dIihW7UgYWdn7Dydy77OQ5wNlC+fRJhj7h/FzU
 mQLJiEfbGZwTbH/a9eerbbyL5Dovbgz1Yko6uIgyls2wt5Bk5GxFY6hxdlZDNzq+
 X1jLP8HyVGisN8P0lpmllMtRVHUf8ZKahdFfxNZTJE5dzyfqPRnLzv9o4Iio7nW6
 T2LHg+z319oSWHSMj9xqUwdaV77F6U26I+6XISvGs3/iDGeANUYWKDiNMGyPjofA
 mPqrLB2in58pc6aJJrOoQ==
X-ME-Sender: <xms:P4B7aoJYXJbHlh9KWckwPB1BfNjSk35MPm8gGue12FrUmSKjtFwKhw>
 <xme:P4B7asdmRu6rwNKNcQjIOWh-hQt66PWhA76YfZl1xyiPaMx61TpUVyTgsFuIu-Bd5
 jU1zewPQO2zyBL1rXPGdWmL1n4-CLQ3J68d-hMR62MTj9bE1oihkA>
X-ME-Received: <xmr:P4B7an0_WeH0JwY2-31iq6VbkMmOt0mQ2HioatGIe6cLkmYEk0mArwtbdzDCEWCSzB8FEg>
X-ME-Proxy-Cause: dmFkZTE3Y3iqpLM60Nt3/G7cgzhkWRCYu2+AYnQTpMaW9dgO/fCRm/0jAQGSVCqKmRLX8I
 1Bemd/AI7TemqV/HKZxOmZAXOB6BS8Rv0LC83ADVEOZOVtX88uPfNtzDneS15ZTNoF54Sv
 /3MLBHOEdI8jKv5KU2WcupPjCEwvY6kdXxIJcCZJOvx+qKuCwkRMJegkxuhp/Gip2EuSkB
 xms0XohZiNIqH4gcoOUzPwR626N3ipCPg5ZbMpheOHl24PcPXUVA1Xd3Xw2Sa+txQq81Ba
 5M1H+oX1WaaRWHuH1H2X9M9OPgh1NfO9zul2LzNluPK8rFKsLN9q8qez5bzKxr3/tOywMH
 qjFm8I7vc8Ls7CT680CzKoVQ/kKuuszJUSzKRsM6N2eoO+sU5MVeTu3DWyT83MpjG0hXOt
 iXEJxEpgle+ojpHkMFyiRu4l6RAl3nBaHyjOI8P9NzCHBbKSczBJpcYBY8qPLbR+O/2Yhd
 Quyin9ww6rfXwGbbPU4j1gin4bEg/a1KlsQvWHagiW7jFSsRQOGNUXtMjEEVkOjdIiy5OM
 zCi3gVhyEZAHjciHyaSu6l8K8XaMpQ0RQOAxqoByihtlny37+odI6dgc99+DkqzG95jFdh
 MnlKSr9n/7F1cPtNqDlKPN2i35OyfHJtVl5iNDXVQr8FtJNSxdpDrWuRi2CQ
X-ME-Proxy: <xmx:P4B7athNGMEpRyzd1HwhNVO_VBMVkfMr3ymtK5SMww4PQQS6rMzgtw>
 <xmx:P4B7alQ951RwuTesGrR0c9nkqkYWQxFOSSvL-hUT_xX8GnIT0E-LZg>
 <xmx:P4B7amgYyTHBh4F5xUf4MnOr0koSRH0L3j3hgyIkyIj4V9R4QngjpA>
 <xmx:P4B7at5PzvjITSav3fHesOMKctkLvxP_Tt6WPFi9w9L9mCQv5sv5iQ>
 <xmx:P4B7ap9DL--1t2Cs1LMFBVfrL6EgOheytnBPPzFym-4sKHWgWXj3YC_2>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:04:15 -0400 (EDT)
Message-ID: <2ccb142a681fbff50122e1e7502572d5f6f636bc.camel@alistair23.me>
Subject: Re: [PATCH 10/56] disas/riscv: Pass rv_opcode_data pointer to/from
 decode_inst_decompress
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:04:15 +1000
In-Reply-To: <20260809223545.730664-11-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-11-richard.henderson@linaro.org>
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

T24gU3VuLCAyMDI2LTA4LTA5IGF0IDE1OjM0IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBVbmlmeSA0IGZ1bmN0aW9ucywgc2hhcmluZyBjb2RlLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgoKUmV2aWV3
ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0
YWlyCgo+IC0tLQo+IMKgZGlzYXMvcmlzY3YuYyB8IDcwICsrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAtLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIxIGlu
c2VydGlvbnMoKyksIDQ5IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kaXNhcy9yaXNj
di5jIGIvZGlzYXMvcmlzY3YuYwo+IGluZGV4IGFmNDM5NDA3MzIuLjQ3ZmFlNzMxNmMgMTAwNjQ0
Cj4gLS0tIGEvZGlzYXMvcmlzY3YuYwo+ICsrKyBiL2Rpc2FzL3Jpc2N2LmMKPiBAQCAtNTM3Nyw2
NCArNTM3NywzNiBAQCBzdGF0aWMgdm9pZCBkZWNvZGVfaW5zdF9saWZ0X3BzZXVkbyhydl9kZWNv
ZGUKPiAqZGVjKQo+IMKgCj4gwqAvKiBkZWNvbXByZXNzIGluc3RydWN0aW9uICovCj4gwqAKPiAt
c3RhdGljIHZvaWQgZGVjb2RlX2luc3RfZGVjb21wcmVzc19ydjMyKHJ2X2RlY29kZSAqZGVjKQo+
ICtzdGF0aWMgY29uc3QgcnZfb3Bjb2RlX2RhdGEgKmRlY29kZV9pbnN0X2RlY29tcHJlc3MocnZf
ZGVjb2RlICpkZWMsCj4gcnZfaXNhIGlzYSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0Cj4gcnZfb3Bjb2RlX2RhdGEgKm9wKQo+IMKgewo+IC3C
oMKgwqAgY29uc3QgcnZfb3Bjb2RlX2RhdGEgKm9wY29kZV9kYXRhID0gZGVjLT5vcGNvZGVfZGF0
YTsKPiAtwqDCoMKgIGludCBkZWNvbXBfb3AgPSBvcGNvZGVfZGF0YVtkZWMtPm9wXS5kZWNvbXBf
cnYzMjsKPiAtwqDCoMKgIGlmIChkZWNvbXBfb3AgIT0gcnZfb3BfaWxsZWdhbCkgewo+IC3CoMKg
wqDCoMKgwqDCoCBpZiAoKG9wY29kZV9kYXRhW2RlYy0+b3BdLmRlY29tcF9kYXRhICYgcnZjZF9p
bW1fbnopCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJiYgZGVjLT5pbW0gPT0gMCkgewo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlYy0+b3AgPSBydl9vcF9pbGxlZ2FsOwo+IC3CoMKgwqDC
oMKgwqDCoCB9IGVsc2Ugewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlYy0+b3AgPSBkZWNv
bXBfb3A7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjLT5jb2RlYyA9IG9wY29kZV9kYXRh
W2RlY29tcF9vcF0uY29kZWM7Cj4gLcKgwqDCoMKgwqDCoMKgIH0KPiAtwqDCoMKgIH0KPiAtfQo+
ICvCoMKgwqAgaW50IGRlY29tcF9vcDsKPiDCoAo+IC1zdGF0aWMgdm9pZCBkZWNvZGVfaW5zdF9k
ZWNvbXByZXNzX3J2NjQocnZfZGVjb2RlICpkZWMpCj4gLXsKPiAtwqDCoMKgIGNvbnN0IHJ2X29w
Y29kZV9kYXRhICpvcGNvZGVfZGF0YSA9IGRlYy0+b3Bjb2RlX2RhdGE7Cj4gLcKgwqDCoCBpbnQg
ZGVjb21wX29wID0gb3Bjb2RlX2RhdGFbZGVjLT5vcF0uZGVjb21wX3J2NjQ7Cj4gLcKgwqDCoCBp
ZiAoZGVjb21wX29wICE9IHJ2X29wX2lsbGVnYWwpIHsKPiAtwqDCoMKgwqDCoMKgwqAgaWYgKChv
cGNvZGVfZGF0YVtkZWMtPm9wXS5kZWNvbXBfZGF0YSAmIHJ2Y2RfaW1tX256KQo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICYmIGRlYy0+aW1tID09IDApIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBkZWMtPm9wID0gcnZfb3BfaWxsZWdhbDsKPiAtwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZWMtPm9wID0gZGVjb21wX29wOwo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGRlYy0+Y29kZWMgPSBvcGNvZGVfZGF0YVtkZWNvbXBfb3BdLmNvZGVj
Owo+IC3CoMKgwqDCoMKgwqDCoCB9Cj4gLcKgwqDCoCB9Cj4gLX0KPiAtCj4gLXN0YXRpYyB2b2lk
IGRlY29kZV9pbnN0X2RlY29tcHJlc3NfcnYxMjgocnZfZGVjb2RlICpkZWMpCj4gLXsKPiAtwqDC
oMKgIGNvbnN0IHJ2X29wY29kZV9kYXRhICpvcGNvZGVfZGF0YSA9IGRlYy0+b3Bjb2RlX2RhdGE7
Cj4gLcKgwqDCoCBpbnQgZGVjb21wX29wID0gb3Bjb2RlX2RhdGFbZGVjLT5vcF0uZGVjb21wX3J2
MTI4Owo+IC3CoMKgwqAgaWYgKGRlY29tcF9vcCAhPSBydl9vcF9pbGxlZ2FsKSB7Cj4gLcKgwqDC
oMKgwqDCoMKgIGlmICgob3Bjb2RlX2RhdGFbZGVjLT5vcF0uZGVjb21wX2RhdGEgJiBydmNkX2lt
bV9ueikKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmJiBkZWMtPmltbSA9PSAwKSB7Cj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjLT5vcCA9IHJ2X29wX2lsbGVnYWw7Cj4gLcKgwqDCoMKg
wqDCoMKgIH0gZWxzZSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjLT5vcCA9IGRlY29t
cF9vcDsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZWMtPmNvZGVjID0gb3Bjb2RlX2RhdGFb
ZGVjb21wX29wXS5jb2RlYzsKPiAtwqDCoMKgwqDCoMKgwqAgfQo+IC3CoMKgwqAgfQo+IC19Cj4g
LQo+IC1zdGF0aWMgdm9pZCBkZWNvZGVfaW5zdF9kZWNvbXByZXNzKHJ2X2RlY29kZSAqZGVjLCBy
dl9pc2EgaXNhKQo+IC17Cj4gwqDCoMKgwqAgc3dpdGNoIChpc2EpIHsKPiDCoMKgwqDCoCBjYXNl
IHJ2MzI6Cj4gLcKgwqDCoMKgwqDCoMKgIGRlY29kZV9pbnN0X2RlY29tcHJlc3NfcnYzMihkZWMp
Owo+ICvCoMKgwqDCoMKgwqDCoCBkZWNvbXBfb3AgPSBvcC0+ZGVjb21wX3J2MzI7Cj4gwqDCoMKg
wqDCoMKgwqDCoCBicmVhazsKPiDCoMKgwqDCoCBjYXNlIHJ2NjQ6Cj4gLcKgwqDCoMKgwqDCoMKg
IGRlY29kZV9pbnN0X2RlY29tcHJlc3NfcnY2NChkZWMpOwo+ICvCoMKgwqDCoMKgwqDCoCBkZWNv
bXBfb3AgPSBvcC0+ZGVjb21wX3J2NjQ7Cj4gwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDCoMKg
wqDCoCBjYXNlIHJ2MTI4Ogo+IC3CoMKgwqDCoMKgwqDCoCBkZWNvZGVfaW5zdF9kZWNvbXByZXNz
X3J2MTI4KGRlYyk7Cj4gK8KgwqDCoMKgwqDCoMKgIGRlY29tcF9vcCA9IG9wLT5kZWNvbXBfcnYx
Mjg7Cj4gwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiArwqDCoMKgIGRlZmF1bHQ6Cj4gK8KgwqDC
oMKgwqDCoMKgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cj4gwqDCoMKgwqAgfQo+ICsKPiArwqDC
oMKgIGlmIChkZWNvbXBfb3AgIT0gcnZfb3BfaWxsZWdhbCkgewo+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAoKG9wLT5kZWNvbXBfZGF0YSAmIHJ2Y2RfaW1tX256KSAmJiBkZWMtPmltbSA9PSAwKSB7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjLT5vcGNvZGVfZGF0YSA9IHJ2aV9vcGNvZGVfZGF0
YTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZWMtPm9wID0gcnZfb3BfaWxsZWdhbDsKPiAr
wqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZWMtPm9w
ID0gZGVjb21wX29wOwo+ICvCoMKgwqDCoMKgwqDCoCB9Cj4gK8KgwqDCoMKgwqDCoMKgIG9wID0g
JmRlYy0+b3Bjb2RlX2RhdGFbZGVjb21wX29wXTsKPiArwqDCoMKgwqDCoMKgwqAgZGVjLT5jb2Rl
YyA9IG9wLT5jb2RlYzsKPiArwqDCoMKgIH0KPiArwqDCoMKgIHJldHVybiBvcDsKPiDCoH0KPiDC
oAo+IMKgLyogZGlzYXNzZW1ibGUgaW5zdHJ1Y3Rpb24gKi8KPiBAQCAtNTQ5MSw3ICs1NDYzLDcg
QEAgc3RhdGljIEdTdHJpbmcgKmRpc2FzbV9pbnN0KHJ2X2lzYSBpc2EsCj4gdWludDY0X3QgcGMs
IHJ2X2luc3QgaW5zdCwKPiDCoAo+IMKgwqDCoMKgIG9wID0gJmRlYy5vcGNvZGVfZGF0YVtkZWMu
b3BdOwo+IMKgwqDCoMKgIGRlY29kZV9pbnN0X29wZXJhbmRzKCZkZWMsIGlzYSwgb3ApOwo+IC3C
oMKgwqAgZGVjb2RlX2luc3RfZGVjb21wcmVzcygmZGVjLCBpc2EpOwo+ICvCoMKgwqAgb3AgPSBk
ZWNvZGVfaW5zdF9kZWNvbXByZXNzKCZkZWMsIGlzYSwgb3ApOwo+IMKgwqDCoMKgIGRlY29kZV9p
bnN0X2xpZnRfcHNldWRvKCZkZWMpOwo+IMKgwqDCoMKgIHJldHVybiBmb3JtYXRfaW5zdCgyNCwg
JmRlYyk7Cj4gwqB9Cg==


