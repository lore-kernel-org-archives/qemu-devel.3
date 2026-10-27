Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38118606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=aLH6D5qM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLYhM-0008AA-9P; Tue, 27 Oct 2026 00:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLYhJ-00089I-PN; Tue, 27 Oct 2026 00:22:05 -0400
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLYhI-0004md-4H; Tue, 27 Oct 2026 00:22:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyNkTRwgcVA2oglnrZLpi6SDq7UCKfOA2ds1WlzyYUjGDcKYhAaT7dA4tcIw7DStqXAH0t1HxfBS8LyiLVXq07aOTvz2lMKYEduMZGzjSCF0tpVI0tXEGyz9s8l4835pXrHNS9AzXYeqMVUQmNXhxSHgO5+7Y/7LgvV48NgQRmkyLwVfPVGXaq6OLK4tJ8Fa9yUt688fg92QSD1b7uCGSpZlsIt48eEOBJ69JX40UM19OSRQ8lhvwhmlFM/fxkqAUkMq+Ts83dxTyu+KDGX3YFdIENQWpj0xRfaiX63i9I0u0oTRD2BbOr0VwrVep8CrY4Tk0uaXIAbI+2kgq1x4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60l1DkI0HLxRLsFeIUjDC5nU7LHVf9KN9jBNUR/RTS4=;
 b=icqowNPo6AsPfMEIj43tQdTfXcgHKiUMFQQK0HGos4nvKKG3NBKEVimukiEa8Ko6c1fdL9raS6F2FvYCCUt4k1n/orJvGOE8ZzA4Z1E0RLG2VIsV2ut6vKxnzEFCw8KutfTKju6/X/iaX3aB6jgB3OnG8+yA7QzsRucY/UveJMa43d1PYlpmenskdGtYopx59Ejte1vE42bajYpcQoc0dKablI7P5iGMWcnrRSEtTR8kxH1GghAqtmcesyp2RKnFKgVF+6eYk4XZSDAe/ar0DdIMBHYJszwoHk1UmmzJkdqHTA9Cnp50E2LVxlTCLWVVN2gy2Fb64lp4tifacsjtSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60l1DkI0HLxRLsFeIUjDC5nU7LHVf9KN9jBNUR/RTS4=;
 b=aLH6D5qM+8P9yXBH77Q+mZvxrdYKkL3qx/uIr/tXnI+WdWkb+UCyyO15YjsdNrnGMdCmmniOM7wg3khWB3IFOKyBkF9p59ugpKom89zT0i5mD7ehmci1dTOYRP35TKCuCoRBCMoMqB9M1N/2NicX9GbI6ZaBehGGktZwjAHjmGjuGK/OpyUCkStEeofI5EFr9b90DdEXS4Bm9j6EuXZZJfVxhRm3skyiDkzvTkjD2ndrog5C6ge5eLrhnOFzEOHwXhoisphYWbGQqqr7RhuFca8Rnh3kVu9s6oyEa9btq8RWufXnah+MP1yTFxczrYw56jJiMh+sZDKOfKZJNe1gXg==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by SEZPR04MB9628.apcprd04.prod.outlook.com (2603:1096:101:33a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:21:56 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:21:56 +0000
Message-ID: <TYZPR04MB749111F86DDAA9B66A416CB1F3602@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Tue, 27 Oct 2026 12:21:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] target/riscv/kvm: create kvm_riscv_aia_access_reg
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Xuemei Liu <liu.xuemei1@zte.com.cn>
References: <20261023021237.486091-1-wang.yechao255@zte.com.cn>
 <20261023021237.486091-2-wang.yechao255@zte.com.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261023021237.486091-2-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0050.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::12) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <68770c01-ff7b-4aad-983c-a77002b34782@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|SEZPR04MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: c1772ce1-193d-4ec4-1527-08df33e1d563
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnrlC5lHdFGci+YUsdS3F/CIVZpHyao8/J8KkU3RF3AeJbJPUzTF8YcKVAHub3xEM+WJ3rjkWCQl1kTGX5+ub6f/RaTq8+CiipKYdnV3fh8d0qhiIzL4xt8ZOzn7j2VKmodXcmciUosEgdhCI9S/LCFP+WlZQloDU/Cws07EZtZzXKih4HxXooM9bWoPRovoZPk5irns+FsFJ+issDduN2weQKYtOykTKnnvhRgNyBj2JLz3m6DgErc3np1On+46udxD8KA3l4zpKHOT3FAtx1uTfujZyw11D1CZCdTQOFyHqSTO/rRz8ugu+4Cw20Mx/PtlFRYBRfs42ry90Z+GLhip00m1VMS6MozeKqXHrWlKctq3NUPvIPGyyTwKQe3RDOCY+A2DkOIrQJuxC/YXjd2x0i4ELJq6UCl4CQf4/L4j4GhaXMG38Mr3aosD/XBI5vWsEKUkXLf3Akj5VMW5PIAisekbFUFHCe8ZALbEn/j+XSwXTb507fHpXyszdqap1ThA0trFrE/NNtfZxfmNncSONgexS8xekrOyxGcrOZC+zo1PN4y1VZsgwlcZ9OUOn72wzsy6Pa7Ii2GlnvVzk8CjUfgz7zInApLftbKYSwO/VmHkhxJ1LPTTt1XywMEQrQas/rSjyOesNBZ5ZqTT29n+iA5xeWfdYuDSzd7V0brzvHwD7YxGeb+qgDSEN1tGGeki4OSV00ZciBK9H6xkrND4I2KlOY/yytJ6pM7zB/ErRJzFrzDGPmaeYfaMfSaiCWI=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|25010399006|4140399003|8060799015|19110799012|22091999003|51005399006|6090799003|24121999003|5072599009|15080799012|23021999003|19101099003|55001999006|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU5Ed2cxZVhGSDZkWXVLMEVjQVFxQWpnRjNuekNCb2xUcWZvQXNnQ1hxaGpG?=
 =?utf-8?B?VkNzbWRFSGtMTFpFc2h2MGZjdjNtdWhzMGZEUk1ETmtSTStTdDcwa1UrVXdP?=
 =?utf-8?B?c3NKVzRGdDl6cVF2aXFVTVZKZEZzcy9nVHc1QkxRQ0NkMFRCOW4rckZMdS9w?=
 =?utf-8?B?VFlCT2lIbUFMOGtWR0xjaVMzNXp3aW4wdVoxYUkzY2V6dExvVCtsbTNzeVhE?=
 =?utf-8?B?eTYyQjVUUEgxdUhQcW9lcTRmaHNjL3RTK0J2SnNTblQ0Q2hFTDI5TEc4ZUFX?=
 =?utf-8?B?QVRzNUVleEUzZVhSbUJ5anZrdGQzUjRPVUU4RzBaVXYyRUpsQ1N0SzhMZjRl?=
 =?utf-8?B?QmdyZHdaZFJFbStwOHk4cWIxUm5wNmZkb3l4NVNsZEVNYjRMdHVOdi9tWlli?=
 =?utf-8?B?NllLYktRcWRrRzR3bkxzcU1tenUzQng4YWYvOFFCQ2JaV21iWkFhNWN6QjI4?=
 =?utf-8?B?b1hUVlFTdURLaU1pWlVBSUtEb1BhMGk1bDlnRk9BRGFUd01TRUQ3cFVKTjds?=
 =?utf-8?B?bFVGQzJTQ0pwTjEvb0NYcVVqRzI2cG5PQ1k0RUkwaithb0RFNE81d0ZzaUJH?=
 =?utf-8?B?YStBN0xaU2x2K0dmeU5RV1R3QlRybWFCbEFUdU1rNFRBemwzMTdjeVpOdXdM?=
 =?utf-8?B?UTIvQ2Q2NTJmcDh4VUU4ZURPY2dBZDRQSlNzdEEyYkh4c1NmRVdGMndyRWJa?=
 =?utf-8?B?MFIyRklwQW5lYUd4cEQ5cGh1MzZFR3EyeWw3OERMdkdYM09mMU9mZngyUXZt?=
 =?utf-8?B?WWdhcXVueXY4Nm05QitNNmgxazNLdnhaZnZNeURsQ1VMVGc4SFhYNFJXZFhq?=
 =?utf-8?B?T3pvcE5oazlva0h2MXh4aW9ldHhGVGNtczlGK0RZMWoxRC9DMXQrYVdtYlMx?=
 =?utf-8?B?cmVPbElaVHp1OCtLYTB0ZzUzbm9ySWJlRnNjWnFWOFZWdDFHRWdMeGF6RmZD?=
 =?utf-8?B?UkJhRGpaMXc0WWVqbEthdTRSVDRuVTBkelE5RDUzcWhDSXdQdGdWekh3Z0M2?=
 =?utf-8?B?WnprU1VCd2FoU2ZNbDdlTU9xd040SU5SNllKVlBEd0x5YU9xQklsWGNiSmJX?=
 =?utf-8?B?VXZOd2FhODN6aElYN2lEaW1HdGRURUp0b0JRSTFieS9nK3R2ZGhyOGxrUlUv?=
 =?utf-8?B?RVd6RUJCL3NZd3RlNFpCUWYwbXB4MmUzR0R3dCtYM3drQjF5VnltOE1GSDM0?=
 =?utf-8?B?TWk0TG5GSFhqUFY2UEJ6eE1NUVdZNG5aeFJDem4yL09yNFBjR2U3SE8zSTNh?=
 =?utf-8?B?dkdWSDJpemJTN3VIOGN2RHFCZUp6VHhJSHNPR2REaUZSdGJQRDZEUW1PSjhQ?=
 =?utf-8?B?RVdRaUhuTFd1QzFxWmNUMWhnbEpWdkt4YnoxZGJaWjRXZVZuWXNIZkxCTUlN?=
 =?utf-8?B?QnJuM1ArbGNFanJoaUx3NTVoZHZLdmtsd2ptU0I3VlFpb1pGV0REYnQ2L1Rn?=
 =?utf-8?Q?bfwD2MGR?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDU3bnJSWlVURkdPT0ZhOEROVU1rMTE3U3VmT0ZDalNwWFhKZk1jc1R6TmtN?=
 =?utf-8?B?aFF2dDJXdUNGVDVoT1grNEVMRkR0OWFZeVRSTnhOS0RkaVpOMXpndEVYaW1p?=
 =?utf-8?B?U2xWZlJUVDhXZ3QwT3l3bVIrbTFuY2IyVTlWRXhQcjY5SXJMRVBoTWpnZlJa?=
 =?utf-8?B?YXFyNHRoYnMrUTFTNmFMQnB1QzFITUVEM2hOTlYwaE50b21Ba0w1MGE1c08r?=
 =?utf-8?B?MGVMd3k1aWEzaFAwYjU3aFdQeSs1Mm1CSkMzNksrS2hCa1g0WWk3Ym9hek9n?=
 =?utf-8?B?OVZUNmd3TEErc29NenZia1F3cCtqdE5wTWFQNVhHM002Yi91ZGpKbi9CaHQ4?=
 =?utf-8?B?cXlhZHhtTFQ2UXp6ak15bXF6TjBLNVQydkxtdEtJZjV0ektaTkUrckt2UzA0?=
 =?utf-8?B?cDA3QTcxczRCNTl4ekk1cHRjYWlMVGd3SDQzMXJHcDEwQUc1QnRBemhONzI2?=
 =?utf-8?B?eUVpVktDL0o4Lzl4SkZlMFl2Y2tRVEEyQXk4Y1JnWFZjTXRjTG1BVmY0VmVp?=
 =?utf-8?B?cmxwYjRWMDFXeUdWM1YzeGRrLzAvUHNFeWpOblloV2JXR2hrZUtjby9OaW1T?=
 =?utf-8?B?blFNaS9saWc5eU03eHA4cHBhYUhzdzBPcmVpRkNYM2NpUDhPaU44d0VLMWZ3?=
 =?utf-8?B?UUJhVnBwR3lyaVEvK0JLTUo1QU1mTjNuSXVvVXhZbjNlcjdNZzEzeSsyOExh?=
 =?utf-8?B?SmhzWEE4eGs1aFZZZ2FaNkFiVnlWTG9uNWVBa0tJb2xwc1VISEhvSmFUQ1Vq?=
 =?utf-8?B?RVRuTzI4UGxiaHNjZGMzTFprK0oyemVWY2E1bm1TME9kK05xTmZyZ1BENng1?=
 =?utf-8?B?Zmx3RllIVDZFTnZJYUl5SmIvY2c0RTBwazFFenlMa0Q4YlBYVDdSTzRNRkVv?=
 =?utf-8?B?ck9nRWNHUXZsZmtJRE1pYlo0U0E0S09udTBnZGZQKzlLZTBNNTBHWTJ1WHlI?=
 =?utf-8?B?Mm5kaUJSWngvdW5GN2hoOEtmUUpEdE1Ea0RBeUxVNmJZMzcwcnQ0VEp2blFH?=
 =?utf-8?B?aklGakhCcEpzRWFkc29kODZFampqazgzeWtPcUZ2SjZXdm9kRmhOREtEcnFM?=
 =?utf-8?B?UXRZdFhTMnBxUEpBMHhNZ3BGUFZhVGpsSXZTRXVvcmZsK0VPTXN6OGpPbGFQ?=
 =?utf-8?B?SmtyZWp2R3k0eTZMZW93OHZDNVYvSDhlMlZsNHI0TnNudjZ5NEJ1MnpWcWtE?=
 =?utf-8?B?UXVtTnNJVEdQNFgrZFB5S3Z4Y0w2UEJsdTV3N1Q3bmJ2MUhlSXMyNFBsRnli?=
 =?utf-8?B?OHI0N2xncmRaTXBUYmllVkljR3lUQVJ5VUhYemRRRjVUaFZnK3E0ZFNDd093?=
 =?utf-8?B?YkQwV3g0MkQzU1lhN2pNVXkwRFppakdaVVFJdk9SeTBpREtPVXRkd1VIV25m?=
 =?utf-8?B?RWEvRjNKRllxeHV5SzlPWVhPVUV4NkJPOGp5K0NjWWNWcEk0Yk1GZktiZmZ0?=
 =?utf-8?B?WkN6VTVvUnlrOG8xWU1nOTZSVUJRU09DVFRER0Q1Qi9FS0ZVUUk2QmdiajFm?=
 =?utf-8?B?QkY1TzNabnR1YWpzRXpPUVpEY2tQbi9Ycm1CWkVRYkZycGM1cWFnT0pVUUsx?=
 =?utf-8?B?NDNmVmtMVGp0SmxkZDRlL2hocldNUDFxOUxpdWZOWnJrQXE3UWp6TzZ5N01u?=
 =?utf-8?B?cHFPZUE1dVZQRlQ4a25JR2Z3OEhkS3RyWi94dlA3MlFUMStGY0ROUzAzQmR4?=
 =?utf-8?B?Yy9DaXBzcXdpaUJ4Um5kNEROYUxZaUxEY2NIemlPYk9mRzFEbGkxSWk4MDBQ?=
 =?utf-8?B?UXFzYzF3ZVh6SkZnbkZnQ04xZHBYbWszcDJ4SStJdWltSmVhQURGcmZHUmdh?=
 =?utf-8?B?OUhzY3o4VEVuMGpRSDFQRDNmbTl6aktLTVMyOVhTM0tLMjh4VlZveXZxMHFu?=
 =?utf-8?Q?sixaexXYhFUCa?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c1772ce1-193d-4ec4-1527-08df33e1d563
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:21:56.6348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB9628
Received-SPF: pass client-ip=2a01:111:f403:d405::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 10/23/2026 10:12 AM, Wang Yechao wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>
> Create common function kvm_riscv_aia_access_reg to access APLIC
> and IMSIC regs
>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/kvm/kvm-cpu.c   | 7 ++++++-
>   target/riscv/kvm/kvm_riscv.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index c085b22b23..3ed94f7586 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -58,6 +58,7 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
>   
>   static bool cap_has_mp_state;
>   static bool mp_state_reset;
> +static int aia_fd = -1;
>   
>   #define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
>                                            type | idx)
> @@ -1924,13 +1925,17 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>                                       "auto");
>   }
>   
> +void kvm_riscv_aia_access_reg(int group, uint64_t addr, void *val, bool write)
> +{
> +    kvm_device_access(aia_fd, group, addr, val, write, &error_abort);
> +}
> +
>   void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                             uint64_t aia_irq_num, uint64_t aia_msi_num,
>                             uint64_t aplic_base, uint64_t imsic_base,
>                             uint64_t guest_num)
>   {
>       int ret, i;
> -    int aia_fd = -1;
>       uint64_t default_aia_mode;
>       uint64_t socket_count = riscv_socket_count(machine);
>       uint64_t max_hart_per_socket = 0;
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index aef681f0a2..8649219e0e 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -29,6 +29,7 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>    * @level: %0 to clear the interrupt, non-zero to set it.
>    */
>   void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
> +void kvm_riscv_aia_access_reg(int group, uint64_t addr, void *val, bool write);
>   void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                             uint64_t aia_irq_num, uint64_t aia_msi_num,
>                             uint64_t aplic_base, uint64_t imsic_base,

