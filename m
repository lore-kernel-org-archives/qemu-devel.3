Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9622FC531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 18:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnhGp-0005ZA-GY; Sat, 25 Jul 2026 14:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dubdublan1987@gmail.com>)
 id 1wnfc1-0005RK-GH
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 12:52:33 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dubdublan1987@gmail.com>)
 id 1wnfc0-0006Wx-12
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 12:52:33 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2caced6038eso17256185ad.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784998350; x=1785603150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PmJO0SuxHrPS+VQPA9MfrfcxKZ5WavZGciWI0XW6mz4=;
 b=Cd4IIRYCdoyATUgdAYUtX/7xCuJLGQrodrzL7+SlPqg2LAawic86i/607fob7SumGg
 kjyJN3nlpimYodkYhml7TXn5BNdzpZyTRffvmQaGybkIvkRXDZoQpf+CZoex6ZLmuS0v
 CrtMfUGb+6IWbvQulSgho2A/ORTFuGLUx+yzr67lj2WLevVkj/ljaYAkvDDJ+HQcH384
 hVnf93eoQZEQV2MS71EzaXhz7Ur3y22HpGHO50j8K2aEHUSTS/dMEQXs4nzISPNijvp6
 28q4GyAnDmDnIGWYgpemYH2h4Sunsa2ULEZ4RBo6cI0IOWmP/4UFBRWl2YNoMVEHmoG7
 uO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784998350; x=1785603150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PmJO0SuxHrPS+VQPA9MfrfcxKZ5WavZGciWI0XW6mz4=;
 b=dhVNgCR1o8lGF5EQXYa+Lz3xLOOCDIbFUD6prLL61CiVcVH2yOmV6ump5lqGCCJfpo
 4pbZhFYwzdm6nLbQqz7/UWJlTstKS8xIbIFwSK3BloSD4vqQcKGg+xxSAympYK1Xz0HR
 I2qI1TREk8CL1z07gIY4SC3xJDVu67kRgwkeeDU6yRuvbkHi8FzRYuSWTq+aCQFFoXls
 3YxyzEmbtJwmjN585e7HaNk827Sa5wR4cUnHK/tNjAqAPIlilkzv8SpVCHPxCKEfURzL
 IQ1tmb8VElVx8VcMkzZUXhjYODy7Mc/S47ktqqvbJ/E1+xNImS743hCTSw069omQdq+f
 0bLg==
X-Gm-Message-State: AOJu0YyDFaE2kBB8U3aoh7xkVH29z/nRtrOLNl9dUHJbDnpmeSSApmE9
 ZtQLaGLj0pbIZ9P7p8fFqSWnPK/iqXuTgupIfOyxsqg6kLlDKNYy3wzWGrmuf2fGD7OhjQ==
X-Gm-Gg: AR+sD10vU9tA+SNSV5We0dPuOSkj8id8mpiLLIiSbDkfL/NUYNNyLBisrs10xkXWEyW
 dE1GujJcZZ4Sivc594tbTMb8n3frqJU8b29hnxyjezrlbidBVqxVsGmL9m1lf78Km8b+PBSG0YI
 8avQ+9TtXQF1KdwydeTBBSB0j6/rJD6onSBX7oEpbYoyosXnA7a7Z3pZTIaTNpptbSX9KUrNgua
 HK+JQ/WJLLvKGa7UE4Bw83PvEcPB2aPbup7OoERo4ecEsavMjurmbnFmdn95sMcuEfs2Qu2wd38
 06Ct2a3vyvoZcMj0YqbxfOgXiJAp9vRLwjbs5E3T4nAtE4PVtiAj7kx368fCZLlImTtM4eAZK95
 3xIuR2cRr6YlJEl0iXmov/MbWtNldofMe/4cBV7JoB/RwL3msp9Kalvhs/fmCh+QyYYuSOnSKyr
 k6pn94TmwrEA9UaTUfnS0OPRQ+xYN0Dw==
X-Received: by 2002:a17:902:ce10:b0:2c7:c385:c5a7 with SMTP id
 d9443c01a7336-2cfd72a5398mr44873695ad.26.1784998349869; 
 Sat, 25 Jul 2026 09:52:29 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([27.115.61.146])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81d81csm11027105ad.80.2026.07.25.09.52.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 25 Jul 2026 09:52:28 -0700 (PDT)
From: lanxiaoyun <dubdublan1987@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 lanxiaoyun1 <dubdublan1987@gmail.com>
Subject: [PATCH v1 0/1] *** SUBJECT HERE ***
Date: Sun, 26 Jul 2026 00:51:17 +0800
Message-ID: <cover.1784966571.git.dubdublan1987@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dubdublan1987@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 25 Jul 2026 14:38:27 -0400
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

From: lanxiaoyun1 <dubdublan1987@gmail.com>

*** BLURB HERE ***

lanxiaoyun1 (1):
  hw/intc: resample level IRQ on PLIC completion

 hw/intc/sifive_plic.c         | 4 +++-
 include/hw/intc/sifive_plic.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.43.0


