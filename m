Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6514EC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNKf-0007YE-61; Fri, 24 Jan 2025 12:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNKd-0007XE-CL
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:18:59 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNKb-00077t-GT
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:18:58 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6f1be1daeso240813585a.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737739136; x=1738343936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4twTcQVLQKgIEzuoRlWRF9LAXLNCoBjPsZMisdjD7LQ=;
 b=i+Y00KXEhiJv3ENhp+F1GxbZv3Cq+28YtDi4Cl3FsVK5RILIS1EqJE9wfP6cySWMte
 oVdNr5uWHGGMVxxbZmKHI8w6umsX06kYuxuj2iS0kacgwSQ0jw5UWU875RApFAuq6983
 IUA8oDYBuSgHGIWc0iweupOSudhHKjBvyGjFQjlBSPUUebFpu+6UjFJkgJpKPT11Dmd9
 zo7lTCMciGMbij38K00PRAWdh/8AnD1aKfwCBtYMKlm/b62EOIwNSFnSEfkVmGXLzAiI
 Z73cPNmlgSASSgx1RQWASO4kkf1Rqv5xsMoKhuesgLq6GAjQQJfdHEBwb0/LhhDkJF54
 La0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737739136; x=1738343936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4twTcQVLQKgIEzuoRlWRF9LAXLNCoBjPsZMisdjD7LQ=;
 b=wZeY1qJ2hGjOWjWnx48fLb4Rej/lTNuGBpMM9hZuoN8m/uIaNz7kvinxFvdYBgygxi
 GaoBKj2yeJhcjEAJ1KVbITy1TfnTnnoZB4rK5+zfYLLLw9mryJtLwSjeVgdKCOWsF3H6
 wPL3d/FZu46MxHqoEKB+/gSt+9/cN4HXgbSWgxNLtK9HDY/WqhrIgto7wAYsYBpo3Fqh
 eUaBf2u0kAqtoHaLN8s8tFU9XrBsQkF4hSS+TuhismY1yi2LN+6P+w0AUxCOAjtHBIMJ
 SrsL2ANB2ld4ibVLs6oZzmANTt9Xpb+L9M0GBBQ71/u0x1TwnTa0mEhfGTy5R3FUmJ6+
 zdqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnR/WdGzC2xF7tMwWkLBXNpbWiFbuqKsw7z8wdnjPwuoaXhOIGH9sExhkrAYKHz8CuEZM854gaWY7x@nongnu.org
X-Gm-Message-State: AOJu0YzJUGghTi4+27XAEFFR75C4FOvoCnyPGcyLFAJPxm3amPK4CQSj
 tvhACCZtY16P1tXQc8wvAWOU0XoFiweqOfWiW/rFJfB03QyonId4BcCAzJJQYlk=
X-Gm-Gg: ASbGnct4Km0me2TLwdjhLnITYFUSYah3ehquugHbdSZpi6P3EPklqAGxuaquyhtkPiz
 NFhBSzLodlh44T4Fue7alsjGtZfYOtrIU9e5yn4PhMRr5ATx1XvtGo/pSJBPTCiDilsB9SZxeox
 trQ5FTgOb1BKyHv1OhL1PxB8fbMRpjLbRKSqp6QPuAo7KEr4Nq4detIWSY07tuhDuXtmf/HFO3P
 izMM63ORKsfz41qQOBYwJWPoXzPajCyNpYTwiPvluC0rHZhzI6VddwC25mWtRIjD8zRihdd+9Bh
 XaLDcXHbNGIkV0O326X0Q0TQ3R25Y1cqRTucWU4SwF7PY5SRMx3kWzYzD+iqvyJWpw==
X-Google-Smtp-Source: AGHT+IF7tptKJBQqZN+j8Cwu2VbTl7sjQA8imXl9CWIFDp+aw9+vkQKjGfibAHND7i1Poa1Y/og2LA==
X-Received: by 2002:a05:620a:402:b0:7be:82fc:6871 with SMTP id
 af79cd13be357-7be82fc6cc0mr2199049285a.18.1737739136568; 
 Fri, 24 Jan 2025 09:18:56 -0800 (PST)
Received: from ?IPV6:2607:fb90:c9e1:9829:9eed:533c:6788:9f4a?
 ([2607:fb90:c9e1:9829:9eed:533c:6788:9f4a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e668c921dsm12102881cf.47.2025.01.24.09.18.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:18:56 -0800 (PST)
Message-ID: <58add097-ae4d-4d18-ac8a-776b6ffc5fb7@linaro.org>
Date: Fri, 24 Jan 2025 09:18:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/28] target/s390x: Restrict I/O handler installers to
 system emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-23-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x736.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/s390x-internal.h | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

