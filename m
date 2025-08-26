Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E72CA0FEB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 15:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqvd6-0004ob-Jg; Tue, 26 Aug 2025 11:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uqvd2-0004oA-7w
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:30:32 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uqvct-00084y-NT
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:30:31 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-246aef91e57so35216655ad.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756222218; x=1756827018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zhH4CnVmuH5rUSqm4B08jrDn1t5mBUjW3z6ucRr1XKA=;
 b=ky2TJjMVQ+at2xyobXPQ4jSELDC9ltsgjb8fquGhVa28+0UO0+4o3rVuVjWbPeav/l
 3JCqh0EkiEyCl5KaogPCaRrC0gYnGm3SVzWmHG06XFnlCIT+Asq3UUH664Hjf0A0u9jK
 kPiXsTsi8r8gEjAzx1N/GN4BG7LvFvngIWOfDEEU+o9OXM7GnsgoStIyOhVzNgfCMFYV
 mP0TZMdzyiW5YhGIe4aWgBD/T0zAQarDN+Q8+GFiMvtteDTJjv3shMA7xXq/3XL8CSWZ
 UTMD9b/b6QzPOEGLaSr58x3GJxNUS+K+4VPskP0TZ5S3DE6hRPEYTXkvr7sdY9Xb/MRf
 AlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756222218; x=1756827018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zhH4CnVmuH5rUSqm4B08jrDn1t5mBUjW3z6ucRr1XKA=;
 b=sVzRZaIvWvt8BgE4cVzWu2FsGTcwC2S0VXciF1RhVSp5fpdCYoF6d+43cN4L0SJLz1
 2wxuDSqLWCWVVw/9+/+7pUyUfd6dASZyj4c6LC+aL+/52pEq87ja6Ev4vrEhdGcGq1N0
 dilUkyyI3YOX4/u+C1XxZCPdK/NkJdXx144cPxQleaodtpThw60IUVDF4y8idYe8SDse
 95flk+jV6jRYEYWb6MZ07O9POYPLS+B8H5x9NksJLASmbz9Jrngb0ZGrbxn6MfX0E+et
 T04We2IcyUxIY2Yg/OKuKi5PJUCAVGka/T7C9t5xrDsqkbyXpM6TSxXgcYP5c2gwjeSQ
 0VbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcjNs4+TwFTymJBNwzz9TYaMaG78t0XEWg84LMrBsElK9kGGHfR16bBPMhpkfSOiqPh6d4kwoaqELv@nongnu.org
X-Gm-Message-State: AOJu0YwkUr1O/cy04xgcNJK4zy85bhmg/ADG1k4Blj6yqJ1UPI+hXZuL
 hsib1+y30fblhJnTIgPdciYoyE0M4iUwnw3nHHAJg/390bEpHotQkLr/804DyvbsA5c=
X-Gm-Gg: ASbGncvcwxXY0hIRIaMYWbwp/h84dA1ZF5hdRZFbXY4g22XYztTLl23qC0xlx+Y6fbj
 OiS3Mb9jxGq3VbR9T6a/O1f+iDaY7gImgl8SrT6Wy/XKabNrBJlR6VwbZzA1pHywpEzKRAvYb+6
 FSoKLpXup6f4aOn8sM0RK9FBL7CfDbUK77tsZVT2eovepQ7n7Y2OCfANdcEaQGDEedSmOFmhQw0
 X4QQU36ArsD1+CnOlPV0Gmxbd82BMO/NM+y7SL/BsKnRPdQDH7UAiaIZHaDudUKv4SHP07G+DSw
 OSp34jtAiE5po0dWWj3ODVQs4VRD/29NLIiNODO+m+6X2u10N92RHgiuS0C5oLkIkH3q+XGdeID
 K0CXXxKe9H+3gtnDAXHDqgj9tK6HjjSvvNlJCRbHToXSSm1He35nz3R0=
X-Google-Smtp-Source: AGHT+IGC5SkF03XEsy+ndwbCgobS+o8wiJUj7tVBDWpwbBiZzZqrOGN1x1mBWIIXeutG0EzBp8tQXw==
X-Received: by 2002:a17:902:cf0f:b0:246:acd6:c635 with SMTP id
 d9443c01a7336-246acd6c81bmr127507485ad.34.1756222217575; 
 Tue, 26 Aug 2025 08:30:17 -0700 (PDT)
Received: from [192.168.0.102] ([187.75.38.174])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2466887fc75sm98296685ad.105.2025.08.26.08.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 08:30:17 -0700 (PDT)
Message-ID: <59c3fe12-fb6d-4aaa-a6e0-ce51e1c7f7e4@linaro.org>
Date: Tue, 26 Aug 2025 12:31:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org, 1844144@gmail.com,
 Jan Richter <jarichte@redhat.com>
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <53b6e23f-5328-42c6-9c58-97ddbf3e5b29@redhat.com>
 <a1105fed-dbd8-4223-b771-180ab12e3f77@linaro.org>
 <8326014d-114e-47df-89fc-632eb5683632@redhat.com>
 <aK3AYjQmb3bNEdrh@redhat.com> <aK3RJnTA1m-kEr4c@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <aK3RJnTA1m-kEr4c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x641.google.com
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

Hi Daniel!

On 8/26/25 12:22, Daniel P. Berrangé wrote:
> On Tue, Aug 26, 2025 at 03:10:42PM +0100, Daniel P. Berrangé wrote:
>> On Tue, Aug 26, 2025 at 09:51:27AM +0200, Thomas Huth wrote:
>>> On 25/08/2025 16.04, Gustavo Romero wrote:
>>>> Hello, Thomas!
>>>>
>>>> On 8/25/25 07:29, Thomas Huth wrote:
>>>>> On 19/08/2025 16.39, Gustavo Romero wrote:
>>>>>> The goal of this series is to remove Avocado as a dependency for running
>>>>>> the reverse_debugging functional test.
>>>>>>
>>>>>> This test, the last one I’m aware of that relies on Avocado, requires it
>>>>>> because of the need for GDB to test reverse stepping and continue.
>>> ...
>>>>> I gave it a try, but this did not work for me, the test was not run
>>>>> at all anymore. Are there any patches needed on top?
>>>>
>>>> hmm that's odd. I'm able to run it with 'make check-functional' and with
>>>> 'meson test'...
>>>>
>>>> This is how I'm running it (let me know if I'm missing something):
>>> ...
>>>> gromero@gromero0:/mnt/git/qemu_$
>>>> gromero@gromero0:/mnt/git/qemu_/build$ ../configure
>>>> --target-list=aarch64- softmmu --disable-docs
>>>> gromero@gromero0:/mnt/git/qemu_/build$ make -j 32
>>>> gromero@gromero0:/mnt/git/qemu_/build$ time make -j 15  check-functional
>>>> [1/2] Generating tests/functional/func-precache-aarch64-
>>>> aarch64_reverse_debug with a custom command (wrapped by meson to set
>>>> env)
>>>> 2025-08-25 12:50:04,215 - qemu-test - INFO - Attempting to cache '/home/
>>>> gromero/.cache/qemu/
>>>> download/7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7'
>>>> 2025-08-25 12:50:04,225 - qemu-test - DEBUG - Using cached asset /home/
>>>> gromero/.cache/qemu/
>>>> download/7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7
>>>> for
>>>> https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/29/
>>>> Everything/aarch64/os/images/pxeboot/vmlinuz
>>>> GDB CMD: /usr/bin/gdb-multiarch -q -n -batch -ex 'set pagination off'
>>>> -ex 'set confirm off' -ex "py
>>>> sys.argv=['/mnt/git/qemu_/tests/functional/
>>>> test_aarch64_reverse_debug.py']" -x /mnt/git/qemu_/tests/functional/
>>>> test_aarch64_reverse_debug.py
>>>> [0/1] Running external command precache-functional (wrapped by meson to
>>>> set env)
>>>> make[1]: Entering directory '/mnt/git/qemu_/build'
>>>> [1/6] Generating qemu-version.h with a custom command (wrapped by meson
>>>> to capture output)
>>>> /mnt/git/qemu_/build/pyvenv/bin/meson test  --no-rebuild -t 1 --setup
>>>> thorough  --num-processes 10 --print-errorlogs  --suite func  --suite
>>>> func- quick  --suite func-thorough
>>>>    1/27 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-
>>>> aarch64_virt_gpu                   SKIP              1.95s   0 subtests
>>>> passed
>>>
>>> I tried a couple of times now, and finally realized that it's the
>>> "gdb-multiarch" binary that is missing on Fedora. And as far as I can see,
>>> there is also no package that provides this on Fedora? So if we go ahead
>>> with your patches, this test will only run on certain distros that provide
>>> this binary.
>>
>> 'gdb-multiarch' is a command name invented by Debian.
>>
>> On Fedora, the regular 'gdb' binary is built with support for
>> multiple architectures for the purpose of remote debugging.
> 
> The set of archs supported by GDB in Fedora is
> 
>    s390-linux-gnu
>    powerpc-linux-gnu
>    arm-linux-gnu
>    aarch64-linux-gnu
>    riscv64-linux-gnu
>    x86_64-redhat-linux-gnu
> 
> you can query this with 'gdb --configuration' and parsing the
> '--enable-targets' args  - I've not found a better way :-(

Thanks a lot for checking it closely.

We already detect it via:

source_path/scripts/probe-gdb-support.py


in configure to detect the arches. That's what Alex is suggesting,
to use the gdb from configure in the test harness or scripts that
rely on GDB.


Cheers,
Gustavo

