Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D94C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM8OR-0001vg-MU; Tue, 25 Jun 2024 11:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sM8OQ-0001vY-L3
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:47:38 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sM8OO-0006W6-UK
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:47:38 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7178ba1c24bso2834422a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719330455; x=1719935255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=31gfp3WAV/v1/sFwjk5+ATitsFqS56qCwRW1EjUScPo=;
 b=oAeTjWl94GXvvFeaiy+bYcP/cRn/ZiRjrctrgsXO+jv2k5548lP5CxQwVb+3UxhriZ
 ib5WcDrCjaDG1NlS/VDCKPD/BBMOeyI0ThjNteeW5RZWY8AAAb2xRJviIHKy9U7W9g1E
 RJfgtnN87UZidDRSAtA/vfyZfP3UN7Uc3mToikZqJxn81I6uu8F0MDVuDzBz0/46ZZvy
 5Pbo5CL/DzBs4wfyNhTZX/NQlsiYO7mQn82VzqtPEMGJf0rwEmiE6NpuMGGUcFSyH0Y4
 Hi5EIS8Ibk8JksTLGb95gEDKbGWzWHFMBbU0Y21kHp/jjKivuzbGeHeJ/uwYHsd1ktQ9
 ZdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719330455; x=1719935255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=31gfp3WAV/v1/sFwjk5+ATitsFqS56qCwRW1EjUScPo=;
 b=ZcPK+13fGL3XwURYYgdGT8uVaGxn9Rd22/iR8X7g2xPP8HvDTn85xBwbe3kkXPLPNV
 YStAeUFnijf3o6+1x+nZQ3T+fFFpz7qWCRCAR/NDXA4khDJv4TfXZfvSraYO88H1pg8s
 Y8BnnCXh2YtFg9zKY0Tw4bbKeNee+MJJJixmTt4D60EaJbgidDbu9AepAMd3ADaKb5Z/
 3p9RGDpPWJOdzzyQhjPXiY1T+lPuYwzYTzRsWhzMAUjEWEBdgY6vLqdfiaHDeHmXQ6/r
 kckx4oHAUkpq/FTxE7bFxCZ7s/66d5CahyIdPJy3OOf0/y2TphBD3mcEG6kunOzi8ppI
 dRKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR8KwKGL0UifhI7jqbRF7fvl2idWvYKXQI6o+D9GrVd5TbHwV84FTv1Yq2PRd1QQZbvqiYTmug/0nZHMlOJkIM4vPCfGU=
X-Gm-Message-State: AOJu0Yw8gFgaHgnkLJ48VQmbwyuHBlOQD+rcEK+hk9hVFAG7iIzyL0KQ
 V6HAedkliSZ0CVWLQaijB586h/L9XJZkxmuiY0AEq+H8KY8zgC2vMkJigS6baXsn5uEQtHVNamz
 d
X-Google-Smtp-Source: AGHT+IF0a0Syin+EtxGJod+Aj3vvKfZZunoTGqfb+y6l0l72WYfxyIRk6sMSFcOTZggHulpWf5fDaA==
X-Received: by 2002:a05:6a20:858a:b0:1b7:bdb3:7bbd with SMTP id
 adf61e73a8af0-1bcf7e32114mr8902439637.7.1719330455042; 
 Tue, 25 Jun 2024 08:47:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7065129b9edsm8529327b3a.148.2024.06.25.08.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 08:47:34 -0700 (PDT)
Message-ID: <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org>
Date: Tue, 25 Jun 2024 08:47:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
References: <mvm8qytp828.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvm8qytp828.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 6/25/24 04:37, Andreas Schwab wrote:
> When running qemu-riscv64 on a riscv64 host executing a ET_EXEC riscv64
> binary it cannot allocate memory for the stack:
> 
> $ qemu-riscv64 -d page ./hello.riscv64
> host mmap_min_addr=0x10000
> Locating guest address space @ 0x3ee000
> page layout changed following mmap
> start            end              size             prot
> 0000000000010000-0000000000013000 0000000000003000 ---
> page layout changed following mmap
> start            end              size             prot
> 0000000000010000-0000000000011000 0000000000001000 r-x
> 0000000000011000-0000000000013000 0000000000002000 ---
> page layout changed following mmap
> start            end              size             prot
> 0000000000010000-0000000000011000 0000000000001000 r-x
> 0000000000011000-0000000000013000 0000000000002000 rw-
> mmap stack: Cannot allocate memory
> 
> The issue is that guest_base is non-zero, which turns the target_mmap
> call with zero base in setup_arg_pages into a host mmap call with
> non-zero base.  On other hosts like x86_64 or aarch64, guest_base
> remains zero and the issue does not occur.

You need to be more precise in your bug reports, because it works for me.
Everything non-PIE, statically linked:

./qemu-riscv64: ELF 64-bit LSB executable, UCB RISC-V, RVC, double-float ABI, version 1 
(SYSV), statically linked, BuildID[sha1]=92e2b4b9a2cbcc91ac029a49ec72eaefe5111f38, for 
GNU/Linux 4.15.0, with debug_info, not stripped

/home/rth/a.out: ELF 64-bit LSB executable, UCB RISC-V, RVC, double-float ABI, version 1 
(SYSV), statically linked, BuildID[sha1]=4c52c576a0452e97d9117b89dd317c88460b0768, for 
GNU/Linux 4.15.0, not stripped

$ ./qemu-riscv64 -d page ~/a.out
host mmap_min_addr=0x1000
Locating guest address space @ 0x3ff000
page layout changed following mmap
start            end              size             prot
0000000000010000-0000000000084000 0000000000074000 ---
...
end_code    0x0000000000078388
start_code  0x0000000000010000
start_data  0x00000000000795b0
end_data    0x000000000007e8a8
start_stack 0x0000003f812224a0
brk         0x0000000000084000
entry       0x000000000001041c
argv_start  0x0000003f812224a8
env_start   0x0000003f812224b8
auxv_start  0x0000003f81222570
...
Hello, World!


I don't doubt that you see a problem, but I need a reproducer, not a guess as to what the 
problem might be.  Certainly guest_base is *not* it.  One can always force the use of a 
non-zero base with -B or -R.


r~

