Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D08606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V4GMrkYt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JzndpGNF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTuD-0001ZX-Oo; Thu, 29 Oct 2026 13:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTu5-0001Cd-UB
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:27:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTu3-0001bW-PQ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:27:05 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDIY11654926
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gOoaG/Ufm3nfvKL/zUgM2uy5Um2xQ3o/2NlAl2edL9g=; b=V4GMrkYty6o6kpe0
 9W+ag51heSqUbMTgnXEhbmZo0Lmn1XQa80fu0MPBtB9IeqxGRS+DR7MCztqoIhK/
 igdl8w6chxSmPwxvboycOtHtGpuc/QWldzkYgocJ4Lpqu/nh3Qd7f3X5jSfM5KqY
 Va6/MOGDPp3JzBhBy34A8O3g14016WU7KiDlErXqninonISSS68Tp9yRr4TpaqnY
 bakb7wal3yRSlDANIV9PGo5OGZmuZ+7OPcK7xCxeKF43vsPcIGT4HmXvBMlU+6Fs
 dCK9JHDQimPi4Km+tl31IylyTe3TiO8o4ZkMvSUl1aJ/AOtBrxWoQEsWI64tL3pT
 qutiJA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a21sum-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:27:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f20addba1so430870185a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294821; x=1793899621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gOoaG/Ufm3nfvKL/zUgM2uy5Um2xQ3o/2NlAl2edL9g=;
 b=JzndpGNFGnVaWK3bCYZjJaL/ndTIYmfL4CYtVMFcIZwoaWekmhdpLGJ2G3hxbocOmt
 23yRnSJzxwr1xGClY3w4JeISJURP7+DFWX3EnKnO+r0XsqlEN7XN7ECT66m++CGkkvSJ
 NH9L5OW0wMWWTdh1Nqk9hWe/08KrPS02Lxo9FL1HC0f8hbzElxuwr7J418Q4VIffFSIB
 WaMslDPgzHEIaGz2Rk6RCeV3rGe/SOdyOdPQuzAcoFcrOuKT6DVbqZo1pIiLzA2RNhyU
 iJK4jcd3zGdiql1/FgE9Tb8YCoyfbnY4HZdLhnYGIHnZjCX25gjQ8iRaj0uX9gDn5DAA
 EPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294821; x=1793899621;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gOoaG/Ufm3nfvKL/zUgM2uy5Um2xQ3o/2NlAl2edL9g=;
 b=s3Jvdx0p4NoC5KJDOzdh208ZDrtu3DvEXfoaMJZ6YcZuVVeUBFtHv5/lJc252YuWAN
 TTiBy5ILnCO/dJ5pyZHNTE4cxcG8Hag70EmZql4sF6AvWJzrndWE3Ztvsxri9e/M91vx
 jokU8iXAdrcmyIMUKM8CtpaF2TyfaV0cs1bYHJ99qTQx6q7BddMP9Dak6BPoBQgllsp/
 /fCkhzi6OD3uTbyzYcpeC8BIuwJngIzNr9O2YkNyk+UtV8oba0VGwol6BRwgT2+G/9PO
 E+srPGtHzl+oF8Eqh1QhQ4Q1CAVEBl8NDW3T7VrAXPR3yQ9+izUUyFt3qCrYj7K6737Z
 DSFQ==
X-Gm-Message-State: AFq9FYJNv2oo1WUbkEeFGSV9WC0yKFx9kf0+ggGVetsMS07oAKULTyFD
 KoXuA98pq44g9sk9YYy6FFHPpq3L7ADAFWghPHGzivetEPYETEvQI4Xa58p/2lDsMgTwkRhkRoL
 tMHr0FMahoFajZ69IorK9IQxQuO6jFg5eMdSJwi91m0KhRD5xoF4GM5VHZQs+hKtZx+Tw
X-Gm-Gg: AYBFou1bBP063EiuiPe+9qo7n6R/cLIVbQ+D2JOdqeBYrfzgsCWUZTshqiAKl/i9K1F
 XRbTGB93SSdoGgudQQJO/PbPz7Bn7OVIWnzo7yiFuMQXFmN/nqaxEDxgsGgvKhqa4+xG7uzhS/j
 ztXQM2itJ8xUrUt0oegnW5xBYD9GuzwX2FS4jzDpqZX35fuJ1n056pdpF0Jp3vd2mT63Vh95NM+
 YF7d00qyHSq/lIrODDFwn1w5YJYgP576YUgvJmrwuSh1Dxw0uOuQln5hnwF98qYby6DPY2/Gc6d
 09f631bmgA1T5d038dRFus6X92Z0jbuChP1ufXpmkRXy1SgaBkFUQBytk45rUd6J1a0znWJL5St
 40dTK/RGgzKVhi/9nwRcOA4CPrl9xosZGVEOCU9kb7YHvL6sGa/2sNX091LKdEWXbSrZ35VtiMb
 bvU+1sfKUQVppz3C8btwcCqRwGoDwhaQ==
X-Received: by 2002:a05:620a:1d03:b0:943:faab:aabe with SMTP id
 af79cd13be357-94408d43a71mr867837985a.62.1793294820677; 
 Thu, 29 Oct 2026 10:27:00 -0700 (PDT)
X-Received: by 2002:a05:620a:1d03:b0:943:faab:aabe with SMTP id
 af79cd13be357-94408d43a71mr867835085a.62.1793294820259; 
 Thu, 29 Oct 2026 10:27:00 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f047bfsm79699045e9.3.2026.10.29.10.26.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:26:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 30/31] tests/tcg/mips: Group MSA shift tests
Date: Thu, 29 Oct 2026 18:23:14 +0100
Message-ID: <20261029172319.25766-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXwkjKSy9x+UKz
 iCSlQetHwYzhrtQvTsoCjVUUKCFixbKycK8lUD2eEeABOmIGCDycdby15P94uWTmMlQXmSbeQfd
 Sc+Jyu1f+Flu2gs0ibY7d470BilEjckjiOWZQrmexO0mkZ1l0eQOcaiNWIkzTS+FYbogX4oeepI
 ylq/CGNLKQlQX7W4nIp+oB0XbgWjQ+fTCeyNWHPDagAmjL7XEQ1b4qOJQV4zBcNiABwQbGQ+9YN
 PWNdGEL19TMqcXdRQDhrQFJHY5fP+dEVtzv9MdxSlTT+JYMIbPfqxzpReG9L0JOoDjO67oSkRfH
 Uu7kRuXOnpMihXSKNby4zxoh7lv4b64lxuBZdBGnHuWa3cdvHyLOg/SMvg+uCaS/rvDAckIMVzI
 zJit9JSqMeNAx2G+X+EAcIBVH8uDv5LNNuSHtsYp0Flb2GnTGJhTbVgHyPtaSXAp7ssmG4TZ4ne
 Ag36rRYPQ9KdGDlRXhw==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae381e5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=4pOn1ErT82C8PKv0Oc8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX8hlhC9LV4lYs
 uE5kXvAf7lAn4NQ2CGw7cGAkC2zO5AlY+58cK3Z0QPhtqIOYDWJR2PZCriz2fr+OD5lkM37ZzBa
 js7oM1mLWiTFRG4nPhWSZd9TyzS05qM=
X-Proofpoint-ORIG-GUID: 4jXKJMtK_DZaj3Azxrs4NjlKcunjZtN6
X-Proofpoint-GUID: 4jXKJMtK_DZaj3Azxrs4NjlKcunjZtN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the 20 per-opcode shift tests as a single executable,
test_msa_shift.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

All MSA tests now emit TAP: select it in the meson setup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_shift.c | 151 ++++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build      |  23 -----
 tests/tcg/mips64/meson.build    |   4 +-
 tests/tcg/mipsel/meson.build    |   4 +-
 4 files changed, 157 insertions(+), 25 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_shift.c

diff --git a/tests/tcg/mips/test_msa_shift.c b/tests/tcg/mips/test_msa_shift.c
new file mode 100644
index 000000000000..22855472f068
--- /dev/null
+++ b/tests/tcg/mips/test_msa_shift.c
@@ -0,0 +1,151 @@
+/*
+ * MIPS MSA tests: Shift instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_sll_b
+#include "user/ase/msa/shift/test_msa_sll_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sll_d
+#include "user/ase/msa/shift/test_msa_sll_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sll_h
+#include "user/ase/msa/shift/test_msa_sll_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sll_w
+#include "user/ase/msa/shift/test_msa_sll_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sra_b
+#include "user/ase/msa/shift/test_msa_sra_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sra_d
+#include "user/ase/msa/shift/test_msa_sra_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sra_h
+#include "user/ase/msa/shift/test_msa_sra_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_sra_w
+#include "user/ase/msa/shift/test_msa_sra_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srar_b
+#include "user/ase/msa/shift/test_msa_srar_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srar_d
+#include "user/ase/msa/shift/test_msa_srar_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srar_h
+#include "user/ase/msa/shift/test_msa_srar_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srar_w
+#include "user/ase/msa/shift/test_msa_srar_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srl_b
+#include "user/ase/msa/shift/test_msa_srl_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srl_d
+#include "user/ase/msa/shift/test_msa_srl_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srl_h
+#include "user/ase/msa/shift/test_msa_srl_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srl_w
+#include "user/ase/msa/shift/test_msa_srl_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srlr_b
+#include "user/ase/msa/shift/test_msa_srlr_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srlr_d
+#include "user/ase/msa/shift/test_msa_srlr_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srlr_h
+#include "user/ase/msa/shift/test_msa_srlr_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_srlr_w
+#include "user/ase/msa/shift/test_msa_srlr_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "sll.b", test_msa_sll_b },
+    { "sll.d", test_msa_sll_d },
+    { "sll.h", test_msa_sll_h },
+    { "sll.w", test_msa_sll_w },
+    { "sra.b", test_msa_sra_b },
+    { "sra.d", test_msa_sra_d },
+    { "sra.h", test_msa_sra_h },
+    { "sra.w", test_msa_sra_w },
+    { "srar.b", test_msa_srar_b },
+    { "srar.d", test_msa_srar_d },
+    { "srar.h", test_msa_srar_h },
+    { "srar.w", test_msa_srar_w },
+    { "srl.b", test_msa_srl_b },
+    { "srl.d", test_msa_srl_d },
+    { "srl.h", test_msa_srl_h },
+    { "srl.w", test_msa_srl_w },
+    { "srlr.b", test_msa_srlr_b },
+    { "srlr.d", test_msa_srlr_d },
+    { "srlr.h", test_msa_srlr_h },
+    { "srlr.w", test_msa_srlr_w },
+};
+
+int main(void)
+{
+    int fail = 0;
+    unsigned i;
+
+    printf("TAP version 14\n"
+           "1..%u\n",
+           (unsigned)(sizeof(msa_tests) / sizeof(msa_tests[0])));
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        int r = msa_tests[i].fn();
+
+        printf("%s %u - MSA %s %s\n", r ? "not ok" : "ok", i + 1,
+               "Shift", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 791ac5109607..feebcc30d6a9 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -21,26 +21,3 @@ if 'qemu-mips' in emulators
     }
   }
 endif
-
-tests_mips_msa = [
-  '../mips/user/ase/msa/shift/test_msa_sra_d.c',
-  '../mips/user/ase/msa/shift/test_msa_srl_b.c',
-  '../mips/user/ase/msa/shift/test_msa_srl_d.c',
-  '../mips/user/ase/msa/shift/test_msa_sll_b.c',
-  '../mips/user/ase/msa/shift/test_msa_sra_w.c',
-  '../mips/user/ase/msa/shift/test_msa_sra_h.c',
-  '../mips/user/ase/msa/shift/test_msa_srar_h.c',
-  '../mips/user/ase/msa/shift/test_msa_srlr_h.c',
-  '../mips/user/ase/msa/shift/test_msa_srl_h.c',
-  '../mips/user/ase/msa/shift/test_msa_sll_d.c',
-  '../mips/user/ase/msa/shift/test_msa_srl_w.c',
-  '../mips/user/ase/msa/shift/test_msa_srar_b.c',
-  '../mips/user/ase/msa/shift/test_msa_sll_w.c',
-  '../mips/user/ase/msa/shift/test_msa_sra_b.c',
-  '../mips/user/ase/msa/shift/test_msa_sll_h.c',
-  '../mips/user/ase/msa/shift/test_msa_srar_d.c',
-  '../mips/user/ase/msa/shift/test_msa_srlr_d.c',
-  '../mips/user/ase/msa/shift/test_msa_srar_w.c',
-  '../mips/user/ase/msa/shift/test_msa_srlr_b.c',
-  '../mips/user/ase/msa/shift/test_msa_srlr_w.c',
-]
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index f18ff8153f2d..d1d4bf6b5a24 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -56,13 +56,15 @@ tests_mips_msa_groups = [
   '../mips/test_msa_interleave.c',
   '../mips/test_msa_logic.c',
   '../mips/test_msa_pack.c',
+  '../mips/test_msa_shift.c',
 ]
 
-foreach src: tests_mips_msa + tests_mips_msa_groups
+foreach src: tests_mips_msa_groups
   tests += {
     src: {
       'cflags': ['-march=mips64r6', '-mmsa'],
       'qemu_args': ['-cpu', 'I6400'],
+      'protocol': 'tap',
     }
   }
 endforeach
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 277ece3e306a..fcf764ea8df6 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -57,14 +57,16 @@ tests_mips_msa_groups = [
   '../mips/test_msa_interleave.c',
   '../mips/test_msa_logic.c',
   '../mips/test_msa_pack.c',
+  '../mips/test_msa_shift.c',
 ]
 
-foreach src: tests_mips_msa + tests_mips_msa_groups
+foreach src: tests_mips_msa_groups
   tests += {
     src: {
       'cflags': ['-mabi=32', '-march=mips32r5', '-mmsa', '-mno-odd-spreg',
                  '-mfp64', '-mnan=2008'],
       'qemu_args': ['-cpu', 'P5600'],
+      'protocol': 'tap',
     }
   }
 endforeach
-- 
2.55.0


