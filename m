Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91ECCF9C73
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st4tx-0003Di-7M; Tue, 24 Sep 2024 08:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1st4tu-0003Cg-Vt
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:44:19 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1st4ts-0005sM-0s
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:44:18 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5010322c1c1so1710756e0c.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727181854; x=1727786654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bD/viDo6JM7IXonR+1a6W+9s+7PzvfpmT4iPCS6+01I=;
 b=MS+Jsvw/mu8dpIJMIxpdzxsidNRZOSpIs8E2vSC5E2J2MHClVKnfhldi0bCUWPvVX1
 2AmD4TNPjorIo1mfUr8InFJuXLSV5HEQ59lhInuP+QGkZ1KDSaW0BjS6wJnRHF8UTBzF
 Yxdo2BGQzaSNf46IClYN2t1MVMu336rKOw6gNyvPrMpYQl0tHjvGYewPMQx6QwLOIbLT
 4h0GoDIyiijbP8b52YLDwy73DVXLUQ5wVgjS7LxYetsRfx+qKQDJxqIiV7bv/Reys8Ms
 eOFSaalHW0HSbPbZK8XTJiu2ew0T2pg7uyZDjKVD9UXgVsk2tj15fnG1dhGN74tWWX/W
 ZB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727181854; x=1727786654;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bD/viDo6JM7IXonR+1a6W+9s+7PzvfpmT4iPCS6+01I=;
 b=TRc19SoDvjdQaRonHRNoSZSWKtrN1PoVW6zwQc8dNDexD53zVfdyx6AsVRtbm5VQo9
 dpKSdxJ0WAxfD5fiwMNVzMnC8rfYwFmV7Lz8r2jkPqYwSQ7Kjk5QEwtocVYTI5w/6GaW
 6+mPF4VmirVr88u9JTqmj1fxDDQt00SPwLGk/HAPGC2vVEJsVyu+KYmMi6XRre3dvLsf
 69L9VcDx9MmGhbj0BZ0YhRwwzzEQkvTt/ziBXwZc2TZkkPW3+0zCj9FHkltAccsI3/+p
 5B3MMsOJBrGThAPLk/F2I9rdcGL2lUMqfDFgG6TS4BIpIRcXiaJWqNwL6AKkcY1X1O1q
 KunA==
X-Gm-Message-State: AOJu0YxqLQAuYi/kGEVi6DEVuUoHFT+afP4D255N0r5OZ5X7RrfMQFK6
 kjQAgJh9ixZTV1caVh4hOubSASIwVcsUGU5BmQdkXANQOBfb5/GHqM9gRJ53fY+wY42WZ0ncgbC
 o
X-Google-Smtp-Source: AGHT+IHNgBeO7uOrUElIpEnwXxnx9ZDS0+hJMUpY153CezwkxunBtrpzZxGSkePiSPwIuWIvxvMSLQ==
X-Received: by 2002:a05:6122:a1c:b0:4f5:1787:18aa with SMTP id
 71dfb90a1353d-503e3bbd764mr8746689e0c.0.1727181854350; 
 Tue, 24 Sep 2024 05:44:14 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([187.101.184.93])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-505aa10a8fbsm767830e0c.49.2024.09.24.05.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 05:44:14 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/4] target/riscv/kvm: add riscv-aia bool props
Date: Tue, 24 Sep 2024 09:44:03 -0300
Message-ID: <20240924124407.766495-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vk1-xa32.google.com
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

Hi,

Boolean properties are easier to deal with in the protocol side (e.g.
QMP) since they don't require string parsing. We should always use them
when applicable.

This series adds 3 new riscv-aia bool options for the KVM accel driver,
each one representing the possible values (emul, hwaccel and auto).
We're also deprecating the existing 'riscv-aia' string option. 

The idea is to use the new properties to enable AIA support in libvirt.

Patches based on riscv-to-apply.next.

Daniel Henrique Barboza (4):
  target/riscv/kvm: set 'aia_mode' to default in error path
  target/riscv/kvm: clarify how 'riscv-aia' default works
  target/riscv/kvm: add kvm-aia bools props
  target/riscv/kvm: deprecate riscv-aia string prop

 docs/about/deprecated.rst  |   8 +++
 target/riscv/kvm/kvm-cpu.c | 100 +++++++++++++++++++++++++++++++++----
 2 files changed, 98 insertions(+), 10 deletions(-)

-- 
2.45.2


