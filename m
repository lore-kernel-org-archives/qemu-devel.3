Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83955C369D9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 08:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mU-00086T-K2; Sat, 03 May 2025 03:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mR-00085v-2s
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mO-0006f8-U9
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWhLgJNS8Ltljm8m4k2fCDLslDrL+mClIW8l8kOMkf4=;
 b=TTXxGG+ltVu42qeE0AHTHXzvvkgBRUT3JajxrMrZlVFe57JOCc2g4vrA1N+sbSlssZWoL/
 r06YynW6eyWubvPYcvzRymt9GmATwKMuh22Xs4+nNeFK2MjHCV6hob3wq0yn2Yf5QcZ6g+
 0JK9sAe6b7Fr0gOSSpkhmnkk23QUeX4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-H81SP1aaOeaiAo1pYJnYBg-1; Sat, 03 May 2025 03:59:22 -0400
X-MC-Unique: H81SP1aaOeaiAo1pYJnYBg-1
X-Mimecast-MFC-AGG-ID: H81SP1aaOeaiAo1pYJnYBg_1746259161
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a07a7b4298so1327765f8f.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259160; x=1746863960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWhLgJNS8Ltljm8m4k2fCDLslDrL+mClIW8l8kOMkf4=;
 b=FcmxKRHqApGAGGl4oj49Sc3Cs5btPIw7UV3QNzMn3gdijQX2YygeJjAcre2NRU2UQB
 oN1cGy6TPpP5WObt+0eNaVRUUetR5nSFCmyYMnIX9VO7yZt8DCnFwrvsPKUi6l58oLS7
 ttsdXadzzHFduYjpNSX2zzGUVdiPjSWtuI8cvH3GulgFMUdmrH9iTPskPS8sjJDZ/4JX
 zZymtFKeraxNbhWvM7cLM6yIxwYa4aeACmmDqfK9rDRQl9Fg1vBCcYQ7XV/fsqNQ9EMW
 QZApxpSDFifCybDBiYrGq0sNmY9wiFj/tlBKXmktLaU7WmaBPpDy/YltrZw73uk7IxQy
 sbhw==
X-Gm-Message-State: AOJu0YzqddPPA2ysQ23qrE2G6dWJDnjG7X0sBZDw6/TI9sPbzF8/5mVY
 2SS29SEy4+wM46KBrjEXGgyZH7Q63zXJJrz98TiHoxO6KfZDt03M1C8N9ntt8oHY884bxGmZzYp
 c4vvxCw7WIcG01xzMlaNPCz1Y7aNsVaa0OSJonNAiCwvljwGNm+VlK5AHVtDGirHWl2WlW65SON
 QQvO+W325/zBw6JpCkAgH8lmqLZTujGwzlzI6g
X-Gm-Gg: ASbGncupCwggsXbqbxQgBZ2FzC2q+bR9vPrxRRnn5BrLw8Sfr+S2InfutUNY/85eepS
 eikQkJW3VDX429m68ypswbkWSveCwNgSLiAf8ZQASObwMTaDdHIHrJHbBX/iqEktLLyiy2loV1W
 ZkeW4llraPQWFC5l9FZFs8t4AqX7neunfZA80oo2TkKLxc++aDY+qnpYbvbvmfaxQRvHU6yvZHM
 1z9rgHuBINRpOYqpnRpMeNYMIyrsDRrJSOesfEa3kNs0GplomYsiLQxIA320fquM5bSNdW7DjCw
 m+LNOUnTA2HYuyU=
X-Received: by 2002:a05:6000:188d:b0:3a0:8c55:26f5 with SMTP id
 ffacd0b85a97d-3a09ceba247mr1352817f8f.31.1746259159959; 
 Sat, 03 May 2025 00:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAewj6qPT0jZ5BaNdWRAnm5D+jk3NqUkK+OsfI9EAn917SjWxUXmwBrrL3EV5cYpUcHjs4IA==
X-Received: by 2002:a05:6000:188d:b0:3a0:8c55:26f5 with SMTP id
 ffacd0b85a97d-3a09ceba247mr1352798f8f.31.1746259159472; 
 Sat, 03 May 2025 00:59:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0c25sm4228350f8f.17.2025.05.03.00.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 07/13] target/i386/emulate: remove rflags leftovers
Date: Sat,  3 May 2025 09:58:52 +0200
Message-ID: <20250503075858.277375-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Fixes: c901905ea670 ("target/i386/emulate: remove flags_mask")

In c901905ea670 rflags have been removed from `x86_decode`, but there
were some leftovers.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250429093319.5010-1-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_decode.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 7fee2196878..7efa2f570ea 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -1408,7 +1408,7 @@ struct decode_tbl _2op_inst[] = {
 };
 
 struct decode_x87_tbl invl_inst_x87 = {0x0, 0, 0, 0, 0, false, false, NULL,
-                                       NULL, decode_invalid, 0};
+                                       NULL, decode_invalid};
 
 struct decode_x87_tbl _x87_inst[] = {
     {0xd8, 0, 3, X86_DECODE_CMD_FADD, 10, false, false,
@@ -1456,8 +1456,7 @@ struct decode_x87_tbl _x87_inst[] = {
      decode_x87_modrm_st0, NULL, decode_d9_4},
     {0xd9, 4, 0, X86_DECODE_CMD_INVL, 4, false, false,
      decode_x87_modrm_bytep, NULL, NULL},
-    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL, NULL,
-     RFLAGS_MASK_NONE},
+    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL, NULL},
     {0xd9, 5, 0, X86_DECODE_CMD_FLDCW, 2, false, false,
      decode_x87_modrm_bytep, NULL, NULL},
 
@@ -1478,20 +1477,17 @@ struct decode_x87_tbl _x87_inst[] = {
      decode_x87_modrm_st0, NULL},
     {0xda, 3, 3, X86_DECODE_CMD_FCMOV, 10, false, false, decode_x87_modrm_st0,
      decode_x87_modrm_st0, NULL},
-    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
-     RFLAGS_MASK_NONE},
+    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
     {0xda, 4, 0, X86_DECODE_CMD_FSUB, 4, false, false, decode_x87_modrm_st0,
      decode_x87_modrm_intp, NULL},
     {0xda, 5, 3, X86_DECODE_CMD_FUCOM, 10, false, true, decode_x87_modrm_st0,
      decode_decode_x87_modrm_st0, NULL},
     {0xda, 5, 0, X86_DECODE_CMD_FSUB, 4, true, false, decode_x87_modrm_st0,
      decode_x87_modrm_intp, NULL},
-    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
-     RFLAGS_MASK_NONE},
+    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
     {0xda, 6, 0, X86_DECODE_CMD_FDIV, 4, false, false, decode_x87_modrm_st0,
      decode_x87_modrm_intp, NULL},
-    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
-     RFLAGS_MASK_NONE},
+    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
     {0xda, 7, 0, X86_DECODE_CMD_FDIV, 4, true, false, decode_x87_modrm_st0,
      decode_x87_modrm_intp, NULL},
 
@@ -1511,8 +1507,7 @@ struct decode_x87_tbl _x87_inst[] = {
      decode_x87_modrm_intp, NULL, NULL},
     {0xdb, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
      decode_db_4},
-    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
-     RFLAGS_MASK_NONE},
+    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
     {0xdb, 5, 3, X86_DECODE_CMD_FUCOMI, 10, false, false,
      decode_x87_modrm_st0, decode_x87_modrm_st0, NULL},
     {0xdb, 5, 0, X86_DECODE_CMD_FLD, 10, false, false,
-- 
2.49.0


