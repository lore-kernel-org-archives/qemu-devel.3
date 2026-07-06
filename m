Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD6FC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgru1-0003cJ-H8; Mon, 06 Jul 2026 18:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtw-0003M6-Vo
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtu-0005eq-HG
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEAlQ1504914
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RGb70iN/S6g
 59wLpkAbDsbdKWagfh72V6KAHtz9T2U8=; b=GwqKYwfbrTWFcF/ry0arl9Y8ysy
 eH24xLbwqp0an4td64azx31IeL5Zegt4w/ANyeIDuVThNwxXpCieU3CR3FQ7ANyA
 QIve1P2giobXBYSQhZVkWeA4t87Q+Hv/FK8zc2TLjwJfSg9mcJJtWIlt9Na7wfil
 cUagRnzESJgZY5U+DUF4FM6YvN3apkNrAp6+war52zIg6SP8i38ltoUd7/+PW/Ca
 0pbbk6DIc6P/XBC8wgiT6kEQVeVZ3+6gnwzWv1rniY6/Z95cBwffsBcIUeEZtXr1
 3WBy4N0le0FjkSbR0SmDcbLEaGUZ7mEU5UY9b8Xi9QU5KcRgnTdPeynjgFw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98k2qb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:42 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8620ee0971so4114824a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377282; x=1783982082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RGb70iN/S6g59wLpkAbDsbdKWagfh72V6KAHtz9T2U8=;
 b=UOc5CWmkwQcjpRYgQrUKbqnfUAAxJJcNB+WPTgJAONnFeu3C5JgMPDzb0Roq1pfKpv
 isqHZIK7D0qI1JR2EMlwOa1Gb7ouadiq7rM/SZPe4fqlpjz6yWBnRZpDevrDYoVMb+hd
 5YlZujqbqlg3bPDiWl+zeB/lWkBBfzQIf92NJNDbE1RgIusDVA/6ITm7L90tEaEiZd+f
 XY8+wY4w3G1oy3mZhgD00/ktNSfk8Uax9YRdLrBULtU001omocZp+hbe/M83sg2YiKaV
 qMEWLnRA+KwYM7olbhkBabzjbtritYmohJh5DV3y6JQsN6Bz4svEZ7mdOJnHN9AyVteu
 TxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377282; x=1783982082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RGb70iN/S6g59wLpkAbDsbdKWagfh72V6KAHtz9T2U8=;
 b=TEnu39MZMVApf2W4ngYfXnoGYm5FQxVKqr9QkmibvzoljUawrz82O4lqFYClcH6VFL
 S5zb/GQaK5kYZUSXWPyPJoo5etC3GzuUpzmbBPFBpcH/P7AQy1Hl4Ty9PxP1fLjd6Cal
 8V4A97b9nmLrts95v5kr7r8Koc4U3fWPphoeaQbnh3AckQ9jM6ZgTYayO3beqJWdynwp
 rFo1HFZgFou5pAzAfEnDMtYlZuDJ68YehtkUrNkrM9XViua69LmBXkp3ALPG/uEs9Gd4
 Z4tnEAvxEQYgvJBuiMnuPNB3LdWEaK2ibe2P9SUt+/IHJUWW9auStnql4jnU31CNWW+o
 RwTA==
X-Gm-Message-State: AOJu0YySPEKf6FIBbhVJyQidc/z9+fDmRyShmQEOFzfJakyrI/ur3873
 pWutJ2QaWABWNaRno2nR1NdYYMlgduRQiO4dEWT9wGSJV1o4i8TcLC42GgGsFEcvoJMHJFqD1y/
 Qj8D2srEWIiXej8RsUcA1SOGkTHc0CTVrYl34hU/Rb4BOplB0pzog7eBfTXEJoiUCHA==
X-Gm-Gg: AfdE7clR6sYsbL57OJH6f70Wfld3dJbhM4sJEAbNwGFGuWSDEj3RkfyEfSEw3riglhd
 fQKYxyzEzGEYw7oLpfqIUDYPDpBXV2MnIErMjgoCCLuYTjZ05zP2n/fiXMAdzmofVL6pS8dAjAx
 5a6xP57nZJ14lwcrprY6tPlkp2cvJ3gr6RcbxYuiHqTqqiVFGoNoJYdtuON7XB5fjZW+2NdGEIS
 u4uWzojxBKYMOmwrrUrxAhg1yfPOlzCSPzx1aGINb6lY8vK1bWvchdYQjBtgo5Nd7Fd90u5Ri30
 UPIEVszaH5zcCOYWmEqojv7e2nVktA0Odb0r8v7B2kgMHAjW47g3c6PnjNETIPx5Xia8/1c+BJH
 0YiR8AV4Dd7jb+UbXYeeAK4fBdVmAvHl2cpwPNU4qKig5mGimdgws7kf1+BMUQpUmJqHgQ12LgP
 wSKjnFfA==
X-Received: by 2002:a05:6a21:689:b0:3bf:b40b:def2 with SMTP id
 adf61e73a8af0-3c08ec66809mr2907587637.9.1783377281755; 
 Mon, 06 Jul 2026 15:34:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:689:b0:3bf:b40b:def2 with SMTP id
 adf61e73a8af0-3c08ec66809mr2907550637.9.1783377281341; 
 Mon, 06 Jul 2026 15:34:41 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 32/91] tests/tcg/multiarch: declare system tests
Date: Mon,  6 Jul 2026 15:32:44 -0700
Message-ID: <20260706223343.988769-33-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c2d82 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=8vYM-gic8w0O4C_0kjEA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX2nrNdb/d3TJv
 ghHSg8W4y3V09U7X62oh/GwISkfKZniH6lswzm5Up1VIwc90P9OlUoGh9UIMrrY4BXq+II+ImTi
 D6+eRIAsbskMXabF2u52AkCr7YakqPAWlRkwr9E1rQaE+sk4i1V4bBsOzP8V6vLecsVr8SUHBBL
 HzdNxLUsJV7TXl1pxQgG0lkycM7LX/q88DWPPg9YTCrWdSNTwltIgyFNz1lOemw3xAdRUHeZTcI
 oziCZzZXrSleaVM7iQvN4cz1GNMw67DIwfGAPn/WzEIgVX46urgTNCkrIxjwGpVGPrz9qoy+oRU
 RpfiC6sD4hYjAPnmZ4nLcSCB5rSRO604ptv3KCEvldELW58MTa3dOKXeEeawof9OAPR7BKo0Ni2
 sXHdpiN9qL41hHlw0kq+PoLM/GP7CurGjdb/rVuE4cRbel0d5sgMy9gBZ9xTiOlNDkt2WZOBi1p
 0kHLs8F1GDDGClVi57g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX9qWnCBk9L8L1
 1gPtLAu8Z12+QTCRAs64srnpZZW8K9XocusjsBdCkb/5pHxh0Fqey6ldBdICiSDXOkVpqh2nm+9
 Ws2QGq/8zwDyq9KMYA2gjzELObrpLWQ=
X-Proofpoint-GUID: 4jtSV164Zoj8_dllmQqki9QUZtpSZAtm
X-Proofpoint-ORIG-GUID: 4jtSV164Zoj8_dllmQqki9QUZtpSZAtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

We now declare all multiarch system tests.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/meson.build        |  2 +
 tests/tcg/multiarch/system/meson.build | 53 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tests/tcg/multiarch/system/meson.build

diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index 99af41b3fcc..508fdb585b7 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -1,3 +1,5 @@
+subdir('system')
+
 tests = []
 
 float_helpers = files('libs/float_helpers.c')[0]
diff --git a/tests/tcg/multiarch/system/meson.build b/tests/tcg/multiarch/system/meson.build
new file mode 100644
index 00000000000..f71c12db38e
--- /dev/null
+++ b/tests/tcg/multiarch/system/meson.build
@@ -0,0 +1,53 @@
+tests = []
+
+# multiarch src path are written to be included from any other arch folder,
+# so all arch can directly add those tests.
+multiarch = meson.current_source_dir()
+
+tests += {
+  multiarch/'hello.c': {},
+  multiarch/'interrupt.c': {},
+  multiarch/'memory.c': {},
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'gdb_test': ['--test', files('../gdbstub/memory.py')]
+  },
+  multiarch/'interrupt.c': {
+    'gdb_test': ['--test', files('../gdbstub/interrupt.py')]
+  },
+  multiarch/'hello.c': {
+    'test_name': 'untimely-packet',
+    'gdb_test': ['--gdb-args',  '-ex \'set debug remote 1\'',
+                 '--output', '/dev/stdout',
+                 '--stderr', '/dev/stdout'],
+    'wrapper': [prog_run_and_check_forbidden_output,
+                'Packet instead of Ack, ignoring it']
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'registers',
+    'gdb_test': ['--test', files('../gdbstub/registers.py')]
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'memory-access',
+    'plugin_test': {
+      'plugin': 'mem',
+      'args': ['region-summary=true'],
+    },
+    'wrapper': [prog_check_plugin_output,
+                find_program('./validate-memory-counts.py')]
+  }
+}
+
+tcg_tests += {
+  'multiarch-softmmu': {
+    'tests': tests
+  }
+}
-- 
2.47.3


