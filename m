Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB5EC25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lN8-0000T5-1F; Wed, 08 May 2024 13:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMV-0000NQ-Nn
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:59 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMS-0007N8-Nz
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:51 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a59ad344f7dso2378466b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190346; x=1715795146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9pAi+aT7uG1PQ0D1DDKsbWx9K3/GOCCjH1yeKFgaO1M=;
 b=RD8Q0OKiOwNtpmnG3lwoMpAtV3yOO4EEfXZPiaVN9+mzKumdrgPzP+ukWkf1qSnpfP
 LRzMTpO8oQbBjP4+6Tf/Q9nZmB7iY0j+vFcsz2vX1qIiJF9F+kjSEvm1Yp2m3UjsiKFq
 eOJg4VK0TWrjEqeVByq+8mr9F2mnSY5fFPXcYLKOm/AVhHVl/1NBQ+8dEvwlgJ0sg02H
 jfap8aMTPcFFX7uzcS0WQxphclb1LzVECsaSIKjsGDyuoEUTZGS3KQdqLz4eiPPac8DA
 c77Dz65MGDlY1C6dem8ll2TZxrrTU3grt/sv87otXrKjcflKshtMVdoKpx+Dppr+lJtz
 VYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190346; x=1715795146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9pAi+aT7uG1PQ0D1DDKsbWx9K3/GOCCjH1yeKFgaO1M=;
 b=HItP761zPKvgRoGBiDViaRJCsrKUd8bSJtktq18XuM5GZK9/1sbkhNr0MwP1P1o5R1
 nigiyxnCY/9qarvavPo/y7gevb9CWV3cVP+tY7j8nTySax6jxMYa4RUiP3dalQqJyXZx
 xS++ZVmgtnk4VNeBfo31E1jX0yKci3OKJddJqle1EDMbOno/Py3BV5uBZ86zlt1mOh0e
 A9bTLU6Aa1y1zfak6keeHTTyzcq+iKxqmGWm5l7iKUC9CvWzla5uvEe/Q43iKEdNCq5C
 BQeaDboAw2QK+2DIWaRMucsWiCL3/pvxemm7BskXAUnSv1sIjhDVoNxTA1IfJKQBxHV/
 DF6g==
X-Gm-Message-State: AOJu0YwyYakXuPACHRI21pPMlYGyjw0t6U7nJgAuN1LPYfOiRDgl2XZu
 ZYjNVAH03aQaJImjWk6ug7VX2H60P5r05CyLwB9y9x7g5DlIgeKFKSSdVoFDbjg2H+YbUOEgJtL
 H
X-Google-Smtp-Source: AGHT+IHoHdefWcSQX/hK3X99KMRKvnXfMoMkUdvvKxRTA+hTyLcmi5ZDsWMFsuL1MTai6auwQd8nrg==
X-Received: by 2002:a50:cdc9:0:b0:572:7280:89d6 with SMTP id
 4fb4d7f45d1cf-5731d9a7cdamr2228272a12.7.1715190346399; 
 Wed, 08 May 2024 10:45:46 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 n10-20020a056402434a00b00572df643637sm5956680edc.62.2024.05.08.10.45.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:45:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 06/26] system/physmem: Replace qemu_mutex_lock() calls with
 QEMU_LOCK_GUARD
Date: Wed,  8 May 2024 19:44:50 +0200
Message-ID: <20240508174510.60470-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Simplify cpu_[un]register_map_client() and cpu_notify_map_clients()
by replacing the pair of qemu_mutex_lock/qemu_mutex_unlock calls by
the WITH_QEMU_LOCK_GUARD() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mattias Nissler <mnissler@rivosinc.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20240507123025.93391-2-philmd@linaro.org>
---
 system/physmem.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index d3a3d8a45c..26f42f4a6f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -25,6 +25,7 @@
 #include "qemu/cacheflush.h"
 #include "qemu/hbitmap.h"
 #include "qemu/madvise.h"
+#include "qemu/lockable.h"
 
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
@@ -3086,7 +3087,7 @@ void cpu_register_map_client(QEMUBH *bh)
 {
     MapClient *client = g_malloc(sizeof(*client));
 
-    qemu_mutex_lock(&map_client_list_lock);
+    QEMU_LOCK_GUARD(&map_client_list_lock);
     client->bh = bh;
     QLIST_INSERT_HEAD(&map_client_list, client, link);
     /* Write map_client_list before reading in_use.  */
@@ -3094,7 +3095,6 @@ void cpu_register_map_client(QEMUBH *bh)
     if (!qatomic_read(&bounce.in_use)) {
         cpu_notify_map_clients_locked();
     }
-    qemu_mutex_unlock(&map_client_list_lock);
 }
 
 void cpu_exec_init_all(void)
@@ -3117,21 +3117,19 @@ void cpu_unregister_map_client(QEMUBH *bh)
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
2.41.0


