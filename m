Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49866C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGyH-00058W-AO; Wed, 29 May 2024 06:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGy4-0004yL-0k
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGy1-0003Ll-Pa
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2eTsiktoorRHNlqcrXrMdLgmU0SE5j4uCz6Wn2IZPMU=;
 b=fdeVRdIhH6FkP7xQFbvmGDBrjoyRngA8dffgIALdfxJg7SkfdKBzNcKOkfBDKXUVVImrCH
 GTlrxCb7c9bc47mxP4Lzv1dZdXnn7sYOYEFSeW5U/HPSdPXdi58U9szm7bV+eX6XRTQeJB
 1wm74J/qSSxaiNCDsU9MFOhpIKwMRkA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-tZz2g-iJNPiidtxKXVOitQ-1; Wed, 29 May 2024 06:55:33 -0400
X-MC-Unique: tZz2g-iJNPiidtxKXVOitQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C260185A783;
 Wed, 29 May 2024 10:55:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44D6D1054820;
 Wed, 29 May 2024 10:55:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 19/22] scripts/update-linux-headers.sh: Fix the path of
 setup_data.h
Date: Wed, 29 May 2024 12:54:51 +0200
Message-ID: <20240529105454.1149225-20-thuth@redhat.com>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
References: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

When running the update-linx-headers.sh script, it currently fails with:

scripts/update-linux-headers.sh: line 73: .../qemu/standard-headers/asm-x86/setup_data.h: No such file or directory

The "include" folder is obviously missing here - no clue how this could
have worked before?

Fixes: 66210a1a30 ("scripts/update-linux-headers: Add setup_data.h to import list")
Message-ID: <20240527060126.12578-1-thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index fbf7e119bc..23afe8c08a 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -159,7 +159,7 @@ for arch in $ARCHLIST; do
         cp_portable "$hdrdir/bootparam.h" \
                     "$output/include/standard-headers/asm-$arch"
         cp_portable "$hdrdir/include/asm/setup_data.h" \
-                    "$output/standard-headers/asm-x86"
+                    "$output/include/standard-headers/asm-x86"
     fi
     if [ $arch = riscv ]; then
         cp "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
-- 
2.45.1


