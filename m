Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6068C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 15:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmx90-0002gr-BQ; Tue, 25 Feb 2025 10:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tmx8r-0002fK-F1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 10:46:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tmx8n-0008UH-9G
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 10:46:41 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMXpV020741;
 Tue, 25 Feb 2025 15:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=fTyqRF1lvhn535Get0prl/RnoixJrYu8YJb+FKWO0wU=; b=
 opOvIelVcF/jhN+9ycysfwgOA3aD6Majhe/Ne6aKecRB/pfxEqU9jHfE4+wp0iHU
 m9oZlDvLGlzjRPpL7yNZFj+p3nv9fL2EWbvD4aPFrNZAbWvOtZAvGPTz2PpZRsuF
 23K01dKgsEZAJV8+4JxeEZcop6DiskKLyoNpj9nsGcvVIwwZRk7J4824eHqSfZxQ
 8NnGNBZ8IVFRbcOQSdAeuR6u4g2V+cuuBF8m4918+kdGfIu0O+wkqGOu8x5es3hA
 ppkZsETP8Y3N8Jf6D7G/RoRm2oCyuppL2n0sW7jT0uRoJrVIkV9wFEr8ky164nXF
 PwKC6URLgDzg65PU/JBFAA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6mbnmvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 15:46:31 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51PEQbSx002704; Tue, 25 Feb 2025 15:46:30 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44y519mmhu-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 15:46:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kH9apFx0vOdC+zzeSAoWkVjLVfSFIW9DB1zKY01u1myPlLn2Vyp1HXAIAVUPxDmr1hf0Zvf1Jpv0g4og1yEuVjuwq3fNZ6k1xNQVbUoNuUE0F+FYj/TQRMdvMMNdp8CRxn4PZiOOxv6K4uBJxljHsq+iswjMe0gD1zCtUlDtkTJpvBxNvPD6+g6pxhTdUnOdkaSFmqjoLjl3clr63lWDX2WRfYSb4UzewaaVJVzNN8t/wlC7lKOcmEYPG9JcO4Do6o0NZhNhpbm4e5aKCsjHS57JDzPuDotVkFZnB7UoLDmmqf9s8chsngRuhOquFmoEylXeJND4uuBlBbwD6vEnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTyqRF1lvhn535Get0prl/RnoixJrYu8YJb+FKWO0wU=;
 b=uwXoxaDyqFbpIOVB64rbD2cT0/4sV2JoPav69X4TPbnrBTREVoe9Oypb5Zu1ZTaRODZGaXGpONbVloUzJgYGJfPOr0C5i6jV4ojUSBvYs+IbjkqYZEkdNPxk3zAnFMcQaPpEgCIqLs7MK4WUJgtLZEznCDBPrsDLlZODygrhIpNMko43j+HIlCJDVrkyM9juMWe8J07bz9mv984hZk71Me8DZI2rQJ6/b7nAT3mlG8tqEphUlhBACdxWDQiH7m6ESfwhPxetNs82aanToEiNGpIoNkeSusnf+I+DzGPSSedNwBl4zOcgTEQzy2Y1EImv5BYX/z32nesXRw9br/VXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTyqRF1lvhn535Get0prl/RnoixJrYu8YJb+FKWO0wU=;
 b=ZEtWiysUChca2nmBUC5988QXCslaA4MOwg4bramC5j/ZGeuS897qwEnI/Pbe7bST4sGsgyUiQ3h1jDMN8hYTX/2jrvNagCY9dfBjTP/LtK/18vLYfgmVYkj10ujsK8hYmCglnVzFp7KxVn0tVF+4dJOSpYZF0q5p5ibzgnkXaBA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BN0PR10MB4982.namprd10.prod.outlook.com (2603:10b6:408:12c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 25 Feb
 2025 15:46:28 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:46:27 +0000
Message-ID: <492dee01-fe64-4ce4-b298-a9eb5d731ea6@oracle.com>
Date: Tue, 25 Feb 2025 10:46:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: ram block cpr blockers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1737135971-132839-1-git-send-email-steven.sistare@oracle.com>
 <Z4qelNxnBcgO87go@x1n> <814d9205-8ba5-48a8-9940-6f16bbb097eb@oracle.com>
 <Z4ruhpH28-GnnTq7@x1n> <20674b54-3c88-4d2c-a590-3b0ddaff86f9@oracle.com>
 <Z5uwUNtYhQfJJlg3@x1.local> <f1f1c640-367d-4966-93f5-a98e3b764e28@oracle.com>
 <Z7Sw228UUsmGD3_t@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z7Sw228UUsmGD3_t@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::22) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BN0PR10MB4982:EE_
X-MS-Office365-Filtering-Correlation-Id: fd60ad52-4d7b-4051-c7a7-08dd55b390fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ak5wcGExUkk5SGJnOWJMcm9MNU1Sb3ZBMFFpMGtrZHVPNzl2RVVuQjM5aXZm?=
 =?utf-8?B?MHI0cjFnbW5HNnU5MEZQZ0JHWkhtL1J3a2dtRGxEUDRnMW1WS3dMcnRWckF1?=
 =?utf-8?B?M2NmS29YSWdwNDBuTmVGb080bFVIN2libktrcUtlMVY2Y3FtdnF4SWhUMGpt?=
 =?utf-8?B?UnlqR3p0VjR2MENXemhNV3dTOXI5VTkyVTZOUTFXSFZHak1RM1FCTDBheExo?=
 =?utf-8?B?N005ZXZVOU04TzVrcURBV3lqZ1ZxZC9XRFkyQTF1OEVPTktFWEoyNjd2dUE2?=
 =?utf-8?B?aE1lWSt5cGVoVkpNK0ZYQ1crR1dheDZ6L3Fyak9MeVVNSTlObEZKdmV3Z1Yx?=
 =?utf-8?B?RVJ0WW1xenZQdDF6b29ta285dTg2SzNTME9VanhoS3ozYStyY2FjRUtERFB5?=
 =?utf-8?B?RmtCMGF5M05CNC9TYU5FWGJZUUhpVGJIUmZrQ3NLNmRRVm1EKzJkTU9xWHY1?=
 =?utf-8?B?SjVUQzhtMEp5N1VnK3VEbjNna1dkUlkzSmJkcmRia1pDUHBVQWVoQ252eWRM?=
 =?utf-8?B?SnB5RExkNU4zcmlBVEYrUUVOa3liVEd5SGd5SytkM1RwckZhQkJtWVRMV0VT?=
 =?utf-8?B?T2x6WjZzVGw5NGxsYkI0QXQ2ZFVtMytvT3VpTG1VMWJFd3IzRm90NWNENFVE?=
 =?utf-8?B?UVhGN0J3UkJ5YUg2NnVzTlYrSEgraDZFbGJPaW1PeDEyZHlWWjNmMkNiRGM3?=
 =?utf-8?B?dk9oYWlOSlp5dWVqSFY1ME9ndUN2SXEvMXJ5K21XLzR1cy9SN3kzMURlcXJD?=
 =?utf-8?B?Qnl3TVhRZXZxNmxWNHNSbmlMQWJzcHFhQzN1ZkE1U25PZW1zUDhsbHpFSjNY?=
 =?utf-8?B?QnlTbmJydTZ4VUpvUkRiUFZyakUyNUszQ2xvYXk1cTBqQUhuczZwMHlYS2xl?=
 =?utf-8?B?RHloeEprVzZob3hPWGxzYWptRWhiaGRWR2sxYW1LNTgza3ZlbGR2UWMxMlZJ?=
 =?utf-8?B?TGQxTkNzUDFrWU1Jc1preW1ZNXVOVjBoWEdLS2REbUkrQWdub2JSQXIwZmtk?=
 =?utf-8?B?NGtKQ1BhRVpCVmttK0UwbCtzelZNcGVObEk3VWJQblFWK3F1dy93RFEwbENQ?=
 =?utf-8?B?RjlnOFRNcDlIb20zTVRCYzN5MkhvMVRRQmpNWnR3YVJEK0VxaTM1VVBHVWlS?=
 =?utf-8?B?Y0NhZk84SWNnWFRNWS9LL1BBSFZsWFVnZ0NXd0FQWFZNcjJvVEw3T3B3bFpG?=
 =?utf-8?B?MkJTUDVrSExTamJDcDVYRG9MV0Npc1B0djVacTBrSU9WWDlFZVBReHhjbTFa?=
 =?utf-8?B?RG9YSDBpSDUzQ1doYXh2QTNaK0xramFwSUF2NDRzWEdpejFyeUY1aUNuNDE0?=
 =?utf-8?B?RHpWbUxFUmJKQnBnWDM4N1BKaEZCdGZyd1BIR09GUUIvZ1RkYWxwc1VtLy9x?=
 =?utf-8?B?alZ6QUpzWkkwU0pRNnJiZjlEM0V4KytuMHNVMm5rZVBRblRmY3NWeUFHVVha?=
 =?utf-8?B?TTJGeDYzcDhhelQxanAzUGpSVDNGdG9CajB2UjBteXR0S0dMeG4zK1htSHcz?=
 =?utf-8?B?bDd6UDBxbFB0eERqM0l4T3RBek9Hb3ZWRmc1dVJtd2hEQ0kwcG42S3NjQjIy?=
 =?utf-8?B?UDIzVyt3a1JMTUt6M253T0hGdzNrbUtSc0lQYWF3M0xPbVk1cDRydGNHU0Zo?=
 =?utf-8?B?Z3lBL0xlWkdMTW1nNWxEUllZNS81VGJNUEtndFBFd1FWUjFua0d0elJVSkpY?=
 =?utf-8?B?TlFZR09COE5aYndvNW1Qc1ZobEFkZUhRWm1UOVJlUkdzNlFLRmhCd1BPalJS?=
 =?utf-8?B?YzNJU214OVovU3d6Z0YxSTEyMHlvcFUybFYyVzNhRWxQRlUwUmsydW4rVFJl?=
 =?utf-8?B?SFJrNGErTDlTbG5qUHZ0eldVam0xQUxXdFVuL0h1TWs0ZHBoeVlzOWp2eVZo?=
 =?utf-8?Q?E6wQw6+PGi9x/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJoVmR6U0c0MlNiNmZONGx2VzcreWVxSWExdGZXakFhMlEyenNYSFY1Mklu?=
 =?utf-8?B?emNkb2Y0Z2RGL1BtczZqQ3NqenRNdEdLUzBtVUlkYUJPSGlHOEllekl6L2hH?=
 =?utf-8?B?b1Jtb2ZYaXdRcUFWeXNBUlh1eXFrMVcvZy84U1pyYjRIUk40cnNnZzRoaTgw?=
 =?utf-8?B?Wmd6aG1vMExjd2JZUGh4alZxcWhjUEVlQW5xbGtWV05vZE5GVzhnbUg1aCtv?=
 =?utf-8?B?VkwzYXVnc09uT04xcC9xREJYOFFRcmFIaEhNbGdVNVE3ak1XTkNZTWdRNVVQ?=
 =?utf-8?B?eDFodWVlMG5McEFYWkYzRW1ZSloxUnVxcEd5S0tMZTJxR2NxbEVyS0Mya0Ry?=
 =?utf-8?B?TjZPR3liMkFOSzcrTGxIaVN6KzdGczBYRng4aHFIT0NxQ1RiMlFjWkVEN2xi?=
 =?utf-8?B?QjhKZWxmZEs3L255WDl6aUp5SXp0UFYwb0trME1rZmlscy9JSGVlSEs5VTE3?=
 =?utf-8?B?Zm84aC9UblRHbERoZVNDYlJHN1dzOGxwRmVzL3VZTm5pR2ZrS0NuZmFsYUM5?=
 =?utf-8?B?aGlYU21zZ3R6NVBMaHBTQzAzMFRzV01IakYwODNjWEtQSkJZWHo0QjlGbW1D?=
 =?utf-8?B?Wk1pdlBnVDlGTnBMeGpZcUN3Wmx3RmlnYW55NmVYNGZOMzJTNVoyKy9Odkow?=
 =?utf-8?B?SUp3VlhhWHRNSWg1L0l5d3pXa2kvYS9QdEZEQnkydWphNXhQZ3h4M2xyVGdi?=
 =?utf-8?B?WktBbFZUM0drVlJ0QUJmcHpsa01WRUNiWXIrL2owcWRPMGhwd3YrZk0yby80?=
 =?utf-8?B?NnFISFEySFRXVE1mSjNpQ1pHaW9NNXh0SDcwOFF5ZnNTZEowTXRjeWNJSm1w?=
 =?utf-8?B?YUdjWjV0OUVlcG1PbjViRkEzUDdvTEIzdEhmaGtIZEg0RHJYUFhkdDVJRzk1?=
 =?utf-8?B?S0RMbEZJZWtxUVJONlVJeFVaV3FvcE9WY2QrY1VodUZiWXR4Z3RSdEwyYnNB?=
 =?utf-8?B?R25iNno3aW14eGVObXlNMThXc0ZrUjR5YmZCbzlhRGdubmtqOUpUaHEvR014?=
 =?utf-8?B?NE9vZytFV0ViTUIrRURSUlQzaVhxQVpxTEZuUDNMQTRRWkVXQW8xNXJraDlG?=
 =?utf-8?B?amRRZkEwcDZnZGRSNGtPRXV4d1o1TnFxNmdNb3haWkZydWNtaUFUcTBjeVND?=
 =?utf-8?B?NFNwYllXRkNsMlA2T0QxY0FIQ3BXOW5VR1R6Y2Z3TytDUCs3ZERjeFp1VHVM?=
 =?utf-8?B?QmJPVFVJZ01JQ2xSckt6ZFJNSE4zS3VLZThtT3NaZnJqTmNiVjExOEtJai9B?=
 =?utf-8?B?RngwQWg0cWxEK1laQURxUSs1NlBsemFGdjhuV0Jqc2dUbFFuV1R6OFFXU2NM?=
 =?utf-8?B?QXdNcFJYTGxlRUxlN1lEMnVjRlliZGxLTTBTaVEyRnlNQWVaRVhZVlU3TFEz?=
 =?utf-8?B?dFQyT0VDc0FXTXV2SnJzalpCamRZNXJoTmJzaG9YZFNBVjRFTDVIM2lrWUFs?=
 =?utf-8?B?UU5xaWhJK0tSUnJJS203b09ObkczV2dmbGM3RlFLSFhzY0RpOGh0eFBMN0J2?=
 =?utf-8?B?SVQzR2N1NmM1aGN2Um04d3Z5N1ZGSzA2UGtpZEZCRkQ1eG9Kak5zNk0yYmpH?=
 =?utf-8?B?Q24rSEZkd09LR3ZWbnVIRnJ0aXp1YTZZQWFUWWJKTWoySzNQcC9tNTUvcU5K?=
 =?utf-8?B?bjNQWnU1UG14dHRVRDdRYXJzRUZlSTBpMG1VYVVSdkZWVmNqZlFhSk4wUncr?=
 =?utf-8?B?eG1CbjBvUXZBRzJ5TU5zUHVpak1jeFFLU08xdWRNOHlWcFVUUk1zSVc0bWRx?=
 =?utf-8?B?SllraFVTeFZYdFZOb0hTMXRtMk9yc3pGeFN1T3NKY2JZalZqbFVZMXJidzRT?=
 =?utf-8?B?cmlBeHZTcERFSlcvdUQxbjcxVndYODZ3QmVXVzZSV3NGdzluNHVpdlYvcmJN?=
 =?utf-8?B?MmI4VTV0d1VuM0M5MjJXRHJBWlZDVS9PZFkwei8zakpsTE5YMlgzK2FFb0dF?=
 =?utf-8?B?VWV3Tmh2djROWDlXc29qM2pMMWtITWIvb0tzWnB1TERmU21IalhncVRaandE?=
 =?utf-8?B?QkRGQkFvNHgrM0R2bVhxemhnYTJ4OHJsL1NzY0I2MzIrR0dqSExnL2RaNnli?=
 =?utf-8?B?VExlMW5MQVZBS2xWeEVhcXpyVHZvb0RrNms1U0ZkbjZZSGlKWHMzdGNnREVv?=
 =?utf-8?B?dCs5RG5vcjNqODJhUnlWaUkxdHM5SW9vMk9VbzZWM2QvN0ZaU1lmd05xZjU0?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t6wejX1nh3dkLA0lHb8NJOB+lvs+i0Xj0z2/Du7954v1KdXDVmp5CAKNZuYN2u5PrvtNUeYE5ZH80o/zGN41mGhiGEpgaUhPDEMQZ2jOXU8fbe97aSMrSucH1rJB+hS2CTbI5FEnfqLdhUSGh+PQGJ1V70vnWhTWh27C4mOH9UAbRQ1EbGnwj8jCrIMMm19vaOngYfDEQCtg7YtJT2zKuuJOqBoqquQUvAm5Pj33H3fP/bbaOjVtaQKvSrz73BhyUYKgLeZBP8WFcJ7+92UhfisZa0BioS7+FgwD73xbMLQzV1XCJau2q+KqltfC9ZHYi0HHQrpiLkKG/cgc16EPT6qM40iM/5o/+nokb3ULtBU0DWKbzhmDU4O4Pc7PjOvORwzaBfV1EdMu66S096ZUzb5cHAWYrVNoLIxT1SqhOyRMcKUdRiWktv/QfW0n5Y9ptrVSxq5s6xuS1diSjbaTYdcnpF0hn5h81ZmiAFr71wHqUreWEYalGGBLs6OB4LIbC5TGqzPyqhy1UBGIh7FzV39BHxDUkL7sc2BB3O+ogoSNi6X75uRvXEllPcXoE1Mw0Pn38qTg4AGUlc+jskOJtYb9qU13KuwYWFOGD7WEQPE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd60ad52-4d7b-4051-c7a7-08dd55b390fa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:46:27.8541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP6JaA2jZWnzISIGMCI2aOiaCdvyLVrwubb6JtAY+nk5cLrdzRKLHVMs/bMmg8cWCGHIAthYvjG/BatVTTavx9fBIHnz5YaQEsWMWZcGWSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250103
X-Proofpoint-ORIG-GUID: cZPvl-FzzN3Q6EZrR4EGtjzXtl6OIHEN
X-Proofpoint-GUID: cZPvl-FzzN3Q6EZrR4EGtjzXtl6OIHEN
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/18/2025 11:10 AM, Peter Xu wrote:
> On Fri, Feb 14, 2025 at 03:12:22PM -0500, Steven Sistare wrote:
>> On 1/30/2025 12:01 PM, Peter Xu wrote:
>>> On Wed, Jan 29, 2025 at 01:20:13PM -0500, Steven Sistare wrote:
>>>> On 1/17/2025 6:57 PM, Peter Xu wrote:
>>>>> On Fri, Jan 17, 2025 at 02:10:14PM -0500, Steven Sistare wrote:
>>>>>> On 1/17/2025 1:16 PM, Peter Xu wrote:
>>>>>>> On Fri, Jan 17, 2025 at 09:46:11AM -0800, Steve Sistare wrote:
>>>>>>>> +/*
>>>>>>>> + * Return true if ram contents would be lost during CPR.
>>>>>>>> + * Return false for ram_device because it is remapped in new QEMU.  Do not
>>>>>>>> + * exclude rom, even though it is readonly, because the rom file could change
>>>>>>>> + * in new QEMU.  Return false for non-migratable blocks.  They are either
>>>>>>>> + * re-created in new QEMU, or are handled specially, or are covered by a
>>>>>>>> + * device-level CPR blocker.  Return false for an fd, because it is visible and
>>>>>>>> + * can be remapped in new QEMU.
>>>>>>>> + */
>>>>>>>> +static bool ram_is_volatile(RAMBlock *rb)
>>>>>>>> +{
>>>>>>>> +    MemoryRegion *mr = rb->mr;
>>>>>>>> +
>>>>>>>> +    return mr &&
>>>>>>>> +        memory_region_is_ram(mr) &&
>>>>>>>> +        !memory_region_is_ram_device(mr) &&
>>>>>>>> +        (!qemu_ram_is_shared(rb) || !qemu_ram_is_named_file(rb)) &&
>>>>>>>> +        qemu_ram_is_migratable(rb) &&
>>>>>>>> +        rb->fd < 0;
>>>>>>>> +}
>>>>>>>
>>>>>>> Blocking guest_memfd looks ok, but comparing to add one more block
>>>>>>> notifier, can we check all ramblocks once in migrate_prepare(), and fail
>>>>>>> that command directly if it fails the check?
>>>>>>
>>>>>> In an upcoming patch, I will be adding an option analogous to only-migratable which
>>>>>> prevents QEMU from starting if anything would block cpr-transfer.  That option
>>>>>> will be checked when blockers are added, like for only-migratable. migrate_prepare
>>>>>> is too late.
>>>>>>
>>>>>>> OTOH, is there any simpler way to simplify the check conditions?  It'll be
>>>>>>> at least nice to break these checks into smaller if conditions for
>>>>>>> readability..
>>>>>>
>>>>>> I thought the function header comments made it clear, but I could move each
>>>>>> comment next to each condition:
>>>>>>
>>>>>>        ...
>>>>>>        /*
>>>>>>         * Return false for an fd, because it is visible and can be remapped in
>>>>>>         * new QEMU.
>>>>>>         */
>>>>>>        if (rb->fd >= 0) {
>>>>>>            return false;
>>>>>>        }
>>>>>>        ...
>>>>>>
>>>>>>> I wonder if we could stick with looping over all ramblocks, then make sure
>>>>>>> each of them is on the cpr saved fd list.  It may need to make
>>>>>>> cpr_save_fd() always register with the name of ramblock to do such lookup,
>>>>>>> or maybe we could also cache the ramblock pointer in CprFd, then the lookup
>>>>>>> will be a pointer match check.
>>>>>>
>>>>>> Some ramblocks are not on the list, such as named files.  Plus looping in
>>>>>> migrate_prepare is too late as noted above.
>>>>>>
>>>>>> IMO what I have already implemented using blockers is clean and elegant.
>>>>>
>>>>> OK if we need to fail it early at boot, then yes blockers are probably
>>>>> better.
>>>>>
>>>>> We'll need one more cmdline parameter. I've no objection, but I don't know
>>>>> how to judge when it's ok to add, when it's better not.. I'll leave others
>>>>> to comment on this.
>>>>>
>>>>> But still, could we check it when ramblocks are created?  So in that way
>>>>> whatever is forbidden is clear in its own path, I feel like that could be
>>>>> clearer (like what you did with gmemfd).
>>>>
>>>> When the ramblock is created, we don't yet know if it is migratable. A
>>>> ramblock that is not migratable does not block cpr. Migratable is not known
>>>> until vmstate_register_ram calls qemu_ram_set_migratable.  Hence that is
>>>> where I evaluate conditions and install a blocker.
>>>>
>>>> Because that is the only place where ram_block_add_cpr_blocker is called,
>>>> the test qemu_ram_is_migratable() inside ram_block_add_cpr_blocker is
>>>> redundant, and I should delete it.
>>>
>>> Hmm.. sounds reasonable.
>>>
>>>>
>>>>> For example, if I start to convert some of your requirements above, then
>>>>> memory_region_is_ram_device() implies RAM_PREALLOC.  Actually, ram_device
>>>>> is not the only RAM_PREALLOC user..  Say, would it also not work with all
>>>>> memory_region_init_ram_ptr() users (even if they're not ram_device)?  An
>>>>> example is, looks like virtio-gpu can create random ramblocks on the fly
>>>>> with prealloced buffers.  I am not sure whether they can be pinned by VFIO
>>>>> too.  You may know better.
>>>>
>>>> That memory is not visible to the guest.  It is not part of system_memory,
>>>> and is not marked migratable.
>>>
>>> I _think_ that can still be visible at least for the virtio-gpu use case,
>>> which hangs under VirtIOGPUBase.hostmem.  Relevant code for reference:
>>>
>>> virtio_gpu_virgl_map_resource_blob:
>>>       memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>>>       memory_region_add_subregion(&b->hostmem, offset, mr);
>>>       memory_region_set_enabled(mr, true);
> 
> [1]
> 
>>>
>>> virtio_gpu_pci_base_realize:
>>>           memory_region_init(&g->hostmem, OBJECT(g), "virtio-gpu-hostmem",
>>>                              g->conf.hostmem);
>>>           pci_register_bar(&vpci_dev->pci_dev, 4,
>>>                            PCI_BASE_ADDRESS_SPACE_MEMORY |
>>>                            PCI_BASE_ADDRESS_MEM_PREFETCH |
>>>                            PCI_BASE_ADDRESS_MEM_TYPE_64,
>>>                            &g->hostmem);
> 
> [2]
> 
>>>
>>> pci_update_mappings:
>>>               memory_region_add_subregion_overlap(r->address_space,
>>>                                                   r->addr, r->memory, 1);
> 
> [3]
> 
>>>
>>> but indeed I'm not sure how it work with migration so far, because it
>>> doesn't have RAM_MIGRATABLE set. So at least cpr didn't make it more
>>> special.  I assume this isn't something we must figure out as of now
>>> then.. but if you do, please kindly share.
>>
>> AFAICT this memory cannot be pinned, because it is not attached to the
>> "system_memory" mr and the "address_space_memory" address space.  The
>> listener than maps/pins is attached to address_space_memory.
> 
> I still think it's part of system_memory - every PCI bar that got mapped as
> MMIO regions could be part of guest system memory, and IIUC could be
> pinned.
> 
> Normally these MMIOs are IO regions so "pinning" may not make much
> difference IIUC, but here looks like it's real RAM backing it when
> emulated, even though they're "MMIO regions"..
> 
> Above code clips are paths that I think how they got attached to
> system_memory.  It isn't more special than a generic PCI device's bars got
> mapped to system_memory, though:
> 
>    - Firstly, at [1], the blob is part of VirtIOGPUBase.hostmem as subregion
> 
>    - Then, at [2], the VirtIOGPUBase.hostmem is registered as a pci bar, in
>      this case, it's BAR4.
> 
>    - Then, it's the same as other pci device BARs where they can logically
>      be mapped into guest physical address space and be part of system_memory.
>      Above [3] was when the bar memory got added into PCIIORegion.address_space.
> 
> Then if to fill up the last missing piece: taking i440fx as example,
> ultimately the pci bus memory address space will be attached to
> system_memory here:
> 
> i440fx_pcihost_realize:
>      /* setup pci memory mapping */
>      pc_pci_as_mapping_init(s->system_memory, s->pci_address_space);
> 
> Again, not requesting to resolve this immediately: I have no idea how
> migration works at all with random new ramblocks being added.. but I'd
> still like to check we're on the same page on this specific case, though.

I agree with your analysis; thanks for connecting the dots. The vfio memory
listener callback vfio_listener_region_add would be called, and pin the memory
for DMA.

The memory is allocated by an external source, the virglrenderer library, so cpr
is not supported for this device.  virtio_gpu_base_device_realize already calls
migrate_add_blocker, which blocks all migration modes.

- Steve

