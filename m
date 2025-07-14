Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D3CC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSLd-0008T0-I2; Mon, 14 Jul 2025 19:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIl-0004m8-KJ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIh-0005ue-VS
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0rpEe4Ya0FUWqHztCZx1kne7sIio/ZH524H7ccN5+II=;
 b=UPu61Nv5y49+SukWJTh0ZHFQBcyqYMPr+GgwDkN7acigMfsmS3HRgI1OOmrgkMry2eM8NY
 Kjvmi363DxwsnMuxdP+1/vrhMk3R7HKf85Jm25T5zq1N4cXQ3ysyfoCeqq6mX/CE5YPFTW
 8FqBo8sFwexjX80T9WcuMiH0DuW6zts=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-F7YDCXgVNZWd_WHId9YkYg-1; Mon, 14 Jul 2025 19:09:34 -0400
X-MC-Unique: F7YDCXgVNZWd_WHId9YkYg-1
X-Mimecast-MFC-AGG-ID: F7YDCXgVNZWd_WHId9YkYg_1752534573
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f858bc5eso3632369f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534573; x=1753139373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rpEe4Ya0FUWqHztCZx1kne7sIio/ZH524H7ccN5+II=;
 b=gCDCRlem21zy5fmDKYbKO5mpwMxQYgKr7m7HSWlBB+NstlOFDtjZugwVC036jx9jxV
 fSySUpmLCsMgJq2OpFIZ/Knk7gqVF3WfKGX5DO+NyFu81C108HQbsxo9fALQO62Pa34Q
 Ck3gtUE62MqXd9pHszIF4uQ3HWr95K3JF3xaydYg4qU53eW8JiAV0uIHp0cD1vNZrVWA
 Ge9++NPIKCAb4c2f7Vvb/lhlhE+xTkuAi4nsXAQsUSsUNSx/LzL02s7YoQJwQSreb8Pg
 SnbckLMzyNgu84ApQFgRlGfkAY+77RWDRVDCwvINVZi4PvnFEf6d/k4zj9DbDTVruQvQ
 6CBA==
X-Gm-Message-State: AOJu0YyqQhB9yDVdNiKPwFNTlyu3xY+t8pd4ciZ8sBGIJ8pD7VXLhbwj
 tr9MieD5SQRUBQ3VONbY6sGLhNGYefKsuU0o5IYjX6TDgr1kEzwgI9UBo953rgVHhVbPOdcMFGR
 2ISgiq23EFeH02Ezuny6ByESwHpxreI+yxo/IxSzInvP0dRkzEN7auzSm0GEJqAV0VcrfWM0Z9e
 i0O6hhoU4zGo0uvoaMsWLwCWeF2Q8Ns/AoeA==
X-Gm-Gg: ASbGncsoPCVMLofbHY7LDxASwwvFpqO1G+YM+9W4XbIINm92oYIr6ZNevPBFSuk1afa
 ELUcd3Xdrwa4PekbcJAYQVDFgDvvESwvqv9AzrdUYpY/wGd8e+UdXEqI49iAGc1CLtGViIApYY/
 qE8iugN2/ZvwNhF1DJ/MsGMcbxDFt9tWoFPBhXoY0XHywdSO0TXAdZ8re2pHGqEzbHqc3dq8DSQ
 T8W4FRpSR4KaOkabU6Y2CE1o5Jc4eA0a0drh6S7tjptyHGjJF5d0OP8Tpr0gaccQIBO1em1ZS8f
 MAn67LyfV/Lk60OOHVjN121PmQyKm0GO
X-Received: by 2002:a05:6000:4606:b0:3a4:f72a:b18a with SMTP id
 ffacd0b85a97d-3b5f2dd2b82mr11501203f8f.26.1752534572818; 
 Mon, 14 Jul 2025 16:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH7vlAm3oGq5yZ3p3JuGb4UNA/mb4v8bBju/0aLwHLYMFwrCvQzI8Gc6hwukw3Ib513pWX9w==
X-Received: by 2002:a05:6000:4606:b0:3a4:f72a:b18a with SMTP id
 ffacd0b85a97d-3b5f2dd2b82mr11501180f8f.26.1752534572299; 
 Mon, 14 Jul 2025 16:09:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d4b5sm13749186f8f.53.2025.07.14.16.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:31 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 75/97] hw/acpi/ged: Support migration of AcpiPciHpState
Message-ID: <6778bd7c1cc29188497691cd3290c195a9ebea11.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Add a subsection to migrate the AcpiPciHpState state.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Message-Id: <20250714080639.2525563-30-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/generic_event_device.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 7535d07737..95682b79a2 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -417,6 +417,25 @@ static const VMStateDescription vmstate_ghes_state = {
     }
 };
 
+static bool pcihp_needed(void *opaque)
+{
+    AcpiGedState *s = opaque;
+    return s->pcihp_state.use_acpi_hotplug_bridge;
+}
+
+static const VMStateDescription vmstate_pcihp_state = {
+    .name = "acpi-ged/pcihp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pcihp_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_HOTPLUG(pcihp_state,
+                            AcpiGedState,
+                            NULL, NULL),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_acpi_ged = {
     .name = "acpi-ged",
     .version_id = 1,
@@ -429,6 +448,7 @@ static const VMStateDescription vmstate_acpi_ged = {
         &vmstate_memhp_state,
         &vmstate_cpuhp_state,
         &vmstate_ghes_state,
+        &vmstate_pcihp_state,
         NULL
     }
 };
-- 
MST


