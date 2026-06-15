Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738C5CD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD66-0002QN-2Q; Mon, 15 Jun 2026 15:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD60-0002NM-Gj
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD5u-00017x-My
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:42 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ1Hb41393707
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/Xy+DxpLUxJ
 Oai0mGUPw8MSLTlKawJ4baeII5y6IQeo=; b=XdZ0XrNi0Z1QBJEeuNrkeheyi1Z
 2V1jVH5+PPr9v8K2SPccFFI4/onM+O46IKKHpxKQXxx5Eh2Mvio0RwCKs1V+iXip
 0XjNsrh2cQ7O749QI3ZGdKIjFeHMM18Qx3GhSiRq5bsaTHuNbe4lraDfIhWx1yP7
 dPpqIpR0KqK6ptRrQ42EOk+5Ig2XeemQQu5b4JPHe7nbwREHG8Ac8EevWHq6CkRX
 Ad2EHuMS0sgFMGSZ5gjz2n88nz/zCfM2r09sLDBhU8mCed2TfY+EbQwwG6XN5B5c
 G3DMPNaATnpKfztJVxfGrgTFlluhA6Z30E+LJf5xQx3JH1RgwrjHd23VYDA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter22n80-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139553dd8acso3745165c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552132; x=1782156932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Xy+DxpLUxJOai0mGUPw8MSLTlKawJ4baeII5y6IQeo=;
 b=EYDj/SEWgNihFGxuGPKoZ/lAwQKT2X5fIN+3BtDXIwTokYlad7S4dOFKjogR9MhOD0
 KV+8BenwC8+5uq3iG94ZlQiqh4GvHD3MNXxKLdjH6E2qX57V8E74Bo9wYu9KARiUUV5C
 9eZ2BGeqoUOdzJoCP3RgMvv9eGIX3DKES4UTmTNalbkoTEp2XJD4+yUQhZvV0SEd7Ygf
 7jKkIFQgUg/IAeU7C98Dt5RW2pQYvEJ3Q1onxOiGwKpiiFJ3JCr8e/0PBzzaY5TKr6Im
 jTUk7me0mJigqEL4bXA/L4gqLghpMKgmH7nHbuGCRMjWwlbsPdNPZGjJZDR5ZcwTDyRk
 tJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552132; x=1782156932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Xy+DxpLUxJOai0mGUPw8MSLTlKawJ4baeII5y6IQeo=;
 b=E+virK7q5iYjUZeilAQNZE9kHVGbh5iwoUxbJl4F0SSE748IK1ZBd0cwRkYM/ahSu1
 Qf0nv1Jgueu0LOja8Hms1Jc6iicITxamPADKKrPHp/wMGJiZ5GJsVxbFix7EKVrFxQ0B
 Akp63elwurJuPtsMGEkgQ+fTiPvntpxhg32TJ7hSvI+BFdu4ueY3L/ScRnLubl8bHy5A
 HeP5Rf2u4Qdrh3iMWZaV9h7ls3Vy52EA75eTwolWZ4cyRUu5wGxfFVQKQ977uXUT1MIP
 LUHqMub+nNGMQ7aE9r3fPkyVZYiRM7BNZFe51Q4HxDanS+GLSI3KOIF/23AIYUeUAiLP
 Gstg==
X-Gm-Message-State: AOJu0YzFJKefDkCxwOKQhRm5KAhO0980AxXzoA89VYlt3fDwCRcn262Y
 tzleNZTGKuFlCb0u+YzTsK0/n8Fn8lwU0bCDAG3P9GaCZ1mwl4AdyO5c48N5EMorAxD+uoayFdB
 BiBwNIGE8yhAPG+TRODKAGzh2Hu3tClSOL4j3K0vGtlHak1WCbXXCPJ9P3i06+8+fpc28
X-Gm-Gg: Acq92OF/nkhARWvDRKtjEI4pjAKYrOOT8FYtnK7BjtLKXEdZOq69xHlVazCyUWew3oa
 hpOeVmQ+caOvV/FqY5tA1twqs68eENH4T0UJ3xopjTgiQeWno0XMR0jnwDlyeBPGhM3DA9PAFT0
 OTxBy1lNhxkEU+0dbPgd1vje9mXAx5PxynRXeoOQikIhVhOoquQycQe0TetRCj7EriCejLxCBUJ
 IwHLayiF3fu2h+3lAchNlM9J4bhL+clg4E+8fB5hJTEdtstAGg+cKtKISWWS7MMpp8oJ6inyz8w
 1n92cWo3+77HVNzChVYdGj14ZlRrRxa9lsAS6PbktnPI3pkh4n2F8RLozPpXrNqSl1Rw6S/6xSo
 ivLkuidzR1/nFlpm/AqI5OaGClRUQozxoH83ScZ3bLYxoCn/6B4GMJuiraSI8HGbQRg0igve3cs
 Ptl6otAw==
X-Received: by 2002:a05:7022:f94:b0:135:d749:5761 with SMTP id
 a92af1059eb24-13985e95689mr248241c88.8.1781552131544; 
 Mon, 15 Jun 2026 12:35:31 -0700 (PDT)
X-Received: by 2002:a05:7022:f94:b0:135:d749:5761 with SMTP id
 a92af1059eb24-13985e95689mr248220c88.8.1781552130982; 
 Mon, 15 Jun 2026 12:35:30 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:30 -0700 (PDT)
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
Subject: [PATCH v2 02/26] plugins: add userdata for qemu_plugin_{uninstall,
 reset}
Date: Mon, 15 Jun 2026 12:35:01 -0700
Message-ID: <20260615193526.2883349-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXxJJs6XwjNqES
 5ZnOmARvcS3kmAqZ4agIl4jD4P8iKvZuXB1yRHFx1VduFAXWXWnOgezPCUyRMjN2FFaF6cdM3oI
 QgENeRz4t0oX5my9x3uAkgvtsdqsY3k=
X-Proofpoint-GUID: _EVQ56GrpqO6_UWN-mxFYmAlYzcnihgN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX0Zo6xaqQaQFj
 Jwl+8/BUJ+SqD/DCbvba2ZMPtfAtXmLwGfXs7X52jf17ctIlYIRjMiVjfFK5IBHijR6y7LqCThD
 NNBrR6r0YpuQFdyf7l9i4SND8OBF1+VSMDBbjFAt3r+5YSlFZT/wfx7SI15Dksjcs6GRI3PHnHG
 VrgGqniQlbLo9C2Tnz2R2sCuFHgQZBoLa25BSTu4wZEBETexfGyxsD7edv9aCr4JCfAlSVpeoTq
 an+4h+r87ZLGIb3iHARHDuMkiO1DQ6KlM+Mf6Ei0q51vT8dOKGNhB06C4dR6MCT2IfThjAWqPBl
 aKsUgA5mtHwE2Z217IG+iFIDgojYfgDGaH6Z8HrAN6SEklZyDgp/gvPmPTM9i/rlvRMlG/xXrW+
 5o1OJKmYOFKzqViC4fpjrSIRhgWCzmWoTnPS+5kwzIrbngeF4AgZumpTczVstQFKoumRd2RgKG5
 UsKYFzBFPAuL0GF3Z/w==
X-Authority-Analysis: v=2.4 cv=F4tnsKhN c=1 sm=1 tr=0 ts=6a305404 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=_u34yJfUH-Co13bc16MA:9 a=O8hF6Hzn-FEA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _EVQ56GrpqO6_UWN-mxFYmAlYzcnihgN
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

We do both at the same time because they internally use the same
implementation.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/lockstep.c    | 10 +++++-----
 include/plugins/qemu-plugin.h |  8 ++++++--
 plugins/api.c                 | 10 ++++++----
 plugins/loader.c              | 13 ++++++++-----
 plugins/plugin.h              |  3 ++-
 tests/tcg/plugins/reset.c     |  8 ++++----
 6 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 62981d4e098..36b003ead2d 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -77,7 +77,7 @@ static char *path_to_unlink;
 
 static bool verbose;
 
-static void plugin_cleanup(qemu_plugin_id_t id)
+static void plugin_cleanup(qemu_plugin_id_t id, void *userdata)
 {
     /* Free our block data */
     g_slist_free_full(blocks, &g_free);
@@ -98,7 +98,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     g_string_append_printf(out, "Executed ~%ld instructions\n", insn_count);
     qemu_plugin_outs(out->str);
 
-    plugin_cleanup(id);
+    plugin_cleanup(id, NULL);
 }
 
 /*
@@ -189,7 +189,7 @@ static void report_divergance(ExecState *us, ExecState *them)
         }
         qemu_plugin_outs(out->str);
         qemu_plugin_outs("giving up\n");
-        qemu_plugin_uninstall(our_id, plugin_cleanup);
+        qemu_plugin_uninstall(our_id, plugin_cleanup, NULL);
     }
 }
 
@@ -212,7 +212,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
         qemu_plugin_outs(bytes < 0 ?
                          "problem writing to socket" :
                          "wrote less than expected to socket");
-        qemu_plugin_uninstall(our_id, plugin_cleanup);
+        qemu_plugin_uninstall(our_id, plugin_cleanup, NULL);
         return;
     }
 
@@ -225,7 +225,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
         qemu_plugin_outs(bytes < 0 ?
                          "problem reading from socket" :
                          "read less than expected");
-        qemu_plugin_uninstall(our_id, plugin_cleanup);
+        qemu_plugin_uninstall(our_id, plugin_cleanup, NULL);
         return;
     }
 
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 435a14f5a00..11213c2ca3f 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -221,6 +221,7 @@ typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
  * qemu_plugin_uninstall() - Uninstall a plugin
  * @id: this plugin's opaque ID
  * @cb: callback to be called once the plugin has been removed
+ * @userdata: any plugin data to pass to the @cb
  *
  * Do NOT assume that the plugin has been uninstalled once this function
  * returns. Plugins are uninstalled asynchronously, and therefore the given
@@ -229,12 +230,14 @@ typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
  * Note: Calling this function from qemu_plugin_install() is a bug.
  */
 QEMU_PLUGIN_API
-void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
+void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
+                           void *userdata);
 
 /**
  * qemu_plugin_reset() - Reset a plugin
  * @id: this plugin's opaque ID
  * @cb: callback to be called once the plugin has been reset
+ * @userdata: any plugin data to pass to the @cb
  *
  * Unregisters all callbacks for the plugin given by @id.
  *
@@ -243,7 +246,8 @@ void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
  * callbacks until @cb is called.
  */
 QEMU_PLUGIN_API
-void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
+void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
+                       void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization callback
diff --git a/plugins/api.c b/plugins/api.c
index 2d5fe9327f7..91c9a24a6b2 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -51,14 +51,16 @@
 
 /* Uninstall and Reset handlers */
 
-void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
+void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
+                           void *userdata)
 {
-    plugin_reset_uninstall(id, cb, false);
+    plugin_reset_uninstall(id, cb, userdata, false);
 }
 
-void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
+void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
+                       void *userdata)
 {
-    plugin_reset_uninstall(id, cb, true);
+    plugin_reset_uninstall(id, cb, userdata, true);
 }
 
 /*
diff --git a/plugins/loader.c b/plugins/loader.c
index 0dbe7bea263..0d587c344c4 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -253,7 +253,7 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info, E
          * call a full uninstall if the plugin did not yet call it.
          */
         if (!ctx->uninstalling) {
-            plugin_reset_uninstall(ctx->id, NULL, false);
+            plugin_reset_uninstall(ctx->id, NULL, NULL, false);
         }
     }
 
@@ -314,7 +314,8 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
 
 struct qemu_plugin_reset_data {
     struct qemu_plugin_ctx *ctx;
-    qemu_plugin_simple_cb_t cb;
+    qemu_plugin_udata_cb_t cb;
+    void *userdata;
     bool reset;
 };
 
@@ -338,7 +339,7 @@ static void plugin_reset_destroy__locked(struct qemu_plugin_reset_data *data)
     if (data->reset) {
         g_assert(ctx->resetting);
         if (data->cb) {
-            data->cb(ctx->id);
+            data->cb(ctx->id, data->userdata);
         }
         ctx->resetting = false;
         g_free(data);
@@ -357,7 +358,7 @@ static void plugin_reset_destroy__locked(struct qemu_plugin_reset_data *data)
     g_assert(success);
     QTAILQ_REMOVE(&plugin.ctxs, ctx, entry);
     if (data->cb) {
-        data->cb(ctx->id);
+        data->cb(ctx->id, data->userdata);
     }
     if (!g_module_close(ctx->handle)) {
         warn_report("%s: %s", __func__, g_module_error());
@@ -383,7 +384,8 @@ static void plugin_flush_destroy(CPUState *cpu, run_on_cpu_data arg)
 }
 
 void plugin_reset_uninstall(qemu_plugin_id_t id,
-                            qemu_plugin_simple_cb_t cb,
+                            qemu_plugin_udata_cb_t cb,
+                            void *userdata,
                             bool reset)
 {
     struct qemu_plugin_reset_data *data;
@@ -401,6 +403,7 @@ void plugin_reset_uninstall(qemu_plugin_id_t id,
     data = g_new(struct qemu_plugin_reset_data, 1);
     data->ctx = ctx;
     data->cb = cb;
+    data->userdata = userdata;
     data->reset = reset;
     /*
      * Only flush the code cache if the vCPUs have been created. If so,
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 9179da43851..c901016b8c1 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -76,7 +76,8 @@ void plugin_register_inline_op_on_entry(GArray **arr,
                                         uint64_t imm);
 
 void plugin_reset_uninstall(qemu_plugin_id_t id,
-                            qemu_plugin_simple_cb_t cb,
+                            qemu_plugin_udata_cb_t cb,
+                            void *userdata,
                             bool reset);
 
 void plugin_register_cb(qemu_plugin_id_t id, enum qemu_plugin_event ev,
diff --git a/tests/tcg/plugins/reset.c b/tests/tcg/plugins/reset.c
index 1be8be2a4b2..6ea675b8095 100644
--- a/tests/tcg/plugins/reset.c
+++ b/tests/tcg/plugins/reset.c
@@ -14,7 +14,7 @@ static qemu_plugin_id_t plugin_id;
 static bool was_reset;
 static bool was_uninstalled;
 
-static void after_uninstall(qemu_plugin_id_t id)
+static void after_uninstall(qemu_plugin_id_t id, void *userdata)
 {
     g_assert(was_reset && !was_uninstalled);
     qemu_plugin_outs("uninstall done\n");
@@ -24,7 +24,7 @@ static void after_uninstall(qemu_plugin_id_t id)
 static void tb_exec_after_reset(unsigned int vcpu_index, void *userdata)
 {
     g_assert(was_reset && !was_uninstalled);
-    qemu_plugin_uninstall(plugin_id, after_uninstall);
+    qemu_plugin_uninstall(plugin_id, after_uninstall, NULL);
 }
 
 static void tb_trans_after_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -34,7 +34,7 @@ static void tb_trans_after_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                                          QEMU_PLUGIN_CB_NO_REGS, NULL);
 }
 
-static void after_reset(qemu_plugin_id_t id)
+static void after_reset(qemu_plugin_id_t id, void *userdata)
 {
     g_assert(!was_reset && !was_uninstalled);
     qemu_plugin_outs("reset done\n");
@@ -45,7 +45,7 @@ static void after_reset(qemu_plugin_id_t id)
 static void tb_exec_before_reset(unsigned int vcpu_index, void *userdata)
 {
     g_assert(!was_reset && !was_uninstalled);
-    qemu_plugin_reset(plugin_id, after_reset);
+    qemu_plugin_reset(plugin_id, after_reset, NULL);
 }
 
 static void tb_trans_before_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
-- 
2.43.0


