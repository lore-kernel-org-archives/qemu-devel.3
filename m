Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1525CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7LZ-0004zS-Ua; Wed, 31 Jul 2024 07:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7LY-0004uM-HD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7LW-0006lT-VC
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722424698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aYyzfF6IqNI/L5NVj2X9zCG1qLPKn4/0ehGgl/Nh5hs=;
 b=EuiOMw1o1DolyvdA5smgeeZ/LDYgJiujcLPAomvxR2zPfOXmTdMgnMkYfuvgSCwTYO31Wy
 REkdYr8an0zLOJwxfqRbyb1MWeu0bZPnlFtQRqYmlS+scVKUySRJt7k0BxUg/2fgc+LudV
 xwcBV/goP0vYt8IfHvpIbnxijPMwuoY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-bhX0ubxlOEi-_9zCJzCpGg-1; Wed, 31 Jul 2024 07:18:16 -0400
X-MC-Unique: bhX0ubxlOEi-_9zCJzCpGg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a766a51b0dso6173771a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722424694; x=1723029494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYyzfF6IqNI/L5NVj2X9zCG1qLPKn4/0ehGgl/Nh5hs=;
 b=KAZjc8R5N58hHkBsaDlS1GM/UAP27pRIgqtRoLUo2gwz87NTb80Hm+MZohzDlQqUgM
 e6EDE7Vf7i2liEb+bjesw+AA45pxQd6Hxxp5lCiyd4Rxsw6KM7wwqz95yrXqG7Fzc8Ae
 9AtZEkVElj6f1Ba9fgOdvYfj7MBEeDlCYAkKBhNJkFKRnLYnZZECJe2zhl/AjKzC8mCJ
 92M/iOFu2xm2/fonvP1066zlAQdh0o87rBNM7977Jd9HIvTBb4R65XCENH0yyjfsG9Js
 XFDXp7lx7Zq2Z5WRr8cvsjvhSh23GPSqV5fOnYXkezZWVpSypyws/wg/wlC1mKxaSLC1
 V8Ow==
X-Gm-Message-State: AOJu0YxpOLFMscu6j2NVxnhyP8VdDu8cgPF5o3Gxdx7rHx6wMcevcZcT
 OjUT1JBUIJt5LCbqr1QzCkML1E0xPzfLcQUUwwmH4xpatTzHuRnGJAMKKqZ3tLOk9Zqk5wdTPgk
 62pjkdtTrpKyKjbhcJiurDpc3kYIwiUwnl+dqdFHRBKuch/Vx4GuQgD+3P8QOehqogcmvdRIXMw
 6ROE1GHXnPZGg+bpovpfeuPiCjbj/Gz6Oj+0rb
X-Received: by 2002:a50:d4d5:0:b0:5af:874d:1b7b with SMTP id
 4fb4d7f45d1cf-5b02000c604mr9118256a12.1.1722424694534; 
 Wed, 31 Jul 2024 04:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHscWNXIyOaWDoq+cl3VgCRoKNVrM48mtyCKBkDpOwgWt1IUGSvzqZe7lPZBmQ5SWbYdV/rKQ==
X-Received: by 2002:a50:d4d5:0:b0:5af:874d:1b7b with SMTP id
 4fb4d7f45d1cf-5b02000c604mr9118231a12.1.1722424694044; 
 Wed, 31 Jul 2024 04:18:14 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac6358fa5esm8548783a12.32.2024.07.31.04.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 04:18:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Subject: [PULL 02/10] target/i386: Change unavail from u32 to u64
Date: Wed, 31 Jul 2024 13:17:58 +0200
Message-ID: <20240731111806.167225-3-pbonzini@redhat.com>
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

From: Xiong Zhang <xiong.y.zhang@linux.intel.com>

The feature word 'r' is a u64, and "unavail" is a u32, the operation
'r &= ~unavail' clears the high 32 bits of 'r'. This causes many vmx cases
in kvm-unit-tests to fail. Changing 'unavail' from u32 to u64 fixes this
issue.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2442
Fixes: 0b2757412cb1 ("target/i386: drop AMD machine check bits from Intel CPUID")
Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Link: https://lore.kernel.org/r/20240730082927.250180-1-xiong.y.zhang@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4688d140c2d..ef06da54c63 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6039,7 +6039,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
     uint64_t r = 0;
-    uint32_t unavail = 0;
+    uint64_t unavail = 0;
 
     if (kvm_enabled()) {
         switch (wi->type) {
-- 
2.45.2


