Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B1DCCA472
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UEg-0008Gd-8L; Sun, 05 Oct 2025 15:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEK-0007lx-HO
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEI-0006TL-AT
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Ap/LxYRjTXw/E9jnwsKOS4crdgiKccCt++rQMqKO54=;
 b=R63KbwppCvf21kPMxmGJAk27fzM10n06qsfyJzZta3EluiVvJ26SQCU+/THJwF8DYEZnnc
 cuRPWYJRq7h9GKZzwPz0zrZlGkLRiNj1zELRz+AWnb1545oQ+2tb5j8Ho2N3+WQkkfRcVD
 dMgxGIJ1Geigm4MP0QKwdzq99m9WzTM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-1H68GBitMTOV-suT9xqdSA-1; Sun, 05 Oct 2025 15:17:08 -0400
X-MC-Unique: 1H68GBitMTOV-suT9xqdSA-1
X-Mimecast-MFC-AGG-ID: 1H68GBitMTOV-suT9xqdSA_1759691827
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3ed6540fso22342855e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691827; x=1760296627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Ap/LxYRjTXw/E9jnwsKOS4crdgiKccCt++rQMqKO54=;
 b=NaJYnk2vToFBCPhgFTn8pevUExPL4dXYcG4/BCatPlYRN7d3edtnZnh+Kqqrwlri9N
 5M9cLKIhPncvznSI5USyCjXukaEdJEVKr6qlLvNwJnP1q0UBkUqjm4OuWg0V2ZO+Ohgf
 31gH21E6lTQ81UE7ahflBvVxTMQb7jfrcvk555NvYHf6dnsPDHgeCU0jj8R3IVGmCWQ3
 tn/kb6Jq/+PAbRpJkXJn0fabDOMEPchISIjtmmzFrb/ZZwBEEip5iwjfeW2pOuILrey8
 UluNZWHsdAi3cPlmzVpZZ88V/ueiH+5bV8ulcFS6L01Qkq7+UfYo8xknqhUWMjYFvuzQ
 gz5Q==
X-Gm-Message-State: AOJu0Yzd5SJaNE5YMsm7p0PQL9mU/SRPvHj3F/b41dkyjkS0m09OEOuC
 t1dM3dP6gGZRtU4uiMgEIHNBC2fp+mhM81V5VDk+zSg4yvO1+1CQPli3fCPshptNpbTUn44Me7n
 7c5U/Q2J9HqRqEql0lyhJQWnV5EmLK6KZuXiEap2lmA9F1Zig4HzVDbufSQpkqDiqgJxoRCLRLn
 30xe1W4R03RAo3z9RGQ9IKodamUSlkqW8mkg==
X-Gm-Gg: ASbGncsoooTjZ54AZ0gO+Hwd5WLkd9a+fq1sWDxRdXcQnORvqXocos4f8UjqMx7PNRp
 ZI/GQmtwAiVOjs6OPHpXHhjbfSnsboTMKnYC3cH0IrlgzbhhVTLlbrY5fjYPqyHs2MqI+Bc/Hdx
 ruizak/ag0zzN08MUIx+sTDd8g9AVdQ7M5uua59M+J87JukisoWfIWa68hNjMMNRoem7j6wpLVe
 H1i5PpenD/xFoPQM46FBecCz/U+mHDUhCYG9TrA3IzbT0c4+tK+Jn9LHcN6lSlxdE5cXO7vjXDL
 A3ENLYsBE7gJq0an/ERC9rpJDTgbOhgJMUcvx0Y=
X-Received: by 2002:a05:600c:4688:b0:458:b8b0:6338 with SMTP id
 5b1f17b1804b1-46e70c5c8b0mr83985095e9.6.1759691826790; 
 Sun, 05 Oct 2025 12:17:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0gQ3dn4NTitApkZbmpXZqvahU3vql06deKIwIzNnOW1wUTcKaTq3B9kPyG8gMkbQXaZnV2g==
X-Received: by 2002:a05:600c:4688:b0:458:b8b0:6338 with SMTP id
 5b1f17b1804b1-46e70c5c8b0mr83984895e9.6.1759691826377; 
 Sun, 05 Oct 2025 12:17:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abe90sm17389924f8f.23.2025.10.05.12.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:06 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 28/75] acpi/generic_event_device.c: enable use_hest_addr for
 QEMU 10.x
Message-ID: <ecd06271dc3ec2e1963f9c294201fc6337ca7779.1759691708.git.mst@redhat.com>
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

Now that we have everything in place, enable using HEST GPA
instead of etc/hardware_errors GPA.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <ad77b64aa1f09141efe942539445908631423975.1758610789.git.mchehab+huawei@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/generic_event_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index e575b9404b..e7b773d84d 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -363,7 +363,7 @@ static const Property acpi_ged_properties[] = {
     DEFINE_PROP_LINK("bus", AcpiGedState, pcihp_state.root,
                      TYPE_PCI_BUS, PCIBus *),
     DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState,
-                     ghes_state.use_hest_addr, false),
+                     ghes_state.use_hest_addr, true),
 };
 
 static const VMStateDescription vmstate_memhp_state = {
-- 
MST


