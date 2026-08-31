Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D09C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x17Kw-0003KA-RS; Mon, 31 Aug 2026 15:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1x17Kv-0003Jc-8A
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 15:06:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1x17Kt-0001kC-On
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 15:06:28 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2d944747d41so10452475ad.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788203186; x=1788807986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tZ+iTEZMuDoLCrtoXGdQZeAICyA3MoElzRAXRcYfLLI=;
 b=oNJaH+YT59sZ5YzlOKefqcvjgzHYxbRvzWNISWZhVG7XrS99XQV+aYn6JMc8Kkyw9b
 0pPwSYX+PsEX1xyd5oJLxP7dDO4nJVI4lf2cmNe6KtMdVOg2y+qjj8WyJh4y16/brrvN
 yAtW8AFctECfupDe78DMErOYgP6l9O/q4r6rz7oXpok/8GjGqFSTZCrc+tvtU7KSkegV
 OV9QLI55Zs746xTthlcA8PjWf7Iz5pfsppqdB9R2fl4W9/744sHzph+634pr102mPVlS
 Kgg9otMouPDFO/4zO2R7+rU51lSbxtGMDcTlPFH2b2sCwgSX23XjTAB6G7HiMeHXUjQ9
 K4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788203186; x=1788807986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tZ+iTEZMuDoLCrtoXGdQZeAICyA3MoElzRAXRcYfLLI=;
 b=dsGgcl2P16B89lkgGoGcrT7pG1IN7sJDVsaEsc06gLZ1D964WhcsNP4F3xXsI/dNPQ
 F6osncQ85SKsel0xgHLMs7HnSFNjuCcAGrbVQZyFc0P//z6k315vxeaVQQNOLu8TtEyo
 B99YFzfR+VUbqIGbYnz3zPo9hMttApG/IuvIPIv/XiTBDweN7J7yHKxOade6tej5Aerp
 x2Z5ZSAasStNi1CVkZMKdcwpWFGujBVTrVetRdbG0TxxMumSMyFeEmhSot4Xrp6hDnr/
 tH9GupofcteZ3/EaiFGq6GDninDNkGtg3MencwGvp+1OxF5vcN9CE3YjEirMJcGyEmBX
 tSoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByN89esV3Om/Uu5tC2B41cEm9Arzh6Xbe28dB+jkGtZ39Ve+eg57DEecXgbpuVqCqVeYQ869wME1fQV@nongnu.org
X-Gm-Message-State: AFuF++m0wiahi7fzbkWhAgde3PtfZcJGxlZnKkZffxn5Z1x5tpJYy7DA
 rqFUc5USeTYOIyHx9KkMXckhvg6xm+s6S8SyF4A/DP7zi92Ub+UUzybd
X-Gm-Gg: AYBFou2A/ZdHF4NBnHCj0Ct9AtObVVqrCNCkvjftnOXEqS24aorXFL2xqr+6aoyl5cV
 geCo+39bxzgqDSE1t01Riqu9r3CCRYW8AzKTZQyJqMh+KyRfYKJxpU46Kt+zNSAzPsPmuyn6Npx
 Qrk4wA/BJWAbondijcOPd5jQJrN5SVaxFMMz5kLqEvqk1ByD2gUMRh37JQo5m6A5MHP2sL6l155
 dzCyr+gF8qrE8KUrKIPbe1IjHXRM0VZds7IQbDoxb78mIcUboebw2I6l8SakTVzcUFCQil4iCLK
 fEZXBQFwT2G21sgJfI2nDY3CNC7Y63ZDOQSkEBsBoaSUvDuP15XS7DqFDlg//yNfnk9lZI6kXRT
 9D/B3lrsTBUwRPpnQvzHi9rgRodAtvXL06PR7A/ONhGvisxYySuz4K0H/KVKiOBSxGO1VJ371wC
 6SSmezD4W2dC4rhqUs0E60XsrW6RMJ4LkBsBytYxRo8R1LVI9zAjewZXyE7MEfWNMr4+T/AdMWM
 8pc/bGnlzSGFUfnUgOdIYLfJrv04pQDuP/DNYeyDjWUfYRhpeLz2Jv46Ca3p7+QGg==
X-Received: by 2002:a17:903:37c5:b0:2d1:134:b86e with SMTP id
 d9443c01a7336-2d74dbe9608mr440606465ad.2.1788203185573; 
 Mon, 31 Aug 2026 12:06:25 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d7598c1cb4sm40595765ad.81.2026.08.31.12.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 12:06:24 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: mst@redhat.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] virtio-rtc: Report smeared UTC clock type
Date: Mon, 31 Aug 2026 19:06:12 +0000
Message-ID: <20260831190612.369235-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=visitorckw@gmail.com; helo=mail-pl1-x633.google.com
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

The Linux virtio_rtc driver only registers an RTC class device when the
clock type is VIRTIO_RTC_CLOCK_UTC_SMEARED to avoid leap second steps on
pure UTC clocks.

Report VIRTIO_RTC_CLOCK_UTC_SMEARED in clock capabilities so the guest
can expose the device as an RTC device.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 hw/virtio/virtio-rtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-rtc.c b/hw/virtio/virtio-rtc.c
index 32de9c1650..0dcbe94758 100644
--- a/hw/virtio/virtio-rtc.c
+++ b/hw/virtio/virtio-rtc.c
@@ -62,7 +62,8 @@ static void virtio_rtc_handle_request(VirtIODevice *vdev, VirtQueue *vq)
                 resp.head.status = VIRTIO_RTC_S_ENODEV;
             } else {
                 resp.head.status = VIRTIO_RTC_S_OK;
-                resp.type = VIRTIO_RTC_CLOCK_UTC;
+                resp.type = VIRTIO_RTC_CLOCK_UTC_SMEARED;
+                resp.leap_second_smearing = VIRTIO_RTC_SMEAR_UNSPECIFIED;
             }
             written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
                                    sizeof(resp));
-- 
2.55.0.897.gb25b4bd76c-goog


