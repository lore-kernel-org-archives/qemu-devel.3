Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23DAC02185
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 08:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta9sZ-0002dg-79; Tue, 21 Jan 2025 03:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta9sX-0002dS-PP
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:44:57 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta9sW-0004LR-9B
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:44:57 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so4060963f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 00:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737449094; x=1738053894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kRBL9pD3EvH7+CBr6dhdQc07O4NtFY1guIK0UpswibY=;
 b=KRScAiqKRMKV+BqbB7KWOnsTfDPFGINooPY1oTlY1VYC+/7ZLcI86xxqrlkpfsifqu
 di2ww23T5XxBYwPzcQdGJgLLwfcd43PxBM5RKiL4/xfpzdbH7NnOLzDEnN++D7LMSiQl
 66aFnZ4oJWGmqQX6T5UmhIRLk3cWoTCs9YVpv9j2E05m+6FSwSGwW+pttoDO/WH+r9EC
 zQcG/biSdEKGUFZhg7m8i5PQoIrp82YXPPSoSnVdjp77Wtgvq4UjIzgzMmO4Zu1siLsX
 7BWvDHE3R2NYaAyi3ErDmkuSy649nq8uxDJqrBwMS1KgdJvH53CejESZVOmeYk8zYl9b
 3Klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737449094; x=1738053894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kRBL9pD3EvH7+CBr6dhdQc07O4NtFY1guIK0UpswibY=;
 b=VuUa2Lq6tBl+kzQzlc/qpvZor7+GXkN/XDPdmPghPGRKvLpbUoDOuQqHQrgUajtgd4
 +PzXw3lPwF04iyT7+MH1OaGZ3XtUceUZoUkrW1aEffizZwUg6MvB+Dp2UIa+1gYlf+bl
 Jnu46i6PXuTXaYcTnXXXTzi7c8L/fxeTv5HccB+DECc/GyOTSI46GJbLTgXDlcOAXNT0
 do9H3WE615ppHoWHlLrawDfmOP6SpPYseVRylkFrTcFBmwxZ/3cmPh7EYv+CwI28JQcC
 /iWSJMrcUs4fMnagE9A7TR9N4DkL6HmRUCvXvXmlzlx1qaktw/ljFmmBoqPP6VMG2I+r
 MgHA==
X-Gm-Message-State: AOJu0YxI9uySieZNDubN5UheR77VgDJ1YKfcsyX8TcXl3cJi5ZTJqf9V
 r4tCK2M1kViMEedRuFOkpFYnW8G1sSUx8KHSZlKab/lUt+leRA60uLd4natiWE7RXWCswdo3vng
 /+Wo=
X-Gm-Gg: ASbGnct52RWIlNzihEXrgdLqutmA0Ny/pS18I6Ff3vF18HikZKnTPiWgHPAivCPmcYq
 ukFQl5HMMM3SOIY7cD+h2459gVr+LriCgQmWOpjJuimD+kQxtcrl1Q02iKFeIWetl/UfrUk5Hlt
 2nZHP/Er2ITmjmuH1HsgfRyCp7CWHj6SLrUOZrvCwUJnQYfNampteUcbLsBgFCSwWKtqKIzdkns
 rgq0L2Y+7SGdm9ZLEpVn8E6QWJCqVYDoQJfKVfHpshB2zS8JaMYEjhPjlcGAqUDXPeFsofLGg53
 5t1eL7hjm9ZC1WYgGy76IDKbXz3t1FU2XsUy3/llsQLK
X-Google-Smtp-Source: AGHT+IH4H3IruuXS1yXn+nUseVO5byUdkRpXWJrtrAx/ovMnj6LTzF/k23gkoCS+XmcoC4nGONA0GQ==
X-Received: by 2002:adf:e84a:0:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-38bf5686090mr11836905f8f.33.1737449094238; 
 Tue, 21 Jan 2025 00:44:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322a414sm12648233f8f.47.2025.01.21.00.44.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 00:44:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] hw/ipack: Minor dust removal
Date: Tue, 21 Jan 2025 09:44:50 +0100
Message-ID: <20250121084452.81941-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Clarify what is what in Kconfig,
replace qemu_allocate_irqs() by qemu_init_irq().

Since v1:
- s/qemu_irq/IRQState/ in IPackDevice state

Philippe Mathieu-Daudé (2):
  hw/ipack: Clarify KConfig symbols
  hw/ipack: Remove legacy qemu_allocate_irqs() use

 include/hw/ipack/ipack.h       | 7 ++-----
 hw/char/ipoctal232.c           | 4 ++--
 hw/ipack/ipack.c               | 7 +++----
 hw/ipack/tpci200.c             | 6 +++---
 hw/char/Kconfig                | 5 +++++
 hw/char/meson.build            | 2 +-
 hw/ipack/Kconfig               | 4 ++++
 hw/ipack/meson.build           | 3 ++-
 tests/qtest/libqos/meson.build | 4 +++-
 tests/qtest/meson.build        | 4 +++-
 10 files changed, 28 insertions(+), 18 deletions(-)

-- 
2.47.1


