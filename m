Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DD4C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFeY-00077K-Qc; Mon, 18 Mar 2024 12:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeR-00075J-8C
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeO-0004aw-I9
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VAGzRhA3KrnZclGngelP6JYgHXE64SaHbxnIXaBAvLk=;
 b=RkBXWT+msnhb6cuYe51trIZo0aBTrL4991MH8Jo8gfFDzhGMaBpylC93YZgavzFKB7lT/C
 /PVDhHUKeBfvqULGvJt+ApSWqSBfEM+uAFJWJCIAc3uDeeE8RLvh++MzSYP62uLku6ZfPf
 g+wHwb3a9rPV1mdlW+44sbKhymD9PoA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-0bVnEgNSMnmdVVIkGr3x5g-1; Mon, 18 Mar 2024 12:15:45 -0400
X-MC-Unique: 0bVnEgNSMnmdVVIkGr3x5g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-514b4c75fc5so512202e87.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778543; x=1711383343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAGzRhA3KrnZclGngelP6JYgHXE64SaHbxnIXaBAvLk=;
 b=W1wz1Y1X5P1zlr+1e1Cb5VoJbswaottoNmWSe+hEqgqfv5WNtgn/Kk5x8zdMo2mHxZ
 uWBt+Q01tj/nPG1QK4nt5jSHeRVXN7hW12lFqIBjAPkzCiZYpNcOcDBFFDj51/T6zNtq
 NhY56bNOzZwVrxWl6fl6JsM1r0Dsk/t8ylTFlmhheAGvJ2HSz+CEsSGgnno5pj9Wt4dt
 CfLy+jZ5JGd9BFGOecn7pBudjGcan3wrSnF6HBGjwsf2iPJsYR0xLgId33myqRTY/oII
 dOZqtILv+fXhW4heAUWju5Y4hEdeoiersBaCkXe4ND/Io61gSmjvXe8uzMHa/QVWsKUN
 iSag==
X-Gm-Message-State: AOJu0YzBHLKJOUMxjODYkeECa/vDvV6F9fr4ktvtnNsDtz9+0jKJ/yye
 Q+xEOoyQ5CqMWj+qrxeGDUSB1N/xIwNCmAevijy1bsz2STcC30o/GpV0N72bZWPcdNmZhYxDT54
 DtvNGFFPjkNu5qAH21Z0uxkIqWF8K20neG02aQMop7B3+0m+mkmyWpaTtvWFfG3UyfVGh4/tBKL
 jLaMFGEe6richmtTLjkkDIxypnau5FzQ==
X-Received: by 2002:a19:5f5a:0:b0:513:d372:20f7 with SMTP id
 a26-20020a195f5a000000b00513d37220f7mr7541813lfj.21.1710778543410; 
 Mon, 18 Mar 2024 09:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgek161MYUHnJIbjyYLQZ0h22d8qmpM22vUfL3pAJbbWqVTj8oNWXTIjsVD8Jq+m/tE9Bclg==
X-Received: by 2002:a19:5f5a:0:b0:513:d372:20f7 with SMTP id
 a26-20020a195f5a000000b00513d37220f7mr7541794lfj.21.1710778542845; 
 Mon, 18 Mar 2024 09:15:42 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c450e00b0041409db0349sm7074200wmo.48.2024.03.18.09.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:15:42 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:15:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 04/24] tests: smbios: make it possible to write SMBIOS only test
Message-ID: <53002d9028f9d8b3215dafd7c0a55047bb5c9804.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Cureently it not possible to run SMBIOS test without ACPI one,
which gets into the way when testing ACPI-less configs.

Extract SMBIOS testing into separate routines that could also
be run without ACPI dependency and use that for testing SMBIOS.

As the 1st user add "acpi/piix4/smbios-options" test case.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240314152302.2324164-2-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 47 +++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 21811a1ab5..b2992bafa8 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -858,6 +858,27 @@ static void test_vm_prepare(const char *params, test_data *data)
     g_free(args);
 }
 
+static void process_smbios_tables_noexit(test_data *data)
+{
+    /*
+     * TODO: make SMBIOS tests work with UEFI firmware,
+     * Bug on uefi-test-tools to provide entry point:
+     * https://bugs.launchpad.net/qemu/+bug/1821884
+     */
+    if (!(data->uefi_fl1 && data->uefi_fl2)) {
+        SmbiosEntryPointType ep_type = test_smbios_entry_point(data);
+        test_smbios_structs(data, ep_type);
+    }
+}
+
+static void test_smbios(const char *params, test_data *data)
+{
+    test_vm_prepare(params, data);
+    boot_sector_test(data->qts);
+    process_smbios_tables_noexit(data);
+    qtest_quit(data->qts);
+}
+
 static void process_acpi_tables_noexit(test_data *data)
 {
     test_acpi_load_tables(data);
@@ -868,15 +889,7 @@ static void process_acpi_tables_noexit(test_data *data)
         test_acpi_asl(data);
     }
 
-    /*
-     * TODO: make SMBIOS tests work with UEFI firmware,
-     * Bug on uefi-test-tools to provide entry point:
-     * https://bugs.launchpad.net/qemu/+bug/1821884
-     */
-    if (!(data->uefi_fl1 && data->uefi_fl2)) {
-        SmbiosEntryPointType ep_type = test_smbios_entry_point(data);
-        test_smbios_structs(data, ep_type);
-    }
+    process_smbios_tables_noexit(data);
 }
 
 static void process_acpi_tables(test_data *data)
@@ -2064,6 +2077,20 @@ static void test_acpi_q35_pvpanic_isa(void)
     free_test_data(&data);
 }
 
+static void test_acpi_pc_smbios_options(void)
+{
+    uint8_t req_type11[] = { 11 };
+    test_data data = {
+        .machine = MACHINE_PC,
+        .variant = ".pc_smbios_options",
+        .required_struct_types = req_type11,
+        .required_struct_types_len = ARRAY_SIZE(req_type11),
+    };
+
+    test_smbios("-smbios type=11,value=TEST", &data);
+    free_test_data(&data);
+}
+
 static void test_oem_fields(test_data *data)
 {
     int i;
@@ -2215,6 +2242,8 @@ int main(int argc, char *argv[])
 #ifdef CONFIG_POSIX
             qtest_add_func("acpi/piix4/acpierst", test_acpi_piix4_acpi_erst);
 #endif
+            qtest_add_func("acpi/piix4/smbios-options",
+                           test_acpi_pc_smbios_options);
         }
         if (qtest_has_machine(MACHINE_Q35)) {
             qtest_add_func("acpi/q35", test_acpi_q35_tcg);
-- 
MST


