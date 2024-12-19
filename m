Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3281AE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 10:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tODlA-0007vp-Oy; Thu, 19 Dec 2024 05:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tODl8-0007vW-7i
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 05:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tODl6-0004Ae-M5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 05:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734604075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+6XkrDw8kJ0urdDIGPNF7dyGN4vEh7W7PLxyHD9bMc0=;
 b=SGJbLvAz/n5+ukUDMnh1YYcUzGmJoGgfOIVH1ihxzltGizVRi0AWXWDF0/+gGgcVSVuEWQ
 lE2O1vMLQHFs2K/LdwXdPl/Alkvkjl7SIpAtjtWAD/z2boTevwoaKfzy2fo3OXspPk+saD
 IF7s1Ex+JkW7qbucly4Vkw96SJ5rMeE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-VPWAn8cEOZ2AyvuOFgLeoQ-1; Thu, 19 Dec 2024 05:27:54 -0500
X-MC-Unique: VPWAn8cEOZ2AyvuOFgLeoQ-1
X-Mimecast-MFC-AGG-ID: VPWAn8cEOZ2AyvuOFgLeoQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3862be3bfc9so431587f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 02:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734604072; x=1735208872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+6XkrDw8kJ0urdDIGPNF7dyGN4vEh7W7PLxyHD9bMc0=;
 b=O2ASRcK3DKvPhRqgDQTnhG6j0mA2iB1J5e/tbqDDskcuV9jrjSnhBE6IPQmfjJH4U1
 ixGBN7HuXYLxQ6QJkB1KOt4YsdmNeYOeVg6QNzdKofZnxqc0KvLD/h7zk9DafIzFydiE
 czfU3oqolo0VwJtkkDsWe2fvaou2eYVEVlQUubXa/Y7Sn+f0wZemFjs1dg8HgvqqJQb9
 NCl9AfZ0isTgfb+UUwqMk6ePPE3xilFHxx7fxx0GVT6YS5cc5u6FCDE3Me9iRcCcsPrS
 dI+nhVulasKqpOsvjQbO6cz78t+TeqKNymKGn7Zk1rIoeg4kGYhgLD+DjqnUXtkYHnBs
 8gmg==
X-Gm-Message-State: AOJu0Yxuan2pdmvdQMCcDkrTF3Bvsm1CCdGMQk6Mp8s0gpIoT0ZhMbqO
 qp+nHxH1XMmLfoyD+nOTSvk+FsF+en8OXEXC0SOJXZ6ij+y4m2qPTGvyh3LSt1Cl729Ek6nwA0Z
 oCJiUCSSSKNPMeTsM8H6YloFB0hQ9CxhMKM2vMpPtcBD384bUAnVHn/pownJsJsYm/lVlLINPQJ
 YSazwjohsfWq3d27ypGrEj3FvlbZ9wk4Qq/gqZ
X-Gm-Gg: ASbGnctLAAjjLmWK4/mshn1TgryKMGt4OBjy6QFal2+9NY7WI0fl4BvWcbH2oAHOqzX
 N8k6Mto0u1YS+wKpqEmqeBUGbGdMbE6lktTOgS9ueo4kz5TGMQpO6Hz5NIBpY7ple0HxQeTsEoS
 FKhC3IxUIWDQ2xMH4xXZFhS+RxxeZ+B50ptBifLiq5rTVvubi3sSRGCj1kp51F+jxB19i3ll/zS
 UK+qyjlqpJiuUchvaJ5dsuujfJPNnV4avwYGMDvlQ6j4ip/R8Xi7yJtGVcj
X-Received: by 2002:a05:6000:2ca:b0:385:fc70:7f6 with SMTP id
 ffacd0b85a97d-388e4d2f5c6mr5695039f8f.7.1734604072635; 
 Thu, 19 Dec 2024 02:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb+tP3gcT7am95giwc/k2L+XC1VBzsuloIZMAYJm0lpmRtIuepP9bbI5OAPDXBTOCFEtbJ/A==
X-Received: by 2002:a05:6000:2ca:b0:385:fc70:7f6 with SMTP id
 ffacd0b85a97d-388e4d2f5c6mr5695014f8f.7.1734604072142; 
 Thu, 19 Dec 2024 02:27:52 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828ba0sm1215686f8f.14.2024.12.19.02.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 02:27:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] make-release: only leave tarball of wrap-file subprojects
Date: Thu, 19 Dec 2024 11:27:50 +0100
Message-ID: <20241219102750.389885-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The QEMU source archive is including the sources downloaded from crates.io
in both tarball form (in subprojects/packagecache) and expanded/patched
form (in the subprojects directory).  The former is the more authoritative
form, as it has a hash that can be verified in the wrap file and checked
against the download URL, so keep that one only.  This works also with
--disable-download; when building QEMU for the first time from the
tarball, Meson will print something like

    Using proc-macro2-1-rs source from cache.

for each subproject, and then go on to extract the tarball and apply the
overlay or the patches in subprojects/packagefiles.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2719
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/make-release | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/scripts/make-release b/scripts/make-release
index 8dc939124c4..2885e872109 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -10,6 +10,27 @@
 # This work is licensed under the terms of the GNU GPLv2 or later.
 # See the COPYING file in the top-level directory.
 
+function subproject_dir() {
+    if test ! -f "subprojects/$1.wrap"; then
+      error "scripts/archive-source.sh should only process wrap subprojects"
+    fi
+
+    # Print the directory key of the wrap file, defaulting to the
+    # subproject name.  The wrap file is in ini format and should
+    # have a single section only.  There should be only one section
+    # named "[wrap-*]", which helps keeping the script simple.
+    local dir
+    dir=$(sed -n \
+      -e '/^\[wrap-[a-z][a-z]*\]$/,/^\[/{' \
+      -e    '/^directory *= */!b' \
+      -e    's///p' \
+      -e    'q' \
+      -e '}' \
+      "subprojects/$1.wrap")
+
+    echo "${dir:-$1}"
+}
+
 if [ $# -ne 2 ]; then
     echo "Usage:"
     echo " $0 gitrepo version"
@@ -51,5 +72,13 @@ meson subprojects download $SUBPROJECTS
         CryptoPkg/Library/OpensslLib/openssl \
         MdeModulePkg/Library/BrotliCustomDecompressLib/brotli)
 popd
-tar --exclude=.git -cJf ${destination}.tar.xz ${destination}
+
+exclude=(--exclude=.git)
+# include the tarballs in subprojects/packagecache but not their expansion
+for sp in $SUBPROJECTS; do
+    if grep -xqF "[wrap-file]" subprojects/$sp.wrap; then
+      exclude+=(--exclude=subprojects/"$(subproject_dir $sp)")
+    fi
+done
+tar "${exclude[@]}" -cJf ${destination}.tar.xz ${destination}
 rm -rf ${destination}
-- 
2.47.1


