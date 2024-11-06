Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CBBD59F5B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kVw-0006Jb-N1; Wed, 06 Nov 2024 13:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8kVv-0006JN-Q3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:12:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8kVu-00085A-2E
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730916736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OOuaO0FdvnRx8m0yCTGELCVtD8jtIom4riAwRaaG5gI=;
 b=V3NbT9b2GsF9tW0HSPYGu++7ndmnRcjhRIB1uEyU7fQtELAyfL6ux6PvQoeLFQLC4QxaD3
 m2ffEx69TN7dSmxZV6/BqVXDmBqiFuotpoSwC0hg4K96YJZ2xkPeps7VjmWPHpl8G1X27o
 4Ts4Q99jXYelX4HMx9E/QKTJhStUjNk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-lX7jz8IpOqG-jhs4Zodc1w-1; Wed, 06 Nov 2024 13:12:15 -0500
X-MC-Unique: lX7jz8IpOqG-jhs4Zodc1w-1
X-Mimecast-MFC-AGG-ID: lX7jz8IpOqG-jhs4Zodc1w
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315cefda02so760095e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730916734; x=1731521534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OOuaO0FdvnRx8m0yCTGELCVtD8jtIom4riAwRaaG5gI=;
 b=ODVPWmMCwi2IrgCzS9FYNP42OI0qjNHcjCSL7C6obTFqcsgHEzrrwGnPKA1XjFgMQb
 19J4D9Maz7lTfeV7j+cQRGWSsKQJf+cfwV0WO9C326L0/NStHj5h3wbYniiIu1wFuUCD
 sZ61wAE0fS9VvJDsGhIr5wxAufeD8KlPhGVAMxlUMjpFXlnZcu5OUshId1nnMh3FWYRT
 pWnTKcsaxqfUNPtap/pX5zImHanx88j4Euy7yNZdQ0Fk52mwllakiegxh/fJe1Y3R1/q
 lYnAzSShUl9p7YjgXHUOBXWPXCT93waOV/iBE5RfgH8ufF4pMvN/mNnVsgJz+/yAPFJg
 jk1A==
X-Gm-Message-State: AOJu0Ywm/uMxpEW8Q6xdA2ycDv4yHlHhd0HQcYIqaZvyYSbFQwAL8c/L
 f9NL3pFsy8m8hoaqyL76JUIuV0XO9Mk+vKmJbxkEYG8TcDJ7h8rIof4WmFSUmgIugsIPg8UkH8o
 ebUqG+rfrO4f5jESODuUCwtxYPs7GC68S6k6lFv/0rm0521xCyuZMmJJfollKr3twcsDiWnOLtl
 YGPzNvUg2l5KDnzW0g7r4Cz5qetszcf+9TGEx8QXg=
X-Received: by 2002:a05:600c:4f04:b0:42c:acb0:dda5 with SMTP id
 5b1f17b1804b1-4327b6f9574mr211921275e9.1.1730916734011; 
 Wed, 06 Nov 2024 10:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIb6ja5Lux+H7hHmYiaXag3lSFCwvfBe/dXrcv5/+egTyfvEQ9Jmxp2XIBCPZGoBp76QcHzA==
X-Received: by 2002:a05:600c:4f04:b0:42c:acb0:dda5 with SMTP id
 5b1f17b1804b1-4327b6f9574mr211921015e9.1.1730916733551; 
 Wed, 06 Nov 2024 10:12:13 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6bee9asm34130755e9.19.2024.11.06.10.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 10:12:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PATCH v2] eif: cope with huge section offsets
Date: Wed,  6 Nov 2024 19:12:11 +0100
Message-ID: <20241106181211.568775-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Check for overflow to avoid that fseek() receives a sign-extended value.

Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/osdep.h | 4 ++++
 hw/core/eif.c        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index fe7c3c5f673..fdff07fd992 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -297,6 +297,10 @@ void QEMU_ERROR("code path is reachable")
 #error building with G_DISABLE_ASSERT is not supported
 #endif
 
+#ifndef OFF_MAX
+#define OFF_MAX (sizeof (off_t) == 8 ? INT64_MAX : INT32_MAX)
+#endif
+
 #ifndef O_LARGEFILE
 #define O_LARGEFILE 0
 #endif
diff --git a/hw/core/eif.c b/hw/core/eif.c
index 7f3b2edc9a7..61329aacfe1 100644
--- a/hw/core/eif.c
+++ b/hw/core/eif.c
@@ -466,6 +466,10 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
         EifSectionHeader hdr;
         uint16_t section_type;
 
+        if (eif_header.section_offsets[i] > OFF_MAX) {
+            error_setg(errp, "Invalid EIF image. Section offset out of bounds");
+            goto cleanup;
+        }
         if (fseek(f, eif_header.section_offsets[i], SEEK_SET) != 0) {
             error_setg_errno(errp, errno, "Failed to offset to %" PRIu64 " in EIF file",
                              eif_header.section_offsets[i]);
-- 
2.47.0


