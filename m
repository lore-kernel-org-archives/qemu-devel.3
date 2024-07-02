Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC71C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjxq-0005dA-Ro; Tue, 02 Jul 2024 16:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjx1-0004Ra-Mr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwy-00008j-Gn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TisxAqM9JFoRTBzvBR2/yPIkvvWOj6XGjDsm9k9s/20=;
 b=bw1quV9SaKR7SEUMAVsUSQRB6evKSzDQ9ikpmI+lLW1ZOtFjIUu4V7s/sTYr9yQp6zh7Zc
 Tnd6QIXKazp4eXwOqPuWHQiMNGNIEDVYYC5HFpBnO+o7IgcBvPIz00vnWMwZroX+BIXiUv
 xjGf8ry2SV84bSmYww8ROrPtO5IW2s8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-g9d9HbaTMj6PxiZNlYW0Qw-1; Tue, 02 Jul 2024 16:18:02 -0400
X-MC-Unique: g9d9HbaTMj6PxiZNlYW0Qw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-425657ac234so31672685e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951478; x=1720556278;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TisxAqM9JFoRTBzvBR2/yPIkvvWOj6XGjDsm9k9s/20=;
 b=AKjCoO6J5bbtgoRxTkzmB2qlfKL4x80CWyJUEW2K/pg7HGTf3xnc+FeHGeM3YE2I7A
 Vh5HLMdUQ2az1MdAJ30J8ux92z22G7DP/GMSqjSXl96mnxVErmmnNDORH5/z3UYpky+1
 kH8ZmtDbiePOae7lWW1aVrOVQ3kHkvc0bad6FmgCL8ifT0i9MjoX9QNJyTp9E3ZTB+DZ
 kyphOG2eXkZdiMWBCZBeJG7burx+pq7aFfLzuTXQnIep3a22jG0LUEK5+CavZPQls7Ub
 Hq0Zu7r5cyaKGJpismqtmwLGVbViAh4Iqryagl8AfzQ7CZP2T5/kAQJeC2ClvFxuH59w
 ip0Q==
X-Gm-Message-State: AOJu0YyAbJnmdwRgSd7yKOrZe7RTTPxAsAQGa6dRqjaw/5LnLqkcrLu8
 XTH4uqmg2/SOMF+/5y0UFJwmPPZ2PJnBYT/M0Vcz0dICYpZknjDcEkyS9wedbZ0zntKu220G/NV
 EJo5kaxV/HfyTN1qnxrIIjIkuOgYdyY++IPr5jOkFSpT0ZRA46ZFTvPwaqEleaacdKtUCRXEmwb
 7eyyFi4zjj7pvimx9gEVkRDqfRz81dPw==
X-Received: by 2002:a05:600c:4792:b0:425:6207:12b4 with SMTP id
 5b1f17b1804b1-4257a03c80emr76959795e9.24.1719951478122; 
 Tue, 02 Jul 2024 13:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdjkHkLZHE+MMtzOESyd4Jh2NRnguAYQnH3wNhvxr3sQL+rozlZteHwAP7j+YbrSR3x1fFgw==
X-Received: by 2002:a05:600c:4792:b0:425:6207:12b4 with SMTP id
 5b1f17b1804b1-4257a03c80emr76959535e9.24.1719951477577; 
 Tue, 02 Jul 2024 13:17:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af389efsm212425325e9.7.2024.07.02.13.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:17:56 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:17:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 41/88] i386/apic: Add hint on boot failure because of
 disabling x2APIC
Message-ID: <e05ee2994a9c188fc49a9ddf70b79ed7f1808e2f.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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


