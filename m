Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8A6C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYQvt-0001mY-Cn; Mon, 29 Jul 2024 10:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYQvq-0001lK-DS
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:00:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYQvo-0000oU-FM
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:00:58 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so16509215e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722261654; x=1722866454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nOFxyVUfG84Ww0QRlijHOWwuXlphgmiany5mEoCdvAc=;
 b=oH88fy9WDHjKnvbPW3cXn+wZauD5BWAcJ+lRMuBY3OOOBUQS5nXn9IPcstMRu4DaRq
 ue+awhAsLwEFJGoygrYZLd2KropSo1b7JffC5mw5Ip2gk6LzHQgGW+eSi6OstDD/PGFS
 Ft2TQqYkQFxg5amB3NZMgGByB+zFbMuNUAxhyajJkdizMgDs4HdzISit7zBYvxYrc/Hm
 IIp6KMdRrF1pv6rJEIM/gPY0Q64BlMHWDL9Uo4jFbbw1MNNTcU1YAe6tcPRHu29p9+ML
 OPPvo7bDDCrfjHC3hwDzlUUiB+sfC7NH3dfB//lTDYTDZKWEEM/JNrZ6pJs+VU19gDzm
 JBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722261654; x=1722866454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nOFxyVUfG84Ww0QRlijHOWwuXlphgmiany5mEoCdvAc=;
 b=G8Di/FvlP31t7Ev5liVjzd5Abd6cARMuk2ennEJ8c8ldr4oaw3Ft+LF+l0dm6w6Lxg
 VzrIC4WTePWrpE03y+P0XX3yPrfYKmL+jDWnvHsYbRaxeqbrBSSsMFE0FFxY8/jVmYYu
 n4vNCcF9cok2GUSjvi3ru2LKiqVNfhP3AQjAkKfSO0OeY37dHjG9XZPXWMsehix9Ttqn
 LCNnffX/JoosOsyMqs9VjIEXDlc/3jnuUSOlVn4mSbgwoREzXa9tKrs8FVUTUO+R7chI
 HeUVvo4ogXZ5EduAAyFNyjLar0YddBi2wAGlDoXEG89KHCbN0UDmkcSIf7J9zJKIQmt3
 wYvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLZ3ArCdF1XglR+rcb+JY91TqQKOfxMyFdLmFXdwU/ZMvE5GiQQOftfnTRTDiDQauoE4FWRBkEXny3xa+sF3gU0htBUj8=
X-Gm-Message-State: AOJu0YzyRk2mez9mv3MAkd1CCDKdskjpT713EgNAMOINfJRnrgnu+4Xq
 ISQSkeokkjNh8VLvihjRzeU85a1DeWg4tG8w5Ej27rp9ZNgv2yMP95mez+nDbQY=
X-Google-Smtp-Source: AGHT+IGl64P7p05VKWq0g5cZHYd+KF3i5yOhHTFJEJEyqkHoKK5Pvpw6sMmLUfV1kXVMv497A0BMWQ==
X-Received: by 2002:a05:600c:35d5:b0:426:6f5f:9da6 with SMTP id
 5b1f17b1804b1-42811dd70d7mr59515165e9.27.1722261654455; 
 Mon, 29 Jul 2024 07:00:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42809eb192csm109049425e9.1.2024.07.29.07.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 07:00:54 -0700 (PDT)
Message-ID: <0914a034-260f-44ef-8d75-2dca9d5fcb24@linaro.org>
Date: Mon, 29 Jul 2024 16:00:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] osdep: add a qemu_close_all_open_fd() helper
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240726075502.4054284-1-cleger@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240726075502.4054284-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 26/7/24 09:54, Clément Léger wrote:
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
> callers that calls it after forking. Since this function is not used
> for Win32, do not implement it to force an error at link time if used.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5:
>   - Move qemu_close_all_open_fd() to oslib-posix.c since it does not
>     compile on windows and is not even used on it.
>   - v4: https://lore.kernel.org/qemu-devel/20240717124534.1200735-1-cleger@rivosinc.com/
> 
> v4:
>   - Add a comment saying that qemu_close_all_open_fd() can take a NULL skip
>     array and nskip == 0
>   - Added an assert in qemu_close_all_open_fd() to check for skip/nskip
>     parameters
>   - Fix spurious tabs instead of spaces
>   - Applied checkpatch
>   - v3: https://lore.kernel.org/qemu-devel/20240716144006.6571-1-cleger@rivosinc.com/
> 
> v3:
>   - Use STD*_FILENO defines instead of raw values
>   - Fix indentation of close_all_fds_after_fork()
>   - Check for nksip in fallback code
>   - Check for path starting with a '.' in qemu_close_all_open_fd_proc()
>   - Use unsigned for cur_skip
>   - Move ifdefs inside close_fds functions rather than redefining them
>   - Remove uneeded 'if(nskip)' test
>   - Add comments to close_range version
>   - Reduce range of skip fd as we find them in
>   - v2: https://lore.kernel.org/qemu-devel/20240618111704.63092-1-cleger@rivosinc.com/
> 
> v2:
>   - Factorize async_teardown.c close_fds implementation as well as tap.c ones
>   - Apply checkpatch
>   - v1: https://lore.kernel.org/qemu-devel/20240617162520.4045016-1-cleger@rivosinc.com/
> 
> ---
>   include/qemu/osdep.h    |   9 +++
>   net/tap.c               |  33 +++++-----
>   system/async-teardown.c |  37 +-----------
>   util/oslib-posix.c      | 131 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 160 insertions(+), 50 deletions(-)

I'm getting this error on msys2, not sure if related:

WARNING: Failed to terminate process: 1 error occurred:
	* failed to attach the runner process to the console of its parent 
process: The handle is invalid.

I find your patch hard to review. Do you mind splitting as trivial
changes? Something like:

- Expose close_all_open_fd() renamed as qemu_close_all_open_fd()
- Rework qemu_close_all_open_fd()
- Factor close_all_fds_after_fork() in net/tap.c
- Use qemu_close_all_open_fd() in net/tap.c

Thanks,

Phil.

