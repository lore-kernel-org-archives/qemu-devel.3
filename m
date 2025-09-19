Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7ECCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYLq-00079U-4K; Fri, 19 Sep 2025 06:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1uzYLn-000791-Q8
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:28:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1uzYLe-0007lL-1F
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:28:23 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J7gEx8032022;
 Fri, 19 Sep 2025 10:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=4rG58Gp3cCSNVUetyLKq6StHzMA8WGVushzhysntCvk=; b=
 LOLNMzzTee61a8+fmq9Er5iFfiRxG1ygq0nQIgWOd2B5W1DyZwoWBvWjSUblCit/
 sgDknvd8zyq2CIkiN0WtjzIdmKzSOWU7x+j7IKmOB8KO4AvlxVFuAar8N3a4cb3n
 2y72ruidMunvhPUdL142Yscg8HHQgpefNqr0LINh5uxjfsPxUiKNI7l0/PLcKZeT
 h15/YOWn09GGOfhl52wWUhMx0mBkP15pTxuJYpbICK45uNainvp25UWCx0ubi1x1
 J3D7LdtCsBIQs8yraT8NdLbZxT4wyiLTbsQeTmmkvXQTSn7goESBhsUgq/85D2VE
 IhpAECBKkCdbnQBpJqvYPQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd58vf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 10:28:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58J91x0X001703; Fri, 19 Sep 2025 10:28:02 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gh78e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 10:28:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXgwgdNYoznsbKElU+C2phG1S9wKD406nw0O1C8ZVjqHucwPqR066Y7CUwnZFTkOVbBbKGsEl7d6GIY7HFP1spIniRM5rXeik8D9QxgY2bmI2bcCTyUsJVTqnhSybkV2q84ZmRlO8RoWxtAe7JSbAb/+XJsxaHHft4aIs0o+a/VSFIb0xJI/Icyc33KcgpKeEboCtr/KWXpJ+9/L13G6sW0DclY42PzWARcxCCeFFi9oH77ClMDeIALaoZVweTy72Zgl672aF/X6xsx8MEeDayaCeBYZO5gVvJxj5tMKVJxDMqcaT6g+kTk7h+tUZsq7M6yyLauekYoeNE41a1MoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rG58Gp3cCSNVUetyLKq6StHzMA8WGVushzhysntCvk=;
 b=GDtKSnTFDpYVSSQ48N3LpDJPlmODBsorjmqeFCAXc66b/0CWR7coi1+Jk1o+QTmX0bc6tabiiDqtNsYTmcvIPthLSwC7lyBkUH2RD3vK2d0UMb7bEH6qfZc9ewBpQfV9ocB4wjJu65TxXTpANkAkfiGdZOpIbuYWWVMa3OlkyyA3yib84wGvUpEtyI5SwRI8Osfwus1W8JTwKNf3gwCn/jwsNbfLHSCJdSkttmsoI/KHSVWKD+mUAZfpNQadriQMrOUKFyQ4Ec5K8jR4FXHv5bbM/rzEMZPMIR5L2+tNghm65ZN2p76m3DILtNpWFk3HefFtfXAoGTAQdjhuLmpXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rG58Gp3cCSNVUetyLKq6StHzMA8WGVushzhysntCvk=;
 b=ymSk1AzsHnpq6PZz3AwgPWET0GOb3TjOWjqjvrpWcBiFHpDpK88eb21IMVBemomQJokF67bH0YO3sLmqJq3aUqp8ZWLRwEj1ZSkjCSdxNUyeiH0281VDbtfWL/I4g+pkaxO9vO8gp3tFkdvVSm7Yy6xxEpm3DRC161RTAvlut3M=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by PH7PR10MB6282.namprd10.prod.outlook.com
 (2603:10b6:510:1a8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 10:27:58 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61%3]) with mapi id 15.20.9115.018; Fri, 19 Sep 2025
 10:27:58 +0000
Message-ID: <d167b62a-be06-4bb1-b88e-e1cc96d7c4a4@oracle.com>
Date: Fri, 19 Sep 2025 11:27:54 +0100
Subject: Re: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, eric.auger@redhat.com,
 avihaih@nvidia.com, xudong.hao@intel.com, giovanni.cabiddu@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250910023701.244356-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0095.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::6) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|PH7PR10MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d30aa8-a932-4ad3-7172-08ddf7673422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGJzdjFjN1lZS1Q4cHJHTjJ2T0g4N2lzOFpBZ1dMR1diQWxNTllSVm1Nanha?=
 =?utf-8?B?ZC9CcjBNLzZDaWtxZ3p2TjNuTXpUaFJqdTNMVmtJbisyTHVBWE1zUUcyNmNm?=
 =?utf-8?B?ZXpXbHRxUjFkbzFPZWFNc1BhRm9qWG11OHBLeUdxV2FDc0JvU2FxeGIxM00w?=
 =?utf-8?B?ZzYramhVdkdmTXpVT2JEMm04cXQ5ZWZwc2pjMVJWZERaVVNiNERkMHBTZHNk?=
 =?utf-8?B?UDBZUkNSZmt6ZjZ5MEVyMmxVSzlPYkZydVBWUmVENnA4ZnZheTNZd2hDU2d3?=
 =?utf-8?B?V3crczNteVhkRjViWDRxeG1hVUgrUHNvRVZOdlAyRURBeVFqUlVVamhSSnNQ?=
 =?utf-8?B?L0p6RlRvNHNhTGFSMHp5UTJCVDc5TVZ5QWI2WFRIYUJaaFlma05lU0NFZEJs?=
 =?utf-8?B?SE1OMzRNQjRzN0hvWmZCbE5tNERlbG1sVUVRM25rdC9sc3BtQm93dFhVb0Zk?=
 =?utf-8?B?QStuaDJ5L1dGM0xycERrU0ZhZGJOZ0ZoalRnMTFReTR4UjVqSHVDemwvb21j?=
 =?utf-8?B?blFVazhRaXp1Qk1MQi9tZUxMRUltNVd6MnJSeEVkVkp5NW84RXBueXNoMHZY?=
 =?utf-8?B?anlpZExOUUQza3pCYk1WKzhxMElWbkFkS3YzeVJuZVhCbmJheEtEOVZJZVVx?=
 =?utf-8?B?SFYycytuaXJjNTNSL0d2YWRzalM2eXk3L1d3RXZDRXcxMjVtMHBRRFhMTDZv?=
 =?utf-8?B?R2FHVTgyTkx2S3RmSlo5M2x0UnFBSUN0MkJKK2xNczMvRkpyS09LU3JSQlFJ?=
 =?utf-8?B?ZWFyL09Vb28veWc3UngwYkZZYlJHQUpEaGptZUxpbXhsMVJoRkhKZHdPM3Zr?=
 =?utf-8?B?OE96SXB2WTNYQ2t3cm1idG56VTlTRFZyeFBlVmxRdEdTaTkvWmhia0VndkYr?=
 =?utf-8?B?V0FZZkxSWG9IZWt4NHZ4cDh6Z2l6aTlKdjhCcS9lTVlCWUZWMWtVekFjRDBJ?=
 =?utf-8?B?SUw0YnNrMDNVVTUzL280OWRmTEw4R0ZWZFI1bWUyQmJPc2NGUXNXeVluMHJ2?=
 =?utf-8?B?ejRId0QvUFY2b2ZFMGZXRHhBMzlRWkY5Y0VrZ3Zjc21oclU0azNVNlROaGRN?=
 =?utf-8?B?blJqeXRPWlI4bVZtMDRoNEswUEJrWnpMeXpNWGV4Z3NnTDErRGQxQ3Z3UEd5?=
 =?utf-8?B?OEhLRzJKTDRWdnlPQ0hhakNrTmhkSEZ5dzRMbEkzNFpFMnllNGtnMlVRS3Js?=
 =?utf-8?B?czJhekpmM1pvdjZ3bmdodGRwdUNaSXRsR1c1UjNvOFB2UFFtODQvWGVTVk9p?=
 =?utf-8?B?REUrOW84QnpsSHIvRDZTaTlZZ2ZBZWc5S3VBUktaUkhZN1RlVllPdXR2N3RV?=
 =?utf-8?B?bVY5WXZOV2ErV1ZiV3VSTnRIdDZvRzJQcEJleHF6cTU3dXVnZkpqRWVmaGlM?=
 =?utf-8?B?SXpWMTk2eXRRaE9XRUo5S3RibzJ6Q0xiMUZDRC9ZVXNvdXI2ZnJ1a0MrK1Er?=
 =?utf-8?B?U3hCcmpNNGFMRnpHZnF0R2pMZEUrZnNhcm14K0ZqaHdPSERDa1BmWG56Y3Vh?=
 =?utf-8?B?amVBaVI0SGVTVXJiV0pCUnRwOWo2S3crdVVqV2p3K2puWDVGMVp5RlFvMzRp?=
 =?utf-8?B?N0FNaDhkK3lqVERqQ1dqMnl2bUNDOW9oeS9BQk80QTBBMHJzb21wWE5CVlFk?=
 =?utf-8?B?dDZDeW1hVFdGWmFuR1Jla0d2TEZQTlZSVk9Ya2lkTWZMNUlpc0FWaWQxR1or?=
 =?utf-8?B?MUc1OU4ycS9WMEU5LzNTVUplVmloeWppTlgzVnJJY1ZDR0Voei9NbUlHZW5y?=
 =?utf-8?B?RUJ5RG1tRnhuaTUza1RSbTFoMW8vQnEzVGVNQ1JOY0V1cGR5alVHTzRFdmFU?=
 =?utf-8?B?azJFZ3k0UGI2ZFNxWVFzY0t4MTJtYk1tSVdKTHdLRG5wYWlUaTc0ZU5ZZFE2?=
 =?utf-8?B?NklVU2xsSDRFOE5HQzdZU3BRUmc0M1FTR2VlNS8yTTBOQXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXplM1h0MHRsdng2NWFMQWhmNklKN3piTDBidGVCZUh1OEw5LzA2MWgyb2Fm?=
 =?utf-8?B?eGJqWVBGSmZ0TlNoaE91eU1LUkgzRXZ4d1VjWWhmNnZDMmxLa2xwZUx1NkQy?=
 =?utf-8?B?NnN0TFFmSlk0c2YwRFYvVWdKZmpxMTJOYlpGdytzU3E3TUtVL2NOZWxONml5?=
 =?utf-8?B?cnViUzgwYW1sMmwvMWdId0FIZ3YzZENCZnpMMk9aUW5Fd1dXdWtUTi9FbUZz?=
 =?utf-8?B?L0xpYitPd25MQk51WUwxcEJ2a3UxR3Z5UkZkc1d3NEFyUVRGZUNhOTVYZWUy?=
 =?utf-8?B?QzNsRDAwSkw0M0thNGtjYjk2eXNEYmxQRkQ4Tk9WbkNkZjA5WjRmOWlyRFFS?=
 =?utf-8?B?QTFFTjZSN09yVEtGM09tRzFUQW4wVld3Mjk2dTV3RU9SM01nZDVsNzNSQTVY?=
 =?utf-8?B?M2FqVGg2TU5vVitUOWJMZmJUYkJ6MndvZWY1OFBLcnNjczI1TnVjVFZ2dEpn?=
 =?utf-8?B?SytBb3JtOGl1a2ViNlBBSXpvOC96WXdBMC80Wk9OV0M4V1ZyUnpUNUFQL3BX?=
 =?utf-8?B?SHJlSmhTcG9tNGhYQksrQjU3cjFSTy9jMVpKLzhtMU9KN3Z4OUU5OVRvMGpm?=
 =?utf-8?B?L3BuMkZSc2tMRTdiakRPTzFtZTFteWw0bFNMTXFLUjhQZWhPYUd1RFFYeGtO?=
 =?utf-8?B?WTJ3NUprQS85bWE0T1dqQnV0VnFTcGdtU3M4NTIvZDZIVjlQWnRNajVkNUZy?=
 =?utf-8?B?K0l1aXAyaGt2cEVwNHNyY284V0pHcVFrS2NSREs3MEdnOGx6elpoTi9jV1h4?=
 =?utf-8?B?Q3VTNk1FYXdWSXJKeFdNNE4wcVNScjB3cHdPWVdjWUkzK2tETys5V1MyQXRM?=
 =?utf-8?B?N2R2UVNua1VsRFZneE9tcVRIdC9IeFBJNE5FUTNNVUVRK2JTWUhJVXhBaDRJ?=
 =?utf-8?B?WGQrSm5FVmcybFRiVkFJVEtXRG84Z0RMTXZjQjhPSkFvYjNwYXFmakRCdFdq?=
 =?utf-8?B?UXlZWi9TYm1LNGdzSWdRdTcxalVzQXJVbnhrbTFHSmtOd3M1TGtMSEhQRDVF?=
 =?utf-8?B?QUdzdWpIemdSMkZpcE5XQ0JDQ1dPU3k1anc4YTJ1OWVVQmZ1ZXdZQ2c1eW5N?=
 =?utf-8?B?cTROeVpCL0hWblNvVW1NdmdyQTNvSW5JdS9hb2VGazdMK2ljalViNFN2ZnFw?=
 =?utf-8?B?OWhnNGJQR0p2aUY3eXFXNUEwaXB4OW5XNzFYSDQ3amE4bFdYRWZpZWJLZ1Jk?=
 =?utf-8?B?aWVjdmpvTXkzQWlHTThSNXVFcUNjdUtVdmRkcnJtcEtwdkVkZ205TlpRUHFi?=
 =?utf-8?B?SWorVm02eXpucUk0ME1mY3ExZUJrSklRb3J3UjVlV1M0Q3NZMXNVZk9IZ0s1?=
 =?utf-8?B?dDQ0Ty82ZDFCMFBHSExaa3dlN2pkbGJ3dEJmM0VaQjdYSHp0ZnBXZnR5dVVq?=
 =?utf-8?B?VDA1Y3h0Rjg4cjIxUjZqMVViRFVCOVBJdzJXS1h6VVEraERDZzVveFRONkFQ?=
 =?utf-8?B?MGsraUNmV3FvZGdrNThiZWR0cTY1UktiNjY4ZXhIZzdYcGk2ODJoWk9wYjll?=
 =?utf-8?B?bFVYMU5qUDJrT0dkd3pJa1kxL3NseG5Vc2dYaEdnTTQ5WVpwQU5GeUpZdXd5?=
 =?utf-8?B?SmNlWVZmRm1KM3RwZjduZ1ZUY0JPMjdaNXpsTnc1SC9xRDZ5Mm43YnA1WTZC?=
 =?utf-8?B?UHgxQ2F2VjlRV0E5VjQwM3g5RStWR1JYVlh1Zmh0bk5NUXB4bmhyTzBKVXdk?=
 =?utf-8?B?RnArZkw5cGRPV3ZPQytlTm03ZktJRWh4YUFsNXkrUU9Mb0V2VWtnTk8yOSth?=
 =?utf-8?B?aHYrTEp2SENSZ3c3MkFKSjBXN3NRSTVPa3lZaUNidjVYazA4eFNuNElQSnhr?=
 =?utf-8?B?M0RaNG9jSldoQVlBRGtxOEhpY2pCdWIySFNHSTdqbjBXU1Q4ZGszc2lmanFy?=
 =?utf-8?B?aC8zVU8rWkwva1lnZ3lHemVJZXdQcnQvTlp4WXNVeXgrbkliV2Q5b2g1Mnhh?=
 =?utf-8?B?bFBNZVNxTlpQK1RnK3c0YVFqaU0vaHNkYVF2dDZZWG1WcFFWb3NpWTFFUk1D?=
 =?utf-8?B?R2FGekoyMktiWHJKbWZOaGRVYjF2TXB4ejZjTU9TZUlTcnYyYmRlM25ZbTZw?=
 =?utf-8?B?RzFiaGd2VHgxRDJFWkNCMVBxYThkMDh4VjRFVHVlNmhua0pnRkRSR3F2UmVG?=
 =?utf-8?B?elNmTDVWcmwrTTFEVDc0b2Jtay8wbW5aUWQ1T3hQY1p3aWYzcS9oSXhRb01R?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 22urHnBVg+KwNtyJBqhiX3q9MA9103WE4uX8Q3ARzhmMtqbOAj8/s192llTu8v+BaPE/nP1dvXPZVgyvTVulWY9ptHRDbNfkwbtlQqhb0sfz8CKd1vJ/aPANTxJ4MX7XLAsU5q0m5c5SB27muuYsFK0TelYpbAONtzDqGOSWjeQsfechCa3Sr4bB62Bxm82s/F/GfT2Tt6bWo8vkleSPKSNG19Gsbo2Dykex90Lo2bVLuFNuhMQBJg/0h4EUcQuakWZMyqE2yiemAVj4P6yWm0M17WWYsL5Y0hmZndIAO6GmOWjGqhAXyWd5+WIE+x+TT4DqVciTckqv2Y4BQdW1Gbo4iNdueibLb+KZSdjl+mdWkFjpt1GMtgHo861QH9EWGWMbQ8vEzh5ZTJru1qhC2HjY7fyVrkjrOt7HYr+CpdoH8XZabp+qFJcIXNO120kZyHoRenHzbPVTdLBlgRP8g9NApSg2qlUUCeENY31UBpp+Di1KHHTMmuNVDckFsXeFqdEANJ8QU3vWVHQPTBdfWI7voa+OJXKHIZDt97gmmrYakoyNs9UfGr2fiLwEzWLDiFT8CyLLzrEVS8LQ4jLT3Dcg2MtJpndtNpcW9Ooujx8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d30aa8-a932-4ad3-7172-08ddf7673422
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 10:27:58.7755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNvG3jP9iMzemmRSCWl1wY3P2xuyVEuCD6t4Ctevvr6hTyt73as3oZ5Y4pARZQOsHLr7aUtPcnrZ1gX6Agc5zFtZc39abYQfKj68efnaScw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6282
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509190095
X-Proofpoint-GUID: dEmNIcRO_H-jSlEPnOMXLCyfIipzHM3B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX2x2srBBabXMc
 3sXN1b4IyME6WmLK8Wanz1CCVpMnhbAp97+TA0NHyJ+fWlDH8R6U92xD59ZhztaDXCfv/w3vJaf
 MB+0W7upnPQs5BFnCK8u4XVJ8xXSMkzmvcsrkYSf8TowkpPE+P17qWHDKKDI5kw2C78toFY7cLK
 N6qzQx/RvtvSeo+6xXXRNViOrQ21YFSp2g0g7HU207Ddm7ZoLUsnC+lW+CJ2P+Noz/ff3cSkokb
 j49iX/zHH3lMN2kzRnMt9+RRvwpZTUumN9zGRD5kCR66BKZnkOAqfqTf0udYZBF3zSejYgXoXdM
 EDUlbkMa0GiSAvjhRW9FwsuoCO076Nodduxd5jnoGaC2/KzCa2LwdPAkE7ghpKQsNYyVVdhcA/W
 l0syhPbH
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cd3033 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=7lEsaQG4Lz_2_lzAoHQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dEmNIcRO_H-jSlEPnOMXLCyfIipzHM3B
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/09/2025 03:36, Zhenzhong Duan wrote:
> Pass IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR when doing the last dirty
> bitmap query right before unmap, no PTEs flushes. This accelerates the
> query without issue because unmap will tear down the mapping anyway.
> 
> Add a new element dirty_tracking_flags in VFIOIOMMUFDContainer to
> be used for the flags of iommufd dirty tracking. Currently it is
> set to either IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR or 0 based on
> the scenario.
> 
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  hw/vfio/vfio-iommufd.h   | 1 +
>  include/system/iommufd.h | 2 +-
>  backends/iommufd.c       | 5 +++--
>  hw/vfio/iommufd.c        | 6 +++++-
>  backends/trace-events    | 2 +-
>  5 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
> index 07ea0f4304..e0af241c75 100644
> --- a/hw/vfio/vfio-iommufd.h
> +++ b/hw/vfio/vfio-iommufd.h
> @@ -26,6 +26,7 @@ typedef struct VFIOIOMMUFDContainer {
>      VFIOContainerBase bcontainer;
>      IOMMUFDBackend *be;
>      uint32_t ioas_id;
> +    uint64_t dirty_tracking_flags;
>      QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>  } VFIOIOMMUFDContainer;
>  
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index c9c72ffc45..63898e7b0d 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -64,7 +64,7 @@ bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>  bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                        uint64_t iova, ram_addr_t size,
>                                        uint64_t page_size, uint64_t *data,
> -                                      Error **errp);
> +                                      uint64_t flags, Error **errp);
>  bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>                                        uint32_t data_type, uint32_t entry_len,
>                                        uint32_t *entry_num, void *data,
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 2a33c7ab0b..3c4f6157e2 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -361,7 +361,7 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>                                        uint32_t hwpt_id,
>                                        uint64_t iova, ram_addr_t size,
>                                        uint64_t page_size, uint64_t *data,
> -                                      Error **errp)
> +                                      uint64_t flags, Error **errp)
>  {
>      int ret;
>      struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
> @@ -371,11 +371,12 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>          .length = size,
>          .page_size = page_size,
>          .data = (uintptr_t)data,
> +        .flags = flags,
>      };
>  
>      ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
>      trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
> -                                           page_size, ret ? errno : 0);
> +                                           flags, page_size, ret ? errno : 0);
>      if (ret) {
>          error_setg_errno(errp, errno,
>                           "IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"HWADDR_PRIx
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 0057488ce9..c897aa6b17 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -62,7 +62,7 @@ static int iommufd_cdev_unmap_one(const VFIOContainerBase *bcontainer,
>                                    hwaddr iova, ram_addr_t size,
>                                    IOMMUTLBEntry *iotlb)
>  {
> -    const VFIOIOMMUFDContainer *container =
> +    VFIOIOMMUFDContainer *container =
>          container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>      bool need_dirty_sync = false;
>      Error *local_err = NULL;
> @@ -73,9 +73,12 @@ static int iommufd_cdev_unmap_one(const VFIOContainerBase *bcontainer,
>      if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>          if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>              bcontainer->dirty_pages_supported) {
> +            container->dirty_tracking_flags =
> +                                      IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR;
>              ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
>                                                      iotlb->translated_addr,
>                                                      &local_err);
> +            container->dirty_tracking_flags = 0;

Why not changing vfio_container_query_dirty_bitmap to pass a flags too, like the
original patches? This is a little unnecssary odd style to pass a flag via
container structure rather and then clearing.

Part of the reason the original series had a VFIO_GET_DIRTY_NO_FLUSH for generic
container abstraction was to not mix IOMMUFD UAPI specifics into base container
API. Then in getting a VFIO_GET_DIRTY_NO_FLUSH, then type1 backend could just
ignore the flag, while IOMMUFD translates it to IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR

>              if (ret) {
>                  error_report_err(local_err);
>              }
> @@ -248,6 +251,7 @@ static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>          if (!iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
>                                                iova, size, page_size,
>                                                (uint64_t *)vbmap->bitmap,
> +                                              container->dirty_tracking_flags,
>                                                errp)) {
>              return -EINVAL;
>          }
> diff --git a/backends/trace-events b/backends/trace-events
> index 56132d3fd2..e1992ba12f 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -19,5 +19,5 @@ iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>  iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>  iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
> -iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
> +iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
>  iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"


