Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB209C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWASA-0003OU-Sp; Tue, 23 Jul 2024 04:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWAS8-0003Nm-Qn
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:00:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWAS3-0004CM-Va
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:00:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N6BWmi001354;
 Tue, 23 Jul 2024 08:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=Vl9aNsZ2IuMHRhKh9mbtnfs8yjiyzk6FfzO1AXiM2tE=; b=
 HVeYCQzO+Ry1+5wpCL1aqzWQJ5B9qHjHi0xpmZRIewxsq94g1EUFhkHN0HxPJKV7
 HEXZU9JxVQN0oEBOh21njAP4dZKtBq8+3dbC+o+G+mDFhBLRqVeFcnQdsEdpxMk5
 LBDOAfpBwMiu1LuoZTU3KZjD6O+zA6OW7WKR/64dEwlxXiBUyE+HhSUlf4vEA6f3
 mpsIDjP2V7q6NvEwUwpiEX0oISkQz4+UOFcdZZ1NwVdohTqotQUrr96Vvaav/Y6f
 nkrCaisz+GJcxQXbBxHyncAC+KfUOZyQnvYAuTZsYwDvcAqfsfcMQF8MzyFmiqk8
 3Nu39jSIulmXIatzc7dbMg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0djtg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:00:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46N7XlX7033611; Tue, 23 Jul 2024 08:00:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40h2692deu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeVw3EJ9CXlN5yMOtArQTrrpFsFf4jc4LGCQ3zexg61x8pNRp2NuRb1TbLm3/fXNPj6qMv/rB/oDcG2DlOrfsHfjIUkQO3DSKQXsKxp06UssUF36sAWEKAhwri8ffYuEE2VkGcAAiOvVHVMiSn/TymzqxgT1+8lQMFtKXzntIzBos4M99rL3qoYQPdJNB/JkFLKZCVqyweq17OqSrvBKVxHueZIut4wq5ka9BBPR86DYjYZQU8L4YY5+xPo/l1ghyzhW49jE07mJLnvJdqLFCcqq4+fXuTAe/9XPWRapPH+fdsGP6+T1RvB1fBRPyrVCiUBL/VoF/bj6p2aQHl6VBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl9aNsZ2IuMHRhKh9mbtnfs8yjiyzk6FfzO1AXiM2tE=;
 b=Ghea6Mfx661BWNone1t9bdqezKDp08xjegE+D9BflwMUpNJdFtEcE2ZramULMIbGxz8wzW5RS1LkQuZz3xYX2j7ur9jC6ouvp2KsuntWHf94a97Agu8Ngo7MZ08axh5qaPEyy5v6/XAisHDsbNNjGymp4VOOiZOaHUZbfSP20Z9w1w8u1s1GnfaXA7UiD/d2cc9Ouwku8chRd3y21ryIcdsklrjCLR5k7suykBpcaxUHCdojzNdoHNcsB9wb+Z+2nTLnVl3Cz2Ap4sav4l87PmXLogjoJDhD38NW7bfKK6SS3RyKOB/RyK1cWdmGeHXGE8CyDYLM0MBZVJHDXF1yPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl9aNsZ2IuMHRhKh9mbtnfs8yjiyzk6FfzO1AXiM2tE=;
 b=yu9uRbFz2cGJ/sWxZa05qbFdi5aIhWsbl+Xl1cm6gfUKck/adP5VLC4KV8mExOlTJ+9UCLyu8b9roCcjbvqe3GyNfPuIkZy9+XnQnkRN/SrW5+Angr3LisuunPYFTJpvCoD0bX9i5PxMXB/7bt403h0vQTB5sOLNYLuLwQVQU5s=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 08:00:44 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 23 Jul 2024
 08:00:44 +0000
Message-ID: <832a6eab-1f63-411c-a827-018b12264513@oracle.com>
Date: Tue, 23 Jul 2024 09:00:30 +0100
Subject: Re: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-6-joao.m.martins@oracle.com>
 <2fd72e9b-c3b1-488c-a532-546ddf3612e0@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <2fd72e9b-c3b1-488c-a532-546ddf3612e0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bda07c-109e-4a09-6df2-08dcaaed8dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QURVb2ZvMmlCRXRKUEM2U0dybzh4Zmpwc0J1YmRpcXpjdmJIS2V0eFlEVUxn?=
 =?utf-8?B?VjZ2ZWZ4MnRXU045S3hUZlYrSmc5czZpSmtkdUlWVE5hcUZZaTlxM2hobHlQ?=
 =?utf-8?B?MG1GaUE3NTlhbEhIM0JZd0VqeW5iYUhSb2N6dHZKSkx4ejdrQS9JZzR6UVIv?=
 =?utf-8?B?dE1SQmtvclVzOGxseGhOUjYxUUxuZnR2MjVKWjFRNHdUTStGenFIaVlXYk5W?=
 =?utf-8?B?cUFxU0xxZHB5SU1hQ2RwOU9zTVNIWXgxQ2VWZ2FFYlNpTC9PdHZPN0NhcGp3?=
 =?utf-8?B?UUdLRk5KMnN0QWR6K1NSMmduZ1FqaGtRNGhKWVpjbXo3UUthTVgxYkc4SXVt?=
 =?utf-8?B?M0VxbGgwQXpGbVN6dmF1ZUZrbUlOejQxZXJXQTBRWGpHbmFrZXVaVURQTWdm?=
 =?utf-8?B?WVB2cStWTnYzOWd6VCtkQ1ZQWXNScUFCcUlyM3NFYlNLb2lnZ1N0VW5QTzgv?=
 =?utf-8?B?SVVIVEZwTkFQa0l1aWFXZzBFcEtFL1VLQVdpY3RLaFJzMzl4Tk5RTytSMFZn?=
 =?utf-8?B?Q3N3MFFXNmtFamF5OWU2ci9FVHdaY2tLdEt3MlFHRkhqUHlnQ25uREU5dG92?=
 =?utf-8?B?UTlHZkkxODBTSHFhMlh2d1phODh6K1FMWnBYNVNKdis2cCswdEIvZG5ab3Jv?=
 =?utf-8?B?NndudFd2SmtycjFTb3FpbE5wRjFUbnF6YThmTVBYL0lkRjVnK0J6K2JwNTYr?=
 =?utf-8?B?SVcwRSsxdmxRVnRWQ0hFc3BzUHFBUjV6TnlNTllUYnBXcFBSRU5FNkdYWUFv?=
 =?utf-8?B?cVJCdjhIci9EdmhraW16T01mUEVNclFOQzdHU2NsaERJU2c4aDF2UEYrY3Mx?=
 =?utf-8?B?SnBaOXkzQ2ZUWWc0aVE0N3V5cXNQdXVPRThrMU5zdFpuMkpwTU92ekt1b1pG?=
 =?utf-8?B?d3hTR215OHNGZzd6K0VrK3RjQ3FRNUwvclYwVFEzdnRRRVc0NnRwYS9oYXl3?=
 =?utf-8?B?RmlVMWdHbnRocHBtenlteERBbXFHM04yblJNcDRwNzhKQ2tIWWc5cjBBSnJu?=
 =?utf-8?B?aTYrNTJnb2dzRk9jYTh6bHJnNHVyZkZtcUwxN2lkTmRvQldLQUQ1MVo4Rk9K?=
 =?utf-8?B?TS9EVnEzL0JtSkcxL3hCVlpSTVQ5RFZ2b2d4cVJ3d1htT3lXNG5kZGJMNFdF?=
 =?utf-8?B?ZGZ0eVlIZ1ZmQWo0bW9FVWltTEl6Sk5nbGJjTzBtdlp4V1IzODNNaDA4d0t6?=
 =?utf-8?B?Sm5kUXZrazQxaGxsWVFvWUNhY1d3cVNkRGczbVBGYm9zbGJvVFJXSzdDL1Zy?=
 =?utf-8?B?MDhGdnh1U2licVdSREhhcGI4eU53aDkwakJvMWZ0WVVYa3Y0U0tvYTYxL2tF?=
 =?utf-8?B?Y3pNVWh4VTZTcVZGWE1paExscWtDSlJYQXVmaUFMMEdqeVdYS01hSGgyNHhm?=
 =?utf-8?B?RmFHNjQvWW85Vk8xWVVZWVg2RHlobGJQVXU2R1JKY0l2aEdLc2MzU1A5ODNS?=
 =?utf-8?B?QXVJZmIrdzhQZ3VjNStlNXRvSzFMRUphWjVzOG40RG4xK1dGaGtReklDZ0ll?=
 =?utf-8?B?SmZUOHFzWVBJeHlNd3E5UW5hdyttRzhDV0tFOVlVbVFQMDlrb0dLVWdDd1J3?=
 =?utf-8?B?UTBkbVc1a1lxaHQrSFdScHUxTlBadW5qbnJaQ0pESHhaNUNjcEZUTCtoczNZ?=
 =?utf-8?B?ZGRKTEVhWkRYdXBrczJ4b2tLNTZOVDRWdEJSZHJHTTR0VHNPenNWSnpobCt4?=
 =?utf-8?B?QnBKTlN2TE42Mlp3c2ZubzRVVEVtMTFIemt2djFkT3JuRDh4M3hvc2RVeUFz?=
 =?utf-8?B?MHllTDdlSjdUNjFtNUV3NzlnUXNOZHFjM2YrZERDejFrOCtJSkhaREV4L3J5?=
 =?utf-8?B?NWZJMnlCb2R0Rk5xckxjdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1hPdkFjaGRjUzdxZFk4M1lNdFJsTGM2S2FjYXRUSlNOT0hvWTJmRkQ4Z214?=
 =?utf-8?B?ZXJzaVlkaE5zZGo4RE54cnUrcXBIVU5XY1lSL2VxWGJvRldwOHI4QTBlVlk2?=
 =?utf-8?B?UVdFdW9YM1Yxc29iakxSaWVnM2tmTlJ4SG9mSUhlblVNRnZjSzdDUjNsbDZ3?=
 =?utf-8?B?SU1IR2NRWHZNbDRIWlBGdnplZ1NjNXhOZDhWMURxbzkzSFNEMjBOOUY4dEls?=
 =?utf-8?B?R0g3STRiVTB4N3o5WDRmQTFXUGdtOE1nRXlnL0REKzFlbzA2Nkx4ZFNqK1kw?=
 =?utf-8?B?cE9RZTBLRVZzUE9VUVUwUWtBR2w5aXhPb0g5WXBUYldoblBNNTJERzdYSTBS?=
 =?utf-8?B?RFpmZ2R4OWljZ2RUckFsUWZ2dUpreTBOMnhNemgvWU5BS1dSR2x6UVVMMlFp?=
 =?utf-8?B?akh6dENMK0N6ZXE4cUdYOS9uTGxnZlByKzB0bGpnaE9kMS90TmQ5Y2FQQWtj?=
 =?utf-8?B?UkpBUmhiaisrbWxDMEFpcXdTaksrNnJMZWJjUlgzV3QyQzNhWWtBV09Vdjc5?=
 =?utf-8?B?V3BMcGpsUGlPWCswR09rdmovdjZNa0JsT1ZTWWxocE9IWnhCbDRVc3ZrQi9M?=
 =?utf-8?B?SStPUUJxYjk5cDkwU09xZURsZnJlQXlLZzZRVGcxdTRReURxTW1Oczl2WGNO?=
 =?utf-8?B?ZmtPYVhaQ210Z05pWUVZSWRUK21GNXExT05hK01QYnM4MjY3aDdWSmpIM3lR?=
 =?utf-8?B?ZWR2Vjl4TjFYMG83b1lHRXNXVmVNVTI0WnFxSnpxanNCM2hNTURsVVcycThI?=
 =?utf-8?B?OFRoUWZzRzNCajBocTRlVUhqYzFtWEgzOGc4Ry8yVWhRM2ZiZ0xLN0FhVUdx?=
 =?utf-8?B?NFVVUWo1eGkrZGNRMFZlUlpmeGxmMlB0d1dQQldrSmtzT3pNcEYzNlplTlFU?=
 =?utf-8?B?d3hRYTZlY2ZtbVhjNkh1d0FvMGRXV2g2a0dnaU56Zi9hRGR3a1FZRDN1a1RG?=
 =?utf-8?B?ak01cHEyUWtnT2IvTGtpM3hMQ0gxOGl3ang0Y1lDdnI1WHFmSUM0TCsvNG5l?=
 =?utf-8?B?YncvUEFEa0pHZWcyVS9USmY4ZVJVZER3Q2RBdE5uL3RQV3JpY2s5UUFtV1dB?=
 =?utf-8?B?eVVjWGpuUGNXdUVvN2dKMmVmN3RGWDBRT2FZVTd2ZVVjUG9PRUlxRitlSnVV?=
 =?utf-8?B?ai9UTVhqTDhubzVLaW1GVlF5R28yS2V1azZBN0Rad3hEVnd3RGIxVVh3UVJI?=
 =?utf-8?B?RUJUVFMwY2FrYlVZWTA4MDkwUThCbCt4NHVMcFk3M3FyYkNHWTROTFVHbi9O?=
 =?utf-8?B?cnkvb3RGYVVKRWxEMHBTN3NaazV1dzdRQ2Z2TUYrSFBMWFBJaHZub1Y5TFhD?=
 =?utf-8?B?RVY1UmNBMjE1bDlLZy9HcDBQeGJtRk50TlNoM2grU29jUnEvUFhyYkFsZ0ZS?=
 =?utf-8?B?R2dYK0NyL2taTkZIWEI4dFNRNjF1a0g5UjZpMDV1WW5zMmllek5YdGtZSUNJ?=
 =?utf-8?B?bldxRTNBWTV5dG02ZFpJUUJHL0JvWGh5bnM4UUhMTDNxUXFkR1c4ajEzWnJQ?=
 =?utf-8?B?OHJDV252U1J3cjRDWk54aGxNN2twRGNYc0RZSFdHdldIdE1jZVRSWTkyTTIw?=
 =?utf-8?B?L213TjV3K003WlYxMnhPZDNJTzcvZy9vc0FIQ1J0SDl0YUwzd0x2VXYyMXJv?=
 =?utf-8?B?ZnhRcHhYZnE2VWt2MEJLUndkQ3pCTjB3eDQvYnE5S2JCMTBrcXJTa2dqNTdj?=
 =?utf-8?B?d0lldzUwYTZLTEY3c2RHMkNQRGN6VGxsVytONUFtZnFiT2ZacStFUithcHVH?=
 =?utf-8?B?VlM0eVYweUZuY0tPNDZ5ZXM1UHBsTmZENUVpeHF6TWUyTGRKL1FwS3hLREl3?=
 =?utf-8?B?RkM0WlBGRVVQU1R4ekxETHlZZmxpTUZiYWt5NEM1MVRMK2FSclJVcUVyUy9U?=
 =?utf-8?B?Z2Z1aG9WaHlBcmN3bmZuL3BkZ3BmaGtudHBZNHpadzlMeHFlQUdFWk1UWXE4?=
 =?utf-8?B?QVY1YW5DK2c3STRUWjljTmdPMVZldytueWwrbFRndndoQkdUT2VVRDZJbnFl?=
 =?utf-8?B?VEJISGRwWExOTmlVdER6Y1FDVGtvQ3RtQTdmLzVvVFBycXBmdk9hRiszaDZH?=
 =?utf-8?B?T0diZ3NhZkdod2dTcnNwd2VjNW5hL3dPNzI5OXlESE52NmcwMnBFTHEzQ3I2?=
 =?utf-8?B?NXBzT0Rma3VKMUZzdlVTYm81ekYyL2FYMEU1Sld0M01IL3BEaGMzZlJidlor?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kJBzCiF6rKG48k+DEtCdLkKDGXT4xk5yNyuXesy5wjRS0XufTqek6uEOfqI9bPGeQO2DN+UnzgJm31qEEJx0p01KBLZN3NsTiXNKRkEmh1+iHHMFJ4A5oCgtPZZNVSrjCHefxLMar1BAeeXOWH0olB5tu5WiafaO5felqcTzHiZ52NVz0nfFTDLI7m0h4CG2jlmBb3BxdWJVWD04uYTd6l0sYSXyL9Uj04Y5zqscey4JBzU9Cr/l7eVsNO6aqOWxC7jdD1z3qwvYrxTXSE4AsDG8RtJroq29iwfew/v/WoKDLT/v207Fz2obEoRTOimCxCsJKcBuPfhB1r+O+2PVIAbWgSui+YxrPng48WR0DmbdfMM0IwtYRoMbru/DCIGhQieAgr9SIstUPO9M66WoJp5RL+CpYaTTUEF8JiMxIZHEDMQFWv/sHZbASB5zQVOjB9GAKl+S+wt862uqpI/0ZcI8tXW2TsYqh9b89mcJOavG23LUGfGquEVFMv09oWqbyOaakTQ7yYzYHVBy/oSFCeH8qbseEHE3znlrzjYzgcJseaJxuLR3spFsxhAPtLbOLvrKYllTvr831nPwU/dy9VXXBmv5mrW5siW9gX5aeLg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bda07c-109e-4a09-6df2-08dcaaed8dc2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 08:00:44.5641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4H820LYIDQKh1/1MLetMvBTzmkW0e5M28VZ3lAftGq9i09EfoOD/52KCAoNJ6ppY9SZVSOAGXyXU+hrgW6SPBlK4kcE9+ae8w22A9vnE4p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230058
X-Proofpoint-GUID: sAXM-jgAjVCEFfqz8mN43_vC2pAL7nNl
X-Proofpoint-ORIG-GUID: sAXM-jgAjVCEFfqz8mN43_vC2pAL7nNl
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/07/2024 08:50, Eric Auger wrote:
> Hi Joao,
> 
> On 7/22/24 23:13, Joao Martins wrote:
>> In preparation to using the dirty tracking UAPI, probe whether the IOMMU
>> supports dirty tracking. This is done via the data stored in
>> hiod::caps::hw_caps initialized from GET_HW_INFO.
>>
>> Qemu doesn't know if VF dirty tracking is supported when allocating
>> hardware pagetable in iommufd_cdev_autodomains_get(). This is because
>> VFIODevice migration state hasn't been initialized *yet* hence it can't pick
>> between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
>> dirty tracking it always creates HWPTs with IOMMU_HWPT_ALLOC_DIRTY_TRACKING
>> even if later on VFIOMigration decides to use VF dirty tracking instead.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  include/hw/vfio/vfio-common.h |  2 ++
>>  hw/vfio/iommufd.c             | 20 ++++++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 4e44b26d3c45..1e02c98b09ba 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>>  
>>  typedef struct VFIOIOASHwpt {
>>      uint32_t hwpt_id;
>> +    uint32_t hwpt_flags;
>>      QLIST_HEAD(, VFIODevice) device_list;
>>      QLIST_ENTRY(VFIOIOASHwpt) next;
>>  } VFIOIOASHwpt;
>> @@ -139,6 +140,7 @@ typedef struct VFIODevice {
>>      OnOffAuto pre_copy_dirty_page_tracking;
>>      bool dirty_pages_supported;
>>      bool dirty_tracking;
>> +    bool iommu_dirty_tracking;
>>      HostIOMMUDevice *hiod;
>>      int devid;
>>      IOMMUFDBackend *iommufd;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 2324bf892c56..7afea0b041ed 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -110,6 +110,11 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>>      iommufd_backend_disconnect(vbasedev->iommufd);
>>  }
>>  
>> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>> +{
>> +    return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +}
>> +
>>  static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>  {
>>      ERRP_GUARD();
>> @@ -246,6 +251,17 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>          }
>>      }
>>  
>> +    /*
>> +     * This is quite early and VFIO Migration state isn't yet fully
>> +     * initialized, thus rely only on IOMMU hardware capabilities as to
>> +     * whether IOMMU dirty tracking is going to be requested. Later
>> +     * vfio_migration_realize() may decide to use VF dirty tracking
>> +     * instead.
>> +     */
>> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +    }
>> +
>>      if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>                                      container->ioas_id, flags,
>>                                      IOMMU_HWPT_DATA_NONE, 0, NULL,
>> @@ -255,6 +271,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>  
>>      hwpt = g_malloc0(sizeof(*hwpt));
>>      hwpt->hwpt_id = hwpt_id;
>> +    hwpt->hwpt_flags = flags;
>>      QLIST_INIT(&hwpt->device_list);
>>  
>>      ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>> @@ -265,8 +282,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>      }
>>  
>>      vbasedev->hwpt = hwpt;
>> +    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>>      QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>      QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> +    container->bcontainer.dirty_pages_supported |=
>> +                                vbasedev->iommu_dirty_tracking;
> Is it possible to have several devices with different
> 
> iommu_dirty_tracking value in the same container? In other words would they be attached to different container/ioas?
> 

In theory, yes, they can be in the same container/ioas. But I guess with IOMMUFD
it's possible that we can allocate different containers for different devices
given that we can manipulate/pass a different IOMMUFD object.

In pratice I don't know if such HW platforms even exist where different IOMMU
instances present different value of dirty tracking, given that this is a IOMMU
feature, rather than endpoint dependent. In x86 it's homogeneous, and likely on
smmuv3 server too. There are indeed endpoint related features which may be
different in IOMMU instances, but those only reflect on logic that the device
needs to implement (e.g. PCIe PRS).

Having said that I can only think of mdevs, where the realize() will block
migration because the vbasedev->iommu_dirty_tracking is 0 should the mdev not
support dma-logging vfio (but it doesn't go via this codepath above anyhow).

