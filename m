Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37B606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E2jxBgMp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEP2-0000rG-59; Fri, 23 Oct 2026 08:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEOq-0000qj-Jm
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:29:33 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEOm-0004TA-2n
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:29:30 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ab38a051aaso7948177b3.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792758567; cv=none;
 d=google.com; s=arc-20260327;
 b=FZUElgESrI2GGSYVHwyJl44ljeWImme1chiwLqiJGYQzuTV67mvURzww2bYA7cqlbC
 QCczrshs/ixCgM817RfkK3ysV/ZQeQuAMMkSkrCtdCsx/iQC/8H0xwgAE+ILpaHOepXV
 6EbAS3bYRpgPisR+sYSksTaYdVAgEHoJIaOBIJAIfHztejmXeOiaXl088uLnafo8O+w/
 m9skZXom1MBV2RND1/koNU2BzKnwPYZYsLF56NFstLeca9IfjOue4rOpCEa4tXGJ5f1n
 ryxexx1EiOe3E+0JFBL79NmoabMP1T4do1EHPFtdCRnnEcORvgKnNZ9TUdDIxA5OXpQe
 k0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4YZAGZDx7IhYcqVvBvHlwEMnU40NIq3uzYxo/jNYcu4=;
 fh=Ooov+i9AeS1BcC1vonK1zlp0+cy8hPMIIb5HY6/nc/g=;
 b=CcOzwfdmjh8g74TNF9jmLVaGwaLqM4xDHTsLEg7pvFzGw2lqesmHJTP+p9JX3KlHNP
 LdfO0UTmuiUg1dlzt7/p7aOcXdO1aQGxKbAw0GJsxDLGac9R9lgsMCwI0gTH94S74Bq0
 v9z4CfkOzhjdBTbcrwE7UIVTP9srHxh98Dpj/NhquNTRagvLaERrsDZmGch08k88dj6S
 EXu4wLZBVEjnHjIy28QfpgFAzUWiAgmnxF4SyzIOh93Ea79aqvG7LYcDkl979Wq4vDma
 dwqYehM0hQQbxoL3lyBLDXro9FGa/o2QgRkoNnol7vB9tIX0Dn7iwMTzaXVmgDe40b9S
 mxXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792758567; x=1793363367; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4YZAGZDx7IhYcqVvBvHlwEMnU40NIq3uzYxo/jNYcu4=;
 b=E2jxBgMpdrIP2Ys7tTSzPPHe5nCYzXi03DKee27PO5S3orJRXEjHBxm6WskNFwHgcn
 J9pWKBro3baggIoNXCoooP5Mm8Khn4pnNpixMbSTwm46WWN2IhUWRkJMvkAZNIF2l72W
 odIVIyo/zE9y7RkeQDk0txukll3u3jw6KlMpmnKz173DxvSVE3Dfcw4G4nMTr4IgSQ3d
 io8kx/aXyQwI76PZG+0CBZDIzcB7kaZhLv+MgHq4glX+83i+FUUAA5OBh831RQHefFM6
 i88yEhPu+Hc3kiA+nSFpjP/iGuMOXdJPJpA7pH8x3sBLOlrY8e9EsoZMtSdMM4a3UJLE
 f+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792758567; x=1793363367;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4YZAGZDx7IhYcqVvBvHlwEMnU40NIq3uzYxo/jNYcu4=;
 b=WbuJXciKMgyqjn25LC6u+YRoNOwnKY1pW/ryjJe8M6AGOtwyfdPl6l7OA5bbGBWTlP
 jMRBP/n2S7smpMkShuyxGBib3t3GrpFA0CBkqx6eAreDxriByEBZHwrHrUfrpCxAfSEe
 JALk6ZjriIw1rmHFBC6+XvNBNHavrOiregLUr2E7LDj+0KJ4+I/yI+0UHEPf4hAjixhp
 1/+ZG0SF/wY/U4bW3G7wWvjlckIrMZ1QlCcbb+Ff4xbev09833Zr4/zjJR43fcZRzxQt
 N7vQ7KLcOj0boLzkl+0fBUAmVom3mfyI0Gp+3+lkXH8SbgkhEEXtuZV2Gv70hZh3uEhx
 D00w==
X-Gm-Message-State: AFq9FYL37YTpmvteeRdMdR6nImIASWvvAndmoUKRlu3jd4GICyXQM+Ts
 FQm3s2d4mtpUWd76XkaWXEKB0DD0FXKsICfKo6TaBTVzMmlxjlg4ruomLbW9u83D9u6xSbX7kAg
 6EFjCZxn5IfHGvdwA0b5llcCEv93e2Jm1gN9xFUy25Q==
X-Gm-Gg: AYBFou149dkWD/rdNe/e8Za5nNiKcyfqKi01UKLccEd/NJDL1G9qX+JMBqzH0/TeP+9
 c/maJyzW0GtDALAqNVGvn7E6AzoZDokT7n7+zWkq4+NM8TqOA3VQsSvsxlxcQ371m+A21H66NlY
 Jb5i3SlUQ0dU1rJQ8mQqCyNyU8NmQd5dNn7uU1pFUd/OC2R7n++vw+IOw7OXHZ/b1oJ+QgG6jNw
 MY7u+thC1p0VMc1+vc8RYtN9DiypGvM59Pf+YolfYfJdGngKmRuVV+MUfIPbp5pb2e+QXMZaKPZ
 VLQ75aTmbZxAtp2G+mF7cJL7C+h6nkxaztAUn9VBCU/SgVa1t35Aw10WfeUWZKowGHYX7w6LV54
 WmqKKM9nHrsbCEhG8Kq40zs0g8QZEjinOqqsMje3AsduB9BugYIAvYK/Ehio5C+q8L+FS6NRIcj
 g4iD8UX/qcd3EUeBaH0GEn0aRBcoNUhl/Sij12JmZ9vQ==
X-Received: by 2002:a05:690c:f07:b0:890:c0ab:2303 with SMTP id
 00721157ae682-8b157cf460amr16460077b3.21.1792758566544; Fri, 23 Oct 2026
 05:29:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
 <20261022213647.21665-7-mohamed@unpredictable.fr>
In-Reply-To: <20261022213647.21665-7-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 13:29:14 +0100
X-Gm-Features: AclHuK9wBflQsqTb9s62TrIDbGQoLFyMTLecgm1h43H2ahBknPaMeV-aAaHCu-0
Message-ID: <CAFEAcA8B8iGW0hcfyOSzCZa-wByuguGS8c2NeLP4_u+dVVJLCA@mail.gmail.com>
Subject: Re: [PATCH 6/6] hvf: arm: fetch more features
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 22:37, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> macOS 27.0 has some more feature registers available. Fetch them (but not using the values yet).
>
> Also fetch DCZID_EL0 at the same time.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  target/arm/hvf/hvf.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index e813f14ed4..3426fcdb86 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1142,16 +1142,14 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      } regs[] = {
>          { HV_FEATURE_REG_ID_AA64PFR0_EL1, ID_AA64PFR0_EL1_IDX },
>          { HV_FEATURE_REG_ID_AA64PFR1_EL1, ID_AA64PFR1_EL1_IDX },
> -        /* Add ID_AA64PFR2_EL1 here when HVF supports it */
>          { HV_FEATURE_REG_ID_AA64DFR0_EL1, ID_AA64DFR0_EL1_IDX },
>          { HV_FEATURE_REG_ID_AA64DFR1_EL1, ID_AA64DFR1_EL1_IDX },
>          { HV_FEATURE_REG_ID_AA64ISAR0_EL1, ID_AA64ISAR0_EL1_IDX },
>          { HV_FEATURE_REG_ID_AA64ISAR1_EL1, ID_AA64ISAR1_EL1_IDX },
> -        /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
>          { HV_FEATURE_REG_ID_AA64MMFR0_EL1, ID_AA64MMFR0_EL1_IDX },
>          { HV_FEATURE_REG_ID_AA64MMFR1_EL1, ID_AA64MMFR1_EL1_IDX },
>          { HV_FEATURE_REG_ID_AA64MMFR2_EL1, ID_AA64MMFR2_EL1_IDX },
> -        /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
> +        { HV_FEATURE_REG_DCZID_EL0, DCZID_EL0_IDX},
>      };
>      hv_return_t r = HV_SUCCESS;
>      hv_vcpu_config_t config = hv_vcpu_config_create();
> @@ -1191,6 +1189,22 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          }
>      }
>
> +    if (__builtin_available(macOS 27.0, *)) {
> +        static const struct isar_regs {
> +            hv_feature_reg_t reg;
> +            ARMIDRegisterIdx index;
> +        } new_regs[] = {
> +        {HV_FEATURE_REG_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_IDX},
> +        {HV_FEATURE_REG_ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_IDX},
> +        {HV_FEATURE_REG_ID_AA64MMFR3_EL1, ID_AA64MMFR3_EL1_IDX},
> +        {HV_FEATURE_REG_ID_AA64MMFR4_EL1, ID_AA64MMFR4_EL1_IDX},

Spaces after { and before } to match the existing code, please.

> +        };
> +        for (i = 0; i < ARRAY_SIZE(new_regs); i++) {
> +            r |= hv_vcpu_config_get_feature_reg(config, new_regs[i].reg,
> +                                            &host_isar.idregs[new_regs[i].index]);
> +        }
> +    }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I note that we now have three places in this function which duplicate
this "array which repeats the definition of struct isar_regs, and loop
around calling hv_vcpu_config_get_feature_reg()" pattern. We could
factor that out into a proper typedef for the struct and a helper
function that does the "iterate through getting the values" part.

thanks
-- PMM

