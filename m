Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC33CF11FA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 15:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syukz-0005kE-1i; Thu, 10 Oct 2024 11:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syuks-0005ju-1n
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 11:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syukq-0003wf-4m
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 11:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728572822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wiwq679JEAjrG+n3FKaI9imuyg7RL0s3zXOf/mltAHA=;
 b=YUuDwOs5hPujyl9NZ3FJPCtJJDfcBrGPE3xBiQh0Y7duhXpLnGLGQ70NSblaEQHSqvQXRX
 M7dTwRxgEtu6a7VPTAHFr0k+nBthMoWMcAMOXmCHIxqUJv9Ubh3nwU0hkquIWLhenEvyYi
 GCxXHFb+c/rUDLKNfWn/MCJASHK1w+I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-slJyD2WENVuPFYJsdbRfrQ-1; Thu, 10 Oct 2024 11:06:58 -0400
X-MC-Unique: slJyD2WENVuPFYJsdbRfrQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c937403b2bso534847a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 08:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728572817; x=1729177617;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wiwq679JEAjrG+n3FKaI9imuyg7RL0s3zXOf/mltAHA=;
 b=oGHwMnWs+/ebaToGB3J2vv8PgEI8YID6bZnls1Fw7MNnYok7rT/8yqIL0EBb8NRIKD
 nx38PW/owRLfJGycHzz2BjbxkY5Ypl016+OIUsgWUKeDTiTRKVF3c8Y2msHIBhakk9C+
 sooJAr1MVtsDRPEutKCdcmQlMjJi1NCSfP3KdyUpLpOKJUCHlvDYgP0aYgp8t/uEoO+0
 pUCpjGq+cxqfgP7pfCpM3ZjYjIE+rKCUaIh763fZyC/sAQHQ9F/TWeJ85WbyCobShIW7
 Jr/Be9AJJPCvyssnOX5rl4YOhTrTqOHlNX1aVF+mdyL87riBSZf2vnHsJNPiCyVd7wAa
 T6gw==
X-Gm-Message-State: AOJu0YyEKgSscqjTRi0CWKs7VA+FKQgxVeuDiYRfM/fLeI6zYrr+de/b
 xzklqzFZdL1VNzNoNRxmIPJtQ7jmIJzW6FjYDIxYChzNawF+2CVrMyZ0lb0SktICd4jNfcCNooo
 rJl7nc75XkecmxwwaFnX9Dqh1fKo3nezDmbrFCANp2NYNEGiuhNCZBeR4d4B8z5qjgrn/p+fSdm
 flTKZGGmnYQq+s/5/lxuAvLeIdj0t8kjcaNo6XoMM=
X-Received: by 2002:a05:6402:5d4:b0:5c2:609d:397e with SMTP id
 4fb4d7f45d1cf-5c91d59f573mr5242368a12.15.1728572816271; 
 Thu, 10 Oct 2024 08:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9r88dHKSTRwu7E0bYzqdFFOBr2m9VpgLOvIsHb4d4AsGOwmt4dHJC5/Lz21PFM5L1+1Ohbw==
X-Received: by 2002:a05:6402:5d4:b0:5c2:609d:397e with SMTP id
 4fb4d7f45d1cf-5c91d59f573mr5242322a12.15.1728572815527; 
 Thu, 10 Oct 2024 08:06:55 -0700 (PDT)
Received: from avogadro.local ([93.56.170.251])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c9370d2251sm894711a12.12.2024.10.10.08.06.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 08:06:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts/archive-source: find directory name for subprojects
Date: Thu, 10 Oct 2024 17:06:52 +0200
Message-ID: <20241010150652.1814677-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Rust subprojects have the semantic version (followed by -rs) in the subproject
name, but the full version (without -rs) is used by crates.io for the root
directory of the tarball.  Teach scripts/archive-source.sh to look for the
root directory name in wrap files.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/archive-source.sh | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 65af8063e4b..7c7727eab58 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -48,13 +48,33 @@ function tree_ish() {
     echo "$retval"
 }
 
+function subproject_dir() {
+    if test -f subprojects/$1.wrap; then
+      # Print the directory key of the wrap file, defaulting to the subproject name
+      local dir=$(sed \
+        -ne '/^\[wrap-[a-z][a-z]*\]$/!b' \
+        -e ':label' \
+        -e 'n' \
+        -e 's/^directory *= *//p' \
+        -e 'tquit' \
+        -e '/^\[$/!blabel' \
+        -e ':quit' \
+        -e 'q' \
+        subprojects/$1.wrap)
+      echo "${dir-$1}"
+    else
+      echo "error: scripts/archive-source.sh should only process wrap subprojects" 2>&1
+      exit 1
+    fi
+}
+
 git archive --format tar "$(tree_ish)" > "$tar_file"
 test $? -ne 0 && error "failed to archive qemu"
 
 for sp in $subprojects; do
     meson subprojects download $sp
     test $? -ne 0 && error "failed to download subproject $sp"
-    tar --append --file "$tar_file" --exclude=.git subprojects/$sp
+    tar --append --file "$tar_file" --exclude=.git subprojects/$(subproject_dir $sp)
     test $? -ne 0 && error "failed to append subproject $sp to $tar_file"
 done
 exit 0
-- 
2.46.2


