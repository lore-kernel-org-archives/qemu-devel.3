Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07370C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjI-0005MB-0d; Fri, 01 Mar 2024 23:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1j-0003z4-65
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:57 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1g-0005uF-04
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:50 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6e48153c13aso1388239a34.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334646; x=1709939446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTWT+RMoE1i/VU7YNW7VXZJeWBnC/6JB7arqg8VoVPY=;
 b=wPPgO3Azw4RZNrbdtjDazpIblGSuGm+sz0IzwuS0O8fW9MoBwtkqB3w81bNDlmfZIq
 T0LL8c6N5a2yBwanLH6OUQ9EO9ZN2ytZb3lBxO4or+6X1UxK3FIeRS6JgiAj8TZpHCzZ
 L80gvYehonUdo3F/eqlnbsSjTSpq5t+SX8aGV7CgDIT/jUMzzkWBDVz6HaRA+j93e5B4
 8jANdlMGCPpt8UzEw12nRYTDoe8nMvUkArMj8QyTaElgAFIq4GT8bJ4fa6t+ZwUfVuZF
 uNwFES1C+aVNMn+BlHAjE7SkDqyPVrMIvw+Sg97iXPlcFp6fqWjHD24wDu0qHyZiJjHi
 EUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334646; x=1709939446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTWT+RMoE1i/VU7YNW7VXZJeWBnC/6JB7arqg8VoVPY=;
 b=sI8yS/SzQwZfu3V6MkSA9tjNEaj7hFAHl0kTVpOP7sIAt6BaLBZkhNr303MlMSKDri
 HXgd4VfEcJ8L7RvYgJRv6SGUaXo25lEOplJ4EDG4h4V9PiQgiiyeUNLQvgQ9SPxPCq/n
 BUpbeOSE1nf5fAIrE999WQOxQa4d0PLrAHwJWL/NXlvnolrGra8DOoLD0XXap1XTp6ve
 D14x7URIfqHgqADbevSltXsdx4vduDgdwTgn7FJp0j2j3tA/7LjoU1a++dE1/y/XwROU
 LsRzBWu6QsLP/xVE2WGjFlRRV2Ophi+yBS0B5+FDtMU6uOPJshhOWO8U1Ns4o7r5vsL2
 zVfA==
X-Gm-Message-State: AOJu0Yw2u7Ha+diFY8vTVMWP7OdfZXQuIq3hqFyrDJDUNwWqYB/jqxM4
 tUPemdLmJjDhdBWMou9Kd/bPVY4DCT51vgXaZ8+CLnR1HTcUly88OXPX1Z1L0iE0W8FbmHvrb9K
 G
X-Google-Smtp-Source: AGHT+IEC3IEufMvQbh163ikvKev1ecMXJ1/QLnLvsRa04C24bmAmYgEHkN4sYfovvFlF6DSD8TUFyw==
X-Received: by 2002:a9d:6d85:0:b0:6e4:7e89:1205 with SMTP id
 x5-20020a9d6d85000000b006e47e891205mr3873115otp.9.1709334646004; 
 Fri, 01 Mar 2024 15:10:46 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 56/60] linux-user/x86_64: Handle the vsyscall page in
 open_self_maps_{2, 4}
Date: Fri,  1 Mar 2024 13:06:15 -1000
Message-Id: <20240301230619.661008-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is the only case in which we expect to have no host memory backing
for a guest memory page, because in general linux user processes cannot
map any pages in the top half of the 64-bit address space.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2170
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e384e14248..bc8c06522f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7994,6 +7994,10 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
         path = "[heap]";
     } else if (start == info->vdso) {
         path = "[vdso]";
+#ifdef TARGET_X86_64
+    } else if (start == TARGET_VSYSCALL_PAGE) {
+        path = "[vsyscall]";
+#endif
     }
 
     /* Except null device (MAP_ANON), adjust offset for this fragment. */
@@ -8082,6 +8086,18 @@ static int open_self_maps_2(void *opaque, target_ulong guest_start,
     uintptr_t host_start = (uintptr_t)g2h_untagged(guest_start);
     uintptr_t host_last = (uintptr_t)g2h_untagged(guest_end - 1);
 
+#ifdef TARGET_X86_64
+    /*
+     * Because of the extremely high position of the page within the guest
+     * virtual address space, this is not backed by host memory at all.
+     * Therefore the loop below would fail.  This is the only instance
+     * of not having host backing memory.
+     */
+    if (guest_start == TARGET_VSYSCALL_PAGE) {
+        return open_self_maps_3(opaque, guest_start, guest_end, flags);
+    }
+#endif
+
     while (1) {
         IntervalTreeNode *n =
             interval_tree_iter_first(d->host_maps, host_start, host_start);
-- 
2.34.1


