Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6833CC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqSD-0001IQ-Sc; Tue, 13 Feb 2024 05:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZqSB-0001H5-O9
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:55:55 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZqS9-0005QH-E1
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:55:55 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41DAFJs1019790; Tue, 13 Feb 2024 10:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=E2Wc0V9NNXDCpAbHaL+nY1466i4bgw0ZKPPLIMNOqKA=;
 b=I8X3pWqj14zJDSYbnhwHDzNpkkbQUlw0vgwYtnTe9Apu1cgAdlLBXRs/3yLAWE3S3g5h
 hnGmOS7kiNdciJ0em2SpGFkjUXqgjttN5a4TnpFFWj5r41jkQYVg2ne9f830bpIZqwH/
 66x3X2kFEmpmrqvM6AGePt9WAJ/XPRSvMuwwkic0Tt/9XI9mxwwel9baNbnRVHnOemTk
 D2B7PcQsWUGCA75HPPEQACwUPBCwDFAojB3CBKoznm3IKNe1cREaWk6ilD+Fp/PU+HZP
 yu5sNm2lBPyqAOOQ1F1jIEWoo90RtvQOXvurBeEBsSlCmlugx3BC1ojGp3zPj+iCTazp BA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w86gqg2sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Feb 2024 10:55:48 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41D9o2W3015037; Tue, 13 Feb 2024 10:55:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5yk6w5jg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Feb 2024 10:55:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esVH6KTS4fA2whOHj2eEgo9XE8N6vRfjVHkswkupkC1iAop/5vWYxf276Dk+FtWQcQ6w+t3ZTrDCnU08tGQcOhonBGLFIUtJA+uIbolUBEPFd2O5b4nQHJ2GDpe+z6KvHk0v5SQdVvhZfqkvsrig2V/xXvpLp4h0CW33I93EXI/iDI86kQKLmC0BJYSBq1yJ0n884rqqTTbu2y//YpqD2wRDTk3MdnAXKzyieUpWb/c/ua2/dhfUeIwErLp+lcTUVkzWieB+zHNXC9FWssCXIB5LhUJFZWkAA/6BEVH36oecY8yVWMs9L6gJYE4LovVZpRF90TNnPtQfake84xMOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2Wc0V9NNXDCpAbHaL+nY1466i4bgw0ZKPPLIMNOqKA=;
 b=aM+3OWfiIExrfQu+az2DjynYZj7NFv2IVnJb0sxM4WKVjV8mHNPNiyBmb9NrCMzq7Iaf28Bj97lVG7oPgYjB7rppoOii+32fSw6QHh7lo2BCzAXu7C/NmS9LmIGdUTVpg+/6SLjQB2hVfC34W7zPfk3ehyzUxn+pfP3+BDPL8g5CQCqLJh5Q3tqwjch/inGSwukaMyLJxtwCv45zuRkrenb2ucIRICnVFcYZfcjGOW4GTjwr5PTUFCXFhrU/uJFx/w8UxZyJmEBTnpk8VuWMOB/28/o2EBvtYsosyGQa4vZjmk3KWShE4uXNeQg6hKKY0WIZXuBM0Zh3bLCAH6PSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Wc0V9NNXDCpAbHaL+nY1466i4bgw0ZKPPLIMNOqKA=;
 b=jAyAPksy16prUFC65OVdD8ihvgQKV/ubkaSLd44Xk5h6FEJbCDFGfjqrjjF4LNQUzVeujxSGg6tZQZpz38zvzsuf9+GMlXMrtm+Ie43ZjvqNsy/xNZnCTgwUjX/iCkbDzQBS6qgaSNhVWXBtUcZ3/ZHFWNKe89ecqEJ3jUGUx/U=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CYYPR10MB7625.namprd10.prod.outlook.com (2603:10b6:930:c0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 10:55:45 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 10:55:45 +0000
Message-ID: <72642921-98d4-4c4f-8117-868d2ae29eb0@oracle.com>
Date: Tue, 13 Feb 2024 10:55:35 +0000
Subject: Re: [PATCH rfcv2 18/18] intel_iommu: Block migration if cap is updated
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-19-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240201072818.327930-19-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0434.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::14) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CYYPR10MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb4dadc-86e1-401e-60b8-08dc2c825433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xu5SakWGEM5cL3EhAR4WwGdggnZYf9HBVJ3yJjnqNFZFyPsOcTSr6N1bcnkmxmXKd8jhYH3ASU6CYZJjr9KL5KdlunNvr7+7P1xLfnRL0vM4Yfqf7KzvtLZp2Kxd9OFvbTDqqXA5yO7tqGVYDus6fLcCCmyupx3OI77/zHkj9MV8TAqWYwxtGG5+xKNlQhBuPnV62I4zzno3CS9Ybo2BuXcypJVbvRo/H5TXoq0RVLb08All+E9HdhdxMVlKWA7hmiiHPraNQzrvD6eNjQ5XoAITqrTRUMAPyvgiVpU3x281VZh62N9mK64n96Sqe8exs1KUWa0ZfM1M5ZRP+WvS2ae6vefGhbhtKJ4Ol9qMJ9Esl7kVSuyMkvXaUb2HXFnDJ0dy8SFGsoIxUAU5cZFps1l4m6G4A+PYAOc4UXgtBelsrL3mle44Pm6gnj4ByNO260xLisaovrPc7pCmLsNueRrcg4yqhJqHr6fJS6/kOAMiEGNrJ2TEvRMuMLDkHHvTTkBZzzG/uC5mX3NrIy4B1z+hKb939Haky9D0pF8O8zjb5HO111lwsKbVQz7RCMwC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(6506007)(36756003)(6486002)(6512007)(15650500001)(53546011)(6666004)(316002)(478600001)(41300700001)(2616005)(26005)(66946007)(83380400001)(4326008)(66476007)(8936002)(8676002)(66556008)(54906003)(31696002)(5660300002)(7416002)(38100700002)(86362001)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjBVWm9LK0UxeWFxTjJIOCtVTjJyU0tPM25Wdk5NRFZMdzR2U29oTzZmNzlx?=
 =?utf-8?B?K1AyakJ3SWhxbTA5R0dLY09WSjF3VUhUS1dxRXFVVGxXUnhPMzNDbExGaWJl?=
 =?utf-8?B?b1UvL1VCeEF1QUw1OEZxWmNMYk9jMUR6eTByQlFkTVV2TlRGUFVWc3JocS9p?=
 =?utf-8?B?YThweXBVQi91SW9oYlB4V3k2RGVlWWlGL0FlOUVsenRic2tNMytQL25jSkt2?=
 =?utf-8?B?N2EyZVprZXhlZGNyd2RXRkM3WnkwVnVTT0VuWXNQWnFObXdIUDZSNFBYSmt1?=
 =?utf-8?B?TkQ4UkxzMEF2bkkvSWRQWEY1MEdLTGtaMHhEclQ1cytEK0hxaEVNT2d5UlY4?=
 =?utf-8?B?ZHYrcFhwUFpxTUNBUHNpV0tuN2twQ2FWSFpla2lYNU1vTEV3ZVlFdDJ1RXEw?=
 =?utf-8?B?b0MybmRCSVFsM2p0d3RwL0NhMlMwVkp3ZEkyREtNbGJZMHRHK1hIZ0ZCcDNM?=
 =?utf-8?B?NXdQSmM4Ry9XYlhOT0tuMVhuYjlveGplS1NNK0dCNUlJVGlCOHRTWWdKR21a?=
 =?utf-8?B?UHpuVW9QRVV0Ym1qVXVZWkNDa3R3TTRjR0hWdElmZW94NjNBTkJZQW4yWTNm?=
 =?utf-8?B?ZGNtTUhROUdRRlQ3aFBpck9yd1c2ckV0WWRBQmJmQkc1MHQyTkVVRVBSTXBD?=
 =?utf-8?B?cFR3dHMzS2IvWlBpcFRkVDhGMTY3eTlsdW56RE1kMnBXbVRzK2twQnp1TERM?=
 =?utf-8?B?UDNXWWpKTXAxZnpTa3dCOGJhL2NJK2RNODFlN2FhQnVYbFFlVE5IOGVyV3Fp?=
 =?utf-8?B?eEI3T0dyMVVxN0xadFNMZ1FTdndYN2FPWEVtVWRDSHVpMGd1MVdJVW1pdndJ?=
 =?utf-8?B?eXYwbXBBUEl5N0wxY0VoaTNBQWpDbHk5YzFNbisxTVNUVnpZWnhGM1c2YVl1?=
 =?utf-8?B?SmowcjIwanI3aElydHVWczFjMVlrelpxdk9KaWZRTmN6K0dWRkRkVlYrY1pR?=
 =?utf-8?B?TFNBMGZDc1RrOVN2d00wR0x1MnpkN1VzWlgyUXhXeWRWNnVZM0grQ0JGeGMz?=
 =?utf-8?B?cmk5VWVNcjNyOWhFZFFySlhJa3NnWU4zay9RQWtxZWltdkNzWWRQY2wvNk90?=
 =?utf-8?B?bVI0T2lCQ0huS0hMVWJTTVRaRWVVcmtVcUFKSFY3QnZQRlYwYnNFZ21jRHhm?=
 =?utf-8?B?TU4yS3QvYXNDc1IzRjhqdllzaGhwWEVTK1NKQjE2VUtOK1NnNDdGOG5lL0Rw?=
 =?utf-8?B?WlpFYmlzVHdJUkNKdlA5TWZZM2JCZ0JkM3JoVmorNTlRUFQrTjFnK2UrK3Fk?=
 =?utf-8?B?OStNTldWMWh1SExyU2dONXBKQjZmY0t1bHdIOUorN05oN0ovckZDSUhBZ3oz?=
 =?utf-8?B?R0F0eTYrUk81Nk1tOFpmUDFXL0hjSjhBU2NaRjQ5WEVhOUh1WGpkdm5mNEJQ?=
 =?utf-8?B?MExXVkYxdnd5SVRFYjBuL3RUa3ZMT0pFQWZWMllQSU5WQkVXcGIvcHFCQXI0?=
 =?utf-8?B?NFdNekx3cXRlMWp1TW5CUHpxUi8zSzB2VjIzbFZjT1BVNnZRazB6aCtqVnQ4?=
 =?utf-8?B?REE0T0JRN3JRSkJlV2IzS2dOcE9VV1FaNVdFSS8zc3BKQnluQm9vUUxHL2Z4?=
 =?utf-8?B?WlRhRVNOOUlLb0FvYVJOejc0N29TUWFUWllQdzZvdjFzOWsrcVg3Znp2Vktq?=
 =?utf-8?B?U3Ftb1lXUjcreHg2cE84cGdrVVByS2VvVzlvZlRkb3dmNVlrYVJYdUdSK01t?=
 =?utf-8?B?d1VDS1d1aUtNWmVIQzlTMFIwYnJtOFlhSkxXM0FMeVNrM3V5OTBHeWlwMkNj?=
 =?utf-8?B?VjI0a2hGb3ZISTFvNWN6N1crMjFuUHZxYkZDcEVod3hBMENQS0VlNURvTHJa?=
 =?utf-8?B?Q2xiVnhDckQwNEZPTWluL05Xa2dyblU5NTE4cUpqTHZvb1ROK1AzcnQ2cjhM?=
 =?utf-8?B?WmdkblhtKzN2d09MS1VCc3VubnNlQVNwMlNCcEdna0l0aG81ZnY1ZWRIMVVp?=
 =?utf-8?B?dmVrT0xNbkVQazFJeWNMRFVjNFU2SGJJTXJ2ZFZOSEoza0RLQ1I2VUFzTHEx?=
 =?utf-8?B?d0ZBanE2OEhJTFRNM1NpQ2pEdEwzc3ZxVGFGb3o0RGlIY25OUUR0dFdrSmRF?=
 =?utf-8?B?YUM0Um5xYVZiKzB6SVNMK29ybit6Y1c1dVlmUzcwTVlHVXY2eG95TkVTQzFx?=
 =?utf-8?B?SStJRVd4NndNdWkycDNOYmJvNG1SUjFyMnNyMGtaUjhITk1YNHBTKzlkN3Iw?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6v8M+NwPNlrUJMKN+LXIVjNWBNCRWPtwDUgz1HDBOrYfLa5SAFpFh43D/srfPBb43ug6TAnfv5OiTX0o8QAOKSx5CdZ0LCfLVsumJghOI7wzs3JJn1jEqUvUd+QOR7ERV5Bnha7zJY/dCDJ1y36WJ4VgFsr1AO8o3fs7ab/GlGDMxoUXVZnT0G/bO9FsFkPFbUeLDqTHQ/zi/YCuO6wFPiWa3UgWXx4z99T4yobKvC4ZbooWaZX7AcB79kFHEsS7YACOxuzY+C5B5yYAgdnnkvMyNsZRN3xEUQV5feFc1cuvEj9+ZSdH14lsVyaMSiiawf3VsEq5tGILA8nu49pGBfcVljmi67Xisyz2PgOD/BhcaYeTaHm5xWdrWVa8wUkL4tzejmWPzHlFlkNKspsjuJVuKGTyNBiuy5TDrpwJ3PKx+WP6M/ShXlsYuGcpxtxOLuC+HJJ1v16A6ICEatGzKuQ0UeufLM8+ts4ZxkR2NDFroFhUYSxODTdHXf4nvZmDApP5h/Ip5iRPt7hVAre0Cjo2k0ZJ3q977xqBX4lw7rbvMBDLMZpWvlosVS1P0s+knrEX8VRqIQ54fup5cguVA6SJeojjrVrESLlK2gvOGb0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb4dadc-86e1-401e-60b8-08dc2c825433
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 10:55:45.3462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ij/4SlLK5UiXrT8mgAnqV2EgW34iil0GCakya/UAiOCFLdkuXSr8QhgRatFuF51XMj8dmPrij+7Ld/XFOSsgf3lsiOrkRU5YvYJy5QRqZeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130085
X-Proofpoint-GUID: xITa5C418mb_NNjlreEjdrTSOMLV_UKh
X-Proofpoint-ORIG-GUID: xITa5C418mb_NNjlreEjdrTSOMLV_UKh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 01/02/2024 07:28, Zhenzhong Duan wrote:
> When there is VFIO device and vIOMMU cap/ecap is updated based on host
> IOMMU cap/ecap, migration should be blocked.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Is this really needed considering migration with vIOMMU is already blocked anyways?

> ---
>  hw/i386/intel_iommu.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 72cc8b2c71..7f9ff653b2 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -39,6 +39,7 @@
>  #include "hw/i386/apic_internal.h"
>  #include "kvm/kvm_i386.h"
>  #include "migration/vmstate.h"
> +#include "migration/blocker.h"
>  #include "trace.h"
>  
>  #define S_AW_BITS (VTD_MGAW_FROM_CAP(s->cap) + 1)
> @@ -3829,6 +3830,8 @@ static int vtd_check_legacy_hdev(IntelIOMMUState *s,
>      return 0;
>  }
>  
> +static Error *vtd_mig_blocker;
> +
>  static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>                                    IOMMUFDDevice *idev,
>                                    Error **errp)
> @@ -3860,8 +3863,17 @@ static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>          tmp_cap |= VTD_CAP_MGAW(host_mgaw + 1);
>      }
>  
> -    s->cap = tmp_cap;
> -    return 0;
> +    if (s->cap != tmp_cap) {
> +        if (vtd_mig_blocker == NULL) {
> +            error_setg(&vtd_mig_blocker,
> +                       "cap/ecap update from host IOMMU block migration");
> +            ret = migrate_add_blocker(&vtd_mig_blocker, errp);
> +        }
> +        if (!ret) {
> +            s->cap = tmp_cap;
> +        }
> +    }
> +    return ret;
>  }
>  
>  static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,


