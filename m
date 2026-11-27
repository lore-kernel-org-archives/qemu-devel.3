Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12983606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mPFRJ5CP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxBy-0006c9-AW; Fri, 27 Nov 2026 09:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWxBu-0006WW-Ca
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:44:46 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWxBq-0002Sy-QT
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:44:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so53281815e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795790680; x=1796395480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DMDvad8uu9h3BkYC3lcUplhi2Nx8OtptLyxDGc2Cboc=;
 b=mPFRJ5CPlmeBgUQ2b6ttYXxu8NL5LYRHaFE6GuQ/nASdDCgO8TnqhgMHiFtaV1hbId
 mdzD+vx8qvMorxhcvkjIRFpD4Lcahmr11MOIIOLqdCyvps8xVZA1gdStIwgBYm4LKOoM
 +Cr0a4gTlBD/88ctUdUAO1PVAKwXg8WnZcEvSWu0SiYGxrrLZ9HROR52Y7wIxlAroDMC
 G/BtlVAfkZTSZocAHXWTUJ4v3IBzvUZ6DcaITa4rcaTsDq9KlMFLuXFRhTgRnhqj1LJ7
 XMA75OMt5KyzYkpaZcoCDVTs0pBihrfsK8GjxINg4CClPNFs+xjv14fdBessfdiCT+K+
 jn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795790680; x=1796395480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DMDvad8uu9h3BkYC3lcUplhi2Nx8OtptLyxDGc2Cboc=;
 b=l/IAWMl8xIZQsFuShsYSb0wkZfaYJ8gIhet2IbITVcQMhQl98xsuNUW1t+aJHQGa+I
 W/Cjiou2bqB2wrs13qBNEVZGQzVOlLGT2Nn+cbEzT/XDwCnPPXiakGsc5I9XMy31pp1s
 boqDVNilC/LMXcNEGv7HmeKd1yi+Y8wzfeP/ZA9X9tloxolvxhL5w2Gbbh4tDZpYFWlg
 H3GIX/3ZAqSNoiwiH0T+QmcbbSE27EB9qMNN46mXNRbdTWd/zbruKZFty+SR0lOBYCLF
 6nLc4QLd4K0j6Q2pvQzpi6UijHnytBurX0qS4Z0QNf5Mm3cvk0sYHI2kcUfdo4Uj2VQe
 +KGQ==
X-Gm-Message-State: APuU4Z9FVz1lWQnDACOqCKcQ4kzpJ4JPyq7U391YuoEATkpc75Sl6EuE
 UiW1tMrxit6q38OVdp17WCUDoC49gODB1X810tKxv6s68zH7mDFGM28NiJGS7qcpmShb+Zpjs8g
 O9ZO2
X-Gm-Gg: AZFdTZc++mClQlC0zYVxL8GT3M60+nSxtYrqDJM5kYHeoDCvg6Yn6JYPMfATezmImGr
 Cr69VDH1nyNrnkHBaNTQRo/c7dYzxSFVubAlZOrYf+99EYpXipcwOK7htex+kf1cLsk8S6suUMW
 01xCqnYJRBA+NT4ixQH1PWrgakqd/fRsXxQlxuA1GC4+wdgl6fqjo2DBSBfa3S9Y4vA7sNBhtgb
 2Jkv2Jsirlc+JIt6L/yVkg0ii3fwrvSlfSe9g3NFTad6rekgP4KPkBkR5yubnHkKCj3J6dkp1pu
 rliPtwnSIJN0crrA7c+SQkQTVGGYxD6ktFWVo3H/qCnpff404MyFADmdhyR73cnNe2NQik/Pk5q
 qQfAEtmMyH6rs9KbY2boKDUvzTbTpzJ+AUxxdA3Gr2A8jeQT4WI23j6P9ZiP4LcU2AY1HfR0dbQ
 hcz/ZwS1pgdRagwT3BkCl/b24h30QYZ7b4sy/aV1xgatD4hEa6OQhEZ0xGROsQ/+14iSY+9lf87
 o3qwFdGl1mO2/PcypgCT9qZASCyuBA4R6fRmgL2GK6zedE2XQExyGTuCXtwAXkfGos5ig3ut+Xg
 f2PDv2cNDAg0/H+A2IN34guRbgTlvzYX6egslnw5p7Kza8hdevkOvsWfV/GYExU/EeffkHpEeIQ
 u8zQp3kWmWdItH5TjnepyEBLEl6BkSaVWDA==
X-Received: by 2002:a05:600c:8888:b0:4bb:aa4f:c022 with SMTP id
 5b1f17b1804b1-4bbaa4fc136mr108709575e9.2.1795790680601; 
 Fri, 27 Nov 2026 06:44:40 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bba6a0d65fsm216862975e9.3.2026.11.27.06.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:44:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH for-11.2 0/3] Fix registering of VM change state handlers in
 post-load
Date: Fri, 27 Nov 2026 14:44:36 +0000
Message-ID: <20261127144439.627586-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have a handful of devices which register a VM change state handler
callback in their migration post-load function: vapic, mac_via,
spapr_nvram, pflash_cfi01 and pflash_cfi02. All of these except vapic
have the same bug. The intention is to perform a one-shot operation on
first resume of the VM, so they register a handler in the post-load
hook which then deletes itself when run.

The bug happens if the user performs more than one "migration load"
operation before doing the VM resume. In this case the post_load
hook will run a second time, and the hook gets registered again,
overwriting the state field holding the pointer to the VMChangeStateEntry
struct. Then on resume the core code will call the hook twice; the
first hook called deletes not itself, but the hook registered second.
These callbacks are allowed to delete themselves from the list,
but not other callbacks, and doing so can result in a use-after-free
(because the QTAILQ_FOREACH_SAFE() loop in vm_state_notify() keeps
a pointer to the list entry for the next iteration).

Fix mac_via, spapr_nvram and pflash_cfi02 using the same pattern
vapic already does: only register the callback if it isn't already
registered.

pflash_cfi01 is fixed in a patch from Philippe already on-list:
https://patchew.org/QEMU/20261124185556.81132-1-philmd@oss.qualcomm.com/20261124185556.81132-2-philmd@oss.qualcomm.com/

thanks
-- PMM

Peter Maydell (3):
  hw/misc/mac_via: register VM change state handler once
  hw/nvram/spapr_nvram: register VM change state handler once
  hw/block/pflash_cfi02: register VM change state handler once

 hw/block/pflash_cfi02.c | 2 +-
 hw/misc/mac_via.c       | 2 +-
 hw/nvram/spapr_nvram.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.43.0


