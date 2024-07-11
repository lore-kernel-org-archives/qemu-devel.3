Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAE0C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtwa-0004Es-Va; Thu, 11 Jul 2024 09:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sRtwY-0003yQ-P4
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:34:43 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sRtwW-0003OH-1a
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:34:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70b1e536c4dso86684b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720704876; x=1721309676;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Ek4dZ23r2LNBO/HrvQd2O5miOnDgSZLlglE08Akrco=;
 b=hvI9Py5OImV8xQa//RtOai9BkVnp4pVsRkQgOBDayLAFBF6IKiT1LgUakwUCdfHStb
 L9oD5FjE/kV72X8jI7HkJj8lbqOWHN/Mk+pFi/63MbSLtm117GQnn0QBG75rJYWXX+OS
 5uE/pW9B0YhbyE+ozOqPSZtz04z0DACArOioGZjJdw2uoQVEvVFO+saWiqGrYbJ9W5Dv
 ZoIcbNSFU5kZB/iQKQnBSEthLED6ZkpsvrkpYROp/89uG0ABjL5A40Etju3XCso1UmBz
 csZB/mHuowQHLoD1YZXV/q+9ZiVDiQNaMtY29X2PAO3g2waLGKsTaQG4nI2UWfnkwvqR
 eMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720704876; x=1721309676;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Ek4dZ23r2LNBO/HrvQd2O5miOnDgSZLlglE08Akrco=;
 b=cEGhKtdUl4/MQc7TtVL6YlCIBuUK0ZrLMqhrZW88AkLRJTAgIdsdOwUD9y1Zrsg+lK
 Nzznj+lEmQabL4Lld6b2jvAluYxjgWzJMe8V6jz1rC4kozwH+jJQPM6mXRB7esNVBS5F
 OtgwMYwfcZP1QQRC1TSEYSGR+UbKzYU6LhUlz0LPxIA8VjtNWAjU1fkLrhaHNxNfcZ8/
 TLS5vq3MRJRvWzMhZrRWfVffm9arpyK2rYNIPAgbDVPdbuUrgzwHS1orzTLtxTTvL+PR
 XrjqRFgZojlqmUsUIXaWgC2bUgCJAuhvRYoosXofWchzX5OQKlGhX4opsHx/vyaBi1lq
 tBqQ==
X-Gm-Message-State: AOJu0YxU5G3vKtqwoxCE/M0JNuw8JVWv5wCd+pLemDn+uEarSmNQsiwL
 gETLPTd3SU9G/eAJjqc+quY0a4hHmaD2ohvV9y+IdifY4mzpNZg6JQ3xv1vAjggjIivbtVAUXcc
 fBMs=
X-Google-Smtp-Source: AGHT+IFtlNzB+8a0SebRYLDXCSR8h4XVoiIPrspjZGf9JrPCuoNkHOMACT6TTv2cz55ggHUfmZTPeQ==
X-Received: by 2002:a05:6a20:8405:b0:1c2:8ad4:35db with SMTP id
 adf61e73a8af0-1c3b29a0878mr2968353637.1.1720704875588; 
 Thu, 11 Jul 2024 06:34:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:bc64:3fa9:be76:3c00?
 ([2a01:e0a:e17:9700:bc64:3fa9:be76:3c00])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b439b82ebsm5649347b3a.193.2024.07.11.06.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 06:34:34 -0700 (PDT)
Message-ID: <1657b51b-243d-4607-8490-3695214da106@rivosinc.com>
Date: Thu, 11 Jul 2024 15:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] osdep: add a qemu_close_all_open_fd() helper
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
References: <20240618111704.63092-1-cleger@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240618111704.63092-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=cleger@rivosinc.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Gentle ping ?

Thanks,

Clément

On 18/06/2024 13:17, Clément Léger wrote:
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
>  - Factorize async_teardown.c close_fds implementation as well as tap.c ones
>  - Apply checkpatch
>  - v1: https://lore.kernel.org/qemu-devel/20240617162520.4045016-1-cleger@rivosinc.com/
> 
> ---
>  include/qemu/osdep.h    |   8 +++
>  net/tap.c               |  31 ++++++-----
>  system/async-teardown.c |  37 +------------
>  util/osdep.c            | 115 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 141 insertions(+), 50 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index f61edcfdc2..9369a97d3d 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -755,6 +755,14 @@ static inline void qemu_reset_optind(void)
>  
>  int qemu_fdatasync(int fd);
>  
> +/**
> + * Close all open file descriptors except the ones supplied in the @skip array
> + *
> + * @skip: ordered array of distinct file descriptors that should not be closed
> + * @nskip: number of entries in the @skip array.
> + */
> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip);
> +
>  /**
>   * Sync changes made to the memory mapped file back to the backing
>   * storage. For POSIX compliant systems this will fallback
> diff --git a/net/tap.c b/net/tap.c
> index 51f7aec39d..6fc3939078 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -385,6 +385,21 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>      return s;
>  }
>  
> +static void close_all_fds_after_fork(int excluded_fd)
> +{
> +        const int skip_fd[] = {0, 1, 2, 3, excluded_fd};
> +        unsigned int nskip = ARRAY_SIZE(skip_fd);
> +
> +        /*
> +         * skip_fd must be an ordered array of distinct fds, exclude
> +         * excluded_fd if already included in the [0 - 3] range
> +         */
> +        if (excluded_fd <= 3) {
> +            nskip--;
> +        }
> +        qemu_close_all_open_fd(skip_fd, nskip);
> +}
> +
>  static void launch_script(const char *setup_script, const char *ifname,
>                            int fd, Error **errp)
>  {
> @@ -400,13 +415,7 @@ static void launch_script(const char *setup_script, const char *ifname,
>          return;
>      }
>      if (pid == 0) {
> -        int open_max = sysconf(_SC_OPEN_MAX), i;
> -
> -        for (i = 3; i < open_max; i++) {
> -            if (i != fd) {
> -                close(i);
> -            }
> -        }
> +        close_all_fds_after_fork(fd);
>          parg = args;
>          *parg++ = (char *)setup_script;
>          *parg++ = (char *)ifname;
> @@ -490,17 +499,11 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
>          return -1;
>      }
>      if (pid == 0) {
> -        int open_max = sysconf(_SC_OPEN_MAX), i;
>          char *fd_buf = NULL;
>          char *br_buf = NULL;
>          char *helper_cmd = NULL;
>  
> -        for (i = 3; i < open_max; i++) {
> -            if (i != sv[1]) {
> -                close(i);
> -            }
> -        }
> -
> +        close_all_fds_after_fork(sv[1]);
>          fd_buf = g_strdup_printf("%s%d", "--fd=", sv[1]);
>  
>          if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
> diff --git a/system/async-teardown.c b/system/async-teardown.c
> index 396963c091..9148ee8d04 100644
> --- a/system/async-teardown.c
> +++ b/system/async-teardown.c
> @@ -26,40 +26,6 @@
>  
>  static pid_t the_ppid;
>  
> -/*
> - * Close all open file descriptors.
> - */
> -static void close_all_open_fd(void)
> -{
> -    struct dirent *de;
> -    int fd, dfd;
> -    DIR *dir;
> -
> -#ifdef CONFIG_CLOSE_RANGE
> -    int r = close_range(0, ~0U, 0);
> -    if (!r) {
> -        /* Success, no need to try other ways. */
> -        return;
> -    }
> -#endif
> -
> -    dir = opendir("/proc/self/fd");
> -    if (!dir) {
> -        /* If /proc is not mounted, there is nothing that can be done. */
> -        return;
> -    }
> -    /* Avoid closing the directory. */
> -    dfd = dirfd(dir);
> -
> -    for (de = readdir(dir); de; de = readdir(dir)) {
> -        fd = atoi(de->d_name);
> -        if (fd != dfd) {
> -            close(fd);
> -        }
> -    }
> -    closedir(dir);
> -}
> -
>  static void hup_handler(int signal)
>  {
>      /* Check every second if this process has been reparented. */
> @@ -85,9 +51,8 @@ static int async_teardown_fn(void *arg)
>      /*
>       * Close all file descriptors that might have been inherited from the
>       * main qemu process when doing clone, needed to make libvirt happy.
> -     * Not using close_range for increased compatibility with older kernels.
>       */
> -    close_all_open_fd();
> +    qemu_close_all_open_fd(NULL, 0);
>  
>      /* Set up a handler for SIGHUP and unblock SIGHUP. */
>      sigaction(SIGHUP, &sa, NULL);
> diff --git a/util/osdep.c b/util/osdep.c
> index 5d23bbfbec..f3710710e3 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -625,3 +625,118 @@ int qemu_fdatasync(int fd)
>      return fsync(fd);
>  #endif
>  }
> +
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
> +                if (fd == skip[i]) {
> +                    close_fd = false;
> +                    break;
> +                }
> +            }
> +        }
> +        if (close_fd) {
> +            close(fd);
> +        }
> +    }
> +    closedir(dir);
> +
> +    return true;
> +}
> +#else
> +static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int nskip)
> +{
> +    return false;
> +}
> +#endif
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
> +            if (cur_skip < nskip) {
> +                last = skip[cur_skip] - 1;
> +            }
> +            if (last > max_fd) {
> +                last = max_fd;
> +                /*
> +                 * We can directly skip the remaining skip fds since the current
> +                 * one is already above the maximum supported one.
> +                 */
> +                cur_skip = nskip;
> +            }
> +            if (first > last) {
> +                break;
> +            }
> +        }
> +        ret = close_range(first, last, 0);
> +        if (ret < 0) {
> +            return false;
> +        }
> +        first = last + 1;
> +        last = max_fd;
> +    } while (cur_skip < nskip);
> +
> +    return true;
> +}
> +#else
> +static bool qemu_close_all_open_fd_close_range(const int *skip,
> +                                               unsigned int nskip)
> +{
> +    return false;
> +}
> +#endif
> +
> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
> +{
> +    int open_max = sysconf(_SC_OPEN_MAX);
> +    int cur_skip = 0, i;
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
> +        if (i == skip[cur_skip]) {
> +            cur_skip++;
> +            continue;
> +        }
> +        close(i);
> +    }
> +}

