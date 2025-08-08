Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B652C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 21:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukUdm-0005qQ-GN; Fri, 08 Aug 2025 17:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUdk-0005pf-St
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:28:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUdi-0001At-ID
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:28:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-459e7ea3ebeso10614265e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754688517; x=1755293317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9WIJj3BlbQJWpB/a+JGYS9iR9cvKd+qZQPFdZntchuY=;
 b=XsWDnM+JL7Pw9eiowk0Umk19EpIY0onca1yX+bdHyuOuNkmLeW+hgGe+8UFbxLZ85E
 Th88hc0nTXuwjK75mUol7VhneuotD9/mFqa09aJlNtGQNj+UtF0ScbK7JMHmGOSiEClN
 guHLp8ACfBDVCl++eZ8WX4+QL4IVTo/PlPYBiCuFNyduWM3f1uh7LO8LGzRrQueD9Qqk
 V0bZQWaCeDMBCQirtx4p1PYy3pzi+R6ImCJMoywpTQ7SLzksyebZJ0AUkzzqthznRqvq
 hiSrt5YXzkyCf3WGcwvelTeMrXR7W33Wk+gHDpJDWNVOwZIysXirwFNwHfu++CkvqXxg
 hM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754688517; x=1755293317;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9WIJj3BlbQJWpB/a+JGYS9iR9cvKd+qZQPFdZntchuY=;
 b=SKizeFPi/qTSIR5kO42SIkT0QK/yZ8A01XeZqtLfBugscgkAjHtp26EBHw4BxzPf8y
 2le5uZ8hhCqfsFIDWgvyHZCnMVhJw+r0cS83oHZJ/gaVEhmEeNJYINiPNAAPjFJaLX/l
 tfWJyHdaMw1yKP17qBe9WGTpczbt1n3Y4PsxIxfRgl8tSZQP1RFAu5mQKUiQb18p+7m7
 uGc82UvWALGMfCc1G6iJ0U4KhC5XR7ds2WpFMkNnEYYonSnoQLHVzxvR26YdB+2+QZ1N
 NUBTEQAvUKmh8vOD6ukbkISwO+Nxlz9J3uZCihn6hgq6JmAN3Kja3cVB5WRjOTjEuRqT
 60fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5QlKdHMcjA1+G72Crh3716BI+vzto6Z3kAKG3vgifkIXSztgaQlzqPuTMIGjVUf7JbpFXAI3ioSCT@nongnu.org
X-Gm-Message-State: AOJu0Yy2HnkTKfsD6nzWJp2JXQ/Y+WWBVe8uauedmhVPKQCEdD+34skK
 +aDrZ/LEYaUPQRA4NNcO4PTx0T8I2wrLGs2SHL7ZBxCm0KQ5zG8oSMrItwVQ6YtH3mM=
X-Gm-Gg: ASbGncuQCrTACjj9eCRHLFJRIuXf6J+1JW/ux7yq90PI3tfLyjJX7sshg+6KB3i5Ufg
 ldOxDrUQuO44XlmXX/9HXPDVX+4AdTkJb/oigKq2DNIJw1EgAw6t1dIK0Ujf0ZufBsI3Ulyp4y4
 MZnF0TqMt4iUcadJVgLQ4NiPZ5iQFsmpPNCFWfPbTQtbwmcmU6gam4ASls0cDlCY6uT7Hoy8Z/4
 57J+7R4HsehFbR6GkJ43nMliS/4NK4q1p9lhDpJFssLaFirdacsgYA2awiqxqPHUSjEWtqJqRCO
 6UuiHrKzEmRCgCLDVovNgiZSq7XX53qig7LpmwVXlvAewXy+85cNum6xyM1+2vXSNc8dLzR2djy
 DrttOUbzXI/0c3uCnF7P1OsXPVZwbzXq0lJ4LVTDZLCmCjBqaS5OmXmknzODqFdAsiA==
X-Google-Smtp-Source: AGHT+IEwEuUkdhHZdtjFqDE4BlCPmbKSOvJgDKAYADj/qPp2VXGM9TRlXPjec8GVSuiuBcibxttkSw==
X-Received: by 2002:a05:600c:5298:b0:456:29ae:3dbe with SMTP id
 5b1f17b1804b1-459f59cec5bmr38365435e9.24.1754688516855; 
 Fri, 08 Aug 2025 14:28:36 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3c51e2sm30679531f8f.32.2025.08.08.14.28.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 14:28:36 -0700 (PDT)
Message-ID: <7442c36d-150b-45ca-8051-c2ce2ae25fd6@linaro.org>
Date: Fri, 8 Aug 2025 23:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] accel/hvf: check exit_request before running the vCPU
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, richard.henderson@linaro.org, peterx@redhat.com,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808185905.62776-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 8/8/25 20:58, Paolo Bonzini wrote:
> This is done by all other accelerators, but was missing for
> Hypervisor.framework.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/arm/hvf/hvf.c  | 4 ++++
>   target/i386/hvf/hvf.c | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index b77db99079e..478bc75fee6 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1927,6 +1927,10 @@ int hvf_vcpu_exec(CPUState *cpu)
>       flush_cpu_state(cpu);
>   
>       bql_unlock();
> +    /* Corresponding store-release is in cpu_exit. */
> +    if (qatomic_load_acquire(&cpu->exit_request)) {
> +        hv_vcpus_exit(&cpu->accel->fd, 1);
> +    }
>       r = hv_vcpu_run(cpu->accel->fd);
>       bql_lock();
>       switch (r) {
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 8445cadecec..b7c4b849cdf 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -749,6 +749,10 @@ int hvf_vcpu_exec(CPUState *cpu)
>               return EXCP_HLT;
>           }
>   
> +        /* Corresponding store-release is in cpu_exit. */
> +        if (qatomic_load_acquire(&cpu->exit_request)) {
> +            hv_vcpu_interrupt(&cpu->accel->fd, 1);
> +        }
>           hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
>           assert_hvf_ok(r);
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


