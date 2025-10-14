Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA4CCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hTw-0005Fd-Aa; Tue, 14 Oct 2025 12:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1v8hTn-0005Eb-LJ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:02:27 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1v8hTk-0004T0-C8
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sml/wPdmc30ln7V90pHwldghbpMeMeQI4MPTsW9yqVrW1XpsrXsdWm72UsFFV4evH6HUrRW9o5NiqrHrmSkjUeFv82n9Ic7mpo8L8pjLL0OMFBMMESBrJQdLryEG8vx3Xt989wbiQJ6uE5KbxO6ZckFVKoUNFYAxQY/fVCucC056kzyuS9WKazL6bLUsXJ9XtzYnCqI0KEYPfBQhtgje8oXWKcG2shqSDMwFWtjmD74owEMV/yp2OQryZHijD0a1tEywg2i67qbYSkEg02b58JoHnRtjYiKA+1H8EIcjwTP/5GLD9SK3UfnJVb3nnC0e+P24w0owqrN4ymjWs0cyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHyMKrdNG7szndytwqZQZYsR2dRhOrkjZwsp6YVHolc=;
 b=NMxxVP1Ar/OXUMAAXEZp4BEUAHLqgpZxvQwHisngPqlFcuVldK27gBql49r7MYDeQuQO1LvkrF4yAn8nh/eQRWGdm173bAP/erAJkLQIGo8pstUvxd5LmyQ717CAWMXkPXIeky/pI8bAg/6L0Oo0hGzuAJ2/Q/4/b1YmzRqTeN7pdv2f+WL65O1aDv07hehskcTSnes1G8Wk5e18oJeTUzcZuKLtZufaaBhePGPjxpty+hVHCA9YZ6KWq/rATNc7ZIOI2DfLfJ4n/zsnn5zz/aFdcQUPX7FjHz4Z6v+C0aV84of2YubTYwDIvXDH4tnZYN2Q/u5QnqR9PEAhfCfysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHyMKrdNG7szndytwqZQZYsR2dRhOrkjZwsp6YVHolc=;
 b=Cg77fcfv08xEDIk4a7q0EWnZJ37vX78oZ2ITPl5p2qUVBHGmdXThJsFa/XGrHMVFxkhHaVzQCzpjl6dNLX0MIhhBPk9UjgY+wnavRS/2REEvZlmZm2ZnTA5swOHDxIoGIqhmFfA5yHXLekuNBMTOxIeUTBgw1rWL9S8RvKPnebCx56FHGvMetEWw3jg+hE56h3kUzUb1IcWh9/KDF6NRn9hXw4sERO+hY+V4wvjEDItYWESqIOLLbbb08vI61dwWaiesniw1d0MLgceoO9WLspadZ+iNswqEXX9KQvFh9d5/z+r+rjXVG3tMn7jKaJD3Ce2OqGieDdIr8VuNGtD61A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6562.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:82::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 16:02:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 16:02:14 +0000
Message-ID: <859f333e-37f9-4e76-bf88-a69d0641626a@siemens.com>
Date: Tue, 14 Oct 2025 18:02:13 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] hw/openrisc/openrisc_sim: Avoid false-positive overflow
 warning
Content-Language: en-US
To: Jia Liu <proljc@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ececfb-3209-4c81-28de-08de0b3b0a5d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0kyVFJBZ0xHTG9GNjNEaUozaGNqRm1STzhDdzB0aVJZYmVkQUFERnJseXNV?=
 =?utf-8?B?MzhoRVJBTjB5c2srNUJSYkJKbzBqaHMrczhXQ1FhdlFoQWZqa3RpeGRjOCs0?=
 =?utf-8?B?ak8wbTR5VC91ZWdGWmR5MmcrMnRzT0JFNXl0eWxvNmlIZzhXZXFpYnJacWVR?=
 =?utf-8?B?WUp4Wk0wT3NtRVREZWNUUzMzRHhiVXNHdW9GL3FYQWdqMDE1cXV0cEQ0d1F1?=
 =?utf-8?B?bjRvNWdZelZtOG9UUFZRS0ZvdFgwVXNIUGYrRk9PTzQwQWRqSWU2YkVXYk9J?=
 =?utf-8?B?M3FEQ1k5OSt6dXk1UlkrZXlTdm1YNkEzL2Y5Y3dvMnZPY3lSaUd4a2dTZUY2?=
 =?utf-8?B?NWdwOTJNekF4RkRqYzVDYXBVclBqNUZWcjJuc3BEYXpYNnFTcWZGOVlJOU5E?=
 =?utf-8?B?a0M1RjZGeFh1Yk0xRm1qTU1PTVFKR05pTHJITW5VeHRQd3NOYlJIVERuRHFV?=
 =?utf-8?B?ajd3R3NlWUZZZ1VSQlFxRzFXaUZ3OTVzQ0VoV0xDVE94SVpUY0lkaG4ySUFR?=
 =?utf-8?B?UWdMb1V4cjNXektER2RPL2JERXJaWGJjNkFqTkpxemlEYVFlbmF2a2QwK3Z5?=
 =?utf-8?B?ZTloeTllaFJ1aktTVzRlcHRGd1ZqSVRiU2hCNmUzNGtFUnJoVmxHc3FrT2Y5?=
 =?utf-8?B?UkhMWDhQVXFHOEFWYjJSRU85UC96OU50K2dHN3hlUXRKS1g2elZZVWNxTWx3?=
 =?utf-8?B?L0pVdzl6RDdnRHBzUlZCN29keFRUeGp3d3dmSFppKzI4Lzhzdzl2RnFIUzBl?=
 =?utf-8?B?SDhoSEQ1UVRadzJ1dGlkak00VEJjY0QzZGRIWmRWWE1KNmZ1a2hlYjM5bmUy?=
 =?utf-8?B?Y3hDZXRPNGRuQVZxVzVPaTNPbVNpbE5CdUQ2SmtLTUdhTk9QdmF3KzlUNDdN?=
 =?utf-8?B?MGFOQ2wvSkxhRXlncWJaV0l3Z0lVUEp2cWI2Ukp1TWZLcnM0UGRvZDFFR1dL?=
 =?utf-8?B?aE1qTi9KV1JROGc2aDRZQWMwZEYwVUZocDBEMDN5YW5vb2t1ZmhibGFqWTVC?=
 =?utf-8?B?eWNxdzJBNDk3Zk5ZazFoc2hDbjdkay9hOTlpTVVLTmVKSTR6ZEIyZDh5dnpU?=
 =?utf-8?B?amI0ekt6QjlCeXplY3VzakVpMVBxd3hsUFNSTDJiS3NISzVnYWhRVC8vVGF4?=
 =?utf-8?B?VkpOSVJBNlE2VGNnTitIemRHMTJZUmF1Y1EzcnM2YUhUVTNEd1hLVHJzQ3lx?=
 =?utf-8?B?K3lsL29qVmk4c2hhK05wdlNpaXVEVnpLV3NqMGw1dVFKZGcwTGlkdG5zU3Yx?=
 =?utf-8?B?MmNTMmlsOW41ZDFCRHNMS3ZuQ2RYZWRNZERRZmwxalhjOUl3Tm5nZUtseW5a?=
 =?utf-8?B?UGtPTGl3eGtFZ1p2aGpYVC9RWGE3a0lweTVZeWdKWjBNeHgzaGhxcE9kMEZm?=
 =?utf-8?B?M2RNdDhZUC9GRmpJTm9VQ2RCcjJJWjZZU1o5SXltOGNqNjR3bGlGaDJRbTI1?=
 =?utf-8?B?YmJqMnkrVFdZNXFiOUN2OGVIVm9rVzBhdXFDZjh2SUVSdFlPOTViTXFTczcz?=
 =?utf-8?B?WVN2dDVqbENqTmJTSUtnTmVxbVU3anIrcVJ0SE5FL1pxcWQ5WVQ4cmszMHBF?=
 =?utf-8?B?eFkrZStkVGRBNWxxOFJ1WjFyRGx0UUJCTlBjbyswVERQMDQ1NzQ1SEg1Z2dT?=
 =?utf-8?B?aUlMRWJMSDg5aFNwRUdSamFuajdxalJtN0hUZWljeXpTZWs0OHhjUVJFQVFR?=
 =?utf-8?B?TllWb09LWUxLZzMxNHVKcm1IMDlVdTMvamNXOXkvM0JvdVlJeHFpdFFoMUhj?=
 =?utf-8?B?YXl1Tmk4eWxyYkJhbis0eGF4bVlwaWFGMVV0Z041NWZUbjArSjMrZWUzK3Fk?=
 =?utf-8?B?cHg3Ny9Lalc5dWdENU92SjRzMVdKMy80aGVlUWVkYUtyT1piM0RudEJicUc3?=
 =?utf-8?B?VVdWYXd5YncvelJpelZvMjlEcnlLL2I2ZGYwZU9FcnZSWVBuOURsVUtZUjJu?=
 =?utf-8?Q?x1jBHzXPNwtC2fV3jv+biIHgOZkejA1v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDA2c1JMbjAreWQ5UmhiVjgxZEJyeXRvVkpXbFpzT2FpRmdGWWVYc2pqUHc1?=
 =?utf-8?B?Z2tqOHo3V29Fd0tIWHJEaHhadWdRbE10djRLY1d6WHJRQ2F4Yk9zazBVS0JM?=
 =?utf-8?B?Vm55cEJCd2o0eTZFVnhJaS9TUjlDbnl4UGdqZmN0SEZLbDYzOGM4SkpObkQx?=
 =?utf-8?B?RHVSRWZPVUdOWmhWbWlseFQxcWo0dm1wc2Y4am01OEQ1WWpkY2xFSkh5YW82?=
 =?utf-8?B?STZFelVZQ3hwM3o4TFRzOWZQMnlyNlVzZFlhOCtOcW1rN05DT25XV2hGWmFQ?=
 =?utf-8?B?MTBoSFZxRy9NbVpkbGNYY3ZMZFgzMjFoRk1wUTdpTWVCdi9vR0NUUUZuckZF?=
 =?utf-8?B?VllQZ04yQVZlMVRtczkyOXlaQmtvSVdiV2haclNjMWFRNE1DalBpb0c1Q2FT?=
 =?utf-8?B?ZVM3M0h3bzFyQzRLVzBtbVNjMTNORHVOV1hEckcwN2tkeEplaDFYYXNiVDRS?=
 =?utf-8?B?WEwvZis3SGxmVCtMN3ZRRDVNWnRianh2YjJzdFNUOFhCeDVCdG9KREoyWGdP?=
 =?utf-8?B?NTc5ZjN3TnZIc1hUVTdqRWFCTFRPWGVEUkszTXIwbEJSNGZ3RGx4NFQ3QTd6?=
 =?utf-8?B?b1U4OURIbXMrNXY5VllLQWxnSDlZVnRUdFNDV2l4RzNYZEdSRWZEYUVxb1JR?=
 =?utf-8?B?YXVpa1A3Y2tlMmk3ZnB3Mis5b2JvS2hFbVRab2dPYUtDUm9oVk1RMHdGa1lw?=
 =?utf-8?B?YkVXY1J0MHJVRVNLRlUycllxMDJIU0JZNUN2YTExV1NyNEFpYU5BaThsMXNj?=
 =?utf-8?B?OGt3WlNlR0JkWHVHc0FOQU56UUNtaWpPN2ptNGZudUo0amFicitwZ2hwVjJ2?=
 =?utf-8?B?TU03Q05PRFhDeFhJSVpIQ2JDUlErSmRnMGp3UHdJeVdKMHJwZnUzcFgzN09N?=
 =?utf-8?B?UHYzNFBOcWsyZnZwQWVrREg3cTV3cSs5YWRSazBKS3RJOVRLdndqMWRXL3hX?=
 =?utf-8?B?YTFxRUtoMDY3eFZDVVF5dWdMcjl6WnBIKytTZjhaaStrcGduTXlESUZodFdC?=
 =?utf-8?B?Z1BWUnZWaDE0cmRsY3hTVVBHTzRQaXRVR0dvbStOclpOWnN5TExMOFZiT09q?=
 =?utf-8?B?eVQ3bFcxRlFyUnpJa2NEMkJSUHJEcHVMaDZsTG44TnExLzdCS0YrS2pmaWFK?=
 =?utf-8?B?Sm9PU20yR3RTZVNQQTE3NDZmRVFpNHlzUWJTaHo3RmxLSTZLeXVxTnBjVzVG?=
 =?utf-8?B?eGJpclNFM0tHbzZ0N1prVlNTU29NQzAzVU01bWJjTWtsb2RNM2syUnBld2Vk?=
 =?utf-8?B?bnRhZ0Q0MjY1aWFwdStYY0JJcEh0b0ZXdG4wTUZGZWV3RmdwSXpWUGp1UXV0?=
 =?utf-8?B?cjF5V0wyVmNuQUJkRHlYcXJFaWdtWkRVNEY5RFJ2Z1pwUjFXV0dvek92MlQ4?=
 =?utf-8?B?cHFvd0IrSmIvSGgzSWt3TzBBRWdFaFZ1ZllPWVBpUGZXOE5zdGtDRTNIcVNu?=
 =?utf-8?B?bW1XNTFoMHUzcnpJbi9JOHpiUEJiYXovcW1tWUsram1ldlZiMVBwV2U0OG5Q?=
 =?utf-8?B?VGZ1d2lQVlRFMWxwZVJTTmY5UE93RXB5ZGJISExwZU1lNnAwQWtXbWhsSzhW?=
 =?utf-8?B?V1VxUU5uWHg3SjMxbmhYS2Y1bzBidWk5YWRURkY0c29MZHY3TC9KajYzRzBa?=
 =?utf-8?B?TGpyL2VTLzFuN1BDUnI2aGNHMFVCTUdzTjhSc0RrZ292WFJTSWR6ZW5mNlFR?=
 =?utf-8?B?c3NpcGlkMTkvM2tjYlZkSnhqU3V0M3A4dC9QQ1NielpHM0MzSURCYUZMbXZZ?=
 =?utf-8?B?cjRuZ1dISFhIcitLMFlITENyVk9XUDhXTlFqL3cyTWRpMHR3dmJndzRvaGNP?=
 =?utf-8?B?L29CYmNzdjYzNnQvTmcxR2Y4TERhNE1CZzRwQ1JnVlRtRVFDU0FHR1pvRTQy?=
 =?utf-8?B?U3dYK1ZDYy9FOWdqSFFMUFhqRlZPWUU2L2pzdmpYSUt5MUluZW5RYktSUHZi?=
 =?utf-8?B?RVdCaXVIN21ucWdrRFQvN29GMlY4OWJMeEFKSzQ1aFJoWEVWRFRyUDZIRDFO?=
 =?utf-8?B?YmpLb1JhMU14aGxqdnBoVFZXK1N6TEJ6U2pKOC96QVdBMWZZejBIdFNwZ3pk?=
 =?utf-8?B?d0V0b1I5UmV2b1d4K0hWV3ZWMG9peGplUnhrMEtUczVsMm1YKzBQaWVCVTNx?=
 =?utf-8?Q?2+NfMNCThYvQXUuyk/s1J1b4v?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ececfb-3209-4c81-28de-08de0b3b0a5d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:02:13.9806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mjzq2Cqx6RlJ0Boo1GV55ijQbROp4FN4nI7LzgMDntzF38iYUQe5uqyYenpqxkMP69+k0WnQ8+15k9bcQW4GNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6562
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=jan.kiszka@siemens.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Resolves this build breakage:

../hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
../hw/openrisc/openrisc_sim.c:284:45: error: ‘__builtin___snprintf_chk’ output may be truncated before the last format character [-Werror=format-truncation=]
     snprintf(alias, sizeof(alias), "serial%d", uart_idx);
                                             ^
In file included from /usr/include/stdio.h:964:0,
                 from /data/qemu/include/qemu/osdep.h:114,
                 from ../hw/openrisc/openrisc_sim.c:21:
/usr/include/bits/stdio2.h:54:10: note: ‘__builtin___snprintf_chk’ output between 8 and 9 bytes into a destination of size 8
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __glibc_objsize (__s), __fmt,
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~

This is actually a false positive because uart_idx is 0..3, never larger
or even negative.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/openrisc/openrisc_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 880c8ebbb8..dcb1a7a00b 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -281,7 +281,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
         /* The /chosen node is created during fdt creation. */
         qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
     }
-    snprintf(alias, sizeof(alias), "serial%d", uart_idx);
+    snprintf(alias, sizeof(alias), "serial%u", uart_idx);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);
 
     g_free(nodename);
-- 
2.51.0

