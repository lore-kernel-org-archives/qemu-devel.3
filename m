Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F4EC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0o-0004wX-MX; Sat, 27 Jan 2024 23:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0m-0004rG-R0
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:16 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0l-0004NP-6w
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:16 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-42a8be32041so12058451cf.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416994; x=1707021794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRwZFjq4cQsQYmD6HoikyRyAnRDJPSlCSVsphAQE8HU=;
 b=JfHO/C6CexIZQrUYSOn3R/sQ43j985rFR7lFYvbNRffAS8XJhohfNwPid2Oo2/v77I
 rGjVkVG6eloxX2x4FIhd4eJOndd5Y6zhqS3VWKbzb7UdoBmNt2nFKWMrFt66uTgMb4/A
 2waXY07cYvcqcqlznhL/gYYkFvZ7+pzNO6jKtyqGNBDr3qwUl8rJZgrwFCgNUWpnxKc3
 rqXm5g98E2/lP/SO7W1J2W0Q9lP7KgMNzP7KV2RYEgxQiKO8cBU+Ykgfcoj/tow3zG8W
 dINNOdmVUlWlhigZB8NwXbQgTf+Rad/or1IpK7F2gWlKvr9hF8LU4qXENpVtk5FXB0f2
 l3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416994; x=1707021794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRwZFjq4cQsQYmD6HoikyRyAnRDJPSlCSVsphAQE8HU=;
 b=M2pMoFT/G8uR7Tl+GaJVLSfxZw/f6x/x6mqsPjnOtmDIgiGjIiI3fNaL6te26M7nhv
 jpqRPLDA9JX557eulX2kK1K8i8GDowITEw/OKu0MRMTNCOqzagq9qgUffeT0ccsdxecJ
 FypAaP+ZfoDunXXWVaKXS0kEdHj26qVAcCHK5m+9Gu103QO3x0PSDJ19FNZNcxPwtQYY
 eY1XP1avnNxuUIbA+7M9kPcIwYdZmN8nB06Eu/lgsc46AGXi5lS6psEBn7k1Qskfgkkv
 uQ49vpqWBrQ5ZEk3oiGP1Rr05e/awljWS0LaOV64rBQLLN91FANQcdin4itNqHlX9COT
 H+Uw==
X-Gm-Message-State: AOJu0YzPUQq5SyYYedd86xbfMMDVoV/OLXGMQVXhMRyc+IA0/MS59L1c
 4nt3Qbrg/okG80/TPYulv3W97ugUVn5pLEmGsEk4lDMoCqBvdv+lr0B2iPEV3EQt+s2Gw3ZbOmx
 oeT96WA==
X-Google-Smtp-Source: AGHT+IFf5VDv0qrWyaCdSk7ZrzOKkG8LZjY13R2JGKdb0BbdNiddE/J4+bBv8HK9sTNp/C4ifdGqHg==
X-Received: by 2002:a05:622a:245:b0:42a:7092:c7fd with SMTP id
 c5-20020a05622a024500b0042a7092c7fdmr4739463qtx.135.1706416994099; 
 Sat, 27 Jan 2024 20:43:14 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 22/33] accel/tcg: Rename tcg_ss[] -> tcg_specific_ss[] in meson
Date: Sun, 28 Jan 2024 14:42:02 +1000
Message-Id: <20240128044213.316480-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x835.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

tcg_ss[] source set contains target-specific units.
Rename it as 'tcg_specific_ss[]' for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240124101639.30056-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 46f7d53eeb..aef80de967 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,8 +1,8 @@
-tcg_ss = ss.source_set()
 common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cpu-exec-common.c',
 ))
-tcg_ss.add(files(
+tcg_specific_ss = ss.source_set()
+tcg_specific_ss.add(files(
   'tcg-all.c',
   'cpu-exec.c',
   'tb-maint.c',
@@ -11,12 +11,12 @@ tcg_ss.add(files(
   'translate-all.c',
   'translator.c',
 ))
-tcg_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-tcg_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
+tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
+tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
 if get_option('plugins')
-  tcg_ss.add(files('plugin-gen.c'))
+  tcg_specific_ss.add(files('plugin-gen.c'))
 endif
-specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
+specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
-- 
2.34.1


