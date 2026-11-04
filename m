Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22B3606A32E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=Rqy3JKKA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOesJ-00036v-Dq; Wed, 04 Nov 2026 12:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOes0-00034F-Ix; Wed, 04 Nov 2026 12:34:00 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOerx-0006Dv-M5; Wed, 04 Nov 2026 12:33:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTdlRlS8L9cmQXA7hfLlscTEstKSjX8xABgIv+OEW53YP1JRRnYwLfqOV3dtsdsLNoIKJzCwDO5HVVk1tzrEyw1G7JBgpG6GKte+acSaglPpr9uLEDtdflqzl2Vt+wBCct8DR4+eTK7z52ByyLS1OJv7F1FFZFWetyVZQSczFpp5ZQ3IEr9p0T2EDpC6aqf7jV21GJufFdlFyBYClntJD893XCdaUaH6PojpvVXQA/Fvuc6XEGbCGQlVV1VQknkFUo7Kpw2YArm9ZTjZ2yIsp6lC4UvuTf04afxCkRCyAuyMxhY56X1oEYPAQ6d/nWmajFUsbsKuEqLRAkqwef16Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MyFS7nlgeAbI59R8e9e1YWqx+2yWSgIFE+Jg+reCHA=;
 b=ZloulkSNTIzll5YtwsUpoQ/9UKJVAi3blZF0WPNFXhDnuBelgWCfTyWaoFw++MmowX/H7oHIcnivPDUTaKcQiDouVldH7VFlykriFfA5PRX+hC/D2tX2Trhjx4cZTY0GEQZaLznqUvxyZFf1yXMiPLJLzTuGSNw4is647DDDoeLmEBPDFl+bjVSP8EzQ+jwn7kQ9jybWnmtuqFFr3hKAQ9DuWuYBJcCBQv42m3VgfKtlHPUSIiGYNfACnwvwIhjSTI8AUyFYxlb7NUN6vJlPn+2eCuEpd3W/AxoKWHD8XUn0CN4TsrxACVD9R7ziQNmQpmNcQlwVUq1Vfa1LIMF91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MyFS7nlgeAbI59R8e9e1YWqx+2yWSgIFE+Jg+reCHA=;
 b=Rqy3JKKA3YSuncDLPtYtJcZIKuVmYNWi/UPq9+D/QsLz3FtJws+g92086fd12FwdGOhJbLHcrBsBHm3V/9NCJzqQgPI+cUxiuhuedLFGa5yWbBZjCoT0ptaPWW4JPnAiPLYeLVgQiCWx1Hhu+OAVhn9iGH7R7nu3hOwEUs9wGR69jrlg3PkVqRjp+GDuqpZPLKreZVUy0byDfe3poZ7jTIxbsohc4D/873a4eSZMwyZG4zACgsC97AYuJ0mxsVd7pQ5oSmFAln1e3YQcMk+i7OKinxOa7U1sI5fAVjHMNJgR7GpG28v7EW5dNFOWfW1vMpmwAxPB6jelYjlSNH8BSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:33:46 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:33:45 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 00/17] target/ppc: Correct Freescale Book E CPU models
Date: Thu,  5 Nov 2026 01:33:03 +0800
Message-ID: <20261104173329.706635-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:405:372::17) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KUXPR02MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: b1531055-0573-4131-6bfe-08df3a99c6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|10067099003|18002099003|3023799007|56012099006|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261022105027099003|261021123027099003|261009221227099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: xeP2CUtj6uCN6I8Byb5tRQi6KdmYCycaa30NgX29OGxV4Dg6x0eN39SMrUAUoPeyaE8TF045ne5hfB13sehxrmYS2bOAMwGcl0ZN77uvXgxLi16afecTaGwPfQoRNjirwMIL/kWZYCSP7LSNtUUIcyARyxWe1+JAWhgV31IMuNzYoGrwokyh3PmUnsOLY4PiuM5EgGfZXFjQjozZbxABHRo/yutllGahDR2tZWkewZHJ1YZ33UfbKXWAtricEaiNDXAwjwagTfoEPFmlhQUcH1Xuk11R7FSTHe+kUVYggmoVD6SOjUM918c+uEZxHzV/gV02vzqaGM8N92Q1P5Yx6UwdfpQENqZjnhwLWLASxjZ/m7kE7axRmqhAoAP2m1ZYfZlojJMXFpE0VkgLAWQmHlVhudBCeJO3+p/X6mXvy5hpIAKwsUPYf6cFttCBmjoE3k5Wz3VG/CtULIB9JCYnm6YQpfIwiQ8WqsKFaDsED9UcwgGn29Z5J2eds9qx7apfCb+nnfUG7vwNm1/SPbQX1AbSGi1dMdsAci9TnCm2COGlWUimXbCLfRdyDcbiiDWQzHuwD4HoQ0BsHxpWytrvRIeN6dtg/JCO7kFM55bRHNGjx4NwSJvu/X22vQ64cb6SCG4dq6wrj+QcezlLqA8ZlUZBKZ+XddDwIUcylhIRs/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(3023799007)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261009221227099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTdWMXFEV01mQXVzemJqQXFsa2gxZFg5RkpyLzA3YnIrZktSTW1uU3FvL3Az?=
 =?utf-8?B?KzhxQlRGVjFBSG41ZmJaa1NrbXRteFQxT2dEdjZTWDFlK3Y2cVIvc0lZUEpN?=
 =?utf-8?B?SVVQdmRrMUlDQll0MWF6MDlGWU1URmh2bGlXQUgrS0ZkdWgxQnB0ajVtSWEv?=
 =?utf-8?B?RzNlNmdYKzBHbDE0cXpIMDVScWVUb1E0UDNsdmhoM1BlV2M3b0Judllnc0t0?=
 =?utf-8?B?RGxFbHJaTml2YmNuTndvNFpsTVY4R3ZYVHlPSkVkeG95L3R6UVFOVzZoMTFF?=
 =?utf-8?B?SmlXK2tVVVZQNkQzMk9iZFRkSkZmSXErQkdyczlOM1A0Nlo5SnlqN0tSejJl?=
 =?utf-8?B?eFUwRHVLTjc4clUwZ3hZRGt6YmpjY1ZyQUt1dERmZGFZZExjZkVtRFlYSWlD?=
 =?utf-8?B?bWtzQWJWWGpkWjE3MVZsbHN5cHR6SGpSdjIyVUZCSy9aeUhHbkFzUjUzTXpG?=
 =?utf-8?B?OHA2RS96SVo0MjhBdXJSa0k4TmZxeHUySzlBYmo1TkJ0SldwTURvMU02R1h1?=
 =?utf-8?B?VVA1ZDh1SVlaQ0lvTGpoMEIxRFF3RXBTYVBaWEdRenpzclpzaTcwcjBpcW5D?=
 =?utf-8?B?Q016dDlOcFBSV2J3MEU0eVB4YTBsWnZjYm1PUHZxWHA0cGpYeFdwejdJRmJm?=
 =?utf-8?B?MFVMZW04V05QUFFkc3Mzay9Mbi83WUhlWVNUVTgyVXBvRDJGT1R6ZGlCZTFp?=
 =?utf-8?B?ZGJTMzV0VGhzdDZiMWFsRkdoV1NXajJhcFRLVERiZXhuKzJuN2Eva3MxUE9y?=
 =?utf-8?B?bmUyWHpXMnZPcUkrd296QUxwUmpQVjNJWUdqaHBNTmx6RXdtWVN6ZjNSbG43?=
 =?utf-8?B?YS9JMnc1cVNTVVZ3SisvdGxyK1kwRVhXTHRWRm11Ukk4eERjVXA1Vkx6V056?=
 =?utf-8?B?MFZuSUdSVCtiNzRLaHc5S21VdytwL080ZWdkckx4blE5cXVWMFZoaHVkUlVs?=
 =?utf-8?B?cVhVR1VKaWorTjRaN3hhT1R6VklIRlp0OFZoUUdsNGVrSGdUVlhqN2hnZ1BK?=
 =?utf-8?B?RUM2UHhpUkU5MGN3Z2wxaS81bit2RTV3cUlnK1B6bHBlT1pxRURBRno0R3VL?=
 =?utf-8?B?SmY5RlVOYzZTSWtEdlJFZVo1SzJmZFJpUVhDNnUzR2tHdzZPSmRVMHIrdkpC?=
 =?utf-8?B?WlAyaVBHY0F0WkdUclJkaE9YVnNJc0x1SWhOcnlQdjc4c3VyVjdqNlZvRThO?=
 =?utf-8?B?TVVwazRnQmxzOXo4RWFnVUFabE1ZUzljV3B5bmhwY0E0RWtoZUREakQ4a2F6?=
 =?utf-8?B?L0hHS0Z3OHRmbzluMWloQUNCOXp0QWxxamE2VE03aitobVF5Y1BUNVM2N2oz?=
 =?utf-8?B?cVFIczhnV1pNRllxNzJJL2FCOTl0Ymp0SGFzdmloV2pxeUt2K0oyZTl0MklJ?=
 =?utf-8?B?azBMMnNQZy9rL2N2aUptMWNzbVZpZWMrOHJVZGhuWS9iWXljamxXMFBuSCsx?=
 =?utf-8?B?bXlubTVpU3pDNGZYL1VzRytsMmUrM2pQV281TWFaTGljQ2xWbXVqcytqc2Nw?=
 =?utf-8?B?eTV4c3pZOWFMZy9QZUJMdHNhZlFObWV4T0FRQmJtWDdRcEJnU1A4eVJmQmRa?=
 =?utf-8?B?YW1lVGNLTmVDaGJxVGJMRWxYVjlmRnRlcjZhZlpyZExldktOQWVlTnd6bldN?=
 =?utf-8?B?bXNwRkEyTkpmVXlYajZsc2YrRDVSRmZwWFFHaFlPVG4zd3RFTmxWWnEvK01I?=
 =?utf-8?B?eGo3ZzRJVXkvbEE5WG5MODNTb2tSOHhTdjd5d2lxcDBjdUNmaUNyZi9PR0J3?=
 =?utf-8?B?a1VObnlIYzNMQ21HUXF1ei82R0FXaG8rYjFWQWpwdjA3VjZnelZJRytwODJy?=
 =?utf-8?B?VlUrd3hjZkpHZmtUbmxUM3Nvck81UlJuMGRKeVM3QW9QaHpRejZrWGQwcUJq?=
 =?utf-8?B?eHRmWmpqcDZQTjA0U05nVEJITURTZ1EwMlZ3cUVPUUlnVW9FMjdmMFNDZmdz?=
 =?utf-8?B?NW9iaUpzRnV2NFgwVkM2UXpKMy8yN2tPV1VwL2ZIL1d2L1Zla0Zsd254MUtq?=
 =?utf-8?B?ZmtQTmxMRU0wbkdxSVF1YXBMby9RWmxoeG9tQzFOeWpiaEVOY0hUZ1hQVGFJ?=
 =?utf-8?B?UytQcFYvOUxBK1NJVjdjUjJKSEZKL3UvYUg1Z09nOER4VklpVVBYZ1paNWxv?=
 =?utf-8?B?cTlBMU9kMWJhU1RWYTRaR2tySTJURVVBT0hJa2lza3QwWXAwK0szcDZxV2FF?=
 =?utf-8?B?M0xaUmZTaEVCa0RVQm1JbFhpWENocWYyODRxdmFxNndtQTZLTTd2cFJmOTl5?=
 =?utf-8?B?NjNiYTNSWTBhY0RXcUZHeTVZUlROR3JKNWFiVVhZRmdGbVU2Y1dWN2pTeVlW?=
 =?utf-8?B?TGU4eHZRd1RpeThZNGdUcUZwY3Fia3VxWjBtUG94OS9DRHhKT0dLR3FsTTVt?=
 =?utf-8?Q?OJOS7amPHqDipMBg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1531055-0573-4131-6bfe-08df3a99c6cf
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:33:45.1593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLuf4xu8P0ocJdBWxpKpiTlcKe9+GvWMColvp4fjZiATiw+GPMYsGwKG4CFomaCOmyySebv6oSzI5HhS9/3vPg5zK61OAklITQA+XINx/Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB8801
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series corrects SPR access, cache configuration and instruction
availability in the Freescale Book E CPU models. It also adds system
TCG tests for e500mc, e5500 and e6500.

The patches are grouped as follows:

- patch #1-#4, bug fixes to PIR write access, the MAS5 SPR number and
  cache block/line sizes (qemu-stable cc'ed)
- patch #5-#6, complete e500mc/e5500 L1 cache configuration and
  remove redundant e6500 cache geometry bits
- patch #7-#11, register the missing cache, MMU-assist and sevearl
  control SPRs
- patch #12-#14, split the PowerISA 2.05 instructions into integer and
  floating-point groups, due to differences seen on e500 series cores
- patch #15-#17: Add TCG tests for illegal-instruction exceptions, byte
  comparison and parity results, and FPSCR field-mask handling

Changes in v2:
- Group ISA 2.05 features into integer and floating-point flags
- Use the first free bit for the floating-point group
- Align flag definitions and comment endings
- Enable the shared ISA 2.05 integer flag on e5500 and e6500
- Align the FPSCR W/L behavior flag comment ending
- Rebase the PPC64 test entry onto the Meson variable cleanup

Bin Meng (17):
  target/ppc: Correct PIR write access on e500 cores
  target/ppc: Correct the MAS5 SPR number
  target/ppc: Correct the e500mc and e5500 cache block size fields
  target/ppc: Correct cache line size for e6500
  target/ppc: Complete e500mc and e5500 L1 cache configuration
  target/ppc: Drop redundant e6500 L1 cache geometry bits
  target/ppc: Register L1CSR2 on e500mc/e5500/e6500 cores
  target/ppc: Register L2CFG0 and L2CSR1 on e500mc and e5500
  target/ppc: Register MAS5 and MAS8 on e500mc/e5500/e6500
  target/ppc: Register PWRMGTCR0 on e6500
  target/ppc: Register IVOR42 on e6500
  target/ppc: Split the ISA 2.05 instruction feature group
  target/ppc: Enable byte comparison and parity on e5500 and e6500
  target/ppc: Ignore FPSCR W/L fields on e500mc, e5500 and e6500
  tests/tcg/ppc: Add Book E illegal instruction tests
  tests/tcg/ppc: Test byte comparison and parity on e5500/e6500
  tests/tcg/ppc: Test FPSCR W/L handling on e500mc/e5500/e6500

 target/ppc/cpu.h                           | 21 +++--
 target/ppc/cpu_init.h                      |  3 +-
 target/ppc/cpu_init.c                      | 68 ++++++++++++----
 target/ppc/translate.c                     | 10 ++-
 target/ppc/translate/fixedpoint-impl.c.inc |  6 +-
 target/ppc/translate/fp-impl.c.inc         | 14 +++-
 target/ppc/translate/fp-ops.c.inc          |  9 ++-
 meson_options.txt                          |  4 +
 scripts/meson-buildoptions.sh              |  2 +
 tests/tcg/meson.build                      |  1 +
 tests/tcg/ppc/meson.build                  |  5 ++
 tests/tcg/ppc/system/README                | 22 ++++++
 tests/tcg/ppc/system/boot.S                | 92 ++++++++++++++++++++++
 tests/tcg/ppc/system/byte-parity.S         | 33 ++++++++
 tests/tcg/ppc/system/fpscr.S               | 75 ++++++++++++++++++
 tests/tcg/ppc/system/isa.out               |  1 +
 tests/tcg/ppc/system/kernel.ld             | 18 +++++
 tests/tcg/ppc/system/macros.inc            | 56 +++++++++++++
 tests/tcg/ppc/system/meson.build           | 39 +++++++++
 tests/tcg/ppc/system/unsupported.S         | 31 ++++++++
 tests/tcg/ppc64/meson.build                |  2 +
 tests/tcg/ppc64/system/meson.build         | 33 ++++++++
 22 files changed, 509 insertions(+), 36 deletions(-)
 create mode 100644 tests/tcg/ppc/meson.build
 create mode 100644 tests/tcg/ppc/system/README
 create mode 100644 tests/tcg/ppc/system/boot.S
 create mode 100644 tests/tcg/ppc/system/byte-parity.S
 create mode 100644 tests/tcg/ppc/system/fpscr.S
 create mode 100644 tests/tcg/ppc/system/isa.out
 create mode 100644 tests/tcg/ppc/system/kernel.ld
 create mode 100644 tests/tcg/ppc/system/macros.inc
 create mode 100644 tests/tcg/ppc/system/meson.build
 create mode 100644 tests/tcg/ppc/system/unsupported.S
 create mode 100644 tests/tcg/ppc64/system/meson.build

---
base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
branch: ppc-fsl-booke

-- 
2.53.0


