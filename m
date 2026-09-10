Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B305C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4bq3-00064k-H1; Thu, 10 Sep 2026 06:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4bq2-00064V-Cb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:17:02 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4bq0-0002J3-3D
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:17:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso65864265e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 03:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789035418; x=1789640218; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qpNsTrKHaf4ZkmutgLJD1HINvhJYAViMaQ4+cjIFEfY=;
 b=FHuT3XPmr9HhbkSElwsksP6L7WFg08jOfbR8fU44OJJOoL5TB6eqPYleWE+QvX0zzs
 NqnxYm9m8liYm80NYLFyxKDeI3biKB+z261Vnw8mBHdEjQbri9o1HCT+DEfjB1eM0FqT
 hUsTPd+SrPuhdCcJWRoHKeyLoBjXESAd/kSdVKsIxOwSXCLOm1uRKOXPeloXAnY9q1W0
 fi4S3ljzRo9EI82+OmFcBzLCeYWFOb/MRIRP7djTqbeLsB7CJud6SaXXT+oB5z9vKU7E
 YEzzbmocSMZnnW3qx7XKPgK3kKDP5bIWdDoOhm5SDmzyroQyrpeejBzz9Q3SlUZrFbFf
 JVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789035418; x=1789640218;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qpNsTrKHaf4ZkmutgLJD1HINvhJYAViMaQ4+cjIFEfY=;
 b=EknaE8dF8DzrqdpW0+XQJ2Tzjwd2Kh30U6UB2XzfrRs5n3A78SDX7lHahP+QvSfgNA
 Rt/tM+zsGBvX26ZzBAmDeI5xnUjuHlXLHjgV0ogrwqhJVILYfpE1B1umZMR7qX74njoM
 KqMkw28o4q4ItuDcfmq44AH2MlrkWCEgbnEKo6q7QQmu4iQ7jormp9c6Z+rRJ2rz5QtF
 sAzAWh7t2agf9XW24crBapW6A8pPr2BrzHtTxFx4WsABlpPUjjIArRY3cwUQPwZeSjDJ
 yyY651XJHa0OGr6aFuszX2Ycr/bKdfSb+h8Gzwy4OTK5SMLOETRDqPeHbGUnkPUEqzQY
 VmTA==
X-Gm-Message-State: AFuF++luiK0wfCNamGpi3jcsNcXoD+secbdoAZsEqr9Ts+jMNVxGJqTx
 ComYS9lhPKKeFP94lG+y56pxrY78FUbnYMist9GTVudymBA2T+0aYqMeTrxj7tgJFJE=
X-Gm-Gg: AYBFou2i9U8j7VwrlvYshWK+XgyqK//m8AZL03jW1Xfs1kkYHjKKc/cnyIW85M7xgM2
 HZ4fQYgFTbRzEYv8A7aw+vuJvSQD8rzEmJXUGT4hHE64wGAYSHtwnsOwRm2hDpW8950gE1uJhLe
 xq4HucOpf5pNLmGKXAKS4hU9noJau5jLW953mk8O77Js9wvCIvECkykUqzSh6wUSoeWk206unQE
 pBlpeA18E3C1A14SBN6qwqsq9zkGNtvKRFmEn3dlsZS/5GUzi9SDLu/MKeEOvCqZGd4lFfLazEn
 iucPvNqa1np9Mj2yIMvM9E8GshPBDOzlsRf7j6DGihW+i2GtXQ9WDjdD7eDZSY84ethGQB9z5jv
 5olKn7SOAX6InWeemXKFWM9b6BIWtPG394Hlyp4MClMquEF7lwxgegkG3kkXPt5t0A5+bPg0dOS
 pD1trlU4FFPIunrW+hAMOVSgLmv9/D5T6I6LkWpiRBg61CFBOOLOrG2ZDjaoYyCYyqsA7zDCU=
X-Received: by 2002:a05:600c:358d:b0:49d:797:8488 with SMTP id
 5b1f17b1804b1-49d0797853emr305064165e9.1.1789035417440; 
 Thu, 10 Sep 2026 03:16:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c494basm58045825e9.12.2026.09.10.03.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 03:16:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 27B015F8F3;
 Thu, 10 Sep 2026 11:16:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <laurent@vivier.eu>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [RFC PATCH] linux-user: madvise() on unmapped ranges should
 return ENOMEM
In-Reply-To: <4238afee-7706-47de-9cd0-effe503a9f5d@gmx.de> (Helge Deller's
 message of "Wed, 9 Sep 2026 23:17:54 +0200")
References: <20260903142720.1467316-1-alex.bennee@linaro.org>
 <4238afee-7706-47de-9cd0-effe503a9f5d@gmx.de>
User-Agent: mu4e 1.14.4-pre2; emacs 30.1
Date: Thu, 10 Sep 2026 11:16:55 +0100
Message-ID: <878q599zs8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Helge Deller <deller@gmx.de> writes:

> Hi Alex,
>
> On 9/3/26 16:27, Alex Benn=C3=A9e wrote:
>> Per madvise(2) and the Linux kernel implementation (madvise_walk_vmas),
>> madvise() must validate that the requested range is currently mapped
>> and return -ENOMEM if any page in the range is unmapped.
>> Add a page_check_range(start, len, PAGE_VALID) check for valid
>> advice
>> values before proceeding with the advice actions. In addition, extend the
>> tcg multiarch test linux-madvise.c to test this behaviour.
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4382
>> AI-used-for: importing and validating test case
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> NOTE
>>    - again testing the minimal agents which did stop and say:
>> *(Note: Per user policy, git commits are never executed
>> automatically by the agent. Please review the diff with `git diff`
>> and commit the changes if you are satisfied.)*
>>    but non-the-less imported the test and wrote a crap patch which I
>>    have re-done dropping a load of unneeded verbosity.
>
>
> Did you test this patch?
> If yes, did it work for you?

Yes - ran the test case before and after the changes and it asserts
before.

  ./qemu-aarch64 -strace -d guest_errors,unimp aarch64-linux-user-linux-mad=
vise.test
  681364 uname(0x7f403e54d3c8) =3D 0
  681364 brk(NULL) =3D 0x00000000004a7000
  681364 brk(0x00000000004a7b00) =3D 0x00000000004a7b00
  681364 set_tid_address(0x4a70f0) =3D 681364
  681364 set_robust_list(0x4a7100,24) =3D -1 errno=3D38 (Function not imple=
mented)
  681364 rseq(0x4a77c0,32,0,0xd428bc00)Unsupported syscall: 293
   =3D -1 errno=3D38 (Function not implemented)
  681364 prlimit64(0,RLIMIT_STACK,NULL,0x00007f403e54d518) =3D 0 ({rlim_cur=
=3D8388608,rlim_max=3D-1})
  681364 readlinkat(AT_FDCWD,"/proc/self/exe",0x00007f403e54c4a0,4096) =3D =
73
  681364 getrandom(0x4a6808,8,1) =3D 8
  681364 brk(NULL) =3D 0x00000000004a7b00
  681364 brk(0x00000000004c8b00) =3D 0x00000000004c8b00
  681364 brk(0x00000000004c9000) =3D 0x00000000004c9000
  681364 mprotect(0x000000000049b000,20480,PROT_READ) =3D 0
  681364 mmap(NULL,4096,PROT_READ,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) =3D 0x000=
07f40405f2000
  681364 mprotect(0x00007f40405f2000,4096,PROT_READ|PROT_WRITE) =3D 0
  681364 madvise(0x00007f40405f2000,4096,MADV_DONTNEED) =3D 0
  681364 munmap(0x00007f40405f2000,4096) =3D 0
  681364 getrandom(0x7f403e54d360,8,1) =3D 8
  681364 openat(AT_FDCWD,"/tmp/.cmadvisebhAABn",O_RDWR|O_CREAT|O_EXCL,0600)=
 =3D 3
  681364 unlinkat(AT_FDCWD,"/tmp/.cmadvisebhAABn",0) =3D 0
  681364 write(3,0x7f403e54d3f7,1) =3D 1
  681364 ftruncate(3,4096) =3D 0
  681364 mmap(NULL,4096,PROT_READ,MAP_PRIVATE,3,0) =3D 0x00007f40405f2000
  681364 mprotect(0x00007f40405f2000,4096,PROT_READ|PROT_WRITE) =3D 0
  681364 madvise(0x00007f40405f2000,4096,MADV_DONTNEED) =3D 0
  681364 munmap(0x00007f40405f2000,4096) =3D 0
  681364 close(3) =3D 0
  681364 mmap(NULL,4096,PROT_READ,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) =3D 0x000=
07f40405f2000
  681364 munmap(0x00007f40405f2000,4096) =3D 0
  681364 madvise(0x00007f40405f2000,4096,MADV_NORMAL) =3D 0
  681364 write(2,0x7f403e54cbc8,128)aarch64-linux-user-linux-madvise.test: =
/home/alex/lsrc/qemu.git/tests/tcg/multiarch/linux/linux-madvise.c:81: test=
_unmapped: Ass =3D 128
  681364 write(2,0x7f403e54cbc8,27)ertion `ret =3D=3D -1' failed.
   =3D 27
  681364 mmap(NULL,4096,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0=
) =3D 0x00007f40405f2000
  681364 gettid() =3D 681364
  681364 getpid() =3D 681364
  681364 tgkill(681364,681364,SIGIOT) =3D 0
  --- SIGIOT {si_signo=3DSIGIOT, si_code=3DSI_TKILL, si_pid=3D681364, si_ui=
d=3D1000} ---
  qemu: uncaught target signal 6 (Aborted) - core dumped
  fish: Job 1, './qemu-aarch64 -strace -d guest=E2=80=A6' terminated by sig=
nal SIGABRT (Abort)

> I'm asking, because I tried the testcase from the bug report, and
> in qemu I still get 0 (success).

I suspect you've been tripped up by the conversion of tests to meson as
they now have the .test suffix. So with the patch applied and tests
passing:

  cp tests/tcg/aarch64-linux-user-linux-madvise.test .

and then drop back one patch and rebuild and test against the copy of
the test with the test_unmapped support.


>
> Helge
>
>> ---
>>   linux-user/mmap.c                         | 12 ++++++++++++
>>   tests/tcg/multiarch/linux/linux-madvise.c | 20 ++++++++++++++++++++
>>   2 files changed, 32 insertions(+)
>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>> index cc0c2ee6c27..4066072ff45 100644
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -1307,6 +1307,16 @@ abi_long target_madvise(abi_ulong start, abi_ulon=
g len_in, int advice)
>>        * though.
>>        */
>>       mmap_lock();
>> +
>> +    /*
>> +     * Whatever advice if the pages are not currently mapped, or are
>> +     * outside the address space of the process.
>> +     */
>> +    if (!page_check_range(start, len, PAGE_VALID)) {
>> +        ret =3D -TARGET_ENOMEM;
>> +        goto unlock;
>> +    }
>> +
>>       switch (advice) {
>>       case MADV_NORMAL:
>>       case MADV_RANDOM:
>> @@ -1358,6 +1368,8 @@ abi_long target_madvise(abi_ulong start, abi_ulong=
 len_in, int advice)
>>           ret =3D -EINVAL; /* not yet known advise */
>>           break;
>>       }
>> +
>> + unlock:
>>       mmap_unlock();
>>         return ret;
>> diff --git a/tests/tcg/multiarch/linux/linux-madvise.c b/tests/tcg/multi=
arch/linux/linux-madvise.c
>> index 539fb3b7726..ebb9666c919 100644
>> --- a/tests/tcg/multiarch/linux/linux-madvise.c
>> +++ b/tests/tcg/multiarch/linux/linux-madvise.c
>> @@ -1,4 +1,5 @@
>>   #include <assert.h>
>> +#include <errno.h>
>>   #include <stdlib.h>
>>   #include <sys/mman.h>
>>   #include <unistd.h>
>> @@ -63,10 +64,29 @@ static void test_file(void)
>>       assert(ret =3D=3D 0);
>>   }
>>   +static void test_unmapped(void)
>> +{
>> +    int pagesize =3D getpagesize();
>> +    void *page;
>> +    int ret;
>> +
>> +    page =3D mmap(NULL, pagesize, PROT_READ, MAP_ANONYMOUS | MAP_PRIVAT=
E, -1, 0);
>> +    assert(page !=3D MAP_FAILED);
>> +
>> +    ret =3D munmap(page, pagesize);
>> +    assert(ret =3D=3D 0);
>> +
>> +    errno =3D 0;
>> +    ret =3D madvise(page, pagesize, MADV_NORMAL);
>> +    assert(ret =3D=3D -1);
>> +    assert(errno =3D=3D ENOMEM);
>> +}
>> +
>>   int main(void)
>>   {
>>       test_anonymous();
>>       test_file();
>> +    test_unmapped();
>>         return EXIT_SUCCESS;
>>   }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

