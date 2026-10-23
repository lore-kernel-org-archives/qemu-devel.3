Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91190606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HO8jB1Jq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zb4ZWyiD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI2q-0006Hc-Sx; Fri, 23 Oct 2026 12:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI2k-0005wJ-5F
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI2i-000395-Cb
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG3ld92931048
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jBbNY9oPYF73vu93PC0fHmlndFzvdOwBK1juP50uIZo=; b=HO8jB1JqPIxXfN5k
 KPf0NXWWDsAiFBrKz3LFhSbeKU2bT86v9AfG9wO4FVlMrf3KAJCoL9QuzOcoxuny
 46f++SfIW6IdY/ejY6rY7SBu4S8DQtPjH1NBNXLgxg2NBKg/3xeU7CRN5t599nDX
 bAIrLryEfgVJ5k3oTG5nPgWiNhHl0i1BR0halpJNztoEl7q/plUtw/HO25snbeIG
 1FIAwfDiM0FSPSwDwOWZzrF0gsDKwUrsYzenNSzAPl9I/Ev9clwaimr6yLi7/8Z1
 B64KyEgOgaL6YoWNwj/schpXFV4R8gh1yn5URuAT2N0nLmq9jUerhwfgzJUDuRbt
 nBpFGA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas6r2at-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9308eafb465so309140285a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772575; x=1793377375; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jBbNY9oPYF73vu93PC0fHmlndFzvdOwBK1juP50uIZo=;
 b=Zb4ZWyiDUzahJSlxE/ERzWcNEHfERv9ice/OlYPHmoYt7A0x/4+sIDScm069SjW0dO
 cAJhZBBPTwnMUjIixZi9fAgReYaLQ4BN/W+jYDFJD00Hl4O+WrHh+g0tASVGxJfz9dt1
 0b+OclctSiRd4g12yNARk5YSushMOoEP8BC6OK2WaRd+rTWeeJdgm38hEHY9YBH6cUZQ
 rb6MIFn9pLoOlyQLPt/rkJt/V9oblG4HeYov2WoWwu11g5RzncWf3aKtLTjhxmqidbWI
 Bk7wzGCCixUe7uWAt2yHcgqgJ9SPEs3MHdukgN/z4fcpnKyeWvqkQhaUEng1Ib2pVvCc
 0q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772575; x=1793377375;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jBbNY9oPYF73vu93PC0fHmlndFzvdOwBK1juP50uIZo=;
 b=rVRlenqLVsseFLgOgqDBcQedg0M16ieNvHOlPvmTs2Ae7+xoz4ST2EbmNI39NfIGrq
 1E3ZenoP1aHCqssYCHD3fJE3hs9FllufdFF6sxnHjzBkAxrqy5GIkQj+f6cdEi5RZ/eR
 l2vqPymbULzctOMzqxNBrMLOSnRBfR8g0WSgeyopOvftYJ5vznOC5pddn2O6P3poL0eJ
 Sn+RGEvzgqOTY+KXYGy0dp+/yEoz38y53H1xi5E+24rjK8QwjCDwr4dCig0Ob60g1NFO
 NmmvcGAoiSyChiMNAj4Tw0A1XOOZ3Bj9gp1VViVVik8rTR0pQyXaxflBFbx6UiNVVKID
 XCog==
X-Gm-Message-State: AFq9FYIUxD3DV8UwsmZhYGLkmSXE8wer1hDbW+H92DIjNG4OEsnIIiw2
 jeJwkvDNFCt/2rhPP4h8Z7kZ/XjKOtnTHVZa8dC7DcNG6Y9lpR+ZcGMgW9fTwra/5l9B0d4EL9D
 M+ykLUOW+2tpn13ZngPTGiXjh28HL4YZnx9qsaPKNW3yKuT8RNONCz9LOxtgVXn1YPFv5
X-Gm-Gg: AYBFou2K9F50KNr22KWD0tCjocVO9StlBDx4HWJdsZdgvM2z0pu4wRQPyvkcL2qVBlC
 VRg2RXfbTpJ2hnjVTuEIBBKhoFvihwj0N/G4z0/3fLb9FcQDgwoWo3rA/hBIMAifmL61GFUNnJs
 Xds4EB3IKax9KXCVXOWyUhEOL14nO3z6+9Dh3Ng7EjNYeZs3Oba/3QIKprXTKwZebVSZNR1hHz1
 00ZjysCZEO0f5aY2qUDJsM5A+StgDovPaD4qjfP2iq1rgkWuBf6Ib+4Dt+mgQmxlX9SzgZpU/M4
 MvvwkU9FMGYJOGgEXjm4Wkdk6Vf74oQ3JC0bhDFyzPssTMxs0jiTVpBu/ZT5zXodAuQN7XL2gaT
 +u28I+i3S7JP2IsAEk2lthVvgtyb6T7vKy94jVSPm
X-Received: by 2002:a05:620a:4712:b0:93e:869c:43e2 with SMTP id
 af79cd13be357-93f6f9a2bcamr507399485a.50.1792772574665; 
 Fri, 23 Oct 2026 09:22:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4712:b0:93e:869c:43e2 with SMTP id
 af79cd13be357-93f6f9a2bcamr507394985a.50.1792772574124; 
 Fri, 23 Oct 2026 09:22:54 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3fac9esm744473f8f.24.2026.10.23.09.22.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:22:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 77/83] target/hppa: Convert to translate_for_debug
Date: Fri, 23 Oct 2026 18:13:25 +0200
Message-ID: <20261023161332.60153-78-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfXwvt+jAwtoMiT
 /kbDsohVoDsOcKk+kizt9GbCnK/L0WJivgpvcUJtkDNysRrYJuEKBUFtBOw7qX7Ej66kSPUGruT
 4YU43MuUZl4fHA1sSOhS5oYzBVgPSC6f8E9dWNu8a1sUMyLgEW+cKAnPkw7cX4axfXSL3f6Tolb
 uIW/iJRBQOKmp1+reiylcxnCbdfnPdXdqP4NR0+qS0zDlqTxWVEMk3IUi1CNuCcxkzkKMMt2Vrc
 T19iAfcatbgTiLpZKjGBa88R0+tmpiSUKDnzFk36LsNRCRggbkgxb+7DNTidkysLfue5CasjCkV
 X7zsopmqU3fcfRQc67i/cYkNIzxuosrZpRHonphSd4QzJ08j7YVMi31p4rSdr91RId7XqR8syS0
 Nr6KHSSC+oClgxq98okUrADINQiRoCRXWaInz5XZ8WHUMzPukVHFgx+EOkkHB65TgrxNSWTN4x9
 nbTSFiMeKa4xtN7fZHA==
X-Authority-Analysis: v=2.4 cv=DK0acCNb c=1 sm=1 tr=0 ts=6adb89df cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wFESi-ZcbIeh2K4vyBAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: w1BSH9v-ajYQuIxyxyb9M0-0z25NNsJH
X-Proofpoint-ORIG-GUID: w1BSH9v-ajYQuIxyxyb9M0-0z25NNsJH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX07BfxsEFC7Iq
 uzrTUe2KOb/AuDl2ZzHWiP0jcyJyyWT+lJHWuc/ZKIPgbW3socFkEuyRLTi+pQutFjSj9WNztSu
 PJPK/vhSm7po3XVk1S2nqS7y64WyGxg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
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

From: Peter Maydell <peter.maydell@linaro.org>

Convert hppa to providing the translate_for_debug method rather
than the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261022125858.310252-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/hppa/cpu.h        |  3 ++-
 target/hppa/cpu.c        |  2 +-
 target/hppa/mem_helper.c | 21 ++++++++++++++++-----
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 3914b3285c5..8818d47dcd4 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -391,7 +391,8 @@ int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
 #ifndef CONFIG_USER_ONLY
 void hppa_ptlbe(CPUHPPAState *env);
-hwaddr hppa_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr);
+bool hppa_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                  TranslateForDebugResult *result);
 void hppa_set_ior_and_isr(CPUHPPAState *env, vaddr addr, bool mmu_disabled);
 bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
                              MMUAccessType access_type, int mmu_idx,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index dbf86941cf0..9d643223980 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -246,7 +246,7 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps hppa_sysemu_ops = {
     .has_work = hppa_cpu_has_work,
-    .get_phys_addr_debug = hppa_cpu_get_phys_addr_debug,
+    .translate_for_debug = hppa_cpu_translate_for_debug,
 };
 #endif
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 01e6149c811..2393a155076 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -346,7 +346,8 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     return ret;
 }
 
-hwaddr hppa_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool hppa_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                  TranslateForDebugResult *result)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     hwaddr phys;
@@ -361,10 +362,20 @@ hwaddr hppa_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
     excp = hppa_get_physical_address(&cpu->env, addr, mmu_idx, 0, 0,
                                      &phys, &prot);
 
-    /* Since we're translating for debugging, the only error that is a
-       hard error is no translation at all.  Otherwise, while a real cpu
-       access might not have permission, the debugger does.  */
-    return excp == EXCP_DTLB_MISS ? -1 : phys;
+    /*
+     * Since we're translating for debugging, the only error that is a
+     * hard error is no translation at all.  Otherwise, while a real cpu
+     * access might not have permission, the debugger does.
+     */
+    if (excp == EXCP_DTLB_MISS) {
+        return false;
+    }
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 void hppa_set_ior_and_isr(CPUHPPAState *env, vaddr addr, bool mmu_disabled)
-- 
2.55.0


