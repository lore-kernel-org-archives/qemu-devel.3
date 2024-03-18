Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF91C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 17:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmHEa-0000YM-Ut; Mon, 18 Mar 2024 13:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmHEZ-0000Xy-6p
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmHEX-00078t-QB
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710784633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xz5P+39VQaj/6mPsDDXaLw8Q7b0zW3e8IuF4GuVzrt8=;
 b=WaaTa2iY5P/htlOe8LixL+ZqgcLYIBp91whgR7l4gUVCfDrvmNuYHXH4Ff+VbjIENa11Y+
 8utHZb+mXaQElTDcgWOaFxRIDxumlWUjOSQWDfdZkBaOU4w2h1mEP7G1NgT2Io7oDJ85yK
 oXQz0cGx2ZFxBjbwip1zP8xMQo+NxJk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-9mQP87XKOa2J5vJUlnhrKw-1; Mon,
 18 Mar 2024 13:57:08 -0400
X-MC-Unique: 9mQP87XKOa2J5vJUlnhrKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66C7D282D3C8;
 Mon, 18 Mar 2024 17:57:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CA812166B34;
 Mon, 18 Mar 2024 17:57:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 4/4] travis-ci: Rename SOFTMMU -> SYSTEM
Date: Mon, 18 Mar 2024 18:56:55 +0100
Message-ID: <20240318175655.756084-5-thuth@redhat.com>
In-Reply-To: <20240318175655.756084-1-thuth@redhat.com>
References: <20240318175655.756084-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since we *might* have user emulation with softmmu,
rename MAIN_SOFTMMU_TARGETS as MAIN_SYSTEM_TARGETS
to express 'system emulation targets'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240313213339.82071-3-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 76859d48da..597d151b80 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -35,7 +35,7 @@ env:
     - TEST_BUILD_CMD=""
     - TEST_CMD="make check V=1"
     # This is broadly a list of "mainline" system targets which have support across the major distros
-    - MAIN_SOFTMMU_TARGETS="aarch64-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
+    - MAIN_SYSTEM_TARGETS="aarch64-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
     - CCACHE_SLOPPINESS="include_file_ctime,include_file_mtime"
     - CCACHE_MAXSIZE=1G
     - G_MESSAGES_DEBUG=error
@@ -114,7 +114,7 @@ jobs:
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --enable-fdt=system
-                  --target-list=${MAIN_SOFTMMU_TARGETS} --cxx=/bin/false"
+                  --target-list=${MAIN_SYSTEM_TARGETS} --cxx=/bin/false"
         - UNRELIABLE=true
 
     - name: "[ppc64] GCC check-tcg"
@@ -185,7 +185,7 @@ jobs:
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --enable-fdt=system
-                  --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
+                  --target-list=${MAIN_SYSTEM_TARGETS},s390x-linux-user"
         - UNRELIABLE=true
       script:
         - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
@@ -226,7 +226,7 @@ jobs:
           - genisoimage
       env:
         - CONFIG="--disable-containers --enable-fdt=system --audio-drv-list=sdl
-                  --disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
+                  --disable-user --target-list-exclude=${MAIN_SYSTEM_TARGETS}"
 
     - name: "[s390x] GCC (user)"
       arch: s390x
-- 
2.44.0


