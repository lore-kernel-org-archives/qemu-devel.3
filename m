Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F36E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2u-0000q1-UD; Fri, 10 Jan 2025 13:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2E-0000GG-K8
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2A-00017z-NU
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6XkrDw8kJ0urdDIGPNF7dyGN4vEh7W7PLxyHD9bMc0=;
 b=eak63UM/WZ0LeNrYojY/85u1xpJAYSXIgtb7/wDou8gBukz4zf/0aRs7WLwy8lf5+iETbB
 pHcyBgB4Bd14A7CRRDqOqvOgCk6WEHRfgPJhJHveiE6s0pfVoJwExM8Y9fYHF37Q0Cgn9e
 RwtVUQzCaRKrfFQgf0MX94juXMec6ss=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Jgp3aVYmNHOJdqjRaNu_BA-1; Fri, 10 Jan 2025 13:47:00 -0500
X-MC-Unique: Jgp3aVYmNHOJdqjRaNu_BA-1
X-Mimecast-MFC-AGG-ID: Jgp3aVYmNHOJdqjRaNu_BA
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aaf8f016bb1so201343166b.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534818; x=1737139618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6XkrDw8kJ0urdDIGPNF7dyGN4vEh7W7PLxyHD9bMc0=;
 b=oNvvG+jFwpN6qFFSNLla6AucRStkXyejE5OuQFyHmUk9q5gO/qQNVW5llX9MZNMxZu
 shVNOKwLFBE9IQOFG3thFTZihycmnzhHIXGjjT2CATWpuZbbLBRidgqNyLp+kIisSRsu
 lyOLvqHfSJTwhYl/v9rp9Lsl7d4cf29ZXvipziPCT9KoVnd6/DgYbQFNH0iDcvm26+Yy
 c3XXs2BsciRuAOYiExrbo74zZ0WK7j51TVZeIeOe5Q6hl9sNctqODM8OfBsmqyZOXmBr
 lVuTI+kSSvi/V0vmvqQ30/IFDDBAPB2SwtZdSzQ4U3mJ82yuURSxyIOtkuSUgQjQArU7
 4GjQ==
X-Gm-Message-State: AOJu0YxwkWO266ua71fxYDIVm1e85XdZ8mzKsKoIwomLzabShJ3wcGYN
 C5bRTTFTFJt/U30fr+sS9K7dsailizdwKs5JaYliVG4vktFy3G08pXI3mswJIiD6pSggn1l3e7u
 V+1UhuQhVuOSWcK5/duBgwpt6Nfng8EK4iRxgvdCtbVdzfD/tvbBt7h1EW755ZjPJ2YCSoBzBEy
 h4q8Wn7L6XO2Byq7oBN69WZxWpbZZOtXCf/Wggxp0=
X-Gm-Gg: ASbGnctxtuCL44LG9JgaYi/lUbzRrsEC4kcyRS/nekkHujMvKHeUnS4vSVS4y9rZkeq
 5FptipnJ9g7MZEBliwxpJkvHuzLuKbUQ3HwoZ1MDmC8w860log0PJ1yKeW2VrG8xcYj0u0b0fqh
 oHjF1bi52g6ZbTS0Fx243gJDnENIxZoV0VvRFItG0hV9EE83MOHZHDj3bP9wp52HzbWRVE4eCF2
 AKXL36GVpNgBQiQotPjk6vgDd9A5VhJ0tYUUNsHyz/hFMrDPAJAyAca+l8=
X-Received: by 2002:a17:907:3e9e:b0:aa6:a572:49fd with SMTP id
 a640c23a62f3a-ab2abdc0262mr1198578066b.54.1736534818639; 
 Fri, 10 Jan 2025 10:46:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYEMhI0YzgUraPEZEgdXI+yEOZm99hSqlIjBdY8coVoxSYFMiXRDZ9Wo1R8u8hlxP1qgBWJA==
X-Received: by 2002:a17:907:3e9e:b0:aa6:a572:49fd with SMTP id
 a640c23a62f3a-ab2abdc0262mr1198575766b.54.1736534818174; 
 Fri, 10 Jan 2025 10:46:58 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90da0fcsm192073766b.75.2025.01.10.10.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 16/38] make-release: only leave tarball of wrap-file subprojects
Date: Fri, 10 Jan 2025 19:45:57 +0100
Message-ID: <20250110184620.408302-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


