Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D8AEB5969
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 07:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq4Cl-0002C1-Vz; Wed, 11 Feb 2026 02:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vq4Ck-0002Bn-C5
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:00:06 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vq4Ci-0000Hi-DN
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:00:05 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2aad1bb5058so18845025ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 23:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770793202; x=1771398002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f5j2yiDWeQFt4GbN0RcP7q8OZIbEEqiU8pxFT1Ob+ek=;
 b=P1BH5L44feT44eGUcGJvDkJjbLX8MHopA0F02ZMxI7QKcT3bJrufP/Lpe91HTrRcoj
 9gXY03AgMWJEyQWrzmenlBr+w/BWk5QWOtRtliy0EXFuxwY3Gv0pChCawC9z4o6356vO
 h/LVYfCDxmymZrxYGtNbvQt53ZuONHmCCuMoev7UVllvEU1wOMuBBT3UcW59BvTF2hfP
 1vvBdPu7VJDTImNkZMAoal7AQXEq+0Z3625vjrC7aglXP+TnTRreLJ8FwjltP7tySsf8
 Ulz3tPsNAQnDl7RagAXhCoFBTIbx6TT4zs3aRjYPK/ZjofFLBZbsdSAmtNNeUmixFQc/
 GfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770793202; x=1771398002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5j2yiDWeQFt4GbN0RcP7q8OZIbEEqiU8pxFT1Ob+ek=;
 b=PDLHTHrXRMJ2+LKR/Fz+1+N2UgfQkiR2cyZQmSQcXSlGqoKMuv+1vDURFCBencDxIl
 fpfJU1T1aoFC40ca9XTgC3cWtZOWrDtV4cx4zraiWMeM09b6RZQZgisJPJ5coaRThHC3
 zcY4sOJPuJXDtXEnzL54aBRpOPSery7kMCmS0NyyhAfTWlR1eHlhrfEBVSxQqzXkP/27
 PB8lUjkJJOQ8ueSPeGRpdI06w40ZXBK8CKLjlyDhS9uuYVj75JMNDI8ZdFarvTn+QLhv
 DXv+2Ic/WsJ2VzIExrM/EKbY4o1Jek2k7cEJJ44t1nvmxRwQJjwyvIU/xuQL6ptfeP27
 e0uA==
X-Gm-Message-State: AOJu0YytOz8ugtjDhOu3MjlLKQ0sjEMqZ2OG+EKADWzY3u4Wl+nxl8Hl
 3tePHWX02suTGgf1c1OpouCT7AeFq3n+gTiA+vD1o83lnbCoNC6NXml0cctrhA==
X-Gm-Gg: AZuq6aLbrA7MtUyEy6UdTreK5bJZC+9TbLuRH0zufbJQFejyyitc9GKu8j+HXT4mFEL
 isNQjBB+f6PcG8mhVoyRPe9xFwsyNvPfyk2BoXgbsMYfeoPQK4gtDlqAAjCTfaDHmjgVPXI6ryw
 gjwo79LVR0/dO0HD66PdB/Mcj9tayGq+uOiNMT4+mC0Q9avSGNxAzhoD1MTosAgY6rTBZIjURN9
 Tct6I0K8fF//uUeL2KzXOU8NmFU86eT16ADRHZlns1oBeCECn8XvdeQ11m/GW4RKAh6JUPdUdU1
 40AbOKB2zxTIyXVUqY+LRI0Ii1yuMZHnC2sASt86Md8LLKtY7HPXv2uATD+Bx1WdPaoUxfeibOb
 Wq1SrjkZq8TWWTGNGfg+gaxLGAqrE3w5DZEAtKtSEcCZt/+pw2A217HjvjYa5jn3r4Om0X6OMyM
 bJhaYd0hEAA+yOOVI7mXRsCFoR/mtvTD+r5a3t2iL1DjGc06CRJQ==
X-Received: by 2002:a17:903:2443:b0:2aa:e574:d7da with SMTP id
 d9443c01a7336-2aae574dad9mr109969905ad.0.1770793202183; 
 Tue, 10 Feb 2026 23:00:02 -0800 (PST)
Received: from localhost.localdomain ([137.132.26.102])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab2997ac5dsm11494175ad.62.2026.02.10.22.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 23:00:01 -0800 (PST)
From: Choon Keong <ckeong.teo17@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com,
 Choon Keong <ckeong.teo17@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw/i386/pc.c: add description for fd-bootchk option
Date: Wed, 11 Feb 2026 06:58:26 +0000
Message-ID: <20260211065826.3974-1-ckeong.teo17@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=ckeong.teo17@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The 'fd-bootchk' option for pc and q35 machines currently lacks of
description in the help output. This makes it difficult for users
to understand the purpose of the command.

This commit solve this issue by adding description using
object_class_property_set_description() in hw/i386/pc.c,
adding the the description message for the option 'fd-bootchk'.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3193
Signed-off-by: Choon Keong <ckeong.teo17@gmail.com>
---
 hw/i386/pc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5cb074c0a0..eb39c18788 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1822,6 +1822,8 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "fd-bootchk",
         pc_machine_get_fd_bootchk,
         pc_machine_set_fd_bootchk);
+    object_class_property_set_description(oc, "fd-bootchk",
+        "Enable/disable floppy disk boot check");
 
 #if defined(CONFIG_IGVM)
     object_class_property_add_link(oc, "igvm-cfg",
-- 
2.43.0


