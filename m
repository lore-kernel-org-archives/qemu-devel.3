Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F29CC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u4P-00089V-TC; Mon, 21 Apr 2025 12:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4K-00080L-1g
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:30 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4G-0003J1-3U
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:25 -0400
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so62269445ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745253143; x=1745857943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDKbRVQwlLuOOUMYpsyapMZZPBBW7Ei89yj6bKmdEwQ=;
 b=Rty2v+uDGo3FsX53VVMjLnstWqPLh4yZi2ZVLvYjUjz22yJT0Bm7v9hEPC5b4iJcaX
 UK6CvK6/qLPhZGrcxlcyw19AvvsYkZ5xFqQPpshMoY+RFO3+OEHkUv9uLNRBxrZWvKjI
 SuDqfMDDTHL8Y9cZ+5cI29K1YIMdeXpSfUKjihpNp9Oz5x13KieC7ao7jzsUUmjn7SUz
 AHpH04XzS20xp4p8AYop4QFLG9Gz7zIRM9usZulAin1pcwWqWF6tc5qey+eBNUa/46by
 SVcoFZWoBPph1SAuq6EskwQhQklRli3gRQBFWfa4qmed3ckfzXqv/2N2zlvPY06ZUoqx
 1idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745253143; x=1745857943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDKbRVQwlLuOOUMYpsyapMZZPBBW7Ei89yj6bKmdEwQ=;
 b=AjwY260hW7z+wqGvTM+TjZMJT0GR8n1qJRIhS+QEeD8J6yuzlK5Ef3qmkiUROKjgrT
 oulT65yrkz7Sz9/t5RrSSFfSF6Jnf0e7CyHtLNm7kHhUh7aGDn2ikGIGVBcP8sB9MbR+
 5/FQS6zruKLJcwsGPN9b0+43gVj9L4qywX7zeRvZasrbgZW/Kfxm1s0ANia8MP4wkdlY
 4XUQFC3jG9kxu8OnfXYelsLMxtHBVMHlDZF8uIckSPY7neuieOdi9l9s9s5lrUt9q+sa
 kbrjhrv8HLpjuS1gQwZxNRoa2e5SM2TgUQnOwMaVCXrTxyxJx4CqCCQaswud0SwoJeiG
 RXcg==
X-Gm-Message-State: AOJu0Ywz0Uy+08clGm7HZOmSuJgh3rUZnLUQCxu8xp7psPvYM+9jI3o4
 jxHW7qz2e8SKU+mxftyLbmOBbtAlYHLP4iIUi4KixqtCmk6ch8BDZurJnX8cVg==
X-Gm-Gg: ASbGncsiojJ+bWMfobIOfM4nmWaFUyQmYF7dlvvzyrQZGZ1ViI2Y/RKY4202ewr9PYT
 XQHw7z0rZddralkZvhJvApHFn7y7NtfXBrr8/s9o6wIKWy6w4/VexjHmazaqJmOeqN0KProMsYI
 vadby3S+TgWgCBQEhGF6EfSAsX08LKs0wmN1r3x8Mta+JqXYUHnI+GhKhJXWFN92gbNRI1/Gx28
 LNSKfvIYQIeeZUw5ARJa49f+7e7j3dxwX2XKm95oTLlwpZJqOZ9RPVBDT49B1edu5d2ohsYLrAE
 A5W97fv7qPiXhQrKCb01u2QLMHwBqNb3YfBetBpJUu/GUWNPrHP9ww==
X-Google-Smtp-Source: AGHT+IGmYXEXhiJpb3HSDnaQwvWe6t+IzhX0D+7LP3plN/lI1Q6EOXCnoreyscb1u3ZLAXQUIl4MAA==
X-Received: by 2002:a17:902:ec90:b0:227:e709:f71 with SMTP id
 d9443c01a7336-22c535ad462mr191732755ad.29.1745253142687; 
 Mon, 21 Apr 2025 09:32:22 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1997sm67778725ad.201.2025.04.21.09.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:32:22 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 07/11] vfio/igd: Allow hotplugging with OpRegion enabled
Date: Tue, 22 Apr 2025 00:31:07 +0800
Message-ID: <20250421163112.21316-8-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421163112.21316-1-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x642.google.com
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

OpRegion is exposed to guest as a read-only fw_cfg item, so hotplugging
with it wouldn't cause issues. Since OpRegion needs to be set up by
guest firmware, a guest reboot is typically required. For linux guests,
i915 driver is able to mock VBT [1] when OpRegion is not present, the
reboot may not required.

Still, hotplugging IGD devices is highly discouraged.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bb1d132935c2f87cd261eb559759fe49d5e5dc43

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e94ed7029a..e3ff86d0e6 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -549,10 +549,6 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
     /* Setup OpRegion access */
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION)) {
-        if (vdev->pdev.qdev.hotplugged) {
-            error_setg(errp, "OpRegion is not supported on hotplugged device");
-            goto error;
-        }
         if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
             goto error;
         }
-- 
2.47.2


