Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143C7C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 12:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKcwN-0005cv-DA; Fri, 21 Jun 2024 08:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sKcwI-0005Ys-3k
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:00:22 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sKcwB-0003Ju-Ke
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:00:21 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f4a0050b9aso15767585ad.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 05:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718971213; x=1719576013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjJ8FiIwLlRUxUj7SFESB41Mk+cqdsNDBhRKpyJyimk=;
 b=o2L99lklWFaPgd1psayupquJRguySckEcihHrKS1137NlFbWpuDtFEbLrFi87plfX/
 ZNeXVu9nLOqFvXMeb7+OKD5nHjpY7dWEr2l6GHgnf260c6HPGgxKNpaNCA8OaJVTQa7g
 ghAh3XUlur07HSaXJ2Im0KfB2+GYEA0MOuqCa3vYMPQbGdckCX5WK+o4rHTXNHkuCxyA
 hWomFp+I8FuO13DujhwIQ1l7J9NR1/SrDJk3uM8HdE1b+WUP3S7qR0OqWgL2Di/D0ZhP
 NXsk3b83WnKSjAVw29QQ66odsXrYWSoNSFbU9o2e3ogGtBCUM2QzsK7FhSw59gJYeoP2
 X/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718971213; x=1719576013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjJ8FiIwLlRUxUj7SFESB41Mk+cqdsNDBhRKpyJyimk=;
 b=VgngNqgFtbTSX2yJikVspm5rLU0DaZmck9km/G9oRHjIvvEwYH1Gctt83mPQrqqTNd
 xWy5Axnth/GrRgRWzCESsixQLrmk03AwTHkpRVOP5sRqt0GW+FjhQQOYBTKb3CHyNCcc
 S18KdC1oEvYyKrdIipHWQYeOVo/UMXXNH9oEA43xUzFle/F5ZrvwWjEHn3b9OgOx3L3m
 Lrb8KZ4cZua8zV0R4vbuadEKbx6Y/N2z2Kkd2wZkAHSP8wxsfth4xOB52evOwKSYy336
 tjwvxqukXEAwrP6Vh732x4KMxP1bCP66B0dckt1WMnrge4oxU4Y3y+2tI0eVONIf5J7u
 +fHQ==
X-Gm-Message-State: AOJu0Yw8FYE7rll3MEOGKezsp8seefU97s7cA5QrgxUmUmBT8/o3sTVQ
 bOtBPkQ2+mvN54UOGLTp2tr+y/uUIeDiFushVgvJkZ7ctbivmGEmC7PsTz/22IWcMh5DJ4xOcCp
 x
X-Google-Smtp-Source: AGHT+IG/EfMQeEn8XpVHYTU46v8NO5eSy15FQurzKf8aspudolJ7Qi/0MC0QCFqLKDi6C9vwVWsE8A==
X-Received: by 2002:a17:902:cec6:b0:1f6:62cb:7c22 with SMTP id
 d9443c01a7336-1f9aa45a631mr93210575ad.46.1718971211354; 
 Fri, 21 Jun 2024 05:00:11 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbb606dsm12422995ad.270.2024.06.21.05.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 05:00:10 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 10/15] meson.build: Add RISC-V to the edk2-target list
Date: Fri, 21 Jun 2024 17:29:01 +0530
Message-Id: <20240621115906.1049832-11-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

so that ACPI table test can be supported.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 97e00d6f59..b54b0463a4 100644
--- a/meson.build
+++ b/meson.build
@@ -93,7 +93,7 @@ else
   iasl = find_program(get_option('iasl'), required: true)
 endif
 
-edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu' ]
+edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'riscv64-softmmu' ]
 unpack_edk2_blobs = false
 foreach target : edk2_targets
   if target in target_dirs
-- 
2.40.1


