Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A55C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrRs-0000M4-Uj; Tue, 11 Aug 2026 14:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtrRk-0000Kc-98; Tue, 11 Aug 2026 14:43:32 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtrRa-0004gX-Q4; Tue, 11 Aug 2026 14:43:27 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 806AA1400141;
 Tue, 11 Aug 2026 14:43:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 14:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786473798; x=1786560198; bh=J8fvy3b5lp8tSQSP+QDB595S/dF9T5JY
 Myf21+duSEw=; b=qP0AsrRj8ve0Ha2PjBngy5lNcaT+JUS74+y0cvRLHsJMwEWo
 phmbRvl966z73fcQCVU63EHSDf4jLBv8dOZ8jfdPdu20Ei1vtejwiNJcv81DHgnw
 215rHYezEcl2NxHEv6v8bk3saJ6KcDl3gLQLO9ym3SZC1n8a8eWcG28Y8LXGsLDE
 9/umJ2xJHHfsKbtWkNKUW8HTS9PnJ5YZ7ZG6yiDLs/4XY7wKCX83r/OLeke3MVEJ
 RQlHkPi64Unxzfwfwlorj7+FeDkXaaZS92Dh5XyHHk3Zx36P3GSfgizRfAMx60kg
 +t5NbjMy/L+FnAvWr5f7czO88claegMqzOGuDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786473798; x=
 1786560198; bh=J8fvy3b5lp8tSQSP+QDB595S/dF9T5JYMyf21+duSEw=; b=a
 v+lVMLlkGyXoaaytAsb8FD/esS6QaAMUUhG1Ky2W+9YZypiuj7klww1ZmfZdxW9m
 gv8gp7CKcE7bhCWzaSxczNEjg+YxIx/IV8aSVU5vlXChdHryxIj5zGs5KB3H9eMD
 p27P40lD6CqKBIh8E60zLaCOI3hbkoPHn18bytkLoQeuqy1BTlmcUexCkUa5lqYM
 tT1rsQoOHDbaN3Bc3IF84yTIHEFTSJISQQGhNoCwoBgMN5+lurWVgh7gxw5NKEUw
 P5QaG3qmiL/2xbU530VBATmJn/DRZwBfmk/colEHV4rNaUMoLlJh2z4K0OXqYt4F
 9XwwLPCgKrw3TCRL7VPYw==
X-ME-Sender: <xms:RW17ajNksQOIkOSR1BFtyJRatjbFreEO7PMWXG0o3dxFg-e4pI4Kzg>
 <xme:RW17ati6ryn_djk3AbbrcoGIMJyI2tveFtW7ZfvJf3h4ynVBUStZeCa9rPgPQ6fOZ
 LQ59RYluPsNK0qqcd5Rtt00rYoLJt4A_3BTTR4V0XrZ0zP3qjdMUrI>
X-ME-Received: <xmr:RW17amkxTBOq0ANRtcPhaz-m1hEYz6kcCiZvQ2St_ELZe5zqrYMCrjS9Wm-Np-3pe6uZbQ>
X-ME-Proxy-Cause: dmFkZTECG1O1GiOkiUxFN4eSNvfwv2Gn5xqCLwowpgpRKlsyMU5aSZPWxB2POXZazEr5GM
 IVEdJPiCHXt/j/jF5Pkt4FLOCd50wWxb022r+DKHGvvb7vE3qqGjSlolqIu4HBWi7xGsKq
 6R7UHr73gANIQmeRkFrTZf52ch5i/owFlzx7X+f53s5eVxC5zCJVoiAfn0b1ZZkCHjv3Ji
 4ExNxZ7MVw0by0x6XjX/ZlEFbmDxUKETbrQcUc5Gq8XehyTiX2rHNTyaAXTdGwRa5LLXCQ
 EMpVrgte++jbVWVVU4cbxIE7QpPCf+Sj5pcM4sg52vqD4dZj4xKkchSSWYGKbhdM196yDq
 8nMbE+pgGYBso++5V4BciT8rmmAyfCLnskVXcVQ2uaxPaRXOwrGGoi/ygCtIWCKnyXU+yd
 L+NXR3QMeVi1t4jMw+Qi+7cvDAzrX6qVLAgAffFczxiBY8p8oeK4IXZD/rhEFmiXO9joB+
 gTDfd2obrncUWShGjZNuYLLaHv5Ospw0PHT1CcUJhjVD2IgdSuPn1QxEI8TqBQOJix5uFH
 gjTmhpP35j/h6CDsC04KGMrHc9XQlsIo9sbnhUVF/qGWtFAKVplWJWy+EdWw9nJRvTjVY5
 ybyGHqb35IZ3tBrvusp2mFewVBpBoBdEl5NIXGHr/Y2C9ZeQauIsMdGyoSTQ
X-ME-Proxy: <xmx:RW17aqPfgYegOaJD-VMnsP7hmlPAIap7wHOK5Fkp8F7yiWdWmDwYng>
 <xmx:RW17apE7OCgquASlAOEc9g2NrwWhLMyIq6FMtgxKOVXg4D-0MrA-nQ>
 <xmx:RW17aou3VtSz9P8d3uufzawJA_vU2p4yRwZPpJAjeaNsfUFuZaMC0g>
 <xmx:RW17ahSovbxazj9nfAhiw0cKfx_FXK7hCYGzB0KCd_ZaC9Kb04XeAg>
 <xmx:Rm17auxFXumay2Xl2rE3YD7Bo8IMGh7v06n6QXMrHNLc74iXxTTbBgVH>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 14:43:17 -0400 (EDT)
Message-ID: <045eaf3ae1a6b1feb7540c76fb0af954f402eac8.camel@alistair23.me>
Subject: Re: [PATCH v3 0/7] K230: add gsdma and decomp_gzip
From: Alistair <alistair@alistair23.me>
To: Tao Ding <dingtao0430@163.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, 	zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, 	lvivier@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, caojunze424@gmail.com
Date: Wed, 12 Aug 2026 04:43:15 +1000
In-Reply-To: <20260808062227.66961-1-dingtao0430@163.com>
References: <20260808062227.66961-1-dingtao0430@163.com>
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

T24gU2F0LCAyMDI2LTA4LTA4IGF0IDE0OjIyICswODAwLCBUYW8gRGluZyB3cm90ZToKPiBIaSBh
bGwsCj4gCj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBHU0RNQSBhbmQgRGVjb21wX2d6aXAgdG8g
dGhlIEsyMzAgYm9hcmQuCj4gRW5hYmxlIGsyMzAgdG8gdXNlIGsyMzBfdW56aXAgdG8gZGVjb21w
cmVzcyBmaWxlcyBkdXJpbmcgdGhlIHUtYm9vdAo+IHBoYXNlLgo+IAo+IFRoaXMgc2VyaWVzIGlu
Y2x1ZGVzIHRoZSBmb2xsb3dpbmcgZmVhdHVyZXM6Cj4gCj4gKnBhdGNoMTogYWRkIEsyMzAgZ3Nk
bWEgd2hpY2ggc3VwcG9ydHMgc2RtYSwgZ2RtYSBpcyB0ZW1wb3JhcmlseSBub3QKPiBzdXBwb3J0
ZWQKPiAqcGF0Y2gyOiBhZGQgZ3NkbWEgdG8gSzIzMCBib2FyZAo+ICpwYXRjaDM6IGFkZCBLMjMw
IGdzZG1hIHF0ZXN0Cj4gKnBhdGNoNDogYWRkIEsyMzAgZGVjb21wX2d6aXAgd2hpY2ggZGVjb21w
cmVzcyBkYXRhIHdvcmsgd2l0aCBzZG1hCj4gKnBhdGNoNTogYWRkIGRlY29tcF9nemlwIHRvIEsy
MzAgYm9hcmQKPiAqcGF0Y2g2OiBhZGQgSzIzMCBkZWNvbXBfZ3ppcCBxdGVzdAo+ICpwYXRjaDc6
IGFkZCBhIG5vYy1zdHViIHJlZ2lvbiBpbiBLMjMwIGJvYXJkCj4gCj4gUGF0Y2gtdjIgaXMgcG9z
dGVkIGluOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA3MjcxNTU3
MDIuMzY0ODQtMS1kaW5ndGFvMDQzMEAxNjMuY29tLwo+IAo+IENoYW5nZXMgaW4gdjM6Cj4gKnBh
dGNoMTogCj4gwqAgUmVtb3ZlZCB0ZW1wb3JhcmlseSB1bmltcGxlbWVudGVkIEdETUEgcmVnaXN0
ZXIgcmVhZCBhbmQgd3JpdGUuCj4gwqAgUHJpbnQgd2l0aCBxZW11X2xvZ19tYXNrIGZvciBhY2Nl
c3MgcmVnaXN0ZXIgZXJyb3JzLgo+ICpwYXRjaDQ6Cj4gwqAgUHJpbnQgd2l0aCBxZW11X2xvZ19t
YXNrIGZvciBoYW5kbGUgZXJyb3IgYWNrIHNpZ25hbC4KPiAKPiBUYW8gRGluZyAoNyk6Cj4gwqAg
aHcvZG1hOiBhZGQgSzIzMCBnc2RtYQo+IMKgIGh3L3Jpc2N2OiBrMjMwOiBhZGQgZ3NkbWEgaW4g
SzIzMCBib2FyZAo+IMKgIHRlc3RzL3F0ZXN0OiBhZGQgdGVzdCBmb3IgSzIzMCBnc2RtYQo+IMKg
IGh3L21pc2M6IGFkZCBLMjMwIGRlY29tcCBnemlwCj4gwqAgaHcvcmlzY3Y6IGsyMzA6IGFkZCBk
ZWNvbXAgZ3ppcCBpbiBLMjMwIGJvYXJkCj4gwqAgdGVzdHMvcXRlc3Q6IGFkZCB0ZXN0IGZvciBL
MjMwIGRlY29tcCBnemlwCj4gwqAgaHcvcmlzY3Y6IGsyMzA6IGFkZCBhIG5vYyBzdHViIHJlZ2lv
biBpbiBLMjMwIGJvYXJkCgpUaGFua3MhCgpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQK
CkFsaXN0YWlyCgo+IAo+IMKgTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArCj4gwqBkb2NzL3N5c3RlbS9yaXNjdi9rMjMw
LnJzdMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICsKPiDCoGh3L2RtYS9LY29uZmlnwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMgKwo+IMKgaHcvZG1h
L2syMzBfZ3NkbWEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNTUxCj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKgaHcvZG1hL21lc29uLmJ1aWxkwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsKPiDCoGh3L2RtYS90cmFjZS1ldmVu
dHPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICsKPiDCoGh3L21pc2Mv
S2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyAr
Cj4gwqBody9taXNjL2syMzBfZGVjb21wX2d6aXAuY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDUxMSAr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKgaHcvbWlzYy9tZXNvbi5idWlsZMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgaHcvbWlzYy90cmFjZS1ldmVu
dHPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNCArCj4gwqBody9yaXNjdi9L
Y29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArCj4g
wqBody9yaXNjdi9rMjMwLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAzOCArLQo+IMKgaW5jbHVkZS9ody9kbWEvazIzMF9nc2RtYS5owqDCoMKgwqDCoMKgwqDC
oCB8IDEzMCArKysrKysrCj4gwqBpbmNsdWRlL2h3L21pc2MvazIzMF9kZWNvbXBfZ3ppcC5owqAg
fMKgIDkyICsrKysrCj4gwqBpbmNsdWRlL2h3L3Jpc2N2L2syMzAuaMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCA1ICsKPiDCoHRlc3RzL3F0ZXN0L2syMzAtZGVjb21wLWd6aXAtdGVzdC5j
IHwgMjAwICsrKysrKysrKysKPiDCoHRlc3RzL3F0ZXN0L2syMzAtZ3NkbWEtdGVzdC5jwqDCoMKg
wqDCoMKgIHwgMjAxICsrKysrKysrKysKPiDCoHRlc3RzL3F0ZXN0L21lc29uLmJ1aWxkwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKy0KPiDCoDE4IGZpbGVzIGNoYW5nZWQsIDE3NTAg
aW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBody9k
bWEvazIzMF9nc2RtYS5jCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvbWlzYy9rMjMwX2RlY29t
cF9nemlwLmMKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L2RtYS9rMjMwX2dzZG1h
LmgKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2MvazIzMF9kZWNvbXBfZ3pp
cC5oCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvazIzMC1kZWNvbXAtZ3ppcC10
ZXN0LmMKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9rMjMwLWdzZG1hLXRlc3Qu
Ywo+IAo+IAo+IGJhc2UtY29tbWl0OiAzMDA0MzhmZmJiOGQ5NDMwY2FjMmZjYzE1Y2JhNmY0ODJi
MmMwNTg3Cg==


