Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3481C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnQ-0005pF-Aq; Tue, 23 Apr 2024 11:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn8-0004e9-64
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn2-0000Go-9T
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3mpida+7pBeEIwF72SudzUqBOgjk+1wmiY+VpH0hr4=;
 b=InkxS5U+GsUTEUvLF6xqraL6psuGiX8YL97Xf/hlKbc2nZYqXJi8YPBJFZnvNkGmsgJnuq
 QMqMra3Tje7m7Jldw4I0wy6fvzCEhFYDQtPCIO+3kIaoga9MGH7XKTd1RudtiVXHH1mB12
 HHdlWKP/RifVerd3jkQtt2l88cvSovU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-WtESKvyEPMiKOdSdveQmNQ-1; Tue,
 23 Apr 2024 11:10:30 -0400
X-MC-Unique: WtESKvyEPMiKOdSdveQmNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69C7D3C3D0C8;
 Tue, 23 Apr 2024 15:10:30 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D686A200E290;
 Tue, 23 Apr 2024 15:10:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>
Subject: [PULL 36/63] scripts/update-linux-headers: Add setup_data.h to import
 list
Date: Tue, 23 Apr 2024 17:09:24 +0200
Message-ID: <20240423150951.41600-37-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Michael Roth <michael.roth@amd.com>

Data structures like struct setup_data have been moved to a separate
setup_data.h header which bootparam.h relies on. Add setup_data.h to
the cp_portable() list and sync it along with the other header files.

Note that currently struct setup_data is stripped away as part of
generating bootparam.h, but that handling is no currently needed for
setup_data.h since it doesn't pull in many external
headers/dependencies. However, QEMU currently redefines struct
setup_data in hw/i386/x86.c, so that will need to be removed as part of
any header update that pulls in the new setup_data.h to avoid build
bisect breakage.

Because <asm/setup_data.h> is the first architecture specific #include
in include/standard-headers/, add a new sed substitution to rewrite
asm/ include to the standard-headers/asm-* subdirectory for the current
architecture.

And while at it, remove asm-generic/kvm_para.h from the list of
allowed includes: it does not have a matching substitution, and therefore
it would not be possible to use it on non-Linux systems where there is
no /usr/include/asm-generic/ directory.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/update-linux-headers.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index a0006eec6fd..d48856f9e24 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -61,7 +61,7 @@ cp_portable() {
                                      -e 'linux/const' \
                                      -e 'linux/kernel' \
                                      -e 'linux/sysinfo' \
-                                     -e 'asm-generic/kvm_para' \
+                                     -e 'asm/setup_data.h' \
                                      > /dev/null
     then
         echo "Unexpected #include in input file $f".
@@ -77,6 +77,7 @@ cp_portable() {
         -e 's/__be\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/"\(input-event-codes\.h\)"/"standard-headers\/linux\/\1"/' \
         -e 's/<linux\/\([^>]*\)>/"standard-headers\/linux\/\1"/' \
+        -e 's/<asm\/\([^>]*\)>/"standard-headers\/asm-'$arch'\/\1"/' \
         -e 's/__bitwise//' \
         -e 's/__attribute__((packed))/QEMU_PACKED/' \
         -e 's/__inline__/inline/' \
@@ -155,11 +156,14 @@ for arch in $ARCHLIST; do
                "$tmpdir/include/asm/bootparam.h" > "$tmpdir/bootparam.h"
         cp_portable "$tmpdir/bootparam.h" \
                     "$output/include/standard-headers/asm-$arch"
+        cp_portable "$tmpdir/include/asm/setup_data.h" \
+                    "$output/standard-headers/asm-x86"
     fi
     if [ $arch = riscv ]; then
         cp "$tmpdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
     fi
 done
+arch=
 
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
-- 
2.44.0



