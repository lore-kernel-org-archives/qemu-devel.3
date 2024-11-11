Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C842DD2E9F0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 13:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAUZb-0004iW-47; Mon, 11 Nov 2024 08:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tAUZR-0004hO-Te
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 08:35:12 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tAUZO-00023K-FN
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 08:35:09 -0500
Content-Type: multipart/alternative;
 boundary="------------Dfg0IWqDZ2i9BaSiyChFiylu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1731332102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SYQKzbm5Q19bdKr+HCKXjMksHNAqblmUM1oglhNIYHA=;
 b=qNxK6mKa/iW5wTqX2ZH0IgzY0VyJMI2FXHIeiz06dC8JXfnEKs4F2PV67WnrqvmlK4iZwY
 XA97HAMf4ntoYgKa0oo1vNQj35IkUc0+SgNRn62zDL2VjyUhmnW3X+DCLY1Bvec8DOVpwa
 kfasQ8lpjtlMyseX2piQSCM4oKkCi50=
Message-ID: <23ef463e-744d-472c-bd25-30f68a97a8cf@swemel.ru>
Date: Mon, 11 Nov 2024 16:35:02 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] tests/qtest: fix heap-use-after-free
Content-Language: en-US
To: Prasad Pandit <ppandit@redhat.com>
Cc: farosas@suse.de, lvivier@redhat.com, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
References: <20241111090534.66439-2-frolov@swemel.ru>
 <CAE8KmOw75c9Vja5dnGy50b2Dqp9wgfMfxRWjHDdqEUkLBUcP+A@mail.gmail.com>
 <60535722-1a11-42f9-a678-d103e227942f@swemel.ru>
 <CAE8KmOyvCJoOHAw7+Y=2-pDD3co5kcwshJCjGfdsmEpsQLRgow@mail.gmail.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <CAE8KmOyvCJoOHAw7+Y=2-pDD3co5kcwshJCjGfdsmEpsQLRgow@mail.gmail.com>
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--------------Dfg0IWqDZ2i9BaSiyChFiylu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.11.2024 15:51, Prasad Pandit wrote:
> On Mon, 11 Nov 2024 at 17:41, Дмитрий Фролов<frolov@swemel.ru>  wrote:
>> Above loop dereferences the pointer env, which is pointing to
>> the memory area, which is not allowed to read.
> * Not allowed to read environment variables? Is it because
> Debian/clang does not support the '**envp' parameter? Is '**envp' set
> to NULL on Debian? If '**envp' is not supported, then the compiler
> should throw an error at build time, no?
Not allowed to read the exact memory area, because it is marked as freed.
>> I am pointing on 2 facts:
>> 1. "env" is Microsoft`s extension, not a standard
>> 2. There is exact example, where standards violation raises
>> undefined behavior: debian13/clang16
>>
> * If this is about Debian not supporting '**envp' parameter, then
> it'll help if the commit message says "...Debian does not support this
> non-standard extension and crashes QEMU".
Since this is UB, it does not matter, if a crash happens or not.
ASAN just helps to highlight the hidden problem.

> The asan error makes it
> sound like the patch fixes the use-after-free issue.
I didn`t want to confuse anybody, but this is exactly,
what is actually happening (see log below).

> What happens if
> the -lasan is not used? Does it still crash QEMUt?
>
> Thank you.
> ---
>    - Prasad
>
When saintizers are disabled, qos-test passes successfully.
qos-test fails when qemu is built with enabled sanitizers
(--enable-asan --enable-ubsan)

==879133==ERROR: AddressSanitizer: heap-use-after-free on address 
0x514000000040 at pc 0x55eae79b407c bp 0x7ffd028715d0 sp 0x7ffd028715c8
READ of size 8 at 0x514000000040 thread T0
     #0 0x55eae79b407b in main 
/home/df/projects/upstream/qemu/build/../tests/qtest/qos-test.c:339:33
     #1 0x7f9011760c89  (/lib/x86_64-linux-gnu/libc.so.6+0x27c89) 
(BuildId: 61cf5c68463ab7677fa14f071a036eda24d0cc38)
     #2 0x7f9011760d44 in __libc_start_main 
(/lib/x86_64-linux-gnu/libc.so.6+0x27d44) (BuildId: 
61cf5c68463ab7677fa14f071a036eda24d0cc38)
     #3 0x55eae77a5c60 in _start 
(/home/df/projects/upstream/qemu/build/tests/qtest/qos-test+0x209c60) 
(BuildId: 2c9032193c32f574ceec39c89e10b1693e20d69e)

0x514000000040 is located 0 bytes inside of 416-byte region 
[0x514000000040,0x5140000001e0)
freed by thread T0 here:
     #0 0x55eae7840ce9 in __interceptor_realloc 
(/home/df/projects/upstream/qemu/build/tests/qtest/qos-test+0x2a4ce9) 
(BuildId: 2c9032193c32f574ceec39c89e10b1693e20d69e)
     #1 0x7f901177b596  (/lib/x86_64-linux-gnu/libc.so.6+0x42596) 
(BuildId: 61cf5c68463ab7677fa14f071a036eda24d0cc38)

previously allocated by thread T0 here:
     #0 0x55eae7840ce9 in __interceptor_realloc 
(/home/df/projects/upstream/qemu/build/tests/qtest/qos-test+0x2a4ce9) 
(BuildId: 2c9032193c32f574ceec39c89e10b1693e20d69e)
     #1 0x7f901177b596  (/lib/x86_64-linux-gnu/libc.so.6+0x42596) 
(BuildId: 61cf5c68463ab7677fa14f071a036eda24d0cc38)

SUMMARY: AddressSanitizer: heap-use-after-free 
/home/df/projects/upstream/qemu/build/../tests/qtest/qos-test.c:339:33 
in main
Shadow bytes around the buggy address:
   0x513ffffffd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x513ffffffe00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x513ffffffe80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x513fffffff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x513fffffff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x514000000000: fa fa fa fa fa fa fa fa[fd]fd fd fd fd fd fd fd
   0x514000000080: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
   0x514000000100: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
   0x514000000180: fd fd fd fd fd fd fd fd fd fd fd fd fa fa fa fa
   0x514000000200: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
   0x514000000280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
   Addressable:           00
   Partially addressable: 01 02 03 04 05 06 07
   Heap left redzone:       fa
   Freed heap region:       fd
   Stack left redzone:      f1
   Stack mid redzone:       f2
   Stack right redzone:     f3
   Stack after return:      f5
   Stack use after scope:   f8
   Global redzone:          f9
   Global init order:       f6
   Poisoned by user:        f7
   Container overflow:      fc
   Array cookie:            ac
   Intra object redzone:    bb
   ASan internal:           fe
   Left alloca redzone:     ca
   Right alloca redzone:    cb
==879133==ABORTING
Aborted


With best regards,
Dmitry.
--------------Dfg0IWqDZ2i9BaSiyChFiylu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 11.11.2024 15:51, Prasad Pandit
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAE8KmOyvCJoOHAw7+Y=2-pDD3co5kcwshJCjGfdsmEpsQLRgow@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Mon, 11 Nov 2024 at 17:41, Дмитрий Фролов <a class="moz-txt-link-rfc2396E" href="mailto:frolov@swemel.ru">&lt;frolov@swemel.ru&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Above loop dereferences the pointer env, which is pointing to
the memory area, which is not allowed to read.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
* Not allowed to read environment variables? Is it because
Debian/clang does not support the '**envp' parameter? Is '**envp' set
to NULL on Debian? If '**envp' is not supported, then the compiler
should throw an error at build time, no?
</pre>
    </blockquote>
    <span style="white-space: pre-wrap">Not allowed to read the exact memory area, because it is marked as freed.
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
      <pre class="moz-quote-pre" wrap="">
* If this is about Debian not supporting '**envp' parameter, then
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
    =&gt;0x514000000000: fa fa fa fa fa fa fa fa[fd]fd fd fd fd fd fd fd<br>
      0x514000000080: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd<br>
      0x514000000100: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd<br>
      0x514000000180: fd fd fd fd fd fd fd fd fd fd fd fd fa fa fa fa<br>
      0x514000000200: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00<br>
      0x514000000280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
    Shadow byte legend (one shadow byte represents 8 application bytes):<br>
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
  </body>
</html>

--------------Dfg0IWqDZ2i9BaSiyChFiylu--

