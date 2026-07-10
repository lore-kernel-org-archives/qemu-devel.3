Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8C2C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4fo-0007VU-8V; Fri, 10 Jul 2026 02:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fn-0007Ut-8d
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fl-0005k7-8I
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:19 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mhSr3847281
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Bx6IAj9Jr4b
 9qX1XgN+Vq4yOQPEysSoHjsMZKosh/zI=; b=Ul6LWKNVzAcRgJw448WhJ95PikM
 kyG/lyAzYdCn2PaZ7laSv4KZejABJXiEIRqaydY2EnO//bpjCglHHEZlHv+3n0E3
 3JJrBMOW28SoSVwPphCxFmzW7PY14dBUZCudfwfefblclmlePJ3+nTAKNzkbKWCi
 fTAkDbffqaQ5UBNSyyqwTt4lzLdw04pS1e2JrlVBlg6lZ00We2lJ767ugm0wSVNO
 93Nga8q7kgzvXO0TNruaJ1WHvZ4de6ZQQJXbNzK9CDa9FLfXZyJi06iywEnQ+PAh
 w51oh0f9XsleMfqdAOWOb5tQgvZ/Z13ZCzLa6tiNKOmCoGt7oD5FovbRJsQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte1qa3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so1198479a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664715; x=1784269515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bx6IAj9Jr4b9qX1XgN+Vq4yOQPEysSoHjsMZKosh/zI=;
 b=RGBagP2hY6qyT7bHF+aRgb7twPMO4uGWa0ECIYvb7jWbPZ4BRCm9vZDunWoCHbxS7j
 7QXexHfRsEUPN6Fz8/iAC6ztnyrioFM8Kgl4hvfISPFqrV5vh/0HqocG83WujJn1KL2e
 qgIx7Eoc/rBgxunrEpRuJdTi2Bns2BtaMXAeBg2U8IKFpkbMHSbYLE3xhJp0HH8SsZCc
 LavMr+JZmtIf7UfjpmscJgN7yI0BlqcndQbeTQihurj5pzlJEglQHvxXnnHmw2d0Tc+9
 9ePL8La0cbzaQLQJTPYij3qe4ry53hz/ts54h3d6hUZLmxzGhxOyS3dwoZtDH0n/Lc08
 Uhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664715; x=1784269515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bx6IAj9Jr4b9qX1XgN+Vq4yOQPEysSoHjsMZKosh/zI=;
 b=ME36/MK5h3BXl18JwBu+7+dLo0dSSpKSDWIChbX4Uz2ub3eP/NGSN/G1JJvDoyLhNp
 I7fizx3W7RZ0EgvBDCRPLQ2g6W/5ICd7Q9WQ143SxT9IG+ry5kbS0Dp/TG3sd5Tqa8ZT
 mY73oRpJH3iPqgCUUSuyUMQugQoMG+A6UeYYKM7D327X57yQtXIdaR+MigrkWYy+cx+L
 luUQ/2vXvi7j8GUTt30UtVibSPIdnLPrQqulFAWpKPwDvrM6hWrfCx1c+Va+8x5nUOg0
 /3aGAuTpdZ/wbkKu11PmnsmzZqBfGA6nCZHP808NbyCxZYar7AWbOLj/TcAkudPHQsKz
 tGiA==
X-Gm-Message-State: AOJu0YyUOrcZicxeZrckIJiExhcMyACXTjW+4D6XknhJfNn88nMAWvWX
 Acc//8qIJr9jEiVfBdmwql1sylOb578loxCrYiuyfqHJ4EJdToZwD8Nq1JPVLYtL85qPmLa5h6Q
 LqcZlM+tMhN20uZ6S10viCaZ687IiiXC8plXCv5ggFjkT+28PVZ+LUscZgIh71uuPUQ==
X-Gm-Gg: AfdE7cnJzIaLtFCWmai2/c6GhLEAd2mIsUIxJHpg2ut3hEDoigW0fmglwVEDsdsyeuF
 bP/Gh990ITwHgRHvwn6u+fAdKWHXePeCDp7epQ7ceV5jAUOxC/2vuPtr5nVCGs+evQVwX9Uo4BE
 g6Rl/m7XGUIyuMY3+Ip66Xor2hb5iMDSRUuwaq9em5KR0h2ONJm5b4C3InY0VPMgVriYs02pLBJ
 TA/AuKtnkn3gZy4L1Z19d0iLgAHe3gMwSAiFWLBG0wx8yw/bMp9d9kPw7h3NBWakPILjHDQYbgG
 0PS5Vn1IKpLitQhCTAxEe7dceq2vc3K/gqo0Q35n1PjY1CFEe0Q8EgV0rsi/cUKpYT/lCbvJ+f7
 YTzRbXaRi58pzp+5mOuKzUc0LURlRYWsONxpKJTMiBHwryWNutO8aFOAJ7rYr9b3KCaJO3txilB
 hdpH1COA==
X-Received: by 2002:a05:6a20:be8f:b0:3c0:9c19:6588 with SMTP id
 adf61e73a8af0-3c0bcfcacb2mr12488433637.66.1783664715211; 
 Thu, 09 Jul 2026 23:25:15 -0700 (PDT)
X-Received: by 2002:a05:6a20:be8f:b0:3c0:9c19:6588 with SMTP id
 adf61e73a8af0-3c0bcfcacb2mr12488388637.66.1783664714609; 
 Thu, 09 Jul 2026 23:25:14 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:13 -0700 (PDT)
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
Subject: [PATCH v4 47/97] tests/tcg/hexagon: user tests
Date: Thu,  9 Jul 2026 23:19:25 -0700
Message-ID: <20260710062016.1818125-48-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oqKQyB7DKoXDUPZykXWI-3avN-xNStNB
X-Proofpoint-ORIG-GUID: oqKQyB7DKoXDUPZykXWI-3avN-xNStNB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX22ZaQeR0FLGX
 TyDTVy5ySe2ldlGZV6pQlAIvoenDMhRo4DQf15QqmCxP5yZbeCF6CtXsQyt/7MqH2TuHuCIvbmf
 j7zeNAm4nkjvvV8EMzD+JV7VOfWLu2SpRjurHqhNYRQP8S8Fr9DFr9umwvjgcM0UmyRN/V5UsYo
 IIDDgjPPvmlCZKSAtNZhRIGPb6YtSGj3fj9Y+m84k2uBhiqWL1ix0b0oyUcg7HhT/+P/KW26xRq
 9OesCnm0ccIDs0IdavlMH7cjIeCB2ynO0EAt57DG8HxBhAFEif9ogyEI4ZCSwegNcYhJirPtj2u
 lSI60xkqrl+ZgSubfVQwhMuuEHOp2kAk2e2SHz4EhmBXrNCYWltJ2GolHl91qnyzzYa+ZoNStmF
 fTqNYe6gS2+53AlPPueErWfHjqft10hYlejvdL0bZL4CGP93IxTv+79m8z1cLjjnMu3PJMf6Qgi
 b3nXN0lzDxqfFNHZbew==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a50904b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=_iHZ7MywaTSflSyKFasA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX7fcv7cZdZs7C
 Rlpwa03nRexvSHAIDUxUIcbRSgs1hgZZYb3c9QuqQMRe4YBDqsMPlIrF/Pndo3M37r5mBH+mLav
 Dz6w+FqmJj65EJAAPBgnyw2wsCUUNeg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/hexagon/meson.build | 111 ++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build         |   1 +
 2 files changed, 112 insertions(+)
 create mode 100644 tests/tcg/hexagon/meson.build

diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
new file mode 100644
index 00000000000..423d125d2ae
--- /dev/null
+++ b/tests/tcg/hexagon/meson.build
@@ -0,0 +1,111 @@
+tests = []
+
+cflags = ['-Wno-incompatible-pointer-types', '-Wno-undefined-internal',
+          '-fno-unroll-loops', '-fno-stack-protector']
+asmflags = [cflags, '-nostdlib', '-mv67', files('crt.S')]
+
+multi_src = []
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    if 'gdb_test' in setup
+      # gdb does not support hexagon, ignore test
+      continue
+    endif
+    new_cflags = []
+    if 'cflags' in setup
+      new_cflags += setup['cflags']
+    endif
+    new_cflags += cflags
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  'atomics.c': {'cflags': cflags},
+  'brev.c': {'cflags': cflags},
+  # Compile for v66 so that the ELF selects a v66 CPU; the test then
+  # exercises revision gating by executing a v68 .word instruction.
+  'check_rev_gating.c': {
+    'cflags': [cflags, '-mv66', '-O2'],
+    'qemu_args': ['-cpu', 'v66'],
+  },
+  'circ.c': {'cflags': cflags},
+  'first.S': {'cflags': asmflags},
+  'fpstuff.c': {'cflags': cflags},
+  'hex_sigsegv.c': {'cflags': cflags},
+  'hvx_misc.c': {'cflags': [cflags, '-mhvx', '-mv69']},
+  'hvx_histogram.c': {
+    'cflags': [cflags, '-mhvx', '-Wno-gnu-folding-constant',
+               files('hvx_histogram_row.S')]
+  },
+  'invalid-encoding.c': {'cflags': cflags},
+  'invalid-slots.c': {'cflags': cflags},
+  'load_align.c': {'cflags': cflags},
+  'load_unpack.c': {'cflags': cflags},
+  # Build this test with -mv71 to exercise the CABAC instruction
+  'misc.c': {'cflags': [cflags, '-mv71', '-O2']},
+  'multiple-writes.c': {'cflags': cflags},
+  'overflow.c': {'cflags': cflags, 'exe_name': 'hex-overflow'},
+  'preg_alias.c': {'cflags': cflags},
+  'dual_stores.c': {'cflags': cflags},
+  'multi_result.c': {'cflags': cflags},
+  'mem_noshuf.c': {'cflags': cflags},
+  'mem_noshuf_exception.c': {'cflags': cflags},
+  'read_write_overlap.c': {'cflags': cflags},
+  'reg_mut.c': {'cflags': cflags},
+  'scatter_gather.c': {'cflags': [cflags, '-mhvx']},
+  'signal_context.c': {'cflags': cflags},
+  'test_abs.S': {'cflags': asmflags},
+  'test_bitcnt.S': {'cflags': asmflags},
+  'test_bitsplit.S': {'cflags': asmflags},
+  'test_call.S': {'cflags': asmflags},
+  'test_clobber.S': {'cflags': asmflags},
+  'test_cmp.S': {'cflags': asmflags},
+  'test_dotnew.S': {'cflags': asmflags},
+  'test_ext.S': {'cflags': asmflags},
+  'test_fibonacci.S': {'cflags': asmflags},
+  'test_hl.S': {'cflags': asmflags},
+  'test_hwloops.S': {'cflags': asmflags},
+  'test_jmp.S': {'cflags': asmflags},
+  'test_lsr.S': {'cflags': asmflags},
+  'test_mpyi.S': {'cflags': asmflags},
+  'test_packet.S': {'cflags': asmflags},
+  'test_reorder.S': {'cflags': asmflags},
+  'test_round.S': {'cflags': asmflags},
+  'test_vavgw.S': {'cflags': asmflags},
+  'test_vcmpb.S': {'cflags': asmflags},
+  'test_vcmpw.S': {'cflags': asmflags},
+  'test_vlsrw.S': {'cflags': asmflags},
+  'test_vmaxh.S': {'cflags': asmflags},
+  'test_vminh.S': {'cflags': asmflags},
+  'test_vpmpyh.S': {'cflags': asmflags},
+  'test_vspliceb.S': {'cflags': asmflags},
+  'unaligned_pc.c': {'cflags': cflags},
+  'usr.c': {
+    'cflags': [cflags, '-mv67t', '-O2',
+               '-Wno-inline-asm', '-Wno-expansion-to-defined']
+  },
+  'v68_scalar.c': {'cflags': [cflags, '-mv68']},
+  'v68_hvx.c': {'cflags': [cflags, '-mhvx', '-Wno-unused-function', '-mv68']},
+  'v69_hvx.c': {'cflags': [cflags, '-mhvx', '-Wno-unused-function', '-mv69']},
+  'v73_scalar.c': {'cflags': [cflags, '-Wno-unused-function', '-mv73']},
+  'vector_add_int.c': {'cflags': [cflags, '-mhvx', '-fvectorize']},
+}
+
+if 'qemu-hexagon' in emulators
+  tcg_tests += {
+    'hexagon-linux-user': {
+      'cc': 'hexagon-unknown-linux-musl-clang',
+      'cc_dockerfile': 'debian-hexagon-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'folder': 'hexagon',
+      'gdb_arch': 'hexagon_is_not_supported_by_gdb',
+      'qemu': emulators['qemu-hexagon'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 8af1352901e..195e5975e17 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -137,6 +137,7 @@ subdir('aarch64')
 subdir('aarch64_be')
 subdir('alpha')
 subdir('arm')
+subdir('hexagon')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


