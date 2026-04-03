Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16F0E88D69
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8m9w-0005sl-SL; Fri, 03 Apr 2026 17:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m9u-0005sN-4n
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:34:30 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m9s-00051J-ID
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:34:29 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35d99031e4eso1326055a91.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775252067; x=1775856867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FRMFNNdf5A2G2RCNnZzCpV8Py2E7bx7tXxUWvTXRHkI=;
 b=LAbbci6XiiXxVSatRd/yOHh/oULKYBUhc/pOXX81HRN7u+Uo0VhPeKUyPJkQBoVGOZ
 53qHX4HIDEcB/Xq+1XvwqGu28Zq08TQdn+6Zv5uqpW0UYwW1mCavP2Lq1Guqbpv5ihMM
 LBZ7Aw4wWlMvVJaJqWZF1k8Qv/U4+10PD+SeW1KYepc8UlB8kwDU/G5YDFjAjVrQ4OHe
 oAVlNiyraOAGOJWDwdEJeGxHm0Khg2tjZXck51he15LGQvc2mUS66vRBsXl9M939EYWk
 FGE7Owf8zsecL7J/s5nJEpdlm5XSMttEWmYJqFRG6zw8T8rYOp60UkLx3OntTicVD4X/
 +tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775252067; x=1775856867;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FRMFNNdf5A2G2RCNnZzCpV8Py2E7bx7tXxUWvTXRHkI=;
 b=dds3YE27LwRHMjQiQjYTWUM1hVB19gwiN38jHnY5o8JD/2Szn3tGmIAClRp5TCdrHq
 OaffPCR1jNieJF4II2pxyG2Jd9+QgOB4BevBTrzc2Z4FcaySxyVF0wVB/D5TKkp4NUX/
 BLvnK8rCFNxOapQx+9dTgMvlj+7PeVkAaBmyx2QqRhu4xXyHx14ayooWUnkV0I7nrK9I
 NrnLT8wHQQ1oKUsHLgvc0O3DKwk9s3gCZaw8BjuBQvcsaomUMCYWsrzwEvkGk4HEm5F6
 D/ZYi1UW/lRpWXsrN7KHQdcCJ+bw0IBZSnb5izPZjwJXOIwU5fjj2MaLzY0ZSzi2drhT
 aXcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9O8v8MIaVEgHQqT7/sfAVNrRvpEUw0bIuu/yvn2ik/C0SmgolZg+7mRRe00XTe7uJnQ11+4z6GJE8@nongnu.org
X-Gm-Message-State: AOJu0YwRtF97JFNHfU6mTgJZXb0mVOizH96R8jfSfZxqDSkvnoxEb2GL
 0ZEfcsvmpmNszCPL5+02VQdRXv+RFNSZbTSeb2kF/BQPNxqGZH44hSBre20xBjVEmA0=
X-Gm-Gg: AeBDieuSwIdRm8q+Sr3nRm9faiZojehiwmUzGoh3S3h5Kggg1TLjkf6dcCWIjYK+e2n
 qzTKDziPxjhJMPtFWqzCxEvMeW7DyPl1u3qAfr32FcXpU/YCnUuRFfFNxdJUIScHNPgztl0e6ZL
 8g/YyhoRX6GqPd9U+fsppNKPvq539DvouXsQ9t9rcta5oX+PIhX09mZcsrWK3DhDBj6DQyTLfRR
 lLWFcAOSGt4pUhmvHkTgb+uatNq8wfDEqE3Gye4ZAFJPl9APK3noxQVFuBgUSTDT2L5HXSJnlrn
 eHrSqQ2OU+5LjWPKcxkB4CaB+oKHhJMsIWZOdwxizloFLJQkbMJamhLc4i79dt+8Eh8CmkzOx25
 nsxiZUj36hV8yFw8Pb09fQQqZd6u4+THvH7BP9xktXS0iyIQmrzG/nMWV/zoN9hX3Ux6YlFgLw9
 7UJs8TMH43S5tp4tS2rGAj53IPSQKmgncQfIt7ye7HZndF7TZGbQ5jMo4GoKDvOvK3idVt4dliS
 ZNyrw==
X-Received: by 2002:a17:90b:3d8b:b0:359:f2e1:5906 with SMTP id
 98e67ed59e1d1-35de678f026mr3944805a91.4.1775252066827; 
 Fri, 03 Apr 2026 14:34:26 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe9379f3sm11754396a91.9.2026.04.03.14.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:34:26 -0700 (PDT)
Message-ID: <55b23986-9933-478e-a1b7-8416709d9508@linaro.org>
Date: Sat, 4 Apr 2026 07:34:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 7/8] target/arm: Remove target_ulong cast in
 kvm_arm_handle_dabt_nisv()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260401201753.92290-1-philmd@linaro.org>
 <20260401201753.92290-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401201753.92290-8-philmd@linaro.org>
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

On 4/2/26 06:17, Philippe Mathieu-Daudé wrote:
> kvm_arm_handle_dabt_nisv() uses a uint64_t type for its @fault_ipa
> argument since its introduction in commit 694bcaa81f4 ("target/arm:
> kvm: Handle DABT with no valid ISS"). Use the proper format and
> remove the pointless cast.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/kvm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index d4a68874b88..c09dc4cb3dc 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1453,8 +1453,7 @@ static int kvm_arm_handle_dabt_nisv(ARMCPU *cpu, uint64_t esr_iss,
>           }
>       } else {
>           error_report("Data abort exception triggered by guest memory access "
> -                     "at physical address: 0x"  TARGET_FMT_lx,
> -                     (target_ulong)fault_ipa);
> +                     "at physical address: 0x%08"  PRIx64, fault_ipa);
>           error_printf("KVM unable to emulate faulting instruction.\n");
>       }
>       return -1;


