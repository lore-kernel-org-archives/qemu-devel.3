Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751E6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t93-0005sl-NR; Mon, 06 May 2024 03:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8r-0005p3-FN
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8p-0001dl-Ss
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eITcF/h9MNjyV6fka9J98I4MflYQxu806VbEWIkwiqU=;
 b=a/w0js4rEC4YJSwfVkmps2AbRj2YIBlO1YYxJyKwJVDp8rVpURpebVb98CgHfzLW8YjPlR
 igT3MO0ySz1OIZsH2cRgBxUxTbQ/Ve3NS+h/Q1r4iOy0BaG+cUp0p5l2I/WnD+uI5wwEh5
 pFmPpHSP5mp/UtINFim4TfM4sYRFBy8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-V6F_0eSWNEWB2qpa3k6-Ng-1; Mon, 06 May 2024 03:52:04 -0400
X-MC-Unique: V6F_0eSWNEWB2qpa3k6-Ng-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59cdf2141eso36349266b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981923; x=1715586723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eITcF/h9MNjyV6fka9J98I4MflYQxu806VbEWIkwiqU=;
 b=Vd5lzEa+0GsuaQ0qLB087noAUgtE3rcFSI1vtVceA/V5JUXiG6iW0vSG8/jNCkuy/c
 /jc1241XdM7/uCfUG4dEs7RIxoCpPnfuTVXUr9frHWYBXsNLPNDOoKJQviWHWejn6twz
 rrGIsnCGsuopataOZUsISQzO0U0gk1g7J71y+9K0uqtWOxo+CyzFWPvS0SPXZautx+vE
 mLwfMqPZnNt9wjR2xGYlSe0xEjmOZgWSvHRJN0rnRl+JKGt3BHjn+4GkEObAE0o4YGXY
 UhezV56nvJFUp6lHvw27Cqs71dAz+MPDE5bh8RlgCohjGII7xm8d6WadigfU4XY0FUqO
 MR+A==
X-Gm-Message-State: AOJu0YwsE+sQPw1bB/MJ1TUh3Nk2k6drpzPqnp1OuoaRP9NbwR8kJh61
 yB6glAMKyDh3zCJMb6ycLPRrnFRBFz5Zj+ma6HutBNdal+Ok44poqwYyclYnXge+MEg7WBkOBSL
 QkZBrTNekZoHb2AlbMMJqhe2WLRwjFixmbXmTnrMJv4K+8JaMVj+OQJiPzrqVuK3g0PvKjDd2Hi
 ZvTOSLh55IWlvRm0yKrnnUM0LiBtwCuvykfOUX
X-Received: by 2002:a17:906:26d7:b0:a59:7ed4:fad5 with SMTP id
 u23-20020a17090626d700b00a597ed4fad5mr5185549ejc.54.1714981923000; 
 Mon, 06 May 2024 00:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJf2lfL6FEtXsvvNAZvQ4mkJAM5hMsWgRgjpdoyZgm9VAEl5aGPNz5XXe5mZucpzCbRGMHkQ==
X-Received: by 2002:a17:906:26d7:b0:a59:7ed4:fad5 with SMTP id
 u23-20020a17090626d700b00a597ed4fad5mr5185531ejc.54.1714981922632; 
 Mon, 06 May 2024 00:52:02 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 bk15-20020a170906b0cf00b00a52244ab819sm5008600ejb.170.2024.05.06.00.52.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/46] m68k: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:53 +0200
Message-ID: <20240506075125.8238-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with m68k.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/m68k-softmmu/default.mak | 13 ++++++-------
 .gitlab-ci.d/buildtest.yml               |  2 +-
 hw/m68k/Kconfig                          | 10 ++++++++++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/configs/devices/m68k-softmmu/default.mak b/configs/devices/m68k-softmmu/default.mak
index 8dcaa28ed38..3ceda6b041b 100644
--- a/configs/devices/m68k-softmmu/default.mak
+++ b/configs/devices/m68k-softmmu/default.mak
@@ -1,9 +1,8 @@
 # Default configuration for m68k-softmmu
 
-# Boards:
-#
-CONFIG_AN5206=y
-CONFIG_MCF5208=y
-CONFIG_NEXTCUBE=y
-CONFIG_Q800=y
-CONFIG_M68K_VIRT=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_AN5206=n
+# CONFIG_MCF5208=n
+# CONFIG_NEXTCUBE=n
+# CONFIG_Q800=n
+# CONFIG_M68K_VIRT=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index a82848ba55b..a91e8d359d5 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -663,7 +663,7 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
-    TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu
+    TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
       s390x-softmmu sh4-softmmu
       sparc64-softmmu hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index d88741ec9d1..0092cda4e9c 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -1,20 +1,28 @@
 config AN5206
     bool
+    default y
+    depends on M68K
     select COLDFIRE
     select PTIMER
 
 config MCF5208
     bool
+    default y
+    depends on M68K
     select COLDFIRE
     select PTIMER
 
 config NEXTCUBE
     bool
+    default y
+    depends on M68K
     select FRAMEBUFFER
     select ESCC
 
 config Q800
     bool
+    default y
+    depends on M68K
     select MAC_VIA
     select NUBUS
     select MACFB
@@ -29,6 +37,8 @@ config Q800
 
 config M68K_VIRT
     bool
+    default y
+    depends on M68K
     select M68K_IRQC
     select VIRT_CTRL
     select GOLDFISH_PIC
-- 
2.44.0


