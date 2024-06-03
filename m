Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE93C27C52
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7Ti-0000A6-2U; Mon, 03 Jun 2024 09:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE7Th-00009u-6E
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE7Tf-0005iA-7n
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717420311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K8sRrq8CDbQFy7vjSuLZFAIC6W/dUE+vt5wdceje7Tk=;
 b=CU605/9lP0Jj7kL9hfxxKr+7CjbunDITxdAF8Z+GZMBwISf3qjIX+Nr4ov7TcGhozu4vEV
 dJC+jme+e7D0qAxuFUFbl4XdqP9WzBYi7rDxjmeCfcGu8ZL8GYZtyQDC8cT6/1RZsV3P3y
 CNhAfmcIFOFvyUWonposJb+uqenSAnM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-oaqgXhXcNk6Eh4aV4c201A-1; Mon, 03 Jun 2024 09:11:49 -0400
X-MC-Unique: oaqgXhXcNk6Eh4aV4c201A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6266ffe72eso224916866b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 06:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717420308; x=1718025108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8sRrq8CDbQFy7vjSuLZFAIC6W/dUE+vt5wdceje7Tk=;
 b=XC/BpA76SyAt9FIoBSB/0Z2Jbek9wiZivpLClBk9wE4N+eW3h73kVQnueRKP6NtqdP
 jcs+ABIuH6IIIFyaUpuOQvHXZ+XLmwAYOmLKyhe6Buw8RqcLK9lVsbs9E57q+pHPMR7n
 ATJrHixeOJrjZGPi1lkk6MBiV6mciKmI/xFVqDrOAS9pbLX9bDWJ+ZM4ZsSJmR9duzDC
 zPZ/XIwLymtRe0aN7Va+xgKmi0pCPM5PEKRGa1/Z2zJMc4fUtgDxSxCuoCyEuVt6l2Bh
 jnLwVF3QAXMiFitgHArIrb+tvO2aLsIyhQ1ZeGGFlozgc2OOcmCwxEv2EBPWOPf/T2OZ
 ofaw==
X-Gm-Message-State: AOJu0YxGWK3DyD09DPcP45oEuUF86Izor871Vp/UGwY0Vx1jPnam/xfl
 eUBMBUbXqv7hJB/z+bTQFMmP4hB7OwT5iD0DjbOaKIHw0iO2BuN++iT0Q7JKhswIvYUZODBofxX
 GVSEhqmoqYQO7BWrr0G6gZdo9TxvogCBvIaLJ6Cnraw7wpbwOCEnO54nfTBLqTXvJXf0F5NqdRf
 +F80Nd+H0XwMTDYtEWNnKhktsAvZ7ri0v9GozE
X-Received: by 2002:a17:907:9483:b0:a68:f6b7:1fe3 with SMTP id
 a640c23a62f3a-a68f6b7227emr322309666b.43.1717420307775; 
 Mon, 03 Jun 2024 06:11:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkHyweoTFv/cdB0aSV2AF1OXm3QrLQ3m7rYETUkuVaK/Z9a/o5CLecbThQqQ+oCX9Sefj88w==
X-Received: by 2002:a17:907:9483:b0:a68:f6b7:1fe3 with SMTP id
 a640c23a62f3a-a68f6b7227emr322307266b.43.1717420307135; 
 Mon, 03 Jun 2024 06:11:47 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a691628de55sm119468466b.74.2024.06.03.06.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 06:11:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	cohuck@redhat.com
Subject: [PATCH 1/4] update-linux-headers: fix forwarding to asm-generic
 headers
Date: Mon,  3 Jun 2024 15:11:38 +0200
Message-ID: <20240603131141.834241-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603131141.834241-1-pbonzini@redhat.com>
References: <20240603131141.834241-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/update-linux-headers.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 23afe8c08ad..ae34d18572b 100755
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
+            # not installed as <asm/bitsperlong.h>, but used as such in kernel sources
+            cat <<EOF >$output/linux-headers/asm-$arch/$header
+#include <asm-generic/$header>
+EOF
+        fi
     done
 
     if [ $arch = mips ]; then
-- 
2.45.1


