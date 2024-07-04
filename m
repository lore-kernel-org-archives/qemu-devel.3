Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCF1C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 10:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEs-0007Ae-NF; Thu, 04 Jul 2024 05:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEh-0006n6-9m
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEb-00087W-GO
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oseQ60e5wmgH0ZYm/I14i7Pkbsm8+uJkxNMnBtHXQnA=;
 b=im3Gz5c6uPI+Vf+Ognv3VP28mWvKjjp01N52qt8rmX26nopIsx4BXsSeaXN+M9jWwNofXo
 5dGCgI3MHgyVfhNHEt/Nhk/4BCgnheE/vjfPLStGg8ktBms84RPN6+c9PBp+lTavKw44o6
 vmzDbgBvOqdefM1Ho8yLeGzPVxd4p0c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-V77fFsZZMcGcPJcMkJ5YGA-1; Thu, 04 Jul 2024 05:58:32 -0400
X-MC-Unique: V77fFsZZMcGcPJcMkJ5YGA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36793b39ee5so353656f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087110; x=1720691910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oseQ60e5wmgH0ZYm/I14i7Pkbsm8+uJkxNMnBtHXQnA=;
 b=w9EBwlttGr+EdJs0FYsrXzCI+aE2d5dN11+gDDUYoDaE9J6v9xtlg6aXJVF9xCOBoW
 5qBRSnNsr4+IMciMe/OUrBUmWZHoavrQZ4xBdxGO5TmtZhSLKR8DJeSnDeNSsg3DG6hl
 nZ1BLcVAfD8IFrHhZb1o3411WBTUmY3/5lFaxmdAMhpEQCEgoeoY/mLRvENn73UJwm7Q
 aC7TeTrtMUQz7QPJ6Socz3POyY6Q8mw4in33A+ZgQsl5r2xwq4qrUc8ESMRiI5ir9QLl
 /Rwibh64zJ5tdmUNwEjYr5XHJ1bCkv9/NJCwTUcgxSz3cRKn4Spcvy+pHZOGZ5elmV0i
 uVlg==
X-Gm-Message-State: AOJu0YzbdQF0e40h5kzYxkkVq0SOdl+n1mC49yljzB5b/EnRwiQM1f66
 ZuVAu0icjQyH2dSLnETSfJ64eygfbnJ6kO8S8D3DZBHlTTDVDAZVREzSdw+gK8bqdPLd134Vcpy
 goqDzKNOGvC1VlJhHNaU+RRimVZrURYgagXxELFje9qLlPjRrukDzHMO36hoDjQo6N3KOxnH59a
 9XTQLlLNL299HMGoQp60MANy2yEmDwNTliebho
X-Received: by 2002:a5d:634a:0:b0:35f:2030:d42c with SMTP id
 ffacd0b85a97d-3679dd23884mr836053f8f.17.1720087110333; 
 Thu, 04 Jul 2024 02:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHiGLzNYBYPP7ccKZI76EO1/MeLF57Qjfznlta5K+o3POQ3uYjQmQIBywRVTbBLyrO+TN6YQ==
X-Received: by 2002:a5d:634a:0:b0:35f:2030:d42c with SMTP id
 ffacd0b85a97d-3679dd23884mr836041f8f.17.1720087110019; 
 Thu, 04 Jul 2024 02:58:30 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36794e6863dsm3595268f8f.50.2024.07.04.02.58.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] target/i386: SEV: fix formatting of CPUID mismatch
 message
Date: Thu,  4 Jul 2024 11:57:59 +0200
Message-ID: <20240704095806.1780273-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes: 70943ad8e4d ("i386/sev: Add support for SNP CPUID validation", 2024-06-05)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 3ab8b3c28b7..2a0f94d390d 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -841,7 +841,7 @@ sev_snp_cpuid_report_mismatches(SnpCpuidInfo *old,
     size_t i;
 
     if (old->count != new->count) {
-        error_report("SEV-SNP: CPUID validation failed due to count mismatch,"
+        error_report("SEV-SNP: CPUID validation failed due to count mismatch, "
                      "provided: %d, expected: %d", old->count, new->count);
         return;
     }
@@ -853,8 +853,8 @@ sev_snp_cpuid_report_mismatches(SnpCpuidInfo *old,
         new_func = &new->entries[i];
 
         if (memcmp(old_func, new_func, sizeof(SnpCpuidFunc))) {
-            error_report("SEV-SNP: CPUID validation failed for function 0x%x, index: 0x%x"
-                         "provided: eax:0x%08x, ebx: 0x%08x, ecx: 0x%08x, edx: 0x%08x"
+            error_report("SEV-SNP: CPUID validation failed for function 0x%x, index: 0x%x, "
+                         "provided: eax:0x%08x, ebx: 0x%08x, ecx: 0x%08x, edx: 0x%08x, "
                          "expected: eax:0x%08x, ebx: 0x%08x, ecx: 0x%08x, edx: 0x%08x",
                          old_func->eax_in, old_func->ecx_in,
                          old_func->eax, old_func->ebx, old_func->ecx, old_func->edx,
-- 
2.45.2


