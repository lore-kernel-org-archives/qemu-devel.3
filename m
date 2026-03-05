Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7C2F47CD4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFfy-0006X6-Qm; Thu, 05 Mar 2026 15:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFfx-0006Wd-Cz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:05 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFfu-00065B-Gc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:05 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-89a0d53f3d1so36569046d6.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743921; x=1773348721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GVUe9ppeL28hfvk2q1FZ1GWr8G4UpRCv4iXib+1mPW0=;
 b=cvDFPj/fhbU0oGI4kunNaDTxEasZaiFr8o4bGRMnqjzlgDLrT5sntUOjA4z6D56yFi
 pS6PHhuYo/1yU6hbAaXOFTEfmL1PLGU/xtAM5hvJxKZGz5eUPEU5GjwlEDHuYfLM4yMC
 HanRpkcIph1bQWujLK9LT3k//7iOlP3/EjurWQgIUoRbWQsD+2OSoirZf4V8dmJBQ3CW
 iC1nfSf+mQkiiHppvqN/NCjXy1KeA2ul4+L5gqAecI+i6LtQK7cjj9AjT8NBn16cPYDs
 OdZNggZLAGPUln68/byKWk1mg1EvSuCIfy0EBXpBM0A5sMo5KvxnFAJI4/itDO9rlBX7
 mD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743921; x=1773348721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVUe9ppeL28hfvk2q1FZ1GWr8G4UpRCv4iXib+1mPW0=;
 b=d6FPiSKHFFZK8jBQeDmpZOiIHkfQueEdncCJdxFThqQMbl2Tv4wBgflGUPzJvEj8hu
 evIIVNDoA3PdUxmDn9jhX3V7y3P6yO1wYzeayGD57SmSk57c4ykzz6Fpmq4s6j+olwpU
 eujQTf9e1BY03YzAPtsHG2BTTa4hhW0lMs14WCkQvFrDWswvmUiYBpr/YhH3kqRghfMB
 8GMDJq3BMvpABS2Y/sVALf6elR+wOs8FdpcAZEac5JGAA9E9hE4FYxVcgY/U2lTY+3wh
 g7TRawBazCYyAcfcdfG9tMkpD8cRYeUXBLaCWeklO6dLzE6VfcQ8o2nXR1rWUULmRvRD
 AdWg==
X-Gm-Message-State: AOJu0YxpcRBnc+7XkYLnne+1071sdjfgQJZEtv99jMbSYgyCk3yFI+kh
 qipkQ0iJDyYzATDL5UoDxmibE2Y7aqdclKUk84zYWRmjE9PogIVmobCCPZk0wJxr0DQt8rRjlLx
 ThsCU
X-Gm-Gg: ATEYQzwidcCn4rAszkDYXHOEI6atPgA225zVvXFQDUPj3v7LzuK0cmpOOI3DRiJh2jv
 Ms1XsHPpmdfx3xTfsgF2e3hSffVCHrkChRDxjE0eZhXbOLwALW15ZHRmvxS3tUjqJoiIVX415Wn
 frElTiSIICubkvLifL/ZEedmJCJw2Fzv4TFmT0HXcLBONli7EoJydjdcORRnFgl6DADjMqObYZH
 UOo+KK85j84y0NDk9auMGLOauOnqizJinQWq0cICSffwvenhWCZlT5jf1kKnR7e7wh4s30i0rE5
 pe3VzeBdDAdwyNh9rhk+PkKiGo57LfLGwqDm5uzhS0Sw8bwYNDbFayd8XT2FsybriRS0j5ywj/X
 dFKSYmuDEO8zWWJocW2zsKkZp9N/PyquLRDTRO561hMsEoEu1Xbs2OKw5BLtwCHBIidE/5eDk6H
 2WP/q7l7MU3Lx49T91UTayT9PJgHdjL0XNhrbre7UWmsmIxZF66WblEKPXQkxc1K3WFBUe6ZsRX
 HT1
X-Received: by 2002:a05:6214:f01:b0:899:ad51:fb64 with SMTP id
 6a1803df08f44-89a19aee9ebmr111842336d6.41.1772743921182; 
 Thu, 05 Mar 2026 12:52:01 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:00 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 00/12] Plugins update 2025-03-05
Date: Thu,  5 Mar 2026 12:51:40 -0800
Message-ID: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf2a.google.com
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

The following changes since commit 314ff2e07ddc6163554077d68aed5d76a50b8e3d:

  Merge tag 'pull-request-2026-03-05' of https://gitlab.com/thuth/qemu into staging (2026-03-05 16:58:20 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260305

for you to fetch changes up to aca77dfd90c8a17a2b3526c5cc871cc410357a5f:

  tests/tcg/plugins/patch: Free read_data in patch_hwaddr() (2026-03-05 10:54:09 -0800)

----------------------------------------------------------------
Changes:
- [PATCH v7 0/8] Enable PC diversion via the plugin API (Florian Hofhammer <florian.hofhammer@epfl.ch>)
  Link: https://lore.kernel.org/qemu-devel/20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch
- [PATCH trivial] plugins: add missing callbacks to version history (Florian Hofhammer <florian.hofhammer@epfl.ch>)
  Link: https://lore.kernel.org/qemu-devel/c4ecefb4-8769-403f-8420-8bce42e43e13@epfl.ch
- [PATCH 0/3] tests/tcg/plugins: Fix sanitizer issues (Peter Maydell <peter.maydell@linaro.org>)
  Link: https://lore.kernel.org/qemu-devel/20260305161531.1774895-1-peter.maydell@linaro.org

----------------------------------------------------------------
Florian Hofhammer (8):
      plugins: add flag to specify whether PC is rw
      linux-user: make syscall emulation interruptible
      plugins: add PC diversion API function
      tests/tcg: add tests for qemu_plugin_set_pc API
      plugins: add read-only property for registers
      plugins: prohibit writing to read-only registers
      tests/tcg/plugins: test register accesses
      plugins: add missing callbacks to version history

Peter Maydell (3):
      tests/tcg/plugins/mem: Don't access unaligned memory
      tests/tcg/plugins/mem: Correct hash iteration code in plugin_exit()
      tests/tcg/plugins/patch: Free read_data in patch_hwaddr()

Pierrick Bouvier (1):
      plugins/core: clamp syscall arguments if target is 32-bit

 MAINTAINERS                                        |   1 +
 include/plugins/qemu-plugin.h                      |  22 ++++
 linux-user/include/special-errno.h                 |   8 ++
 linux-user/aarch64/cpu_loop.c                      |   2 +-
 linux-user/alpha/cpu_loop.c                        |   2 +-
 linux-user/arm/cpu_loop.c                          |   2 +-
 linux-user/hexagon/cpu_loop.c                      |   2 +-
 linux-user/hppa/cpu_loop.c                         |   1 +
 linux-user/i386/cpu_loop.c                         |   8 +-
 linux-user/loongarch64/cpu_loop.c                  |   5 +-
 linux-user/m68k/cpu_loop.c                         |   2 +-
 linux-user/microblaze/cpu_loop.c                   |   2 +-
 linux-user/mips/cpu_loop.c                         |   9 +-
 linux-user/or1k/cpu_loop.c                         |   2 +-
 linux-user/ppc/cpu_loop.c                          |  10 +-
 linux-user/riscv/cpu_loop.c                        |   2 +-
 linux-user/s390x/cpu_loop.c                        |   2 +-
 linux-user/sh4/cpu_loop.c                          |   2 +-
 linux-user/sparc/cpu_loop.c                        |   4 +-
 linux-user/syscall.c                               |  16 +++
 linux-user/xtensa/cpu_loop.c                       |   1 +
 plugins/api.c                                      |  42 ++++++-
 plugins/core.c                                     |  50 ++++++--
 .../{ => plugin}/test-plugin-mem-access.c          |   0
 tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 134 +++++++++++++++++++++
 tests/tcg/plugins/mem.c                            |  95 +++++++--------
 tests/tcg/plugins/patch.c                          |   2 +-
 tests/tcg/plugins/registers.c                      |  79 ++++++++++++
 tests/tcg/plugins/setpc.c                          | 105 ++++++++++++++++
 scripts/qemu-plugin-symbols.py                     |   9 +-
 tests/tcg/arm/Makefile.target                      |   6 +
 tests/tcg/hexagon/Makefile.target                  |   8 ++
 tests/tcg/multiarch/Makefile.target                |  17 ++-
 .../multiarch/{ => plugin}/check-plugin-output.sh  |   0
 tests/tcg/plugins/meson.build                      |   2 +
 35 files changed, 555 insertions(+), 99 deletions(-)
 rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
 create mode 100644 tests/tcg/multiarch/plugin/test-plugin-set-pc.c
 create mode 100644 tests/tcg/plugins/registers.c
 create mode 100644 tests/tcg/plugins/setpc.c
 rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)

