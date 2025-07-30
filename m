Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4CBC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvDx-0005L4-NJ; Tue, 29 Jul 2025 21:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCO-0002vy-2q
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:40 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCM-0004hk-7n
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:39 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-315f6b20cf9so6775258a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837296; x=1754442096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aCYPR2FiJ1QAY3BBIXtKExP1YeShrtPgpJYXL8zq0L0=;
 b=PSn13BwEVf4X8fMKDoyle71WhTLY18XUqnAmLbcjuj+F/uUg0/lYDwp46QNFDVtdCU
 7uwIpQikATaFzX9N82wXiXZNtRhCH532e8jMmeu1jNl3mxwtR8aDEbUQu9Poe9kAx259
 y+4yc3VAGxk4VORQmUOf1VXdAJVfNtYYfp37patvX+WGEF3uo8yB2b5i8lMqSGh9yrGb
 vCSyndTeQko2i6wzmYuQ/v8tQCGZkFwH9bmJmA5sR/p+dJNb/ktMzkoEtdo4OdOF8Vhu
 nqNMLutYseRFMwcuGR8FS07t+1xno/GpO/jzcU5Ej4ZDZ8xw6mLJIFvxuyZv7qzKGJBv
 u2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837296; x=1754442096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aCYPR2FiJ1QAY3BBIXtKExP1YeShrtPgpJYXL8zq0L0=;
 b=fN31iX5aQtKOYhlyuhDSusmFv0pMmoja2X8mkjZKFJMMKzDcpu7XuvbXmrYcZvsVIc
 ZcJ1i0YTtH4UY5w4sbiZLnplseorLwc2y5B+JR28HTqZTa205+koF2VHivCP/TNueLMG
 9/RrKwva2+nGC/qerHFG54Yxuc9yVxr4VwKbVegVTTYmTKJDdqIzPdLnsCaACJmUWwE6
 l4pEdLWtHxeaDSBNAXSvYJTnDIkKb8V9OqjG7+jemOxY9Mx4iuXtYehgksuaeZxdTZqB
 87zXfLl4Zd6Viu1wSYT2fUyw6gvwHWYrfHzUr+xlyze7v6H1P+OiiW9eKGJWHfWrBnHD
 /jJA==
X-Gm-Message-State: AOJu0Yy5kI/8qnE6N5/lwpS59GSLfFqNS2BsywkoS11yOBB95P4quhCc
 tC7A3T2mPxUZR1cQ8/F/heD2HbxHjdVu+Gq1O3huduFqoP5JadeJx9BtYeqAcQ==
X-Gm-Gg: ASbGnctUOabJKlQubCPTewPtAEMZrAHc1Pm1qil9oXoA5Nv6mUlQeZdc6CRZnPCqLzo
 GIrJ7txsHqyq+ggS+Un7VU1nXh3ll7jWsKA+2khPNnml271IjRy8X6tv46LSEEV76/U6l6pKOCB
 BmhVCtSmb8vTOQg3I8y0Afb0DFkl35CdjcDBtcdxxZAGe9FZqvGD6WVk0dKrzvhXalEgxLK/l4G
 cedMdGLwaDfPLb+hQEa5lvSnJXf8AuP1eRyLVtzgsASGtynlfXnsFrMIEJCdMlBCVSFdhpzy3M8
 kKWCcP7pXtZ3alE7h3oPt1xxJW+h8V6HJuY2WyHZVMf9ofqUQCmn4j5nNqaTXd5rSCF76VxSkGO
 fN5G457FaxVHx1MNOBfFgig5TbLV1hq3/W9Z7u7HwbjO65S0RBzFZjwamX1v8uM9cBW3qJWq4YW
 5D9r9PKoEXaSwgh54hV97xYFiLNTg=
X-Google-Smtp-Source: AGHT+IFlQlGf3DIp9bOWYiGllUc9T8tEATH2DhGIJGkCizb41uBhgPYHijpEzP4g430cdlil5jJlfg==
X-Received: by 2002:a17:90b:1ccc:b0:31e:d2a5:c099 with SMTP id
 98e67ed59e1d1-31f5ea4a331mr1886794a91.30.1753837296190; 
 Tue, 29 Jul 2025 18:01:36 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df5adfsm343253a91.25.2025.07.29.18.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 18:01:35 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/11] bios-tables-test-allowed-diff.h: Allow RISC-V FADT and
 MADT changes
Date: Wed, 30 Jul 2025 11:01:13 +1000
Message-ID: <20250730010122.4193496-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sunil V L <sunilvl@ventanamicro.com>

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Message-ID: <20250724110350.452828-2-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..0c3f7a6cac 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/APIC",
+"tests/data/acpi/riscv64/virt/FACP",
-- 
2.50.0


