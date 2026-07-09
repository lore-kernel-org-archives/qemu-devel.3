Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C41C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 01:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whe2i-0003KH-8I; Wed, 08 Jul 2026 21:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whe2g-0003K4-9Z
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 21:59:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whe2d-0003d1-Oz
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 21:59:10 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6691PNk8194723
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 01:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oZffLOcJQaCf042kSq8+VDaLadkJBDda2Rij9Fv9R2s=; b=E4yPSnF4jNSn6mDi
 wd5KljP4CMkqnZIr5GZ4CPy8Lw3Aw/nImiIyyFi3IDR2Pcmj60eUoB8dg6Xa0Q1l
 iC6M1bXItbnqIq6USbhvxSd7oD3sl6lrtHH1sCCmFnqiHERq5o6WrwZ9L/6ppSR/
 G8c8Jim+8i2EhH2+1ucIzxkC/XEmeKRvm7YaFT5O7yO16z+B+BOVKeQtK8vSEXcg
 mDx44YcBQXbMTT7cfybruB2Rx4KgurCDYI9HkeCssfon+bpgMAQ4j2etKeD0Syuo
 9rB0mdbRrIQ7KrslAChoxivsUwXr1bMR2E1V7jrg2IpvFsRY5pvuQ+mrR1FxbvCz
 tJCQLQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1ydr3q5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:59:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8479b45ad08so2077195b3a.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 18:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783562344; x=1784167144; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oZffLOcJQaCf042kSq8+VDaLadkJBDda2Rij9Fv9R2s=;
 b=c0fK/HEiO7HmPwcMf7m5ldp+bTU0FUE7lY3i5NuE7MyZ1rIgNvNYtA23RI/80gxn1U
 rfzi2ApKMi4c0USBRsx4QeDjyJY2Wq90u19/el5mMbDXzOxlnJ6xzC4rmcHxk7o7pDWN
 dTXEhDstYZWJlnC8JgHO12+CG2tqaOavrJJmGK1GpyI4ilOu0gmHquJazep1Wba5aPgm
 +QgR/HV5w4V15BXgyoZQZSohibaqLFlmZV6hqrFTi0DsTrxvwz3yW//jnoTCrymtsUzn
 9MvpeaqsFHCZ8WruCIwLoJPv1m45h35cSVMGXoDcY6FvDzXGuAZm2ICExQdOMDmmNZ2r
 gL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783562344; x=1784167144;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oZffLOcJQaCf042kSq8+VDaLadkJBDda2Rij9Fv9R2s=;
 b=brwcsA5iQrkN0tui0DrTPfnAouxcYV8+6Ev47TsLeOqGh4RIsBJgsKuuQQAcI9kBVG
 gi643v7368vEwwK0s9cSfd9zsspKF1RRzy31NyNtwz+wS0WikibyV6dkd9XMr9TC+W2+
 M3R3zHOt0hAwuQNIchrZKme4v7Rhu0MdC40KdHulzxWGLBqWlnWICnmA+ErkJRrKSeOf
 Qs0GTkRMtAa1ijpJOlhO4fcc7O6LG7WRmbYC5rTAsBuMVpuSNkMQbZpow9HkM+INGzIF
 pxoi9uB15EEfm8BERFUnmBUnstqjdwOyeIJ4rKx1u7L/TNQOTa0mLURLMXLznI0YY+6N
 Bfdg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrnZmndX1VwHyw/1lhscsjrdxiMTj7LbkUqVZVyoxW5SrJU7msJdk1yDOrZOypREB+HN7vV9JniNb1B@nongnu.org
X-Gm-Message-State: AOJu0YxEDgRmQwsnSKJbV0Oy8tMfi+t/RvugQhdSvjKHjtDGFJnWsFWD
 HmBe+ep9Ydb9Y5L+4zgIXUjin8s0C3pMULdUK1DU6QrybfRY1uykbh76mZ3OOvUqdVjzkYiuRRu
 6wYoMg3D39/zWpsOzVRtIewK1KkB1Czo6Gfog4nb+XjS3o/XmThULYGIkRA==
X-Gm-Gg: AfdE7cndo3nMPvQgUDeCPVC/W33AxpY2EvncrU9ho6F1nqnRtreV5PpXOMFghD80/BR
 qGUKjZcRWGJuxzEIVbyyj/F/fdLfzeoLANEZfWpM4JniRI5qsz0EOqiu4Yhiy05xkI+gMZQlLEm
 FqnhyeU72zIsCN9tV1+vp7IZhrZ+FWOvyiUl3PIJtm4gXzPfazff6dIAYMUFbOgoC0haWQSRE7l
 lkOvaq6mMNHZYzOM4wmJHq01G7p9+cZ8bbCdz23qBVTwXoX/g+7CHMkqixNDEqSRTuw4BECGZJj
 7HkEmnJETeAJnjPJNKcovuTS2qN7tfmae0DaFua7a9RsT3IMMmVX5194wHxO4bes4xDgDKoFJyf
 k7nv619Ra6hI3SmSEI25X02zH1xHzWb59Kwf2GpxWyJf5ML/on7Qrij2T2R3MzueQOw==
X-Received: by 2002:a05:6a00:244a:b0:847:9ce5:d293 with SMTP id
 d2e1a72fcca58-8484301f0a4mr5026248b3a.24.1783562343607; 
 Wed, 08 Jul 2026 18:59:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:244a:b0:847:9ce5:d293 with SMTP id
 d2e1a72fcca58-8484301f0a4mr5026211b3a.24.1783562343023; 
 Wed, 08 Jul 2026 18:59:03 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8484c6ae0e7sm1136722b3a.45.2026.07.08.18.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 18:59:02 -0700 (PDT)
Message-ID: <62a83c4d-c26f-4b0c-b59f-62b6cc39b634@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 18:59:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8990dc77-d8af-47aa-abe4-8d279d9e2da7@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAxNyBTYWx0ZWRfX6VxT7ilQSbBe
 CQFJqc1XzpHCBk1H7zfF9DcoS7Y4QtHNvc9qHHVrjn8CDAmqA4VhwqLcxjuJzDhFjHpBJaXkzCJ
 2bGNk6uIY38c0jiiKM06v2n+nRGKjJ4=
X-Proofpoint-ORIG-GUID: I5oCVYtdwd_732trNQ-V7jtDOqbfOGu0
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4f0068 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=jQIij1hyAAAA:20 a=Lx1EvxgrAAAA:8 a=oobj9mfM0YSfs0EMyPUA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=ZFi1QaP_tuf8dODdgmj-:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: I5oCVYtdwd_732trNQ-V7jtDOqbfOGu0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAxNyBTYWx0ZWRfX0GQ/duS/s1KG
 fZhZgHR9W8tAcsz1umCb2IYo46m7fPMpiRNqiJwW4C4gVsL4ka2oM5O6ZhysBmvaZVUkbu6+ZKL
 BRh+Bjo1iZV3sJdhlHkD8OJcGITFX1tX5rV5EU7Vn2JBzYG7aYjzHPG4OSQj9VNqt1s2ARPwY9j
 0mgrFutoh93Kg0HhXNJaA8Pu2HO2B0OWDd/K0SOKHY/ACyY63vIpphBzb0TI6bW8Wl8QXKw/8KC
 3i8OnLYZ5fYl8FCZPM82MEnDGKI0lxOJaDswT7bdrE8PXwwhxIB03gBjtWW0/OCRj5ETrk0I2/C
 aPtVeyjKh6ttE/bXmgTtAgbdMTZ9xFVYwsYWb5jnTLS/ox78GwaxldLj5zsFSNPQxC8tm2AZjC8
 Kqpza9l3e1cT6ZyuA6y57RTKfOJraBPMgd7sLQTcr34ECS0v3pvIrw/wMlhPzYwWKhYKRJDD5of
 u0Y28q5N5PEi0gchYtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090017
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/8/26 6:47 PM, Ziyang Zhang wrote:
> 
> 
> On Wed, 8 Jul 2026 18:35:09 -0700, Pierrick Bouvier wrote:
>> On 7/8/2026 6:19 PM, Ziyang Zhang wrote:
>>> Document the dlcall plugin under Example Plugins: what it does, the trusted-
>>> guests and guest_base == 0 constraints, how to load it, and a pointer to
>>> Lorelei, one end-to-end userspace implementation, for the toolchain and a
>>> runnable example.
>>>
>>> Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
>>> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
>>> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
>>> ---
>>>    docs/about/emulation.rst | 202 +++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 202 insertions(+)
>>>
>>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>>> index 3b4c365933..b8fdc88a45 100644
>>> --- a/docs/about/emulation.rst
>>> +++ b/docs/about/emulation.rst
>>> @@ -1046,6 +1046,208 @@ Count traps
>>>    This plugin counts the number of interrupts (asynchronous events), exceptions
>>>    (synchronous events) and host calls (e.g. semihosting) per cpu.
>>>    
>>> +Dynamic Linking Call
>>> +....................
>>> +
>>> +``contrib/plugins/dlcall.c``
>>> +
>>> +This plugin provides a dynamic linking function call interception mechanism
>>> +for linux-user guests: the guest hands a call off to the host, where the plugin
>>> +runs native code in its place instead of the guest emulating it. Interception
>>> +alone enables several uses, for instance tracing or auditing guest calls.
>>> +One use is acceleration by leveraging the host's native shared libraries. For
>>> +example, a thunk layer can run the stock zlib ``minizip`` utility under
>>> +emulation while forwarding its ``deflate`` calls to the host's native zlib
>>> +library (libz). This avoids emulating those selected library calls instruction
>>> +by instruction.
>>> +
>>> +The guest issues a reserved "magic" system call (4096 by default, configurable
>>> +with ``syscall_num=N``) whose first argument selects a pass-through operation:
>>> +dlopen/dlclose a host library, dlsym a symbol, and invoke a resolved host
>>> +function. The plugin performs the operation on the host and consumes the
>>> +syscall, so the real kernel never sees it.
>>> +
>>> +.. warning::
>>> +
>>> +   Trusted guests only. The guest can load arbitrary host libraries and run
>>> +   arbitrary code in the QEMU host process. The plugin is not a sandbox and
>>> +   provides no isolation. It also requires ``guest_base == 0`` (qemu-user's
>>> +   default), as guest pointers are dereferenced as host addresses with no
>>> +   translation.
>>> +
>>> +The plugin intentionally keeps the QEMU side lightweight and knows nothing
>>> +about any particular library or its calling convention. Turning a real library
>>> +into working thunks, including argument marshalling, callbacks and variadic
>>> +functions, is done entirely in userspace, and any toolchain can implement the
>>> +interface.
>>> +
>>> +Loading the plugin is all that is required from QEMU's side:
>>> +
>>> +.. code-block:: shell
>>> +
>>> +   qemu-x86_64 -plugin contrib/plugins/libdlcall.so <guest-program> ...
>>> +
>>> +`Lorelei <https://github.com/rover2024/lorelei>`_ is one end-to-end userspace
>>> +implementation of this: it provides the guest and host runtimes and an
>>> +automated toolchain that generates the thunks from a library's headers, so guest
>>> +library calls run on the host's native libraries. It supports an x86_64 guest
>>> +running on an x86_64, aarch64 or riscv64 host.
>>> +
>>> +A minimal end-to-end example uses a one-function library, ``libhello.so``, built
>>> +two ways: the guest build tags its output ``from guest`` and the host build tags
>>> +it ``from host``. An unmodified guest program ``main`` calls ``hello("world",
>>> +7)``, and the thunk makes that same binary reach the host build in place of its
>>> +own. The sources live under ``src/``:
>>> +
>>> +.. code-block:: c
>>> +
>>> +   /* src/hello.h */
>>> +   #ifdef __cplusplus
>>> +   extern "C" {
>>> +   #endif
>>> +   void hello(const char *name, int lucky);
>>> +   #ifdef __cplusplus
>>> +   }
>>> +   #endif
>>> +
>>> +.. code-block:: c
>>> +
>>> +   /* src/hello_guest.c */
>>> +   #include "hello.h"
>>> +   #include <stdio.h>
>>> +
>>> +   void hello(const char *name, int lucky)
>>> +   {
>>> +       printf("hello from guest: %s, lucky %d\n", name, lucky);
>>> +       fflush(stdout);
>>> +   }
>>> +
>>> +.. code-block:: c
>>> +
>>> +   /* src/hello_host.c */
>>> +   #include "hello.h"
>>> +   #include <stdio.h>
>>> +
>>> +   void hello(const char *name, int lucky)
>>> +   {
>>> +       printf("hello from host: %s, lucky %d\n", name, lucky);
>>> +       fflush(stdout);
>>> +   }
>>> +
>>> +.. code-block:: c
>>> +
>>> +   /* src/main.c */
>>> +   #include "hello.h"
>>> +
>>> +   int main(void)
>>> +   {
>>> +       hello("world", 7);
>>> +       return 0;
>>> +   }
>>> +
>>> +Lorelei ships a prebuilt toolchain (a "devkit") in its releases. Download the
>>> +one for your host and unpack it:
>>> +
>>> +.. code-block:: shell
>>> +
>>> +   # <arch> is your host architecture: x86_64, aarch64 or riscv64
>>> +   wget https://github.com/rover2024/lorelei/releases/download/v<version>/lorelei-devkit-<arch>-<version>.tar.xz
>>> +   tar -xf lorelei-devkit-<arch>-<version>.tar.xz
>>> +   DEVKIT=lorelei-devkit-<arch>
>>> +
>>> +Build the guest ``libhello.so`` (x86_64) and the host ``libhello.so`` (this
>>> +host's own architecture), then the guest program. ``main`` links the guest
>>> +library with an rpath, so by default it loads that one:
>>> +
>>> +.. code-block:: shell
>>> +
>>> +   mkdir -p build/guest build/host
>>> +   $DEVKIT/bin/x86_64-linux-gnu-clang -shared -fPIC -o build/guest/libhello.so src/hello_guest.c
>>> +   cc -shared -fPIC -o build/host/libhello.so src/hello_host.c
>>> +   $DEVKIT/bin/x86_64-linux-gnu-clang src/main.c -Isrc -Lbuild/guest -lhello \
>>> +       -Wl,-rpath,'$ORIGIN' -o build/guest/main
>>> +
>>
>> Why is rpath needed? We don't want necessarily to find the library
>> relative to where the binary is located.
>>
>> In practice, we'll have:
>> - the binary
>> - folder A containing host library
>> - folder B containing thunks
>>
>> A and B are not related to binary location.
> This example ships the guest libhello.so which is at the same directory
> as the main executable, so I add the rpath to make QEMU run the original
> program without specifying anything.
> 
>>> +Run it under qemu. It loads its own guest library:
>>> +
>>> +.. code-block:: shell
>>> +
>>> +   qemu-x86_64 build/guest/main
>>> +
>>> +which prints::
>>> +
>>> +   hello from guest: world, lucky 7Would your suggestion be to not include rpath when compiling main, and
> then set LD_LIBRARY_PATH to the library path when running the original
> program?
> 
> qemu-x86_64 -E LD_LIBRARY_PATH=build/guest build/guest/main
> 
> Like this?

Yes, exactly.

By doing this, the end goal is to see that we can dynamically switch 
from the original host library to the thunks simply by switching this 
variable.

Regards,
Pierrick

