Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAE6C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURot-00017p-CB; Mon, 29 Jan 2024 08:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURoo-00017Q-AE
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:36:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURom-0000Zx-Mx
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706535416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZlayBfl1lG092L3t/mfKlmWwcPTs55S8i54HXtLS20E=;
 b=I1PsP8qcrhDa8vTjOmuOD94c94ESgMLWKomHBpHMTiFPGxHztFn5JO+6Zz/1RDyEVrw6/O
 m4lCqI9I9jnRDvMmVt2z2tnuw44VyOPJOgAjfQU6pUSLJ5BKz8ZVf8X57mqE5Q9puTwW8B
 5g7Sl0yifvgunD0o9siTu5XupQ5MH74=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-SLkDQHaQOvGnar9oF0EBDA-1; Mon, 29 Jan 2024 08:36:54 -0500
X-MC-Unique: SLkDQHaQOvGnar9oF0EBDA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a34a22e09ccso72653966b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:36:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535413; x=1707140213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZlayBfl1lG092L3t/mfKlmWwcPTs55S8i54HXtLS20E=;
 b=Y/WmD98f2UIkoUw50aX6xUKKfF5p/858buStaITFhaYjRijTzdRkJeLXofMxEuBpY2
 WcRAIMoC3EFOZsOOrQmK5zqlTGuDd+RbQtuaoda91FpbDqru3jSavIJdw1wN99kFe8Ie
 kptyAq+EhnRnCwRtUBlB7s7dmVZTee90dn9v+9enyuFTygnlgcVZpeGfJ9w4jt2c1X1i
 gQ4Z0bNORRbhGuxZEHC3FXp5EjXcQE7/QG0WhO0hP4TG1OUmFceSgCVH59UJXG5qeKsd
 MuQ6uZnUBZUSm3ItBXwyox6FAXSNG6mQlXIXCZVyQ5azQ6gwwvr/94jCvPLBVV9PpmhR
 hfOQ==
X-Gm-Message-State: AOJu0YwoRPmCElOujoxIAf1PQol7on2A+Z8ge6kF2XG3GrPUEmHHzcF/
 WmEnhyAQ3USO5lZLya+e7fOz2dogEJIWiqzOcsRRhtGML7ny4DjxiQYrt4i4jI8NbmmuW6WqdWW
 +X4Fdz+81uSdefQ+PSmzjMqxS4r6NnWp8X417CQ+KTTqd7K1idCuPaT/oSzNzEzZ/pZJ6lRPn+0
 slVphp/B+gbpM2HpMRCBJsN18iTFkQ9B5054sx
X-Received: by 2002:a17:906:a013:b0:a32:b376:48d8 with SMTP id
 p19-20020a170906a01300b00a32b37648d8mr4244195ejy.18.1706535413088; 
 Mon, 29 Jan 2024 05:36:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8uEvS9nYL7ZxJZ9fEgiR7N3wuRPAz1exeePoNiCvbi1qkbsOYqISGx64wZFy7S40f/bKY3w==
X-Received: by 2002:a17:906:a013:b0:a32:b376:48d8 with SMTP id
 p19-20020a170906a01300b00a32b37648d8mr4244183ejy.18.1706535412698; 
 Mon, 29 Jan 2024 05:36:52 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 gx13-20020a1709068a4d00b00a2cf537042asm3880670ejc.192.2024.01.29.05.36.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 05:36:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: do not create legacy symlinks
Date: Mon, 29 Jan 2024 14:36:51 +0100
Message-ID: <20240129133651.1106552-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

With more than three years since Meson was introduced in the build system, people
have had quite some time to move away from the foo-softmmu/qemu-system-* and
foo-linux-user/qemu-* symbolic links.  Remove them, and with them another
instance of the "softmmu" name for system emulators.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/configure b/configure
index ff058d6c486..9cdb5a6818b 100755
--- a/configure
+++ b/configure
@@ -1605,21 +1605,11 @@ echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
-
 # use included Linux headers for KVM architectures
 if test "$host_os" = "linux" && test -n "$linux_arch"; then
   symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/asm
 fi
 
-for target in $target_list; do
-    target_dir="$target"
-    target_name=$(echo $target | cut -d '-' -f 1)$EXESUF
-    case $target in
-        *-user) symlink "../qemu-$target_name" "$target_dir/qemu-$target_name" ;;
-        *) symlink "../qemu-system-$target_name" "$target_dir/qemu-system-$target_name" ;;
-    esac
-done
-
 if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
-- 
2.43.0


