Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2ACC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5f-0003yx-NS; Fri, 10 Jul 2026 17:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5X-00031K-K9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5U-0004pf-4h
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:51 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Q8b1713097
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7O/x1efwusU
 +pOE9vlNKtrBIo5AqxhLt/pbdgTiwrRQ=; b=irgzLk9e0J/bAB67YoJeG/kRJs/
 JTnjqngNOHs40VE0R0Aqg7hnT5oIlZPQgFWQJKlgH2ekjtDXt/rDDYBP9SyPghko
 PP2HKqk3TqkA+AQ83b/geoXBueck8lgZca9NbIkimiKHuCZLNDDWuE2RbQezmsjz
 h/BJ2bpQTHZQ5ZsIrC6dRw0Te4u6UM37uVuH4J2IVCaZjC37gfBjcY7pQvoJOlKt
 gM3cxoAAcWIT9d/tcBX2MIBoDydV1zSRSPAojSf1uYl0jS5zEnsZXzzPTlquSarH
 UQ0BrzoHl+S9A0RXYzS8t2iFQQmuiPRja/KvG0oib60XMTLOJECDBfS5KEQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb339s9vn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88da04b719so1304049a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720116; x=1784324916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7O/x1efwusU+pOE9vlNKtrBIo5AqxhLt/pbdgTiwrRQ=;
 b=E9P8DwhiOU0Z+DPa9g+7c7uOKha0drmF0a/NSS7be+gmZEdRawxX0Nd3b7W72rEJb2
 +PqZXzjjgAFoS//OgR2nyiT5dMEqWhCPU0SmWnZQUHPP5fJL6F97/01rulTUTlZi8/dq
 uSx65sSqI9gZbe1yb5pWE79bTEMJThxo8qlwJgq33Mw021hk+mO3fdwC6cakYOq3OiTt
 otobWkLAqMr8/4Sl2thrnQ92LQJqCmT2CivPjigf/jl8wMgOTKpwsZoDIEcpORxXJWBh
 ZFE3CprscaIotdhDZ9FaEe1gepGbl3rNPH0fzrsMX8ElSnspk9dWWVm5axfnJGujfLPC
 eBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720116; x=1784324916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7O/x1efwusU+pOE9vlNKtrBIo5AqxhLt/pbdgTiwrRQ=;
 b=k0DwFtY7I3tLuvJ+0ag3AAJ0Lg8D8lWHRh7tQGMjrAcUnTQOH5+y0Ig+a9V8vhos1m
 dRiih6earc42EYx84Qd2YxVqB/1oFFt9iUiVot7ay+jrvc7EFQdHk+9cqMxNdIetB5Uj
 1gS8D1Eh/YgJ8cJ0qtdI9Qp91qzczufqB40MtQ4wt4vBmMMpxmz0lmGMcNcvr9VRU8VI
 iVFlv/vbulMVA6Ky6LW5xJ57c/xDohX49AyzBN5RPlPZEvmkgvM6igGRTKeF1foFxRmc
 bKLRhY6Lqr/2s4tioVsNc+9MjHVSzgNEcPHuzgVNesiS655J174tu6rI0jvYETe0RbbA
 VDcA==
X-Gm-Message-State: AOJu0YyerJw8BnWRX0YXhQxzz7vTIWM2RgBgxLlH74hay73S6A8YQbvb
 hEcJEfCH4QBYNF+Wa+lio5hpAWVnknwStZ5a8SZdDwy241CpRM/qSrkVwKahUxIZCOgpnZECXRH
 AMRwVaJhrTve2khqUawUo+K/Ql4eknoErzJA2uR7qX8vKIV7V6lOC0O18lb7jzcAgyQ==
X-Gm-Gg: AfdE7clFBL8Zt9TGuIwUnQzYtzDk5A2lO4+1uTNfK8IcRfKxFbwe+znWUVw84eMn5sD
 1fNJRT2aEJbokjDYFaQwbB1uPGU3prT3Wfz0fjLSzmm2N/Yi3ZNGErzTt6PG9I4KiP+WGieUBX2
 LuRyECHmmxxV1/DPR5pfNDIn29p7xzAmBx51Dhz50FyrXdggw1rJuRmgiBRSXOSk60w64vpfv6t
 Wie9+ZDsaOz0/APDhlAD4GevvD51vJeSkaahinV2bG57Ayt/4KMAFHJV0v6ur35dHwB8LDhfpr+
 dEeF+ihoZTvwLcUQ51h90pMvo0dg3LBwtoAJwjElcBZKFZarmRWPl+Y28w43NOe8n9X4uILOeiT
 FGh7Ix0n84wZ0V9xA5ayY+ZjOI51BXe1kUjD5U6Yj3/e1D4mn7eOhcD2oF8gf0i2+xuSDYULFXp
 17+Qoqmw==
X-Received: by 2002:a05:6a21:700b:b0:39c:235:c5ec with SMTP id
 adf61e73a8af0-3c110a0fb58mr726570637.34.1783720115712; 
 Fri, 10 Jul 2026 14:48:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:700b:b0:39c:235:c5ec with SMTP id
 adf61e73a8af0-3c110a0fb58mr726536637.34.1783720115181; 
 Fri, 10 Jul 2026 14:48:35 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 48/98] tests/tcg/hexagon: user tests
Date: Fri, 10 Jul 2026 14:42:52 -0700
Message-ID: <20260710214343.2065491-49-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXzctKRLuZgkbL
 Wb4RfAWwHlxlpq9TMrMZi45sloY8hYH8BmIj35UEHXCQ+dUP40wck60VCOFW5AspeUrVaTlbdc7
 u+92Qy1H6/vE+Q44Y1Zo0npCF/iBjHk=
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a5168b4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=mDV3o1hIAAAA:8
 a=EUspDBNiAAAA:8 a=zIPrjQ4gCWyY0Bfb52EA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: Y6gDNu0tw_Nu0NUrcGZnUj-HUq_ZWcoq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX088a//pkCOfE
 TGFxp86N1WwYlLoS19jnK1nOgoLz7E3Ob7nE9eKL3c/Z/VpPfSunTaH9Ar5PmYX/TLnTSRlG788
 zmLb0mtNUPXpPguiOvQHtDDW22+Ptkf3WfCh0R4Q1MiilIXk5KUSK5Egnlxtl0k6B6PUM4ivbo1
 eEreG5gkRpwVIOfdTt2KtYxT4VucEuFLWtB7+gRAuJQpoaPKD9C7pIqG5IUdrCCpRKIHNuoL+KJ
 Y7a3FZSvYUde6nTFS/E5t1UGcLbJyA96dv82zffDSQRgv6eTphsHRSiF/WbiU+V594CnJHqAZwR
 ztARa/7VNUBIc8IzCSiq4Q+uIiICBsapLLqhe5Yg1thazWGmhOHGGtFNHkFmWHzNktf/kjF66dB
 LNcwuK4cP2qotNouO8BoiwW91o8Yd3v8SDvqsIHrYBV08ry8UPfup6Q8BNF1cZTpkCqiWCA8G1z
 /t9GtBfRdrMfXkV18Iw==
X-Proofpoint-GUID: Y6gDNu0tw_Nu0NUrcGZnUj-HUq_ZWcoq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
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
 tests/tcg/hexagon/Makefile.target | 146 ------------------------------
 tests/tcg/hexagon/meson.build     | 111 +++++++++++++++++++++++
 tests/tcg/meson.build             |   1 +
 3 files changed, 112 insertions(+), 146 deletions(-)
 delete mode 100644 tests/tcg/hexagon/Makefile.target
 create mode 100644 tests/tcg/hexagon/meson.build

diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
deleted file mode 100644
index 70a8ec2e7fb..00000000000
--- a/tests/tcg/hexagon/Makefile.target
+++ /dev/null
@@ -1,146 +0,0 @@
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
index e2bc582ab5b..e6206ae670a 100644
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


