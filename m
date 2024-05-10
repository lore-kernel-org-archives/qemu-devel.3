Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD86C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Nog-0001OA-5t; Fri, 10 May 2024 06:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5NoX-0001Ko-Kl
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:23 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5NoV-0001UQ-Ec
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41ffad2426eso3650795e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715338157; x=1715942957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVbCv81rAzGflBvcSrzxqDvQbbVCQ+aUGbh/Oa+Rhcw=;
 b=GpfH6ElDBYL62gof87k7LDlCzRrUU37KUmj4oMkRWiwHb5Ey9EVi2EY5dCkMCs5bJw
 xgABtdLLEHDi4/qY8sUCaUN968R0AanIkgcriC+J2K1aXEpdyJAxCsf+e+DEz3hKCn35
 CCUrTMNJOghpb6GqiR/o+CNK757EW4YlfVv8nvOtw9tiPSVws4Ok31XJl+sk43+ZAHS5
 p+KidkmzyBepcVWXnttuXeTeSPRSVKmy8TECG4m0sk/9rQYMU9ud+Fi9Q9NJlnmyQCVu
 c7wsM4nSlw5+rlgs/h2AEh4wACdJQrVvpASAPwFKRBiXL25YCvGhccsIG8jWc4igN9+d
 2jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338157; x=1715942957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XVbCv81rAzGflBvcSrzxqDvQbbVCQ+aUGbh/Oa+Rhcw=;
 b=otkpM4uYIxe5ITq0Nhy7Uiq3AqaVrvalCvUH/Sogd8jxQzWJ2X/hZMlFRYSvfecEcw
 O88zAmUALU1RULmKVZ7HU/1DoNyEcFqrEPLV9e/fwsetZ4VBa4oBoDiJw5ERSFVzIUG6
 XCXjN7r6e9Q8GVfi3wBAgeVxZcp3DYdB/EHMOvT5BgvtLP/tUjoQlRUbfoe7xbf13BBB
 yTbhMPJ2+ZsLHhd0vhKONRTZFAg2PATYe+hSdonBcwz9IpAFHhJIoMXKGJldMMdHRjuh
 7dXOqIskwmHWjEX1+B8K47WDouxI/AS8v79ynyuTr1dZqd6YW66iUElWRpUN8bjvuNjk
 DYCA==
X-Gm-Message-State: AOJu0Yw0EOa/zPaT7FETZdlsPOCBUOdDB90lF00LP5+m1WL1PHCaw8+G
 npHVRRmWqTNIo2WoG3p+HATL1T8EluCEuBMX2EnX+x6z71Pi3wr0rr8cIvzNmfwzje8eccUwp8X
 T
X-Google-Smtp-Source: AGHT+IHdk5RMerXt6xlL7OKXtzLIPevwNSQsVWTfglLFy+cVjQ0DDHmvBq710DZ/D55SqgKGH3hL1w==
X-Received: by 2002:a05:600c:3508:b0:41b:f116:8868 with SMTP id
 5b1f17b1804b1-41feaa38a79mr24859125e9.12.1715338157651; 
 Fri, 10 May 2024 03:49:17 -0700 (PDT)
Received: from m1x-phil.lan (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b79bdbcsm4196331f8f.23.2024.05.10.03.49.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 May 2024 03:49:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/7] hw/xen: Remove declarations left over in
 'xen-legacy-backend.h'
Date: Fri, 10 May 2024 12:49:02 +0200
Message-ID: <20240510104908.76908-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240510104908.76908-1-philmd@linaro.org>
References: <20240510104908.76908-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

'xen_blkdev_ops' was removed in commit 19f87870ba ("xen: remove
the legacy 'xen_disk' backend"), 'xen_netdev_ops' in commit
25967ff69f ("hw/xen: update Xen PV NIC to XenDevice model") and
'xen_console_ops' in commit 9b77374690 ("hw/xen: update Xen
console to XenDevice model"). Remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-legacy-backend.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index 2cca174778..eb22633caa 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -67,14 +67,11 @@ static inline void xen_be_unmap_grant_ref(struct XenLegacyDevice *xendev,
 }
 
 /* actual backend drivers */
-extern struct XenDevOps xen_console_ops;      /* xen_console.c     */
 extern struct XenDevOps xen_kbdmouse_ops;     /* xen_framebuffer.c */
 extern struct XenDevOps xen_framebuffer_ops;  /* xen_framebuffer.c */
-extern struct XenDevOps xen_blkdev_ops;       /* xen_disk.c        */
 #ifdef CONFIG_VIRTFS
 extern struct XenDevOps xen_9pfs_ops;       /* xen-9p-backend.c        */
 #endif
-extern struct XenDevOps xen_netdev_ops;       /* xen_nic.c         */
 #ifdef CONFIG_USB_LIBUSB
 extern struct XenDevOps xen_usb_ops;          /* xen-usb.c         */
 #endif
-- 
2.41.0


