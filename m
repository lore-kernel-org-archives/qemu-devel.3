Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864AD60A2612
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FttOhTpa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D9J4f1m4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqsO-0001IT-7r; Fri, 30 Oct 2026 13:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqqq-0008Nh-8A
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqqn-0008JH-TI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu28a4025492
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6RyVs3nUetjaaD9VgdwFw8WA7SXZIHT2DbGgv6Jstn0=; b=FttOhTpaMOAfrzaE
 0Pe7ngUGY16g7wcRbiT+uXB6Uui2Zgu+dRC/qzg5vhNcdoQhkMZGoA8B7tTkd0/P
 CuJ6GnWh7V3sUs3yeZzZaG39MNO6TfKIP+LyXalkBgCEIjdVrTc+mzNYKq4uJRDb
 m+IEItZ5Z2Rd7tdTwfWRwHTlodxITL+ii4YUC414WBS73iMUgsnF4l4ppagIvIFJ
 HnSxY5SGLrvg68/vZLULOhF5wyIYQNbGzGFnMDnLncvpDdWRnNL00AvPpiZyKY5M
 2kMaOc4M433ia3ImuymcT8+7kEUuTFgJBZjt0XrlXDcJp8uHGwHZGMip1TnCiplW
 Hn1yCg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm9gg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:12 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7cc23a549a9so697904137.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383031; x=1793987831; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6RyVs3nUetjaaD9VgdwFw8WA7SXZIHT2DbGgv6Jstn0=;
 b=D9J4f1m4+3g6NzNzie1a0JBIjtUB6aEAzhGP/scLU8xe7/Ba34/wMsdwQFeI5fsBr2
 3tmlawcAQ6c/rMoSZCjGIPkyn8aL3cZV3hQlitKIl1m48NvFcON1KKHs3xPK76/nYoZI
 TySo02MPdl8wQJvAda197OUkQd9hvjbKYc1uWOH8wpD5hUnN859ewilCowiEGdDAMFHK
 4cOMLOJob8wPcoyoNcYSKKjat3ahrG6hJ3M7QTw611IpUBJtcCZlSp1FvKZx5WOMSg0u
 BMjTfXVdxDxBNbe87cpbOGki1mvFSRcYfJrXpuu3bgK5kvpcI9I3mBvTdqlMDJUu7IQl
 2txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383031; x=1793987831;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6RyVs3nUetjaaD9VgdwFw8WA7SXZIHT2DbGgv6Jstn0=;
 b=fob0sQ8wBLQ27mFjshpYt1pTZR1d76+KCIO3COrEFBIu4DOLpKmstON2qGcs6PF1wi
 mMHvIr0BVAf9H08iTteSomyq9jV18W5NQXecUpvU6jEJkU+KY7wFRErzXgYHIrwZgfw6
 ksa0NdgAhbl8qxKdvYFB+dwgOqtmRhsgDrzBAwN5i+dfvsXzZHW7q9bcaTdq1NHuRIzi
 eZibXdgJTcM0s5p88VimJ8K0ZQNrZTaqrIdaB1KM9Qv3nxc1W8GBDUIhR3EJYh0gO1KX
 OxlxYzCxek7r6SPBPnWunvZiKS4KBYTm08rhZjmDPugbEobDnHjcivBG5/IPXJyw+mUI
 kAtw==
X-Gm-Message-State: AFq9FYJMLx3xB80fgZU5gFWxuxAoClUdwXUOgJlEUO8Z+U41Pxz7Pb09
 6xfy0TOT06Ja3mXBo7cjnHuZ2dTrPVq3+A9I6+c1lUJol3lmqwk1gZOJ40SzFTjM5+KarbZC8d7
 iNCcMyc027Sk16h+XU3U724R0SSuIV9Me2r08pRYdyqEw0CF52m59WdFXJKaTO7+zQ/e3
X-Gm-Gg: AYBFou0ZkigMp5MFzEmTe2pp+fGQzYaigfrAumu5JtfLonXEgwl1xmPNe7+iZXfxe6B
 3b//DZWtSbC9IMW5dbBWZryucdrgXWWmZwGRtASJ6qeqOgAk16jc2uqfTzMTw1U8rC2YyN79UeY
 hy9W3dm628GdAAkxuf+FGydRF79O/zCX87SslyXm/r6hNKShxFS1C+VJd8/SnW/8UdmxwhWmD9L
 r3KpcNMJxzHzNfHHUCI9YTbF7bIiE7nvzU9r3LyjHkE9YNseG7A+tv4Z++Y422QYFqw+eKcf639
 AMepuZFU8fAhWUbyZz2b22sCZ/eM2Sys7Q7QLGT8qGosEtZHKX8GZGU/bS8kgDhZnCksJQHdcAH
 OabNJ7U6FHOfVOkJgft8EnQjZhlHpgRS69/VFz84rqJeVFcTh5AUqKmzeS/8t8reOWnJ07n177n
 BI+UqrtWolVuGTm5nNWPYlRMP87z+pJQ==
X-Received: by 2002:a05:6102:2b85:b0:79e:373e:8216 with SMTP id
 ada2fe7eead31-7d0723d2480mr1755027137.0.1793383031555; 
 Fri, 30 Oct 2026 10:57:11 -0700 (PDT)
X-Received: by 2002:a05:6102:2b85:b0:79e:373e:8216 with SMTP id
 ada2fe7eead31-7d0723d2480mr1755018137.0.1793383031150; 
 Fri, 30 Oct 2026 10:57:11 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b789c6sm4821765f8f.26.2026.10.30.10.57.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:57:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 23/32] tests/tcg/mips: Group MSA int-div-mod tests
Date: Fri, 30 Oct 2026 18:53:45 +0100
Message-ID: <20261030175357.99684-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o7IUdLTNs24QJakvOzLj1x-BxSMs7hOd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX655IgkFRVUoo
 HivHPUWnAXeDswvBc14c37I3ihXi8cNhee6pd5QNekydjT8Lrf1AshwIKECFf3J80Zf9Z4mgcNe
 9ys/n6m7OPSPIL+BtkXoflxByDQrW/o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX2sngw8cM8b2v
 5qt+aI9VRZhGF0prNCwxqtAyJmsSkVQsMIAv+7BzCYW9Qr1ffupAmVwN0ywhDhS01V+65FQqVs2
 VhgQbsvD11QsE/MZnR7PjpsXLqm25O9Qln/Nw5EDl6wMXQTDoz0oc0Z98krlmwVqJ8z1ZmSkjbi
 6ApKd3nLcTx+Ut9CSQURiUry2IxfmgYiDNld2j6uqqJvVc74QxY2w5pR2PGs4x1rz/Kub63ewqG
 JJd5pyv/tTu9PnGKdqxcWv5SqHKjDN2YZk6CcErkTB7LlPMP1MMEQzn9X38vIKMpjhY9x4/MsYd
 EfzMs2UHGyhfkGAxWZ5rdahdxCTN+iNNPpC57ac/ZecMa4UYw0T2lUuQdvdMlbSQM/gA1FYglqX
 hjTODrOT6vgwkyJlCjuAiHTcEPY9tvbXWt137W0zT7d9imLdqm2I2l6oGzEPPd/0V4Fvlwusc3Y
 1KuhG/V2BfqttPWCmdg==
X-Proofpoint-ORIG-GUID: o7IUdLTNs24QJakvOzLj1x-BxSMs7hOd
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae4da78 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=XlFCZ7tVMrZGAbOMMLgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Build the 16 per-opcode int-div-mod tests as a single executable,
test_msa_int_div_mod.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_div_mod.c | 123 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build            |  17 +---
 2 files changed, 124 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_div_mod.c

diff --git a/tests/tcg/mips/test_msa_int_div_mod.c b/tests/tcg/mips/test_msa_int_div_mod.c
new file mode 100644
index 000000000000..764054c2a57f
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_div_mod.c
@@ -0,0 +1,123 @@
+/*
+ * MIPS MSA tests: Int Divide and Modulo instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_div_s_b
+#include "user/ase/msa/int-divide/test_msa_div_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_s_d
+#include "user/ase/msa/int-divide/test_msa_div_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_s_h
+#include "user/ase/msa/int-divide/test_msa_div_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_s_w
+#include "user/ase/msa/int-divide/test_msa_div_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_b
+#include "user/ase/msa/int-divide/test_msa_div_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_d
+#include "user/ase/msa/int-divide/test_msa_div_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_h
+#include "user/ase/msa/int-divide/test_msa_div_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_div_u_w
+#include "user/ase/msa/int-divide/test_msa_div_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_b
+#include "user/ase/msa/int-modulo/test_msa_mod_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_d
+#include "user/ase/msa/int-modulo/test_msa_mod_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_h
+#include "user/ase/msa/int-modulo/test_msa_mod_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_s_w
+#include "user/ase/msa/int-modulo/test_msa_mod_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_b
+#include "user/ase/msa/int-modulo/test_msa_mod_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_d
+#include "user/ase/msa/int-modulo/test_msa_mod_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_h
+#include "user/ase/msa/int-modulo/test_msa_mod_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_mod_u_w
+#include "user/ase/msa/int-modulo/test_msa_mod_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "div.s.b", test_msa_div_s_b },
+    { "div.s.d", test_msa_div_s_d },
+    { "div.s.h", test_msa_div_s_h },
+    { "div.s.w", test_msa_div_s_w },
+    { "div.u.b", test_msa_div_u_b },
+    { "div.u.d", test_msa_div_u_d },
+    { "div.u.h", test_msa_div_u_h },
+    { "div.u.w", test_msa_div_u_w },
+    { "mod.s.b", test_msa_mod_s_b },
+    { "mod.s.d", test_msa_mod_s_d },
+    { "mod.s.h", test_msa_mod_s_h },
+    { "mod.s.w", test_msa_mod_s_w },
+    { "mod.u.b", test_msa_mod_u_b },
+    { "mod.u.d", test_msa_mod_u_d },
+    { "mod.u.h", test_msa_mod_u_h },
+    { "mod.u.w", test_msa_mod_u_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Divide and Modulo", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 199b1b934a5e..537de9ea4a2f 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -10,6 +10,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_add.c',
   '../mips/test_msa_int_average.c',
   '../mips/test_msa_int_compare.c',
+  '../mips/test_msa_int_div_mod.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -35,14 +36,6 @@ if 'qemu-mips' in emulators
 endif
 
 tests_mips_msa = [
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c',
-  '../mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c',
   '../mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c',
   '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c',
   '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c',
@@ -89,14 +82,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-multiply/test_msa_mulv_h.c',
   '../mips/user/ase/msa/int-multiply/test_msa_mulv_d.c',
   '../mips/user/ase/msa/int-multiply/test_msa_maddv_h.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_b.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_b.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_d.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_h.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_s_w.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
-  '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
-- 
2.55.0


