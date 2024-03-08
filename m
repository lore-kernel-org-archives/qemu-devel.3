Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1001AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riawH-0007WV-QM; Fri, 08 Mar 2024 09:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riawF-0007Ui-83
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riawD-0000Z4-0X
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709907063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9w7OrnWjdHq2UoQPMPmpiUmfvtIv8fWk3DyuiCabn4s=;
 b=etvyTMWxTB1QJx1xz4782rZMocZ42ZJFy4PI8ydQRJhrtcSNsNsu9ljZ19OBIWhOzY8SNT
 qJGrVv+WytgsB46J8KI0H5a4if3aqt5ErBkSVyXx3n+po8aTEWTsjXhLKlis6cUYa/savf
 SMhN+pVzlQ9rtwMNY1F1DAspcEUfmBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-PTcFoHU6Pgm8_9gPimL5xQ-1; Fri, 08 Mar 2024 09:10:59 -0500
X-MC-Unique: PTcFoHU6Pgm8_9gPimL5xQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1CD7101CC67;
 Fri,  8 Mar 2024 14:10:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 989FC492BC6;
 Fri,  8 Mar 2024 14:10:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 3/3] target/arm/Kconfig: Stop requiring CONFIG_ARM_V7M
Date: Fri,  8 Mar 2024 15:10:51 +0100
Message-ID: <20240308141051.536599-4-thuth@redhat.com>
In-Reply-To: <20240308141051.536599-1-thuth@redhat.com>
References: <20240308141051.536599-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.44.0


