Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900E0C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4hK-0002VT-Dh; Fri, 10 Jul 2026 02:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4h8-0002Or-EQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4h6-00065Q-L9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:42 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nUp13803933
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=F/JO9PxUAmS
 geYqkYKVvOA36VFJLtMSt8C4zkCH61cU=; b=e0+03n/bOqpuW5/OQEmYobAxllb
 rBJA8+e0lyGg5khONZFtnNtAf+qruQ1Bl6VU4Etry3wtuzQqmEmSR+4HXGXJHI/j
 AVuxcd2/dMrFRisxduxS2JIX7nzxHynTDTmBTcvq7Qw3gm6eE1nMHn7HPdl5Zwsm
 0vke7gHtyNws5FSyHAXQQZK503OHpMatSzAfNNX4Y9pdxPyCqIosvObIwJL3nn4c
 deQff7RSieTvJe1njgaK6LT1oLW28gNR+cuL1HQgbsCb0bpzphnizsalkqXJ/XMt
 EWr9rV2KAHp74iY+FjEea8bv0lbkKJoM3ETwrC9ByaDX4Bt9ajCNeWTu5aQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mtuqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccafc5e82cso6104515ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664788; x=1784269588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F/JO9PxUAmSgeYqkYKVvOA36VFJLtMSt8C4zkCH61cU=;
 b=eSXQnNHkohLtzoYqdhdtp1Nl3I0hMWcGDiZYfXxVhM9ykstuMyRlN15BR+bZerj9kv
 1ltdd++rKBExtHoIMXK2MkQZSxLknM36YU/g+ZsHZ9Foz4YF0TLSpgbkQOfxJUmf5nRL
 GXH4HDp48pleO0TmGs7rpGXLFvbqM+1Gib/9A0uBMMFNiAs8WfbAfUPKjg298DH8zkCW
 akPiX0/II81QKSGmJnzf+uZuyj1eT7kpDL1ClsWoImUqLKcSJqDjqlu44k2tJNTliXpU
 Aoi435nQpIn49HTU/kmaM2KuCJT9ozQSgg4hm1Fea0FN2Jyaf3pVPH1eKD0M1rFWKqak
 vYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664788; x=1784269588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F/JO9PxUAmSgeYqkYKVvOA36VFJLtMSt8C4zkCH61cU=;
 b=TRb9zPYgPRgwUNOdA9nBlMZdATn7kbFEz5NtuiP13cRfntd+asxuK9NsNcY5iQ8HCQ
 1fRrmhPYE6w/ooT4GCMgX3Fqcn5uhXwlpjJdrf0DCbpvmaPxmjsp7zfo/OtZOrmHkLgX
 sENtzxUJ9oDRrJnqCmaRLMm+w0uxD1tzEwwK1+ScMwajQNfMwgk/lfN1xwunZrp1yXP1
 eU9Y52cr12Inn3QSyg/O0bA5qgSjTFL+oRLQz0jkeyR6YY9wK5lXrO1TEoaiu0oyPd97
 vA5kJol3GJM797QZeqz7pGOX4LtksBVn0cpEK/SW1HGdiIIakbvwZQ0YVO4VktrHeys9
 TKig==
X-Gm-Message-State: AOJu0YwMXndALpMsLQT6hoxLz+8U8YvotIcusNZufS8UZ6Wd1gcLuOIo
 yWl5LGlfz7LSFG8tUmUySnZcLJO1UbmnbYuIy3wQtydqVi5PZXqshLlzF9hQkicJreVVa3/vlX3
 MqjJkJyT4BhTFyztkdm+0IrKVKHm/G3HP790TT9zBZ3hCFEeI7tf3sITank8w5D63Qw==
X-Gm-Gg: AfdE7cndIgtsHUdWn2f5ap/DjnW3NU3Gx7FJc1X/VngbehqeQxp9w+B5kNNs0XVyvTE
 dAmuw+p6fe/XeO9f0VU83bLgNB6xk5TxPKCkfJoFmK9fpuQZY7+xUDlvB+a813+u/1mTHgZD5bf
 71qew2juujqgdxttwAWKQa0O38ttEYxMR8Cthg1CZN6K4YID8SDvBDiWmnBmg+UWfCWWv7LakFs
 LEgDk3sVRMRw7E4BQvfWUC6uA7XynOb7SlmS066riZV6pft57Hsxidkydeu1vvvBJ8O6Zb+TDcn
 t9Jl/eh+7RpdjoqvAFA3Nbx8/cpAO5ntzWFHJyYatHG9dPhSN8jwmN07lX4sXZdvwwQZi5Dqu09
 HuB1YAk3kp+wiSL9d4NhSnaOJsAbIJFMhRqkZ32YBaO4VZkkzUcHOdPxOTroomeit8oxTB3f10F
 4TfAk9mQ==
X-Received: by 2002:a05:6a21:485:b0:3c0:b766:7500 with SMTP id
 adf61e73a8af0-3c0bcc9e9a1mr12244187637.68.1783664788471; 
 Thu, 09 Jul 2026 23:26:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:485:b0:3c0:b766:7500 with SMTP id
 adf61e73a8af0-3c0bcc9e9a1mr12244145637.68.1783664787922; 
 Thu, 09 Jul 2026 23:26:27 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:26:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 78/97] tests/tcg/riscv64: system tests
Date: Thu,  9 Jul 2026 23:19:56 -0700
Message-ID: <20260710062016.1818125-79-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1eeMCqoc7iaTTfwAegNcptizCsner2V3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX+eAy6T1CjmI7
 sHzWuwq/1zffn57iXC6gTx0ggUr2t1Uhf7tRWx1qvFFcFjFM/7EqZsxCBH1JlM2Lc8MPaVFXo6V
 YZt/bF2ntXj4PVPDFEn+PKUpwm9Pj+w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXwTdJ7nzi5kyF
 /GRVYw6MOil0NmksfGC3A+hQZ7dm2AybnKkQpLoI/wzfrTTtxfG1ul0NTX7aNCaZUhGHG4LDRrJ
 XHnVUZTD1/IgF90Kdax0A4XUvA6MSajPhpTDOsnArrT2XnbnDwV25AOdCT0HKpw5fTPXH2ftQHC
 aEAOiXl+V8giYxWMOqn0y3pyGVA9fPP+ysfP4utITFf30OR3FxEFekO74muwky2BopAPuD/zX/v
 9x8SarSWBiUjluqaXNN1zMH7NFAqHb6t/rtxuzA3u/ESSye9Bpu4l/9xQ2copMi/ABeiZkBZ1O2
 XqjwXvu2gcPvPApGHSt/fyN9rWJajkuPr5d8aRLfQ0vZ3USh0Rcl+9EgZmydvD4f8oH221vFf1M
 9SDATHMRnYN/hcJrpNcHvGU/a6jRRXcfeU3HWYlCdsHjpyIgh/yhUkBODWuZxM9Tt4Yshw3JxM6
 Jcpvw/g1PjVP0o9GDkA==
X-Proofpoint-GUID: 1eeMCqoc7iaTTfwAegNcptizCsner2V3
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a509095 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=5OnOcaDEccV2vxpikNEA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/riscv64/meson.build        |  2 ++
 tests/tcg/riscv64/system/meson.build | 38 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 tests/tcg/riscv64/system/meson.build

diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
index b5f574c1377..2292bf8ed1b 100644
--- a/tests/tcg/riscv64/meson.build
+++ b/tests/tcg/riscv64/meson.build
@@ -2,6 +2,8 @@ cc = 'riscv64-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
new file mode 100644
index 00000000000..86ad66db358
--- /dev/null
+++ b/tests/tcg/riscv64/system/meson.build
@@ -0,0 +1,38 @@
+tests = []
+
+# Multi arch tests are not supported
+# tests += tcg_tests['multiarch-softmmu']['tests']
+
+link_script = files('../semihost.ld')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-Wl,-T', link_script]
+qemu_args = ['-M', 'virt',
+             '-display', 'none',
+             '-serial', 'stdio',
+             '-semihosting',
+             '-bios']
+
+setup = {'cflags': cflags, 'qemu_args': qemu_args}
+
+tests += {
+  'doubletrap.S': setup + {'plugin_test': {'plugin': 'discons'}},
+  'interruptedmemory.S': setup + {'plugin_test': {'plugin': 'discons'}},
+  'issue1060.S': setup,
+  'test-mepc-masking.S': setup,
+  'test-crc32.S': setup + {'qemu_args': ['-cpu', 'rv64,xlrbr=true', qemu_args]},
+}
+
+if 'qemu-system-riscv64' in emulators
+  tcg_tests += {
+    'riscv64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'riscv64',
+      'gdb_arch': 'riscv64',
+      'qemu': emulators['qemu-system-riscv64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


