Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB9AD4920A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCzHX-0007Oo-39; Mon, 18 Nov 2024 05:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tCzHU-0007OB-LA
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:46:57 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tCzHT-0003Y5-5u
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:46:56 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cfc19065ffso1361672a12.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731926813; x=1732531613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iAnf8ZSAxSU1u3Z5PVmcw4Q59w1jFgLVgeRKEbH4LKc=;
 b=JiAXwnK5m5GEG+KqW1Y/696a9F7q9ybUjoLqoh4ohYWlzTrVKX6X+48QYDjcOJUpte
 0N9yX8zwuqu1kOK6QfllVGe6eEB1b5yYRfyobW6ytZE7Jd/fMNZrLq0RJ823z6XV+CG0
 HxPakU57zDPVPtRfipKuo1LHEKTiDRzMNxlk2KqIN0B0Qqv+xPAXo5RNhCfRsOp13Vfd
 dcX6gPojmtAGnEPkYG8MGrLxbz9ladjepKnXHaQDFftO0ssLCwie7DMuCLU8FOBKuvvP
 bvrcSpWlzEcz3T+sXgpaMh82beeCCOKYY9/pUi3zStF8mLmIncucziq7jyN9/4NWLxG2
 6PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731926813; x=1732531613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iAnf8ZSAxSU1u3Z5PVmcw4Q59w1jFgLVgeRKEbH4LKc=;
 b=tEPwWnTiMzbYkULRNByFuk/M5SX16kmshywB9VOiagWJ2cSdpC4RKTBL4gbw/4Z9wW
 qROM5ygexYZysLTFPs72dlfSG2EAg8mFVeiDt/GzzsZ09BVk2qsAOXq2rpitSNIKdlkd
 e3TcH7KqgQmaYshH/ohfI2oIjIlbHmLeQNF6Ml+8z8hJhMTSWXxNDPhI69hN0qyArjaw
 bRSf8WT5QOfScDOD84qL/thbGueyfwNlmSt2HvJViUJd5/wEm7qgvhQUYc1rO4DR7HOj
 lIhxACMse/O0+/LxpqpEotTRR/n5icZ1zBa874k2PntP/5HkDY4A5YwomSOqozCk50sS
 PXLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBQ3ydlUwUl7X9lvHpmIGX1NtKr4W5To9YwsTcqWeg6i9Q3UKG9GcD0nh7rCNpdtRy8c46BzAT+HH5@nongnu.org
X-Gm-Message-State: AOJu0Yyiwy4gSlZuNMreWBnFPLogHn+pR5b7zHUM9jV7NZlfd8Fayuhx
 DsoItWwrA0zDseHIPRjHcX3Y9jxbxlalo9PLFNm6i8fImM3TSdV4C1liSDiCUeY=
X-Google-Smtp-Source: AGHT+IHie3jLerrHDU6EuWlB0FJNlsUaRv6Y+GSWxUkqUQT/SHblGEVUkCIuNktgugg8ofBUMHs+zA==
X-Received: by 2002:a05:6402:440b:b0:5cf:3d11:c798 with SMTP id
 4fb4d7f45d1cf-5cf8fd10554mr9765358a12.28.1731926813071; 
 Mon, 18 Nov 2024 02:46:53 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cfc2677c5csm1167202a12.72.2024.11.18.02.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 02:46:52 -0800 (PST)
Message-ID: <51b12b06-1fac-45c9-bacd-094045d02c97@linaro.org>
Date: Mon, 18 Nov 2024 11:46:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: aspeed: Reorganize the "Boot options" section
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Guenter Roeck <linux@roeck-us.net>
References: <20241118090648.187720-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241118090648.187720-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 18/11/24 09:06, Cédric Le Goater wrote:
> Add subsubsections for possible boot methods and introduce a new
> section on eMMC boot support for the ast2600-evb and rainier-emmc
> machines, boot partitions assumptions and limitations.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   docs/system/arm/aspeed.rst | 99 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 86 insertions(+), 13 deletions(-)

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


