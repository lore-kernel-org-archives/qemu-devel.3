Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B27C5AC67
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 15:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsj0r-0001tb-AX; Sat, 08 Aug 2026 11:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wsj0o-0001sh-QF
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 11:31:03 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wsj0n-0006Y0-7j
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 11:31:02 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so489694a91.3
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786203059; x=1786807859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vhZR8OvPYc9FUcIBxMXPkD7VFNC17pB7loT5n+cu48s=;
 b=rBHC5FEfhLRJUo7ICdnywY7wwct7/ech5L9HpT8wpIBpDdhfO5deu472ntLYpAi7Og
 zQS7z19kZ23aBdJ0JFd+m2bFpjw93ZIFts2vFeZvg0O4vPGp/gIYJNJL0yGbLj4Z1Bjy
 Afkk7oET+pwteX8+dFMJKeVrVawsPFeS4Q0PNT1cTz3RPj5tKOqDRCRwt5vO+CxYriIK
 OOGfOgtzn8SmfNax9UXsI7SxFB2XcRpeaJThTty3BF20Oivg5acoH65LO09C6NYmYGBI
 RN2odWLckZWInAeo9uDAVxmM7KOdTeqRvCecAR5Hw7CM29Tglo9tKhM0eJQFoG93seRj
 5JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786203059; x=1786807859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vhZR8OvPYc9FUcIBxMXPkD7VFNC17pB7loT5n+cu48s=;
 b=MK/HbK7Hrjb7w9N0vMbOa28LBOlZQRu5Sye/bKjkzT8UgjFnAE8qDjxMksHDHUXoqL
 Hw2jFUysUxkqAy8LHwWvSbwC7LYxtyXOMwMs5bPdhKxm8qdJPQ4w9zPbMXTNzgCdJXQ3
 7ZpnJ0wEWQ+YnB/l18RgoBi6UFXU/Z6XZvcTa9wIiXLb9rAgL3E2IPxu0l9u0TGoARsy
 9XLpD87kewTmwcju1ulOIfOnIkTyIia5Zjpaj0KdK/EONlWdktCuhMDn4fYb0BOSyuul
 /FNh/LkPiP+pmrY82cJ26caUHLLU1ZLjZf5d6e31DepNMB10nFTNCTC9zlkSqY9M05ft
 rcjg==
X-Gm-Message-State: AOJu0Yw7B9f1rR28q59apw+dYejyQ5wA5Wpl0YvbWhiXP0V1F80Tj6br
 TDWsJRT2E6XoF4Vo1oOIIwNlhyyr1mEodYVWpXEeRg+YeATe8bLYg/0qZW6u5hne
X-Gm-Gg: AR+sD12G5KLxf9evDYQotTfr0boHNFXDfHouZs7nzxHCjGv9qnSfTJe2NsrE10LmzC+
 zRxlIRXLigHoNg80OwU5E2KOV2aEr+t8Ubksw7RuuRV3V8mgK1qThpvBPRyc/xus6XLU5ggwox7
 i7PVqIrgnj4I0GChNOGToH+WDFZ2nZfKj/IeqZLV1umJAlPJONNcQOKroeoQ3QlYBKyvSH1yVUk
 k/djrTuep5oGqjpJfK0pAvmQjk+ZasqcXwm1iiPD7K6Cn2lTIAH4OJtGlDn94bxlWMvLQDvJLYC
 nppvsUf11sSF/auZMmry0T0pzI7dFE07mE9qdVqWn+Nai+wkiUXZJZLw14NTz6Z2e2Z9sZ0zZvQ
 MDhDcsuAIJXQ9TMO0TlFxeQCkceFCm2sqRjXcbKx5GEGa8kitbMD5RQlQL1KL/HsGhRJ9VOJ2If
 lj6eCW05GVAr7ddUDrvGDM74kfHNad0cKQiUFAyQdHVi+FhgY76+qoZRq8dmwoFHKwS74ioXSkH
 2gL
X-Received: by 2002:a17:90b:1d4f:b0:38f:7f60:ba35 with SMTP id
 98e67ed59e1d1-3903c5381d6mr29994555a91.5.1786203058796; 
 Sat, 08 Aug 2026 08:30:58 -0700 (PDT)
Received: from MacLin.attlocal.net ([2600:1700:e140:14d0:50d2:25db:c95b:492a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bebee8d0sm19978586eec.24.2026.08.08.08.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 08:30:58 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Connor Kite <connorkite@gmail.com>
Subject: [PATCH] hw/virtio/vhost-shadow-virtqueue: range boundary in
 translation
Date: Sat,  8 Aug 2026 08:30:57 -0700
Message-ID: <20260808153057.2641831-1-connorkite@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=connorkite@gmail.com; helo=mail-pj1-x1029.google.com
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

iova-tree expects inclusive range sizing when maps are allocated or searched.
Currently, svqs use exclusive sizing when searching their
vhost-iova-tree for a match to the region to be translated.  This could
lead to errors if the region to be translated is at the edge of an iova
region.

Fix this by reducing `needle.size` by 1 in
vhost_svq_translate_addr to bring it in line with DMAMap and iova-tree
convention.

This patch is an updated version of one from the patch series "vhost-user:
isolated memory".  The patch has been isolated from the series as it
is not tightly coupled with the rest of the series.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index bcb7f2ffc7..c8831d52be 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -99,19 +99,25 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
         const DMAMap *map;
         DMAMap needle;
 
+        if (unlikely(iovec[i].iov_len == 0)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Zero-sized buffer made available by guest");
+            return false;
+        }
+
         /* Check if the descriptor is backed by guest memory  */
         if (gpas) {
             /* Search the GPA->IOVA tree */
             needle = (DMAMap) {
                 .translated_addr = gpas[i],
-                .size = iovec[i].iov_len,
+                .size = iovec[i].iov_len - 1,  /* Inclusive */
             };
             map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
         } else {
             /* Search the IOVA->HVA tree */
             needle = (DMAMap) {
                 .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
-                .size = iovec[i].iov_len,
+                .size = iovec[i].iov_len - 1, /* Inclusive */
             };
             map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
         }
-- 
2.43.0


