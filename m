Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08627606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JlWdyEyM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BbfRTfF1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI34-0007H1-9A; Fri, 23 Oct 2026 12:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI30-00070j-Qv
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:23:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI2y-00039p-MW
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:23:14 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6D7W2462574
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aZuD0DENIiKbyrh1c5c4+LO1FpVBkl9u5xfG9H9NzX0=; b=JlWdyEyMQXPMuj9A
 wnVP5QFvPu9NDUmKMQcdwHMpj28qkJeRY7JxDbZGAajHKQzd4i4Na1sDpWYLQTy+
 EeubVtHdVYh+OMcMtKRYhcYifSBW11KUivAGvGieuibnrCU2i1lj5oYVHfVUFqqP
 w9HMSxoFBx9dBbdSa1AFWv8nG8VWqO1/AolMaCxLDQpNLEe2LjljXhq7dFi5mhR5
 bQDJcccBbh60fm2ZW04j/O3rt8C+AXMCZvXoO4gqZLbWkAzaYW9OivjtK58lWLHP
 wa1Sj5JlWZf4ijvv2+3SKklNNPD+8lr2llrAiLWKYTxdvTT0G7P7KimUAmozCRSm
 ZaJNsQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtvju8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:23:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-917a109c937so16300956d6.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772589; x=1793377389; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aZuD0DENIiKbyrh1c5c4+LO1FpVBkl9u5xfG9H9NzX0=;
 b=BbfRTfF1y1BO7PdqY4nl/7J2gSR+RTcnhd4219ZPwCevtD7z/BIh7PYileSeJNrwBo
 m7Ni0zzZDkpAASBAcm5RMEjy+Xbm6NZDqwagYq0fjgG+DU3jcc6on/zXHjGbmcnSKONp
 SBcBLsoNH9zvTK1PaGZcncFKmcECmw1jkE4C3zYREmrVsC9girZhkPB/0BX3GS1bx5RV
 Fjk1VtioTC0TjCLe4xQ7UVSzqG1/3C3xy/ljs5oS1LUGrU8oPPyVRlh5sD/8RsFn8zJo
 MP5h61wPVRniAP18FbQonf6uvQhJpjrxWgI7WSxwQ42M4m6ar2BE4xkvJsqe57VTHRM8
 lV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772589; x=1793377389;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aZuD0DENIiKbyrh1c5c4+LO1FpVBkl9u5xfG9H9NzX0=;
 b=I7TtbeaGzoRV6tO/BLomCXEgfu9Qq1EhZ6CqkXkiRm2Ht8ZACPXRtvg1os/ebc+K5q
 g8boaOZUtuHfv8OJTOqPkRNi/RydUsRMVuy4QvYIQK7OdqLKyLKK2GLWfZ3d+NBNsXQ4
 0Jo1T5sReDVZsULp0WRwq7ByAFyAGwEKucMlKAaO/gL9qi05uuSdhndoqXeA3GNDLDDO
 uIxZx2plyzsIhWcOYOvZLd2kQYvJGoNVBiyAx7l9j9vPA6FmN6TJusxcWP49I0NqDnTs
 A4RUt+O3DooVJ0wUyWsfAURN5byHqbEZ1O1p8YoxRM95MSZxTCGYPo7PDWzRDXTlf6VS
 YuKg==
X-Gm-Message-State: AFq9FYLxYCDzlcgHezHUnF5lTLkFpPypRXYezOML+hobwqTfAhVQfyBI
 4hN8/UWP6OpSyChJP165XlbrpBhp4T7Zhp/CYgIMW6iBUm0v7muFoZi80q693zh+fSc6m0/xzCq
 y4qiYreNz9m2gSGJF4eth43jf0r3ylfN01KOjnu7wQpJTOkbI8NHu7mnyx15Yhu16z6xz
X-Gm-Gg: AYBFou3G9RRgOiW0wztrPi86BASJYn7pgnTq0a+rY3rg0ppneZqbgLrWR2RHR28r07X
 2eClYsyoeUXG3Hzil2yMrmU+VSRKxN7hW8f9dFeYpt1DTqcciRp2JTnq6n2fJ2A5TG89ud7eJgy
 sBAZJ2Ke7x6TiVyMbgj4EnK3RMDxRClzgHYJfst0kq3yE/pCv+ZmXP821KqX9kci3h+bQltFfRk
 KChvzUyKowaBWC88Ui7xzV+F/RSyYV5qZIN2dXO9E2NK6TetCTBmcFRnT8IzROWCBxhZvYFf6jj
 LdWnTByxPMMfbWBHpZ1Bk32SrNJcBWgZNAdwEClhl2JMOYl+i/HgD7mEp9rg+1+c/54a/elUzJu
 E19OhsTfC4cadHrF7fJt7Gh/DqZ2KOdrdwVPA7sG6
X-Received: by 2002:a05:620a:4725:b0:93d:23b3:5088 with SMTP id
 af79cd13be357-93f6f907cc0mr503773785a.16.1792772589017; 
 Fri, 23 Oct 2026 09:23:09 -0700 (PDT)
X-Received: by 2002:a05:620a:4725:b0:93d:23b3:5088 with SMTP id
 af79cd13be357-93f6f907cc0mr503768485a.16.1792772588384; 
 Fri, 23 Oct 2026 09:23:08 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312fc7012sm8799725e9.5.2026.10.23.09.23.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:23:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 79/83] target/m68k: Convert to translate_for_debug
Date: Fri, 23 Oct 2026 18:13:27 +0200
Message-ID: <20261023161332.60153-80-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb89ee cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pwLHjLZDfaiR1KEsWAgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 983RIrfNxoX1GjaWUGnGbiwVEMud8Hv1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX5mrQlqaUEfk3
 q2DsJ47JLJXwJGa05gDfcrQRUS1prLA88BgAgGA7Oz4LlNWWyDLPHJtudNl96WNd2c6rH/4Pe+C
 rz5QGGyaaaqdxTKH1M23Wq56P1i3vHYJXJwB5V1SGMOoWKBzHjOOwzqjO1pYfgTFaVHfZtyPiyh
 Mei/s7v6v1HdJL0qGATjjTPnAK2KJF7HvAegTx4Ejtj4seMSDj0zAg2QPD78PXN8SgySBnjtigz
 Gyydhp/9/GJ2JZaXJ9/2hUxmdssmL269f2kXaiQGK0ObMtupx4fehYImWHhg06QITNa+lg0LFBT
 l1eTmB9MvN1siXk4yq+Ll7VMf8eIEHM2vAS9QhSuDB8YOtf/tEcV0zppfvDqFfc3fnNUbk/JYz4
 KOEK4nxaaLHbrOTVGDdHH1VR3qUpk4x3ljj4uJf0vAg5td+yt1xCnKLeD2aNo1YRV6EQPb5ZRX7
 VRrEGVWHnDnE4HBLOzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX3t1ji56PLVMu
 aPboieGo5RhClnWRccicY33vulPFadAUhcoTqmpmqh9a8uA7DM2Rbu7DADK61MnousZa0FrJ0X/
 k8b4wiujGd8+Ixmb4QDw75xxoMimdmM=
X-Proofpoint-ORIG-GUID: 983RIrfNxoX1GjaWUGnGbiwVEMud8Hv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230064
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

Convert m68k to providing the translate_for_debug method rather
than the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261022125858.310252-5-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/m68k/cpu.h    |  3 ++-
 target/m68k/cpu.c    |  2 +-
 target/m68k/helper.c | 16 ++++++++++++----
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 44b4afc41c6..781c98f7840 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -187,7 +187,8 @@ struct M68kCPUClass {
 #ifndef CONFIG_USER_ONLY
 void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr m68k_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool m68k_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                  TranslateForDebugResult *result);
 #endif /* !CONFIG_USER_ONLY */
 void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 01c6b6afb1f..f7d289e591a 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -688,7 +688,7 @@ static const MonitorDef m68k_monitor_defs[] = {
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
     .has_work = m68k_cpu_has_work,
-    .get_phys_addr_debug = m68k_cpu_get_phys_addr_debug,
+    .translate_for_debug = m68k_cpu_translate_for_debug,
 #ifdef CONFIG_HMP
     .monitor_defs = m68k_monitor_defs,
 #endif
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 5f91d206f59..c30854a6746 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -908,7 +908,8 @@ txfail:
     return -1;
 }
 
-hwaddr m68k_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool m68k_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                  TranslateForDebugResult *result)
 {
     CPUM68KState *env = cpu_env(cs);
     hwaddr phys_addr;
@@ -918,7 +919,8 @@ hwaddr m68k_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
         /* MMU disabled */
-        return addr;
+        phys_addr = addr;
+        goto success;
     }
 
     access_type = ACCESS_DATA | ACCESS_DEBUG;
@@ -928,10 +930,16 @@ hwaddr m68k_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if (get_physical_address(env, &phys_addr, &prot,
                              addr, access_type, &page_size) != 0) {
-        return -1;
+        return false;
     }
 
-    return phys_addr;
+success:
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys_addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 /*
-- 
2.55.0


