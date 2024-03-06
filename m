Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3126BC54E55
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhfzq-0008A5-SN; Tue, 05 Mar 2024 20:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhfzm-00089X-UU; Tue, 05 Mar 2024 20:22:59 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhfzl-0001yC-6a; Tue, 05 Mar 2024 20:22:58 -0500
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7da728b0597so2615511241.1; 
 Tue, 05 Mar 2024 17:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709688176; x=1710292976; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkejMe+9X9uvhyCGN/Y68qZ1rWllwI/TZXNvolLR9rQ=;
 b=lWsmckayeU5qBjNpr/FQ5ZSll0w2rgSoBqaShZEA4KjKSliui3yHRHwUSJCqCLH030
 14D8uJsuB/8TGMTKIXi9cjX+SJ0CEaWSsl0IO7wH7cwHvjtxTY6NrFziQQZH2CxZ1I/X
 bJdOhuRfSxgrSR2bpvI9eucGWheEYfQTLgBTsSnVJNTp/By8YqUY98f4Sj9epby2jT55
 kelI4A4t+FDx+AuQkaygbskSxXVbAc7US8wXY9Lin3zNas+/zmMirgk4wG/B2cNMQXdx
 nND6xkjYWTYcpyNXM5J94aAPtcbc8Ut7HlAwPvPxTn/hwDPsEC/Dob0SF6TKINGoDvtm
 JmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709688176; x=1710292976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkejMe+9X9uvhyCGN/Y68qZ1rWllwI/TZXNvolLR9rQ=;
 b=PRK7NYAdntmnhCUznTR4mhxMRQKdkDWHGKDhJq0XqKoUsMHMazF4L22LJa/kUXAVXm
 XL+9gQ/ogIVvMRhVOeREa+aGK4RGEEBFVKgk8pUsvvY0fgi9BpV7W5Xj4THkKSB4e6xz
 eKsRlvDYtYSBhVosBnVcm2N8mIhsYaCBhTwAMb7gtl8ycpja188Y4Bt6jmgxvZGscij/
 XIgm2YvUuZo7gpqa2O3UC3uHkrpeQcuuoCdm+/sYKIGW6bHp+C6swNDSadAnzCpR88KH
 oGUKBI1BjvBEEDqyHdP+0YK4G/3W584Ii0jY19E8QAjzRXPoukRieqBrQQ9SWdZ0opxL
 GV3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCm7zJ9nngZnUsL4yWGW0Nol1CKMXfU4EsO0Ogf8/sm51UM573i5SVc5XP6iibBCu6iGMiFTRBC+qoMrsdNvZCdAoNMN0=
X-Gm-Message-State: AOJu0YyItoKjJ4cbdS463louES+4m+riUx4u3am0oiyumfW4up4j8iK+
 D5wxdu8R7NYZU/D+hlATC/wBPB+15jqilTMq4dK+xlseQSmyc8Qwh+rPKlw/XnyY7lpMTm7sRMu
 A+7n0FFN7PriD15YOJgPTZ/IG7Go=
X-Google-Smtp-Source: AGHT+IHuNluOalqXm4L8Fr3qtJJTanjCTN426pHcZxhcsAO+DlKcBuu2jJxAGUahdnKuymcXNxw2n9HCFY6BphifBek=
X-Received: by 2002:a05:6102:72f:b0:46d:34fe:65af with SMTP id
 u15-20020a056102072f00b0046d34fe65afmr3577995vsg.21.1709688175716; Tue, 05
 Mar 2024 17:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
 <20240221213140.365232-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240221213140.365232-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 11:22:29 +1000
Message-ID: <CAKmqyKPPdVH2-QbPgTcHxT3jAUds4GXsJJZn=x6f2oSo1cnquQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] trans_rvv.c.inc: mark_vs_dirty() before loads and
 stores
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Feb 22, 2024 at 7:34=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> While discussing a problem with how we're (not) setting vstart_eq_zero
> Richard had the following to say w.r.t the conditional mark_vs_dirty()
> calls on load/store functions [1]:
>
> "I think it's required to have stores set dirty unconditionally, before
> the operation.
>
> Consider a store that traps on the 2nd element, leaving vstart =3D 2, and
> exiting to the main loop via exception. The exception enters the kernel
> page fault handler. The kernel may need to fault in the page for the
> process, and in the meantime task switch.
>
> If vs dirty is not already set, the kernel won't know to save vector
> state on task switch."
>
> Do a mark_vs_dirty() before both loads and stores.
>
> [1] https://lore.kernel.org/qemu-riscv/72c7503b-0f43-44b8-aa82-fbafed2aac=
0c@linaro.org/
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 9e101ab434..7a98f1caa6 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -636,11 +636,9 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1,=
 uint32_t data,
>      tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
>      tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
>
> -    fn(dest, mask, base, tcg_env, desc);
> +    mark_vs_dirty(s);
>
> -    if (!is_store) {
> -        mark_vs_dirty(s);
> -    }
> +    fn(dest, mask, base, tcg_env, desc);
>
>      gen_set_label(over);
>      return true;
> @@ -797,11 +795,9 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t =
rs1, uint32_t rs2,
>      tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
>      tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
>
> -    fn(dest, mask, base, stride, tcg_env, desc);
> +    mark_vs_dirty(s);
>
> -    if (!is_store) {
> -        mark_vs_dirty(s);
> -    }
> +    fn(dest, mask, base, stride, tcg_env, desc);
>
>      gen_set_label(over);
>      return true;
> @@ -904,11 +900,9 @@ static bool ldst_index_trans(uint32_t vd, uint32_t r=
s1, uint32_t vs2,
>      tcg_gen_addi_ptr(index, tcg_env, vreg_ofs(s, vs2));
>      tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
>
> -    fn(dest, mask, base, index, tcg_env, desc);
> +    mark_vs_dirty(s);
>
> -    if (!is_store) {
> -        mark_vs_dirty(s);
> -    }
> +    fn(dest, mask, base, index, tcg_env, desc);
>
>      gen_set_label(over);
>      return true;
> @@ -1102,11 +1096,10 @@ static bool ldst_whole_trans(uint32_t vd, uint32_=
t rs1, uint32_t nf,
>      base =3D get_gpr(s, rs1, EXT_NONE);
>      tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
>
> +    mark_vs_dirty(s);
> +
>      fn(dest, base, tcg_env, desc);
>
> -    if (!is_store) {
> -        mark_vs_dirty(s);
> -    }
>      gen_set_label(over);
>
>      return true;
> --
> 2.43.2
>
>

