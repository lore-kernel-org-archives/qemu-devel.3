Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FCCC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVglH-0000l2-BD; Sun, 21 Jul 2024 20:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkt-0008NN-Bq
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkr-0005t3-P3
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=glIE7906tG8xbsdQlnyVht0Qfp0CHdCdyn4JQdsY2qk=;
 b=Yd9GAm1v0TmHHD2KmtIDEeevzCmkrc+GRz6Ut6JBOsPjQxzWL2xP501mKa/kSvtZSawBpR
 jo853tAPFb+/Zaa2laXsdCURUxmgTEhy3qSwiwerjyeeNYBshEwOfkRXUzaPFrDZzrgU6Y
 SfataLdZTV9FERTQkME6MLpQ8QB2j2I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-MHxxYfQKPOmD-CqxkAw0-w-1; Sun, 21 Jul 2024 20:18:15 -0400
X-MC-Unique: MHxxYfQKPOmD-CqxkAw0-w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36865706f5eso2223908f8f.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607494; x=1722212294;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=glIE7906tG8xbsdQlnyVht0Qfp0CHdCdyn4JQdsY2qk=;
 b=DNDolvy2MYjlqnhb3syWYjNOlkonFJ7wYCJFH6hx5E5hFi6w8NK+or0fnU/hcWAJ6D
 JakX37MfMh9JG+1ZEJVda8Gg6e+o+F0PBFBrUJUu8NxJ5bzEbkkHmJeV+U5q4J8KSBNO
 DaAjZcMUCN2SgN/EdHV0sC8S+B8O/qw1js/TKctocucxQRpKEbyf8Ux4Pgx1X74ZmPtx
 fxOY8aS/keESBh0rdS2MAmok3pZVAGB4VqygnEt8HOhRCnX09PC59aeJZmknrDRk1ULU
 2hpD+qhfcillrgHZpwEdDxeIYX777QhxCywo7D16EFyHeB2IsYHYoH0kus1FbBYNSOA3
 DLNg==
X-Gm-Message-State: AOJu0YyrgfCXambCNcV9goPjCwmPEKDC0M98rNbYm4FA766Rjj3ozC7Y
 5M9Fa+sogBIshJLkAUfjyOEerJ1QJ+n+oXqfXljkT6+w+TYPicpXO4u0SX7ZVMBKTTFetzhpDBL
 o71/nd0WcqyFstVu64ZFp7kjrcIU+eggpIAST5meO914gwwHF4f05aY00EJ0q6M6hKzNcaRq2rJ
 9Hl+aKUkVfSCa/20jRJsXkgD4pJZguhQ==
X-Received: by 2002:a5d:6b0d:0:b0:368:4edc:611e with SMTP id
 ffacd0b85a97d-369bae3c846mr2760755f8f.14.1721607493822; 
 Sun, 21 Jul 2024 17:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqsaSk4gFPaUyOndWdxQeO0NqdQGJSWQv/k9l7RrZGhO3ssqhFlMhx43tJdHhQ3oT/Bq9sWg==
X-Received: by 2002:a5d:6b0d:0:b0:368:4edc:611e with SMTP id
 ffacd0b85a97d-369bae3c846mr2760734f8f.14.1721607493340; 
 Sun, 21 Jul 2024 17:18:13 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ceccasm6962687f8f.81.2024.07.21.17.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:12 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Gavin Shan <gshan@redhat.com>, David Hildenbrand <david@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>,
 Vishnu Pajjuri <vishnu@os.amperecomputing.com>,
 Xianglai Li <lixianglai@loongson.cn>, Miguel Luis <miguel.luis@oracle.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 39/63] hw/acpi: Move CPU ctrl-dev MMIO region len macro to
 common header file
Message-ID: <9b16367d9ab2ab32fbd48b4c243a33ba66eb79ce.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

CPU ctrl-dev MMIO region length could be used in ACPI GED and various other
architecture specific places. Move ACPI_CPU_HOTPLUG_REG_LEN macro to more
appropriate common header file.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716111502.202344-3-salil.mehta@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/cpu.h | 2 ++
 hw/acpi/cpu.c         | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index e6e1a9ef59..df87b15997 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -19,6 +19,8 @@
 #include "hw/boards.h"
 #include "hw/hotplug.h"
 
+#define ACPI_CPU_HOTPLUG_REG_LEN 12
+
 typedef struct AcpiCpuStatus {
     CPUState *cpu;
     uint64_t arch_id;
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 2d81c1e790..cf5e9183e4 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -7,7 +7,6 @@
 #include "trace.h"
 #include "sysemu/numa.h"
 
-#define ACPI_CPU_HOTPLUG_REG_LEN 12
 #define ACPI_CPU_SELECTOR_OFFSET_WR 0
 #define ACPI_CPU_FLAGS_OFFSET_RW 4
 #define ACPI_CPU_CMD_OFFSET_WR 5
-- 
MST


