Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26FCC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsY-0000OE-0G; Tue, 20 Feb 2024 03:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsU-00009Q-8P
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:26 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsL-0008Bs-G1
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:25 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so725417766b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419195; x=1709023995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8LOpUQSDLdq/Q7FHXx+eaDcvqKGP+tp/efzoaFLimQ=;
 b=pw5577pTpXp8k0vN6O1zMaqxu8cIHmD+bmp68hoXP5va+pzHFYOL/uJTbpx/RHjxwS
 PYSWVlSJrxeg3D517OF9jHQtkHv8kDgOH3RSXWie8FYaZiRj/OXXZe7ZZ0WGr5fA6eL2
 GTAYsZ38ML2DtCJjYtRpO7xzF9KCsrX1dtKjX2DAqNS5kbnLIW9pH95ch/HrrtdVo/Ok
 a7gTpcRW/C+d65TEQIoD+HOaVBU6qqQmK8V0CJFvQP6IMSlg9x2WtUV8GWyWm5Z++6OJ
 zsic+ShfmW1cTz7Lb8NC0ks9/wWF0KRKYUD0uQjVggnUUbtTdul7jS1gRlYcgJ8ig5X3
 42KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419195; x=1709023995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w8LOpUQSDLdq/Q7FHXx+eaDcvqKGP+tp/efzoaFLimQ=;
 b=TbA2e+wjlj5okrJMXzQ8wMrqxuG7CdrElmjZwzkSJV0pzPb0/pciW/pbps2dsaW4yu
 pNSO/uxJYMIYgSvCWCH0TDQvyZPRE5TuB1jh1xNRVFs07Ure1qLGt06+bopwxIrrq4q3
 B+6yGRwfx9O/+9auqU43ms2bt0Kzf1IEYMaemq0nvTpZvo1oZvZxqhuTZ0O5FanHCEdm
 uP+l2BA8yUAII6rTMsbVmJYA/I9UBq1DtyBBtIvfVuknL8cpSRePlcdECK6aPwITIyYG
 uvu+dWdoC96hW6dzjcMFpoJAJ81n315GnLb+BS72VtCprI7Po/9cPOZzrQpNI5Gt2fRT
 OvBA==
X-Gm-Message-State: AOJu0Yy1Xjyjtfj7OC17Wg2SpR2wU5iNcRfaVU7XMSfYuP/TB/uJ6qKZ
 6JhgtzEIquuxQxhRmYgj6FX1rqWNQEh8LEeHNDCiV017sWLnCM07I7DPY41QhtM=
X-Google-Smtp-Source: AGHT+IG8qqcWkwXHQPyB+uR9bclG1G2vyQ7VRpW2+xiFcPJu44K6+Becb2NE5IJuMLHAhYyUAdVFLg==
X-Received: by 2002:a17:906:68cb:b0:a3e:482b:1b9b with SMTP id
 y11-20020a17090668cb00b00a3e482b1b9bmr4588271ejr.75.1708419195707; 
 Tue, 20 Feb 2024 00:53:15 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:15 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v1 07/21] sh4: correct typos
Date: Tue, 20 Feb 2024 10:52:14 +0200
Message-Id: <12425416adca441b07f7e3ecd4bb339096a7568b.1708419115.git.manos.pitsidianakis@linaro.org>
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/sh4/sh7750_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sh4/sh7750_regs.h b/hw/sh4/sh7750_regs.h
index edb5d18f00..946ad7b3aa 100644
--- a/hw/sh4/sh7750_regs.h
+++ b/hw/sh4/sh7750_regs.h
@@ -172,7 +172,7 @@
 
 
 /*
- * Exeption-related registers
+ * Exception-related registers
  */
 
 /* Immediate data for TRAPA instruction - TRA */
-- 
γαῖα πυρί μιχθήτω


