Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE935D74941
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 21:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5tZs-0002Pe-8O; Tue, 29 Oct 2024 17:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZm-0002NO-V5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZk-0007d2-W8
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730236585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGscfKpqzkKw2z0pwGkeUsLF9GAsvAy96M3qbQI4qYM=;
 b=d7rEWb6bOFezlwq+BvTlbOfXEkmP32oADCUFG3s8pXbbri5UGZntsu6VlJYnKsrWqHbaRb
 QOR63i0vHg3lyNiZm93REEWutePS6kCXDSGotyLL3Dv5Ww5wui+705zRr9Z3gW8T0SmugA
 In083iwQy2rYHZAi/NYICyatrd3o8Z4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-OEu8E5eaOgqhDPrg6jiWow-1; Tue, 29 Oct 2024 17:16:21 -0400
X-MC-Unique: OEu8E5eaOgqhDPrg6jiWow-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5eb9c053637so5280580eaf.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 14:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730236580; x=1730841380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGscfKpqzkKw2z0pwGkeUsLF9GAsvAy96M3qbQI4qYM=;
 b=E7ZqlpqaxZIlReicc+jJuAAkt9Z+YyWP08BnGxwVYosnLVAO/Qhq8qGNDM4HqJgKKa
 wwy+Gism2a22kyzyWEdSUh8bi05e9nYrDjzylY8EGxiYqIXTVVu79bdZQfcBEx0YxpIT
 VU1TxuJX29WTOM+WjvgvBUIoX7+Y0UMS7gS3raVaRLVeVE2hf1xJyARajjTrDwNWFk0i
 OcAFPtM6SadxBflZIQG5aio6fI2acohTksyLevehcBaIwX54qzDz5jRFX+ybSnMIX1ZW
 AcSFFHg6GpvVay1mH4Z1C7yw2DKJzafZflVJna4W8NdcdvtOcAhf/S62ZRSWnC+3hGB/
 g8iA==
X-Gm-Message-State: AOJu0YwknJGmdwHQqtXwfirZSb8J9MjYuK8DnVuV19D1oiKU2bSK4Ggi
 +/9xbjc/adJ6Er9/FjwcgaoUbgnRsu1cJqAfk/WcnA80EDVhr5kV5BCD6npmHhVDNjKPXJl3sVa
 7k9afZly5QoCqpPwnSHDExI6Iu6i9lVPVGdjUuhh+NiZy9HXlhu7xBivKDSUIRkEBhoYsy9dOXn
 x8EEcCICQhCqXOrHu7nGeShs58R0nIRjrIZQ==
X-Received: by 2002:a05:6359:4c8b:b0:1c3:7070:4442 with SMTP id
 e5c5f4694b2df-1c3f9e87977mr570092655d.12.1730236580329; 
 Tue, 29 Oct 2024 14:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyUSzfCQCKaRSuBIBI9St1GTAfYmIx/z/6MTNOLQR0Rt7LLJzXWoUKTTh2rB4myepRulOmUA==
X-Received: by 2002:a05:6359:4c8b:b0:1c3:7070:4442 with SMTP id
 e5c5f4694b2df-1c3f9e87977mr570088855d.12.1730236579911; 
 Tue, 29 Oct 2024 14:16:19 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132292c97sm48481691cf.49.2024.10.29.14.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 14:16:18 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC v2 4/7] qdev: Make qdev_get_machine() safe before machine
 creates
Date: Tue, 29 Oct 2024 17:16:04 -0400
Message-ID: <20241029211607.2114845-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241029211607.2114845-1-peterx@redhat.com>
References: <20241029211607.2114845-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

qdev_get_machine() is the helper that QEMU heavily uses in most places to
fetch the current machine object after it's created.  It can only be called
after the machine is created as of now, otherwise a container can be
wrongly created at path "/machine", and that could crash QEMU later.

It's not an issue for now, because all code paths will currently make sure
this helper won't be called too early, e.g., before the machine object is
properly created and attached under the object root path.

This patch makes this behavior more predictable, by never trying to wrongly
create a container if the object is missing.  This enables the helper to be
used even before the machine is created, as long as the caller can properly
handle a NULL return (which says, "machine is not yet created").

No functional change intended as of now, but will start to make use of it
in later patches, where qdev_get_machine() can start to be use before
machine creations.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/qdev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5c83f48b33..c867aed28a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -840,7 +840,13 @@ Object *qdev_get_machine(void)
     static Object *dev;
 
     if (dev == NULL) {
-        dev = container_get(object_get_root(), "/machine");
+        /*
+         * NOTE: dev can keep being NULL if machine is not yet created!
+         * In which case the function will properly return NULL.
+         *
+         * Whenever machine object is created and found once, we cache it.
+         */
+        dev = object_resolve_path_component(object_get_root(), "machine");
     }
 
     return dev;
-- 
2.45.0


