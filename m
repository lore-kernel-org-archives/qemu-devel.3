Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30C1C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7sG-0006ux-7p; Wed, 15 Jan 2025 13:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qq-0008Mr-S8
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qk-00071A-6e
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kii3OpRcU1wXLSEo03c2NmodU8Ev9h2TzMQ/hu40ANk=;
 b=JUXbjippCt/gThnTDjzwH12y5kFD1YaJPsbkiZ1lT/POMa0mS4ZA7Yizl7669h+3o00fHl
 P9N4pqIiLTE5IzSsucQS57p48StitqIYrjHvLony+xYuJtH4kfIqKMr8eKiooMur05VT+L
 tqxka1QP5NsDAIUz9BHrhh9oLfp06eY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-0L1rlHR6MLy--4TyZ2VCiA-1; Wed, 15 Jan 2025 13:10:30 -0500
X-MC-Unique: 0L1rlHR6MLy--4TyZ2VCiA-1
X-Mimecast-MFC-AGG-ID: 0L1rlHR6MLy--4TyZ2VCiA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436289a570eso1165e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964628; x=1737569428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kii3OpRcU1wXLSEo03c2NmodU8Ev9h2TzMQ/hu40ANk=;
 b=WCoVr+DT0niUzynpe88AgfFDfD9sjOy4SVszxE8i7LEN2zoojLy/lOtJ86YHwBeYjR
 hQ9PU7qfUtXg+jiMGXSyE0o8n3N5ebRnXPTm4PLEUG9MFGKkwklNXv4o6wcefkJx70cv
 hqfo2GFOBScVDu7wCnQUZj93wnBBgrX1xY4mzQt6w6yN2gFB7Pay0aCFD5VyS86MUYf8
 9XkPhIVelWLMGH6FkysaA7KNFlD8/v7VLKyoBm2Bc8jYTXed/SwbNPnp2gE6/r509pR4
 Mg1LeArN9ycRiVfjshG6fk0ODKOnQyV0USTU4Ck6Ya+DN6e+AV82Id7Y2/RDDjQMFMY5
 paxg==
X-Gm-Message-State: AOJu0YzPtLjszgtChERg6+VmJkmqFoI84BF85ueYvW23SBbPwVoxzbS9
 yy7gwjYIeqdizgdPBrLI7jd7OXJQdEvc1ZsM1hpiR0xdepJCbDi0eWcKqNOegEQ3Kjs7BubOR5W
 AZyK5IWJ/pJYX0Pa/84a2KmZiRmICym9+I8lEyk+qhFtaNK0TGGgLT9Ez+1ziOHSnCLHA3XWhF5
 o+ME/3otU7DUZWYAwzKBEdBDQjnqu5Sg==
X-Gm-Gg: ASbGncsmzZKKN2cStR88S4lzzsVkWYQOPSmrHH/f6kRrSWNBg6bbv7ZnOJ5CZ3S7DD8
 cdBFBQxhKFi7pquey8cvMcz1aTHC59CRUk0n9SuOUIvDet96b7VQhGgwzZvW4GEQotYjmf2FwIj
 14LcfcW3KdZDixpSDEwUD4WnI09CnSYe0Zazj53Rm0I4OwSAscwDgxhtmJfBb2QEgsljfCQoNqA
 TYOq/Oe/A2DvdlN8ofhU2TBQ7Lz3GD1pzMcycopiWz21KGGMv2z
X-Received: by 2002:a05:600c:54c5:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-436e3fb231cmr256182615e9.27.1736964628371; 
 Wed, 15 Jan 2025 10:10:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFolWjDnyXe8Fyrvz0sfvcFYWUBgkNh9x94PI6ctfbfKCQhoGNAo4PAm+DW2CNNLzrfvK4YFQ==
X-Received: by 2002:a05:600c:54c5:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-436e3fb231cmr256182335e9.27.1736964627999; 
 Wed, 15 Jan 2025 10:10:27 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c1664e8dsm43324755e9.1.2025.01.15.10.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:27 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 37/48] acpi/ghes: don't crash QEMU if ghes GED is not found
Message-ID: <1acc8d4e647e3d9fc45cc43c216e784e47a74809.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Make error handling within ghes_record_cper_errors() consistent,
i.e. instead abort just print a error in case ghes GED is not found.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <c7e1665ba46df321f0ce161d60dfd681ab827535.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/ghes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 66bd98337a..6843ddf64b 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -371,7 +371,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
 
     acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
                                                        NULL));
-    g_assert(acpi_ged_state);
+    if (!acpi_ged_state) {
+        error_setg(errp, "Can't find ACPI_GED object");
+        return;
+    }
     ags = &acpi_ged_state->ghes_state;
 
     start_addr = le64_to_cpu(ags->ghes_addr_le);
-- 
MST


