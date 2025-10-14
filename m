Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C418CCD190
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 21:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8mZf-0005bY-Ol; Tue, 14 Oct 2025 17:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v8mZb-0005bF-Df
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 17:28:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v8mZX-00083r-B8
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 17:28:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEf7Jh020417;
 Tue, 14 Oct 2025 21:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=tWqQgZ1eqsvZxG+2iMJDPnlmtss7epPuG0sZsNvBdHs=; b=
 d2FYot++q3fikK1koCS6U2g9ZO90Dr58a4wmA8qS0z3IGDSZl5Y3PU6bof1Ozqo4
 Z3DnBk2UpN1vOiZDI0BBrEZuwjKGs80cv0X3sS83AzE/8p7pP6WWUNUVen+8rANk
 qTekU//VTeAM9NhH22cXod6/JmjLD5Lj5EaV5tuZzZsAJheduQp9oYuLA5uAeV+V
 +DlTW20+T2zGiqS5MvXq06TkzOTRCh1iizg1Ha1pzZKPijjnh8Ka3WtUG0L+P+UT
 4zGWL1ALqRIFUm6+x7aNgaDM9y6NgacFT/z+30XWxZ+1Yg25k9CBVDEBe+pYLIol
 gWHAkDo+T5BpAkGFBCEvSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfsrw9pv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 21:28:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59EKF7lm026402; Tue, 14 Oct 2025 21:28:30 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49qdp98spt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 21:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZhL+V62YQNBNk+1297dIFHYBGCpYhL91xIvBtHua5axp9xSK/2IJX3P4cH/h/lYHDBjX1nI+WsTO+BJeQpdfh7BT207DO622fSFwwkOhZX8vxXN2urnzSuMbrEGtgLEX8GmumbAPrERXaSdhvvxOIp2XBGYwVA3nruqZcaIthSnKe3idYmi5jxhqfCdomuyt691WMzVIMVCspHJzJ3bdz7fJz/azQcDrwgbG734DVv9gqSRKK8JrWf1m30FkkN7oOb6iEV3TbpsftQ1SxB7qOxPBcmJo2E6wiIbdfU+Xrv3preWwP6qG40Bs654FmXY/3f7Ed+dgQzvlu20k0tzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWqQgZ1eqsvZxG+2iMJDPnlmtss7epPuG0sZsNvBdHs=;
 b=nA4na9QigYsWrzUNUWdMBCc95x8668bIAOTAIvTU+I2RhBuCJGab0z277A/fA+6Zv6KBjRNrEFbT7YMz3xOE5iSPIzuWdRdQgc6C/HnwuSyU9Tz+hQdQon+B8vH81GC9M9Axqu5FPiq15FxJ1QlZ2RAZffsKd7J5aOtmf/W48BjAam5/TePaQgHtvJ6sDbJ5fsegE5RFZ2zYs6INarwtAMzGCiYBvf1zP1VQpclUFXEZKoW2CocwwrFyFLC4NBBNY5t93/4Wg7s8UiOmKCBspQJ1WIk0evkgZ9aPdhIN/J77w9HXzK3aSSzLNWRCQtrzDBhQunDofwH7bdUfgHF/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWqQgZ1eqsvZxG+2iMJDPnlmtss7epPuG0sZsNvBdHs=;
 b=vcWp6k6ATn9pmOKAH8gp+iwPlGf2tYy7lRU4LgSjVpHz3jPUTtnMNsuWlWWXvJMo149CWJV624yi09/8bK8BXoyzcicwDQWl+5WxkSLbm+81toU6hvwVai1Uf3kGVpwPBo/X8qmJfliS/5Gf89amgmwbwZ410rmaxw/YwJ/Iu8E=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by IA0PR10MB7157.namprd10.prod.outlook.com (2603:10b6:208:400::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 21:28:26 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 21:28:26 +0000
Message-ID: <b55e48e1-2557-45e1-bd18-8320b9dec718@oracle.com>
Date: Tue, 14 Oct 2025 17:28:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] amd_iommu: Fix handling device on buses != 0
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, aik@amd.com
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-2-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251013050046.393-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::27) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|IA0PR10MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 437e3bf2-3aa0-4925-7791-08de0b689c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXhiRlZSc1ZmZVhCVVc3b2gvUkpVSkVXOEFUMk1od2c5OGhGUVVnZ2xYa1B0?=
 =?utf-8?B?VCt6aFpaSUx3WlVyVWY1cXBRZy9UQWVNZWswb0d0NkJRN2UzUGxJUWFndkJv?=
 =?utf-8?B?K0tpKzFGZERMVVh0WndyV2hoSkd1TmlhQmFzM3pkaDNwU3VXYmM2bUJKMFI2?=
 =?utf-8?B?RmMxSmpBRm5pakF4SnVzbzVjazdhUlBmaVY4T2tYaGtodEhDMnlEbnA0NFVu?=
 =?utf-8?B?OE1yL1lHWWh3V0MrK2RYTWlWU3VjeW1CRGp3Q3NXTTYyUGdKV3llRElSb0p2?=
 =?utf-8?B?SzBucjZMZ1ZTN2V2TUQ0bWZ6OGtXY1cxN0RaM0twV0FJY2NPNmg5RlQ5QjRP?=
 =?utf-8?B?cSsvZDB2WCswUDBsRjFPdzV0dGs2V1drUDhDU3lMNEFGY2EzYnRXYzEzOTZp?=
 =?utf-8?B?NmtpSUJWbU9SNFpxWDhJSFNVT0tHRitoeWh5Y2dXcnVKUWtHTnQ0U0pXMnc2?=
 =?utf-8?B?UmpVbE5lR2FvVFk5VUx5QTdqSURHd0U3MzdTd1hpOEF1Ynh3OUN4cDJkaElK?=
 =?utf-8?B?MjVGMklzWkFId2hkWjNPYnZ4clFsWXpMMk1WZE9Sb3BkY2RjS1dwRmFqaWc5?=
 =?utf-8?B?dVhYa3YyYk9LTE1RQWM3Rkd1YjI2R0lxcUxLUWVSY3g2dFZxVDM1N2ZuMjdO?=
 =?utf-8?B?N3h5bFpkVUNKalEyc1VkRXJBcGs1clRsamN0SUNRUWVYekpvelJuNUhvTCtN?=
 =?utf-8?B?UzhueEpjTmd4ZGxnN0hyYXdwNWxXSjR0QWMrTnVzdEtHbXd1enFiQzB1RWQ5?=
 =?utf-8?B?ZldMUWJ0eG9sNnRiQlBtdWorRi9CdDV5U1d0OXBFdzFsV2Q4Mk5aaXRCK0Uw?=
 =?utf-8?B?bmI3b21YNXJRQlFSTUp0NmFpWWxGOGhWK3FGcjBEczNNNXc4UlZlSys1TkNy?=
 =?utf-8?B?cTNNOHd1SkpBa0lzLytQT2szQnczZldPNEJ0SE8yNnJpdVFwY2N2QUhHaEp0?=
 =?utf-8?B?dWp0bWdmbGFwLzlSR1BiYmlCczNjU2tRSXFZRTBrSjAyTlZuNDhjbmpndGJZ?=
 =?utf-8?B?LzJhMkpUYjNISklDUnRUSWNtd3RiUDBZZUpvMW16SmNGRit3dGU4Y245TnRi?=
 =?utf-8?B?Nll4S2p5aUFsRUcxR2NwTTRYb200WE9NbVlVMUF1R0UrT0o2OUdOSVVXWWZE?=
 =?utf-8?B?cm5mcDlmQkdHTVc0MjJYaENZRzRrUktuUDZtenNuaXJZMC9lcEJZaElMdFBG?=
 =?utf-8?B?QkpvRkY0bGwrb25yTDY5cUZTZHJHTExFRjJVMCtLSGp2NVV6L1lRdnlCR1pp?=
 =?utf-8?B?ODNnejBqaDlmM1kzZlRubUxNakpuN2NqekVkeWMwWTJsNmVYellVVkJIWkJR?=
 =?utf-8?B?a2IzYkJQMklSdU9sWjdnUHBjUmxMSy95RWxSSnpjY0R5aGhROCtQK1FpQWdy?=
 =?utf-8?B?cDZCeWlqUDRsSnFOcHIxU3E3ZVJ0bXY3NWZ0NUpMZi90UU42Y0dLMDU3b2xj?=
 =?utf-8?B?MmVxQUtNaVJLWFFmZ0w4b2ZVZndJVC82RFVzQUtNVVFQT3ZGTUZSVXBqS1BN?=
 =?utf-8?B?cTJkeXl2cTJsR2srMnlja25Scnk0MlZLNFVzcFlTNnFzSDVHajd2d2Y2Vm4x?=
 =?utf-8?B?dTJPaEZ3REw4TzBzeFlMYytXSWRHbUptMkMrcjc0dkZrSlk1ZHV6TWhlUHRv?=
 =?utf-8?B?b2dkcmZ4aEZqMXJ6TFQ2V2ZkVHFNSjRtTW5KOFVLRGR1Zk5tRFNGQnlHUUFM?=
 =?utf-8?B?bTFLWFEyZ0VseCtHbDhGcE1zM0JHSUhPRlNhaUxYZitJRVRNdW45cEJja0NC?=
 =?utf-8?B?RkxWZ05qYytPUG5rWllKV0pjc01CaFhJSjVMYkZkeS8wUkpDR2Qzc2puUnJo?=
 =?utf-8?B?MFhEZUJCQmVvUzB1anZxUDk5RGhkcUY5aFdKNzJkekVQYmVXKzVtTFJNT3VX?=
 =?utf-8?B?RktGeUhlaEx1aUFiVzh2ejhIcnVDeG8xN1F3QUs2ekozOGk5YTROUmI0NzVo?=
 =?utf-8?Q?dxg8zBeuurdb8gqGQeJrYn6pcMkH0UFC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmhTTE1acEF4TU5sRVJpRnNJTGlhUDJJZHEzNWRBb2Y3R2h5WC94M2RyOHNY?=
 =?utf-8?B?czhlYUp2WFVmaUcvY2poWTg3WVI0anFyem1yRnVhU09vMzNrcG9KTnNRbHhI?=
 =?utf-8?B?a0FYdExjNjhhUkRTOXE0Y0pLeG1lRFZKUFI3U0xBeUl3MzJhTFBUY3ZwQnZ1?=
 =?utf-8?B?RW4vNnA4cmljeTVLeGtXN2hHWTkwaExkY1BEUUEwSXR6U252Z2UxMkZQVU1v?=
 =?utf-8?B?YTYxTUJuRUJFU29WVGcwMGl1OFNHNXBOY21rREY1VlB1WHI5NkpXOEpka3Yr?=
 =?utf-8?B?WWJWVkc2Q3FTZ1RPUFB5UkZhYkl1dHdGak01T3BOSkVCcVFld1dHd1k2TmhC?=
 =?utf-8?B?UW5tVUFrZ0RKREZuTTFldUZPTERRSDkyY1lmRjV6Y3BFY2ExZW9XK2F2U2xq?=
 =?utf-8?B?bTNhdGdaUVIvVWN6UVRFTDEycVJYVTNEdmRsem1RMEgzSUJzR2pIMURobmFN?=
 =?utf-8?B?dU9iODV2VERNRkF3WTc4YlhwVldZeTNTbEM2WmVvaWMvMnozbkRuY0RBSFFS?=
 =?utf-8?B?S253NGUrQXJZRjJRNVQ5bWw0WjFDK3pKdXFlUjJEVTlHOUJMcWVGMVhiZWRr?=
 =?utf-8?B?bFNrZ1libTl5dTQraXhMUy9RSnE2dGllUXdJcnFkMmZ2MUhPQjJIaWRYcHNx?=
 =?utf-8?B?SmJKWTRmRy9vSkV1cUJpQi9LWVVSc0NxTzhIQmJYUVg0dFFsQ0xLUU5zcURF?=
 =?utf-8?B?WFdDL3JzczNBM0FJZm9ONjgrNEZnbXZtNUUwUCs5SnB5d1pZSmZwV1NDbThE?=
 =?utf-8?B?L2tUL1RmOVdKK282UXY2aThRc29EMnR3bW1YTUx5azhHMkVaQTBKYjNhTXB3?=
 =?utf-8?B?bXMycTdkaDhYR2IvZ3NET3hCdUZmdHRsV2xWSld6U1lGMS9ZbWV5bU9JNk1B?=
 =?utf-8?B?RkdQZVc3NUNGZW5yWUx4bFJZK2hNS2Z4N0JJVTREYlp5a1RIZ0R0ZE9vTHgz?=
 =?utf-8?B?WmhCVDZSQU9wbURxRDExaXdMMnpZK0w0WEd1UjloWDE5c1hKclY0OTIzbVdE?=
 =?utf-8?B?ZnEyczdISll6THdLRVdyNGNkZ1FMM0JlTU5lZ1FvdUJCSWlBWTg5SktMRHJM?=
 =?utf-8?B?ZmIwNnFjWDQ5VENodjRucmlvOG1Xa3RqcjEzVjNuYzg5ZlpnSlA2WFNNa3pv?=
 =?utf-8?B?NUFXRHNMM3JvRlN6QVpFUmpvYklZOVBQMDFXV21velBqWDcxMEphK1Rzby9V?=
 =?utf-8?B?L0F3ZGoreXlOUGYzSFQ2TG5MTDZmRFhGU3VUaWphV1owVXU3R014ejVETzEw?=
 =?utf-8?B?MHJOYjFneGVVaVNtL09Bd0JpTFdXb2R6NVEvVXY1UWpKOWlWVUp5cDhLa1VK?=
 =?utf-8?B?VDFHRlQ5M1lkTm84TldycWxhbFNxczhPTDd0RXJUMFpGcURzb1k0SXJUUlBM?=
 =?utf-8?B?SFpTSS8zcDhteXpldXJVY2dvenhIU05xQ2pHbk5KcUIvOWdQdkR4OTFQSnM4?=
 =?utf-8?B?S1hGQ3J6UktPMy9BdzQwdlBMb28zeldLMVA4VnZmSjJBSGhnTERYaXBGaFdQ?=
 =?utf-8?B?SUFKekd0dmI3aXM5bHIvVitEODc0OVJOMW9zQnQ3Z0JwRGkyS0g5M0VNUm1K?=
 =?utf-8?B?M2lqNDhjbzhwdmVVWkRXcjU3Yk1yRXlCNE83K25KZmcwR2xvQ2tSdjZ5K1Jo?=
 =?utf-8?B?TnJ4UVNJeWVkSmNrVXhXdGwvc2w4eVBndVU1eFhnb0ZmcFF3L0xHVkhpSkVn?=
 =?utf-8?B?Q2Fva0kwaFRGS2lxTUxIbWxYV3RlV2k3UEdUbDE3TWpoV3lnR0hHeFlrTkNi?=
 =?utf-8?B?T0tNeFdwZHNoWDlzb1NKQU1yYUV3NTZDVFMrWmhzVHpHME5BVkRScXV6a3M4?=
 =?utf-8?B?REtZRmM5N0FvWDYrQ2NjSk9TV3RtNy9tTFg5VTVTODlHcEF6VDlBeTA3UUVx?=
 =?utf-8?B?aWFSY00xQUFMUXlkeUMyanFpOExkWkJjbFRQNlhoMW1Yc2Q0ZXM2NkJHRUYx?=
 =?utf-8?B?YUdGL0tGd21DczAzV0E2MmtPZXdhL1VLMTlSYzFUMnU0TzA0TUFMTnAzUVhW?=
 =?utf-8?B?SHZOUktXbmdGa1NaeFZOYU8xdnNLdGJpZU0rUW4wMHpZK2pOREE1Nm9OMjNE?=
 =?utf-8?B?aUdMU0huVDM1ZGNvNDJFbURRWm5EQlU0c3BXNmNmSXdUWmlQVUhKcm1ralRs?=
 =?utf-8?B?NktvMmlERVZFckFucmErWjMvRVAvRzdSWEY1ZEVnNGFBUXFrb3FjUENEa3pt?=
 =?utf-8?Q?LQVS5NgKm1IOXPkDmKBU3Xs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cs9rl5r1keFPyeI6spBi+K6zGwD9iJUNaCjnirx7AAs9EJWQsehx74r+s2iLQWptTr/vSGN0a0pLpY1ZNFe/A6xIODbskEWSkkLOuCSCe6DPuJbThge8koQ86k0wtvRPXo2jp5RKeBM6jTHHBiNKMeWVRHPomDxPwCVtXRO3CMqH3zqT3MP3w0uAJ8ESPtrtZCmyW7+gYZfI7aRGXowYoVdeB3K8L8Q39DUlFCRVC5sIYYSrMgr2c6F7UA7aRZ3e6JR8ZuwWUnVkCMl7uElenQxNKeuCbopUqQMzOxV+Bpm863YFsFoNdQPHoAK7iYDoZeztcCC0dhjYlgDL20RYvFmZED0lGIc0jMxQ93UKGb6aq0l10QQoZeZ88kb4wqOjgFVFKv5QICAWmaOJOWxkra/E1GsLtVqaCvHrKZd108Bo6xNywEfu07SjiMaCc5QdG/5brXzVN6BfExqic+FqBtZ3vGvvVo2RSngkH7xGjka0JAQ1QDfWx9J9s+g0YZxt6Vr6LmyPzzPUNnyXBmeak2DlELYTWsiy1drj4/VHrJ5qcG39uIz1lbNmKaF7YOGYu6TM4xz2rxcbHvtLCc95J3ew5P/iNg9HWdMIaVSluuU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437e3bf2-3aa0-4925-7791-08de0b689c4b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 21:28:26.1585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avD1XDnsOIA49nTsIjzt/d9fncb2QWv2JWY8wv7KB4TNR15lks6QrtCmKY1QK4CdKq4iHS8FFq6ZLte0vVCP560KCR/nk2iPJnisii36Xwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140146
X-Proofpoint-GUID: memQm_bUG2nGfm4Fr8dCUzuACZ-8Ytpp
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68eec07f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=S4VHZ1LGKdml8piCdPgA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX2KynAPkanoXu
 bbLiH8PeJXWBb8tFE7tlxnCupGg6L1ykrCVd21UY0h+YBT4cIGQtY7bsP73VrloRhOSP//XzFyI
 DBv55OxVa9HQoM7FmhomthwpZF0ed8Vv4PME16Cx3XNZBpaMAiHcm2ATuTYIyuvKbffUpMDBRJR
 2NmEzSD+wcFeu4idXUzA2H8awReJrGA+9OuSZhPFuS6WNo8+Pgx0jx0DnXG5XPHPz2wDO80lIvf
 kH7/3/MeAHTIn5Qmo9ZOgZd5hFpT8Bo66EiJrqKQ+WwqGNiN45zHfbwKCnbr5KhEYF1+rPgVGqF
 xdx2XfBRU1tR2r/dm8WZ2+re8/MPz+Frjtg1p8CdHoNTmhweQV0VrTUJr6uyW/sBBEeRPYG0BrD
 A4mwzYY5NXzFgzHf/zBmhwuyukBvEw0Wf1ez9OHRtktjrBzV374=
X-Proofpoint-ORIG-GUID: memQm_bUG2nGfm4Fr8dCUzuACZ-8Ytpp
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/13/25 1:00 AM, Sairaj Kodilkar wrote:
> The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
> for indexing into DTE. The problem is that before the guest started,
> all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
> kernel will do that later) so relying on the bus number is wrong.
> The immediate effect is emulated devices cannot do DMA when places on
> a bus other that 0.
> 
> Replace static array of address_space with hash table which uses devfn and
> PCIBus* for key as it is not going to change after the guest is booted.
> 
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>   hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++------------------
>   hw/i386/amd_iommu.h |   2 +-
>   2 files changed, 79 insertions(+), 57 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 378e0cb55eab..b194e3294dd7 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
>   };
>   
>   struct AMDVIAddressSpace {
> -    uint8_t bus_num;            /* bus number                           */
> +    PCIBus *bus;                /* PCIBus (for bus number)              */
>       uint8_t devfn;              /* device function                      */
>       AMDVIState *iommu_state;    /* AMDVI - one per machine              */
>       MemoryRegion root;          /* AMDVI Root memory map region         */
> @@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
>       AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
>   } AMDVIFaultReason;
>   
> +typedef struct amdvi_as_key {
> +    PCIBus *bus;
> +    uint8_t devfn;
> +} amdvi_as_key;
> +
>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>   {
>       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
> @@ -382,6 +387,44 @@ static guint amdvi_uint64_hash(gconstpointer v)
>       return (guint)*(const uint64_t *)v;
>   }
>   
> +static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    const struct amdvi_as_key *key1 = v1;
> +    const struct amdvi_as_key *key2 = v2;
> +
> +    return key1->bus == key2->bus && key1->devfn == key2->devfn;
> +}
> +
> +static guint amdvi_as_hash(gconstpointer v)
> +{
> +    const struct amdvi_as_key *key = v;
> +    guint bus = (guint)(uintptr_t)key->bus;
> +
> +    return (guint)(bus << 8 | (uint)key->devfn);
> +}
> +
> +static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
> +                                          uint8_t devfn)
> +{
> +    amdvi_as_key key = { .bus = bus, .devfn = devfn };
> +    return g_hash_table_lookup(s->address_spaces, &key);
> +}
> +
> +gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,

This causes a build failure.

Please continue using static for amdvi_find_as_by_devid() i.e.:

static gboolean amdvi_find_as_by_devid(...

This local helper is only needed within this file.

Alejandro

> +                                  gpointer user_data)
> +{
> +    amdvi_as_key *as = (struct amdvi_as_key *)key;
> +    uint16_t devid = *((uint16_t *)user_data);
> +
> +    return devid == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> +}
> +
> +static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
> +{
> +    return g_hash_table_find(s->address_spaces,
> +                             amdvi_find_as_by_devid, &devid);
> +}
> +
>   static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
>                                              uint64_t devid)
>   {
> @@ -551,7 +594,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
>   
>   static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
>   {
> -    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
> +    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>       AMDVIState *s = as->iommu_state;
>   
>       if (!amdvi_get_dte(s, devid, dte)) {
> @@ -1011,25 +1054,15 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
>    */
>   static void amdvi_reset_address_translation_all(AMDVIState *s)
>   {
> -    AMDVIAddressSpace **iommu_as;
> -
> -    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
> +    AMDVIAddressSpace *iommu_as;
> +    GHashTableIter as_it;
>   
> -        /* Nothing to do if there are no devices on the current bus */
> -        if (!s->address_spaces[bus_num]) {
> -            continue;
> -        }
> -        iommu_as = s->address_spaces[bus_num];
> +    g_hash_table_iter_init(&as_it, s->address_spaces);
>   
> -        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
> -
> -            if (!iommu_as[devfn]) {
> -                continue;
> -            }
> -            /* Use passthrough as default mode after reset */
> -            iommu_as[devfn]->addr_translation = false;
> -            amdvi_switch_address_space(iommu_as[devfn]);
> -        }
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
> +        /* Use passhthrough as default mode after reset */
> +        iommu_as->addr_translation = false;
> +        amdvi_switch_address_space(iommu_as);
>       }
>   }
>   
> @@ -1089,27 +1122,15 @@ static void enable_nodma_mode(AMDVIAddressSpace *as)
>    */
>   static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
>   {
> -    uint8_t bus_num, devfn, dte_mode;
> +    uint8_t dte_mode;
>       AMDVIAddressSpace *as;
>       uint64_t dte[4] = { 0 };
>       int ret;
>   
> -    /*
> -     * Convert the devid encoded in the command to a bus and devfn in
> -     * order to retrieve the corresponding address space.
> -     */
> -    bus_num = PCI_BUS_NUM(devid);
> -    devfn = devid & 0xff;
> -
> -    /*
> -     * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
> -     * been allocated within AMDVIState, but must be careful to not access
> -     * unallocated devfn.
> -     */
> -    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
> +    as = amdvi_get_as_by_devid(s, devid);
> +    if (!as) {
>           return;
>       }
> -    as = s->address_spaces[bus_num][devfn];
>   
>       ret = amdvi_as_to_dte(as, dte);
>   
> @@ -1783,7 +1804,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>                                  bool is_write, IOMMUTLBEntry *ret)
>   {
>       AMDVIState *s = as->iommu_state;
> -    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
> +    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>       AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
>       uint64_t entry[4];
>       int dte_ret;
> @@ -1858,7 +1879,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>       }
>   
>       amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
> -    trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
> +    trace_amdvi_translation_result(pci_bus_num(as->bus), PCI_SLOT(as->devfn),
>               PCI_FUNC(as->devfn), addr, ret.translated_addr);
>       return ret;
>   }
> @@ -2222,30 +2243,28 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>   {
>       char name[128];
>       AMDVIState *s = opaque;
> -    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
> -    int bus_num = pci_bus_num(bus);
> +    AMDVIAddressSpace *amdvi_dev_as;
> +    amdvi_as_key *key;
>   
> -    iommu_as = s->address_spaces[bus_num];
> +    amdvi_dev_as = amdvi_as_lookup(s, bus, devfn);
>   
>       /* allocate memory during the first run */
> -    if (!iommu_as) {
> -        iommu_as = g_new0(AMDVIAddressSpace *, PCI_DEVFN_MAX);
> -        s->address_spaces[bus_num] = iommu_as;
> -    }
> -
> -    /* set up AMD-Vi region */
> -    if (!iommu_as[devfn]) {
> +    if (!amdvi_dev_as) {
>           snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
>   
> -        iommu_as[devfn] = g_new0(AMDVIAddressSpace, 1);
> -        iommu_as[devfn]->bus_num = (uint8_t)bus_num;
> -        iommu_as[devfn]->devfn = (uint8_t)devfn;
> -        iommu_as[devfn]->iommu_state = s;
> -        iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
> -        iommu_as[devfn]->iova_tree = iova_tree_new();
> -        iommu_as[devfn]->addr_translation = false;
> +        amdvi_dev_as = g_new0(AMDVIAddressSpace, 1);
> +        key = g_new0(amdvi_as_key, 1);
>   
> -        amdvi_dev_as = iommu_as[devfn];
> +        amdvi_dev_as->bus = bus;
> +        amdvi_dev_as->devfn = (uint8_t)devfn;
> +        amdvi_dev_as->iommu_state = s;
> +        amdvi_dev_as->notifier_flags = IOMMU_NOTIFIER_NONE;
> +        amdvi_dev_as->iova_tree = iova_tree_new();
> +        amdvi_dev_as->addr_translation = false;
> +        key->bus = bus;
> +        key->devfn = devfn;
> +
> +        g_hash_table_insert(s->address_spaces, key, amdvi_dev_as);
>   
>           /*
>            * Memory region relationships looks like (Address range shows
> @@ -2288,7 +2307,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>   
>           amdvi_switch_address_space(amdvi_dev_as);
>       }
> -    return &iommu_as[devfn]->as;
> +    return &amdvi_dev_as->as;
>   }
>   
>   static const PCIIOMMUOps amdvi_iommu_ops = {
> @@ -2329,7 +2348,7 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>       if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
>           error_setg_errno(errp, ENOTSUP,
>               "device %02x.%02x.%x requires dma-remap=1",
> -            as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
> +            pci_bus_num(as->bus), PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
>           return -ENOTSUP;
>       }
>   
> @@ -2510,6 +2529,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>       s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
>                                        amdvi_uint64_equal, g_free, g_free);
>   
> +    s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
> +                                     amdvi_as_equal, g_free, g_free);
> +
>       /* set up MMIO */
>       memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
>                             "amdvi-mmio", AMDVI_MMIO_SIZE);
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index daf82fc85f96..38471b95d153 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -408,7 +408,7 @@ struct AMDVIState {
>       bool mmio_enabled;
>   
>       /* for each served device */
> -    AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
> +    GHashTable *address_spaces;
>   
>       /* list of address spaces with registered notifiers */
>       QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;


