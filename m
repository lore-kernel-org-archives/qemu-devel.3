Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E0ECD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 06:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slMo9-0004lV-Gz; Tue, 03 Sep 2024 02:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1slMo7-0004gG-At
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:14:27 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1slMo5-0002ER-Ca
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:14:26 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7cd9e4f550dso1330840a12.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 23:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725344064; x=1725948864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ocor0J69gEkcnw3K93XNkT/Ls3GmiKCW3UrbQY2G9R0=;
 b=bvS8jn1nA+gB+M/2FITlCLBJ+2tNLa+z3j0AtbMGvhbpbw6plkVxhKumURG8od+BPW
 nd4WNv5jOe+7z7xS+UkMW4CZPSFNUS+aXJdn8STTkyHiwP9agVOFQJ8clihwOPaqTeQt
 FTEOuBzsrPGzh13HghbrLaZ8BJ3IB7av0aZ9ienVTj8gO1MXiZjcEekoZ7EfhDBXtsvZ
 /aSOE8xs84Yk9xlawsiX/Q5plcNyfFnwTdVXkuJOZ7ZLlDblr/qiJhz8tj6d7E+/tplj
 i/z6pZGdUaEa9aUNLkXnL0Gi4uwmoGqYKDSbLEEC5lYNohRE6qXmLwGYVI74i9y/u3eR
 RvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725344064; x=1725948864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ocor0J69gEkcnw3K93XNkT/Ls3GmiKCW3UrbQY2G9R0=;
 b=OnZ3qTrXHwsH5paVY4YaUI5Kkp/oWxJviGHXhqop20bAq1a56B4RtCjPag+imzM51Q
 swUZ70gkyIIkF1vVDTEnrH+YztqsgbwSc8MX2irCWYYhQiniIsvSGWDIms91v0zNUQyt
 Ed5dVK3g8Bl2NQvfO0XclXBqwzQobl/MBvRYsmN9hmzQDFLUnH7s4/++RxDHy3Oo47tn
 AG0p9VE7x12KSeYC3RSydufUEwLhoywJS8HtQsnciXKNr0sYRkg6Ua3OaD/VaOzjoiv5
 o80Tuq8YeMYGfoyilHpRcIz8jSYrCuPZKWNMPnkXC+b4xxDvbehkwn8FEKRSHvs0QPdv
 E4cg==
X-Gm-Message-State: AOJu0Yz9yVAKv/udXdk7hZcT5MXthYR2p72ACFEbNxOz4Tm/XzeN3eFC
 MlvP3fV6hKj+mQxxtSHFMVVlysE2iz/v9r7n6iW79zCvSkeFaUgkpRkSHjt0t6f86LoOTQ969Jn
 /IQzDp9Dqz6lp3+jZgeCoQp3fMb+oYsJkxXuLjM/CS4J1n54JENHCy99E/ey5vCku+8zuFBKcjE
 WSNxD7Kz9nNSTpAtfRLbyJafZHFXbbp9fcBy0=
X-Google-Smtp-Source: AGHT+IGlW3H0k9zO3KUAuUhCu3brrjl8Zmq8jrT/neqsuWTj7tdazdx9Nl4f8aM6bKD/6QA3jg6+Hg==
X-Received: by 2002:a05:6a21:60c4:b0:1c3:ba3d:3ec3 with SMTP id
 adf61e73a8af0-1cce109796cmr14688854637.36.1725344063316; 
 Mon, 02 Sep 2024 23:14:23 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20524c16145sm60467145ad.98.2024.09.02.23.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 23:14:22 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 1/5] target/riscv: Add svukte extension capability variable
Date: Tue,  3 Sep 2024 14:17:53 +0800
Message-Id: <20240903061757.1114957-2-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903061757.1114957-1-fea.wang@sifive.com>
References: <20240903061757.1114957-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x536.google.com
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

Refer to the draft of svukte extension from:
https://github.com/riscv/riscv-isa-manual/pull/1564

Svukte provides a means to make user-mode accesses to supervisor memory
raise page faults in constant time, mitigating attacks that attempt to
discover the supervisor software's address-space layout.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 96fe26d4ea..636b12e1c2 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -81,6 +81,7 @@ struct RISCVCPUConfig {
     bool ext_svinval;
     bool ext_svnapot;
     bool ext_svpbmt;
+    bool ext_svukte;
     bool ext_zdinx;
     bool ext_zaamo;
     bool ext_zacas;
-- 
2.34.1


