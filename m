Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ADAC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCN-0007gJ-2R; Tue, 02 Jul 2024 10:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCK-0007RP-TT
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeC0-0008Is-3l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TisxAqM9JFoRTBzvBR2/yPIkvvWOj6XGjDsm9k9s/20=;
 b=RGfQvvgmHrfWQPxc53+GV/X9meQCN43c4FI/y1e1cKOxw+920dKLy3kmtfmUeyW02it2BP
 L8sNNAuCTWTbbnjNwXjP9n8Nd6sPse3mo4PcD6O9YyKPycA1/6YUcEOoQsT3fGiPokoNLf
 iABwi+y6BslLaX697Q1yqbyTioLXj3Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-LtdjTcIgNFWxGcaq5Ux9uw-1; Tue, 02 Jul 2024 10:09:09 -0400
X-MC-Unique: LtdjTcIgNFWxGcaq5Ux9uw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-424a775ee7fso29863525e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929347; x=1720534147;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TisxAqM9JFoRTBzvBR2/yPIkvvWOj6XGjDsm9k9s/20=;
 b=V+S4fz5/U7mV/AaZr4QDxyGNE4NZRxLQ1rPpPSbgjt03oUwZFWQfJePbdBznmox4Jr
 iyJgDeB2WONdRlq3HwJUBdpwD+GCIMKQtMcEN82v7EaURMumFP5XHYi5hRCS941H6oTd
 jEa2WRG/Vb2nGA9bDc5ENNrLB7PGbUW+YQt4Ie9/AoBhZWU5tf77xj6P8NDFL0ntECwX
 RuLL3wM2Fskrt42YVQsFAUSdVDOhuWU5Ep7fnsdr/BAn06bDSXZg1dfcATc/UUhXb+j8
 vU0UpUFpsIRYMy1GBFFX2YhT5eW7Thrr9GbR6rbBVw2+AMnVztNw9dwl9bimJyQvvgw9
 9/lw==
X-Gm-Message-State: AOJu0YxZcPMfFu45FEG9VkpH1klWGMjqs8iROXRiCK/gAhUz19//HbFe
 Q+V6XTM46PNSVA/6HzoMwSs53eNCXZL+qWvDJKBBlCOzRr6f0/vhZjCcMbXsT3fUucuVeGKWhqe
 J5DNR/Ahyt2Si2mHdXEU/BIeb0xn8SUZWpZr4r0D32/krGMHoZHPLC8+j36ss3u376s3/3qqdJ0
 391jqWyhKFqiPzJe/fex8EcIStqoitKQ==
X-Received: by 2002:a05:600c:68b:b0:424:a7e7:e443 with SMTP id
 5b1f17b1804b1-4257a02b8d2mr60203965e9.12.1719929347571; 
 Tue, 02 Jul 2024 07:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpARjIxgEDOnSoOk/9sIqxKCk+3dibiA8TewD7x6DubYxlnlnJHkFaxZXObdOr8+7P2/ingQ==
X-Received: by 2002:a05:600c:68b:b0:424:a7e7:e443 with SMTP id
 5b1f17b1804b1-4257a02b8d2mr60203675e9.12.1719929346999; 
 Tue, 02 Jul 2024 07:09:06 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b8e2sm199033255e9.16.2024.07.02.07.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:05 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 41/91] i386/apic: Add hint on boot failure because of
 disabling x2APIC
Message-ID: <7801fa5054e0eac7a169b32bf630cb237d2652ec.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Currently, the Q35 supports up to 4096 vCPUs (since v9.0), but for TCG
cases, if x2APIC is not actively enabled to boot more than 255 vCPUs (
e.g., qemu-system-i386 -M pc-q35-9.0 -smp 666), the following error is
reported:

Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:449:
qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
Aborted (core dumped)

This error can be resolved by setting x2apic=on in -cpu. In order to
better help users deal with this scenario, add the error hint to
instruct users on how to enable the x2apic feature. Then, the error
report becomes the following:

Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:448:
qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
Try x2apic=on in -cpu.
Aborted (core dumped)

Note since @errp is &error_abort, error_append_hint() can't be applied
on @errp. And in order to separate the exact error message from the
(perhaps effectively) hint, adding a hint via error_append_hint() is
also necessary. Therefore, introduce @local_error in
apic_common_set_id() to handle both the error message and the error
hint.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240606140858.2157106-1-zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/intc/apic_common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index d8fc1e2815..c13cdd7994 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -433,6 +433,7 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
     APICCommonState *s = APIC_COMMON(obj);
     DeviceState *dev = DEVICE(obj);
     uint32_t value;
+    Error *local_err = NULL;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -444,7 +445,11 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
     }
 
     if (value >= 255 && !cpu_has_x2apic_feature(&s->cpu->env)) {
-        error_setg(errp, "APIC ID %d requires x2APIC feature in CPU", value);
+        error_setg(&local_err,
+                   "APIC ID %d requires x2APIC feature in CPU",
+                   value);
+        error_append_hint(&local_err, "Try x2apic=on in -cpu.\n");
+        error_propagate(errp, local_err);
         return;
     }
 
-- 
MST


