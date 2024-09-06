Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A834CE7AE0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTZQ-0008VX-Ew; Fri, 06 Sep 2024 03:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1smTZM-0008Dv-CB
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:39:49 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1smTZK-0000mm-6e
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:39:48 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f4f24263acso30455521fa.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 00:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725608383; x=1726213183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RPR2kr68hQ5IuQ8MG/HC4hDsIR2S1/2Up0H8R4bLH8o=;
 b=ESIZFvxoUZE7ysWzhpmFq1HdXdFa6y0i5il+Ew7o2FQkaB7j4GPIPQjGj/z+Ol5KrR
 n0DeXphxtgziFvLsAe20BA7m6wUPlvvvl+szGDvS+Djm4TOBkAxcUtg1d6cPAhC65ZkR
 hNXGnTJUp5DhYLqPl4ChS8Li/k/CmLvwO1Fwgji4vPjNkm6O6WBUfDU4AqyDN97qvj5M
 mxqfRKxDEDiO8FpGyH7bhllieP0nX6Hgglme9Q8GMTvXnQrs6DC6oj/iNXZey+HMH2h1
 d37fFZz2NUlv5re+BAld46b8iywSXSkxeQhDrHy9OsRLVVqTg99Fr7/jfs56keR6oFfL
 wSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725608383; x=1726213183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RPR2kr68hQ5IuQ8MG/HC4hDsIR2S1/2Up0H8R4bLH8o=;
 b=n6wKiBiJqrtKVwOccY4TYOLzUdm62nGLqBrJ6pTklOR0o7FycoV6KoDfjGmb2khU5j
 QWssXISClB2EGyEEqRPCiS9kVnMGX/McaO+1H5YRzHFi+VL9RFj1eLebP4BWpyyf6UdE
 IcvfvEgnT3MixQVy/nHv+kM/5qvUE+w4LuQawfREwj6LMFvrXWFVv2k/X5tzgR9hLpAS
 YfLIXuT0jfiB7Sqs7+y/wgKqaMsQuxUWwF3kvLLIZ5EXzAH/5IlQiyoB7kWpbXBQEwRO
 vukc7Sb0qSZ8A6Su0qOLapo7Wyd2wm3rzrfsx8MLdREQYGtINOZgeRxfVguSQE7+rP3j
 ikyQ==
X-Gm-Message-State: AOJu0YxYCUlWr6DH/Oa5bIwLAo73707TjDOeSIC15tTqZzuNZvyp3kFu
 LFxFbCAxfs6NjfP2JOy0hwLSYAM7Ia9t6YJjSCG+7LsJtrTrykfKyToXTmy8
X-Google-Smtp-Source: AGHT+IETe85ka54S0TIKo3HZaJTK26Nx7AUrUYVMuX166ma66k1yFtjMFF06X/n6Ow96R10thv4Eew==
X-Received: by 2002:a2e:a590:0:b0:2f3:cb70:d447 with SMTP id
 38308e7fff4ca-2f6108ad85amr247562801fa.40.1725608381727; 
 Fri, 06 Sep 2024 00:39:41 -0700 (PDT)
Received: from top.fritz.box (p4fdf9401.dip0.t-ipconnect.de. [79.223.148.1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8aeacb588bsm19904466b.78.2024.09.06.00.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:39:41 -0700 (PDT)
From: Michael Vogt <michael.vogt@gmail.com>
X-Google-Original-From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v4 0/1] linux-user: add openat2 support in linux-user
Date: Fri,  6 Sep 2024 09:39:12 +0200
Message-ID: <cover.1725607795.git.mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=michael.vogt@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is v4 of the openat2 support in linux-user. Thanks again for the
excellent second round of feedback from Richard Henderson.

The code is identical to the previous v3 and I only fixed two typos in
the commit message. I'm sending v4 because in v3 I forgot to add
"--threaded" when generating the coverletter/patch which makes it a bit
awkward to review and it does not show up properly on
e.g. https://patchew.org/QEMU/. My apologies for this mistake.

This version tries to be closer to the kernels behavior, i.e. now
do_openat2() uses a new copy_struct_from_user() helper that is very
similar to the kernels. This lead me to also drop incuding openat2.h
(as was originally suggested in the v1 review). It now contains it as
a copy named `struct open_how_ver0` and with that we can LOG_UNIMP if
the struct ever grows and qemu-user needs updating.

To answer the question why "maybe_do_fake_open()" uses a
"use_returned_fd" bool instead of just returning "-1": I wanted to be
as close as possible to the previous behavior and maybe_fake_open()
could in theory return "-1" for failures in memfd_create() or
mkstemp() or fake_open->fill(). In those cases the old code in
do_guest_openat() failed and returned the error but the new code would
just see a -1 and continue trying to open a special file that should
have been faked. Maybe I did overthink this as it's very
corner-case-y. Advise is welcome here, happy to change back or
simplify in other ways.

Thanks again,
 Michael

v3 -> v4:
- fix typos in the commit message

v2 -> v3:
- fix coding style (braches)
- improve argument args/naming in do_openat2()
- merge do_openat2/do_guest_openat2
- do size checks first in do_openat2
- add "copy_struct_from_user" and use in "do_openat2()"
- drop using openat2.h and create "struct open_how_v0"
- log if open_how guest struct is bigger than our supported struct

v1 -> v2:
- do not include <sys/syscall.h>
- drop do_guest_openat2 from qemu.h and make static
- drop "safe" from do_guest_openat2
- ensure maybe_do_fake_open() is correct about when the result should
  be used or not
- Extract do_openat2() helper from do_syscall1()
- Call user_unlock* if a lock call fails
- Fix silly incorrect use of "target_open_how" when "open_how" is required
- Fix coding style comments
- Fix validation of arg4 in openat2
- Fix missing zero initialization of open_how
- Define target_open_how with abi_* types
- Warn about unimplemented size if "size" of openat2 is bigger than
  target_open_how


Michael Vogt (1):
  linux-user: add openat2 support in linux-user

 linux-user/syscall.c      | 116 ++++++++++++++++++++++++++++++++++++--
 linux-user/syscall_defs.h |   7 +++
 2 files changed, 119 insertions(+), 4 deletions(-)

-- 
2.45.2


