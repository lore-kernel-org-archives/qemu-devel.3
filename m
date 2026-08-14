Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FDEC5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuuBT-0003SQ-R9; Fri, 14 Aug 2026 11:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuuBS-0003S4-DD; Fri, 14 Aug 2026 11:51:02 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuuBQ-0004n7-BW; Fri, 14 Aug 2026 11:51:02 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id BBCEAEC019C;
 Fri, 14 Aug 2026 11:50:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Fri, 14 Aug 2026 11:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786722658; x=1786809058; bh=HZZdXR4pgMzKpLWzK6qwwU8XPOaOufQG
 q40+Nzb+hos=; b=bjOKkZS3M7UOmdlv4MGtomBVfrbThDhmXpdAYi8cY7Kmy/7V
 DHFMKudga53zDcqepn/4SaEsG45622MKkhA/sqM2QnVi2PcOpy+UPbxq5IIyJJVO
 Mc8RsT5f+1CUhRVojd5kzW/f4xM7e9FMD5W1Gv8dV47UKagyu4x60KtIdUumsa/l
 UMpymVyMwWQFAopuMuTxwLHVvxqK8tks56mqVIforblvwlDML8uf/7Yb/bd7keaX
 063yHdapaKxWwk/wxrQKawkctFh7S24A0y9Y2BdfBUctkfnV8cMNRb70rbFFFD7a
 4YhdsvW0bWOlJKHeEOo9CFMoWEd1DHeUIzB2Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786722658; x=
 1786809058; bh=HZZdXR4pgMzKpLWzK6qwwU8XPOaOufQGq40+Nzb+hos=; b=J
 ZJ1r4jF/eVSxYQBMytFJt1cQ8UgMc7HDx669NrXwVxtXWAWnTgir3E2VbvSiNSaO
 1bszDev7DfgwRKmWAcBS3jCUQ7UXP8kh9RbRt5ToDzyARKs2VCRjlHW8HXZFv0yC
 kdo/ZA9ODYTdkkrP2ixTZBY4qYRemjKtDauOqGTb0h80U1i8LQATTpsGVIA21IFS
 kiFKQwt2DVJp74Tb5VCs7AvJuNRr5hXZUAB3K/a1FWDX962pwbUwh8rGDUzTfsKn
 NkdDXaaY0Q7ke18/gq3rDk4Etke7wx5WSWozkz9Lpp/y/vV336knmdiCf6bb9e5Y
 RDEWvHVKL4Ib+zzdvQgtg==
X-ME-Sender: <xms:Yjl_apcT2ZlpmOkV3IXRnlx7WSBX2HOfMBweEAJ_N7m1yI49XwXiww>
 <xme:Yjl_ahRhiNxPs-vOXiiMAa_3tIMOAAa_bm7pBUN7dH8mB8_Bo6W9WCGdwKM5EdH8c
 -03XZQdrhilUvo6-EL9hJ77tId9sfcX91-9jKV23DZc5FTW2P3rwww>
X-ME-Received: <xmr:Yjl_aiapk7dB7l9jcucnfzb1DFVLZYVeggKOhhiaB2iGbmWwHNo9I82HT-5fVrLbWCCpZQ>
X-ME-Proxy-Cause: dmFkZTGu3eW0Z/5hbWCQZQFQyyykLEGLGSUhTjp8ZIY2edQjwBxOaYxzfJTxeIOnQ4+oJ+
 U+s7XccINIyJ/HcMIQJebuaP5fxe5NyMyiTdcXL85zqOXzg5h7K7aCDdoZFjY/WZgkWgwQ
 JKUiAT/mJ0N6KYfNfouOgfnzAv2kI3eqi9/yO6kfaaoqIuvjhmcijqNXzksaAh4tACrU+X
 cuPVr0aRM48UX8cZ8I8lDHHydozGZPYSbNp3VEt9iG7mGikUCeyl47qJM61f9qwgtBy7It
 Pq/hZoru/IL2ZqhBBgNLag5fb9EBYipdCV/OJENQN+eUCvp3NNhyB6MgOir6v6Ege3T8Zl
 JtRrdufXBrzzXObO4l5kejBAnXutyWg6gh/4IOz0scKVb1rsx8FmrLceiIBh7oQWYEtAXO
 xRRszLNkSsPQWAEoKsRGfPw1mAhqoGjXy2sJyIrGJtDiBE7+xScnQ8kTTGKLl0g0mtDN0k
 XFWRaRpiueNTSfQCdi6kLcPNc0eMa8kpo2QA0Gs43SADmDy5Kyp1n46efTSEjtDiCLCP7n
 G5xFuMd4pvwUqFeP/fcZ88+lShrJuEk1Bve01Kwp5r8EhHRvIBjTnNEqA7/GUcSfNwDwdP
 vMWqOqNzsNN7Fld7+pXtwc+dPUVJSGcvC2zt0sLHnS3Rj1m/8Lc/skj2Jpvg
X-ME-Proxy: <xmx:Yjl_akckSEWGk7GlX-UvswX0bFaPB00qoLzZH8HoB-hVoTaqAHrwXA>
 <xmx:Yjl_ajL6T-di3HR9c7idHDKYzaypXvrAz2d8JIXxU9RyvWi4eUTKNw>
 <xmx:Yjl_ahKR187htOLSwzpmK95KWTV3AozHwg7LoDr1ZGUx15NyOdBxxA>
 <xmx:Yjl_aiV_9T50DadwUU5vsxbfxDa-eae3cqLfin1eQ1bypRLDEw3tWQ>
 <xmx:Yjl_aiuoMIszbS4L702yO_yux4gIfgIzWonbxUL53FZ5pH2io_xIaXvr>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 11:50:57 -0400 (EDT)
Message-ID: <d6664eb41fb32ff02503e5eb15fced34b52cc2c1.camel@alistair23.me>
Subject: Re: [PATCH] tests/qtest: remove trace output from k230 watchdog test
From: Alistair <alistair@alistair23.me>
To: Chao Liu <chao.liu@processmission.com>, alistair.francis@wdc.com, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: bin.meng@processmission.com, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Date: Sat, 15 Aug 2026 01:50:57 +1000
In-Reply-To: <20260813054329.35425-1-chao.liu@processmission.com>
References: <20260813054329.35425-1-chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=alistair@alistair23.me; helo=fout-a2-smtp.messagingengine.com
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

On Thu, 2026-08-13 at 13:43 +0800, Chao Liu wrote:
> The interrupt mode test does not depend on trace output, but passes a
> trace file to QEMU. This makes startup fail when QEMU is built
> without
> the log or simple trace backend, so qtest cannot connect.
>=20
> Drop the unnecessary trace option.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4126
>=20
> Signed-off-by: Chao Liu <chao.liu@processmission.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> =C2=A0tests/qtest/k230-wdt-test.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qtest/k230-wdt-test.c b/tests/qtest/k230-wdt-
> test.c
> index c8eaeaf1ae..b1131f42e3 100644
> --- a/tests/qtest/k230-wdt-test.c
> +++ b/tests/qtest/k230-wdt-test.c
> @@ -76,7 +76,7 @@ static void test_counter_restart(void)
> =C2=A0
> =C2=A0static void test_interrupt_mode(void)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 QTestState *qts =3D qtest_init("-machine k230 --trace
> k230_*,file=3Dk230.log");
> +=C2=A0=C2=A0=C2=A0 QTestState *qts =3D qtest_init("-machine k230");
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Set interrupt mode and enable watchdog */
> =C2=A0=C2=A0=C2=A0=C2=A0 qtest_writel(qts, WDT_BASE + K230_WDT_CR,

