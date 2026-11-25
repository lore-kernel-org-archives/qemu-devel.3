Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31B606A332
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OyTVacQt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N+1ReFnC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCvw-0002YF-46; Wed, 25 Nov 2026 08:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCvo-0002VB-HT
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:06 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCvk-0000fj-IU
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:02 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mPXQ555546
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EcMWS94WxnX
 JWso/1bl4w2nn5/lvCpcllnV5sxWLSxY=; b=OyTVacQtcgnCbn/lyKbqpPpg8mv
 E4HhGZsO9mnjORBhTFdfW45JTv0o2utFf6adRdVWZVokWfUcG3LpGa3EakU0h5iP
 6NXmWjsvkKlXQAk51p6o2TugFFJru6wPUUdjZ6AMGxYqVXk5BpzMonlB02Qna+IZ
 vqx7YWXTB9Q8qdZ5nezAjYdSNuTUap5COYJgMHZVF18/ZhsU4gMQAmQwCkSJQTX9
 z4tz9zRulE4AUQ5OGWZkppZ5e8QYY87eLuYlc+X4FJVh+d84OlXTrICIth6PSi+R
 zWQoK4jl+Ug+ODnwnXPX6CTLGVzKA+pkzzWdJfPxnw4qHAoEl3f2/ySZanA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnrykb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:20:59 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91c6c1e082bso106995126d6.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795612859; x=1796217659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EcMWS94WxnXJWso/1bl4w2nn5/lvCpcllnV5sxWLSxY=;
 b=N+1ReFnCO2RfkIW/MYQpu+KEW5dNoHDOrhXtnKL5yMk1RCTBDAQf4rlJ3+xZW40h9G
 yrvcu+r3O98z/EmqtriSOze61Oec0f5JZo06pclCK/OdDlShSpUrg/J5owedxOuevk+e
 T4kK2TKbcdpgHcDqyIWRfcZ2FL8/xTOs+aiNpu0sOPK2+A434L/3Tx4Ah0kjBPLnF368
 r7EeElRCSjQezHkZVyH7odUv6c8PuyFZ13rDs5/nuvw9gauJLOvdQNo4YF9tSPpdPW52
 EUXZmR7s+aEZsUTo/mU3z3zmB6rN2qZ3cWucpiqZXibqiIrTDAR7KOlMs08JlGhdCfu7
 Eslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795612859; x=1796217659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EcMWS94WxnXJWso/1bl4w2nn5/lvCpcllnV5sxWLSxY=;
 b=vk2gQGWXm9IK+pgK2nnFKAoWVskNQEEmopx+UlFsn4JAl+sPvPzlytPv/Q70G0UY/q
 K8zmEeSGL39zNhoqXztPgHM0qrX4ZFCCesEfyz6NDlPkYcrTz3/EJ2fPHOCI+hMN/5D2
 LaRqjB+oK3T+dZNgcGZYk5u+mL1rMWi2Tk49AcL0HKUVdfTWpirstTEmBBmC7pAfFusz
 lMFbveYue62cZ+DX4iGBT3r5elqMPzg6z38TlE1FTm2SQYTwaPwfdFduJHnf0W407es8
 cIcLDPcx3B+2a8VeH+NJHRygyQXHKF4cJMcyp+HSHdoFvqgvbnwr9i2Z4zWiG6SIQjJZ
 lB6g==
X-Gm-Message-State: APuU4Z+s0O4ErdjrFZTiO8ngWY+sQR4n9byqo058x+Qmfa2IISHiLOjt
 tkAcKmvxElKDsbgxK0BmO20akCDNQeGYJQifJbjSSuVTpZb4wjvi6I+eKjrfLFEDtEJ7N+XaRRi
 Rlscy+0Ax8qR4ywvdmEfHJAqLiOxoFxXrhaO8A/4iMUEaOKhY0yQ8fUflWpmeYSd+fg==
X-Gm-Gg: AZFdTZf4W6DIcvVJFTMKo8AM3lY8VLb9boiFTDA9eqayBqr+xw6Rnp5+bkhtPH8GnUg
 akgaebO9/bfn+/wl0QjW6B6eH54JaM/Rj0W2/Z9LtY6jqStqGmzJP1OoJHErbQnyTjwCXORGjBy
 ehyF8PQRheaCYTuNa2If+OntyXmlAnUFC/6AHALhEIdkkq4mAKrlhNDmIpYXqhylx502a2GDuKK
 M6wCrc4NMb6svUMs9YxM0L0RBcTG3h6s95xqaOnITECcOJjYXjh50ACSAvWAsA5tEz9aV2lKT3v
 Nw3FNdvn01fFbHON6tpSCpH5XhBBTyDhEX3D1KTlj2OIHkw6LW9AHOLOYAchCx51k/9PyAJNgQe
 HugIgOtgaCwfmEjaJuYTrEHyXn6nsqjtEj03O6/q1zDhSjVQ7X1E5eTE4QoBH03NYSUVWMHv3dx
 UpklDp72YB/g==
X-Received: by 2002:a05:6214:3d01:b0:921:6588:53ef with SMTP id
 6a1803df08f44-92165885458mr107646086d6.27.1795612858914; 
 Wed, 25 Nov 2026 05:20:58 -0800 (PST)
X-Received: by 2002:a05:6214:3d01:b0:921:6588:53ef with SMTP id
 6a1803df08f44-92165885458mr107645576d6.27.1795612858340; 
 Wed, 25 Nov 2026 05:20:58 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm160836946d6.34.2026.11.25.05.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:20:57 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 06/15] target/riscv: allow hvip.VSTIP writes when
 (m|h)envcfg.STCE is set
Date: Wed, 25 Nov 2026 10:20:05 -0300
Message-ID: <20261125132015.229955-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
References: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MiBTYWx0ZWRfX3C72nkwF/Y9j
 oXgCTuwx0TBZ0UrxlvK1SjPJRoTXgNQGiCULddRkkcSxXdHV2qFRbzfmtsa9g9cYT7S+8p22YiT
 r0mo1NIG5x60IUbhBoi5+5TyWmI4hcRzJFhiYUB9UGV0aMyaVGa4T4R4r62JYvnYreXGoSMCEDs
 raQ3hyd7JQxNqJ+wNcOeEQo8lpuoORla+yi5l5KCgCJsf3LUWeGF1Fozj2WTH5pV6Ik6Vw8yqgs
 DnIsi4OvjxbZEOORnPAw2OuBc2R2sKEbfsZzN+KB/AzYJxJvuNGTSDXApk+03s6Kocg4BzLHzGZ
 NI7G43Y2cEXi9qiyjut2dgVutattx62JAw2fvtuSnR/vS1pSEsqXdZEj9zSgYYJYdZzwf8Z3DnE
 NaPadxpGEkLEvQKSnHJqfoWp3M4XezasSJ8uZ1DUY+z1dgNSfZtVmN3xChSoJAF1r+qgJNFPBNm
 aGArNvcMfv+LnJ+3WHw==
X-Proofpoint-ORIG-GUID: xLbojG4t8R4FvfRbVwI-70WrcI9dVRE-
X-Proofpoint-GUID: xLbojG4t8R4FvfRbVwI-70WrcI9dVRE-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MiBTYWx0ZWRfX+qyVPwPW9xqR
 /BvPSsFiprBlEzj4D0wgm57EfNcS8srYO5/jsm+STUWwu/KJYOIxHYfU5ZMbnFwx4ta8jp9yIep
 Qnjkuq6GqieYVDBdbbotudOZeI3fiVc=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b06e0bb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=M9ce6HhBX4SvkK6VDRMA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250052
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
 tests/tcg/riscv64/system/meson.build |  5 +++
 tests/tcg/riscv64/test-hvip-vstip.S  | 65 ++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-hvip-vstip.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 6989393bac..a715f48e01 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -4041,8 +4041,12 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
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
index 9684628014..87a26389ee 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -141,6 +141,11 @@ tests += {
     'cflags': cflags,
     'qemu_args': ['-cpu', 'max', qemu_args],
   },
+
+  'test-hvip-vstip.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
 }
 
 if 'qemu-system-riscv64' in emulators
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


