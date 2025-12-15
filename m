Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB506D5B85E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCok-0003oF-AK; Mon, 15 Dec 2025 12:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVCoi-0003o3-Ta
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:57:04 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVCoh-0007zH-ED
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:57:04 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so18126295ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 09:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765821421; x=1766426221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CdNgqbZgGC1qDRc3rbuIRyZmbhgMWQtVz5IQ5Opm5jg=;
 b=OEr4x7IvBkiV8F9KN5RNQ4AZtAyvzHrcRqugaQEpara4ewusH5lT9cpfBdAU1EvbiC
 NBmJa2/0iFm2QhgWHZTP7h2t3TNapfw8noeglFrrgWIB69bUe74vQKJJi8f6pSboPzRN
 jhZvrcZEjdtsnLuu/6Tyit0EjZwkXZytUV0tpL4pxYtURyO6uYu39p/u2hWcGDWER2kV
 xUGh9iPvDnmh9fp6hxBncOLRWzr3uDMXgKoUhvVttmJszVvsD2+S4aAw91+6D2Y4K7Mb
 nqFFJD/BZn4EjB8U5bvlnhRUMNy30GaG/htheqIGeuf8HUqPGn9wXgTD590qTPiwhtw1
 vDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765821421; x=1766426221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CdNgqbZgGC1qDRc3rbuIRyZmbhgMWQtVz5IQ5Opm5jg=;
 b=bNN6W97P3BjLo+qNNoMTFoMtKnJlgtdEDfBdFkGw+7fI5PUFXujo+4cKYgg8FuAgeY
 mbbW43R3kTXLAG0OCBlT/3mEyx40RpnkFwv3KoduXeikDF11juuoz3GVQFzB3xP0sN4Z
 UVzWVgSxOgfJp198bmzXp3xiFKeX1++FHmvQhqJeitsmFU+w/XGIKMqlhzme+FDGR2Jm
 t7qdULfq3NBLkBexxBpW9jN4tQXmTPpRovnVpBjBp5pxtEcADpd2QDB31SMpwdc73uEc
 JKk/fiv2YaKlWf8roZpUUyzmGtzbiw67LBIgCcQehNRqw7Tet8TwbPRgYPAoH8bF/sAz
 aeDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1d/AT0LoQVO+DNkTnRUFH5uCZzwsf9uAQ/FDJvQ3VFKYuNXduYphfFo3jCXYaic33r9fD9OV6O/a1@nongnu.org
X-Gm-Message-State: AOJu0YwafSy7jm3tg+dDIxQiz+pbIUAZH8pvNx1MisnA2ng/ftoTpBaU
 nL9Q8GIxsllnvOvAcZZgn6a71EjkL586+9sN2kfN24GuMM8oxsWk9OF9MwHUNyP9X2s=
X-Gm-Gg: AY/fxX7GNhPBP1Z39TGoDzMxVAcZV3A7yakXHz7VX/ZofWjD6/78xxLfuAFWORaqq41
 RWb9/vktSxRC5II6B2zW/lIh6Yodjnx7cRHvSDowMGi27jQKlrs36wruDVsGp+oIWNYjCMooDch
 eJS+qKOiFnaCCrz8/lNe+Z6J44wR/JE9RMFxsiln0GI1TcxXOzbN0+d9Ck1AjO78X2Ym3sjr+7U
 uX46Ffo0MMfiLhdW4wmGnam196t/1mld8P4OXXZ6eKv7RYN5NGqQpvfKV+3yevK6U4OPYHatx2q
 xP0/xYPnMPVF5NR9vIzTUU9BgAIZnedaNmt3EG//zyWEnv5E7XAO1nMmmhURRI8ys0TZuB4tLpN
 CzhqoD+MM0G4OUBr4K1Cgai5dw2lG9ATTwWVDsdJDHs7Ond5HoW3+TZdi8+VSKwexYnhxwBk6oQ
 +IasYBse/202V71fCRJKzPrJk1Dmmd+onGF2j9ko8eFIYXLPeQ1gr7dRg=
X-Google-Smtp-Source: AGHT+IHh9hH9N+naDHoARjrcrV6VPq90HXfgUjy90HAZfqj/cZiXUF63jFHBGYA9sY0LKUM3sHtg+A==
X-Received: by 2002:a17:902:d58a:b0:2a0:c1f5:c695 with SMTP id
 d9443c01a7336-2a0c1f5cf3amr60586055ad.16.1765821421411; 
 Mon, 15 Dec 2025 09:57:01 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a0993ab61dsm73268325ad.46.2025.12.15.09.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 09:57:00 -0800 (PST)
Message-ID: <e7ffbbc3-b544-4882-861a-76bee28c50f9@linaro.org>
Date: Mon, 15 Dec 2025 09:57:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] linux-user: add plugin API to filter syscalls
Content-Language: en-US
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20251214144620.179282-1-functioner@sjtu.edu.cn>
 <20251214144620.179282-2-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251214144620.179282-2-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/14/25 6:46 AM, Ziyang Zhang wrote:
> This commit adds a syscall filter API to the TCG plugin API set.
> Plugins can register a filter callback to QEMU to decide whether
> to intercept a syscall, process it and bypass the QEMU syscall
> handler.
> 
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> ---
>   include/qemu/plugin-event.h  |  1 +
>   include/qemu/plugin.h        | 33 +++++++++++++++++++++++---------
>   include/qemu/qemu-plugin.h   | 32 +++++++++++++++++++++++++++++++
>   include/user/syscall-trace.h | 17 +++++++++++++++++
>   linux-user/syscall.c         |  7 +++++--
>   plugins/api.c                |  7 +++++++
>   plugins/core.c               | 37 ++++++++++++++++++++++++++++++++++++
>   7 files changed, 123 insertions(+), 11 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


