Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55903C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG1e-0005yi-3e; Tue, 23 Apr 2024 09:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG1J-0005OQ-1S
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG1H-00026U-K0
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9u5KdLBjt3phFKYb28PcAbu+aFuu+sa8p7olAJeG70=;
 b=g9RPl1aREIAh1VFPIibhiAPnHwgNUAgnZHolVTzinz0FPSgevh6GCHKL3qSeNXOUob7MX5
 4ZkxvJSObZjw9J8gwpARY6Ldg6NZsNI3NkjUqr4pUL3s5OXBfTPTu7P4LaS3KeQoIrLAlL
 5TEuaCuq+wFPZrWKit75fuABeI55sBU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-EXurDrqnOkKXiKB7gq8rUg-1; Tue, 23 Apr 2024 09:17:09 -0400
X-MC-Unique: EXurDrqnOkKXiKB7gq8rUg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-518d2f112d2so4856810e87.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878227; x=1714483027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9u5KdLBjt3phFKYb28PcAbu+aFuu+sa8p7olAJeG70=;
 b=VRPmRMPLCyAsp3SClqrkuDZgLi5VEcWKyOxBRnvwebvyzeSrP3/fLHlzflJ5zAa/3h
 w6kO7SrC9vn/Rz6AvyLy1ZwvzStk9rde5nl4tLbnD+vJ8HzNTrx72P+2ZqgZtTNkQgOd
 2EhNLa02F9E3lj558NLV5ZB7J68VD8JVZOkjAILu1PqZUsoZTO1uyFw5aX4kxIe4g6Cu
 +XNwgPC2sJc58RtfjWo15CE4gwdyjleBG4NGcUdKKK4hE/HWHRjhHbiUyK9n+OMYqU6A
 gKMuNKaPA3iTlaUQh5m79CwBMHIOweGx7WIVC+IMllrjRoQSEZGP4KW/6r40NcSGCChv
 odIg==
X-Gm-Message-State: AOJu0YwjZk/LQP2EkVNNwGw+aeVytTCXxocG1A7U0yBJkJS9hC5FaFLy
 e0H5vXb54WH3TSKuG4VHNgyTmhnzGIwFc76fxDHMRHmkvWKy8cs/DwH9XCb+A99uQzd7DjUo4Nu
 9p+CN7BVk6KBwIjEOFC1wKLP0NJuOVmzA5AMO86Rz6c+Ipzb+clHBSy541eS0bdqSZ/Hk9G3aOF
 bX4d9B8P/vR14BeJDT8b3MfGDYZz6OLjgPtiH9
X-Received: by 2002:a05:6512:3daa:b0:51a:d74b:f122 with SMTP id
 k42-20020a0565123daa00b0051ad74bf122mr12070559lfv.59.1713878227387; 
 Tue, 23 Apr 2024 06:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLv4LpBDJAx7EZ1BJLykwYnmh9A9AMsI5FTWiATs+U1pE4L9UGrI1iLu9RJWyY5Z+vHTSOog==
X-Received: by 2002:a05:6512:3daa:b0:51a:d74b:f122 with SMTP id
 k42-20020a0565123daa00b0051ad74bf122mr12070543lfv.59.1713878227097; 
 Tue, 23 Apr 2024 06:17:07 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 x15-20020aa7d38f000000b0057033a63559sm6773403edq.21.2024.04.23.06.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:17:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 21/22] tricore: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:16:11 +0200
Message-ID: <20240423131612.28362-22-pbonzini@redhat.com>
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
Continue with TriCore.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/tricore-softmmu/default.mak | 7 +++++--
 hw/tricore/Kconfig                          | 4 ++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/configs/devices/tricore-softmmu/default.mak b/configs/devices/tricore-softmmu/default.mak
index cb8fc286eb2..c7ab542244b 100644
--- a/configs/devices/tricore-softmmu/default.mak
+++ b/configs/devices/tricore-softmmu/default.mak
@@ -1,2 +1,5 @@
-CONFIG_TRICORE_TESTBOARD=y
-CONFIG_TRIBOARD=y
+# Default configuration for tricore-softmmu
+
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_TRICORE_TESTBOARD=n
+# CONFIG_TRIBOARD=n
diff --git a/hw/tricore/Kconfig b/hw/tricore/Kconfig
index 33c1e852c33..6c04f64949d 100644
--- a/hw/tricore/Kconfig
+++ b/hw/tricore/Kconfig
@@ -1,8 +1,12 @@
 config TRICORE_TESTBOARD
+    default y
+    depends on TRICORE
     bool
 
 config TRIBOARD
     bool
+    default y
+    depends on TRICORE
     select TC27X_SOC
 
 config TC27X_SOC
-- 
2.44.0


