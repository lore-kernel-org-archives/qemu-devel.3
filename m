Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A015E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK4M-0003v2-Vg; Fri, 10 Jan 2025 13:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2W-0000MR-8x
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2T-0001BJ-0s
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZZpz1I4nrrOQRN+TRsF/5PkMw69HmjZiuT6tDsXbT4=;
 b=Z/6RDpkMXZ92zIHqlpZxH+uJjBEQ0U5tluLWradpwmvdkBd0qMnvj6+8Jh3HHWW7W2nbSc
 gnB30mEZ5sVxmXCPugcplk2rsfoEbeA7EKAziZkIXLhv6CWKUtteL0uBORyqGnCRv/E/IT
 FcvHEao7LiYrNb0uOWeLspP/lxn3/mU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-QaHz8nPAPlqIOEONLei_WA-1; Fri, 10 Jan 2025 13:47:19 -0500
X-MC-Unique: QaHz8nPAPlqIOEONLei_WA-1
X-Mimecast-MFC-AGG-ID: QaHz8nPAPlqIOEONLei_WA
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa67855b3deso200719866b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534837; x=1737139637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZZpz1I4nrrOQRN+TRsF/5PkMw69HmjZiuT6tDsXbT4=;
 b=wC8ZDXkAvl5/xx0ohmxL6zW9dHSJUOvhY887tGN8waTpc0cP8q2N7RSdjUo/WNIftI
 yePuk00Yl+MCptz4X82jlGo6YgSJ0cuHCp17wU4MmlvT4VJoLb/vYOUQ3AMxVGyFJW8X
 CGvzOilj2pGGugYnHF3K2yYcFFm/YqbA0TtO1TrfVXLlwJlTSLDraZaODXi2l3CUwqej
 O1tXzjOz/PFXvL63SdIlW1TCIlc1nHiTAEZaUDQEIC9f6dGlhPPSBE5hF4cZjgWFglcw
 Ifc/THqH/iZJfvShaQZcSiV0SJZIso46u32ln6SiKjpzD4tyxhqnMIJz9M44JxEtRdCZ
 QINg==
X-Gm-Message-State: AOJu0YzJhFYXr7c9ldqLxHyaCMjndyl3PB0IQC8wqDKdJF0eOglzPQo4
 /wT9rQXG+3G2WoUYYXhxlaKG9vIUHtqGlPxo/6l8qk7i/xSF+kScOcnui0x9t78b8+whdExPTOQ
 mPv3Qagl3JipdUPKfJzYXmOC7Mh2bXDi+AJXc1vTotS5ey8Qusq+9SscCG2ptUNz+E+wKLeZku5
 Iuh2rWstIYhyGedRadYNz3OIx29y0RpHmzrcX/5VY=
X-Gm-Gg: ASbGncuOHUW6HaJ9j9+xVPgC1IaNCXjsdG3aAhhBAlS+4trB5MgnZz9uxGPJi5/njuE
 PhMDguHts6mj3xd/rrSlS1bePfjl8mVEj2KRW849GfiCIlBF+iIAh6lVvH/bGZLaAqGKzhrcf1V
 PdagppUvAyntFHJ5/KzvwDHVOgJm1w4tZk2DHBpaFo8zjI9uBsg58d/gAFM4oX2rWzVTVkAAquN
 9zeCVo/Dhid/78gzHHP7U+FHf1mANi6WwTRpd6aiTT06c/ai1Pfh+aTlJI=
X-Received: by 2002:a17:906:db04:b0:aab:eefc:92e5 with SMTP id
 a640c23a62f3a-ab2ab6c46a0mr922132366b.14.1736534836991; 
 Fri, 10 Jan 2025 10:47:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHwbxf+HDdzW3foNxEh1+dCID7p8h+pNbaC/OmiN7IsVgNWVbfVRRe//1Dc+tnvITau2jOfw==
X-Received: by 2002:a17:906:db04:b0:aab:eefc:92e5 with SMTP id
 a640c23a62f3a-ab2ab6c46a0mr922130366b.14.1736534836543; 
 Fri, 10 Jan 2025 10:47:16 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c96485aasm194854066b.176.2025.01.10.10.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Zide Chen <zide.chen@intel.com>
Subject: [PULL 24/38] target/i386/confidential-guest: Fix comment of
 x86_confidential_guest_kvm_type()
Date: Fri, 10 Jan 2025 19:46:05 +0100
Message-ID: <20250110184620.408302-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

From: Zhao Liu <zhao1.liu@intel.com>

Update the comment to match the X86ConfidentialGuestClass
implementation.

Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Link: https://lore.kernel.org/r/20241106030728.553238-8-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/confidential-guest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 0afb8317b58..164be7633a2 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -46,7 +46,7 @@ struct X86ConfidentialGuestClass {
 /**
  * x86_confidential_guest_kvm_type:
  *
- * Calls #X86ConfidentialGuestClass.unplug callback of @plug_handler.
+ * Calls #X86ConfidentialGuestClass.kvm_type() callback.
  */
 static inline int x86_confidential_guest_kvm_type(X86ConfidentialGuest *cg)
 {
-- 
2.47.1


