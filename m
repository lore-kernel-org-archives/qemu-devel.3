Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD6FC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 03:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Mkn-0001Of-EU; Sun, 12 May 2024 23:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkZ-0001MG-W3
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:23 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkY-0008M0-Ay
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:19 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so2637613b3a.0
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 20:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715572395; x=1716177195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HqjfLbdxMaAm2Kc6kgGY9B3YsreiqnlUzVf4xDnoFw=;
 b=GQwZumdB8NLl9aIU0/UHh/UgUnBfbgO6z6JqPWHWkX0uYkYK/4EYjparhBcYhb1AeY
 14hGya2cPHEeFLq0C36/ynPxFM4SJqWUd43YUouWNn2ThX2jteMI64jCAt3tK5IR727f
 G9jzDZn3sxyaUea1rfLBuoQjiM6z9i76X0CwfetB2Jj5mtHNEAcBF0w2rziyX/pdiI9I
 VSO7nnBcmqc+y/UWPN5Wn+cRa+k0ueQcSlCggVjtoWvX1hUrSS0udrqJfkrJHhVGEamK
 +OLbt6GY/yonki7z4MvVN68h87uFaaYWBhbbd2wEIa8TjSr74k7K5SyUBYD9UzNC8gAg
 i8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715572395; x=1716177195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HqjfLbdxMaAm2Kc6kgGY9B3YsreiqnlUzVf4xDnoFw=;
 b=tL9CpTTf09u5r7YMWKdHsogA6ba/k9JIyVTkk757GCnK20ey94e4u2gzjU8wPlOcSf
 NEYknHX8NgvLjI2uhoGLDgqPceTNpLOYnK3xVUDd06driXNGwmogxJpSEYRBCZ07JM/9
 ep+UgxLexrPY9/9+k36mIBjTsWGG3DPUoHOBt8uyAQn+Ppc9R/JXpWypYw34AtX3fkJ0
 2zbWfvh8fPH0//lqgtRSsZrAPj1erG20d89rshjQCBjxsAt9vSJ9RCXIY0zZNyj/ft44
 jl3PS9ZukKQhKWyL8k24y9OzPnX+peCgKVDkxZj1RVJa2t1CyeFcbAg+nrCFw2eGS35G
 G3Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOiaqS/lKYgu7BtpuUtWiEFSvJtFAyjKq+5YF0/3NsF/RtzQM70sqldP8n5d0kDwaPXQNLDnz2FXrjYTWrVYAFDhr/Zog=
X-Gm-Message-State: AOJu0YximUfdiUtOuVwAqpso+KMbKFNwT5kTmXjCda+YZyQC21+IazYY
 O+wcbLCnRENaJmZ4wFVniVmSCw+kzCVAEFhKiwpSCHu/V+qvsi8PdNSwf8Hq5rs=
X-Google-Smtp-Source: AGHT+IF+6QK2UMCytKPLngLJySnjzawj1JAR3X7rQAdzPrhyH33AyUpyaf4ms23gdoyW95hfqwtEvA==
X-Received: by 2002:a05:6a00:3d15:b0:6f3:eb71:af90 with SMTP id
 d2e1a72fcca58-6f4df3ba92amr14867225b3a.4.1715572395246; 
 Sun, 12 May 2024 20:53:15 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.40])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a8137asm6407947b3a.45.2024.05.12.20.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 20:53:14 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v2 09/11] hw/nvme: enable namespace rescap function
Date: Mon, 13 May 2024 11:52:28 +0800
Message-Id: <20240513035230.60162-10-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240513035230.60162-1-luchangqi.123@bytedance.com>
References: <20240513035230.60162-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x42a.google.com
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

This commit enables the rescap function in the
namespace by detecting the supported reservation
function in the backend driver.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/ns.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index ea8db175db..68a18636fb 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
+#include "block/block_int.h"
 
 #include "nvme.h"
 #include "trace.h"
@@ -55,6 +56,12 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     }
 
     id_ns->npda = id_ns->npdg = npdg - 1;
+
+    /* The persistent reservation capacities of block
+     * and nvme are currently defined the same.
+     * If there are subsequent changes, this part needs to be changed.
+     */
+    id_ns->rescap = blk_bs(ns->blkconf.blk)->file->bs->bl.pr_cap;
 }
 
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
-- 
2.20.1


