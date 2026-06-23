Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EA6CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc61G-0000bB-25; Tue, 23 Jun 2026 14:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc61B-0000af-Ud
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:38:42 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc61A-0006z1-7r
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:38:41 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36ba706ab46so218251a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782239918; x=1782844718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d/cFUQLrnsPY4I2acO41DTxHr/EN+5rdRRbfu9Atrik=;
 b=Q5QVdcz2XsDybElasMfU/Eds3knM+dZbAcAtTDENUY4zFFmGpWkXanJopCh72TC8f5
 /7KBYsH2Ry+14EvF5kh17abtPUfoJOouPV9H92v8hbz22eH5Tgt9aiEZsrWVtZIYajYd
 fEJDsuMpBg5M2G8I9iJqU0kxsBMIBk1NhiwQZS8Tuwu8IqpEZA+qonO62RFhSx0xcYMy
 A6aG2hKa/7sbQ7M9CXJ0cgf3m+Y4JaKP3nXiJVe93IRKgKFoWPXffnf01hxA2mFpS67F
 P1FW+47cd1Pjm7KXbjPN+U4f/XDbXDMTgyvx+F1gkb59axcUjwh2mlm8v4ENXQ/D8MXE
 /z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782239918; x=1782844718;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d/cFUQLrnsPY4I2acO41DTxHr/EN+5rdRRbfu9Atrik=;
 b=YPIYfSgq1GdAGcMeDi1/S38SKUtNZYpvUdyBWh9r7OtTwBtHqP21DnW5SFV48y9Lja
 Bva4gdO78B3IT5zPQMQjCWu++vFI7meoswZBnDGo/2TzB17n3WvSaS90qVRIuUFR4CL+
 mpjJmDT11lVV4xc7cQroS0JM36hCCQNGH9GDBO9Dj/czap5QlMiQYhZXK4zw96KKv2ek
 8Ec9ZN8o/rvgTjAvHyB6siaKNrUHkK21vHp7XcmzshvW9j0nuEuoBg52548oocmNVQeb
 Fo4Ex8q3KIVfCoS9pZDszagyJsfvGphb9NyJ+0Dabw8J03dZ4tPN6kTwLAPl42YCgE1x
 exQQ==
X-Gm-Message-State: AOJu0Yx0zDI9ahBsNDoW6alHRsTz2aImt67jKY0ULJ7H6DArfmW6xatS
 y06T67EMfLL68iDB4OUtRXLm0fE8l9IW+VM+BSOOqHFe213kjf+cyedaAlFGUACE+roHAdE8Vw0
 dHRsW
X-Gm-Gg: AfdE7cmXOzVZclMktftIHrVapZ3SjSfhuoXP16BOe60/8duK4GINpOMNW3HO6pnZTzl
 u1C/jFfInxKvz3FXJ1+SHohuojZpHa1O64uH5AHJr8Rg7jBcN6sbFySxpq066vDm41OrNTd8n55
 RRVIFDilV9WrUgKihJtq3BLvcHA8j4vLp9sqK7/7z2WMlZaKvuYbsjBdoqG1hfF1lBhvl6cRIwn
 22uYy5kfRykEiozaZsK5RaZ/AVc7dZVu7N3An/gPuTuRCVAqqGzupndwzCnQXJWC9UXrQYAPYUI
 jN0tOpwe25g0r2CM80W+fDNp3KqQ6SQ6Sq4URt33uOsjhMi5saXwFmjRd6Eo9jjk5QeZ2VZjHxK
 10xysfIUoWeDPBoWjAQYxZq9GHxtWn8xwa5P0b5xmgWrcEcIqLZjOn4Ey+pQLgN7+mUlisd4+si
 ByVucLJ1j5Jqeou9j5Okfo3HYzYe/xPa9GyFjJhQ7chLMQk8wMj5KzusFnHg==
X-Received: by 2002:a17:90b:568d:b0:36d:633a:e8aa with SMTP id
 98e67ed59e1d1-37d160bd73bmr21291765a91.13.1782239917717; 
 Tue, 23 Jun 2026 11:38:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37de3ba0fc5sm93398a91.13.2026.06.23.11.38.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 11:38:37 -0700 (PDT)
Message-ID: <12f840bb-4f22-4f57-8edc-d5a90b2dfe73@linaro.org>
Date: Tue, 23 Jun 2026 11:38:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/40] bsd-user: Add signal shims sigwait through kill
 and os-signal.h
To: qemu-devel@nongnu.org
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
 <20260620-misc-2026q2-v3-6-f6ce23ad8dda@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260620-misc-2026q2-v3-6-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 6/20/26 21:19, Warner Losh wrote:
> Complete bsd-signal.h with sigwait, sigwaitinfo, sigqueue,
> sigaltstack, kill, and killpg. Add FreeBSD-specific os-signal.h
> with pdkill.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Kyle Evans<kevans@FreeBSD.org>
> Assisted-by: Claude Opus 4.6 (1M context)
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/bsd-signal.h        | 80 ++++++++++++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-signal.h | 20 +++++++++++
>   2 files changed, 100 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

