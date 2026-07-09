Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B61AC44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 23:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whyGW-0004ts-P3; Thu, 09 Jul 2026 19:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whyGU-0004t7-Cx
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:34:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whyGS-0007Ri-Pr
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:34:46 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXRhn2422261
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 23:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fNGolF183Ykc3ikRZVV1o+MZTkAVJfEJh30XgScHIlc=; b=Ug36KEtjhHkNxquy
 JAZfxtdimarVKUeH8s7l6lfMzXM/W03Zs3Nxcq5ygr7wShm+S+UAdzfyZ+go7Wa5
 fyhrkiMFO1lEqXBm75B+gmLbV6iBboYhspj4PAv7hdBW0lgh5/JBWhDIdLt2NjTa
 Im9aq6NGatKy8ZgpokXRKGlyLaR99dxQZBzsGLt/gBct+hAYC0+6tvL1rgt5eWYw
 qSEBF5CYPjjzPhvAeE3i3hODyQq/ZW9SA7TJMIYhd5l73go3zIiPe0qkUZr58bFx
 VohHudZ6JNiNEu+3ljV3qXXz0BGeyRHD5ogUqkinhJ/oj8QNtZBUf7PdjgO/2i4o
 6v+a+g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvja2us-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:34:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-848590a507eso292556b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783640083; x=1784244883; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fNGolF183Ykc3ikRZVV1o+MZTkAVJfEJh30XgScHIlc=;
 b=Q8inSFCNpjzHi+s6zZvqpNqs2tybrY+gnIgPonAJoLiN+TtYqLwbEUS8cP9q3fd7h/
 lIP7ltOsebgBDlGc+FJ/h8ovvNE25UkxIXtXWx3F3xpsAQhr67inuMVFeit9yvixVvk0
 6Xl1JccuFWeMRqrSLwTfiHE7vFkSMgVx15QdrGJAi8KImtaFEZKZEP1ZllxpR5Z/qjQ0
 SaW2kArtpXbfB1JAK9lldM26cofbXQ+44YmtegR2TAVgJRWCpZuTTvn3wTwYtazCqhYV
 YagA/2EzlB5i1oyKHsxPIAmjO3Lv6+j67FvE7JmDqxk7kznwdzHFFJyAly8XVeUgr4Lo
 FQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783640083; x=1784244883;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fNGolF183Ykc3ikRZVV1o+MZTkAVJfEJh30XgScHIlc=;
 b=QfTc3xNLuAKodxmTl9umYffQYjRdGEyjN4mQvgQqtcJCDsoQs6gYJpt4AE4fHyFmYE
 NJk9PzUddBRTjN2mUnEumqkMhsuzrdDvTZq81Ml/hkeXB2QZZiQe8XyiEwrwa6Tyz3Ye
 XmvAwEAfFeZetHiMHjdL6P1JEG1oyLZkcvv7nH4cPoMvdCGK/dKBvAMQ9dfsS2FovitQ
 PyDF2oWPpqWqkBubthLiLZ4iwPI1fsXrfFxYL4nLmPtAgSjRuKoN1Zaw9ITAZRMgbco+
 WnGKW3M3ZrCtDM4x5ju2ezarNSruV8GUbjigaV1vxA22HESUV6XugM3sUOhoaFbfF1J5
 Z04Q==
X-Gm-Message-State: AOJu0YzCQtL1aWduyUVBhyPcO5U0rY44bkgS/Hq4Y2/Be0zUhwxxQxCp
 GuPrSXwCIxfuBWNfv7d68YtuYWW2rnvZM9rziKKn4Z2w/aHk0RU2l4aoSc/2s6QsZEP+8tIDW20
 dTcKLzJTlxPVSnYLYjuzMhCzU2lZMGd6nhzeB7UaMMxvg5aIn2uuweHquBZbAzKsuuQ==
X-Gm-Gg: AfdE7clIqEH6kMVKYAoY7gwGn4hQy3rPBcwyFJSSnRdK0p81ezW4VE2YrVbXlzBzt07
 aTC41dDXlNk/XIdTTB1MppUibr4VZd15vUklq3bVJ5RfkiomNZPvVGsJxgZbAuSTKbZ8RUapcZ6
 ciWn3W4bVzlnqGGsQTQet/X8NjsgIAFosQKbJSI25yzLOHZyxCUULt2y6fomfhLEy+5TqJ7Gzos
 XteM0C6Aae4W7NTzjjq15pCaPH/jFnG0dWEseqfaG5MMaHkhXfBGEnc4TnOyPLgCZa6YseD9HOt
 nud3Mkcu+VcSsYz6Y7OViEPkKXFUe1YWQpaDthKenL6aOQqwg0bH96UMhYfFOoFELDuvkFBEpeq
 DzKjqpp8PmaiH/NjsiK4iqPTQSDPfPaLtsvGVrxTL7WmAAXG+cVwDise+DwM=
X-Received: by 2002:a05:6a21:3393:b0:3bf:7994:ddc6 with SMTP id
 adf61e73a8af0-3c0bcfbbb8cmr12382738637.25.1783640082745; 
 Thu, 09 Jul 2026 16:34:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:3393:b0:3bf:7994:ddc6 with SMTP id
 adf61e73a8af0-3c0bcfbbb8cmr12382699637.25.1783640082240; 
 Thu, 09 Jul 2026 16:34:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm25447189eec.20.2026.07.09.16.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 16:34:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, matheus.bernardino@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>
Subject: [PATCH 3/4] target/hexagon: raise SIGBUS on unaligned data access in
 sysemu
Date: Thu,  9 Jul 2026 16:34:35 -0700
Message-Id: <20260709233436.3075100-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
References: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIzNSBTYWx0ZWRfXy3Ktvpdwgued
 9krEGwYBy49oHrIFjtfrajoaX5vMACWFAq6wG7czSb9Wk2gDYTrT6cbxTkXxT4+S6qHb6R4s+5V
 aYmMRaDpuGDhK63LlSF7cnXM//0KQrpdinS40nNzhDjALAFyJSwTtzq7I4fB04+woc2NrCut3Pn
 lswP19gWeNM1EsAVOAMx7G713sAxGM1JaLmBrVkpNr5RuXwESjsSuyRafL3y/l0D336wTFyjoYY
 YqvLNfSbQofIAZ6bBPIueoA30blrWW1KPlZE/eFsR/+cKallhobhLRC8mV+cStVUOP4f3AZbOl7
 kBLj3RQtDYOAjmxRDyPNfgWXCtYHojQ4/cJvIUyD7YC9VD81/42kXUVtJ5TRnTDpl7T6RQVUXQy
 c24A0OaxKgp9jvTGkkK1yI0ZhF0n1ccTX5ymJwruvfPTMvo3lc5sp1gd5r89LFrLs0ZEHwoLreP
 yflSQ5EM91xFeVYg5tw==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a503013 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=T1onTCyMlbt3cFJWPvcA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 2i8LaH8N34tWno87WVKmjanC8rsNmA4S
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIzNSBTYWx0ZWRfX+M8DukLweIzg
 P5UGlbJWCNuQFnM/DbJ7dDzZrih6JNG74RK24XEsXpRgqd/GjyaBo8QTMb72cCqNB+vWp/7+j3D
 XW5R1Q7vaRNhIzTroxFH7lxc8w9dCrc=
X-Proofpoint-ORIG-GUID: 2i8LaH8N34tWno87WVKmjanC8rsNmA4S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090235
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

hexagon-softmmu had no enforcement of alignment for scalar loads and
stores: the MO_ALIGN flag added by the previous two commits triggers
TLB_INVALID_MASK/alignment faults in cputlb.c, but Hexagon's
TCGCPUOps did not implement do_unaligned_access, so the fault was
never delivered to the guest.

Add hexagon_cpu_do_unaligned_access(), which raises
HEX_CAUSE_MISALIGNED_LOAD/_STORE via the existing HEX_EVENT_PRECISE
path, mirroring raise_tlbmiss_exception()/raise_perm_exception().

Also add a linux-user cpu_loop handler for these two cause codes for
consistency with hexswi.c's sysemu handling, even though linux-user's
own alignment check in accel/tcg/user-exec.c currently raises SIGBUS
before Hexagon's cause-code machinery is reached.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 linux-user/hexagon/cpu_loop.c |  5 +++++
 target/hexagon/cpu.c          | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 0958c51fbb3..d7f73439dbc 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -76,6 +76,11 @@ void cpu_loop(CPUHexagonState *env)
             force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
                     env->gpr[HEX_REG_PC]);
             break;
+            case HEX_CAUSE_MISALIGNED_LOAD:
+            case HEX_CAUSE_MISALIGNED_STORE:
+            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
+                    env->gpr[HEX_REG_PC]);
+            break;
             default:
                 EXCP_DUMP(env, "\nqemu: unhandled CPU precise exception "
                     "cause code 0x%x - aborting\n",
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 42d93e5da47..e2af736a99d 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -637,6 +637,18 @@ static void raise_perm_exception(CPUState *cs, uint32_t VA, int slot,
     cs->exception_index = excp;
 }
 
+static void raise_misaligned_exception(CPUState *cs, uint32_t VA, int slot,
+                                       MMUAccessType access_type)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    int32_t excp = (access_type == MMU_DATA_STORE) ?
+                   HEX_CAUSE_MISALIGNED_STORE : HEX_CAUSE_MISALIGNED_LOAD;
+
+    set_badva_regs(env, VA, slot, access_type);
+    cs->exception_index = HEX_EVENT_PRECISE;
+    env->cause_code = excp;
+}
+
 static const char *access_type_names[] = { "MMU_DATA_LOAD ", "MMU_DATA_STORE",
                                            "MMU_INST_FETCH" };
 
@@ -715,6 +727,18 @@ static vaddr hexagon_pointer_wrap(CPUState *cs, int mmu_idx,
     return result;
 }
 
+static G_NORETURN
+void hexagon_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                     MMUAccessType access_type, int mmu_idx,
+                                     uintptr_t retaddr)
+{
+    CPUHexagonState *env = cpu_env(cs);
+
+    raise_misaligned_exception(cs, addr, 0, access_type);
+    do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
+                       retaddr);
+}
+
 #endif
 
 static const TCGCPUOps hexagon_tcg_ops = {
@@ -732,6 +756,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .pointer_wrap = hexagon_pointer_wrap,
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = hexagon_tlb_fill,
+    .do_unaligned_access = hexagon_cpu_do_unaligned_access,
     .cpu_exec_halt = hexagon_cpu_has_work,
     .do_interrupt = hexagon_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
-- 
2.34.1


