Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2856FC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 23:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZfSj-0001Uj-7h; Thu, 01 Aug 2024 19:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZfSf-0001Ty-MA
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 19:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZfSc-0001oC-Oh
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 19:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722555831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=igfziAhXHEqZepOq2g/cEjBcQT6bFTUtsGt6WB6hWCA=;
 b=In38YZbPUbedkfeI1RTPp/aJMJ0K77dfAY7SijMxU0m/ytm34uSCHTXQh7XjXqWhXwm4tq
 OqbFqm+8SL+seZSmh0cb3kYT2KbBbqSAca7wCirnbo7XfFeSMnMaKO3mWewT0JoEtsr4b2
 ORfXId4zvvtwTK7ZmJyiLs1OdPwuV58=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-8mrNRqOGNW6R5mUzThO3pw-1; Thu, 01 Aug 2024 19:43:50 -0400
X-MC-Unique: 8mrNRqOGNW6R5mUzThO3pw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5a429a572daso6085469a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 16:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722555828; x=1723160628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=igfziAhXHEqZepOq2g/cEjBcQT6bFTUtsGt6WB6hWCA=;
 b=HD/XWc969sFd/I8RGuzurRPfCuCFyFHeAQr8T2w96XgfS/OPz6nmBSec4CRTeTiyww
 xSTqcacW1gD+HPaLFtgtpq8t6c38znmBa5vKC+UE7Ss0N+t9wm408ArNeN53jnx04BFY
 1IxxH5e1jsQc7YCxJ+3qHQ8RRBSSx6eRhKvlsgHXqulmIVg1MyO4qgjZEHwSRxVIVXdw
 PD/2eHUukhhzHfr4TltUuqefXYr0+coj1E/NGf8aWvc6Wz6nOmiP0YaYjakf7FhEfXOl
 8q7abxq+3LUvIFuiCu86ouSxolMkIdqw/yMWojg1UhaxHIm7ydToREEOh3eiqYvUJgog
 diWg==
X-Gm-Message-State: AOJu0YwdFqs11rJM3eOXkgr0M8AQcWvWowCGIS3VFiYBECDWF4kP38cE
 k2u30DXysHCptEwRRdmxpgxQmU/hZZj/aN94NPtBD7dWOTCnRoYO6U+Bc8NCc4N0p7vkOMCAic5
 P4tnZ4l3Z4Bnn3t8bOd6Bb+jOqgffiTRkiYs9qCcMKVfHPeYKQgrrhoKMO/F8MANxAG5YmQ4heO
 GYCCxLkaVuX5+A3Jl1zIDekIfC+5orMD+s4+Ct
X-Received: by 2002:a17:907:94cb:b0:a77:b052:877e with SMTP id
 a640c23a62f3a-a7dc4e5626fmr140574166b.19.1722555827792; 
 Thu, 01 Aug 2024 16:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPIMNy2DFkHQoqIWx3ltDct47CmduchW8AMpdbXdFtQf7XRxtQApCDcfiZ2aRNSoprHETh1Q==
X-Received: by 2002:a17:907:94cb:b0:a77:b052:877e with SMTP id
 a640c23a62f3a-a7dc4e5626fmr140572466b.19.1722555827215; 
 Thu, 01 Aug 2024 16:43:47 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec8879sm31705166b.211.2024.08.01.16.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 16:43:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zixi Chen <zixchen@redhat.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PATCH] target/i386: SEV: fix mismatch in vcek-disabled property name
Date: Fri,  2 Aug 2024 01:43:45 +0200
Message-ID: <20240801234345.355447-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The vcek-disabled property of the sev-snp-guest object is misspelled
vcek-required (which I suppose would use the opposite polarity) in
the call to object_class_property_add_bool().  Fix it.

Reported-by: Zixi Chen <zixchen@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index a1157c0ede6..a0d271f8986 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2422,7 +2422,7 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
     object_class_property_add_bool(oc, "author-key-enabled",
                                    sev_snp_guest_get_author_key_enabled,
                                    sev_snp_guest_set_author_key_enabled);
-    object_class_property_add_bool(oc, "vcek-required",
+    object_class_property_add_bool(oc, "vcek-disabled",
                                    sev_snp_guest_get_vcek_disabled,
                                    sev_snp_guest_set_vcek_disabled);
     object_class_property_add_str(oc, "host-data",
-- 
2.45.2


