Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAD9CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBue-0005W6-4n; Thu, 18 Jun 2026 08:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBud-0005VW-98
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBub-00014L-Eb
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:03 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAs1X51030408
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 41WyGJzPRd91HwZyhcbAHpYqoJ/8Ng6HGaJDEfY5JO4=; b=f4jM9W385mIGq3UO
 nQ5Mk0Onecsj+nwIAsQvfe81YCC0vseUo2us75QsFf7nNV3fp61ooE1smzKbdJUL
 GVdVP9JYZLeGYJBha8KptgiFnzVq6DevgKBQDMeghYX1UMr6m3YxIQaPujEYE15W
 2JDsjR5GsDDA+NuSrRvTbXoasbY4fs2nStMStdiELehBMyXH58SMaDDG7lZjbHIJ
 90ZZCsxq72mPFoW22fuNlPBjeTKWcEff9QQHDgsjks+4Ej9lgQOZNB5u9Ub2jMGl
 4XmaVwySXqjgzThSzrweG2efjOgV8KkOkfePsjIMOZHIZUshL86WmNFgDsH4Mnaq
 Ad+1hA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vm3crv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:00 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-489677a16bbso80444b6e.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785919; x=1782390719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=41WyGJzPRd91HwZyhcbAHpYqoJ/8Ng6HGaJDEfY5JO4=;
 b=NPTdYXhESOmpnvKIUplUYvbh111iR6I2bnw5QShomM/KM9lNPLFI3OQLPuSRrOIO86
 f2mWn3QXbINS9Jqr3495jJ/ESphKxA5YKsZrd9cTd3/eW8eFg5Y2hNxfHpZ7x45F1rZ7
 xHB4hjliUltpmvPEENAZlNaXmmfXKW7bBTMuBftnyDEN/rJmOhyHrf+0Hmt2iadIP6YF
 6TPozefzXrTgdzQ03UcOd8MZ/hnibPRRzmZBU4RHKDOupsmb5EelNxyaljoxST5MbBgG
 BXsu+ZF4ZdDsDL4d/WkB3VGDqij3bEzMLb8L8PGREXDNzn4AVC2QDHrT/TKbD8K2CJmB
 XGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785919; x=1782390719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=41WyGJzPRd91HwZyhcbAHpYqoJ/8Ng6HGaJDEfY5JO4=;
 b=pc/rb07YwW3OlzZ6pl+oQLIchTHxw8cx0W6aFCLWag0cYkZ+i93ye58i8jWLWMY5vL
 l5c72PMdIRxRdhpDdXENzUybuuumnZs1RwqvcZjnnpM607OiWNMpYFZaV0cnuSxP21SD
 mv8dq2HyzjDL8fgsOcbubZdq9+mWefVIpTd1Gyxo84euoTeLzqAcM+ZPAX3pFKeCk47j
 VZOnQzZA/PJ2svLN70QLq5K3fvIqdZdjM5RVr6ZrGhiNs/3WsikysRAlfzs+hfdgqokt
 9Bz7Iym8Bk6uEh6c2SCVLkBb41raG1Y5x+YpcKFTzuRTQUDyWpS0+WJDiT0lFFHtwwd5
 vYBw==
X-Gm-Message-State: AOJu0YybidjsAwSYsjbPgDRoVZ4KG9F4FrWt4IGks+ED1JAb3cLtz2H6
 M0k2SZxPH384/5HV+FNTMG+/FnNyFmr6WIxWKUuzQ2DMjNBrCuoqOywaL1fodWfbGqtNogR8zUm
 w9ih1HOSGSAzF1JjuoqI7MwjK06PzkTxJ78AU+iLI7yma61T/d8HJvFMjcu0+pnflHw==
X-Gm-Gg: AfdE7clyTKR4l+KtYa+qUwoEtJisBaawOC2LABmSqHoJEAqJT9Ob9DXz1I5tk/Ge+Qi
 tWlgO/OI4SfJuKuLxb7sNTvmqNe77NZC+aG94LuTQqGD2iVLRNB7ma0DbF81ylEZX1VzNXneK8s
 e/TZq1rQ5tMewRYVHC34LW6k+uEdnrIVVhNO+j8O2I+wmxy/FVuhG5ejNEx64GFDV7YBQeoPWy0
 /1gsSnNacHE89NfdWijpuDd+x1CL7FLoN0MjeEe+cMV8+Ca0rDrdI36ujEk5PDUU+FkrPLL616s
 icz6A1qgwdvhwu82I3Xb5A3KN9FJSHvEPsk8Ti/fHwP+XxjgQLYjOaPrFDeZn9DwW/3mMB3jLAb
 wNUQHEGJxVayxIBcTc7crDV57gUUCtpmL3MdjVB7bdk95ryp2g+2UwaxGeYnMnjIZBcnF
X-Received: by 2002:a05:6808:1250:b0:489:5dc7:dc55 with SMTP id
 5614622812f47-4895dc7e08emr1529738b6e.40.1781785919356; 
 Thu, 18 Jun 2026 05:31:59 -0700 (PDT)
X-Received: by 2002:a05:6808:1250:b0:489:5dc7:dc55 with SMTP id
 5614622812f47-4895dc7e08emr1529674b6e.40.1781785918613; 
 Thu, 18 Jun 2026 05:31:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d2d9esm39113045e9.1.2026.06.18.05.31.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:31:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/48] accel/tcg: Restrict IOMMU declarations
Date: Thu, 18 Jun 2026 14:28:06 +0200
Message-ID: <20260618122825.90331-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX6Nfa53Wj+XkZ
 j6Qgm9m8UbHrAqPYxS0JTEbkgK3NKR567A7v0RANbWnundHTpAv1uhCGGCSO+CNFrBBxEL2MC71
 iO86edU8+jcwiCgDJmEn3vMxwXasrMFKj2+/5JFd8Nq13JCYD13Eyx0q6FyxDyoCuDZFeEBmFsk
 ZvtljuxDqtUyKT4Vbo8FtrsiHIcrq0Rm2Fi67TV81zKHDoZp1pQ7AZ3wZXe8Ayl+YJ/AwqfE2qC
 OANcV/0iL3GBNFvvmgR6X+MZzW3GVwSRn2D+626/z9FCKJu5NRBNqmoKsIxbOnCII/BhE/azQmr
 tH8RkHSu0XPhThUK8jJ24EV/wfNmBoOpVLFVDz6JdaglOH/vYlzcd1VuPxBE0jfPp5MG+bOutgC
 ke+QDrggzisFFtyiWP2UorSS+zrl8uOwgHf35ZmL/RqEMk5lMbkBLsNDGI0WIN+VNMlUWiny7P1
 sYdw7ymDZrurcP2u/mw==
X-Proofpoint-ORIG-GUID: XMvizXpq_dKlm-Ez-L9Nf893fxdeSqS0
X-Authority-Analysis: v=2.4 cv=UrRT8ewB c=1 sm=1 tr=0 ts=6a33e540 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xWu8-Agft_6X_INOG6MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: XMvizXpq_dKlm-Ez-L9Nf893fxdeSqS0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXw9cZWg0yf8kq
 PRUV5M71kMgON79+bcjCObrGZZ9VqMfULg6rk1E4qG4UKqbvDJB6gd+DVgb2buU1v867anAlqKt
 FWh8RAN3+0vQ7D2uAIKStQICw3IYQKU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

Move the two TCG-specific IOMMU method declarations from the
generic "exec/cpu-common.h" header to "accel/tcg/iommu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616153633.93267-1-philmd@oss.qualcomm.com>
---
 include/accel/tcg/iommu.h | 7 +++++++
 include/exec/cpu-common.h | 3 ---
 accel/tcg/cpu-exec.c      | 4 +++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
index 547f8ea0ef0..a4032a292e5 100644
--- a/include/accel/tcg/iommu.h
+++ b/include/accel/tcg/iommu.h
@@ -7,6 +7,10 @@
 #ifndef ACCEL_TCG_IOMMU_H
 #define ACCEL_TCG_IOMMU_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #ifdef CONFIG_USER_ONLY
 #error Cannot include accel/tcg/iommu.h from user emulation
 #endif
@@ -14,6 +18,9 @@
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
 
+void tcg_iommu_init_notifier_list(CPUState *cpu);
+void tcg_iommu_free_notifier_list(CPUState *cpu);
+
 MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
                                                        int asidx,
                                                        hwaddr addr,
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 830e57dc5fc..74337d84640 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -34,9 +34,6 @@ unsigned int cpu_list_generation_id_get(void);
 
 int cpu_get_free_index(void);
 
-void tcg_iommu_init_notifier_list(CPUState *cpu);
-void tcg_iommu_free_notifier_list(CPUState *cpu);
-
 /**
  * cpu_address_space_init:
  * @cpu: CPU to add this address space to
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ad94f96b252..7292ff15060 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -26,7 +26,6 @@
 #include "accel/tcg/helper-retaddr.h"
 #include "trace.h"
 #include "disas/disas.h"
-#include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
@@ -46,6 +45,9 @@
 #include "tb-context.h"
 #include "tb-internal.h"
 #include "internal-common.h"
+#if !defined(CONFIG_USER_ONLY)
+#include "accel/tcg/iommu.h"
+#endif
 
 /* -icount align implementation. */
 
-- 
2.53.0


