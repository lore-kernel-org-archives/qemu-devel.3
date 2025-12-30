Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC70EE4997
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 18:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaeFb-0000cI-8M; Tue, 30 Dec 2025 13:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaeFU-0000a6-Ep
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 13:15:15 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaeFS-00057R-LX
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 13:15:11 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so16412765e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 10:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767118509; x=1767723309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qoGdiFHwOT/FBKC6+5EUIpFSHuiDOLXjnqJtpWquYMc=;
 b=Y3Bzl1AbZ2FM0i6qZN/mTQy4mMzY0ZPlRrg1KdznKajE6nyLTXNJj2Rv9QoCPiq7Hj
 5sZ/W/o1PjbYFQxdq+amjaoAQZT3/uAFzGwInT8EZJzB80EHGN8LqRR6mJbFKjIjKZpC
 FFs82srxz9AO8KsUda+2tm66BcjdEjbhY55uBO+oqPrc+98mjYoA8WE8gnOBrNzWDkGC
 JIqSmyqC9hrp7gDVsb5dLTqnQ2IxRDIcgXYATJx8AKE7sXp2O9o0M5EYHgrB8tMmherK
 LYGCAHStE5iLcarkLWo8SLQsOU49vl/hQxzfi+gSZV0acBGT++F7A2fByeCRiGsIwxaR
 uj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767118509; x=1767723309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qoGdiFHwOT/FBKC6+5EUIpFSHuiDOLXjnqJtpWquYMc=;
 b=s5neb/Wc0U51GpUZxxoLiAlddMwzEMyTEnIJSykK4LL+zJMuNADECcp3EVdB5iIIcd
 AGV2Jx9a1GaDRfMjkmay206S5zgSPp5XOkcWynLrao5Xzjw0COes2iem67o0u0O7S2Du
 rMUnvndW9eo1JlJ501CuPolu+Lk3HYbUtkQs4oZnQM1GLiJzKyHxvLutYYI2+QPZaY6P
 ciRLUkqNeMTm/bOb9ethR8sjYKXg0yxW9dBTZLr0Whfh2jn3P4/xZF1QzG/sNydEH0R/
 YWOYTePvZyP3TNgtGXNCsZ511ySOBNVa3un9TghGZozikuUIyfvJ8BQYkyHh7jvOuSPS
 HYmw==
X-Gm-Message-State: AOJu0YzhiE2zYPHqn2rpTqGXkHLRWnY9QaeUc6bPpAuTnv8NNr+OMf7+
 v1KT+NG/JDbsyqGLyHfWt9RngHOxVfg+3NtWoXXm2XisoznygDpHulSvV764hE2klWFiscfXIHn
 xx80ncGw=
X-Gm-Gg: AY/fxX6YdQ1wWtlnTTGtE3Wy9Vt8UxdOr9MpuxZBNpIaQ/0FzX72ZjSKrd1o7DD732y
 1sdP1B0hq6fprSS9Iw7UfmqzI/izKydJC6ZJYJ8+iYdEpS3SsRpExEDlYMkLAPhoJ1NNCA6R/Pc
 4akA0d377LFu1nO8ctDeI+Yt8YwMpEKtWh+3/klJHjTZk1p0vG+Z51k4PT22GnDHzzbSHSm5Xis
 BDV6WdcGTTJLa/LEBL46wCs87vIdtCdw964/GnsZjwIcCAywzVzdC0FmItRWU3U18fUW/DRqAG2
 /BAUicfXjvDp2mqCJ9j0Be7xBWsobS0oyjrPG/9yi/5SNs1wjKWrWiHa2JqpG8+Abr7l40rTCNg
 HQwix7VP5I/z7SZiomOwtl9obLNgh0snGjVkOmwvsCnYZQP5DaTN0kPr8O/8/2xCV70TkPLI0ce
 gbY1GzMvmhDIdicUoGM0XYVUp2RWsZ4m5gGE2S3AgBWZOVUV31CTEpUw==
X-Google-Smtp-Source: AGHT+IHxFfxC/BQKOXyzbuW60QslPMIv8uYbUzaBIANlhsKNbOQ7frF1hTqLJ4uZaRXacHdQNkEDtg==
X-Received: by 2002:a05:600d:101:b0:475:de14:db1e with SMTP id
 5b1f17b1804b1-47d1957b7c8mr283347945e9.24.1767118508189; 
 Tue, 30 Dec 2025 10:15:08 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273e4d5sm662919445e9.6.2025.12.30.10.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Dec 2025 10:15:07 -0800 (PST)
Message-ID: <3e835ac0-6d93-4bab-9024-9e99587beb3e@linaro.org>
Date: Tue, 30 Dec 2025 19:15:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] monitor: Merge hmp-cmds-target.c within hmp-cmds.c
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20251229231546.50604-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251229231546.50604-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 30/12/25 00:15, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (7):
>    monitor/hmp: Replace target_ulong -> vaddr in hmp_gva2gpa()
>    monitor/hmp: Make memory_dump() @is_physical argument a boolean
>    monitor/hmp: Use plain uint64_t @addr argument in memory_dump()
>    monitor/hmp: Remove target_long uses in memory_dump()
>    monitor/hmp: Inline ld[uw,l,q]_p() calls in memory_dump()
>    monitor/hmp: Fix coding style in hmp-cmds-target.c
>    monitor/hmp: Merge hmp-cmds-target.c within hmp-cmds.c

Series queued, thanks.

