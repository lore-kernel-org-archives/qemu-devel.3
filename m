Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FDCC48285
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 11:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTglE-0003Ch-RU; Sat, 27 Jan 2024 06:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTglD-0003BN-68
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 06:22:07 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTglA-0005ti-NG
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 06:22:06 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso13306285ad.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 03:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706354523; x=1706959323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PF/gob0gbW2N32hQ2Hs0VMP3zQT7ujQAPR6utAcyNr0=;
 b=dpTWycpnXB0+m4bo4+nYJoTwksaWf77oMXAuNPWN6Z+NO1xoTAEhjfA0CfJlq6pg6r
 Maf6LnzJrLSs5XrxeqYNG5+GBBfJ6JYSv7VheEczgjBbQuxRhv2pj3ujlR/yHGcDuvWr
 I6uRQmHepou5Ps9oFozLEzKFO3UBdzWOrlkMfHJkrbYzmDfZ+tj+DkGi3Y2S4oq4Znu0
 wGQwrw1mRwJg/4sD78xl6xpi3J/BrqJTGw954i5YcplmetRrvpf/4KKy0z9g8Xl4DksR
 AOjy4+ZUAtiQRs16QK63y22I1mkgwiyYMCH1j2zlAaZRFaX6xvFPqJtm5UMhpTdhpK/L
 99bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706354523; x=1706959323;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PF/gob0gbW2N32hQ2Hs0VMP3zQT7ujQAPR6utAcyNr0=;
 b=jK8mKGv7cKEWhfx7aZJ4adkJtZCTZFCpwXLORvj7TDFrQyIQxjp1L2hOsOmO9U1g9E
 X5S28xMShlwmQhtHehxBvu7fg8LyOFiZTc05ey5LAdpPgr8L25+PyiFZjiK6KOs+tD1R
 IgPUYZRp/nLsQWnRSJ/KnAnnBf/IWPYvl/RDHtEvlP9cigjMAaXXR+XhzMBDEVDxoY1m
 NzYIoicNtMj/UhhOxmQodjSBncCPr8T2FEfQQBBr/tGAuKet956mXdWZCc8PHP8P9Mmv
 S3jDVURXENu/beIdvuR+ApYCKdwRnGr/Cu5kI6Y50UpiFNl0XojaJPVOXbU5zFV4+y8I
 jmtQ==
X-Gm-Message-State: AOJu0Yyyt40kjwAH3MO6B7oXjtDH5hoy1YbGKjME9dK/YByyteacfPV9
 kCsIJzKCA2pOzvMyZjXHlivBNiuLQ862/yh7FYsLUGFRa+/k8sIxFOk1S9qriH8=
X-Google-Smtp-Source: AGHT+IE6ifY4f3iDDcgoF75Dw8Qad128QnuM1A9vkIYjO1yws1JNsfuLm32261x1b8M753wHPmfUfw==
X-Received: by 2002:a17:903:2793:b0:1d7:6ae4:c93b with SMTP id
 jw19-20020a170903279300b001d76ae4c93bmr1360262plb.78.1706354522933; 
 Sat, 27 Jan 2024 03:22:02 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:af6d:99b9:66ea:c79a?
 ([2001:8003:c96c:3c00:af6d:99b9:66ea:c79a])
 by smtp.gmail.com with ESMTPSA id
 sj10-20020a17090b2d8a00b0028e2a0d297csm2680828pjb.41.2024.01.27.03.22.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 03:22:02 -0800 (PST)
Message-ID: <2ddbae0a-c91f-4871-98e1-b9492a04de6d@linaro.org>
Date: Sat, 27 Jan 2024 21:21:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/34] target: Uninline cpu_get_tb_cpu_state()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-14-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-14-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> Required to compile accel/tcg/translate-all.c once for softmmu targets.
> The function gets quite big for some targets so uninlining makes sense.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---

Queued, thanks.


r~

