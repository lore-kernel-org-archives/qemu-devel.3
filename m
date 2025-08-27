Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2616CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKCO-00065B-GX; Wed, 27 Aug 2025 13:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKCL-00064D-Rf
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKCD-0006PX-C3
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756316664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zcf8TqjQ3/yb5B8qCAtMZmdycxDGMaqAUOgRT7KKKOI=;
 b=LobYFTP0/qzn1wI2ZTW9+UilWyGjDFhiE0BMTC/8KsJVd3LwZz5KD1QvQjsr/cy65oDpIS
 siHhDLdaiTGbfeUp+AS8IntX7LvVP4C5Nh9TPhEzwvAAGv2sODfGvHuqWLiCZ/Z/yndd+M
 DpSBk/jZRmFq2MYMQpylJ3MZkVQ5ilA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Wh1ZJD7VN3WQVGnJn897PA-1; Wed, 27 Aug 2025 13:44:23 -0400
X-MC-Unique: Wh1ZJD7VN3WQVGnJn897PA-1
X-Mimecast-MFC-AGG-ID: Wh1ZJD7VN3WQVGnJn897PA_1756316662
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b05d251so288675e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 10:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756316658; x=1756921458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zcf8TqjQ3/yb5B8qCAtMZmdycxDGMaqAUOgRT7KKKOI=;
 b=O+JZp0ZcCGKZbGZ17Shs3SRhUqw142adtNy8VdmtzFT/t0oeFjsd+X8y+lYTVPe+A2
 o35i3YxGlT5Va1+jEPr8Zoue9TyQYJnOTXeSqo0hrSSE7giKWaq17fZ3QffybiBW/D4N
 ZzAoR+Ly7P3SUxK+tBOY2a3LYX7Y2/Y1X4Z2maj3ih3MsgRuxjojOvZJu4sXMMZZlSt6
 sen5aXV1EX3glDCzZL0hzBx5Z+wZ6pwla+bPmAM+UwvaOvBSCBi9pV9KelSn9Npgi33S
 jhBUEAntRAEocGqMv2i3ZbvZ9IQD8VAABTmYmYG3NyxDJyNGPjeT+1cqfx9XCyoqNCSM
 47aA==
X-Gm-Message-State: AOJu0YwnjKAEYWbtA5gLra5Ma5KMCTH+eYZSlfQ9WS6XIn5DOAL79rXf
 K67cmAQoy3V57ojUdjY5ReoORbcpsPi2CCoInz8UDxCDjZJrb4P8TMj6cyNt9guuquUnCgEd/qL
 sd7GNSqi1o7NvQVxDvYGzDudHcNNPC3vpp4Xm99qfpl7yVvjdvZq6DMhKg23D9ZuTU066gpxCBL
 A/ilJx97VtgwzC791PP0SGCR51V5t6jR59jvWduXUg
X-Gm-Gg: ASbGncvU7lLvbxYEOoWBAm4QNYO4t7cvp5NE4TziVB4FLQlQtcUJQUG9SnLsj7KSyJi
 29IF9ru/SV/ywSmZpdKr7bGvaCq9RZidiDrlrqwy3h1eMFkps+o0W/SjDGX1z4iwkaaGSYUm/bl
 7npWV8GNXRgLKdGZnNpIIeYSL2NkoSkLYE1XyWX1LX5SClbbnctSFLomttWyNyXYQWBgErbnR57
 u8IYVgLXg3e6DTyaG2lnUqdhbMWIjmHvVj18sCSAP8I148nUdvq5oEym8s6VwC4waE+tFUbFhxC
 U4wOSqxa3+8Vih13iX3l3d3uYQK536d/w5rxJgw1Sti2bHpFYT/0NejDjwJdKCPBoB+c/62fAPv
 cEOz8d4IALCDw7+KwmO08U9xlKihVPJsY1URE0iXw2is=
X-Received: by 2002:a05:600c:19cd:b0:456:db0:4f3d with SMTP id
 5b1f17b1804b1-45b517b9571mr218758955e9.24.1756316658606; 
 Wed, 27 Aug 2025 10:44:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzxwVEzXsrXnidhUzgVN9WNKpE4UBE4ViKz3g7At9m/OGwqx+811uLXsKsFpnLdFoNq5UnCg==
X-Received: by 2002:a05:600c:19cd:b0:456:db0:4f3d with SMTP id
 5b1f17b1804b1-45b517b9571mr218758745e9.24.1756316658143; 
 Wed, 27 Aug 2025 10:44:18 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b736b7068sm10330075e9.5.2025.08.27.10.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 10:44:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2] MAINTAINERS: add a few more files to "Top Level Makefile
 and configure"
Date: Wed, 27 Aug 2025 19:44:13 +0200
Message-ID: <20250827174414.814138-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

A few files in scripts, and the list of packages in pythondeps.toml, are
strictly related to the toplevel build scripts.  Add them to the
MAINTAINERS file stanza.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed762..0f3e55b51e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4392,7 +4392,6 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: meson.build
 F: meson_options.txt
-F: scripts/meson-buildoptions.*
 F: scripts/check_sparse.py
 F: scripts/symlink-install-tree.py
 
@@ -4403,6 +4402,9 @@ R: Thomas Huth <thuth@redhat.com>
 S: Maintained
 F: Makefile
 F: configure
+F: pythondeps.toml
+F: scripts/git-submodule.sh
+F: scripts/meson-buildoptions.*
 F: scripts/mtest2make.py
 F: tests/Makefile.include
 
-- 
2.51.0


