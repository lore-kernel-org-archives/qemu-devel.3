Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC4DC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwAYS-0000tz-GM; Mon, 17 Aug 2026 23:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wwAYR-0000te-Kz; Mon, 17 Aug 2026 23:31:59 -0400
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wwAYQ-0007VU-87; Mon, 17 Aug 2026 23:31:59 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 00F791D0004B;
 Mon, 17 Aug 2026 23:31:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 17 Aug 2026 23:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1787023916; x=1787110316; bh=r/UlKKx/Zkl5BG+/6HZz7xxMtKu4pP6g
 5ipIgq0RgEQ=; b=lCwQP9T3bP1qIJqofGT+Shu3aqB/aOhL9xKhs4f7k1I2NR7l
 Q99jFz/FG0oVi6Kv6zLPMEYGbrqfn8k05auWmXgVEPrZrMmR2wTHM3RnXDbnM5tf
 aNqIg6UXR7RcTRCsOuxxYjYyPhPTJknhsHsORQ5KFuaaX7XJzX4YhF8SNoLPSkLT
 HIxsQs/Td2Wx1mFDHKLdjnYNtsmPk63qGM5vaEbM3v5FEFBobjU8y8nmUjoBUrLm
 BB5K8Y15iLEd7KsoIp/LxKRJTTrax93jML3qOyisiw3Eh3VadVPgEDiXeZNv84eY
 hVtXTe3cb9+WFbscrMKYu++32SwIZ/ZnqSJduQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787023916; x=
 1787110316; bh=r/UlKKx/Zkl5BG+/6HZz7xxMtKu4pP6g5ipIgq0RgEQ=; b=L
 fiOVmB7JyD3DC6R4KCCboYHH11k7iPfcLS21/xXPdnkrACt4X3zO7oe87WPSnVal
 SKkd+/XuhDwvIzmVIjRdmyeqZirSucY4vQHngOZYXwfkImoUiCNk+6MfJLZYLy9D
 Rl0Zz+h4SkcOgw3jPssVwzs2mc6bulxzLhw0RvNMNYXRl14xXU2NgrLXmHnwNa/o
 l4F4QfAtQ6+6SN1oCAWf1DYFxq5FzHhVfr7jEZO6N0AHsgJ8TQAjyi17xj79QjxQ
 gKEboS4wj/k5vK/BSKnY4rBizX4PgeNeah0yPJ24X5xnfYXAdvQYXfpADQn9XtEF
 UJu0/s+ph7dTX3duaBaBw==
X-ME-Sender: <xms:LNKDajp9Co2rkdSGx_1xzuuGrvQ5TQW58RyVNQ5C3sW9wwoZcQuigQ>
 <xme:LNKDatzuAkKiIz0XDtFE75iG6KjBAuT2hqB5OnRb6JFysYvPyVwY0SEaPv5DanKsY
 7CBYjXdkiCdt-l4fSuJjjbtYgcKp8mVAQe_6nalH25AjlrKb4nCTEDP>
X-ME-Received: <xmr:LNKDaoJlfCZqxyS3FqJ0MdtZsEnqSx0k7sz4erULnu39YB8yfaNRIQmmGN2EGv_AvbvP7st0iXWSjfeO4boCqEJ9wGE>
X-ME-Proxy-Cause: dmFkZTGPFYID+zTiYQaqLZYysGzD6u8s2u5JFzTDdL+uP08foKUR6FQRRcGFuf+DiztYEi
 Jk1yx1EaFZ4j+OWoMGUdyeHfsPkbMa2TVqWU3edDO6SbbnNk+9KzUuXdbJdLCSgYEocT3B
 hdAayYNaTY/+dPaz5sVlGeZyq6E2D8STT85Ibmd1BCTTX8fmN2YvRmrygDyqom09xAjSFy
 iM6vZRcekPKjOwEV5v6Kg6+nq9iPvCv5veOwl8zWqfTchsaa0C1Xq5rAIIJNt5iJRJPlIF
 /LzuXkumz10ROfaEaZfn5MGgRKFXYDi9oIejoLOi7RSSko9sFIwiPAZ+UspKai3vp2SBrs
 kZtw0wgt9E7ligI9H+9/Gl+w8p1E80eWeCmlHD91+Sz9UJ6xIdTqLSg2rTo8A4ZqOxAlbx
 2/BX5VYhbzohEJZVWJZuXcePl+egxklE++xcs7JAtuJ92ELrAfEDCVpCbBLJhvhM0Yzw4p
 n2icYdYvi4W9tSLAPL11icmpTZa2qt4517Ucs49CubnNjr2+UASzhpEVDu36Y4k15DM6nX
 guv6ULvEiHPqeqxY6YbTQsxOlgck5ol9PQHKwNsmVS/Y/I5ieaXJyZI52pc4JcjO4p3NSO
 87Qj4PYQMWkuYOEuLGPqFVi1kvX81+gxdIKH7Y20sMenqihMruWsr8ZhilWA
X-ME-Proxy: <xmx:LNKDavLEMNnhBMZiRmlH4v1XmQ19q6jfdUSY1t68bzmv3uQDyf3AYw>
 <xmx:LNKDattUtyONL9JFB1RR1EHjhLtBHk8n37dIO4HVetl8Y3opKXd4hw>
 <xmx:LNKDakTxT-gPQhabTrO8citCvLaejoH_Im_bT21uUxjLXh3UecxCFw>
 <xmx:LNKDarMHvsytLzlYqMaPwZcapiOGJLSn6b1-YId3UUYhUf1aHIXSdQ>
 <xmx:LNKDagDlYzUbm6uEdMrjFio43tQRerIR3w5hIXWd3UiEWh9Y7xR0XWyj>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 23:31:54 -0400 (EDT)
Message-ID: <a259a94377d9c41ae20f6299a6b4dbd5da367ad9.camel@alistair23.me>
Subject: Re: [RFC PATCH 14/18] target/riscv: Return bool from pmp_is_in_range
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Date: Tue, 18 Aug 2026 13:31:52 +1000
In-Reply-To: <20260815203730.1468365-15-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.148;
 envelope-from=alistair@alistair23.me; helo=fout-b5-smtp.messagingengine.com
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

T24gU2F0LCAyMDI2LTA4LTE1IGF0IDEzOjM3IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25A
bGluYXJvLm9yZz4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFu
Y2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoHRhcmdldC9yaXNjdi90Y2cvcG1wLmMg
fCAyMSArKysrKystLS0tLS0tLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDE1IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNn
L3BtcC5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuYwo+IGluZGV4IDViY2NjNjA1MjcuLjVlYTBl
NWI2YzMgMTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuYwo+ICsrKyBiL3Rhcmdl
dC9yaXNjdi90Y2cvcG1wLmMKPiBAQCAtMjk5LDE4ICsyOTksMTAgQEAgdm9pZCBwbXBfdXBkYXRl
X3J1bGVfbnVtcyhDUFVSSVNDVlN0YXRlICplbnYpCj4gwqDCoMKgwqAgfQo+IMKgfQo+IMKgCj4g
LXN0YXRpYyBpbnQgcG1wX2lzX2luX3JhbmdlKENQVVJJU0NWU3RhdGUgKmVudiwgaW50IHBtcF9p
bmRleCwgaHdhZGRyCj4gYWRkcikKPiArc3RhdGljIGJvb2wgcG1wX2lzX2luX3JhbmdlKENQVVJJ
U0NWU3RhdGUgKmVudiwgaW50IHBtcF9pbmRleCwKPiBod2FkZHIgYWRkcikKPiDCoHsKPiAtwqDC
oMKgIGludCByZXN1bHQgPSAwOwo+IC0KPiAtwqDCoMKgIGlmICgoYWRkciA+PSBlbnYtPnBtcF9z
dGF0ZS5hZGRyW3BtcF9pbmRleF0uc2EpICYmCj4gLcKgwqDCoMKgwqDCoMKgIChhZGRyIDw9IGVu
di0+cG1wX3N0YXRlLmFkZHJbcG1wX2luZGV4XS5lYSkpIHsKPiAtwqDCoMKgwqDCoMKgwqAgcmVz
dWx0ID0gMTsKPiAtwqDCoMKgIH0gZWxzZSB7Cj4gLcKgwqDCoMKgwqDCoMKgIHJlc3VsdCA9IDA7
Cj4gLcKgwqDCoCB9Cj4gLQo+IC3CoMKgwqAgcmV0dXJuIHJlc3VsdDsKPiArwqDCoMKgIHJldHVy
biAoYWRkciA+PSBlbnYtPnBtcF9zdGF0ZS5hZGRyW3BtcF9pbmRleF0uc2EgJiYKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBhZGRyIDw9IGVudi0+cG1wX3N0YXRlLmFkZHJbcG1wX2luZGV4XS5l
YSk7Cj4gwqB9Cj4gwqAKPiDCoC8qCj4gQEAgLTM4NSwxMCArMzc3LDcgQEAgYm9vbCBwbXBfaGFy
dF9oYXNfcHJpdnMoQ1BVUklTQ1ZTdGF0ZSAqZW52LAo+IGh3YWRkciBhZGRyLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwbXBfcHJpdl90ICphbGxv
d2VkX3ByaXZzLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwcml2aWxlZ2VfbW9kZV90IG1vZGUpCj4gwqB7Cj4gLcKgwqDCoCBpbnQgaSA9IDA7Cj4g
wqDCoMKgwqAgaW50IHBtcF9zaXplID0gMDsKPiAtwqDCoMKgIGh3YWRkciBzID0gMDsKPiAtwqDC
oMKgIGh3YWRkciBlID0gMDsKPiDCoMKgwqDCoCB1aW50OF90IHBtcF9yZWdpb25zID0gcmlzY3Zf
Y3B1X2NmZyhlbnYpLT5wbXBfcmVnaW9uczsKPiDCoAo+IMKgwqDCoMKgIC8qIFNob3J0IGN1dCBp
ZiBubyBydWxlcyAqLwo+IEBAIC00MTQsNyArNDAzLDkgQEAgYm9vbCBwbXBfaGFydF9oYXNfcHJp
dnMoQ1BVUklTQ1ZTdGF0ZSAqZW52LAo+IGh3YWRkciBhZGRyLAo+IMKgwqDCoMKgwqAgKiAxLjEw
IGRyYWZ0IHByaXYgc3BlYyBzdGF0ZXMgdGhlcmUgaXMgYW4gaW1wbGljaXQgb3JkZXIKPiDCoMKg
wqDCoMKgICogZnJvbSBsb3cgdG8gaGlnaAo+IMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgIGZvciAo
aSA9IDA7IGkgPCBwbXBfcmVnaW9uczsgaSsrKSB7Cj4gK8KgwqDCoCBmb3IgKGludCBpID0gMDsg
aSA8IHBtcF9yZWdpb25zOyBpKyspIHsKPiArwqDCoMKgwqDCoMKgwqAgYm9vbCBzLCBlOwo+ICsK
PiDCoMKgwqDCoMKgwqDCoMKgIGlmIChwbXBfZ2V0X2FfZmllbGQoZW52LT5wbXBfc3RhdGUucG1w
W2ldLmNmZ19yZWcpID09Cj4gUE1QX0FNQVRDSF9PRkYpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY29udGludWU7Cj4gwqDCoMKgwqDCoMKgwqDCoCB9Cg==


