Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CBDC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 08:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTHlE-0000PB-MT; Fri, 26 Jan 2024 03:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTHl4-0008I8-5M
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 03:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTHl2-0002Sv-7n
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 03:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706258415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FUNbVaBu/SiP5r0/ed6gLwfPO+g3hM0qy/lnk4SkiUY=;
 b=edRJEBF6Vx92r3qF96riYCWTathOmpmn3omQ7G60EJNp3k8oyh7FbSTaEOV3u7IcQ3T3qO
 MdJaLrDGPmp+YPUzQQEaLFd0sDEJXUrXMXTPrY6Y8wff5u6Olt444PeMjg/Exgi0sclPkf
 O9WJMe6PXipRNmFTRY4U16mq3gyAp0s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-z1ypT6w7MxSWQIlaV5mW1A-1; Fri, 26 Jan 2024 03:40:09 -0500
X-MC-Unique: z1ypT6w7MxSWQIlaV5mW1A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CF86185A780;
 Fri, 26 Jan 2024 08:40:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5810492BFA;
 Fri, 26 Jan 2024 08:40:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] target/arm/Kconfig: Stop requiring CONFIG_ARM_V7M
Date: Fri, 26 Jan 2024 09:40:01 +0100
Message-ID: <20240126084001.879548-4-thuth@redhat.com>
In-Reply-To: <20240126084001.879548-1-thuth@redhat.com>
References: <20240126084001.879548-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Now that we made sure that ARM_V7M code only gets compiled if really
needed, we can drop the hard requirement for CONFIG_ARM_V7M in the
Kconfig file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/arm/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/Kconfig b/target/arm/Kconfig
index bf57d739cd..3fffdcb61b 100644
--- a/target/arm/Kconfig
+++ b/target/arm/Kconfig
@@ -2,10 +2,6 @@ config ARM
     bool
     select ARM_COMPATIBLE_SEMIHOSTING if TCG
 
-    # We need to select this until we move m_helper.c and the
-    # translate.c v7m helpers under ARM_V7M.
-    select ARM_V7M if TCG
-
 config AARCH64
     bool
     select ARM
-- 
2.43.0


