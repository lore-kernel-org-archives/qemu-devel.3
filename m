Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E62BC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiKN-00026h-5s; Mon, 08 Apr 2024 02:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiKL-00025z-Rm
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:17:57 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiKK-0007KM-A4
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:17:57 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a47385a4379so933146666b.0
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712557075; x=1713161875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zGYrNQCJFqg8tYtGpRnhZx4PA9z4hLrPFSSPf9gp9LU=;
 b=af0JUj5RQ1dyOr/rNJlBdR8LLxFUA9HIxsWuDKzyIZeavNOyccVE8SV0EBBi4LVaym
 UDg5/Dg1noSvnYdOn7gX+ZtlsUuXp1S+yk7ZDep01FZo5gefsbpvCJf665Shf2YNHuud
 c4pACVGn/84/Rif0La2vQsRh7SVdbmp+fBcj3gk8x9aiV5JAhDsjM+CbxdpYv9OG84aP
 rkMwyAeIvPxwtzcov5V8NnqjmISpnkPRLm5JMb2Ld11jrZIyK76FSiJ0mJHhC0NJoR/m
 AeRuMhxXtdNOilGVs/9t6XDEtqi1BMwySdh0zeTuMJacZaTNxgd+SN6qW8kRtfQM5qaP
 0YrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712557075; x=1713161875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zGYrNQCJFqg8tYtGpRnhZx4PA9z4hLrPFSSPf9gp9LU=;
 b=SolX+qMa6DhbaT4taFTAK7JGepG4JSGQQkq/kyRaRAIx+O3GA3mJzkVyroCtiuaakm
 WJHAnb92IFWsW890ab4v/BjNaKrT9vBWiJf437rAC5Lx+0VFuVf6xKgWpH4HW+0tln+I
 Uee9ESRavbB7lb7kVQ9dbjIneuPP6WWELFIsDgeeRDgnCF2WKfowetDIPvNEM77CmbuH
 bhRyncosbYvE9YQPgYff+TNLQYt9uQXz1nWtVubqAdNrXfN5Nc74k3rzdt3+yeyRT9uQ
 J3Dvet5jqjFLh16rFhRQ49cMU3j+8j+N6mm7c4ypq3ew9nUPe02SYGB/4Dunkh6UxWj2
 dh1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTho9Xwc9hZMqP94Ss4dDIwiIcETjmWmF+yj4hWsMs3pdOYRrezryDAPn9fzjT8wXGK9/Bup3uHtd9J05SGzyhwLHrrdw=
X-Gm-Message-State: AOJu0YzT44NZFyz+5EdqnLV+7d2q2UXlFHyODX6WhhUm4kDSHAD8Sfca
 Hr/WrPmimwwBtGmhmy+iMHDIBMwZdDO89qWxpAeDETtRuFHdIWATkZ/h+W79MtY=
X-Google-Smtp-Source: AGHT+IFDcYRnyQ0SfHRLka7x0ISHnmyr54p4U2S9AGhaCqMd3jyH9c5jJ6cfzGcY+YD1M2xNvyoAFw==
X-Received: by 2002:a17:907:971f:b0:a51:affc:ad66 with SMTP id
 jg31-20020a170907971f00b00a51affcad66mr7355107ejc.12.1712557074966; 
 Sun, 07 Apr 2024 23:17:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 h22-20020a1709067cd600b00a4739efd7cesm4033053ejp.60.2024.04.07.23.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 23:17:54 -0700 (PDT)
Message-ID: <4a2e59bc-5061-46f5-aac0-791d87ab5259@linaro.org>
Date: Mon, 8 Apr 2024 08:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/riscv: Use insn_start from DisasContextBase
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 7/4/24 00:32, Richard Henderson wrote:
> To keep the multiple update check, replace insn_start
> with insn_start_updated.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/translate.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


