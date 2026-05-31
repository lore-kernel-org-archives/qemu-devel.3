Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87B1CD6E56
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 09:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTcbI-0006I8-7D; Sun, 31 May 2026 05:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcbF-0006I0-V6
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:36:53 -0400
Received: from mail-japanwestazon11022118.outbound.protection.outlook.com
 ([40.107.75.118] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcbC-0001L0-Mh
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ+ey5z1SLx8h7LWv0JzYzrInlb2S1ak/ASloUrjFLxEMC5lVdHdcFWFbxvWik5k2KDqB77N4cF5FS2HBJ4n+rYf87DisC9dgih03LkZJNKmv5qegH/ak0FV25AcESMczxog4kii73tQOUzDV1KXMB8UR0XyV/XckjdxMztVZ5MizdZ8uFdF0CdecyP5GDkCz/mdySHBL+2kGxwkhq3xE+BPsM0mGc2SYUSB4U14oI2T5srYnS5u3VkKkrfwOiOd6iR5YZdBnjcwhC7x/OpcWA2oSfKwz287F0tDfG5RSm5aL6Lf0AWe1GLKugKkc+xuRDaYuqfNLAg0/ptN7HqgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=on1kaHWX0h1edPtSA+twcTFyNGvfEzJsJAonPUEa00A=;
 b=I7E1LnHdDj2ttKmcg9OFrVPofVkzja8DJtHrGiTa4RVyIKBjuP/f2UEPKS2zJ8ofs57cXPlpu7mJ61DE5zDWRF3htf1cinHApptANlvbXVQtBKW+Yqgnkr72lLtqAIUKD5WgxkU/ZWR84y8WkqlCGMS8D+uOiRr6nlT9KMsBpvipDAfkDOZC0Dw6hYh4Oa9kOYUzny1tj2mmfFK4wD/6dN/ug/Ww4lTss0SxAo4YouDFHC56KtaJ86GOS4RDdJV531DTO2cPV6sD3i7p+0fYrlJJHgwthxeRgBHxGNJdVKv7yjfxOO25Ul5nRcRcg+HuY5UucOfHC6sdDSzQdhHFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYSPR06MB6627.apcprd06.prod.outlook.com (2603:1096:400:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:31:39 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 09:31:39 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Subject: [PATCH 00/10] target/tricore: MPU, peripherals, tc39x SoC
Date: Sun, 31 May 2026 15:00:51 +0530
Message-Id: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMv/G2oC/yXNQQ6CMBBA0auQWTsJLdIYr2JclHbQMbaQmUJIC
 He36vJt/t9BSZgUrs0OQisrT7nCnBoIT58fhByrwbbWtX1nMNKKPG5YhMMkhMusRcgnFBq8Eib
 OnPwbyVzG3sWzNd5Brc1CI2+/0+3+ty7Di0L55uE4Pi1N8dmLAAAA
X-Change-ID: 20260531-dev-ifx-tricore-upstream-rebase-minimal-e18f56d421a6
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, christoph.seitz@infineon.com, 
 David Brenken <david.brenken@efs-auto.de>, 
 Andreas Konopik <andreas.konopik@efs-auto.de>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: BM1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::26) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|TYSPR06MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2a8cd9-98e1-4a6f-d2e4-08debef76ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|6133799003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: N3VE99icTRAKs3Kf+H0wVgzgpNzZ7pGp8PQLnA6uNoYILkvg0xy/bf0pM1lzavo0TB5NUcFpwoVnSjeXDZaMuRwdcQb+CqhEVzGeoW9nYala3DISQPbneWhJeTPS4T5IJBjs3KvJyM46tCJ+6rbPOi1qXPGqUp77tdrK6Ws6vmnrYgc+hwXJV1E4HFIcltoZ8PFPHtPOfMUDaGiFETAaWF+a77cPdcooBoHDR+T7iNK0x4ya5JHvnbz0JVzHgOD5jRJ5x5N9zw6XVkFUAUBN7sPkAOHHT1pJLIBItaLzQHoepYqw0kJwu+XxwwAw+2ui6zue4KQeZLI8/wyf8OGvU3FLym19QxIYfn1zdi6Jtn4NB/7Sh09Q/j8ik33A//mNsAq7o1kUxJdpbWemoID1OE9LEEH6UDao55/uPDu3Te7LDKQ4MuvbmhYidQupju6AozTyH/PZOtcLLhPg8E+geQmYW/1Q2JUH+6v3UJphgYv0vW0/M9WdkuKFKFaOBTcab2ny+XoNV2uyD1WF8tiRGBQGdOHGO7DcSLZLTYxEoSGHOYOBHBPOZaObHJFULcla71xmnY4106NPjbTx8OQSLexhKzwCvESvkYGhYaE5y2B/E1vmQrfduyhl+3Txlpm9q28tphIDJmIOG1pfvin0ymFpMTevX3NFe12yOoDNkUyRfdxCtybhK4Ba+hCu199bWnOnBvPwFwBsrQzh6xw5C4OZ/8aXmp5OOdkifzG75XNG+mMy7yCAI3s3M7H5caJj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(6133799003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHk2eHlPTVJGc1JzQnladHZDUUNjQndYVFl4TFdKQXpZZTJxVmVmcnNTWi94?=
 =?utf-8?B?Z2lZcWVJS3RVZmFvZkhMUlVneG9NK1FmUTlucVhXYmpyUlYwRGRnT1k4VlFn?=
 =?utf-8?B?aFYybUFjTXFtOUdJakJIcXRId1RmLzlkV1ZxUHJ6ckxVSVFaRjd6QWREQ25J?=
 =?utf-8?B?Qi9BbFBQMzN6RFhJZi9MR3ZNVkZZSXhlVGszUUFacmxSUTZiY3VUNFlNS2tH?=
 =?utf-8?B?aXA2SzhxSCtoNzJuWEFjdVNKOXdPS01UV1ozSi9uNTE1eTRlM1F1K3VaYTN3?=
 =?utf-8?B?eElNeGp0UGljU3hxTDloTklGUkJ2cDFZYXdRVlJsZ2VaQlJRVTQyaWJHOXNU?=
 =?utf-8?B?RFB1VXhEZk1sbHJKOWxKYmVVUitZWWF6cHl6N2p1c1d1NHVyTG9zeG9ZY09L?=
 =?utf-8?B?SituN3dVZWtBc2lYNlA4c3c1NVR2d05pV3hUeDNJYVZMeVgwT2pnMDhMRnZU?=
 =?utf-8?B?MFZMQ0lRQ2NvN3hnMlluNVViblpGekplVUhocXJBaHJndW81RGtwVnY5SkEv?=
 =?utf-8?B?aUViZzZvK1k5aEp3ZGYyQ3dFZERTbWh6M1R0eHJyMXZrL21nUTliSVJva3ZK?=
 =?utf-8?B?dERtcUNqczRpc0JJUUd0b3NCY3RzYTVIZUVIM0NQRjZKaytKYzR6cDg3ZDk1?=
 =?utf-8?B?azl5QXpXeG9yczFTbU02dkJhV2pkb1h0UmRkN2xzS2NPWU5sSmRjRHRzN25X?=
 =?utf-8?B?Y0g0SC9Zam56d3RjNlhBNGZ3V21wSVkyWjBFVkZPUXlUMHJwMnRrRlNxQWYx?=
 =?utf-8?B?L3UwSmJYK2RzMEIzeVpQZkFuV3NaWDFaNWZHQk0zelVZQitzK29Va3Rqa05W?=
 =?utf-8?B?RStQRzNOeU0zenFhVGxSL2xndkU0OXhxV1gxZHpyQ3NiZkt4Ymo1MDhuSXl4?=
 =?utf-8?B?eXdxUk9lazExZ1ZyR1F6aW1zT2QwcmxXUU9peFpIYTJqbjBVc0diTGxia2Jp?=
 =?utf-8?B?SWNCWFBKRm5OcWNkVHk1a3FYekd4c2o4U0x1RWoxWFVpSFl3WHVDbWJwUmJu?=
 =?utf-8?B?TmgrL2hoTERPZlkrK0hsTS9sNGhEZnFOVFg4d2FwbENHRkxNQlpVRHhWa09t?=
 =?utf-8?B?ZXVuc0dsL2F0bzh4QTAycS9QOGJQYXhJS3ZWUHVxNnZINGN0WWZiN0hRWE14?=
 =?utf-8?B?YVEvYmxTekRkdmJNWWNseE94OURWWVFxN2g0ZnRpK085NTBDYzJib1NKTFBv?=
 =?utf-8?B?c3FnZmU1b0pYVm9lN0I4SjhjWHlFdUF4UjcyYkh1eVh3bHVhbGZHc2JpUTRJ?=
 =?utf-8?B?aWJKWjBkZUZRLzgvYVRGVllLQm1GN3RYN0FXcEJnWkdxWGZVU0ExYmpxQzNt?=
 =?utf-8?B?c0EyUTk3ZmFIWlAyVFdKVjhVcG9yTzlMRzdWcVBtK0NZcTNZNGdkV3FXdGhG?=
 =?utf-8?B?VTFnYWs3QkVuaFB0b0F5YmVwRGVwaE5KU2w3cEVJaWhOK0NkMlJLQmx1Wkly?=
 =?utf-8?B?ZERWTm5XSG9DbnFhU2pBMkxjR0FNbE15WXVUNjZxYXN2QTVnLzNzMjlWbkJz?=
 =?utf-8?B?Nm1qbVFoNVN3eEZnSXk4UWcvK0NYTTFJOWsxN1QwaWRPTzlzam5WSDAvMzZ1?=
 =?utf-8?B?L1hFN0JKZDRUSGQ1NVV1WjFsNGtMeDlVYk1Nc1Jpd09nZzhuV2VxOVVqQzN1?=
 =?utf-8?B?ekdlYThGNGxOSzl6MDQ3dVRqaHBMUVVQcVZOSmVUOTlDeUxHN0V2YWxMMHBl?=
 =?utf-8?B?dzZGczlaaXpnMTk5c0dvdE5jNVo1ZjU2TFEvTU5JZ3FzbGRTd2ZUT05Jd1N6?=
 =?utf-8?B?bTBoOTBmNnNNUjNTMVRPYjJJYWhrWm9DZEhQZjh3SmpudkpFNG1HaTdnUFk5?=
 =?utf-8?B?RXJaaW1EK29QcGtuN242dVYwUTlPRlRmb3NsMEJYNVFRWUI2SU92SXZKY292?=
 =?utf-8?B?K2xsMzMwQmtKWDZhemNXWDdMcTV2cjAydGNjUnhrVGhIeHBYR00ycnVOWG9Z?=
 =?utf-8?B?WDQyek9CbEtIQm1DVmZISS9NMmEzZWQwcFM3aU5vbjBOaFNZWVMxMU1CTTgv?=
 =?utf-8?B?TVRKcTA4N1o4QlViQUc5MGRIMk55Nm1LbmRYWXB0d3ovK3p3c2Y5WUhwTldy?=
 =?utf-8?B?S0NWSFdBTW1YZnEzL1ZVc050UzFVZDg0Qit0LzMxeFhFUndDMFpkelNKS0RN?=
 =?utf-8?B?L093dTdlcGRKT1UydmpuYi82S2V3TEY5UlVCSzlLYTl0a2o1L3U5REVKM3U4?=
 =?utf-8?B?WmVwTzhDSTJKTDV5eW9HeHZ6bng3VS90azRTUHg3THc2a2ZRSlBBYkdOUmhr?=
 =?utf-8?B?WXhDNzA4c3U0eUN1RU1hdjROUm9Ba1k3ZEpoZzc0YVVlN1lUZlU1RjUrU3hR?=
 =?utf-8?B?cE50UWNDeFplcGdrYmk0cDFwNndsVElOaUVzTmZGcWJNaExadWk3QT09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2a8cd9-98e1-4a6f-d2e4-08debef76ada
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:31:39.3239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYrXtwZFyP5RQeRnIemKExtmeHuFLcUE/6SDSlmDkSAqi9fCagvxW9DiHTUqeGJY/mIHZfKshIUAOlXSaUI6nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6627
Received-SPF: pass client-ip=40.107.75.118; envelope-from=parthiban@linumiz.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fix the MPU (was a no-op stub), add peripheral devices, wire them
into the tc27x SoC, and add the tc39xb SoC with TC397B machine.

The peripheral device models originate from the EFS-OpenSource
QEMU fork [1], targeting QEMU 9.x.  This series ports them to
the current QEMU 11.x baseline with API fixes and adds TC3x
register support needed for Zephyr RTOS boot.

[1] https://github.com/EFS-OpenSource/qemu-tricore-patches

Changes from the EFS baseline:
- Ported to QEMU 11 APIs (resettable phases, const class_init,
  CharFrontend, hw/core/sysbus.h, DEVICE_LITTLE_ENDIAN, etc.)
- STM: fixed address from 0xF0000000 to 0xF0001000
- IR: fixed address from 0xF0038000 to 0xF0037000
- SCU: added PLL locked status for Zephyr clock driver
- STM: switched to monotonic counter for deterministic timing

Patches 1-3: Fix memory protection registers, implement MPU,
add tc39x CPU model.

Patches 4-7: Add IR, ASCLIN UART, STM timer, SCU devices.

Patch 8: Wire peripherals into tc27x SoC.

Patch 9: Update MAINTAINERS (Orphan -> Maintained).

Patch 10: Add tc39xb SoC and KIT_AURIX_TC397_TRB machine.

Interrupt delivery and TC1.8 ISA will follow in separate series.

Single-core emulation only (CPU0).  Tested with bare-metal
firmware on TC277 and TC397B boards.  Existing TCG tests pass.

The downstream release with TC4x and interrupt support is
maintained at [2].

[2] https://gitlab.com/linumiz/infineon/release/qemu-aurix

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
Parthiban Nallathambi (10):
      target/tricore: replace legacy DPM/CPM CSFRs with CPXE/DPRE/DPWE
      target/tricore: implement memory protection in get_physical_address
      target/tricore: add tc39x CPU model
      hw/intc: add TriCore interrupt router
      hw/char: add TriCore ASCLIN UART controller
      hw/timer: add TriCore System Timer Module (STM)
      hw/tricore: add System Control Unit (SCU) device
      hw/tricore: wire peripherals into tc27x SoC
      MAINTAINERS: take over TriCore and add peripheral file paths
      hw/tricore: add tc39xb SoC and KIT_AURIX_TC397_TRB machine

 MAINTAINERS                      |   9 +-
 hw/char/Kconfig                  |   3 +
 hw/char/meson.build              |   1 +
 hw/char/tricore_asclin.c         | 457 +++++++++++++++++++++++++++++++++++++++
 hw/intc/Kconfig                  |   3 +
 hw/intc/meson.build              |   1 +
 hw/intc/tricore_ir.c             | 264 ++++++++++++++++++++++
 hw/timer/Kconfig                 |   4 +
 hw/timer/meson.build             |   2 +
 hw/timer/tricore_stm.c           | 328 ++++++++++++++++++++++++++++
 hw/tricore/Kconfig               |  15 ++
 hw/tricore/meson.build           |   2 +
 hw/tricore/tc27x_soc.c           |  62 ++++++
 hw/tricore/tc39xb_soc.c          | 366 +++++++++++++++++++++++++++++++
 hw/tricore/triboard.c            |  32 ++-
 hw/tricore/tricore_scu.c         | 240 ++++++++++++++++++++
 include/hw/char/tricore_asclin.h |  89 ++++++++
 include/hw/intc/tricore_ir.h     |  62 ++++++
 include/hw/timer/tricore_stm.h   |  76 +++++++
 include/hw/tricore/tc27x_soc.h   |  13 ++
 include/hw/tricore/tc39xb_soc.h  | 115 ++++++++++
 include/hw/tricore/triboard.h    |   2 +
 include/hw/tricore/tricore_scu.h | 103 +++++++++
 target/tricore/cpu.c             |   8 +
 target/tricore/csfr.h.inc        |  20 +-
 target/tricore/helper.c          | 242 ++++++++++++++++++++-
 26 files changed, 2504 insertions(+), 15 deletions(-)
---
base-commit: 81cc5f39aa3042e9c0b2ea772b42a2c8b1488e76
change-id: 20260531-dev-ifx-tricore-upstream-rebase-minimal-e18f56d421a6

Thanks,
--  
Parthiban Nallathambi <parthiban@linumiz.com>


