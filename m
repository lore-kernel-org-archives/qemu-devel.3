Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F61606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xQ/mEngc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQV8-0003Fq-C3; Fri, 06 Nov 2026 15:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xPQV6-0003F0-TJ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:25:28 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xPQV5-0006yy-9h
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:25:28 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e8da6ef7ddso6228965ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 12:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793996726; x=1794601526; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iyLrLh/KEVJBiZwmZGxXhHhOmRBJyYAgUokztiTF5ME=;
 b=xQ/mEngcg9toMxCR/XJD47nkvf7GAMpL4zXk7LyS4WbkoLYKx2ZEw0senXI5IqonIR
 pL+HvjqVF4gfTeX6vkDXteQchjmVcXmPi5WkxgfrsM2Hq+jb6gZhGgfZlGWqmWwObnfV
 yKmDtEceXBHj/cZyYG1CkwIp0F4YbbhD7kGdVwPUlpaJLuZfqxFru6ZTqPVvlyI1Y1cZ
 0GZvc/7t9AaqHWQIt/mwO4lvp09ucHKHzz7fFrggKa8dBWMIzcDmAf8+eXuMn/2+q2Zw
 ixvcpNMAigMQm2gIvuhGp1y4ZgP0m91X4aM6VTbKbRXX+H1eQxDOLizfGk0YJIIGhd+q
 wBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793996726; x=1794601526;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iyLrLh/KEVJBiZwmZGxXhHhOmRBJyYAgUokztiTF5ME=;
 b=eRshLISPEj5ORU/QXYjq5bTOdu6NFgwDId8QyGENGXVpHnbYzM6m2b+GxsNwGuKHlY
 Zv7K+iHURK6ob3oUIuaJY24TwHSUsRFnGCVStAFOwRiIHlJuienmWbyxK77v9lz4INaj
 /uei9YKcSY3DKXb8PP5B5wG6KEMpMkVHUKFARxc6mjTK20ebGm4h6svHsMvmvH8XwIxG
 r6Sk9pY5J3d6Ws8becjrJtAmW7I4jyoovJn/wV2rJ/DvQHXEBO6jrPX4cdbGr/po0VlT
 2rvYlcgZ1YHdjbYc4xbI4K5HYtxO14PMgbF5jypPJgRzgzCtNkiaxwVVXrAJVnNS8PoO
 ZJ3A==
X-Forwarded-Encrypted: i=1;
 AL+hErH2W047ftajKprWHOB77mpQUxxd7zSHk1q0ufifGKjYN+uwfjDBSu9PRP13pvvEGi4k3QtSwq14N93a@nongnu.org
X-Gm-Message-State: APuU4Z8Xu+prY8qUZhfugVThXrQY0HRS8F0tvj/mMioF7bh31kmOdvav
 zpZ5sTkeYsaBF9sVdGa0iTdSBghk+GxZpb94ErO6+MrQATNSl4/StAqoDkD7bM+HwQE=
X-Gm-Gg: AYBFou1Feh+LLs3taieq4440STM2eYTl7a6CC+kKDYxWZTxeY2W2b5S0xWn5o0c/F+R
 1LoXe0CkBkINoyUuKFHo0zjn/h4pc7S9Oi95UCyXTws+fUmcrGp7884jT2n8Jp0R+0Lr0avZSew
 /zc4do2gN+US3y0zF+wQId+ZpYj5qZYfHnD9IewdzPJ0cZLy+4qQdTSJp7n6fXcWjcfRz2BlKXq
 qS7UK2td92BiISgcG00xYNk1gntO1IzU41frlbQ06ghwskqf4xpabxNRn30ugMtNandowBcHnNR
 QWuFg1zzA93vT14XUaz2YWrZN2XuvMWYwQG5kN0hkAmc0tJC+2u2q4pZpLw0vGnsBPpKYaIfhqH
 JbKlMFisn3R4tNmttJD6gL2G+typ4un4v+IXSDxKX+a/cQqGLXx1r0LwgC9uoqiUbyhkV/Utp5p
 c/qM17IhW0X+oMna4j7CSIMsWizK0qtcl2xBh2k3vXhO/Y3PdsqdKPP5xJW6QYT2dsshbqAQVwQ
 3s/9cvtMKX3zGz0Va1BR8dCpNdmZ1Y3voqNO1WDWagEVL3B3fENcclqxNcCUC+BOWGWDINzVZOb
 xCLwCp1hc7uVD6AFjlS1ONPPsymdjy3l+MZkHzkfKAUZkbg9ZYZitp0lYDtYo55b2TLl/Q==
X-Received: by 2002:a17:903:2b0b:b0:2e2:e3aa:7a35 with SMTP id
 d9443c01a7336-2ed40c96724mr46875935ad.36.1793996725599; 
 Fri, 06 Nov 2026 12:25:25 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47d5f2d7sm8759015ad.52.2026.11.06.12.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 12:25:25 -0800 (PST)
Message-ID: <40f21e15-803f-49fb-8faa-dbab10bfbe7b@linaro.org>
Date: Fri, 6 Nov 2026 12:25:22 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Linux user next patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20261105225547.12848-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261105225547.12848-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 11/5/26 14:55, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit f71afb409a87c4ecd0f9d63a5963eb645dfab780:
> 
>    Merge tag 'pull-loongarch-20261105' ofhttps://github.com/bibo-mao/qemu into staging (2026-11-05 07:24:53 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request
> 
> for you to fetch changes up to fadeabfa77834f7f0e5150bea30c6f0e52dc2b5f:
> 
>    linux-user: report EFAULT for a NULL sysinfo/getitimer buffer (2026-11-05 23:43:50 +0100)
> 
> ----------------------------------------------------------------
> linux user patches
> 
> Two last patches from TAKANO Mitsuhiro for linux-user to return EFAULT for
> getrandom(), sysinfo() and getitimer() syscalls when called with NULL pointers.

Applied, thanks.

r~

