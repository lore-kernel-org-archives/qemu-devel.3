Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42B8C44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCrV-0002Iw-LI; Tue, 21 Jul 2026 11:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wmCrT-0002IN-I7
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:58:27 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wmCrS-00053x-2A
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:58:27 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69a5ecbbfb2so13311346a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784649504; cv=none;
 d=google.com; s=arc-20260327;
 b=s9J8lv6OB2KUlc2d8UsM3BF/hXtR+e1QpmhPoMWa4T+y/LH0wcx4/GJk+a5yovfsoq
 OfXL2TDg4p05gbUZDkkyrnV1Ioc7CIKNQVnHjmWaYtPAJf9mY/mR5a0HyKNzgfmdlCCE
 A7zrIp0PN9hdMCp9RHt1Q7RG03M3EAKQzrJi6H7WzzkoV/50FiqpqR5wdi8VfsQBKqQx
 xFN7H/CH3gZFYh5B7/fNIhaK5r+cgtHjie9jjYeeRyQiQlZbohzRnWn2oLt/GCUGKFL2
 JeljAoNY8xx9eZwJH0+lN0eghydqcLrZ6L2b92n1h15E8aHuJmbeQ3TlflsfgnlsvWFS
 UfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+6r8HDziIk0LRW1IUXxJDSIlpxujQb15h2CQEkqB2Ac=;
 fh=Du2SvsMu45Pf38hdJ7+zZL9PFJ+eba3qOwo3oiYGPYA=;
 b=RnRndBi9Vpk3yHbcyBA+IWdV10YkBMvRJp8wPGztSxq3+JO3GQ/TQoNDvrjIh0lzZQ
 Gc5mhivaNWwGSUQUdeFDkmKgW7OCly/o+Rv+oEz6cwFXIKVcAK+DNBsREEdkKVrXw0iS
 KcB1emt8ufbZ3jT3AV1mJb1Na2Exjj6gyJPFqqrdHqSRrDl1m9V62bg91HJLLmywseCs
 K5B2S7MR6nIZGjnj+eQMnTN0Ft5YabHiRekeqmUMGQ8JoFViUlIEQ0/Qil9WNWJW7drl
 m5N5NHVJBicoCa1hG4xeof1x7FyfXpVwr5NCGHgitisteYaLsttnhpM7fanXJWcSZv+P
 NDow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784649504; x=1785254304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+6r8HDziIk0LRW1IUXxJDSIlpxujQb15h2CQEkqB2Ac=;
 b=q4ligDupm6R6+R6DOLM4wbp39Ts1Y05zLhLznCrMlDeI1MgJFSiI3HDpbuimxBNXRh
 7UikNSbeyGVcYmHNO8ipZeIMeGPH0GJWPlbBaRe+9zrTrHAgmpYM7JmfCLjbcyKPKzp2
 fZ4CCjSM+fqLo8fXk7JgcaYexy5/nmoSvzKdgh8xZB/a0KxPNbzK9qL7A4kuMzE8eRPO
 PkadoKjP6kyHheZ5x+2fCqovqtEqk0Iub41utqf1PXXoOeKP7YoKqRULL5ullFeTO4VT
 3/tc/ssIbxnS2uz7X6oDvFax4mQVHa91KEx63Qxqvfi95hxGyM3gp8FwEel4d1DnhALr
 aPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784649504; x=1785254304;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+6r8HDziIk0LRW1IUXxJDSIlpxujQb15h2CQEkqB2Ac=;
 b=WS7/JcGsd69WEJujEoHsgYe4v4z6Ucpb4hU+EsaUbhXwpJfY4c/x6ppfBFe3RXKNbL
 NPw27BENqhbuvRxRc7YRkPXWbTXUUpFwGe7xtuvQZ+Wkd0mjcQvGV3igXdfnzLDWSA+H
 aVdyAyjelReeQh850qxb14WzQLc2tAfESKr9D4h5JgaOKRmQQ58qwGmrGvAOWs4LmUCu
 Uyd0Nm48IuZoEa9oXctu73NOzFGtmTlFAfMR9GiIlLKNOdHFGqhaKxeGfZNnDIOPUYbY
 FqNou1RpMv+uvanjWM479IVj14q6Yl69/Xb034T6aSE3ore1lZ+XyF7izStvTikZf8In
 1GIQ==
X-Gm-Message-State: AOJu0YzwgI5yqCgT1ReMkDR+9TCVc243KSgZZyq8glS9aCG4GfSMvbzG
 45hjr3UZ60Wiux09ohm1BrkubNOkQRGoe5G/1tTsWv+ODoNh1Yj0RyOp+ZtDgJSSHxEhIyx6NHf
 Pd5DPikHM8zsEX/7XDAzXgvTsuFlNPb8=
X-Gm-Gg: AR+sD13uhkh6/kXJQgt9m5atPK5fUhftXllrakg0hmKm88Z/1FPPilY/UGs72Z9oXsd
 wWecQX80BqC94QbS9xo6uiFNggkifC6AhDVTNnb61m4ufVWx1hijJOsOiPOwSOG0K6eBkCyaADD
 YMFQhhjaBpjz3X28/OJblii648P9K6AUqyW2NN9EdZNh0FiPfjZ3+mrnCCS9tXJUcTl1Mu+c8uA
 nRsfqVWg4FqxHdbnwZTjA8qm9+wDNgHmxtSiLnC8X/Ie6jNL8CiIfWMuT94TSxiMVfkkN9IGsMO
 Trpk+7n5e4yrtnhmTSTw
X-Received: by 2002:a05:6402:5287:b0:69a:9355:ec36 with SMTP id
 4fb4d7f45d1cf-69e6534ae07mr6457238a12.42.1784649503654; Tue, 21 Jul 2026
 08:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260720222717.33078-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260720222717.33078-1-pierrick.bouvier@oss.qualcomm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 21 Jul 2026 11:58:11 -0400
X-Gm-Features: AUfX_mzaSiMpkh_tzBCmULsIAZG_05bQEZGpWtg0rbt5GB0iDB0cSeFrmaY-txI
Message-ID: <CAJSP0QXGh6VqapJmDR8TLC=1M1Ob1GE7GLX8LZUNc3wkkKFVpA@mail.gmail.com>
Subject: Re: [PATCH] docs: fix sphinx build failure
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Jul 20, 2026 at 6:28=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> We recently started to have those failures appearing when building
> documentation. It's hard to identify if it comes from a python, sphinx
> or sphinx extension, but it blocks us.
>
> Exception occurred:
>   File "/usr/lib/python3.13/multiprocessing/connection.py", line 399, in =
_recv
>     raise EOFError
> EOFError
> The full traceback has been saved in /tmp/sphinx-*.log, if you want to re=
port the issue to the developers.
>
> This seems to be the generic error message for "something went wrong in
> sphinx multiprocess":
> - https://github.com/sphinx-doc/sphinx/issues/11449
> - https://github.com/sphinx-doc/sphinx/issues/14458
> - https://github.com/sphinx-doc/sphinx/issues/8973
>
> Solve the issue by simply going back to sequential builds. We didn't
> notice a huge speedup anyway.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  docs/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Michael's reply suggests there might be other factors involved in
these errors too, but there is no harm in applying this patch:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

