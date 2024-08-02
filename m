Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D7DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtg2-0002ZS-5m; Fri, 02 Aug 2024 10:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZtg0-0002VD-Re
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:54:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZtfy-0005Dv-CO
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:54:40 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc53171e56so5152335ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722610476; x=1723215276;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2wKnSaxwAurxqVOmTM00rPFAGyNfPCMfOr7fL121OPg=;
 b=r32HeYo46e05OUdqUYtxHgHNWZ9F+WhaB2HbXBy2cZWYUjZ4nJ/9F2AEV5v+3LSXAP
 Tk9uYNTCPWxNRG/eESvDnuqVhevOU5yikleRtZ2kTB3qraXC28rr4sqGhNU7g7VUbkdY
 EZurgW++wcqRmf3q9uwNaEIIES++V4fIhSd+sXZrqNQguJjYLXeNbWEU4OhD8oBnBK0Q
 X1DBVa2rHSW7J2p4E8DVv7/VoZwxPxLiQWhJN1kiYEWHPsJNSmg3ElSOY3OqBSuJcDc/
 sqF8isf2p9ROHwQgyDAd+TMcQqYzbdnpH7uJnrFsMYA5c4A32To+qR3STHPGyw39h8HX
 htwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722610476; x=1723215276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2wKnSaxwAurxqVOmTM00rPFAGyNfPCMfOr7fL121OPg=;
 b=Yydv69kuk3sD79/atVdbOPrxP4R6mzVXJp+sXplwuCtDqTcXjDqSuYntLXRmahqW0C
 GWVIZjuzvPUpbxtPvsnzmqZnIU2bchRyquVu2G2fQC6pCvqNI8TW9Z3R73DpLaqVqRxf
 mjaQm8glQsC6VGxJUKfE1ro/XhsiG2YXIUeeRvCLt3xdELEMbyJ0M45hCLQJKmGVSOC1
 GTpKjhZDtNq/MpttPJpQzhcpErf+gzNnh1qQpYjPki3wHHuHWuQCf+oT6iAQcPnavNfQ
 sdtk8MMebK5PE9sbR9rnk1aCAKCtuWl8r4GOcpikJDDEgkEwqqWLdfCb0UtTRWvPoNfm
 aAQg==
X-Gm-Message-State: AOJu0YwzdANZbX/az+hMoBCgFRY3w8wolgwE7nfiA7WfYTh2RpvBFiXu
 1RHnzNFKR7YUleyuqh8G0cweEXKEIviaxhhwr9cjEz/vYLmTE9zIvvC/SLfk2tTD5Bphzh216o5
 sjg4=
X-Google-Smtp-Source: AGHT+IFbG5Zb//fBxukt4QXHIaj+Gq2rUCb01AXDNSzEGv3MTrXwILzTFdx6PtKh9LU+U4Qy71TmUA==
X-Received: by 2002:a17:902:d502:b0:1fc:5cc8:bb1b with SMTP id
 d9443c01a7336-1ff57422457mr28400875ad.7.1722610476078; 
 Fri, 02 Aug 2024 07:54:36 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592aee19sm17920635ad.282.2024.08.02.07.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 07:54:35 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 0/5] qemu/osdep: add a qemu_close_all_open_fd() helper
Date: Fri,  2 Aug 2024 16:54:16 +0200
Message-ID: <20240802145423.3232974-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x633.google.com
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
v8:
 - Fix erroneous -1 added to open_max
 - Remove useless close_fd assignation
 - v7: https://lore.kernel.org/qemu-devel/20240731084832.1829291-1-cleger@rivosinc.com/

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
 net/tap.c               |  34 ++++++-----
 system/async-teardown.c |  37 +----------
 util/oslib-posix.c      | 132 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 50 deletions(-)

-- 
2.45.2


