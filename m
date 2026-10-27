Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1929606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=WBuKkX4r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLbV8-0003X8-0C; Tue, 27 Oct 2026 03:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLbV5-0003W4-A3; Tue, 27 Oct 2026 03:21:39 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLbV3-0004on-Mo; Tue, 27 Oct 2026 03:21:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysu0TS4YKONAf67y3ZJmjideB6MfQcpkbqhI9TNnnjSF+IiHSAyUZmjiN6JsJm4pli44jGdipJkJPNBlyHnlX1yFlqGunaKGTG+Yw/roCjOcdbJJgJ53665S6PE+95qLWmzzzeiXU/0HmRm5u4lRSnCQZtSe0bIG1db8okaJCyBpXExU9+T7JhB4Rb/pGSpdKhPIva69ASZcQfjlP3lqs8yxpb13nB8hV8PAUlSKnuxKNEAl0BDSAkDTmPnHh4VUXnz3LOWNfAOhlyKOo91P1nDaZEHbUkVpzbKukUYDP9e8DkGDDt/FT5YwGusvBcQ48/m5AWmnF0G4urDQDHaFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb/eDcyAJ09VgkmKP91+NuzrGrh6UZrlt21h6KcI9iw=;
 b=WT/t9gH5TykIbvfiVI46mgzixeDscGgFZWlfnCzw9FVQUwiS1sk6L05J5zPfcl23sa0olEF1Um+X2BarIFhFjF8GekTbsS1Mk2OUSQZzbGNwkqKwUYyxQq/HzMo3gq1pgMe/IrRMcDR7YyOkA3jbqVD6Fe+0un4xFxAjHUFQ73Hq5o0LYLTjScjBI4gJlr5vNGHHmBaombs2psz3Ow/6HBtsbTEgnXfU9BsoBCanzGVJDXhJxmmL6aYJvlp4nCYDpaOqjL2IXb+yhvjqyB60dN+FJ+GouQKy4+9/O+F/PRDx8t7wzePNudsPeDPKKAXB6bqJiunNufj2aKe2p56HlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb/eDcyAJ09VgkmKP91+NuzrGrh6UZrlt21h6KcI9iw=;
 b=WBuKkX4rQqr/WACuKZ+JCvJmQb/Wm0jk4+Wdb0uL4EUjbfbEGaGrwlQxf3OF+2Jjk0yhlAQrYKKz2nKlRjpzCnLsGvv/l4yYFoQghwRlrE4v0GX+EBGN534FY+2udT4IA4OaLQ+/utSJsnw4uW7yqPNIC9FTY++W73nd/RKVUrzbOAZqvXq/ueeRVv0TLp+c6VzsDrvdz8OBaROMBTXcT3Nl5ALoI4yHRDNdUzX9FvXHytXAX/iWmr5osgpaKjVndbJaTRrcjN45pUDWrDRouaSSeN9jXRKtdbyYCeX+fjOdKpQzSZuTeCP0ceAZlxGI4aLgujFJ5xc5kAe750PXMw==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by SEZPR04MB6731.apcprd04.prod.outlook.com (2603:1096:101:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:21:28 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:21:27 +0000
Message-ID: <TYZPR04MB749147B9360103DD81B3C2E4F3602@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Tue, 27 Oct 2026 15:21:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] target/riscv: Only save vmstate_debug when TCG is
 enabled
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
 <20261023021237.486091-5-wang.yechao255@zte.com.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261023021237.486091-5-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0011.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::17) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <58aa2e9f-b28f-40d6-b000-ca44ec1f8964@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|SEZPR04MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 737f6f84-8d2e-4e88-3487-08df33fae9d3
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWTq462A1ci1xfPBdi3ebdlUwEnBn9/d4DAtRjxz4e82sS0X5ktfyLuehX0j/CI1i1EHEPBsKFIbwB538lDD3P0+d8oTxArdUc8wAmWuTOfQmgqzqDb5Y3o7CwcSFbC/0EhlFAf2e7uKhMkTBP00JxdHig5B+a99j63jtTjw3GxCWOsWuOaLt++rj6m44mAvcNaUpmWFPfrOLlwm8ibZuvji1LVMHuBsARSFsMAYDdiD0pJSmf5HEOHGN4uxNzocbDh+Jk7x8qeEq7DYsCAREaDBWow5RBgU3bQ2Y2xubOI28/AmuZeUZJFvpBLJ92h2j9tNaC7EAq5/qEoMk7/IInxxunji1okN45pSK/XxxbyZXZ0RsuUnKI5ZwlEum2JvghkqmikAB6mRwGUn2Y/zR6v4KwhdqCbHvULCHRdAHSEbFeuXxwCCHOncjFumArULFtggjPxzKhmBILvd9+hFb0wnZ880R27DjjZcpeoR8LkQ4QFkTbklzl4y1tQZZnPyV1PgaMxtZf8zjU5vKh+GGul7OA7Tp3IwROI5jY4pfAQzeuy+KLN5toX1mLko+JWCeLU3GDNZp/T/96gHYPA1eI/TB2gcMqYml10MqSWRQFrdIIiMrDb7f5CjCNKPmBAQrKaWYPZBcMr2EwEZ6ysPVyOpuf00lpZAYhyNpmBUmpzbPK8AgoWmEwydCpXUe/1+OVIPBi8i27Gbn412dT/s7QlpjvJxUNGYLMvRkVS/4sxWM9mVyDcmKtDbnrilTubSycQad4G/nMi/eUB4031RkULRdQSVK8JjQg=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|6090799003|15080799012|22091999003|23021999003|51005399006|24121999003|41001999006|55001999006|19101099003|25010399006|8060799015|19110799012|4140399003|3412199025|440099028|11031999003|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qm9Kc1ZpeE95VHorYnJycTNzTmsxNWlPNEx5d09MWkVPSi9QYzBWZWRadmZp?=
 =?utf-8?B?NGNMalVVeFI1TGwrbXFmMllJc0c4dDdnWVpST0xtSm83b2kvYkVUUnM1SWhp?=
 =?utf-8?B?MldzNW84ZUczcVppUDhVdDNvcVoweDhJN1AzaC9MNjdUaWY2SmI5TjBvVkhk?=
 =?utf-8?B?T2FvK3M2MVNML2c1VDNlbTFrak5vRktlQXBzZERucnhLTmxxTE96TDVqWEdm?=
 =?utf-8?B?MklGRWFnamVkVGtHRWpid3k3eHdKZkdtUE5xK1laN2tDY0lvR1Z5Rm1PUDN4?=
 =?utf-8?B?Mm1MNFJGNy92bksxMmRsdjVmNnRkYTJXWXRoSEJaQnk4b01ob3FYZFBGdG16?=
 =?utf-8?B?ZDlGZVFRRlk2WkpZRHVsYU02K3F6VHhkVFdSS2N6cStYaDV1OEVXd3UvYVIy?=
 =?utf-8?B?OFJPV1BWcUdWS21aWENSQXJNYzQyWENNWXhCM0hYZnZzWk9RQ2VpVnN0UkhU?=
 =?utf-8?B?YlFKZTBxdW1aTGNxTk5YRzNHL3pJaTltYWwxQXFhOFlBTi9DdVpYVHVha0Yz?=
 =?utf-8?B?NWo1a3B6QUgrUGxHdU0vblJPaVh6MVVncmVGN1ZCcHd0NVhNOEY2NVA1QmtF?=
 =?utf-8?B?cUs0cENLTnBaK2N3SkkwWUk5MmM0VVlwRHJoakVFU2ZESHdWdTI5b3V5QUZ4?=
 =?utf-8?B?Q0pBQXNyU0tINVJHQ0E1UzJBU2FaSU9OeDVOMTJkQ0FtWkwxVUFReGtJUkNp?=
 =?utf-8?B?bm1ZSTRWT1VyQ21zc3U5UDFoaThUSC9lOVF3NzBKaG1rQzJORllwenFLcU01?=
 =?utf-8?B?WWRvR3U4Tkp1T3hKbFJmUndldDFVVUREQVhRVU41S0NZcTFKOU5IV2ZSMXVU?=
 =?utf-8?B?bFgxMDlMWGVrek5kK1pFaXZVUFFNU0NKak9tcmwraGlHTnpnMkpWSWZyWWdz?=
 =?utf-8?B?cW1BYWdTMFJlcFB0YjJnSm8yakpJNURPR3B0cDZySTRwYUtzMnlqbzBrZ000?=
 =?utf-8?B?MW5qV240aHVEbHEyV1pNT0ZEZ0lkQXpxMWtFZGZwd2RJVmozVFN6TFV3WkFw?=
 =?utf-8?B?YmFjZmFSSnVnSmFRcU9xWjhuTHllamZUN3JuYy9zZE5rZHo5TDliV0gxZU8z?=
 =?utf-8?B?d2N6UjZOTkp0ZXRUTjZSWjRYaEdhckU1eTBZY3FNQU91bStTTHFRSzBIRXVw?=
 =?utf-8?B?MGxOTTE5NHAxQ0JrQ3hrbVBZemVULzBOYzZLdVF3MDNhTVNkanEyNi9vVXZr?=
 =?utf-8?B?VDVoVVdhczVtTFJTM3Z2N1ZOQmtGUlNBWU5MY2kxY2J6S1ovOWJranphUTAv?=
 =?utf-8?B?TzNYMmJWcjNhaEx4YWk0UDRqSmhLTWhxbXNiRk9rMTdXZDR6bmM5Ni91SmR6?=
 =?utf-8?B?OERxWG10Z0IyR2xHdTZiVndDK2Q0djNFd0haSmhVMW1UdW15eDNtd0RHdUdH?=
 =?utf-8?B?MUNld29TdEpvR1VTRUxCTHdlTUlFYjdxUi9Dc3dZOEVVbXpTc3dNM0dKYTlo?=
 =?utf-8?B?QWczWFVXRzZGSWdoYWRncmdHMkl5amRESzRrbXZoa05uZHZSczNJL3B2WXhN?=
 =?utf-8?B?M2ZVTG95bFhzd0psaWp3UkpDQnVJWHJqeDYyUS9zMFZKdFl5ZFQvQkhzekt0?=
 =?utf-8?B?aTBrdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amlpUEZwZy9WV3BEUmN0c1h2VXd5ZG9TdnJVVk5HS0p0aEY3alBPbmhZZGhn?=
 =?utf-8?B?Tk1kOU9MZXZrUnhORnd0VnpVb3NtY2hINExua0wwZ3EvNmhsQ3FQNEVYRUhZ?=
 =?utf-8?B?a252MzhKWkFNOUwrMmxYWFJJSEhwdUpoVnpPMmdlZzBTcmdUZFlqTHFEbnlM?=
 =?utf-8?B?NkppVHF5SUJnY1V2THpsemw1TG52ZUpXbHNqZk1tNWo5VXp5MUxIOVJIUzIx?=
 =?utf-8?B?bTIraGJUMU9ySEl1WmZXcXdMeXozN1E4UHZDWjZSQm8xOWE5bWZDL1Nhdjlj?=
 =?utf-8?B?WnFLSjhNZXNlRk4yY2pWV3FveWhFeFpnS3dDM0ozVUVIRkszNDdHV3VRWGo0?=
 =?utf-8?B?bUVpUTY1RC9ZZkEyWDFMWUxKY0JKb09DSlU2QnNIeGhscFhHa1IrdVMvSG9v?=
 =?utf-8?B?eC9Fc1lvS0NnZTRBMVFsV3NIUGhoZjhRRElzWGsvMjM4YjI3KzA5c1BKK3hK?=
 =?utf-8?B?VEh3ZHZMbkZYYko0Mi8rVmd5ZGtxNFhPVW8wVWFzejFkc3J0U3ZZMGtSVHZ2?=
 =?utf-8?B?UXpWZkg0L29WNFBqMnJKQW1QdDQzZVNTakNlKy9va1d6ZTZDaC9sSThhd3l6?=
 =?utf-8?B?UXZucGpTc2hlM21uVjkyWGRLQlhQdFJvaEdIM25EY1FJdUZxQjJQbSsybDlV?=
 =?utf-8?B?aWxJR2pXWGM0L0IwdVZ1L1ZMdEhGejZsN21XbU41NTlQNUh4cCtvSVFIV1pX?=
 =?utf-8?B?cGp1dkZRdUt5UVp5a2dHczI2a2RjM3FHY0VNWFlMUTk2TGExYW9sVVprV0Nq?=
 =?utf-8?B?YjFGZGJQQXJWZTNZK3JLanI5dFN0MHhQMmlTL3pTY2pWR1JpdHNXTGREMFI4?=
 =?utf-8?B?SnJZVG1vOGNLSkh6SjQ2ajQ3c01YZ3dPalRyTUFROGhTend0K1RaSHZMWEN4?=
 =?utf-8?B?Y2hJQUtNSUpWSXNPem1MeXFjSDBLOEt4VWNwN3hBQWROSzhqeFEzT0hwUGho?=
 =?utf-8?B?K1dPclUwb09MTEtSMmNFdzNmeUhnbk9TTHdoTURxSWY4dm1WdFplalNzSWxQ?=
 =?utf-8?B?U3ZaV3ZhcEplblFaalZNZHYzRW5uLy9uQXVjK05EcjlQMEs3M0JoTXpxR1Np?=
 =?utf-8?B?K0k0dkdrbHh4VFRSQThWelB5bVlNdWlzblJ5RWtUbWZadG1GR2pOZ2Z1SzJo?=
 =?utf-8?B?MzNiZjZNSGxQRHB1WnB5d05VUWJXY3lDT2tKdTlMTWZtekZzcFh1L3BzcGxL?=
 =?utf-8?B?K2xHOHd2Sm5SVFdhaFhKdnE2MWlmazV6THlxTlhSRUdNK2VXVkdRa3ErQXVo?=
 =?utf-8?B?amdLMDkybFZDMExaNUtiVVRhcHg4dzRsRERNcjVISEFnOVpTb0I4aDJKMmJr?=
 =?utf-8?B?Yk02a1Y1cEZVM2Q5ejhIOE9kRUtKeTBrbXdNakk4K3QvWVVwNk5RVnhjUDZN?=
 =?utf-8?B?NzNVL056cUxkVkgwamZleVBic05XVWF6cjU3aWZYMldvUHZSSlBpbzlsZFpH?=
 =?utf-8?B?eS82Z3o4c2YzR0VBZXo1RDB4T3ErTkpXUW5hSXNZc055dVM5dThybU5UT0xv?=
 =?utf-8?B?Snl6SnBoblAraWU5RmdCNlVjazY4Q1FtK2NZRk83SkUvY2IybWRtaTh0RGxo?=
 =?utf-8?B?OHd4VkplM0UzTm44cnduM3dwUi9ONllEQ0dwWlNKOWY4UVA3QlMvM3lWNFY2?=
 =?utf-8?B?Z0F3RUFQRDFLckd0b0k4UHNod0t5eXRmUWxYaDRKRVh6OEttd1J6QmFkWE9k?=
 =?utf-8?B?a3NEL1kydmtXcVZQWWtObUphSGtyQUV2UkRNd0pUU01nZDZtZE40Y0lESGRE?=
 =?utf-8?B?K2UzN2VUL2lYcy9WTmU5UkdPMDdPMTN5bHFrYTUxcGxJNTQ4aWtXUmNRdFZD?=
 =?utf-8?B?WjRrY0kxWmxWY2hUaVYxT3JoNEh1QlFIekVwRWpnbXFhUVNmRUx3ZWM4SmVz?=
 =?utf-8?Q?my+W+vzlyI8EE?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 737f6f84-8d2e-4e88-3487-08df33fae9d3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:21:27.5866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6731
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


On 10/23/2026 10:12 AM, Wang Yechao wrote:
> Commit d45b9bc65515 ("target/riscv: move TCG only files to tcg subdir")
> moved the TCG-only files into the tcg/ subdirectory, so env->tdataX is
> now only allocated and valid when TCG is enabled.
>
> However, cfg.debug is always true in riscv_cpu_properties, so
> debug_needed() unconditionally returned true and the debug vmstate
> subsection was always considered needed. On --disable-tcg builds the
> corresponding fields are uninitialized, and attempting to save them
> triggers an assertion failure in vmstate_save_state_v:
>
>    qemu-system-riscv64: ../migration/vmstate.c:737:
>    vmstate_save_state_v: Assertion `first_elem || !n_elems || !size' failed.
>
> Fix this by making debug_needed() also require tcg_enabled(), so the
> debug subsection is only saved when the TCG-only state actually exists.
>
> Fixes: d45b9bc65515 ("target/riscv: move TCG only files to tcg subdir")
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/machine.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 0de06e9588..c5f0261ba7 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -324,7 +324,7 @@ static bool debug_needed(void *opaque)
>   {
>       RISCVCPU *cpu = opaque;
>   
> -    return cpu->cfg.debug || cpu->cfg.ext_sdtrig;
> +    return tcg_enabled() && (cpu->cfg.debug || cpu->cfg.ext_sdtrig);
>   }
>   
>   static bool sdext_needed(void *opaque)

