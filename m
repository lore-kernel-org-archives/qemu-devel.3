Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B95DC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqVx-0007ui-Dj; Thu, 27 Jun 2024 10:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqVv-0007uR-1s
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqVt-0007IB-Il
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719500054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kahTNt6XmEjQH2qUEICtuDFVEALNHFOMfowFA3jt/ZA=;
 b=jDLZV1/zbBfhzUFhBwbFEpGtInIJPzEQ2eeopqf5jX6fqmLv8yh2ejIaakU0U/vjdOnIWq
 AZFBcQEcM1j8VDnEWrgj5ElDiQFvzltkWgD4slcRzQjm3TPrPFIMnzFi1VxBsQo/Sl+qbF
 XaJzCauamPJcapOKOmhnbnA/ZE7JoTA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-qL0-b2wPOCyrVkNnT0HWYA-1; Thu, 27 Jun 2024 10:54:13 -0400
X-MC-Unique: qL0-b2wPOCyrVkNnT0HWYA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7135459efbso339314266b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719500051; x=1720104851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kahTNt6XmEjQH2qUEICtuDFVEALNHFOMfowFA3jt/ZA=;
 b=qhpEkW8iWTyKvf0GcU+J5Gp37DsU3ROBiBAT0awmdgdexG9y0m48TGXjRTtYJoIlce
 rd45kKRpJZHfxCJI5YazLjdoQz0nZ8hambLXTyroAWUJrVotRn9/r1c2KXjUsAoq54ff
 kxVErAzYEXNjo2IYoBhkJhaKs3VC4HghYf4/94NG/dtzpQvM4Vvg2QTWLhluz6tcybCa
 WQq23m+kilflL3HVOAds8TwLpPgKF2RnVQp/X5Fbpwh0M50lxx5hg58TOPza5TLpDaIX
 PsZdPETzxn72iovXyH+EIY/hwBy7HDYkm8c67cIWt0ARw2L6ppUIfiCb7qHa024rHbRE
 H14A==
X-Gm-Message-State: AOJu0YzmppK3IBhOyGQ64c4ABCe9vM40DR5cqHs41psa73Fu7YSYXj5/
 sDoS7Mduhmzyv+W4qa84Ez/KWKvy5LRQ+4/BZsh+HWWUjWcubUFrIzH75nYNY5/IHCkPZP4Qgog
 qMMgj/M9TS+fGpVt9c66TRtCyQEa0t/hxrrHJ4aG//SBwl4sDZKDV3a+mnDptCb1FARZ3k/i4YO
 xW9Tyq1cXqA90jeNO8GwNjqiHiMhPxUMyjlhAP
X-Received: by 2002:a17:907:d041:b0:a72:87c4:8fc7 with SMTP id
 a640c23a62f3a-a7287c4a170mr381386766b.2.1719500051364; 
 Thu, 27 Jun 2024 07:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGLinNd+o/pheO51PaR+rxIPT43fsFfdZcE6j51Y0KmDsjTrtR23gfkR5YGIYZh1ckQOtdAA==
X-Received: by 2002:a17:907:d041:b0:a72:87c4:8fc7 with SMTP id
 a640c23a62f3a-a7287c4a170mr381384966b.2.1719500051032; 
 Thu, 27 Jun 2024 07:54:11 -0700 (PDT)
Received: from avogadro.local ([151.48.235.205])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a729d7203b8sm67210066b.79.2024.06.27.07.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:54:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH 4/5] target/i386: SEV: store pointer to decoded id_auth in
 SevSnpGuest
Date: Thu, 27 Jun 2024 16:53:56 +0200
Message-ID: <20240627145357.1038664-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627145357.1038664-1-pbonzini@redhat.com>
References: <20240627145357.1038664-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

Do not rely on finish->id_auth_uaddr, so that there are no casts from
pointer to uint64_t.  They break on 32-bit hosts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index a6b063b762c..28d6bd3adfa 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -155,6 +155,7 @@ struct SevSnpGuestState {
     char *id_block_base64;
     uint8_t *id_block;
     char *id_auth_base64;
+    uint8_t *id_auth;
     char *host_data;
 
     struct kvm_sev_snp_launch_start kvm_start_conf;
@@ -2208,16 +2209,16 @@ sev_snp_guest_set_id_auth(Object *obj, const char *value, Error **errp)
     struct kvm_sev_snp_launch_finish *finish = &sev_snp_guest->kvm_finish_conf;
     gsize len;
 
+    finish->id_auth_uaddr = 0;
+    g_free(sev_snp_guest->id_auth);
     g_free(sev_snp_guest->id_auth_base64);
-    g_free((guchar *)finish->id_auth_uaddr);
 
     /* store the base64 str so we don't need to re-encode in getter */
     sev_snp_guest->id_auth_base64 = g_strdup(value);
+    sev_snp_guest->id_auth =
+        qbase64_decode(sev_snp_guest->id_auth_base64, -1, &len, errp);
 
-    finish->id_auth_uaddr =
-        (uint64_t)qbase64_decode(sev_snp_guest->id_auth_base64, -1, &len, errp);
-
-    if (!finish->id_auth_uaddr) {
+    if (!sev_snp_guest->id_auth) {
         return;
     }
 
@@ -2226,6 +2227,8 @@ sev_snp_guest_set_id_auth(Object *obj, const char *value, Error **errp)
                    len, KVM_SEV_SNP_ID_AUTH_SIZE);
         return;
     }
+
+    finish->id_auth_uaddr = (uintptr_t)sev_snp_guest->id_auth;
 }
 
 static bool
-- 
2.45.2


