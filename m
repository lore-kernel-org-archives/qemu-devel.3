Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B426C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 01:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOS2V-0005Qv-G8; Mon, 01 Jul 2024 21:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOS2L-0005P4-1v
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:10:25 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOS2J-0002A3-Fe
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:10:24 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f9cd92b146so23690795ad.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 18:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719882621; x=1720487421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zs33WUET3TwShkJZi0v92Kdx2DNNU6JjJOAyINKhk/A=;
 b=SRgOykneNf94xyN/fiGnE7RH3grYY5wiszuViIjhegM64e3Y3oegaFCUnJX3m8WG8K
 mjNPoUS4Vvl4uus17uBH/j3OKtFufH9U0rH63PmddEN9/NwpO8oGocEmwqfMo5Ut5W0+
 eUSCjLnVmWT16d2RPH+oHgujTbvcgwTDahh+4cvvbxRXYpwzXMX9rupwdbbhOjuiQQuI
 6FHDkAP5wuOlcPC2/kCYgIxlO6fWR0+hT1HUAVjAXtmr+i3/GA13I9HU8VJ8Qt+FFBgy
 smaDc+g9i3v6bJnkv4ulFWpVxFesnMpKGfGiIZJfIWSWHWcYIIY21+kHeUuPaJWs1eCt
 4tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719882621; x=1720487421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zs33WUET3TwShkJZi0v92Kdx2DNNU6JjJOAyINKhk/A=;
 b=fx3GLRq4iOJ5umqwNiP6lWJ70KIZ36p/x0Iuulx5SJVWzbkjQIGi3nOwe7jriuWdRs
 FNQWGTKe/8/NWZ8UO6ONTVxIEZIrD2jzcF5y5h+QyURQPrTbxfnltrTE+gO6aEJh88QC
 /dlov6Y/XddyNKQ/hY2fb4PvLKmHdq4yBD4LNnhLAjr6m6aphh6K6TFgvNS/vpRVz3xu
 3Pj5l+sXgRDQV0kBhkyTvi7kEp7lOtPVkCYrB/puJDOQXWYVd7uD93HtDRrUOcl7Ugc5
 i+XmUKNZezm5qQZin1lrsSuRGmEycBOz97x0QMtSUpmX28fYiurF9fZWlBHAVDt5LvrU
 ZjHQ==
X-Gm-Message-State: AOJu0YwKiB2Fo1vFTVivmNJC8ZIFKCW+XRfg2W/sTUXIyDOCB36npKz4
 B6pqGoj5fy7zJME10Vj+Cf4v4rLY9zffvpixXJvR91B4ReLKOuM4P3TM5gl5/jUqhXb2+GWkClJ
 z
X-Google-Smtp-Source: AGHT+IF/eFg102bQcTMjvOfLTTP0DJQjQu8at+GrURnqxRTMh15beDu+CwYrOtdGiFNSHNf8IVF1PA==
X-Received: by 2002:a17:90a:9e6:b0:2c8:4fd5:f647 with SMTP id
 98e67ed59e1d1-2c93d7143f0mr5241630a91.24.1719882620829; 
 Mon, 01 Jul 2024 18:10:20 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce1f198sm7480317a91.2.2024.07.01.18.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 18:10:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 1/7] plugins: fix mem callback array size
Date: Mon,  1 Jul 2024 18:10:09 -0700
Message-Id: <20240702011015.325609-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
References: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

data was correctly copied, but size of array was not set
(g_array_sized_new only reserves memory, but does not set size).

As a result, callbacks were not called for code path relying on
plugin_register_vcpu_mem_cb().

Found when trying to trigger mem access callbacks for atomic
instructions.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b6bae32b997..ec89a085b43 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -85,8 +85,7 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
     len = insn->mem_cbs->len;
     arr = g_array_sized_new(false, false,
                             sizeof(struct qemu_plugin_dyn_cb), len);
-    memcpy(arr->data, insn->mem_cbs->data,
-           len * sizeof(struct qemu_plugin_dyn_cb));
+    g_array_append_vals(arr, insn->mem_cbs->data, len);
     qemu_plugin_add_dyn_cb_arr(arr);
 
     tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
-- 
2.39.2


