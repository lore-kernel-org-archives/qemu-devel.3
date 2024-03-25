Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C21DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rol48-00032k-8H; Mon, 25 Mar 2024 10:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rol45-00032R-F9
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rol42-0005mn-9t
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711375957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TC7zX4WQgoLSn6ZIKyojaDdAE/R2hLhtQDyrGtIDMkU=;
 b=W664l9gp/DT4/kHTxj1eK58pxM2it9r9i4lstVYkzazixks8ispPVulUkPYccsV8FkshbX
 sBlfcbEdoJ0EVFNs7Glfi4a46hUyqzOnN+BvNBW9ojgO70G9UGTvqCV6yQO8LJN4+jd+5N
 S2nCXvXTlGw5bSA4QxFDtnALgKSQ1as=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-oPEluuF7N6OAOmjxTxtPSg-1; Mon,
 25 Mar 2024 10:12:35 -0400
X-MC-Unique: oPEluuF7N6OAOmjxTxtPSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 062A328EC11D;
 Mon, 25 Mar 2024 14:12:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32D463C20;
 Mon, 25 Mar 2024 14:12:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/9] .travis.yml: Shorten the runtime of the problematic jobs
Date: Mon, 25 Mar 2024 15:12:02 +0100
Message-ID: <20240325141210.788356-2-thuth@redhat.com>
In-Reply-To: <20240325141210.788356-1-thuth@redhat.com>
References: <20240325141210.788356-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The "[s390x] GCC (other-system)" and the "[s390x] GCC check-tcg"
jobs are hitting the 50 minutes timeout in Travis quite frequently
since a while.

To fix it, we've got to drop a lot of the targets from the target
list in the jobs to make them work again.

With regards to the "check-tcg" test, we can move the check with
"s390x-linux-user" to the "user" job instead which also builds
the s390x-linux-user target.

And while we're at it, remove the "--enable-fdt=system" configure
switch (since this is not required nowadays anymore).

Message-ID: <20240320104144.823425-2-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 597d151b80..a8d1e12190 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -184,8 +184,8 @@ jobs:
           - genisoimage
       env:
         - TEST_CMD="make check check-tcg V=1"
-        - CONFIG="--disable-containers --enable-fdt=system
-                  --target-list=${MAIN_SYSTEM_TARGETS},s390x-linux-user"
+        - CONFIG="--disable-containers
+            --target-list=hppa-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
         - UNRELIABLE=true
       script:
         - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
@@ -225,8 +225,8 @@ jobs:
           # Tests dependencies
           - genisoimage
       env:
-        - CONFIG="--disable-containers --enable-fdt=system --audio-drv-list=sdl
-                  --disable-user --target-list-exclude=${MAIN_SYSTEM_TARGETS}"
+        - CONFIG="--disable-containers --audio-drv-list=sdl --disable-user
+            --target-list=arm-softmmu,avr-softmmu,microblaze-softmmu,sh4eb-softmmu,sparc64-softmmu,xtensaeb-softmmu"
 
     - name: "[s390x] GCC (user)"
       arch: s390x
@@ -240,6 +240,7 @@ jobs:
           - flex
           - bison
       env:
+        - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --disable-system"
 
     - name: "[s390x] Clang (disable-tcg)"
-- 
2.44.0


