Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616FAC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 15:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s55sE-000580-N5; Thu, 09 May 2024 11:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s55sC-00057S-Sf
 for qemu-devel@nongnu.org; Thu, 09 May 2024 11:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s55sB-00023o-GZ
 for qemu-devel@nongnu.org; Thu, 09 May 2024 11:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715269194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SggfTuYyggwoM3Dk/FnrixXh4FdicngFCQV1xP2xz1c=;
 b=YV/gWE0CKul3MBQcvAY1UcCtSmJXSMYd17AtLJra4+7BXyg2AWT3Ec5Ea0XQAsDmPQh49H
 TzA2Pdc6cqL1YeRMkoluIm7kVlxz8HUw+FrXBmsEp7+w9FkKBh9WCfpAIQjppawVye7Wdf
 2TXFnW9tCj5qXMvXukSkCajyE/hzXK0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-dITDrtErOy6pUMfpQi74tg-1; Thu, 09 May 2024 11:39:53 -0400
X-MC-Unique: dITDrtErOy6pUMfpQi74tg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59eea00cafso77890466b.1
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 08:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715269192; x=1715873992;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SggfTuYyggwoM3Dk/FnrixXh4FdicngFCQV1xP2xz1c=;
 b=dojILzuCgmJuSJIDzuHqLNh8f3v1tMOPehThyD+kg8Q28lHXAVppf1B0+7e6trZTLX
 SLed+3t1NZNn/GRHxuNUatn1IFo7gUL/lfoEQ3idGfK0TNOJeT+t2IyAHRcoGwf0n0SX
 mxzlaPl6000OT22Aw5Xti2HKhcn/u1ixLNcqvJIX2mFRolkSA/LPAivuRGKEi85pKtyt
 1M6qeIn9p3kX3hVEX4ziqgyqySD8yW9HJumEjo5Pf1blr4HB+/wxvLddGxBdlgWEBrCo
 jUBTmQeIERMgmd3Wr6X10URQhhKAbKUDaTT00gJqwuwepJjhU2g0K+DaZIZK3VLvXU3A
 6QGA==
X-Gm-Message-State: AOJu0YymwBnHcok8xwUCOaVJFzYIssyXbcGAPSzFBJQidf1o4cKWAAXm
 RieQyOujFTPrG453XHN/+0XfsHwJT4qPvbGeGEph7xNiKODxpPTXqJw1ttQHjOpcT4DDuLbGwQj
 WoSJGDXVb5RHdFKdNEVB40gKSVZIVtUimeYUpquRSu99YnlPdnC7LyYsrPIa/e9QXRxG6b0JxeZ
 oOMBab4dgmsvyJ9tBkHUkXB1m+O9Ze3OSaitgv
X-Received: by 2002:a17:906:1d0f:b0:a59:9da0:cc1 with SMTP id
 a640c23a62f3a-a59fb9c53damr520536166b.58.1715269191933; 
 Thu, 09 May 2024 08:39:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhClLXxfjl2M/7hv7WaWabP6EmUXTp9lNU2b3tyAVbcY032yO0hqWEXtMHqL+wmpldZJOUZg==
X-Received: by 2002:a17:906:1d0f:b0:a59:9da0:cc1 with SMTP id
 a640c23a62f3a-a59fb9c53damr520533966b.58.1715269191555; 
 Thu, 09 May 2024 08:39:51 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b01467sm86460566b.170.2024.05.09.08.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 08:39:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/i386: fix feature dependency for WAITPKG
Date: Thu,  9 May 2024 17:39:50 +0200
Message-ID: <20240509153950.143766-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

The VMX feature bit depends on general availability of WAITPKG,
not the other way round.

Fixes: 33cc88261c3 ("target/i386: add support for VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE", 2023-08-28)
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1058b6803fd..f2ea6899e39 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1551,8 +1551,8 @@ static FeatureDep feature_dependencies[] = {
         .to = { FEAT_SVM,                   ~0ull },
     },
     {
-        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
-        .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_WAITPKG },
+        .from = { FEAT_7_0_ECX,             CPUID_7_0_ECX_WAITPKG },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
     },
 };
 
-- 
2.45.0


