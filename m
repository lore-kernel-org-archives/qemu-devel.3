Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04AACD4F5E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNzt-0000Sd-Ix; Tue, 19 May 2026 13:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPNzr-0000SL-I1
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:12:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPNzp-0007IQ-82
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:12:47 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49021532ebdso8594875e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779210763; x=1779815563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GDjhGIy/c2r4F5F7g9Y51GerqpJnwxS78M4iQL4vOIA=;
 b=m2cnAPS8QBdfQJ+Sc6L4TLJFvoU6Da1Q3tu+14m1kd5tpXT2JqZkpGQEc68QnU27WG
 lU4WbDP1+H180czxOIR1J61yw9c/rUaSCtyUPHvUybSWu2+qefgrWInEemuq/JE9Rf7a
 PwMf42aPqXhpLh7rRj+pS83naKtj8o0H73VfdoXXuTh86w8jIfJYUBp+qn2cZYmwsZlu
 msQwHm1SMWnvvuK4CRpcXEYtf88HgZOU19b24gQxSMre0O0mns0BsfYydrAib3k3fhLH
 V3wM69CS4bDDm2IvC5ili65kpF5IfHyr+6DuY7c73e9QfxkRwLxlz8tzvXx7KMSO5/8W
 GI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779210763; x=1779815563;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDjhGIy/c2r4F5F7g9Y51GerqpJnwxS78M4iQL4vOIA=;
 b=Wk9luPrPSL+YXvl1Q/3NEhXHKD36A1K0S+L/HUJtcQc619dCB7X6adFmN4kb+NWN3L
 1mCEBa1D8QEcSO5m2D8Qy+9a1Jhv4wHDpoHPujloyd7f03iSyNhsEhIE9n11GAghJiVB
 8WX4z7xTM0dpncm8FOXB0HKRlkTOfLfvSCEkk6Y4s0tLexAx5XmIHkF6jAqb/sQZdmVw
 0nBPEPeKnEvx6VJ3Sz9ZQkg+hPA5oF9OVYjmZtwOqu9ijFeNTIOn8I18cnnt5TR4rkXa
 ybl+iofqZOUcBU5pImh57rF0NgageVt1GGlpEtsOZfGLFTvBjyWHzVCEZa08umUxmf0D
 s3gw==
X-Gm-Message-State: AOJu0YzMMzq/ZmQ9NnKDK8YtA27OVXNxaieumWsr9bxhjyyV+647dgGp
 8M7z7buNYiw1WVp0aiBtfGBk3IA3YKUGqJbq6QIRnmCVSIECVKzDEG5xRMdynvHuvK6EKeQBR9Q
 /LCnvRJQ=
X-Gm-Gg: Acq92OGgiVR4XKLnhBPh6oj6Y3LQo0TvFLVaBd+xECv8pRt7X0+5aZiyTagIOuDSeld
 /dpPm1OZ725rhWL/rg5d2b39k9OSoCWzd7Tm1zF8TzHcgOf09zME8/nG0u9SdSA4RNdbSOCt0ot
 4G0hbVnUM7V6dIzJHrKnoRUPJ9hUWbow3GosUCQV+XjAhhnL9hNse2EtOvZte804Ud2vJaBdhRY
 WoKKd8Vx/2lCfk6m6y8rO+HhAC7uEwpiHhgBZpdngITSsQa16yKq2YVusIltWReCpZrbMLAJvl3
 2yhASLWq4Brq8xvjaqt7/YCdKWoH/XyUKhzmJ3On3RLN41GMa7SR4iDf3UzQfeqtMKFfobJ5uMv
 EorcsF20858Kp+ykwBpYMMinb0Z4m88q/aSkdfU1ti38Vk29AL4pLVtsUtYwpTkD2SGu2ZCGcy3
 dYg1ilJ3DRNpeJe7Nj5ubI36n2JTJ7PwvbdOvmkejjhu4ocdNQIV2siMewCo9AWfPHQZv/x0jX
X-Received: by 2002:a05:600c:c10b:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48fe60d55c4mr224043335e9.9.1779210762713; 
 Tue, 19 May 2026 10:12:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a1aeafsm49522343f8f.23.2026.05.19.10.12.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 10:12:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
Subject: [PATCH v2 0/4] buildsys: Stop checking for ESA/390 host
Date: Tue, 19 May 2026 19:12:36 +0200
Message-ID: <20260519171240.97420-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- Fix MAINTAINERS entries
- Remove s390 check in ./configure
- Replace __s390__ -> __s390x__

Philippe Mathieu-Daudé (4):
  MAINTAINERS: Fix s390x storage key/attribute device paths
  MAINTAINERS: Fix tcg/s390x/ path
  buildsys: Stop checking for ESA/390 host
  tests/tcg: Explicitly check for 64-bit z/Architecture

 MAINTAINERS                    |  6 +++---
 configure                      | 12 ++----------
 include/qemu/cacheflush.h      |  2 +-
 include/qemu/timer.h           |  2 +-
 tests/tcg/multiarch/nop_func.h |  2 +-
 block/file-posix.c             |  2 +-
 disas/disas-host.c             |  2 +-
 util/cacheflush.c              |  2 +-
 8 files changed, 11 insertions(+), 19 deletions(-)

-- 
2.53.0


