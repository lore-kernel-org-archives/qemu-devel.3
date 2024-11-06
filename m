Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF694D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8k3V-0003BF-33; Wed, 06 Nov 2024 12:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8k3T-0003B5-2h
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:42:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8k3P-0006QX-7M
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730914969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mBsx0rsy+/jhtfc6pdSbD0STqvK4hr0OKKVjpDbFNmk=;
 b=d58WKbMtE+vcM7ZEtz7VRMX9xx4nlT57sfr3F16jpyMV77h9CX+OKe73W4Fgw0W4peZWwV
 6bk3ZuBOBIFsDOW+PJnNEq9FOu1tDdCzrKbUGpxYIW1jfLHRvlJr+kysvN2Q/VLZWLLECy
 YyJKaaX+a9+7ZuuUddE4T6B7sM+WFTc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-Q5cwb7-sMDKqaCc64zONgw-1; Wed, 06 Nov 2024 12:42:47 -0500
X-MC-Unique: Q5cwb7-sMDKqaCc64zONgw-1
X-Mimecast-MFC-AGG-ID: Q5cwb7-sMDKqaCc64zONgw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so716692f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730914964; x=1731519764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mBsx0rsy+/jhtfc6pdSbD0STqvK4hr0OKKVjpDbFNmk=;
 b=ahCZmMiD9TkMMTeD4Wg/5hlqR4x6wVBqyMeFmJEIN5UTehJFe5dJeQGq/+bnIwTEGR
 CL1EAMBuu1qds2b7A4TLmPwXKbc+PvHRDnSdT1HNaD7N69sgaXMq75Tezivs46JUnTYd
 Ks8fLtNa/XKgLBNE0bQGlZy/RYjhGk6iXPl4F8zPEyaGrlZsopFggVmRmGMbbtpwBOmR
 aojxkR2hQajStBgAsa39T9ZTodbwpMLtP5t1j4360JqPS8AB/iXttRqFSWiCs9eyj8Q/
 CBGD0S/+a4a4oTd726Uz6yCO4wEfZFqCoaYp0VlcNVb1a5iZhegchq+tgOwMlHZpJcyN
 axqQ==
X-Gm-Message-State: AOJu0YyrEemWR1RrM4PdNLh4/pB81Per9cnWBmzZ3CNf3fCorboclbep
 1RITD5TyZwGkgmWaunWV094+/FcJ0c4OGqYRNia7hqk2nUO6VLSWimQJXCzhTbRFGwkNgtrc7JV
 5RG27J/cJ6Yt2aPopqC0ezlW8WuD6lAaBdKYmtjgfupFhKYMPCqgy05gTQYFvvcscupGEtpVP/z
 FgFmDdQ5utvUVN1PM4yw2vLmy54JiG/Ep89q/vfLU=
X-Received: by 2002:a5d:6da9:0:b0:37c:fbb7:5082 with SMTP id
 ffacd0b85a97d-381ec60b96bmr52090f8f.25.1730914963822; 
 Wed, 06 Nov 2024 09:42:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCSMmvgbvTn2erOK67NfSSDU4gq4TgViEH6q7LvULcPD+c97y3UGBnW/CdDUDi45zVC0b1qg==
X-Received: by 2002:a5d:6da9:0:b0:37c:fbb7:5082 with SMTP id
 ffacd0b85a97d-381ec60b96bmr52069f8f.25.1730914963446; 
 Wed, 06 Nov 2024 09:42:43 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7392sm19702728f8f.55.2024.11.06.09.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 09:42:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dorjoychy111@gmail.com
Subject: [PATCH] eif: cope with huge section offsets
Date: Wed,  6 Nov 2024 18:42:41 +0100
Message-ID: <20241106174241.556373-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 7f3b2edc9a7..cbcd80de58b 100644
--- a/hw/core/eif.c
+++ b/hw/core/eif.c
@@ -115,6 +115,10 @@ static bool read_eif_header(FILE *f, EifHeader *header, uint32_t *crc,
 
     for (int i = 0; i < MAX_SECTIONS; ++i) {
         header->section_offsets[i] = be64_to_cpu(header->section_offsets[i]);
+        if (header->section_offsets[i] > OFF_MAX) {
+            error_setg(errp, "Invalid EIF image. Section offset out of bounds");
+            return false;
+        }
     }
 
     for (int i = 0; i < MAX_SECTIONS; ++i) {
-- 
2.47.0


