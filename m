Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D8606A336
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZhvNZks
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ9fc-0002bz-D7; Sun, 08 Nov 2026 15:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jpaulma23@gmail.com>)
 id 1xQ8ey-0003nw-5Y
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 14:34:36 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jpaulma23@gmail.com>)
 id 1xQ8ew-0004PN-Mi
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 14:34:35 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5ece3ab2e91so74526e0c.2
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 11:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794166473; x=1794771273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z8t0nNuFXyxz6SmHHB6aORBIYFJJJrRDmmJIfbtuZKg=;
 b=lZhvNZksJbmUS/LmmZtd3Dyj+UHsKBuSN1r1gtznT3x00gGkBVG+895JjR2dtQ1Blg
 5Ip0EkbtW9HS2h63l74BwjzW69MHjMbj/VgLub1JgEp8nmwppFjijOx+GWzo3J7o9L0L
 hEbRjlk5HCmge9k4WkvrDXvUqKuY1hNHcrdF1ux9yFixweC102++ZVkKjwRT3TPlQ13W
 KuUC/ePZcqkQGjkjaU2L6SBDteW0PxdQnxEKhdOnUCFN/epHy/0iT6YIqDcdjNflJYv8
 /ZTnN+BxJSqusAhtg/8KnoNZKlM+XbPmjrXF2y2FOap14ldT73qFulDdqVTUOdaPovml
 zMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794166473; x=1794771273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z8t0nNuFXyxz6SmHHB6aORBIYFJJJrRDmmJIfbtuZKg=;
 b=WJ6XyOrLBlLUChto+kZ2/WOzZ87qzPUtI3RFWTYOy1Kqs7l0TNZkDSCS6YYElHyil5
 UtOt4egLrpsdBABi2/zZQCLMZgTlhouTMhIVW2XIP+VLzgKE+LXSpNtX50r8zzHcdJZH
 znI167pPi7+1HqWtgi/HUDodvVm7dW1nwSmS2q4OMqHoagVU5HATkprrC4o1HRBIrNGI
 uCdlxEia5tTHWO0G/IIr5dNHw6XtP3qZmckeNsCffVQU0ao/da7zSp6J/+CiTJaRimdp
 bd4N69lOlzwp6HcIi8q57yw/iCvk+Vbfov+9OciuTY7jNkbmVZqjzLTMFI+v1qHQXgMB
 jN4g==
X-Gm-Message-State: APuU4Z/4RyYwvRO+pylNLUc+9jYoX8uylHGZ7/Q1odDjdnKg069pxEG5
 2hlSv9msE+Cv26reDiknD/AjDBGVulqpEOkAE9VGu3g23GZLs+ObldoDk4EsZk9a
X-Gm-Gg: AYBFou2UJudhSx4KicQBdFF9j2mCuNdPr5C1qHEMSAVR/RA/eGB/3bkcO8yZgY3hnT9
 XmFKTWrfQbGqewwftShiOwK/R7RW3khpqzsup+te9HYaoMNQqpN79wqVyWgxVui5JbUGild/PJy
 wQaJ7U7jzC+zgXtIPXfhpj4y9T2j3sodE8IaLBC43ag4tx3xG/EY+0QRtG58RKxk8LZcfL9YGhR
 xUcohE8LRS4Q2QL4yOjxsb4z+WUg3Ibxk6YMW80EfSNCGYptsa5NFvOt7o+bTVUNv21CzUyO5OC
 Y7PhywldhO6vZLZWeg8G/6ab+i3iR6vef8BStLcGOqnJl16Sg74Otv2XpFTluaSFZpM8zkmf4en
 2BMTPJeLR5HRzTJKVAmjDkp34okNZEY0OIl8umtol6NEY6Oy6fnO2ccLD9R2xRxy79HMCVzDWci
 AW5nAlgNdb4HwIwFjUaO1D2Ad+W3lKUjH6EYe3/3hvjQWlC5r0VdyI4P7ez1oK7qcPukUQ69g8+
 hmCVNskSfYFVmxV0lFm+BYVJAOHk1u2/ib9rrVjmhHGGyfX+ttgfmsNUphz+qTJsVKCcGUGurBl
 re66RB9wCOpP3gnw1iHEAWXQFxu0sRyxKkfN
X-Received: by 2002:a05:6102:dc6:b0:7cc:1a41:20e8 with SMTP id
 ada2fe7eead31-7d2daaad4eemr477831137.5.1794166473350; 
 Sun, 08 Nov 2026 11:34:33 -0800 (PST)
Received: from jiputer-laptop.. ([2605:8d80:6c29:aa12:5c76:8909:6da4:b5f3])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99c029dc1e2sm2237456241.4.2026.11.08.11.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 11:34:32 -0800 (PST)
From: jiputer <jpaulma23@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	jiputer <jpaulma23@gmail.com>
Subject: [PATCH] semihosting/uaccess: Convert malloc, free to g_try_malloc,
 g_free
Date: Sun,  8 Nov 2026 14:34:23 -0500
Message-ID: <20261108193423.225720-1-jpaulma23@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=jpaulma23@gmail.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 08 Nov 2026 15:39:15 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert malloc to g_try_malloc and free to g_free in
uaccess_lock_user.
Convert free to g_free in uaccess_unlock_user.

Signed-off-by: jiputer <jpaulma23@gmail.com>
---

Something to note, when len == 0 in uaccess_lock_user,
it will return a NULL pointer, instead of a non-null
pointer from malloc. Any read or writes on *p will report
EFAULT since it would be considered a bad address.

Patch is for this issue:
https://gitlab.com/qemu-project/qemu/-/work_items/1798

 semihosting/uaccess.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index ff944d8c2f..71d7cc9006 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -17,10 +17,10 @@
 void *uaccess_lock_user(CPUArchState *env, vaddr addr,
                         size_t len, bool copy)
 {
-    void *p = malloc(len);
+    void *p = g_try_malloc(len);
     if (p && copy) {
         if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
-            free(p);
+            g_free(p);
             p = NULL;
         }
     }
@@ -90,5 +90,5 @@ void uaccess_unlock_user(CPUArchState *env, void *p,
     if (len) {
         cpu_memory_rw_debug(env_cpu(env), addr, p, len, 1);
     }
-    free(p);
+    g_free(p);
 }
-- 
2.43.0


