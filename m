Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095AAC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuj-0002xf-DD; Tue, 04 Jun 2024 02:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuf-0002v4-QJ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENue-0007HX-An
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZD7vE8gF0Y5V60aNmYypp+fbL0TaGRRhrBUq5pD118=;
 b=W0J8LUcG+pzyuaE0oCbEoFAd+vYNj7+xcncCQMX7jne5xkegytVRgGKTkUbsxbhV4iYKJA
 umUIq4KeOn+1NIzd9j5OVUvc6nBPsShnK3nxlyKG3mDdbVmZdDESp9MXKg87tD63tP2X1o
 gVWGiGPjZX8TqDt7i9HicNYZY5bIcLI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477--zeLSUPGOkuo_YpRDpFGOQ-1; Tue, 04 Jun 2024 02:44:49 -0400
X-MC-Unique: -zeLSUPGOkuo_YpRDpFGOQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a68ee264225so92309566b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483487; x=1718088287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZD7vE8gF0Y5V60aNmYypp+fbL0TaGRRhrBUq5pD118=;
 b=Wa0UElhzy6NkttQ1UukY+W2sDGI5rtc+wghzEJlndLvrR9LVNaiPPOipEfTG9oPpOn
 1ewKr0e/X7aXfRQxQI5sNx1twoiE3I7TecusLtbb47MmYHF7n6t/uako+DCWKrXCBGHD
 PVNw/rTEnKiwlsKnQ+tFYQDK6SM7xL2VrCJKmBe6srd/SunWlbZDmoaWqdUK0j8zcXxV
 tASVuxvqJNrbsBCCEYxO8tVnjHNJVSnMucw9q0Jyf3sSBiydVB4ZkPgfgYIASPniPmhc
 VRa77KUwPQa4Og+G9LuNKPYFGqA3uW51+kX9772K35+ayRkrA3/5Thcl4Hz6rZHgiI90
 4DJA==
X-Gm-Message-State: AOJu0YzYzyBaoTVSSVs6IkJu9GLl+i0zGUZ1FWHIN0UmR0fRQHSxYYUX
 hqXJ3Z77bEUe2oaOcQJvlz62GnrYZD6zGx7ra2a6no6PxKgFnAdxB9JSczsxK/G3A8glrC6FLYM
 hD42tZ7Ch6qEFKaMPEMsxkP6cUqy3RjI+9BZXics1R453DLM5VXR5ATGNs9UQdoy+HlrO9e77NU
 wcY+oolIeKFc8TMmYLaF6mjJv4qISGu2abpRBo
X-Received: by 2002:a17:906:2a91:b0:a68:689e:db4c with SMTP id
 a640c23a62f3a-a68689ee2bbmr623275566b.55.1717483487691; 
 Mon, 03 Jun 2024 23:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHawltmXHutgxyWDFfJ1efGdkkpjDIfu12XRUbKoZlS462Y24DI7nx7gWSwhO8jRNOv5/v3BQ==
X-Received: by 2002:a17:906:2a91:b0:a68:689e:db4c with SMTP id
 a640c23a62f3a-a68689ee2bbmr623274166b.55.1717483487291; 
 Mon, 03 Jun 2024 23:44:47 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68e1bcfb95sm382718966b.107.2024.06.03.23.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 12/45] update-linux-headers: fix forwarding to asm-generic
 headers
Date: Tue,  4 Jun 2024 08:43:36 +0200
Message-ID: <20240604064409.957105-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Afer commit 3efc75ad9d9 ("scripts/update-linux-headers.sh: Remove
temporary directory inbetween", 2024-05-29), updating linux-headers/
results in errors such as

   cp: cannot stat '/tmp/tmp.1A1Eejh1UE/headers/include/asm/bitsperlong.h': No such file or directory

because Loongarch does not have an asm/bitsperlong.h file and uses the
generic version.  Before commit 3efc75ad9d9, the missing file would
incorrectly cause stale files to be included in linux-headers/.  The files
were never committed to qemu.git, but were wrong nevertheless. The build
would just use the system version of the files, which is opposite to
the idea of importing Linux header files into QEMU's tree.

Create forwarding headers, resembling the ones that are generated during a
kernel build by scripts/Makefile.asm-generic, if a file is only installed
under include/asm-generic/.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/update-linux-headers.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 23afe8c08ad..57a48837aa4 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -118,7 +118,14 @@ for arch in $ARCHLIST; do
     rm -rf "$output/linux-headers/asm-$arch"
     mkdir -p "$output/linux-headers/asm-$arch"
     for header in kvm.h unistd.h bitsperlong.h mman.h; do
-        cp "$hdrdir/include/asm/$header" "$output/linux-headers/asm-$arch"
+        if test -f "$hdrdir/include/asm/$header"; then
+            cp "$hdrdir/include/asm/$header" "$output/linux-headers/asm-$arch"
+        elif test -f "$hdrdir/include/asm-generic/$header"; then
+            # not installed as <asm/$header>, but used as such in kernel sources
+            cat <<EOF >$output/linux-headers/asm-$arch/$header
+#include <asm-generic/$header>
+EOF
+        fi
     done
 
     if [ $arch = mips ]; then
-- 
2.45.1


