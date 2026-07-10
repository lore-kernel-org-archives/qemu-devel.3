Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93E2C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKAT-0003K7-Up; Fri, 10 Jul 2026 18:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiKAS-0003Js-6M
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:58:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiKAP-0002e7-OL
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:57:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3tVP1895217
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 19N88pNpHoDWm2jzA6yepqF9mRRZnuTWIZj8/pIqKUg=; b=dxTt1oAyQ3C72y1k
 pB7pZ20ZvZsdzwV/OrEwliLyJ/J7d0xR3q600b50ObyRdMArR2EEbhK2/ZQ8FJOI
 FNn0PbZupRXf3N+Iy8k7sMYeHWG25wZzZ4fgRDhVR5hkoUAFig7mX36aS7/utzI3
 M5Xq/fy4vkSADFkYfh0SM6ke1vnRdTBFWPwh4XQZpHWTGYwCDk9tPNxv7l8iMxJ9
 E/C+cU3w6GE2FtYahr+QCDqQQeiGBMWcLjsxRfJxnsZT0y9x0XfkcFR39Fu2lLRg
 nn76XvMNaZdCfSPm+t02bDseAtReYfRJJIroP6Pe/Kd3fbo29GvldHOPDng6I30g
 GUAHNA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xvs84x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:57:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so1815051a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783724275; x=1784329075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=19N88pNpHoDWm2jzA6yepqF9mRRZnuTWIZj8/pIqKUg=;
 b=apdGrFRzwAQqnpKxSBiQ3/kT4V1h/4XyqzopAh0/Sqi4q79rLtDFQSLM2IcrvB126W
 hWF50Brabd0wSYtVZiXJxvmKzuRq8+vFWpLZ8/yfdBu3z3EMmw3Y6OBFNIKQGSXcWGem
 HaIOM1FfIHXecHPtnkaCJEZn5XtEF0KXtPB8njkmNCxA+l03/m5kPvYM1dHtbjAIbJsA
 atseIGTFASfSyaFiodcMKUW6w4ol4Zepd5BQa0uh6izczcqru5vYhAnxbUVFKYk++EQH
 seuYgR/SJapGK9V+udoPpzdlIhx3cHfQsuBnalRxmljGazhWKDXw/svihUBcLrvv62In
 KSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724275; x=1784329075;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=19N88pNpHoDWm2jzA6yepqF9mRRZnuTWIZj8/pIqKUg=;
 b=kzlWMxlb//PfJH6ab7hXN3j1RBriWttEloj3KIovY5MTajguJ13rI8VDNGqQmW75mv
 9P4u0vQ0HaqcTkEf8zd/q0l4GT37oEGt+73jrSoDgZ54q2pGuwNW5tNqXTJbs+GF2clM
 PQDOEtpD8TFjWDRDOb6WnBbXhv/Dc33x8/r6EOl9GkuHFE5xuq85PElA9v84CKgIRYVq
 TjWLShCV/CWtzFj/yey700wWQfQvVtRm5MpPT9lPY3zyCD42ZQyP8iQZgDrYQDTSb3Sk
 HGbuIVF/TbI0J2LfjLxZbCiVHqt8RZ49KiUDVhKp5ywBDjplridtCCEP474Ze5wuF1C1
 6ywA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqH1Vk8/FF6gox5AATR/yIU/gIJwNyV2dXzzHM2krNUDzfO2TvUTjgyzdzEUKpKRXo5m9W/3odr8Hv@nongnu.org
X-Gm-Message-State: AOJu0YzCwmke+2I7DNjNeKhpQTExOLwiiu0B0oQDx9Duubfnf5m/QO5f
 kOlkd96CyqhocwUwdr9OD3phVRqJiT5AheS+hAQU8rvtJBB3BdXhvkC7+OvWmILH1e2Ons/CJyl
 bZ8fO7vIOXLVJiFOaeWYh643/7F6BhboFSTXt7MM+0ICgchppRqkaLXhaKA==
X-Gm-Gg: AfdE7cm4fM2G35hQcBBr8u59ZGiO9mrN9ASZxPozuC8jAaI1r0XgU+N/J5DoYS6Xyhb
 09Hr6qGGQ/XcZkxInreFlwdhAxjjcaRZidtI23aY/q0bl/zH8VzI33ZLLJOGS31K8W3DEY1zoZL
 eQjdrg16Cv7nD4v88vSV/h9+TXpRAn4qm5aZzljDX3inoUTh3YYp2BccHwTvsU4sEA+Suwy9oWr
 yQDgGjfuLLYxhfaGi+PWt5l8euLDNhfkXiWYbSPgZYBb7pfxhj3kx293DxALjI7GhnKGT3yxMNE
 yawyQf120mp36wbXD2ohcKIhzaBkfa8wYGBxpW1RKJUAUN7aPZT62VQgYyu6W1H1v+nZMUUa3xa
 FYKXN+wrLSzcY44g/q1w5UKXm+6ZR7WN4t6kxBK+STR91EGV6d9nGIlddUb/RHWmOhwoE/0+P8h
 AJm+c=
X-Received: by 2002:a05:6a21:6190:b0:3c0:9c18:d5aa with SMTP id
 adf61e73a8af0-3c1111a84f5mr853593637.71.1783724275365; 
 Fri, 10 Jul 2026 15:57:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:6190:b0:3c0:9c18:d5aa with SMTP id
 adf61e73a8af0-3c1111a84f5mr853569637.71.1783724274797; 
 Fri, 10 Jul 2026 15:57:54 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f5975sm41604313eec.4.2026.07.10.15.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:57:54 -0700 (PDT)
Message-ID: <990f11f5-c8fd-4cf6-b186-180e24452ff3@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:57:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260710212601.583352-1-functioner@sjtu.edu.cn>
 <20260710212601.583352-3-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260710212601.583352-3-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PWBJZl34RRdxDraCa5-0_LMR6QNM5cIC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIzMCBTYWx0ZWRfX0p22KilFq5Eb
 7iVujPKIsHZJrnBTda31lrn/mkuz6RWAwbdRDs2m/6uGJH6aPk6aZ0kTYiXUPsAgDhFAHubiKis
 GUXmDfI6zcfjnU2Zl4XriNUer0EWsPT1LEIEgUv95EGa3CaIe1JHKMpEeSBgENEkE0NklY4t89D
 YRNLvVL0K9yepsItUDZBdz1+xKKiWwozBD4J4Si7Y0BVKY+CjBoO/NcE+2Thc79DStqaAINGaRZ
 85IHcX8E0pVruy+gwreikCx1yLPTB+cYT7ExOizYrSSmQYKF9afIRrsTgZFOqydKkPFCseQFDrd
 AqVptUmVMb8qFTyOEpD9N+KQnfEyxKqf0oASGuDNazysr2kMfQSjmGvNSu7i7jb/IYeyEUb47t+
 pBjuvFAmu8wPuw7/MceUF2aTWY12Q5Cnx4co41iwX93phObBrTreDLnKl58COIOn6gud5BYi4Lj
 hR3dhOGWxi+BCEV/XzA==
X-Proofpoint-GUID: PWBJZl34RRdxDraCa5-0_LMR6QNM5cIC
X-Authority-Analysis: v=2.4 cv=HInz0Itv c=1 sm=1 tr=0 ts=6a5178f4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=jQIij1hyAAAA:20 a=xNf9USuDAAAA:8 a=Lx1EvxgrAAAA:8
 a=YYnCLPYtJ6xWOe2PXswA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=ZFi1QaP_tuf8dODdgmj-:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIzMCBTYWx0ZWRfX7b8TdE5lFzFo
 pDs2BGycSNlfgow2lXyKuYfp4c+r7JKASzFLOdruTK17HDpHkFckp3QiXmrqlqECG4bTdAt++V8
 ps/U3GDgXgSBU6j4Z4h/yHNgq4oOOHE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100230
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

On 7/10/2026 2:26 PM, Ziyang Zhang wrote:
> Document the dlcall plugin under Example Plugins: what it does, the trusted-
> guests and guest_base == 0 constraints, how to load it, and a pointer to
> Lorelei, one end-to-end userspace implementation, for the toolchain and a
> runnable example.
> 
> Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>  docs/about/emulation.rst | 156 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 156 insertions(+)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index 3b4c365933..4f5ad1b3c6 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -1046,6 +1046,162 @@ Count traps
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
> +two ways: the guest build tags its output ``(from the guest)`` and the host
> +build ``(from the host)``. An unmodified guest program ``main`` calls
> +``hello("World", 7)``, and the thunk makes that same binary reach the host build
> +in place of its own. The sources live under ``src/``:
> +
> +.. code-block:: c
> +
> +   /* src/hello.h */
> +   void hello(const char *name, int lucky);
> +
> +.. code-block:: c
> +
> +   /* src/hello_guest.c */
> +   #include "hello.h"
> +   #include <stdio.h>
> +
> +   void hello(const char *name, int lucky)
> +   {
> +       printf("Hello, %s! Your lucky number is %d. (from the guest)\n", name, lucky);
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
> +       printf("Hello, %s! Your lucky number is %d. (from the host)\n", name, lucky);
> +   }
> +
> +.. code-block:: c
> +
> +   /* src/main.c */
> +   #include "hello.h"
> +
> +   int main(void)
> +   {
> +       hello("World", 7);
> +       return 0;
> +   }
> +
> +Lorelei ships a prebuilt toolchain (a "devkit") in its releases. Download the
> +one for your host and unpack it:
> +
> +.. code-block:: shell
> +
> +   # for an aarch64 host; see https://github.com/rover2024/lorelei/releases
> +   ARCH=aarch64
> +   TAG=$(curl -fsSL -o /dev/null -w '%{url_effective}' \
> +         https://github.com/rover2024/lorelei/releases/latest | sed 's|.*/tag/||')
> +   wget "https://github.com/rover2024/lorelei/releases/download/$TAG/lorelei-devkit-$ARCH-${TAG#v}.tar.xz"
> +   tar -xf lorelei-devkit-$ARCH-*.tar.xz
> +   DEVKIT=lorelei-devkit-$ARCH
> +
> +Build the guest ``libhello.so`` (x86_64) and the host ``libhello.so`` (this
> +host's own architecture), then the guest program:
> +
> +.. code-block:: shell
> +
> +   mkdir -p build/guest build/host
> +   $DEVKIT/bin/x86_64-linux-gnu-clang -shared -fPIC src/hello_guest.c -o build/guest/libhello.so
> +   cc -shared -fPIC src/hello_host.c -o build/host/libhello.so
> +   $DEVKIT/bin/x86_64-linux-gnu-clang src/main.c -Isrc -Lbuild/guest -lhello -o build/guest/main
> +
> +Run it under qemu:
> +
> +.. code-block:: shell
> +
> +   qemu-x86_64 -E LD_LIBRARY_PATH=build/guest build/guest/main
> +
> +which prints::
> +
> +   Hello, World! Your lucky number is 7. (from the guest)
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
> +Run the same ``main`` under the plugin. The call reaches the host build now:
> +
> +.. code-block:: shell
> +
> +   LD_LIBRARY_PATH=$DEVKIT/lib:build/host \
> +       qemu-x86_64 -plugin contrib/plugins/libdlcall.so \
> +       -E LD_LIBRARY_PATH=$DEVKIT/x86_64/lib:thunks/x86_64 \
> +       build/guest/main
> +
> +which prints::
> +
> +   Hello, World! Your lucky number is 7. (from the host)
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

Great work, the workflow is now ready!

A few small issues are left with lib dependencies.

libstdc++
---------

LD_LIBRARY_PATH=$DEVKIT/lib:build/host \
./build/qemu-x86_64 -plugin ./build/contrib/plugins/libdlcall.so \
-E LD_LIBRARY_PATH=$DEVKIT/x86_64/lib:thunks/x86_64 \
-L /usr/x86_64-linux-gnu/ \
build/guest/main
build/guest/main: error while loading shared libraries: libstdc++.so.6:
cannot open shared object file: No such file or directory

Indeed, libstc++ is not available in machine's x86_64 sysroot by
default. It works with -L $DEVKIT/x86_64/sysroot but as mentioned
previously, we don't want to use another sysroot than the one that user
has, since it can contain extra libraries we are not aware about (or
Lorelei one can bring extra dependencies that we don't want).

So the last thing needed is to link statically libstdc++ for guest thunk
and host thunk. In addition, you can do it for lorelei .so (I mean .so
included in devkit), so thunking is fully self contained and does not
require extra dependencies from the system where it runs.
Same for libgcc.
Link parameters you need are -static-libstdc++ -static-libgcc.
Once added, all thunks and lorelei devkit should be portable between
different machines 👍.

The only base dependency we can assume will be present is libc (which
also includes libm.so).
We could argue if c++ should be considered as a base dependency also.
For debian (+ubuntu), fedora and archlinux, it's not.
See what is included in debian libc package. For instance, in our case:
https://packages.debian.org/trixie/all/libc6-amd64-cross/filelist

doc
---

While at it, please add -L /usr/x86_64-linux-gnu/ to command line so it
matches the default people will use.

rpath
-----

It seems that .so in thunks have rpath set to $ORIGIN:$ORIGIN/../../lib,
which should not be needed. LD_LIBRARY_PATH will specify where to find
the correct libraries, please remove it.

You can use this command to double check this:
readelf -d thunks/libhello_HTL.so thunks/x86_64/libhello.so
No RUNPATH should be present.

thunks/libhello_HTL.so has an explicit dependency to
build/host/libhello.so. It should not include build/host and just link
to libhello.so. Remove rpath also.

thunks/x86_64/libhello.so, remove rpath.

To clarify, lorelei-devkit-*/*/lib/* can use rpath since devkit itself
is self contained. Thunks can not.

-----

Once solved, we'll have a clean and minimal workflow, which ensure
thunks do not require any extra dependency.

With this, any user will be able to grab a lorelei devkit + a thunk
tarball and use it as a drag and drop replacement for their system
libraries, as long as it matches their version of course.

Keep up the good work!
Pierrick

