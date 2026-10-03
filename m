Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEA3CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD38c-00073k-7M; Sat, 03 Oct 2026 13:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38a-00073L-NB; Sat, 03 Oct 2026 13:03:04 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38X-00075o-H6; Sat, 03 Oct 2026 13:03:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+dI9jadrpqujc+CDr3H1py+g9xTgIo9EfBaTjA3U3bsdLeua6w69NxUNDDnP9qzbTVhFkOkfpaQRgdnEsd2s7dH1FUCBaH3M6HtrQF8Glae+qS/8Ns6dcMt9yTQKE5k3UIIqt3lnTzPBj8G7Bo6l6hGGq+FevWxzJ9hdDtXn95VC2q5285xmmk8raZZiR2ExuySbS3p/E/zniJif/2s0f6Rb0VgGxrCMk2P4Wb0Qblre5eFs7sQVpzo8oE+BICe7ufmTmxIbOj+21Jfjzmw1Qo1hIGKeES4cL7hRHPtzdBbSlUpwE6GJizomHAu/PRrFyWRD1tjdJEeS8sioz2rzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdihNhbm2DjK+eLVlB8c4k5Mt/Q1BSbW7LpE0IoR5bI=;
 b=xw4W5/gaEehQOY4ffgW1dxZHZtXuyBIwIQUVH+aqTdzANidNxwuHSsaOfOaiQotWzrn/tVXI7ftTCtSgtZqyz1+M1unVrusi6FVIDYkscHqeC33+42uANZ9ms5eyj+cogCBTNYu8R3HQhRTxRIvW5OhF0moHFkKVSlsHsbOlU+Ok1lGKFpPOukTeBxcVM8xFCxqmv1xh9LcwXIEqohRNKWt1niSKH8Wuz1lGo9SnQECSd+I9TxcRh718q94KHmeVE5K+cMh3qpCfEq1u9GCEeHDEZlvKCx+qRHKHzPUlhD+g8rxuzbxJMbvnhnaIipuxMmfqjaimtA/beHI20g/QFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdihNhbm2DjK+eLVlB8c4k5Mt/Q1BSbW7LpE0IoR5bI=;
 b=P8xgynSji5+xb78LbqWmq0X8ywFKckwyoVT/roZbJBso36FozaQzpIGTkqxBzx6SEWvf/PBUzox2ej10kuFRUAlZS6qPqvB10DciX1lg65sqxmLwqUrI4CtRzL8OUAzJoPTco/kyxUuRBslnIiLbPIPd2ht7V183JEBQ4cQ0jUHG5az91RW8eRV79ahorAWAfdZ1fGZdeA2sjoSewdNCIKzC0U5Bb4HmN6Xbzpd5Lj/TflhxylzqQeFBDcZ6mwqNgqaJCL3tFE9ja3ekixigS8inU33zOvJEYPmt1nHDDggbfRtzQWMnp2w16Wkf2Wjz+c8KP01xKJE+YU+pqdYlmw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYSPR02MB7371.apcprd02.prod.outlook.com (2603:1096:405:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:02:52 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:02:52 +0000
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
 Thomas Huth <th.huth@posteo.eu>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v3 00/27] hw/riscv: Restore Microchip PolarFire SoC Icicle Kit
 firmware boot
Date: Sun,  4 Oct 2026 01:01:50 +0800
Message-ID: <20261003170232.2450916-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYSPR02MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bc66c0-15c0-4a8a-d768-08df2170292c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|18002099003|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: qWQAulnpHoY+xHUr6QZkKZkPh/rLIC24Nm0vH3CYiFIY2+Bu3r8GRDNe3+jU58NV52ANnYsi39Dx1mM20x4ANdnm+BC0WgEI+sk4gpFlkwQ3j6FJ1QKgZmfr2MrgXgfQCLUfEkS1PV9FoWpbyoesAuUlFEzSPJAvTlJbDm9yLH6izod1OqKesJyWYZLQyloYfWRE7DtxdyNmk81opsE8iQ0OzsHAMfKn7qCY97CHDhAPFNxW3ryqfCmykz2CSFREqDyOI8kRnM/oWudFnNlJJJfCQznGyUi7gbW4jZNEred/hF8Er4bnNMtAe1T2nfBYQ3Vc9fum9xBMFCNBtirSro7druT0o1N+o4gWRuwjfq6POM+4ll7pOvakUdlt0bb0MMOKnMINKFPZVL4LidwfTn/mXLF/ram9oB3BGEVTZb7/d5s6DYoJGBJsYhZYTQDRVLEycUzdooELxyi67JAtZn0RihwPZ0HZvtEjvCV6IQi00M4XUo1GGJ1dTWL2bFBf3UvHHhokD2H0PDyjy9U2ISBEF1R27bk5B4nMO5e8nMOPllEGhh9j2X77hYNx14RLXUKcZY0jvRJBglOZ78JuK3iNZPcIPKFfF8BBcr0Oa+IrsT7i+qcy9DpTO51zI2ZiRogxDG58aSaoLk69TGH2wBZBTUm+kszOcms1TPdHO2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(18002099003)(56012099006)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NaV0hzZ1liaWl2eE5vcnliVEFlblZjOGttZ0Z3b2ZFemU5S2p2U0Z5bFZX?=
 =?utf-8?B?TzArYk9TTW9xL094MzN0VENhVHMxTjVxL1VXZHJYdHo1eW9IZ1l6bzkyS1Zo?=
 =?utf-8?B?QS9KR0xTVjhKeGhJV1BSRzBxdFB5c01JcU0weU1aaGpwTUY5THAzM1d5R3RO?=
 =?utf-8?B?TWc4T1dQWC9GTFhueWhWRXBZbjhORmFLdW5VQXF1RGNVNXBFRk1jTDMraTFT?=
 =?utf-8?B?bjNpbXB6cURTUjRESHJmMUhmYWdaL2oyNzg4RmZJK0JMMVNodTZYeUx6UEM0?=
 =?utf-8?B?M1dVTDRDbW5jVHo5dkhPZSt1NjNlN2dtZENzSzlFeGF2Z2ROc2pRZGhVTzdr?=
 =?utf-8?B?dW1oaHpqOFgrSWpYTDBHK0pEQ1BvUmo0K3Z0YVU2bjZwYUJobE1hN2xnMXdo?=
 =?utf-8?B?eFA0T2dqdUVzVzk3SmdBYUlCLzY4ODlsbkFzalFMMCtxREZFSkM0anZXM3Vi?=
 =?utf-8?B?cnJCN2k1MU4zUU9UNFhmREFsL1RHMXBBUzhPNHR3YlRKQlF3OHRYNVRnODgv?=
 =?utf-8?B?VVQ1ZTZ5MlczOUJnY2hBclF5UlJpbmRBaUdNemJwMGdlWFQ0clNHNlY2Ykpw?=
 =?utf-8?B?YUszTEo3R2hZa3JvcWo0aTkrdVVrcXZDdnlJNlVKU1JSVE9uWXVvYmtWUDZP?=
 =?utf-8?B?ZEl4eUpHUG5oL0RnUS9zN05JWlVOcG5UUzRKeTRxaXpUdmZGTXJSZlBRTE9w?=
 =?utf-8?B?Z1RPQ0crUkd5WGhaWTJDV2ZnblQ3T1hKRXFuTGJpS3Z6N0ozc3hTc09WNnZM?=
 =?utf-8?B?M3pxL0o1dGVrdWZ3SkludW5ZNlY3MUFOMDN5dk1sNkxuc2dUb0Uvb3BPUGhH?=
 =?utf-8?B?bzByVnkvM3NOd1FaZFV4c21HMXZSQ3JJM1hDVUtiMkpUa3NKQ2lVMTJoN0NL?=
 =?utf-8?B?K3NoT1lSM1ZQY05KRmh4TmUrNlpHMTZVb0I0R0FKTmhZcFBTVXg2SUZRV2U2?=
 =?utf-8?B?alo0cW00UmNiZjhBT2lMdld0ckx1VVo2VFpWLytCRWw3UGdqRkV2ZVVsNVhh?=
 =?utf-8?B?Z3BwWE5tQ1ZtekUrbGVRVDB2Ky9YWTdmWWY0Ym5EREdldmVKN240MUZUamhm?=
 =?utf-8?B?VHVDclk4emhXWG04Z0ZaVHpscWI5M2RmaHNqNVdPTFpRSVpGVzd3ZDdkajlK?=
 =?utf-8?B?RjdINCsxa09LNXZsQ3loSFltQXlCRGRVd0Z0NGlRN001ME9JUjZiak1yR0NX?=
 =?utf-8?B?ZnB4ZkdUNTMvM3BSRSswQnlTbkxkTDhVWXBkY2tWcldITllkT09tQ3FLbnRJ?=
 =?utf-8?B?OXc1Q3djOG40eWJHNm5Wc0JKU21nNC9TSERJaXZsekR5SmNZaWtlVEV0Z1NP?=
 =?utf-8?B?MHdkOWNJNXJzOGxoVHZQV2tQY2o2ZkJvWTRsN001NzN5SHZPaWVQYmR3OWJJ?=
 =?utf-8?B?MmRETktkL1ZCTVBiWXVJaGhvVGZybHBLVWRta014Znk4Qm9VRXZXZzdackRI?=
 =?utf-8?B?ZExGcmtnQXIvcnBTa1o4dWFRVTU0emZ6Mi8ydm5McVlzeDdpaFBXSjhpYndJ?=
 =?utf-8?B?S21CeU95Y203S0NQeUUwRWRMVjdBUlFDME9xR2dtVFJPUDVJWVJIOTVFWCtZ?=
 =?utf-8?B?cDZkWStGMHBiN2o2S0lpS2lWZkxqS0xuYkk1ZWdTWkxFNGhXWHN0NGxnMkhu?=
 =?utf-8?B?N3d1czJjVGJ0NXdsSDltc2RQMVNQUDhhWUlzajhSS3l2VWJlMTJNSkxJVzNV?=
 =?utf-8?B?dUxlMW0xWVRYNlN1cWxYTE5XL1NhOTRTbE9ZRnFqdnNSWWE1RE9GNk9Zencv?=
 =?utf-8?B?TkcxM2RhT2J4Zzc0ODlHaWMxNG5qT0RjaUVSMVlydFFXOW1kUGlUeHdOaTRY?=
 =?utf-8?B?cGpXN045SkpMQ1k3ZWNXcVk0Qi9BaUZPOXc4NkJIUUN3UzdQUHNFejF4elRZ?=
 =?utf-8?B?cElnQ2dmbUJSVjYzTHpOMU1RK3BmYjZhNWNFeTdqRWtyV3pxMzczVEo5N2hk?=
 =?utf-8?B?U3AyTEw4VGNSMG1hZjZMbXBEbkJIUFBmQXZSd0xkVkdHMnAvUlFkajlSdzVu?=
 =?utf-8?B?WUlPZVNxMTFSdHh4bHhxc1dWd0l3aEhtUytMa3lNNldhL0FGR0h3emE2V2pq?=
 =?utf-8?B?Z0N4ekp1dTdLRS9NeHRZNjgzTXh1WGUyVzJWcEI4Y21nc29la3lnSVp2V0tZ?=
 =?utf-8?B?OVVIYTdrRUpmRitGMDVGaEUwWjNQUENzREQwcWZSUWkrV3RIMVdSTFVTQmVX?=
 =?utf-8?B?ekxDWi85ZTg2dVJ1aTZxRVVLN0JaN3J3c2NiV0g5SlFlSXI0anEyQ24wQlNv?=
 =?utf-8?B?VXhOR1EydXhaRHhHTEg0bU53dzlBNVFYdEYvNGxJOStCRStqUzkxd1dTd3lp?=
 =?utf-8?B?eDJ2Q2h2YzVnRzFSKzZWcSs4UjN5dTNoYWkrckpQQ25TUVYvWkxWYTlhb3lx?=
 =?utf-8?Q?KS0BwvLJwm/Xt06E=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bc66c0-15c0-4a8a-d768-08df2170292c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:02:52.2629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de79bu9wjIlOiKbnrERjaO5VKxcDY5KF1nLMDd8CF1AplGaFP2N936wSGE0PGWU21jnK5v47iPUmO+v8LfaIVErqhp59PQQnPy6cuT4fNUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7371
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The microchip-icicle-kit machine was originally validated with an older
Hart Software Services (HSS) firmware stack. HSS v2024.06 cannot boot
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
changes, QEMU boots the HSS v2024.06 eNVM image, loads its U-Boot
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
* Keep SDHC and SDXC memory transfers at their fixed 512-byte block
  size, and advertise the Cadence controller's 64-bit system bus
  support.
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
* Booted HSS v2024.06, U-Boot, and Buildroot 2026.05 Linux to the login
  prompt using the functional-test image.

The functional test uses the processmission/qemu-machine-images release
v1.0.0 tarball:

https://github.com/processmission/qemu-machine-images/releases/download/
v1.0.0/riscv64-microchip-icicle-kit-v1.0.0.tar.zst

When restoring the HSS boot support, 3 potential bugs were identified in
the upstream HSS source codes that either blocks the DDR training from
succeed or traps in a multi-core race at the very beginning or after
a succesfully DDR training but stuck at OpenSBI/U-Boot hand-off. There
are already bug reports filed aginst various upstream projects.

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

Bin Meng (26):
  hw/riscv: pfsoc: Correct the L2LIM maximum mapped size
  hw/riscv: pfsoc: Map the L2 zero device window
  hw/misc: pfsoc: Support DDR training with newer HSS
  hw/misc: Add SiFive L2 cache controller model
  hw/riscv: pfsoc: Map the SiFive L2CC memory windows
  hw/riscv: sifive_u: Correct the L2LIM maximum mapped size
  hw/riscv: sifive_u: Use the shared SiFive L2 cache controller
  tests/qtest: Add SiFive L2 cache controller coverage
  hw/sd: sdhci: Run ADMA independently of MMIO
  hw/sd: sd: Keep high-capacity memory blocks at 512 bytes
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
 docs/system/riscv/microchip-icicle-kit.rst    | 163 +++++-
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
 hw/sd/sd.c                                    |  43 +-
 hw/sd/sdhci.c                                 | 143 ++++--
 tests/qtest/cadence-sdhci-test.c              | 282 +++++++++++
 tests/qtest/mchp_pfsoc_rtc_test.c             | 315 ++++++++++++
 tests/qtest/sifive_l2cc_test.c                | 306 +++++++++++
 hw/misc/Kconfig                               |   3 +
 hw/misc/meson.build                           |   1 +
 hw/riscv/Kconfig                              |   3 +
 hw/rtc/Kconfig                                |   3 +
 hw/rtc/meson.build                            |   1 +
 tests/functional/riscv64/meson.build          |   2 +
 .../riscv64/test_microchip_icicle_kit.py      |  56 ++
 tests/qtest/meson.build                       |   8 +
 32 files changed, 2643 insertions(+), 194 deletions(-)
 create mode 100644 include/hw/misc/sifive_l2cc.h
 create mode 100644 include/hw/rtc/mchp_pfsoc_rtc.h
 create mode 100644 hw/misc/sifive_l2cc.c
 create mode 100644 hw/rtc/mchp_pfsoc_rtc.c
 create mode 100644 tests/qtest/cadence-sdhci-test.c
 create mode 100644 tests/qtest/mchp_pfsoc_rtc_test.c
 create mode 100644 tests/qtest/sifive_l2cc_test.c
 create mode 100644 tests/functional/riscv64/test_microchip_icicle_kit.py

---
base-commit: 2a0ac9c8ac2d303ca515dc819043409aef18cab5
branch: icicle-kit

-- 
2.53.0


