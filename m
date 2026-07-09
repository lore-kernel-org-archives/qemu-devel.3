Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1863C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 02:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wheGA-000430-Lf; Wed, 08 Jul 2026 22:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wheG7-00040C-7t
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:13:03 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wheG4-0002eu-CM
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783563174;
 bh=J3rnRvBcPFYMdbXtlj+DgAzmWtnixrwsFMTZY8UI+3w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=T77WCPOmqbfNw1xL+BBd1N2zO66UNN8gr7UtqnRSLZFCfIFgecMuAPxUcie8HYiwg
 eWe/fgyrTHcA8jRxBkvrLa2WFHJqXv5JmzcyFdt4mWit3rACtxcIm6ZiZsMr5/MNlW
 XrLdgORyeeg7QKDIPa1PZmdcUlLOLbwzY2fyNzDAVARPoanuV9L1ffT8Tvb+IjcuV0
 Hk8cDlQSIPyKbTRb3UTU81GyBwbfwziu6gomKHmocWY589f6IdDGufHS1aSS0uujrA
 5VYA+Zoq9vdzbNROPSHp6qXWE4DfLPpqMEGCk0o0ed0xBJ6fdyG9JHKNyzlVpplEWh
 XSSrJU7YZbQ3g==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 4D4B730015A;
 Thu,  9 Jul 2026 02:12:54 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id B4315380CA4;
 Thu,  9 Jul 2026 10:12:53 +0800 (CST)
Message-ID: <ad7f6d1d-5ec5-4aaa-808b-6b13c81d69bd@sjtu.edu.cn>
Date: Thu, 9 Jul 2026 10:12:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] docs/about/emulation: document the dlcall plugin
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260708152043.251537-1-functioner@sjtu.edu.cn>
 <20260708152043.251537-3-functioner@sjtu.edu.cn>
 <6abd4f15-03b5-4036-a016-74269e87c36a@oss.qualcomm.com>
 <f6600480-2cac-4708-8a3d-b2c69d454196@sjtu.edu.cn>
 <2c33043b-da8e-4b3f-8f17-c574b4632fcb@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <2c33043b-da8e-4b3f-8f17-c574b4632fcb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, 8 Jul 2026 18:29:59 -0700, Pierrick Bouvier wrote:
> On 7/8/2026 5:27 PM, Ziyang Zhang wrote:
>> Hi Pierrick,
>>
>> On Wed, 8 Jul 2026 16:55:19 -0700, Pierrick Bouvier wrote:
>>>> +A minimal end-to-end example wraps a one-function library,
>>>> ``libhello.so``,
>>>> +declared by ``hello.h``:
>>>> +
>>>> +.. code-block:: c
>>>> +
>>>> +   void hello(const char *name, int lucky);
>>>> +
>>>
>>> Please include full files for example:
>>> hello.h, hello.c and main.c calling hello function.
>>>
>>> Also, please include compiler commands for libhello.so and main.
>>> You can give a full example assuming it run on a x86_64 host.
>> Good idea. I will get it done in v8.
>>
>>> I could not get it to work.
>>> Following all the steps, the error message is:
>>>
>>> [GRT] failed to load host runtime
>>> qemu: uncaught target signal 6 (Aborted) - core dumped
>>> Aborted
>> On the error. [GRT] failed to load host runtime is the host side (QEMU)
>> failing to dlopen the Lorelei host runtime, which means $DEVKIT/lib was
>> not on the host LD_LIBRARY_PATH, for example if $DEVKIT was not set in
>> the shell that ran the command. -L only points QEMU at the guest's
>> loader and libc, so it is unrelated.
>>
>> I reproduced it: dropping just $DEVKIT/lib from the host LD_LIBRARY_PATH
>> gives exactly that message and the abort. The real fix is making the
>> example self-contained so nothing stays implicit, which is what v8 does.
>>
> 
> I paid attention to follow steps correctly, but maybe I missed
> something. Please see here a full dump of my env and commands:
> 
> $ git status
> Untracked files:
>    (use "git add <file>..." to include in what will be committed)
>          a.out
>          hello.c
>          hello.h
>          libhello.so
>          lorelei-devkit-x86_64-1.0.4.0.tar.xz
>          lorelei-devkit-x86_64/
>          main.c
>          thunks/
> 
> nothing added to commit but untracked files present (use "git add" to track)
> $ ldd a.out
>          linux-vdso.so.1 (0x00007f5855c3a000)
>          libhello.so => not found
>          libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f5855a0a000)
>          /lib64/ld-linux-x86-64.so.2 (0x00007f5855c3c000)
> $ LD_LIBRARY_PATH=./ ldd a.out
>          linux-vdso.so.1 (0x00007fef23831000)
>          libhello.so => ./libhello.so (0x00007fef2381f000)
>          libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fef235fc000)
>          /lib64/ld-linux-x86-64.so.2 (0x00007fef23833000)
> $ env | grep DEVKIT
> DEVKIT=/home/user/.work/qemu/lorelei-devkit-x86_64
> $ tree thunks/
> thunks/
> ├── lib
> │   └── x86_64-LoreHTL
> │       └── libhello_HTL.so
> └── x86_64
>      └── lib
>          └── x86_64-LoreGTL
>              └── libhello.so
> 
> 6 directories, 2 files
> $ LORELEI_THUNK_PATH=thunks LD_LIBRARY_PATH=$DEVKIT/lib:. \
> build/qemu-x86_64 -plugin build/contrib/plugins/libdlcall.so \
> -L $DEVKIT/x86_64/sysroot \
>   -E LD_LIBRARY_PATH=$DEVKIT/x86_64/lib:thunks/x86_64/lib/x86_64-LoreGTL\
> ./a.out
> [GRT] failed to load host runtime
> qemu: uncaught target signal 6 (Aborted) - core dumped
> Aborted
> 
> Any idea what could be missing?
> 
>>> We talked about not overriding sysroot, so please remove -L part.
>>> Also, Why do current dir is passed in LD_LIBRARY_PATH?
>> In this example it assumes that the host libhello.so is in the current
>> directory, which must be able to be found in LD_LIBRARY_PATH.
>>
>>>> +The guest ``LD_LIBRARY_PATH``, passed with ``-E``, controls what the
>>>> emulated
>>>> +program loads:
>>>> +
>>>> +* ``$DEVKIT/x86_64/lib`` contains the guest runtime support shipped
>>>> with the
>>>> +  devkit.
>>>> +* ``thunks/x86_64/lib/x86_64-LoreGTL`` contains the generated guest
>>>> +  ``libhello.so`` thunk, used in place of an ordinary guest library.
>>>> +
>>>> +The host ``LD_LIBRARY_PATH`` controls what the plugin and host thunk
>>>> load:
>>>> +
>>>> +* ``$DEVKIT/lib`` contains the host runtime support shipped with the
>>>> devkit.
>>>> +* ``.`` is the current directory, where the host's own
>>>> ``libhello.so`` is
>>>> +  located.
>>>> +
>>>> +See the runnable
>>>> +`hello <https://github.com/rover2024/lorelei/tree/main/examples/
>>>> hello>`_
>>>> +(minimal) and
>>>> +`demo <https://github.com/rover2024/lorelei/tree/main/examples/demo>`_
>>>> +(variadic functions and a callback that reenters the guest)
>>>> examples, and
>>>> +`Lorelei <https://github.com/rover2024/lorelei>`_ for prebuilt thunk
>>>> trees and
>>>> +the runtime environment they expect.
>>>> +
>>>> +.. list-table:: Dynamic Linking Call arguments
>>>> +  :widths: 20 80
>>>> +  :header-rows: 1
>>>> +
>>>> +  * - Option
>>>> +    - Description
>>>> +  * - syscall_num=N
>>>> +    - The magic syscall number the guest issues (default 4096). Must
>>>> be high
>>>> +      enough not to clash with a real syscall.
>>>> +
>>>>    Other emulation features
>>>>    ------------------------
>>>>    
>>>
>>> Regards,
>>> Pierrick
>>
>> It looks unexplained today only because the walkthrough never shows
>> building it. v8 will.
>>
>> v8 will also include the full hello.h, hello.c and main.c, plus the cc
>> and clang commands for libhello.so and main, as one runnable x86_64
>> sequence.

Although I have tested in the empty containers of each ISA, it is not
possible to cover all Linux distributions. Currently, the Lorelei Host
Runtime (in the devkit, libLoreHostRT.so) fails to load and does not
output dlerror(). At present, I am unable to analyze why there is an
error on your end.

Perhaps you could set the LD_DEBUG for the host and use -U to unset
LD_DEBUG for the guest, and then observe the output.

Regards,
Ziyang Zhang

