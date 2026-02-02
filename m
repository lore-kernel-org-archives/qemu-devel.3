Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536BFD172CE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmUN-0007d5-31; Mon, 02 Feb 2026 00:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmmUM-0007ct-9l
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:28:42 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmmUK-0001Te-Og
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:28:42 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a8a7269547so38632475ad.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 21:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770010119; x=1770614919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IwTJUG6uDs+BW9ibE0GqELeNkUa0TuzobgOA0VlLkfE=;
 b=C4avzE2egncDx2sAURC8dKJ7Xp/UfMxpTnKUeF6gSmHWNaHW5VDO18pHuXvCm/240r
 cVx01Rnpbn2xVxGgL5Ok0/Eoqpd6s8POeMtpaFXL4P8y7Mjli7WXfwPfjFZHpQawdp8p
 IOSLN0aDNgUqc1IC62DxQUTMyTWcJq2TCPmbp+96HspLZ+NZRCWHUr8OKY/X7Eq+T5Wo
 yRme0WjAL3ngaGgcMXIZQL2PwaFtx40bGW3ay1/kAevmwidDLTxxvhVbAbdZpydRPA1/
 gh25xFq9my4dW8TpWUCse8tp7ZndjEAMRFRHSZjOyK2eN49xX1sZv/KozE+YyKSW9FyF
 bUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770010119; x=1770614919;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IwTJUG6uDs+BW9ibE0GqELeNkUa0TuzobgOA0VlLkfE=;
 b=WPIPanhjW/pnZQgf3OHrwl5vQ8jOlpU0aQFUuCzhmJUQikxBU7t+vewUH/dphCjYQ2
 8CcpvWWDlTUYmiSwOAxXTAriOxeOZm3X9liszVpTKgbylAvOWCuOth51L8AzeHAr5ToE
 tZSAZ9ZPqqUR6MNoOZDX19+tzXphPRBNO1eF+koLF51o+MVoHP8saQSKnFzUIQ4sguT3
 hwDUS+bl2nqus5xZqbAtdNJdqEuzE/g5JoVoefxl6B4xKesQhpItusdUfx0vzAjYDttU
 ghpyd/ALuEb7Cetr9PTNmE3hxaUKbvuq0XDpaGTyj/AX0Q2tHCzni38NmnL22iR3v3t5
 INJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqdiLqe3tuEY85lYdNfkI+0imItkUk8SBCPjL4rVGxyt8JXLMfaypluVifJm7oR5C/c2uTlkj5dWEm@nongnu.org
X-Gm-Message-State: AOJu0YxSQWkZ5zePRw21jDyqoAV1pu8xMtSiiz3eO9LYm4izZFnwhhKL
 DPJod+05740QyG7gdKPTz/XvR+jgYL55l+jy6Cg/OwNOYcEH2f/gCLwj26IH+QauL1jNGWiBQdo
 XdLBB
X-Gm-Gg: AZuq6aJpgIFIWv7oy3NxPpI+t0rpHLz45DEHUh84TYtZ40axXnECWjxUn2/G8/GE/jp
 +KlWFxIi/LzaHMc2hV1n9W1Tj+UBWSSR3ykMp8QfhRdRJXpZ8NBJU0gC5LbDZkH5ZMeWVakvnDS
 E80IRndh6kdhK11K1iSCWmtpA3eDbjudkHgVuwJmoP2xGU6cb4sGYtwkfV0RPdWCu7NdEhpEoum
 30zRVwEc+QMrOBdMOI6FxZzt6WJ8mGCBtl9UJQLM0o2XmxFurdaGzpv5LKa2iIdLvkBOqOCb6kN
 pO7QV/ZuPOdDNTCPu0mWxVjsamce4ZAcXnxlnVESzGSUfbe7KAk+07wvYpDbjNu74Pts6fwvG2e
 BNM+BxPn9GUh1EhfWUkMIV3RIi3Zq7+EOH2UvJYBKBO/2+9GxWGvKlDx8GNdBPuYdnMSCCaLlRd
 KSnMZn2SMapZXdAMsext/hc8ry7VIRX88D4WJMqBFQMfbz+QgN13LCRUoE
X-Received: by 2002:a17:903:2f8e:b0:2a0:abba:a2ee with SMTP id
 d9443c01a7336-2a8d959c483mr94152515ad.5.1770010119050; 
 Sun, 01 Feb 2026 21:28:39 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b7f6c7csm139858545ad.98.2026.02.01.21.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 21:28:38 -0800 (PST)
Message-ID: <9df0664b-152f-4702-82e9-abce37b8d3e6@linaro.org>
Date: Sun, 1 Feb 2026 21:28:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] linux-user: introduce syscall-filter plugin API
Content-Language: en-US
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20251214144620.179282-1-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20251214144620.179282-1-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/14/25 6:46 AM, Ziyang Zhang wrote:
> We choose a smaller magic syscall number to avoid the illegal instruction
> exception [1] on qemu-arm.
> 
> PATCH v4:
>    1. Modify some comments
> 
> PATCH v3:
>    1. Change to a smaller magic syscall number and add comments
>    2. Set register flags out of the for-loop
> 
> PATCH v2:
>    1. Rebased on newest version of master
> 
> PATCH v1:
>    1. Format the code
> 
> RFC v2:
>    1. Simplify the syscall filter mechanism and remove fork-cpu
>    2. Add QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER enum
> 
> RFC v1:
>    1. Add syscall filter registry
>    2. Add fork-cpu interface to re-enter cpu_loop when handling syscalls
> 
> Ziyang Zhang (2):
>    linux-user: add plugin API to filter syscalls
>    tcg tests: add a test to verify the syscall filter plugin API
> 
>   include/qemu/plugin-event.h                   |  1 +
>   include/qemu/plugin.h                         | 33 ++++++++++++-----
>   include/qemu/qemu-plugin.h                    | 32 ++++++++++++++++
>   include/user/syscall-trace.h                  | 17 +++++++++
>   linux-user/syscall.c                          |  7 +++-
>   plugins/api.c                                 |  7 ++++
>   plugins/core.c                                | 37 +++++++++++++++++++
>   tests/tcg/multiarch/Makefile.target           |  4 +-
>   .../multiarch/test-plugin-syscall-filter.c    | 35 ++++++++++++++++++
>   tests/tcg/plugins/syscall.c                   | 19 ++++++++++
>   10 files changed, 180 insertions(+), 12 deletions(-)
>   create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c
> 

This was merged into master (a8e6997ef).
Thank you for your contribution!

Regards,
Pierrick

