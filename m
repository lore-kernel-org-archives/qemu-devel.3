Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498A3C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDCt-0007kD-9P; Tue, 23 Jul 2024 06:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCc-0006gb-Ma
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCY-0001nJ-TH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kj1I/08pd2fWVIr2fyGlScWsVaYM95BuB4yW1kFmRKk=;
 b=HhkN6j1TUamlZYS2pNnZ1MwtU0UISzRtgkwth6Cs7b1kN8YvtICeYtBWXtoNDgPxrV3jLp
 r/+iihxHM5/bSTwJfzd+0Gu6S/330VuqX6bfsOyILUAt04hzC0i5dnzBeJN0x5h5d+DDNe
 tQIwddFk+86Q9TsqKhUy44eCDKNs58w=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-gCzwjs6uN0a7ROcBD6BD1g-1; Tue, 23 Jul 2024 06:56:59 -0400
X-MC-Unique: gCzwjs6uN0a7ROcBD6BD1g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52f02833519so2403657e87.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732217; x=1722337017;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kj1I/08pd2fWVIr2fyGlScWsVaYM95BuB4yW1kFmRKk=;
 b=s49UZNT4y2Hy4JHxlw4Dw2FmgraVZ+RLqkVVPDHd5jzjdKjnTewR96XOMJxog6IdqA
 B+ycTRRZ5bfNZBBTHPF1Wu8lLq1tFjiv9SL6ucCbSlgnV1pxEG1NWTir4eBaRa8v7jey
 haI+gvi9JlfoGNohrzLAmPzWIICrO0DumpTor3U3oHWwiQjTZcJly3r2FTx9Bawsk0H+
 JxYTE1xkk4y0SF2FiXu/O5deSEUQZIA9fhzLeZIjAj/Uc54BKHr7yZV6vFm39iNCgrVA
 196XReZPnJfxiNDPX3UDs0G0xad6IDMVYmk40ddci84vwMaSo7aMQ8KSt9lfLmRJCENP
 6Gew==
X-Gm-Message-State: AOJu0YwW2wTZUgG/UBEq6Q6SoHL+J1Dbc0xbt1iOXtcpDf76pP814UVY
 ulkLz6daCsTd6IiADRCuZf49a96cpR7l8kIKzsRG2CT0WrG7ftCuEFKl30ta6mdYgg/75mb+8OB
 24Im8wZzDY0d559qJ/iJ9QCpELBHCW0R5crOJtjGbaIWASWhqdcIZNlQGELUo0Kw5tPsp5yVDut
 mlpaG8GRc5u2TLw4SWNeU9O4IOwoVPgQ==
X-Received: by 2002:a05:6512:ea0:b0:52c:dac3:392b with SMTP id
 2adb3069b0e04-52fc404bbbemr1763546e87.33.1721732217162; 
 Tue, 23 Jul 2024 03:56:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA/nkg2nG+CmFagKaSvPvSmjfuzyLxQzejYMP7Lxd8rCbJUCC7UtdqL0qn+BYoEb0VUjTf1Q==
X-Received: by 2002:a05:6512:ea0:b0:52c:dac3:392b with SMTP id
 2adb3069b0e04-52fc404bbbemr1763516e87.33.1721732216378; 
 Tue, 23 Jul 2024 03:56:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c3f0673sm7298041a12.61.2024.07.23.03.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:56:55 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:56:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Minwoo Im <minwoo.im@samsung.com>, Yi Liu <yi.l.liu@intel.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 19/61] intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP
 declarations
Message-ID: <3a23554f91c01cf75705a36a5eed3ebef6636d41.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

These 2 macros are for high 64-bit of the FRCD registers.
Declarations have to be moved accordingly.

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20240709142557.317271-3-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index cbc4030031..faea23e8d6 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -264,10 +264,10 @@
 #define VTD_FRCD_FR(val)        (((val) & 0xffULL) << 32)
 #define VTD_FRCD_SID_MASK       0xffffULL
 #define VTD_FRCD_SID(val)       ((val) & VTD_FRCD_SID_MASK)
-/* For the low 64-bit of 128-bit */
-#define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
 #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
 #define VTD_FRCD_PP(val)        (((val) & 0x1ULL) << 31)
+/* For the low 64-bit of 128-bit */
+#define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
 #define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
 
 /* DMA Remapping Fault Conditions */
-- 
MST


