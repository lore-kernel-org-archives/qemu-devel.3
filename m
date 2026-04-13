Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF6EEBFD14
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCCYd-0005P7-B7; Mon, 13 Apr 2026 04:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wCCYa-0005OY-7o
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:22:08 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wCCYY-0002ln-Lj
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:22:07 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35d90833cacso2498697a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776068522; x=1776673322; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/72zsIH/4baL4+UZIEr2+z0FgfZcPzaYyDhUX/FcD4=;
 b=RNQXgoh2QTQgGuYBcgmgg9/b60ptYDOqJJG7g0dpMvOPz3HetuIhVKJhCTV7fs/OBT
 o9fW9Ko9v9ELDd8yH1YBYjMAlnlFu4D2tlcPEZxIaNmu7g+0Fy9bGhw7j3cAcqGVzDVT
 mDdIAq9DxoMGG2CirsRp8W+ddD+0JPMerzWkCqhaRjwS6aUl1q+DHPdTZdO1NGTwfUDu
 LD2iaAvTj52EUsFXqCZKQuLKR4nIEHFzRKnaVdEgyh8aJAqmWdZBDMhklDSX3liSPvZJ
 NYlRfRnj24vLKwfJ1O4N6RKuaAjhDqCW1+52g1pCLYvPuZgzcPWRKWcHrCgxUr0tew/B
 dk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776068522; x=1776673322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+/72zsIH/4baL4+UZIEr2+z0FgfZcPzaYyDhUX/FcD4=;
 b=LW/RnamoIku6Ge7XHzG5ChgS448Q1b0JSVYx7YyF1x0P/QURNcHSHxuxmkNivRxDQI
 o2vCZIWDKKPg8S5X2K0OzgIvf0FMlYkWdDNXqPUCIcVf/p8J7Cr2F53zNqlHXOJsL4St
 Iepm4PfytAC4ljlIh7a/iXyySzrdxLXM1Y0bXWrJa8JfoMbzo+69xt8EUbsz9lPOyG/z
 JkYZr3xaHqkvZFsccF47dhBC1rNwFXAwbjdBBrIPtCPci/IZyDibsTVNrftyDC58LzpQ
 HH9ppvRj1P7HNu3GGw2CdcZ9STT7r1frt0tL3lfTokvhFk5TmLi0ESBSk/xedUVxnUf5
 KcSQ==
X-Gm-Message-State: AOJu0Yy2pu/RTwO1BTUSmjhiUTBdNQOgUNiSZ8sr0ymA2MVKekg19srw
 sl55vfHJXZancdh/BmoRIPwBuLJFX17YtKXx5znTvXFX8+7i0bmTeGVTAyNx0bUxaH3VKIeulSd
 Htjgp8rXLLvlnA3A6iT1LBcC3SsrF6rZ0gXlmGjxnU0DcFJmN8Sil1LaCcv51aY4uzpk8Xt9lV0
 Me1Jt65DoJZXjTklHucpStNwWknNONpkcVkZo6zCa33dhCgmRz
X-Gm-Gg: AeBDieuBVbDtGgjuCNfcQYrx6abFAoHq+ZSHb6uq7kQzDeQqnxM3pyEfnsfuVIfVFu0
 hJtINMAuPxgUJJkzCMdiRYAsjlNRSjKB1IMnVyTxCEJCge87WdzhGFY96PuqNBZBynmzyl4lUi/
 RWUw2k1w+rB2Q94BbKmViyefwBtUnPRD7SHWN/TQF/uorTsSob3dPuNwWQ4rWm11e2UdChCYeBr
 O/RJCk9A3aiqPUK+8Y5bi/cTJEWjpEDbbLY6x1xp+gzK8mAJCo/tL21hEb6XK38OZTr/0KkRebS
 QktibFzuMK0vFV8cD+fFGRcLGt7h7pu6rrP+GJ6C8gQ2UZ1q/lXkqtYJ9V7UCN6O0ug1eWArPn1
 vLJcuWRZUOuF5F7A8zl5elRJ7ld9WgXLI35dFZGO6xi9uXImsdqbT6j4EXNd6rnvFQS/fgo5X2T
 Zd7aN1q7DxCUjISkG+0G4d/6Y7Ki8ZISvrHssOgnF9EvBIYeDOA5rfqsnbhX5se7YQ4w==
X-Received: by 2002:a17:90b:3d8e:b0:35b:929f:7e8d with SMTP id
 98e67ed59e1d1-35e4281d23cmr13096269a91.14.1776068522161; 
 Mon, 13 Apr 2026 01:22:02 -0700 (PDT)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com.
 [74.125.82.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fb1ed394csm3639478a91.11.2026.04.13.01.21.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 01:22:01 -0700 (PDT)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2d64c756111so3869395eec.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:21:59 -0700 (PDT)
X-Received: by 2002:a05:7300:f082:b0:2c1:7afc:df00 with SMTP id
 5a478bee46e88-2d589361d94mr6547058eec.30.1776068518458; Mon, 13 Apr 2026
 01:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-7-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260408140635.42546-7-zhiwei_liu@linux.alibaba.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 13 Apr 2026 16:21:47 +0800
X-Gmail-Original-Message-ID: <CANzO1D0aY3nMWo3AN-Fo0V612dJUb2aZ4iBUf59Gd=YHX+Uasg@mail.gmail.com>
X-Gm-Features: AQROBzCsnte2nkO0y7Ap5mtBuMorKGXCvjQb_R9ZJNV8tRnEKG3DBcElnayLlyw
Message-ID: <CANzO1D0aY3nMWo3AN-Fo0V612dJUb2aZ4iBUf59Gd=YHX+Uasg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] target/riscv: Enable SMMPT extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, 
 palmer@dabbelt.com, alistair23@gmail.com, daniel.barboza@oss.qualcomm.com, 
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102e.google.com
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

LIU Zhiwei <zhiwei_liu@linux.alibaba.com> =E6=96=BC 2026=E5=B9=B44=E6=9C=88=
9=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=883:29=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Frank Chang <frank.chang@sifive.com>

> ---
>  target/riscv/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index cb4ccd001d..1e49465eeb 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -225,8 +225,10 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
>      ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
> +    ISA_EXT_DATA_ENTRY(smmpt, PRIV_VERSION_1_13_0, ext_smmpt),
>      ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
>      ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
> +    ISA_EXT_DATA_ENTRY(smsdid, PRIV_VERSION_1_13_0, ext_smsdid),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>      ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
> @@ -1379,6 +1381,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>
>  /* These are experimental so mark with 'x-' */
>  const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] =3D {
> +    MULTI_EXT_CFG_BOOL("x-smmpt", ext_smmpt, false),
> +    MULTI_EXT_CFG_BOOL("x-smsdid", ext_smsdid, false),
>      MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
>
>      { },
> --
> 2.43.0
>
>

