Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E83C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 02:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wheE3-0003IN-7m; Wed, 08 Jul 2026 22:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wheE1-0003I7-1W
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:10:53 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wheDw-0001bW-5h
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783563037;
 bh=MF+5HdxhrCtx+4DJGVG1v2w1BdLxLL7jBJKB6w3wW8E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=yJYbz0jxqzSGhqBP+iJ1x7yelhGB2LQytMfjDoH1psm6bbIOsaoxmt+CUh1dAKO9g
 RoaDW6EsQR4xlo93KDFuLIGYPLAKDTsbc8N061z2/QoOM5fx5FOy/gP5fg2oZu5Wq4
 +TBvq5gO6eciQ/1VzEEDFKst0RLzu4VE3cAZKHhxvvMCpBoq+K7rfNJucLEgT12yJG
 u0kywdWJ2uiBtR0mym6nrc96axHJqwXYyNXIXcbQJs9fXzVnrJDX52NcLq6QNkVcqy
 3clYAxcAhozjQGBtzQDN0hi0ZQpH1D65wpbcZCsP8rAR9Tv4MqFB1i09OhJubvHEUK
 7a8G1jvVo/ZPQ==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id EEA3B30015A;
 Thu,  9 Jul 2026 02:10:36 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 3A255380C9A;
 Thu,  9 Jul 2026 10:10:32 +0800 (CST)
Message-ID: <ac710e66-0e76-4ea2-a45e-57ad569fb8ee@sjtu.edu.cn>
Date: Thu, 9 Jul 2026 10:10:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] docs/about/emulation: document the dlcall plugin
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260709011945.282457-1-functioner@sjtu.edu.cn>
 <20260709011945.282457-3-functioner@sjtu.edu.cn>
 <6573ff2c-da32-496a-bbbd-28ebce020a22@oss.qualcomm.com>
 <8990dc77-d8af-47aa-abe4-8d279d9e2da7@sjtu.edu.cn>
 <62a83c4d-c26f-4b0c-b59f-62b6cc39b634@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <62a83c4d-c26f-4b0c-b59f-62b6cc39b634@oss.qualcomm.com>
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

On Wed, 8 Jul 2026 18:59:01 -0700, Pierrick Bouvier wrote:
> On 7/8/26 6:47 PM, Ziyang Zhang wrote:
>>
>>
>> On Wed, 8 Jul 2026 18:35:09 -0700, Pierrick Bouvier wrote:
>>> On 7/8/2026 6:19 PM, Ziyang Zhang wrote:
>>>> Document the dlcall plugin under Example Plugins: what it does, the 
>>>> trusted-
>>>> guests and guest_base == 0 constraints, how to load it, and a 
>>>> pointer to
>>>> Lorelei, one end-to-end userspace implementation, for the toolchain 
>>>> and a
>>>> runnable example.
>>>>
>>>> Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
>>>> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
>>>> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
>>>> ---
>>>>    docs/about/emulation.rst | 202 ++++++++++++++++++++++++++++++++++ 
>>>> +++++
>>>>    1 file changed, 202 insertions(+)
>>>>
>>>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>>>> index 3b4c365933..b8fdc88a45 100644
>>>> --- a/docs/about/emulation.rst
>>>> +++ b/docs/about/emulation.rst
>>>> @@ -1046,6 +1046,208 @@ Count traps
>>>>    This plugin counts the number of interrupts (asynchronous 
>>>> events), exceptions
>>>>    (synchronous events) and host calls (e.g. semihosting) per cpu.
>>>> +Dynamic Linking Call
>>>> +....................
>>>> +
>>>> +``contrib/plugins/dlcall.c``
>>>> +
>>>> +This plugin provides a dynamic linking function call interception 
>>>> mechanism
>>>> +for linux-user guests: the guest hands a call off to the host, 
>>>> where the plugin
>>>> +runs native code in its place instead of the guest emulating it. 
>>>> Interception
>>>> +alone enables several uses, for instance tracing or auditing guest 
>>>> calls.
>>>> +One use is acceleration by leveraging the host's native shared 
>>>> libraries. For
>>>> +example, a thunk layer can run the stock zlib ``minizip`` utility 
>>>> under
>>>> +emulation while forwarding its ``deflate`` calls to the host's 
>>>> native zlib
>>>> +library (libz). This avoids emulating those selected library calls 
>>>> instruction
>>>> +by instruction.
>>>> +
>>>> +The guest issues a reserved "magic" system call (4096 by default, 
>>>> configurable
>>>> +with ``syscall_num=N``) whose first argument selects a pass-through 
>>>> operation:
>>>> +dlopen/dlclose a host library, dlsym a symbol, and invoke a 
>>>> resolved host
>>>> +function. The plugin performs the operation on the host and 
>>>> consumes the
>>>> +syscall, so the real kernel never sees it.
>>>> +
>>>> +.. warning::
>>>> +
>>>> +   Trusted guests only. The guest can load arbitrary host libraries 
>>>> and run
>>>> +   arbitrary code in the QEMU host process. The plugin is not a 
>>>> sandbox and
>>>> +   provides no isolation. It also requires ``guest_base == 0`` 
>>>> (qemu-user's
>>>> +   default), as guest pointers are dereferenced as host addresses 
>>>> with no
>>>> +   translation.
>>>> +
>>>> +The plugin intentionally keeps the QEMU side lightweight and knows 
>>>> nothing
>>>> +about any particular library or its calling convention. Turning a 
>>>> real library
>>>> +into working thunks, including argument marshalling, callbacks and 
>>>> variadic
>>>> +functions, is done entirely in userspace, and any toolchain can 
>>>> implement the
>>>> +interface.
>>>> +
>>>> +Loading the plugin is all that is required from QEMU's side:
>>>> +
>>>> +.. code-block:: shell
>>>> +
>>>> +   qemu-x86_64 -plugin contrib/plugins/libdlcall.so <guest- 
>>>> program> ...
>>>> +
>>>> +`Lorelei <https://github.com/rover2024/lorelei>`_ is one end-to-end 
>>>> userspace
>>>> +implementation of this: it provides the guest and host runtimes and an
>>>> +automated toolchain that generates the thunks from a library's 
>>>> headers, so guest
>>>> +library calls run on the host's native libraries. It supports an 
>>>> x86_64 guest
>>>> +running on an x86_64, aarch64 or riscv64 host.
>>>> +
>>>> +A minimal end-to-end example uses a one-function library, 
>>>> ``libhello.so``, built
>>>> +two ways: the guest build tags its output ``from guest`` and the 
>>>> host build tags
>>>> +it ``from host``. An unmodified guest program ``main`` calls 
>>>> ``hello("world",
>>>> +7)``, and the thunk makes that same binary reach the host build in 
>>>> place of its
>>>> +own. The sources live under ``src/``:
>>>> +
>>>> +.. code-block:: c
>>>> +
>>>> +   /* src/hello.h */
>>>> +   #ifdef __cplusplus
>>>> +   extern "C" {
>>>> +   #endif
>>>> +   void hello(const char *name, int lucky);
>>>> +   #ifdef __cplusplus
>>>> +   }
>>>> +   #endif
>>>> +
>>>> +.. code-block:: c
>>>> +
>>>> +   /* src/hello_guest.c */
>>>> +   #include "hello.h"
>>>> +   #include <stdio.h>
>>>> +
>>>> +   void hello(const char *name, int lucky)
>>>> +   {
>>>> +       printf("hello from guest: %s, lucky %d\n", name, lucky);
>>>> +       fflush(stdout);
>>>> +   }
>>>> +
>>>> +.. code-block:: c
>>>> +
>>>> +   /* src/hello_host.c */
>>>> +   #include "hello.h"
>>>> +   #include <stdio.h>
>>>> +
>>>> +   void hello(const char *name, int lucky)
>>>> +   {
>>>> +       printf("hello from host: %s, lucky %d\n", name, lucky);
>>>> +       fflush(stdout);
>>>> +   }
>>>> +
>>>> +.. code-block:: c
>>>> +
>>>> +   /* src/main.c */
>>>> +   #include "hello.h"
>>>> +
>>>> +   int main(void)
>>>> +   {
>>>> +       hello("world", 7);
>>>> +       return 0;
>>>> +   }
>>>> +
>>>> +Lorelei ships a prebuilt toolchain (a "devkit") in its releases. 
>>>> Download the
>>>> +one for your host and unpack it:
>>>> +
>>>> +.. code-block:: shell
>>>> +
>>>> +   # <arch> is your host architecture: x86_64, aarch64 or riscv64
>>>> +   wget https://github.com/rover2024/lorelei/releases/download/ 
>>>> v<version>/lorelei-devkit-<arch>-<version>.tar.xz
>>>> +   tar -xf lorelei-devkit-<arch>-<version>.tar.xz
>>>> +   DEVKIT=lorelei-devkit-<arch>
>>>> +
>>>> +Build the guest ``libhello.so`` (x86_64) and the host 
>>>> ``libhello.so`` (this
>>>> +host's own architecture), then the guest program. ``main`` links 
>>>> the guest
>>>> +library with an rpath, so by default it loads that one:
>>>> +
>>>> +.. code-block:: shell
>>>> +
>>>> +   mkdir -p build/guest build/host
>>>> +   $DEVKIT/bin/x86_64-linux-gnu-clang -shared -fPIC -o build/guest/ 
>>>> libhello.so src/hello_guest.c
>>>> +   cc -shared -fPIC -o build/host/libhello.so src/hello_host.c
>>>> +   $DEVKIT/bin/x86_64-linux-gnu-clang src/main.c -Isrc -Lbuild/ 
>>>> guest -lhello \
>>>> +       -Wl,-rpath,'$ORIGIN' -o build/guest/main
>>>> +
>>>
>>> Why is rpath needed? We don't want necessarily to find the library
>>> relative to where the binary is located.
>>>
>>> In practice, we'll have:
>>> - the binary
>>> - folder A containing host library
>>> - folder B containing thunks
>>>
>>> A and B are not related to binary location.
>> This example ships the guest libhello.so which is at the same directory
>> as the main executable, so I add the rpath to make QEMU run the original
>> program without specifying anything.
>>
>>>> +Run it under qemu. It loads its own guest library:
>>>> +
>>>> +.. code-block:: shell
>>>> +
>>>> +   qemu-x86_64 build/guest/main
>>>> +
>>>> +which prints::
>>>> +
>>>> +   hello from guest: world, lucky 7Would your suggestion be to not 
>>>> include rpath when compiling main, and
>> then set LD_LIBRARY_PATH to the library path when running the original
>> program?
>>
>> qemu-x86_64 -E LD_LIBRARY_PATH=build/guest build/guest/main
>>
>> Like this?
> 
> Yes, exactly.
> 
> By doing this, the end goal is to see that we can dynamically switch 
> from the original host library to the thunks simply by switching this 
> variable.
> 
> Regards,
> Pierrick

Thank you for the explanation. I will send out PATCH v9, and then I will
update Lorelei.

