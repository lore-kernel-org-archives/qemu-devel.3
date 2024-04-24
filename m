Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03919C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzggQ-0005JK-1j; Wed, 24 Apr 2024 13:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzggF-0005Gj-GW
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:45:15 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzggB-0005Z1-OB
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:45:13 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-347c197a464so46853f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713980709; x=1714585509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ml+4qNbbwrewfNa4tKqFrq9Yee47wMDeCNmhWRp2b6s=;
 b=mmqRn2sWKxKWFqDbRi1SWv0AMAPn0YKxWhD+Mmap2tV+ILnHP0RezUrhhSuL3+a5oQ
 URLQ7VZTbccfVtyjcezzow5RjaUOi3Qmi/5zrNIiD+88dIdOp+QvfaUPouuPWaEmucpX
 LfNzvFvRnW7B7MrzgGvZLfUjwcwV+YavcyYle6Eh5Km3vBRJXD2u9aJR9zPsBvbV8k6u
 bNZ0bggLB4zRmyc81aISpyq3lRZ4rcsBWEJnhaNeAJBwMCvgDA00SVkqNb3ejlfgXoi0
 bh4r12awrD4taG2VqGfsTFdJfZrvoeVkbX4ev6LlYF8okrXHVWoIOt4GpZn1+H/rW5Av
 rpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713980709; x=1714585509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ml+4qNbbwrewfNa4tKqFrq9Yee47wMDeCNmhWRp2b6s=;
 b=Rs6Ge5+NOGPGJ/yw4I1ePLHqKwA0BD2B6zxHZaraU+3KEV1jfbZK8dIZGy3a8DUkMI
 2aJSm8FRDBpmgeraNRa4KLHoooehmt2Y7JHbJbeF/faVaWfoTTyj6EaohI4wHBRemvWI
 lESIYKqXWxR390pN3SBLsQOVBRwO+NXCFLqwQxndB/WU+IFramv/WOWxBsJDRkVp3+Jl
 mKFeKOl1iVOrIqrmoMjNP6D+o2eRLJkQ0blmLnKleMdJf2SAa3PPdSI94ym5VEJivTqD
 Fy3hBfIm3Bl+Ivo7nt9r/Nq7rrJSU5FHRb02ZxyiX540td4AZKJlzxAplsoW6AkLEx/b
 mI9w==
X-Gm-Message-State: AOJu0Yz/y0AJmSQoHAxIrA6qp7JqaEFSWyIUmx+Sy5glWOgCdyt3yROs
 wz4SHE0GsxCS2mauzpqTXkEzMlbFJPSs01DG/9rxQFEYdNEPYnkOulx65NtSP7xzb6Eb4LUoVhS
 n
X-Google-Smtp-Source: AGHT+IEm6fgQaSqX1ek6SlmYV0yiyp6MHtPp6J201wnsB2FAbYUmOGPzSy/L/prUfOGY0hOZ75QLag==
X-Received: by 2002:adf:fb0b:0:b0:346:d12d:fcab with SMTP id
 c11-20020adffb0b000000b00346d12dfcabmr1726298wrr.65.1713980708973; 
 Wed, 24 Apr 2024 10:45:08 -0700 (PDT)
Received: from localhost.localdomain
 (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr. [176.184.51.42])
 by smtp.gmail.com with ESMTPSA id
 f3-20020adfe903000000b003445bb2362esm17616085wrm.65.2024.04.24.10.45.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Apr 2024 10:45:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] accel: Add new @dirty field on HVF/NVMM/WHPX
Date: Wed, 24 Apr 2024 19:45:03 +0200
Message-ID: <20240424174506.326-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

We want CPUState to only contain fields used by common code.
Start using a specific @dirty field for HVF/NVMM/WHPX
(TCG then KVM will follow).

Philippe Mathieu-Daudé (3):
  accel/whpx: Use accel-specific per-vcpu @dirty field
  accel/nvmm: Use accel-specific per-vcpu @dirty field
  accel/hvf: Use accel-specific per-vcpu @dirty field

 include/hw/core/cpu.h       |  3 +--
 include/sysemu/hvf_int.h    |  1 +
 accel/hvf/hvf-accel-ops.c   | 10 +++++-----
 target/arm/hvf/hvf.c        |  4 ++--
 target/i386/hvf/hvf.c       |  4 ++--
 target/i386/hvf/x86hvf.c    |  2 +-
 target/i386/nvmm/nvmm-all.c | 21 +++++++++++----------
 target/i386/whpx/whpx-all.c | 23 ++++++++++++-----------
 8 files changed, 35 insertions(+), 33 deletions(-)

-- 
2.41.0


