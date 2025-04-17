Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1DDC369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UGJ-0006lU-Dl; Thu, 17 Apr 2025 14:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UGI-0006l6-3E
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:46:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UGG-0004M1-2c
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:46:57 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMwFB015340;
 Thu, 17 Apr 2025 18:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=0+osxRdvGeGfbz9T2oYSNg9p3vV3TXTqNVQIN03AZWA=; b=
 h4jo6ZI0R+G079L9oksITvmdOqDNwGx+n4nfTTRx9GaAAQtKRVKAdMxznEkBDjcz
 4e0ywTO144cB6OgFZJPIwDrRmKRV0f6n1i8f8rw6TCU/tEWGMO3xj6BpQUYvNdZ8
 1cpEEsyf1DgqKxGNLnlAUsMQMVXSEcuw+3hzqVSIr/5ePakokIYKY2LroIt5pAPW
 lR+tF2QTQ67U2p7xSTJFy1l/N56KnY5nBTHWbCC86Lgg1/PqVHLn96YFXdpwbksV
 cpXH4LLG4ErP1D8OopxGNmRJb41KptFbK0a0XEA2fwpFIc+29Aa7fs/TKHDrOYbx
 k+UsYaH52GKkUeTueF4pDA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 461944euqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:46:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HIa8SW009188; Thu, 17 Apr 2025 18:46:46 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3nn8bc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:46:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksvMPVd8tMqzc90TxRzozeoSWPpR/+Tl9ht0MjLmGmH50AkLnR9qP6SOqG4Lqw8wEdqP0h7uoTJyZzNCmf/sA+7dky3hoOrgea9V5QIOOi6zVRDAbUVj+Q8wmFqVEXYl3iy+PxXQwOya1bVwX6a/OA9fRZa7f9zEdegFuiqVyMybNg8V3lKbWYy02JaimC16K3z59pDrWKZ5kGZHvCGg4xY+D1WUIRilmTcfI1muLLam51dApCl3PrL5YxM4uMzo5H4DDCGuD8EAVavFInEjkFSYLvpgvdnNY5CnpRtrG7IS5epOuqLbH2uwZwCzcIZpxTJgxpiokWHEYozK5EmoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+osxRdvGeGfbz9T2oYSNg9p3vV3TXTqNVQIN03AZWA=;
 b=OUVkGYX0rYlqGGwA5IkBdjhPuREwX8IN0AUA89BT5hZIDMB7M1F6nrB8aPCRBdGAuXYFPj6G3fgsYpdC9e5f5J9+5ONRbNNiwF7MMGdv3MbC9pBPOt9qneKRrx/G5CKJcZeSSlcDlZlmQ6iGsqQFlavbzFy3GjGcdjZbD1Qq9C6hBk+k/TlMLXZiKOHlWCssPneeOm38GKlHxXplhLJnoeskeVRezPUL2SJtE4rAyrypOu+p75heo3g5ziSGnA6f/yWyzp6owNfpBHrqT4eaGJljFwOA07dZId1SXXkr3iQiklYK/XyyV7ZA/QAkcEvakS6X5uqyagDjfQ6jqiirEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+osxRdvGeGfbz9T2oYSNg9p3vV3TXTqNVQIN03AZWA=;
 b=I6KDesHdKdwWYTCBwNxrEjNXTxSS/iUTOzTunGTtTrQkmjPANr25DAKDa8B06HsRDMkyacps0XO+pZ6v4DXCynaTbh/rr5QK4Bpms6L9XvxKRqvOSIlp4RXLFA4HEtQLGLzIYZSjT3c2Kvu/3Yj7jgOIZWzHRHpQFy/sJyvIb98=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by IA0PR10MB6793.namprd10.prod.outlook.com (2603:10b6:208:43b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 18:46:43 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 18:46:43 +0000
Message-ID: <f1a3ab0b-ea30-4c4b-b6e1-90418559cf0a@oracle.com>
Date: Thu, 17 Apr 2025 14:46:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 05/13] acpi: Send the GPE event of suspend and
 wakeup for x86
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204133.2955-1-annie.li@oracle.com>
 <8d1087a0-a1e7-4979-a230-ece87cc7093d@linaro.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <8d1087a0-a1e7-4979-a230-ece87cc7093d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0462.namprd03.prod.outlook.com
 (2603:10b6:408:139::17) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|IA0PR10MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 593c6158-5473-4d16-1515-08dd7de032cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWNqVktkLzVHdlA2NG02cE9BZlJ1eEtsQXdnY09wTDd3cldWODhIeHZ0VVNX?=
 =?utf-8?B?cFVXVHNTeG9EYmw5UEo1bVRPSGlaOGxqZW4zR0dpenEwVk9heXY4c21PaFpW?=
 =?utf-8?B?bUVTODVYemlubS9iZFpLWDhvdVowUGhXOENEV2JYeWU0MGZGWENiWTVJYnJD?=
 =?utf-8?B?Y2tRbWg5b3RiVFpJYm9KdmdRSkxxVFV1RlRBRjdnY0JaKzJuT3JuTXRpNGk4?=
 =?utf-8?B?cXFDeFlUYmtYa3dBUXB1K1JBWWNFMGxJNytHcGsyRUNGTUpOYStFdHRNOUVP?=
 =?utf-8?B?R1AvRk8reWdtaTF5TkV3R0x4djJ5RnRTSzVlbG5GSGZ3QVpyMUQwdDU5c082?=
 =?utf-8?B?clB5SU5pa3lpUWtORSsrZ2dHQkN1aDJLOFFUQzhobExTZkc0eG1vdmpkblda?=
 =?utf-8?B?elhTbCs4UHZqVW1ST2hzTGdVWVhoOXpzY2RMZkNIQXU4ZlZDZnl0MU0xSjBU?=
 =?utf-8?B?cW9FQytIOXB2NlJvSlJiQWRmaDN6cFNXRWRMbmUzSXZjRTkybzI2ZlR3N1lI?=
 =?utf-8?B?MnVwL3dhQlJqeXZqOUpya0ZhMk5DZXlrTjh4RlM4djFacVhTUW5tMURtSGtt?=
 =?utf-8?B?K0YvcTBCaG4rMVhJVW5mbllKTS8zNzFuM3kyUmg3SW4vbW50TDNjanFmNDl1?=
 =?utf-8?B?Z1MvSWVjV2hKL0NsUHV3VFd3K0R0TXEwRHJyNnhjVkNFSFBlL0h0NjVxMlBz?=
 =?utf-8?B?MVpJdGxZWFVvRisrYWtyRWk0WWFsS3lZUDM0cGRjR0FTM1IrNm5YclBMM2JH?=
 =?utf-8?B?MCtEMGpnbERjTXh6ZDFSZlEzWlRMSTBUVUU0ZEFjSVIyZzZad1FoMm9OUjNn?=
 =?utf-8?B?OVFZRjkyRlYzWW1GS093Z05tSFNSdDJxbHhiZ29MMklCdVd1RnhGaHV0Mlkz?=
 =?utf-8?B?SjhVMm1jcDVrWk1LdFU4cWJKUmtpWE1xanpkc2hNQ3BhQzJqQlFoZlZZKzZ6?=
 =?utf-8?B?TEMxVW5Zc0VOWm5ZYmFNVTZHQjEwSi81cHdPRnQ1WjRIVEk0alJPVWlrRlZj?=
 =?utf-8?B?c3NEVVFqTjVkWVFSbGUrMHdWU2p3RUcwazJWYWFKRzY0ZStzSWFJa090MnY5?=
 =?utf-8?B?eDdXY2M3cy96TVdRZ1RINllyNWl3anJFNnJwM1pUL3NxL0t4VU1nUjhVZWpV?=
 =?utf-8?B?OFdQSUxFM0RDaUZWc1l4TXRqZ2xBaW9CanVNdk5janV1UUQvdFFTOUJqOEYz?=
 =?utf-8?B?cEd1bnhyVE13MjVVQnllY3MxakRPWjdLYjEybitKTXBhMG50RW5wc1NqRGtP?=
 =?utf-8?B?Z1JRZENWUllXR1JKN0xEVXI1TjRsZzdFblFDc2pTMCtyTDR3SnpRSDJFRlRS?=
 =?utf-8?B?dFRvNUVEVm1OYVhLMDRTTG9QM1lOcEx2SXo1anVqU3YyUnVOT1Z2dDM3VnZx?=
 =?utf-8?B?OU1yVWx4NWttTCt2SzRyZUFOOUhxcHNtTFlvVlNhbytweWRYNmJJM1N1UkZL?=
 =?utf-8?B?c3Rvb2pRTGMrRzYySEdKZ2dHditKc1JDWUFTc21tY3lJZktpM2xBYzZQaDFB?=
 =?utf-8?B?VUpkNWRTUkpKT3JOR0RPcHlSNDgyNjg2OEE0c3JxL3hOdWFSMG9DMzYzc1Az?=
 =?utf-8?B?SWdnN3VDeU8yS2sxeWV5K2hJelhvUkdVVEhqQStWZ0ZJYTlIdmFpK095MmRQ?=
 =?utf-8?B?RVdXS2crRnRNaHZIK2tGb0NONFdicmlGSEJBYWQ5ZUJjcHZIQXZyVGhMakMr?=
 =?utf-8?B?NzVsaWhCYmx6RzQ5bmJubDFqeVRTUFR1V05mTXdnTEtGRXhKeENTVHliTjIz?=
 =?utf-8?B?dEtWLzVzUzVEMFZrakFsQXVUU1pSamx1M3JPbUMyZnBEaTRqZ1lzRTg5MktZ?=
 =?utf-8?B?b1pmMHY0WkRELzBYK3NIZFNhc3dpbldldGJHRjhVdFpzZmdHcDBNRldwSmtC?=
 =?utf-8?B?WDIvalI0cjFjQ1VYbThHUThnNkNqdHkya0xTODNaYnhOc2liQnJ5bGtZOVJK?=
 =?utf-8?Q?OtT/XJaLqak=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZjTFhjVk5YTUlUZ0hTVFpRSkM5eTVBd3RJMzEvOEdXYUIzeVg4amhpYmRS?=
 =?utf-8?B?UFkyUGNCWnRhZTJubHV1NEk5Mmpqa1VSQUgrZSs5S0pUZ2kzSjd0Z1BlNFBr?=
 =?utf-8?B?Y2FLT0dLY3l4UE82OXFJemVrQ0xlbUVzV3pvK2ZaRjJrNDN0VHhEWlBKUWQ2?=
 =?utf-8?B?aHBnaWdEclpUazZoelZkZFRJcVNmTCtxM1pyKzJUQXpkV3k1VC9kNVZESGU2?=
 =?utf-8?B?UkJvQ0VqMHBRcGwzRVJ2K2tJQWpGcm1IalRTZWZ0R2xqckZTcDNPYi80d0c4?=
 =?utf-8?B?UTVFUmFtYjJsS2RvYjE5dUZNUWZpTGUxUmtlc21JeVhyODhwSFo0Ty9mc0FS?=
 =?utf-8?B?NjFCZ3BtVWRVeHI2RXA0SnlQcHJvQitaVTVKbG1Ja1c2Y1hqYUJ1TTBrYUJG?=
 =?utf-8?B?N0tINGxVcUdpNDZTR2NCaklxUDdFbmk1SmZ5VEMxaUtlRnlHbjlOVEE1MXlj?=
 =?utf-8?B?WG5DSTU3bFBVYmJNM1lOWmcrVjVyU0RjZy9LMHN0U1FZYUVDbWs1Mm1yZUNl?=
 =?utf-8?B?bVlaOEkxU09ZR2hnenlJbnZiN0lkdDRUYzFJbVhLbjJaam0vT29JMzNqZVBw?=
 =?utf-8?B?ZStIeGFHUk1XV1RMZVJyREk5VzZWakNWSlljOUFKTHNmNlhmZzJIMjQ0aEQx?=
 =?utf-8?B?dG94V0Y1bklRdkQvbjk2bk12TVFRZ1Q5YXFrYTg3bmtORDNLWTd1UUY2WmxH?=
 =?utf-8?B?bnpWNm5qNmNvdzRuSDRxcmxpRlBOaHc0T1JFOFF0U205VjhEdlBBNkkzMGZy?=
 =?utf-8?B?anh5cXZZcmIyRjU5UldVekFtZ1M3S3NGc1hHYldtdjFvVlNjaG9uNTNYbDBK?=
 =?utf-8?B?MDZKSURPOWI0djRpRjVYWVpDWXhnS2dXaGFQMWhESUlmMWY0Wkg0K0NnMUhi?=
 =?utf-8?B?L3ZoWXpBZDhVcUVtWGJUc080UGNVTzZzZ0Z0ZkhkN24ydzN6VHp5aWd5SzNj?=
 =?utf-8?B?cFBhQnlVaWR1eFE5dlNlOElkUFpZUm9WZlhHM2VGaEVVOWlZN2pSSXQ3blZs?=
 =?utf-8?B?V2liQ0NJWE0yM1Y5V29DNWdZZ1pia0U2T3lmVDlNYkRpdzFwQjFJS3BwR1J4?=
 =?utf-8?B?OTkvWkpydStZRWVibkdJNFY2dTJIc1lrZDYzUjVhRUhwcHVtcWhuR2t2bzY5?=
 =?utf-8?B?dFRLRDV0T2ZRNG5HSnpyMmFiUEZtYWNoejY4SUpoUC8wbGdNMVFoQnhqYlFD?=
 =?utf-8?B?S3laOXFmdEVIWE1XTUI4OGtSWU1sL2hvU0lTa3J1UEIxdXdFbURpeWVyWng1?=
 =?utf-8?B?b1JIUmw4MnZTbXhQZXZobG9WRXBmUTJ3cHVPRWhqK29laWdTTCt6SzljbGo5?=
 =?utf-8?B?VEZaQVB1MDR0ZzFmaFluTzA0OE9VYndLbnZOUk9OczBzMlhOS2VqR2t5Qmkx?=
 =?utf-8?B?UEg0WnBhckZlNkVKSVNDZ21kd25kMnlwL1dNbEVNc1QzYnlUR2VqMGJ0SjBa?=
 =?utf-8?B?NWJFNVdCNUlLZE5ET3p6RDcvM091cURoWXlqVWIrSlFJS3lKem01ZVZFWEVW?=
 =?utf-8?B?dzhMUlY2aGdaaG9kamVDSktqa2VIcWx5TlJkbmdTUklpaHVLR3VaVTJyUGpu?=
 =?utf-8?B?dlNyRmhvZ2Fza1U0ZnFIVXVTYk94NW1LckZGS3MzdHUyeVE4dWlKa2dnUVlG?=
 =?utf-8?B?ZUd1M1RBVW5pSWFVaStBNWVxb1JTbXZPV3o5NEptUFJyWnI0WVQzUS9zOUtT?=
 =?utf-8?B?SXBRc0p5SlgrNE1rU1krL2FhaC9KYmdJUjFyc3ZnREErWW9HSmhEZ3FOdXlB?=
 =?utf-8?B?aVBWWnJhOS9qOVhrVFVVMVBhNm9sYUxtbG8wQm1IZUVRNmJlNk5HWHJiTXZK?=
 =?utf-8?B?aTdmNDE2Ri8xMzVWR0lGTFdldnUzWE5oNVF6azgvUk40cVh0U2lYNXpCdlll?=
 =?utf-8?B?ZUpFUlA2MXdQQ1JUZWtHUnk5S3piRFEyb05LVGZ3bXBzZ3ZwUWJoMUQ2RWdT?=
 =?utf-8?B?emhLSjljMlJjSmlGZkNoSDZVZmdObit0SnFwMmYrZXE1OTI0UmFQRjk4elBP?=
 =?utf-8?B?OE9QdFA3YlpKZ1k3NUtXWTRMTnRMWHVzV3B5UTZaSDdnajJrck5tWlF5eXlC?=
 =?utf-8?B?TmRBUWlsajNJMjR6Zm5McUVDdVRZZEtTQ1owd04rQWZVcjgwZzVOU0ZhbFhr?=
 =?utf-8?Q?8ti2Q708W1dz+Gwi3vehJ6WGT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wRcnMoqPlWj2DKrNKRXdZiGwCyNoUABUn3zkwtVbjPP7f3PQDBQBi2iFAFzeqevnzF68rKuhEekrdKs5teUh02KU96EKtmETOIBCfAHK5pBQrqbzGp7qqZEvII3t3bO1oiIajo0HN9nSG/lGd6wlbkH7keWXZci/6Uh8s74hOsYrLO610R2Bgdf7TfQn++usF3y04tbotOyY5gPpwXDqfc/+ZXl6WkG283dCHe2g0hVU2XruSOv3UCOK4sMacsy9x6LLlbhYhd6QyIp7xqW7UBSY1qUk1jy/IvPf2bCZYuKa3mzp3qV8ccaMJNKft0NTkMNFlcBYwRvCvXk4nAaBcT0lWuceJ1kdUK8R5yGosy49/e/dVZbJJopIm8iYWe+Sr9CmeLye7/vEuiDVNMBh8dxjyREKjX6oqKzUplbFS0P4KsNAfoS23i496gPefuUb/RpDT9PLBeBfVgh7PvlBkWe6GPdLU12448/so2XuZrCnJf1g2lTVXJHWhpnWKcaKbyJW0V1ACmaW6jIif29Ec0QL1nG6rPhM5ekXiVlIUtF9Xit+CRND+BfClXLAWx/qm3CW82uPBTuU0Vh1vg0vdh38K4vsYkdAn7sbjkvoG3E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593c6158-5473-4d16-1515-08dd7de032cc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:46:43.7682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP3xzkjsDY49DZoO/wl2sZQUApMClPz4xVAKAUQy5LHirPPvoPtths5Lba/npKFVZmzuRfZL1Ks/ZgPsAlu9Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170137
X-Proofpoint-GUID: reF0HKNH_Yfx0c6xixqgkQqFnaXn0zDK
X-Proofpoint-ORIG-GUID: reF0HKNH_Yfx0c6xixqgkQqFnaXn0zDK
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Gustavo,

On 4/17/2025 1:40 PM, Gustavo Romero wrote:
>
> Hi Annie,
>
> Some additional comments I forgot :)
>
> On 4/11/25 17:41, Annie Li wrote:
>> The GPE event is triggered to notify x86 guest to suppend
>
> nit                                                 ^ suspend
>
> But I prefer to stick with "sleep" here instead.
Ack
>
>
>> itself. The function acpi_send_sleep_event will also
>> trigger GED events on HW-reduced systems where ACPI GED
>> sleep event is supported.
>
> The title for this patch is a bit misleading because no
> x86 code is actually touched. Also, we are not generating
> the AML code and field for wake up (SBW) in patch 1/13,
> hence, remove "wakeup" from the title as well?

Good catch, I've removed "wakeup" from comments, but
missed this in the title :)

Thanks

Annie

>
>
> Cheers,
> Gustavo
>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   hw/acpi/core.c                       | 10 ++++++++++
>>   include/hw/acpi/acpi.h               |  1 +
>>   include/hw/acpi/acpi_dev_interface.h |  1 +
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>> index 58f8964e13..00a9d226f0 100644
>> --- a/hw/acpi/core.c
>> +++ b/hw/acpi/core.c
>> @@ -359,6 +359,16 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
>>       return -1;
>>   }
>>   +void acpi_send_sleep_event(void)
>> +{
>> +    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, 
>> NULL);
>> +
>> +    if (obj) {
>> +        /* Send sleep event */
>> +        acpi_send_event(DEVICE(obj), ACPI_SLEEP_STATUS);
>> +    }
>> +}
>> +
>>   static void acpi_notify_wakeup(Notifier *notifier, void *data)
>>   {
>>       ACPIREGS *ar = container_of(notifier, ACPIREGS, wakeup);
>> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
>> index d1a4fa2af8..64d3ff78ed 100644
>> --- a/include/hw/acpi/acpi.h
>> +++ b/include/hw/acpi/acpi.h
>> @@ -184,6 +184,7 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, 
>> uint32_t addr);
>>     void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>>                            AcpiEventStatusBits status);
>> +void acpi_send_sleep_event(void);
>>     void acpi_update_sci(ACPIREGS *acpi_regs, qemu_irq irq);
>>   diff --git a/include/hw/acpi/acpi_dev_interface.h 
>> b/include/hw/acpi/acpi_dev_interface.h
>> index 68d9d15f50..1cb050cd3a 100644
>> --- a/include/hw/acpi/acpi_dev_interface.h
>> +++ b/include/hw/acpi/acpi_dev_interface.h
>> @@ -13,6 +13,7 @@ typedef enum {
>>       ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>>       ACPI_VMGENID_CHANGE_STATUS = 32,
>>       ACPI_POWER_DOWN_STATUS = 64,
>> +    ACPI_SLEEP_STATUS = 128,
>>   } AcpiEventStatusBits;
>>     #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
>

