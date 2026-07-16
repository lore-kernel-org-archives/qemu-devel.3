Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58365C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUq-0000x9-28; Thu, 16 Jul 2026 14:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUo-0000x1-Q5
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUn-0001Xy-AG
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:42 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSa7Y3274374
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JUjDZ1DHGvR
 7qgizW3604RGsuA6SIWco7PEugKqVXNI=; b=CPS5e896GbdOVtwW/ExUXI5hiiA
 qvGwUwNQLMVSLZdT+BwZTkl4rcqsNwC/sneuzj9OzVhpqPB1uKuhWS91/9sdKtGk
 +2b7JlvIEPXgHg4Ac312TS+sFmqS4nWz+DXsuZsI6MvicD9Y5gOvxxS4ReM2Vpm+
 TboQ4xq5CEtUMCvkemiBXTib18KpgsFD0jGc1Br68HYpDMNdpG4rYoHkihRLQL3K
 NvU2JKMT23F+PAFE15FB3EYaqkdw1ZA3LNxwRhhFlvt/gLND2cbFzuchiBuqWRvI
 x78kxalqk3KpPa7hs/u2Cfzw9MIp9c0ZBf+z8o1yBFNrc15CyaJpOhMigug==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff2f2rjjq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ce7fabf76so9650916a91.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225259; x=1784830059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JUjDZ1DHGvR7qgizW3604RGsuA6SIWco7PEugKqVXNI=;
 b=Qd/HGItGc/6riLUevamJcDbq/8SazMRDYzRwauhuAjzisPqfGjZ4lHTFvXUcu8iCk5
 Fodlg5+XKDMpdzwGOB0wT2fTRalpg9Zq/DhS1yGsEbvVYlqnRYdOMntic0Zf5yjdeeL8
 D8Hx5g2NpKzQAUCr+P3TxcmPF5HSiIQmiFAmMvm6gj/qwDxKeMZT8Qzt9l5FlUo+Fkcl
 AMK6ja6BGzQDYvoR1RS29Q/UK70vlxhDJdYU/wKRXx6cxIpWJr9qTM+8E6fkDqBE8aE4
 WuSvQyLgMWLVQ8SRqr30xGz4VdWFfh3WNJOE5S4WACp0lO8DS/FkhoJMbwsy33bqfZH4
 hloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225259; x=1784830059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JUjDZ1DHGvR7qgizW3604RGsuA6SIWco7PEugKqVXNI=;
 b=oE3bA6egliIY+WGJxgQfbiTkzHrBdab0tG/dFsRZGng3CNPOxo5n36ak/DkCVlEWOF
 27SA8zOwEdmvQPeF1evFVqL2btksBjsuqJ8Ou+kXamN4seocsQITGlQtLlW5RYEZp8+m
 Yco3czFRmP0Lk51q3k3bqvM81JpfXyDookjzMRuYhuv16TqsyLbwjwjJJe+fSGZUlB3M
 Q9r9l4aj99FyaSr7q85cesF72FfppQd5Ue+LJU6zFes9W0QbbVQt6e3tWriUGglqPXfI
 fNB5npsfHj1Uqje6PoiDOdl3bIckbcqR+RkBlfF8ZG1SD8M62IWdA93wnIM42FyvHdxc
 qMig==
X-Gm-Message-State: AOJu0YwmRTjWkbG8FlIu3vnSYpH9ojXt1lajKj7JY+NRopG4CPuliJcB
 Nkz1i61B3xs0JO+h/CYVZLRpDYiSYrGi6j7/YcpnSn/qZmgrHz5HvWPoDx/Fw7eu4eB2+/ErvSW
 DI3Ly9sBcPimr1R7bHdtMWjaiX/PGSAfSxRfun0qbMnUteV3pd2pHo2OQmfkaqThXeQ==
X-Gm-Gg: AfdE7cmmzdIfWrjQJMyoPuYcKVK9+DmURbe+lr33Co2eWXzUDETKXMABxgJf++nFG1h
 RiFHx4zq3+sswefGsNzSpsAs/i1SzCtxZM6y4yYZbmuhJmr6YVRcfWbOC0v4+C1CI53WLkhDcwl
 76ByWqVwji9UJtZpje5WyectyWQF4bg6NBSdaLU6HOQ9vYPm9zRGitHI9BAzpgYP9mqbxZx8Oxh
 QcoIfTx2XnQFMFy7srXghqLTkVSHPH196P8nfFH/njh90Z+sKk1RX4wkwhTrfokBZBBckc1udzf
 +h2B9APfkePkFbcKjC2SrXMq30IV/S6u5IYSboxiUHd7NqUbiLu8qxS0OLNXf2PfrnoSftcfxoD
 nXQDQyFu4f5kuvwktdJRVAlZ1+jyoep3y6EolJVJSpAjZaKD5Fi6VgQ12sUV79jI=
X-Received: by 2002:a17:90b:5610:b0:38d:e658:595a with SMTP id
 98e67ed59e1d1-38e1ae5f629mr9878694a91.2.1784225259281; 
 Thu, 16 Jul 2026 11:07:39 -0700 (PDT)
X-Received: by 2002:a17:90b:5610:b0:38d:e658:595a with SMTP id
 98e67ed59e1d1-38e1ae5f629mr9878658a91.2.1784225258712; 
 Thu, 16 Jul 2026 11:07:38 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:33 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 09/14] semihosting: add ftruncate helper (to be used for
 hexagon)
Date: Thu, 16 Jul 2026 11:06:53 -0700
Message-Id: <7399327e99bf4f7bccdcfcfdab954dd47c1a0053.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 75vzUnZAS2nz22aVpX1XI9LPOqlpRAc9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX1FXKo7E29Mox
 Zud26xJknLuPt28PklI1++p8oihsAbbGUBHJdI2CDwfs3bSAcoBsTNKmlqnF0L/RnjRPQ40zGNY
 9oW8NLrnbSeCA5y6eWq72UtBmtj7hzE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX+peu2lVLcLYt
 TaiiflVGvrGNOoq+kJCBrpSS/67qvdUBySdGSoYGRu5B/n5NQyf8zlElk7uP8P0Dkd7rvkfo+8z
 U1uvcpoEYYgfuuJwJN8YQJSY0d2PQIdhUB31BhZQApdKhUGzhs2IN0/cM/7E7F3fNI0bdwytprn
 pO2f0GCjiIi+T1fFfhA9xfg9bREiPovA28X/WDrHU4azMWVS5q2TIwQGEaPacqifnNp5y8jlwRQ
 Js5uS8jv/G23xGrEr8TCiOSxHPyLXyA8gYiY6lKhmorMUDHlyYRj2hM5HouNBziGYZ/ZQhH6p87
 pbcg6puuu07v3zpPl3oA2S9OZRlDfAhPCJzlLfyviJSOPrI2fgy4rqGEBqlOLTgfj5RxQGZkpw1
 pssGNPyq03OWeJ1aBb9LVGjVKOlWqgk82TbkkHmCRSpB48jl1a0urFon/LXg9TtSaURB6y5RF4Y
 Z7WdBz115hIpRzoS2Ww==
X-Authority-Analysis: v=2.4 cv=NcTWEWD4 c=1 sm=1 tr=0 ts=6a591dec cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=H7u-uynIU280lupyLLIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 75vzUnZAS2nz22aVpX1XI9LPOqlpRAc9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160185
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

The common semihosting syscall layer has no ftruncate
helper, but the Hexagon semihosting ABI includes an FTRUNC
operation.  Add semihost_sys_ftruncate() so that Hexagon
can delegate to it rather than calling ftruncate directly.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 include/semihosting/syscalls.h |  2 ++
 semihosting/syscalls.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/semihosting/syscalls.h b/include/semihosting/syscalls.h
index 03aa45b7bb9..3919ab64c7c 100644
--- a/include/semihosting/syscalls.h
+++ b/include/semihosting/syscalls.h
@@ -75,4 +75,6 @@ void semihost_sys_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
 void semihost_sys_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
                            int fd, GIOCondition cond, int timeout);
 
+void semihost_sys_ftruncate(CPUState *cs, gdb_syscall_complete_cb complete,
+                            int fd, off_t len);
 #endif /* SEMIHOSTING_SYSCALLS_H */
diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index 20f155f869a..0456db0befb 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -8,10 +8,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
 #include "gdbstub/syscalls.h"
 #include "semihosting/guestfd.h"
 #include "semihosting/syscalls.h"
 #include "semihosting/console.h"
+#include "semihosting/semihost.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 #else
@@ -541,6 +543,13 @@ static void host_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 #endif
 
+static void host_ftruncate(CPUState *cs, gdb_syscall_complete_cb complete,
+                           GuestFD *gf, off_t len)
+{
+    int err = ftruncate(gf->hostfd, len);
+    complete(cs, err, err < 0 ? errno : 0);
+}
+
 /*
  * Static file semihosting syscall implementations.
  */
@@ -982,3 +991,23 @@ void semihost_sys_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
     }
 }
 #endif
+
+void semihost_sys_ftruncate(CPUState *cs, gdb_syscall_complete_cb complete,
+                            int fd, off_t len)
+{
+    GuestFD *gf = get_guestfd(fd);
+    if (!gf) {
+        complete(cs, -1, EBADF);
+        return;
+    }
+
+    switch (gf->type) {
+    case GuestFDHost:
+        host_ftruncate(cs, complete, gf, len);
+        break;
+    default:
+        error_report("ftruncate call not implemented "
+                     "for this semihosting mode.");
+        g_assert_not_reached();
+    }
+}
-- 
2.37.2


