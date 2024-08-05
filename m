Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE5BC52D71
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 21:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb4st-0006rt-UU; Mon, 05 Aug 2024 17:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sb4ss-0006oM-1R; Mon, 05 Aug 2024 17:04:50 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sb4sq-00081f-3E; Mon, 05 Aug 2024 17:04:49 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fd70ba6a15so83364055ad.0; 
 Mon, 05 Aug 2024 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722891886; x=1723496686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XySQWrEFO9nPy8SoTcGCQY7CmQyabF4H4g770XsoGWU=;
 b=aFeA/tV8WfH9KmdNDIEia7H/6rlyY0YwE4l68I2UnydfeZefUq85VzYd7ACfUMTMeG
 2+jcsnNQITmc4eEXJ3c/lWLM2ygmgMH+8ViWtwxbWIgDWSo4laQslIaEa+FzOxNRciTH
 mzY3RUfHfaEXkh4LvfvlATZjVBSKkQxa3tMueHfDyRqdvDWnEPszTXg0UYXhhCzMHGxt
 qzWuiWCtoWUUTJ/66KSew/rK/1e2GisFKwOS6CY1aY66AY5m/pgbB5l8mJs2nT//o0kd
 vAo0OF8bK/SvCeaegFEjqztpjE96Bg6+eX+hcbZfqtVNLzv9vpZMPp0txplLSOWQVCBF
 3EnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722891886; x=1723496686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XySQWrEFO9nPy8SoTcGCQY7CmQyabF4H4g770XsoGWU=;
 b=Ew+L+IZWskgCInrGwtov5DBlFq0+DFSFK17O+GgmC3aQq+OMwA/78nFpFHrC3R5UHv
 LBVIz6E25R7nV2LElI4XAd4wX+TSY4myZ0B3gEjXFF/ssu5eO2M7yVK//3Vg76ZlPuTJ
 9CXKvJk2lwQI55IAdi2jUMLbY6Ojo2xw/0gVYrtXElKrfjRoiaiirnHBb+ll7lDL/KMR
 0t4iFgyjvh+FXsOrEtTrU5DneyGIz3Lah/1WmpL0xmm2SapdC+M4oT+PwsCuGotpWMHS
 NSSElyeFQo6a2i4GFu2/s3cetbRbRCHw9tJDxjsoZkM8rKUh9DlpoGEDwnrdgpThwR2J
 TWQw==
X-Gm-Message-State: AOJu0YzhAfgvZ/ACYh7/0vVEc9q/AcGauIiLsllIRxcXVh1FBzYKswRe
 1dx+w+cYc1HbFSAX6wSxk6bGUmgWaSfIwguu6sESd3j0w+BotzkPOSBQ8i/z
X-Google-Smtp-Source: AGHT+IHM9L+mQEaah81Nrb82lfOcmT5oG+oJhroIJJDQSPIUstzGVqgyvzOHNfg/4YlFC+3U4Ar3Ww==
X-Received: by 2002:a17:903:11ce:b0:1fb:82f5:6641 with SMTP id
 d9443c01a7336-1ff57292c9dmr142214395ad.23.1722891885864; 
 Mon, 05 Aug 2024 14:04:45 -0700 (PDT)
Received: from localhost ([205.175.106.198])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff59059f9asm72684995ad.131.2024.08.05.14.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 14:04:45 -0700 (PDT)
From: Gregor Haas <gregorhaas1997@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, dbarboza@ventanamicro.com,
 alistair.francis@wdc.com, Gregor Haas <gregorhaas1997@gmail.com>
Subject: [PATCH v3 0/1] Add support for generating OpenSBI domains in the
 device tree
Date: Mon,  5 Aug 2024 14:04:43 -0700
Message-ID: <20240805210444.497723-1-gregorhaas1997@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pl1-x633.google.com
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

This patch series adds support for specifying OpenSBI domains on the QEMU
command line. A simple example of what this looks like is below, including
mapping the board's UART into the secondary domain:

qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m 4G -nographic \
        -device opensbi-memregion,id=mem,base=0xBC000000,order=26,mmio=false \
        -device opensbi-memregion,id=uart,base=0x10000000,order=12,mmio=true,device0="/soc/serial@10000000" \
        -device opensbi-domain,id=domain,possible-harts=0-1,boot-hart=0x0,next-addr=0xBC000000,next-mode=1,region0=mem,perms0=0x3f,region1=uart,perms1=0x3f

As a result of the above configuration, QEMU will add the following subnodes to
the device tree:

chosen {
        opensbi-domains {
                compatible = "opensbi,domain,config";

                domain {
                        next-mode = <0x01>;
                        next-addr = <0x00 0xbc000000>;
                        boot-hart = <0x03>;
                        regions = <0x8000 0x3f 0x8002 0x3f>;
                        possible-harts = <0x03 0x01>;
                        phandle = <0x8003>;
                        compatible = "opensbi,domain,instance";
                };

                uart {
                        phandle = <0x8002>;
                        devices = <0x1800000>;
                        mmio;
                        order = <0x0c>;
                        base = <0x00 0x10000000>;
                        compatible = "opensbi,domain,memregion";
                };

                mem {
                        phandle = <0x8000>;
                        order = <0x1a>;
                        base = <0x00 0xbc000000>;
                        compatible = "opensbi,domain,memregion";
                };
        };
};

This results in OpenSBI output as below, where regions 01-03 are inherited from
the root domain and regions 00 and 04 correspond to the user specified ones:

Domain1 Name              : domain
Domain1 Boot HART         : 0
Domain1 HARTs             : 0,1
Domain1 Region00          : 0x0000000010000000-0x0000000010000fff M: (I,R,W,X) S/U: (R,W,X)
Domain1 Region01          : 0x0000000002000000-0x000000000200ffff M: (I,R,W) S/U: ()
Domain1 Region02          : 0x0000000080080000-0x000000008009ffff M: (R,W) S/U: ()
Domain1 Region03          : 0x0000000080000000-0x000000008007ffff M: (R,X) S/U: ()
Domain1 Region04          : 0x00000000bc000000-0x00000000bfffffff M: (R,W,X) S/U: (R,W,X)
Domain1 Next Address      : 0x00000000bc000000
Domain1 Next Arg1         : 0x0000000000000000
Domain1 Next Mode         : S-mode
Domain1 SysReset          : no
Domain1 SysSuspend        : no

v3:
- Addressed review comments from v2 by adding default values to new properties.
  This results in concrete errors at QEMU configuration time if a mandatory
  property (as mandated by the OpenSBI spec) is not provided.
- Changed command line encoding for the possible-harts field from a CPU bitmask
  (e.g. where bit X is set if CPU X is a possible hart) to a range format (e.g.
  the possible harts should be CPUs X-Y, where Y >= X). This does constrain the
  hart assignment to consecutive ranges of harts, but this constraint is also
  present for other QEMU subsystems (such as NUMA).
- Added create_fdt_one_device(), which is invoked when scanning the device tree
  for a memregion's devices. This function allocates a phandle for a region's
  device if one does not yet exist.

v2:
- Addressed review comments from v1. Specifically, renamed domain.{c,h} ->
  opensbi_domain.{c,h} to increase clarity of what these files do. Also, more
  consistently use g_autofree for dynamically allocated variables
- Added an "assign" flag to OpenSBIDomainState, which indicates whether to
  assign the domain's boot hart to it at domain parsing time.

Gregor Haas (1):
  Add support for generating OpenSBI domains in the device tree

 MAINTAINERS                       |   7 +
 hw/riscv/Kconfig                  |   4 +
 hw/riscv/meson.build              |   1 +
 hw/riscv/opensbi_domain.c         | 542 ++++++++++++++++++++++++++++++
 hw/riscv/virt.c                   |   3 +
 include/hw/riscv/opensbi_domain.h |  50 +++
 6 files changed, 607 insertions(+)
 create mode 100644 hw/riscv/opensbi_domain.c
 create mode 100644 include/hw/riscv/opensbi_domain.h

-- 
2.45.2


