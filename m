Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0730C606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n8Z84aef;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=duO98Bix
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtZq-0003wl-Ss; Fri, 13 Nov 2026 10:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRtZp-0003wI-1v
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 10:52:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRtZm-0007u0-Vd
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 10:52:32 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFR3AV1076207
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 15:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=0gt5iE0h8LnfNoaJXmmOQodB4CdrXdb+PNc
 OHifMEdE=; b=n8Z84aefwmE8BsMPH6450iw8uDNv/2VYmChvUisYDWYMFggPPXj
 qsgZrDgvNyEV5MUePifFJE0aPSflipRehWhXBoRZfBNm/jsbMNkSRuG+ODBHY5Sp
 aqYosBUliwdkfWcsHqlmOsyyiTSz4EHUGnKjHrudoFGrAVpZ/cx/suFBfqmaIZbU
 nnoh3fbkssYKd5F5tWCVH2NvoG5LsTtBZ6gYetI1vCpW6rtUA1NTwak0mF0o7T2t
 E+s8H91FS2YPuMnWnRsoKwGOa0Qit+RUXlKLaVrb4lHBL8IrLsbiHXWW91IVMy5n
 5tMAKsdSEsfslkDCpFHeIN2g5sML43o5F9g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwh0amfb2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 15:52:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f559420f3so123737785a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794585148; x=1795189948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0gt5iE0h8LnfNoaJXmmOQodB4CdrXdb+PNcOHifMEdE=;
 b=duO98Bix7ezn5CGaImJZNl0NCQFNj4aK9A00fgfpm+JeVM43KaJ+UTurXinvQPqP56
 gYmG+e1ztD44Oa6C5socy1jAbGOj8WhD7H6G77jNURKXPQFDPuxEBw7D/rvK8usPMvuB
 WHe5mQeNdp3AZJgEzKUYpEqadJrAIaNfKRnRnzV3gu46FWpvxshH8hNnQgBaSLV/Nm69
 4mt7C58xxe0tIiMT2IKuq8UEo7QeRSo13qvJx//GJ1Gw5/gjPJI6WQQ9yMjqj6QGEMvq
 /GospNEFrUwOEU2GB0woTLg0bp/lsnU/xhH8Y5cG5fCXXIDEcXTxhtl69Qgg8aQy5wYA
 DIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794585148; x=1795189948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0gt5iE0h8LnfNoaJXmmOQodB4CdrXdb+PNcOHifMEdE=;
 b=nAd71+9R/hCVV1itF5jr+9sgzjw5qERRJBYeX2rBmIDQOZWVZMPhWt6qD/FGe7/DJg
 k9VN82Tq2YsSGL2tpY6RR5/jXUNosIsnuc1En4X0DtGtPEgg0PIMiAJcVqaqbiyLu/za
 bXcJCBCS5kC/8vQBSMP5fdC2WpNNjR1UHYNtIxRFvJCiKEHoVcL2ZBFFL6u61AXlG5aG
 6GrcqGXXiF62M6llgRyVATwATzRO2desKBTSZbCpDsgiYBRrM92reRBGhNTgfDKJyV5x
 L3iTRCjQ55YQdjWlSDwHTZDBDAUoqOcTuMx3HM1wRv67o9710uTc+StH0/ZC9xNmd5Jg
 ctpQ==
X-Gm-Message-State: APuU4Z/vO+sCMJsrV90ty1vuYIW89duzztTtDOe+CJ2lCsuAatBjI95Y
 Cga/wmEamXdNMwuCidiJWuOMGeCTt/teYahxZUlUAg8hRufm0oKUO8PpbYjnPJAvQjpQiEx4++I
 VIDLwvxTnMKvZbuuRCw/G5cg48xIaUvbEnp7MeBAaSR61+2nCSGWIAaxDXsBLv7k8eQ==
X-Gm-Gg: AYBFou2ofRLVBq50DTFV7Dj4AH9uAwqHXOEYKGy6xKxr33/j9jKr+l701HH3noUjoV+
 K9z9QqrQ+78Ri91+vAEImG1h65zjCPFg2L4F0EvDXXSSIaw5kcj+/UyRrMvGdwlP6/alEJmn6y9
 nm2FJZb8xIDiqKz+ea09sDmBUnQfIa0q5ENw+4kw0ov70j/luyMPJEzkZph/fJjw950NdrhQ+4i
 7IVYeeJiVd8M5gQRNnoDAyAi380IPius6vT2bKwTQVmQn+3xPVe4MajTKJGg88JabX690PmcP3a
 rlIYt0wFyO9FZLIztJEashlRSow2xzMEJvh4uIKaQr0txp3nTZQaWvGTco0iLKjvptWNSucA/JE
 frN8D0fYnBu9dOxRupiKtPG+lGTlDwY//JYlJ3G531rRDgfvTHYJ6Tlo4jCoOBSINOwiv5i9ZbZ
 wG2tGnRJakRQ==
X-Received: by 2002:a05:620a:1b9c:b0:949:44d2:3275 with SMTP id
 af79cd13be357-9494bb8f2b9mr467670785a.21.1794585147899; 
 Fri, 13 Nov 2026 07:52:27 -0800 (PST)
X-Received: by 2002:a05:620a:1b9c:b0:949:44d2:3275 with SMTP id
 af79cd13be357-9494bb8f2b9mr467665885a.21.1794585147203; 
 Fri, 13 Nov 2026 07:52:27 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.237.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c5fd1e7sm216276785a.1.2026.11.13.07.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:52:25 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target/riscv: allow hvip.VSTIP writes when (m|h)envcfg.STCE
 is set [GL4593]
Date: Fri, 13 Nov 2026 12:52:21 -0300
Message-ID: <20261113155221.87297-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MyBTYWx0ZWRfX0tFx+1KUCIQY
 mp5L+/bmzmmAkVeaO607u/KW9yUptHYL0zN+AQBGp0m1R3UFDrMyDBgrEUMDzcbCkKbwHyp5Ijg
 bPk0PfZiIUCy4vagaHw9axDIJYEDl5A=
X-Proofpoint-GUID: K2uJngAkJ1mmHPalCr8JXkVYS79R48Cc
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6af7323c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=iNxvZbmf7GYCzVQazAudjg==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=M9ce6HhBX4SvkK6VDRMA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MyBTYWx0ZWRfXxm/PIlTIr+f/
 CtG5qJ89bj4RbAJXMNrE4HxGDa35K3IK0njiEk99zqwd30Z/dDTpaII6KCjpgsu7A/ZHy17eZY9
 tJu2CdP3e0jN8+5297oh3TrMv3PotwrxKb28U1O4YRDSGLHZLUD119PWkP4hj8+GzrK/iTpV09+
 qjR4Nnj2OrGbyphV9+6SGeu8AV9qKXb5HJ7VwdAhRDiXPH3V6HmcRMjhAlEJCcCWWmqhQQChCHr
 8FblxpzNh1kMNDfyTElkZp1OBXDTzMTjJSHhEnooamPeLMv99WtMy9xX7zZ7gqGChsxSjt4J9jk
 /HDuG0zf9wdrs1n5HCIK/AK55aWLoNbE9jiHlnYo+SAGHsE1XcZsTAiQg2URdDbDrU4eglT38Zu
 Wo+uPJuzmUAgz2Ok2mZSaPYzAXpSDu3d+ST2rtpEqyCH8p0hx8Zu+/135vGGJvy98WyAKRQkZdr
 iDsL3obveDo1CcwX4Kw==
X-Proofpoint-ORIG-GUID: K2uJngAkJ1mmHPalCr8JXkVYS79R48Cc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Priv spec says in the hvip section: "Bits VSEIP, VSTIP, and VSSIP of
hvip are writable.".  There's no reservation about hvip.VSTIP being
writable, i.e. this should be the case at all times.

The issue lies in rmw_mip64().  The function, used by multiple CSRs, is
filtering out VSTIP based on the STCE bits being set.

Make an exception for hvip.VSTIP.

Fixes: 3cb2edae7401 ("target/riscv: Fix VSTIP bit in sstc extension.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4593
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c               |  8 +++-
 tests/tcg/riscv64/system/meson.build |  7 +++
 tests/tcg/riscv64/test-hvip-vstip.S  | 65 ++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-hvip-vstip.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..82e315c56f 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -4006,8 +4006,12 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
         /* STIP is not writable when menvcfg.STCE is enabled. */
         mask = mask & ~MIP_STIP;
 
-        /* VSTIP is not writable when both [mh]envcfg.STCE are enabled. */
-        if (get_field(env->henvcfg, HENVCFG_STCE)) {
+        /*
+         * VSTIP is not writable when both [mh]envcfg.STCE are enabled.
+         * Note: VSTIP is writable via CSR_HVIP at all times.
+         */
+        if (csrno != CSR_HVIP
+            && get_field(env->henvcfg, HENVCFG_STCE)) {
             mask = mask & ~MIP_VSTIP;
         }
     }
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..b73b09781a 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -89,6 +89,13 @@ tests += {
   }
 }
 
+tests += {
+  'test-hvip-vstip.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-hvip-vstip.S b/tests/tcg/riscv64/test-hvip-vstip.S
new file mode 100644
index 0000000000..f89e3e32b5
--- /dev/null
+++ b/tests/tcg/riscv64/test-hvip-vstip.S
@@ -0,0 +1,65 @@
+/*
+ * Test if hvip.VSTIP is writable with menvcfg.STCE and
+ * henvcfg.STCE set.  See Gitlab 4593 for more info.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	/* Enable menvcfg.STCE and henvcfg.STCE (bit 63).  */
+	li	t0, 1
+	slli	t0, t0, 63
+	csrs	menvcfg, t0
+	csrs	henvcfg, t0
+
+	/*
+	 * write hvip.VSTIP, read hvip again and verify that
+	 * VSTIP was indeed written.
+	 */
+	csrr	t0, hvip
+	li	t1, 1
+	slli	t1, t1, 6 # bit 6: VSTIP
+	or	t0, t0, t1
+	csrw	hvip, t0
+
+	csrr	t1, hvip
+	bne	t0, t1, _fail
+
+	li	a0, 0
+	j	_exit
+
+_fail:
+	li	a0, 1
+	j	_exit
+
+trap:
+	# Any trap is a fail code 1
+	li	a0, 1
+
+# Exit code in a0
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.43.0


