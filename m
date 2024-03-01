Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8717C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 21:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgAqN-0004tT-BS; Fri, 01 Mar 2024 16:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgAqL-0004mn-Mf
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:55:01 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgAqJ-00006o-NV
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:55:01 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so24675175ad.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 13:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709330098; x=1709934898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vh2C2wal8S6HzUHDQum0TQWsDdWv5X/3qq6hrm2LB1k=;
 b=QVnoWdfwEIstXX6TT8MuDn4q+nXKu/18S/KXTvnYTGpIdHiHJ0lEu08Ez0Esa2pjmk
 eTSnWKpEv6NnBwoEns50echJ/oHdpHZhp8i3m0k8pRaL0Wj4O8cy2Zw4FbRw81/CYe8e
 WhGDbKs7HFucVIWjdkOvZgGIc0b84cnEPTeC/c6fqaMrcZjQ2hA75g60rE8taQHkpF5d
 vKx7Q5PU2nvz/ZUGB+T/y47KQsWHg21jkDfNtfsR4qAUrAJHgeXbZcSiU/e+lXon/Ten
 vM5rva0VxICOZC1dTjrTKMWDNf93onduR4NK1vFkIwX/oMoZ39LDIDAlBZ3ad3JvbTHy
 tIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709330098; x=1709934898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vh2C2wal8S6HzUHDQum0TQWsDdWv5X/3qq6hrm2LB1k=;
 b=PH0BokXTuGafEJLJhB15L8EC+IJQepSIzIYlvjvTyIJhp+oRN64301kYytfOz95i9b
 yWbXMzcX7U4egSPwEkJ0L8fNwyPnz3kPBbfA4KVZZzLlnFk8mqQyE+8TgocR/pKW8hv6
 1hTSr5TnfBCG1kRCnnl/DS1ST7Fs/uf0q2988jAY3r8Oz3kw9NQN3ftQxHOuBmj0UdeO
 ymTzKiL0xjt+IbJJdwnJcjgSjCiWJ+WybH1f4N9I7HgGAtCmHW5b4g01Uuej6kQJCHnK
 WoyH+cDx9w7oP5HE9u2+vqiCKcI7RopzDzgEWlfBdBxRDHZiw7SPNzCSyvgFxDJlUhCL
 H4UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuETfX1LsbPXrc57Ggua2rQ+d5cJdgO2kL97l9ZgBcHy+hYbftOJa7KnER2COCHlQ+zkqwo1Xc48WK54Kr1Lzawz01Hog=
X-Gm-Message-State: AOJu0YxxE61bkqb/y6Ub8dUWPViLflaFTdU5fao0+6Cm8/ilh6i+k6Js
 +jO6qwJo1TG10og0YMXaRpTe4R06kIFAKbMPhA95lUhozsUKBazhxpCCI3JNiAI=
X-Google-Smtp-Source: AGHT+IHR4KBRAdHdSf/JcD2Xdvd+t699C05ZTPJqhvuKlcA/gCdcNfA5S14sBVKVb+GnsWGStCJEmg==
X-Received: by 2002:a17:902:ea04:b0:1dc:d642:aaf0 with SMTP id
 s4-20020a170902ea0400b001dcd642aaf0mr3824166plg.6.1709330098182; 
 Fri, 01 Mar 2024 13:54:58 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902868700b001dca9b21267sm3946503plo.186.2024.03.01.13.54.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 13:54:57 -0800 (PST)
Message-ID: <97dbadc0-a9f0-4c32-abb1-7613380e2a5c@linaro.org>
Date: Fri, 1 Mar 2024 11:54:53 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] target/arm: Implement FEAT_ECV CNTPOFF_EL2 handling
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240301183219.2424889-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/1/24 08:32, Peter Maydell wrote:
> +static uint64_t gt_phys_raw_cnt_offset(CPUARMState *env)
> +{
> +    if ((env->cp15.scr_el3 & SCR_ECVEN) &&
> +        FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, ECV) &&
> +        arm_is_el2_enabled(env) &&
> +        (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {

arm_hcr_el2_eff checks arm_is_el2_enabled and returns 0 if disabled.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

