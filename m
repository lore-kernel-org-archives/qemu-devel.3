Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D99C3DA4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 18:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRylW-0007Fz-GJ; Thu, 11 Jul 2024 14:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRylQ-0007Do-G6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 14:43:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRylK-0000O1-9U
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 14:43:32 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70af8128081so1027264b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720723404; x=1721328204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mKnD7uHsCOnK0uEPtrOfEMj/42b0yImqo7kg5+I30Eg=;
 b=XYDdy0HjER5UZcO1NXkj03r37GqTZaNe6E9AWSD7KNbPn3teXxmyuF58CGNxTVRw0J
 8Cil7JyF5Vf++Qt+m02bt1jTQowsMsFlAG5Aar+BjLB6AmXQlbleZI+AqeS79EdgphRP
 8F38H0ZJsfBL35C7SeioT5fdT8QAF82cbogTRABTwYZyOs/f2h+owMI4nAjTbAWbCZ+E
 B/u5XU+Y0/D+H4/l5Q94+KW0p4wNZcRjCwDLT0+AA6SfODvQejXKk+TW7PcNxg7KgFzB
 oHXWIIVFL6Se5ZxrQO5+sBL+KdfjgVaIxTpn7MZMGJdKJG3QLuXvZSpABO/7c0PbZ00/
 k1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720723404; x=1721328204;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mKnD7uHsCOnK0uEPtrOfEMj/42b0yImqo7kg5+I30Eg=;
 b=QzOg114sMIbsLwMxz+vWk6G/+43VXsAPeqIC7zAjQa46J5A75MbE7xZrBRFdZ+/R26
 i5FtV6qKi5jUyvdoZx4yH5E/nwzm2YFGQRAQ0gK/phLqR7QvrHnejCHegP7r6xqZsQgh
 Nw4Llr4/IrPqs3pK4y3XI80jbHPFxM5h5hLiP1uuK3aPdKS6nrie9sBDHyt86Kp5NM6k
 vuwKhkmdsQYfSU50f75CvVpJ1keDtzoUlPGgy9pKv9ll3O7DLZd4Za43gOl85z0aBK8K
 maxGPWwVuXkYMWVq/EcN+Ks/5vL1wWeaz54h70iglVfGrN2Xbd4HMcQ3tLq84oN9wpE8
 wObQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURzKVVCTGsQk6RegpZ1b2rn2fPFFxmOaYPgovN6DsT16tDMXojj2x50X+W7Ig23X0OI4L2f3w0cxIMsfYsB4u+3v6mlq4=
X-Gm-Message-State: AOJu0Ywa6hQAonhVWuFU+SzoHZMzAWmI04dIWN1GxNs7VbNIf4pGkcmB
 e6tIG67CQJddh4IuFYlb+6Hm8UefN26VzdFW1nezSHU2rzTdw1wEmEbQmcRZ8nI=
X-Google-Smtp-Source: AGHT+IGaG9z3Ag6oCE2f0HnaAFli6nSF5RXXpcm1v3CYCsaAcrkCpjA7Gn75+B98n9K5NZ8PCCQiGQ==
X-Received: by 2002:a05:6a00:4f8c:b0:70a:f65e:b13d with SMTP id
 d2e1a72fcca58-70b436320e1mr11032634b3a.27.1720723403775; 
 Thu, 11 Jul 2024 11:43:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b439b30b9sm6213393b3a.178.2024.07.11.11.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 11:43:23 -0700 (PDT)
Message-ID: <c7e1d9de-ec4a-48aa-a1f0-4903ade1bad9@linaro.org>
Date: Thu, 11 Jul 2024 11:43:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] osdep: add a qemu_close_all_open_fd() helper
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
References: <20240618111704.63092-1-cleger@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240618111704.63092-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 6/18/24 04:17, Clément Léger wrote:
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
> 
> ----
> 
> v2:
>   - Factorize async_teardown.c close_fds implementation as well as tap.c ones
>   - Apply checkpatch
>   - v1: https://lore.kernel.org/qemu-devel/20240617162520.4045016-1-cleger@rivosinc.com/
> 
> ---
>   include/qemu/osdep.h    |   8 +++
>   net/tap.c               |  31 ++++++-----
>   system/async-teardown.c |  37 +------------
>   util/osdep.c            | 115 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 141 insertions(+), 50 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index f61edcfdc2..9369a97d3d 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -755,6 +755,14 @@ static inline void qemu_reset_optind(void)
>   
>   int qemu_fdatasync(int fd);
>   
> +/**
> + * Close all open file descriptors except the ones supplied in the @skip array
> + *
> + * @skip: ordered array of distinct file descriptors that should not be closed
> + * @nskip: number of entries in the @skip array.
> + */
> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip);
> +
>   /**
>    * Sync changes made to the memory mapped file back to the backing
>    * storage. For POSIX compliant systems this will fallback
> diff --git a/net/tap.c b/net/tap.c
> index 51f7aec39d..6fc3939078 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -385,6 +385,21 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>       return s;
>   }
>   
> +static void close_all_fds_after_fork(int excluded_fd)
> +{
> +        const int skip_fd[] = {0, 1, 2, 3, excluded_fd};

3 should not be included here...

> +        unsigned int nskip = ARRAY_SIZE(skip_fd);
> +
> +        /*
> +         * skip_fd must be an ordered array of distinct fds, exclude
> +         * excluded_fd if already included in the [0 - 3] range
> +         */
> +        if (excluded_fd <= 3) {

or here -- stdin is 0, stdout is 1, stderr is 2.

Perhaps we need reminding of this and use the STD*_FILENO names instead of raw integer 
constants.


> @@ -400,13 +415,7 @@ static void launch_script(const char *setup_script, const char *ifname,
>           return;
>       }
>       if (pid == 0) {
> -        int open_max = sysconf(_SC_OPEN_MAX), i;
> -
> -        for (i = 3; i < open_max; i++) {
> -            if (i != fd) {
> -                close(i);
> -            }
> -        }

Note that the original *does* close 3.

> +#ifdef CONFIG_LINUX
> +static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int nskip)
> +{
> +    struct dirent *de;
> +    int fd, dfd;
> +    bool close_fd;
> +    DIR *dir;
> +    int i;
> +
> +    dir = opendir("/proc/self/fd");
> +    if (!dir) {
> +        /* If /proc is not mounted, there is nothing that can be done. */
> +        return false;
> +    }
> +    /* Avoid closing the directory. */
> +    dfd = dirfd(dir);
> +
> +    for (de = readdir(dir); de; de = readdir(dir)) {
> +        fd = atoi(de->d_name);
> +        close_fd = true;
> +        if (fd == dfd) {
> +            close_fd = false;
> +        } else {
> +            for (i = 0; i < nskip; i++) {

The skip list is sorted, so you should remember the point of the last search and begin 
from there, and you should not search past fd < skip[i].


> +#else
> +static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int nskip)
> +{
> +    return false;
> +}
> +#endif

I'm not fond of duplicating the function declaration.
I think it's better to move the ifdef inside:

static bool foo(...)
{
#ifdef XYZ
   impl
#else
   stub
#endif
}

> +
> +#ifdef CONFIG_CLOSE_RANGE
> +static bool qemu_close_all_open_fd_close_range(const int *skip,
> +                                               unsigned int nskip)
> +{
> +    int max_fd = sysconf(_SC_OPEN_MAX) - 1;
> +    int first = 0, last = max_fd;
> +    int cur_skip = 0, ret;
> +
> +    do {
> +        if (nskip) {
> +            while (first == skip[cur_skip]) {
> +                cur_skip++;
> +                first++;
> +            }

This fails to check cur_skip < nskip in the loop.
Mixing signed cur_skip with unsigned nskip is bad.

There seems to be no good reason for the separate "if (nskip)" check.
A proper check for cur_skip < nskip will work just fine with nskip == 0.

> +    /* Fallback */
> +    for (i = 0; i < open_max; i++) {
> +        if (i == skip[cur_skip]) {
> +            cur_skip++;
> +            continue;
> +        }
> +        close(i);
> +    }

Missing nskip test.


r~


