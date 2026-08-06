Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FFCC55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrybB-0000Dx-Pu; Thu, 06 Aug 2026 09:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wryb8-0000Db-LD
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 09:57:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wryb3-0002QO-9p
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 09:57:25 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676CDFsd2555601; Thu, 6 Aug 2026 13:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=kGrAA/HaCBUh9YBunUZFeFu/lUQQiJoyKpcIJlDoLcE=; b=
 hER4dkG2T3+hUi+IZj9ur3AEds0l5s2W0cFQ2z74n07iCobQE4MRT/wxOSPCtL0b
 ZhjzCSXy1SnI0/rUwCpvZ91Pfz+eUSsF04AnFX792QydCeKOveWGPjv8amPXHr5L
 rY+0tAh8gVYhjgIEOjxr1y+G/isc+BGtYHw32+VX8K+tDBc/Hbk74N4TZh1ZLUGz
 mUHN4T1skksaI4HIz7zY5NskcWX6qIsB2VePafJJKPty8N2yljg+Nv7CA6HS6+3x
 7tggo3A0AIcKcDCXelqhh919BpJ7l1jkUQutF/yT0bKlA/5lb83gOkaMX/+FYih6
 FFcMF44DKMc3HBH7Q5ffaQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs77eww5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Aug 2026 13:57:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 676Do1tg035580; Thu, 6 Aug 2026 13:57:14 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010024.outbound.protection.outlook.com
 [52.101.193.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ftq44ak8u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 06 Aug 2026 13:57:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSPqRcbIIUTd3K2YmQdZ6cVZxHND3ghHnUU/PwroBWg5uTcs1qo94M4b1WdDq6qfGAFi+plws0iBww9lGXUMe4pbjhv/5r53AIdWqrOwsLzyzCXqi4lQIlN4yvQZQ96Ofviau5IHn1wmFxnWRzff8Qc7KAZScgqWbYINhbJVxIbDDKoAFelwMXfKB5CJun5VsrMIQn53yZ6urwyInW7PDAHzFd5ZzAPF9TwldhibD/NEjUNGI19qbpY+fBixDjK1wlh3Zk6JcbA5ORpRBJXHq8rQr8cQYuFy3CjN46KZYUwhuRM0RMA/1svlJO8jKVPN+xLkNIOV/51kL6sz9x17Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGrAA/HaCBUh9YBunUZFeFu/lUQQiJoyKpcIJlDoLcE=;
 b=DWIJ5bhYiPi60QtwQuMkRxB4YbebGsR1I62mdgZ+iDEBNJM/MfeWqJG+2y0ifBFPH0HXypncCVQCM312QpIe8UOPGzRIpwDar1gD4d+wpLD2zfA0GZiQj4guHQr+stWdWgHu+/hcGmixQzRjNBdijtvvtRyCUvTHsBn6ruHk03anopMRfsg+lIZ1xMTuvGZd7xzBopQlpYbn6FSipfcxRSJeGJzgICSbTiXZhNU5od38n2ZcZRtePMn1LPaY8rkZWx9tpo7KGP6OMbfnpBbGsXHf/EBsun9fudfjBGQFGgwwfOsOUwlq1cEg+YaQMvTh0hpGIiaeVzIZmQhJAxBcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGrAA/HaCBUh9YBunUZFeFu/lUQQiJoyKpcIJlDoLcE=;
 b=ZxDnBnRIhaVsDZvQUQd+b+3oyeP/c9zhnEqSIzahzLb028K1Ce7p0k1er9ziGfgEnRW73wxaPnSFRxfrHHFzobfopm1TXaTgYfpU/Dy5SluTOUN1wZmjf0VfnnJdYmEimn0cmO/or2fTo58QyBn/lhPXhQ2FjgUL1xKQJ6mZiJY=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 6 Aug
 2026 13:57:07 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 13:57:06 +0000
Message-ID: <50b49ea8-cfbc-4d0d-821a-4794887cfdc7@oracle.com>
Date: Thu, 6 Aug 2026 09:57:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amd_iommu: Honor DTE[IR] and DTE[IW] when DTE[Mode]
 is 0
To: Daniel Paziyski <danielpaziyski@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260718175208.118721-1-danielpaziyski@gmail.com>
 <20260718175208.118721-2-danielpaziyski@gmail.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260718175208.118721-2-danielpaziyski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0197.namprd05.prod.outlook.com
 (2603:10b6:a03:330::22) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CH0PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: b64d6151-b9c1-4dcf-1e95-08def3c299ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|5023799004|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: 5n12HoLL8oRlW0Ez6VMjE1rOEY0DEZh3w0tXsf2z4pKWzra1hqqOlVHJMOstxxwQCfWCtQ2oYAzYEj2McuVlS4DnaE4yrGScLGNi3aXw26J0AT0G27yauV0Izahp7kjXRuirA+KsFohZUPKcaJEAluAopkID5qxKiw7n/TbfS/yAk9qfZhM+uS3w4QI+bPNPZ4dE0T2t1igyFIcg/NdVCOwaxjBr0kH+WYKTb0cn6+9m1LGPzqsMRQzOvKNmtBbXC4JGuT2JFF5zTfx6KZnw8frTjDb+kQE+tKuRRI+GiQyrqezEdZc9HGmWsH381Pe1cnPe8A0XFAvaLUbOCBXKWVkHbyiTJexC5EF9qECqM0wqNxxI4HF5nQv3Q4Hwb+RINbqemdMeK3NHaeWVGi6Hvc/gtBT1UaHizoHaUgrorzRywhXqvrTquQJTf0xYOvorwbCLbvhGCmnSv1oKjcV/LFuuUjrHgcN8KzB/zPNo6BxWWYMQbGs2xWGzZ7v4VR+eZR9HYIcZlfF57a83tuUCN+nBwoPujg9R43FFcfQ/nELv/ZPIGl4UTVtmKGFkAxkEgxHQDua7J+xU+droj22QRF9mFl1xelbT7xvRlq9tlLv49lvwtDiP+EQR2zxDOikblxddqH3UevRTxiZ1aNeZezacC1Vsvlwpbi+N4eB/JDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(5023799004)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTBvcWJGYUwwVE9zRStQekx5NUlFTnNZYVNZWVc0Qkh2cjVpMUVBZFdDMVZI?=
 =?utf-8?B?THQxMzVUczdDT2ZEM0h6dW1jSURoZ1dDUDlyK2RpVWdlU2RicnpiYkVIekp5?=
 =?utf-8?B?b0QyOG9ScWtMdUZuK1dKYmJIaFlPYWRtVnYwN1NjMUtFN3ZQOEhjbWkzWFEx?=
 =?utf-8?B?V2ZldXFMSUlReGQ5V2p2SVlrSytFZWEyakg5OHdkV0ZEbHY1TVVaOFkzbUJx?=
 =?utf-8?B?dXIvSXdpNmw2NUJWTmgyWWo0QXlhR3NUZW5zY1lCNVJhdlNpNzZTZnc5RzBz?=
 =?utf-8?B?VEVJeld4ZXgzNXYwNEVWL29vcHBYcHo3QXFMSTNaOWt4dS82V0hydjdnbW43?=
 =?utf-8?B?ZHFVb21ETjV3NkI4SlEwZnBOYy9WTWROc0g1WHllQmkvdHo4ZXdTUHMweUNU?=
 =?utf-8?B?dzN3dEVETXEwNXp6WXl0cEREMEc4a3NSRWtVSkJUUlE5bmNzRlhBeDlHa2s5?=
 =?utf-8?B?anRuSHFnKzVYRHZ0eU9XUU44MUlvcVIzSnhVUURaQ0NLMzNVTVEyZ3Z1VGJW?=
 =?utf-8?B?MWNXNlZpSmYxK2FwWFNhc0ljZE1NTjVPdW8wendFVWpvbm9ybGkrQzFHQytM?=
 =?utf-8?B?QkM2YkdYcUxsVC9xcUpZRnIyczhJems1NFZwbU1SeHFrNThVRXJtTjBITnBr?=
 =?utf-8?B?TDFVOFo2MHVWVUFjVzVYQ1NwQzltV0JyODNpcUw1NFVxWHEwRlIvWE9yNWtT?=
 =?utf-8?B?cUZpc1VaU0piaGlyMUdoVDhvSGVxOUNyNGVZOVN5dVF0QmVUa0dRYzdpWWND?=
 =?utf-8?B?VURtaDZRQUR4WjhnTmJzM3NTa1JuWEc4NXhLcEpYUlVOTVVaOEt6TlluOC9S?=
 =?utf-8?B?RTBHVXAwb3l1L1pXemJlY0dodW0wVWdnQys4VEhqMU8weWlleXREajdQT2Za?=
 =?utf-8?B?cnVxcmdWZG1iay9PY2hiM3lnaWwxYjNaNFl6OURGSXBtSjNKOWdnYzBaa3lQ?=
 =?utf-8?B?U3lFMHhFTVZlVUY1a2FqRVppaE1OMHNXdjllS0hOb3BDaGZLcm1pbGlBMDNm?=
 =?utf-8?B?U2NGVnIwbUhzTm50TlZBVmZZYWp4TXIvUEZRMmd1dWJhY3NhRVdwTXRlUXV0?=
 =?utf-8?B?MHZDcGhLQllmTGQwOEQrbm1hTEs1blNkYUUyWWpGOXJHTVcwNS9CN2NFR1Nl?=
 =?utf-8?B?SmNOWTMzL0U5dW45T0JEU3B2VXlYMTB0NGJSVlhiRjFxaVlVSTJIbmUva0p2?=
 =?utf-8?B?WmE0UVcydFlQY2pJZnYrVUk3cUwrcFJ1ZkZSMHhPOE5jSDJsbDVMSnJLTC9m?=
 =?utf-8?B?YU42UlpwREhoVUJHT1lDaGpWUTBGaTlLdjRyTVBiZGRZR0lWd0J0N2RQc25v?=
 =?utf-8?B?bWd5Vjd4MlNINStwV2g5SEVDeCtxbE5KNlRaVUgzWDZpZ1Y4MjZyM1pGNWhW?=
 =?utf-8?B?RWJCTkE2YkhHSGl1Z0Y2SDE3cllWYlF5VjRMZ1ZqcmFVSkFsUDhDWVU2dGIw?=
 =?utf-8?B?emJCMWlYS3REeUZlQmlJYWRnRDZuVzRTN3FFekNWWUVWUVd5VnBwQWpJSWZk?=
 =?utf-8?B?QVFSQzlCeXdTaFRkYk9JQkpIS1hPc29tUDZaSG1rdXdLNzVvTXh2YnhTUjVr?=
 =?utf-8?B?cVlyL01rTTlSbzlNcEN4d2h0bkF4a3VtUUphanl2Skh1bGhRNkVGTXI4WUhF?=
 =?utf-8?B?UjFPV0F1ZzB0TFRPVkIvV2Q1OHY1WnQvRUVIVm9JMXZQSEp4UWZjY0o2MjdE?=
 =?utf-8?B?UkpmN3dXeWY1L1I2TnZ2MWU5MExpc1JpUTRLQTlpZlpEMXpYMThiMWNrK29v?=
 =?utf-8?B?K2I0ZzFTUG93bnd4WkNYYjR1RnE4ZnV1UGQycXhFci9qbm84eWMyOFRoZ0xr?=
 =?utf-8?B?UHU0OFpqVUx2TDJ5T2tpSTRLaUxJZGoweGdMR2VLWFBMOEdqNnJ4SW0zMDV6?=
 =?utf-8?B?K01QcnNULzlUMGJyeDBuNjNIR3RHSjJhcU44TzFrY1VlVEI5L1JDYnZ3SzU1?=
 =?utf-8?B?Nk5vNW1HNnlYYTZDYVhaY1hlaVFFOGRRRTU3Tmh2U0I5ZGc0RWdCSnA0bXRy?=
 =?utf-8?B?ak1hdmNKL3RRWm80RHJ3bTQ3dXJNUE5kQnFVbUVJUjdBTThSakw0L0ZtWGVu?=
 =?utf-8?B?VzIvTFhsdU5WeVViQjV3MDNGcTRLZjJRTmwxZGhuNFpUZU9oZWF4bVVMUDN6?=
 =?utf-8?B?TGgzNzhHQ0lWZzRHeGl5L1dMbGZ6NnYrV2M4V1J3ZnZPSE41STVhWE5WNHFI?=
 =?utf-8?B?TUVZdDZ0WmRNM1Q2ek1PemNGWFZhemJJTlZIUCtURktIbHZBY1AwTXl2N0RT?=
 =?utf-8?B?L3pBTnFZQTcrV2FDeDRUak9zc0F2bFdNM1hTbllxMDBpbnVTZjFvTUNnZk9Q?=
 =?utf-8?B?Y3RiaWJuRkUySTcyd0hnM2dJZDR6Rmg2SjVUcXNWdXhGTlhLQ1ZsZTROMnBj?=
 =?utf-8?Q?Jn5cUVrj9kjgsgwY=3D?=
X-Exchange-RoutingPolicyChecked: XrHfoAqwUe2/faDXoZvvbVBuy/m9xGFIweXsJZ+nP609FnY4+hbKGWEVaIsw/XKmON/H5vYf4jAvNb/yPmLGQjwnGIy1mWvSDObg5ADapwIvtWndZj1GzKGccXd9+Ocf3nZHtK/AGASXcUKZI51IPjvOsZI/CZ/IjLlFJTtYgsasvdH9oEk8YdVfS1pdzSYjPHskzo205ARpXDEi8jvk5XHaZVLKGXsI2iOwsjEXbs4KoDX+3mgpIq72mHmPtDXl4jRijFZkpIkCQCEmVj7or4WGlsxIO5qiRMV1xfm0V7/RnEfC2Z79Mfu/ZdNP3fFm5/u3h0Kw9lN1X7KRDtuHDg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GoJWKpumMaP8ke4BLJ4nEWWq9jYgrciNCJLMBnMb4kNE5mt7rbM7Wg7XaQoPUZgkjx4/khOvzRsXXXd/6sNx4t2pFUSAxm2KpI1TsXVFSAsQcfxel0PcIAPD0K7t+LEvXwhYfBK9v+3x0R5s5yfGd47jfgXyiaSNYxREH8uUn5GlWJoa/fb3zOmSO1avlADLMcP5Af29BbnyS/Kc89da22X5cq7KRwzZ/bFclhiNY4+l2zTc1BsYEXOd83DehrZzRmmhOw3Rukn7GnVAc+NPZVi46dG4Xae4Tuer8HGNcLCw3H+PshF5IGvzr364sn9TOJFpMUBCeuNy0ZMgJO4r8l8kgeX+vheImRTxokLwxcW0jtz8sOiZYSBolbxsC7Im+ziV8+JTwnpDrgqKVw9WruDT3V9K+hpH6lHRQvEgfLcedKebBZ1RXneTxiYKRVmwq1SIK2l3xuCGd1pjcBdPGat7Ecjttihk7wQwVCh7wsw95fsWFiiSdPk8aQXv+CFSrvoOBTExU1wnUtYZd5Uxzg43Qn26udMB7MBXw4bgIcE8SRNSQyfLiERVHGC3KpSWFF0TeMs2xSd+yAmTTh/+vCHxcjGWXWOcQ6CylPBzgxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64d6151-b9c1-4dcf-1e95-08def3c299ec
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 13:57:06.8491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOFCyeQkXzqHAIOUDvxxNAaTq6hmb/qf6k1xshfQ2X7izOXsETZyHJ5MQO4FQfTN3YT2cJeBJa1c5KaBqA3ATRw668Jwq3j2cdE+RTe0Ars=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608060109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwOSBTYWx0ZWRfX85mdnZs6kuI2
 Am4nfQl/iK9LiiUztX0g4tTFimjfXWkx0Ctw5zrnJZRUqMrrOYxPVBglaAcnd+8T0kq2U8SWT2u
 TDJwwdj0nPvLnKrBF6L/pkR34WOu15o94zQDStSUWjakrY1qRLNu4CkoXe4L+JDomD5iEDLAWRN
 cGFDe0uU32eELT4cloyO2BB6fiBs2HZvFb32HGr6iKRHXIeUPDReXpj3zAx6vVzdyV4pBDCcHOH
 wYX+oErfmsxjjoIQUOWiuFO0h+ehLVggDmko0FUCuQgrfqeebijenpl3HozTkwr/GVLbuzRRFbF
 BvYdfKdFfTCErK2h9FoGkTiHFD701ruy6XK/bMNys7j9o8Y9Tpm76+oVFUNGuDmGiwuko+O7Y8u
 BWUL5yZR1F+2KIN2ka9IxCkAYC0jUzU492FLKOF3ECJZiPUfpQOwnq4uq2YrPSzakCvfJb2KmgO
 /kHEHIOTW2jzXCbDsaA==
X-Proofpoint-GUID: eydF5kTYxo2pHW8-riNIkAoB4mEmW5ut
X-Authority-Analysis: v=2.4 cv=OqZ/DS/t c=1 sm=1 tr=0 ts=6a7492bb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=pGLkceISAAAA:8
 a=ZsqXBkfCEwYLr8K_zgwA:9 a=FR9RYl3Lr4_X7j6C:21 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eydF5kTYxo2pHW8-riNIkAoB4mEmW5ut
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwOSBTYWx0ZWRfX8nahZVhZTgCN
 6bf4AyZ/kSD42L3g8FFwmNNdkblrv7wi7BaltpPxMsDp+CxcieSIKpzHG+WzGn1bpQkOOu80ARs
 W2xeux5LNw11HotVk0HKPXeqUj+aN3W636KJqrzHNYT1GZVPwjRA
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel,

On 7/18/26 1:52 PM, Daniel Paziyski wrote:

> In an AMD IOMMU's Device Table Entry (DTE), the Mode field specifies the number
> of levels that the page table hierarchy for translating Guest Physical Addresses
> (GPAs) to System Physical Addresses (SPAs) will have. When the DTE is valid and
> translation is active (V = 1, TV = 1), and Mode is equal to 0, then the IOMMU
> will act as a "filter": GPAs are the same as SPAs, but, whether reads or writes
> are allowed depends on the values of I/O read permission (IR) and I/O write
> permission (IW) in the DTE.
> 
> In the current code, the values of IR and IW are considered only when traversing
> the page tables for translating GPAs to SPAs when Mode is not 0 (and are ANDed
> with their counterparts in the page tables to determine the final permission),
> and when the DTE for a device is in passthrough mode (Mode is 0), IR and IW
> are not taken into consideration, and access is given unconditionally, which
> conflicts with the specification.
> 
> This patch implements honoring of the IR and IW DTE bits when Mode is 0. To do
> so, both the iommu and iommu_nodma memory regions in the AMDVIAddressSpace
> struct are preserved, and a new field is added, passthrough_perms, which along
> with addr_translation will determine whether the iommu or the iommu_nodma memory
> region will be used.
> 
> After a DTE invalidation, passthrough_perms and addr_translation will be set
> accordingly with the new DTE configuration, and when it's time to switch address
> spaces in amdvi_switch_address_space:
> 
>     - Iff passthrough is desired and IR = 1 and IW = 1, use the iommu_nodma
>       memory region,
> 
>     - otherwise, use the iommu memory region.
> 
> The handler for translation (amdvi_translate), which is called when the iommu
> memory region is enabled, has a fastpath which handles passthrough mode and
> verifies permissions. Additionally, since the DTE is fetched in the page walker,
> and it is possible for it to have been updated concurrently, if passthrough mode
> is requested, it is handled properly. Moreover, care has been taken to not fill
> the IOTLB with entries handed out when passthrough is active.
> 

Thank you for the patches and the detailed description in the commit
message. While the problem you are describing is valid, I think the
solution in this series only addresses it partially. If my understanding is
correct, your proposed Mode=0 handling covers a scenario like the following:

- an earlier INVALIDATE_DEVTAB_ENTRY read DTE[Mode]>0 and set
addr_translation = true
- guest changes DTE in RAM to Mode=0
- The corresponding DTE invalidation has not yet been received/processed by
QEMU, so addr_translation still reflects the older DTE with Mode>0
- a DMA request misses the IOTLB and triggers a page walk
- amdvi_do_translate() reads the new Mode=0 DTE, which conflicts with the
older DTE state cached in addr_translation = true

I think the reverse scenario can also happen where a previous
addr_translation = false can select the passthrough code path while the
guest memory already has a DTE[Mode]>0.

There are other issues that the patch doesn't address e.g. for a VFIO
device, the replay() callback does not handle Mode=0. It calls
amdvi_sync_shadow_page_table_range()->fetch_pte() which rejects Mode=0, so
no MAP notifications would be generated in case of DTEs with RO or WO
permissions.

The larger problem is not with your patch, but that the current code has
different emulation paths making decisions based on different versions of
the DTE. e.g. the current code makes it possible to have addr_translation
(and passthrough_perms) derived from an "older" DTE state be inconsistent
with a newly retrieved DTE data from guest memory. Your change is fixing a
special case, but unfortunately I think we need a larger rework so that it
can be applied without introducing additional issues.

Based on my reading of the AMDVi documentation, the OS must issue
INVALIDATE_DEVTAB_ENTRY after modifying a DTE before it can rely on any the
updated field(s) being used. A guest can change the Device Table in its
RAM, but the synchronization point where the change starts affecting
behavior in the HW (or emulated HW in this case) is after the next
INVALIDATE_DEVTAB_ENTRY command.

The approach I am considering is to cache the relevant DTE state (i.e. only
the address translation related state) for each address space, and update
it when processing INVALIDATE_DEVTAB_ENTRY or a global invalidation
(INVALIDATE_IOMMU_ALL). THis way we avoid reading the DTE from guest memory
at various paths, and instead use the cached version, so the emulation code
makes decisions based on a consistent state.

This new DTE cache and the existing IOTLB cache should remain separate i.e.
INVALIDATE_DEVTAB_ENTRY would update the DTE state but shouldn't call
iommu_inval_iotlb(), based on my reading of Section 2.4.2
INVALIDATE_DEVTAB_ENTRY from the spec.

I think what I describe above should be a prerequisite for your patch to
then implement consistent handling of IR/IW permissions with Mode=0. It is
a much larger change, so I am still working through it, but you are welcome
to contribute now that I have hopefully explained the idea :).

Thank you,
Alejandro


> Also, for the sake of easier debugging, the trace_amdvi_page_fault tracepoint
> now also takes the BDF of the device which has caused the page fault.
> 
> Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
> ---
>  hw/i386/amd_iommu.c  | 136 +++++++++++++++++++++++++++++--------------
>  hw/i386/trace-events |   2 +-
>  2 files changed, 92 insertions(+), 46 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 90252c52af..10d75a5088 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -54,6 +54,8 @@ struct AMDVIAddressSpace {
>      IOVATree *iova_tree;
>      /* DMA address translation active */
>      bool addr_translation;
> +    /* Permissions for direct map when DMA address translation is not active */
> +    unsigned passthrough_perms;
>  };
>  
>  /* AMDVI cache entry */
> @@ -1162,34 +1164,16 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
>  {
>      AMDVIState *s = amdvi_as->iommu_state;
>  
> -    if (s->dma_remap && amdvi_as->addr_translation) {
> -        /* Enabling DMA region */
> -        memory_region_set_enabled(&amdvi_as->iommu_nodma, false);
> -        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), true);
> -    } else {
> -        /* Disabling DMA region, using passthrough */
> -        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), false);
> -        memory_region_set_enabled(&amdvi_as->iommu_nodma, true);
> +    if (!(s->dma_remap && amdvi_as->addr_translation)) {
> +        if (amdvi_as->passthrough_perms == (AMDVI_PERM_READ | AMDVI_PERM_WRITE)) {
> +            memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), false);
> +            memory_region_set_enabled(&amdvi_as->iommu_nodma, true);
> +            return;
> +        }
>      }
> -}
> -
> -/*
> - * For all existing address spaces managed by the IOMMU, enable/disable the
> - * corresponding memory regions to reset the address translation mode and
> - * use passthrough by default.
> - */
> -static void amdvi_reset_address_translation_all(AMDVIState *s)
> -{
> -    AMDVIAddressSpace *iommu_as;
> -    GHashTableIter as_it;
> -
> -    g_hash_table_iter_init(&as_it, s->address_spaces);
>  
> -    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
> -        /* Use passthrough as default mode after reset */
> -        iommu_as->addr_translation = false;
> -        amdvi_switch_address_space(iommu_as);
> -    }
> +    memory_region_set_enabled(&amdvi_as->iommu_nodma, false);
> +    memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), true);
>  }
>  
>  static void enable_dma_mode(AMDVIAddressSpace *as, bool inval_current)
> @@ -1222,23 +1206,43 @@ static void enable_dma_mode(AMDVIAddressSpace *as, bool inval_current)
>   * - invalidate all existing mappings
>   * - switch to no_dma memory region
>   */
> -static void enable_nodma_mode(AMDVIAddressSpace *as)
> +static void enable_nodma_mode(AMDVIAddressSpace *as, unsigned perms)
>  {
>      IOMMUNotifier *n;
>  
> -    if (!as->addr_translation) {
> +    if (!as->addr_translation && as->passthrough_perms == perms) {
>          /* passthrough is already active, nothing to do */
>          return;
>      }
>  
> -    as->addr_translation = false;
>      IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
>          /* Drop all mappings for the address space */
>          amdvi_address_space_unmap(as, n);
>      }
> +
> +    as->addr_translation = false;
> +    as->passthrough_perms = perms;
>      amdvi_switch_address_space(as);
>  }
>  
> +/*
> + * For all existing address spaces managed by the IOMMU, enable/disable the
> + * corresponding memory regions to reset the address translation mode and
> + * use passthrough by default.
> + */
> +static void amdvi_reset_address_translation_all(AMDVIState *s)
> +{
> +    AMDVIAddressSpace *iommu_as;
> +    GHashTableIter as_it;
> +
> +    g_hash_table_iter_init(&as_it, s->address_spaces);
> +
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
> +        /* Use passthrough as default mode after reset */
> +        enable_nodma_mode(iommu_as, AMDVI_PERM_READ | AMDVI_PERM_WRITE);
> +    }
> +}
> +
>  /*
>   * A guest driver must issue the INVALIDATE_DEVTAB_ENTRY command to the IOMMU
>   * after changing a Device Table entry. We can use this fact to detect when a
> @@ -1252,6 +1256,7 @@ static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
>      AMDVIAddressSpace *as;
>      uint64_t dte[4] = { 0 };
>      int ret;
> +    unsigned perms;
>  
>      as = amdvi_get_as_by_devid(s, devid);
>      if (!as) {
> @@ -1268,14 +1273,16 @@ static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
>      case 0:
>          /* DTE was successfully retrieved */
>          if (!dte_mode) {
> -            enable_nodma_mode(as); /* DTE[V]=1 && DTE[Mode]=0 => passthrough */
> +            /* DTE[V]=1 && DTE[Mode]=0 => passthrough */
> +            perms = amdvi_get_perms(dte[0]);
> +            enable_nodma_mode(as, perms);
>          } else {
>              enable_dma_mode(as, false); /* Enable DMA translation */
>          }
>          break;
>      case -AMDVI_FR_DTE_V:
>          /* DTE[V]=0, address is passed untranslated */
> -        enable_nodma_mode(as);
> +        enable_nodma_mode(as, AMDVI_PERM_READ | AMDVI_PERM_WRITE);
>          break;
>      case -AMDVI_FR_DTE_RTR_ERR:
>      case -AMDVI_FR_DTE_TV:
> @@ -1889,15 +1896,45 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>      }
>  }
>  
> +static void amdvi_fill_iotlb_entry_passthrough(IOMMUTLBEntry *entry,
> +                                               AMDVIAddressSpace *as,
> +                                               unsigned passthrough_perms,
> +                                               hwaddr addr,
> +                                               IOMMUAccessFlags flag)
> +{
> +    unsigned perms = 0;
> +
> +    if (flag & IOMMU_RO) {
> +        perms |= AMDVI_PERM_READ;
> +    }
> +    if (flag & IOMMU_WO) {
> +        perms |= AMDVI_PERM_WRITE;
> +    }
> +
> +    if ((passthrough_perms & perms) != perms) {
> +        amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
> +        trace_amdvi_page_fault(addr, pci_bus_num(as->bus), PCI_SLOT(as->devfn),
> +                               PCI_FUNC(as->devfn), perms);
> +        return;
> +    }
> +
> +    entry->iova = addr & AMDVI_PAGE_MASK_4K;
> +    entry->translated_addr = addr & AMDVI_PAGE_MASK_4K;
> +    entry->addr_mask = ~AMDVI_PAGE_MASK_4K;
> +    entry->perm = flag & IOMMU_RW;
> +}
> +
>  static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>                              IOMMUTLBEntry *ret, unsigned perms,
> -                            hwaddr addr)
> +                            hwaddr addr, bool *update_iotlb)
>  {
>      hwaddr page_mask, pagesize = 0;
>      uint8_t mode;
>      uint64_t pte;
>      int fetch_ret;
>  
> +    *update_iotlb = false;
> +
>      /* make sure the DTE has TV = 1 */
>      if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
>          /*
> @@ -1916,7 +1953,9 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>          return;
>      }
>      if (mode == 0) {
> -        goto no_remap;
> +        amdvi_fill_iotlb_entry_passthrough(ret, as, amdvi_get_perms(dte[0]),
> +            addr, perms == AMDVI_PERM_WRITE ? IOMMU_WO : IOMMU_RO);
> +        return;
>      }
>  
>      /* Attempt to fetch the PTE to determine if a valid mapping exists */
> @@ -1931,7 +1970,8 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>          perms != (perms & amdvi_get_perms(pte))) {
>  
>          amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
> -        trace_amdvi_page_fault(addr);
> +        trace_amdvi_page_fault(addr, pci_bus_num(as->bus), PCI_SLOT(as->devfn),
> +                               PCI_FUNC(as->devfn), perms);
>          return;
>      }
>  
> @@ -1944,13 +1984,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>      ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
>      ret->addr_mask = ~page_mask;
>      ret->perm = amdvi_get_perms(pte);
> -    return;
> -
> -no_remap:
> -    ret->iova = addr & AMDVI_PAGE_MASK_4K;
> -    ret->translated_addr = addr & AMDVI_PAGE_MASK_4K;
> -    ret->addr_mask = ~AMDVI_PAGE_MASK_4K;
> -    ret->perm = amdvi_get_perms(dte[0]);
> +    *update_iotlb = true;
>  }
>  
>  static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
> @@ -1961,6 +1995,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>      AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
>      uint64_t entry[4];
>      int dte_ret;
> +    bool update_iotlb;
>  
>      if (iotlb_entry) {
>          trace_amdvi_iotlb_hit(PCI_BUS_NUM(devid), PCI_SLOT(devid),
> @@ -1983,10 +2018,14 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>      }
>  
>      amdvi_page_walk(as, entry, ret,
> -                    is_write ? AMDVI_PERM_WRITE : AMDVI_PERM_READ, addr);
> +                    is_write ? AMDVI_PERM_WRITE : AMDVI_PERM_READ, addr,
> +                    &update_iotlb);
> +
> +    if (update_iotlb) {
> +        amdvi_update_iotlb(s, devid, addr, *ret,
> +                           entry[1] & AMDVI_DEV_DOMID_ID_MASK);
> +    }
>  
> -    amdvi_update_iotlb(s, devid, addr, *ret,
> -                       entry[1] & AMDVI_DEV_DOMID_ID_MASK);
>      return;
>  
>  out:
> @@ -2031,7 +2070,13 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>          return ret;
>      }
>  
> -    amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
> +    if (!as->addr_translation) {
> +        amdvi_fill_iotlb_entry_passthrough(&ret, as, as->passthrough_perms,
> +                                           addr, flag);
> +    } else {
> +        amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
> +    }
> +
>      trace_amdvi_translation_result(pci_bus_num(as->bus), PCI_SLOT(as->devfn),
>              PCI_FUNC(as->devfn), addr, ret.translated_addr);
>      return ret;
> @@ -2423,6 +2468,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>          amdvi_dev_as->notifier_flags = IOMMU_NOTIFIER_NONE;
>          amdvi_dev_as->iova_tree = iova_tree_new();
>          amdvi_dev_as->addr_translation = false;
> +        amdvi_dev_as->passthrough_perms = AMDVI_PERM_READ | AMDVI_PERM_WRITE;
>          key->bus = bus;
>          key->devfn = devfn;
>  
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index a1a50d0910..df2d046000 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -103,7 +103,7 @@ amdvi_dte_get_fail(uint64_t addr, uint32_t offset) "error: failed to access Devi
>  amdvi_invalid_dte(uint64_t addr) "PTE entry at 0x%"PRIx64" is invalid "
>  amdvi_get_pte_hwerror(uint64_t addr) "hardware error eccessing PTE at addr 0x%"PRIx64
>  amdvi_mode_invalid(uint8_t level, uint64_t addr)"error: translation level 0x%"PRIx8" translating addr 0x%"PRIx64
> -amdvi_page_fault(uint64_t addr) "error: page fault accessing guest physical address 0x%"PRIx64
> +amdvi_page_fault(uint64_t addr, uint8_t bus, uint8_t slot, uint8_t func, unsigned perms) "error: page fault accessing guest physical address 0x%"PRIx64" by devid %02x:%02x.%x with perms 0x%x"
>  amdvi_iotlb_hit(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, uint64_t txaddr) "hit iotlb devid %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
>  amdvi_translation_result(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, uint64_t txaddr) "devid: %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
>  amdvi_mem_ir_write_req(uint64_t addr, uint64_t val, uint32_t size) "addr 0x%"PRIx64" data 0x%"PRIx64" size 0x%"PRIx32
> -- 
> 2.55.0
> 


