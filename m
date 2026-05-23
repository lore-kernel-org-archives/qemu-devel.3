Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1C8CD5BAC
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 12:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQlnM-0007gz-QS; Sat, 23 May 2026 08:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wQdFW-0000Kb-DG
 for qemu-devel@nongnu.org; Fri, 22 May 2026 23:42:06 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wQdFU-00011M-PF
 for qemu-devel@nongnu.org; Fri, 22 May 2026 23:42:06 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5a877510541so9125781e87.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 20:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779507722; x=1780112522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qFVAp6EFQDNV6TsONcqYfIVwYqHKqy58kia4nBKKXNM=;
 b=T7XH/1t5anCslUy6Zv50sMARLlfO8E2ycxL6T/TMd8y6qepKNQUK0YbF/cvTu/1Diz
 D3dNU+Kcqmg/sGHlznEv3Dfj21bEYaphyGMFQV4xYSlh/eDwUa682xmku8JPrrKAYi1J
 mqnPTjb+2kDOejtMXZ1dh5MW5YMXfJ9omDverdSyPPNKIpaFJZtmogsyNC+zjpIAWEYt
 1ymlaPMHV5B098/uJvuJLsu6McK5EsliKrxTNnqfXUQMi+ZMR//Lpbg82EWF2KTHEJ2N
 7qlSKMuVvSKFXGK1ExHxSGvnOfQDvhOwTF/g3hAIeNAzPNXJRX/Vcb2GAkfdsFdEtejy
 Blbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779507722; x=1780112522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFVAp6EFQDNV6TsONcqYfIVwYqHKqy58kia4nBKKXNM=;
 b=GcNZ94lW34wT1ucNZ/9HtbA2r6r78aYDI+TcwD5pZhrlwKzHzmy8gtetVCOD5I8P5X
 N/ndxjuIfMdwsUec4NU3N7D3SUgGhK7BNGXPA/V61jMaAAcNlDvfi/q7xlJ3qBaR3d8Q
 6jvM4MMSFQGACDwp0EvmsuzZrv53VJrOpNCGZUe3tO4mR5dNsQuAJ8ImS7eRP1XRpfaA
 X6os48iug+5Q2vnR3X7FgHbqi2NTk4jlJOqUpnhzFpyeq14T7WxLch51p9n1fgS/pfBC
 +5zZ9ZICm+58U7nTm8b386sQo7yJZlBptinYdFLz2Z13EtpVrM0Zx761tb/Lx6lRWBs2
 dc4Q==
X-Gm-Message-State: AOJu0YxHLZsdXjPElOWh/+y4DPgvvqP+k6QqGs4aAz5Pr5dRsliPiIlQ
 sOppOpfONAEDx0HFCApaJqIBzVYRB7d2lP1mZu7hH352vZ9pl2q1I9IO6GeTDnpl2p8=
X-Gm-Gg: Acq92OECibYnkoL1hD+0nnLx8VNdiqvna7euH6jjTYPdTSmV+YmgRCI7vGNMj04349R
 tPl6Bm6ZWG7P+6rN5zyyeet6CTf8MR60z27mDr68Vd1vKo2K5JhDjpXfO2bsynohtOOue+pPGv6
 RsYU62fED6rr735gcOyF9PQgx+2xlhmXC8B2RWMyVhvdSAqWfqjZz1bnL9RlOwiMBvjwuj1GyEt
 EKrotOwOOVUJthAPrn3sjqUfOKxrGf13I2vfxhBabavdXdl9rkzSxMkwpfHBrgDSATN45P91LYj
 32ooe71R5AyaMQ4JaKNqw5wJHlZGwc/PcanpYEDOSz9pJxNhNWtEC60blVzRTayoLaJNo+R9+7n
 rNmOPK5v2wH+A6dHW5e2XUzU7mYOSy45G8f1lCpfPPNacI6OJdH3OS+k8gurPYCW45ck1ujmICQ
 8DB6/kPpMqXzcX8MgRZ3hKQbtTErgUBZlWupVKxUr/
X-Received: by 2002:a05:6512:1321:b0:5a8:7f30:609f with SMTP id
 2adb3069b0e04-5aa3238b3edmr1663941e87.10.1779507722086; 
 Fri, 22 May 2026 20:42:02 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8080:c2d::1:2b])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cb36f6sm848685e87.4.2026.05.22.20.42.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 May 2026 20:42:01 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Alexander Gryanko <xpahos@gmail.com>
Subject: [PATCH 0/3] hw/smbios: Add dedicated handle range for Type 8 tables
Date: Sat, 23 May 2026 06:41:55 +0300
Message-Id: <20260523034158.57487-1-xpahos@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 23 May 2026 08:49:35 -0400
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

This is a continuation of the work originally proposed by Felix Wu [1],
which changed the SMBIOS Type 8 handle base unconditionally. As Igor
Mammedov pointed out in review, an unconditional change would break
live migration between hosts running different QEMU versions.
This series addresses the review feedback by:
- Using machine-type versioning (pc-*-11.2) to opt in to the new
  behavior, preserving T0_BASE for older machine types
- Adding a PCMachineClass field to control the setting per machine type
- Adding tests for both new and compat machine versions
[1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg03208.html

Alexander Gryanko (3):
  hw/i386/pc: Introduce 11.2 machine type for SMBIOS type 8 base
    migration
  hw/smbios: Add dedicated handle range for Type 8 tables
  tests/qtest: Add SMBIOS Type 8 handle base tests

 hw/core/machine.c              |  3 ++
 hw/i386/fw_cfg.c               |  1 +
 hw/i386/pc.c                   |  3 ++
 hw/i386/pc_piix.c              | 16 +++++++-
 hw/i386/pc_q35.c               | 16 +++++++-
 hw/smbios/smbios.c             | 10 ++++-
 include/hw/core/boards.h       |  3 ++
 include/hw/firmware/smbios.h   |  1 +
 include/hw/i386/pc.h           |  4 ++
 tests/qtest/bios-tables-test.c | 70 +++++++++++++++++++++++++++++++++-
 10 files changed, 121 insertions(+), 6 deletions(-)

-- 
2.39.5 (Apple Git-154)


