Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6106C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 15:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dLL-000819-IL; Thu, 16 May 2024 11:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7dLC-0007ob-2U
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:48:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7dL9-0002w0-3O
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:48:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41fd5dc04f0so53482835e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715874497; x=1716479297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGqHM91ncsaR+sn9MCsN16viCuvwwaOuHfEASUkbpMg=;
 b=YOYhZeJZlp7/2NmjggeMVtETiN2yE+rpwDz46kytZQOOMcbPOd9KrvyAuEQD0w3a1U
 dvor1sX7J0H9PJKvPA/HN0fjZYzEUTLTfYjFINqSS4hXYgrHiq98Nb8twDFi1vx3DFGP
 ug9P6BJKpccn0CjkNiY2oydsHtrs/g8Ed9k7UrOf8zT+Z4FINBTAXA8G8PP8w78pIy3W
 8pBXlB+3fRTZPaMQwKKVC0i0lSWIEFEaGD5Mqn9y9Ocv0t96bbdUvYEuLFeqwvtBPd9S
 Muk5xb8WOD674QRLF6W1pG7yO9zGVUF5D+El5ZeXE308A0JOxfj36a4Rnb8HHWk7Rhas
 BVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715874497; x=1716479297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZGqHM91ncsaR+sn9MCsN16viCuvwwaOuHfEASUkbpMg=;
 b=j/HK/WbgY25pOhqJUrEmtx5xaie5vqEGpAx+Kz7JV85lqQ1yw78BNzFx9r32N2vUe3
 ieAIijC9AiiHZ/X8KarF7M4WzpxsDsYK72PWhU69BZcMU8PFV1VLN1tHSrpYSGkRj5O9
 QsGmO+ZMEx2Wnd+1YMWKP44pQ1H6iZqK/ryx5/coGrYMIHWnCg2x4d2M7Z9S90yw4M1W
 u9zd/bgN8FUMRDQSdVNImBJ6sY1Rp8ggtJGCXqLsvWq1Ov4qI+rhCNfU8fjaUZ66w2i+
 /42b3PnCtLJyzzgMGBPtgSLVO3syZme+FOKoftdEyJwR3mFmPg/ZRKZd0QjQgJcNnyIZ
 fkUw==
X-Gm-Message-State: AOJu0YzgRAOndX99UIL632cOAlx9pQk8To2Zx2vHanPZcH4ozEXyeI9v
 qr3wmBDieotz4HcjhO6tCGm9sLKqk0bq1SWnjawdQiSeZqIswMuUgLjBAadajEk=
X-Google-Smtp-Source: AGHT+IFDnMojfO2xt6pVlbquVE8+8jvX7sNqlGUZLdx3w42IdkxyV+nQ1qb+sp/jB5iZoxOh1bsTGw==
X-Received: by 2002:a05:600c:4f0c:b0:420:1f0f:fe19 with SMTP id
 5b1f17b1804b1-4201f0fff56mr93205855e9.13.1715874496961; 
 Thu, 16 May 2024 08:48:16 -0700 (PDT)
Received: from gmail.com ([213.0.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42012d08bb9sm169509855e9.48.2024.05.16.08.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 08:48:16 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 5/8] softmmu: Replace check for RAMBlock offset 0 with
 xen_mr_is_memory
Date: Thu, 16 May 2024 17:48:01 +0200
Message-Id: <20240516154804.1114245-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
References: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

For xen, when checking for the first RAM (xen_memory), use
xen_mr_is_memory() rather than checking for a RAMBlock with
offset 0.

All Xen machines create xen_memory first so this has no
functional change for existing machines.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 5e6257ef65..b7847db1a2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2229,7 +2229,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * because we don't want to map the entire memory in QEMU.
          * In that case just map the requested area.
          */
-        if (block->offset == 0) {
+        if (xen_mr_is_memory(block->mr)) {
             return xen_map_cache(block->mr, block->offset + addr,
                                  len, lock, lock,
                                  is_write);
-- 
2.40.1


