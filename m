Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321B1C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu80P-0006jq-CT; Wed, 12 Aug 2026 08:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80N-0006is-F7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80K-0001ow-VH
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:22 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4PbY3664882
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fB3X5i66McZlK+dR+cm0eP6FmuNHMAXpD6GH/8ebx+Q=; b=ESzsr+QzGtN8F5n3
 SXqi4q1ZB2Wr9nWvFczsWv93xXd2RNPmlmrnXFcfJSb1jncUsiJRMlukOMA2mqm+
 vERhtnU/hKoJ1jKLYMJcTskM9bVIhIEi7/mDR8airh19Hrhe8uNBeZRFuwpa97Mk
 nn4ONfHiZdNM5p3aHRpngrvFo1griz124Vr7t78lq9No61TBvzJhCFg0VbMyf4k9
 JfUDr1DPIzhgZsw3om/JbT0f0dvgV05gwW4qElXQd0SSTcZpGpSNnpt/PYrfEfD6
 V++BACEvb0igQagYFrLzMY2Kitqq+EGDNgBqw9tO8gKoTmWfiW8Ik7qkbsDi8FVT
 fX5vzA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0m6rh4us-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52827090cc5so11179391cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537458; x=1787142258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fB3X5i66McZlK+dR+cm0eP6FmuNHMAXpD6GH/8ebx+Q=;
 b=JbGetD9ej/d83COCp2UPOxs1qwoXP+UI9FThxyx0bU/BAh6PIq7nOvWe6TS3nIfdVd
 Bx44fPF9GZCZx6iNl+ScWzU6vfA24G49+m9BFjKKZd2p/3qaMQ+/o5pZfM7agDC4OLSF
 sPv3kHKd6AtAWe7UIuPBEJJLiuqpvKJ6NoI5KmqpDBsMMtgyYiP8kVV1kF5VQn/UiGEz
 Zmz7s63HzhU1E6TuovEDw4H17iEUaKpxqVCD29JllRLJawEa8nwbCOHgHunXOIjNkkZJ
 EgAHdjkvmjlpgXDtsc1cT+cywWHgngxk5038Hx3fdE+iq13vWUOauyrySdBE/+NuF8sg
 2Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537458; x=1787142258;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fB3X5i66McZlK+dR+cm0eP6FmuNHMAXpD6GH/8ebx+Q=;
 b=B9Ree+uuRn7qGQwDBqn5xRos0gahAWmq7o4SR9WleTkARa49+NJWn/EZ3Zz+/wS00k
 uSvsqtnrYp2mCG4GUbPTkbIh7Try6TzEX0DKHswu7Ec86UeWSZQdfRS33dlkqwWM5//y
 CErKUBxRuysoivUPPtlqvasJkRVRFrGPxqKg8l2iog/k6/y1syZKj+YRVb64Jb7zjRl0
 585pWb357t9QRl/tB6XkXwghlbNQkPRuhZIQIpk9AuzCTNfXfyXxPFcUBd0/s8bjBqBp
 SixpcRk0O0vQsEKoUzKriMDF/SPZTVnxaKETqiEQnDcUiXxIJSu3Ivs2FUQ4y0U/28J3
 tKrQ==
X-Gm-Message-State: AOJu0YzGPegkNb0bAsY1uWvbXA7UHM+ihFKRuRxyBx1gyv3nHvAMGvmh
 77YFM3ZKubfR8H34T07TR9xAAiI9tYyURUMzDPYC/jN889rXdHn0HhW75XkAWe8FZ9Dhzw/8HkW
 oPWAL1KDGfFkrYVCAfUFg/QhRq5D9sXeXN5OD5Nb1d5EbgIbLckRfMnMGx6ycIWfqSg==
X-Gm-Gg: AR+sD10jsA5163fFzS7AANkTvIy+jNnOVPMi0XnchcOreOlt8YBWi9O6L3hWPPGlyS2
 XaupeEd/LESjn9UtO+9Ma/IeINtn9sk+IeNu1dY/aR67uTnIHTGBpwi6dykDO4k9I+5uzXfryKg
 ISiXe1hq8DTdHZtQQ/GmElTuH+NtYSGKEQLTAaMEbhfANimM93Rgb5Rl426PEWc/MmVyCVBO6/+
 3Q1+LVooI1CNXVy9SJfgnLTlUejTleoJUcom+5Iqn0XVQfWIaZfqmWJkhkdgCrJYJijeC6jbASN
 cfgaRLnVomwkt78Q5tg/eWbNObCtK2MgKrB0rYAZWGe48C8wl5PdOaihCy+OYysiVErkzb2EpmT
 suO+BuwLviZHOjNjLxZ1q684VxIYBnN31dtEI2Rb0bw==
X-Received: by 2002:a05:622a:2285:b0:516:7a83:8c37 with SMTP id
 d75a77b69052e-52d602bc56emr68918121cf.11.1786537457785; 
 Wed, 12 Aug 2026 05:24:17 -0700 (PDT)
X-Received: by 2002:a05:622a:2285:b0:516:7a83:8c37 with SMTP id
 d75a77b69052e-52d602bc56emr68917701cf.11.1786537457337; 
 Wed, 12 Aug 2026 05:24:17 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d4e0cfsm6782672f8f.19.2026.08.12.05.24.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:24:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 06/14] monitor: Include missing 'qemu/aio-wait.h' header
Date: Wed, 12 Aug 2026 14:23:23 +0200
Message-ID: <20260812122332.72975-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX8/8G+XaXr/v0
 5lcJhnXJEeSVEAmhXZst/xxNdPh+JxyCzPrLYrQCcQrSE1trvcoCft4duhZhy0Hn9WOuAkLa809
 XvKfKVVW+Eo5Vv9hAEUdhN3h+ipdt2OrSmEpnEPtsGS8pNR93tsSv0XJgfLQfSmg92dglFfsCuf
 ezjbbxv772C4Zkd0Dl3uD+OTAqTE8PKCCPf5oSIh20GPPZ+SkIZ/SHaFKkujRTZK7JFto3oq+Qp
 UUs+XipZMdq3cUBBI5C9EBUcIyenlQ9wH8LFL165sz4NXyJLPkaqac8AD6cpFCdQLu0v9ORq6a7
 RH14/X++1xGjnbjDfkhJiosEXIBlWpImXRUu7Oy+mnQBWf3HSbsi+9Q5e8MNyOwZIFhQ1E8DC45
 SY4SLVEjvRmuIXELOUm0Y4FzA1Xja44XzUeH7U09X6vo8zg9BAF/yAR8NwUop8AynxQxMtebzZA
 2WkepkSv1t15NB2shgA==
X-Authority-Analysis: v=2.4 cv=Wb08rUhX c=1 sm=1 tr=0 ts=6a7c65f2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=xCX-Xho1F_OFkwux1AsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: _k0R96DMHtHbJ2lgF5bCSnDSUQ_6_qFL
X-Proofpoint-ORIG-GUID: _k0R96DMHtHbJ2lgF5bCSnDSUQ_6_qFL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX+4ICwEGhh35x
 LcJOimi5VZ4qta6J/yGdjUQBQ3oEMOx5tnT5e4GUoeHyrl0aynWU9UckHTPcxFNzryB2WcETsBV
 7K/v2wx5JsJDVQRmfIhJglJFISZ9XVk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120100
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

Both monitor.c and qmp.c use types / methods declared in
"qemu/aio-wait.h". Include the latter to avoid the following
errors when refactoring unrelated headers:

  ../monitor/monitor.c:648:5: error: call to undeclared function 'AIO_WAIT_WHILE_UNLOCKED'
    648 |     AIO_WAIT_WHILE_UNLOCKED(NULL,
        |     ^
  ../monitor/qmp.c:792:9: error: call to undeclared function 'aio_wait_bh_oneshot'
    792 |         aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
        |         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


