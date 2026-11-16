Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520D606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PqjyGm5s;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JYKkAtre
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT657-0007Kh-LK; Mon, 16 Nov 2026 18:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT655-0007D5-4p
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:47 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT653-0006s4-Eg
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:46 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfNrR612161
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fOHbAKjEO4upw0qf0JFR3dVv7hTwK4iUKoBI0YHvfXg=; b=PqjyGm5s07TMAkQy
 o8I4TFJaRUl2tI6yz4ri6erHM8StHKRkCAPrx3iFONBC0w3EIaWBQMRGG1JMEfPY
 zFwN8XzxfBe74yCRUz8/Ux/eCfpiYD7IZLPp1NyMqT42QppYjxoqkoDS2BqBdKT6
 Qgu8oNs5D2WxYK0+RSz25DEIfhNgcyJvflfY3KBm7Dfi4nb73kQSIXrnTW8+Q99Y
 heREUyo327nhR1JzMCouLAIvzcH6A0K6gsn6C5p1eg8Orc5SqG+e6uad0AePF9xs
 EuAOkrCVLT+qc94lHdeu3JEUKA6lm9dOk/X4aAAjKVc4WeGAvKLWmXCMhMgbJFhT
 7+w9pA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyy6gk405-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so394926185a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871544; x=1795476344; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fOHbAKjEO4upw0qf0JFR3dVv7hTwK4iUKoBI0YHvfXg=;
 b=JYKkAtrencXp+fRSGgQT5DveNSGgXyyaa4eorabFt5L8eui2CTZJh90kr08QxwNUnI
 voyQ9I3ITx8lLDc2ng/pDLg60qgHySOX1nVa+Rrm1QxsEEiN+VWkc1PcOXWASt/qDrL/
 10E95haaVLK6dZdagV1k5doukLmlAj0EhtOJ+pvRnvMpv9dt7s4KfImml+OKacA6VKAf
 zrjz058Rgs56Gyj6NO7jseyG9PnFtNRyDflygqqkSkq64iyu7YZRKV/DUskSNACVVn51
 UPggSYf1hNaviCy9j5lUsG6UrIRd1QuUaZmh20j+2SIbcBuNmrCyHKn+gu2PIQooAvkU
 jf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871544; x=1795476344;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fOHbAKjEO4upw0qf0JFR3dVv7hTwK4iUKoBI0YHvfXg=;
 b=vqNgTrRHS0v6yeVmvO7HUI2ODb0BgIjenB5te5OsMksxX9F59AoofD9u1Osg9jwhJu
 zepMNRDq1+mRPYo1A9WW1m5osyKYW8Y5+0JdVwsI0tzp+EOMusF5iwy7FL57R9QpgKve
 gmFINC5SLw9VgT6Fy6dwyNbu3NpwlBkz7Vl+1zDH9dyKPPnSwZh7LSeqD7FqwAqXmBt5
 9AwaXkunZl3Fw/KU9nnfDlI4RCxv/jhq7PE/3JRGIQbLsqtHXq9bShbZVG7o1TLf9l7N
 g0DDKmFO2pcRgbYUshXkllMGfH0N5vkuVaRO/zfEW1ImCXp/cWDjWXQI5m+Ylr0MUH6z
 Dy+w==
X-Gm-Message-State: APuU4Z8FgzUGdxaH4s985K9GUEJ22ZFXczofQMDfddEtmMhtgoYjCRqW
 gZEoRhEFaftoL3nzMk5SawM2kfKX1UI7C38aqsrEih2y7NPJ2u8ZGm2UFYbBaNG7FsEHX5SAoaZ
 A2UA7adVQ9l0YmSpP/o6k4J00f7hUkfQtdlSTM1YIogmDXp82atMbOVRb0x4QQR4gKg==
X-Gm-Gg: AYBFou0g3+TZa0EmZiEJ8Ov/PBb4CE+8Gj6I9ze+5B7GYVeutgLcml/BfO7Ol2TkIv0
 ugU2cZVh2Ch93klgWZpD61J+aB2VTqaFc/Agt/NBrvirYyFNvvjBsGrCgvr7ksideRtNA4C0HRx
 FgVREr7jHnhnasPgZZlnvSQQrX9mSFqSePETShw44EAY8xU4MW50lbrpHR5RKShFZrjcFm2+m+S
 plTatUg5p4RRmRg44GgqLqfX0J8btRPc0brdK/LJR7WoS7wOn4TMVAmRg0R2dd2HSSxmW3s+Aqb
 0AGwKpU9AhGwp/d5NFZy3YoShJcEB49Egylu9N6sxM+357mW+RdOvXCt/Mzw5af26Qpvin+42HU
 +87UQyqDISv3VCl2x9pAukufyujBb5upZqWH8QGqzFmmw1MTZ3PmkcxSN+ppHwsvRBoHtgFMOGk
 5ab7sExAVy6Grtdw==
X-Received: by 2002:a05:620a:17a3:b0:93e:e425:229f with SMTP id
 af79cd13be357-9494bb957d2mr2122122685a.77.1794871543860; 
 Mon, 16 Nov 2026 15:25:43 -0800 (PST)
X-Received: by 2002:a05:620a:17a3:b0:93e:e425:229f with SMTP id
 af79cd13be357-9494bb957d2mr2122119485a.77.1794871543356; 
 Mon, 16 Nov 2026 15:25:43 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe373casm23990462f8f.30.2026.11.16.15.25.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:25:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/22] hw/usb/u2f-emulated: Use QemuSemaphore rather than
 QemuCond
Date: Tue, 17 Nov 2026 00:23:29 +0100
Message-ID: <20261116232335.31593-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX1hu31EHC0Xtf
 3QJNjmwr4HRl9Ki0w9bxW+7jkgcxqjOL3pnWB1yy8GBBGpKgkkIZ1Q0VjY8g8mtcXKQe0uI13zZ
 wonl8djmSRXvtNEEat/Zh4b/zvB5rOcAyKBFIsdfu0D3X4TG8043HZ2Lx7LEYn2zpbimsD8YTBe
 XO+J4gHuaaqZ6YoMpwv6dFZBadw149E4Q9OUKeS8qp1xEtvnk2ujMDIF4LZ6M60IRbHJhNh4+BG
 BeY87Yf1/5PA70OOqou83VCFLcLAe+4+44nw4tHm8oqk9Stp713zRvqQtUcXUv1gb9kaVuXlBPs
 4NRC5R3VAjOwW5EizBZZPoipziiE0VIcHarsHFVJyYbHpOhzz2IIGZjEe+EHcyitOT7uUp3+SJw
 QE5AW0WFVF8/HOES1CSuHH1tAv5D3/H/6n6cBNx15lzHIu2wARWp2YZEuqSo9E5HiV9toexmi7+
 PUc+4imyU1AExQF4lkA==
X-Proofpoint-GUID: yjbPmJl4W6nZ6dzRYqt0aUCHDnzaRiQF
X-Proofpoint-ORIG-GUID: yjbPmJl4W6nZ6dzRYqt0aUCHDnzaRiQF
X-Authority-Analysis: v=2.4 cv=D/DSufRj c=1 sm=1 tr=0 ts=6afb90f8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=B8pVnTZ1yy_fOrvyf7sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX9ZuQuwdt8Xed
 xWuCW3LeHrXQOSnuWFEWFttBkgSqoOn3QO7gPaRVp3DITuXLxoVBllW/7zhXrQl+11nkbM2O5zU
 P5oPZi3SClCQdxUb7oNy3qmFCoELO4M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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

The emulation thread only waits to be signalled that a packet
is pending, which a semaphore expresses directly. This also
avoids the Coverity complaint that the condition variable is
not used in the standard lock / while (!predicate) / cond_wait
pattern. Same change as ccid-card-emulated in previous commit
9590693b1d29 ("hw/usb/ccid-card-emulated: Use QemuSemaphore
rather than QemuCond").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20261116223625.24296-1-philmd@oss.qualcomm.com>
---
 hw/usb/u2f-emulated.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/hw/usb/u2f-emulated.c b/hw/usb/u2f-emulated.c
index b82a31501934..0aabfc514b7b 100644
--- a/hw/usb/u2f-emulated.c
+++ b/hw/usb/u2f-emulated.c
@@ -90,8 +90,7 @@ struct U2FEmulatedState {
     QemuMutex pending_out_mutex;
 
     /* Emulation thread and sync */
-    QemuCond key_cond;
-    QemuMutex key_mutex;
+    QemuSemaphore key_sem;
     QemuThread key_thread;
     bool stop_thread;
     EventNotifier notifier;
@@ -148,9 +147,7 @@ static void u2f_emulated_recv_from_guest(U2FKeyState *base,
     u2f_pending_out_add(key, packet);
     qemu_mutex_unlock(&key->pending_out_mutex);
 
-    qemu_mutex_lock(&key->key_mutex);
-    qemu_cond_signal(&key->key_cond);
-    qemu_mutex_unlock(&key->key_mutex);
+    qemu_sem_post(&key->key_sem);
 }
 
 static void *u2f_emulated_thread(void* arg)
@@ -162,9 +159,7 @@ static void *u2f_emulated_thread(void* arg)
 
     while (true) {
         /* Wait signal */
-        qemu_mutex_lock(&key->key_mutex);
-        qemu_cond_wait(&key->key_cond, &key->key_mutex);
-        qemu_mutex_unlock(&key->key_mutex);
+        qemu_sem_wait(&key->key_sem);
 
         /* Exit thread check */
         if (key->stop_thread) {
@@ -331,10 +326,9 @@ static void u2f_emulated_realize(U2FKeyState *base, Error **errp)
     event_notifier_set_handler(&key->notifier, u2f_emulated_event_handler);
 
     /* Synchronization */
-    qemu_cond_init(&key->key_cond);
+    qemu_sem_init(&key->key_sem, 0);
     qemu_mutex_init(&key->vdev_mutex);
     qemu_mutex_init(&key->pending_out_mutex);
-    qemu_mutex_init(&key->key_mutex);
     u2f_emulated_reset(key);
 
     /* Thread */
@@ -349,7 +343,7 @@ static void u2f_emulated_unrealize(U2FKeyState *base)
 
     /* Thread */
     key->stop_thread = true;
-    qemu_cond_signal(&key->key_cond);
+    qemu_sem_post(&key->key_sem);
     qemu_thread_join(&key->key_thread);
 
     /* Notifier */
@@ -357,9 +351,8 @@ static void u2f_emulated_unrealize(U2FKeyState *base)
     event_notifier_cleanup(&key->notifier);
 
     /* Synchronization */
-    qemu_cond_destroy(&key->key_cond);
+    qemu_sem_destroy(&key->key_sem);
     qemu_mutex_destroy(&key->vdev_mutex);
-    qemu_mutex_destroy(&key->key_mutex);
     qemu_mutex_destroy(&key->pending_out_mutex);
 
     /* Vdev */
-- 
2.55.0


