Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC45C47BE1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 23:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdGrs-0003Ml-Vt; Tue, 06 Jan 2026 18:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGrr-0003Mc-Jv
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:53:39 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGrq-00041b-1S
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:53:39 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso797160f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 15:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767743616; x=1768348416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hno/s7N4Pvh6ZEGM76nUMxxZZOi7yIdAgRHN3GmgAXc=;
 b=XnHDqUz1rOka5PAjPSAXGGFcFOvEy0qMoyJYvQAXxJg3Ekiu7y5nHoGpNotpget7jq
 AadvdcmxQ+H3ni+9LMYRFSiBVhpuvpD2YNkdR1SpoSt4eXaDD/cWMJx3SLo4yxZ8d91x
 of7rWTNFcVDms+WzD6v9BuLZoNyzEt0nvlKcMUP4Kl/ASwp+3OD50H2r5xUD/hnqX4D/
 9QclqAwZU4XytdLY1hFbGAQzvXnlLLHp2SPEefGkhkKRYkYxNGqKoFRwskiVSb97eGbo
 PS9Jj7+DVFi/1RzYsJdPJ3rbZApGwaCvZXg/3Sx9l/X1MNBphvPUSpm4gzK+4FYR36r9
 pKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767743616; x=1768348416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hno/s7N4Pvh6ZEGM76nUMxxZZOi7yIdAgRHN3GmgAXc=;
 b=lsnOsMfdAJnyu8ntoHmz6NZgARYDlXr7dj/+gXkmeHk/owK7dJe9taJzfZ0zhQx5YN
 HE4bizThb7sNvC2AIHNv2xJq1z4sm4SRGEy6R00/10zUsfnsSrkZkFnKf1oGWME6Vfjy
 eva+DFtKZlSkrJlUVClIybfBZ852NbxxMG6xSQTuoH389SVAdUwELAiAJoW5DG9XSAth
 PYFz09MYZ0meaaeeuG/rVYeCe6b5fxJlog0CgbPhK1xKL179um/F5H2FmEyTqrYs1tKk
 4j+IY18UH62L9YofnQh9sIJAdO3+jwkH9EjH9SzBekx9OQvpQ/Z6G/ZvUQ+enCsc5oYl
 EbUQ==
X-Gm-Message-State: AOJu0YxdLSVuiymjieVgOCo65kwQjvxW5Nj+qihU1J3082VISnxUHqJI
 LWpWpl9pzrkdCKzYLdlVvaEPabzsT81jig0z6AXUBmfmGiJeEJXN8zm7mDP+KJ7OtjwZLOyYQh3
 JWbfNUHI=
X-Gm-Gg: AY/fxX5E1MwjAymTSwEzgaVRIZnAyQEmtaeOgAH3UBlwvZajriqLlyDhUKgVjUunQzT
 DB+GBWMDfCuAoigaDVo/lsyafWp4IKMwAFB8fbq+wbuCkWYbp5DNF7bGk9ME6ZyNbYb+5XpOfh8
 g01qPLKYoLzET4p/SpAmHcjQs484YwH0hvq5ZGdQQRrc+TM6Rlt04VNWM6e5tILvEKQlq9zGLWp
 Rcuv3HEd881rHFWON9XYxYrj/wWwVl14tkYe97RShXasOpcxOAfrg3J1jCkywja/7+ytJq53a8D
 zq1rGhX0M70F/qdLyvyYm7YzyGe2iUBNNvJFiiym6wp2M82LppJJfBwYft40AIeN/81zsufzJ5q
 fD/fy6up1KN/jKBfgun5DHkgrRuzvgT4IVfunu6dhVdVRz/CmGO2sCl8OyxSmaUks9s03Lz8JCB
 qCN6153Bcn86xy+ZWnZ2GqlFNaDvR19u9qQD5lj1gkNUTKjZo22Y/DN4k5Zsfr
X-Google-Smtp-Source: AGHT+IEWawP3lX4o2c7wJRB5yi2qcvZFiwu1r9yFc+e60EO1DRqKvWK9fEFoyiakCR/Pp+9uExhaBg==
X-Received: by 2002:a05:6000:40e1:b0:431:16d:63d1 with SMTP id
 ffacd0b85a97d-432c37a50aemr863512f8f.44.1767743615596; 
 Tue, 06 Jan 2026 15:53:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5dfa07sm7139231f8f.25.2026.01.06.15.53.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 15:53:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] target/microblaze: Build more files once
Date: Wed,  7 Jan 2026 00:53:26 +0100
Message-ID: <20260106235333.22752-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Build all hw/microblaze/ once, and most of target/microblaze/.

Philippe Mathieu-Daudé (6):
  meson: Allow system binaries to not have target-specific units
  target/microblaze: Directly check endianness via CPUConfig::endi flag
  target/microblaze: Avoid target-specific migration headers in
    machine.c
  target/microblaze: Build system files once
  hw/microblaze: Replace TARGET_BIG_ENDIAN -> target_big_endian()
  hw/microblaze: Build files once

 meson.build                              | 8 +++++---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 4 +++-
 target/microblaze/machine.c              | 3 ++-
 target/microblaze/translate.c            | 8 ++++----
 hw/microblaze/meson.build                | 2 +-
 target/microblaze/meson.build            | 2 +-
 6 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.52.0


