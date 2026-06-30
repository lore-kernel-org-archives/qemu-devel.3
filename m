Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF1DC44500
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYyY-0001yr-2d; Tue, 30 Jun 2026 09:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyW-0001yW-2W; Tue, 30 Jun 2026 09:58:08 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyT-0003om-NN; Tue, 30 Jun 2026 09:58:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i02G3m/urKCvxHD1LB+mgBBNZLBShCkycB/d7L+aoScFtWz5XHu5II/9njJl1S2ONLSAJ1sRV81FoMKcZxajagEJgeFqmDfSVEniXMte2VKWUpdiVyfSqW75qgqGjrq2M5qf16xepu7IOxbdxoz6gEkr2ecW3kENvAVxJlUZbptuQV7zfMP2/Xkn5sJC7qls1glEn6FlaXVLA68/iEI/qh0w7PaoMfg3mILBDRg9f4F7mrXkStr62syFCXR/mqxV9V7LjSewSLLzIbw7SdF4rY7ua3XfVw539fL6MrtLmSsUFOBGJcTI3md0ZUMSP3JMXknN+R/n0C5V7HgSJzJowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBK1Kmo+gi0n+THBppLY9O1YnOm/fUT9Y6rxGBcdq/I=;
 b=ugwXRcL3wSdFAQCHm/5yZ6cPFZ/HNjCJb80LBmfoXzZ0wmPkxx0HGRe1kN9L1Eyn1IR2rihoU8oz6MiFcDBRo5sp2iIQgzkdX3rkKT1Qog0/6mOmumL/KuijjFccuykZNOn2w+8eYDoKI4fC43OXJ57opMfxmV57bp5vyI1KljJQInsPh3mECDXCCe+Komdjo+gqHA11iz02VW25Y/qLKq0daleXRwuNsweqGgNV5vsR5r0HSCz4W6Q4xWTJMRTZ/EP76NpHoXi8J+PVLT+B167ZvuBy2SohytWAzvi2OTrIURFAh8/P1FXBt3i87/zVa/mxrJcb2b4zHWMU5K4Yzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBK1Kmo+gi0n+THBppLY9O1YnOm/fUT9Y6rxGBcdq/I=;
 b=bDbY5f1t9UKy5tYJ7fXRxFBLaZytEdIQNQRzdMQFtm2WDGpy4b9JAW6gv6yOAlkG7sf4JdTiL2cjeEowFxQk2r2UruKKVZNVR8W+pzJLLpjw2O44+2qyYx0fcmxEmBNBg5WJxb0daGB6ZcjqPjEH7YcLMqGaVeOl5tiNl9ckBbxXhzhhszUwSu9yumTG9wdvMPHqNL9ldFQoeys76WRaeVoeykweXm5zv98zbpt6ZeL0LB0bz+5V4OXhVC8DwSnNmxd9Jv+QES+GXm9LMiWEsx/8Ft9AIHmjPseK5Q95fBjB6kW6d8BYwn2byfg7dqCb6QjIknNurhnz3JVqORYNVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB8959.apcprd02.prod.outlook.com (2603:1096:405:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:57:56 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:57:53 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH 00/10] hw/{block,ssi}: Fix spi-nor flash dummy byte handling
Date: Tue, 30 Jun 2026 21:57:19 +0800
Message-Id: <20260630135729.466264-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8dd496-6d37-42e2-d31e-08ded6af919f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|34096008|23010399003|7416014|3023799007|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: y+IsV0XvBrmMNieGhhUcVLS+zux7jeOcYcvLSyDGM2lLc63bcSqcVAqDId57WuNq6axP51yFY773FiqHSpYb9xe4pnMbyT/wWUVl0A0XK4FZt/dDws43tv5+2TypYJPWgvZYH9fFsT38F3QWeYrf9HjqXco+GoMIbW0sQnTZnp1HENbwaOxwrSp+ffwwfPy3qL86pmmWRpYM+2MoHiCB+ZHgrCg9Eo5tPDnhDWAtjvRtdLXFEF/PmqU1FvtW8FgawBOeb3YHFpX9ebKKwdUlpGrEcqvCyPWdlG5dMl2NzzScJOy+ZWbDR9dcjovBmkqV316PgiXdNYym5fbU+JkrXzDaA+QkeMgMjsoLu4V9w53hpV3Froe9JjQ82IFCpMUDVdxkN8pEtkTosbxbRpBcQzvRPWsXZmobk+vAe3KlklHbW4i6+0lxR2rOJpOA+G8xcv2fN4sZm1ZiNPsQqHPeKMZ3sPG7NHpnaL426qrhqD6WorzJjrnCNsrcHkjYEwzvNxh4HV9a2ZagaEf0xFHfnvyf6kF8NqZ3yuwL2WGp7/1PHEPrDolBSOGlxrw513w/u/zDDTBUFPFSosP11Dz+ppDWK+2KPwC/Jjql2rQ/Mz9GXzbW9zJOqWLz8buvS6f8msgdtSGZAanpdxwCRSIDbJMTN2MNdG7iMXDngaCtW0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(34096008)(23010399003)(7416014)(3023799007)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3o0YjhrTE9hMlNnWWFDUE1vOXhwRFRqVG9nYUcvc0o5N09nKzBxT1cybFYz?=
 =?utf-8?B?SFZSaW1xLzdLTk5Ld2FGaG1xZFFCR1c3dUhtSlFFQ2VkcE5BS3RKamI1MTd5?=
 =?utf-8?B?NmhrNnBQbGNjalNrMGZ4R2FEUWdVUm11Z1lySlFrTzErd0xSNW82OXR1ZCtu?=
 =?utf-8?B?YUNDZ2NpY2NxY1czZzZkcEZBY1g3c0lYa1RSWEd2b2pNR3BBSHQ1blVzOHJr?=
 =?utf-8?B?bXg5OXEza0h2aWhmb1MvZlhkaUc2V3BRamdzVzh4ZzRhSEkrOW5GeGROckhQ?=
 =?utf-8?B?S1Q4a2ZvVGVHMFJJd2tzdHZqcnNVOTJ5eU1VSGNPMHl1enI4bEJqMnlsdUE1?=
 =?utf-8?B?ZlVUclN4OVZsRjFzL3phR1N6a2p2YXFTVUp6MHBDZzNmOWhVNllDYzduWnZL?=
 =?utf-8?B?ODhyazBaZHFoZldTNElraWx3WWoyTHVoZkFBbGtBRDF6T2FhQ2RGaTFGMjha?=
 =?utf-8?B?d1NIQ25nYTBMZGtkR09HL1ptaDJBOFJoMXBXUDZqMHhNazV6VDZQQXhaeFgv?=
 =?utf-8?B?WUpXWk5kSW1Od00wd3k5clErcDlSb0lOZUVoeFBNRnRwSGdxMjljQ0kwOWRv?=
 =?utf-8?B?eWNqbmlqTFBGV3dwM3Bod1JZVDQveEhDaWdBNVg4a3o1QXMwNkJiZ1l0cU1u?=
 =?utf-8?B?eWZCeGpHQTZVajdONWRPRkJnMnpRU3QvdDFxbjY2QlZ6R1JBSXdCQk1qWVM0?=
 =?utf-8?B?eVdYMjJ4UVJxL2JGaEpQZFBHU1VtSHBtcy9Ea3hjTkpZVHB5dHBFRnJuNU1u?=
 =?utf-8?B?dkkwMEhXMWJqczU2enZsbXNtL0xFbVl4WmtydHp0c2xPZG9sNFcwWFJvRGFW?=
 =?utf-8?B?MjAyQzdXeTNEakY0SkhHUlVMYld5MXhkVDVIWE5TcFlpUXpzMUtpMFBiRnhG?=
 =?utf-8?B?REs1K3hkYTRxTjVxZ1h4K25TN2x6VGhVeVJBNCtQZFF1dkhkWTY5UHptRU1I?=
 =?utf-8?B?Znc4c3VJVHVsREQ5YVkxY2VPUlVwblhNaWlQaFFIWnM3MFNIbmV5alhubFUr?=
 =?utf-8?B?bWtjZUlLcmxQeWcvRnlBVUhEcWVNSmFvekd6U3RvMHlHQWUwdjRhcU5VRnk3?=
 =?utf-8?B?VGF6RElrcDZwV2pEVXBlNmV4MzgvYlN2UndwSEUrYXhueFpXU3NXNklvS050?=
 =?utf-8?B?SUtKK3lzcEZWcWphbkxWS1JuczRGbHF3VFRwMERMc0xPRlk0OW9Oc08yOXcr?=
 =?utf-8?B?M0NWdVBPYlFOUFVhNVl4SGZ5UXNpcUlNVnZMQjlwVnQ2RTQxSkF0VnRNOFk5?=
 =?utf-8?B?bkxOMEFuVDFnMVZUQ2tmRWFBRVV2ZTFSMS9Iak1QWkM4ZXVRYmVLNFJyN1ZN?=
 =?utf-8?B?L3REUE9Bczc0QjhMREY1azJYVjIva1J2WnJibGhFUm5wb2YvOGgvVlpIU3BG?=
 =?utf-8?B?VWN2NmdFYlZLYUJHT09Yek54cEJqcFBEbVVIMEJLWUswWlJkQXArVFJjQXkz?=
 =?utf-8?B?OElnbU52d0ZjVEIvalZoTUVwYS85QkpYTVlITTRpdlpUV0gzelhHeisvRTkz?=
 =?utf-8?B?cXhnWVFHbWx3ZFhteWV5dXFjTUwvaDIvcW9ZTlRDRlRvcmJOdTNHV0VTWXda?=
 =?utf-8?B?Y2I5d1JaWSswTXRWRk12Z2UyU3NuQkFUWXdVamFKYnV5ZUppV1hFNzk0d21R?=
 =?utf-8?B?ZTN6TjYxWkNMMktONFk5K3ZRM2tmMEtDVnBPZDNGYjJHY3NVWHR0R3lYa3JC?=
 =?utf-8?B?QUpia3dqaEpyUFpkdWl2MWtXQUxNUDdrVEN6TUROTktMbGhSSzI4Q1lORUtY?=
 =?utf-8?B?anRnUUROK2ZUaVRXQnhuSTczam5HeU8vN0JTL1hGNlNNZkVNWmtGRFMzU0xx?=
 =?utf-8?B?bXlqV1dVK0ZsczJ1VUk0MTdSN1ZGL3kwUjBURzFNeW9TV1NzZEFRY21IOW5Z?=
 =?utf-8?B?b1dzam54d0RWUHpES3NWTmJrNWNmMi92SFdqS21lTyt4SzRYY01YNUlNTG5n?=
 =?utf-8?B?MUNidlVoNk5vc21tRWZUY2tRVEc0c1R5VGIyU0xjMHdQRjJBZ3hDUmc2K3RH?=
 =?utf-8?B?VmpjZnkxd2FvYTQxaXVlTHdmQ1pVaERpNUxaTVlFTkFKVVNJUjdIcDFLSUJS?=
 =?utf-8?B?ZEgrMEhCMHByTC9jQXZERDlXUkxXdTVYeGFKWWlGcVJ0QmtkZ0FnLzd5cngz?=
 =?utf-8?B?UG1jbUVHRTBFQXc3TzVsbXBuWmh1OWJOZ3VNRXE2MGFYT3p4eE5BOXZNc2FZ?=
 =?utf-8?B?TG1zTXhPRGxBTklHYkpvdG1ZMjkrSUdFemNwcFMrMUtXVlZTNWZicVVzU3VB?=
 =?utf-8?B?Um5qVU9QbzdydDlCU3BRc0tHNUhGZDJCS0xKcXVlNm5xSWdCeUloazFHamgz?=
 =?utf-8?B?U1l3aG14SWwweHM4TlUzNFQveHRzWU1ZalFleTh1MmFLMGlSWkt1dzhVTzA0?=
 =?utf-8?Q?zwH4GspEglNiwerU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8dd496-6d37-42e2-d31e-08ded6af919f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:57:52.5338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de/msWd5Y3UtgPyDeC+Rt1Qa6H9b6EsLZ1u9vqIcs0n2oYYLU1LPMsgFsL3ZjholqcyrYGA6N3xepbj9WDEP6uUfDpGoBwriOYthYn8qozw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8959
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


This series fixes dummy-cycle accounting for SPI NOR fast-read
operations across the m25p80 flash model and several SSI controller
models.

The root problem is that the affected code paths mixed two different
units. Flash datasheets and controller registers often describe
fast-read dummy phases in clock cycles, while the SSI bus interface used
by these models transfers byte-sized words to the flash. As a result,
some paths treated cycle counts as byte counts directly, and other paths
compensated in controller-specific ways that duplicated flash command
semantics.

The first four patches fix the flash side. They make m25p80 keep
`needed_bytes` as a byte count and convert manufacturer-specific
dummy-cycle requirements to dummy byte transfers for Winbond,
Numonyx/Micron, Macronix, and Spansion flashes. The Numonyx/Micron
change also handles the standard-mode case where the dummy phase follows
the address bus width for output fast-read commands.

The next patches fix controller-generated dummy phases. NPCM7xx FIU
and Xilinx ZynqMP GQSPI now convert programmed dummy-cycle fields to
SSI byte transfers using the bus width selected for the dummy phase.
The ASPEED SMC direct-read path is updated the same way. The two ASPEED
reverts then remove older workarounds that either hard-coded FAST_READ_4
dummy behavior or snooped manual user-mode SPI streams to inject extra
dummy cycles. With m25p80 accounting fixed, user-mode byte streams
should be forwarded as supplied by the guest.

The final patch documents the intended ownership boundary: flash models
own command semantics and dummy-byte consumption, while controller
models own hardware-generated dummy phases and cycle-to-byte conversion.

Some background:

While recently working on some device modeling, I hit this issue
again. I then realized that I had sent a fix series for it more than
five years ago, but it never made it upstream.

This series picks up that old work, refreshes it against the current
tree, and fixes several issues in the SPI controller models. The original
series is available at [1]. I have tried to verify all the SPI controller
changes by booting real-world guest software to ensure the change does
not break anything.

[1] https://lore.kernel.org/qemu-devel/20210114150902.11515-1-bmeng.cn@gmail.com/


Bin Meng (10):
  hw/block: m25p80: Fix dummy byte handling for Winbond flash
  hw/block: m25p80: Fix dummy byte handling for Numonyx/Micron flash
  hw/block: m25p80: Fix dummy byte handling for Macronix flash
  hw/block: m25p80: Fix dummy byte handling for Spansion flash
  hw/ssi: npcm7xx_fiu: Correct the dummy cycle emulation logic
  hw/ssi: xilinx_spips: Fix dummy phase handling
  hw/ssi: aspeed_smc: Fix direct-read dummy bytes
  Revert "aspeed/smc: Fix number of dummy cycles for FAST_READ_4
    command"
  Revert "aspeed/smc: snoop SPI transfers to fake dummy cycles"
  docs/devel: Document SSI dummy-cycle ownership

 docs/devel/index-internals.rst |   1 +
 docs/devel/ssi.rst             | 132 +++++++++++++++++++++++++++++
 include/hw/ssi/aspeed_smc.h    |   2 -
 include/hw/ssi/xilinx_spips.h  |   2 +-
 hw/block/m25p80.c              | 146 ++++++++++++++++++++++-----------
 hw/ssi/aspeed_smc.c            | 135 ++++--------------------------
 hw/ssi/npcm7xx_fiu.c           |  25 ++----
 hw/ssi/xilinx_spips.c          | 120 +++++++++++++++++++--------
 hw/ssi/trace-events            |   1 -
 9 files changed, 345 insertions(+), 219 deletions(-)
 create mode 100644 docs/devel/ssi.rst

-- 
2.34.1


