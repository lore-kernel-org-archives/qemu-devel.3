Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D15C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG0x-0005CX-IF; Tue, 23 Apr 2024 09:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0v-0005CA-FR
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0t-0001xE-VR
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Eyi3nrisI3K7EFl7NtvcIXaV/CzRmevR+H+16a87dk=;
 b=BwSVCXmf311ac+wP2Lf8ZDpLNYqfNTy/+J65PlVhdHfR5llZNJQAVuUAPWXiLSPg+iXVPj
 SMnqpfdVPScVVJGT7XoWOP4sESc3DpQggV/R4yvQMEhgO4//3Dc9hwvZ9OGsFARaIeechJ
 hSxp2FYC7wsQLFyEN7xvpSQsaoiBo4c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-LLrGXeswNNiNyYfm6P2Frw-1; Tue, 23 Apr 2024 09:16:44 -0400
X-MC-Unique: LLrGXeswNNiNyYfm6P2Frw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a51acf7c214so148687066b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878201; x=1714483001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Eyi3nrisI3K7EFl7NtvcIXaV/CzRmevR+H+16a87dk=;
 b=p6E3GOh/HW+VnkN0L0hUU3EFy+xv2fbcpoUHpzUKBGpEed57R+nV3M8tJCHSg/j4Tk
 H0cseRYWmDQfHFnztZqWX8zbBkTzk1NjIZEQDKH3MN0U3eApo5htKGyStYGMUCf/YTVC
 b+TReO91P2MRs6Hz6uN1Yv3jU0PMfURhLk7fni0UKsbl0tKsGWVNXzB64b+5LJCZ4Pr/
 IF1zvK0XpVbshwHw6L6PtKUTbysOxpop9jDiXqxvkfibysY+GaYtaBKJBvrcuiN+ba83
 dxsJ+pii4jE9ovzTKuUmDj7uVb6TJyMvXh/8Gl/jaQowqsqIuY/0kvU5CFdDpF1Rq/kJ
 I8Ig==
X-Gm-Message-State: AOJu0YwmrCXhRdFwWzclSaocIqG/FnHk3m57Qw4m8mngjxbFoVoIUCBJ
 oCJlXt5s0/re/P/CZxbT5Wzn/pxWQyUPChxBnmqEaJfu/U7erARMkYExotBn9QBtQQXL0SO6cSB
 Kkh/a1lplEI43u1fbwXzyOiPHsu1DB3Q1GKH+pXryKrDitx0hwincbmypUEAb+DCIzo4AUXF7nl
 oDCq7p1TA7rgSsFAn7AWsK4x9oFwKWoNPiqJgM
X-Received: by 2002:a50:a6de:0:b0:56e:2e4d:884e with SMTP id
 f30-20020a50a6de000000b0056e2e4d884emr11748619edc.0.1713878201688; 
 Tue, 23 Apr 2024 06:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDyx+vq5scYJ9yh4xIo2eSuRhzc0IyNy1DMI50ADAfQ9/9OI5XGCsgDKIf/FmvUMxHGK+KVg==
X-Received: by 2002:a50:a6de:0:b0:56e:2e4d:884e with SMTP id
 f30-20020a50a6de000000b0056e2e4d884emr11748599edc.0.1713878201258; 
 Tue, 23 Apr 2024 06:16:41 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 x15-20020aa7d38f000000b0057033a63559sm6773082edq.21.2024.04.23.06.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 10/22] microblaze: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:16:00 +0200
Message-ID: <20240423131612.28362-11-pbonzini@redhat.com>
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
Continue with Microblaze.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/microblaze-softmmu/default.mak | 9 ++++-----
 hw/microblaze/Kconfig                          | 6 ++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/configs/devices/microblaze-softmmu/default.mak b/configs/devices/microblaze-softmmu/default.mak
index db8c6e4bba3..583e3959bb7 100644
--- a/configs/devices/microblaze-softmmu/default.mak
+++ b/configs/devices/microblaze-softmmu/default.mak
@@ -1,7 +1,6 @@
 # Default configuration for microblaze-softmmu
 
-# Boards:
-#
-CONFIG_PETALOGIX_S3ADSP1800=y
-CONFIG_PETALOGIX_ML605=y
-CONFIG_XLNX_ZYNQMP_PMU=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_PETALOGIX_S3ADSP1800=n
+# CONFIG_PETALOGIX_ML605=n
+# CONFIG_XLNX_ZYNQMP_PMU=n
diff --git a/hw/microblaze/Kconfig b/hw/microblaze/Kconfig
index e2697ced9cc..d78ba843fac 100644
--- a/hw/microblaze/Kconfig
+++ b/hw/microblaze/Kconfig
@@ -1,5 +1,7 @@
 config PETALOGIX_S3ADSP1800
     bool
+    default y
+    depends on MICROBLAZE
     select PFLASH_CFI01
     select XILINX
     select XILINX_AXI
@@ -8,6 +10,8 @@ config PETALOGIX_S3ADSP1800
 
 config PETALOGIX_ML605
     bool
+    default y
+    depends on MICROBLAZE
     select PFLASH_CFI01
     select SERIAL
     select SSI_M25P80
@@ -18,4 +22,6 @@ config PETALOGIX_ML605
 
 config XLNX_ZYNQMP_PMU
     bool
+    default y
+    depends on MICROBLAZE
     select XLNX_ZYNQMP
-- 
2.44.0


