Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA56DC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wls0m-0000Dw-IQ; Mon, 20 Jul 2026 13:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzU-00080c-BJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzS-0002xT-Cp
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KHBrj23442628
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ws4CN89UUGq
 Wa/bbUghhSXHktZXUdVMHQTmzZsGomuo=; b=RoYvDfKCLFlSd3bxZR5fBSnQ3VR
 e4SYzXJE5rcxugeNcplP9NXChsHibFqsA0tix18fpgFn/krO0NBg5/DLyh7y1EY/
 wM9dMcAr+qgtIXaociiaXigGxQxq4WvQKyLHlF8IcXGj0IebfXo2CrL/jz5wQRc7
 7MRcMaTsBVUsERZrYIeillgTPlwdJEyCZoy6nMsIM5+G4koM7JbdwEe376Dgwoev
 Wlk+1QcqdS+4DMClqxOM7AlKi1KqnsoI8iAA5YYM4UBlnSUhItRxd2waWrv0/HCS
 4XQ3F2LGC2JUPwrRMGrHZJpTURtTmljylvmWpoQdZ87sMZ3ESrRNxaSqsNQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5r46b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so5419871a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569276; x=1785174076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ws4CN89UUGqWa/bbUghhSXHktZXUdVMHQTmzZsGomuo=;
 b=VEA7SPTELEXcUP9K7pOB3ryDoQ1jQXcZHsB5obDYJNAhi6C9EeDb3Acce0T3fhVw7b
 944qL3/c8jHeKM+lQq1rISuwkpT5J/jdv/yXeVYCgcde1XMlJ4x5/DvSQ60kSdBYCYSI
 A/2etn3+rDgJCOaCIcFfi69mFve4rNyh0d98vygWRxHuSmwQbUYxz4jBOf35GCjtVoh2
 KbH8DS+8+v6vUl1lJpvFHVTVVMWT6ELDODHgJh2u1EFS7bqHbUba1f0iKxv1AuYFHvKX
 LuR2PMxL6cmhFNWnl3Tr8DOrIwWrIhlignxxl4ufGPUkz6WRaSGRXRUU/rRJEMpjGQjZ
 xibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569276; x=1785174076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ws4CN89UUGqWa/bbUghhSXHktZXUdVMHQTmzZsGomuo=;
 b=XHqGxfaqVbzEw+0+dW5BEoSnu1m4SD70OLr667SERU3AnJMko+pS8jvdZZhJt3H7Jt
 rYzqj5ZAlwSRUboPq1SQm/hWhTJacNZiRhqU/sBdmUIsVgUzmM6LLUlO/gBXJPb3A9vu
 m3i7LnJJEIpxfy6i/TEEYd85DZfj/4siYbEY/0QipB1/gVQof6DZ5lokJQnv8FTQrjV6
 dVOo4fYMWs/coIOk6/qqKY6YNdOpqmK7gTSzTSkNp/X4E8oPkUT3WfnJ5jPIlwwSgKfd
 DLoCv0ZHNuQDHNbrdnqzyUT95S/tEusTbrQwPk4lPoPArTlh/2auzE+I8G5s0ygjtOv9
 AZjw==
X-Gm-Message-State: AOJu0YwNb2EJsJAcUlHnGREo+uwXKkSInt36IPSZkmYj4lnko0+NAq2X
 kCyetiphonv63QW0+hY8eUR/XjnuPcih4NzNtX2sSp9x8D1Ny4zRiUSIS9Pm2lctVNemL12h8WD
 yNRYPCr866vCD4xH/y8eeSZE77Gi/HQNIPnXzLgDDr9i94wKolYiS1BiBTavUvw4rLA==
X-Gm-Gg: AfdE7ckzLHQgEIi8emDz8YDsfxH5SEJM3MC/lynrOGmwT8P7aPMO8xgAOUfembf9/8+
 nDWFSDBL6tLTb4uF7R+a0EUHQIcuaO7zOaaK2mcLyE1OtdsPc49hPcZEpiWgNySeKaoL7jizhpJ
 1YMSyjpWS9oT73efzy5Ui+uuhO6weIU3Za1s63SjU8a2asHFhjhE9rpwXGQtSE0Qe60MvKYBK/w
 yr9R67XcRBmRDeVQbbzsWi/lryVXHidSloRu8r0Qa48Y4FYP83LejA7vn6Lvh4+7nZIp5iOBJ+v
 TSWtUeleI2JKSUqODhJgy9abxZlPbhElCTKQVOb28uwNXsAb/FxQBOHqmZY2IvuRJ+pduRX3x6j
 zh9AUFEpmF2+KMERxa7t5yRAx09a7JhOP2mHMtzcItjGyhJjMuIf2lFUvQ+TrGTk=
X-Received: by 2002:a05:6a21:511:b0:3bf:ab4b:2d34 with SMTP id
 adf61e73a8af0-3c3ad9dfdf7mr16508803637.53.1784569276019; 
 Mon, 20 Jul 2026 10:41:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:511:b0:3bf:ab4b:2d34 with SMTP id
 adf61e73a8af0-3c3ad9dfdf7mr16508754637.53.1784569275322; 
 Mon, 20 Jul 2026 10:41:15 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm66281257eec.21.2026.07.20.10.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:41:14 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v3 04/13] hexagon: cpu_helper: add reg reading/writing helpers
Date: Mon, 20 Jul 2026 10:41:00 -0700
Message-Id: <b02e7a60814d97b1a259718daa3199f01dcac45b.1784568922.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX1UdnW76+bLU2
 55nhr+tDd3mtKjNm9InN2lkwN0ypkJy52fBTiRHawzDvyofyLPD6qweNHJCSBTowTFvr7UgU9o8
 fMqLQ299sIYIjTqwlObBp4JglBLOKh+C4qrT7pY8la44OrEqWNQhS8TfHX5wPBL3GYmB3v5sMXo
 oeAFN7kmea6OBQywwl/HBt4W+l9uEI2/c4LjkFED49xBoEm/g+vt8A3BgaxKUURU53XK9PYOXgQ
 zERsBAvmYbfnNgHcM4ULW7P9nPmOwwJrlBfrFMPhZEB0ZawsYWLJAbiO+Jzsd47qUHgDxQ5WCN3
 SUuuUxym0NY0DzlboxK3pyaaue5DXnHNiHG7lp7ZZiDMxxgWzDl8/OyD6+vOm/xRR4O+pfNgO1l
 /EdtOfwhcmyuLWONKTsFQJFLtIf64EnwV+mnBUgQ3eGfDBuicjZmCpeO8ueH8jCc2z+YK7A3iRq
 XXcGRkuxit0qek4GEzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX6mySGdv0NgKw
 ZVSu57LMXiBPte09YtETkFkkJFx7vyqny+K2Cfm20j73NWa0oNSpI+a5SPNWfigdVQ5GoIOOhTg
 rOw/cy3kWFodkRSGjxFKEgTs9r6SqcA=
X-Authority-Analysis: v=2.4 cv=WNpPmHsR c=1 sm=1 tr=0 ts=6a5e5dbc cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=nXchshz6agspm-bXmVMA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: qxZb7qHxoiJwlL5IHTNDR9hiOblCBWPU
X-Proofpoint-ORIG-GUID: qxZb7qHxoiJwlL5IHTNDR9hiOblCBWPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

And adjust op_helper to use those. They will also be used on upcoming
semihosting commits.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu_helper.h | 18 +++++++++++++++++
 target/hexagon/cpu_helper.c | 40 +++++++++++++++++++++++++++++++++++++
 target/hexagon/op_helper.c  | 18 ++---------------
 3 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index ca2e13ab1d1..757a49fc4d4 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -7,6 +7,24 @@
 #ifndef HEXAGON_CPU_HELPER_H
 #define HEXAGON_CPU_HELPER_H
 
+static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
+                                       uint32_t val)
+{
+    g_assert(reg < TOTAL_PER_THREAD_REGS);
+    env->gpr[reg] = val;
+}
+
+static inline uint32_t arch_get_thread_reg(CPUHexagonState *env, uint32_t reg)
+{
+    g_assert(reg < TOTAL_PER_THREAD_REGS);
+    return env->gpr[reg];
+}
+
+void arch_set_system_reg(CPUHexagonState *env, uint32_t reg, uint32_t val);
+void arch_set_system_reg_masked(CPUHexagonState *env, uint32_t reg,
+                                uint32_t val);
+uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg);
+
 void hexagon_read_memory(CPUHexagonState *env, target_ulong vaddr, int size,
                          void *retptr, uintptr_t retaddr);
 void hexagon_write_memory(CPUHexagonState *env, target_ulong vaddr,
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index e981e11a35d..98ce599571e 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -27,6 +27,46 @@
 
 #ifndef CONFIG_USER_ONLY
 
+uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg)
+{
+    if (reg == HEX_SREG_PCYCLELO) {
+        return hexagon_get_sys_pcycle_count_low(env);
+    } else if (reg == HEX_SREG_PCYCLEHI) {
+        return hexagon_get_sys_pcycle_count_high(env);
+    }
+
+    g_assert(reg < NUM_SREGS);
+    if (reg < HEX_SREG_GLB_START) {
+        return env->t_sreg[reg];
+    } else {
+        HexagonCPU *cpu = env_archcpu(env);
+        return hexagon_globalreg_read(cpu->globalregs, reg, env->threadId);
+    }
+}
+
+void arch_set_system_reg(CPUHexagonState *env, uint32_t reg, uint32_t val)
+{
+    g_assert(reg < NUM_SREGS);
+    if (reg < HEX_SREG_GLB_START) {
+        env->t_sreg[reg] = val;
+    } else {
+        HexagonCPU *cpu = env_archcpu(env);
+        hexagon_globalreg_write(cpu->globalregs, reg, val, env->threadId);
+    }
+}
+
+void arch_set_system_reg_masked(CPUHexagonState *env, uint32_t reg,
+                                uint32_t val)
+{
+    g_assert(reg < NUM_SREGS);
+    if (reg < HEX_SREG_GLB_START) {
+        env->t_sreg[reg] = val;
+    } else {
+        HexagonCPU *cpu = env_archcpu(env);
+        hexagon_globalreg_write_masked(cpu->globalregs, reg, val);
+    }
+}
+
 static bool hexagon_read_memory_small(CPUHexagonState *env, target_ulong addr,
                                       int byte_count, unsigned char *dstbuf,
                                       int mmu_idx, uintptr_t retaddr)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 3ce223caba3..324a9632dd4 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1846,28 +1846,14 @@ void HELPER(setimask)(CPUHexagonState *env, uint32_t tid, uint32_t imask)
 void HELPER(sreg_write_masked)(CPUHexagonState *env, uint32_t reg, uint32_t val)
 {
     BQL_LOCK_GUARD();
-    if (reg < HEX_SREG_GLB_START) {
-        env->t_sreg[reg] = val;
-    } else {
-        HexagonCPU *cpu = env_archcpu(env);
-        if (cpu->globalregs) {
-            hexagon_globalreg_write_masked(cpu->globalregs, reg, val);
-        }
-    }
+    arch_set_system_reg_masked(env, reg, val);
 }
 
 static inline QEMU_ALWAYS_INLINE uint32_t sreg_read(CPUHexagonState *env,
                                                     uint32_t reg)
 {
-    HexagonCPU *cpu;
-
     g_assert(bql_locked());
-    if (reg < HEX_SREG_GLB_START) {
-        return env->t_sreg[reg];
-    }
-    cpu = env_archcpu(env);
-    return cpu->globalregs ?
-        hexagon_globalreg_read(cpu->globalregs, reg, env->threadId) : 0;
+    return arch_get_system_reg(env, reg);
 }
 
 uint32_t HELPER(sreg_read)(CPUHexagonState *env, uint32_t reg)
-- 
2.37.2


