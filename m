Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B36C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7oD-0002jC-Nv; Tue, 25 Jun 2024 11:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7oC-0002eR-9x
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:10:12 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7o9-0006oI-Kn
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:10:12 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70679845d69so1900477b3a.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719328206; x=1719933006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olkiI7wyhmRaTOBe/j8f3rBI3dB8B8MYASE/tQDUo2k=;
 b=GURkNqiUaW6oSb9cV/z/Yt4rrE71o5N7JpDy6FiUWbsitDAShzFVBB0BZVn2vM77BB
 ZNF7xFSDXcMFqYvLOVW35KbsI4dpQhsBC3vIaz+QkYpdrs8bSBjdmvTkdgpHbzDspPC1
 mdsj1dTV4kC/EVm9YVOpjQfylfW77u0pL+lKwTCVja9avQSlPm7yLECPjoIthRSzyhNi
 LH6tKsXqcjV/h+hi57EnRPUMbjAHZNDUNV7o0RKSytHrxi7j+WXfbz9czWDsF5FFDo8m
 u8Mc8hJM2wYcIoOvjEyO3x6JntVNs0727k7tAcM2JINBCiUHUO9Dh7xwQoK6PvQdCMt3
 6VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719328206; x=1719933006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=olkiI7wyhmRaTOBe/j8f3rBI3dB8B8MYASE/tQDUo2k=;
 b=ApJehwDlQSRttK0XQ+VcALTc6G8CYssskbvP03kWFw2QNDEFYnjugn3wvocXBmFZsp
 JfHic/WII3jrf24DhJTCxGI9bjkSwwyoX/bBkX1FZKRC6vtVuwY4bkTTwmDWgikAbxjf
 2aJ1vqzBvXkEohu+COBl7Rkr0pwfsPY2VYF6C63mWS/tvgTkjfg3Jga4ZPJ+re5ck/Sz
 xwrkPJFCIsJ7AQKWPS7bdMjyHKMYsqQF1by0Z4OyIVnwNM4+EYS7lGctMYDUqG8fkvDc
 vkY761L7iKKKwEW8Qex+sXDrzfTCJM11cWepqoP0fCuFcyxnrq9PI7gPClIImKSwqG78
 FXwA==
X-Gm-Message-State: AOJu0Yz9M9Xu4msinuxiDd1JR7WsWKXC+GqWTCEnVZ4gNOhMakGOmgM2
 KL4VldabY9LjVQVSTIZUqTFfuso9j9SHO2MquOTx6QO67Z1KAvyMDndR6GqEEJiZt0PUhf0GYmj
 F
X-Google-Smtp-Source: AGHT+IFKLQn/oY4IAR9q/UOiO0jPnTv3ONebY0lDtHjcgSlzC2I7xobgtZ4N/9xGUttZTdJHHXNneg==
X-Received: by 2002:a05:6a20:29a1:b0:1bd:289f:2cc3 with SMTP id
 adf61e73a8af0-1bd289f63b1mr453187637.7.1719328206324; 
 Tue, 25 Jun 2024 08:10:06 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70681722219sm4142636b3a.73.2024.06.25.08.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 08:10:05 -0700 (PDT)
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
Subject: [PATCH v4 13/16] tests/data/acpi/rebuild-expected-aml.sh: Add RISC-V
Date: Tue, 25 Jun 2024 20:38:36 +0530
Message-Id: <20240625150839.1358279-14-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42b.google.com
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

Update the list of supported architectures to include RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/data/acpi/rebuild-expected-aml.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index dcf2e2f221..c1092fb8ba 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -12,7 +12,7 @@
 # This work is licensed under the terms of the GNU GPLv2.
 # See the COPYING.LIB file in the top-level directory.
 
-qemu_arches="x86_64 aarch64"
+qemu_arches="x86_64 aarch64 riscv64"
 
 if [ ! -e "tests/qtest/bios-tables-test" ]; then
     echo "Test: bios-tables-test is required! Run make check before this script."
@@ -36,7 +36,8 @@ fi
 if [ -z "$qemu_bins" ]; then
     echo "Only the following architectures are currently supported: $qemu_arches"
     echo "None of these configured!"
-    echo "To fix, run configure --target-list=x86_64-softmmu,aarch64-softmmu"
+    echo "To fix, run configure \
+         --target-list=x86_64-softmmu,aarch64-softmmu,riscv64-softmmu"
     exit 1;
 fi
 
-- 
2.40.1


