Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E3DC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6aw-000178-6U; Thu, 06 Feb 2025 13:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6at-00016Q-Fu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6ar-0000x7-QN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aqE03Vgex3UL7QEdCGyZZ09+9MfXrGLX09b9cezsDig=;
 b=Zm2tI757ydDVgJGYp7VNdNsjMdfvglB/FU5vga9qBSIjB/pLQGRfAcExMI7vdJ+U0RyW66
 xcVFP/AT+T+G3TqN8gtUY3SiMd6CsZ3ivUFG66Vjh5NYaE0PX+qul0sX7cDec6tDocr4Tl
 AcVkqk5Z6J8AK520hcZGNLjsxzJlagg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-MoEy6Z3EP22qOmnkES8OhA-1; Thu, 06 Feb 2025 13:27:15 -0500
X-MC-Unique: MoEy6Z3EP22qOmnkES8OhA-1
X-Mimecast-MFC-AGG-ID: MoEy6Z3EP22qOmnkES8OhA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436723bf7ffso10546325e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866434; x=1739471234;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aqE03Vgex3UL7QEdCGyZZ09+9MfXrGLX09b9cezsDig=;
 b=MLwhoIrtmDB82HCeHZK85w9KPVoAqYb3Z5JEa4BsLZtetAQG3WyV0wywRAeYVx1qGD
 xw1plu3EZ0OlQeusLWwH9ClzZeYT56C7g2X30ePXJyHqV4O966YSr5O8r7aqPKwooSnX
 lwsv2qXltUFWZWasf27QtDkPAFox7uoBounX96VyDm5FmSH1+TGfWi+Qhkegx1IAKqa+
 9SN4c2GwmQXOAcbIJmwj4IwM9+RYfKXcrhadHvNjWPw8cJm0OZdCwUB6CSWvkaBYN70l
 aa++Wa9qn5hdzcE87Q6diwi36qnqXc5Dk7Sq2p/jrGZq13wQ6/XkyrCJhtl1YyMLexo3
 /Itg==
X-Gm-Message-State: AOJu0YwAKM8eHlay55rZUSf6fg6vNTy+YfjLZ0Swlb4RaVeB+lSeur0d
 v7jLVKjEITdwD93QLPm+SMeDsDqJKpz2BmzfR/tnS3qycJKLwrDfESH/9XlN8++yikAwFVDuc02
 +DZc0xF+R3ZDy5mdVnpBJpqBtMoiomyh/77fDC24Y0fIKOQP7yO514oaPqOWFicBgSTi1kON99b
 VqnLqdUxCNo0qNX/70f18lFG5of4fn69cRjx4iLx8=
X-Gm-Gg: ASbGnctG4r/dKwL3TbJEz3vsGxLWLF8OgJQdCdB2Ja9ed0zMDdia0hUuu+U2MQKH5sp
 Inle8Exgi0wAOCMk9Oj/FZPgwV5QdT7wAdrqml1fyJXckvxj4kBdyPh8JGWi/pdt70z3AzLztCg
 927qpfGHYRg2ftmTYN7yMaO7gETRweWMl+mAjpuGIom1dPet0aMonYTFp+eR7yXgsJfOhb7wBw8
 FbpTxIL9C6juV3T4ywhM6Id9L3OztMXpGzJ8eUZFm0tZPc1YSL0f6rhYItGL68N0Cc/+z4MfDZJ
 3jfvE6U=
X-Received: by 2002:a05:600c:35cb:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-439249bceeemr4615835e9.27.1738866433708; 
 Thu, 06 Feb 2025 10:27:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGluoR7CHkyMBnYcNNLAe3Umjj1M2OOwcuSaK00ewwyH4vVUIx/DSs7goTUU599Kf9l2rhuPw==
X-Received: by 2002:a05:600c:35cb:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-439249bceeemr4615695e9.27.1738866433318; 
 Thu, 06 Feb 2025 10:27:13 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d933789sm62717835e9.4.2025.02.06.10.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 00/22] target/riscv: declarative CPU definitions
Date: Thu,  6 Feb 2025 19:26:48 +0100
Message-ID: <20250206182711.2420505-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Alastair,

the subject is a slightly underhanded description, in that what I really
wanted to achieve was removing RISC-V's use of .instance_post_init; that's
because RISC-V operate with an opposite conception of .instance_post_init
compared to everyone else: RISC-V wants to register properties there,
whereas x86 and hw/pci-bridge/pcie_root_port.c want to set them.
While it's possible to move RISC-V's code to instance_init, the others
have to run after global properties have been set by device_post_init().

However, I think the result is an improvement anyway, in that it makes
CPU definitions entirely declarative.  Previously, multiple instance_init
functions each override the properties that were set by the superclass,
and the code used a mix of subclassing and direct invocation of other
functions.  Now, instead, after .class_init all the settings for each
model are available in a RISCVCPUDef struct, and the result is copied
into the RISCVCPU at .instance_init time.  This is done with a single
function that starts from the parent's RISCVCPUDef and applies the delta
stored in the CPU's class_data.

Apart from the small reduction in line count, one advantage is that
more validation of the models can be done unconditionally at startup,
instead of happening dynamically if a CPU model is chosen.

Tested by running query-cpu-model-expansion on all concrete models,
before and after applying the patches, with no change except the bugfix
noted in patch 10.  The 64-bit variant of the script is as follows:

  for i in \
    "max" "max32" "rv32" "rv64" "x-rv128" "rv32i" "rv32e" "rv64i" "rv64e" \
    "rva22u64" "rva22s64" "lowrisc-ibex" "shakti-c" "sifive-e31" "sifive-e34" \
    "sifive-e51" "sifive-u34" "sifive-u54" "thead-c906" "veyron-v1" \
    "tt-ascalon" "xiangshan-nanhu"
  do
  echo $i
  echo "
  {'execute': 'qmp_capabilities'}
  {'execute': 'query-cpu-model-expansion', 'arguments':{'type': 'full', 'model': {'name': '$i'}}}
  {'execute': 'quit'}
  " | ./qemu-system-riscv64 -qmp stdio -display none -M none | jq .return.model > list-new/$i
  echo "
  {'execute': 'qmp_capabilities'}
  {'execute': 'query-cpu-model-expansion', 'arguments':{'type': 'full', 'model': {'name': '$i'}}}
  {'execute': 'quit'}
  " | ../../qemu-rust/+build/qemu-system-riscv64 -qmp stdio -display none -M none | jq .return.model > list-old/$i
  done

Do you think this is a good approach?

Paolo

Paolo Bonzini (22):
  target/riscv: remove unused macro DEFINE_CPU
  target/riscv: introduce RISCVCPUDef
  target/riscv: store RISCVCPUDef struct directly in the class
  target/riscv: merge riscv_cpu_class_init with the class_base function
  target/riscv: move RISCVCPUConfig fields to a header file
  target/riscv: add more RISCVCPUDef fields
  target/riscv: convert abstract CPU classes to RISCVCPUDef
  target/riscv: convert profile CPU models to RISCVCPUDef
  target/riscv: convert bare CPU models to RISCVCPUDef
  target/riscv: move 128-bit check to TCG realize
  target/riscv: convert dynamic CPU models to RISCVCPUDef
  target/riscv: convert SiFive E CPU models to RISCVCPUDef
  target/riscv: convert ibex CPU models to RISCVCPUDef
  target/riscv: convert SiFive U models to RISCVCPUDef
  target/riscv: th: make CSR insertion test a bit more intuitive
  target/riscv: generalize custom CSR functionality
  target/riscv: convert TT C906 to RISCVCPUDef
  target/riscv: convert TT Ascalon to RISCVCPUDef
  target/riscv: convert Ventana V1 to RISCVCPUDef
  target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
  target/riscv: remove .instance_post_init
  target/riscv: move SATP modes out of CPUConfig

 target/riscv/cpu-qom.h            |   2 +
 target/riscv/cpu.h                |  43 +-
 target/riscv/cpu_cfg.h            | 175 +-----
 target/riscv/cpu_cfg_fields.h.inc | 163 +++++
 hw/riscv/boot.c                   |   2 +-
 hw/riscv/virt-acpi-build.c        |   6 +-
 hw/riscv/virt.c                   |   4 +-
 target/riscv/cpu.c                | 967 ++++++++++++++----------------
 target/riscv/csr.c                |   2 +-
 target/riscv/gdbstub.c            |   6 +-
 target/riscv/kvm/kvm-cpu.c        |  21 +-
 target/riscv/machine.c            |   2 +-
 target/riscv/tcg/tcg-cpu.c        |  19 +-
 target/riscv/th_csr.c             |  30 +-
 target/riscv/translate.c          |   2 +-
 15 files changed, 689 insertions(+), 755 deletions(-)
 create mode 100644 target/riscv/cpu_cfg_fields.h.inc

-- 
2.48.1


