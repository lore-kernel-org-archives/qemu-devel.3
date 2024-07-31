Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC649C52D54
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7Lp-0005qv-QM; Wed, 31 Jul 2024 07:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7Ln-0005q1-Lo
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7Ll-0006mr-IF
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722424712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DLy0sdEp2Wnrm9eD4P6E+5mw/BzvIrbLw2Ba6SR4iAA=;
 b=WH8X/Kw0bUHLndjXJ4rzcAxeLe1My41r1A4oFvemydKfgPUeikb+w+K/WjBGEf8r3MWsN2
 Qbddw8wrWoHOD0w3vHhDbp9lezmMJMyRxlqvcMssDQ4pweBg3trhPqrH7q/zjJ3Kk/efZl
 H2xkEcTSz3Y1IMn/PgB4/nmHI2efH/s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-uITCLyngOCqMHzmmev9jOw-1; Wed, 31 Jul 2024 07:18:29 -0400
X-MC-Unique: uITCLyngOCqMHzmmev9jOw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7275e17256so568537866b.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722424708; x=1723029508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLy0sdEp2Wnrm9eD4P6E+5mw/BzvIrbLw2Ba6SR4iAA=;
 b=Tuthy6cmqdPy0VgwodP7D3jPnYkWCu7xUnE9nPWSczjzXuRXszfCaRNGKoRW8+63xe
 F3XR0VM4rxmcK4r/uIJ40MDrIcQGKb0SzmbWPOzXHZInAMklIgYCFQNx2gEDAsQDSOgI
 WAuE6cN5pQ1cnh/qMchFUmXKODSzORyOWKhxzuMisyggubuAns0KGw9pu/onCfppbRS4
 IYJpYpLGNH5Ii55IHqNzVVYyZOJRXhV9K6TmBGBWsWLMGD7YNoZXrhdA0mhfgjgbJ3LL
 GqATYZCvqLgP6rD6OR8U5sCeVZFBJaYVMqS641Vbft3nJJWZoaiwGg6nX2bEvrcNJr9I
 HhVA==
X-Gm-Message-State: AOJu0YxT3EunkmXVwLiAo8t6AIrD2S5sziz8CpWXGEyiACVe+IM9iQSx
 qBY+fqM0i56FRGI6+Rg9iu4u8KSIRuiNk9atzwXip2Wc3imV0zxzl5gDIq4uDPZGlplgGuuKggm
 IHCoBIWai+9KcaCLajvRT71Sk09hTdLw3k186PTmm428cqgXlLDESHhbhZ0GPwtsNEmzGY3fR0r
 BRwFK3ZIMbLDWEXmjNinc2NXuxPmOr2gDrzd/G
X-Received: by 2002:a17:906:d54f:b0:a77:de2a:aef7 with SMTP id
 a640c23a62f3a-a7d40150ad2mr1032012266b.44.1722424708137; 
 Wed, 31 Jul 2024 04:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd6FvfL4RnnSElTY80AYlYfZV9d1vWEZnrHe6i02iCVhI11f10D2a8OGal0TNReq4Uh8ed2g==
X-Received: by 2002:a17:906:d54f:b0:a77:de2a:aef7 with SMTP id
 a640c23a62f3a-a7d40150ad2mr1032010766b.44.1722424707768; 
 Wed, 31 Jul 2024 04:18:27 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7d9043ca41sm148185366b.72.2024.07.31.04.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 04:18:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Anthony Harivel <aharivel@redhat.com>
Subject: [PULL 07/10] target/i386: Fix typo that assign same value twice
Date: Wed, 31 Jul 2024 13:18:03 +0200
Message-ID: <20240731111806.167225-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731111806.167225-1-pbonzini@redhat.com>
References: <20240731111806.167225-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

From: Anthony Harivel <aharivel@redhat.com>

Should fix: CID 1558553

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
Link: https://lore.kernel.org/r/20240726102632.1324432-2-aharivel@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index b4aab9a410b..31f149c9902 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2694,8 +2694,8 @@ static void *kvm_msr_energy_thread(void *data)
 
     while (true) {
         /* Get all qemu threads id */
-        g_autofree pid_t *thread_ids =
-            thread_ids = vmsr_get_thread_ids(vmsr->pid, &num_threads);
+        g_autofree pid_t *thread_ids
+            = vmsr_get_thread_ids(vmsr->pid, &num_threads);
 
         if (thread_ids == NULL) {
             goto clean;
-- 
2.45.2


