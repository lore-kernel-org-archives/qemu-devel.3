Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22CCC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 01:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whdfc-0007PW-R7; Wed, 08 Jul 2026 21:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whdfZ-0007PJ-Ls
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 21:35:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whdfX-0004Ie-6Z
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 21:35:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6691PEis194025
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 01:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rQmvl4/VsZJZkOSYjtYqdUA6x9vmryGjxie4MtiInZU=; b=fNF2muffFoKTqb2d
 jv57VnXFZkJFGS0qzBviaNdMbLcKhms5Hg5bYvLxOmZNC9/5QaXqXOhAKs9JNmM9
 BdgQ0iAowMrDlhj8WtNs9fKKjxS90y4wdMLbesLRkci2sAG7xYQBEbtIhFo8kco1
 ZKRso+PZ6woVeOHWGBh6gkQY0/i6+9U2zaeu/OPVQAywi/yszD4rrefwp1yQxx2H
 8KQK2NqwMuCeclbh/dofoT3nh3YyNtCRQpcYeDxSQ4kvXjvhBSOX+oI1ib59wO8y
 K76Y6DzaCcxQv3QIEsPo4JJj/bbEHPGFC1QELeOQ/wfBXN9fyGd/q/Eh3ocQ99a9
 rEFtMw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1ydr12w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:35:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88e0d11a3fso1232561a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 18:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783560912; x=1784165712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rQmvl4/VsZJZkOSYjtYqdUA6x9vmryGjxie4MtiInZU=;
 b=h8JN4+uNnNjpgFo3F5GCFp++1d4YbWHjZZ023CNrtvwSelYKxinyZyGPUehFDJAkDS
 Yi/stZNyQgnjlTCN1+uICC4z4oO0mLg5C1PQuPhyWEah/svKuraIMuDCN3fcAU7mP79H
 Slp0tL2XXCXdKB+DKWE3eHvCbtAn0B1CeLw4infZf31xrScRV3//bLnSYd0SkeRBYw6P
 V55L+zpJ1E/GMi2FYru0cbAYOAJgShJoRwd0yMMV2o0pTp+WogoecwKWFAvSVMVU5w8n
 heDuj+rE12OP7h/LLxBsIA0eTz27S5tkx9RnPrbFukWznuuYJNeLiZOA6yt/fEcx8HMy
 JtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783560912; x=1784165712;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rQmvl4/VsZJZkOSYjtYqdUA6x9vmryGjxie4MtiInZU=;
 b=M7d58EspX5eXxm5WojqQs7xlMvWtYckNZEJ7jH/aAV917aYSIivdNk6GFmYXxRSY7K
 bbHMg/vHiPBmOBKrxD6ofiGdK8TScI4O5Z7xKLZlbv5k4JN9Jtg+thIlzU6K2HOkmfD9
 b0vCew3ElAh51AAbzDgP2cymto9yx2ORZXSzv3RO46PWmlR0sx8TCKwtR3opY88SoLhW
 oI6d4ufsUPklQNjAhBS+pBFiah7PXz8F9vMEkB3S8eKB9dBwUASc4GSu9wTodV2ThTWe
 tXJ8mClF9Y6dFwIyg0vP/b27U+WRWonYea7wF2UObzRj1t7X2+PlmkcMnCL/wvBczDLw
 RQHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RopTZbfDm4JbOqa5Q48UTCpX1kp7qGinhjzOkHvAV07FiWk3R8wJ7RbE/38PrvPvEBcOy+XzewhTOfw@nongnu.org
X-Gm-Message-State: AOJu0Ywy6XYnc+GFaToUGt3kOYO/zJrOorGRnjELbUgcpSBy4hZIQx/j
 JrQT116oYdHgqN6sx/FGMz6vZLjhM1vJZ7GDpSokjwaYR6dUj8xt1KbXerplBH/xSlzqBiJqDP5
 xwyF8TmvHrBw3ZuvMf1+KJu0mPCRnIKr97nXB1S5mz0J4yDPlpjciVHmS7Q==
X-Gm-Gg: AfdE7ckFzWhqLSdTEM69WfJN1fYQqw7tqrKBsbiOiPthNcYlp9So5PxaaV7z8xmt8qO
 69WR3abpluwd1SSmoajojrSjjRPbJdwiD2Y6cIjoi5IM5sL0HYLh7XN+tSHwGPgHmmuAn+uZLsG
 P9Yd950Ooqjn84acZy7ZE3EJs257OUzg8ARGMwlAbWK1v+p2L4QYaxHHkMI/jJ3oX6N0wgq3WHB
 6R4kUDdGSR2kFFb+Iu/VJ6wIqx/ZsHCIwA//C8dJ8p6oyLN6pM4xZ3Yq2RrY2fI+69quFH6ik/f
 X+coFULN9Y93aY5ocwAaHC7Uy8LDahhtZgh9ser+2pW3DisRSU1DQ0V+Hj9eSWwUApylW894xg8
 9RIYq2Gxvf1pZcpqYSank59VDWB3YKMljIvY84QTofikqO50nIsfkUObzUJp7nZagmWa6uV16eY
 gExx8=
X-Received: by 2002:a05:6a20:6a26:b0:39f:a8fb:3354 with SMTP id
 adf61e73a8af0-3c0bc902639mr6067153637.17.1783560911845; 
 Wed, 08 Jul 2026 18:35:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a26:b0:39f:a8fb:3354 with SMTP id
 adf61e73a8af0-3c0bc902639mr6067125637.17.1783560911290; 
 Wed, 08 Jul 2026 18:35:11 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f72a6sm28256324eec.1.2026.07.08.18.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 18:35:10 -0700 (PDT)
Message-ID: <6573ff2c-da32-496a-bbbd-28ebce020a22@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 18:35:09 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260709011945.282457-3-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAxMyBTYWx0ZWRfX2LVWaovy9MAO
 sNUoxIGd0h7LzqGWLzgdSVqbJAUzokD1ZMaokYorwkjW3wv0Id4wRfyliOHrZYDqSCxH/bgaRho
 OUm8O3SYNmQguLxcPSfAq7Gh6aSWP1k=
X-Proofpoint-ORIG-GUID: UXI1zQAP2p_BAPMTHApNEYswDlZlfdYy
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4efad0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=jQIij1hyAAAA:20 a=Lx1EvxgrAAAA:8 a=3Q1zBixfIfePBc1G2hcA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=ZFi1QaP_tuf8dODdgmj-:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: UXI1zQAP2p_BAPMTHApNEYswDlZlfdYy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAxMyBTYWx0ZWRfX+5sLWjAiCxoy
 1FO/cn2ACneSK1gH90DdoALsBXJB6q5EeNiNTLQ6cg+tqkg0Mu7u7+OQTzMa3HqVi83yTvWTwWa
 8A7kWa4nto7QLNiX8qJ434S3x+oBaeQIxvsteMu9+RMIMXz4UnCL6orIMqAK6wIdi/c2aYEkiC9
 2PgrLMHzKbQoBvtaHK4twylEVsiFep+c0A2YXOJu9bXERPL9MWXZe/nUw22z9vWh0PVzPbCZx1r
 MdjKPXDQ8Pl15UC29rc3Cm44M1tsapGI66Bb3xXA5M3DiTPV1omt6OdjqCvXmUd2brw7wVW3lyJ
 lInH2bl4MJQplp+uYDrwkzsYkoDRW2iRbDWqWL+6d3oLzUCQF3toYl/nz7Y4stEtf23ED7zgOfi
 0x9HYUKtDQ6a7z2bpFzLwcF8w1VIf4AeMQKTAG01o7/+m+/6qKsNVqhJlneSVvonugF+kfsV/27
 PhPDBm13vepbSzntxMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090013
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

On 7/8/2026 6:19 PM, Ziyang Zhang wrote:
> Document the dlcall plugin under Example Plugins: what it does, the trusted-
> guests and guest_base == 0 constraints, how to load it, and a pointer to
> Lorelei, one end-to-end userspace implementation, for the toolchain and a
> runnable example.
> 
> Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>  docs/about/emulation.rst | 202 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 202 insertions(+)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index 3b4c365933..b8fdc88a45 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -1046,6 +1046,208 @@ Count traps
>  This plugin counts the number of interrupts (asynchronous events), exceptions
>  (synchronous events) and host calls (e.g. semihosting) per cpu.
>  
> +Dynamic Linking Call
> +....................
> +
> +``contrib/plugins/dlcall.c``
> +
> +This plugin provides a dynamic linking function call interception mechanism
> +for linux-user guests: the guest hands a call off to the host, where the plugin
> +runs native code in its place instead of the guest emulating it. Interception
> +alone enables several uses, for instance tracing or auditing guest calls.
> +One use is acceleration by leveraging the host's native shared libraries. For
> +example, a thunk layer can run the stock zlib ``minizip`` utility under
> +emulation while forwarding its ``deflate`` calls to the host's native zlib
> +library (libz). This avoids emulating those selected library calls instruction
> +by instruction.
> +
> +The guest issues a reserved "magic" system call (4096 by default, configurable
> +with ``syscall_num=N``) whose first argument selects a pass-through operation:
> +dlopen/dlclose a host library, dlsym a symbol, and invoke a resolved host
> +function. The plugin performs the operation on the host and consumes the
> +syscall, so the real kernel never sees it.
> +
> +.. warning::
> +
> +   Trusted guests only. The guest can load arbitrary host libraries and run
> +   arbitrary code in the QEMU host process. The plugin is not a sandbox and
> +   provides no isolation. It also requires ``guest_base == 0`` (qemu-user's
> +   default), as guest pointers are dereferenced as host addresses with no
> +   translation.
> +
> +The plugin intentionally keeps the QEMU side lightweight and knows nothing
> +about any particular library or its calling convention. Turning a real library
> +into working thunks, including argument marshalling, callbacks and variadic
> +functions, is done entirely in userspace, and any toolchain can implement the
> +interface.
> +
> +Loading the plugin is all that is required from QEMU's side:
> +
> +.. code-block:: shell
> +
> +   qemu-x86_64 -plugin contrib/plugins/libdlcall.so <guest-program> ...
> +
> +`Lorelei <https://github.com/rover2024/lorelei>`_ is one end-to-end userspace
> +implementation of this: it provides the guest and host runtimes and an
> +automated toolchain that generates the thunks from a library's headers, so guest
> +library calls run on the host's native libraries. It supports an x86_64 guest
> +running on an x86_64, aarch64 or riscv64 host.
> +
> +A minimal end-to-end example uses a one-function library, ``libhello.so``, built
> +two ways: the guest build tags its output ``from guest`` and the host build tags
> +it ``from host``. An unmodified guest program ``main`` calls ``hello("world",
> +7)``, and the thunk makes that same binary reach the host build in place of its
> +own. The sources live under ``src/``:
> +
> +.. code-block:: c
> +
> +   /* src/hello.h */
> +   #ifdef __cplusplus
> +   extern "C" {
> +   #endif
> +   void hello(const char *name, int lucky);
> +   #ifdef __cplusplus
> +   }
> +   #endif
> +
> +.. code-block:: c
> +
> +   /* src/hello_guest.c */
> +   #include "hello.h"
> +   #include <stdio.h>
> +
> +   void hello(const char *name, int lucky)
> +   {
> +       printf("hello from guest: %s, lucky %d\n", name, lucky);
> +       fflush(stdout);
> +   }
> +
> +.. code-block:: c
> +
> +   /* src/hello_host.c */
> +   #include "hello.h"
> +   #include <stdio.h>
> +
> +   void hello(const char *name, int lucky)
> +   {
> +       printf("hello from host: %s, lucky %d\n", name, lucky);
> +       fflush(stdout);
> +   }
> +
> +.. code-block:: c
> +
> +   /* src/main.c */
> +   #include "hello.h"
> +
> +   int main(void)
> +   {
> +       hello("world", 7);
> +       return 0;
> +   }
> +
> +Lorelei ships a prebuilt toolchain (a "devkit") in its releases. Download the
> +one for your host and unpack it:
> +
> +.. code-block:: shell
> +
> +   # <arch> is your host architecture: x86_64, aarch64 or riscv64
> +   wget https://github.com/rover2024/lorelei/releases/download/v<version>/lorelei-devkit-<arch>-<version>.tar.xz
> +   tar -xf lorelei-devkit-<arch>-<version>.tar.xz
> +   DEVKIT=lorelei-devkit-<arch>
> +
> +Build the guest ``libhello.so`` (x86_64) and the host ``libhello.so`` (this
> +host's own architecture), then the guest program. ``main`` links the guest
> +library with an rpath, so by default it loads that one:
> +
> +.. code-block:: shell
> +
> +   mkdir -p build/guest build/host
> +   $DEVKIT/bin/x86_64-linux-gnu-clang -shared -fPIC -o build/guest/libhello.so src/hello_guest.c
> +   cc -shared -fPIC -o build/host/libhello.so src/hello_host.c
> +   $DEVKIT/bin/x86_64-linux-gnu-clang src/main.c -Isrc -Lbuild/guest -lhello \
> +       -Wl,-rpath,'$ORIGIN' -o build/guest/main
> +

Why is rpath needed? We don't want necessarily to find the library
relative to where the binary is located.

In practice, we'll have:
- the binary
- folder A containing host library
- folder B containing thunks

A and B are not related to binary location.

> +Run it under qemu. It loads its own guest library:
> +
> +.. code-block:: shell
> +
> +   qemu-x86_64 build/guest/main
> +
> +which prints::
> +
> +   hello from guest: world, lucky 7
> +
> +Now generate the thunk from the host ``libhello.so``. This produces a guest-side
> +``libhello.so`` that stands in for the guest build, and a host-side thunk library
> +that dispatches to the host build:
> +
> +.. code-block:: shell
> +
> +   $DEVKIT/bin/LoreMakeThunk.py --name hello --lib build/host/libhello.so \
> +       --header hello.h -o thunks -- -Isrc
> +
> +Run the same ``main`` under the plugin, with the generated guest ``libhello.so``
> +ahead of its own on ``LD_LIBRARY_PATH``. The call reaches the host build now,
> +from the same unmodified binary:
> +
> +.. code-block:: shell
> +
> +   LORELEI_THUNK_PATH=thunks \
> +   LD_LIBRARY_PATH=$DEVKIT/lib:build/host \
> +       qemu-x86_64 -plugin contrib/plugins/libdlcall.so \
> +       -E LD_LIBRARY_PATH=thunks/x86_64/lib/x86_64-LoreGTL:$DEVKIT/x86_64/lib \
> +       build/guest/main
> +
> +which prints::
> +
> +   hello from host: world, lucky 7
> +
> +The guest ``LD_LIBRARY_PATH``, passed with ``-E``, is searched before the
> +program's rpath, so its generated ``libhello.so`` replaces the guest build:
> +
> +* ``thunks/x86_64/lib/x86_64-LoreGTL`` holds the generated guest ``libhello.so``.
> +* ``$DEVKIT/x86_64/lib`` holds the guest runtime support shipped with the devkit.
> +
> +The host ``LD_LIBRARY_PATH`` is QEMU's own search path:
> +
> +* ``$DEVKIT/lib`` holds the host runtime support shipped with the devkit.
> +* ``build/host`` holds the host ``libhello.so`` the host thunk dispatches to.
> +
> +The finished tree::
> +
> +   src/
> +     hello.h
> +     hello_guest.c
> +     hello_host.c
> +     main.c
> +   build/
> +     guest/
> +       libhello.so                            (guest build of the library)
> +       main                                   (the guest program)
> +     host/
> +       libhello.so                            (host build of the library)
> +   thunks/
> +     lib/x86_64-LoreHTL/libhello_HTL.so       (host thunk)
> +     x86_64/lib/x86_64-LoreGTL/libhello.so    (guest thunk, the drop-in)
> +
> +See the runnable
> +`hello <https://github.com/rover2024/lorelei/tree/main/examples/hello>`_
> +(minimal) and
> +`demo <https://github.com/rover2024/lorelei/tree/main/examples/demo>`_
> +(variadic functions and a callback that reenters the guest) examples, and
> +`Lorelei <https://github.com/rover2024/lorelei>`_ for the toolchain and the
> +runtime environment they expect.
> +
> +.. list-table:: Dynamic Linking Call arguments
> +  :widths: 20 80
> +  :header-rows: 1
> +
> +  * - Option
> +    - Description
> +  * - syscall_num=N
> +    - The magic syscall number the guest issues (default 4096). Must be high
> +      enough not to clash with a real syscall.
> +
>  Other emulation features
>  ------------------------
>  


