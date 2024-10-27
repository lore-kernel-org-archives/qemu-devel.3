Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E37BD11707
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 13:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t52zm-0004Q4-Vx; Sun, 27 Oct 2024 09:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t52zX-0004PT-9Y
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 09:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t52zV-0005cx-SM
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 09:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730034453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5QhCKvhp29QPJik0nQKngTKmaiB2ETkqCV4dFuTDNus=;
 b=CcQmRg36sfCGxbshhBBarnB7xRx1tuYBTfhqhmUs67QRNlKyEJ50WQ1RuChvWzo0r464mu
 urp9wbuMdNG2oIO5OMWD6dEzQ7LBLJD20a+DRTfkR8QL8Ag4hsG9EGADFe3lGErJ764N+I
 HCd66QBGHaGvwFcw5OvYX0Cdaie7nKo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-d0zHY7GgNoaFKWhmb0BQvg-1; Sun, 27 Oct 2024 09:07:30 -0400
X-MC-Unique: d0zHY7GgNoaFKWhmb0BQvg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d603515cfso1696310f8f.1
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 06:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730034449; x=1730639249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5QhCKvhp29QPJik0nQKngTKmaiB2ETkqCV4dFuTDNus=;
 b=K6AlFCYYlFOv8wNlHgpWyLWmU7JyqyzV3er45RO8LUWh478+jp/dnTLYIGj8FkOip6
 MjbwxOuvHAVj3AWrN0bFiKbAiN9mOWVcJOjMmtEpyQsWLOUDkcZtNYfbFpc2TCQtM1ph
 b6MnF2FZf1g0ROBZ5wKmPku4suiM3fF0Kupih1A1MMptkXQYQi1TYfRk9ICAoo04tUak
 7fwN5nkyoYiInnyjIzKC1sCzQhfrECUBVQy91WkM+kFdcdIRiA47rL8Xh1GW6K3LYLwd
 vahnh8juuu8PpzGOKxwjp4fKcObD0ZwHTB0nS/5gSRAEi80EEUibjHhAxzBWjMKjakfo
 /quQ==
X-Gm-Message-State: AOJu0Yx27GN5xS2zvg4+y0tB198lvkykgv+MSYc8g8ORCYQ/zyD6YtFB
 1KQjy5T9vxPL3IJThFMFnzjE8hbqcFCs9XRxPcdKFkRh8bGLrkn3MMdiwvdD/Z1pLOnF9d7s4dC
 PI/04Vrg1RfGTNi+VPwXlOF+xQoeyoWovyewxIxfUMXURQ45NEPqP+BvD/UiUsDckeoVK1n9M/k
 Q8nXG5bfRaLg7dAtG9Df+H3HopQZBQzMZDbjNosLM=
X-Received: by 2002:adf:ef84:0:b0:37c:d20d:447c with SMTP id
 ffacd0b85a97d-38061163710mr3943564f8f.29.1730034449006; 
 Sun, 27 Oct 2024 06:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQcy8Aguba0l7L+TjQJsxySggOXcSyEiGTcxf4rHoPhcxPgoAw3MzF+U+nKT1mlERBG5h/Dw==
X-Received: by 2002:adf:ef84:0:b0:37c:d20d:447c with SMTP id
 ffacd0b85a97d-38061163710mr3943540f8f.29.1730034448489; 
 Sun, 27 Oct 2024 06:07:28 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b70c91sm6696400f8f.85.2024.10.27.06.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 06:07:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH] configure, meson: deprecate 32-bit MIPS
Date: Sun, 27 Oct 2024 14:07:26 +0100
Message-ID: <20241027130726.244605-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The mipsel architecture is not available in Debian Bookworm, and it will
likely be a hard failure as soon as we drop support for the old Rust
toolchain in Debian Bullseye.  Prepare by deprecating 32-bit little
endian MIPS in QEMU 9.2.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst |  2 +-
 docs/about/deprecated.rst      | 12 ++++++++----
 meson.build                    |  8 ++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index ff56091078e..6102f00aec0 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -41,7 +41,7 @@ Those hosts are officially supported, with various accelerators:
      - Accelerators
    * - Arm
      - kvm (64 bit only), tcg, xen
-   * - MIPS (little endian only)
+   * - MIPS (64 bit little endian only)
      - kvm, tcg
    * - PPC
      - kvm, tcg
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 74c75666c31..32b4cd16ec3 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -170,15 +170,19 @@ property types.
 Host Architectures
 ------------------
 
-BE MIPS (since 7.2)
-'''''''''''''''''''
+32-bit MIPS (big endian since 7.2; little endian since 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 As Debian 10 ("Buster") moved into LTS the big endian 32 bit version of
 MIPS moved out of support making it hard to maintain our
 cross-compilation CI tests of the architecture. As we no longer have
 CI coverage support may bitrot away before the deprecation process
-completes. The little endian variants of MIPS (both 32 and 64 bit) are
-still a supported host architecture.
+completes.
+
+Likewise, the little endian variant of 32 bit MIPS is not supported by
+Debian 13 ("Trixie") and newer.
+
+64 bit little endian MIPS is still a supported host architecture.
 
 System emulation on 32-bit x86 hosts (since 8.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''
diff --git a/meson.build b/meson.build
index f5df5cdc49f..e69287acfc5 100644
--- a/meson.build
+++ b/meson.build
@@ -4807,6 +4807,14 @@ if host_arch == 'unknown'
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
   endif
+elif host_arch == 'mips'
+  message()
+  warning('DEPRECATED HOST CPU')
+  message()
+  message('Support for CPU host architecture ' + cpu + ' is going to be')
+  message('dropped as soon as the QEMU project stops supporting Debian 12')
+  message('("Bookworm"). Going forward, the QEMU project will not guarantee')
+  message('that QEMU will compile or work on this host CPU.')
 endif
 
 if not supported_oses.contains(host_os)
-- 
2.47.0


