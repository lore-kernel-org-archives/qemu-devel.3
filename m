Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03E9FED2CA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Xia-0004Si-5J; Thu, 12 Mar 2026 00:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0XiY-0004SQ-5g
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0XiW-00041c-P9
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ab232cc803so3203665ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773289931; x=1773894731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OYYdNjSVoqD8tw5SUF2UUxZ/GLvusjzmSGWXXsSOG2I=;
 b=d5uqDZlrxJnNrxQE9kgR0dmwpamuHZoExOwxDYTcG2hv1s06/eYDG4/20yajdJozF5
 yeOhJ5FPjUCR8L9gtmxKzfkKLcRFjaXZe6UKf/pAjBYCufGlX/W/F/UjkT0wnkwGA99C
 H9X4NbUwWN2YJ5bX0t7Rxdj5IkDIaEKSmdPXbJVY++Xfl5wIA+zVT9P1ekFdhkQ/pYRr
 5q8Suw4x/CUKW637KahkstAZG2Q6Q1+exDwaiyKcDfp2rKCtyG0nU1FLdHWPq9v4uOYV
 ZHaufP6tr+xYZRpTAx30QqL/oIX+hbOEKNPZgdgBVKmz19DfmpE66DBj3/fmwVk6gHmU
 RSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289931; x=1773894731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYYdNjSVoqD8tw5SUF2UUxZ/GLvusjzmSGWXXsSOG2I=;
 b=XYKHZaKKWgZilvvgLCYmyGMxSZN8W6nnlzmIUl86GGZZnC9yfEUmaMnR+ew650VPrR
 Zrok0ADWJrgidTvC2re+1U+Rt89IwKBZD8xEibGB/bbL6nVzo8HslNtypV7LwCdeYCRs
 XoXf59SaqgTWmE5yHAwB81h4o6aTO1Lb1NDJ2TvvOXAdWWtAojkyxvTwMccEnWr4OyBl
 qhtEdDgSq0NT3RaFA5VgkxQ6ADFd8pAURS7YJ79XHLwz71kO+LGQsMNe6e5TE+dKzdPj
 hdnLwx/QPxKznAsTQoiRiAj7iQ0PKr3mZpW2nnAxSoHwFFJacSkc4VwoT2w8Ovl4M1En
 w6lw==
X-Gm-Message-State: AOJu0Yyf0onJM1lq3JjsoimcZXkKbMzw0ScPWdMWc16+ABFMYy+wmKM+
 +7xbA5i7dhkmml9DHmIq5avuL8bVLII68Gj/hLF9ZwzgYth8Zt6jQc6fMy2MBAPQ
X-Gm-Gg: ATEYQzwY3dti0pbPoQAijpLw+TGKKmc8kebzNOinusFTOo80vr6bte+7IHQ6BrzyDDh
 eDSo5FwvKMiVIXb3k8m99FqStGJqMUaj8bVXjMOBbepdYR+EYtdDZ1oL0Ah/nlC4bcID88IYhFW
 jJ/p3x2pzJYVGHbY2FniYRl67H+uarMGqTMeen0uuhBavN3wIrBXJ9Sx+5RnT0ToctFnqIV0D7e
 b0Wwh1vl3LTzRMVuezDW7nEEUlNypmIohYiFPxeEKmmoFj31IXmiZ0oAR08sKcLzwH5oHXj5sg4
 YfanQWlqlaCHAqrtWku9Da0Cd3TLbHiI7zFn2BaIsjxIQsRrDoHmHJdyauu8yGvoex+NBIgY0Rd
 rSYtyXe5Kqlr0/b7Ux76LGxsZnMw1N+VPhZct6dRfZEEjGhcqXvnszk63KvHzdRIl7qF+KUg58r
 GN0IenhVQnN/l5qAM46OR7/IFEMkoWGyKErXvPazfkqg==
X-Received: by 2002:a17:903:3d0c:b0:2a9:484c:ff2f with SMTP id
 d9443c01a7336-2aeae7efdfdmr46097875ad.23.1773289930772; 
 Wed, 11 Mar 2026 21:32:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222ab6sm54340785ad.10.2026.03.11.21.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:32:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, peterx@redhat.com, philmd@linaro.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 0/7] Fix some -device T,help crashes
Date: Thu, 12 Mar 2026 14:31:51 +1000
Message-ID: <20260312043158.4191378-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

Markus reported the following

"""
Watch this:

    $ qemu-system-aarch64 -S -display none -M virt -device acpi-ged,help
    qemu-system-aarch64: ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.

A number of devices crash this way:

* acpi-ged (aarch64 arm i386 loongarch64 x86_64)
* fsl-imx6 (aarch64 arm)
* fsl-imx7 (aarch64 arm)
* fsl-imx8mp (aarch64)
* microchip.pfsoc (riscv64)
* riscv.sifive.e.soc (riscv32 riscv64)
* xlnx-zynqmp (aarch64)
"""

This series fixes the crashes

Alistair Francis (7):
  hw/riscv: sifive_e: Don't call qdev_get_machine in soc init
  hw/riscv: microchip_pfsoc: Don't call qdev_get_machine in soc init
  hw/arm: xlnx-zynqmp: Don't call qdev_get_machine in soc init
  hw/arm: fsl-imx7: Don't call qdev_get_machine in soc init
  hw/arm: fsl-imx8mp: Don't call qdev_get_machine in soc init
  hw/arm: fsl-imx6: Don't call qdev_get_machine in soc init
  hw/acpi: generic_event_device: Don't call qdev_get_machine in soc init

 hw/acpi/generic_event_device.c |  5 ++--
 hw/arm/fsl-imx6.c              | 14 ++++++------
 hw/arm/fsl-imx7.c              | 19 ++++++++-------
 hw/arm/fsl-imx8mp.c            | 13 +++++------
 hw/arm/xlnx-zynqmp.c           | 42 +++++++++++++++-------------------
 hw/riscv/microchip_pfsoc.c     |  6 +++--
 hw/riscv/sifive_e.c            |  8 ++++---
 7 files changed, 52 insertions(+), 55 deletions(-)

-- 
2.53.0


