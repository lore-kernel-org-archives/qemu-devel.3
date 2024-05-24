Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158F4C25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 06:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAODI-0002km-SL; Fri, 24 May 2024 02:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sAOD3-0002PW-B3
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:15:21 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sAOCv-0001Kh-G0
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:15:21 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c9cc66c649so3938371b6e.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716531311; x=1717136111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2sFSRuC8+CxMlP5PVNh1RPxJK2RXSojBm6McPGcyLX8=;
 b=K/FOn/3/zAEnbbCQfIuTccMln61Hn9789BkVcuOYDyjwVstGAAPF6H0xFI70TMwO80
 U8X4jSamAmtz3Skaqi1dXpFrwXnO1vNA+1/v2YthdJaqH3wdNORV5wl70RRoKw5Hoy1v
 w7EaGXXgPUICupVF+QmTrByKcHRs+b0ZpX2sybthQXYXBQCS/zHb0BoAHsJ+U9sELXeh
 Sm5voLjPGC4zdY5EOZK/38N9wkBRMUIt2LMaq2iY2bx4pKyQxj9MHbkDB6zUVrL8f7+c
 co8R6gdzvVgJj9XJ4aPTF85+/c+KzVt6NsPPKU/2P527n2SemgqUqobQPV6FACRre65k
 48RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716531311; x=1717136111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sFSRuC8+CxMlP5PVNh1RPxJK2RXSojBm6McPGcyLX8=;
 b=TMhHDVH7EllRSbObUeYiJHVqdXm94875Yfy7zry0skwdIfabPLWWug9dGHDtMGt0se
 DpE765oqbF12TEBdgOgQoIZcobuIzD62MDpxS6GbSIL57XHTAZQcYUnOOAxAD7eySuOr
 3XwOX+p3I0kJbX75RxVrqJPl7zIVk5WHeGo9d2Jht8yRq8qEsg714ChASQPTkHm8He4R
 2xDQ+ZZwMojevOJfrAEVCVrgyH3FwNNnnoo/090lSoxidy0I6X2QHlA557ZwE7scPl+/
 NOpvm+aZ8a1p1hgY4B/j+O2G/8qo5kZc0bbhNIXYy+IdggbIXRKq4npgBTbllSkJnLJo
 Nbww==
X-Gm-Message-State: AOJu0YzqmLs68l34cpS6ZKw32L5fwa5y3EGeV9EUMik4anbw/VqPhZle
 I9Fxf50355YTIPevVnNdSHTo+1tH0dlcL2VDs4AsjYiVfieGTfuS2tKHxOjElyrYzNWoXRqcH7I
 1Mm4=
X-Google-Smtp-Source: AGHT+IFq9mGYMgGQ3biwrKf9GU227to/Vc80af/X6Miwmz2YD5gv28eIFIuWTu+ooDDizcmw0esAdw==
X-Received: by 2002:a05:6871:112:b0:24c:5d25:ed48 with SMTP id
 586e51a60fabf-24ca14e1c25mr1500113fac.46.1716531310853; 
 Thu, 23 May 2024 23:15:10 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.31])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcbea487sm516106b3a.107.2024.05.23.23.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 23:15:10 -0700 (PDT)
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
 Alistair Francis <alistair23@gmail.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Haibo1 Xu <haibo1.xu@intel.com>, Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 07/12] meson.build: Add RISC-V to the edk2-target list
Date: Fri, 24 May 2024 11:44:06 +0530
Message-Id: <20240524061411.341599-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524061411.341599-1-sunilvl@ventanamicro.com>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index a9de71d450..576c803a8a 100644
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


