Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E65C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcEP-0001ql-Lr; Sun, 16 Aug 2026 10:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcEO-0001px-4R
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcEM-00028Y-9X
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDl5m93214690
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F6ohuIDbyuIY9Xg1tfojyir1l6XnmoCJoUpT126iL8w=; b=asFYYxxxyGH6SMem
 SoC4pHpYpch2yiInLs9Pp1HF6NaIETq/XRrANZzlIZXQUBQ4BfiR2HSAF9r1Q9yu
 TTzAbOmsf7CFdqMp+ZqF4DGZbf7CNHExkSiQUh66WqBCGAC2Ys/GPgCC7m0/HZe5
 SQAfq1q58/n6VAA6/qryrFYrO2G87C0CNnWkTEQX0XXOBpiBLLgYGQ3UUZe3VfMg
 aW/DRu5SX0q2Rcc3AIVMqryL+OWeXj1uaI9ebSi1GKI8vUTn+p6cFQHmviLmTGT+
 5ZJga8NOLQEvAiwJhNbGYBx0OzCkZOAZrpuD+l+wjP6kGqrQw0ZyoqOT4/cJh60R
 kmuKRg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfbngj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8e9489f62bfso30382206d6.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891976; x=1787496776; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F6ohuIDbyuIY9Xg1tfojyir1l6XnmoCJoUpT126iL8w=;
 b=gCsvHzVLjxozLDxQ6qjHddScPn5rcn1mvYa+l7YAXKcWA6k9+uZUpFsh1kBcVDNijE
 yfVZfwo86Np6FCulELWkt+RDjh+UfJlUh7lffaCCg+igk/bLrkD3ETGb7FepqamxW+3u
 sMgy16NI2Gb66MByY2De8qd415mZRJVL8pez31Q1LX6Ft8884tocNlnc9cV5vvMTVYBK
 KxSwugnsza12+NhQ4PViehYORYVNg6NbBE8PSDUOKT1f14Fjhja3rEqrEbbT+X9XRPm8
 d7BmzCqfrh2E0EV2chf8xUYeBA7EXV5QivqHcwvit9et83R7v7bnqw5FxHyF1lPYZSOS
 zzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891976; x=1787496776;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F6ohuIDbyuIY9Xg1tfojyir1l6XnmoCJoUpT126iL8w=;
 b=lJgTGobCMN7E/y6n1RLRM6PdIv2ulYV/h+S0Xqxsuh8iTSVDdSGJ0sgJz/AMDlqxpG
 IAEPZiJj1hfAK7Mu/QY+zJoUxvH/I8XeieEbfr+O8crkHKFXra9ooQLefhraaFiRXL4K
 HMRsLDwh/3JIJoStVwYwmyoR+0811AS3UOkqq5Yu+smdxoef1RzrZHX917CdeLarVomW
 o4mpjuZPqcr1QYmLH0eT1scHKqWqUy2mRikTIIS6577MKE997A3WyS+SWf5BsAD9oh5b
 e6yzUIbfIWUSW6jgH3Etrg53vyZO4yB4UQ6MflcEuOFweOnsDuf8VMBg3hFG8+GNU9E4
 +rzg==
X-Gm-Message-State: AOJu0Yw9iunHA3uXTszkQ/dCniwFE8a4JrBMaXq/DwwMT/CQdf8wDMnl
 nZEmIJFmpDGX42D8V3wcPAsqrKCFCfyP/JedUMUy/2QlnEsTNhmKHzqSTUdn1Q9PhlH8Pax7+Yv
 Cc+GkgvY96F0ow+AyvmJtfVU36eZYH1Kjn42jcf/QFVwZzorZ+kjEsfH1v6kfpR3UPA==
X-Gm-Gg: AR+sD12YN3KNF3hD/zXf3uh2RCbTTdVcwqiDFLYVse53f562Jzz8jDUmpJztIQ3EJdI
 xxK5Ctw6luilPbv5Un1GZaIS5ICO8SDLlGsrzFClknGBvhhkFmq9eiR5zbWpS2kGev5ioTKlw6O
 3iHOt8DXSaWJ+0hMO05Hp7IC3gjChfgZiVoPkBTMp3YvgO4KkRhQYhjGhpqM+WXw8YtKVvQ8Ipx
 +PnDxDW8prvKw2ZnS0lbTC2elo02kF+sQ83Yi3Pg3H5TVrKYI4EkP0N1H06OsZs8tcCrRwaQiSx
 wcvGsYkTDovP7e41nla7xsgSbrHMo845qkYovmOpBGpDw7Ypyj8oRkt70gtV+3yptdIin4Lnzua
 ZSTt64CNWTKE9ZyQQoyBVA58GsreujR7XwVP9RRrAqQ==
X-Received: by 2002:ac8:580f:0:b0:519:efea:cf41 with SMTP id
 d75a77b69052e-52d85431a8fmr202423411cf.28.1786891976495; 
 Sun, 16 Aug 2026 07:52:56 -0700 (PDT)
X-Received: by 2002:ac8:580f:0:b0:519:efea:cf41 with SMTP id
 d75a77b69052e-52d85431a8fmr202423171cf.28.1786891976110; 
 Sun, 16 Aug 2026 07:52:56 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996106c6esm73721345e9.5.2026.08.16.07.52.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:52:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 49/56] system: Move qmp_inject_nmi() to
 hw/core/machine-qmp-cmds.c
Date: Sun, 16 Aug 2026 16:45:48 +0200
Message-ID: <20260816144556.69009-50-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX3JCnhf9a7jtc
 4HGCN9rzPaomrhl/sjCuDePr/jAL0Z1esYY9jWBVqSRiBG8BxRwceMkw6WhfsG46hPkOAuwJqMf
 v2UhFdIJHYFX5PxSurGcFnPvIsKEwZU=
X-Proofpoint-ORIG-GUID: 6SGzTjbdGa_R0G1Gi550DIgmqmrO4Vxv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXzrfYD7fPQ6dJ
 pdAQJXLEr6M7eqiH6fGUnfstu6rvSBp+8zafWYhmBnfzjxK1hICTIqG3WAe0+qKaJfxR0bKyqqJ
 /hoNusR9KNnUIKX4Ekp25Qrvb34umhyloIvqM04uQTzn2OccRXcVZhqDV3Pp6PHEdRQaWuW9mHd
 Jj/vveOSgYlimnotbno8f2K+KLCUWkeebLYqYf/cY31RLfrEn60l0foOSDz+815z2Kub0xeqmJk
 ehX/k54/38XLVwZUo3ndY1VvXM8DAl3j7vrnTWxorF3eUgs7+nCs5v/nInZRpZIQgpobIn44dIF
 KVAMg0MiNw05F2BuoDh8AtRF8nmp03OAPSzhEu6xIo8Vm0X/bhb/zQ3A3YnUydNcBp9ZqcdweWo
 7FZVUXyVvuIuma0jEmIlPSdCQM6bxO/+yFRJUwaFG6rg2xkiXH6WqjDcH+eemwi5R/D9oEnoYpl
 Ayd1jnowvKuUxTP1Kzw==
X-Proofpoint-GUID: 6SGzTjbdGa_R0G1Gi550DIgmqmrO4Vxv
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=6a81cec9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
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

We figured NMI relates to machines (for their machine-specific
handling), so move the 'inject-nmi' QMP handler with the rest
of machine ones, in hw/core/machine-qmp-cmds.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-15-philmd@oss.qualcomm.com>
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


