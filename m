Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249F3C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 22:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEzMk-0002Po-Hx; Wed, 05 Jun 2024 18:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEzMi-0002PR-DI
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 18:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEzMe-00041G-P1
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 18:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717627455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bL9y6zpapumIvS5R8Z26XHh7cawngiLb8cpEUYqF+cA=;
 b=HsnmiM2WTerP1Ap6RYkYSQMk569Hpq8zV7RyQI5jBP36fERE5eVq2WSP1G7QkADZVa5Bro
 a0WP4VCNnbcfx71oL4IBJ4K0USFpi9cK4u5adExHekCzj9lpdGrCeNrhT5IkXs2hGiCtId
 QF85RlQYnSmrxTsDJYwyrAGVwG8op0I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-82w46QM3MoaHq47_Anc3ug-1; Wed, 05 Jun 2024 18:44:14 -0400
X-MC-Unique: 82w46QM3MoaHq47_Anc3ug-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57a2fb28a23so152943a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 15:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717627452; x=1718232252;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bL9y6zpapumIvS5R8Z26XHh7cawngiLb8cpEUYqF+cA=;
 b=DZcm5+TKDoxtnhgf/M1SaCLXE11pikOYeLCdHRB/vPF8mZcXTrlp/ikI4cBgoQjltO
 tkkMSpObtKLovRH3oLh24+blSoycxHTMov/CWqvugOWYa/tGSVQ0OcYdVBe2X75NloFK
 oO0LKdoSlwK1nab0C8syU0Afj1oMBGzCVwC80QtUAgJhf8PzzSDQZporoUsbyJg+Otaw
 0UDSRn8QiG/zUC44dhpb1GoWCeUuGFmHA2QRO0H1gnuD/GhbT18e2Wcr4sUrZz4a+3ok
 1F7dJ9g+f+vX0aBjotmVrZ/7a4s2roeEo3ZB6KqOdzuQkzG/y3Eqfu7YuAO+OfB7dYOW
 sMtQ==
X-Gm-Message-State: AOJu0YzAc/wcDd3NoB3Rjl8fkaDu8t6xpFPIpXI2kYcSwUYgrkvnTUYp
 0hL7fTiPP6iR42RPK9VY5AAWjtWDi3dwWfms7TiF4lqYhOINyv8mWxIa0cL1DYq90X3kX4QZ42A
 Y+cq/sChN0fsFKGdBLoxPzmBpMQ/KZkQ4I637dqemLNkQVjayA405Nd5ofMu7vIFJIbqB7/67kx
 sNo9vlXwDca1q8kllebC+woTILRv4QeSbsm+b3
X-Received: by 2002:a17:907:7783:b0:a69:2553:5806 with SMTP id
 a640c23a62f3a-a699fe00f4cmr247400966b.52.1717627452457; 
 Wed, 05 Jun 2024 15:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfpqX7SRxzPfxnSpVZdzWb8J25rKFgjf7fZ2DQYeLweA/h6HvAMxhSjN7lsUyUL+S5sQ4zqA==
X-Received: by 2002:a17:907:7783:b0:a69:2553:5806 with SMTP id
 a640c23a62f3a-a699fe00f4cmr247399866b.52.1717627451962; 
 Wed, 05 Jun 2024 15:44:11 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8070e2fcsm1532066b.154.2024.06.05.15.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 15:44:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: pankaj.gupta@amd.com
Subject: [PATCH] target/i386: SEV: do not assume machine->cgs is SEV
Date: Thu,  6 Jun 2024 00:44:09 +0200
Message-ID: <20240605224409.2103109-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There can be other confidential computing classes that are not derived
from sev-common.  Avoid aborting when encountering them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 004c667ac14..97e15f8b7a9 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1710,7 +1710,9 @@ void sev_es_set_reset_vector(CPUState *cpu)
 {
     X86CPU *x86;
     CPUX86State *env;
-    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
+    SevCommonState *sev_common = SEV_COMMON(
+        object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON));
 
     /* Only update if we have valid reset information */
     if (!sev_common || !sev_common->reset_data_valid) {
-- 
2.45.1


