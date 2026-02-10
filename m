Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC01EB2700
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpule-000327-LB; Tue, 10 Feb 2026 15:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpuld-00031z-Qh
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:55:29 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpulc-000795-Dm
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:55:29 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48068127f00so12492175e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770756926; x=1771361726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pjYxSrPd8M75NsoDn4e1sRhyz8XNSbFENSCfgcqMO/g=;
 b=o5lT6vSklRH9Pqo+92A6UKJRzjJJGvWyHPCfhuymxDKtK6eDYoyrboaowBui9/1j/x
 J5JXC1t4eULHTGAXMQzCdANi1VtfVZ7PBUP2QkT+4eysXAXf2aLNhWF3Av2TBIBlGrfg
 u4X8Dxjb5Vs2KP/Lr41WVOBQ/3EBN9zZ0USemwyYCnMZITUHp9ttSTRmqSwCbeOlqSHX
 6ECtH1IZEeXCZveSfQJnDn9Tvjvw3o0FHeWPdT+z+xqhjPjL0EFwOavesqeC/3XKwdfN
 tIH6h578ExjVSiDwTB8hIaA67lHQHJQac+2VNzEk+3tx8wOcMkylaSHGWvSFr5J+gD5Y
 EtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770756926; x=1771361726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pjYxSrPd8M75NsoDn4e1sRhyz8XNSbFENSCfgcqMO/g=;
 b=PJguZid91MHiNd+SVGGYUnssgpdJ3j7H7MiWU006M1z2gUrR97mYGYHiJCjHR35Zs+
 goMdO8/mvxJWaidlyWZdYdJSRI52rAcQJKbxKkGBvxmoJancHJVZiq4p0TsJ5T+IzdkL
 vflcxFlMno+aZNaHM5niTG+TlV6TO50S6KiGEcKpvzfObK+H53SZo+x75XTuqdNT6jCh
 zTbX7i3+uadsIcGUSamOV8cPVGVxmhasbrLHVPq5F2bytyxW2guQVuGnb/lJUp3+NztK
 qa+sQm344cw/gEmFFlFZg2cHeATDNWI0T/xNQMNmSXBmIbw/Ht0+kYoZ5n7rv/OhpaYY
 q0QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkSuCpez2ZDoIkWqx1O7LZUiGPoZx3WRSaxw+3L5wUOi6IeGP24XR1WB8JkURUpIsFImERPwCmGIsA@nongnu.org
X-Gm-Message-State: AOJu0Yz/C6CrZLK/pwSyXY8RwGjbzyAHIzMPKt06SAjW+dDHRw8Dc0OY
 VqAmhRj6Q5OMkJzoepOLruJGYyKLh+/3edpiyATfXPUb8G+jFS785tH4n40qZgqMue4=
X-Gm-Gg: AZuq6aLIcrZVuTY1Y6SHwY/SpVokD6vfmdFW7iwWrRsjSCwDyYCB8hQ6CgRA9M24p/q
 rybbeu7bg4rHJfccwwYeYHOnwQb7mGlqLgsih4RkyhAyi8O+RCBz9dEGMnWCPtlyoCFSxrq4lcn
 Ejw+/Jb3+696GIw8DJdCRENhDYap8Yu9Lpv9KiHV5yI0X5Bm3IG37OckvqPyxUR73RhZ0bPXezg
 ztt5VR8vhDuhfEX/MB8tfsWqo9IVFrJ0ThfJVXxfioi0lDc1iOgdrQnwJsdAYrbHIiIB3EpjHnZ
 GddAEhzdY5wNu+h2QwGMcnzZp3qduoEZ4Rzbne5VBMmiXiJlN6/6WtxA5A6EKtaUTkLyScTA7lZ
 IwQQ1TsXN0D1hkRswjr+7cLRw6pN+RPuav7JfclVaauV2wBaAbJM+4st73LRYMaQ18+40B30F9B
 rJN6pE5i6o7dtDui4lXdSlC07883tIgDQb9HHsj7AVL/sN1yRHSxYrv16Px5OFF6E=
X-Received: by 2002:a05:600c:468d:b0:477:fcb:2256 with SMTP id
 5b1f17b1804b1-4832023126bmr260930545e9.17.1770756926225; 
 Tue, 10 Feb 2026 12:55:26 -0800 (PST)
Received: from [10.123.89.66] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a5bf1efsm8168905e9.0.2026.02.10.12.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 12:55:25 -0800 (PST)
Message-ID: <22dc2d00-2457-4fc6-af7a-cce4bbb38cfc@linaro.org>
Date: Tue, 10 Feb 2026 21:55:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bsd-user: Remove the openbsd-specific code
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
References: <20260210-bsd-user-rm-openbsd-netbsd-v1-0-8b8b0f50c29d@bsdimp.com>
 <20260210-bsd-user-rm-openbsd-netbsd-v1-2-8b8b0f50c29d@bsdimp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260210-bsd-user-rm-openbsd-netbsd-v1-2-8b8b0f50c29d@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 10/2/26 16:06, Warner Losh wrote:
> Remove the OpenBSD specific code form bsd-user. It's not been maintained
> in any meaningful way since it was introduced to the tree in 2008. It
> hasn't been connected to the build since 2021, and last time (in 2023) I
> tried to mock-up the meson support it needed, it failed to build. I
> contacted the OpenBSD people in 2018, it appears, and even at that time
> they tought this code was not at all useful.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/openbsd/host-os.h           |  25 ----
>   bsd-user/openbsd/os-strace.h         |   1 -
>   bsd-user/openbsd/strace.list         | 187 -----------------------------
>   bsd-user/openbsd/syscall_nr.h        | 225 -----------------------------------
>   bsd-user/openbsd/target_os_elf.h     | 148 -----------------------
>   bsd-user/openbsd/target_os_siginfo.h |  82 -------------
>   bsd-user/openbsd/target_os_signal.h  |  69 -----------
>   bsd-user/openbsd/target_os_stack.h   |  56 ---------
>   bsd-user/openbsd/target_os_thread.h  |  25 ----
>   bsd-user/qemu.h                      |   8 --
>   bsd-user/strace.c                    |  17 ---
>   bsd-user/syscall_defs.h              |  10 --
>   12 files changed, 853 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

