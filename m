Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30941C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4cB-0002V8-IL; Fri, 10 Jul 2026 02:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4c8-0002HE-10
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4c6-0004nU-1U
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n9uD3707758
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QNZAa3alJiG
 tGxLBjjBM1lfZbLaA21+JnZG/rrXHBHI=; b=Gd0XgcZIkc2KzMGvS47t5jvp1rg
 jotNQuQByGR6PeqqD3RMbII/GxvxjJOx4AGVXMcJB39JlnoGDMbAf1E8dbdu+aGF
 g6jlruu0zTLj+OWaCbg45REmwVaMIzsFWp15Q/JopCRdcEMa9bed04LyO4drvh+0
 EY3EFPuVjuP39YBs49SrHb+M1BsweNe3okf6h1n9oa+iYwRBaYkPTNtFcg8Tms36
 bsDLxSVJQlqCA2IgGp18xGCOX9JNzY/tQM2oL4cRSnNuZsVSGFCQ+V0nLFqdX7Jb
 ru08+Wtd1Lq3rXl00RdIyp5kh5a2L4jMeLCd3XyELDjNnAbQHkRJoOb/Bew==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg5k33n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:18 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c916d17dd43so1038570a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664478; x=1784269278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QNZAa3alJiGtGxLBjjBM1lfZbLaA21+JnZG/rrXHBHI=;
 b=jnxCAvGIlywG3ICRSzjqpBwyVNdBK1UAAoQocYgr3qAKtmyhjkMXd/CZnX6RbEJfEB
 Flc2OrGXcew7RuBKQEf+vTAkAuW5my/6uBZmqivlXYzgQw/Z1x3Z0MI163tThtBBsel5
 zxD9odVn9QfI9UpfnPyHVXXz6pPkp+r0F8gpM/wmWeKCsEuH8Mbk41JrIGm9FSaCY+Oq
 zTA/Ax+Pu+BMA8WvpNW47tmOMJ93qiCLGKQWPC8MnoHQn5xA9WAkbDBsQN0r7vX6PIkY
 IKvH+DjCKtxwIzs69zNSSoWkvYimKKWP8YIxBCa5JQGV/dloHPSgAzgef6hsYcZGI7EP
 mf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664478; x=1784269278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QNZAa3alJiGtGxLBjjBM1lfZbLaA21+JnZG/rrXHBHI=;
 b=Zp72nqlAI211Q1IpylLRIUNdfUaPVLBMu3cr16xrLURe5gQWuEza7Up7SMaqNGSKBj
 0iADKv5fHikxcL/jb8BhkrdsykMmb4dpmQZydV5COclp5TlzM9B2AbIaj4PiZsmGM5zb
 hs9U1avlv+HJsr1SmGfuQhgo52hisFltr/n9SuNiQHVSMxKXZ0cAGJYpvEizGoz2Fmip
 KcGNalF+tPNOZOFA7oBLWdb23lIBut9Nugi20+UgVf3V1wNFf7+Xmme8VvxgyImzNekL
 4Mf+ecO5ds0jq4coSxsVPRrqhendg7KZgYHsWMFlbJMMN7EUWfH+N2LyUDbExD6zfSnw
 LLnA==
X-Gm-Message-State: AOJu0YzYUQIcWyz0Z456bapfpDd0i6mKqN4K5lhLlTx1pCcrc09+QtyV
 iz6oqQCw/oTFBE4SIS0Hq3VwbUAbSU0Lh+N6V8A7rxLYz/gkPgb1rKhAqQrCH6CzDAtE46q1m07
 J+or/zvVMLfCK3DT4XizMRMtoFfleRXjPv/sY+PUElKlVT2pR+RckK6a78BclKNkZkQ==
X-Gm-Gg: AfdE7clak0ezr5ViMbIIPv0xPeXMlcJku35vK7IbRl2g/NRZZ7b1QeT8bfzHk/4EVhq
 wzlcmn7ulhKRqSIH3oxqyc+wsoBwS8ffQOL3qCqsxvezyFjneYLOXUdlE5pAipqEJOFfi9ZGAkq
 E4NZWqoyRnSG8RCbjmAbI3EU50FSKKvpWjtkwzQPw/YT3MA2U35sDqx4qMzlJOvofomPEW1yIdj
 CUlobLLWxLlpUJdYHxbMKn5iP1+yg73QlsiLJLI1F7lUSpQrkNafHbxZ1Z+u8ISoNTnrltCkps9
 JJT5OSBEy0xvQU+8YVQXKrJ5ws7xNxGy+nIC4n9CD1pzSy08OTZfqOBmqE1Lrk5hXSlT1bRdb7W
 7e3gOp86WRZlaZr3wUnQc39mwZxhRjvMSZw3hpDafBVACqxgUIuedKchiRGoZ28UbzERFrpeG7h
 n4qUjcPA==
X-Received: by 2002:a05:6a21:4e02:b0:3c0:9c19:65c1 with SMTP id
 adf61e73a8af0-3c0bcd20167mr11458802637.73.1783664478025; 
 Thu, 09 Jul 2026 23:21:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:4e02:b0:3c0:9c19:65c1 with SMTP id
 adf61e73a8af0-3c0bcd20167mr11458774637.73.1783664477501; 
 Thu, 09 Jul 2026 23:21:17 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:16 -0700 (PDT)
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
Subject: [PATCH v4 29/97] tests/tcg/meson.build: check host cross cc is working
Date: Thu,  9 Jul 2026 23:19:07 -0700
Message-ID: <20260710062016.1818125-30-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FN8rAeos c=1 sm=1 tr=0 ts=6a508f5e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=URtBMVaIwCeI8XDN2_AA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXwZIzbkvan1xQ
 fcQ5sS8qMcB5qHAtwF5ySooL7KNTUh2o2XAM7y4ELitWWfbzCHA8vD1AYRQ7WYw128Gqt/RVf7j
 q14Uanq9QITW2ODTfLBJKc69TjtnZ/s=
X-Proofpoint-ORIG-GUID: i7tpnDCiVEHJcdwHhBqY4rmOAdORFR6k
X-Proofpoint-GUID: i7tpnDCiVEHJcdwHhBqY4rmOAdORFR6k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXy9pUOGjhPT8U
 dE723UIfP8LV2DPan07FtbYF/kg4dsJXLhjNPX5/fAws4MP0xxAFOeIa8Ohb8QFoWA6UW3JXCLo
 Ga3WcQ54h+f/r7ILqs3e8WyeVzCCGv3q9MN35FVhSjXK+Yi0TPEFgXgoSuArAX7OkQKdwBH5zl7
 +n8iEJ2qjONSK6p4LKi4XWrrvO/LkN7DDwQH1OYF+B/vLDi+atwLfIdTa5W5DhCsM4kpUeWQVLU
 YtuXNadCJ9XCxTieZbrjxZA1866m4GlBBae7Ghu/6adk/u5PvHi9zUhjjKxRY/tk6jZy6A7IRcp
 LytX1gz8EPLRASpBStj+tPCBP4fW3etOGviQW9K2i404BVUFpQiJrra6IMMPY9P37TDeJLQkmPN
 JOvC0Rtac2HZycKBUIUrNOWpkjTYyqQ5sAswy1FqPcTeRdpOHa4S9bWmuQu0kiONc9vbwJ+rBk9
 u93vakFdxZj6PA0gLhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

On Fedora, cross compilers are provided without runtime or header files.
Thus, even if program is present, it can't be used to compile files
directly. Check this, and fallback on docker if not working.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 13 +++++++++++++
 tests/tcg/test_cc.c   |  7 +++++++
 2 files changed, 20 insertions(+)
 create mode 100644 tests/tcg/test_cc.c

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index eb17b0bdd67..4cdd0a95310 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -106,6 +106,19 @@ foreach target, plan: tcg_tests
   cc = find_program(plan['cc'], required : false)
   cc_from_system = cc.found()
   has_cc = cc.found()
+  if has_cc
+    check_flags = ['-static']
+    if target.endswith('softmmu')
+      check_flags = ['-nostdlib', '-r']
+    endif
+
+    cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
+                      check: false)
+    avail = cmd.returncode() == 0
+    cc_from_system = has_cc
+    has_cc = avail
+  endif
+
   build_test_depends = []
   build_test_depend_files = []
 
diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
new file mode 100644
index 00000000000..b8a0dae6c8a
--- /dev/null
+++ b/tests/tcg/test_cc.c
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <stdint.h>
+
+int main(void)
+{
+}
-- 
2.47.3


