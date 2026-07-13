Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5D2C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwR-0005jw-75; Mon, 13 Jul 2026 16:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwP-0005ji-M6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwO-0006Rn-4f
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:49 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9GFr2470620
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KgoeEtREP98
 2UVwDu1tBLv1m6zgILNescQnRy+9maew=; b=jyaWQxBc97rrHO0Unv5A+Y1D2xd
 WVtUuMM+haPWeS4q+a01IMu8tUG52uJ3tHJNzVBoviFPysqRmL5+UYASpi5Z58/J
 GMxRY2xZZ3yymgbOJqZMLFlgP7CkDsVofunjoIsoNuprJ0cNLvN31+5pkRlP5NhX
 su9aq0OLgd7O1Ag6OlZtiCKSgq2HeDQ4g0mokdTp2T1yvbxRquEuSqQo4+tIq86N
 xkLxkAcwTHLgVcHd2coTpEWqdWKVgMfS2T4/Jhfl+vqYXM5DmGbQZTnBJakrPbm3
 Y5YjX9XFZ8WRyLgTQuq4TVQGgZmVbh9BsI2ZaiBbA6c8mccJkjZXMDuPKzg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44jrmer-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3811279d51aso403723a91.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973256; x=1784578056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KgoeEtREP982UVwDu1tBLv1m6zgILNescQnRy+9maew=;
 b=HDjXz0nmi4pESxZlj+Tb/QED1f2VQ2p/UYYDCk34C5vnpCG3hYhRBuY5kDF25bGIx0
 uf8ddNyUv53rkiCv63/PgdeCnKbaWUlijeF2B3RmVfznS2HcWtC9K3LQXpnAnx1mvBu7
 Ngs5DFF1KxT0vsB0zA9kQt54BUnmCtffOtPiMlhlIp7tIJ4AxYgvyCERUhN/H9+P/Sp6
 Nkn3eAIfkzmg48C27W056Ab+NL2zPgcY7HL86ToYGqOKGWkURVYcpJEqb7fXLuvzIoHr
 j4lxKQH3FFDu0My6pN9ybwpeImy4LaDUhVwQxXXeSkD2O6Hr6vikWWvELiwxCK48Am8/
 8G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973256; x=1784578056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KgoeEtREP982UVwDu1tBLv1m6zgILNescQnRy+9maew=;
 b=Fuk0qiwy5XqAiF50/lQiB3TBIv9+awPSplVtN5pUoyJ/R71CuPmbJqKRAZmnCGPqve
 +VqFmnRz05BJOWKnvr4P4vrBbbzbv7ZoyMaE8JXZahR1Sv4H+zb8D7yu+7HeUw1ZUlRu
 phv/voutMREOkX4gQsXLKFIsdPgEa1CuYbNeOFXawcGuQXctZb+QuQha2mvvH8NPEkdT
 N+ybmCW4w9WSHyJm0+1PtpJhgDatZSydSszakLrYd5khRM2oPQuOCzds2uYDrWNJQvKt
 9tIVnVQbQXeIJiCxBj89r++gzO/eKQylXxf5TnbBB932clcyHbxHCq9yKTx+7Tkbaak6
 guaA==
X-Gm-Message-State: AOJu0YwuUZbHLY4sKx2nQm3KE4ub3vTts7J8+ssELc+4K/h89yPn8zvr
 MaTspyDNaNxvRlaBwsjgis0FqZiP+OXXp9qG9fdj/jjZPP+iT2bCYSa4OJEe2jZtv+IOHnakiVU
 PzbItWQ0TCCGflgAbRflfAXhtz2nh6bbGDib9u/Aa+uUjaBV9CVJeQ39QJ1ST1MhYV6Mx
X-Gm-Gg: AfdE7cllmKxUf5pncz8PH43Y0w5hXgCDSAm0TnHdxuZjmO5WG2H9JVZymcCSaVjaS0K
 K/xASabZClJ8/4qMZTMc4o2xczdYRn/G39Oreck9SYlLy6xRnsSvl91DNd+g93Q+AQvnhjHfxjW
 l8MLg1oABzbKd+fSFULtcx2InVJ68jRNQEeMSOLeRaTc0QIJGDS9T0+ZvM3grg/5mPgkmltzMeC
 74aCVjb6zen2ziOCAJHIh0AkaqkiRZu4bT6QvSALYZPq6Fl0hJZv7izATBAFpY32OM5qSWvcd3z
 /fc72025wd4rnylirH2h+53UePnnt1rSWedVe1KmIL2hnprEtvkf44JfRjIqCDLs8Kl/nHugI4V
 BIGevvEki325H9u0l7/0FRH6IHnD5Y7NxYP+iJPL0oNRCOP7zaSPIP+wpDjd0Cjz0gWtSDbg04w
 ==
X-Received: by 2002:a17:90b:4fcd:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-38dc75d81f1mr9591499a91.17.1783973256235; 
 Mon, 13 Jul 2026 13:07:36 -0700 (PDT)
X-Received: by 2002:a17:90b:4fcd:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-38dc75d81f1mr9591478a91.17.1783973255810; 
 Mon, 13 Jul 2026 13:07:35 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:35 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 08/14] semihosting: add ftruncate helper (to be used for
 hexagon)
Date: Mon, 13 Jul 2026 13:07:16 -0700
Message-Id: <8f1099dc944079927f8709ec8156eb76c2c04f63.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XHO8sWcA00BsNmxXO8rQ_Z61tQb3Ir6i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX8OuBetH5cwcW
 tI+OcqaMhz5li6nMxOOqmP1mtgin7by4qhAfcZaFE4dvhKnE8xOlc82DsG9WO0tHJSSgoXBXWcm
 adbG2/OTjVEJtuuVRUrumipJlA/IdIwoOySHYVQEbBwpi/JcQSgDWWEYSlrV70NcfUW130mIaEl
 GgJqFPEGrsqVg48hCyt0B9dYZMcl4JYW7J2lkTujhrfEIkjm1hvCcU3eZzafJXmlJi3yLZ3yeKu
 9aAKKv97rWx72J4pLyY6rhRcNQMmALoqo1zHk0EN9j3wl446QVg0OV+PGGZv1Z5ptQP+g3cejKF
 oCLmgG7D4iJNg+Fj9BeFdfz7nDRGXhsEsK+xU2VbXcMRRFwIrfx6PS0ky7oXIyE4AZG2MMsZ++2
 91hqNz90qOAYLoJ4QtrP84qdSswV1rq4lHz/SwpliWE3yRopTS65/+qm1trH+lAsf77A/LZjXq7
 nSu9s+LU+jCBHgw46rg==
X-Authority-Analysis: v=2.4 cv=XonK/1F9 c=1 sm=1 tr=0 ts=6a554589 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=H7u-uynIU280lupyLLIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: XHO8sWcA00BsNmxXO8rQ_Z61tQb3Ir6i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX10PmXcdKqZVF
 GsTLmRwpaXTtD8JTPxpeNZ7x/zSxbm3xlHk7Y+sTCu7MzNXTJmyckGATnMxnvaIKa5r5BWSDWvw
 pJ8yK4/IC+TyYET6qulkEaZIZK2BpBA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130208
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
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


