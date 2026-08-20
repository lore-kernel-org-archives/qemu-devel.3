Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61E9C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx9Ac-0006Fc-Pa; Thu, 20 Aug 2026 16:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9AP-00066P-CP
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:15:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9AM-0002LA-Ax
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:15:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7fv1587772
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E4Asvl4uLwcbAodqEq9ruJYyCPOIEYw9M6JfsXTVRG0=; b=kscPNHkv/YnPK8RE
 S4s9vj9eYf9FAT2+jcP8js2ETP4TlqthKsHJv4112H10Un/XfPrZQgWSz+6yukRB
 jgMg+gaJ24SPB5/DdJxK+a31n0hktzCLGOPrTGFluQlQlLY1i1/R2qNGJiUukQQj
 /UgZZgVlglZ8aYqfVdVK8lRbr5PwZuX/2PjyhJ1DfkPjemY3RxrsJYDHTE9OrGkP
 5rtYSeHUgSrBRXaLYwb1pxq63eNd7beL3BKrOttmJyhJSGOFT3HfoXwbIaA5VuQ3
 0YIG1+TAH8STLDwxkJOhKEIz7n8hAvvELfhjMWYDqhj6Z4PeK/sip1eVtl1vZBGe
 N2q2/Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg8asf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:14:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso4223771cf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787256899; x=1787861699; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E4Asvl4uLwcbAodqEq9ruJYyCPOIEYw9M6JfsXTVRG0=;
 b=R5ngahGRNs15fwnIPmN4fhnG3LdGzoNpvGSGddmbxgH+XEdhSGZEfwpkACdjvNBI9/
 2Nr12RavWml80OfDjkTJvsULYu1bbLpCSfOxtKzjIH94Th6NUkctkdBWg+1wCKpOF+YX
 YjbruiZDIRIF91Z+kvtRH9yQsFuomQIeS+q0wAHJAZ4YAc38s8X7pHOJ84oO+oIEA3rF
 9MCS75zuITqSLTRbXGg/NVRqcpqSUreC/0X7PXU7XRl+IeaDslYD9bNGhwXlvCA02862
 FoSbmp+o3E2KQdPTZR909F8XCS2Hmw72GGhpS7kR1k+zGYYMlvhiE8iTWiFpIpcXF23j
 AF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256899; x=1787861699;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E4Asvl4uLwcbAodqEq9ruJYyCPOIEYw9M6JfsXTVRG0=;
 b=IT7SqGmN8tMJRiI+eJ0Hovg6qS1lbuTzTbgSt+s7VWzVkrg0ZWIcw1rzUm0/uOz/r6
 UY7FoAJFSr6BMg3CtbNa4j8ub9wyC85tyNTVe5iE95au4XKwILORcU9OeZAYhTGYDX9b
 Eg2jWOA+EwAI77LMBzzXf41QQImmlgt2yWvjsOiA8bSEmwwgLshRRyZPC1AEp9XGAU9M
 QyoLcyMSQeVIrQEifRA1MzZEW4DNGyDn661Yp21zW6jsWPDqQJiVSUrHVBgTosFRgVpI
 a0IU9+bce6LKJOs8xhYJqznOLY2mUwwsgXDVSCBTA9u/xxFtF9wkrnhwcgfaHLJba5iI
 jNxg==
X-Gm-Message-State: AOJu0YxyVB2bowfB30Tgsp5oiYRb8dAiN8OgdNkSnhLBUQl7hvXqP7/9
 sQt5QgpCVFbI7d5NEaagNCQkOQAgmuE0fHSaAX5zoPJ6uXjLFXdKSiRsjwonLd2agL8duGqBOz+
 1kd42G5sspJ1B2Ftbn1ZHJCRgabK/N6H+YJG1iU4Tpuq/DuKZN1dWxyrsR/ouydBDFbLv
X-Gm-Gg: AR+sD13wR2c40MYbBexBTXE4+IdAF4igOn0hyYmnnrmYdrHS48EagRrlFpz04BmNpKF
 Y8c0i+n+d1y8gJmPsoWPD17a+Cb9KBP+ZxxMjql+z1R0KnGA90kdlxM72yqZNosj3fRJ/qgzPha
 56OMoqLRitJl2X7gQsDn53UbGrjGijLR96/d0Aq7vBJrPRheMXMUabPPBBgvIzUwOeWddcWWgK/
 8Tzg/WlSOTIg7VTiiZ8SSZrGeFCScrttNJzc7oJJt1AKO83ONhmb4dcf0YQEUOmFRvNAHLskwob
 j88pLNjQ8JJSVvSZ8yVeOeKuy5XCAH5GuqRcK3T0GasTB5Fwsvvd4mCHTPuslfoxldPnM5RH6H6
 juyiTgVq7aDfZhJJOSfGelqlYLVX0cXl+xzBVxPZu9Q==
X-Received: by 2002:a05:622a:a1b:b0:52b:4f1a:5fde with SMTP id
 d75a77b69052e-52df5864a38mr11139741cf.19.1787256898860; 
 Thu, 20 Aug 2026 13:14:58 -0700 (PDT)
X-Received: by 2002:a05:622a:a1b:b0:52b:4f1a:5fde with SMTP id
 d75a77b69052e-52df5864a38mr11135411cf.19.1787256894914; 
 Thu, 20 Aug 2026 13:14:54 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90d3046sm4287185e9.1.2026.08.20.13.14.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 13:14:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v2 07/15] target/mips: Constify CPUMIPSState for various
 cpu_*() getters
Date: Thu, 20 Aug 2026 22:13:47 +0200
Message-ID: <20260820201356.29775-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820201356.29775-1-philmd@oss.qualcomm.com>
References: <20260820201356.29775-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX7NAq7JskH+eH
 QBjWdG9w9LJxvQAb40ROXzgsizq2xeAOF+e1K91IVbutOQUhrEK/oRcWFPUNMKwbdaAMVlLdaq9
 RHicd8waGSj2JBb9qCZ9089VvPMMTW0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfXz1kwTG7/jvNO
 wNlEbehY3NoOq+5NM88487cwXOAQPRW6OdNYQpnOPLMwE7UuBP81Pwx+daT7NvduB41UoID3oDp
 N24BIjI8hsXWa+7CcDw13zUp8l0fZv+yxGOporO9oy8VysRpy9EAFLbEc9yO7j6ifhI7Or4Hb0G
 RBgEBv+TFg5UeW1XX+yH30rAd/h4ieIMXf/FPFJuouRXQaX4goeZ1G08EO5JJNGyuPGkjmCRD+T
 auDM+Bffd09aA+Ki1622ng09dU7KXS1FOU+eV9q9VbcsaRUVMNFJe5LGNYQY+BZbyxnzPdA/EXh
 P251JaHOtrflL5XasNdS/4hHtg22KqHk20v+zAa5KwXf7A3XNo+XJeAH7E4ibOwR8oC2BI575U7
 FnJXsjwHQsiYN7XQbq0eS7/YTe3mYW6lFiEycempRG/EdJUQcPwhcixJrZfnUL0RddYXcDfNy/F
 U8ThxIsYgnfAOHvJDhA==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a876043 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=OdUTIDwS7iTBxe5GiEQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: CfD1Aey-oCQ0CxAITH2lg_hUyFdQyZYR
X-Proofpoint-ORIG-GUID: CfD1Aey-oCQ0CxAITH2lg_hUyFdQyZYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200152
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the const qualifier to CPUMIPSState when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/mips/cpu.h      |  6 +++---
 target/mips/internal.h | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 319147a948c..6404b342a5d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1372,19 +1372,19 @@ static inline bool ase_3d_available(const CPUMIPSState *env)
 }
 
 /* Check presence of MSA implementation */
-static inline bool ase_msa_available(CPUMIPSState *env)
+static inline bool ase_msa_available(const CPUMIPSState *env)
 {
     return env->CP0_Config3 & (1 << CP0C3_MSAP);
 }
 
 /* Check presence of Loongson CSR instructions */
-static inline bool ase_lcsr_available(CPUMIPSState *env)
+static inline bool ase_lcsr_available(const CPUMIPSState *env)
 {
     return env->lcsr_cpucfg2 & (1 << CPUCFG2_LCSRP);
 }
 
 /* Check presence of multi-threading ASE implementation */
-static inline bool ase_mt_available(CPUMIPSState *env)
+static inline bool ase_mt_available(const CPUMIPSState *env)
 {
     return env->CP0_Config3 & (1 << CP0C3_MT);
 }
diff --git a/target/mips/internal.h b/target/mips/internal.h
index c5c286872eb..7dba22300b1 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -165,7 +165,7 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
 
 extern const VMStateDescription vmstate_mips_cpu;
 
-static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
+static inline bool cpu_mips_hw_interrupts_enabled(const CPUMIPSState *env)
 {
     return (env->CP0_Status & (1 << CP0St_IE)) &&
         !(env->CP0_Status & (1 << CP0St_EXL)) &&
@@ -180,7 +180,7 @@ static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
 }
 
 /* Check if there is pending and not masked out interrupt */
-static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
+static inline bool cpu_mips_hw_interrupts_pending(const CPUMIPSState *env)
 {
     int32_t pending;
     int32_t status;
@@ -247,9 +247,9 @@ static inline void restore_pamask(CPUMIPSState *env)
     }
 }
 
-static inline int mips_vpe_active(CPUMIPSState *env)
+static inline int mips_vpe_active(const CPUMIPSState *env)
 {
-    MIPSCPU *cpu = env_archcpu(env);
+    const MIPSCPU *cpu = env_archcpu(env);
     int active = 1;
 
     /* Check that the VPE is enabled.  */
@@ -281,7 +281,7 @@ static inline int mips_vpe_active(CPUMIPSState *env)
     return active;
 }
 
-static inline int mips_vp_active(CPUMIPSState *env)
+static inline int mips_vp_active(const CPUMIPSState *env)
 {
     CPUState *cs;
 
-- 
2.53.0


