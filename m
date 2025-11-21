Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF2DCFA76C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMON7-0000YZ-3v; Fri, 21 Nov 2025 05:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vMOGv-0007S2-FE
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:21:48 -0500
Received: from mail-westeuropeazon11013034.outbound.protection.outlook.com
 ([52.101.72.34] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vMOGm-0001Cj-NO
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:21:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUq1PDSpokFP8gl5Xne8FUiag9NkNTBpdIDiwD5Ht7PBFUy5nodG9V4cP8oP8toR1lLfHz8NxYw9yf4k+NH+zjoYVFW7V5sBZMIni7lK/g4+OPSGynxi4p2ZzJhKuiRqT2JbDHc7SvYTci7CxmjuuaKaEFIh7TOSAj3PmtJdkAnOdJMqXJHG13QLVR6AxqiYbqz6XBqoVP9a4cSqX/I6BufKF/OExabqqlyKNxzLwNQ/NgWBT9Q/LFjKnAq0Uw+J5dhTctdn5kqIipQ1l6pjxdxtgPH742nWe/BK/pc4ocvhN507e+foBCGq9tnkc88UdlSwJ5p51e7PkgfJHuI51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocaY8YjCnSWA8CIgCquCNW2SpslqLH6gTxi0VWrnMHA=;
 b=iMarghpNUfPlSUGDycMI4RmKLyY0dnKqfcJII7dBvR61neGrpGDOWlnkNMPVuD5pYPhDif7JucUOa4TDNX9pD43Q2ykll0BVANyMdFU9HMfXv7Kjgs/+Rl7nBN3zBLCJzNbotSq+7OJnnOb6XmvZQ0FkNh6E5/KT27vjyPp4yKaxqPxQTZM9a0zTfYTTf0FKuUlLn/vFUmI8EB1wgOrWjcl4gvZUzLWdzBrkN2DXvWs3lj0dh9iDcHpecpDtrqHeyQTEmM8f28kQ95TDbkojiytaYASSKCbZEzns0xTlseWl1YW/GvCXOu1imSKSnm38zrfwgZiouise2ia3ZbgFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocaY8YjCnSWA8CIgCquCNW2SpslqLH6gTxi0VWrnMHA=;
 b=KTgdMQb69betVt4LfOYAlZDIhY1sykNYXRAD4+YIsi6ladJreSi2Ahwlo0PEA/M5ifqaJW6z84K9Afv31UyMsPlquuxVWT3W8HCwgrBWXaxerxdSUbvmvEcGedTNBIKcKhRtMoiZJ0gKs4j8h0/RRLUo5icrnbiwKh9CsZvIdVs3r72Mbr1KiF6+iMtJ8jKoMllG6GnYx/7pYqc8LGvmVn7UTpfG1rdlUE1VGB1Jghi1oN8NBmsEn2/sBalU7F3dHcXEvn1yN4xjF8I5YvC8bn9aRduiIVsfyucfYauGyCIJVhv3c/S0kRWWIemVCPX6b8ve4k11d76DC+pgvJIWjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3216.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:131::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 10:16:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 10:16:12 +0000
Message-ID: <dee22f22-c2e5-4154-99a7-525bfeb965af@siemens.com>
Date: Fri, 21 Nov 2025 11:16:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scripts: Changed potential O(n) file size calculation
 to O(1)
To: konrad.schwarz@gmail.com, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Konrad Schwarz <konrad.schwarz@siemens.com>
References: <CA+kmUXafV4PPo2t+P23g9QRXHjaH_XBke3DjzbvciqBtw+i-OA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CA+kmUXafV4PPo2t+P23g9QRXHjaH_XBke3DjzbvciqBtw+i-OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3216:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d614e69-0868-46fc-be32-08de28e6ff21
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nlc3dnc4Z3NFakFHV0NuUmY3R21mNUY2TzF6dDZYWDZxT3Y3Q001ejV3Z2Q2?=
 =?utf-8?B?V2t6V25sRG9WamJCNkloeFBTa1hvcy9HdmsxajRxQmdrc2h2cUJkUWcreHI2?=
 =?utf-8?B?NzdseUY2UzRpVXZkT2tpQWtPbExtRVdJaGY5V3RabkFFMk9KOTFUaHFRclor?=
 =?utf-8?B?dUtKRnFaaE85WVlVWWFNYUZ2Y01WVjd0V2NMYWh1Z0xXQTRBNlBVK3p1ajlH?=
 =?utf-8?B?dkRrcXVvbXc3M1VzRG8wcGVyQkZsTXlFaU5HZXBmcmVENGg2V3hYR2VseGFa?=
 =?utf-8?B?aFZhU2VFN05SRGQ1Y0I1azlDcjF0RUQxOEl2Tkx2L1UrUDNDcEJSQjFrWVdu?=
 =?utf-8?B?UjYyTkZ1R09wSnpDZENmY00wVFpUM2s2V2t2RjdMTCtqWDIzWUh0L2laOXU2?=
 =?utf-8?B?R0U0U1VNYXB4RTdIaXJSRmNFY0xHckVMOEptaGZSaysxQ0g0TExQSDFONkhy?=
 =?utf-8?B?RlVvNWw0MllSd2dCVHJCOXN3bkQ2WWowZWdUdDI3aFBOeDVrYU9zQklRekt6?=
 =?utf-8?B?dVF0T0wvbW95SjBLdTdyVldhZXdPbFAyeG41aUozclJ3SExZeU5GcldtSWJk?=
 =?utf-8?B?M2Y1S21wbjhrRHZYNEJuMndrU1o3QTJzSGRvT3JNL2NYK1kzZmE4WGVPWHVv?=
 =?utf-8?B?b3dBY2U3bXdmL3pFM24yN213OTFiNHNwV2FiTHg4c2ZQM2pQVHFtaHdFVG55?=
 =?utf-8?B?UzZIdTJxbEk1ZkNNVjNxRTdkaFNsSlowdXpyNzdPZlFWQ2E2R3NMM1VTR0Nq?=
 =?utf-8?B?TEFSdGF1V2ZJZ3E3SDdldmYvQW5BYlBWQXg1WE9ZTzc4dFFGTDZCQklDN3JR?=
 =?utf-8?B?Z3B0NW9CMnJmS2hESGZzQjFDT3N5UzExRFl2TUZ3dXVGQUhFR1RoanJ3WU9q?=
 =?utf-8?B?T2NyM2kzRStZY0ZEK1l5cUZTRTN1NmtBOXNUT20zcWprM3NUL3NvU1VGdGdZ?=
 =?utf-8?B?TlpRVlFCK2dpU21PSHB6S1IyUnJnaW1uZ0lmQ3crZTVoM3RrY0c2ejBYZm94?=
 =?utf-8?B?dGd0bXFKMjBtRi9qUTZaWDdqOEFQNE8zeHo2WDgwSllJMldwUnF1ZGljT3Bn?=
 =?utf-8?B?eWYyTnRvVUhRc0pXUjdBVmp3T28vY3hTOGtBMFRQWU1US05oWmg1ZGRrVnpO?=
 =?utf-8?B?ZXlpTDlQVndpdDBZejgvWEJRK2I5ekpLNk9pZUIvdklHUWc3OUtaV1U0aGk2?=
 =?utf-8?B?Wko4aE9EcXBnWkduazI2c0FMelVOOHVXc1ZML0JFdERzWHFIa0E2U3Q3d2ox?=
 =?utf-8?B?SkNsQUR0TFFXdXhUMEo3YmxNZk04clBUZTBSYjNHbko3L2h0SDQ1R080Yno2?=
 =?utf-8?B?eW5yS3hDZGl1RU81VzVvYUVYcVp5eUIxMkVmMnZ0d3JNejZudWY2NFdncWRU?=
 =?utf-8?B?ZGVLak44MW1kd3AxdDBKYWIrV1p2WHVtaDhvRytJZnpMVjVmS2RBN3lrR2lx?=
 =?utf-8?B?TEJPZXoyMkkxY0ZyQXJmdzVUUi9UUjVQTVR4djNpNlhGUlUzbjZLd3UyVHpY?=
 =?utf-8?B?UlF3bkdSKzZ1VFF3MnFqS2g0a2JSWmg4RHhlS2lEKzg4Qlo5aXJ5UTBMM21G?=
 =?utf-8?B?Zml5dTI3Z1lJZ3FRZDJIVGMzQU5UWE45cCtYQUtwc2lZcjBOeVV4QndGZjNw?=
 =?utf-8?B?Tkt6Z2paRHVWQndSeWpDMWtSMHBGTlllSTN5Qnd1R3gyQ2lIajhDTDBZNEpt?=
 =?utf-8?B?NDMrNDF4WXBwcGFINy8zVjNQOVZVc1Azd0QycEhlUjBrMkc2WkVycGxjTkNa?=
 =?utf-8?B?TmpScEZvckU3Q2RiKzBXTXRndmxERlgzckxyUmJwamV3a3VERkZxRHVMbGpq?=
 =?utf-8?B?MDFzcTB4TmdCNFlNRTZDUVZHYk1kTGFXZ3lWNUhQb09rLytYVzJrUHUrRlFK?=
 =?utf-8?B?MDhXNm1POU5FTFFZVDN5Nm9mNmVZZ0UzNERKODJqSHI1bTZqdEhxMlhpYzRP?=
 =?utf-8?Q?f45YohTZPgC7Rqv7MWeE/IEtDubOtM5I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHdFcjBIcjhCemNaTTYzRTBHR1JlVTZFN1UrYUQrNVlLcUxaUnFQczNJc0FI?=
 =?utf-8?B?bXl4NXhvc3liNGVqNlBhK2RJeDZRbDFkdkQrc2hza09rVmRETGwzcHZEaUth?=
 =?utf-8?B?M082bG51Q1RQWUpmTU5kaDJWcVdSKzJXRnNxTnBQWjR5WnRUVFR3NGVmSmwy?=
 =?utf-8?B?NEJ5aysycDFjZVVROG5LSDdSUkJiVXZzQmxwdTV2bTNidG5kWEVCRG5DSjFi?=
 =?utf-8?B?aDBJRm1JZ05PeGVqTm9xT3FVTFNOSU1tRVM4cFR3TDJnUkdTSUVGUnJtb0NG?=
 =?utf-8?B?c0FYYU92RjNIUmRCUWxQT3F6cHVwZ1lQd3EySExFYjZsZHB1VlJRcTNFNmVj?=
 =?utf-8?B?MmFKU1pDSG5IV3l5d3c4S3pXcGhRS29yekhxSFBrUVhsbTVkZmJGdjMwY0JM?=
 =?utf-8?B?eFJGRENIVWVtb0liWEtkNHliL0Y0WGhuMG84aFUrdEVXeFlCL0xrMTFJTWh2?=
 =?utf-8?B?NnlPcDZrWVMzL29WMTVqR3F3QVhrS0cza3Q2dUlVMGxMTUd4THRvMDN6a25p?=
 =?utf-8?B?dUhESVgvU21rd2o3b2FJd3kxWWhDL2xqTUVZalVOdTE3dUxVdFkrNnJxVExK?=
 =?utf-8?B?VnJRSUgrdlQvT0xMc1hNUDZYT2pmR2RXeXpoS1R5NEFzZjBuQUIvc0xtM1ZD?=
 =?utf-8?B?WXZHRnBrNTRFUy9PS0ZaN1lCOHNCYmN0RElob0J1RllFR0ZxRmZuQWt6cUR2?=
 =?utf-8?B?b24yMEpYYS9mdDEzVTVhQThpZ0h0Yk1RVVA0ZmVYSUY4aFZyNzV2MlhYUzdj?=
 =?utf-8?B?TkM0UHVIWGlLY1RjL2tnUG5xS1p1Mks5NXgzQTE4L3lvekNTcDhvQlMvU0J5?=
 =?utf-8?B?M1VEZGFzRkY2VWpUVXUzZVo1S2NtZDB5SDFOTURWLzVtNVI4K1MrWGhNY1RT?=
 =?utf-8?B?Wml1S01ZVElhZTNEdm5nbTFPdFZ5WTlsN2EvQXRxcUNLYU5nTi9tSHBhWVU1?=
 =?utf-8?B?S3IxZmtrdjFrTUsycHAxamsrTDZXVEtoWWlFVUlLUnlHZDFEdnBROEpST0NE?=
 =?utf-8?B?WlFvQzV6b1pQYkphWEtVSWwyaG9NeHBQQkE0dElqMDk1dkVYSnVmR3RUMHpP?=
 =?utf-8?B?NDZ6akhsNHJ6bnc0ZlNSSUhaRU40dCtCTDQvMDNBYXpTck1KUTJVaGwyS2JO?=
 =?utf-8?B?Z0hUaVJlNHVaaFIvUmlBRmV6ZWF1UFBQOTNtZlBNVHJTc09va2EydUpjYlpu?=
 =?utf-8?B?djBFaHpqNGtmcUgzOUZOUWc2L0FJVTdWL3NrTnAyMnBWcWFlY3dIbjUyM3hp?=
 =?utf-8?B?S2RzZ2JEWkF1RHJWQlRtT1oxRVFWYnhEbG11NVc2T011N2U4N0hjaXVWQzJB?=
 =?utf-8?B?cnhRNTl2aE5Ebng5cVJCOTN5MG1JSzhYMjVoS1laMjNxVFlJdVlIbk5tRGlv?=
 =?utf-8?B?Z0ZjWjR6ZmhBOWZMelZrN29IeG96OVQ1UDZMV2dKekpLWnBCN2t6dGlVaWE5?=
 =?utf-8?B?bmZYdHhsTjBuLzA4cEt4SmYyeHFNeWRZWlE2RE95UkNnOXYxUGxucjJGaytY?=
 =?utf-8?B?RWdMbG5sZjhkV1BoR0htb3BLK2JmaWxwNVR3c0dyVkhYWUJZZi83SlpVWFFj?=
 =?utf-8?B?ejZtYzhYQzR0Mjl5Sy9wKzd1WXdGYUdtYTdpYnhGbFovZnJzQkcxUm5FZGZV?=
 =?utf-8?B?bTgyTFE3M1dyOTB0b2FiNTRLMWtLNHNpRmFIaUpUdVY0bHkwN2NTNWorWlhu?=
 =?utf-8?B?TTkxNzFGRzZDNXl1YVpHVGFlY3Y3ZWpxTCs4Qi9QaGV5UzBtV3lYK25FTzdq?=
 =?utf-8?B?Y2FzMjN3dVZ2VTQvNUtEL0UxVXQ2VGxwbHRMb3NsYlZrOVNCdUZSUmVET0FT?=
 =?utf-8?B?MjlPdm04eDVPOXpRbnFObHlacmI0dXYvenVEZHQvRzl5NmxaL0FOK09hUlRJ?=
 =?utf-8?B?R3BQT2JTekZSSm05Q2FqaEp6ZWhjdlQ4dnY2ZU14enN3eW1Obkw4L3lHYXlo?=
 =?utf-8?B?OVhMbGlMS2syZlFhd3VENU5OTVlTK3JuSFhJLzgraUtta3d0dk5CTWtVKytn?=
 =?utf-8?B?a29obWY0K0lKUHBZUk1Bb1IwZExLeS8zdVBhOGxEWnJGcHFOdUFyZ0R2NXVT?=
 =?utf-8?B?Tm9xRkhTNEQ0V3Q3ZitBUjFXcVU4RTl1aS92b0t1TkN4S1VvMUo4SUNidXpC?=
 =?utf-8?Q?EsUMgq41UshOQC/Ouqu067rCJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d614e69-0868-46fc-be32-08de28e6ff21
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 10:16:12.3376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: friOAdCdh67Y17uSCs93FN8ZTxnLOUyXkFXPKoFzkayASOP/Ba5FmMGrWTf4Mum9zzWaT2mrWDzbmDhDeoWRBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3216
Received-SPF: pass client-ip=52.101.72.34; envelope-from=jan.kiszka@siemens.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

You want to add

From: Konrad Schwarz <konrad.schwarz@siemens.com>

to the top of the commit message when submitting via a different account
so that author and signer are aligned. Or use git sendemail which will
do that when author and submitter address differ.

On 19.11.25 18:28, konrad.schwarz@gmail.com wrote:
> The mkemmc.sh script calculates file sizes via `wc -c'.  `wc'
> normally works by reading the entire file, resulting in O(n) performance.
> 
> Unix file systems obviously know a file's size and POSIX `ls' reports this
> information unambiguously, so replacing `wc' with `ls' ensures O(1)
> performance.  The files in question tend to be large making this change
> worthwhile.

Valid point.

> 
> Signed-off-by: Konrad Schwarz <konrad.schwarz@siemens.com>
> ---
>  scripts/mkemmc.sh | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
> index 45dc3f08fa..d2c4e84b16 100755
> --- a/scripts/mkemmc.sh
> +++ b/scripts/mkemmc.sh
> @@ -37,13 +37,19 @@ usage() {
>      exit "$1"
>  }
> 
> +file_size() {
> +	ls_line=$(ls -Hdog "$1") || return

This will not suppress the error message when a file does not exist or
is not accessible, so:

ls_line=$(ls -Hdog "$1" 2>/dev/null) || return

> +	printf %s\\n "$ls_line" | cut -d\  -f3
> +	unset ls_line
> +}
> +
>  process_size() {
>      name=$1
>      image_file=$2
>      alignment=$3
>      image_arg=$4
>      if [ "${image_arg#*:}" = "$image_arg"  ]; then
> -        if ! size=$(wc -c < "$image_file" 2>/dev/null); then
> +        if ! size=$(file_size "$image_file"); then
>              echo "Missing $name image '$image_file'." >&2
>              exit 1
>          fi
> @@ -105,7 +111,7 @@ check_truncation() {
>      if [ "$image_file" = "/dev/zero" ]; then
>          return
>      fi
> -    if ! actual_size=$(wc -c < "$image_file" 2>/dev/null); then
> +    if ! actual_size=$(file_size "$image_file"); then
>          echo "Missing image '$image_file'." >&2
>          exit 1
>      fi

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

