Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAD9C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eK-0003df-OC; Tue, 07 Jul 2026 09:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5d1-0002Ov-Sz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5d0-0000ZE-4i
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:23 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8eoI3616557
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hY8gLzk0rHZJeGlxwJxqv4ggljy8LVtQOjKXzqPfu+U=; b=kryVHT2q6fTGkleP
 le/fmEpDw7esMn5z7JuYsKqs/DnEszbd3vlLLvkp4JpRDyIbu/eU6HBdRkMmkhwu
 DBh0qZi8jxWGFjtER+6xQicY/O2CidJDaOFmb/UcvYc71ao3WMViwtcXvQFIP4TD
 HU8U2U/SGGr6Kx+F8Nian7ZLt0K9AIC49pbIxb1Dak3xEXUSD7LOoBWRedZnrcnh
 /KnbRUcgBq9yiA8WBS0vIS1MKW6cA4b7clyI83lAARvHax9Gd/rSaqdyO2kXyjLe
 6tA13Rw3rs7HCqMp6tGNPR3V+MZyq52+lYYOz7HabCy+Y1hp7AiN8ZUFk4z4gMnn
 6c2FgA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun1dp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:14:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c12e43b98so51679671cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430060; x=1784034860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hY8gLzk0rHZJeGlxwJxqv4ggljy8LVtQOjKXzqPfu+U=;
 b=dFpolBOIDDwHERcwAKL+mDvh26i87RXwbK3WsOmfgWzjaOGgVnyfSX0g2KG4xnxsv8
 cqovtay6ns5DKYV9sW1Ox2RBNegzYfpaUJM6MMASHVJ4Qo5bzfijK8k7E6/u9Ir99nMP
 kyGFdgFHkp+2AKTfJV3+7rTgXhD7IAKCyKoChyYBlaFCG3n8GdXoXg49U7GklwzfqdrW
 elDvZx2fBqa3Pvw9ZzQ4BYr8ABnQAbioYCoPxy4ukLrgZw2ZsnNKmAs3/wq57ImCtXYy
 XvGBU0D7mK7CbEo08MEp2DFoTZWTr9U2CWiKtknfqVEDuNGTvdJmx0T+XTONjT51iVOf
 e36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430060; x=1784034860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hY8gLzk0rHZJeGlxwJxqv4ggljy8LVtQOjKXzqPfu+U=;
 b=tWo9j/6zsyiacEbQ83nwZuLa2JauPB6fIZbmRaNECBfqSjxYyUjF3Cgqam6jVewQZ/
 dCs5YIZ/WcRIDa99+P06Galmckw1I/35DcxPUoD1MHWrYHXTnZfaHzgC5tLV+ONufSG4
 Iyqb5gem8cr7+t+Fbbc69oa+lWWgiPtrVM17oszEeRiOydozl32wq6T0xoQpBcYcEr5j
 +itEkQvUoUY1G29eIysyxzymUJtOHZoRwxxrRBDo/OJQQBEv+DZJJaNyxEe7Pd5/ayoA
 XyzHNfz8z89lxApqzopkNSrVobYepDfQ6aI7582UBf9H0bkM6SirZCsuHwVFLt6KoDUp
 3rvw==
X-Gm-Message-State: AOJu0YxB59D8O+64v9pSJbziyapZJVMt41oaToiOrwlvHanOLB+U3pV6
 psINJhG1ftXF+uIRImg1K2ALWQg1R53idOZoJo79rmj7BysD24iTO+HcQ2Ksq4QBKnY0YU21CbS
 Ht08qZ87dZCbtL/KvSlJpLW7GhTGSmjIdNHSr7FWk/0X9VTK3h3QTtka6sNlBzkIXUw==
X-Gm-Gg: AfdE7cnortyQA4u/dxMXQdZqOuPx5xwpUZ6NUNixX9lKkLQU/gXpNZpYBTSNVpD3KaM
 kABti30eVNfBYpEc2dCYHNDMyxzeWcH6CaJP4C7JmRSouJrkVLv6agcxKP9Z/OQdrmgO7MAZPDY
 VecGUCYji6Ocnt+zsJ5v+DlTbtwmQpF+sTDAglumKhEZpnHhzXoRYMj5J6nC9I+RNYU7aMU16WJ
 fME0YPmVn6BJ4eU8WYNYRneQrzOybC805EJkud4pDxr63YZyCU6dPg0snYw68rdzaPAncThIf7v
 KrzssLuUfr+otra9eq3o9fwoLjH3saWUNXypvHgGEUZ12Jk1K4j/2MWVJOoNjY6E56osMuqlyGF
 jaMNMLOUUuTOO5zfYsmpYk6WVK59eErbkg1JuC8liaRlH41KP7Eh4aVRnCxzWidblWAW4
X-Received: by 2002:a05:622a:1788:b0:516:e00e:6868 with SMTP id
 d75a77b69052e-51c74855e7fmr55197521cf.46.1783430059680; 
 Tue, 07 Jul 2026 06:14:19 -0700 (PDT)
X-Received: by 2002:a05:622a:1788:b0:516:e00e:6868 with SMTP id
 d75a77b69052e-51c74855e7fmr55196791cf.46.1783430059039; 
 Tue, 07 Jul 2026 06:14:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada036efsm133707466b.45.2026.07.07.06.14.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:14:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/32] hw/intc/loongarch_dintc: Fix OOB access in DINT MMIO
 write handler
Date: Tue,  7 Jul 2026 15:12:06 +0200
Message-ID: <20260707131223.51505-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXz1kCKK6HW0pw
 kzvDmZIYdENAEKiHeWqML6kuAoerGMgTTQ0zYjNw8wFZiPbqKtvbXb6yM9fOjjxie22IdbMn8tx
 Lh4eeNu0ZABveWT0zoTlwaVzjprR6ns=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX86AQQdjSAwjz
 xp0bHgCVhRvKf0olulaqSqUGqKewByx1TMhTeLmb3V+nTfRL1vNXhDl/W9bteB0yfLOo86a0qAz
 EHE1dcSCHYCG1oEqhvtTAK2w0DajzN62pFssmgSACoEia61ENb9ES/PVGVLi51qbPa44xDGf22d
 YVyr5Awfm2NqrkoVOLkLKG9GJSWaO/4odiFtnBrKkiFWf9TCjJnoeOZVe/d+JFSu/cbGeot3a17
 C3nT0NvO5G5wGB+W4hnEeDw/DjiNtetczal1CYSHo8MgNb3Pzw1xO9Lsw7eC5YE0wyRRjlPtopI
 1JciMemmGNcNTZYP/8TvGhRH0b+YfBMa9b3Er4MQZLovGs42KMCn6iNQ5tQ486uXxyEMdk4zaNm
 2s8TWadTpx4GhiA53GwkeDu5wkkhUOjVgvm9ySIzNWxN6Fhs3lijY6g0fylt78shIg5jH5MxaIV
 vBsE0yUbBYdafqYMU1w==
X-Proofpoint-GUID: LAr5twWhBrCJODDVUoywEW25qBuJ-UVr
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4cfbac cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=CkMQp57mgodZXwwJr1oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: LAr5twWhBrCJODDVUoywEW25qBuJ-UVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

From: Song Gao <gaosong@loongson.cn>

Validate guest-controlled cpu_num before using it to index the cpu[] array
or pass to async_run_on_cpu(). Without this check, a malicious guest can
trigger a NULL pointer dereference in async_run_on_cpu() and an
out-of-bounds array access in qemu_set_irq(), causing host crash.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3616
Fixes: 0d148eaf5a3e ("hw/loongarch: Implement dintc set irq")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260701065454.1976188-1-gaosong@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/intc/loongarch_dintc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index c877a8003b7..e40292887c2 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -19,6 +19,7 @@
 #include "target/loongarch/cpu.h"
 #include "qemu/error-report.h"
 #include "system/hw_accel.h"
+#include "qemu/log.h"
 
 /* msg addr field */
 FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
@@ -52,7 +53,19 @@ static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
     CPUState *cs;
 
     cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
+
+    /* Validate cpu_num against the configured number of CPUs */
+    if (cpu_num >= s->num_cpu) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "loongarch-dintc: invalid cpu number%d\n", cpu_num);
+        return;
+    }
     cs = cpu_by_arch_id(cpu_num);
+    if (!cs) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "loongarch-dintc: no CPU for arch_id %d\n", cpu_num);
+        return;
+    }
     irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
 
     async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
-- 
2.53.0


