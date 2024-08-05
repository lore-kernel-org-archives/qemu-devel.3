Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA073C3DA64
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 00:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1salfY-00018J-0w; Sun, 04 Aug 2024 20:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1salfW-00011e-2c
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:33:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1salfT-0002SG-SU
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:33:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fee6435a34so66772145ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 17:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722818022; x=1723422822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kxTVmEC8sYfVjCF/Ppep2vXM33ocQtlVeZVJuZksTaQ=;
 b=TIZeCtI97WoeXF/AE3PkRVltLqiLrxv+QOu1JmOAAcQFUeiN80YTIaydfMCPBBByLN
 8ExZdaTw5bDamfm6cK2MrdLtSPUwNaV1M4+u6qGdoRGyl7mPO1VryjZPk3vjZUMYsToR
 sZ9Zx24gdr9ZxfxxRLVf2Q6cNXSb/fsQjEfFbsQ1BpaTOaIMKWoQsS77WcAPbi4+10N/
 9ndZ+nKrqENOpxm3bDisO1QDjAjaTUigGEwNzJl4rpghMbD2AWJDJzpL363/r76sli67
 6EwNxnUf9KOZC0Ym1+beM73UQIvHapyfKfQQLk67lCVYtlofEO/psamvrmW0UhQNKC9Y
 O5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722818022; x=1723422822;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kxTVmEC8sYfVjCF/Ppep2vXM33ocQtlVeZVJuZksTaQ=;
 b=Xh9OHBUSlCBQEkeLF6/aMlpYVJ9ERpFv3JLPEjZbINk1Mwz4I5gfiEqX7IOuIp8gDf
 1v2T+Uz/L0myEcx3eACXVwBLFIIPTW7Af3yIBO4cTN3QziuUanbIkyF1lW0L8/44G08j
 /eqEW3scogU3GSZ1qTsI8Hn5t9tLFHm91AOlWi5hLDsgiVhx8+LdgGsL5S2u3Isx9FBP
 r99o9rgrUws9ZIzHnB+RJliVyZFNziVy850V61HVvscNMu8zia2t2JQWL2m+K4qNVHAE
 5KCC350JIOoNCAkSCzS/Eh5YeOFxdY69gOA3rbsSpDLAR83dO11pLVZJvpTJoz8+EH1h
 pK6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd7w6jnZp8uJJgMZDw2F5cWrkZ6XDqYkCXMFGNSArgk+6jhAMAn92okofTIOXV3aETPtvIpkU/5cukwtHQ+C9yNHDWCFI=
X-Gm-Message-State: AOJu0YxTtYYROtqJPXEpPvsctTplbyl9REYmDLG8PKCHYmR4WSx8GFKs
 g+4SoG4T3l0x5kA8w8JEtOu8FHb3K/+ldw5MSArhle0X2ufvrgU/a5pXUekchlo=
X-Google-Smtp-Source: AGHT+IGaEpZ8WKBFgvHSUYxX82519MxazVVWfi8HdSm2fNTkH6tbuOZ/BteFxb6o9ljaF6LPy2DDSA==
X-Received: by 2002:a17:90a:680d:b0:2c9:a56b:8db6 with SMTP id
 98e67ed59e1d1-2cff9559125mr8654876a91.37.1722818021971; 
 Sun, 04 Aug 2024 17:33:41 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cffb38d3besm5636146a91.54.2024.08.04.17.33.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 17:33:41 -0700 (PDT)
Message-ID: <8f4653cd-93c7-4797-8a56-974c1bda7e32@linaro.org>
Date: Mon, 5 Aug 2024 10:33:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] qemu/osdep: Add excluded fd parameter to
 qemu_close_all_open_fd()
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240802145423.3232974-1-cleger@rivosinc.com>
 <20240802145423.3232974-5-cleger@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802145423.3232974-5-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 8/3/24 00:54, Clément Léger wrote:
> In order for this function to be usable by tap.c code, add a list of
> file descriptors that should not be closed.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>   include/qemu/osdep.h    |   8 ++-
>   system/async-teardown.c |   2 +-
>   util/oslib-posix.c      | 106 ++++++++++++++++++++++++++++++++++------
>   3 files changed, 97 insertions(+), 19 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index de77c5c254..4cc4c32b14 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -760,9 +760,13 @@ int qemu_fdatasync(int fd);
>   /**
>    * qemu_close_all_open_fd:
>    *
> - * Close all open file descriptors
> + * Close all open file descriptors except the ones supplied in the @skip array
> + *
> + * @skip: ordered array of distinct file descriptors that should not be closed
> + *        if any, or NULL.
> + * @nskip: number of entries in the @skip array or 0 if @skip is NULL.
>    */
> -void qemu_close_all_open_fd(void);
> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip);
>   
>   /**
>    * Sync changes made to the memory mapped file back to the backing
> diff --git a/system/async-teardown.c b/system/async-teardown.c
> index edf49e1007..9148ee8d04 100644
> --- a/system/async-teardown.c
> +++ b/system/async-teardown.c
> @@ -52,7 +52,7 @@ static int async_teardown_fn(void *arg)
>        * Close all file descriptors that might have been inherited from the
>        * main qemu process when doing clone, needed to make libvirt happy.
>        */
> -    qemu_close_all_open_fd();
> +    qemu_close_all_open_fd(NULL, 0);
>   
>       /* Set up a handler for SIGHUP and unblock SIGHUP. */
>       sigaction(SIGHUP, &sa, NULL);
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 9b79fc7cff..2636dcd1e0 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -808,11 +808,12 @@ int qemu_msync(void *addr, size_t length, int fd)
>       return msync(addr, length, MS_SYNC);
>   }
>   
> -static bool qemu_close_all_open_fd_proc(void)
> +static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int nskip)
>   {
>       struct dirent *de;
>       int fd, dfd;
>       DIR *dir;
> +    unsigned int skip_start = 0, skip_end = nskip;
>   
>       dir = opendir("/proc/self/fd");
>       if (!dir) {
> @@ -823,8 +824,33 @@ static bool qemu_close_all_open_fd_proc(void)
>       dfd = dirfd(dir);
>   
>       for (de = readdir(dir); de; de = readdir(dir)) {
> +        bool close_fd = true;
> +
> +        if (de->d_name[0] == '.') {
> +            continue;
> +        }
>           fd = atoi(de->d_name);
> -        if (fd != dfd) {
> +        if (fd == dfd) {
> +            continue;
> +        }
> +
> +        for (unsigned int i = skip_start; i < skip_end; i++) {
> +            if (fd < skip[i]) {
> +                /* We are below the next skipped fd, break */
> +                break;
> +            } else if (fd == skip[i]) {
> +                close_fd = false;
> +                /* Restrict the range as we found fds matching start/end */
> +                if (i == skip_start) {
> +                    skip_start++;
> +                } else if (i == skip_end) {
> +                    skip_end--;
> +                }
> +                break;
> +            }
> +        }
> +
> +        if (close_fd) {
>               close(fd);
>           }
>       }
> @@ -833,24 +859,68 @@ static bool qemu_close_all_open_fd_proc(void)
>       return true;
>   }
>   
> -static bool qemu_close_all_open_fd_close_range(void)
> +static bool qemu_close_all_open_fd_close_range(const int *skip,
> +                                               unsigned int nskip,
> +                                               int open_max)
>   {
>   #ifdef CONFIG_CLOSE_RANGE
> -    int r = close_range(0, ~0U, 0);
> -    if (!r) {
> -        /* Success, no need to try other ways. */
> -        return true;
> -    }
> -#endif
> +    int first = 0, last = open_max - 1;
> +    unsigned int cur_skip = 0;
> +    int ret;
> +
> +    do {
> +        /* Find the start boundary of the range to close */
> +        while (cur_skip < nskip && first == skip[cur_skip]) {
> +            cur_skip++;
> +            first++;
> +        }
> +
> +        /* Find the upper boundary of the range to close */
> +        if (cur_skip < nskip) {
> +            last = skip[cur_skip] - 1;
> +        }
> +        /*
> +         * Adjust the maximum fd to close if it's above what the system
> +         * supports
> +         */
> +        if (last > open_max) {
> +            last = open_max;

You wanted open_max - 1 here as well.

I have fixed this up, and tidied a bit more while queuing for pull.


r~

