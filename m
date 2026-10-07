Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1D4CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOLU-0000Xm-Tu; Wed, 07 Oct 2026 05:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOG8-0000SJ-Ic
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOG6-0000sl-5V
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:24 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jRGu118854
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hQZnoBXJG342e4Sm8iQo0p1Gum82bj7e2Kv/cLDTDeI=; b=HKVhgH5OZePlwVEH
 4/rZA38hZGyLpgD5iQIy7+DHGvSEBhzZoS7PQs9Z3btn4wb5m1qTD0gj0GqbAYiR
 6HQXn2z+G0Oebtmd0CV5OLOiMC3iFDC8btD27HyIp043UjUFZJ8yW5rGho9dz7VH
 9St45aNUp6lBGwlvMlr+UrAZjBqnC/lc/lFJQRwbJeIGihPGEpqUrBD07LmJd1Jf
 ZhmQfa4dRpNRGvA1aA764pQbV4Weo+rnhqkkSnfh1lKkVoehaSSezwBzuv0Q3oeX
 tHDZSlW41cM9C34xWcKR7qcsiXikzF2f1RMyZcXIbAAztIe150jx4mDOrewZZdw0
 YnZANQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc58w85-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:48:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so624636485a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366499; x=1791971299; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hQZnoBXJG342e4Sm8iQo0p1Gum82bj7e2Kv/cLDTDeI=;
 b=PEL0H5D8SlZMbT+ZQAY9ivJSVAumGzQVrRDFqklWws5eVy52HwIPWKgqdLY8Pl9KqW
 ooKYDr40h19MDg/bylpHUuM+hhx8XQ5uZZuaP78l705TtMPzo8kitxTivriyCDbVRsWv
 twCMVCXNYYF3Df1QI7Y5XNByxURlkNr3g9hha3DiTe3rpnTU2mm6MA6TziQOq1XQH3Qm
 v6qa7/PRj8wdhz/zS2u6vChBNcLd+pOjXOuKMvgDi92tIH+9ME5UZ7L7Qvph569ZQI3B
 xM4N8eqEUC8ffl5h8/BoZDmxg4jGHz2CN7mC+3HYa4wJhpoy72ncNbx+vYHF8yD7s0id
 qrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366499; x=1791971299;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hQZnoBXJG342e4Sm8iQo0p1Gum82bj7e2Kv/cLDTDeI=;
 b=KndDEdLJ9z4kyfBVMAJstOTxE0pusJZ7wIdsmr0ucj03Qe0GaYwQBZ+dUsqjifvFaV
 jK+Ez5k7UIS5lCv79fHOjOvgFwCjyKse27h/AYC1hPh4aDn5vErmDkl1ODI1In1aPFne
 EFeVyxYjTMMulKxFPoCzU53cPRPbZyk5sxtfQ2GqQKn0HVnPcYMoigKUSaNVykOrjHdB
 fe2krJHC/U/CdigWX65BDNjON6AUVwKehbqUUrQ1SuIHebwEDazfZTOUfCLyfnAVZueS
 IkvQQydpdn/oTcboEjPpK4zP/hIM0+geXLLprn+/E5kAh9+a2C7Jofqwcggz77mcJl3s
 dFJA==
X-Gm-Message-State: AFuF++l5agnZqFvf7qkz/aEfGBgfYZbHaiChwk3M0c3/7X0bjxxAiqcg
 7Rl44zrvwoSVr+tBiOFJZALt2CZQptZ1OyS2X+38o2JpC/bJBZoHUW5NpULvm1G+lnFwn6ha6+G
 oiq4Bfx2I9LhSt811K5aZsqc2zD8tym+gxov3nDWmTyNSiFG457cRw5MxO7N7rYkvA2UV
X-Gm-Gg: AYBFou2+AYPG+SVIlwddUmsKKuuGk4WTFUwzolVcBKO6JnAtXuEt1BRCT/NaIPNs+OS
 VtWfaCs+atUN9Yn1cJHWLYxUXq3GnHYwbCgrIApf1RVfqfiIvGMXzzlzurCTqKIXNQUDAwmWBm7
 fC4VWCqCskKB5JoR/TUtXfwZmm9gI0HrkMKTVpZy6h05j/EZhpKjNBuu76HxP6StoHt/q5r1T/G
 3ZX+PE6Sa/8BlFr98ksYsQIiM1xIiJDv933GU/eSq1/fowOAu/IFLeMd4yO89g2gD/XZe661fiB
 UOuSgL1XO5eyFazcjhIlARuDuC/BDUm6rRPZR2p3jKtvPm0yIgE00XkMwqd0+LspoatF9qdNBvd
 QKPm0bPeEPxAk1cU8MRctMTPYL1RlmdK3kzuFgPgG
X-Received: by 2002:a05:620a:4415:b0:93c:891b:90f1 with SMTP id
 af79cd13be357-93e860aa1e5mr1020848085a.26.1791366498682; 
 Wed, 07 Oct 2026 02:48:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4415:b0:93c:891b:90f1 with SMTP id
 af79cd13be357-93e860aa1e5mr1020845185a.26.1791366498207; 
 Wed, 07 Oct 2026 02:48:18 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1814ce9a0sm32269855e9.3.2026.10.07.02.48.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:48:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 25/27] target/sparc: Register CPUClass::exception_name()
 handler
Date: Wed,  7 Oct 2026 11:45:13 +0200
Message-ID: <20261007094516.75732-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXwyHngltHKu0T
 39PQOKh9HLTvRZvrnwG04eSCDd5aCJxa53aK3npwl8j5EnOLvWM1HVpNspsPKFx0IxgPzi25MaZ
 xln8UMFUcacHTRJ/6yXyMgozIQDjGz4=
X-Proofpoint-GUID: iV9kgb-TtZvm4Mbk2KgETAEtlcTOE74L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX3HJHgf5W0wiC
 6NtBlz1AKmV9+fukX+NFZYUyMneDUXW1QrD4nQpZJaXijCX12dRsIh+hZR0L3edDRiW2jKVmfXi
 ziBXuGyd/zBn0ofXccCVU30KadXCmM5bcQ0GDHUM2HFQE8B31rY0ZyxSTsESc58T3Z+lLqdTNso
 tLQhnNger/BnK49yiYdqTy8Fyll7uDJXrzlkY+mzaL+JADwOt3wjHdNqfSpf3bkWF7vGxiNkukk
 pPQZ6cRdiOpsoIwQgjDbG5HUqQHKjN7DHvZ6AQz2T9DiCIk+liDhiH+j7pxgBztr7q3E43HFi49
 GOw/cMq2+RcBGHq08D7ZXiyrisPW10g+L/03djBq+KTZrYie2l9Af/2tmIKYIvqWMiB7J6ELJDL
 rBbbR8FKTAo59lUXuvCtfQs07j95ZZ33FpgLUfIPZ3BrF8dQTDA/C37IMlXJRsmqY4KukGB7dZ/
 AJT17CT73xyHkNMoXbQ==
X-Proofpoint-ORIG-GUID: iV9kgb-TtZvm4Mbk2KgETAEtlcTOE74L
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac61563 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kEJbCHFcLIL5wbn19PYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

For each SPARC / SPARC64 target:
factor sparc_exception_name() out of sparc_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler, so
the common exception logging can resolve SPARC exception codes
to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/sparc/cpu.h          |  1 +
 target/sparc/cpu.c          |  1 +
 target/sparc/int32_helper.c | 23 ++++++++++-------------
 target/sparc/int64_helper.c | 36 ++++++++++++++++++------------------
 4 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 31a16c2af03..3c1ba223eb2 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -583,6 +583,7 @@ extern const VMStateDescription vmstate_sparc_cpu;
 hwaddr sparc_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #endif
 
+const char *sparc_exception_name(int excp);
 void sparc_cpu_do_interrupt(CPUState *cpu);
 int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int sparc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ae9bdca9df8..1f9a62a8c76 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1098,6 +1098,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = sparc_cpu_class_by_name;
+    cc->exception_name = sparc_exception_name;
     cc->list_cpus = sparc_cpu_list,
     cc->parse_features = sparc_cpu_parse_features;
     cc->dump_state = sparc_cpu_dump_state;
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index d6bb3fa1e54..2bb40d3905f 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -58,12 +58,16 @@ static const char * const excp_names[0x80] = {
     [TT_NCP_INSN] = "Coprocessor Disabled",
 };
 
-static const char *excp_name_str(int32_t exception_index)
+const char *sparc_exception_name(int excp)
 {
-    if (exception_index < 0 || exception_index >= ARRAY_SIZE(excp_names)) {
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(excp_names) > 0x100);
+    if (excp < 0 || excp >= 0x100) {
         return "Unknown";
     }
-    return excp_names[exception_index];
+    if (excp >= 0x80) {
+        return "Trap Instruction";
+    }
+    return excp_names[excp] ?: "Unknown";
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -107,15 +111,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
-        const char *name;
-
-        if (intno < 0 || intno >= 0x100) {
-            name = "Unknown";
-        } else if (intno >= 0x80) {
-            name = "Trap Instruction";
-        } else {
-            name = excp_name_str(intno);
-        }
+        const char *name = sparc_exception_name(intno);
 
         qemu_log("%6d: %s (v=%02x)\n", count, name, intno);
         log_cpu_state(cs, 0);
@@ -129,7 +125,8 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         } else {
             cpu_abort(cs, "Trap 0x%02x (%s) while interrupts disabled, "
                           "Error state",
-                      cs->exception_index, excp_name_str(cs->exception_index));
+                      cs->exception_index,
+                      sparc_exception_name(cs->exception_index));
         }
         return;
     }
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 10341e0c282..da5e214b11b 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -60,6 +60,23 @@ static const char * const excp_names[0x80] = {
     [TT_EXTINT | 0xf] = "External Interrupt 15",
 };
 
+const char *sparc_exception_name(int excp)
+{
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(excp_names) > 0x200);
+    if (excp < 0 || excp >= 0x200) {
+        return "Unknown";
+    } else if (excp >= 0x180) {
+        return "Hyperprivileged Trap Instruction";
+    } else if (excp >= 0x100) {
+        return "Trap Instruction";
+    } else if (excp >= 0xc0) {
+        return "Window Fill";
+    } else if (excp >= 0x80) {
+        return "Window Spill";
+    }
+    return excp_names[excp] ?: "Unknown";
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void cpu_check_irqs(CPUSPARCState *env)
 {
@@ -136,24 +153,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
-        const char *name;
-
-        if (intno < 0 || intno >= 0x1ff) {
-            name = "Unknown";
-        } else if (intno >= 0x180) {
-            name = "Hyperprivileged Trap Instruction";
-        } else if (intno >= 0x100) {
-            name = "Trap Instruction";
-        } else if (intno >= 0xc0) {
-            name = "Window Fill";
-        } else if (intno >= 0x80) {
-            name = "Window Spill";
-        } else {
-            name = excp_names[intno];
-            if (!name) {
-                name = "Unknown";
-            }
-        }
+        const char *name = sparc_exception_name(intno);
 
         qemu_log("%6d: %s (v=%04x)\n", count, name, intno);
         log_cpu_state(cs, 0);
-- 
2.55.0


