Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63336CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lsA-0005CB-UZ; Thu, 09 Oct 2025 04:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ls7-00059N-0E
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:36 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ls4-00087T-Ib
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:34 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso406563f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759997968; x=1760602768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nf16ULl3OMJ1iL2VzWtsstQCjW4+oYwJ71ie5wSwdyw=;
 b=jzd+Hg0x0GpPmiH3Z3gf/jn+lm2yWzMWYlouMokbgfhnYjRkXtOOAAwO0vok5QPdAW
 316PCdW6zJL62nlKxo61aoGs8XtaB0NklPW3FPMWCcO8dEgfDTa7qBwMuQ0jW5pM0f6c
 HZ7i8vH1/BOvHHZF7r03+vvWGfoYf5W3/Lv16Vk0MAKvGX2XOICl16OO8u81ryO3PPSP
 NDjm2gHyiYSK7Ae0FCr6uK0D65hX+AQ8Ga/4oX+8LlkFctvBDaPJvOBLkCj/eoFtEuN/
 MtZSjUKbJdz45JRlKXbf4Jh7qgt2lXMhxChmoeFJSDYWvNBnGP+zxlkYdAisr2iMP5iY
 losQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997968; x=1760602768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nf16ULl3OMJ1iL2VzWtsstQCjW4+oYwJ71ie5wSwdyw=;
 b=fRXqg4DdwewcWdcG5aYrK1CxHHqoxE9yRef5ELzYv8mzAF5g1gTIN4Mxm8lP2t2xwd
 Xc2Tbm/a12DBpUgLZLyVXtRP5kAfNv9GBs7inWwiyUT3w7g3rbNgqN1w0keU3JFi6q8C
 FbehKdFpHvO+FmEG0LaMT/IfJbHpdvZqq+fSzu2+UQbEVxvp3vYh3USFR5X5c6TV0pZU
 osft/+TLCQFbV+oiD3KUV/Y7KCxGupimyuE2tzk/fN6aa+tHYiX982MZqCFqhcqv6uaf
 19X7+5vgXAmAzUVrf6tSYKqNW7fco4pYe255m+ydSVle4LP/UcSGgVVRz5QNUtnJfgQ8
 JuVg==
X-Gm-Message-State: AOJu0YzfIuMRTZEV9CBck+RuVJARr93B0HM3CgOJqSQLhdAJOhdlTLYF
 Jhu1sZbYMN3JSh/gOU9JZwIPmfTe7fY9ARNeOk7tOnMsK0jQyiK2KtMeWjj45Eym/RLBag8w57b
 eBTaUuqbNJA==
X-Gm-Gg: ASbGncuvxjcq/+xgXE1rM7etszIvZxl+uCVBzWRPb6/QSegejhPEWNWd3jUIBHgIyFy
 ZqDnYbMD6MSYsOhqIL58pgMr6KMa+L5jl0GAkxcuP1zsxmEZRxSpT+TbICyiQhkh2k2did8Gygi
 Z5cDy2d3OQL+I/CbmnArgGgzi2rRiQXtl3raCWA3qjHwdRhROtppQBIDHEY4Plld01mBZ5RVhDz
 08j5HaVgs18tb1ybytfVniWyGyZ9I4Fa6Kf3JFuRHFbBPk2CS/yvfEuiMXx3qXV6YNcGL6JerS8
 1z5RECsnpOt8jkFCKzLmeQvCbvnkr081F185o7Tcghrq0mmEt05J3eUy7xgWY/SjHUawwiEC4po
 GNX3qhYUAUz9QFSMkkYrMYrCIhtuTW5e0ZU44N0oBNB41b0CNp6u61sOdIJgNErAus4mJC5Efrk
 4dngeDD3/lb6KMXHdsn+UR/c9V
X-Google-Smtp-Source: AGHT+IGTQwwMzmoOGebCHjOBPTQbdHo4dNzldaGbJQI3WnbSXvYqtJytiEqFhNw5Da+Qf6txixmRng==
X-Received: by 2002:a05:6000:2305:b0:3e9:9f7f:6c36 with SMTP id
 ffacd0b85a97d-4266e8db5f6mr3657694f8f.54.1759997968372; 
 Thu, 09 Oct 2025 01:19:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e960asm33187966f8f.37.2025.10.09.01.19.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 01:19:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/10] target/openrisc: Remove unused
 cpu_openrisc_map_address_*() handlers
Date: Thu,  9 Oct 2025 10:18:57 +0200
Message-ID: <20251009081903.13426-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009081903.13426-1-philmd@linaro.org>
References: <20251009081903.13426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Commit 23d45ebdb19 ("target/openrisc: Remove indirect
function calls for mmu") removed the last uses of both
cpu_openrisc_map_address_code() and
cpu_openrisc_map_address_data() helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/openrisc/cpu.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f4bcf00b073..87201365a91 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -220,15 +220,6 @@ typedef struct OpenRISCTLBEntry {
 typedef struct CPUOpenRISCTLBContext {
     OpenRISCTLBEntry itlb[TLB_SIZE];
     OpenRISCTLBEntry dtlb[TLB_SIZE];
-
-    int (*cpu_openrisc_map_address_code)(OpenRISCCPU *cpu,
-                                         hwaddr *physical,
-                                         int *prot,
-                                         target_ulong address, int rw);
-    int (*cpu_openrisc_map_address_data)(OpenRISCCPU *cpu,
-                                         hwaddr *physical,
-                                         int *prot,
-                                         target_ulong address, int rw);
 } CPUOpenRISCTLBContext;
 #endif
 
-- 
2.51.0


