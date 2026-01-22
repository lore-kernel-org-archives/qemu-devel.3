Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33F2D6CFA2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1zP-0003tn-VX; Thu, 22 Jan 2026 16:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexey.makhalov@broadcom.com>)
 id 1vj1P8-00029J-QQ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 15:35:46 -0500
Received: from mail-pl1-x662.google.com ([2607:f8b0:4864:20::662])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexey.makhalov@broadcom.com>)
 id 1vj1P6-0003e7-6y
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 15:35:46 -0500
Received: by mail-pl1-x662.google.com with SMTP id
 d9443c01a7336-29f2676bb21so14359855ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 12:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769114140; x=1769718940;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=58fEbDQzOEOcqM+aoJ/6Z+PPGOizVglKM3ox/7WE8xU=;
 b=Mr4aNx5UIKid3UGp8UOQ6xsN2jdykKh0Qa/1ilCQxjVuGhbj8sgf8tawsfXcB1Mxqa
 3PoByv8RolB2K9JFa8is0VX2u+1dNda94fO93LX5Di8OHdJI3kJaddPp6JoBEwPDP1T3
 3hw5Hkd98xTykTVNdnjPGyWWDu25klwzHy4yetUTKXhLwR7/arxW5W+QhIQ63c7zXhek
 mFSZPl92ydPWDrxxFoigdKMfLfw+WlubeKnpFVKlZV0OumyAM1oa5HaJ/rdGz/I3xSSp
 edZ8pHYwPqUsZJmF1ksd0H2K1zMxmMlsbSctKK3xKmI2StwVZhJ30k5aMInsZEswUIb7
 g7Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtiSIA0nPIBr7F8l9co9q5IeiyBk4iGGEshQG+xiA6RgSNznaBiZbw5gstw2+s9zqmXIqZVHg8iaQz@nongnu.org
X-Gm-Message-State: AOJu0YzGiae7SrfptaDFUAXlOk+FP/+IUGmyCMdtXxAcBLrFKmPr0pyg
 aVFAMFVEYCNo9IE/VIpv3DVk4iaMVRH0EfdyumKYOSDYs4XO1J6t3aklDu/UY3TCIfhu1hzIBHN
 wJ0oOtq+GkOXQZhxhIHeh8ngnEiBi8RSz9LYXq3wphazbV589F7hsZbMtTqeiShClWE1tlcJJjt
 Lsk/tsUOVayJ96tAvelLGtCmGpA+W+SpV7PWLGqsGXlbkaSZCFZPox2xMCuxf3WmRS+/wl4ZAhM
 N0CnpZBBjkjIQ==
X-Gm-Gg: AZuq6aLwlwMpTZd1BCCoVLNXUiZz5dI9aJUGwA8b+Yynmq23NJ0SYCVTo+Y38sLk8m4
 S79iCFFQhS8Uz5aUcCqiegQxPwEc/iaF8zlkalEbg65O1qfWxE4qtest60q9BOQMki1MPtcwS7e
 xkFprVuGkeixLc2aOF0FRHVCWaobo1976bhTgSPc0XrR8laR6J0XiFWWdw/77jnJgQ13yK1fMtU
 yUxGMlo/k1JQu56ep1lHcS/dmD26pZ/o0ZnIYYcAiYZvSuocGaFx6C5fOdre4EXWeHreLi85wuM
 TZqDt/7nAQ0uouTFlgSRxiSG4L7QnMp7ncA7FW6CzJzsWPlY26Ct8+ARoaTZu5dcFXlEhnGks3W
 BJQI1Qe1zkqhkdABd621NNNyk0z4cKT7rCo2wSqvDp5cC5ik7aI1eBN3C0hBMPZQ4iuF+wYzh4J
 erqJNRfORrUHknjrrtD0i0Fn09nKvqaXqqnaVazfbEAwGODg==
X-Received: by 2002:a17:902:f652:b0:2a3:1b33:ae11 with SMTP id
 d9443c01a7336-2a7fe75705fmr5058765ad.53.1769114140465; 
 Thu, 22 Jan 2026 12:35:40 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2a802dc810asm182585ad.21.2026.01.22.12.35.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 22 Jan 2026 12:35:40 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12339e20b66so1935519c88.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 12:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1769114139; x=1769718939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=58fEbDQzOEOcqM+aoJ/6Z+PPGOizVglKM3ox/7WE8xU=;
 b=APODwxr1WTdh7Txh+b8VlXjLpZ7aUVlxyARbxdxWWoNmX7jk2m1aw0iWQWFYVRz4YU
 yrAYsrfKATuWCLdhQlf7fcqnyvPO0DgMDlgm00eJBpGlr4gt8s8gqQwfGAXedE7WNriv
 PnznK8dkbUtDfmdDHYPWKbJpZMmdfaPq87myQ=
X-Forwarded-Encrypted: i=1;
 AJvYcCXvnSiA5B9RZU2RaYvLSA2aW8x9HqUEfol2yfEnMwup2PDVxymCsiMRFcFGZdUDpbt9De0z7HzeAFC2@nongnu.org
X-Received: by 2002:a05:7022:6996:b0:119:e569:f60a with SMTP id
 a92af1059eb24-1247dbadf64mr317196c88.3.1769114139002; 
 Thu, 22 Jan 2026 12:35:39 -0800 (PST)
X-Received: by 2002:a05:7022:6996:b0:119:e569:f60a with SMTP id
 a92af1059eb24-1247dbadf64mr317179c88.3.1769114138436; 
 Thu, 22 Jan 2026 12:35:38 -0800 (PST)
Received: from [10.66.193.70] ([192.19.161.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1247d998102sm888987c88.10.2026.01.22.12.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 12:35:37 -0800 (PST)
Message-ID: <7577f589-8d56-4bbf-aa6d-d2c7d45cbf28@broadcom.com>
Date: Thu, 22 Jan 2026 12:35:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/vmmouse: Fix hypercall clobbers
To: Josh Poimboeuf <jpoimboe@kernel.org>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Justin Forbes <jforbes@fedoraproject.org>
References: <ae0b8f2c574abe8053e742260c794adcaeda975a.1769110562.git.jpoimboe@kernel.org>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <ae0b8f2c574abe8053e742260c794adcaeda975a.1769110562.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Received-SPF: pass client-ip=2607:f8b0:4864:20::662;
 envelope-from=alexey.makhalov@broadcom.com; helo=mail-pl1-x662.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 22 Jan 2026 16:13:09 -0500
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

Thanks Josh for a quick fix.

Acked-by: Alexey Makhalov <alexey.makhalov@broadcom.com>

On 1/22/26 11:36 AM, Josh Poimboeuf wrote:
> Fedora QA reported the following panic:
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
> The panic was triggered by dereferencing a bad pointer (RDI) immediately
> after a VMware hypercall for VMWARE_CMD_ABSPOINTER_DATA in the vmmouse
> driver:
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
> Reading the disassembly shows that RDI should contain the value of a
> valid kernel stack address here (0xff5eeb3240003e54).  Instead it
> contains 0x40003e54, suggesting the hypervisor cleared the upper 32
> bits.
> 
> And indeed, Alexey discovered that QEMU's vmmouse_get_data() and
> vmmouse_set_data() are only saving/restoring the lower 32 bits, while
> clearing the upper 32.  Fix that by changing the type of the saved data
> array from uint32_t to target_ulong.
> 
> Fixes: 548df2acc6fc ("VMMouse Emulation, by Anthony Liguori.")
> Reported-by: Justin Forbes <jforbes@fedoraproject.org>
> Debugged-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   hw/i386/vmmouse.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index 2ae7f3a242..3bba221d5f 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -72,7 +72,7 @@ struct VMMouseState {
>       ISAKBDState *i8042;
>   };
>   
> -static void vmmouse_get_data(uint32_t *data)
> +static void vmmouse_get_data(target_ulong *data)
>   {
>       X86CPU *cpu = X86_CPU(current_cpu);
>       CPUX86State *env = &cpu->env;
> @@ -82,7 +82,7 @@ static void vmmouse_get_data(uint32_t *data)
>       data[4] = env->regs[R_ESI]; data[5] = env->regs[R_EDI];
>   }
>   
> -static void vmmouse_set_data(const uint32_t *data)
> +static void vmmouse_set_data(const target_ulong *data)
>   {
>       X86CPU *cpu = X86_CPU(current_cpu);
>       CPUX86State *env = &cpu->env;
> @@ -197,7 +197,7 @@ static void vmmouse_disable(VMMouseState *s)
>       vmmouse_remove_handler(s);
>   }
>   
> -static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
> +static void vmmouse_data(VMMouseState *s, target_ulong *data, uint32_t size)
>   {
>       int i;
>   
> @@ -221,7 +221,7 @@ static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
>   static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
>   {
>       VMMouseState *s = opaque;
> -    uint32_t data[6];
> +    target_ulong data[6];
>       uint16_t command;
>   
>       vmmouse_get_data(data);
> @@ -247,7 +247,7 @@ static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
>               vmmouse_request_absolute(s);
>               break;
>           default:
> -            printf("vmmouse: unknown command %x\n", data[1]);
> +            printf("vmmouse: unknown command " TARGET_FMT_lx "\n", data[1]);
>               break;
>           }
>           break;


