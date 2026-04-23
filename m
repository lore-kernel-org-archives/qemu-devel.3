Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24759FC0340
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvqP-0005Us-NH; Thu, 23 Apr 2026 11:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFvqO-0005UF-2g
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:19:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFvqI-0002CR-VT
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:19:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so6970493f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776957588; x=1777562388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PnhfxpyOrEFHhYfrElCJxn7WSl22OKT9MC8JbiCDHig=;
 b=A3KSQtM9SyWTTFRzzpwta8E30ynbZJlpZOQpNq/AZyTqIS8MTELFyoPEi4xGKOO1a8
 +p7n/qDtu3sfNzF+DZ/bf2vXTt8qxuucxmK7oQEBbBmoOXWqpMymS5ED32KbHaBSnkBN
 1WXUTzCVLFa+g1LFUf4W2YG0b/UEBeG8csV4g41NQTzrPBDDme76sCXlxxPTXtSCJALo
 l9Do+rH0fy7gH6TijBK0FxMFXlxcHMovcKXEKFetlA2lc1rpiflk1DNh4+XRUXRf1NsS
 cEjewhQVMbKntYUoNdVmq1AQo1HUtyfS3YWf7Y7IJKHkZqseU3sp8dv8H+cvzkRvdqRz
 4sRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776957588; x=1777562388;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnhfxpyOrEFHhYfrElCJxn7WSl22OKT9MC8JbiCDHig=;
 b=ke7UmYmoxOb3sRD//p9U5gFgQcA4CNNjMVuaeNq2H8zMvqQg96UYf9rVa59IAymW9v
 aj2pO1VCbpjwyFPWbGuU5tLwl0pDn/D62Bx5dC4xa2dhPni8DbXHjX4wxxZRqDu+1Znd
 C+MEBuXYe8hrzrpMcPqeHOlvtUUOF9k17dqXTSbT7YWTaEex10UufKhBl/0CRgN7L8tO
 Rw5GvI6Uy7eNjKPBV/QlbsEfcu4Ctop2RRVVUsWUO5jCHDZUKzeKYDtjNhSGTsw14C8F
 z/hpmMc2oI4+Pvkj/eGk3qARLp1w+SIHGPugZkD5tU6LuMYLkZ3XpQYzBREl6Ea7HLs6
 68Qg==
X-Gm-Message-State: AOJu0YxRcrTH2RV+ldvRH/BR2CvVOUSC+YcXwU0RDwB5Jaz/NeWMdNqn
 /HDu3GAiPZM8BzkJhr65J+QeD5wvAaEP5IwNb5rqN7ka0ApUIhzRQAF/kiKG93uG2yAUszdsnE0
 MSlouo2YkNg==
X-Gm-Gg: AeBDieufuJy2w5c19Jk0Mer60qS1okU1xh87to89B/2H9sigxryeI3Jjju1zzseYx4L
 EnwheLtQFwRxnWIqRvRLFTu6WovuduVSs4CMWcMHZZsJl3GivvnLlzklxNiV+sijF9kQDL19S4t
 GotMMgAMjMHZI4F2ib/jj2Y6tNsuPf3onQa6Ie1NY2vqWcH65KFL9cmKusVeMJ7kkmhimZdJoKz
 s8NdedzA8WtKMCGIPnFFhF5kQYx4cvmiGzecdjjQwFToKyiyigPIVphNmh+aEkGNvLalKGp2WIp
 KFho1UH8lCO018+H+ujCnQM1jTGPMj9qvp47Tvueuh94lt4uyRkFo0mOfZFm0/7OtCw9pzSRR7H
 RY5xC/+FHiE4bBoARyKTDDl1BxXVbEQCEjlAy8NNhTaRhsHDqjqugd3BWILupNX5vwaGHZXjCj1
 kpTc8UbJ5J8B1zvTuo336QkrVpajrsuTiuyg==
X-Received: by 2002:a5d:40cc:0:b0:43f:e721:76bf with SMTP id
 ffacd0b85a97d-43fe721784amr29083852f8f.41.1776957588435; 
 Thu, 23 Apr 2026 08:19:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e46898sm57142024f8f.27.2026.04.23.08.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 08:19:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9D9755F7F9;
 Thu, 23 Apr 2026 16:19:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/2] virtio-gpu hotfixes
Date: Thu, 23 Apr 2026 16:19:44 +0100
Message-ID: <20260423151946.1853943-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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

The following changes since commit 98b060da3a4f92b2a994ead5b16a87e783baf77c:

  Update version for v11.0.0 release (2026-04-21 16:28:47 +0100)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.1-virtio-gpu-hotfixes-230426-1

for you to fetch changes up to 30fad722ce68316d22b926ba0e6017f0440465df:

  hw/display: don't accidentally autofree existing virgl resources (2026-04-23 16:13:53 +0100)

----------------------------------------------------------------
virtio-gpu fixes:

  - fix build on Windows due to EGL assumption
  - fix use-after-free on virgl resource

----------------------------------------------------------------
Alex Bennée (1):
      hw/display: don't accidentally autofree existing virgl resources

Anthony Roberts (1):
      ui/sdl2: Fix assumption of EGL presence at runtime

 hw/display/virtio-gpu-virgl.c | 6 +++---
 ui/sdl2.c                     | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.47.3


