Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40BCC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0kw-0005C5-H2; Wed, 17 Jul 2024 05:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU0kp-0005BS-U3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:15:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU0kk-0003Pm-PI
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:15:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H95dNc019791;
 Wed, 17 Jul 2024 09:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=sg4EwNGDm/uJkJ6x6GgxCCoFAx7+Wn1MOS7tfZvf9rM=; b=
 iinD3zSMxrD/T/7vj4aTFnOVHh9J6LA/2vqsd8feB0JC3HhUm0+RvrSUgH8Xvw6M
 KDasV9KfKp4tDJXSlW6jCGydXmPOQ1k59XaRdbvci3I9WpstJnl9NDRWGN1qHD8w
 qdtgmLDH1dfHxdA/bNTvdDGbeYpDCr/LCOOScn1OG2rfTHRzljNIi9Q1uLo2xX4D
 MjLS8YMJufMyVb0MNtLmhzsq1qPgpfpiUgO8GXsz8WPiMkSB7Pkny2COkVWMNHqI
 m+g5iuROSjRr1AVx/vFJ3GPGwTEWKk3T0sm+MsSEwa0W3OA2d1dQPBVGKLZ9/DqT
 XXpC/yHJoXwKFP9DXUFmWg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40eb10014f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:15:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46H827rH003630; Wed, 17 Jul 2024 09:15:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwextcpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:15:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yx+/Pid9YnTUsIyFBFsZG1nh5qe8ZoJ+nOFtUYjUSRfrq1M4T2OTroYLAYU5tgd8fIsZUp7qj8sPWB5ziR24WiRfb8Z9PNd3fZoAIlZn90THXG3M7aG7SMt/rD5KBlqSU5R7p94G1S4+BbNvixFnrZg4wOiGI6nLLqjTPqEdc8elDChRdvhJQbIbq3RV5Hd3xl3U+b8+hIyZE3CafmC4q3+xdk2waag+WCqpZvmQRiu3klRNsRB7+f94nBsJXtKyjW05QZTAniGghajwPpE3kBonDyp3ekksDM+KdnQ6Alfmq56OABgLJB1e71jUzQCM9NwHk/bS3iRqFlja0uFssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sg4EwNGDm/uJkJ6x6GgxCCoFAx7+Wn1MOS7tfZvf9rM=;
 b=q5Q08r946LQf8dZ7qVzRP6o0FDDfmcYOW3Hwy9KOtS3dVhKBGhDAAbfdykctWfd0BlXp5XqooZQnAiuQy+YAevLuYQtCKMlf2PLt2N7AlxQJqGy9rZMzmaAt+CvLdCY2bSYmU5e4pl4BHNcDAzS0lL5Us/Okscn2y+FA7X1HO6HKOP+YPEWQawWEUaFQ3Fy73NVSoUrUfNcEKd3GogZrbYeguwi02mX4z1mIsfqi13XwaKuGT6xQmaRBYUMEYszkgnso1HqVR5O316CHMzH5s2z/CMavzRbZLPgYjvR05QAZlICWzNSa/VCxpuoBdr3TwOIrH6IKShCECCeULsLBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg4EwNGDm/uJkJ6x6GgxCCoFAx7+Wn1MOS7tfZvf9rM=;
 b=B81Eo35iRzqslNuON6WxX4xvtaRyDUVyIpebS6+NWdP1NkG+DB6MZa5j7nb9qyGYqGHODg43Ac8kd8pt3awXiRJsLOPY4uixgn5OaxO044KpIOIZpIbYX7Pz1z4soBGqzgkqcjRzYQWPRy9/m5owqPGMmbOt1xbFGhcshDuvftI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SN7PR10MB7075.namprd10.prod.outlook.com (2603:10b6:806:34f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Wed, 17 Jul
 2024 09:15:04 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 09:15:04 +0000
Message-ID: <84cbe922-a03a-4ea1-a1a3-90a4d4e449a1@oracle.com>
Date: Wed, 17 Jul 2024 10:14:56 +0100
Subject: Re: [PATCH v4 09/12] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-10-joao.m.martins@oracle.com>
 <SJ0PR11MB6744B9EA05FE77ED2FA9C96C92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744B9EA05FE77ED2FA9C96C92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0077.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SN7PR10MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd1e03a-9e8a-4471-2158-08dca640f1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWRNazRRellJSHN3aWxjV0VTZVBkdzAwbUlZZGdHc3lDQmJZL0Y4TGdiYWpa?=
 =?utf-8?B?SEFiRDgxTlNCdXJGWXZOZHFpUVVBZ20vQ1RqVk9NNFpZMkVVVzFjR1U5cTRZ?=
 =?utf-8?B?Z0xHb0VQbVFKdXd0S1pSMVNzY200SmpUUDllYktjVHg4M2dZSk0rUkVDSFV1?=
 =?utf-8?B?NHl4VG1Zblc5WGsyNldIVFJtcTFIZjVqeFlPWG5JV3VGNjFJUzdSUHd6QVBt?=
 =?utf-8?B?ZjdYU1Frbm5Vc3NkL24ycGkyaVZ0RTIxMENqazhyL3hUYk5TT3Vjb0JvSC92?=
 =?utf-8?B?dWh5ZnN4TUVlVTJwaXdSMEJ6QllyVDRRL3ZtTzBRMkxrY283d2ZxamplUkJL?=
 =?utf-8?B?R3FYQkRwdlJIRzBzT2VCaVlBaThsOS92YXdrS1hJYUpWcERaOGZ1VnczRGto?=
 =?utf-8?B?bW5ha0RzMXUybmViSVo0MldwWDZhMzl6bjFxbTVwUUdYMHVsZmg2dUlvcVJJ?=
 =?utf-8?B?bFJ1ZFV2Q1VISFk0ejdzeTVYcklPRDJxY2xOZ09SbU1KUUhBM1BQQkZDOU5U?=
 =?utf-8?B?MFAwSDBJWmJDa1BldFI5VzJsK01JYXFkc0ZyK2ZnSlI3ZXJWVXkvWGZPWnJa?=
 =?utf-8?B?eFVKd2JVTkpwa2FCRWVvaGpFajlrYUM3Z04ycUV6R2hPTmVtT29uZ0dhT2JO?=
 =?utf-8?B?Z0FKcndWcFJVc0VvVW5PNWZTRGxHOG5DWFZRdjkrU2h6QndhSVEzYm94c1U0?=
 =?utf-8?B?YmNYdEpoQXV1WUtQY0NyRlBySncwdkxRc1paVit6OE8rNjV0UlR1cEc0Tk1B?=
 =?utf-8?B?bzNmUllyTUhLVFloRlBQQ05qTXIxVTZ4eVBGVmdCNDllMlVCMnBvZWdsWEow?=
 =?utf-8?B?K2RRSytNckZGV1BENlFTSUJ5NHZ5YThCb3E2UFZCS29zR3BCNHV2RVpmWjlt?=
 =?utf-8?B?eHV6Qm0rU1JGcVdmaW9rT3k2cjk5Rmd6NU42Z1RJbFAyUlVDcXpiMzhWM2Nv?=
 =?utf-8?B?OWUzV21UblltbTMzSVNLSlY5T0VTMFRWUWFTY3lkK3dsbm1ZVG41cEdkakF1?=
 =?utf-8?B?N0lxdVE0R2sraTJpUjBmdDIyVEJDSVgybFdLVXBydVVjdTlDbnZURS9rU05C?=
 =?utf-8?B?aDJYcVJKUjJldytDOUp1dzRocEpMcWlIM0dVc3BJK3AyeW82VmVoM2RCNHdE?=
 =?utf-8?B?a2tVMU9KakRFUFpHczlTVjZpWDRhTVdnSVYxTzgzdkgyK09BMWhUUGo3azhz?=
 =?utf-8?B?OHQ3Q0hGaDdWSDloVWRTSENQRkNEWVVEZ0R6U0c0SEVoM09POVM2ZnZoN2V5?=
 =?utf-8?B?dldwTGlac2p6bE14SnBLSmxaYjIxcVZFbWhBNi9QVkhXc2JhYzZSbFRRblJp?=
 =?utf-8?B?a1dwRTRFN01nNXE0QU9jMnJwSVFlZ0RuY3pERFdLSlVjWm1qSCtqVGlDQzNW?=
 =?utf-8?B?c2J3YTB6ZTVPY043L1lRdWtRQ2oxOG4xWXV6Y3MxeW9IQzQyaGw5NkhMaTdD?=
 =?utf-8?B?UkZBR3hCaWpjdkdTMFVsS21zaVNkRVB4MG5haFVYVFZXWERQM2lvUVlTKzRq?=
 =?utf-8?B?MkdPSUlLaVc4eTdIR0d1UkJwMXBHMFlmUjFTbnovaC9TbURnTHJKYkc4anRO?=
 =?utf-8?B?a3VVLzRKMHBBMEk5MTlkbDR5UE5mU3YzUEQ2VklLd096YjZJTmFwc1g0U2kr?=
 =?utf-8?B?bldIZVhqbDRlVUhnNjMzR0xYUnBnYVIxb0p3eEpkRzV3d0lMRFdBamJVYWlS?=
 =?utf-8?B?TGFtOHc4cHY0LytqcDkweVpFalVhakdLd0t5TVprNkx2YURsSnI1bCtsaUc0?=
 =?utf-8?B?YUhrbENScmpwaEVzQ1pGNzFubS9kR3lKZUVpSnFVZHMvUUYvQTR6KzJQSzha?=
 =?utf-8?B?Uk92ekNXYTJKcTVHOGIwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm04WnhDcnhwYitGVTJQem1RVmVHTlB5QnRTQ2dQbG1pcjFFTVZnV1F5V1Q3?=
 =?utf-8?B?ZlNoZmFUZDRYK3FwNzBheEZJREZsVWdQMCsvZGlackNuRXZFMEdCdXV4VTgx?=
 =?utf-8?B?bDhMY2JnbWkvc3BReU14WG9yTG1Ud0tpR21CU1dCMzh3eFRMYm5EV0d2VWJK?=
 =?utf-8?B?OFdiOFd2bVhNR3I1ZE5OWEpvOVpsV1RaYUJTaFZ2QUh1Y0wzdzA2VU1ibU01?=
 =?utf-8?B?b1FFRDBpODhyZUEvVEtTb09ZSVh6MUVZd3gzZ3hzYTVFZTZzQ3c5QzhiVHFl?=
 =?utf-8?B?QkZoMXU0ZnhsZHd3RUUvS3c3czNYMXFBQWNLeXJ5M3A3bS9OdmhRZmMxMktG?=
 =?utf-8?B?ZU5QZ3QxK0dlcjhMNC9ROHNLZEx4L08xV2FGL3RpSE9nRjNDbzVwcXJQNHB4?=
 =?utf-8?B?bFJFeHk1UGJQaEg4TDNMMzloOVIzQlJSNkllMS9mUDlJYjJHTGd0WHF6a3hV?=
 =?utf-8?B?SDBTZGtuM0Vnbk4zRlhBRlF5K284bHFHT0NQTG56V1VwRzVHaWUzaFk4bWhX?=
 =?utf-8?B?aUxqSXB0Zi9nSjRxWnNicFBDclkrWDVxdkZsV3VIaDVqTk9maktyeEFpZHla?=
 =?utf-8?B?R0N5Ky85WkxWZlFJSXFvVnp0N0U0MlJ2SWlYU0V3VFdjTDZLbTNoNnBSaDkz?=
 =?utf-8?B?NTh3Z3JmaFRSazZ5RzRNcFFrSEdQWlpHY3NWRDZqZkFXQ1Fkckd3UC9NL0Nu?=
 =?utf-8?B?Yk0vMEZLWWd2UVM1ZS9JaUJFTXQ1ZnZGZUNhN1RxRFV1NDQ1QkVkdVdvakNm?=
 =?utf-8?B?aW1IQWVEUW9HVEhWcDlnc042eHN6UTAxK1luUG9CNExuRjZrMXFkQVRPekpr?=
 =?utf-8?B?a3FYczdidTRYR094VFBhVW4yS3hKdERydWJjSEVsZUM4cnJ1ek93V1hYTi9l?=
 =?utf-8?B?bWd6eWNDcUlvUGRQU083SFpmbmhoRVpZL2tNQkMzYzR0K3hZZHdsVDUvVzFw?=
 =?utf-8?B?bVR0MVhaOGV0YS9sVk81Rk1PSGNncFZlRFlRbGoxUTRHL3FUOEZHbzRzYUMz?=
 =?utf-8?B?QnhDclhJalhCR1pXNmNKaG5jc2NWNmRhQWk0dVNFbzVEWUFNWTlWZzBaajZz?=
 =?utf-8?B?UUNwMlo4N1BTNk90blM4M0RraHpOeEVuMGpxTm1WWjZhd2hsZ05JZ1Q4amNC?=
 =?utf-8?B?VksvbnBNWDNGd2ZDRUNZMjAwNE9GZ0dZVTY4V0dzUEZiRWJ5K1k5T0NvcGNX?=
 =?utf-8?B?NytXT3ZFajM5UmFHbXNuU3BGWWFFYjVuWW15cGdkbHBQc1hmVitOTmQ2NURl?=
 =?utf-8?B?cUpuTEN4UXJCcXNINjZaTTdtQ3IrNW9pUkl1djZncnpQSGhHMXdwaG0rck5R?=
 =?utf-8?B?T00zT1lFcEZzc25KNVNEV0R4dGFFREwyeXRJNDRFUGlTcDFraGZNVzJjaXZU?=
 =?utf-8?B?V2V1Rit6c3I4bE5uLzNKZ25DMnNoQUM5ODJDeUYyRmprOHE2Ykllc3Vnb0ZU?=
 =?utf-8?B?Nm1CR0k5Z2swcytER2RqNTZJL1B2WW8rdHFpSzFaRkVjZFdQZzZWRjhJRkhp?=
 =?utf-8?B?cmM2TUJlSFVrZmRKSEtXVDgxTVBQLzRORG4zTWFTSU5EVHRvNXBveXlmNzcx?=
 =?utf-8?B?UThORmw4OWtlN0dkcjNZMk1hdVJiL09iMm40ZldpakpUMzhLeHg2ZlNsbTZV?=
 =?utf-8?B?cnFJTzBodlpraVBiRXl0cWFHb04raHE0SzY2ajYvZjU2Y3RmdEVPenJ1R2Vz?=
 =?utf-8?B?ZkczOE1HZnNrN2FDMDJJcXNabUlNK2I0b2ttNlhTdURmenBsbzdEd0dpbEk3?=
 =?utf-8?B?MEZZZHU1L3JHVXVaem9tKzhsaFpNdjN6amIyV0xsOWdCc0JKVjZNd2JPUkw4?=
 =?utf-8?B?a2wzSVlIWmJvSUhUYW1qRGFXSnpDTUV4SEJ3MWJtanlQaVhaUHJiNFVFaURy?=
 =?utf-8?B?amVoaGdoYmNsOXhtY0cwZ2VlbmdiOENXWFRPQlpIeTlVTGttR0YwRUpMY0w1?=
 =?utf-8?B?cHlVM2s5eEREaTV4ZUsvekpvdUQwd3VkeTJZY01uWCtMb0oxUlZ5d0FLTnQv?=
 =?utf-8?B?bGtLeEVTV0ExS2xpNlpHZ3hrWndjanhJSnAwQUJZaXBGWXRGN29Ta01rSVpx?=
 =?utf-8?B?bEw1QzFlM09pWFA0L2REWks4OVBQYWFYTXlHS3dHZkFnWmN5Z3pQOHlqWWYr?=
 =?utf-8?B?N1ZnWU83WWhvK3ZSMCtuVml2M0lrZWJDN1BPSmpwVktyN1JjYXVXbEJqZWRJ?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: At/jXK+uO+kzW/gbbHX15amzCrdHnEJmWWbZQEtp7c5fSGzF39XNigwpNyXihgYfCmc5wxphmke9SiOBCJCQcSuLp47MW05W9FoSqRFa3INN8gaX9/ytGEKbZPEMqiX14gSYeamOZduEhS2PO7jKTiIOnvpQPLLnqTOjMUJXfz5S2nnsOJP1GH/R82X8ebuUge394Yimy0JwbCiQgos+4VF9tq/v6DUEbSM1i0WqoDQDMPHAbCYmMZWxdyb+KXweSmWunOK9VQnHhYpOf+EvUWdewhhWGSWgFK/SOdwZ4vJPhcpOCQWAa3HrtNyw9WZFPd65+OPJk3/2gMt7uMHpaukt+8tz02Yl+wySRtWcqXHALOOJv7kzdkY7MD/saVOA40YxbtUK0p10CXsWk2NUxY2Ll8Mi0ziRSaL5eT7BBBs24jZn0JJ8+MdBbhQLafOV/Z+gXt/5F4TfV07tH0z6+RXOofbUcwB8LQTAvRM0dL3LV8K+BzbcE1wSmOTW3T86lSfJNwaF6AH/yJnLzSZjz6AweSHqsXyFu8REN8WCTgXCctl3j5jHffNl/a1QGDG3xNE+a6GF9Ej4CmVKmd/5lg1sSqeANgbTF7vZJYNGjOg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd1e03a-9e8a-4471-2158-08dca640f1b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 09:15:04.5346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmdv9aTo/+oAAOP5GTWdcY+ZYAJenjgmRaErHg4DdJaguuWKVU2dUmoQk0J3EYhJSX9I7ePD21N095AlKuBtEToBKNPiMmH/aTzlGxG2M40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_05,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170070
X-Proofpoint-GUID: mYArQqaaxVtGX8NpcSGo0OQXmyAtfaVt
X-Proofpoint-ORIG-GUID: mYArQqaaxVtGX8NpcSGo0OQXmyAtfaVt
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

On 17/07/2024 03:24, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v4 09/12] vfio/iommufd: Implement
>> VFIOIOMMUClass::set_dirty_tracking support
>>
>> ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
>> enables or disables dirty page tracking. It is used if the hwpt
>> has been created with dirty tracking supported domain (stored in
>> hwpt::flags) and it is called on the whole list of iommu domains
>> it is are tracking. On failure it rolls it back.
>>
>> The checking of hwpt::flags is introduced here as a second user
>> and thus consolidate such check into a helper function
>> iommufd_hwpt_dirty_tracking().
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> include/sysemu/iommufd.h |  3 +++
>> backends/iommufd.c       | 23 +++++++++++++++++++++++
>> hw/vfio/iommufd.c        | 39
>> ++++++++++++++++++++++++++++++++++++++-
>> backends/trace-events    |  1 +
>> 4 files changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index e917e7591d05..7416d9219703 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -55,6 +55,9 @@ bool
>> iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>                                 uint32_t data_type, uint32_t data_len,
>>                                 void *data_ptr, uint32_t *out_hwpt,
>>                                 Error **errp);
>> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>> uint32_t hwpt_id,
>> +                                        bool start, Error **errp);
>>
>> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>> TYPE_HOST_IOMMU_DEVICE "-iommufd"
>> +
>> #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 41a9dec3b2c5..239f0976e0ad 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -239,6 +239,29 @@ bool
>> iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>     return true;
>> }
>>
>> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>> +                                        uint32_t hwpt_id, bool start,
>> +                                        Error **errp)
>> +{
>> +    int ret;
>> +    struct iommu_hwpt_set_dirty_tracking set_dirty = {
>> +            .size = sizeof(set_dirty),
>> +            .hwpt_id = hwpt_id,
>> +            .flags = !start ? 0 : IOMMU_HWPT_DIRTY_TRACKING_ENABLE,
>> +    };
>> +
>> +    ret = ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
>> +    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret ? errno :
>> 0);
>> +    if (ret) {
>> +        error_setg_errno(errp, errno,
>> +                         "IOMMU_HWPT_SET_DIRTY_TRACKING(hwpt_id %u) failed",
>> +                         hwpt_id);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>> devid,
>>                                      uint32_t *type, void *data, uint32_t len,
>>                                      uint64_t *caps, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index edc8f97d8f3d..da678315faeb 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -110,6 +110,42 @@ static void
>> iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>>     iommufd_backend_disconnect(vbasedev->iommufd);
>> }
>>
>> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>> +{
>> +    return hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +}
>> +
>> +static int iommufd_set_dirty_page_tracking(const VFIOContainerBase
>> *bcontainer,
>> +                                           bool start, Error **errp)
>> +{
>> +    const VFIOIOMMUFDContainer *container =
>> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> +    VFIOIOASHwpt *hwpt;
>> +
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>> +            continue;
>> +        }
> 
> So the devices under an hwpt that doesn't support dirty tracking are bypassed.
> Then how to track dirty pages coming from those devices?
> 

We don't support 'mixed mode' dirty tracking right now even before this series.
I plan on lifting that restriction as a follow up. So far I was thinking that to
make sure migration is blocked if neither VF nor IOMMU VF dirty tracking are
supported.

The reason is that the migration initialization of the VFIODevice needs to be
adjusted to be able to understand all the constraints that the IOMMU dirty
tracking is not requested when VF dirty tracking is in use, and vice-versa. Thus
making this check a lot more representative of the features it is using.

