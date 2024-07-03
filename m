Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F559C3271E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8kS-0000tl-CC; Wed, 03 Jul 2024 18:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kR-0000gq-0e
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kO-0001Uo-Bm
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WFUPapk07PnJ8CLhVhbjjsuC+NoP2UxN6SJb+Hfxl60=;
 b=WEdfvfbrwUPKp1PJkoJ9O5dDp7DMcgXp6p2mcZad3MeuJwZ/CIQX+veuY4tOW4ICJ5hZDs
 VeqjmK0ZcvZKUQzNtIkhURZjDzEYwgesePqz3U475Pkgsqwf7tDM5XmSxNVXAR1m7nEkRl
 6jM8HJX1SuXDtyWK0hbfmpT/y3t/QGk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-CBAk51sYMMqnzcC1N4PHgg-1; Wed, 03 Jul 2024 18:46:36 -0400
X-MC-Unique: CBAk51sYMMqnzcC1N4PHgg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57c93227bbeso2847049a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046795; x=1720651595;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFUPapk07PnJ8CLhVhbjjsuC+NoP2UxN6SJb+Hfxl60=;
 b=qHE4wBWPSHCjLDZYK2KiriHujvMZarPC3QAyw6yRbGeihEU3lJDVEewm3ZOJkmmpdo
 xu56N0tWpRga0IlvU+PJV1VWUDLXOORDFsQvVYMxOlk/6djwhJvn3Q2X3hEd+SzQvFkL
 40OiSwhuyIHzOkLpAjYHlPTZkBjNSeyiwn7iAx+s1sROX23dFa6Yf30BMhP0zSC6Vr88
 SKYpa1VQ7Xe33fZFIN22mZr129igV82d0eCkTMkNcY+TdwHClEcOjsWCUN39hfP5Byje
 gUFQAxGWLeOyxMKGgu0a1128VKKdSUvGjb5hWyAT2/PstBNzrlHWuK9Im+bAidDlcXZn
 91Eg==
X-Gm-Message-State: AOJu0YxJyHHzwUd1b7pV4FZAHhZC9de2Bv8be9kVgr8gLRy47ylyKm0c
 RC1OrpIAx7KxorP7fsL2SbTVTh0CxMm3ZQ6DeWB4ELlhfFhl8+eGwTs8KSQgzvGBlL+P5ANUwGD
 q5qUvfAYZQlkyYfxsMVq+nTVKDOaFGA4rwuqfItPML1vTg7l8urdKGTgLIMPfHrrJmMrrqsCI7E
 SK9ntYqOQgH3AuugGN1OnBFZwXKxJduw==
X-Received: by 2002:a17:906:68d8:b0:a6f:1025:8dd6 with SMTP id
 a640c23a62f3a-a75144b50b1mr785261266b.71.1720046795120; 
 Wed, 03 Jul 2024 15:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn8JibTmMf4vuYP1+dSTzvAzAkwnT9Yw/yZLUnI36/nSkW29iBIG9f0zEz1CIhJudHWwRaZg==
X-Received: by 2002:a17:906:68d8:b0:a6f:1025:8dd6 with SMTP id
 a640c23a62f3a-a75144b50b1mr785259266b.71.1720046794459; 
 Wed, 03 Jul 2024 15:46:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77b784de44sm3452566b.56.2024.07.03.15.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:46:33 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:46:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v3 29/85] hw/mem/cxl_type3: Allow to release extent superset
 in QMP interface
Message-ID: <c51dca04281f9be6eacdad8fc8f9c7ddc87dcf3c.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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


