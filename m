Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0C5C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 18:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raK8p-00057G-F2; Wed, 14 Feb 2024 13:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raK8n-000576-V7
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 13:37:53 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raK8m-0008Gv-5h
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 13:37:53 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EI017b020810; Wed, 14 Feb 2024 18:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uH56h2RASMMx8MK+fI6q9qmnPnb3oaBLwTwFI4dgKho=;
 b=EeqD/qdwCi7uO+Ds9EwGDTtF6Cysd/6dp4nseJnlvfdsZQkddgQstnBN4lStru14iwhx
 Gf9tnfBVrAnotrrNH/rtpEGbyKTU1MgQ+odX2s8mwPK5XVVbBQoHQYeAAG5a5f7BTt3X
 tZBVwvLXpCpo3e15gkHpWDXazqVeyTMrqgz04YqGXiutin0nY2sxAC/bKV3uxGr5r2aE
 1j0K4hgQrKXh+srWhvN4aWDVY842fbfFB2DvNVXrONtbb+rBNEhhDEbpD7POMoBU90jF
 ftSzgQTJgdMVtCpB//s1gRaQsvDX+iCJJ4PWljgyfEkWXOJCrP94qm7emZgBhtVEZNfF NQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db03nw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 18:37:44 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41EHqZWu031505; Wed, 14 Feb 2024 18:37:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5yk9bdu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 18:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCR/1SARWXLYQqz4PN3hgmhJadV+/KCgVL4YyJHj3f+Q9+XJA9/KfUqcKTkEmOC5mGv0cxuSWZCBwimm0IEvnqoRsCXsqOsKl84CUcVdsuOf8FFDaVykDWL26t6gWnsKctB/EfvK5XDEUK+nTm1n/4N0IAV2JAioORX9uHWYJ3g98+ndSgl7MhWlTpcSAYqR84CSnX+SPAichOpacRi0bfGshlUGIB47OouaudKHkiIQ+6uNrziLKNkf8HOezyHVqpnaUEMW61evjmw8Gs8zzC/lf9BTa8hxyKCOMip+QnKla0E+r5AA4g06rVktm6Goxt2HRIvy6SHqkXs2kiNiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uH56h2RASMMx8MK+fI6q9qmnPnb3oaBLwTwFI4dgKho=;
 b=foWUKLKNc0v28tEm4PGxJaBZ/HPsMpj4+Vmn9glSEe7WK8rNeLpTzzRVdUHAA8CFt4jNbx0oqjuihYpC5W36Adp4+3qCaFZTQES8qUgravsSClJzBiZQnj6zr9bwLdiAJtzEWa74kTD/+LZ/ylHqnDhnSAxi9AHZSRkErOYzoJu1HKoLfAkK6p7WmWzVBX4hed4sptEQoUVeUi/I7C8yk0pPiEck2AXy2c01zbjn86Anxe/lWQWJMhMw2M+kFatxYA9/wS10dQvEh6Sudnl2dKO3jOFoJBCVAAfxBuWa11ziBYoYPhuPLcw9KdNBQ1qz4I7kHNnZV/Hwh+g5VjIwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH56h2RASMMx8MK+fI6q9qmnPnb3oaBLwTwFI4dgKho=;
 b=di8v3SWr7FdPjZPaVu35KVtXUE5pkSBOR22OI0SfxuG6Av+6FSdfSSzuMX9XgkJfitHXPqFQYmTjyqZI11eWgIJfQg7WYMGOq6XjE+mmOea+t/65Yzud0fL0UCjGTkK2igE49RDFGGERdWBVOj5yuyAC/GEz4lPnB42lL1apOX0=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MN2PR10MB4285.namprd10.prod.outlook.com (2603:10b6:208:198::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 18:37:41 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::7368:33a0:2dc8:38c6]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::7368:33a0:2dc8:38c6%3]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 18:37:41 +0000
Message-ID: <1bd4e4da-9ac6-4211-b997-c4002e9ef397@oracle.com>
Date: Wed, 14 Feb 2024 10:37:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] vdpa: move iova_tree allocation to
 net_vhost_vdpa_init
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
References: <20240201180924.487579-1-eperezma@redhat.com>
 <20240201180924.487579-7-eperezma@redhat.com>
 <9a919f49-cf88-4c72-92ff-f0c18a5593f1@oracle.com>
 <20240213052102-mutt-send-email-mst@kernel.org>
 <CAJaqyWc-OCKf-WR+h7-FoQR=iPO=9tXj3zCDDXNTT4TcejAQ_g@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWc-OCKf-WR+h7-FoQR=iPO=9tXj3zCDDXNTT4TcejAQ_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MN2PR10MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: a184d2f8-32eb-43cb-5d53-08dc2d8c069f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXJ7Y6pouIr9CvrzX+amT1RmeGet0uTdcRcKaQe4kMnccf/xZ7CVeeQgcpJeGbFp9gj43VezIdxLzKBBQ/VHa8p67yjztnZ6/T6TpvXnquAu6aQJRT6UyzmgkElGdVvE+XU2zZnQhJi8SojDXgxYK/J8hI/KXlQecJ4qhqPXWVIpZjWmp1bs6kxWUFpsAIj8HoNx/ZVxSIHoKBhUX92cpNstJ6pE3BpF+ChqGoPoxuDD8Ut5FpUe6cx4SthsEG1i8bg+biVffLlqEuJVWFDtOISE11L8cP/Jqxg45GHDSMjjQh53SHHCDz2BQ9c8uC/EDCewDi/S0jxqwzNbOSCjLBVKyFOvHGwfexyWLYhBqu2+ZkTgQCuW7QXTwAcVNj5+EVgbRqUuD1YizPxyabiMppr8f0HqZWH7UCkqNI1i/agQIxvejT5VceBG2kGXXAlJf9Kyd/MnvAmVEJAuWjswrNYitWIertaNncIMlxut4NJkP2BSi/ylr4UCaclEwfNd6XVr/M2XVti1x+qTgCqHVlcSRG3coeWseLHJ8uN/dcMDPO0on50l+SML2vwKHNYa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(36756003)(86362001)(31686004)(66556008)(5660300002)(66476007)(7416002)(2906002)(4326008)(8676002)(31696002)(83380400001)(66946007)(38100700002)(8936002)(110136005)(478600001)(53546011)(54906003)(316002)(6666004)(6512007)(36916002)(6506007)(41300700001)(26005)(2616005)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXlCWHBxR3I0K3hZc1BYTjBEUmQxRVRTWXpkdWtld0c2N0kyZFVVUWhUY20x?=
 =?utf-8?B?b3Noc3g4QVNGdlFQbmVraGZaeitiYUFhcW5lRW9tZVd6Nm95V3FHUnhSK05F?=
 =?utf-8?B?NWhPWDBra3ZCS0dCamtOcjlpeTNYUWZZOWJtdFpmdmxKd2U4dEVobitvZTF0?=
 =?utf-8?B?dE5PcU5UUUw0UThrUTdhK1ZINHpFTENIMEJpeG56aHlsdWcwZzVDOUpDT0Rr?=
 =?utf-8?B?S01uNEZsdDZ0MEZtUmViZ0syWWE1K0xuK2dKSk9RaUlQWHFuL0VwY21JMkdt?=
 =?utf-8?B?Skp5T0NsUWxEWStMT3loOW5JY2VmRkNZNk5mT3pMdWw3OFZvY2VJSmpwK1NN?=
 =?utf-8?B?TlpnbDd2Ykh0WDNsd0F4TVBVZVE1Wm5KZGxZdUkwNlhHSk5HWnFETFNLZjZ3?=
 =?utf-8?B?dmh3bkt1NXc3TmE1bVFWZk9BalhPUi8rN0V1czVpN1RNSDZ6M3FIQlV6MDFO?=
 =?utf-8?B?RENWOFJkWE8rbUQ1ZVBwVzdmMVNuZEdkOWFCZWZqcENJcElzVkdrMk5uWE4x?=
 =?utf-8?B?eHdXem9QajA3SGNybHBxSTNNcVNvbk5ZeUg4aHljZmRsdzdydHRPK1NmNmFT?=
 =?utf-8?B?aTQrUWRsMU4yYjkvTlhkdlRKcDVVMEd4NndCc0F4RGdZNFA4V3BQNzkvYng1?=
 =?utf-8?B?a1ZWSWx3OU5UdmFBcHNPTG1JZ3VFcFB0WVBQejNjcE5NSHFUcmFUMHR0NkV5?=
 =?utf-8?B?QmFQamFIakEvZ2EvMFdVa0IzMVVHS1VUOTB5SEVET3lWT05pTjBSdGlKQ25r?=
 =?utf-8?B?UFBpTnZvcUVUM2g1REM3WEdLZ0VJazZLWlpBbFE5MEwwcDlLNC85WDdKZW5N?=
 =?utf-8?B?NmtlT2tHdDBQeUhqQTgyY1ErQUljL0dFbUFLQktmOERIcm5MU0pVbDFoKzJB?=
 =?utf-8?B?cmR3MUhJajIrTEsxb0diOEQ0NnNQWmpsOU1wWkN6eUdXTVZ4Tnc4aEM3WXl6?=
 =?utf-8?B?UWJoaUZuOEYyaC9xc0Y1R0piWWpVaEFRNEVINFl0TFB4NHhuRVpGdDZoYUdj?=
 =?utf-8?B?L0VqbTc1dFRnYkx6VEtvVE5ZWGttOE9WTTF4Qk5ialBxajltUkRGWjFLc0lm?=
 =?utf-8?B?ZThDZ0xJUGlhVXNTQ2V5SHVqT0NTcERaZ1ZVOGlkZkl2dHkwZEIvZkZXU1RU?=
 =?utf-8?B?N3JGQnZva2xCejN3STQxcys3RmxoNzNFUHAvNXcrRDBtZEMzbUh3MzlOYUx5?=
 =?utf-8?B?Z1NXZ1BMNlduaTF1YUxkQTZUZmV1bEJIbmZtdytXeHFXNHhGK1BidFVseE9p?=
 =?utf-8?B?ang0bjN1SHdQMk1JK0gxcmQ3d05nQTBaTEV6c0tOLzIwdkR2QzFYNnlndnMz?=
 =?utf-8?B?T2RXRS9EOE0xaDMwc2V0cDUvb0FLaUVWWGxUZzZWaGNFbnVKTFF4Y1hwUXds?=
 =?utf-8?B?ajl6TzBLa0FOcFFVY2hmdkRqNUxlUE9FSDYvZlhhbVIwT2ZOcnIrUG05NlU3?=
 =?utf-8?B?c0ZuTzVZalRxMERlemFlNUI4dUhWLzlHckNKMmdUOVMxMTdzOXh2SXVwcCtw?=
 =?utf-8?B?MzRzMHFGVFFJMExRUTlUaE5QRTQ4eVNIZ2Y0SDMyUGhKTDAzcDhDR3Erd09x?=
 =?utf-8?B?VzhZMlFLTU1rdUtMWUkvOEJYdE44ZnZ4WmRHSHRSUWxpT29YQWhReVEydVdR?=
 =?utf-8?B?TzNsaFQ3NzNZRm94NkI0Yzl3MjFFbW5DL2xNdW5tRVU2VkJSZ0NKNnZrdmNj?=
 =?utf-8?B?cjJQbjNrenRHMnpneEZoL3JaY28rcWEyMGRsZDBPRi8xR21ZU1lheU43WTF1?=
 =?utf-8?B?N2FaYXRWVTdTcDhTcEJKUS9YNittQ3BWelVVa2d5QnNMdGhZVG1hU2JtV3Zj?=
 =?utf-8?B?eStwalhXZzQxalVldFdWbFBRUWc2djliYlF6REFkZGJEUllyMTVSejJVM3Vu?=
 =?utf-8?B?SE5uZkZIaWlVN25UK2l4bTZkSzdTVnZrcWRGL3BtZDNrdnloUmk2TFhFTncy?=
 =?utf-8?B?dmJGS2ZOTkw0cHNFNUVWU2tHeXVGK0lnVkcreEhMRkh1Ulh2MXRDbzlIVFFK?=
 =?utf-8?B?VWZVSHZtOW1HWmtNRXh1L05EeXQyUjlvSHdPRXd0U1ZmYVlyTGFZS2RTa09o?=
 =?utf-8?B?QTdkN1hVT2lQMysycTMxZFErVXEyNGFWcndBRlRXcmp1WE0xcEovS29SWDYz?=
 =?utf-8?Q?heRHE+TZTZ+uQ+Ae6jP80+w7J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BYg4wI1Bb1qNSnvo19i+jkaTNy+M2cypjx3RkmEIXyI5DtDxh/xDLf2Dh7nJzwbE4p1vrmWlkuADhDVaYWAKel6SoW9YcfLRB0ErOaTeeD407L9sH6t0H1bvYr0wBX0AuI3CenfZmWjA0cxfh/oWxpD8tXqrjMoWTf6vJqDAOqdrx/u4u6h2NLcjIn+e9SZ0y3LLhgL6CO4YBxvdeEWWtOFiAj5d2aB8eZnuF62FOQ6GQg0380Zf1hv40FS16RsgaEFjRPUIX9vl/wQAxOf2Ic7d+F8OvA2StAvjEkZUExRNnvkAETQ30aWjtmM88+WTbSlIS6NAhPJ8T6raf8E+RzKKjRkUS/jq+NZ50+AH0wScunFPmlCImoTVRSEp/s15b/9fmVu9cmDkPgW+mB4YI7FoXhxKBX3iC0mzMyNm9k6AbdrXLuEfNxq/K1PUpimcAt1PO/lW6WXPVedpg+Xn6CsHJT3iXrAD3Ghjt5hTsVviMJ0CW0W9ubAaVRrl04lTwPwpXx2CzAOONXvDKhuGaUGZA5VKQK+G7yS3FD26GIrSZbJZ6kRFeLgZ0BaV671Eft4x/9IeMlCd6d0aO8ZTi4cHwPujWvXlj5Oa7FPN3J4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a184d2f8-32eb-43cb-5d53-08dc2d8c069f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:37:41.0631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jst2fhkDEAhLaz4dAIrHfsrbjkes2p6P/TzU+ZpojZfkyWB1qpw4Kw90GXa+d6daTJO85TP06GmrKGEEZuP/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140145
X-Proofpoint-GUID: oAexKvfOuSMlj0wfqQ9s-Fv0odyx2jWf
X-Proofpoint-ORIG-GUID: oAexKvfOuSMlj0wfqQ9s-Fv0odyx2jWf
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Eugenio,

Just to answer the question you had in the sync meeting as I've just 
tried, it seems that the issue is also reproducible even with VGA device 
and VNC display removed, and also reproducible with 8G mem size. You 
already knew that I can only repro with x-svq=on.

Regards,
-Siwei

On 2/13/2024 8:26 AM, Eugenio Perez Martin wrote:
> On Tue, Feb 13, 2024 at 11:22 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Mon, Feb 05, 2024 at 05:10:36PM -0800, Si-Wei Liu wrote:
>>> Hi Eugenio,
>>>
>>> I thought this new code looks good to me and the original issue I saw with
>>> x-svq=on should be gone. However, after rebase my tree on top of this,
>>> there's a new failure I found around setting up guest mappings at early
>>> boot, please see attached the specific QEMU config and corresponding event
>>> traces. Haven't checked into the detail yet, thinking you would need to be
>>> aware of ahead.
>>>
>>> Regards,
>>> -Siwei
>> Eugenio were you able to reproduce? Siwei did you have time to
>> look into this? Can't merge patches which are known to break things ...
>>
> Sorry for the lack of news, I'll try to reproduce this week. Meanwhile
> this patch should not be merged, as you mention.
>
> Thanks!
>


