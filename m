Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FF4C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2RS-0006wE-Ab; Tue, 11 Jun 2024 10:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RP-0006v7-Hf
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RO-0005yc-36
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ftFLj961lY1sH71EgKyVbgD5orNrRVyY99cZHuM258U=;
 b=WqlJ98Sm955ORUI43FekqV7P+kYVya1243gAIXWapfmeGx9dc7wBoeyc5YMzWadHOJsUQg
 Q3Fy9tIfW95hrNV74aXxqGQ2rPdE/9J432BCfazKPwxY0W3EFNXFlYrCJaDBAu8kIfjogu
 uDZga04UuPWwwiQEpHTkXcKF2vB0Q6I=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-O6q5I1MeMRmKXlDWMuMLzg-1; Tue, 11 Jun 2024 10:25:35 -0400
X-MC-Unique: O6q5I1MeMRmKXlDWMuMLzg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52c8ddc2ef9so1672919e87.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115933; x=1718720733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftFLj961lY1sH71EgKyVbgD5orNrRVyY99cZHuM258U=;
 b=m8F0N5KT/HQjOly129sRPteEzH4/30JHP6cx59Jg3Zkqm7fFWEiEmPFI9krpYsR9Um
 Zxhf0qEIe+vUoYXo+GUWUx6K2dIGreQ28xF/J4X5ctAGKCG0nG/ERepVw7VEPAvxP9fk
 /DOVgGHmH7HuyYokVJ1K9MQDhqDj0SnRDu+Eku/FQX4N7lNv3iVca+qmhfs/+ACgOIvO
 SsZdM7CkR7aTjF1Zn9+p6+/ofJDAF0+zjSSzfu9/NRRZhbtsewMmTENF2fks2oweanre
 RXp2iPzU3zu8CsxGqSB6Nn6jcUUaibWhc2WVGMAroPDyLQwI90ahHCL74bbuyXPGjuHi
 V9Mw==
X-Gm-Message-State: AOJu0YwsHZjC0XZXcVoA8yG4PkjYPZSpqVARduVvwKYFtsObrn9JVc8O
 J4lC+csMPvxaYYgBunaSzzvlIOeETjuHwdepv66keDaZysINIrLtm6OLm/iUGswCSND2TYhy8oD
 bf6021nggtlabNRAJEkqav8xPygtaAnA/zOQrmnxPVKnAtXTZyx2KkRyjgkaT+vvZBa1ZmWfPlE
 G3V6pEJAiFHN/566hfEo6zzbHEnTzmv+mh+gFv
X-Received: by 2002:ac2:498d:0:b0:52b:c2b9:d988 with SMTP id
 2adb3069b0e04-52bc2b9da42mr8322386e87.40.1718115933419; 
 Tue, 11 Jun 2024 07:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR2pZlck7RRAw0TqD/I3kay/JF8gooucdcgPmJqn+heHK3/lVymr0o81TL12vsMxVxYW8wtg==
X-Received: by 2002:ac2:498d:0:b0:52b:c2b9:d988 with SMTP id
 2adb3069b0e04-52bc2b9da42mr8322363e87.40.1718115932950; 
 Tue, 11 Jun 2024 07:25:32 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f17a103ccsm334886966b.136.2024.06.11.07.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 04/25] i386/sev: Move SEV_COMMON null check before dereferencing
Date: Tue, 11 Jun 2024 16:25:02 +0200
Message-ID: <20240611142524.83762-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

From: Pankaj Gupta <pankaj.gupta@amd.com>

Fixes Coverity CID 1546886.

Fixes: 9861405a8f ("i386/sev: Invoke launch_updata_data() for SEV class")
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240607183611.1111100-3-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 7c9df621de1..f18432f58e2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1529,11 +1529,12 @@ int
 sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
-    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
+    SevCommonStateClass *klass;
 
     if (!sev_common) {
         return 0;
     }
+    klass = SEV_COMMON_GET_CLASS(sev_common);
 
     /* if SEV is in update state then encrypt the data else do nothing */
     if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
-- 
2.45.1


