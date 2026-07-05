Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22186C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwF-0005GF-O8; Sun, 05 Jul 2026 10:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwD-0005Fn-F1
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwB-0001LB-Q5
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TN4hM0h/oeHfWerEOP7yQ+tFpXqcE34vqzrhfzhWtJk=;
 b=h2R+QY0jyRxmyj+Qu/iMz/GHFtxajGzPJXYMoYc8VWW5YLUy5WlE7rdybxYyea7qMSFmbd
 m84AUtGnP7LRU6D0dx7Ij7oClLKhzjoC8Zjc677tv8AwFdLKA/bRssG2oTSgyRYGbfSQSQ
 tKdhrjZUatYydjLzfTWyIwTsRD3Zpf8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-fUouAC_TNKehc38A7II_lA-1; Sun, 05 Jul 2026 10:35:13 -0400
X-MC-Unique: fUouAC_TNKehc38A7II_lA-1
X-Mimecast-MFC-AGG-ID: fUouAC_TNKehc38A7II_lA_1783262113
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4926fa2cb17so20276945e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262112; x=1783866912; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TN4hM0h/oeHfWerEOP7yQ+tFpXqcE34vqzrhfzhWtJk=;
 b=czdlnBC5lJkecZ+2Y7l9dgMx9NPFdzcIXES+N8FMo31j0svYeaQ9CLWcXH+UZcNh2k
 UIohzrTxF1ssFW1kLLYg8QDZcfBA34n1/bAKY+cUJ/1xj3VhQ22Q93PhNqiXD/BjwWft
 3FOUcMRK9DoXAFSemw7eZiCzOiJ6RKQyB9QS0E1yCBuy7zos21KBOQ9c4ltJSGemkbxl
 Ii3Nh8p8yFz4QDBDdljqksCo/bYPKpjePgH4GSjWPk9YGhR9gFTIVb73mvgE/o0Jit4t
 tqDqfHkgha8i05Sv3s6RxFN3BTPy07s2JH9pqae3X93YVOGDyEdXXmIgXsw22us8JnwF
 azUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262112; x=1783866912;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TN4hM0h/oeHfWerEOP7yQ+tFpXqcE34vqzrhfzhWtJk=;
 b=kaETnWj8Icd43KdO1jJWr8f/kcT2xUCHBjSLa7SyKqqX3m9HFxQFGkLAi9Bf+oa/I9
 Dz5QGEp/nwy3BywBKt4/j1sN5J2OM8Q4gqkYmgEvukvElQdYo0xu90NqDUFNF9BDIGVX
 A02si/Bc042OUcTwCJz3ssCST/IAA53iDy5Nia4LmALNkHVeytt5bgK7rsSyHvKWKn8U
 od6cdJhR/hGZv6wpN0lDASIPWB9xQUaWrTNihdoc4/cXIJiAhfuZpxlu514NCk/OFNej
 ShXkqYmros/5gE+4YZlt8qIbsi4eHlPEjMC+ouRtBuTL1XaRSsBQZQi3q7NCRIqH5muP
 AwzA==
X-Gm-Message-State: AOJu0YycyeWo3gBed6VY/2TSkTlN4IFfFVAH4lb5AOjVA0ZlVfPoIzEt
 og8TfAEBc28a5NjM47VOW9Ec3Gl1SkOpUE87eIHmFny2n+SoyAjuusjMKLt422Uwhl2ncuu3hpX
 foHBX6xTCm3zJbuRtG5MMpb0UGE9Pw2rk04AT85zFFTWAWj0zinnDrcuy/6wPXEY0BlhESeXMES
 LM0C8mV9G3sI9Pksg5XGjhVnTOxz6hUtKc4Q==
X-Gm-Gg: AfdE7cmL/qBV0qpVRxIEF7u0zjxEduAyNRpNGOu1uFdnjlS8lX+2YUms8VvAv7E4Ypj
 klRuRa6Uo+Z23VNksQ3/1IkztWuCpu7UNmlMn7Ph6lvADMEeKZKfV3TU2KL2OlqXPlOF4j/P1BT
 s+nlxBgKXsdmIVdi7Q29PoSVMkLJD4p2nle6tHo1DSQhRPIv+ULfjFBd5xY4EXttb3J8FV6A7We
 MlW0pEOIkL0SgQU8riO39mC7OGhDgfZwz/qFaHzdReupIBkwN2dVuPKAsndhNR3t9Rd062/u3Pj
 kXhU76fbnyqzF9sKCXDXW6EDT6BSmd4F9B3lCHQ7v3kestIwRCXmWdCBAeEZc9plQ2TDND/WQlT
 abzHZDNvoAe4EHDkJkwH1NNWWc6hp0fBn
X-Received: by 2002:a05:600c:6287:b0:490:af63:2cb1 with SMTP id
 5b1f17b1804b1-493d128b6e3mr63750955e9.7.1783262112457; 
 Sun, 05 Jul 2026 07:35:12 -0700 (PDT)
X-Received: by 2002:a05:600c:6287:b0:490:af63:2cb1 with SMTP id
 5b1f17b1804b1-493d128b6e3mr63750725e9.7.1783262111864; 
 Sun, 05 Jul 2026 07:35:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c637bc21sm518262585e9.7.2026.07.05.07.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:11 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 fanhuang <FangSheng.Huang@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 12/44] tests/acpi: add bios-tables-test case for sp-mem
Message-ID: <ff1d11b7bfb34941c13cd70668f4f9e253c588ba.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: fanhuang <FangSheng.Huang@amd.com>

Add a q35 bios-tables-test case that boots two sp-mem devices on
distinct NUMA nodes within the device_memory window, exercising the
per-kind SRAT partition (per-device ENABLED entries plus HOTPLUGGABLE
placeholders for the remaining sub-ranges).

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260623075051.3797975-8-FangSheng.Huang@amd.com>
---
 tests/qtest/bios-tables-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index af6d9b5136..45abd8bd8c 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1416,6 +1416,26 @@ static void test_acpi_q35_tcg_numamem(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_sp_mem(void)
+{
+    test_data data = {};
+
+    data.machine = MACHINE_Q35;
+    data.arch    = "x86",
+    data.variant = ".spmem";
+    test_acpi_one(" -m 128M,slots=4,maxmem=1G"
+                  " -object memory-backend-ram,id=ram0,size=128M"
+                  " -numa node,nodeid=0,memdev=ram0"
+                  " -numa node,nodeid=1"
+                  " -numa node,nodeid=2"
+                  " -object memory-backend-ram,id=spm0,size=128M"
+                  " -object memory-backend-ram,id=spm1,size=128M"
+                  " -device sp-mem,id=sp0,memdev=spm0,node=1"
+                  " -device sp-mem,id=sp1,memdev=spm1,node=2",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_kvm_xapic(void)
 {
     test_data data = {};
@@ -2807,6 +2827,7 @@ int main(int argc, char *argv[])
             if (strcmp(arch, "i386")) {
                 qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
                 qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
+                qtest_add_func("acpi/q35/sp-mem", test_acpi_q35_tcg_sp_mem);
                 qtest_add_func("acpi/q35/acpihmat",
                                test_acpi_q35_tcg_acpi_hmat);
                 qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
MST


