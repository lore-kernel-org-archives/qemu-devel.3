Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631E3D3ABD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 17:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAY56-0003ik-Ew; Mon, 11 Nov 2024 12:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khoroshilov@ispras.ru>)
 id 1tAY54-0003i6-UJ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:20:02 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khoroshilov@ispras.ru>)
 id 1tAY52-00017q-39
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:20:02 -0500
Received: from [10.49.130.42] (unknown [185.79.103.100])
 by mail.ispras.ru (Postfix) with ESMTPSA id A4BD2413BDE7;
 Mon, 11 Nov 2024 17:19:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A4BD2413BDE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1731345594;
 bh=cvvpk98777ix2cDmEPLsJwsUTRmLqkM7uILYOwfbfRs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=FPVomFxuChV6U6fGZx9Y0qJeaKvggwNnfvJI3WCFQsnc/ParQBc/t99pgpSRMlYfm
 v5sfR1yK9vG7j3kBgZpuYBpYwq+RP1jZ6+CgRACGx4wKSnf02esA9SaBQxhqDo3vAu
 pfPa+s0/ay8HtX26Trm9KVf1p+shw7AQWGdfViiw=
Subject: Re: [sdl-qemu] [PATCH] tests/qtest: fix heap-use-after-free
To: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>,
 Prasad Pandit <ppandit@redhat.com>
Cc: lvivier@redhat.com, farosas@suse.de, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
References: <20241111090534.66439-2-frolov@swemel.ru>
 <CAE8KmOw75c9Vja5dnGy50b2Dqp9wgfMfxRWjHDdqEUkLBUcP+A@mail.gmail.com>
 <60535722-1a11-42f9-a678-d103e227942f@swemel.ru>
 <CAE8KmOyvCJoOHAw7+Y=2-pDD3co5kcwshJCjGfdsmEpsQLRgow@mail.gmail.com>
 <23ef463e-744d-472c-bd25-30f68a97a8cf@swemel.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <f8673240-2bae-d759-9d1a-de3a320b3c14@ispras.ru>
Date: Mon, 11 Nov 2024 20:19:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <23ef463e-744d-472c-bd25-30f68a97a8cf@swemel.ru>
Content-Type: multipart/alternative;
 boundary="------------5D41C97EADCAC79B5849950F"
Content-Language: en-US
Received-SPF: pass client-ip=83.149.199.84; envelope-from=khoroshilov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-1.909, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------5D41C97EADCAC79B5849950F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 11.11.2024 16:35, Дмитрий Фролов wrote:
>
>
> On 11.11.2024 15:51, Prasad Pandit wrote:
>> On Mon, 11 Nov 2024 at 17:41, Дмитрий Фролов <frolov@swemel.ru> wrote:
>>> Above loop dereferences the pointer env, which is pointing to
>>> the memory area, which is not allowed to read.
>> * Not allowed to read environment variables? Is it because
>> Debian/clang does not support the '**envp' parameter? Is '**envp' set
>> to NULL on Debian? If '**envp' is not supported, then the compiler
>> should throw an error at build time, no?
> Not allowed to read the exact memory area, because it is marked as freed.
As far as I understand, heap-use-after-free means a situation when code
allocates memory then frees it and then access it.
Here the code just accesses invalid memory because of nonstandard main()
call convention.

If it is correct, the patch title could be "tests/qtest: make access to
environment variables portable"

--
Alexey

>>> I am pointing on 2 facts:
>>> 1. "env" is Microsoft`s extension, not a standard
>>> 2. There is exact example, where standards violation raises
>>> undefined behavior: debian13/clang16
>>>
>> * If this is about Debian not supporting '**envp' parameter, then
>> it'll help if the commit message says "...Debian does not support this
>> non-standard extension and crashes QEMU". 
> Since this is UB, it does not matter, if a crash happens or not.
> ASAN just helps to highlight the hidden problem.
>  
>> The asan error makes it
>> sound like the patch fixes the use-after-free issue. 
> I didn`t want to confuse anybody, but this is exactly,
> what is actually happening (see log below).
>
>> What happens if
>> the -lasan is not used? Does it still crash QEMUt?
>>
>> Thank you.
>> ---
>>   - Prasad
>>
> When saintizers are disabled, qos-test passes successfully.
> qos-test fails when qemu is built with enabled sanitizers
> (--enable-asan --enable-ubsan)
>
> ==879133==ERROR: AddressSanitizer: heap-use-after-free on address
> 0x514000000040 at pc 0x55eae79b407c bp 0x7ffd028715d0 sp 0x7ffd028715c8
> READ of size 8 at 0x514000000040 thread T0
>     #0 0x55eae79b407b in main
> /home/df/projects/upstream/qemu/build/../tests/qtest/qos-test.c:339:33
>     #1 0x7f9011760c89  (/lib/x86_64-linux-gnu/libc.so.6+0x27c89)
> (BuildId: 61cf5c68463ab7677fa14f071a036eda24d0cc38)
>     #2 0x7f9011760d44 in __libc_start_main
> (/lib/x86_64-linux-gnu/libc.so.6+0x27d44) (BuildId:
> 61cf5c68463ab7677fa14f071a036eda24d0cc38)
>     #3 0x55eae77a5c60 in _start
> (/home/df/projects/upstream/qemu/build/tests/qtest/qos-test+0x209c60)
> (BuildId: 2c9032193c32f574ceec39c89e10b1693e20d69e)
>
> 0x514000000040 is located 0 bytes inside of 416-byte region
> [0x514000000040,0x5140000001e0)
> freed by thread T0 here:
>     #0 0x55eae7840ce9 in __interceptor_realloc
> (/home/df/projects/upstream/qemu/build/tests/qtest/qos-test+0x2a4ce9)
> (BuildId: 2c9032193c32f574ceec39c89e10b1693e20d69e)
>     #1 0x7f901177b596  (/lib/x86_64-linux-gnu/libc.so.6+0x42596)
> (BuildId: 61cf5c68463ab7677fa14f071a036eda24d0cc38)
>
> previously allocated by thread T0 here:
>     #0 0x55eae7840ce9 in __interceptor_realloc
> (/home/df/projects/upstream/qemu/build/tests/qtest/qos-test+0x2a4ce9)
> (BuildId: 2c9032193c32f574ceec39c89e10b1693e20d69e)
>     #1 0x7f901177b596  (/lib/x86_64-linux-gnu/libc.so.6+0x42596)
> (BuildId: 61cf5c68463ab7677fa14f071a036eda24d0cc38)
>
> SUMMARY: AddressSanitizer: heap-use-after-free
> /home/df/projects/upstream/qemu/build/../tests/qtest/qos-test.c:339:33
> in main
> Shadow bytes around the buggy address:
>   0x513ffffffd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x513ffffffe00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x513ffffffe80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x513fffffff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x513fffffff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =>0x514000000000: fa fa fa fa fa fa fa fa[fd]fd fd fd fd fd fd fd
>   0x514000000080: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x514000000100: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x514000000180: fd fd fd fd fd fd fd fd fd fd fd fd fa fa fa fa
>   0x514000000200: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
>   0x514000000280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:       fa
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
>   Left alloca redzone:     ca
>   Right alloca redzone:    cb
> ==879133==ABORTING
> Aborted
>
>
> With best regards,
> Dmitry.
>
> _______________________________________________
> sdl.qemu mailing list
> sdl.qemu@linuxtesting.org
> http://linuxtesting.org/cgi-bin/mailman/listinfo/sdl.qemu


--------------5D41C97EADCAC79B5849950F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 11.11.2024 16:35, Дмитрий Фролов
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:23ef463e-744d-472c-bd25-30f68a97a8cf@swemel.ru">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <br>
      <br>
      <div class="moz-cite-prefix">On 11.11.2024 15:51, Prasad Pandit
        wrote:<br>
      </div>
      <blockquote type="cite"
cite="mid:CAE8KmOyvCJoOHAw7+Y=2-pDD3co5kcwshJCjGfdsmEpsQLRgow@mail.gmail.com">
        <pre class="moz-quote-pre" wrap="">On Mon, 11 Nov 2024 at 17:41, Дмитрий Фролов <a class="moz-txt-link-rfc2396E" href="mailto:frolov@swemel.ru" moz-do-not-send="true">&lt;frolov@swemel.ru&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Above loop dereferences the pointer env, which is pointing to
the memory area, which is not allowed to read.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">* Not allowed to read environment variables? Is it because
Debian/clang does not support the '**envp' parameter? Is '**envp' set
to NULL on Debian? If '**envp' is not supported, then the compiler
should throw an error at build time, no?
</pre>
      </blockquote>
      <span style="white-space: pre-wrap">Not allowed to read the exact memory area, because it is marked as freed.</span></blockquote>
    As far as I understand, heap-use-after-free means a situation when
    code allocates memory then frees it and then access it.<br>
    Here the code just accesses invalid memory because of nonstandard
    main() call convention.<br>
    <br>
    If it is correct, the patch title could be "tests/qtest: make access
    to environment variables portable"<br>
    <br>
    --<br>
    Alexey<br>
    <br>
    <blockquote type="cite"
      cite="mid:23ef463e-744d-472c-bd25-30f68a97a8cf@swemel.ru"><span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
      <blockquote type="cite"
cite="mid:CAE8KmOyvCJoOHAw7+Y=2-pDD3co5kcwshJCjGfdsmEpsQLRgow@mail.gmail.com">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">I am pointing on 2 facts:
1. "env" is Microsoft`s extension, not a standard
2. There is exact example, where standards violation raises
undefined behavior: debian13/clang16

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">* If this is about Debian not supporting '**envp' parameter, then
it'll help if the commit message says "...Debian does not support this
non-standard extension and crashes QEMU". </pre>
      </blockquote>
      Since this is UB, it does not matter, if a crash happens or not. <br>
      ASAN just helps to highlight the hidden problem.<br>
       <br>
      <blockquote type="cite"
cite="mid:CAE8KmOyvCJoOHAw7+Y=2-pDD3co5kcwshJCjGfdsmEpsQLRgow@mail.gmail.com">
        <pre class="moz-quote-pre" wrap="">The asan error makes it
sound like the patch fixes the use-after-free issue. </pre>
      </blockquote>
      I didn`t want to confuse anybody, but this is exactly,<br>
      what is actually happening (see log below).<br>
      <br>
      <blockquote type="cite"
cite="mid:CAE8KmOyvCJoOHAw7+Y=2-pDD3co5kcwshJCjGfdsmEpsQLRgow@mail.gmail.com">
        <pre class="moz-quote-pre" wrap="">What happens if
the -lasan is not used? Does it still crash QEMUt?

Thank you.
---
  - Prasad

</pre>
      </blockquote>
      When saintizers are disabled, qos-test passes successfully. <br>
      qos-test fails when qemu is built with enabled sanitizers<br>
      (--enable-asan --enable-ubsan)<br>
      <br>
      ==879133==ERROR: AddressSanitizer: heap-use-after-free on address
      0x514000000040 at pc 0x55eae79b407c bp 0x7ffd028715d0 sp
      0x7ffd028715c8<br>
      READ of size 8 at 0x514000000040 thread T0<br>
          #0 0x55eae79b407b in main
      /home/df/projects/upstream/qemu/build/../tests/qtest/qos-test.c:339:33<br>
          #1 0x7f9011760c89  (/lib/x86_64-linux-gnu/libc.so.6+0x27c89)
      (BuildId: 61cf5c68463ab7677fa14f071a036eda24d0cc38)<br>
          #2 0x7f9011760d44 in __libc_start_main
      (/lib/x86_64-linux-gnu/libc.so.6+0x27d44) (BuildId:
      61cf5c68463ab7677fa14f071a036eda24d0cc38)<br>
          #3 0x55eae77a5c60 in _start
      (/home/df/projects/upstream/qemu/build/tests/qtest/qos-test+0x209c60)
      (BuildId: 2c9032193c32f574ceec39c89e10b1693e20d69e)<br>
      <br>
      0x514000000040 is located 0 bytes inside of 416-byte region
      [0x514000000040,0x5140000001e0)<br>
      freed by thread T0 here:<br>
          #0 0x55eae7840ce9 in __interceptor_realloc
      (/home/df/projects/upstream/qemu/build/tests/qtest/qos-test+0x2a4ce9)
      (BuildId: 2c9032193c32f574ceec39c89e10b1693e20d69e)<br>
          #1 0x7f901177b596  (/lib/x86_64-linux-gnu/libc.so.6+0x42596)
      (BuildId: 61cf5c68463ab7677fa14f071a036eda24d0cc38)<br>
      <br>
      previously allocated by thread T0 here:<br>
          #0 0x55eae7840ce9 in __interceptor_realloc
      (/home/df/projects/upstream/qemu/build/tests/qtest/qos-test+0x2a4ce9)
      (BuildId: 2c9032193c32f574ceec39c89e10b1693e20d69e)<br>
          #1 0x7f901177b596  (/lib/x86_64-linux-gnu/libc.so.6+0x42596)
      (BuildId: 61cf5c68463ab7677fa14f071a036eda24d0cc38)<br>
      <br>
      SUMMARY: AddressSanitizer: heap-use-after-free
      /home/df/projects/upstream/qemu/build/../tests/qtest/qos-test.c:339:33
      in main<br>
      Shadow bytes around the buggy address:<br>
        0x513ffffffd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
        0x513ffffffe00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
        0x513ffffffe80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
        0x513fffffff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
        0x513fffffff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
      =&gt;0x514000000000: fa fa fa fa fa fa fa fa[fd]fd fd fd fd fd fd
      fd<br>
        0x514000000080: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd<br>
        0x514000000100: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd<br>
        0x514000000180: fd fd fd fd fd fd fd fd fd fd fd fd fa fa fa fa<br>
        0x514000000200: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00<br>
        0x514000000280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
      Shadow byte legend (one shadow byte represents 8 application
      bytes):<br>
        Addressable:           00<br>
        Partially addressable: 01 02 03 04 05 06 07 <br>
        Heap left redzone:       fa<br>
        Freed heap region:       fd<br>
        Stack left redzone:      f1<br>
        Stack mid redzone:       f2<br>
        Stack right redzone:     f3<br>
        Stack after return:      f5<br>
        Stack use after scope:   f8<br>
        Global redzone:          f9<br>
        Global init order:       f6<br>
        Poisoned by user:        f7<br>
        Container overflow:      fc<br>
        Array cookie:            ac<br>
        Intra object redzone:    bb<br>
        ASan internal:           fe<br>
        Left alloca redzone:     ca<br>
        Right alloca redzone:    cb<br>
      ==879133==ABORTING<br>
      Aborted<br>
      <br>
      <br>
      With best regards, <br>
      Dmitry.<br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
sdl.qemu mailing list
<a class="moz-txt-link-abbreviated" href="mailto:sdl.qemu@linuxtesting.org">sdl.qemu@linuxtesting.org</a>
<a class="moz-txt-link-freetext" href="http://linuxtesting.org/cgi-bin/mailman/listinfo/sdl.qemu">http://linuxtesting.org/cgi-bin/mailman/listinfo/sdl.qemu</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------5D41C97EADCAC79B5849950F--

