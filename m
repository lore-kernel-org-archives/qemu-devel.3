Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432DFC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6j7m-0005oq-Tp; Wed, 16 Sep 2026 02:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdondi@axiado.com>)
 id 1x6hcc-0002E2-Cu; Wed, 16 Sep 2026 00:51:52 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdondi@axiado.com>)
 id 1x6hcZ-0001Wh-4C; Wed, 16 Sep 2026 00:51:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVIk5Ew6jCei1whLGkhdfINqlHInSIOfXMqq6QBKLawJNmutUt4VKbGITMtuh+LHgL6B/n8R5LP3i8FJNSU3Kmcm7kxWZ1gIQ7qG2LDXyjB6pdK4OlHnnNn4BWvJIgb7410npG/1D9XG6ONiJ244hE+l4HK0cUI0gJQIM+flmVJCWJesrZcUwrfQUh7ZNL7M1fztU/rCwc41aw8vRiHwOSL+4zJs4WcvHByVXqNnATB9kGWnLCoSx2rKjxEb9z8NIvEZBQRGRl/okZWi4EIPnSvSoEW7f3+prp626vflHeV+z30cUbc28vV3xWDJNb6OcsdRMRLC42rhYIOhi5wFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQr1sTT/BXajgT6GLHoDeZqpInK646UGJ+AjWxFGMHQ=;
 b=fj1k1ZFJxsF5I0BYj3sViiz2Xs8kDvqeQL1G1K4Pp9pzRnkGmY7PDM7EDeZ+RdoAyOlItMRJDFICmeeBnUeSw+0WQOiQf7omqkJLHeOVHUq19XE2Nc9zGC4XFOgV+9Q4G2Emlta6cVpNDL6pscVk4Lozh5qJwhrQUmluWM7q9sK1l2egI+dwRbqhiri9GunYMjJIcVUz2YzkjNFwWo/RhELg8Kc0jmMsVQ/E53GL1+5sDPpdpezG2vmMG7Zgecldtq1s29hGY3K7HPPSRGjh2Pj3V6D99627kVSnWv2ySwJhzANxl2OreUY18kuvIz+WqEoJmbGOxtcAM1+2/4/2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQr1sTT/BXajgT6GLHoDeZqpInK646UGJ+AjWxFGMHQ=;
 b=TKFlt6edBP4sRNhpjtQCGFEnehkCQdjG4A0DaaSnm5vwhijuU558l17RVmfigzkVL+gcUeVqYStlzhfVyVIoTEoTUUvV648YIVPSQD5j1LIVv56lXZttk7+3ub5Y10r6ipprY+pGg2GtgsB6qZsOlzWzCG5f4uR0EgXC/2o2oJ+jJCQIy+Xn/zy4D19W8GVzUnQOyriQPx93GWbFmpdgX06p/udHFX9IcDTNm3C29C6n9tGvSOKRTedICiM3iBOaYxD3eiEHwzVcd/MM0+Drw0WOieNB/t9MRaijGexFPAfsdhHvbVn80dS5ayi+UjxogcAKH+vXYA5xYb3Khh6aCQ==
Received: from CH0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:610:b3::10)
 by SN7PR18MB3823.namprd18.prod.outlook.com (2603:10b6:806:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 04:51:41 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::94) by CH0PR03CA0035.outlook.office365.com
 (2603:10b6:610:b3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 04:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 16 Sep 2026 04:51:40 +0000
Received: from axiado.com (unknown [10.4.1.32])
 by smtp.corp.axiado.com (Postfix) with ESMTP id A791B4186B53;
 Tue, 15 Sep 2026 21:51:39 -0700 (PDT)
From: Ratan Lal Dondi <rdondi@axiado.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, jasowangio@gmail.com,
 kchiu@axiado.com, Ratan Lal Dondi <rdondi@axiado.com>
Subject: [PATCH 0/2] Add Axiado HCP network device model
Date: Tue, 15 Sep 2026 21:51:32 -0700
Message-Id: <20260916045134.1687145-1-rdondi@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SN7PR18MB3823:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: da19c0d1-abe6-453f-2b3d-08df13ae32e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|10067099003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: ig3PVArMZEQ59Z2futjiHuDYoI1Luetm4t/t0vPcOcsMUpT3zfXRJ03OrXsQXpWNbUOinMw8Q9T5O2LHnHb2H/3Gn0kNEtvZtLTsSGm3yXOX/4Ssn0x+6tKgMm5oyOzfr/cGT66ZuGfzbU3bSWIW8BOyuy6P/knjIsFTbb+coZVUnfOIJX6dgjVKUjMhJn3vA1pm4PBAj1GK/hADVbAxcYJ+PgET+RPfoxenPjgnLMyeWFkg/yW0hiP2ufh+Ph5YhC4nVJLrwki+zrSvCMOUDS/W05Ppa2/3gDVUGtSQFxwTJIKaEyNEYFap4Q+DpO4dkaGA4vMkuGTQBUfPz728Hbu+7iXKnWf1ATl2lwmhs4rHO2qrozkDuffS2NKrMQOo1bvcWzrLNwBmQzIXPglIL+3vyst7ztlCRk5TSa6mB2nQ89JcZHYXOeMhMciZjqZMhXqO1BmA9rQAKFb6EXsIPGFmfPlpCKuuyEzDAjpnyyms6CbMfgMiwZIpKiVa5B8YjNEoFL+x1BbKmJ2w7m0NsQH/X66bASSmum0LNuticwjhfB7PMV7FxW3RTpiUXAbUxgjBcibn2PL2eVsZhMaKo8fZqwmB7piFPhNDOZ/zYCgfY4G+OMWbqRksr48oKKuDy5GNYzOrtTHZhtikPlP6yA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(10067099003)(18002099003)(3023799007)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1czYKFhViOPPUk5pKyHnAVeEBA5gloxvGxWTeGQQc+a99dX4jfbukkGf7tZQuNp3a4UdcxPjbtvaexscajtXbIJ1UcAKvRQspwSoWjgFN+v1xpEM3Vi/kLjTcOqcbHLaBzPUXBa6anzSnyZ89XfD4tpWWBWZGEiYYruB85K1ApuEK7K2a729pvk1zinnpSP/snZoMNnZj9n2oWzIqaXYzAnYsT0UG1JHduypfc0vKR+7S1aOvcLcor+0C9fFUuBnQl09Lrik/6pC1s5KTWqcGGdwKxzVHL25aoS7ckEHtg/sUlX0WvuAJZYonDV95jVi/hIJA9nCkh/7HtnIr77eyNBSsuODFB4r/K3FOvHfTh/95qo0Vqq6tWX6cap5pcNM3FSnfMIIsTdssDxh+xebq3KVP6KJE2bWqlhxanFBord988kpaSUfdMxmrbTDNH2V
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 04:51:40.5790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da19c0d1-abe6-453f-2b3d-08df13ae32e9
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3823
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=rdondi@axiado.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 16 Sep 2026 02:28:02 -0400
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

This patchset introduces Axiado HCP network model for SoC AX3000

The HCP (Header and Crypto Processing) block is the substantial part of
the series. It is the SoC's network complex, built around an Inside
Secure SafeXcel EIP-197 packet engine that acts as bus master for all
packet I/O over four command/result descriptor ring pairs. Five MACs
are demultiplexed by an "application ID" tag carried in the EIP-96
input and output tokens. Only the packet datapath is modelled; the
EIP-197 cryptographic transforms are treated as pass-through, which is
what the guest asks for when the block is used as a network interface.

Refer Axiado website for more product information
https://axiado.com/products/

Testing
-------
 The user-mode network backend is required, so configure with libslirp
 enabled (it is auto-detected, and silently absent otherwise):

  ./configure --target-list=aarch64-softmmu -Dslirp=enabled

  qemu-system-aarch64 \
    -m 4G \
    -machine axiado-scm3003 \
    -device loader,file=u-boot.bin,addr=0x3C000000,cpu-num=0 \
    -nographic \
    -serial null \
    -serial null \
    -serial null \
    -serial mon:stdio \
    -drive if=sd,file=obmc-phosphor-image-evk-axiado-qemu.wic,format=raw \
    -netdev user,id=net4,hostfwd=tcp::2222-:22 \
    -global axiado-hcp.netdev4=net4 \


In the guest, bring the interface up with DHCP:

  udhcpc -i eth0

Then from the host:

  ssh -p 2222 root@127.0.0.1

With the unmodified vendor Linux driver, the guest:

  - probes the HCP and brings eth0 up
  - obtains an address over DHCP from the SLIRP backend
  - resolves ARP and answers ping
  - sustains an SSH session and completes an SCP transfer

Not modelled
------------

  - EIP-197 cryptographic transforms. Descriptors are pass-through.
  - PCS/SerDes behaviour. The guest configures these registers and never
    reads them back, so writes are accepted and discarded; the link is
    always reported up.

Ratan Lal Dondi (2):
  hw/net: Add Axiado HCP network device model
  hw/arm: Wire up the HCP network complex in the AX3000 SoC

 hw/arm/Kconfig              |    1 +
 hw/arm/ax3000-soc.c         |   23 +
 hw/net/Kconfig              |    3 +
 hw/net/axiado_hcp.c         | 1372 +++++++++++++++++++++++++++++++++++
 hw/net/meson.build          |    2 +
 hw/net/trace-events         |    6 +
 include/hw/arm/ax3000-soc.h |   14 +
 include/hw/net/axiado_hcp.h |  172 +++++
 8 files changed, 1593 insertions(+)
 create mode 100644 hw/net/axiado_hcp.c
 create mode 100644 include/hw/net/axiado_hcp.h

-- 
2.34.1


