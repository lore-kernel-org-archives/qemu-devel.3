Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DEDC5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtk8P-0008Ll-3o; Tue, 11 Aug 2026 06:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk8N-0008Jm-DU
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:55:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk8L-00009H-GX
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:55:03 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BAMYHc037442
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 45O5ZPkXnN4lR6w4tP5RI9h0AD+uvfX9nj+VXuvU+5c=; b=S19YzL3zy1XujhE0
 Uud+lE/81M3SUk526XQLiqkoj39BJIaaU3adnvd5zDI8Ui6yP0GuhY0avM9pTYC7
 wiZgDDgP1a1s6IjiyIi/FDoqOM6bClhe30NhwKGDH14cMHllUxAE9FCRXHOVlDh1
 OE+DBib9115FpXZsjRzq7o4jTh2vqh7GA7Pq8yWAwnBtPVEcs08lp/c7k75tHYLD
 WSWUAMwIKiRpBURjCebwmFOJsDPt66AqzxhdQQALMsZhRC5z4stUXilz5l2tnvd1
 2eylVV6XXXOyZSMX6gtOl0WXIoeCXCsq0l9T84+U5HXviTAQMnBsRnq7MNTuK8h4
 QSpRvg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk63q8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:55:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52827090cc5so11366951cf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786445700; x=1787050500; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=45O5ZPkXnN4lR6w4tP5RI9h0AD+uvfX9nj+VXuvU+5c=;
 b=dpgkuDjKj3+VsC4+Klt2qswyaWhHdyKSK6v7vAzCzMW6TrBQgHSBg8uYJgRbk989+m
 aallTHyK48HDTxcQqZavglkcDiXCBptrTbbtVGpukjpWB4oSmrqvQhNy0bmZ1DwVsym+
 vij53fdY0pIbEBj+6kYRnwBSK0l/qKe2xQUVe0TWvlRa7B622ZoV2akqcaDykBysubyw
 I1FvK+Yy/9ESfF1UpAOafYOI8xilqAYvznAo2VupUD+cK3hg8P8QgviVjjZPERbT/PB0
 yUdIcwGr7RN+hpY2q6LYWoIqReR6xgdVU9MjLlZzH9svai9vkyzgf72s6RyJ1PAqh1RA
 MUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786445700; x=1787050500;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=45O5ZPkXnN4lR6w4tP5RI9h0AD+uvfX9nj+VXuvU+5c=;
 b=CcrJPixrq66VQ6NF9KhuAi1RHrLYMGbV4Zc9rIxzcgGllDbZCV4F7pCYtrQrR/9xT5
 1GyvHi9FYFb/T5JFAgn40FYt4pbtHLsyW35778kG56693da+u9Kmod6aOy5WgH3fjAU2
 I0rNURB57OYpGGNbAhWgRGtLuVdHrC2vey/N4VmKPrDf03/lDmi+t+1r2UvgQ6ltehtY
 ceH+VRD/vtxXGiAoMh/WkkkDfR7510CSr4j7CvHDGvfr2updbBHd3S3JU8Z3u98N8gWC
 9bO2aNam0AkR4MGsySTMtmCnzDqCAlLDoBFSxrtcdXU2dyVm+/G8mSEM7Fq30AWE6Kmp
 DB1g==
X-Gm-Message-State: AOJu0YyAZcGF+JMgsEa5kEXfS0yWd8nQm8xiBExRGxozgJaKiZvdTdqe
 KDfgC0sgaoLCliXdrktdoeiBybL6KudwxCZMETPaEqAkgAsZV0ZxRJeulwCqP79kov18COO/J6F
 CwYlG9YybIaoxCZicl/JOYXJAOI3bNDMwI4K6+UfEs6dAzyP4TP7r8RFPgHADIzlpig==
X-Gm-Gg: AR+sD12n8nXvW/z8HZ66FTg1EuKiVGM2aggbuox3GKAShjnwR4KdDFXDffS1adbbKs5
 Q8R2W88eB4v6wTC5T6b7PfEfIBdC8uvGJ+kajgPeO0tbaG2QglbVTW4gImAHnvEcTa3NxT2IPp9
 gRHxedJQryeFFKviNNjeR+Rwvi7Zyx+64zJ0eM4kwOmX7uVm2Lnc/ixV6URB4FtD1YcDWps8QZc
 guaPO/vj3pF/PNS1G+nbwiO0mBhFbcQd5NtDMoOErmc9tFQ8X6J1aSnESSc4HI/rIGpuWpawGT0
 c+qP+i4puwINYD10WPLgZEEXbrJvCVybYzmh4ewOoOxlLQh/6fsDy08T27UCNzxlxC0Nq/Qm637
 IONHM+l77fMK0vJttu9B6cE92EOmtweX9b9pfnqqHTzX7dlI=
X-Received: by 2002:a05:622a:345:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-52d5949b962mr14542721cf.2.1786445699787; 
 Tue, 11 Aug 2026 03:54:59 -0700 (PDT)
X-Received: by 2002:a05:622a:345:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-52d5949b962mr14542311cf.2.1786445699238; 
 Tue, 11 Aug 2026 03:54:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a7096c5sm3646022f8f.24.2026.08.11.03.54.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 03:54:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <minyard@acm.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v3 4/7] hw/nmi: Remove @cpu_index argument from nmi_trigger()
Date: Tue, 11 Aug 2026 12:54:22 +0200
Message-ID: <20260811105425.7429-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811105425.7429-1-philmd@oss.qualcomm.com>
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Nb3WEWD4 c=1 sm=1 tr=0 ts=6a7aff84 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=FcA89Dn81BW4c7i3JskA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: rSNsPiGn2i9e3Y31DLx7JpPUcYiQkrxb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX++lYAxNC6Wem
 BCuu68a92Udo4bMotAeNZ9e1+AYHLfMLKQtzVSOVOhQL5thysFINM2Mer4ffbSQU+7QdTdR09P0
 Rj8rYFPATT6Z9BJB67j1HRzgE3HYTZg=
X-Proofpoint-GUID: rSNsPiGn2i9e3Y31DLx7JpPUcYiQkrxb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX8W17iwTK894n
 8klrJVwUFdov70xJ8sZGrFUBqkNTtGjmMAOImd70jQc7RNT9pL/6PO9jZztSCLt3WPBpRQ8HLqZ
 kFJLkNn/k6yuEYM7JPqtZOQvDOrYPG/nuFvzVB7gQxSfsYW5fXq9Mj5KbvTP3pkvuruGduJR5Ot
 8Zi1EdAJBg/Q67L4j+dEl3t30krPHzr4lkVEcnDueK+peA4yXn/hT2lZ7BA7gz+4JioBPM8Zubk
 pFd+wOba+NjGmsfPavdG0Q0Ihmzi8+kprnAYImncS1CjpncL0L46XSGIwihwWXDGwkd2SekCSz/
 Nk/mrFtjw53ptR3/9e3MDKJb9aw0WLE3yC84GMu8HA9B8UKrcUnMZFEOIueWBqr50qPPp1aiR79
 QotdDODT2r/oF7mv1SJAXKxPBXhpccLGoT8kTJocpTHvuvNCffhlWaPYCzOgBurMNMNCZzaI3zQ
 q9NKMYgDLKZjXeGdNJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

nmi_monitor_handle() is not related to the monitor, rename
it as nmi_trigger().

Return a boolean value indicating success / failure as
recommended by the Error API since commit e3fe3988d7
("error: Document Error API usage rules").

The 'cpu_index' argument is not used, remove it.

Document nmi_trigger() as suggested by Peter Maydell in
https://lore.kernel.org/qemu-devel/CAFEAcA-yALySmCJLbitCmYpiZKUXJNOavGJG9RYeo8fKqz7gcw@mail.gmail.com/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/nmi.h  | 25 ++++++++++++++++++++++++-
 hw/core/nmi.c          |  9 ++++-----
 hw/ipmi/ipmi.c         |  3 +--
 hw/watchdog/watchdog.c |  2 +-
 system/cpus.c          |  2 +-
 5 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
index 4c4ce79071d..e77c382452a 100644
--- a/include/hw/core/nmi.h
+++ b/include/hw/core/nmi.h
@@ -46,6 +46,29 @@ struct NMIClass {
     void (*nmi_monitor_handler)(NMIState *ns, Error **errp);
 };
 
-void nmi_monitor_handle(int cpu_index, Error **errp);
+/**
+ * nmi_trigger: Trigger an NMI, in a machine-specific way
+ * @errp: pointer to error object
+ *
+ * This function triggers an NMI, in a machine-specific way. The
+ * intention is that this should typically trigger a guest kernel
+ * dump or reboot, and might happen as a result of user request
+ * from the monitor, watchdog timeouts, and similar events.
+ * (For example on the x86 PC it triggers an NMI on all CPUs,
+ * and on s390 it triggers the RESTART interrupt on the first CPU.)
+ *
+ * The NMI is triggered by looking for QOM objects which
+ * implement the TYPE_NMI interface, and calling their nmi_handler
+ * method. Usually it is the machine model class that implements
+ * this interface.
+ *
+ * Not all machines implement NMI handling; this function
+ * will return an error if used on a machine which does not
+ * implement NMIs.
+ *
+ * On success, return %true.
+ * On failure, store an error through @errp and return %false.
+ */
+bool nmi_trigger(Error **errp);
 
 #endif /* NMI_H */
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index ff6454437c1..662f2051123 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -22,11 +22,8 @@
 #include "qemu/osdep.h"
 #include "hw/core/nmi.h"
 #include "qapi/error.h"
-#include "qemu/module.h"
-#include "monitor/monitor.h"
 
 struct do_nmi_s {
-    int cpu_index;
     Error *err;
     bool handled;
 };
@@ -54,19 +51,21 @@ static int nmi_children(Object *o, struct do_nmi_s *ns)
     return object_child_foreach_recursive(o, do_nmi, ns);
 }
 
-void nmi_monitor_handle(int cpu_index, Error **errp)
+bool nmi_trigger(Error **errp)
 {
     struct do_nmi_s ns = {
-        .cpu_index = cpu_index,
         .err = NULL,
         .handled = false
     };
 
     if (nmi_children(object_get_root(), &ns)) {
         error_propagate(errp, ns.err);
+        return false;
     } else if (!ns.handled) {
         error_setg(errp, "machine does not provide NMIs");
+        return false;
     }
+    return true;
 }
 
 static const TypeInfo nmi_info = {
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 74818ff3cea..444af726d75 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -59,8 +59,7 @@ static int ipmi_do_hw_op(IPMIInterface *s, enum ipmi_op op, int checkonly)
         if (checkonly) {
             return 0;
         }
-        /* We don't care what CPU we use. */
-        nmi_monitor_handle(0, NULL);
+        nmi_trigger(NULL);
         return 0;
 
     case IPMI_SHUTDOWN_VIA_ACPI_OVERTEMP:
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 0842fe373ae..026768e9fb2 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -81,7 +81,7 @@ void watchdog_perform_action(void)
 
     case WATCHDOG_ACTION_INJECT_NMI:
         qapi_event_send_watchdog(WATCHDOG_ACTION_INJECT_NMI);
-        nmi_monitor_handle(0, NULL);
+        nmi_trigger(NULL);
         break;
 
     default:
diff --git a/system/cpus.c b/system/cpus.c
index 97e5a5edee2..5c0a192c01e 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -926,6 +926,6 @@ exit:
 
 void qmp_inject_nmi(Error **errp)
 {
-    nmi_monitor_handle(monitor_get_cpu_index(monitor_cur()), errp);
+    nmi_trigger(errp);
 }
 
-- 
2.53.0


