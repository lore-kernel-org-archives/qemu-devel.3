Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62531C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeSF-0001gh-BB; Mon, 23 Jun 2025 06:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeSE-0001g2-2t
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:31:10 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeS8-0001hX-Tz
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:31:09 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-710bbd7a9e2so36388717b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750674663; x=1751279463; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k9danHCazlxLRDSXgDmpGwrbZR8kAcJpkJB8ms1wbno=;
 b=zZOhzPVPbecfDwWbejMIHWgNfWB5gmGAx3hme/q3Cga/V9EsIrlnRt2a8TNbwEfrkH
 daFU+uvnTHTAgHJ6YnXUUX14kVpjFJ0DMdOV0tsBKlQdgg+c9SM/UmOgk1YKatzQmKqJ
 JXq51tmVXMA1IaV07bvJWEsu0HlFgnbp6gsSVjfgJP+upOv+qSEcTrkQZnb9ikmhkcBj
 VgYraaYYyXE3IJWm0BocSm6gdW7c7c2+p0bygRm3dzkqqu6/YIA3gtZGqLpS6wE9LfxE
 VGtC41zhNhV7ZV0Wu0aJHfuhirf1MkwA5HZbUqmc89/gfEo74nBMfH1m+O1Aa/rDYWsN
 e6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750674663; x=1751279463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k9danHCazlxLRDSXgDmpGwrbZR8kAcJpkJB8ms1wbno=;
 b=Syjo3CphZttvpNg7gWwaE6ymsl/qNn0E7vEsGBbF66wyDCbaxVP6g6r6EYNXWJl8DC
 P7lcLbhlrySWPQuBZiWJwmJBvM8V7k3zMORbBSpzlm/EIJNUqAY4hPwN9rtl3ZXqEfNq
 0qCHiC4r7XKZJRprsag1FoqtpXlfZZCyM/kuk2DIDM0+OAcq5jPinUVQgTYed2Ph/LD0
 z9WENn7HWo1/hJx5N9keTRjSD0jMBWsYeusebywLRyDlZLXb3AboRmjCGgFwmHuxBaXe
 VbgL3kO7rBiXu0K4bEJdXwHQQRbSiwBWSCU/Xk7PrBEQgQLBHumKATpo/VBFhdnW3wzc
 yfCA==
X-Gm-Message-State: AOJu0Yx+yZEioogYXyTdcMNRwCLgjsTtYRgQaD4edRJxARS5VIVESFsT
 I8lPjvQf/zJq3Q7Kksc9fCdwIcIFxt8Fiv8vQGtuWorquFWr88bmgr0KNmNbe75+hFieN5WakfV
 o/IUC33UAfTKjvMaHXg2NlIebO/lLtzeBdmKq/BR9Qw==
X-Gm-Gg: ASbGnctjAWdQQc/iLH5bu39fg8/b/5kkbUxCm95bmdfTj4pF0zB+8N6pfIktlda3Csx
 RiqXpiPb2V6fHhpGUmijMTkDEOSVpGscy+ls7ZcbrtlHzB4YZ2LzBZDB/RLTCp6eXh+1k4pMBdd
 nLmJSttDgQjlz5zUxm2Tv/M25cf4/r3pGtpHLhdL8Nbs72
X-Google-Smtp-Source: AGHT+IF2Idx5NNqGMUMvpF9dMfSUjj3i2XAl3/e45gSYi2/uCkmSOSfhUPFeihywQ138yFD2srBRT/TLe+oYtSVnz3I=
X-Received: by 2002:a05:690c:a0a8:10b0:70d:f47a:7e21 with SMTP id
 00721157ae682-712c6311a2emr121478707b3.1.1750674663352; Mon, 23 Jun 2025
 03:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-13-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:30:52 +0100
X-Gm-Features: AX0GCFssc1oAMhY7u_0AZIh1aapz_SRpJvrNAJSId2IS4DszQSn9QaAqGuobT1Y
Message-ID: <CAFEAcA8oCZ_6anANDaa3XNqJopyb3CBtj-2YJ9JZjUXSvZvHvQ@mail.gmail.com>
Subject: Re: [PATCH v2 012/101] target/arm: Introduce FPST_ZA, FPST_ZA_F16
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, 22 Jun 2025 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rather than repeatedly copying FPST_FPCR to locals
> and setting default nan mode, create dedicated float_status.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h            | 12 +++++++++++-
>  target/arm/cpu.c            |  4 ++++
>  target/arm/tcg/vfp_helper.c | 10 ++++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)

We should also add FPST_ZA and FPST_ZA_F16 to the comment
in vfp_get_fpsr_from_host():

    /*
     * We do not merge in flags from FPST_AH or FPST_AH_F16, because
     * they are used for insns that must not set the cumulative exception bits.
     */

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

