Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA151606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=nSVOXYh+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNUTj-0003ux-0P; Sun, 01 Nov 2026 07:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <holypumpkin@foxmail.com>)
 id 1xNN7i-0005Rt-4T
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 00:24:50 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <holypumpkin@foxmail.com>)
 id 1xNN7e-0005Mb-1w
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 00:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1793507077;
 bh=p2mljzMEe0IJKM/XG/lgk/MEXJqo6vc2iHlU/tijpsA=;
 h=From:To:Subject:Date;
 b=nSVOXYh+Li18J0N9to7SF4UDBWsp1wz6avrVfx+iUjvwuJMfXWRQrwOMZEOfzuMgQ
 9vWXDWWJjM/n6PAsQEz4cOiQb5Hltd6LcIyrH9CV8nv8q1xsMCI4zU0xqCYlpS22HG
 RBnmbU7UVBT/1tu8S0P5vHJXbeAEDOIC7WAH9/Aw=
Received: from localhost.localdomain ([113.200.174.63])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 2212124A; Sun, 01 Nov 2026 12:08:33 +0800
X-QQ-mid: xmsmtpt1793506113tugfd649z
Message-ID: <tencent_471D7439562BBAB82E2810D7746E636AC809@qq.com>
X-QQ-XMAILINFO: NQQUvflVuqBOlAYzMAFaDnw+Ry0t6endmfPnfiPMi5a0Y05iU7/mDJYyWoc4kA
 RT2ONORxIEZb/gXn/YvVnUWWWv9rqy86k3ewVXjfBj4uZ+/Kkq6PwX66uEjGg6F3vDXd+yVG7wdE
 4JbZ9FUyQbaiR480hPuyCTYzfcVir4HHMV5YoF7WTo6a4/+DkZida22aJ0YCbA9n1xylTtcVXLpN
 zHoeVFzy+3bDqk7ImB9rXb52o2nYGdkjZzgzbHTm1YI5Ls0vGzMAqjw8sIxGjKv54wFLV1qlhVS3
 oxnTGP3LmnKG7asdh1lX8UDJFlAf5CZ2jSUEmrfv/S1BJRqz184Qr72AP4kJOwnjuYYygnUyWrmF
 rw/GUJjaKuUJVVnth2O0xAYnUwCEjKZpFtFjwP+j5+byNNQN9zcsEHQiarKhuqLuEIWlfhNMt8hM
 trKzWh7rXo5IU79z1kLiDxFl9WZx15PJBVAx0852IzfO9aE2RiuMXzAS8Xf0QHzpQcFf7elNxAU1
 TtFSHAfFowRv9RLw2ON17nO09xs9GrG6GJ1NF1gfjukOz+QI6Fi9xGX6ztvzxBjcno1fSJoGB8wv
 1LjWORMb6hFFWR0syg/NuGeKjHY+aHfL5A8iqUJxklURYZAukeDw+oYZ5PgerF3UdL1SRovpnLph
 K+hL49UT941L0yxGrV0G8SzriTt0G0Ku+VKUkpfP+IbylxSzI+LzJ+mPaj1P4hKja0mkfQtSwyg6
 nVRvmAqr182u+ndisp9imQc5xBOxtI5xSVWxGH7dCGHdF4rhkKWt33XQZ8tFgUKcZCK9SZoxcu8X
 UGmDjqQeuIqvWWFmaq7m2CJACaLnK52BUgAKPBlNCWzh/eDE5/yYnO7oFoZ5mMwQEBvoa/LRxB3p
 H30Fr0trjRMEzufIrsfyX+nezlkS4m4MtNC3LMF73ipKkAhKSn/TUOrckQWGN55LFALslDcHPnVl
 SVo3p+53tLXXqWLz5tDM14JGM/J823sXw/tk44VQIWM1l46c/CbgvSAIGXekCosezb35yq0vANDp
 p8+aDP5Khu9QQJng49XJVRg8y2Wg7KU71Vql+xWcNNsRpmZp82fKMtW1QXSGIx6Wc4MzESLJ/IzP
 Vy/gvnUNSFPrMPYoKtKqhPb2ZwlGaSn+SmR+xbk4lrNfDedzKNm1AXGt/IS3DL6t7qwv5KM/9aB1
 ynvFi79AYChHxiqdHqUvL5IsnaGsN81OKqPPSw/ZP0EQRp+1yCt8gXRPgU
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Haoyu Nan <Holypumpkin@foxmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/2] tests/tcg/riscv64: cover vector configuration state
 transitions
Date: Sun,  1 Nov 2026 12:08:20 +0800
X-OQ-MSGID: <20261101040821.1841-1-Holypumpkin@foxmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.48;
 envelope-from=holypumpkin@foxmail.com; helo=xmbghk7.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Nov 2026 07:15:59 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Vector configuration instructions update both the destination register
and architectural state used by subsequent vector instructions. Add
coverage for these effects before specializing vsetvli and vsetivli
translation to avoid the generic vsetvl helper.

Exercise register and immediate AVL inputs, including zero, values
around VLMAX and twice VLMAX, and large unsigned values. Check source
and destination register aliases and the x0 forms. Include LMUL=2 and
register-supplied vtype configurations to cover the generic path.

Seed VILL, vstart and vcsr before configuration, then check the
resulting vl and vtype, the clearing of vstart, and preservation of
vcsr. Check that an invalid vtype sets VILL and clears vl. Perform
vector arithmetic after selected configurations to verify that the
following instructions observe the updated state.

Register the test with rvv_vl_half_avl both disabled and enabled,
using a matching expected-VL calculation for each setting. Disable
compiler auto-vectorization when building the test.
---
 tests/tcg/riscv64/meson.build         |  13 +++
 tests/tcg/riscv64/test-vsetvl-state.c | 142 ++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-vsetvl-state.c

diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
index 0766f4e3ff..0d3a6eb4d2 100644
--- a/tests/tcg/riscv64/meson.build
+++ b/tests/tcg/riscv64/meson.build
@@ -17,6 +17,19 @@ tests += {
     'cflags': ['-nostdlib'],
     'qemu_args': ['-cpu', 'rv64,c=false'],
   },
+  'test-vsetvl-state.c': {
+    'cflags': ['-march=rv64gcv', '-fno-tree-vectorize',
+               '-fno-tree-slp-vectorize'],
+    'qemu_args': ['-cpu', 'rv64,v=true,vlen=128,elen=64,rvv_vl_half_avl=off'],
+  },
+}
+
+tests += {
+  'test-vsetvl-state.c': {
+    'test_name': 'test-vsetvl-state-half',
+    'env_var': 'RVV_TEST_HALF=1',
+    'qemu_args': ['-cpu', 'rv64,v=true,vlen=128,elen=64,rvv_vl_half_avl=on'],
+  },
 }
 
 if 'qemu-riscv64' in emulators
diff --git a/tests/tcg/riscv64/test-vsetvl-state.c b/tests/tcg/riscv64/test-vsetvl-state.c
new file mode 100644
index 0000000000..95ed7df1ed
--- /dev/null
+++ b/tests/tcg/riscv64/test-vsetvl-state.c
@@ -0,0 +1,142 @@
+/*
+ * Check vector configuration state, register aliases and following arithmetic.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static bool half_avl;
+
+static unsigned long expected_vl(unsigned long avl, unsigned long maximum)
+{
+    if (avl <= maximum) {
+        return avl;
+    }
+    if (half_avl && avl < 2 * maximum) {
+        return (avl + 1) / 2;
+    }
+    return maximum;
+}
+
+static void seed_state(void)
+{
+    asm volatile("vsetvl zero,zero,%0; csrwi vstart,7; csrwi vcsr,5"
+                 : : "r"(ULONG_MAX) : "memory");
+}
+
+static void check_state(unsigned long expected, unsigned long type)
+{
+    unsigned long vl, vtype, vstart, vcsr;
+
+    asm volatile("csrr %0,vl; csrr %1,vtype; csrr %2,vstart; csrr %3,vcsr"
+                 : "=r"(vl), "=r"(vtype), "=r"(vstart), "=r"(vcsr));
+    assert(vl == expected);
+    assert(vtype == type);
+    assert(vstart == 0);
+    assert(vcsr == 5);
+}
+
+static void check_arithmetic(unsigned long vl)
+{
+    unsigned long value;
+
+    if (vl == 0) {
+        return;
+    }
+    asm volatile("vmv.v.i v1,7; vadd.vi v2,v1,1; vmv.x.s %0,v2"
+                 : "=r"(value) : : "memory");
+    assert(value == 8);
+}
+
+static unsigned long configure(unsigned long avl, unsigned alias)
+{
+    unsigned long result;
+    register unsigned long same asm("a0") = avl;
+
+    switch (alias) {
+    case 0:
+        asm volatile("mv t0,%1; vsetvli t1,t0,e32,m1,tu,mu; mv %0,t1"
+                     : "=r"(result) : "r"(avl) : "t0", "t1", "memory");
+        return result;
+    case 1:
+        asm volatile("vsetvli a0,a0,e32,m1,tu,mu"
+                     : "+r"(same) : : "memory");
+        return same;
+    default:
+        asm volatile("mv t0,%1; vsetvli zero,t0,e32,m1,tu,mu; mv %0,t0"
+                     : "=r"(result) : "r"(avl) : "t0", "memory");
+        return result;
+    }
+}
+
+int main(void)
+{
+    const char *option = getenv("RVV_TEST_HALF");
+    unsigned long vlenb, maximum, result;
+
+    half_avl = option && option[0] == '1';
+    asm volatile("csrr %0,vlenb" : "=r"(vlenb));
+    maximum = vlenb / sizeof(unsigned int);
+    assert(maximum >= 4);
+
+    unsigned long requests[] = {
+        0, 1, maximum - 1, maximum, maximum + 1,
+        2 * maximum - 1, 2 * maximum, ULONG_MAX,
+        1UL << 63, 0xfedcba9876543210UL,
+    };
+
+    for (unsigned n = 0; n < sizeof(requests) / sizeof(requests[0]); n++) {
+        unsigned long wanted = expected_vl(requests[n], maximum);
+
+        for (unsigned alias = 0; alias < 3; alias++) {
+            seed_state();
+            result = configure(requests[n], alias);
+            assert(result == (alias == 2 ? requests[n] : wanted));
+            check_state(wanted, 0x10);
+            check_arithmetic(wanted);
+        }
+    }
+
+    seed_state();
+    asm volatile("vsetivli %0,5,e32,m1,tu,mu" : "=r"(result) : : "memory");
+    assert(result == expected_vl(5, maximum));
+    check_state(result, 0x10);
+    check_arithmetic(result);
+
+    seed_state();
+    asm volatile("vsetivli zero,31,e32,m1,tu,mu" : : : "memory");
+    check_state(expected_vl(31, maximum), 0x10);
+
+    seed_state();
+    asm volatile("vsetvli %0,%1,e32,m2,tu,mu"
+                 : "=r"(result) : "r"(2 * maximum + 1) : "memory");
+    assert(result == expected_vl(2 * maximum + 1, 2 * maximum));
+    check_state(result, 0x11);
+
+    seed_state();
+    asm volatile("vsetvl %0,%1,%2"
+                 : "=r"(result) : "r"(maximum + 1), "r"(0x10UL) : "memory");
+    assert(result == expected_vl(maximum + 1, maximum));
+    check_state(result, 0x10);
+
+    result = configure(2, 0);
+    assert(result == 2);
+    asm volatile("csrwi vstart,7; vsetvli zero,zero,e32,m1,tu,mu"
+                 : : : "memory");
+    check_state(2, 0x10);
+    asm volatile("vsetvli %0,zero,e32,m1,tu,mu"
+                 : "=r"(result) : : "memory");
+    assert(result == maximum);
+    check_state(maximum, 0x10);
+
+    seed_state();
+    asm volatile("vsetvl zero,%0,%1"
+                 : : "r"(1UL), "r"(ULONG_MAX) : "memory");
+    check_state(0, 1UL << 63);
+    puts("RVV configuration state: PASS");
+    return 0;
+}

base-commit: 9703b6cf418d2ce72fae8d00e511135ce0bfda43
-- 
2.47.0.windows.1


