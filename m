Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDB9CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDs-0007YQ-8w; Sun, 05 Oct 2025 15:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDr-0007Xp-7L
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDo-0006OB-MH
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8c+cSIxub9P5Uar4OsTTBSJ3SPcqHsJGWNUFLj9euLM=;
 b=iagq0f9UTGOd9UwyWIUYNrx822q4yErdjSSQriZEQcjSIWqtJ5YNNDjfMxd5E3J6MNZgw4
 XxO3fTjxwwwTuxKlcWgagWUoj7rrgRAIpvA6WGfhwzcn7jcKcLxh5APWrryc8aQCcnPZCq
 1aYOgYygvoFZny81XNrJs927Zp5LnTU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-m3I_9-utMLC7swfetAlJSA-1; Sun, 05 Oct 2025 15:16:39 -0400
X-MC-Unique: m3I_9-utMLC7swfetAlJSA-1
X-Mimecast-MFC-AGG-ID: m3I_9-utMLC7swfetAlJSA_1759691798
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4256fae4b46so848616f8f.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691797; x=1760296597;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8c+cSIxub9P5Uar4OsTTBSJ3SPcqHsJGWNUFLj9euLM=;
 b=rphf8JBOMuljDb5wt/AAMnbQt7A62+oo0d6FHgdBMT5xg0fDMLpxIDFP7U4iF7vy99
 9YtYxIr4Z48eLANmKKOq4CHBXSUeO4teoywoDRVqqgn/bnenDYOrfsIuUgtz+01i74LF
 IQv6viR6abLhZth9LfgaLol5tiEjYOm7C1gyjZ3FYNuBIZxLQi/klFxDNyoP1q0rgA0i
 iV71MvBsHpWvTlQTkvK1XfgbXDUusAn1D8VqroP8i6QQ/eyv3nS1b91wG6P5UbwaKwCn
 Q59lgwJpjdMPMxuLFDfNUhX4STcjrA+jlu2Q65aGWDJnPskOoAWXJO5aOtzk1Ck+R4Lk
 VhMg==
X-Gm-Message-State: AOJu0YxM2sdjSmWRd1IZ+lTDL5oHfh3veQTXS11yBs7yqezxC+6l9+An
 1weCvyjOdopK9EBbXecpwCSGMBdpZRCaS6tWLzuzV3xgaGECA2GZH/Abz+nmZKbvaPgJWQokNoL
 +xRxAOGujtuQ3gtg/ueZ2+cV7I9043Mje9h/+Zyq4Gz2epli1a1qUodDWys84G4QWaDfIGTVCjj
 v6SA4yCtcnZOr9igWzeGRlLgKFKLhu1y3vnA==
X-Gm-Gg: ASbGncvUPIE5+OTxDyPt0RHgPRgS0mlXiVlgCAHlBhXh0dRr6JRBWnEa8n3Eku9JIev
 WoE+ZLDyNOF1ulauIUkZdIbsQoDbBwkrx5ruYjkISva9q4CeHSV910f2PXw0L1SRQGv4TrvxUc4
 82R4kfYgBWeW53vItcRvdJ2/SiSurIpRF1gaDJFziRXmcmcwuaJsgBo9Sw3zM9w/OHYmWRvZRWJ
 92SrsFw04wZUUnF4xvrNswnLhVpEQJwmY7roonc9xPcG4pB9FNDKn5Lgo4ArPH3i8mmJAz08cs6
 PWeKgHA+kqy2GjaiZulb/BeX7H4LJV2pEn/dj5U=
X-Received: by 2002:a05:6000:1a8d:b0:3ee:114f:f88f with SMTP id
 ffacd0b85a97d-425671c6404mr6429885f8f.59.1759691797386; 
 Sun, 05 Oct 2025 12:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkfvWjfHyD8oTcCkxBo4Dk8sacRcJpSTcBF87BvWoKuxfp3ts2iezeGvq0vevPmbERbC5nFQ==
X-Received: by 2002:a05:6000:1a8d:b0:3ee:114f:f88f with SMTP id
 ffacd0b85a97d-425671c6404mr6429860f8f.59.1759691796789; 
 Sun, 05 Oct 2025 12:16:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0853sm17783203f8f.50.2025.10.05.12.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:36 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 15/75] Revert "hw/acpi/ghes: Make ghes_record_cper_errors()
 static"
Message-ID: <6d65290d83919267a7775bd4877d923a505aae9a.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The ghes_record_cper_errors() function was introduced to be used
by other types of errors, as part of the error injection
patch series. That's why it is not static.

Make it non-static again to allow its usage outside ghes.c

This reverts commit 611f3bdb20f7828b0813aa90d47d1275ef18329b.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <14f2a888cfbf922d5f2bf94d7612114f25107d59.1758610789.git.mchehab+huawei@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/ghes.h | 2 ++
 hw/acpi/ghes.c         | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 578a582203..39619a2457 100644
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
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index b85bb48195..b709c177cd 100644
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
-- 
MST


