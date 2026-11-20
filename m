Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C06160A2600
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=YsYfLfiF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUI03-00085q-Si; Fri, 20 Nov 2026 01:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xUI01-00085U-BW; Fri, 20 Nov 2026 01:21:29 -0500
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xUHzz-0001rP-Aw; Fri, 20 Nov 2026 01:21:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nW4UtIPk94sLWJ/2dD0IRt3IawMweqiX2hNf1657ots4e6olS11gmPtqE0iNfWsQyNloxEKoca1tt2EyUaNVpBNHwxA2u6lP8SSoxwPnxVpmdluEvecCqd++r9uIXm7z3SdtoFT5BcrmVDzP4nmcL6jQNtjZBDXlV/WrlW+tOY4WISJtSI+rU6eSJkqp3ie+fPT30gfDbd+W4TfmmKaCOip3RaqnPRJZxEpL5Mx1Ft47TfReyUTBdNp+kFbTYvcjCtxW4UhmwhRTFhZuDlYujebl4xlw3H9+aEQEAScaFrwA5ItKf4PFMt/zkkzrl2b0w8ozJT9PLbqTbom3KH2kbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtyRigISa7DgOOnnSbyf55Px+rUS8WdVcoYEeVst/+U=;
 b=EF1qLFTgm/37hPkbBa7oxhGRjgZH0ax9+zE8n5FXGHhQe/6UeZGgoOknGpY/Su/emcsRJ6cbAhsOHrtz4udB6X107S7WgK+WqwIoIPYLZ4tbKt/WCKR4krRU9b84UdYQO4xDnbTZlDOpyZ8aYleS2b9VoPvHOpIw3MS94Dtm/jdZ8VDaDrhTBGex7wYVVGGUybXFi10JC0mhZMdYtnNryKbm2RaUfVktosuAq8Tvj9hN9vXN7/7pHOkmk74ljSrgq8x44EUmCf44TNswrk5LGQ313gGqHEcZD3AXSAvoWrvXbkJmj0g21B8QwlMHL4AjBFwnS3Pyd3ExBsXSFpkBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtyRigISa7DgOOnnSbyf55Px+rUS8WdVcoYEeVst/+U=;
 b=YsYfLfiFiB07ogNh6sokcqS7H3wHS5vos+vvY9mEJk9jvJAaF44c30BGOAEpoKuNK6ByXIREVGMbNh0lxVlYkkFmttNudhjt+5VPRMBbSEQQRWSKN5RV1pVr86wL9QLzhOuKL0VntPs/DlVe2kDDkejR4DcHwW6ZA6ssCHK+68WHSOoIJN/V9ta0tyA05odJbLQB/bdFRI3GjX2ZDsu+TI1Ntpk78OfaDxqxQjeSdrBQopvVL0W12pWbIcY7cLAFOsC3LyMsjsjwT2wokPJy1vf34S3djTDLccK0XIkVp4dud0XyetP/ZlLdXXSENdRpHcWpM7q3wVKTzc3tcMjGEQ==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by KUXPR04MB9299.apcprd04.prod.outlook.com (2603:1096:d10:7e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 06:21:20 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 06:21:19 +0000
Message-ID: <TYZPR04MB74914FDB61FBF04C60BE0731F3782@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Fri, 20 Nov 2026 14:21:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] hw/riscv: make UART FDT helper consider baud rate
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
 <20261119082356.1264726-3-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261119082356.1264726-3-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <c0e42b55-1a33-4d18-ae1d-cc20755c6841@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|KUXPR04MB9299:EE_
X-MS-Office365-Filtering-Correlation-Id: 3854ff53-e86f-485f-4055-08df46ce7d75
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWTq462A1ci1xfPBdi3ebdlnre1z96abVt7MtnnOx+EDrg6CulRsk3IKHx4EuPAtF4IjvzPu05DF+q0xJswzhr3NMu8ohfmrqyBJsbvFxAOUu0pB2nlTOyGoFjIxs8miL61VA+seP/lFN1AKyRnmWpewfMJQfJumUf2Jlstv3vAFtsNhQsPTwLqXmubzyV4Rl95zqtC166vQgF6HOPTEnNDnjPYE4d3FN/zTgq5rXLMxnLajjdSWdoTb3Aq0945mY8duPWzESq3sCUQXhg5gxHVcd+MrT2sh4p2VPzTgnbccixLML23AWDoLps39r2wGEJduQ32ieKSDGZI1tNnc++cgDMhiZLgXUyERxiE9KA9IlSrkdUnpDSlqykaItSVpU2YBb9YDxtu7soO1zkAzzPc/6EaH9LGWg/7NpOXGA1gfQPd7YNnzcxPxZldTpOEPDYOv8sEVith17MCuwu/PJtDI74KGosvpcABVPc22KrtArqzZNTqYZdOpmt8sevAadZe5malcGS6xqnvuCSWGBYhWStv583uYwf2knhYGy2ff+B3xAddPEDxuNHT+lxNrvzqKOZrSboa8EDqgH+LBiRXMxcr8HPmDOTaOiacJxPEsW9CIPkeUp0HKmyxNO/wuUzFZaCXPrMft6YKNp4DWyID/IplJPMF7zdlAU9VKy6c15R1KPUfRjxV3/yIsjRiVLLk7+BW2/EEwQstaQ0tyATeIYIdahGuXoM+34Y5j89Mxw2HZMuVrxaWElX06EHC04HJ+asbKstE9BfIVXyABku9i571IwlBbgY=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|15080799012|22091999003|19110799012|23021999003|8060799015|41001999006|4140399003|24121999003|55001999006|19101099003|51005399006|25010399006|5072599009|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0ZhczQvaFE4WUplSmF0UnA1dTNTaEhVMFVoTDNnSm0rclNKUnBLMVlCbnpS?=
 =?utf-8?B?bjc1bXQ5MTVLSU9LUmZIUXpDS1VUUWswd1dBa2FQVUp1UFRVYXVJcW1zb2x5?=
 =?utf-8?B?a1pQeVBYUTlhS0h1aVNxT0ovdENHekVLR2NncW5iaERrRGs5WEhKNVhxWFdm?=
 =?utf-8?B?cVNDdnR3Z0tyNHAxcG9jdk1HOEtPa0hxbysrQWN4bXFxMjV4bWNBWFFwNEt2?=
 =?utf-8?B?WUlzWVErVHdSNjJIRkFJVFJoS1FUZ0cvY0s1SHZIQ2JwWlIxU2ZtcVUxd09v?=
 =?utf-8?B?RVFSdXNJSy8yaTNjWWpudk5NMzdpN3JndGYrZmZaYmgxN1I4WTNXM2Q2NDZ0?=
 =?utf-8?B?SkRUU3JHeE9XN3E4NHMydTdtNmR2ZTFkVzNLclNkK3BOdGJJTlFUNnFnMUdO?=
 =?utf-8?B?USt1eVRpNm9sbE02K3NHTWVKaDZ1Q0svU05PZ1ViYmx4bmxYa3dlajg2MmFY?=
 =?utf-8?B?QVlkU3BQU0t4NHFkRUZTbE51eld3RUdGZ3h1UEg3a1BkYUlVWDhrMFBsZTZ6?=
 =?utf-8?B?NHVDSG1jZS9iSDJXdTQwbExEMmRLaWN3MXU2bHJBU1l4OWVyVWhucm9LVmNr?=
 =?utf-8?B?WFdhRTZ6SzZRWWIzdHEra1ZYZDVvbzV2SHVla01IaFpOS2tSU2g5bHJHVWdD?=
 =?utf-8?B?WjEwZk8rZURpVXRSS1JudXFaRkcwcCszVmFYUVp5RjRKNytRTU1GdVBtWG1Y?=
 =?utf-8?B?VFBnaS9YQ01WYndRMldQOWVzc2sxOThES0FGMGhYRW1iaGpJdVh3dDY1RDBi?=
 =?utf-8?B?a0xSWWxqUzRocGhzQURrMzBYWVV4SFk1Szc2R1dtV0lYRTFGUS9CbHFwQzhl?=
 =?utf-8?B?by9qUmg5elljVWt2eXlYYThZcTNhTnVMSDllU0JtMDNaRjNTajRKdE84TEZj?=
 =?utf-8?B?ak1wZCtQQlB6WVpwTUYxL1VHenM2anZwdVZKZnpSeXY5TzIvTjJhSlVvTDFO?=
 =?utf-8?B?UjkyRml6dVZTc1B1UkUrWE9NUnl3WVJ1dkVVU2ZmRlBERjBESU5rM0g4a3RK?=
 =?utf-8?B?U2UxYTB1L3hjeUdZMEEwRnVvWFJmQnhVSktFZlIzc1owTmFFOXBaN0FmN1JU?=
 =?utf-8?B?TWJ5S2M4SXR2UG4vVGNBbWRHYUhValZTRVVCZ3dQN1hrVVBaSVd3UHV1bWtI?=
 =?utf-8?B?eUxZekVqdEJ5OGY4MlAyUzJCOFpFR3lIYXUyTWNFbTNZUHA3QWttUXk2YmxP?=
 =?utf-8?B?YTc1VWxUb1BWWElza0VjVUZDbWFMS2lpV0E4T2NIelBIME12N2tOaCsxMVFM?=
 =?utf-8?B?L1M1aDViMXBPdXdkQ0Y5eWJWWlI4OUp0OHRqaU5sTEY0aWNKS2hIa0I0TFQ4?=
 =?utf-8?B?UkFrQ3llend2blVycUhZcEd4eE0zZTYvMlNWV0U1STNZQ1Z2OS9vZ1VzTEU5?=
 =?utf-8?B?bllCK0dmZzlIRGhuMHNUeFBvWDhqZUplSlVkeFZQQW5idFZyN2xReThtYkg4?=
 =?utf-8?B?R2pkRmVoRFZ5NUNYbnF2ZEhsQ2tSNnIwVmcvN2FBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUwxVmdPQlhRcGJKRXIvak0vMzBuRjBwVFpYM0V4SjRROEtDbERsMVYxQW1a?=
 =?utf-8?B?cnBDVVZxbkpRTzl1U0Fjc3ZSakpoeXdBdjI3eHB5YTdvdUVWd3pURFhka2Rs?=
 =?utf-8?B?R1lxTVhjeXdLeTFyUDVqVGNEVnRHcm45ckw3cWxFTlJNclZST1hTMjc2VVVI?=
 =?utf-8?B?K1lQcXhLSDk4bjROcGRQZ0FscUhvSlkwOEdlNGhGQm1yUzY1TEhIYzNYUG5X?=
 =?utf-8?B?clZ2bjBnaEVpK2wyT1FXRnRuaWVqYWVkN2RGelN5TXpNRC9MTm9QUEVzUU1N?=
 =?utf-8?B?T2RFV1pXWlg2N3kvZXhyUkhzNzQ0WVpMaU5zSzBBMmxNc1Y4L0NnZFgyd1RD?=
 =?utf-8?B?emJVZkppNjlPUXYwUTFCQ3BLQnAyUENNUlhlV21RcllKN1dFcW8xZjFNd09s?=
 =?utf-8?B?M0JOUjFRQm80cDUzU1RXRWtNMlBaNlVveTZpSDBseUtDOFE2R25uTGxndkJ4?=
 =?utf-8?B?c2FwNkRzS003YUxSYk9mMHF1TE13aW1ZSitnVVlpNUhBOU5oL2xMQjh4MDEw?=
 =?utf-8?B?eXJXSlgwcVU0Zno5b3N1UWUveGRIbXB6dC9JQktOWDRZT2RUcEVQN0tXZ29T?=
 =?utf-8?B?MUVvQk1hQUE5ZFFDSlo2WmJ4ZFI1UEZLY2JzNTdTL1VXeUZDNk9vakVYWTZi?=
 =?utf-8?B?bktoYUU2UEdlSDdkNEJlSEtSV1k2cDY4OHlmbER0QXlsdUljc3R0ZURHUnJZ?=
 =?utf-8?B?YUhGS29RQ2FKbzNSRGo1ai85bFl2MmZHU3RFa3hOZ2hLZ0RnY1BwTzFZNlJs?=
 =?utf-8?B?WGJxYTdFekRUd1dleW5ZVVdJU3BISTFnTlRGVkVwZ1lTQjhqaHYxMXRsV01q?=
 =?utf-8?B?S24vNGUwUTdxSFNFOW5EMEVDbnplb1ZhbnpaekRDUFdObUh3UWNyRWt4SEo1?=
 =?utf-8?B?ZlF5eHAzeXFlWWhFQnJhRmNaVE84cGNXUFZhcnhFUzlYbk4vSWdRS2d0REcx?=
 =?utf-8?B?Z0dZenRZenFJSE5yUE1Vd0d3VTd5cFpaZ3I3SGdTSjZKejVPYllieUYxYzNV?=
 =?utf-8?B?akhad3M1U2RQSmYwQmpBTGJaTlgwbU9qa2o5UG5QSUdyTjFNdGI4aWlLOThn?=
 =?utf-8?B?NWo2eFZpWnBlT1ZZT2JUc0d0V2g4OGwva2N5TGlNV2thM0UrVFNjcXdGbGlR?=
 =?utf-8?B?SkQyaDFEeEYxaEdMZUQ3cEVTTkI5dDZKODNINDBEWHR2UWZhQ1Z3c09wT2Ez?=
 =?utf-8?B?SlNjTmVBdXBuTjEyZXcrbGVCNHVDUng1OTN0K1J6WklvNHBhbkdRMDV1b0Vo?=
 =?utf-8?B?Zlk5anZrSTZzNWFFa2diNG81WHptUERHbW5mb2RhMktrREptZDlTN0hJb1JN?=
 =?utf-8?B?VFQ1NkVPUDV2aWhqL3Ivc3pxRmZ5K21TRU9UN0xhcDFENlgrbUZ2YU1yMTVB?=
 =?utf-8?B?WWExWXp6c2d2dHN4VXRUUHZSR0QzRlB2eHl2T1BEZGZMZmkxLzhvNXVreVdM?=
 =?utf-8?B?TDc3RGZ6eWwzUi91NWE5eWlUV2ZmQ2FiUVIzMU9HRVpwMnRjN0E4dVgrSERs?=
 =?utf-8?B?N0NKejBlWkdhRXd6aDl6T3VvSkYrQnVuMThvY2xEdEc4L2ZjTUpESVQ0emJ4?=
 =?utf-8?B?RWRmOWYvTUJMbzNxSE5qcEZhTFJ6WW9nWk1Bc2h3b0kzTjlpS2JwbUdpYzFI?=
 =?utf-8?B?NXJiL2V2UG9ndVNoeHdjZStvVm1QMFJ4VnpmQkNKSERSYjZVL05ZT1NVRCtG?=
 =?utf-8?B?OTlRMWliQzRkdGNIblRjUy9EeS84akM1WS9SRDlZMVVLVzM4aE1sRWw3QkZh?=
 =?utf-8?B?VlpSVlRxWFhhcXRjYUw3Tmh4clVLL1dvekJpc2M1Ti83OUxMV05QUGxpdStv?=
 =?utf-8?B?bjBvZmxKSnZRYzBzRzlOR1lqcFAxd2RKTEI4bHA3WDlNR09vdnV3OWs0YXVH?=
 =?utf-8?Q?+64fpJCqdfp0k?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3854ff53-e86f-485f-4055-08df46ce7d75
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 06:21:19.8813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR04MB9299
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/19/2026 4:23 PM, Daniel Henrique Barboza wrote:
> riscv_create_fdt_uart() is defaulting to a 3.6864 Mhz clock, which Linux
> will interpret as a 230400 base baud serial.
>
> We need more flexibility to set a different baud rate for UART devices.
> Add an optional 'base_baud' parameter that allows callers to set a baud
> rate for the related device.  We're keeping the existing default in case
> the caller does not care to provide a base baud.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>`
> ---
>   hw/riscv/fdt-common.c          | 19 +++++++++++++++++--
>   hw/riscv/server_platform_ref.c |  1 +
>   hw/riscv/virt.c                |  4 ++--
>   include/hw/riscv/fdt-common.h  |  1 +
>   4 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index e90502b1bc..685b64531b 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -21,7 +21,11 @@
>   #include "hw/pci/pcie_host.h"
>   #include "hw/riscv/aia.h"
>   
> -#define UART_STD_CLOCK_FREQ 3686400 /* 3.6864 MHz */
> + /*
> +  * This 3.6864 MHz default clock results in a base
> +  * baud of 230400 symbols/second.
> +  */
> +#define UART_STD_CLOCK_FREQ 3686400
>   
>   void *riscv_create_board_device_tree(const char *model, const char *compatible,
>                                        int *fdt_size)
> @@ -798,11 +802,14 @@ char *riscv_fdt_get_uart_nodename(hwaddr addr)
>       return g_strdup_printf("/soc/serial@%"HWADDR_PRIx, addr);
>   }
>   
> +/* If base_baud = 0 this function assumes a base baud of 230400.  */
>   void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
>                              int uart_irq, int aia_type,
> +                           int base_baud,
>                              uint32_t irq_phandle)
>   {
>       g_autofree char *name = riscv_fdt_get_uart_nodename(uart_mem->base);
> +    uint64_t clock_freq = UART_STD_CLOCK_FREQ;
>   
>       qemu_fdt_add_subnode(fdt, name);
>       qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
> @@ -810,7 +817,15 @@ void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
>                                    2, uart_mem->base,
>                                    2, uart_mem->size);
>   
> -    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", UART_STD_CLOCK_FREQ);
> +    if (base_baud != 0) {
> +        /*
> +         * The base baud formula is base_baud = clock_freq / 16,
> +         * ergo clock_freq = base_baud * 16.
> +         */
> +        clock_freq = base_baud * 16;
> +    }
> +
> +    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", clock_freq);
>       qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irq_phandle);
>   
>       if (aia_type == AIA_TYPE_NONE) {
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
> index fb770cf6fb..5cb55a43a8 100644
> --- a/hw/riscv/server_platform_ref.c
> +++ b/hw/riscv/server_platform_ref.c
> @@ -320,6 +320,7 @@ static void finalize_fdt(RISCVServerRefMachineState *s)
>   
>       riscv_create_fdt_uart(ms->fdt, &rvserver_ref_memmap[RVSERVER_UART0],
>                             RVSERVER_UART0_IRQ, AIA_TYPE_APLIC_IMSIC,
> +                          0,
>                             irq_mmio_phandle);
>       name = riscv_fdt_get_uart_nodename(rvserver_ref_memmap[RVSERVER_UART0].base);
>       qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 016003d73d..9eccf62d4f 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -398,11 +398,11 @@ static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
>   
>       if (s->uart1_present) {
>           riscv_create_fdt_uart(ms->fdt, &s->memmap[VIRT_UART1],
> -                              UART1_IRQ, s->aia_type, irq_mmio_phandle);
> +                              UART1_IRQ, 0, s->aia_type, irq_mmio_phandle);
Seems the above should be as follows:

+                              UART1_IRQ, s->aia_type, 0, irq_mmio_phandle);

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
>       }
>   
>       riscv_create_fdt_uart(ms->fdt, &s->memmap[VIRT_UART0], UART0_IRQ,
> -                          s->aia_type, irq_mmio_phandle);
> +                          s->aia_type, 0, irq_mmio_phandle);
>   
>       name = riscv_fdt_get_uart_nodename(s->memmap[VIRT_UART0].base);
>       qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index b3b14ada0a..2a06aedb61 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -131,6 +131,7 @@ char *riscv_fdt_get_aplic_nodename(hwaddr addr);
>   char *riscv_fdt_get_uart_nodename(hwaddr addr);
>   void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
>                              int uart_irq, int aia_type,
> +                           int base_baud,
>                              uint32_t irq_phandle);
>   void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
>                             int rtc_irq, int aia_type,

