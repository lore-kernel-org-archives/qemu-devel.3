Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A52C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8lH-0005jv-5u; Wed, 03 Jul 2024 18:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lF-0005cE-CG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lD-0001jf-MB
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TisxAqM9JFoRTBzvBR2/yPIkvvWOj6XGjDsm9k9s/20=;
 b=ahcZkK5Cidr5k1V0oUh3CYppNyHtCFLLj6m5oIFZSZpT6oZjqUqPR6zyOnPuPm7sL2XotF
 wC1iW41iR8P1hdR2evJLrafKbAnDg1sSQ9ap+E6xRVdqOEFIWVhTqAC2fb1A/ZwjS2xfHL
 YmFK7KF+VvmfvzaeOednKct/TTrP6gE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-7bZXWk2pPOaeCnMSkdC19A-1; Wed, 03 Jul 2024 18:47:34 -0400
X-MC-Unique: 7bZXWk2pPOaeCnMSkdC19A-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57d539484ddso4440a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046852; x=1720651652;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TisxAqM9JFoRTBzvBR2/yPIkvvWOj6XGjDsm9k9s/20=;
 b=GMG3GzVP2fvJr05rtoKE4FIQxUxr2heDHGcZaly/grOGpikDXZlp7EdGwdFS8L02Ha
 Nr6pwW8uzEDb75m7dU12DT4May77C9gIBPlclNpmcLfecXPWymPPvyy3u257XPZLdLTt
 HTjWc52Xnnnrk2Lk+8/9133RV86670VbCe0Qd//BHcfaUEkejcrcjDH7H5fMgGFgJSUV
 A1bMGPCg9SAZxz5zUHoi4cAVKONXbCRcPHZx0UePJx7ljry0yX2J9CxNbEhLdpJnnVb0
 gNdG48YyfQPIsz6Iu9pUUoDy0Vyvz+a8Id39gY5FbhmDzb/L7Py5YKpUXuUsijmyxrZN
 iYvw==
X-Gm-Message-State: AOJu0YwFPJwi1cvITj65av87BkkEK9BVCO+RFms8F/xP+USG/wAF8Z25
 qNg1wHk+LLb2M/mS7xKo0veZtTbVMI/F8pUATrr7ob7Bc07nwbC3/cYOWtgyFFpBFIftpQDlJNv
 rfdSopqoQqtqswXNMtiR99W6q7NGKN0ZsQZneqc5wFbfSzClkVBt6lcIIV/XkBo7tvP/LIX6L9y
 ATm8v00CCDpgGNvgQmL8krXgRsqtTsAw==
X-Received: by 2002:a05:6402:c92:b0:58b:fe68:9e51 with SMTP id
 4fb4d7f45d1cf-58bfe68a2bdmr2356121a12.35.1720046852418; 
 Wed, 03 Jul 2024 15:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXiyx2t40TZhpm/bdjIeIoR2XWhN/Kb/mgEeScw8k0KU1RNlVMs6KXe1nV8dIO8ISFA29EpQ==
X-Received: by 2002:a05:6402:c92:b0:58b:fe68:9e51 with SMTP id
 4fb4d7f45d1cf-58bfe68a2bdmr2356103a12.35.1720046851239; 
 Wed, 03 Jul 2024 15:47:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c8371dsm7648617a12.9.2024.07.03.15.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:47:30 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:47:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 41/85] i386/apic: Add hint on boot failure because of
 disabling x2APIC
Message-ID: <e05ee2994a9c188fc49a9ddf70b79ed7f1808e2f.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


