Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC850EBFD16
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCCW4-0004B8-SP; Mon, 13 Apr 2026 04:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wCCW1-0004AS-2g
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:19:29 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wCCVx-00027j-QJ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:19:28 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82f431c0ab6so220053b3a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776068363; x=1776673163; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5SO0u6mvsYx2Er9GPM2Ae6cAoCEMLwS+a9b90sE9fY=;
 b=J9kAr7+KiuxCeCM3XiY4FqkCPxviU9E1gtacviaKmDw6aUhD2s60j2AN5JviArtNH3
 Aqq+tJNcNqFvGfWTMwwyTP4kok3NY3p95G6ctU5NxUEhXypiOb5ywshIWRqqhV5ZQvm9
 lblUyen94BObzJcNb7VyKu8NHyHj3GiLJHsma8kXfta8F2YwR1g90PGbtse609Gw8HZ7
 86tg9YPZ7+txiYQavIGsNsBhtQTc3p9KxXmSAfXjcJi2o1byBkIlGOxlGwbEm23WCp0t
 nZRbRs3qIcoBixbOgFBi8GotmX20ufIgb062Yky2iJlfpgtfPhfw9HD/LnYbiQFXVrhL
 8uBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776068363; x=1776673163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H5SO0u6mvsYx2Er9GPM2Ae6cAoCEMLwS+a9b90sE9fY=;
 b=HufQQN9vLoOqFWjpAzIYtT68AnUZ/rdBUvJ89c0LUnneoj9cxJfl000f/EIJlBRCX0
 mbNWlHSTKfJOHh+DMkgVbb9TqaRHKJEUH/E3+C0MyjlYuoRkFJxGn2Q6oVXtSk7at39M
 Vu0pEoeqT/GRJrWvojxbFenkLpZxkZcmCLOb4LyKGcuzpO9F3oUP5Sg8ijmDFFj60Nw9
 G5InR9ntVg7vKav00Rv3mLts7TO1Zl/TDPAH3pdQNmQ6j8jXSe1uPlEMwTl5j84A64C3
 dqS/I3dSIWJq5TxJZPxCxructg02oGx/23gJ6wFJFJDuwHp+NGQEQsT9Xbgvcu/lZfmO
 Lpyw==
X-Gm-Message-State: AOJu0YyIDbmxkVuPCGJ4u2c+laWGS9xhWUS9Avkkn7dVkIjO0CQ9o6ti
 SXKAvEHgHgCiS0pbZHvhplIfJQ/OeSrFAEHKCimysqKy8kPE0sZX9EG0f/rrPMuLT43v1LDj4Pf
 ZTq3YTmGDICXqq6afQSl1yAu9OWswy12yV7m2TH8RQUnSC9t4KcagFqDZ7C9P5UgZWEiN5QW36E
 qq6LWpZ0vsilLp+hIIBLZTILZMEweMb4ixpnQjgeFDhrW4gUZD
X-Gm-Gg: AeBDieu/UbHNTSv0B4DqCLxMgsD8WMZg59h0/Fnum9BMilafpsmsOhfPYRpICi0AQ6r
 R6+TDFhmQbVNoycK9Q+aUqgu+iJKj35Q4FCM2sncndwfRAyYZPFOa4LM3000jGJeQ536biTJXMA
 1hXWGzsr27K6WCX7knidfRftz+LI8tGNHh46vEPvc0i+fdQoO9A49iEfdOugUQSEwgWLgFStayh
 0f8k8LM2Uyl2nNLPWOvPWMKNzNfIC5aFRbRNGFj32UyMKdIiPIv43TdqHqOpnfG2Uf3WsuPt4Lq
 xZAoN4IOAbOe+vE5YS60E5X/si/RkK2JdO+6NMIB4brRj8jgmiv49XCbjfsTjclY1baS2NMRyBm
 IFYF9hUqh1xKY1LJue+/O2XYXCRjw2mhOQmLzj6IgpWs866Fb9JWHwwDyB1TK8AjKDBfxyoSK/q
 xkungU4B5VJZ4dsFnWUzVTv5adj6z0TCcppqFgV72mjU8WLJedfOma+V4g7iR7H8eC6A==
X-Received: by 2002:a05:6a00:e13:b0:823:3079:7c7 with SMTP id
 d2e1a72fcca58-82f0c2f7a36mr13587732b3a.29.1776068361683; 
 Mon, 13 Apr 2026 01:19:21 -0700 (PDT)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com.
 [74.125.82.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c50cd34sm11044463b3a.54.2026.04.13.01.19.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 01:19:20 -0700 (PDT)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2d9916deb14so747857eec.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:19:20 -0700 (PDT)
X-Received: by 2002:a05:7300:8c85:b0:2be:8216:57db with SMTP id
 5a478bee46e88-2d5873ad987mr6250054eec.3.1776068359715; Mon, 13 Apr 2026
 01:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-5-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260408140635.42546-5-zhiwei_liu@linux.alibaba.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 13 Apr 2026 16:19:08 +0800
X-Gmail-Original-Message-ID: <CANzO1D1m3Jht1BNuPi3MvCr=iQRHWSgEGZqHryNof=m4Dra7SA@mail.gmail.com>
X-Gm-Features: AQROBzDlQBeDu4axNKOHGLK79oUM32wm7upOSCSPbvUDVoLJlHQjsJa93v_aOL4
Message-ID: <CANzO1D1m3Jht1BNuPi3MvCr=iQRHWSgEGZqHryNof=m4Dra7SA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] target/riscv: Implement SMMPT fence instructions
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, 
 palmer@dabbelt.com, alistair23@gmail.com, daniel.barboza@oss.qualcomm.com, 
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Zhiwei,

LIU Zhiwei <zhiwei_liu@linux.alibaba.com> =E6=96=BC 2026=E5=B9=B44=E6=9C=88=
9=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=883:24=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> This patch completes the SMMPT implementation by adding support for the
> new fence instructions: `mfence.spa` and `minval.spa`.
>
> According to the specification, these instructions act as memory ordering
> fences for MPT updates. In QEMU's TCG model, this is conservatively
> implemented by flushing the entire TLB, which ensures that any subsequent
> memory accesses will re-evaluate permissions and see the effects of any p=
rior
> MPT modifications.
>
> The instructions are privileged and will cause an illegal instruction
> exception if executed outside of M-mode.
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/insn32.decode                    |  2 ++
>  .../riscv/insn_trans/trans_privileged.c.inc   | 30 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6e35c4b1e6..84cec57daf 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -120,6 +120,8 @@ sret        0001000    00010 00000 000 00000 1110011
>  mret        0011000    00010 00000 000 00000 1110011
>  wfi         0001000    00101 00000 000 00000 1110011
>  sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
> +mfence_spa  1000011    ..... ..... 000 00000 1110011 @sfence_vma
> +minval_spa  0000011    ..... ..... 000 00000 1110011 @sfence_vma
>
>  # *** NMI ***
>  mnret       0111000    00010 00000 000 00000 1110011
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/risc=
v/insn_trans/trans_privileged.c.inc
> index 8a62b4cfcd..5ec6bf5991 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -160,3 +160,33 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_=
sfence_vma *a)
>  #endif
>      return false;
>  }
> +
> +#define REQUIRE_SMSDID(ctx) do {          \
> +    if (!ctx->cfg_ptr->ext_smsdid) {      \
> +        return false;                     \
> +    }                                     \
> +} while (0)
> +
> +static bool do_mfence_spa(DisasContext *ctx)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    REQUIRE_SMSDID(ctx);
> +    if (ctx->priv !=3D PRV_M) {
> +        return false;
> +    }
> +    decode_save_opc(ctx, 0);
> +    gen_helper_tlb_flush_all(tcg_env);
> +    return true;
> +#endif
> +    return false;
> +}
> +
> +static bool trans_mfence_spa(DisasContext *ctx, arg_mfence_spa *a)
> +{
> +    return do_mfence_spa(ctx);
> +}
> +
> +static bool trans_minval_spa(DisasContext *ctx, arg_minval_spa *a)
> +{
> +    return do_mfence_spa(ctx);
> +}

The spec says that:
"When Svinval is implemented with Smsdid, the MINVAL.SPA instruction
must be implemented to
support such fine-granular invalidation of physical memory
access-permission caches."

So I think we should call REQUIRE_SVINVAL() for MINVAL.SPA.
However, trans_privileged.c.inc is included before trans_svinval.c.inc.
So it might be better to separate these instructions into trans_smmpt.c.inc
and include it after trans_svinval.c.inc.

Regards,
Frank Chang

> --
> 2.43.0
>
>

