Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDBFC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8oC-0005rT-Bk; Wed, 12 Aug 2026 09:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lG-0003lp-0r
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lA-0006WY-Qj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4W0j3637934
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DrbbpvJ8PS4d9Wmp3LH1rQVAhWTDBdxV8i64qa6nA5o=; b=U1JQ480wDXGjhnnU
 pc75/axCtaoL/6t8g2Co73qd/tKlNo5OjpARHJ+ZqzQWGm5QK8d+luXHFl0XGE3v
 ocHDEbptVuJg1WSRWe+z+o2POqm2SKIjzgVHrCYS9YkkBHCd3ULVsRTj410aUiaN
 iqSxxBQ2srqaI3Jtr3kyxTECj38/TzrVz363gRA1gbXi6LGjY3BqwbuzW/gB2p2u
 EYgCnUJAQO4p0OiqduP8r1l05QESk1JaIX3EniNTAYnMxuswV9xNv+EEqBGcizIX
 RiHkElamEYtT1NnkXBeMReRxFddbOvtTQIlDbXkbSO4HdxPPDv6sx92yUUASCPHO
 BGh58A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0jgrhrt6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso17233261cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540360; x=1787145160; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DrbbpvJ8PS4d9Wmp3LH1rQVAhWTDBdxV8i64qa6nA5o=;
 b=JiQvrMwM0Jc8EkJJaJSHe65RfeA1aLDjSbADdzWQMQawY2LezsBWMGP2dy4SSxjUgM
 Nq5ECENeDtVuEc+I9tL7KNgnan9YXgTGW44BC8z5EQ7JrIKNI5dqmrDrTYEHtLnZRpAU
 q8ByYYZB14QlYNZcU05bX/uXlguhzru4Lksz3d3/yQfqK34I6bX7fdv6OYR4ckyRT0ki
 3H8hgbpA0IdqrNOBUd96vGHF6ejhuOlsP6P6w+OiNOzuuYh3PllhawUnE8pJUVvQoaNZ
 MLWq1m37ETTHgKDuwJB3/Cb86l+ulcL0Jmoc5COeTkz1Qj4l6QYdXFIu8/xdItHbLh44
 tCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540360; x=1787145160;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DrbbpvJ8PS4d9Wmp3LH1rQVAhWTDBdxV8i64qa6nA5o=;
 b=R2jdWzScJQXvhu9QiroPjVxG+1PbHUscquttoncW0UTyTpq1wi2+1/02lkuKqIYZPt
 dkOycN/RV5mqMp+7cmRKcuczkV6tV9tKlbcOnfwZJmW1KbyDgl1U28X+Wl3LlUMXMOQ1
 SQdGWhinoxn8SY/dUqlHFVmtFRSGNk/u+83OypkQGC9wAfrZvwM7SJFn2CXnCKolM4hn
 5oZrItjQzki+q6bTFaalP31TRos3MnzhsO/lVxuyxgpy479xmALT8Q3pRs5+MVWxMQO7
 PDW9732bxbrXU6hYMUTd+kkEzYITvrjRbZXBqc4cU+dDuyRDuV+IE5lALHcmbEaWoF7D
 ZuNA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/Pfpt/KDi5Nb2qvEIaVjzeovO3yZpeO1GDNYh6q2xH7kP0YSydJGMjC+hly1LNVP9ALZ4Fm2GUDOH@nongnu.org
X-Gm-Message-State: AOJu0YzECCtXSJARcMGv5sCWvEZ2rbsRmWLpMFOnpJ07nlrv1R7V4dhu
 Xz+IT/i7k6qfrSTIDhr19CBwj0sah4vm62ca4Tsj1m5c8niKWmyFB6WO4KoOUGid94euBpKrvOc
 Ycs1yAaNpLvyPTUjN+dZt4Og/8Dxa2uetPOyq0KTIT7tljYbMy83gusg+WQ==
X-Gm-Gg: AR+sD11q7vh+b2+UE9Me8gqVUwSiySBGGbmX+C5nNYRZ/eRaVY8rWMgyVamlLTmIII3
 0jBrARoW3LPqHc6KeOeel9p/VGb6qQ68gudrqWQysRaZhlj3Lsq8wLJRjRT+fwdJtjYXDBFmrLX
 HAGRc4pV97YNqhQPyheRWWkRp2mktvMcpuuolqot4BDMcrdoq5/vQ58DL9vbj8p8IlRVFxyOB6i
 srrajWlqBQcDgG840rT5tR+nx00Dyy6vcd/YqNtL8s/mAMHDHrqPrHNePcXWFbIhkaTBrmYPaSN
 zUImZAMJIhr+v3CcbAm0xhBITjiOhltP6ykIjPwNihVX/KSMiuuFdbEagvW2r3WStGmykNzXhk9
 r5GN/vrmmycZ4L2/duFafY0d6bGeZNVDIPz6r/veY3Q==
X-Received: by 2002:a05:622a:341:b0:517:87df:d8ec with SMTP id
 d75a77b69052e-52d646b85a9mr36207781cf.9.1786540360317; 
 Wed, 12 Aug 2026 06:12:40 -0700 (PDT)
X-Received: by 2002:a05:622a:341:b0:517:87df:d8ec with SMTP id
 d75a77b69052e-52d646b85a9mr36207241cf.9.1786540359885; 
 Wed, 12 Aug 2026 06:12:39 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d4c10asm7363884f8f.20.2026.08.12.06.12.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:12:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 07/16] monitor: Include missing 'qemu/lockable.h' header
Date: Wed, 12 Aug 2026 15:11:38 +0200
Message-ID: <20260812131147.83188-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX45smvRU/T2ox
 GggUfzzx1hlJXf2En7JvbJXtDzNZyTjyo6rex7YxJ+UauxeOmkKnRaT5nDu0atlAbYJj0CFqaXw
 ATLJVd6qjm/4iwI25lEajiCjAqITiBcwqOiqHlKCi9W2yTh8dEzS4syb8XsYnO0JUfpuFwIrham
 RPhPK/496CXSeQC6OLNWYT8kKBGlAzw7iUNvOrRm8gpGOglIuxPc78ho9Nvt2oqfSGW9vJd8R/l
 E7YT0mQ5Bi+ergt6Jfq0ycWBXZRYKblpbhSi3juFsevhbrpReHcwgmWMAdDQBfV/k+Yu7Ip0kMy
 NHFDOFuu4ffFjI01Adf+toFukXSBZ2deJjnDGXwJTB5qD0Lwaq5+vQrns6Lpm3nSt2WiK32hT1X
 fBnV4kg+G8gWbFaUPi/4JFywiQAPme1a8qdSEt767yqArkDEirJb4N1XD4jIaSyIDLMG7KyL4wN
 9IkhJL+hYKxY91RQjDQ==
X-Proofpoint-ORIG-GUID: hVYVJ5Agq3N_GJBTaY3neqWBa1ij1euN
X-Authority-Analysis: v=2.4 cv=TNJ1jVla c=1 sm=1 tr=0 ts=6a7c7148 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=_5bDPQybseJbp6lUwYQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: hVYVJ5Agq3N_GJBTaY3neqWBa1ij1euN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX8ejfSB8foX0q
 JeeLEyzd2SseT/44MdZiitWDaHT4WMX03OR1RxS+i+TQEMtxSss3mDcxhEnTXbH8xbGhODaUrXa
 rcc39NS8ERA74YN95Zk9pJpg47ZveHs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
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

Files in monitor/ use the QEMU_LOCK_GUARD() macros, which
are declared in "qemu/lockable.h". Include the latter to
avoid when refactoring unrelated headers:

  ../monitor/fds.c:146:5: error: call to undeclared function 'QEMU_LOCK_GUARD'
    146 |     QEMU_LOCK_GUARD(&mon->mon_lock);
        |     ^
  ../monitor/monitor.c:176:5: error: call to undeclared function 'QEMU_LOCK_GUARD'
    176 |     QEMU_LOCK_GUARD(&mon->mon_lock);
        |     ^
  ../monitor/qmp.c:164:5: error: call to undeclared function 'WITH_QEMU_LOCK_GUARD'
    164 |     WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 monitor/fds.c     | 1 +
 monitor/monitor.c | 1 +
 monitor/qmp.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/monitor/fds.c b/monitor/fds.c
index cc35d2ec334..abe5f13487d 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -29,6 +29,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu/lockable.h"
 #include "system/runstate.h"
 
 /* file descriptors passed via SCM_RIGHTS */
diff --git a/monitor/monitor.c b/monitor/monitor.c
index c75ae815343..6af09f2f6ea 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -32,6 +32,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/aio-wait.h"
 #include "qemu/error-report.h"
+#include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "system/qtest.h"
 #include "trace.h"
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 6ae1098d39f..aec03157750 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/aio-wait.h"
+#include "qemu/lockable.h"
 #include "chardev/char-io.h"
 #include "monitor-internal.h"
 #include "qapi/error.h"
-- 
2.53.0


