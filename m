Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9327DC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiSd-0003GH-Ub; Tue, 16 Jul 2024 09:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sTiSR-0002hO-HP
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:43:08 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sTiSL-0007Uu-Nj
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:43:04 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-760df01858cso514815a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721137380; x=1721742180;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=19IVG1p50VU/4oRnvIoXT/X7FY9zuWq/6+CuFjijIls=;
 b=o3pP7RfmcitLNP5CWomuyTf8M2decEpY7lIgd2lczIaZFqaV3ch4OOENRm/lLnHqMY
 pUXhbjf2M0NuE6eub4b6QKPTUMoLcGjZItrisVCEVeUsQgcntIGKhXZXnoVbWn2f22oI
 qkh/UEgnZ8Q3wV++aPyKxIdLHFA7dhaw2l1ikX2rtOciy4cPeNJyhX1kXUI1SUCFKIFU
 lCQeAUfY+08iZ7yE1439BsMMXlXIwmDx2kUtA/08OevoByqraeYfWoSchCo1tfwZz5cj
 0Mgt1wzcpz8vz+/PqLhiTtIY4plqIqUQOU9u7LpdH/9fylln6MOoyaXzlX3gHI7XQeQs
 aTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721137380; x=1721742180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=19IVG1p50VU/4oRnvIoXT/X7FY9zuWq/6+CuFjijIls=;
 b=gQ5uRA9CpV44Ountv9OwYhvdRZGdTsLvEXumzl/hmwR0k8iE7PBevJfXquAqLdkAG7
 wSnsh7g3fJ3P00bq6k5DQHBRor56u4HUdV56yMiBq4q1XMA5LtPRLKs4/XjufmxJmuif
 MTk3cjPYrB6ltzID6eAXVbQaRc0FKp/2hCXleG3Rk2SjRgsV9YZcHODLSAGAzyh+hAE0
 k8pGg8prJRn58hp218v/S5bcRzIeRD2K1PjhaF44qPzBwo4QHWHjvQ9GAG85++yLcz76
 h5LxRJf+ckjU0BSOvbLVM4wpKAcYvkaoGdNIYng0I8xVd422MrAimNnVOAdCO0hQdTGG
 CoEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKIT2jVtrrPjeF8RcJ4Yq4y13SaEZfGFVqojbu87XsCgOe9xxl3TIn0tB42xFCxHJywLRbDUZ37OHhP4WT/CV91wV4REg=
X-Gm-Message-State: AOJu0Yz/owqjMNvaiDL5yfm0DBr0gXApJz/pCEriHXAD4Nm+sNe6/Y6+
 4OTsgFPur4sl1aDCmCisCPuRCP8PtVR9YzgGjBI8u2YJglkRp3aXA5tN0Y+E93CaUEVBvhsaGx8
 mKa0=
X-Google-Smtp-Source: AGHT+IGtrHH8hXjUrKtuzrg7Y7ADRCyCKOA5ctAVMioEpo/tloCLwim3e45mPUNJ1sl4RM/FKOIpfw==
X-Received: by 2002:a17:902:f68b:b0:1fc:4377:f62b with SMTP id
 d9443c01a7336-1fc4377f6f3mr3256815ad.7.1721137379667; 
 Tue, 16 Jul 2024 06:42:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc46562sm58667865ad.253.2024.07.16.06.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 06:42:59 -0700 (PDT)
Message-ID: <d30ccc9b-f5b7-4c46-a4ee-260c73454c9c@rivosinc.com>
Date: Tue, 16 Jul 2024 15:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] osdep: add a qemu_close_all_open_fd() helper
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
References: <20240618111704.63092-1-cleger@rivosinc.com>
 <c7e1d9de-ec4a-48aa-a1f0-4903ade1bad9@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <c7e1d9de-ec4a-48aa-a1f0-4903ade1bad9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=cleger@rivosinc.com; helo=mail-pg1-x52e.google.com
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



On 11/07/2024 20:43, Richard Henderson wrote:
> On 6/18/24 04:17, Clément Léger wrote:
>> Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
>> POSIX"), the maximum number of file descriptors that can be opened are
>> raised to nofile.rlim_max. On recent debian distro, this yield a maximum
>> of 1073741816 file descriptors. Now, when forking to start
>> qemu-bridge-helper, this actually calls close() on the full possible file
>> descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
>> takes a considerable amount of time. In order to reduce that time,
>> factorize existing code to close all open files descriptors in a new
>> qemu_close_all_open_fd() function. This function uses various methods
>> to close all the open file descriptors ranging from the most efficient
>> one to the least one. It also accepts an ordered array of file
>> descriptors that should not be closed since this is required by the
>> callers that calls it after forking.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
>> ----
>>
>> v2:
>>   - Factorize async_teardown.c close_fds implementation as well as
>> tap.c ones
>>   - Apply checkpatch
>>   - v1:
>> https://lore.kernel.org/qemu-devel/20240617162520.4045016-1-cleger@rivosinc.com/
>>
>> ---
>>   include/qemu/osdep.h    |   8 +++
>>   net/tap.c               |  31 ++++++-----
>>   system/async-teardown.c |  37 +------------
>>   util/osdep.c            | 115 ++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 141 insertions(+), 50 deletions(-)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index f61edcfdc2..9369a97d3d 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -755,6 +755,14 @@ static inline void qemu_reset_optind(void)
>>     int qemu_fdatasync(int fd);
>>   +/**
>> + * Close all open file descriptors except the ones supplied in the
>> @skip array
>> + *
>> + * @skip: ordered array of distinct file descriptors that should not
>> be closed
>> + * @nskip: number of entries in the @skip array.
>> + */
>> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip);
>> +
>>   /**
>>    * Sync changes made to the memory mapped file back to the backing
>>    * storage. For POSIX compliant systems this will fallback
>> diff --git a/net/tap.c b/net/tap.c
>> index 51f7aec39d..6fc3939078 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -385,6 +385,21 @@ static TAPState *net_tap_fd_init(NetClientState
>> *peer,
>>       return s;
>>   }
>>   +static void close_all_fds_after_fork(int excluded_fd)
>> +{
>> +        const int skip_fd[] = {0, 1, 2, 3, excluded_fd};
> 
> 3 should not be included here...

Oh yes, my bad.

> 
>> +        unsigned int nskip = ARRAY_SIZE(skip_fd);
>> +
>> +        /*
>> +         * skip_fd must be an ordered array of distinct fds, exclude
>> +         * excluded_fd if already included in the [0 - 3] range
>> +         */
>> +        if (excluded_fd <= 3) {
> 
> or here -- stdin is 0, stdout is 1, stderr is 2.
> 
> Perhaps we need reminding of this and use the STD*_FILENO names instead
> of raw integer constants.

Indeed, I'll switch to using STD*_FILENO.

> 
> 
>> @@ -400,13 +415,7 @@ static void launch_script(const char
>> *setup_script, const char *ifname,
>>           return;
>>       }
>>       if (pid == 0) {
>> -        int open_max = sysconf(_SC_OPEN_MAX), i;
>> -
>> -        for (i = 3; i < open_max; i++) {
>> -            if (i != fd) {
>> -                close(i);
>> -            }
>> -        }
> 
> Note that the original *does* close 3.
> 
>> +#ifdef CONFIG_LINUX
>> +static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int
>> nskip)
>> +{
>> +    struct dirent *de;
>> +    int fd, dfd;
>> +    bool close_fd;
>> +    DIR *dir;
>> +    int i;
>> +
>> +    dir = opendir("/proc/self/fd");
>> +    if (!dir) {
>> +        /* If /proc is not mounted, there is nothing that can be
>> done. */
>> +        return false;
>> +    }
>> +    /* Avoid closing the directory. */
>> +    dfd = dirfd(dir);
>> +
>> +    for (de = readdir(dir); de; de = readdir(dir)) {
>> +        fd = atoi(de->d_name);
>> +        close_fd = true;
>> +        if (fd == dfd) {
>> +            close_fd = false;
>> +        } else {
>> +            for (i = 0; i < nskip; i++) {
> 
> The skip list is sorted, so you should remember the point of the last
> search and begin from there, and you should not search past fd < skip[i].

readdir values are not ordered so the best I can do is restrict
start/end once found in the fds and bail out when < skip[i] as you
pointed out.

for (i = skip_start; i < skip_end; i++) {
    if (fd < skip[i]) {
        /* We are below the next skipped fd, break */
        break;
    } else if (fd == skip[i]) {
        close_fd = false;
        /* Restrict the range as we found fds matching start/end */
        if (i == skip_start)
            skip_start++;
        else if (i == skip_end)
            skip_end--;
        break;
    }
}


> 
> 
>> +#else
>> +static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int
>> nskip)
>> +{
>> +    return false;
>> +}
>> +#endif
> 
> I'm not fond of duplicating the function declaration.
> I think it's better to move the ifdef inside:
> 
> static bool foo(...)
> {
> #ifdef XYZ
>   impl
> #else
>   stub
> #endif
> }
> 

Acked.

>> +
>> +#ifdef CONFIG_CLOSE_RANGE
>> +static bool qemu_close_all_open_fd_close_range(const int *skip,
>> +                                               unsigned int nskip)
>> +{
>> +    int max_fd = sysconf(_SC_OPEN_MAX) - 1;
>> +    int first = 0, last = max_fd;
>> +    int cur_skip = 0, ret;
>> +
>> +    do {
>> +        if (nskip) {
>> +            while (first == skip[cur_skip]) {
>> +                cur_skip++;
>> +                first++;
>> +            }
> 
> This fails to check cur_skip < nskip in the loop.
> Mixing signed cur_skip with unsigned nskip is bad.
> 
> There seems to be no good reason for the separate "if (nskip)" check.
> A proper check for cur_skip < nskip will work just fine with nskip == 0.

I'll try to rework that.

> 
>> +    /* Fallback */
>> +    for (i = 0; i < open_max; i++) {
>> +        if (i == skip[cur_skip]) {
>> +            cur_skip++;
>> +            continue;
>> +        }
>> +        close(i);
>> +    }
> 
> Missing nskip test.
I'll fix that.

Thanks,

Clément

> 
> 
> r~
> 

