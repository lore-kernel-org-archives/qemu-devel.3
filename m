Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF7DCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESrZ-0003v2-PO; Thu, 30 Oct 2025 09:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1vESrU-0003u5-6T
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:38:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1vESrL-0007mJ-DR
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:38:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDCHMt024304;
 Thu, 30 Oct 2025 13:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=2taC4FyAq4juusWuEPsPEBsyeZ4lywHzZfxjdOBRkyU=; b=
 EDmOBICJM9CO7JF1qs5FLcniqDYV29ITG6+1VTCu9j1j7+WC7uh2QcZapj8Yn7gL
 diish+57QrA/RjsUA1fWMFKUvUXlQA4tf6OiMZyUHQLfhpTPKg5XegA4Fd2ZZwuo
 FOO85F637NrEq2R+xDVDTAswHoDTd0K1ZKZ/GFuvwEUSXVVXiUZoy68Mt/AygL7+
 8KcEXtTs4NPYyRRB9aFI+PRKJ3D7NLtvJQ95h0P+Rc8WVD69tjrb7ElU7a017/qT
 e06rEyXWXNHlAlheCVQUgCIkgfzT41vhOQWXikluo5ROsNNZ48ww1b0MHBr1lUIe
 x3AaSQ+WCTjz++gf02fOSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a476hr9j6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 13:38:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59UCxL2E023338; Thu, 30 Oct 2025 13:38:23 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4a33vymufx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 13:38:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lamScclDXn1LtyQKMMhwJRFiq+F0LOJran4ozSGBBgUnTbt5rN+TYvwUDm8TIpaeEos9sGVKNo8ChUyUfA5Ax1FBUMYRqszy9HecahlOsxA27mngqAwEgqbjRtne5GJbWq3sjbi+2FSoY+cFy1/VVsBav0jBZ2QgR0ojPgqS3sHChDgXO88tVedLerknUdUb/qHIuYYGBvIvmXYMD1oK34ge9PA+hrWOIPGbW+/hPD8/c5f039K0xM/V2Z/IL7Dow3C8o/6kP5nhwM2UIRedoLuF5NdQuOkYc4rkgGTMk6aOx81EyZraqH3oNIT7aGFUTPB8UDwndSgJsRkJbNzwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2taC4FyAq4juusWuEPsPEBsyeZ4lywHzZfxjdOBRkyU=;
 b=uPRu+hCRBIh6l9Z1hhmjDfBgefQao/u9hy20YnY08kogCB0N3jtlzAxMxrc3lGHPyxTpM7UmWjDCv15kvbkIS4XYMEZe545qdwRuprG63ihhoQVUQFZ0yxSYZAFQoUU5jBa6q66bIEmprqRmnNtSVT1PesWv+/smpB3Ese34FjsEt4SjVy6m9llGWWfVxChBmxLTKMv6bAiIFGT3WwK6fzrX+sjuyoXuGgDhxJQtCn+z2Cnc91aI48ASS2SIXab9goxNxlGA5QtFB80Kh5gNH+zoGdR4ZT4B9a/zlRU2haM/bKtCPu8vWh3Z+01MGkCRxFrpP4Ag+YcltE4bNNDhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2taC4FyAq4juusWuEPsPEBsyeZ4lywHzZfxjdOBRkyU=;
 b=XQW9pPsaFyK8FoQwIbYGxor/E0WzKk3x8SNJHxLt1VYh5lC23OHobQSZhT1NsRHZfBPtdZjlCHhCeSbKgET+lD5TyTTRBq9Y5w6CorII/a9Et1DN9tfTOfrS6HcprnYBdAv0mnrJfjZEnA/vohAquL8l4GHMKq6BD3XhV3M4DBI=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by BN0PR10MB5047.namprd10.prod.outlook.com
 (2603:10b6:408:12a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 13:38:16 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61%3]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 13:38:16 +0000
Message-ID: <d073c27d-1006-470b-b5ef-7d7e73a738bf@oracle.com>
Date: Thu, 30 Oct 2025 13:38:08 +0000
Subject: Re: [PATCH v4 08/10] vfio/migration: Fix a check on
 vbasedev->iommu_dirty_tracking
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Avihai Horon <avihaih@nvidia.com>
Cc: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "Hao, Xudong" <xudong.hao@intel.com>,
 "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 Rohith S R <rohith.s.r@intel.com>, "Gross, Mark" <mark.gross@intel.com>,
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20251029095354.56305-1-zhenzhong.duan@intel.com>
 <20251029095354.56305-9-zhenzhong.duan@intel.com>
 <eb2e5419-7a63-47be-adaf-e34709d8310f@nvidia.com>
 <IA3PR11MB913625D418E023D14D4ED0CF92FBA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <fbfe567f-c8d0-4342-a593-efe48d7050ad@oracle.com>
 <IA3PR11MB9136D46E2ADB556BBFA68A1792FBA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <IA3PR11MB9136D46E2ADB556BBFA68A1792FBA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::16) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|BN0PR10MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: 75df3d56-ca11-4967-306e-08de17b9947d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akJIVXBNTTBhQXl1M1IrZFphMzU1RGIzSm9lQUpzVTRGZDZoVHhsWFYvUXpP?=
 =?utf-8?B?eWNvL2tGSEZJWFdNMUlQNXBNRUxCZmErb2Q4Lyt3ZTlTWkU2NXlFSzdLVG9X?=
 =?utf-8?B?VEZiRDJTKzNSd0JpK2JsV1Vvdm5sLzdLZjgwMms4dTJsbUFnRjJ2SmNuYWNo?=
 =?utf-8?B?Znp5bXdLQXhLTUNGNFo2Sk9yb0h6b214Vmx1NXdTUnc1RXJpWlRyVVNmU3RD?=
 =?utf-8?B?Rk1wblQ3VGwrRjVXVWt6S0duNE9lVEtpYmlZWXpOYzZ1ZTZ0Q1lJcmJDTVZN?=
 =?utf-8?B?SFplQ29od0dSMzBwQlFYVER4VzloTisrRnBoVjk0dU5xME5EQllnSVh6SzdZ?=
 =?utf-8?B?TlIySUl4cEVxdkpaakpvWFhqbndpaUx0OFY1dWRYNWNNLzgxa2UycWRIZVA1?=
 =?utf-8?B?eVZiK05obGxjN2ZtelpNVDdxdE1XMUc5VVZ2YW5jNmdGU1VMYUR1OFdLbVhr?=
 =?utf-8?B?ZHo0RWFZa2U5RzdQUzlDWWJORSt4TzV4dWJZWnlZMXpsMXVNNldNWTdKMUxT?=
 =?utf-8?B?Vk9DZ2tNbFpQc1RnUUl2dlZZaXR5SzdyYy9aVHZXb25ERTRZTGpkUGs3ZTBu?=
 =?utf-8?B?NFgyOWpmWlRSQ2RGaXNsY0cwZmJVT2t0ZTYzQTBGZTdqZUxvbE5kcEtFcmNL?=
 =?utf-8?B?QmNRUHI2b0Z3blREMXgxMDM4U0lMRjRhSUcwL3J4QkhpRmZtalIvRXYxR3d1?=
 =?utf-8?B?NURWakdBN3pOcW56ckxOc3J5WWtvSm1sQjd2S1VaMXlEWUlFYUVNdUpTdFpR?=
 =?utf-8?B?cTZlVDljeDNqK05ZZHorUGV5ZjRpT3diaHMvY2ZsRU9GSGhkSDhUTFI2V29l?=
 =?utf-8?B?YTZQTlFMWTFqRjBjU1FBelNkQ0c0dWQxazdmRUs4NDBUdTJQNGxPd3dGclls?=
 =?utf-8?B?THJFaGpnaFVmZ1EvMCtKT1JWTzZHcmV4VGU2azZJaDNGMXgxVGpLUWYzSmxJ?=
 =?utf-8?B?RUhzUy9pZzk1bElyNjBtdHkxVXM5amJGTTd4MDFKUUQxYllSVG4xbGw0bjFu?=
 =?utf-8?B?YngvYllZZWVnS1R2cS93Q09MNXRLbk1pRkFCMG40UnNtTnZwVlU1REtrRisx?=
 =?utf-8?B?K0lySGtjcnlFdGxDc1V5NXdYdHN3bzE1NGZ4Mm40MUtDMVN1MWxPYzBwUHp2?=
 =?utf-8?B?RDFCR085QmxrbDlKZlhuMURHNzVHSlFqSS83bTFLL1RoYWh5SEdaZWUzMG1o?=
 =?utf-8?B?NkRxNGprcS95TGdyTmYxTi9iRnZUVDdTVGxvemtJQURjbSs1dTFXSUg4eDY0?=
 =?utf-8?B?R2k3c0YxSHlHQkRBblVvV0ZOdkdNL2IxWm1VUm50b0ExM2djeXpZNWdRY2ww?=
 =?utf-8?B?RWJrSHF6REZHWGd2Q002YThjQ1UvVWNBTFZ4ZjhTbWJwRXIxQkR1OXdLdU1W?=
 =?utf-8?B?K0JSRjlidG02UUVueFdBV0lWc2FxNWNlRlJWU0lKSWZpenM1OTFDVlUvajNx?=
 =?utf-8?B?QWxsMHdHVW50WUc5U2tRbExzdktVZ0ZxQW95YmduaHA4RWJOZGdJclh3YmRF?=
 =?utf-8?B?WlYzdzNDcEZyU0hkTi8wSklFMVREYmlYdThua09DcjhmN1Btb3lEV0NKQWJy?=
 =?utf-8?B?aUQwZkFQK3lDRlV1WWc2dEhvZEVXbzBBdE4vWTJuekJJQ0FWRmxWVDZuWmtk?=
 =?utf-8?B?THVubWpBZjNDNXl3aDRLTEszaWRrK2RtZFBhd2QxVDlxZjE1R0NaN25EQTRt?=
 =?utf-8?B?MEJqVHJQSktrRDNTbEZiWFNTTFFjS2F1bWJjT2I5bXpFcmx4YW1yRXYvckxq?=
 =?utf-8?B?aFNUV05LQU1GcFJRYXNKNCtoeVEySVlzMnZYNEhKMWUvN0Nzc3FkRTlvOWdq?=
 =?utf-8?B?VXhHdk1SMWRLeEk4cXF6aWo2MSt2a2NsTnp2YVBja1ZJZE9IM21QUGFLMmZq?=
 =?utf-8?B?MzU1ekxDYy9KNlVGSTA4UHBBai9zSGV6dlZhUGE4NnZDZTJUaUlPQWhCTFA5?=
 =?utf-8?Q?ZL+qbAFGTwREFr59wqQ4vb229QCSgg4B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGlHT25hT0FwWjhuNDU1S29SVTZyVHFmRmhCL1JFNGRuY2cxL1l0THcvSWxB?=
 =?utf-8?B?aFpBY1I4MVl6TDNWT1B3cGFTWEg0ZWN2LzFhU2VIZlNDeWNpT0NjcFRhNXlL?=
 =?utf-8?B?aGdKZWpVSDd1eDlFMk1XNTJvYVJQdGtBWFRSZTRNWXp2V2lPeVcwdndZaEZh?=
 =?utf-8?B?UElQMHNRZEI1cE4zUDZNMERCRk1Zd0I2Y0NzVTZtYnB2TExBZmZXa1g4cy9m?=
 =?utf-8?B?S1Z4eGp3cGtzNmtDdi9NTVAxSUlzaXhRaHZ0TWZqZkJhQWZrQVh0ZklkazZh?=
 =?utf-8?B?NkxnU2VUWjEyQ0diaDVvbTJqWkRrL2tZdGgwcHJtcUM3NEs0dlpueW80Vi9I?=
 =?utf-8?B?bkxQRnhqYy9qeTFDUWdhMU9mMEduMThjdUtPRmFRemZMbTh6MWV3bVRBU0Qv?=
 =?utf-8?B?TUNTUWtJT3BZbUt3ejE1MkdMWjNTNGdnOEsxZ2l1N2UzQnNXSzNCZTFWQzVx?=
 =?utf-8?B?L09FKzZhVmV5KzBzOVdnL3kwOTFYOE9Tak0rQjRKbFBLRitiQW9VNU10TVpt?=
 =?utf-8?B?aElEZjVZZkg0djBCTCtjYTBpNnN4WHZvei9CajJQMDZ5cmN5VkM3Yms0UFNH?=
 =?utf-8?B?ZTJ6ZzF5RjR5SU50UTFCalY4TGZycGJzaG93M0pkanp3TnVBV2RZMVJIV1RO?=
 =?utf-8?B?bVk5dlF5dTk5SWJNRUM1NXV1WkJEY0l6dWhsTmhITmF2V2dsZ0RpQ1hIcXd2?=
 =?utf-8?B?aDVGQmo3a1JXbG1zR0x3VVQvUUNyN0VYVk53UUtsdm9SRjQyNENUT2duM0pj?=
 =?utf-8?B?d1IvM1VBOVBKQzM2R2lheWpNckpyZUo2di8vVldOWmkyMS9VN2dwMUNkb2NT?=
 =?utf-8?B?ZVJXaDlSM1dsTGVCdEJGYkZuL0ZPM1ZabTN3QXI3Ym85c2RNOCtJeWQ5VlFq?=
 =?utf-8?B?TEppSTZxcllpOVNhL0FrWndnYmtjVE1FUUh6VHJRNG5FT2s4MXlzaG15OGJi?=
 =?utf-8?B?MVFJT2s4TWxvTkMrYm9MTFZIRFVnL1YzTlBoZTBXWE10RjNrN1ZhL21YMXpW?=
 =?utf-8?B?ZnFwY2tHb3pLWXpvZkU1R0l0NXZmT1FnWWZPNU5WQ0RLL09oL1NCWU9qdEM5?=
 =?utf-8?B?WFcycWxuVy9USnBzNjNPMkc5Ri9nM1J6V1NPZVJBb1pTOG5wci82YVc2akRB?=
 =?utf-8?B?citMOEpLL1pHRnlWQmpOUmJiU1Y0TklNZFRnUjlDRXhwSTN1RGF2bW9iVUlO?=
 =?utf-8?B?QWNqa3FrQjJ0eWl3YUZNd0NTL1RxRTJGMUlpdjBLZ2MzK0V5U09xeFFLMEpE?=
 =?utf-8?B?NlZjTW0xcUJqWlZETDNhWkhKMHQyRE1iMnBuaXg2ZEpNeitKY2JHdHZzdGcy?=
 =?utf-8?B?VlE1b2xuYXpZQ0Fza0lXck1LbHpwVTUzK08xME5pUS9tclBZQ09mMnFQREtV?=
 =?utf-8?B?YjFkc2ZNZDFCODZBUlJkL0JxRlFjZll2dzZXRjBiSTQwWjRsTk9NdGdVd25s?=
 =?utf-8?B?NHVuTE9pNUdwVUhoa2VnNkp6eTdFRWNqTUdUSWZCVFIzSmpVL0JBRmxTaTFx?=
 =?utf-8?B?TzN2MHZ5VlEweDZIUzd2RzdZNmpYSWloNVRVQk5mRVhVUHFjNjMzQ3BtVVFD?=
 =?utf-8?B?cFhGQUpqTnZuSjVoVTNoRXc0YU0vb3hPWWpadE42cmdBNVU4K2RaOWtTZjZz?=
 =?utf-8?B?S1FxOTlZbkQxc0U5SzZkdEJDNTJYT3FOZ1FzVEFvS2RJTFVuMTF6eUNHWmZT?=
 =?utf-8?B?S21CYWhtZG5oSWhQZ1Z6T1pEQm5Qb2ZvN2xKWWg1U0RYd2g0L1FCOFZacFFT?=
 =?utf-8?B?UEx0V004aFZxZEdibzBmUDRGKzcyTzNsdW9yUHN1ZnlQbUlVb0lkMXBZYWVK?=
 =?utf-8?B?MEhnTDVBZENCb0F4ejRsVUtmOHJmcVU1Z0tqWEpYSnMyOFNnaU5lSXJpTzh3?=
 =?utf-8?B?d2NCT3RrL01ueWFmNUFXTFRhUlZRVlA4dktGUW9XdW96Vnk4SGlYSldaeDcw?=
 =?utf-8?B?OHk3dnhJNmg0N1o0QlU2YW9MalpxMWVVWnJWZlhiSEo3bXlBT1RZbldhdEVo?=
 =?utf-8?B?Y0JKd2RiZWVVVGpSdm8xclR6bC9DTnZDTExDVnc4cC8reklFK1RqU2huZ2xh?=
 =?utf-8?B?cU9MU3RnaTZOeEFqYkpndFhLQ0ZMS2N6M3RYc0E3TWNFd1lLNDRZTUhKcjk2?=
 =?utf-8?B?K0dxTXd6S1pVS0lhb3BnaDZiaVdXcnFPeWVmUWRIYTR6TjNZRS9UQ3VLZTJy?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HD+YBRuazXdANy76uE5AwbgaDDgLyQ1g1PmqLhkk3vyDy2lD2OkJzXNoKhu1xIaBiAmK3ywNMq2yN768+SvySVJ3lX7inD7xwZYCMulMZCwSEnp1EehVAHytTW0ek76p5p1DeEu0tgvO19+WdesTvZlMIJnKDsJCI/p9mGzNxigW9xNXrcd4dbX/DXI8Ur2yCQWtAUaymY6yaoGoDFmGy0xPI59/Kl0KJJco2nC46uGeERgNfieHB8XyP1ZGH9uEYcI8Npe1zW8rUVZZwG4IjEzV//0OxlF4iyL215MW/TdPjYAVczpxy8EUwqY237Ts2RemVV/1V7zD0xXjXFEfsr3MM3d6sldZN29BffKx87AsoN6O4hUy0QBqdlFo40uEQRePhEUTUOcPHpcTnOIS2VSYyfuDVu1roMZ86iOQcQCRqkyryeHnB5Z284z4CuBEOtGNkrZyRNFiGFe4JAUUNriQ4VEaZZ7CSudCqFR7X6v05JPQwaUPseafBQWW1NSxwB5nffESTbo6PeHWilWY2OUrIBHitJQD4Ka2czxCGgxG/b7JfrdfJf9yO9JXlrMokpsoFbjICoCdFbe5yF9HjSURJ5lGAiIe6mse96CvvQM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75df3d56-ca11-4967-306e-08de17b9947d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:38:16.3987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SvP3whVl4k+EAN932eYAnZd4JFgMYbfbGbr/SDaUDyGsbI5YPUU3dlDwEaXDuF0fix2aNX8sLc41rF838Xe5esbmU/qRgClCS4cRcOZ7Kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300111
X-Proofpoint-ORIG-GUID: VTCgTgwDwApUKdYQheGekVwWJzXSiE-6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MyBTYWx0ZWRfX/x3ktAhwVq8H
 nHZXkoZm0uBu2UV+R+NCAjOVmICNwFhbaVrSqDzOZWmBnnNvb5q1Slz3Y3vqpi1PpDd0Wnv8Dfx
 BHPa+YfsgncNiPl2a/hnGWYQgrDSKoaMtN7SZhnSV0lg3wsX7Ve6Btr/pUV66mCX7xELV4FFxEI
 dv7NxgqzNq+hsmiEtfzZwibfdyiY0e++Pt+mWxHyM79u5JpH7HcB4NfW6LXBHI10AZVxzuWPaoS
 XArL2OzE0x2j2yjmxxiNhMIDZdab93LFkPcCIqVV+SOXQZZFBt1szvT3tcam96yslt5BftMLZuG
 CfYBoLl5HIoBbXOZ1itgP2LcKh6oAm8JzzV/izNhZkl9F02fO+ZZK/gjalE4VTXmU8pkQfjTiHF
 IazvFWoyrIHyFo2JaLzrXsLMVq5gRg==
X-Proofpoint-GUID: VTCgTgwDwApUKdYQheGekVwWJzXSiE-6
X-Authority-Analysis: v=2.4 cv=YaywJgRf c=1 sm=1 tr=0 ts=69036a50 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=7CU49R9B68R8ivgD6qsA:9 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30/10/2025 13:06, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: Re: [PATCH v4 08/10] vfio/migration: Fix a check on
>> vbasedev->iommu_dirty_tracking
>>
>> On 30/10/2025 09:10, Duan, Zhenzhong wrote:
>>>> From: Avihai Horon <avihaih@nvidia.com>
>>>> On 29/10/2025 11:53, Zhenzhong Duan wrote:
>>>>
>>>> BTW, do you have a real production use case for migration with VFIO
>>>> IOMMU type1 dirty tracking? I mean, is the scenario you described in
>>>> patch #7 a real use case or you just fixed it for completeness?
>>>> If there is no use case, maybe patch #9 is not really needed?
>>>
>>> patch7 is a real use case, in guest, we switch device from IOMMU domain
>> to block domain and see the issue.
>>> We need to send accurate unmap notification with actual mapping during
>> migration, for both backend.
>>>
>>
>> I think the real question is why you are using type1 backend overall for
>> purposes of dirty tracking.
> 
> Just because we had set bcontainer->dirty_pages_supported = true, the dirty tracking
> by query through kernel VFIO type1 interface is used during migration, even though it's 'perpectual'.
> 

Right but that's what iommu_dirty_tracking is for. iommu_dirty_tracking should
only be set for something that actually uses IOMMU for dirty tracking. And this
patch does the opposite of that.

See below on the perpectual part.

>>
>> type1 dirty tracking just returns everything in the bitmap as 1s. There's no
>> actual dirty tracking and we usually call 'perpectual' dirty tracking because
>> everything DMA mapped as write is always returned as dirty no matter what
>> you
>> do. It doesn't look at pagetable neither for the unmap get dirty.
>>
>> It's only (known) use has been for testing (in the lack of IOMMU HW +
>> IOMMUFD)
> 
> You mean testing live migration or the legacy VFIO type1 dirty tracking interface?
> If you mean the first, we can force enable it with 'enable-migration=on' and set
> bcontainer->dirty_pages_supported = false.
> 

I'm aware. I meant testing of dirty_pages_supported code path before IOMMUFD
existed, or in the lack of IOMMU hardware.

>>
>> But reading your statement in a different way: you are saying that you use
>> *two*
>> backends at the same time? Why would you do that?
> 
> I mean patch7 is needed no matter legacy backend or IOMMUFD backend.
> 
> btw: we do support a qemu cmdline with mixed backend, e.g., two devices,
> one backed by legacy backend and the other backed by IOMMUFD. But I'm not mean that.
patch 7 I don't disagree. But this path 8 doesn't make sense, and it's not
fixing anything but rather introducing wrong behavior I think (also the Fixes:
wouild be wrong if you're code is setting iommu_dirty_tracking). It is setting
iommu_dirty_tracking on something that does not anything iommu dirty tracking
related. For type1 container it should be false.

iommu dirty tracking is purposedly there to make the distinct difference that
type1 dirty tracking is *not* actual IOMMU dirty tracking. And that the
migration *only* goes/is-allowed automatically if either you have device dirty
page tracking or IOMMU dirty tracking, but not on type1 legacy dirty tracking ..
unless you force it (with enable-migration=on).

Imagine type1 dirty tracking actually getting treated like iommu_dirty_tracking:
it means you are telling users that 1TB guests migration with VFs that don't
have device dirty tracking without IOMMU HW can be migrated *by default*. And in
pratice that means they transfer 1TB of RAM during stop-copy. And have them like
1min downtime.

