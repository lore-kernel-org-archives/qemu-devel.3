Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EBCEEA86E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 00:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqhGy-0003mE-AO; Thu, 12 Feb 2026 19:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqhGx-0003m4-9m
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:43:03 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqhGv-0000qK-Mp
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:43:03 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-823210d1d8eso228092b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 16:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770943380; x=1771548180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1MUqKIJei4eEL5uhQtFC/eJ9jdXXDBn0WYzNdWXQ0cg=;
 b=qJ4Kf1PPiu0TqL2MpgCuVlOOBqA/PT57f2VVom6eNR2BccSqpmZbUOlHyjX1+eymrl
 seBPdM8PRUFzeDr94oFtLT5hYcgboyx6CPKWsInZfFkeanDvO4tb5m2pnKgBLKPfrHuD
 jfqGo4DLC7fRdHUkL+wFP2OSfhAiZsG8ocsW1zVRPhcFLz5vBypOA0O9QBWli2MQ69EK
 Zie5gU3AihMWj+bIGjArgQrl9YJJaXfGni7ZFGG++mqtjy/TdLQfCGqVUvem5dnsZjud
 fPqiTgbBXm1jmMujACizxp0ZDrJbh4eBd3numkd5csnzwAwPi78JRiM05jNAyYqRDcHk
 gYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770943380; x=1771548180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MUqKIJei4eEL5uhQtFC/eJ9jdXXDBn0WYzNdWXQ0cg=;
 b=MOr9uftitYAQAVku7TcnuHmDeGgV9Wsez0ivRBNVKJkxXipqZjcQKJthmHWTZf9n/Z
 vavih3SAUPrBPd41dUFbGO1BEnR1E+ZrAR2fj6hCHr+ulhTYmtbzdQAe1Hqc/QNwsXSQ
 S0coCejd6Is1wDtAC4wKdET8f0mG0xAftDSyMdXN6GQkTFxAFn/4ZjVofHDyuJmpHDsf
 6Khv3V4yS57rhHFqHw6ABr00Ud26pCSGgrbyUVbdQ+aEcEd8bf8hn6dw+nF6taknXa/7
 rVJU5rcqanHd28VWJivYBsIniZDBU2NT8//YxYDuWeL/3Q3rBEcQKmGvtuHhX3fgQbGv
 AYZQ==
X-Gm-Message-State: AOJu0YxbOjZ+mohIw2NUgGJbcgnVsvnGGGui+doDuFEji+NMRfvU3Yyw
 5SOflL/LtJyFSCZr5+SWcECfaTeHL9d0ZRjKOxPmgOyvQswIFLyCg+KVvXpp2AeFkfqS6ebmgPH
 jz9cx
X-Gm-Gg: AZuq6aIa7la12HP2CTvW/LZtXvqZ/ZvOz0ctexZsyA08iMPAb2lAOBaykv9iCR5zEjJ
 0nl+06AZRgyzC1Iwb4NV+WDpGeoH2L4COcEj+v9/dui/AcWkHx0U97T5GLnG1jzK0iuOFZY7a/9
 PlVjiNGKCh2rHWaYMET1XgtIehC3wl83zWK5OPNpuhh5Biu5ZADPoxtcH5lHsWEf9VwfsudwFMe
 F6yiUzt33CAI07PjRmaz0ZeGh386g5iymrDQUf4YNMCaNBnFmyToP6inBeYEThLGL4oSvlfjDhm
 DXrO2tZRciSx4vkXeC+y+YtHZMp9oevxvgR9cWgLgmTAdx3m7s6S33xRXBTmhcmsYNu/at+d/UW
 qSHWLuK1473ExdNNHgk1+fCbmOBqqm8yDlUOFzyTqcRZNCb+BQafucdV+DAUXpKeIjlh8JNVRUX
 Oxol3DJFgh0PyNOSqwmwTWKOth7zQ4tJtxhnrcZ8oKN6YiZGR8keXkktAxm9DKuD0wuTF6kolBr
 +sK
X-Received: by 2002:a05:6a00:2da4:b0:81f:5acb:55e5 with SMTP id
 d2e1a72fcca58-824c944f15cmr252572b3a.2.1770943379833; 
 Thu, 12 Feb 2026 16:42:59 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a431f2sm504326b3a.22.2026.02.12.16.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 16:42:59 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 0/4] Plugins patches for 2026-02-12
Date: Thu, 12 Feb 2026 16:42:50 -0800
Message-ID: <20260213004254.493059-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

The following changes since commit 4ed6a7f2fdc09d9fc3411e83e278da0085122016:

  Merge tag 'pull-block-jobs-2026-02-12' of https://gitlab.com/vsementsov/qemu into staging (2026-02-12 14:35:18 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260212

for you to fetch changes up to e82d8af3da05e5315a11d0841e40ff0ed0ce53c8:

  contrib/plugins/uftrace: add riscv64 support (2026-02-12 15:59:48 -0800)

----------------------------------------------------------------
Changes:
- contrib/plugins/uftrace: add riscv64 support (Pierrick Bouvier <pierrick.bouvier@linaro.org>)

----------------------------------------------------------------
Pierrick Bouvier (4):
      contrib/plugins/uftrace: fix infinite stack unwind detection
      contrib/plugins/uftrace: add ops for walking frame pointers chain
      docs/about/emulation/uftrace: add info about automatic tracing
      contrib/plugins/uftrace: add riscv64 support

 docs/about/emulation.rst  |  23 ++++++---
 contrib/plugins/uftrace.c | 128 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 138 insertions(+), 13 deletions(-)

