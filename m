Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE8BE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzY-0004iU-5M; Thu, 09 Jan 2025 12:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzG-0004go-HU
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:27 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzE-0006xv-Pw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:26 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaf8f0ea963so235339566b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442382; x=1737047182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xev3MylNica8tJvKDRxAEt4qG+psA/6bp/Uvkw9USTg=;
 b=Fc0GDnwe1mGDi8RPIsBYJqciuPFW5XrFEUGJiLf7xK3Rtr21WxRy89VxV4ypBpuq8N
 UmY6j30W3FU7IlaF+VluTP+VrPYKwdJHUgPVanyuL1c6NsSWWvo0sUMkoYyOf3Lz1SIi
 d2v/Y7a5c6QYcyQ/TPqKnLKiPEuwYyFjb20uGy28kqaN//1ZZvSLDPU9RbWXI3tekSuv
 05c4TG7WlKZi+j98VkXNhEC3aEsN48MP5j2Fsum1sT/b7k0/XQ9TyBWQDeb8uLLb5Zqt
 zZwQiT3YfPBV1HtVcGMElb5clQoaK34qCgy4tosdjQUR6oBivnQ98UM0Oi+Li91jZokT
 KFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442382; x=1737047182;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xev3MylNica8tJvKDRxAEt4qG+psA/6bp/Uvkw9USTg=;
 b=FIUsB0TPejBSueNBaaw0R8us65A+5wqRNcZUuaKi3fKBz68L0cUw2Wq8TPsoP3lhIm
 UOCOHRwsLUTrcONM91Sc3ajwAlB7Zj5WEw6HGxO7Zm7ZZIYbyLILbaQ03aRy9VVvs49W
 Rx0w/YM+qj099n7Sn1nt+SkNqMJ/TsqLDs76h3X2KZ8EU51rw/5FEfIyOrjhhHEKilFt
 svxk8jpOBhSjltdhDBGc4gTsFeZGFeCir9XfTttNtNQ4xN86pfIGpDquIT3xkqL5rJJC
 oQ3Eu0n2NQiH06XXDg8G5aEpTL/+YHeUiMsnBhd8oVg/mSFo1nu85lr3WNXob+yLCo8f
 qvOw==
X-Gm-Message-State: AOJu0YwgzMUY9t7VCQF2LqXQSxcwDG2h/M0AHUAM8w3eTkYkDvtrq82s
 ZNmOqrsh+qzLy3IciT649bHI2gQpZ02hfY2JK4yYV9IQDu4oJ2m6Fs0QWdAeXco=
X-Gm-Gg: ASbGnctQjmkn4t4K5g+H0X5NrLnK2+m6BiDeMbApsCteS0vWwxakZ6e6Y7vS9JjRxXT
 vYYiXbJg9lSpVzviuQ7czY9Mf/U3InqqKjHlTYa4ugOfa2npwEqQ26scm2PRGvczwwD+2NBT655
 nev9bPdifhOvO6+jRNC3L6P75ymcV6SazZpcaoRCZJStqaExXD8TvP/B9ne/1Prn8x5I5h3L01P
 5de8o7pZx2PMb3xU9AQXM1R80XgBv+UMw6SgEwiB7YlMhoWn/UgZu0=
X-Google-Smtp-Source: AGHT+IHla8n15db7gTAgCexyIBdayUFuYT1+cTj3mhUm1d7JbJgTCzsxtGvGDI4jVa6NKS+fHKCuRw==
X-Received: by 2002:a17:907:1a4e:b0:aaf:f32:cce8 with SMTP id
 a640c23a62f3a-ab2ab6f3481mr478807366b.30.1736442382426; 
 Thu, 09 Jan 2025 09:06:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9646be5sm89611666b.174.2025.01.09.09.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C9BC25F75D;
 Thu,  9 Jan 2025 17:06:19 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 00/22] maintainer updates for jan '25 (semihosting, gdb,
 plugins)
Date: Thu,  9 Jan 2025 17:05:57 +0000
Message-Id: <20250109170619.2271193-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

This covers my remaining trees outside of testing/next and is mostly a
consolidation of patches I've pulled from other people.

For semihosting:

  - a bunch of cleanups from Philippe to aide single binary builds

For gdbstub (touches system/vl.c as well):

  - propagate *Error to setup functions

Ilya, I know about [PATCH v4 0/9] gdbstub: Allow late attachment and
will look at that later. I didn't want to delay the rest of my reviews
fighting with a messy re-base. If you are up for it you can post a
branch on the thread and I can potentially merge from that. Apologies
for the rug-pull between v3 and v4.

For plugins

  - mostly fixes from Pierrick
  - a speculative fix for cpu_io_recompile() case exposed by Julian's
    discontinuity patches.

Most are already reviewed, the following remain:

  accel/tcg: also suppress asynchronous IRQs for cpu_io_recompile
  system: propagate Error to gdbserver_start (and other device setups) (1 acks, 1 sobs, 0 tbs)
  system: squash usb_parse into a single function
  system/vl: more error exit into config enumeration code
  semihosting: add guest_error logging for failed opens

There will likely be a v2 anyway once I've got testing/next merged and
Ilya's gdbstub patches. I don't think I have anything else pending but
do shout if there is.

Alex.

Alex Bennée (5):
  semihosting: add guest_error logging for failed opens
  system/vl: more error exit into config enumeration code
  system: squash usb_parse into a single function
  system: propagate Error to gdbserver_start (and other device setups)
  accel/tcg: also suppress asynchronous IRQs for cpu_io_recompile

Philippe Mathieu-Daudé (6):
  semihosting/uaccess: Briefly document returned values
  semihosting/syscalls: Include missing 'exec/cpu-defs.h' header
  semihosting/uaccess: Include missing 'exec/cpu-all.h' header
  semihosting/arm-compat: Include missing 'cpu.h' header
  semihosting/console: Avoid including 'cpu.h'
  semihosting/meson: Build config.o and console.o once

Pierrick Bouvier (11):
  tests/tcg/plugins/insn: remove unused callback parameter
  contrib/plugins/howvec: ensure we don't regress if this plugin is
    extended
  tests/tcg/plugins/syscall: fix 32-bit build
  tests/tcg/plugins/mem: fix 32-bit build
  contrib/plugins/stoptrigger: fix 32-bit build
  contrib/plugins/cache: fix 32-bit build
  contrib/plugins/hotblocks: fix 32-bit build
  contrib/plugins/cflow: fix 32-bit build
  contrib/plugins/hwprofile: fix 32-bit build
  contrib/plugins/hotpages: fix 32-bit build
  configure: reenable plugins by default for 32-bit hosts

 configure                      | 21 +-------
 include/exec/gdbstub.h         |  8 ++-
 include/semihosting/console.h  |  2 -
 include/semihosting/syscalls.h |  1 +
 include/semihosting/uaccess.h  | 55 +++++++++++++++++++
 accel/tcg/translate-all.c      |  5 +-
 contrib/plugins/cache.c        | 18 +++----
 contrib/plugins/cflow.c        | 17 +++---
 contrib/plugins/hotblocks.c    | 29 ++++++++--
 contrib/plugins/hotpages.c     |  6 +--
 contrib/plugins/howvec.c       |  7 +--
 contrib/plugins/hwprofile.c    | 27 ++++++----
 contrib/plugins/stoptrigger.c  | 48 +++++++++--------
 gdbstub/system.c               | 22 ++++----
 gdbstub/user.c                 | 20 +++----
 linux-user/main.c              |  6 +--
 monitor/hmp-cmds.c             |  2 +-
 semihosting/arm-compat-semi.c  |  1 +
 semihosting/console.c          |  3 +-
 semihosting/syscalls.c         |  2 +
 semihosting/uaccess.c          |  1 +
 system/vl.c                    | 99 ++++++++++++++--------------------
 tests/tcg/plugins/insn.c       |  4 +-
 tests/tcg/plugins/mem.c        |  6 +--
 tests/tcg/plugins/syscall.c    |  6 +--
 semihosting/meson.build        |  9 ++--
 26 files changed, 243 insertions(+), 182 deletions(-)

-- 
2.39.5


