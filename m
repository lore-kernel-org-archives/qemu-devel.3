Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D16C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 02:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzpB6-0004FK-MJ; Wed, 24 Apr 2024 22:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzpB4-0004F1-RG
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:49:38 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzpB2-0000Yk-Ui
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:49:38 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so407197a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 19:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714013375; x=1714618175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CYVAbqWQ1mVQ1182kIcxPqBvIkkQsvacNoipNfVztA0=;
 b=v9gjsRXpXJPNq54QmzXcOeLc1nOBlVNUzy8VZQHmM8whG4u/AZDc3d3BECr00dMXfw
 wQZKUq1TIa/qw1EXCETb+nJgq9MlyNlkbNYPtMFbDBIdBkTbTezBZ3ZuuCJvPgzGcRdh
 T1wKUV3aq1tFqu8DREyuwhefnMzA4FsNxVqv8gokULdI/0l0lECgHN0QV00V+AKPrGgl
 m5TyKb84UOVENTGvmwwdrkyLj772Bt3ohsAc/qS+6jFg9AnqFw/j2oiO5XpTafntlVUL
 xzSh/Lbu/oBA62n4lRhI4sluZ+5NyLRHmzragplBqsVumDlXyLsVudPXYqls4vgBJEpg
 4MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714013375; x=1714618175;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CYVAbqWQ1mVQ1182kIcxPqBvIkkQsvacNoipNfVztA0=;
 b=M8/x4HZE5/hE7nHSJehEk4cWeq0b8tA/PiL1SX3/7dLHwqM0acxmr0uiiZYWjbBbqo
 pGk0EVOEb2TioH805UYy8Z2B1Z99r7x8N41fvVFVM4yl4MXbFCR3OW7YGEgd4eg2xfbO
 9lSRMtNFgijS4lHkX8pZ5SW1G8zz7CmvML0mOOb5U2NPWi4qvmSXJvI1GWWQ/qFeNLkK
 jb40YDWg4CdJe9S9Bk5WAX+/AJDaQC4UhzpqZet6SfIiiiW1km0EFX7+9NGZxKY0tv6A
 lM6hgFb6X5zD6UCy0xiwTNBUKmI/3DP1d92yZzhwXMOQf3vbHZsDY3HQz/8O0FEyowA3
 J1Tg==
X-Gm-Message-State: AOJu0YxaMycsSzvJmTf0nB392v4ynXWEGllfvvYk4vpXrQWp/3NwDi2v
 IqZbm+ltwwKlWBsV810ZePAplpAHoZjsiBDBuBRsGvuP/5sPFDr/M0E/FYAQcYgPA3tJJLp91/t
 C
X-Google-Smtp-Source: AGHT+IEwsL84U+hGZUaQtI+sWFzTHkcR6yFBriiiv+NGU5Q2b8xRu3V1z4Th7+Avr2Qdi6n8CTRovA==
X-Received: by 2002:a05:6a21:3e01:b0:1aa:8c0d:bce3 with SMTP id
 bk1-20020a056a213e0100b001aa8c0dbce3mr4703085pzc.32.1714013375225; 
 Wed, 24 Apr 2024 19:49:35 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a170903010c00b001eab473021fsm273843plc.168.2024.04.24.19.49.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 19:49:34 -0700 (PDT)
Message-ID: <84297019-ab80-4611-a6b5-ab17b66c8aa5@linaro.org>
Date: Wed, 24 Apr 2024 19:49:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] tcg + linux-user patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240424225123.929152-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240424225123.929152-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 4/24/24 15:51, Richard Henderson wrote:
> The following changes since commit 85b597413d4370cb168f711192eaef2eb70535ac:
> 
>    Merge tag 'housekeeping-20240424' ofhttps://github.com/philmd/qemu  into staging (2024-04-24 11:49:57 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20240424
> 
> for you to fetch changes up to 0815c228bd1e0c24ac064ce299807b32f8e05d83:
> 
>    target/m68k: Support semihosting on non-ColdFire targets (2024-04-24 15:46:00 -0700)
> 
> ----------------------------------------------------------------
> meson: Make DEBUG_REMAP a meson option
> target/m68k: Support semihosting on non-ColdFire targets
> linux-user: do_setsockopt cleanups
> linux-user: Add FITRIM ioctl

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


