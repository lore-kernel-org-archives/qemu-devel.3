Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDEEC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 23:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whc71-0001dy-Ud; Wed, 08 Jul 2026 19:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whc70-0001dm-0w
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 19:55:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whc6x-0001Fq-ME
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 19:55:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668N91pO084296
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 23:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HYOBR/zRD6Rzs5A8fkiuV6GUyBQH63+irGPk6xdytuM=; b=jbQtVoBdtF4/y1vk
 5c7nER1bBv6gjSMpQXZWJ+QY3d50nQSj5ieGLnpCVDJESzqmTbNJZdcDgG9bmEWK
 zZ0YJLOa9TYuaBewQa8CpKTolrytsWDvsaqMf6tPPQAjc4Kj1qy27Wnmkl9bqhMg
 /PNztAUdDSbwkcVzXuXa0UIv4XKzoWZHGMzhkAqi2fzEBLnYAjga9HPqKb+/7Wcf
 /Xk61tSqLU1Ptc5Yj23jvBE1ZiXrzq6fU9xeuC+glh35MmfjPHSULMZGWRJO7Omz
 Nu5CtmVgzFcuwnmRUWaxCMn8eu7BUzXs1Dhxm2ag2B7Xw2BfshvbxvNjBmOiqSG2
 PWNs9g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4vrvjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 23:55:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c889d1eebafso2598276a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783554923; x=1784159723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HYOBR/zRD6Rzs5A8fkiuV6GUyBQH63+irGPk6xdytuM=;
 b=SmB9JrSreMqVaYUjXcRUdqciVV95JsernOmAjoYjy/E4aVYdK9zv3tjbDikw2UOpW/
 ZBbeAL8qcoBPtxVoEuYV7B1zPm++e2pow1/DItMXm34sXB5eEulfBs6XhwEVbJiQbVqL
 P4QCaoGbcTBMLRjd5lPakQDksNEdH7cCKyBuC2HNKVc6R+GnahAj4wlceNc0eUatoA7V
 68gaanTN+6euW22G4AUs6SC/s/AHKEtzEa38C4tFYQZFJsN9DLks/iuR/x0ywz62rY8l
 ejDRkR44Uhd7ngmWcJszolBSuzzic4UEygXdcCytOV+i+6T7zE/aKuLORHlmZF3dMsTd
 e3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783554923; x=1784159723;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HYOBR/zRD6Rzs5A8fkiuV6GUyBQH63+irGPk6xdytuM=;
 b=Alcru5AoIgaBT3qqM//IvD38WdCHnGTjBHvkl2CN9BgW4BGkQ42BtpPjtJ7U4jOzuC
 VUTCempQdDbSeIn7LOgDulA5VoMxoz1MBd35lRwRuYN7uDefe8W+CIpcgSHtiFe79lhN
 omQcHgl0+0et+JI6e1Tzu5o5AglimDK3voghA+vJsou+D6j4Uo+T3EAhjWB5WDB++kkc
 q/6lHAG84gMuWLptEYWF5cR5BtgyGQTT/mHqneD5aoi8s5ON5oZ7j0yNsy1Tl0q4YJHK
 JJGc0Z+UxUdE/tzSYb8917aVEA3bQtTDjS92RuzdzvW2/WNWKCTgwrBT26W39GlLxOM9
 Mw+w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+NaxXAYubSvZtlzBO29NpH0uk55KiXed5C6H7GNJJYoWIp0JaB29eyAzpf08JOlSDsP53j6W4ydOj@nongnu.org
X-Gm-Message-State: AOJu0Yymms0be1hNtjwykE5BKljnI0NAlGdfSJrQxdzhMbqWdS94uUML
 pMbvxa1ijnl28URngSMSVbjBBObRVPfhGbvVY5tiFu9bcDmQ4K1a4v7a7umxt0W+VhOxTJ0N+lc
 qQ9h5y/unsfQw0TTlJYpMQzoU78O2iTaF2DdHyTMGBOepsQMnqPd+MPAnzg==
X-Gm-Gg: AfdE7ckCF62qBUeMBGrArzmoqkyIcPV+KH+YzVuIba2zi6vSHnoZBkAXICfbzUyWnUL
 L15kZIM3ydCkFpEyrRSPkmfLeTjYYHGhJ+3xbPP2G7jJfTau6eBKxEB+7X0EpQZq+o7zw/TSRnD
 KKIlh+/aPHGcyW/1tfyCpl5G4U13ECiRxDv+Z1JPIO25ASen2EaJyNHDZirnuhqJyJp6ncRL+st
 EYvo7zFhMQEMzzo9NPG1w8VIZXvoRifwGsz8X8LsiUJho2R+WYg0bHyHUkDa5LvQHJWgh549hN1
 ZNbVW05EOG1P24gI5bv7rHfhFuBxcMSHZwLlJqFXhNXAxQmCacHBT61EVlk09wQSHH2YkBfcvuH
 /llL6wqHM35i/c7c/R9+FYIjTg/xh9bBMDde5LduDvAZeTeSwFy62o1E0ZLMIiTSVh8Ip9d3Bcs
 s1xqI=
X-Received: by 2002:a05:6a21:497:b0:3bf:b69c:1f54 with SMTP id
 adf61e73a8af0-3c0bd276aeamr5583015637.57.1783554922993; 
 Wed, 08 Jul 2026 16:55:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:497:b0:3bf:b69c:1f54 with SMTP id
 adf61e73a8af0-3c0bd276aeamr5582938637.57.1783554922082; 
 Wed, 08 Jul 2026 16:55:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3119c2a7bb5sm4662541eec.25.2026.07.08.16.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 16:55:21 -0700 (PDT)
Message-ID: <6abd4f15-03b5-4036-a016-74269e87c36a@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 16:55:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260708152043.251537-1-functioner@sjtu.edu.cn>
 <20260708152043.251537-3-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260708152043.251537-3-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HwkeCUw90SAJFoNx0xE-3Ifbfv4eeXzq
X-Proofpoint-ORIG-GUID: HwkeCUw90SAJFoNx0xE-3Ifbfv4eeXzq
X-Authority-Analysis: v=2.4 cv=GIg41ONK c=1 sm=1 tr=0 ts=6a4ee36b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=jQIij1hyAAAA:20 a=19utL_LVv2XBxaGOJe4A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIzNSBTYWx0ZWRfX29Noa1kQ9z2h
 tf1wsyOrhhVL/iArfV0HWN48EaY7S6OttcXblfkYruEY0sJsjyEFsMeQo28F+qA9HlZb++6lbds
 yYV2THbwVjxxVd9Xv1r6CtuzSS7DCIafpJ14yHr2yvS2PmyTBBMBv1zs+tGiy8gzxJZMMoaBmrK
 aIK+FFAaNFsLWXhtjvC3ia/fcxba9o0pdO4YQqHmO8BIlcQ3u+5MIPIs1SJA8BSfq3BvE3u+Tp2
 RtiA+MGk/6ZsEl7JGRDhq1I05klok5p+WRBROh7ruhVYtj9rG8dAnSif/S3vCGesGg9KafTMZV9
 1tX3mJ1QDYuRJrkZPBKYGl6STITiv6Ziue1Ju4liLWvJzcVCVWcmN6QIhvbvcWz3Z4HKWIvFsjN
 8dytE5UK7sNeTuH81daP2DULDjnteUnCaUiR2SaOFPR7ObVBWh00zmnJ8VrbaJelnW5P3bfDw1y
 vHZMcuhGbkZgq6YV/lA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIzNSBTYWx0ZWRfXxrhpACfmMGZy
 ks1sS9mbspLaq64XpyLdkTKTEW3eC4bZ4ofl5YX0c9GE2qnbWxLeMJT5FeF68zto6cOHHQ36Wt3
 ccXMOc0OWPtpkyISHtzjVLVkW6aLN4o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080235
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

On 7/8/2026 8:20 AM, Ziyang Zhang wrote:
> Document the dlcall plugin under Example Plugins: what it does, the trusted-
> guests and guest_base == 0 constraints, how to load it, and a pointer to
> Lorelei, one end-to-end userspace implementation, for prebuilt thunks and a
> runnable example.
> 
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>  docs/about/emulation.rst | 122 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index 3b4c365933..07fbd24072 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -1046,6 +1046,128 @@ Count traps
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
> +library calls run on the host's native libraries. Its prebuilt thunks are for an
> +x86_64 guest, running on an x86_64, aarch64 or riscv64 host.
> +
> +A minimal end-to-end example wraps a one-function library, ``libhello.so``,
> +declared by ``hello.h``:
> +
> +.. code-block:: c
> +
> +   void hello(const char *name, int lucky);
> +

Please include full files for example:
hello.h, hello.c and main.c calling hello function.

Also, please include compiler commands for libhello.so and main.
You can give a full example assuming it run on a x86_64 host.

> +The guest program ``main`` is an ordinary x86_64 executable, linked against a
> +guest ``libhello.so`` and calling its ``hello()``. The host has its own
> +``libhello.so``, the same library built for the host. The goal is to run
> +``main``, but have each ``hello()`` call run on the host's ``libhello.so``.
> +
> +Lorelei ships a prebuilt toolchain (a "devkit") in its releases. Download one
> +for your host and unpack it:
> +
> +.. code-block:: shell
> +
> +   # <arch> is your host architecture: x86_64, aarch64 or riscv64
> +   wget https://github.com/rover2024/lorelei/releases/download/v<version>/lorelei-devkit-<arch>-<version>.tar.xz
> +   tar -xf lorelei-devkit-<arch>-<version>.tar.xz
> +   DEVKIT=lorelei-devkit-<arch>
> +
> +A single command reads the host ``libhello.so`` and ``hello.h`` and generates
> +the thunk: a guest-side ``libhello.so`` that stands in for an ordinary guest
> +build, and a host-side thunk library that dispatches to the real one:
> +
> +.. code-block:: shell
> +
> +   $DEVKIT/bin/LoreMakeThunk.py --name hello --lib libhello.so --header hello.h \
> +       -o thunks -- -I.
> +

Sounds good.

> +Running ``main`` under the plugin forwards each ``hello()`` call to the host's
> +real ``libhello.so``:
> +
> +.. code-block:: shell
> +
> +   LORELEI_THUNK_PATH=thunks \
> +   LD_LIBRARY_PATH=$DEVKIT/lib:. \
> +       qemu-x86_64 -plugin contrib/plugins/libdlcall.so \
> +       -L $DEVKIT/x86_64/sysroot \
> +       -E LD_LIBRARY_PATH=$DEVKIT/x86_64/lib:thunks/x86_64/lib/x86_64-LoreGTL \
> +       ./main
> +

I could not get it to work.
Following all the steps, the error message is:

[GRT] failed to load host runtime
qemu: uncaught target signal 6 (Aborted) - core dumped
Aborted

We talked about not overriding sysroot, so please remove -L part.
Also, Why do current dir is passed in LD_LIBRARY_PATH?

> +The guest ``LD_LIBRARY_PATH``, passed with ``-E``, controls what the emulated
> +program loads:
> +
> +* ``$DEVKIT/x86_64/lib`` contains the guest runtime support shipped with the
> +  devkit.
> +* ``thunks/x86_64/lib/x86_64-LoreGTL`` contains the generated guest
> +  ``libhello.so`` thunk, used in place of an ordinary guest library.
> +
> +The host ``LD_LIBRARY_PATH`` controls what the plugin and host thunk load:
> +
> +* ``$DEVKIT/lib`` contains the host runtime support shipped with the devkit.
> +* ``.`` is the current directory, where the host's own ``libhello.so`` is
> +  located.
> +
> +See the runnable
> +`hello <https://github.com/rover2024/lorelei/tree/main/examples/hello>`_
> +(minimal) and
> +`demo <https://github.com/rover2024/lorelei/tree/main/examples/demo>`_
> +(variadic functions and a callback that reenters the guest) examples, and
> +`Lorelei <https://github.com/rover2024/lorelei>`_ for prebuilt thunk trees and
> +the runtime environment they expect.
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

Regards,
Pierrick

