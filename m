Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEA0D4A609
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgerX-0007j4-5i; Fri, 16 Jan 2026 03:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgerB-0007Zl-5U
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:06:57 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vger8-0005Yb-CY
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:06:55 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-432d2670932so1393678f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 00:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768550812; x=1769155612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FtSEBoSd2UwHbmOqPZjm3XBWem81yAnh0ZyMoISlHD4=;
 b=YRygJnQxWAtiuhSXYL+vZ2gkx0+qINynGsBac67yfKdNW5F5QuX2QKvnR6ai7zYd1o
 1dgeVq039oddT2MdJE7gd2imxEY8/gS1BbY2F28DEsyOVP3cLi71CHlfOTKe7zVjHL0y
 fWy/x/ZqHLo3hbW0JeOPRWZaMgJRlikZHfQ0uoHz0+sMCTqb/t0NtOWf4zm93GzBjBgL
 f6TSBxZxsgG2ZqvzytPxS+FjtndTtnQ/UQmlKb9NIn20Y7OZNfP8cgrhWt2DNLydHdUQ
 tN8LPJwt6NZ2ccZG2ZBpyOyJy4hYSsAM4pZ1rrMeve9toYVBlkFhNMBuD4NXXJGq0uAV
 Y1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768550812; x=1769155612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FtSEBoSd2UwHbmOqPZjm3XBWem81yAnh0ZyMoISlHD4=;
 b=cOHNq95BG54ZTGRL30SWmlzDjEqFpRMTN+VYlAiCaFEhhwPEIrPKfsaMH6m1diA0gJ
 /ypfpwsMwzoB7h8kOC1cvf0sQqY4Ohc5O8hrQPG+rcpHpg2b3v8qbdG2xgZqdqECOoQ/
 ftrrbWfvMBA6NdHHxTAs1AnQKOjfEgfJbf7XQLh1NgUWrSDFFRvRZhKux18R+ulQRUDG
 mgiLA/oWZyKKGpAmSRxKn9x2awdxUiap4uQpiCVgaCaUy4cNPKnFVY2ngZzAxj6CgLLg
 Rn0itMOcDab6sYh6rRwDLwdsSdcy2LgDmXGobpz9MsM/og9LiYu1UmRM12l71JzQBX+g
 CvMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUN9atLpxGzEy74p/MF0c26LpbQT1iBL6w/UoqJsxj43o5c9goxTeRSdYlyUJBOSOvu2t0uew6a6pq@nongnu.org
X-Gm-Message-State: AOJu0YwWdfYyE+Sb82TBR0MYSRGbL+yBpQo00RNpdaFDFDzAnPwmasyT
 qWDu4xl5vq14/1INGTX8MezR7/ZseOtJIt3TN3rZpfXL/kGFWUfeYgM9fcK1KuX/MjI=
X-Gm-Gg: AY/fxX4fzFwkskdQk1DaawBx7aT8QdnLiqN8viDwOaDPPLYLOCZ2PTsNxv6l9rt3yZQ
 kCGeQUJ2O9ATjQlHeuz1NzWrCcW95UKaK6YCN//auI8+OPN9pAJfXroCZPgBy5z/7DD+bSa3Q2H
 uoPIscRWrUyUs6Txb4bs0o1sTL2Y314as9P/xceJ7S8sMr5Umgxmb3APZ+ByosaBgJ3IMvYzHbw
 IJNvEo+yhlZKOLH37wIqfOuUb5crLSxG9GketbgQUCZr9qIikG+CvmufHyvKtjOPgwJSlbAszQG
 mU3mN0RuO4vgrd8TYENdwHQo3Q7wKB92ldw6JVGxVehxnLG9urCP7vJnIzvU0Ke/5MRz13CsqKy
 oSxxlb7F9vzK3/g0nXGlfM2sSU940PJ5NHx5GtunKVFuGkgOYL/ylyv9a21RlzaxXHo16Shvlb4
 AQTO/YtLK8EYf/u80RTWefYsrIGhi2Sz1kRHgG0S7zpaUUKJ8GlMxSNA==
X-Received: by 2002:a05:6000:400e:b0:430:f241:a11f with SMTP id
 ffacd0b85a97d-43569bc475dmr2014117f8f.30.1768550812286; 
 Fri, 16 Jan 2026 00:06:52 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997eb0bsm3647846f8f.34.2026.01.16.00.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 00:06:51 -0800 (PST)
Message-ID: <4bd6292f-993e-4c84-8053-40fd2fb2379a@linaro.org>
Date: Fri, 16 Jan 2026 09:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 53/58] migration: Drop use of Stat64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com,
 pierrick.bouvier@linaro.org, thuth@redhat.com, pbonzini@redhat.com
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-54-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116033305.51162-54-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 16/1/26 04:32, Richard Henderson wrote:
> The Stat64 structure is an aid for 32-bit hosts, and
> is no longer required.  Use plain 64-bit types.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   migration/migration-stats.h   | 36 ++++++++++++++++-------------------
>   migration/cpu-throttle.c      |  4 ++--
>   migration/migration-stats.c   | 16 ++++++++--------
>   migration/migration.c         | 24 +++++++++++------------
>   migration/multifd-nocomp.c    |  2 +-
>   migration/multifd-zero-page.c |  4 ++--
>   migration/multifd.c           | 12 ++++--------
>   migration/qemu-file.c         |  6 +++---
>   migration/ram.c               | 30 ++++++++++++++---------------
>   migration/rdma.c              |  8 ++++----
>   10 files changed, 67 insertions(+), 75 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

