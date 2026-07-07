Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313C4C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Gg-0003gW-4z; Tue, 07 Jul 2026 04:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Ge-0003g8-Rs; Tue, 07 Jul 2026 04:35:00 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gc-0007zQ-N9; Tue, 07 Jul 2026 04:35:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6Oq6mSW1kDdipvW6bRNFAVGg+ihMNbGj4uzY5Gmd2O4BN0r4Xw8CneTdH9i2kPfHiqlk7ZPrfVmBPUyLwYW+YpJJiXZyB8Jlxq6KaWMg+WawLXw3Bs7GV+9AV+y0+F07OyRVwAjSwD/WyvDHxwe+25YihYo7goJHIdsXc/HJg+vex39IpNnANXGcyNTKhbnxgsmM5L3KrTFg3uLaepAqRqQd8MyKrK3682yfZNdYiCo2VhtsFSI6025sAWvVXM43rpTzkOtqMERGowuBccCtYHX5gh5nRBdcBb03/GJwwodCeihOnvVcAoMh2i2QCL/gjRGoXCPzDIa5EzGTGbXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jqjXNd9EP5faNlm5KnE0C4FK0vbcqJp74+zoED+jhs=;
 b=lCXpMbowG9p9iEDcsL5MdZCOFOksJvSPzvgNCPLv6T8kd+kqBQunTkEq8h0MS7J1RC2EZdI8/8JMl1xgvQA9NnljgBp2siJVlEWO7o4uSUsbgocET+8mZ+zQ/YuHJRN55e5IOdWMkms2JDPF4K69GbiQi5d/TSSHUOWFnTp71JfIRm8lCRbRrXjxz2tcA8alhUkkKRY+UytxA0dYKEsl/OkOGCPLSIQI2bE1UT3xq4wNPYbM5lQJ4RyvncgSr3CQRReWRxSH8soEYVs39DAs4c1q0BWrMggBOI+8tWFV5MHJlEGZXXSeKG18++saiXUUQZeIA2xO89+GdA3f3bf7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jqjXNd9EP5faNlm5KnE0C4FK0vbcqJp74+zoED+jhs=;
 b=AW9xNs8kSs57nssgY1FGXe60CwVs9fAq427avVDikVEGw6TTvtKudQVNn6GROn8U+Rno1TorOzrE70QBnERBLUbkPkLPMe7mG+jEk30XN1VBFoJqgR5keP7xBK5LHPkP2Z2lgOV/4w+9wGYTslii+wPgrxfahuP6tlXaMM/19lV3G4ZlFe+zEAYVWqKY8d7D76KXlUWQ2tw9decFtdqjD0WnGAiJgh0Q0Ya97ZLUVa/CAcPIQiAr6kz2wN/oX1aW+FN3xKg53IGc/nRUai6M1B03bsi9x3DId+chmm8X/RBcWqroIgUY9sV03BZ5d88zN9sOfHeXaSkLUnN5HcthRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB5558.apcprd02.prod.outlook.com (2603:1096:101:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 08:34:51 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:34:50 +0000
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
Subject: [PATCH v2 00/10] hw/{block,
 ssi}: Fix spi-nor flash dummy byte handling
Date: Tue,  7 Jul 2026 16:34:19 +0800
Message-ID: <20260707083431.219671-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0106.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::6) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad237cb-8470-4bda-fd76-08dedc029c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|366016|376014|7416014|1800799024|23010399003|3023799007|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6Ex0NmaJ5+gj7VSTlKChD7vDC37YGqPPZ4+P2RsfcagD0EHmjoKvX+Oc7vOILEy0P/etfEmvaehV8Cqk35SI6aWQPTHvokMAAlMTDUN9FofU5Rjjrn8UpcMCUJKn4iHzYVp8+riP2iviLtrLucFHpK3utnB3lqmE1O9Gqyun3nv1e6CdwTtIQM0GG9copUdAcAwRNn3HbcFAvmqozldPHHv1eOzmNDJRl1V9r/k2JFi0QCsoTOA/Oo2TapDL67b80jY5QBBXOj1JbJGTm+AnH6R54doArwYebSQSwh/IW49vW78lulwIiQFHKh2Mp+SiNbYH/ImoVCpJ1CUTjGaNlB8u8REbCcL5sFRp0DX+pGJXSEXdYak2hglPt69z87j9tgqhH/inTUo5GwaScsLAtm5OpHsBEhYNJg47g5Dmx17jw6wIrW6JR3CTQwFeR5VGNZKy0isrPQsqiBxjKLJ2d25NBPF2XUgPXwK4fKDDlGY7leDnMx4dFUtPARGnYqI2J5i8u3iOdjv13n3gOHSK0MQkoI2E055bxxk2CUwwLYs4j4/pKYjFqiVqHwu6xbU144jliOUcmmQylZcTvYGNBmnPQpyCD7oJ6rw6Ua3qyT2C/MRKB5VOWNprTl3ddlLoe6G2N0B6o1V/IlKNtO137fOACAUJEWp3ywE6qCmmcOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(366016)(376014)(7416014)(1800799024)(23010399003)(3023799007)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHByWW1hbFd6TW16WUtIY3RPSU1ZOWVIOU5xaUVNWEN5RU1FdlQ5WGVKcW5J?=
 =?utf-8?B?anZtZWt0ZFE5MTFoSjlVL0I5NVg2a1NCOXgxU3VnTzROUWRNcEQzeGE5aXdL?=
 =?utf-8?B?YWE0MFlSZ3hhWE9XRU9lVmxkeXp2ZnNXZUpwWFdZS0VFVGVXYVBFZGE5S05t?=
 =?utf-8?B?OTJGUTlDcTBENWpYdDRaNWNpU3dRcklnRERsWDV2MHpHZmpnV2hQazJ5UHZH?=
 =?utf-8?B?V21JbFA0QUtUVXB5VTRxUWEwTjBoTDRVWUxINW80dTZUeFBIdExhSXgvVDNV?=
 =?utf-8?B?R2JVd2ZvWCtNdDZKSmxGOWxhK1B2b2xUY0lIOUlXaUY1TmdxWWhsSFd2WXRy?=
 =?utf-8?B?eGVvTEk0WElpWWN5N1ltb3dhTCtqVnFWdjdRRXN4ZXBkREdtUGdDL0xWQk1M?=
 =?utf-8?B?TnI5Zm91Y2Nua1ZUSC9lSEp2NlY2SXZHTjVodnhxRGE3d2N0VXl3RWZyMDN4?=
 =?utf-8?B?cnkxNTNnMTFlVTVSRENuWVgvUW9KbWlTbzBjQnViSHBKWFlLSmtIMXlCYnlO?=
 =?utf-8?B?WlJhT3NrR1AwRlFUelFwS0xHNnR0eXZodldIeFBmc2JnNWsyM3U2RXFlanNw?=
 =?utf-8?B?YjY0OGRsT2tnQ0RXSS94dkJsZXlXVGNDdFV5U2hvNUR3Yk9SOHkzSlM2NHJQ?=
 =?utf-8?B?a0ZwRTY4WHZQL2NHRzZvN0R0NVljR2pSYzhqeWlSVWxVZDVLVFBBL3AvNERv?=
 =?utf-8?B?N1JGTC9OSEg5R0FwSnlFMElRUDZ1djQ2SzYwYThoM2tpdTRvd0VEQW9VbDMv?=
 =?utf-8?B?dytGWTJMZ2s2NjJjNGRXVGV2cmZpZEVMOUptM3I3QW82b0JWaU90UEFueUt6?=
 =?utf-8?B?UGp5MThoR1VFK0M4T09XYVlhaTkrdG40VDFnM3phODNKNzdScmk0aVAwNkQ3?=
 =?utf-8?B?UzBIOGNhSEt6Vnc3MEFqUFpOMzdma0N0L2pIeGZTU1VaVk1mZGhUV1BYd2Ji?=
 =?utf-8?B?SFNsNE1JSHg1VklTRm1MejJVcXdMZUxic1orYlI0d2w4c2R6WXUydDV1Zm9B?=
 =?utf-8?B?NTk1TEdLaXJURzVIYzRZVzJuMCtXSHRTSnUzajJUUEFoUU42Ujk5azRLYStK?=
 =?utf-8?B?dVVuUGtmQ3QyY3FKdUI2bjZUT3hpWTExWlMybGhmanYvaWVCWDZhcmZ2Qjgr?=
 =?utf-8?B?a3dpbGxVZG9YQ3g0ZDhxOVNmK3NBY1JLd21iTzk5OWNDMGU5UURPcHd2UlV5?=
 =?utf-8?B?TCs2bnQ5cU9HcjN0dlRRMFdtOW92eVdVWm02bSt2bXhVV1JncDBJZ1hjMXMv?=
 =?utf-8?B?MHJKeHI1OXlaRU5abHNRQTV3M2ptbjIvV0ppN1BlNVVWVE1GeW8wWFUybkR0?=
 =?utf-8?B?Q1BtSzcySTZJbWRFV1Rwb1NLbVVaMy9RNjNLcTFVYkZoR2xRWG4weHN2VXFF?=
 =?utf-8?B?ODRRRDYrbTMzRDgwUVh0S2VyaWVGTDFRbnNlWFhnQnJscjlQbkk3MnBxbGMv?=
 =?utf-8?B?czZmUlJhejZNTWF5MVBlTzEyd0VzOVRESkJBdmdBUmh5cnV3UXZsSlJPdkU1?=
 =?utf-8?B?b1JLZ0JHNENnVTJScms1OXpmcXMwUzRtYlhlVWNQZWNxVXhlby9lekIwR1ZX?=
 =?utf-8?B?T1lmUzU3emdQTE5pT2g4cGVqWnk4OENRR25EdVJ5bk5heTRtMHZZMGRaQTBL?=
 =?utf-8?B?QWwvRlA5VldXbDFLdFV1Zi82dzBCV2QrSUlVOXMwanN2VGpERjdlMDkyRkZt?=
 =?utf-8?B?VC9wLzFvbytRM3c1YmsxZ1I2YUdYOXlmdTUzOFZUbEVaWCtMS2dvdzdFZDVG?=
 =?utf-8?B?UlQvUFo0dU5TSWdtQ2xnVFUxVkc1ZVZEc1daWlcrY3dkQ3FkaDVRaEsxTk5V?=
 =?utf-8?B?dkdXVytvMFJOQW85S0E5WCtTMGZJdGF3bGhsNzJNVXVCYzgwd1J3ZjVRMjVW?=
 =?utf-8?B?S3A5MlMyR2QwYkhJVkRTTjY0Tm1KeDlrQ1hVYWpFSVRYQ3BVYnJxSUtpcGor?=
 =?utf-8?B?SkU3VitoNnpoNFJ3SVU5VkV6RGZFeE01S2pUYXg0UzArUWdQb0NqbStoUDl5?=
 =?utf-8?B?VUo1NHppeDg0N2JBaW5nWFZTVi9aMy9BK3dHbkxuQ1htZkZaWCtuWDFBQVZY?=
 =?utf-8?B?YkFWL2N6ZkRja0oxM0NYelZESjkydTZIdjIrQlltaC9sV3oxUTZDUHZQdmgv?=
 =?utf-8?B?RnVBNUZLWVR5TUxQWTJTQlRoa2NLVzVlSExFTXpxWVpmQmphTnFxbGdYazhp?=
 =?utf-8?B?MG12SzIwU0E5cnhHZ0xwV1QxVFBmOHpZRmxFOERibEZERFh3ZEcwOFRXOXM1?=
 =?utf-8?B?Y2lOMjFqWkpTeUpiWTk5djdYbEtrM3NjYnFSbm1JcGI0eURMa3VvSU1ZcGJY?=
 =?utf-8?B?NDY5emtlRFRFUlgxSVkwdHQ0a0xCWHFON2JOSFFOU0lxYlgwY0FoMG5Na0Yz?=
 =?utf-8?Q?fRcKjyCU1oJWp1f4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad237cb-8470-4bda-fd76-08dedc029c15
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:34:50.3303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHMU3XB7fvtEBqXd2iw6S6+AdyT9sv7lhtMf2dqVO9CmvKwXyxvJb5msmPYU57nSgzfUrG+L586sTBgo3H0cMKcp/wUtvFUEmRHUZspbpJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5558
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
Reply-to:  Bin Meng <bin.meng@processmission.com>
From:  Bin Meng via qemu development <qemu-devel@nongnu.org>
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

Changes in v2:
- correct the typo in the commit message: instrunction => instruction
- correct the typo in the commit message: genenic => generic
- change numonyx_extract_cfg_num_dummies() to numonyx_extract_cfg_dummy_bytes()
  to avoid confusion
- change macronix_extract_cfg_num_dummies() to macronix_extract_cfg_dummy_bytes()
  to avoid confusion
- change spansion_extract_cfg_num_dummies() to spansion_extract_cfg_dummy_bytes()
  to avoid confusion
- use assert() when the dummy bit count is not byte-aligned

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
 docs/devel/ssi.rst             | 132 ++++++++++++++++++++++++++++
 hw/block/m25p80.c              | 154 +++++++++++++++++++++------------
 hw/ssi/aspeed_smc.c            | 135 ++++-------------------------
 hw/ssi/npcm7xx_fiu.c           |  25 ++----
 hw/ssi/trace-events            |   1 -
 hw/ssi/xilinx_spips.c          | 122 +++++++++++++++++++-------
 include/hw/ssi/aspeed_smc.h    |   2 -
 include/hw/ssi/xilinx_spips.h  |   2 +-
 9 files changed, 348 insertions(+), 226 deletions(-)
 create mode 100644 docs/devel/ssi.rst

---
base-commit: 94826ec1370328375c3b6d1e80fdc94c8f46c348
branch: m25p80-v2

-- 
2.53.0


