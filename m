Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E69BC25B5F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66mT-0003C9-GZ; Sun, 12 May 2024 06:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mO-0003An-Ig
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mN-0005kj-4N
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwo7BsnwcP82yreks1wX75A1VxKsNz9996vExb/jyP0=;
 b=h7YMH5VJIGogZa0YJg8O6PTIN1gQSQ5A3JAc8DODLU+Hlyjy/qWK/fNBOO2bPSS8M+/qVE
 X0IvdFQ/6lQSZIqV3hxvcExeYrofeu5wt25rV84nEZd9iIXRv0VI4zcjMquVahEQ47whbH
 N9WdUH7j14wO0M77uwBvcnERNHxn1mo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-oIEXNUg_N1SpidCCTfw9Hg-1; Sun, 12 May 2024 06:50:05 -0400
X-MC-Unique: oIEXNUg_N1SpidCCTfw9Hg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5222a0800f0so1691175e87.2
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511002; x=1716115802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iwo7BsnwcP82yreks1wX75A1VxKsNz9996vExb/jyP0=;
 b=sXt/hI4sUwKhOd2Am7H7y3Mj3cdiYKTBtN0r5iuBxjBSjwIftP8BCYrCX5sW/+GSm5
 mxkrY0YnRl9VYlEmIx116iL646+DV+6/UaTWHjsOE99P6cnkCykSugYsp7iJfgiGrycW
 Vtf8acCZqnAa0M8TN0zSUhRIwtzYeTGAcXclyz73sNX02B54i6fpqC6fY4fKOmxat+MG
 BoxIbPAlpBIL5e+TMMYRn2HWVdHj1+N4rwjnzptWCnBe9MByBWgueE8Tk2kyVGYbfOs1
 eRiIn9xHPj/XqwHHvpgG1D9Vj0EPSiPp2i/9RrJ0DkyGoQLmocxDrlTg2KjbKqbnJqS9
 aLAw==
X-Gm-Message-State: AOJu0YyA/qf/17dXbEKdv5JtoMJYnS2SaXCZ5f8jddNxL7shziIR4xVr
 LU2bGjn2zWrdBzHxrvmJx1IGIfonXnJoGTsmTljvQifEk7/UCf4nuJIwQpIOHk/OE0tf7hULtvb
 li54HzRouTrb+AaveWhNteXbp1JADcwMv+T4qhlqJ3cJoTDRkpX9A3duczxWT6hUagXG5CHE9yt
 QPplngl2T9++hUDuYG6B5Jy/zgiTdu/V3oq501
X-Received: by 2002:ac2:43a8:0:b0:51f:488d:274b with SMTP id
 2adb3069b0e04-5220fc7c51emr5565816e87.9.1715511002525; 
 Sun, 12 May 2024 03:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErL2eFXDAdNljIaOx0awTzYibrCMd0B1P0uKGzoAzIeHuYYVMM/f79pH+uf6GEwN3bFURi9A==
X-Received: by 2002:ac2:43a8:0:b0:51f:488d:274b with SMTP id
 2adb3069b0e04-5220fc7c51emr5565806e87.9.1715511002042; 
 Sun, 12 May 2024 03:50:02 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cd85sm450869066b.15.2024.05.12.03.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/27] target/i386: fix feature dependency for WAITPKG
Date: Sun, 12 May 2024 12:49:23 +0200
Message-ID: <20240512104945.130198-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 79372de8c5a..cfe7c92d6bc 100644
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


