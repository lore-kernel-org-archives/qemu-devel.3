Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E964D35671
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 03:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkwKg-0007Aw-Sk; Tue, 27 Jan 2026 22:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkwKf-000773-N1
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 22:35:05 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkwKd-0004pe-UF
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 22:35:05 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso5811879b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 19:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769571302; x=1770176102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aBxOR1YedQIo2DLEqnwB3McpT12voEdd2Iy57Dntw3M=;
 b=rptfRSMcMi/jrUXjnl83Cl2JqSrSGpEH8/l1i23Yawjoyun5NSICi+WTpMn8qJq0Ia
 O/6RM0tJIdlOjFR1f677izGNnrCYXSEHoPg8qKUmYIZL0RrIGAuYF7QV9T1QMbsk2tvT
 12oqFZlmtBGJktpVRjB2w4e8mXIHVST5JMVr2lQnLEba3IGPoMhDwI9yRn9YGEqMO0Ln
 K+jXGk4BqE0h3TdEgZKBk9NZntr0Jc76xcHAf3Ki9JzNlzXf2PcKsBXYl1ueA8bZ0YLr
 O112tgWVaGAHKqH3zIUvqPUcZX3joaApecwiX7/z5KIfdQ8dSe9sHOC7ZDyNxoMINq66
 YHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769571302; x=1770176102;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aBxOR1YedQIo2DLEqnwB3McpT12voEdd2Iy57Dntw3M=;
 b=aFxjBWJn3ICG9Yhl0tB0wrfHHh8Lvqemx5B4iU01m085DiNpex5rKshwn+oR7pUNhH
 PKbN9e76Ic4cOcILwkJztT70K/i4IIz45oLbvY3Mgl0TAeyoztpJgynAW7FA1M5hoTni
 qOKvqR/xar/1pyg2V74FpkY/lgdn9F6WqnkchLCvhkoooCEyhQpAxD21JQMI0jyRIxbo
 ZI1qVmZDkAp9+bXTY5i+12sCD3XJd1KqVOKruFQtQU6Mx6DeyQ2YnSWlkZ4C3ZfVgEgP
 Lde5W5Eab9R4hOSeanRMWoKu7RT+su6QUKAZMZqfAqvR72RrBSoddnVAPls9h8riHxDm
 Rchw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6/9fmQgPHCGtil9l+KCbtJBpT+t+mGWIEQIqdDy0QYKZtuBnFG+b+Uzb0QQzPnlgDLUZR0e0DbVmO@nongnu.org
X-Gm-Message-State: AOJu0Yxg8UA2npqKEuQwf8niaIX5zQ65wzXdfGkeuzfX2yscyCJpMmYU
 hWLaa+t7ViHBMvDPytcKQFMbAOGxEvkXrW7FCcXE1jGynrfEM3U7XXTLBPyPxm/1ExNkmtSIaM7
 m8b5NP+Jtjg==
X-Gm-Gg: AZuq6aLEiwpRsVBIlLc5J9j9Aw1xxo9F9DE7n+HauR4ZkrhYimNpY/b7k0WKrNRSYMm
 SifItCPX7qlS51CQrfZfbLYYGIj90dWQLYpBcJ2bhiR97R7VufzFkFYQQ4iomvKl52XE2qCby34
 CZUY415pLlZrTEC6F7l6JM+LIXH0Sllp2sJbZDbH4Dg0C94+z27QMdoriTCJlilTDJsLCHgfUqZ
 v2smewPBFwwv2qByIMTS5BjDBvb9QeoelTCMRVoBm++9ygSS6ccnUWisqZv8q62LGuk1I0pe0hC
 QpslWDIoOOgm9XkfRzNaMXbI3H7uodL0d9vH6CmCQwM89IpQoZzjDaJkjzlXMmSjbFE82oZneBN
 5JPCrKvaKewXeBtRFQ9x53igfST3MGBhcMiH3cAU04063aQnrChjLJlv9dkfJLVeDzMo8D/zAE4
 xLDv9FLb7/iyr8vjipV7PfDgi2SGGNYQ==
X-Received: by 2002:a05:6a21:4846:b0:38f:df47:87a0 with SMTP id
 adf61e73a8af0-38fdf478a2emr759796637.61.1769571301704; 
 Tue, 27 Jan 2026 19:35:01 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642a42b3fcsm783732a12.20.2026.01.27.19.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 19:35:01 -0800 (PST)
Message-ID: <717a0b26-f836-44d6-a2bb-289a72c4889b@linaro.org>
Date: Wed, 28 Jan 2026 14:34:57 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] updates for MAINTAINERS
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260127114240.3009791-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260127114240.3009791-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/27/26 22:42, Alex Bennée wrote:
> The following changes since commit f26976b9d30496d28bd4fd045f4300706e567a29:
> 
>    Merge tag 'pull-vfio-20260126' ofhttps://github.com/legoater/qemu into staging (2026-01-27 07:14:11 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-11.0-maintainer-updates-270126-1
> 
> for you to fetch changes up to 74be6f8bc918cdc532272efcb002b9146bfecc78:
> 
>    MAINTAINERS: add co-maintainer for TCG Plugins (2026-01-27 11:37:35 +0000)
> 
> ----------------------------------------------------------------
> MAINTAINER updates
> 
>    - fix some malformed entries (names, lists, status)
>    - drop Mads from HVF and Tracing reviews
>    - add Pierrick for overall docs catcher
>    - add Pierrick as a linux-user reviewer
>    - add Pierrick as a co-maintainer for plugins
>    - set linux-user to Odd Fixes
>    - update core Arm to "Supported"

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

