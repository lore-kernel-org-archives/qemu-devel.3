Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72762C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 12:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tckpG-000820-Lk; Tue, 28 Jan 2025 07:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tckpD-00081p-Mz
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 07:36:15 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tckpA-000346-H9
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 07:36:15 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so9299894276.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 04:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738067771; x=1738672571; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EYQtGn8Frdt6ov9MABghxQ5rtLtenhTGcKtOp7YoKaM=;
 b=JW9URmngXsF5kkrXZDQD9r2SSOxNcaLQMoyVVYkonDHInQaFwGCHEvNi9tMPqk97Cd
 B3x1jgxQye6+PCAlVCCoI0HFsUBfoiKxyqsflY539IpZmLnQwvJQLS8l134SpBQFf+Uf
 rOdD3IS0QM6zUM/f+MvgaYZuPzyNu4+uvIj9iVlRTvtu+Xw1zspbYSNvPSMXZe00tsRI
 zrlxfsNaLb+GO5RUED7VEAHACE2z7kpR0WBgfarA7tds4QKHylbpGoT31EI5dkDl1jJO
 i/XXHOGA/zjJheDh289o4dm8mRqh9RqBnurKaf8tg3T8VfwxdSdQkqD/cTHhZYRKDvbz
 m42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738067771; x=1738672571;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EYQtGn8Frdt6ov9MABghxQ5rtLtenhTGcKtOp7YoKaM=;
 b=PGX8Ozoor6YK/TB/WO+ruR18MLE4vaPm4J4swT65OOcV99BjsZsh+mcRO7XwNGaKUW
 vIwe/3E3t14Jbl8BN9GhbWVfQItwjWJLlbGJkmZLXTGVhanjRrze5jkNBiarcbHsHj2k
 zuneu3WsE0uJflny/ucAl/Pv9EMLT2qQVV4rjuT+S0ODEhW/MQSsvkHpsHn+xqdM8I9I
 VvBLYBsoyKEh06KfizGwtVYvrFQt8bzi69x8M4EtRGfB/nuisLfWklfe+dmr8KmcqLMg
 x1zOs0zGAMxD/AV0ya1C34VYCwnttqXLkPVZU3xVho8G/zYINxcYTvvwmeWEChlZlzZA
 gKFQ==
X-Gm-Message-State: AOJu0YzZONltGIine42jOv+eIN+qUOjr33Eoce15ewZwwa+AEB7ekWiL
 VYSRLs+3l+aAuyyN+ICowsf2BjFhFCcnvug2HtGWps/XmG65YnASIB5dQnccVywrMC0W44T9Gpx
 Z72FWfWalC24WwZT5Ljnq9ZdecWnVM4wFklJhSA==
X-Gm-Gg: ASbGncvriji9bznQCBAmf9bkqqdaIk/+oN7yUuEPycTYMcHZVvKuFX9axDGkdoOadhG
 atVj7T3A6HIAYNn+CqdFNjeRJANG/yenb7YzsZLz0PAuEmN8IIFKia2C4UFVtZ4bYHMs7gwDAjw
 ==
X-Google-Smtp-Source: AGHT+IHtfUjNxndFDEGUJY7vZH1Aa/H9C82dXONz9P2FdPTWTsGTuW4YUpZdoai5swvvkQ1qZRW4juFh9a1KzGg4Xds=
X-Received: by 2002:a05:6902:1683:b0:e57:f5a0:85c0 with SMTP id
 3f1490d57ef6-e57f5a08b03mr24788000276.43.1738067771047; Tue, 28 Jan 2025
 04:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-8-peter.maydell@linaro.org>
 <05ed4583-704a-492c-896a-71bbd4a63a12@linaro.org>
In-Reply-To: <05ed4583-704a-492c-896a-71bbd4a63a12@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 12:35:59 +0000
X-Gm-Features: AWEUYZlx6JenynU-LiS_Lnk_XfNDfEmjmA3eTPIOk2hThxEHgX0aCMPfiLZzJ3M
Message-ID: <CAFEAcA-qC_osUrdhFzsd7bjv1R54UwiZXrF3sQ=aFHm8k=NkQw@mail.gmail.com>
Subject: Re: [PATCH 07/76] target/arm: Use vfp.fp_status_a64 in A64-only
 helper functions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 25 Jan 2025 at 15:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/24/25 08:27, Peter Maydell wrote:
> > @@ -2808,7 +2808,7 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
> >        */
> >       bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
> >
> > -    *statusp = env->vfp.fp_status;
> > +    *statusp = env->vfp.fp_status_a64;
> >       set_default_nan_mode(true, statusp);
> >
> >       if (ebf) {
>
> Is this really correct?  !ebf includes aa32.

Whoops, yes. I'll drop this hunk of the patch and put in this
patch afterwards:

Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Tue Jan 28 11:40:13 2025 +0000

    target/arm: Use fp_status_a64 or fp_status_a32 in is_ebf()

    In is_ebf(), we might be called for A64 or A32, but we have
    the CPUARMState* so we can select fp_status_a64 or
    fp_status_a32 accordingly.

    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 011726a72d4..2ba1f7cb32e 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2808,7 +2808,7 @@ bool is_ebf(CPUARMState *env, float_status
*statusp, float_status *oddstatusp)
      */
     bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;

-    *statusp = env->vfp.fp_status;
+    *statusp = is_a64(env) ? env->vfp.fp_status_a64 : env->vfp.fp_status_a32;
     set_default_nan_mode(true, statusp);

     if (ebf) {

thanks
-- PMM

