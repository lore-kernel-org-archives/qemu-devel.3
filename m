Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428C0D3515C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sEW-0003oT-TV; Wed, 01 Apr 2026 05:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sEU-0003o5-BC
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:51:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sES-0000lz-NG
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:51:30 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso59923675e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775037087; x=1775641887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EN+5kYZfAKjpQLnOvclcuPRS7nQ2Q2ZyKGKhUmOFOR0=;
 b=MH+RWusCsDxbYW3Dwie56Tb1qt9qvC9jlSkxbRQ06Tkh0JIbLItttuLNdUaJNlXjC6
 jWY7n+UrS6UshdZJG/dffDXGT8si0wuu1smMDnKi6K0R12FG4gZZGRazfZmx3epVlDhf
 KkwHg5QgRmQxDnWC1kK3N3C4rBHLLYy60wKnsViZsXckBxQtoNFruj6gbRcuUgPh3knS
 +qV2rtLkKl3s4SLxF0Zx0QQoubp/yTq77ODix7YeuxKYfNk+Y0t9JK8jEagUY+4Uu7dX
 BMzjXUPFYXE69X398F2p8X9OpLVTbSFD5dN5NUCcYPpCqJUxdcjkeOj1h9zeyxrjBH8r
 yWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775037087; x=1775641887;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EN+5kYZfAKjpQLnOvclcuPRS7nQ2Q2ZyKGKhUmOFOR0=;
 b=loCEM5ebsftsrlxsqUejNabEMDpEKJvarTfhspGe9UBxAWoVN0c5gKOV2VGwP5I5Tu
 yrsBx1C90j7tICGuPXqyKE/5Eu/rCgDq3OBMpFqkLV+ebssmkmBMKevIuxlJNPnr1LPs
 j5SQa8CfJ3DnJG0+Qb6MhydQsImNjcXosGPOFGIBtJL06kWHu9RTxQKIZBTtJ4bRMwPZ
 TS1l7YnvPhcT0RaPwRoi3niN4hRDFwnozf2LHrCndt+FO6heMiFXVXjGC8H2u613PbVW
 dB+a5bYQjd7wlXtXM7YvTBEQQkwxsClbBkICT4DGPsVro3tXkQK3YLqm4I3BjRqi5SVw
 VhkA==
X-Gm-Message-State: AOJu0YxaLRc3DyalMnLsa0xHxGE5CtUEM9nG32CxJvyRI4TWGwtQV5fq
 QxBAnNna40laB5zQNosZp222agVy8v56V60QHrxpIn7WgWF1W7m+vzLYzpO1+39RzgI=
X-Gm-Gg: ATEYQzww7OhnjTMb4zvsfHg3xTjxyfpzy0Wx13DVQL0ZFnpof7lZcMgWhGs4YPiCIjy
 qrq86d2HJkBcqOUR2ZyZ+NH226bx5juQmOiuO4+hAzoPKrXdOmaYu4c4pbUdsE9DhN+shkyp2sl
 GTV5IMwTK2pv+pSubZVRJRQfGgBw8QL7iKOHRXX3PoNBhYw2/HFbdtCPnvln4dNEfs0fXra/mXM
 9hA3Z6dmsoMlUkpFu5MuTA/aw7XkZx3iE2ZIKXVTuvWaYeWGRaHjWo3k+LaeZZydA3AOHIP6XqR
 PO+pXLa7twLdNUwZhBuAcBtxiJg9vnqKanC8zoAoP6M+y7M0rBYAJPRpP/HM/7bFoP70d8ZyiVw
 VckJCSc7YPIJimUfTrk9Fa9nOxo4XiD8aY9xS/zEnvRi+ySsLAPj90LLAZlMzldaRigac47hby+
 NRAn9ngGN5cSLTXowbVaIu/QG8ovlLij2LhrNZc6b08og8X31HVviibBno1UOeZLFBBRnMKGloL
 NjO
X-Received: by 2002:a05:600c:450f:b0:485:4453:401d with SMTP id
 5b1f17b1804b1-4888356843fmr49062315e9.2.1775037087040; 
 Wed, 01 Apr 2026 02:51:27 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e843a55sm82884325e9.12.2026.04.01.02.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:51:26 -0700 (PDT)
Message-ID: <6c998d7d-e185-47d7-8687-556e9efa7983@linaro.org>
Date: Wed, 1 Apr 2026 11:51:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target: convert TABS indentation to spaces for consistency
Content-Language: en-US
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>,
 richard.henderson@linaro.org, pbonzini@redhat.com, zhao1.liu@intel.com,
 edgar.iglesias@gmail.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org, thuth@redhat.com, peter.maydell@linaro.org
References: <20260328170913.3673-1-tanyaagarwal25699@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260328170913.3673-1-tanyaagarwal25699@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 28/3/26 18:09, Tanya Agarwal wrote:
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> 
> To follow consistent coding style, convert TABS indentation to spaces
> for consistency.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/372
> 
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> ---
>   target/alpha/cpu.h      |   6 +-
>   target/i386/cpu.h       |  40 ++---
>   target/i386/svm.h       | 308 ++++++++++++++++++-------------------
>   target/microblaze/cpu.h |  12 +-
>   target/sparc/asi.h      | 328 ++++++++++++++++++++--------------------
>   5 files changed, 347 insertions(+), 347 deletions(-)

Queued via hw-misc tree, thanks!

