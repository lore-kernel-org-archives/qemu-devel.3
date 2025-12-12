Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49712D4921F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 12:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU2Vl-00056c-Mg; Fri, 12 Dec 2025 07:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU2Vk-00056T-B7
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 07:44:40 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU2Vi-00040P-7x
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 07:44:39 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso11246655e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 04:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765543476; x=1766148276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTw3+ZpJfWWrgcpg0P6jSoPj4kJT1ybd7v5S7q7MhLI=;
 b=UxZdenLLLXf1CC64P8ib1KpyY8ghjxUJsdo5REub56hlrYHHA/urwfbUMIHO2TSP8z
 bhhOMCMNzPZOKx500AvE4ozMdjYAvPeGr9y1ObNCplXrIJHXOHxDfyEW5XrB0Cp1bKbs
 2nSEfvBXMnmE2KwgFnGofAkflH7B65ppICngjRXGDyS+Jb26woetIzU7loT0DlPGlw0r
 EJPTntWMnUXeSLU3BkDH3wr1mLfdKqlJ/HeeKKVaNPnN/kOzGnqcBP1YyLTwID4YvNlH
 OFXfoZdzCbo4Zh7UPQn7zjY+SxEbKqmEsY9C2XU3l6fvnss11PQKZX9JDUrpR4tYUi0J
 vVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765543476; x=1766148276;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qTw3+ZpJfWWrgcpg0P6jSoPj4kJT1ybd7v5S7q7MhLI=;
 b=awjGlhqY96/xWp76dcRMGZWb3hgoqdQ57sebVGentVcJ6BKVFhSEJ/bEPL/5H/vT6h
 ixoyzYfFRpqMGIfeLdALtRL8/nyUbHN6ITxwhdvD66LGUOd20xobtA+wp3Y61LIpwzmF
 3FQG/vDQJg0/GdMyohiLvMky1MEr7Zqb73sEETM3IJfENfLO389fJSANxEecqNPS8kEr
 A8QH54JnoioLmHbW0Bsix6AkkH6KQ89IKTzsHPgcJyzsQq95ujA3WzNJZyfKbVI5hFHe
 Q21rMGm47LjYDFN1uJUEVtTxqCSi/8qh8UwdQlDOel+0Q2kCtgFJnT5SzTLJ2wjaAk5j
 LNug==
X-Gm-Message-State: AOJu0YxPfLQ4rYa4QPhLYzS/44y+oSsANVOrFq8nTqnd1SdEiun7e48r
 oHTVY6dTSbR27fzHqumV+OqSn20Alg8nxCJ2cezJzVQ6+iyBnwPZ4zLysXtEZ9jzGTE=
X-Gm-Gg: AY/fxX7qQDBHRXy1T5UJMsMVJ9yx/RMrau9grKpd6kXDcq1XOv/sxAbvHLwfdktWaTM
 mwwyFGg45C+3njmRkX8ZBQkNTYmDrFicJTCdBh4ZfhMAstNBFurkCMPp0jupA8Z6XKHdw1WsT28
 U8BUOIE0gdLkuqpwTzlNjrgGQHAfJ5s3eOblG4v8WA8LlLZmWSHzPYXvqbqww6Hb+GUvNzCLgJ4
 08JLvsGg9sHBw/M0grBTurLK1X3LLFF92fQzSZCs5J16OlAg2NgzB/cfLV1n/rlhZXGIftks+uf
 RMaucSN+PdgpH4iK2LzwZOvswqHEVm4ywTkbSeVNaNQNECvwH9WV1GMza7cUaohrrGuNnJs63pE
 17TrfWyMSf+UgiF9IxnyNhFlv5r4Wc6+zGhtk2QYdP5zquDvjkugE2Ryw15mI4FU183XGi5Lfzd
 bMA03lLDcGrig=
X-Google-Smtp-Source: AGHT+IGspiuJczzKVfI3GoXutwkghyHAqgeajPzxnGI4otXCJoXwHkbIaxkg1A+GsejJohSiUw73Wg==
X-Received: by 2002:a05:600c:3ba3:b0:477:a219:cdc3 with SMTP id
 5b1f17b1804b1-47a8f1c33c5mr24105225e9.12.1765543476450; 
 Fri, 12 Dec 2025 04:44:36 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f74b17bsm31081455e9.2.2025.12.12.04.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 04:44:35 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E4F3D5F82E;
 Fri, 12 Dec 2025 12:44:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ziyang Zhang <functioner@sjtu.edu.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhengwei Qi <qizhwei@sjtu.edu.cn>,  Yun
 Wang <yunwang94@sjtu.edu.cn>,  Mingyuan Xia <xiamy@ultrarisc.com>,
 Kailiang Xu <xukl2019@sjtu.edu.cn>
Subject: Re: [PATCH 0/2] linux-user: add a syscall-filter plugin API
In-Reply-To: <20251110133442.579086-1-functioner@sjtu.edu.cn> (Ziyang Zhang's
 message of "Mon, 10 Nov 2025 21:34:41 +0800")
References: <20251110133442.579086-1-functioner@sjtu.edu.cn>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 12 Dec 2025 12:44:34 +0000
Message-ID: <871pkzuax9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Ziyang Zhang <functioner@sjtu.edu.cn> writes:

> We have improved the code format of RFC V2 [1] as suggested.
>
> This patch modifies the indentation only.
>
> RFC v2:
>   1. Simplify the syscall filter mechanism and remove fork-cpu
>   2. Add QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER enum
>
> RFC v1:
>   1. Add syscall filter registry
>   2. Add fork-cpu interface to re-enter cpu_loop when handling syscalls
>
> [1] https://lore.kernel.org/qemu-devel/1341969682.5812455.1761115945695.J=
avaMail.zimbra@sjtu.edu.cn/
>
> Ziyang Zhang, Mingyuan Xia (2):
>   linux-user: add a plugin API to filter syscalls
>   tcg tests: add a test to verify the syscall filter plugin API
>
>  include/qemu/plugin-event.h                   |  1 +
>  include/qemu/plugin.h                         | 29 ++++++++++-----

These clash with the now merged discontinuity api so will need to be
fixed up on the next re-base.

>  include/qemu/qemu-plugin.h                    | 24 +++++++++++++
>  include/user/syscall-trace.h                  | 17 +++++++++
>  linux-user/syscall.c                          |  7 ++--
>  plugins/api.c                                 |  7 ++++
>  plugins/core.c                                | 36 +++++++++++++++++++
>  tests/tcg/multiarch/Makefile.target           |  4 ++-
>  .../multiarch/test-plugin-syscall-filter.c    | 20 +++++++++++
>  tests/tcg/plugins/syscall.c                   | 15 ++++++++
>  10 files changed, 149 insertions(+), 11 deletions(-)
>  create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

