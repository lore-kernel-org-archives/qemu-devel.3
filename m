Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E064BC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbP-0000eI-GZ; Tue, 12 Mar 2024 18:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAb1-00083t-93
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAay-0004RU-IQ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/EiRia/WktsB6CMALV6JgPPHjttgoWQ71frCIn+d3U=;
 b=i7Zq6YC0JTuQG+bwNzljE6wQSGN5P1K6FQiDqHYwc0oGSqWL0y5FI8NebQuBj3NdS8N/N8
 pUkJx+oNr8f67ddCjDNZgmS7DxzU1vtiyq7rDEbahgs9DKyeEnSXZBANvs0BVcKndpw64a
 0X9HzsNYyHq4VvdQGukmlSeGvpb5ygk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578--cRv60GgNbWzAbsDY5d3Jg-1; Tue, 12 Mar 2024 18:27:38 -0400
X-MC-Unique: -cRv60GgNbWzAbsDY5d3Jg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-513c6e69b85so349570e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282456; x=1710887256;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k/EiRia/WktsB6CMALV6JgPPHjttgoWQ71frCIn+d3U=;
 b=NfsQB8yhCiiJA00XsqSclXx1Vvjs8a/+Br0RIE+Dc5JsDcv2jibA5MvkV0+gTTLDQq
 wu24XVag7gvIu4oD/WbnFEvUM0m+s1k3lGqmhtmyXCz2zzUGna2SpR5UY9gVj37WYENx
 lt+2/XcIzlaBYthr8DdWhbBhrnv8QO0LBUaVq8EOuXU4zRCfC9syJKuNZ3Avap46W3Xc
 E0E/tS7rdjkc96UL8RHBhbkSiYSErn+Oy5h5ISTkrA7H3WmbjVEkTkShB11W6DHFRgoY
 QM7tKB9d06xTK12DbzZlKHfjy1zDQPrTxmjRLrt0TDkUo5OWtyhslHBxBSyXwVbuYpqe
 ul4g==
X-Gm-Message-State: AOJu0YyMGB7/zIIdG9ntisuXffCxXR1ddB7whfk+tLJvbuVi7Pl6tf7l
 AtUiSB1nCm+dKv7tBAnSIfu6c5YDElBsEUUu7F1PG0/dYVJ3097d9go3f2LijaXJYjLI1lq5SDv
 gRRIThNh38/ZX79RvvJ8JLYoOlfPKSoF25Jr6G40sy7BKdHZRZLOuD7qKLePDsyazYqIJd0QcoY
 Fle/I602nNUk8Lsxc0/4fefp+b9by7ZPW7
X-Received: by 2002:ac2:4241:0:b0:513:b9ab:6e99 with SMTP id
 m1-20020ac24241000000b00513b9ab6e99mr2201498lfl.50.1710282455854; 
 Tue, 12 Mar 2024 15:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIsyggiUH+m4JIci3RtHFIKVTzWpPPe3lFquwvm/56wnC/n+ScFPNCjsMQZPpnGCD+1HVtKg==
X-Received: by 2002:ac2:4241:0:b0:513:b9ab:6e99 with SMTP id
 m1-20020ac24241000000b00513b9ab6e99mr2201483lfl.50.1710282455356; 
 Tue, 12 Mar 2024 15:27:35 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 v15-20020a170906564f00b00a44bc99cd89sm4258490ejr.42.2024.03.12.15.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:34 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 39/68] hw/intc: Check @errp to handle the error of
 IOAPICCommonClass.realize()
Message-ID: <0f9c30350bdf9d062609a15124f30f6c2b0a4b60.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

From: Zhao Liu <zhao1.liu@intel.com>

IOAPICCommonClass implements its own private realize(), and this private
realize() allows error.

Since IOAPICCommonClass.realize() returns void, to check the error,
dereference @errp with ERRP_GUARD().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240223085653.1255438-8-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/ioapic_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index cb9bf62146..efbe6958c8 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -152,6 +152,7 @@ static int ioapic_dispatch_post_load(void *opaque, int version_id)
 
 static void ioapic_common_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     IOAPICCommonState *s = IOAPIC_COMMON(dev);
     IOAPICCommonClass *info;
 
@@ -162,6 +163,9 @@ static void ioapic_common_realize(DeviceState *dev, Error **errp)
 
     info = IOAPIC_COMMON_GET_CLASS(s);
     info->realize(dev, errp);
+    if (*errp) {
+        return;
+    }
 
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->io_memory);
     ioapic_no++;
-- 
MST


