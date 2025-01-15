Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C66C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7sE-0006is-3z; Wed, 15 Jan 2025 13:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qo-0008Jm-TH
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qj-00072Q-PI
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jKE9c5M8qcrF2rVuiv+K3wTMAWn1KWYDQBuYnN9ug8U=;
 b=EFStBpAwSAopDlYwpHAyySjSLFkTJWDGo00trQ23/REaabIolDTEAyFQIMuO3iEpPALs3q
 xejGBfBEwhIrCC/Dzx45C+YRIPZr/kxlmATdp5binY4I1KV2zzNW7Qd8CWxI0VMLBYT+CT
 ynwZOJ7eiii0Ynwt9rCxVmEdaV4o4wk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-g7Mgwla6OmGu7kuyP-F1wA-1; Wed, 15 Jan 2025 13:10:37 -0500
X-MC-Unique: g7Mgwla6OmGu7kuyP-F1wA-1
X-Mimecast-MFC-AGG-ID: g7Mgwla6OmGu7kuyP-F1wA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4362b9c15d8so37111455e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964635; x=1737569435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKE9c5M8qcrF2rVuiv+K3wTMAWn1KWYDQBuYnN9ug8U=;
 b=kup5/DjfcAq2xvplM0jjNOsdLe32lkeuAmjnE4nWS5bRNXk+aUQ+/ZkA0g3tzPlVUs
 EO61fOTGqUQrmk4WStBAlx0TnR4bq6tsJvrJQceog0CPAvv5f3g4KAO4hO29u7bwbEKq
 BHcJGEsbtDP6pbArImL/TbbwVmIJNmLrb80VHIEK+MMz2RtTilXI/FB2UIERWuD3GVYG
 YEyyVVN4JnwUIlW7MltX8/PwPdk7+05bGURCC3Qz9y5pi8VT6EPUWC15ZCoG2EBvDvF+
 eqHPmQJQWDYGlOaW6kpSmoqBDdXB8SGJRWg7AS2FO7/ewloZR+/WhZ7XAtlEyWiKRlXn
 j7tw==
X-Gm-Message-State: AOJu0YwPyG70x0dmoraDN6JQ1uziFoAJ9Y9FHo5fQMawlZu5QKi+TpCK
 bIkD7X1vs1+X37KlDHzIkjbI4yRJQg9AaDgKY4q4/98/ABZT0MFdW5/RNz+Iqb9AfTfILI5Sxa1
 nXfkRmqKzUmp3xy21DgFNHInl8mNKU4xRttXIq6da+x/tFqd8Yza+aiYM/0UwyqDgfgfc2htKPk
 5NrnpHbhZgpC32H2xXisjHmVV17tv0RQ==
X-Gm-Gg: ASbGncu6Kja8fO/LLb51U1rtDX6tuP+LvRrD9eLlfsUcE81uzx/LgubllMH7N6amupr
 s9T07Hovvpo3b+BwLfOgBIuz2Jw1cLCXG2WdlHnTIglz48+iKNUhwoMM464EyEd9dNOnMBD4UDj
 D+UdmaVTxzwYnzGbb78kuLHCdz3O32pSsaLWzH+N0pg8tV1y0qo1KwgOQa5M8+qoLFglF0z3p3K
 DZYUQzpyxwQWa5Mr2GHNJ2mujcG7fCKaumB4rz3Y/06zubpgQUA
X-Received: by 2002:a05:6000:154f:b0:386:373f:47c4 with SMTP id
 ffacd0b85a97d-38a873579b3mr26019287f8f.49.1736964634796; 
 Wed, 15 Jan 2025 10:10:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGATvq4Q040yTIpCKdqV7z3EL3LTn2Lmdrfl5f9AiMvN2mqfgLEnqYuOVWmOESEbMxlSPjEgA==
X-Received: by 2002:a05:6000:154f:b0:386:373f:47c4 with SMTP id
 ffacd0b85a97d-38a873579b3mr26019261f8f.49.1736964634345; 
 Wed, 15 Jan 2025 10:10:34 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b8214sm18165056f8f.78.2025.01.15.10.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:33 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 39/48] acpi/ghes: better name the offset of the hardware error
 firmware
Message-ID: <652f6d86cbb60e193edc2510c365b75229734ccf.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The hardware error firmware is where HEST error structures are
stored. Those can be GHESv2, but they can also be other types.

Better name the location of the hardware error.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <ddbb94294bafee998f12fede3ba0b05dae5ee45f.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/ghes.h         | 2 +-
 hw/acpi/generic_event_device.c | 4 ++--
 hw/acpi/ghes.c                 | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 21666a4bcc..39619a2457 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -65,7 +65,7 @@ enum {
 };
 
 typedef struct AcpiGhesState {
-    uint64_t ghes_addr_le;
+    uint64_t hw_error_le;
     bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 58540c0aaf..c85d97ca37 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -363,7 +363,7 @@ static const VMStateDescription vmstate_ghes = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
+        VMSTATE_UINT64(hw_error_le, AcpiGhesState),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -371,7 +371,7 @@ static const VMStateDescription vmstate_ghes = {
 static bool ghes_needed(void *opaque)
 {
     AcpiGedState *s = opaque;
-    return s->ghes_state.ghes_addr_le;
+    return s->ghes_state.hw_error_le;
 }
 
 static const VMStateDescription vmstate_ghes_state = {
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 3f94a5542b..983e28505a 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -359,7 +359,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
 
     /* Create a read-write fw_cfg file for Address */
     fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
-        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
+        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
 
     ags->present = true;
 }
@@ -385,7 +385,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    start_addr = le64_to_cpu(ags->ghes_addr_le);
+    start_addr = le64_to_cpu(ags->hw_error_le);
 
     start_addr += source_id * sizeof(uint64_t);
 
-- 
MST


