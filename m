Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0602C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lVs-0001Bv-On; Wed, 08 May 2024 13:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVn-0001AW-0o
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:27 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVh-00027b-1i
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:26 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59b097b202so4631866b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715190916; x=1715795716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lv4TLW1euMgeLNUuNRRaqUVuv3SXn2Y0b+IICdgy07o=;
 b=NNlUmw5z0ZBA2gdh3MVfnljdVMYBNxDRcCufhTeuNA6A5YlVcix1bf5X+JQAVMATKl
 5lh8cRbOi/hfKHsAkPUjiUeOtp1t3+POp1hDn2kiwKOPbckHwYFuvfO2ziNFm7joRKWV
 bro667uwYqudNIg2vb0IKUdutPQT25XYCQ+C87wL0IhY+hbdWUewKRNPbiInvhOKYSZ5
 hMzhGnwhCWPyhlOD/795+aevcsQ22/bCwMxyOmZ9VRm7lKNP4VZE6fQmiGkVvCHtGvj/
 IjlWW1oIoi2MSA3FY/w+Qq4bPlekVtljesAaOIk0stLQ+jjAt0iEckoH1D+ikseCitKx
 zYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190916; x=1715795716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lv4TLW1euMgeLNUuNRRaqUVuv3SXn2Y0b+IICdgy07o=;
 b=DEEBeR3GAaw6drlvh8IM59cBCxwho8bPCu2Lpi+m4Bku7wk0N045jX+Hy06KAhppp8
 tnE5WBA0qWIM6u+70BBLejiV3zyTXF23R13Z1vKw4w0T6jBtd7QcVF2YRYeEM90g9TcF
 AFKndnIVlpyFabhaEkvUFRo6lM7Yypqlx0i0K/Bvg4fPLCy90yiK9jyNijF53QvhwaOw
 u+K1UYTLuAQ3QMLsiX2JzeLpLQFSBODRCBtWB1KWawBnP8VnmkxieuQ7KhI84BpENwSU
 yhBOLcJzSzlBYkBGKTqTVADXcVWa3e7ua6DKPBKXlEB6mbHwq1NIRlpySN6hIOZPBVfW
 hm9g==
X-Gm-Message-State: AOJu0YzpKSsq9vMgRA4tMXgjW9Hf58PRx6ztlNHHA8OBy+RtUz4SsHl6
 cK6I2WXTKmZT9SUPTuvajU7YqtnFujp33NUFKYliShDIGSoC5bgVYk9hNA==
X-Google-Smtp-Source: AGHT+IFoWm/qbO3pEBP8O3oqmsdkPJXA0pzGzLlFJhN37mbxF2cqY/vKEWlo79Jhkh9jnVDpBVWtfQ==
X-Received: by 2002:a17:906:b78d:b0:a59:b543:c9f9 with SMTP id
 a640c23a62f3a-a59fb920d59mr261121966b.7.1715190916175; 
 Wed, 08 May 2024 10:55:16 -0700 (PDT)
Received: from archlinux.. (dynamic-077-013-167-103.77.13.pool.telefonica.de.
 [77.13.167.103]) by smtp.gmail.com with ESMTPSA id
 a24-20020a170906671800b00a59c5a129basm4483821ejp.80.2024.05.08.10.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 10:55:15 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 0/6] X86: Alias isa-bios area and clean up
Date: Wed,  8 May 2024 19:55:01 +0200
Message-ID: <20240508175507.22270-1-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series changes the "isa-bios" MemoryRegion to be an alias rather than =
a=0D
copy in the pflash case. This fixes issuing pflash commands in the isa-bios=
=0D
region which matches real hardware and which some real-world legacy bioses =
I'm=0D
running rely on. Furthermore, aliasing in the isa-bios area is already the=
=0D
current behavior in the bios (a.k.a. ROM) case, so this series consolidates=
=0D
behavior.=0D
=0D
For migration compatibility the aliasing is only performed on new versions =
of=0D
the q34 and pc machine types.=0D
=0D
v3:=0D
* Amend commit message with a diff of `info mtree` (Phil)=0D
* Add comments for bios memory regions (Phil)=0D
=0D
v2:=0D
* Don't leak bios memory regions (Phil)=0D
* Add compat machinery (Michael)=0D
=0D
Testing done:=0D
* `make check` with qemu-system-x86_64 (QEMU 8.2.2) installed. All tests=0D
  including migration tests pass.=0D
* `make check-avocado`=0D
=0D
Best regards,=0D
Bernhard=0D
=0D
Bernhard Beschow (6):=0D
  hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()=0D
  hw/i386: Have x86_bios_rom_init() take X86MachineState rather than=0D
    MachineState=0D
  hw/i386/x86: Don't leak "isa-bios" memory regions=0D
  hw/i386/x86: Don't leak "pc.bios" memory region=0D
  hw/i386/x86: Extract x86_isa_bios_init() from x86_bios_rom_init()=0D
  hw/i386/pc_sysfw: Alias rather than copy isa-bios region=0D
=0D
 include/hw/i386/pc.h  |  1 +=0D
 include/hw/i386/x86.h | 17 +++++++++++++++-=0D
 hw/i386/microvm.c     |  2 +-=0D
 hw/i386/pc.c          |  1 +=0D
 hw/i386/pc_piix.c     |  3 +++=0D
 hw/i386/pc_q35.c      |  2 ++=0D
 hw/i386/pc_sysfw.c    | 17 ++++++++++------=0D
 hw/i386/x86.c         | 45 ++++++++++++++++++++++---------------------=0D
 8 files changed, 58 insertions(+), 30 deletions(-)=0D
=0D
-- =0D
2.45.0=0D
=0D

