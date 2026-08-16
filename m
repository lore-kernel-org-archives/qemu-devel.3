Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E9EC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcDV-0007p9-FU; Sun, 16 Aug 2026 10:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDU-0007mY-FU
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDS-0001vY-Vl
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlp8j3534411
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +6kkrKc0NGsJRZ7Uf8rORc1ZAV4QXY8MKZweRgHzMNc=; b=noie6PBEskCvDLKO
 7V+UCd70P3Ph18stqILyx7NTIzHfwpkkS3lVg4sZBuaq88RE751IDipVloZiu+Zi
 iMd8qHKadfSYbzd+mfeWTWpve6hWzWf+dWlkyinG8MsYulMqABLuGrNx4NDg81DU
 EuVF6WoVix8SNrZxmRLAVXSTWBvbfw8UqiOn3qz86eNkqGvctO2BsPP7zv4quSbb
 FbdZMXzr5GuE4mSfQIO3yW9dtqoZzfqYB9TxdHS90GZt933OJ1lrhWLA7hHqDAGM
 tEQzmxGc2rSIJrDGehBx2TvsopxhxPoi6W/CmQb0FOM8AEMpKRbPPLAFB8NmiZW5
 fuOMeQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf3mp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52cd0374265so55867171cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891921; x=1787496721; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+6kkrKc0NGsJRZ7Uf8rORc1ZAV4QXY8MKZweRgHzMNc=;
 b=VuVcEEL6bpw90K+kLhHwad2dhUkhMRFGB8RkYnh/ReaHRfj94xaw4QJwW1+7PVY2LM
 XEh/q1xCHUuYecYz+3yMoZJScdBFWByKirJ2DfL04bOc9n7cU5zYrMYLmlxG9wb/SYC+
 rsxwhT9z4gkNHqYlZTjmssuRXgO64pgBgwfc3+UHoyJ4fhqaq7NB972bDOdmtq4KA2xk
 QUNYmrlRRRXPLvY7DWwlQdn4c0b0dy+JQLt1y55CNrIWP1+71BdyKeT4Hi3DOjZ1Hj0o
 OzitzgBFbakrQCY7U+q6IZ0euCUApcMioXVm6KEK+S7Mh9Wr1iDLf9MZ6ekCkLvENQ+O
 DiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891921; x=1787496721;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+6kkrKc0NGsJRZ7Uf8rORc1ZAV4QXY8MKZweRgHzMNc=;
 b=s4WpzGkVknx3YMeCyIT38STKF1l+RXXAde/FqiieOOaugDh7CxrMI3TIkwdtNPIuYw
 3rStoZ9kht1udQC9TN0iE03imPk3t9iDswh3vTMWWki6ZhOwm7pEGHsCA1G/f8XxTik1
 zOsv4EvqjVT++QRhJO2gSLHlYR5cBuVFCxkVvLmrli14sf5ml7fGdBwwyNRgf72reYOx
 w1VjAMg2QSJ3KKNWfTSf+PYl3nGQuVOhX/c1zL08a+vcKL7fd9FZRyTBYsJ5mt3KeRcX
 PAomY31Him84kUzz6HWBEErDUfxSZr94ECh45fzAPTGTV2udr7XkzpiPhvxt1ImZcdx8
 hLMw==
X-Gm-Message-State: AOJu0Yxk+BAwBvbdrt3C9QSqc3bcpg6u0s6KTbNXo0g+c+2lncEElTXw
 QSMEeM1+w2PZWeyudnvfXTfFY2fYWbhrLcXRjGzPcOhtzsT/vD0k/B4NEdN8hDV8ab83UEVSsiD
 Ixw9grdbKqNU4QFBe0YvvK5T6dKmX494/WGrKgQB9jNQUaCWeB3JU9TcQGlS0TRwSvQ==
X-Gm-Gg: AR+sD11/UF7QjtGqLuOcuWd3H1tdiCfzp1eGjbx38afRWnmEGqh6q9Y5yT+hYfZGK42
 sI4Vv3FFS7sDofKUGqoZNZfRfWWYuk7e9DDgQIwXPYZjV/7Ce9xKyut3yD5vKliHLhAeHFP/FWN
 mK9y8nis2saF5p6j9ZDuWTwbywHwN7PJhSDraKcjps7CzNX8VGFwZneUnQP0Whl1LeU91FJYvTV
 Ba0hjP4Qt9xokX7vQhCQ8n+HAMGLjinVnbDRoQN/2ewmraLG4KodZ0fWOSUkaxEEAzCChy/1REs
 aRyDHTVa+5mDFFVvCN5Flx7nAgFGwQsoVsvXScSv4Vekd3m8PSn9HArwScAjLzefcrGm+IXZcqh
 c1s0Wwspw/tPtmczWWxLJa7oqOI+J1jV8ESwEXiWI9A==
X-Received: by 2002:a05:622a:ab02:10b0:52d:8841:ef7c with SMTP id
 d75a77b69052e-52d8841fb96mr122547031cf.31.1786891921505; 
 Sun, 16 Aug 2026 07:52:01 -0700 (PDT)
X-Received: by 2002:a05:622a:ab02:10b0:52d:8841:ef7c with SMTP id
 d75a77b69052e-52d8841fb96mr122546881cf.31.1786891921093; 
 Sun, 16 Aug 2026 07:52:01 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999611bf65sm47890055e9.13.2026.08.16.07.51.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:51:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/56] monitor: Include missing 'qemu/aio-wait.h' header
Date: Sun, 16 Aug 2026 16:45:41 +0200
Message-ID: <20260816144556.69009-43-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a81ce92 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: rWOrH8WZSQjW5Uvwx6sGl1WZFjthu0Wn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXwostYclwFOYE
 /BLUJipRoDqyIdsSBrxwnOdcKw8ejMW821wselGNuxdr6+Oz5Uql34S91Z2y8rv/5UFd250v8Br
 SBUx1jUZ3jZLX4c7Aog/DE0tyfcJJOzZ8TbkBc5ACkWM1/eHUJDk0fnsOr3U1dxLyQr7zvN3ofx
 diGGjYiOkmmICu/UKBop2CJ6R0bABQ8AgvpWBLK16bZcfiETV7Sc4enXoy6vCVwprN0jWL3VWga
 KGZEcLepTMzvODdQ7o8NVYiFoOpQM9ZxEGKpMMkKn8WzY6yGgIUcO9eyAEObV8chUvB5ONStxdN
 Pwge2lPxybr6Pj7NjyxhRk/HzvJIAtQdpwF3J3bJJObL1Ml7izjuJm4FkkAiU+fXXTxm3hz0ZHF
 VwvKXAN3HxlIDl8dVC/SVyoGgUg66ydxymsVvHO63NkNVS7LO7bo7rM0ArAYE9b7+oQ/p2nCBRH
 S/z8SIP5Kwof8E+OEyw==
X-Proofpoint-ORIG-GUID: rWOrH8WZSQjW5Uvwx6sGl1WZFjthu0Wn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX6AV/kIkfcUgn
 XgcbYHDRKLEKa5dzGHtzNPf40hW1zY0lkmM7WcpIzuMY/0rmGzAAmr84uyodZzx6XzqMvAdQtl2
 YQnaS5I/MTNONhPU4a/Ai9BvHThNoww=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
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

Both monitor.c and qmp.c use types / methods declared in
"qemu/aio-wait.h". Include the latter to avoid the following
errors when refactoring unrelated headers:

  ../monitor/monitor.c:648:5: error: call to undeclared function 'AIO_WAIT_WHILE_UNLOCKED'
    648 |     AIO_WAIT_WHILE_UNLOCKED(NULL,
        |     ^
  ../monitor/qmp.c:792:9: error: call to undeclared function 'aio_wait_bh_oneshot'
    792 |         aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
        |         ^

Fixes: 9ce44e2ce26 ("qmp: Move dispatcher to a coroutine")
Fixes: a5df506e129 ("monitor: implement support for deleting QMP objects")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-8-philmd@oss.qualcomm.com>
---
 monitor/monitor.c | 1 +
 monitor/qmp.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index ed195fd97bb..c75ae815343 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -30,6 +30,7 @@
 #include "qapi/qapi-visit-control.h"
 #include "qobject/qdict.h"
 #include "qom/object_interfaces.h"
+#include "qemu/aio-wait.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "system/qtest.h"
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 338d37cb7e5..6ae1098d39f 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-
+#include "qemu/aio-wait.h"
 #include "chardev/char-io.h"
 #include "monitor-internal.h"
 #include "qapi/error.h"
-- 
2.53.0


