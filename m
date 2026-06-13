Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA393CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 17:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYSKk-000089-Gb; Sat, 13 Jun 2026 13:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYSKj-00007s-0L
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 13:39:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYSKh-0002WH-5Z
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 13:39:48 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65DF9Cja1235274
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 17:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ayTBXbbsAYVAVTSDVKIP6d
 pPIbfcm24p9PJjpCcgepU=; b=MiaiYJLq5vm25soABj7O/UzVKOwC5ah4EN+dxd
 grKxqX6zLvmP1epgu/HSLR8XV5DPa18upOO57j7iTZKJbemnnPDf+YJyNfpPA0Tn
 UErRNgMW3r4ES9+JmoWe5iJjpQecehtmXF27gmslZzR2zAm/NcLJ87LNkNdiwpj/
 zaZU/5KdQIfoLuR1cOxrLOspNtZTc58Hz7mWWjgrKKSvbBL1kQYwkIDYXSUm1dGs
 3UtVM1Ms7zAM4+aZ6lVntu6SiZTzLRS0NCjrppuau8BqjxYt4KVou+JInVKLWgrD
 rNHHbD9aC839ddvL8gWiscrdjr6kWNysTdMb0xQjzarbzF/g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryffhmvw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 17:39:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915f7c37734so453796385a.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781372383; x=1781977183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ayTBXbbsAYVAVTSDVKIP6dpPIbfcm24p9PJjpCcgepU=;
 b=MJv+jVgmR40XOR4IymTZx24yYf3wlYV+aqZFpXCaC12tCZUKFSQ/B8S2N3uI6aeBpd
 V7PxS1LUMk+hLxR8vaBCbM5WIPovaDeffy1GUrX8661qnQCZYcjL/BDonJec/Lwls8Gb
 hOxih8fRp/0nxXNlpNRGRvUqXdz/DaET+j524NGlS6ApX2AFD5Uj2q3WMXgKDzoejHl1
 TvAricCo1Xsef87CCPQ72qXXwdXMj+1XFY4Y06k6LHNW04kdAJGVYZbcWe1MHMvIckmq
 qNeArZC77PctF6Ljz9y/Im7apVm3Z/PPvhyXrgeqClVBkqftxpYIo1HnTSV6liJURs0R
 vc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781372383; x=1781977183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ayTBXbbsAYVAVTSDVKIP6dpPIbfcm24p9PJjpCcgepU=;
 b=fzlJorfwnziuWCd0IxjO5t++R8eY3VyyhokibgQobRXNtr5O80tuIRN+1U2sSj5Ax2
 PTxbAX5N06M7tkybcsLNDsFoc59uIkhD4qzesG0YXvTODNBa5VWBKd8sZSGZqtsJ78dB
 fq4bp+BI/ozX/lX3/zEtAKVWOL5EAuVjdsjGD4/JZsL8AtDlno/jFYV6iggPD58TLczv
 YaHjGWcH0Cql1ljtEm/X5pIPVekg+lOE16KodWvk8WjL8PtZF4PXoklP0DBJelwk0jTF
 26wLe+OkTYd5XfbpBfXGhAq/5AWiliPfAMWJaHb5n4IZ8iAxCLb7rFJ0SNSJBnebN6px
 uOWw==
X-Gm-Message-State: AOJu0YwMcrkX/RKOgcVWo923VOmVbTzfSBK8izMW97EUvX2tzND096sx
 sVmrqYQ1RFjP3cbLd8AK9SJ4EBnEyTK0/OIfISYlQggeC4+PLlDtTlhduSyZSc0MkDN7xCBjgB1
 EZsWowZW5fmJPRmjkA+sSvIC/eU46YhrdnWWOLUPyV+GE7oT61hKV+g1OVsSSA2HQKg==
X-Gm-Gg: Acq92OEbqzLWWUPT9zua4IsmiwRRVN0kKCU6nldTPtcPU5mydLYgok6jwnDLk7OHAJt
 4TiHAf2slIQg3vdqjwtTEPdahKKXrhrcF5h3XAB1s614f5yVXRfLijahPusPP1jQcayj8shVXZj
 9jQ7OKwC9nICtUAa2dZs/V/8dziQHDbeeC3f4BnAaaf/p45gFnts2qFqRl+f24dxB4tQ5eApbYh
 Xdr+qJQhluTzTwqqjjI+D1sAtru+8F41LuoCNRS8B+Jt+ALLggROtGDdB8Phb5DFsSGlwqEVs/R
 1rzy+BbTxGrPncVk1DO8jVm/cGjkHPCllfdkEF6BOhu3Lur/kcRcluNlmQAWpPJL1AwxNU9MdRq
 egp6ZVmkC8y2N78wLZTeD3uu8BPhoaRQTDt0p6NX0nDTpfcCinyfWkOk/mfZYzxySM9E2VO1nvI
 hz2qBXp7pI
X-Received: by 2002:a05:620a:17a8:b0:915:c4de:7ada with SMTP id
 af79cd13be357-9161bc8d2b9mr1136288485a.27.1781372383206; 
 Sat, 13 Jun 2026 10:39:43 -0700 (PDT)
X-Received: by 2002:a05:620a:17a8:b0:915:c4de:7ada with SMTP id
 af79cd13be357-9161bc8d2b9mr1136285085a.27.1781372382782; 
 Sat, 13 Jun 2026 10:39:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203c05ebsm92274525e9.9.2026.06.13.10.39.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 13 Jun 2026 10:39:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] accel/tcg: Restrict IOMMU declarations
Date: Sat, 13 Jun 2026 19:39:40 +0200
Message-ID: <20260613173940.539-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HuxG3UTS c=1 sm=1 tr=0 ts=6a2d95e0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Vt-pFaZAzWkUpIUNC88A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: XP-AOkGDIL68fga-o1dKX3p01LLukmTM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDE4NCBTYWx0ZWRfX82vOhukXKO6b
 tiKyXfzkwMcDD9YX2exIeHQbKtrAeVx8FIMpNcuPtgFaM5xVnrMemrSXiRbnqXTm0RlLX26yGWw
 Mt5TS8Mhvak2DNk3o8zAfIa9AKZNSbM=
X-Proofpoint-GUID: XP-AOkGDIL68fga-o1dKX3p01LLukmTM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDE4NCBTYWx0ZWRfX3gjCia3xoGcu
 q0aMdeCjuifvjINsUi5AE5DM2cv5jiQE3mR/z6RKvl6y/jcgLRfCt4uex3WE4nhFizsR2FM5GN4
 N0srxFUkUNpPwMUL6Z5s3ENfDnkStwj17TWssK4ZK9VO7LWwcPQjVfoc6Ghs0Yf9vJlYlSakT/o
 DQXzPKEphSJea1cihk53dmMJU9CArsuQFFNgJF6zG7fNkEebKUeNWFK+nCvBJYvWfufeVjobybS
 FKxrsdP75W021Ke3iieR7HQjOpqHOgZdASR1ovsxo1uuLQoIGhBNCYGafJO3xj3HTV5JDJ3Augc
 St7Oqb1k1blf/+dbCB01znPk8YmxtD+IDt9bvQc+A+OHSG4Rx/nqu+M+JI6ZtasF36LJaC0H40J
 gQzH5ZAJFkDB+e2VI2QSryq/R+DeZZF96UmANQwejw2ZJGmIjiMgdKRxDP/oiRnsDsnbZlWVcwX
 xtYR9E+XgnKiiiz71dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606130184
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
---
 include/accel/tcg/iommu.h | 3 +++
 include/exec/cpu-common.h | 3 ---
 accel/tcg/cpu-exec.c      | 4 +++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
index 547f8ea0ef0..2b6d0ff7282 100644
--- a/include/accel/tcg/iommu.h
+++ b/include/accel/tcg/iommu.h
@@ -14,6 +14,9 @@
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
 
+void tcg_iommu_init_notifier_list(CPUState *cpu);
+void tcg_iommu_free_notifier_list(CPUState *cpu);
+
 MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
                                                        int asidx,
                                                        hwaddr addr,
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 24e3eb500bb..6fe821b9a1d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -35,9 +35,6 @@ unsigned int cpu_list_generation_id_get(void);
 
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


