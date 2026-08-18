Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892E6C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPUb-00014v-Gf; Tue, 18 Aug 2026 15:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUZ-0000xR-Th
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUX-0007ch-Nw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH7aP2494672
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=haT0bNewHwG
 vPaMAUxhfuxvRfhhHQFnd6ar9UrAJ73w=; b=KNNQN11AzkhhanpzDHLMU0nKNJx
 7WYF4bcR7BkmQ6LIf2dOkbbMZ010p7kPZjaOn0Q9nt4iMJOY1sMgq5TUGct59pIp
 34OutD9ohCQb6qNg59tEyGyTU6NeYc0aO640FtMEbSAUeHvulCEZxtkBWTERHyUv
 vaVxjt97MY1LD3M/jQTfTR9MN6bnIkGE0bu3vA4jC31/fAf6vpsb/RKdoHG0yvRA
 KLPrB6dp/tvUgguaslmhxC+7uuYcGNEWiP8prsiGJsdr8/GYPbes2a2OhpqYfkh+
 9Sh3TNCzmydcCDILVv0sFDCesEEWta5Bvf5LCtcUUCRXsksGSk+S5+Tcb8w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4sfnhaqn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-395543dc382so324427a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081325; x=1787686125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=haT0bNewHwGvPaMAUxhfuxvRfhhHQFnd6ar9UrAJ73w=;
 b=BzHx4/Q1xzI4EwvPxj2L4ijAwawHm58908I+EWTbHi6RXRNlpAO/HGaEW2oufyOldY
 XhXAU0zetWm/l1nXVTz9mCnXZ6uWUST7Kei9ZlRGyk5PyHerTnkBS9P23BW8N5R36irh
 5vLQa1aXeQDDjsK+Ro/x4gwW99z7KuhdokcDL6AR9MYAutEeZ2e3UZyBfU0ZD7+YqaUz
 NSI6oReKp4p2/QcfG4yr51hFLKnvS4lG9xBcrsyID6bc9dhfLr9W/0q5GeHSCuiEtS2t
 zoCqX1nsGYz30LgNRb7IpxLWlS2SubZnvKj3QOweGfMhz4bJCfjCdMb4UqcunZtIDHMR
 Ys/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081325; x=1787686125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=haT0bNewHwGvPaMAUxhfuxvRfhhHQFnd6ar9UrAJ73w=;
 b=UPPHHt++kY586VWppLonBx/t0v5UUMzRwXqABzMInnjfbG3MgHB4N28eym/iPPRnHm
 MEhq0VawK+rkauf/wPoFjAPdkyLdAaeqtSP10mBlOa6SccC/NL5raAOOC8PQEdc/IsPz
 9McJiV9Amaau8Z47lnubo2wKomVa3Pe7r9rkxiruj412b1594e6/aTv4IO5lXYc+5PF1
 ocPzkx7Iac9505cnyMG5tqYyxcDpS5RQKgy54SpAnjavQmpu6oO6Gax0wIhTSq/KNnyY
 xjPJ4x8EqLraruPi/Xmhk070BxxmtaFlz9RZYEnnZuTp+hJDgAfKqs7RqIRJQgCqmtx1
 IqNA==
X-Gm-Message-State: AOJu0YxPwPS+YnADSymgoyjy1z5v6giUbVseYciVD5GRVuBAdabODmCl
 CkCbaRUR4ncckmcQO5y+aTen4Vm6wsNkHX/+Gu2Sb6f/qmiVGIsHHEEG7HptzB/i3ZTGXxzOung
 Zp19UbmUzhnbs9yeoHAtM/bBqrejpRLEtfgRPdldHJorhinzRiR36YXRDProLFsMKtQ==
X-Gm-Gg: AR+sD116eO6dFuTHrKy3PsDVgnIY9WhycnNiHtvt9TXDJlRsNE8E04fAA9x/KI4LdMQ
 ANo+wd1pXY+t/1agGVk7RibnFiB4JKHNhf+P9ZcBARbebNWwxkx2AaW6vBwNOaecjwSWPz6Le/y
 UXni4QF1SFaxnFiHp0+/1F9DFgXaqCnhvFKB8QkzuPKFDbaU+rUloxM4C9OlWD/GsCHkX/vk0SC
 GtUv8XybUuW3ia1EmAoGSLS1ROnMQTLA0XrWFc69pyM9+Z1BsJEA9dmfR8k/L2Hp0ODLgCjPeMf
 HQvDl7Vs9cKb1UFAmxXXDKVofDsHUlTkVg/mllBNXfTyKK1ILeAs2w24fFV+fJ5CUSeLIeTS/pq
 it+wvvl/vM60mLZSuwWjMYrZwvp6MJy7zo/5In9yqtbnR8vTH7D5rEx0/OkE=
X-Received: by 2002:a17:90b:4cc2:b0:38f:aab1:5148 with SMTP id
 98e67ed59e1d1-3957b8d7581mr32017a91.13.1787081325479; 
 Tue, 18 Aug 2026 12:28:45 -0700 (PDT)
X-Received: by 2002:a17:90b:4cc2:b0:38f:aab1:5148 with SMTP id
 98e67ed59e1d1-3957b8d7581mr31916a91.13.1787081324995; 
 Tue, 18 Aug 2026 12:28:44 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 073/104] tests/tcg/or1k: user tests
Date: Tue, 18 Aug 2026 19:22:37 +0000
Message-ID: <20260818192309.22169-74-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX9sOPip7u7pIS
 hO5PCT4kzKsCSHQfkGZslGNwjaSy5cIa9h/TLsEuXud7dPR6DvGgg9FDLj8JHzYwcn6VCmNYQ9P
 ocIbftaQfizxC7zWod3Q0aD5JkVlz68=
X-Authority-Analysis: v=2.4 cv=MpliLWae c=1 sm=1 tr=0 ts=6a84b26e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=vRC7ysU8fHDJUYuF0LMA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: lSpM50jZPE7JGIQcTrLnJMjJIlFwHA3n
X-Proofpoint-GUID: lSpM50jZPE7JGIQcTrLnJMjJIlFwHA3n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX8WzNRJNKlf2q
 OCZU8ZPMQ3OSgeGD1ihD3IMoxakqRZkzESUqRoXMMOOJwMWBm2cCaUs1V9k5HulQJ3TPejYwOvO
 daIQG6jlX1Sk5O4t5cDD4jgmYgQzTYvg2n5SzA3Lh/o0SA+tNshhWApUz8gdfe+X/3v9PkJPb9O
 C3AiFprdxm+WaPU+2ayPt/aH+6YQrbSp5zWWEuTgSrPkpTbBC0HfdXYKoWPJ8EytqNQdQvQhlhf
 2gynb7wu1jozvTbehBU9jtgW292O71+w4yDgsiSqBg+wAqZr8Ci0q/Zljlk7vzWEIPqy09CCcpe
 AtlDmVdc5gJPjgZk+u7DFxmEj0xTfTry53mM0e4WUTrZ54aOVqsJRthdB4Zfo9s4MTQAKSRhJNW
 RkczQO3LALATfOjPvVs4+r54ePxFwOHqNVMgFRO3ezqC/bWuOsoeglNMdRTT98gIv7kSFUoIYRD
 0PAaIS6FhE+VVUfoZYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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

Some tests are currently failing, so they are commented.
To be investigated.

qemu:or1k-linux-user-test_addc FAIL 0.05s (exit status 255 or 0xff)
qemu:or1k-linux-user-test_div  FAIL 0.06s (exit status 136 or signal 8 SIGFPE)
qemu:or1k-linux-user-test_extx FAIL 0.06s (exit status 132 or signal 4 SIGILL)
qemu:or1k-linux-user-test_lx   FAIL 0.05s (exit status 139 or signal 11 SIGSEGV)

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build      |  1 +
 tests/tcg/or1k/Makefile    | 71 -------------------------------------
 tests/tcg/or1k/meson.build | 72 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 71 deletions(-)
 delete mode 100644 tests/tcg/or1k/Makefile
 create mode 100644 tests/tcg/or1k/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7aca685078f..d6406b5cb59 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -148,6 +148,7 @@ subdir('m68k')
 subdir('mips')
 subdir('mips64')
 subdir('mips64el')
+subdir('or1k')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/or1k/Makefile b/tests/tcg/or1k/Makefile
deleted file mode 100644
index fb5ceda512f..00000000000
--- a/tests/tcg/or1k/Makefile
+++ /dev/null
@@ -1,71 +0,0 @@
--include ../../config-host.mak
-
-CROSS = or1k-linux-
-
-SIM = qemu-or1k
-
-CC = $(CROSS)gcc
-
-TESTCASES = test_add.tst
-TESTCASES += test_sub.tst
-TESTCASES += test_addc.tst
-TESTCASES += test_addi.tst
-TESTCASES += test_addic.tst
-TESTCASES += test_and_or.tst
-TESTCASES += test_bf.tst
-TESTCASES += test_bnf.tst
-TESTCASES += test_div.tst
-TESTCASES += test_divu.tst
-TESTCASES += test_extx.tst
-TESTCASES += test_fx.tst
-TESTCASES += test_jal.tst
-TESTCASES += test_j.tst
-TESTCASES += test_lf_div.tst
-TESTCASES += test_lf_eqs.tst
-TESTCASES += test_lf_ges.tst
-TESTCASES += test_lf_gts.tst
-TESTCASES += test_lf_les.tst
-TESTCASES += test_lf_lts.tst
-TESTCASES += test_lf_mul.tst
-TESTCASES += test_lf_nes.tst
-TESTCASES += test_lf_rem.tst
-TESTCASES += test_lf_sub.tst
-TESTCASES += test_lf_add.tst
-TESTCASES += test_logic.tst
-TESTCASES += test_lx.tst
-TESTCASES += test_movhi.tst
-TESTCASES += test_mul.tst
-TESTCASES += test_mulu.tst
-TESTCASES += test_muli.tst
-TESTCASES += test_sfeq.tst
-TESTCASES += test_sfeqi.tst
-TESTCASES += test_sfges.tst
-TESTCASES += test_sfgesi.tst
-TESTCASES += test_sfgeu.tst
-TESTCASES += test_sfgeui.tst
-TESTCASES += test_sfgts.tst
-TESTCASES += test_sfgtsi.tst
-TESTCASES += test_sfgtu.tst
-TESTCASES += test_sfgtui.tst
-TESTCASES += test_sfles.tst
-TESTCASES += test_sflesi.tst
-TESTCASES += test_sfleu.tst
-TESTCASES += test_sfleui.tst
-TESTCASES += test_sflts.tst
-TESTCASES += test_sfltsi.tst
-TESTCASES += test_sfltu.tst
-TESTCASES += test_sfltui.tst
-TESTCASES += test_sfne.tst
-TESTCASES += test_sfnei.tst
-
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) -static $< -o $@
-
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do $(SIM) $$case; echo $$case pass!; sleep 0.2; done
-
-clean:
-	$(RM) -rf $(TESTCASES)
diff --git a/tests/tcg/or1k/meson.build b/tests/tcg/or1k/meson.build
new file mode 100644
index 00000000000..5151e8f361f
--- /dev/null
+++ b/tests/tcg/or1k/meson.build
@@ -0,0 +1,72 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test_add.c': {},
+  #'test_addc.c': {},
+  'test_addi.c': {},
+  'test_addic.c': {},
+  'test_and_or.c': {},
+  'test_bf.c': {},
+  'test_bnf.c': {},
+  #'test_div.c': {},
+  'test_divu.c': {},
+  #'test_extx.c': {},
+  'test_fx.c': {},
+  'test_j.c': {},
+  'test_jal.c': {},
+  'test_lf_add.c': {},
+  'test_lf_div.c': {},
+  'test_lf_eqs.c': {},
+  'test_lf_ges.c': {},
+  'test_lf_gts.c': {},
+  'test_lf_les.c': {},
+  'test_lf_lts.c': {},
+  'test_lf_mul.c': {},
+  'test_lf_nes.c': {},
+  'test_lf_rem.c': {},
+  'test_lf_sub.c': {},
+  'test_logic.c': {},
+  #'test_lx.c': {},
+  'test_movhi.c': {},
+  'test_mul.c': {},
+  'test_muli.c': {},
+  'test_mulu.c': {},
+  'test_sfeq.c': {},
+  'test_sfeqi.c': {},
+  'test_sfges.c': {},
+  'test_sfgesi.c': {},
+  'test_sfgeu.c': {},
+  'test_sfgeui.c': {},
+  'test_sfgts.c': {},
+  'test_sfgtsi.c': {},
+  'test_sfgtu.c': {},
+  'test_sfgtui.c': {},
+  'test_sfles.c': {},
+  'test_sflesi.c': {},
+  'test_sfleu.c': {},
+  'test_sfleui.c': {},
+  'test_sflts.c': {},
+  'test_sfltsi.c': {},
+  'test_sfltu.c': {},
+  'test_sfltui.c': {},
+  'test_sfne.c': {},
+  'test_sfnei.c': {},
+  'test_sub.c': {},
+}
+
+if 'qemu-or1k' in emulators
+  tcg_tests += {
+    'or1k-linux-user': {
+      'cc': 'or1k-none-linux-musl-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'or1k',
+      'gdb_arch': 'or1k',
+      'qemu': emulators['qemu-or1k'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


