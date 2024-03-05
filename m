Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDAFC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 20:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbgH-0007Xi-09; Tue, 05 Mar 2024 15:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhbgE-0007XV-26
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:46:30 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhbgC-000217-6d
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:46:29 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e5c0be115aso3110670b3a.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 12:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709671586; x=1710276386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rh7ImRCJ9sXBDVRNLKseuNzseOk7B+khv7+nBAQFxQo=;
 b=Zr8GcDqbxKR7c7xp/0JCAl8eXoPzaXloGn8SdbHNkWIgvL0AitmTTjdrpn6DlggW/E
 XolC9yBmGpUNRqH62/DMF5YxWVYle4CG5nuJMk7OnK+w7Nfx+dB+oQupRRntVDCOAGY7
 lzPYF5Z0iGCfEgzZVtH2ozmNUvgjjnN+ddI/v96eU5o8uJ3M6zC5cgYlK871ymhdL4fL
 uU2Y4Kp8ksQKXC0k30jr4E0vWFN8nHItwv4h6t4JHrNQj3+9eEQvhPu/n6f4MsTUpatF
 5TVe/qtNKa+gxdFEUJgeqgjQ6jvC8ATjl9j50SQyWM0QqCvBjGobhBnt+7mVRhyeU80B
 PfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709671586; x=1710276386;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rh7ImRCJ9sXBDVRNLKseuNzseOk7B+khv7+nBAQFxQo=;
 b=kM2rNERUQz+5F3+lHKud0B/mKtlXU77xCu4uJiPQpmi9DUATkx6xowyFVEp6CapNTe
 LowqfzfUO3Hu8aXEMiHAshJCzOT7/SeQ41X1Bcrc1DDQz5ChXN2R8UCNMIjFs0h93kZ0
 r26Xi9oDWe25ab3pgen8z5tyachpHW/DSUhCNPPermhnh0Gs3D4QsNZDXDrQveAhaig1
 /wJ7gLKjnRhbhyD+J41YCtDwA7C0NzXlbpZ2VcH1CbuAsx5u71yWVLekmgxzcHWKAKS/
 s2o3Bme7I7bfdN30++gO4zm4bTEtk00FoY+Q5LiCgvKHRrgM6O+cCAp86NEuAV4+XDxS
 o5Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaIv8hURsECP17ULBehFKiAHwPVlX9I55uWTpAC0bFDGsjeSLnhppPHCtuL6kFOPNvn2bhwSYW1Ep5AI7uGfM9x3P2Yaw=
X-Gm-Message-State: AOJu0Yxk91TO4q6AC4VaeOpxGvPNMvEBrlZMyx/2eB1NkOBKmVxBDtgi
 IzbWr6EIxChX0ak0I5LmIZiVHI9YDYJHxnhwoprVaFVxmbaiGUL2ayzx5c9vjcU=
X-Google-Smtp-Source: AGHT+IEaaf8zdGt1DsicyJlIF/SKQZQV3dlKJWPlxVNPp5rJwaaqOalmt/9l2TUZ08eBfAM3itdqZg==
X-Received: by 2002:a05:6a00:310f:b0:6e5:bdfb:bcd2 with SMTP id
 bi15-20020a056a00310f00b006e5bdfbbcd2mr10205592pfb.9.1709671586427; 
 Tue, 05 Mar 2024 12:46:26 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 q67-20020a634346000000b005dc49afed53sm9621106pga.55.2024.03.05.12.46.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 12:46:25 -0800 (PST)
Message-ID: <fb7d5ad6-f671-4b53-9ed9-512f03d637b2@linaro.org>
Date: Tue, 5 Mar 2024 10:46:23 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/29] disas: introduce show_opcodes
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
 <20240305121005.3528075-27-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305121005.3528075-27-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 3/5/24 02:10, Alex Bennée wrote:
> For plugins we don't expect the raw opcodes in the disassembly. We
> already deal with this by hand crafting our capstone call but for
> other diassemblers we need a flag. Introduce show_opcodes which
> defaults to off.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   include/disas/dis-asm.h | 8 ++++++++
>   disas/disas.c           | 1 +
>   2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

