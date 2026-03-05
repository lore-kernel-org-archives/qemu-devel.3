Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A01F47CD4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFgB-0006c8-EN; Thu, 05 Mar 2026 15:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg7-0006Zk-EY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:16 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg4-00066l-D5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:15 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-89a06bc2f1bso70189586d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743930; x=1773348730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhU2H5Lji7UkbAGIzyPPNScbnVNC1zzUf1PUJSajVNo=;
 b=XXzIEbis/XwGnCGnAXhQ4UMePfq6E+Afq104B2FajxotlgbBPzZSjfeB37+cK0RVdv
 s0TWyKDq0TD4HWDcAhMfp9SpKPr15JDTjd7EfKwkBLmtZ5SIFISCIRtH47YZ09gt7pIR
 PbvYqSWM3Yxjm0dwXR8B+dH3H4o02ces+HHVFTd98aKHtkqtPix4/8rbJrFFaki2hTnK
 UdjF1LlJZy/7QS4i2G+vihf7/uotFSXC0ncZHJAwtbv7Cd4zsAWyMqf2CJsvt0xBi0WF
 k26+RK5JEmv4bIfBnNNIhmJRq42oulhWpvFb3Lc0i8m0SeY6M9iKf28QEzyVv6HNBRvz
 Jwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743930; x=1773348730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jhU2H5Lji7UkbAGIzyPPNScbnVNC1zzUf1PUJSajVNo=;
 b=XqQ+sF5uDWmshlPkE3wpX/tXkKeT2DHTEyoHycGwfMkoi13pjTLfpQ5aLwDVno6U3Z
 ig6ZtAbLqYrw+1OfOB9pox3Ej0zsFfPfTq/0pqokOvBXiwwW6y/JrZb4JVuYRSwxPl7F
 d1EqFl9ll8L+VAw9qk0yedSZcbKg8T/PV9QB4WuQjsVRHQAWy/5lCfKTMiMKLjbDFzWW
 G+VlmJ+IJtrGkdiP4NCOnUicMKE6EhsiRjxOrv33nhZL1ViiZMee2EjW5dD8SbOTZY7a
 BtM4BB6g4QLpbWzQAbb9eAvADoDToLoPr59aC34vTcneknHX/lqa1jf+WqtPdgzL8vDu
 IAsw==
X-Gm-Message-State: AOJu0Yz9UNMmOLSq94AxwcDrZt5OTR5mPLTWR7n/W71RzxALCAM9UGLv
 oIFsK0zrdnyqQidlp8XVTda5IinDeRvGsSuwR4OJBgiHENWiibPts5mC4r6Y0sIRvh+yKmBiRQu
 5L969
X-Gm-Gg: ATEYQzyQkM2HQbJU57ohEUUmWtfoGOMFtXMV9BlDIPgVbRRoweKN6bEuAZnhpm5AZUq
 Kj1xoTVit4vERMsBU1PxbJkpsuTwrU88XlJqzUqo96mumFnvYGqc2yhGTJO8kWkrAeyFyWrAK+R
 53sW/WV8BxfQ40vEQ9MimUOcXiXFGqYoEQ2GqzmK4qiEfZy+0KqPdF25nu+6wN1q5bcf8SSu88y
 YQkQsMOfOBlJEgOhexFmfvz5w44N6lWAV5lx9NPiSqlC9+TiOjDBh+WTrnvTrTkCE/RtGewysgT
 CNZvrGaLmG9yveWncXueLz5+2V1PHfr9huRo5wsWKU9yWBz20zd/YFusC5s2CYxq4kPWFeCV0Rw
 nrVAqs0yBQNi2BozEty/jNLlAMoGD83h9DEAZauyFhFhoi0vFey5rK2GZwgqWdakCZnuBocsO/X
 uAJtKlGWyif1cZsEmYmKYgHWZEzDkhjrGjPpBC4ntruyP0JYDsaXE+Z8TQIXHmHwqs/Gs1cUAVx
 Tbk
X-Received: by 2002:a05:6214:2585:b0:899:eba1:3c0b with SMTP id
 6a1803df08f44-89a19af3ac2mr104706976d6.33.1772743930182; 
 Thu, 05 Mar 2026 12:52:10 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 06/12] plugins: add read-only property for registers
Date: Thu,  5 Mar 2026 12:51:46 -0800
Message-ID: <20260305205152.2121854-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Florian Hofhammer <florian.hofhammer@epfl.ch>

Some registers should be marked as read-only from a plugin API
perspective, as writing to them via qemu_plugin_write_register has no
effect. This includes the program counter, and we expose this fact to
the plugins with this patch.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
Link: https://lore.kernel.org/qemu-devel/20260305-setpc-v5-v7-6-4c3adba52403@epfl.ch
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/plugins/qemu-plugin.h |  3 +++
 plugins/api.c                 | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 7b9cd6a9717..fceb8194eb8 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -979,11 +979,14 @@ struct qemu_plugin_register;
  *          writing value with qemu_plugin_write_register
  * @name: register name
  * @feature: optional feature descriptor, can be NULL
+ * @is_readonly: true if the register cannot be written via
+ *               qemu_plugin_write_register
  */
 typedef struct {
     struct qemu_plugin_register *handle;
     const char *name;
     const char *feature;
+    bool is_readonly;
 } qemu_plugin_reg_descriptor;
 
 /**
diff --git a/plugins/api.c b/plugins/api.c
index 23c291f6444..85b34949cbb 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -410,6 +410,12 @@ bool qemu_plugin_bool_parse(const char *name, const char *value, bool *ret)
  * ancillary data the plugin might find useful.
  */
 
+static const char pc_str[] = "pc"; /* generic name for program counter */
+static const char eip_str[] = "eip"; /* x86-specific name for PC */
+static const char rip_str[] = "rip"; /* x86_64-specific name for PC */
+static const char pswa_str[] = "pswa"; /* s390x-specific name for PC */
+static const char iaoq_str[] = "iaoq"; /* HP/PA-specific name for PC */
+static const char rpc_str[] = "rpc"; /* microblaze-specific name for PC */
 static GArray *create_register_handles(GArray *gdbstub_regs)
 {
     GArray *find_data = g_array_new(true, true,
@@ -427,6 +433,16 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
         /* Create a record for the plugin */
         desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
+        desc.is_readonly = false;
+        if (g_strcmp0(desc.name, pc_str) == 0
+            || g_strcmp0(desc.name, eip_str) == 0
+            || g_strcmp0(desc.name, rip_str) == 0
+            || g_strcmp0(desc.name, pswa_str) == 0
+            || g_strcmp0(desc.name, iaoq_str) == 0
+            || g_strcmp0(desc.name, rpc_str) == 0
+           ) {
+            desc.is_readonly = true;
+        }
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
     }
-- 
2.47.3


