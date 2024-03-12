Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80968C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAe7-0006LD-Rl; Tue, 12 Mar 2024 18:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAch-0003gs-RZ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcY-0004eq-0Z
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PeMFDO4130XoQfHKpWr48T0PbkJVOHJ4wOnTCp2Y/U=;
 b=GXDJCBzsDFRXWaKaCgn6GGBCaBXTHPcY/86nM+TvEy1hGeQ9YszuzeqmGop7S7MN7I2r+p
 x8J5oc4WJaHTFMZMcwj5GSH5RPFXPJe/+KspZIbTLKuKd0ajjrDzRTAOHKvZJzhXEVj3cO
 jUW18scqc45reW596Kz+eH8BNlnqHpo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-H9iHv4UANqyhMI7SR3RrsQ-1; Tue, 12 Mar 2024 18:29:16 -0400
X-MC-Unique: H9iHv4UANqyhMI7SR3RrsQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-564fec337b1so276122a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282555; x=1710887355;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5PeMFDO4130XoQfHKpWr48T0PbkJVOHJ4wOnTCp2Y/U=;
 b=eKUOa39jXAfXrlEPA5b9RYcjN7a6rzj+LJiT6CbVjdXjkogqxw6xCt1urXzLaSN6vY
 rF8pKiuaDQMd/2C6suJRZFA0NXyevf4qzL9b1ig0DHB3XtUkviyZwhoSBvx9dtgxmJwJ
 52sXZ/l517CO2d3yU1RIFggAml/0GBlYfYA+lOIjzF1Hy/nAYWnp5d8bPTYriAUeqPtD
 FrqRyDNmUO4dOyfo5fPD4dwx3T0QaWhGT9pDI24l989hU1++iWBEc3OSKmltV8RqooKS
 JMHxti85O3HTJDoYMt1cpomMaIVDUV7oOMSleE55795BgK+WmCB8Tu5mTcE1r00QmF5G
 9giQ==
X-Gm-Message-State: AOJu0Yy2GhUMPqi2XDVkaDxlPKvNo/uPRRibwbDl+LVuEFImc1PkkVSO
 jcrBTdcLfmU2EskSayYJCRLG2SyfE+rR/CWGSW16EykiUVtAJObz5/wLJ8QzQyul42Wd1YRPObi
 JGsXixGENaszjTSGEjKaB/KW3+eHEyqHcdNyrF4IScZURqlUdMTmfLPQS4OJ2OFNmln2yngqNhB
 bhFBl2B1xnsgkAQPb3gADeJ3mC6lgeLhHC
X-Received: by 2002:a17:906:6d4a:b0:a46:38aa:a649 with SMTP id
 a10-20020a1709066d4a00b00a4638aaa649mr745271ejt.34.1710282554844; 
 Tue, 12 Mar 2024 15:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbwlQGCQgW49cMn3mEBZA0YljSpO2uGzdfkTp0+iwD9p2uJjuSB+9NCod5iLFMNAzQPtOKjQ==
X-Received: by 2002:a17:906:6d4a:b0:a46:38aa:a649 with SMTP id
 a10-20020a1709066d4a00b00a4638aaa649mr745256ejt.34.1710282554487; 
 Tue, 12 Mar 2024 15:29:14 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 n3-20020a170906118300b00a451e507cfcsm4218421eja.52.2024.03.12.15.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:29:13 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:29:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 68/68] docs/specs/pvpanic: document shutdown event
Message-ID: <73279cecca03f7c2b4489c5fea994e7349eaafaa.1710282274.git.mst@redhat.com>
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

From: Thomas Weißschuh <thomas@t-8ch.de>

Shutdown requests are normally hardware dependent.
By extending pvpanic to also handle shutdown requests, guests can
submit such requests with an easily implementable and cross-platform
mechanism.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240310-pvpanic-shutdown-spec-v1-1-b258e182ce55@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/pvpanic.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
index f894bc1955..61a80480ed 100644
--- a/docs/specs/pvpanic.rst
+++ b/docs/specs/pvpanic.rst
@@ -29,6 +29,8 @@ bit 1
   a guest panic has happened and will be handled by the guest;
   the host should record it or report it, but should not affect
   the execution of the guest.
+bit 2
+  a regular guest shutdown has happened and should be processed by the host
 
 PCI Interface
 -------------
-- 
MST


