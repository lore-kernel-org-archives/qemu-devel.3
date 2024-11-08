Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98307D64073
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9SwZ-0003th-6D; Fri, 08 Nov 2024 12:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwX-0003rL-MO
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwW-0007aS-6o
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOuaO0FdvnRx8m0yCTGELCVtD8jtIom4riAwRaaG5gI=;
 b=b0MQtUWJ/0ftQAFeou7C0wPU1GWoaNv+dAlE70JBuPKIqaQsvaAPvZqFccb6Qd3850mu67
 3eXLCeK2/aqnrfLbl7aKxOlEo3kqZKk7juegqeWfVLfN8MxhTmH/BfRc0Cwiu5bmsXnlI9
 PIMWQQxZsb5775kAwzSwAX9KQYzsDk4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-oR9gy0dnMOyUxBW2a7O00w-1; Fri, 08 Nov 2024 12:38:42 -0500
X-MC-Unique: oR9gy0dnMOyUxBW2a7O00w-1
X-Mimecast-MFC-AGG-ID: oR9gy0dnMOyUxBW2a7O00w
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539e13b8143so2979650e87.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087520; x=1731692320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOuaO0FdvnRx8m0yCTGELCVtD8jtIom4riAwRaaG5gI=;
 b=gfWcpeSA9hOMJNplXUgjWuBSI4fm5hA3N9/7Noi8JdwIAe43OlyqQDlg+vzSYkzvci
 6vbYVbwWzkZ/mryigJdJ0bbJ139dmVbfW6DN+Uum3ruRFGiaolJD1xFiMub9l4dEmg9/
 QdZaaBLwf2vNpGFoWM/k1x4q2xEzEPBvqdVHrgM5x3kVTIT07WcDfpLnbePiMMA6N7Ka
 2//3yce4WWb046fU/s6pG60hDGSoxYGpbNiSz0J22y7GpkKILvpsMDPbleCKQ+6qd991
 ZipQyvOQ5KsICN8JrC2jA+5t10KpAq5eJ9bYZ/aJ8Gyp/zVwUqUD7SJDmoGjS2hzVKzu
 JkdQ==
X-Gm-Message-State: AOJu0YwvXBzOzRoa9pHWAvdWIllTWtkQASBoN2Oe4uvRGmOiBZNZMvEK
 izMRJ1Vdflxjax6pmqveNFjZvOj2mRi+ZbUaZ0xdqtk2T5SxMAG18Z6PUAS+lepD3JUOMRFLszr
 AnHZ75CFSb+RmSzsD36Rc7nqFRCDSz5px/P9z5ZiUHWyAaeAY0sht27jMBml53/Pf0tunUl/bsD
 IqaJR3Mf5UiLMOWOhOErOqKZAo7pie6r9gFCXGY6c=
X-Received: by 2002:a05:6512:3f11:b0:539:ec87:bc7f with SMTP id
 2adb3069b0e04-53d86231c05mr2301740e87.19.1731087520101; 
 Fri, 08 Nov 2024 09:38:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEURCbPWZePcBUxBqf+BhJAXgcO4dIpMQe7YfMvJTTFIa9Fkc6VU4CzzjhFrfmbltHyPivQ2g==
X-Received: by 2002:a05:6512:3f11:b0:539:ec87:bc7f with SMTP id
 2adb3069b0e04-53d86231c05mr2301721e87.19.1731087519625; 
 Fri, 08 Nov 2024 09:38:39 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05c1f56sm75960955e9.34.2024.11.08.09.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PULL 05/13] eif: cope with huge section offsets
Date: Fri,  8 Nov 2024 18:38:20 +0100
Message-ID: <20241108173828.111454-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
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


