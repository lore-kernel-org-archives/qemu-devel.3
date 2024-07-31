Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58130C52D1F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ50j-0002Go-UB; Wed, 31 Jul 2024 04:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZ50i-0002Fb-Ic
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:48:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZ50g-0004bN-BZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:48:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42803adb420so5040355e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 01:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722415715; x=1723020515;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v4mmQHwPaD07LzZb8IvPYojIZcb5y+tHYD9gzQ3D4lw=;
 b=DObRMgEtFyBIGNhZNbrYARSVwwTwevDaF9U3x/w3gA4TMFPLmW/oU8TdcMw682QAvS
 q7R96QstVUO3R/wWYDYs4y9uzYF2YH5uVE/JQ6VlSpeSRnk3yPuk+HImQRCZfWPV4QUO
 q34+DSpzdqDZ0CjULj4A61wr3cW2ifORP5M81oau7Nt3f3z4iMBbX7NZR7Z/2/XfA4YF
 pT9MY5++UQC2tGDZtjCcxVJ3s92e23FubvgyhyzFNhY1Vs7Rt7wARIlWsMhl8dDJxVaR
 8nRLAp9WM2K8/aHhp2Muhv2PMc0B76m0omib++x2wuX0L2jVK2zMqVnlSjCMTEDoScnC
 rBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722415715; x=1723020515;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v4mmQHwPaD07LzZb8IvPYojIZcb5y+tHYD9gzQ3D4lw=;
 b=ZVDkWSQJMK13PWnE0Qcd242n+Il8j23w8KTP14GSpCBV0k/gmrYXiLXRj7UZr7mqVB
 EXkpDSV9PNB6U8t4xso7wjQKEhRGa8nypD1BVFX4L54tsQXRVvzdFAt5q/CngPS/XF5b
 DRa1coZFzRzzoPPRDAevHIOjU/mHHhhRvDaPkZIErOKMznkw9HdQEZxMinRdSfQzVXXt
 2kTnTR75gRuIOlu1sU2T/p7UQr0PULQcEhQPUsJFXJdjMpWDmiXZFHNbTX0fwo7IUw+e
 DKAxCRJQX0BfeNzfGtDq2h/Xqfa4hfIrozNf+fUWm8BNOq9cV39srhA2bHaT7kW6zu5h
 DxGQ==
X-Gm-Message-State: AOJu0Yz5+jJ6Bf12Cx4c9ec3xRWHdoKdeG2MrZTkS5Drqr9nxqPtpe4h
 KzxQuBBMm2D3/jV2qZG1wNz1OnJbepiwAIXkGNosz98NtzNwPAUcX6Re0Rd1zhN1Z9Kx8gRXJpw
 ntVs=
X-Google-Smtp-Source: AGHT+IHLqoT+7MAo3PJkhvTIBspvMt+NQaccAenIMQRxZoiyhhIdHPgi5sYyK1FrMkteJxmS8dcCmQ==
X-Received: by 2002:a05:600c:1f85:b0:426:6358:7c5d with SMTP id
 5b1f17b1804b1-4280550cf89mr87606485e9.4.1722415715216; 
 Wed, 31 Jul 2024 01:48:35 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0344sm16576425f8f.2.2024.07.31.01.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 01:48:34 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 0/5] qemu/osdep: add a qemu_close_all_open_fd() helper
Date: Wed, 31 Jul 2024 10:48:24 +0200
Message-ID: <20240731084832.1829291-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

v7:
 - Passed open_max to qemu_close_all_open_fd() subfunctions
 - Remove extra whitespace
 - Reduce some variable scopes
 - v7: https://lore.kernel.org/qemu-devel/20240730122437.1749603-1-cleger@rivosinc.com/

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
 net/tap.c               |  34 +++++-----
 system/async-teardown.c |  37 +----------
 util/oslib-posix.c      | 133 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 165 insertions(+), 50 deletions(-)

-- 
2.45.2


