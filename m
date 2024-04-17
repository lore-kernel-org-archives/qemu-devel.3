Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F9BC04FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 02:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwvEJ-0007zy-GX; Tue, 16 Apr 2024 22:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwvEI-0007yD-TL
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 22:40:58 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwvEH-0008V1-9L
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 22:40:58 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ecf05fd12fso4810572b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 19:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713321656; x=1713926456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fp1RrhCcCJRy50mhDnczZLby887pzDwdKuVLWtTdRRc=;
 b=DfFBAJoELPLSjmW+yjZUNZuo5PSyzkVENTzkUukEcXEW+7Q/O+y7d+eJBV+7RltpZ1
 dAAEFl6a3dP16M/2Cbelnl/tlSjnoT+i9X8JPC0Fra8oQg6Gy+J5nc3qAo0f7JiRyqUO
 4u742lIJfZe9v1oN6iwFOcCzqgEmKwNDYa3/+ZgQmYXf88gpWgkPmEIZw8VqH9bHbmU5
 9wJIaxUopfak9LxrgvFcMCabScvBGgjslDI2k9mcuX7O7LjqOnGiHfwonHgieAZQB+/6
 0cIQMS15wC3k7AotCIxUcfFIHS0+CH+joAZwEDODDJ4CF5Kot1soUcrpfGQhUcC3rUP6
 YLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713321656; x=1713926456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fp1RrhCcCJRy50mhDnczZLby887pzDwdKuVLWtTdRRc=;
 b=TFJ9xKwsy8/RU05nY5Dz99wm9t99anTljk2HJh/Aw6WLw+D9qsx5cyiFN/pkmysiWx
 qVIU5Wo+l1BVn9I136POtGDv2xHFggWXUD2DzuWALuJnz9fKpKUq+3ibdmzy2APgS5IF
 vy5LZM6/7iCV3OIoRRtBk3anVPieOfcW2SeB3lDPcd91c9tdhe8CHBKiFhldWUW7VGbd
 2UFT1v403KI6118OghRtIYLvaGfwmGKbQrY+IkoywqcKIZu6C8PEOr1czNeaBh8sqFoG
 uNyJryRIl9BA9CJepKo66bwer4dCsl3ijC5dDaOTShLVb4h2tEXfezZJCWSPxmJlb/wo
 k3UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrUNBk5yYY8BTLvYXz9DKRZDG7/DAw6VdGHLqRcYvOL1XBiam5PUIn1XabOtzOPvp1ObnZdcm6TTAeMWPbZYkIu8es/94=
X-Gm-Message-State: AOJu0YxqVbVUCvxe0X+LK7cs8fqMMN2UUwWrO6TJJLCPOynGgxStVV2y
 72xYneKpyTff72pQt0cT26oC+stZYNpuCQYd4DlR08bIiHodeI/N5B66ycEmWNc=
X-Google-Smtp-Source: AGHT+IHw/HXv/Il66p63y0Wmtf9c6v5iIgGAxAzX29oMzCT6Y8RQcPfr9q8Mb20nM7MrC/DbpTASXw==
X-Received: by 2002:a05:6a00:14c3:b0:6ed:4f0f:c93a with SMTP id
 w3-20020a056a0014c300b006ed4f0fc93amr18617275pfu.0.1713321655995; 
 Tue, 16 Apr 2024 19:40:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 y16-20020aa79e10000000b006ecffb316ccsm9535266pfq.202.2024.04.16.19.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 19:40:55 -0700 (PDT)
Message-ID: <c580f2b9-0c95-4135-8f6a-290a23b8219e@linaro.org>
Date: Tue, 16 Apr 2024 19:40:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v3 2/2] trans_privileged.c.inc: set (m|s)tval on
 ebreak breakpoint
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20240416230437.1869024-1-dbarboza@ventanamicro.com>
 <20240416230437.1869024-3-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240416230437.1869024-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/16/24 16:04, Daniel Henrique Barboza wrote:
> Privileged spec section 4.1.9 mentions:
> 
> "When a trap is taken into S-mode, stval is written with
> exception-specific information to assist software in handling the trap.
> (...)
> 
> If stval is written with a nonzero value when a breakpoint,
> address-misaligned, access-fault, or page-fault exception occurs on an
> instruction fetch, load, or store, then stval will contain the faulting
> virtual address."
> 
> A similar text is found for mtval in section 3.1.16.
> 
> Setting mtval/stval in this scenario is optional, but some softwares read
> these regs when handling ebreaks.
> 
> Write 'badaddr' in all ebreak breakpoints to write the appropriate
> 'tval' during riscv_do_cpu_interrrupt().
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_privileged.c.inc | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

