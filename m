Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696C7C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1pZo-0006i6-Qe; Tue, 30 Apr 2024 11:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1pZn-0006hO-84
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:39:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1pZl-0006aT-I6
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:39:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41a72f3a20dso41475255e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714491564; x=1715096364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ro5JFSGgzEkgdJg8C7TXv2B8QW+b5qGmICAHuqQZ8Uw=;
 b=Vki0DQs43DC5m9sBFac3QCOAQ7KwLHQzRLMI1M+AVvZysWjEqOiOIGKG1a+wKE99CX
 +4TTWqJ+1cvluLSfi39JTm7hJL79KImPlE1uHxm5fkGr4muGZXpdvxfhQvvo6y8z+RJI
 Lf04w8/aVneXHo6tDPdSiOr34D9A8OgRQM0fPkUN/p1NC1DKNqU+l9rzzvDpXr7H+Xsu
 Aq/TsdPUgSfcBzg9Ur+hi6lKiYRQtEdP2bfnXs9nDXziEBbHCfZhl+ndIqJoKP/FgG99
 WBPOYikRxLl7Guq+VU+VDlnFLF7NKWkDanS+ehaOFW8RjoN8+De654xcxOv2ZCX7wUc1
 4O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714491564; x=1715096364;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ro5JFSGgzEkgdJg8C7TXv2B8QW+b5qGmICAHuqQZ8Uw=;
 b=VKfOk/YHYZvgp4ORR4lnlHeEIz9pxUBQQgr102N/tdVnrSGkM+0PQbV80cIji6DOlJ
 OQ91DqpJdQKSKeROzdH5lbnhPg+DyqwbjnyLIlIjgKoC0U/4kO7RrXRYlP3bwlKqGj6L
 e++RdffAqPbAy0e+0fLcuGBZNqFTSUgHGOWB0b8ftyX1h5Dcitny96wIsrrFtCZXHSQb
 2imGCk4KcQxuFNOUwroslfaGHiVOkFXuSZGWfFY5pYTIVm+zbG0UZ0oUEBh/4DK/9K/k
 bqJr3KPz7LPmL2UlViLlUmJUx+LMHE/dSxSdzUHCOHrnIh8KfOFRIrtOfe9KsBdoUjJq
 wSjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXujYidKd97x1tv+IQyXK2nDyYrnx9Yfb1EKbz/Iy2hTVNfIzJIis4jhp2pJnRYEdUC+wAkpGyNfvHhgz25JE2SAod+vAo=
X-Gm-Message-State: AOJu0YyeLZKiPkRbup+m3oLWT0uT0sghUdPwvU9swr31XZ+GRMDRy0Wv
 EE7K0KZAvi4CjPdgTbBL+x0/mtqalq2i1HrfX5oyOREgI7alP1GCKYlAC6qxrFU=
X-Google-Smtp-Source: AGHT+IEKAVVjctccWEcnDHTddz7qyilitnzuf5BMCdj1KRvL4TNcwpi/W2TZa7BxE57KfrTvr8vRMA==
X-Received: by 2002:a05:600c:1ca2:b0:418:17e9:c23f with SMTP id
 k34-20020a05600c1ca200b0041817e9c23fmr10889732wms.31.1714491564000; 
 Tue, 30 Apr 2024 08:39:24 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 n26-20020a05600c3b9a00b0041bf87e702asm11441235wms.10.2024.04.30.08.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 08:39:23 -0700 (PDT)
Message-ID: <65316058-d2e1-4250-91e6-4da22c1279ed@linaro.org>
Date: Tue, 30 Apr 2024 17:39:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] hw/i386/pc_sysfw: Alias rather than copy isa-bios
 region
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240430150643.111976-1-shentey@gmail.com>
 <20240430150643.111976-7-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430150643.111976-7-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 30/4/24 17:06, Bernhard Beschow wrote:
> In the -bios case the "isa-bios" memory region is an alias to the BIOS mapped
> to the top of the 4G memory boundary. Do the same in the -pflash case, but only
> for new machine versions for migration compatibility. This establishes common
> behavior and makes pflash commands work in the "isa-bios" region which some
> real-world legacy bioses rely on.

Can you amend a diff of 'info mtree' here to see how the layout changes?

> Note that in the sev_enabled() case, the "isa-bios" memory region in the -pflash
> case will now also point to encrypted memory, just like it already does in the
> -bios case.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/pc.h | 1 +
>   hw/i386/pc.c         | 1 +
>   hw/i386/pc_piix.c    | 3 +++
>   hw/i386/pc_q35.c     | 2 ++
>   hw/i386/pc_sysfw.c   | 8 +++++++-
>   5 files changed, 14 insertions(+), 1 deletion(-)

I'm still not convinced we need a migration back compat for this...

> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 82d37cb376..ac88ad4eb9 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -135,6 +135,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
>                                   MemoryRegion *rom_memory)
>   {
>       X86MachineState *x86ms = X86_MACHINE(pcms);
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>       hwaddr total_size = 0;
>       int i;
>       BlockBackend *blk;
> @@ -184,7 +185,12 @@ static void pc_system_flash_map(PCMachineState *pcms,
>   
>           if (i == 0) {
>               flash_mem = pflash_cfi01_get_memory(system_flash);
> -            pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
> +            if (pcmc->isa_bios_alias) {
> +                x86_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem,
> +                                  true);
> +            } else {
> +                pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
> +            }
>   
>               /* Encrypt the pflash boot ROM */
>               if (sev_enabled()) {


