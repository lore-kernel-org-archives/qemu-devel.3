Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC69606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YQit3WF+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G2JrJiOT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI39-0007cu-8S; Fri, 23 Oct 2026 12:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI35-0007Tp-VL
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:23:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI34-0003AE-4k
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:23:19 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6E4g2215919
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ajir7S+iuMCY9fLagjetcNkEg7+rFaUjEG50RV42aUk=; b=YQit3WF+zRGNVcvk
 mlaxlG5pxsmKtFSCIy6y+5pY1ULAuhxdBcrZUtJmR54Zai55037IsZGdyuXBCrdT
 QsVbh/CIYKozPLwzvIdOZF1blSB7WQ+aRXoqPUZSijuGqAt73gnfAKi/RKBxtwLe
 v0qufcWZQZRyAxei+xz/q+wSp9bVH4l/wgeQQyhVLN8KZxAUv1Q4DY5UhS/UT2Od
 1MBlgnCnXHUsvxm/i6j9E1LAqEqFNiRVpvHCS9zTw7tPjaBECeAEc+HCBfcgTJSt
 4wUh/WHKVEPRR+ZRX5MkEkfpMJPLVJTKZK3+gPX9kIK40g3gyXOijKZUmZB1TQoV
 MSm3qw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc8228-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:23:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f322ef7d3so239905485a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772596; x=1793377396; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ajir7S+iuMCY9fLagjetcNkEg7+rFaUjEG50RV42aUk=;
 b=G2JrJiOT2b7ZLfEXYzo7dZpAGme5pQHNhMOUP6sh3NrsTWZpFh0oLuMsdBL225HphD
 R7xEg9zEo2dY90VS934i+w4keStBOV/qXjpGT+F8zFnqGLnf2agQFyQWYzLn9HBb9ck/
 cahWn+ztmLCMH7GsubxIIzbw5VOU9RF7Q5Pr0ByDFUzy7QyAkJNusmCX5X5iPQm6gu10
 ewtXgucUnEiucf/c8GT4YaPonxTiUL3oJzFcVNbtzCFUvcZsjF2p77edfAPBsMyDHLVF
 +xwo3nuMR3wdNNSCj7tgiYGQLVX+eE+oJFwZWcvqGpV3GrWDzzNJ9sXMVkrqw6rL2TDC
 ypjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772596; x=1793377396;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ajir7S+iuMCY9fLagjetcNkEg7+rFaUjEG50RV42aUk=;
 b=CKxMvGCOU08aLF2EhSjSnvPh7kFpni31rIvO8zYZw82Y/yPqjoiEJnYjE6Obo4HrVw
 RZLJGSCpFR235ptGoZiBjVD4s7u30ed8I58HZErG2KvAr4LZztGS5x/b8byJ5233vJid
 n2g0iC6PCm08SCZO13OGyjQhrt9GGWKHR7EC2YM72bd66jqyxA7hBf1rHhS8DOIsVxxL
 aFGup97P7WaN4T2M8rzebxoGMOG407xT071+FraFB7IXtOM1C9rOCDx7p+zf5iMs5F6Q
 u2O/CY2bpZ8DgBW/4Wb2dhIVuEX/4ZYKPqu01K7q+i10+ditG1JdtdqWfTBNY8xhUHgD
 Fk7A==
X-Gm-Message-State: AFq9FYJdm6ym1zy/0+ocNYTgXQ/yP3zfxLk7jxKl5nHV5uNVeHjEwPfD
 jOrvbFi+KscEkoWf34tBTYF0GbLcWJ284Gc3CVABFbVRJ1EAMzts/kIJwBDTKO0SKqXsEl7odxs
 a2Q++4fYF88OD3E9iukVbyruPLnY7CwcQCLwHa/HYUrVwog8oGtrnOBYh68Ly58QChnFk
X-Gm-Gg: AYBFou1QwTVmNLbf00iaMKbRpB9zx7zmL4L2t8P0pLJQlfCY/jGawpSbxBuN2nG/WWq
 cHbfmvV6+3bX7rkA3jL6KG26g7Sb+2GPIftGouBNS8007lDDR/PKwtCqXJa7MiqgqWVjNezCH6u
 dxGqvbRuQBCFh5AsyVQTiVaPoDac9orkWBFd2JJPHqN4bfmjLwEoA1ngWW7bl3de5n82FYlsvOY
 QYY7uzUl+0fUxjEBHB3sJgD0osQ8hyNO6WuuH/UQ0wQ5kRIZ58anSyeA5VqlNZesDub7FQXOPAU
 wHCU11iU9aOYpp2cVDES5TY7waCgiOPaFjMwQqm4X2Wl3/S9C+oMPUrChPj4zplJvSu81UivxTT
 /f+5qFQE4ZhlMZeackv2ETwFa6f7C67H4Ux9tBur+
X-Received: by 2002:a05:620a:801c:b0:93f:1dbf:6ceb with SMTP id
 af79cd13be357-93f6f585032mr458546385a.3.1792772596234; 
 Fri, 23 Oct 2026 09:23:16 -0700 (PDT)
X-Received: by 2002:a05:620a:801c:b0:93f:1dbf:6ceb with SMTP id
 af79cd13be357-93f6f585032mr458541985a.3.1792772595624; 
 Fri, 23 Oct 2026 09:23:15 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cd9d09csm15959055e9.5.2026.10.23.09.23.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:23:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 80/83] target/mips: Convert to translate_for_debug
Date: Fri, 23 Oct 2026 18:13:28 +0200
Message-ID: <20261023161332.60153-81-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfXzdB9l4rhmnOP
 vIVtaOAgSzcM3O+/a3Jc4cMppc9MATf+fwDld5QAiMNJjNV733vN0sptE2RfyKSgP3Gmg9A0lW1
 KlPbLZ59BtPIFbYXc4HbfltULq7dDpVwMbLp+DRs+OaNaRUwbgaKeNOQZWcehYap4JO24eGEZJb
 e4BhfHI6RKjoHLbfqVEAExC05NkQHjSw4E/QFHATfetaIjbOIshK8SjEA2veRAiimP+3U1gUYiJ
 AcJuZX7UDnlcsEFeSOKT4apLCQYErNU/XL2smmMmX/MEZHXOGJY3IEsVnkPJ98hGY22U/piHqP+
 nOzQ15Y82vU+m4TE8x2DzcJ5DWoQK6q+XB1YXrQejzgxdPBZmeDdC+UhjWpjEqjcWeHCyKaJVu0
 mV4lJrVohfNJV9Yb+p1vxQa+NrtBP/88Z8cttHqWDj9ujiAMUYDcSyrKVAD35wn0sw80OdSQ2j7
 L9UMJ34/MOufm/FK3jQ==
X-Proofpoint-GUID: -kH-nPrXXrTUe8941pFrt5BTYYFOMS0w
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb89f4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=zDhEfTcEUI2QNMyCiQAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -kH-nPrXXrTUe8941pFrt5BTYYFOMS0w
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX0Rxr/ZcUfFAh
 0MJ/AW7ohGhlJfhkpa/5kO1l+CkkKlthjj1vC55mSbXA22FNuA/JXDUE5ebLDhs42EvNWcG0iN0
 fxcmKF0YFJQxbR1/7AMGDd4uTj/Yqcs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230064
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

Convert mips to providing the translate_for_debug method rather
than the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261022125858.310252-6-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/internal.h        |  3 ++-
 target/mips/cpu.c             |  2 +-
 target/mips/system/physaddr.c | 13 ++++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 0c9b1335ebb..a302fc0c20b 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -118,7 +118,8 @@ enum {
 int get_physical_address(CPUMIPSState *env, hwaddr *physical,
                          int *prot, target_ulong real_address,
                          MMUAccessType access_type, int mmu_idx);
-hwaddr mips_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool mips_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                  TranslateForDebugResult *result);
 
 typedef struct r4k_tlb_t r4k_tlb_t;
 struct r4k_tlb_t {
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 759a4e93a0a..c5193dbc8e3 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -659,7 +659,7 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps mips_sysemu_ops = {
     .has_work = mips_cpu_has_work,
-    .get_phys_addr_debug = mips_cpu_get_phys_addr_debug,
+    .translate_for_debug = mips_cpu_translate_for_debug,
     .legacy_vmsd = &vmstate_mips_cpu,
 };
 #endif
diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index 746dbf8aa4e..6f11e70ba80 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "../internal.h"
 
 static int is_seg_am_mapped(unsigned int am, bool eu, int mmu_idx)
@@ -227,7 +228,8 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
     return ret;
 }
 
-hwaddr mips_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool mips_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                  TranslateForDebugResult *result)
 {
     CPUMIPSState *env = cpu_env(cs);
     hwaddr phys_addr;
@@ -235,7 +237,12 @@ hwaddr mips_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
                              mips_env_mmu_index(env)) != 0) {
-        return -1;
+        return false;
     }
-    return phys_addr;
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys_addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
-- 
2.55.0


