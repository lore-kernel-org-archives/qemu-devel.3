Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AC0C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFQA-0006OL-Px; Fri, 28 Jun 2024 13:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFQ9-0006MD-2l
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFQ3-0002Gl-Lq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qo4iq+TZlgWKFhoxHuIKDhYlvc+TuqqUn66pvomGcWk=;
 b=i2WAKshHKQAiNKUkLPdy55mv7LKHQ42XEcZD/yjIRJChCwYt5KZMlhOlU5NNHRNozasiTA
 qvSYp84fQ7CaYM2rS0dBJGoG/Ns3Oru3T6Xj4sJXWEJ1YuNSAKJKH9ADNpjem7KZL7X1i/
 KbZG8+wtanchovDiarx8dneq6q8bILM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-LqKosx9PPFyq0fkDn0gGkw-1; Fri, 28 Jun 2024 13:29:53 -0400
X-MC-Unique: LqKosx9PPFyq0fkDn0gGkw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57a524f1f7eso587748a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595792; x=1720200592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qo4iq+TZlgWKFhoxHuIKDhYlvc+TuqqUn66pvomGcWk=;
 b=psCeIX7L67zCo6lqG56x4hSehpDNVLm7BYfjDhUT1rjHCPftK4NZcUMKIeELl9A+ZM
 af07viAZUGgpBrhlxv1ha4GmHNKHZUoJjBDUSzO8M4Kvo0DYFVaH0oiuoaEhBdsVoeNO
 DR6ieT7NK+jMSVRcA4sfNZb0ysnm2hidbQisZUFPjz1TeVQq+ZiVefSl5Y79xllpxwLt
 gGgATVX2roo6iKoy552SgMwAOkQnV7VCt0bbZ4Fj3qNZ6FV80ml3B8wC6/wgoB/p1h4J
 aFPqJjWhEWy3aSuo9r2OxrUtx5AKJdWKOY700xQV/AXQ+jX9N66AIXEbuV/18BAMDs7J
 U6lQ==
X-Gm-Message-State: AOJu0YzZiZi3YCi5+HAhRwi8sQ15KhyPbMmz2MxSLGBNaQ2uzFYe/Y96
 9Sf4pkm/D6D8rlG5xI3gP+4klp6XHdajJ5hrDpyUU8BitVKQCkAi/qWf+p9ut62HlrCTD7cF5XO
 znY1DIAJ53bgPw6N7h7tNgpomcLf6W8t0K8+/O3xtZqY1+Zmxd67SYVLD/yn6H2QqBKqCrpSTE6
 4DPjj24Zj0CQsLsqRhir+OZzf+omBvDKTEnbTE
X-Received: by 2002:a05:6402:358c:b0:587:2e28:deb6 with SMTP id
 4fb4d7f45d1cf-5872e28e17fmr279896a12.41.1719595791705; 
 Fri, 28 Jun 2024 10:29:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENIIbfMiXwLufWcsM3nBI5wJswICyLXb0ZJtVHbOnv1GDCYh7+e+7ZP/GWB26agnJBCAILAw==
X-Received: by 2002:a05:6402:358c:b0:587:2e28:deb6 with SMTP id
 4fb4d7f45d1cf-5872e28e17fmr279880a12.41.1719595791302; 
 Fri, 28 Jun 2024 10:29:51 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861324f069sm1305553a12.33.2024.06.28.10.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/23] target/i386/sev: Fix printf formats
Date: Fri, 28 Jun 2024 19:28:55 +0200
Message-ID: <20240628172855.1147598-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

From: Richard Henderson <richard.henderson@linaro.org>

hwaddr uses HWADDR_PRIx, sizeof yields size_t so uses %zu,
and gsize uses G_GSIZE_FORMAT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20240626194950.1725800-4-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 0ffdf8952c3..3ab8b3c28b7 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -934,8 +934,9 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
 
 out:
     if (!ret && update.gfn_start << TARGET_PAGE_BITS != data->gpa + data->len) {
-        error_report("SEV-SNP: expected update of GPA range %lx-%lx,"
-                     "got GPA range %lx-%llx",
+        error_report("SEV-SNP: expected update of GPA range %"
+                     HWADDR_PRIx "-%" HWADDR_PRIx ","
+                     "got GPA range %" HWADDR_PRIx "-%llx",
                      data->gpa, data->gpa + data->len, data->gpa,
                      update.gfn_start << TARGET_PAGE_BITS);
         ret = -EIO;
@@ -2148,7 +2149,8 @@ sev_snp_guest_set_guest_visible_workarounds(Object *obj, const char *value,
     }
 
     if (len != sizeof(start->gosvw)) {
-        error_setg(errp, "parameter length of %lu exceeds max of %lu",
+        error_setg(errp, "parameter length of %" G_GSIZE_FORMAT
+                   " exceeds max of %zu",
                    len, sizeof(start->gosvw));
         return;
     }
@@ -2185,7 +2187,8 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
     }
 
     if (len != KVM_SEV_SNP_ID_BLOCK_SIZE) {
-        error_setg(errp, "parameter length of %lu not equal to %u",
+        error_setg(errp, "parameter length of %" G_GSIZE_FORMAT
+                   " not equal to %u",
                    len, KVM_SEV_SNP_ID_BLOCK_SIZE);
         return;
     }
@@ -2223,7 +2226,8 @@ sev_snp_guest_set_id_auth(Object *obj, const char *value, Error **errp)
     }
 
     if (len > KVM_SEV_SNP_ID_AUTH_SIZE) {
-        error_setg(errp, "parameter length:ID_AUTH %lu exceeds max of %u",
+        error_setg(errp, "parameter length:ID_AUTH %" G_GSIZE_FORMAT
+                   " exceeds max of %u",
                    len, KVM_SEV_SNP_ID_AUTH_SIZE);
         return;
     }
@@ -2291,7 +2295,8 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
     }
 
     if (len != sizeof(finish->host_data)) {
-        error_setg(errp, "parameter length of %lu not equal to %lu",
+        error_setg(errp, "parameter length of %" G_GSIZE_FORMAT
+                   " not equal to %zu",
                    len, sizeof(finish->host_data));
         return;
     }
-- 
2.45.2


