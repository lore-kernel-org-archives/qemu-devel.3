Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A904606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kTigs/J7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNZo8-0004v5-KU; Sun, 01 Nov 2026 12:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNZo5-0004uL-Ob
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 12:57:26 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNZo3-0003th-Dm
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 12:57:24 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cd5c9e52398so995639a12.1
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793555841; x=1794160641; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kPCoufGABZV1JjVgWGoZXXAxbJCakER03TORpeATVNo=;
 b=kTigs/J75FWn7xccimb5GYHiFGY0J47NWwy5fEEmyysyqDATObQ7PxW8f29RjdU22N
 q+HlsX0amJZN/cuVk387ZxcJj1Z2IvR4PDmSbII++z5zZiC6AGUi3kQsulPBOGrXwxFV
 tHXSXfosMpoUhMmGVhrGjJXIAbclabOOYzHkjkO8jBCD7Xj9bBIWV6Yh5LZ95auYdMHU
 DNtgoeBkJdpIO6Rzal0AJ5P+QpzxgP+TJrHAH4LWDhfm7JMBn2edoUboK9kM2jUQu42O
 iKpz31mU38mcPODe1abMopTfdV92iNDxUvJFzIq0pMSizEzwNiVucW6jiBHnkK4W+hff
 xG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793555841; x=1794160641;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kPCoufGABZV1JjVgWGoZXXAxbJCakER03TORpeATVNo=;
 b=W4HzlO5jOujzVNPlP21QPB4/1b+Xlcs8WJOE41mAY0EVbB/WpUpgO0SxvbLRj12aPi
 0BjjwA6YaI4Kx/N/2QpmccMWQffZ/3cAh5L3vTYwX6WUFRMcn4Ce6PGCNGlt8A5qW0R/
 zgggCevKsKrCuTfbfn7VYvTtrWsHCaS0dY/hlyHKV79+H6uH8Z6j9o4gfPhGaHaKxW8Q
 9jVmoB4P+o4/p8sOWiLIiRbQIuxMikGOPGq0dez3McZOrPJ+yxa6b4AnHhGMVd+9Qs7D
 zrLOsVjAzc1PsqtWzUTrvec3nLddfLv1P0QGzsjsPCXctoSDhzWQ/rA34+wEXh6pz+rk
 1dKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByP1Np3cBTzPjRIAKO3+BeqPgl5tfajIgkjfEr3nGwCQrc5qibUTe09RrFJ2GShWDjfIoH8JVZi0aza@nongnu.org
X-Gm-Message-State: APuU4Z9/2vfTLJoPwq2isYioYHgYXcJM7i3Kd0c6QPdlguQb1+sIL5/b
 lrYHI1owaWvMj28P98jJbEs7n5DF7rjrLtJZN6tpl4z6XkVbw2teDHkJ/iVRbA1pQzY=
X-Gm-Gg: AYBFou2Jt10w5nogwA5TRuS/rQ8uUz267PrM3UMovFdLUC1FFiVqANsfURJHd1A+kEa
 8fnKm5rzwzj4EjM7VMRabiJMXJ6tT3NB1tyDM+WP0mg5b1GHnx3aZC6HMWUfJnJTaVH7yYTBVFQ
 sjy8t1fNmazmG3rLHDbMULXhOaFxtle7pyhusyT0qpzxpfvcVuX+AYax2M6KPL8ni3aXbSRAuA8
 aSnj0p/2otHIxR/yUcYTDvABQwSeTE5qE+FixKE/gzlos91GJ6RWHRj6crn5UUeSr3DH7bWVRS9
 MiMH48LoqFIP66V4eEvp85GtGncw/mlaqrLJIRt2nIg1SFVSJAJ+TmlBdS2uTANmxC+6jHvtzSW
 yTQBkWcgBLjmjNcWY1nBtcdoLa3FdrWPcH1LtdIaZY99hJBXN9VgYm8l1WUZEe++6m4TF7eb5ES
 +U5kX6qpYkkYc718FLlLXtcfEsI4a/rUXRq98JvTxOhxOGr0WN7iEXb5L1dt6g+dzdetjRttztK
 2ObkaAXLJiUcnwE9ITzTh3y140EZcrX5oXrFy1IQ53W7UnylZ1H3XitmqHU8W+1mnuJ+gumezXT
 R95d7TRmbz8EPiX70ptELzq2+Qx5/Q4+yijDl5MMHceeaU2Q0cgokw4z8EMow0+W7Qch25I=
X-Received: by 2002:a17:90b:184f:b0:3ac:83c1:2c0 with SMTP id
 98e67ed59e1d1-3ae897e06efmr6244611a91.64.1793555840423; 
 Sun, 01 Nov 2026 09:57:20 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae87f5dcc3sm6441574a91.3.2026.11.01.09.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 09:57:18 -0800 (PST)
Message-ID: <94812fe8-954c-41ae-932a-c18bfd5747ba@linaro.org>
Date: Sun, 1 Nov 2026 09:57:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 0/9] UI-related improvements & fixes
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20261101-ui-v1-0-8af305cef69a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261101-ui-v1-0-8af305cef69a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 04:06, Marc-André Lureau wrote:
> The following changes since commit 33eb51c859834f2024090bf843c69814267b6c26:
> 
>    Merge tag 'pull-vfio-20261031' ofhttps://github.com/legoater/qemu into staging (2026-10-31 16:52:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pr-v1
> 
> for you to fetch changes up to cfe14e550370100ebf27cfeea65f6b1b1e11004f:
> 
>    io: report a warning when a file channel is created from a stdio fd (2026-11-01 16:06:27 +0400)
> 
> ----------------------------------------------------------------
> UI-related improvements & fixes
> 
> - clipboard: add QEMU_CLIPBOARD_PEER_UPDATE notifications and guest-peer tracking,
>    and factor VNC peer registration out of extended clipboard support.
> - VNC clipboard: implement ClipboardAvailability so clients are told when a guest
>    clipboard peer appears or disappears.
> - VNC: stop losing updates (stale pixels, stuck client) when a queued job is
>    dropped by a display surface switch.
> - D-Bus: send a whole-surface Scanout before the first Update of a new surface,
>    with a qtest for the VGA text-mode resize.
> - stdio/io: duplicate stdio fds in char-stdio and warn when they are passed to
>    qio_channel_file_new_fd().

Applied, thanks.

r~

