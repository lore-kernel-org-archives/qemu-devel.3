Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B25606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GLEuxl79
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPMLL-0002X7-Ja; Fri, 06 Nov 2026 10:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPMLJ-0002Wo-Lg
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:59:05 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPMLH-0001W5-S1
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:59:05 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so6938765e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 07:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793980741; x=1794585541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=739Me1zY6AmuhNddeuGC7tZaXrrDNULlLnoAVIHqTg8=;
 b=GLEuxl79qdZwQG/bGHkuXYeHDqPehUaLaKigAak43LgKMZqIu4gHDaKD/gmNEr3psL
 Gl4Nnd9b978dTBAboBUZvoUKZqOl9amnYL+T1yjp1l8uqA59/BnNugMNIpNOOZyr/33H
 IS20cWFDLKKW3LLAYwxv9lqXqu5grNtTmoVkHDscxBbO8O2PBr5Nkk+T1+dB1UfFlGKz
 Av3NGs43VMTXCVntvYlKDp3q+6Zk4z1o5oGOZVQ1cezMbPq4CrlWakuPUi8iX3qSw0QZ
 47+xjB8cOx7OpiROSyYfigGftR4j9/RBpy2dgV9vkWZh2xq8dIiPXq088D2qOLW0fCEX
 uA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793980741; x=1794585541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=739Me1zY6AmuhNddeuGC7tZaXrrDNULlLnoAVIHqTg8=;
 b=mWsUhtg9JCPhXZYbg7Kq+gX5webkdcrqytzXT8F+5MPkq3Pwcz6NEY/uVY7M/qRdLg
 sgcTDOuffH3eRCizW5fA1cxkxWgdxKemTipJnMmx7MtjEEJ0LV8sFNu4ODIXKbhzcxe3
 lBYyFJVpLaeTMpDgIljL7mVNxp1/p5hn0EjwNv1hSjXuSTKJGTjkJ+zjHsSkjaqUKa2p
 3CyS3JZIXAo5KpQmjg8mKpWgbryegP8Wf5sl/T5L77MB+YnHpEkoqhFEPi0HUoeMfj/Y
 OFoj3lhhhwp0232TXsYsqPXx+FaAglVH35u90X1JX6z80mmtG736OCGDNseKh0JrB8fF
 9bWw==
X-Gm-Message-State: APuU4Z9ClOjAGf+BsvLwE9iPJlObRZVYzOoZ6LfMe+y2AXPFFjZAuOwC
 n5lOWNo+3qpXJyW42TNLMfFQj+8EIJT/628sThxP2ItEF67aN7c8yeDs2KkU1bIwkdeQIk1yjW6
 qTfN51QM=
X-Gm-Gg: AYBFou0uFIBHQScU9cFOmSwsg8ssFaNup0QWW432MBzZugWWXu303Vq5oHS/8vgtaZ0
 7UorWH+ZQYj7n4xKFIKWNzSeACCKezp8C0T3IHA59QefwWqUu57pCOushJd1Q9ZnKmN1dWVQfwJ
 lm3al5wqKUJTfom8KhVN+uBTsxIKkKFtzJaeC+yuSSQYFugBM6IS5wBfXcwbzreb7Y3ESkNStzK
 4etT32j5JPjpvo0QbUQi4Gti8o+nGtTwfbHLNZkuKf79gCSJs12xgDEE8edYr3eVptHw1NTRjEN
 coX/rPCcbwHyF54lt2OXTvKpnOquxuWiq3Bycn3PfGlBgLYlV6cu0Pl2YhDEpcIgsHhhXe3OdVr
 tLVcR4WLDQm/QRk8DXq30t6anJPwlnloPi+rj4BaCJQY6zPc0zkw5WMM82m7znsfHeulmXD1+1y
 r3ctBlrPjSPqUU6MeGJgUHDwVfk8UZtFOOUO5Z8CXU+Is64Y1yCnVZLw+G1zyK38Ft601p+utrH
 kqMuBOgrsxtjJQcWM92Bjt6ELrkaUPVsh2tfVBoPV6QWo6P1zsO76Vw2paBZbQmaQYvdw0Tco9B
 2FF1CqHHiwuZDCUpoaXRFC9Lr8pa90e0q+WPfF0pZc0rKH8mm1O3SOX+c0Q1PoPHMAmxEbrKdVh
 4ktTd3jBTIqv+px9IUt+0e/RT+vuJ9KOVeQ==
X-Received: by 2002:a05:600c:1913:b0:4a2:1398:dd05 with SMTP id
 5b1f17b1804b1-4b6de0ce791mr51203785e9.16.1793980741029; 
 Fri, 06 Nov 2026 07:59:01 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e168f331sm80661395e9.3.2026.11.06.07.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 07:58:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>,
 "John Snow" <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Philippe Mathieu-Daude" <philmd@mailo.com>
Subject: [PATCH 0/2] meson: Revert recent changes to qemu version header
 handling
Date: Fri,  6 Nov 2026 15:58:56 +0000
Message-ID: <20261106155858.3779237-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patchset is two git reverts, to revert ab78ac76f44a124 and
fc35f24387703da. Those commits try to move the handling of version.h
to entirely within the meson file with no external script, but
unfortunately if you do that then there is no dependency information
about it passed to ninja, so the file isn't recreated if it's
missing. In particular this breaks incremental builds from a build
tree that pre-dates those two commits.

There's been some on-list discussion:
https://lore.kernel.org/qemu-devel/20261105181449.1691-1-luoyonggang@gmail.com/
Since it's not clear how we want to proceed, I'm posting this as
the "revert to the situation we had before", so we can discuss
what we want to do with a bit more leisure.

thanks
-- PMM

Peter Maydell (2):
  Revert "meson: rewrite scripts/qemu-version.sh directly in
    meson.build"
  Revert "include: introduce qemu/version.h"

 meson.build                          | 29 +++++++++-------------------
 include/qemu/version.h               | 20 -------------------
 bsd-user/main.c                      |  2 +-
 linux-user/main.c                    |  2 +-
 monitor/qmp-cmds-control.c           |  2 +-
 qemu-img.c                           |  2 +-
 qemu-io.c                            |  2 +-
 qemu-nbd.c                           |  2 +-
 qga/main.c                           |  2 +-
 scsi/qemu-pr-helper.c                |  2 +-
 storage-daemon/qemu-storage-daemon.c |  2 +-
 system/vl.c                          |  2 +-
 tools/i386/qemu-vmsr-helper.c        |  3 ++-
 tools/qemu-vnc/qemu-vnc.c            |  2 +-
 util/module.c                        |  2 +-
 scripts/qemu-version.h.in            |  1 -
 scripts/qemu-version.sh              | 25 ++++++++++++++++++++++++
 ui/cocoa.m                           |  2 +-
 18 files changed, 49 insertions(+), 55 deletions(-)
 delete mode 100644 include/qemu/version.h
 delete mode 100644 scripts/qemu-version.h.in
 create mode 100755 scripts/qemu-version.sh

-- 
2.43.0


