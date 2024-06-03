Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1F3C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7Tj-0000Ag-Ne; Mon, 03 Jun 2024 09:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE7Ti-0000A7-7S
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE7Td-0005hY-SK
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717420310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sCaqbMzfZgKieszL9uZZLkr+VTRMFuQvJdzKizDv27M=;
 b=iIdmD/9mOAAu5m1X7AA1YWY7E9RWnu6Rm+31ALwyDBeU2udkD+aO2gDPompLX44bmNKfac
 2/QlHLr1Wma2bth6p5FXMeQN/bG1LaAmCpFvhT4GbqCA1KiUph6M2QGXPZ7jwmXNQGy5ps
 g+n9omaEipwz1+Ava+t0y9rXfFowN2Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Lb5Gs_Q0NhCE5IhwCKL6Aw-1; Mon, 03 Jun 2024 09:11:47 -0400
X-MC-Unique: Lb5Gs_Q0NhCE5IhwCKL6Aw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a592c35ac06so359909766b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 06:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717420305; x=1718025105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sCaqbMzfZgKieszL9uZZLkr+VTRMFuQvJdzKizDv27M=;
 b=BotclONm7HtdjZn151EO+d/haDPwhO7BZq4YyfSGtsPBhh8LLZZO0es6Sz/fZCdSSt
 Ty5w2PEvh/Axg9paRS4goVow0RYW6ihF7B4JMXnz5Izc3I2ILdZ7Ycl79f67k71A7PI7
 RGq7V1dTQb6WJZsNTkTU9DTLnLJiFAEWAm1iKA+4HyMa40EuNL2e/phF5YfLybMYiUOJ
 r6Zx/sDDnKpv6tlTBlhadGlBmvPfI+vBuapd7WAn3zQnctAC8091ojR9E7vbFmgrNAJH
 R9y7KE/R5p+F8vEb6zej7FPd7qIZREGhqOD8hWuHTCeeb0PJfz5Rw+KtUOoPBPOVErvz
 JO9A==
X-Gm-Message-State: AOJu0Yy6RkTbpJdOKdYE38O00s1KeJ706HeIMmMjiFq2hRPCRIwU886B
 xpPzBPHQVeHcVfV2vQpRbaH55oNgxcGC+mefrR34UEZpTAS+Mg8dFYCAK8yyKqW4LU/+0daH6E4
 kI8NZo43Xi0f8SawqSB0aSXZrU6KloNj3PujxenZ603NLJRFu5YXW3iI477WCNqGm2LoUrJfz2h
 zL/E3MRRv3Wwn/Xy997DmrCJRPU7H1ZpmKP2Cg
X-Received: by 2002:a17:906:bfe7:b0:a59:a3ad:c3f6 with SMTP id
 a640c23a62f3a-a681867280dmr758875666b.3.1717420304981; 
 Mon, 03 Jun 2024 06:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcAszKQWPg566eBiZ/xFJTzyQZKJZFM6xTmWflD9sp4fnGjiAtQ9cBz13MT182bloYf1MFVg==
X-Received: by 2002:a17:906:bfe7:b0:a59:a3ad:c3f6 with SMTP id
 a640c23a62f3a-a681867280dmr758872466b.3.1717420304399; 
 Mon, 03 Jun 2024 06:11:44 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68e3ff633fsm284126766b.14.2024.06.03.06.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 06:11:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	cohuck@redhat.com
Subject: [PATCH 0/4] update-linux-headers: prepare for updating to 6.9+ and
 for SNP patches
Date: Mon,  3 Jun 2024 15:11:37 +0200
Message-ID: <20240603131141.834241-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series contains a few cleanups and fixes to update-linux-headers.sh,
which I needed or found in order to pass CI for the SEV-SNP patches.

First, updating linux-headers/ fails due to the lack of
arch/loongarch/include/uapi/asm/bitsperlong.h.  I am not sure if I am
doing something wrong but it is caused by commit 3efc75ad9d9
("scripts/update-linux-headers.sh: Remove temporary directory inbetween",
2024-05-29); if so, I guess I'm 1-1 with Thomas given my own bug in
commit 66210a1a30 that he fixed.

Before commit 3efc75ad9d9, the missing file would incorrectly cause stale
files to be included in linux-headers/.  The files were never committed
to qemu.git, but were wrong nevertheless. The build would just use
the system version of the files, which is opposite to the idea of
importing Linux header files into QEMU's tree.

Second, pvpanic.h was incorrectly included in a slightly different
path than what is used in Linux.

Third, SNP host-side patches will need linux/kvm_para.h, because some
of the supported distros do not have a definition for KVM_HC_MAP_GPA_RANGE.
Including it is a bit complicated because we also have a version of
x86's kvm_para.h under include/standard-headers/; linux/kvm_para.h
tries to include <asm/kvm_para.h> and that could cause conflicts.
So, the linux/kvm_para.h is also placed in include/standard-headers
(patch 4).

Pankaj Gupta (1):
  linux-headers: Update to current kvm/next

Paolo Bonzini (3):
  update-linux-headers: fix forwarding to asm-generic headers
  update-linux-headers: move pvpanic.h to correct directory
  update-linux-headers: import linux/kvm_para.h header

 include/standard-headers/linux/kvm_para.h     | 38 ++++++++++++++
 .../{linux => misc}/pvpanic.h                 |  0
 linux-headers/asm-loongarch/kvm.h             |  4 ++
 linux-headers/asm-riscv/kvm.h                 |  1 +
 linux-headers/asm-x86/kvm.h                   | 52 ++++++++++++++++++-
 linux-headers/asm-x86/kvm_para.h              |  1 +
 linux-headers/linux/kvm_para.h                |  2 +
 linux-headers/linux/vhost.h                   | 15 +++---
 hw/misc/pvpanic-isa.c                         |  2 +-
 hw/misc/pvpanic-pci.c                         |  2 +-
 hw/misc/pvpanic.c                             |  2 +-
 scripts/update-linux-headers.sh               | 37 +++++++++++--
 12 files changed, 141 insertions(+), 15 deletions(-)
 create mode 100644 include/standard-headers/linux/kvm_para.h
 rename include/standard-headers/{linux => misc}/pvpanic.h (100%)
 create mode 100644 linux-headers/asm-x86/kvm_para.h
 create mode 100644 linux-headers/linux/kvm_para.h

-- 
2.45.1


