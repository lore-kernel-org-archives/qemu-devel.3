Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39DFE65D25
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 05:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tELlF-0003NG-94; Thu, 21 Nov 2024 23:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tELlE-0003N2-EX; Thu, 21 Nov 2024 23:59:16 -0500
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tELlC-0005qg-J7; Thu, 21 Nov 2024 23:59:16 -0500
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4adcd7e153bso273280137.0; 
 Thu, 21 Nov 2024 20:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732251552; x=1732856352; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbQ6wRflIJ7rQ5ch+JClMrd+dK96Krv5wDkF5V7AfeY=;
 b=VPfVb9+iIfdvz/Q3aNU9uOts1NKarj+3FzIht/GD1C8dUwNGmxtDYt3A1bH6PjO0YM
 MriD20D4JHyPz0ucOSq9y31D2bJ/BCE/TDho0tUIUKZ9/hvgA2uzYvo6lUrFzN5k7Z80
 GeY//eu2IafwB54MlUQiTEtLiQ1QVz4sbAV8OqJnzo71T8WERrGNClYm+tmy0JR0qPUD
 tn4E3R3P3MHoJQcFGmhzPNqzxfJ/Sm9aWXPPHDvMJbaQnoY60xkcomCb2L8SrXRYvXVe
 hP9wsdg15hnwGk24+iKZio5b+wiLinm5u3W2rwbphM/RrvxtGYDt+JdDzkHcmzJZZu4f
 biNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732251552; x=1732856352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TbQ6wRflIJ7rQ5ch+JClMrd+dK96Krv5wDkF5V7AfeY=;
 b=Br4Rx3rPapoNNMMYb/oAMJZe7E7AXtI3YMusQ94UY6rmTThrJcuTVM7+pEQL7j+mJh
 syMCUEu0NXOh5tVwqFofXNZq5D3NbUXi2rf9nmSUHQz7zIKhzQI0b6LYHTeHfaGDP01V
 maA3tVuPGZWeoEabbwui/HiyIERwMDVoMu51YRJ2twBRpPayvlOJcfrfPQ+TdrHt8yjt
 M0DnfDmD9cEPT10iBbs1iZbpRRu/LSQgnZfaNxg8T4ldQa0NCNtvwb5dXsJsjYBIYOgS
 ZFiXalZNCWqbXKgRdCB4zKBjfHbaYh8DZNJtaFUmXom2pUTCKHHHOVSvOJ5xK+EkDztF
 OqZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf0K1aK7Y5QCMAe4mfgwggcbA1lzRebNogxfk6lXjQK6zpyevJ4mS2FBZOejvu4ygQwsXgDEB2WO1R@nongnu.org
X-Gm-Message-State: AOJu0YxVCyKBipMAHZDuKvikNjcsS1wUfCdZ/GrOgU3KplFNT6n4cQPu
 D2EvNlUwNLwEBuBof16Q+eflWngtO5smicd9s/PufBJ2ZZd1/GrAo1rujqrBaT+4tt+pCIRs2Ro
 6/zJUYgj4rr04Ldiald5r/8G4tK4=
X-Gm-Gg: ASbGncthQZfVQg0JrxwUX1JXNaVbQwVyotfDILAOzfALzCwKDoxdu9RlZR4AsC9zufz
 iAfopobUjRfLm3IQgIsSmpunZRfp9EtOlZOpq/38WQFmBo39M5AQFkWxbNySDhA==
X-Google-Smtp-Source: AGHT+IHitEG4PTMFMndYJzS1XFw47wWkFBLCTV4an3B53AlZbDxaHZkIasFwTtOs3aibI9sDrhsBcyWQS5rI6wcw//Y=
X-Received: by 2002:a05:6102:4429:b0:4ae:f1e9:4d73 with SMTP id
 ada2fe7eead31-4aef1e95026mr196469137.16.1732251552464; Thu, 21 Nov 2024
 20:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20241120074854.1767780-1-fea.wang@sifive.com>
 <20241120074854.1767780-5-fea.wang@sifive.com>
In-Reply-To: <20241120074854.1767780-5-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Nov 2024 14:58:46 +1000
Message-ID: <CAKmqyKM9N7RFSU3V0k+UkvVRNW70ff4hTcDTdiLYsCqK9znM8Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] target/riscv: Check memory access to meet svukte
 rule
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=no autolearn_force=no
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

On Wed, Nov 20, 2024 at 5:48=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Follow the Svukte spec, do the memory access address checking
>
> 1. Include instruction fetches or explicit memory accesses
> 2. System run in effective privilege U or VU
> 3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if
> instruction is HLV, HLVX, HSV and execute from U mode to VU mode
> 4. Depend on Sv39 and check virtual addresses bit[SXLEN-1]
> 5. Raises a page-fault exception corresponding to the original access
> type.
>
> Ref: https://github.com/riscv/riscv-isa-manual/pull/1564/files
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 55 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0a3ead69ea..edb106b8a0 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -857,6 +857,55 @@ static int get_physical_address_pmp(CPURISCVState *e=
nv, int *prot, hwaddr addr,
>      return TRANSLATE_SUCCESS;
>  }
>
> +/* Returns 'true' if a svukte address check is needed */
> +static bool do_svukte_check(CPURISCVState *env, bool first_stage,
> +                             int mode, bool virt)
> +{
> +    /* Svukte extension depends on Sv39. */
> +    if (!(env_archcpu(env)->cfg.ext_svukte ||
> +        !first_stage ||
> +        VM_1_10_SV39 !=3D get_field(env->satp, SATP64_MODE))) {
> +        return false;
> +    }
> +
> +    /*
> +     * Check hstatus.HUKTE if the effective mode is switched to VU-mode =
by
> +     * executing HLV/HLVX/HSV in U-mode.
> +     * For other cases, check senvcfg.UKTE.
> +     */
> +    if (env->priv =3D=3D PRV_U && !env->virt_enabled && virt) {
> +        if (!get_field(env->hstatus, HSTATUS_HUKTE)) {
> +            return false;
> +        }
> +    } else if (!get_field(env->senvcfg, SENVCFG_UKTE)) {
> +        return false;
> +    }
> +
> +    /*
> +     * Svukte extension is qualified only in U or VU-mode.
> +     *
> +     * Effective mode can be switched to U or VU-mode by:
> +     *   - M-mode + mstatus.MPRV=3D1 + mstatus.MPP=3DU-mode.
> +     *   - Execute HLV/HLVX/HSV from HS-mode + hstatus.SPVP=3D0.
> +     *   - U-mode.
> +     *   - VU-mode.
> +     *   - Execute HLV/HLVX/HSV from U-mode + hstatus.HU=3D1.
> +     */
> +    if (mode !=3D PRV_U) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
> +{
> +    /* svukte extension excludes RV32 */
> +    uint32_t sxlen =3D 32 * riscv_cpu_sxl(env);
> +    uint64_t high_bit =3D addr & (1UL << (sxlen - 1));
> +    return !high_bit;
> +}
> +
>  /*
>   * get_physical_address - get the physical address for this virtual addr=
ess
>   *
> @@ -894,6 +943,7 @@ static int get_physical_address(CPURISCVState *env, h=
waddr *physical,
>      MemTxResult res;
>      MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
>      int mode =3D mmuidx_priv(mmu_idx);
> +    bool virt =3D mmuidx_2stage(mmu_idx);
>      bool use_background =3D false;
>      hwaddr ppn;
>      int napot_bits =3D 0;
> @@ -901,6 +951,11 @@ static int get_physical_address(CPURISCVState *env, =
hwaddr *physical,
>      bool is_sstack_idx =3D ((mmu_idx & MMU_IDX_SS_WRITE) =3D=3D MMU_IDX_=
SS_WRITE);
>      bool sstack_page =3D false;
>
> +    if (do_svukte_check(env, first_stage, mode, virt) &&
> +        !check_svukte_addr(env, addr)) {
> +        return TRANSLATE_FAIL;
> +    }
> +
>      /*
>       * Check if we should use the background registers for the two
>       * stage translation. We don't need to check if we actually need
> --
> 2.34.1
>
>

