Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0CAECD9A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo67V-0004Oa-DN; Thu, 05 Feb 2026 15:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo67S-0004OK-15
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:38:30 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo67P-0001qP-UW
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:38:29 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so164815e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 12:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770323900; x=1770928700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=45D5IrujDDf1S62gQLfN8X64aPHVOxpaNaH1L4123Q4=;
 b=K6MXhba2Qm5G/ydKZ7SHxxP/VN24jWgY+1lz9S6O0XusLJP1z0SsoW9Th7P8e1mi93
 IHzxJwx/QsWfzc7C7k15Bl/MfIzaHl+8M1KZSeA4tmVGcgKGRPve+DPxTNsqEigmpKIo
 AyOcx28Gphq0Qbik5CG0AtOcl2jc5BXKDaAWZrRyNtwfGWIrB/kDDvz53amyki6h7Xyx
 56usj99bGXHpvenTaeH07X+GkIWXlRQMw6m9cyPK/+8JqwxjtlnTlNsDkAq8tuiT8mBb
 7Ajr79Ds0LLoNeJxT8j7RoqTz9NnLJoBDw+NwBfQ+kEO1zeJFHG2wI0vbzJMkUou88Ek
 7Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770323900; x=1770928700;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=45D5IrujDDf1S62gQLfN8X64aPHVOxpaNaH1L4123Q4=;
 b=LNwzF9OmamQ4DNuB3yVVqjqY+EnhRcP1o9njjWaKSRnnK18kL19iSiQDnOS/tn7ouR
 KK8PhsKj3kLc3mteMLescn7QJw70++Qa5GtKfOjasXTIK9V1YiaRtsTMofv+Vu5eBpbm
 guhLDe6sBAthNOa0u4O1hvTaobA5CsZ/7IFFei2TK8kDLY7kxI+H+llz4zirg8vzZGI5
 P4as0TyK8ozYryjceHbsXhr4nMapHuY+IJrxAj/2DIiT3IaC9LNgHS5vpkEvC03Rh4PM
 1fti8uJoN7kz8CgWaXEXe4GPJmTWtmLzaS3iRb5915xEx6bZumSn6TH1k16mWunZUDX6
 hKvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0gQPy1+VU/2DRFiHBKej+etOzXTinBzSgQrKxtKGDQdjdQZpPIIcA/bTWG2who1JB/tKUESSYDJwh@nongnu.org
X-Gm-Message-State: AOJu0YzmaeyiXDC3ehEYyTZUSkHnckof39KphBMQ8wJVJB1Sh6DilD5v
 r0a7Glhc0vzgfQ9mQUYKr2odZlnoWbNV3VesjkaqKumo/8SKxDs3IcP1UPBfr/G4aA0=
X-Gm-Gg: AZuq6aLAMlMkHIDS2gLexJrMiTPKUJnR4eD1HyabVGYkLUBqAVosqMYaowLDKwSM62t
 XC0AZUs7foLIRQ5UZIF3pg0TOGXr9cgMPAjtfLON5074MTaB8bxRlhkiZbtCycQbLnBSxmaZbi0
 23Zo97peB0oUeT5/qDtxyHY+FSskYtJy/p6WmSLc7DkGgHaGnWRdAXcO6oJSi3tL5sl7cYSG73T
 t3tSD5TJSXbebR7tOyrdifVuJallD1U2vOHnlJZrUk8UDpDLFpg0U4ewYA6pPyNXEl9onWM940i
 v4g9Hc4KCFl0Rq6F7ETOoEtjQjiAYIs9U+bxe6ZsPZcKzV/i+iGFMpb5LfT06NbUBIlaBk21ELc
 k5hWFuj+Ff5a0aGRQTy0/EmMxQDWXz4M5rImuR0rNR/0pV/uJROXOtudMDjBsv7PxOpKRhMQeDd
 RWkVLaGFWv+v1el+Jye51Qlx8d3pyK0O/ndCtgLGxKxnnUKiWCJErXBsgS76RwgzqH
X-Received: by 2002:a05:600c:3553:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-483201da2d6mr9063595e9.3.1770323899767; 
 Thu, 05 Feb 2026 12:38:19 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483203d606fsm3238515e9.2.2026.02.05.12.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 12:38:19 -0800 (PST)
Message-ID: <c64e8c71-029b-4989-b056-29d8ceda2804@linaro.org>
Date: Thu, 5 Feb 2026 21:38:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/i386/vmmouse: Fix hypercall clobbers
Content-Language: en-US
To: Josh Poimboeuf <jpoimboe@kernel.org>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Justin Forbes <jforbes@fedoraproject.org>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>
References: <c508fc1d4a4ccd8c9fb1e51b71df089e31115a53.1770309998.git.jpoimboe@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c508fc1d4a4ccd8c9fb1e51b71df089e31115a53.1770309998.git.jpoimboe@kernel.org>
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

On 5/2/26 17:47, Josh Poimboeuf wrote:
> Fedora QA reported the following kernel panic:
> 
>    BUG: unable to handle page fault for address: 0000000040003e54
>    #PF: supervisor write access in kernel mode
>    #PF: error_code(0x0002) - not-present page
>    PGD 1082ec067 P4D 0
>    Oops: Oops: 0002 [#1] SMP NOPTI
>    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-0.rc4.260108gf0b9d8eb98df.34.fc43.x86_64 #1 PREEMPT(lazy)
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20251119-3.fc43 11/19/2025
>    RIP: 0010:vmware_hypercall4.constprop.0+0x52/0x90
>    Code: 48 83 c4 20 5b e9 69 f0 fc fe 8b 05 a0 c1 b2 01 85 c0 74 23 b8 68 58 4d 56 b9 27 00 00 00 31 d2 bb 04 00 00 00 66 ba 58 56 ed <89> 1f 89 0e 41 89 10 5b e9 3c f0 fc fe 6a 00 49 89 f9 45 31 c0 31
>    RSP: 0018:ff5eeb3240003e40 EFLAGS: 00010046
>    RAX: 0000000000000000 RBX: 000000000000ffca RCX: 000000000000ffac
>    RDX: 0000000000000000 RSI: 0000000040003e58 RDI: 0000000040003e54
>    RBP: ff1e05f3c1204800 R08: ff5eeb3240003e5c R09: 000000009d899c41
>    R10: 000000000000003d R11: ff5eeb3240003ff8 R12: 0000000000000000
>    R13: 00000000000000ff R14: ff1e05f3c02f9e00 R15: 000000000000000c
>    FS:  0000000000000000(0000) GS:ff1e05f489e40000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000000040003e54 CR3: 000000010841d002 CR4: 0000000000771ef0
>    PKRU: 55555554
>    Call Trace:
>     <IRQ>
>     vmmouse_report_events+0x13e/0x1b0
>     psmouse_handle_byte+0x15/0x60
>     ps2_interrupt+0x8a/0xd0
>     ...
> 
> It was triggered by dereferencing a bad pointer (RDI) immediately after
> a VMware hypercall for VMWARE_CMD_ABSPOINTER_DATA in the vmmouse driver:
> 
>    ffffffff82135070 <vmware_hypercall4.constprop.0>:
>    ...
>    ffffffff821350ac:       b8 68 58 4d 56          mov    $0x564d5868,%eax
>    ffffffff821350b1:       b9 27 00 00 00          mov    $0x27,%ecx
>    ffffffff821350b6:       31 d2                   xor    %edx,%edx
>    ffffffff821350b8:       bb 04 00 00 00          mov    $0x4,%ebx
>    ffffffff821350bd:       66 ba 58 56             mov    $0x5658,%dx
>    ffffffff821350c1:       ed                      in     (%dx),%eax	<-- hypercall
>    ffffffff821350c2:       89 1f                   mov    %ebx,(%rdi)	<-- crash
> 
> Reading the kernel disassembly shows that RDI should contain the value
> of a valid kernel stack address here (0xff5eeb3240003e54).  Instead it
> contains 0x40003e54, suggesting the hypervisor cleared the upper 32
> bits.
> 
> And indeed, Alexey discovered that QEMU's vmmouse_get_data() and
> vmmouse_set_data() are only saving/restoring the lower 32 bits, while
> clearing the upper 32.  Fix that by changing the type of the saved data
> array from uint32_t to uint64_t.

TBH v2 is even nicer/clearer, thanks for it!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Fixes: 548df2acc6fc ("VMMouse Emulation, by Anthony Liguori.")
> Reported-by: Justin Forbes <jforbes@fedoraproject.org>
> Debugged-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   hw/i386/vmmouse.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index 2ae7f3a242..d9b1fe0515 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -72,7 +72,7 @@ struct VMMouseState {
>       ISAKBDState *i8042;
>   };
>   
> -static void vmmouse_get_data(uint32_t *data)
> +static void vmmouse_get_data(uint64_t *data)
>   {
>       X86CPU *cpu = X86_CPU(current_cpu);
>       CPUX86State *env = &cpu->env;
> @@ -82,7 +82,7 @@ static void vmmouse_get_data(uint32_t *data)
>       data[4] = env->regs[R_ESI]; data[5] = env->regs[R_EDI];
>   }
>   
> -static void vmmouse_set_data(const uint32_t *data)
> +static void vmmouse_set_data(const uint64_t *data)
>   {
>       X86CPU *cpu = X86_CPU(current_cpu);
>       CPUX86State *env = &cpu->env;
> @@ -197,7 +197,7 @@ static void vmmouse_disable(VMMouseState *s)
>       vmmouse_remove_handler(s);
>   }
>   
> -static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
> +static void vmmouse_data(VMMouseState *s, uint64_t *data, uint32_t size)
>   {
>       int i;
>   
> @@ -221,7 +221,7 @@ static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
>   static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
>   {
>       VMMouseState *s = opaque;
> -    uint32_t data[6];
> +    uint64_t data[6];
>       uint16_t command;
>   
>       vmmouse_get_data(data);
> @@ -247,7 +247,7 @@ static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
>               vmmouse_request_absolute(s);
>               break;
>           default:
> -            printf("vmmouse: unknown command %x\n", data[1]);
> +            printf("vmmouse: unknown command %lx\n", data[1]);
>               break;
>           }
>           break;


