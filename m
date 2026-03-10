Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A15EB1043
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzuaW-0006zI-Gg; Tue, 10 Mar 2026 06:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuaU-0006yq-4M
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:18 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuaS-0005kB-72
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48532925a4bso13079095e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139514; x=1773744314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=prpVZEFx5pusLus9gfFD95wasIRzuR492CqA6rGNeDs=;
 b=oq03ckeC7vkv7lEl6a5FdDDa7Fv4Ahbkvhm9tZncqVbfQrXW/w7OiWMuDTNiGqCcBJ
 CLZ46PRFWuGigzsgsEDdcfJtwuU5Jgb59n2gJNE3B5VS78rD8qJZrRyZ90AHIo6MkQMW
 NTJVBP6Sp+1KzO4qNoIE0CRnyh9+ebuj2/7fAO2R+oQL4mgfSScHKe7UKW4WiXFTpvEk
 0UAB8aAMuVKZj0IMqURxvBsX/sjiu8liqjniTwkncyxpTYiY1f1yB+SswOcz6FjpC8TH
 h4AuOaorPopLaMfdWzdSThly4cnaUrL1B3RgTHeoSy2PeKd/dNoKft2sWLEMCsx3Gn1G
 byFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139514; x=1773744314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=prpVZEFx5pusLus9gfFD95wasIRzuR492CqA6rGNeDs=;
 b=AmMLIbNSqQKLNFEH5gr4K2Vhg3rFJfBkDEXY3mfY4CxUiXthD26f5lfyTw59vOubbx
 sAywmgVqyBkKRUENw2emEUFzdjEgiN0qp+pXsVEN97uyisUflPIGJf+m/OOTiVswY2Ui
 OPkiPJEXg4x6tbYMkX5G4OjHS05xW69c174RQr86XlygguJXu5G5n3XDDDhswW2gwN9W
 ZRpx6jt25HRMojKUN2svVKTnRqZPbY0sl0KGMepCSiSfXPvPKVp4qtSN6laZdE3qmV+y
 uR/6p4P5SJ50k9usSXxja8EMybB6A2iuK1P9uRcVtnd/v2G4YQtFcv28hj29CPYGmVhY
 jKhg==
X-Gm-Message-State: AOJu0YzW9Wm5x7nyGX+sg72XLu4ZYI/iQbqdVdACRzgh3xPPFzwFqj7p
 I8v7gToqkPcSiS7OdKe4CQjLRn7L0ks2Lb9vYCsqN+f1mBaMAGQdfsItHC6x9GZ+u0IpzCtLzrY
 TQe0f6+g=
X-Gm-Gg: ATEYQzxAuuI3YfGXLGZ37LyZ/D7l8ROrHCdC+VCKypbAbEA7ylRnRht67286jVHEohd
 STmobMOYBIzOw9NAO/ZMRlyjLXe2DtvWeEDja2eEdCw80IEIJ9Xov4KJ/w+Dti+ZCHG12PyfzZ8
 T2cTzzvWX6Nt2sNmqF+fU1hp9RGE0HETUVmu2oxKIvRcjCYUwQKc4taCjtCJZN2cp0C/yTqDL93
 p1v/bysrcTUwl9m8eT47y0WLg4DsDdYt6WQ+SaHt+w9CpcyETutk9OLDwha3XrWUyHYK6sqaKhe
 BXupkK9im58iRbml2X04DdjK5lbMY8MaFrCuVJ4Jf/PAPV47xTMwGB/fcrvtvroLVLWtnAjKoRP
 BG+7aTpfkETeXSKZm/f7YtuYzaMkdc1G7PnO8H7OswydNJ3PWGwy8kbHQMniFLeifB8TUtz6vi8
 RtfEBf+05dQAkeYtoOIyZZdm78UF91bHKz0lUXt7a4sUWp9H31ilSujzZtUlzDskouv/kasaV+
X-Received: by 2002:a05:600c:540e:b0:485:39d1:b4dd with SMTP id
 5b1f17b1804b1-48539d1bb72mr114282505e9.10.1773139513516; 
 Tue, 10 Mar 2026 03:45:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48531818b5asm128181615e9.3.2026.03.10.03.45.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:45:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] Accelerators and TCG patches for 2026-03-10
Date: Tue, 10 Mar 2026 11:44:55 +0100
Message-ID: <20260310104511.12670-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The following changes since commit 31ee190665dd50054c39cef5ad740680aabda382:

  Merge tag 'hw-misc-20260309' of https://github.com/philmd/qemu into staging (2026-03-09 17:19:26 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-tcg-20260310

for you to fetch changes up to c574ff9245c7e9d10433efd60df2319ff4d69084:

  accel/qtest: Build once as common object (2026-03-10 11:36:21 +0100)

----------------------------------------------------------------
Accelerators and TCG patches queue

- Improve TCG extract and deposit
- Build accelerator stub files once
----------------------------------------------------------------

Paolo Bonzini (2):
  tcg: Add tcg_op_imm_match
  tcg: target-dependent lowering of extract to shr/and

Philippe Mathieu-Daudé (9):
  target/hppa: Expand tcg_global_mem_new() -> tcg_global_mem_new_i64()
  accel/kvm: Include missing 'exec/cpu-common.h' header
  accel/kvm: Make kvm_irqchip*notifier() declaration non target-specific
  accel/stubs: Build stubs once
  accel/mshv: Forward-declare mshv_root_hvcall structure
  accel/mshv: Build without target-specific knowledge
  accel/hvf: Build without target-specific knowledge
  accel/xen: Build without target-specific knowledge
  accel/qtest: Build once as common object

Richard Henderson (5):
  tcg: Drop extract+shl expansions in tcg_gen_deposit_z_*
  tcg/optimize: Lower unsupported deposit during optimize
  tcg/optimize: Lower unsupported extract2 during optimize
  tcg: Expand missing rotri with extract2
  tcg/optimize: possibly expand deposit into zero with shifts

 meson.build               |   3 -
 include/system/kvm.h      |   8 +-
 include/system/mshv_int.h |   5 +-
 tcg/tcg-internal.h        |   5 +
 accel/kvm/kvm-accel-ops.c |   1 +
 accel/mshv/mshv-all.c     |   2 +-
 target/hppa/translate.c   |   8 +-
 tcg/optimize.c            | 266 ++++++++++++++++++++++++++++++++++----
 tcg/tcg-op.c              | 215 +++++++-----------------------
 tcg/tcg.c                 |  21 ++-
 accel/hvf/meson.build     |   5 +-
 accel/mshv/meson.build    |   5 +-
 accel/qtest/meson.build   |   5 +-
 accel/stubs/meson.build   |  21 ++-
 accel/xen/meson.build     |   2 +-
 15 files changed, 338 insertions(+), 234 deletions(-)

-- 
2.53.0


