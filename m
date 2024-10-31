Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74906E68949
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MHc-0003gu-PB; Wed, 30 Oct 2024 23:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHL-0002FK-5f
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:23 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHJ-0004ET-PL
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:22 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20ce65c8e13so6041675ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346920; x=1730951720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ed1DgwUYyhkwPW2XZOfchuohMKGJBL43fEPl2QoA32U=;
 b=ncVb/ob9PNC/XzdKSsnGIA4aGpZVx7BrYkf8uTKcPfPl0+hQYblAdmBjMTwxe1icKY
 YTr3a7esesJ/2BiDJkb1+PoyvRduLLOSJJa7qv1KQ+19ufWTooWFoJNx+9G8HIuZleD8
 vUHi0nO8BwbYx4UUgp8aTAwP7Pn3/63xCXY6ZVQy/Qlj6YNSzbQEOZbGJF3OIGhR/j4S
 bMA0tXEHzklipR2QA6xkgxFPYuj6iP3UYrmk73nRXMSB1SPa0x1hJC23UimD1yWjdC4I
 W2Xgjm2HXmk9P/BFjfgdWS5wsBAZHepiTR0+vwru6FDlMLv1XsGRt1BumzXdtI79PXRO
 LXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346920; x=1730951720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ed1DgwUYyhkwPW2XZOfchuohMKGJBL43fEPl2QoA32U=;
 b=UAYaBGunfF9RNcx7OMeWcD99yze9C+BuQCquaOZSdiSYGLkw5Jgz5Mo4AQWq5imUAP
 RqgZ2sp6c+Q+7I4H2HMZue6fPDvLjLPRioRcc4HpTJfjMzeWpxrKir+9gaOCGDD/qi3i
 9TrfXdcDyjG92TZQssMWl6ve4+sNI3e3JYxrAMhXvr0qWp2e6eJejZVKuDi0y+t70nlK
 FoJhn+351ugZurK+EpN4DE0ro2mbwBAr6pzv8XP3OpSZVXN5bwWTXvZQO6Z6H/JPyQPm
 aH51COaYxO3CnwWqYJOvNVeghZPXVocp1G43+snJlymWepc+abyPRA2Fl0Mep8BtDC2i
 DgUw==
X-Gm-Message-State: AOJu0Yy7U1qBmL9gAKhXMy0pFVbo5cnjVh7/ffYZGvjBLUwtKcJs1LUg
 RJde8ZX8vn6y6GhQfUAz/UnxpnQXilqHgyk/jGoB8oHi+fBBEdJKJcWu3WHu
X-Google-Smtp-Source: AGHT+IFMShzPm1QuxQz3T/p06WpH4cSTsmEmKIKT5BzMIUcUcTHeoLzIZh/TTxVqCb5gfs3jUhB1YQ==
X-Received: by 2002:a17:902:f543:b0:20c:5e86:9b53 with SMTP id
 d9443c01a7336-21103ab979emr22487565ad.3.1730346920257; 
 Wed, 30 Oct 2024 20:55:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:55:19 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Frank Chang <frank.chang@sifive.com>, Jason Chien <jason.chien@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 36/50] exec/memtxattr: add process identifier to the
 transaction attributes
Date: Thu, 31 Oct 2024 13:53:04 +1000
Message-ID: <20241031035319.731906-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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
Message-ID: <20241016204038.649340-2-dbarboza@ventanamicro.com>
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
2.47.0


