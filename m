Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6C9106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vvy-0008Mn-Ex; Fri, 13 Mar 2026 02:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvt-0008JW-Et
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:38 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvr-0007DT-VZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:37 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b73f4ab4so2065615f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383014; x=1773987814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53mNKzvab/32xZpUxA/85M594az9SYvGSuw6VS9vrso=;
 b=Ies453KVgpfNMNZWxXvW4bbH1bkG6ZtcLskkMaNWUOOWQZvxLGV6iJcoA9ST02ptht
 IqqOORyq2VNMaDzElkWRpZENdvnAfhdPtudEgiN1XGMqAhjXQi/Xu2xn7ZGK7J/2DWkE
 t0NTXP/P3Y0RkOpihWM9mzkGTuVCCgHgyN2OekhBEQqKoNdzZNzvWd7bSIHbQjyLVuk0
 iGVIuKm8VGa7C+Vi848EiUPJ20siQiwAtwFp1qoMQx16Qmj6PckWjcKy5bDwEV7GlMfY
 iYWd2L5uSY+/TD91jSJzgxMmix6pW1EoJfAFDWtNJUObsPttRiTxPlDrHdNARg8DM2tJ
 raeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383014; x=1773987814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=53mNKzvab/32xZpUxA/85M594az9SYvGSuw6VS9vrso=;
 b=Wp5SSOm/57zKa4bClikCbhjhYoH7w3API3Z/4o4jbWVBaMKBlNXIUi9c7YsKoKd+in
 feWUseSjFIjBuEoJgicWEMSLwj3qZjk5mTNfZa1j2Iy73T0gsDUp1zS4nUu4f3dDHJIT
 0smPB3gINshmc81W/aPRn9vUDFlNy5a3i24k7CV/j9pIrvGqTvCeS33ldFZnv0LYybkw
 5NSn74J2E26Z0TEnqieALRS7R5DHbmCxamlh35JmK+DAMdRrmhanOeJUoz80AaopOgNV
 vc9MkgEbU1gD/fnvyi/ukJ37S1RzK0x8Da2sYSq+h8cksmaVAdXU5BwouBfNTYDHjwor
 zlFw==
X-Gm-Message-State: AOJu0Yzn5nK5USJfVwufXL8Icp6gJGblyhNuw6P8U/DwKV6mY21TrL7S
 wYSLeNqWwu0RJuItERLfDhwSMdNoGo8qDMZ3xl21AUk5mn1LiCKJ2zamCOtAXFWqalpQtWs5zOo
 Z1I1IwJ4=
X-Gm-Gg: ATEYQzwHtTzNs/n8p6VadV1eDHRa6o3Mor0CZ05ZqqbTXW6PxJPjli9loo2smEv3XWe
 oqc88rM7oN8nXFetfrsEf1LMfh92mzg10eykbZpm2Wr4ujr6FKSnghWa7W2DMJQb7yhEc5Ldpbr
 5VfZMv2+sKEgS8GXo3+oHjs2yRRvQ6l7bFbiuHxc7cE9J46/FoMzGTm+8LlJVyrFtWuezxIFXvH
 fgElF67fpInlUiHnUN79w5Q6tjhqmlIxNvDIfA1vZRarilLHK7uGWKts/orxp7losamn4f8AbZ4
 sz4ZlhZ5us2G7ianfwKbhu0yziN4IGYc74bL77TfZmyJJiSJmoMTR5iW2TFSayquX0Zh9/lS/OZ
 EkC16b/xyo74/unlW1o50LapCVsA9HHQdcpTt4dZtYLuSLs9Tk/x2ZK9t0w5/peZ8JnFlzoUwa5
 WGu9+z+VZ1h8ZYSly1KRQSCWWS5D44lVpZ6zxHZFs9S+6kmb2I4PbDoNC5t9VVMdWtzh0mIGrcT
 ZdYxUCiy8gnTw0S
X-Received: by 2002:a05:6000:2dc5:b0:439:905e:1236 with SMTP id
 ffacd0b85a97d-43a04d83c58mr4511100f8f.2.1773383013947; 
 Thu, 12 Mar 2026 23:23:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1affe9sm14455124f8f.15.2026.03.12.23.23.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:23:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 23/38] hw/hppa: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:39 +0100
Message-ID: <20260313062055.2188-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index ec63dc12979..3a96ba00cfb 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
-#include "cpu.h"
+#include "target/hppa/cpu.h"
 #include "elf.h"
 #include "hw/core/loader.h"
 #include "qemu/error-report.h"
-- 
2.53.0


