Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C76606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EjkKEe2h;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fA0F98ON
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCwE-0002hk-82; Wed, 25 Nov 2026 08:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCw4-0002cV-9N
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:22 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCw0-0000ge-HH
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:18 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mDTm3763932
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4e+LYFEBHvN
 q2airE7BwHREyHQTc+YyjmSq/kXaHRMA=; b=EjkKEe2howgJ3oLNlAaCRj+8IG+
 cRcFicWq6WUyFS4wme7m6lKKhD8D7A6Mniah7NXGjIWTB3wj9hVFs+sb/wYMtvmf
 MhDRHD/FpW1lUIb/vj/J+a/4MvxxVE3T+WxE9b/q0nOVvydDNo0mNuPnEz9HLhOH
 cnsX5YRmBnQXF/PKsqPk3nvwqyw8LiKBjwKjBWsCqtTEkIL0v2MtDHtXmR01Rq+q
 uzV4K7Y5tSMI8ed6XYHkZptuJ2nCs7UinrhbJG8TUTG4vcIusszZkNBIwO0fCmEL
 ZsBOj+gmSdXOcTxGft5k3xQUqHZ+pHRjyBpi0J1NIHdFnRWAWdm2yIDSANw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vv2ry1a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:21:05 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-99e0b2d9ba4so4533478241.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795612865; x=1796217665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4e+LYFEBHvNq2airE7BwHREyHQTc+YyjmSq/kXaHRMA=;
 b=fA0F98ONHcPqLwT0PoWrewwA413yvG7iR+X71HrVBdMiwUC/0oHIJvAtVmriMFhM2l
 VcjuXmI03kc6yv7QJy1hnPAFf6lQncb1ghItd5WtKjCFKJCh2BpA9prITvLoSMbSeqja
 IaQOM3eQ2vth4iuD5OgKFtUIXh4A8VOFspseF6lGqz61B5aXz0txf5eg5MCw3F7lA9aR
 +cQoiub+YvW0mDN43fTHWpLnd01fQ5LddJWRHx1v6kL9iOBIYY9i2UrEIk2HhHyIDKbZ
 g5BOC6y36bY3Mrtty6bqHkrqDiSMNRBjgvAOwdwfPd7npeSvQFSdnL0c8873Ycb2CLEK
 Z2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795612865; x=1796217665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4e+LYFEBHvNq2airE7BwHREyHQTc+YyjmSq/kXaHRMA=;
 b=M2pMx3UkBhzwu+NYcPHmJ5INvizUIY4s2G5gsKdyd4VrybIclFWuttxzM7XRh9RkC1
 KYYt/Q5IZOSJ+CkpswoGCQeDZ24Jr/4/hpP7sWcDAfgdpW6gIG36L+ot8uQPpLDYPWmc
 rWTkBwL8ME4MS3CHVpcO+vDnUCRnTxE7TZL64zX/Y+ohlFH3FWHWsmPXy4EIkHBEn3LL
 b9HluhThBq7x0+YpXZuRIY4hmh76pRYfJCs+EmTK4NAMwPpnV9RkyR9OjinaqsQ1dkf2
 0SGAtmhpOQM9sr4lAbwbQPrd7SxZB9n2x/mNy+sdmPhIZqZhDmxI0Gjjn4XsBZu/Ux55
 TCpQ==
X-Gm-Message-State: APuU4Z8HJy0ZjObvi8tj+NiifdD9dNS7nwX9qhvCyovKSrOIIoi1gyst
 ydNsR2uw7wo9mVBmjVjcetPiGiq6Y9f6FSu+ygIlFcesQkejADveetcji6C+a2gX1F3oJZ/zaPK
 TOi+KmaJpsWPEkbyKTKisZsmt0dy90DCB+yZo3VKtg9luYBrQ3d2bI62vy49iIRPTew==
X-Gm-Gg: AZFdTZfm1kUc9HSJPitsTlq1wlVnKFW6inNLRsCjnFEd38Ewwxrl065xYXRCn4OyL1Z
 qAU02EbeAZLh1pGoSSDL5uFFXGFhO0+ZQykSxPWMvfDRfaEVeKCheI6ScBZeuzzhr50WQSfMn+0
 9DRcWTcwyegf39+OJ+a8ycEjjUnJP75ZKnr34157h3sVPz4uUlno2LFWrw5aBAWNLNZfA/cYYCE
 wu9ult1ojA2bqnZ+NKYRHc/IRZJ0KMxzuIM17/azdPIlBjdp+xMQAHp3Peu8mj/zrIxnMOB937S
 u2bjyEEmp5EdQNzmYTPAoyJ+I2CbKLanyQkE5mRAW3y3wHlJuUuQJBU69UKWwEEojjw2t6GVUjY
 VqiYQjrbLNAKhC+v4/hEoJLzXLqbihkd/RaEDWqTvRI5/VPUAeLOhBWHn5A88iif6OD0pUsoP8R
 +NoHZ0CAFvlw==
X-Received: by 2002:a05:6102:26c7:b0:7d2:7be1:271f with SMTP id
 ada2fe7eead31-7d7395b6953mr10083230137.31.1795612864503; 
 Wed, 25 Nov 2026 05:21:04 -0800 (PST)
X-Received: by 2002:a05:6102:26c7:b0:7d2:7be1:271f with SMTP id
 ada2fe7eead31-7d7395b6953mr10083195137.31.1795612864023; 
 Wed, 25 Nov 2026 05:21:04 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm160836946d6.34.2026.11.25.05.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:21:03 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 08/15] target/riscv: filter out reserved (m|h)envcfg.CBIE value
Date: Wed, 25 Nov 2026 10:20:07 -0300
Message-ID: <20261125132015.229955-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
References: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfX2xvtoKf2iFs3
 VDUDjTfmsumXjC6POdBRX3vKhHuPfbyfYI53PKTnY+eTRHV+qemEw90Xo0E+cNATs3blUyb5hBY
 2nsfZmm5Re6WWDseKkOwa0y1NilHCqU=
X-Proofpoint-GUID: TY8mn0UrW1KxxbZNDjqywG-Y7lF0H0jE
X-Proofpoint-ORIG-GUID: TY8mn0UrW1KxxbZNDjqywG-Y7lF0H0jE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfX3wXbI4ijWTTe
 e5GeqbA2uQQcz6xAsghe1yGorGsnneu3aGt5oz7+mwlVour/7NlDhK9mcTJyowXH7ucDZxJz+xo
 Fxtb+UN9XCoeRE/ugnrEaFLdYVdTelXSvBZiS205Mcsd80OqZXcBOwtddAptOrUMwX+B50sddQm
 9ZLzU/JcF3vAZSVMHCpXth5SIBN286CVrq/LJpOsaJ72ZhaintaExjD+NtmR1Z6hi4VIxO+aGTQ
 QkddNapNhtEIM/l/j3BB/9ii2cO4j+khQTdWQlk2RwUDvkNJqG8TcTsPmm18bJJKFZY4mewDPzp
 D4UPGODghltSQr+8XmBA/Yd7o0pPOcut38H/uJicdAr0zNTQIy+KXnI0pkht6W4oJqz/cd3UGTv
 UhOKZkPpzfHOca2cFyV6MqCEF4R5Md9pgqBSRkL5tufkHAdMsjc480Znl3AwBKTjiaAUxyRoFNt
 fGQM66F+LHqhweT23xQ==
X-Authority-Analysis: v=2.4 cv=A/z5rKWG c=1 sm=1 tr=0 ts=6b06e0c1 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=ZgkQZYNTZRhgL34ysRAA:9 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250053
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We can't allow CBIE = 10b to be written since it's marked as Reserved.

Fixes: e979f6a15552 ("target/riscv: gate envcfg CBO fields on extensions")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4216
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c                | 14 ++++-
 tests/tcg/riscv64/system/meson.build  |  5 ++
 tests/tcg/riscv64/test-menvcfg-cbie.S | 82 +++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-menvcfg-cbie.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index a715f48e01..83eb44a590 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3431,7 +3431,12 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
 
     /* CBIE/CBCFE are read-only zero when Zicbom is not implemented. */
     if (cfg->ext_zicbom) {
-        mask |= MENVCFG_CBIE | MENVCFG_CBCFE;
+        mask |= MENVCFG_CBCFE;
+
+        /* CBIE = 0b10 is marked as Reserved.  */
+        if (get_field(val, MENVCFG_CBIE) != 0b10) {
+            mask |= MENVCFG_CBIE;
+        }
     }
 
     /* CBZE is read-only zero when Zicboz is not implemented. */
@@ -3613,7 +3618,12 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
 
     /* CBIE/CBCFE are read-only zero when Zicbom is not implemented. */
     if (cfg->ext_zicbom) {
-        mask |= HENVCFG_CBIE | HENVCFG_CBCFE;
+        mask |= HENVCFG_CBCFE;
+
+        /* CBIE = 0b10 is marked as Reserved.  */
+        if (get_field(val, HENVCFG_CBIE) != 0b10) {
+            mask |= HENVCFG_CBIE;
+        }
     }
 
     /* CBZE is read-only zero when Zicboz is not implemented. */
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index fd52d1e4ec..be9d892a95 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -151,6 +151,11 @@ tests += {
    'cflags': cflags + ['-march=rv64gcv_zicbom_zicboz'],
     'qemu_args': ['-cpu', 'rv64,s=off,h=off,zicbom=on,zicboz=on', qemu_args],
   },
+
+  'test-menvcfg-cbie.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
 }
 
 if 'qemu-system-riscv64' in emulators
diff --git a/tests/tcg/riscv64/test-menvcfg-cbie.S b/tests/tcg/riscv64/test-menvcfg-cbie.S
new file mode 100644
index 0000000000..324993d214
--- /dev/null
+++ b/tests/tcg/riscv64/test-menvcfg-cbie.S
@@ -0,0 +1,82 @@
+/*
+ * Test if menvcfg.CBIE/henvcfg.CBIE reserved value 10b isn't written.
+ * See Gitlab 4216 for more info.
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
+	/* Set menvcfg.CBIE [5:4] to 0b00.  */
+	li	t0, 3
+	slli	t0, t0, 4
+	csrc	menvcfg, t0
+
+	/* Now set it to 0b10.  */
+	li	t1, 1
+	slli	t1, t1, 5
+	csrs	menvcfg, t1
+
+	/* Read it back, rshift it, check if it's 00.  */
+	csrr	s0, menvcfg
+	srli	s0, s0, 4
+	andi	s0, s0, 3
+	bnez	s0, _fail
+
+	/*
+	 * The same constraints apply to henvcfg.CBIE, thus we're
+	 * testing it like above: set it to 00b, then 10b, then
+	 * see if it's zero.
+	 */
+	li	t0, 3
+	slli	t0, t0, 4
+	csrc	henvcfg, t0
+
+	/* Now set it to 0b10.  */
+	li	t1, 1
+	slli	t1, t1, 5
+	csrs	henvcfg, t1
+
+	/* Read it back, rshift it, check if it's 00.  */
+	csrr	s0, henvcfg
+	srli	s0, s0, 4
+	andi	s0, s0, 3
+	bnez	s0, _fail
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
+.balign	16
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


