Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BECC41513
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 16:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGLqQ-0002ur-CJ; Sun, 09 Jun 2024 12:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sGLqO-0002ts-BC
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 12:56:36 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sGLqM-0000vP-2W
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 12:56:36 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3759a6423efso2671215ab.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1717952191; x=1718556991;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1JUE/g4ebvpIHWoAmH1FKrzbhNlZWzvxo4KSx+uHc00=;
 b=SNVIVYhfV+aXMMFBL/FQL2wFWJFlL0MLIrQjFRS5XSj8aj4E2CeztIdf6wZjJ10RJk
 2YGsCiVsrGr1a25uYJQLa3rhuKVXAM+fH4qxC0hMsJZZN3JLco9G9QC1pReFiu5YVZF5
 uJk9O/cMUTaJbrmnwx6dDR/GopUGIIq7dI4TG2Av9MYCrvQebiVGPcD7TyLw4L8aKoEV
 9kCatHqHsrsFQJXRlSZDbPf1PWkVkiA573+F0wRQCLa+V+HNkdeYATFfhRepUASaqjsF
 eULXLxZaVJ2mv+XyJU6pB+23vkTOu2xsqVTBYazeYPHObPPZhaXBLkiDrxPtt1d8uEss
 IxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717952191; x=1718556991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1JUE/g4ebvpIHWoAmH1FKrzbhNlZWzvxo4KSx+uHc00=;
 b=N08iF58D0qnxjIco0iM8B90rQYCq+EcJf/EBCRd3xJ82ooZD41mDCSovr3pZmEORjo
 CIOr13NppgFiNRFpCap3gUy3JUsIQw3svvI+rjO0cjN5Kk9fbnUo9q1aa05fdAUA9HCd
 ZY6MhAGO5gr2PEyD3DNpj33ZFISwY1FQjy5DwSHx2W8jNWskYA8TsElyr6nBx38s6PXX
 6ZDBgXwQMUTLags3o0lz1y5T6QNBfbAOzxpMVjp8F5711fQ9fPfo5I/usJPVTpyYZuv8
 vHakRomV8z/3eDbf72g7TujbMYktgfWxCPLi4eAtne8FWhP7WZwlpZMO81KvNiLhpWDc
 +jkA==
X-Gm-Message-State: AOJu0YyoKXMz/sU6d+wUOeQJjjexobEG9bWYu4Oittqw2Ps4eA1IXiHr
 PXnlq2cFA/tTcohU8CkWilscRHig2rpypnSsQuQNcGJl7+XrMX2fWF7oPzq0ga50a3vS5VXU6I8
 yZoo=
X-Google-Smtp-Source: AGHT+IGcv+IE6eeIeBCQXK0ah1zY2/nTRkhucezO27ksvJXpeG6nHnwiHm+ljwHOttEfJ0b2Cf5EmA==
X-Received: by 2002:a05:6e02:1a45:b0:374:b252:243f with SMTP id
 e9e14a558f8ab-3758030d58dmr43181305ab.5.1717952191232; 
 Sun, 09 Jun 2024 09:56:31 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374bc1c82d4sm18891715ab.80.2024.06.09.09.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 09:56:30 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PULL 0/3] Bsd user misc 2024q2 patches
Date: Sun,  9 Jun 2024 10:55:54 -0600
Message-ID: <20240609165557.52555-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12c;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 3e246da2c3f85298b52f8a1154b832acf36aa656:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-06-08 07:40:08 -0700)

are available in the Git repository at:

  git@gitlab.com:bsdimp/qemu.git tags/bsd-user-misc-2024q2-pull-request

for you to fetch changes up to cb4c259052cbc5dd04c17d963c789360cb8fe340:

  bsd-user: Catch up to run-time reserved_va math (2024-06-09 10:30:25 -0600)

----------------------------------------------------------------
bsd-user: Baby Steps towards eliminating qemu_host_page_size, et al

First baby-steps towards eliminating qemu_host_page_size: tackle the reserve_va
calculation (which is easier to copy from linux-user than to fix).
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIzBAABCgAdFiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmZl3pgACgkQbBzRKH2w
EQBfpg//U4YdJAA0H4okwPtowP1wIK1gpWvVd5FIN17pCXLKT4FR4efhWeEnQh8U
+dXvkCpX/MnhBkStYoGZBmYe1rNKkEAn8BPCsQqX4y3af5RzKyKWo0gZXOjN3L9e
ixmeFcg/7BTwnSbcO02xd9BOPPaRiFBDSidh28gr/1sxpXRxlbQHzIUpTBncDaN6
4w5DnF+b1RFHCz05ytrP517cj7E32Ig9S/cVMmBd1pGJiLnHiOp/peMprCL6tnI+
YNBzttCbRPNH2z0zVd9En/hDnVirGPYX+LXg0Djkw3I+stJj4jwbJTuDG+5Lzghp
YrYfiU6x7OG9ywjFJgY1/pExVT1cwkNjuGCXL+F4R49R5LfIEHq5/MlQp+tjpYYO
g5WmpiLnFpFosmXIPJmxr16zqm2sLD+P0Jr/kdIz58fTWmIQeKwi/Vu/73h4kxST
vjBbhC3eg56lQDaospc4h8+RehmI6LdSWYx0kxv2JKpXH3lQPqsDSrOcm9hEbWYS
DeV++vkyQcXrbCnwomfxG1U+dVYBlJ1L1wClxc/1WD9KxXXJIwlvGmIu3o3c2+xj
BM6eRe3evWioqdqhc2lY+XxATwbIUxiect6ml+F6E0KJxlm3Ajqy6qw49G+uhZxa
XWUEIYGDd6/xHMlBeo6FKUpe/Ez/i3eCFXr4AD4iO7AtTuukrO4=
=3EaH
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Warner Losh (3):
  linux-user: Adjust comment to reflect the code.
  bsd-user: port linux-user:ff8a8bbc2ad1 for variable page sizes
  bsd-user: Catch up to run-time reserved_va math

 bsd-user/main.c   | 51 ++++++++++++++++++++++++++++++++++++-----------
 linux-user/main.c |  8 ++++----
 2 files changed, 43 insertions(+), 16 deletions(-)

-- 
2.43.0


