Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84822C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcF2-0003Hg-Tc; Sun, 16 Aug 2026 10:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcF1-00039Y-8x
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcEz-0002ZZ-NF
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:39 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDl3fr3951098
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PE/JZHUx/aOfGfcCK0a/H5DxkVxffzTXH8TBVthfIy4=; b=AKNZQXzuNWcpIR6Q
 byQbuuAC6Lh4HDB+dahQhUhVxdqNYWR0U26OGWGdtWMkDh1bpASkZ3tgBemBx65w
 iZ25Rp05fXwlGJl2xm30qBdQ5X7w0wSV9tEvY/reA9nU6tz24INukDpEGPF58Qew
 rJjC1ltUC0IoEiO+fVzY5XmspIJnI7h8jqaxvAmgEfWr8wnSrGEAmcH4jfyLGgNL
 rmgEDmtCzTvCoPtTADxGVFj5c19kyWIl0Ywnbdqeo7c2ZtcPTdvpGJ5aMx5fI5qI
 Lmyc84G5gyVzHoJrY2ilr3IaMaU/940yBlL6uLbKh0Btnu8esTp6MHpPGq8sD+q7
 RLKsXA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghnumkh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso23460861cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786892016; x=1787496816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PE/JZHUx/aOfGfcCK0a/H5DxkVxffzTXH8TBVthfIy4=;
 b=RypVkLD4EutEnkFCx585AeJ+jfoFNh/E+qazrGcqIG8Xx/lAfMJZtYSzNaDSL16pHR
 DLcnleLm/A8IKDiUErWgqtKaKvgJKFoW1QTyAvuC1tPHcNhgMm6zprV+aIgusOloCa7j
 qiUWL0rvtF/fuzGSZhhMnWMpt1UfauOAsKZRwfsovBU4h7/p4Tg1bT6EoC0jJ/Sw1Na+
 oVUoTssloBbHcN/iWcgJhjtjSu+GM4Jswed4gLM5VFuNi4VdhZFZU058PxEIooKCICtk
 pYf9WNQ4sEIOgKbyI8/TDJr4vrpFrlZVFsvgueDhcUe5NarACAqyW0a7Mak7LmrEMeqz
 wI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786892016; x=1787496816;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PE/JZHUx/aOfGfcCK0a/H5DxkVxffzTXH8TBVthfIy4=;
 b=kx5tAv6hR2Ee62mkAE6cnRI+uznxOWL+j4H599ozDzDaWVOSMK01Fq4aE7bYQKAw8K
 ZhPvYz0/TJovYuj1KZw3AnEtHeJDQsD3eVljTBUFViyxNEDUSrniF7/utpq6+f+E7XLO
 pTh0oskafKCTadQOOvIy46iVGmtqzwSPOC56KPxLbQ1RECas+BJAxL8Mxs+7ho6SAGfz
 WzRAXxtLqSjun3fWYvAlvRM61c7E3HXNlYM1zmADkywIyOGKK578vzS1mYfCGbAwHraO
 RFJBUo9oHzeOpz2JPOTUHpp1EinS8SuT4q/PKAhfzE4iTZpuAXnrtMl3bItov9S9tk0x
 odNg==
X-Gm-Message-State: AOJu0YygWvU1wCSoQ7BQWI4ONBY5czm2tHvUzzOOqmcuD5l2AE5wNdbg
 KS+pPdFgDhyinL28rJUrGY1JLV/67eoTmPSWlyZHMbj0INPhjmmOPXOo6FTYJFaLNajEfqxlraQ
 zIqByuevorS/joFRcq27v3SrxjHtsl7XJUFgOlhqj/In8/EgIH65UjcjnofTZApNbJQ==
X-Gm-Gg: AR+sD10Fbphx5SphxCGrW5tfVFD6j0zeMArItyBf6wUuo4kRHCW9P4Gcbg/mGNYBbX+
 5JC1kUvTtm2Jz82XjMp3c7wOramdjrr4I9R+eMAoRvg5qpz94w6OaqakPREq/1a8lCtpBS7ASbl
 34WQxORKP/rK/ITgRUYx3akyuWr1kCiVCFPgbPrPkBDrV84RoIiCQCXs5wxKMQlyX+MnO+ZaVKx
 6PGYutwJyBAsMcFX8yesqB/z6wIfqwAHnf2eQS2Qtx/EC+TCvVmzrz8nu9KvRZEz9eII9hd1t+h
 UFPsCK4dDM3teQOCuq+P8tPogRwvyZAt5lVR4lJlvyOWZaKBYgir9Pqp9yW3G3lAVSwqDSY1nMs
 TJCn78lYAQi+oPhkU+ET88oJoVgcJeyLfNNJZcr8Ywg==
X-Received: by 2002:a05:622a:250a:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-52d74baa1femr319301281cf.22.1786892016182; 
 Sun, 16 Aug 2026 07:53:36 -0700 (PDT)
X-Received: by 2002:a05:622a:250a:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-52d74baa1femr319301021cf.22.1786892015740; 
 Sun, 16 Aug 2026 07:53:35 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm66904775e9.6.2026.08.16.07.53.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:53:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 54/56] monitor: Replace container_of(MonitorHMP,
 parent_obj) -> MONITOR_HMP()
Date: Sun, 16 Aug 2026 16:45:53 +0200
Message-ID: <20260816144556.69009-55-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX6K+Yfb2A1nLh
 OCTZmn5YuEaEavPdNv8HqJ9BLmVXm1gbe8CEdJGTTdgV9b27Eqc5A/OAiwvdbXTy459K/ZbLynn
 TLowTDUebGQaCXddkTSpgdqUorM6Pc0VNbmzSsdxQKmwN+KIfyIl93nBrdu+Mmw2xz5mEVErzE6
 TRcPEvwGIR+LQ3HCpBonux6fRjPTVy6Y1+L+GsHP+YjrC6f1B/nweMujs1MY9fI2ysjYBfL1ToU
 rQiNcMo7rWAAsNLSvmjp8G7+RdwSYFWS+/FT5g59es9MlwGf1X1jDrwWKG/p5P0sgVezuPL6ja+
 /grdPs2wMI+PSLZyKOjIsWvbFPCRKmOyISGdgWTG5P9TebkbWoVt3ascj96PDEZrHrKIefR3qA/
 Rsz7+ZF1eZXuNP6UhMqb75/ivSQ93KOUunJWPDwf/jMhSBOJNZhcqPbq4WdO2cQ29S4K7osNCbs
 eEywNgia3IO9Ez19Yfw==
X-Proofpoint-ORIG-GUID: WJedrZNsXS-P-7EVdxFFAsvsXke7dJnr
X-Authority-Analysis: v=2.4 cv=QN5YgALL c=1 sm=1 tr=0 ts=6a81cef0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=BI3AvNoh2EkR8V5c1rwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXyQb0BRZrx8qd
 NsHYQLRGZQLoJdKEQgxZgyN+HOSvRz85kZZHtfc/rvTX9roHVOfJSGwpvEFInxTyJYkzymSs+5r
 Fni5sAHXv7F+ejbVAMi329uQUhUczMo=
X-Proofpoint-GUID: WJedrZNsXS-P-7EVdxFFAsvsXke7dJnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

By replacing the container_of(MonitorHMP) use in ui/ui-hmp-cmds.c
we can remove its incorrect inclusion of "monitor/monitor-internal.h"
header, using the public "monitor/monitor.h" instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-23-philmd@oss.qualcomm.com>
---
 monitor/hmp-cmds.c | 2 +-
 monitor/hmp.c      | 2 +-
 ui/ui-hmp-cmds.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bcd0a1fc878..4e8d996dbb5 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -290,7 +290,7 @@ void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
 
 void hmp_info_history(Monitor *mon, const QDict *qdict)
 {
-    MonitorHMP *hmp = container_of(mon, MonitorHMP, parent_obj);
+    MonitorHMP *hmp = MONITOR_HMP(mon);
     int i;
     const char *str;
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 46f8d4a6ede..22b1972d346 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1520,7 +1520,7 @@ cleanup:
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
 {
     Monitor *mon = opaque;
-    MonitorHMP *hmp = container_of(mon, MonitorHMP, parent_obj);
+    MonitorHMP *hmp = MONITOR_HMP(mon);
     int i;
 
     if (hmp->rs) {
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 24cf3a67104..806a7bece7c 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -19,7 +19,7 @@
 #endif
 #include "monitor/hmp.h"
 #include "monitor/hmp-completion.h"
-#include "monitor/monitor-internal.h"
+#include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qobject/qdict.h"
@@ -343,7 +343,7 @@ void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
         return;
     }
     if (!arg) {
-        MonitorHMP *hmp = container_of(mon, MonitorHMP, parent_obj);
+        MonitorHMP *hmp = MONITOR_HMP(mon);
         monitor_read_password(hmp, hmp_change_read_arg, NULL);
     } else {
         qmp_change_vnc_password(arg, errp);
-- 
2.53.0


