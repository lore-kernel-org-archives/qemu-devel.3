Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A8DC54E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFet-0007J2-4W; Mon, 18 Mar 2024 12:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeT-00075z-6h
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeR-0004bS-Hz
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8d1jC5pXP2pg+IhFhot7syCv1JspX4H/Mza9SReTv6M=;
 b=XKSuGiShOVemxrLHANX8aD95c0tIyWNiH1si1xiHxGmSy5BOJFboNx1fKYD7D/517TJdLx
 e8uUy+idyljeHkwa2pqp1TQMSRss3ioUt+GPKlbi9FjOU/idLUd70Vni3j8By/3Uo40SlG
 CGLOPZwap96AOVZ1P1W8xo2kE3wM98c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-_wzDt6T7MBuKIzNAKl0YrA-1; Mon, 18 Mar 2024 12:15:48 -0400
X-MC-Unique: _wzDt6T7MBuKIzNAKl0YrA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40e435a606aso24420895e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778547; x=1711383347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8d1jC5pXP2pg+IhFhot7syCv1JspX4H/Mza9SReTv6M=;
 b=Ceb035jxgGx2AOtyPfZtWXYPu8Z1ybAPF9RuDhhj0YCEShXyeik6Uw6qOkNZjdZhrf
 kU3PVBpLok8VBGqQhsxUIAS945iBY6I2+VzDaBxOIC1y3IrhpFoM0dAyk7MvTJqsUMMb
 nreQs6a8vwCDNj1LApfDKibzSzrVA5Jvg16F9uYQtuLOFr5oBkXi8Zhu3s3UEVN5M1Pb
 aT0p2YJFZxTRjMIs0QakEvZAeQkGctk1RT2K2l6HIk9M4cR4YX/4r0vD93wIDq1la/ul
 VlHhsQFVlvlDI63g5w6Ciwr8Qw2pDfrUn5Ob+qfaT9GHQv0L8jAi5CDWeuSPFQp/HtG6
 T0iA==
X-Gm-Message-State: AOJu0Yxve6rcOvHsIDN/MQlhKXOUW+lR8h9QD4++8wuMDLM4c4scQIqU
 i91kjWiig/EvrWUt1DuTI3ZZTrwdWbP8SAzFw0Q2dDL86YS5+u8l5MtIqDG0g7HSEHmX/+EmcvP
 ymX+YSPX4PVk7dG5dlosFVCdfQ2jE67K9+jiK+laal/rIOSb6g/U6AndgvlwGPba/QZ6khkVtO5
 wC40q8zVJjHUolPon2rxEZnPBNpxL10w==
X-Received: by 2002:a05:600c:3b24:b0:414:c63:a781 with SMTP id
 m36-20020a05600c3b2400b004140c63a781mr2788653wms.1.1710778546673; 
 Mon, 18 Mar 2024 09:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEw/sgTN9t+PBLuBuLzNZ6aCF0W9/g9KluberChmqPTXSkXcuAjiIOLBuZMw3vswXzUc6EcQ==
X-Received: by 2002:a05:600c:3b24:b0:414:c63:a781 with SMTP id
 m36-20020a05600c3b2400b004140c63a781mr2788636wms.1.1710778546227; 
 Mon, 18 Mar 2024 09:15:46 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c4f9400b00414610d9223sm687173wmq.14.2024.03.18.09.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:15:45 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:15:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 05/24] tests: smbios: add test for -smbios type=11 option
Message-ID: <ed75658af39ea29c5bf2d6fd2c645a54c95db78a.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240314152302.2324164-3-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c |  17 +++++++++++++++++
 tests/data/smbios/type11_blob  | Bin 0 -> 11 bytes
 2 files changed, 17 insertions(+)
 create mode 100644 tests/data/smbios/type11_blob

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index b2992bafa8..a116f88e1d 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2091,6 +2091,21 @@ static void test_acpi_pc_smbios_options(void)
     free_test_data(&data);
 }
 
+static void test_acpi_pc_smbios_blob(void)
+{
+    uint8_t req_type11[] = { 11 };
+    test_data data = {
+        .machine = MACHINE_PC,
+        .variant = ".pc_smbios_blob",
+        .required_struct_types = req_type11,
+        .required_struct_types_len = ARRAY_SIZE(req_type11),
+    };
+
+    test_smbios("-machine smbios-entry-point-type=32 "
+                "-smbios file=tests/data/smbios/type11_blob", &data);
+    free_test_data(&data);
+}
+
 static void test_oem_fields(test_data *data)
 {
     int i;
@@ -2244,6 +2259,8 @@ int main(int argc, char *argv[])
 #endif
             qtest_add_func("acpi/piix4/smbios-options",
                            test_acpi_pc_smbios_options);
+            qtest_add_func("acpi/piix4/smbios-blob",
+                           test_acpi_pc_smbios_blob);
         }
         if (qtest_has_machine(MACHINE_Q35)) {
             qtest_add_func("acpi/q35", test_acpi_q35_tcg);
diff --git a/tests/data/smbios/type11_blob b/tests/data/smbios/type11_blob
new file mode 100644
index 0000000000000000000000000000000000000000..1d8fea4b0c6f040a13ba99c3fad762538b795614
GIT binary patch
literal 11
Scmd;PW!S(N;u;*nzyJUX)&c?m

literal 0
HcmV?d00001

-- 
MST


