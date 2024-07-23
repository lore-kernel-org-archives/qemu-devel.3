Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A53C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9l1-0003bw-Ao; Tue, 23 Jul 2024 03:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sW9kz-0003Xp-OW
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:16:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sW9kx-0003NC-66
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:16:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-427d8f2611fso4602315e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 00:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721718977; x=1722323777;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5F3CNFuom6VFoLCzpBvgsLevuDJN+zZbbktqjwCvZA0=;
 b=r4WCMIMgs2YH8fRCHdtM5m9Ho3L8VVrB4RpvlSkYThIEGo9ogYmAUvwIYktJwNx198
 q9Uvu1buNARNQ2YMHx2SpFnYMFv/Kg2+QZfaFn65fU1IkjUrx8bORKBmUnq6/SEOgKT6
 RIdtA1FXUD8Xw0kAN6c4vQuSSpEh5Nx9jIipWCSp2AGbTqGokKm3biq/OIBtIVkURCuM
 seoa93JfM+1AA/k6S5ySsQjiJ8c+JPTHpL3+AvwLIk0BEnl8QeMaoiuwq5lCdabrC5y8
 J4NVEDXs/VkvI7FQodox22o0VpOj00pjKkelBdnOwObZF18rS9neTC2EPCJnnbtQFGn1
 ZgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721718977; x=1722323777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5F3CNFuom6VFoLCzpBvgsLevuDJN+zZbbktqjwCvZA0=;
 b=PmZRFi7QohT7lne/YN681r6QX9BNiOoMoPUNvTWSmpyBbGJHoWJY+gmXXMwkmpibGA
 Xd2TNkF29gWbFMxMFQ6RQOicHdqgIIHTSY0bi1AOm6GZY+ZsgQitjpimuiOOCkqGW2jz
 6SDoGM6ue5Ar3SXaOc3i2yuUbEyeC3vu7KLCohvkKj5e8AFUT9EPTSYxgr3s7L6BZ3L1
 OgLNHLfmgnz0TeSo2Dx7ozOEOVIR7XvcQg15aAdCONM7944khgByemOVF0Nw6aZF5ey2
 WyjGheI8LEWvh3BYmmhvF8ogPvLVVIV1UXZHrKA59xo+h/yaCRX8jWo+G8OGm6LwuKl2
 fKsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvcBTj++RLxv8SF3BFZXO+XCl9aOdiKihJctBGnA6B+VFXDhzK8VSfmONIGPMgDQZzfMcehgtB8UW3DkCSCNAb1vj18LQ=
X-Gm-Message-State: AOJu0YwdLwnewPzlHxV6COrJgg4KQ70sClVc7kAcasSHhIet5zjeowhK
 whRxlZyh51wLIp3lCYJAZVJK/U3lzQltkJyB6Y+ZD+TlUVUqpEHHtzmKDyeE50k=
X-Google-Smtp-Source: AGHT+IEMWCe89f6zwj+UC9rDBSBBPj9DEqVpCoco/eduZicazTpVfAURSJhU287KvsMnUvBwC5J3UQ==
X-Received: by 2002:a05:600c:3542:b0:425:6962:4253 with SMTP id
 5b1f17b1804b1-427daa683eamr43865935e9.4.1721718976993; 
 Tue, 23 Jul 2024 00:16:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427db34fe3fsm124874135e9.4.2024.07.23.00.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 00:16:16 -0700 (PDT)
Message-ID: <7aadff15-3939-4e0f-a81a-84f78521a8a1@rivosinc.com>
Date: Tue, 23 Jul 2024 09:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] osdep: add a qemu_close_all_open_fd() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240717124534.1200735-1-cleger@rivosinc.com>
 <c2085e4c-d2af-4ea1-9a04-f523c94a7315@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <c2085e4c-d2af-4ea1-9a04-f523c94a7315@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x332.google.com
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



On 23/07/2024 08:24, Philippe Mathieu-Daudé wrote:
> Hi Clément,
> 
> On 17/7/24 14:45, Clément Léger wrote:
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
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ----
> 
> FYI git tools parse 3 '-', not 4.

Hi Philippe,

Thanks for the info, I was not aware of that ! I'll use 3 '-' from now on.

> 
>> v4:
>>   - Add a comment saying that qemu_close_all_fds() can take a NULL skip
>>     array and nskip == 0
>>   - Added an assert in qemu_close_all_fds() to check for skip/nskip
>>     parameters
>>   - Fix spurious tabs instead of spaces
>>   - Applied checkpatch
>>   - v3:
>> https://lore.kernel.org/qemu-devel/20240716144006.6571-1-cleger@rivosinc.com/
> 
> 
>> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
>> +{
>> +    int open_max = sysconf(_SC_OPEN_MAX);
>> +    unsigned int cur_skip = 0;
>> +    int i;
>> +
>> +    assert(skip != NULL || nskip == 0);
>> +
>> +    if (qemu_close_all_open_fd_close_range(skip, nskip)) {
>> +        return;
>> +    }
>> +
>> +    if (qemu_close_all_open_fd_proc(skip, nskip)) {
>> +        return;
>> +    }
>> +
>> +    /* Fallback */
>> +    for (i = 0; i < open_max; i++) {
>> +        if (cur_skip < nskip && i == skip[cur_skip]) {
>> +            cur_skip++;
>> +            continue;
>> +        }
>> +        close(i);
>> +    }
>> +}
> 
> Build failure on windows:
> 
> ../util/osdep.c: In function 'qemu_close_all_open_fd':
> ../util/osdep.c:725:20: error: implicit declaration of function
> 'sysconf'; did you mean 'swscanf'? [-Wimplicit-function-declaration]
>   725 |     int open_max = sysconf(_SC_OPEN_MAX);
>       |                    ^~~~~~~
>       |                    swscanf
> ../util/osdep.c:725:20: error: nested extern declaration of 'sysconf'
> [-Werror=nested-externs]
> ../util/osdep.c:725:28: error: '_SC_OPEN_MAX' undeclared (first use in
> this function); did you mean 'FOPEN_MAX'?
>   725 |     int open_max = sysconf(_SC_OPEN_MAX);
>       |                            ^~~~~~~~~~~~
>       |                            FOPEN_MAX
> ../util/osdep.c:725:28: note: each undeclared identifier is reported
> only once for each function it appears in
> 

Should I move this chunk of code in oslib-posix.c and stub that function
for win32 ? It seems like this code was not built for windows before I
added it in osdep, which means it is not needed for win32.

What's your advice on that ?

Thanks,

Clément


