Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049F7D6CFAB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2ta-000641-S2; Thu, 22 Jan 2026 17:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2tU-00061i-Cw
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:12 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2tS-0003IV-QX
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:12 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4801d1daf53so17648735e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769119869; x=1769724669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qIfBYHSgtu/9b58++ba2ikXF5fP3ecwdtjJFBO+c3l0=;
 b=ijxJHFgPb3rGeb8WZP6L/ogzrIQaXdW1vjtWHff8GD1EHjq6X+SHvi0LHllb3xLDgA
 Rpkl1Thf+3RAFwWrx89AC/EDpVwdAI1Ye5aJmTfYKfZ0BvCHIYj5y3+Y8r3HGuKzhPXH
 SVamngGLlUd/63rcirriCmkpLq/u2MHtuCDvII/y05Z0jdlXN2EWAPQAFvTmTsB+VMyJ
 7Abw9i16VujpTuARBYCDZg2frfbnuaiXR4mcTMrkxBBym3p8QiazsPbvPS9dqtSBiwgO
 xqnQX0z6pS0VAWUMsIEq7tbCl8xXhGcjcxYGw6NX9XtQYCan8Gx+emzU5F7v4y54l0pd
 687w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769119869; x=1769724669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qIfBYHSgtu/9b58++ba2ikXF5fP3ecwdtjJFBO+c3l0=;
 b=t++E+wilNJoeijQUe15Cc5RvGNjkmxtxPw7nU8IkarnV2DiMl8UyPxXRGzjenWkO8n
 svb21xXi8SRO0JgFHzLyLsZAWa+0BmBJ3vwu43mQlaR1yI+4bK80x1xLQOpZPz9byB6b
 pnmI0rJllWpJ+onBO3142HGoPBJfSrQuHzCM0EjxC2CamaW7X+XqqZNGyVpNBrV6Y14I
 fnaBOOIy93G5w0dV3o5arRpU67y1hyBM0H0IFs1IyJmzPidSKvxS5wh19R6RtRnJQz2u
 TAZgrjo3EokD2vt4SzyZrazICVFZrEfMsszDjHvGpx/yLzWn15hHdq7QhLB3V0dV46cM
 CpGA==
X-Gm-Message-State: AOJu0YyKfz/w5+6gJaBXCTZ0CEFp1H7RoXfhPlgnf60YO3uo4Tvgivsh
 rprN4NaPCopVB6Mab00LqFQu+wFud3CtNMjcbkxb54PgBpmXPuWWxFK/A/hESFryExgB6dhxdAt
 0F2JfqcQ=
X-Gm-Gg: AZuq6aJd8WRAP43kuUKa8hlczDlOGfhJ8DMblewkBGHLXX8Ye4Ge8QelSEeqHQBhRyt
 CMHobLQmdOwDcYGZtD03ePeUlXw3BM50QARa0WPh3IoOyYYUfrjtR0IQ5xGmI+B3M7KChhMr08V
 VRd1HcC7dnqeGXb4bYlThD4JGfBjQvKEX1KESitySy6FMg2liqu8XKe7vEfY+7srvZavISG1G4O
 OrswDcpHZxz/wHAo5g+2MH6ddkEFIEdjMN5383VnZprK2y/lge0YunU6tddZ78gGaSbsupl6Q3U
 AQsy15jeHd+r3C18er4Lu6B6MmUp5g0wX7NGOFZjTXHuqb22+qHgEwBjdCWcgxhSsglUOmhLWae
 u2u/fDJwfM/WWzQJ0Spl4lpcelSNPzjycmKoIB3BriK31KCJRjAXesSbJk4jzSBaXYi1WeEqJzV
 Mk6oY6zY5tKfLyJv5TELMUjfXN8jJIghkX5o6pxwvoG+sYhOXonWMEQNv9vR7D
X-Received: by 2002:a05:600c:8189:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-4804c9becaamr14425535e9.19.1769119868844; 
 Thu, 22 Jan 2026 14:11:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804dbab1b8sm2893715e9.8.2026.01.22.14.11.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 14:11:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 00/11] target/ppc: Remove most MO_TE uses in
 cpu_ld/st_code/data()
Date: Thu, 22 Jan 2026 23:10:54 +0100
Message-ID: <20260122221106.57184-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Since v4:
- Fixed incorrect rebase

Since v3 (DATA path):
- Remove MO_UNALN in do_HASH (rth)
- Complete CODE path

Philippe Mathieu-Daudé (11):
  target/ppc: Inline cpu_ldl_data_ra() calls in ICBI helpers
  target/ppc: Inline cpu_ld/st_mmuidx_ra() calls in memory helpers
  target/ppc: Inline cpu_ld/st_data_ra() calls in do_hash()
  target/ppc: Expect page translation hash addresses to be aligned
  target/ppc: Introduce the mo_endian_env() helper
  target/ppc: Introduce ppc_code_endian() helper
  target/ppc: Inline need_byteswap() and replace translator_ldl_swap()
  target/ppc: Check endianness via env in ppc_disas_set_info()
  target/ppc: Introduce ppc_env_is_little_endian() helper
  target/ppc: Check endianness at runtime in mo_endian_env()
  target/ppc: Inline cpu_ldl_code() call in ppc_ldl_code()

 target/ppc/internal.h        | 11 +++++++
 target/ppc/cpu_init.c        |  9 ++----
 target/ppc/gdbstub.c         |  2 +-
 target/ppc/mem_helper.c      | 60 ++++++++++++++++++++++++++----------
 target/ppc/tcg-excp_helper.c | 27 +++++++---------
 target/ppc/translate.c       | 15 +++------
 6 files changed, 75 insertions(+), 49 deletions(-)

-- 
2.52.0


