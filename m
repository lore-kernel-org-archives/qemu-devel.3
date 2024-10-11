Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2100D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4W-0001C4-Q0; Fri, 11 Oct 2024 13:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4T-0000hD-Q4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHdg-0007ED-C0
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZkqswzW9dFZWPavxaROlpLneVmZFWmvHp+0g7ynwSbY=;
 b=dLU/SH20uKiMkgHHwTaeULNshPXh1RIMzI1Mbuiyp6MiumOSrnN7kx/8BdUVBLuZvyg0j0
 vnsjk1q1usnaGh+9Gg00DgjmZUkd+to4X/NWkB1qaMOSRaGoAjq0iaAEu07ZQ01nfz66WX
 bzinYDwvPu3e8Arh1nNdad7osTvB1jM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ddqFp_4SNqGvn9cKxfPi6A-1; Fri, 11 Oct 2024 11:33:09 -0400
X-MC-Unique: ddqFp_4SNqGvn9cKxfPi6A-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5c94ccfb210so517741a12.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660787; x=1729265587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZkqswzW9dFZWPavxaROlpLneVmZFWmvHp+0g7ynwSbY=;
 b=NK4sCZqVvVGtJqDBPbG2Ey8k5ZNr5lV0tmQUmn1Z6Cva8u3pyvtdWQs7crox97g2ig
 /zPtd+LBt2DO6RQsCbUs6Y8x/s3bXYYHOaMaaNckBLlLpXf5y9hanYaB29c4hkbJwZJA
 AJEwO4x+bfpdS85wb2wf4RcyliluqoCxVQKb0lVUI78lIp4kNeLeQ6bmOvCMrVpPPioG
 WqzV/rGbGs+0W9juTqKVTk++JVU/DX2NDtrRnFCZrrYp01OnDfzQN+4RnjpyxQCM52aO
 gLf7jQ8y6HVgWx0votdPO3VeBz4lAU5dXCf1MIkEqV5ZO6dF+doQO6cocrxsb24N3nlC
 5G3g==
X-Gm-Message-State: AOJu0YzqcVa3l+GHCa3JgHAw8Lmmx5knHpeVuiA6bfCIsUO1oyWxsr+1
 hgmZ8CwDf1FqypRRTab2ZOY1/wYp9FmdL2Brug2ZR+wfpbmi67glJIYl5iByWd1r/ycG2UpPgvj
 TkGM5GpHrtxuxoIOAACvuqxpNcALf5BQbBM7ktbRpF+vFy39IqecwfmpR+GKJ6puK/+q+qqsX1k
 v/frRLZi8EctWOVZMtjj/4IZjtgTVfxkWJbrDakH4=
X-Received: by 2002:a05:6402:2684:b0:5c8:9f6d:8af2 with SMTP id
 4fb4d7f45d1cf-5c948c73849mr2040124a12.4.1728660787579; 
 Fri, 11 Oct 2024 08:33:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXVyRxwrIetUmaCIy/oNcOv1DtpcDzzC5z/nXVSSjrsfiR1RDGmHtE3sDzuIrny3K//+8ZmQ==
X-Received: by 2002:a05:6402:2684:b0:5c8:9f6d:8af2 with SMTP id
 4fb4d7f45d1cf-5c948c73849mr2040098a12.4.1728660787044; 
 Fri, 11 Oct 2024 08:33:07 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c937119cb7sm2018030a12.36.2024.10.11.08.33.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:33:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 08/18] scripts/archive-source: find directory name for
 subprojects
Date: Fri, 11 Oct 2024 17:32:16 +0200
Message-ID: <20241011153227.81770-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
References: <20241011153227.81770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Rust subprojects have the semantic version (followed by -rs) in the subproject
name, but the full version (without -rs) is used by crates.io for the root
directory of the tarball.  Teach scripts/archive-source.sh to look for the
root directory name in wrap files.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/archive-source.sh | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 65af8063e4b..9d9b2e2d5e2 100755
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


