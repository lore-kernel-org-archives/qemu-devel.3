Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F87C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcCI-0002HZ-0c; Sun, 16 Aug 2026 10:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcC3-00023j-SU
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcC1-0001dy-ND
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDmBXX4145014
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tLKPs+ARtkciTR4oRVHUxqxK6J0969Mt+2v69gcFJp8=; b=gPCLZTFXG8Dk/IsY
 eH0L8mDhHFCdBWjSe1VAI3nS7YboRk1gmsjCzkeJQYE2lv8sOuVAVTyod6wxSjI0
 cyJX3QjF1adQaI91WpnBJQz0x7eVQDGVnG8E6575tWaeB/ZaqFmzVgs3xHJIyUYL
 4gMw/tLRTt3/DKh6Nz+Nd7ReuPGRz+CxsOrmb8LVou2ySV5R5vr0TVDiOOw3tSqi
 GtCfEptN/psD4HDtcJEm3lWOBgG33Xxnud+V+50c2e7M8I4/L9fSH3X1LH26ll8h
 3vqfnLlCqaPGiw0clhC9+Q1hIi29LIqmEM2oWXULZWxxGOiz0uP8YpeGHCrU/+oQ
 arzuhg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwkkfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso49087481cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891831; x=1787496631; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tLKPs+ARtkciTR4oRVHUxqxK6J0969Mt+2v69gcFJp8=;
 b=ZqSAHxMRDjwfoud5O9CgXfj59QyeI3MvcvZruStMsCnDwHeHkb7k36skeoTcK8muqS
 goqEOeeBkUJJ7jkYWqaqSoL1jENjxa0CqyF0F1J/PWZEjbU9RqZNtE0uaa99sjgsWc37
 5K+dCaFdU91J7PeFVtJS+X6vjCIlEW2uwv0BebgRr9MSTKnlkdkgFNj7rPHgmtLNK1b9
 0/5we7vYaNXBqfjh+dC382uy+WXzltcNYS+ModBXUzltMOwn1xjvTXcY+UBLCjODE3sq
 wlfj3yfzXKO61XkCKiNgQVa9AcxYXaS/qQsxfd0SRCwRt7a5fkQ0DK8ygNyw0Esxm6bC
 tuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891831; x=1787496631;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tLKPs+ARtkciTR4oRVHUxqxK6J0969Mt+2v69gcFJp8=;
 b=FZKmGchYq5kunRgvuCPGf9idFMrARDNxS1ENZ4URrT57b34X8EgD/V9typtyR/CUDZ
 JBlA5OEGesTbpNLT4rOFpyYIofbZx6DTUo7+IHMoyGuqJ9QSZwNurO0DuMVnp2IhLUHm
 9TfNyufgI9p2jPqT84ktRWI96xMFmqsYcq6d/7AXgBMvAOrBbJhOFzepsAxVdi1y7s2K
 RzKnu0mLNN6BUSqyWCkJ62HzS0/Qr1JJbjNzY/zci5CczQcCLuB/E9K2Ko/xKRAUudaZ
 KfTZGkjS6kj5Wz7hPgiIhLcb+TEY4RfNEfccOtqu9LPpMh8kOrpQZsdmkswaXsuwNTjH
 +NEQ==
X-Gm-Message-State: AOJu0YyC1U+5aIV/RTVgGUrDNTOCXxiVEWLl3ggVPKgQEdKGtDW00t+I
 dXhcJh7fLXV/RBay7y6P6KaOLvsFrRPojxZJ+OgZesYAilab8llubSfQMZa33jxHlsYkj7YGA1v
 nD2Jn02Ms8s3OegEUBowJKeiS8A8zyI/Du1JrxL28EX/ItCOiB+GO3mdLpmSu7h9sZA==
X-Gm-Gg: AR+sD13pe6vgMCVrJPKd2GVppkHlAoBYubNh2ibKsk8oUcH3PyI/QC9UqclOP1BFN7/
 +FFKYdLLzSFHXY9irNazfnvrSLbPHkMQy8X0tdEQS91lFSHau+G5kFvPlfIzx2V/L/oquXZPJQQ
 OYst3H/94eln9SkFxs2IS74SnsjJepV4gWztObCn+2TDI2C3PPxJZ8/WJ+fr+2V1Wvlz8rFvPKi
 GTXMr7/TQaYP056/XUVhDck6clRMb+BhmJffdoMuUZOeda/hQNh7bphZu8GCOEPefRRs55IB89u
 rRZ3UwRtpSI1VeDOst4qMTILaWMjYl6aZ0AbzvXfQ/8t3kZbKYhepJy0HzAkyJyvyPPMUgROX29
 f3HjiEY7e4a7hT7yjRKhg/uIE+IJnMm7jU8w2WfxcaQ==
X-Received: by 2002:a05:622a:40c8:b0:527:7842:72cc with SMTP id
 d75a77b69052e-52d854e5526mr221535301cf.39.1786891831043; 
 Sun, 16 Aug 2026 07:50:31 -0700 (PDT)
X-Received: by 2002:a05:622a:40c8:b0:527:7842:72cc with SMTP id
 d75a77b69052e-52d854e5526mr221534861cf.39.1786891830556; 
 Sun, 16 Aug 2026 07:50:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f1ffffdsm25230095f8f.2.2026.08.16.07.50.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:50:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/56] hw/nmi: Remove @cpu_index argument from nmi_inject()
Date: Sun, 16 Aug 2026 16:45:31 +0200
Message-ID: <20260816144556.69009-33-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Q7w82qwmnMMBcBM4RpDLZKn0IihVcrYZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX/0PrQqwvMNzk
 7wBPqmDn8cTdn7vAvZRDPCnoXjOhigg7bIs5JACxmJMaHy7GutUT1QvLrBRtlJhY65LkdtGP19V
 rUlGk7OKElmoL9252fyu8zJQ2l48sYCGzcHk88OAUvMIukqrZ1+i17gG86OfRcKsclrsfCz2SrD
 uLJJ9EKlhx57YctcUdJOD98oHb8xaFOpITwWx7naWcmyBgEl0gN98n/ufLCbRao47fYIeymZnvf
 A9qNemRhuC2UBGAFPtFyLxSKtLR5xQu0nqdFvf5ojoHr01xXkNspTDaPC1vw5zVXvSMvxAXY4wz
 D3dK0JfgJJF8m5vGZ920OpGcf8YAT39SxlRbGz1r8sc4kUTtzMk9AvYdfOKJ9zM7lfgnA9bgINd
 21Ah+LidM4E4z/6s6WCJgVjJd5xpO2QQbxv5ROcTRmNbEDZ6UvQj0Xb297Ka0EHcECioAvwg56A
 F7HgV3YkLtU/Dg7cSSg==
X-Proofpoint-GUID: Q7w82qwmnMMBcBM4RpDLZKn0IihVcrYZ
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a81ce38 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=BCSMXUZzsmg2-BZsF7kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX3aMsB0v+9FWC
 vPCjjKQoSQ1zsrjpcuDz/A1v5L+DdHl5GfDSnxjlPEK/jiWvOmqHjxdk3qqQJYTq1RJgZ3rwJqC
 G410kN3RIawIaansU6gwxCTmPd9DCDA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160118
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

nmi_monitor_handle() is not related to the monitor, rename
it as nmi_inject().

Return a boolean value indicating success / failure as
recommended by the Error API since commit e3fe3988d7
("error: Document Error API usage rules").

The 'cpu_index' argument is not used, remove it.
This officially drops the current CPU for HMP command.

Document nmi_inject() as suggested by Peter Maydell in
https://lore.kernel.org/qemu-devel/CAFEAcA-yALySmCJLbitCmYpiZKUXJNOavGJG9RYeo8fKqz7gcw@mail.gmail.com/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-Id: <20260812121232.71958-5-philmd@oss.qualcomm.com>
---
 include/hw/core/nmi.h  | 24 +++++++++++++++++++++++-
 hw/core/nmi.c          |  9 ++++-----
 hw/ipmi/ipmi.c         |  3 +--
 hw/watchdog/watchdog.c |  2 +-
 system/cpus.c          |  3 +--
 hmp-commands.hx        |  2 +-
 6 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
index 4c4ce79071d..851be28257e 100644
--- a/include/hw/core/nmi.h
+++ b/include/hw/core/nmi.h
@@ -46,6 +46,28 @@ struct NMIClass {
     void (*nmi_monitor_handler)(NMIState *ns, Error **errp);
 };
 
-void nmi_monitor_handle(int cpu_index, Error **errp);
+/**
+ * nmi_inject: Inject an NMI, in a machine-specific way
+ * @errp: pointer to error object
+ *
+ * This function injects an NMI, in a machine-specific way. The
+ * intention is that this should typically trigger a guest kernel
+ * dump or reboot, and might happen as a result of user request
+ * from the monitor, watchdog timeouts, and similar events.
+ * (For example on the x86 PC it triggers an NMI on all CPUs,
+ * and on s390 it triggers the RESTART interrupt on the first CPU.)
+ *
+ * The NMI is injected by looking for a QOM object which implements
+ * the TYPE_NMI interface, and calling its nmi_monitor_handler method. Usually
+ * it is the machine model class that implements this interface.
+ *
+ * Not all machines implement NMI handling; this function
+ * will return an error if used on a machine which does not
+ * implement NMIs.
+ *
+ * On success, return %true.
+ * On failure, store an error through @errp and return %false.
+ */
+bool nmi_inject(Error **errp);
 
 #endif /* NMI_H */
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index ff6454437c1..2d890f2995d 100644
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
+bool nmi_inject(Error **errp)
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
index 74818ff3cea..dedf23cb997 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -59,8 +59,7 @@ static int ipmi_do_hw_op(IPMIInterface *s, enum ipmi_op op, int checkonly)
         if (checkonly) {
             return 0;
         }
-        /* We don't care what CPU we use. */
-        nmi_monitor_handle(0, NULL);
+        nmi_inject(NULL);
         return 0;
 
     case IPMI_SHUTDOWN_VIA_ACPI_OVERTEMP:
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 0842fe373ae..5f764a0c1b8 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -81,7 +81,7 @@ void watchdog_perform_action(void)
 
     case WATCHDOG_ACTION_INJECT_NMI:
         qapi_event_send_watchdog(WATCHDOG_ACTION_INJECT_NMI);
-        nmi_monitor_handle(0, NULL);
+        nmi_inject(NULL);
         break;
 
     default:
diff --git a/system/cpus.c b/system/cpus.c
index 97e5a5edee2..9758cda4636 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "monitor/monitor.h"
 #include "qemu/coroutine-tls.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
@@ -926,6 +925,6 @@ exit:
 
 void qmp_inject_nmi(Error **errp)
 {
-    nmi_monitor_handle(monitor_get_cpu_index(monitor_cur()), errp);
+    nmi_inject(errp);
 }
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index a29f02b623e..43ff220b5fe 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -869,7 +869,7 @@ ERST
         .cmd        = hmp_nmi,
     },
 SRST
-``nmi`` *cpu*
+``nmi``
   Inject an NMI, in a machine-specific way.
   Not all machines implement NMI handling.
 ERST
-- 
2.53.0


