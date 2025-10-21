Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45F2CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJd-0005mK-0d; Tue, 21 Oct 2025 16:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJV-0005La-HF
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJT-0001ZI-Hg
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so5701075f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079833; x=1761684633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5pCkwXJ0ZMdPMUhQ4XQ9aG/lFbpQNR5L7Pb23bpOUK8=;
 b=p/FmL8PvTjlEdEzy39R1+gDQ7BmyPA4iIwZLYdDRqJYb8SfENwWXbRYrZSe+wWU6LN
 yhBPVspOu/E+vsydFzxl7cXJTMpvzPDg4+vCtgnxzkzoStJK+m/HPPhCw3hM86nqxgKQ
 Dv5kB2Yhw8VX4xVrrQcNKHrDlaFlzXGtYhNcfN2lp/pSY16/X4u1UuyWwmdwx5uY6Lw3
 d9FYYhJlH1Vi527imsZoI8Ig8k82lf0QcpjduUOw6RxIaMTCQ/RX/wxzurVU+00sh0qm
 5p7xxvUPWQ4kZSqaElN8M+SwlJTKJVT0BZNDop7ELyT03N3iwqaw94NJRj0EY63luMkl
 RAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079833; x=1761684633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pCkwXJ0ZMdPMUhQ4XQ9aG/lFbpQNR5L7Pb23bpOUK8=;
 b=qRK6fBVaX8u8+tqQ7qNayjQF0m11j3cG6So9kZv9ni7GV7vucO4QDucngtpgIjaxKv
 YHiGvFOlZQBINImhTZwmV0k4o4I7KJWs7+JDzyAab66tNFZ3ziHywyPC0z1EQc0TcJs7
 feZq4sAwRiLzPd+lGW+/QY7sttadymjSH3yCVpYqIlFUWHJrAGqdm7dMxLrpG8++B86k
 Vc77682L7mLMHp0nH4KUFR9g62OBHMwGJRg7qFPuuYUEa2yNqHtC0MEWS+/GWj/GYkyG
 a7+TAFZwhnXG+COzZMzVEMAwOHg8Rqk7PvJYgQqrKwxjzrRUF3P4AaA+f8KkY1jU+8lA
 gcDw==
X-Gm-Message-State: AOJu0YxcQ+QlOpC9mdVO+INMXa/GFYDnkRJcZQF1BrdCvAG+0KGpzr4U
 pt63H7U4Qo/9RRi3eXwjtVtCi9WzctFpWSmNWaFRT8V3J7UxQXzeumevo5mANG8Yx5/t/N96fBm
 PDCS4WVo=
X-Gm-Gg: ASbGncuZ1G4GEwGcdz+iDWl7b0MDBm1VomecVcxa+gR6U2ldY99Ic7U7zAcLYD+YFaO
 9Exn867T3boqfp/BqrFy570GmY8NY04eoxd0RBraEH8NbAQ1K2BrGDedDvthSerJYeZVi+wf03z
 4tj4TzLMTFen9GTaVy7XqJJFMmACwa109E4kYDNZR0bXBVP2mJlWPiQe4ED0yotEzfJdl1TjAvK
 aIkAGerCsRDmV8Yd2OwdZEROKijftNZLgPbYJdI6SBoqKr8rUME8YET6e54wheW223lURncUWK9
 WUwGua8hVG/BMiK99Sv8A3G03Zt0ZJ/RS90wge3+AqnWpRzvBOWXAPJx0er5gldc6spiUbfD8gC
 M8E8aViWEKkjucHvaVZX/nAIYDwtaLUyC9Zlb1ET8/vwm72x6YKXU4Uuf16z/PCdEfMtKXJPVmB
 mRX8YhHBb+mUNW1wTaVry7p0jfCBG1XDgU3WDmxqdl+VyW3eNRaQ==
X-Google-Smtp-Source: AGHT+IGs2Z3YSA1x/PxUxi5iw2Iw8Rtin3k+88j0qCKZCdFaNJOWoZWsMHacOKp4FGrMNQ593EYyzA==
X-Received: by 2002:a05:6000:22c6:b0:427:23a:c339 with SMTP id
 ffacd0b85a97d-42704d6c507mr12832022f8f.14.1761079832754; 
 Tue, 21 Oct 2025 13:50:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b985esm22665976f8f.34.2025.10.21.13.50.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:50:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/45] docs: Update mentions of removed '-soundhw' command line
 option
Date: Tue, 21 Oct 2025 22:46:59 +0200
Message-ID: <20251021204700.56072-46-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

The `-soundhw` CLI was removed in commit 039a68373c4 ("introduce
-audio as a replacement for -soundhw"). Remove outdated comments
and update the document mentioning the old usage.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20251021131825.99390-2-philmd@linaro.org>
---
 docs/qdev-device-use.txt | 4 ++--
 system/qdev-monitor.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index 043ae461140..fb420da2a9e 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -311,9 +311,9 @@ constraints.
 
 Host and guest part of audio devices have always been separate.
 
-The old way to define guest audio devices is -soundhw C1,...
+The old way to define guest audio devices was -soundhw C1,...
 
-The new way is to define each guest audio device separately with
+The current way is to define each guest audio device separately with
 -device.
 
 Map from -soundhw sound card name to -device:
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 2ac92d0a076..ec4a2394ceb 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -73,9 +73,9 @@ typedef struct QDevAlias
 
 /* Please keep this table sorted by typename. */
 static const QDevAlias qdev_alias_table[] = {
-    { "AC97", "ac97" }, /* -soundhw name */
+    { "AC97", "ac97" },
     { "e1000", "e1000-82540em" },
-    { "ES1370", "es1370" }, /* -soundhw name */
+    { "ES1370", "es1370" },
     { "ich9-ahci", "ahci" },
     { "lsi53c895a", "lsi" },
     { "virtio-9p-device", "virtio-9p", QEMU_ARCH_VIRTIO_MMIO },
-- 
2.51.0


