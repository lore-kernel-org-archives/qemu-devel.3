Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC95C52D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 23:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seNYA-00023A-ST; Wed, 14 Aug 2024 19:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY6-0001ki-8h
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:37:02 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY4-0006WR-Lt
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:37:02 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70f5ef740b7so319819b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 16:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723678619; x=1724283419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzoJvs+/ktmRvV/uludFrSeMjpPKw38xy+lGwp2LWAA=;
 b=CqIMZho1iQIzGr/SHFL9AtS4K0w0BAfgozvIyT26wP3J+eJxtF5m/jjt/1CPhiSrRm
 35XlCvnFZbumzBuKYuGA3yhf12ZpuC5lvrxdYI++XzXmPqytzGrt0jJDzRmg5eu+jy6c
 0TLXGD5YnTp4JI3qwobtYD4LQ/k13bQ5WU6UOqpC3d3tTSiSGoS0+QzKZEnsp41aei2v
 HlgHHW/A6cvcJ+59fOrdQLsu2KvXlHXiNjQQnn8McqPKGN2UkjHz8bXWVpWPuk1LwEV8
 okfrsylTxNa7u9CoH4I3fE0rVK9pNvAnEk79xpO0FXpFG/Cn+shmisCAxzedYBzuv23o
 d6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723678619; x=1724283419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bzoJvs+/ktmRvV/uludFrSeMjpPKw38xy+lGwp2LWAA=;
 b=L8H/DJ00/ipzbaUmNqyiaytLkFhm6zZcOTthgQhb9kHjKc42+EFZiWHzwBP31GLgZj
 MBqWNTC5D5eoS/RMFXW49g485VtzPXdV3gFT8eL5CtcSxfLGi2CmJCOzt0fh4CI8EmcK
 iUyhXjyF69+mKAB5wY3n2dxxEg4TxP8qDb9vRpv4JqJcqAaFlYxazhkUXmsnQNgN2kAI
 VIEc0NQ9btHFGWXt/JpN0efsaWsVGa0M3Z6SETZQVnyJJth8PFPV1OgrW/nJgLxC71k9
 m39Xb2UGHy+krRXKbj+ujlZMoNfVHG9T6Uz1GRXTedC9vFwUEo1WduoSxpfwcJxBil5A
 fZag==
X-Gm-Message-State: AOJu0Ywo4uJcrpnd44ZeNueVgJKMzRNevs3X+q3IpSa3yR9MoNZxBJwC
 8o2yLWe07xBGgMGuNxkapvBeBGXoX/+xiN/yY/OeKcyCTbXWNGg5R1EtV8IQ4DUMdtqZqwELE3K
 h1gs=
X-Google-Smtp-Source: AGHT+IEerxmprREtG28hemAszEAk+gOmixw605ol/n/naRl7+bng26g1gKIb3JJm1IVAqIZYrhQ9pg==
X-Received: by 2002:a05:6a00:1ad1:b0:706:29e6:2ed2 with SMTP id
 d2e1a72fcca58-712670fa392mr6336540b3a.5.1723678619237; 
 Wed, 14 Aug 2024 16:36:59 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef57dfsm112164b3a.115.2024.08.14.16.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 16:36:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] contrib/plugins/hotblocks: fix warning when compiling on
 32bits host
Date: Wed, 14 Aug 2024 16:36:43 -0700
Message-Id: <20240814233645.944327-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Found on debian stable (i386).

../contrib/plugins/hotblocks.c: In function 'vcpu_tb_trans':
../contrib/plugins/hotblocks.c:117:56: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  117 |     cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
      |                                                        ^
../contrib/plugins/hotblocks.c:126:40: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  126 |         g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
      |

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hotblocks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 02bc5078bdd..d540f1b7f0b 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -109,9 +109,9 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     ExecCount *cnt;
-    uint64_t pc = qemu_plugin_tb_vaddr(tb);
+    uintptr_t pc = qemu_plugin_tb_vaddr(tb);
     size_t insns = qemu_plugin_tb_n_insns(tb);
-    uint64_t hash = pc ^ insns;
+    uintptr_t hash = pc ^ insns;
 
     g_mutex_lock(&lock);
     cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
-- 
2.39.2


