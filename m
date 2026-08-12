Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E131C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8op-0007Ca-Me; Wed, 12 Aug 2026 09:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8ly-00042s-3V
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lw-0006rA-F7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4a9j3311438
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xQgaB14R7ESk7abgkLPNHUg9U3cWnv504LpqQp2HHEA=; b=O2gJemLO2LnoG1oa
 2a5KLhOxRY5gRTatpBUOLDL33dI0JR8zXE392hFzGeJW9ylNBkAVUSmdkkgRUnMr
 XZ7TSenOT4bxgzrZijP8VmxLjlhziyGXGK9lDjvowPAvhtslwvWWHsTOudBs3Z7i
 CEOLLz0hGAykwnY0FUfSzMTSmbEnZBfbKTEibaq9ERsPveodL0Ryj6ehD6Wsl7lc
 hjD6AqyxPUsNMNuBYF8fM8bT+W2u/wQX759IxHPadBOGehiAm0oCVYgNqkWrr7cK
 Ys7tUMtmGJQwdSNgUCcCI7jesCGAx2IsvryteNOFdtrw4q+zyswjiO6VBVEqxWbB
 0Kl3xQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0p3d0uc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5283fa0656dso26674421cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540410; x=1787145210; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xQgaB14R7ESk7abgkLPNHUg9U3cWnv504LpqQp2HHEA=;
 b=EzfStdESs4CgQAJNuoCTGmu6ne+ZfsVTPuRem7sdhBPL8JDkqi3cYsQg88Z7+L2Wr4
 XvoSSh3se6qMmZFd+evHr2I988u+uv2wgN5a5lavcKuxPgPhd7DDw2gEWrBNQH4n/nIv
 MGZ14PljC4ee4mdDaiMzZsDN2qRqSQMAXdIOmrI35sUeaLEw4xPMcqaV1H+Wf7FWehY2
 JehaBgmLqV1JfvhSCSleHiQdp6Iy1kivjwvYN4Q6PsjIMViJQKln/r2LoQFwkX8nN1ka
 Eg+PfCXi1bfAyA35msjee2uDaUVXCrD1buRXWWj+1+E9yVQ1ckX1zLwqQb+pJnXYGOEk
 vAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540410; x=1787145210;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xQgaB14R7ESk7abgkLPNHUg9U3cWnv504LpqQp2HHEA=;
 b=B3ORAH+4/1FYM29QMJcuQ3hoDFbrox7RGg6ZvJkm7mFukK9AgAcdhHgbTGXmhdy0MX
 qEing+whSClmjWusnNwCcafVYTs03TA21FJmIH2hU5qhnSIEU9/itBal7WbOYAe5QeIE
 AYy15CWq6T9abEVoSJh1fjlAz6Hjzhj9ELb0W1yryjHswyHCtHcmoRJBSE07wL7qpLki
 h7NmQgbguaad7ZdJx0awWAItWqYbfijNWPH+L1PsUCENmW6DXdXLzwjGS0nuYnqskG9s
 0dgbKNKondSyKcI8Iu00bZUJ2qi073RbjyCw3KCvdYx6jQ+p93JW1zWwBNrwMgEH5fnI
 mSTw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9Ju8TgOycIr4Iu2MioEm4RjNP2c5PNijcp8ThyHDmsnq+DRQDEwrhea1AEdzy+pqZQ/WvQGEPx1rk@nongnu.org
X-Gm-Message-State: AOJu0YxiDZ7GkvgPI3pB/31ariZjOmv1xPL7gepT9X7zo4JBvpc7FaRd
 blb4xlhiEr5DZGcGL/MQg1M02kGc3SyVmPN28A/fJxcaIWmhK0OCwnQBf54dgZr3OGPo+YAIG87
 LOnplEH/Ee0ixQ79U0ogd7GmitRzNjxhJcvCxUl1/aXKV48LaDu64j+5huQ==
X-Gm-Gg: AR+sD13wzQxiDEs+2sKnqaIJN/0tqmqN8xzcnIOASUwQ/hsYJSQJa8s7KqhNUgRBrSZ
 lpa2wigUIQmk4suQy0VjAGO8rL4T5lZLgRzJa3c+kmdNO8N8DlEMs8WKwo05PQuANGs5VM0es0L
 W0Aow7bPaWqqqgJP96IQwIHtjYVKDC13lhm7D6ztIiq0xv4WUn6Ela6dHTGWJu+5wLMFrq4/0nY
 wpmgUXmWd32yc50G0erM1inQgM6b25N69UhZFd2ba89fHKsnia0RzZGGN+pklldzjTYHU+9HK8a
 X/elecl1FmQVgM4Oeax0KZy6UtgIQKRxudL/Fxg+TlHAABe86/6g7edheFye8onI9m1PiRdX7ci
 G4E93MV+GZfBqo5eOcZPm87yBUlCgTUyH3vjrV4HNJg==
X-Received: by 2002:a05:622a:48a:b0:51c:1f35:4638 with SMTP id
 d75a77b69052e-52d60365125mr67853741cf.21.1786540410361; 
 Wed, 12 Aug 2026 06:13:30 -0700 (PDT)
X-Received: by 2002:a05:622a:48a:b0:51c:1f35:4638 with SMTP id
 d75a77b69052e-52d60365125mr67853141cf.21.1786540409830; 
 Wed, 12 Aug 2026 06:13:29 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d709dfsm7273883f8f.35.2026.08.12.06.13.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:13:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 14/16] system: Move qmp_inject_nmi() to
 hw/core/machine-qmp-cmds.c
Date: Wed, 12 Aug 2026 15:11:45 +0200
Message-ID: <20260812131147.83188-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WGbJnEL3MGLYEXWk5IgRoULTqaYIRMQI
X-Proofpoint-GUID: WGbJnEL3MGLYEXWk5IgRoULTqaYIRMQI
X-Authority-Analysis: v=2.4 cv=UfNhjqSN c=1 sm=1 tr=0 ts=6a7c717b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=rxed6eZ7nxedQE1Oj_YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfXxpZjf6U++Dyo
 r05WRlDkUj9EjJCo8kDfgpqP/TSviZLCa3RQuFP8UjjHwP5d5viAJU7KdvM6VVonjKDp91SguNh
 /ryO6w8W8RFwqcNcFpQmBarcqnbJKdJ5qYLmtwuhZKW+J1auxCz/IRnPopwgik2j2KScoHOZ9HQ
 wTphPVWzb0RahYPGff2K/Nq6S3MU55lVcOAxBh9bTTiss6n1wa67fGG+TCvrO9xxTVesJ9Cy8Yn
 PPaKltuPglipNR9vmNia1D9p8H/8fPc9DzCkQ06o5GeqNOY0zcEWUUWQndYeAwfd96PTgzrIhDX
 PcGyo3BbyG8n3lLoUco23W9Vw5mfDiQWZG2Oesq3nNa1JflPfd0uFsMb50i1wR+yDjcIFaBHqrO
 TN1BLI8LIVAjpCBBvk82ibpdx1hnYOmazzEJeIwj9KAf04c73Rn7ey0/NCtYN5XtmGYJMx2LWXH
 4ZrxSgEBKHUI0aTH98g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfXw1U+QgEN3zLD
 le+2CXsC5QGe82MEnQUJKCUp0fkovfCqI9acdDU7Q4uFtNIKjX7PrZ9HO6WLrB6mFawqy4Vl//p
 i2CNDmTV6vrqX8rAv659IACtzuXVT1E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
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

We figured NMI relates to machines (for their machine-specific
handling), so move the 'inject-nmi' QMP handler with the rest
of machine ones, in hw/core/machine-qmp-cmds.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/machine-qmp-cmds.c | 6 ++++++
 system/cpus.c              | 8 --------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index e62cb4ec888..1aa5f262298 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/vmgenid.h"
 #include "hw/core/boards.h"
+#include "hw/core/nmi.h"
 #include "hw/intc/intc.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
@@ -448,3 +449,8 @@ void qmp_dump_skeys(const char *filename, Error **errp)
     }
     DUMP_SKEYS_INTERFACE_CLASS(oc)->qmp_dump_skeys(filename, errp);
 }
+
+void qmp_inject_nmi(Error **errp)
+{
+    nmi_inject(errp);
+}
diff --git a/system/cpus.c b/system/cpus.c
index 9758cda4636..aa2510bf8fc 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -26,7 +26,6 @@
 #include "qemu/coroutine-tls.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "exec/gdbstub.h"
@@ -38,7 +37,6 @@
 #include "qemu/plugin.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
-#include "hw/core/nmi.h"
 #include "system/physmem.h"
 #include "system/replay.h"
 #include "system/runstate.h"
@@ -922,9 +920,3 @@ void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
 exit:
     fclose(f);
 }
-
-void qmp_inject_nmi(Error **errp)
-{
-    nmi_inject(errp);
-}
-
-- 
2.53.0


