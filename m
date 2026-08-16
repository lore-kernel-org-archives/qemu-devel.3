Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302A3C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcDe-00083J-08; Sun, 16 Aug 2026 10:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDc-00080w-KS
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDb-0001xL-0v
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:12 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlOgN482183
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 drmDyXgEuIO16YDWsy7JkXXCrfr5ReM8l/jxKggouZ8=; b=Zj2W/msQ6JmEodHR
 7k2RlcU+6Rlb3b2hwqKHbiGfiVyE6oCY+4iu3Axgw2uoEEbCpjyGI8aPEs8eraxP
 9sU/DULAaRTxyhFxsi9hfLILS2QqNvVcsdzl2N2I8EQ2CbvPASsKT5L/SWGTSSY4
 CPPuUil2T9tNJAjN/17cBYwS/kdkvBkWJ2ZzKnOpOTtYFLXn26IC56rRTc9TypKC
 MRxDp7tzXL9n1l4CbkCLNeV5qrNfAyoSE1qDhxGXkeEb6M6L9Iaw2znAPgyYhAjM
 juEAuCW44ErLtGOu7WWzc/Vu2wZ2TrbNOTQyv6ryK5ynUKEUta+AclQc09svPMIy
 3vqOrA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfbk5v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9368f2b7b2bso261392185a.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891928; x=1787496728; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=drmDyXgEuIO16YDWsy7JkXXCrfr5ReM8l/jxKggouZ8=;
 b=YWUt/iwTgw4xm0umyK0ouO8+ezbM1K+0wMRLCiOZESa/MVXB/zppZA4NP1qkdtyw9+
 l1Nwz6NlDJu4u5Wjef5Z7EYuMpFLbkQCQdDN/ku3kLN0DI3cpFNaMcpXrXVevrbOmzAY
 Iq1KNZTemS58YD4pPIrfSClNjDbuP34A5A7Lgy49LdRSGBnIKahnGb5DK7Ru0p7VjlSg
 u9ggWJFXoTJW42Uz+NWcBn4NLXvkdy0Af45cXBku2AVN/HeffXWx1dfRNYtKjLlWFCsO
 xFnFHjxfh5sW5NK0jjWKb6s3irg0vODUk+oW/uwpB2eN3p64PfCYUfa44IH3HoRNxbib
 Id3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891928; x=1787496728;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=drmDyXgEuIO16YDWsy7JkXXCrfr5ReM8l/jxKggouZ8=;
 b=BpUhqPk29zh6sfYPRSbpb99KavlKZC0WPo/ap7oIFRSlBlBbCiW6+ETGuG7Dr8uUng
 hiDrG2UEyksJqTUAmgMIrEpOrj7i2o9+YMMorGQrcWK0W4vEDgKFnhM/BZnHQvX5LHaR
 M3cImAOq+xo0jWUxe3qjDCJK7muA3vTHg+hXA7XTzUyK/52kIwfC50cUlTgRGYkwZllT
 zAt6Xyux3nlM7UtD4UF7u6+uS75TvYkWoHd7W8nXTcwBUwaZma1fbfB5N3dmi6+cfUOw
 KBieh3dku0hlHFdTSjKKH5wZ2vUCO3mIW0EoWFqmHW9fCknWCgXtfrviortaryV3xIfp
 WzFA==
X-Gm-Message-State: AOJu0Yyjox23K6SC7szspbiwzHGtEmYL7Hgz/0DfOFq8WPOBlr+BSgxe
 TCTgUp1bMU+3OtXXK2pabfGeSQGr+9cw9/F3q/i2dNLGF4kM1eyhB67AfRqzXoA4l6HPNjO+aFo
 a5xZhogBUXehx4UyrfxYSWpEqrdoajo4Ecn+NsDg7Xa2vLQxE1uKa5XtYmK2rGtgjzA==
X-Gm-Gg: AR+sD13mPgRR/6PJFXHWgPibblkqYd3fJzGH7wounmG30SuMUSBEmL94RUxBsJWKaEo
 5fFrCrEbeECNXzhOyjDBCiHolvde7Ujmc2PXcnpyjOLe7JVyIqzj4QJWWFqSWQHfP0XvTdFGGAI
 kp2wTiZ7rLzm+zTj82Of3C/PvgfSooiEmpXjcq49n8kzNU+fZb/NsfOJJZL42Skhu1OiaHm7hZN
 5oqDu7iQa7tTrajWFygANdSRHAfIZON0XkIlRPs4r+LoxWdKbqhrKylYHyBUN3aFLS1D+rEZOYD
 xI5blDkAyNk6v1BI+mBfSpnFA9znEBWXFAPCoIUYuY3Sp3j/659xa3DTfI3szG+xiVne3V5bPoG
 Usip3s9J/f0yrTtHWDGQN4T+zfTprTe/9RBYG1+M/Vw==
X-Received: by 2002:a05:620a:4892:b0:936:e938:b07a with SMTP id
 af79cd13be357-936e938ce06mr841601285a.8.1786891928552; 
 Sun, 16 Aug 2026 07:52:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4892:b0:936:e938:b07a with SMTP id
 af79cd13be357-936e938ce06mr841597985a.8.1786891928097; 
 Sun, 16 Aug 2026 07:52:08 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm66775825e9.6.2026.08.16.07.52.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:52:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/56] monitor: Include missing 'qemu/lockable.h' header
Date: Sun, 16 Aug 2026 16:45:42 +0200
Message-ID: <20260816144556.69009-44-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OZ6oyBTY c=1 sm=1 tr=0 ts=6a81ce99 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=_5bDPQybseJbp6lUwYQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: hQahD8l6aR5yT0dTQVhK_UrWCDE2ogW0
X-Proofpoint-ORIG-GUID: hQahD8l6aR5yT0dTQVhK_UrWCDE2ogW0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXy79GS6vvRgPL
 Qi1By4MOw1smYVvAWF63vlAHhi33JcmNaYKwtO9VwYymU3D5SxG4bHIKq0lV7vfO+G12siBWP4Y
 q8B3Gtzy+byROgbwcvD/0cs2vX2+5iA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX2/Q5dY4fVodO
 RI2QGs8P4Yke0xlcdIxvMlfEoWtEYEieAZpgDlP7Eog2nVrvSGP/+2dpv2ykTANxgH22wqMtiVp
 l0JIJjxCeZnaRI/78LjSw/lVtNK3MtS/XyQOTr0qZO5bW6uSDU3/dQFYZu5Jhf97YyUaUoQKEV0
 oQhcBP3qZCwDGaW+enTsq55XuHODuW9FNyRPNCRiWpKlk7/yaKZqGqLoLCcRwFnxZC84zK8NWJ8
 +N2TfaXvi6OAZfPobrrtiuX3ez4mKhafaO7Dj/Vn1eSjtWjCCf6HjJFileZGQzThURVPAXS9Wlv
 oX1jt5fp/LfZWfx7IZfUF3DXEDRpvoSG67DfhB0ZNxuApB5wq8cJK39c76OdaT38LdDQppJW+3k
 C3j3JD+ZAfTMldfC3/VUYLO/wHkSQKb/rg+OCLh8lVvdLaTbLW59WNxANGR79XcW8yaB40BRS5H
 o98rBUnrF9AuGylQvGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160119
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

Files in monitor/ use the QEMU_LOCK_GUARD() macros, which
are declared in "qemu/lockable.h". Include the latter to
avoid when refactoring unrelated headers:

  ../monitor/fds.c:146:5: error: call to undeclared function 'QEMU_LOCK_GUARD'
    146 |     QEMU_LOCK_GUARD(&mon->mon_lock);
        |     ^
  ../monitor/monitor.c:176:5: error: call to undeclared function 'QEMU_LOCK_GUARD'
    176 |     QEMU_LOCK_GUARD(&mon->mon_lock);
        |     ^
  ../monitor/qmp.c:164:5: error: call to undeclared function 'WITH_QEMU_LOCK_GUARD'
    164 |     WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
        |     ^

Fixes: 0210c3b39be ("monitor: Use LOCK_GUARD macros")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-9-philmd@oss.qualcomm.com>
---
 monitor/fds.c     | 1 +
 monitor/monitor.c | 1 +
 monitor/qmp.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/monitor/fds.c b/monitor/fds.c
index cc35d2ec334..abe5f13487d 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -29,6 +29,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu/lockable.h"
 #include "system/runstate.h"
 
 /* file descriptors passed via SCM_RIGHTS */
diff --git a/monitor/monitor.c b/monitor/monitor.c
index c75ae815343..6af09f2f6ea 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -32,6 +32,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/aio-wait.h"
 #include "qemu/error-report.h"
+#include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "system/qtest.h"
 #include "trace.h"
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 6ae1098d39f..aec03157750 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/aio-wait.h"
+#include "qemu/lockable.h"
 #include "chardev/char-io.h"
 #include "monitor-internal.h"
 #include "qapi/error.h"
-- 
2.53.0


