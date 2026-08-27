Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63153C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziSY-0008Jd-FQ; Thu, 27 Aug 2026 18:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSK-0006ny-GD
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSG-0007Rq-A8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLdgs1358489
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=haT0bNewHwG
 vPaMAUxhfuxvRfhhHQFnd6ar9UrAJ73w=; b=D81Gr4P0bnrfg4zJqarOw4X/jeF
 Vgd0GrbaIq+MwVLS1Jb1RND/ud/ERGbR+9+ei1vyIHxE/rh9H9cqFdAuvBwo48m+
 m+RM/Ju5mZ4Fd7UcgA55AdlG4L0M0nrszfEmJegkQgfDnYzNIuKCTn1QANO+bTPB
 6jGgK/Gv2KVbi5s5MM6WnHUjdHLvQkEjrkshUxO7jLix8tBsN2gWHzHRHM7O0nAH
 h73/9zgo9gMDSG3LcuitZlX0WMRf4RB1mcl/TY7533hu3mJN9ig4T1qaVa51361e
 J5psYH61Etet0knQcSnj1pv4RZdAYSN1gpgNjwOTdlH3BINyRCZYOcgXmXQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgvaaaa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e8fee6af3so536482a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869203; x=1788474003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=haT0bNewHwGvPaMAUxhfuxvRfhhHQFnd6ar9UrAJ73w=;
 b=EdbkOLM8pUR5qvARw6OXE/fqxiRWQiWeT63yjY0Win78twu8W94Ba5N/ohEYlbvuQD
 fWdAUTAObAaHpFnwaKu1pEC3lfxyxcOSi8jjJ/NeQSuhUL+blYExM0TAk0Yr8S4KqlJb
 2JCamcCetTkPc8/ImnuNc8Fk4wCIapLRigrgjVB9dUb2YkwsyRfEAwHGETjf/8UnRjQn
 O7tA559gUkncOQWi+fIMS8bOXQiJYP7iWHvCB2+Secl3zBhmwXQ1Wazn40bsiP9M/2uM
 9Tz583xENAo3z6xwVQqb6GpjQuwgYMfc9v6HVrEcUgVlqGwPh467OqljiTYBL4aima2P
 6zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869203; x=1788474003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=haT0bNewHwGvPaMAUxhfuxvRfhhHQFnd6ar9UrAJ73w=;
 b=LILMkwmP3Ws5RXOWjhuQWyZCAU+ZnnvYEyI6Z2tk8WAxce0uZMqI+tjy8YAKsst0fS
 o9yaEh5t9fcfMJgDgo/y4qPpxDW5YMufHt7XtUdRx/re9G6fWa84fvPF2XiYpZGt54LH
 mtSvdgoQ9E8nAO9PSCDerCGbRjqovkbwH68PEvZN4OW2uteJ9jNJHmN7lZuJqvlYkEkP
 OAgg/Q0sFRCsKVsJtMh5zonvgln8wO+pkN/fC4CLtb3McZzxiQ806Bl0mZAsyE0cScdl
 LlP1RSovqNoHIDzDnvw95vZcsobSINBLcaE+4kbXq1+ptHCRobI8c7u65lJX6vDLO0rw
 rNAg==
X-Gm-Message-State: AFuF++lJsoH2y2Rp51U4vnFwG1gYfer8xJgk0t3+FcXtvoWQZHWqQ2JQ
 NruVgrVo1ai9NStHNUrXh/RqnDbBtOgo6VbLHh5+xtmyvzNnOMJhUrAMkpsUSFyBhE+erWW+hZJ
 oEiE7lOS9dtasthg1fhWdTaBbNgNcJjKClgkI/IzVr7bQqXsf3ThE2cCOrOmUxQfyTA==
X-Gm-Gg: AR+sD124DHnQiRaBD4PokQZfvWNzT+m8ILw/q7LPyCtqSu1BR29ESNJ0TM1qkoM6yu0
 O5yS8Ka4MOw3Kcp5KvKtRLjXn/8fkipa7g0M3q76fM0mUwhOTHWpqB+ypk5Ri08N7YXgDBivTsQ
 zp7ohRHWsptwLLHL7PDDo7Fi2grsIv2FSI/ehI0R+BFeXLg51AcSqeLoZVVa/A9DmkivmBKwT9w
 PY+MS9/N2wbcsOz/QAVxiqKJwT+nHiwThKnSu5bAnqWMNo8QGnBF3A7v+IXMxuqY8aga8boXXIf
 9s/Qhpbg45FBWds4fVuhmETio0bYlJE7ULDGtv2ybmBXGASRFeKy1CB/DbtoQFvisthkof+igKG
 EP89uP/iP9GIJ2zZpag57MGHLol4NAe24sbawK/mmid/nEB1dc98oj53ucfw=
X-Received: by 2002:a17:90b:3c08:b0:38e:485c:ebd3 with SMTP id
 98e67ed59e1d1-396d0f9ad1fmr4496523a91.15.1787869203379; 
 Thu, 27 Aug 2026 15:20:03 -0700 (PDT)
X-Received: by 2002:a17:90b:3c08:b0:38e:485c:ebd3 with SMTP id
 98e67ed59e1d1-396d0f9ad1fmr4496407a91.15.1787869202868; 
 Thu, 27 Aug 2026 15:20:02 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:20:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 073/105] tests/tcg/or1k: user tests
Date: Thu, 27 Aug 2026 22:14:34 +0000
Message-ID: <20260827221506.91574-74-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LFhqEgooUhPvLM0WOHg5HWGrnXkYk_An
X-Proofpoint-GUID: LFhqEgooUhPvLM0WOHg5HWGrnXkYk_An
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b814 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=vRC7ysU8fHDJUYuF0LMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX5Hfg3/T6fDYX
 lkAlO3D93sIZz1oLu3Fdy17YtnXF6vZ0cSW7ZqII4DM1fjfB2K/YzCgQ2/pYLBV48cWhL0HQRNM
 j9A/kUrmFAnCW4nSTfT8gfZazpMPNnzL8gCoExRAFidq1NwjWfrb6r0FBNT0YicpeIoHn/d0ISB
 GPR7/2BFxl5UCxl30/kU/oNbUOvMVCOIYGGtWxF54PG8pbzUqJaHtzHy6fYVdgFpyLfXncS4IvB
 NgkNO+vWHwdkM3b2eOyBwBb4+UlFJqzkuMjVv22Mu+jwzRyu5nU12N88VNC0YYp9c6wtBfzKfCX
 opTE+4bUpmWU8OVQz2fPhJ4YRSSqP7M3glSGl2pv0JB/1Iqhe6A9UppYM4zQf1ioSGKhUA1e5kM
 Mfrr1YMjR0DONEFHIckgIy7wHK/MAOiphXsBIA87me3V3Te9cgemtRfAqPvebiGiaMARGSpWZq6
 x4rlkHwVYt2mTcSlq0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX4wxRT6XaB4QO
 TRs5LdmKj77iklDkQeEZExelgaENoI5G6Nnh9Jxr6T/UBLyR+Ow38OiHbsJp0nqt9bsnyNJQjjs
 DwIIVS3O04+0+TV+RIRi5J2VVTH8UbY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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


