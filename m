Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F239AD33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qlb-000181-Iy; Mon, 28 Oct 2024 10:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlS-0000f9-Lk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlQ-00040v-Ux
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsUT3jzMYD5+Mr0ZTkd2XlGREse/Gg+yaEc3jtKi334=;
 b=WgY6MVDlrQo5HmSjHa4WRWiQo0xwP1cWxmGlQUb0Tmu4+5yEkBGFGoMmo1+vgS8Yi5U6/2
 44VhRJ/locTnkD7jI/bktW9/OG4bqYl6bexDc6T4Z53/eAzucipHR58loSULTZBE1pn/Nk
 PwNYxOCXmCNPBebtMyCttbKghDWfvIw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-nze5tk_gMXir6vA3YIA44Q-1; Mon, 28 Oct 2024 10:30:34 -0400
X-MC-Unique: nze5tk_gMXir6vA3YIA44Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so3124044f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125832; x=1730730632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsUT3jzMYD5+Mr0ZTkd2XlGREse/Gg+yaEc3jtKi334=;
 b=QBc4K0DYNvY58uQ500qbcNynmLMOGCQkcGRX3xaRmQKnZKMOx0FRZXNxnOLMQpoc93
 6HMPd1uOBuLhltmb+YmO4OS8/jNBv02Ja94UodTHOpzTbJlIFtDQHxgmc4jQiG231xDB
 DkFsDt2s/sdYFabL7olIf6lyNTeKaORLtkM2h00/PfdkqX4v1SuirXQ7unZGyae5FJN7
 vddXiV3NafIEAp7YJPUmwmVDjf3iXOtcWXQIorYaxTg2iYSlu9GdyeymysxO9qNHB1Zc
 kLTpMQy+hmUF/kyvggkpxu5Qvj77ccmbYpsAGiz+jDfn1unMm/lsW9Ow8+KupSIKLwjz
 AH2g==
X-Gm-Message-State: AOJu0Yy/dQimcq7CrwzVUH+n3OQgNUb0IgqOc8xiO2OLgKRjFfR1HokT
 P9k7Ln718H1BgMz/LmeMWYMoevc7+twRKosnpMtLT5k6r1Y1i4AnJ3sLGVaXwTdcDrInDvyakcI
 jITkUYCsbvgyKOjp0CdNhXW3hd37tQ/ZfAqybrdIMY6A9Ac1VKRmABNb/u04lAAS4geFF3I/7sN
 Heie8PZVf17rJHnSXA4uzAEg/zGqNPcjjfCLnWIIU=
X-Received: by 2002:adf:fc46:0:b0:37d:2e74:2eea with SMTP id
 ffacd0b85a97d-38080de743dmr42006f8f.5.1730125832279; 
 Mon, 28 Oct 2024 07:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjUw2i4fDkeujYQFXV913oG/kfCdMj35U3jcTi6vhFaBrR96+X2A04i4+e/UFQbC9lR18vYQ==
X-Received: by 2002:adf:fc46:0:b0:37d:2e74:2eea with SMTP id
 ffacd0b85a97d-38080de743dmr41979f8f.5.1730125831862; 
 Mon, 28 Oct 2024 07:30:31 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058981ae4sm9687871f8f.0.2024.10.28.07.30.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:30:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/24] configure, meson: deprecate 32-bit MIPS
Date: Mon, 28 Oct 2024 15:29:30 +0100
Message-ID: <20241028142932.363687-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
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

The mipsel architecture is not available in Debian Trixie, and it will
likely be a hard failure as soon as we drop support for the old Rust
toolchain in Debian Bookworm.  Prepare by deprecating 32-bit little
endian MIPS in QEMU 9.2.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst |  2 +-
 docs/about/deprecated.rst      | 12 ++++++++----
 meson.build                    |  8 ++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 8fd7da140a3..b779eb54934 100644
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
index ce38a3d0cf0..f3f4cd4059f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -164,15 +164,19 @@ property types.
 Host Architectures
 ------------------
 
-BE MIPS (since 7.2)
-'''''''''''''''''''
+Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
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
index 5e2b0fb82b2..110e93f84e9 100644
--- a/meson.build
+++ b/meson.build
@@ -4721,6 +4721,14 @@ if host_arch == 'unknown'
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


