Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BBAEF99C4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxsx-0007Bv-4I; Fri, 13 Feb 2026 13:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxsu-0007Bg-9t
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:27:20 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxss-00060s-CR
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:27:20 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4362507f0bcso988572f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771007235; x=1771612035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9vafi0T2GAlTsHHxivHQyehFiV4lWmUNEpHUiK5qusY=;
 b=pMLOq3vj9e6ifRnWzO9f42Cgp6+u02/36OrDIXY3eQ7waKFj4tybnIzNOCs7ZKkWBI
 RUjm3jliwpn7rdKROMOZlBVlUzvOrYJSCBTxnhzNZo8SGHFbZZadzYu4FmEyr8Jz5ORe
 Nhicx3kLsQq15Oxp1Rv58UoK4S9g70mP9rnfDA2/ryBrbStQHlW+ovaLmayDnDp3v5I+
 GoNWbtu6O8WTzoD83CTAZLh9LBzml3px/a70ssCxBcHsQWVBbef9TwL/B8JCTrczXxOa
 f6geeyIrHPyq40NUk6xKeHofxCuxgRxBk0aZaDfnhQAZS72JC8NX4v4LWZoRL13hbdSX
 77sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771007235; x=1771612035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vafi0T2GAlTsHHxivHQyehFiV4lWmUNEpHUiK5qusY=;
 b=VjMC+SrsXjLaUoftFISXKq/C+M2mHGCtYWQykqOS1PcuKBj1JamcgTNZPCFv+5wApy
 4wTWw+FVqC5hY/IJ9Hn6YPescLKuvTF+NI6OoArAuoT6dluvpfLW1ATpirJDU/4kKUGX
 881doNispxpRAn6+uRqlNEklFDCQ9nCT7ElE/DvgEK6kUM0PmDLFk4cCsbWh8wvr2WsC
 yZfjHPPC57G3DC1k9/6DERd6zjBgXxNwh1wBQNo4GPhrKDZtNJ2xF0RXtxH27cjQ9mRi
 shsU0pN6LyJLcKb1j9On33LlfueepYSRfLqMsRs6wcDNOtKKQGECSze0Msd7Xl/dkxXa
 peQQ==
X-Gm-Message-State: AOJu0Yy3bRQm6KGAe916mTPoLZGdkBiYRHPfHLkEMg/TdjmSfD6ugqqs
 m07YQEdZwhXUGXao+UvDIc0HulvY8F43lMxwH6PbB0o6MrQ0Ngkh3jA5Z3FxucXgPuweAUnMRTu
 KR9jEUUQ=
X-Gm-Gg: AZuq6aLniPmDQxs56YstoBNufLAfEWh+mmpvTrQkYLkTr0Vaw1NdMf0V+bT1FReK2ye
 EE44eCMO1MuIwZH5IsrEQaUzY9vZABQRivLvENGEH6ILCoAbJSdgdFND4km7HSr7wgHGnGS7Hje
 7wswwD64VcjrF2x4WrS5zkuRCGgjf4e262lQBW9IMfIdxS6lbv4LUB5/DffSbGtE5fydo3+duke
 lommgbqfskKe0nKn9GN0t598VvelPCW6Ov7CzmNoAR/Stu0lIw+M3AB90hB47iyHO1covXX5M6q
 yKYahjPCAEsR71EhYORaqIKscazE0lRKgmJQg8bVj/IHII1DoJOOYNdSWBnFHAMcdDBW2yMKl04
 tgjuS1BNJ0cWqvdFdXd805GDgDlZJvVj/QsV+dWSDQfMDLNWuS35UvY8F8dyalW8ZSFUINl8jcL
 opwt5RKJ0nQw2HYtRywAMxLJQgWNq7jbshdr8SCthPbR2deT9FjPh1B0Z+Dnnuy7A8EHls+jOI
X-Received: by 2002:a05:6000:230b:b0:436:1597:7c7c with SMTP id
 ffacd0b85a97d-4379d5eb3d7mr2243792f8f.13.1771007235492; 
 Fri, 13 Feb 2026 10:27:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ad0166sm7172724f8f.35.2026.02.13.10.27.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 10:27:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/5] page-vary: Build set_preferred_target_page_bits() as
 common code
Date: Fri, 13 Feb 2026 19:27:08 +0100
Message-ID: <20260213182713.44924-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Allow common code check TARGET_PAGE_BITS_VARY at runtime
via the target_page_bits_vary() helper, then use that
in set_preferred_target_page_bits() in order to build this
method once as common code.

Philippe Mathieu-Daudé (5):
  qemu/target_info: Add target_page_bits_vary() helper
  page-vary: Expose TARGET_PAGE_BITS_MIN definition
  page-vary: Use target_page_bits_vary in set_preferred_target_page_bits
  page-vary: Build set_preferred_target_page_bits() as common code
  page-vary: Inline set_preferred_target_page_bits_common()

 include/exec/page-vary.h          | 15 ++++++++++++++-
 include/qemu/target-info-impl.h   |  2 ++
 include/qemu/target-info.h        |  7 +++++++
 configs/targets/aarch64-softmmu.c |  1 +
 configs/targets/arm-softmmu.c     |  1 +
 page-vary-common.c                | 29 ++++++++++++++++++-----------
 page-vary-target.c                | 25 -------------------------
 target-info-stub.c                |  5 +++++
 target-info.c                     |  5 +++++
 9 files changed, 53 insertions(+), 37 deletions(-)

-- 
2.52.0


