Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2931C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 11:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcjN8-0005Xr-QL; Tue, 28 Jan 2025 06:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcjMk-0005Re-4Z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:02:46 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcjMi-0008Sn-Jx
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:02:45 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so7820388276.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 03:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738062163; x=1738666963; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V2I2NjmN3Mq2+zaxHECDvWFrfzR/EWpUa/NXwTC2lBw=;
 b=nPSdM2G9VoXayD/3KcTZAs7ngw8V+NjPTRt7ZJ62PMJY/3qj8l0gZH9H6ys2U/COE5
 5LHcsITF2Ogc7SpNRk3aUoTeE6Znu1tVtBgT8JK/d8PUupwJljRifh+e1/cwlEyDMbBM
 8COMjW2qL6QfInlIZ00Fkm0gc86Dk+LaRL4UEgNuWuMneVIBtAeqGjlBkxUO8653tq/Z
 Lj5fKebz5f/cMdJI6yzZu9GqUkhPiKTtpu1wDChP3ujHcXUaDxOkKGdpEJHiXiDzcpmW
 oTOOF9lcnolsMOxtW6Ev1eAua1UpQCN0dzmjw303rLlzEWG9O7AjFgIsNWAbj8OYwX2s
 slxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738062163; x=1738666963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2I2NjmN3Mq2+zaxHECDvWFrfzR/EWpUa/NXwTC2lBw=;
 b=MXWnxZvDgdK+NvFeP/rSYG/UQBXmjwy/J1K/y31Udj475SgjY6moBA/+kMuip5F3A4
 MQqnjrhLIY1xXl9GlZ07vgyfVLY8CA7EOE6sVmvHcWT5TQnMBJ9e9siu2kTh4diUIvBy
 bPyc2rpQcy/bRTOx7ElxWO6s6JWEBtPT8tzjARfGWWa/Vp7cwvBkqZzfnpGHe8j1QkAp
 Zq8apXI05QmcYAzDiT8K+bjLY2ZT716x10kUKHy5rEIX1hdNQlEllq1mZvuTsvTLubnx
 HEIDs3a9H6LjvjALIP1wcb4CxNE32s0pKwM0pwKQgy7rdLwaPyc06rh0YuTPwI7UhT6h
 mH7Q==
X-Gm-Message-State: AOJu0YwgFNEd6e8GtKLY0E09tKG3S5JghUQCNB7jlJkFiG6ZtPANizuy
 TiapRyXip5GNVvC20L3CivrY1lx/zIkTxyJZE1m58rZKyZcV5Cx75u41hQyY8EZBFxjpz7A0G3l
 lKJPGO0GIGBLQRp/f1jgmukLpRZqB8xnKeUwv9g==
X-Gm-Gg: ASbGnct0jek26Jbpy+uIMXDOJyexwplMpEOfqgIwDGTBvGvbnGZj5QSnzQzOXbzt3XB
 9+8gm1ML8QcxoLDGu2YfoVkNWvIKbSRzKzreLBB344ioSrzVXAxopQKZ4rkcznkRO9SD7fR5Ohw
 ==
X-Google-Smtp-Source: AGHT+IH/krcDHFxqG4g8kqykLnaAt21ebyPiN/u/0FHhOQf9xLaFpY+5dPcR8fvfOV6z14MXuX3LQf8x59SZV873lhk=
X-Received: by 2002:a05:6902:72c:b0:e58:32b4:4866 with SMTP id
 3f1490d57ef6-e5832b449dcmr14727103276.25.1738062163125; Tue, 28 Jan 2025
 03:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20250127232604.20386-1-richard.henderson@linaro.org>
 <20250127232604.20386-2-richard.henderson@linaro.org>
In-Reply-To: <20250127232604.20386-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 11:02:31 +0000
X-Gm-Features: AWEUYZmFKLyyX3nrLHgttrWoWZvbCOJuRJ0yA24pa5A78USgOfr-8mV372KHqwM
Message-ID: <CAFEAcA9Uy9=rWXNYiWoXhwyhDu+6p162_EKTX3kksBdmmvBwcQ@mail.gmail.com>
Subject: Re: [PATCH 01/22] target/arm: Rename FPST_FPCR_A32 to FPST_A32
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Mon, 27 Jan 2025 at 23:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate.h     |  6 ++--
>  target/arm/tcg/translate-vfp.c | 54 +++++++++++++++++-----------------
>  2 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index 59e780df2e..6ce2471aa6 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -674,7 +674,7 @@ static inline CPUARMTBFlags arm_tbflags_from_tb(const TranslationBlock *tb)
>   * Enum for argument to fpstatus_ptr().
>   */
>  typedef enum ARMFPStatusFlavour {
> -    FPST_FPCR_A32,
> +    FPST_A32,
>      FPST_FPCR_A64,
>      FPST_FPCR_F16_A32,
>      FPST_FPCR_F16_A64,
> @@ -692,7 +692,7 @@ typedef enum ARMFPStatusFlavour {
>   * been set up to point to the requested field in the CPU state struct.
>   * The options are:
>   *
> - * FPST_FPCR_A32
> + * FPST_A32
>   *   for AArch32 non-FP16 operations controlled by the FPCR

So the reason we had "FPCR" in the names here is, as the
comment notes, because the original distinction was
"operations that use the 'standard FPSCR value'" versus
"operations controlled by the FPCR". But I think with the
profusion of float_status values we've ended up with,
most of which are sort-of-but-not-entirely controlled
by FPCR bits in one way or another, that the "FPCR"
part of the constant name has outlived its usefulness.
So I'm happy with renaming these to be shorter.

thanks
-- PMM

