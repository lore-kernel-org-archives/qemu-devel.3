Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B288C27C7B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6Ya-0000y8-0x; Mon, 17 Jun 2024 03:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6YG-0000Vj-Gr
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:13:19 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6YE-0002RX-KO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:13:16 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-579fa270e53so6014147a12.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608388; x=1719213188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HoghgUjXslv99c0oIEDxG9bbeaop6k9yBJ/Y2X/84U=;
 b=xihpoSuLiTV4xozsyvC2iN6IxIyl9n3F7ELqbX6naqOZ1MblgRJH8Dkf6Ny29TeeXo
 Kfg8mL+k4Ql5bsYwdio5y9vxI0aD1ip49Ytq5GIEKiQe6jUE+xLXLE57MjxaAx+RHIOR
 whjeDZ8b49LPOZ9ANk3n7dvTPYiDu6FcykvbNEgO7FX5BQSzeiQSlaQQOQm21yzlq4pi
 LFJ6RsIDxf+pIq0qe4t3chqu4t3qVx2ZmJ5rlTHlDU8EdmlmsenFjv77gj9cSJ1JUpy0
 t8XTiHGB/i8AsV0yGi7SYzsEGcpJrH3MS//rvYIRkXDNQ5Cw+8jdr0+cXtCjBKD0sYuB
 tQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608388; x=1719213188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8HoghgUjXslv99c0oIEDxG9bbeaop6k9yBJ/Y2X/84U=;
 b=Bat8S6+GAetkOv2u7RhGSt6Lp6RdmdTGhCy6Vvspu3uEZ81ggQt8VNonpYQpGbN82T
 T8k/EDmWEUuX+NCKkhqXb6TcEPjg4lihHOeEJpqieeTzBDXCCzOaL0tRPs8ChTjb2g/+
 DGCasLhPwvCX9PbU+VeXeU7Ue3fKnqWLbG3KV7inp/wNDR6yBHn0gGQ5xYBCDz1fvtGB
 hT46S5GJZb6vKnNGFZhA3RU8GxvNUtk1zbou6jaiDo/m/q3dai1OtgZ9BVIpOwAFVUDa
 26VrFgoa/Hc4AAux8+9tk793kvTKGX6H2mvcefQm7f7k3FOt33oxbCr/818K6Y5OAMOd
 axPw==
X-Gm-Message-State: AOJu0YyX8SaDdwVNU3P8YbZjK33LXyzczr+5R5UB1TXz/NjwQUgeFJjH
 3wPF7mepr1rpRerCwX+uP77q1SK3PQX/do9aQPrjyYSHL3CAXZmW73seg+8zozIayFvnileljYC
 GMEI=
X-Google-Smtp-Source: AGHT+IEVR52rafdg3qRpw8weTV6vAqetW1JF5w3QDD9hadhphQVmdGBfk1Ps106quLaAo/59LSVtpw==
X-Received: by 2002:a50:9557:0:b0:57a:33a5:9b71 with SMTP id
 4fb4d7f45d1cf-57cbd69eb5dmr8062641a12.33.1718608387738; 
 Mon, 17 Jun 2024 00:13:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb741e782sm5967415a12.64.2024.06.17.00.13.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:13:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 19/23] hw/i386/acpi: Remove AcpiBuildState::rsdp field
Date: Mon, 17 Jun 2024 09:11:14 +0200
Message-ID: <20240617071118.60464-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

AcpiBuildState::rsdp is always NULL, remove it,
simplifying acpi_build_update().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 158e74f64a..f4e366f64f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2458,7 +2458,6 @@ struct AcpiBuildState {
     MemoryRegion *table_mr;
     /* Is table patched? */
     uint8_t patched;
-    void *rsdp;
     MemoryRegion *rsdp_mr;
     MemoryRegion *linker_mr;
 } AcpiBuildState;
@@ -2714,11 +2713,7 @@ static void acpi_build_update(void *build_opaque)
 
     acpi_ram_update(build_state->table_mr, tables.table_data);
 
-    if (build_state->rsdp) {
-        memcpy(build_state->rsdp, tables.rsdp->data, acpi_data_len(tables.rsdp));
-    } else {
-        acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
-    }
+    acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
 
     acpi_ram_update(build_state->linker_mr, tables.linker->cmd_blob);
     acpi_build_tables_cleanup(&tables, true);
@@ -2804,7 +2799,6 @@ void acpi_setup(void)
                            tables.vmgenid);
     }
 
-    build_state->rsdp = NULL;
     build_state->rsdp_mr = acpi_add_rom_blob(acpi_build_update,
                                              build_state, tables.rsdp,
                                              ACPI_BUILD_RSDP_FILE);
-- 
2.41.0


