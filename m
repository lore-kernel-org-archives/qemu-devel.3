Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88872C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 09:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR6ly-0004yw-Mb; Tue, 09 Jul 2024 05:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6lx-0004yM-Cn
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:04:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6ls-0007Vn-Te
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:04:29 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tXgR009580;
 Tue, 9 Jul 2024 09:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=QVQEcwPyJyC+uvpplw786tCS1yqKXOs1UvEmG2VqxUU=; b=
 VJIvyUPs3GfteeNNpKfo25ynK5HlKYoMpYMMhincFhqF3fO89KsNEYrm/aAhTzl8
 Z55YMKVWKxL1EbsVxR44kBjCQTASXN4EOe1CR1waRcpMHfAzhPuwK+ZemAapwyEj
 xIj3OFjiMHsDtXljKUcGSaoI7ViTDrw3kFc2eqRB+f6TU7CCPvF8O1Us9vLNtgky
 KNsdWyPRxWzbN8BXjIBxCr1UuN93BUxAtY5Q8x90/zbj0w93w3e1Z95FK8AoNUTK
 4bywAMmaTXxiNm6HqR86LxiJjOlh+hYYz3sG7yfvXjwGhq+KmWyrGJGMqwjHwhwR
 pMswAsvi6zgKuTx2oJ76Cg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknmg0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 09:04:21 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4698Xh1l014196; Tue, 9 Jul 2024 09:04:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407txgncwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 09:04:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAG1fqMbNwI2z7/wO+6NG9iauSrjr8VbIWs5Wk4SLZKc2Sr+E51cDqz/mm9fCgaWhQntwykJD+kjBWZsQl56R46kpqUaLRS2g9/fMVDCXcUaFzhcYdyniSv3LGhggzdRtgESJJFdF8adGuY+0i82SYd3DGObWu27kWF08jX9XVcROXuspI0p1b4i+hTQb9U0/wTwQygc4VUwMHXkE0+BLvIYUFcWDLXJu5HnhqEvIVKBbS8aqb3kmuHaYxkdKvQXnm7gGyJbvZMD6iGSP17MTsamO5C8gPc3BVYDX6y5Mn61Ymssjqe84dr0/AN8VXVj5uDn4UXBbpyCJc3vd6jdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVQEcwPyJyC+uvpplw786tCS1yqKXOs1UvEmG2VqxUU=;
 b=A6wkIXD2rujY8y0TTPvE1hraVAYp9T3BcMgMAtqXC92Mb7ZrDNlVEkeBEHX0QJFmiQjOX7CA/+dya5iR5rT1CV/rENCPGwBVuFQdp8GKfztjwd5kbx4R1B3zxUjhCrskw0Fp9m69305EX0n4iee4l4I8fkxmLIVpaTxZdXIHUvmwafP8FvuJ90fsG2QrHQlHdkog+OBgXHMdESKKfcKounHseK/eCDzBgMIbZpNvX+uUv2eOv/+s6X7Sh9sjCDcRjxsPIbrZjhdnrpK7EwHK1PqoUuZXU9+nrDsICV98waE0zDUCGbRl7iR+FmrmDU62FUwf+DpJVD5WQPOQAC3lEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVQEcwPyJyC+uvpplw786tCS1yqKXOs1UvEmG2VqxUU=;
 b=LaDp4ntt90sBz3wf8cSsBSucfQSbup7bvg6K6yjMSGbD1m5fX9Qx6KYm432uEMMbI7s60UWVGUFXWe7Wptg4II/UuONcqnIRWdqzO8O64B5H1+SQqPujK4PtgswQmpuJUx4duwIAKmr1zKzRNOz8Pfhumi0PwQkGvhak6K+Li8s=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB5891.namprd10.prod.outlook.com (2603:10b6:a03:425::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 09:04:18 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 09:04:18 +0000
Message-ID: <ce8515ae-2fd6-417e-9f2c-43bfb8b605c9@oracle.com>
Date: Tue, 9 Jul 2024 10:04:11 +0100
Subject: Re: [PATCH v3 05/10] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-6-joao.m.martins@oracle.com>
 <a3f22b3b-e3bc-4dd6-b6fb-cfb726addfbe@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <a3f22b3b-e3bc-4dd6-b6fb-cfb726addfbe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0135.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f8::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 148ebc4c-b9ee-4013-7b19-08dc9ff61d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vm9obllGdFRKS1ZKaFowSGtQTlY1c09QNDcvVytUV2EzY2x4bDZoTFpnZFN3?=
 =?utf-8?B?NDBaNTh5bzRBdmhTMmxsaUtOOThFRTBEOGpkSDBvekNycDF5T0dsZnVKRDkr?=
 =?utf-8?B?MitPRXBMb2lRMUdwUzhhWjQxeTRPcUo2eU1iMjVPUnpwQnZ1cDNwNDBCOTBU?=
 =?utf-8?B?b3hmRGlCK01NWm40UE5YdXlyNzNxVVpTRklqaWtyKzZuVTRCd2lXc0JrT0pP?=
 =?utf-8?B?WDl3MnVqRkhXZnlKdytUdytiMzhZenFNcTRtNU1qSlNOMzVpanhOK1pBQloz?=
 =?utf-8?B?YlVJSUh6OXBkYnB4aGlVT0M0cFNucVAycytjaDlNMjhFMHlyazcyNEh3MTBs?=
 =?utf-8?B?cmVPQW1oYzI1VmZGN3cvcldOUDFjYlR6YlM0NEtKbDd1Ui9adWxPMkF2M3lu?=
 =?utf-8?B?aVNZWDhhT1hZbnBGYkhuVmRKTTJFdmIrTlIyb2JPNEdwNDcxbXNWQmdjVTBk?=
 =?utf-8?B?TkhuY2txL25aeEVHcUN0SzErR0JQejlTaml6MVYwYjZyUEJTRDJRU0hpblBU?=
 =?utf-8?B?SFpiRHJHZTdLQkxGSDNGZlBPbE42MitMbG1GTk12SlVxaHZPSTR6aFM3WjR2?=
 =?utf-8?B?VzRFNDBXZ2xUNm1CSEhaWTBJaEhDNmZJRWJ1VjFRemY1TUxpeVpGaUJSSDR5?=
 =?utf-8?B?MDlaVFh1ekdwN0hGY1BtQ0hxNUgrU3JoOWNEZjdTcGxwTjlVcDZVblB3cU0w?=
 =?utf-8?B?QkUzcHVmVVFQS1VXNjRZbkhjaC9XbmZLa2w0cnN2VjUvNXFRdEpob2dnY1Fq?=
 =?utf-8?B?ZHRHQVFJZ1RGeFpFeGxuZzZhUkRPd3g1NFpuM3JyWDVYRHpEWjh1bDhQSzd4?=
 =?utf-8?B?TjZaVVJmSmFsSDhIbm5yaXZhS0pYRGtCRFpSTk1GK1ZjTG5jRGEvWUFwLzdK?=
 =?utf-8?B?OFNvSU1LSUFGdGtDU2pOaWIzYjllbWRwR1V6SXNnQWhIcnBvS28wZWhQVjJp?=
 =?utf-8?B?NHc2UVY4NkN4OGQwdGxPc0cvVWQ3UWpOWXJtWi9YNVMzd1pycUVhNy9jZWFx?=
 =?utf-8?B?WndmYTRCUkNCQzNmTFA0ZFRlRlFlcTZFOWFzajRHa3JWR2lsZ2c3TmhURVds?=
 =?utf-8?B?QXJEMWMwSldjdUI5UjRkbTJrTmNzVnNCK3lBTkNTNEsvMFF0L3VjZzVtaGVM?=
 =?utf-8?B?QVNEbnBoc3VhRThNTklKeFE5RUJZOHhNdlBQMkM5aENFVmhZekFmOURaU2Zw?=
 =?utf-8?B?MUNxeVBiYzJtaUs0Tm1qUGtGckZvWnRkYTc5ZkluUmJIZ0hFbDNXVFpYNzhz?=
 =?utf-8?B?N1pkT3BMMmEwaldmU2JEWlJUTGh0dW1HSktNTldST0wyYlVHZ3k3TmhaQmlW?=
 =?utf-8?B?T0lmWElabVJjN25vSW5GVDlPTWd3NitvWVRqUTRFOSt1b1BEUUc0VTNrUU1U?=
 =?utf-8?B?TG9KNGVTQnRPamxHQ25qdlJtMFdxczNtSWs3VG5oYmJna3ZLUW0vZW5QNThu?=
 =?utf-8?B?YklHT0VnQkZ0T0lOQXlteVRTRWwrNGU3TTA3d0MxTllsLzYrSDA1eU10dVRo?=
 =?utf-8?B?cmJCVHVLc0ovU3dWcEliaVFYbXdYak0xOVY4MGNnb0U2cHZxQmJ0bFFHSFFo?=
 =?utf-8?B?VjdIUlQ0ZzFIK3NmQWFkWEFKeWJlUFR6b1VUUjVPdVlLcTF6eGczMFNhakRF?=
 =?utf-8?B?a3R2dVRkWUFULzFvR2k4WlZxaGxaWjllNGhDMkd6bTVSeHdXdzY3STE3TWdC?=
 =?utf-8?B?YmVpTEtTelR1eldpMElVS2o5ZERpYU5UVnA1MFJ1YkZ6Y3NJdkN4M0tSV1Rn?=
 =?utf-8?B?TzNMa3JjWlhia1RrLzQ3ajlTTGhiN0VYR3JWZU1VSmhqZmZGUE5mNGNtMjFp?=
 =?utf-8?B?VXhzN3BxOWpEQkpzbjROdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUNPczc3bm92VUsxZmdvWXF0MCt6MlVsZ0w2WlhGbExxdEdDaHM1NWhMWmQw?=
 =?utf-8?B?Z2NqZVpxbzFBZ1k0enFYaW53bVkwQXY1aGFXT2xQL3kwVVNRb3JUOGFVTXRi?=
 =?utf-8?B?QnB4RkxhQzEyV3NoTktnTmRuQ1UvbTdwK1hhdjBiYzc3OG5FS1NGOGY5YUU5?=
 =?utf-8?B?Sko0T0VFenpLRFU0cFhieEJickNNdWM0L2Y4UmhmczVaOEV6bllUTnJMeTBu?=
 =?utf-8?B?dW1OY3FNdVBJNXJ4OFk5eWNFQjN0dmxpdnRRNVBLeXZrc1d3SThKZTU3Nm44?=
 =?utf-8?B?VUsxV3B6RXFtQzA2YXdMN01wYlNtaUw0M0d0SnAxN2l4alBrTU1jbEErWlpZ?=
 =?utf-8?B?emxMaW1pNXNVMXN0TzMwdVNITUtWeGdhc3VtSncvRWVVRU9reWtQc29kcHpx?=
 =?utf-8?B?VVJ5VFVkZDZLcUtxbVBzSDF0cjk3aGJHWmtsQnE1ZitEd1hiajBSakl1S2dJ?=
 =?utf-8?B?bzhtUXhWMEhJcmRCQVVwSWpMbW1TcE1obWkxUmhVeEFLR0ViOFp4Vm45eWJW?=
 =?utf-8?B?SU9qL081cFVQMFpncXA4cFpaTnY0VHhDa0tJaG5RVDhLL21wczhNSUw4WEpm?=
 =?utf-8?B?SlJDUWhkZm1NUkd2N3JRcTZ6eXdyenlObGNhcktGQnBYcmMvOGFmNXdUcm9T?=
 =?utf-8?B?Tlkwc0lCWmQ5UkhSTkJkWUJleGFUcnJ5T2RtUEQ0YTNVOXNWWXRqR2ZKaGZN?=
 =?utf-8?B?c0xSaU9lWlE3Y2w4QjN4YXA2NzF0d0JDbzFDZEVHODBIaENPc3RxNFkxbU5s?=
 =?utf-8?B?YmFEYW95OVFIaENVSGx2ZGExVk5PMGhIcW1ibGRpZjlBOVlvOVM4OWNtN3Y2?=
 =?utf-8?B?K3I1TjcwWldiTkZMT2Q5cWZ0QzVHTlE2ZkZJRVlyWHgwWjVDNlFrb1l3SUl0?=
 =?utf-8?B?TmdRWW1jdy9xcGozdEVlU3BhZUEzWnFMMFJUbmVseEN4aFdVZ2R4NTVLenZ6?=
 =?utf-8?B?YnQ0RUtMd0EvMDVZQm85UDZOZlgxa2NOdG9uMmJES3MxUjNwYTlkM1llT0pL?=
 =?utf-8?B?QkdwNVlHeWdwSnJvSllNY3Z0V2pVdllqdDV1bTBBQ3pNb3YzeHAxekk5Sm91?=
 =?utf-8?B?bXAzUWVHMzh0UUFNOEVBN1I0UCs2cHB6ZmJaclVpUmpFc3J2YktJT0tuUDhw?=
 =?utf-8?B?R1lNR3NDb0ZRNStjRkk2OWxMWG9sNzBVT1I4dXY5eHoxc0JiT2VkZjd2UVdF?=
 =?utf-8?B?aFF6THkxQjFBT0JhMmJacGhOWHc2K09DL01NbTFXdktRekFUdXhxKzhncFdu?=
 =?utf-8?B?c2JwaFBPL1h0Wk9qSnNsSXdkOFlHYWtFZVF5ZjBnUWJsd2swV0ZWUjh5OVhm?=
 =?utf-8?B?bXUzWTFYQTFvYkZqbnRHZTZVK2Z2S29GQXhka2RJY0tKM1RTczFEZjFCWU9Y?=
 =?utf-8?B?KzNRMytVeFovYVJXYW12TlBGVVM5RXhOZE5sOVdMQU1udTR1bU9yTndvUzUz?=
 =?utf-8?B?U2toT1ROV3E5Vmk2aTRUcnFtb3F4ZlVrTGlXYnpGeXV0MGRScE5wZTYvWGZF?=
 =?utf-8?B?WjAyVXJERitjQ3lGVWp1dktvbWhidEt6QmlZaWpobmFuVDgzZnBkUUFzVThE?=
 =?utf-8?B?SHd2ejdjbUtPV3MvNHNscmUyYVI0S1VCVGRleU45NmZQQWpDaVFLRk1HNGlH?=
 =?utf-8?B?QlNldmo0Y2NpSXpxaERQRTJaSVozYVFyRWJ4UDZUY2JDZ0FBZzlMbmtONUtx?=
 =?utf-8?B?cWJicXcyVUtCa3VablN1U3FkcFdhL21GZGwrTlpUaUVGSlZGS0JYdDNQRkFm?=
 =?utf-8?B?Vk9FK25tU2Juemd2RkxwRjdlRkNCV3Vmb0Z3cmVJZG9JRDdGOFp0Y2ZvQ1Zq?=
 =?utf-8?B?SUt0ZThvK0ozNkRCNjNZLzdRS3Y0RWdWTS84TDJTTVBUeCtxWml4VjZWa2lY?=
 =?utf-8?B?KzB1TVpqa09hdmtrWTRsV09TK3NiKzExekorVTA1b1VZMG9tdHZmOFN4UFB3?=
 =?utf-8?B?VEpJT1BsL2dRajNFbUlkU3d6cUtVU0pzSmtGakJmOXVGUlZsczdmVzFtM1dr?=
 =?utf-8?B?QzFrK2REbGhhcGh4VDU1QWRiS04ya0k3SnR4N2lUQlBIYzhyZXFGNU5aa1hu?=
 =?utf-8?B?N3E4VTQ2VG5JYkwyUkNwSnFLNCtRRGxWOHlFRWVtejREL2pwYms3a2poa2pU?=
 =?utf-8?B?UUhDamFzUUNMTjNKVm45b3lWSDhZZk81OWZVQmg0a0NYTGVPb2VKVHhYN3V3?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lXBj7CFM5E94wIG1xvjCz5CXcYsRI8B+WWZFSfgY06Xtp9FXXoF1ddcdWcKGJj0GkLNclcvkAHIOsp9vbRv236GAwe3YiWR2Z44GTGXH/guBPrFQGFJWreCfsQfkriB3lJf2g4gYIrXhCl6dujAzmwAM2Ug7CDUd4GIVWm+UJpt5hFbo0ToyHGVlCNBRJB3Ubk9/pSfViHKSmqMSzlburCSngRaivraxPHLGZnNNAwlarUNH3pqCRyfau5YF75PfGIyWCDyfjGU/8dM2tBPO1g8v9X49i4Np0hnDobizDA2wm3Rmu+7rm+Dypl1HrBseh/wR0YgAve1QmLFHMaqSuOpRDLY6NF7FewT+ZEzF+ebEZ7tAeXVop0QKJGD/c/gKAHmHMmNeevzRC1AXTJZ3uRoYskVTAdE4EkZlqxW/hAKXLKByfjBQhQPaSy5IF9npF3qBeRlsmQBuGvAd5d7h/AoNFdC7sKD3od41kTNU4YuuLJeaBZtUMzck4jYSDGayk/aP07fzI0SDgev+LXPvMqKXIM55oillWqJRL19TnRkeh7EzuqTURC+7z6pCf8ooIzzgMsjskZIoohxqkPWrlJmXfIBwDZP7lhlRTpOs0Qg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148ebc4c-b9ee-4013-7b19-08dc9ff61d06
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 09:04:17.9791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMBarFrLIAGE4ywctJnonbpf6/jTuQSWf74tiWXUedNtcqh8j99JLrJaF9jdko9h4vcmbrpmMQ7sw6Z/lmd9Kd8Se3K3Uqm/JwQX3GZNQgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090060
X-Proofpoint-GUID: 10qi0c1PDBop0O5ZpGIVMF1JWwWaY00K
X-Proofpoint-ORIG-GUID: 10qi0c1PDBop0O5ZpGIVMF1JWwWaY00K
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

On 09/07/2024 07:28, Cédric Le Goater wrote:
> On 7/8/24 4:34 PM, Joao Martins wrote:
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 2ca9a32cc7b6..1b5b46d28ed6 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -212,6 +212,20 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice
>> *vbasedev, Error **errp)
>>       return true;
>>   }
>>   +static bool iommufd_device_dirty_tracking(IOMMUFDBackend *iommufd,
>> +                                          VFIODevice *vbasedev)
>> +{
>> +    enum iommu_hw_info_type type;
>> +    uint64_t caps;
>> +
>> +    if (!iommufd_backend_get_device_info(iommufd, vbasedev->devid, &type,
>> +                                         NULL, 0, &caps, NULL)) {
> 
> I think we should report the error and not ignore it.
> 
> That said, since we are probing the hw features of the host IOMMU device,
> could we use the data cached in the HostIOMMUDevice struct instead ?
> This means would need to move the ->realize() call doing the probing
> before attaching the device in vfio_attach_device(). That way we would
> catch probing errors in one place. Does this make sense ?

Yeap. It also helps centralizing cap checking in addition.

This stanadlone use of iommufd_backend_get_device_info() was also annoying me a
little, and there doesn't seem to have a reason not to move the initialization
of caps earlier. I'll do that

	Joao

