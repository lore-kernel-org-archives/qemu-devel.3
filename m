Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B25C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTm-0004PJ-Nt; Tue, 18 Aug 2026 15:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTg-0003zl-ST
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTc-0007SC-Kt
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJOrtB1724870
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jdhnECGmTa+
 ROuc2LTR2mpsS6iv4nTiKAaGVeIowGs0=; b=PAFR/h1WzigilUtUkctX2F5wtiC
 IBesJVp1d/foXXald49g8SFs9RW9h84F5wQhJiAc2ALBdI0SNx8y7zrG5cW3wbxf
 Fksypm9AyIVLq+JDhicl6T6IBPNwJ+d/gz0BDtdJXHVyW6WgN2tGXyMAt9AnAW2n
 aOgpIQn3i31/ByrD5NTFau69hZ+366bXjPybKjhDoQPhduLDq01Dj0JsCqKRDHgo
 iy+TqsP/UFDEmqGZf+8xuO1bTx+hYTXz4ScgGBkrSvb7mV9SW0onR9cEp4kOoO5D
 /sv5p/gIx5a6rp0ddsiU5e+pquftJPo9addWhVXp+LP18H7tztc10nwmrcA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj1uwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso244618a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081278; x=1787686078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jdhnECGmTa+ROuc2LTR2mpsS6iv4nTiKAaGVeIowGs0=;
 b=beyOp8EoikgfZ89VPseSTmB4Loltmjdwx56BNyQxMx3b+NPRuzytVUskxgrqhnxPfJ
 0ghpe+f3NBoSsYRRZNau4HmwF3ejJv8bE18vwUAwjZH7wQjEqrPJC3PbxKFAYlMuwykm
 twufrzd/6i6Os4/JAxMMtr46Jyb73veHyeUKDw/L2B9sv8OVXMa0DIQPUnl81PgSZwTV
 vVp4qkAmpt4BeskF/YL/lqzpYCmPvEn1HtAXx/WcqGr8NwJ42l0Qd9addCLRASpjxKWx
 Lyd62Mt3URShS+o32zRxEKxe5da91LUBWf5q6gKJNymo/nQddrEkC41/jfVwJKWn0HJD
 r8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081278; x=1787686078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jdhnECGmTa+ROuc2LTR2mpsS6iv4nTiKAaGVeIowGs0=;
 b=TPp0PnToyoGjG9WJV0L/1QnLlNy/kUHp0NKfZPPfF68nn8qIhoA5M3YUw5jN3zfHIz
 9y46U0ltT7mtPRwFN4Jx7ThWtcVaPZmHfSSi9GL09ui1t2918ckG23ULR0tHtBWUE/Ny
 cwVLtezntSmUtwJZbxgofqpUiLG4s2E9KUgiBiSDYseNFpQh+voJtdt7KYTAjnAV5QuW
 G5wVB9JsuY5azINOQpo5P8HWu/2cEC+6yKy4vHjkvFIR3mLA8PmrDBFpvIu72fESPbxd
 lCvMm3YcA04NoOzbi5nRmRnPrnXqOG2XFzWo7rZxRBV6BW3nOtd3/1leSYgtLMaH6hLG
 XPiA==
X-Gm-Message-State: AOJu0YzGW8X5xsDKse2Ckmcc0tGtC3itGQqDsWkfLmTzwcr4ynXisvCA
 kA4Z45+D2HVxhbor6szmYmmGM2+JAtnOIqQsqWuVQV6S27TK4Sdly6BJDWnuiho9cdDGE6A19UJ
 Z/i6THAbVL2eSJDNAm0+PhWAW72HfrZy6DWlHCMIifw4enARx6FU9ibbtdABA4xFzBg==
X-Gm-Gg: AR+sD10mWIhWYaZXLwmdI3vcTuld6bknOGk4EHp1rLrhA8mTpvOEyXchHCOLllioFMD
 zFE8JtdG+C4jY0ZpRNt4hMhYi5Il73Z/ksc6eMiuSHnNYzvt027tUutM/IDt2rA4sQY09MhhSF/
 6FofD9R6R5JZeTOylsDqHNghFNnBFWD+nmBGjCxX2Vf0z04DLonBnAtFjCT00CWZ2s4Wawaw5va
 sI0XkgplqfiMSOQMODRZx0qK13OmpdC1rRN1yv9FOBEnVLbxGPIKgFndMmefIIDrqJfodj6KAzM
 fBp0s/YUg2TvCfJPIO3owiItf6zLXK/Yz7zfdmXkHRGymnMuMkSDCYFZVUz/cXejNkxUT3E38G3
 l7ukh4V0A68hNHPIg9eAfJhtn9g6nNWJfbkJ6VECDB068Dkw8OygO2LNEtrY=
X-Received: by 2002:a17:90b:5102:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-3957b3d7620mr34782a91.10.1787081278093; 
 Tue, 18 Aug 2026 12:27:58 -0700 (PDT)
X-Received: by 2002:a17:90b:5102:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-3957b3d7620mr34716a91.10.1787081277493; 
 Tue, 18 Aug 2026 12:27:57 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:27:57 -0700 (PDT)
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
Subject: [PATCH v7 050/104] tests/tcg/hexagon: user tests
Date: Tue, 18 Aug 2026 19:22:14 +0000
Message-ID: <20260818192309.22169-51-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX9+jDp9RZGn38
 2bwos1aSgQioLAguNJAkkgf6wBSEEphumSwdmU63kUbtdLQudoib9JS55vf5N/kzDSqStHXJOOh
 m0tVPCqjgDGZtvFenyl1ofUDqKCg0Xw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX5Z+aoupx+Sa+
 95c0wx31UJJenDvzIwEjijbsnRFrtMMvXhvG8Ys/5w+EJ0ORVoW4uvuvRg6a6G+tUzP69orLhn0
 Sd7Lik1xpONzcRYU+EZoJc1nYGhEw1auupZDSphrdwYPUObyJo5Z/49Yn1UTKwGrUW7prZzh1Zh
 TkwtQdSkP+azPHb5kPNvQwd0rVjnUZ6WPtx+YawvaqPIuu6NrvWpYp1y53NYekiqm/OfyO3eMTT
 ZxJgwKknmiyb0jusUfUR/U8pSu34CyZH7kW48tc3cq2nZv4F/EpHiom/RfeFPniUiojrGkYq9ZN
 zXjFz9L2iAPr/vxIlAMzIaE6v3SZSfxvP+HPdwenBqolAfqstyqqxaMeON89GO9dmtOKKkICzjF
 cxeaQLmb82JIDK7T40uxaSO8JNyKhHTf3YbM8QMws9XGg65QmGJDHW41uZqHt4sIIpS65362Rxy
 vhZYeeT3/Z8ps0XJh7g==
X-Proofpoint-ORIG-GUID: UnyGTcMqEwuBb2SXOQxTLRASV7uU7fYm
X-Proofpoint-GUID: UnyGTcMqEwuBb2SXOQxTLRASV7uU7fYm
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a84b23f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=mDV3o1hIAAAA:8
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=_-pcP7RoYdBLuRuhCPgA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/hexagon/Makefile.target | 163 ------------------------------
 tests/tcg/hexagon/meson.build     | 118 +++++++++++++++++++++
 tests/tcg/meson.build             |   1 +
 3 files changed, 119 insertions(+), 163 deletions(-)
 delete mode 100644 tests/tcg/hexagon/Makefile.target
 create mode 100644 tests/tcg/hexagon/meson.build

diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
deleted file mode 100644
index 61adf6356e4..00000000000
--- a/tests/tcg/hexagon/Makefile.target
+++ /dev/null
@@ -1,163 +0,0 @@
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
-HEX_TESTS += fp_hvx
-HEX_TESTS += fp_hvx_cvt
-HEX_TESTS += fp_hvx_cmp
-HEX_TESTS += fp_hvx_disabled
-HEX_TESTS += invalid-slots
-HEX_TESTS += valid-slots
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
-fp_hvx: fp_hvx.c hvx_misc.h hex_test.h
-fp_hvx: CFLAGS += -mhvx -mhvx-ieee-fp
-fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h hex_test.h
-fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
-fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h hex_test.h
-fp_hvx_cvt: CFLAGS += -mhvx -mhvx-ieee-fp
-fp_hvx_cmp: fp_hvx_cmp.c hvx_misc.h hex_test.h
-fp_hvx_cmp: CFLAGS += -mhvx -mhvx-ieee-fp
-
-run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
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
index 00000000000..aef9a53d773
--- /dev/null
+++ b/tests/tcg/hexagon/meson.build
@@ -0,0 +1,118 @@
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
+  'fp_hvx.c': {'cflags': [cflags, '-mv73', '-mhvx', '-mhvx-ieee-fp']},
+  'fp_hvx_disabled.c': {'cflags': [cflags, '-mv73', '-mhvx', '-mhvx-ieee-fp'],
+                        'qemu_args': ['-cpu', 'v73,ieee-fp=false']},
+  'fp_hvx_cvt.c': {'cflags': [cflags, '-mv73', '-mhvx', '-mhvx-ieee-fp']},
+  'fp_hvx_cmp.c': {'cflags': [cflags, '-mv73', '-mhvx', '-mhvx-ieee-fp']},
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
+  'valid-slots.c': {'cflags': cflags},
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
index 17f48bebf98..27d7aedb8b8 100644
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
2.43.0


