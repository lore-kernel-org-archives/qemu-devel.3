Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94171CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoO23-0007U0-Lp; Tue, 19 Aug 2025 11:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uoO22-0007Te-8R
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:13:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uoO20-00053L-2w
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:13:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45a1b097037so30622435e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755616419; x=1756221219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KuVmvBFfEkT9bRVP6FipdMcC/Uw1Jo7F5/MCMJhl+hg=;
 b=qDp7X8BFIWGT+xHz8uzkcrkjw/UZYL2C3PRz6mImJaZ0dKRZx6LKz4u5KoiSd6Qunq
 3HFo1zG5xpT10cMlCCYV7G+FlDrjoqHBkDQ2fRkg+MO253QNszIcFNpLQXKFCT4icNF6
 iQrPhbO5vbo8fgZgvDNTYjLUfl53ctgoSTsg2ZzQAVXt7QnTmD9ofGPyGzGc2zvwGQNm
 NZh4tvujuRNxsvZYxwBA9AoNzN4arCJ4N97TBippcKKuhxr0eABqTF/VGw0EFjaQj3x0
 AAzfuSK6WWMcUO+vUaLFxN2fv4HdeNb4Dk+XLP6qJ2/Jcy/O/RkrhAe8hxScP47NmC4I
 sAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755616419; x=1756221219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KuVmvBFfEkT9bRVP6FipdMcC/Uw1Jo7F5/MCMJhl+hg=;
 b=wrdwmntjblTBlkYvi4WWCOivTuE4Fj+8mRZ06LZ1VnbTG/jisYpr99p5ciWQmQUQQA
 FVD+UjyPL4CxKbzJNisvyXf3fJlseBJcVnCJ3AEjqOooVMmzWHSavBXpHD3kc0fM9+zx
 saE6+f8oTOHe1BMHZ4uGEYdzWNPG9y0RaDpFAakQc83LZ4NyWabXwVRzpIHvIIJuoYoP
 PrzPkuPq1z+X3UReT3Q6FPTsEYzwQHX5iFeGEXmS+xx+LdLkdpVv0mwIcoCuvL76q7OX
 ihnAJBsE0HqCz2N19IPaeN7Ntg4whvfsdp180TZhybAVHKCL8vsigmea+Qe3PPxR03ol
 M2hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/uzjZl57oNbHbfoEsat0fHOkdX3CMOYp9ux7eSvvQ9Uzz99jTlL6p+5AoZkNyFiOW7nilO7kJQFYW@nongnu.org
X-Gm-Message-State: AOJu0YzAh6CDG62F6n4PWgSr4CM1egJ2RoplJ3G0cE/JSFI0VCBu5UUJ
 TYnsd5WKJMtujtbnfldraogjUG6gnkZLDIIGXx+Iw9WkgDzaDqlYXUA2ba0e9POibGE=
X-Gm-Gg: ASbGncsSG4xHVh442JO1wIoPggHSqGje9GzD7U7mw4s0YyhLeaDDLBe7BRc0Ja3SVQK
 2CsL0N3ijlPQmo5MTWjIUyu6oaRZzBNRwqfKbZTfFJNGmYyhs5WVtj0w321Fs3J2+bJOi0cMmqn
 9FtmPPG+XQ0g2JYFYwRILpQ8us20YwWdTItAqaajcemTHmUltCA9uGqjyrKp9oG3x2qQfOBQAcK
 2yeEiLwld/2ab08EcO4YBvHLPfLWM2ABEXlWh+JRrHnSQQbA8QJB28lKqzhoCuojScOLkueUrdj
 N5SlF5wFxaIe09XtGP9xx8A4YDs827UVfBqUFtXB7c1/n0VSmfK7GNGg6foNDJT73CrmPxuHNk9
 IUKhNfSsnolsSyCHnHcn5MnHr7LhG5UBqh3pc6nIdjJyyacwzJtyvlXQ5HfzzQhTWuLWU+Faz4B
 fa7KZkeQ==
X-Google-Smtp-Source: AGHT+IEPXFJpO8pKhRVv2vvmev05LD2F+VucQNoN7gMUAZ7McIkCmCGZS9nktvnsy9eCYbsfZHyhcA==
X-Received: by 2002:a05:600c:5249:b0:456:1bae:5470 with SMTP id
 5b1f17b1804b1-45b43dc14fdmr20036595e9.8.1755616419250; 
 Tue, 19 Aug 2025 08:13:39 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c6bd337sm219126345e9.4.2025.08.19.08.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 08:13:38 -0700 (PDT)
Message-ID: <17ff1493-c707-44e3-8f8b-ad20c51478ba@linaro.org>
Date: Tue, 19 Aug 2025 17:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt: Remove the lower bound of HighMem IO Regions
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Andrew Jones <ajones@ventanamicro.com>
References: <20250728-virt-v1-1-0ab9682262c8@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250728-virt-v1-1-0ab9682262c8@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Cc'ing Eric & Drew

On 28/7/25 08:51, Akihiko Odaki wrote:
> Remove the lower bound of the Highmem IO Regions' addresses for the
> latest machine version to increase the chance to fit the regions in the
> PA space.
> 
> The lower bound was especially problematic when using virt-install on
> Apple M2. virt-install 5.0.0 adds multiple pcie-root-port devices that
> require sufficient space in the ECAM region. However, the Highmem ECAM
> region did not fit in the limited PA space on the hardware, and the ECAM
> region size was limited to 16 MiB. If virt-install had added more than
> 16 devices to the root bridge, the region overflowed, which prevented
> edk2-stable202505 from scanning PCI devices, including the boot disk,
> causing boot failures.
> 
> Ideally, a virtual machine with more than 16 devices added to the root
> bridge should just work so that users and management layers do not have
> to care whether they use constrained hardware.
> 
> The base address of the Highmem IO Regions was fixed when commit
> f90747c4e8fb ("hw/arm/virt: GICv3 DT node with one or two redistributor
> regions") added the first Highmem IO Region. Later, commit 957e32cffa57
> ("hw/arm/virt: Dynamic memory map depending on RAM requirements")
> allowed moving the Highmem IO Regions to higher addresses to accommodate
> RAM more than 255 GiB, but the lower bound remained to keep the legacy
> memory map.
> 
> Remove the lower bound for the latest machine version to accommodate more
> devices with the root bridge. Keeping the lower bound for the old
> machine versions ensures the compatibility is still maintained.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   include/hw/arm/virt.h |  1 +
>   hw/arm/virt.c         | 16 ++++++++++++----
>   2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 9a1b0f53d218cb6157f65fdf79602e6c4da75809..b9d25799e099a037ffc18bbd2fc5f6bc1463bfcf 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -117,6 +117,7 @@ typedef enum VirtGICType {
>   
>   struct VirtMachineClass {
>       MachineClass parent;
> +    hwaddr min_highmem_base;
>       bool no_tcg_its;
>       bool no_highmem_compact;
>       bool no_ged;   /* Machines < 4.2 have no support for ACPI GED device */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9a6cd085a37a008179b967b036b0056b3c3eb7be..b1de97ef67ba415d873049c703e5b2c062afe17a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1833,6 +1833,7 @@ static void virt_set_high_memmap(VirtMachineState *vms,
>   static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>   {
>       MachineState *ms = MACHINE(vms);
> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>       hwaddr base, device_memory_base, device_memory_size, memtop;
>       int i;
>   
> @@ -1859,8 +1860,7 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>       /*
>        * We compute the base of the high IO region depending on the
>        * amount of initial and device memory. The device memory start/size
> -     * is aligned on 1GiB. We never put the high IO region below 256GiB
> -     * so that if maxram_size is < 255GiB we keep the legacy memory map.
> +     * is aligned on 1GiB.
>        * The device region size assumes 1GiB page max alignment per slot.
>        */
>       device_memory_base =
> @@ -1878,8 +1878,8 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>           error_report("maxmem/slots too huge");
>           exit(EXIT_FAILURE);
>       }
> -    if (base < vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
> -        base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
> +    if (base < vmc->min_highmem_base) {
> +        base = vmc->min_highmem_base;
>       }
>   
>       /* We know for sure that at least the memory fits in the PA space */
> @@ -3394,8 +3394,16 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
>   
>   static void virt_machine_10_0_options(MachineClass *mc)
>   {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>       virt_machine_10_1_options(mc);
>       compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
> +
> +    /*
> +     * Do not put the high IO region below 256GiB so that if maxram_size is
> +     * < 255GiB we keep the legacy memory map.
> +     */
> +    vmc->min_highmem_base = base_memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
>   }
>   DEFINE_VIRT_MACHINE(10, 0)
>   
> 
> ---
> base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
> change-id: 20250728-virt-833dafa6c11b
> 
> Best regards,


