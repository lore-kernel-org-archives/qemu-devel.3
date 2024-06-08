Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED93C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG2Wr-0007tW-OS; Sat, 08 Jun 2024 16:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2Wp-0007st-JT
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:19:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2Wn-00063i-Gn
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:19:07 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70255d5ddc7so2662590b3a.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717877944; x=1718482744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d2TiceYzWFxsgprbHVhAhRrL5WBgg+1v6FRI6hMkfuA=;
 b=FdHDfV9eWWSHAF7y/sjQYJPy7m9/zHRzy/KT+RcaryUuvYapIPWQWcxhbZaa9eB/NM
 I/iz9pvN2/wmppuFIuham+AlsJ2tl7BNh+Bf03ZcgBBRDvLkuGQeEVDI0TgSbwUVdJWD
 /t+6I8XNG91LBVH56Pak3Op0ody7TcB3O1r+wbGq3i5H3+w+WX25QYKwsRyfUO7PvcDV
 YSw9HFJ8Wb4oGbvvRO4bemekBizziaQ2CXcyGau8zDnciEgMset/qVfmoEzmk0zoxVlc
 WsPJfj/SNkbWft/EnRM5natlPmLnNzuzhwn480KjlY1qW7Ddx177ZeaRFwG56NElGZgP
 xEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717877944; x=1718482744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d2TiceYzWFxsgprbHVhAhRrL5WBgg+1v6FRI6hMkfuA=;
 b=dPBxh5iqa74xVdOMX3Nwlqt1ouihyEiyWXnGLFhil7QeaE8IGxKqC2nnQvCP8OLA7Z
 t2VO+OrcqBB8+oHQ4wnDSCNHAC4m4lbeUA4OuwTDCGzHdyqgYjLpVcryFj6Dj6EDk4S/
 Y7Xhj4nyM4saHUBfQCfIodtGY+4CcXpGG7aC5SRfKwx9NuS/RbX+g8p2e4LUihadvvwA
 GUsiSgJ/vrEuhswezUcufVmT9jvK0sYDnqmDwJzxBre75rnhGjuL3fNb6YZRueAKSoPv
 4ZMcThemEvXGvMmfz9XAdS/OqdymBFEX7aJDgNBh5TERFWqIXncbSsVW9f2criSoFq0x
 fRVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXavBiEjTDHXw66FynH+BittAQQ3SqCp/ZlrxiPSxYvhBLAxK6wo7dSBr9reZEoiQUQOvYrp39u0h1BR/t4ATLSI+8YA8Q=
X-Gm-Message-State: AOJu0YyCh8G4hobxpXzbBXvsyIQ1Cr/Pgt9nLYjzJTvxGFhIMbwVkqdm
 1tznXwJG2s17T/1QiGX/DXBsWy99Zr7S50/P9MIIYVvnBm3ivJchCOL/DPiZm0PQ1jl0cPYXEAq
 T
X-Google-Smtp-Source: AGHT+IGLzJVis+tdtI5mUMf8DLd6s2T2OvyBTC7rAgS3pY2Xz9Sb4BNQ5I9Jt+yISyHLY/ktc7ZlKQ==
X-Received: by 2002:a05:6a21:3398:b0:1b0:1ce1:e7ac with SMTP id
 adf61e73a8af0-1b2f9cbd7d3mr6548690637.53.1717877943599; 
 Sat, 08 Jun 2024 13:19:03 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7041f2fe912sm1867314b3a.212.2024.06.08.13.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 13:19:03 -0700 (PDT)
Message-ID: <be32f958-39ab-4c40-b81e-074f034229e1@linaro.org>
Date: Sat, 8 Jun 2024 13:19:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/42] i386, scsi. hostmem fixes for 2024-06-08
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608083415.2769160-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/8/24 01:33, Paolo Bonzini wrote:
> The following changes since commit f1572ab94738bd5787b7badcd4bd93a3657f0680:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2024-06-05 07:45:23 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to fc00123f3abeb027cd51eb58ea8845377794b3bc:
> 
>    python: mkvenv: remove ensure command (2024-06-08 10:33:39 +0200)
> 
> ----------------------------------------------------------------
> * scsi-disk: Don't silently truncate serial number
> * backends/hostmem: Report error on unavailable qemu_madvise() features or unaligned memory sizes
> * target/i386: fixes and documentation for INHIBIT_IRQ/TF/RF and debugging
> * i386/hvf: Adds support for INVTSC cpuid bit
> * i386/hvf: Fixes for dirty memory tracking
> * i386/hvf: Use hv_vcpu_interrupt() and hv_vcpu_run_until()
> * hvf: Cleanups
> * stubs: fixes for --disable-system build
> * i386/kvm: support for FRED
> * i386/kvm: fix MCE handling on AMD hosts

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


