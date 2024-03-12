Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7891DC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzxb-0006iD-5i; Tue, 12 Mar 2024 07:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjzxX-0006fl-3B
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:06:15 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjzxS-0004tP-6V
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:06:14 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56838e00367so4540860a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710241566; x=1710846366; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p7OEZPa7p6Pe7ENAE6q6rtIkEaxEOW1ji58ZGDGbUJA=;
 b=e0MMsVdT5h375SRNMZOtutvUZj0v7oSuzcBmK0i4ahec6yUhXTyZjEvukrUqc8aPkm
 q82wkID45uFHWc7d/JTpA6iUa4T+MGnn7Xgb5AT6jq1OZ9l3Tr5W6rCG4bxlAPZe8n5m
 BzIBQ7zWObpv1nz/ihkOjj9qR4329J8rInNsH8z9uxOD9TNJVYqMhaWJI71GxUXdHWzw
 E0cNx/1Ng2naWrg/P6kP2ohJ7W+iHoxeMT/tBq8SeLzEHoIIp2/KlaKg9z3YBEooM4Fi
 FTBR0xf+az/0XiT6yhd8iPbVd73MPY0D1QF9RilWuV+MWfwYwS4Ogg+qOi1fcOz1IKHO
 Gm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710241566; x=1710846366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p7OEZPa7p6Pe7ENAE6q6rtIkEaxEOW1ji58ZGDGbUJA=;
 b=ssKnqGfRnTqNqW9DziItuoJ78sjCevs4Pjl1Am4U16kTk2QOvsk4/x27PjpVDGlshM
 i8yXSXL5b1XyUHxsVJPDt7/zGd+ta2JExkn6bGwzqlhHt/WK6DSk05qQdRrAS6pxjpHy
 WecMExTDRA3rLidM8xBgt989sZTVxwLjfsN5i9q2WhIWQIuERnkDw97Xc59lq3Eht//+
 4k74FH/ouragfTX4RxZGuGeQEgzq72sJnB3U+HhWKP5dh8I/W+Ab7mmbfJEVo3BKym2Y
 vkwzN0PJqnHLyMNyBHq3C0CBiyEEzLhEBhCIqJX8lYrkmizdWyxgPF80FP/gP926YTAg
 Kv1w==
X-Gm-Message-State: AOJu0Yx9DkZNyVO5E5SRFXeY+HFTRYuemudGtI//amR4t3WLE/Mavoig
 6G8u9jpzHs1vGgD5jP/vpYISKZ6uM8GITMqgZEw0JTAVO6PM3Trpqe9E2E6LM5ENZL5Aqe8D7pQ
 EvggKx7mGdHuPrrDrG1O/m4mK4j7pOWcgwiJYJCFWGUR7al6a
X-Google-Smtp-Source: AGHT+IFU6gdUn5kV2pnxMtMY/hnnbwLilV7xcx5/Z86+abBtPbQihE7d0xZC/6QIJ1f7c2BunMPobJWSv/KKkdGcF2g=
X-Received: by 2002:a50:d741:0:b0:568:1c56:f82 with SMTP id
 i1-20020a50d741000000b005681c560f82mr2122335edj.36.1710241566750; Tue, 12 Mar
 2024 04:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240311175440.305912-1-laurent@vivier.eu>
In-Reply-To: <20240311175440.305912-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 11:05:56 +0000
Message-ID: <CAFEAcA-w87eBiYr3+jJZgRa_R1b1yqKtdCoSryREiiah0Hk2CA@mail.gmail.com>
Subject: Re: [PULL 0/1] M68k for 9.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 11 Mar 2024 at 17:55, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:
>
>   Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/vivier/qemu-m68k.git tags/m68k-for-9.0-pull-request
>
> for you to fetch changes up to e39a0809b99bbbe5f0ec432fdd9e8c943ba24936:
>
>   virt: set the CPU type in BOOTINFO (2024-03-11 09:38:08 +0100)
>
> ----------------------------------------------------------------
> Pull request for m68k 20240311
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

