Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D89C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV8rp-000857-OJ; Fri, 27 Jun 2025 09:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uV8rn-00084u-BU
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:11:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uV8rj-0000ZS-U3
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:11:42 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RAcfXg015255;
 Fri, 27 Jun 2025 13:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=MNpKdAdg0YXd5tyJ0V3XEWhfsaJRCLNzi3hzMi7lhTo=; b=
 A1sHWxYtWuHVOPmZhYVlKHJI22X3T7cCDC/fyomLO6QCoxdjXXPlK3KxSXPxQXAB
 0sfIjwKIgE+VvW9xSSdGUZecrp7mT0LWYuxb3Rbgt6ARetQMMBhKcGY7M4uRmKwp
 w7tx8wFNKU3aPgyYyvHzFwxOR0ZWW/YsIzSnTfca9sLsPDzexWm4IBdOcTLeTRHo
 i2QTlhdp5lQjJSs55y/Ps9vO5pcqXeK9H96dPZv3eWwxRuLxHjeLFokQunFAEFY2
 t8ww3iJd7xGuAFgIKMpLrGAlBGUOXOe/cCT/BWfB/QMBOD0PfDjsqqFemLen+DyD
 NDYsLfpu9ZcKWR2EMpsjBA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5tu6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Jun 2025 13:11:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55RCbnbg013322; Fri, 27 Jun 2025 13:11:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ehr8tcd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Jun 2025 13:11:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLdJCoXYyyIAdcnO22SZWjOBFGDYuvi8swzHnmYM9CbXtbpOk3oY8atDTgqn+25r1My4q3A5MQXXtU0IWXTP0nBukkmlxrNqwysDj4gD/iAghjTB2EA+OPvCTMxOlBz4//z1WpDCadrL0QZenldUXAkXJq3GkeE0F/rT3RO4UXMVRLkw1ky40oFkFZC0GT65x4nVyL7Q4P8rEPAo+7+cz0T3eZrkQoXzY/Kq+1GaUlMKZ4s03MVDwRvUoPh2nWGsLLicmVWXLHWjzPAgnKzGxyhiWqjwDEskRw8JvD1ZbJ08pxCJFKwjaOnycq7vqXyeufnMKSQcsct6eVI16wYg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNpKdAdg0YXd5tyJ0V3XEWhfsaJRCLNzi3hzMi7lhTo=;
 b=wBKDTJyoV4zMJ2rE6iphmxorwy3IXpyS4pwGN7p3WZff9kkpWXmhXMOABjmXs+EKPHA3mYyA4XOxV9WrLWL5ZNQIMxZQ/Yqq62y8Dh7ztHBQmNtunPde8lzng06kftYS7BjutP5Ry41aRoksNwxtWvKJdrYfiV7wqKmscRTwaGZn1U6n2M31TrI9A81+FbanctPLOHM2TQrOzqWOj6eW6xiycXDQwawXAxCqrfoNYbmSBfbWwsiBxDN/8kX1I+niIp3DPCcOrulqXZ5DnXJsLeABjUvi3AyZGk9y6kehy3xa4sIrVTQJCdCCkWvenYSCqJPsNJk82gmf4qHVn45u9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNpKdAdg0YXd5tyJ0V3XEWhfsaJRCLNzi3hzMi7lhTo=;
 b=zq22/0pW6SQ5ukJG0vgSFYL8rWoqx7Er87+dDEUOmKkldbjm+xLX7UOxdKf5RPwempk1O7Wuzr4hNzu7ntbt+CIsDPNV6Wd4uMyQd7oFAFzG4x3ywdwrFqb75DOFdiPltb2kdax3hRcQ1ogRIBzUgJYhgnTPV877g1YSj7K5fmE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7331.namprd10.prod.outlook.com (2603:10b6:610:131::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 13:11:29 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 13:11:29 +0000
Message-ID: <1c4d57d3-d727-456d-be91-5ab12d8f350a@oracle.com>
Date: Fri, 27 Jun 2025 09:11:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vfio/container: Fix potential SIGSEGV when recover
 from unmap-all-vaddr failure
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com
References: <20250627063332.5173-1-zhenzhong.duan@intel.com>
 <20250627063332.5173-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250627063332.5173-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: f92332c2-0627-4a61-48da-08ddb57c212e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVlLdWN5VFYxOVRLekxIQi9zSnNBSTd1bU1GNVB6TEJMd2VUOVVsdkR2SDNI?=
 =?utf-8?B?RDliellpYXVDQ0x2UG91bWZHcXBmc3o3WXJJaWlKWklVK2tRNEx5N0FYOVg4?=
 =?utf-8?B?ZWVGRU41dUd6cDVmWlNza1huc0FiNDBEZzI2eGpPVTJsV010N3c5Zks5dzJw?=
 =?utf-8?B?QVB3TlNKdUhRV01KRkhpTEo3Uy9Ybk1NL2Z4UG9peWNBUG91YnNoRUI5SlBI?=
 =?utf-8?B?WXkvZmo0d01YZ3NpMERqWFRVaVZnbEd1b05FaWF6cUx3ZHJ4VG9tOWlRSko5?=
 =?utf-8?B?NDlJa2Rwak04VXVLV3V2d2Z2OFI1dTN5dFNrcjNhNklPcGJFa3FPbGlUUi90?=
 =?utf-8?B?Q3Q2bHlUKzhwdEZidTlNQndOOTcrODNVY0xnbUZ1cnoxaTh1NmxNUzBtTmhP?=
 =?utf-8?B?Y3RTSTUybDZwOG9VQ2tabjVQY3hPNlpvYmhCTDdyZnptYnIzT1hCUks2QjNj?=
 =?utf-8?B?cmZaNmg4R2NtYWVwaVUzRUE5NVp1RGpyL0lVcmRHNHBUZXRCdTFvNVBCWUdZ?=
 =?utf-8?B?U2RQR1N3OVFjNG9RNEdzNEN3cWhyT2RTbTkxLzB6QnQ2VHExVkZ5K1gyOUdW?=
 =?utf-8?B?Z1RZdkd0dW1lQXRkWHNNeTh6NWo2b0I3MDhyYUNxZUQvazVtVXFPQkpxWDk1?=
 =?utf-8?B?R21WYjNMb3RXVm1qWXlVaGlUZWhLOTFYRWJwQmZ0Rk9MWE9LajhQUTRLUjFL?=
 =?utf-8?B?a3BZRlZpSXpVRElUYjVqYkFCYUkwaytkVFFTZGdzMTVPQ3c4ZTF5TW1KMDBV?=
 =?utf-8?B?M1IzdkQvRk11d0pCOXBZVTVkREVlalhoemU0WEVJaDFtVTlWcTdLYzBUV2po?=
 =?utf-8?B?MDBYSjBQcE5WeGdEakRXZ2NXbTZZNkdEL1pUaHgvdTlLY3IxKzY4Yjc4L2J4?=
 =?utf-8?B?d2NyaTBKNFNFSkxoZWFFNTBqcnBCWGJNUW9zbjc1cEpEZERZNHVrRGVGNzAw?=
 =?utf-8?B?SDBrWjVUWC9sUkxhOTZRV0s5cXQ0WUZ1T2h3NnlEUDQ4QlM0OGRjaElwVm1a?=
 =?utf-8?B?L0J4all0SDNqV05HbzJudng0S1dudERiUEJObGhvUHN1TnMvendzWDJrWE55?=
 =?utf-8?B?SklMOGE1ZkJRUDBVUFNOc1N2K2d3NnFEdDV1bHptd1VpeXcrbzNhM2pOQkEy?=
 =?utf-8?B?WVpHWEJjRVNoSDV0SE5lY0ZJc3ZYWXZSOC9RWTJpZ0lvSnA4dklVWXBxbzhI?=
 =?utf-8?B?YkZQUUhncE8ydE9Ub2R2S0Q2Yi9mc3lVajNVaWVIdHdRWkRpYk5sN1ZTZVpN?=
 =?utf-8?B?SVpWbXdBTWd4VnQ2TXJGMGtEK0h2NlBySGZSVm11VERxd05lZ2lnRVcrZTQ3?=
 =?utf-8?B?b045OWhzd1B0c2dXRVZhcUpIa3lvTGN5akdRdlIwbmYxVUhuUWNXcmIxQmEx?=
 =?utf-8?B?ZnJVNTVGTlo5bEZJR09VbkRCL0VpTnBHa3NFVW95c2M3L1pYQ1J4dXl4R0Z5?=
 =?utf-8?B?MUpRWC82NmJQV1ArSVcyTGZFaG9Sa3lzZ0pMVHdwUzcwUHlXa2dRMjVUK3BJ?=
 =?utf-8?B?SVNvNHNncjNaaHBHZGdCRDhKT3p3NlNielR3Tk5WYkRnOVo2V3RGWDQ2ZlA0?=
 =?utf-8?B?M202V2xseVV3ZnE0NXBpejVIcGQyVHFFVjZ0OTFjaVdjNnNJWXQ4cUJIVVAy?=
 =?utf-8?B?TlBwRFB5KzVOT29zMWRnaE9xd09xMm9oWEd2RmY3TklxWXpOWEFOdmJld29v?=
 =?utf-8?B?eFY1MHN0bUZaTUJVK2dZR05aZWFTMmhmRzJ4bUptVTEyYjZXVHg4VE5qUXBm?=
 =?utf-8?B?UjNmdVJQcnAwRXI0QkFaNmphZmtPYUFicXpmQmVzTDdvQUdNaXFtTVAwcllv?=
 =?utf-8?B?Nk9GS05QK2VuQURidHVWZWora3grU2krTFJWNHpuaGhHQ0M3RlZsZ3N0eDhJ?=
 =?utf-8?B?WlVsd280cEkraUJWRmRyKzNocCtuRm12QlYzUG4xZWlNUjVoTnlnRFdBN01W?=
 =?utf-8?Q?hV/OPMWiAg4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUtvMUx0ZFpvekpDeXlIeW14MTRxb0puTUU3dVRPV29vTnBTMDkyQklJdGlz?=
 =?utf-8?B?cWE4U0NEUkxpT2RNTW5wd1BRVi8yaGpEYjJjMnNDYmlhOTExdEhEYTJ1T2ov?=
 =?utf-8?B?Y2dZZ21nd0RhK2xNelR0RGwzQjIxdlpwZFdKVWxpeDhNQkt4TEFSQW9xbHBC?=
 =?utf-8?B?dFJzVkhyS2V6ays1d20rSkFVaW1xWmV2MjIvYWVVbG9sODlsNC9uMGlQb1pp?=
 =?utf-8?B?QlpNc0ZNcHRnOWdSL2NJTXROcCt3NzNzT3o4UDl0RXE2QW8rMHhqUXlVM29w?=
 =?utf-8?B?Y1Vwc0ErSExuK0ZUWTAxTnZvVm9objhJRTczTkliMFh2QXVaMUwremx4eEdn?=
 =?utf-8?B?V0VRcmdDcldqSjh4VzJnSzVZTTlxREhNUVZMR3d6TUlrVjJzZ2VvckVSdGhz?=
 =?utf-8?B?R2pmRVJSeUMyN3NtWW9tOVdwcW9TeGtEbkdPOElQUzk5Zkd2RmpMUmRnc3dl?=
 =?utf-8?B?M29Vb2lFV0o1QjBqNGs5bnFCd2YxVHBkZ25UVElteGNyTkc3QkZCeTJmM0Ix?=
 =?utf-8?B?Yml5Tlk4bXdiR09OUmloYkhwKzFqd1RvNG1GTDQrWkFHK3VzUUROQjFBWXpE?=
 =?utf-8?B?MVR3MnFHVnRrWHdoeFR3VGlZQWM2SmhPUEJ5eE5wa2ZKblJWYTJiMDJ2Znpm?=
 =?utf-8?B?SU4rbkQwZm5LdlR4ME04M1NwNkVwQVF4REJOeW1hNHh2c21CbWsrQmErcG9V?=
 =?utf-8?B?VFpNZU1KWXVDNVMxTHlEaGhEQWkwSDByWkRnbHFBajY5WEJYWGdta3dRRUM5?=
 =?utf-8?B?YzJPTGxwTm8wVEhxbHVOTjQvd01HOS9RRkJaTnFjdEtLZXJ1UG5PYWJJSTdm?=
 =?utf-8?B?Z2ZPcGFDQmF1Rm9RbURjdmorUnA1a2c4aXFiQVJwb0NuYVRpUnRTdWwybVBL?=
 =?utf-8?B?bWdxVElVbi9UbXNGTG5maGNBYldrcWFPWi9oQU5lb1hSRkhZSGJUWjBBaEZz?=
 =?utf-8?B?cmNyMmx3OEtWQ0VUWTR2U1R6SG5aM0Zzbm1kaTdtamlrTDg4N3R6dEhEdjBB?=
 =?utf-8?B?U205YVB3ZmNHNDZBblJNM25CZXdGZzkzL2FsUjludXlDWFZjRS9IRTNCWnZL?=
 =?utf-8?B?SmkrTVZOekFoYmErMW0vRVl0eU83MjZTWTVPRnozR3Z0dWV0UmVTK3ZJUXYw?=
 =?utf-8?B?RUdpdkpZTmlBSjJDU1hQZllvT0hzSWxDa205RHNnRlNSbm1wai80K2pJeVUy?=
 =?utf-8?B?VmZmUDl3Rm9GbW5NbTRSOEp1NE1rb1YrT0o2S0FZNVFEUDdXV1h3ZXhtUHlX?=
 =?utf-8?B?SUVqZVFDSFcwc1pkT05EUUpUU1FKbUVxcktacktMcndtTHpWeHp3MW50eFY4?=
 =?utf-8?B?VXpMUkVnQ1JuTktTN3JCUWE1aGpUeExMcE02N0lHQnVldGttR3h0aldsTk51?=
 =?utf-8?B?SStLQmhrRGxwTzQxZDBwdmNTZ1NGVTBDYWZzV3gxOWdFc2JDTUhDWGRLRnpw?=
 =?utf-8?B?d3RlblFheHRyYno5Q3hVY0t5YldKQ2szb1BpWnNMZFMrNXR1em5jaXNaaWxw?=
 =?utf-8?B?YjQvTjQvZ1hTODVTYkMxYVA2cElXaVcrZjE3YmhId3dLRmpnTVY2UCtad2Qy?=
 =?utf-8?B?VUNBK1BQRTY0c1hhWkJKMThBVmxOV0dvbVlDZXNEcGoyOGlPMjFUbDVYanVa?=
 =?utf-8?B?YVRoeDUxUitSNG9ZdWtOL2M1Wkh5akY2SDlXNWNoSk5QVVFEVERZcmowUDFN?=
 =?utf-8?B?bVQvVGdkb0NleHB6SzgrWDBBTEt6aTIvUXJDYXdNTkd3ampQUkJmUTFUZlFB?=
 =?utf-8?B?YndHbVJOQVQ5ZHJzUWEyYzRoUUZQNkZIb3NKR0dPaXU4VGhpM2FTMjNQcGtT?=
 =?utf-8?B?b1RoME9LTHkyM3l3SElvOUNraGVTanFDOUl5VGxuT3VZTEFRTlM2QlQxbW16?=
 =?utf-8?B?RWNndWE5ejVtaDlPVFlFVjNpTEI4U0N6Y1gwYW1tSW9Xc0RYdm03cnpteWNW?=
 =?utf-8?B?VHNENTRlMzFvMXpWcjhZZS9RZ3FLUDBtVExoS0QwYy9BM0Uyb3BKc084TnN0?=
 =?utf-8?B?ODRPcG9DZFY3Z1FDdi9jT05aK2xSK3FDRSsyeEk2aXE2WStQYmIrWEZCRklF?=
 =?utf-8?B?SDhoeHNEVC90N0tqcTFHRis2QUNSSjYwWlZkUWU3UndEWlZBUFduOCtzb0JJ?=
 =?utf-8?B?a3NmSEl2SExSRENlMjNwOXplQ0J4WC8rQUFUT1BUVjZZVng2dGpxcVQyL2RO?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Vj43vi49Za7Kuhh0Yd7tiG3vMpLxOyzHUro+XTLQ5MNs2Wfgg36dROpwF3g7xQVvOjUCToJZuLj9R76c8jIXZVuWu/+SkfX+MJKI4T9bd/cY9IBoi4rTzYgfZHDdXgfkVN3YuAJuNsJ0L2QTrtpO2ikok9+k0YL4CjNOEMmlY+Pv37la/CsMSiRvfzdmAacR4YJf/1l0wee/M4ygmRptigraZ8Gx/wQdKbOo+UTR48L79SHQNYyCr3/s1vfdOyVgGPKVZ0ZSQarhT6Gzlxmy+NJ8yEVEW9sRRtyyVjqM/FNV8ZVNUeoSMw/dxfdRDfqEJiRi3l9R+Pjum4grW4EoGnFq/wvDAqgGU21kRFM+YFwwjdOMkfs9zuhv+RcF6QnwlaMXzJTQMee9M0sIAxrxYMo91YfGDky8W+45g0NSPJ5XyPBxlWv7buVA+bMxohuDk/kbGSlrmyak9ybNER8xvIStC8nDod8L0Z6K5jPUrmF+XvmZx8koZM6GKu/OVnYAC0T1C3oPHc5DWzq37wyqEu4LiIAAn4DXx4FFzrOqmBHVkuAz1TTL8EfGayPCtkeNe/snZadD4uU/Gjs1NlpQ74w0QhLcaJbW/QI8IWgskhI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92332c2-0627-4a61-48da-08ddb57c212e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 13:11:29.7066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kR+jgecGoPiT9QeYCVYx49+rBrpCIMBxIUM8o5e63815PvbpUdbg+J69+29RCD9y5LznDO06uHMkaQGqPYUwBXhoEVVkdzqHZIZ+Nqp82UQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506270109
X-Proofpoint-GUID: SeTnFFeNcVRP_EejMiYvIuZmg0kyyYOS
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685e9886 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=pYgRdr-ZsJMLOPzUq5AA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEwOCBTYWx0ZWRfX9a3acA9OKM2C
 wwV/nMnJQGTT3s8zK/rFw5z95iyN8/dtGOV4X/Tc59giFvBz2g+WPWpiKHG2BCErFZwavUuZKKo
 u4ufLOKoc2ywvctpIwb6FtXTABcA8V/B3J3H0rpSeK1eJmEJL36Oc/rYG+N0f4g+plXy1jQnimH
 cXWa/2d/elEDfgcvxqcStWqa2RCQfSKi8G0SkEs74PDgND/pcobxdH7NX6IFZALSByq1y3hpv/g
 ZUXfRBdIrktUydUDEwv13EpeOc8SIjSJaJMHgOjXZqSBExxwKbKECffJNUDUe1wMTLn/29DZjDC
 J+IoQhGF2uF0nzIt7pNXwcLUA9YkMq2++lFHLqOpx2bdT2aPOAPGqweAcc+GHzV3utDtolWL9b0
 4jZHSofa423+RDDSTl+ArPk22rfIdmG1hX/aCkH+4DN51OlMgPgJoIxlHJf6S7G8M/fnpfW4
X-Proofpoint-ORIG-GUID: SeTnFFeNcVRP_EejMiYvIuZmg0kyyYOS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 6/27/2025 2:33 AM, Zhenzhong Duan wrote:
> CPR overrides then restores dma_map in both outgoing and incoming QEMU, for
> different reasons. But it only sets saved_dma_map in the target.
> 
> Fix it by always setting saved_dma_map.
> 
> Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
> Suggested-by: Steven Sistare <steven.sistare@oracle.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/cpr-legacy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index a84c3247b7..0a5d1bd480 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -180,9 +180,9 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>   
>       /* During incoming CPR, divert calls to dma_map. */
> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +    container->cpr.saved_dma_map = vioc->dma_map;
>       if (cpr_is_incoming()) {
> -        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> -        container->cpr.saved_dma_map = vioc->dma_map;
>           vioc->dma_map = vfio_legacy_cpr_dma_map;
>       }  

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>


