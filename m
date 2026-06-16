Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AACCD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZI83-0002Ed-Mg; Mon, 15 Jun 2026 20:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZI82-0002EV-A6
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:58:10 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZI7z-0001vc-8e
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:58:10 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-692491fec0bso6635126a12.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:58:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781571485; cv=none;
 d=google.com; s=arc-20240605;
 b=jGcgUVPtrWlu+sunGCwljADRArjI8qc7+IJy4dSZULLFgUPA1VFVcBafk0lRTSfwDE
 EGiidBBmJrrlmKfIDPcW19vrCRIFpvuXnv0bXfcQanwxMsABLp2pvCMWfhRFS8uEOg2b
 troSRvdEd1XKJvjP8JSulFxwI+n4yJONQSszGN0ZtoARDBadUoMZCFwkIo2MPiWEGm3i
 8g/H+GYhCZPPF+yKM95NYey0EDv1SO1hb+9pWXSYcxAAO7Vr7R0OTSNtAPTZPoXQMcu/
 KHT+TfaCzQY5HjbAtfJouJ4wkbkfVmudWJT4eYvProjxOQlljRu4g791xDjVmb5nTRu1
 NFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y5JtVxw1GsJ+ot8xffNhghsZIFL5pVEBHi4kPvzg/hA=;
 fh=QMl3m49tuLtOusuuXCnCOZCsoZiLfsjUwXG2nLBmcSY=;
 b=TnyOIhHb9Ax72hS5pq/8kSTs518kjZPU3Z6FTopPzHJ1ZvGnnsqwmOZnt4uxlZpEvA
 ZrOi+ZEJYpFdIle0CxWLLcGnOfV+bpmiHYJLUmj6e0QVqJGPI2NSjrKA4mHuohqpyrj0
 lH8ceaiYf7KslgxIF3ur9FvU3MfNHKOg+jSKRMhncltNIYuoJQMXzJit2fH6XgqwkgIJ
 FEc7Lc6+Egr7OfjOlDWQEgg+m4OBQcI/M82AO6W3fT5UNKk1wecqtusYD+ewSG9Ux9vJ
 komxSzf+dKp+h7OV3qjvLH2tpLfOutq49SkBx2OtNTWh6Wy2+zQh3r7e42460OMOQyi0
 0gCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781571485; x=1782176285; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5JtVxw1GsJ+ot8xffNhghsZIFL5pVEBHi4kPvzg/hA=;
 b=AvH6Uh2b0MOqjgyqf27QIkrxRxs+biJntRjasm+MkNf6NwG2d7e8EWWtY6iEVMxYp7
 jklbVw6fK+B9YcLrTBqAPpX1z6vGocHklN696JiXjOT8Ztxjv1UXVqBmluI7XBpn1NZ0
 PDE5EV2twNU9KSH0TstEWu1aVSS+D8omVZxZILcoIuCQX/y/An/d9dYW3YT7/nj0K4lL
 zcBIrrbeJylAqmgf4x4hlyxC9E7sm4HbsrmS/BsYWlztD7K5YPAA1YE2N+kvRJ2SldGX
 Fc/oSfhvp7H4VIp92lfd9g5yOoKSu+O5Nhpbh0qP9/eS1v3YYUrQzSf0HlKNS+C504sr
 XZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781571485; x=1782176285;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y5JtVxw1GsJ+ot8xffNhghsZIFL5pVEBHi4kPvzg/hA=;
 b=V4OBWn88mZnV/ChQsUfysKGGS9/KfOezPd59qmq5OKnJCfiOBwptDy++ODl0h5wnHW
 6bfMM/fASNBHB0RfM6Y6lAp/M/v6WZYC10QU20vImizLyxHb2oP7Rxw0+Zi9PMCw4e12
 gMBRIgG2OrJZzQ42Tqs/e6EH1+9ZYthK4wRPT4GLcVlS3UPzTkkWX3X9IyTEiZ88cFPU
 ZpSy7lqdlf5JZ0gr8+YGTFwdiLaXsqwxlDY5vRH3vfbdg9bR8ZheLK1KPg0YRLOcfHsW
 f8wP7F9y5mAIZa07LESgP3+9FriZz0smvP2RZCf0hbXk+ELgl3JOz4NPSt31mhKAHUoE
 hhZg==
X-Gm-Message-State: AOJu0YwWxkaBG91almCvh/A/R6zjXNXuPYCkct0qlbZTwO8hehKUA0LW
 DTT6W+UEwfQ40spAsapps6HeUp7eVFOYLaEr0FgcQsZnX9WtyM42gSwTuZNN4m32IXpWEjICXCo
 C6sLv04fimYMQPH5mPvJwd5MkJdsv63FSxXJL
X-Gm-Gg: Acq92OG128sTwQ8KiCix7XokBsFPGe3rDG0lITgzEbRgSVqv80Sv2EfCAD5sLKcyhsD
 Hw4TEqFezB2rv6XKZu7smdHvNzJTM+5uzWo723nh9Vzafydu5ndAsmsf8n0wbun7cz9nCqYqhGk
 wl3rzuFg907fhtOCYwWgx2cDlIKthMYUrxgx/RRsl9Wsdm7BY2LGmLbtLUVbYliZ0wWn8Y0SwMo
 1n4+2q3g3X65wrgVRU25fldT4qJu1fJigr48uwPpdtwgFhbmOL4uYz6Oxp9MsZikqRV1c8pOKGu
 J6muoXEvEDgbMaUzG2NjcM2KfQpc6Qk4PxQU+g==
X-Received: by 2002:a05:6402:3212:b0:691:b5aa:5a70 with SMTP id
 4fb4d7f45d1cf-693788fb36bmr7517095a12.4.1781571485356; Mon, 15 Jun 2026
 17:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260610214133.1882563-3-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 10:57:39 +1000
X-Gm-Features: AVVi8CccgmY5SS9TMVYXOGFIwlnHVDlya1J7fwj1QELPGIWNPEMMDTK-L2Kzpj0
Message-ID: <CAKmqyKOHLaR8mkL_An6UiKkbAXSe4f4fwAhJm=x4MgFMvJSNjQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] target/riscv: add riscv-server-ref CPU
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com, uwu@icenowy.me, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jun 11, 2026 at 7:44=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support and others.
>
> We're going for a profile-based implementation, instead of a regular CPU
> that can inherit RVA23, to allow future CPUs to use it internally as a
> starting base for their own extension sets.  There's also a new
> 'rvserver-ref-1.0' flag that can be used to set the extensions in the
> command line for other CPUs, which can be used for testing/debugging
> purposes.
>
> Note that for all intents and purposes "riscv-server-ref" is a regular
> CPU and no, we're not trying to set a precedent of calling the riscv
> server platform spec a profile.

Urgh! Let's see how this looks in a year or two. Hopefully we didn't
dig ourselves a hole

>
> [1] defines in rule SEE_020 that we must support at least 11 debug
> triggers (4 for insn address, 4 for insn load/store, 1 for icount,
> one for int, one for excp).  We're going for the minimum.  If more
> triggers are needed users can set any trigger amount with:
>
> -cpu riscv-server-ref,trigger-count=3DN
>
> Note that N must be <=3D 128.
>
> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/serv=
er_platform_requirements.adoc
>
> Suggested-by: Icenowy Zheng <uwu@icenowy.me>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 30dcdcfaae..a150acd151 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -42,6 +42,7 @@
>  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>  #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>  #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
> +#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-serve=
r-ref")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibe=
x")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e02d53cbba..63fbc4b98e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2063,11 +2063,35 @@ static RISCVCPUProfile RVA23S64 =3D {
>      }
>  };
>
> +/*
> + * The riscv-server-ref spec isn't a profile per se but its
> + * CPU definition can be modelled as a profile that extends
> + * RVA23, with additional things on top of it, and allowing
> + * future CPUs to derive from it via
> + * ".profile =3D &RVServerRef1_0;".
> + */
> +static RISCVCPUProfile RVServerRef1_0 =3D {
> +    .s_parent =3D &RVA22S64,
> +    .name =3D "rvserver-ref-1.0",
> +    .satp_mode =3D VM_1_10_SV48,
> +    .ext_offsets =3D {
> +        CPU_CFG_OFFSET(ext_zkr),
> +        CPU_CFG_OFFSET(ext_sdtrig),
> +        CPU_CFG_OFFSET(ext_ssaia),
> +        CPU_CFG_OFFSET(ext_ssccfg),
> +        /* ssstrict is always enabled for PRIV_VER_1_12 */
> +
> +        RISCV_PROFILE_EXT_LIST_END
> +    }
> +};
> +
> +
>  RISCVCPUProfile *riscv_profiles[] =3D {
>      &RVA22U64,
>      &RVA22S64,
>      &RVA23U64,
>      &RVA23S64,
> +    &RVServerRef1_0,
>      NULL,
>  };
>
> @@ -3326,6 +3350,13 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>  #endif
>      ),
>
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
> +        .profile =3D &RVServerRef1_0,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .cfg.max_satp_mode =3D VM_1_10_SV57,
> +        .num_triggers =3D 11,
> +    ),
> +
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode =3D VM_1_10_SV57,
> --
> 2.43.0
>
>

