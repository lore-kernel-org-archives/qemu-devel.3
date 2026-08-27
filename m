Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A64C5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzShq-000698-FX; Thu, 27 Aug 2026 01:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzSho-00068B-57; Thu, 27 Aug 2026 01:31:16 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzShm-0000jp-Ff; Thu, 27 Aug 2026 01:31:15 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 015E4EC01AD;
 Thu, 27 Aug 2026 01:31:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 27 Aug 2026 01:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1787808672; x=1787895072; bh=OCMJ/MYUimGd/Fob8NO80S5wGAaBu0It
 BzUd8eGnMOs=; b=kiDAQtEDa7DoBXNwMBYZj0FThzEQpBndYKYOXOjPUzw6gaIA
 e4inFH+kugVU72zzeD3RR+Kzvvpr3tNQNY/LUGm3BQ8y7oZN1d8j8wV+8pCWzXhQ
 P1gyI60VGr9+fzrI2egEtzMyGitpAvCnIwwMOKzxCvIqlaqH54dKMuHsTqJJEThF
 YGwytfy1S7XucE7yKwV7fuMqmOdlTsgAUNk1y455Cfntz2g/RIRyCWDCI1F/aNGi
 8dCzemyYqFI+DdL6ws8ChgCuVHI71NyF8P91/nk3UmBjozg52IkjynJGrvBP3SfA
 OuvYRr5/zap97LfGhTtl2Rw4lA0KcULdZ910CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787808672; x=
 1787895072; bh=OCMJ/MYUimGd/Fob8NO80S5wGAaBu0ItBzUd8eGnMOs=; b=c
 iCXLlzDn7QaITassrasJpPnuRTh/VpyOVBXJHkAYNcjVjvbbpspGNNaYn1QYQYq9
 IDWy6rI/asEYr1y5gHKz4uGZt5x6V0ysUDaFjopgw1mo0NasdZK/HsJvQjT6D8I0
 cnRxH/fQsP36bRFj2oApcP/P53RSKef9muHW6BRrOyTRfKSf8toDsdR+9L0cPMU9
 7l1g0Z9ick72wXGDTDlULoKj6M8q8H3LHu07n4NlJKqK7ERlWtN7t4G6fjD5w6Ht
 m+m7xq5XDlQMnnq/5FVkDJhiUGng+ISN5rY7p1y2hvUFRbMUflROLDEglicqodir
 O1HV2Ir3YT5pA5J4d2+qA==
X-ME-Sender: <xms:n8uPagefVorlJ2y3bb4sBu2Z1tFPr8PrPPUuDpRMmeewoH2u0YV8IA>
 <xme:n8uPaj1fRarSsWt7zrYf0rjTJGEIqMyuw62ULI-BfUQaG8fjFYVKSAH59_KV9LZ3f
 P9aG1B_pgHiCy9p8O58yfeRa_t5CIp-SXhJsmH324XtjZIlQ5rY-no>
X-ME-Received: <xmr:n8uPagMFSCk96bxTN8GQC0ARABTUgnFYNBLayeHET2JNK2hCwhok64MS2d91w_c9IUjhYZWNhmZEoKTypAxu8yS8jHw>
X-ME-Proxy-Cause: dmFkZTGxTzDF9ljJovxys1DnOAP0oUJYty27B0GzBM4AXiCJZn3bFLRWTYPddY6wPdtbi3
 LsMf639TMhCgcY8YGmw5a71jBM5Tm+Ly0lIZSBP+kXpBaufxKbT91VVd/AfhlpIm/a8fqJ
 qnXrccbBd3jRyM7clZbeLcthu8KWr5eOsFEp+msZKwr8FERLfyTok7Und+7iE/hppI+z6E
 NpNVSJtIRKP5rXJThMVue7BQz0b1mhbiB88Ng9vRwwl8Z6UCEM7c+GxnwYPhddH8RtIvHO
 EXISFgbTV4wZQg2MaF9vXKNHNo+CzxHLOVQzhKn9DxKSRZa6AkV0vHNiZjdmzGIdgTueRJ
 OWVjbYsKGpEcsKi2tRH85y0VeCVBpuFTWD39+eEX/hrVIS7YhPnMkoY4rrU5DIaw11cUBR
 Oe4SJWJUh6wWijEE2fufgi+O7rySWQaT11m1VNZQ9fUXEpeXOmcDm+ADYo8riRjNbFP6Zm
 HX5TvBcpCTO5nXEiY2+pr0RIoWx0xsFp7O1euIgw5D9BB4r6RAKiHfvzwjVS9oH7bXbWzL
 oNp+VhgyTf7AhExJ0dFZSq9LPubywmCGLtnbMX2gOR4rEyXOALU08ElCzgs6TeCY+5TqhG
 OC8c2TrYMszIGNlHYRA0HZynQde3+TiqYISyCSJCVO5VtMLHw/jPOqKr8PRw
X-ME-Proxy: <xmx:n8uPaucr5jgz3Q2t1fZtpm30cWlRARKjVZ94_WCanilXUew0MMnrBw>
 <xmx:n8uPatVRClry52rxdUuCAdpDpAlUsrCmrPXpBhPJ0MiPD3pe3gn7NA>
 <xmx:n8uPamw_9xHecQgNkAyA8Gojz40yzB45c0zzT2K-licL-mxlYka7Ag>
 <xmx:n8uPajjqfubhWrDJLeb5-TW9b1iDZQP0r6VtUmzyt-FCVytMcsO3YQ>
 <xmx:oMuPasrEXBKV5fLPef6aSX4FHaBtPYAOuN6vWu2cbMbk3ISENYyGheSs>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 01:31:04 -0400 (EDT)
Message-ID: <c8f06fc012811d207af31afe0b43ca78f1637c36.camel@alistair23.me>
Subject: Re: [PATCH 4/4] hw/ssi/pnv_spi: Fix dropped upper bytes of ssi
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
Date: Thu, 27 Aug 2026 15:31:02 +1000
In-Reply-To: <20260825040452.1322251-5-stephensportia@gmail.com>
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <20260825040452.1322251-5-stephensportia@gmail.com>
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

T24gVHVlLCAyMDI2LTA4LTI1IGF0IDE0OjA0ICsxMDAwLCBzdGVwaGVuc3BvcnRpYUBnbWFpbC5j
b20gd3JvdGU6Cj4gRnJvbTogUG9ydGlhIFN0ZXBoZW5zIDxwb3J0aWFzQG9zcy50ZW5zdG9ycmVu
dC5jb20+Cj4gCj4gVGhlIHBudl9zcGkgbW9kZWwgc3VwcG9ydHMgdHJhbnNhY3Rpb24gc2l6ZXMg
b2YgNCBieXRlcyBob3dldmVyIHRoZXJlCj4gYXJlIG5vIGluLXRyZWUgU1NJIHBlcmlwaGVyYWxz
IHRoYXQgc3VwcG9ydCB0aGlzLiBVcGRhdGUgdGhlIG1vZGVsIHRvCj4gdXNlIGEgOC1iaXQgdHJh
bnNmZXIgZnVuY3Rpb24uCj4gCj4gU2lnbmVkLW9mZi1ieTogUG9ydGlhIFN0ZXBoZW5zIDxwb3J0
aWFzQG9zcy50ZW5zdG9ycmVudC5jb20+CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0tCj4gwqBody9zc2kvcG52
X3NwaS5jIHwgMjggKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9o
dy9zc2kvcG52X3NwaS5jIGIvaHcvc3NpL3Budl9zcGkuYwo+IGluZGV4IGUyYThhNzEwZGEuLjQ4
MTc5OGIxZmEgMTAwNjQ0Cj4gLS0tIGEvaHcvc3NpL3Budl9zcGkuYwo+ICsrKyBiL2h3L3NzaS9w
bnZfc3BpLmMKPiBAQCAtMTk0LDMyICsxOTQsMjYgQEAgc3RhdGljIHZvaWQgc3BpX3Jlc3BvbnNl
KFBudlNwaSAqcykKPiDCoAo+IMKgc3RhdGljIHZvaWQgdHJhbnNmZXIoUG52U3BpICpzKQo+IMKg
ewo+IC3CoMKgwqAgdWludDMyX3QgdHgsIHJ4LCBwYXlsb2FkX2xlbjsKPiArwqDCoMKgIHVpbnQz
Ml90IHBheWxvYWRfbGVuOwo+IMKgwqDCoMKgIHVpbnQ4X3QgcnhfYnl0ZTsKPiDCoAo+IMKgwqDC
oMKgIHBheWxvYWRfbGVuID0gZmlmbzhfbnVtX3VzZWQoJnMtPnR4X2ZpZm8pOwo+IMKgwqDCoMKg
IGZvciAoaW50IG9mZnNldCA9IDA7IG9mZnNldCA8IHBheWxvYWRfbGVuOyBvZmZzZXQgKz0gcy0K
PiA+dHJhbnNmZXJfbGVuKSB7Cj4gLcKgwqDCoMKgwqDCoMKgIHR4ID0gMDsKPiAtwqDCoMKgwqDC
oMKgwqAgZm9yIChpbnQgaSA9IDA7IGkgPCBzLT50cmFuc2Zlcl9sZW47IGkrKykgewo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmICgob2Zmc2V0ICsgaSkgPj0gcGF5bG9hZF9sZW4pIHsKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR4IDw8PSA4Owo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH0gZWxzZSBpZiAoIWZpZm84X2lzX2VtcHR5KCZzLT50eF9maWZvKSkgewo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHggPSAodHggPDwgOCkgfCBmaWZvOF9wb3Ao
JnMtPnR4X2ZpZm8pOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwg
InBudl9zcGk6IFRYX0ZJRk8KPiB1bmRlcmZsb3dcbiIpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0KPiAtwqDCoMKgwqDCoMKgwqAgfQo+IC3CoMKgwqDCoMKgwqDCoCByeCA9IHNzaV90cmFu
c2Zlcjgocy0+c3NpX2J1cywgdHgpOwo+IMKgwqDCoMKgwqDCoMKgwqAgZm9yIChpbnQgaSA9IDA7
IGkgPCBzLT50cmFuc2Zlcl9sZW47IGkrKykgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoKG9mZnNldCArIGkpID49IHBheWxvYWRfbGVuKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByeF9ieXRlID0gKHJ4ID4+ICg4ICogKHMtPnRyYW5zZmVyX2xlbiAt
IDEpIC0gaSAqIDgpKSAmCj4gMHhGRjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWZp
Zm84X2lzX2Z1bGwoJnMtPnJ4X2ZpZm8pKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBmaWZvOF9wdXNoKCZzLT5yeF9maWZvLCByeF9ieXRlKTsKPiArCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKCFmaWZvOF9pc19lbXB0eSgmcy0+dHhfZmlmbykpIHsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJ4X2J5dGUgPSBzc2lfdHJhbnNmZXI4KHMtPnNzaV9i
dXMsIGZpZm84X3BvcCgmcy0KPiA+dHhfZmlmbykpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKCFmaWZvOF9pc19mdWxsKCZzLT5yeF9maWZvKSkgewo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmaWZvOF9wdXNoKCZzLT5yeF9maWZvLCByeF9i
eXRlKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNU
X0VSUk9SLCAicG52X3NwaTogUlhfRklGTwo+IGlzIGZ1bGxcbiIpOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAi
cG52X3NwaTogUlhfRklGTyBpcwo+IGZ1bGxcbiIpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxZW11X2xv
Z19tYXNrKExPR19HVUVTVF9FUlJPUiwgInBudl9zcGk6IFRYX0ZJRk8KPiB1bmRlcmZsb3dcbiIp
Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDC
oMKgwqAgfQo=


