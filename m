Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D863606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Z2lqo7vJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR4Wk-0001ZM-QO; Wed, 11 Nov 2026 04:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xR4Wi-0001Z5-Vv; Wed, 11 Nov 2026 04:21:57 -0500
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xR4Wh-0006hB-Cy; Wed, 11 Nov 2026 04:21:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pgmy9nxLoXLyLE4xxPI8E54UtT9zl9m/qJqy9bf0IyzPPscAaqjK7LsckrrCASuDCDIn3mpj7TLjjIAd6d1DWZtvwMd5a7WCdv8xOJTS3IKod1y9bVC/0+2bJ80SWmlBbod4B004GiKmdqKL0Ef8tssbxmW3AyIzXcOhywj8MrSpJDZa4XT0dPCiYYbBRFkJZvAfei8ZW3VMFXZQGk0f90dCtsRZ6C5VTXuHS54vOX8RhmaQTnF5ydbbXa4suvrxI9VOTdj7uxB01mxxJe/hlKHG0NAVSkSFywRNtao6OGBc9jL7K6NTtjBw1DEEE6DkwQDmhDUfEfhksff4u3s2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKdzWkpRwZjmjGh27M3goSW+3m5H8CBDDM/LETYDOaU=;
 b=SVsHEWQV9WDt0mL+Abx8VrBDs2rn9LW1ag9HdW+/J8Hh2wGyzqtDk7O8SIc4yNaH/ciRuSAq1s2XDoyoUsezs58Ger6El8Rh8G06DaFhJA6Ym62J8tLfgFnG5apTSk140I85y44K2KvupWWJviH+zSV4MyPPzq3TpnI/a7aERuIzmES92CaLFvwx48H/33Z9WLbF7CXd+uzCZZmFnb4yHfyXvSzSstFZhj66DoMVRTSv7qsYQ0t/oeTy8QBIY8E5PPaSNz9gyCxCCMPDq9amrYUrtH1VSvjoox3tANb8vlS6L5lquEsZx++JBeAVKQgzxTK4nXxq/Tbe96+/3p526w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKdzWkpRwZjmjGh27M3goSW+3m5H8CBDDM/LETYDOaU=;
 b=Z2lqo7vJCKtgbr4JrxgiS/oBEwI32eb394uBN5Zc/74ufXcmq8y5avoRuNxErINYCTn0TLpdYTQCMjxZEdQ2puTNAxekXJerKJxRzpaWeK10arTLbQwqiGbsR97fOxaLdkTGyUyNTy5Ysz/vuQCIe1Bwtw1k26hXs86Z93xoHv3v629V0a2Rqqia2EUjLw7GIxxOaCpF4k9o/a54tkXNPNd1B+j9ILzx0LADlO2QRm4cNv38xtg4/0VnUz2s7Mhl3uLcw9v7/AeiRezsu16+Xt6Tf7SvDezRgbezZ6YBXUUXcEXNz4iA78WaIc0OYEklFyEtClJopelb2BP/WyQXbg==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by KL1PR04MB7043.apcprd04.prod.outlook.com (2603:1096:820:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 09:21:49 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 09:21:48 +0000
Message-ID: <TYZPR04MB7491CF19F55CC2FADCBCD457F3712@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 11 Nov 2026 17:21:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] target/riscv/tcg/op_helper: avoid env_archcpu() to
 access cbom_blocksize
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 philmd@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20261111065815.167869-1-daniel.barboza@oss.qualcomm.com>
 <20261111065815.167869-2-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261111065815.167869-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0039.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::17) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <93c38335-320c-43a2-9275-420824ee0de5@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|KL1PR04MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd21c35-66ec-4dfa-061f-08df3fd535c6
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|55001999006|4140399003|19101099003|25010399006|12121999013|19110799012|8060799015|15080799012|24121999003|22091999003|41001999006|6090799003|23021999003|5072599009|51005399006|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXVOVTM2VHdOenlSYVhHbU1taDc2Vmt0cG5NeUdUSnFkZVpYNlp4djFxeFho?=
 =?utf-8?B?NzJSVURhelpMb0s2R2d2dW1FQ2tUcnVhdlE2N2gwV1lTSGRhMTF5UDlTcE83?=
 =?utf-8?B?TzJVSElDZDhjL0hIRUV1TUZXbGdYdUZoOEdsSXdXaU1pT2xmNllRNXJVZGxO?=
 =?utf-8?B?WHZ5VUQwaXdkeTBNVHRIK1ljcFRZRklMR1owcytybXVNaDFncEN6NTBCNHNp?=
 =?utf-8?B?RFZqWkZCaHcwTWVMWGtpZTBsdDlHTnFwQjFkQU5VaHo2dUJ1NDRvUjN5YXg0?=
 =?utf-8?B?V2NUTEhJbnBFcGZVc2V0RSs1VWVDS0JkQWF1NVgrT2FXM1pqOWJCRUZUNjEx?=
 =?utf-8?B?bDFWM3JxUk5rdC9PY3R4eXhadjU1VTliejNsTTBXZU5nakpwbjRPd3ZOLzRV?=
 =?utf-8?B?d0l2OFN0eEZSK09EdHFIUmdhY3NsNHZBSU9FQVBCYWZjZUNxaHNRTnVRK0Rn?=
 =?utf-8?B?L1B3UVVqYkNsVU9JMTQ1UG9MMUV2Zk5KVXNza3U5bm5mMEZHbTNDUi9XdkVk?=
 =?utf-8?B?R3pJbllUVlBOMENmV1FlSTBUT0tjSEdHZHpHclpuL0tnNTY1QUs5SnpESG5o?=
 =?utf-8?B?enE5WGVvMExMZkZYOGw4RExsYmVHclhub3F4aEUwWUlWd082dlptTjBtUmZx?=
 =?utf-8?B?MUdYaHRwRTFENkZWclFsNG5DRDI2NW11T0VwNHpvcWdOa0FscnpHdzRsRUJR?=
 =?utf-8?B?L0pHemRjUERJRXpiOE9lSnJ4SDgzOWlISXI2MjdoTnY3T24wclRPU3Jqck82?=
 =?utf-8?B?WnpqcS92d214amlOSWhURVBRNjJYWThFMnEyeE9QN0RlY2o1VGt0UldEN1oy?=
 =?utf-8?B?aDAxRERPOU95bGtNV3NlNlhHM3k2WlViT2VLdjVzL3JCVklvYXVOU1NBR1p3?=
 =?utf-8?B?QXM4dXMydEMrR1FJOW9jLyt6WWpVQktCRUNIeHpBbnlPYktwcmtqUGh0TDVo?=
 =?utf-8?B?ZWtFUkgxM2RHaG0zenExd2haMzM0OUJ3NFYvcDJ3V1NnNEQ1L2NxVjlscjUv?=
 =?utf-8?B?RUxJS0o0U0RleTd1bk9pUDlPRnBicGQ2eFNXdDA2L3hGUWh5SXNRVi9aZzFO?=
 =?utf-8?B?WnZjSHZhZ0NrUDNZMnFESkM0aHFkYitja3RZYTM4U1paOExYRUpRdXZCcW5E?=
 =?utf-8?B?ZTV2aHlRbVY2MitvM050T0hEdHkyNGdYVm9VYlNqeTRocFkvN2RFMisxRkp5?=
 =?utf-8?B?R0ppZmtEbG02ZUtGbHZRUnBTdWJ2TVZpS3dUdlVZZ0pXYnJmMXlmWWxscHh2?=
 =?utf-8?B?alNKVHFlODNtbGROR1pCUVpWbTczNE9yZWZETWdaWDFJSGF3Sm5KZHgzczJF?=
 =?utf-8?B?d1lYTDl3TFlmM2hiY2xuUFhNK2Y1aUFFbUhjU1Q4S1d3a3ZGNGlBalpabUg5?=
 =?utf-8?B?a2dMY0pKVkVTcGJtOWpQVzB0YzI1dG9SYU5ra05najdkWm5qQW5ZUGRIMzcv?=
 =?utf-8?B?Mk40MVpUZ0UyMGFhakEzTUdJblBGLzF6L3ZRNzFXY3doaGNPaWpkTzdoSFJu?=
 =?utf-8?Q?vm9qD7oAhHHTE8vYurWI0z5IdYJ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVZmUS80YlJnNHVxZ0RrYlAvWno2L1VheG94MWdUZG8rM0lFUXJUSTU3ejFI?=
 =?utf-8?B?MXp0YzlSWjYxMFRFZjJOQmR3Z2ZLckZXeW9LL0FIaFZLSFp3VXNCWUhKYzdL?=
 =?utf-8?B?VVoyam0zb05NbHc0cTU0bklJT3BIVm5oeHF3eFk1bXptZ0xueHJmOHJyR3gr?=
 =?utf-8?B?cm1CUEFxWVArMjFzdjVIbkNJaE5raVJoTWUwdnRNRVJXYVZQQmVSS0lGclRW?=
 =?utf-8?B?disxcFZOSXlYY3ZEWUtnbVl5MmFvaVplWEZucllFbHpzdStlSktyU0t3cEly?=
 =?utf-8?B?OTNhS1R0WTJrOG8zV3IzNVZWN1k0WjB2b2lnaHJUSFZZS1NDSXFhU05NMjc3?=
 =?utf-8?B?elpLOHIzeVM0Yjc2SzBjc1NiR0pOQlY5VXZHN2FvajNmUlFUMk5XeFZ4SENQ?=
 =?utf-8?B?MStPQnVHeGt5V3hKNWloaUhZQmZZYU5jL0gvcUhIK2JDRUxmclhFaFVDQjZ0?=
 =?utf-8?B?K1hVdjhtK3BabFhSWXRxQ3N2L2ppQlR6Zlowb3VOcnFRa0xCdjBLS3pzeEg3?=
 =?utf-8?B?ZjZUTllBUk1BT3FLVFphTUlGSFM1UWJzVXhkN00xNGNWNFlqN2gzSXB3UUlT?=
 =?utf-8?B?dWlKcTZ6d29DNlpaeStrL3I3OEpZVjh0SlVsNFE0UHp5MXp3VUwvdDZuZ0Mv?=
 =?utf-8?B?RURpeDQ2RnZoY3NmTHdDMWtzNDJVVEZSQ0RTYVVsclp0L1VBSWtlay9YQlVv?=
 =?utf-8?B?OGxibUx2Y2RFbmNmSENzbFhNSlB4elZtSzBMQlR0UlBNSDc2b3BCNm9nQ1Zx?=
 =?utf-8?B?T2J2dUQ0VnFDNTg1bzVmUEUzaGlSdDVXTUI1aFlPOTJmcEo3UmlPMG9ORC9G?=
 =?utf-8?B?dk1tZkcvcDdiWkUrVHJQTllXUGs4SHRNNjdDNHRyd2lWdk93NmVTeFNxM2hT?=
 =?utf-8?B?NnVyWUlhTFBvQml0ZmYvakZyQi9IdTdVUFBzMEFNbjIyTEtKeFQzSUdENm9Z?=
 =?utf-8?B?cmp5djcraFVBRTArWG41bXJ4d1JESzdXdlkzbFFydlJVRUdKWDdjZXd2cGJV?=
 =?utf-8?B?L0FVcDFMdDA0dXdPYnZORGxUS3pJdVJENyswMWlBaTFBMnk0TkV0L2NhZ241?=
 =?utf-8?B?WWlHUHljNEphK3lkYmpNMFFFRFFGUVdlQThtRUExZnJzWXQ0RWtESk4yc3hZ?=
 =?utf-8?B?cyt1Y3Y1YStuQm85VWRTRGlyNi9Pd0Y5NXpKcFZTWm5WYzI2S2VTTUxYV2xC?=
 =?utf-8?B?Z3NaZkliU1krNzZlN1RhV0lidVc5MXdqa2dQa0o5dlZNNElsWHFZekkrQllw?=
 =?utf-8?B?a05DS1htTGpLMXdoUkRrOHZ4d1RmbVdFb2hqcTF3Z3R6ZVBBdlI4NmJWRnFP?=
 =?utf-8?B?NW1Yc1hJSnRRc0lkZGEvNWtyZmpOalkrWHVncEFjMmh4RmdMSy8vZnQ4TWJ3?=
 =?utf-8?B?NVdZMHRqQWp2cjZiY3A5TVVPbG4wRnhYWnM5djRyS0s4OW5hZCtxZjY1Q0Z5?=
 =?utf-8?B?WnlOU1RBcGJXTU5BSHF5RzFOMVFqcDJma09BVFFsbmpSQmJCVnRqMUJKKzEz?=
 =?utf-8?B?V2hUUnNrcFQzbDRPdWhSbkNJZFByYU9JZ251TFBiaml2WjVSSEs0TTcxM1U1?=
 =?utf-8?B?T1VJcHBjU0MxeXpZT1Z6eUFWQ1dSNEdqZDY4TGVCVWFLdDdmRS9ObU1UM0VX?=
 =?utf-8?B?ZjNCb3RMSllZd1hCdXdiMGxVUHBCUWR4TEpiMjlNendEM3NhSlRIT1JhOEE3?=
 =?utf-8?B?ZW5Wcmx1ckR6Wmc4cTBJM1lrdWY3eDZmcTh6T1lhTzNkVld6aHpvUEM2aHB6?=
 =?utf-8?B?VmdDbGtYOFFxbCtVN2dtOHE5blU5aFQvQThjcExzTEVaaVBocmlDdVJiYTU2?=
 =?utf-8?B?SGI0NHc1RWNaOXdOUmR6VzU5ajBJS3NuUTNWMVE4Y0dGUEF3SlVPVjhmdk9F?=
 =?utf-8?Q?f6chNJUl+tdKp?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd21c35-66ec-4dfa-061f-08df3fd535c6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:21:48.0214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7043
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/11/2026 2:58 PM, Daniel Henrique Barboza wrote:
> There is no other use for the RISCVCPU* pointer aside from accessing
> cpu->cfg.  Use the riscv_cpu_cfg(env) inline to retrieve
> cfg.cbom_blocksize instead.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/tcg/op_helper.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index f9c79fe6b9..d7af56ef61 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -229,9 +229,8 @@ static void check_zicbom_access(CPURISCVState *env,
>                                   target_ulong address,
>                                   uintptr_t ra)
>   {
> -    RISCVCPU *cpu = env_archcpu(env);
> +    uint16_t cbomlen = riscv_cpu_cfg(env)->cbom_blocksize;
>       int mmu_idx = riscv_env_mmu_index(env, false);
> -    uint16_t cbomlen = cpu->cfg.cbom_blocksize;
>       void *phost;
>       int ret;
>   

