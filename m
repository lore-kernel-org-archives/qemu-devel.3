Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dnyWPWqp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jR7UGwPe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHvJ-000655-Vs; Fri, 23 Oct 2026 12:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHv4-0005Rp-SD
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHv1-00028A-CX
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6Eib2215922
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b8VNFEOUdeLKH7/abdgQIZopNBDubsWT1M1wT73CMKc=; b=dnyWPWqpbeLYWnw9
 CPzOWNQDMJ88zmbXZO7gYMXK4R7nq5/8CcZdbiAN4UZpqiNXPrhKfs1Nc4azGQKs
 f9mP2GRi3+mxz0q9m+w1L8FIGOSCKwiQUJwuHlK44L37T2Nn1AFbsMoEl+9Oh9yw
 /r9wJItp1XRJtb97ZSSXc9xQl/i8I04uG7krwyxr1/XZzEdlPcM8Dxn3AsKQJzry
 t6wkKK07ktsKIg0+Jy9Y79o6aTlXi2vykb8o48fXTZlCq8qOkFx2kOmRqRmH1XsV
 gLxAp5Orx6CNl3H3VuNtojXXSDugtflhoUabb10b7lQLaQO73pDZ7St2X7KyJrdX
 3p1emw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc813t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f20addba1so201408385a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772097; x=1793376897; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b8VNFEOUdeLKH7/abdgQIZopNBDubsWT1M1wT73CMKc=;
 b=jR7UGwPeuIuEUvFoc5Slesqr7mrCHLlwTyYVsqQtTd/tW+aDb7VR4PiTneBgGHrlkt
 aSu8Tev6G127yCdX9xnHZMNiGSv8ELDYaS5M3fVpsO9Qqkued6Xg0lUMPDDeuiFKLYwZ
 XHh3h3Ei35OBwGwetcMiiSh8FWbM4aiLsB8OsR0RLN5YjL6p72bJ9tXv20tubpyxCCJL
 w+UpgtlSD0TdOQNYOYalOhB61vlzxI+0X9pTfW9OKmHpLj8vRwORvvuGTlji2ZHLkxG5
 cCnKVfBKxQGhpC5uoHQoifbWuqdj3pyu3U4kAR9STsi81M2Qcrfj9Jf0zdnMQ1CcMPSg
 qU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772097; x=1793376897;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b8VNFEOUdeLKH7/abdgQIZopNBDubsWT1M1wT73CMKc=;
 b=sENcU3/D0D8JH1ChwGY2XQun3HsPL6QNPmB8sbykRUN10ftvkS7u2uD4jCr56cKGdP
 2hl9A0i61NZMh0sCo/vw71S1sOxAVd/pa+Wecy8X7WbnNdRPGfgW41iiIp/cx4hvj5wu
 eXEVaTRla7vp3R8QD0C0iu+k+ASLwhG50QxePnxMvjlEwl7EhHhaJbsirW7Ayg8XEsqb
 KO8zTH2WtovPVr0EHbdvz7EM+OyGpxUmMyOcOgQJrHlG/lN+rebtJ0GhwY8MUIPHe4F9
 PJqggZJgXpFafWTGQb2lLGEF/gfl1jpBTqD+5EDH943f9KrZumnnPHhM4MsqJxjMmwN6
 r/uw==
X-Gm-Message-State: AFq9FYJ+rAOMRGtW/tnfYXSdqToZeB66fU2nGWECe7G2bgOJD6GVFmUk
 7yl9eb1MSj53Q1dX/Xbzh0uHACBAYdLfee4me8HhwPFQTW98tP6ov9Am73w1fwFGstAE2GZpr3G
 Q6SCK/iEL07mH10HVweeQ0TTqErixnMtwYkgajrfeh/lkLz5P3J9hGibgzsxDSfdWxvaL
X-Gm-Gg: AYBFou08m/RF8Plb+1v+OpBlAaaVQiFqbczCqH1TR/5PuA2QK2P/EybsBSrU7Ja99rB
 dAlnqkbZaX6MOQia8+r8v//+04rJAinBQHbxSF6VSX0AnlU05z/Cv8BOw5KJJvS0lV+uP6TzEww
 yZWfqlBJpWFXwbyba03nKUgFBbTW6KG6aQ+7SLWtSeEvaXMzgkKC6Cx81rCVNnuLb6MAcqnZ3pF
 2tnmNKnO2SQL4GCoukdCNDai47v+sz+Ru0kfZeBDySKdh8jrYcHkSsAG2rtHV4A9c3AGwhL1Qn9
 bdijpSVMHnuADmzpv2LMu4hDLAJujcvyo+UEnGz9GAFGyYNThxqxEbEJLLV/Qf5nVnXWoNNFDF3
 j2I3KmXh8uCW6M+ADdONnNgV+VfgsZtiPquJqe1+e
X-Received: by 2002:a05:620a:3910:b0:93e:c12c:440b with SMTP id
 af79cd13be357-93f6f8bc772mr531721885a.71.1792772096906; 
 Fri, 23 Oct 2026 09:14:56 -0700 (PDT)
X-Received: by 2002:a05:620a:3910:b0:93e:c12c:440b with SMTP id
 af79cd13be357-93f6f8bc772mr531718985a.71.1792772096465; 
 Fri, 23 Oct 2026 09:14:56 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3f0b8asm766783f8f.11.2026.10.23.09.14.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:14:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/83] target/mips/gdbstub: Replace target_long_bits() by
 mips_env_is_64bit()
Date: Fri, 23 Oct 2026 18:12:19 +0200
Message-ID: <20261023161332.60153-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX+fpnyEpVUvH+
 rOspz5L13Sx/i2cx8ZCCLH3pUbRCPtPsO+qeCmYF1l7zMTjpm8xvVrHsKFXKwynB6JwSy0+8PZQ
 17hZXWs+E59SgOZB+Km9m3XJQCCxQS4kxXuq0xLomJ7W6us7QoC/ZQWlQN/oAUJpq+wHwRp4ye0
 L1xqP2g8o3ArOJqeagG2xbf1XrOEHyq4oUWQd0R9YfVieY5q7DUx5WZHsKYpOHS2wS5P6fAyAb+
 +TdLAIZztOZaIp1T0uKrUgsJ8gus7L4m+mESTYuVod7EhgqxxD7hc3cKHLmFOQ24LIlUxEnUKMb
 ZximE/+pIWUjuM8WQzm0i9Gzs6wwQ8epRDnJgmneHRPwtSIlNulVrOC5uPwCTSTliD1ujUyNble
 224YzwF02iBCmMsfWju/8yTsxX4P8OlpMWdqqvtvIIrqs3T6sAJCia30yV8727TZthVqx/3ZfZm
 R2tEgubY55uS6bnJ0hw==
X-Proofpoint-GUID: h-clAmHodS1-8BARgE2utOmI_UD8K6Jo
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb8801 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=4t97mPZE8VEZQuOP_ikA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: h-clAmHodS1-8BARgE2utOmI_UD8K6Jo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXycuXUkMsL/ts
 /FEUc4jr5J8T1l/3YDuDXo/F+j+f/ADr/THZrEBhcVzuSD7VflTXY+prMRINAb0+f2c9m8h3I8s
 xTForM+Ya+RDcwp+ioBcWbtVNsR99UM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a mips_env_is_64bit() helper and inline gdb_get_regl() as
mips_gdb_get_regl(), so that the GDB register size follows the
emulated CPU model rather than the target build's TARGET_LONG_BITS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261007232326.66240-4-philmd@oss.qualcomm.com>
---
 target/mips/internal.h |  5 +++++
 target/mips/gdbstub.c  | 11 +++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 7dba22300b1..0c9b1335ebb 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -228,6 +228,11 @@ static inline void mips_env_set_pc(CPUMIPSState *env, target_ulong value)
     }
 }
 
+static inline bool mips_env_is_64bit(const CPUMIPSState *env)
+{
+    return env->cpu_model->insn_flags & CPU_MIPS64;
+}
+
 static inline bool mips_env_is_bigendian(CPUMIPSState *env)
 {
     return extract32(env->CP0_Config0, CP0C0_BE, 1);
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 7598aab6158..78d3e9a5b9b 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -24,13 +24,20 @@
 #include "gdbstub/helpers.h"
 #include "fpu_helper.h"
 
+static int mips_gdb_get_regl(const CPUMIPSState *env,
+                             GByteArray *buf, uint64_t val)
+{
+    return mips_env_is_64bit(env) ? gdb_get_reg64(buf, val)
+                                  : gdb_get_reg32(buf, val);
+}
+
 int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     CPUMIPSState *env = cpu_env(cs);
     uint64_t val;
 
     if (n < 32) {
-        return gdb_get_regl(mem_buf, env->active_tc.gpr[n]);
+        return mips_gdb_get_regl(env, mem_buf, env->active_tc.gpr[n]);
     }
     if (env->CP0_Config1 & (1 << CP0C1_FP) && n >= 38 && n < 72) {
         switch (n) {
@@ -83,7 +90,7 @@ int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
             break;
         }
     }
-    return gdb_get_regl(mem_buf, val);
+    return mips_gdb_get_regl(env, mem_buf, val);
 }
 
 int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
-- 
2.55.0


