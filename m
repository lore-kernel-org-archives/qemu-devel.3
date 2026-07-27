Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0672EC531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 04:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woCgk-00082f-9L; Mon, 27 Jul 2026 00:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1woCgc-00082F-7F; Mon, 27 Jul 2026 00:11:30 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1woCga-0002L6-56; Mon, 27 Jul 2026 00:11:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymze3Z/TNuOOB0NhFUYGLp2wVRQHn7FtKIABi9cdL61MZroWP8folUCPTD5qbhJDHXRzgJ2PqtmYgnjxC8I11N3rUsnSqJRhQvvfL5UIe5yErDvR2xohPqtH7o2zjfEdxqTtb10XF6atx4IlwZM+3rfbcWNvJUn/Fy2Wa2kY++oDtTTBB3R4Cwud990o6lpql5R0Tc91hPfEyvXCOdscQqDAMsnwzPscM4ES4NfoaWMukihcoJR1CZnA0VlxgFPPj/d1vX5xMz6vwYic5i6lyknVoVYVuNDQbkg54n6Pk2roMcIF2yzIhPkv39iTpcF/B0gk6XZEsIrRpEzkqhQWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lvV5mHyxdHJeIncgPRVLz4Lk5uX/AW9jt96GtCo3MY=;
 b=iUzymSXuUp1PKu0VeFXMPemMhgJkXfJvfqJ5cpbysgPZKggx2msgMdghQnM7xZItYnGhy1Aa/PXgEBjcA0uEXEQbtOS1XjyIwPTFHtkFujHbpag7dRhyEFCLeGVhBdp+jU4hlVu9X5ZatPtpudmikTwabZVGuc0hNrooy0UvPuefFBxgyZonzPsuXWH4Bh4uHTo3JokOGZetTNTcrZFP9FgXgGMzsaDDGNRh55oF4fXmUNx8zaCnIPJk4uooOg39W8vN0F7E+ekGoo649mRzM4+aOXGzBh5RZOAmcWd7CTkQkXrtZmFaojzWdzKFHKr6sPn7jvPn6ZEEJqVHrDOpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lvV5mHyxdHJeIncgPRVLz4Lk5uX/AW9jt96GtCo3MY=;
 b=f0Yoj6qHMSyPYw225GdAZz8rQ+52lLoDUKcVV8sTjbewUNZNcRCtoC7MJxk4O+cLMEkP2RqJTcBIrA0TDnhnHTCdfAbq37a2vPrywfbzs7ZJcUFdtHZjOhZSyB+4vURxNyUFpNb0bU5lCecomhuXIIQS8Bwtf08kzAea/xVesOe3xmdvDUU3DymiXjsRl1GPCZuU802oQ6W5t/5EZe/WaUtRxEAO3yWGRTK6KMzoUwZS/p9KDEKf+3BHgfp1NSt8DO5BrGcidtIriElQ3PnGGbg5PUwatrZSkJmOKSR75yooXYRiaQ+BvPMgvnwmMsSHA4NumJr6Nlubfj8LMf75Lg==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SEZPR04MB8114.apcprd04.prod.outlook.com (2603:1096:101:24f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.9; Mon, 27 Jul
 2026 04:11:15 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0270.006; Mon, 27 Jul 2026
 04:11:13 +0000
Message-ID: <SE3PR04MB89223E16CC5CF2E41E74EF25F3CC2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 27 Jul 2026 12:11:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/misc/iommu-testdev: support PCI MSI test writes
To: flavien.solt97@gmail.com, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
References: <CANVUYGvOyZdCwXOtDkS7bXY3Z2HGK1b6QWKttCVUjhnpH65g5A@mail.gmail.com>
 <CANVUYGu7QKOa5t52yQnBc4U0zQxP2doTDR7BRGR65z+vJw7zRg@mail.gmail.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <CANVUYGu7QKOa5t52yQnBc4U0zQxP2doTDR7BRGR65z+vJw7zRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::13) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <e5933a45-96c6-4f3e-973a-ae53743f81dc@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SEZPR04MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a165517-ea33-4c7f-298e-08deeb951880
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|55001999006|15080799012|51005399006|19101099003|22091999003|24121999003|41001999006|6090799003|19110799012|8060799015|5072599009|25010399006|4140399003|23021999003|40105399003|26121999007|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUp2alJCTWpYSHo2U1RrdnRrQWFKS0tkZGdiK1EvWVpXNjZJcUsvbU12aDVC?=
 =?utf-8?B?elI0ZUxoNnU5dnhVTmREY2xhR2FTaUlFVUoxUHd0cmFqcmpWNWUyL1pOM2lk?=
 =?utf-8?B?Ni9OS2F2UmFvMWJpaHIyeXpLRm5LTlJianVudytWRXdreGUwdkpmZU1kQTlk?=
 =?utf-8?B?RHdSK2x1WDlKcU1TdG5IYnpHcVpVU2w4MEJIb09taVdIQjkrZUxTSmpQbGxK?=
 =?utf-8?B?VmpQVCtaUVRwQ0hlSGVPMTQrU3dpZkJ3RGJKc2NHdVRDWmNDajRrOEl3cjYw?=
 =?utf-8?B?cGJGbFRMWlBRY2JDUlE3Q2U3ck5oTjVFYmVBUm56ZHdkbzkwbi9RK0JTTUhk?=
 =?utf-8?B?MWxLWk52M3M4cjVqcUtRL2FENzc0VTBqU3U0ZXVYNjY5eEFhS25jbWRtZEtj?=
 =?utf-8?B?QWZxdDNlTUtBME44bzhGNUtzdUNjUlBuSHFFUGlzUmNTd2l5eUdyOWt6ekRx?=
 =?utf-8?B?TWRid29VbkxtWFh4MSsrK3hSMjhsTXE4bGE1T1JTUDdwY3NGdjE3M3lwcjZU?=
 =?utf-8?B?NkJjQ3diTzVvczc2V2xOZ3ZlVDlKeUFmRWZxd0ovZUFxWUFaeENDRHpuUzVC?=
 =?utf-8?B?WU5UZ1ZQcS9kQ3VFcEZtYjk1QnRCUnc5VWpNZU14ZFBPTjY4a2o3ekMzZ0VN?=
 =?utf-8?B?TnAwUzdFeU83VmxUMU9TaHVaa3MwNTNNT0FBYWhJbGFQdXZZdWhqaVowb0FG?=
 =?utf-8?B?Zi9KaU5tQ0QzSURqZVpsZmRXbUNURXg5a3BGbDZnd0hjM3J4Y2xGTUNRY0xx?=
 =?utf-8?B?OHl1T2lSYXNyQ1JmK1k4TzJjVVhKdVgvSzhSbHlvWWwyOWZ6QWtOVFlKNGNw?=
 =?utf-8?B?K0owL2JQSmE3bndXNGN4SU80dWtGK0I5SEVMTWpGM0dzYXFWM2xuSldMT3d4?=
 =?utf-8?B?eWpEdTI2dm9hMzlQcGxSc1J3WGk2aWZ6VDdEdDNkTEZpaS9IcEtQa0ZLbDZ3?=
 =?utf-8?B?TUNCMUdkUXRSdVlIcitkRkIrNFhWenBqWE1iQ3NqYlJrc3NJK0w1V2N6cnAx?=
 =?utf-8?B?VlFhVzJ3WTFKUTk2aG1tbVhkeE9tRVpLakFzSTdFOGh5MU5GWFh6ODBFSEt4?=
 =?utf-8?B?amRaWE9pMlhyRXoxWTczWDFtaVllNDlIVEs3QXR0R3QrbzZ0LzVwWWlpTDRI?=
 =?utf-8?B?VlhlbG01d1hXbWJGWitjbWlEejVDZktpcVFvcFFxL1A5MWlJN2VrL3YxTTBH?=
 =?utf-8?B?U2dxVm9MQ0NaUVZLZnZyM0dMYmVadUJYS0tadk1rTGtSeWlHb1FDVXlhdFdh?=
 =?utf-8?B?SmZFV3NveXRaa3d1bTI0cmt1RlAzYVNEcjF4cCtMTjc2RFZDWnp2STZQS1Nw?=
 =?utf-8?B?YnBKaXJrdllpZll3SXkzcjF1UldseDBwR0VyTWdvUTFjTXRhUGxvRkVUMXB6?=
 =?utf-8?B?L1kxMjNhUCtkSVFDMUhFMlRaRkRyd01KNjQ0VHVMdGNISDVnNFYwdjhxVElz?=
 =?utf-8?B?bHlqQ2tEeXpZZDEyQW1oeDM1OFp6UG9UYlM2dHVUVTB1NUlBUE9NZTNPWnpG?=
 =?utf-8?Q?gYKUgMnt45GxVwQ/3sAFXSmg8kv?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFdPa0tYWFhWcTV0VlRMMUdjd2VWbG8vS2RVeDFhV00rT0tnSzZTRUh1cFdp?=
 =?utf-8?B?QS9kYTMrTi9yQU16aUFRUGF1SGpEOGd5VElGbHVIUC8vSEFlWEJQaUlEaGJO?=
 =?utf-8?B?bjhjdHpkOE1DL1V0VzZMWWdWMG13eGFWUjdjeGVKaFBreEZlRFJ3RURlWHBT?=
 =?utf-8?B?MmpOR0cydTRYM2dqSVdBQTNWTlJ2RmdPQWM2NHQ3ZWpsV3RNbWtMLzdtQnJO?=
 =?utf-8?B?RGdZOURqSEMvYjN2MTVVOEcrM3ZycytEMU1seDhwNjBHUVl2VEVGVHlhKzN2?=
 =?utf-8?B?L2lJMFdxVjRybWl2Uk5rakJaUmhTbUpRNnorYnZVUnB2eTUzejRwN0xQeldD?=
 =?utf-8?B?UjBWWlBrZldTWW5pVk5INklBMXJzdExFVGo5ZmplcFpqY2pFbGxHTk1VaU04?=
 =?utf-8?B?YVNsK1NaYWNWSGRvUS9xcHROQXF5WVViUCsvWnR3NEY3dWFKRzBsbUJZcCtP?=
 =?utf-8?B?bEU5VU1yMWpCVlBJZUo3ZHcyZEViYWxyYkl5T2o4WTQ1cGNPNXBLemNNQTBM?=
 =?utf-8?B?azI0UWxXSkR1NnJzeFVVQUVsSzJYZ1A3RTZ2MEJDRGpRT2pWS05oSjhUOTQ3?=
 =?utf-8?B?MHdpakJMOVY0RXlUSnVwRGRrMnJ2bDhiZmlVUjhaaUh6M2MwV0tZUzNQbndH?=
 =?utf-8?B?SFQzQytESGZPZ3U3dXgyT0IzUnZIWThyU3oxTXdvYXRSVkNDaGgvN2lQSmZ3?=
 =?utf-8?B?TXZUWS9rTnd3Umt3NG1QWWxlVEpHMlRQQ3MvZG93MXZ3amttbTJZY3RUUndS?=
 =?utf-8?B?WlA5SkpSMHN3ZW5GQTRkdU9IZnVlSVJBTkVMd3hYVnY4Y2RkNGlFd1Q5Wk9h?=
 =?utf-8?B?bFZpNEQvN0Z4eGQyU0JWSXV5UXQ2bkxBR3N1MUcva1d4NURZMTVBQTRGeTRv?=
 =?utf-8?B?VGtBRWNtVytTMjFsMWpMNjBDVWdWSEs4Q1BjbkZNelhNdVR1U3hZcW81aldW?=
 =?utf-8?B?aDU3RnNFSlVLNFpMYXJSdi9xaGZFZWcvZnZwNHZKaTdVL1AwcG9Jd1RvT0lV?=
 =?utf-8?B?TW12d1owUDJpZGNiK1oxNEdrZmZkZlVRMFVhcW16d2NrNkFsK3FqU3p2aVpC?=
 =?utf-8?B?TENuVFhtWVlGSFRic3BDdWtWTE0wNHpzU1BqSU9zSFovZ2J2clJ4WlRXRVl1?=
 =?utf-8?B?SHUyVkRrV0NFWVc5REt3ckt3TEQreUN0Z0RGaEtKNXJpMHVFTjRpQXU3Wm1i?=
 =?utf-8?B?Q1hEcURGT2hpK1JaMkx0ZHVGdCsySHE3K1V5U08wUVFBTXdoWWl2SUZjb3RX?=
 =?utf-8?B?Z3ZsQ0h0RHdIeHhFb0hUNnpjK1A4THE4eGZKMmdHVTI2WldBOGc2a1ViUkI2?=
 =?utf-8?B?UGZkTHlEV29DWGNocHowV0FVRVU0bWszVnQvMlZjZlFjZWVxVjFGYjM0VlFw?=
 =?utf-8?B?WU9iMWRESFF2RkhkaHVDKzhzSFdGTTd5clZmMGovVWdyY00zeGtVOHpUcHJl?=
 =?utf-8?B?VnVRaitiRXBIbUJxaE9nNk5UN3VwS3hzZGRQc2lqZ2wxNitPalNDcXMyNjhY?=
 =?utf-8?B?cVFMNTN6UUlzVHA5NHhZUXcyMVZFZzI5WlhRenFoYmxSWVVsQ0hreTAwRmxr?=
 =?utf-8?B?UEJzWkpsUE5BNU5kRUdLQVNQOVFpaWQ2UHlEZUxiWjRqdVNuRjVUMmxuOThZ?=
 =?utf-8?B?by9XZ0FuWnhvUGhpZnJxTU4zVGhxOU8rWGYyR1hMT1hrWlVacmpRb05kZ1FZ?=
 =?utf-8?B?QW1COWpQMGwzeW5zVFNDUS81RGpXTEFKWE12SlR6RER6bklRbVRqSGpPOFYz?=
 =?utf-8?B?SVVjTVl3QVZ1RG5KTkc0NTZiamMxY3BzM0RRZlVKQ0Z6UG13VndtcEFKWnlP?=
 =?utf-8?B?RkpCbGJXcW4yZEpGYmFGaG40cVNPcWFrYTNxT1ZhWGR6VHRBTmNXUjN6Sk9m?=
 =?utf-8?Q?Cp+Sv1UCGIkcK?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a165517-ea33-4c7f-298e-08deeb951880
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 04:11:13.2457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8114
Received-SPF: pass client-ip=2a01:111:f403:d40f::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 7/27/2026 10:28 AM, flavien.solt97@gmail.com wrote:
>  From 84574de55c0f63f0963b3e5e0d477b18de91cf33 Mon Sep 17 00:00:00 2001
> From: Flavien Solt <flavien.solt97@gmail.com>
> Date: Sun, 26 Jul 2026 17:51:16 +0800
> Subject: [PATCH v3 1/3] hw/misc/iommu-testdev: support PCI MSI test writes
>
> iommu-testdev writes ITD_DMA_WRITE_VAL with unspecified requester
> attributes. RISC-V MSI remapping tests need to select an interrupt
> identity in the payload. The MSI trap also identifies the device through
> MemTxAttrs.requester_id.
>
> Add a write-value register with the existing constant as its reset
> default. Populate the requester ID from the PCI function. Existing
> translation tests retain their payload while interrupt-remapping tests
> can issue a valid MSI for the test device.
>
> Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
> Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/misc/iommu-testdev.c         | 14 ++++++++++++--
>   include/hw/misc/iommu-testdev.h |  1 +
>   2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/iommu-testdev.c b/hw/misc/iommu-testdev.c
> index 15eb6de..6428a57 100644
> --- a/hw/misc/iommu-testdev.c
> +++ b/hw/misc/iommu-testdev.c
> @@ -28,6 +28,7 @@ struct IOMMUTestDevState {
>       uint64_t dma_paddr;
>       uint32_t dma_len;
>       uint32_t dma_result;
> +    uint32_t dma_write_val;
>       bool dma_armed; /* armed until a trigger consumes the request */
>
>       AddressSpace *dma_as;   /* IOMMU-mediated DMA AS for this device */
> @@ -80,6 +81,7 @@ static void iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
>
>       /* Initialize MemTxAttrs from generic register. */
>       attrs.secure = ITD_ATTRS_GET_SECURE(s->dma_attrs_cfg);
> +    attrs.requester_id = pci_requester_id(&s->parent_obj);
>
>       space_valid = ITD_ATTRS_GET_SPACE_VALID(s->dma_attrs_cfg);
>       if (space_valid) {
> @@ -97,12 +99,12 @@ static void
> iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
>
>       as = s->dma_as;
>
> -    /* Step 1: Write ITD_DMA_WRITE_VAL to DMA address */
> +    /* Step 1: Write the configured test value to DMA address */
>       trace_iommu_testdev_dma_write(s->dma_vaddr, s->dma_len);
>
>       for (int i = 0; i < s->dma_len; i++) {
>           /* Data is written in little-endian order */
> -        write_buf[i] = (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
> +        write_buf[i] = (s->dma_write_val >> ((i % 4) * 8)) & 0xff;
>       }
>       write_res = dma_memory_write(as, s->dma_vaddr, write_buf,
>                                    s->dma_len, attrs);
> @@ -186,6 +188,9 @@ static uint64_t iommu_testdev_mmio_read(void
> *opaque, hwaddr addr,
>       case ITD_REG_DMA_ATTRS:
>           value = s->dma_attrs_cfg;
>           break;
> +    case ITD_REG_DMA_WRITE_VAL:
> +        value = s->dma_write_val;
> +        break;
>       default:
>           value = 0;
>           break;
> @@ -240,6 +245,9 @@ static void iommu_testdev_mmio_write(void *opaque,
> hwaddr addr, uint64_t val,
>       case ITD_REG_DMA_ATTRS:
>           s->dma_attrs_cfg = data;
>           break;
> +    case ITD_REG_DMA_WRITE_VAL:
> +        s->dma_write_val = data;
> +        break;
>       default:
>           break;
>       }
> @@ -263,6 +271,7 @@ static void iommu_testdev_realize(PCIDevice *pdev,
> Error **errp)
>       s->dma_paddr = 0;
>       s->dma_len = 0;
>       s->dma_result = ITD_DMA_RESULT_IDLE;
> +    s->dma_write_val = ITD_DMA_WRITE_VAL;
>       s->dma_armed = false;
>       s->dma_attrs_cfg = ITD_ATTRS_SET_SPACE(0, ITD_ATTRS_SPACE_NONSECURE);
>       s->dma_as = pci_device_iommu_address_space(pdev);
> @@ -280,6 +289,7 @@ static void iommu_testdev_reset(DeviceState *dev)
>       s->dma_paddr = 0;
>       s->dma_len = 0;
>       s->dma_result = ITD_DMA_RESULT_IDLE;
> +    s->dma_write_val = ITD_DMA_WRITE_VAL;
>       s->dma_armed = false;
>       s->dma_attrs_cfg = ITD_ATTRS_SET_SPACE(0, ITD_ATTRS_SPACE_NONSECURE);
>   }
> diff --git a/include/hw/misc/iommu-testdev.h b/include/hw/misc/iommu-testdev.h
> index 3383659..2f4e931 100644
> --- a/include/hw/misc/iommu-testdev.h
> +++ b/include/hw/misc/iommu-testdev.h
> @@ -81,6 +81,7 @@ enum {
>       ITD_REG_DMA_ATTRS       = 0x18,
>       ITD_REG_DMA_GPA_LO      = 0x1c,
>       ITD_REG_DMA_GPA_HI      = 0x20,
> +    ITD_REG_DMA_WRITE_VAL   = 0x24,
>       BAR0_SIZE               = 0x1000,
>   };
>

