Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBFCC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 10:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukKkL-0002sN-2i; Fri, 08 Aug 2025 06:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukKkI-0002nx-U9
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 06:54:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukKkG-00054K-F2
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 06:54:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so12751225e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754650481; x=1755255281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WNhqOzyDwe5dusDE+NJULiqYkQaDt+VVSfCckGVd1/k=;
 b=oFxkb/ImA4QXK8N+rMyW+euIIwqXeTHH9m9Y4RGtALs5W37BUJJFEPjPcNLazXY+oF
 Hin46oedJSqnuTo+hrKI1HE5U6q7Y5FwGgSvgwLF2S86IDOMCXc76k+8hDkeZR6Nq/xS
 WT9tnQTCY3amboi3ZVwuWzMSZIXV/nrCXighXj2NOJ5iEMw7Kn1/FkeQJ84l9hyPwHlu
 Efe343JzCNHh3GbFm4MX6uYzyJzJd+VkYie2KvEfioqolEGkguEeIeEMuSGenKczwbXw
 NBAgz3EC43xbtyxPXN1oZLpOJk9jdLUdyP/jBlmahqpVJEiHyxOZmKEWCgK/VMzaa/Ts
 fv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754650481; x=1755255281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WNhqOzyDwe5dusDE+NJULiqYkQaDt+VVSfCckGVd1/k=;
 b=GbSwqgUkFTT+vUx/aoMDLs5log6vAYhAlNvjngfuYwhiuCVTLSztxfrN0f5yu8S/XN
 4kdlTVSAGsNj6MGgQn4bzPioIdxIcEKNYyIdploxxme+YkkxszD/3lmp4QcktWRa5FRo
 A2vpIY5GeJ8S/0+du+UcG6huUFJN5rCEPU26Zczdk771f6rTRq9cJybFDooTy9HZw4Qm
 MG35TDmlj7mvc8QbDuJrhMms5MErBOyEE3ytoziLm02dZBqeZeGR+zpdWx2cC758eBJA
 LXZMTyRJMXCYjgjMomNvMApbcQUnnpICTMZERZkMQ65oywAi0USm6n9TlekVy0GdjuyE
 zNRQ==
X-Gm-Message-State: AOJu0Yz4z8xugX6RQobghCNMYWm6kykLLFZ1T28ZZYh1DQZ2PihgZn3Z
 Cxyag6tuLaE7qhLhmH2yFgmP7m70KqqbHZH854vWYm4rQ8itBT7MKnPo7FNyx5cX5eA=
X-Gm-Gg: ASbGncsVGNIlRb6KFRGNnN/6nMxGTrMXZj+WrwyQx9qfP/l9/7Eoo10ej2jB/hdqELX
 5oWjsofTKZIb7ebkDEt0YQaqltl5TDDsnCP+0V+xVTC5PJusA6HZy7ze4o9gsW1OGHmJQXAN8Pm
 Biz6ZJ1HyIRQgUatBc/8zoX6ITZ4afHldCokTNR3Su7J/UHmD8FdCdUy5YXzf3DUrhYHwYHMdcf
 InKxa4X6PSClb9ka5x1WnmSa7Ggutmooz/F+HvI6CG/9KTVsXLfcn8xI532OoxWJ9LkmWsSmqf2
 TAIAfpT2JKuPGKAkcUGjYKSmLTOpf4dd9xei5CUVFGIe8hsDFC/A3sOQevJ1R2t+jXkYjR9FKsl
 PfUF6TbIvEMuDZG4tZuI6bjksLAiop9Vw8tQar0bX1gW/JQyDKM9X5ufwnCYIf09JPA==
X-Google-Smtp-Source: AGHT+IHalif+aeEf0ZCJiSvWujzwKi74GkEB/ibKbW+UHqcYV+n1NitxWQyqKtzU7mGH0eGMrRBOMg==
X-Received: by 2002:a05:6000:402b:b0:3b7:dd87:d730 with SMTP id
 ffacd0b85a97d-3b900b5558cmr1707359f8f.52.1754650481179; 
 Fri, 08 Aug 2025 03:54:41 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4534b3sm29807430f8f.47.2025.08.08.03.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 03:54:40 -0700 (PDT)
Message-ID: <d480bd1f-535c-4001-b489-4a0d8b62a80b@linaro.org>
Date: Fri, 8 Aug 2025 12:54:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] multiboot: Fix the split lock
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20250808035027.2194673-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808035027.2194673-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 8/8/25 05:50, Xiaoyao Li wrote:
> While running the kvm-unit-tests on Intel platforms with "split lock
> disable" feature, every test triggers a kernel warning of
> 
>    x86/split lock detection: #AC: qemu-system-x86_64/373232 took a split_lock trap at address: 0x1e3
> 
> Hack KVM by exiting to QEMU on split lock #AC, we get
> 
> KVM: exception 17 exit (error code 0x0)
> EAX=00000001 EBX=00000000 ECX=00000014 EDX=0001fb80
> ESI=00000000 EDI=000000a8 EBP=00000000 ESP=00006f10
> EIP=000001e3 EFL=00010002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0900 00009000 0000ffff 00009300 DPL=0 DS16 [-WA]
> CS =c000 000c0000 0000ffff 00009b00 DPL=0 CS16 [-RA]
> SS =0000 00000000 0000ffff 00009300 DPL=0 DS16 [-WA]
> DS =c000 000c0000 0000ffff 00009300 DPL=0 DS16 [-WA]
> FS =0950 00009500 0000ffff 00009300 DPL=0 DS16 [-WA]
> GS =06f2 00006f20 0000ffff 00009300 DPL=0 DS16 [-WA]
> LDT=0000 00000000 0000ffff 00008200 DPL=0 LDT
> TR =0000 00000000 0000ffff 00008b00 DPL=0 TSS32-busy
> GDT=     000c02b4 00000027
> IDT=     00000000 000003ff
> CR0=00000011 CR2=00000000 CR3=00000000 CR4=00000000
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000000
> Code=89 16 08 00 65 66 0f 01 16 06 00 66 b8 01 00 00 00 0f 22 c0 <65> 66 ff 2e 00 00 b8 10 00 00 00 8e d0 8e d8 8e c0 8e e0 8e e8 66 b8 08 00 66 ba 10 05 66
> 
> And it matches with what disassembled from multiboo_dma.bin:
> 
>   #objdump -b binary -m i386 -D pc-bios/multiboot_dma.bin
> 
>    1d1:   08 00                   or     %al,(%eax)
>    1d3:   65 66 0f 01 16          lgdtw  %gs:(%esi)
>    1d8:   06                      push   %es
>    1d9:   00 66 b8                add    %ah,-0x48(%esi)
>    1dc:   01 00                   add    %eax,(%eax)
>    1de:   00 00                   add    %al,(%eax)
>    1e0:   0f 22 c0                mov    %eax,%cr0
>> 1e3:   65 66 ff 2e             ljmpw  *%gs:(%esi)
>    1e7:   00 00                   add    %al,(%eax)
>    1e9:   b8 10 00 00 00          mov    $0x10,%eax
>    1ee:   8e d0                   mov    %eax,%ss
>    1f0:   8e d8                   mov    %eax,%ds
>    1f2:   8e c0                   mov    %eax,%es
>    1f4:   8e e0                   mov    %eax,%fs
>    1f6:   8e e8                   mov    %eax,%gs
>    1f8:   66 b8 08 00             mov    $0x8,%ax
>    1fc:   66 ba 10 05             mov    $0x510,%dx
> 
> We can see that the instruction at 0x1e3 is a far jmp through the GDT.
> However, the GDT is not 8 byte aligned, the base is 0xc02b4.
> 
> Intel processors follow the LOCK semantics to set the accessed flag of the
> segment descriptor when loading a segment descriptor. If the the segment
> descriptor crosses two cache line, it causes split lock.
> 
> Fix it by aligning the GDT on 8 bytes, so that segment descriptor cannot
> span two cache lines.
> 

Cc: qemu-stable@nongnu.org
Fixes: f16408dfb0e ("Multiboot support")

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   pc-bios/multiboot_dma.bin     | Bin 1024 -> 1024 bytes
>   pc-bios/optionrom/multiboot.S |   2 +-
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


