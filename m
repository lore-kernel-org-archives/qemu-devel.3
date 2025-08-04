Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5927AC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizcH-0005BG-Al; Mon, 04 Aug 2025 14:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uixuN-0003mV-6q
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:19:32 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uixuL-00022A-AM
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:19:30 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76bd041c431so3761191b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754324367; x=1754929167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CpUCthRS9rIwst4F78DkhORvM6W+9I21R+2QLEH3fxc=;
 b=YIyE0u7fBflXD/iNo0fxtAM3IKhhR6JnGGm7sHV5T8RQccbOUQvkGe0n1u1PDptWPC
 WmQe0eKeUdmtXyizF+ZBAbIflo7eAxg01b+JjoiaZUGG0sp5MSc4opzzdZNeEJqP2UqX
 mTCgOGyrOhkcGIw0AKlNUhcySDs97psWkVaEOD0xnWpm8xXjTHLvEm2I2TsGRrUyZoHX
 IKBXkDcopXiBelYVri9wdyKnupGXjM6gU6WKmpDGZY1EaR8pk6Lk09lD9dKxtoj1EpQF
 P1HPIUfPw3/6A1v08dWRWTvmYfJDDYG74Jd/8d8rr7BNGfkAzFDFXns0KFZblDtMDhLi
 ssig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754324367; x=1754929167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CpUCthRS9rIwst4F78DkhORvM6W+9I21R+2QLEH3fxc=;
 b=TEYEukfdvj5Sl6xfXJjxzPQCXmy3at63eos8IJDb3V1RdJGy12gSMrCKzkcTLY6aUl
 HGqvMvUX2ri6oQ7yzZ8xS5rdfuw4+VeRW6Xut5yvGcCG4cIOutI6DUCyLbw6zx45p2jG
 HUZNyXx4ezl+/gU/r0XDe0bC5zn67RWBuThpDx2Ma/I7vmsLTi5NDZe2CwldB2p/DI6u
 81nOy7D2nvUch0NpPMOoFRWiWZAnuuaS8AIqe2Mo67aDJIMMXPr3qCsnfE/gQydTuhPi
 +5Uy9OKyP8+xpU+b+Vgb1WMq0pYaZEfvUGM9RLjZnsKe+Qk82LyUXImcUGzAUz/yBT1Q
 Pr6Q==
X-Gm-Message-State: AOJu0YxF6jG75Zvf1jz0mPjAPAe5i+yguOraAsYXixnYJdQcHFDxq1cp
 8uPxFi/b39P0ToZeMRNCRmOMrZ+7eIQqarxE3OSYKpD+E9YudlKc9Xky8oJYwaE1eJ1JvwPqXuh
 FVdMG
X-Gm-Gg: ASbGncuChNHALH8CQhzRgkGD0jyADbFlkgiHk2yd8gb1F5vKDZZSoQPb+pkvC0rsUSu
 iLJiZ2ltB8SKI9VH6U/mzs1rT/Ag7nL731qaGRf3j783raPBgK2am48sAJ0SVb5YtZ+jZOdgcWk
 Iktuluwwtu1EMdaX4hi9dyADmHzr4CCSgu3IORoPET0eXXa6k9LRzOrLzNtXnIUgPhTtttcVUK9
 CkUP0NtqWpKRb327s4r//UltnAs1HNfPb5YAn4lMjpx8g8UYMPJWhMFOpshgdYG0yqU6ONNbbfA
 hdbLXuO2+AgZL7LJpqFAhsWDpiNrfK7i65nHR4wbVgucsOc2ehu4ljvqIgNZKl4aeKX2UFZORib
 +wVZVbRcWPVUXh1XE3DAGn6tlSG/0pCS0YEo=
X-Google-Smtp-Source: AGHT+IHRxZpBpyDns7hvAI1UNoXTAmdYMflO+QdzuKnFR/VA+xiHQbRlLfIkcLbwQuIxSLzmTNyurw==
X-Received: by 2002:a05:6a21:99a5:b0:234:6989:b690 with SMTP id
 adf61e73a8af0-23df917f0abmr14953011637.41.1754324367246; 
 Mon, 04 Aug 2025 09:19:27 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd1d4e312sm10371252b3a.17.2025.08.04.09.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 09:19:26 -0700 (PDT)
Message-ID: <01d39deb-5431-4631-a2ee-09deb69b4603@linaro.org>
Date: Mon, 4 Aug 2025 09:19:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] contrib/plugins: uftrace
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/24/25 1:45 PM, Pierrick Bouvier wrote:
> This plugin generates a binary trace compatible with the excellent uftrace:
> https://github.com/namhyung/uftrace
> 
> In short, it tracks all function calls performed during execution, based on
> frame pointer analysis. A big advantage over "uftrace record" is that it works
> in system mode, allowing to trace a full system execution, which was the
> original goal. It works as well in user mode, but uftrace itself already does
> this. It's implemented for aarch64 only (with the intent to add x86_64 later).
> 
> Let's start with concrete examples of the result.
> 
> First, in system mode, booting a stack using TF-A + U-boot + Linux:
> - Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
> https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
> - Stat and open syscalls in kernel
> https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
> - Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
> https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
> 
> Full trace is available here:
> https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz
> You can download and open it on https://ui.perfetto.dev/ to explore it.
> 
> Second, in user mode, tracing qemu-aarch64 (itself) running git --help:
> - Loading program and its interpreter
> https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
> - TB creation
> https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
> 
> Full trace is available here:
> https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz
> 
> If you had curiosity and now you're ready to give some attention, most of the
> details you want to read are included in the documentation patch (final one).
> 
> Overhead is around x2 (sampling only) to x10-x15 (precise), and long traces can
> be directly filtered with uftrace if needed.
> 
> The series is splitted in:
> - implementing the plugin
> - adding useful options (especially sampling and privilege level tracing)
> - add a companion script to symbolize traces generated
> - add documentation with examples
> 
> I hope this plugin can help people trying to understand what happens out of the
> user space, and get a better grasp of how firmwares, bootloader, and kernel
> interact behind the curtain.
> 
> v2
> --
> 
> - trace active stacks on exit
> - do not erase map generated in system_emulation
> - add documentation to generate restricted visual traces around specific events
>    of execution
> 
> v3
> --
> 
> - fix missing include unistd.h (build failed on MacOS only)
> 
> v4
> --
> 
> - add support for x64
> 
> Pierrick Bouvier (7):
>    contrib/plugins/uftrace: new uftrace plugin
>    contrib/plugins/uftrace: add trace-sample option
>    contrib/plugins/uftrace: add trace-privilege-level option
>    contrib/plugins/uftrace: add timestamp-based-on-real-time option
>    contrib/plugins/uftrace_symbols.py
>    contrib/plugins/uftrace: add documentation
>    contrib/plugins/uftrace: add support for x64
> 
>   docs/about/emulation.rst           |  213 ++++++
>   contrib/plugins/uftrace.c          | 1014 ++++++++++++++++++++++++++++
>   contrib/plugins/meson.build        |    3 +-
>   contrib/plugins/uftrace_symbols.py |  152 +++++
>   4 files changed, 1381 insertions(+), 1 deletion(-)
>   create mode 100644 contrib/plugins/uftrace.c
>   create mode 100755 contrib/plugins/uftrace_symbols.py
> 

Ping on this series.

Regards,
Pierrick

