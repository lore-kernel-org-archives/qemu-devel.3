Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29C8C54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsj-0000jS-5u; Tue, 20 Feb 2024 03:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsh-0000hK-FQ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:39 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLse-0008Ho-66
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:39 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a36126ee41eso683564166b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419215; x=1709024015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDgHSGvtF7qGWqMyv82hrdTgzPdhn+1HJ5vS2mvdT+k=;
 b=WFs8ucruAXeC3ZWMKBzM8JO8YHKEN6OVm6dPuxfGoCggWu+h2kT4yNwRUx3+2ijAG5
 HxNNCGy8XjlP9k34lYSla/pj6olcheJqfHpqEEZobRtJ1XRoyUy/HqYu+zqXi3MyqL13
 Jsd3VONaZNZ0ZzdYRUFurXwXY44y7dLdPfUtXFbEjVZmFL7lelGyqTCAF6qfXtTw4NVJ
 mnccoNirNMYe5wMNcSPCO+lM4IIyoosGOKKeWISM1DH1Tw9wIXiTe9XaiqgSiONg7Ytl
 zIxJvFJLhPXsgdPF9wdWfZVlEWzN0hgKnegwjYEgj2qvrxpR7qs2avFe4hKKoF1Rro0g
 42tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419215; x=1709024015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GDgHSGvtF7qGWqMyv82hrdTgzPdhn+1HJ5vS2mvdT+k=;
 b=FrGtEFVZu8b4TWIud6Jxpx8bFEGs89btXaPowC/vTs+5bDjIFa12+VWFNeRE42h9xh
 zN27YNDsiQiKVfPqycvP5FIsZ4KkxHnlDh66eFWCuWwTI5b7WT8MBAJfeMzs7r77BcOY
 rrk2MvUmTFN0tJf3uBlkciLJfjwWxvqgkoUQ3T1Y9IRVO6HwLXsBdK4MhqIQSTEHix0O
 z/ov8qSSXVMpJTHZ+GS2/dIQANMbBn3gxD48ZppAZtftgxSPRVVX2UgbrbxEp1O93dJ5
 bCiPYcaXZ9aGIwFA0GCbIOEnHzrNhFV61w9BRu33Ik0/vpzjmz5llDL3OntCgTZ+SQ7e
 lIGQ==
X-Gm-Message-State: AOJu0YzgtebJxAB3y16AQa/f/NPPtNMl61kQRKZboSNJfsINzXXbHkbn
 irGTwWb0pmfVcNgsJZUQv7GUX+y0+FkSO0MI9G2/WX8kUORAKH8r5V8rrklA6+I=
X-Google-Smtp-Source: AGHT+IF05Jr+3eODfG9nVaaMLbz71kgqZc91A+v3oTf+OAYzS9zC6++fOVnHWqwv1rRNXeKZHLqYuw==
X-Received: by 2002:a17:907:100b:b0:a3e:876d:1b1 with SMTP id
 ox11-20020a170907100b00b00a3e876d01b1mr3944482ejb.20.1708419214949; 
 Tue, 20 Feb 2024 00:53:34 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:34 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v1 21/21] target/sparc: correct typos
Date: Tue, 20 Feb 2024 10:52:28 +0200
Message-Id: <deda57f7d7dde2b88e2975ed6dee6cd85fb0ff96.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/sparc/asi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sparc/asi.h b/target/sparc/asi.h
index 3270ed0c7f..a66829674b 100644
--- a/target/sparc/asi.h
+++ b/target/sparc/asi.h
@@ -145,14 +145,14 @@
  * and later ASIs.
  */
 #define ASI_REAL                0x14 /* Real address, cacheable          */
-#define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cachable		*/
-#define ASI_REAL_IO             0x15 /* Real address, non-cachable      */
+#define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cacheable		*/
+#define ASI_REAL_IO             0x15 /* Real address, non-cacheable      */
 #define ASI_PHYS_BYPASS_EC_E	0x15 /* PADDR, E-bit			*/
 #define ASI_BLK_AIUP_4V		0x16 /* (4V) Prim, user, block ld/st	*/
 #define ASI_BLK_AIUS_4V		0x17 /* (4V) Sec, user, block ld/st	*/
 #define ASI_REAL_L              0x1c /* Real address, cacheable, LE      */
-#define ASI_PHYS_USE_EC_L	0x1c /* PADDR, E-cachable, little endian*/
-#define ASI_REAL_IO_L           0x1d /* Real address, non-cachable, LE  */
+#define ASI_PHYS_USE_EC_L	0x1c /* PADDR, E-cacheable, little endian*/
+#define ASI_REAL_IO_L           0x1d /* Real address, non-cacheable, LE  */
 #define ASI_PHYS_BYPASS_EC_E_L	0x1d /* PADDR, E-bit, little endian	*/
 #define ASI_BLK_AIUP_L_4V	0x1e /* (4V) Prim, user, block, l-endian*/
 #define ASI_BLK_AIUS_L_4V	0x1f /* (4V) Sec, user, block, l-endian	*/
-- 
γαῖα πυρί μιχθήτω


