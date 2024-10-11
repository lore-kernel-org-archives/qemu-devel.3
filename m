Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37480CFD2E4
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 08:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szB7f-000351-0n; Fri, 11 Oct 2024 04:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szB7c-00034o-Pr
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szB7a-0005gB-UO
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728635737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=G5kIcRFA38/+mHvsnhBT5k4Ky00HLdTEYJyCgu1xduY=;
 b=fPMNmDUh6nwa1/o1ZFZqKbqfW+Qi3yNqeriYxF6OnPCnKvA+Di/quLaJSasZmDbnUvJW83
 QGFJIbNaC3fPuF4RrHI82N9HFau/o5L/63dXmHRuyGJBJSo5dpiphl47/79FNzzddPoDKP
 nki96BuE/dSOnwRGkZDW8swsbwHsrrY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-K8Eo9QKmPTmD8AXQlk6-0g-1; Fri, 11 Oct 2024 04:35:36 -0400
X-MC-Unique: K8Eo9QKmPTmD8AXQlk6-0g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c92ad674aeso1248594a12.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 01:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728635734; x=1729240534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G5kIcRFA38/+mHvsnhBT5k4Ky00HLdTEYJyCgu1xduY=;
 b=oe1qaTxEmfzG35kLoAsrG5AD/0wglExUZIkhgADknzQftAPxx6CSuzDtOpSSLmSRIh
 ClkbCrhSaB5RHn7bKuNfQ+tWKzfJF/4Qv6SxBD+zNhUBZO6o5GW3Ij0Q/PFyN5lJ9FcO
 Q62OPgrgRisp8V5RoEp7QlvaQ3ZPfntF+lgKqoTewp3ANIkysJUb3Vp4Wc7RAMD9fide
 g/G0/a91whMZFzqUe5Y7RhuRuv+l/EDnitD0J3VvkmqIOrFyOHDGFBZvkY6hL+fHj0tC
 uYir7h6ucZNJy9IpVOAFM1CjA3/wHDjVhKbRlonpX5o1iF+xiydhnBlSIIRMCaVY1Sa+
 b/uA==
X-Gm-Message-State: AOJu0Yw9lW9SsXguGFhyQE5HT3Yb7y7o/GrJ5Dp4yr7hjUEWbmVVGQ1h
 +7WITPT+L99c4lOOzaj3LGCmvaubYI53xjGNP+2pZOldW0rxkOHjxcj5j2Vv9gYBOlKhwxEv/pZ
 RBnyXkivwzsJzAEMtPdksv35am69gssRVdiddBa1g75q0JaPihIK8V8x3CZ3+v2hgCVqnchUuUr
 VhZ70V2n8tA5MX4/a21OFTlqsuVpPILWaNIsRVMNM=
X-Received: by 2002:a05:6402:4347:b0:5c9:5665:8df5 with SMTP id
 4fb4d7f45d1cf-5c95665905amr79660a12.34.1728635734510; 
 Fri, 11 Oct 2024 01:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOya3Y0Hc/cyLMozmr0l3wDKaqCclQoNEvU3D3tVF/gkpyoebJoWWEVJaKn3SbfNL+wpG57g==
X-Received: by 2002:a05:6402:4347:b0:5c9:5665:8df5 with SMTP id
 4fb4d7f45d1cf-5c95665905amr79643a12.34.1728635733976; 
 Fri, 11 Oct 2024 01:35:33 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c937263299sm1682535a12.77.2024.10.11.01.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 01:35:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2] scripts/archive-source: find directory name for subprojects
Date: Fri, 11 Oct 2024 10:35:32 +0200
Message-ID: <20241011083532.15023-1-pbonzini@redhat.com>
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
v1->v2:
- put local dir on separate line
- use :- to print default even if $dir is empty
- use error function and invert "if test -f" condition
- simplify sed script to avoid jumps

 scripts/archive-source.sh | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 65af8063e4b..3f9c51ce2cb 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -48,13 +48,34 @@ function tree_ish() {
     echo "$retval"
 }
 
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
 git archive --format tar "$(tree_ish)" > "$tar_file"
 test $? -ne 0 && error "failed to archive qemu"
 
 for sp in $subprojects; do
     meson subprojects download $sp
     test $? -ne 0 && error "failed to download subproject $sp"
-    tar --append --file "$tar_file" --exclude=.git subprojects/$sp
+    tar --append --file "$tar_file" --exclude=.git subprojects/"$(subproject_dir $sp)"
     test $? -ne 0 && error "failed to append subproject $sp to $tar_file"
 done
 exit 0
-- 
2.46.2


