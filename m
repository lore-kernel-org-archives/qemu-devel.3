Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95C1E6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 22:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmfr9-00028Z-1Q; Sun, 01 Feb 2026 17:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmfr6-00028L-TD
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:23:44 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmfr5-0007Sr-Dc
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:23:44 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so3540761f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 14:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769984621; x=1770589421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UHlij55eGJTGKQxzT0LRhKfCC/FthHGFdTZ/C+PfrxM=;
 b=Mz7A57+fqBzWz2hbWd8CfMoWtGh++wVg5zPaptfGO8rVQkB1UGMG3m2JyGfZYVdj/9
 V00c0yehefcRcqzMYeLnCJQhGT1IJtmLrg4fhijL6vcKNVKCkYb2OrKYcUfF0qtjHH0j
 emiVNI2uVtILODeuTZAFi1izLjeQd9eU97mu/BHHLioAt2sQAhJLsG4lbdwJgZHU7l1p
 5JYJlOqd/4zNdWfQPkjlNrzPr+575AFl+isK2oH/idjlxj+zoEA46l6PIXjK85aZyv9y
 D18ltvCqb4+36aIQPidPsAophV6pYzr+K+zYBWdg6E0s6hC0EK5qBiOnF7QU0tWFLmd0
 mcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769984621; x=1770589421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UHlij55eGJTGKQxzT0LRhKfCC/FthHGFdTZ/C+PfrxM=;
 b=LECecrrYkyAFUOQpabVNYRSiBoGlhZeuEINdTsce7ylvAO0XasRUlJX2AGwKa/MW3L
 kpbAlULRiUobIO4+mpBLOV5d4BHqTdys8HYugcFnD9f2VFyMB/IUl97IH223XkgTmFKT
 T+pLxCaNtxuZ6snVLWnPdGqKPDEHVC+LrskCvznnwmICv/x7dOCJ9f+r7lMVFoHXL94e
 mI7Anr2Z71cxpdCMcBxVPVgd7AzJfxFny/JPWZfBFyi5A3RbpyTNwqv3Di5hDlz+EupX
 xGfq7NWrVx5DDgtQaHAjS/UR94Oh3H4ttetgI79FUo7qanA4vBai3ew4HQk6Z9Dx3x4I
 mSkg==
X-Gm-Message-State: AOJu0YxQtYNTK6nLnQqzzwf4EC3b5maBOKiTtac69cTXTEsd0FCFD+is
 bKvrn1TGGqXkNEgUqp8z7nWGxD6Fz9DzZA4z1BjspUGYFGmTV+TaDXlkuiM6ax//yb/nnRoDTUw
 jIUVWfq8=
X-Gm-Gg: AZuq6aLCQvcH67X+XLFb68GEorXQaBSLTCQ1/JndELe+9e1hfkLu9E3FL+WZpRIIpuq
 lFuzDUN8mTek8DLk1qrKAiE8dTwwRq0rNq/ObZBAxup8hdpG1peJaTPRyY0iFZnND+ISPVL0esX
 42wrh/H2xQWIV+nQKmN7C6hdvSZsfXpbFXVbN5/E52VB9kYMSJvQWEb0Qy4zDmGyTf9sgjm4nfW
 waLE7JXrb6UksOjPIfCyeedk8hBv0L/HqTmVekQDuOAaxonAcO2qSgM0s0Qj+L5UaVQfkvl9YUU
 0lKXVVTOft9lqQQeQnquUq5Zjrh3huC4W69y0X8MZ/j34rnT4ydVztK6oJSbii4Kl0EhOvgPpU+
 L3XwbBb/TWv9G1jt2Hq9GMGbhvjIw/KwYJ9ZVWH9Ypvwi99wuS2nsMMeY6TqosuKzGraGKaZU+W
 y2HBVQzqS1xdEn2dTi+k2+RnScFuTbZCUy2nRFP7bSN7NF5kHnIj+GVw==
X-Received: by 2002:a05:6000:4285:b0:435:add0:3d77 with SMTP id
 ffacd0b85a97d-435f3abb2d8mr12470410f8f.55.1769984621354; 
 Sun, 01 Feb 2026 14:23:41 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce93sm38151108f8f.24.2026.02.01.14.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 14:23:40 -0800 (PST)
Message-ID: <6c7ed2e8-0af4-40d4-8c2b-f12a2716c547@linaro.org>
Date: Sun, 1 Feb 2026 23:23:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] tests/unit: add unit test for qemu_hexdump()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260201221328.72111-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260201221328.72111-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 1/2/26 23:13, Philippe Mathieu-Daudé wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Test that the fix in commit 20aa05edc2c ("util/hexdump: fix
> QEMU_HEXDUMP_LINE_WIDTH logic") make sense.
> 
> To not break compilation when we build without 'block', move
> hexdump.c out of "if have_block" in meson.build.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v6:
> - mention commit 20aa05edc2c in desc
> - wrap long lines for checkpatch.pl
> - use g_file_open_tmp()
> ---
>   tests/unit/test-cutils.c | 67 ++++++++++++++++++++++++++++++++++++++++
>   util/meson.build         |  2 +-
>   2 files changed, 68 insertions(+), 1 deletion(-)


> +    /* We expect proper alignment of "s is" part on the second line */
> +    static const char *expected =
> +        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 68 69   "
> +            "Hello World! Thi\n"
> +        "test: 0010: 73 20 69 73  20                                      "
> +            "s is \n";

BTW I chose to ignore this checkpatch.pl error:

   ERROR: unnecessary whitespace before a quoted newline
   #90: FILE: tests/unit/test-cutils.c:3686:
   +        "s is \n";


