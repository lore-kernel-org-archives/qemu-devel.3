Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FB6C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 06:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW8wp-0007HO-7z; Tue, 23 Jul 2024 02:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW8wn-0007FX-0G
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:24:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW8wk-0002EH-TS
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:24:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266182a9d7so34012395e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 23:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721715865; x=1722320665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AfED/y769uK7eoMyRRRpd1y0vNBFKwtZuKlaY7VNFII=;
 b=s7NSS/0p3CyybZEnTHiw860DhwxEofCjC4TGdVLN9BFKQi7wpHgmByH0a1lKyvvcur
 B9yFNPL3k5ids+bDjHijExe1C3I/a1hApIWqA8jXCFPvB9ffaff+eojMBP+H/RPMobGx
 EfswE1H9ZtMW/wOmciuqpHUCzCTpttC9oTux8PI1SlFaA0AICLDJXckZ7UY7wJyxTt2H
 /IqxbVf4E40Wn1X9myCGI5ASlWFtTd5QuyRYGbfjJ+5jNE/WTelyS9mRq3m3IB+Xblwh
 6TV0ySnjSLH7dUkWfsakglQbE0Sc17/FFyU5AaEFYMVN59fnG0CokuZrgrHLiy/RUm3H
 7s8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721715865; x=1722320665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AfED/y769uK7eoMyRRRpd1y0vNBFKwtZuKlaY7VNFII=;
 b=W3tyY5jo9qrlK+ncM82P9VNaXAbYrQjqqtvI87bDOgrsS8ji5IcA8lXBahpUvlVfFq
 t7iG2vIatL6HAoXUnXj3cZlI5hHg7xupOZ934R+TWMfG2eNCtjZtZIxHW5auE++CkP3z
 8AFlPiqSMtxNH7Wi3+YjQlVxYEA00HtNYtOFjCFjro9XxoIHZdpaIExpv2gTFqt0jzq6
 4fsJvz+1TGeRI1muvhjVaxpqIN0U8gn/RdlH5AM4cGkRrAnEAJsAoC2NpOVo9IEixncb
 m1lPA+2f9xEu/4IFvPD70ScdGZDyDGw7qRsEl27u8q1XnBTYYRFSw2J2s/9syIFIoiiz
 FciQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrsV07PXhTFIJtHXu27eGooiroKZn1ydtuK6uidCuwDWjhZ7ZSYS7u1UD0jtzXRmZaYalDiUsnmlXY+Eq0nMMjn/u3NNc=
X-Gm-Message-State: AOJu0YwW2qSTlXXSSqw8LEfbApKiLxKkrYcM4/Vuqu0HiU4u3mOkEyOV
 saPLZ9aOYL/GAGW483bWIX3Soq5UyLvEjiKEgAkEuts7MnwHQWit9wRkhX/OEcc=
X-Google-Smtp-Source: AGHT+IEdFWwnQ6jZapN0wLYqvpZaFIclVG1TZq38xHAjeFnF8sO6c4raIm4wBqxXNCYIAtfQ8TTNFQ==
X-Received: by 2002:a05:600c:1382:b0:426:59fe:ac2d with SMTP id
 5b1f17b1804b1-427daa67bf1mr77228225e9.32.1721715865255; 
 Mon, 22 Jul 2024 23:24:25 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm71381755e9.45.2024.07.22.23.24.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 23:24:24 -0700 (PDT)
Message-ID: <c2085e4c-d2af-4ea1-9a04-f523c94a7315@linaro.org>
Date: Tue, 23 Jul 2024 08:24:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] osdep: add a qemu_close_all_open_fd() helper
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240717124534.1200735-1-cleger@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717124534.1200735-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Clément,

On 17/7/24 14:45, Clément Léger wrote:
> Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
> POSIX"), the maximum number of file descriptors that can be opened are
> raised to nofile.rlim_max. On recent debian distro, this yield a maximum
> of 1073741816 file descriptors. Now, when forking to start
> qemu-bridge-helper, this actually calls close() on the full possible file
> descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
> takes a considerable amount of time. In order to reduce that time,
> factorize existing code to close all open files descriptors in a new
> qemu_close_all_open_fd() function. This function uses various methods
> to close all the open file descriptors ranging from the most efficient
> one to the least one. It also accepts an ordered array of file
> descriptors that should not be closed since this is required by the
> callers that calls it after forking.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ----

FYI git tools parse 3 '-', not 4.

> v4:
>   - Add a comment saying that qemu_close_all_fds() can take a NULL skip
>     array and nskip == 0
>   - Added an assert in qemu_close_all_fds() to check for skip/nskip
>     parameters
>   - Fix spurious tabs instead of spaces
>   - Applied checkpatch
>   - v3: https://lore.kernel.org/qemu-devel/20240716144006.6571-1-cleger@rivosinc.com/


> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
> +{
> +    int open_max = sysconf(_SC_OPEN_MAX);
> +    unsigned int cur_skip = 0;
> +    int i;
> +
> +    assert(skip != NULL || nskip == 0);
> +
> +    if (qemu_close_all_open_fd_close_range(skip, nskip)) {
> +        return;
> +    }
> +
> +    if (qemu_close_all_open_fd_proc(skip, nskip)) {
> +        return;
> +    }
> +
> +    /* Fallback */
> +    for (i = 0; i < open_max; i++) {
> +        if (cur_skip < nskip && i == skip[cur_skip]) {
> +            cur_skip++;
> +            continue;
> +        }
> +        close(i);
> +    }
> +}

Build failure on windows:

../util/osdep.c: In function 'qemu_close_all_open_fd':
../util/osdep.c:725:20: error: implicit declaration of function 
'sysconf'; did you mean 'swscanf'? [-Wimplicit-function-declaration]
   725 |     int open_max = sysconf(_SC_OPEN_MAX);
       |                    ^~~~~~~
       |                    swscanf
../util/osdep.c:725:20: error: nested extern declaration of 'sysconf' 
[-Werror=nested-externs]
../util/osdep.c:725:28: error: '_SC_OPEN_MAX' undeclared (first use in 
this function); did you mean 'FOPEN_MAX'?
   725 |     int open_max = sysconf(_SC_OPEN_MAX);
       |                            ^~~~~~~~~~~~
       |                            FOPEN_MAX
../util/osdep.c:725:28: note: each undeclared identifier is reported 
only once for each function it appears in


