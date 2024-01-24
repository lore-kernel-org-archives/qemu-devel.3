Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761C6C47DDC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 15:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSfaF-0003Z4-AH; Wed, 24 Jan 2024 10:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSfaD-0003YN-CM
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 10:54:33 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSfaB-0002MT-7M
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 10:54:33 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-337d32cd9c1so4962932f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 07:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706111669; x=1706716469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BK/V9dj5YhGk0iLWuoz8QxmPAwCjQLFlhcHGZGmRcrA=;
 b=A45BWDTwJPswzj1c8EJFOY35BoVLhiIaaPINgUnDLlpsg88vuGtY1O2tDlVHquYWTz
 l/Zn6Marm/xsKyO5AKGC6eMGT11qezmohmFOxK70cjvIre2zeDUnTlETyxKCpWXL3qJO
 9x0+VXbpUqz4lfIvx/GdG96+LTrX7V6BMCFUAH6maqWCnlln0fdOi3KXuumR0NQ2e4+v
 lVH2svZtxgbGDIqO5T2T9X18od12/qmEYWA6ScpFL5jB3tejjBIyf+fcjs2w/63ez200
 WQoltk4evhBotxkaoEBUOOwSCBcg+Ue9G2fHFJuV2l5cxe0flJIShkFBOF36B6IUbLcU
 D+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706111669; x=1706716469;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BK/V9dj5YhGk0iLWuoz8QxmPAwCjQLFlhcHGZGmRcrA=;
 b=jD1WOv4qwBBUxDHAXxuuy29x2TzQysbgRCuCZqP4Zi5ay5Pxi8qRYon0W95KBD92In
 IjUYktt18PR6uVqMY9h7dsHCWzlFta5ZJ86F+vb1owwGVTH8pZPtKJDnpg0JTN9GOCAV
 XGh+YEiI3qbKNEQWhcnI7FNgWXw4muFY9vuWWdGRkdODAISIH/Vbgr5dql3woq8O/hm4
 ZJK9L/izXGGgLlQaGEXqyP/qTrP5RXP29xySXjAaKxgscH3CuL5bKHeSISH3Q8rJdA2G
 47wqIKdG7Lj5YjdVV5XRP8Chx6RZthfTO9bXFi57zhVVm5QeDIp8AH3tr8kyqHj/Rgn5
 HHew==
X-Gm-Message-State: AOJu0Yz5Dq+s9XhCcRKtwVQS5hP73o/KCNRsYgQEwUZBGY1V/7ap4NZM
 LZWq0EZlkteRx8Afk8qVAdjCUmb1B+QVqJ1fJzOPSlJtOOyj5G8nwbusBmv4hx1L4GSFoo3CsKn
 z
X-Google-Smtp-Source: AGHT+IG2MtMetZMY4/fR+PXshiy11q1zfCHCJ3qkPsPw0ct+u49aNQGsO4wE8N5S1kr6GfY3ceeUyg==
X-Received: by 2002:adf:eace:0:b0:338:fcdc:ad19 with SMTP id
 o14-20020adfeace000000b00338fcdcad19mr698831wrn.6.1706111668791; 
 Wed, 24 Jan 2024 07:54:28 -0800 (PST)
Received: from localhost.localdomain
 (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr. [176.184.8.67])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a5d5711000000b00339273d0626sm11842179wrv.84.2024.01.24.07.54.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 07:54:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] accel/kvm: Sanitize KVM_HAVE_MCE_INJECTION definition
Date: Wed, 24 Jan 2024 16:54:23 +0100
Message-ID: <20240124155425.73195-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Trivial replacement of KVM_HAVE_MCE_INJECTION by
KVM_ARCH_HAVE_MCE_INJECTION (not the "ARCH_" difference).

Philippe Mathieu-Daudé (2):
  accel/kvm: Define KVM_ARCH_HAVE_MCE_INJECTION in each target
  accel/kvm: Directly check KVM_ARCH_HAVE_MCE_INJECTION value in place

 include/sysemu/kvm.h         |  7 ++++++-
 target/arm/cpu-param.h       |  5 +++++
 target/arm/cpu.h             |  4 ----
 target/i386/cpu-param.h      |  2 ++
 target/i386/cpu.h            |  2 --
 target/loongarch/cpu-param.h |  2 ++
 target/mips/cpu-param.h      |  2 ++
 target/ppc/cpu-param.h       |  2 ++
 target/riscv/cpu-param.h     |  2 ++
 target/s390x/cpu-param.h     |  2 ++
 accel/kvm/kvm-all.c          | 10 +++++-----
 11 files changed, 28 insertions(+), 12 deletions(-)

-- 
2.41.0


