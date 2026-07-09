Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADDBC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 00:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whcbz-0004qr-Ao; Wed, 08 Jul 2026 20:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1whcbx-0004qe-Ha
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 20:27:29 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1whcbu-0006uj-1T
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 20:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783556834;
 bh=l+FgUBISqjk1aYYUEekYsylR0elL32WLVuJ9AMlZxGc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hhPh/Sz0g+iQrGZq3hY3FRKcwNKkCHLTw3AzNlCOzXJLg1Xp05GLyJwvLLXDP8DM2
 pYGiNdKvL/8D/FarbsuBQMoN/Yo0Rfoc18Z8sxX26CVFaR5WESJ/iyydR3uIqjeQ8L
 P10Mah8n5wvBRejIFyd+R1pnGnqavU4WVK6F1LzXl+MKmIExMP3k/0Sw+HJBlMBeHh
 oHzLwwWitYtVbKcBk/tPLpbUTvTHiD94ia2DwXcsSwll0IPXUnY77eEhGPpM1f8Bc5
 ZOqcDE/XZG9tds2xFF35zDAOhXOZedPjyG0l1u8rxkOSmpyjyk1Ax+Aqrj3gKBsVad
 enGbqYMeQVl4A==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id CB21C2FF367;
 Thu,  9 Jul 2026 00:27:14 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 9CEFE37C925;
 Thu,  9 Jul 2026 08:27:13 +0800 (CST)
Message-ID: <f6600480-2cac-4708-8a3d-b2c69d454196@sjtu.edu.cn>
Date: Thu, 9 Jul 2026 08:27:12 +0800
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
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <6abd4f15-03b5-4036-a016-74269e87c36a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Pierrick,

On Wed, 8 Jul 2026 16:55:19 -0700, Pierrick Bouvier wrote:
>> +A minimal end-to-end example wraps a one-function library, ``libhello.so``,
>> +declared by ``hello.h``:
>> +
>> +.. code-block:: c
>> +
>> +   void hello(const char *name, int lucky);
>> +
> 
> Please include full files for example:
> hello.h, hello.c and main.c calling hello function.
> 
> Also, please include compiler commands for libhello.so and main.
> You can give a full example assuming it run on a x86_64 host.
Good idea. I will get it done in v8.

> I could not get it to work.
> Following all the steps, the error message is:
> 
> [GRT] failed to load host runtime
> qemu: uncaught target signal 6 (Aborted) - core dumped
> Aborted
On the error. [GRT] failed to load host runtime is the host side (QEMU)
failing to dlopen the Lorelei host runtime, which means $DEVKIT/lib was
not on the host LD_LIBRARY_PATH, for example if $DEVKIT was not set in
the shell that ran the command. -L only points QEMU at the guest's
loader and libc, so it is unrelated.

I reproduced it: dropping just $DEVKIT/lib from the host LD_LIBRARY_PATH
gives exactly that message and the abort. The real fix is making the
example self-contained so nothing stays implicit, which is what v8 does.

> We talked about not overriding sysroot, so please remove -L part.
> Also, Why do current dir is passed in LD_LIBRARY_PATH?
In this example it assumes that the host libhello.so is in the current
directory, which must be able to be found in LD_LIBRARY_PATH.

>> +The guest ``LD_LIBRARY_PATH``, passed with ``-E``, controls what the emulated
>> +program loads:
>> +
>> +* ``$DEVKIT/x86_64/lib`` contains the guest runtime support shipped with the
>> +  devkit.
>> +* ``thunks/x86_64/lib/x86_64-LoreGTL`` contains the generated guest
>> +  ``libhello.so`` thunk, used in place of an ordinary guest library.
>> +
>> +The host ``LD_LIBRARY_PATH`` controls what the plugin and host thunk load:
>> +
>> +* ``$DEVKIT/lib`` contains the host runtime support shipped with the devkit.
>> +* ``.`` is the current directory, where the host's own ``libhello.so`` is
>> +  located.
>> +
>> +See the runnable
>> +`hello <https://github.com/rover2024/lorelei/tree/main/examples/hello>`_
>> +(minimal) and
>> +`demo <https://github.com/rover2024/lorelei/tree/main/examples/demo>`_
>> +(variadic functions and a callback that reenters the guest) examples, and
>> +`Lorelei <https://github.com/rover2024/lorelei>`_ for prebuilt thunk trees and
>> +the runtime environment they expect.
>> +
>> +.. list-table:: Dynamic Linking Call arguments
>> +  :widths: 20 80
>> +  :header-rows: 1
>> +
>> +  * - Option
>> +    - Description
>> +  * - syscall_num=N
>> +    - The magic syscall number the guest issues (default 4096). Must be high
>> +      enough not to clash with a real syscall.
>> +
>>   Other emulation features
>>   ------------------------
>>   
> 
> Regards,
> Pierrick

It looks unexplained today only because the walkthrough never shows
building it. v8 will.

v8 will also include the full hello.h, hello.c and main.c, plus the cc
and clang commands for libhello.so and main, as one runnable x86_64
sequence.

