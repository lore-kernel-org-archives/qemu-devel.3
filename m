Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D82C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtt0m-0003Tb-Pr; Tue, 11 Aug 2026 16:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt0l-0003Sx-0r; Tue, 11 Aug 2026 16:23:47 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt0j-0004Eo-FA; Tue, 11 Aug 2026 16:23:46 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id BB2E7EC01DE;
 Tue, 11 Aug 2026 16:23:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 16:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479824; x=1786566224; bh=dwlPoLdkCNgiR198seO/0bB8MJG67pTf
 gx5VvwHGHHY=; b=rqAdMSMWW5dDeahc4Ro4sr85Yi/BTRTl+qK31z+7QCgVz+dl
 udOq56hho08z90Dau+7x/5fRKcO8CRUvgGfxVLuzvX27/7PTzMQycnr1l6rQi93q
 F+EJj0WNAWgFUzDkyhaiMf627IgajpCOhkc9lyIuI2/4iY2mQN31gjK+hUk4Wrzd
 qPsGWPyUSxhsp6HdaBoD/JUlw7eFhT4GLxf31zMvauaoNP1aARh27zziQWSfajK+
 OQ20rsJ9g/OFTRGHDOm5Nm/N9B2umpGjeJJt23yBOk1OjydhwFpXQthJXlDvyLQl
 Cgh9PUGiuK5RA23QmGCtG664ZXh7XQSDPZ5K+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479824; x=
 1786566224; bh=dwlPoLdkCNgiR198seO/0bB8MJG67pTfgx5VvwHGHHY=; b=h
 eS790MhmURgudn4Jenk5/jkB4Ui1SHoTv2WTbgGnt4kWSQDKNqrt2Wur/pVJHwfY
 6+5txMZcL4ka+Mpt+PINSd2ekqkhF6WR5GsAf3ove13j3iuoWBKo7jzeV8lYxLHA
 fmbppdAQVIxwkC0d+hWQeCSRA6nbLjCLkTLsd5z8EKM4WYHQdIS3TDpOS8L7OtOP
 MoFtLfoffEYM6wGvFXQ1XNWnpy08zQ0fyj6UnOd/LVfoqmmge82xtNzqexQCGTof
 hYR/c3Psl4agHIM+0tTGmpMNAZf4JNgAlP8Lissy08PAl6fHSWhQn/KB4Pj3RGnf
 9JBSI08XHX2pCg6hPTgpg==
X-ME-Sender: <xms:0IR7ahvmQJmKIg83VprypmfoVTh9Y6PT3h10V9uEfH-A1TXe-Zg1Fg>
 <xme:0IR7auwm2rdMG2NDpzTytpOXIvgcc7An4aIht8ZRZu1xAfuV1pdlyKT4JrN-2oK26
 9l0EzRE5tX-uXdDTcaHHGHeY-OBqhaXX8NJxApigQPIuGNr3_xmFCg>
X-ME-Received: <xmr:0IR7aj5N_6ualCN2l8zEkcciagf_19tN13ufR_VkNoDtgg6Xmj_M87vc92-o320ymj77Ag>
X-ME-Proxy-Cause: dmFkZTGFUpSS2GT1z7DHoWv8NCM7+16aVte8EPcTOexXdW4G8RGpvTIDkkb9QH/6b3lrEi
 1QfIZs+N3MbyOFqV8mRj8GKZrEOXVeiF+EFez4pVjLgnRU9i+JfRj3PTXYYbmI5N2UMtHV
 K2j88n1elLZIEH7515+VW5iiht/TNZB1dGxKz6HzYBQCgC2eOodtqOJdSpZNqeALwZqEuI
 DFqpAvMiJtrOwf7l1T1ujDu4b5y0MFoi9u9/JAb7eppzTrOWqRV1Eielyobcy6YkxQ5D6V
 mYp08JdTcFEtTlaUcpcdcO6LKBUhXgLUvkDF8vn8Oz+1Wx0Q/AlGDibx/qsu8xqDLhn5QZ
 nnyML7Lfgen2GlR7QGu3L77w/+qxcv8orGU5cN9sXcrp9fYpsJ9MS7/MA11XbTY0+Z7KR6
 tAMEFxJCKf4toFqi6+jxCUTTakfGd466cAc582KBFW7eo+jUcpsHL9td6He0y7aH3WA0Mo
 hN3K4RbziLCASNtJVC6krdV4ovFziHsmTn0YuwaBsk6TWbBOUFTEasL8e3wwFiHKzj3dFH
 mKVNtZp8KhTL2CNJnOw44epq2sri5X7St2DIA0hx62qleh04kl2Yd2FeLfTBu/yoaaUBuY
 LU6E+s08QnN6RGmld4tt7ZcBNzpuDKcL//hVCDGbMerVo7oFT3WxDrI5xYIQ
X-ME-Proxy: <xmx:0IR7agWPE0bBprRq9_vyseECWjZz1HK5sqRMtD9i_c9wNErdrMJvKg>
 <xmx:0IR7an1r7MtmDOYKetDXidys_ANdBDmMb218-AdRO3lCqvih4fkNFQ>
 <xmx:0IR7at2VQqI4KPsBdyz4iTOLGBnRLZRQE51j7eLADLkhT0nSrmVEfw>
 <xmx:0IR7aq_YGyGb1KGUoTXO6mNi9EaJcPcIMIrVfWunpk4-FgDDmnJSDg>
 <xmx:0IR7apwPLoJ7UBfCrfHsfXOSlSKcQq6uqp1K7SmlCuB5S5-pLWxm4bFr>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:23:44 -0400 (EDT)
Message-ID: <271642bc639d731b11ab9819d8b9da29ed27bd64.camel@alistair23.me>
Subject: Re: [PATCH 31/56] disas/riscv: Allow decode_inst_lift_pseudo to loop
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:23:44 +1000
In-Reply-To: <20260809223545.730664-32-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-32-richard.henderson@linaro.org>
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
ZToKPiBBbGxvdyBwc2V1ZG8gZXhwYW5zaW9uIHRvIHByb2NlZWQgaW4gbXVsdGlwbGUgc3RlcHMu
Cj4gQXNzZXJ0IHRoYXQgd2UgZG9uJ3QgaGF2ZSBzaW1wbGUgbG9vcHMuCj4gCj4gU2lnbmVkLW9m
Zi1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+CgpS
ZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoK
QWxpc3RhaXIKCj4gLS0tCj4gwqBkaXNhcy9yaXNjdi5jIHwgNiArKystLS0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2Rpc2FzL3Jpc2N2LmMgYi9kaXNhcy9yaXNjdi5jCj4gaW5kZXggZmU1MDNiNmNhZS4uYjhlNWIx
MjRhNSAxMDA2NDQKPiAtLS0gYS9kaXNhcy9yaXNjdi5jCj4gKysrIGIvZGlzYXMvcmlzY3YuYwo+
IEBAIC01MjU5LDkgKzUyNTksOSBAQCBzdGF0aWMgY29uc3QgcnZfb3Bjb2RlX2RhdGEKPiAqZGVj
b2RlX2luc3RfbGlmdF9wc2V1ZG8ocnZfZGVjb2RlICpkZWMsCj4gwqDCoMKgwqAgaWYgKGNvbXBf
ZGF0YSkgewo+IMKgwqDCoMKgwqDCoMKgwqAgd2hpbGUgKGNvbXBfZGF0YS0+Y29uc3RyYWludHMp
IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGNoZWNrX2NvbnN0cmFpbnRzKGRlYywg
Y29tcF9kYXRhLT5jb25zdHJhaW50cykpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRlYy0+b3AgPSBjb21wX2RhdGEtPm9wOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgb3AgPSAmZGVjLT5vcGNvZGVfZGF0YVtkZWMtPm9wXTsKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y29uc3QgcnZfb3Bjb2RlX2RhdGEgKm5ld19vcCA9ICZkZWMtCj4gPm9wY29kZV9kYXRhW2NvbXBf
ZGF0YS0+b3BdOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXNzZXJ0KG5ld19v
cCAhPSBvcCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZGVjb2Rl
X2luc3RfbGlmdF9wc2V1ZG8oZGVjLCBuZXdfb3ApOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBfZGF0YSsrOwo+IMKgwqDCoMKgwqDC
oMKgwqAgfQo=


