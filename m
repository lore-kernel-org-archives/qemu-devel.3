Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958AC606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=gxtVv+8z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR4XM-0001rX-3x; Wed, 11 Nov 2026 04:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xR4XK-0001pk-1W; Wed, 11 Nov 2026 04:22:34 -0500
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xR4XI-0007pF-B5; Wed, 11 Nov 2026 04:22:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkpCuHnynxhf1Gx8gUM2nNcp/WlIKq25+VZiw8MZPDdMxHR5lgCsN/BdV0ijNA2ryJ+F7NPzgIIdT2HCUF/UuF/37oAbGiczxkvjDzP3IqY7kUoEjBVqEM6TA8jhOceM3bq7YDfTnG4hXER8JuL3CgXA9RXnbN7Mmjft1xlfsXi2swgeB7+1OkuC6HniMwOZBOPBNRKLFvefkk4PzX9bnPASr3oxKlsVM9CibWySy8ALM84Isc8U9FoSIxI6vkgWN++h1YZz2ZhG4PmMonxMQTQ4mCgZq6fi7aTQz8RpmfWkJhvueV7C7OSYi4Y122S/w/l6rZRXRb1K27xkWyBC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtlufnC+c3jbkMTmZAINBHyxAMNmXxaqFxzu7Xy+/os=;
 b=IF3fklrD6xartwW+8LmCN3nzqc/9/8q0dHwRNNKYDgNumB78hYpbANsrFZYV1Ip4AnsBknazuy1Tbdulo1zkxRWgMrrR/tx8KVUNcAi8Kp9CyEI9yDTBSGx/qRbO3SZPgVKE4Ov6HYXDyhexgN4XsfiqXYe9GlGZQicIRdrNSk3CaerUYrhzXbYi02xWq86nBD3IGsXfcPP1CAmNlfI8gkdw4zPhLf2wenCvlwHchNf2P9w0QXUQHx6tOvdEiJ0SczzNdbJluwE+DiaWy83vxRSA2PpKYZNj7gw3xOC7FZQvFK8Avve6TiM61s1KtGukYlsmLZJrQzhltv9wj2BHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtlufnC+c3jbkMTmZAINBHyxAMNmXxaqFxzu7Xy+/os=;
 b=gxtVv+8zHQNn4hZ6EscHqcCp353t/saktY0Dd6xngSlkkE/+HLhlVmz/0Epvph2IzFM2+bZZ+j16tv606L1DLa2I/g32krZGG7jvYmDwPwJqrEK7tMKekghwu7X319HQMvhwPmu5DCyvy7Gww4yaWbnt14Hx2tryoolY3Maj9Df21qHgcGgThh7i4EuzjJBLg4lnDGCJSbOkpiD48XKGMBuO1ZJ3hqC4H9dRUse48PuPVlLSOmyMQhRxwFcBRM+6MJyFDEtB5UDjkweWOFexuemzdjGCik1Ina/4rCj5qy2YEK9xR20UcGomfaTFLIXQhi45fVkEhUMAZPLxGyM5nQ==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by PUZPR04MB6383.apcprd04.prod.outlook.com (2603:1096:301:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:22:24 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 09:22:24 +0000
Message-ID: <TYZPR04MB74914BC74A1741FE0BB2403BF3712@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 11 Nov 2026 17:22:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] target/riscv: raise access fault for Zicbom
 MMIO-like accesses
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 philmd@oss.qualcomm.com, ZhengXiang Qin <qinzhengxiang@foxmail.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20261111065815.167869-1-daniel.barboza@oss.qualcomm.com>
 <20261111065815.167869-3-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261111065815.167869-3-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0045.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::8) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <244acc3b-f0de-486d-a555-9860b08a2a27@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|PUZPR04MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 805108fb-c70d-4952-2b66-08df3fd54b8b
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|24121999003|15080799012|19101099003|41001999006|19110799012|8060799015|51005399006|22091999003|55001999006|25010399006|4140399003|5072599009|12121999013|6090799003|440099028|3412199025|10035399007|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjdjUlYyODByTDNuYklvMWZ5c0hndzZyVDFld2hvbnUwamdUendMczd4MDNJ?=
 =?utf-8?B?R1lGaTZTZS9KUDZtaFFHbGF5UGRCU2Z6ZnNrdEFRenpFOWhZUDg0TlkxcDVT?=
 =?utf-8?B?ZGV4b1dqY29uNHlWdmR0aWdhSzJVMVpjTnRIa0lHMHJURDY4bDNibzNLNzJk?=
 =?utf-8?B?TW5mQ0VNKzFKdWZuQ3lqNE5YNC9qSU40ejcwWFRwWVV5RHhFOFl6SE9HQzJk?=
 =?utf-8?B?ZUVGQmlqeG1PaE9qMFVQZG9TcmpvTS9kRzJUeGhHRW5Qd3hYREVtM09jbFdR?=
 =?utf-8?B?aXp5UkpNbGp1Q05pQVh1WGtKREpYd0lMN3V6RDJXa21pMlp1eGRmQ2hvdmtW?=
 =?utf-8?B?ald1YyszT2pXMlY0SFgxYUhBbmd5MWR3UTdOUEhvK1djU053YzRodHhiQ3V3?=
 =?utf-8?B?RWhGcnpSK0QvQlNxRHRsWGZkSXI3YmR3VStKUW9LRFZVOG40YTJrcGZZcXZP?=
 =?utf-8?B?UzJNYVdMSHVmL0dwZGgwamhTVExab1dqQ2tydFYzMHNwaVNEak9ubDQzREJB?=
 =?utf-8?B?djNQTGZxS1J4VnFTa0dnSW83S2MvZ2REblpaVThudmFJKytjWC9wMml0cmZF?=
 =?utf-8?B?L0VyNmFheVQ3ZlhSNU1JanlsWFJWYVFDVUMrUVlBdkw4SzZFN0pZL0hqOVBp?=
 =?utf-8?B?Y1htdkVtN0VqN2xNeHB4OFBjOHhGYUZldDYvbitmMHFCcXhSVEtlNEFucEJa?=
 =?utf-8?B?bUdIZklXaU1uck42S1M3dHRNcEFWMk5oeDU5T1g5ZVdVVHJHeTQ2WkNPLzlo?=
 =?utf-8?B?Mi8vWTJxVWRwczBlTFhxZUduREtjb3NDbFB1QjdwSzdMQ2JJL1Vwd2hzOUVu?=
 =?utf-8?B?b2ViRnplcERHT2tWaUhCb0RFNmRaa2FhdTh3ZEVBOVBaRk90SGVQbXc2RXhG?=
 =?utf-8?B?NXNTYmdtVUZIeFUzVGQ3M0hhM1p0Y0pkNlhjQUhtZWpreEJVYVRGOGo4TlVW?=
 =?utf-8?B?ZkRBZFUveFBRaEJEMGowSUZBUDJQSnVCeDhQTEJWM1NVcHRCeHdtQk5lSU5F?=
 =?utf-8?B?MnBVbkRwL09RTklubk9LRkRoWkdYMnpKSWp5c21jTHg3T0VVNEc4Und0Sjdh?=
 =?utf-8?B?RFI0eW1DeExGaHo1YnRUV2txSzRjbFdscDNld1JqMStTQlBtOWxsMW94eWoy?=
 =?utf-8?B?SVhNWkpESlZGVXpFaTlPNjBZdGZIZ3NxOUJqOWg0b2RFcFNYbnQrMVJ0bWhj?=
 =?utf-8?B?YWRmdnA1RFhqalVkeUdDNXNnaHBRWC9WOVZsTXBESnZpQWQ2a2F0UHlXbWNm?=
 =?utf-8?B?R1ZrVFhiUFVCSEVtUmdjckt6V2dwRXBRa281Q2UwOXZ1di8zL1lLWHovaG1l?=
 =?utf-8?B?WWc5MTNOQTdQTm9VRWVuMEk1MWkzUnlEdDlyTXR0eFhIZGxVN2NqeGlrZ3BB?=
 =?utf-8?B?b2dPeEcwZjZkcHBXYWN6Rjl6cHBQOHpqdEc3MWROOGd1QStmQ1Jwa0xtVUpT?=
 =?utf-8?B?MFBiMW42cWNZQ2RTZ2JpZTFJYmtzQVpDUVVVVE5HYmk5YWxBYlVSSXFkSm4w?=
 =?utf-8?Q?StwBmk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXY3dzVOSUFnNUdtWnY2WGJkRmZ5U29CVHdzSVVwVjR5aUVOb3kySWJoOCtJ?=
 =?utf-8?B?RHoxNmNuVHE3SVFWSFYwdzNua3FsdWlXTE10NkVPRVNzSVFXYjNBN0diczc0?=
 =?utf-8?B?dWM3Y0wwNTFUMWhqYWlwT0xTdUVqbWhJQ0o0YkhkOGhEbHp3MmN2eVdicFNh?=
 =?utf-8?B?R2tnd1dBZHREZWVIZlJXcllFeFdvQ3NJZVQ2bk1BRE43M0tVOU9YWVRNcXB5?=
 =?utf-8?B?eHBraWJHMWYxeDJ1a01PWUl2dDBMb3RsZ0gvMTVtYS8zR21rQnJxSGQ1c2FZ?=
 =?utf-8?B?YWd4WHdJNUkyZ3RxcVg2NjNIZkF4cURCcTAxZmpCVUpoVDNibFZqdU42U1l5?=
 =?utf-8?B?T1M1M1QxaW5ZNy9HQ1BHampBdFlhd1hRL3c3aVhPQTljNExIZ0NvSGNWM1JH?=
 =?utf-8?B?czdGa2FCZ1FwS0wzWVU4QTRqSVJ6Y1lzVmp4QXVQMCt0THZDY2FYT0tiOEZX?=
 =?utf-8?B?UmlqdVI4RVNlNVhGN09BanJlemFhQVpjVkpKR0hiYkpyd0d2QUk5TnpyaEtY?=
 =?utf-8?B?Tm5vLy9jbFhpbDVNZDB4UFphdnZWa251anE4Mk1xSTRPTVZ5ckdKNWVRNnl4?=
 =?utf-8?B?UnhTTWhZQ1ZZeEszU2pGaHBEeno3eXFRUEptM2tGK2NCeUlWb2ZRQ2tQNHYz?=
 =?utf-8?B?UlBzc0tLOXBPZ1I5UldkL0xHOE1oU3BTZTZ0QlY1aTFIb3Z5ZUYzd2Q5RDAw?=
 =?utf-8?B?cFlpQXpEd2lEK2RwNEc4VUNGVE9xcWw4RjJzMW5ML0I4WHJmWSt6Zzc5NGUx?=
 =?utf-8?B?SWVHSXNhYXluMnhKNFB6eUNkNy82cDRvRDRFTC8rSWsxNk4vNis4aHBvTVJV?=
 =?utf-8?B?eUg2Q2RMYzJvUVFZWUU4QlBSN2QwdWxZL0ZLWHBIYjFlTytXWFZucWRsS1g3?=
 =?utf-8?B?VmUra2tuVmxkQlVUMXlsSGM0bGFHRjVpNlhVOHpSdDNKWGVrZGxkcVhGRlY3?=
 =?utf-8?B?ZkdiMGo2WGV6TXRSZlhFNWh0YnJkejVpaHQwbDBRdE5GTnFpTjlJSU0vZVBF?=
 =?utf-8?B?S0NMVDI0YTdXNFZhRDNnblhwK1lDcjlTNTM2dzl4L3Z2MGVrK0Z0TlpxM2s2?=
 =?utf-8?B?dnVzaGNNWVg0TTBCVHRxcEhrRTM5VU1qa044dWNRMnpWQmViUUFJZUlFb1Ex?=
 =?utf-8?B?UnI4VXp3dFlYVGVwTjIzbUZGMElKUmcxYm16TWhHdDhWZk05YTZzdVdPWnl4?=
 =?utf-8?B?RzFoRjIvYTlpRlVjNjlqWVUxeXpnSnNKTGtjaGtsbFhKSk9aRGg2bGdHUS9J?=
 =?utf-8?B?SWJIaWhuS3FUYnRFTURhZjVkSjloV3M5RGtJMG5hVzFVQzNCZ3BldXE2VGN2?=
 =?utf-8?B?RFlGTVFMNWJCVFZtWURHbWtmaXd6UWQ4N1kwMDk3U2ZrTTlWOHJEcXd6RFJK?=
 =?utf-8?B?WU9tUkF5NEtpQVk2dWF0Q0xvc20ycERZSnJIemxMRlo5QXRTcFFPN1V1ZlQz?=
 =?utf-8?B?VC9LVCtEUFJ3cjArYW9vQXIrcXl3ZVNqa2pMMnkzVGJ6Q0VGVUtIQm9IZ0ZT?=
 =?utf-8?B?Rys4K0YzTXVTdmZQT2hhYzVQdUdZT0dJKzZCSnlXclZUQTJDTUtOdHVoK2Na?=
 =?utf-8?B?a1phT2VHa2V4VzNNcEl2bk13ajJ3VGllNlU0b1FGOGlCUUtLMHJ2eWs3djBG?=
 =?utf-8?B?N2trdmt1VlZsUUxTMmRuQkJyLzRBcjBYK0U2aFhadTRlYS9ZZ0hFRy9vUHNk?=
 =?utf-8?B?b0VQcG5uRWtvSmNmOGxlT2RrZFZScUxic2VQV3laZVc0aVpkNVMwcmZ0d0tZ?=
 =?utf-8?B?a2owUFNWNlpyMnZSSTAreWdTaVh5clBsL2EzVy9CdWhwOFhQMzVyWHljY2pu?=
 =?utf-8?B?SlRja050djNNYjRMOEdnNWhjbmtwdndyc0krd1pvdnhwaTIxUU53cDBWU09O?=
 =?utf-8?Q?yx/Ew+LyShOQu?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 805108fb-c70d-4952-2b66-08df3fd54b8b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:22:24.1213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6383
Received-SPF: pass client-ip=2a01:111:f403:d406::1;
 envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/11/2026 2:58 PM, Daniel Henrique Barboza wrote:
> From: ZhengXiang Qin <qinzhengxiang@foxmail.com>
>
> check_zicbom_access() currently treats any probe_access_flags() result
> other than TLB_INVALID_MASK as a successful access. However, a result
> with TLB_MMIO means that the target is MMIO-like and should not be
> treated as a normal cache block management target.
>
> Raise a store/AMO access fault for Zicbom accesses to MMIO-like regions
> so that cbo.clean, cbo.flush and cbo.inval do not silently succeed on
> non-cacheable/MMIO-like memory.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3501
> Fixes: e05da09b7cfd ("target/riscv: implement Zicbom extension")
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/tcg/op_helper.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index d7af56ef61..52aa545eec 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -231,6 +231,7 @@ static void check_zicbom_access(CPURISCVState *env,
>   {
>       uint16_t cbomlen = riscv_cpu_cfg(env)->cbom_blocksize;
>       int mmu_idx = riscv_env_mmu_index(env, false);
> +    uint64_t fault_addr = address;
>       void *phost;
>       int ret;
>   
> @@ -251,7 +252,10 @@ static void check_zicbom_access(CPURISCVState *env,
>        */
>       ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
>                                mmu_idx, true, &phost, ra);
> -    if (ret != TLB_INVALID_MASK) {
> +    if (ret & TLB_MMIO) {
> +        env->badaddr = fault_addr;
> +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ACCESS_FAULT, ra);
> +    } else if (ret != TLB_INVALID_MASK) {
>           /* Success: readable */
>           return;
>       }

