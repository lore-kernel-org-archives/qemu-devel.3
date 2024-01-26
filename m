Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70545C47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 07:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTGsw-0003Gl-1B; Fri, 26 Jan 2024 02:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rTGsu-0003GH-3e
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:44:20 -0500
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rTGss-0005on-5X
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:44:19 -0500
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mum2d-1rAukg2DEx-00rmS1; Fri, 26 Jan 2024 08:44:13 +0100
Message-ID: <ffc002d5-f648-43b8-b938-011a4a92cf5e@vivier.eu>
Date: Fri, 26 Jan 2024 08:44:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH trivial 1/2] close_all_open_fd(): move to oslib-posix.c
To: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
References: <cover.1706221377.git.mjt@tls.msk.ru>
 <94fcee0d7595865b3a6fab744982ad47715e5faf.1706221377.git.mjt@tls.msk.ru>
Content-Language: fr
Autocrypt: addr=laurent@vivier.eu; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+wsF4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +c7BTQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAcLBXwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
In-Reply-To: <94fcee0d7595865b3a6fab744982ad47715e5faf.1706221377.git.mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qdlEPqHM0E5G2NdPj/HZou9A+1DqC+d7oFHFA6XEGAQQoHhUg21
 a1mXyFSrSI1WLlCEdshjp3XaH/XZzY5lO4YS1IQXWxNdTNZDXzG59ZZHioWqWavxVf7jNLc
 48I/FcgJn15D5Ek7wIBLhqrCReO2aw9JXvGupY/SVHs8d3mOS30nunLbhe7PaXdZ7o5c+zO
 JD9qZ7anuMv9FG7mn8gbQ==
UI-OutboundReport: notjunk:1;M01:P0:Ew/G2z2fErY=;fjib96ykgTMtNn6Np8iQMxOFFZE
 1bBydeUAo8CyJTeTOlS4NzcD69WrcoPvjlygwXVvSViaj6OgeGlXIaDgTAQW5bD6pEFTmMrNJ
 Rqpd1bKD8/oYlJgipxStR81HzF8eVUI+KUgmJ8vCaQoFJWqwspHV43Wnpm6F5pXC9OXWNpHaw
 +4gNOyecONX/trS7brKk4ki8EYm3Fuo1LrZ2ygFqju2at5M0vi2aY5WmLNRBvoTx0ssWaGMRW
 Sw2Mc8H6By+bPOf2R6BclFQniEM83cjPUjeiZXQlOG3amB92HUIjRcKhD5aaxTLAj9o5MdfD5
 D52X96yQZ2DBqlesyFTMOebeaknpxK6uB1urrkzrmhGg5VRGOZ8RnXy3sC4StSE1MrcGcRqc1
 NQyclHZpNPhNa8T8eZMQ32RcJ86XA4XNxQqdbLXHjcAGyJD1ljlbt3BhQdYkuJARidPPs3Yio
 mRD++vLpVY64Cr9Vsd1l0JbUqXS2X6zfcZePs4D0hz1asQEkOuqsT1aUI394F0qTjYNYQg2gD
 lQhNPw1NwCsE5l1Q41r2kWRnGigjfbAbASOGEmX8MrbiC00AKyrVQl7lG0IrdgnjkVwGmyvIg
 8xEXzFH2unZGaZvw/jIEPXQAn9qgzpPHjE1G/whW2REI2G2yqd9mMKWXJjmO1R4NVXRzAA6/c
 iGiyrqY/B3Le2WOjT9t5hEKRoUuToXHhf+VpObnRTiIFL3IQmd6EdwF0yxa8d/+2JiOul//uv
 2BnaN61RT8WLfRJJInMUzJFI7HBXo4mmqVjWghDPd9Bqwr70Mjm7mOHaP7M4uGjaX6n9bLxgY
 TlI9Rj5kqHLBOSclOPq2Tlojve4Wpxh7jV6FVoIsLUdOBVKkrUKocvMyZ2nRMWBDDkZdoR1zs
 mz47DUG9A7EwWFw==
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 25/01/2024 à 23:29, Michael Tokarev a écrit :
> Initially in async-teardown.c, but the same construct is used
> elsewhere too.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   include/sysemu/os-posix.h |  1 +
>   system/async-teardown.c   | 37 +------------------------------------
>   util/oslib-posix.c        | 36 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
> index dff32ae185..4c91d03f44 100644
> --- a/include/sysemu/os-posix.h
> +++ b/include/sysemu/os-posix.h
> @@ -53,6 +53,7 @@ bool os_set_runas(const char *user_id);
>   void os_set_chroot(const char *path);
>   void os_setup_post(void);
>   int os_mlock(void);
> +void os_close_all_open_fd(int minfd);
>   
>   /**
>    * qemu_alloc_stack:
> diff --git a/system/async-teardown.c b/system/async-teardown.c
> index 396963c091..41d3d94935 100644
> --- a/system/async-teardown.c
> +++ b/system/async-teardown.c
> @@ -26,40 +26,6 @@
>   
>   static pid_t the_ppid;
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
>   static void hup_handler(int signal)
>   {
>       /* Check every second if this process has been reparented. */
> @@ -85,9 +51,8 @@ static int async_teardown_fn(void *arg)
>       /*
>        * Close all file descriptors that might have been inherited from the
>        * main qemu process when doing clone, needed to make libvirt happy.
> -     * Not using close_range for increased compatibility with older kernels.
>        */
> -    close_all_open_fd();
> +    os_close_all_open_fd(0);
>   
>       /* Set up a handler for SIGHUP and unblock SIGHUP. */
>       sigaction(SIGHUP, &sa, NULL);
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 7c297003b9..09d0ce4da6 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -27,6 +27,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include <dirent.h>
>   #include <termios.h>
>   
>   #include <glib/gprintf.h>
> @@ -106,6 +107,41 @@ int qemu_get_thread_id(void)
>   #endif
>   }
>   
> +/*
> + * Close all open file descriptors starting with minfd and up.
> + * Not using close_range for increased compatibility with older kernels.
> + */
> +void os_close_all_open_fd(int minfd)
> +{
> +    struct dirent *de;
> +    int fd, dfd;
> +    DIR *dir;
> +
> +#ifdef CONFIG_CLOSE_RANGE
> +    int r = close_range(minfd, ~0U, 0);
> +    if (!r) {
> +        /* Success, no need to try other ways. */
> +        return;
> +    }
> +#endif
> +
> +    dir = opendir("/proc/self/fd");
> +    if (!dir) {
> +        /* If /proc is not mounted, there is nothing that can be done. */
> +        return;
> +    }
> +    /* Avoid closing the directory. */
> +    dfd = dirfd(dir);
> +
> +    for (de = readdir(dir); de; de = readdir(dir)) {
> +        fd = atoi(de->d_name);
> +        if (fd >= minfd && fd != dfd) {
> +            close(fd);
> +        }
> +    }
> +    closedir(dir);
> +}

I think the way using sysconf(_SC_OPEN_MAX) is more portable, simpler and cleaner than the one using 
/proc/self/fd.

Thanks,
Laurent
> +
>   int qemu_daemon(int nochdir, int noclose)
>   {
>       return daemon(nochdir, noclose);


