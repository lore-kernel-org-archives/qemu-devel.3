Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BADD78783
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 14:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWbgf-00027d-Cj; Fri, 19 Dec 2025 09:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWbga-00026Y-88
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 09:42:29 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWbgY-00087f-ME
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 09:42:28 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so988840f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 06:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766155344; x=1766760144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mFzUbEkSHGXLIgZ/r5WcVCOqhmVEZwYo1XQA2WbgWN8=;
 b=pKNXrFd5aM7fFsxdO+MnrNCvRPB7/Aj09YZaAntI5QenQvRsvZC+M4qlDMxv/Zg9xt
 Jy2ec1+xPfIu2UQF5hZbcPjhj2LmJS1kdm0xjgHJk5Iis32zJrDHbpBOVsox5DIE8upz
 hvZ+yzizY+sm3phPMTWkc0EqGPi/lejpV6G/O7dfJ7pxXsD3mcYYHlrA1I3c6+DQkREg
 PQl6LXDYf0h/bGuVw2deXmLkTgTJWnDtsTZkcpwfEse09/N9GqoEE7hR3LCoHnEv+NHU
 +22r/mcS8geOENZt9BJ70M1RzF6gslxfPNpb99nb216YMuamc7AnyZJFndqx7a72l0Sp
 ms3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766155344; x=1766760144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mFzUbEkSHGXLIgZ/r5WcVCOqhmVEZwYo1XQA2WbgWN8=;
 b=Uir3ouwgBlkP+PitRPEhvI5G7onhxlFF9bDWORJQ/KF5QbQ8k75qb9WArOi93G6bxs
 nXk7Qej2wzlfDgRkrg1VmZzRlkKWSdvMknPfKqYShQZx2nw7kjqlsrhqyYpozj69Kxoj
 aZZH1fiWEviCBWU2rgBOj38PF+W4QaQ0cjGVZptG6qbrI1xRkVtfoO+EUgH6+P7+jkr9
 wTUVMlluEQEpWtGAwojgxlSAHa5WrPoHS6cSAWNPmQl5S0HiwbQN5WLRle8LXGr3FgxT
 HmttaUL0W0sCnNQTAJlNB1mSz85h/8RMfhKF0ZjP69TiNejSEeUN5hzSTyr7FUbzdCYQ
 /aXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWblc3RbKYRwr2Ad3//dTVRU+Ab21VSmM0HITf56r7XZn4dNaUnAHMJyIADLXsj+3g+QgKrvzTYmzVg@nongnu.org
X-Gm-Message-State: AOJu0YzOwo5bKlxpZ9tLXyWmFQJFD68JAlhsWydr19zrsc07PurVr7mN
 Nd4E+EcmT/wmKgeRyLf648t+dSj9FkRwRI42pp3WfNCpRME2LXTeIk0eWnni87LS4R4=
X-Gm-Gg: AY/fxX6TntUHqo8jk2HO8vwI+AOJDiNpq2QiyDtLC24m8fXRJx3cZf9AC/rSxzFxKTO
 qZREfbZ+QDrJHH7eo4FDmymLgnhyMivTXe9uppMZIKFqroGW5oRsEcqz0CDGIJUYCu5kL0fleu1
 +6ehxPt56bhT7U7XuQuvykfuSwrUu4C5UuGmKd598fEg+WIV7pLP7ytcb5MGSezmgWFesoaLhF7
 5j4fKrLLLj01Ofm5nCS6DzRmg86sGOMzmZbH0tcojIqgklByB7Pg3yF4dYFXMmyiRC45tXBd9SG
 +b4nfFlOpwyCKC5GFgB4aSGatkmLZAI7h8T1W8R20rukI08gJ9J+MCPWNf+pJzKBHxhr042qLQS
 OtumATZgav343XQ6gFEAiRTdEHQ6h2hKS4YOSs8v6FLT+6LPECkf3adM5nQVb70PAkyjoIrF8eQ
 oXsi0WQKURmjibxAME7Ts+0Y0DwT/CL6I1bb3eIF3izUR+D34Lhbqtsg==
X-Google-Smtp-Source: AGHT+IFXt+0wsladlFIOplZZMM7wy73S2fPUo8wSNThC//p3fGwe7CgRH1Dx3IxykHsIbyxbCbfwDw==
X-Received: by 2002:a05:6000:2308:b0:431:701:4a22 with SMTP id
 ffacd0b85a97d-4324e4cecfcmr3559951f8f.27.1766155344522; 
 Fri, 19 Dec 2025 06:42:24 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82f6asm5431336f8f.27.2025.12.19.06.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 06:42:23 -0800 (PST)
Message-ID: <8c5ea2fb-79ef-42a5-bf27-3859499f25a7@linaro.org>
Date: Fri, 19 Dec 2025 15:42:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/microvm: account for SEV c-bit in 64 bit PCI MMIO
 hole
To: Cyril Leclerc <cyril.leclerc@subnoto.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251216194953.1183260-1-cyril.leclerc@subnoto.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251216194953.1183260-1-cyril.leclerc@subnoto.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

Hi Cyril,

On 16/12/25 20:49, Cyril Leclerc via wrote:
> microvm places the 64-bit PCI MMIO hole at the top of the physical
> address space. With SEV, the c-bit reduces the usable address space,
> so the MMIO hole ends up at addresses the guest cannot reach (the
> guest always strips the c-bit on MMIO accesses).
> 
> Fix by placing the MMIO hole within the sev guest addressable range.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3245
> 
> Tested-by: Cyril Leclerc <cyril.leclerc@subnoto.com>
> Signed-off-by: Cyril Leclerc <cyril.leclerc@subnoto.com>
> ---
>   hw/i386/microvm.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 94d22a232a..cb43a399ff 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -36,6 +36,7 @@
>   #include "hw/i386/microvm.h"
>   #include "hw/i386/x86.h"
>   #include "target/i386/cpu.h"
> +#include "target/i386/sev.h"
>   #include "hw/intc/i8259.h"
>   #include "hw/timer/i8254.h"
>   #include "hw/rtc/mc146818rtc.h"
> @@ -230,7 +231,11 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>   
>       if (x86_machine_is_acpi_enabled(x86ms) && mms->pcie == ON_OFF_AUTO_ON) {
>           /* use topmost 25% of the address space available */
> -        hwaddr phys_size = (hwaddr)1 << X86_CPU(first_cpu)->phys_bits;
> +        int phys_bits = X86_CPU(first_cpu)->phys_bits;
> +        if (sev_enabled()) {
> +            phys_bits -= sev_get_reduced_phys_bits();

No clue whether this is right or not, but please use logical operation
to remove a bit from a mask:

                 phys_bits &= ~sev_get_reduced_phys_bits();

> +        }
> +        hwaddr phys_size = (hwaddr)1 << phys_bits;
>           if (phys_size > 0x1000000ll) {
>               mms->gpex.mmio64.size = phys_size / 4;
>               mms->gpex.mmio64.base = phys_size - mms->gpex.mmio64.size;


