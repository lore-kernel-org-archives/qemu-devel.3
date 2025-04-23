Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE9CC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 08:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7VVz-00025j-NH; Wed, 23 Apr 2025 04:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1u7VVp-00021T-SS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 04:31:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1u7VVk-0000wP-FV
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 04:31:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0uNEW002994;
 Wed, 23 Apr 2025 08:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=PICkmKtIB6K+lWpelUZ57yGZjRqKPcr2OB/7dak6MsQ=; b=
 dKBFVqy2rNrsEsvGEk1LdbIS5CRuBLTTMilRStwFeVaAodNqx+Xyqr2JqcMHUYh9
 u6SmKWgvvEd/0vLti+y13zyfcslK9hG20pGCk18aXo/sKaqK5Y7b4vBeu6RP9U1F
 aMIfSNXnzAOrfpNa1J2dcFR/QayG4jIYJwd2QCDXOceWHD7rTjqzFpFDg5cau6E/
 9tKxgm0uyklbCBgUbVwYkTtlZ6Dc1vtDz8njE7OWqYLuRI1WgBpVtLCx4dL/2LcQ
 I+5COxvzAvRQXs4GXs6Vcg2bT+6u/r+1Y2Ec/FLM8h3OcETlphy92sSDGNJF88IH
 YuTQLVTwlKdmigKs59/zxg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha0qrh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 08:31:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53N7faEw028470; Wed, 23 Apr 2025 08:31:10 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013060.outbound.protection.outlook.com
 [40.93.20.60])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 466jx5sdaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 08:31:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdL22rObFJuak0Fg9Mr9dgRLFIkbl5fmlPEL9vj0h87T5iPDzsWhRa/tjwU9CtK+1ECl3JKF+ldNRzou82WzELS5kn5m0X4qwEQZdgXrXHcJv2dXOPlIOa+kI2yBzPuN2/13PCYLUwZYSdWpkMq7xybmmd0y9rVT0fdSO77Ez/j5SNYEUMEI8m3/plfn9TI9eVLmbuavYkbt1WJOW0kNfYMX7dN6OOZ8m/54+PL0TARkIcXyMFJKhnKdKNw9YhK7kRRAji52y4rhyB3hibDszHXkHHSwWhjjqcpoimL3jMUH0ElKXhzvUYugJ+B8tcuu08qkafeOKLBD9lnQ4H9e9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PICkmKtIB6K+lWpelUZ57yGZjRqKPcr2OB/7dak6MsQ=;
 b=lhcTuP3WuTJrBWUCuI0fFA+0LiJdgu51H52qXYx8tAzKYP4FLS7Dy9oXqvxYXlibw7j5W0Huo4vaaxXoyBSoW5x7fjtUZbwXo9QyN2pRzz+8I0I+7tGW0xayBYGN/ZnVcrGpaOVtpmUy1BWM4HjtW5OGsUNTPOS/PoIwbWvFDTl/Vh+HLcUElVxtftb2ca8ksxLmrJwEntKh4zSyzuAqm8HZrXgISnpmAcSaGAnd/2fGXDmZdiRp7nedDqtMujqa12i6XHRo25KNvDbXcne5cGDgJE9fOpI4Vc1dAb3wmJH4HfNzVnWyjdEn2XIsJeScb7fPBEtnwNZEgiUhowxcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PICkmKtIB6K+lWpelUZ57yGZjRqKPcr2OB/7dak6MsQ=;
 b=CtUhJcQvbN/b+nmSbCp+Ec/zaqtDIHjA2uGsJd7H9EWI3InGESKYCebB2UX5XNM6FZYlSQeAilel3YA7Mq3G1xgkUKv5P+dZURJWdYoRQOvykWf6/DTy6KFRT8qvtBXcXsEx9pZ+GeYmWizRnyu51ZsR9oxkBk9QngnwOtiryuY=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by BL3PR10MB6164.namprd10.prod.outlook.com
 (2603:10b6:208:3bf::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 23 Apr
 2025 08:31:07 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3%2]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 08:31:07 +0000
Message-ID: <6bfeb371-7efb-4b69-9106-d770aa72666d@oracle.com>
Date: Wed, 23 Apr 2025 09:31:01 +0100
Subject: Re: [PATCH v2 1/5] vfio/iommufd: Make a separate call to get IOMMU
 capabilities
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250423072824.3647952-1-zhenzhong.duan@intel.com>
 <20250423072824.3647952-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250423072824.3647952-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0183.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::20) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|BL3PR10MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 0591c365-a82d-4da0-94f4-08dd8241318f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWtidXNvZUdvOUUwVkxCa0hiYi83c2xPYzlWVmMwdHMvOFlmWWFNaEtnakd5?=
 =?utf-8?B?UkFHSzBNOThVdnhkS1hRNll1dnRnSzgxK05yMWxRc2RXdDg3amE3ZGZjR282?=
 =?utf-8?B?blNGTzRKS2VTQzJGbGtvYWxxQXJhSG0rbjZIQUVOY0xnZlBFZVI0NmlobFh0?=
 =?utf-8?B?Nm0wa1JKYTI1bGNnUHFvOG5saFM3SkxGc0JZYXlja2p4cmtvWmE5OUs1R05u?=
 =?utf-8?B?WnVRL2xWZW1RSWtmWDRMNjZFci9DY1A2WFA3NkVUQTVhYnRyVmNZNWR3YjVQ?=
 =?utf-8?B?ZWxKU1Vod1UydkJCNVpzS1FtWFlncitDMGx2K3BjZHdRRE9iRVQ5cEN2M0JG?=
 =?utf-8?B?Yi93WGUxWkp5clBwZmRJa2NIRU9tU2hLL3J3TzRoNlpWWFBBZnJJVy9qczln?=
 =?utf-8?B?emo2Sm9CMFlhRFJSTU42Ujk4eWhFNE1rdkZNbENUSm44MGVvRzM1dURKM2oy?=
 =?utf-8?B?ZklLOGQwWkZFSGY4YVRLY3I3bm01Z2loNjRkTW1YK0RMZytxSCtIcUNzd05r?=
 =?utf-8?B?ODA5MkpsOE5RZUJLbjRrU0xwMDhjbXRmUDhyTWs4OFN4UHB0SSttays0MkF3?=
 =?utf-8?B?aEdOYlVIZlE2V1IySHBNQ1BDdktIQndJUVMxOHRzRnJBTmoyT2JmZFEwU0c0?=
 =?utf-8?B?OG5aSXArOHBYZDI4TGUrekFjWStMVlRsWEVPWnYrcThSdGtrQzBqUHN0Rkd1?=
 =?utf-8?B?QlRHZTd3UFg0dlMzeVpqSHFkRHh3Y1VEMHJVd2NSbDZqRkpXampCMlZ4SkRB?=
 =?utf-8?B?MG00dmhHRlMyTzdSWXJwQno1Nmh1N0s4Y1E3TEhjcFU2Q2NjQ2pvT1puZ2VZ?=
 =?utf-8?B?OHN3Y2FGNXZJcjFNMGo1ZzVzbWtaYnY2QkY5QW43MTA0T2JvUnBPK1RHSDRk?=
 =?utf-8?B?NXduS0tacGtMakI4U1NJdzk5dmhqdy9NdHpjaHpUMkpHcjlZS0N1TXNoZzVY?=
 =?utf-8?B?SHlQZmMyc0VtV0U3UjRrYWpZeDlVTEdRYTIxTlJNTTJJTTkyRGhuZW12anJE?=
 =?utf-8?B?bGZiTUt4SVk5aThCdSsyRXQxQ01PTnIxUTR0bkRTUHVtTzN4RUF3emRHcGQ4?=
 =?utf-8?B?dWxlNmlBLzFGOUlJeDhyb2xvZDFTRWR5STVMZ1E2dGc0bXBPaFVZTXlIVjRO?=
 =?utf-8?B?OHpDaXY2OGV3OHc4ZDZDOVhkRityR3RhUGZiUUpyc0FyY0FvbVhDL2F1OGZN?=
 =?utf-8?B?RUFHdXdiRnNJQ2JyVFV0aFVOZi9QR0hzeG9Rc243bE9YMS9raVBjSHpUa2RY?=
 =?utf-8?B?a2JzQy9aaUs2S0pGMGsrZ1g5QXhFWjlFbWJwd21KNnNlYUh6UVI2VDVqK0gz?=
 =?utf-8?B?Qno5clJ1Z0Fqa1VBcnNONHlUbWZnSklvTnB1Zy9pRkhOU1lZUU5OM3RrZVBN?=
 =?utf-8?B?TXoyTmlBWS95WXNnV0hsSnQ4WDIySWRPTS9MSU90OHNIeWhxYVplS1U0YU14?=
 =?utf-8?B?aGQyRit4OTRUUnNCM1IwVzE2bGc3RFM5VkVrelQwYkJ1K2h1T3RkemJzQVYr?=
 =?utf-8?B?NlRzVVVtMlZod3RZMVoxcW5yOERSQzRUeVdqZUNsSlVrOWVnNU1MeWpDbDFW?=
 =?utf-8?B?YTJ4OUNCZ3l6THVSQWMvVVVVOHNjNEJUSXBsak0wRU5ZU1hRU1U2c0VrQlBY?=
 =?utf-8?B?UUJFTG9HZG90TlZDc2pWRStyM1U4Tkx1dVBDRnJYREdSREpxb3lzak5jaVcr?=
 =?utf-8?B?N3YxSWc5MmpPc3I0UmtlRUFIVHZsbmUwSFljcldXVUNzWXBOWG9PbVdtVHFy?=
 =?utf-8?B?bUt6Tm5mRFlTSGcxTGp3OU5ITFU0a3RjWTNadWMxZU95NS9QKzBzQnhxVEU0?=
 =?utf-8?B?NFBoeHA3VUI2WjA5eDZpb0N5WHBjVy8rZkVRUUpvajlwdjVwcERCRllxbHUw?=
 =?utf-8?B?R0psWUsrK1RXR1MwSWduZFJiVUc2MUFBT3llalhJaHdvSWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjhQSThUM0JpeVcwZE1aaHlMSlFXK0FraW1pTkpnUHUveW9qZldrdEZHdFhl?=
 =?utf-8?B?a0xHZTdQRnFReTk5M0ZXL1NWcm1NSUpERUROWlBuL2dDRWUzTnkwM0paWUIz?=
 =?utf-8?B?dEM3Q3B2V1htMXlQZkZVak5nbjdWa2F6R3pycFYyZFo2LzZZMjJUZk9GcmhR?=
 =?utf-8?B?Z0paSkRKQkxBR0VHWDZnUUNuYitEcFJqTlNpbzZibXd5N2FHWFZRangva0Nh?=
 =?utf-8?B?eDV3bDV2REYwZ1RpR3FIaW8xL2t3K3VPeWcyS0tsMnV4SmNBN2xSNkMzN3Az?=
 =?utf-8?B?TExzNTFxZlRDQ3hqd1FzSjc5dEsrY2hkZGVtKzB4eDFrS2lORlFBNGplQXF0?=
 =?utf-8?B?SCtoKzdFMVFvZmJXcm9tMDQyOXZEdzBWbXkvQlRZYk1wREI3ZTkrbmJBTWtj?=
 =?utf-8?B?S1QxU2ZzQ2M3b0laYzlNZndoN0ZRTzM4VFhGWWU1SUFmK3h5Z0RLSFV6YVhZ?=
 =?utf-8?B?WjVWUXQyem14bkZmZlp0b0ROUThST3ltdk9SeTNuclBncWxHd2JicisreWpC?=
 =?utf-8?B?TUo0N1Z2S3RLTzdVZlhDNmdFKzJ5U3JKRHRrR1dPclhYR1QyZW5oQm5FbGgr?=
 =?utf-8?B?eHhUYWdyTmQzU1RXbEs1Tm5nR1pOQS9lY0dEMG5ZSXNleTA3Rm9iM2lScWxp?=
 =?utf-8?B?VlBDeGp1TmxpSjgvQkh6dENGMTg5TDcvRDJZUlgyRUQySGRXaStEaC9MdlVV?=
 =?utf-8?B?U0w4WkZseUpmSFpCR1hlWHBDUWZXME9LdGZ3YkM2anlXN2htejA2RGlZdE01?=
 =?utf-8?B?VDd1WXZ2a3pJd0VZTzNXL1RkZHRRTWpnUW1oSFF2R1JHamVsTzhtREM2Q045?=
 =?utf-8?B?dURETVV5bkw1bERIV1RJSWdFbE5Xby9RU0FZdXdkbmNxRW9aRWVWZGF6QWRG?=
 =?utf-8?B?ZlZ6VThrTFFFek5uVTRFRzBKNEkwTW1FMno1cnpaREwvTUtXd241VUk5WEtM?=
 =?utf-8?B?VjIxNFVPTFhta0xEck1BMmE4RGxhcmNLVTRZN21EM0dhcC9RTGIwbU9XZTNP?=
 =?utf-8?B?S1p6aEp3dkhTaHBOQkFCNmVGOW9PYkxDTmh1UnZVdm8rNStRekEwR0FVRDh4?=
 =?utf-8?B?dzdWQkQyL2lmUjBmMlJVdmZXQ2UrUjkxSHhobWoxb0lsM0o1cHo2dm5HaVdP?=
 =?utf-8?B?bU1IT3Y4ckdrRWJOOUoyM2F4TkI3MFAwZERiaGlzMmovVWhLTURiRERZZEk0?=
 =?utf-8?B?SVpHSll4VWEyeEpmYnpGQ1c5eDFyQTVUOTFnVjdNMnc5YTAxSnFESHN5THJN?=
 =?utf-8?B?VVNLelpzWjJRc0g3ZC8yYjdOYWpOQmgvbUR3OElSZzU2K21RSnp4Lzd2ZDhP?=
 =?utf-8?B?KzQxclpJTkZkZTE2QzFXUFdjRDl3dmRScmg3bTl5bUU0d2ViRnR4RW1lS3NN?=
 =?utf-8?B?UitHSkJmaENOaDhWZ2lBc2lCUlJ2ZXRTaXlUOXk5ekFtRFRtVmNFMUpqRlIx?=
 =?utf-8?B?eFFHdjRjMU90NThGcXRhR2FvVGYxZEY0S01VZlo0eUNIUU1vZk5hbmdPd3dw?=
 =?utf-8?B?aWh0Uzcxd2UzVzNiSGtsZjdPL3AxL2g1YmZUa1RFNGlqbFR1amppMkpiVXJa?=
 =?utf-8?B?Q2gzc1N4clFNNDZkZ1JVc1ZRQ09tMXkyamFkRklReHFxUHdVaUtqV3ZzNDFY?=
 =?utf-8?B?VVpoVW5kMjhJNzZXUmJ6b21Eemg3eFliS0RkSVF1M1J5TUY3eHBiN1NzY0Jz?=
 =?utf-8?B?am4rOW5pdlE1ekxMWjFaUk0wRzRzUlZVT2x2UlFQWEhOZmxiUnJuQ2NyY3VX?=
 =?utf-8?B?bnk5cVRwa2QxZDRkNnkvc010OWdzNVlzOE1TamI1d2tOanVuWm44Sngxei9j?=
 =?utf-8?B?NmhRWnBnRkhLUytLTENCUlpFM2VRenJrMDhPRHBrUGM2d253bVl0bUxhVjgr?=
 =?utf-8?B?RDlxank3ck1abksrV084QkJqT050STV0WXR5bHVtZTNpczdQaXR4SWE4Vlhl?=
 =?utf-8?B?Qm95bzBGWVU2TFBiSmdiaUlQajFVOURkNVgvMkxPUzVockt3eDVFeC8ycWxE?=
 =?utf-8?B?dXBTZldRVFlwQUV2dlpadjlOQ2hQU2lwVngrcnZKVFd2ZW15L3VHQzAvMVRy?=
 =?utf-8?B?SzBZL0dTc09iUGdBN1MxQUtTRUFWdkdhb211MkhQdFR6NmlCTlVjR1U0M0dI?=
 =?utf-8?B?M3MyMzBRUlNlZ0wzUXUxVy9wMGVoY3FCeUIxOVBwakxYeHhHYkt6Zk1UVDJ5?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TEbGRyJMuvbffUlKvaTtzU8+8XGDy/DFw+J9vz/T4keJU4UtY9c8L38mhqJ45hP77kNrB8eMPAWHYBckr1KKhnK9PCKeENm0rjtOS5FuUFxUcOZJ4d8TYbeArtyyQPfsjH2iH1SAkPp4rHyrLTfUkwx+ozGilinYIisS87bfAJmuBdX6jUMH/axpjRNaUBClOJyEb/UOG/pYaOgEJGTCwKO6YogECT+HTZRyDVtJXwJYoby4c6jQgd2iZ5t9aC6gfApXj+DlxzMeiPMTfjsAeDVJWwXaRrAZWy4OJy2lkJruFbTcANwpm5s1fLbIIU1G8tTy2bZhucFEh1kRmgl5BPYIYRRZQoiA0TPpNU3uHvANdIJS/iUkgrnXvTYYvQhgnYhPe+LWmOhaCjgsyphLiq12/zNhxt2Xue2oxKo2ZmNF6FwP73Qih10dx+4ESKDurMLPQ7PxKstvmI5cz3HRdZHSOpKeCa/m8ClVAbHU6fWctBfLBfDWE7X1vCfzY67RpMj/nNdwzUtcL4A+jRJFyt51+2R7SOCiYHLjDOfNTBccIV+GYGTdOwLQIzMbknx4EXs23ekr5SQXn+RKPM8nouKj3XVsuAYgO/BppT9BE+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0591c365-a82d-4da0-94f4-08dd8241318f
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:31:07.5265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzBRJdsyKN86+fqfwjhdOPHygZMlJAR1uYxnIAnTiUc13TrPTKwPbyspcA6fbX+bFMbrbMgyFKXTn7ygxBhsI98pRtBqMiJ1AXweJDGGJ8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230057
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA1NyBTYWx0ZWRfX53iyuuljeWxt
 vPvwFRLOPDZSG4V0wEuPHZ0IDqXJC8wNee/diXonhEQVQOXvWTmMQW+g8hdAZ6SmPmat4AL+dWP
 7BH6LewLQ+aidkB+BtX4SosLEmyozUV7QYwrOr7latYl0vzq/DTKffhVRwYKW4oiAKQjF7TVX2W
 pxRQRYvk2/IuKjWZVG46bahL6xgiJbda6XeeigzBRfAQTI5qlQO6hueKgBWenyJqq2r/OuCvDc/
 hwlmX88BNndeaBFPhxYEJN8sMQUnsVuno9nyDE4qJhOQH149U0LCxH/A/tp/J0YdgiZNJHKjBm6
 bPFkY3OfshdZi4L/1wcwBZY9noxX0hnyZqPIHlFW9nV67am/3t7xzx2Dqh8Pd8OOMhbJLRG2OAQ
 /8vsOeAc
X-Proofpoint-GUID: uyaxYVZli_IeeVuDZeiznPVmjpZAJq_o
X-Proofpoint-ORIG-GUID: uyaxYVZli_IeeVuDZeiznPVmjpZAJq_o
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23/04/2025 08:28, Zhenzhong Duan wrote:
> Currently we depend on .realize() calling iommufd_backend_get_device_info()
> to get IOMMU capabilities and check for dirty page tracking support.
> 
> By make a extra separate call, this dependency is removed. This happens
> only during device attach, it's not a hot path.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

I think this looks right now as it's placed in the auto domains path where mdevs
aren't involved:

	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/iommufd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 48db105422..2253778b3a 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -287,7 +287,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>  {
>      ERRP_GUARD();
>      IOMMUFDBackend *iommufd = vbasedev->iommufd;
> -    uint32_t flags = 0;
> +    uint32_t type, flags = 0;
> +    uint64_t hw_caps;
>      VFIOIOASHwpt *hwpt;
>      uint32_t hwpt_id;
>      int ret;
> @@ -324,7 +325,12 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       * vfio_migration_realize() may decide to use VF dirty tracking
>       * instead.
>       */
> -    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
> +    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
> +                                         &type, NULL, 0, &hw_caps, errp)) {
> +        return false;
> +    }
> +
> +    if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>      }
>  


