Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CA5C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFun-0006xS-L0; Thu, 22 Feb 2024 15:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFum-0006vW-1R
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:32 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFuk-0002Zm-89
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:31 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dbb47852cdso580245ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634609; x=1709239409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riDxx/Iexj1qjgzxqR/EG3iYXorkzbFxBXBzbTLKvNo=;
 b=yNhIpPPe2TUFEU4hQVPE79G4RZfzCeGPK6Im71PSFrGvJ2NiQ0cKmxAvosIPrsWCKt
 eGTenUqYkfNHfS1Mh+6AUauwtaSbI/iwxHDW2EhOdCsGFifyKBhigGZKtReN1jEBB/3d
 KSUj/uVe5zi1zMJVTZl/4CvC/lVvD+wjQMgzGOTG1G3+G/zJm6zsJG/WFkwuaukX0Nhe
 iX2uC2XIfXilRMe8Y32EVM8h26qNs2P2hTUCCK5rpqVrTOi9h/XBShuU11XvQSJpeY1K
 xxehCEX6xYnqF/T7KbGu8OcjrT4em4r/qUShxPDZWFn0AfJja4MdXeN8n/EXJ2tWDb0l
 zL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634609; x=1709239409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=riDxx/Iexj1qjgzxqR/EG3iYXorkzbFxBXBzbTLKvNo=;
 b=YBx3eaa+uP7bQ+jtPaNcA1aFxwPN02MhMJGyAy9MBQNrfSkdQho7KyCL9kBvFxWzqe
 8StFFDVcZw7/VXW4nTVA59SIw7QPPjItHGDXRGUrYAT0gEDD2/nuAGZs1Aecak6toi/5
 Nttx9/TpX0T0tPH9Ef+ht1Ba3kCOWcheh2lx5oyJy0dWZb3kkFOnU8yvPFZgk8Dde3FO
 tZ+TTAen4jFpkX34nMdTY5ZveWXBtr0B1HeAodO+clYXIcoogQdQWrcC5PP5UZwqEhJo
 13EpvQqKn6/r+ftaCfjjQ6/67IoSkXcDBAI2ZEp+XR8cklJTwpaZ2gK4L67ojCG3vPiP
 SzWQ==
X-Gm-Message-State: AOJu0YxnztMCOOh/IahrTE/5mLfmWdJESeXnphdpN9Rpv8cr60rqlWTo
 BTcbmO6uA4XMtQyqBzayPmvBuq1qezM+Qxhgc5jOVamMeOUnBsS9IJgH5xeww8didwpHS4gx4PL
 +
X-Google-Smtp-Source: AGHT+IFTayTEfEFMciAD+6EPaRRK5cfQpJ10W5TGmNtU6UiQyNrqCn5Czg/EGKkqUMDMUg5eI2DMpg==
X-Received: by 2002:a17:902:ec8b:b0:1dc:11f:d954 with SMTP id
 x11-20020a170902ec8b00b001dc011fd954mr13067965plg.54.1708634608825; 
 Thu, 22 Feb 2024 12:43:28 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 02/39] accel/tcg: Set can_do_io at at start of lookup_tb_ptr
 helper
Date: Thu, 22 Feb 2024 10:42:46 -1000
Message-Id: <20240222204323.268539-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

If a page table is in IO memory and lookup_tb_ptr probes
the TLB it can result in a page table walk for the instruction
fetch.  If this hits IO memory and io_prepare falsely assumes
it needs to do a TLB recompile.

Avoid that by setting can_do_io at the start of lookup_tb_ptr.

Link: https://lore.kernel.org/qemu-devel/CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com/#t

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240219173153.12114-2-Jonathan.Cameron@huawei.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 977576ca14..52239a441f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -396,6 +396,14 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     uint64_t cs_base;
     uint32_t flags, cflags;
 
+    /*
+     * By definition we've just finished a TB, so I/O is OK.
+     * Avoid the possibility of calling cpu_io_recompile() if
+     * a page table walk triggered by tb_lookup() calling
+     * probe_access_internal() happens to touch an MMIO device.
+     * The next TB, if we chain to it, will clear the flag again.
+     */
+    cpu->neg.can_do_io = true;
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
 
     cflags = curr_cflags(cpu);
-- 
2.34.1


