Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287D0606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLhn-0003nU-18; Fri, 23 Oct 2026 16:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLhf-0003n1-No
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:17:27 -0400
Received: from mail-japanwestazon11022091.outbound.protection.outlook.com
 ([40.107.75.91] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLhd-0007EA-5q
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:17:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiqTNbSlhiW9Q1ZYFuf6rg+qyFXHZ9VlSEH3BxbmtCeuy883ANnnKsYHO2BpEXPVBl5/2SVEtlpdsWXquvH/Fuc+vgj1l13dmhVngwuiW8iFPcAPUrDiffQQg28GgRCnxPpyen5Uv0fYtpFAA94WpdF24oV1qt7KQIL/goZLcE7fHX7SXtjMp2VpAZpWN+GF3msGiYaFXNzIyKyrRZLnkuLO9iUO5rwAd4TkE67uL+j1HPiQxGLKqFtJyYMyJKU14y4bndXSthI4nUMiTnl6wYxEiGiW4jA4Wfrr4dH+9wwSlOas4BdaCZ98J6ppYS+C9Q9ZRL61fjOJnv1Nc2BEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXdzrt4v7RPfy1vFHh55T+fve/gLHDTnGU7V9/K43Ok=;
 b=zNbITFP9JJZCwekG7zFcJw4yHzdcfkMZ7UhlCQKv0Pc5TulwhvWDh+c9vX3uFS4XoF3NYWuZMtuLVM8I/j0repP3Nb//n0LrlAh4yK0lhnRYmg+y36mh2kjHSs94LyEO9vpGwBZ9z2TuXQlVwOp3p/YUnbjmjBxTyzQH1H0FTjuyTsP9pyzFV8waMGZsBUYhX/bkezg1vnIUAeT0G0td/JeHdEGb1moTqS+LU9INd9ogJ92Sv2OiNRVinQ90AGDQFw1URMUxzRujzMFlkRKPdApvz+wXFn+BxvLlwVYGOFXTTj/H2LNKrgwVToKRUnSO2rfhffgyF8TawqSb6eFOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SE3PR06MB9019.apcprd06.prod.outlook.com (2603:1096:101:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Fri, 23 Oct
 2026 20:12:16 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%4]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 20:12:16 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Subject: [PATCH v2 0/9] tricore: MPU support, ASCLIN/STM/SCU models and
 TC397 TriBoard
Date: Sat, 24 Oct 2026 01:41:54 +0530
Message-Id: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIq/22oC/5WOQQ6CMBREr0K69htaLBFX3sOwKOUj31BK2tKgh
 Ltb8AQuXzLzZlbm0RF6dstW5jCSJzsmEKeM6V6NTwRqEzORizKXBYcWI1C3QHCkrUOYJx8cKgM
 OG+URDI1k1ADIr50s24vgqmTJNjnsaDmWHvWP/dy8UIddvyd68sG693El8j33/2rkkAPXRZVaK
 LGS94HG2dDnrK1h9bZtX8j3okHyAAAA
X-Change-ID: 20260531-dev-ifx-tricore-upstream-rebase-minimal-e18f56d421a6
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Saravanan Sekar <saravanan@linumiz.com>, 
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>, 
 Christoph Seitz <christoph.seitz@infineon.com>, 
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, 
 David Brenken <david.brenken@efs-auto.de>, 
 Andreas Konopik <andreas.konopik@efs-auto.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792786334; l=4466;
 i=parthiban@linumiz.com; s=20241125; h=from:subject:message-id;
 bh=7PoE8KYJVMhYLONjJZQpc1waC58IJ4Q8YO2TkmuiuaU=;
 b=LziYpk47arhzUN8iZ057ifZHBL2ZOjbMoesbT17FQGHZ50XsdVbb8fNAQfKdyEymd+5WvzaCB
 46hw6ja0c7ZC0TV1rdOIVcLMKgIyoSbor8wha/wtsPDsdfFL20Dki9V
X-Developer-Key: i=parthiban@linumiz.com; a=ed25519;
 pk=PrcMZ/nwnHbeXNFUFUS833wF3DAX4hziDHEbBp1eNb8=
X-ClientProxiedBy: MA5P287CA0172.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::16) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SE3PR06MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 469d8a07-0171-4824-653a-08df3141eed9
X-LD-Processed: 808466aa-232a-41f4-ac23-289e3a6840d4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|23010399003|376014|38350700014|261022115727099003|261022113327099003|261021123027099003|261021130227099003|261021135927099003|261009223027099003|261021121427099003|10067099003|56012099006|18002099003|6133799003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: NciemLriEUHFh6ZKS2t6TXIglOT60PQ5nSAV9i+6Z9LueA35I4Pzqnv17Pr192av+Pb7EQAEVDcJVGSCEvm3QEN7iYkOjAg0vwMStIk7OtzimccUBBagjz9J5UhlLeXhTFrXOF17Xi2rVWGbYSxLvHUnTRk8jChScUu6VffwqT2/r8Nji0lA49RHMYD6i72d57rl3O4LQRHE07Jv6pEgH6AeJ2mNE1Vp3hVjZqcu+t8prFbgakPf8nxherNYvsJo3jyemYDQGoIxro2w0CATPQXGmLHSRB0iRurV/ckO79Uczuu6quIrE5uIr7K5ZXlM74BPdbEdzpt9SFtbIRVRls2w9mGK53Ush8Q7VEDLfD7WPIJ0fWaEj2FQRgJbolgjoqPz/dJ5eY5f7O4uf1QwBUG3B+e1YIZXnNAcgW86BFWrp1Dear7btPct9vMT3K5srQgI2+4FPrWccHvlZVfjCpGtnpUoYS0InAav+PMmnDs73mwqG+yGrTnA6fpsFWVenNv65BTrvrynsYpNhycGNZf5LNQDD/Va0nQYrmCujKlwICMjHW4wMV87xe809nhoRRPRxyPZ7Q56eaJRHtSlkAGVVuGYqAManvfEtsstRgqAw0ghIiaxt7nfsMe6Zo1Ekgcw9K7UXXFzHw1UTuLK8mCheK2CLH98116+QHFo2tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(23010399003)(376014)(38350700014)(261022115727099003)(261022113327099003)(261021123027099003)(261021130227099003)(261021135927099003)(261009223027099003)(261021121427099003)(10067099003)(56012099006)(18002099003)(6133799003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dno1L1lxY0JLZ2gyNkh6NzkyY3c3ZmFBcHZBV0tXQjJhSEdZZlQ1MzRXeWZh?=
 =?utf-8?B?aXpVNGtjRVM2Z01qQVVsTFlZRjl2Qit2VE02djlvRmFiVXNSRzRpaG9JbjR3?=
 =?utf-8?B?NDZDUTFZOWl2a09tWHRUY1FGTmt5REFvT1R0czFnRDlXcVY4bVRIemMvVUVu?=
 =?utf-8?B?VlBaNXBZVXdFQlBCR21qV2NFWjJuSllabzRnNG82LzdnbE85ZC9ZR08ySGlW?=
 =?utf-8?B?dzVZUXBRelBZekJwOFFqeGsxaVdEYmZTM2tHV0lqTWdBdUJMc25FV3pvYkY3?=
 =?utf-8?B?TmcxaGwxTDJKWVNIQU00aVF4aEVCdi9aZng2aUxXMGxLK0E2OXJuR3NlU0Zm?=
 =?utf-8?B?KysyaG9EekxTUDY0cFA4RHE1elAvZHcvUUFsamxsRHN6SXpyLzBwNXNFRTlE?=
 =?utf-8?B?Tmpuc28vYm9IM2wvOXFlYjRlWGFSTkpob2c5OWdaYzRlcFNxd1hueFJYT1Jh?=
 =?utf-8?B?NHRWc0Vpelo4OS93blZOdkpBMzlmRlQ3NWoyZzN0M3RLd2EycndvNnNCc1FZ?=
 =?utf-8?B?SDdoWTMrVSt2dEx1a0pxcVZYVmwySkwwRkVQTVNYTHVUTTlIZzYwWGRmdFBX?=
 =?utf-8?B?bWMvMHp5YnRnc3RiaVRKL29FcHhVU0xDeDVPblVQQ21tQUNJQWRFTFZ6clZx?=
 =?utf-8?B?K0gxREl4UkVZLzgvY2VIUU9NSTgwV2xSbkpabU5SV0l5V2Z2RkdmYnhOUmRt?=
 =?utf-8?B?eUVHUllNVGhINXd5aDVrTXVReFN2UGU0bkZvZXRzTkdMalBrZnRHTmMwUUZR?=
 =?utf-8?B?UnNJZVFQdHdMRzFLSEkvNEd4eVRmaFE1MDdQSzZ5TEJyM29vUDVFYjhDbWlE?=
 =?utf-8?B?SXFkUkpTeDJndE1GcGFHNlNxeWhMNlVOcWNnK1FMQWdGckZraWozMFhRQ1lp?=
 =?utf-8?B?YVJwU0RXMU9MRDc3bGZDbkdqWFAwV2N4TzMrMmJPVEl0ekVpVFFkZDRPUElW?=
 =?utf-8?B?U2xxVDFBRUxRK2d3cnUzbzA2dnY1SUZKOVI4ZkJMSUtCcnp6cDRCRk9tTmVv?=
 =?utf-8?B?VXlsSXBRNEpTRDJLajFCL0lRaTFjSUhxYTdrcWNXaG5hZXhkbDQ4b1lUaXdJ?=
 =?utf-8?B?Z0s0eWpsZmxyT0pkM0VLV2JaUGFwS1dNTkZLZWprNFVFaE4xV2MybUlLZk5F?=
 =?utf-8?B?S1AvOWJKSFRHcU81QmFMbk9JTVY2Q1NaOHdwTVJuMnNtMkpNaGdGeThGK2s1?=
 =?utf-8?B?MlA5NzFzU2tlSFEzRytXamxsc0VKYlpYTjZoQWJKcjU1enI1SXozV0JPK3JT?=
 =?utf-8?B?VWducFFQT0d2K3ZhUUYxVnlQa1U0RUNzMUhHcGYycERBbERmdTZFM0J2Y1RZ?=
 =?utf-8?B?NGJBTVN3Y0V5cjVHY3FiMnJvUUhmaXhMbHZQUWFFRVpwdXkwR3UzdUVxQ3Ru?=
 =?utf-8?B?a0Zka08vR3ZBTmFNbEwzci9lL0hiTEFZQ1l4OXdlUXhjVjJnQjUyVkNESno5?=
 =?utf-8?B?S3l1MEIvclRPVkRNVFlNelRKekI4T1JpbThPRWlEUFNtZ0lpNmpHbkt5Z250?=
 =?utf-8?B?aVlNVlBOaUlaN3RFZWsxMTA4ZXhIWHR3WWY5YkU2cndQa3ErYjA0cEs4Umhn?=
 =?utf-8?B?N080VXNCV2tmWkdCSHk1MWR6VzJkT2VLRHhEV0VrMHFoc1o2K2NQdUFBVmJY?=
 =?utf-8?B?RVdvQUdyN3FUenBrS1pWc3Z5OS9xdnNSa0EybnRPMUhaK3liSmpUcThUVDlI?=
 =?utf-8?B?MXVYRVZHRHpmVFJKcmhFMGdNYjhVYUY3aEliTHBDUFlVZ3lJVUs4Sy91NU80?=
 =?utf-8?B?ektsS2l4bEI5WmorWVZycjdOUGVlYTk1WU4wQmFjYmtYUVhvRkFobTZFVjlF?=
 =?utf-8?B?Nmp4LzZiK1dFaTBmR0tsL1lJaUNOTVdEbURhWC81UlJNV0dyQzhaQ2NhQWV4?=
 =?utf-8?B?YktwRzRWVE81eXlaVzRzUmw0S3piZjNtZVAzNzdETUhCc2JTM2pHL2c5T1pO?=
 =?utf-8?B?TTIyM3ZNa1d3MXZ6SSt1ZlpKdjNDeU9pQjZoQ2VaNStXNW5Hdmx6dzJRdjNj?=
 =?utf-8?B?Umc1MnpRSXh3cnpzU3NpK3R4RDNEWXZiRENDZjZNNVRTb2tVSENSZTBWNzNX?=
 =?utf-8?B?cURQSjBqSnhzbFhvZERjaTBvVDRhVzFXQlhYRERlckZlNnF2dFJXYk1uT0or?=
 =?utf-8?B?S2pUeEQzbHkyZDhyZyt0dGdPbFo1YTg0OE1SL25Fb1JyRlJJYXFoOGowWkVD?=
 =?utf-8?B?MXQvek93NTVBUURCcE9vNnZWaTUzNnRZWWxTcURlSUwrZlU4WXExaVg2eDk3?=
 =?utf-8?B?Y2FFS1YzZlI3MFZxWGF1enRBbjZjc3JZdXdVdUdwd1VqbHJ6TXVRaWZVVHVr?=
 =?utf-8?B?MnRBWmhVMGl0cnAvTnN3YWdEb0RXTWFONldPR1JuVXFQMUsvQ0RYZz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469d8a07-0171-4824-653a-08df3141eed9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:12:16.0884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n9ivw9RhEUazkaDVMVtiQ5n88RtjffuF8zhTUvlh9CHCKmcyH5JocP5gxMSC5QSiiqid8G9E5OEvPvEH+3WxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB9019
Received-SPF: pass client-ip=40.107.75.91; envelope-from=parthiban@linumiz.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Following are the list of changes this series adds,
- Fix the MPU (was a no-op stub).
- Add models for ASCLIN UART, STM timer (system timer) and SCU
for the clock handling.
- Retain TC27x support and use the newly added models.
- Add support for TC39x SoC and triboard KIT_AURIX_TC397_TRB machine
- Interrupt router (IR) is dropped in v2. See changelog for more details.

The peripheral device models originate from the EFS-OpenSource
QEMU fork [1], targeting QEMU 9.x.  This series ports them to
the current QEMU master baseline with API fixes and adds TC3x
register support needed for Zephyr RTOS boot.

Changes from the EFS baseline:
- Ported to QEMU 11 APIs (resettable phases, const class_init,
  CharFrontend, hw/core/sysbus.h, DEVICE_LITTLE_ENDIAN, etc.)
- SCU: added PLL locked status for Zephyr clock driver
- STM: switched to monotonic counter for deterministic timing
- ASCLIN and SCU accept 8/16/32-bit accesses (iLLD uses byte access).

Interrupt delivery and TC1.8 ISA will follow in separate series.

Single-core emulation only (CPU0). Tested with Aurix Development
Studio (ADS) blinky, Zephyr hello_world and small bare-metal tests.
Existing TCG tests pass.

The downstream release with TC4x and interrupt support is
maintained at [2].

[1] https://github.com/EFS-OpenSource/qemu-tricore-patches
[2] https://gitlab.com/linumiz/infineon/release/qemu-aurix

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
Changes in v2:
- rebased to current master.
- dropped interrupt router, which will be sent as separate series.
- addressed review comments related to empty function in UART, moved
register macros from public to specific model implementation for UART,
STM and SCU.
- SCU: set .impl explicitly to 1..4, so byte and half-word accesses reach
the model.
- ASCLIN, SCU: allow 8/16/32-bit accesses as per the TRM.
- ASCLIN: write TXFIFOCON.INW bytes per TXDATA write, instead of always 1 byte.
- tc27x: STM0 at 0xF0000000 as per the TC27x user manual.
- Reviewed-by not included for UART ASCLIN and SCU as the changes in
register access, which needs revisiting.
- Also fixed the review comments related file grouping in commits, moved
MAINTAINER entries in respective commits.
- Link to v1: https://lore.kernel.org/qemu-devel/20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com

To: qemu-devel@nongnu.org
Cc: Parthiban Nallathambi <parthiban@linumiz.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>

---
Parthiban Nallathambi (9):
      target/tricore: replace legacy DPM/CPM CSFRs with CPXE/DPRE/DPWE
      target/tricore: implement memory protection in get_physical_address
      target/tricore: add tc39x CPU model
      hw/char: add TriCore ASCLIN UART controller
      hw/timer: add TriCore System Timer Module (STM)
      hw/tricore: add System Control Unit (SCU) device
      hw/tricore: wire peripherals into tc27x SoC
      MAINTAINERS: Add myself as maintainer for TriCore
      hw/tricore: add tc39xb SoC and KIT_AURIX_TC397_TRB machine

 MAINTAINERS                      |   7 +-
 hw/char/Kconfig                  |   3 +
 hw/char/meson.build              |   1 +
 hw/char/tricore_asclin.c         | 537 +++++++++++++++++++++++++++++++++++++++
 hw/timer/Kconfig                 |   3 +
 hw/timer/meson.build             |   1 +
 hw/timer/tricore_stm.c           | 365 ++++++++++++++++++++++++++
 hw/tricore/Kconfig               |  13 +
 hw/tricore/meson.build           |   2 +
 hw/tricore/tc27x_soc.c           |  32 +++
 hw/tricore/tc39xb_soc.c          | 338 ++++++++++++++++++++++++
 hw/tricore/triboard.c            |  32 ++-
 hw/tricore/tricore_scu.c         | 295 +++++++++++++++++++++
 include/hw/char/tricore_asclin.h |  41 +++
 include/hw/timer/tricore_stm.h   |  34 +++
 include/hw/tricore/tc27x_soc.h   |   9 +
 include/hw/tricore/tc39xb_soc.h  | 110 ++++++++
 include/hw/tricore/triboard.h    |   2 +
 include/hw/tricore/tricore_scu.h |  45 ++++
 target/tricore/cpu.c             |   8 +
 target/tricore/csfr.h.inc        |  20 +-
 target/tricore/helper.c          | 242 +++++++++++++++++-
 22 files changed, 2125 insertions(+), 15 deletions(-)
---
base-commit: b6c4b7e86dec12d07f5cac65265b986d38ee9002
change-id: 20260531-dev-ifx-tricore-upstream-rebase-minimal-e18f56d421a6

Thanks,
--  
Parthiban Nallathambi <parthiban@linumiz.com>


