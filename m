Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B50AC25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 06:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAODa-0003B0-Mp; Fri, 24 May 2024 02:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sAODB-0002br-AY
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:15:29 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sAOD9-0001Po-Aq
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:15:29 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5b295d6b7fbso3975267eaf.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 23:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716531325; x=1717136125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrXaQc53ipIFlLePhseHKfjVcL4zLVxbYhNZg/WizrI=;
 b=hr5X02thrfbM/UPTRx9NB9KP7kt3qFs2Z1x3k98furCXvS/U4vE8wkQHwDyc+iQ59N
 +QmBpkJZuo2sGgyHlKXOKzqCbjzzBtif51fF8iW7s0FAxMzPXzyYlY2Vkzy6R3zA1yGU
 RoH+u69hQALACjBtJZsm5DcrIz9e7XPhvSo1ZnyAplB2cdBy4n0z5m8t0oI1r8JHALRe
 MPCRjmAf+P5YjkxJPEBrW8UCJ73rYuCeUX1EsxPeNKZzNq1ZShQz/WBgX8ZvzhRJBYJT
 MkQPa+rL8L6A4TwnleeRuEkpkaudYyQEyBaOzdiAiR+c+DhVe0SCqSy/0fsym/QNn7wH
 J5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716531325; x=1717136125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrXaQc53ipIFlLePhseHKfjVcL4zLVxbYhNZg/WizrI=;
 b=QrnUhkL7akVe2Wzz5NZ6vmDxm+HFdSf6sgzdrrWUzmzTiTIak3+etudxvzjAYEdgTm
 tsuNuOErQOhoTH7+Hy7yLxH4kQN4sST8DLqEJPXVCsT5xGLfYBf2zIrBKvPveBssGDmh
 kKaxjICkByKx5IG4WCuhpvRRlYW4KPZ/WEDlOEiq/K7rgNy90+wgLNw8nqcxjMcX3Myx
 yElYjHkodA/gXFBdDw/MMIJUlhVn+BjMOTwNyrUjZj4y0qk77D0JI9DB/o7R3YKaMWUM
 cVo/dt/KV3EP818r9llaqJnticYdPrbaEuLoqjxayk5DeFIIqjsp+5dqM6XH79OUOiy+
 qJAA==
X-Gm-Message-State: AOJu0YxXKUjDfNYCzAUZF07gUeXgKKMaPK4l95IurvnQQUfywhnG6UFd
 kW7kT101j5UFgmdfdaMc6C7ltqI3uDIO1Qvwsk5yNUHtcnoGBd5Kun+pmYJwFpKIqJHB+Sw9VyG
 DC5s=
X-Google-Smtp-Source: AGHT+IFmNqF7tf0HzUPAB9tJZDvioFwJOD/W+ZamvWyWohGEK0Ob0qiQ8x/mdUM7luoL/+TAs/vlVw==
X-Received: by 2002:a05:6870:158b:b0:23e:7432:6f12 with SMTP id
 586e51a60fabf-24ca151bee2mr1402393fac.45.1716531325033; 
 Thu, 23 May 2024 23:15:25 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.31])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcbea487sm516106b3a.107.2024.05.23.23.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 23:15:24 -0700 (PDT)
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
Subject: [PATCH v2 09/12] tests/data/acpi/rebuild-expected-aml.sh: Add RISC-V
Date: Fri, 24 May 2024 11:44:08 +0530
Message-Id: <20240524061411.341599-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524061411.341599-1-sunilvl@ventanamicro.com>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oo1-xc2e.google.com
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


