Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5D2D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQATv-0007ai-Mh; Mon, 01 Dec 2025 15:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQATo-0007aE-9t
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:26:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQATm-0002Hp-Id
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:26:40 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477b1cc8fb4so28189165e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764620796; x=1765225596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dGo7HwaYmm3RUbpO4wwSLRoJ5HEPwxxBa7Gq9BFgGSw=;
 b=TVcEVKKvWJq7rFBNMA/S3gyQhC/Mt5ixxa7kCGW5wL2j78ruv4AV8IDpFpULB6lkH8
 YE11ujauvtZQ3AeEgzJPFMf+9SngH5h33TabCViuAk5/xqbBAs57wbcBhqGCvpcCn8MS
 KUGQC9Yh7auWku/cPDgat20RyCE+goNOdneeiJNI6xFsWivndPeS37Xc4IA4mbVBXvpL
 RKXoULchXZsfzn36hl0ADOYSEtUh5Qeck3W0/Tg7nGbhlVeS7G9pUEcyHe4anZ1cajW5
 IN5U8jcdUdX0aNO4GAzshTYlRiUHSDlRlXPj02WzlJuAeqMLcsTQTVOQAhi7yD6+CYdB
 icxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764620796; x=1765225596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dGo7HwaYmm3RUbpO4wwSLRoJ5HEPwxxBa7Gq9BFgGSw=;
 b=LkfgfE/PvkREJ8plL91t75fLznZs6SAnyfYl+Yh9J7v1UzS0M2hWXyVxrhi2wHANOu
 qMFfz5s27zWoKn1yZ3siJp+1ZhNgpfJEyNNl07fzxIW0TWLo1060Ipi+vUKVoLWHQLul
 yRdi0z9Q8jM8ODf3fH0y2gUcduvzCnu+btkGW0ZxPA6Eoq8yBoxwR8TnxuaMOBDiQr2h
 l8Hf2k1jfZwDHJYAkAb2E/AWTEoShR54v77C6wQ4yt5f+9yMqt1uStN4/KJK2lxP76LC
 CiJyzhSvh+gj8VEsitMsIGgPAQiCxvrBPvlGnPgNe6/P+gT576zVmdKdbZevVnUtAM7Z
 S9GA==
X-Gm-Message-State: AOJu0YxWxjZQKZqC0fkNskerdt9DLXC69NPa6jYbVijAXZka4Vzs5e5q
 g69JACJZP0ltdMoz8HdpXfQ//xC4vIppKBsOB3hTVfbB1jxo5fo7Np8JRdBgugonbhme7mbZNKu
 0U8XVarln+A==
X-Gm-Gg: ASbGncsr+yMzml0WmksvQzfqgq8kxJu6vHjt5u0nrME1Pkghux/qxuAI53uSOu+KNbt
 QWVMHUqrhPt77t8BEmjjVcxWJam9NMtrX5tWrnd/TNyHY0+WhoseiVIrLklxLPKS3P+GuntG84l
 LHZQr1JHmTUvJuurN417wlU8vJsnpBtxCp6AYI+WS9aRO7FULqP6luDH7Qlf7JsCUW3DShv7gWq
 TRSPI2e3FdfVQ8r5ovBCRuZD9uqqYbperqDqtceIED5ivSEoTkkLRE4NbiP8536+ITUrzDw3Z6f
 bTYgrGfk5RAyRCNo3qIAqD7LIt+QHc0yCsPO2sLWuHxifiiZWeHjKlPcexxhiMOg/V3ZYR9DNkR
 8jUvf43cx3ofQCHwOUZCb2GoBO//ETb+FzbxuW0i58F4ybgjUDQRA5R3WT0LCAdv4bPgMcNMn3S
 q/9fzi22PBGRXcez6p0I11MXiCSWYJnZM0ubbQrA3Wwu+/YJL89vj0DeSwNLIJ
X-Google-Smtp-Source: AGHT+IEYVh0/qVKp+4EZrYOjyQ467DM3iYgEp3zx77Mm79ag9dI99FHILr084mBTLDObPxnma8S48w==
X-Received: by 2002:a05:600c:8b37:b0:477:79f8:da9d with SMTP id
 5b1f17b1804b1-47904b1b270mr277349615e9.24.1764620796475; 
 Mon, 01 Dec 2025 12:26:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a303sm30053265f8f.27.2025.12.01.12.26.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Dec 2025 12:26:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Accelerators patches for 2025-12-01
Date: Mon,  1 Dec 2025 21:26:33 +0100
Message-ID: <20251201202634.98188-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The following changes since commit 9ef49528b5286f078061b52ac41e0ca19fa10e36:

  Merge tag 'hw-misc-20251125' of https://github.com/philmd/qemu into staging (2025-11-25 14:22:39 -0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-20251201

for you to fetch changes up to 3bee93b9abf5509f1ac25909478dd52a724bf0c3:

  accel/hvf: Fix i386 HVF compilation failures (2025-12-01 21:21:16 +0100)

Spurious checkpatch.pl warning:

  WARNING: architecture specific defines should be avoided
  #49: FILE: accel/hvf/hvf-accel-ops.c:151:
  +#ifdef __aarch64__

----------------------------------------------------------------
Accelerators patches queue

- Fix HVF/x86 build
----------------------------------------------------------------

Nguyen Dinh Phi (1):
  accel/hvf: Fix i386 HVF compilation failures

 accel/hvf/hvf-accel-ops.c | 5 ++---
 target/i386/hvf/hvf.c     | 6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.51.0


