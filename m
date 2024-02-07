Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05230C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXfsk-0002pp-7S; Wed, 07 Feb 2024 06:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsi-0002pV-OP
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsh-0003O9-6H
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707304456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W6gwJMN1incoibgLga1+SPkwv5rohbLrn8BJ2IlE3VI=;
 b=Iff7PKYb6F0XYSaW3MmCxVLOSzTVlZ5QdGYUZWgxeQS2pe32/l5hvRodjeC5g3R/D3iG70
 VNlegxcr7Gke+mFNRdxlBCc3UO7kBHMPI76n268njdgcgT35y0AnTUkgcY9VpELsT08Ly1
 ecyJe1E9QNpfVotzssl2noPKN9eGWxQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-U6SoK-BGMrqXWmM7OEQ4oA-1; Wed, 07 Feb 2024 06:14:15 -0500
X-MC-Unique: U6SoK-BGMrqXWmM7OEQ4oA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-558b04cb660so327156a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 03:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707304453; x=1707909253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W6gwJMN1incoibgLga1+SPkwv5rohbLrn8BJ2IlE3VI=;
 b=h2ysHCFFpJs1fOCUs6EEPMaEYHqnGZZj4bAU1w+HFfqCmNuEGCA8dyNizuLfqXEizb
 Q4hUu/q/oyzLIjuw2IMcX2D2BaWCJUM7B/ja7j0VtcbzPzKY/LGInTHOznEx++8C/qlD
 kecw67Lwf8fbkRkppXcFizeki706zFENIrJ4S8ckZXR8VnhLKO4yLlNOLrk1yHygwVJ4
 btzNNVN4uexFoaCvl/YL1K50nEKUnDKqA/1Gt9SSsJRzYahDdtaUu99Lk17e7/kq0/Q5
 duzNJZPmNbTM6dT8kHpD2jsnWkcrYl+l9QOmgV1jhVUmbPVPy+Yyk2+pU2JBQxHK4CXP
 0n9g==
X-Gm-Message-State: AOJu0YzLF0X3575QgUqsfhW5q6l9d7bvFopT23DyaNoXvYPpl0WlTF2j
 dWMB4ObEb5cA+PZ9hv7jFpSvOEjFC9TYxWMVuULKwdnPxzlFrHxIAR9vPjzeICJhZPU5qD4M5aG
 Dk+TOLuFdFuuNvS86Fho/I1vx+9MqYjALNyX8xqfv1mw2FcnxVnAJHIxqd8io1ykYwvsZ+X6vjh
 /txM1lbR8c5zS5om1Xht3Qgs293uiTrI3IfKmH
X-Received: by 2002:aa7:cfd4:0:b0:560:8f9:5a8a with SMTP id
 r20-20020aa7cfd4000000b0056008f95a8amr3431682edy.42.1707304453511; 
 Wed, 07 Feb 2024 03:14:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpNAtXGY01wv/q5KbLSqWZ31x8+wUb9vv2QjwVVrRUISm39+07SSI/T8FTj9Hxu15K5zMucw==
X-Received: by 2002:aa7:cfd4:0:b0:560:8f9:5a8a with SMTP id
 r20-20020aa7cfd4000000b0056008f95a8amr3431667edy.42.1707304453173; 
 Wed, 07 Feb 2024 03:14:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWeSSnxIC8Q+WRXPkJ1bPb4A3ZwTPP9IynS0FeeOyihiPBtBaZAhWumJ96V9sr5Num+2lrQLylx3mkUdA07ReXPEg==
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a056402321800b00560dbcd61a8sm483642eda.94.2024.02.07.03.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 03:14:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: shentey@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 0/8] mips: do not list individual devices from configs/
Date: Wed,  7 Feb 2024 12:14:02 +0100
Message-ID: <20240207111411.115040-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Back when Kconfig was introduced, the individual dependencies for MIPS
boards were never added to hw/mips/Kconfig.  Do it now.

To simplify the task, include a couple cleanups to the SuperIO chip
configuration symbols, as well as a change that makes USB device
creation available even when building without default devices.

Tested by comparing old and new kconfigs; and also by building each of
the boards one by one, with default devices disabled, and checking that
the board can be started.

Paolo

Based-on: <20240129115809.1039924-1-pbonzini@redhat.com>

v1->v2:
- more cleanup to hw/isa
- include "mips: allow compiling out CONFIG_MIPS_ITU"
- split out patch 3, previously submitted by Bernard
- new patches 4-5 further cleaning up ISA_SUPERIO
- clean up new fdc37m81x-superio.c file
- do not select IDE_ISA for FDC37M81X

Bernhard Beschow (1):
  hw/mips/Kconfig: Remove ISA dependencies from MIPSsim board

Paolo Bonzini (8):
  usb: inline device creation functions
  isa: clean up Kconfig selections for ISA_SUPERIO
  isa: fix ISA_SUPERIO dependencies
  isa: specify instance_size in isa_superio_type_info
  isa: extract FDC37M81X to a separate file
  mips: allow compiling out CONFIG_MIPS_ITU
  mips: do not list individual devices from configs/

 configs/devices/mips-softmmu/common.mak      | 26 ++---------------
 configs/devices/mips64el-softmmu/default.mak |  3 --
 include/hw/usb.h                             | 27 +++++++++++++++--
 hw/isa/fdc37m81x-superio.c                   | 32 ++++++++++++++++++++
 hw/isa/isa-superio.c                         | 18 -----------
 hw/isa/smc37c669-superio.c                   |  1 -
 hw/mips/loongson3_virt.c                     |  5 +--
 hw/mips/mips_itu-stub.c                      | 26 ++++++++++++++++
 hw/mips/mipssim.c                            |  1 -
 hw/usb/bus.c                                 | 23 --------------
 hw/display/Kconfig                           |  2 +-
 hw/isa/Kconfig                               | 20 ++++++------
 hw/isa/meson.build                           |  1 +
 hw/mips/Kconfig                              | 25 ++++++++++++---
 hw/mips/meson.build                          |  1 +
 15 files changed, 122 insertions(+), 89 deletions(-)
 create mode 100644 hw/isa/fdc37m81x-superio.c
 create mode 100644 hw/mips/mips_itu-stub.c

-- 
2.43.0


