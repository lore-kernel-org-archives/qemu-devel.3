Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA892606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XTIab7AP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nl4ZwIJf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI0Y-00015F-SJ; Fri, 23 Oct 2026 12:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI08-0008TE-OL
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI06-0002vl-T8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5wAO4063399
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /5Zc0y7WfdRouFj8DsBNduG8+Z0M8WHegrOziiA/Tww=; b=XTIab7APdfgi1v3q
 ExT/srvqOKvsHBAiacy3cxXawDMrndQHHLbGtyjocs6MhuNtZe+XHphkALE+weGb
 JHTzjZQm/zrZWgU6zSFTV3Qbu8/xevWb+mDD7Kjei36kZwQhXemR5no3QtpSuVdY
 rs6qMjRHF5oGH10Q9l/Uo7RAIG4OXUFkalr3Tp5h6EXp1wBAZ9hOe7v80pSiUVtJ
 psrbv7i4rMBSJ1NGiI8bFGN4/YSrf7c1R4KVVf4ApKJGJR6OJkTsw17ZjezvGWl6
 V1ETr04ULohJa59AJoQ9FIN4BHO2UEJ57jZaVcC0d1vBSjo9qx6esNKQtExv8Wf6
 HVuUPQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrch5a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ca9b53afaso320588785a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772412; x=1793377212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/5Zc0y7WfdRouFj8DsBNduG8+Z0M8WHegrOziiA/Tww=;
 b=Nl4ZwIJfQKp0LolYEJ4IHgWE4ME8tGElIGRMfv2x8dd7i2CMlPTgWxzb8wxqeVZk4N
 h/J20V1FaPOaKGg9WQMoK/RCKCcBjLOX1eRhdlczyQV19zbnLTrBrVogqhF/Rhvd6yoz
 q42tACdmoth/PPCT6TqD+UDrIPgj8wE+RqMH1K3BhN3qf9oL3px1L4gKPaMGtFAVz/cb
 BfgdMAauy8fHQYqOrRH3eMU6/l9lfOX58+Fyf51AxvGhU/I/Z8+PgNrh/TATEbwNvXNf
 b5XsvrzRFLRZC+pfdG+SfiQ+Y/iDWQfuXQ2XdRQGmwdwgQ3vwJWU/CzvELPshSasKwvE
 LKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772412; x=1793377212;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/5Zc0y7WfdRouFj8DsBNduG8+Z0M8WHegrOziiA/Tww=;
 b=XzYAWFWkMHIwUS2DiMcrVaA7b7i+JzAFc/atwcf631HxVJJfKb/cozVHKc5q3cTK+5
 uBamR/wxvwvPSncblvqjNsUpg8ZtVhCbdvjcL3/aVYPM6F5w3rzcF36lrxsBo3Qrq4SE
 +u/OxWXbJAt+T6l3FmzxM1t/7/VFtCZUyrix/8rLC3tGDS/hf7biUGbx6Kz0AMhno5EO
 gJIXgOoMGS/nQjXEvhdFkRIEqeDRRzzz4ShOCvHbx7kPupjQbFx7ytxRCKZv8bFobfi2
 4jFUA0SPfvmCtts0PN7OJwBXvtHjaNS4hqeKeOiTOz92tXi9mtFOGsLFwenpAJ2FfacU
 3UhQ==
X-Gm-Message-State: AFq9FYLfa8igLQ82zx11p6f5ifIpKu4hcpP7V/aPm1n0l286qIfp1nqi
 qAkxBwntDOdDGB0uheyQ4dgVg39i25U+2euAZXO/YQAWq61bwZiE6XUGdIx0Ml8lk0BFrsdZBxV
 QCj7ARSeEkr+vXQr2/4RllF9DK1YfLR8A8Iw9XsOGjEDtabmOy8Vz1KeA5NCjt7qcaC1d
X-Gm-Gg: AYBFou0XcttE5/mwDFs9pfu2ru7LuuL0dCEaAtmMdBoX24bHf372zS8VMRZ6AGmh18e
 rVmSizNfgM+gTGZO1JpoEYqbwynckUV0joS1lWqPZYX+zd1CS0BxOPzotO3PUEGhaklWhakX+X4
 m+IpI1FN6YzT/5oPiu8ZQTcod6QjB7wl3tz615BWe9LdrcKzvIchxgfMuMIlSzyHvl5qsZjuCqd
 Juy5Xm3a41wyG2T4Eodcd6TP3hU2rMN+dlI27AJu/ccIRr+jnnbFYsJM3T2RktlGqr2L+h7JzAF
 dSazRiTZCz4eEScQuB4YTVk+U/mSVWCZru6xGXq8AlYQJZpEPKQRslNBdxBceFpOolxzlB+B/Hf
 /47qqBPmyC2Rf/mPpkTPgvolom97iH1GLCRFPGb+u
X-Received: by 2002:a05:620a:4515:b0:93f:26d6:d70b with SMTP id
 af79cd13be357-93f6f787243mr516788385a.29.1792772412421; 
 Fri, 23 Oct 2026 09:20:12 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:93f:26d6:d70b with SMTP id
 af79cd13be357-93f6f787243mr516783685a.29.1792772411891; 
 Fri, 23 Oct 2026 09:20:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d4048c1sm709936f8f.29.2026.10.23.09.20.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:20:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 55/83] target/or1k: Convert to translate_for_debug
Date: Fri, 23 Oct 2026 18:13:03 +0200
Message-ID: <20261023161332.60153-56-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _0U3o-o4UiKcilHnB2wgCwBu9s2gxD9e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfXwI4ZppAVCXCX
 60OaY/oLE3hv/D7/HU5yEpTc6tEWwg6n4U+Z/8U860of0i512yF73O4QBdrfZM/4C4aeI4iXmsd
 6l+Z1tT2pHj6ewrPAfCuV2wxu5F9AmE=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb893d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=6LqkmPY7H80bW4kP3U4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX+/WKT6nMrR0c
 nbSgRWCJjRBwMIH5n3BXdAUJv4TqA5oc90WZBJq4eCLk0olQnesWIl9n2suhTPXhWIUTn3gT9vb
 rdec554YhQQ/xpmW7DJBHzn/igoS11tdU6iTc05crqHvOUlzcLfcAyCK6gUrcaR+CLP+ADd2701
 V2Y2qIBcw4F6i/5+bRFTQc/pKiy6gPH5L5dfr1ybdBolPs3T141RABdetQHw+pdybnuxYDsBU+W
 u6hxJIpguVbE7jgJ75flXoaFxPWFtghnA8foK0qjZS8T02Gvh/cMrJNMS1mBRClIvnW8SDTisFh
 mYvhMXakPrKuY6D0iWJ4brsIrDeE20HREu5saHsFZ//d2qu1KD+FWZBPPUG9xKxIaTbIiNgURAW
 NEr4Ev2z5MV2UiwvgwGWX4aUFy9njF0y0lilMaLrO8buLodPMHS14+vLPs6mpL4chsWVv9UZWhg
 dwMoPQnK0flxRD691dA==
X-Proofpoint-ORIG-GUID: _0U3o-o4UiKcilHnB2wgCwBu9s2gxD9e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
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

From: Peter Maydell <peter.maydell@linaro.org>

Convert or1k to providing the translate_for_debug method rather than
the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261020122752.3651914-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/or1k/cpu.h |  3 ++-
 target/or1k/cpu.c |  2 +-
 target/or1k/mmu.c | 21 ++++++++++++++++-----
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/target/or1k/cpu.h b/target/or1k/cpu.h
index 96ed1779fae..50a665eec01 100644
--- a/target/or1k/cpu.h
+++ b/target/or1k/cpu.h
@@ -298,7 +298,8 @@ void openrisc_translate_code(CPUState *cs, TranslationBlock *tb,
 int print_insn_or1k(bfd_vma addr, disassemble_info *info);
 
 #ifndef CONFIG_USER_ONLY
-hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool openrisc_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                      TranslateForDebugResult *result);
 
 bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                            MMUAccessType access_type, int mmu_idx,
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index 5aba8a42a95..8537d1a0326 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -247,7 +247,7 @@ static void openrisc_any_initfn(Object *obj)
 
 static const struct SysemuCPUOps openrisc_sysemu_ops = {
     .has_work = openrisc_cpu_has_work,
-    .get_phys_addr_debug = openrisc_cpu_get_phys_addr_debug,
+    .translate_for_debug = openrisc_cpu_translate_for_debug,
 };
 #endif
 
diff --git a/target/or1k/mmu.c b/target/or1k/mmu.c
index 3fc56e1b771..a78e8c8ca2e 100644
--- a/target/or1k/mmu.c
+++ b/target/or1k/mmu.c
@@ -139,7 +139,8 @@ bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool openrisc_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                      TranslateForDebugResult *result)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     int prot, excp, sr = cpu->env.sr;
@@ -152,12 +153,15 @@ hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
                             PAGE_READ,
                             (sr & SR_SM) != 0);
         if (!excp) {
-            return phys_addr;
+            break;
         }
         excp = get_phys_mmu(cpu, &phys_addr, &prot, addr,
                             PAGE_EXEC,
                             (sr & SR_SM) != 0);
-        return excp ? -1 : phys_addr;
+        if (excp) {
+            return false;
+        }
+        break;
 
     default:
         /* The mmu is partially enabled, and we don't really have
@@ -167,13 +171,20 @@ hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
                             PAGE_EXEC | PAGE_READ | PAGE_WRITE,
                             (sr & SR_SM) != 0);
         if (!excp) {
-            return phys_addr;
+            break;
         }
         /* fallthru */
 
     case 0:
         /* The mmu is definitely disabled; lookups never fail.  */
         get_phys_nommu(&phys_addr, &prot, addr);
-        return phys_addr;
+        break;
     }
+
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys_addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
-- 
2.55.0


