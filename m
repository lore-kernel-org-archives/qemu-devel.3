Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2066CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 16:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Lbh-0007yL-VE; Mon, 13 Oct 2025 12:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8Lbe-0007uh-Ro
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8Lbb-0006z6-9o
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760373661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=M4PpLZCIcS/TWHP7SQYNUMpLS4jIGwyW9HPY7SpN9RU=;
 b=O8vCAqrx8KnILTYu4zzJcnTtB5Wv0ovL417unMdFCdk2N0bLTPxZo6RZg1uxg1W0IzqgML
 xBRwjMrRGHbOJr2QoSPzGqOghOYN/8lbg6mnnceEzG187NJVhdgBG6Cec5nQJPsjY8Ynr2
 usRGqgbMowzBOgGeLBRBIkuKiMOE2HI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-X-34zVc9Pxip03fcmCwkBQ-1; Mon, 13 Oct 2025 12:40:58 -0400
X-MC-Unique: X-34zVc9Pxip03fcmCwkBQ-1
X-Mimecast-MFC-AGG-ID: X-34zVc9Pxip03fcmCwkBQ_1760373657
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ee10a24246so3831364f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 09:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760373656; x=1760978456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M4PpLZCIcS/TWHP7SQYNUMpLS4jIGwyW9HPY7SpN9RU=;
 b=Hs1uJJpc5V6GlAQdVEuEmatxLKgTexnMCn+rXrDfoTxarDXDMbEL5yiYTBvaWaMPBW
 skYPtbI/E/+iYoRAUkcGS1Hl2Xq87Hz9cFeg64WA30lmfVGJh2ZQHjjd6wogvQuHGynw
 CgnCKitJt0GpTMODlx7Sa0qycQ5m9uHNQ9RKYH+n89Qa1zXh09P2fXPuSsFZ2wqxH+RN
 /o+VNN71nOZj1qG5+tVnBjvfH74CYu6gTGNr1ce6BO7bOspAxsc6xYEcDNUbV/g3et8l
 V7vWsF3Q+or9d9NKuQ4558nm3F2i8NNCOkQc1WZc0u/MzLaWeTMDhyIywlspADmGNS4L
 0nBQ==
X-Gm-Message-State: AOJu0YxMUvZ6JEzCvqr0ulN/bKINLnbuMPfVgJZjtNuPKPSLQF00pr2F
 5idq9lQ6ZbBNfB9hddaWV1WJY/97QctaMJts7KFvv7Py0epVk4dDaibRI9r6cvmBwwa60gJkxEi
 fkAuEd4SLjLpdbN5HiUBK9lnyXnJLAiTaHfba6cebcVEB/gBNRDwv0/McdnPbL/YvkpcIdDUaXm
 02WTxVA0TX0+odEDVV9O5IzeiZ4zm2OfX0GZJAUZj7
X-Gm-Gg: ASbGncuTYw5ixCzSFH3CTLRaD4Ek2Lw5DRElyZ7xVjrMj597P/Me3SpxwrB5AwXxyaB
 IBnUBMZ9VawXXChmPBf8AiErGWu+bfIjeemvIxomcqIjTiqoGUj4nKen5vejyllCr0HgJFX7YH4
 M1BkvSAUax5Wb8r5X4GXiSa4BbVegWXx4rliKyBjjFNxwhHQVCXkL/ztIFJUdErv5E1fB7pXiZz
 yhn+nkAvrAPoUFlTOCxB4R60j/vC8L+szbMdlgRkC0izE//8x2yiM/f6ZRHuQXsxaGaORnbGO6r
 3D7IvvnSvU50zJGvhg4143LcglBzRPNl3CX8zht4RevoEqVBnQcJN/HS/oj59ZLD4uCTjftb3zb
 aqIYCpdzvzX0VTbNvB5lIi0OgbcpQ1xI64lJar+ImZoA=
X-Received: by 2002:a05:6000:4308:b0:425:8bd2:24de with SMTP id
 ffacd0b85a97d-42666ac2dd9mr11659167f8f.9.1760373656002; 
 Mon, 13 Oct 2025 09:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG//xnbyB1liYNR+gj68gM+e4wQmvRUvLcpwHIh3mK/XuGX1KQwuuurxvWUM8Vtc2HPClNVg==
X-Received: by 2002:a05:6000:4308:b0:425:8bd2:24de with SMTP id
 ffacd0b85a97d-42666ac2dd9mr11659153f8f.9.1760373655581; 
 Mon, 13 Oct 2025 09:40:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e0a03sm19164758f8f.37.2025.10.13.09.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 09:40:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/i386: user: do not set up a valid LDT on reset
Date: Mon, 13 Oct 2025 18:40:53 +0200
Message-ID: <20251013164053.1001673-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In user-mode emulation, QEMU uses the default setting of the LDT base
and limit, which places it at the bottom 64K of virtual address space.
However, by default there is no LDT at all in Linux processes, and
therefore the limit should be 0.

This is visible as a NULL pointer dereference in LSL and LAR instructions
when they try to read the LDT at an unmapped address.

Resolves: #1376
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4f99cbc5c0b..455caff6b23 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8649,7 +8649,11 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
 
     env->idt.limit = 0xffff;
     env->gdt.limit = 0xffff;
+#if defined(CONFIG_USER_ONLY)
+    env->ldt.limit = 0;
+#else
     env->ldt.limit = 0xffff;
+#endif
     env->ldt.flags = DESC_P_MASK | (2 << DESC_TYPE_SHIFT);
     env->tr.limit = 0xffff;
     env->tr.flags = DESC_P_MASK | (11 << DESC_TYPE_SHIFT);
-- 
2.51.0


