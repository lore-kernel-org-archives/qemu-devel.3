Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3315C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 18:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsnNt-00075p-Rv; Thu, 13 Mar 2025 14:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsnNs-00075R-5z
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:34:20 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsnNp-0002Nw-7m
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:34:19 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so1335140276.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741890856; x=1742495656; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o9H+iuk78YKeVjgBFFsvFrdQ4G8MqOtnjvCrBIEMBvI=;
 b=naYf+zB+ZFgPWSV0FEG+VldR5q4QRbwFLGWUBnly213lFKi1pcVLxyuhpoC/iVnKsp
 8vOsTILvezy4a0WCDeurXb22ZCMKfLrGg0qcZa1Nd6I6kRz2V3dYsTQeWaOtsbxozv3c
 nYJcjGA1NT77dY6PmKXB/t/HAsKnNZAt0E4ATDpY0nMvvHKCS220JPlobQ0HO/vweO8x
 uPbotoxMwp+thlO6QtFRDVdAESayjWgnwjSgXLRyk5wCz3Fndv7WwI8O01i4CbzBySL6
 eCzGHpsEbDZU9BLi+Mv+dvC7cj7o6vZCU9urkUOZypV0KeqPGhykPUSlk0cpBDGc7p63
 8PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741890856; x=1742495656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o9H+iuk78YKeVjgBFFsvFrdQ4G8MqOtnjvCrBIEMBvI=;
 b=ovxnexrb2JOLq4DoeU56DcPWC6g02NIZE+E0R7+tDar0t5HQe3hsZ+DLAJHOwx2ESB
 zLakB92P6udYXSzymqdo/xFg0tyFc7POfFCP1TkRtVG6YWQ1M1HTrBmI+sPu0E6Sy5em
 GTR16Xho5fUPn+9B+fKmqKjkZPHcMiotE1tqeOzv0xhQHbS/X2sDPE8L6pailuSsxBS0
 zmbbY3dlDMjXShtygL3G5NhEo5C/KIYeaz8d3hGg0PTVcvXLh0PivV7oI4sQFc41vBjA
 CcHczRygoQLWGvflsqzjnyL1+amnLTpcc5Fw62jz82MK4FW96lF/DA+kpLdqlkzy/O3D
 iLgA==
X-Gm-Message-State: AOJu0Yxloj/BaotzX6GDvqkywxod5egTYeYdvbBlwGF1x/njyuZuRcgP
 dxII+/T/z1X9kfI8Xa7ARAPFyRf+UOJHbY0I8r/TiVekja7ceqnXebLmYRG06wS3CemF769cBYo
 8j+k672LXAIh9ppN40XKAMH0DgUjJuxi1UcSAYQ==
X-Gm-Gg: ASbGncv7ciC5xM9Hue9fBnwj7LPgtzqNT33RDe1PxoVfASYF86k3xKGy3W5C9tDdCPi
 s0D568pO+BwU4D0m7jy/1vAV20cQku+20nUtBhXHykwKCNcw9q87DfLbozSmvJMUR64WrElt+xC
 1JGl4NkhHrWbBDs2SztXwjrpz0E/Y=
X-Google-Smtp-Source: AGHT+IFu7RTubxd2F175CG2Lci0jiil08qM2GIPHsdsmDFiq5Pj8BO6EKV7tvcpZDj8Do2UiOkJYSjxpyId24g1qFxA=
X-Received: by 2002:a05:6902:722:b0:e5b:1710:d3d0 with SMTP id
 3f1490d57ef6-e63f3c024b4mr623465276.43.1741890855676; Thu, 13 Mar 2025
 11:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250313-clr-v1-1-2cc49df40fe9@daynix.com>
In-Reply-To: <20250313-clr-v1-1-2cc49df40fe9@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Mar 2025 18:34:03 +0000
X-Gm-Features: AQ5f1Jq2saxJY6yu_EC_VJuK2i0doYJvXf6GOi9MV3Z2IlLMLFAxTUgrN4TwgZQ
Message-ID: <CAFEAcA9pu_Y8Ki6TFznViO1UCqqSgHgn2ZKQjbcoKVob3qF5dg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Define raw write for PMU CLR registers
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Thu, 13 Mar 2025 at 07:16, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> PMCNTENCLR_EL0 and PMINTENCLR_EL1 clears written bits so we need an
> alternative raw write functions, which will be used to copy KVM kernel
> coprocessor state into userspace.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  target/arm/helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f0ead22937bf..30883cd3a989 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1907,7 +1907,8 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .fgt = FGT_PMCNTEN,
>        .type = ARM_CP_ALIAS | ARM_CP_IO,
>        .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcnten),
> -      .writefn = pmcntenclr_write },
> +      .writefn = pmcntenclr_write,
> +      .raw_writefn = raw_write },
>      { .name = "PMOVSR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 3,
>        .access = PL0_RW, .type = ARM_CP_IO,
>        .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
> @@ -2033,7 +2034,8 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .fgt = FGT_PMINTEN,
>        .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
>        .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
> -      .writefn = pmintenclr_write },
> +      .writefn = pmintenclr_write,
> +      .raw_writefn = raw_write },
>      { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 0,
>        .access = PL1_R,

Hmm, looking more closely at this, I think this second one should
not need a raw_writefn, because it's marked as ARM_CP_NO_RAW
(meaning nothing should try to do a raw write to it).

And the first one is marked ARM_CP_ALIAS, so I'm not
sure why we would be using it in KVM register sync:
add_cpreg_to_list() skips ARM_CP_ALIAS (and ARM_CP_NO_RAW)
registers when we construct the cpreg_tuples[] array that
defines which sysregs we sync to and from KVM.

(We should arguably be consistent about our usage of the
NO_RAW flag between the pmintenclr and pmcntenclr registers.)

thanks
-- PMM

