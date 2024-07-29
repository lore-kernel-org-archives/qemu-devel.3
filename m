Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9285C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcLc-0006hG-6I; Mon, 29 Jul 2024 22:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcLa-0006dE-BR
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:12:18 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcLX-0004BM-So
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:12:18 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-25e3bc751daso2939013fac.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722305534; x=1722910334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ref+X6HfwcJVt+DUoyjVSKl/pdGsw5DSkY0LXIiNoNc=;
 b=NrL1jTfrJaowQ1RDHCTOXIiGUECAHpJ9eU6o72313WQ1TNcO99PYCy62t2RYiJTlmz
 5IBdwNvUd1eeFZu958YIPSVNHCDKRGIJ1vXC9A7DDJduf7vFSHWxPzZlaud2P+HSK2Z8
 goSGsAF5FQeNZvzilWocXT7b8F07vlpdPfd8iuVg/M7mt/K0d7xrC9mVseeaGWctr/Rb
 QxmiZfNC5u25IwhrYwNWtCa9FOkyYi4i+L/VS35j8palLFVVYaZXwIdCLVG13yVK26EL
 67ca+G7LwWQDGyaxvLIvxfyyo7CYZnQr3HwU5m/NR+IiOexe++vsqFg+InlD9N+YWBma
 H8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722305534; x=1722910334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ref+X6HfwcJVt+DUoyjVSKl/pdGsw5DSkY0LXIiNoNc=;
 b=hMEPuVl8KmPLHhM7gxktodDAxD5M+TSpTKw2Y+nCP0sQ+/95u9iW9sx+uix26Nvx8R
 1SSGdPBK4e2zmjN6SGTEct+SXooQYPLPxlsGinnqxBU5vL367UrS0x2lP7Wa3lVudJOb
 tcOSn9290yzkyNtd6BpF5lxU7LR4oI9c2+LuX3MzajayhwR8D16fmdvvKOa534LqSXc3
 q2suFwNg79Y/3oVcyLE5z0LeVMB7TXI4gr/u8s9jILg6qQQlJqQyiLnEtLxkQEtKUVAq
 N4JiXqXY+CiZnnMPxQhmqDPzH7iJ6iAiz9oXjEOJaQP73RkfaZjCMaYyyW3nKDOxVvly
 m2xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzEf2ijZg785FUx37GyH13PdnBtFcY3wLy6pEYv6G7Dg1j20LC7PPWz1CPxNrtg7r6RR8ToUQelHyqmR2ho3r/rhHmyNw=
X-Gm-Message-State: AOJu0YxTH7e5OaraNyTBHXTDpFrlCVCsX7FrVt0iI1zavAUgYB9Yh1IW
 YWixX//e4Fh+gXsxRdGtxLc54sTINRDOHCtyFvSTQkF7faeHyVMhXqnr3c2z7DnYMwBIGQNSTez
 GJSc=
X-Google-Smtp-Source: AGHT+IFkKK2UYhb4JKUt9XHfRNavmItVLu559BD86X//ExFnud3V/5EgiJqMYufpLSwvE7P253Oxjg==
X-Received: by 2002:a17:902:c40c:b0:1fd:a412:5e05 with SMTP id
 d9443c01a7336-1ff0491ad81mr85602945ad.52.1722288753963; 
 Mon, 29 Jul 2024 14:32:33 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7c8c9d3sm88307155ad.3.2024.07.29.14.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 14:32:33 -0700 (PDT)
Message-ID: <38387ea5-fb29-430f-a83a-917ca74b8357@linaro.org>
Date: Tue, 30 Jul 2024 07:32:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] osdep: add a qemu_close_all_open_fd() helper
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
References: <20240726075502.4054284-1-cleger@rivosinc.com>
 <0914a034-260f-44ef-8d75-2dca9d5fcb24@linaro.org>
 <94b658a0-21c1-4cd0-8bc5-21c0c71b9cb8@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <94b658a0-21c1-4cd0-8bc5-21c0c71b9cb8@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

On 7/30/24 00:20, Clément Léger wrote:
> 
> 
> On 29/07/2024 16:00, Philippe Mathieu-Daudé wrote:
>> Hi Clément,
>>
>> On 26/7/24 09:54, Clément Léger wrote:
>>> Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
>>> POSIX"), the maximum number of file descriptors that can be opened are
>>> raised to nofile.rlim_max. On recent debian distro, this yield a maximum
>>> of 1073741816 file descriptors. Now, when forking to start
>>> qemu-bridge-helper, this actually calls close() on the full possible file
>>> descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
>>> takes a considerable amount of time. In order to reduce that time,
>>> factorize existing code to close all open files descriptors in a new
>>> qemu_close_all_open_fd() function. This function uses various methods
>>> to close all the open file descriptors ranging from the most efficient
>>> one to the least one. It also accepts an ordered array of file
>>> descriptors that should not be closed since this is required by the
>>> callers that calls it after forking. Since this function is not used
>>> for Win32, do not implement it to force an error at link time if used.
>>>
>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>> v5:
>>>    - Move qemu_close_all_open_fd() to oslib-posix.c since it does not
>>>      compile on windows and is not even used on it.
>>>    - v4:
>>> https://lore.kernel.org/qemu-devel/20240717124534.1200735-1-cleger@rivosinc.com/
>>>
>>> v4:
>>>    - Add a comment saying that qemu_close_all_open_fd() can take a NULL
>>> skip
>>>      array and nskip == 0
>>>    - Added an assert in qemu_close_all_open_fd() to check for skip/nskip
>>>      parameters
>>>    - Fix spurious tabs instead of spaces
>>>    - Applied checkpatch
>>>    - v3:
>>> https://lore.kernel.org/qemu-devel/20240716144006.6571-1-cleger@rivosinc.com/
>>>
>>> v3:
>>>    - Use STD*_FILENO defines instead of raw values
>>>    - Fix indentation of close_all_fds_after_fork()
>>>    - Check for nksip in fallback code
>>>    - Check for path starting with a '.' in qemu_close_all_open_fd_proc()
>>>    - Use unsigned for cur_skip
>>>    - Move ifdefs inside close_fds functions rather than redefining them
>>>    - Remove uneeded 'if(nskip)' test
>>>    - Add comments to close_range version
>>>    - Reduce range of skip fd as we find them in
>>>    - v2:
>>> https://lore.kernel.org/qemu-devel/20240618111704.63092-1-cleger@rivosinc.com/
>>>
>>> v2:
>>>    - Factorize async_teardown.c close_fds implementation as well as
>>> tap.c ones
>>>    - Apply checkpatch
>>>    - v1:
>>> https://lore.kernel.org/qemu-devel/20240617162520.4045016-1-cleger@rivosinc.com/
>>>
>>> ---
>>>    include/qemu/osdep.h    |   9 +++
>>>    net/tap.c               |  33 +++++-----
>>>    system/async-teardown.c |  37 +-----------
>>>    util/oslib-posix.c      | 131 ++++++++++++++++++++++++++++++++++++++++
>>>    4 files changed, 160 insertions(+), 50 deletions(-)
>>
>> I'm getting this error on msys2, not sure if related:
>>
>> WARNING: Failed to terminate process: 1 error occurred:
>>      * failed to attach the runner process to the console of its parent
>> process: The handle is invalid.
>>
>> I find your patch hard to review. Do you mind splitting as trivial
>> changes? Something like:
>>
>> - Expose close_all_open_fd() renamed as qemu_close_all_open_fd()
>> - Rework qemu_close_all_open_fd()
>> - Factor close_all_fds_after_fork() in net/tap.c
>> - Use qemu_close_all_open_fd() in net/tap.c
> 
> Yes sure, I'll do that.

If you're making updates, I think you should drop the linux ifdef for /proc/self/fd.  This 
is also present on Solaris.  Importantly, it'll compile on all POSIX systems, whether or 
not /proc is available.


r~

