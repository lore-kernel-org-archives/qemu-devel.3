Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035AACD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYl2-0005JQ-EZ; Tue, 16 Jun 2026 14:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkb-0004UR-EZ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkY-0000RW-3F
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:05 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOtXQ303627
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vOJg9WnkM58
 XNdIm5fxCrrM87dShj+fmFLQWvVcrFJ4=; b=RAVmr67iYAAoY1sbglia4TdvM1u
 LefS3OgWmB0Bd1bqZKxLPcyNJpVy6n4rQHXFMhkPC5EwTYCKrr4o8TJOl9IEKXnn
 tuEdxOZ2PYYYrlKPd8By7FBhcAXgolRsC67nfiZ0VVWFrfPBL6tOKrqNUdMNpNkk
 Vn/8MonV7VlxaVZBolr2MC2MUzcvtHYMk/zkDP6RdrgbkwUTeRicN0d0wuHJLEMb
 X7VsmI7Shg9IlhfWG+DkJKwaPR6nWpcohLKnYBl4LbbP+d5Vp0Iu7616tOsBs1Zy
 hTer2TWsTqMht16V+dMAHXnmPILMbzv1jP/5+k6FBSONqnkihBJGotsflQA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1epb7d2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c85a2f1d1e5so2625235a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635370; x=1782240170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOJg9WnkM58XNdIm5fxCrrM87dShj+fmFLQWvVcrFJ4=;
 b=f5N7fFoRbAkgzI6l0dwaDvtNKW8s/xju0iNfPYa4qJ+eB6K9kUzUq4g4sww+pfKzk9
 wGlbFtLYAtw3YGHmqZXGlELABfhiA/1cGNg2612qEdSX1w+Xy+tWL6Htb3EkJoWK486x
 lbexCRwu+QQ54RVLfY5OKajhvXbdvx9lZ7k9Im7kDi2AOyiQGJH5/YDjkcvrMr/bmFRc
 HVTRwHTW8J7o+LD9mJeTbIJGBhvtmkeYdraY3BeS9XTrWdmRN86W8ziCnJ+1H+2rviRS
 5MpyFJf5Q3exXhzmM6698mwIPqJkcIV6hukGPUdG2CNQ4JSK96vKGS8bRsoUX+Z4KoMK
 YMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635370; x=1782240170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vOJg9WnkM58XNdIm5fxCrrM87dShj+fmFLQWvVcrFJ4=;
 b=IVjpslAAC0tzXvuA73IKenQkkM4krDn2AYdSb1WF/aVogqukxhNkUhlCjmyH+mWwRV
 Nb7tsT2tL0kZMMCEMiFhTF3ZkfGP3pSVFLUvD3be9Sg9sPH+yqbX32TdW1T+zi1NQx/c
 3tSnoTmH/Z0WagAYp4mO8EcgZPqE9WAT1GamriWBvTiDicS4+2rL04eryPp4iHduC8Wf
 sND+CAvWaYH7tLNsxyM7q6U8IpGPqN43T8wDNaUI0EBkag/+Hkkl60bUR1MRssSrpP15
 wQpyXH5OtKlODUrbDsRcGJ+AwVqvuME0AInMfWz8hUQgLEpf4szCcwIvebbEhbGyUEFz
 U6/Q==
X-Gm-Message-State: AOJu0YwBkzrbC3kGezIgt8C1eqEUe95O65IWCMMz0fs2nIWxeATcFiVV
 ACxZw57J7l6DmhBtp6gdTrYg71edTbN2MTyTh4ywWNuvwqSuUIToq0R9/PgVMNecQyrIhKU4iwe
 e2uU3wTrVkmm+wW+do3kxWmlZ9YuZSZDGsj2lzM16I0qurcFUJPyjrVZj8uMIqUhMaLIi
X-Gm-Gg: Acq92OENPTdTuTXMAtYB81qOcVJTYNirrGSbozs16Es3dbOM0JtezX0fbFfR8mD1Var
 qHajx1uB0rFJ+UgdeHoDfNEppSGV/S4z0Wsi3qwQJYJnnjXQ2rqPj3eOhXdOmI/oV+29PMppLOj
 x+azfYLI5H1yocDt6/l7wASFTWAtPcJo/ANDBJe6SK58d4C41f2EU0kQdbFQKshY3roc1RPy1/5
 Kz9JeuGTOquGiZOiGSpJERclMs3nIkkYmFuCPZbJRJ2fqDxQrYjfk3YG/jfo1Pt6pnboIFI5/UR
 s/QOHr0xtQUYKmEtcReSlWwEt1oTXT8re4fMVkkJWmLtgG9eywmFQWvgCt8XhuMNzDFA1pUfbwl
 gM9Nqq+FPJSYLPBVzkxu3rUsZOUEiBWYJFOBfV4VnKjalw8Dvan33IITQ6x0ZTkDthoIJ3880BQ
 +6PjSwiws=
X-Received: by 2002:a05:6a21:458a:b0:3b5:28d1:8bb5 with SMTP id
 adf61e73a8af0-3b8b5f36f87mr516856637.11.1781635370029; 
 Tue, 16 Jun 2026 11:42:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:458a:b0:3b5:28d1:8bb5 with SMTP id
 adf61e73a8af0-3b8b5f36f87mr516834637.11.1781635369602; 
 Tue, 16 Jun 2026 11:42:49 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 13/26] plugins: add userdata to
 qemu_plugin_register_vcpu_discon_cb
Date: Tue, 16 Jun 2026 11:42:17 -0700
Message-ID: <20260616184230.303038-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a31992b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=UCrIKau3vUVB3JaL4XcA:9
 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX2q7IS4EXsVU3
 cO7tkcLY62ckqVHNlppwWlfHZjWzt1xuC/BW9Uo5FFuPvgMuYEnLMutBMMpV1yIfMSjBKp7OjFS
 37aBSVXl9RMV8OxzLM+KJpVkV4O6Gnc=
X-Proofpoint-ORIG-GUID: 6QsVB8lC7KiBbm1TMarKg5NVvXCdrobL
X-Proofpoint-GUID: 6QsVB8lC7KiBbm1TMarKg5NVvXCdrobL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX8FmCrW/RZLFz
 q4pJ3q1siMq0bZgtQ2Ai7RHCAcpWonWc6LxkeFF7omcJtngK91n7S3DSQTES7h4BbidBJQYabHe
 +/880/7Vl8zb8EapttMalj5e+Lh6MIexOgbWHFIcS+a08YIwJda1g9qa4Hgsinb/Ti51ho7niSd
 Vuce+FaYnf3exOafAGfgf9zAI8Gg24StkjavkJiayDfhK4cs3WF6jJjpgSVHAfeg4/RuF6wC49c
 5ceNHlWlOOn+r2vKYxEDyWbubPmK9aWTnc+Kb4NQnNunUas22ELGXedvz0jhOI4zHjJ6yDljOF3
 eGA/EA/eKez+X/l0Q7cKMSEDLpqTx/vGmRw8XoMFrWgt2AX90xuQCC2N62CkhJJ/Y7oG/e7l2U9
 gF/wKfLlnfeQR+LGWhsy3W9BpJc/QZjZ1nTF3uLiz7YnhPxVkuRmhFwc7mJBX5mLzE7plDUiMx3
 Ef3M41ZJTpFwDq/D62g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
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
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-14-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


