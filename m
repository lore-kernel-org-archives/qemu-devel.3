Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AFB606A786
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WjejhTfL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSug5-0005aO-Me; Mon, 16 Nov 2026 06:15:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSuef-0003wH-VP
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:46 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSued-0002E4-CU
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:45 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so1385323f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827622; x=1795432422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=axHm2KD5tqEhcxv0LLLMI45i4rCgo/rHakMhYkIY7So=;
 b=WjejhTfLYcL1uOethNh4Ec3L6OO4uh68aVBZDRHZJc9tPpEFKrk4cIdTf0SrPukg03
 xd1sdpQnd7pU7J5HH8q2aq4F2JBZihyHjPh9Ibxg6h4IAKNcy2wqeGgT59LlVNnNX8VT
 8R28fgxciBMyg/LVZ6oQTfweLd/GtAaD2IydZPXbEhYIpt6kM7Fer9zKAU0Zp/sr3lRy
 ouR00QBnoUtoJWvAtkeGvq1FXzXoroVXCNpiIhU+fkMv0c6qGXZkGCgp+muT1TW6nVyo
 o4nLh9XcOW/qIJIBEnwyovGB/5H6z1HAqXFd7CBkGTWuDNOJwTqeYnpbAMhE5ZYk75M3
 iLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827622; x=1795432422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=axHm2KD5tqEhcxv0LLLMI45i4rCgo/rHakMhYkIY7So=;
 b=uL1nqau81ERBG0QHe79FC4UVF5AkAIDPYsQitd9AKxqF27FbKSLvgwT71DYCokL73/
 PWWw/xzMp/sPlSm09kE9x7m+3jCoYSeeocRSv1wXZcww0JUp44eRmnxIIawxultQqKJX
 Xex9T0Y2QCuYbJyMUUlSf7s9m5z++CwFBlMipHHVTAEI2keIVmagvWg2uR6KOkvxPgA3
 HJ9TwU05N+Gtp5BUABsQdbb/yRdIY5bCVE4ElGrgMaTVdhIzFahOYqQbqc11CktzZBJK
 xDB5Fla4ulM6/NVFRfyUCY8t0MpoIQ/zn8lF1QuEr7ipDsoSJcw0A5xaE8s2rpUkeQs1
 YHbw==
X-Gm-Message-State: APuU4Z/MfR6NsSvkrzmnEAQL4voF6Bxo7iiioQLlHlz90kaXNROhv67W
 v7JFUo1iu4jiBaRIYIXZBHqWslXvqAsszt/ouR4blLK89+0hg3xiqKju8my+WOB+/E0akpiIxqq
 /Eil/ekQ=
X-Gm-Gg: AZFdTZcPkVEKCmKT/E1LmP00bPC/zP87amj9ngAgJAeeGWsPXMJ0ij+3uRyDkgVItFD
 Lebe4XXRBVP6ktDg/O+e2hEOoMV3qeMR9zttRgUf6/mcJmdp7R8W0RLl7i7VArxiZZXC68O0nRj
 Bbf1RQXarUVXrOdiJP9Kq4TCQ/svK4owpgMnhrVkCBz71chG4HEpTKOs+augh39XZurE+PVBP/W
 fISmrTV/S/DtI0LxdpCy9Hx4alMBm5u8ea0uaGW9Ztf++WsZBuHnBEhl2kdtK54Xv0u8+CwB78t
 xVgiUl07rjNGpSpUfYtiCU/1r+KbS3478myEihctY7y486d32TbyFkuUu6BvZj+NwgsCApTgON/
 EI45/oXJl6IfEprJ1H1/OJ4cUFgpdghqCLEe8WIlLOmP52gzUZCPh6YkfnHmxaH9IORkIffx0Xt
 nVewchzmpZ4+t3o2s2j1BhbS8Wqv424k8gbPH43txJ7n7CZV2PDmqfbwSxyqflZYuST4i8K5LrX
 fqiuloTTTk/yHERLeL7YbDv6y8fQftzfYF/UOqc7J9pKYby/bGr+XsfZJv3avwtNbPhBXHkBHuN
 TSt5FmCd8iVIEKNYG3q1wLYdIhLcA9vYQDiqbsoRn1uc24cqImEyqigiGE6dElHwOkvL5xrHwHo
 bNg1xgm+AN+BlzDtWKl+G6LR2xxzYzC/0nQ==
X-Received: by 2002:adf:e19b:0:b0:498:b92a:2f7 with SMTP id
 ffacd0b85a97d-49c71d49040mr20866683f8f.30.1794827621929; 
 Mon, 16 Nov 2026 03:13:41 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/33] hw/arm/virt-acpi-build: test vms->acpi_dev before
 building HEST
Date: Mon, 16 Nov 2026 11:13:03 +0000
Message-ID: <20261116111303.1692832-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ren Yanyi <kevinren114514@163.com>

virt_acpi_build() gates HEST table construction on:

    acpi_ged_state = ACPI_GED(vms->acpi_dev);
    ags = &acpi_ged_state->ghes_state;
    if (ags) {

ags is the address of the ghes_state member of AcpiGedState and can
never be NULL, so the check always passes.  Whether the GED device
exists is a separate condition (has_ged also depends on firmware
being loaded and on ACPI being enabled), so a machine started with
ras=on but without a GED device reaches this code with a NULL
acpi_ged_state; ags then holds a bogus non-NULL pointer and
acpi_build_hest() dereferences it.

Test vms->acpi_dev in the enclosing condition instead, so the HEST
table is only built when the GED device exists and the ACPI_GED()
cast is always valid.

Fixes: 2e9c5c5bc85a ("acpi/ghes: prepare to change the way HEST offsets are calculated")
Signed-off-by: Ren Yanyi <kevinren114514@163.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index d368913e766..5670d1eca71 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1406,7 +1406,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_dbg2(tables_blob, tables->linker, vms);
 
-    if (vms->ras) {
+    if (vms->ras && vms->acpi_dev) {
         AcpiGedState *acpi_ged_state;
         static const AcpiNotificationSourceId *notify;
         unsigned int notify_sz;
@@ -1414,21 +1414,20 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
         acpi_ged_state = ACPI_GED(vms->acpi_dev);
         ags = &acpi_ged_state->ghes_state;
-        if (ags) {
-            acpi_add_table(table_offsets, tables_blob);
 
-            if (!ags->use_hest_addr) {
-                notify = hest_ghes_notify_10_0;
-                notify_sz = ARRAY_SIZE(hest_ghes_notify_10_0);
-            } else {
-                notify = hest_ghes_notify;
-                notify_sz = ARRAY_SIZE(hest_ghes_notify);
-            }
+        acpi_add_table(table_offsets, tables_blob);
 
-            acpi_build_hest(ags, tables_blob, tables->hardware_errors,
-                            tables->linker, notify, notify_sz,
-                            vms->oem_id, vms->oem_table_id);
+        if (!ags->use_hest_addr) {
+            notify = hest_ghes_notify_10_0;
+            notify_sz = ARRAY_SIZE(hest_ghes_notify_10_0);
+        } else {
+            notify = hest_ghes_notify;
+            notify_sz = ARRAY_SIZE(hest_ghes_notify);
         }
+
+        acpi_build_hest(ags, tables_blob, tables->hardware_errors,
+                        tables->linker, notify, notify_sz,
+                        vms->oem_id, vms->oem_table_id);
     }
 
     if (ms->numa_state->num_nodes > 0) {
-- 
2.43.0


