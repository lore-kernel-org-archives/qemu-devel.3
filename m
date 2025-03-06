Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAD2C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpzUf-0006D1-IW; Wed, 05 Mar 2025 19:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzUY-0006Ca-MA
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:53:39 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzUU-00033b-Rh
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:53:38 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5236d34a37fso42941e0c.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 16:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741222413; x=1741827213; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+U+TvEEDuFcwl0xschQMrC/q11rVSkEGofUQ72bapc=;
 b=VlKGCFwhs9XfRNmayTkgjeqeuoSICU5n3FJgzkQpVEfM0tTTPGg9RLey3CmDNOw++F
 x/Dmjog7OYnqLFSbWEVRImyfMyOUlFg955E3K1gDO5t8WUICo5s6n6lH0IpammQNySef
 5B0rHo9aebwN51jLVta1M6Rq2krzjI0Gsl/qLT01R2QhZpW8dQ0BJ4H6daqeKgIkXe28
 Zy7tdspD03b8l/YW8RANEh0BOHXrlwX7GYEXHyMmkuVABUz9cIFz8tX98gqqvotPnyKj
 945CX6K9LzrFSOmkvjugI2z5lG7QChMLppEBcNF5t/4j6atw8vjDIikeUPMUdyLW7fx+
 8WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741222413; x=1741827213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+U+TvEEDuFcwl0xschQMrC/q11rVSkEGofUQ72bapc=;
 b=JOtQ1gT87o9SltpAFeQ+rg6TOyyYVy1HEaAPdhPAIlNrcWonpepr0HljDGNwJ/ABJy
 TEo3sKiM5fGQg/vwmEaf6MO9QPX54uQCLGbSN1ejPdTY0C1MIFiWVtld7ogrkhgqiBY/
 QDpRPXMzJznaPCGu/xbHeYwOb+6sikQLYYGfMhZa50Zh7nhxrKuhGC/2ZqeOzfIEToMJ
 nTG/zfUBNIj+ThuT86TDOYpG3S462dDaFcBlG+/JWs748LI6hrY6jNDzO7wISOPFFZK9
 3070hvtJt0uMacxOH+2CzB+RjcB/RrG5AvGXCbMqrw3p3jNev3BgF73i2kh1uyVcXO+i
 EoeQ==
X-Gm-Message-State: AOJu0Yw1zUW5DAkEJr3tj1f6lclc0ZKYz0cGJNjbgq2++iXVgUf75Y7L
 MqrF70Icmx8DaRT7nfNnnIRilm2joKxX2ON+1HIyA0Hqyr906h9YLvb8oWF0SC61D5Xq49ZNk47
 aqdmmHk142l/FBaixAGkSookfliAJcpzMiDQ=
X-Gm-Gg: ASbGncsOfPWxbZTl6amcVVbYxD4BpU2gKbKAoIFNDRGcb4/zLE2AiMUZmEY8Iuof+X1
 NRg0oCt2d6l+UXHJWGsudeHKrPF7NaRl6QGcllPi86rzr57kXse+mlSHjX4rFeJvk+9AZ4Vtpkz
 1jXbPIcimOWCM/wYRfD+5q86s8fE9ZmkpF8LrPtClz4hpWvZU6WuZ4sjep
X-Google-Smtp-Source: AGHT+IH5qoU75FKrQo/3iz76aERy88KDoGhh8zUCcvXriF2xLIct0xnxQ4RSI6GnX/LsDt8BzoS+dzdyGSqmhgTPDuM=
X-Received: by 2002:a05:6102:cc8:b0:4c1:76a4:aee4 with SMTP id
 ada2fe7eead31-4c2e2920621mr3504015137.19.1741222413509; Wed, 05 Mar 2025
 16:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20250228102747.867770-1-pbonzini@redhat.com>
 <20250228102747.867770-7-pbonzini@redhat.com>
In-Reply-To: <20250228102747.867770-7-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 10:53:07 +1000
X-Gm-Features: AQ5f1JpbE2pn6s38YFsIeicifqNP9Ns5Xi3XLyCefqpm3HPjFxX4Wnh29ubhw0E
Message-ID: <CAKmqyKN2Z_ZOwQw=99-iD5eCbw-M4NfvrVmOCRpd4TSWPecbQA@mail.gmail.com>
Subject: Re: [PATCH 06/22] target/riscv: move RISCVCPUConfig fields to a
 header file
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Fri, Feb 28, 2025 at 8:31=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> To support merging a subclass's RISCVCPUDef into the superclass, a list
> of all the CPU features is needed.  Put them into a header file that
> can be included multiple times, expanding the macros BOOL_FIELD and
> TYPE_FIELD to different operations.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_cfg.h            | 160 +---------------------------
>  target/riscv/cpu_cfg_fields.h.inc | 167 ++++++++++++++++++++++++++++++
>  2 files changed, 170 insertions(+), 157 deletions(-)
>  create mode 100644 target/riscv/cpu_cfg_fields.h.inc
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 7b7067d5bee..e9bf75730a6 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -22,163 +22,9 @@
>  #define RISCV_CPU_CFG_H
>
>  struct RISCVCPUConfig {
> -    bool ext_zba;
> -    bool ext_zbb;
> -    bool ext_zbc;
> -    bool ext_zbkb;
> -    bool ext_zbkc;
> -    bool ext_zbkx;
> -    bool ext_zbs;
> -    bool ext_zca;
> -    bool ext_zcb;
> -    bool ext_zcd;
> -    bool ext_zce;
> -    bool ext_zcf;
> -    bool ext_zcmp;
> -    bool ext_zcmt;
> -    bool ext_zk;
> -    bool ext_zkn;
> -    bool ext_zknd;
> -    bool ext_zkne;
> -    bool ext_zknh;
> -    bool ext_zkr;
> -    bool ext_zks;
> -    bool ext_zksed;
> -    bool ext_zksh;
> -    bool ext_zkt;
> -    bool ext_zifencei;
> -    bool ext_zicntr;
> -    bool ext_zicsr;
> -    bool ext_zicbom;
> -    bool ext_zicbop;
> -    bool ext_zicboz;
> -    bool ext_zicfilp;
> -    bool ext_zicfiss;
> -    bool ext_zicond;
> -    bool ext_zihintntl;
> -    bool ext_zihintpause;
> -    bool ext_zihpm;
> -    bool ext_zimop;
> -    bool ext_zcmop;
> -    bool ext_ztso;
> -    bool ext_smstateen;
> -    bool ext_sstc;
> -    bool ext_smcdeleg;
> -    bool ext_ssccfg;
> -    bool ext_smcntrpmf;
> -    bool ext_smcsrind;
> -    bool ext_sscsrind;
> -    bool ext_ssdbltrp;
> -    bool ext_smdbltrp;
> -    bool ext_svadu;
> -    bool ext_svinval;
> -    bool ext_svnapot;
> -    bool ext_svpbmt;
> -    bool ext_svvptc;
> -    bool ext_svukte;
> -    bool ext_zdinx;
> -    bool ext_zaamo;
> -    bool ext_zacas;
> -    bool ext_zama16b;
> -    bool ext_zabha;
> -    bool ext_zalrsc;
> -    bool ext_zawrs;
> -    bool ext_zfa;
> -    bool ext_zfbfmin;
> -    bool ext_zfh;
> -    bool ext_zfhmin;
> -    bool ext_zfinx;
> -    bool ext_zhinx;
> -    bool ext_zhinxmin;
> -    bool ext_zve32f;
> -    bool ext_zve32x;
> -    bool ext_zve64f;
> -    bool ext_zve64d;
> -    bool ext_zve64x;
> -    bool ext_zvbb;
> -    bool ext_zvbc;
> -    bool ext_zvkb;
> -    bool ext_zvkg;
> -    bool ext_zvkned;
> -    bool ext_zvknha;
> -    bool ext_zvknhb;
> -    bool ext_zvksed;
> -    bool ext_zvksh;
> -    bool ext_zvkt;
> -    bool ext_zvkn;
> -    bool ext_zvknc;
> -    bool ext_zvkng;
> -    bool ext_zvks;
> -    bool ext_zvksc;
> -    bool ext_zvksg;
> -    bool ext_zmmul;
> -    bool ext_zvfbfmin;
> -    bool ext_zvfbfwma;
> -    bool ext_zvfh;
> -    bool ext_zvfhmin;
> -    bool ext_smaia;
> -    bool ext_ssaia;
> -    bool ext_sscofpmf;
> -    bool ext_smepmp;
> -    bool ext_smrnmi;
> -    bool ext_ssnpm;
> -    bool ext_smnpm;
> -    bool ext_smmpm;
> -    bool ext_sspm;
> -    bool ext_supm;
> -    bool rvv_ta_all_1s;
> -    bool rvv_ma_all_1s;
> -    bool rvv_vl_half_avl;
> -
> -    uint32_t mvendorid;
> -    uint64_t marchid;
> -    uint64_t mimpid;
> -
> -    /* Named features  */
> -    bool ext_svade;
> -    bool ext_zic64b;
> -    bool ext_ssstateen;
> -    bool ext_sha;
> -
> -    /*
> -     * Always 'true' booleans for named features
> -     * TCG always implement/can't be user disabled,
> -     * based on spec version.
> -     */
> -    bool has_priv_1_13;
> -    bool has_priv_1_12;
> -    bool has_priv_1_11;
> -
> -    /* Vendor-specific custom extensions */
> -    bool ext_xtheadba;
> -    bool ext_xtheadbb;
> -    bool ext_xtheadbs;
> -    bool ext_xtheadcmo;
> -    bool ext_xtheadcondmov;
> -    bool ext_xtheadfmemidx;
> -    bool ext_xtheadfmv;
> -    bool ext_xtheadmac;
> -    bool ext_xtheadmemidx;
> -    bool ext_xtheadmempair;
> -    bool ext_xtheadsync;
> -    bool ext_XVentanaCondOps;
> -
> -    uint32_t pmu_mask;
> -    uint16_t vlenb;
> -    uint16_t elen;
> -    uint16_t cbom_blocksize;
> -    uint16_t cbop_blocksize;
> -    uint16_t cboz_blocksize;
> -    bool mmu;
> -    bool pmp;
> -    bool debug;
> -    bool misa_w;
> -
> -    bool short_isa_string;
> -
> -#ifndef CONFIG_USER_ONLY
> -    int8_t max_satp_mode;
> -#endif
> +#define BOOL_FIELD(x) bool x;
> +#define TYPED_FIELD(type, x) type x;
> +#include "cpu_cfg_fields.h.inc"
>  };
>
>  typedef struct RISCVCPUConfig RISCVCPUConfig;
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> new file mode 100644
> index 00000000000..a42f298017f
> --- /dev/null
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -0,0 +1,167 @@
> +/*
> + * Required definitions before including this file:
> + *
> + * #define BOOL_FIELD(x)
> + * #define TYPED_FIELD(type, x)
> + */
> +
> +BOOL_FIELD(ext_zba)
> +BOOL_FIELD(ext_zbb)
> +BOOL_FIELD(ext_zbc)
> +BOOL_FIELD(ext_zbkb)
> +BOOL_FIELD(ext_zbkc)
> +BOOL_FIELD(ext_zbkx)
> +BOOL_FIELD(ext_zbs)
> +BOOL_FIELD(ext_zca)
> +BOOL_FIELD(ext_zcb)
> +BOOL_FIELD(ext_zcd)
> +BOOL_FIELD(ext_zce)
> +BOOL_FIELD(ext_zcf)
> +BOOL_FIELD(ext_zcmp)
> +BOOL_FIELD(ext_zcmt)
> +BOOL_FIELD(ext_zk)
> +BOOL_FIELD(ext_zkn)
> +BOOL_FIELD(ext_zknd)
> +BOOL_FIELD(ext_zkne)
> +BOOL_FIELD(ext_zknh)
> +BOOL_FIELD(ext_zkr)
> +BOOL_FIELD(ext_zks)
> +BOOL_FIELD(ext_zksed)
> +BOOL_FIELD(ext_zksh)
> +BOOL_FIELD(ext_zkt)
> +BOOL_FIELD(ext_zifencei)
> +BOOL_FIELD(ext_zicntr)
> +BOOL_FIELD(ext_zicsr)
> +BOOL_FIELD(ext_zicbom)
> +BOOL_FIELD(ext_zicbop)
> +BOOL_FIELD(ext_zicboz)
> +BOOL_FIELD(ext_zicfilp)
> +BOOL_FIELD(ext_zicfiss)
> +BOOL_FIELD(ext_zicond)
> +BOOL_FIELD(ext_zihintntl)
> +BOOL_FIELD(ext_zihintpause)
> +BOOL_FIELD(ext_zihpm)
> +BOOL_FIELD(ext_zimop)
> +BOOL_FIELD(ext_zcmop)
> +BOOL_FIELD(ext_ztso)
> +BOOL_FIELD(ext_smstateen)
> +BOOL_FIELD(ext_sstc)
> +BOOL_FIELD(ext_smcdeleg)
> +BOOL_FIELD(ext_ssccfg)
> +BOOL_FIELD(ext_smcntrpmf)
> +BOOL_FIELD(ext_smcsrind)
> +BOOL_FIELD(ext_sscsrind)
> +BOOL_FIELD(ext_ssdbltrp)
> +BOOL_FIELD(ext_smdbltrp)
> +BOOL_FIELD(ext_svadu)
> +BOOL_FIELD(ext_svinval)
> +BOOL_FIELD(ext_svnapot)
> +BOOL_FIELD(ext_svpbmt)
> +BOOL_FIELD(ext_svvptc)
> +BOOL_FIELD(ext_svukte)
> +BOOL_FIELD(ext_zdinx)
> +BOOL_FIELD(ext_zaamo)
> +BOOL_FIELD(ext_zacas)
> +BOOL_FIELD(ext_zama16b)
> +BOOL_FIELD(ext_zabha)
> +BOOL_FIELD(ext_zalrsc)
> +BOOL_FIELD(ext_zawrs)
> +BOOL_FIELD(ext_zfa)
> +BOOL_FIELD(ext_zfbfmin)
> +BOOL_FIELD(ext_zfh)
> +BOOL_FIELD(ext_zfhmin)
> +BOOL_FIELD(ext_zfinx)
> +BOOL_FIELD(ext_zhinx)
> +BOOL_FIELD(ext_zhinxmin)
> +BOOL_FIELD(ext_zve32f)
> +BOOL_FIELD(ext_zve32x)
> +BOOL_FIELD(ext_zve64f)
> +BOOL_FIELD(ext_zve64d)
> +BOOL_FIELD(ext_zve64x)
> +BOOL_FIELD(ext_zvbb)
> +BOOL_FIELD(ext_zvbc)
> +BOOL_FIELD(ext_zvkb)
> +BOOL_FIELD(ext_zvkg)
> +BOOL_FIELD(ext_zvkned)
> +BOOL_FIELD(ext_zvknha)
> +BOOL_FIELD(ext_zvknhb)
> +BOOL_FIELD(ext_zvksed)
> +BOOL_FIELD(ext_zvksh)
> +BOOL_FIELD(ext_zvkt)
> +BOOL_FIELD(ext_zvkn)
> +BOOL_FIELD(ext_zvknc)
> +BOOL_FIELD(ext_zvkng)
> +BOOL_FIELD(ext_zvks)
> +BOOL_FIELD(ext_zvksc)
> +BOOL_FIELD(ext_zvksg)
> +BOOL_FIELD(ext_zmmul)
> +BOOL_FIELD(ext_zvfbfmin)
> +BOOL_FIELD(ext_zvfbfwma)
> +BOOL_FIELD(ext_zvfh)
> +BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_smaia)
> +BOOL_FIELD(ext_ssaia)
> +BOOL_FIELD(ext_sscofpmf)
> +BOOL_FIELD(ext_smepmp)
> +BOOL_FIELD(ext_smrnmi)
> +BOOL_FIELD(ext_ssnpm)
> +BOOL_FIELD(ext_smnpm)
> +BOOL_FIELD(ext_smmpm)
> +BOOL_FIELD(ext_sspm)
> +BOOL_FIELD(ext_supm)
> +BOOL_FIELD(rvv_ta_all_1s)
> +BOOL_FIELD(rvv_ma_all_1s)
> +BOOL_FIELD(rvv_vl_half_avl)
> +/* Named features  */
> +BOOL_FIELD(ext_svade)
> +BOOL_FIELD(ext_zic64b)
> +BOOL_FIELD(ext_ssstateen)
> +BOOL_FIELD(ext_sha)
> +
> +/*
> + * Always 'true' booleans for named features
> + * TCG always implement/can't be user disabled,
> + * based on spec version.
> + */
> +BOOL_FIELD(has_priv_1_13)
> +BOOL_FIELD(has_priv_1_12)
> +BOOL_FIELD(has_priv_1_11)
> +
> +/* Vendor-specific custom extensions */
> +BOOL_FIELD(ext_xtheadba)
> +BOOL_FIELD(ext_xtheadbb)
> +BOOL_FIELD(ext_xtheadbs)
> +BOOL_FIELD(ext_xtheadcmo)
> +BOOL_FIELD(ext_xtheadcondmov)
> +BOOL_FIELD(ext_xtheadfmemidx)
> +BOOL_FIELD(ext_xtheadfmv)
> +BOOL_FIELD(ext_xtheadmac)
> +BOOL_FIELD(ext_xtheadmemidx)
> +BOOL_FIELD(ext_xtheadmempair)
> +BOOL_FIELD(ext_xtheadsync)
> +BOOL_FIELD(ext_XVentanaCondOps)
> +
> +BOOL_FIELD(mmu)
> +BOOL_FIELD(pmp)
> +BOOL_FIELD(debug)
> +BOOL_FIELD(misa_w)
> +
> +BOOL_FIELD(short_isa_string)
> +
> +TYPED_FIELD(uint32_t, mvendorid)
> +TYPED_FIELD(uint64_t, marchid)
> +TYPED_FIELD(uint64_t, mimpid)
> +
> +TYPED_FIELD(uint32_t, pmu_mask)
> +TYPED_FIELD(uint16_t, vlenb)
> +TYPED_FIELD(uint16_t, elen)
> +TYPED_FIELD(uint16_t, cbom_blocksize)
> +TYPED_FIELD(uint16_t, cbop_blocksize)
> +TYPED_FIELD(uint16_t, cboz_blocksize)
> +
> +#ifndef CONFIG_USER_ONLY
> +TYPED_FIELD(int8_t, max_satp_mode)
> +#endif
> +
> +#undef BOOL_FIELD
> +#undef TYPED_FIELD
> --
> 2.48.1
>
>

