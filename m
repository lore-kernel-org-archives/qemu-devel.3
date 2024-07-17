Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA0CC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0ni-0001Wj-1j; Wed, 17 Jul 2024 05:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sU0nd-0001VM-Ap
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:18:16 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sU0na-0003yz-2r
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:18:12 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70378348d59so6107a34.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 02:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721207888; x=1721812688;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kPX1jl5eoFJRQrixX3GtkCNiJq0G31nICUo3ykK6Zj8=;
 b=Xw9kUG0n8k5pwI6EIpG6L46pDXZf5YeEiKD6hexn5G8vPnCUXPGKaaVhLciGH6Sm/B
 RbC7z+gpeF5Er9b///jtwJXoSveUkkz94sPYuEpQPpOkiTjSZKqHn6/gG/U277VoYBhx
 +NgFTvbVRxZlR6NN5VFH10UneuoETDtfG0YQS3ubaZ1jveT4RRySNMBLFI9iK2CGHdbx
 TprXrRE/dccJxkyxVRB8yXAvy1bUv1m4t+vWznsAbD428LUoJd+dFbrq8lha9jAH20YX
 aU2ldLbg/+aMPwbug075BDaq3lIncMxdx3gjt2fz8t6IWpWtPrEsTSud/7q6gLF7pUw4
 K/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721207888; x=1721812688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kPX1jl5eoFJRQrixX3GtkCNiJq0G31nICUo3ykK6Zj8=;
 b=I5hyy19J3UWoSIZd/w89uTw2SBM9uTYFlqSPvXDoqe4qTBDqNHnzaSW1V11BygxgGr
 c4v4l+fuRqASBBb9UQRdW747nKs00WAPOlJ2e3mmR3brtB1EvY9CObpirXpTTELwmFG2
 2OvdOdhmLfBnB6zB/Ge2vc6WkGr6p5y0d0gprEYIlF9vs8j5lb1uj8d7O97Gzhp3VYcX
 tu9mbuhgTHAFUDNcu6RQ5fZ1KiEOxAOeyx9tLqZ0RJl2uwByCECtymTD8QQrItUqClRS
 nMwv8kqTUeKj9N/cIvJUCImwtdjOm4Xnw79ua/rzJYoviupfg9Ef2UvgDpI5YMu5yEGh
 +Yzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ1jYyQMQEOg1d5FM8urFAl8aJuS+Mg3Kjq8MONGC8EsSJ83bHg7SqlxfRAe7q/9//QZODJ+csnv7yDcvqm06A9akiCh0=
X-Gm-Message-State: AOJu0Yx7KY4vDZ15dy+ZwdBKs0vB+Yt1/+ObHfXB3BlA+ZZygFRtgOB3
 7dEY+oLsuGWEJowjkFQ3+rJWVq3RKURuXY05cHL/DMZOa1HHnPVygD+i8K1w5Ok=
X-Google-Smtp-Source: AGHT+IFlZ14K3gSwuuLQ9sh1bU7zj6OPiOZHoiQYfQIgax3LyNyxzdM//UgNye/TeUNTWG8xJNlMTA==
X-Received: by 2002:a05:6870:3d88:b0:25e:14d9:da27 with SMTP id
 586e51a60fabf-260d8db5da4mr794140fac.0.1721207888461; 
 Wed, 17 Jul 2024 02:18:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecabadasm7637656b3a.181.2024.07.17.02.18.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 02:18:07 -0700 (PDT)
Message-ID: <be923e26-8784-4cc1-b8a4-6d1cc0b057f7@rivosinc.com>
Date: Wed, 17 Jul 2024 11:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] osdep: add a qemu_close_all_open_fd() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240716144006.6571-1-cleger@rivosinc.com>
 <64d26790-5003-4da5-9cb2-eb9ea43112b3@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <64d26790-5003-4da5-9cb2-eb9ea43112b3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=cleger@rivosinc.com; helo=mail-ot1-x32e.google.com
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



On 16/07/2024 16:46, Philippe Mathieu-Daudé wrote:
> Hi Clément,
> 
> On 16/7/24 16:39, Clément Léger wrote:
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
>> v3:
>>   - Use STD*_FILENO defines instead of raw values
>>   - Fix indentation of close_all_fds_after_fork()
>>   - Check for nksip in fallback code
>>   - Check for path starting with a '.' in qemu_close_all_open_fd_proc()
>>   - Use unsigned for cur_skip
>>   - Move ifdefs inside close_fds functions rather than redefining them
>>   - Remove uneeded 'if(nskip)' test
>>   - Add comments to close_range version
>>   - Reduce range of skip fd as we find them in
>>   - v2:
>> https://lore.kernel.org/qemu-devel/20240618111704.63092-1-cleger@rivosinc.com/
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
>>   net/tap.c               |  33 +++++-----
>>   system/async-teardown.c |  37 +-----------
>>   util/osdep.c            | 129 ++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 157 insertions(+), 50 deletions(-)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index 191916f38e..43a035d756 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -757,6 +757,14 @@ static inline void qemu_reset_optind(void)
>>     int qemu_fdatasync(int fd);
>>   +/**
>> + * Close all open file descriptors except the ones supplied in the
>> @skip array
>> + *
>> + * @skip: ordered array of distinct file descriptors that should not
>> be closed
>> + * @nskip: number of entries in the @skip array.
>> + */
> 
> Can we mention @skip is optional, and @nskip can be 0?
> 
> Also I'd assert(skip != NULL || nskip == 0).

Yes sure, I'll add that.

Thanks,

Clément


