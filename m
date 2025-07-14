Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006BFC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSGw-0005KS-4q; Mon, 14 Jul 2025 19:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGV-0003cT-Ev
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGU-0005UD-0n
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZL6gIy6E1EGKwHnookoXDuH71GEOS/u/ejdom3UITfo=;
 b=I2hnDO9MtfsZ7iPWBw/kQf4qa2Zz2jMj2ETqJp14cilgf2yYqTrIHKl7Bdj1ytrVTwj01J
 4Z8VxDBJPFF4kHUerZKV4b+u6UGBsQtEg5dJLWbIRj9TDUWTxrNaK+CxhPhKpizkQXJOZ3
 KxcTQaGSMmXPu8LvRIngBUYeMOnWmX8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-wMQ1kxtANfmWDXuQ0q2aSQ-1; Mon, 14 Jul 2025 19:07:15 -0400
X-MC-Unique: wMQ1kxtANfmWDXuQ0q2aSQ-1
X-Mimecast-MFC-AGG-ID: wMQ1kxtANfmWDXuQ0q2aSQ_1752534435
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45597cc95d5so18204875e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534434; x=1753139234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZL6gIy6E1EGKwHnookoXDuH71GEOS/u/ejdom3UITfo=;
 b=uPAZxB52T9oLZKRwmh4BhAg8JAQwxUunh0IJjjmTM3uDSV+HXsg75FaGiQosBVpOS8
 +/HOUz/i1F90y4Je3qEMrodSDOF6d2juC8cG+MoNIUa6zht1jlCpfKoGmrfPpjQRb3LU
 jlGRAnJZga56VtdPUqTnpklWzbY/BjlHhezYj8PDpSsDxdQ4gcCeTRY3ARU4Qg7v3q5E
 mthwF2avwbsYKigCWDHPhLQX50MA33gRdqlbPFvKYXvTrVmtCmV00VCESWUC7OR0AvZ7
 O6o6xEf/2BC0eczLfljjh5qwprXsL/lfm8KCO1jLyCJviQR9QHrxzWIuULJNAA3fygu5
 El+Q==
X-Gm-Message-State: AOJu0Yxkjswndj6MdgkdiY1i0mAfkAdrZVOQF07i2avxAfoi6Z4njaH8
 FMccrhLYn0vQZX4xk39Ak0IghPR+Isml8YambrEN51rPKxSZMlyHlB/0bDn/LzQtHPx4zjDlVxD
 4+/TawKXnAJ1YD3NFcefz2Qt6ewrkV7MI/hdAq7gUVvndyIpUQZ00f3f2sGkx6GACyv4iEYEGVO
 76jmeSMaAApeG6rh5C1Rxgeo/d5GsYoheYtw==
X-Gm-Gg: ASbGncsHvC2fR0zxO6nBLMKfi5P4na6GAIf8/3PoLA4myl7VGkqQTPfDHyinTbflzqR
 O9sDqXAiwpIeZJPZ9saKraltpnON+s1Pin7DV7nJlTNLvHH/etol9U+IoySBu9dYXplKZYAcuEX
 PbKASXoccQqyt0qMe54ez+LiA73CNnJsXsvfTDyfEi4NjKxU52UOOxsUJfNgCEwGYMpVTWFjO4+
 LJxgTMffjG0G9Mv3Y0ikcAGSwm/1JxMyZ74zMJJF+g/1373US0YRh6XKcNdI1AlkjBWhDGIhB4d
 0O8s5iCBa+1POMLPF2h+hnlVkyLQkrYH
X-Received: by 2002:a05:600c:1c8f:b0:456:2212:46b8 with SMTP id
 5b1f17b1804b1-45622124965mr25396005e9.28.1752534434233; 
 Mon, 14 Jul 2025 16:07:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWXWVjb6PpjXQxUk5m6v4U91+cq9IAujqFHfVmaLDKbzY/WsKleJ6cWB3JtIfiBtW/skWimg==
X-Received: by 2002:a05:600c:1c8f:b0:456:2212:46b8 with SMTP id
 5b1f17b1804b1-45622124965mr25395805e9.28.1752534433739; 
 Mon, 14 Jul 2025 16:07:13 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50fa9b4sm188290535e9.27.2025.07.14.16.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:12 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Vasant Hegde <vasant.hegde@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 23/97] amd_iommu: Remove duplicated definitions
Message-ID: <5959b641c98b5ae9677e2c1d89902dac31b344d9.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

No functional change.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250617150427.20585-8-alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 96fc5b621e..8b42913ed8 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -206,10 +206,6 @@
 /* Completion Wait data size */
 #define AMDVI_COMPLETION_DATA_SIZE    8
 
-#define AMDVI_COMMAND_SIZE   16
-/* Completion Wait data size */
-#define AMDVI_COMPLETION_DATA_SIZE    8
-
 #define AMDVI_COMMAND_SIZE   16
 
 #define AMDVI_INT_ADDR_FIRST    0xfee00000
-- 
MST


