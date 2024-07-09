Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D380C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 08:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR6eK-0006md-Q0; Tue, 09 Jul 2024 04:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6eI-0006g1-R7
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 04:56:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6eG-00058k-9q
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 04:56:34 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tTBi007086;
 Tue, 9 Jul 2024 08:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=dG7GdDRviEPj2j7n/Xf5+k41THsWWTL1rI4RmaXG4To=; b=
 BRlkbdlmjXO1mQHJXJLIBn6E6huxp++Cwts5OIU5o8ggsR2U3TxaFynuscz59Out
 5QdetbHIhkiFIyzFD8cWkRx1HMYhD29vRm1ErwZhTxet6cMhWCdlXUKMS+x+A5rZ
 GGo9k6G6Do4su7OK9CGIAcdGEqWddGq9RjB9t572AaO++SAqOxYQMkBV6YzXqI1v
 lZQFjIlYtk6jLLoSPBtGK9g1tMqpxh2dwDAnsHmosFukDWqISQY72oLAQGJBLsyt
 4kGyYPy24+eWr8hysLMkHldjIMpCwembZ+VboCW6bqwkR3QbWMhAOMxjy+T2Z8bI
 JH6ACR+KQL1CAntuZuSMbQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybmgcg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 08:56:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4698UCvk013662; Tue, 9 Jul 2024 08:56:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407txgn3gu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 08:56:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNmlSCAnKNLUgdBuMYbRK5SBClQz3SfNXuLchH0xHJlp6MXCvI5lMzLtmwnBv+an4DwhAvX3tUJkFuNi+DtqXTT2noJFNbbAiXX8RQBFA/kIJE6FR4Dr3Hll7e1dNdyUl10QiflfHhCQtnIv4rayXSYmvYJBO7VLjx3k8qB/xvzGjMB9cLrnVCrKdOJZCH+xZh5YOlOBiU3R/+NMWREhRRalBfqA+J9uhzoQbR6nmrCd1hskXE8gcbsoycxALNdhR1toPI95rTX99WKG+TIgu0a0odKuQz9GBsGFDTQr2pDV+bmXp4xbtNLfQF1a7H1q3IxvsF5gBBbq4Clzb5gFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG7GdDRviEPj2j7n/Xf5+k41THsWWTL1rI4RmaXG4To=;
 b=W29BCg87ZdMCzj5Kzd6CBf4DqnWW3tiyOVXxUCcpH2ZeznVLcYfS6RcPWXG+MH5x1xUcpUUm+FXtm9NjEL9wIrXdX+tAoQjlCrkP9dnwnVYm+L5299Zw+Grt1XLvVSThwehNC5Xhq+w0/mTif8DZDFfhtbKCqPM+tIxVXwAYOOWZjvMwJMz0beyKtBlzByelShaxf0NCTFJFb+/Eagptt/zUEnUgQa7W2VqQObmnsgHkPnMUGYy+lQ90DKkuc8ngHx5BBzHSJUMH97PNBMJwsTf8WNzOf5SxGSKO/qg6MCqwccuG6ktFWW/Xiv1YY/owTaISrxTYTkjjwaB9plo4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG7GdDRviEPj2j7n/Xf5+k41THsWWTL1rI4RmaXG4To=;
 b=TJ8H8j4rFiRcZUzjToc/OHZNkX/JLp8lcLo7mNxl9+QDGzvqRdnTlrI9F+BcODqds79sRcL+M19Vb7/lI/32Cz1bG76mlEXl61WJ8gtzukanNtEhqnvMyoJkHxGQWsEf38pwXz7AFi6dwzofZ1iwjvJwAon0CXe9aRF01uvGxIs=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BLAPR10MB5105.namprd10.prod.outlook.com (2603:10b6:208:325::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.38; Tue, 9 Jul
 2024 08:56:24 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:56:24 +0000
Message-ID: <e822d50d-8147-4846-94bf-fd32cb1aff99@oracle.com>
Date: Tue, 9 Jul 2024 09:56:10 +0100
Subject: Re: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
 IOMMU_GET_HW_INFO failure
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-2-joao.m.martins@oracle.com>
 <SJ0PR11MB67440E96F272F5D349023AEB92DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB67440E96F272F5D349023AEB92DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0144.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f8::12) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BLAPR10MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: ff68d4a3-bbfd-4197-9502-08dc9ff502c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDBFeHNLRFBSUXd1a1Nsdi9LU0E4L2RXeElNb0dpb3hRUmZnSTQ5TkM5dktt?=
 =?utf-8?B?eUZ5UlNxTVdlY0wrZW9mWVJrTWtnQjRDYnhVeXpzcjJyZUV5VDkvN1hNWU8y?=
 =?utf-8?B?VFVjSGo5SURVeDJpSjJBSzZPaUdtZ202cVBRWCtPS1hTeGdiWDhFYjhNaVY3?=
 =?utf-8?B?S0Ywa25TSmlhL09vU0ZKcVI1U1QwbmRLQmdUKytpcDNXcjdablEzYVRkdngw?=
 =?utf-8?B?ZUNDdkNXalNJZjU3dzFYeklJWFZ5dFZPTkx0KzRZYWYyQWJzTHJWdmEwMVg3?=
 =?utf-8?B?aThKa3NRdUdFRDAvQUlaTWtCUU5WRjRGN0lNTEZFMFVCMXpQeU11YzByZFE2?=
 =?utf-8?B?REw1RUdiZjBERW40NDFScFZnWGtkNUI0K0lySWRwL3IycStRVnVKOVZmeUQ0?=
 =?utf-8?B?Tm5Qb0RPU0F0ZXNWUG5oTjd6ZitNSEZVTno1QTVmVUprY2tmdlhsSjJxTmZY?=
 =?utf-8?B?Tjdvc2lkK0lwejVIbXJROHMvb0lPYmo1d0lhaDJCb0pQaVBBRXFoY1NRemVt?=
 =?utf-8?B?SGxkU3pvVlpEQ1ZRWnF6bk5NREcrOEU0K3BZZ1MxUUhobFk4alJPa2YxdmVx?=
 =?utf-8?B?OU15WUIzWU0xeXg1MXU1c0lnYVdqcC9KbjJudEZyL1drZm81WjlqSmxHT2FW?=
 =?utf-8?B?STFWQkE3dVFzamdiVjJESVpNcGFHckdKWWcycW1OeHNBVWlacWJxMkQrRm1a?=
 =?utf-8?B?MGpySGVudGdXUUYyK1pjazdiemZLYVVQT2hsQTB4bStReUNmQTVwUmhnMVhV?=
 =?utf-8?B?SDJ4Y29uVkxSbFdNNHdQaU9oSTBZQXlTLy9aM3pmYWhVZm1GK2Q2QWY4ZkRZ?=
 =?utf-8?B?TkFXck9qcGdnQlRGamhrSTdBU2N6QWRYdERLUkduWmVxNkxZMWhTdnBtMDZx?=
 =?utf-8?B?elN2UFRpMWgrSVcxN1g4cFllNUx2a1VUSWhZd2dBMm11STNKZzhrUDk4NnBk?=
 =?utf-8?B?K1U1VW9YT0ZJZ1B1NzlIWEM1allvTE5tTmxkY0NwWXoxbUY2VmJyeHN0TFRp?=
 =?utf-8?B?U0hvWGNMS1FrUXZZVmpOTGJQdnhhdEVKOFY1KzlzemxwbUtQR0tZbWNMSmFK?=
 =?utf-8?B?MzlEWU4xUWFjZDdRUWdlZ1RZak5OOU1TcWVlaHFnK3E4UG9jOWV1RUZvclFr?=
 =?utf-8?B?MUFmN1FZWUR5bnpIMDQ3a2VPUFNiNGVkN3VrZms1a3BNRzVSbmFtZzZwbCs1?=
 =?utf-8?B?N2NpckVmL2RMUlVIeS9HbVF4ZEo3c2dZM2FpaG1DNUpyYVlkOXk4b00yczZ3?=
 =?utf-8?B?aDk1YmluWm9EWTJmV09PVXo0ZmJ6NHg1cExGdURsT1NtWURTUERuTjlrZVNT?=
 =?utf-8?B?NkJkN290ZFdDeGlCeHZySmpDQkN1UHk4SGUwNHlxN2VKLzE4RzdOSkJiSG96?=
 =?utf-8?B?anZNdkt1VmFrejBnYnBZeUxDM2JQNG9LSDBpZzN0NnI3WE1LRDlYVjhBRTlU?=
 =?utf-8?B?RUVKSDNDTG5RUHV2blhaVDhhdktWM3JkTHBVMFhEemZjV1czYURnVzFIcjl0?=
 =?utf-8?B?T2dZNlVUQk5MeGQwVW9Raml5T2d4Zis2am5HTzhvQzJ4TnMybUhzRllhMnZU?=
 =?utf-8?B?WWJFZzd5Q0NHSEhZcW0ydUFtRjBER3FYcEN2WFM2bkV6cTR2MnZ3aGhvajdm?=
 =?utf-8?B?SGpRQ2F3S0crQmY4YzBUT1hsZ1o0OVdJbVFCWHdIbzBJNzNYanQzaVFUcVR2?=
 =?utf-8?B?U284MW1MVXludWdTcVRqRmxUTDhjNXNEbkROTFd4bjZrc05VWXRGcHROQm1F?=
 =?utf-8?B?dTRtNDhBcmQ5SmpjWG1XVVIvbitwWktlTzE1VGE1cDljc0FYdkNCaFdILzZC?=
 =?utf-8?B?N0tZL1g3YXJrYVB6UWd0dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWZmeHE4UzNuUWkwOE85ZVFiQW51Mm1iUmNadENubDN5bHJQdUl5Qm5hUUUw?=
 =?utf-8?B?TlZNVm0za0tac1o3dkh6cnhhVHYvMTl4Y2p2Q1d3QWhLL2F2eUlwalcvWlJ5?=
 =?utf-8?B?QlN2UDREamFBUmJIVG90OFQweTNSVzBVaWJRZzIxR0JiZGhaeFA5QnNjYy9o?=
 =?utf-8?B?MzVBZHFDK1R6RmxTTEFZdUcreURhTTNFQTJiYW1lNDRma1M1T3R0Z3BZRnl5?=
 =?utf-8?B?RWswa0xtNjE2QzJzL3ZJREJ0QlJFOUpERmtvaHBSVFFmMGY0SWtnZ0FSZVE1?=
 =?utf-8?B?OWNOQ2hFUkllTDMzWlZsck5GU0tQYUt5ZDVFYTlXbFlnY1JWWjBwRFg3OERN?=
 =?utf-8?B?d3F5U2I0ODE4M0lYS3hVRkdMOE5qSTBmZ1Y3TXBBL0dqV0NvQnhFTEFpRzVY?=
 =?utf-8?B?TU01SHVxS0NqTUZ2cml5VUIyZGJPMkJvR29HZm9SR2V3NzdTSXdxMkhPSFpX?=
 =?utf-8?B?V0xMcmljYjNXQ3lkL0I2a3l6T0JuNk9zejlWN2IxZVlFQ21pMWtURnNWTFE1?=
 =?utf-8?B?ZzM0L0tYQzdWVTZXYk9ZMUttU0JZZ3ppTlprOHpIYTJSYWl5QkdIKzZ1ZTZ3?=
 =?utf-8?B?MFNMSXpYV3dOM3U4UUpRYzVSdU96clNJaHZ4ak5NT1V4Zmh2MnFWK2EveWRI?=
 =?utf-8?B?OVNhN2ZNOHd4ZlJaMkIzenhUeW9lY3BxU1hPbmxzNmtuMnM0VUtTTkZodWcx?=
 =?utf-8?B?TStsUkdSalpqQVRDay81bU8rOWZPWjVvNGNKS1VMazFvL2xvTVlndCtmNjE0?=
 =?utf-8?B?U0pZcVRuUmRHMnJiUklacDgzUnhHK3FwdTlPWjlwWk5WQ28vbVZpNjhvZFZB?=
 =?utf-8?B?aUd0VWtyaFpvSjJCL1dPUVVDanNCNnQzb0xJSmduUVIwenRoQ2tBckNxR3ZR?=
 =?utf-8?B?alcvSW1kVDc1TGJwTlpKU1pyQ1dwUmI0WUpPREpJd0VpSXptdXYyN2VPdnUy?=
 =?utf-8?B?SmIrUHVNUUdLdlVNU21ITUF5bGJTc2dMMzBCa0lvVXA3aFR6Sm9IdTFJV0t2?=
 =?utf-8?B?Z1M3NHQwdTNENnNTU09pQnJ2eEdUYURaUHBLNFVsckYwbEFkMG5XYkY4QWNI?=
 =?utf-8?B?QldHTmR4ejRDV2E0VUdlS2tCOVRHaEpqMkM5dkxUaW45N3gyeFIyWkp6TTl0?=
 =?utf-8?B?OVd6amU5RzQrT0VlUVo0am5MZE5iVm12WW1aVEk5Si93WVU4N3NFSUVIN3Fi?=
 =?utf-8?B?MjluREpYVDRDSTZrQ1MrbWtySWxvT0l4cWd5Z0szQUVNd3FaS2VJYzdnbkFE?=
 =?utf-8?B?aENrbStvdEwyL3VlSEdNM3g4REpKNnJkd3IyWm45WFFRL1N6MDZjVmMzOFpP?=
 =?utf-8?B?alBQVHErSVcyUW13UUdNSmdXeTNxM3Nlc1NXdmVOWFF1cktwWTRnTUxqSG02?=
 =?utf-8?B?YjJ3L3JxMytpUmh3UGE4K09WTEV2Ymgzb1R0Znd6aWRidmMwQ3I1bnFINDd6?=
 =?utf-8?B?VlVsaFNtbk9WSlFleitMNzk3bG1Na0N2Y2FlVGF0a0JTVWtnT0J6OUE0UFk4?=
 =?utf-8?B?Z21ZN1dYTzhrbHpRcFZzZm8rT3U3c3JNMGx0cG8wS2lDcnF2a0VXMTRvUXBP?=
 =?utf-8?B?SnRnNHlsYmhCWHlEOGdPbzNRVFJobmMvK1RaaE9CNWRpNEJwWmszRU1wUzFv?=
 =?utf-8?B?VE8rSHZzdjA0MjBraGRVb2YvKzRWendDU2x1R2hxKzFsd0VhYjI3NHlpN3hy?=
 =?utf-8?B?ZWgyMUFsYkdnQmNDd1VubDkxUGM0ekhsSysyZ0xVSzNybWRPQ1pPTHlkK21I?=
 =?utf-8?B?b05SWjNzWWYyRDQxYzJIQ2lobDFZTkloT0RnTVpVNm8xMG5VYWVlWnV6cXFM?=
 =?utf-8?B?S09zYnFhN2xzc0xscThJYUhUejFaOHJiS1oxLzBPVGd4R0ZWQ2JnUGNoaXY2?=
 =?utf-8?B?UEVuSEFRRkRPczdBVkN2Ylh0ZlY0TXk3dFpnaTdQWitVU2dvTEZpZGdsTk5W?=
 =?utf-8?B?WW1DNXRhMVk2OTFSMEcwbXlSSzBOWHJXRDNPWFZ1QXFCMkEzQlJacWUxRldI?=
 =?utf-8?B?ZDZpbEZZN0gzc2QxNVU3a3ZCSmJteTNVdjRqY1phcTJBQTliWGU5SHE1azBl?=
 =?utf-8?B?aE41czM2MzR5VEpudXl2NURINFRnV00wRG1FdkRCbFVWdVJIU1J1cklsRms0?=
 =?utf-8?B?VDBTbERZQlYrZlR4RnNxSUhZdXl4SEV2aTVPeklabXlqTXc1SE9KNTZZMDN3?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TTs67sIMLJ1OElMD1LfrPHn8OEmK2g817+fn4YnIlroIFzExBALJL4t7aOar23Q+QFUnbPzeIH3Se4BHYG8qEZ7h+CLp5T3yGGAEIlK3OMedZG2Pjme1ufkdPtNEYZoc1kILJwjYH5TS2Y+hEBh8/pscUde5ly+CnSwzZ+iqykgynQlIXi3dUWi39QQ8lPqIwAbwiOAYnNR+oXbBlhIlRgIMGrXsSpQqbd6iK9fSsxHmYEDPjMbGoDE1MAVQ8EM82nzwB4+4t3/HP8ffj740iZe2oQNBiEh9jOBAlEuRaa0AyaDCcP60UsAS/93qR70b4tTECupyHN//h9mBXHA4lDnnGfmPhsO/lP/h6PTHlK0JzMfFJNP0Gx21bK9gjcrW40yqeHKbipE0Smu+ac0zlVTP0qsKFQZ0AabGYOYZqcTVj3eEDV/sS2MSkSz1WmdXKvInhyo/YE7JxcGOhyY+U1FfKKqrMfFA4oJIylieQGXJyB8n+jWSkiavxYzdmW0fAWswAr/uOTPQ2so3p4PZO9BvDdTk5pXA+LiztcYA+VJ/0ui3UXyvKak//YEQDMNQoDSLrUIHDlqfN8I9y+oTRWGzGZ1BxraCJ/clWgib9os=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff68d4a3-bbfd-4197-9502-08dc9ff502c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:56:24.4886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXfIfgZIxeFdo1bUq8ZB1e//lLf2qhR0pr6IBw5OO9OMuYMJZ1PXjA+grGva3/z4tF563/67jizQzi5riDP5ZegQeTQjNbDwCmJKFyd4Mjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090059
X-Proofpoint-GUID: GJ87op0udA6-FoUtbuFvG5TLZM7MSmfN
X-Proofpoint-ORIG-GUID: GJ87op0udA6-FoUtbuFvG5TLZM7MSmfN
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09/07/2024 04:43, Duan, Zhenzhong wrote:
> Hi Joao,
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
>> IOMMU_GET_HW_INFO failure
>>
>> mdevs aren't "physical" devices and when asking for backing IOMMU info, it
>> fails the entire provisioning of the guest. Fix that by filling caps info
>> when IOMMU_GET_HW_INFO succeeds plus discarding the error we would
>> get into
>> iommufd_backend_get_device_info().
>>
>> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Fixes: 930589520128 ("vfio/iommufd: Implement
>> HostIOMMUDeviceClass::realize() handler")
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> hw/vfio/iommufd.c | 12 +++++-------
>> 1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index c2f158e60386..a4d23f488b01 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -631,15 +631,13 @@ static bool
>> hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>
>>     hiod->agent = opaque;
>>
>> -    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>> -                                         &type, &data, sizeof(data), errp)) {
>> -        return false;
>> +    if (iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>> +                                         &type, &data, sizeof(data), NULL)) {
> 
> This will make us miss the real error. What about bypassing host IOMMU device
> creation for mdev as it's not "physical device", passing corresponding host IOMMU
> device to vIOMMU make no sense.

Yeap -- This was my second alternative.

I can add an helper for vfio_is_mdev()) and just call
iommufd_backend_get_device_info() if !vfio_is_mdev().  I am assuming you meant
to skip the initialization of HostIOMMUDeviceCaps::caps as I think that
initializing hiod still makes sense as we are still using a
TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO somewhat?

