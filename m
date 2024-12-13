Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A21E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBBS-00058r-48; Fri, 13 Dec 2024 14:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMBAe-0004Sr-9R
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:17:52 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMBAc-0008DY-Bs
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:17:52 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43635796b48so1334745e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117467; x=1734722267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4/14a9mDGDa/KnxDonzGqm0gIlizPcSMWgu/6bMOP6I=;
 b=Rcyi9xcJODJP1n2PVW8zppmqOm4d3bffqobpz62vT8DajOP36IfTizOIcCK9x+9NHE
 +rX/KQtUkQZXLUzVeTaKtV2xmzC14CZILs+lk07tBTIV7qJV75IRa9gmCTFXZYlRoNVg
 fhdL9O/629W05bNN7g1MOC1F8IUx/KhkWxFYNHykH28S0PO/tvezUTfYzPm49PuH8TpH
 y/Nr/9a5Hd5lRBNzuyAkHC8+0NehNPwZi7jmd0vqprzaWX3GaPUU7G54fwSuJd7N4I5f
 noZ0zMwJhoBq7flEvaKUdFfmS0dVDLGN1GPqqevllnamozThDbVSR+8SWgBwOpD09Yiv
 CiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117467; x=1734722267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4/14a9mDGDa/KnxDonzGqm0gIlizPcSMWgu/6bMOP6I=;
 b=WvPWsHGQdioTzB2xlPtN2Fc1veCd26DuTLG9zGJnUbF59eGaB/+wAi8qzAT/g20mFg
 GRjfhNVvcv3qA8xNo1fXV0CwzTx1C61zS2sU8YRf3m0gq7Uu5gY++WSfVr6/VFxZi0Nr
 Wvpqs+xKx3pUHR0XNztfDAfC3LxV7kt4uLJtA5TX7oTF78CfE8FYFM+LHFxQuMbOnoiI
 Wsj0XEDraAguFT7qtDzHqQQPWbOhGUypWT1YMbKxKLgkfSxlQWsDib0kbdHPa/KjlrNr
 N+CzA7VjByMYzCLGrFYCHzPD4ZLoJ3nfI1b86Q/LMcUoS2dGhhBrp1gigopg4CqkKJwm
 MTDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqmwBBc3qGYG5hVOOK6QKR4NXyxI2eMcy88rC/c1YtH3oAoKlvCj/TGH5fOOV+rOjSXO4+n7heb4dX@nongnu.org
X-Gm-Message-State: AOJu0Yw7VIWfyea18dUQkqndGxYxbQ/vuHzuKiT1jxAiX9B5u5yDQDmQ
 trT6h3iI7i4iD+Oai8exJl9FmB4/0NZfdcfiogWxNLOqQdbFLNl3RPHuUvTmE/M=
X-Gm-Gg: ASbGncsYD9ZfiwkufpR0ZYwMq8T9t2Uh9M7tJdIVqlgtDXJw8IGpab570YHRqeq8C5u
 CrLiiauT5qfWXsUiN2o8pUJapNmV3KAV+lpC30d2j6Bs1Gg55E93QBJX7V1kBrcQpEUZNaJRQ9Q
 byjRcDVA6+AhVEPzJZ0YELeTNxk5QI0eYy3JTg//ZCw8JAnJGL/gHTAJAgu29HPgAgJ5Xf5Gp1Z
 HwGArVFOYmjfZR9y5g/C+ZPVtsJuBncM5hp5s/+KOm/eax6Mr16wskdg/OlI6j25ZSdNg/6H7Ew
 h7NCgxvsbuP0X/w2alkL
X-Google-Smtp-Source: AGHT+IGOZbdfit7LhxtPPj4XI6aO+PG6OBk7/M+KqWHI4gjcG0sRxCWVPGu9PbnUk3k/iiKS3d25bw==
X-Received: by 2002:a05:600c:1c19:b0:434:f2af:6e74 with SMTP id
 5b1f17b1804b1-4362b16beb1mr30547905e9.15.1734117466747; 
 Fri, 13 Dec 2024 11:17:46 -0800 (PST)
Received: from [192.168.224.213] (127.47.205.77.rev.sfr.net. [77.205.47.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436362c7d64sm2053645e9.36.2024.12.13.11.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 11:17:37 -0800 (PST)
Message-ID: <f8ebff35-907b-4e58-8729-ca5d7b8a06a5@linaro.org>
Date: Fri, 13 Dec 2024 20:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/arm_gicv3_its: Zero initialize local DTEntry etc
 structs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20241213182337.3343068-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241213182337.3343068-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 13/12/24 19:23, Peter Maydell wrote:
> In the GICv3 ITS model, we have a common coding pattern which has a
> local C struct like "DTEntry dte", which is a C representation of an
> in-guest-memory data structure, and we call a function such as
> get_dte() to read guest memory and fill in the C struct.  These
> functions to read in the struct sometimes have cases where they will
> leave early and not fill in the whole struct (for instance get_dte()
> will set "dte->valid = false" and nothing else for the case where it
> is passed an entry_addr implying that there is no L2 table entry for
> the DTE).  This then causes potential use of uninitialized memory
> later, for instance when we call a trace event which prints all the
> fields of the struct.  Sufficiently advanced compilers may produce
> -Wmaybe-uninitialized warnings about this, especially if LTO is
> enabled.
> 
> Rather than trying to carefully separate out these trace events into
> "only the 'valid' field is initialized" and "all fields can be
> printed", zero-init all the structs when we define them. None of
> these structs are large (the biggest is 24 bytes) and having
> consistent behaviour is less likely to be buggy.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2718
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv3_its.c | 44 ++++++++++++++++++++---------------------
>   1 file changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


