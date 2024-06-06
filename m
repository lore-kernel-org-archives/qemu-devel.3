Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C00DC41513
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 04:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF4zS-0008Bq-EH; Thu, 06 Jun 2024 00:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sF4zR-0008BW-7Y
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sF4zP-0008Iz-PQ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717649078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOOlv7L2avyyL4xO82xIG7tzsc7nx9TcVszICCX3FgE=;
 b=K3Yl523lZ4i7+SByJz3I5aNEFUj8weHE9g6Ow3eVoeg3bu/qLeG+CEdqytjchhUE/6mIda
 BIFG5wMoO0UQDLZ+lKxHKk2weLarhh0Ze6RezZAhx6nFfkBLJWuwyfdPBYe1w/3OwDha0N
 TJzGpIEWf2XRMjhy5O3Bud5DW5GRQ3c=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-W4345nmYNx-UN7kzpjH2zw-1; Thu, 06 Jun 2024 00:44:37 -0400
X-MC-Unique: W4345nmYNx-UN7kzpjH2zw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1f68862abbaso5769035ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 21:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717649076; x=1718253876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOOlv7L2avyyL4xO82xIG7tzsc7nx9TcVszICCX3FgE=;
 b=H8ileE8InRsV5XtJHZKr6EaTwNE+RnM9ao/jbB38dX5KbOMcCxWNFPZ5HiiQYCL9DL
 lgsJrxYFEcxgQQwftMZTO3ajRrnck0tgyVwWiQ8zzY9Sa8cqu0MQ6lxGLBdXShNxKc2o
 nKBzeFG7nEhom6hKmNuOQ87J78GD0kdyCTaL7XvU+uG02iEJIyjUDlpKvA5OxqdVG48+
 X1YHKmflXEK+u48q5dlNuiWcBL6MJGFB/jJQbYHZaiunmbKcMsg1EESW4UgNeFJdQChu
 TQs9TbOD/iTEOooMJqZ1kAq22nUIWF306M79iQmx7A9/MbMdnNNtJ06e2/owYiTU5y5t
 sPmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX84+SVEzpIEzP/UdpZ99pm1JaHaRMU8YrsK4t1U3p9BzoCIg8ifJhnqZlpJYM9Tg+dWCeNzuntBMwfjgw2fsxwSv8XOA4=
X-Gm-Message-State: AOJu0YyobFWvBgHMVUZRFIQV9dK/w2bj00HCFkQij8Of0hSeq4ko+hSe
 JbGdb6wW/WJkK3Vwz7yuzcj+glPhXdvqxkgSa/XeSGVQw5cOhUOEh7kCQT0e6Ig+mZ/4jooxPyB
 q8eaUr4tfESMGZL/tcRjWvFdRcPapdp+cVYmBu4eG/gx2hZO7igp+
X-Received: by 2002:a17:902:d48a:b0:1f6:a602:fb05 with SMTP id
 d9443c01a7336-1f6a6030d76mr51208965ad.45.1717649076251; 
 Wed, 05 Jun 2024 21:44:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOvrxSkhpVJR+TkTvEuYU9CA0VdQLX6LCYS1npecrX38Ge+JAigLdjZTjS0PqB9ELJ3DLCLQ==
X-Received: by 2002:a17:902:d48a:b0:1f6:a602:fb05 with SMTP id
 d9443c01a7336-1f6a6030d76mr51208815ad.45.1717649075840; 
 Wed, 05 Jun 2024 21:44:35 -0700 (PDT)
Received: from localhost.localdomain ([203.163.239.242])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1f6bd81b9e2sm4057165ad.295.2024.06.05.21.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 21:44:35 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] qtest/x86/numa-test: do not use the obsolete 'pentium'
 cpu
Date: Thu,  6 Jun 2024 10:14:17 +0530
Message-ID: <20240606044419.8806-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240606044419.8806-1-anisinha@redhat.com>
References: <20240606044419.8806-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/numa-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

changelog:
v2: added reviewed tag (thuth)
v3: added reviewed tag (imammeodo)

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


