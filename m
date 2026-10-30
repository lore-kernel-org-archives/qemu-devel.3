Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D124F606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nnrCWZ14;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A7gcJYwb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqsK-00018N-Lh; Fri, 30 Oct 2026 13:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqr0-0008SI-8x
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqqx-0008Ji-Q9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu9vQ3057237
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zhd+SswohxoTjYD3Gra5w9RZuzmiiU319kwx5MH/SQM=; b=nnrCWZ14P7P8zZDj
 KVzefXxH+ZvYi3t+emuCWesrFYLp2Zww8tcStVbyUZio5fPypCvErZ92HvE5Pt9c
 uTapih/lWKLp4rL8h8feThLjLqGO43seznnwAcUkJuK3lQoQmGxRiua/fBL5tatR
 e6UBc3qzF++AislGoIOIYQihBAxuXeWZ8l8RN6rqVvlzmS3n7EOiwejwTspo74lj
 5PN8xLCnDwf3JsrSeAv4pYj8/TSL0fraaN8eqao7NyTktqAVAhal6ZxuNUzoqWFi
 fcpjdQZlZaLdpUuHz5Pr71DFpgOzduEZhcPHJIP7yJRqPJ01BmZM0otbfw6fhKH5
 PYGVeQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pcbhe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:20 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7cc10da5ad4so210906137.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383040; x=1793987840; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zhd+SswohxoTjYD3Gra5w9RZuzmiiU319kwx5MH/SQM=;
 b=A7gcJYwbrnTXRIXlFx1bgnNJ7/Vobrtb5rmyWetJPXohCTOWU+pbBwd8NXtr5120Su
 yFggPClZAeY9PhVff5x4/WSZqz59VsQexFzRIp/0rFWB3widBVl9jisiQJVH+cbtYbDa
 Vb15PVpJM30rGtpyLkIahe1eTzJujvSHkwPX4B7EbRe+xHkAAUWK6Ge9Iaxbg9vm9bFq
 fmVEfG/dOiaiP02XrDRohyo+oJHPkNqn3BHfXBdBKOzn8gIOog6eCfQ0v3z50E2nAmQP
 A7WBBtEAaJL9HkykDW6i2tNhxLz8SI8TbHUFsqpl5oCdhqHEH233caVtxksmM9f2pZKK
 UCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383040; x=1793987840;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zhd+SswohxoTjYD3Gra5w9RZuzmiiU319kwx5MH/SQM=;
 b=k28eKrg/nqA669ur16Lf9NW/mYmcTgX44IiGq6yiyxLdSBkdnyIP5QDwYyxP3Yby+h
 v0GLAhdhWMLNwP6EJyVhLkgR0ZB2OGDZ6x59TuECG0EG8wZ0+ns9I+PQPeZU7lbGrFz4
 Z/3kmxDb8EI8/DFrl+620WHJh0wG00Ymgyx8excJncrP9XWFcTJ7QeYWbmoMUbbLXisv
 JnjhQbLa554ueEnrSi0kom9+5HJX0EkZHp0oJI520I6+9UQEl9Pl48zrLkLueNceQhxS
 8pbuQwQVRPttSH9ePsq4ik+GNv408QkTL0uu5dd0aZ1tkMWrv7PjaIYAkoLJsDqyTYK3
 XWSA==
X-Gm-Message-State: AFq9FYIYzU+rmxlDdgjRGu+6hjCjWYW1fBiu6fH+UkFVUob+HQlVpIPt
 RvxvlIYMOFfo25+00bHLiHFJSyxNpKovCuDV6IefebB5gsuVUpuRnwF1iD5DTBVfPCZ8ayyTcUf
 qX9al+Kylj1uSCmL9dnhktq8ZzxfrRlcDhVn+1mJljMImWZgTDlSNGSviHpeMxqvhLYGr
X-Gm-Gg: AYBFou2rqIM2TLjQR/beztWUdS0LlYkfsRNrjvEmfslnOB8ujiRN0i+88F65cOqgiE3
 DXqaqOj/zSu5LEMTUI/I0vvfdIaOlWWW0Kq4oDCP205eBMD2y8SqyDoZGXV8drfLV4U4Irnz0zc
 wPNDVFiU1jmyqM99rYcR1eI2U9CPZn37XXvP91uQ1flJ2IyvI1RmiWbTCYf8PQRUph/kkVNO+97
 pw+qTeU0ny2waywZnZ5+MzeYO8H/reNN5m0BXxKTGzJkk+6yh98257yEt0QDGin6tepxb2xV5x2
 yOkkVS13m6BAcoye3mI2C2TuOEtUv9CqbteG9HrtiwFlbrr0/tUPaVzD8RcFqBnzfZQm+IZDzS+
 BUWa1qtPgJQcRocxOUXjR4Rsxc8c1goRdA40JA+p+5ZkD2v4bibfq8c1AW35ded5O76w9vlLFea
 O67CfxRXzdoglVJGmCJC0KXvPT6LhMfQ==
X-Received: by 2002:a05:6102:6c4:b0:7ce:78f9:adfe with SMTP id
 ada2fe7eead31-7d072c17d00mr1575869137.18.1793383039730; 
 Fri, 30 Oct 2026 10:57:19 -0700 (PDT)
X-Received: by 2002:a05:6102:6c4:b0:7ce:78f9:adfe with SMTP id
 ada2fe7eead31-7d072c17d00mr1575856137.18.1793383039261; 
 Fri, 30 Oct 2026 10:57:19 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d511sm4423576f8f.8.2026.10.30.10.57.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:57:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 24/32] tests/tcg/mips: Group MSA int-dot-product tests
Date: Fri, 30 Oct 2026 18:53:46 +0100
Message-ID: <20261030175357.99684-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX6CaeoGxe9Xkb
 BKVvQ66jmJNvTlIhu5sYowpcGDdOyY8JooIHX27CQ77PGx2577+uqlxT7kAykOQPJQaSlxm4TRg
 WhZ+hseZS2hPSKgYjAgkQ3PVoVhwUkvQ/rmFAsaaS40XCbNiKjq6WceapwQos9XFk8rEhrvwjwF
 LGH/cOTeV+rhI8oAzEXNHzCEvoa9JMngTaQXZvnhD8QwYjy5nZRK6HMfnIjm+XrfLobinKdeqLe
 JE5gVJK08YmwP50Z4q3biUfVXRL+soYbZRSFi9SZK3SCGoouEfZK8qUJnwa9BdW3h1QRSJkKKYo
 EbjlBPk785hl6ramIDQGS2ta1fxRH1hUrTeTcbCiobJKkkINVj6UrJUV/tyc7Xm3opjXAZuCdL1
 70HqMsySOHHJovXFEK2yaaDVTI6n2otXIANn/vyxMSUl8foowrDrdB1VamRNJ0JZgvByHTY/wMQ
 W3rjrqUsyWV/fBPLTPA==
X-Proofpoint-GUID: 1PGwlkFEWrfMHjbHvKLEcVQubXOz2YEh
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae4da80 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VhQGtWI-d0xSCWyjZuUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: 1PGwlkFEWrfMHjbHvKLEcVQubXOz2YEh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXzvlbJ0UGzE4k
 Nxw+SfodY926MrEmTVF7ETMawyFvYdwBfjvN1c9gPgxd/EKG8PX+ZyhNrtPj5gZtmJS4GZ6vG4e
 zd/SMMplLpLWiZ3cpcu7xMyYok3hTls=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Build the 18 per-opcode int-dot-product tests as a single executable,
test_msa_int_dot_product.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_dot_product.c | 135 ++++++++++++++++++++++
 tests/tcg/mips/meson.build                |  19 +--
 2 files changed, 136 insertions(+), 18 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_dot_product.c

diff --git a/tests/tcg/mips/test_msa_int_dot_product.c b/tests/tcg/mips/test_msa_int_dot_product.c
new file mode 100644
index 000000000000..fcbd414741b9
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_dot_product.c
@@ -0,0 +1,135 @@
+/*
+ * MIPS MSA tests: Int Dot Product instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_dotp_s_d
+#include "user/ase/msa/int-dot-product/test_msa_dotp_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_s_h
+#include "user/ase/msa/int-dot-product/test_msa_dotp_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_s_w
+#include "user/ase/msa/int-dot-product/test_msa_dotp_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_u_d
+#include "user/ase/msa/int-dot-product/test_msa_dotp_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_u_h
+#include "user/ase/msa/int-dot-product/test_msa_dotp_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dotp_u_w
+#include "user/ase/msa/int-dot-product/test_msa_dotp_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_s_d
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_s_h
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_s_w
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_u_d
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_u_h
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpadd_u_w
+#include "user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_s_d
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_s_h
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_s_w
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_u_d
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_u_h
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_dpsub_u_w
+#include "user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "dotp.s.d", test_msa_dotp_s_d },
+    { "dotp.s.h", test_msa_dotp_s_h },
+    { "dotp.s.w", test_msa_dotp_s_w },
+    { "dotp.u.d", test_msa_dotp_u_d },
+    { "dotp.u.h", test_msa_dotp_u_h },
+    { "dotp.u.w", test_msa_dotp_u_w },
+    { "dpadd.s.d", test_msa_dpadd_s_d },
+    { "dpadd.s.h", test_msa_dpadd_s_h },
+    { "dpadd.s.w", test_msa_dpadd_s_w },
+    { "dpadd.u.d", test_msa_dpadd_u_d },
+    { "dpadd.u.h", test_msa_dpadd_u_h },
+    { "dpadd.u.w", test_msa_dpadd_u_w },
+    { "dpsub.s.d", test_msa_dpsub_s_d },
+    { "dpsub.s.h", test_msa_dpsub_s_h },
+    { "dpsub.s.w", test_msa_dpsub_s_w },
+    { "dpsub.u.d", test_msa_dpsub_u_d },
+    { "dpsub.u.h", test_msa_dpsub_u_h },
+    { "dpsub.u.w", test_msa_dpsub_u_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Dot Product", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 537de9ea4a2f..2d2dc60789b9 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -11,6 +11,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_average.c',
   '../mips/test_msa_int_compare.c',
   '../mips/test_msa_int_div_mod.c',
+  '../mips/test_msa_int_dot_product.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -159,22 +160,4 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c',
   '../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c',
   '../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c',
-  '../mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c',
 ]
-- 
2.55.0


