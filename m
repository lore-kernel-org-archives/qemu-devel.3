Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD89DCD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTVh-0000wa-Tu; Thu, 28 May 2026 01:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wSTVg-0000vn-Jz
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:42:24 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wSTVf-00029a-4y
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:42:24 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b9e9a6802aso54362235ad.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779946941; x=1780551741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iXlEBQFARya9w5G9G6vIm8DPauRPVaa2jUxbs1FkK9M=;
 b=Zi0kDj+KxxFnm6tK13ASANtyKj6racxRYuD0NDWiHHk+XRL+8hgEDwQSvLz1DhpxJT
 PQrz82SEQCuhV6T4SRAnu1M0A2hjJ7M5K9wmNojhxsRhPrsMqRB9cZmJh9483hcXx7Dw
 69TBUKe4+l951o4BiaZvz3k9P4fnMvSHXTL8l5DofhXdpQWztokFCMb83b/iVgqKGTTW
 jBZJVjvQ0pISJlAMEV1EIRsL77ISAwpU2mu/MtH2cRWpBpNPN7r3n+K5FEN39Iumhpum
 B9w0Mt6v0w2zZAwoKMJHUnK34+82aQjIFUkIcY39fFab4QpNBQB6+xiy1OFQHH9S33vB
 DkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779946941; x=1780551741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXlEBQFARya9w5G9G6vIm8DPauRPVaa2jUxbs1FkK9M=;
 b=EPsWGZJTTwew9jwuGfeeMMYZlsaxLdqKCEUwABXy/awvT9z4kgmrKEsPgIPYGBM94W
 k03dhPa+984TZWak4LQbbBpZEdL6gSQHjSuS7UutJtSxlWkmKpVKQzMRGRulZQuimAE0
 4t7umUqBleZAIM/ym9H4o1gug2NYuMs3qw9BamMRWa2pfPhw/MI94PyMRqdzeruiVmbu
 Uhv7xPWMuEweoBJ4Pzok4yO7Hnk936IfYORhsv73L3oG4Vc/Zc4UNIufnPOq1UQJ9Etf
 oUVE+Pr0qjpQ1KnvxQeocefGt/og+nyvC7wm7llKe0oSIDdLxp5ETz6Id++sp72YDnd2
 smlQ==
X-Gm-Message-State: AOJu0YwbjrbmKUzsOZrz7COhuT2EMS4bS9idweowOkaZYCuXMQstDZ9l
 uYo6SUnJXqUZWgscx4FD+5nKiJUO6DCxixCJTMrUnECfDD9tYDWWsaLKDjrRjxOxldspYTkAqoQ
 UYJDg0GNNh20FJGPCP5V/Mwh4Bos/yyIoCgfYcaYSoOcgDA33rHokVA3/lIJ+EPnqQjH66B/CAQ
 0y9Kwhgsu4hiRkTZkkuZMcaIct80Fi8WfIt38HterNMupul3uk
X-Gm-Gg: Acq92OGh7hK5RgRl/i6d6RAWZEMKaJFLQA2vYEWlAvtsIBfLIjgg0vfZDW5Hyfhc9YQ
 gyvmitdR1X+ZzGNget3C4GwxD7NqSM/hs+p1bdgD0wiHmPM6bCsNMG0poc+D2EaSKccd2DfUZg9
 5cG9P5MB/i8wEB/0BCvdGMRgE3wznfm2kM5yYl+Jh6YvCsspF48gPDxEoj2TZc+PEaHunx8i709
 cvr0n93ep5EqNczrV+02tLln1ltirVGrH8qtdqU6U8gNsnrNeBt/8CxoGWUoZRVhtIJqp0hUFCU
 x4uosx2ssNm+XrmPd7t8TJrr1RFfzNn5LxJ0ctei7eJmhsGTu+zhMnav7/GbKi+1If28z+Rhx94
 nwulm1+Z98bvPmBIj8sP+aGCBw7sPcJ7UXGpldwVhhLwoDFAWWx6baIHjlYgWRF7FtBLgKFSJ3E
 6cWnBFtlEExwc1GHB3uqAsW8hsXkw6PFWe2uzPq3REv9n5cJ04h7vm7bN0SXc4
X-Received: by 2002:a17:903:1a07:b0:2bd:8822:d8cb with SMTP id
 d9443c01a7336-2beb063193emr290830825ad.23.1779946940991; 
 Wed, 27 May 2026 22:42:20 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beca535bc1sm122275815ad.56.2026.05.27.22.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:42:20 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 0/2] target/riscv: Add the implied rules for G and B
 extensions
Date: Thu, 28 May 2026 13:42:11 +0800
Message-ID: <20260528054213.678458-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62c.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add the implied rules for G and B extensions to enable the implied
extensions.

Changelog:
  v4: Add 'target/riscv' to cover-letter subject prefix.

  v3: Keep riscv_cpu_validate_g() and riscv_cpu_validate_b() but remove
      the auto-enables as the implied extensions can be enabled by the
      implied rules.

  v2: Remove riscv_cpu_validate_g() and riscv_cpu_validate_b() as the
      implied extensions can be enabled by the implied rules.

Frank Chang (1):
  target/riscv: Add standard B extension implied rule

Jim Shu (1):
  target/riscv: Add the implied rule for G extension

 target/riscv/cpu.c         | 26 ++++++++++++++++++++++++-
 target/riscv/tcg/tcg-cpu.c | 39 +++++++-------------------------------
 2 files changed, 32 insertions(+), 33 deletions(-)

--
2.43.0


