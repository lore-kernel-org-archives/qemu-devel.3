Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D207C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtt4u-0005d7-08; Tue, 11 Aug 2026 16:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt42-0005Hi-W1; Tue, 11 Aug 2026 16:27:11 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt41-0004c4-I9; Tue, 11 Aug 2026 16:27:10 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 830EA14000BD;
 Tue, 11 Aug 2026 16:27:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Tue, 11 Aug 2026 16:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786480027; x=1786566427; bh=tV3H1vzhEsF4kdo+ZSbnyfwUHoWUw12S
 QvOthwqW9lM=; b=fgUYRNkBLsXvNCkwFahIyX5r3+nYFWFkMnNZLUGjiVaqhxCi
 BGxv4v385hjeYwqTUFouzOe6h0uidjNEtmETIa01xkYiMQTdqd/2y5CP7zyuyxa+
 7f0+qjnRjRSjoI8lFNKXMULBH5eu7UoDcWOxCSOVhngj8/c2hi1lPjewIQWJPS8o
 BsPcF+DgXbC8AWzSxjSidZHrWz4eCe2hDrFCjT0FhGhsJ3dfxUPbJCpIGgiGbvHv
 hzV4NYu+/DKZ9CkLeSjD9p4EHUIQLTDpgZHNIjAJUg3ZoVqXILpYQdXNGz+/0O71
 TKNEf5nn7FSWiQf8ogF3yJRtBniVPkT+59sPXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786480027; x=
 1786566427; bh=tV3H1vzhEsF4kdo+ZSbnyfwUHoWUw12SQvOthwqW9lM=; b=U
 Uk2zLPHjKC+fulpUEkP6rGyKiZzga6zBKKscJX6x1Ky1xOOb7uBG5e2Iys0pvpTR
 8pQYKs0dxMfqjKzWNjuUWAJL1kDYO6IKN6KPZHwL+lSz2QUmB5bG6fNgocTvTHet
 dWJQKLDKN9KbgyL5blaIfD059B9A4HEkkkZ9utPk2i3uUqkDvK8sm8vsRLIQnJq4
 HmtR12aE6pyVMpouIehtGZfoFSVsEFgQ+zpIWBwg8p9kZXmxOfLD9hAoTEDL4BGU
 drtFyuc89c2po6X3GcprRAq3BMKcZqjA8vaEUl3IbYDljazsjy4I1ZIEHQJI6icj
 sJ9pB/ULP/nID/D9fursg==
X-ME-Sender: <xms:m4V7asbAsRhbUHjSYQ63yLHqw8Ca_SVqAKxKahfpEhQhn4DmAOvEbA>
 <xme:m4V7arvjAD-GpU5lDFFQHl9wVtlYcMWpen_QxV8wD1lho_faGQuEeMhN9USZ-LpmK
 ROFq1qviIFOQXKkisyf1fJIdcpKnMFif5qI1s_rAaaaXwIsbSJetuI>
X-ME-Received: <xmr:m4V7amGr85Un11axGLOVAqOQPaJrmlHF789s7W3atWhfUkdyIgLdPygqbMFr-FEoPNPMHA>
X-ME-Proxy-Cause: dmFkZTE0EZyRZ7wKPWgKPXWQORKjyGpPS2MXjeq7cO5+xq581WzrhI4X6Z/eKYPJqimyGV
 eBh135KcADSLxdtMQb3+CThtL4jkcoJeOaMfFjYssGEAwo9Th+FktpBmFO0Hx/OaA5IKAM
 WWFj1Yxed6ihZbWE3ss7Ki2u1KRuhrh+nsnEcg/+UvugGikBQHU9zCz4LdzSJ787B5Sx4w
 rEJ02Ya1x9DyBFIBJskbnXhTLOvjhyEId4Lz82HVQFJNpAIXUr7dEy5FDtQOPHKp/ziRK8
 lWeQRlKaqTQEzvHgovHVNNePqFfQvh8F2ZZPjC8QpM9U/2vZxSlwFXhVU1OJ646aJQPbeV
 lLMtjYBOBZbWnZtnQQqWzCDnlqDMa0iNxO88aELKgQLBbxVTmfUUTz2xKylUFksHY+YLcC
 wJV0XhbvlTmAoSr7pIVOg6zILID/VsVOmo4n5D7RptFEF9YKf/AQ+1tK7U3xrtBFOWrH7s
 OuUhELwgyfs3VCmh2EOzlTXlQR8URp7PebppiBZln5BV7ElO4CIxqLqC9qMTVE1PgOn5OQ
 d8N7N9BGCAhHUmA7iTzRgpajKhORCuSM0KFpP6YKrkT6PNME+3lKNwaU28r+Ngw1OwIZJd
 FzZ0/bDJXE8hwKDm16dIixIMuevhf6Qn4jvUkd+KA7mDzZ//a3u6SWqQAHJw
X-ME-Proxy: <xmx:m4V7auwV95EOsRCNmo_vikaH0jnswJ_ARsDmHwQfzG7S1uhhQFSw6Q>
 <xmx:m4V7athl9DXY5zE7SlcIe4Pl4y8Vvy3r832T4qbIJJD48Ba7hLfpDQ>
 <xmx:m4V7apzweahRlbvaryCu2xdlWBbV6dt_U3gS0zRHQYNxY7-Mjv46_Q>
 <xmx:m4V7agIWScxfPRspAnoB_OcRZSZJGaXk5C9vkx04DO-MPhTWrwSxyw>
 <xmx:m4V7avNsYa2jr3QOhwLacLNPBJcBdOm7ZEUHDV7dDiXc6mXHs91-wyOF>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:27:07 -0400 (EDT)
Message-ID: <bbba7fd2ffbe49053df36a8a17127c482b779c8e.camel@alistair23.me>
Subject: Re: [PATCH 36/56] disas/riscv: Chain "nop" pseudo off "mv" pseudo
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:27:06 +1000
In-Reply-To: <20260809223545.730664-37-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-37-richard.henderson@linaro.org>
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

T24gU3VuLCAyMDI2LTA4LTA5IGF0IDE1OjM1IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiAibXYiIGhhcyBhbHJlYWR5IGNoZWNrZWQgYSBjb25kaXRpb24gdGhhdCBhcHBsaWVzIHRv
ICJub3AiLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhl
bmRlcnNvbkBsaW5hcm8ub3JnPgoKUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0
YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKgZGlzYXMvcmlzY3YuYyB8
IDEwICsrKysrKystLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Rpc2FzL3Jpc2N2LmMgYi9kaXNhcy9yaXNjdi5j
Cj4gaW5kZXggMmZlYzEzNWI1Zi4uMzdmNjQ0MDgzMSAxMDA2NDQKPiAtLS0gYS9kaXNhcy9yaXNj
di5jCj4gKysrIGIvZGlzYXMvcmlzY3YuYwo+IEBAIC0xMDM1LDcgKzEwMzUsNyBAQCBzdGF0aWMg
Y29uc3QgcnZjX2NvbnN0cmFpbnQgcnZjY19qYWxfcmFbXSA9IHsKPiBydmNfcmRfZXFfcmEsIHJ2
Y19lbmQgfTsKPiDCoHN0YXRpYyBjb25zdCBydmNfY29uc3RyYWludCBydmNjX2phbHJfcmFbXSA9
IHsgcnZjX3JkX2VxX3JhLAo+IHJ2Y19pbW1fZXFfemVybywKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJ2Y19lbmQgfTsKPiDCoHN0YXRpYyBjb25zdCBydmNfY29uc3Ry
YWludCBydmNjX25vcFtdID0geyBydmNfcmRfZXFfeDAsCj4gcnZjX3JzMV9lcV94MCwKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJ2Y19pbW1fZXFfemVybywgcnZjX2VuZAo+IH07Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBydmNfZW5kIH07Cj4gwqBzdGF0aWMgY29uc3Qg
cnZjX2NvbnN0cmFpbnQgcnZjY19tdltdID0geyBydmNfaW1tX2VxX3plcm8sIHJ2Y19lbmQKPiB9
Owo+IMKgc3RhdGljIGNvbnN0IHJ2Y19jb25zdHJhaW50IHJ2Y2Nfbm90W10gPSB7IHJ2Y19pbW1f
ZXFfbjEsIHJ2Y19lbmQgfTsKPiDCoHN0YXRpYyBjb25zdCBydmNfY29uc3RyYWludCBydmNjX25l
Z1tdID0geyBydmNfcnMxX2VxX3gwLCBydmNfZW5kIH07Cj4gQEAgLTExMDgsMTEgKzExMDgsMTUg
QEAgc3RhdGljIGNvbnN0IHJ2X2NvbXBfZGF0YSBydmNwX2JnZVtdID0gewo+IMKgfTsKPiDCoAo+
IMKgc3RhdGljIGNvbnN0IHJ2X2NvbXBfZGF0YSBydmNwX2FkZGlbXSA9IHsKPiAtwqDCoMKgIHsg
cnZfb3Bfbm9wLCBydmNjX25vcCB9LAo+IMKgwqDCoMKgIHsgcnZfb3BfbXYsIHJ2Y2NfbXYgfSwK
PiDCoMKgwqDCoCB7IH0sCj4gwqB9Owo+IMKgCj4gK3N0YXRpYyBjb25zdCBydl9jb21wX2RhdGEg
cnZjcF9tdltdID0gewo+ICvCoMKgwqAgeyBydl9vcF9ub3AsIHJ2Y2Nfbm9wIH0sCj4gK8KgwqDC
oCB7IH0sCj4gK307Cj4gKwo+IMKgc3RhdGljIGNvbnN0IHJ2X2NvbXBfZGF0YSBydmNwX3NsdGl1
W10gPSB7Cj4gwqDCoMKgwqAgeyBydl9vcF9zZXF6LCBydmNjX3NlcXogfSwKPiDCoMKgwqDCoCB7
IH0sCj4gQEAgLTE4NjksNyArMTg3Myw3IEBAIHN0YXRpYyBjb25zdCBydl9vcGNvZGVfZGF0YSBy
dmlfb3Bjb2RlX2RhdGFbXSA9Cj4gewo+IMKgwqDCoMKgIHsgImMubHFzcCIsIHJ2X2NvZGVjX2Np
X2xxc3AsIE5VTEwsIERFQ09NUChydl9vcF9scSkgfSwKPiDCoMKgwqDCoCB7ICJjLnNxc3AiLCBy
dl9jb2RlY19jc3Nfc3FzcCwgTlVMTCwgREVDT01QKHJ2X29wX3NxKSB9LAo+IMKgwqDCoMKgIHsg
Im5vcCIsIHJ2X2NvZGVjX2ksIHJ2X2ZtdF9ub25lIH0sCj4gLcKgwqDCoCB7ICJtdiIsIHJ2X2Nv
ZGVjX2ksIHJ2X2ZtdF9yZF9yczEgfSwKPiArwqDCoMKgIHsgIm12IiwgcnZfY29kZWNfaSwgcnZf
Zm10X3JkX3JzMSwgcnZjcF9tdiB9LAo+IMKgwqDCoMKgIHsgIm5vdCIsIHJ2X2NvZGVjX2ksIHJ2
X2ZtdF9yZF9yczEgfSwKPiDCoMKgwqDCoCB7ICJuZWciLCBydl9jb2RlY19yLCBydl9mbXRfcmRf
cnMyIH0sCj4gwqDCoMKgwqAgeyAibmVndyIsIHJ2X2NvZGVjX3IsIHJ2X2ZtdF9yZF9yczIgfSwK



