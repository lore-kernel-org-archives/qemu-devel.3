Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7889B606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=tZqyPdlT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLyqM-0006oo-UL; Wed, 28 Oct 2026 04:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLyqK-0006nQ-QZ; Wed, 28 Oct 2026 04:17:08 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLyqJ-0007Ak-8d; Wed, 28 Oct 2026 04:17:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTfkoPgN1b7ZJ8JUyJIkOcUrL3L1KcOvFyUw5bNaHSfWiY4xnFvqU9VytJ7QSa4lP1chCUIvcfWMBpkE0m8/0ND8e/0mGE8NFAzJy5SVJHMRr10agJwLlnyMYJJmQM1DhAcBIQnWJ6lWhkN9my3wGLH5onsyAt4XoAvgnCUXavq8iyS6DZkCy4zvFFE0VWqQvLCaw/jD4mEIrdcGYnq3fYPVeQb4wOE4iVc1Z2F0KBNN9Hr5ED5B4TdMi6bGUMkEHQ7Bj9geQ6/ICC/DabdEekfLGtnHjRnF/BT6tYIBAHmAHQ6fvKfJ8JVgdmmG1VOHhL4kE09uvrbLVjxlFNVK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clUKAEfv1n0d0ysJxwklb4pmWvvWr5vRGixICwCsoy4=;
 b=VGftIl/QpIrMrR/u8F2TBcY5/mDWeELWMob3FBAGb7fnZZimy6nIgfdiED1tTOBqfKfAy8P9cLPMHA99GRKsp473+joF2jMH/IK/nT2TCLD1tx9gcqtiMkUPO1hrR0q4OBDdt62sXLsh2HJRRKnn2Ziec+WIIqeX+2gauq26XYofUqK3qFeNHqB669BKeSkVw4sg4gU/ZWfzG1PZD3Mh1PW4hqHH7QgB41QDyjQX5g+Sl9ChQdZx2PsCmcsSQeIl0lo8dxxzAgUZM82hOM16LvwRBprgse27goMceeH1cxP3Ha7NXlruZktSxFo8QStLPmcPup7LynGXh1zOdrbjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clUKAEfv1n0d0ysJxwklb4pmWvvWr5vRGixICwCsoy4=;
 b=tZqyPdlT8+P3J7iKyIR1st2sTEXlcq1Ev5cUv33h5yXqMeKCr8FIY/VnhsmA1ohThCab0WtLzy1MWvah+dtPqlHmaCiiQE6wOqRNLXzs6hcRROyjxK3Enm19Pv+JAlRfVRcu49tbHFFhGBlwA600/+X769myct3n3pVTSpfqYylHR1s905yDyHsG08purkygKbLaIVVdNDHcaK/ZOK3eBR8M/NtR6hLadsn7AsM02XruVWdK9y25XFvOiRUZrrLUM5vCfYeKAbroooL2Td9aMPjQ3MX4xy1sHxQLnDWDRU2tstJuFELr0ebayIby4cSfxXw1EirXnUGPAhUQh0S70A==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by KUZPR04MB8983.apcprd04.prod.outlook.com (2603:1096:d10:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:16:59 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 08:16:59 +0000
Message-ID: <TYZPR04MB7491ECBD333A976E1BC93A98F36F2@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 28 Oct 2026 16:16:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] include/qemu/bitops: Move BITS_TO_U64S to bitops.h
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Xuemei Liu <liu.xuemei1@zte.com.cn>
References: <20261026024048.630015-1-wang.yechao255@zte.com.cn>
 <20261026024048.630015-4-wang.yechao255@zte.com.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261026024048.630015-4-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <82fc95d4-e697-4cdd-ba59-a356f67ccce9@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|KUZPR04MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c72e5c2-bcff-4424-2d9e-08df34cbd5fa
X-MS-Exchange-SLBlob-MailProps: obhAqMD0nT+6TxoHw5fNkboUl/ASnSn2PiVI6/JFdwXf8kE+hFVM22x98qn6dXCkIwDyPo5mOggKKmw06ba+lVCDzcec7F1vyBJoXGI6yOdVtg7pDDNwyuw/dY3J4NjkcQ1+ps00U8qmI4SaMTnkpR0AY2eW9dUY+/AsVyv/Odi/wiHmLsNLYUHxP+P9OA7HoSyNuCVohQCgj/iw155dYUgnq2X4VDRhDTEevWIwM6pLsG74Xf4UO7oNGNEQ+Dtp13YIu+5UYO8rfK1diNVsUEseDhDpAtpoIsO6BS7vvSuYzH5e/KiWR0BTZxt+MEu31JFBG70BelG60GL8nh9cbHIAoPgolDzN/VFLvPK4uteezs6s/kk66Fkjqt8xV36gvi9b6IKe7DtCQvsMJX5KIRxunPk942/QNjGcpCxTWenwiP7QiFwyZi0JSH6U820sg6fVt87vqmO5mwVSIsi0qa+T9+QuXqM3xu5SYcOXeQYDMrGCPjWD2HZsdELWWY8nIgI2+bGkL2+sOSs9UZbjXycUaesDV7rANQ0X1p7McyW5h69Br7TgkVq9K+MDkWpYben9EPgjNOiB8SvzvEwUNZUzLZ1n7zO1MkmEiN58h/7KwAnLT/4yCXPkRzpqqldzC9nnUY/Sh1wZmoqGmGrVwMvF6G766V5mMIvA9zlbVzbJx01ZsbHwubWlzMNWkSZDULHEfZB4HJP+4N9d0TqbXKYCVDTEcgZGD8ecci00sDuWcdjH3OO8v54jmgXPrc0qcIf2wN8FiYlMSqUWvjCPChkdJSLm5IunjDDf0ruf23fnaCUPvNkcji1TKKQMYq4V
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|5072599009|23021999003|55001999006|19101099003|6090799003|8060799015|22091999003|24121999003|2604032031799003|12121999013|19110799012|25010399006|4140399003|3412199025|440099028|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGVWUUcwYTc1UUNKZnZXNGNIMlJudndWdGVZM1BhSno5bHloNEJ4Vm1uSEdr?=
 =?utf-8?B?QnhaN1Z0THJzUlRlcnJIL3Z4ZWRmNFdoZ0p0VjNMVW04dFJaVUJDMk1hY0J3?=
 =?utf-8?B?bGp1cVBiNjdGTkMwZFJ0QVh2OThwU3grenlhakdJN3BWT3hlOTdISWpPRytV?=
 =?utf-8?B?NjdDb3JNWmtVenNQb1RsTXJiZU5FejNvSEp4Y2xGdW5ETzRtbE44STNQNHRu?=
 =?utf-8?B?T25wWW5pZUlIV2NvTFJvQ25NTlhLVXpidmw3bi9DWVN4OEVZYUg4aDJTQitW?=
 =?utf-8?B?dWdTQnZrVmxoSUlmTllncXBUbEliYjRjaTFBanpyQXdHWnZyOUxyUEF5RWE1?=
 =?utf-8?B?VUduSWhSdkFUSnlCZnh4eXJoOTI1ZWdvMnExNnJuVHY3VTZqZDA1UzB0cFhW?=
 =?utf-8?B?clhubE4rMkJJdW9pbkhuUDlna3FoS2R1U3ZPbVplbk1sbmJrS2xIMGQ3QW9m?=
 =?utf-8?B?dnYvbDRPNkQ5VS9tbktPMHBZV1pXWlJaaDc3WHhvS1pGUWhweWNrWVhnK3JL?=
 =?utf-8?B?UFZ4ZWJTR2dsVFJ6ZzVBMGI0ZGVWWVFrN0E2TEJHTzZBVlY5Rk9BTFdSTXYy?=
 =?utf-8?B?UTlWSG5GSDdzUlVjWTIyZTAwYmVia01kdkVRb0pIaSt0aytRSTZKdzRkaU1S?=
 =?utf-8?B?L2JaZ2dBL3FJbnRNZU9sZFhGZnRFbGd6L1I1eHNQa1pCRytOQm0rZFJOR1dF?=
 =?utf-8?B?MnJGUXpJSnZoQXFsdC9pdlFlbXY4bGx6RTl4YkE2Y3NveGFPaFZMa00vUHZ3?=
 =?utf-8?B?WWZna1hadm1GTDhMS2lSY3FpZ0ZuWURUVzNLRlA2TjVVNkZQWUJqLzFGZVVs?=
 =?utf-8?B?VDI0UXFiMTNKendONmpTV01mK1A1M3pvbFBIMEVLQ0cxRGoyWCswUmV2K3Ft?=
 =?utf-8?B?YWhmcXVINy82blhEUzh2SDR0anRHN1VYYzF0anNIZ1czV2JwS3BlSTUyK21O?=
 =?utf-8?B?bDRKc0crUlRwa1oxNTRPL2Nqd2REVUMwKzVocitrNDlUcVNzQ0JDbWg2MXF5?=
 =?utf-8?B?T2lyYm1ZR2UyYVVFVXQ1cmllaVNNN1Q2M0xCVEgrQWdWR01URXpKeTZ6ayti?=
 =?utf-8?B?ZXc4bENSUldGUmRQZy9zZ1JHTEtuQ1JNVEdKOHNtNVNmMnNMc1prTHJKNGJn?=
 =?utf-8?B?Wkc1blQrVEJybThidEhTaURZRnJlRG1TNWxXRVk1ejZxeDFPa2REQ3o3TGkw?=
 =?utf-8?B?UlFJaEllN3doR0FNY2UvR09Yd045bUtQWHN2eWVHZnRGajIwbU1XUWN6TFhQ?=
 =?utf-8?B?MFhWbGJMSy9XQkNrWWN3RUowNDFMdTZiSlBUU1dleFVBbFpGL082R3JwNnZI?=
 =?utf-8?B?RGk4REpJOVBFbUJ2NU9KL3EzVGZmeUtmbm5POU1pcExsNkdZYzZja3lORFI4?=
 =?utf-8?B?SENtTjFiV212bHNCRHNUMlh1TlBndWNoQkhiYml2TXRRK2ZraFA0RWs5TGhW?=
 =?utf-8?B?VVNmUzRpamMwb0xuamJIcmxlZkNtV2JQamFjRkdDRUR3czNOdDN4NUtCbURn?=
 =?utf-8?Q?NW7WuEWi2NT3p6nScjHz2Ml6IAz?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZkSS8zbXAxVFZNZXFmbUthaUVzbkMvend1bW0wWGNWNVVOZG9HWXNZRTBT?=
 =?utf-8?B?ZWI1M3VPMU96b2Zlc2h4VjRLeTBZc2xKUmJoMnBIT1JIa0xCTDR6WHFxOHVS?=
 =?utf-8?B?UkVLam01M1ViKzU2dURhVTRxZVVxc2xDd3JOaTBrTU9BbTdSTTVBb3JyMG5H?=
 =?utf-8?B?R2FTZzNYNHJlV09XRDl1alowdE9FVmIzaFpmWVkrR1UyMGNFakpzVlhjL0Q1?=
 =?utf-8?B?L2I2anEycWZsRldkUGJHLy9ZVDN3RllieUg1SWM4Um5qcjhVdVBrWTZZbDdx?=
 =?utf-8?B?US9XdW1jVG16dnZ1QkdKdDVHUkhYTHF4RTIwVGNUU2JheHp0V3lvOTh6dENz?=
 =?utf-8?B?dWpjaVlqUkZ2Qit5Sm05akFwN25tSHpmZzdmOTNmOTJ6OXQ2cGRYUllwaGpP?=
 =?utf-8?B?c1I1K25pWXJlVDBBSnVBM3pSNTZ5MU16cFdOL1YrdGxDZ3ZtV0EwbmtMTVl6?=
 =?utf-8?B?L0FuaU1PV1hjM1d5STNLWi9CRy9VMjZ6UW11SGcxeGZNcXh2bmREVGlkRHN1?=
 =?utf-8?B?NUhLcmdDSi9QMDB0Nkx4emsxb1kybEtrQUc3UGt2Z2RCT1hBMko4Um10QitE?=
 =?utf-8?B?S2IwMlBxNUhvOW5mQzFxOFlYUERpNm5qaysxalFOeXM2aXlwRko2WUVzVlVC?=
 =?utf-8?B?TzU3VnpyaFY3R2VncUxpVmppK3l5WDJxOVJHWEV1WE1zTUVIM0V5WU9nQnll?=
 =?utf-8?B?d3pEWmxONnlCalZPZUZDYkpla0UybExmS1FQRnQrTkxrQzdwWU1Hc0t3OFFq?=
 =?utf-8?B?RUpUQ0xWSmdjb1BkRGExeit4ZkF2b2E0SlNCSkxoOCs4WlBHMVplMVMrRWlo?=
 =?utf-8?B?Sk15YkZPanh2dmtqdGMxMmY0TkJ4cEVDU2hRSDJ3UUtRUm9GeDdRMllUSFR5?=
 =?utf-8?B?eDVzdURRUkxQNE81L2IxSFNWWG42QmU4RnZPaFhRcUNBTisvWVdNcDJieGhr?=
 =?utf-8?B?SlM2Z1lOcERsSlp3aFpEK21yRWR6bFZwcXB6ZFJ6RVMxaWFTa2crNlE3YWs1?=
 =?utf-8?B?Nm1sOFFUR1p3NDMrMHdVWVVrNWNLamx1VFd1bCtqeWJ2TDhsK0JWQ1RETC9n?=
 =?utf-8?B?YXZiNFAvSndwYlgyNlBJVGpmS2F3THplWjNMeXJZeTZoUHlkazJDSEExSVNw?=
 =?utf-8?B?RXFBaUgybDVWa3FpM0Z2dHJCWXlYSmZ1MHNnUXZpSXRqM3NaeUhCTlFPaEFH?=
 =?utf-8?B?RUplblpnOEV3Qks3dEQvclhRS2FEazVnUEo5WjgxS05oWElDYkdvcFJKdGsw?=
 =?utf-8?B?TkNrSmtPaVQvTm9xenp1RGZ0L21BNE0zSTE0d1NzbXlTMkFUK2hwSFhmMjAv?=
 =?utf-8?B?Zjd0cjZtWTM4TkZJMVFkREl5aC9VRFhwUmdaMThLeThCb0Z2V0JwV09kU0Fs?=
 =?utf-8?B?YWxiaG90NkZBcEN1cjZVdVpqWjFRSWN2WnR2ZU5WY1JVS1k4czN6MDNjUjFW?=
 =?utf-8?B?VGIyNVQ1VkwxdEx2dC9Qa3U3RDZ6c1pSNzdjSldYeU51NVlMbXpEcHJTS0w5?=
 =?utf-8?B?UUQ4SjIwZnJiWk1zbkU4aTBISDRSMnA5R1pTWXJSOEtDQkNqM2hNUlA2aHNZ?=
 =?utf-8?B?bEVXdFR4S1lPZXpMczlBZjRZMU1ENWE2N0dUNTlkRWJwWURQaVVNdmN4S1hn?=
 =?utf-8?B?QU0vL25WaXEzdTJXTFIrWENXdlJwaFE0Q1lVcm9ESDNiUFZYOGs2OTl5cDFY?=
 =?utf-8?B?ckNaZFFxc3lWVVlSdDRKYTdvWWtXNEFnNjA1MTl0MHQyRU9XeFQ4YU5jTDdU?=
 =?utf-8?B?Zjc1TVVqZU9HeFp0OUdQdnlCbzZ4S1BaUzgxRGw5RVZFei9OSVZTT2l4ekxo?=
 =?utf-8?B?MFNGRjU3S2lhbmZTVjIrL1Y2eGRXQ0E4aHhjLzdrNGZQbGRnUTZvN0hCNlpX?=
 =?utf-8?Q?TiqNgScrygkjC?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c72e5c2-bcff-4424-2d9e-08df34cbd5fa
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:16:59.2809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR04MB8983
Received-SPF: pass client-ip=2a01:111:f403:d405::2;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/26/2026 10:40 AM, Wang Yechao wrote:
> BITS_TO_U64S was a private macro in migration/vmstate-types.c,
> defining the number of 64-bit words used on the wire for bitmaps.
> Move it to include/qemu/bitops.h alongside the existing
> BITS_TO_U32S so it can be shared with other code.
>
> While moving it, express the divisor with sizeof(uint64_t) instead
> of the hardcoded 64, keeping it consistent with BITS_TO_U32S. This
> is semantically equivalent.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   include/qemu/bitops.h     | 1 +
>   migration/vmstate-types.c | 3 +--
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index f7363a5479..383648fe59 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -20,6 +20,7 @@
>   #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>   #define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
>   #define BITS_TO_U32S(nr)        DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint32_t))
> +#define BITS_TO_U64S(nr)        DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint64_t))
>   
>   #define BIT(nr)                 (1UL << (nr))
>   #define BIT_ULL(nr)             (1ULL << (nr))
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index c2d4645f31..8094d76f1b 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -16,6 +16,7 @@
>   #include "migration.h"
>   #include "migration/vmstate.h"
>   #include "migration/client-options.h"
> +#include "qemu/bitops.h"
>   #include "qemu/error-report.h"
>   #include "qemu/queue.h"
>   #include "trace.h"
> @@ -596,8 +597,6 @@ const VMStateInfo vmstate_info_tmp = {
>    * bit words with the bits in big endian order. The in-memory format
>    * is an array of 'unsigned long', which may be either 32 or 64 bits.
>    */
> -/* This is the number of 64 bit words sent over the wire */
> -#define BITS_TO_U64S(nr) DIV_ROUND_UP(nr, 64)
>   static bool load_bitmap(QEMUFile *f, void *pv, size_t size,
>                           const VMStateField *field, Error **errp)
>   {

