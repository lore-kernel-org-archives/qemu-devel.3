Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561DACCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIcur-0002NR-M9; Sun, 18 Oct 2026 22:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xIcuq-0002NI-1B
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:15:56 -0400
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xIcun-0000om-NF
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:15:55 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id D793D1D0015E
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 22:15:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sun, 18 Oct 2026 22:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1792376151; x=1792462551; bh=i+yGs/eAMh+RBuURDK+rapAmp3HdKj+/
 wpLRF43nUz4=; b=IsKz0swMEVJgyZkZe/JqHK77psybiMd4PgDhPk3pIgyapehn
 KUYZINRm+b9up5cp2IyPRqlk4U5j2p7M8/erOjxK+jLWcDxTN+bryDzeV6TMyG1C
 noYBMwt6W73YCIiG4DSehP8QwO8xkPc1SgnHMupDAikJOU5+p2R9IMHTxs0lDsVe
 qfrZi50UK64NO9Wg6gfu4gumuF77qXC/7oFzcBHGafsyi5RTMTCBgBDfsi2iAwGE
 scgoBkvkxDri+iWLHRHw7YLYIY46DsIKni2Q2zT5hFKeijQ7SAcIwT5YUOuBEt+3
 D7GIUWGgOngOz1CrcGR5boMLzbM05PrkgpTwDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792376151; x=
 1792462551; bh=i+yGs/eAMh+RBuURDK+rapAmp3HdKj+/wpLRF43nUz4=; b=l
 MS6k0BdAK5yy/bLwMAohOGzMOKoxnBCj8MSD8vZZBloxB3cYHawaxAsWpfz3wEbE
 VTNgq0ks3g7NfUT6D/9SBMotOUezh9o5Sjg2PHhkARuNoeOxHMDStyVwlSuvjxz0
 ByJY2sEwSw7ZXwDtTj7GDo0LWKkDvMtxcuWvYOejQTGr8l1O+XhQp0DqpKGBG5HZ
 eq2sYFOq4adCBioDYaZ7EWtEA4DprJjVkSejuZbymKjzJ01CqBKTte7jTxzCnYHZ
 05myaaqermLyte7q9Qw0+Xael1mKNoGsNsoGpd275wS9NZI28G9GmQ0sVv/Xvz4h
 UHvmSu+bPhstAm7SCKMPA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792376151; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:OEPc/nkfIQs/L8l4MaIL07ez/vIWUtdhCfe4EglIBZ1GbIA
 19x95Hps8BGHQN5/+bKkugOEMUvpS2CQHqWFOPNspCWrCuBX0PNof9BbWyCoZ3zY
 QGOG0ouYofzrKUnL4Ix2ahqiwOgtBo30tQxyHu1qHzb5XqbuUelkYKKFCJQLLdOt
 c3UE9GJEG/g1RWAkUbneLe05dCl4WDG+ihZVDXiH3vc9Lh25igDeDbdcZGthjFWH
 0ZEqEQC4AeK9WONk1ndTUV3SnzFOM7HiogIjODI9Q2h3mPGrZMUdqZl2D4YWh9dm
 ommKrT7lKCzDS9d1JgkYrVzRZy1EJ0EUJ89kswg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:vFfCxrTReRFp8Acpz+JRh1wlMP0EMhPNG8nZ1y/WiaI=:i+yGs/eAMh+RBuURDK+rapAmp3HdKj+/wpLRF43nUz4=;
X-ME-Sender: <xms:V33Valf_Uc_VIEnb_iIr1yiur4lr-Zye72SrPB8VjLIY3JdNgcYncg>
 <xme:V33VauIAtlaY_v_q8gqh5u1UGK-iy_abrJ-lU_uXE_w1kZQTwqTKcynvI1iLNgi5c
 qPpyz18Aw1s-RrQZYE3kXtkSKSUrQ-ZJwmtOgnxV3BI30PnFasml2s>
X-ME-Received: <xmr:V33VatjiqUrCvXLrfXhfnmIvfqWVjAVgY--DM5sf0gUY8fMVet5BoLcBHIif4Zs81l87_DynKNEJ25Ox97kQqjib_8s>
X-ME-Proxy-Cause: dmFkZTG22oLZKCCmAxybmiva5vB3oflKDnmJX1o2iLDlkI+j/QFMwAcbaz9cFXsj65E9hL
 mCgj1Ef1zWusAkyjAohnUuQx9S9XF7pDQC5I+Ams/XRvDeTljQoYhAJFkz1SryqHmEfxCo
 EFvdF6Q4Q/YX+fd0sxNtzwCz//XsbX1JeC2MB4n+CltsNMQlGZL3jn/KI70ZyQP+TuwUoH
 jbX/sTUqERl+vmD87x2/t4+p9UlbdSG7cuCybkWl25q/9LZq5IXAmnM9MpTe+rchD+RuJA
 1VnNXoU9SqzhJCv1DnzL+KznwbuQCRbckYSL5wFYvx7mWbgQBzUFda3VD5nQJt5OT9kKZ8
 AEbkQD8oyykSJ46Oyqbv/Qb8oELnuP2KlEJGQ1fJ1gPbXKpCJxLU91qhrNgaGLMMS+x2Ej
 JL3zvI+y/BolTgTAKwnuMvDFPd+jDFMs4xrTDupTIBXFxM2uL5xPeGqnzWescC/9UxMlKA
 Tb6WzAAVh+sjVITlbaKiCc1a7YP+xfQvsdZYU3bBBiz1A2nIxcluCzerUmSxCgo10+OWxz
 sLndqCzqy7QWeOpZzXXZS5uASa5rx/9YAMDyKb4+I8rc0GHLhuzRp7wWYAAIEJCd9j3uzC
 0tF2l86hYY5evXcYqh2jExp50wxejrITABX3Sc+0DgkdueWuNMLKhUAdoZYQ
X-ME-Proxy: <xmx:V33VakSqEdqOTN3hEBGvhx9XSRv51Uq6C0t2dnU1BYW0b58-4kaVkw>
 <xmx:V33VavVycpLSXpkDUuxrnoo2MrZ3X6GzHF4AzciciM8om3RcPGtsMA>
 <xmx:V33VaoR-jizCgg2_pquEjx9TVK8nsoWZ0ffuu9V9bsLXD1eDw84miA>
 <xmx:V33VaplKu193uMcUDQaGDtQ9nOU_ALnDNc89J_lWEU5yeAebgYbbSw>
 <xmx:V33Vah-FSM2YqHElc8DvpY-KnlbmyDUtliKC6XefKkPquvkJwyNX2LVr>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 22:15:48 -0400 (EDT)
Message-ID: <ddb5ba58e24be916b591b6012524205398d482fd.camel@alistair23.me>
Subject: Re: [PATCH 26/63] hw/char/cadence_uart: fix RX FIFO overflow handling
From: Alistair <alistair@alistair23.me>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Cc: Pavee Hui <phui@google.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Date: Mon, 19 Oct 2026 12:15:46 +1000
In-Reply-To: <20261004-issue-4560-v1-26-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
 <20261004-issue-4560-v1-26-ccbef537cbeb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.144;
 envelope-from=alistair@alistair23.me; helo=fout-b1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

T24gU3VuLCAyMDI2LTEwLTA0IGF0IDE0OjIzICswNDAwLCBNYXJjLUFuZHLDqSBMdXJlYXUgd3Jv
dGU6Cj4gVGhlIG9sZCBjb2RlIGNoZWNrZWQgZm9yIG92ZXJmbG93IG9ubHkgb25jZSBiZWZvcmUg
dGhlIGxvb3AsIHdoaWNoCj4gbWVhbnQgYSBtdWx0aS1ieXRlIHdyaXRlIGNvdWxkIHNpbGVudGx5
IG92ZXJmbG93IHRoZSBGSUZPIHdoZW4gdGhlcmUKPiB3YXMgc3BhY2UgZm9yIHNvbWUgYnV0IG5v
dCBhbGwgYnl0ZXMuIENoZWNrIHBlci1ieXRlIGluc3RlYWQsIHN0b3JpbmcKPiBhcyBtYW55IGJ5
dGVzIGFzIHBvc3NpYmxlIGJlZm9yZSBmbGFnZ2luZyBST1ZSLiBPbmx5IGFybSB0aGUgRklGTwo+
IHRyaWdnZXIgdGltZXIgd2hlbiBieXRlcyB3ZXJlIGFjdHVhbGx5IHN0b3JlZC4KPiAKPiBGaXhl
czogMzU1NDhiMDZjZjU1ICgiY2FkZW5jZV91YXJ0OiBpbml0aWFsIHZlcnNpb24gb2YgZGV2aWNl
IG1vZGVsIikKPiBSZXBvcnRlZC1ieTogUGF2ZWUgSHVpIDxwaHVpQGdvb2dsZS5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5j
b20+CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMu
Y29tPgoKQWxpc3RhaXIKCj4gLS0tCj4gwqBody9jaGFyL2NhZGVuY2VfdWFydC5jIHwgMTYgKysr
KysrKysrLS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaHcvY2hhci9jYWRlbmNlX3VhcnQuYyBiL2h3L2No
YXIvY2FkZW5jZV91YXJ0LmMKPiBpbmRleCBlZmY2YTNjNGQxN2EuLmFlMTFjYWExMWI4MiAxMDA2
NDQKPiAtLS0gYS9ody9jaGFyL2NhZGVuY2VfdWFydC5jCj4gKysrIGIvaHcvY2hhci9jYWRlbmNl
X3VhcnQuYwo+IEBAIC0yODQsMTQgKzI4NCwxNiBAQCBzdGF0aWMgdm9pZCB1YXJ0X3dyaXRlX3J4
X2ZpZm8odm9pZCAqb3BhcXVlLAo+IGNvbnN0IHVpbnQ4X3QgKmJ1ZiwgaW50IHNpemUpCj4gwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm47Cj4gwqDCoMKgwqAgfQo+IMKgCj4gLcKgwqDCoCBpZiAocy0+
cnhfY291bnQgPT0gQ0FERU5DRV9VQVJUX1JYX0ZJRk9fU0laRSkgewo+IC3CoMKgwqDCoMKgwqDC
oCBzLT5yW1JfQ0lTUl0gfD0gVUFSVF9JTlRSX1JPVlI7Cj4gLcKgwqDCoCB9IGVsc2Ugewo+IC3C
oMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgc2l6ZTsgaSsrKSB7Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcy0+cnhfZmlmb1tzLT5yeF93cG9zXSA9IGJ1ZltpXTsKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzLT5yeF93cG9zID0gKHMtPnJ4X3dwb3MgKyAxKSAlCj4gQ0FERU5DRV9V
QVJUX1JYX0ZJRk9fU0laRTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5yeF9jb3VudCsr
Owo+ICvCoMKgwqAgZm9yIChpID0gMDsgaSA8IHNpemU7IGkrKykgewo+ICvCoMKgwqDCoMKgwqDC
oCBpZiAocy0+cnhfY291bnQgPj0gQ0FERU5DRV9VQVJUX1JYX0ZJRk9fU0laRSkgewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHMtPnJbUl9DSVNSXSB8PSBVQVJUX0lOVFJfUk9WUjsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgIH0KPiArwqDCoMKg
wqDCoMKgwqAgcy0+cnhfZmlmb1tzLT5yeF93cG9zXSA9IGJ1ZltpXTsKPiArwqDCoMKgwqDCoMKg
wqAgcy0+cnhfd3BvcyA9IChzLT5yeF93cG9zICsgMSkgJSBDQURFTkNFX1VBUlRfUlhfRklGT19T
SVpFOwo+ICvCoMKgwqDCoMKgwqDCoCBzLT5yeF9jb3VudCsrOwo+ICvCoMKgwqAgfQo+ICvCoMKg
wqAgaWYgKGkgPiAwKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCB0aW1lcl9tb2Qocy0+Zmlmb190cmln
Z2VyX2hhbmRsZSwgbmV3X3J4X3RpbWUgKwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAocy0+Y2hhcl90eF90aW1lICoKPiA0KSk7Cj4gwqDCoMKgwqAgfQo=


