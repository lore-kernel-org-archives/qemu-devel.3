Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6A7C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqW0-0007vX-8o; Thu, 27 Jun 2024 10:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqVw-0007uf-R3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqVu-0007IY-Jm
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719500057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndsw8fOyaChmgjQGUrWjnxxCLs4JQPIUld82Y9cUCkQ=;
 b=HyOOzcHJPvx0tPL+ccqPgQGJJ6ohH2oKBYjQYYpb9t712Ws8AJDnf1KhFcx8VGu3qfdwtM
 7Tw6zhEouMDhzbWfaHqAlGhROXLLSS/mozkpbOCt5m8ar8sXXar4DMiL2n2zUXPQfr9TrF
 hPi+2O7lHbxvLnp5rGtNTu4TmRb+Np8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-Haj_ZnLkNAiv8JWxVQAnuQ-1; Thu, 27 Jun 2024 10:54:16 -0400
X-MC-Unique: Haj_ZnLkNAiv8JWxVQAnuQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7253454b3fso269614666b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719500054; x=1720104854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndsw8fOyaChmgjQGUrWjnxxCLs4JQPIUld82Y9cUCkQ=;
 b=AAkKKcYYb7gb0cwwItv+k+5lSom7quVqE6fTNwwMtY+DPKBlH/ZLOnb1vzEmGYKR/2
 RBH+E/MrX+ld6zVia/CgAielZKsqDH//Va+E40CybQhcp+jKJ4JStu3p58cNRmfsmSkp
 Lq51G3kt9zU3L+WI4RNi+vcgy1GySPb8pdwoxpmYAuRSC6wMhT7pVRmAaBg5W8Rvm+CG
 WgRwBeyi0VxKizdQX7pAc6p5Uf2iXLlYlJ8RXy1ib830I6QcvINeZ5ehAiJeKBDnb7aM
 X7N+C49FKsWpgeXEhltRX9WcuDKHHJUd9QMWIcN89WvcJIg2WNGrOYF6JeMQ2Qvh0sed
 j9Yg==
X-Gm-Message-State: AOJu0Yz3OiZS1olB+dWUePfroIafnQjF2uJMn4gYIPVwBCyj7Li2gswt
 zo3WC/1O+RXZ5cFEEBUqP/W0bz2hQXdJljN3ZsL8UnFtaBiavqqmMt891WTLicHlgZ0aWj8+rjA
 QEOglH93FwlIRFhtKyIpewA3pYYiDzcddq3F8nRZiyLEK0heMNG+LOEoAXvn+ox/zdtdZ9/tuzH
 4cLoD3s8pRE4HQ79F5Yn2JDJyKqPefNW9vsuw6
X-Received: by 2002:a17:906:ae92:b0:a72:6416:5ccc with SMTP id
 a640c23a62f3a-a7264165fb5mr603267466b.58.1719500054270; 
 Thu, 27 Jun 2024 07:54:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAG2ibHYkrlelUzyugOBvvt8aeJvYofzbd5oiSk/9XTkw4qPz3/Wc3lWlVgW1Gls49VkYBOA==
X-Received: by 2002:a17:906:ae92:b0:a72:6416:5ccc with SMTP id
 a640c23a62f3a-a7264165fb5mr603266166b.58.1719500053941; 
 Thu, 27 Jun 2024 07:54:13 -0700 (PDT)
Received: from avogadro.local ([151.48.235.205])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a729d77987bsm66000866b.122.2024.06.27.07.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:54:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH 5/5] target/i386: SEV: fix format strings for 32-bit hosts
Date: Thu, 27 Jun 2024 16:53:57 +0200
Message-ID: <20240627145357.1038664-6-pbonzini@redhat.com>
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

Use PRIx64 for uint64_t and %zu for size_t/gsize.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 28d6bd3adfa..77ff908ab17 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -886,7 +886,7 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
 
     if (!data->hva || !data->len) {
         error_report("SNP_LAUNCH_UPDATE called with invalid address"
-                     "/ length: %p / %lx",
+                     "/ length: %p / %" PRIx64,
                      data->hva, data->len);
         return 1;
     }
@@ -934,8 +934,8 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
 
 out:
     if (!ret && update.gfn_start << TARGET_PAGE_BITS != data->gpa + data->len) {
-        error_report("SEV-SNP: expected update of GPA range %lx-%lx,"
-                     "got GPA range %lx-%llx",
+        error_report("SEV-SNP: expected update of GPA range %" PRIx64 "-%" PRIx64 ","
+                     "got GPA range %" PRIx64 "-%llx",
                      data->gpa, data->gpa + data->len, data->gpa,
                      update.gfn_start << TARGET_PAGE_BITS);
         ret = -EIO;
@@ -2148,7 +2148,7 @@ sev_snp_guest_set_guest_visible_workarounds(Object *obj, const char *value,
     }
 
     if (len != sizeof(start->gosvw)) {
-        error_setg(errp, "parameter length of %lu exceeds max of %lu",
+        error_setg(errp, "parameter length of %zu exceeds max of %zu",
                    len, sizeof(start->gosvw));
         return;
     }
@@ -2185,7 +2185,7 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
     }
 
     if (len != KVM_SEV_SNP_ID_BLOCK_SIZE) {
-        error_setg(errp, "parameter length of %lu not equal to %u",
+        error_setg(errp, "parameter length of %zu not equal to %u",
                    len, KVM_SEV_SNP_ID_BLOCK_SIZE);
         return;
     }
@@ -2223,7 +2223,7 @@ sev_snp_guest_set_id_auth(Object *obj, const char *value, Error **errp)
     }
 
     if (len > KVM_SEV_SNP_ID_AUTH_SIZE) {
-        error_setg(errp, "parameter length:ID_AUTH %lu exceeds max of %u",
+        error_setg(errp, "parameter length:ID_AUTH %zu exceeds max of %u",
                    len, KVM_SEV_SNP_ID_AUTH_SIZE);
         return;
     }
@@ -2291,7 +2291,7 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
     }
 
     if (len != sizeof(finish->host_data)) {
-        error_setg(errp, "parameter length of %lu not equal to %lu",
+        error_setg(errp, "parameter length of %zu not equal to %zu",
                    len, sizeof(finish->host_data));
         return;
     }
-- 
2.45.2


