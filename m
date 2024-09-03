Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D05CD37AA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZxK-0004Gi-DI; Tue, 03 Sep 2024 16:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slZxI-000480-1z
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:16:48 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slZxF-0004P2-Oj
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:16:47 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20551eeba95so23428975ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1725394604; x=1725999404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmgSaVL8dhq5nP6b5OzdsZKAt0sQ4+L9Gnx6E+G/OOg=;
 b=eeHlHTthbQ57VvVpdiARffVNrW26mkKLwIu4ZJsYysiVoXvvj3Ddb3C69LkHSoatU4
 M2ATA+fi20HnatDXvdZVSHRKdOWcQ97kilDQMKjfCOOLofSoTkhhoru/tmaJQ/KKR7Fj
 1CY3VnFjpWUekMtB0xK01HdjWZrBZqDbSLX53BMKZol3brj/x4BhznDTpWqdlvjlLBEp
 GydwR99PtTwiEniFi85sp47gL/R29GGNwoT6Y5RSt8uQVj8YcQ2X8wCDJt3kYBHM8IdQ
 V7SMIQe0qulx8tTY+z0OH937KEKTujxab4SAWgZgbZ4l8QFIp/uGNh9AYTxHZToKuBbA
 AkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725394604; x=1725999404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmgSaVL8dhq5nP6b5OzdsZKAt0sQ4+L9Gnx6E+G/OOg=;
 b=kkwvwf17fQjav2t5YjFU3OwHUjvkZSm33F0ZYrjhOWH8ouYQt8ZfX2sOibCZZV9HyK
 mBvJ39wPNeUA/9q07o9rO2cdT5zrNRpPPlDwa90cIIb6eEEeW3hm5vfyNoy1vN5PnsKJ
 ykQyYjHl9US2aicMeqftcytyAjzBmupJhqfS1AQ0R0HkYab90DBKYM0UWZm/sbAO8L1y
 9A+92k63IGXS0KbhOA03I450X9knRc+ag8IroCROzqlY2lH/kCGIjTlMscyadpIgGOYE
 /5uZ96TtnwBDMtTHt7peKLlMuy3sflN2WCjFji6oeelokLiH1s7cR9y1wRs4FBHGHyxv
 RzOA==
X-Gm-Message-State: AOJu0Yy1o9QiIiB9VYYNkwS7zMT8VEgtuL17th0Zm/Z2tx+Ob7XjgFCB
 GZh3yxm7DCW1PSq+t/b7QZbBqGzOs5mmFuL8WU00lD4nT5pT4eK7ykUKJTyUSXDsBSVsE6FYq4a
 c
X-Google-Smtp-Source: AGHT+IGBMtSKH4L/TYTxOSRldmppXXru6UH6XYsqPaVcdDl9/6kE0Vc+tzmA1UlsVS/jvVgOeif+yA==
X-Received: by 2002:a17:902:d2c9:b0:1fb:6d12:2c1c with SMTP id
 d9443c01a7336-2054bcbbec8mr130431685ad.19.1725394604103; 
 Tue, 03 Sep 2024 13:16:44 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.170.227.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea531b3sm2189745ad.216.2024.09.03.13.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 13:16:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Frank Chang <frank.chang@sifive.com>, Jason Chien <jason.chien@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 01/12] exec/memtxattr: add process identifier to the
 transaction attributes
Date: Tue,  3 Sep 2024 17:16:20 -0300
Message-ID: <20240903201633.93182-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903201633.93182-1-dbarboza@ventanamicro.com>
References: <20240903201633.93182-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Extend memory transaction attributes with process identifier to allow
per-request address translation logic to use requester_id / process_id
to identify memory mapping (e.g. enabling IOMMU w/ PASID translations).

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 include/exec/memattrs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 14cdd8d582..e27c18f3dc 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -52,6 +52,11 @@ typedef struct MemTxAttrs {
     unsigned int memory:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+
+    /*
+     * PID (PCI PASID) support: Limited to 8 bits process identifier.
+     */
+    unsigned int pid:8;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.45.2


