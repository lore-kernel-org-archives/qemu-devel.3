Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46F1CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgF3-0000Rz-EC; Thu, 28 Aug 2025 13:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ure4I-00088J-GF
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:57:38 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ure4F-00036a-DY
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:57:38 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71d6083cc69so8996057b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756393051; x=1756997851; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=md8tVuCKnuH4m5IM/INNY6VAoMbgn42OEquOLVADy5g=;
 b=gdEc1MwNr93NmB8U9w2KJijLiIunptPZ/gF1ZECa7j7ws+PoMVEEQfp2brZsWNVl12
 H8vf2/8P79ipkUpKA6tparYbfkFqA5GW6uP18jBF02Rt5smcmbceopRGQ3n9OA8FAzpQ
 YU+TcWEIAuExLEAqdS/lNec4giji4o7LuzV3mFtzRfCFY50dX4eu/GjyparHSyC/wJW0
 zN+fqlQ3cX12839jU5KPVt1rmTTeVTVwvuaDe9HcdjpoNOI95xgyYf8Bs5PonEwJpwzp
 DO/u/Ltd/8itYOWu4agxJrEKp2gPfYa5tVarG+maGxsrFRGnfb4narxn9zjY5H8T+Ahk
 XS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393051; x=1756997851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=md8tVuCKnuH4m5IM/INNY6VAoMbgn42OEquOLVADy5g=;
 b=Y87Vp2OZecJgQk3czn3a2Jw+Lh8MIN5dJcPMdzefGHZa3hHvvcrCB+Vez4q16dZLye
 1zmPdrRhl5ScKlG8SGn9QsTes+udYG80B7s+prvtpy0O31i9kmgoXEngg+NwtZdd/z9Q
 Q7bj5905u86eaEkGNnYdaS3FYfpfddm6d64zaLYFwY+mCJdxOE9EUkCGFrdwI00GdwGO
 0DyXvekDy1QwXccO/9buQDGf2BcQdr6i+JxNQxTLoYqkEISpTdt7bv1XvyZ3tMPHHs6m
 0/JNoouiweUYVw+Nsf1FFbcXberIa9wMDUSpaAcHK24uWXbxeJkanE4qgnLgv1mxFJs4
 IvRQ==
X-Gm-Message-State: AOJu0Yz8Nc+7rW+92ZCXYAsohSRZqrZNJvb3xmyCnZe7yTCS8eEz4aI+
 HH5nsXLtFVPrNLXwjuHcDaQ0VIHeM/rDlTzkM/XoWbfYB+LXs9kioyNu8N6UzEehHTdFA8My2XQ
 oK3wmcOLh5P9/FIfQArqP1SOfsq1bBDYMkxaMT4Is4A==
X-Gm-Gg: ASbGnct1Ji39eqGof+Wz4kbrySO1G75uxNsjx46E/MkNxmvHV0XgAAGVfVdRNx0r9b2
 hxmsViGskP+Fan8SK/1Ev5xrUMYEClmVm39+18wZ3V/AKqKdrLIvs2ByY9XW2QxRpng/Doq/Wmc
 aqqlFX3B8ItXoUH79EqEnxW1x0S8UgX3IBzSlEPV3v03a1xwXE6VGxqkNk0iaQ/SVH+FDXptxv5
 fMf8odcb2IJTN6G0DY=
X-Google-Smtp-Source: AGHT+IFSpySfdmDwU+75vNVyYTihVWN44+NnYwjDY5/5WIPP53z6O52uz3PTSTDtE6FhUqAieLHIR9UkoXXbdX5/C+g=
X-Received: by 2002:a05:690c:7286:b0:71a:f22:28fa with SMTP id
 00721157ae682-71fdc41d88dmr258083427b3.39.1756393051543; Thu, 28 Aug 2025
 07:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-46-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-46-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:57:19 +0100
X-Gm-Features: Ac12FXxFMiyij9P5CkF0mcJ0H3Tw356sdy4d1d-XoTHsQ8pTz6TrDN865QYR_IE
Message-ID: <CAFEAcA8cV9NLgnLw3Vnn8VsUXnbt4=CCbLEE8vA47mqhN-yAdg@mail.gmail.com>
Subject: Re: [PATCH v3 45/87] linux-user/mips: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Thu, 28 Aug 2025 at 13:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the target_pt_regs structure from target_syscall.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mips/target_ptrace.h    | 17 +++++++++++++++++
>  linux-user/mips/target_syscall.h   | 19 -------------------
>  linux-user/mips64/target_ptrace.h  | 16 ++++++++++++++++
>  linux-user/mips64/target_syscall.h | 16 ----------------
>  4 files changed, 33 insertions(+), 35 deletions(-)
>  create mode 100644 linux-user/mips/target_ptrace.h
>  create mode 100644 linux-user/mips64/target_ptrace.h
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

