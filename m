Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646C2EE6B69
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUAg-00067h-S2; Fri, 06 Feb 2026 17:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAd-000649-KG
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:23 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAb-0007Au-8G
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:23 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c626bd75628so841859a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770416360; x=1771021160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/nPjF8I/jK1WRoDGu+6dSuf4liZEvyFrUCZ7ZeWLxs=;
 b=hf6o/S+M6gKaTmd519kaqg61zRAIHKAFXNqzPN0NiTNiKiOoj+3VJSIOtNpyBAorrY
 DwpAmyu0CgPtXiQlfIM/x2xQfF3GzCDdHrSHewGpfhfqH16hGxDSS4uK8KkdjKR0DXIh
 vCaAtb6MHhRwgAsBisHdND0TGW0UyDUpnkDx13u4zt1d0eI17qE5f9N4eIOEJLFJwWnz
 TGOsdoJc7xnKSupjnAHQk8PvvIFtPc4vwV3sX9ysY0R5cYaqqezBSDYBSa3rWmP3VQwz
 6Av+o+wvATb2xpCxjF1481A6bM4IjA2QIO4YQAMgn3Zquh7W5eV4+5ts3RYfwKPDKJBt
 9QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770416360; x=1771021160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4/nPjF8I/jK1WRoDGu+6dSuf4liZEvyFrUCZ7ZeWLxs=;
 b=H2BJALUILxzKuZ0PseW3EAAelbFVAYP033Yq4MQUcfg9bVQ0XqSeqFS98UFTbhT5zn
 2SekpSoIaZF5oEocX3a8mQ2e7SDjGACHN1dtgIi7/T4u7aTUklMd9USirJT4ZRK0Sy3Q
 dIZwoGP1IMRd7lfso/O7ZR2CQJEQ4xOuGbc2rDzv1Blt/oCZJ/zf4G0AMXkB4jK4If/I
 PS1P2vLfgAuDTHr9zBKq0dqOksROTrhG6JzS/ToDBhBtdHTLpNa0OB5crolhK6XGAbIU
 Fn0iRp7UonJZFXZg5cscPtIB9B5WGLEqcmLKlBKz77yHwdTNTctdN34JljV5UaNIXXB3
 2hqg==
X-Gm-Message-State: AOJu0YzaRiBWzaq/Y0I3oELhjh9JiQiYm4PW9ltfLQQwOP4wzR1LPbFW
 CjP208C/VtWGEitlf319SMdd5bMQXOcLi+eKitYky4oPy47oZ6Q8/XBfCfp2AZdHa3gfrEeHffC
 CnGK0
X-Gm-Gg: AZuq6aKfvmMPAaUJ7ovr2LhpCOfBeO9IAS3Hqgy/eeqb8u9742vo1VuSwU8mOW88x1v
 CWJvjYW1S/5pN9V/qwYdpEfw4/ZZ+qNABt1xnz71QyBCcuRXYm6v0F3qF/obetNQ0gcJi4ffIn4
 eHuFhIud2AVuE56EaATID5pzX/ZerE4irIu4B+BXxSXB2uETKH1agMBJ+1hQX4GDiUkYpuqxNjc
 CRnnT4QxJCqFrcRzcuzATtXaxWURTbwEGfWRPCmDq1DNqDlid7RD0/SOhR2XWmH20I10KQwlLu2
 LcwPGZ/9H5vcHLUVZS9ceGtPCYhYkeXKJXoCMx5oQZ7TrxJpKzdYNt7/8dIKnsj4cCHogtskrqi
 gD/fbB0iKO3wZP8OTnUjG3syZjwbEsfMNs+cg/bEE09OZ+8Ol+iDyeH0wBXxulM+nHOchk+S+ni
 5kVmvO4NfSgOgIJmLBlq8KIuPRWxFoPSHZQLYYLXicxp9iZu6ycAYdMl65DEOJESWy
X-Received: by 2002:a17:902:e541:b0:2a0:d629:903f with SMTP id
 d9443c01a7336-2a951607922mr39370405ad.9.1770416359667; 
 Fri, 06 Feb 2026 14:19:19 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95bff42f7sm13316575ad.68.2026.02.06.14.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 14:19:19 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, stefanha@redhat.com,
 richard.henderson@linaro.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 5/9] include/hw/virtio/virtio-access.h: simplify
 virtio_access_is_big_endian
Date: Fri,  6 Feb 2026 14:19:04 -0800
Message-ID: <20260206221908.1451528-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

virtio_is_big_endian already checks for VIRTIO_F_VERSION_1 feature, so
this is redundant with big_endian_code.
Also, clarify why we explicitly check for ppc64 and arm arch.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio-access.h | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 1bea3445979..9aed3d1da4f 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -22,21 +22,16 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
+static inline bool legacy_virtio_is_biendian(void)
+{
+    return target_ppc64() || target_base_arm();
+}
+
 static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 {
-    if (target_ppc64() || target_base_arm()) {
+    if (target_big_endian() || legacy_virtio_is_biendian()) {
         return virtio_is_big_endian(vdev);
     }
-
-    if (target_big_endian()) {
-        if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-            /* Devices conforming to VIRTIO 1.0 or later are always LE. */
-            return false;
-        } else {
-            return true;
-        }
-    }
-
     return false;
 }
 
-- 
2.47.3


