Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5044E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=Ji2LVCwZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTgAj-0005gh-1O; Wed, 18 Nov 2026 08:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdondi@axiado.com>)
 id 1xTgAh-0005gU-QW; Wed, 18 Nov 2026 08:57:59 -0500
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdondi@axiado.com>)
 id 1xTgAf-0002wA-QX; Wed, 18 Nov 2026 08:57:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqNtlFqfmi4SBo51Ofp9248JW9wnpmxeKHFb3cvV2hLRVKfU4h8FprS42//Hyb9iaIjZMezjyMT/k8wVvfMtQJY7Ioa7WgLP7R/Pb8rir+R8L7KoN1iu6ahO6j96JDQ1d6ED5qulg88+2oMe08LUlQt3wb+NPtW/tK3N2AcX3mrGPGnDPoNJjGFY7gjdpF63YZyUEc4vk7+S9OM4KvEfTSTYEssXu3n1UchRQkOqTIk15621mM/2z5EIjJNVk/ycBg8T+SbTH1jvIarCkZvrGyuDal75/IjdYxaIJL5KyMFmdYaNk6HdMBHtM6wUf4zCrwfcN4WwHDN8dkg+ZtxoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+ugTQEoiVXGVe/sgAFOoUj0IjEo4rOV+DOmXEoF+Pc=;
 b=HA3CNhK73R6eG4uSBF0UAZG7fwpOeyPf8Pc6LMtA0M3JIKrRrCRiK17CSqtF3a3ZYXyDXD5Y9JcuG3dznxYqNk7SOi8vDUk8aWTllLSw6NtVhJQMV6GSVPJwMXjy0NRqMpYXc6ZCsWFKsysySSABfzIO9ujhZQvsUwuL1j30ff+MeWI0wRnokQH5qXZSFqJl1O6ca+AyLThV19GgST78TNMElQHQxi2ab/fOdYY26MBDbxs6tOGHdX0J2dDuuojYJ2HWM12waNgJMwqM4W6HFf0B+7UNW6XdEMCOP0zpnFmIg+PzMEQE+9kyyWHXLnZcIDrYwvi1Y0DeKdMpRpepQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+ugTQEoiVXGVe/sgAFOoUj0IjEo4rOV+DOmXEoF+Pc=;
 b=Ji2LVCwZy2ZLhPQlx/IIYYAZKl5AhA1GN9XObeGqqDna/Az1BCycDZEdEhVZET+0Rlm9Qj/R/2K0BmS+1bVQjD48W8ALsOXEqhqXSb0seXyJQMBtnmFcJ9/MRQZLV3IEPUStbuxQZp+ZnD1awPcCivfBckithKpxOAHn5tWLdMWO4ro4AzSMB4nhKqsUto2p/Jf3Kah2hL5jXEP+h78aORVvkyYGy7tBL2PVVvq4v8lx5ddTOmukj5sJGcABZ2Faq7ZebW/J+BO84pkibDYKNhWNis95oQHH3UFsfswpNw02N+ydAnxXvsScAJKchRlA9m//pY2UZMqT/o0nJzci2g==
Received: from MW4PR03CA0177.namprd03.prod.outlook.com (2603:10b6:303:8d::32)
 by DM4PR18MB5425.namprd18.prod.outlook.com (2603:10b6:8:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:57:50 +0000
Received: from MWH0EPF000D894F.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::1d) by MW4PR03CA0177.outlook.office365.com
 (2603:10b6:303:8d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 13:57:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 MWH0EPF000D894F.mail.protection.outlook.com (10.167.249.215) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 13:57:49 +0000
Received: from axiado.com (unknown [10.4.1.32])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 2E03A4186B53;
 Wed, 18 Nov 2026 05:57:49 -0800 (PST)
From: Ratan Lal Dondi <rdondi@axiado.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, jasowangio@gmail.com,
 kchiu@axiado.com, Ratan Lal Dondi <rdondi@axiado.com>
Subject: [PATCH v2 0/2] hw/net: Add Axiado HCP network model for SOC
Date: Wed, 18 Nov 2026 05:56:29 -0800
Message-Id: <20261118135631.3563037-1-rdondi@axiado.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894F:EE_|DM4PR18MB5425:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e4cd792a-76ff-4641-9bbf-08df457beeba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|261022113327099003|261021123027099003|10067099003|261022075727099003|56012099006|261026140227099003|261022115727099003|261028144727099003|261021121427099003|261021130227099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: 31DPEeQU2rE2nyMgBA3xa8vLFMf8AgqAhVQWrqIGqTgNFOH8rOyiF61zfjJLk1/kWQEXmt3Kt7TEE09M/NKx+vWwSRc2wuSEUqh4+oH4QtxtU21zlDBCX+MEtYVpn1O5lk9XELwFCgW1fEH5MP4kHL1fYfo8tPoyQca6G9TCDKes+uAOmRESD97q3qRXWE1cvmeXRiv7vqwllwGzox5NYgnldIwFfQEbA7GMyvr+XhHsIpW5iYS0T4HwDoeWet+qrOxKvC56/ut3bUUitKtTXddGc0RxEgQeql/4nwbvlPpaVvRBodYvp9dTX3uni7dOOXUgLlYuXp1fB41edsEmy+mWm/b6e/UeOUdv2DuPxSD0IrmUmAbDcMCaHLXSnxc3KRmSGd43acKKSNHLyes3W3vjnHSpIPvXY0ANrN1C1F0krt36NdcBV4rX5ZRPsasnro2oTnyXds9L+QcKyP6IyAaLIucNkXJym1WPHPS7ngVs8+JZkhRamz6B8eMw0B9WQPN/EkDOmtRGtYKW03AlmzWCQE7Wa3rbhy506q7RS0PwXAAmlfCt0cp71wze5ABQLVCXKv01ocS5mXJYg0bXyZcqryYceWv95B5nG0zC1AI2yFaIri8n2rq4TeHS0gVbcIyZw2shz16sDOXxH5D/9w==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(261022113327099003)(261021123027099003)(10067099003)(261022075727099003)(56012099006)(261026140227099003)(261022115727099003)(261028144727099003)(261021121427099003)(261021130227099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(13003099007)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pFHuuVz/ywxR380jmPNp0cPvt0ewHsLCRPUoAGP2vkkffnCapspjBsXev2NeIlfyQDY0AYR3RNySVbszQhIUnOxJ+n/7ZVfX8hNKkx8QP66GQaiIAUjM+RlzI34DsErkOrBvZ9da2YX0/HpbLdkxRwqpACREYgtNOAggazsnV55FoKpH7I1LL8TwYtD1oGUIilAfJKw10DBHqiCyFsoz2BWYQG+KUEjlN0Pocr73uS+4r/T5IrbtB/wpeA1iDUVJe8mK4Gi35vSph1+BWgHKTso+gvv4RK4Egi2glfkbOr+UFlRWUNv33kSZgf/CqAd9OFkNsAF5MRT1MIYh8wWl6JvEBry8snU0D6+uKWHVSzYHBz6x0eV5GAdfI2Y7f9CDyj9OGYvw4EBoCF1Vug5EPcYllFBH8EoUq/Xkq6eZm46/jNhd/3ytbKQTxYEz79UT
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:57:49.7253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cd792a-76ff-4641-9bbf-08df457beeba
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5425
Received-SPF: pass client-ip=2a01:111:f403:c110::3;
 envelope-from=rdondi@axiado.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patchset introduces Axiado HCP network model for SoC AX3000

 hw/net: Add Axiado HCP network device model

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

Changes since v1:
- Rebased onto current master to resolve merge conflicts in
  ax3000-soc.h.
- Removed an extra blank line in ax3000-soc.c.
- Replaced AX3000_HCP_IRQ_BASE with individual AX3000_HCP_*_IRQ 
  definitions in ax3000-soc.h.


Ratan Lal Dondi (2):
  hw/net: Add Axiado HCP network device model
  hw/arm: Wire up the HCP network complex in the AX3000 SoC

 hw/arm/Kconfig              |    1 +
 hw/arm/ax3000-soc.c         |   31 +
 hw/net/Kconfig              |    3 +
 hw/net/axiado_hcp.c         | 1372 +++++++++++++++++++++++++++++++++++
 hw/net/meson.build          |    1 +
 hw/net/trace-events         |    7 +
 include/hw/arm/ax3000-soc.h |   17 +
 include/hw/net/axiado_hcp.h |  172 +++++
 8 files changed, 1604 insertions(+)
 create mode 100644 hw/net/axiado_hcp.c
 create mode 100644 include/hw/net/axiado_hcp.h

-- 
2.34.1


