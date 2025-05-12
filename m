Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC372C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYTq-0006bG-1x; Mon, 12 May 2025 15:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTn-0006Mb-7B
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTl-0007Yw-H3
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baUoSc/kcICrDzWC2euzR8VyUVJ2vhHKTO2IbuR51/s=;
 b=DoB2Fw6tWpm8qKrqCz28v0Dx/0lwfX8T9SlnZza4F/idNDN+6yYCvWaTZ6AKQHhaNev2if
 Uv/WDu9HUF0vd60MJoGSUM/V0OOXALMdxmnqchegPNjky03AX+VnG1U98kxxM1mFN20XdN
 qjQ9K+QmJMwvxPWxpHFhUVCgTr/Da3s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-qRqWN6TNMS2G09mKyH6kUw-1; Mon, 12 May 2025 15:06:19 -0400
X-MC-Unique: qRqWN6TNMS2G09mKyH6kUw-1
X-Mimecast-MFC-AGG-ID: qRqWN6TNMS2G09mKyH6kUw_1747076778
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a1f9ddf04bso1843542f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076778; x=1747681578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=baUoSc/kcICrDzWC2euzR8VyUVJ2vhHKTO2IbuR51/s=;
 b=J43JKZEjHTJKNyNSQsfPVyPWIB/B1OwglM3p4VAFmIe4kMl768eF6TFE/W7kUAYFbt
 XN4fbXYrO/0lO5gcUM/9mf2Wztd7suVok/UvbrAfZF3b1tXXh1XDX/O2Ysa5gAdgCm0F
 Z8Dxtqog8OK4Bdegx8EhUpxRJ1+6hw5Za5M71tvR2/MlJ4gscveWeJWVQzaVVa7vIrQf
 LEf1TSV5AV0PZpQn8Y/rTxuwi8vFwojWbPL8AlWbU1obZaSdNkYXfXn/nqfw6TNIcz1T
 7JIJPSdOjApwI2k9H9H5S098kFv+jrIyuC44cwLChZtIrdK/4lc0JRBfAQvhxn2xd7ok
 sQjA==
X-Gm-Message-State: AOJu0YyZYKJb3RairaUng7odmX+6HTvoGTo4qH3vcc40XHQBUOW0coQU
 pjFfnC6RKroqvCNCfnVikSXfII4f90zT4xkC0yLGE3F9gxr5xv4qT8kaa8FKWeLxEaIUi9vFDeU
 VB4xNqFaEWZ6Rc9HO/ZIgTSoOe0/zEIrNLyTpvQaP6jFSYaI7fA9z3g/q5eUwI9/N8EK645fSvy
 elFwttgVExfthyJOhIXzduISGONC/gb2zVl1A/
X-Gm-Gg: ASbGncuKKsAKVAk8Ysh0lWEToM6YhHql289SVv0FnhcWB/mQKd7vrHEHZtWJMlsRHYq
 0C0bYayOhu+J9cXwisiWd3NqwghnP9zWZxo0vhucoQIGDbR1b1DqgfsJ8vOOtzZw/Gb1nSooNo6
 4ZcliIdZ0nOdsX2pFy+6YZpW6V5G+6TIZxGJBnjvc+28AGQXfiWfbCqDBu/851Ae+gTx5FWAh9s
 act+PzuTyv/Xtje8JpssWns6KjUq0ubAmjN7QES3i2m+mDFJ+y1QTAKVzPduoSinVEZEKJgZIb7
 nX51qX99jxMGpX0=
X-Received: by 2002:a5d:64c3:0:b0:3a0:b807:7426 with SMTP id
 ffacd0b85a97d-3a1f64ac686mr12218720f8f.52.1747076777783; 
 Mon, 12 May 2025 12:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo0HVKPDzY13pgpgy5EhEg6k3QqCZBYRLyeYxNFU0EFuuu43EHOBXT5lCY4klSOM+J5VS3Jg==
X-Received: by 2002:a05:600c:cca:b0:43c:f597:d582 with SMTP id
 5b1f17b1804b1-442d6cfa8d8mr107304095e9.1.1747076766603; 
 Mon, 12 May 2025 12:06:06 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d6bf96bfsm135718365e9.6.2025.05.12.12.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:06:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PULL 16/16] target/i386: Make ITS_NO available to guests
Date: Mon, 12 May 2025 21:05:24 +0200
Message-ID: <20250512190524.179419-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

When a system is not affected by Indirect Target Selection (ITS)
vulnerability, VMMs set ITS_NO bit in MSR IA32_ARCH_CAPABILITIES to let the
guest know that it is not affected.

Make it available to guests.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/r/8c1797e488b42650f62d816f25c58726eb522fad.1745946029.git.pawan.kumar.gupta@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1656de3dcca..ec908d7d360 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1383,6 +1383,14 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "bhi-no", NULL, NULL, NULL,
             "pbrsb-no", NULL, "gds-no", "rfds-no",
             "rfds-clear", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, "its-no", NULL,
         },
         .msr = {
             .index = MSR_IA32_ARCH_CAPABILITIES,
-- 
2.49.0


