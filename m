Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16524C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 00:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTAVd-0003hp-0A; Thu, 25 Jan 2024 19:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3EgOzZQcKChk9DBAD275DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--komlodi.bounces.google.com>)
 id 1rTAVa-0003hG-Nu
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 19:55:50 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3EgOzZQcKChk9DBAD275DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--komlodi.bounces.google.com>)
 id 1rTAVZ-0004pJ-58
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 19:55:50 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-290ec4dc888so1588631a91.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 16:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706230547; x=1706835347; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=t6nHIN8ORZr9i+Uh/2rlB1Fk1t/dXzyBMvWw71XqxkM=;
 b=2wldsIPq4GitC13FRnSLw7nSGKi+eke8oTHBakKEJCSVX7HmL1c0OIafXodom+7uwJ
 EM5xA1OW+EW+RYLXohvNvljRCOjiapqR9CdfKStfG688wyYCa4IRG3+HewT+EaFg3AHh
 VrbE6MzbnI8icisE+M56khVtu0OqHSrc0O9Xz1OsVSmlZknwjbblOMS93QJRDZ3t8AhJ
 Jkgn7mQ+9yEgAOtltvJ5VA91LbtaY+PI3UTyoA1cc75z+YcjlYRs96CBT3T7kTt24CM+
 6zEvFVsUwgQieSEcDjbz19Aceuk4esv/4mg6a1cpY9vkpAMmgZ6tH/Y1BcNZaVrheioZ
 65Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706230547; x=1706835347;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t6nHIN8ORZr9i+Uh/2rlB1Fk1t/dXzyBMvWw71XqxkM=;
 b=AXgrSeMheb8+55Mokk9YK+PqdfkNGD6ddbmlV/Btsz+0Kq+EDsTQg24gm6U7KdRahk
 nnPuxdNhGMsMpMhAwda69kQB4YA60XQTb6WllGdT+E9gYfWY/Ee3IRh9f2ijgydqJ5DI
 j/HnmxPxwNMnm492zvkONDiMZM43BR2H4l0INVnjuVSQoJlufbSKGv+PhnghpHVChHV9
 X5VomYUz9jv47Oux06byjFpvcegoIQZhXqMpEhVywKpNlMpHtqN5q6sXQ8z4fMS9jfUc
 MiB8o5NaT57YwfXQ4DR7LQBlPIcfhMMpeoESp4IB0Gzh+0fWtTSxNTAOZtDLckUCfMAj
 Xa5Q==
X-Gm-Message-State: AOJu0YxHA0sAGmi4OSYmKWDeSgJUuD/u2KYEqjp1g7FCdcNzH2Ij5ch6
 K9OrbGmu9jHzUrvDL3Kyi2k/evoUsyMKpCJlzH7x9LLnI58B5ODGAMp6J3xrZvj+MxB5YEAimks
 KXeJdLYW+0up8R+DbDW2gHQ4IOp01tOnTKnYRhiXOEM2ukmVcJ45qN7V+oIHbxlw41n3yC4Yt2m
 xEPGCbSVjceh6LECYeZMjeyYLOznoZ+50a1lzi
X-Google-Smtp-Source: AGHT+IFp2LpxYYrJvB4R5vrluaMbJOzvU6S96NbgWaeyY2e38DGPBa00cTxYrid0pMQN2EERI9Zztu4f52UW
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a17:90a:bd0d:b0:28d:e0f3:9ae7 with SMTP id
 y13-20020a17090abd0d00b0028de0f39ae7mr13363pjr.7.1706230546884; Thu, 25 Jan
 2024 16:55:46 -0800 (PST)
Date: Fri, 26 Jan 2024 00:55:40 +0000
In-Reply-To: <20240126005541.1839038-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240126005541.1839038-1-komlodi@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126005541.1839038-3-komlodi@google.com>
Subject: [PATCH v2 2/3] hw/i2c/smbus_slave: Add object path on error prints
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3EgOzZQcKChk9DBAD275DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--komlodi.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

The current logging doesn't tell us which specific smbus device is an
error state.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/i2c/smbus_slave.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 1300c9ec72..e24a1ef472 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -25,11 +25,15 @@
 #define DPRINTF(fmt, ...) \
 do { printf("smbus(%02x): " fmt , dev->i2c.address, ## __VA_ARGS__); } while (0)
 #define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__); exit(1);} while (0)
+do { fprintf(stderr, "%s: smbus: error: " fmt , \
+             object_get_canonical_path(OBJECT(dev)), ## __VA_ARGS__); \
+             exit(1); } while (0)
 #else
 #define DPRINTF(fmt, ...) do {} while(0)
 #define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__);} while (0)
+do { fprintf(stderr, "%s: smbus: error: " fmt , \
+             object_get_canonical_path(OBJECT(dev)), ## __VA_ARGS__); \
+             } while (0)
 #endif
 
 enum {
-- 
2.43.0.429.g432eaa2c6b-goog


