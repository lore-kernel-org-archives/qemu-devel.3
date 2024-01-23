Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F3CC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 18:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSLk3-0004f8-Sm; Tue, 23 Jan 2024 13:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rSLk1-0004dn-M9
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:43:21 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rSLjz-0002me-Qa
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:43:21 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D28204032F
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706035391;
 bh=5j3mVdGTDGaCWMdmDtFz1Oq1qeObw7oJUX1aePYiZRA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=UW40Gixl87DJSCe1sx3RZcxR28WHHRNCjwnAvv1fnJ1SP+jJRtrZNHYFhK1wwgdS9
 rK6wT8LrI9kJCVyyAISd0rwxvj8h1Fj0MGB91VeK64p1WbGdFqbPISH0wmut4l/B0a
 lsR+5LfuFQLEQc9yOxMFWLITEV8IHCR8SuIevFdBlB/VRXms28Tupi414lWy0Aot1G
 e5xwmmY9Pp5k3415ChqCrU+z87lULcJpLeOO1ifaWXSbOEsLPiqMELa9hB5ZFRKY3r
 pi6PG3bq4jLzDiwgdyJL/RrRgQYK/C7tkeIshjhmWp02CXHxZJijgArlUCydKa3f2u
 Fdf8aEJKH9iPw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e412c1e65so40383895e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 10:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706035391; x=1706640191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5j3mVdGTDGaCWMdmDtFz1Oq1qeObw7oJUX1aePYiZRA=;
 b=Buq+S3+5WCMddVZGOhYSR8lrKRas69SH7O4H6R26ASsU+kTPsJQsrn+goYvPeQ/A+q
 yRSd7KxIi5NXqhJL1piMuIs8H7dl9pM3cgMCTxQqOBZjA6X9/1L/BjXsDbAvZkU0VKAZ
 FK+C5G1EVwqBZi3E7kCyKslIKrkFDVCARK+czuM4hS+lkTQCCrkpsC7vpU37de/AZlWc
 v8ldxyZRSRFyYwVpra+Cz2YfUO8LWBUcsOqui57HzAQvpkZzvCEIkRfMjwIgiF7xX+8B
 rlEobLhpUDoiBM+Q08HKF78SodNhYhIztzVYTTDpaqUkcQGhIv8FVgdBNiE+zgqgnjng
 qemg==
X-Gm-Message-State: AOJu0YykR75ei0CHaSwdlPgmrvs8nSA0ATnbh0/dTq3fObhcs5s0p4Mc
 BQqJrrGWR1ft2/cJHVZHS24gN4bRxt1M6B9GIECTD4btC0zOt+z2JPXHjKVsDXo32fq4vT8loo+
 RemdJxSEJ815B0wpLWvSBkelUmNPWa5lr6z+HsBInb+lr7YDdM6vkPUjV+AsdG9JBduaz
X-Received: by 2002:a05:600c:56c1:b0:40e:71b9:65b4 with SMTP id
 ju1-20020a05600c56c100b0040e71b965b4mr743490wmb.133.1706035391015; 
 Tue, 23 Jan 2024 10:43:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGHcpIGQvddEb5oSLcGJah5hXJAW/KnwvLbR72bGW3HvOqGgzQovLQkgOSYDjHXRwqOo96mg==
X-Received: by 2002:a05:600c:56c1:b0:40e:71b9:65b4 with SMTP id
 ju1-20020a05600c56c100b0040e71b965b4mr743486wmb.133.1706035390624; 
 Tue, 23 Jan 2024 10:43:10 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a5d6ac9000000b00337d392c6c3sm14180252wrw.13.2024.01.23.10.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 10:43:10 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 0/4] target/riscv: SMBIOS support for RISC-V virt machine
Date: Tue, 23 Jan 2024 19:42:25 +0100
Message-ID: <20240123184229.10415-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Generate SMBIOS tables for the RISC-V mach-virt.
Add CONFIG_SMBIOS=y to the RISC-V default config.

With the series the following firmware tables are provided:

    etc/smbios/smbios-anchor
    etc/smbios/smbios-tables

Add processor-family to the '-smbios type=4' command line options.

v4:
	remove a superfluous #ifdef
v3:
	use misa_mxl_max to determine bitness
v2:
	set processor family

Heinrich Schuchardt (4):
  smbios: add processor-family option
  smbios: function to set default processor family
  target/riscv: SMBIOS support for RISC-V virt machine
  qemu-options: enable -smbios option on RISC-V

 hw/riscv/Kconfig             |  1 +
 hw/riscv/virt.c              | 42 ++++++++++++++++++++++++++++++++++++
 hw/smbios/smbios.c           | 20 +++++++++++++++--
 include/hw/firmware/smbios.h |  1 +
 qemu-options.hx              |  6 +++---
 5 files changed, 65 insertions(+), 5 deletions(-)

-- 
2.43.0


