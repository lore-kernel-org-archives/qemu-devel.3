Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FECAC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weRYp-0006Ra-UB; Tue, 30 Jun 2026 02:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1weRYo-0006RF-AQ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 02:03:06 -0400
Received: from mail-10628.protonmail.ch ([79.135.106.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1weRYl-0000Ts-SC
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 02:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=w3lbqtybwvg6fpdanrtbrjmrw4.protonmail; t=1782799381; x=1783058581;
 bh=vOl1Gf38XOmeepwgjSzzL2cWp/3Vit57m+T9zJ7nIdc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=KGIb2v7woLHggIWCoNj/wk8ZqA8ZA9IsX0JCGYzRTUkIQIO7sDZZBWjg6Q0+pDvbL
 e9ysMkbvk+rEylJ7ktTWNOuqv4IDZalmCBrem/+NVj5MsUI0aHX5afnDllsjz2CqKM
 qIi1swfGGpkw6Z87KExz/cAwVxr7wgN/1aPYWmlVecc5ZJfHo9UUM1LgeyEviC8naY
 STedA9v+KvOuOMYbe2Ss8ZOl4bYaAHchjxkpXZOuLNwLLgnE2OaeS0H8kaZIAM7o/5
 t/+gwouOLM68b/Z+EIclm5KocQKrPxk3b8D6P1RdgZYdyTiwtxLbu4GQwcs9bFD7dp
 EwUYw4r49lS2w==
Date: Tue, 30 Jun 2026 06:02:56 +0000
To: Markus Armbruster <armbru@redhat.com>
From: Christian <christianslima@proton.me>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] disas: converts malloc to g_malloc0
Message-ID: <ivgABRYgjCAvFEp6oiNyDgt4s4XO8EYr1VBiYPbuEzRH4UFDlpqPw4AgUlgFBb2AAKdw2EybEjNzoz8S4QPaJE2cUQjs48fm4BM97KPZ_IQ=@proton.me>
In-Reply-To: <87qzlor5j2.fsf@pond.sub.org>
References: <20260630005249.143976-1-christianslima@proton.me>
 <87qzlor5j2.fsf@pond.sub.org>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: b862abe60a5da50ec08839bca0bbcf351a732e01
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=79.135.106.28;
 envelope-from=christianslima@proton.me; helo=mail-10628.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Markus!

> Any particular reason to initialize, or is it "just in case"?

It's a just in case, the next lines initialize the values.=20

> g_new0(struct m68k_opcode, m68k_numopcodes) would be more obviously
> safe, because it checks the multiplication for for overflow.

When I tried g_new0, but the first argument is a pointer to `struct m68k_op=
code`, but it gives me an error, so I just used g_malloc0 instead. If I pas=
s just the struct as the first argument gives me the same result as using t=
he g_malloc0?

Thanks,
Christian

