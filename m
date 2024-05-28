Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3DFC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzTq-0003Qt-Sj; Tue, 28 May 2024 12:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzTp-0003QQ-KC
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:15:17 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzTo-0001i9-4U
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:15:17 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5766cd9ca1bso1416586a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912914; x=1717517714; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GukKbc5tV8LtZIe9Cz4pP9VS+Y0KkH7EySCSlImjxxA=;
 b=pm3agyvG3SHmFFrgiVZPzJ/ZYLMB6Vkz1/adOQaffjrbH9qvkzSDebfSqTKatS+3qs
 kwlwFBRXYs8SQiThJST4/xTFHcieFo7LOzF2CJrXNE5VHYFYrZRv5fW1NPM1KzaFEjSz
 QHVtKsyPtRNPU/Ub6hPqcVtWb9E2BVmUf+fVuJA/Lf4VbJ5MZ+XU058/XAhdijsrKaPG
 rcGmTrSURHVLOhV8qpx2aECGUsaekrcQMfDJbqYKOxE80b+XdarPsz+khfDCKFaNkWDc
 Cm5WFs+XRRxWdb5cUOsD2m/8S++LhMn47Fhon5aRyy5BsI0KSh53HmfVODF4X4CjcHQs
 QqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912914; x=1717517714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GukKbc5tV8LtZIe9Cz4pP9VS+Y0KkH7EySCSlImjxxA=;
 b=E6nuTd2dXdmAPHGSXyacfOfCAtPUPXkX4twHE9qkv1ecK1nzNFfu+PHptyPhxtUdq4
 5VrN/Q9kD0SagtU2co9/YIg8BdZ5helrSDGIkmg05mzcW68tOHjAGky9hSfZddvOWOJk
 gb9zwuYLSTpRaev6+y+S4yq78rBNh9ZgOqlPhr5Avrsl/NG6Bntv2hhopoLscBeTsSC4
 Dfk2SyCuw63i4ZEnMft2WE/0iueqMPrJ0hT+ZNMtIua+w0MVELlo5kdmpjzrvQTb5eaj
 DCE+xJ+bSAplYpfEDK3bJNe09xAyHoXUi2kThjXT6Iw9IyevP1bRbYrGGXBa9Aly5gGy
 FD/w==
X-Gm-Message-State: AOJu0Yzp2EH1zWdl7RntHGACoahV36W1BlcoNvpTcjthE8j6ZCc9dqR3
 JvyIjsSuQQvWepcZ+VQY8qLPM9pLirhsRgsa2Fc20CEbPaFtVKLMICWqPIGe3Z6c4w+Ko73bNnk
 r1gKKDopVXvSfeASr0tI7zIetPYUphA3gwSKNMluje/qxgkY3
X-Google-Smtp-Source: AGHT+IHxicSgoUGZ/41sb0r9tiDr9KkPUak+xE1iZH8fOlRoDRPAUHQBTbIbI6BVNQbNO1ROUqhTAniG2Xnkgn0sWdg=
X-Received: by 2002:a50:9343:0:b0:579:e7c5:1001 with SMTP id
 4fb4d7f45d1cf-579e7c51a1cmr2611203a12.23.1716912914347; Tue, 28 May 2024
 09:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-67-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-67-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:15:03 +0100
Message-ID: <CAFEAcA8tSj=5QNBKb72iZ0fmYRBGf7QjpK-0YtpbF5sdBMffxQ@mail.gmail.com>
Subject: Re: [PATCH v2 66/67] target/arm: Convert FMADD, FMSUB, FNMADD, FNMSUB
 to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sat, 25 May 2024 at 00:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are the only instructions in the 3 source scalar class.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  10 ++
>  target/arm/tcg/translate-a64.c | 233 ++++++++++++---------------------
>  2 files changed, 93 insertions(+), 150 deletions(-)
>

>  static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
>  {
> -    if (extract32(insn, 24, 1)) {
> -        /* Floating point data-processing (3 source) */
> -        disas_fp_3src(s, insn);
> -    } else if (extract32(insn, 21, 1) == 0) {
> +    if (extract32(insn, 21, 1) == 0) {
>          /* Floating point to fixed point conversions */
>          disas_fp_fixed_conv(s, insn);
>      } else {

Doesn't this result in the unallocated-encodings in the
fp-3src class now falling into the "else" clause and
being mis-decoded as the wrong thing? I think this
needs to be

    if (extract32(insn, 24, 1)) {
        unallocated_encoding();
    } else if (extract32(insn, 21, 1) == 0) {
    [etc]

thanks
-- PMM

