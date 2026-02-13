Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7752CEDF175
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvCu-0004vW-DH; Fri, 13 Feb 2026 10:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqvCt-0004vL-EW
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:35:47 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqvCr-00055L-Gx
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:35:47 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso12671565e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 07:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770996944; x=1771601744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U5AoR9cpwHvDDrUxa05jI8tRkd8t4HAbSmgcVgRdiQ8=;
 b=n4tAWPJzgF5DFChI4v+tQjsbFp+GmMMxnQPoZHLPhf99mtTsmtsTxYSrCY3gtRMRdp
 xwR+exbtJ3ArksXzcWhJdquIaUHQJIHMJT1MjdTpgjKqSauv6Noatwp4ctdyXQjyJOkd
 fHj/WDcjP//wq6uvEMjZKsP0UaSBthGcjXVlAzkEDOjteoVt/roRq6j7qcPfA1Jhta5h
 iIp9mWcJMjzGBjbvUmMUWegvE1b3RgwemPNP3ixLxtutZ/6oBjS+SaUGMCM+KYnoJWvF
 4aaVn5j1ZWMQMYRKKRSbjwnLvY/b/IiTWLSOSf1wzrtFapFRZI28RBmXsASW6CHG5Pra
 tFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770996944; x=1771601744;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U5AoR9cpwHvDDrUxa05jI8tRkd8t4HAbSmgcVgRdiQ8=;
 b=NFhTi6rMG8cDMErqx2Q7hepM70wO4BjCdAK01vO86PQ99Gmu6rkK2Z74cEaptTHf8j
 Ls7a9siB1PoR+Lbvro7pOpCyGqM6gHYljlMAYUtPbXQJT7s/644H6awT6w3JMhyo7UiF
 pTqifYVCLeXO96+ND7B87y6NxirULzB1Xi21H91Hn/HaUnGHp7EgLmxderTmfAQPZOOo
 mparY/r5bC/dl4NA/APiH95X9i85Cm3c4PZMR+wN/DrJBc+CdK/OGfXINtemqFK71RH1
 zG9iIBTY/k/LRmJ9I0gxjogRiWcYxQKL9KJwrnZDQSXPbKKzjTuFYC317KYE1bs8oLL2
 iTQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj8d05AGUvG9qFfHFBzCmr/o6eacAnLlsccMRgA95YwCMrB6PL8X+DPc8EQIDwteU4okcd7mv4oiiR@nongnu.org
X-Gm-Message-State: AOJu0Yz+xmwLfDqMC4V4hL9O9Z34geDfTY1Pq8U6XMUEhZWVylAWE7dY
 kapMRsgOu7/zLkPBpEI0hcCFSfXnRqnLtn1sSNNxTiPvDU1YCO4cUqbPXcUthJhbVMI=
X-Gm-Gg: AZuq6aLHt1kkARMkxVdEUqvoRlgafHbvje+HlwvMBJWk7BH/Z4wwFLgvxKCAsNn2vgV
 WSnaRlpYazOFSlVyYbPpW7g4o8upWRUN2M61qVZ4iITJJPi3q6jzvsy50S4LXk9sKsMn5SyfgYS
 78csckkr0dlG/Ql0xDYoDFrlrmsY5QkopyEkhFMtKc2gCKUSI6mk9VKlZx3zY4jHRFEfIScfSGi
 wMjlLmg/FEtnCp1R0bNQNOf36VeGXtqCSD/JYyHIkx6DpJA/ex8j8Lm4mSEUx/pYNPIlPAyNxxU
 GnvxR1lnTMG/9whjhqbsVh0pzq6IzjAHZ+IMx6l8SRXvMSp7lP2LjnO25Dib8kacl/8sOeNbDCG
 XkfF//GLFGqV+SXPv310mHttFEqI44rw5AG9qDPA+mtzdhfuD3e/DgEhJ/yE0lahe/JJVexB3LE
 TJpDtxoo/LqEo/AuerulJhQr0fKo+LJYi9ilJhGPBPr3/fkxMRnmPHH5cwCB7/il/OFg==
X-Received: by 2002:a05:600c:19d4:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-48373a6329emr41996645e9.22.1770996943668; 
 Fri, 13 Feb 2026 07:35:43 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99e194sm158317525e9.8.2026.02.13.07.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 07:35:43 -0800 (PST)
Message-ID: <f3c9a6e1-92cc-431c-a042-e36d22ce0c22@linaro.org>
Date: Fri, 13 Feb 2026 16:35:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] target/i386: emulate, hvf: move x86_mmu to
 common code
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Cameron Esfahani <dirty@apple.com>, Peter Maydell
 <peter.maydell@linaro.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
 <20260213034556.13471-2-mohamed@unpredictable.fr>
 <B6FEEE6E-6950-412B-AE56-BB4CCE980F51@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <B6FEEE6E-6950-412B-AE56-BB4CCE980F51@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 13/2/26 04:53, Mohamed Mediouni wrote:
> 
> 
>> On 13. Feb 2026, at 04:45, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>>
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>> target/i386/emulate/meson.build        |  1 +
>> target/i386/{hvf => emulate}/x86_mmu.c | 14 +++++++++-----
>> target/i386/{hvf => emulate}/x86_mmu.h |  0
>> target/i386/hvf/hvf.c                  |  6 +++++-
>> target/i386/hvf/meson.build            |  1 -
>> target/i386/hvf/x86.c                  |  2 +-
>> target/i386/hvf/x86_task.c             |  2 +-
>> 7 files changed, 17 insertions(+), 9 deletions(-)
>> rename target/i386/{hvf => emulate}/x86_mmu.c (95%)
>> rename target/i386/{hvf => emulate}/x86_mmu.h (100%)
>>
> 
> Oops, forgot this bit:
> 
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 9c5d85453d..0b3674ad33 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -263,6 +263,10 @@ static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
>   
>   static void hvf_write_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
>   {
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
> +    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
>       vmx_write_mem(cpu, gva, data, bytes);
>   }
> 
> Will include it in the next revision.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


