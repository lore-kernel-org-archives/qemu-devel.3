Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F3CCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsZy-0008By-Q1; Wed, 03 Jun 2026 16:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZY-000807-JN
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZU-0004F5-9V
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:18 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653JUgks2076092
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=93IDN7wiimW
 ZkhMH0DM+l8cxRFMawbmqsxL86VRHJUs=; b=Vvv4/8FlZI5e7jUnXqfvH2WrtBl
 bMRFxt1cMZHLsZAcG/cWf1R2Jm0eq08gnNm9Oq61r2oPNtJOeEX9CcEEFhlQ8xvS
 gKSpPgZzVB6ZQ5Ei7jlGCJSo5tUhGCDCaTeBncPORzlJT6Vu/AJ26iMvou5JqniC
 U1RS8AYquazl3tvULT2m3R6NXrmprT6bw6L/AvoAUV7/HlwLSO9UsUa0LyNBHCby
 zSFjCyURhJAt2JOySNeqa9HzjDZw8WG5AewuO+3t5eksxlO7Mk1VyrWeAw8KOW4s
 T4jNxt9/wufIbdmpiO9FilbotoPNnyVyet4yckMGgwXSf/FzXsNCfd7vTKg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev1bmnj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:14 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137e49e896aso720054c88.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519933; x=1781124733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93IDN7wiimWZkhMH0DM+l8cxRFMawbmqsxL86VRHJUs=;
 b=WIg6P07gHD/EP2/jfZ0h5T2HMEvHD8Hv622byT0gRgh8PHr1sc+G9gzp57rJWKzspF
 y7BUyS76/dfu227vnQhc3mEV1ubi9GKkSq4X2/HJtFMyFBPh1maVUDDfQrMLtbaLQdzj
 OfZfB3Hwf1KClGmqdnFqJhfVNaZxOn8Su1BAkYZ0L10XHkuqPFQmLEI8DGLg6rlKBzUA
 UQa4eZdA65s3d9C5S9Yl0yarYUyx2nA0J7JIYXL8exE6dsmluwHsWGuxPYuKjl3hRXKQ
 SjF7baLbdUAZpxP/f8QwVq4tgSNKgOjq0NJaCDwDIzZY9zfBPRk/K0q9fV3krozsL12R
 80AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519933; x=1781124733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93IDN7wiimWZkhMH0DM+l8cxRFMawbmqsxL86VRHJUs=;
 b=LRoseREouNWqlU2LCuR5LtWBSJICTne1sAtyVbmZwhVu4BoEEI8iImQoJzeRbyTjmu
 p11765Ce0vfqfPJDfmsst41GmOdC1SQGlcZfd8I8LkDJN56P02KwWeo4sFXugh5EoVWg
 G/T6GwUGknz1nOlQkr+LcBSjtDuUGYsJ5DBtwaqUgFOrpYZlsSaiyiiKZBHT/rjxchXN
 JUOEjQ37m7XwvE+7ZpZERMa4z03FfCkZiFfQnYpWs1yFbnDZORhqy1dwtwL+S1OuOM5P
 kxjNwuKY6HWaoU83ysZv+GjbXBAh7eoRdCH5rBVD8K8mAqevLjrd+FsS62jyDf3DD0yn
 VEpA==
X-Gm-Message-State: AOJu0YzgSdahghiSKhJ+j3abTuspx6CzyaQXPW1f6CS/NMRmAa8DCoyP
 64GKV2whLzmIrgfHJSOgsHTtB0HBI5sPYT5j13l3djLitrSPFiJhYu5+N9QNTqzfXW+oVyqcb7n
 ckJXrTID7E7cx+ci4Tk0T0ZkFMF3C4cvMCL6dX4QQ2DxboY7sdtOO0LSJrv4sRVdTTMiA
X-Gm-Gg: Acq92OGW8NK+vewFZbpZEpQgnlcQBk3q/Tywu/BRjZ/zbDTd8J1dTGpoPmBHke4VBtc
 96ippsU35i7swFahKLeR9lhFjd7HqkVyhBXBtmOZbxcYMXjnwlHp0ejerTExAu1IIBvLzqRZHm+
 Swby34CtIByxggp+NZVg/haxd0m+I7lFVVUKCG7xKepIHpJcj9if0DuH4mYvOGoJKs9p1AlHJjM
 3JL3Uc7uK0vcu3dZeTZRkvfNTpG+nnBIH42a2rD/pSeJu/3opYb+MNc5PbwFynu7+GHEG/QEJbZ
 ZMcz0ol2bvnHSaGCW6n0PQZCCkfSCqU4hUAOnN/+U8Yv9MC5OnTk5Wsnzxx3ka2pLvZsnbmORX5
 IJ2tCwISvoiHHYicKQ6PkYwGfKTThPLPbrpF7WaTXrMgPPpBm01n1gWWjne0BywZ2DwGrKUccpF
 4JjYRqO2wM0kQdQC3B
X-Received: by 2002:a05:7022:62a1:b0:137:fac1:c052 with SMTP id
 a92af1059eb24-137fdf4c45fmr471169c88.16.1780519933307; 
 Wed, 03 Jun 2026 13:52:13 -0700 (PDT)
X-Received: by 2002:a05:7022:62a1:b0:137:fac1:c052 with SMTP id
 a92af1059eb24-137fdf4c45fmr471153c88.16.1780519932687; 
 Wed, 03 Jun 2026 13:52:12 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 10/25] plugins: add userdata to
 qemu_plugin_register_vcpu_resume_cb
Date: Wed,  3 Jun 2026 13:51:37 -0700
Message-ID: <20260603205152.1440291-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VT8HgvCFZcou5PSXVIstERAEuD0jMXbI
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a2093fe cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=jbUUBHnpNWWeZ8W5LfIA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: VT8HgvCFZcou5PSXVIstERAEuD0jMXbI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfXzpwmwzgKSB9l
 X6P2dWOpi/0QCaM1Kv1CPPvAvlKa7xtgb2P8Obl+kmVV+8k/hryos+7KW7KKhNxc1EM5/XdZj7g
 aRelAXraXzXW1kpNzCduAUI6aqJAyGil9JNoXGxZDPFJ+6PVf2tbRJuFVH0PbPwwNFZa7iADVe4
 0Tci5VnunUmGfxFTRui7ec57evyEE2pCSIsT/87AZ2IAnN9egLzh54sBELRTvOVALdTEoxBU+U6
 Grmdlcymn2p8DIYB/GWpFt25HvRdX98rsQWbZs9vC0bEwoE7fCsvXxBVVZaPk/tkeKUrIkbtluj
 HIe6p7qogpbs1fwIR7HF0zfTUMvdMCbcbc/3pxMnJ1PNdpEJndKjUQkf+Mr7OsP8Xk/GICWyDN1
 7m9H0KaEgnU45ipVhvhXIZM6HhehiFNoAG1IyHaxM1qCu4vnnTDeLTni5gM0JQAgm90QNEJA0f2
 EHV1DyXIS1++VzWqLFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030203
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
index 111ceeea285..aa9240fe21a 100644
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
@@ -635,7 +613,7 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
     if (cpu->cpu_index < plugin.num_vcpus) {
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
+        plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
@@ -666,9 +644,10 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
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
2.43.0


