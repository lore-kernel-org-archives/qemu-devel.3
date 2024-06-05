Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCE6C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEl1j-0007GW-Fn; Wed, 05 Jun 2024 03:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sEl1h-0007FN-P2
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sEl1g-0004a1-BR
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717572339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=suuFTwrFjHJhcoeTNEoS5N1Dv16DjnF0P5AMW2D9V90=;
 b=RfmD4C9p0FXSUstT8kwTpY+Cyunpr0d7QKsXX5PtzA5JLYjLr/9ggZ6Y+BQ8AfrPt74G2z
 iVRl552Az1yxrZ6YBXwlkDAusj0tacZ0MmoAGuWIwtvID2AFirTjnvCHyOw0d62rC8gQKH
 8/Jritr2QE7d6v7MieGzXeSzp9Xs+hY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-7_mzDBzVP5Gz9N8EoUHq5Q-1; Wed, 05 Jun 2024 03:25:38 -0400
X-MC-Unique: 7_mzDBzVP5Gz9N8EoUHq5Q-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1f63b8ab0b8so16867675ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717572336; x=1718177136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suuFTwrFjHJhcoeTNEoS5N1Dv16DjnF0P5AMW2D9V90=;
 b=WeoEZapKFa0H1TCwCoeCUqOljYuGPIg1/VouXVlK4yaC0XpjRR7k5eG9iZ7hKguV2k
 ZJ2Kyi1JbMcxOPDI78nOTeW/e7G0fMPMO9auCH4P9RBot6O/8NEUKQPVK2nCcP/Jz09x
 djnz5V3cd+UeQhG5oWvLyCCvU+v6tWMixcTtyTR6SZ0H46BHs0aAOZv1hTYIymETuojB
 NS8rQ2IPDBBKITdwqbNpbuZefBi8lLs60d9wTxvPSOzJTRrfQeI+kmHHZKD+9qpRZI8Q
 p8fPBduEF7y2jNSayoorLjnuKAFrmIM8bPkKxGOVfgn3UZXyw2E6m0PMFAYUY/glfglm
 FaeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo4KFJeqdBlGm6EzhXYMTahnAP6PHz/+cbgl2odXr2iVuk5k0jQ54f/zwr7MnzE9gjVCys2t6h7AksNJwrGJv1ndUjRKg=
X-Gm-Message-State: AOJu0YxQZz1zznQFhd6ufktYZ7fnWx7u3SmkL/NH1K0SEegqf89FqFrN
 kN2MweK1Moqa0XYMPErh8q/iuBsaspvTEVaY/iMs2ZErcG/bhbNNniDS6y/4MxgpAgy6fs1RUI6
 iEeHQgEOaZLSF/5gblwgn7KVAnK7PL7wPaniHkZWFqZw4qkeBGjXyaVZqxHg3
X-Received: by 2002:a17:902:e847:b0:1f6:77e3:774a with SMTP id
 d9443c01a7336-1f6a5a6aee4mr21912565ad.52.1717572336102; 
 Wed, 05 Jun 2024 00:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZuAWoehzvOGN0612mi6DwBU0RCtaBt8ymPEA/pAtA63V0DYhEy1xVztWV1PQe27B/RaaRgA==
X-Received: by 2002:a17:902:e847:b0:1f6:77e3:774a with SMTP id
 d9443c01a7336-1f6a5a6aee4mr21912425ad.52.1717572335662; 
 Wed, 05 Jun 2024 00:25:35 -0700 (PDT)
Received: from localhost.localdomain ([203.163.232.78])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1f6703f7673sm56329335ad.210.2024.06.05.00.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 00:25:35 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] qtest/x86/numa-test: do not use the obsolete 'pentium'
 cpu
Date: Wed,  5 Jun 2024 12:55:09 +0530
Message-ID: <20240605072512.67692-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240605072512.67692-1-anisinha@redhat.com>
References: <20240605072512.67692-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

'pentium' cpu is old and obsolete and should be avoided for running tests if
its not strictly needed. Use 'max' cpu instead for generic non-cpu specific
numa test.

CC: thuth@redhat.com
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/numa-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

changelog:
review tag added. No other changes.

diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 7aa262dbb9..f01f19592d 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -125,7 +125,8 @@ static void pc_numa_cpu(const void *data)
     QTestState *qts;
     g_autofree char *cli = NULL;
 
-    cli = make_cli(data, "-cpu pentium -machine smp.cpus=8,smp.sockets=2,smp.cores=2,smp.threads=2 "
+    cli = make_cli(data,
+        "-cpu max -machine smp.cpus=8,smp.sockets=2,smp.cores=2,smp.threads=2 "
         "-numa node,nodeid=0,memdev=ram -numa node,nodeid=1 "
         "-numa cpu,node-id=1,socket-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=0 "
-- 
2.42.0


