Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F083606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=YXSpDKTh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=t5slANs0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQz0I-0006tf-0R; Tue, 10 Nov 2026 22:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQz0G-0006tH-7k
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:28:04 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQz0E-0007k4-FA
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:28:03 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id C1FE71D0020E
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:28:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 10 Nov 2026 22:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1794367681; x=1794454081; bh=gcPFdhgesZ5uIjminkvcuQHimxQmSbZs
 heSdqzjyzyA=; b=YXSpDKThSgNXqbEwdoj/o+sO/xoUtF0vySE9XJtU+oj6Ndfo
 mYjYRazFLbSVpO6AK10HE5H0DM/JA9Li+LhRr0XWWOnYIu4Q0fUaTfEj7HFEAprq
 EK5WuUu3G9cib7wf5xYKpe2JoUiOX7LzT660P4pft9OhSmRnbiM5WMzM2Mcv87bm
 jgcZ5h+nMGAlKi0v9sET6289/S7fvu3OxngCvKb2erYyEYUpsAE/Ww1frXcAhMu4
 6tLIl53eQwsXKDZahmePEMMVonZh6KH7tu9muc3pA/nwUv6lFJLO6klA7Yw7tvBM
 2lHly6j35UimFbYjN+64YAQeG0Xy3SrxEpEhZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794367681; x=
 1794454081; bh=gcPFdhgesZ5uIjminkvcuQHimxQmSbZsheSdqzjyzyA=; b=t
 5slANs0N8VBxaF0VPNJZVWuZCmNIz5e7ns1MeubcCSsQ3O0Y+MZOWnC071X7QVR8
 GxTQccznXrWhDNmp1dTy0wFp3KcxCr9Y1fmkiJh+caJIbCFnR/dLgpeQmg5+gvDa
 zx+5XLRmPUh5pQP99ivdDGj9FdQkKMroGHdS1D8KboHMlL6RQaAoBI+SV1fK5F6W
 72nsbDpqN4KOq6K4BJBfRmeGGsjOQYfT5V6EplXGs0AldOp8ND3WwSTCQcxzkMv8
 GNi8lbZVWzvi0AdnfxTYFWGFHEh+YR3HhHJhZXS0w0XF9g6poaFnEqby0oCgV9uf
 ZNpt7nHuVoVBfUT0xsWkg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794367681; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:BbV3LgX2CoJG5WKjwBeB+r9c0DRzFN8qDrJ2NygNA1ePuQ5
 wKAQz670pqdhS/2P/5+Kkk4GlSdhuYv7WRZiABUZT1sPKYVvsY5+AiKSfscejAlp
 l1XpvlE/QvMZFwE/WPGNytnX4ECxFMgCvVYaBFAl3epkPeoe4ZBHNOS/EnaQnvVf
 UC7LeXfGRpmEJ1JJkj/IAT40Zxi0ExlXws0RYukjShsoQhPuQaZ4C5DRa/o1iQxA
 dZvGif//eremS1N0WrXhJuQ37OyvZ+TT5hG3uNT2mgNLnFuQCCSmkAC7+8qkFNow
 6bpx5GaEOCYMYvwjrxGSeHDdihMUel5EcIF4fBw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:dJ+oI41nkCjgz4EgB505SiZUkarzrYf9OivRavGbocs=:gcPFdhgesZ5uIjminkvcuQHimxQmSbZsheSdqzjyzyA=;
X-ME-Sender: <xms:weDzaseHeUFm1XG8DIdnY25m_QFYr0dv8lGnkmL99_sueQpmzZhS_A>
 <xme:weDzaoT5fCA1YeJaQXvV7vUZbOuZb50SuOHfhlppsuBRd1zads0EMyjfG0osVvx1n
 VE4Uz22OKhc3hHS0oIeiAXsS7gkXc8mDDm94hh7YSgLrgwmIP328oWa>
X-ME-Received: <xmr:weDzatYw7Q5mjdxf1ZJ_YEz4NcmfAxco1ebjtH2j2K-sDfIdkZ8cpkp5Qfuvsg8HqSC0y5demg1m14uRuYPCdyVtcmY>
X-ME-Proxy-Cause: dmFkZTFBkt/J4YtNrHnFLRyxUNThRN84jVH7K5jH5KIQ4VNXfO11cfMU3mbRqN1H5D1UIm
 eAADKU9B8Q4ETXIX6C4is/nPQM4ISJDQSN7oIxlOucPTEeszN3vJcF1wPK4KaS4YGsrE5p
 952cxVk4aSIzjnH8RrKzaTyIh/dvnYcg6peomeuzSQA8DmpBinT4geq1D+d6xwqAXO1zIj
 YlbdXtmiyhJa4Uud19jHJvV2kntT7KdqyYQ1aJPrBI2ARvmHfi8MIQTb630HqpTSo26lhf
 sdiEDngirCtFVYAxa0E79TB8ouoawSw6mR/X/AOsZiMhaHqmM8CPruLhNOjo2r5mBwNIWV
 Citlc1hkLo128CwAL7du165DU907lrqT0+my1xRfvwWSY6XAhpr76PK2whfs1QeGWykl2P
 kQ289hsKDCwmyZEGUykvhu6sZEtkGm0nhGJsWmJiVylA/fkh4M8MEY1c0uMFA6yrf3VUKw
 Ej7eHhkLfgycG83l2gd/VqqdV3LVTSu61qRjgh7RGFud2pNhaKhzfUjZ/4zO2CUiRNGhNG
 dtj/9jIX9TvnmlMVpIQ9Y8yeAtq8ehs2GftCiYT5rA1tOaEtdu5kN3X4z1il3oG8qwU/R5
 CnWa3hV9tCgrZFH8qywPd04XngHY/mP3A3mL31knboq02eprejnOv6MRaZbw
X-ME-Proxy: <xmx:weDzajcKj5yMJoeew5QYL6a4KcJhhk7QcPvSvq1g7KeTa5HEELCCbw>
 <xmx:weDzamKBVdzDWUvbm2MwsEcLiMt6oxfGCByp88R3S9Z0rtrknn-fzg>
 <xmx:weDzaoJA51nqJQ7F9dB6EyatCJw3ncM07rIbzzcHXxdfom_v-glV7Q>
 <xmx:weDzatXRgWfEOliy9PjKqn1RFODxwxg2NWyGYuUaD4mBbWINNgKpDw>
 <xmx:weDzahDe5ZVCPeFZ03NZHxkBMGHkkZtG121OHKe9lx59GowtJp2nRgJL>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 22:27:58 -0500 (EST)
Message-ID: <f875f21cec8e24090949b60c898e158605f59515.camel@alistair23.me>
Subject: Re: [PATCH 3/6] hw/dma/xilinx_axidma: Fix DMASR register handling
From: Alistair <alistair@alistair23.me>
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell	
 <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, "open
 list:Xilinx Zynq" <qemu-arm@nongnu.org>, Frank Chang
 <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Date: Wed, 11 Nov 2026 13:27:56 +1000
In-Reply-To: <20261015033733.35116-4-jay.chang@sifive.com>
References: <20261015033733.35116-1-jay.chang@sifive.com>
 <20261015033733.35116-4-jay.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.150;
 envelope-from=alistair@alistair23.me; helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDExOjM3ICswODAwLCBKYXkgQ2hhbmcgd3JvdGU6Cj4gVGhp
cyBwYXRjaCBmaXhlcyB0d28gcmVnaXN0ZXIgaGFuZGxpbmcgaXNzdWVzIGluIHRoZSBYaWxpbngg
QVhJIERNQQo+IGNvbnRyb2xsZXI6Cj4gCj4gMS4gRE1BQ1IgU3RhcnQgUHJvY2Vzc2luZyBMb2dp
YzoKPiDCoMKgIFdoZW4gdGhlIGd1ZXN0IHdyaXRlcyB0byBSX0RNQUNSIHRvIHN0YXJ0IERNQSBw
cm9jZXNzaW5nLCB0aGUKPiDCoMKgIG9yaWdpbmFsIGNvZGUgY2xlYXJlZCBib3RoIERNQVNSX0hB
TFRFRCBhbmQgRE1BU1JfSURMRSBmbGFncy4KPiDCoMKgIEhvd2V2ZXIsIERNQVNSX0lETEUgc2hv
dWxkIG9ubHkgYmUgY2xlYXJlZCB3aGVuIFRBSUxERVNDIGlzCj4gd3JpdHRlbgo+IMKgwqAgKGlu
ZGljYXRpbmcgYWN0dWFsIHdvcmsgaXMgcXVldWVkKS4gSW5jb3JyZWN0bHkgY2xlYXJpbmcgSURM
RSBvbgo+IMKgwqAgRE1BQ1Igd3JpdGUgY2FuIGNhdXNlIHRoZSBETUEgc3RhdGUgbWFjaGluZSB0
byBiZWhhdmUgaW5jb3JyZWN0bHkuCj4gCj4gMi4gRE1BU1IgVzFDIChXcml0ZS0xLXRvLUNsZWFy
KSBJUlEgQml0czoKPiDCoMKgIFRoZSBvcmlnaW5hbCBpbXBsZW1lbnRhdGlvbiBoYWQgaW5jb3Jy
ZWN0IFcxQyBsb2dpYzoKPiDCoMKgwqDCoMKgwqAgdmFsdWUgJj0gfih2YWx1ZSAmIERNQVNSX0lS
UV9NQVNLKTsKPiDCoMKgwqDCoMKgwqAgcy0+cmVnc1thZGRyXSA9IHZhbHVlOyAvLyB3cml0ZSBS
L08gYml0Cj4gCj4gwqDCoCBUaGlzIHdvdWxkIGNsZWFyIHRoZSBlbnRpcmUgcmVnaXN0ZXIgaW5z
dGVhZCBvZiBqdXN0IHRoZSBJUlEgYml0cy4KPiDCoMKgIFRoZSBjb3JyZWN0IFcxQyBpbXBsZW1l
bnRhdGlvbiBzaG91bGQgY2xlYXIgb25seSB0aGUgYml0cyB0aGF0IGFyZQo+IMKgwqAgYm90aCBz
ZXQgaW4gdGhlIHJlZ2lzdGVyIEFORCB3cml0dGVuIGFzIDEgYnkgdGhlIGd1ZXN0Ogo+IMKgwqDC
oMKgwqDCoCBzLT5yZWdzW2FkZHJdICY9IH4odmFsdWUgJiBETUFTUl9JUlFfTUFTSyk7Cj4gCj4g
My4gRW5oYW5jZWQgRXJyb3IgTG9nZ2luZzoKPiDCoMKgIEFkZGVkIHFlbXVfbG9nX21hc2soTE9H
X0dVRVNUX0VSUk9SKSB3aGVuIHRoZSBETUEgZW5naW5lCj4gZW5jb3VudGVycwo+IMKgwqAgYSBk
ZXNjcmlwdG9yIHRoYXQgaXMgYWxyZWFkeSBtYXJrZWQgQ09NUExFVEUuIFRoaXMgaW5kaWNhdGVz
IGEKPiBndWVzdAo+IMKgwqAgZHJpdmVyIGVycm9yIChyZXVzaW5nIGRlc2NyaXB0b3JzIHdpdGhv
dXQgcHJvcGVyIHJlc2V0KSBhbmQgaGVscHMKPiDCoMKgIGRlYnVnZ2luZyBuZXR3b3JrIGlzc3Vl
cy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKYXkgQ2hhbmcgPGpheS5jaGFuZ0BzaWZpdmUuY29tPgo+
IFJldmlld2VkLWJ5OiBGcmFuayBDaGFuZyA8ZnJhbmsuY2hhbmdAc2lmaXZlLmNvbT4KPiBSZXZp
ZXdlZC1ieTogSmltIFNodSA8amltLnNodUBzaWZpdmUuY29tPgoKQWNrZWQtYnk6IEFsaXN0YWly
IEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKg
aHcvZG1hL3hpbGlueF9heGlkbWEuYyB8IDExICsrKysrKystLS0tCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ody9k
bWEveGlsaW54X2F4aWRtYS5jIGIvaHcvZG1hL3hpbGlueF9heGlkbWEuYwo+IGluZGV4IDI4MmY5
Mjg2N2QuLjY4OTJkNDk0YzAgMTAwNjQ0Cj4gLS0tIGEvaHcvZG1hL3hpbGlueF9heGlkbWEuYwo+
ICsrKyBiL2h3L2RtYS94aWxpbnhfYXhpZG1hLmMKPiBAQCAtMzg1LDYgKzM4NSwxMCBAQCBzdGF0
aWMgc2l6ZV90IHN0cmVhbV9wcm9jZXNzX3MybWVtKHN0cnVjdCBTdHJlYW0KPiAqcywgdW5zaWdu
ZWQgY2hhciAqYnVmLAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAocy0+ZGVzYy5zdGF0dXMg
JiBTREVTQ19TVEFUVVNfQ09NUExFVEUpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+
cmVnc1tSX0RNQVNSXSB8PSBETUFTUl9IQUxURUQ7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJ4aWxpbnhfYXhpZG1hOiBIQUxUOiBjdXJkZXNj
PTB4JTAxNmx4Cj4gYWxyZWFkeSIKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgIiBDT01QTEVURSBzdGF0dXM9MHgleFxuIiwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHVuc2lnbmVkIGxvbmcp
Y3VyZGVzYywgcy0+ZGVzYy5zdGF0dXMpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVh
azsKPiDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoAo+IEBAIC01NTUsMTUgKzU1OSwxNCBAQCBzdGF0
aWMgdm9pZCBheGlkbWFfd3JpdGVsKFhpbGlueEFYSURNQSAqZCwKPiBzdHJ1Y3QgU3RyZWFtICpz
LCBod2FkZHIgYWRkciwKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKCh2YWx1ZSAmIDEpICYm
ICFzdHJlYW1fcmVzZXR0aW5nKHMpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFN0
YXJ0IHByb2Nlc3NpbmcuwqAgKi8KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5yZWdzW1Jf
RE1BU1JdICY9IH4oRE1BU1JfSEFMVEVEIHwgRE1BU1JfSURMRSk7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcy0+cmVnc1tSX0RNQVNSXSAmPSB+RE1BU1JfSEFMVEVEOwo+IMKgwqDCoMKgwqDC
oMKgwqAgfQo+IMKgwqDCoMKgwqDCoMKgwqAgc3RyZWFtX3JlbG9hZF9jb21wbGV0ZV9jbnQocyk7
Cj4gwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDCoAo+IMKgwqDCoMKgIGNhc2UgUl9ETUFTUjoK
PiAtwqDCoMKgwqDCoMKgwqAgLyogTWFzayBhd2F5IHdyaXRlIHRvIGNsZWFyIGlycSBsaW5lcy7C
oCAqLwo+IC3CoMKgwqDCoMKgwqDCoCB2YWx1ZSAmPSB+KHZhbHVlICYgRE1BU1JfSVJRX01BU0sp
Owo+IC3CoMKgwqDCoMKgwqDCoCBzLT5yZWdzW1JfRE1BU1JdID0gdmFsdWU7Cj4gK8KgwqDCoMKg
wqDCoMKgIC8qIENsZWFyIFcxQyBJUlEgYml0cy7CoCAqLwo+ICvCoMKgwqDCoMKgwqDCoCBzLT5y
ZWdzW1JfRE1BU1JdICY9IH4odmFsdWUgJiBETUFTUl9JUlFfTUFTSyk7Cj4gwqDCoMKgwqDCoMKg
wqDCoCBicmVhazsKPiDCoAo+IMKgwqDCoMKgIGNhc2UgUl9DVVJERVNDOgo=


