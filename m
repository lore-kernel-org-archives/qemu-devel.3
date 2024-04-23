Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB50EC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG0c-000587-Rv; Tue, 23 Apr 2024 09:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0a-00057K-4D
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0X-0001sO-AM
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/CfJcUHL0kvBww1bxnnvCI0JFKeWF7v+z/NCC8Exn4=;
 b=Yuk9Qk3qDzZtUOZqpKRtHJcO0CUUZJtIa0injgEylNDvd6PtUNvaarBLuvRTzDwMmwXEz5
 T/gml4v/lIMqo0HfjVt7JhWLsF8vXbLl9ItPSYRBxAKdJF9HOi6RUDH+CrlfyJf1g5QME7
 6+JQdpotuiw5TJ3N17j65D4QMK8GVeM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-B9O6G-SjM0aYY-KK8lkwJg-1; Tue, 23 Apr 2024 09:16:22 -0400
X-MC-Unique: B9O6G-SjM0aYY-KK8lkwJg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a58765c5770so66306066b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878180; x=1714482980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/CfJcUHL0kvBww1bxnnvCI0JFKeWF7v+z/NCC8Exn4=;
 b=xK8Ct7gE0rhsoB6WCi5Togk9tF5pKV/xqhdt7OUpe7p69fp84hKvozcpVzo8T5086B
 ZlZ1YITJw0dW7nV1AEkEV3BQraDq4K28bJ7/jswxR+kudr7Nu3ipA1pZe4U2ReNWhmvF
 T72I9QezcO/7APkZb9/0CMGjfv5JxgED5kE1whacWmHzBwI6XSpYCCOJx/BD3oV9MBpS
 gDv40SqkLDh7Jdiav/1ZhxN04igrDdX0JgB2TZpCUXxZ6hxrbgeeUECSsX+IMGWM0T7O
 6tV15yGeWuCiQxr1RSjzFq4y9Qfrc3ukQHix/jrdBPUrj1veCYuEQAXSkbXxAEafz+P4
 dQXg==
X-Gm-Message-State: AOJu0YwHsd1gmhZoUoGKlLVW1D/Q2fsd5IQicsFCQEFxoUSvMNqURVtg
 O1usRQP82IU9IoEsipLYvOOhyw3taCfGUs+xNhMwYXFc1tPnIQDbMO8pz7ylxaUN7eYb9HLqHsT
 Ehu97N8LBCeaDDgLIhkeOAq/1HNPl5SP5oev4W9kxpMjMrdWoRscPt/0Hstadmxi5cwrg20o86W
 PRgllekKLgTM4MckgDsUP4iHIh1bV/GJgsx2X3
X-Received: by 2002:a17:906:3608:b0:a55:612b:cca0 with SMTP id
 q8-20020a170906360800b00a55612bcca0mr8430533ejb.27.1713878180627; 
 Tue, 23 Apr 2024 06:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKaNkWhfX4ZOkNJQoWm0DyOPFE7OCU/MR9QscnC3k+DK5HkbE2DcqiJwLT9SKQlmJl0zfn6g==
X-Received: by 2002:a17:906:3608:b0:a55:612b:cca0 with SMTP id
 q8-20020a170906360800b00a55612bcca0mr8430519ejb.27.1713878180312; 
 Tue, 23 Apr 2024 06:16:20 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 lv11-20020a170906bc8b00b00a555eaf25c7sm6969928ejb.123.2024.04.23.06.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 02/22] alpha: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:15:52 +0200
Message-ID: <20240423131612.28362-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423131612.28362-1-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Start with Alpha.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/alpha-softmmu/default.mak | 5 ++---
 hw/alpha/Kconfig                          | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configs/devices/alpha-softmmu/default.mak b/configs/devices/alpha-softmmu/default.mak
index d186fe8e9b1..3de6a9f5779 100644
--- a/configs/devices/alpha-softmmu/default.mak
+++ b/configs/devices/alpha-softmmu/default.mak
@@ -5,6 +5,5 @@
 #CONFIG_PCI_DEVICES=n
 #CONFIG_TEST_DEVICES=n
 
-# Boards:
-#
-CONFIG_DP264=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_DP264=n
diff --git a/hw/alpha/Kconfig b/hw/alpha/Kconfig
index 9af650c94ec..7f3455ce1e1 100644
--- a/hw/alpha/Kconfig
+++ b/hw/alpha/Kconfig
@@ -1,5 +1,7 @@
 config DP264
     bool
+    default y
+    depends on ALPHA
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply E1000_PCI
-- 
2.44.0


