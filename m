Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0BECEDD89
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW1m-0004iu-HN; Wed, 09 Oct 2024 08:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1l-0004ik-MV
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1k-0005Ru-5n
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNbystHyQfpG9zdYMm/IbZBExIkcr+7+jlbR55DWaDg=;
 b=bgGa3+edro5C/7V3cxoACOZl4tNlptbfnELZhySUEAvCOSNRRovQmW/we0fHlMoB1Xxg/o
 ENM8x5Ab5u38UfwvkhuXc73v/4L3Tu/joc9yupT6zvnK4gkrnr0DzDQz5RI49CriP1lShu
 6h7klgnOa7KsAHg568J0+QuNI9BaoZQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Vwbz1t1qPsOfcjSys4hjCQ-1; Wed, 09 Oct 2024 08:42:50 -0400
X-MC-Unique: Vwbz1t1qPsOfcjSys4hjCQ-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-835439ecbd3so37324639f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477768; x=1729082568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNbystHyQfpG9zdYMm/IbZBExIkcr+7+jlbR55DWaDg=;
 b=vvUFQHrvZzM3Wbq0NCWuv0VivtbqhQnyfj/JQTo0zM9RUI17jrfuB1k7lIi76RitGm
 7MEkXAjpMiyi4ZjMD9BekkI9JOasf1/mcJJiWI/Ah/1QkU+XZ6BeNXAlcKWwv0Is7wVU
 8RAsJ/5lPzKOx8JZDzo89x9IaMQc9qNdYzeD8j+cKqIG9kt7yBGBu7GHANTmTJGFdyxQ
 Aus8qDPyHrpZy1flYBPWn7uCpuNmMEmXJstAmH9jvbRUf0FDRtFkKb2KIGKzIljvQhHZ
 Tsf697qp8ujHvaos3Ib27gXcCjwnJILFiqftleQ4sGBiKeCVpV/o0pG5UBqZHvqt7vhH
 JC9w==
X-Gm-Message-State: AOJu0YzKnxCNQd0OP23+QsssiTNcethazWGRdAuitmQmZlzvOIFK2Wb+
 BKsTgv4wS4axfhqWyxtxGbXIQOipzvT8UfKucVG5QS38QdR2nty1YgGogtkFiZEti1+llTyybs2
 DhwVDL2x2wXgEsM3yiVA4ozOBQ91ugXzxSUUpwhvigslHotuD1G8qm3SnBmSRs6EcbuNFayj8Aa
 JezRD2LgzZclUU3BGFFsLIVI3akLIdfQuTOQ==
X-Received: by 2002:a05:6602:148d:b0:81f:75bf:6570 with SMTP id
 ca18e2360f4ac-8353d4a3b07mr228901939f.5.1728477768375; 
 Wed, 09 Oct 2024 05:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENlNaV1R1A1VuGrBVbAxUhZF4hpbLmYToSTtwgeVsAdY+lrDV+0KUmwe0au+/CrpyEeXnQ8g==
X-Received: by 2002:a05:6602:148d:b0:81f:75bf:6570 with SMTP id
 ca18e2360f4ac-8353d4a3b07mr228897639f.5.1728477767895; 
 Wed, 09 Oct 2024 05:42:47 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:42:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 04/12] migration: Remove unused migrate_zero_blocks
Date: Wed,  9 Oct 2024 08:42:30 -0400
Message-ID: <20241009124238.371084-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
References: <20241009124238.371084-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

migrate_zero_blocks is unused since
  eef0bae3a7 ("migration: Remove block migration")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240919134626.166183-3-dave@treblig.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.h | 1 -
 migration/options.c | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/migration/options.h b/migration/options.h
index 36e7b3723f..79084eed0d 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -40,7 +40,6 @@ bool migrate_release_ram(void);
 bool migrate_return_path(void);
 bool migrate_validate_uuid(void);
 bool migrate_xbzrle(void);
-bool migrate_zero_blocks(void);
 bool migrate_zero_copy_send(void);
 
 /*
diff --git a/migration/options.c b/migration/options.c
index 9460c5dee9..6f549984cb 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -339,13 +339,6 @@ bool migrate_xbzrle(void)
     return s->capabilities[MIGRATION_CAPABILITY_XBZRLE];
 }
 
-bool migrate_zero_blocks(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->capabilities[MIGRATION_CAPABILITY_ZERO_BLOCKS];
-}
-
 bool migrate_zero_copy_send(void)
 {
     MigrationState *s = migrate_get_current();
-- 
2.45.0


