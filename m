Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4C9D5CCB9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B4x-0003XU-BE; Wed, 30 Oct 2024 11:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4w-0003XC-Bc
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4u-0007m1-VF
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OC04zWrmLQv9jlMFCWvGBK923Zpyicv5m+dwVSdRYg=;
 b=Sf/bMb0kmbR4AokovOe9prJN5ydwTbg20Z0jEqzSmdObLLJzWZ161jEcHg7WYwdjbmz5RN
 UxcEJ03GJHMjbW9QFOvTlQcaDXjABiau07FuM4pSjerpin/5QwZMDVWffQHgtuUXyiXgKw
 RZtXZEplBFxYQiy4oI/o05R2Yba1clg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-aj5LybM6OcqsWRz0pnEzpA-1; Wed, 30 Oct 2024 11:57:45 -0400
X-MC-Unique: aj5LybM6OcqsWRz0pnEzpA-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3e60970ed1dso31291b6e.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303864; x=1730908664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OC04zWrmLQv9jlMFCWvGBK923Zpyicv5m+dwVSdRYg=;
 b=oW4VMqZcFz1rrtPidxUiUIjFXbYJpyQ0hkModsvuwmpGcwbEZueG5vcwlf65IgNIQC
 OrrF60KodZXIGiYK/vuGtOanDRuLpIxzvgUwTrHg/iifKinOrv8E5Ak9u5s72eszA+E3
 FhqKVY7gzL63SQW3XamJjejFEsk50QfOLgENJGAemy1Ne7vhGnmE7kaSyaYgEp6HEMaO
 8jQ4UZ9nSidAvNYEQo7hmaQ9hedPPBlelCrSWtUxoZW5O8kQAcyLdRIQ3xpD7MBbdHkD
 ZgckCchJlCi2c/i/aNizWU+7nhL+kd/btd46hJHyh75JbhB1ry9PzDYEitl3n56cqKrt
 74EQ==
X-Gm-Message-State: AOJu0YxK+JPfY1RTr1+B7JSmgF8gvdS84c28bFaY26ZT1XsyxiqKXjgQ
 to/8o0wVd+035Dh4evmAecNp7hsq9OFAaUdI+Jaq7wNTrgiR7UzxxGyv3p6pq8lXoAc22ZB0CaM
 tD6M5V7cgDgiuq/FRDu03/jKu+KRTNg/93ymQS0uxv0QKzeKjpMvkiwiyjljr9wBfCTn9egON4J
 dEL1xZf2q44wKwTwDkGA4skWodHyIWUSCb3w==
X-Received: by 2002:a05:6808:1487:b0:3e6:77d:2ea1 with SMTP id
 5614622812f47-3e6384b9564mr13946819b6e.45.1730303863788; 
 Wed, 30 Oct 2024 08:57:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwb7zFYkHxM6wk6In87GHjFcARRYE4qSE/uLqcjwNOdUP4FcyGQfpy56ffwQp4s4S6u2SneQ==
X-Received: by 2002:a05:6808:1487:b0:3e6:77d:2ea1 with SMTP id
 5614622812f47-3e6384b9564mr13946787b6e.45.1730303863338; 
 Wed, 30 Oct 2024 08:57:43 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Hyman Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 04/18] accel/tcg/icount-common: Remove the reference to the
 unused header file
Date: Wed, 30 Oct 2024 11:57:20 -0400
Message-ID: <20241030155734.2141398-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

From: Hyman Huang <yong.huang@smartx.com>

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/5e33b423d0b8506e5cb33fff42b50aa301b7731b.1729146786.git.yong.huang@smartx.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/tcg/icount-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index 8d3d3a7e9d..30bf8500dc 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -36,7 +36,6 @@
 #include "sysemu/runstate.h"
 #include "hw/core/cpu.h"
 #include "sysemu/cpu-timers.h"
-#include "sysemu/cpu-throttle.h"
 #include "sysemu/cpu-timers-internal.h"
 
 /*
-- 
2.45.0


