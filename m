Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317F4C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Lu9-0005jd-LM; Tue, 07 May 2024 10:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4Lu7-0005ca-Hy
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:34:51 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4Lu5-00025N-N0
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:34:51 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso2448278a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715092488; x=1715697288;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8UQwJWo0cr2ZRaC4+6kRjAHtdNM0XskKMAiaHBTEPQ=;
 b=QoEjEsmjN7rpWd/sbNtl7UgF+fLVGYN/nN8XE2byNqc5u4OpwDuZSwFI0iZcN2fyUe
 Mr/qqZdmyCqE1F4EqSqaLw7W9mV+6U5CE79Vkgzg5GTitlmWfUJ5pbp5U1SDR6eqUpzY
 qJOQKMV3khOpu4Wbw1l9VJr/6QoPY5K4VZsQF2HDAe+PG+wWc7TP9lxV14XtwJiMsbFD
 K3HISguEtmNK0ocJPYNavcZPPBVu4Wj6PsgjgaF8zbGIB24uL+zqVqpw4sXsb2V9xraH
 zkXrUwJ0wBro0o+BFGqVAop6OYBCqtsJOgM0fW+2rZPIzeaGEXx/G6NFzp4VdeyqmPHC
 UcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092488; x=1715697288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8UQwJWo0cr2ZRaC4+6kRjAHtdNM0XskKMAiaHBTEPQ=;
 b=IEGPbQcChUc7g98n7efzu9Voo6oLqkDMW0Q/ysbB0astLKzsGrpAwoO2fjrIHXAF7S
 JqPllvsnuwO2hH4k5BhkvUJ8ij2MmQT1GtRKzlOy/4CMtB2/OHZ3YfQ004wAAkGCxoza
 xbT9FERzMwHBDByjEcWgfWgCcLsfAX8jri9cc8AnzMrmE4TDq46aqtKhP+eC3aNyj8t6
 DgW7q65edmzVMfi9Szf/o5o4Q/ZXYPOMhw2neMginCsSmib13P+Gma6qPsHlhUEgJWDV
 /4Zd0PAd59zRAJP9mVsrrTSjFyhuP4FqfSnO6kwIhjN2KFa2a+hGAMtEcki8625WYaik
 TDIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXDK7qNj03ehKFPN/nCe+0UzQtV93DJcWrlY6JgWMxjGKnuYqrbQo0BcuT/1t46qPjxTK2/aO6i27BQmKkGeIeCufLu+I=
X-Gm-Message-State: AOJu0YyszQmhhc1nr+hj5iXGExFNiQ32kqirYCL0fuNA0FUI78vCr+aC
 J1AEaxJU8tN9AboB4aVU0SkRbFWD4Dfd8GIC6KdEL/hF5YH+lZqndbDH2+44zfE=
X-Google-Smtp-Source: AGHT+IFBTyD6yAwtLJxwTETKda7qnBJZeLRZUN8zPZ2/2WnkHx+uAAfr3lvbB02xC4trri8CqeudzQ==
X-Received: by 2002:a05:6a20:e188:b0:1a7:7505:ac97 with SMTP id
 ks8-20020a056a20e18800b001a77505ac97mr15903702pzb.11.1715092488112; 
 Tue, 07 May 2024 07:34:48 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 pq10-20020a17090b3d8a00b002af8056917csm11827206pjb.29.2024.05.07.07.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:34:47 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: jag.raman@oracle.com, peterx@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v10 1/7] system/physmem: Replace qemu_mutex_lock() calls with
 QEMU_LOCK_GUARD
Date: Tue,  7 May 2024 07:34:25 -0700
Message-ID: <20240507143431.464382-2-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507143431.464382-1-mnissler@rivosinc.com>
References: <20240507143431.464382-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=mnissler@rivosinc.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Simplify cpu_[un]register_map_client() and cpu_notify_map_clients()
by replacing the pair of qemu_mutex_lock/qemu_mutex_unlock calls by
the WITH_QEMU_LOCK_GUARD() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
Reviewed-by: Mattias Nissler <mnissler@rivosinc.com>
---
 system/physmem.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index d3a3d8a45c..5486014cf2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3086,7 +3086,7 @@ void cpu_register_map_client(QEMUBH *bh)
 {
     MapClient *client = g_malloc(sizeof(*client));
 
-    qemu_mutex_lock(&map_client_list_lock);
+    QEMU_LOCK_GUARD(&map_client_list_lock);
     client->bh = bh;
     QLIST_INSERT_HEAD(&map_client_list, client, link);
     /* Write map_client_list before reading in_use.  */
@@ -3094,7 +3094,6 @@ void cpu_register_map_client(QEMUBH *bh)
     if (!qatomic_read(&bounce.in_use)) {
         cpu_notify_map_clients_locked();
     }
-    qemu_mutex_unlock(&map_client_list_lock);
 }
 
 void cpu_exec_init_all(void)
@@ -3117,21 +3116,19 @@ void cpu_unregister_map_client(QEMUBH *bh)
 {
     MapClient *client;
 
-    qemu_mutex_lock(&map_client_list_lock);
+    QEMU_LOCK_GUARD(&map_client_list_lock);
     QLIST_FOREACH(client, &map_client_list, link) {
         if (client->bh == bh) {
             cpu_unregister_map_client_do(client);
             break;
         }
     }
-    qemu_mutex_unlock(&map_client_list_lock);
 }
 
 static void cpu_notify_map_clients(void)
 {
-    qemu_mutex_lock(&map_client_list_lock);
+    QEMU_LOCK_GUARD(&map_client_list_lock);
     cpu_notify_map_clients_locked();
-    qemu_mutex_unlock(&map_client_list_lock);
 }
 
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
-- 
2.43.2


