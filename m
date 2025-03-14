Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC6EC35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 15:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt77c-00088r-Ua; Fri, 14 Mar 2025 11:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tt77O-000868-OB
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 11:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tt77K-0000jb-Hc
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 11:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741966711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JQGKBKXOHH2Mv9+V7IawRGJ4zdTputDRJl6j1G+R1vY=;
 b=CJHi4niE/Ji2He8sE8Y288hzurXMbfOt2MUj4JdKI7Fk8rlGhEIsuAmKgfLmz2KMrg07iJ
 pnJSZw5rOk80dqHhKt+l6GJ8jwHzYsW3Z8G6oUEU9oc20NuZ+KenDfdglCuwZv4bl5TBXg
 tPf/91hGWS9Jr/T4/fbabHibnYodfwg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-FZxnOOizPGKWrfYrbA-9TA-1; Fri, 14 Mar 2025 11:38:29 -0400
X-MC-Unique: FZxnOOizPGKWrfYrbA-9TA-1
X-Mimecast-MFC-AGG-ID: FZxnOOizPGKWrfYrbA-9TA_1741966708
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac31990bdfdso175153266b.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 08:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741966707; x=1742571507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JQGKBKXOHH2Mv9+V7IawRGJ4zdTputDRJl6j1G+R1vY=;
 b=lnuHdGb084VF0th8FBu3bfNZHOzxPu56hlACVx+BJx2z3H+m4tHa0+nJVl5+SGVG39
 RVrPo/e2lY7z7tF04lbQniSs69r5grniJ9Q46mKuDUhTcLZmq9ZRDLlD53Opq0AM3rGx
 tKLSsb7tAtcfNaIJdSCuBC7D6vNBJl5V+ZD5ilqbN7IGbsSyPelx2Tnef3eFG5mDI4gK
 fTsjE/GNL+KxKyeljuhvZbYdAN9JU/l7jPmeUjN5G0cztXQMSJHh6MfKy1ETPPE/mqXx
 An3s4fVIyabGAaG2U8LCltSCWnpOIIAA8cJgXIWGaW+lp6cSw+KNWlUgUTIaYGnFAf7t
 sTmg==
X-Gm-Message-State: AOJu0YwPHwozrb1sqmLe5ccLU0uZyYJdmEGisAY383/5egcxoxnVUQQS
 agu+j439z4Aaf/nEFUamxzsakfj0ZXJ/Ng47IWfjGRjYJ+KCJG5CwoztqFpBi4rb168RnqitpVu
 SFCNssEaMSml5sohoWEsa93oJCNOnBxt2ZUmp6mQU67AHEfkLACEz/8zeCa4PXVob1gtHEAFOfV
 E0PSSL6PZHT+uul2QusgWMs3HEKRt1bhmkGPQK
X-Gm-Gg: ASbGnculchmR4WBy9fwXwqtb+CXONjG7Dj/atTEqxLNC4g0GGo6SY0QWzmBhB+T5LWU
 Wv+PHXel2vhdUgEH4cAz/+6rmZomi+3fIQhyIc8ZPB26Guw2JXpr0LbU4LAXe/RLL3OeNZjYviO
 IVzG7Qpqxtz7I2/17OV2lVMinMCXvZ5Cw3rJ7l+kyqVqgGuIEFsO3Ntd/A4o8giBx3eIcIZuVBf
 n534ZkzNVNQufUZI5I5uIDJiPiO+n7oU59ESmSYZMY5GLc+qGcpn4XrN3Bkol/RK3/mqY2neW1h
 59OlAEqyhIiwVYogmsrJLQ==
X-Received: by 2002:a17:907:7296:b0:abf:641a:5727 with SMTP id
 a640c23a62f3a-ac33011254emr386759466b.7.1741966707385; 
 Fri, 14 Mar 2025 08:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmbm2sdwmCW5oIfsx52R1GqMfrL6A4Kls67if0hoIjCwyECr9XUPhSf7NojVF9Wphh9gwKFQ==
X-Received: by 2002:a17:907:7296:b0:abf:641a:5727 with SMTP id
 a640c23a62f3a-ac33011254emr386755866b.7.1741966706930; 
 Fri, 14 Mar 2025 08:38:26 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3149d0bc1sm241147566b.105.2025.03.14.08.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 08:38:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] configure: disable split_debug on Windows and on non-git
 builds
Date: Fri, 14 Mar 2025 16:38:24 +0100
Message-ID: <20250314153824.65303-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

-gsplit-dwarf is reported to produce broken binaries on Windows.
The linker produces warnings but exits successfully:

/usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld:
qga/qemu-ga.exe:/4: section below image base
/usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld:
qga/qemu-ga.exe:/24: section below image base

and as a result qemu-ga.exe fails to start.

On top of this, also disable -gsplit-dwarf unless building from git.
Similar to -Werror, split debug info is probably not the best choice
for people that want to build for installing.

(Random thoughts: there is a tension here between adding an option
that is useful for QEMU developers, and messing things up for everyone
else by doing something decidedly non-standard.  For example, distros
are starting to create a fake git repository just so that they can
use "git am" to apply patches; while some of them, for example Fedora,
are wise, or paranoid, enough to pass --disable-XXX for everything and
then turn back on what they want, it cannot be expected that everyone
does this.  It may be safer to make --enable-split-debug default off
for everybody and add it somewhere in docs/.  For now I am keeping it
enabled but we could consider doing something different during the hard
freeze period).

Reported-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure         | 4 ++++
 meson_options.txt | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 02f1dd2311f..9aece67ed08 100755
--- a/configure
+++ b/configure
@@ -1864,6 +1864,10 @@ if test "$skip_meson" = no; then
       { test "$host_os" = linux || test "$host_os" = "windows"; }; then
       echo 'werror = true' >> $cross
   fi
+  if test -e "$source_path/.git" && test "$host_os" != "windows"; then
+      echo 'split_debug = true' >> $cross
+  fi
+
   echo "[project options]" >> $cross
   if test "$SMBD" != ''; then
     echo "smbd = $(meson_quote "$SMBD")" >> $cross
diff --git a/meson_options.txt b/meson_options.txt
index 3432123fee2..f3546b9abc1 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -362,7 +362,7 @@ option('debug_mutex', type: 'boolean', value: false,
        description: 'mutex debugging support')
 option('debug_stack_usage', type: 'boolean', value: false,
        description: 'measure coroutine stack usage')
-option('split_debug', type: 'boolean', value: true,
+option('split_debug', type: 'boolean', value: false,
        description: 'split debug info from object files')
 option('qom_cast_debug', type: 'boolean', value: true,
        description: 'cast debugging support')
-- 
2.48.1


