Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10694C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raWsj-0006kd-1E; Thu, 15 Feb 2024 03:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWse-0006jA-D0
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:14:04 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWsc-0001D8-Rk
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:14:04 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d7393de183so4428975ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707984841; x=1708589641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M8+1KDUdQjI8AZQHezHiYdY80ZYMz1qagwUuHIkMVsU=;
 b=uSC4BOHWnzrBLPxBUVN/mt8uTOHyZW7zNf+7Ybok4LACYeER9SaNM5uQQDlgziVU7h
 Q7oAsImdh24iudvpnljeKMec333w69Hd/M9FH6F6imzUmgKrryQkwDC1psHBxBIMzIYY
 pZ/mM4+pQghvFW2DocasuOjRZYceRy12eVFp1btrBIIqs1uv/wkoAqeieRY2z1XxNPV7
 gcooBHhjgg/furdAfWvmNKnWw6PzcVEYyjFR4xRdV66wwxNr6kxWNa4mfbx3eRDe9aNi
 75MUtDqQ6l6AYFS6r9Zs4m8mxc1Tt2LaJ8K3e3YVp+4jl4oomhSYJa+mPr3S8bs4WzK5
 /4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707984841; x=1708589641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M8+1KDUdQjI8AZQHezHiYdY80ZYMz1qagwUuHIkMVsU=;
 b=kIhSpHFLyZViRzlwhVcD0o6oxO7xjAz/7jgoJLvV14S+sJqrNHxl9ph4AF2XuHDuKq
 /LMBkA1Xo6oeRnUqYLo/wwUTlTFLyfjSvGfBKb8x743cxSeRPGo/0RKgEa08QYPIBOiq
 qHNxTBnd+hJAXTTOMA9v5jmlW0jmhcPBTcX26HvwEM/i6ft4oa45zogYlbNARFeM5qZy
 67m5BqU6McVFoS/1zjAWiBdnM8BvO4Ls74x0wNsFVTO+4FuvGKXlOJCGBUUzhntwu0TH
 M3Vi36Od831cRHLBwmdnTKthOavzUMAAMBqgyZvVok4kDKwjeAINpFzlSvQx+9BdgwqU
 d8zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVudkzuwVOHom0FUJw1d1f5R/MhPieofVO3lsTebYxue8yLoNWGGWE1EXH2XZ8/0H78iUpJKmMnD/hAh0dJzfXY+3Lcos=
X-Gm-Message-State: AOJu0YzSAGyvSqYDrh42/sm367WZvMTpTBYdqLmenRwexVzCE29OIcSn
 /ECIl17Kt/NT0gQ5SGKGuYI/+4vlLdxDpdu+LeJGzT3kE1Bun8NVLGGEkVXaNm8=
X-Google-Smtp-Source: AGHT+IE80SmbuZ7sUOrZsdJB+/qR1PMbFjvHoR/1XFTIy72W4PvoCiq+WWG3UmQr3YlvEiAaG05yDA==
X-Received: by 2002:a17:902:db06:b0:1d9:c86c:39c2 with SMTP id
 m6-20020a170902db0600b001d9c86c39c2mr1174510plx.14.1707984841276; 
 Thu, 15 Feb 2024 00:14:01 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 mp6-20020a170902fd0600b001d5f1005096sm697107plb.55.2024.02.15.00.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 00:14:00 -0800 (PST)
Message-ID: <af1e8f39-45e2-46cf-9430-2d443f45c2bd@linaro.org>
Date: Wed, 14 Feb 2024 22:13:57 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Remove mips_def_t::SAARP field
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20240215080629.51190-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215080629.51190-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/14/24 22:06, Philippe Mathieu-Daudé wrote:
> The SAARP field added in commit 5fb2dcd179 ("target/mips: Provide
> R/W access to SAARI and SAAR CP0 registers") has never been used,
> remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/internal.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

