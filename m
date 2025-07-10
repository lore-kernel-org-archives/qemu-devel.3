Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB0C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZpwB-0006h7-03; Thu, 10 Jul 2025 07:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZpw8-0005s4-Qj
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:59:36 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZpw6-000556-F1
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:59:36 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e8b3cc12dceso634076276.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752148770; x=1752753570; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YfMnil2xhEmv1j0PSh2ZYBtfhQluDz2tH/9qZnzD7Xs=;
 b=Z75Rh65hjp9/VkrImgwsxO9wnVRR8P5Q/E5h+m2pricjsHdXjUER1RVghL+QMJKYFs
 ktnBfBS8GWF0Nfj6Np9W3EZEcuNt9WTdGk2LWfoG+ciY0EHOCiow687W415cbS8NWOj/
 wqdobIcdwjPu9fh8nt40f6T0IyMGbt+ajXC9jffwCnSbCgkHHv90LrrAhWZTVURloGvu
 kAGFATOICi2P3KEWgAyTQ9Bbhd0iWI6tfv6no584LeejPpEY6SF64aGdps4TIPRzjVlQ
 mBPDHSWbgBSgdK2uexNkcB2k4DKnUvi6D+412gDuWlyZYwNfWH2dELQDbJH3tEaw4cbo
 lffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752148770; x=1752753570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YfMnil2xhEmv1j0PSh2ZYBtfhQluDz2tH/9qZnzD7Xs=;
 b=jA4h0oo+6/vTwt78/+5BXrwUaxKtmlkeeV+/CufptdRNKoAkq3Rg2eoEl/Y9MjYJ9j
 zDbFGxfUw/32BQoxScPSCbmIvI4jKeEBB28McOhjC1TmbO0phK99LvKAlJg605fi8Lja
 o9nKxzPLdJFlwa/uKn4OLFk1XKfbD2SlFzoVz3KcHlWRLSMne/Lnp8CxOWwcZJYF2R0s
 OF3NUCZIhJXOR6/K2RrAqddgOZlOB9wUPGWuMbE+3Bod5XNorREpuXadcqThQNMSdG9u
 +v2d4AC8Tyg+jPdN92zZ2BfXHdQcYrvEqpfS0rp4ybRvS71fXsgzvJ40AhCnP9hA5nLq
 ZOUA==
X-Gm-Message-State: AOJu0Ywib+uK/nZMSmLm9fAqre9NPhmaNNY2YOwfFTjXwXzhOPbU3GHY
 4CtLQK8VQzXE63uX4747zInnTuSRUQRh33rZJZ/8XTFYz0mbhpE9OxdAup7HVppPRnAbTtK1oWk
 lbybOf8CqwR7SneGnJT0PLw1g9kwpkR0MmWi5zNX+ES/Qc0OpHA1l
X-Gm-Gg: ASbGncsdVg1OLClW1VlM6ciV5Iezbb6ios+ExDkeKNn0CRvH2dW7uM7ZIjmXitk0A/0
 r5EP89EHuvMbd5+7jCmA6gUytw672Yn8A53mdkjPsE4ZHxVQ6nVoOm4QadPOX9J2aSd2V10xAgw
 V+fMvp10j32KGHBt5gCMCgqrYlknLGhzhNu79s81bjI4Ah
X-Google-Smtp-Source: AGHT+IFc4by//U1sCac6vikwQwVdpi0yBp0LDOx9eqqeVIiwYDOidyFbIvy3rar7rOSZS+S2Y8GzX2+3Pm06zc0hiiU=
X-Received: by 2002:a05:6902:4790:b0:e8b:60b6:bd2d with SMTP id
 3f1490d57ef6-e8b7a356f22mr2870470276.12.1752148770269; Thu, 10 Jul 2025
 04:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250707202111.293787-1-richard.henderson@linaro.org>
 <20250707202111.293787-4-richard.henderson@linaro.org>
In-Reply-To: <20250707202111.293787-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 12:59:19 +0100
X-Gm-Features: Ac12FXy89eqVMrVwxsb_zdNZRMjIzKD4n-AGVvN2kH3ZnO8ri--f-1pCKsPO8_8
Message-ID: <CAFEAcA9UcPCQ5qqrM+Ao5hrOJ=xYgOJ6==WNDj0xPpr2qh-TfA@mail.gmail.com>
Subject: Re: [PATCH 03/20] target/arm: Convert get_phys_addr_lpae to
 access_perm
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Mon, 7 Jul 2025 at 22:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/ptw.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 39ecc093a5..7503d1de6f 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -1643,14 +1643,14 @@ static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
>   * @env: CPUARMState
>   * @ptw: Current and next stage parameters for the walk.
>   * @address: virtual address to get physical address for
> - * @access_type: MMU_DATA_LOAD, MMU_DATA_STORE or MMU_INST_FETCH
> + * @access_perm: PAGE_{READ, WRITE, EXEC}, or 0
>   * @memop: memory operation feeding this access, or 0 for none
>   * @result: set on translation success,
>   * @fi: set to fault info if the translation fails
>   */
>  static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>                                 uint64_t address,
> -                               MMUAccessType access_type, MemOp memop,
> +                               unsigned access_perm, MemOp memop,
>                                 GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
>  {
>      ARMCPU *cpu = env_archcpu(env);
> @@ -1678,7 +1678,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>          int ps;
>
>          param = aa64_va_parameters(env, address, mmu_idx,
> -                                   access_type != MMU_INST_FETCH,
> +                                   !(access_perm & PAGE_EXEC),
>                                     !arm_el_is_aa64(env, 1));
>          level = 0;

This will treat a "don't check access permissions" call as
a data-access (relevant for TBI), and means there's no way
to say "do an address lookup for INST_FETCH but don't do the
access-permission check". Is that what we want?
We should at least comment this.

thanks
-- PMM

