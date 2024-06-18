Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F62C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 20:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJf6E-0007o2-Tf; Tue, 18 Jun 2024 16:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJf6C-0007na-HO
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:06:36 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJf6A-000872-B5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:06:36 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7041e39a5beso4320486b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 13:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718741193; x=1719345993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dDEV0aYSFXNMMtEOhHGnn0qhgDtlZBAeoGokfxAO7BE=;
 b=vrPNO35ANwsg2uOH1xo95B8s3ihmGyKjpxfiBYuVmqyFD6YDieJAz0lAaRy/6Dber0
 M6OaD1ZOHQUXo0op6RiDELuHYqVh9m+2D73UYh/+p9fdyCARKQ/chjyjAcfDdjpuutlT
 nBJn0z3JzOnGfwCHMkQxhI4JOtekDsQL/3J5LJQTYNbGu61BeZLH7Z9oYYPXKmCkpNV1
 URx49Tdnr4lrjsg/nhsorbd2NNBUsUx2S/j0girIrjbPC2Z5y5Ufd4phP3+9tmtJXZzv
 IKuQMQ2rpXYigv413VxwBwmwGgsh/X1v53w4azXH0CqVv6BorSV2rjAIay+2euWEYV7A
 xUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718741193; x=1719345993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dDEV0aYSFXNMMtEOhHGnn0qhgDtlZBAeoGokfxAO7BE=;
 b=xSniLU4Fi06gUFORjABc88iFOpXAfWqCOMiP71AWtcRmUjsUJ0fsYmBoCFPBmoWpU8
 L6sTTAznuff/DNgRcDivr4kECuotDgmPEKaVj2NUhQSbHpB7vuKh6p7uRFK73ZMpfMGV
 07ho9VNJmsx/2A9vl12LvCv7zr17ouumf7hw4xZa6OEGlyNL3NwmUPPg1TCsuxmV0bhf
 C2Fx20ZwNI7itjXjwngQmVLgm4Sx2i2R5r7QJYCdFbSs3gIM6SYfx+sDr5bub6Bol3RQ
 61akVsMDHYnhfKJfiw6+Bux15FnBp8b5UeFcCALGiX34KFj4Qz4QpAGHq2xfxmVU3VUb
 176w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxHizYXJTSZM98CWKLcbLNX95zTyO2QH627ZZSRxb9GE/RbXfQY952lfDWcNhiekwiGnPgnFP3b6bVkI06oH3ZjwvboL4=
X-Gm-Message-State: AOJu0YyNMtcBeLjwc8R3eLkXybO+lyyB6ekaINCy6lneaMZBPGnldcwi
 fMMaYb1yHLAT7R8c4heb6WF/doZAULp8PzzQiJtuhldsG70XX1DEnCqnEP0PFDM=
X-Google-Smtp-Source: AGHT+IEdLHTm04anc/R0cWQMxc1NdF+Zm1ExGdJoofdVr/1i4LZu4jJ3Lt6XsXVPf5g9Wv+jnLimhA==
X-Received: by 2002:a05:6a00:18aa:b0:705:ddb0:5260 with SMTP id
 d2e1a72fcca58-70629b19fb0mr776500b3a.0.1718741192446; 
 Tue, 18 Jun 2024 13:06:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb3d1ccsm9316584b3a.125.2024.06.18.13.06.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 13:06:32 -0700 (PDT)
Message-ID: <5ae93d7c-0fd2-4ead-b903-6b5838e0c24b@linaro.org>
Date: Tue, 18 Jun 2024 13:06:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/76] Misc patches for 2024-06-18
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240618160039.36108-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/18/24 08:59, Philippe Mathieu-Daudé wrote:
> The following changes since commit 900536d3e97aed7fdd9cb4dadd3bf7023360e819:
> 
>    Merge tag 'dirtylimit-dirtyrate-pull-request-20240617' ofhttps://github.com/newfriday/qemu  into staging (2024-06-17 11:40:24 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/misc-20240618
> 
> for you to fetch changes up to 02ad1f5b04bf2941852f405c87535307365f7041:
> 
>    ui+display: rename is_buffer_shared() -> surface_is_allocated() (2024-06-18 17:54:40 +0200)
> 
> Spurious warning (3 times):
> 
>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
> Deliberately ignored in ui/ (also 3 times):
> 
>    WARNING: line over 80 characters
> 
> ----------------------------------------------------------------
> Misc patches queue
> 
> . Remove deprecated pc-i440fx-2.0 -> 2.3 machines (Phil)
> . Always use little endian audio format in virtio-snd (Phil)
> . Avoid using Monitor in INTERRUPT_STATS_PROVIDER::print_info (Phil)
> . Introduce x-query-interrupt-controllers QMP command (Phil)
> . Introduce pnv_chip_foreach_cpu() to remove one CPU_FOREACH use (Cédric)
> . Set arm_v7m_tcg_ops::cpu_exec_halt & mandate TCGCPUOps::cpu_exec_halt (Peter)
> . Constify few uses of IOMMUTLBEvent (Phil)
> . Wire loongson_ipi device to loongson3_virt/TCG (Jiaxun)
> . Fix inclusion of tracing headers on s390x/TCG (Phil)
> . Add few shortcuts missing to readline (Manos)
> . Update ui/display entries in MAINTAINERS (Gerd)
> . Use qemu_add_mouse_change_notifier on Cocoa (Akihiko)
> . Fix Standard VGA screen blanking and cleanups (Gerd)
> . Fix USB/MTP reported "free space" value (Fabio)

Fails testing:

https://gitlab.com/qemu-project/qemu/-/jobs/7129004955

qemu-system-tricore: ../accel/tcg/cpu-exec.c:1082: tcg_exec_realizefn: Assertion 
`cpu->cc->tcg_ops->cpu_exec_halt' failed.


r~

