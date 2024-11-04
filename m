Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A68D1BDF4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Gv-0003VY-AJ; Mon, 04 Nov 2024 16:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Gr-0003S1-Vb
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Gq-0005HU-Bi
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5o6Iz1/wP5zB957KDr4w2+nYVqYKn/FATzH9r01QwTQ=;
 b=Hw7T8uhPdKy/YfA5FpQBatHSFDaeaGPmzKpccl+h14B+GNY7gkTeK0UVFWOolCPm632bEQ
 IZfv5gpx6+27/rqXF+WQMpvZfLe2rFNgBA/+o45R1VfTDdafQVjTIqkgGKjXLtQAdlNJ6C
 EVhPzE+Le1Efrq2xL8JguhWYmwSqt0k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-jfhwKp3MMxGFBIMGJinqIQ-1; Mon, 04 Nov 2024 16:05:54 -0500
X-MC-Unique: jfhwKp3MMxGFBIMGJinqIQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c95b050667so4705633a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754353; x=1731359153;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5o6Iz1/wP5zB957KDr4w2+nYVqYKn/FATzH9r01QwTQ=;
 b=PO704yazaNdATFjxfEtHi/0Hc4dM4nw0rJCKLo0GLqeNdsGXsPtL7U5kyQel5RFR1R
 N+m+A5YMBRokdfisyAZ81h0S3DobLyN3kM+VOwN36IyRMPVSWqM6EKPd2D0NtooKmpu8
 KuOngDLKRJlHOhlRhLhU2gjWF1vd8bQiidXJJx+mOpzV+Librj2a1RliyYqMH/SEy2yl
 kOmAamHf/pp1/4tezcLtnxQ57noC1t7HYFdaHkF9AQTnz7XK6EmdSA6p4hsmafmUp42h
 VuyM8Xy/12OGy5SnK3f8Wvd/qmpov1yN3I7iE4/qZppuC6PgDxfXo5Kfvw+mH1nBuRP8
 Xekg==
X-Gm-Message-State: AOJu0Yy4b88/CQ5cnNeiWifmXUVZo+yAdApMZBpqhaHkeI8EDeZ7UN5M
 59pkeiD1LvESk+bHnE+FEqUUa/lSbe8wZFhThZe08e7WkCxIqD6jrvoAhtnZ44qWKVl9GPhgcCy
 JJz+4/oYkWZmNaXkskpvCfwNsZ6aQ/MHSt52Ttm/ZHQ5abW6A5WorG+r+RRI9Bj1JUUCF8mFtev
 yP9rYmqG2vPVlPjW4HG2dEqxzfjU1Dtw==
X-Received: by 2002:a05:6402:3592:b0:5cd:5732:ecfe with SMTP id
 4fb4d7f45d1cf-5cea966bd05mr15314543a12.5.1730754353032; 
 Mon, 04 Nov 2024 13:05:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqt9FZqCcmy3VPlZTkcJKX4vYLKJdFxciWf0K/FLe0rmttyz/5F2xzOazkvwO8wp001NhmOg==
X-Received: by 2002:a05:6402:3592:b0:5cd:5732:ecfe with SMTP id
 4fb4d7f45d1cf-5cea966bd05mr15314526a12.5.1730754352536; 
 Mon, 04 Nov 2024 13:05:52 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6aae181sm300645a12.19.2024.11.04.13.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:05:51 -0800 (PST)
Date: Mon, 4 Nov 2024 16:05:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 06/65] hw/acpi: Rename build_all_acpi_generic_initiators() to
 build_acpi_generic_initiator()
Message-ID: <a20b6c8f0b279edf370bc20b7845f87c36d03f7a.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Igor noted that this function only builds one instance, so was rather
misleadingly named. Fix that.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916171017.1841767-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/acpi_generic_initiator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 7665b16107..73bafaaaea 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -74,7 +74,7 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
         acpi_generic_initiator_set_node, NULL, NULL);
 }
 
-static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
+static int build_acpi_generic_initiator(Object *obj, void *opaque)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     AcpiGenericInitiator *gi;
@@ -111,6 +111,6 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
 void build_srat_generic_pci_initiator(GArray *table_data)
 {
     object_child_foreach_recursive(object_get_root(),
-                                   build_all_acpi_generic_initiators,
+                                   build_acpi_generic_initiator,
                                    table_data);
 }
-- 
MST


