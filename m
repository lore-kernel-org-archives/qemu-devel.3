Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D1FCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD6k-0002gv-QZ; Mon, 15 Jun 2026 15:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD65-0002QR-Qo
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD63-0001Qs-87
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ17OY1393465
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zGujvD7uH+y
 W2wYzQ7GOLuR+E3tz4/noxyDLwMFpBc0=; b=EMdBST8ANi8mMiKW88XKnl1qeGD
 nFfUf5aCCD9QQXJaP295PMq5HR2bAGo+dWFmgwPi1dkuSbA/5kchUGu605UVj2RG
 VkOErUtzdWlbVDsn0wsdzqi2GELtjIFi7q8WRmTP8whEtCtZ3VcOkP+3G1RmkRhT
 YLugn8H1svWzEInpITsy+3Vsb3UXCrfehjkUKMciaF0DZA4Srsv5gKF0wKsNF4fm
 5OkUGoIUX9e/AA6xqjgR+mY0/kY3/vG0T+bY538VB6c34yejx4F9TcmqjOIg8iID
 xy6XUwsNITgodETQ+kVEnG6FwKpZ8gp+PITHrmYgk5cAvngBvtJJKZHNdRQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter22n91-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304dd917645so7795472eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552145; x=1782156945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGujvD7uH+yW2wYzQ7GOLuR+E3tz4/noxyDLwMFpBc0=;
 b=TKlbbKQ124kA6ep8Ugs6OBys1giVr5K0+sVz1kcye6XKmmF1WT3/RcT0EJzDY6//yw
 vyIZp25AyRa2KnbZYi3olyxVOvGD7E2mZYG1RrHAf8iX2/dtvXCbAri97jO3CSb9chyj
 uIckv9gZ7Nv+TlFkTa7iHFqnR3wpbwAcE9g33mg9y/40cdlRDNVGfWBcxMT3ivl/zUTQ
 9nic+XWvzc32+XkjkkcwZs831Rh94b72ZKqtc6Wu8S4z4wYYixs0HE+kudCyAGQyz5BW
 wlRu2/VyzmpP1VQCNwXcITOhU2tEWGjZjPP+Y6l6A6pGD7+rZnFVhwoMHB9F0rOmwEPS
 z4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552145; x=1782156945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zGujvD7uH+yW2wYzQ7GOLuR+E3tz4/noxyDLwMFpBc0=;
 b=RerQTwZwnCCDklnJcUvg6kel4nFsEnsuz2ZLnrtDl7k9rv/KRJazfKuWKnre3s4Ar4
 SPk/+Z3wUsSkXCj9XKEe/32FOrz+cw7p+l3aAeILKiMbuEVxKY4LVcwrwEbiMYhXA4ml
 Gh0CW9eMYGUf9NQgaDZyeOmG8b7y1eWg7IhoRWu70q4VPyDg4Ly+bnHfjFzG8E4PV3NS
 vlmgFaCrWA0dDWP4sFWENiMMcbh/wxPYvwf34IiYxr0PC5/FDOPbQzd8j6ZGVjPrmBr7
 oZoOCPWe047CbsArXq12YdfiV2XxO573rXtg6HOQ8hdhgnIHMy0gwAPBGgN+Pjmkb/Ng
 91fw==
X-Gm-Message-State: AOJu0Yw4H1hGLzjbqXDx39+xQSRODXuRtU3hVrT3+kTStigxql/i4x65
 s+izsnu9XNZ7F5vK1ZOYW2zqQPVINgRY7WIc4tSE3P2kbbX2SpXrEWFE8hvfSPjm+St5EQUi2oz
 l4ziT1/fOO0Lf/gHkcwa0XCZSfeIhr8rHGQl2tK6uerkAJ8H9XabP64AzSJ8qQE2j9ac9
X-Gm-Gg: Acq92OHwMCFSp3Cuhdq2HyjN04nXn4Exx5ImK6ZtuJVamOyTLjhOojKMS+BvvJ1v8lz
 6TB7K+/z1OEM+kX5DozgRHnO+7zdXsZgMU4svqWcxYdjm0aF0gYAIwU5mUWT2Z58AnbUC5NeVUA
 ya4HWbSiW+cCpZ/ER2DMcuytREHgDXxCC1RjGmjC2biRbiLZihu0weZoQ02mKk206psM1SGd38B
 8iIWqfBQ7hYfZEZmqKMhSY9/cDEyt19E7kFhdJ41+WzmCvgD/ZGLReycM1jc2zlyG19FIHUILsU
 bVYSG5m+DtbDKrqQwB3duucwT//lHy7cL27MRiGqc/mKZ7Z0fx3uq0HzPzOYNQfZkntI20Rm/AK
 +bp5C7EDzxmZ3rnummP14Zrr/tRqWA9pGM7JFM2bFfy0KTLavRm8VAJkJrG2/N1bMe0Luj5oTPO
 hOL8/A5A==
X-Received: by 2002:a05:7022:f9e:b0:132:ac76:9772 with SMTP id
 a92af1059eb24-1384bb966a3mr6416582c88.34.1781552144796; 
 Mon, 15 Jun 2026 12:35:44 -0700 (PDT)
X-Received: by 2002:a05:7022:f9e:b0:132:ac76:9772 with SMTP id
 a92af1059eb24-1384bb966a3mr6416563c88.34.1781552144224; 
 Mon, 15 Jun 2026 12:35:44 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 13/26] plugins: add userdata to
 qemu_plugin_register_vcpu_discon_cb
Date: Mon, 15 Jun 2026 12:35:12 -0700
Message-ID: <20260615193526.2883349-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX6JEHrxSLwFuT
 bz51fQIe1bm8148wcwlLbUcMO5Z29fVBgtm23DpSae95e6EIjneUO+s5+M/zTQ1rpIjXX/n1Z0c
 cWSlv7eu1JuUuDhQ90mhUyK/y+G4KOQ=
X-Proofpoint-GUID: Iesgk3zX9Y2Q0EClNkdXk47EcDmgVg2G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX5x5+SJTe+b+I
 UHTyeZ4FgGEf4AoX6SF4bf8I/+3rYoSQbUNTqpL5PVxeQ717/pQumErNsNbUOPSUPqJumtkTwHu
 xzERZZL7c/fi1QhAATvgAXaXA0mPoSxfds6LV3F2M69JdZNo8uxlHcnLhLWuq7jwdXZgQH+tt43
 qdBzrU0C4/XKl5VjU/1RTSKDoanXfkuANt+qD702oLEXvQozl/FzYKSGB+MaAx3YSujEql/livx
 5Tn1UOHD2bj7TBcELAdSgaQuQIbk33ITFltqzJ09SVQaIdSFUElnTdvoP3psdk7qnxlUqw86yUs
 Zfg6e/Q/3vSdUWZy0+RNKMzoXX9UxgJGLttOBoMrAOEOxje9+14mWiic4Upiov4joKshPjOM18Z
 DUGUQLwuuoiZ1jKYEUlt8WkE8lHYdB8VfjTWgIZGdjMiJJrMrBdMZNviKlf/V9BKQHvlKOEAuV9
 KZxjKSeFLPEELni5PFg==
X-Authority-Analysis: v=2.4 cv=F4tnsKhN c=1 sm=1 tr=0 ts=6a305412 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=UCrIKau3vUVB3JaL4XcA:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Iesgk3zX9Y2Q0EClNkdXk47EcDmgVg2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150207
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/traps.c       |  5 +++--
 include/plugins/qemu-plugin.h |  8 ++++++--
 plugins/core.c                | 12 ++++++------
 tests/tcg/plugins/discons.c   |  4 ++--
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
index 4b879a8212a..4d59aa3c09d 100644
--- a/contrib/plugins/traps.c
+++ b/contrib/plugins/traps.c
@@ -25,7 +25,7 @@ static struct qemu_plugin_scoreboard *traps;
 
 static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
                         enum qemu_plugin_discon_type type, uint64_t from_pc,
-                        uint64_t to_pc)
+                        uint64_t to_pc, void *userdata)
 {
     TrapCounters *rec = qemu_plugin_scoreboard_find(traps, vcpu_index);
     switch (type) {
@@ -75,7 +75,8 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
     traps = qemu_plugin_scoreboard_new(sizeof(TrapCounters));
 
     qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
-                                        vcpu_discon);
+                                        vcpu_discon,
+                                        NULL);
 
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index cf937c60ee7..03e7b2b1fb8 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -186,6 +186,7 @@ enum qemu_plugin_discon_type {
  * @from_pc: the source of the discontinuity, e.g. the PC before the
  *           transition
  * @to_pc: the PC pointing to the next instruction to be executed
+ * @userdata: any plugin data to pass to the @cb
  *
  * The exact semantics of @from_pc depends on the @type of discontinuity. For
  * interrupts, @from_pc will point to the next instruction which would have
@@ -198,7 +199,8 @@ enum qemu_plugin_discon_type {
 typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
                                              unsigned int vcpu_index,
                                              enum qemu_plugin_discon_type type,
-                                             uint64_t from_pc, uint64_t to_pc);
+                                             uint64_t from_pc, uint64_t to_pc,
+                                             void *userdata);
 
 /**
  * qemu_plugin_uninstall() - Uninstall a plugin
@@ -293,6 +295,7 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
  * @id: plugin ID
  * @type: types of discontinuities for which to call the callback
  * @cb: callback function
+ * @userdata: any plugin data to pass to the @cb
  *
  * The @cb function is called every time a vCPU receives a discontinuity event
  * of the specified type(s), after the vCPU was prepared to handle the event.
@@ -302,7 +305,8 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
                                          enum qemu_plugin_discon_type type,
-                                         qemu_plugin_vcpu_discon_cb_t cb);
+                                         qemu_plugin_vcpu_discon_cb_t cb,
+                                         void *userdata);
 
 /** struct qemu_plugin_tb - Opaque handle for a translation block */
 struct qemu_plugin_tb;
diff --git a/plugins/core.c b/plugins/core.c
index 5b4ed0ce213..0da7fbf929b 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -122,8 +122,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_discon_cb_t func = cb->f.vcpu_discon;
-
-            func(cb->ctx->id, cpu->cpu_index, type, from, to);
+            func(cb->ctx->id, cpu->cpu_index, type, from, to, cb->udata);
         }
     }
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
@@ -656,16 +655,17 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
 
 void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
                                          enum qemu_plugin_discon_type type,
-                                         qemu_plugin_vcpu_discon_cb_t cb)
+                                         qemu_plugin_vcpu_discon_cb_t cb,
+                                         void *userdata)
 {
     if (type & QEMU_PLUGIN_DISCON_INTERRUPT) {
-        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb);
+        plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb, userdata);
     }
     if (type & QEMU_PLUGIN_DISCON_EXCEPTION) {
-        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXCEPTION, cb);
+        plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_EXCEPTION, cb, userdata);
     }
     if (type & QEMU_PLUGIN_DISCON_HOSTCALL) {
-        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_HOSTCALL, cb);
+        plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_HOSTCALL, cb, userdata);
     }
 }
 
diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
index 2e0e664e823..22114830fdc 100644
--- a/tests/tcg/plugins/discons.c
+++ b/tests/tcg/plugins/discons.c
@@ -98,7 +98,7 @@ static void report_mismatch(const char *pc_name, unsigned int vcpu_index,
 
 static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
                         enum qemu_plugin_discon_type type, uint64_t from_pc,
-                        uint64_t to_pc)
+                        uint64_t to_pc, void *userdata)
 {
     struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
 
@@ -214,7 +214,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                                     has_from);
 
     qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
-                                        vcpu_discon);
+                                        vcpu_discon, NULL);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
 
     return 0;
-- 
2.43.0


