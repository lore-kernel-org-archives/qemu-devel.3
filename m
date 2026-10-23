Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF3606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aLOVHkie;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S16szMTU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHy1-0004gW-12; Fri, 23 Oct 2026 12:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxr-0004Js-S4
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxp-0002Yk-9k
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:55 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE67q13019019
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xcgP0X6WunyfiWmZrS9ujopTFmtiq6gtX4+aU0FN2f4=; b=aLOVHkieGmomDjyd
 zgwVOEOYPdlpZq2bLutJ9oNjS9JPbqls3dSOaHKG0obxCFc6nnJ6e4Y5WSjdPlK+
 Vdh1CItQy8xGqJLsUFmM2bPnoPLrxaiA9KpIn1qXDOohVJcjR4OX+5DS2tye3Z8a
 B7WHVdX0iggndqFeFU03tQwF9EWGibWQBI1tFhM89aK9Hosuus21DADNejA1B+Z0
 ohOH488hib/2pefJSz8xjaikv3nBbvq2kOwSB+g2CLWPbAnJ8HqGJUEYwi+9QyES
 MZPvzk5VBbw6DATAni/rtV8C6tcJ6v6g2tNw8379thtKF6Teb8IALE9YLG33LmOL
 ADyluA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsykbxt6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so245633485a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772269; x=1793377069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xcgP0X6WunyfiWmZrS9ujopTFmtiq6gtX4+aU0FN2f4=;
 b=S16szMTUhz044zAx0Go8MvEyumuxIMthzv+FdUr7G6G5iTFdzSXJTMYrPHDedc1P4X
 Ap2a3IAZwG+c6KdRk0N4gSWD0l6u4LcyZRGksxVGJ3TZTIX8OYECajFYDirm7TwUe65v
 /qPaQNyeUGTHpK4CWanfXuBV3aKNdPhVmMUHP+MHl42O2RI7Dq8EpCSQOookjnfpA5nv
 UO4/LO7hbcLuRfCMEbSZjaTIGHyytF8xxa1lagYwStfcqtXDtW4j1mY+2ASrEJanrclm
 3UaEqCdhD48/NxdcMRJ7HtWdghiB+eSRThyhkdxC8Asv5/lBZj/ESHCFRGSIJqsZV63d
 LOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772269; x=1793377069;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xcgP0X6WunyfiWmZrS9ujopTFmtiq6gtX4+aU0FN2f4=;
 b=dARs4/fWNcQ83xjR17PYhGOsrWzKj2NH+5DiFWM09CAavZ8AKpiwPJ5Izp/0MNmZQC
 KBpD3vSja2RGNH5Lvh6k1XQ55bQGUy6WGYFCgZf8+25HGImBgZsLcUVwmreRQdOKHLdl
 KTIu/C4s6eZe0uFw3oUVRryiaLYsHyqfH/CRz86lag/1Cr58g+Aa/yAmq1HmoCi+ckUz
 Ikn6w4rpZLgjPZl4ha71zlg2yNdpeZUJikr7Cyz31ceXE+pYiprp6DGKNSwzuMxKZmrs
 j2vcyKKQfWtMSUFF3J3jlGJe31c5qBjAIym5xCCfOVDV83D5gH0cEzoMBZ8U9BaMFZEk
 j30g==
X-Gm-Message-State: AFq9FYJEfjCgM+XY/bpYz2JKtFS1jMX0eoqmt33tfnXYt4hSjDhRpZUu
 ezOIulyFuykkYDHTYgtqurKYq5fokXc75j114U7kTdpkAXB/hSLTIKOYoYiTCHa11VWJJ0N5pon
 dK4Vg7P3e83jqIEu4SDOHMeM7jmULrgUJ/yFeIXVfc8VRQyjl6pI4ZBysmEVPG5BH+LwN
X-Gm-Gg: AYBFou0ft1ox4zUJlfYqUGgwRydZFp1GySpIE4pR3k4g5q1Vd+QLKD8xEACHkDS7AK2
 TuFrqieKSRrzizBDb1XSu38S5Ro1SKdpeSTxuARF558lD8PC4HGMSjIjzc7jF7V3IeRbQ73mVfA
 x0dO+F8NZHosLNrpAd6S/YhYBxSDLo+034JpI6HwUFYmKzIfHqmQVNozBfeWIKKIFtvCqYJQsvY
 xczpBmK3sSuZu5YjvDpFVbFyNHWc7R9x2G0GP6paR3YhIYSwg0o687py7PDGl2LBbcLhNVKbsae
 wN2DhPIVot/igC+SHSJFPEDVSdd4AUdrDczx+7Ep3jLRnzU5TRq031xbOXtA72kxDV+0hdKCE8U
 2CUgyTMRVSFRlbmtoG7Ju88TkrfrOAW/xgs1pjFFo
X-Received: by 2002:a05:620a:2717:b0:93e:9171:b72 with SMTP id
 af79cd13be357-93f6f804a63mr481735285a.49.1792772269064; 
 Fri, 23 Oct 2026 09:17:49 -0700 (PDT)
X-Received: by 2002:a05:620a:2717:b0:93e:9171:b72 with SMTP id
 af79cd13be357-93f6f804a63mr481731385a.49.1792772268545; 
 Fri, 23 Oct 2026 09:17:48 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d427e68sm800163f8f.52.2026.10.23.09.17.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:17:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/83] target/microblaze: Implement and register
 CPUClass::exception_name()
Date: Fri, 23 Oct 2026 18:12:43 +0200
Message-ID: <20261023161332.60153-36-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXzT6QBmI2BoTs
 GoL3htk883O30a2OwnjztWHZGjtKGJ19WVqkvlga9zREtHRy1jK59cY7c7Z6qk7ywyjqV/Y31Hd
 O+Vc9e8wirK1WzoAy0c3Sqmp8G4LUwFsXL1RuanLUEVpY2H/O5KuvOGyPMoAu1jyJQNpsLZdRIc
 gpd7yjClqXqJDqulZFBoDopiecYCoG0EYJMXeUBsBdcdAm0oSH2HTeq6RmBavgSDEawZaPJTYvO
 JayauIFEsEROtppt5gqxnt5oW0ps2iL38bia6ub94AE2wrT5NlejhPDX3VQPxxKUXa+2p3EJTLy
 FyopyJieax3kIU9eZxhChs2aq24PELmnpqBRJe4ts5Ssd26+/NzdpZxBro6yxrkkfTWHKaPzAZ/
 TLgmEF/3B71aKBNq4WcUsK7foyWQHm6XlDhfqZaoNP1uo4SdEawI2U1clbMlLFUG2DGSBeNws2X
 HyiIRTSLSmewvHDwSVQ==
X-Proofpoint-ORIG-GUID: IxxRi8_ZosSNwRf7TgGg7z6wMFbaldpI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX/gL1xsNAVcs4
 jG1kvCCtjig0Sw/hs1lf4r7ot9AAF04RuledNGVwGpep2kflDoMpPKcDjxbF4xHky8rawv1R8Ha
 tZGli7Gwmyx+6pDFfXkGM7VTAl6+Drw=
X-Proofpoint-GUID: IxxRi8_ZosSNwRf7TgGg7z6wMFbaldpI
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb88ae cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_ZqrUhsafL45AmjA-XwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
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

Implement microblaze_exception_name() and register it as the
CPUClass::exception_name() handler, so the common exception
logging can resolve MicroBlaze exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-17-philmd@oss.qualcomm.com>
---
 target/microblaze/cpu.h |  2 ++
 target/microblaze/cpu.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index b9602f72b94..fc2783693e3 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -36,6 +36,8 @@ typedef struct CPUArchState CPUMBState;
 #define EXCP_HW_BREAK   4
 #define EXCP_HW_EXCP    5
 
+const char *microblaze_exception_name(int excp);
+
 /* MicroBlaze-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_NMI       CPU_INTERRUPT_TGT_EXT_3
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 6013a8def8e..6d3f7cdae81 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -23,6 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/module.h"
@@ -79,6 +80,19 @@ static const struct {
 /* If no specific version gets selected, default to the following.  */
 #define DEFAULT_CPU_VERSION "10.0"
 
+const char *microblaze_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXCP_MMU]      = "mmu",
+        [EXCP_IRQ]      = "irq",
+        [EXCP_SYSCALL]  = "syscall",
+        [EXCP_HW_BREAK] = "hw break",
+        [EXCP_HW_EXCP]  = "hw excp",
+    };
+
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
+}
+
 static void mb_cpu_set_pc(CPUState *cs, vaddr value)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
@@ -468,6 +482,7 @@ static void mb_cpu_class_init(ObjectClass *oc, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mb_cpu_class_by_name;
+    cc->exception_name = microblaze_exception_name;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
     cc->get_pc = mb_cpu_get_pc;
-- 
2.55.0


