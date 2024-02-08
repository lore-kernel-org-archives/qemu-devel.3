Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC63C4829D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 22:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYCV0-0007Dn-K5; Thu, 08 Feb 2024 17:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCUz-0007C6-Hk
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:01 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCUx-0005DP-Rl
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:01 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a28a6cef709so38342966b.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 14:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707429837; x=1708034637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AroTFz7StupzYFRerkeRQ1hym90slEK4YvkM8vhuirw=;
 b=OWKHkSCN+dxAMSGsR4G4iidrQeYWJcjYH1g6co5IGlx4nPG0OFQUMoT+yxgog0m2jL
 Zk1BMFYiYgStmwMuNxsj5i+/EbuD4KeH/xqwBRUQs/pmExMujFk3TbmsjsPPo6KOUlgM
 RML6FbArqQ8hcfNZUOXkOGB7cy90YtBxKREB6CmZPOOcJBjRreepA26GiL9uIYo0KF2g
 eVWZ85cCVL8ZX1TItkgc1voZRzC8FQzbyEr0REOauVwQGpj4s3sprYFF/t3/Kn/3K8qt
 kP5WqkMzwOAAuAKrhVdxORDIbgr7d4cvG+4fyyqnM7/f9AghydD7SluJvZAh7vfgKYvM
 PBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707429837; x=1708034637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AroTFz7StupzYFRerkeRQ1hym90slEK4YvkM8vhuirw=;
 b=Ay3v2ne0z3tFqxoFpP2Z1cku6YoJvLeI5c+kDu9mwCt6ti/phaRCyyoEcHZOzOCoC4
 aggA9cMSsELmygzmA3A+FpkwQAWNZPiIR1XP93evTqGdxzejZS2c+uTyQEC372SmTDXo
 PhsXVXpx5hvFzqzlGLjlySiCiBcr2F13jM9kyYIbvHEskFt2Oe8JR1WjoayGsuXV9YxL
 d4ERacmvx9qS4lsY2EgQvYS2A2Ibwn6FEPtvPCihZqeIQreD8YVsefoEmY0hckMVL8tN
 b64dWV/LUKvsM/DMsA7whlzdfhBWE1+D+bjotBa5xd5AKoUqhlU7GPNeq16iNpybTAEc
 +wQQ==
X-Gm-Message-State: AOJu0YxN+86J3SRGiB3n7N1ijjiXSXZn1Sy/UOQceyvoW2Y8ToYu96CK
 7kPv9YI6rniHod9CxKUMkVPCGxeSMPEpwJ5Ue0OJveeiYoUGjeIVMhtU4upb
X-Google-Smtp-Source: AGHT+IGlmW+wJwauUvEoGPCe7RlNtkU1lnMqNIo/EpMgdM1+hVzcO8ltu7TugQOl0Sib4tzwKIx1UA==
X-Received: by 2002:a17:907:689:b0:a37:8a2c:316a with SMTP id
 wn9-20020a170907068900b00a378a2c316amr434541ejb.45.1707429837250; 
 Thu, 08 Feb 2024 14:03:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUZNnDFNUhr+l9DKhqyDfJgrbQUHYG+6OSLaKlh7psFGw61RODaNQQcFzrhuLwlwBJrggBUBq4ghbBY7FoUabzt2zD/ECoBtRBBg4aJzYZ0SlyPoGRtvI+inAFMsPCBqok4u4c8dYjdMFQt3UWUepYB/daiqYMMxvxcDdQH7ZEsdSh6+egMtYXeCrpg5u1w81IM1BFqsRjYK1MFLq1rn7ABI724GOctpctpQXh8BJkZtxwo/WCv
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 ti9-20020a170907c20900b00a3109a492d4sm109753ejc.20.2024.02.08.14.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 14:03:56 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/9] Simplify initialization of PC machines
Date: Thu,  8 Feb 2024 23:03:40 +0100
Message-ID: <20240208220349.4948-1-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The series aims to simplify the initialization process of all PC-based mach=
ines.=0D
=0D
It consists of streamlining redundant code, as well as consolidating the se=
tup=0D
of system flash and generation of smbios data which are currently fairly=0D
distributed.=0D
=0D
These changes are expected to make the code easier to understand and mainta=
in.=0D
=0D
Best regards,=0D
Bernhard=0D
=0D
Bernhard Beschow (9):=0D
  hw/i386/x86: Let ioapic_init_gsi() take parent as pointer=0D
  hw/i386/pc_piix: Share pc_cmos_init() invocation between pc and isapc=0D
    machines=0D
  hw/i386/x86: Turn apic_xrupt_override into class attribute=0D
  hw/i386/pc: Merge pc_guest_info_init() into pc_machine_initfn()=0D
  hw/i386/pc: Defer smbios_set_defaults() to machine_done=0D
  hw/i386/pc: Confine system flash handling to pc_sysfw=0D
  hw/i386/pc_sysfw: Inline pc_system_flash_create() and remove it=0D
  hw/i386/pc: Populate RTC attribute directly=0D
  hw/i386/pc_{piix,q35}: Eliminate local pci_bus/pci_host variables=0D
=0D
 hw/i386/fw_cfg.h      |  3 ++-=0D
 include/hw/i386/pc.h  |  5 ----=0D
 include/hw/i386/x86.h |  5 ++--=0D
 hw/i386/acpi-common.c |  3 ++-=0D
 hw/i386/fw_cfg.c      | 12 +++++++++-=0D
 hw/i386/microvm.c     |  2 +-=0D
 hw/i386/pc.c          | 25 +++++---------------=0D
 hw/i386/pc_piix.c     | 55 ++++++++++++++-----------------------------=0D
 hw/i386/pc_q35.c      | 38 ++++++++++--------------------=0D
 hw/i386/pc_sysfw.c    | 17 ++++---------=0D
 hw/i386/x86.c         |  7 +++---=0D
 11 files changed, 62 insertions(+), 110 deletions(-)=0D
=0D
-- =0D
2.43.0=0D
=0D

