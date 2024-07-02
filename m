Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381D1C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwP-0008GQ-IF; Tue, 02 Jul 2024 16:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjw6-0007Mu-2w
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjw3-0008Pw-Vg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WFUPapk07PnJ8CLhVhbjjsuC+NoP2UxN6SJb+Hfxl60=;
 b=HvavVm/oyAOQVnFNa4wTqevFP601fG0GL2V1LadwuGOZYtCSmH9WVzf/M+aDmdl5aTnliv
 ysPLlSMN7DFrr/tDDm48D8fqQ7LCanGKtKt0gTF+AaFeZ4JgM7DESXlAfO3OWGkJQf8BlJ
 vpj2e9yIgQOSEn133ObHIdyGItxJy04=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-fEpk3Kx-PZSamilY9elDrA-1; Tue, 02 Jul 2024 16:17:05 -0400
X-MC-Unique: fEpk3Kx-PZSamilY9elDrA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ed0d046689so44782231fa.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951423; x=1720556223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFUPapk07PnJ8CLhVhbjjsuC+NoP2UxN6SJb+Hfxl60=;
 b=fEB2DmKyMGyJgnQJb0c8OzoIM3+kGCsxWjzKVaaOOM4YyR6pjziSthSmYDwE5MLrtL
 xY0Fxa2LLtRs6U4viR7+4TIpfe1uN7tIb/AKzLon3lnrjaDIf/Me5fmNb61g0Z3QUyP6
 0CAocBlivAKMXi36s0bY4E4JIRYEMdM83nJq2Utz1mJJrX6+A3KewtD48yuMOxBiiN3u
 Dyr0XQMSosgPexlxyDDr0T48nQJap3UxmsqL+L5+KET67eKWkIvIEZtBPoPpVIepyZFr
 +EYfPtJ7mKEADimn5TyFnWObzeLMovfBQN2zjbYn/Pdlf0xvRla/u83mXj3/C9zGAIKK
 8IDw==
X-Gm-Message-State: AOJu0YzsiTE71pJ7dyPalhY0ZEn38Z9I5nyGjxQ7L7v2a7Iwk9sg4C9m
 INfzMuDBx2flKkJUm+6iQ6Lc98uEDe30MSQ64oep+6SVK7LLTrSy/IPhXUIr7xmMyYbuV3NHA7A
 JPFDWZgqhUYM/Wzzv24uCtepT0i/9c/GDFKZUatg5Scfzg9y1v/uiLDRZr69/U0arU+zLIhjve/
 zQvNWf7VFh0QVGasHbg0vUpRP+CH38EA==
X-Received: by 2002:a05:651c:220e:b0:2ec:174b:75bb with SMTP id
 38308e7fff4ca-2ee5e38103emr69606671fa.28.1719951423222; 
 Tue, 02 Jul 2024 13:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWuTgT8rvQMK1YaRAM2ZRbnzg6G0ty0wB6ndhH7A99cRdroF7aU89MvWs9FGnNQ6H3zQnMRw==
X-Received: by 2002:a05:651c:220e:b0:2ec:174b:75bb with SMTP id
 38308e7fff4ca-2ee5e38103emr69606501fa.28.1719951422511; 
 Tue, 02 Jul 2024 13:17:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55e61sm208160205e9.20.2024.07.02.13.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:17:01 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:16:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v2 29/88] hw/mem/cxl_type3: Allow to release extent superset
 in QMP interface
Message-ID: <c51dca04281f9be6eacdad8fc8f9c7ddc87dcf3c.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Fan Ni <fan.ni@samsung.com>

Before the change, the QMP interface used for add/release DC extents
only allows to release an extent whose DPA range is contained by a single
accepted extent in the device.

With the change, we relax the constraints.  As long as the DPA range of
the extent is covered by accepted extents, we allow the release.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-15-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0d18259ec0..5d4a1276be 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1947,7 +1947,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                            "cannot release extent with pending DPA range");
                 return;
             }
-            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents, dpa, len)) {
+            if (!ct3_test_region_block_backed(dcd, dpa, len)) {
                 error_setg(errp,
                            "cannot release extent with non-existing DPA range");
                 return;
-- 
MST


