Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76495E9D827
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9X7q-0005OE-TV; Sun, 05 Apr 2026 19:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9X7l-0005NV-WF
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:43:26 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9X7k-0005EI-B2
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:43:25 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so2888453a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775432603; x=1776037403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5+L2GeP4pzYzyFI/xsp8JLMBxkGYTj1BSGSMTTi3jVU=;
 b=EbuRaLzdn7CY9K+l96Syx0WY4kedb16xxaoIe3cWDh6ucHAsZ2fLgax/prqsdQ72uI
 hET72jl7fP0Cs6B/RbPpJddqtJBAMlqMvrSucz8flRkDcuv+vfBidEMYOcauX2DLVlWx
 Mvz9QvgifADeU68RK6Iuwr2mtNhIkD93xj4bQS6C539KKr76V/x+oT5E3hiIL16O6jTp
 joTr7nI5c5qCQ7YbQgEVhfSqHCPT/PEyQLlIreQH1splwMpV4YTUmgOGJY0z7yG3jgEF
 nwN6PW9lezeu43boCxXUSw3rO19b0G9jF7xjY1PGld44MUwZVEzhgTA6o3dJomYq0WOC
 gFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775432603; x=1776037403;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5+L2GeP4pzYzyFI/xsp8JLMBxkGYTj1BSGSMTTi3jVU=;
 b=CYZt3YELCXrQthpi5RcQlXWGAlk4hQYuprQCW+FK2I6oXMJMUa/kd/K/lMXCOxRjcB
 Pg4x9H4YmxVCleTR2c/v7fXK+0zzOc1EgujpQqTucj9rLVGUsFBtDwX5cBK6nn5D+K3c
 69RLRL2F/hWE4k7tO6XKKEszeJ3tI4Q5gbAm4oRLzKjhsHzdCpKp9MK61oUyqHEe7ARl
 nQOMaPBcW2/S35OFmdCmEIaWw2GF6cRJzZTTQ/kHF9ZuhBVtW19CvNXXPq0/frQ/qNLc
 QkhQ4hQgyuIayhz/DPOIrQWkb8L3rOQ1yuAUmC2J00FNfmCA+tGySsYfDVzHoFxBI27V
 q2lg==
X-Gm-Message-State: AOJu0YyB6h9coS9Ul2cWAAk/hAJV9J8ArDm+ULhsTxysGXJaVCE057/J
 HEcED7DPrkIygSRUXFDkMVXjns96bxiCmojuNDvhEx597668n3OZkkPyvm2qM2cTybf+9uDDTR5
 UyZk2
X-Gm-Gg: AeBDiesWmDmwGk4d8twNe/Kflk/2qjND+LNlC3uHmJ5/+s8gmayIey4lY0ULBtNPI0d
 zSu8+hAUpASbVSgPTaqt3W9R0w8uq1J2bPhCb24B9qTJpsjoXn5DthI6H2AhoV6Qn3xv6PVjnpe
 FaatOXZvO/CA3JGMQBp6pSTf4pwh5WqCouc1pMPfpPimK3XBjzLgWfXbm8PgNAol25tfobDHKJZ
 LZG8uXKnIW2uWOIDh9uXZFnyh/VIpZrSJpHS1wHCbg3W94uUX2nfjPRFvLhQgwJRbWYZAJ9MjXV
 8WVdt6NJjJ/7lcyGn3DtNdNJrBy//jiC/uxTO5waNOYxpvfprI9PgE6AK7VkEE7UNMSZveg0p/J
 5acShuUNNyXSUP5pj1AK56SPz+yLHbK5DCAw0gW0dbqheW4sML2J1Xe+gid50AhgFJghZq9L2tt
 IM8oruTDv5HT3KOuOUCF4rhqoL2VAIuGeauEJ8lPNR6eektFOOy8aIXC8WwAkSGWfpx8o=
X-Received: by 2002:a17:90b:58f0:b0:35b:9ab6:1d4b with SMTP id
 98e67ed59e1d1-35de68f2cbemr9670279a91.20.1775432602546; 
 Sun, 05 Apr 2026 16:43:22 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd367c142sm11896138a91.11.2026.04.05.16.43.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 16:43:22 -0700 (PDT)
Message-ID: <f8730515-af75-4f4b-ac9c-567f9cc1c9dd@linaro.org>
Date: Mon, 6 Apr 2026 09:43:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/35] target/arm: migrate gcs syndromes to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> Added a little comment to explain the RADDR<->ra mismatch.

Or you could just rename the argument.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 38 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index 503b19b5d02..76f66b3beef 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -690,21 +690,49 @@ static inline uint32_t syn_pcalignment(void)
>       return res;
>   }
>   
> +/*
> + * ISS encoding for a GCS exception
> + *
> + * Field validity depends on EXTYPE
> + */
> +FIELD(GCS_ISS, IT, 0, 5)
> +FIELD(GCS_ISS, RN, 5, 5) /* only for non EXLOCK exceptions */
> +FIELD(GCS_ISS, RADDR, 10, 5) /* only for GCSSTR/GCSSTTR traps */
> +FIELD(GCS_ISS, EXTYPE, 20, 4)
> +
>   static inline uint32_t syn_gcs_data_check(GCSInstructionType it, int rn)
>   {
> -    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
> -            (GCS_ET_DataCheck << 20) | (rn << 5) | it);
> +    uint32_t res = syn_set_ec(0, EC_GCS);
> +    res = FIELD_DP32(res, SYNDROME, IL, 1);
> +
> +    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_DataCheck);
> +    res = FIELD_DP32(res, GCS_ISS, RN, rn);
> +    res = FIELD_DP32(res, GCS_ISS, IT, it);
> +
> +    return res;
>   }
>   
>   static inline uint32_t syn_gcs_exlock(void)
>   {
> -    return (EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL | (GCS_ET_EXLOCK << 20);
> +    uint32_t res = syn_set_ec(0, EC_GCS);
> +    res = FIELD_DP32(res, SYNDROME, IL, 1);
> +
> +    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_EXLOCK);
> +
> +    return res;
>   }
>   
>   static inline uint32_t syn_gcs_gcsstr(int ra, int rn)
>   {
> -    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
> -            (GCS_ET_GCSSTR_GCSSTTR << 20) | (ra << 10) | (rn << 5));
> +    uint32_t res = syn_set_ec(0, EC_GCS);
> +    res = FIELD_DP32(res, SYNDROME, IL, 1);
> +
> +    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_GCSSTR_GCSSTTR);
> +    /* when ExType == 0b0010 RADDR is the data register */
> +    res = FIELD_DP32(res, GCS_ISS, RADDR, ra);
> +    res = FIELD_DP32(res, GCS_ISS, RN, rn);
> +
> +    return res;
>   }
>   
>   static inline uint32_t syn_serror(uint32_t extra)


