Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A92FA3751
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn0W-0006lM-TD; Fri, 02 Jan 2026 16:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzi-0006fv-7Y
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:44 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzg-0000JT-Cz
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:37 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7f216280242so76491b3a.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390454; x=1767995254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sa5EHxYx/snq7aAH+sWySlzd4bZ6Z+JvqzA3ZIoZGIo=;
 b=A3fP+HcNx6kXh0fd7UREWdV5/vq1V91V/ixNW/FLxBiSYW8l/ab4ycLlccayPOaQCY
 gdO5OUPtSDR3BVGMppSHrFWKT/5Zu7e/HzNxsYBr7+XKm/O+FT7Ru1LOA8xm+iiW8wrf
 R4/hzZNwaUWVUvqrUJVpgF7t2fIyOgWqvmAFoajxWzhX3WSfiosszlUXNOxek5D1STSk
 Y0eDcDdHSfLu4wzYU2tDXEVB00q/tHFgPAzCKr63Z2svhdH26sIjm6JgVbf3JsLMAPDO
 FpAXGMflSzKOuCRxhI6/RrEB3tOlfXx2z+set4zPU83W5/Ofc3sHPvHXpJrxB4BrZy7v
 ZR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390454; x=1767995254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sa5EHxYx/snq7aAH+sWySlzd4bZ6Z+JvqzA3ZIoZGIo=;
 b=sjmo0ygtPpf7VojGD9N+F9V/moSc8sPd7VuPzbJsjBSvC6kv8nJbUTZbVVy3cOPryj
 PGmjdw2QG6gT2GxGa6efaOZNdzVP16uKEB0HvHL/suN5j9hYOnf1BJe9ZF/RsVa89Qt5
 bTPTGyMuWq7p/mb4Ck8vTUeEwEh53JJHB9bmIA+cIYCrFFgaMa+HSKYtCzbW/1AY3MpU
 yX9iKxgpD4obVMvR9tNCbMQ0dj3h11zE9sG6JtN38eZdhj98hhadPF6065cuXE11r420
 kZgGHX76XPtt4Hx88J+vnInaxGjdmXSCyNIwPxAEnBb1gFr5A/H+BVW2icGeb9unhjRD
 i+Jw==
X-Gm-Message-State: AOJu0YwXQHBYFGUpx3kllCRO8C+MQnDD49XYHpLWeVaRT4XE8cCnbp6n
 UuAU9iXQblxsBgK0q6UtWfhsQfax+RdUMnlh3TEvhcfrx6uRLWLG81GQXA0/r5qZ2s6N0S5lxe5
 ShGP1nnQ=
X-Gm-Gg: AY/fxX56RsU5IalyvyibJjJVGTUiYXQMQ7NYWaao4HtNzUjcMdEpc8xTlgG0LA4fAIQ
 AVfXObXDz7fRF+1THTO3QXcl7juxd4OB8SGLnJiKzaRdDQF47HFshdrJPb/eZKh0z6cClfdFwfj
 fgUpLqZopPGR1oBYa0oaGxgFoIjMnP3M9f102ykvGP1OsZGZkbcagoDYtMYRCty1aHatiTH9MBq
 IqR0mrv4lyCxuGtFIuaataaQIyjMHAesUpNvDTUwssrIYOyvcUuRt+q7kJwF2Sffb6qvc/FSWRF
 tSDeLssZVq5jsosFcl16ndEMbtfejyc8pahBK2IBMo924QeoPU4VNvGGWiq7aStuzzdaTKvALtV
 xygHpnA/VJoVclj42vG6N/8OcHWy7fnp5IRrXmaj8uVRew3Rfa3DPcZ91jcJBk0/CqvwtGYJxMe
 H+yE4KAWfaAbTtUowKDu92zAo7o4PDn9pTK+OCxPOEWf7XPFna4FxY0M5caVyCgjgmalHXKxw3Y
 VA=
X-Google-Smtp-Source: AGHT+IGWyC3T2PlBAqYpm0UMco2ajzJrYxA8O6X+AksTPDdjR6HfzNZqlYNe5MqV/AjpLJKWsd2aow==
X-Received: by 2002:a05:6a20:258f:b0:2b9:6b0b:66be with SMTP id
 adf61e73a8af0-38959351d03mr777455637.14.1767390453989; 
 Fri, 02 Jan 2026 13:47:33 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476f8f3fsm62925a91.5.2026.01.02.13.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:47:33 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 04/11] plugins: define plugin API symbols as extern "C"
 when compiling in C++
Date: Fri,  2 Jan 2026 13:47:17 -0800
Message-ID: <20260102214724.4128196-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x443.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 60de4fdd3fa..e44f863d839 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -16,6 +16,10 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 /*
  * For best performance, build the plugin with -fvisibility=hidden so that
  * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
@@ -1210,4 +1214,8 @@ void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
 QEMU_PLUGIN_API
 uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry);
 
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
 #endif /* QEMU_QEMU_PLUGIN_H */
-- 
2.47.3


