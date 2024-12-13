Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AC9E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF8N-00033f-GH; Fri, 13 Dec 2024 18:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8G-0002nt-TK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:41 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8F-00031Z-7L
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:40 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so27059335e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132697; x=1734737497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxphwPmo3ws4n0VvyoWJoeeSK4RqOZYnTK7zd+ejDWM=;
 b=uhYL9VZJamjij+QtEgJ9KFyjDGAWo1BbThNGLg+nOY8GybQsvS8N52MU9+g2WprDA2
 Dvf2wfw4yWLX7b4WMJfU2IlFllBilEmFUxHPg6BcYMjUcVXFR2T5kRnjuikw6n4sqI6y
 nGgpvqUuqwvLS/PmrWGLCrcAIFkDqfu+YomoYnIT14y4dXz+p3zSQkByLcL5gr+wP3od
 5CgOEt9Yq8euNrKgmQtFG3R5ucHlifC3VC3hux9OwxlE3dROpAbYDfXW0Tcjj7jjnLAq
 3mxlMhXm6JoSunc7cQLW3fOrjZ0207YkXwvmwxwMajO/SCrMFxAZmUVgaR3ZwP8N1L5v
 uS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132697; x=1734737497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxphwPmo3ws4n0VvyoWJoeeSK4RqOZYnTK7zd+ejDWM=;
 b=u8hEnRmM2z1m+icY4ig7gFxQxTVjHjm2DjTRxhc0YX8XoS3Ye4Fp/1+lUMhT4b+Bxh
 hVb/GSpSFNqWWSJ2u8qEoMqmM+vI+8vt5LQGKGcmwwDS2SJ8Na7pzpSL3SFt/bBfXvEs
 arRpw5SiXEWxadM5c7Pb/vJZPe/Gp47ycbwK42fmyMwX+OUlaECjgNEm8JqHKL1pCMoV
 YhGz5U7XqT+xouEP3qsitXioIvCcPyC8QrIb+XNbwDQQmPA+plrEvHVUnMBj65c/Ptpf
 X85wjTuU9ZxUTmFc8iw7WYs4rn3x9V1ljShpSLsmu5iGErd8aXsQxYICFFqHT+EimSTf
 P/+w==
X-Gm-Message-State: AOJu0Yxrj1f9neT1QXnLDDB4RrHxREHHP2nb63HZAjdcvEDkUv2e3y4Y
 ++smE6BoSwKsWztCoWYLHx7zuc9XM3VMmZBxachfsg8Z2x1aaITOKQVedV6HbIzVjCHtgPsaSkW
 go1s=
X-Gm-Gg: ASbGnctsOYQi0WtMt0sniHlRzI2cSS8QH10JxpwII+MEhJxatdCu4E/UWq9D45ZfJQ2
 7wo5WCkX5OgKrVvoCUzGGa23uXbwHDxw4/UqXtxSTwlFwjJyPzGnFhzogwmTYVkFtpWiqMvy14i
 JXwSd30XuUISqoyvXqENEpZEhoLM4wOSgTpY+4anLwQ0hc2YnA/J8+/m428KFVN4F5+3akrEaMO
 uAncpxQGLQwEF1QsYBgcdVAFQxQ4/mJ+5ru7k/AyBQ7n/0YebkNsqcvnUMf7yjYEWVBg8915fO8
 nxjuPg==
X-Google-Smtp-Source: AGHT+IGKBZ6hFs3GXw17zJ/tbB9Ur/BQhVwWJwPC1SJrRLKyMHp5+X+2+pHY83b3KtYetVMvNxKtxw==
X-Received: by 2002:a05:6000:18c6:b0:385:fe66:9f32 with SMTP id
 ffacd0b85a97d-3888e0bfcc4mr3511109f8f.52.1734132696932; 
 Fri, 13 Dec 2024 15:31:36 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8012112sm849517f8f.11.2024.12.13.15.31.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:31:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/20] hw/nvram/fw_cfg: Skip FW_CFG_DATA_GENERATOR when no data
 to generate
Date: Sat, 14 Dec 2024 00:30:42 +0100
Message-ID: <20241213233055.39574-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Allow the FW_CFG_DATA_GENERATOR interface get_data() handler to
return NULL when there is nothing to generate. In that case
fw_cfg_add_file_from_generator() will not add any item and
return %true.

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241213133352.10915-4-philmd@linaro.org>
---
 include/hw/nvram/fw_cfg.h | 13 ++++++++-----
 hw/nvram/fw_cfg.c         |  3 ++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index fcb06f18cc3..6089681f421 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -30,8 +30,9 @@ struct FWCfgDataGeneratorClass {
      * @obj: the object implementing this interface
      * @errp: pointer to a NULL-initialized error object
      *
-     * Returns: reference to a byte array containing the data on success,
-     *          or NULL on error.
+     * Returns: A byte array containing data to add, or NULL without
+     *          @errp set if no data is required, or NULL with @errp
+     *          set on failure.
      *
      * The caller should release the reference when no longer
      * required.
@@ -298,14 +299,16 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
  * @parent: the object in which to resolve the @part
  * @errp: pointer to a NULL initialized error object
  *
- * Add a new NAMED fw_cfg item with the content generated from the
- * @part object. The data generated by the @part object is copied
- * into the data structure of the fw_cfg device.
+ * If the @part object generates content, add a new NAMED fw_cfg item with it.
+ * The data generated by the @part object is copied into the data structure of
+ * the fw_cfg device.
  * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
  * will be used; also, a new entry will be added to the file directory
  * structure residing at key value FW_CFG_FILE_DIR, containing the item name,
  * data size, and assigned selector key value.
  *
+ * If the @part object does not generate content, no fw_cfg item is added.
+ *
  * Returns: %true on success, %false on error.
  */
 bool fw_cfg_add_file_from_generator(FWCfgState *s,
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b94cd27bd85..46c62c8f09e 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1031,6 +1031,7 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
                                     Object *parent, const char *part,
                                     const char *filename, Error **errp)
 {
+    ERRP_GUARD();
     FWCfgDataGeneratorClass *klass;
     GByteArray *array;
     Object *obj;
@@ -1048,7 +1049,7 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
     }
     klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
     array = klass->get_data(obj, errp);
-    if (!array) {
+    if (*errp || !array) {
         return false;
     }
     size = array->len;
-- 
2.45.2


