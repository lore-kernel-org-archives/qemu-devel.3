Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25F0C982FB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lsQ-00072N-Kd; Mon, 21 Sep 2026 17:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lsF-0006lz-Oj
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:32 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lsE-0000R2-B5
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:31 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so18639505e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027299; x=1790632099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=notC94T4bNBsCvNTC7YA0uXb459RvcuTT7pI85Z8gIo=;
 b=S75sLXuWhVt0Dp3fosO6g6qRUNbMZ+l4acxKGdAKUCmZjf+q1f/ESDAAfmR1QXc8OP
 yWNgmmQU+c7aaQxCEEY7lDRAfdrE1GfyzxgQ4L1tJ8t501Vfs3QOvFOy57MTTqf44uRv
 wNpgyVVXxxG7PnXSJK7tNJNvDIuu4xRp4wTfFWQ/SGjbuDkIOKAx5uHS0YPJxRoQotC1
 dEpUPh0UP0CTOoWz0/8Y1ujJuGR9nSpSoWyDjAeAF8gl+JCm8DjDGMyjQijmNB2iMVlb
 XBobXAOiRWH4LWi6aX48pZz5w7Y+nC68UVSG8/TR7rcWLvNPde7sOFX7svxgsh/CoBnS
 Zxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027299; x=1790632099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=notC94T4bNBsCvNTC7YA0uXb459RvcuTT7pI85Z8gIo=;
 b=L7LTDr2qrDbhI6oQNeV0vKehd9QZUG2YfAXgNsoL2YUURh5uRS0ZwN0vg1D3cLhVg4
 04q3HjvWryAOsNeqADjk7SqnfMua8WbeJrfk+RV9ZHAeC5f+8DvQX/okViuJ+JEm+eeg
 7xiZ7C/F32OjSqHWsmtDeAwZeO3M/NSIp5LqKRzCWCpIv6YGq2nYphtEB1cfwn/Z+gxf
 hT+6VdkZxutek0Teess72RO/I7JhghLdkKiO+PkK+4IWHpXPBimZ64ErntYXxCrA4ZcC
 Euz660F7/haxPGlpp4ZqNMHAufqtP9XnCUV9/lSvkffQD92lfMt7YZtbdy3H2uPO9Ct6
 SekQ==
X-Gm-Message-State: AFuF++lTZRgD2AQ1HQHgalJqSO1OJh/LClCa5zDlNF2f1X6uye0+DxZt
 VrYaaG1EztoA7hbYPVGojUXqNhbNe7MF5Jfy07Sle1yT9ck0012F/sGNJFGviw==
X-Gm-Gg: AYBFou2DVEWcQYEGlFm8FG2ZTSvKrNDqJDNswzKu5TeWLs+3h64OKCXIlxXZ9VeniQM
 gPFofTdGO+NVy5oYqlF8krRhd22SYTtYzoPFjUG3kUTiTebmnlv5x4YQBcJg2QPxQ4+iVTndade
 RMjaWqRR/bIgttnmo8smOh2gAZjVpzysdii8YvZQyrx83twQ+OKYQZYbDHFzdXu7Q8gHYvsTvAg
 Kc1pKD/Cdr0fONilTQsyKWFd6CafM0JboNpscfyouIuGBtjOW7GRvF/rXnpiw+AWmbAeCEINtHl
 Uituz65mCTEljfZRl2c7KUWUSLhPWJwPygT81gnKvkPXOPFhJlyBixopJDzKiDCOCLSACxDYkwR
 q9StYMSxfYTIzXbveojSNJ95rdt+j4Iwh3eSuEpm0kZjEHy+B8+Fceo163plf/TEuZNEqhnkE+t
 KslwwgLOjy2lJh8ALa3BLsefKXG9oXtujyvUGclLZeVOLEgr+tkQ/T0aCqxNIwZdmUO3sISLJDp
 fvwCXM5Iic/Sbo5QvsV036nFzI61lVDehV67RcC2dAwrSlTHCI+z6ENAx+naG34Eh1YO5ZbjFsJ
 tbU=
X-Received: by 2002:a05:600c:3584:b0:49c:fc6e:a3d9 with SMTP id
 5b1f17b1804b1-49fc584fa71mr223737155e9.24.1790027298896; 
 Mon, 21 Sep 2026 14:48:18 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:48:18 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 39/42] hw/usb/imx-usb-phy: Avoid casting from void *
Date: Mon, 21 Sep 2026 23:47:07 +0200
Message-ID: <20260921214710.29422-40-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/usb/imx-usb-phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/imx-usb-phy.c b/hw/usb/imx-usb-phy.c
index c25566d0fa..2b2913c387 100644
--- a/hw/usb/imx-usb-phy.c
+++ b/hw/usb/imx-usb-phy.c
@@ -49,7 +49,7 @@ static void imx_usbphy_reset(DeviceState *dev)
 
 static uint64_t imx_usbphy_read(void *opaque, hwaddr offset, unsigned size)
 {
-    IMXUSBPHYState *s = (IMXUSBPHYState *)opaque;
+    IMXUSBPHYState *s = opaque;
     uint32_t index = offset >> 2;
     uint32_t value;
 
@@ -108,7 +108,7 @@ static uint64_t imx_usbphy_read(void *opaque, hwaddr offset, unsigned size)
 static void imx_usbphy_write(void *opaque, hwaddr offset, uint64_t value,
                              unsigned size)
 {
-    IMXUSBPHYState *s = (IMXUSBPHYState *)opaque;
+    IMXUSBPHYState *s = opaque;
     uint32_t index = offset >> 2;
 
     switch (index) {
-- 
2.55.0


