Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208EEC3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURUs-0004lj-HO; Thu, 18 Jul 2024 09:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sURUl-0004WM-Iw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:48:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sURUg-0004b4-Nm
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:48:29 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IDeUR6005183;
 Thu, 18 Jul 2024 13:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=JtqkVPxvZHrP5eoOuk3ajcpVwmogvFZPrUVYysW37F0=; b=
 L8LI3pkGcqCF5YcnbZQIsqvDr+hU4vtGLXVjRXNavBbLJEVLRHp2/GPdVVHyPUQ4
 ZAoHnref4ZVMrFjFW0IjwSo18NB6kkKofX3pj7kJzq+Yjgr7Wq6SVMpqSeiUMVwN
 4VH+2EjClUvN00kciHFr4KCHUvj9+W4mJkJTymbK0MTE/9Fs56QfkyV1nvzo5GRb
 M5OtHBi+us5r8tEWyuLd5nC6FDl/mMtBOFAT44fSbEChJm1D7QeUyfivxOTa9i1a
 OLtO2nUWZ0sHyrxSQh+LkevuKrUCPIZWCuETk9QaxXSzRdmcavJcXVUaEjjSUdzG
 XQp5QyIpG4rKr9wafa5T3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40f44wg0t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2024 13:48:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46IC5sk3006705; Thu, 18 Jul 2024 13:48:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dweyxk09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2024 13:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA6ELSm5dSWj95zlPzgqD1fppmKdOMaeC8x8KksuhBA2/GJ4He4gF6HoXqqHqVq/5+kfZZYlB8fvtIWnbpThiD9SLXUp6mwlhKexVdUpdKLcoy6doXoY9JkMM83127OuQ6amGa8cPpssMp4pZkYKQ8v14sugLn7OyByoee+jnEYywRPGvshC2nonB1eSU4jVY78v94Wi3DAUNVTivyvqahpXjqPPaFeOnx9d348oPTd5C7vf2AFMlQYBo98ghonwMQC/r90eXthHkWQlT6qvPWRajeAGmN+zMj9GwyTNP4L3cOzvdGOxfdsd87eVtiEwsujSoBtgWl6AIAZXXp5Rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtqkVPxvZHrP5eoOuk3ajcpVwmogvFZPrUVYysW37F0=;
 b=nBSRgKCMoOgbViFApPZhcVDqyR8P2h3cAxkhMPfvsftRwqEZFBug+fQHQW+K5udgzV2ecVeHP6U1toWzoJgM/a+pCiepgQNrZ64Zg9JLqG+/fj2nRymi46s+15fSJ+bWp0qM6YBjMiP75D0uMu56re+5brP04hCIkFXF7kcapk1MiiUnnwGDf8tlaRlB3C/lJoX6pXNuUevfqzMP3RisLG3On/nL2H8TS+AaQJ/6w5ZKDKpe6HzDMLmCI9vKGggBBqMLvu9dWzH7VF9aNVos010nF9MH9aJ3DjHFjMTNOuLoo02VPGr8FlGkQMGzd6g/mH4qOxjeZUBV44DvmMls1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtqkVPxvZHrP5eoOuk3ajcpVwmogvFZPrUVYysW37F0=;
 b=EYsuqeMy0/vple0JAhCpQntxRyjL1s99ztsjg4u/gjtuMQh8avIEuznOO1JrqV7piZ1A9u0RQaSdKewAUaI6Jf6Rh9gpXhqVGnpcU3YAIB5gNxLWWTZCB40sSxPlnmlRhV+3evIWzQaPaVAZr1B4dNcbBISa4ItQU48842tmcnM=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MW4PR10MB5752.namprd10.prod.outlook.com (2603:10b6:303:18d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 13:48:14 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Thu, 18 Jul 2024
 13:48:14 +0000
Message-ID: <016301e4-2971-4186-9bc2-e69d2560cb11@oracle.com>
Date: Thu, 18 Jul 2024 14:47:39 +0100
Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
From: Joao Martins <joao.m.martins@oracle.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
 <f98463ba-32d1-4d9c-876c-715d0ca6ae3c@redhat.com>
 <befcbcfb-2ec4-4ec7-bd14-504c9363b3ca@oracle.com>
 <a67edbc5-68ce-4967-b8b9-a440904ed1b1@oracle.com>
 <SJ0PR11MB674475CA28136228FE93072A92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <6ce29c92-d9f8-413d-92f3-8a30e937f746@oracle.com>
 <2bffe255-f5ae-4004-aa64-e62ccf201464@redhat.com>
 <5f97ffc3-a7d2-4c4d-8420-112d1cf157c6@oracle.com>
Content-Language: en-US
In-Reply-To: <5f97ffc3-a7d2-4c4d-8420-112d1cf157c6@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::14) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MW4PR10MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd854c6-3311-4f2e-2919-08dca730453e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkRjbDNOTlJ6Z0NQYk9LU1ZKaXBobUs2UEVERkxKdlpTQk9VeDN1dHN3TzlB?=
 =?utf-8?B?L1YrNHpERkdYUkVmZGZRdDM5ZmJmTzZXMURnOXBRQnNJSE5GdXJsN0NmcmFq?=
 =?utf-8?B?RG8rb1BaQUdybXBJNXNTWWFrR3Zycm1NeUJRV1hWVkhFS1VRVnlEelcxV2dX?=
 =?utf-8?B?bWhGMVJYU25MTXJnVWE3eTIyWXFOMGFrcEtLQXBpbGpyN3NCeGlTK1BpNE9Q?=
 =?utf-8?B?TDVaUlVoTkUrZ29tK1dXZXV3TXd4MmYzSnRqcVpsK1VPUUovZXpOUFJyR3R2?=
 =?utf-8?B?WHBJeGc1bWE1QTVmOU51MnliaEdJMjRLaFY4RWh6S1I2QUEyNDNZd1FlMFA3?=
 =?utf-8?B?YWJhMGpGVEpabmd6WTZ2dUJyWGpRcWFTeXlUeVFqQTcxRmVTNXpzaVY1MTQ4?=
 =?utf-8?B?aHg4WmcxWG8vVGROdVdJcGhwVm1jT1VEVFdtTEdhdU91NGk1WXB4endndWVJ?=
 =?utf-8?B?TXIyZGNJUU1CNmwwbENybVhZQ21CZGRWYmRPZHpGNmdQUkhFam9kL0xDMmNl?=
 =?utf-8?B?enBGU2x6VFhobkZnVlh4K0JiUFpGdmVEMENwZ0NqTXdTRWxTVk0zOGRjTmMv?=
 =?utf-8?B?cGVOVmpRMldydVNpaVJvc3pXT1ZPV0Zqd1liZ3IxUUphbVNVQmt1Yk1PWW9Z?=
 =?utf-8?B?dk5sZUl4b0NoQW1rN0FCWmRUc1JrOElwQ2xlUXhzeE94a0Ixak1WdG5lcDN3?=
 =?utf-8?B?T1p0cTlQMUtBb2FISms2aktRUm9kdWJPWFBCcjZiSEdkSG15QXBnTXkwN1RK?=
 =?utf-8?B?ODZndWpWZDJxUzlHZ014eEVJYm5UNXQ0V3ZBYlN1L0I0Z3JNMlZyZlRleTQy?=
 =?utf-8?B?QU1adEpES0dhTFVhY3dRNnJaRklNRE9zVEovSHJIZ2NNd3hiRzAvR0NWZm9V?=
 =?utf-8?B?ZHowd3lNSmhVRjRxWm5uU0FWVzhscHY0WTFPcEwybXRkQjZ2cjBjdEVwWHJk?=
 =?utf-8?B?WXltQWFrSkUxYlF4OFVSeEdJMGtjczNQTXpQSXpJQi90ck1oZ2ErWDkwV2pn?=
 =?utf-8?B?Wlc5V3dCa0dpb2hjcm9MRnlRTGVoVUJ5VVA0Sm5BYW5ER05BTHVCQjJPVjFz?=
 =?utf-8?B?L0JBKzNGS3R3MFlmcU1WeTc1c3g5eXdETjZ5bUg0UEI1blcxSm9mTGpQTXB4?=
 =?utf-8?B?YWNpcWdZZGJLYWFtTm9KNkxpSXNlaDlKRDQreTdSbmxTbUFlWnVnbG80Vy9E?=
 =?utf-8?B?YlEyU0FwN0VON0tSYXhSVWttd2RRWmZrTEF5RFcxV2EwM09HSFJIaG5FL2o4?=
 =?utf-8?B?Z0JVUFZJUlRtZmtoVGtZazVHVFYxeURLN3hHZzFEUy83NFhBOTZlU3ZUYjlF?=
 =?utf-8?B?WHVNSzgwSWlaRmM3SHBTR2xnS1N1UDA3QnJrT21UZzh0bkpCZ2sxKzNhdEUx?=
 =?utf-8?B?d1k0djlNMGZERGVxeEF4T3B2VFpseHltMjhYZHdOV0pjUGxWR3VJQXI4d1l6?=
 =?utf-8?B?RXZmVThXQlRzcDEvSGtVOTFtWWpOYUxUMHRZOWJiSEE0WHVmTUNSZS91V0do?=
 =?utf-8?B?ZjBUMXRJN0tsSHV0eXZtMWNNcWUxMkdkL0lpVEx5bmhacmhuNWlNdDdiQXJH?=
 =?utf-8?B?SmExK3FzR1U4SFgwS1lGV09zZ0pSVGtpaHd1U2ZiMkxXaGVDdTd3cklRbVVs?=
 =?utf-8?B?c25BbWR0N0RvTEpQdDQrZXRISFlGVm5kblFCS3h1bndFdTZuMEU4aHVpcW1Q?=
 =?utf-8?B?RTBtT1pRSkVQU2ppdlh5RS84SHhrcnlydFNhUGZWZjVJMmdBdGlUcVN3OGxP?=
 =?utf-8?B?bFo4ZGVhTHN1T2Vnb2E3N1hKcjRzZ2Vzd1BzclRvdG1PbW50SWR1YzlHWStp?=
 =?utf-8?B?Nk9tVXhyeHR3WUFsYzVDQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1k2TFpTTk9wS1UySUtLenljUzg4aStiVXIxSVFxakNjTEE2SXdibXRCKzh5?=
 =?utf-8?B?MXdrYnJBcm9adG4zeVNMNXBBdU9HVFpTOW5KcnpxS0k0M3U2bzRkMWRCTjls?=
 =?utf-8?B?ckxLYk9ZSEowRUFMd3NHSk9BcGs3TUVEcFlnNjBqZ01pQkh4ajNRVXNQQ0p0?=
 =?utf-8?B?dEh2SlZ1OXA2ZHZGSFkxd2FpUWtsTmgrZGNubmNHZ3lZMmVxd0dNUmh4UHRu?=
 =?utf-8?B?eVlvYXI1RFZjaktabmQ3V3psSi85elRodk5TdTFnOGZ1RWJYNGFURDFNY0tH?=
 =?utf-8?B?b1E2ZTh1UlErM1lSRG9TSENYZUhxZXA5NDlYTjhlWncrd3BYQjNOK1FMbW1G?=
 =?utf-8?B?dEZRVTdPNG03cTFPcVNpQ3d1NldqYkRhWXFIQktvRjVEdWNLb0wxSVVrYThy?=
 =?utf-8?B?cUIvSUNKWTdDZ0NPUEtrczYzSUpJcUFBVjNKbmx6a2ZjTlh0bHpYdEJuR2tK?=
 =?utf-8?B?dmE3T2hxbll2WDRrdTNHNjM5TzRDSXJPcnlCOENlZ1BDaDdKWUpSK0JBRmQ2?=
 =?utf-8?B?WnI0WEdGNmRTWUpudytFd25RcVRJeE1DZk5TMS9Yb1ZZaEdyQ1RiMmhsTGFO?=
 =?utf-8?B?Lzl3MTJ3RU5sVmRoTks1VE9ucWQ5dE1SS1Rjb2VXTzBmQVQvdzVzdW41Qmkv?=
 =?utf-8?B?SDRKekRJSVhPak1JL2FqeFZ3UW1HZU9ibldUeEJHcTBOUHl0YkI5RjFjclhm?=
 =?utf-8?B?b2EyNEhEQ1VVT2phaDVMTnNhSHlpRnU1UElWWlBRZkg3OWVvSUZXTHRlL1Iy?=
 =?utf-8?B?TTdkdmlxTDF0dTg0aGpqSlVnbzhCSzdGWWRDVjkzMmVReFJvbkMvRS9xbDBO?=
 =?utf-8?B?d1pzRFpWRUZkeWdsa0dCSWxVaHVWcjJtWkJ5VzdWVkVDWmRNTG9pSThObmJO?=
 =?utf-8?B?aVBuamFpa3pRTjR4bjBka1liV1k2a3Q2UWVocFo1UStPK2pGejBSZWxscUhv?=
 =?utf-8?B?QWhNNVFvenF6bjhHZ2RrOGltLys3YTJrejBXSGVMcnFlVFE4L0RQejZvb1pt?=
 =?utf-8?B?TUtpSnlsV0NkbDB6U2l6MDZzK294OW1MRmxBN0JaR1RURE1rTlZaZXJTd2ZG?=
 =?utf-8?B?dVozVUYzTUdHWFpYNmNYZUQwdENsSURTTCtLMWsycEZSb0dWdEEzQXdMZ0tu?=
 =?utf-8?B?cFdtWTErZTlSQUw4RnVJc1FHN2RoRlhDNzllWjVUblFJMzFHU3VQR1prWTFH?=
 =?utf-8?B?MXlpRkF5RExIL0o5VlJseUZQMEVnRkZUV0IzRktRMWIvR2lLS2FLMVUvc2h0?=
 =?utf-8?B?QXVsNHM0c0xNbzg2SCs4RUF3dFd3ek83MDhnOWFYU0l4ZkpxTTVLZ3daa2hh?=
 =?utf-8?B?a0dxZjUyRTJodnVBMm1oY1Y4ZXNXZHF5ajhBVmkrRStXa0kyeDhvV1J6a2xi?=
 =?utf-8?B?eUhkNVVzZGl5MFZrUW5mMU1DREs4YnVNT1RyYVRsLzZQK1d3YVp1N2h0ZDk3?=
 =?utf-8?B?SSt0MDQrb3oyWEE3OHo1VGQ2WDVtb1BhY3hEY3NYMlVEa2dScE56aUVKc3c2?=
 =?utf-8?B?NGl6L2JERk5FdXg3WnhLNXRua05ybFdudmRaWmVtOXBZQkZPWURBNkRldmpu?=
 =?utf-8?B?enZPZ29aQWhPVlB2UGkyRFRBUnhueWRVSUoyQlZkWFNJaHVuOVJlNjNaeXNB?=
 =?utf-8?B?ck9Zek0zcUdFNG9Pb09EYkNKeEk5cUZJdGxnNG4vQnJJdzV4V0RYWUp2Z0RW?=
 =?utf-8?B?U1hmVkxaM25vT2dSa0NmVzJ6ekZBT2JiVlU1aFE5L3N4aCtCeDF0bThrTTlr?=
 =?utf-8?B?Yys3SitBQy9WSElyczFlWnRqLzFiOGxFMDEzZWhkMlpOTnF6MGN4cS85UlEr?=
 =?utf-8?B?NmlTL3kyRnFNeFBuVW5ZUzFTSGlQc09vRUx5QmYya2FIUkNYbEhRSG9YL2FS?=
 =?utf-8?B?eE41eVBaOGhCb1gzb091NDJSa1dvSHFFakVNbm5STVEva2NBYW95ZUx6bHB0?=
 =?utf-8?B?TkJRVENscUZkYnBtZnRUK2x1L3ZWL0J2Q3N1L0hUaGc1bFRDSWJHdUEwSTJt?=
 =?utf-8?B?amREVWhId29LdTF3ay9xSmVETysyYlRRUnNmMFlsQm40Vkl4d25JODJqNkRN?=
 =?utf-8?B?TndUc09JZUNqT1hwYlVTL1JzNWpkTDlpZzJnYU5VNGIvQlhCRXpsWkVOdXFm?=
 =?utf-8?B?TEZzQ3hnUVM4bXNhZVFjQUhldU5BNVAwZzRpaSt6UFZlVExSY0VMNGJvZ0cv?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h7ICKorwtZAL3TM/I6QOt9Gebm0lUCaAgl/fzLm13aO0klrP8igTNxqRyNbNSy3JmsGdw1aymb1dn4Nx78kRaha6K1FoXB42bTzDCDZudzmdvIdZO2HNecSUqU9FxCbb8mvOSL6cCQg19/MBhMVLz6Cgi/rp8h82jB4StLBfJKZhPQn7AVE9OgUq/YlfP6HT4SsJgidW5wIPoovBTGlYWYnGLPsyAVDkxLIZ9A1P2Fy0rGR4OgTqv0yxKWz91blAmK6aRRymNf4NLTSeyGeTSEnDNkzyC8PrnkCyoMKKhuFuo+9g6WoH5rvHp+nq52EkraZKYuQ6zQ+4X1FG4vID7AQqOTGBBmHNt+mwBJ1yMFYKKzwLOPbQBsvBd4h8qx15/iQqR4L1/5pu9LimJTYvbPtM+cPvLYkRStF/a7GMATBn7VAikbgomqPffEsYOfbGilxPM8DNNFYav8dBDDBd/5jhakUJ6/8nSd4to1lHAZoJrwlBvPH+uR4ObD49zdn9fZ2238bVZg0kGp4EvrYhtdLNDtc4t488igxzkiR65eF+53DELr8nrDG33MK3QRE1SP10tY4EmWRSb/sSlgdHL+05hwBiUNHpfPMSV3iptsA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd854c6-3311-4f2e-2919-08dca730453e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 13:48:14.4690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+0BS9P6EwAT7fTJDyYhNRIk98i6cFXhjTNffsOb6CoPxSxon5rxvQ4jGc8kwhkrGiIqnsPLbh/ZhlC8+ITzCqWJRq0iko0+qwaYu2zXd78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_09,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407180093
X-Proofpoint-ORIG-GUID: 2QdqZ-SvmERfnDxED_vnyXzL343AQfVa
X-Proofpoint-GUID: 2QdqZ-SvmERfnDxED_vnyXzL343AQfVa
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

On 17/07/2024 10:31, Joao Martins wrote:
> On 17/07/2024 10:28, Cédric Le Goater wrote:
>>>>>>>> @@ -224,6 +300,11 @@ static void
>>>>> iommufd_cdev_detach_container(VFIODevice *vbasedev,
>>>>>>>>   {
>>>>>>>>       Error *err = NULL;
>>>>>>>>
>>>>>>>> +    if (vbasedev->hwpt) {
>>>>>>>> +        iommufd_cdev_autodomains_put(vbasedev, container);
>>>>>>>> +        return;
>>>>>>> Where do we detach the device from the hwpt?
>>>>>>>
>>>>>> In iommufd_backend_free_id() for auto domains
>>>>>>
>>>>>
>>>>> to clarify here I meant *userspace* auto domains
>>>>>
>>>>> *kernel* auto domains (mdev) goes via DETACH_IOMMUFD_PT
>>>>
>>>> If the device is still attached to the hwpt, will iommufd_backend_free_id()
>>>> succeed?
>>>> Have you tried the hot unplug?
>>>>
>>>
>>> I have but I didn't see any errors. But I will check again for v5 as it could
>>> also be my oversight.
>>>
>>> I was thinking about Eric's remark overnight and I think what I am doing is not
>>> correct regardless of the above.
>>>
>>> I should be calling DETACH_IOMMUFD_PT pairing with ATTACH_IOMMUFD_PT, and the
>>> iommufd_backend_free_id() is to drop the final reference pairing with
>>> alloc_hwpt() when the device list is empty i.e. when there's no more devices in
>>> that vdev::hwpt.
>>>
>>> DETACH_IOMMUFD_PT decrement the hwpt refcount and it doesn't differentiate
>>> between auto domains vs manual domains.
>>>
>>> The code is already there anyhow it just has the order of
>>> iommufd_cdev_autodomains_put vs detach invocation reversed; I'll fix that for
>>> next version.
>>
>> While at it, could you please move these routines :
>>
>>   iommufd_cdev_detach_ioas_hwpt
>>   iommufd_cdev_attach_ioas_hwpt
>>  
>> under backends/iommufd.c ? I think that's where they belong.
> 
> OK

At the first glance I thought this was a good idea. But these functions while
they attach an IOMMUFD they do not really talk to an IOMMUFD backend, but to a
VFIO device file descriptor. Now I think they are in the right place here and we
would leave IOMMUFD uAPI things to backends/iommufd and VFIO APIs in hw/vfio/.

It also uses a lot of VFIODevice* which requires some funny includes in
sysemu/iommufd.h.

Do you still want me to go ahead with it? Here's a snip below of the change
involved:

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 2b3d51af26d2..19d1e430ef48 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -20,6 +20,7 @@
 #include "trace.h"
 #include <sys/ioctl.h>
 #include <linux/iommufd.h>
+#include <linux/vfio.h>

 static void iommufd_backend_init(Object *obj)
 {
@@ -232,6 +233,46 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be,
uint32_t devid,
     return true;
 }

+int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
+                                  Error **errp)
+{
+    int iommufd = vbasedev->iommufd->fd;
+    struct vfio_device_attach_iommufd_pt attach_data = {
+        .argsz = sizeof(attach_data),
+        .flags = 0,
+        .pt_id = id,
+    };
+
+    /* Attach device to an IOAS or hwpt within iommufd */
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data)) {
+        error_setg_errno(errp, errno,
+                         "[iommufd=%d] error attach %s (%d) to id=%d",
+                         iommufd, vbasedev->name, vbasedev->fd, id);
+        return -errno;
+    }
+
+    trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
+                                        vbasedev->fd, id);
+    return 0;
+}
+
+bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
+{
+    int iommufd = vbasedev->iommufd->fd;
+    struct vfio_device_detach_iommufd_pt detach_data = {
+        .argsz = sizeof(detach_data),
+        .flags = 0,
+    };
+
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)) {
+        error_setg_errno(errp, errno, "detach %s failed", vbasedev->name);
+        return false;
+    }
+
+    trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name);
+    return true;
+}
+
 static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
 {
     HostIOMMUDeviceCaps *caps = &hiod->caps;
diff --git a/backends/trace-events b/backends/trace-events
index 211e6f374adc..2fee8e0af20e 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -15,3 +15,5 @@ iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t
ioas, uint64_t iova, u
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t
size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" s
ize=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
+iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int id)
" [iommufd=%d] Successfully attached device %s (%d)
to id=%d"
+iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d]
Successfully detached %s"
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 077dea8f1b64..5a6d56c915e2 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -172,46 +172,6 @@ out:
     return ret;
 }

-static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
-                                         Error **errp)
-{
-    int iommufd = vbasedev->iommufd->fd;
-    struct vfio_device_attach_iommufd_pt attach_data = {
-        .argsz = sizeof(attach_data),
-        .flags = 0,
-        .pt_id = id,
-    };
-
-    /* Attach device to an IOAS or hwpt within iommufd */
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data)) {
-        error_setg_errno(errp, errno,
-                         "[iommufd=%d] error attach %s (%d) to id=%d",
-                         iommufd, vbasedev->name, vbasedev->fd, id);
-        return -errno;
-    }
-
-    trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
-                                        vbasedev->fd, id);
-    return 0;
-}
-
-static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
-{
-    int iommufd = vbasedev->iommufd->fd;
-    struct vfio_device_detach_iommufd_pt detach_data = {
-        .argsz = sizeof(detach_data),
-        .flags = 0,
-    };
-
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)) {
-        error_setg_errno(errp, errno, "detach %s failed", vbasedev->name);
-        return false;
-    }
-
-    trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name);
-    return true;
-}
-
 static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
                                           VFIOIOMMUFDContainer *container,
                                           Error **errp)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e16179b507ed..24fde6270112 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -170,8 +170,6 @@ vfio_vmstate_change_prepare(const char *name, int running,
const char *reason, c

 iommufd_cdev_connect_and_bind(int iommufd, const char *name, int devfd, int
devid) " [iommufd=%d] Successfully bound device %s (fd=%
d): output devid=%d"
 iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=%d)"
-iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int id)
" [iommufd=%d] Successfully attached device %s (%d)
to id=%d"
-iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d]
Successfully detached %s"
 iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD
container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions,
int flags) " %s (%d) num_irqs=%d num_regions=%d flags
=%d"
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 57d502a1c79a..89780669118f 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -18,6 +18,8 @@
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
 #include "sysemu/host_iommu_device.h"
+#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-container-base.h"

 #define TYPE_IOMMUFD_BACKEND "iommufd"
 OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
@@ -51,5 +53,9 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be,
uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      uint64_t *caps, Error **errp);

+bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp);
+int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
+                                  Error **errp);
+
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 #endif



