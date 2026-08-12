Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7A3C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGM6-00024R-Q9; Wed, 12 Aug 2026 17:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLm-0001ik-48
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLk-0007rK-HK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:01 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2Pe11165240
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 97+XKwMvL5vZM1NtKPV3aSs2kqnjlhlKaZ+8LDjMShs=; b=ZIQWi5BXPBtYMc9F
 iO35ZLSzsgn8nIxjixyHporSessv9hizZxbZ8uZbwLAQKWo2OHAdHRvDouzzBGa4
 8EfY+Iy/cjb1JZydfaMWWgATa/6e1+9ncgF/WTH5FWntRgsbBnnih5tflEaUGglh
 z9iHb1yvdjI9wdggV5/kwq2EkjJ269yMShfSCTfm90SaN1WCkrH2rdUnhmn4jkkh
 riDFFJf2m08H6KzJMrKwiNcvTAc/sc/9BO6RJSpyFe2Upl8h7FRnA1WBFzMSYRTk
 QltU59pVEQ/BZSOhmSFkYs+3v3omGnuh6pjdA4yW9b5Z1E5kOSvIgT4+hsEass5w
 RmALIQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0sk427xc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so24744991cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569538; x=1787174338; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=97+XKwMvL5vZM1NtKPV3aSs2kqnjlhlKaZ+8LDjMShs=;
 b=O0PmlyjR5F6Lz+w/NQY01FKEQTqYQxCJa7xEeEbYS7Z/ERPQdtTzUA5tQXadN9NvvA
 f3fJOPw34KI0TCw5zw7GQx+g+9SKjizju1ptamVcNE8pGk919LEGxlBUVHUiF9OvFiEa
 dL/2TqqQy6JYoSvQDHzN9+7jTQdpEaamZbUooR09YdTzxAmb+uHNpaUZfXVDkkrj1cBf
 FLmCNnuxzWS3FVli7Q5iOcQEkN638rg1lOkAKFg9stS9mh3Y6P9MIseg+aLBCf7TgsaW
 364eLaCzeg31g7GR7SO4G2sDfZCyvW6QhcWjGgwfgSOpuo9ScKiVj+T8EyyRDKO82ec7
 QDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569538; x=1787174338;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=97+XKwMvL5vZM1NtKPV3aSs2kqnjlhlKaZ+8LDjMShs=;
 b=SNWbX90NEolayDxlIUAC0kmmjT+bL1ry0xt3aEehys1z2dOvUAU+bBmj3Ts0yNo0pd
 HiOu/UXfOWSspx09XXuBeg97LyH4kCE1Kjfdtq7IEy9HcjaEGseVq2pM0mE3JlkFilTM
 tVrAI10Eu4zWoZhCQ9LlahAtYUKGxaLn2goNI7T8QemJpLKn6g/WYjASrHCrE+d36EPP
 nzD6K3G7W3e1wKsATrUNv4Nf2WNWr74jwwPHEfKMCHaNf+wrwByjVFJ3RQCr0FYiQnDV
 k8AkAtEPLJsHweXisFYkl41HCAerkqQrdHAReFCnl/gIww6YNrqO42vWcmtNfGUpehWp
 f4Uw==
X-Gm-Message-State: AOJu0Yy1h+iA7efNTGpNqkx8YLQJF8cnsPGsVivHHIZj+NzKQXSKL3qM
 Gvm8IaJInqQ6yr+Gg5G/QCgT4zqpsANlG9PjwKFLBjUBg/xoxCY8NGNYiRQ+JDCo/MQIK7iuMUe
 IpeBu+3lan7wnW73zsucQakFNzhkdyobWfsMdVZlmIyEiMuRBdVFGTGS7ZhboOSosVQ==
X-Gm-Gg: AR+sD13zzsrtWunIrLIc0pnTgfRNrUIpnVmv7qJeMW1DaNJ6mqQ/yo77izVT7QRCeTb
 3JoRBcxS6a9ci9wSTpiYzuKbfZqT9S6mQVBhFOsIQ2MVdnOCWNnh8M9wDOuASVVRQST8ja6jLzJ
 sGd91vC6EjqY4JVxDtfnHhd2x0JnnRxeEsqxnba3eSKw/7MiGuiKYO4jKTtNmVsOIqzxGvV7MoS
 xwrc97KcP9IOzufLzxnpT5XaRpLY10M7D7CZAtnyn8cEtTtIsc0JCjTiFu+Sq1RkXhPeWdgolBm
 tUSkz6UF8p8Yc7taJyG9FhvlggjCAg/2eyptKl69aMB3/TYDyJ/wXaUm4Ap1NgW6jvseI39ShNV
 TFkWTMOoSo6xaLMBj9H3dMqVNXjRY/0BWAzT9AO7GfA==
X-Received: by 2002:ac8:598f:0:b0:516:d83c:edb6 with SMTP id
 d75a77b69052e-52d73c4996cmr12093911cf.12.1786569538060; 
 Wed, 12 Aug 2026 14:18:58 -0700 (PDT)
X-Received: by 2002:ac8:598f:0:b0:516:d83c:edb6 with SMTP id
 d75a77b69052e-52d73c4996cmr12093181cf.12.1786569537477; 
 Wed, 12 Aug 2026 14:18:57 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e4435bsm5434785e9.3.2026.08.12.14.18.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:18:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 14/23] system: Move qmp_inject_nmi() to
 hw/core/machine-qmp-cmds.c
Date: Wed, 12 Aug 2026 23:16:58 +0200
Message-ID: <20260812211708.92824-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hKBp3KuA530vUgr8Lh-Ee_kGyfkgZRUO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfXwzy0NXJDptTz
 CQL4+wMojbnQEsAhO2PtgsihNZyQC0iU/jBq4Ic6i/8Ol1IFipGOrgvwqxF2d7OnBEGc2cv4HH4
 cGSgp9EDkYZIZPuemGlkUIc4tCvywC26058bZiwxIm1HKu0YbFKHX6/07uTN7JzgC961r8ZvjGv
 b+wlYs0qzmG7Nn3tJ5Yno8Za1rKnorkhvu9ox7Zl5PBAaK826nq81P1Yjo0Hpzv7ORWHZo4foRs
 EDSrfQxu5Dxo+lPoipi5rXHIcm1U6Ufrz3tDxbxg9aIdoPFmTkYZIacIQsc/igFi2Y9A7+oUnku
 hxnHYZndT0nWTe/nWvp1AUWOAJqOSseY/mlIgLaq38ZaQH+T7xu5ak3PZCC3tIjOKrhNVbm6n9Z
 0Kz+t/T3z/h8+4DmDd889Vv1sa/ZcEQD+OYU95nWLJOO53Oz4kEaVfraIX6IITWDkZctQP1VyCf
 /6uLKIc+GNQmAQ6apNQ==
X-Authority-Analysis: v=2.4 cv=E8n9Y6dl c=1 sm=1 tr=0 ts=6a7ce343 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX8qKXT/ThtDAC
 5fgO+sLUhdo0VAFNWpqHwutls7JEXJKAXjHPajd/JSdn7k10iO3POFm0pIo3oz35S9DMmYXCc0a
 YbVP06G37fbE9JGMOCCKyLP4MiQuQcg=
X-Proofpoint-ORIG-GUID: hKBp3KuA530vUgr8Lh-Ee_kGyfkgZRUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
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

We figured NMI relates to machines (for their machine-specific
handling), so move the 'inject-nmi' QMP handler with the rest
of machine ones, in hw/core/machine-qmp-cmds.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


