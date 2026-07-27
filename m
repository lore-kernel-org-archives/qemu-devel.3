Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BFDC531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woEax-0004WS-J8; Mon, 27 Jul 2026 02:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1woEav-0004V4-Qg; Mon, 27 Jul 2026 02:13:45 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1woEas-0006qf-U7; Mon, 27 Jul 2026 02:13:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lP8f8PzGrnkaVOgqpqaU1xybdflA8hJ7o6RE3u+4mqae9QYZk8HBHIBA8GHiOrayNxMv6CUVNFOKjFm9PG9E45VA1u05kC+jN16E/ecfKCZTnggDcNf8TIpw/yH7z0EpbeHbiHa0VSJmwvR4LZVTTk/i3sbEc7Lcon8A0s8dMY0SSyqAmMDZQpaP0WUhZ8S+QhykWinePmX9S0FO10oUtlv0LkADvopFKxdyhw6aLg0oo0BUfD0T8AfpHsGJbTEI7+949dritRbPiXZKyAFIw0BIfBrZqZIzfRLx7MB40tfOowKwRc38+P5XVZLjShKEkAUXTz6PnN/ry+8o0fg33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRQiOLDF/G2Cw5jKkxiPIiLnT02t7NoIoZ0+8hlGxeQ=;
 b=YdIao6hk+NPcfB8MImdBNFpe55vfX3Ppkh8mstDKF/zIuOmEOFxJoe+61u6scrv8W4Juz4cRZIfnE/GIFqsQ+l74FFadu/81werSvPXuEDGw6qGtcpmvk+is5MFJi/Nn6NMpPvfVEcsKSuHoP2243YfNJEqJcypqHFisY5uDW4pdWN7br2e+5Pg7zilL3PZG7bMBrq/Q7hX/x7Xry5ZR4YhzifhcU8Ual2ABNL/taF/L7O1moaggAP2QZId9XT5/e+890qt10SPZ4OGpEPHSeZfl0vGRpt/rJdJFahchzX3koZr4OPkSTYSxrqy0w1GygqloAoj7loWHJh1hmH94Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRQiOLDF/G2Cw5jKkxiPIiLnT02t7NoIoZ0+8hlGxeQ=;
 b=jHu0bYmYktTyx9dVuPiE14SrxVIGdKblRN9WI3KhmHTJzzr+yBxXvi06g00qVzWXhECFuN4Za1F3Z8Fju4Gx0V6G4DMDGJC2RKQX8fS/gF0rstew59zrgazfPAwwhSm2G0m/Z3TpLWsk6j4llGARnKOcpBnaH6Pj63r9xDuaDVqhbmgl5tiprmMgU291KD21PRWHasiIxOLypYgb+URkB0YtLFqGkSeJCchBdpyfk7M07D4qrGzwl1pOhPGSBaJ5MJ8azC3XzHwaaU2Gt2MrxMmuuxXs/WgkSXEqD4+Y9RmXM226TQm3hqYXBA1dCgT8ZUcDyN/IKWsecnMij1FNtQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TY1PPF253818BB5.apcprd04.prod.outlook.com (2603:1096:408::a8f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.9; Mon, 27 Jul
 2026 06:13:35 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0270.006; Mon, 27 Jul 2026
 06:13:35 +0000
Message-ID: <SE3PR04MB892241436DB20CF5111ED982F3CC2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 27 Jul 2026 14:13:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/18] target/riscv: Add packed SIMD extension state
To: Molly Chen <xiaoou@iscas.ac.cn>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Yin Zhang <zhangyin2018@iscas.ac.cn>,
 Dajun Huang <djhuang_1@std.uestc.edu.cn>,
 Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <8b602c084875d5d5517958ffa3a25651c0bb41c1.1784280142.git.xiaoou@iscas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <8b602c084875d5d5517958ffa3a25651c0bb41c1.1784280142.git.xiaoou@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <124f61b0-5527-4bb3-82d2-593dc44ff746@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TY1PPF253818BB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 51896f30-378f-4033-da39-08deeba630be
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19101099003|55001999006|8060799015|12121999013|41001999006|6090799003|19110799012|5072599009|24121999003|23021999003|22091999003|25010399006|15080799012|4140399003|10035399007|53005399003|40105399003|26121999007|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzRUb1NZWTJlcDVrOHVHRG9NdWVSb2laa2dOejdJRmJBUkllWUZvbFJWQXJM?=
 =?utf-8?B?UmhZcmZwdUc0Vmx0Yjg3Nm9PMEhPN3BRRjgvb2x5cXpjM3pqNlBoWENqNHdz?=
 =?utf-8?B?ZEdkOVcyNmMrOG5KejNTbytrbU9DY2IxUytrL2dMSnBDNnVOTWpZMFF0MGxW?=
 =?utf-8?B?aFJIaEYySDFvNlZ2bnBTMWl5T2lQWnhOUEUxRGpxazI2OHdTdGtWQlJraWgz?=
 =?utf-8?B?REdLN2s0SEk0QzJISmxHYy8vMGZjR2JNZ3FiRDNwcTlqL3BaV1lLL3pIemZa?=
 =?utf-8?B?YXF4bjFLRnd1RTZaV0FNUFg0Z28vZmY2Nm1ZVzNjZVlLbFBiTlRhek9uZDUx?=
 =?utf-8?B?SUV2aWx4M1FzZGR0dWozU015TTd0c0ZVVmNUbCtnY05GZyt3dU52UzJkOTZh?=
 =?utf-8?B?YXRTTmY0RXpabS91MDluRmYwd2ZqK3hVQ0Rnd2NxNldWQkJuMmMvU3pXYjlo?=
 =?utf-8?B?bGxGRXpkRVRZSm1lT2k4OHJjZG9zY2hIdktWdUs4MllFQXNRREUvcTZFamtj?=
 =?utf-8?B?amFPRWlURGdPRjNlaWwrdmxEQWtMTjF1ejVZR0I0T3UwOXZva0V5UTJwRjU3?=
 =?utf-8?B?V052ZXY4dkUvbFR1amFUdEFaZkM5c3ZVN1FxYktldm5ZSmkzOU5VZUdWWmV0?=
 =?utf-8?B?VURlVjUwSXhSL2NVdlRlMHczREtpZDVBUDV6ZU9hWG4wQ3Z6UXNDNVVCWW9J?=
 =?utf-8?B?STdFcUxBcHk4SWVOUy83eE1LdUJhUXlnVENmbnloTm9PQ1M3TWNYTDgzTFpF?=
 =?utf-8?B?cU5halJhMXk4Mm1ieCtHNEc3ZW1kU0lQcXBMQ2pZS3IyQW1jNG1GM3E3WWpK?=
 =?utf-8?B?a2JFNjczVWE4QmJ1R2RjVDRjb0d4clAyRWt2RGNKQmxHTVVuZFZ4TlpDRnhS?=
 =?utf-8?B?QXRpTnNuMHlVem9nV3M3L0lRVFdFc3RTa0JOajk3d3Buc3JaSlY4YjJMcXdF?=
 =?utf-8?B?bW5VZ0xIRXUzMk0vV1ZiUWZBM1VKSEVjYXFhNlVRaXpad3F4M05DZVVCQVNO?=
 =?utf-8?B?ajF0dllHd0VScEw5bTA4QjRhcCttdkhtZnlsVG5xV3NOVHdVOUFiTE5zTjVO?=
 =?utf-8?B?eGEzZXRPTnVxd0UyZXRIaE42ZW9QZnlNOHk1b2ZZYVFDOU5sWWtUZkVPTE1t?=
 =?utf-8?B?NGVXeCs4bU1lU1NpTnpsbGxsZTAzVkUxdkkzRmNvRlR6d0FpT28wTGNWSDJ2?=
 =?utf-8?B?RnNDSlJpcFYrT3FUUWZIWlFNOTNCQmgrcWg0ZkUwOHFlRDZlYnlKL3huWjN5?=
 =?utf-8?B?cXRJSHVzRGVHMnB4RGpoUGc4a24rK1BFdU5KYWJmNklYYnhmTytGTnlrYUNC?=
 =?utf-8?B?ZVRka0l4T2VBSXJnT1Roa1RieUMzNGV2UlhvZWp2bWN2YWp6TE85ek84eHB3?=
 =?utf-8?B?VllEOXNnRDg5Tzl3dElkRGErMFNtbXRmbFRWUmpsTFJNQ2RBNm9IRVNOTGVt?=
 =?utf-8?B?REVhRDlFYW9GbDFiV1FCN00xRTQwYzgvNzlCMW9wZm9EYmdFWFo2c3ltRUNP?=
 =?utf-8?Q?oTwPGPUxQ9r/AWcLepi1L7wDXZt?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXJIaUhwQnhQQng2NEorK1Jocmh0WDErU2NOQitxM1VOQkEzZXFUMllGeDB0?=
 =?utf-8?B?S0ZiVWlyNHJDWTVpWkllc1pySTQzbkFtd3FhUUtscDJ5cFVqT2dZVVpMWm00?=
 =?utf-8?B?NDNFTDBySFhNemRGUHRYRmxZVjdiYmtCYzUyZnEwbzRwbFd2c0Z5QXA1MDZv?=
 =?utf-8?B?Unl3MVNZd3M0TU5ZbHUxWHJQaVI5M2dQdUdlVFQ3L01lVkdZQTV1RkpoSDg4?=
 =?utf-8?B?Vlk4ZFc4S0Ewbzltak9xZitvMW8yRVBpYjlBdU5MaWswQTlROGdjMXZQOEsx?=
 =?utf-8?B?YWxWQ0FxM2twMGtCR2N1TExleEVyVUdXLzlTRWlMdm1IZHlpOWJ6MjNVeFQ2?=
 =?utf-8?B?Zms0MUtnTU9rTWtzbnR0WmJselFZSGpnakEvTk9WYjdpdGR3V3NVSEpBVmwy?=
 =?utf-8?B?Q0tWcTIwNEhrK1Vwa29ack9lSm5IQ2ZxYlBaSDI3dmdrU2dyZDN0VStlWGZU?=
 =?utf-8?B?WFB6UzhmR2t2TkJ6cUtESGxGM2h3ZVhzblRxOTVCeHIySWxrRWZEZkZ6dmdL?=
 =?utf-8?B?dC9GbjcxRENCMlk0UGtDa2Zjc3pJSzRZU3pvR0FsNUJmWTEvdjluOXpBS2cv?=
 =?utf-8?B?dGdRSnJncjYwdSs2QTVQSFFZdDhOa3FWb3ZBK0RlUjA1d3JEUzNldkJZZU00?=
 =?utf-8?B?bUo2MklQbFBSRFdkMC84MEZGT1RlQy80R0JWLytUa3QyS1FBVXlZbTJRd1Ns?=
 =?utf-8?B?cGZqSnRSQUYxZDdGYjh5eThUbFRqVm9rVVNOd3N6NTZJeS9sSDVWR25aODJy?=
 =?utf-8?B?K0tXZGI0YzdOZ1A0UitPU0d6dW5qaWRLZkZQY2RPUTVDTUlSQk1MTjlvK1Qv?=
 =?utf-8?B?eVhBd296SVRnd2UrcnFtTHZHZCtXbDVzNjB5ZUFvOTBYMTRXVG1wODlJaXgv?=
 =?utf-8?B?U2JrRDA3blVSblRnY1NnRkFxR2pPR3c1VHE2UzJyV2lJS2JDY2RlNVJUQ09I?=
 =?utf-8?B?OGdSMTdKRks4eG9PS1NsZVBJRi9xVHEraTBic1pnUHhIY3paU0FZMlpUcVor?=
 =?utf-8?B?T0QzS2xJWnJjYlA4Zi9ZSVBVcXR1R2p6SW1CMmxocjRDY0ZtTWJhZUtuN3M2?=
 =?utf-8?B?SVhIWUpCQzU2Z01JU1p1b21wVEZ3TzhSdXlyRC9LTjNHZDBlVVFYMnVkNEJ1?=
 =?utf-8?B?RExrd0toT2k4b2UvMm9nMkFuWGRFdk9uRnhzTDlhaSt2QkZ6eE81cW43SlJT?=
 =?utf-8?B?c2Q5dmZQVG5nb3JRclRmNVNoLzVNTndldGFIeE9nR2poQTI1ZCtCZTdQa094?=
 =?utf-8?B?d09sUUhpc01wdnhvMUdDRWNnMFppSXhncGwxeWNGMHp4c2JiaU9vTTdES0Ex?=
 =?utf-8?B?VUZYSTFaaGVSaXRtckRvZDlLbHNzbVpodndqTis2YTNIUVR6NFpiQ2JQRHBF?=
 =?utf-8?B?VnR6MEVBOVRtZGNTRVBMTjB5SHYySVF1U1JWWjRNYlhxSll4UGRoZUFrc05w?=
 =?utf-8?B?aWZydUM1YWcwTjB2MTlSK0RUaFVFa3dBbDZGdlZtcC9hZTgrb1Z5dlZqZEJt?=
 =?utf-8?B?MzhFVVJVTUc2U3BIOTN0dDVtL1RLc2h0MDRrWHI3dW9kQVZHcUxTQlFrYnE2?=
 =?utf-8?B?TlBjVkFDWk5Zbzg3akU5VGR5MXRtbXNSZldFalhnSHl2S0srOS83VzYxeXVs?=
 =?utf-8?B?d3gxM0k3RXBnZHBmOEdPRmtoanFVeE1SVjgzeHFJZmlIWEhSYWJSdDE4aTlt?=
 =?utf-8?B?UDFNbU1nbEVZRDRYUE11cE4ydmtIVTN0UDFWZlpJclNFWnJLRnRnek5TVm4r?=
 =?utf-8?B?ZE9FRUx5M3NnR3dFZllRZHNXeVY4V1MramQxT2hqSjRxcHBLYmpjK3pKWWRw?=
 =?utf-8?B?aGhJOVlnbFYxejJZczQzckkxUjVrZUdXMUpwSXEwd2RabG0xdFAxUnJyM2dQ?=
 =?utf-8?Q?qOl4VpOdLnvuQ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 51896f30-378f-4033-da39-08deeba630be
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:13:35.5478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF253818BB5
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 7/17/2026 6:06 PM, Molly Chen wrote:
> Model vxsat with separate Vector/Zve and P-only control paths.  When
> Zve* is present, vxsat follows mstatus.VS/vsstatus.VS; when P is
> implemented without Zve*, stateen0.VXSAT controls access instead.
>
> Record the P-only stateen result in TB flags so cached translations
> preserve both instruction legality and the illegal-vs-virtual exception
> class.
>
> Co-authored-by: Yin Zhang <zhangyin2018@iscas.ac.cn>
> Co-authored-by: Dajun Huang <djhuang_1@std.uestc.edu.cn>
> Co-authored-by: Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
>
> Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/cpu.c         |  5 ++--
>   target/riscv/cpu.h         |  8 +++++++
>   target/riscv/cpu_bits.h    |  2 ++
>   target/riscv/machine.c     | 19 +++++++++++++++
>   target/riscv/tcg/csr.c     | 39 +++++++++++++++++++++++++++++--
>   target/riscv/tcg/tcg-cpu.c | 48 ++++++++++++++++++++++++++++++++++++++
>   6 files changed, 117 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a82e6563bf..c9e6c83a491 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -46,7 +46,7 @@
>   /* RISC-V CPU definitions */
>   static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
>   const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
> -                              RVC, RVS, RVU, RVH, RVG, RVB, 0};
> +                              RVC, RVS, RVU, RVH, RVG, RVB, RVP, 0};
>   #define RISCV_CPU_MVENDORID 0
>   #define RISCV_CPU_MIMPID 0
>   /*
> @@ -1489,7 +1489,8 @@ static const MISAExtInfo misa_ext_info_arr[] = {
>       MISA_EXT_INFO(RVH, "h", "Hypervisor"),
>       MISA_EXT_INFO(RVV, "v", "Vector operations"),
>       MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
> -    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
> +    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)"),
> +    MISA_EXT_INFO(RVP, "x-p", "Packed-SIMD instructions")
>   };
>   
>   static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c9dfa7daff2..75cfb16d846 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -70,6 +70,7 @@ typedef struct CPUArchState CPURISCVState;
>   #define RVG RV('G')
>   #define RVB RV('B')
>   #define RVX RV('X')
> +#define RVP RV('P')
>   
>   extern const uint32_t misa_bits[];
>   const char *riscv_get_misa_ext_name(uint32_t bit);
> @@ -742,6 +743,13 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
>   FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
>   FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
>   FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
> +FIELD(EXT_TB_FLAGS, P_VXSAT_EXCP, 34, 2)
> +
> +enum {
> +    P_VXSAT_EXCP_NONE,
> +    P_VXSAT_EXCP_ILLEGAL,
> +    P_VXSAT_EXCP_VIRTUAL,
> +};
>   
>   #ifdef TARGET_RISCV32
>   #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 3f146a43fe4..fa7bf60f4fc 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -355,6 +355,8 @@
>   #define SMSTATEEN0_CS       (1ULL << 0)
>   #define SMSTATEEN0_FCSR     (1ULL << 1)
>   #define SMSTATEEN0_JVT      (1ULL << 2)
> +/* Packed-SIMD draft: enable access to vxsat when misa.V = 0. */
> +#define SMSTATEEN0_VXSAT    (1ULL << 3)
>   #define SMSTATEEN0_CTR      (1ULL << 54)
>   #define SMSTATEEN0_P1P13    (1ULL << 56)
>   #define SMSTATEEN0_HSCONTXT (1ULL << 57)
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 0ab613a2980..a9cd7e4c1cc 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -158,6 +158,24 @@ static const VMStateDescription vmstate_vector = {
>       }
>   };
>   
> +static bool p_vxsat_needed(void *opaque)
> +{
> +    RISCVCPU *cpu = opaque;
> +
> +    return riscv_has_ext(&cpu->env, RVP) && !cpu->cfg.ext_zve32x;
> +}
> +
> +static const VMStateDescription vmstate_p_vxsat = {
> +    .name = "cpu/p-vxsat",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = p_vxsat_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8(env.vxsat, RISCVCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static bool pointermasking_needed(void *opaque)
>   {
>       return false;
> @@ -518,6 +536,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           &vmstate_pmp,
>           &vmstate_hyper,
>           &vmstate_vector,
> +        &vmstate_p_vxsat,
>           &vmstate_pointermasking,
>           &vmstate_rv128,
>   #ifdef CONFIG_KVM
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc56..e809997f52e 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -109,6 +109,24 @@ static RISCVException vs(CPURISCVState *env, int csrno)
>       return RISCV_EXCP_ILLEGAL_INST;
>   }
>   
> +/* vxsat is also architectural state when P is implemented without Zve*. */
> +static RISCVException vxsat(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_cfg(env)->ext_zve32x) {
> +        return vs(env, csrno);
> +    }
> +
> +    if (riscv_has_ext(env, RVP)) {
> +#if !defined(CONFIG_USER_ONLY)
> +        return smstateen_acc_ok(env, 0, SMSTATEEN0_VXSAT);
> +#else
> +        return RISCV_EXCP_NONE;
> +#endif
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
> +
>   static RISCVException ctr(CPURISCVState *env, int csrno)
>   {
>   #if !defined(CONFIG_USER_ONLY)
> @@ -1013,7 +1031,12 @@ static RISCVException write_vxsat(CPURISCVState *env, int csrno,
>                                     target_ulong val, uintptr_t ra)
>   {
>   #if !defined(CONFIG_USER_ONLY)
> -    env->mstatus |= MSTATUS_VS;
> +    if (riscv_cpu_cfg(env)->ext_zve32x) {
> +        env->mstatus |= MSTATUS_VS;
> +        if (env->virt_enabled) {
> +            env->mstatus_hs |= MSTATUS_VS;
> +        }
> +    }
>   #endif
>       env->vxsat = val & BIT(0);
>       return RISCV_EXCP_NONE;
> @@ -3494,6 +3517,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
>                                         target_ulong new_val, uintptr_t ra)
>   {
>       uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
> +
> +    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
> +        wr_mask |= SMSTATEEN0_VXSAT;
> +    }
>       if (!riscv_has_ext(env, RVF)) {
>           wr_mask |= SMSTATEEN0_FCSR;
>       }
> @@ -3617,6 +3644,10 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
>   {
>       uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>   
> +    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
> +        wr_mask |= SMSTATEEN0_VXSAT;
> +    }
> +
>       if (!riscv_has_ext(env, RVF)) {
>           wr_mask |= SMSTATEEN0_FCSR;
>       }
> @@ -3746,6 +3777,10 @@ static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
>   {
>       uint64_t wr_mask = 0;
>   
> +    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
> +        wr_mask |= SMSTATEEN0_VXSAT;
> +    }
> +
>       if (!riscv_has_ext(env, RVF)) {
>           wr_mask |= SMSTATEEN0_FCSR;
>       }
> @@ -5916,7 +5951,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_FCSR]     = { "fcsr",     fs,     read_fcsr,    write_fcsr   },
>       /* Vector CSRs */
>       [CSR_VSTART]   = { "vstart",   vs,     read_vstart,  write_vstart },
> -    [CSR_VXSAT]    = { "vxsat",    vs,     read_vxsat,   write_vxsat  },
> +    [CSR_VXSAT]    = { "vxsat",    vxsat,  read_vxsat,   write_vxsat  },
>       [CSR_VXRM]     = { "vxrm",     vs,     read_vxrm,    write_vxrm   },
>       [CSR_VCSR]     = { "vcsr",     vs,     read_vcsr,    write_vcsr   },
>       [CSR_VL]       = { "vl",       vs,     read_vl                    },
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 4af5cd9c731..1665583accf 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -160,6 +160,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>       fs = EXT_STATUS_DIRTY;
>       vs = EXT_STATUS_DIRTY;
>   #else
> +    RISCVException p_vxsat_excp;
> +
>       flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
>   
>       flags |= riscv_env_mmu_index(env, 0);
> @@ -182,6 +184,23 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>                ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
>       }
>   
> +    /*
> +     * Without Zve*, all P instructions in the OP-32 and OP-IMM-32
> +     * spaces are controlled by stateen0.VXSAT.  Preserve the exception
> +     * class in the TB flags so translated code can distinguish an illegal
> +     * instruction from a virtual-instruction exception.
> +     */
> +    p_vxsat_excp = smstateen_acc_ok(env, 0, SMSTATEEN0_VXSAT);
> +    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
> +        if (p_vxsat_excp == RISCV_EXCP_VIRT_INSTRUCTION_FAULT) {
> +            ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, P_VXSAT_EXCP,
> +                                   P_VXSAT_EXCP_VIRTUAL);
> +        } else if (p_vxsat_excp != RISCV_EXCP_NONE) {
> +            ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, P_VXSAT_EXCP,
> +                                   P_VXSAT_EXCP_ILLEGAL);
> +        }
> +    }
> +
>       if (cpu->cfg.debug && !icount_enabled()) {
>           flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
>       }
> @@ -530,6 +549,28 @@ static void riscv_cpu_validate_b(RISCVCPU *cpu)
>       }
>   }
>   
> +static void riscv_cpu_validate_p(RISCVCPU *cpu, Error **errp)
> +{
> +    CPURISCVState *env = &cpu->env;
> +
> +    if (!riscv_has_ext(env, RVP)) {
> +        return;
> +    }
> +
> +    if (riscv_cpu_mxl(env) != MXL_RV32 &&
> +        riscv_cpu_mxl(env) != MXL_RV64) {
> +        error_setg(errp, "P extension requires RV32 or RV64");
> +        return;
> +    }
> +
> +    if (!(cpu->cfg.ext_zmmul && cpu->cfg.ext_zba && cpu->cfg.ext_zbb &&
> +          cpu->cfg.ext_zbkb)) {
> +        error_setg(errp, "P extension requires zmmul, zba, zbb and zbkb "
> +                         "extensions");
> +        return;
> +    }
> +}
> +
>   /*
>    * Check consistency between chosen extensions while setting
>    * cpu->cfg accordingly.
> @@ -612,6 +653,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    riscv_cpu_validate_p(cpu, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>       riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
>       if (local_err != NULL) {
>           error_propagate(errp, local_err);
> @@ -1414,6 +1461,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
>       MISA_CFG(RVV, false),
>       MISA_CFG(RVG, false),
>       MISA_CFG(RVB, false),
> +    MISA_CFG(RVP, false),
>   };
>   
>   /*

