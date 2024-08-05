Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594EDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 22:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb5kA-0002x5-Q1; Mon, 05 Aug 2024 17:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sb5k5-0002ug-Bx
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:59:49 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sb5k3-0006RF-KG
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:59:49 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7a18ba4143bso7558242a12.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722895185; x=1723499985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ze4f5WWRI0v4Ei0sg6/Kj76OA6a3KyEEqX7xYsmSIkc=;
 b=HzTQyHifu+TKmu1oTzQfrHmDJopFOx9u/957GrX1STCqRXR5bm2SD/baqRE+Z0z2pb
 M+FZP6GBLbIi0aHCiqXZ6KX3wMhmuJh/3GPY6JSv6bzuq2/ixUD8LjPDeT2gco8lZX29
 lixVeNK9kaXN/qUBRfHE0187LdQsdfLGPgvKwR3hfrrhNtiEsWxDpiIYRYmXULNsfQu0
 rwgqeJIauTtT8iQX4gYsMmc0WL4CHIXwIeUZ6eayRpH3KFh5aNd2CFTpjFjDy4ZNVb6Q
 U2zrgofcADvG+4EzGeG8JXDOTZ4wkpMHlGK+D8oGmowYLq6PwpChyfj8SvARrAcRr/BQ
 6qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722895185; x=1723499985;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ze4f5WWRI0v4Ei0sg6/Kj76OA6a3KyEEqX7xYsmSIkc=;
 b=Ab8iYBSsmPlaP6nwvOhJ9qZs55APOhrUh7RWVrmwTNHp1cugnBWhdKTfZXRPKrFUzF
 uKWZVN1Vx/pBBROdMGznlariH2Y30mfvP3tQC6lT8ATe1FxbLZA2jpJHfaiQKuj7ryA2
 OBlqZR77Y8HTa2mwUdxwStuWiqgKyGfcpOGhLrfGUftjUdKMs5NXzn9zwXLwLhpQabxl
 nnfWskvJlixFg0xYep0ssMi+a/yjSFeV49E335I1U/PbD30aA5iP3hCkZtQrcu6oyMoe
 6rTub12BDi0wHQmUZXvRm8uyxV/4E+qp4ddyETv3OszwcBrc76ewlWBp/i4PT60Tb3rA
 3ZPw==
X-Gm-Message-State: AOJu0YzsW3j/yP5FBquJw9z8M6288I/ZP0Pxvxu+rhGauarTsKwzs63w
 ITAOkkJtAs1PxzCu5voUis+LgDKcx4PUSNnfVF0iQGkEHCY8Q2D5p+gE2THoxuJ+n1syObQRPda
 3y0g=
X-Google-Smtp-Source: AGHT+IHjx9Xjh9u+T9f1BuKfWnEiLG7VFCqkYVzMNXd/lxSGLn8VqtEgqPchY4Z8w7Av97aBWvb/cg==
X-Received: by 2002:a17:90b:1e4c:b0:2c9:57a4:a8c4 with SMTP id
 98e67ed59e1d1-2cff955901dmr11095275a91.42.1722895184806; 
 Mon, 05 Aug 2024 14:59:44 -0700 (PDT)
Received: from [192.168.0.152] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cffaf69a1csm7572143a91.7.2024.08.05.14.59.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 14:59:44 -0700 (PDT)
Message-ID: <1943ce20-91a6-4942-9dd6-9d1024dc2728@linaro.org>
Date: Tue, 6 Aug 2024 07:59:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] misc patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240805003130.1421051-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240805003130.1421051-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/5/24 10:31, Richard Henderson wrote:
> The following changes since commit f9851d2ffef59b3a7f39513469263ab3b019480f:
> 
>    Merge tag 'migration-20240802-pull-request' ofhttps://gitlab.com/farosas/qemu into staging (2024-08-03 07:26:26 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240805
> 
> for you to fetch changes up to 9996a35c6433c0e019a1c05791299db5e63a5db7:
> 
>    net/tap: Use qemu_close_all_open_fd() (2024-08-05 08:33:36 +1000)
> 
> ----------------------------------------------------------------
> linux-user/elfload: Fix pr_pid values in core files
> util: Add qemu_close_all_open_fd
> net/tap: Use qemu_close_all_open_fd


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

