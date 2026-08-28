Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3088C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05XY-0008VZ-CR; Fri, 28 Aug 2026 18:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XW-0008Uz-Jc
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XU-0005iY-Va
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:14 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTrTE3777095
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oBcV8PaCRFbb3XaTPgUCF9qM66A9X8ZOEQ/Mf6VcOo0=; b=mv6dwrKXVYov0lN/
 QYzx4oJxWOwCdWlU1ejKe5N+NA3rC3dCqKlB1n7mdcwD4tRDlo7bvUiaHhsGbbhC
 MkIhbGckfmNNEmX03p9BtjO4HOdFtwxkG1WcrtO0aT3n5z0EKRD6eQFGdAKfX2ac
 sc0qmDYJDfBudx2NjIr28CdD02FshTXMr1Ya1tMGo1UpzCpK4weh6v0it7oUbiKQ
 lk1O4fp/hPT1mfAGL5o3OZm84zN1znRaRdO4hurxm50DPl0yJEUL31DKLAshGtf6
 rhBUl2TacAcfYhI0IpnAcSIWWxLqYvDKEmTRxOlsoxBzJO0Wqu7FHYh1HN15TRod
 xquMGg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbj3er82s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so403103a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957951; x=1788562751; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oBcV8PaCRFbb3XaTPgUCF9qM66A9X8ZOEQ/Mf6VcOo0=;
 b=F/yy6oNF6GBK1AN0tY8TTUDXyLsvLiIRBHJ20GO6FfSahAyx9Iy8MAdTulVtltYJz6
 iUy2cx2bUDIbycC4tNr/MrQYN1IY5uP8TcHdbdSgNz5P15SCszHw7BdwpmosvgUdoxiX
 NeHnda+OldJv7GSEr95iBwe3TEMmc3YboAplOs5H3Zgp3hHl7TdF/uxmHVx2DymRa0nz
 0En29UAB6ZJSZW5NBFXvzdhXa509YqCCwuaKccvvi26vN/dUfLgyxuqGecsc8SXtaaW4
 W+wNVinVLtF5kDh4h5oSkgja5UfkItrrfqKVPpiLXiWGatAIo6Ypo1IOAboxuk/iM5UR
 bgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957951; x=1788562751;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oBcV8PaCRFbb3XaTPgUCF9qM66A9X8ZOEQ/Mf6VcOo0=;
 b=aTPnTlSvzZ9Fi3j4HMfFXinHOYD5q3su+ZbsXqLflKy2dC3GwY0Xk3hJLLifWvKt2k
 STTfklWbuduRJbHdSXeoNUt2Y8bdk+/AZdTW3fasVRopPtBM7qO6ekK+KxEOvvh3xWMj
 KQCDBgtZtX2h66MnVnwQ4KQ+WcMhajHnZY6X2AN0A7IF9E/gxEKv6cJblxEcry0SXI8B
 uCQqGctflnW4o7b8+FEWa5qBMCWS93bZF9VWEtzziJyvr9ipsQTR/95d2XpR5ui8GAgr
 eX5BsF1w6f7K0L5Qz+PeDwqthH6Wj+MCRD2bGtqfAdpiSmzm3bJRvUDxIbkQxJ7y+mcf
 dr4w==
X-Gm-Message-State: AFuF++kRWFipiBp/Fv9A4BaOPfJXk74iSV7vr0JQJS5R7kibvBeUEIX9
 WsFBizudNdNGtZpMI8SCVvVdBdVD182jp3dLe+TADhZ4XrVccDHDv1t1mb/92Cc0bERQWEIAZK6
 dlHWWQKXDhzR+3rBIDR2cqUX/XIhYRLZqq8659woXN2h7NDTGBJ5pZ1VSEkN2puFpFA==
X-Gm-Gg: AYBFou312VQ2qGvO1dsJ8orV87BiBuj9hw+ktnnGufLN7rWtZRdwX1NBVOSTYM+L/2V
 io8YIsgoHiWJTdSDx2ZJuY//Dv9aiCLyolssG6tcKmKPqQmYfkK+wDOe+vo0xLsbp/sAxiO6NIV
 YYW8Q/Z6FrLSC2dI/pKNsGfXoAta6lWk+QjlxacuSPa5voZYqs5bfafVpCet26UQAMafgzX1cN7
 uJebig/r98wKwolwxenkezArlE7H0lCdAmUIF7MVJOywcOp0Ldxf4/NiQygZzWp3jdUbfhiSaqS
 AVk3/duaEW3GVtQVEjgXNIBh8uUbsEEZhKR7VWvBlT7aFANnvfXqwEkt+lHa0AR4Mk/W+m5EKXt
 jF7Jx2OtvmXnx3SLdTHkea3JgYBjiTJ1d3fXvzmZWVRvmU2LPXkUqtIEwjxM=
X-Received: by 2002:a17:90b:2f4f:b0:395:c3f7:2895 with SMTP id
 98e67ed59e1d1-3969babafb3mr23134507a91.7.1787957950777; 
 Fri, 28 Aug 2026 15:59:10 -0700 (PDT)
X-Received: by 2002:a17:90b:2f4f:b0:395:c3f7:2895 with SMTP id
 98e67ed59e1d1-3969babafb3mr23134478a91.7.1787957950370; 
 Fri, 28 Aug 2026 15:59:10 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 05/47] target/arm: Use -cpu max-v8 with aarch64=off
Date: Fri, 28 Aug 2026 22:58:19 +0000
Message-ID: <20260828225901.367438-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MZ0WWPStO5Z8Qcfrxy_s1RT2XV5U9wGf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX9b3l+zxV18Yh
 cigQh+8lM6mszv+WLHvOOHl3Y3krAXBmVr4i7ateW767dcenLw6LMPmbJ+MpKOdnzUWZMgquA3Z
 TbZlQOdW4gD5knEseidqef5N1Uq++1ZMJkmhnn7YWWpZCnddsfXQxqX8QRUzoKfPo5nfeksDs3v
 GTXOLvthch5GlGjFZY97Og9Dvm28AoFp2nCzRJC5LH14UpAgKtyWw+jPq9QATs0vgcDakbQMEsT
 FIZ1olEO/8Faw3uGLBq/qXycPS06xibLLouXQDziGg1/Rf1yIyrd23ds81Zn9kwyghoddOuN85r
 x4QzSaYG4OGPhJS09/P7I28LaSE+rJaoLKuf6SbQFexE9oO28JRHj9m4sZ/4Vllqr6PxXTvq53i
 kxk15DcrHgDQJsFMHDzWSNnwZpGLE4EoYqX2CKajaMG0sfmsMOpq7FEtdinahhfr+P2m9XRFau1
 xqw9hjcwx+vgMWjp10A==
X-Authority-Analysis: v=2.4 cv=QLVYgALL c=1 sm=1 tr=0 ts=6a9212bf cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=QnPuJ91tA4QMyvGEi4oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: MZ0WWPStO5Z8Qcfrxy_s1RT2XV5U9wGf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX7T0R6UKToq/J
 P4WWZl0JFHTimHRymK0WFNBYVoSquMnOGENmm8eArDvnPpUEnGHs7BQHm77hRVU2cMzvGW+lxTj
 vHUZ1NBg8nDbLLRHQB0VCTx7tTRvvpk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

From: Richard Henderson <richard.henderson@linaro.org>

Armv9 does not support privileged aarch32 execution, so
aarch64 cannot be disabled.  These tests must use Armv8.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/functional/aarch64/test_virt_aarch64_off.py | 4 ++--
 tests/qtest/arm-cpu-features.c                    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/aarch64/test_virt_aarch64_off.py b/tests/functional/aarch64/test_virt_aarch64_off.py
index 13d8b73b0d7..73c9a4109c0 100755
--- a/tests/functional/aarch64/test_virt_aarch64_off.py
+++ b/tests/functional/aarch64/test_virt_aarch64_off.py
@@ -18,9 +18,9 @@ class ArmVirtMachine(LinuxKernelTest):
     def test_arm_virt(self):
         self.set_machine('virt')
         # KVM aarch64=off requires a host CPU that supports it, so
-        # restrict the test to TCG only
+        # restrict the test to TCG ARMv8.
         self.require_accelerator('tcg')
-        self.vm.add_args('-cpu', 'max,aarch64=off')
+        self.vm.add_args('-cpu', 'max-v8,aarch64=off')
 
         kernel_path = self.ASSET_KERNEL.fetch()
 
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index cb4d01fd46a..7348fb8d28b 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -493,8 +493,8 @@ static void test_query_cpu_model_expansion(const void *data)
         sve_tests_default(qts, "max");
         pauth_tests_default(qts, "max");
 
-        /* TCG allows us to turn off AArch64 on the 'max' CPU type */
-        assert_set_feature(qts, "max", "aarch64", false);
+        /* TCG allows us to turn off AArch64 on the 'max-v8' CPU type */
+        assert_set_feature(qts, "max-v8", "aarch64", false);
     }
 
     qtest_quit(qts);
-- 
2.43.0


