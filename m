Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F22AC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsN0-0002FU-4G; Tue, 11 Aug 2026 15:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsMw-0002El-IX
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:42:39 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsMu-0006IT-7A
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:42:37 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 809F81400166;
 Tue, 11 Aug 2026 15:42:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 11 Aug 2026 15:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1786477355;
 x=1786563755; bh=tFFQv8kLOgs2OBvMUDW5kDZP9wi2XTvdNuGxTNbOlU0=; b=
 czjBj4aTAAlCuJOmOj1A1VD7I2jfm4ahwDymPcIuYFI/HlLyUSVdeQhrr8wjyjxi
 f/VxcLuJLeB1/EeGHrfz3t5/SD4rIpcnvhjdvucX77v3Kz0eOLYzqfxoRkF4qpX0
 Gw0Jg/3LEAJYOpSCR3U1oIyN6vHC1zSql39NIBC9nH8ltfRriEXLQ0zIPaOkPrDr
 /jCcJr6NfznKf80FwFxDEaPCi51KLghN5C7wohVLec6ftkNhBNt+0Ex3rmp9Z+1n
 myrG9utm1ew0qDTNSIlM5R3SOOt4m/FD264QUk2/8DrBipsqxe3BQH0i2C6eeLAt
 WCqz9oC35xrBIuhX+f5Sqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786477355; x=1786563755; bh=t
 FFQv8kLOgs2OBvMUDW5kDZP9wi2XTvdNuGxTNbOlU0=; b=M0DHN4rUm5PHVnYG/
 uJ5XUMIq6EbJNnrDLjnVdiRqsocGCTh9597WQwb5EvvORDyflZtoGzOBEqZ9/M3b
 1zediFIWUVoXdpApkH2jUnIkRMUGvjwlbqrO5cQ0v5MkR8qkehn1+MQFhyJPQHkY
 oHhdEfcmYxCIP6ye13kP64hoMYAPhg+xtVniimTyNY6VfFQCiC/DCBXhUw+ItsA/
 qaCZrTR6a53iquET7fjAgl8fhm/DvApyoBaAkswJDQGjkSvBFiTWNbcE6AFPPmbC
 ed0rANDXJdN0HjKqhgL3QO045bIvAfwraleFpLklNyscjATSoRh30v6cmbjp5R6d
 S5OiA==
X-ME-Sender: <xms:K3t7al_hvBwkoVpbXwzq-w8n4q4FJiqsENjiouW3TowmMGVIJVQauA>
 <xme:K3t7amA8JtZL0nDi2fneBGOKHE1cXqwnTdcGHYLS96-YuaIzG8B5PN9Dkmup_l-Kf
 RPGTIHv_782FyHCf0qddgYs3Aou7aqwAF5cbQdONzVNuZRSu5AsaQ>
X-ME-Received: <xmr:K3t7alz-BIBHRHyVeej2wUe-pn4DwVQGBntVjzP8b2GxGZqxFhJQIBdASltnfihrKl_2Kw>
X-ME-Proxy-Cause: dmFkZTEjvvAyhsRzZP/Aut29qecPO9ZLNxm04KV/Q44Ajtpuv5uPOZODqjkERW+eDyr2a2
 uyelIjKelV0RtJ891C9xC+CT2Xrt2bqUqc7QahUbbK9y4IcnaHhE8NSKXFcaikLR37JJZl
 d/3Yg0XQWqJQschOyiGow9GemPiNAp+zJ0KTvh4S+fonsku2AWvnc3Cb+hGYYNEXs7skZq
 99uGRq/KGXjsDiMv3DxhZ8EOuwl3DJ9UqvAZ301DV3n4+Ec1B2RJnYncxSlvGQ9nXEuyJh
 et1jy7aGtTfr5wMC6TNsbEA/MF9Ajt9XZJHV0m1aCM9ok0KIztoWbRLU12KX50j4dOHQXi
 +5tJsDL/TElWcLXWvMeVzafw+2WT0/GzseF9OWCcijv0VaWYroHC6MRKcPKTJx/9rEp64P
 viZiwAjDqCjpIq2SDp2LdfmQ9lwSTwgbOjIwhhihl/Pi8vgaU8rQgOBX8M7qso0FGgXimG
 pqhbvdn97G98y1tUY0hw6qe0BJpCeiDYqskfugQ9Mtx7um5Tr8PTSP2VIoqSngJ6yWm8ao
 4wldeJXp/6cXQ5h/IEEO6HZ4iK8vTG96LqaDB48l+fd/2p7pwveT5EwftRqigd7CZ4iyEf
 ElzeHqK3PyCPNyyP/0xT2SNc645RS+s3/mEL6EZsFT9WmNbqNYzW4xusN/+g
X-ME-Proxy: <xmx:K3t7arSUChyp-syIq2C5K9zI8ITPsSFTUvpY_vXjvjbRnVa35T38zQ>
 <xmx:K3t7as_-U9Qxrl1ZRUz0AjlJs4kVAXaxx09TyZlN5ayOJI8RZx7q4A>
 <xmx:K3t7airBX2_0yfAMADwY-_YryYsRIAR6vgXDPmfj-WseYu-wZjD1lw>
 <xmx:K3t7apl4z9sSxlyI74T2Ip7ydv7KpZnuCqU6e9TkgSkm2pEUV5z_cg>
 <xmx:K3t7ahh_u2OrNzzxWGvtj7fkTyM77N3JxDaoFt-2M2wD89eu6axSntVs>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:42:35 -0400 (EDT)
Message-ID: <993c0a1a9627ad5183ecd89912fde7cbd8c087a1.camel@alistair23.me>
Subject: Re: [PATCH v2 13/16] util/cpuinfo-riscv: Detect Zbkb
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Date: Wed, 12 Aug 2026 05:42:34 +1000
In-Reply-To: <20260811045605.1246543-14-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
 <20260811045605.1246543-14-richard.henderson@linaro.org>
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

T24gTW9uLCAyMDI2LTA4LTEwIGF0IDIxOjU2IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBSSVNDVl9IV1BST0JFX0VYVF9aQktCIHdhcyBpbnRyb2R1Y2VkIGluIGxpbnV4IDYuMTAK
PiB3aXRoIHRoZSByZXN0IG9mIHRoZSBod3Byb2JlIGFwaS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBS
aWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KClJldmlld2Vk
LWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+CgpBbGlzdGFp
cgoKPiAtLS0KPiDCoGhvc3QvaW5jbHVkZS9yaXNjdjY0L2hvc3QvY3B1aW5mby5oIHzCoCAxICsK
PiDCoHV0aWwvY3B1aW5mby1yaXNjdi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
MTcgKysrKysrKysrKysrKysrLS0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaG9zdC9pbmNsdWRlL3Jpc2N2NjQv
aG9zdC9jcHVpbmZvLmgKPiBiL2hvc3QvaW5jbHVkZS9yaXNjdjY0L2hvc3QvY3B1aW5mby5oCj4g
aW5kZXggYjJiNTNkYmY2Mi4uMWYwNDcwNTFhMyAxMDA2NDQKPiAtLS0gYS9ob3N0L2luY2x1ZGUv
cmlzY3Y2NC9ob3N0L2NwdWluZm8uaAo+ICsrKyBiL2hvc3QvaW5jbHVkZS9yaXNjdjY0L2hvc3Qv
Y3B1aW5mby5oCj4gQEAgLTEyLDYgKzEyLDcgQEAKPiDCoCNkZWZpbmUgQ1BVSU5GT19aQlPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKDF1IDw8IDMpCj4gwqAjZGVmaW5lIENQVUlORk9fWklDT05E
wqDCoMKgwqDCoMKgwqDCoMKgICgxdSA8PCA0KQo+IMKgI2RlZmluZSBDUFVJTkZPX1pWRTY0WMKg
wqDCoMKgwqDCoMKgwqDCoCAoMXUgPDwgNSkKPiArI2RlZmluZSBDUFVJTkZPX1pCS0LCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICgxdSA8PCA2KQo+IMKgCj4gwqAvKiBJbml0aWFsaXplZCB3aXRoIGEg
Y29uc3RydWN0b3IuICovCj4gwqBleHRlcm4gdW5zaWduZWQgY3B1aW5mbzsKPiBkaWZmIC0tZ2l0
IGEvdXRpbC9jcHVpbmZvLXJpc2N2LmMgYi91dGlsL2NwdWluZm8tcmlzY3YuYwo+IGluZGV4IDAy
OTFiNzIxOGEuLjhjNDhiMWVhOTEgMTAwNjQ0Cj4gLS0tIGEvdXRpbC9jcHVpbmZvLXJpc2N2LmMK
PiArKysgYi91dGlsL2NwdWluZm8tcmlzY3YuYwo+IEBAIC0zNiw3ICszNiw3IEBAIHN0YXRpYyB2
b2lkIHNpZ2lsbF9oYW5kbGVyKGludCBzaWdubywgc2lnaW5mb190Cj4gKnNpLCB2b2lkICpkYXRh
KQo+IMKgLyogQ2FsbGVkIGJvdGggYXMgY29uc3RydWN0b3IgYW5kIChwb3NzaWJseSkgdmlhIG90
aGVyIGNvbnN0cnVjdG9ycy4KPiAqLwo+IMKgdW5zaWduZWQgX19hdHRyaWJ1dGVfXygoY29uc3Ry
dWN0b3IpKSBjcHVpbmZvX2luaXQodm9pZCkKPiDCoHsKPiAtwqDCoMKgIHVuc2lnbmVkIGxlZnQg
PSBDUFVJTkZPX1pCQSB8IENQVUlORk9fWkJCIHwgQ1BVSU5GT19aQlMKPiArwqDCoMKgIHVuc2ln
bmVkIGxlZnQgPSBDUFVJTkZPX1pCQSB8IENQVUlORk9fWkJCIHwgQ1BVSU5GT19aQlMgfAo+IENQ
VUlORk9fWkJLQgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IENQVUlO
Rk9fWklDT05EIHwgQ1BVSU5GT19aVkU2NFg7Cj4gwqDCoMKgwqAgdW5zaWduZWQgaW5mbyA9IGNw
dWluZm87Cj4gwqAKPiBAQCAtNjAsNiArNjAsOSBAQCB1bnNpZ25lZCBfX2F0dHJpYnV0ZV9fKChj
b25zdHJ1Y3RvcikpCj4gY3B1aW5mb19pbml0KHZvaWQpCj4gwqAjaWYgZGVmaW5lZChfX3Jpc2N2
X2FyY2hfdGVzdCkgJiYgXAo+IMKgwqDCoMKgIChkZWZpbmVkKF9fcmlzY3ZfdmVjdG9yKSB8fCBk
ZWZpbmVkKF9fcmlzY3ZfenZlNjR4KSkKPiDCoMKgwqDCoCBpbmZvIHw9IENQVUlORk9fWlZFNjRY
Owo+ICsjZW5kaWYKPiArI2lmIGRlZmluZWQoX19yaXNjdl9hcmNoX3Rlc3QpICYmIGRlZmluZWQo
X19yaXNjdl96YmtiKQo+ICvCoMKgwqAgaW5mbyB8PSBDUFVJTkZPX1pCS0I7Cj4gwqAjZW5kaWYK
PiDCoMKgwqDCoCBsZWZ0ICY9IH5pbmZvOwo+IMKgCj4gQEAgLTc2LDcgKzc5LDggQEAgdW5zaWdu
ZWQgX19hdHRyaWJ1dGVfXygoY29uc3RydWN0b3IpKQo+IGNwdWluZm9faW5pdCh2b2lkKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbmZvIHw9IHBhaXIudmFsdWUgJiBSSVNDVl9IV1BST0JF
X0VYVF9aQkEgPyBDUFVJTkZPX1pCQQo+IDogMDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW5mbyB8PSBwYWlyLnZhbHVlICYgUklTQ1ZfSFdQUk9CRV9FWFRfWkJCID8gQ1BVSU5GT19aQkIK
PiA6IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZm8gfD0gcGFpci52YWx1ZSAmIFJJ
U0NWX0hXUFJPQkVfRVhUX1pCUyA/IENQVUlORk9fWkJTCj4gOiAwOwo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGxlZnQgJj0gfihDUFVJTkZPX1pCQSB8IENQVUlORk9fWkJCIHwgQ1BVSU5GT19a
QlMpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZm8gfD0gcGFpci52YWx1ZSAmIFJJU0NW
X0hXUFJPQkVfRVhUX1pCS0IgPwo+IENQVUlORk9fWkJLQiA6IDA7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbGVmdCAmPSB+KENQVUlORk9fWkJBIHwgQ1BVSU5GT19aQkIgfCBDUFVJTkZPX1pC
UyB8Cj4gQ1BVSU5GT19aQktCKTsKPiDCoCNpZmRlZiBSSVNDVl9IV1BST0JFX0VYVF9aSUNPTkQK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5mbyB8PSBwYWlyLnZhbHVlICYgUklTQ1ZfSFdQ
Uk9CRV9FWFRfWklDT05EID8KPiBDUFVJTkZPX1pJQ09ORCA6IDA7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGxlZnQgJj0gfkNQVUlORk9fWklDT05EOwo+IEBAIC0xMzEsNiArMTM1LDE1IEBA
IHVuc2lnbmVkIF9fYXR0cmlidXRlX18oKGNvbnN0cnVjdG9yKSkKPiBjcHVpbmZvX2luaXQodm9p
ZCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGVmdCAmPSB+Q1BVSU5GT19aQlM7Cj4gwqDC
oMKgwqDCoMKgwqDCoCB9Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqAgaWYgKGxlZnQgJiBDUFVJTkZP
X1pCS0IpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBQcm9iZSBmb3IgWmJrYjogYnJl
djggemVybyx6ZXJvLiAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdF9zaWdpbGwgPSAw
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFzbSB2b2xhdGlsZSgiLmluc24gaSAweDEzLCA1
LCB6ZXJvLCB6ZXJvLCAweDY4NyIKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDogOiA6ICJtZW1vcnkiKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpbmZvIHw9IGdvdF9zaWdpbGwgPyAwIDogQ1BVSU5GT19aQktCOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGxlZnQgJj0gfkNQVUlORk9fWkJLQjsKPiArwqDCoMKgwqDCoMKgwqAgfQo+ICsK
PiDCoMKgwqDCoMKgwqDCoMKgIGlmIChsZWZ0ICYgQ1BVSU5GT19aSUNPTkQpIHsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLyogUHJvYmUgZm9yIFppY29uZDogY3plcm8uZXF6IHplcm8semVy
byx6ZXJvLiAqLwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3Rfc2lnaWxsID0gMDsK


