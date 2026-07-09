Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53007C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 17:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whsZU-0001K8-Eg; Thu, 09 Jul 2026 13:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whsZQ-0001Jr-HT
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 13:29:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whsZN-0003OX-OC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 13:29:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HSJee2553768
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 17:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UkJrkwjhU43RFSro4Kt/QPmHgp57NUW9Be4L1NT+d58=; b=kzjPrsQ4E9w1p/8/
 pM97HUWTCnDyg1T+ICX9uPvadhsHi98XhpkYR1T4wp5zCyG5t+xjXKIwZigCJZZj
 v4OxZRuJjst4TQyWAx0HENotJE9zP8F6IxLuVcO9kEEEvQyqKCZgFYu19aVCxvva
 p2dlZ1ymaCTQDkJblYN+c26IZ+4ZggZY5bv2JzyASNZA2XIY/ulXLrEV+eJ72/Yk
 cxj+Xh/2EeyF8tfhNC/E5QFLFg5vd6HI9QnUirAo3zAL0GEMT+RNmnj+K7WJ+b5Y
 lmILUQeg00uMqYP+n363OBNPTBZwdzxKht8tAXP488aRmgL/PrSH3YXttLVAdX1W
 86/YFQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3gkp0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 17:29:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3810960140eso182098a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783618191; x=1784222991; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UkJrkwjhU43RFSro4Kt/QPmHgp57NUW9Be4L1NT+d58=;
 b=EQpKG38acyfNV2t7PQe+9Id7nETGE33h1Wi6guGhcODPamn8Fxx8bmb6aigQMlR95P
 8wyCLl2x8e0Pj5yXAdGFS5JhlZ+LccQki7f4oqsAvC2KfkGANTAMTUTHSyF7HJcjAd8z
 F3tyq26U0XNCvSP4akgEbCxd31fgqnB19CSKsB9lE8oE2cv5tJCI/m69x8IIKKksbZMa
 IcEc7czGGYocs+MYNbBj2UO6mKy1ZrOQzd5YXPibZgiQ025PGJGyOTt34GlUIV51w/1Z
 iOHmm20Lzv1nW8my9tyDOSZlTJAmSESFOd3YEQljQ+jeOC5dF4iCLzdxu9z1C6+HA8UR
 aVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783618191; x=1784222991;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UkJrkwjhU43RFSro4Kt/QPmHgp57NUW9Be4L1NT+d58=;
 b=O9RLgNeKq0GF8+6Azjc4GckRXnlogjnHXSHCGqaZ2YubEuDeI35WKraBVI+KsH4wZ2
 WVYgA49PqpBHKgLLHASEpCVqmjDVpeuKGVE96962J3Y/Oc9bkav6DjjvvHDGho87nvfY
 meDiD1XS3yWx/efDT89eMm8Af1/Y7B6n0JJ8GtcNfpVs/RhXzCLgPGwmozPy8rA3YfHO
 DcyObg+baOkhYCF769dnvp1Lwt9WTZJJpGYrWkfLND+/6axLm+LH2A9xL5m7WxPVWY4R
 f7E0KM27XG6KE0pQ4nCC114UO5IzUpKO1hVilbJc2By3HkP1UBhg19f/4WyzInEMQ6gw
 wdjg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpf1sKx0va0ZgMQ9X5APd8tXeepmEXrzsSelacBzG0FeomLYyx+CxcgL46jOIOhX5AM+Bpp716tMy+k@nongnu.org
X-Gm-Message-State: AOJu0YwVetGD4OnuQ2Dl79M0XGX4Q0bwkf5QdlewsuRFyl01dlsaOWL0
 8nRBl/jS0R6G4hZ3cHjoSWR0oO/HFntWEnGRje0vEFjIAS+1uwJ5api9aBuG3o4kEtn9W4yqBbX
 UPXq0y3V6dF6glBKYfbgcOR8eu8y0wDV3EVcvtlN2+x1GFHvO0j7k0NmXqw==
X-Gm-Gg: AfdE7ckT6zwwybFg8MfZG61kW8mcgIcvWgpCqPBi9ySCakmXKpNb14t39R2oSjq1+HD
 kBOsGC04x8FJbAmDITbfQiJAshVYl3DAiJp6Zll44vcd42Du2W8lsu4hnWKBi1OCtxnQdkrw75g
 x/Gocmo3O4KjWmilqU3Jyv6qb8CCSHDOF8pG+Az90NmmkzbhgWk3bTtAOe3K0BLGEc7wY7iK7mn
 RfnrvVactkYtcDrKL8uFrlBCgz2l5px6AsgBIi2TxqiPOouFNm4RGoZrUxRXLcsTRooKE80PU6x
 8JaLAanfsoO5NRQRG4NPcssdPmy3oyD3X3ynP95rTAEGdELkKRSIECvk8KcYc6TPm2CiNC65XnE
 E0DObAYny65yMUZCL+AGswkG3Ic7R2l7cfZsxv6UavpBTuJYH/zopItFbyg6xYJ6v7LIIUNPJKf
 FD9vU=
X-Received: by 2002:a17:90b:2545:b0:387:e0cb:7f1 with SMTP id
 98e67ed59e1d1-389425942dcmr8294114a91.37.1783618190691; 
 Thu, 09 Jul 2026 10:29:50 -0700 (PDT)
X-Received: by 2002:a17:90b:2545:b0:387:e0cb:7f1 with SMTP id
 98e67ed59e1d1-389425942dcmr8294076a91.37.1783618190032; 
 Thu, 09 Jul 2026 10:29:50 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a5516abffsm1556796a91.4.2026.07.09.10.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 10:29:49 -0700 (PDT)
Message-ID: <3954a5e4-32c2-4f89-a4e4-4b445e52589a@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 10:29:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260709025528.300019-1-functioner@sjtu.edu.cn>
 <20260709025528.300019-3-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260709025528.300019-3-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE3MiBTYWx0ZWRfX9CPv0VDDAPk6
 hS19qlaRs1Qb8ashAIehl6mE05ogyx17lJo+T7z3xd7zLM22y18YockRRg0qXp0Ywv0OUEKOhZe
 61Fp43wTrJFrLzNWsM6U+6FY/i2k4N8Ghq+4YDD6k4jUE9lL95FJYV8r80Y/hkWWfe+OeNGWBcA
 /QPgqsRaleJMm5T1c7p2lzf4373szbT5pHPRzurgwS+kL8vlNg/ec8eiyqIvmXuVua5R/0RYNYD
 cEuPYAnceWZsYhOGx6uRZumBxp0DWW162gJaJEFuSV0cw/S+fMPODu6XrZXyGQ4TJ4AqRBvSsJA
 1x5pL2M0H1oAHlWA5xVcXGdAGAq/8lXHXLkXizHOIIsAOIwZAMmHc72HpWqWEdLj5bOQWZVbmpE
 S8rDT53M3lpDNxMDC0FzNQqDee2XR0YhbKV+ZS+jVqvEDejq+nW3CvoW8m6Dfb9ddO2c7nQ+nl6
 mp3rJeLwFx/GO6BCcGA==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a4fda8f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=jQIij1hyAAAA:20 a=Lx1EvxgrAAAA:8 a=AuJn8XObV2d6nrw1dPgA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=ZFi1QaP_tuf8dODdgmj-:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE3MiBTYWx0ZWRfX4QPFYvuTaNL3
 9w4hAKefazrjJ7dKwnctwQHQNFVm7OdLYC3f/7h0MAVgZFpAcXdL1KKhM2sRp1hBMei151njMYH
 3pdPWdmghkTShgbKvFXbK8CLXKwWDu8=
X-Proofpoint-GUID: vIzKMEb32hXxSr2mZoF94Xe0dizISQ5w
X-Proofpoint-ORIG-GUID: vIzKMEb32hXxSr2mZoF94Xe0dizISQ5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090172
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

Thanks for the update.

On 7/8/2026 7:55 PM, Ziyang Zhang wrote:
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
> index 3b4c365933..1a6480de89 100644
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

Please remove the cplusplus part, we don't need it here.

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

No need for fflush (same in hello_host)

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

Excellent, that's a nice way to see difference between guest and host.

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

Please replace this part with a proper url, choosing a specific version
and arch. Ideally, you can publish under "latest" in addition to
versioned releases on GitHub so url stays stable.

Also, please add a link to https://github.com/rover2024/lorelei/releases
in the comment so people can click this and see what is available.

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

Good.

> +Run it under qemu:
> +
> +.. code-block:: shell
> +
> +   qemu-x86_64 -E LD_LIBRARY_PATH=build/guest build/guest/main
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
> +on ``LD_LIBRARY_PATH`` in place of its own. The call reaches the host build now,
> +from the same unmodified binary:
> +
> +.. code-block:: shell
> +
> +   LORELEI_THUNK_PATH=thunks \

Why do we need this variable?

> +   LD_LIBRARY_PATH=$DEVKIT/lib:build/host \
> +       qemu-x86_64 -plugin contrib/plugins/libdlcall.so \
> +       -E LD_LIBRARY_PATH=thunks/x86_64/lib/x86_64-LoreGTL:$DEVKIT/x86_64/lib \
> +       build/guest/main
> +

This still fails on my side with following error message:
lorelei.guest-rt: failed to load host runtime: libLoreHostRT.so: cannot
enable executable stack as shared object requires: Invalid argument
qemu: uncaught target signal 6 (Aborted) - core dumped
Aborted

Seems like error message is incorrect in itself "invalid argument"?

I'm using debian trixie (stable) in case you want to reproduce this on a VM.

----

Please simplify thunks/ folder hierarchy. Make only one subfolder
(thunks/x86_64) having both the thunks and lorelei lib, and remove the rest.

With this, we can simplify command to become:
LD_LIBRARY_PATH=$DEVKIT/lib/:build/host \
qemu-x86_64 -plugin contrib/plugins/libdlcall.so \
-E LD_LIBRARY_PATH=thunks/x86_64 build/guest/main

---

Also, in lorelei tarball, why do we have /lib and x86_64/lib that have
same libraries, but with different sizes? What's the difference?
It's confusing.

It seems like x86_64/lib folder is never used?

> +which prints::
> +
> +   hello from host: world, lucky 7
> +

[
> +The guest ``LD_LIBRARY_PATH``, passed with ``-E``, is where the emulated program
> +looks for its libraries. Because ``main`` has no rpath, whatever ``libhello.so``
> +this path resolves is the one it loads. The thunk run lists the generated thunk
> +here, not the guest build, so the thunk stands in for it:
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
]

Please remove the section above from the doc since it does not add
useful information. Also, we already have a link to Lorelei above.

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

We're getting closer, hang on.
We need to have a simple example that is functional before being able to
accept the plugin.

Regards,
Pierrick

