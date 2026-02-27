Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FEEFEFB5E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzpg-0005Nx-2o; Fri, 27 Feb 2026 10:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vvzpe-0005Ng-P1
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:32:46 -0500
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vvzpZ-0007wa-E5
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:32:46 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 a6fe344c5d94d448cf523ff75100021ccf85ab1e3627f80753cd74fae668093e with SMTP id
 69a1b90e6a074a243d78415c; Fri, 27 Feb 2026 15:32:30 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1772206349;
 bh=QB58kNlAOGo8jNhr6GZVpey4GgUbomv3NmrnBVR69gI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=Y8xM2bmwY1dObhFmOySqyawTqTW4RqdhK+hf9P9aAQtAD3tN2ga6jE8JoPte0PJEW
 CoYnnpAMmaabikljL6ZUOU+dYmmqRwPOkzcaRrFuPMm5Pkac7yAfrTIwe9d7djv5wQ
 aJAULAat+jDmiOsmzrFHETRagjR6j8CX+iH7LogZKD6fBxeMOkYGhcS81ShEg0+mnn
 SI+ilGJ7DOTJ6lB/ROo8cYhHz/gBys9BJMFthCZGDpa6Nw0R+1+M7p3uatQ9mA+FP+
 Iq22JX3oVeGuzfM63PifN4gAZIqjU64tya8StHsA7d5VJ1MwNF7MYG0kFoOUGVGGMr
 FJqC7hG1b6msw==
Message-ID: <6b0d1396-63bd-48cd-bfc3-2b0dc34327e9@yodel.dev>
Date: Fri, 27 Feb 2026 09:32:27 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] scripts: Move lsan_suppressions.txt out of oss-fuzz
 subdir
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
 <20260227135736.2280161-2-peter.maydell@linaro.org>
 <CAFEAcA853KSRD7yJKjyoM-E2R4YNou=x+BCR9EWrjym==-tQjA@mail.gmail.com>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <CAFEAcA853KSRD7yJKjyoM-E2R4YNou=x+BCR9EWrjym==-tQjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi, Peter

On 27/02/2026 09:04, Peter Maydell wrote:
> I forgot to cc the 'device fuzzing' maintainers on this patch;
> sorry about that.
> 
> -- PMM
> 
> On Fri, 27 Feb 2026 at 13:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> The oss-fuzz code uses an lsan_suppressions file to suppress certain
>> leak-sanitizer cases that are known issues or not our code's bug.
>> This is useful more widely than just for the fuzzer harness: if you
>> want to build QEMU with the leak sanitizer enabled and run 'make
>> check' then you will want to suppress some bogus leak reports.
>>
>> Move the file up a directory, and add the usual SPDX identifier
>> and a comment describing how to use it.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   .gitlab-ci.d/buildtest.yml             |  2 +-
>>   scripts/lsan_suppressions.txt          | 11 +++++++++++
>>   scripts/oss-fuzz/lsan_suppressions.txt |  5 -----
>>   3 files changed, 12 insertions(+), 6 deletions(-)
>>   create mode 100644 scripts/lsan_suppressions.txt
>>   delete mode 100644 scripts/oss-fuzz/lsan_suppressions.txt
>>
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index 1b656b9eb0..7548057c54 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -626,7 +626,7 @@ build-oss-fuzz:
>>       IMAGE: fedora
>>     script:
>>       - mkdir build-oss-fuzz
>> -    - export LSAN_OPTIONS=suppressions=scripts/oss-fuzz/lsan_suppressions.txt
>> +    - export LSAN_OPTIONS=suppressions=scripts/lsan_suppressions.txt
>>       - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
>>         ./scripts/oss-fuzz/build.sh
>>       - export ASAN_OPTIONS="fast_unwind_on_malloc=0"
>> diff --git a/scripts/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
>> new file mode 100644
>> index 0000000000..ffade3ba5a
>> --- /dev/null
>> +++ b/scripts/lsan_suppressions.txt
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +# This is a set of suppressions for LeakSanitizer; you can use it by setting
>> +#   LSAN_OPTIONS="suppressions=/path/to/scripts/lsan_suppressions.txt"
>> +# when running a QEMU built with the leak-sanitizer.
>> +
>> +# The tcmalloc on Fedora37 confuses things
>> +leak:/lib64/libtcmalloc_minimal.so.4
>> +
>> +# libxkbcommon also leaks in qemu-keymap
>> +leak:/lib64/libxkbcommon.so.0
>> diff --git a/scripts/oss-fuzz/lsan_suppressions.txt b/scripts/oss-fuzz/lsan_suppressions.txt
>> deleted file mode 100644
>> index 7d90c280d0..0000000000
>> --- a/scripts/oss-fuzz/lsan_suppressions.txt
>> +++ /dev/null
>> @@ -1,5 +0,0 @@
>> -# The tcmalloc on Fedora37 confuses things
>> -leak:/lib64/libtcmalloc_minimal.so.4
>> -
>> -# libxkbcommon also leaks in qemu-keymap
>> -leak:/lib64/libxkbcommon.so.0
>> --
>> 2.43.0
> 

The similarity index is under 40%, so `git log --follow` doesn't follow
the move; not a big deal, but separate patches for the move and the new
lines would avoid this and make it easier for folks to get the full
history in one go.

Also, there's a missed reference in the docker test script (diff below).

Thanks,
Yodel

-- >8 --

diff --git a/tests/docker/test-fuzz b/tests/docker/test-fuzz
index 7e506ae1f6..d2bdc8afba 100755
--- a/tests/docker/test-fuzz
+++ b/tests/docker/test-fuzz
@@ -18,7 +18,7 @@ cd "$BUILD_DIR"
  cp -a $QEMU_SRC .
  cd src
  mkdir build-oss-fuzz
-export LSAN_OPTIONS=suppressions=scripts/oss-fuzz/lsan_suppressions.txt
+export LSAN_OPTIONS=suppressions=scripts/lsan_suppressions.txt
  env CC="clang" CXX="clang++" CFLAGS="-fsanitize=address" 
./scripts/oss-fuzz/build.sh
  export ASAN_OPTIONS="fast_unwind_on_malloc=0"
  for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f | 
grep -v slirp); do



