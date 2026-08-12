Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEABC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7pW-00072P-OJ; Wed, 12 Aug 2026 08:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7pU-0006xp-B5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:13:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7pR-0007WF-Nh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:13:07 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4CB5569131
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +D8rA1Tq9MPno3w70GrJ/i26NF9WPbxp5pAHVjnjEx8=; b=JXn+Y1A+mhtEQbOS
 Hzlvu7y/0QRRad+IteCgNeZ9v6o2miM2Xf1bTjpiHcjnCfSBZGIdgju4Wj1E5Imd
 XbOqpyHe+vMBoKFr38uB6e2vYa4pOAVYCb9GcvaDmjA/8RwhYX2ZukUyQh/3dNqD
 1bvToJxlo6m2TtHp1+4j2OOQhiyZx0y2Z0vGhEN3I9PloH/Jv13YPEpCqesPmxg4
 0NfC/14zLSwzN5j/1qYSJbMfFFU9aBht6X+jM1Gjz+AC/GVyTbqPaEOV5ExLkGBf
 InSH50584FPNSxhqrZ/Zc5KZ08kUvExVSZ3C36P+lMBACVy0NNxsIM4VQSC73T44
 pf1SDw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nut8pb5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:13:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bf321d786so14675541cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786536783; x=1787141583; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+D8rA1Tq9MPno3w70GrJ/i26NF9WPbxp5pAHVjnjEx8=;
 b=YZLpUoupa/m66DoFPhnUVJjhkP1UgtssZAv0tEIxBABCzJj//9idmJp1Y3cy3q/MAv
 i9zJ3IXSoT4SHvtLRyybAV87OzDDeWwrykqiToNwhz7sP+bp7GrrJZqHEK31uJ7ua2+7
 NcGtEWIsjVxqWrwBGVjYtIyj0/OSd082jCWMM+TVLCeMyRRIihm4kziZ1N99aGshqe8D
 SBOXxOTeilRaoInHPN6cair8LEOoUH/MKyCF1z4CIfOcR4MjBWgOUQvZmnyd4VhpQU0z
 f04JstsaJ4LUK+uAOQT29NVk4x8GTtm93PyQWi7uxf74dcko/TsrLyWwOTQtTi3nwguU
 t1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536783; x=1787141583;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+D8rA1Tq9MPno3w70GrJ/i26NF9WPbxp5pAHVjnjEx8=;
 b=b/FwOqd9+5x7BueFXCyT5G+9b5hLHMeG0VzdPizU4TYu00OXm7SuTeiMMJcrryaNm0
 7+dnbweMsYdmc0D0VytNTw+cAA6vFckA8sR6HLXusII8eD/zfE5rJT2iDNphmOWxntEo
 rX/szVtFXLsVawWfDKU0L0moce47lOUPcLuLRGfC6kn3Ep5d/11+LpSPBu0KGob4A47G
 AvjdOLsgyG1BcM5Dx5QP+G+OuZejXQbYUc8CJRwzrXPNFCjE9tcqniquS+8vYvL5WemV
 pyluJ/y4AuW7XnevP/1J7+mgUXmQ5XyVypaKiy8YgVNmQ1rWMUJIVkfPOb1g6kk/m/ot
 fuXg==
X-Gm-Message-State: AOJu0Yw5MadxRIrkb47f3PfQxc4+4T+0W8IdwTJd873HhWN6QLn90dkC
 Yhonx8hMujU8lXlu3WmCasuScarRPYw55JgEB4zSnx9TsNV77XMOty1SLNQ+wb1VX5ArNW5UWV+
 wxQkwNLjHWzkCZI/z/IMqwr1dge6Kiz+4mbgZCMAenWK7bI2a4ICNBLLTHGDFryEKlw==
X-Gm-Gg: AR+sD11J2wdp1udWygoZpMjBTfBzr2xk4fPbfm+zPK4FMb0NvZftzDvFy4s/0MmJ3qV
 elarTHJpltRN34ITp42ZfR8TrPoU4nP36N2f8PMxxUmMc5CPM8Y/lDXwjKurNCeasgT2HjE5VkY
 IZwpB4d+Nvt+vTIWxm5n2/B+54ahZygKUdigc5YWa5/qvgC8rxaOsFBTbrQFjyFy/zezMwt9Wwv
 10MPFoh5JXXwrhkWW/jiPorneHDejuZmdpqFMKTXH7r7AL20cg6TSEBRf868uUingjGSVf3zxNL
 xO8D1QPeKWPn3RlQX1CqQCyHFCYk+Q51cgpTVnLjMSGA/mksHlsW1bAlKYunP8Yuv5hXxZnLra5
 TuC2Aj452VdZqdR2K/ke6GEbEcmE2ZdSQPWQoFQg5gA==
X-Received: by 2002:ac8:5c93:0:b0:51c:1117:c6a with SMTP id
 d75a77b69052e-52d646a003fmr34908281cf.4.1786536782964; 
 Wed, 12 Aug 2026 05:13:02 -0700 (PDT)
X-Received: by 2002:ac8:5c93:0:b0:51c:1117:c6a with SMTP id
 d75a77b69052e-52d646a003fmr34907651cf.4.1786536782372; 
 Wed, 12 Aug 2026 05:13:02 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaa4d2fsm70097865e9.1.2026.08.12.05.13.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:13:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/7] hw/nmi: Remove @cpu_index argument from nmi_inject()
Date: Wed, 12 Aug 2026 14:12:29 +0200
Message-ID: <20260812121232.71958-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812121232.71958-1-philmd@oss.qualcomm.com>
References: <20260812121232.71958-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfXzrjczYjybBIQ
 zV+ukrrKc0t8q3B2RdnoyLqi1ur1tLq36jkUKY4qqMY2xrT0BaZVY7RWyw+Jq5tvfG0UOvOfiCZ
 hepw6m6vqMJMhF5+AQEJCBFy6MHkCOU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfX7j0jG9U8XXC7
 Ll3bKIJtBg7ShVLg73K+OKC+LwxfwONNSGUf++ZSXecQK0JhiGcWleXKS6GB1wvGOblu5lNwQRw
 lSJRQmh1k97ra8ylKr5VqdbblVgr6isqp7pD34mP67iBtUxQ9McP+3oYxTBwPXrMZl5D8DuXYDr
 YHdfOoDA8h2UhSqwGXSikRL1sztfX0c+CjMmYgiyHC6NVKgv2m/WyBUqno4kZl4QkNmu/xQBTfR
 Y0A5Ni18X3oJuxddAwlOa2y72JCOrB50TzsNB+LOR4XA/PEaibvTN4tO8axiKyVjozAGOTzpYpj
 TSfcN1YHLe/Aow+DU7CJSM6ymD3R9ou0ENEQSmZAcCuXEZ2jfmgFJM2XTcM9Woc6I6mMs71lLl/
 3KX30PnVJYnB6tpK5BK9BrEmftLLx/22dG2CObHT/OobQOYyy0nFP9rlHDC1eyGNOnMETtSWx5q
 PCtcL/T8fXCJjSQpjsg==
X-Proofpoint-ORIG-GUID: aftIUSj4zTNzEACQO9zaguJnMxhRaTDY
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7c6350 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=BCSMXUZzsmg2-BZsF7kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: aftIUSj4zTNzEACQO9zaguJnMxhRaTDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120099
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
index a1b77ae4044..b21f361ada0 100644
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


