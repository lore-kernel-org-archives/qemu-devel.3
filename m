Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6813C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhvl-0006Lf-HS; Mon, 09 Jun 2025 15:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvh-0006Kq-EW
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvf-0000ok-Us
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeJM+ShIS0TMolEwKNgTvE0T6ihxo6U4DD+hKUlZmKc=;
 b=cqCd0OoIn+ErY9gZDkWszwPfgQmEHf+iGdD5StBiK4+UsUYjRG16otuC5EAGoswdRxKI0s
 MpAm00+lKHJQXo4b2FJn6xBvLf0ZQ9n8YGIRGO8f36fXn6+JuL/XIGHsRYnxAxDIlee5EW
 +p/yszMMATFnkcRQW32LBgmK/iGPbBY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Q3YSRhm2NBG33xUOtRHzIw-1; Mon, 09 Jun 2025 15:13:05 -0400
X-MC-Unique: Q3YSRhm2NBG33xUOtRHzIw-1
X-Mimecast-MFC-AGG-ID: Q3YSRhm2NBG33xUOtRHzIw_1749496385
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6faf265c3c5so72120916d6.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496384; x=1750101184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EeJM+ShIS0TMolEwKNgTvE0T6ihxo6U4DD+hKUlZmKc=;
 b=gpx+vFCay6ZIcuL/Q1NYB7stPYBibXLKgZd/G5V4L/XVqUMDq9/F1lvldAqijApXaF
 0ez26gN+oKzrfx3MOcbTvvjE8d8gcm3oboRGG6IxboGf05V3VfQZjUCGDXZRqRsRGad1
 9nJujknfv6gyt2HarSa2zi/1vzW8TE0/Dw4hPbmCEPmQAWLxjEMktXAJgqYbs//jiOot
 X0il8Ne0u4j0L7nbSH/sAyxtDyqYaZrvIY/QbZi+IejRHsHh/mkLHTe+E83MnKrL/ktM
 JjscJHkNpTVwODgxtA21E7X7mZnpTXmSWRecv1b64q4sMWKQIlsIniyxElFyrU67uHkU
 KKow==
X-Gm-Message-State: AOJu0YwibMTPlV415OqH+dQ8lqy+9dsJHpT7Wvjdv/3qrwNIMoZ1CYMv
 epquOc2tjXYF9HAG6Ax5LfdMLKXRs78iIX8DmCRJwR2h+IMqQQ6b10U6Fzhb9BD/DhG9fWKnpLv
 95YJsl6cmY3GQ+dBhmvnV2CAGU7yKG54Sog97i8Wh1IRID/V/uH6XAwQI2zrINVQNaR/C+cLFN5
 EGkouFEFIliriw5ipeMij/hTvBaJfqKKtJDFFKTA==
X-Gm-Gg: ASbGncs8yph3tCAYAnTVG0XYFUGcBHNOGwmE3fr+Vk5issQyOF0tK6EmGC6xiaJ94pn
 gGRCm58hTlj8Xj314vKenzMPPCoSs1CVUjAA5G8oGtm0FsMEJYm7HhT8FqvauymfXHECu9BG9YG
 c4/SxqeacQ7gDcsMQB/ewSnFgSzBWkXTl4e7/dOyWb8mKDSLL5lFxVqACLeHTKCkeCiKP4QXx6c
 sev8g8oCaQ2gJe65Z8RM8e6f1yHXAIBbZbZB64WqTptXcPODXmXFO8CSNqpsDee5QuDp28J45AE
 0FtcpouUbOIZxg==
X-Received: by 2002:a05:6214:29cc:b0:6fa:c81a:6229 with SMTP id
 6a1803df08f44-6fb08fcc259mr226146546d6.43.1749496384623; 
 Mon, 09 Jun 2025 12:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFijfW9CUUQN92l3iNNEySwnpRNvuqGz3LPJQKj4Wl/cWm/l47MLB15yYT0zHThl2MUyA57EQ==
X-Received: by 2002:a05:6214:29cc:b0:6fa:c81a:6229 with SMTP id
 6a1803df08f44-6fb08fcc259mr226145986d6.43.1749496384019; 
 Mon, 09 Jun 2025 12:13:04 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc24sm55178856d6.72.2025.06.09.12.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:13:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 01/13] migration: Add option to set postcopy-blocktime
Date: Mon,  9 Jun 2025 15:12:47 -0400
Message-ID: <20250609191259.9053-2-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609191259.9053-1-peterx@redhat.com>
References: <20250609191259.9053-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a global property to allow enabling postcopy-blocktime feature.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 162c72cda4..4e923a2e07 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -187,6 +187,8 @@ const Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
     DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
                         MIGRATION_CAPABILITY_POSTCOPY_PREEMPT),
+    DEFINE_PROP_MIG_CAP("postcopy-blocktime",
+                        MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME),
     DEFINE_PROP_MIG_CAP("x-colo", MIGRATION_CAPABILITY_X_COLO),
     DEFINE_PROP_MIG_CAP("x-release-ram", MIGRATION_CAPABILITY_RELEASE_RAM),
     DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
-- 
2.49.0


