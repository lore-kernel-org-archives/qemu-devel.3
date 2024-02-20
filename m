Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55603C54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLBL-0000jK-Uv; Tue, 20 Feb 2024 03:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLB0-0008VN-Aw
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLAk-0000d7-R9
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIuuW+wdt/l3qwd+9X1fX+swjCEROfFuJY+nqWv9slw=;
 b=W0TtFNVDp2RbGdHlN7WPSMFqrsQKXvKpzS2YE9oBP9jTTkxyNeAWq7uHT2jmI/aRioq+Kd
 7blUiKAQbQVL5Cs18U8xhg8WFXwPeKItMF0/Fmdf3aH3ZbZ989bH9iVpvAJy2tMKx0EsTX
 LURyDMvAR5eqFnw1iVWGAuT1o1jc/BE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-WT4OC1-HMxWFaUd1NH2beA-1; Tue, 20 Feb 2024 03:08:11 -0500
X-MC-Unique: WT4OC1-HMxWFaUd1NH2beA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3bdd99a243so488653366b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416490; x=1709021290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIuuW+wdt/l3qwd+9X1fX+swjCEROfFuJY+nqWv9slw=;
 b=kqJsoVhNTbgUjmGTjvfnn3Cgyp/sXrHReinm+ux8tiCCbL4TD7QAkOxebcYLjOvZAN
 B8s0MBPaH9kXC6K/7NayqwebMHDkSFL1dyLLHBQizgzIW3wtVn2tdJeJhj7IcVfr89OQ
 91++mjoeW4K/AOi6Z4tlTMTtSSxX2HlDWhyTiBDYRBazoeUTDE+5Z3gh86IPXfvC+SN+
 XqWzVkGPClYHdWLaL4m8yzXfImLlxFVywl/Xb4lVK6QB8Tzi0gYmXp5gp7Ltf8BFn2ac
 csKnGS7ybMx1NgGRjxHR+iO0+p7I8dLGwbNeFI3di9N69ahfiv/lkz2malGGRsrm2EvB
 WMtQ==
X-Gm-Message-State: AOJu0YyiaLZG5Nyv5gwt+oOlooh9sFz87ZeX5xD1RoeEXgj61QDkRpuP
 hGoW8HtGy418THMt/SmKi9+RY4+zFIbDydOhecjAxVFni8PeSAEEtntUPL23Bcn09Wro/rx2Sxz
 V+bTx+Y9e+JQE0OqmxK7d3suFNxrI7kLaEnh7oKKWnd79i9ScDAiFyp26iT64WlFKrfPMoGsLKj
 mXKm5K5SlfWQQdcbH4pKCGcaJU3VM7H5vQR+cd
X-Received: by 2002:a17:906:d215:b0:a3e:7a1c:47ac with SMTP id
 w21-20020a170906d21500b00a3e7a1c47acmr5344463ejz.8.1708416490269; 
 Tue, 20 Feb 2024 00:08:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW55noVnmT7sSYq9mthQ0weTf4shB48BW5A8fnMFjtDN6Ngf9hB2Wx9YioODLbBMGxi8OlPQ==
X-Received: by 2002:a17:906:d215:b0:a3e:7a1c:47ac with SMTP id
 w21-20020a170906d21500b00a3e7a1c47acmr5344444ejz.8.1708416489998; 
 Tue, 20 Feb 2024 00:08:09 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 tl7-20020a170907c30700b00a3e5bcfe5b7sm2589628ejc.134.2024.02.20.00.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:08:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 13/17] configure: put all symlink creation together
Date: Tue, 20 Feb 2024 09:05:54 +0100
Message-ID: <20240220080558.365903-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 9cdb5a6818b..3cd736b139f 100755
--- a/configure
+++ b/configure
@@ -1538,6 +1538,11 @@ for f in $LINKS ; do
     fi
 done
 
+# use included Linux headers for KVM architectures
+if test "$host_os" = "linux" && test -n "$linux_arch"; then
+  symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/asm
+fi
+
 echo "# Automatically generated by configure - do not modify" > Makefile.prereqs
 
 # Mac OS X ships with a broken assembler
@@ -1605,11 +1610,6 @@ echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
-# use included Linux headers for KVM architectures
-if test "$host_os" = "linux" && test -n "$linux_arch"; then
-  symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/asm
-fi
-
 if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
-- 
2.43.0


