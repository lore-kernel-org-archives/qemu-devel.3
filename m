Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488BAED7B92
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZsA-0001Yu-2l; Tue, 14 Apr 2026 05:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCZs4-0001YJ-UX
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 05:15:51 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCZs2-00084D-3z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 05:15:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so1878777f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776158143; x=1776762943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XCk4HcphTywuTMhaSHp2v2iLapMiZxwN1A2t9mpTSko=;
 b=a7jXi+zq95im+eM739nopsXQoYgU4Dv7vhajp80x2RQudaY7jMel0Uo4djXvUKePHw
 /6lT0Uqenpngul/ltsSF3EmRUGwiw5SYn9uARr58Y4VtgogUwNUlFQG2giV6HIMxUDA/
 U/To/agJgHZioIHrlSUUTyUYa9LOXlUirnG8AYDsoh8Ytkt1uciiqqk0gTbyvUntAKtH
 mTKKm39xIz6iCuMOA1etpyM6EiQfxNbdvdlZiaFKxTc40UtZba/CjaapPLL769ELjgTG
 xBd1VNFpm/GC2OF2bHMb9Qgqt5Vte4cjHEhcmnryVZY49/158/oyRSfYlKLz7X0OUyJ3
 rQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776158143; x=1776762943;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCk4HcphTywuTMhaSHp2v2iLapMiZxwN1A2t9mpTSko=;
 b=OxJy5+TP1EMGZyvYR+sqvNeFsq7G5z1quayD4y7ZjHCnFxqxZIsNtG/emEY/muCI2C
 LxT32xvcw6q/ksl+RjS2BLJ9pRDPk1mlSB+xHb4fbIJlp9OscTvmKw7ZDf4Vd4nsbefl
 Tft6Lq9UU9x7L/lywNqNuhiZ+hfBbunQngIXsJaGw9fnfyLZblMivOYafaKcODo8jV7O
 wUnYLcaZXxBPsXYZObijtG5RakifTW3+9fxqpTJvw72Fgb3ZqMWnkZh50liOCD0kn4El
 mpqL1KuAdrZQC7XDrT1B/9LXvdUwOINL9J/e2sBzcSJg4XNIpirOEpAURgxKzRaTsuPU
 DSRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/gIJuF4wXCLN5x3wy3TiMSXoFYlpVhHkoFk/K0clBiRAv0h9/VjBu0C0nF/oEl4HuOxdC+YxCGYgR@nongnu.org
X-Gm-Message-State: AOJu0YxR9M070ZIG4j8whQcQP4g97kuZL9lKOrCIua5LZY2VcDbzpuYn
 tmZ63p6RdBIm9/DK0lb2bQcogAnouWMyvq39ur5B6A6gfUETdLuxsqTOAwSJUbBGpe8=
X-Gm-Gg: AeBDieupvubO5zc1sQ8VX7WCRdZTWG9lPulCCm3Z4xYmv9FIZBzv8tLD5toGEkR7gmg
 ZwGk0k0XGWoeWDCIP98pKJUcxTY7kByeItt/ZzAKqoGgSN7OdG65wjy/5pL6+POgv/rQPKv1SWY
 jVPhfHFchTTpgdaufuQxnoW8Sy/nRMWkFm5oAyt9dM2YYG+jgMHFXE7p8KI9QD1xyKjgM6FPedr
 ekgb+MMWVP3VdEaATTUY6N9d2NFsGrfbH/eLTZBfadQ5jYysB4ortIETOsQUC9yT0/HAXRL2ECp
 V5VregoZIR7FwTgnkjJVPoJeGniXAxA7w4ujtd9E4b7oIX8QnfX7xk+2mB6JjNTbwhrMujec586
 weIzudvs1zGgTC0xprwp3b6vMcbw2i2OzubOPQCeAzLOHRHGZzT3og9decJbkYYG9uof/EaOWkK
 Cs8Ucc9Z1STtxTMQdZ2QXRNqYjdLg9+0jdr0b/7ROycYVpW44ss/V3kfcPQy8VdpnjWA==
X-Received: by 2002:a05:6000:2383:b0:43d:7946:bae6 with SMTP id
 ffacd0b85a97d-43d7946bbc0mr9283257f8f.43.1776158143218; 
 Tue, 14 Apr 2026 02:15:43 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63de2a53sm38868373f8f.5.2026.04.14.02.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 02:15:42 -0700 (PDT)
Message-ID: <825cb787-b782-447d-90cf-d950d78e1cbb@linaro.org>
Date: Tue, 14 Apr 2026 11:15:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 v3] accel/kvm: return early from
 kvm_irqchip_create if kvm does not support irqchip
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
References: <20260414045911.63662-1-anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260414045911.63662-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 14/4/26 06:59, Ani Sinha wrote:
> During refactoring of kvm_irqchip_create(), the refactored code was returning
> early from do_kvm_irqchip_create() function if the required essential
> capabilities were not present in KVM. This was not translating to an early
> return from kvm_irqchip_create() as was the case before refactoring.
> This is because, do_kvm_irqchip_create() did not have a means to notify the
> caller of the lack of required kvm capabilities. Fix this by making
> do_notify_irqchip_create() return EOPNOTSUPP error when  capabilities
> are absent and then the caller can check the return code and return early.
> 
> Due to this regression during refactoring, all KVM guests on ppc64le hang
> immediately during startup and this completely breaks all functionality on
> that platform.
> 
> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> Message-ID: <20260413090010.60339-1-anisinha@redhat.com>
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> changelogs:
> v2: refactoring included which will resubmitted again for 11.1
> v3: basically v1 with tags added.
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 774499d34f..92af42503b 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
>       g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>   }
>   
> -static void do_kvm_irqchip_create(KVMState *s)
> +static int do_kvm_irqchip_create(KVMState *s)
>   {
>       int ret;
>       if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
> @@ -2587,7 +2587,7 @@ static void do_kvm_irqchip_create(KVMState *s)
>               exit(1);
>           }
>       } else {
> -        return;
> +        return -EOPNOTSUPP;
>       }
>   
>       if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
> @@ -2610,13 +2610,17 @@ static void do_kvm_irqchip_create(KVMState *s)
>           fprintf(stderr, "Create kernel irqchip failed: %s\n", strerror(-ret));
>           exit(1);
>       }
> +
> +    return 0;
>   }
>   
>   static void kvm_irqchip_create(KVMState *s)
>   {
>       assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
>   
> -    do_kvm_irqchip_create(s);
> +    if (do_kvm_irqchip_create(s) < 0) {
> +        return;
> +    }
>       kvm_kernel_irqchip = true;
>       /* If we have an in-kernel IRQ chip then we must have asynchronous
>        * interrupt delivery (though the reverse is not necessarily true)
> @@ -2835,6 +2839,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>       }
>   
>       if (s->kernel_irqchip_allowed) {
> +        /* ignore return from this function */

No need to explain the code. If you want to add a comment, explain
the "why".

>           do_kvm_irqchip_create(s);
>       }
>   


