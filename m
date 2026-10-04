Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2472CCA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 07:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDGfF-0001QX-7y; Sun, 04 Oct 2026 03:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDGfD-0001QP-D5
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 03:29:39 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDGfB-0006Bx-MS
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 03:29:39 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33e46a156f4so746014eec.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 00:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791098976; x=1791703776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fcM+GgvqYnaybOh3REeIuS+9IDsCpLtcMLDjgRhyf2E=;
 b=ndVjAtZDT+S/hD9WJP0QCJ2bW3320+I6FKCIBKm4VHApyt2E2zYV2301begZzCVFAb
 E96YK5GUmq4wc/2kQPssyPIut18Akmgd7wKFUsnfu0mRcHUFQ186dgLfwliYRJCM8aMV
 WfFL5NTmbEoLfqU2sZHmulr/kj7c0128tEv/dIYEhH129GznhZv1XfxvJBNIFy+UASIP
 4RafCFVMZpgBOH3nITdS/+fJe3ndWJBZ8MKHY7y1rbohxVrUpVVmeRhLxvpUWzuP58Qa
 aGMskFuFK3YHv+bDePimH3ZezO006hXjc9YyjObzIKP7/B3P2m81/0eh6Q4ZsqUGFPGJ
 lBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791098976; x=1791703776;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fcM+GgvqYnaybOh3REeIuS+9IDsCpLtcMLDjgRhyf2E=;
 b=Deo1znvg70incmnebSUHz59Ye8eV1NIDhpirJ2yrzKlHnJ8Lyt5w8fxdX5pW2XskOT
 WfPhRC8D4qUZa2hopvQ6ccNJSVcEu7FILhPEsmtQVCCdrtoEwX2HqVSHnO/v4H21V5mR
 ue7le9rqojVqa/fyF6lYNs+dHa9NVKcIbkELdSKju8JvCcxrkob8zMgbTVdJBDivN28t
 OZFHUkQjS/P9wrsIeK9SdmVIMIeVQhia5jBtzgpEVU9rkcvPjod/oukrqskxg+i+nzkk
 j5sJ3HFhwzNuTHd7eXSAzZery7xRNWbFN4cCALIQkBeAuwMRc6a3CgzI3B2tnJl+/9T1
 q1VQ==
X-Gm-Message-State: AFq9FYLDH3odP1OytXztp17uh6xlb+KCxHOCFXVdxMIhCIyGh8G3J3rv
 fLVTuMgC5ONRu4t28/GJCOhEmwml6PwofD+ZIouH+GBZYGVwgbexMDhsJbeo0Yr7
X-Gm-Gg: AYBFou3fCeqsSdZoYGnhbNVeX/7zdWnWU7E8NLFw4i5JxIi5XTcX4QldFOrU/kHoGNC
 SUtwvkgSxSZ/JQZMoLkLkPctwwMZP7XJPhzcsBqp0ReuZuzxXqWCWFtXL07ph8JD0jjpIz/JEaC
 F4owS8FJK70OPzhJhyu42M1y3VXLQyGvHs0Sy895u4dL2lpr3zudJtAcUCv2JUFNIm0KFkxBE/c
 UA3Sq2p7w4JE/hMBprxDjOle88StFqd7fLG+fB+0KOC3+CZ/cEfoUsGQ6/SmMAyrG8xNl0+nSON
 0Sr4w6v7fgol9e3Kr0lnnkIMNeR6hEY2bfIUWsTPNN/wfM09gQl1UqjYFEdK9E1xHmG20kZMrBF
 MNu0KsixxIgCDUSHCBf92U0lg4ZseyEc7QkzTLVduFOSoAEZakwcvHlxkogfEPBAgjcIg9wiXQ3
 cMl/ZED9mwU6/CwJxU5seOGQfRiBJC2EFKRqXq/xy4a7wttjwBet1ZkMtni0OCmqdEu2NZuOsQZ
 1XV862tGZmrcPX0SQ==
X-Received: by 2002:a05:7300:8345:b0:34b:f456:25ce with SMTP id
 5a478bee46e88-34f14f06d11mr8344456eec.3.1791098975753; 
 Sun, 04 Oct 2026 00:29:35 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-351270204e0sm3036770eec.1.2026.10.04.00.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 00:29:35 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/4] target-info: preserve full softmmu target identity
Date: Sun,  4 Oct 2026 15:29:22 +0800
Message-ID: <20261004072927.1142-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

`TARGET_ARCH` identifies a base architecture, not necessarily the full
system-emulation target. For example, `mipsel-softmmu` uses `TARGET_ARCH=mips`,
which caused `query-target` to report `mips` instead of `mipsel`.

Generate `TARGET_SYS_EMU` separately. Softmmu builds use the full target name,
as `SysEmuTarget` enumerates system targets. User-mode builds use
`TARGET_ARCH`: user target names such as `aarch64_be` and `mipsn32el` do not
have corresponding `SysEmuTarget` values. This means `mipsel-linux-user` now
reports the base architecture `mips` rather than `mipsel`; its executable name
remains unchanged. Initialize `TargetInfo.target_arch` from this token and add
a qtest to check the `query-target` result against the target name of the
running QEMU binary.

Yonggang Luo (4):
  Revert "target-info: Statically initialize target_arch"
  Revert "meson: Add TARGET_ARCH to config_target_data"
  tests/qtest: check query-target architecture
  target-info: preserve full softmmu target identity

 meson.build            | 11 +++++++++--
 target-info-stub.c     |  2 +-
 tests/qtest/qmp-test.c | 13 +++++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.55.0.windows.3


