Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40131C0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 18:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thCHq-00026N-BI; Sun, 09 Feb 2025 13:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thCHn-00025m-69
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 13:44:07 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thCHl-0000pA-I3
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 13:44:06 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dd0dc21b2so912338f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 10:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739126642; x=1739731442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RBdZbL2HQ4hv8JDGjkvd1u6fWEH0VQeBuOZiwzugxU0=;
 b=pRZ3y7tFDEAdlWtCH+ec3lqnpBKXLgOQ1DJbIUJjIU8lVfCR3Ly5yQwA8Stm2OIsiW
 +G1PvOQdpMA6eF+xMM7Fuhu0voCPPcdBFlePYxKGsrPK9MWQQyPhC2C4tA0Ua5idhbXG
 MekZAyMJD/otzhbNgRbVyjqgEoZjsI2C9vvAu0Ah5aKllG5yZYDmdiE/j4SvUu+xVXow
 pQZzsHirbdYz1ljQgppGvUd/4uy4xDbO0fQPPgdv8ypyCMkAtLuScJud+sC7k9umrs0J
 W05dYFYO+Lf0h/2Sot56gLi1lIo+DAagM3B4S8CoFOjOze16quTMTuFo+qRGtyepWHjV
 YhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739126642; x=1739731442;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RBdZbL2HQ4hv8JDGjkvd1u6fWEH0VQeBuOZiwzugxU0=;
 b=TZv6ILgjyxJJ2JE2qDIA+ldCYoz7Ar2KrxzabaO/hPxaZsw+N82Y547yf1m8uG6Gkt
 gqrboih2e2sYKSLcN6P712gOzeUCydeKRI1GG4Mr1R04TKaIH2fEFMXbUML30GrXR/RA
 B8Dpwv05zAa1NvCXCJfaQLZ8xfAANMaPaz9aPTOMkNGR9QhI8VPkCUrkFGgwfWY34rny
 ElghzW3nmAMWZ3q/kZ4goYByA7K2cug+kbMC84dQLqwAZDfMHSxlpAOqgBnwMYtoHt6L
 Q5CTwZRcEhrLta8CxkXTGkHTKJ34EA6YlTBvDvoDETr+AI58v43goKblEdEIQC/G6H6d
 D0wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk9psmG5/WLk9DKRLbsqg8Tq/QVoi91plVTuDhJwr3bv3HxCmJ1786V4BEqQjNZnfrSZGymfQS9n/c@nongnu.org
X-Gm-Message-State: AOJu0YxAQ/lZiQLcHNwHAl2M8rd0QrNgeg13Tfy5HgkKiJfDEvQUEQkx
 cRUpBtl5TRR2xAu36K+MhKL68GabrlQv/5sKxyfpdpTv9V1b6zGV4DsR8CtyYrLPmjJaRp6ESDN
 vnk8=
X-Gm-Gg: ASbGnctzkczIQ81/YEc785tfdozDT6/fD8ueBezhz7mi9O3B8klfsydZ5XK7ISMmt1W
 px9V8SDzjVf0ucnkiA7hsMCXqcuk7nfE+1KSkuhnCMMNukygqJFepTQC+10exKAsDyKEs6WGJ8w
 T5qYJgaJ09LBLTz2UOaFtIfflEk3eA2n86dBkhOjvqMFGrtbNpf5vU9eLTMLmThym0bJ1cRHa7G
 ok3mM17AQ+zOoLrkKCirHHZtauX3UsezO1FVo38jX+goUZ72Vk4bQlmRpWTYrKIxg7mkABufXD1
 mYchE6aQtXd/hjGIc1QcB0qIRdj/Qy8Afq/hZ0aL8gQPMr1wCv0GBYrqX08=
X-Google-Smtp-Source: AGHT+IHP9vP0OQy42SCdXm/Vm3d/gH9my79wjFrKLWTB3QJJF4/MTi9GhJYG5NKs/KDyVkuEHzHlyg==
X-Received: by 2002:a05:6000:400f:b0:385:f220:f798 with SMTP id
 ffacd0b85a97d-38dc8da6361mr7011057f8f.6.1739126642418; 
 Sun, 09 Feb 2025 10:44:02 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd2e0765esm5114463f8f.82.2025.02.09.10.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 10:44:01 -0800 (PST)
Message-ID: <d375a630-d136-4e0e-9103-fd4dcb1e03d7@linaro.org>
Date: Sun, 9 Feb 2025 19:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] target/riscv: introduce RISCVCPUDef
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250206182711.2420505-1-pbonzini@redhat.com>
 <20250206182711.2420505-3-pbonzini@redhat.com>
 <f4ec871d-e759-44bc-a10b-872322330a3f@linaro.org>
Content-Language: en-US
Cc: Max Filippov <jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f4ec871d-e759-44bc-a10b-872322330a3f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 6/2/25 22:16, Richard Henderson wrote:

> It would be nice if this were const, i.e.
> 
>    .class_data = (void *) &(const RISCVCPUDef){
>        ...
>    },
> 
> This will in fact create an anonymous object in .rodata.
> 
> We have other uses that do the extra casting away const,
> e.g. armsse_variants in hw/arm/armsse.c.  Although I suspect
> *all* usage of .class_init can and should be with const data.

The only non-const use I noticed is Xtensa:

static void xtensa_finalize_config(XtensaConfig *config)
{
     if (config->isa_internal) {
         init_libisa(config);
     }

     if (config->gdb_regmap.num_regs == 0 ||
         config->gdb_regmap.num_core_regs == 0) {
         unsigned n_regs = 0;
         unsigned n_core_regs = 0;

         xtensa_count_regs(config, &n_regs, &n_core_regs);
         if (config->gdb_regmap.num_regs == 0) {
             config->gdb_regmap.num_regs = n_regs;
         }
         if (config->gdb_regmap.num_core_regs == 0) {
             config->gdb_regmap.num_core_regs = n_core_regs;
         }
     }
}

static void xtensa_core_class_init(ObjectClass *oc, void *data)
{
     CPUClass *cc = CPU_CLASS(oc);
     XtensaCPUClass *xcc = XTENSA_CPU_CLASS(oc);
     XtensaConfig *config = data;

     xtensa_finalize_config(config);
     ...

