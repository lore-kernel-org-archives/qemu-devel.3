Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD99C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 18:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG0RZ-0002we-Pn; Sat, 08 Jun 2024 14:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0RY-0002vn-5G
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:05:32 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0RW-0001dh-G1
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:05:31 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f4a0050b9aso27393525ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717869928; x=1718474728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u3p0wJkgFJpW1tq5j66/Sn+DMMvdasnq6VEmL+baoJ8=;
 b=oaXYWT3lK09gIbt74IuC4g7BP6tYJck7fUqqnl1ncJA4DA3q3oYZ7nhTP8jPRh8xRe
 8Nbd0MHB3jhcAza41mlbO3GM7H82PKWKEqGuUT9+OqsfLItTbPUsxG6O3bKv7+zSJo/E
 zbZXD/D94zHvnPAPV9sSSjvluw3KJNq7f8VmtaMbP5rJ1ChpC53nz7Nv+9ISXgUm2Sj7
 8DNJcpAMPFHBNPBVg+brydX8RUh/UeALfMYfNJiniG4WrVz863ArCPsqJ29LZj0WQgu8
 5Ay3ZM4u6SAfda1ItwVS78BvgEtDskVIgkhZ0vYoVhRqGKmQb8SD8wpvcdjXGm4WPmp9
 nPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717869928; x=1718474728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u3p0wJkgFJpW1tq5j66/Sn+DMMvdasnq6VEmL+baoJ8=;
 b=gI9Z6V4aL3MyiAnLy1H690nCc0rIOY0B2+3AsZ1PEdVx14driFNF1KPME9tGWgmnhP
 6f6IBPZ9/pUzaE7YcP93J7qdBL6Lg3P6vVIyLbf5X4lYCBVv2JypWt7lfrdXP5zTCB6V
 FNKDIJ+RXjfCaRtHhY2XM53yu+6/SyEDhpF0KTpCP1vGEUBOpMBFm+DhuHM+PVmXrdBU
 EkWZbxDbAxg95Baidt+V06S83lzFGw1yDZ0Ars50L6zTueSHwi8Ycrhihygzq4VVgGh2
 GhlQHrI4d4RqNOx3IYBrhCspvsFYx9d6sWUwVqVkRIVHIkEA+S10wYrNxS+DBBNZvUM5
 oiKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYC6bQ7zsv1E5i9FZnLmTDmhBcyfkUUq76alnQtnqLZnP4PXVI7TEjacwjM4iNv8WPTezEQHMz+EpwRcbOSRJF9SK6ykk=
X-Gm-Message-State: AOJu0Yy8BDGrlYQhRjMY1HrbZuzcLArwVCe4dLEprZKExeVT/vSR0bdm
 8KMxuHXBpwP0YYYbeGrURWHEgJD6BqqyF8zKy+VgtM4PECgtd2kITr5s9GiPmsc=
X-Google-Smtp-Source: AGHT+IGxAXV3f+paWa58igh1JKFVZNinF2RLUKgQD2mN2DJhPBonCbxUabeivCjUscisXXwc3+FaoQ==
X-Received: by 2002:a17:903:1d1:b0:1eb:6527:707f with SMTP id
 d9443c01a7336-1f6d031f82bmr66069855ad.39.1717869928181; 
 Sat, 08 Jun 2024 11:05:28 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd7fd94fsm54552075ad.283.2024.06.08.11.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 11:05:27 -0700 (PDT)
Message-ID: <a4f062c9-249e-41cd-a2c1-1524b41c050c@linaro.org>
Date: Sat, 8 Jun 2024 11:05:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/25] target/i386: rewrite flags writeback for ADCX/ADOX
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-3-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/8/24 01:40, Paolo Bonzini wrote:
> Avoid using set_cc_op() in preparation for implementing APX; treat
> CC_OP_EFLAGS similar to the case where we have the "opposite" cc_op
> (CC_OP_ADOX for ADCX and CC_OP_ADCX for ADOX), except the resulting
> cc_op is not CC_OP_ADCOX. This is written easily as two "if"s, whose
> conditions are both false for CC_OP_EFLAGS, both true for CC_OP_ADCOX,
> and one each true for CC_OP_ADCX/ADOX.
> 
> The new logic also makes it easy to drop usage of tmp0.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.h          |  9 +++---
>   target/i386/tcg/emit.c.inc | 61 ++++++++++++++++++++++----------------
>   2 files changed, 40 insertions(+), 30 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 8fe28b67e0f..ee873a0ed84 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1260,6 +1260,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
>   /* Use a clearer name for this.  */
>   #define CPU_INTERRUPT_INIT      CPU_INTERRUPT_RESET
>   
> +#define CC_OP_HAS_EFLAGS(op) ((op) >= CC_OP_EFLAGS && (op) <= CC_OP_ADCOX)
> +
>   /* Instead of computing the condition codes after each x86 instruction,
>    * QEMU just stores one operand (called CC_SRC), the result
>    * (called CC_DST) and the type of operation (called CC_OP). When the
> @@ -1270,6 +1272,9 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
>   typedef enum {
>       CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
>       CC_OP_EFLAGS,  /* all cc are explicitly computed, CC_SRC = flags */
> +    CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
> +    CC_OP_ADOX, /* CC_DST = O, CC_SRC = rest.  */
> +    CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */

Comment for ADOX is (and was) wrong -- SRC2 = O.
That made review a bit confusing... :-)

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

