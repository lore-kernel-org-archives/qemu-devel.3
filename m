Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B196FEBFD16
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCCXF-0004mV-CB; Mon, 13 Apr 2026 04:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wCCXC-0004lJ-On
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:20:42 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wCCXB-0002XC-9K
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:20:42 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35dac556bb2so2346106a91.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776068439; x=1776673239; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdVfur+gnSsW1Hvga4ktUnlVGHwCt2w73j2vqNjj3Yg=;
 b=S2eCRFjt2tufTiDvhg4zGht+4Z7qDRUUzYe8WuSpvRhiKZQqM6oJ3Oq8jLRXcWV7F4
 SVaswQxBGsjrX2bHTqDXnDorgW6bMQOCwXGgGgkWLTkf/gsnEc5zj+I9umAXqb6K0l+N
 Kl5wiuUzQYwQV5eTLa5AS/KT/17WVIqTogLKWRjudsZxQ0NLTrGDTXi/r6xlXXwH1b1E
 m3Z25gLbMjrm03RdR4wavixbZZsxfFlPKysPB6sYOeNJBQ33iPxoVlYIDRcFZ+7DXVId
 1ZrufgwUQ1iLYLdXGWV7bvtTZpwjmsYZokCE4+apU2FaOx6BWLmw7uwpcJcUFXN8sE0M
 OHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776068439; x=1776673239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IdVfur+gnSsW1Hvga4ktUnlVGHwCt2w73j2vqNjj3Yg=;
 b=EF/Ob+Prt2k3V6rSOxAE3IJC6CQHXG4D+I8QH/elGeCnenAcuyCi2/V2fEweJYCeU5
 SEONdIjGiXSLUFDfaYvAtlL5DnFVudvTK/a6PgLu9CxVcoPrDG6m3tCJpTwnRL6Sg0Gf
 jESCr/EkFKFYjQE1LRaB6ZWppnbo0o9G9nkG6Le0xkbLp/IWn/kWKV46O/xa5esIwyD0
 gHOwua9x95mnyEjujVNXo90qV0dvj/4fc+TcjBmghEm4FEjQyPFFE/aI5sBkgXOl0k/i
 Wa0tR5NNIO2xfvcd/wbjF51GiuTZHG8AJwNwNnwBObUgJEFntAoK+Wt9NpLX1uSo0/OX
 NS3Q==
X-Gm-Message-State: AOJu0YwjyrCCnyWPyZpDm+jLf6O0aY9mXCgzhNN+HOHzogx3wt6NBbc9
 PD5Ew/i5uxLvA9ZlNERK310vqn6+17t6fepHW3VEnANXItah0OF8IZo+EhhnCObt7Jy1X8FtNbf
 9e1BSGfbV4v7awbJT1Eiz4gvxpDPXYpL2lCmDtxKe6RKx+0vilJwhMOgZXWArDfPmot+/bl6yJy
 i1+ediC4CYsuyJDD5bXgEVn8ERb0s1N4dJu6YNpUmLvKjb4/R3
X-Gm-Gg: AeBDiet/BL+cBQcgS/dPymIX4DaoUXNMc9rJT8gwg+xxsUvSGe2YHHU5v3qeCeUuyxv
 DF67kYXT1+sAHuNOseoBLJUMZMMbJEpN42SBzKVKTPFa9NRXOcXzpgLBwhM+5FlQYU1+ndV5UAh
 0jIWjZEuapROIz0uxDvvObN5l00588ldgLdFqRcXI7iXiHX22kKlw2YcEWF3Qzdd0j8Ef6IeIDL
 C9cCZr0WEXgZ+mN60Dz0M+pNNSp3wjQ1H0qlDz3I7eClIGB+FOpBUhsCU6jyju5bn1O34AslDNm
 ayCBXY2ht063Vgq0ImOyICF6X4QLuugbO6M9UhNHFYP/OdDuvNsDlH8ut9jBmMyqTtX5f7PgEnH
 LLEsMUGqSdFz1OE7msUvKKaNcQY0pulx5BYx1+kPxshzDeznenz74e5TC/UWYugl/XeQQHDPuSI
 P9Ayq09KXJUVsV+XoMOk9XnPWEIrriOA3hi159taI5je7po6y/AIjKb6kbbvBjWr1OEQ==
X-Received: by 2002:a17:90a:2ce6:b0:35e:d012:5a39 with SMTP id
 98e67ed59e1d1-35ed0127277mr2907685a91.14.1776068438842; 
 Mon, 13 Apr 2026 01:20:38 -0700 (PDT)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com.
 [74.125.82.174]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fb37d6e36sm3398956a91.16.2026.04.13.01.20.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 01:20:37 -0700 (PDT)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2d868d014a5so806187eec.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:20:37 -0700 (PDT)
X-Received: by 2002:a05:693c:2b01:b0:2ce:d5d7:f537 with SMTP id
 5a478bee46e88-2d589dafca1mr6294246eec.30.1776068436464; Mon, 13 Apr 2026
 01:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-6-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260408140635.42546-6-zhiwei_liu@linux.alibaba.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 13 Apr 2026 16:20:25 +0800
X-Gmail-Original-Message-ID: <CANzO1D2hEEbz6uT6QJ_e0tRKNAz8C=MVVRRbk6Cd5=zvC4F4gA@mail.gmail.com>
X-Gm-Features: AQROBzALrUHGbYYxr-jx34tDn8Nof7DYDnybzsWOCs62fOaE8ukd8C_IRwaKdf8
Message-ID: <CANzO1D2hEEbz6uT6QJ_e0tRKNAz8C=MVVRRbk6Cd5=zvC4F4gA@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] target/riscv: Fix smrnmi isa alphabetical order
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, 
 palmer@dabbelt.com, alistair23@gmail.com, daniel.barboza@oss.qualcomm.com, 
 liwei1518@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>

LIU Zhiwei <zhiwei_liu@linux.alibaba.com> =E6=96=BC 2026=E5=B9=B44=E6=9C=88=
9=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=882:36=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8ac935ac06..cb4ccd001d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -224,9 +224,9 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
> -    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>      ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
>      ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
> +    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>      ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
> --
> 2.43.0
>
>

