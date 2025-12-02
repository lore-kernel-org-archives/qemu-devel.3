Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1946D116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQRNT-0000uy-7Y; Tue, 02 Dec 2025 09:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vQRNR-0000uH-OU
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:29:13 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vQRNQ-0006XW-9v
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:29:13 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-55b24eedd37so3487164e0c.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 06:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764685751; x=1765290551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nANGTs4aowyDtRQENP29o/7kvzcAseznRXo7SOnqA30=;
 b=yOu7BPdWB9ZrYZrjKfUBANcXD3wxdnrCoaTCzOvC4KjWxm+T5bpBGfRQLCyHEDN5j8
 zFpxPeO1kz4n1fz3aENp/vDHlBDRB4lE5rg6jdw7+kCgHvnuFSr8wUz8GHRQ/zvUgME5
 /4rXMAm4XKdMR13KEatombSjoRnQLis2yA0Ywq+SQ+Mru4F+O4gLFwhxm6UqF0KC7j4R
 bx8GM8R4sImyceqOhtLHXjBRIXmWt7sS1dpY/ati8I1eNuzweIW2SX3mzuCNZPwhlwzM
 qo7V80CN600FKaXxAZKtrnJCu6cxz9G+rJ5e16fMVQINAGOXFTimcW4G4/xwwNW0N6I8
 Qv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764685751; x=1765290551;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nANGTs4aowyDtRQENP29o/7kvzcAseznRXo7SOnqA30=;
 b=CH2ubQuDN/cOEW4QvStbo7NYTEshN46xE594g1xM5kaVRZESUxhsMXjgkDKkKMHqQj
 WLbnh/6mTsAtBeKAGKN5GBjhEHqtCzX+/eN6GZsy3rGjRzggvJ2iQVbAJSSKF+4mnqZp
 yb98AI6GTudXk7hvHRpmvGvkUMHTILVu7tx2Z4nJboIpHIsEo2G76rDk7qiih6K6hwvp
 CgWJtCDzf8O7FvqfaiQhheqw2xrLCyY7F9Ga/YucnT75n/GS45vODYpdVtObYCfPwnwD
 PD7PWZds1dB/krNXR+C6pn16l+G5GcSdFRaIH8hRzZemkw3mtJluGGOETtufYqIEcr7M
 ix4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ8cBAL39dcI2E6PoOIwkBzhSrupjQ67PIpNl9KdVZn8AmMoFciyg1e17zDtpdqRQY1BHugtr7gRhe@nongnu.org
X-Gm-Message-State: AOJu0YxLri0jHdUnZeoTQpanpPS39XmfdW7BK2Oni6OUkDhfEJRcgyuy
 4RnKN10nNVMoEEtI23SoAWLooCRM3YXBxonr+7V/0Fgr/HRnD7VWJvXFQsUMoWHFqSw=
X-Gm-Gg: ASbGncvNrwilPaqCyqmpv+wVxsfjABZQLVivJu8vTs2/m7XxrMcX439jyJ+45G7rUAc
 XsxAZcb3WYOjQD2gMu8oVDlQj7aN5ZrO4gspQow0SDE6rVn9NqaDa0qB0Fdb9MKbnrnh/LlJSTF
 Z2zNyKhU1lzO5OA2Tou80cQAZdCBPeJvgut7+dZriTnm/uYuBXFcHGkk2YYIiTUD7hdbgSbmtxD
 6A0jIhynqPcf7dugG0GjEdkSRdbqvAJO5epFLdeEs6pSdn1MTjkGgnf+cWhVG5DMLwOnKxZKElt
 SumYpi+urPZiMag96A3yfQuJ9uDRQB8jOft1iedCjmZSRY/U0118O1yDb6iN6CbZDhgNdUnw6xH
 wXZP/7f/upbn3zrpHTkL0CtbXCkIjAwVX/1rO8xPxILga+C+yQr9owvO971vxgC2oIuXReinw81
 Vd0cvRJJzP5mgkbLBFJJrpSw==
X-Google-Smtp-Source: AGHT+IHEFpPOfhrpAYvEodIE5o+NwAOWh3p5xqF0V/cVERTGn/K+2PXDyI/pQOOK0ScHwWBzVG4IXg==
X-Received: by 2002:a05:6122:3701:b0:559:6e78:a44c with SMTP id
 71dfb90a1353d-55b8d6ec758mr18844507e0c.1.1764685750960; 
 Tue, 02 Dec 2025 06:29:10 -0800 (PST)
Received: from [192.168.0.102] ([177.139.2.175])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-55cf4e1d580sm6506596e0c.1.2025.12.02.06.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 06:29:10 -0800 (PST)
Message-ID: <c2747a88-436d-41bf-8277-b1c10a1aafc5@linaro.org>
Date: Tue, 2 Dec 2025 11:29:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/4] target/arm: Allow writes to FNG1, FNG0, A2
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251202120250.763150-1-jim.macarthur@linaro.org>
 <20251202120250.763150-3-jim.macarthur@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20251202120250.763150-3-jim.macarthur@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa36.google.com
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

Hi Jim,

On 12/2/25 09:00, Jim MacArthur wrote:
> This just allows read/write of three feature bits. ASID is still
> ignored. Any writes to TTBR0_EL0 and TTBR1_EL0, including changing
> the ASID, will still cause a complete flush of the TLB.
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/cpu-features.h | 7 +++++++
>   target/arm/helper.c       | 6 ++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 579fa8f8f4..d56bda9ce0 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -346,6 +346,8 @@ FIELD(ID_AA64MMFR3, SDERR, 52, 4)
>   FIELD(ID_AA64MMFR3, ADERR, 56, 4)
>   FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
>   
> +FIELD(ID_AA64MMFR4, ASID2, 8, 4)
> +
>   FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
>   FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
>   FIELD(ID_AA64DFR0, PMUVER, 8, 4)
> @@ -1369,6 +1371,11 @@ static inline bool isar_feature_aa64_aie(const ARMISARegisters *id)
>       return FIELD_EX64_IDREG(id, ID_AA64MMFR3, AIE) != 0;
>   }
>   
> +static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
> +}
> +
>   static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
>   {
>       return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c20334fa65..7812a82bab 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6102,6 +6102,9 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       if (cpu_isar_feature(aa64_aie, cpu)) {
>           valid_mask |= TCR2_AIE;
>       }
> +    if (cpu_isar_feature(aa64_asid2, cpu)) {
> +        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
> +    }
>       value &= valid_mask;
>       raw_write(env, ri, value);
>   }
> @@ -6121,6 +6124,9 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       if (cpu_isar_feature(aa64_mec, cpu)) {
>           valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
>       }
> +    if (cpu_isar_feature(aa64_asid2, cpu)) {
> +        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
> +    }
>       value &= valid_mask;
>       raw_write(env, ri, value);
>   }

Afaics, we are not flushing the TLB here like we do for TCR_ELx (in vmsa_tcr_el12_write) before
we call raw_write(). Since here we could be changing the A2 & friends bits, which can change
the value of the ASID being using (like the TCR_ELx.A1 bit), I believe we should flush the TLB
explicitly here like we do in vmsa_tcr_el12_write().

@rth wdyt?


Cheers,
Gustavo

