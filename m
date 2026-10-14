Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01044CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnnj-0004fW-8i; Tue, 13 Oct 2026 21:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnne-0004Y4-Bi; Tue, 13 Oct 2026 21:28:58 -0400
Received: from mail-japanwestazon11022120.outbound.protection.outlook.com
 ([40.107.75.120] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnnb-0007NZ-Vp; Tue, 13 Oct 2026 21:28:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsLb2+/PiOaHlwJonLMWbpo2mSXIYjdCCcWm+7Kh859U3CXFQpIAYsP0R2GEILzeoQUXepvz9Mxg3g6PwhUdyI9Q3EfDOXuyJonj2oiBguJDStdn1+nLzdjjI7q8qH3AcelGY/ZI1QP6hemx1ZUCTqSCU5KJ8GGsvTxALRGJl+AdPaHI6uAHLld18jIfmK6Xd5Tc5PW6r83N7QIwuFaZxXvfN7iPPqk09kdA0FcujwOCE+20I4yAjeSIOn9Hm3F+vizCbkKZDTdAgoBBkfPNYM6tkHjc4AeDdsDpsDlHLhBUWM7XapjYZpC3ex6tLQDl3s+N+nTOWl/y7nON/KBcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG7q++xcslWm6NfhVDBrhjOgz4aKMTtNQqYrG7nNu3k=;
 b=xqUc6nlWSUn1+9yuarwptnwy33Ksjw3lG83LlrSySiqLM98zbuLXORXImZjVRoaqxyIhHBRfcldtFIvXeoWlttwMJ3iwbEJuFmY6MmVadg7ucPidmwIGdl2d3/vZNyXXnRjQudwr01ikDYwbg0FNKztYkSnb7rigNQBjjncEa2PblEh8vaIs1krvXF1+3hyzAsBqwTgKXkbMpxwx/mOh6fpKg0Aeq1YicOudIQ8oywhGHoOANm6OkZ4RdaG5jwo9q0s1WzuiDGoBSrWVhvWWkRbZA0ljG7nHRdwhqfzPbm4yv57PfjBRRXdSYRBm1wNgbZUMYtW3wdwej92GMMUTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG7q++xcslWm6NfhVDBrhjOgz4aKMTtNQqYrG7nNu3k=;
 b=YnGozsVBknln3/2604QFaHMMNxAnnx7TU9TTme9U2mm61obHqgkbvAjFWdSR8BBtV9yaYamJ7qJfs75nTlL3nZXDVBXusnB2cZIhOSIuVr/aebdViiT7hfBwibvd9W/bAbCVN/N3U4wTRv1FC66xTC5VoKV2vNo91JDrnEChlPBy/WQF5CVmKYIDHbFdbGd+4/x1pOQNM0ZfkuRI9KS3YmcUMPpb6Hu2eE/H4xsDmB+mt/wK0VRbP6YAhC06eMUMeWU39vS4vqYS22W2Pfg2L43L5dLvdf+e4DKvvDLsRcRzmOglo+BeuOcEEudFhm3KeBXlZGMEfFwa6yBmvh8fpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by OSQPR02MB7959.apcprd02.prod.outlook.com (2603:1096:604:297::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:23:44 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:23:44 +0000
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
Subject: [PATCH v4 00/27] hw/riscv: Restore Microchip PolarFire SoC Icicle Kit
 firmware boot
Date: Wed, 14 Oct 2026 09:22:40 +0800
Message-ID: <20261014012323.322790-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|OSQPR02MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: f507c7e5-9409-4715-925d-08df2991c9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|5023799004|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: S5mQVk1xm7pOdaFaNN8/Z67f+s2hAqnxe8vBAk9TiUThNYpNZfjZIPpv3AdqiOZBuyNqbun25oID3ce3fzBjSc3kOnaeW2Wo/ZjmzL0kQIb8dy+WGObMxQ5Lk7QpSy6YJZHkmmyQouh4ctuOwEJqw67NNS7sMsAJcvW6hPC/EKHafF2t8GA/TwLGsckbi2D3+G3fZHo0Sx3pmYAjeKcwkUJpDE3nTcQS6QBYpM92UGr9SeEcq+dHyPAILKawC4NZDeKc0FkdaMbA++qHqs0EeJ4Ptm2VKunpfPvCbCT8D7sAwBfBRIGf/mrRjGPbG6pHWv/Ey2gsCMu3YRavz8U2OeFjl5R+smEiNp15HPhW97cqUm3QaCJ/mCkEwPMhE5IoMETdbpSTgAoFEAwps5hNL1aiaqI+uPyXBXoCKWW9TA+0y24HV9/zYGUbn8ue5CtKHwOQPV5Jsnc0QymfvFGC64TZmtEIdUqZvdkt2whEoxGIOgRf+BF32wB7aaeKJdSNeDpJBBg6wmWcmnBwmlNNBO5I92AsidzuuKw4g8d+3O4ILVdJKOWJesHTaj20xvVQgjAfzkLHzYyVHVWus8sySYbFAPDUvtouhVz4woTJWKEV4jvLZAcH6aPIsjjGjP1yhRQlIVrtWPix6D+ST+L2Ra+MqmLQZUF39WBTDJ5T0jg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(5023799004)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUVEN25EVVZ1bE4xQmJRSEFpS1Jvb0Q4UFhCdXE5UWhOZnZUT1BHdzVISHpa?=
 =?utf-8?B?MHlobVNJdkR1OTVyYlJCL1JpMnZ3ZWxZQmtHVzNGNnkvS1E3M25tVm8rdGFD?=
 =?utf-8?B?YU1na0cvdFgvbk1NVnloaWlzdXU1SkF2eUJOeFo4UFJzcnBFOVhTeWJBYTJG?=
 =?utf-8?B?YnB6Wm5oaWdQbmRhUUdJUFhrTWpXRkdyTExNSUlBbkhOTXRncHhEOVFVa0t2?=
 =?utf-8?B?OFVsODA5YlJURGtRQ3lWZ3hDYWFVc3c5emViQ1pKQjZSS09pY2J5YTJoYlUy?=
 =?utf-8?B?Sno2TDdaT0NuUVp3NlF6cHFLd2ZaaC9Vd2VFTDVtQTc0NkpVMG9PbVlMMWw1?=
 =?utf-8?B?RGZLR1ZvUHhGbWxML0NhT24zMzJYaWF3dEJMTHRhQ2tEaWdVeXRyaGJqcnpL?=
 =?utf-8?B?UFJlVUxKMVlMYmpRWVM4cnMrb1BMamFrMnFDRkppNklkUVE1UXBrUmFvYjhv?=
 =?utf-8?B?M1lGZjVsVGdDSW9hb21ieGlCSFc5cTJQQUYzUmg5TjR5UXV4SEU5bUVsdGhh?=
 =?utf-8?B?TTFSK3h5RVJTOCsvR3BmcXRwcjBsWjlUSWU2VmdPelJ1ZEdBemlxcUtweDVy?=
 =?utf-8?B?YnUwcTQ3R1hRSkdaUFNMQk14QURES0F1R0RZTG9SaCt4aHRRWldhWDc5QXcy?=
 =?utf-8?B?S2dmM05CeXVCSnU0Y0xEOWtYMlJoSE9sVjlRZlpuZWY1WjRZdXlPekZmMkVp?=
 =?utf-8?B?UnpNcnc2VmJFSDRvR3VuSFFIOWRHUGZIMnJaNmRwYnZHbGxJV2RHWEZlU1cv?=
 =?utf-8?B?cXdEU0VZa0J2VFN2dkVEWWhyR3JFcFAxN1cwVFl0cndxQTM4NFlYZi9qSTlr?=
 =?utf-8?B?b1NwaFVuK1p6aTZiTnIzUHNORjhxU2dydTVnRnpGaFdIZVUvcHVYbXEzb3My?=
 =?utf-8?B?YWlTYldoaVA3eXplRUNrdXdNN2ZBZjhickV0azlhM2F6SWxqV2F2TlU1UWww?=
 =?utf-8?B?SnhWdWl4RktUZjUyZzdxWXVhR29Zd3Q3L3BOWUUySnhWY09BVGpyaTJqUXd5?=
 =?utf-8?B?Y3Z3NzI4OUhLbTlVOGdMdndSUTB5QkVPYjBtYnlpY2tSMXNGQ1ZrbHRwZTNU?=
 =?utf-8?B?WTIxMDBvQVJwTmJmdnRLVE5hWUN6SDZaSUgwL0diUFptQkpwTkRpV2NUNUEz?=
 =?utf-8?B?NUllS3pSYlBHbmUyRzFwUGtaWkxFa2lEL3NDVWZUc3NtUzhTbi8rajhGZ1Z5?=
 =?utf-8?B?Q0d6Qnl4cVRDVHNIYjI2S1J2a1ZVOXl0ZnBJTVdwdStjc20yeTZVMmFjQTIx?=
 =?utf-8?B?bk9UTUpncytwa21jeVFVdXQ4YUFVVGt5ajhlajF1bU43MkFRUzJwSU5EWU5Q?=
 =?utf-8?B?U3ZoUlpSbjRGUm1zZGhvcnRSamFWQm9sNjlzakxaQndqSS9NVURhL09zckNH?=
 =?utf-8?B?S0JubjZ1NU9ZZkltL2tYdlNzWXhuVkIvWGtuWmRDdUdrdHo0K0JHZGJIbXVW?=
 =?utf-8?B?Q2FQMmkwNUJpRnN3OXIwN0NReUpjVnZoNEFpM0xTUDRqM2szK3BDdDZpdU5l?=
 =?utf-8?B?b1VFQXBUTStpOEYyaDdCemdvaXd0ckZQMWtlN0E4c0grOTZuWXJ0UERiMllh?=
 =?utf-8?B?QnpYT085WTV0SWlKb2tCbHFuTnc4MFdMajVVYTVWYlNGUmh5VDRRN0lZTk5I?=
 =?utf-8?B?MTBZNGVrNGpaREo2M1dmMXRyT1RJbHc3TVRpeEJVV3ZnWDJWTzRtWVV0NzBw?=
 =?utf-8?B?RHVndTQwaU9Mam1Yam84OWdNUFIvaXNCYTZrekI1Q2p2TjZUUWJBQkJTWU1L?=
 =?utf-8?B?TUJHTmpaM0djYlJkMmlUU0lJOGZHZVVwWFV1bEJEbHVKVlovbWRVRDRqMkVn?=
 =?utf-8?B?Z21WVXRwWTc3UEVpdERtS1duQ2hadG9hQnEvMTJKK2kvY3lQMTNITTlyWDFk?=
 =?utf-8?B?UTM0TmVtY2o5SDdaVkRhbmJ5ZUlQNXlSWGNwQUV4L1N2MGxBRTlXZ2FPcExq?=
 =?utf-8?B?Q3lpT0tUT1BCdm4zZ0VXQ1lwbDBwRXI4VEoweE9MbTJNUTc4eUs0MlAza1JH?=
 =?utf-8?B?S0VHUFdPZDlNaFpqdXFSbVMwdmxnTHJiVFVVa3hyR1llUnRIMVc2a3dzSXhV?=
 =?utf-8?B?dm1VbnJERThhVmFzbXE4MjQ0WHV3M0ZkZmJaUUtJckd5dmdmc29vV2FmWW1V?=
 =?utf-8?B?Y1k4QkFoWi9DRnR2bUlxWng4MlpkU3ZtSkR3dXA0cElRUWdXREplZER0VnlK?=
 =?utf-8?B?OU52UzNObW9RTkgrbnE5U25hLzVEVThLVXl3Q1grTWhGMU1zcllTaHI3aWRD?=
 =?utf-8?B?d0pnS1lidC9SM1pZQTNZZTFzSCszVHBzRVpqaUlTVWcrbEFDSityckErQnlY?=
 =?utf-8?B?Nng1clNWNGJYOU95VCtvcVdtVjVNeGVyMmZZMC96YWNISCt2UlFmS3JxcTIy?=
 =?utf-8?Q?U/2+vHNskVHORWro=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f507c7e5-9409-4715-925d-08df2991c9c6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:23:44.4066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IMnKWjhTQdJoXA8ykQ+gZVCI53Kj9Blf6USmmEn1axI+/ORfH/n+YmL+6Lpq+5OftpaYFTNEJzNP7HsWAbaiPNLmq+EHBS7D+z7MVY5TuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7959
Received-SPF: pass client-ip=40.107.75.120;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
 hw/sd/sd.c                                    |  43 +-
 hw/sd/sdhci.c                                 | 146 +++---
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
 32 files changed, 2639 insertions(+), 200 deletions(-)
 create mode 100644 include/hw/misc/sifive_l2cc.h
 create mode 100644 include/hw/rtc/mchp_pfsoc_rtc.h
 create mode 100644 hw/misc/sifive_l2cc.c
 create mode 100644 hw/rtc/mchp_pfsoc_rtc.c
 create mode 100644 tests/qtest/cadence-sdhci-test.c
 create mode 100644 tests/qtest/mchp_pfsoc_rtc_test.c
 create mode 100644 tests/qtest/sifive_l2cc_test.c
 create mode 100755 tests/functional/riscv64/test_microchip_icicle_kit.py

---
base-commit: a1c27ca02bcfeea7deb6d4634c70d5b3b421a76d
branch: icicle-kit

-- 
2.53.0


