Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB42C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAqz-0007fj-E7; Fri, 11 Jul 2025 06:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaAqt-0007Zr-VO
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:19:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaAqr-00020Q-37
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:19:35 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453643020bdso14769085e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752229168; x=1752833968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zhGqM2BKY3kFj2qnGDPGI0reWpndg40GuwtmL7GUpu4=;
 b=y52QH4rc8lsY1mlTBZmFo49kPF3jLE+8en5y0DL2jWNnwJ1SZ5ZWJmTBpGcLo9Jvqs
 VaV11J6nF6lSfbVbathntZAN6ntqK3uDZf3zamjqlRH4TG7uAlyBkJGSMr3OeqSz6yN1
 aD3MbU28kV4qdsauwHvlrL7wLSDIUL4g3KuZBiTxCZQaNzm0xvkT/Dk1HWTwqNVac/wY
 Hh7kzXJ/ZqaR//tlKhDBbeJSDAF+RJxDgosREO4FVu95QRo8t3N/6UHYsORVYLqcl9ZX
 ByQyR7nlaUEBEDczPrPHxmTmUqVAYecZrTitiRZHBoIUcLGizx9Sj+86i9c5nnkGY/hF
 zQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752229168; x=1752833968;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zhGqM2BKY3kFj2qnGDPGI0reWpndg40GuwtmL7GUpu4=;
 b=bZfJtZNSF/RXBsgmvupoGpf/TcsL6NS9iB3VmEJ1lasVYNAcWfyJ7DPnF7vehrVqT2
 UIdC/kCS/WELFsvUc/lPNKYe+Nw/QlYJpWeX3KcS2w/DLQAOQbELHMjwL2dAf9yZysPr
 dIPU4iyTTfMrUCWwSIlf2ygjIfYd0lAVEW/zV/2P+7l3+94hG1wd1loWDXpMqgsyAIZB
 elEdUmlUoyEX4dd1JB0YaOpyl2Soc+ZNOKc+HizL2P9um0dmA9JJIpzWvnnySS2f5d1o
 OjLbi9mfa2zhcV3raZGD0MLxxuJPYZ9GlXwR/p7Qb0dJM05EbeRRJhFJVFMnyKT6sjDA
 wvCA==
X-Gm-Message-State: AOJu0Yy0odnLZtohUeYRrbkiIhN/5K6FGTkU+lUjBVrd/sMFj+wGrv0n
 6E7YK34qQ2/ig2eq324Ik8xvVmD5FezJp5LJ6ymakdOOojeaDsjla8vFO9RYpb/BvZY=
X-Gm-Gg: ASbGnctrYRUFawtgwdgLzOrvrMZ8nOmx5OM3OGH3x/wj0pdkL2sryvQ4M3bgPkQmpla
 0/E8MSzHCZQnxryOHWsU3FIr5xOmqMgpSGPTuyPeV4xJqLx2ymnEf7TsRR957s6XyZLM5RCryiT
 MhkVinXGXYXpA9mFUm9F9lR+uR2x6msNQMtRFrPYHLKjj9xVF8TaV1Q2GBMjoV81UzsUDrt3309
 Gsiu9lHEMM+mEWcGri95WpsujJOlpGsQ9Z/9hGzPgBlyBmRwNXoKX/ZIWX00kGCIy0uGULO6ojl
 3xL7tgQ6uAYM6Hni0z8PSzcLHd4Rvv1oYetPL+9Y9xcf6UR64uK2iMe6iwS+nVgINKi+s8YhkC0
 +kZ4jzYydIVfjE58LGFhiBNgWB3LIr+7m/Ez13zJeAba0h5PLRb28iid7/FAaWv68ZcnxZQ==
X-Google-Smtp-Source: AGHT+IFO4xH0Szvt2qzJUdyV/rPWU4crVI/Zxp+B4cIIg6vl6cqId9cpoF7qvPU+3I8Xxo8PsMEt2w==
X-Received: by 2002:a5d:5e90:0:b0:3a5:5270:a52c with SMTP id
 ffacd0b85a97d-3b5f18168e9mr2546080f8f.0.1752229168070; 
 Fri, 11 Jul 2025 03:19:28 -0700 (PDT)
Received: from [192.168.1.47] (lfbn-mon-1-587-20.w2-4.abo.wanadoo.fr.
 [2.4.165.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26c8bsm4034175f8f.88.2025.07.11.03.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 03:19:27 -0700 (PDT)
Message-ID: <cb840e55-3f12-4005-9fc6-883876971241@linaro.org>
Date: Fri, 11 Jul 2025 12:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: merge host_cpu_instance_init() and
 host_cpu_max_instance_init()
To: Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org
References: <20250711075507.451540-1-pbonzini@redhat.com>
 <c5d96f80-31c0-44dc-8f7a-557367a1abc9@intel.com>
 <CABgObfZ95PAHOZ-2RSj=nPi5J5KGVPmjuB4tzY0oKX07mddg=g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfZ95PAHOZ-2RSj=nPi5J5KGVPmjuB4tzY0oKX07mddg=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 11/7/25 10:17, Paolo Bonzini wrote:
> On Fri, Jul 11, 2025 at 10:16 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>> On 7/11/2025 3:55 PM, Paolo Bonzini wrote:
>>> Simplify the accelerators' cpu_instance_init callbacks by doing all
>>> host-cpu setup in a single function.
>>
>> btw, it changes the behavior for "-cpu base" with accelerator.
>>
>> I think it should be OK considering "-cpu base" seems only for
>> experiment case.
> 
> Yeah, I wonder if it should even be user creatable.

Per commit 5adbed3088d ("i386: Define static "base" CPU model"):

     Despite having no CPUID data set at all, "-cpu base" is even a
     functional CPU:

     * It can boot a Slackware Linux 1.01 image with a Linux 0.99.12
       kernel[1].
     * It is even possible to boot[2] a modern Fedora x86_64 guest by
       manually enabling the following CPU features:
       -cpu base,+lm,+msr,+pae,+fpu,+cx8,+cmov,+sse,+sse2,+fxsr

Anyhow I don't mind if it becomes hidden.

Regards,

Phil.

