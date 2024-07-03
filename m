Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C56DC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwZU-0004GM-Jy; Wed, 03 Jul 2024 05:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOwZR-0004Fh-0U
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:46:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOwZO-0003eZ-R4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:46:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7066463c841so3483294b3a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 02:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719999992; x=1720604792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K7gY0skHye9VnQi2Uo8sQ7ZsJIo+uyRo3JAlqXo4TXA=;
 b=h47q/fXrpSOg9aiCLrT3aC9Gj7fVtvqgkbtEQFjX3XByCZrIfzEOs4wFECtfQTSDUb
 aEVODQY6WhnHnzncQJ0Iz1k9dlwJ1RsVIlU31fXD8YN/1PGkXE5M5BtFi6GyZQM8+Eng
 8sV+Z2hBfryeRa7VDOJP1j5Z/JrruYS2L5PpNDCI7VpsT2YeReWT/hcDlWpmIRANMtzq
 LCtGHk6mgKBtpstB2/q9AF8s1WkJL0Way9GFut+JO5wPqOI9SnB35F72zRgHCsxGAWs/
 zlUUjB4eRQdiW9zrcV/hSaWDT09mslibN5+hjpSevNz5VU27xI/15jg5rPG8wXWSXjsy
 oMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719999992; x=1720604792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K7gY0skHye9VnQi2Uo8sQ7ZsJIo+uyRo3JAlqXo4TXA=;
 b=GS1GjQlQbgDX3y6Ml1L/qWpgH2DFl1gHJqw70qGFupPLyo99lfNWK3CkG7LX2slhSc
 shJns39xs3IZ0EAANa0kARTGYQqqLXpkTxi9zWpszfGppjXn575dtgiEeWsTDHX+3sBO
 Ltjh4d0kTo/eo14GNB95cAmGoicDCIeC2IBemcvx/BRK7pLWEUk462qay7RrGfS8xAht
 1ESUlVaIzT7gOKTfes/MwVgVoIs6BVOH5l3Wlk9tEwVTAMJkpfPge/wWlg/IvtpgJyVk
 UJe6kAmoGkqFNg+y5FcXJPOH+7q9i6tAaiafObb9zVPVyWIlcEMqY7H7F4gfTd3onFob
 bu9Q==
X-Gm-Message-State: AOJu0Yw303Qxw6Qr7wADnPBZmDjz2HTsZsqjk7cUaBDF0On+Pw+qcnqg
 MkOHNs7f6ThhQPARmljNZzC+cZRu3T7vWs2NT7fv2iTFQMCSCHA9myn7wJ/UikuwXbfJVWlqA2F
 9
X-Google-Smtp-Source: AGHT+IFa/3fQZYLh2eOfuSyPhIgtZgnzCZRxTn6iRVw7k2cebi5vB4+Ej77q6JUXQylKAjt0c/CRaw==
X-Received: by 2002:a05:6a20:2451:b0:1bd:289e:5fbb with SMTP id
 adf61e73a8af0-1bef6228338mr11914110637.58.1719999992487; 
 Wed, 03 Jul 2024 02:46:32 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3bc5a1sm10278621a91.36.2024.07.03.02.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 02:46:32 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com,
 eduardo@habkost.net, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/2] qdev,accel-system: allow Accel type globals
Date: Wed,  3 Jul 2024 06:46:24 -0300
Message-ID: <20240703094626.1704990-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
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

This is another approach of the problem we tried to fix with [1]. It was
suggested by Paolo during the review.

In the current handling of '-accel' only the first instance is parsed.
All other instances (aside from a 'helper' command that triggers the
help text and exits) is ignored. So this command line:

qemu-system-riscv64 -accel kvm -accel kvm,riscv-aia=hwaccel

Won't change 'riscv-aia' to 'hwaccel'. 

This is affecting at least one use case we have with libvirt and RISC-V:
we can't set 'riscv-aia' by appending '-accel kvm,riscv-aia=val'
via <qemu:cmdline> in the domain XML. libvirt will add a leading
'-accel kvm' in the regular command line and ignore the second. We'll
add official libvirt support for this KVM property in the near future
(we're still discussing if this prop should be a bool instead), but
for now a QEMU side change would unlock this RISC-V KVM use case in
libvirt.

With this series we'll be able to set 'riscv-aia' using globals as
follows:

qemu-system-riscv64 -accel kvm -global kvm-accel.riscv-aia=hwaccel

This change benefit all archs (not just RISC-V) and will allow globals
to be used with all accelerators, not just KVM.

[1] https://lore.kernel.org/qemu-devel/20240701133038.1489043-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (2):
  qdev: change qdev_prop_set_globals() to use Object*
  qdev, accel-system: add support to Accel globals

 accel/accel-system.c         |  3 +++
 hw/core/qdev-properties.c    | 39 +++++++++++++++++++++++-------------
 hw/core/qdev.c               |  2 +-
 include/hw/qdev-properties.h |  2 +-
 4 files changed, 30 insertions(+), 16 deletions(-)

-- 
2.45.2


