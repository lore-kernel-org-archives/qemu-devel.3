Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8791FC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBU-0002U3-Ru; Thu, 28 Aug 2025 13:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urbeQ-0005a5-Uy
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:22:50 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urbeN-0001v7-D8
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:22:44 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-afead3cf280so109596366b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383760; x=1756988560; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2DgyHheK/0+xUl8Bkf91Pj5PAamzCFASNWdNNp4r7o=;
 b=jFh5/SmKLZHuzU/VUV2UrTBQW+nsrHx3Om6TzAdLM6ie3tNcuq//j/KfsFFw7uLTY0
 8D1g/SX7zagep7mtUnlLYIhyxLZ3eTaStMLxYWEvSWdrB4UEw/Ay9gBOLKxjE/w4akmb
 MzKdZqR07XoK6PtXApUukwB5lPGD/o61pcJp54Cn9S6ERuPAUaIj8kD9C7H+0Zr3sgGf
 UJQ/aFF89YJVjlXQddL9BCNYdnWm+AYZQmEyvN413R7YFugviPMpf6m9eenMkheiOeJW
 nlUCB2QBkDMbukuNsSl6Qlw+73RVFziC8rOHCHpHb7Vmp7cobFTbXTN04t1R9uvKqI15
 YH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383760; x=1756988560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2DgyHheK/0+xUl8Bkf91Pj5PAamzCFASNWdNNp4r7o=;
 b=Em6Nm4rnl2NRICPeehBg3yJVaYRTLbsCL6RaB4/nuB3Y650Yb6FDCsQBYTeaeicSps
 1unwIYSti5yb+9PMEvsuNF7z2LH5yI6R5nRm32ZqUcqUwtPDUzbIPuMirMJLaJ6bmxGY
 0F6vbR9P7OIvZx9cboKVARhAkpe2QF2wXmE/ALCmx92mm7j32O9kfLFhsmOUWqVNkh2k
 jXnu+lTkXBwjP/DEKnitIItY02aSTMjIcKkUEh1uayZ19Wmd0KgvY7qSEUldYZ1/BpOd
 5g+TkMtL3/2bUFR1W3wS7Vb6S78yR15QsBNmAtjLqRZCZnNKD9OTRFIVDTVlDLlvkNDQ
 YTcg==
X-Gm-Message-State: AOJu0YzMrk2uWqz4gVQQuW+RIsemyNCwab203xts5tr67R6U87rTMUKR
 GAmUxmUkEzmhY0bylBM+jEpSxbUno71P1Ckxfv1j6XQja8L4X8IDkJJLuNM4hyO1e3/alADwLoc
 alwpTemATSfH993v/q14mbSrcdRI9ajMTDQ1wr5QRIQ==
X-Gm-Gg: ASbGncuIM99deqHmKohy3uUoO5diB8uuSKJNkDyXhcYH0pkZyz2A6Xsxu/1q7NU5Ra8
 EXayL+yU77LeCCtA3gEIQX/u10X5jxqvBxujyfnQyHL7k+sI+uxDi14cJFMemIYO0pFX2jJpEN/
 6xsDjJZHNhd6BdHy7VN//Q8VakqAa8nCSpymxfNkp2d1zivU1965WRSNwZbhYpFyoZRB7PVTUCh
 D9+PkZz
X-Google-Smtp-Source: AGHT+IGmpkIX6sXY1NIRRJFhLI0IE0J4O7kQkMygI48WdLjm/PxwgDHDQZePNjNjB2RxY8ezwRtrjlJVTEFBfxgDwwo=
X-Received: by 2002:a17:907:72c9:b0:ae0:cc5f:88ef with SMTP id
 a640c23a62f3a-afe29048ce7mr2253035866b.32.1756383760080; Thu, 28 Aug 2025
 05:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-5-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-5-richard.henderson@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 28 Aug 2025 15:22:13 +0300
X-Gm-Features: Ac12FXxF4ko9mIQyFgJKPpiGe9OspY4f7xK_bnO9Y3fmu7P2zewEodjgRx6T158
Message-ID: <CAAjaMXYUJxadTdi7BjvwEA-AwuAjpQyp6o2rRMC5s4jCCN9XoA@mail.gmail.com>
Subject: Re: [PATCH 4/7] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Wed, Aug 27, 2025 at 4:07=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Conversion between KVM system registers ids and the HVF system
> register ids is trivial.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

FYI: you sent this as [PATCH 4/7] and [PATCH 05/61] by accident,
happened to a few other patches in this series as well.

>  target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index f0e4b75e6a..2577dc1c0c 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -403,6 +403,26 @@ struct hvf_sreg_match {
>      uint32_t cp_idx;
>  };
>
> +/*
> + * QEMU uses KVM system register ids in the migration format.
> + * Conveniently, HVF uses the same encoding of the op* and cr* parameter=
s
> + * within the low 16 bits of the ids.  Thus conversion between the
> + * formats is trivial.
> + */
> +
> +#define KVMID_TO_HVF(KVM)  ((KVM) & 0xffff)
> +#define HVF_TO_KVMID(HVF)  \
> +    (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
> +
> +/* Verify this at compile-time. */
> +
> +#define DEF_SYSREG(HVF_ID, ...) \
> +  QEMU_BUILD_BUG_ON(HVF_ID !=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_A=
RGS__)));
> +
> +#include "sysreg.c.inc"
> +
> +#undef DEF_SYSREG
> +
>  #define DEF_SYSREG(HVF_ID, crn, crm, op0, op1, op2) \
>      { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
>
> --
> 2.43.0
>
>

