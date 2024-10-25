Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103DFD149D9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 18:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4ObG-0002u8-9z; Fri, 25 Oct 2024 13:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4ObF-0002sK-5f
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:59:49 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4ObD-0002Ni-NP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:59:48 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5ebc1af8e91so1174922eaf.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729879186; x=1730483986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aPjC8EoA5VgdPyxmzDMvo5GAQnHdNsnFgI+pzOnJD3o=;
 b=FnDCVmRYfvfIW7Mq2w424qbLmzY9xh8xgexO69AFShdpeUopAkpRtgezjB5LQSwlqL
 1onJrO/B9PTjh4DFsnZ9VG/9f1z6Q/V3Gq/AwBzvY1lwBiUuY7rIJkRA2sXn0LJ+w7Vv
 17deeJRTb7gdSTRKuybR/t5b9F1kKdYb8bAXplZJ3Jf41fxfk/s0mAO7Zz3gW/UqigT/
 Z1qjTpv2CYspywr+zS1we+3EmXDvzNZwnFp0ErghwspZJnDYAeRTvugZTycXGt2QX/3c
 ThNheu9uzAVqmJ/vsuP5WVbtPKG6W1pIsVYnamRaAYMvZoU6UFCqk7FG/2VY0t9tHsXK
 NXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729879186; x=1730483986;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aPjC8EoA5VgdPyxmzDMvo5GAQnHdNsnFgI+pzOnJD3o=;
 b=ZyrTBKRB0DQcdrYfbZai6HCU6cHXAd4tAfq2B0g611w9TkD4ZkZL2b3Lk38MKVfC3p
 8e2AzOu1odw3xlNnwx7NtOqLG0SeRJUSX8V+OdPzmima5fDhUmkDpKGTuLFonJB1aLtX
 Nko3en/EF9hECismeeXvcMmY5LaniVa1ZLhs2WW7oQW2csT3/7uM2R3fD66fCYeyTcAI
 881wkROkg6ZqdS080ENvTmem9WFiYAdSiUZPWJ90R3gfQUMtAEOaNT1zDLuBiaeR5Lj/
 MKvETPf9b0T6cQrhsNVwhkvte1tm6Ij4z/IQIjP4aukQvEifMJ5vVe7SZzQVnTBdAT3t
 Z0sw==
X-Gm-Message-State: AOJu0YyPILLepmwWzYU+EnihuJqeSrrN1OGay2c9B6x3hTKSNObBoLT/
 zizTMzcX9Wqus9pMumYEPiDv2U08ocInLfp3abVHFpIZ7kv//cuUvIP7lqUNIiYcpfxxU83hlBG
 lk3R/DA==
X-Google-Smtp-Source: AGHT+IGGttXCQq59/A76A6eoeRs9BNWmSf0QzhYZN8KC28whe8AamEy+GGh1/8O7EekyOTOKl2bt8w==
X-Received: by 2002:a05:6870:1605:b0:270:129f:8e65 with SMTP id
 586e51a60fabf-29051d75ad8mr354210fac.34.1729879186169; 
 Fri, 25 Oct 2024 10:59:46 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8495cabsm1379708a12.0.2024.10.25.10.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 10:59:45 -0700 (PDT)
Message-ID: <784b2fab-a7ad-4e52-a3bc-60351cb7ecf2@linaro.org>
Date: Fri, 25 Oct 2024 10:59:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/i386: fix hang when using slow path for
 ptw_setl
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20241025175334.2549425-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241025175334.2549425-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oo1-xc29.google.com
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

On 10/25/24 10:53, Pierrick Bouvier wrote:
> Most of the details are available in first patch. Second one is there to ensure
> we'll have a useful error message if start_exclusive is called from cpu_exec
> again.
> 
> I'm a bit puzzled that we never triggered this hang before. Is there something
> wrong with the potential slow path for ptw_setl, or is it simply very uncommon?
> 
> v2:
> - get current cpu from local variable instead of current_cpu global var.
> - change condition to check cpu is running as current_cpu will never be NULL.
> 
> Pierrick Bouvier (2):
>    target/i386: fix hang when using slow path for ptw_setl
>    cpu: ensure we don't call start_exclusive from cpu_exec
> 
>   cpu-common.c                         | 3 +++
>   target/i386/tcg/sysemu/excp_helper.c | 4 ++++
>   2 files changed, 7 insertions(+)
> 

Pushed from my old branch (same as v1), please see v3 instead.

