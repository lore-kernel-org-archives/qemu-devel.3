Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1248C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZjO-0001Fi-FL; Tue, 28 Jul 2026 00:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjE-0000jo-Vl
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjC-00024z-D3
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:44 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aZ9j1714780
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PtUy1n0F7+X
 jcj9VjN/NQ0QfcRs5k5hKeK4XnL+06DQ=; b=LG8qGkG1AjHGZzheaBBonJ8WEHy
 +OnpvpABaqZc/Q/0h2qCJmrRuAZaJ4+l2Y4CzHFoTJM1EG3Wkg1N+Oq/BzCEduXp
 ey59XSpb7K9IC10Q1Um6pbVnLXpIxgAdym2dV0/9dPECythWEwX7Csvvl3d+zUr1
 iKTiG+FuWMrDMYERz0qocgNWBc/vdVZOK/jy+kj9ndRffbQkqlZkz+mMBmwKFmCX
 FbDiw3jc822BYsgRf7PJZUXaPl7ZW8NKcfroy9htpikZu+UqOz2tqxuykAYe29sv
 Um3g+6cD7Tiq6lHE9gzl8GQ4xpmGeGq1FZVLGwLpaVwsl6uIZ+Xzv5Z3mDg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkjyed-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb4cdf95b5aso6152936a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214060; x=1785818860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PtUy1n0F7+Xjcj9VjN/NQ0QfcRs5k5hKeK4XnL+06DQ=;
 b=FgXD7b+CBaj5/H1c3qgt2uc5TcLrffW7TK9gV54x73PqWmv8EJu8YgLzn4XUekVL0M
 HXnrMiSkpqod9nLAQXuPQvevc9ACKoExfJ9s2V85SAuIbcqFFF9dv4eOgLs2CKgcBdUw
 t0iMiJY3z5Ge2DitMd08boz6ZovddyjXE7W1F8KWwaEQQve1BJd3jr0EOC9faN0gRVZH
 LujMXeXZrVfmpvtzvKJsmXzWWrBmOeK9cFx8hOn+bMktu9gcRrob3DL1nG7rS1/BiUw7
 dyS3epO6lbUngGgz2eajiV962DQapNlsTgt9SDOO0HO0oMVCrWahVKg8n4nJjxHC5AgR
 Ga4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214060; x=1785818860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PtUy1n0F7+Xjcj9VjN/NQ0QfcRs5k5hKeK4XnL+06DQ=;
 b=d53FVHCN5bWAGym5T4+9Hy5+ArKSS2c5kkK2KhU3XZjs5epgyV9516Rgp2WTwj6OHP
 Srn8G6EhjCrGpUbZDqt78laf8bQTLAeyXTfyvgAetlbT+DBr6iEEs4kTH7CWAXLqp0Qu
 YvR5UfVR2uvZ7ZQANJ2vWb/kuBxa8/yUiwA6pBRpSMxLOUQGi4lhInsyEjQ9UcHwDKOX
 s8T7j+FS9UAxnqD3OjsXkA99XQRFuIhuyNl/TWML8CBEKHFWaKeCUfqyx/tut+T+WnSB
 cA2HUcl7Ar2f5as+lFhuEEhJvRtz7fh/caXa1zG2l/+2Mfxh/IqtMYJ+I0ehzUV0igKI
 CFTg==
X-Gm-Message-State: AOJu0YxpyLZZKF/0un35kV9LE0kqxecnz5Nlte28uVynShmWP7YlAfIH
 gPI9qVf3thRcvbsk1j0e7EzMUDBxNjmXa8uwQFs5SQ6K6XOYLVWiuLlXNJJLDHWxMZ67VS6N4Vv
 HKQa700lBu1jORGE76KwA9OVy+Vc8OPlACL8J/fkvQlY8vd78e3tQq1OBAm+NgUoSzw==
X-Gm-Gg: AR+sD10M6Z5wK4IxB+is335jHVCuRjOWFpJvI69OhIYuayN38dkFLjdbWxbgwexoWZF
 t44MnCWX7MpRa05rN6ldxw7hNm2rOSi1fODEiG8xZ2XiOqv5NdBuheA4QTbpxs+H7zH56L9J1DA
 hOn+mJ2CC/5qtgGMZgUY0O2FNn0AZLOT/LUnDStZEA3qFH6HP0o2f0s6BOXKOt3AONtfF6z7VwN
 JqvzzkHNJshq9/JLD+J7DSc2CoVMClH7Ut3A7nrazHUms58bRt8hcuehgu42P3b60iV7nTyFe27
 5KeV0IcpKpPiqzljFGs4p4RTYwDwzfeyqB01HmWHqvRBlIab/UWGsvbYT7FQSvQj7lt6IMH9fj/
 kM4bfuplNSSUtvuO3JwCZRk/FOpwjKk1rPJ4Ta+m3gR9qIvNGXHcJ2k4TjFdTNJNL3bKbBJc=
X-Received: by 2002:a05:6300:189:b0:3bf:6237:b1b3 with SMTP id
 adf61e73a8af0-3c8ba5d8fabmr994233637.42.1785214060260; 
 Mon, 27 Jul 2026 21:47:40 -0700 (PDT)
X-Received: by 2002:a05:6300:189:b0:3bf:6237:b1b3 with SMTP id
 adf61e73a8af0-3c8ba5d8fabmr994217637.42.1785214059841; 
 Mon, 27 Jul 2026 21:47:39 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:39 -0700 (PDT)
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
Subject: [PATCH v6 049/103] tests/tcg/hexagon: user tests
Date: Mon, 27 Jul 2026 21:41:53 -0700
Message-ID: <20260728044248.137626-50-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 180QoonJ8GCuoMDxbu1cCScCcw4ocu7F
X-Proofpoint-GUID: 180QoonJ8GCuoMDxbu1cCScCcw4ocu7F
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a68346d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=mDV3o1hIAAAA:8
 a=EUspDBNiAAAA:8 a=SimhI8I5uGPfL6hJvhIA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX60kr3vlHcnBi
 4K3mHOcr3ZEzXiXAlix4zQ/U2R+dmOqT5CSdnuG0ueZlAuER59vdj9ji0w/xEAmZLcJRn0xOwNI
 86Oei1DoI1teJdHz7uzFiO+5LR7rCiQ02vSmJl8O69IGg1VFgyr6UiTjeTHn8rYGz2YD5iCJQ7E
 yzu8+AVuTlkANt57tH1zoZ4W/7s2slHnX9b6mxzbf3KO5T30X8iKoY0mY54ETnVNR56qRt26fEF
 Az3J3q7CHA7PfPeApeIzDwsknvLRj3omAO+WUnWE88M2WrTEYIDXwbAu7QUGnq1V058ffcPYsnM
 dBs2R1FXyRLLWReQiqXio6iI+nAiIFFuY3B/81NVbYV9fwBsb0TORo6k1uCPTJsT//mNFfJOTnS
 bA9e28qnisLT7ViclFcff7+89Dz+qQ7qM3XLw8NKjkcLmjtIRzS9U53cIAI5iymE9nFP5Lss6ie
 XfKCBmBxmjBfZtJlmrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXzmoz9daHItmR
 WGNgo0pwZaud6Wb9d10VO9xvdy8Ns0+l7G+CMblwnUD2d7IkkA29Gl1bR/+p2ITe3J2vRkoNxRF
 y8N70EVzhUIMFrvCFh4xuNgd/Yotu20=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/hexagon/Makefile.target | 148 ------------------------------
 tests/tcg/hexagon/meson.build     | 112 ++++++++++++++++++++++
 tests/tcg/meson.build             |   1 +
 3 files changed, 113 insertions(+), 148 deletions(-)
 delete mode 100644 tests/tcg/hexagon/Makefile.target
 create mode 100644 tests/tcg/hexagon/meson.build

diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
deleted file mode 100644
index a2a0ffc69b2..00000000000
--- a/tests/tcg/hexagon/Makefile.target
+++ /dev/null
@@ -1,148 +0,0 @@
-##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
-##
-##  This program is free software; you can redistribute it and/or modify
-##  it under the terms of the GNU General Public License as published by
-##  the Free Software Foundation; either version 2 of the License, or
-##  (at your option) any later version.
-##
-##  This program is distributed in the hope that it will be useful,
-##  but WITHOUT ANY WARRANTY; without even the implied warranty of
-##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-##  GNU General Public License for more details.
-##
-##  You should have received a copy of the GNU General Public License
-##  along with this program; if not, see <http://www.gnu.org/licenses/>.
-##
-
-# Hexagon doesn't support gdb, so skip the EXTRA_RUNS
-EXTRA_RUNS =
-
-CFLAGS += -Wno-incompatible-pointer-types -Wno-undefined-internal
-CFLAGS += -fno-unroll-loops -fno-stack-protector
-
-HEX_SRC=$(SRC_PATH)/tests/tcg/hexagon
-VPATH += $(HEX_SRC)
-
-%: $(HEX_SRC)/%.S $(HEX_SRC)/crt.S
-	$(CC) -static -mv67 -nostdlib $^ -o $@
-
-HEX_TESTS = first
-HEX_TESTS += hex_sigsegv
-HEX_TESTS += misc
-HEX_TESTS += usr
-HEX_TESTS += preg_alias
-HEX_TESTS += dual_stores
-HEX_TESTS += multi_result
-HEX_TESTS += mem_noshuf
-HEX_TESTS += mem_noshuf_exception
-HEX_TESTS += circ
-HEX_TESTS += brev
-HEX_TESTS += load_unpack
-HEX_TESTS += load_align
-HEX_TESTS += atomics
-HEX_TESTS += fpstuff
-HEX_TESTS += overflow
-HEX_TESTS += signal_context
-HEX_TESTS += reg_mut
-HEX_TESTS += read_write_overlap
-HEX_TESTS += vector_add_int
-HEX_TESTS += scatter_gather
-HEX_TESTS += hvx_misc
-HEX_TESTS += hvx_histogram
-HEX_TESTS += invalid-slots
-HEX_TESTS += invalid-encoding
-HEX_TESTS += multiple-writes
-HEX_TESTS += unaligned_pc
-HEX_TESTS += unaligned_data
-
-HEX_TESTS += test_abs
-HEX_TESTS += test_bitcnt
-HEX_TESTS += test_bitsplit
-HEX_TESTS += test_call
-HEX_TESTS += test_clobber
-HEX_TESTS += test_cmp
-HEX_TESTS += test_dotnew
-HEX_TESTS += test_ext
-HEX_TESTS += test_fibonacci
-HEX_TESTS += test_hl
-HEX_TESTS += test_hwloops
-HEX_TESTS += test_jmp
-HEX_TESTS += test_lsr
-HEX_TESTS += test_mpyi
-HEX_TESTS += test_packet
-HEX_TESTS += test_reorder
-HEX_TESTS += test_round
-HEX_TESTS += test_vavgw
-HEX_TESTS += test_vcmpb
-HEX_TESTS += test_vcmpw
-HEX_TESTS += test_vlsrw
-HEX_TESTS += test_vmaxh
-HEX_TESTS += test_vminh
-HEX_TESTS += test_vpmpyh
-HEX_TESTS += test_vspliceb
-
-HEX_TESTS += check_rev_gating
-HEX_TESTS += test_pnew_jump_loads
-
-HEX_TESTS += v68_scalar
-HEX_TESTS += v68_hvx
-HEX_TESTS += v69_hvx
-HEX_TESTS += v73_scalar
-
-TESTS += $(HEX_TESTS)
-
-atomics: atomics.c hex_test.h
-brev: brev.c hex_test.h
-circ: circ.c hex_test.h
-dual_stores: dual_stores.c hex_test.h
-fpstuff: fpstuff.c hex_test.h
-hex_sigsegv: hex_sigsegv.c hex_test.h
-load_align: load_align.c hex_test.h
-load_unpack: load_unpack.c hex_test.h
-mem_noshuf_exception: mem_noshuf_exception.c hex_test.h
-mem_noshuf: mem_noshuf.c hex_test.h
-misc: misc.c hex_test.h
-multi_result: multi_result.c hex_test.h
-overflow: overflow.c hex_test.h
-preg_alias: preg_alias.c hex_test.h
-read_write_overlap: read_write_overlap.c hex_test.h
-reg_mut: reg_mut.c hex_test.h
-test_pnew_jump_loads: test_pnew_jump_loads.c hex_test.h
-unaligned_data: unaligned_data.c hex_test.h
-unaligned_pc: unaligned_pc.c
-
-# Compile for v66 so that the ELF selects a v66 CPU; the test then
-# exercises revision gating by executing a v68 .word instruction.
-run-check_rev_gating: QEMU_OPTS += -cpu v66
-check_rev_gating: check_rev_gating.c
-	$(CC) $(CFLAGS) -mv66 -O2 $< -o $@ $(LDFLAGS)
-
-# This test has to be compiled for the -mv67t target
-usr: usr.c hex_test.h
-	$(CC) $(CFLAGS) -mv67t -O2 -Wno-inline-asm -Wno-expansion-to-defined $< -o $@ $(LDFLAGS)
-
-# Build this test with -mv71 to exercise the CABAC instruction
-misc: misc.c
-	$(CC) $(CFLAGS) -mv71 -O2 $< -o $@ $(LDFLAGS)
-scatter_gather: CFLAGS += -mhvx
-vector_add_int: CFLAGS += -mhvx -fvectorize
-hvx_misc: hvx_misc.c hvx_misc.h
-hvx_misc: CFLAGS += -mhvx
-hvx_histogram: CFLAGS += -mhvx -Wno-gnu-folding-constant
-v68_hvx: v68_hvx.c hvx_misc.h v6mpy_ref.c.inc
-v68_hvx: CFLAGS += -mhvx -Wno-unused-function
-v69_hvx: v69_hvx.c hvx_misc.h
-v69_hvx: CFLAGS += -mhvx -Wno-unused-function
-v73_scalar: CFLAGS += -Wno-unused-function
-
-hvx_histogram: hvx_histogram.c hvx_histogram_row.S
-	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
-
-ifeq ($(CONFIG_PLUGIN),y)
-# LLVM is way too aggressive with inlining and dead code elimination even at
-# -O0, which interferes with the test. What looks like dead code in this test
-# to the compiler isn't actually dead code, so we need to disable all potential
-# LLVM optimization passes.
-test-plugin-set-pc: CFLAGS += -Xclang -disable-llvm-passes
-endif
diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
new file mode 100644
index 00000000000..3e519435245
--- /dev/null
+++ b/tests/tcg/hexagon/meson.build
@@ -0,0 +1,112 @@
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
+  'unaligned_data.c': {'cflags': cflags},
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
index 351d4c8b021..73deb6cbc3e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -140,6 +140,7 @@ subdir('aarch64')
 subdir('aarch64_be')
 subdir('alpha')
 subdir('arm')
+subdir('hexagon')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


