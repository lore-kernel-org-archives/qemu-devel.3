Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6959BCF2576
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 16:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t011l-0005Q9-V9; Sun, 13 Oct 2024 12:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t011S-0005Bm-1j
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:00:56 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t011L-0003MR-Tq
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:00:42 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71df8585a42so2636563b3a.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728835238; x=1729440038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a1i2+Ri830sAEOVSGxryIPM46/DjUsnsnqUhWB0XfNI=;
 b=KX0kl87+8IW3zbsOlEzeD7Est21BGil/FjON/lXd7WepAx4jX3GAjv5XRh7u5WJ9wb
 9GguCsAsgls0vBEK7ytWPNIqE/WZ03CAjGPrGd+vtF+MzpDoNj6lAAGSznULPPmuVhY7
 P+LeYqUxbhb5FAZvzLqsICvWYnocJ+Cx1FoR54XfZiUKtvHQraO2ErRklIPLXDYPeuak
 euRs+/0zXuSqZvyPRplfgRsptWbFWFQSueF8Rx4+H3gMSOX4c9fi5BoL5eJYJquyG/80
 BpXfJF1SpeY1QZmjEWzF0iCW9knMhwUzqtMhwG+v9jPsXIPQO6hqX2lff7JQjWI0tctX
 TQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728835238; x=1729440038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a1i2+Ri830sAEOVSGxryIPM46/DjUsnsnqUhWB0XfNI=;
 b=DPH3+uWcH5EIHLqUE3UiSeLyupWt9ruGIXU9wnT5a1SV9ut1Hyc/zG2fFtgV4qWqgM
 buROeH6KeQrFz9gdHsn6E9qa7B63LnNR13TH8Bcu20PP25pKyhfFyhwT2w4TodkKtsvJ
 qL9oIz/9t8D6wsFQpKj3nXILqnXpDK1Xm0T2W6yl7mHSRIhVMUX20DZYMmHcVdpJHDtI
 HUWMHHs45EEaanG64XqPrsAvDcZvYop24Ean6Q4gfEKsK5R+CR1MybPR9nRuPyU+dld+
 eCzY1kRSowDcIbabaTvtezXoCzEyeUDpx/iUSiFXv9wnmyW+VQv97XwWuGPwx1orbu15
 ovUg==
X-Gm-Message-State: AOJu0YwW3i/XnlwqWjK/fZxRwKWX/wn3j9l7yf7S303AOPrvsG6YTjCP
 YPVuS6QbsmxzVW8jG2cEBf4uenm5FEFwasGG1ICoakj9ANjKsBfwrMVHGNc5gNk30ZSRe4jfz69
 /
X-Google-Smtp-Source: AGHT+IEZpAhKQVBLdTON65jYdGFtOwNMuHx+Yet2HC4TK+clJnYF49O/ZEaIcoO6QyUpDpVAwDCXMA==
X-Received: by 2002:a05:6a21:4006:b0:1d8:a67b:9219 with SMTP id
 adf61e73a8af0-1d8bcf2bfbcmr15327618637.15.1728835238462; 
 Sun, 13 Oct 2024 09:00:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e5e4ac12bsm1174808b3a.155.2024.10.13.09.00.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 09:00:38 -0700 (PDT)
Message-ID: <9b248543-f711-4c36-9c8a-f58bc6aabbe1@linaro.org>
Date: Sun, 13 Oct 2024 09:00:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] target/mips: Explode MO_TExx -> MO_TE | MO_xx
To: qemu-devel@nongnu.org
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
> Extract the implicit MO_TE definition in order to replace
> it by runtime variable in the next commit.
> 
> Mechanical change using:
> 
>    $ for n in UW UL UQ UO SW SL SQ; do \
>        sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
>             $(git grep -l MO_TE$n target/mips); \
>      done
> 
> manually remove superfluous parenthesis in nanoMIPS gen_save().
> 
> Reviewed-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> Tested-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/translate.c               | 120 +++++++++++-----------
>   target/mips/tcg/tx79_translate.c          |   8 +-
>   target/mips/tcg/micromips_translate.c.inc |  22 ++--
>   target/mips/tcg/mips16e_translate.c.inc   |  10 +-
>   target/mips/tcg/nanomips_translate.c.inc  |  32 +++---
>   5 files changed, 96 insertions(+), 96 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

