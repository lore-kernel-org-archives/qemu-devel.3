Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6759C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPi-0005fQ-0X; Fri, 28 Jun 2024 13:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPd-0005e3-Qx
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPc-0002CF-6W
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTQLDy7fzv4IlAQ52PKIL6tgs655OTYs6Ror3JKC4ro=;
 b=WbPUcB/9DL3ZQ8XZEx6Vfj5Bdu7RkPMkfII2mQ5Mo6UxsWtASF3L7jCj50lZGDaVPsorYt
 D256zvfRLUEDvYhWODLLyGkDrR+tpf4KoE/F9gGFMCi49Au7Qz135GYiHAeIg1RRFuEFn8
 iPe0pHu59MQkhz286HYwYDkFYNUqtg4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-IJ4nIiYdOfWsz3TLFR41hg-1; Fri, 28 Jun 2024 13:29:22 -0400
X-MC-Unique: IJ4nIiYdOfWsz3TLFR41hg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57d22ea3e71so606634a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595761; x=1720200561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTQLDy7fzv4IlAQ52PKIL6tgs655OTYs6Ror3JKC4ro=;
 b=qAyLtziqWHijKb2779bI/Vk1t462vj4HZ1iltkR8ZsxCaK8QJsNHThqa1IUOrJgDnv
 P37d+IAZ+s5vOQ6aZQdBkXkXA6LczILt2y91I+m2r6F/QWuvBZDog4PXoGJXMd+ClJvB
 FmB09s6VHQKJbrHIRR6ed8Zzwngzd+3lOSnmpCsdLsXkRDu2JYZ4OnuGP7ux3tes+uOf
 HImhBUdi6i0BAKpspmUXK1pdbqbIMLP7U6Zmg1u51PV0AgNoPcyIootSNCKalU9i6d+u
 EYR+FFDqcAj9FoZJTYi8UwaCcmLnXiyViMnXUrhJSev6fei4xj1dG2V4eTBBt4a98Mvs
 lnHQ==
X-Gm-Message-State: AOJu0YxFtIrANgG55110FPM2zJWAorQpKFAp/BZ/yo2umijlXltv+fz8
 466XzCPs3xnE1TRywvNhnfLURQ+6yrbywYSpoOV8sx4qVyL3QVgFqfKCL41JAddNvi9vyyk2eK7
 JOqlca6rOBCfFPzx5Fl8kA+yAZXtngzugWofPRXGypVbAOgyqOI2dgD0dVsjM1T7nY9CFl/ulJO
 4LRMagPr+0SZirm7EIs09pCAUx63zHt4X26/rO
X-Received: by 2002:a17:907:a649:b0:a72:8135:2d4f with SMTP id
 a640c23a62f3a-a7281352e3cmr873131466b.48.1719595761469; 
 Fri, 28 Jun 2024 10:29:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJxjjt9duRZgzcJ9F/23lxvLZauhMr7tyELJiQ742ajIcajjFwLUagkTIWED2gUoTH57P5fg==
X-Received: by 2002:a17:907:a649:b0:a72:8135:2d4f with SMTP id
 a640c23a62f3a-a7281352e3cmr873130266b.48.1719595761141; 
 Fri, 28 Jun 2024 10:29:21 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf18486sm96789466b.8.2024.06.28.10.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roman Kiryanov <rkir@google.com>
Subject: [PULL 11/23] exec: avoid using C++ keywords in function parameters
Date: Fri, 28 Jun 2024 19:28:43 +0200
Message-ID: <20240628172855.1147598-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

From: Roman Kiryanov <rkir@google.com>

to use the QEMU headers with a C++ compiler.

Signed-off-by: Roman Kiryanov <rkir@google.com>
Link: https://lore.kernel.org/r/20240618224553.878869-1-rkir@google.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 0903513d132..154626f9ad2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -925,7 +925,7 @@ struct MemoryListener {
      * the current transaction.
      */
     void (*log_start)(MemoryListener *listener, MemoryRegionSection *section,
-                      int old, int new);
+                      int old_val, int new_val);
 
     /**
      * @log_stop:
@@ -944,7 +944,7 @@ struct MemoryListener {
      * the current transaction.
      */
     void (*log_stop)(MemoryListener *listener, MemoryRegionSection *section,
-                     int old, int new);
+                     int old_val, int new_val);
 
     /**
      * @log_sync:
-- 
2.45.2


