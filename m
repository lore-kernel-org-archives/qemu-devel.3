Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC8EC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 23:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sal4K-0001KA-D5; Sun, 04 Aug 2024 19:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sal4I-0001HF-Sd; Sun, 04 Aug 2024 19:55:18 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sal4H-0002dE-9R; Sun, 04 Aug 2024 19:55:18 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4f8c50440e6so386371e0c.3; 
 Sun, 04 Aug 2024 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722815716; x=1723420516; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BniFO4Qij04i8PldxGbs8JzVdvE+fjb+FaKxEjbg5Q4=;
 b=UhO/8rXIxFGID9qIw+2MlIPkPdY/0x/Y+3ZA5iatSIGY/ThYCMGIRvSpvbfqgzolQQ
 0cvVjtK5aWSV47/C6vxfodKn4u0eyPvHRAeHRuJ7fBu0YEyySanTAn4D0A73b7sEgp/K
 K1ML/VLD6icr76vPl8TuhtZGV5+WZpZcoIsxJB4omc5GjDJjUz8EN66EUNN3/3FIhAYu
 Uukl0o9i86ewUTr5GsrJTMoDxB4DVVdfhVG3Ep/Zqn0Jh9LfXZUCmjSYQ4jn96AuHrb6
 vzf6qrwdHYzIHHFWw7bzYf40G8+L+XGMXvhKkNirAPtH7jS45XAZllYTRumogQ7PrK5B
 4xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722815716; x=1723420516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BniFO4Qij04i8PldxGbs8JzVdvE+fjb+FaKxEjbg5Q4=;
 b=V8Kt7IR9Fcno4lLlzW1t8el7b3Pgdqcl0rLNdN6Lsag4Y1A0XYO4tp4acs3wDIN+Lr
 Fj9LYxfIvJUdukfJ4LRoSibmQ4Vyrf8I7GmU8Otwg3Jcyeezm/L5f8WFkFSp/EUz8W1K
 SGlrWByiwVEX6pxJ0mgba8nJvVZoklDcbYx+lPTzH/FGIJK4uubkrITZHwwMBArw13fF
 HbIrK/E09GkgZiZdbgFsSKM3WFUauCHvMtug7DZatmkneHBuCsq99r9Zum81qdCRJXi+
 ouawG5BM33qI8fhPof5IGe5rjfUObuDdHPMCBItaerYMb897+iOjLI9RGRq3oytIn1K3
 1VEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfOtlPeQKf5vq7Ve8y2lSFnU6E0Xp+Rtef9/PkJZviwDy6hcUOWMzvaQWbvXDP/sHPXNXVaShDIdCQrRFJwv8kV9kA4Ec=
X-Gm-Message-State: AOJu0YxIOiOVK4mr2WS0GzlIn44CfyFwkAJLhwMHNCOkaMoI//fl14Wl
 kngftUrZvDLQX3CR2+Hv/dsXGqvyddmOzsMBUQ48fguPQ/MKkPyc4ldmN0u1MMrfvmf2SIfPsyq
 i9srlVy+277mqZf/e1O1bIsaRE04=
X-Google-Smtp-Source: AGHT+IHxm/JPA4ww2FrsU/qO5bPt22qW9WadTH8/01n/34xsSBNkExqGNSMwTHwsiIBhL1CZgU86MNHstoOIodqpUlc=
X-Received: by 2002:a05:6122:2221:b0:4f5:26ac:e4a with SMTP id
 71dfb90a1353d-4f89ffffd68mr10952997e0c.12.1722815715672; Sun, 04 Aug 2024
 16:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240802072417.659-1-zhiwei_liu@linux.alibaba.com>
 <20240802072417.659-3-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240802072417.659-3-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2024 09:54:49 +1000
Message-ID: <CAKmqyKMh+hsKP2AsiJGRz1QsNrx2G8oY83syPw2WCfxrgxQ0gg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] target/riscv: Add MXLEN check for F/D/Q applies to
 zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Aug 2, 2024 at 5:27=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> Zama16b loads and stores of no more than MXLEN bits defined in the F, D, =
and Q
> extensions.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvd.c.inc | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_=
trans/trans_rvd.c.inc
> index 0ac42c3223..49682292b8 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -47,7 +47,11 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
>
> -    if (ctx->cfg_ptr->ext_zama16b) {
> +    /*
> +     * Zama16b applies to loads and stores of no more than MXLEN bits de=
fined
> +     * in the F, D, and Q extensions.
> +     */
> +    if ((get_xl_max(ctx) >=3D MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
>
> @@ -67,7 +71,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
>
> -    if (ctx->cfg_ptr->ext_zama16b) {
> +    if ((get_xl_max(ctx) >=3D MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
>
> --
> 2.25.1
>
>

