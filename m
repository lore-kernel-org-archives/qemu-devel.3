Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1A610FCADE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 21:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82hv-0006OB-4V; Wed, 01 Apr 2026 17:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w82ht-0006M2-1j
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:02:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w82hq-0008Bn-Nf
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:02:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486fe655187so1749235e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 14:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775077349; x=1775682149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wu484ARXgNjrCXY792DVUqnqI/7zasFvjnpp9c4Q+uo=;
 b=JRazDKsPyUBHzXaqf5Vz3q0xqJYCOPxZhRf6CSjVzmZ4dkbPD3mSvyJir4z5epl0Ve
 4jVs0qr9AobW1/N1BqXI72yhyQiAl+KkHHExSELALJ5txJU7onTDSKm5ODEMpdyAgetL
 2SfJ98XMbU2CEClahxCFQ0iSj58QUoZ4plk8an5oF71iejOpKDr+xNI/YTJOEDsFMHCs
 9p0bgcTZTRXhOzmArLg4yLovDGTP6BWezBHdLb3t5M04nE7LgOy7IryhzHOp/716YP3J
 HpYH8SzXy8pUC9JBp4M4nkC2ZNh1cV6dR1Da758p2DgbyILvGIKc5lnK2skw+Dqv030H
 Gk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775077349; x=1775682149;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wu484ARXgNjrCXY792DVUqnqI/7zasFvjnpp9c4Q+uo=;
 b=l4VvYwP4QgI/mU+aWcgPYaGy66ffnNq8S+WMM/czEkaRriOswiCfGBRy5WneyWVslJ
 wCV3i7cdThGBw4m2uLSJ/9n3JE9mhFdAzIdZ8DtwcwLCnfGNJXHoZ86CG7jZPt/L1G0J
 16asnMAW3l4G8pE4M6UzKR45ev0mWXB5/wrvhQQDDGP4woG1vaAjNsTjTWFi9GLHW5sQ
 Kov+t8bn+PFAG0TyeH+nmTQEcr7+lOjqdBFR++Qhz26cT/hAPQLBeONFzrGWzPkwJ1yj
 W+4fkQiU/4XxlAxOUgCKzw+wvk+1bLYnDSv++QH93Sjj67ZNipIPW8z3mU8Vo+I8YRIb
 84DQ==
X-Gm-Message-State: AOJu0YwYUuRhxFJOUR5bbA2QYS0Xw+NJj4SOQ7hM3jYHYsZixdud92nB
 8/2Rc4AItshQk8MSGkAdv7alRGQCv+SjUSummK4TVWP112gwCW9jP48pwSCM/ke6c1SpVhETbfn
 B+Sd3d8E=
X-Gm-Gg: ATEYQzx6h20ANQp/Tf3Y+k8r6ah8y/KXkjTbOCyWpl+NXoLXhlQ+CJdrVCeg+Y2X35B
 pecH9P00to3recPEoYiPYSxORd0DW2dDzHf4FOYvCU1R9ukVh9thwVN5aPs7lg9lv1AcNZ+ip7k
 5+UwMbRsxV3m91YSfZJVKxlM3TQs+XaZeiLwtcfzea4oltzkHsQhntnLq30g2T7HY+Wg+5q6cGM
 bVBUD10/6FxuQ+BpBtzedtcdfYOge70Pi9fi15bnLp5VF+4yDXEAIoqTuxgSQzBmZ6xeZvBeKAI
 DeOkR362AjD+TYv3+Ig11mlWq0klnQkcirSrDqgCOnhCrUpmuyf96N7FXxJ4apPWNn43Dg/U4qY
 znIM0yNsB6BWU0vNPzv9Ims2xtKgvSYeZbSezWScuAPyPkzB3GDL3rEWONluqloBa7gFAuz9S6G
 ua8kBm979Z8+CNkZextAjkWMsx3SYT2AZoKX4DrBE88zIc7/r4YZE29LfQr4YubsswYg==
X-Received: by 2002:a05:600c:c165:b0:488:7ff6:1f75 with SMTP id
 5b1f17b1804b1-4888b786676mr11650045e9.21.1775077348657; 
 Wed, 01 Apr 2026 14:02:28 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888955d711sm41710665e9.9.2026.04.01.14.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 14:02:27 -0700 (PDT)
Message-ID: <b449667f-11d0-48d8-864b-dc17f30a18fd@linaro.org>
Date: Wed, 1 Apr 2026 23:02:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 3/8] accel/kvm: Expose all non-target specific
 declarations
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, qemu-riscv@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Anton Johansson <anjo@rev.ng>, Song Gao <gaosong@loongson.cn>,
 Weiwei Li <liwei1518@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, Bibo Mao <maobibo@loongson.cn>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Zhao Liu <zhao1.liu@intel.com>
References: <20260401201753.92290-1-philmd@linaro.org>
 <20260401201753.92290-4-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260401201753.92290-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/4/26 22:17, Philippe Mathieu-Daudé wrote:
> None of the declarations guarded within the COMPILING_PER_TARGET
> checks use target-specific declaration. "cpu.h" is not required
> since some time (maybe commit 4fb54de823e "meson: build target
> libraries with common dependencies"). Remove the restrictions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/kvm.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index a2463a3ac3f..8bf7a10deac 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -224,9 +224,6 @@ void kvm_irqchip_add_change_notifier(Notifier *n);
>   void kvm_irqchip_remove_change_notifier(Notifier *n);
>   void kvm_irqchip_change_notify(void);
>   
> -#ifdef COMPILING_PER_TARGET
> -#include "cpu.h"

Missing:

   #include "qemu/queue.h"

>   /**
>    * kvm_update_guest_debug(): ensure KVM debug structures updated
>    * @cs: the CPUState for this cpu
> @@ -449,8 +446,6 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>   int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                          hwaddr *phys_addr);
>   
> -#endif /* COMPILING_PER_TARGET */
> -
>   bool kvm_arch_supports_vmfd_change(void);
>   int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s);
>   


