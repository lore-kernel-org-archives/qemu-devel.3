Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB145D6CFA5
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1oB-0002pQ-4Q; Thu, 22 Jan 2026 16:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1nm-0002aI-Pn
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:16 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1ni-0005DG-K6
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:13 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so1452142f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769115664; x=1769720464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lhxXUE0H+XJXDXOhBm3s+IybQWdIwTewdlOeA21IWl0=;
 b=x6Y6MCBt+ZHJykG+7tX+5JIv74dMz8Nanjeow3V/g8ul6U4p4boe/lAbx3/Ef5v3us
 FIv1Iizk7wtmWzMF2VsGq+/Yi8q8Ai4QS4IsTvVi/cau8W5LgxvwsVZ/nn+chUu2yrob
 Sdos1KOf8bqOTigrk4+gexqOlTJAEGjO4GM8O+DfQUl+889P10Dv7uUlLpFDOJ3pYxni
 5NWmlBK2GVPEJiZ+HV6kkE1qIHPszGVc3UMx8IyeCrdYhOiYBzfY0PxSQ/L6148OeB9d
 qOtlHm7p47aSyr9wSkTEWMt1jBjMgLE83tvF9MQ/SVRqskAw+rSJoz8E0HkDn+kiW+AE
 FxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769115664; x=1769720464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhxXUE0H+XJXDXOhBm3s+IybQWdIwTewdlOeA21IWl0=;
 b=Dg8V4xaOhybImTLKahC36j051wZE62RwC2YZmWKz92bKK4YspvXY15yVLlFraCfhBg
 Tci56T/+LW2W1U7J+sWTL+7ReWfuttDYig6lX6potK7lezso+Q0P/SG1M+7i9mGc3cip
 9gmvYETxW0lc5F0wdLkLFpv7PcDiJBBN/miKLb1nZPWS+Hte/Lg6FeY2jgyR+mV7Ur9Y
 tcuxzfGrasUY0mh9WEPZwyiW85SxqQVijMpPsiHtGyEwqOb/gLV8kAkj/BvVe7TaWRkf
 h1fJt3OHvzmrYXvlkNTUXQbNlTovbTOWU981qt+WpcWCJCqPbd4s8ZFG3eU9xgn5H5vk
 Iavg==
X-Gm-Message-State: AOJu0Yyc2x9H94kHiTbfn9JPKZj40L7uXseC7IP3fakEAZJQojeDEzD0
 ZT3fWeiYryz2F92EzUbWVYLNsCbiZFoNVXoaADKsho1FaPZRz1TgtCZg73g+rZlCdiqLVpoqyOU
 JQN/2KQA=
X-Gm-Gg: AZuq6aKZkncmULHatajqo/iv/lVspwm/ILZflpeahH7Ccv1rVYH21LydwsrXsEl+OnW
 raxcDKmdpwxailj78u7U4GLj+3NL7SfhhGYXb6dLqUUGaUysx/kVNOD5J4O+51n0Vc3P5C6qhvu
 OB9PQWYtVgi+mv/aenxbq1wNllrXSAakMqIU/X858HhuD051w+o5hgpamqtU4qGZc+Zohkd1HRf
 7DscmyC7O0jHmnZp+l60JkFZCc4aWXcetAhmtkOC7L+x9bKEmW+llB3Qt/nKmGZfM8yic1X1Iz8
 3IfZX8uqBsFUeWB4ebjHl7RmtZ5n03LZxY3V83iERLSSwraB7czOAnketoLzjrW5Mg6S8xwM43M
 EEcNrDlZRd1Yuu/UkBAGIhA89YiW3ZPutMypod+OPt+TPngN99TqviEEDyk+JxCgrXL3XY+4Pga
 BdcfgWCVhtqP3RFljPeNhcHAE4PRUE9MB7CTzu2Xz2FfH2bYctiunSby1y2eIY
X-Received: by 2002:a05:6000:2886:b0:430:f494:6a9c with SMTP id
 ffacd0b85a97d-435b159cac4mr1372393f8f.17.1769115664432; 
 Thu, 22 Jan 2026 13:01:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24b54sm1351261f8f.15.2026.01.22.13.01.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 13:01:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 00/11] target/ppc: Remove most MO_TE uses in
 cpu_ld/st_code/data()
Date: Thu, 22 Jan 2026 22:00:50 +0100
Message-ID: <20260122210101.55358-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
 target/ppc/mem_helper.c      | 56 +++++++++++++++++++++++++-----------
 target/ppc/tcg-excp_helper.c | 27 +++++++----------
 target/ppc/translate.c       | 15 ++++------
 6 files changed, 71 insertions(+), 49 deletions(-)

-- 
2.52.0


