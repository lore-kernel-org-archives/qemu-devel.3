Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30199C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRuTg-0003ht-MI; Thu, 11 Jul 2024 10:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRuTe-0003gm-4r
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:08:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRuTT-0001RB-06
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:08:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so7175525e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720706920; x=1721311720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e8bJ7MWKgdknqEJSg3JeWmibKxAGZJdlzW4ynd493gw=;
 b=tFgF58TwnEoN9S1jPo5Kl3YKwEL7YFyWUinFpTOv2j1rPkCZPHIonbohrZ0vUmZ868
 VMlcMZkcTgYL2ha1nqWmCMHw6kKc8R8nd7EfT0UHMBaf1d/xrsajBOgqR8JgmMRPS7by
 SCZ4vdyytYkJ0ymoBJUIP+k0DVV0C9p0tw+2iY9B3C2QHFsyhwfhpftXc+nG22k6hmXs
 K/cQhnQA8PEkK8sR/JEVp89t4hHYBSOVEAms7HXdsqCVh/lp1/RTj7UBFlCnJ+wzvG3q
 8f7XN4+2uH4pOIyfJldbpHxq6Vm8mKqx+E55yYnYV/oB9c3IQ+pGIBGlBMQzNd4k/XZl
 2cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720706920; x=1721311720;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e8bJ7MWKgdknqEJSg3JeWmibKxAGZJdlzW4ynd493gw=;
 b=m/BTojdlEFLNIGIlt1jz0JtwuVJ0yw2uTwRP5CBWxTVr0E46WCihF6TuCBIfto39bY
 4OnsEiMAtZeab3IzotqSZJyeNUPYCScV8y/vOYXNZI3+Yr4VQgUfLJqpsx+/Fuykoii7
 nON/N67thl9I4Z5CbJ/97CaIr9NU8KqWEcnEkUZuLlH+PSmIfhcuaKCp3RFzOrWLX5X2
 u0HKyf9sxWSOea0GceYGBrT2wQ2+x7Kt012w7T62KfUUQYSFAOPx5L493NYW6qermipt
 gGDQ97MDdSDmbXq0wHC2GRw3CmdovA4rVWFVTN3kI3tRaSU+6HwMLZeR+iPE5CEcKFNP
 U76w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/qw7KJYQebRU20MfzKyJ89zynAWeFCfklH9WXXjMuUHkce9A/jrB/uFshP1nazX1Y4Ttko7/wOP7fhlnvZGWE/P7bjuU=
X-Gm-Message-State: AOJu0Yx3g6GryNFWVbMAHK3q1d+yw+ZdJWmDTccdONRbbHeDDztwBSGz
 bevZApm5aI8tNXxRHWVqrAdKuY2LOeVsLm28QkaqJoRcZ1qVA5Avow8RjbcL3cA=
X-Google-Smtp-Source: AGHT+IFp3cp+6QTnt6Ys9KQjQYIr4izObqhM/PV8J1iFBey2CAk8GFnUj6u+ODDa++g7gFIEuzDRdw==
X-Received: by 2002:a05:600c:2152:b0:426:6f0f:2b21 with SMTP id
 5b1f17b1804b1-426707f892emr69040725e9.31.1720706920067; 
 Thu, 11 Jul 2024 07:08:40 -0700 (PDT)
Received: from [192.168.123.175] (212.red-88-29-184.dynamicip.rima-tde.net.
 [88.29.184.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279731a60dsm45896105e9.40.2024.07.11.07.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 07:08:39 -0700 (PDT)
Message-ID: <4252f0b9-8e5c-4f85-bb87-c8824e426037@linaro.org>
Date: Thu, 11 Jul 2024 16:08:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v48 00/12] hw/sd/sdcard: Add eMMC support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
References: <20240710141408.69275-1-philmd@linaro.org>
 <53939fdf-4361-47b1-a6a5-edd52ebf2100@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <53939fdf-4361-47b1-a6a5-edd52ebf2100@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/7/24 13:03, Cédric Le Goater wrote:
> Hello,
> 
> On 7/10/24 4:13 PM, Philippe Mathieu-Daudé wrote:
>> Tag to test Aspeed tree:
>>    https://gitlab.com/philmd/qemu/-/tags/aspeed_emmc-v8
> 
> I gave this branch a try and the rainier machine boots correctly with
> a baked emmc image :
> 
>    Tested-by: Cédric Le Goater <clg@redhat.com>
> 
> However, I am seeing a *lot* of printf messages :
> 
>    sd_blk_read: read error on host side
>    sd_blk_write: write error on host side

Ah, I noticed that too but thought it was trace events, not
fprintf.

> which were introduced by the initial implementation a1bb27b1e98a. This
> doesn't occur with my tree though.

I'll have a look (my first thought was latent issue exposed).

Thanks!

Phil.


