Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E30C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHPBj-0008NV-Db; Wed, 12 Jun 2024 10:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHPBi-0008NK-3J
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHPBg-0002o9-P2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718203376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qq8ujPsJ+J4O/loqzt4Yo7HEnPlqsiixMZpBY1GvreI=;
 b=UV1hBUDxGAa9bJvRB0ga6AXJBEAb/2OgTP0vVheg2k2j74RWETnE8b0UgON+PjagWh5EAe
 e9UGPVijC2cfYXpcionL8S1reV2xrM/onMo8+gSBjAxHg2FnTgGCCx+UM/yKYjhQ6aZ2rX
 t2MGsoGDgmPzKSLpg5WD181A/emxYmM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-FLJ5Lj-tM3-odvUCkxox3w-1; Wed, 12 Jun 2024 10:42:37 -0400
X-MC-Unique: FLJ5Lj-tM3-odvUCkxox3w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-43fd537e6a6so5526861cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 07:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718203354; x=1718808154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qq8ujPsJ+J4O/loqzt4Yo7HEnPlqsiixMZpBY1GvreI=;
 b=sxuttfnVY0KTj4UMiCOv+DW/6wzJjhe61R7OUTwQQN7p4MMw14AfNPJ71t4smcVp76
 HtwraKL1ab1F1JWsmVS4SFIMp51a3b1AQ59xYkAWAbICuKSF6oZyDDIjt5S23GW76BwW
 AxKTJVCvDs8HkF/auY913/NpWoqsFwIYgJ7B4hW+h68hc/m7zSHI8X1C7Gt/nRiGQ2TM
 a4hTELCdv2ftzy5qjS9K2hudGV7HdrXHiTwumSyQpAfWEg4nQl1nE3c/JofurbSzoydz
 iGRi8Q7nCNQzw8I04GfSbQqe0VbTtoYH83ZHibImA9MVjTPdRQhC/bCEf9akd2boFJ/y
 U7lw==
X-Gm-Message-State: AOJu0YxrFxtVwqnrO12dx06TMpDgh2TXdHZIrTJvY2SpPadnp57AHTi3
 ompw6wnUrEOmDiuVI//3eOZA/uHB9LI1QaPawe1umuGMOAsa+7Qv71eOEWBmnCBusCwZ9bkztab
 A3a0MjC1U6i1Nhgexibm0jL4z5KZ9coM/7NPeWG/RSWZCqvJs4ikOm8TCvlz1DHH4vUmChoyB0j
 Ss+91cbUzcI/xsJn8j736cg5plaOldewuNGw==
X-Received: by 2002:ac8:7d81:0:b0:440:279c:f9e6 with SMTP id
 d75a77b69052e-4415aca8c5amr19354201cf.5.1718203354188; 
 Wed, 12 Jun 2024 07:42:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAVUywsmnBrLAPYDZ7kYritTrdaoRf5vdSbQ7SHuEHPIAi6xsukZSvYP0Fjg5oofCiUlFMkQ==
X-Received: by 2002:ac8:7d81:0:b0:440:279c:f9e6 with SMTP id
 d75a77b69052e-4415aca8c5amr19353881cf.5.1718203353560; 
 Wed, 12 Jun 2024 07:42:33 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4405e3ded65sm37581681cf.87.2024.06.12.07.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 07:42:33 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bandan Das <bdas@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 1/4] migration/multifd: Avoid the final FLUSH in complete()
Date: Wed, 12 Jun 2024 10:42:25 -0400
Message-ID: <20240612144228.1179240-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240612144228.1179240-1-peterx@redhat.com>
References: <20240612144228.1179240-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

We always do the flush when finishing one round of scan, and during
complete() phase we should scan one more round making sure no dirty page
existed.  In that case we shouldn't need one explicit FLUSH at the end of
complete(), as when reaching there all pages should have been flushed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ceea586b06..edec1a2d07 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3300,10 +3300,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section() &&
-        !migrate_mapped_ram()) {
-        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-    }
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     return qemu_fflush(f);
 }
-- 
2.45.0


