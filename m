Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC06E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 13:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM5p4-0005f4-VG; Fri, 13 Dec 2024 08:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5o0-0005AW-NY
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:13 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5ny-00015W-NG
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:08 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so1162860f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 05:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734096844; x=1734701644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3yF4gTyIXghUKxGkr5yLxPBvl2lN3UWs2PgcMEYcsVo=;
 b=Qz6cua3o3GmLITMHIWaoM+dqq8LkublH2Ui8KZHaNkZOFBVG/oiJ3BVoBVeexanO0g
 o9mwRgf4s+rRjFufr+1g+xq8dVk2yci8waQm/POFqLfW8tXRFuhMtzbT31nAHLmRHvfd
 pAzY7xFwuSHqBe8VgPQC1XdpnbF6p9/6bIMkWAzC4xpM8QhMRbE/0TP53pnsLSxofAXU
 Gcxb/cEWQ3hU3q+BnU2zbaaHpWdbmxa5p0xLaxfyFO2sx9/Y7r9k4cuEX41FYKfaEyEd
 ogiksFdAwCr+WgiOge+jlEJrZjGvIXmOGQs+hv80jBQHCZ83Nczo7vPnNSLDLESfFi8b
 acww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734096844; x=1734701644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3yF4gTyIXghUKxGkr5yLxPBvl2lN3UWs2PgcMEYcsVo=;
 b=St4hgbdYdkV4D3gpPdoAbyn5lYixI5FtiqoTzdu7cU5irnm7Rk4jfTf567S51Vxmmg
 tg0WTop5xJRJONLoePecHc+yYy7wGJZSpS3+FErO/NkAP4zThiVjKd5VpqoSi+XJ++VJ
 HF4D1iBwoVZz/7dUTUspOZbEvjlq8lOWxUIkZ0efEr3mXm/otq/+EJUgSsELbgRdHYA+
 cZNBXgKr+ftSAAmix4cD6oFEKnc33oLpf2vFAU1Uf+vftRMEsGw/0HMyOIOOxb5jvibi
 yanSXirWSCCtkvws5TaQ0fmxuE9jqPnbgcgGOqStIKqBUlBxrukGIpyQ5qGNQP0yD1Sw
 CWlw==
X-Gm-Message-State: AOJu0YwNkrLRFmQ2g9GZ6gdK5kMeh0N7C2ikkoV86GKBya/fUwsW8CS7
 5hJT3L+T29P9ZdEK1OH9Waa5g+h8b49357v7hiFhRDUdKXLWxR4wNcFH4ziDpdIozStEDukxp98
 o
X-Gm-Gg: ASbGnct874FpCyxIUzEQZqf58LHCYfrf4GOP79UCkhw1vduYTngb9dsGBqvKk/9DnHU
 XMK8xlGok3ujFHK8b3pWW3rqPJfAzMxFQXIkEa1Npk7IVI0v4hKUTSiXFAkhYG/5YmW4QiKl0IL
 K4dDPPwxEQEp9hrXSed39o6G5WJokOjxHbtk9dmdOY2F/EX/NzRZd00C82Mmnap/TYCbzbB288T
 wtK9y+Zvmsmq/rZ0tVk4VQi2WWeA3/4UN5ZMZ9DuWK/kv/P6G3Msva4izeFgvC+CQoYR8tQDJKU
 Gvvugn46jA/eh2lMp7qXxHmRndfeVOLcGzgk
X-Google-Smtp-Source: AGHT+IEjTQJud7HmuB8/EGY4i4Ze6Zwa+TKzED1E3xO8dWvKlxSgYnShXY87DFpU7p00buQ80O1lxA==
X-Received: by 2002:a05:6000:491b:b0:386:3d27:b4f0 with SMTP id
 ffacd0b85a97d-38788805406mr6166037f8f.14.1734096844432; 
 Fri, 13 Dec 2024 05:34:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782521dfesm6969358f8f.107.2024.12.13.05.34.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 05:34:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/7] hw/nvram/fw_cfg: Pass QOM parent to
 fw_cfg_add_file_from_generator()
Date: Fri, 13 Dec 2024 14:33:47 +0100
Message-ID: <20241213133352.10915-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213133352.10915-1-philmd@linaro.org>
References: <20241213133352.10915-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently fw_cfg_add_file_from_generator() is restricted
to command line created objects which reside in the
'/objects' QOM container. In order to extend to other
types of containers, pass the QOM parent by argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/nvram/fw_cfg.h | 10 ++++++----
 hw/nvram/fw_cfg.c         | 11 ++++++-----
 system/vl.c               |  3 ++-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 14e68966c59..fcb06f18cc3 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -294,11 +294,12 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
  * fw_cfg_add_file_from_generator:
  * @s: fw_cfg device being modified
  * @filename: name of new fw_cfg file item
- * @gen_id: name of object implementing FW_CFG_DATA_GENERATOR interface
+ * @part: name of object implementing FW_CFG_DATA_GENERATOR interface
+ * @parent: the object in which to resolve the @part
  * @errp: pointer to a NULL initialized error object
  *
  * Add a new NAMED fw_cfg item with the content generated from the
- * @gen_id object. The data generated by the @gen_id object is copied
+ * @part object. The data generated by the @part object is copied
  * into the data structure of the fw_cfg device.
  * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
  * will be used; also, a new entry will be added to the file directory
@@ -307,8 +308,9 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
  *
  * Returns: %true on success, %false on error.
  */
-bool fw_cfg_add_file_from_generator(FWCfgState *s, const char *filename,
-                                    const char *gen_id, Error **errp);
+bool fw_cfg_add_file_from_generator(FWCfgState *s,
+                                    Object *parent, const char *part,
+                                    const char *filename, Error **errp);
 
 /**
  * fw_cfg_add_extra_pci_roots:
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index fe3b86135a7..b94cd27bd85 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1027,22 +1027,23 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
     return NULL;
 }
 
-bool fw_cfg_add_file_from_generator(FWCfgState *s, const char *filename,
-                                    const char *gen_id, Error **errp)
+bool fw_cfg_add_file_from_generator(FWCfgState *s,
+                                    Object *parent, const char *part,
+                                    const char *filename, Error **errp)
 {
     FWCfgDataGeneratorClass *klass;
     GByteArray *array;
     Object *obj;
     gsize size;
 
-    obj = object_resolve_path_component(object_get_objects_root(), gen_id);
+    obj = object_resolve_path_component(parent, part);
     if (!obj) {
-        error_setg(errp, "Cannot find object ID '%s'", gen_id);
+        error_setg(errp, "Cannot find object ID '%s'", part);
         return false;
     }
     if (!object_dynamic_cast(obj, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)) {
         error_setg(errp, "Object ID '%s' is not a '%s' subclass",
-                   gen_id, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE);
+                   part, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE);
         return false;
     }
     klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
diff --git a/system/vl.c b/system/vl.c
index f103532a9a1..4a370da624a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1184,7 +1184,8 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
         buf = g_memdup(str, size);
     } else if (nonempty_str(gen_id)) {
-        if (!fw_cfg_add_file_from_generator(fw_cfg, name, gen_id, errp)) {
+        if (!fw_cfg_add_file_from_generator(fw_cfg, object_get_objects_root(),
+                                            gen_id, name, errp)) {
             return -1;
         }
         return 0;
-- 
2.45.2


