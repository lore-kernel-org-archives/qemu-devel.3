Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6D9D767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNP-0003pW-8j; Thu, 31 Oct 2024 13:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMp-0002eD-S7
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMo-0007TB-A0
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TOqLeQtpEReanbf91UbnwMmvrTuPU1Wv13MQzPMF2ro=;
 b=Tg/G5Lc7NHPZN0ad3RukLH/khxJgJxC24AWc5EHQLOGOgOt4g951IwlNAmMIfkKDM9yMqA
 SGaQ4W0TVhSzQarGzQGpbVjnhkvLGo34vSlzjZ6amkS2yyHmzQh2F2cEvUe2Ut1WR2gyQZ
 aPAuvn5ZbO6red3h7E0B5/BFut0iGjc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-zjapQuJZOAaJNO20dL-Jrw-1; Thu, 31 Oct 2024 13:53:52 -0400
X-MC-Unique: zjapQuJZOAaJNO20dL-Jrw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4317391101aso7529405e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397230; x=1731002030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TOqLeQtpEReanbf91UbnwMmvrTuPU1Wv13MQzPMF2ro=;
 b=LM9TMk4dRoltol9V8QBUODFWwZntx5f1IIO2GpA91COKPk4KFpT6LpCmvz6W+ysS7U
 r8qt5tbYLP7B3rXQyfDDqHTf68pqq+zrNWCXuruMx17kscDsS3XkTuBkC3Tu4LYgozxN
 qM28yHxIn4EJg+USuQZkcsiN1HN30B8vTnObpCuufmA6M/4JoW9LgSohU2UWwh+r55Ad
 v+dHhR2EeiK3CSCCs85Y1XYazGriMgp7mo1GFl/nDg3d5oD3ZEoWajfU9iiDu4ytWwoi
 siLOpCy+9OdrP6SZmYNrPt4pGRo/dsodiSXCzCRjaiGU5sDDbWe8UaUxKMwMtZMNoUKr
 O6gA==
X-Gm-Message-State: AOJu0YwoCKs6fqqx3dC5roiYVpnO3I3+LMB9ky35Z8vXclsa3N1vA6Ii
 VqmTBoFjmLR+OsPZBPZxhord9OhzwKN+jFdO4+fj4rsATUAifK7AsRt9MvtcVSEcJDqXnJ1lw8M
 ke8dpKxHK+ZuBAFIJbxl4ctkTTHSGz+ZF8Bzq0JmLZ89zDXKrmAYMj4ShbA9ZUmbhsdLlXKPyZU
 PEAkRS2YSMR/brDzZUt5jVqvS1Kt4G5r5qZ1m+Izw=
X-Received: by 2002:a05:600c:1c15:b0:42f:8fcd:486c with SMTP id
 5b1f17b1804b1-43283297a37mr5805005e9.33.1730397230383; 
 Thu, 31 Oct 2024 10:53:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQImw2kjCHHUkbpXnM79CVMa1MyeXPIGLsBx6f8hIxmuOfPsPOgw0iUppUnOFVN96z/NGXog==
X-Received: by 2002:a05:600c:1c15:b0:42f:8fcd:486c with SMTP id
 5b1f17b1804b1-43283297a37mr5804795e9.33.1730397229952; 
 Thu, 31 Oct 2024 10:53:49 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d698144sm35966375e9.39.2024.10.31.10.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 42/49] target/i386: cpu: set correct supported XCR0 features
 for TCG
Date: Thu, 31 Oct 2024 18:52:06 +0100
Message-ID: <20241031175214.214455-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241031085233.425388-2-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5886b44fcf7..f08e9b8f1bc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1318,7 +1318,9 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .needs_ecx = true, .ecx = 0,
             .reg = R_EAX,
         },
-        .tcg_features = ~0U,
+        .tcg_features = XSTATE_FP_MASK | XSTATE_SSE_MASK |
+            XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
+            XSTATE_PKRU_MASK,
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
@@ -1331,7 +1333,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .needs_ecx = true, .ecx = 0,
             .reg = R_EDX,
         },
-        .tcg_features = ~0U,
+        .tcg_features = 0U,
     },
     /*Below are MSR exposed features*/
     [FEAT_ARCH_CAPABILITIES] = {
-- 
2.47.0


