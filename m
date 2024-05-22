Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7919C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 13:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9mNS-0006xK-9I; Wed, 22 May 2024 09:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9mNP-0006r5-NQ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 09:51:31 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9mNM-0004Xr-SS
 for qemu-devel@nongnu.org; Wed, 22 May 2024 09:51:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ec92e355bfso12596515ad.3
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716385887; x=1716990687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zp1kUoDEGiwyPs6SF7r3w1C2DCdyFWrgXX3CSoDElEE=;
 b=EjRXhoFibh8T7HB9NcJUsil15+Vmkw/pBQ0/uOidS9AXRAAuxbQgXOnAOgyGLICPa1
 lXc6mhYrt3ENiFUiSDVAIj2MIWvlWkjSFFMunJ2ciBXOG6Vmodx9FglSeIW0k3d9Er7B
 bqllKST8/zvPGLJij6Wk5mdFaw6wZ+GJF0XsgCyS4vc55DQLMIJkdMmnNBfps7b7i6uZ
 tG6ob3qESWXFzo+04ogSFfdfPvSX8USV1b8YlM12RiaUxIrMQQD+xiUDPj374Rv0cFNr
 U2o3ICKwxwPzSjhOmh9o2lOXohAqcmIysLXVwI0e8rFkG8sqQnUze0T4y86bRcMQFUPa
 5jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716385887; x=1716990687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zp1kUoDEGiwyPs6SF7r3w1C2DCdyFWrgXX3CSoDElEE=;
 b=TWYmX4rs1HKNPJuPCDW7tBmtmRgyutTewjabmUQhmU793TM+BfAAFQ5ZPV6P4ii38b
 cPKMTLdbTsG9//dEOBnaZKLOtwvzw3QCF//8JkscsOMWRrTX7WDR8hmdugV/DmnJpWUO
 etnieVwUJ+hmusLebVuGSuhVSCdpsPn4NimVduQtU17wiUvOEhyjQqWX+nxf675OzPyu
 MxjTsNzXZIRU5axmrdXaeXpixSRT89jFMaHE6MQN2IkT9BEAiC69z/CZcGCR6oxvrNmW
 uEYvCR3IWVH/7K8Vgm2UXqy7pu7kjSWLT9SmmJ01B90BsV+YZU1EsqvqaZvX3sqLhAc4
 r+qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjq7fTBncQsb57hp6rBfmFgwLPiTTRk+TA5xGHz3dJlhXxlPlKj52o826hrnYDnWP5tRf2KHtoQHqsd7tHwhW4D5owtYk=
X-Gm-Message-State: AOJu0Yxhwm6d+UXJLd2joQ6UWOxrS5mWFe6QGNkXvTvc5WuJzqlmdU+t
 NzW0SR0drt2ATo2LEi8BBV56YoK024mQEUfIj5y71p2CybRJcr0cbYe3Wuyb0Bs=
X-Google-Smtp-Source: AGHT+IGnIOiZFTHSCEhj+X6BNxfl1AmG0Jps2UQp1V9IBu5tQa3nXKHtY7Jj/IDFeoRI8GEa4GUbYQ==
X-Received: by 2002:a17:902:cf05:b0:1f3:2d51:17a with SMTP id
 d9443c01a7336-1f32d5104c7mr11894775ad.18.1716385886713; 
 Wed, 22 May 2024 06:51:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f32d91cd9asm7466325ad.267.2024.05.22.06.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 06:51:26 -0700 (PDT)
Message-ID: <b66667b8-af13-47f5-8375-98aaffb3dfa4@linaro.org>
Date: Wed, 22 May 2024 06:51:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: generate simpler code for ROL/ROR with
 immediate count
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240522123914.608516-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240522123914.608516-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 5/22/24 05:39, Paolo Bonzini wrote:
> gen_rot_carry and gen_rot_overflow are meant to be called with count == NULL
> if the count cannot be zero.  However this is not done in gen_ROL and gen_ROR,
> and writing everywhere "can_be_zero ? count : NULL" is burdensome and less
> readable.  Just pass can_be_zero as a separate argument.
> 
> gen_RCL and gen_RCR use a conditional branch to skip the computation
> if count is zero, so they can pass false unconditionally to gen_rot_overflow.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/emit.c.inc | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

