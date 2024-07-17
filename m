Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A03C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU16v-000138-83; Wed, 17 Jul 2024 05:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sU16t-00011k-1Y
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sU16q-00044n-DV
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721209079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7f/oza70YijrEZXJDsffGjk79Kt9m8p6opZQE8XOAUk=;
 b=dS4fakf4qFfuX4RMLYZ/16Y9Y9SmsKIAKQCUsFwRwYyrqvpsRnr2zdyI5rd/myBp5EWNDS
 +CcX9k0NCqk1Tcvev82T8ddvAopH+LqN2kh0pMpagVNFp2VwKyS5z1YFY1nF7+mTfRWtYm
 MhlfSLQ2FMHLSaPhvq9HpcJWfju4BnE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-sVnwG2eAOOejSAeKj6iBJw-1; Wed, 17 Jul 2024 05:37:56 -0400
X-MC-Unique: sVnwG2eAOOejSAeKj6iBJw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-426d316a96cso47324435e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 02:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721209075; x=1721813875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7f/oza70YijrEZXJDsffGjk79Kt9m8p6opZQE8XOAUk=;
 b=iehxthH+rYAf6ceZ+PX6mvLYMaeL/isLm4yIa/YzqqUfjVV3buYVC9tYJZSoPVlJBl
 mAl2M2z7UR8eLPDaSSDD0/kA7XP3S6nz18TsULumOwnXxnG+lR6X7XyDmAGdXLsgK69f
 TlLk0nPJ7ODY7ltHv8i2uB9a7djVgNpf5sgIFB5whXbT6qb8vMqhT/aUK9NYz3iAOQRU
 eZvzHnGzazCotnpvZB0QYy3Y20WabJCjNprIPqCb3mw9Yl5sb3tveJPOLqvnFfKcIF+f
 GqgFXvpDMVyyXxopSGlCh78LPFRK2dYDbzZfVGIQ7M3AXPShU/ZdUdekBiGNzfa3iax3
 L7dA==
X-Gm-Message-State: AOJu0Yzj/X9H4CirHxBX2HlmFrngDL8RdI9zH91+FhP0rchjQ6GyBXqh
 0kQnNWrdfCOEMv/NSSAqkD147XYI/TNvg3QfELSQQDgz/gLiTDULlpIf2AzFUX9G2+LYgy/H9hR
 CYGBwKr0v0Eb1hEwi9aEWE+SzgYH7shh9UGp6uzA74orFAFTKN4SpSA5RMcdQxUrztQVbFpKeiX
 FN9MmxuxpFs752Y4GY2Oj/M6976dlhO+wTXg4x
X-Received: by 2002:a05:600c:4fd5:b0:426:6960:34b0 with SMTP id
 5b1f17b1804b1-427c2cba1c7mr7057615e9.14.1721209075168; 
 Wed, 17 Jul 2024 02:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2eCXb6WSFPXZ+74bgt/idZY09BtlI7h1SpjjdbtrqfzhrxGqMF/+sJK+N7fBrIALrqXNp4w==
X-Received: by 2002:a05:600c:4fd5:b0:426:6960:34b0 with SMTP id
 5b1f17b1804b1-427c2cba1c7mr7057375e9.14.1721209074362; 
 Wed, 17 Jul 2024 02:37:54 -0700 (PDT)
Received: from step1.redhat.com (host-82-57-51-153.retail.telecomitalia.it.
 [82.57.51.153]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2d6ef8sm196442285e9.39.2024.07.17.02.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 02:37:53 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] scripts/checkpatch: emit a warning if an imported file is
 touched
Date: Wed, 17 Jul 2024 11:37:52 +0200
Message-ID: <20240717093752.50595-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If a file imported from Linux is touched, emit a warning and suggest
using scripts/update-linux-headers.sh

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 scripts/checkpatch.pl | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ff373a7083..b0e8266fa2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1374,6 +1374,7 @@ sub process {
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 	my $reported_maintainer_file = 0;
+	my $reported_imported_file = 0;
 	my $non_utf8_charset = 0;
 
 	our @report = ();
@@ -1673,8 +1674,17 @@ sub process {
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-# ignore files that are being periodically imported from Linux
-		next if ($realfile =~ /^(linux-headers|include\/standard-headers)\//);
+# ignore files that are being periodically imported from Linux and emit a warning
+		if ($realfile =~ /^(linux-headers|include\/standard-headers)\//) {
+			if (!$reported_imported_file) {
+				$reported_imported_file = 1;
+				WARN("added, moved or deleted file(s) " .
+				     "imported from Linux, are you using " .
+				     "scripts/update-linux-headers.sh?\n" .
+				     $herecurr);
+			}
+			next;
+		}
 
 #trailing whitespace
 		if ($line =~ /^\+.*\015/) {
-- 
2.45.2


