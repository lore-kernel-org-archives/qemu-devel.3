Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37618CF9C73
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDru-0005Fu-Bv; Tue, 24 Sep 2024 18:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrr-0005DY-3t
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:48 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrp-0001fZ-Kf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-718f4fd89e5so5122024b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216322; x=1727821122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhYz7dkNA7U6Hw9OuujVyqU2ppo5YtJiB+wYW6uzsrY=;
 b=KO9RbWC0vZEtIDrkumOWhYq5ngfWIfth3B7zgdEnmRiwWek51YiV1FyeXdmb70SIBH
 s+5b8KyS477MJRhjJxj2T6bg79zCMcKe4F6tHwPyRBlgvDmEVdqhMaI6jjSvuj3O1xKA
 E/Lr9yKa+XuQMcymdSwC/DglTWfMDjlkCpdkxkwL/QqPS+iMMsr8PP83zuFJ03xcPCdQ
 40MB0KbYXAsxV3/EnJDH1VAQZFbNYIT6ec/d/8a6AFxGaSuUEGOrj64V8DsYH7DrfOIR
 8w9pugNhdvJvKz83FwJd/nBfgEs3lqhL4E0s5IXoNQmTeo4BGK0DqcKVnkFHOekd0xYU
 8W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216322; x=1727821122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PhYz7dkNA7U6Hw9OuujVyqU2ppo5YtJiB+wYW6uzsrY=;
 b=mrOvd9KfKQqQNhWEEOW8PwYk9QdDsDlokv6ZXQesm8LppXrvm2DI2FZi5KmAv+S4fU
 LfH0FGHdIR7vQnNmuCpYTP/sGjnI0HNnXrfMwtKJpEVe8PqFMkZMGktB3dpPh1HjjedH
 XhBIBwuRKLFp43KATNcZycTF2NWs/KoS7pFiHGEC+cIzcbTEQB2wDULURoWAs6e9Q/Tt
 OnYo8697/HH+MM3NpZs6nRkt84ObF79AuNISEoNNAB7tdgIx7x5oqGlWPknICQ3+okVP
 A/g9Q1psTbrHm7+l9HR5WWhdU23e66xFjjQ2L1YfH2xsR8C/Q5w3J2Noq8KRdQBYa1Ab
 Xfog==
X-Gm-Message-State: AOJu0Yw291za/m4zNzKB3P9LOmVG5+MiQhiBoweHJMamhhxHPXxN+rsQ
 JpYmZcePj2GOpS8l3vzcPzA9/dUFbONCIXfTtsxaicq4NOiFWjW+G1l9YA==
X-Google-Smtp-Source: AGHT+IH0wRhrknwaBOJfLbjpzfPIy0lNUEwlT6/7sOKP1ESbfW07Snwx0WZ0k3qVng1bw/jjFB6dZQ==
X-Received: by 2002:a05:6a21:118a:b0:1cf:6953:2872 with SMTP id
 adf61e73a8af0-1d4e0befdaamr732823637.48.1727216322643; 
 Tue, 24 Sep 2024 15:18:42 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Frank Chang <frank.chang@sifive.com>, Jason Chien <jason.chien@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 14/47] exec/memtxattr: add process identifier to the
 transaction attributes
Date: Wed, 25 Sep 2024 08:17:15 +1000
Message-ID: <20240924221751.2688389-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Extend memory transaction attributes with process identifier to allow
per-request address translation logic to use requester_id / process_id
to identify memory mapping (e.g. enabling IOMMU w/ PASID translations).

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240903201633.93182-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.1


