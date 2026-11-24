Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A414B606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MZz1z8h3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvWa-0000J1-0f; Tue, 24 Nov 2026 13:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVvWW-0000In-AZ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:45:49 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVvWU-0007gc-MD
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:45:48 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8c70c2ab5a2so1904758b3a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795545944; x=1796150744; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=APgroaMcorztWtl10r+Y1bMAwmnP4ZDUa9xvqCpXmMo=;
 b=MZz1z8h33Ahqwfo6BX74C6DAXIQXQEN0r+3qDMVGd4vhkFrUoR0AgdpqBda88nMCsX
 pCdc4V284o70ZtS+Jbq2qqbDyHXbgzzKmVLnrbBXBFa6MalqVnVjilhGvLhccah+stap
 UZKrsy/CYgwH9WXKbTgnfTLfNOVheM+OPi8q9ndkpJTjoQzQjVFUIxe6U3MjsvWCb9r7
 SwOMCG384YZ25mpg1sH6cmKtwUTh2j5CmXFvGttNB53ZDXfvVfb7UaFd4wW1r+1RvPym
 y+JbUKo3dduR8FBP00bOlX9roAGOpdutivhwjGHkhHNfQsD0KP2W5qmOpCfnwB30LvOg
 PJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795545944; x=1796150744;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=APgroaMcorztWtl10r+Y1bMAwmnP4ZDUa9xvqCpXmMo=;
 b=Km4JfirIrJl4rOCLjEOgxB7AQqF+jbyH5ZOVvk4HTOZRA01GdXCJIS2UEnw4PNE3Av
 waiYDfhCRHf++Ze2Z1XzyB1GW+k+5bSb2cq8QBNBzw9VRqX7vy0c4k9AZAkHbxdZdBYL
 qS/GMaHIklgbgzorMAySzLNQqO3Ze30fcLWk0Zp/6nCXVjOOZPGbBSSRJ/lNNakSpiie
 jcm0Cok25lPaIIU8z0xlN5KCu58JVjL02tB9+qL0nOnsWfz8Q56k+W9B34Owy7GkFfK7
 r0ug76pcEB8kIsy9P6NWVRHL7qijXa+/6A51CfOAOKniW9SIPcNyK5BKfwAoOr8dpnRA
 1Rsw==
X-Forwarded-Encrypted: i=1;
 AL+hErFleITWVc7uRkBaOOYyFZOKpcI3mA3Oy7o5khjZXW9KxrJiC2DI3tsWMkOwNsFjp7t+rhuW77EcyGT7@nongnu.org
X-Gm-Message-State: APuU4Z+1fGRf1hfBX2WJ/1oRrtK329FD/ON8DB15x/EIXQ3prKN88WhI
 LvqQyu18Y8jlkQjiFCmMoyliYD/xpogWFcNsn6Zu1gunwUoNsClNv6XCebuxWPguMOQ=
X-Gm-Gg: AZFdTZfGVn9rvNiZb5+QIGqAf+SlbUQd1CpFC5WB+ZcsP/eTc4HNCxcxzuGirKIPsUF
 J6CscRWOhUxfspZ/qqhwdnvQ6GQZcdNJl36fepn54w44idBOViKNjzLdPZWGkM6ePoGxk707+il
 VsWPdkp0lG9YuJG0V592tMGHSaFy5dO+5hYGaJw1PqNo8L9wiJQennZ9c8tWRoDdtyFIxNIQA5w
 Jh18Ze7Mxde+PF6e/9FaMhE3x7UZux+/PcJhUgxSVlC+rPzrvXhBJUF8uHAxOzWxYvvnexHpwGo
 13QsNz9Rc8btiNYkLE103w1+/8PPNaUD7VJPUXJVYgo/ylvnWVluY9WEgtrcR2/VWbdF9FN8v/o
 7T2nIBiwQkgdQ1l1n5yf3DY/h9jmaqN2unuHyRfBo7DwszerDnDxP0aSt8gD8G0ejPBUCHwNF5P
 1L/vuTk5XNZBW1lGrvCHkmYon/XGVRX/yZ0DLep7suvHoEzQqosrs5yhOlLk/rEfJLCZXAxS9ww
 Y+sjVtbOLXOvfczxvi+6c7t359sf6ao5PuUHToSfRxNEmxwpUVSOVyqnjhGFjXkxdM5HA9KD7Ep
 FE3j5yX2/Qk8oZbxj4SvS6ucpkExS27zs2byKvXbB9/W48OnYj3XD3dYyIqeSwHBNitns8gQkIL
 0OMhJhu+kCr2hQtc=
X-Received: by 2002:a05:6a20:6a04:b0:3fa:df2d:d3e2 with SMTP id
 adf61e73a8af0-4014c756bc9mr14626623637.16.1795545944462; 
 Tue, 24 Nov 2026 10:45:44 -0800 (PST)
Received: from ?IPV6:2607:fb90:ec1a:80da:bd6d:e606:6f80:51cd?
 ([2607:fb90:ec1a:80da:bd6d:e606:6f80:51cd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87285c272sm7776099b3a.19.2026.11.24.10.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 10:45:43 -0800 (PST)
Message-ID: <63bcc50e-a57e-4a5a-96c2-6f2a51818731@linaro.org>
Date: Tue, 24 Nov 2026 10:45:41 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20261124132904.138731-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261124132904.138731-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 05:28, Peter Maydell wrote:
> Hi; here's a target-arm pullreq for rc2. All bug fixes, mostly arm
> but a few in the net subsystem.
> 
> thanks
> -- PMM
> 
> The following changes since commit 2bfbe39d0fff8af881cffe2bab9b615e77807c35:
> 
>    gitlab-ci: Switch the msys2 job to use ucrt (2026-11-23 09:13:18 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261124
> 
> for you to fetch changes up to c020bf46966ae4dbbf82efbc4c5f3435a2fda42f:
> 
>    hw/intc/arm_gicv5: Fix value of the IRS_DEVARCH register (2026-11-24 12:55:53 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * net/checksum.c: Correct handling of IP header length
>   * net/checksum: Correct handling of checksums when IP options present
>   * hw/ssi/aspeed_smc: Correct minimum_version_id in vmstate
>   * hw/net/rtl8139: Limit DMA transfers to plain memory
>   * hw/arm/bcm2838: Route system timer interrupts to GIC
>   * hw/intc/arm_gicv3_cpuif: Don't count a virtual EOI in EOImode 1
>   * target/arm: Handle "PMU disabled" in migration validate functions
>   * hw/watchdog/wdt_imx2: Fix migration when pretimeout-support not enabled
>   * hw/intc/arm_gicv5: Fix value of the IRS_DEVARCH register

Applied, thanks.

r~

