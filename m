Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C34CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTiw-0006Js-0Q; Thu, 28 May 2026 01:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wSTiu-0006JC-N1
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:56:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wSTip-0004f5-Sx
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:56:02 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8353fd1cb5fso6289282b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779947758; x=1780552558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2PUBTnl7NO+GZMfRvUslTvPkHKEc8GZDQXDvKmhtZI=;
 b=WblairuqvRXQJR4LLtKMaPDap7bZIaFVi1fblbp99ZwVM1Yx827aqOU5xZR1YGWI5j
 dsTwvGUsmqEdOx7PZnLbgjccK1OSyQC+Rb+UL5kVtdeS5Dw87hkMwvtFkMMwzBbAIs9f
 eFlRhUtUp59382kw77E+WhH9mYk9kzr7PqozoBi5qh8GG5jgBCOgvYPkz4L8qgyx8jKj
 cY5b/lC14Z+8fYr0qwpitXGYPNOsaW0r6RRPI5vhWjPf/UXxWisPAqtgeB9HXsKeoi35
 tFX2grt42kEXohpWRKzRMzuP71bc6xmeNyymv9aLTmSpUFwHJh7T6wEluqGhR6kO+JRN
 HPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779947758; x=1780552558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W2PUBTnl7NO+GZMfRvUslTvPkHKEc8GZDQXDvKmhtZI=;
 b=pXQjPQ1bdBS7q1VIGIEo1zhku//84SdicliZpSiI4NslDNkH7332QOlCNiywKuCgLY
 bOC+QAL6u/zVQvdbOf6kiGthRXbbg9xdoiiPD1Zsxekmvmvx2RyQM4vlMvmljov5pqj5
 bB+v9t0XrA47kwIChAg/OapncwL9hDAOK5NkylSigD3fJcYPpV2UIAoNr5BcbaD8fSc3
 MsdMw0Lz/AMV83puyeSljpDuTGG92TJ/gGRtjXg1YopbyqPJ1x42Vm/oFkfB9BHsNM3d
 GVd54TYqQfkPQSD1ZDDn8sIgcYPx84GTqQuRnLda1LpCalpWDmLTQ/BkdvuRHN/lh58N
 uNzg==
X-Gm-Message-State: AOJu0YyJrhv3EYSEcgaW7TL0bOlWCHI4oqCKb7kUsq8AWcngj+g2fvTk
 9NWzthxA+KY/G6Sy1yFRovuTeZPqhTaPqjFiwDcrdonVIVX+UyFywo2moDQjx2nck9Q=
X-Gm-Gg: Acq92OHaVl6kGbsIxURuSts08vvBjotEExWWmwa4l2UGDB3YjskHBNPXa+EfDGs5TWw
 Q3y3gevUx3n4sHmPXFKGn6ey5Fgv5IfuYQsbILUV0CKVeSyFxGgRqS0E8rzlVd1x7deWFwXkE7K
 8WNlF199UncdOg1uLcgTiL9bCE86Wroz8bPaNBjNYTOK7z4OVKPPn+bAvuhZVP+6zGLaqdUQS0C
 C6gponjlqhWUovqH6yjuxVov7R7yvedErA8ETphNxvViQ4WsaJfEvPklbeAEnYwUnEKF5BXuEKC
 OcAFgUfw81atOV0CVV5gWHC4yANH+m1aQA1YKhE/sfVY4ABHZI2rs1aZBNKZ6IrbAeyX16mWHbg
 9WLxJ+hxltnVq9t31mUVDzkp1NkG3Zw/k53jq1e8shxSk17Momr+580+fMXdSj9f10HIV6MKZds
 S/pCWYnLgm8yLlYIuvnZJuGR0rpXJoC4Cgl1k=
X-Received: by 2002:a05:6a00:9283:b0:827:33cb:c7a3 with SMTP id
 d2e1a72fcca58-841fda94381mr209905b3a.10.1779947758395; 
 Wed, 27 May 2026 22:55:58 -0700 (PDT)
Received: from gmail.com ([114.249.134.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841f3cbce48sm758068b3a.10.2026.05.27.22.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:55:58 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-cxl@vger.kernel.org
Subject: [PATCH v3 1/2] hw/cxl: factor Set Feature write bounds helper
Date: Thu, 28 May 2026 13:55:24 +0800
Message-Id: <a8f1eedc2173fd98e244048a2eccf00e1af460c1.1779946245.git.physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779946245.git.physicalmtea@gmail.com>
References: <20260429152750.2409174-1-physicalmtea@gmail.com>
 <cover.1779946245.git.physicalmtea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=physicalmtea@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

c1c4d6b38b13 added the same offset + length validation twice in
cmd_features_set_feature(), once for patrol scrub and once for ECS.

Factor that logic into a small helper so later patches can reuse the
same check for the other Set Feature write-attribute branches.

No functional change intended.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c | 40 ++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8ba7e8625..2e4cc5824d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1702,6 +1702,21 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cxl_set_feature_copy(void *write_attrs,
+                                       size_t write_attrs_size,
+                                       uint16_t offset,
+                                       const void *payload,
+                                       uint16_t bytes_to_copy)
+{
+    if ((uint32_t)offset + bytes_to_copy > write_attrs_size) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    memcpy((uint8_t *)write_attrs + offset, payload, bytes_to_copy);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
 static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            uint8_t *payload_in,
@@ -1713,6 +1728,7 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
     CXLSetFeatureInfo *set_feat_info;
     uint16_t bytes_to_copy = 0;
+    CXLRetCode ret;
     uint8_t data_transfer_flag;
     CXLType3Dev *ct3d;
     uint16_t count;
@@ -1760,13 +1776,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        if ((uint32_t)hdr->offset + bytes_to_copy >
-            sizeof(ct3d->patrol_scrub_wr_attrs)) {
-            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        ret = cxl_set_feature_copy(&ct3d->patrol_scrub_wr_attrs,
+                                   sizeof(ct3d->patrol_scrub_wr_attrs),
+                                   hdr->offset, ps_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
         }
-        memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
-               ps_write_attrs,
-               bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1787,13 +1803,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        if ((uint32_t)hdr->offset + bytes_to_copy >
-            sizeof(ct3d->ecs_wr_attrs)) {
-            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        ret = cxl_set_feature_copy(&ct3d->ecs_wr_attrs,
+                                   sizeof(ct3d->ecs_wr_attrs),
+                                   hdr->offset, ecs_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
         }
-        memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
-               ecs_write_attrs,
-               bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
-- 
2.34.1


