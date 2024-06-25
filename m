Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65EAC3065B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7nz-00026E-Oi; Tue, 25 Jun 2024 11:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7ny-000254-Jh
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:09:58 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7nw-0006ao-E2
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:09:58 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70675977d0eso2443812b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719328194; x=1719932994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjJ8FiIwLlRUxUj7SFESB41Mk+cqdsNDBhRKpyJyimk=;
 b=nC8LZfcHUog09sql+DU27aaJ4VtA3Jz5krMvJBXaBShr1Gt6X5a935NKgc5/LnJ/Ii
 bKEUpo6gFQRwymUL93jzNeLbuhAfsSBZxLUar7/mLOElTNB1zlmE3qbyetFZiu6h1Pdd
 nrdKslrs6pqv+YUr6bXGCgiw2OFgAsbmQchpTrBlT73UkQwFa0jqOuF6DrVEK2H7T6SN
 FzTRDQsOrIohPNpwiWvRts2u+BhBTmn4zL8vd5nATxcGnz+pbAGeDxNpEVAVDtG0SXqu
 /uJkBGck5uyRmNFdIa7Es5xenLuHZ8vbZ8sh85OXeeidHHhrpLSM2jDHIujyYAx0aO23
 iihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719328194; x=1719932994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjJ8FiIwLlRUxUj7SFESB41Mk+cqdsNDBhRKpyJyimk=;
 b=v2QGZYeJLlwq9Xp5iWuCYica9XqrRxDtQVnxQZCtYFzvKVYTKitdxlnyUM5HxOUMvv
 FrxI0mx2KAAKfSVZwAxBQRETgqcfViHUMMhxSz3k5DQZEiS1ZSjNs8ZGYWPP4JlyScXn
 xZj0AAkGe9OaO3g1vTjixy9+tisrWAkGzqxF7dbjTqyoiBoEWjzKkkxVFxqKgDbUfK7m
 dej9LZpWOMEzrp3kaQm6CGC1z9kUBiXYtKHT8EGxGUX9b/jmC54+XUmQP7yH16cA0ehn
 pacs4mrGV3LmvrnhObZ2K/Aps6BtL4wdAzb/E9vcVKfywrWP7+rnFm+nl/gIjHmKwL9Q
 4Cfg==
X-Gm-Message-State: AOJu0YwmvpaYYA44ZmrAb5wY0WtHPVq87TGoCZ82kXYlp50O1b1zxr9S
 1hVpglZHvSC/hiMl2P0OdMuMF/dtzhOBD1R3PbJmqxrVbBzBP4h46MTVC0Xo//TpQpLh6dhv8dT
 h
X-Google-Smtp-Source: AGHT+IHOiF/yY81dbFimosfZ4x5hXRCPUiJLb4Y6q+5lZPt5o6QY+8JNZ3QG9DKsQIqNa8ubTVM5Gg==
X-Received: by 2002:a05:6a21:328c:b0:1af:939b:d477 with SMTP id
 adf61e73a8af0-1bcf7ef1a40mr8239489637.36.1719328194390; 
 Tue, 25 Jun 2024 08:09:54 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70681722219sm4142636b3a.73.2024.06.25.08.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 08:09:53 -0700 (PDT)
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
Subject: [PATCH v4 11/16] meson.build: Add RISC-V to the edk2-target list
Date: Tue, 25 Jun 2024 20:38:34 +0530
Message-Id: <20240625150839.1358279-12-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x436.google.com
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


