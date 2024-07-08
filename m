Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F50C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqyP-0001po-IF; Mon, 08 Jul 2024 12:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQqyO-0001kU-8q
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:12:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQqyM-00018E-FW
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:12:15 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fb1ff21748so19668345ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720455133; x=1721059933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e2VMMjDVgOinS8lmGevLWohwOG/rRPr6wjs69ixbMjc=;
 b=FdF/QRWyuWM8a2m8ZeG473i+kfpZnRLUEGIe9TmkhBwiaU/OxTZ7MbSAJijdz9uB4t
 oGexdDHN0lHFCswXiChJTZn3Cfp2CgR4HiSSBvPAsCKOs/gQLVmJIQkyUoY1xklCXbTO
 DagmhM95NxYyZ4+44Szg70Z+xJXlqSIOIOJJzxObDQrqREdQbpAa6AtkUS/OGXrun1R/
 0xQBxluP/axLn2s/AznHWoU7GRKZXxXLLHtrj9oHGjEdf5YdsktAsjuSWU0LMMRXVffS
 t0Cq9/Sn4eWELDK7zV9iOrUOmzabC8HbGL81Ul2fGzBhFbn4o8HKOEsSH1VxeGlkXQDV
 zibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720455133; x=1721059933;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e2VMMjDVgOinS8lmGevLWohwOG/rRPr6wjs69ixbMjc=;
 b=rl83gL1QcYJUKsu5mc7Z5JBOOO+yltsoRnfvHGPyE7Q0EXQUMrOaBP4hA33vrvtTvx
 HlFnAS5dtuj6n4xj2/0LjkM1VcIcIP6NHLMQ0g7QT6XxNMjSK00Qv+2W7AphPzvOiRh+
 jWpz44guknPBbQ8mFmoJub4M33zqcQO8dUZeOdsJ0skllr8OOIKXafty+dEv6BnATLtH
 i6vsauTS8AZsjxRb0/BVFaoujdPkKHzk6IbLxozw0pnG54UKGCc3S46zDT5gcIosCxfD
 lHQpDqRl41qoTZznEtVzNssMuiRbaIdvWmZSet1ZqGm+pkx50fWp7u5FQ7lTazfmkE+r
 AuQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgB00dQl6LxGT2vji98zwBLYNG3KNpneDgMvWAjTxhBgQvkiXgsYRAJ8NBYhZQoY3aBvPT4ZLRk/sSho0lG/GFbsd131U=
X-Gm-Message-State: AOJu0YzcE66BjDbk3OVZ66J1zjHtfDKgAzrxClTuSSnAU9KeawtdUr0u
 I7/5Fv2SkD20GfJ6PyT2/CcImcP3jADSqFPqZoha/i0DAcuTniCXuLyZVCJtnZA=
X-Google-Smtp-Source: AGHT+IEJnUjFHy1Vo91cGIxMXju+jjGG86cPGZ0fZREBiJYjc4FnSXCPGc9UoHYchjekH64VfCAJ0Q==
X-Received: by 2002:a17:902:c403:b0:1f9:c508:acd5 with SMTP id
 d9443c01a7336-1fb33e14fcdmr70137285ad.5.1720455132900; 
 Mon, 08 Jul 2024 09:12:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6acf63fsm349365ad.268.2024.07.08.09.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 09:12:12 -0700 (PDT)
Message-ID: <2a800fc9-ab30-409c-9f78-85a5cf26820d@linaro.org>
Date: Mon, 8 Jul 2024 09:12:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] bsd-user:Add AArch64 improvements and signal
 handling functions
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240707191128.10509-1-itachis@FreeBSD.org>
 <20240707191128.10509-9-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240707191128.10509-9-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 7/7/24 12:11, Ajeet Singh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Added get_ucontext_sigreturn function to check processor state ensuring current execution mode is EL0 and no flags
> indicating interrupts or exceptions are set.
> Updated AArch64 code to use CF directly without reading/writing the entire processor state, improving efficiency.
> Changed FP data structures to use Int128 instead of __uint128_t, leveraging QEMU's generic mechanism for referencing this type.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/aarch64/signal.c             | 20 +++++++++++++++++++-
>   bsd-user/aarch64/target_arch_cpu.h    |  7 ++-----
>   bsd-user/aarch64/target_arch_reg.h    |  2 +-
>   bsd-user/aarch64/target_arch_signal.h |  2 +-
>   bsd-user/qemu.h                       |  3 +++
>   5 files changed, 26 insertions(+), 8 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

