Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F549D715E5
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 12:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjd35-000353-2N; Sat, 24 Jan 2026 07:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vjd1Z-0002c0-Ly
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 07:45:59 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vjd1W-0007Hh-UL
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 07:45:57 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c622ce9a33bso987455a12.2
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 04:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769258751; x=1769863551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ubzFdz8S1iQDxG07ae18vcibEmtHUdW3npIOVoXdzY=;
 b=tVG2S+er/7hSXa0zLnukV64m67yAv2qXm5CWJ5QWAH48aD39L2NrBkHM/6VZB5ziYt
 4VUtfWJXwd8nDxedNHFjyZiI86aOokub4cOqPywS+u1DnzVACe2wtXmOwBql+Y7R7Xnv
 vkXpwSz+QiiEx1m3JOFdxPTXjTyQ/88lyUsFuQZyp6vg/soybmiaxOBN/Ag/E2Fwe0dj
 fV+TpBDdU6xOhPCJ8UnpKXRxHqQNOcCdxvxKR0StZrZJVSBs8XMX0rEzfQWQeOOWBhFe
 Po8GcuGfSQd64bOwchFR+74F1Lwj72lN1XN1a3vXzTHOrvSzOozGwb+lASfX2TF+98tO
 AZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769258751; x=1769863551;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ubzFdz8S1iQDxG07ae18vcibEmtHUdW3npIOVoXdzY=;
 b=bVL5KzhHqUC4yOS2bZp6RAht2e+Oh6AZ+hNFJsEcsItvRDrso/FEn7SAzCLa935cVZ
 MJLMGQxhjTtpJFcoEW+rfv0fVu4u9JugKJDtlG9Ow5j7bMgd1GZVhj0luatxkxuuy+Ij
 4/O8eHy8I4atyPr+Aci9/5ORzojvfmh8rqim8ruRapcQWA6+vR+D9PdwGd0gOO66og/X
 vg/FzI+t0udjLdYUQPrbmCwEO4Ve4c+C/3DotiNP6s4+lugo9WDwL9ByCI9VIKYviDXA
 +JgNOofCbIWL3MxfTK6rF81DflmbCCGhx8z+kR8aPZ2lEzyPI+E6fk1DH6pOOdcVGAWn
 RF4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8sE0LSLjxXZ/WXuMs2y2UOr6gOwQ2ePoRbOBKMRiD7XwRs8I0mYXBXK80c6AUugRIQ0HOfAeVKvab@nongnu.org
X-Gm-Message-State: AOJu0Ywk9ay/LGBla6xCG5FVNFOm9CcBC+QcR7i5GQTGfnumRkUepAcC
 apAwUELmN2E6n5V+I8YomFRsYHJKUetaOyVSeLt9cU7f5jsUyiospPas/95c1DS12Bw=
X-Gm-Gg: AZuq6aJtctdB6FOW5cbwWG38Ag+LPCTEvarDBaFGuE11hlcN3XJNE+IjfIiavl/zGgy
 Uz1xtdgKCUYfbXPGk1IBJMqnfNka3YDpyM3mamHcUJqx5MGnJffABJUFFsEUBbdW4W4EzCdYvnU
 CVN9+QoH1X1o4tj1D5k+t7UFELmU051JnppoHxzSPvpW3o/MXHnTToAujqZh3N38fldasFUV3Mo
 SBY1KpQ9pSngDz8gWwwlLHO0wUupqM9AxgQUcFPdXLI37D04yFHKdwexBafie+UECGbU/W92F8U
 AM9mk3dLCwDGstiE9HjlLkdGS3Y31fXzmXVbWQLo7UpwRHbUjjRZ6Vm7rBeq1+GNKkSDQisP4iQ
 wlS4O+Q4UICBx3+gJGe6kU90sA3h+yGfxXxDhtWZrPmmFIZRWf8uGwFgLqan6/mNULJelTxlt4z
 Xd8eHULqNzu+I93Mw5zjmy+I+Gq6JQZw==
X-Received: by 2002:a17:90b:1e4f:b0:34c:c866:81ec with SMTP id
 98e67ed59e1d1-3537b475b6fmr4084746a91.36.1769258750819; 
 Sat, 24 Jan 2026 04:45:50 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3533521707asm7397476a91.8.2026.01.24.04.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Jan 2026 04:45:50 -0800 (PST)
Message-ID: <757fb697-0731-4d43-99f1-3d035a7609fe@linaro.org>
Date: Sat, 24 Jan 2026 23:45:43 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/11] Linux user for v11 patches
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, deller@gmx.de,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260124085306.3996-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260124085306.3996-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/24/26 19:52, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 2339d0a1cfac6ecc667e6e062a593865c1541c35:
> 
>    Merge tag 'hw-misc-20260120' ofhttps://github.com/philmd/qemu into staging (2026-01-21 07:39:57 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/linux-user-for-v11-pull-request
> 
> for you to fetch changes up to 5db961f92b38b2a0f9db50b47ef3a718962b374f:
> 
>    linux-user: Fix MADV_XXX constants on hppa target (2026-01-24 09:47:00 +0100)
> 
> ----------------------------------------------------------------
> linux-user: statx() syscall, termios2 support and futext() syscall fixes
> 
> v2:
> Fix build error in which CentOS9 is lacking the definition of MADV_COLLAPSE

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

