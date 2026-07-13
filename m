Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E746C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjL3O-00037d-GJ; Mon, 13 Jul 2026 14:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjL3M-00037P-Nz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:06:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjL3K-0006eI-D8
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:06:52 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF8DcG1611656
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Bqk8mP195HN
 kw6fg3JtNDjDDd6rttLWS2pjOqiBhIvE=; b=Ubb8iGlI/6byd8zhl2V/Y1EHrTx
 kTgap8b6b2nLA+pW0ddy1uT06vIEr4MlbeUGzq1f7AzjkNDHsYv2D/LkncT5gJM7
 7mas0EhsqK0AZjocm9ldMEGPId7yO7Dly+/bhwoo8afyR6/6wa4K4GTg9XK4Kifw
 EfNtWi1HzzZISdjPD8O/2A0yJZAOS96YkrIw50ySFU/ngXCkNAOLQ9ezkL+ZhEzq
 0hlKVg3Cs5qAyFHsGn5tj4XpnHBpIi5Y4KdyVk9SZ4R92DVsBJmjeOJKowd6tKJy
 wQwveD47Oh+jfw6zlQoTs7hJv71aiYiWc7AaXTKsuNZD2wpUhHsnNwvwdtQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qt52p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:06:48 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c890bac374eso8777034a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783966008; x=1784570808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bqk8mP195HNkw6fg3JtNDjDDd6rttLWS2pjOqiBhIvE=;
 b=e5S0IFQ2KVIs97LGCfYVwjq/6wLM6j+tqjK9dNBEyhABoLE4eJuP1DSwFUcBQtwmlb
 AO+qqWEDfvFsItmmbM9u1JcFxjSXf4SHAUoVY6EqYbO6wK3nXSPstUrveW1DDYnkP671
 pJfZJAY/fauKYV1/vJmP4mXhCmX9sKoVl79nghDP5SPVP1HXpIw25yaAezhny8LCTMRl
 x66yKPkoUzArwUvaoQJiRr7ou8mfWF7tHnbpEUwLQz6n5ShzxgaPGsYhJQ13C58hAqcB
 njQxVrEozQDDW6nHldq2oLGIBhjMrQPhA3llP+7tcJi7Udfv8ar2xpvMM+YBFoA9YwZ2
 yc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783966008; x=1784570808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bqk8mP195HNkw6fg3JtNDjDDd6rttLWS2pjOqiBhIvE=;
 b=HLPNf4JnD52fVl+7zfpxzRuK/nt4UiXWSHGeaecvYwRQ3kxiArBcFmrKE+PVFbTNKD
 EqHlYifYGJFDo9SnHRlA6cRQWsfPQ1mps7e+Gk5OZ81nPEPkhcnDKOqYPE3ztuyWhK2J
 PnvwsKJAVgYqH0UZtwad0/mbIjjGu3YISp/OPctlOI2wI6Hst1U1n0HW6MtNDmKizlEH
 zjQ90NIxEM/NIppP78s7k35XBZwZWd+aU4JeMjiCrkxR/ar4MkZQPayXoFWHQ14O16yG
 Py9i2dQAc+UAhFk9bd4u8jcUAPT8l7Xg5k24QHLY+0ivxWHAJndqeEe2hBCl68jai6Q3
 A4+w==
X-Gm-Message-State: AOJu0YzhKHKJvafX++qdEWTuyTT2vmbhYp6MVYaSsJvflEHZtuZUd13E
 l8TBEKb/jOkg36n6Dq7/rEN2DErk/p5C16JE/DB8Z1JCo/HO+fD/YzIWeFfcr6hIWlbGN5euT4o
 2Xf+aEPX4YgfisK2aKnc1g/KOLIpFkvQVTeLNcyWsdTm8Vs1McON8BVcyjbsPaYUs7g==
X-Gm-Gg: AfdE7ckiLbfdjbgRtFxjQImGtmrIndYp/TAOLuO9hkoA6touU4oQI2elpLdJcYwWbyM
 dHCL3laqxSkpDy3ED3I8oSxcB8c7qtJAnKLgOLffY39Ehe3B0GvcSmEYk9OzahnRvswixioTtgL
 DkwgJnBJPvAbt/SDenrq1ymXgPUvJzYSoGwRI/d3L1wys8Z0fw3BTSDf23LYCMxZPkGjKlXL6e2
 QJNrxu79Qv3QDro0Aou+XGuT2KETEagbDtecjf/0jcSlIYshPD4tqQAIEjFPu+v1bNvoxLOa1LX
 3wr1DexNQcz7dI0v7gPh6rQxhtyvy5Ztgdcgt2MDy9/okr8Vxgr1yb8gpY7C94M8/f+X5ZdAG8Q
 BV412WlT5sTpw6PKl7ZWHlcwlbOhswnvo00M6kdm32Tv9ARFkqH+v+GVFKjCWVokHIq70Ubxqpf
 ug3q18Fw==
X-Received: by 2002:a05:6a21:46c5:b0:3bf:b40b:def2 with SMTP id
 adf61e73a8af0-3c11003092dmr10350031637.9.1783966007459; 
 Mon, 13 Jul 2026 11:06:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:46c5:b0:3bf:b40b:def2 with SMTP id
 adf61e73a8af0-3c11003092dmr10350003637.9.1783966006934; 
 Mon, 13 Jul 2026 11:06:46 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b8a5992c9sm27501109c88.4.2026.07.13.11.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:06:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/3] docs/about/emulation: document the dlcall plugin
Date: Mon, 13 Jul 2026 11:06:38 -0700
Message-ID: <20260713180638.2228609-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713180638.2228609-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260713180638.2228609-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4NyBTYWx0ZWRfX4TzqEQcaWczN
 OsxRYUHxOSJA11DLMRv7XBrOfWYfqKpuZcpy0iG+S/gg+GxbSS6jX9U8JU3NBZlUoyJYCBK247P
 YAlunByHNgr/bQvJlMJ6NFvecsljHqf5Dv+T8znF2Gkf/W3OZjj2w/pnhkpekVpBJVrWOELDxCk
 cfEn5xxpFrwnwEbUX4xBnIg6XgiQJC9leBln9OpCIljWPfZYj6dnxuVJXeMjZQCL4bGWmVp9jvY
 8iWW6wL3y1NPLXYw67PJoAV6rvrhCnc9rzrowalxF4rXDzkEbD0sAUcXaUtDnDN2gNTgYaIVy8C
 Y7/wyVV0XfKwgCyHuFVicnBF31XWF/X0H24Iq0t9kG33AgiSWiIfHJ7truLoQVK7JXR4HU9FseN
 4pog/QMiwFlYicXOZqkP35O7SU3qaotHla2/umz2+t27lUv8AYJPpd4DUvbnUJhMgHmwGQLg3f1
 w5tIK/YO/uaQmh+CU5Q==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a552938 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=jQIij1hyAAAA:20 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8
 a=jqyheP39vwLst_Jpb7sA:9 a=x9snwWr2DeNwDh03kgHS:22 a=ZFi1QaP_tuf8dODdgmj-:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 2BeIc5CpQLOrP-EDCdWtsocuZ6U6ddLS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4NyBTYWx0ZWRfXyYxA3h5l+bHh
 shwzhdmoS97HAdq5ChBt+WZUjtJyF0qaotKvmVaDGAz53syhhdX0iIgY5vGaZL2k8funZq6Or0U
 mYY9L87UVsPSKdnzhldjrykXiUDOozg=
X-Proofpoint-ORIG-GUID: 2BeIc5CpQLOrP-EDCdWtsocuZ6U6ddLS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130187
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

From: Ziyang Zhang <functioner@sjtu.edu.cn>

Document the dlcall plugin under Example Plugins: what it does, the trusted-
guests and guest_base == 0 constraints, how to load it, and a pointer to
Lorelei, one end-to-end userspace implementation, for the toolchain and a
runnable example.

Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260711094523.622997-3-functioner@sjtu.edu.cn
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/about/emulation.rst | 158 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 3b4c365933d..b861501e85e 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -1046,6 +1046,164 @@ Count traps
 This plugin counts the number of interrupts (asynchronous events), exceptions
 (synchronous events) and host calls (e.g. semihosting) per cpu.
 
+Dynamic Linking Call
+....................
+
+``contrib/plugins/dlcall.c``
+
+This plugin provides a dynamic linking function call interception mechanism
+for linux-user guests: the guest hands a call off to the host, where the plugin
+runs native code in its place instead of the guest emulating it. Interception
+alone enables several uses, for instance tracing or auditing guest calls.
+One use is acceleration by leveraging the host's native shared libraries. For
+example, a thunk layer can run the stock zlib ``minizip`` utility under
+emulation while forwarding its ``deflate`` calls to the host's native zlib
+library (libz). This avoids emulating those selected library calls instruction
+by instruction.
+
+The guest issues a reserved "magic" system call (4096 by default, configurable
+with ``syscall_num=N``) whose first argument selects a pass-through operation:
+dlopen/dlclose a host library, dlsym a symbol, and invoke a resolved host
+function. The plugin performs the operation on the host and consumes the
+syscall, so the real kernel never sees it.
+
+.. warning::
+
+   Trusted guests only. The guest can load arbitrary host libraries and run
+   arbitrary code in the QEMU host process. The plugin is not a sandbox and
+   provides no isolation. It also requires ``guest_base == 0`` (qemu-user's
+   default), as guest pointers are dereferenced as host addresses with no
+   translation.
+
+The plugin intentionally keeps the QEMU side lightweight and knows nothing
+about any particular library or its calling convention. Turning a real library
+into working thunks, including argument marshalling, callbacks and variadic
+functions, is done entirely in userspace, and any toolchain can implement the
+interface.
+
+Loading the plugin is all that is required from QEMU's side:
+
+.. code-block:: shell
+
+   qemu-x86_64 -plugin contrib/plugins/libdlcall.so <guest-program> ...
+
+`Lorelei <https://github.com/rover2024/lorelei>`_ is one end-to-end userspace
+implementation of this: it provides the guest and host runtimes and an
+automated toolchain that generates the thunks from a library's headers, so guest
+library calls run on the host's native libraries. It supports an x86_64 guest
+running on an x86_64, aarch64 or riscv64 host.
+
+A minimal end-to-end example uses a one-function library, ``libhello.so``, built
+two ways: the guest build tags its output ``(from the guest)`` and the host
+build ``(from the host)``. An unmodified guest program ``main`` calls
+``hello("World", 7)``, and the thunk makes that same binary reach the host build
+in place of its own. The sources live under ``src/``:
+
+.. code-block:: c
+
+   /* src/hello.h */
+   void hello(const char *name, int lucky);
+
+.. code-block:: c
+
+   /* src/hello_guest.c */
+   #include "hello.h"
+   #include <stdio.h>
+
+   void hello(const char *name, int lucky)
+   {
+       printf("Hello, %s! Your lucky number is %d. (from the guest)\n", name, lucky);
+   }
+
+.. code-block:: c
+
+   /* src/hello_host.c */
+   #include "hello.h"
+   #include <stdio.h>
+
+   void hello(const char *name, int lucky)
+   {
+       printf("Hello, %s! Your lucky number is %d. (from the host)\n", name, lucky);
+   }
+
+.. code-block:: c
+
+   /* src/main.c */
+   #include "hello.h"
+
+   int main(void)
+   {
+       hello("World", 7);
+       return 0;
+   }
+
+Lorelei ships a prebuilt toolchain (a "devkit") in its releases. Download the
+one for your host and unpack it:
+
+.. code-block:: shell
+
+   # ARCH is your host's architecture: x86_64, aarch64 or riscv64. This example uses aarch64.
+   # See https://github.com/rover2024/lorelei/releases
+   ARCH=aarch64
+   VERSION=$(curl -fsSL -o /dev/null -w '%{url_effective}' \
+         https://github.com/rover2024/lorelei/releases/latest | sed 's|.*/tag/v||')
+   wget "https://github.com/rover2024/lorelei/releases/download/v$VERSION/lorelei-devkit-$ARCH-$VERSION.tar.xz"
+   tar -xf lorelei-devkit-$ARCH-$VERSION.tar.xz
+   DEVKIT=lorelei-devkit-$ARCH
+
+Build the guest ``libhello.so`` (x86_64) and the host ``libhello.so`` (this
+host's architecture), then the guest program:
+
+.. code-block:: shell
+
+   mkdir -p build/guest build/host
+   $DEVKIT/bin/x86_64-linux-gnu-clang -shared -fPIC src/hello_guest.c -o build/guest/libhello.so
+   cc -shared -fPIC src/hello_host.c -o build/host/libhello.so
+   $DEVKIT/bin/x86_64-linux-gnu-clang src/main.c -Isrc -Lbuild/guest -lhello -o build/guest/main
+
+Run it under qemu:
+
+.. code-block:: shell
+
+   qemu-x86_64 -L /usr/x86_64-linux-gnu/ -E LD_LIBRARY_PATH=build/guest build/guest/main
+
+which prints::
+
+   Hello, World! Your lucky number is 7. (from the guest)
+
+Now generate the thunk from the host ``libhello.so``. This produces a guest-side
+``libhello.so`` that stands in for the guest build, and a host-side thunk library
+that dispatches to the host build:
+
+.. code-block:: shell
+
+   $DEVKIT/bin/LoreMakeThunk.py --name hello --lib build/host/libhello.so \
+       --header hello.h -o thunks -- -Isrc
+
+Run the same ``main`` under the plugin. The call reaches the host build now:
+
+.. code-block:: shell
+
+   LD_LIBRARY_PATH=$DEVKIT/lib:build/host \
+       qemu-x86_64 -plugin contrib/plugins/libdlcall.so \
+       -E LD_LIBRARY_PATH=$DEVKIT/x86_64/lib:thunks/x86_64 \
+       -L /usr/x86_64-linux-gnu/ \
+       build/guest/main
+
+which prints::
+
+   Hello, World! Your lucky number is 7. (from the host)
+
+.. list-table:: Dynamic Linking Call arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - syscall_num=N
+    - The magic syscall number the guest issues (default 4096). Must be high
+      enough not to clash with a real syscall.
+
 Other emulation features
 ------------------------
 
-- 
2.47.3


