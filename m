Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C0EE6F08C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 21:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6z1W-0004bH-Vp; Fri, 01 Nov 2024 17:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Y0UlZwYKCsIzwy2mpowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--roqueh.bounces.google.com>)
 id 1t6z1L-0004aZ-R6
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 17:17:29 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Y0UlZwYKCsIzwy2mpowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--roqueh.bounces.google.com>)
 id 1t6z1J-0006bL-NQ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 17:17:26 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e30cf121024so4517399276.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730495843; x=1731100643; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aMrTZ4STABqah8WQotlgzCCGyariF5g40NI1L5oOnQk=;
 b=ZFhn4BAzh+Tqt3zHOt2TrPbGEp0GyU2GMY6qeb3MJuMLHhYkNHRoTkfDVf78gut6qF
 E7Y4zR2I1cG7rYJ+xDTZdezA7e7d/eYEGtoOfawCBNfsg8Jlc7LI+K8lmP1lLJdGPikI
 PHj7cZQMQcy2mRzk+lv2KMgZMWb+mmA3gmOxUoHWXf0gjI5g2MG70486La8F02qcmLoY
 JivUIIkg9uO4vCEFVDrtnAL5sKjf4lEhBilpioxwlXyg7quLNqOhw5EHLyHcUJRNPHsr
 pcw6wHhl32IK6Fg2gWI8JrtHzPMHBaNH5RUmFRUDRwttY0ojPxcGs3LvAte/OuzfyyyN
 bO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730495843; x=1731100643;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aMrTZ4STABqah8WQotlgzCCGyariF5g40NI1L5oOnQk=;
 b=HXPn9s5aWS0judYKOIQYSEeILkCKHQ4EfLXLCGdHVmQhA/fFD/zE4VWxlWhU5kbaho
 efRWRWukxpPEJ/7CCh0BTSOk1EClz7xUY+PP95tvZvkjXPFMfybaCHT5sRrI4qK5Fg1K
 nri0iNQQezmsYtX3KW4B0kWwfpCPQ4ONme8bdpXOebcPPgVBcmdzcJqzwnGM9s/eZmKQ
 ZHtKK2zIIVC+wHHOIBFBuZyq98Q4pOAYd2FbpFekAhkPqVcssgfD+r8p2fagquQv+gPl
 nDxeHwW4UMLcbbzc3AwjoPW98xIkRqc8a7ahCqCakqYA9OZ+cCb1nUEINNvN24E2uo6N
 A6wQ==
X-Gm-Message-State: AOJu0Yydf7q+4vZBgsRQSCK++0ofS3J0pqC9R0PUs8zwvblEJdjTP1AC
 X2qYLCMY3wQG6KSgUD2HFPfRpr/I+HXA+BxZi9uLccZ8wH1cbg/1kaCuzJ19BY4ezWzC4ASnuHe
 QPw==
X-Google-Smtp-Source: AGHT+IEU0MGtxnVsF87k9bN21ViQZDxK8Zwb1BkKpLRzF8YW51W1q0Hz0sb8Vu1Jb1hohj6iZ7Q/q03l9+Q=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a25:83c3:0:b0:e30:c79e:16bc with
 SMTP id
 3f1490d57ef6-e30c79e1861mr13959276.8.1730495843419; Fri, 01 Nov 2024 14:17:23
 -0700 (PDT)
Date: Fri,  1 Nov 2024 21:17:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101211720.3354111-1-roqueh@google.com>
Subject: [PATCH] hw/usb: Use __attribute__((packed)) vs __packed
From: Roque Arcudia Hernandez <roqueh@google.com>
To: thuth@redhat.com, richard.henderson@linaro.org, jansene@google.com, 
 mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org, Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3Y0UlZwYKCsIzwy2mpowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--roqueh.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

__packed is non standard and is not present in clang-cl.
__attribute__((packed)) has the same semantics.

Signed-off-by: Erwin Jansen <jansene@google.com>
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 include/hw/usb/dwc2-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/usb/dwc2-regs.h b/include/hw/usb/dwc2-regs.h
index 523b112c5e..b8b4266543 100644
--- a/include/hw/usb/dwc2-regs.h
+++ b/include/hw/usb/dwc2-regs.h
@@ -838,7 +838,7 @@
 struct dwc2_dma_desc {
         uint32_t status;
         uint32_t buf;
-} __packed;
+} QEMU_PACKED;
 
 /* Host Mode DMA descriptor status quadlet */
 
-- 
2.47.0.163.g1226f6d8fa-goog


