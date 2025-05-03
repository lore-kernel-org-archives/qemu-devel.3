Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D49C369D9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 08:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mg-0008AC-2C; Sat, 03 May 2025 03:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7me-00089m-Ij
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mc-0006hn-GQ
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=naXb0LxpAG+QrW5oaLUaWLV/f+gZqRysHFdNv5h+KXw=;
 b=VwUErwuLvQfgBRAdb/4EC1xQFEagWjgM/aVLMgIBYXPCE+0e6cTsQ7J8jbwG6SErPM0j/Q
 d+lgg/GaN1TIquRlOoamzBWnsGetsPNiHF1v5XGiWj4fOxJ4518Wbr14FTKPB5rYcVCDYz
 LG5B96TbD9wHvonbgJrBp5/KXaC7MXc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-qJtjJ2aSOuK7oqpTIT8kMg-1; Sat, 03 May 2025 03:59:36 -0400
X-MC-Unique: qJtjJ2aSOuK7oqpTIT8kMg-1
X-Mimecast-MFC-AGG-ID: qJtjJ2aSOuK7oqpTIT8kMg_1746259175
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ceb011ea5so14463455e9.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259175; x=1746863975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=naXb0LxpAG+QrW5oaLUaWLV/f+gZqRysHFdNv5h+KXw=;
 b=wqOhVEYNBeC8lFcYIpCp+Fu+6EdAlLSD92Z/Jtg3mR6kvZ82wUYPhsGMPrnjJaoG2Q
 SVFRquH41OJnLJmU47BVMLMtsUNKbcKHhdOyDKwycZUUQ9IMq+AmdQUcTLqQc6gQAYxy
 WZtDmGYdlH3Zi2ceYYLJO5f0nmZQRxgA4rSCsB0u51ib5YB9jUYx1Q4UzBVXfgwR7n3o
 +C2Ogvc+fbbN1i8sjzmYSnEPoSt7rQVlKqa3uudH1/anEf3rJikOBbBIMGZHXrETRZ/7
 i6vsht7drebKqmS4Nlr8P3cMvWNSnog5WSjTr40qoNk/Oopj0e8oAcVzNrIHHOSprF/W
 +d8Q==
X-Gm-Message-State: AOJu0YxcPKRW7X8U/oSbn0V77A8EfGpCEhooIVvEyCP/HlaMwxARh6BV
 hOOsmLe9r/W8APLpjcy1mZ0skxh3veDJpEYmghQo1z54Czh1NqkhryhnSDNak01MxqPwZjBXXw4
 vhBS2ZKI1uw//dSbx8sTilOLxWsFMUPdxxpFWkvMRspZALpu/TzqL/WHdHEh+ECsGskAWpCssTZ
 ad8sxxTKrdzhLN7QK2Z91QX/lGMtvnIWiAv4ui
X-Gm-Gg: ASbGncvqfIoLMD/FSC9Jw7oGvD603V1Ba/SwuyaDBqUOezW6np6U+spWJyFFwYca0tr
 0mJ2BiLHcfeuJzx2OxcsGkiJd0wbK/245I0zI9aFq/TsbN5v7NzgsT55qmRgI2zCqRFu7pIBzZi
 xG80VwwfOsYgqnDzGRu/eU/tj7THTQGMkIkTmsMZs5yDLRQS67JlNV9ya6HHap+1/52SkBHR69Y
 r0Ar1D/8g3ZYJK7onaxam+nhD9n0ysEtjgIvYilveAzc9KZ9kGeZtdtbUqSGBCkFEc3ZHPiIsij
 IPCBmoR6ci7OWGw=
X-Received: by 2002:a05:600c:1914:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-441c48bca55mr1537185e9.11.1746259174710; 
 Sat, 03 May 2025 00:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbR2kaVLJ42WP86DVgovbE4HJVFUgylyAcliITiAWEUx0lyh0e8gsol0p48M+Fh9S/59ah8A==
X-Received: by 2002:a05:600c:1914:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-441c48bca55mr1537025e9.11.1746259174297; 
 Sat, 03 May 2025 00:59:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8992b4csm68633295e9.0.2025.05.03.00.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PULL 13/13] monitor: don't wake up qmp_dispatcher_co coroutine upon
 cleanup
Date: Sat,  3 May 2025 09:58:58 +0200
Message-ID: <20250503075858.277375-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Since the commit 3e6bed61 ("monitor: cleanup detection of qmp_dispatcher_co
shutting down"), coroutine pointer qmp_dispatcher_co is set to NULL upon
cleanup.  If a QMP command is sent after monitor_cleanup() (e.g. after
shutdown), this may lead to SEGFAULT on aio_co_wake(NULL).

As mentioned in the comment inside monitor_cleanup(), the intention is to
allow incoming requests while shutting down, but simply leave them
without any response.  Let's do exactly that, and if qmp_dispatcher_co
coroutine pointer has already been set to NULL, let's simply skip the
aio_co_wake() part.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Link: https://lore.kernel.org/r/20250502214729.928380-2-andrey.drobyshev@virtuozzo.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/qmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 2f46cf9e494..cb99a12d941 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -356,7 +356,8 @@ void qmp_dispatcher_co_wake(void)
     /* Write request before reading qmp_dispatcher_co_busy.  */
     smp_mb__before_rmw();
 
-    if (!qatomic_xchg(&qmp_dispatcher_co_busy, true)) {
+    if (!qatomic_xchg(&qmp_dispatcher_co_busy, true) &&
+            qatomic_read(&qmp_dispatcher_co)) {
         aio_co_wake(qmp_dispatcher_co);
     }
 }
-- 
2.49.0


