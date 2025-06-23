Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA35CC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTefV-000606-Fj; Mon, 23 Jun 2025 06:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTefT-0005zD-UB
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:44:51 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTefO-0003FS-Hf
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:44:51 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-711d4689084so40483777b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750675485; x=1751280285; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W07pgc47ZblesW2OIZ47UFpwON5zet/C11t6LuhqptI=;
 b=LeUcHp7K1OPMs25qCP6CRrwJwS00tZx+zqc3jCFmKp9Chku6yt3fFKYe6/SRk/DRcm
 PAzOY5t01eO43y10P6Vl8060xjHsaUC5ad4Y/G2X/gQoTUQloLsN81DPLBIPwTc8hqPg
 mqdDbZiht8kZ7dPl7oqLVqWW4DND7mR2FVNQtMLhzomrBFDedUmsrxlr3fORm5zImDGl
 vWChaDBq/GTNIFH6AoT30iz9AJKhqf0+DI3lPrzzlG+s3Vdl0BQH2p9JUxLHvJJUgqjz
 Duj0q4ix8CJ/hEqG9puOHF4WIRvEjG6akZx67fP1DOsB/omaiud9tVyYC4Pq3hCqQttc
 nEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750675485; x=1751280285;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W07pgc47ZblesW2OIZ47UFpwON5zet/C11t6LuhqptI=;
 b=GzgJZqrR0wgVEnl8MTC7SFcNt2YmHDQPgcQV1VFdmk0/bDdp8OHY4S9Dycae5vSVLM
 Lzfr8N7he47pXMS/I9F6nIqy9IEuFNZo3NFmOCsczPGPHhkCRHCxoZQRyl+2qyeLznxH
 6CD/+GNVLK6bU5JKYvjBYSn3QnqhvsYydM/MxjL86dA4IBRgeYblH0dEuW2MAKU47otX
 w/uIKaskiWtPGtXdbzZNYpEQcpERxQqU1WfCQ6cfXu6aUZszotH0jOX2XJEpoVevEGgz
 hUrOSx7j6vAWHgLgWfL8W5otSTpVBtf0psA7fxR/2SfAbl6EfvYCh1ShtA2aGZr5jZ6y
 8fBQ==
X-Gm-Message-State: AOJu0Yw7hgWnxWrzVJzTP/mMd0/48vUt7BxpwVBAABch466X9lNTYTuB
 v7E341tfxGJDvCgLi4fqjbPy/cMX7MAc1jCAs7iWlVM/BaXPHQIO09VBfGaRhP0A72ygmERfDzv
 cD5A67ms5ccKXlHDMpALhdAzKcPSuzN4QkRCJFOMJNShpDVvS1j0w
X-Gm-Gg: ASbGnctx5qdmVCV31+j80a+37F4oWeopf+2aTwtyFaf7A3zPyfAzDPjuAwTuzHi919K
 ZglzU4DqynA9jO5lehUe+qwB+siyaEFUzZlv4mRaWzVojxAwGiXulHYUlBOmiK/cMUsGdaz2rcj
 WWElwtFTkvfKXX945pQH4DcV12MVaAYq0fRSWBlfmCbONR
X-Google-Smtp-Source: AGHT+IGJNBt8if9LrTuA3eyhXPbeviTT6ArT2UTpstv61gF3eKx24Yh/tWeOVDTg1fTXcm6/4T+lokg8FO9Ejj2Jzzs=
X-Received: by 2002:a05:690c:a9a:b0:70b:6651:b3e2 with SMTP id
 00721157ae682-712c63b17f4mr178308687b3.6.1750675485068; Mon, 23 Jun 2025
 03:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-16-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:44:33 +0100
X-Gm-Features: AX0GCFt7CTCBVNlmqlasLmvWrxm8Ecrvjg8GFmo-ruYd8lzzhJraowwRC50LHGs
Message-ID: <CAFEAcA-VMzZZSsXij0wuyT142vZppEfjXWUd0z=zW=x51z3mAg@mail.gmail.com>
Subject: Re: [PATCH v2 015/101] target/arm: Add isar feature tests for SME2,
 SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Sun, 22 Jun 2025 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h | 55 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 4452e7c21e..650abcb054 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -931,6 +931,11 @@ static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
>      return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SVEVER) != 0;
>  }
>
> +static inline bool isar_feature_aa64_sve2p1(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SVEVER) >= 2;
> +}
> +
>  static inline bool isar_feature_aa64_sve2_aes(const ARMISARegisters *id)
>  {
>      return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) != 0;
> @@ -976,6 +981,11 @@ static inline bool isar_feature_aa64_sve_f64mm(const ARMISARegisters *id)
>      return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F64MM) != 0;
>  }
>
> +static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, B16B16) != 0;
> +}
> +
>  static inline bool isar_feature_aa64_sme_f64f64(const ARMISARegisters *id)
>  {
>      return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, F64F64);
> @@ -991,6 +1001,51 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
>      return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, FA64);
>  }
>
> +static inline bool isar_feature_aa64_sme2(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, SMEVER) != 0;
> +}
> +
> +static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, SMEVER) >= 2;
> +}
> +
> +static inline bool isar_feature_aa64_sme2_i16i64(const ARMISARegisters *id)
> +{
> +    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_i16i64(id);
> +}

I think we should put these "utility" functions that are
testing for a combination of architectural features in their
own section of this header, in the same way that we separate
out 'Feature tests for "does this exist in either 32-bit or 64-bit?"'.
(I assume the reason we want them rather than just having the
caller open-code the "sme2 && i64i64" is so we can use them in
a macro or something later on?)

> +
> +static inline bool isar_feature_aa64_sme2_f64f64(const ARMISARegisters *id)
> +{
> +    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_f64f64(id);
> +}
> +
> +static inline bool isar_feature_aa64_sme2_b16b16(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, B16B16) != 0;
> +}

This is FEAT_SME_B16B16, not FEAT_SME2_B16B16; we should follow the
architectural feature name in our function name here, I think.

> +
> +static inline bool isar_feature_aa64_sme2_f16f16(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, F16F16) != 0;
> +}

Similarly, sme_f16f16.

> +
> +static inline bool isar_feature_aa64_sme_or_sve2p1(const ARMISARegisters *id)
> +{
> +    return isar_feature_aa64_sme(id) || isar_feature_aa64_sve2p1(id);
> +}
> +
> +static inline bool isar_feature_aa64_sme2_or_sve2p1(const ARMISARegisters *id)
> +{
> +    return isar_feature_aa64_sme2(id) || isar_feature_aa64_sve2p1(id);
> +}
> +
> +static inline bool isar_feature_aa64_sme2p1_or_sve2p1(const ARMISARegisters *id)
> +{
> +    return isar_feature_aa64_sme2p1(id) || isar_feature_aa64_sve2p1(id);
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


thanks
-- PMM

