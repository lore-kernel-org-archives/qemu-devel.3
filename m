Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D5BCA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBAZ2-0005o0-Qz; Mon, 28 Sep 2026 08:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xBAYs-0005ma-Hh; Mon, 28 Sep 2026 08:34:27 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xBAYp-00011K-N3; Mon, 28 Sep 2026 08:34:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veO9J2ykLbmkbbxkUMSNDmuu8klQqizdf5mPo3zWHOd8oORn5WQhkIXln4ty3BnpLmUxpXeqhOhr/yQ1hfTcpcssaTMLgHuIyOogoS1SiHpwFI1AtzPM4EvADlNfw8G5R66VcKcCG1zz51c6aeY5Ud5biydezJSbVP2Rab0JFgA3jRH9pK0cWestHZS4duCx+0mK2l6AnueUqrVUGKx59bA3Fj+Vm41X8KJsEBG1MPxGRbBjt1nMVhO2oQDqK/rYhCTwLVEYIHQIWpbZa59p3H1mIk6WAeniq6s4VW0hhyGIViuIORr9AXsFUuUgIM6jJAeL3drMzGnTJzV0bZxkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHYwxWO54h0ZM42s25isGTMwTeD4/o19qJ2K77fZotg=;
 b=VWe+a1Wf/V24VJy0hDXdaITiziWarTP2NwHfD77dWoqBkPWNigoNgj9B1JnfitOieoOJ/inXFWoRWk34l7StRk1wP+j0f67c8qtHAE0TjJmptS17RwJF55DoGgMiuEpMFOh5L3xCOOvWjlkfTPj8nFEyfrvRQCHWg2PBh5MNg8IL0fMcUnQujIwloTucu6vAJ73v6LNYDi/epY+bgoy1z2kBBxSd5ibjPQJv99Vjo4XP60qD+dZPYr/lJlOAjAyZOw8cIz4bv9jsoVCkZJNu1zDV+bzBPF+jYo864i2TIQTTdb1LdoLkAgvhYwBf6SCkDakfccuSsdPy2ZVm/RHTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHYwxWO54h0ZM42s25isGTMwTeD4/o19qJ2K77fZotg=;
 b=GgLVXSwZvUHm281g+X2mRSECyZ3r9pdukZ8taE8jHZtg9TzRTkVzmHdxUJeTF/K3dVQeEYW8RKCQoK3trAWkKB37tvFVVK/VbQ68NVeDEaPqQjzPFVx3zT5z+BgWF9VcR0mo0KDtQZzCppu596pjCu2tlLfQYEbVz/hjP0BGp4AYlCFmFk9QU8j476lVgF7IC+/JPCXZhwN+BaIH7PPQ+7ICACqPnjgy4IZdxpzI+pgYP4AKx5NXkNVU3q51YwNxwobl/MwW/mY4xCEIbjWuOQSFOmB7fJ03qDGQWDXGDFeOBjKiF4cpdppIcTrQmAQCX8R60lZEt0XXTEchUDsBqg==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SI4PR04MB9355.apcprd04.prod.outlook.com (2603:1096:4:29b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:34:14 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:34:14 +0000
Message-ID: <SE3PR04MB89225BDC90FFD239745421B7F38D2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 28 Sep 2026 20:34:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/7] target/riscv: add dret instruction
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
 <20260909144841.1766921-4-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260909144841.1766921-4-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0007.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::7)
 To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <927ecc69-5731-4267-a173-4879737135ad@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SI4PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a849c00-7cf7-40e7-5271-08df1d5ccd96
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|15080799012|41001999006|55001999006|19101099003|5072599009|23021999003|22091999003|24121999003|25010399006|8060799015|19110799012|4140399003|51005399006|440099028|3412199025|12091999003|40105399003|2607281247196008|10035399007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDU0Qnd0MVdrQXpKM1o5UGRqeFFGcE5ZaEw1TnZnNzFnTmlyRHlvdFlMbE1L?=
 =?utf-8?B?RGF3ejZSa0RlY0NqU09XTXVWRVBGYXp4YnEvSFh0eVFPN2NmZkk2b3FYWUNv?=
 =?utf-8?B?M1BKcHpQNHpUdHp2QUlyWFp4WkZsbkRxemJ3di9WKzR5SmY5TEEyV3hKZkpn?=
 =?utf-8?B?WnNwSURaSVZCNnA2aU16S2psUk8rNlQwYTJ1SWFPODUrMGhkbUFsNUk4VkZW?=
 =?utf-8?B?eXdqT0J0am9XZDdWclpjMnVreEZuUkhLa0xFdml6Zm5KemlUY0crb04zSlBK?=
 =?utf-8?B?a0gxMmhTMkg3RlB6VkVvclZ6SmF3R1BhRHJVbkw0RGp5UjE0dFhPUUp4QTll?=
 =?utf-8?B?ekkvNmhMcGt4bUdzRGlXMmlLTCtPT3RESHhMWXo1MmdpZjhDem50bkV0cmho?=
 =?utf-8?B?ZzNMQ2RtZGhNMEJ1cU5GUXZjVmtraldkTXFvZzVrNTNtdjQ5Q3B2OCs4bjFr?=
 =?utf-8?B?MnNORSsxQWI3Tk8xYUpXelMyL2FHWm1LN3F4bzVCR1pybnBCTVNpWjFWenN0?=
 =?utf-8?B?aW5YclZzWGdrYWYrQzlyMXlrTHdBdzlzTml6UWZQS29tVk9oMlRKcm9LWWFz?=
 =?utf-8?B?Qjl1VGF6UWNzUldseVRSYkFsV1dmRmtpZGk2ME1xTmhDTk9WU1Z3Z254eVd5?=
 =?utf-8?B?bEJpODliQmtuR2JVNGp1aEx0SVJLM1YrUVVUaStIdm9EYzYvSjV5K1JtaFkr?=
 =?utf-8?B?R2QxZzUzZ202ZEpJZFoyd2tJOEQrMUdyQ2xpVmVGbzBZRTBmajRqNmVxN1Z2?=
 =?utf-8?B?QUt2OS9EWEMvU28wNFU5Yk1DbVBQbFJTd09xTjQ5dzl1YnBWZzR4NC9FY3Ex?=
 =?utf-8?B?SndwNkRtOG1WMWMxamhjMEVGeHJ2V012RTQ3cFRMc3k4V3hzWEFWUHZRNHNl?=
 =?utf-8?B?SDB5RFZuMFpTTDlsNG9hcFJYZUxpUkQxZWoxNVRZcmowenpMaWp2ZzNhTm9k?=
 =?utf-8?B?MW9TdSsyTGM4WTc3YVlRVmU5aStPYnZGWjcxTGtNK3JEaDBSUzlqWlhKK3lV?=
 =?utf-8?B?VVdTa2pqZytTLzRnUFU4bGxtcHdoSlA2cVpNaCs5VkxrT3NDbWZocVhLUFRi?=
 =?utf-8?B?bDZMZjBWM2JtS1pNWTNla0FnNUFrTHF1ZXJXd0x3NzBKemZEV0p6UUxEMmV4?=
 =?utf-8?B?bkZ5MlZFNHE2eUZnZWlzTlhSZXRzYThBTVRVYlF2ZWVoSWdEeElzV2lOZEJ6?=
 =?utf-8?B?S055NW9BdXFRQVNjT0ExaFRZWU5TK2ZhU1ZhMjFRUU1wZ1Ztb0UvS0N1RHp2?=
 =?utf-8?B?Y1A4SnpJUHo0WmloRjArRVVBb2tJYjdHQ1NmdGx6em9sZHpCTy9iS2htTFdE?=
 =?utf-8?B?eTlYaExKd0hKZmhYUUlPaGZtckxqOG9UQjU2dGNuNDhyWEFmSU9CblEvSlRT?=
 =?utf-8?B?N0VVUWlZaGZoT0xKQlgrdWx1ZDZRTzR0OG5QRWZ1Z1BmZ1hwMFJxWDdZS1Jj?=
 =?utf-8?B?OW8yMGhTOGFMNDMza2J2K0tkbHVTS0YwRlE0MUpjOEpoMzcrcjVpMm1iVExv?=
 =?utf-8?B?V2JmT1JxeUR6bG8zalhDb0g5YzlROVFRcHBKUDl5dzJCcktzaWhqeUplWCtq?=
 =?utf-8?Q?fm9NW4UOwF8GJS03rr88OE+RE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWxMK2RSOVVCTjZnRTZCalArc050Y1NHaS9Gb29UaTNUYlo3Y25kaXhiaGNm?=
 =?utf-8?B?WXhGMXJET01sQVFJYjNtb2lQZHFpMFAvRG42dEZyRVQwRmNXQXRLL0ZkYzFk?=
 =?utf-8?B?Zm1PdC80RFRnY2x3dzZCdGNvWXFPTlBVWFBxWGUzQWdHejJjR3NhaG1YVG1m?=
 =?utf-8?B?MWhRSDFLUDg4aDlobCtSWGxVd0NUcnBVVmR3YmtkekczTFJiZGNLMWpQSHJT?=
 =?utf-8?B?d0FxbzJ6MHRZTUV1aGd2Z0RZWS9ZYUNDZ1gvajlDQUdteU9iNVFJL09vZ21O?=
 =?utf-8?B?TGJUYWkvSHNLTzYyUXFWM0lKTE40U0k3TFpYcWhENnFjNGpMUnlzd2NiZkZt?=
 =?utf-8?B?aXR4d1E3RUwvK3gxN0xEU2wzUjFJdndoV1RhR3FRTS9BbVFlUWU4QnVYcWxn?=
 =?utf-8?B?VDIwMUJMUXIzVnFCRGFLYnB1Vm1XbHZQbHMvSE0rTUx1RVRDRHpQN0FEdGk0?=
 =?utf-8?B?NmdGVjZxTDBYSnFZRVI1a28xUFpTVVp5SDJGR3JCUjIxc1Z1UDVGOFFtUE5V?=
 =?utf-8?B?WDM0VUp6SHFaK1M3MWNwMENsbHN1cWN1S0VWdUplSkp5b0tjM1BWSDB3Rkxx?=
 =?utf-8?B?anh0Qjd2SEl1YWhIRTVJQWtKMlF2S2dtV3ZuRkNPa2tBY0s3bDFuOGxjK1pt?=
 =?utf-8?B?cFhLaE1KNjA0eWdta0FYaW1GZ2M4b3AxVnpIZ0JRMlgwbkFMWXh6Ry9nMFRK?=
 =?utf-8?B?ZEgvMlJCUENEemFQaVlDWEw3RUlFSEFIRlE2Nm9YUHpJL1ZPUmxYZ2diZCsx?=
 =?utf-8?B?YXhrRS92Y0toRUlGUnN5SnBEejcxeWNVU2Z1czcrNDI2K3FGVWFyS1h2eXpn?=
 =?utf-8?B?WFFLVHo4K1oxZzNQUUNsbUFOby8xNFBtV1BSSk1qMDlOdHVNV2szaVB5QjE3?=
 =?utf-8?B?VW5hOWpvejkxY3RRMEtHd2hqQU5uYkI4aDkxVXNPaTJaMXMrM1lYNlQ1dlZz?=
 =?utf-8?B?VWRLbDliVzZWcTllblY1N1gzbWtPamtIaUlZc0VZZHJIRVZIMEJ1VnlEQUQ0?=
 =?utf-8?B?V0ovSDRrSzVCU3BkUyttOUlEYk5XSHdMUDRVZWxGNndrWUswTlYvMkNMSnZB?=
 =?utf-8?B?dnU1UHZqQTA3ZmQ3RVdhdHZxaGd5S09HRFdYRTRGbmVFZitjaCt3TXNUeW5i?=
 =?utf-8?B?ZzdlS3dIMzZvWUlCUmVTbXpqcDVNSGlEam9PME1XNDZ0T0poWGVJUW9DYk14?=
 =?utf-8?B?elZ5azVveFNkbE01cXVKUStyS3VadlBwUDlVei8ybEtpQXNWNDZXVDg0MHhi?=
 =?utf-8?B?bEhtUUxsejVVbndUajBzL0lhS0J2bFVwOFBudlA4NVh4UWRxZGdUYjkxRkQx?=
 =?utf-8?B?UU5YcDM5VzUxTENRVk1Nb2c4T0VQbnhtRmt3Sm9SMS83dEFKZlk1ZEx3ZGsz?=
 =?utf-8?B?d00zSlVjR2NMSGdDZjJ0Zk9Ka0xpbU4wMlkrZUVYY2xKS29jQkJRUXZYN3dp?=
 =?utf-8?B?OWZGSkptbkNiaWxBREU4elVCVXlFZDk1dHUxeXY1czNFT1U3b0t5SVpkSzZv?=
 =?utf-8?B?Q09QZkk5QzA4S1V2dnZiZTZIc3hyb3d0MDVSWUxES3ZFZ0k5UTB1OCtJcys3?=
 =?utf-8?B?VnIxbTRNV3hFQWVQeUhKK2ZlUGd1RTdLN2ZlWDF1d0dBV250ZlpWZFlaWWdM?=
 =?utf-8?B?Y2ptM2dIcmt1cXBNNm9jWSs3TW5jRU00MEpVRU9obFJocVA2YWZPU3VxbWd3?=
 =?utf-8?B?OTVVRWozNzRHRVpGWERncWZKLzdWRTY2RWZJV3hVbis1Tnh6M2JvZjdWcTI1?=
 =?utf-8?B?TURyR052aDdaeFdWcjRZc3hFYXFNSjBhN1NTbkZvOVp2TXVBaWdhRUVyZlJH?=
 =?utf-8?B?VW1WM0dLS2NNNS9VQjludHR2TG9zM2k1OFY2NkxrY1VtYzB3WFc0cWxmU3U1?=
 =?utf-8?Q?upX7uqHSDBREk?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a849c00-7cf7-40e7-5271-08df1d5ccd96
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:34:14.2260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR04MB9355
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


On 9/9/2026 10:48 PM, Daniel Henrique Barboza wrote:
> From: Chao Liu <chao.liu.zevorn@gmail.com>
>
> RISC-V Debug Specification:
> https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
>
> Add DRET decode/translate and a helper to leave Debug Mode and return
> to dpc. Executing DRET outside Debug Mode raises illegal instruction.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/helper.h                          |  1 +
>   target/riscv/insn32.decode                     |  1 +
>   .../tcg/insn_trans/trans_privileged.c.inc      | 18 ++++++++++++++++++
>   target/riscv/tcg/op_helper.c                   | 16 ++++++++++++++++
>   4 files changed, 36 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 4fc2d3a155..b4c47d0738 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
>   #ifndef CONFIG_USER_ONLY
>   DEF_HELPER_1(sret, tl, env)
>   DEF_HELPER_1(mret, tl, env)
> +DEF_HELPER_1(dret, tl, env)
>   DEF_HELPER_1(mnret, tl, env)
>   DEF_HELPER_1(ctr_clear, void, env)
>   DEF_HELPER_1(wfi, void, env)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index aa02dae3c9..46b00411ff 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -118,6 +118,7 @@ sctrclr     000100000100     00000 000 00000 1110011
>   uret        0000000    00010 00000 000 00000 1110011
>   sret        0001000    00010 00000 000 00000 1110011
>   mret        0011000    00010 00000 000 00000 1110011
> +dret        0111101    10010 00000 000 00000 1110011
>   wfi         0001000    00101 00000 000 00000 1110011
>   sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
>   
> diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> index a8eaccef67..4e57901880 100644
> --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> @@ -125,6 +125,24 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
>   #endif
>   }
>   
> +static bool trans_dret(DisasContext *ctx, arg_dret *a)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    if (!ctx->cfg_ptr->ext_sdext) {
> +        return false;
> +    }
> +    decode_save_opc(ctx, 0);
> +    translator_io_start(&ctx->base);
> +    gen_update_pc(ctx, 0);
> +    gen_helper_dret(cpu_pc, tcg_env);
> +    exit_tb(ctx); /* no chaining */
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
>   static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
>   {
>   #ifndef CONFIG_USER_ONLY
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index 3e94005d2b..54269efee1 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -473,6 +473,22 @@ target_ulong helper_mret(CPURISCVState *env)
>       return retpc;
>   }
>   
> +target_ulong helper_dret(CPURISCVState *env)
> +{
> +    uintptr_t ra = GETPC();
> +#ifdef CONFIG_USER_ONLY
> +    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
> +    return 0;
> +#else
> +    if (!riscv_cpu_cfg(env)->ext_sdext || !env->debug_mode) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
> +    }
> +    target_ulong retpc = env->dpc & get_xepc_mask(env);
Seems it should be at the top of the function as below:
+#else
+    target_ulong retpc = env->dpc & get_xepc_mask(env);

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> +    riscv_cpu_leave_debug_mode(env);
> +    return retpc;
> +#endif
> +}
> +
>   target_ulong helper_mnret(CPURISCVState *env)
>   {
>       target_ulong retpc = env->mnepc;

