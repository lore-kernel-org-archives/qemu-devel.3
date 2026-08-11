Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4972DC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtok3-00039l-7W; Tue, 11 Aug 2026 11:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtok1-00037k-Jq
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:50:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtojv-0002OS-Mh
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:50:13 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDX5uR767022
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9SNNbFWXkO5xJkw3gfIEyPOGK5pvSUHYIpq0lvVOhio=; b=HYmjksLXzooWgt8W
 TpKz2FICNvmYrnM49L5MdXjaDEt95qpYTYrPh/RwUtYXoL/jjgl3obxJJzNPBCLl
 mG1pPCnHizA2jLfCdBlxJdrM+ZZi6q3jUgizCJCEyzY0/3LI9U1j9+rjBPEHkCod
 6BsvjXx7pwBSd0NcL5TusvtEq3rmpRsmgbjHm4pQNFzpT3fNrp6PuWF5wHVoVEYV
 RAtbKmxt/q/E3th/7WYHDmQtbNs/f7gBC7bQHUsWVkKDYiBiDKHdvMB3XKDESp3y
 dhMCxGAnypUPmL/ajjzIfSOAgYjUOqSgmORRUK56PgNduMgMsIMp/9rOw4kQSOy+
 pne08A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc1b0g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:50:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso577951cf.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786463405; x=1787068205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9SNNbFWXkO5xJkw3gfIEyPOGK5pvSUHYIpq0lvVOhio=;
 b=TCJW6mRyNtPozimHigfrBroey9OOBxrbXr9QyIjBiAlxFViIye7cNShAcrjZgo0eHi
 pbN8e93qHJll3vVc8aEKfUKyGWDYLC6vHUTXKNanw8jYXk5JnwiBhvYJ2ed5JKO/LNnv
 Y9pRluOsw/C8qxmTnPjEqiWciUJaoR48cFq5ctnLdS18pzExBSsHw95fRc/GQi5VxA5S
 Ys+i1huzgA57Wstj/MbLA1MZzQIuii6FBbLAJgwd2zHNu8dn8HP9FxqRkRNfI/WPmjPA
 TNT7b2AkJxqCW0ZcLQ73au1o9SdqRXFBt9WIU+f9UxSyPQrVaT4tNiA6jgpXQm4M9o1b
 Q7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463405; x=1787068205;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9SNNbFWXkO5xJkw3gfIEyPOGK5pvSUHYIpq0lvVOhio=;
 b=tXBnan5mojKi+PHgkcBF5bQ42HfbA00dI40hG2AVOSQy794EaZsy3gtmjCgJ5YFyid
 Rze5JsiDXjM+C/goJBN5q0eNtfVk0p2myZIkg/OsOMy7+uu4WWB0oYvo4FMu9bzPmI2n
 xvUT6rWwW+BsvYbZptvWJEyVh9SrcO6Nq3EZl3sCzGswUZjziM/n+S9u3FAIGCOQ0rY3
 Bp6SC6TtbjzzPZV4rFa1FzS8ewtF9Vctt2DU9u4/Mi3Mbd8ir25sDjbpZUX0aLv6DlYT
 tZ1c+/pTE9BaOjfZWW/TW/xhDAGpsDNWk7TaEg6e54Fzklkca+TwRlC0au660F1JgagT
 4b9A==
X-Gm-Message-State: AOJu0Yx5LTwkR7/VcWgKzrWy6RHrG5xD9TTdIbnyKHIOtFpHJr47xczu
 pDAmqaGaf6L512HaOcX2PUpnPONySvTrCTyAGzgwdYqPSIhGtNuDhqWVWQLFL9rkhUgpJdX9wcs
 DNm8ZKn1gZMYUHY+4/QnPMNzsa2Ey4EGVhpouoPaKX4OAYVG/NhFH5rGObxQfDC9S0w==
X-Gm-Gg: AR+sD13w3UYFjktsY+T3XisbfxLJWvfIgykYkL/Wp6cbQYb8ylwlEQjvCC5KeVyzC2T
 fuO6+As90PKXWXATjXPoGa5gMLJSR3pfCSGPVKaVic16mQW1CgdFMhJzVCA9JzJE+Rzfrl+3pv+
 S+uNeBtvBffgLKZdiB2zIPVktWGOs7xAse/ma+S2apSI429ddbV4ed4+CnhbG3eKVEwiz2FMjl2
 VPKMvyRathVz4J9Xh1H7H4FJ/1UxYBUrg4BS9FYpPkwYAkdz2+9ty9ILHn7JAjXDR2MXaZcNrrx
 dIfwMA3zpKZG3+C4NLPGX0WYIykofsy1XbDsuQLOfLXzuGtlpOnRs+6GexyI+4NcCBVj3ShgS1L
 7jqIs/BU3nUa3HcNDlDWhnobxYfENB8dKsBKEZapxxw==
X-Received: by 2002:a05:622a:11d0:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52d584aa4aamr36648411cf.9.1786463405071; 
 Tue, 11 Aug 2026 08:50:05 -0700 (PDT)
X-Received: by 2002:a05:622a:11d0:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52d584aa4aamr36648001cf.9.1786463404618; 
 Tue, 11 Aug 2026 08:50:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997abeba23sm1000755e9.11.2026.08.11.08.50.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 08:50:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v4 4/7] hw/nmi: Remove @cpu_index argument from nmi_inject()
Date: Tue, 11 Aug 2026 17:49:27 +0200
Message-ID: <20260811154930.13915-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811154930.13915-1-philmd@oss.qualcomm.com>
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX/TwU7ho6UKyj
 AtnEgmsqwRTFvupT5f6dsT+mXSAsCQG8zNJJ0kTkI/Z8qD/AIjN8ZZCGkhy8FIfaPFufU2G0/dn
 nCz/tXbQ56MyOeRQtXjlAflBSBjH2Zs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX7xMOqA0c3H5p
 G2KCOWtoX1C7Pa2bVXNqr0opuVT4dhX9feZAjQ2NboRxSdFyT7uJFPFwwXqbNPDXMohZ5qvW6qw
 wObZymjUzr1b4DGMmpvboNI08+KWmtNbRyez9Jm6vKH/CzsqmWaVY6K65VO7vPFhqLa/YrSeNYY
 JsUJohZgJUvq5hpNwJqHbvRbEKiS+iVpPIfP2EpDqlhfpS+3A0yh65hog+DDEvF4duN4Zy9RXcI
 J+HP+Yp3ru9KorFBfzy77cW6cpcNmnt/8jzDrG3XjW1+FmWAfSjuBsqY1Mf3jMCmPlUjwCD8jV/
 peREdo2xkcZRKMfX+q+Fs5bCCO5vochGPan+GOsd2f7d3bd7mWSiVV0xYV3Y1w/Txs64HEiw3cd
 sP+Um9d7jHdf3RqgideGHung4DN3tZB0YKrgwQgtztq1D0gmHq/Nnb4gF9JCcjHwbTLhwTc9wkp
 /Wytq10M+gjXiKFY/sg==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7b44ad cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=FcA89Dn81BW4c7i3JskA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: JED8ha7-aXB-w87pWi4YUzIjN3r7zgDw
X-Proofpoint-GUID: JED8ha7-aXB-w87pWi4YUzIjN3r7zgDw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110132
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/nmi.h  | 25 ++++++++++++++++++++++++-
 hw/core/nmi.c          |  9 ++++-----
 hw/ipmi/ipmi.c         |  3 +--
 hw/watchdog/watchdog.c |  2 +-
 system/cpus.c          |  2 +-
 hmp-commands.hx        |  2 +-
 6 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
index 4c4ce79071d..2ff5be1e214 100644
--- a/include/hw/core/nmi.h
+++ b/include/hw/core/nmi.h
@@ -46,6 +46,29 @@ struct NMIClass {
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
+ * The NMI is injected by looking for QOM objects which
+ * implement the TYPE_NMI interface, and calling their nmi_monitor_handler
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
index 97e5a5edee2..04809698de4 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -926,6 +926,6 @@ exit:
 
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


