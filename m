Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4ADC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5c1-0001FX-M4; Tue, 07 Jul 2026 09:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bs-0000ck-N3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bq-0000RY-V1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C94Dc3720529
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FUCPwIQCIt5SOIGz15lD15kcfqAqh5dcGYn2DSOINHA=; b=MhGX/Fz3FyzTATZj
 4sjFtnUsav6HIf9eZb2V7VOjPi1PTCDIyQUBxUgYtay/rM+qQRxnZrdK4WYSzk8v
 gmVFsfWc7Hz2PsXHME6xikMKdA1PYq6nQ7SyTt8Y8RJG641//defBAGAFLF0ZjXh
 lRSPOmtD8FRJgSCfke234SpyXQ1URu63u7p5UbU82XGaHACwmX3fG9p39ZFC2AIH
 AoOSqzT2/ZnkQLPGvfQzIbTSUO6pchEejLI97QHqFBTb3uZDwg52dUxq0D7CNflA
 yMV1Bayci5zD+LvLVXL3kQRrQFkCtT4mNZGgfd0FA+bkpWknx8XBkGgdWOt+CTH6
 dVy7Ng==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t9mgm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:13:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso87206911cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783429988; x=1784034788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FUCPwIQCIt5SOIGz15lD15kcfqAqh5dcGYn2DSOINHA=;
 b=K2d4nBEh3dzJcFr9BsNIT7bgzAl5Tvoof7iwkOKKyQ59meU7uBcbVTnfeIQh3QNAI5
 PBwXtKFyTfNvdSqygbjO0HXexenUXAKiAzTGSbIgh3DDCOWQvxysVqwZQYAs0rs0wpdg
 h+ocYFq8CmR0ssoAYIwshUQ7eE5oT14dcRhCu5UzoxoBZgZVQbCK/QAnr1kjyW9XOSW6
 9QBIuZMPB8qLATI64qbZkBOCmG/GpVc1pa3CgBJdxjZA+mRlFuu71g4N5Kax0bVuDkdf
 B88S1DJUNzfJkJDjmSbn6L4LGtcf8IDilTfke4KaQhuxi3zexWjqbQkjb4uvps+fyccY
 1mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783429988; x=1784034788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FUCPwIQCIt5SOIGz15lD15kcfqAqh5dcGYn2DSOINHA=;
 b=JPk+pNoHDQ/iO5ANlWzO6U1T90wFdzBXc5fy5LykHg6IkO5SZgqO5p78poK/0HaqqV
 HQdBaeE0BJrBDOMZ0bYTOEBTaZaX3gkGupUvJYQcEHFPlkRpH48HcDT+yEPe803OSlKQ
 1wMarm7mVb6k1RO7yUAneuC6uvIio5+MQNmT5ai1mWEC3MlGmP4nt/+0h95q9AsvJjTa
 ZnI8ogwySKH1EiVfpOuz0frEaX4G31Rm40ToHoyJwKT8SACyKOAVkNTuPcW/NVOq0gx7
 CkU1bayVgMQ1lj9EBcUWJh/YhQg8NT73GNtgzZ8G8GWxJLoQVsgfXfprrySYLRx/AaX9
 Fvmg==
X-Gm-Message-State: AOJu0YwhVCsjZ9zi2kVQXOPRN1pdbv//HFbXslKoEjKTEK+bRBKj6Xh+
 DmofTz6qjj08qw6JnxxRHE7wW8dkAzlt+4A04phWnlEMw92plYzQfg/NS6TbpktEI/yknPfXCa0
 rvTO5+7TAvVC01jOU3/1Ft6lLb6+m3Qt57q1nVnR/qHRgDbq7cOO3+VWYbZjr7EUmcg==
X-Gm-Gg: AfdE7cmj70Ls/RBDj9LvdxDt7TN6dXzS+bcVo9egTi/bymTNRmAXoV83/qCnRAkMuYK
 1d8HjEVKwkifUfypKK53mYYb9cfQOJBaDkO2NBoSg49v6KDCAXvEq1TeSMAuzm6klV0ftea1V01
 TqV7EAIrz5OYsP3LVVqfsQRKiVHs3T7D+zo1qQSdi3ynJjo/v0xCUSJf6cZMDauS5H5WvfPuBWY
 D9jrcbFNMeC/nV65W46nM+A1njCzo5wTsaoQAyfS1bXLW0fzZO7ia2jPSY5kJx7wvzLobQDCP+r
 tJrid2P0f2hugdlq0Gd8KUi8l80JiUBWFtCOrU94x7MudDquCvCzRpr5scvBV3pcOS6IiCfxjYo
 d+4FA5xNFUTDodAYMA3ydJY72NctZIKTSU9QaKRUHrrNDcpfp2gGzSYocwwzoBJr4uTxW
X-Received: by 2002:a05:622a:52:b0:51a:8c86:bd4a with SMTP id
 d75a77b69052e-51c748d5a52mr53319431cf.71.1783429988120; 
 Tue, 07 Jul 2026 06:13:08 -0700 (PDT)
X-Received: by 2002:a05:622a:52:b0:51a:8c86:bd4a with SMTP id
 d75a77b69052e-51c748d5a52mr53318481cf.71.1783429987323; 
 Tue, 07 Jul 2026 06:13:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15b634d60esm90106166b.7.2026.07.07.06.13.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:13:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/32] util/filemonitor-inotify: Use QEMU_LOCK_GUARD()
Date: Tue,  7 Jul 2026 15:11:56 +0200
Message-ID: <20260707131223.51505-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UWjW9HU4pExEqiTTJUo4eVxI6vTeUXJ1
X-Proofpoint-ORIG-GUID: UWjW9HU4pExEqiTTJUo4eVxI6vTeUXJ1
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4cfb64 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=jD69X8wp-xb9194rqy0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXwJio6YFVoYJw
 uXtBY5eagG4/1r2Yib42gzSf0RTbfXaWWWHcH5bxEZAAIX22z8e5pg6vc4wzOwUmfnj60Ok5QFg
 3XKv/2LJeCQXfP1zbRU0FQQureEzuZNSzFbGnMFQ1gN2vojStZNF4eYKCwb/i+fDsXfk3v/cfFO
 R7+B4elKICAjOsxDfQNzT0XE1jO5jD1jYwc5VZ15E3BEVag/m9EB1ILdI9mnZc/rDVtWXjfvFb+
 Tt9kxtPxyd/E5vRpU/z/C+8wJ/kL34aoCSP99WvEDbMF3p/jxdhikYDbPVPs5BpeiUrQrHbX0fX
 VuL+H4R/vS7XLyIUssX2/XX8ZeJXg6Q6XkLZBcuXiPmEmcbQmetFh+PoDuqEk64UzegeIvHusOk
 G1PYWcLmbz+imH5crOokXVzYVPTUkvgYeU6Ltg0+Z8oeLVt+vt4n80DnAvZZob2jeJetblr5wwV
 fLmc8STFIPxVLj+4z7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX2i/1wci9mSqG
 uHGCxGZQoCkEZuZWtDgthGysTVTc0+p428qTzFZclu48QI6DCdpmWN4qNOwq7Wlcpog4HvYY3L9
 xMnHjeUxYLniZZXi4lk6CQRumYqv/4E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

From: Evgeny Kolmakov <randomjack94dev@gmail.com>

Replace manual qemu_mutex_(un)lock() calls with
QEMU_LOCK_GUARD() to remove 'goto cleanup' code

Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260622073647.3721-1-randomjack94dev@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 util/filemonitor-inotify.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/util/filemonitor-inotify.c b/util/filemonitor-inotify.c
index 7352b9fe53e..fe2057f820c 100644
--- a/util/filemonitor-inotify.c
+++ b/util/filemonitor-inotify.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/filemonitor.h"
 #include "qemu/main-loop.h"
+#include "qemu/lockable.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
@@ -59,10 +60,9 @@ static void qemu_file_monitor_watch(void *arg)
     int used = 0;
     int len;
 
-    qemu_mutex_lock(&mon->lock);
+    QEMU_LOCK_GUARD(&mon->lock);
 
     if (mon->fd == -1) {
-        qemu_mutex_unlock(&mon->lock);
         return;
     }
 
@@ -72,11 +72,10 @@ static void qemu_file_monitor_watch(void *arg)
         if (errno != EAGAIN) {
             error_report("Failure monitoring inotify FD '%s',"
                          "disabling events", strerror(errno));
-            goto cleanup;
         }
 
         /* no more events right now */
-        goto cleanup;
+        return;
     }
 
     /* Loop over all events in the buffer */
@@ -151,9 +150,6 @@ static void qemu_file_monitor_watch(void *arg)
             }
         }
     }
-
- cleanup:
-    qemu_mutex_unlock(&mon->lock);
 }
 
 
@@ -257,9 +253,8 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
 {
     QFileMonitorDir *dir;
     QFileMonitorWatch watch;
-    int64_t ret = -1;
 
-    qemu_mutex_lock(&mon->lock);
+    QEMU_LOCK_GUARD(&mon->lock);
     dir = g_hash_table_lookup(mon->dirs, dirpath);
     if (!dir) {
         int rv = inotify_add_watch(mon->fd, dirpath,
@@ -268,7 +263,7 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
 
         if (rv < 0) {
             error_setg_errno(errp, errno, "Unable to watch '%s'", dirpath);
-            goto cleanup;
+            return -1;
         }
 
         trace_qemu_file_monitor_enable_watch(mon, dirpath, rv);
@@ -297,11 +292,7 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
                                       filename ? filename : "<none>",
                                       cb, opaque, watch.id);
 
-    ret = watch.id;
-
- cleanup:
-    qemu_mutex_unlock(&mon->lock);
-    return ret;
+    return watch.id;
 }
 
 
@@ -312,13 +303,13 @@ void qemu_file_monitor_remove_watch(QFileMonitor *mon,
     QFileMonitorDir *dir;
     gsize i;
 
-    qemu_mutex_lock(&mon->lock);
+    QEMU_LOCK_GUARD(&mon->lock);
 
     trace_qemu_file_monitor_remove_watch(mon, dirpath, id);
 
     dir = g_hash_table_lookup(mon->dirs, dirpath);
     if (!dir) {
-        goto cleanup;
+        return;
     }
 
     for (i = 0; i < dir->watches->len; i++) {
@@ -342,7 +333,4 @@ void qemu_file_monitor_remove_watch(QFileMonitor *mon,
             qemu_set_fd_handler(mon->fd, NULL, NULL, NULL);
         }
     }
-
- cleanup:
-    qemu_mutex_unlock(&mon->lock);
 }
-- 
2.53.0


