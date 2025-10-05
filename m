Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB10CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UEL-0007ly-Jo; Sun, 05 Oct 2025 15:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UE6-0007h0-TB
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UE4-0006RR-DI
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NIhiW5u2eQoMFtkoyQrTpDhwvgeVrThMS4HUlP2TBEA=;
 b=GRBJu6RmddsPFxaGInyw/lCoxvXQZN//4SnO5CmvLjCuG0jngID8fkDtAgTelus4R69COI
 dyhiL25myA277cRPonorKFsJ+7ZvjV4FlVr7UTIBePZkG4J6snXsafLK2PVxDOepei2y42
 GgSDNLit+6iU7wMLki3UL8Q6Ninqpy4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-JERAcVWfP82WSeucE2IXRg-1; Sun, 05 Oct 2025 15:16:54 -0400
X-MC-Unique: JERAcVWfP82WSeucE2IXRg-1
X-Mimecast-MFC-AGG-ID: JERAcVWfP82WSeucE2IXRg_1759691813
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3f42b54d159so3228473f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691813; x=1760296613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NIhiW5u2eQoMFtkoyQrTpDhwvgeVrThMS4HUlP2TBEA=;
 b=P+mCTboIPJNAS/HNx1b2xhDHxXdBZ63UvpVFprTGbgeTSv5W18zSJptUP2a/HIjWRn
 tv7Lcl3esC9tZGUNNmMVTp4l3EQngDlvPgwjmKDRSK4q2zC6+4ckIQaKmTV9XDNi+krb
 I95l2CxACiBgPdtAJwxMqqgal1wZxSwIGveHdocsefeW3joSKBgaEkWG7i6f4X7vlway
 miYom/HljCmIkz3LGEm0QMSabRxwQYVg1gVIRtm/OGNprIXPjeLgOnlpzYt0ociWTkr7
 a7KyRobdsYgN3cOiw4FV27OQP4do0nmXV3ZIjlhNODOvOHqu8O2+HbrD5eOxqdqmhu0U
 dJsg==
X-Gm-Message-State: AOJu0YyoCISkB88+VShcxrdTBbT4rjwAUWsMpumRlQTJMLCE06hZFER+
 ZYNIyLhMUhH6i9IB3uyK6xhCgFEO2TqrX6YOc2/twgJIYeSoPkzeW3xaPkYYN6DIH4OiaAOdOlW
 wRvAtOA42XTEGPyO3eyl90q/ide0qv0OYt0rfxt/GGWciQWBE1FvMpguITWcpsJIy2yWEtat/wU
 wUgrqZze8AErRBL4eXM0zDW0y9rQyHmGkmRg==
X-Gm-Gg: ASbGncsKBdHmvCI9Nqpu54+IZ5XPedjaV71zvPTBCT7TaVuZ2dSRWWnmaprC0MpSzji
 eHYkVcNeyRbaIHWgAc9QQx/QU4A5jnhdQiPyLVDqg7kyilBBovx5/cD6O5d7ehgxTKgpAynDHa3
 onGjq7klXwyY1wDv9EAgu4zwkN/yYpTAxcybS9kjEBr/0FjnS3HZFXs9T0Z8S1U1u+Xdwc5ynDi
 C0H0RTxO9Z025fwb9scR/hys88kfh09u0CVj3zMu6N0CsjyPkaDTbuZMKKdgp5bsaq26MMvC+Zq
 NCjiajq2hJMYPJNIHPC2JWBKHDRU/oqOTGYb8SU=
X-Received: by 2002:a05:6000:4013:b0:425:58d0:4834 with SMTP id
 ffacd0b85a97d-425671948cfmr6288978f8f.39.1759691812924; 
 Sun, 05 Oct 2025 12:16:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsWN4zgw9e6n7Hk6GjBt1nA+9NTwZM/bYi3euHzHf3qQ7aiwEhTw9R7RDdL7iOv+R0g435wA==
X-Received: by 2002:a05:6000:4013:b0:425:58d0:4834 with SMTP id
 ffacd0b85a97d-425671948cfmr6288960f8f.39.1759691812370; 
 Sun, 05 Oct 2025 12:16:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e970esm17357225f8f.35.2025.10.05.12.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:52 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 22/75] acpi/generic_event_device: Update GHES migration to
 cover hest addr
Message-ID: <d238dedae699a924c92228cb8b3bb8dc861008b5.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The GHES migration logic should now support HEST table location too.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <ede7ddf4b10f34094a4327dc458d630ad319bd1c.1758610789.git.mchehab+huawei@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/generic_event_device.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 95682b79a2..55998303c2 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -436,6 +436,34 @@ static const VMStateDescription vmstate_pcihp_state = {
     }
 };
 
+static const VMStateDescription vmstate_hest = {
+    .name = "acpi-hest",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static bool hest_needed(void *opaque)
+{
+    AcpiGedState *s = opaque;
+    return s->ghes_state.hest_addr_le;
+}
+
+static const VMStateDescription vmstate_hest_state = {
+    .name = "acpi-ged/hest",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = hest_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
+                       vmstate_hest, AcpiGhesState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_acpi_ged = {
     .name = "acpi-ged",
     .version_id = 1,
@@ -449,6 +477,7 @@ static const VMStateDescription vmstate_acpi_ged = {
         &vmstate_cpuhp_state,
         &vmstate_ghes_state,
         &vmstate_pcihp_state,
+        &vmstate_hest_state,
         NULL
     }
 };
-- 
MST


