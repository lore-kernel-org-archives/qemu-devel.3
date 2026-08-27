Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB7BC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSft-0005Lu-FR; Thu, 27 Aug 2026 01:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzSfr-0005LI-6H; Thu, 27 Aug 2026 01:29:15 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzSfp-0008Py-Mv; Thu, 27 Aug 2026 01:29:14 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C31D214001E6;
 Thu, 27 Aug 2026 01:29:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 27 Aug 2026 01:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1787808551; x=1787894951; bh=xH/9fYlkVLcxpzTx0FOfaurs+lAfO3q7
 6r+KhFZgE2g=; b=G5iZeENwrTfFT2M78oh3VulPAcYM1SGZvqQmr7zj7XPtg1ia
 JAI0dfmSGej4CweJRhF/ZL9BHhcLeeRuSR42aBPSRGy74lFZyz8JUDfkGvlufOIl
 8xXefofmw344dRE5PiMTtBcEj7gAnl5yUJP/cwijEa1lPKA2FaTVBbjA+77vtOmY
 kcAh4qMEh2r95UOopfnMTiYUBECpW0u0VTDHR7kTj0BMt84ejSVeHI+qmWVvfC26
 ngifhp0HMvqjrnqklQ3FxI4p/iBFNRar1XafCmJ3rVkryIBTI+MHWxq+IsQuLuNw
 vS4onimZ8YCV3BUkITfwWJi8gWp1qYC2jWXvjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787808551; x=
 1787894951; bh=xH/9fYlkVLcxpzTx0FOfaurs+lAfO3q76r+KhFZgE2g=; b=A
 XaS9lVU0J6MvNqMuWhFZsKS5/n1x4PT73akBXQAoCNodzIhevuTzE5pulrUvi7sn
 /HHHY7NoAKaOshigs+lLrrKxFlI6HNS20rnao0AYwHQ1gM4/s7/+s3QtMwICC8oJ
 n9xuerIAkroJwGRxqWRGpKVP7UzbKe8I0fQiXlZpRYsuNOlaEQzqem+L9uvsbwiB
 c1j5cn/uxfbW3m2ydE+u80SBmWsli/wIIliJOIcs+CN6aYIg9lG+o3DYeRdvAhKh
 2CoSKvUSf0EJcsESE1F0HiLIyH9otnC6MydtRRwX4HTo0ViIN3r+0Cv73nYxcMyf
 L/5aGpqSZyLsVXPRaAo1g==
X-ME-Sender: <xms:J8uPah_X5EYPp61MJO1b3D1ii-_lw_cLbo1DyBRNSGTFqYik5MALaQ>
 <xme:J8uPanXRWD98FCv8f9gA_F2yOCi7kwMdGQR2diR8Kk5YTgzM3qBZM6-fD4BLz367T
 yoS1pQyW4tDLMmxx7osOx_S8Kd8ekkGm4kvMrA1dDVbpbLgZV5gSSY>
X-ME-Received: <xmr:J8uPatv2zfaWNo3U01PGnzJReGKhYdiVvbc4CkNPu7MQK9hpYZv03r6AapQ8DeEpY8ztJ0ZZQ20XJP-9u3vSedyH55M>
X-ME-Proxy-Cause: dmFkZTGxTzDF9ljJovxys1DnOAP0oUJYty27B0GzBM4AXiCJZn3bFLRWTYPddY6wPdtbi3
 LsMf639TMhCgcY8YGmw5a71jBM5Tm+Ly0lIZSBP+kXpBaufxKbT91VVd/AfhlpIm/a8fqJ
 qnXrccbBd3jRyM7clZbeLcthu8KWr5eOsFEp+msZKwr8FERLfyTok7Und+7iE/hppI+z6E
 NpNVSJtIRKP5rXJThMVue7BQz0b1mhbiB88Ng9vRwwl8Z6UCEM7c+GxnwYPhddH8RtIvHO
 EXISFgbTV4wZQg2MaF9vXKNHNo+CzxHLOVQzhKn9DxKSRZa6AkV0vHNiZjdmzGIdgTuecc
 Y5MdoVmGpN4JpGbSqfu4orq/Plio0c4oseQ3cKf3Niaefq6nqXNZScm3qXp/BtSkqv7n1W
 na5/PCwt95dP1rpFwbqA2glmJeA4xKd6gKNWisyAf5lOADVDF+LZJ6of/IuKVlbjuFO+KR
 qvwfCy5IdXpMEZN4JG8NwCsvOmw4GRTM24RD3hVjW3iGeIzjKWCemqGtKhcnwzj+EoMI8A
 L2yH0nC14j4J348BSOR3H9RP3pitgvoAZOgak4YwnQOlcY6gJt0Q/20mSaAEwTgoJLFnQJ
 +u+v+iKskcjpHGy2daxa21lAkF3kVhS+Ebsx2SitYRmx/6aYmc51mse5wRzA
X-ME-Proxy: <xmx:J8uPat80VlVYsr-1Qf65lwGLOr8wSpYP7Fo14mURfqR_1NTVUZeLFA>
 <xmx:J8uPam3zbHIyU1kMqIF-ljfz-vBueNtrtP7iOj7pzgPqIkITZq70Uw>
 <xmx:J8uPaiSdRNnJo-1-ppI39wDfr8bj3SMG7chlO1J1Q-mVjP2__LEhMA>
 <xmx:J8uPapAhQzqXBtn4kzpMfRsbSwutuXruUTRHJBiQHrxidTZ7ZnGWZw>
 <xmx:J8uPaqHPhyO0Rc1Z_xrMOYgoH69lfF3DMJhid_GXs6-lC3xP-NYhxpK6>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 01:29:04 -0400 (EDT)
Message-ID: <99e467eada1799265b37a6d661aad51fa502bab4.camel@alistair23.me>
Subject: Re: [PATCH 3/4] hw/arm/strongarm: Fix dropped upper byte of ssi
 transfer
From: Alistair <alistair@alistair23.me>
To: stephensportia@gmail.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell	 <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 	qemu-ppc@nongnu.org,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Troy Lee	 <leetroy@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@mailo.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Nicholas Piggin	 <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Kane Chen	 <kane_chen@aspeedtech.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 Glenn Miles <milesg@linux.ibm.com>, 	qemu-riscv@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
Date: Thu, 27 Aug 2026 15:29:02 +1000
In-Reply-To: <20260825040452.1322251-4-stephensportia@gmail.com>
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <20260825040452.1322251-4-stephensportia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=alistair@alistair23.me; helo=fhigh-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

T24gVHVlLCAyMDI2LTA4LTI1IGF0IDE0OjA0ICsxMDAwLCBzdGVwaGVuc3BvcnRpYUBnbWFpbC5j
b20gd3JvdGU6Cj4gRnJvbTogUG9ydGlhIFN0ZXBoZW5zIDxwb3J0aWFzQG9zcy50ZW5zdG9ycmVu
dC5jb20+Cj4gCj4gVGhlIHN0cm9uZ2FybSBtb2RlbCBpbnRlbmRzIHRvIHRyYW5zZmVyIGEgMTYt
Yml0IHZhbHVlIG92ZXIgU1NJLgo+IFRoZXJlCj4gaXMgbm8gbWFjaGluZSB1c2luZyB0aGlzIG1v
ZGVsIHdpdGggYSBwZXJpcGhlcmFsIGF0dGFjaGVkIHNvIGl0IGlzCj4gaW1wb3NzaWJsZSB0byBr
bm93IHdoYXQgdGhlIGludGVuZGVkIFNTSSBwZXJpcGhlcmFsIGlzLgo+IFRoZXJlIGlzIG5vIGlu
LXRyZWUgcGVyaXBoZXJhbCBzdXBwb3J0IGZvciAxNi1iaXQgdHJhbnNmZXIsIHVwZGF0ZSB0bwo+
IHVzZSA4LWJpdCB0cmFuc2Zlci4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBQb3J0aWEgU3RlcGhlbnMg
PHBvcnRpYXNAb3NzLnRlbnN0b3JyZW50LmNvbT4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFu
Y2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGh3L2Fy
bS9zdHJvbmdhcm0uYyB8IDcgKysrKystLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3N0cm9uZ2FybS5j
IGIvaHcvYXJtL3N0cm9uZ2FybS5jCj4gaW5kZXggZTQwMGYwYTE4NS4uMmRmODk1Yzc1YiAxMDA2
NDQKPiAtLS0gYS9ody9hcm0vc3Ryb25nYXJtLmMKPiArKysgYi9ody9hcm0vc3Ryb25nYXJtLmMK
PiBAQCAtMTUxMiwxMSArMTUxMiwxNCBAQCBzdGF0aWMgdm9pZCBzdHJvbmdhcm1fc3NwX3dyaXRl
KHZvaWQgKm9wYXF1ZSwKPiBod2FkZHIgYWRkciwKPiDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0aGVy
ZSBkaXJlY3RseSB0byB0aGUgc2xhdmUsIG5vIG5lZWQgdG8gYnVmZmVyIGl0Lgo+IMKgwqDCoMKg
wqDCoMKgwqDCoCAqLwo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKHMtPnNzY3JbMF0gJiBTU0NSMF9T
U0UpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCByZWFkdmFsOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHJlYWR2YWwgPSAwOwo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAocy0+c3NjclsxXSAmIFNTQ1IxX0xCTSkgewo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJlYWR2YWwgPSB2YWx1ZTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfSBlbHNlIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlYWR2YWwg
PSBzc2lfdHJhbnNmZXI4KHMtPmJ1cywgdmFsdWUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKFNTQ1IwX0RTUyhzLT5zc2NyWzBdKSA+IDgpIHsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVhZHZhbCB8PSBzc2lfdHJhbnNmZXI4KHMtPmJ1
cywgKHZhbHVlID4+IDgpICYKPiAweGZmKSA8PCA4Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVhZHZhbCB8PSBz
c2lfdHJhbnNmZXI4KHMtPmJ1cywgdmFsdWUgJiAweGZmKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChzLT5yeF9sZXZlbCA8
IDB4MDgpIHsK


