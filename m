Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC42C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaoP-0003gq-NS; Sun, 18 Jan 2026 16:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhaoN-0003fU-8m
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 16:59:55 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhaoI-0008Il-5A
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 16:59:55 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-430fbb6012bso2910024f8f.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 13:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773588; x=1769378388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MUqg/c3XOGu598nJL9AuyENZuHnrrv2YO9W5F9axxGE=;
 b=jsUl5ck4Le9b52AA/2iPZgr8mnMUUPCCP52ntDP7NBYnm45c5Ccwotbney8t5r+uMk
 Byo/5XSGYXZWrNqNTSAhdIUt9wFc7OrYsCoa1chGyCR3y4+W91KxxFIATygrjm6mcWc/
 SU60DFKGDxTqXms0AO1t8sTdSy6BHvGB0PZ0kLW/8IANBKcTeDwr/Gm3RB+qSpAQXjyp
 YZhcLPHOB3kX1YXjc8bVKhuosBEbXHPa+MIKZpGoYbvCnMcZYHMPtzGC8txI1VPoB35S
 7R56OMY88vXZdL3aCpoZQAmkX9WonC7T/yJuDdkDWLpNqOK8Qz9MthcFIGVsD6bxQZc7
 g29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773588; x=1769378388;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUqg/c3XOGu598nJL9AuyENZuHnrrv2YO9W5F9axxGE=;
 b=wIxJpsJzZ7wZwGiwp+q2uKA+l1W2JTqhyXsr35RuhK+c3GPIRReM/VdkEu+0fKkWss
 CxkJ33BG8UdQvW8+yp2x70esye5U3WYOaw5MBinPZkWK9/3i1gTG6VBpwAw6gn8lSGZc
 a8CyL94Lfk/saxGHrhxKW8qV3GAsvAqhSmXNyBUeyuIK1+zylmxylaSeHMZBvT9cERvS
 5BO1b4gooaV3HkCANCcsfUjoAJTWlz2f46k9CL6Y/5HJCbOk7BUl+CAlfTQtAFix9/u1
 qN9N6ywVYUJuumMqKMFJWoABRUWxHiBxo3MWoS6E3fBfq++SCHK164+katskQ1k7LBBz
 KO2g==
X-Gm-Message-State: AOJu0Yzj7rl3vQAugwJ0wuctAIQvpmNvKRkoTriSTIX+kJjLGfxYf4ot
 DUq80FBxA+h1dEkNaDIkxkQ8n66mc/sDlSmrdv/8mKCFIt+82ikl0h6Y/58Eg538vwjoGgR59B/
 KJ3UYjH0=
X-Gm-Gg: AY/fxX6S8jFxpU3nuowMB7Kxfs53AvEGctNf9FYqkEA98MXpseJQxRi69PUO7Da6zXD
 EkgCw/ouJrDdmjIZkcjhkF8G1gHXhq/RPfkSNiH6q9ZeUyJ1ZcHfd5ZJvs5KM6v2g8weXevZ18k
 nQovY+lM0RBkuywha8Zdwg22814Z1QPh4zOhURy5dojbfTMWeq1ECokrHUvstSc2iG3JY261Kh6
 uUOqAQllWtHEAmfMlrdhnm5bErnSCJCh0XvMA5gs0UTaT0ThL1j641v45Gpx7kWmlxRABDDnLnY
 VIANrolKR9RHMlFmmDI8TAm8sxkZTlDUgGMJHHUjD+KVz818yRkbdWUpm7HExk/mrGoaL05TnbG
 B+7gqkz6plSUoiBE9roKoOEr+tQ7dMlo/FKSpDVd0Au7IQgGfNsg/IR5AUns91/FUPZvniM8fIX
 sAbPeUHhxY/jlNOPZ1dyFntOFbLhitNEcKzVom6IhLOh/QFk0tQqALdVcslOM2SrfdQQ+/XIk=
X-Received: by 2002:a05:6000:1843:b0:431:864:d492 with SMTP id
 ffacd0b85a97d-43569bbaf7dmr11905027f8f.36.1768773587869; 
 Sun, 18 Jan 2026 13:59:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e664sm17358111f8f.30.2026.01.18.13.59.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 13:59:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 0/2] accel/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
Date: Sun, 18 Jan 2026 22:59:43 +0100
Message-ID: <20260118215945.46693-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
- Addressed Akihiko's comments
 . Do not introduce hvf_arch_cpu_synchronize_[pre/post]exec() hooks
 . Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0 in hvf_[put/get]_registers()

Philippe Mathieu-Daudé (2):
  target/arm/hvf: Move hvf_sysreg_[read,write]_cp() functions around
  target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0

 target/arm/hvf/hvf.c | 167 +++++++++++++++++++++++++------------------
 1 file changed, 96 insertions(+), 71 deletions(-)

-- 
2.52.0


