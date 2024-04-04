Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7DACD1288
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsT4B-0006W2-LU; Thu, 04 Apr 2024 15:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT49-0006Vm-37
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT47-0000HB-6U
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-415584360c0so10350695e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712260081; x=1712864881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pBI2bAKvSbFwYens+uFocY16BqreP8B228r882k/ACc=;
 b=U7stbzmBx2gskD9tutN0ROnl0Siy5LpYSdJU6S+2rkQRZT+naHybbIbWe3Po0wvkY0
 tQqXjhA7l6l9tOKs2edfVBkNbfsCdnNk0YDH0WMnk3BFQuJWkphwRIorOPql0kfEbcUB
 8cbOXwoJ1jPTtIsn7L9hCW2abhElufNwzgMw+bf/LrHVcYgCra8QYm8v0GhVJrNd4m7W
 2Adc4xTdjFGz9j6I+iasZryHPCu6pI9XcFAtMgZgAPJG5PSjPmi3OLEYPFjMOHCYkLf1
 pdHSxB7hQqqKa6lOXN8NsyY1TK68Pa6Frl99MuGTKv34q8ubkqvgzK4Z4R1g+EBkxPD8
 Am2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712260081; x=1712864881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pBI2bAKvSbFwYens+uFocY16BqreP8B228r882k/ACc=;
 b=S83e9QW5Zg4HxfInkte9q4GtpzS5iuSsCKRobK+cULMKEcOu0gE50XurQqLE21SfjS
 K8xPtI73eMHu8vVDmNf3HgwdmIh9jxSqn5FbCW3/1JGm5CG6wB7ZagX2Q7ExWb39Eqp+
 4Us9dQNk3s7M6/hr/tEOwuOip0vvTDBWzJdIf0hRGKHCky9mBWKuQ3vaVLh8umwEN7V8
 RVvxARktnZ8PtshwUAxCxs/31HdSIAR5/+kyFdt3Iil9QpSqSRSs1fjr/zwUdnRd1Ula
 MOYSNCwS4FUAxZUDqo8e+dsQffucHstmE5ynSBeoCvjeg45OlI3tH6QaAzitVxMpp+Qp
 IxIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU799MCHOEpTVr+1DGg4AN52gPi18cKOzCG+GH2Lbpr6eD8a28ToN3P6MFUJ5A6lQ02EWC6ATBOIKSKsuogbwjBBxzYtsI=
X-Gm-Message-State: AOJu0YzTUD9vXl4PTyu96air2nd45uToZBnHPj1gT/zIXomMAy/z+ZpV
 dgnz4bVh5SyWq48DnkysnBq+z+x99uJNNfp4BAH/SSZKBcl8y/pMJsTqaApFN6E=
X-Google-Smtp-Source: AGHT+IHPr2CCdDowSKUJMBTMnRoQ0fRs92PZPihFKjVZmdAbGNdLTZcoKxtdzf1tyJLv2/Gon7eRog==
X-Received: by 2002:a05:600c:204e:b0:415:5732:65d3 with SMTP id
 p14-20020a05600c204e00b00415573265d3mr2549708wmg.37.1712260081437; 
 Thu, 04 Apr 2024 12:48:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 bg8-20020a05600c3c8800b00414807ef8dfsm247994wmb.5.2024.04.04.12.47.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:48:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-9.1 0/7] buildsys: Start shrinking qemu-user build process
Date: Thu,  4 Apr 2024 21:47:50 +0200
Message-ID: <20240404194757.9343-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi,

While reworking include/exec/ I have to build many configs
to be sure nothing breaks. qemu-user is particularly
sensitive to changes in this directory (mostly because
all user-specific files include "qemu.h", itself including
various exec/ headers). Getting tired of this waste I had
a look at what we pointlessly build. This series is the
beginning of yet another cleanup set.

Regards,

Phil.

Philippe Mathieu-Daudé (7):
  ebpf: Restrict to system emulation
  yank: Restrict to system emulation
  monitor: Rework stubs to simplify user emulation linking
  util/qemu-config: Extract QMP commands to qemu-config-qmp.c
  hw/core: Restrict reset handlers API to system emulation
  hw/core: Move reset.c to hwcore_ss[] source set
  hw: Include minimal source set in user emulation build

 meson.build                |   6 +-
 include/qemu/config-file.h |   3 +
 hw/core/reset.c            |   4 +
 stubs/fdset.c              |  17 ---
 stubs/monitor-core.c       |  20 +++-
 stubs/monitor.c            |   8 +-
 util/qemu-config-qmp.c     | 206 +++++++++++++++++++++++++++++++++++++
 util/qemu-config.c         | 204 +-----------------------------------
 ebpf/meson.build           |   2 +-
 hw/core/meson.build        |   2 +-
 stubs/meson.build          |   5 +-
 util/meson.build           |   3 +-
 12 files changed, 248 insertions(+), 232 deletions(-)
 delete mode 100644 stubs/fdset.c
 create mode 100644 util/qemu-config-qmp.c

-- 
2.41.0


