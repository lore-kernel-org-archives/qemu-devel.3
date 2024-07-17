Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08092C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwph-0001Ea-8l; Wed, 17 Jul 2024 01:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpb-0000xU-KX
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpa-0001yy-0V
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfnYhM6E2CaFv2IA7/dxTNaC2rVmX5k5keNeCLuDmSs=;
 b=Q8Nk3EJIgWkndoibj46kb10Mrb9aGYGmKIQgH474UCQB4+8mFFhT94buQMw1sMOYRLSuUt
 Us7o+n4BgmUEEz5ax+106PiCY2P2G0YLDyJpwZ97gx96JCgOVptDLRL0ujtSBYthUoL8dc
 0QCslazswFYQVQ0UGp2mf6erGYVyS94=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-BGfExDs_N56xH3b5PYyICQ-1; Wed, 17 Jul 2024 01:03:46 -0400
X-MC-Unique: BGfExDs_N56xH3b5PYyICQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42668796626so45404245e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192625; x=1721797425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SfnYhM6E2CaFv2IA7/dxTNaC2rVmX5k5keNeCLuDmSs=;
 b=KYMIFV7lh+nsjftSIrgY4Y5qpFSVAv5lwe1Vevc118CBtA2zA+J/TvsfiA9nc4UmBC
 WpoT4VF52AfiT5DYMEsPzjgJe//QpMQqDLgpXJO2rDYqHKGuUAGHymXxOjui+7qNnJPL
 p0eeqZbNup4J+eh6f6u/Bj+v2VZj1ST+6YHcPp30o9fJLczmSUCvGmj8JqOwbwL9YPKA
 /Tu085hsVDkC+JI+7qsuigsNBEM+E3PqazxCRBlZBh5OU2zjbAMlwxFscWK5Kf1FXcr2
 iz6xM9usJsPN/cbIR5oamQzmKYmU61LJgqJyh6d8oP4JENEXBCC8/13xxK+ljZYBahCP
 /9cg==
X-Gm-Message-State: AOJu0YwAhned4DkP4M/d2jyjExW1pQWMw3452AC8zcFM1NZBx3PH2bqV
 Ds4Pr8YH29vHYogKZ9YJzcq8WnMq5J9/k0ZSyDjJUs/UJYPPBF1MHBwZGLbbwnOn+CCpvq9UwPQ
 K/6AaABMZD6/GY6jmzTgtPA8/3AXgLKGqkxUVn8fJl/kvuNeWTW7bTMESWYGxrObRIq83KkAyno
 iKbwQJS2wVOKIbBPZudpFd211Og3k8jCZp7CT+
X-Received: by 2002:a05:600c:450c:b0:426:6099:6ea4 with SMTP id
 5b1f17b1804b1-427c2d0d87cmr3203045e9.38.1721192624784; 
 Tue, 16 Jul 2024 22:03:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF61v6pCOFB0Fv03dXNsIYoawym27UDJ/1D/Wj6PTCRKBu0WrCfQj1M8LDz5ZuRKp5upW0CTQ==
X-Received: by 2002:a05:600c:450c:b0:426:6099:6ea4 with SMTP id
 5b1f17b1804b1-427c2d0d87cmr3202885e9.38.1721192624346; 
 Tue, 16 Jul 2024 22:03:44 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a8799e7esm143550615e9.18.2024.07.16.22.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:03:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-stable@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
Subject: [PULL 05/20] hw/scsi/lsi53c895a: bump instruction limit in scripts
 processing to fix regression
Date: Wed, 17 Jul 2024 07:03:15 +0200
Message-ID: <20240717050331.295371-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

Commit 9876359990 ("hw/scsi/lsi53c895a: add timer to scripts
processing") reduced the maximum allowed instruction count by
a factor of 100 all the way down to 100.

This causes the "Check Point R81.20 Gaia" appliance [0] to fail to
boot after fully finishing the installation via the appliance's web
interface (there is already one reboot before that).

With a limit of 150, the appliance still fails to boot, while with a
limit of 200, it works. Bump to 500 to fix the regression and be on
the safe side.

Originally reported in the Proxmox community forum[1].

[0]: https://support.checkpoint.com/results/download/124397
[1]: https://forum.proxmox.com/threads/149772/post-683459

Cc: qemu-stable@nongnu.org
Fixes: 9876359990 ("hw/scsi/lsi53c895a: add timer to scripts processing")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Acked-by: Sven Schnelle <svens@stackframe.org>
Link: https://lore.kernel.org/r/20240715131403.223239-1-f.ebner@proxmox.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index eb9828dd5ef..f1935e53280 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -188,7 +188,7 @@ static const char *names[] = {
 #define LSI_TAG_VALID     (1 << 16)
 
 /* Maximum instructions to process. */
-#define LSI_MAX_INSN    100
+#define LSI_MAX_INSN    500
 
 typedef struct lsi_request {
     SCSIRequest *req;
-- 
2.45.2


