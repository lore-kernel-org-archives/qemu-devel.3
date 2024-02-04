Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69CEC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 02:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWSOa-00008s-0f; Sat, 03 Feb 2024 21:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWSOY-00008h-Gr
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 21:38:10 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWSOU-0006qq-Fn
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 21:38:09 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-686b389b5d6so14898456d6.0
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 18:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707014280; x=1707619080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=01dkI6EOG9WxuF4BSNDnSeEjW1R/r5WKmjcKwk0KGew=;
 b=UZ/up4+zprHMYll6PJVHQUECuD61Uic0sST68pwwqO/kAf8g6l/UASut2aW8tYKETu
 D0y1xXqXrBoz7U2c07qwit6TmKRzI0JdsI6nBQKvjgmijjT+PHkwu+CwU4/zpGxRqmH4
 5R+YhNg2R6GuuqIkvSw3c13kBKCb6nZmlv/+CUfDEY1bHcU6L930JRRFWBtP+25edhPY
 UOnyBovn7eEP8YmP+yIKgBr1KP6VFbXzQYwbZscQmyN3WAjAlBY7r0KEO6eoR3sH4uqD
 GTokLlPbZbEwuzQ7fy9Pf/vbrW+ixYOiKODRZkQ4F4oI8G9NmGMVdZSCPNb/2PiigEAN
 tq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707014280; x=1707619080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=01dkI6EOG9WxuF4BSNDnSeEjW1R/r5WKmjcKwk0KGew=;
 b=gGjavz8iei1j5psYTGYuP0cmUYC8EKZbi3mVKncZrn1JjaM2Pdh4fRHTedbSPRevMD
 wQdGd/GH3a52w837hQjliKkYFDa5trAR6LoQm2Fk5bIWEWc7QZZ07+wEkuicWFkvuHCa
 dac1bEhVkMsRmLk9h1qKB/mfCj+Psls07gcIITIkPkwmMGw0F1TbAxd+cSkdljGn1bF/
 fem5ZRo1QQcp9FUPI1S5fjKZjFcMI3FmyKpcUpv4gMETKQo9UFWDgDE93qI1QMoCf4Za
 t3lf0gRnJVvDJnYmfDBek4gE2UkEkCaIXC/nX5zQ1tlvvI6uOMHyN8uUWShA6j18hWok
 pygQ==
X-Gm-Message-State: AOJu0YxbgIZKZnHw3w4PIpft1T8XA19moUDrfAcH9qKus+zvA94TpxUV
 BN/hnbptGIEwEDAZ44wSWVHCZ/X5ClBBIn+ICI7R50QRTk5Jw4f8uBSQxjsdtTu1uw==
X-Google-Smtp-Source: AGHT+IF3mDrxVTlR5tToDqYEeOxubNSH3ZIfovQmWn5ohC1zhYNAxl/tGgvwnPQNZWAfgP7nDt5/lw==
X-Received: by 2002:a0c:c983:0:b0:68c:957b:7740 with SMTP id
 b3-20020a0cc983000000b0068c957b7740mr2619845qvk.41.1707014280686; 
 Sat, 03 Feb 2024 18:38:00 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVvWL6tdAARkxzhvD9zdCC569SIId1x5+/bGhZFGACJLEyh+ZNCwaVrF6FuKH/vMMsJm06ehUTHWEOQ2wB0avEGqJHV/mU/RVoRdFh1I/suCBEqwddn0f0wqPi8
Received: from raphaels-air.lan (068-175-070-054.res.spectrum.com.
 [68.175.70.54]) by smtp.gmail.com with ESMTPSA id
 w11-20020a0cc24b000000b0068c5b3a7f2fsm2337742qvh.37.2024.02.03.18.38.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 03 Feb 2024 18:38:00 -0800 (PST)
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: raphael@enfabrica.net,
	Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH] MAINTAINERS: Switch to my Enfabrica email
Date: Sat,  3 Feb 2024 21:37:58 -0500
Message-ID: <20240204023758.83191-1-raphael.s.norwitz@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I'd prefer to use my new work email so this change updates MAINTAINERS
with it.

Signed-off-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f9741b898..a12b58abe2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2556,7 +2556,7 @@ F: include/hw/virtio/virtio-gpu.h
 F: docs/system/devices/virtio-gpu.rst
 
 vhost-user-blk
-M: Raphael Norwitz <raphael.s.norwitz@gmail.com>
+M: Raphael Norwitz <raphael@enfabrica.net>
 S: Maintained
 F: contrib/vhost-user-blk/
 F: contrib/vhost-user-scsi/
-- 
2.43.0


