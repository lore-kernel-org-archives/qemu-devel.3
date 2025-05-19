Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFF6C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 00:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGoCK-0000Xz-CF; Sun, 18 May 2025 20:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGoCF-0000XO-9q; Sun, 18 May 2025 20:17:37 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGoCD-0007Nq-2q; Sun, 18 May 2025 20:17:34 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-52410fb2afeso2622328e0c.3; 
 Sun, 18 May 2025 17:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747613849; x=1748218649; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZVKVF/qTw65cv51/4KNi53uu2B84G9DNrG+BqCQr4Q=;
 b=docpBOrFFMbo8H4hIHv6JZBpfGOwHHFSp0MintkY4VNUSZbdFHm15RjVUWLBvKkhK6
 1+edEfrQimvS98wfH/q3WUEsQgG6o5EwobiHPTK/gfRXeGtOPNJPcau6vq2cX95ndPJM
 2gVteR6jgZbw/9yeY5p4luf6Y4TBe1R61NNnKDtvREULQPkSzVZN0jfobFdqfZjl2CSC
 6fJ/JxxDjy0A5GpI3WMU1oljecPo8B60+AmMggPMUkI05htsjOBb90pIWnME0qD2TVUA
 YfP8pYeXNTBMQCiAB5c9YyJ7gMNGqsoQ4XvPSABKjEX0+rEJgJOep6MndheLNi2fl6gA
 okrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747613849; x=1748218649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZVKVF/qTw65cv51/4KNi53uu2B84G9DNrG+BqCQr4Q=;
 b=IYkXWffBwScu2I583PgQeV095xdk0aEfmXZ80bjlbdGDXY+yGJG8fcwOk0qyJ6LOTa
 xvySPPGmBwILbuKk2P5sFHvO/znzD9OKGe908oamYWWWCI9OMaEDLrfJNq5rofomRqV0
 7oQ3+qtciT3hYiNzgHqNW6AeyFubwegFq3gzjFQPpvOagFy1dtgqJYWg30+42xlRsanI
 NZ3H1pVD1uWxGxUpjtnpmlkaLr+fYSx53QLDfPLgeWVchkt1UWAoZv8r4jTlnS1FicWO
 V0G8mfuEl55/QIi9/vqGnBZOgxfjZO6Yztv5u3XdErh7XxoyScq4iEeG1hD885/9/sII
 zbuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMVbO5ozgZJifQ3tMMGnPc6xbOZHcI7yREi8zHyUaubYB/DuYkwDR6eTkXwxAcqYOzaYBlbnlFDweW@nongnu.org
X-Gm-Message-State: AOJu0Yw0Qy66JRQ6LFLi3CJdpnH1t55xaPHNeFmJTZl+o7RpNgj3/fpT
 eWxc2cvJR42dP+w2oTKfHtJg7xOkDG3pRdTG9rGMO74fv1KdCZ42NcLL2Y1LNTqAQRps77DIAcW
 CGfV2CUjMH5M58iD2+/s3IxLSRTbRsPs=
X-Gm-Gg: ASbGncvLQAvqntR8AFsWcwfUbYpaaDI4NUGouOFeN6ptzZsmFfJKgW/1oC61dTde7fv
 pBvR65855nJQNJPv4vxYIBDj6mO0ZkmhPPjUUhhTpnTnTI5tp8HmMDrdlDLbsZw+rqxH1/P9ohF
 /c4Oclf1pwSi5TQUa1/mCOMi32tUhn7AjOspHFvlhzWctkStUTOn6F9pF1Q+zi2ZY=
X-Google-Smtp-Source: AGHT+IGTdNxbfcFImbKZe/u7StOJxwCzMM4GGQo+jLyBu4wCKszoRW+kWkchIqtkhJopZfpL1pUCDXXerB3kn3U0U88=
X-Received: by 2002:a05:6122:46a7:b0:52a:863f:78dd with SMTP id
 71dfb90a1353d-52dba91e5a2mr10982973e0c.6.1747613849494; Sun, 18 May 2025
 17:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-10-richard.henderson@linaro.org>
In-Reply-To: <20250504205714.3432096-10-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 May 2025 10:17:03 +1000
X-Gm-Features: AX0GCFtF1g0SDv8pO09Rs__WSuaJ71bU_x8OFQiafOQ5Yhea4xLeDPv6w8zFGbA
Message-ID: <CAKmqyKOw5_b=_GrTd6exz4JnPFQMmFBFUdKTi4-LvFP9=gKvUw@mail.gmail.com>
Subject: Re: [PATCH 09/12] target/riscv: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, foss@percivaleng.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Mon, May 5, 2025 at 6:59=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Check 32 vs 64-bit and pointer masking state.
>
> Cc: qemu-riscv@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 55e00972b7..267186e5e3 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -237,6 +237,31 @@ static void riscv_restore_state_to_opc(CPUState *cs,
>      env->excp_uw2 =3D data[2];
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
> +                                vaddr result, vaddr base)
> +{
> +    CPURISCVState *env =3D cpu_env(cs);
> +    uint32_t pm_len;
> +    bool pm_signext;
> +
> +    if (cpu_address_xl(env) =3D=3D MXL_RV32) {
> +        return (uint32_t)result;
> +    }
> +
> +    pm_len =3D riscv_pm_get_pmlen(riscv_pm_get_pmm(env));
> +    if (pm_len =3D=3D 0) {
> +        return result;
> +    }
> +
> +    pm_signext =3D riscv_cpu_virt_mem_enabled(env);
> +    if (pm_signext) {
> +        return sextract64(result, 0, 64 - pm_len);
> +    }
> +    return extract64(result, 0, 64 - pm_len);
> +}
> +#endif
> +
>  const TCGCPUOps riscv_tcg_ops =3D {
>      .mttcg_supported =3D true,
>      .guest_default_memory_order =3D 0,
> @@ -250,6 +275,7 @@ const TCGCPUOps riscv_tcg_ops =3D {
>
>  #ifndef CONFIG_USER_ONLY
>      .tlb_fill =3D riscv_cpu_tlb_fill,
> +    .pointer_wrap =3D riscv_pointer_wrap,
>      .cpu_exec_interrupt =3D riscv_cpu_exec_interrupt,
>      .cpu_exec_halt =3D riscv_cpu_has_work,
>      .cpu_exec_reset =3D cpu_reset,
> --
> 2.43.0
>
>

