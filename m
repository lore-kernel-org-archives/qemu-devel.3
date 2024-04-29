Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA205C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1YF3-0000Pa-2s; Mon, 29 Apr 2024 17:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1YF1-0000PD-GN
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:08:51 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1YEz-000873-HW
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:08:51 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5aa20adda1dso3291618eaf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714424928; x=1715029728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/3ma0wtM9dTeP/r4InGS7KO53E6Jd+7AdYqM+kx9p7k=;
 b=Hk6uM6/Y2Fc39UZJUPvQXaEL37wdDkK1i3HyPhqJrqEcfPq0IMEIEEcHhxo2xJbe/i
 R0hjCV+iY9IvBS11QHaY0owr5ecRyj8DJkR61FHbOA7XMC6ujJWLkv8vdhe3KAf3tXDS
 enLF+ONYNIVKWnz1NqWComIS5inu5LEy14E6KxGm5LyansF+AWWMmUQzmkpNnnZdcJ1i
 iyYDInR/uuMs17M0EMS+3sIAKromtMyMr6AtALpeyfMfQuJur4sHLmvPcPZHfOn7xXEc
 UM20l80jRKijEsfKl93W0bvsMV1RzVL9A6/z+iZ+V/6Gei02RYYUNkh3LZhntCOAVrC/
 P/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714424928; x=1715029728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/3ma0wtM9dTeP/r4InGS7KO53E6Jd+7AdYqM+kx9p7k=;
 b=bXaigfgcoSVm6iF6PmdWAnrghzi3SznE3X+C/UhdlGifLAbpDA1blPjdbP+SQdu5nk
 KiWawewNyVcJR/oIxHX8AtUDBnyS/vgSeATP42mpLVBjld7il4u38qK5w2cRnzwJHLdk
 TybfJBHcFCzQWDaNz2EJngOi8HyPz01YVzBTaR+hGHx07hyn3CZpZBarjIhfgmdXrIVl
 flPq5lTbNYCHosndNUsRxe4+U2cYGPBokBH9b0BswF7q+07uT4F8J6uU9LT7VX8PyEdm
 tXh4L3iLOe+v84NT1o+reETRFuCY0WSLy31aS86tw6IgAEpT2NmolLv9GZxwGNt0pjE0
 5qcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIRhkxCJ3LNNYhDn5cNkgR2SyTlVDXvz0v+aDl3dJ2rd0Hh8XsXLaS734MlM2ebOyfliqRZauGb0PAeePzdU8VpF8pWdw=
X-Gm-Message-State: AOJu0Yx23kgv8JKI0H08u7BA8EGi+66jo1TOV6Zj7u4HGQ7VerVx7PE+
 6BDeMLRl5D+1ZGfhe99dL8arsbJ8Uc0eRP3PBZm5t/bEohVs2A0MZtvaxUEOGlM=
X-Google-Smtp-Source: AGHT+IF4Zi2NUHpSoLo3esTW/fqAt2H46ee3J64cgVjzA3ijzAjortqgsDLNGmoN5+pMIAtHcJdrXQ==
X-Received: by 2002:a05:6870:5389:b0:22e:ca59:8faa with SMTP id
 h9-20020a056870538900b0022eca598faamr12370524oan.34.1714424927600; 
 Mon, 29 Apr 2024 14:08:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a634e03000000b005cd835182c5sm19564649pgb.79.2024.04.29.14.08.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 14:08:47 -0700 (PDT)
Message-ID: <39cb269b-5736-43c2-8087-797bfaefc51a@linaro.org>
Date: Mon, 29 Apr 2024 14:08:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/24] accel/tcg: Move icount fields from CPUState to TCG
 AccelCPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-25-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> Both @icount_budget and @icount_extra fields are specific
> to TCG accelerator, move them to its AccelCPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/vcpu-state.h           |  4 ++++
>   include/hw/core/cpu.h            |  3 ---
>   accel/tcg/cpu-exec.c             | 14 +++++++-------
>   accel/tcg/icount-common.c        |  7 ++++---
>   accel/tcg/tcg-accel-ops-icount.c | 14 +++++++-------
>   accel/tcg/tcg-accel-ops.c        |  1 +
>   hw/core/cpu-common.c             |  1 -
>   7 files changed, 23 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

