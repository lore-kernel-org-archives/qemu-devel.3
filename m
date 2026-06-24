Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C22CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB8q-0007Np-Um; Tue, 23 Jun 2026 20:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8n-0007MT-Tp
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:06:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8l-0003AM-0J
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:06:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK008e1189842
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MZP7Zk3uinz
 rssBb/EnhDeb4UwEFQe3jIpJKUSipL5o=; b=R5z/PXsNNEO4LptcyIZykvSz17J
 /NBQAK1Y4Rye32v2sd1PmpZhWmDICvHVuhGCkpThy3FFdNI1U4rEXdJTE99QyQxE
 +SRtSKPJJqd9ruiwCkWG12QeAvNxgQPlnROBcDA1fVo27O3wQRrIPOpdVx5IkxRi
 0J0KrgdAJR6lPjrG21r3d3FBpbJo1u/Em7X8Lf7NfJZQnjmWf4jieBO7FdVirtUR
 jrarMBGdI3Wxw5BxdF7vh2/Q0WTizqaKfl7Dzt3c25ZxY3HMPm/QkPRZxiHcryFB
 Ndb8bvPYWiPoVV0n/XQXm10Y9Gi2WvGXBq+JAhTJejsSRvc7zcvYXQ7bDFA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eytvh2ev7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8e06f4680bbso10270496d6.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259609; x=1782864409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZP7Zk3uinzrssBb/EnhDeb4UwEFQe3jIpJKUSipL5o=;
 b=YunjNv6f44ugL7a/0Y2vk+08yKJRTKo6PVulNoS8ZeWf/vUBESeJnHnHqd5BxVffs+
 QnDGQnPxxn2LaUA9K3iXNWhSiF1PYu270b4DGXjRHcwmCERRvniT/r58r+UFj41wPkKE
 ioy4AwqL0v2UmJR1htdbIDfewrUkGqCgQllxqKcnzIM+S+PWPQ8JJt2VFa+cI+h/WF/d
 fh66qyz+nMXFuqjkbSUfIPLihhYZRpEoZvofWEB3GiIlH87Knbe8fqfxKIdfzVgffSTm
 1AAX+K0bO33ethWN48HG6knN+jVO0sFJQG9HFmdx3g8+yg/h/Wl5g3m6ivjHyJYDCHEd
 8UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259609; x=1782864409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MZP7Zk3uinzrssBb/EnhDeb4UwEFQe3jIpJKUSipL5o=;
 b=qyrrcHUFe0KOnCSAoM022KckOVCZ9sB4r+Pf52psnQ7eY3OoWs0jnZG3uAhtlUX4wd
 +cAaFTQHMS5FXJUCRfEsaKpQWjU9UtnVgxDcPrlT1rPlm1ImPzKcdt1mNKU2L1hX1y0l
 djPFm7g3AwK+1zcGjTu5pqgt8JIxHyj+gpAG54n9mA7Ry/GgrhH4Br4gn8j6eKNjmUWH
 pXYPYybQy7iHAeaXHN9QIN4T15/LGXMxOikGiuCcr6GFnldMAjrSeBI1O8kBfLj2zvd4
 1xPUUPVG24KKp+qB+akFbDEy0F1Yk+fI2yNoNqjt7mbHqy2q4UxUsTAHRCk/Wdqs6KR9
 TDAA==
X-Gm-Message-State: AOJu0YybKvTQvrwaE990FGoeIGheefDU1PIjvVH/flVzSXTP1I63lPNF
 koGB6u2nksmNN6rvCoAgUN6aVR+Eo0Nzu2nDoKOuj60eHZPUr/yJrEQKAJsJHyIJtCZSdQfnBEw
 Q92oIY79nSUCGM3zbkKIIxHTTJIMBlTWTt4Vo7HBL5AIXLuMoUTGnowSJgggPgyMAyg==
X-Gm-Gg: AfdE7cllgzR7mEVfIcLfZkcI1vG5nHHvsjZx7LYMI5QrwnvAkj49mpJOsJ2Sv4on+Zf
 ogLp8mnJY2rQI7J+QlFhe5OWqgV7jXvCQXsvVrdA0OJh46oQpTyLUcvtQHuyItcTdUVVUi+OvHL
 daZxhZXRQw+S8T9w+XtMIDOn9LbybZuP6+A6vfTn2AfSrIO0upuDoKpZS4z/Pwc7UmpMij6T+CK
 EIx/gM2wZM6VaWDYBoMNiusiP/8ugMpO/rs0IV1i8Yt6/FN61oamjhaUwonIHapONebXSdW8uAs
 54FrpXHC6MbIfsh2adqQQLO8eTfnQw2fNQaotmN0zmwmW1vjfJQMEzgJ6Lh7EL55vj1qj4qTQ47
 15+Yi+4kYXOK9w/jy1RhQa5DOuMqWTVrYeaurZX+9pTrvZQ==
X-Received: by 2002:a05:6214:451f:b0:8db:aa76:103c with SMTP id
 6a1803df08f44-8e400e0d803mr92193806d6.10.1782259609264; 
 Tue, 23 Jun 2026 17:06:49 -0700 (PDT)
X-Received: by 2002:a05:6214:451f:b0:8db:aa76:103c with SMTP id
 6a1803df08f44-8e400e0d803mr92193376d6.10.1782259608940; 
 Tue, 23 Jun 2026 17:06:48 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:06:48 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 03/24] target/riscv/machine.c: do not migrate pmp state
 with kvm
Date: Tue, 23 Jun 2026 21:06:10 -0300
Message-ID: <20260624000632.2149359-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX0/0KbtXZDrrx
 Tl7XZpG3rZKA+hZWt3EmuwkL/n1mksWK5ZhlVo1ABJqBkJlEckOXNnX7t6BIKlQ+OrO1pEOAaLH
 a5eV9xC3/0JiRMIE6yr9etXrM1iqB3ud92ke1QADxpzicSd4LUi+uji9DSYPaAFmlvWt52T3xhl
 z8P+oygJA2Xj2lpz7moWfRFyHCjYVXv6TE+5Yw1jrIdb02K/SaeW+awK9f2xbraYw1W28xcE5tE
 Yvo6zjybEUHaaQ0b8X1is2zEl7PYfFwiy0dREuAX0GXcc3O2o0PQw4MWB0e6uRylU3in5vb4iS0
 TRky6Ptjq0YmjXj4tIrqD7iwCAUHO4/kvjYFUKCr33IzLremYuBpz+fflYbo5bHk3AkEtjF9woz
 MH1/PLC3cUQH9D47IQbyEg3G84gMhHDxg3VTHAZ/EUT3cxzEnTJA4Iw6ZX7A9Ul0K8DaeKSMMcx
 NhUS7ZiZvhi6z9D4PKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXxfcncc2MK64H
 8bqkA4eGAsn1X4mu9Big1nB3fYMbAysLf6CjeErul556gVOOZ+kJueIqn67+64MQi/FfaHdtx4D
 t82J+Adcsm1Qhp9FZtVAkXm7I27lGe8=
X-Proofpoint-GUID: kdnfv5gcj8_wTLinqrA2-_wKhBJKQoAQ
X-Authority-Analysis: v=2.4 cv=AJDhMgPs c=1 sm=1 tr=0 ts=6a3b1f9a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=oilNxGZmbZYYRX1p_pwA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: kdnfv5gcj8_wTLinqrA2-_wKhBJKQoAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The PMP emulation isn't present in the KVM driver.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/machine.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index ba96ceceef..e1cbcaa349 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
+#include "system/tcg.h"
 #include "migration/cpu.h"
 #include "exec/icount.h"
 #include "target/riscv/debug.h"
@@ -29,7 +30,11 @@ static bool pmp_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.pmp;
+    if (kvm_enabled()) {
+        return false;
+    }
+
+    return tcg_enabled() && cpu->cfg.pmp;
 }
 
 static int pmp_post_load(void *opaque, int version_id)
@@ -39,10 +44,12 @@ static int pmp_post_load(void *opaque, int version_id)
     int i;
     uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
-    for (i = 0; i < pmp_regions; i++) {
-        pmp_update_rule_addr(env, i);
+    if (tcg_enabled()) {
+        for (i = 0; i < pmp_regions; i++) {
+            pmp_update_rule_addr(env, i);
+        }
+        pmp_update_rule_nums(env);
     }
-    pmp_update_rule_nums(env);
 
     return 0;
 }
-- 
2.43.0


