Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0861BCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAY-0007u7-PO; Sun, 14 Jun 2026 15:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAW-0007i4-Ao
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAU-0001mf-S9
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zy+KxHWGEBRW7m0bG1W08Cf+nbSLlxXmtq1kZ68JP+k=;
 b=J+ToT24TERagKNkCjT/G2i3XrvxGjTOkVWnK+bNe9fe/5qK4z14LIA+bmwbm/qTYBBmn4g
 wGSmJ9uNEeEAvqOI9opdrSwF+6o3OUfh6ooWMy65MyYyIuqCerj2J0t8UjiREcK5kA1vHW
 JiQHvyEx50yz998w+LOFgIbrwMivkCo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-cJlRN4uhN5urZLENIiMHFQ-1; Sun, 14 Jun 2026 15:06:49 -0400
X-MC-Unique: cJlRN4uhN5urZLENIiMHFQ-1
X-Mimecast-MFC-AGG-ID: cJlRN4uhN5urZLENIiMHFQ_1781464008
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b37e1f47so18563125e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464007; x=1782068807; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zy+KxHWGEBRW7m0bG1W08Cf+nbSLlxXmtq1kZ68JP+k=;
 b=OaYnkoBzrwq8MlemP+XnfjLznIIqT0udvisFphyjsb2Mb/RpjQ73kl6JS7bKGOwWXL
 8LHmW2690kG4tXL8SqgpN5P3SodmMXqnu4fIQAy/vP5lA3t4kOfmALsAhBaPHSvmsG3G
 9ryxehqNqj7aKyOgvVtsvblP8fBsjFvOXfkjpKa4UGjyIQo9ORoT9hVuy3z/Gw2ZLHHH
 DUVl8IvQXZ1UB4pealIpMZcwKmoPfd+xQgW6LLBptU6PftfEkWQKgmR+Xhme8emUOnjl
 mamIpEsnawdNScb4wVvFh6cFLT+fKtto5meqtAmFj1175NR14r2ZAFv+nBz+HFZMZTpq
 7WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464007; x=1782068807;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zy+KxHWGEBRW7m0bG1W08Cf+nbSLlxXmtq1kZ68JP+k=;
 b=SvIPmjRGCV61zA8VbHFT2MtU1q0Fv1+VsFsp6EqgkrsnAB19DZmSHInkx509RUbgxe
 rRx4461QUmltPOnuJ0uR4PUuX8wvpxGHyyZrMxrdx61BDy9KemqMs+lRotFIsF2+aZQH
 jrI2AOpjoG+IobBfbgjDV2sdo+oMXeIK8w953d+e2Xt5jJdXZnRnzS8/ApPgasWmfox6
 nCjnwXRXNUutIpc7vFC+RQ446I0asjVJZiFFNwchAWNiSqYW30D6TV57rQdqflUUZZkY
 aSCJTNbieCqSCEEtJmz1AKSnmVlfw99P1i/vihioTyAc23LZcLRGsRLwB+eEX2cd3dGz
 hZwA==
X-Gm-Message-State: AOJu0YyxmceJfzquFOFdvlMrJSefumehMOAavGGoLtnS659uTrbTLVf9
 wSw4Fwib+mHwdzWZEVYuTX5zC4ODzHAVoFMHj5jUgDQ+7gbWIINGJRoAJBM9sJXVo8v6ikLq/kM
 TRAULmqRPUpfY+vGakSzP7Q3yZudw4Ut9icMhUFj+iHhydtUWO+CyGLmrgFE4GCJryNIfXreT/e
 sAWH2rzeiMGK/hceoMMRCdR1nsfhwKzedigg==
X-Gm-Gg: Acq92OHo9KLPweCtbwzDgkqIEEu/Z6FbGRQQ421t/SYLPD4rqrK25RQ8AtkVxMCuhyq
 6DOIwaT+U9Z+uv5kVFeYWV6pTcxqItJxwIe1iSFgJrHNx4odUCyw6UrdqvWb5WXY4e6evT54Uuk
 xayPkaB4FsYgdURqZRNIwDaZgVHk5xhTsca/I3lDyjA/Qm26C1ZJz4IhEMH25iN2bw3KHjiNUfp
 iyfkKktGAKxdGKMvQU8Fs0LlvkjKNPFYE/TsTtXlX/PjchuqL3H3S4DZSPpiqFAYpxPRJMzKOVQ
 Pn0jbxRZC7HYj3xWdVFRwdtf3fmblblvU24JCNQc4YbolzbH5jnrv0HC0cn+5fQLTliGLbXgYaE
 wIG3oSavavoJo9QNoyn26uIabbukcbfS3EASg0vEcp2o=
X-Received: by 2002:a05:600c:3e06:b0:490:a964:14f8 with SMTP id
 5b1f17b1804b1-49220084947mr96609085e9.8.1781464007611; 
 Sun, 14 Jun 2026 12:06:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3e06:b0:490:a964:14f8 with SMTP id
 5b1f17b1804b1-49220084947mr96608725e9.8.1781464007073; 
 Sun, 14 Jun 2026 12:06:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922033156csm173868055e9.7.2026.06.14.12.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:46 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL 025/106] hw/char/serial-isa.c: declare IRQ as shared in ACPI
 IRQ descriptor
Message-ID: <d616781f2d63fa602b12020cedbb274d15797e41.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
3.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
Descriptor is used then the interrupt is considered to be high true, edge
sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
an IRQ then if more than 2 serial ports are added, Windows indicates a
conflict in Device Manager and these combinations cannot be used together.

Change the 2-byte IRQ Descriptor in the _CRS resource to a 3-byte IRQ
Descriptor indicating that the ISA serial IRQ is low true, level sensitive and
shareable. This enables all 4 legacy serial ports to be used in Windows without
conflict.

Note that it was agreed during the list discussion that this change does not
require a compatibility property since it is not part of the default machine
configuration and was already broken.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260515150634.2637533-4-mark.caveayland@nutanix.com>
---
 hw/char/serial-isa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index a4be0492c5..eaa4e843c0 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -92,7 +92,8 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
 
     crs = aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
-    aml_append(crs, aml_irq_no_flags(isa->isairq));
+    aml_append(crs, aml_irq(isa->isairq, AML_LEVEL, AML_ACTIVE_LOW,
+                            AML_SHARED));
 
     dev = aml_device("COM%d", isa->index + 1);
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
-- 
MST


