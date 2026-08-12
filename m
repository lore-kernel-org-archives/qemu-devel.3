Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCB7C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAme-0004gm-RJ; Wed, 12 Aug 2026 11:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAmY-0004TD-NY; Wed, 12 Aug 2026 11:22:18 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAmX-0000dJ-0V; Wed, 12 Aug 2026 11:22:18 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 44F66EC0253;
 Wed, 12 Aug 2026 11:22:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 11:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786548135; x=1786634535; bh=Bf6ruqCSqK+C+lYC+rb4LR9Kze0ANZL0
 4zA+Zc62UhQ=; b=QwastEhC6L4iWV5oJzIhGaAQBHfHAr9JX6mjD7/Ff2IUMzzu
 1eP+IyE8+yb5+XCssLFMRrOrLWmuVOHvfkZVKbmDJ/h2RLtFaPFTOfPw43pexBMg
 7FjbHI5Di3vuiPWoXZOAC+pk60SvzjPsDokIPa745jRfzM3kw61ANuw7V6uj8mGT
 BE7Pe0EmTq37AdV8A7gO3lswGQJ2P4qZ+SYl0yKn9Z3seR31Mcid+RWuWjZimzeg
 eiC52h/ZnzccSgf9z1MsHlktS2Q90nwEy6KcL+2sHxHr6QKaXghrXYCpDGCrbAzz
 4XpzttPWZHT4Cdkc/hcHIZm+lqZNzdVxifcnaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786548135; x=
 1786634535; bh=Bf6ruqCSqK+C+lYC+rb4LR9Kze0ANZL04zA+Zc62UhQ=; b=P
 zDQZi2o2dz/fMF7o6Y+60H/R83w8hlWynvfUlSRPiimc4bd8+Wcn7Z/upHXfXkYd
 Gpvk+KC6Xf9nU2AFEnjvwMIrQSlG/YP00HySCn/VqCLJMsAF7nPswLX0q9SKueMT
 MR2BN7z6VbLw9Xrl8FxSckCGoMnCX5Nu85H9qXgsCryoBQ4q9K7QDwRdo5Qo51st
 aGJpxPbIU0xr5dabY+mZniP0NdI2BkUIHoWzkm9EfdGfTcKATkJ3ogQdEOH75477
 bOA2Z7NxHaURE+6bqLtcYmQidNri9MiTZ/WdJJPq0E49mq9GMdKygAHpFH2aeU0R
 sjTCbo0IqxSjwrsNjzPXQ==
X-ME-Sender: <xms:po98anXn_pc_HrPNe3t0Sg3eda8a8IToHwZw6fXf6miY1HSpwxts7Q>
 <xme:po98at0w0PP6-D5_8BYFhc4DFUI79nVFAadxkxDOY3eyr-7_OD_VN5JuipkZ3cSnB
 I60im_EAC2UGMmFY2ULnCEGUCXMO50OEBg6Y3BNKOQV9vjshKrSAxEq>
X-ME-Received: <xmr:po98asuflYQ1mOYIiLxOAiSeNm_qs4RoQe3DM4oCAANwC1tsSIS2YN84sdnDlb6YyXfS4w>
X-ME-Proxy-Cause: dmFkZTEcUVOi0bk1aRsvdSnXTqKAa3QBlko0iwctZrGHTeWS4rL9dDelty8i8D6lBffumr
 NemaF9sQfxZr9RSXZc2hcvjJYRw6ZUfJk2q7LYaHvHRkEOY3um+0UJxEQtLwECK22MlEAr
 oYhs0HaSLRNQawAdjT60PGLn38OK4FG/NQdD+pqUfXsenHXgO2YRFjJffo35X6xS27W1rn
 13P7wJWuynYQwZN3r56GpVD2owI9e3ANd8fpPC8zEfEJxxdow0xM2vrubUgm9kou76yPbn
 TBds7vH/+vMj2PAnRAm6H88/RRcJhIkJwlC56+pf/AggZ/Vj/Vt/Zh4Dznx9Q6J04zzQSq
 Kc8/P3yvVr7W9PBdpsCIj8rXVfvAHGhkRKLM3ofIyaHU4gmS2gLz2ySHm2F87/8aUhvmSK
 QRkUrqGBA6BuNqlyoOMFzax+xq5+bjynoWfLiR+vFkADbwVxbKT5PmIsw+iSSjlR8/xuWj
 M31oZaRbTG13tK81ltsE/xsggi+KN6SeQYNZnTibRXtdfCcRRWmK7bsW0cydy2NrNHlhHu
 A0VmuMTz50qAPERs1QUHWU1qrLvUK8/WDcWkTLD6y+/x1AlT+fOAGA3N4HTvmJYH50YOCG
 5xkLlrWxHnYhldjAS5WwCz3l0DLw5n1LEGRsHErtyreyMTafSo8/xZyAkvjA
X-ME-Proxy: <xmx:po98alU-TjGF889-_fQVUdPJKpyYrf2TEHP0Hni4MzxTw5Op81pYtw>
 <xmx:po98akwDeEa4UA0t0QmS4tp0I8cRj6d3zFnoJOkQzXw1ywW4kjndsA>
 <xmx:po98akEaUYPGpjFLVKrNcDTfnzVwbbg2L0ZIrWivaQYngTLZIG-cew>
 <xmx:po98ahvNWyEFsnSbHZccgYgSIh8y8GWk_Y6odJzk2MeJ2C4_eHnupg>
 <xmx:p498apM-PaB3xXv7VzQkhUFUfbauYZ46Qe77Rad8tJDFUxLT2zMGA5bl>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 11:22:13 -0400 (EDT)
Message-ID: <0cf11d25bd390dc0fa2f7b55a8f7515869706739.camel@alistair23.me>
Subject: Re: [PATCH 01/26] hw/riscv: pfsoc: Correct the L2LIM maximum mapped
 size
From: Alistair <alistair@alistair23.me>
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, Chao Liu	
 <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>, Daniel
 Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt	 <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,  Weiwei Li
 <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Date: Thu, 13 Aug 2026 01:22:13 +1000
In-Reply-To: <20260723151853.2143177-2-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-2-bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.151;
 envelope-from=alistair@alistair23.me; helo=fout-a8-smtp.messagingengine.com
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

T24gVGh1LCAyMDI2LTA3LTIzIGF0IDIzOjE4ICswODAwLCBCaW4gTWVuZyB3cm90ZToKPiBQb2xh
ckZpcmUgU29DIGhhcyBhIDJNaUIgTDIgY2FjaGUsIHNvIHRoZSBtYXhpbXVtIG1hcHBlZCBzaXpl
IG9mCj4gTDJMSU0gc2hvdWxkIGJlIHNldCB0byAyTWlCIHRvby4KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBCaW4gTWVuZyA8YmluLm1lbmdAcHJvY2Vzc21pc3Npb24uY29tPgoKQWNrZWQtYnk6IEFsaXN0
YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+
IAo+IMKgaHcvcmlzY3YvbWljcm9jaGlwX3Bmc29jLmMgfCAyICstCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaHcvcmlz
Y3YvbWljcm9jaGlwX3Bmc29jLmMgYi9ody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuYwo+IGluZGV4
IDQwMTcxMjljODMuLjIxOGNjY2FiNjkgMTAwNjQ0Cj4gLS0tIGEvaHcvcmlzY3YvbWljcm9jaGlw
X3Bmc29jLmMKPiArKysgYi9ody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuYwo+IEBAIC05Niw3ICs5
Niw3IEBAIHN0YXRpYyBjb25zdCBNZW1NYXBFbnRyeSBtaWNyb2NoaXBfcGZzb2NfbWVtbWFwW10g
PQo+IHsKPiDCoMKgwqDCoCBbTUlDUk9DSElQX1BGU09DX0NMSU5UXSA9wqDCoMKgwqDCoMKgwqDC
oMKgwqAge8KgIDB4MjAwMDAwMCzCoMKgwqDCoMKgIDB4MTAwMDAKPiB9LAo+IMKgwqDCoMKgIFtN
SUNST0NISVBfUEZTT0NfTDJDQ10gPcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAge8KgIDB4MjAxMDAw
MCzCoMKgwqDCoMKgwqAgMHgxMDAwCj4gfSwKPiDCoMKgwqDCoCBbTUlDUk9DSElQX1BGU09DX0RN
QV0gPcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7wqAgMHgzMDAwMDAwLMKgwqDCoMKgIDB4MTAw
MDAwCj4gfSwKPiAtwqDCoMKgIFtNSUNST0NISVBfUEZTT0NfTDJMSU1dID3CoMKgwqDCoMKgwqDC
oMKgwqDCoCB7wqAgMHg4MDAwMDAwLMKgwqDCoCAweDIwMDAwMDAKPiB9LAo+ICvCoMKgwqAgW01J
Q1JPQ0hJUF9QRlNPQ19MMkxJTV0gPcKgwqDCoMKgwqDCoMKgwqDCoMKgIHvCoCAweDgwMDAwMDAs
wqDCoMKgwqAgMHgyMDAwMDAKPiB9LAo+IMKgwqDCoMKgIFtNSUNST0NISVBfUEZTT0NfUExJQ10g
PcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAge8KgIDB4YzAwMDAwMCzCoMKgwqAgMHg0MDAwMDAwCj4g
fSwKPiDCoMKgwqDCoCBbTUlDUk9DSElQX1BGU09DX01NVUFSVDBdID3CoMKgwqDCoMKgwqDCoMKg
IHsgMHgyMDAwMDAwMCzCoMKgwqDCoMKgwqAgMHgxMDAwCj4gfSwKPiDCoMKgwqDCoCBbTUlDUk9D
SElQX1BGU09DX1dET0cwXSA9wqDCoMKgwqDCoMKgwqDCoMKgwqAgeyAweDIwMDAxMDAwLMKgwqDC
oMKgwqDCoCAweDEwMDAKPiB9LAo=


