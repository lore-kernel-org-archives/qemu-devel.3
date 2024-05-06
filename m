Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8571C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9A-0005x3-1S; Mon, 06 May 2024 03:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8j-0005nO-H6
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8i-0001cg-1w
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iN4tbNSzLnnxZylnaIpsJ38zvZ6eIX3lpJVpzpt9iIU=;
 b=L81vWV+oFNp4AxhIbrqUjXGk84AxusQXHkhIHfgj3n56rFgJ15tuI+yQc6q2f9FOH90HII
 VmZw6sp58zZIvuHa0+49Rb/lpMtQF3F86Dfy5GnGwJwrFqLZpRZHlegBHvU7NdqbrGxpsw
 uSA/CXeFZjG++lsCZSsoPKjbKvn6FRw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Cnz3ngx6OXCYPRKSGg76mQ-1; Mon, 06 May 2024 03:51:57 -0400
X-MC-Unique: Cnz3ngx6OXCYPRKSGg76mQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59c02f798bso98239266b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981916; x=1715586716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iN4tbNSzLnnxZylnaIpsJ38zvZ6eIX3lpJVpzpt9iIU=;
 b=RkyCBUS4xkT88zpQXYccNp6SLr5oWHED64ncQXYESpRycn3P3QjAZUwLKvCf+vYtRX
 Vv0SzSwzj1kOidcmZ5qLpYv+SW0LF33VihvNQuwnVeM9nzn91v9DTxAqn+mlnEGTbhtE
 0w8TZTNUoS10EwMbjwX3YthHDZIcWBF/SWNy11kYlufUwttX2aDwOHJ5NG2UyQlqv9NV
 MaEzDthI7aR1Wc9H2m5JeksgSuVf0mOOdUJmT4tvoh1BAKEvnbj8VhaP1sT71xF2xwVq
 0AE6/Rnl6qCmDgrF9svGj2p2X5+jyU8jkpQHBo8XH1vivn9cynaVZiH9Xxcgw8J9kQC0
 Al8g==
X-Gm-Message-State: AOJu0YzMnjnq/uuY15dXyqZHuhOzZoNzV8lzs6TKxgxf4sFT7pNVQ5SB
 PIuoWWl/whNjCUSNKARp64qHMFwzTHwjp1wMkqhzAwdjei+YqnJlSa1AuYxF+/Uov3+JPF5JTM+
 p1aXMudVTwoWWviM/Pasf/zJMT4uHtaJQcKvsQ3WSZvfEConbUjC2pwkIDrY6pIc1RhaFE6ngPX
 pAyIkVhHOLAAdaSWv2+GeoeGoyHm385r67bydI
X-Received: by 2002:a17:906:b858:b0:a59:a282:5dbd with SMTP id
 ga24-20020a170906b85800b00a59a2825dbdmr5691781ejb.66.1714981916103; 
 Mon, 06 May 2024 00:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEszT7UWcHMI2CfPXwjJuy1hwAjF2JBB5MnKqWapjNPKVFMuKN8Kn1xbAH/prdcQKVjUbG8PA==
X-Received: by 2002:a17:906:b858:b0:a59:a282:5dbd with SMTP id
 ga24-20020a170906b85800b00a59a2825dbdmr5691767ejb.66.1714981915705; 
 Mon, 06 May 2024 00:51:55 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a1709064a4600b00a59c3a49fc6sm1612424ejv.72.2024.05.06.00.51.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/46] hppa: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:50 +0200
Message-ID: <20240506075125.8238-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
Continue with PARISC.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/hppa-softmmu/default.mak | 5 ++---
 .gitlab-ci.d/buildtest.yml               | 2 +-
 hw/hppa/Kconfig                          | 2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/configs/devices/hppa-softmmu/default.mak b/configs/devices/hppa-softmmu/default.mak
index b0364bb88f2..059510cdbb7 100644
--- a/configs/devices/hppa-softmmu/default.mak
+++ b/configs/devices/hppa-softmmu/default.mak
@@ -4,6 +4,5 @@
 #
 #CONFIG_PCI_DEVICES=n
 
-# Boards:
-#
-CONFIG_HPPA_B160L=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_HPPA_B160L=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index f4dc5666467..6531758d968 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -662,7 +662,7 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
-    TARGETS: alpha-softmmu avr-softmmu cris-softmmu
+    TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu
       s390x-softmmu sh4-softmmu
       sparc64-softmmu hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index ee7ffd2bfb5..d4d457f4ab4 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -1,5 +1,7 @@
 config HPPA_B160L
     bool
+    default y
+    depends on HPPA
     imply PCI_DEVICES
     imply E1000_PCI
     imply USB_OHCI_PCI
-- 
2.44.0


