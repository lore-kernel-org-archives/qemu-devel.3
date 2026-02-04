Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C319FEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAU-00085o-VZ; Wed, 04 Feb 2026 14:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAQ-0007li-Ko
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAP-0007wM-1M
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FlCsVTyOmzbmzNiE9LQNPtkryQmNzG3JOg34QbwilkU=;
 b=RVl4rj6UABi0i59GiXOryhO7sFUWFSFyADLkT00uqrBbNYyni2/dNu4I+OEh2uEkKOhiix
 ZEYCuwGWYVa7zpcsJB7kXVuwTfc1dtvMenefnuY4wFwn6D99tzgPQxrYp3Z7tpVIfXMYPc
 zAltfLOpfeqoatxc/Ee8D7GTkJDBfrw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-eWa6iyAJPeG367E_sOCrKQ-1; Wed, 04 Feb 2026 14:03:55 -0500
X-MC-Unique: eWa6iyAJPeG367E_sOCrKQ-1
X-Mimecast-MFC-AGG-ID: eWa6iyAJPeG367E_sOCrKQ_1770231834
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-435add03f12so111933f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231833; x=1770836633; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FlCsVTyOmzbmzNiE9LQNPtkryQmNzG3JOg34QbwilkU=;
 b=hhqTVC2x1aPw+NpRj/B6dWpMMRTkkK/48+Dw3/MkVzP4S9NKL7b8tm5mKG6otORTRY
 aNeuI2VS6qKyl6/TjjILj2arlR4gNAAHFcoLScTBhqGWRidFtSUMl2wC5T6niw9flDx/
 O7Z91w0Zr+kQHjGTgdWmdmd/xcQvacU0wu6gUT1RZKhef/GHptE5SGxqyNIJjLBROLDK
 oG5PELL6DhnpKfKwza1OjE7HqJ671uBEKuYpVn4L4evcSFkbB6NjSDG/35pwbZpqRFyJ
 DeeKXpVrarzo+03ye/k4+gWC7J6/7L/hUcvkply4LobuoX9ymUvi8Q1rnPVnAbsiylJd
 BchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231833; x=1770836633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlCsVTyOmzbmzNiE9LQNPtkryQmNzG3JOg34QbwilkU=;
 b=FzLPZz9cqW1SebUtOpge/a+tXDo9wHpOTQQFV/MTEMsuCRGq7MCwApikmTeaaqqoIv
 HrDlHEHFpqd3B+Y+rq0t5PKX1E0Oc0qhnllJlLmX8ZxOjELCu1tCCnxeiYEGhh2HG2XA
 Kvt0Gt9phjmApQqApAvZvNfihaQtLiwT4qNMgxT5r9UFHDbo9LWlwPuSXmkbt3xN7FoG
 HbFNWJMbMy7Sek3txeDQ2SgYMgGWsI0yu3pUOclLAMT9OXM9tpxb/QQcQzkokjC2cb/o
 8qigLTeaqCZiFG5tedz+xqsa3OQSFn80LOoafWulhgb+gM7GX2adCNFoDKNSF8YgCTLM
 SKIA==
X-Gm-Message-State: AOJu0YyQNsNsaLWiKpnCPCP4hCQtvMrtYJhMrEI7HWOXqPRHdIp5pcED
 yYorobYBzixV0BpVELlN+T1MzAb0JuUyqHSEn7uqjXbLFKKa9S0a4+EGNwSxDfy2J+L435RjPx+
 CoK3HzK3HxJCFOoSy+CztLhONOn8f7flFhKWlBmgdS+GIl1DQmeSJylSi9/0j31+NZDFgKUT1mC
 L6CMO+vlLUEP+Ww4wTbsyUOC2abdm8rTi7yg==
X-Gm-Gg: AZuq6aLiY53TVw0AZzEs45Gj+RLP54KEIwsP38ZCZsH04wikcW1aMA9jSmiPGhKShkB
 WZcG4zOBipTTpdv7XL3Tp0+rUwW94cV3hIjrr1QhhdmjP8NiFiv0Ze0TpqifWsStY+s35vOsNag
 nHyJf97veYPLcYSQ72/KuOW7zvs6vsvuuZqG27YvuieoEgcZZPsj4EUd7yckVNnhGrOHxW3xWNG
 uiKCTyCY2v0LzXbw9RzM1/GECal2btEed6Af0xkpU3tr+XmUSsJOmWoC05s+vdwBuUwZ+g82tV7
 2WXVd0OsRtUzmqblZ924ERXCWkFwzRapM55alrlF7wPdRtIQQMdankdSCUGrO8tix2fbdQBFT2X
 8ViKEvBVnwQjF+mwwnYtBU+Q6SQGPQPi0jA==
X-Received: by 2002:a5d:5d01:0:b0:435:a673:bca1 with SMTP id
 ffacd0b85a97d-43618031b7dmr6033520f8f.27.1770231833246; 
 Wed, 04 Feb 2026 11:03:53 -0800 (PST)
X-Received: by 2002:a5d:5d01:0:b0:435:a673:bca1 with SMTP id
 ffacd0b85a97d-43618031b7dmr6033451f8f.27.1770231832606; 
 Wed, 04 Feb 2026 11:03:52 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e3a3a9sm8382054f8f.18.2026.02.04.11.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:52 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 27/51] acpi/ghes: Abort in acpi_ghes_memory_errors() if
 necessary
Message-ID: <6131883f1a836a1df556e862b46af4e60b8d6b2b.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Gavin Shan <gshan@redhat.com>

The function hw/acpi/ghes-stub.c::acpi_ghes_memory_errors() shouldn't
be called by any one. Take g_assert_not_reached() as a clearer indication.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251201141803.2386129-3-gshan@redhat.com>
---
 hw/acpi/ghes-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index 40f660c246..b54f1b093c 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -14,7 +14,7 @@
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
                             uint64_t physical_address)
 {
-    return -1;
+    g_assert_not_reached();
 }
 
 AcpiGhesState *acpi_ghes_get_state(void)
-- 
MST


