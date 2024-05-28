Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D562C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmpV-0003z1-9M; Mon, 27 May 2024 22:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpT-0003xz-TX; Mon, 27 May 2024 22:44:47 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpS-0003mb-Aw; Mon, 27 May 2024 22:44:47 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f47eb21f0aso3307145ad.1; 
 Mon, 27 May 2024 19:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864284; x=1717469084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qcQTiAdEv5FwQ27d9xmN3ZTsEtqw8BucwxaZ316zkY=;
 b=MBVLrormYa0ek79S6tjCV0Xc5qG0JDzPi+Ubyz0HH7IShpbTBuYg7UqgIob80wxHn0
 r3Jst+F+52b/8vXUwvyT/BB7g30VVs+SItWjBvB7CqhdOejpjKdsrEsVblG88GbyG0MB
 UD3egAyWMFdds+7/18L7bAm6DuRe5CshpxDjna3NsO/df+/lYRkQVSuBq9F+79doYpbF
 4Rb6cULMwFgeGb0fezN3/1Ez6qRX6p/RYrfIkdWyMurUjOSBkO0tq6QqqtMxfZ97ZI7z
 Z5xskhttmpSNLMIViHShEYlB7wxysDerThFuMbS3zIDP7jmcWaZYO+85m9OVgQTjYmmv
 LoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864284; x=1717469084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qcQTiAdEv5FwQ27d9xmN3ZTsEtqw8BucwxaZ316zkY=;
 b=vkGU0vOJ19NHsbN+sG5FIrnGzjc5q6LKuTUT/gqj9a5PwmeUBzh1T1WFs+97sZ3HnN
 X+irfkszF7RZ1EircmaifqfW/RLRYOIr66kQSBTZzG+5/rGrmY00/BR8b2P2QTv39tyJ
 q1woz5q6thl7tfqB5IrLBW8TfxTGPJ4txJslRz6++yiLY/Gg554841qXlxqWwHvyHltr
 kNRzsKjz0e40KxzoRs2h/bS2tCRE8zrc7rGGmDkAxq3IuU4VAgOo/ZH732p+Ws9qlqHh
 1c19DoiUP2BzHa++q4HRkg4I/l3m1HVmv1ivll5zvCnVmNjsOdIS9mPJFxwuAzrqsd/O
 4NVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZeJ8Cahco15vLbHoj6q8TFV0/t9lpqOxrIE3m1bhMbREgATJxfohM3hijFnhDb4SWBpMUfTCKn9uvI/+7tJXWKH9KMjs8
X-Gm-Message-State: AOJu0Yx+tAUU16lGrcjOSTurPhI3oCZjf9bU4Rl8Jc9LzbY4WZfiED47
 /korWAZa1jAGEHuIGl8EmxBwz4mgldL9y0ZFzYteIbXyEDz1PGLu0nH/Pg==
X-Google-Smtp-Source: AGHT+IHFm1fuCWvdFoVEXXUeUTPN+kYWVDPfGNemupT8X29OlfDuNjEAwSQKeU/mNU+Cz9C+wXHUCg==
X-Received: by 2002:a17:902:e88e:b0:1f3:39f8:7e7f with SMTP id
 d9443c01a7336-1f4486d1f78mr111465725ad.14.1716864284443; 
 Mon, 27 May 2024 19:44:44 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:43 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yangyu Chen <cyy@cyyself.name>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Chou <max.chou@sifive.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL 14/28] target/riscv/cpu.c: fix Zvkb extension config
Date: Tue, 28 May 2024 12:43:14 +1000
Message-ID: <20240528024328.246965-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Yangyu Chen <cyy@cyyself.name>

This code has a typo that writes zvkb to zvkg, causing users can't
enable zvkb through the config. This patch gets this fixed.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Fixes: ea61ef7097d0 ("target/riscv: Move vector crypto extensions to riscv_cpu_extensions")
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by:  Weiwei Li <liwei1518@gmail.com>
Message-ID: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a74f0eb29c..0d6fb9b4ba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1539,7 +1539,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Vector cryptography extensions */
     MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
     MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
-    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkg, false),
+    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
     MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
     MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
     MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
-- 
2.45.1


