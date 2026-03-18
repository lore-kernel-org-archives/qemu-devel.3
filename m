Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C897A10775FD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uzs-00026K-DR; Wed, 18 Mar 2026 13:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzk-00020L-2Q
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:48 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzg-0005pf-Qs
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b0603ee486so698605ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773856063; x=1774460863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7SBLNkZfE70Q4c4n8fHx6puQVux00Zu8cChd4QK9u4=;
 b=L9vZid7sEXqdwUfM7/PaONVf5pcH5ZzGbdQ9C0zUx5ovcsLl9ZFKkl8gxy1Ezu9djJ
 xDJyRVlKNVibSW0954o92/u9x6j1WtcSz7tkk+Ro8KfLjwaBrpMQ0a/+zZSTkQ/9udTm
 ez4X0iXYxr0QJG1WowuOXSM89IhRz4FD5eryO8fVi4cFcEVG+MBYTp7wJXcczCTtJ9N9
 TfRb7YRgw0KDhhuU5n1SSOQQ5zWgILu03lTRL37xAvGCmfHY6b9haukExWjBH3OwiK7U
 QU+bKInYie9fWmmDGc798i86kZnO3Zh7fZqjBU7tKNtCw4RM6yfbvieML7LrR1D+d6mp
 Gr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773856063; x=1774460863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D7SBLNkZfE70Q4c4n8fHx6puQVux00Zu8cChd4QK9u4=;
 b=mQqbQRMGtXpvIKhX3irzviIab039RhHiOqAHU5P7XFNIj+K8P8P9xsdbLhFPNGGhDV
 e/iPQZTd1lbM9pVIJZJ21m6exhPjuCk6ZFfOlOeGaCB2H2qRjW5StCYEOjfz3nJ/Rg/x
 +rQjtPJNTv7JTRBaEp+7hqJx9uNjK9fkN26VAjBsbaPf+BiZWIGbHDkJpnk4osCTkSFf
 yDoUlnOR/zJNOyQAlfbgXYcaYR0flyByNZ1shTmgtfitMoBgHKIYWfSk7C/cBnJQ3rh5
 4g0jnctYzIbETSLVSEVDP+UhFL2Tjy/F4l0lKzVXWid9QIF/0WSV7Eetr+YPCz76hB8o
 Q3lA==
X-Gm-Message-State: AOJu0YysSMQ+Kb0GdC9rRUilsH+Q42kYWa2IYw3nVdHVCX/oqzNm+eNP
 ABl04HL1TM7xJoNLPZl6vo9qZqrUuBppcT85STUBETkm2dEWq0RlaqQaG5eyU0pWCTLV0Z0voM8
 PzG8kl/8=
X-Gm-Gg: ATEYQzwZRpW4uxTBXnmOPq/LebMb1V2Vi2aeWniEmybbpIu1NZqmn18XZZ/S03I/0TQ
 eGJ8m0WcrzcIMIAQc+MqrpeS9LDHMcgVUfQpqJHJsMD8gsUirnr9lXUVz76oGxoKa0e85kM5A8F
 pN0qMeYnxIqn9n6/Ea6J/mU2UXC7lJ1MmGy5ch3alnhLink+gO/QbDc0zs4wFSN4cG6DnJiaE/K
 B4HwQ+Dn8rIn3+vSL/ZmuU7h1tgNZFVg9bwNrYWAKP6N2/1kA/GDbf0KLgJMZbsLLP1Vero8O0K
 qwvjTZlP9dHe7/9UmEnv8zGIS381CG/9AkjxvnWTLfEUJ4e7NHVUcaNbHCg8OsgHO5Se2BL0LHg
 8CPZ/N2ttlQ57kakad+lcxke5o65FHciF3jSYW1l4+HfHawNEESYT9FhaQHsjpicj/dpJaL/ktc
 fCW2Rav2hLO94WH0EnpQCY0ZLk7S8HGFKonLcktvb26ursGCd4Fj/bDE6xY70I7J2ZI9oMjhQSo
 IdQ
X-Received: by 2002:a17:902:76c5:b0:2ae:c907:85e6 with SMTP id
 d9443c01a7336-2b06e43079cmr29467945ad.50.1773856063300; 
 Wed, 18 Mar 2026 10:47:43 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5f0ac2sm34066185ad.52.2026.03.18.10.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:47:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, philmd@linaro.org,
 qemu-ppc@nongnu.org
Subject: [PATCH v5 6/8] hw/vfio/ap.c: use full path for target specific header
Date: Wed, 18 Mar 2026 10:47:31 -0700
Message-ID: <20260318174733.1717643-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In addition, we fix target/s390x/kvm/kvm_s390x.h cpu-qom include also.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/s390x/kvm/kvm_s390x.h | 2 +-
 hw/vfio/ap.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
index 649dae5948a..7b1cce3e60d 100644
--- a/target/s390x/kvm/kvm_s390x.h
+++ b/target/s390x/kvm/kvm_s390x.h
@@ -10,7 +10,7 @@
 #ifndef KVM_S390X_H
 #define KVM_S390X_H
 
-#include "cpu-qom.h"
+#include "target/s390x/cpu-qom.h"
 
 struct kvm_s390_irq;
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 856fa2678cd..3fae9ae9814 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "kvm/kvm_s390x.h"
+#include "target/s390x/kvm/kvm_s390x.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/s390x/ap-bridge.h"
-- 
2.47.3


