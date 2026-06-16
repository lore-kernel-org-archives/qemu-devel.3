Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3B9CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYka-0004U8-Gl; Tue, 16 Jun 2026 14:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkX-0004T5-RU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkV-0000Q6-8S
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:01 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOpRn172521
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XCp7wjMoPJE
 vUc0k6Et5EuPx3gYWSwbF1epVDK/IHxM=; b=BrDH9cNysEFfyLxnMij/2wXgyvl
 Sg5lfBYZrxbkl6N5ehPOBFgLguepLIjloZctsaDJ85b4+TS92xj5CYGsutObPOUx
 5YrQF1tZwFGYgf5lFkndEjfkEtY5qKSLbqCQULtfuX2r2OJSRQi2HYTHi9ZgqvLN
 YKsWjfgaZvT+zXjwOZlgTS7PfR9w153aJj66E/givxWTtlgqDGSRccOCf7es7r7J
 j68mpR/VdGg72WtVmgwxiKEAyxlpoNNmpDHTpBH6/3yKz/0JD2Fww5E6EQCkjSW/
 aD4Y/+2XyW2R97VZpX9QSG0Qj+Qo7QN7zWMP4fAamjXimCdwb4lMu+WG7nw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09kbhwe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-842208d5b0eso3883639b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635367; x=1782240167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCp7wjMoPJEvUc0k6Et5EuPx3gYWSwbF1epVDK/IHxM=;
 b=h+QSUzcJ4IUHSQe7/urIQx+ytwlALcOOq9HJrySMoU/R9XlZvUHi4/qD5eg3lWBHT7
 kNddRxuP36a/WL5vn/OtioUBNE2So4WcUAY/1afJcoCKX2MoeedhGzHRlzt1tp1N1Zy2
 /BsU0dZoFOTDsVMVU3ON4iRrCl+Gk1/Ev01c3VFnQllhN38IZmmTqMXu6irlF+0HY2Ai
 PH6KdLIhH0ByM8TikkVLBxP+Sk2SeK9khOSw3j4feswnxBw/MM3TCSSebh4SWzMnUg+k
 QR0t8ZvKgZnGlLUZm1kB/7x6bpaOY/jNRbVTu7mjsmrh1wPX1qiN8vqUWpLj6JRXWFu2
 C+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635367; x=1782240167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XCp7wjMoPJEvUc0k6Et5EuPx3gYWSwbF1epVDK/IHxM=;
 b=JS0Jl2K1vw0jU77me9CYnjhYry0nUQSCLUMWGftb825O3dUG8+rY2Pe7unab1oyBSn
 CLTZgIP/kIIvMBqgReXpXgG6mubS8UQVqKamy3WlAfoEk7FEeBwDJkBgAXGNqDOT0Rl6
 l7godS6WGScFNdHOUsGoY4BrYRpWbyA0RqfrMrDUshI38TMbzX9P3MJBekiS+gtZy7eU
 IMlrdLHzH/i2mzvdjXoMYosHpEGGjoTUKMa3MERTu76HGakYcczjGDuUzjU1ykrG1FKL
 yKBqZNBljR/5CkTb6FKaaQ1eLRmrG8WI+88u8YUyfcwmse8JeTpfx3z6IXXYeU8Me7s6
 TuNQ==
X-Gm-Message-State: AOJu0YwruhPzaANTDupFl7nlYy0QlBA64bxo9A3yp/RDNsoHC25koTy0
 Muwt28NjPtUD5MTXyv/yXN+DK4olq5CXKZ+HRywCJjlDM8vba1VSv2fK96d+Dr4ZFai5WuTLiKG
 tnhlHFxIsyrIgkIKBhvjkCOeZIU0MXch2mYOfd+okb92ig+WfOYe2yg704vQW0eD6kYNh
X-Gm-Gg: Acq92OGw+yBqSLP2n25+UEI+MG/98oZEr0oa7KwztAkgssiMvx2gQYeNyNvNQb4iLVR
 8q9jdAsqSYJ0GGkPcwga+uv6KqzZjEnHdafZ6PSkZSyYAQVsZ3A7ocMwe6kbp912xD5TbSDx+zW
 WIjG20enBFqNwKB927Wgewwc8vKV/sess1iWLwcsA2NgRlg5UIYnRZjDazcvIK2aEa3z6BsKQvL
 gWNtc+V1g12b6B2N54mgVsxWFWcOYotX7aljRCUbotyNHbRa6wCwy2Tc9P0RLNUUJOTJL7+fXVb
 yyn7Rk1FoCUGadLoOpndBdUBp3pBUiBr28sYEQigk0gtecXatauKTm/jMlzWgAX9kM80COdkd3m
 sSXtvcnJy8Wnq6enePv8ZQ8XGpvBrmZmAx5R+bhDYfXEj1cMKP/h9aIVpu0oN6qvxSx2Az4wM/K
 bq/ljoLWY=
X-Received: by 2002:a05:6a00:2d25:b0:842:6f13:1461 with SMTP id
 d2e1a72fcca58-84524476bcdmr368294b3a.11.1781635367173; 
 Tue, 16 Jun 2026 11:42:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d25:b0:842:6f13:1461 with SMTP id
 d2e1a72fcca58-84524476bcdmr368271b3a.11.1781635366680; 
 Tue, 16 Jun 2026 11:42:46 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 10/26] plugins: add userdata to
 qemu_plugin_register_vcpu_resume_cb
Date: Tue, 16 Jun 2026 11:42:14 -0700
Message-ID: <20260616184230.303038-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX+KhnpvriHBmi
 78P2ySDbyAWXUyucXMKym1dI7rZ5ljkPl2KtqKr6+iJpevmPz5L7ajGovPNo70/o2nhQJfvLiT5
 qhTYiS0KjLy28R4Qhdg9Plve4kCAjkA=
X-Proofpoint-GUID: MhqQeW8msH0scOF-lwC0QMpxGL5Wv-_U
X-Authority-Analysis: v=2.4 cv=DoZmPm/+ c=1 sm=1 tr=0 ts=6a319928 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=jbUUBHnpNWWeZ8W5LfIA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MhqQeW8msH0scOF-lwC0QMpxGL5Wv-_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfXxDI0t91OY/vT
 xyz9ArkcqF/hbHT8wWWA+sbmLii7Sz/9eBlnR1OCQP/atUrlT4/Zsd7FgyWoH5eyS5opempnLqR
 9XlZJ+0s0uMsSBpLbtOEiUwFy47WlDA5eTTcQDMUD/OLxqiFJpc8KFui2DTHTsqC7uzC7j9/zif
 Xf3Vzsj3JM1dfwDyAYU9nj2V7I3rOr2Qv+oRV18AIP/ES+85AgijEiOGz3f5DWe5njBJOK7YMgr
 omkBgxPJNNponx4wXiqs788GfIpgRKsDmNzWz1b0e2LrTYNk4AtmX9R9OS8+Z565ZF35ztK4cde
 3ytkycBCA6pN35S9if/Thkr3QuLwAELDaC3GJGVaPsNQTGwPgbAIsEPoJFBzhOBuYxh8r66JcXl
 g/RfRvN6AJauxCPg5sEp0hD8vB3ShHyABvo9z4H5UYyLIQXl1EJeYhTz07nPF6ek/ggxO+DfW/i
 H1QhU2FgfhjHJ8ikoyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160190
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-11-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h |  4 +++-
 plugins/core.c                | 31 +++++--------------------------
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 75d2a69a3bd..8c146ea49c2 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -285,12 +285,14 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
  * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callback
  * @id: plugin ID
  * @cb: callback function
+ * @userdata: any plugin data to pass to the @cb
  *
  * The @cb function is called every time a vCPU resumes execution.
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
-                                         qemu_plugin_vcpu_simple_cb_t cb);
+                                         qemu_plugin_vcpu_udata_cb_t cb,
+                                         void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_discon_cb() - register a discontinuity callback
diff --git a/plugins/core.c b/plugins/core.c
index 47244603786..342357a7499 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -78,29 +78,6 @@ void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
     }
 }
 
-/*
- * Disable CFI checks.
- * The callback function has been loaded from an external library so we do not
- * have type information
- */
-QEMU_DISABLE_CFI
-static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
-{
-    struct qemu_plugin_cb *cb, *next;
-
-    switch (ev) {
-    case QEMU_PLUGIN_EV_VCPU_RESUME:
-        /* iterate safely; plugins might uninstall themselves at any time */
-        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
-            qemu_plugin_vcpu_simple_cb_t func = cb->f.vcpu_simple;
-            func(cpu->cpu_index);
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /*
  * Disable CFI checks.
  * The callback function has been loaded from an external library so we do not
@@ -114,6 +91,7 @@ static void plugin_vcpu_cb__udata(CPUState *cpu, enum qemu_plugin_event ev)
     switch (ev) {
     case QEMU_PLUGIN_EV_VCPU_INIT:
     case QEMU_PLUGIN_EV_VCPU_IDLE:
+    case QEMU_PLUGIN_EV_VCPU_RESUME:
     case QEMU_PLUGIN_EV_VCPU_EXIT:
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
@@ -636,7 +614,7 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
     if (cpu->cpu_index < plugin.num_vcpus) {
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
+        plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
@@ -667,9 +645,10 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
 }
 
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
-                                         qemu_plugin_vcpu_simple_cb_t cb)
+                                         qemu_plugin_vcpu_udata_cb_t cb,
+                                         void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb, userdata);
 }
 
 void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
-- 
2.47.3


