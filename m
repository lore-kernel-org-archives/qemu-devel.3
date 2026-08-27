Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D28C5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSec-0004qY-OW; Thu, 27 Aug 2026 01:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzSeb-0004qJ-VV; Thu, 27 Aug 2026 01:27:57 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzSeT-00087o-N9; Thu, 27 Aug 2026 01:27:51 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 0642AEC00C9;
 Thu, 27 Aug 2026 01:27:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 27 Aug 2026 01:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1787808468; x=1787894868; bh=/aB9pgtig98bpvW+OmELPQfsby/2/YRM
 M9L45YgIdWM=; b=NqC4XYMcQAi4ibPLvEHNPozKxZpUve4u3AkkyN5eErVMv47l
 lRNxd7pIRD/GyXYp/I1BW4wE+t7cTCAu6qhW6KatzortgjHk5WTjygrIVNiCl0jz
 Lp+P4v0PY8mdb5r4I1aOZyjYbgo7DsAIZSaYKVstzACxgUEmYvHyJDWgGImj60i4
 4YPmW+tkSeNcAnxm9bMnWQcMA2nvVkjJj2fNRcg2Q55Sdhr8S+Ts7PsdUNsVR4co
 Tf+ENO2kbB9hK5cud/11SXjohEfqEjb0nRGDRRf54NosNCX9xIbErCdjfp8Pezl3
 qNbGwq8NHi8uC1JTGn2+FpG+zYWFj2FUIjXoGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787808468; x=
 1787894868; bh=/aB9pgtig98bpvW+OmELPQfsby/2/YRMM9L45YgIdWM=; b=D
 uNthAvLoJrHVUPMzf2H3nbXPRm7CSivtfyO39DgFKWUvp54PfA/YBh8vM3etk2np
 59Ymvh2wVwovHjL6fEu57FhtHd08rNNmCxlOe0+WpZ5mMFeTb6CrREJkt/CqcoD9
 smkeYSF4UuegScTRYWavKzQkj4f64U9n3cQmlk20cj+GCpjKIPE6WX0BMAnRFcBV
 Ys8+PPRADIPbsogGBV94UwF5UUlLk9+Y/iyPh0a13JYwpKuppusbQLJsTBPNILO9
 wFPQMSfegjmJ+Hr85HFYJINLGX+LAqVtSSkl/SmPw7FJzORJMUhOJEZvS4up6COG
 haq2Lv+VcEY0Y8Ngp9AVA==
X-ME-Sender: <xms:08qPaqZdOavRNV_K9zBClGQXS8MfjwajADseyny6JNNSRpFHKJ2_7g>
 <xme:08qParitiV7YGUAfpC0o44ZRsTbOTO_64Js8Eq2VjEPHz7CUoivlgVmKWNdZxqM89
 dpTw_57-HWfcXSpVTthmOL4Lqn6w3o-ap_E6NM5LdKp1ndkG06MYKaR>
X-ME-Received: <xmr:08qPavieSWC6oE3bU29lTSZlENx6BzQyQSARr_SCERSeS6oK6j7Qwg8SLNttMQgUC9LH9oiMBGWEIVAAkkuyoFac-Sc>
X-ME-Proxy-Cause: dmFkZTGxTzDF9ljJovxys1DnOAP0oUJYty27B0GzBM4AXiCJZn3bFLRWTYPddY6wPdtbi3
 LsMf639TMhCgcY8YGmw5a71jBM5Tm+Ly0lIZSBP+kXpBaufxKbT91VVd/AfhlpIm/a8fqJ
 qnXrccbBd3jRyM7clZbeLcthu8KWr5eOsFEp+msZKwr8FERLfyTok7Und+7iE/hppI+z6E
 NpNVSJtIRKP5rXJThMVue7BQz0b1mhbiB88Ng9vRwwl8Z6UCEM7c+GxnwYPhddH8RtIvHO
 EXISFgbTV4wZQg2MaF9vXKNHNo+CzxHLOVQzhKn9DxKSRZa6AkV0vHNiZjdmzGIdgTuepr
 PhQdcsPd6mT6b5VaK/KnzRlWb38GDi0QCl9712ep7suLBpP605rQjUDausr0zH+4bBLglj
 V6d0Ky8YGayEPtwcLACfPiIjEMtCTgTWOjEHBtqtiTo0PM9Tego+7TMjMd0mPd/CqPy1Op
 6wD2BqNAPhbR5H5i32GbSQJxQ1AGsseEhYeEX/jb0OrqGeWrrpSmo15rAO2SNtRAYHUjCD
 He089/b+6VSX9vR9pa6M3QGDb9MywnzrjBXZibRGGmDaDH4FQ3UEbjovqqh/4QRWTzs5zY
 6rZN1JqB60/UhpIHRc5EJ5U+uXlylcJUfvQzpsMxwjCqp1vfWBsm1DvNwAXw
X-ME-Proxy: <xmx:08qPahKWb0q6-eFjjxklj1qL7YE5SMILq-xXT43Hdl7Nrscxb0XByA>
 <xmx:08qPamUboDbpfpxBODd5lW0FtRjr5vrcp2wEPPpj_vGUKosn5hUjqw>
 <xmx:08qPaj1Jku_l9J1bOp7IbRQ2GxPC1oC6c58gn2djlsxot7qSGX23Cw>
 <xmx:08qPajRQdRazRpGvboXQ5ZGVH32n8xSf_MUzM5bCtjMFIzX2DciJMw>
 <xmx:1MqPai8wcHQDHN_xTgO1CBNuVwz0e3eb57Gw9YBBkEaQJa753wA2boWc>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 01:27:39 -0400 (EDT)
Message-ID: <569ab33835bd619963d3e6f34984498987148570.camel@alistair23.me>
Subject: Re: [PATCH 2/4] hw/ssi/pl022: Fix dropped upper bytes of ssi transfer
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
Date: Thu, 27 Aug 2026 15:27:37 +1000
In-Reply-To: <20260825040452.1322251-3-stephensportia@gmail.com>
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <20260825040452.1322251-3-stephensportia@gmail.com>
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
dC5jb20+Cj4gCj4gVGhlIHBsMDIyIG1vZGVsIHN1cG9ydHMgdHJhbnNmZXJyaW5nIGEgOC1iaXQg
b3IgMTYtYml0IGZyYW1lIHdpZHRoLgo+IFRoZQo+IDE2LWJpdCB0cmFuc2ZlciBpcyBicm9rZW4g
c2luY2UgdGhlIHVwcGVyIDgtYml0cyBhcmUgYmVpbmcgZHJvcHBlZCBieQo+IHRoZSBTU0kgcGVy
aXBoZXJhbCB0cmFuc2ZlciBmdW5jdGlvbi4gRml4IHRoaXMgYnkgYWRkaW5nIGEgc2Vjb25kCj4g
Y2FsbAo+IHRvIHNzaV90cmFuc2ZlcjgoKSB3aGVuIHRoZSBmcmFtZSB3ZGl0aCBpcyAxNi1iaXRz
Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBvcnRpYSBTdGVwaGVucyA8cG9ydGlhc0Bvc3MudGVuc3Rv
cnJlbnQuY29tPgoKUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5j
aXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKgaHcvc3NpL3BsMDIyLmMgfCAxMiArKysr
KysrKy0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL2h3L3NzaS9wbDAyMi5jIGIvaHcvc3NpL3BsMDIyLmMKPiBp
bmRleCBlYWFjNjY0ZWM1Li5mNGFkZTQ1Y2E5IDEwMDY0NAo+IC0tLSBhL2h3L3NzaS9wbDAyMi5j
Cj4gKysrIGIvaHcvc3NpL3BsMDIyLmMKPiBAQCAtNzQsNyArNzQsNiBAQCBzdGF0aWMgdm9pZCBw
bDAyMl94ZmVyKFBMMDIyU3RhdGUgKnMpCj4gwqB7Cj4gwqDCoMKgwqAgaW50IGk7Cj4gwqDCoMKg
wqAgaW50IG87Cj4gLcKgwqDCoCBpbnQgdmFsOwo+IMKgCj4gwqDCoMKgwqAgaWYgKChzLT5jcjEg
JiBQTDAyMl9DUjFfU1NFKSA9PSAwKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCBwbDAyMl91cGRhdGUo
cyk7Cj4gQEAgLTk5LDEzICs5OCwxOCBAQCBzdGF0aWMgdm9pZCBwbDAyMl94ZmVyKFBMMDIyU3Rh
dGUgKnMpCj4gwqDCoMKgwqDCoMKgwqAgdGhlIHRyYW5zZmVyIGhhcyBjb21wbGV0ZWQuwqAgKi8K
PiDCoMKgwqDCoCB3aGlsZSAocy0+dHhfZmlmb19sZW4gJiYgcy0+cnhfZmlmb19sZW4gPCA4KSB7
Cj4gwqDCoMKgwqDCoMKgwqDCoCBEUFJJTlRGKCJ4ZmVyXG4iKTsKPiAtwqDCoMKgwqDCoMKgwqAg
dmFsID0gcy0+dHhfZmlmb1tpXTsKPiArwqDCoMKgwqDCoMKgwqAgdWludDE2X3QgdHggPSBzLT50
eF9maWZvW2ldOwo+ICvCoMKgwqDCoMKgwqDCoCB1aW50MTZfdCByeCA9IDA7Cj4gwqDCoMKgwqDC
oMKgwqDCoCBpZiAocy0+Y3IxICYgUEwwMjJfQ1IxX0xCTSkgewo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAvKiBMb29wYmFjayBtb2RlLsKgICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cnggPSB0eDsKPiDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdmFsID0gc3NpX3RyYW5zZmVyOChzLT5zc2ksIHZhbCk7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHMtPmJpdG1hc2sgPiAweGZmKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByeCB8PSAoc3NpX3RyYW5zZmVyOChzLT5zc2ksICh0eCA+PiA4KSAmIDB4ZmYp
IDw8Cj4gOCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJ4IHw9IHNzaV90cmFuc2Zlcjgocy0+c3NpLCB0eCAmIDB4ZmYpOwo+IMKgwqDCoMKg
wqDCoMKgwqAgfQo+IC3CoMKgwqDCoMKgwqDCoCBzLT5yeF9maWZvW29dID0gdmFsICYgcy0+Yml0
bWFzazsKPiArwqDCoMKgwqDCoMKgwqAgcy0+cnhfZmlmb1tvXSA9IHJ4ICYgcy0+Yml0bWFzazsK
PiDCoMKgwqDCoMKgwqDCoMKgIGkgPSAoaSArIDEpICYgNzsKPiDCoMKgwqDCoMKgwqDCoMKgIG8g
PSAobyArIDEpICYgNzsKPiDCoMKgwqDCoMKgwqDCoMKgIHMtPnR4X2ZpZm9fbGVuLS07Cg==


