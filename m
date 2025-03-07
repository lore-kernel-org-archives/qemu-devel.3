Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2DCC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdB7-0007JP-OM; Fri, 07 Mar 2025 14:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tqdA0-0004mg-4B; Fri, 07 Mar 2025 14:15:06 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tqd9w-0007mq-CJ; Fri, 07 Mar 2025 14:15:03 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 153F6A45158;
 Fri,  7 Mar 2025 19:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6899C4AF0B;
 Fri,  7 Mar 2025 19:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741374897;
 bh=rfeQeGss/MoU2Xcp08lVDvvFnOrqh+GtyoihS5g84ow=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EstRwrote58HU7ASLhnrkKN8dhG+0NOzcsskJtSylzNTT2wnKCUBQxKkJ7havJWTh
 KxwGxjstd1UgD/p0xcB8LEoXl68vLTcpb0osE+HG+BNtXIUheAsAUArKfqAMbcBop4
 a0fXHIGoTpq99NGOaxUOOLY3Er0jCvMr6ytJYvPT/Z154dBwQHvjgd26Zwia8q8Q8L
 T8U3a/enVOb/5OXr75sT6TX/zXK9J9kfex42cTs8B4jKbsalPNniQ+rJZ5GSP5Tnfu
 vnRFy8scd1M7vuJcsnDL6aVfGx2ioI2FCXRyqm4RIutD23vUYbriLjse6i+MObADF2
 D0wm7fP+zbCPg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tqd9r-0000000BQmR-34fX; Fri, 07 Mar 2025 20:14:55 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Gavin Shan" <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/20] Revert "hw/acpi/ghes: Make ghes_record_cper_errors()
 static"
Date: Fri,  7 Mar 2025 20:14:33 +0100
Message-ID: <9cb6c734f32f01206db562b9a406829bf81e19d9.1741374594.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741374594.git.mchehab+huawei@kernel.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The ghes_record_cper_errors() function was introduced to be used
by other types of errors, as part of the error injection
patch series. That's why it is not static.

Make it non-static again to allow its usage outside ghes.c

This reverts commit 611f3bdb20f7828b0813aa90d47d1275ef18329b.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c         | 6 ++++--
 include/hw/acpi/ghes.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index b85bb48195a0..b709c177cdea 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -390,8 +390,8 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
     *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
 }
 
-static void ghes_record_cper_errors(const void *cper, size_t len,
-                                    uint16_t source_id, Error **errp)
+void ghes_record_cper_errors(const void *cper, size_t len,
+                             uint16_t source_id, Error **errp)
 {
     uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
     AcpiGedState *acpi_ged_state;
@@ -440,6 +440,8 @@ static void ghes_record_cper_errors(const void *cper, size_t len,
 
     /* Write the generic error data entry into guest memory */
     cpu_physical_memory_write(cper_addr, cper, len);
+
+    return;
 }
 
 int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 578a582203ce..39619a2457cb 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -75,6 +75,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
 int acpi_ghes_memory_errors(uint16_t source_id, uint64_t error_physical_addr);
+void ghes_record_cper_errors(const void *cper, size_t len,
+                             uint16_t source_id, Error **errp);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
-- 
2.48.1


