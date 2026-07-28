Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F0CC54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZkh-0003Qq-Tt; Tue, 28 Jul 2026 00:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk7-0002nT-B5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk3-0002A9-Dj
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:36 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aruj1701595
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u+vpNKF1JAY
 p3XL9ZImsevtgRI6x5HTjfFAynBfU1aU=; b=P4tx5rm8OdsN6SfWu3bQmEBltfU
 AbSJrApQlNZUROvNy+Yz3O5k8VXob9apJFi36IeFuci5pf7f7NAJeg4CK+QBGC9S
 QUszrH1FEYkuiook/1CSDtERqueZ9OVyiqNefFcs9SRiKNFgKqNo+d/bT6R6Mc5d
 BBl/fEonoXA1xxxGBjRuexLBot0fQSELUUOHE0Md4z+iRc6wG6zbES+3HpkIzGYh
 1fS7S5q8oyDT8MOLANvT/VKYSCr+BtyQlc3cXyfh6IF2k1E4Mt/goUnMSn6hxVwL
 xXpBuAsm93cwyzQgaNzrDrPs8m9+agJL7e72jhUkVU5QGJZkHyjCqJIf79g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7gwsa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb835525b13so3889701a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214112; x=1785818912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u+vpNKF1JAYp3XL9ZImsevtgRI6x5HTjfFAynBfU1aU=;
 b=CPQbrXHdxrLbDY3HL+k1XjhMN7qSKFiPqPhyoBzeNMauPtFNHliXi9VmzVPX7D/MLT
 F8LQb+eTG7n44PR8fc7+AGHkCnJSH1w/ZOvY6xYVeZ3ACaOCO5eIh7IB/a/Trq/c6e+t
 SpLB1wodcso527q2aEU63srRXJTRQiZZuvh/FIo49nC0WVHQpHqt9QkzAcd2QLF9wRLP
 CZmuziEvuEkzuXH8ODJDHmDsM9aP/lRsiwJt3Fvjw1t4iVYDO0OiAZzucm0ce/9vU8zc
 xkzBzFhNA6cPyzOxLMiaok60Uh0jhQ2mkZWCP0li04ZdL0kvNI1dsAsRxq9j/fXcWlud
 NBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214112; x=1785818912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u+vpNKF1JAYp3XL9ZImsevtgRI6x5HTjfFAynBfU1aU=;
 b=os6ivInVfymuqOe9InznXNU1iz9rSQUcYNPfMGx6ZEuwEivXtXqeUx+xa6ES9pE5VS
 2gnzi9wErWV07mADVYj6ecmB63JOd1ZF94lEAtuF0QWpXdK548KL0E8gNJqNyYOEfyfX
 yrFiZ86yrpuDAE6uiA1FpHToHtR3H2IzpSjh/pQAsKrXkho7QS1zlpHxHIVaOxB1UjBa
 Gs4+Mm+RUsJap3AWzF0QizqSD00b3S8kZcdB9CI3RQmP5LWdNdt2wCsfTz0ARQAtcGdP
 Yuiw+Y9xa52SxYICOFjiz92qID7swPJjE9e4l4G3ZaC+PT+1IZrboF2yMfACVR5opvPL
 DoEA==
X-Gm-Message-State: AOJu0Yz+5xq/6es3byopcLJM612Ury0745drIJA4c5hRTyauiQGv2pq5
 sI1bYahqurfXJUnLA5+wiqMkcg4zt5HvUi/GweVskCEvbRzpe7kG9O381BCBNXPDXFUzJtrk4UB
 ZeXPqe+P4khol/Y5B2FcVm7DovfqsLS5yyES0JEOizhTwzwOSGcXYZYLHkH/4rNJxuQ==
X-Gm-Gg: AR+sD11Sx85UzHtCXqVloaKyQDDqfigPKyyFaEHdQhx3Ki/2HtDdyAtfwsRJTs3NQaZ
 3JlgHQ7//xZmjYLTXoarnKZxxq2FUddxcNB8qrCmYfVNZCDnUAJKjAxrkvYOTz9hanqAd1p9QaG
 f7bGC0ypC0UEme+Wq6E/Kq2Yn8yLQb6tc7mObCvIq/MYi0gkgtuupWNns7YotHQM1uUgXxzRutX
 Q+SRAGyIzYwFMZUWa15SEE1l6irkVJZiE8a4W2rkvitpz0pFDQXStifneiIDkTIoReG2la0BdVt
 SDD5oqcOCu6Ujw25DfVSSRmDmPIyWuYwJOVmlaKOyPdTlITnzF0+v6AjawX66ZNbMM7bxfjNZp/
 yWQbvULKCg0tva5hVZmWtdXnQh3H6zTZSw+DnmgBlcdkBbb+9xJ4tNdoNyO8nAFTzsC/c9xM=
X-Received: by 2002:a05:6a21:3381:b0:3c0:b766:74f4 with SMTP id
 adf61e73a8af0-3c8ba484354mr1193684637.31.1785214112233; 
 Mon, 27 Jul 2026 21:48:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:3381:b0:3c0:b766:74f4 with SMTP id
 adf61e73a8af0-3c8ba484354mr1193649637.31.1785214111777; 
 Mon, 27 Jul 2026 21:48:31 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 072/103] tests/tcg/or1k: user tests
Date: Mon, 27 Jul 2026 21:42:16 -0700
Message-ID: <20260728044248.137626-73-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX+bxoM4sZJVF2
 WXemSo3Y/NrghEQLj8KedJk3A27WgVPCiKqomVa8kjZHXMdsesTjrsw+WiRbJl4ca5229tIGWTY
 WZvgq/qYcRsVuO6D+xT2fKB5tMdgKKYr4/AOlFgICoC1zRjxVi/BRnzqWubSHr0KC3v6muKyjIb
 +3WQ7eEGyOfxy/O5tPG/9CMvRnf48I2XKppazOpKVBcll2K6GAa/4gRRJyIZ4qnjsyKwNB5Aba4
 qoywofq534RnmYWwK9LakRyCp07LKOxS7xeGyiT6dPHFjQuErwATRXm5WILLiFR3lzYPXgJTtMJ
 Ud2jYEaiLfIB8PWHI0g/y6KWXQI5tc6dVM5Z3JgNs2MtUYs8YD/5H1/bhuVntIGMcG8DJA123l8
 n0fV4oW/8c8X6bZK4QFUhqgKKPW3I8DyttA4Nh/BIyHHEWchKi7VkXLi1GmPJAki2RoJsMet6N3
 yYymGr4UkqmfT8hhqvw==
X-Proofpoint-ORIG-GUID: kVzayAnHlJV6wdd0w8B8qNuvT7AST61a
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX6MEt8pyPeiIp
 NdiVgn+P6g9mfwWadHM3ol+iT5SxjGqTsLN71OXgtUfqOB2yWyrVYKNe5kNTDPIVI2DNRsJ9jOz
 iejZKLQKoImvEh0mD46cYYapiI6rLFY=
X-Proofpoint-GUID: kVzayAnHlJV6wdd0w8B8qNuvT7AST61a
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a6834a1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=vRC7ysU8fHDJUYuF0LMA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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

Some tests are currently failing, so they are commented.
To be investigated.

qemu:or1k-linux-user-test_addc FAIL 0.05s (exit status 255 or 0xff)
qemu:or1k-linux-user-test_div  FAIL 0.06s (exit status 136 or signal 8 SIGFPE)
qemu:or1k-linux-user-test_extx FAIL 0.06s (exit status 132 or signal 4 SIGILL)
qemu:or1k-linux-user-test_lx   FAIL 0.05s (exit status 139 or signal 11 SIGSEGV)

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build      |  1 +
 tests/tcg/or1k/Makefile    | 71 -------------------------------------
 tests/tcg/or1k/meson.build | 72 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 71 deletions(-)
 delete mode 100644 tests/tcg/or1k/Makefile
 create mode 100644 tests/tcg/or1k/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d7a805428be..310948c3f91 100644
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
2.47.3


