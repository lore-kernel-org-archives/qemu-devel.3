Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619C606A329
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=JQsrBStt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8O-0001UX-Vr; Wed, 04 Nov 2026 10:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8F-0001Sg-DY; Wed, 04 Nov 2026 10:42:36 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8C-0001DQ-Mg; Wed, 04 Nov 2026 10:42:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy7mggcB6i1eX7iTfiElLzAdyupdYXjoX/C2TU62NpC0d8d+2iNb36Nbj9bdW5MJUy1f3Lynxp5fTrSxEV7H5TjZbVeTlW2i3lhEQNtUQWjhR8zZrg5CR+BlCfcJCMofatw7GNJc41IpmWnTabUFDmtBNp7dO7koAJ0xlYuKSNeGzwDCuocC5fbMBlb3hhpmmjfTLqKm7FFsU8UA6/QZmuhxljsC3qRX75fg0CUVMEydY302fIA2C2NzDRIitybNSjcd1RPgaN13xkdNpja6B3nuMdB5KlI3mtPBkofG1JTX0XLJAcq435D2EoTF2tMXauNdB561FLiqnltIfzHsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys7g47W7H29g7iLNgy5CfGDeAz6RLzvYlguodITz990=;
 b=m1fdFK7LfgoNHhMDMg69AWj3Xc8mfj0cpJNCoX64pkhvut9+A8ToPWOJpkEFbKzFwvf+GizNkiVULDJxRw++dixqNIqARbXp72kZ/HcUL3tHbVGcLgNXx02iAd/139/KZhrEC6mZIePzPp2Rs5lT/YN8AGzAfaFnZ86IgffQTTE/G4L5PwSX1WwBELJ8cmKpWEG1EuV78t5bkJCxCvX4zDlHDfmteS1TcmFW4mnq/KNhI5VK85o7UFIf3GtqSXsW98X7fnQECtggDwsS2xJXkMtFbUErUY9/pkFhEAWyfmiSMTiryAy9PB3kdgjTHSTVOoVZFO1E+cvXV84PdO+ISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys7g47W7H29g7iLNgy5CfGDeAz6RLzvYlguodITz990=;
 b=JQsrBStthcNwshr7o0Z70JHrBYqhRYdzOwBtYe9xHu+Z/G33Gwb1GeYBbrvzgyjw3nFnZqFra0z1sfnHMfGt8WbRiqz24VacHMlKGjJajJ5jIIvKg5liBSYTKCL6HQCraOSuRwsV7t1gEoMSNcx/xbp3jmJCEtFfkiD8Tj0Swa0IlfJ4qunFXwzA7DoUFQ8tzhlHHwVJJ4vKRKsqr4oONDdWQlMcT7tAjzGpgql4h32uiaLN+wiytGRedmtilmYmMTu/K7atQzeLFo3DewkUqYUkCCQrsjtCg6JjJ7fhKk6BzqaG9gtgwOPGVO/JMBZIqCMpMwe3oQCT/MKD8YMenA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:24 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:24 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>, Bin Meng <bmeng.cn@gmail.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v5 00/26] hw/riscv: Restore Microchip PolarFire SoC Icicle Kit
 firmware boot
Date: Wed,  4 Nov 2026 23:41:27 +0800
Message-ID: <20261104154207.641511-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEYPR02MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 2703772c-5451-4609-a035-08df3a8a38d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|7416014|366016|261022115727099003|5023799004|56012099006|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: B93hod/7TKtlSp0cNyWRDM0f5BxTkhMqVTzkHUNj2p9Shzm5RB+/6q1jlPPG6WK5DSU3eRjURVa9Zn3rumGQOX0hP8ZbkkzuHHq+14s/6Ef3qM2Xe+t0DiSC/WQ1vcOkq5CFKI3SvI/zuvC7JudYRRojCSqA7Kgb4oVYQ/wPzVYp0At61m51xG0WErHyhrNtAD/W5XIE7VXO+3uMXGO/QXQiZOJkWnwWgtwBsinL2MsbqaBZdw6faN81LFIOiypt/8TEPPgS8l8XFQPrfJzwaR/URUaS5uqLHi8PImRCmJ/lhPhPznXCbEbuZLTorEp5ngJRwI/H2ERktf+oVOTMF2myhygEEY91zJHuepIyVo7pYlZcv6tnhcu67cxVsA8neN0AuDbOMdbcp2vigvjh/m19QkYcP3kPNGqeWWYsqARGMBUutV1Y6x8MZDdMxcj5k2NJpE4tPHqtG6hjp4K+VF3zEO9tNcQOQQfV5uTgvWLc8AORjUTFcxu3x2aHtDOZPnvQxgl5dbs22XoWqFz4WYE+llDe3ySc2XEvtIeLbUQrG1nViSWGKit5h3RzWyfpJ546RuRNnS7YNrTXIveLcXi8816Irhq+P6WhBqHwHcVVQ8VHTIftvCl2muo4WT7Jxq44sBZgDSGN+mO6ELcHov5ded0pPgNIhC4GUHr0rsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(261022115727099003)(5023799004)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pjbMq+EMqELh48gGuDSTwfKkSgzxsNMusxNSMLm9Z7fZG1f73Zpvb5ZxKEsw?=
 =?us-ascii?Q?MFZx9GKxyR8xbqrSiCpEUlRMV8phiMQiawFLY7iFrTTsHGReyTDMjywLFSYE?=
 =?us-ascii?Q?q/bUR/wWoLa4C/aJ4IjuqUDx2RsYPJKkITqit+iryZlIx1OLRTKZ58uXPUJP?=
 =?us-ascii?Q?HGO2C6G2a4VH+fz7MPeLHF5eDjKDnpNkqMtMuOkAVKvDBUL+GOqXfu0VQiKC?=
 =?us-ascii?Q?euPpa4GmxArcj+16s45K6qEPOJI+sin0DArwTeNGjFrCM+VWW3TkkIrSms0n?=
 =?us-ascii?Q?P8v4tCfAimAuMa4Q/NnZ6OeV8z+pBIqdpmoZ9nlyw3EBS7Q+yqN6vsjig6q4?=
 =?us-ascii?Q?dQ0YcnqUR6HBW/n69k2E2CrkQ3hYbMNL84JqIyZxJ1mPj3pcFA4aA6l/i4Rc?=
 =?us-ascii?Q?g768JiluDPu+Jv0HGiX4p+sPOpU/6Ms46DQX0PCkMXaINYhwdxlqiUKz88xb?=
 =?us-ascii?Q?W7X8xEZbiAZn3FqxMmnVbfzC4OHzbKc/tKyfZECNk6q55Pbhe2+GbaPXj0aa?=
 =?us-ascii?Q?ps0XpAWRR11a+vg62F8YcU5pY2czf2OevnTHaAlzM3epcmdu9/4qP4Ebsw5I?=
 =?us-ascii?Q?w9SRE7rLhllLmJFq5aZwh8SyMKE6eFFZzW4UmVyinKPYqUMitVBhM1czavgD?=
 =?us-ascii?Q?KD3O5D4rNye/Ql8xNarJItqH6zwCrG6yh1xxJtND36Dpd2mXOmJ+8c1sKvQF?=
 =?us-ascii?Q?lN7LQrkRSSN8IMJMhHFmaMKZK97wAsZu1RlEnoE+hkthiC/HvYa/FPgNWHrd?=
 =?us-ascii?Q?CxyXfebGvjJFalWJel9oDLLzHVGfgwUJ0T2HJmeK+8dhGVH+dMdBmt8nJtmQ?=
 =?us-ascii?Q?9kAkzlgPFIAGdH+CDqKI3xoXjhS8UH8HQODGGtfbBBgSd4JdAvqQ7PvwDWIk?=
 =?us-ascii?Q?9o+l6hHPKZkgGIOTLg4BEz9Ez0DgsqdYa+pKz9lkomMEFkIbfc4gyusuIut/?=
 =?us-ascii?Q?dq/4bNT64MKi4k5rKryqKvqwnYrzT2CoIxFFd2XY9HIDAyhR0fcHMO4d1wLb?=
 =?us-ascii?Q?kEDTjlr71Dkgvqe9H2rMNrviReHrlU+tqBY4oHJaFGZhlt7NooIyBN9/Man7?=
 =?us-ascii?Q?gczxmiLMbMMvit5uTn9ujqrzw8m0m5WqJ4FKVqx/k+9OJ0COm742maLu/NNS?=
 =?us-ascii?Q?F6PkfyLTnTa0E6PTBk8Ze7LrWYJIX0h56W2FL1fwdQtdHlQ8othl4hW2huFx?=
 =?us-ascii?Q?T7y0QWvOLpwbOPEXBO903WVQ1RpdAL6eBv90hpGQGgUp/TfiLqadkobiSRUh?=
 =?us-ascii?Q?CWlvUxJqFk09nVfiLfWX5ogtPi1KM3viCTA0Ja5tSZu+7NI6CXIoG+BvW5YZ?=
 =?us-ascii?Q?0Q68dEzVGnUHZ31Hq00TEJS3gBCNm1XPyGs5hKLtBeaPKys2Eglkd9i4kbwL?=
 =?us-ascii?Q?6pL8d+QSuYooap2HMBJgiClupgg0DxvnupMLyPSmhGdAtZ0DeeTSltnE4o2p?=
 =?us-ascii?Q?5FIplmt3T5TRDS33v3qilucJXIccBJ2yDs8DNIpV34ePp97WBi2RQzHWA7dq?=
 =?us-ascii?Q?GVdxdk54CjziZAWvq4lU1KmDqUnHTpb8DElPhscyhTUfzpP9sjOSZlbTbKkq?=
 =?us-ascii?Q?+9OCo5MwnYR+HQMiB3TiwnK63oy46pMETHrsy6ewmRcG2cEED++5cBtcF+S2?=
 =?us-ascii?Q?bX//aJSuhbPhmmgz/MFzcNwknbeQbMSWckVA2vAUhQGhMTF546C2r7xTGffL?=
 =?us-ascii?Q?UcpyEFjitw3UmhMQLpg3+tZDUeO2aDG/SYHb9gwXKHLtjxkpSpOI6ZUgTv5a?=
 =?us-ascii?Q?vGvISw5i+beD1CtPlTGOaslKpIYqRRU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2703772c-5451-4609-a035-08df3a8a38d4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:24.4948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BE0gU7ceSD/BJaY1fjQ0NSq4OgWkWD8f6oRGxaO53S1tZENsVuDsLpI7uHJX2mJpR3nYplAWu7BcFOpejwJGWKeL+6JqP3LXd/mHCVW9r0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB9159
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The microchip-icicle-kit machine was originally validated with an older
Hart Software Services (HSS) firmware stack. HSS v2026.04.1 cannot boot
through U-Boot to Linux because several firmware-visible parts of the
PolarFire SoC are missing or incomplete.

The first failure occurs before the UART is initialized because the L2
zero window is not mapped. HSS then needs additional L2 cache controller
and DDR training behavior. Later boot stages exercise system services,
the RTC, SDHC version 4 DMA, and high-capacity SD card block sizing,
along with the complete DDR aliases. The existing models ither reject
these accesses or expose behavior that does not match the hardware
specifications.

This series restores the complete firmware boot flow. With these
changes, QEMU boots the HSS v2026.04.1 eNVM image, loads its U-Boot
payload from an SD card, and reaches the Buildroot 2026.05 Linux
login prompt.

The changes are organized around the firmware boot sequence:

* Correct the L2-LIM size, map the L2 zero window, and provide the DMC
  status transitions required by HSS DDR initialization.
* Model the documented L2CC Config, WayEnable, and WayMask registers,
  and resize L2-LIM as cache ways are enabled.
* Complete SDHCI version 4 support used by the Cadence controller,
  including Host Control 2, SDMA system addressing, 64-bit ADMA2
  descriptors, and SDMA boundary continuation.
* Run ADMA from a bounded timer-driven engine instead of performing work
  from command or unrelated MMIO accesses.  This keeps DMA progress
  independent of guest register traffic and avoids consuming a polling
  deadline inside the command write.
* Advertise the Cadence controller's 64-bit system bus support.
* Add the PolarFire SoC serial-number system service and RTC, and honor
  the system-service notification control bit.
* Correct the DDR aliases and fix the board topology at its physical
  configuration of 2 GiB of RAM and five harts.
* Document direct and HSS boot, add focused qtests and a full firmware
  functional test, and restore the machine's Supported maintainer
  status.

Testing performed:

* Built qemu-system-riscv64 and the documentation.
* Passed various newly added qtests.
* Booted HSS v2026.04.1, U-Boot, and Buildroot 2026.05 Linux to
  the login prompt using the functional-test image.

The functional test uses the processmission/qemu-machine-images release
v1.1.1 tarball:

https://github.com/processmission/qemu-machine-images/releases/download/
v1.1.1/riscv64-microchip-icicle-kit-v1.1.1.tar.zst

When restoring the HSS boot support, 3 potential bugs were identified in
the upstream HSS source codes that either blocks the DDR training from
succeed or traps in a multi-core race at the very beginning or after
a succesfully DDR training but stuck at OpenSBI/U-Boot hand-off. There
are already bug reports filed aginst various upstream projects.

Changes in v5:
- Select REGISTER to fix riscv32-softmmu link failures
- Rebase onto origin/master
- Drop the high-capacity SD block-size fix already merged upstream

Changes in v4:
- Drop the unused ADMA callback forward declaration
- Move helper definitions before the data-transfer declaration
- Merge the ADMA timer callback and batch routine
- Use HSS v2026.04.1 and the v1.1.1 test-image recipe
- Select the SoftConsole toolchain explicitly
- Use the generated complete boot-mode-1 eNVM binary
- Use the v1.1.1 test images with HSS v2026.04.1
- Add the execution bit to the python script
- Collect Conor Dooley's Tested-by for the complete series
- Collect Bernhard Beschow's Tested-by for the ADMA patch

Changes in v3:
- Name the QOM parent field parent_obj
- Move the LIM and Zero windows into L2CC
- Use the shared SiFive name and indexed WayMask registers
- Parameterize master count and the RAM-backed Zero aperture
- Resize a LIM alias while keeping its SRAM backing fixed
- Configure and instantiate the shared SiFive L2CC
- Map the register, LIM, and Zero windows exposed by the controller
- Remove the external RAM allocations and l2-lim link
- Keep the PolarFire master count and modeled Zero aperture unchanged
- hw/riscv: sifive_u: Correct the L2LIM maximum mapped size
- hw/riscv: sifive_u: Use the shared SiFive L2 cache controller
- Rename the test for the shared SiFive L2CC model
- Exercise 15 masters on PolarFire and 21 masters on FU540
- Decode the seven-bit opcode and nine-bit mailbox word offset
- Bound serial-number responses to the documented 2 KiB mailbox
- Mirror the current control flags in the status register
- Use default access sizing for the control and mailbox windows
- Split the NOTIFY fix from interrupt acknowledgement wiring
- Separate interrupt state ownership from the NOTIFY fix
- Link SYSREG to IOSCB for MESSAGE_INT reads and writes
- Support both clearing and setting the MESSAGE_INT pending bit
- Update commit message to mention the DDR aliases is modeled following
  the Icicle Kit reference design
- Change only the default hart count and retain the minimum of two
- Document reduced topologies and matching firmware requirements
- Include the DDR pattern-test patch used by the functional-test image
- Document the image-only FPGA programming tool check
- Describe startup-race symptoms and link the firmware investigations
- Explain how reduced hart topologies change the CLINT DTB tuples

Changes in v2:
- Use the Resettable API instead of a legacy reset handler
- tests/qtest: add Cadence SDHCI ADMA pacing/MMIO reproducer
- Assert bounded ADMA pacing and MMIO-independent progress
- Reuse existing SDHCI definitions and command helpers
- Verify transferred data against a known image pattern
- Make 64-bit system bus support a device property
- hw/riscv: pfsoc: Enable 64-bit SDHCI system bus support
- Reset the RTC to the documented hardware values
- Expect the documented hardware state after RTC reset
- MAINTAINERS: Move Conor Dooley to PolarFire SoC reviewer

Bin Meng (25):
  hw/riscv: pfsoc: Correct the L2LIM maximum mapped size
  hw/riscv: pfsoc: Map the L2 zero device window
  hw/misc: pfsoc: Support DDR training with newer HSS
  hw/misc: Add SiFive L2 cache controller model
  hw/riscv: pfsoc: Map the SiFive L2CC memory windows
  hw/riscv: sifive_u: Correct the L2LIM maximum mapped size
  hw/riscv: sifive_u: Use the shared SiFive L2 cache controller
  tests/qtest: Add SiFive L2 cache controller coverage
  hw/sd: sdhci: Run ADMA independently of MMIO
  hw/sd: cadence: Add 64-bit system bus property
  hw/riscv: pfsoc: Enable 64-bit SDHCI system bus support
  hw/rtc: Add PolarFire SoC RTC model
  hw/riscv: pfsoc: Add PolarFire SoC RTC to Icicle Kit
  tests/qtest: Add PolarFire SoC RTC coverage
  hw/misc: pfsoc: Model PolarFire SoC serial number service
  hw/misc: pfsoc: Honor service notification requests
  hw/misc: pfsoc: Let IOSCB own service interrupt state
  hw/riscv: pfsoc: Correct PolarFire SoC DDR aliases
  hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
  hw/riscv: pfsoc: Default Icicle Kit to five harts
  docs/system/riscv: Document Icicle Kit HSS boot
  docs/system/riscv: pfsoc: Document CLINT topology for direct Linux
    boot
  tests/functional/riscv64: Add Icicle Kit firmware boot test
  MAINTAINERS: Add PolarFire SoC Icicle Kit maintainer
  MAINTAINERS: Move Conor Dooley to PolarFire SoC reviewer

Wadim Mueller (1):
  tests/qtest: add Cadence SDHCI ADMA pacing/MMIO reproducer

 MAINTAINERS                                   |  11 +-
 docs/system/riscv/microchip-icicle-kit.rst    | 162 +++++-
 docs/system/riscv/sifive_u.rst                |   2 +-
 include/hw/misc/mchp_pfsoc_dmc.h              |   6 +
 include/hw/misc/mchp_pfsoc_ioscb.h            |  10 +
 include/hw/misc/mchp_pfsoc_sysreg.h           |   3 +-
 include/hw/misc/sifive_l2cc.h                 |  42 ++
 include/hw/riscv/microchip_pfsoc.h            |   7 +
 include/hw/riscv/sifive_u.h                   |   3 +
 include/hw/rtc/mchp_pfsoc_rtc.h               |  46 ++
 include/hw/sd/cadence_sdhci.h                 |   1 +
 hw/misc/mchp_pfsoc_dmc.c                      | 273 +++++++++-
 hw/misc/mchp_pfsoc_ioscb.c                    | 174 ++++++-
 hw/misc/mchp_pfsoc_sysreg.c                   |  37 +-
 hw/misc/sifive_l2cc.c                         | 282 +++++++++++
 hw/riscv/microchip_pfsoc.c                    |  91 ++--
 hw/riscv/sifive_u.c                           |  32 +-
 hw/rtc/mchp_pfsoc_rtc.c                       | 477 ++++++++++++++++++
 hw/sd/cadence_sdhci.c                         |  11 +
 hw/sd/sdhci.c                                 | 146 +++---
 tests/qtest/cadence-sdhci-test.c              | 282 +++++++++++
 tests/qtest/mchp_pfsoc_rtc_test.c             | 315 ++++++++++++
 tests/qtest/sifive_l2cc_test.c                | 306 +++++++++++
 hw/misc/Kconfig                               |   4 +
 hw/misc/meson.build                           |   1 +
 hw/riscv/Kconfig                              |   3 +
 hw/rtc/Kconfig                                |   3 +
 hw/rtc/meson.build                            |   1 +
 tests/functional/riscv64/meson.build          |   2 +
 .../riscv64/test_microchip_icicle_kit.py      |  56 ++
 tests/qtest/meson.build                       |   8 +
 31 files changed, 2615 insertions(+), 182 deletions(-)
 create mode 100644 include/hw/misc/sifive_l2cc.h
 create mode 100644 include/hw/rtc/mchp_pfsoc_rtc.h
 create mode 100644 hw/misc/sifive_l2cc.c
 create mode 100644 hw/rtc/mchp_pfsoc_rtc.c
 create mode 100644 tests/qtest/cadence-sdhci-test.c
 create mode 100644 tests/qtest/mchp_pfsoc_rtc_test.c
 create mode 100644 tests/qtest/sifive_l2cc_test.c
 create mode 100755 tests/functional/riscv64/test_microchip_icicle_kit.py

---
base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
branch: icicle-kit

-- 
2.53.0


