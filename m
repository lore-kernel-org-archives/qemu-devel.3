Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE2FC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxu-0000LT-F2; Thu, 27 Jun 2024 06:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxr-0008Rq-Oq
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:51 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxp-0002qx-Uj
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:51 -0400
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7f61549406eso12605339f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482568; x=1720087368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+j6fKPVNUKUnpKxQMAdtrznAy8Ydu67u7x9DuieKE0=;
 b=I8j3lzUZAi/FSmYd2acqpG6FgRmbVaqptERU3A0gGZRe1spJksiCPOYU5fWIMJZpv6
 OxxCjGy5SXl83GdKCxDr5wuhNfDe6hARPfROeW14jhv51sl+b4NeYWIpB3ZbPXry/vvw
 CrxrAn7Bx7DUFNWHtCuU2mCXsVTDAqQZxN4zwwUWIrLfSUSNY4PtFy0B9yKzOYKZvSb7
 h0PGiB3Y50Wqnbf9wcMsGAmij9cs2gn49H70nMSmAUMGd0q+atCHVlPFXl2WE8iM7K/W
 PUV/DA8tsHgqPB8z+y4pviLIql1GMKIyPTbILL2EwUK0XOlnKO1oxEvID16emu9Tr13v
 F73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482568; x=1720087368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+j6fKPVNUKUnpKxQMAdtrznAy8Ydu67u7x9DuieKE0=;
 b=WSh0VFnEqoec/5O+ZdjCFDlXJwTN3fGnPAiW1r/beS99HGDqNk0zZRADwk7OvlBj6n
 ssoGL8uCsdlarOxG/gASKl5hQPUVwJO2/qMLEnpc4UbabpcWaAFJ0H0QBoewE3Zb4ndD
 cBQRq9Kdtz4RTTVPVrroUQRDVeQuvSb3NZGl5QC8pPxEzC5I76ttL6v9xu4tFJR7ZtyE
 lPu8yt2gLV1EIpoATicX2ogHT1mkLCq5KwHferI0R8CZsxFmDf1KTJ74sHydRPFYiJlb
 I3LlIX2uCJh5ZLBtdZoM5+ZPZskyAnIhM4Knx1/DeJMe8a+YHqTmZtw3RIYreexjVU6l
 R5Sw==
X-Gm-Message-State: AOJu0YxHKqBuXXpzEuoaWZ4c0RUFH7s0pTfyQILAvlgDl8bP4uftTqjv
 Wc+5IO49hQ4KvIAPn2n3atWdlDmFJTIIErU8IoeJRPYT5fcNinZDmUX13X/r
X-Google-Smtp-Source: AGHT+IHNOnh4snA1JbyAl60XYCAUC6EPph/N571XudXc5WX1XegVfyIoxxTlpRi6NKvpqP+zREoRbQ==
X-Received: by 2002:a05:6602:6d15:b0:7eb:71b9:fc8 with SMTP id
 ca18e2360f4ac-7f3a755b3c3mr1514878739f.16.1719482568291; 
 Thu, 27 Jun 2024 03:02:48 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:47 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/32] target/riscv: Apply modularized matching conditions for
 icount trigger
Date: Thu, 27 Jun 2024 20:00:53 +1000
Message-ID: <20240627100053.150937-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alvin Chang <alvinga@andestech.com>

We have implemented trigger_common_match(), which checks if the enabled
privilege levels of the trigger match CPU's current privilege level. We
can invoke trigger_common_match() to check the privilege levels of the
type 3 triggers.

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240626132247.2761286-4-alvinga@andestech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index c290d6002e..0b5099ff9a 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -624,7 +624,7 @@ void helper_itrigger_match(CPURISCVState *env)
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
-        if (check_itrigger_priv(env, i)) {
+        if (!trigger_common_match(env, TRIGGER_TYPE_INST_CNT, i)) {
             continue;
         }
         count = itrigger_get_count(env, i);
-- 
2.45.2


