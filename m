Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5D7C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLAe-0007Kv-2n; Tue, 20 Feb 2024 03:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLAc-0007K7-5h
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLAa-0000b8-Mx
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sc8/RsKreZdGHNeQ107eSW7WAXNnjbp5XEYSDLR89jo=;
 b=AIx7nmXE1aKBtzz1bDjkoC87ON+5RQexUiOCBy9O82oRCKvVkiMSaEyHXn1jSD6O6t+5g1
 FwyLyBYBqUkjHo6TYp7LWIxKQaSEkiCUlAosdYdPT1N1muaiLHZr6pcaj5x7yX4lSIQK35
 FOQhXtIuPyEFPF4vvr9whluMjSTuwbE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-6BpsVvJuMb-OfrGLwU9nqA-1; Tue, 20 Feb 2024 03:08:02 -0500
X-MC-Unique: 6BpsVvJuMb-OfrGLwU9nqA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3ee69976dfso28297566b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416480; x=1709021280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sc8/RsKreZdGHNeQ107eSW7WAXNnjbp5XEYSDLR89jo=;
 b=r1bPFq/KfCpjCVMOKZRYv+ydPdtlqLIy0B+H9eFEDP0VgOX8mx7Nt3PTJInDJmjHTd
 cqsX1fmKt3+e9fk3x6QEV49BokJpYk34BX9GtY2hbkgjlXTssRDhKXM+NRomu+vH2etd
 Q3mXcnwWA3KzefEc5uzdYhn5k1puQQOgdxCnULRm2Nrd/jdSLU7T60SBI5CtJTaejpiJ
 OfhdOcvaPtn6ROc4RXTVIfF3Zw2kI6o6y9UJsg5zNpISwQEDY9Ix9RnbqbRE+5ZPpVkl
 4/G3VtvK9ley3GQH89XWnyVddhM0/iniWQuEi9JWO0e6HTX9/FAprX8d8n11kGysTxgE
 XgsA==
X-Gm-Message-State: AOJu0YyaJ9qZhgyyAXsoTWrrfmBG2N0MZ45Mk4zECY0tSj/Q8hQ96Trv
 ntNtKO4lVwnFCGMU9vUZtsmeMp9e6isOPIxlGoyuc2kzAqEdTgJohkRMxJwnS8ERWqXrXbXix1B
 j+0en2Xp0TihXN+UZCUzQMt8t2uYKH94P6IlbXn1pXUnTCxrX8az6lyC/Cqo3K2rUCiuqpsRGuo
 4sUIZFObY6dP/uiEYtJLVMQnT6E1cRjXy7iw/X
X-Received: by 2002:a17:906:f9d7:b0:a3e:f967:b54 with SMTP id
 lj23-20020a170906f9d700b00a3ef9670b54mr601381ejb.12.1708416480621; 
 Tue, 20 Feb 2024 00:08:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo0ocjr73jyNyvVnNLqaXwgUerx3uZfm/h/QdcjsFrQ5Kw0rTHk00ichTXPl5NYexWkOm5Wg==
X-Received: by 2002:a17:906:f9d7:b0:a3e:f967:b54 with SMTP id
 lj23-20020a170906f9d700b00a3ef9670b54mr601368ejb.12.1708416480275; 
 Tue, 20 Feb 2024 00:08:00 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 tz5-20020a170907c78500b00a3ce31d3ffdsm3730347ejc.93.2024.02.20.00.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:07:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 12/17] configure: do not create legacy symlinks
Date: Tue, 20 Feb 2024 09:05:53 +0100
Message-ID: <20240220080558.365903-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
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


