Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9A0C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 13:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYmum-0003WW-06; Tue, 30 Jul 2024 09:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYmuV-0003Uw-Ey
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 09:29:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYmts-000553-Lk
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 09:28:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42111cf2706so3857885e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 06:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722346032; x=1722950832;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ahoz0KIOaZ5paltn37jRDo8tt6b6VcG4doV39F7NN2A=;
 b=BUg40VSQt4gBGb4NR0NiXHzqIVOZVOSDLEAz8aAjMPan5Y5Zh/bgnX8SLNjNM8/ipo
 k+gQ2PKrtAB/HNGuIoKP/BZ/hJ98rjqkErAZZGVt8zcsl86zLmAcBER9RR/TyFxJbgd1
 PjbMCtfsIr7NdgSvGh+2F12gK8JR3ArXjuUwOb2CdEXczXHuthMjsWo3xVMFXXRIgY8o
 vlR6iWR2Ot2/P5nYTkqHdnabxodW5tVp2uoO13d16LhkotvQq/vahyIoT7D1WuMmYvcQ
 vzWYk5bruBmCSUFZcdeQX4ySRab5tCDjA46zgHqNWyQ/gQmK66fME/cWGZiTPpDGLM0N
 zFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722346032; x=1722950832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ahoz0KIOaZ5paltn37jRDo8tt6b6VcG4doV39F7NN2A=;
 b=EBZTnZuaAy5Wuh9VRCZrP5BWBcVujPVJGeYJ8GRVqGqntnOGfeZc20wMQYOOf7qnxw
 xF2FDTns/9SqTnN/sgN8Nau6Zq/0T+oVhu14DHxTrFWfqR42D3uL4qObGB/Kc0UgQ1Lf
 t7DE6UqTF55v/dZ2y92vT7gRtDQ2wdW0vT36DkZ8UzCQ3s+TtU5WrLdrjj1JPt2d9RUR
 G/bcqvXcF02ya8e8jQgmQpolOkk04Ejeen2ebqBKZQWs5X9E51VwQ8/t374xEITx0lXE
 J52prvs/Y2hQXbptiPBGxXFoqT9AEqIuICMMS9waaiu0yV6PaE4Ge0sa8kML6fmfcKls
 GyaQ==
X-Gm-Message-State: AOJu0YwnTrVuWxGXjeWQ5mpITzlI1Ub5XHVe1cSqr4wKm/xg/uZpIfOA
 40Ps/GtrArQsz7hxEqLkf5tEZgW9Drijypuwk80Llyb9Wpr0f0wTQmZ6tmqfWu3/6h5OVivezch
 7sZ8=
X-Google-Smtp-Source: AGHT+IEJ9rjVOH8ljCFqeTfMaPL3QUsTDE1LcsSQO5sOuIjHhWJdR3Jxt7SRPJg4BRIUG2jtZyPS8A==
X-Received: by 2002:a05:6000:18ab:b0:367:90a8:4d3b with SMTP id
 ffacd0b85a97d-36b34bf2d44mr7252294f8f.3.1722342280988; 
 Tue, 30 Jul 2024 05:24:40 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14577757f8f.106.2024.07.30.05.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 05:24:40 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 0/5] qemu/osdep: add a qemu_close_all_open_fd() helper
Date: Tue, 30 Jul 2024 14:24:23 +0200
Message-ID: <20240730122437.1749603-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
POSIX"), the maximum number of file descriptors that can be opened are
raised to nofile.rlim_max. On recent debian distro, this yield a maximum
of 1073741816 file descriptors. Now, when forking to start
qemu-bridge-helper, this actually calls close() on the full possible file
descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
takes a considerable amount of time. In order to reduce that time,
factorize existing code to close all open files descriptors in a new
qemu_close_all_open_fd() function. This function uses various methods
to close all the open file descriptors ranging from the most efficient
one to the least one. It also accepts an ordered array of file
descriptors that should not be closed since this is required by the
callers that calls it after forking. Since this function is not used
for Win32, do not implement it to force an error at link time if used.

---
v6:
 - Split patch in multiple commits
 - Drop Richard Henderson Reviewed-by since there was a lot of
   modifications
 - Remove useless #ifdef LINUX in qemu_close_all_open_fd_proc()
 - v5: https://lore.kernel.org/qemu-devel/20240726075502.4054284-1-cleger@rivosinc.com/

v5:
 - Move qemu_close_all_open_fd() to oslib-posix.c since it does not
   compile on windows and is not even used on it.
 - v4: https://lore.kernel.org/qemu-devel/20240717124534.1200735-1-cleger@rivosinc.com/

v4:
 - Add a comment saying that qemu_close_all_open_fd() can take a NULL skip
   array and nskip == 0
 - Added an assert in qemu_close_all_open_fd() to check for skip/nskip
   parameters
 - Fix spurious tabs instead of spaces
 - Applied checkpatch
 - v3: https://lore.kernel.org/qemu-devel/20240716144006.6571-1-cleger@rivosinc.com/

v3:
 - Use STD*_FILENO defines instead of raw values
 - Fix indentation of close_all_fds_after_fork()
 - Check for nksip in fallback code
 - Check for path starting with a '.' in qemu_close_all_open_fd_proc()
 - Use unsigned for cur_skip
 - Move ifdefs inside close_fds functions rather than redefining them
 - Remove uneeded 'if(nskip)' test
 - Add comments to close_range version
 - Reduce range of skip fd as we find them in
 - v2: https://lore.kernel.org/qemu-devel/20240618111704.63092-1-cleger@rivosinc.com/

v2:
 - Factorize async_teardown.c close_fds implementation as well as tap.c ones
 - Apply checkpatch
 - v1: https://lore.kernel.org/qemu-devel/20240617162520.4045016-1-cleger@rivosinc.com/

Clément Léger (5):
  qemu/osdep: Move close_all_open_fds() to oslib-posix
  qemu/osdep: Split qemu_close_all_open_fd() and add fallback
  net/tap: Factorize fd closing after forking
  qemu/osdep: Add excluded fd parameter to qemu_close_all_open_fd()
  net/tap: Use qemu_close_all_open_fd()

 include/qemu/osdep.h    |  11 ++++
 net/tap.c               |  34 ++++++-----
 system/async-teardown.c |  37 +-----------
 util/oslib-posix.c      | 128 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+), 50 deletions(-)

-- 
2.45.2


