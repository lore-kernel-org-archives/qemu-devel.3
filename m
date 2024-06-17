Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F3EC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHFI-000685-VX; Mon, 17 Jun 2024 14:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJHFH-00067b-ET
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:38:23 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJHFF-0001il-QT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:38:23 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6e54287a719so3195026a12.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718649500; x=1719254300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZF2wT+bLesMcuyBU7zGwJGctxhs9psXI+trveO06lzs=;
 b=e6w62ar4zB7xmrtMnN5J64ho5B5dKWTwyzS9MP1q8hwVm9E9B50a3k10suoI9tJxsQ
 iTCbf52+v+2i2rpQn+OJJUYOZbDQsMaPA6iCBquD0XHDQ+BBS7zVEB3owz8q5PJTAu6b
 N9k8mAYcaEhbG4JPff/hicky5AZGQCssWSyk7wijqJuMCdHaLULbW1/cFx7+9mr87/VF
 xLBqSLI8mGb+P3qxtGBjsJ9nSPp9JS391r10h2trPEDV7+f9D4WnTjgEy/NdZ80Al6s/
 Qy6krChXl5K6fDzQ17Kz9ErKL4AfIUQXRw/UHK9RLbVI2H8F/hlVh6Gpilsr4o4xu0lg
 +p0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718649500; x=1719254300;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZF2wT+bLesMcuyBU7zGwJGctxhs9psXI+trveO06lzs=;
 b=Hi/+5NMtnn+SsgHSPWqa2P7FaqMa6D8G5iLJhkWOgtBdoWo51mSOoZSJ7miOVCQLSz
 ACZ/6q0nMq7oSaEqWTLOI1WvHTy7IKvOkJDkRbEUY7iy5im/0MXdbx0wKpsvLSYC7hXC
 aF4y3OKmBhWkWrGrNTXOZvjO3daFcMj2XIqT8M0e0t1harqgliuDI6Lx4ugNUWiecsew
 /WzQXs/ZvnyskCIYIxhOWf5HDxpkh6Ja6oMmGhsjElpLYfghUNAKY/mrxVc9QOAelVQU
 9YFLXOBkyxYvE5a/8KY4l9sY31fZCDjVXWtIMF0y5B2Oiq7hjc6nWZG/V2gc/azg6PV9
 mKag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPbp4zlxd1ck+FMkt03pXGHY/R5Zf081Uw4jHUNQhBPF28qsli5I3AUuJFtS7Swz4Z1Qe2fDILlps5bhIKctpfMLtWLso=
X-Gm-Message-State: AOJu0YxfjNz/RftBOB6BgtNqDf2bvzIM23oX0kx2lirAbAa7l2qi96BP
 oJkuhEx31E0Yd4IaXwLW/4qdoTHEQYaFYfzI+PX+ozdj+RyKgTgSRUOw3TiID2uK7IL3TNBBFrA
 R
X-Google-Smtp-Source: AGHT+IFeI23cxkZ18wEsQd01s0CCOrEghtbcIpjtBbGhSrr1Ohgfsacg2cBUJGc1TG5NGPfWm8wu4Q==
X-Received: by 2002:a17:90a:4b82:b0:2c4:dd4b:b5fd with SMTP id
 98e67ed59e1d1-2c4dd4bb718mr8716835a91.7.1718649499710; 
 Mon, 17 Jun 2024 11:38:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a769c8aesm11460058a91.39.2024.06.17.11.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 11:38:19 -0700 (PDT)
Message-ID: <92eb22b1-8511-4be2-a6d1-4812cf147f76@linaro.org>
Date: Mon, 17 Jun 2024 11:38:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/19] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240617040228.1878487-1-clg@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617040228.1878487-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/16/24 21:02, Cédric Le Goater wrote:
> The following changes since commit 05ad1440b8428b0ade9b8e5c01469adb8fbf83e3:
> 
>    Merge tag 'virtio-grants-v8-tag' ofhttps://gitlab.com/sstabellini/qemu  into staging (2024-06-15 20:13:06 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/  tags/pull-aspeed-20240617
> 
> for you to fetch changes up to 5f44521242d2fdfa190206a6be40577a58a71ef9:
> 
>    MAINTAINERS: Add reviewers for ASPEED BMCs (2024-06-16 21:08:54 +0200)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Add AST2700 support
> 
> Changes in v2:
> 
>    - Fixed class_size in TYPE_ASPEED_INTC definition
>    - Fixed spelling : Unhandeled -> Unhandled

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


