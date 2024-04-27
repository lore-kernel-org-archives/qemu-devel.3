Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCDDC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 14:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0jL2-0000Xi-5Q; Sat, 27 Apr 2024 10:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s0jKt-0000Ra-KZ
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 10:47:34 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s0jKp-0008GC-6k
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 10:47:30 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ac16b59fbeso2689284a91.2
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714229244; x=1714834044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6wcbJVsApLjFvrfZlLIEnscXA61H/LQylnHzp959vKo=;
 b=Y5HZgU4sA/zjqpsAB3DxRLIjmp/xxad6nzY0c8nHBhWkwBIzk0yewFpM326TZ9m5fy
 VxNPeqH3kC6kAmirVagPg/19NR/aoxtLY38MXM6M6hXrhVSnmrwApVGiFrlqoS5gRzLc
 4UfvCG2hucuL6uOM07fIPGGKVKSWJJr6weMPNvwNajXm3/ahtsakhAAdLogjyfFIVdMR
 dDZj+UZYlt9ByMYHiWBHQynNZqBMyFO/19GPtqKyGVFACvkHS6BGOCgq3dT4ybDsWFxe
 bsM020t0QFzF7C4sxSRVMqM0lKHX8t+CUC6oObm5ZGuNXbTsiPi3R7ZhyvNxrYQzKU4k
 HDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714229244; x=1714834044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6wcbJVsApLjFvrfZlLIEnscXA61H/LQylnHzp959vKo=;
 b=H9J4K5WOzuEVygNMRm8ppTsNb9RCLwOe5iL+ENrZMnsEQHZqUXNmlUEagNVhtMYt1f
 X+r0odV0RpcTcRv8fZzhZlpfA3yTQFv3n0qTYoXx41DaShzp/fI0112webnVznqweTA6
 Y6ImmTl4BvGd8A/yYsb2Wnnad2NQOrhdiQrZtsurKmp+/XVKBlVZu2OcN5lO+kjsXZbc
 gjnJh4V1jQZts4MUO8NmmENP8BQV6bS0pgk6lCVXwtTHf+ABXA1/akV2jRC6348KPcNC
 j/pZng6iGczW13N8E2oZ3VHgR4jmKMuATswOLXz6cRBHS+qpbWfETujiJR6PVzg/nLZS
 /5fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNUyQLlhItwIF41BVJpn7n3FvcnqhVLwTSgf1f3cS+LnkjkukkM4hEXVidK0d0aifB5nwfBE5Rk+OGe65RIkUDl0GvIzI=
X-Gm-Message-State: AOJu0YxSWS2lB+XbVm900XnKr5CkYgseFcwwd1mPkiCaco4GOI+42Tw+
 4GJzSUfsAgUNIFHWiuLIZVNMtbqISapdiruKQ8pseVYJx6ImmuPIIKUcx2qqDqY=
X-Google-Smtp-Source: AGHT+IGwse8lYW9T2xG3kSIABHNFoEICjAUgoHEU4XFiqoEAlGWLOn3BoCGIWP5dUiE9RNhhzf9EQA==
X-Received: by 2002:a17:90a:d78b:b0:2ad:e004:76e6 with SMTP id
 z11-20020a17090ad78b00b002ade00476e6mr5231493pju.7.1714229244449; 
 Sat, 27 Apr 2024 07:47:24 -0700 (PDT)
Received: from [192.168.91.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a17090a938100b002a706910b05sm16194208pjo.9.2024.04.27.07.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Apr 2024 07:47:23 -0700 (PDT)
Message-ID: <040db071-6406-4270-969a-c98d6fb33caf@linaro.org>
Date: Sat, 27 Apr 2024 07:47:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/38] Exec / accelerators patches
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org
References: <20240426194200.43723-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 4/26/24 12:41, Philippe Mathieu-Daudé wrote:
> The following changes since commit a118c4aff4087eafb68f7132b233ad548cf16376:
> 
>    Merge tag 'hw-misc-20240425' ofhttps://github.com/philmd/qemu  into staging (2024-04-25 09:43:29 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/accel-20240426
> 
> for you to fetch changes up to 671558d290ffb93752d3245e7c5604b04b6dcdf2:
> 
>    plugins: Include missing 'qemu/bitmap.h' header (2024-04-26 21:36:19 +0200)
> 
> Selfish PR, painfully tested commit by commit.
> ----------------------------------------------------------------
> Accelerators patches
> 
> A lot of trivial cleanups and simplifications (moving methods around,
> adding/removing #include statements). Most notable changes:
> 
> - Rename NEED_CPU_H -> COMPILING_PER_TARGET
> - Rename few template headers using the '.h.inc' suffix
> - Extract some definitions / declarations into their own header:
>    - accel/tcg/user-retaddr.h (helper_retaddr)
>    - include/exec/abi_ptr.h (abi_ptr)
>    - include/exec/breakpoint.h (CPUBreakpoint, CPUWatchpoint)
>    - include/exec/mmu-access-type.h (MMUAccessType)
>    - include/user/tswap-target.h (tswapl, bswaptls)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


