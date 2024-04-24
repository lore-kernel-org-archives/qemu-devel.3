Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD12C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXW9-0004hT-Vn; Wed, 24 Apr 2024 03:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXW6-0004gj-UC
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXW5-00031C-D3
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0dr1j/EciOeGG75/QBW6MCzl6uEWgRvXyxkSn1jYg4=;
 b=VxcmKsx9q938+tjgp/NM9jxZe98v3KNJbU3sSceNJQiJzykb8jssC0k8J+eGfHvhy4XHEd
 c/VcQK7n7Ee+juCzyONnLSsp8s3wKrWXjsHc7cr4to9JxABZJBCS44UvgZicrUp4dqWbdh
 cT+RBatmV5xbsdZfsCqUZf4BHUtrrt8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-AMdsYHeHORWUoJx24RwY7w-1; Wed,
 24 Apr 2024 03:58:05 -0400
X-MC-Unique: AMdsYHeHORWUoJx24RwY7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5F463C12824;
 Wed, 24 Apr 2024 07:58:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04F753543A;
 Wed, 24 Apr 2024 07:58:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/17] .travis.yml: Remove the unused UNRELIABLE environment
 variable
Date: Wed, 24 Apr 2024 09:57:24 +0200
Message-ID: <20240424075735.248041-7-thuth@redhat.com>
In-Reply-To: <20240424075735.248041-1-thuth@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

This variable was used to allow jobs to fail without spoiling the
overall result. But the required "allow_failures:" hunk has been
accidentally removed in commit 9d03f5abed ("travis.yml: Remove the
"Release tarball" job"), and it was anyway only useful while we
still had the x86 jobs here around that were our main CI jobs.
Thus let's simply remove this useless variable now.

Message-ID: <20240320104144.823425-6-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 8da88c4360..196725d5a3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -113,7 +113,6 @@ jobs:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --enable-fdt=system
                   --target-list=${MAIN_SYSTEM_TARGETS} --cxx=/bin/false"
-        - UNRELIABLE=true
 
     - name: "[ppc64] GCC check-tcg"
       arch: ppc64le
@@ -184,7 +183,6 @@ jobs:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers
             --target-list=hppa-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
-        - UNRELIABLE=true
       script:
         - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
         - |
@@ -274,4 +272,3 @@ jobs:
         - TEST_CMD="make check-unit"
         - CONFIG="--disable-containers --disable-tcg --enable-kvm --disable-tools
                   --enable-fdt=system --host-cc=clang --cxx=clang++"
-        - UNRELIABLE=true
-- 
2.44.0


