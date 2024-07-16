Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6263CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThRQ-0002Dy-Pq; Tue, 16 Jul 2024 08:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sThRO-0002AA-Ch
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:37:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sThRM-00023Y-4c
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:37:58 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70b00f3216bso338981b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721133474; x=1721738274;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jQLYK6LDOTgoRZP3h0HwOnPHw431Zt5eCBcCniEkOnw=;
 b=3DXaLLDPMBsJclN59s8XVbjYyXWDkAtvHfYP4FLxioP6MqtEfsg/iz2JC+qN6xgOck
 78mC1cVB/98faCr09lVm4Pe9gnGT0lDpBAyOBSF+5hHc2WIKKaTaxnO07NoiWX0UFdkn
 GlglNZLKzQkK4DyIIvNwo9xSs1OZEUxWdDQ7FEEbdodJyRKLQecmjS2vDhhx2bYxzVOA
 rmZgE4wC2vi95jrUK//SmgUPdNFMf14Olg51GZy70RNuPWTcBy60VGtPfhevxay9vsMl
 d1x5skuLuDYSmOpOaTyTHE48aO/3eC26b5Qck+j3FmzmSHYJvdwgO5tZrK68MDovBPOq
 /cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721133474; x=1721738274;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jQLYK6LDOTgoRZP3h0HwOnPHw431Zt5eCBcCniEkOnw=;
 b=AMibhQSFKWnEN6eR1qQ264zAxOO7+TG860SmMt4ukeliI6j+mUyCp2Qcms39Qkcm0y
 T54q6tRt2Dvo91tR8Cf0no87aWI7x39zOdoc2ophoqUE/p5jKXr543eyJd5C4dmxHUL7
 9B75lRJvx/frQBdWKCUTFXmHjk+2hYv5SZ7pktuy5SQ3N1zUKPzgKdlyR+BE6X9GJJxw
 kYK4A38S7CUy7JAku3Zj9jAOkE5rOLfFTqUbPoxeRec3KZBES5w/drNpLyenoGCgnSG8
 UenBwIP5qGZ2A6/Ci9nGjJjB6s60ShoM8o56AfDKW9VKwwb3LXzKKK3/S9+RWG9FTyXs
 GFyw==
X-Gm-Message-State: AOJu0YyR34NCL6mtSYCa1OOFr7kNfOSgUWviAB6hxrCrdEqujhdNhsil
 uhYNzSLp3oH8To69AoLiYLf7mMiMepINx1UbLAxFZZSmfP90+5AfVQlR8K55070=
X-Google-Smtp-Source: AGHT+IGUSVdbi9DP+POZatVMmd6bFij4gygeRuRz1+YSb6M3z7YdVl3jqUnQd95MIeGO5IZXiZYH6A==
X-Received: by 2002:a05:6a20:b40a:b0:1c2:8a9b:b18 with SMTP id
 adf61e73a8af0-1c3ee5880f3mr1889762637.5.1721133473864; 
 Tue, 16 Jul 2024 05:37:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-78e32b6ba72sm3940640a12.14.2024.07.16.05.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:37:53 -0700 (PDT)
Message-ID: <50fd5c2a-cee0-460f-bbae-55ef44ee1071@rivosinc.com>
Date: Tue, 16 Jul 2024 14:37:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] osdep: add a qemu_close_all_open_fd() helper
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>
References: <20240618111704.63092-1-cleger@rivosinc.com>
 <ZpFH3E78ly_CP2fF@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <ZpFH3E78ly_CP2fF@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=cleger@rivosinc.com; helo=mail-pf1-x42b.google.com
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



On 12/07/2024 17:12, Daniel P. Berrangé wrote:
> On Tue, Jun 18, 2024 at 01:17:03PM +0200, Clément Léger wrote:
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
>>  - Factorize async_teardown.c close_fds implementation as well as tap.c ones
>>  - Apply checkpatch
>>  - v1: https://lore.kernel.org/qemu-devel/20240617162520.4045016-1-cleger@rivosinc.com/
>>
>> ---
>>  include/qemu/osdep.h    |   8 +++
>>  net/tap.c               |  31 ++++++-----
>>  system/async-teardown.c |  37 +------------
>>  util/osdep.c            | 115 ++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 141 insertions(+), 50 deletions(-)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index f61edcfdc2..9369a97d3d 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -755,6 +755,14 @@ static inline void qemu_reset_optind(void)
>>  
>>  int qemu_fdatasync(int fd);
>>  
>> +/**
>> + * Close all open file descriptors except the ones supplied in the @skip array
>> + *
>> + * @skip: ordered array of distinct file descriptors that should not be closed
>> + * @nskip: number of entries in the @skip array.
>> + */
>> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip);
>> +
>>  /**
>>   * Sync changes made to the memory mapped file back to the backing
>>   * storage. For POSIX compliant systems this will fallback
>> diff --git a/net/tap.c b/net/tap.c
>> index 51f7aec39d..6fc3939078 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -385,6 +385,21 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>>      return s;
>>  }
>>  
>> +static void close_all_fds_after_fork(int excluded_fd)
>> +{
>> +        const int skip_fd[] = {0, 1, 2, 3, excluded_fd};
>> +        unsigned int nskip = ARRAY_SIZE(skip_fd);
>> +
>> +        /*
>> +         * skip_fd must be an ordered array of distinct fds, exclude
>> +         * excluded_fd if already included in the [0 - 3] range
>> +         */
>> +        if (excluded_fd <= 3) {
>> +            nskip--;
>> +        }
>> +        qemu_close_all_open_fd(skip_fd, nskip);
>> +}
> 
> This is slightly over-indented - 4 space is QEMU normal style.

Indeed, my bad.

> 
>> diff --git a/util/osdep.c b/util/osdep.c
>> index 5d23bbfbec..f3710710e3 100644
>> --- a/util/osdep.c
>> +++ b/util/osdep.c
>> @@ -625,3 +625,118 @@ int qemu_fdatasync(int fd)
>>      return fsync(fd);
>>  #endif
>>  }
>> +
>> +#ifdef CONFIG_LINUX
>> +static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int nskip)
>> +{
>> +    struct dirent *de;
>> +    int fd, dfd;
>> +    bool close_fd;
>> +    DIR *dir;
>> +    int i;
>> +
>> +    dir = opendir("/proc/self/fd");
>> +    if (!dir) {
>> +        /* If /proc is not mounted, there is nothing that can be done. */
>> +        return false;
>> +    }
>> +    /* Avoid closing the directory. */
>> +    dfd = dirfd(dir);
>> +
>> +    for (de = readdir(dir); de; de = readdir(dir)) {
> 
> Don't we need
> 
>    if (de->d_name[0] == '.') {
>        continue;
>    }
> 
> otherwise atoi will fail and we'll try to close(0) multiple
> times.

Yes, that seems like it was the case for the previous code. I'll fix that.

Thanks,

Clément

> 
>> +        fd = atoi(de->d_name);
>> +        close_fd = true;
>> +        if (fd == dfd) {
>> +            close_fd = false;
>> +        } else {
>> +            for (i = 0; i < nskip; i++) {
>> +                if (fd == skip[i]) {
>> +                    close_fd = false;
>> +                    break;
>> +                }
>> +            }
>> +        }
>> +        if (close_fd) {
>> +            close(fd);
>> +        }
>> +    }
>> +    closedir(dir);
>> +
>> +    return true;
>> +}
> 
> With regards,
> Daniel

