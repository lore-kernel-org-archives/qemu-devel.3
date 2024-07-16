Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F276EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlIu-0003EI-5D; Tue, 16 Jul 2024 12:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTlIn-0002y7-2P
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:45:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTlIg-0001uz-Uj
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:45:20 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GFMUlK029958;
 Tue, 16 Jul 2024 16:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=Lu670YdnlgBZSdzkjE8O+XKsQ25Cuc4sZ3z//m4tFYc=; b=
 ilyHSvESUugYVmRYabyD318fC+ltH+MKMkzyyHu/oQzWVH3AP7OKVzicFsItFotJ
 rkolIMQoxy6VMmBet74LFP+XAxjA6iBWBXxbiC2p9UrVAkYFjzK0R02OGk+wxIP+
 zbcQVjroIMvV0Q7B+Bv6Z6Yy6CtCDRwNQYZ9MxQ9j3VWbBDN7InBg+hHoOHNCvKS
 7j/we3L4o0VHXJ5DE4Osk7qVwvCL9JodPLp8KkNUtlCwddxXPnaZva4db/PI8o7r
 h+Ho16TyehPStlBXtiNH3sooZfxi4dcuN3MAEvsoukynf2hy1tv3WWHSgysRWwfl
 KhJs05N8kqH35q5vU19PwQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bhmcp5h1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 16:45:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46GFop5r038908; Tue, 16 Jul 2024 16:45:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40bg19sa31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 16:45:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsunmEekbwzbS0ETf/DgFdVmD8GvJnBgo0LbwR9N8/V7iXxr+tN64QwUW0rzrXAIfB2etGINKPZhFBCBrwwouPauYOwry03zOCEpHwWpt3do1b36IxybreBUm90P5Yo4pGJVMiRqCdl/kPcNhkiGtSpzfUuISFhreT4e1NBdazXEKPNM82kSIcFT32/+610OUzDdxhjhKMbbzLgfVlh7NDjfbVvQaeR1Hmr3+1XqAt9qx0srZjlfnmweIoWniFdGatUhzZMElub9oKT1Xh3XHUCu1sjqSUX11BztwDBEbFTET2/UPlVZoYk+6sz8r1aiftxJHpj1uOyuNdZ4QIaCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu670YdnlgBZSdzkjE8O+XKsQ25Cuc4sZ3z//m4tFYc=;
 b=xRO9VYieZ+pgTjZIi7YWrbYNYFjUxWUCDMwptlPqIAxghjqTEUsP6CfvnoBbFvAuEi0OU/u/4iSZZ/Opv0daeQZzk8Xeyf2EeO4vWZDryFmx9cn3uof9JVcKG+hEmxxNIzz39X3PFCWzGFXs8i7Vvb91weNr5UUDTpPzSNiWbbdYICslNCR94MFwDdyxzmhQAyA8OK1kjvjDZSfOQz2IsSS5WRqGi3xLO/t+YDn+UUbv8XTmzdbBOWaXIN9rkPaZi4V8zP74R9JEzwysDEu2+bK9MkZYKS14o3gJd3gXdTT+Qew6DJv6yxX8igPeNdkEpsVYt9nzG1zt8FQpwXFsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu670YdnlgBZSdzkjE8O+XKsQ25Cuc4sZ3z//m4tFYc=;
 b=psHIqmTvofsZifR+bZc+cXzCYDoAxyPIeoeViBb6toZdvxRyvb0hhj/czbEjFDHEQKs6wrMRRM59yUSYBFzJaFhdkyDddy3bHDfLZm0hlTgwhOveL1aAwUoUY1fhq62jXWEO8UMXIT0482zD3s935u5IT2xK1DVP2Qa+VBVQ/9g=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS7PR10MB5973.namprd10.prod.outlook.com (2603:10b6:8:9f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Tue, 16 Jul
 2024 16:45:06 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 16 Jul 2024
 16:45:06 +0000
Message-ID: <befcbcfb-2ec4-4ec7-bd14-504c9363b3ca@oracle.com>
Date: Tue, 16 Jul 2024 17:44:57 +0100
Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
 <f98463ba-32d1-4d9c-876c-715d0ca6ae3c@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <f98463ba-32d1-4d9c-876c-715d0ca6ae3c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0207.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::14) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS7PR10MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: b5678aad-944b-43ec-37d9-08dca5b6a57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm5jK0FRbVYzV2owZDNrRDJMRDE0THdKUmJubmcwaFNPMDVNYUlQOENiS003?=
 =?utf-8?B?V3ZKUENXRWcrTHJQVjYvVGtiZ3dCV3Y2UEd3RFYrWS8zWWhqL2Fycm1VdmZS?=
 =?utf-8?B?OERGNXFsSTMvRkNTb0cvRDljL2hudnNSRXl4eGljbzY0TWZmbmhxU0wwNWlH?=
 =?utf-8?B?bmlBQmVEQ0tHZUpHRXhUdHlaT2hFWmsxWDQ0Q0VPYkVmeDJJMERtWVNOMjE0?=
 =?utf-8?B?OE5pR1NzUVhxenFaYm83b01PZ1JxQVY2MHZRcVY4SG1LWDRSMXk5MTg2S0th?=
 =?utf-8?B?azVZbjN3OGFEd2ZhSHVqMEx0ZHNPbTVZL1g2WDZNZEJueWRNK1Zpa2NaaGVx?=
 =?utf-8?B?YmRRdDQ0bWtvRE51S2xmQjlPU3lTM1NXb3VxYXA4R3F3eVZROVVRTnJKa2xp?=
 =?utf-8?B?aWM4VGhxNnhzWjlZTkR2aVhyVldrOU55Z1NHNDdTZFVXdU9sK2xGcDdlZXha?=
 =?utf-8?B?YkVsR1pYTTlySXA1Ty9HOTRySmFDZmlJZEVVRGEzeU9wamFpeDk3WnQ4UTFZ?=
 =?utf-8?B?dW1sWDhhNDF5a0Y5bU1WTU9uUzI2TWU3Vm9ibnBEUkhWTnI2QUkvTGpYMVFX?=
 =?utf-8?B?MHlhVlRtdXNwSllKeHl0K1kvQkpYakdKbHQxRXBzR0VzdmtxZlRHdkswYlR1?=
 =?utf-8?B?T053UjdvVmMrZE1GdVdiNkJGc1FSZzdiNFVRSjd6bkpxZzBseS9HWU12bm9n?=
 =?utf-8?B?dWR4WjlQbDhrY1VjRGZJdWcwTUtRUHhEWmVablJmbmR4NGRMSFhXUEdmaFp6?=
 =?utf-8?B?VlNjUWQ2YVQ0RW5RR2U0U3FGcGI1amZqSjlBREhMcWZOekUvTDZBOW05VXhw?=
 =?utf-8?B?OGpSMWpCcFNhcTYrOVdZbmQvQ2FjSkdnYmM3cFd3K1B0cmNGU1hjNUljR0cr?=
 =?utf-8?B?VmUvODVFNG9DM1dSVnBudnZwaUdObytIdDBFNW16bXh2Y2l1S0p3K1dnMnl3?=
 =?utf-8?B?Smt2S3BNN3NNVkpvWU1iY1FhQ1Z4SzRIWUNUR1ZOOENLZWgxKzM1M0ZkRitL?=
 =?utf-8?B?bFQwSm5IR2N5N3ZQRDR3UDJTZmFNd1k1YUFNWXoxMnZ5U1hES2RvbjdDREJu?=
 =?utf-8?B?WEhxVkdINnNTZFpnL04xK3JFVjZaOHhKTkY2RzlOSjVSQXRybGhYanBpb0Fx?=
 =?utf-8?B?WEVSM2s3VWJuRTVHR2pKTnVVMG1ueDRJM0FOTUtUNElxdXhnR3VBaEYyZkZO?=
 =?utf-8?B?MllHMmM4c3JBUjQzUm5TMTFSajFEcUFOU2x2aGNJS3ZsTm5SeDd4bkNXV1Vv?=
 =?utf-8?B?YkovbmdaU0RjK1h2QWxMNjEwNlBvWHZuTjFKd2dKcFB5S08vZEcvQ2dRWkI2?=
 =?utf-8?B?MHRBaUhXRzRZMi9MY1JUamY4ZjE1WHBDRVMwZlJ2Sm9sbXRiSklZc0pLVHdp?=
 =?utf-8?B?c2trSHhuOUk1ZzBWbnlZa2VrSWtNQmx6dmhhamRJNWNMMkxEWE53Y054cjV6?=
 =?utf-8?B?T2pVc0xvdUtGVUxvOFhrTE80YTMwT0hnNzkvMVkrcStkN3l0Q1l0MnJvNFNx?=
 =?utf-8?B?Zjl4TE5LZkpkNkNadlYvZFBIZHAzY01TcGlXT3lqMGkrQmRFdzFoUmN6Tjkz?=
 =?utf-8?B?ejlvQjk1a0NwOWdqQ0JqTUhZSDhlM2lFK0NWWk45eFM2UUl0SDNBNVJld0Nw?=
 =?utf-8?B?ZDJ0a1pXd0F4TksyMzQ2OTVOUVNINXk5UGRTNWVLa3RtM0gzclJvaDdjekFr?=
 =?utf-8?B?YUV3NTJhUWFnbHYxd2kvZzVOTmM0RlhxMFlaSmJBRnZGS2g5T2NDS2pZNWZG?=
 =?utf-8?B?c1pRQnVVVHZUR1hOYTdsRkFKTUFuZkRDRlZkSlozQVNqbk9qc1EwQzdQWCtY?=
 =?utf-8?B?MFpQODlSQk40bHBHbFJQZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkRidUdkTVp4QmcycWtKK1RmZ0NYeGcxUXhZak1QSzJmbTIzRkl4cTJPc1RC?=
 =?utf-8?B?WUxlU1BiUFdHb3d2a2Y4WDlzeS9xU3l6Wlc3aDlWLy8xMFZjNjV4dzNPQ3pp?=
 =?utf-8?B?MkpWejdUOVhpWnhpNTNzSXJtMC9pOE1QaHkwRlRwOU9YTXJaY0VNMDVFYXJE?=
 =?utf-8?B?WDZoNFN6U0dOQk9JUGlqeVQ5WUdDbi9TeWtDTUdGK3EzbkF2WUNPbEdJakk1?=
 =?utf-8?B?MjR2ZXVlOFFJNkhoeVFKaXFsb1pYL3BWUEtRWWJiaFJmSnNWSnBFZVdjdUFJ?=
 =?utf-8?B?NGptYklPcFJTMVFkVWdUWlhYblBVZE9IeHBxaVl3d0FneUhqaTFuNmJxM1FR?=
 =?utf-8?B?THNKa2w4TkZmYzVNdkVZSFlHdEw2T2Qza01QTTNpR0toNWR4MmdNbTFwUG00?=
 =?utf-8?B?VHMvTTJpL1BJSUhETWJxYzhXTS9pdDRsWDg3ZTZGRnpQU28xV2g4WitBL3Qz?=
 =?utf-8?B?ckFvWTYwWm5KclB6YWgvNjN0QjgyeGRnZitOcHhIU2IxdFNvNjJBTnFBME5p?=
 =?utf-8?B?SFpUYWFtSlR2Ymw3VU0xOXBGbFdSU2JXUklCMGFJelJhdUI5MEpiRkkxNVlr?=
 =?utf-8?B?YWxIbVFHci9UYjhmekJQcE9UdkpvaXJjbll3NVUyWmJhYVQ1YTFFYURyVzRW?=
 =?utf-8?B?N01nWWZwVzZQc1RzaGdxRVdQTC9QY2JWeElTTVBtODZ2b0kwUEhRYlBBTGxH?=
 =?utf-8?B?bUxsUjl1S25iUkxxRExEUGxvaXU0NEwwaWQwbkdjWU1JQVBtNS9OcjhWYlVX?=
 =?utf-8?B?aElGcDdUdExPZXkvL1VNSnF5dDZFME9pOEdKNFFYZWpkdDkyQXZQQllhUHJ4?=
 =?utf-8?B?RG82c2RScndGZ0N3RzVKQzMxZXFnb3JoWkxHV3JvNWMwWGZYb2sxU1VXV0gy?=
 =?utf-8?B?VnZPTW1vb2lIM09Ea2J2dzFZVkppNGVRckorVUxJTnZaZGxiUE5yanY3am9T?=
 =?utf-8?B?dW0wUWxHVjBHaXQ0NWNzMWFoeVBWZnVFUE5uc2ZHeFpSbU14NWtIeUd0dkhz?=
 =?utf-8?B?WnlpbWRPbWNMUHc0ejZKT1QwL3JjRFBwZFlHWmlqRW1BdG9wMHA5UkxZb0ho?=
 =?utf-8?B?R1Fpb0xRL2N0dTBDZjdRVHlGM2hRam1EcHRkaERjeWVtOERVdUovM2d5S0tH?=
 =?utf-8?B?TGd2azQ5UVkrNjBXV2tmU0JCcXpVOElPSmNGcVQzbHQ3UGx0ZEJQQ2p5NUd1?=
 =?utf-8?B?L25Zdm9DVERPWmx4VzFBYUxxR1pLK0grWnM5RWpuV2hxSVpnY1VweG44UFRr?=
 =?utf-8?B?TmMvNmlaK0R5NVZTYWxZeDEwUDR0UVZLM3FLY3dLa3dIVE1jVktPQy9hVHhS?=
 =?utf-8?B?ZG9MVkNFck9YalB3WGNLK3h6a0ZUNldQVzc3M3lOY3JFZmVpOHdRL0owY2pZ?=
 =?utf-8?B?WVhhd3ZKSEdVZEZCdTZ4ZVRNWU5sQ0ZLbDBpS0xFYUo5Q0JZMlpIWUNrS0dL?=
 =?utf-8?B?Y01iRFYxWFZ0VDNkcE1RSTU1aWZKUVZOMm1CUHp2ZVRXMEVNYmZ1Njd0Q1NI?=
 =?utf-8?B?bjhPYjVLdFoxU01rUyt2bkQwZ3l0OUVIRnA1bkN2QnhPbVd3YmdTVmJTY2lJ?=
 =?utf-8?B?aGlvMHdwRzdBUDdFbWVkMFhYZWtEb3lZb2lMMkZ6dXR3SXhQRTBDcUdvbUs1?=
 =?utf-8?B?Mm5EV3NHTjduOUxWckZ3dDhybjhxeVBFbFh4OE1McjZqVnhwOHlNYWU3Y3pL?=
 =?utf-8?B?ODNFdzVGdjJZUi81d2lnSDdNQzdQOEJ0cjNwUHgvb2wrNVo2cVlhQi9QUGZR?=
 =?utf-8?B?Z1p5bFNoVEpXVkIrQUxLNTAzamFVUHcvM3Q4Qk5PbUdDR3RBRmRBdlJEalV4?=
 =?utf-8?B?WHZCeWxOUm9ZS1JTdlNVN1loa2NHeU5pSWxad0ZOQlBSbzZCVjRHZXpZTTRY?=
 =?utf-8?B?bTFlSzRXaVRrUUdCbU5HbnRlUWNHTzd5WGEyaTBOV3RrdDNzRXpwUVV1U0xE?=
 =?utf-8?B?SHgraDJWQ2RnWEdHOU1wK0cwVnVZRzJTd3pHK250eEcrb0F0YytkYnB6Uzl4?=
 =?utf-8?B?YjIvSWtlUzBpbHg2aE1CWHVxbC9GcVo3TTBHY2ROd3JWbHBHL255ZXJFTWw4?=
 =?utf-8?B?K2JpbUtrOXNOckxCeDRYeWRMZFUrWC9ZdGh6akhrNmpUSVJnVzQ1dEc4QzB0?=
 =?utf-8?B?a2JQd2JoUmw0Z2NjOFJKcHFRa3BrTmhtazgzU1lBQ0lPa2xmUW8xcjg4bGJq?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QWM+hXxGRD7AQnditb0ln5DeP+h/KVuXJ6eJ8VcCR1xb4uW8MzV+c1KWpJmMv8E1/Yf2wdm9TjiEgDJKHCi/CVWDQLX6PhBaXr9xYrdya608jGfmoLSdqSYktaAZg7G0d601J4hVNq9bF/gmBChArKmtbn/t77SC/01fY+fv8bBRO/M6dfFkb+3q//PSPHAHtOB9ctvYB8t2X2Kxwb5uyI2ZpwPDqRuNwkb98eUsXfyudEDlCDgHd6LjuFoI5joX10+sXqEx9ooTLK7jGeBqLdc35G36Ue3MAlD6KMkigj3YTsUk/fxwdKEHnAns4qJt3IiIYCp4vrAA0u+hdw39q5OOAabBweu+9jPItqwNqmoYD7sjq3nxuuWFIGapAAFXl5bI8qGP3HQJP7QSMgIzVa6ZR7/TOLWCz3/Nx65Cf4KHebWAVDY8+a3vObVU10zC9qTaFaV343r/qPoQ8t7T+57ndTaJ9+wIW+EZXbWZQj0gR8exbLoqqhQBKTMgkMRQfpvDHAg47RRmPAQMaEBur626UWSFhpiJHnHs18lHP1c5e0vT4VDjvQNbXTT+9XRF2bVwVItqiAmU3klsPnYEGLK0pbqhVbQLvCsVt0H3aqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5678aad-944b-43ec-37d9-08dca5b6a57f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 16:45:06.1573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQgdr9ZOcjrZb8xLQ63US/vw0mEVutcyyQ2mRFFUbPhDZuleI9bZXKXARMdkQ4C4T+6qTkIp0nDmz9EL64D0/Zq7rC8UZni7o9LfGl6tqCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407160124
X-Proofpoint-GUID: -iS2gzKv7O3KGKmGitWmgAY5cezFJg_r
X-Proofpoint-ORIG-GUID: -iS2gzKv7O3KGKmGitWmgAY5cezFJg_r
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16/07/2024 17:04, Eric Auger wrote:
> Hi Joao,
> 
> On 7/12/24 13:46, Joao Martins wrote:
>> There's generally two modes of operation for IOMMUFD:
>>
>> * The simple user API which intends to perform relatively simple things
>> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
> 
> It generally creates? can you explicit what is "it"
> 
'It' here refers to the process/API-user

> I am confused by this automatic terminology again (not your fault). the doc says:
> "
> 
>   *
> 
>     Automatic domain - refers to an iommu domain created automatically
>     when attaching a device to an IOAS object. This is compatible to the
>     semantics of VFIO type1.
> 
>   *
> 
>     Manual domain - refers to an iommu domain designated by the user as
>     the target pagetable to be attached to by a device. Though currently
>     there are no uAPIs to directly create such domain, the datastructure
>     and algorithms are ready for handling that use case.
> 
> "
> 
> 
> in 1) the device is attached to the ioas id (using the auto domain if I am not wrong)
> Here you attach to an hwpt id. Isn't it a manual domain?
>

Correct.

The 'auto domains' generally refers to the kernel-equivalent own automatic
attaching to a new pagetable.

Here I call 'auto domains' in the userspace version too because we are doing the
exact same but from userspace, using the manual API in IOMMUFD.

>> and mainly performs IOAS_MAP and UNMAP.
>>
>> * The native IOMMUFD API where you have fine grained control of the
>> IOMMU domain and model it accordingly. This is where most new feature
>> are being steered to.
>>
>> For dirty tracking 2) is required, as it needs to ensure that
>> the stage-2/parent IOMMU domain will only attach devices
>> that support dirty tracking (so far it is all homogeneous in x86, likely
>> not the case for smmuv3). Such invariant on dirty tracking provides a
>> useful guarantee to VMMs that will refuse incompatible device
>> attachments for IOMMU domains.
>>
>> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>> responsible for creating an IOMMU domain. This is contrast to the
>> 'simple API' where the IOMMU domain is created by IOMMUFD automatically
>> when it attaches to VFIO (usually referred as autodomains) but it has
>> the needed handling for mdevs.
>>
>> To support dirty tracking with the advanced IOMMUFD API, it needs
>> similar logic, where IOMMU domains are created and devices attached to
>> compatible domains. Essentially mimmicing kernel
>> iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU domain
>> it falls back to IOAS attach.
>>
>> The auto domain logic allows different IOMMU domains to be created when
>> DMA dirty tracking is not desired (and VF can provide it), and others where
>> it is. Here is not used in this way here given how VFIODevice migration
> 
> Here is not used in this way here ?
> 

I meant, 'Here it is not used in this way given (...)'

>> state is initialized after the device attachment. But such mixed mode of
>> IOMMU dirty tracking + device dirty tracking is an improvement that can
>> be added on. Keep the 'all of nothing' of type1 approach that we have
>> been using so far between container vs device dirty tracking.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  include/hw/vfio/vfio-common.h |  9 ++++
>>  include/sysemu/iommufd.h      |  5 +++
>>  backends/iommufd.c            | 30 +++++++++++++
>>  hw/vfio/iommufd.c             | 82 +++++++++++++++++++++++++++++++++++
>>  backends/trace-events         |  1 +
>>  5 files changed, 127 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 7419466bca92..2dd468ce3c02 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>>  
>>  typedef struct IOMMUFDBackend IOMMUFDBackend;
>>  
>> +typedef struct VFIOIOASHwpt {
>> +    uint32_t hwpt_id;
>> +    QLIST_HEAD(, VFIODevice) device_list;
>> +    QLIST_ENTRY(VFIOIOASHwpt) next;
>> +} VFIOIOASHwpt;
>> +
>>  typedef struct VFIOIOMMUFDContainer {
>>      VFIOContainerBase bcontainer;
>>      IOMMUFDBackend *be;
>>      uint32_t ioas_id;
>> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>  } VFIOIOMMUFDContainer;
>>  
>>  OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
>> @@ -135,6 +142,8 @@ typedef struct VFIODevice {
>>      HostIOMMUDevice *hiod;
>>      int devid;
>>      IOMMUFDBackend *iommufd;
>> +    VFIOIOASHwpt *hwpt;
>> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>>  } VFIODevice;
>>  
>>  struct VFIODeviceOps {
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index 57d502a1c79a..e917e7591d05 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -50,6 +50,11 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>                                       uint32_t *type, void *data, uint32_t len,
>>                                       uint64_t *caps, Error **errp);
>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>> +                                uint32_t pt_id, uint32_t flags,
>> +                                uint32_t data_type, uint32_t data_len,
>> +                                void *data_ptr, uint32_t *out_hwpt,
>> +                                Error **errp);
>>  
>>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>  #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 2b3d51af26d2..5d3dfa917415 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -208,6 +208,36 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>      return ret;
>>  }
>>  
>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>> +                                uint32_t pt_id, uint32_t flags,
>> +                                uint32_t data_type, uint32_t data_len,
>> +                                void *data_ptr, uint32_t *out_hwpt,
>> +                                Error **errp)
>> +{
>> +    int ret, fd = be->fd;
>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>> +        .size = sizeof(struct iommu_hwpt_alloc),
>> +        .flags = flags,
>> +        .dev_id = dev_id,
>> +        .pt_id = pt_id,
>> +        .data_type = data_type,
>> +        .data_len = data_len,
>> +        .data_uptr = (uint64_t)data_ptr,
>> +    };
>> +
>> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
>> +                                     data_len, (uint64_t)data_ptr,
>> +                                     alloc_hwpt.out_hwpt_id, ret);
>> +    if (ret) {
>> +        error_setg_errno(errp, errno, "Failed to allocate hwpt");
>> +        return false;
>> +    }
>> +
>> +    *out_hwpt = alloc_hwpt.out_hwpt_id;
>> +    return true;
>> +}
>> +
>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>                                       uint32_t *type, void *data, uint32_t len,
>>                                       uint64_t *caps, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 077dea8f1b64..325c7598d5a1 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -212,10 +212,86 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>      return true;
>>  }
>>  
>> +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>> +                                         VFIOIOMMUFDContainer *container,
>> +                                         Error **errp)
>> +{
>> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>> +    uint32_t flags = 0;
>> +    VFIOIOASHwpt *hwpt;
>> +    uint32_t hwpt_id;
>> +    int ret;
>> +
>> +    /* Try to find a domain */
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>> +        if (ret) {
>> +            /* -EINVAL means the domain is incompatible with the device. */
>> +            if (ret == -EINVAL) {
>> +                /*
>> +                 * It is an expected failure and it just means we will try
>> +                 * another domain, or create one if no existing compatible
>> +                 * domain is found. Hence why the error is discarded below.
>> +                 */
>> +                error_free(*errp);
>> +                *errp = NULL;
>> +                continue;
>> +            }
>> +
>> +            return false;
>> +        } else {
>> +            vbasedev->hwpt = hwpt;
>> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +            return true;
>> +        }
>> +    }
>> +
>> +    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>> +                                    container->ioas_id, flags,
>> +                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>> +                                    &hwpt_id, errp)) {
>> +        return false;
>> +    }
>> +
>> +    hwpt = g_malloc0(sizeof(*hwpt));
>> +    hwpt->hwpt_id = hwpt_id;
>> +    QLIST_INIT(&hwpt->device_list);
>> +
>> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>> +    if (ret) {
>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> +        g_free(hwpt);
>> +        return false;
>> +    }
>> +
>> +    vbasedev->hwpt = hwpt;
>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> +    return true;
>> +}
>> +
>> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>> +                                         VFIOIOMMUFDContainer *container)
>> +{
>> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
>> +
>> +    QLIST_REMOVE(vbasedev, hwpt_next);
> don't you want to reset vbasedev->hwpt = NULL too?
> 
Yeap, Thanks for catching that

> 
>> +    if (QLIST_EMPTY(&hwpt->device_list)) {
>> +        QLIST_REMOVE(hwpt, next);
>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> +        g_free(hwpt);
>> +    }
>> +}
>> +
>>  static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>>                                            VFIOIOMMUFDContainer *container,
>>                                            Error **errp)
>>  {
>> +    /* mdevs aren't physical devices and will fail with auto domains */
>> +    if (!vbasedev->mdev) {
>> +        return iommufd_cdev_autodomains_get(vbasedev, container, errp);
>> +    }
>> +
>>      return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>>  }
>>  
>> @@ -224,6 +300,11 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>>  {
>>      Error *err = NULL;
>>  
>> +    if (vbasedev->hwpt) {
>> +        iommufd_cdev_autodomains_put(vbasedev, container);
>> +        return;
> Where do we detach the device from the hwpt?
> 
In iommufd_backend_free_id() for auto domains

> Thanks
> 
> Eric
>> +    }
>> +
>>      if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>>          error_report_err(err);
>>      }
>> @@ -354,6 +435,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>      container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>>      container->be = vbasedev->iommufd;
>>      container->ioas_id = ioas_id;
>> +    QLIST_INIT(&container->hwpt_list);
>>  
>>      bcontainer = &container->bcontainer;
>>      vfio_address_space_insert(space, bcontainer);
>> diff --git a/backends/trace-events b/backends/trace-events
>> index 211e6f374adc..4d8ac02fe7d6 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size
>>  iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>>  iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>>  iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
> 


