Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5157CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDki-0005cs-RJ; Mon, 15 Jun 2026 16:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZDkW-0005bj-O1
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:17:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZDkU-0005OC-AG
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:17:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIx6wl881931
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YAwYqo4j2xI
 o0+uzt02mpKpdCk7XeWb7OVcHyuzMJGE=; b=NNoED55yJ+UjnyDOwph5Np///zp
 PiHMdKEXTwVE1irIfkHJfnD5yMuCwgcZaWyncgleCiLiZwsOg7wvRdAcYrqsF/mW
 qvI19uIAMWOrqYyjsO4yZ12TNtT1Z2LTfYtPjDxswfO5ZYTQQ9SoqF3Jv8GgX/lp
 mc3c3y5FcnE5uLW8n6Vr+m/gPCa0Uc90C30ZfpjKY825WQkzNDAm63/FD7iGG6aD
 H7RtzVqNJE/V9n6UeT0yN3sGyr7KWqDDHgtGzRKdLGS/FYHwmp+dlpgg7tkzRXBK
 CdNJaIaPfTlwypGJXpjwCVFHNwhoqEgGI8yVlpW1GrBmTys3JeIg5AsYTiA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0juaf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:17:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304f23c55b2so4763732eec.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781554652; x=1782159452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAwYqo4j2xIo0+uzt02mpKpdCk7XeWb7OVcHyuzMJGE=;
 b=A9vn8vax/X21+EmvEpJJ/J4LugY37rHSdYFlnG5XY7SZQs+5lkSlzYHRWEWt4uttCH
 7AJv4s5YF56AjvHrd0cXjVGKjeCVUNv6KCIx7wMlapBzr1b+PfHz3CqqjEw8wDRSxVF6
 njNMBf66z8D55cONfWaTiumiLImjGfrpYQXN+OrlXn7AQVwM4sWPqM6PN+L6KaLKAb1J
 lUGxYohUdP44GXJP8g8ieynUVzLKY3LShzSiawBdbOFSrh4UnMye76Tg6Sytl9MKJh8X
 KfPcsaLZOlYbuJqayYT/0Ba6OhjOC3lj/mStWyCQKt3vFfZP+lKEXTqSXKNZo6BHekA3
 Dmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781554652; x=1782159452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YAwYqo4j2xIo0+uzt02mpKpdCk7XeWb7OVcHyuzMJGE=;
 b=pFUYu+tRQfHNKCCOCYeEJIz1aWlDmHGvhtj0GlONNcKXbD0zu9+LmyA6Iu7S2hr40G
 jxl4WdekQIgLqBn/L7RyapRaZzQMyDPAnNXK/W1IvBdR2U6rkvAUT/n8kF2tT+mWe1Ku
 dVkF61No4ZDK/s0DbfJfGjCldUi8u8bEHQqWXGmWY5lSj33OWm6NWcTUp47zOpa55IaS
 ggrF/xj+PWGixjMack45aeAHCIADa82PFOlR3B1yskU/Bvb9xoQDdypgAIO0m1l5leul
 fnHl4rCDaVIZ04bhDCMq/xTxa5NzqgnHDtYP0ldo2I/WqMYWmWG7slvcMdDTcwKV63Ea
 UD3Q==
X-Gm-Message-State: AOJu0Yxtm0whRglkOv/r5rjX5bD1FR0U6Pp1AXhTMxUEn84M3KYsFIsl
 AyDAAkqkN0dGqsUtezm26QXttJRpRiyyyEVphVrkJttLOvP6EmYzJ9ey6VnqhZt9H1VsKnVuato
 LFQQrq+e8VXP/quzUolIQ0QG7oGau3hbOCqwiYvajBVhgWe0V40pw+TlVX+BkgxXBvGgV
X-Gm-Gg: Acq92OEyRxIjcdNTb9Yp21KguNkxlYu3LEnVu9DFiuK9j19VcH5rvNczWvGR1jrfVxL
 FOBrFAvxp81gRIDneyXrdhOdS71i7bprVUblfIWdQOmfTVeDT8jMy5I9s3F2+QyFK0ulM3UBUFB
 065xd0vDN/cuk1XwOgwxU8+mCElgWF+q3pJsUPhvfnuMiDxQwxHwC7d9pEbPF6njc2ph3tn3ANV
 Ov8TmLZs/McDtGfR58pHeGSDqC8VLOptZCt4jdKK4xyfsmkMbR8tHbIIbSDKbz3zNaUD1c/TzFm
 Tqj2ARDD5IKPyKAbfRbbtQ7DcRy9hmgegZ9lubt2PCAUqK/pYxvNzj5d/GgmTZj7odzQ0TW69pn
 gXpfCrAE2DGFm0DmhDL+3km11J3SIEqc5EXrgiUK//1oyWC92HQxOet5q+WIbUOoVllCeckijGi
 6tSt+0hA==
X-Received: by 2002:a05:7300:e421:b0:303:f2fc:c483 with SMTP id
 5a478bee46e88-30ba596ba48mr463713eec.1.1781554652203; 
 Mon, 15 Jun 2026 13:17:32 -0700 (PDT)
X-Received: by 2002:a05:7300:e421:b0:303:f2fc:c483 with SMTP id
 5a478bee46e88-30ba596ba48mr463697eec.1.1781554651712; 
 Mon, 15 Jun 2026 13:17:31 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d810fsm16435237eec.12.2026.06.15.13.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:17:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@oss.qualcomm.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/2] meson.build: check MAINTAINERS file is consistent with
 source tree
Date: Mon, 15 Jun 2026 13:17:23 -0700
Message-ID: <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxNCBTYWx0ZWRfXxKpoyINW4T44
 VxZj3YZPaulRY8Q9boYfbXd8bqmIeBt2lWfQH0EJBb1Fm5F79QSee9nCn+nJfJWKQl0eAQJny8F
 wVBaDnvkMYzCM49JPZmNrC4jPpVPofc=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a305ddc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Ikd_lo372LEE3i8avE8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxNCBTYWx0ZWRfX4OB/FD0hSFoc
 zuJpl1jBgpYYuldoHYKpTes3yJf2bWpEh7tyzqce1cvIxXEvMEferoEUw2zhGvSPAK+K4Gbpz+O
 tgX6RqN9wdKQeH1TV4OO4bWMP+AFFC0OO7TpGsjOG350/OG8mA35HLLmc6fQWqhqjFXFvig4/9Y
 24iAHh8ecAZ4AuH3kq3h67L1qmrC0gOgVkAAfPo40NdB2VpYoplr4n/DHevG9DHM4CYJxvrcQY0
 rkWj+myPJV8rqU+gCjoOz0MEQoKnq+RVUDi5v9ZzMVtVXCJHWCBME58MvkMnALdldPZ9Ac2NKDA
 OoRal39BanP8GtMv1C2CrXzildmR+ojC+u9bx99ZDDqIjBGa//FTq64ikv5nF9pRsMSp0tK8pqK
 uXjw6kp2SgmAqayAUL1snzSFqchFLng/XV4JTbVpY4p8mvIK1qPYPROGrsqtsjeT6Sxh9hmIKkK
 JUbEOtGM9cUpk+u2YQQ==
X-Proofpoint-GUID: NfIEO24AjX22tRmVvH_KNPU_CfswzHfM
X-Proofpoint-ORIG-GUID: NfIEO24AjX22tRmVvH_KNPU_CfswzHfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150214
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

We add a new script: scripts/check-maintainers-file.py, that will run at
configuration time (and not at build time), to not hurt build time.
This script runs in 0.2s on my dev VM, which has an old cpu.

We can expect things to be mostly in sync since adding or removing a
source or test file will trigger a configure step.
For the rest, like docs, tcg tests, or remaining files, GitLab CI will
build things from scratch and always run the configure step.

With this, it should be impossible by design to have an upstream
MAINTAINERS file with non existing file entries.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build                       |  5 +++
 scripts/check-maintainers-file.py | 53 +++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100755 scripts/check-maintainers-file.py

diff --git a/meson.build b/meson.build
index 19e123423b5..57e9c9de42b 100644
--- a/meson.build
+++ b/meson.build
@@ -17,6 +17,11 @@ add_test_setup('thorough',
 
 meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
 
+# check our MAINTAINERS file is consistent
+check_maintainers = find_program('scripts/check-maintainers-file.py')
+maintainers_file = files('MAINTAINERS')
+run_command([check_maintainers, maintainers_file], check: true)
+
 ####################
 # Global variables #
 ####################
diff --git a/scripts/check-maintainers-file.py b/scripts/check-maintainers-file.py
new file mode 100755
index 00000000000..b001816a401
--- /dev/null
+++ b/scripts/check-maintainers-file.py
@@ -0,0 +1,53 @@
+#! /usr/bin/env python3
+
+# Check incorrect file entries in MAINTAINERS
+#
+# Author: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import argparse
+import glob
+import sys
+
+
+def check_one_entry(line) -> bool:
+    return True
+
+
+def main() -> None:
+    parser = argparse.ArgumentParser(description="Check MAINTAINERS file")
+    parser.add_argument("maintainers", help="Path to MAINTAINERS file")
+    args = parser.parse_args()
+
+    found_file_entry = False
+    found_incorrect_entries = False
+    line_counter = 0
+
+    with open(args.maintainers) as file:
+        for entry in file:
+            line_counter += 1
+
+            if not entry.startswith("F:"):
+                continue
+            entry = entry[2:].strip()
+            found_file_entry = True
+
+            file_exists = len(glob.glob(entry, recursive=True)) > 0
+            if file_exists:
+                continue
+
+            found_incorrect_entries = True
+            print(
+                f"No matching files for {args.maintainers} +{line_counter}: {entry}",
+                file=sys.stderr,
+            )
+
+    if not found_file_entry:
+        raise Exception("no file entry found - is MAINTAINERS path correct?")
+    if found_incorrect_entries:
+        raise Exception(f"incorrect entries found in {args.maintainers}")
+
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


