Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC7CC30659
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7o7-0002Hl-0d; Tue, 25 Jun 2024 11:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7o5-0002Ex-Lk
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:10:06 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7o3-0006cc-DT
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:10:05 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70670188420so2318245b3a.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719328200; x=1719933000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPyOu1IwMNogunIuIjBkDIc9zx4X6xTuQJ4OgT7GMUM=;
 b=gdcinpQj4ZvT3LyNE4xelFmA3twwUgYNl1XQ76IvVqil82T3qX0igbP5JblLH/MHhL
 F8SI81RL8OhVpaAZcJ+4r35RlRXvo+uT4aWDMkz9CQbIfZPSbpwU20xuZovYmKQnUU+4
 La5t61ryCKulmh8v07ZqttvD7sjLPUs5NnGuw8bCn+8cgXVhAwxkQi+EcTEQZBFbURyW
 MlaqWGmmMGqujGUUnKlodzyQmY74EUQ++kSFbavH5dt+6j9vPlfgL3/Z9hBAij/zFAuM
 UkityWCuT8vJmcylA86Hks15pzGGEkYNN48joi0HWYELDMIE9vIa3CrXOGGgKbmRrtX7
 IjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719328200; x=1719933000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPyOu1IwMNogunIuIjBkDIc9zx4X6xTuQJ4OgT7GMUM=;
 b=hEwbhG0yvHq8bhw5pg2KoJ1I+e69DhvSPu/rjXbMPYTPyduqB1mpD1KaZVBtOXiC7U
 XX9Z2R8sGyTCgUgUreR8iubExXvdtXjeTTPNSXaGOpgCKCvcoZ9F2ETV9MQ1UoHLJtcF
 wjKZEZ7C7zk2xnlrv6j7r6tHAgEM/NwB1WBRuM5riwsLRAMSxL3CULkw9WDHNa1wIe7f
 4Xpz2/r+xdkbNp42GmeVXC8uw6XYiBi11M+oxOjOM3Jcjpfmj5tRTbmZGYFVXaK9QeiA
 /FosAAxA9dH5f+yD65YhTpDiC8hau9zBtQsIj2xzzxMva4BqRvjVnwhBfW5H8pj0tfRX
 c3DQ==
X-Gm-Message-State: AOJu0YzLL7hxVvtD96ciHFRJlAJrYLg9STePVBMoD6fcyrjYoq5RZmFJ
 HY3Wv/+Hyhmp06mEAFvCkvW3rmvn/3rYdhHiIIvKao/6Pz19qO9PlDy890Y/tm7XZxdb1vbxUdS
 K
X-Google-Smtp-Source: AGHT+IEa/98rIsNeBVi1pCyL7gL4Ra7UJdymGObXwZqtPnPctM1yFFvw4Z9gt5kXUtmXT4jc8G+RaQ==
X-Received: by 2002:a05:6a00:139f:b0:706:3204:fa4e with SMTP id
 d2e1a72fcca58-7066cbd0820mr11148032b3a.0.1719328200343; 
 Tue, 25 Jun 2024 08:10:00 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70681722219sm4142636b3a.73.2024.06.25.08.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 08:09:59 -0700 (PDT)
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
Subject: [PATCH v4 12/16] pc-bios/meson.build: Add support for RISC-V in
 unpack_edk2_blobs
Date: Tue, 25 Jun 2024 20:38:35 +0530
Message-Id: <20240625150839.1358279-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x430.google.com
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

Update list of images supported in unpack_edk2_blobs to enable RISC-V
ACPI table testing.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 pc-bios/meson.build     | 2 ++
 tests/qtest/meson.build | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 0760612bea..8602b45b9b 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -4,6 +4,8 @@ if unpack_edk2_blobs
     'edk2-aarch64-code.fd',
     'edk2-arm-code.fd',
     'edk2-arm-vars.fd',
+    'edk2-riscv-code.fd',
+    'edk2-riscv-vars.fd',
     'edk2-i386-code.fd',
     'edk2-i386-secure-code.fd',
     'edk2-i386-vars.fd',
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 12792948ff..6508bfb1a2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -259,6 +259,9 @@ qtests_s390x = \
 qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
+qtests_riscv64 = \
+  (unpack_edk2_blobs ? ['bios-tables-test'] : [])
+
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
   'ac97-test.c',
-- 
2.40.1


