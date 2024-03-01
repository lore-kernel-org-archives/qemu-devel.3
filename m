Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5541C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg83l-0005Yi-C0; Fri, 01 Mar 2024 13:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1rg83j-0005Y6-AO
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:56:39 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1rg83h-0003w6-Qr
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:56:39 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dcc86086c9fso2671977276.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709319397; x=1709924197; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IgXDeRMCN6gCmWkZM/1UMPs+fYvQ58DJDLgGotCHQoU=;
 b=ei6rZeK4fSQNmV5YN0Of6+rwgfvBEJxUiAxqeAg8c4MNswBFmpMuz4J0+hjmbT9ne6
 mhIr2MyazOhm4cKrH/vflTsO7fd8o4srSqLmvfCsIQYLNYWcCRDqpWUMtfqjoph5uSBe
 zJmcK1xDGGZd2bA0myCrVvv5MjXoKeUpOQIRk7hPxiSmQiOUw9/9Ss8JPonEc7wFtm8l
 aFRl8aqJpWW+HaFgfCx2ydkAyGyXvnR6UC64VVHMb51PyqbwWruluJZVptM6hQ04A0jR
 XIrguZ8BMSRyQvS/xE5a1fUe016uecJAoW/5scDpCWgXo1cFqwVvkM9/vIfhQsWH/yL4
 GHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319397; x=1709924197;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IgXDeRMCN6gCmWkZM/1UMPs+fYvQ58DJDLgGotCHQoU=;
 b=lxpxs7/dkWKoo/RvBSmKCBE64OtUSh1QlsfzuYxIpTete7Ixx/l7pYJFMuWZZhk/dZ
 AsegUAgRV6nJvIpdogib8xEHNgVCl+jdN/snT8tWHFiuU1mhhrFCVB0TLAgpRcNbf3pF
 cr22Pre/bwweFs2QbJPtxcOY+y6wl8pnsNAjEUjPput/PTZbmGOdbNv2JFB91ockczjG
 Ggv3raTuyxO3AfRYUZf2zaE/meeCq5ARA9xXqP6EIal7RKrn6QVYufCMcmZbex9g4ItS
 ONJ+SYCiKkwYtWUj+6cqYCC4nLpl4bbaVefsGgJGAS5iaGOsjBe7u4XgKnjc9kjA5vhj
 +3bg==
X-Gm-Message-State: AOJu0YwUZJLoCerYmigUCilh8PXze7i88YNxcrVcFXrtQnMpgnn2Zc3/
 FqvqZrPHrzcX24H8za3z4TamToCmywfAztR71dUdwhpZan5ojG0eaF9LgnPQTNKHK5mDyMCFUVk
 0wCcXK0qkXKSRN9b6wcOfoSUZzTdschagDHCVIA==
X-Google-Smtp-Source: AGHT+IHSy0nW8ADVzY828WRopg95rU3RPOm3abHUe1x0tp6I4vHg5s6e2ZjxPopzFsmYhzg6zX+Q7UPZvxrLl5mkUsc=
X-Received: by 2002:a5b:502:0:b0:dc6:b121:d00c with SMTP id
 o2-20020a5b0502000000b00dc6b121d00cmr2464858ybp.16.1709319396713; Fri, 01 Mar
 2024 10:56:36 -0800 (PST)
MIME-Version: 1.0
From: Frediano Ziglio <freddy77@gmail.com>
Date: Fri, 1 Mar 2024 18:56:26 +0000
Message-ID: <CAHt6W4cH+=pyxNZ9F_8Yed4K_pYfO-qP6iNHQHEYLvWUk+aGUw@mail.gmail.com>
Subject: [PATCH] Make some structure static
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=freddy77@gmail.com; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Not used outside C module.

Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fa387f043..a1522a011a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2558,7 +2558,7 @@ static bool vfio_display_migration_needed(void *opaque)
         (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO && vdev->enable_ramfb);
 }

-const VMStateDescription vmstate_vfio_display = {
+static const VMStateDescription vmstate_vfio_display = {
     .name = "VFIOPCIDevice/VFIODisplay",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -2570,7 +2570,7 @@ const VMStateDescription vmstate_vfio_display = {
     }
 };

-const VMStateDescription vmstate_vfio_pci_config = {
+static const VMStateDescription vmstate_vfio_pci_config = {
     .name = "VFIOPCIDevice",
     .version_id = 1,
     .minimum_version_id = 1,
-- 
2.34.1

