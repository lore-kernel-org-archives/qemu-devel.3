Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72045C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrVg-0006Yn-7r; Tue, 13 Feb 2024 07:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZrUW-0005Rh-4N
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZrUN-000177-6b
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:17 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41DBnweO005680; Tue, 13 Feb 2024 12:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=AIhwDxXQQLm+L9c9k4nccVxl2uhu2NpULKfJEJn9xsU=;
 b=CnISKKfggfYk4JsFHs7t7zyuMHEAosAYlb9jwKx4LWtV+Gnq4756u/ftDUQt84qSCrQd
 UJtAPtMh4wIu8MDIHHjmZ803Gj0Ycyc0t8Z/ngSt/567ETLQJrgFiMhY6YZl9A9Yod2b
 MKujBqI3aHNGleMsPmFXzXgEZ4Lew4HDYP9+hdpsAh3yDhzLrxaBowjk7cgFDi9FUnfF
 67a3ymaJAcX3f6ERf5EFF4dALKibg1ypxc5OFtEqaP48HSi0jUgWU6IMhz6etQKx6qaM
 V/qT1Za7Q63NNp2/mJWKEUd53dMvoT7ct3HPtWCqeKgzcp0wmB9MdpVU850jOizNyXU3 vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w87w4r1ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Feb 2024 12:02:05 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41DBwvW5000716; Tue, 13 Feb 2024 12:02:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5yk77pe5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Feb 2024 12:02:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnAhfm2NmZIae6+WcWB06gDR1HNbSFGXxX3w6M5JT7DKwKSEi+sSisp/2KbONOlq4w12T1/lLuDdX4Nz9v1CPM2ETZ607EQGdf7DWgn3PyWb0AQcgjl9GJnhy/TGkygPqy2Zhe3krIokVGWSjmJMPCkT7qhhmYDoi+NZvW4uo2LTB4kyqWvYurIp0VStDVamKor90IGRHDJI6bLFMQwYhE3qbv4s2VkEuat103ao81qB4+WgU/gWJ+ISD7QS1PFuz7AYtoiPlvTUMsYGVB5uHbasiRaL9AIZh1IYGMorUD3bdUWJ41kxp1mOgZ0oXw+6Sgk6iBPGtpEeU6KhmG8Cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIhwDxXQQLm+L9c9k4nccVxl2uhu2NpULKfJEJn9xsU=;
 b=PfN2Y+pfKO/ADUOZYMuaUT0rXEDOKRWWku6DkFcPlU1aQ8McmK2pY/OvqAKafaDmnVGSfI8l8YdsCMnfS4ohBbKWmveNw+6sWuEMwe8v7OQG533Uhklw4b6vugHX6DJB2r3zTj88xSt7p7zBrE4a7lMYAMb2rpCa/EB8M1cwnTB/bnUxQNmAd59dIeUcSxioYOB+wJrOgtBrlWlh5NSzeY+81zXX/zdQBCpKK+jaVmufSLcuYz/PsxqKO3RB6ChT0c9xF8CBHd7etdZXXn2+/wt70IBWLtCRQaEyLk8TJ7k3XzQpQoLqoDn5aKGdmUz42L0FULGcB3JXfR06WnUEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIhwDxXQQLm+L9c9k4nccVxl2uhu2NpULKfJEJn9xsU=;
 b=Td006vRBGRnAs2xmTqL/N1KegWcpmh0vu3qSvO9T6r4m/IsNpLMyvEJ6rCto4/S1dpdxpMuj/2651D7q4MEHzgi40Hn7UYIZzj+dxIHvE9KJo6AAWJTyrgnhwh2dnTu+walWWQ24BmLgcc9c6/C9hxsJ1k4Tb/VRiNty3HdiNd4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH2PR10MB4264.namprd10.prod.outlook.com (2603:10b6:610:aa::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Tue, 13 Feb
 2024 12:02:01 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 12:02:01 +0000
Message-ID: <b776955a-661a-42a5-81fb-2573122fd6d9@oracle.com>
Date: Tue, 13 Feb 2024 12:01:54 +0000
Subject: Re: [PATCH RFCv2 2/8] vfio/iommufd: Introduce auto domain creation
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-3-joao.m.martins@oracle.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240212135643.5858-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::7) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH2PR10MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6c8947-049b-4131-7f2d-08dc2c8b9632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bbLH8CoE1Qk7EjCSpjGTtLq8SUlhuec6Iu517EyPhcUzkOqtX1C6hnatdYp6nKfBiPkZIerB/AKAKSGJUne2nMcPVGMJQlYOroswmHSwZnGv7yniVEWT8o2MmQ/nL0KtuTIsZHlbQbsxhJUrLLJTmY7hwicgKuxYsAXe8BVC5bsaVCGWCjLCHqV5eyyxJH/3Ano8chjKYFNYJmYSUqQa0OZipu1YENIq8Pu1t9zAhSycxPjQ2Ct31xK8ejDx8grhrhYm9DGS3/nhnVCXz9K5L8dEr3vKkBQ7lnKX0Bj5vi3LOt1y6gtU3f40xnXq3ub7oZCy8P6CihTUS/IcLYBLblZrCjUpVZiNXhxAGVINbs40ekau6hMGgjqwoXkLEK5LkENeyqFWdYM6TkxerOeN4EKUqpA8vejYydllV9XYHUVozW9rQ5twTc96Q6oDtvJ1yHzCS1lT2wIqLVJmM4UCTGeKj1TMVoxV5jTQhEraD/QiYmdiKIhexrOR+eRpp9VGy0k55rky9y9S3MpN5RnVCJWQfvoqWtRlgdVl9e3YIcKn/DKX7YwpMj0qCcN4dDy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(7416002)(8676002)(8936002)(5660300002)(66556008)(66946007)(66476007)(6916009)(4744005)(4326008)(2906002)(36756003)(31696002)(86362001)(38100700002)(478600001)(6666004)(54906003)(53546011)(6512007)(6506007)(6486002)(316002)(26005)(2616005)(41300700001)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGczUE84ZEZDdVZoelpBbSs5S3h6alBOVGJ0U1djbHV5QWNpaWFnREt2dysx?=
 =?utf-8?B?VmdSY2owQTZYNTdrM05FRlFXSzY2TnZNOGhJdE1GNEVUdFd0M3JsRjFYcU1o?=
 =?utf-8?B?STZjUEFQWmRxaUh3bU9ZWEhHV3dMU1R6MmM2ODdqaml3TCtqUTdyaUVzdHBO?=
 =?utf-8?B?UUoyODdUMm5mMG9Bd291SEIyMlRmOXFHeWEzWHZwY3FBRGxHNHM0cStmSEgv?=
 =?utf-8?B?R0E5bld6WC9zUGpUODF6VkZPYytIanZZeXdoczBnTkt4N1ZISmd1N1QycDgx?=
 =?utf-8?B?RG5Ua2JGTTVTWHRSUGIxRUVScEQ3ZWJVMUtPOGlQNUplbGN1Y0MwRUxWWXEz?=
 =?utf-8?B?WUo3VFlvQ1gxL2o4NjhUWHh5L3B6U0dNUlEvVGZSUnN2bnVvYmlqLy9sVmlj?=
 =?utf-8?B?aTh5UWFqUjIzRUFhVEpHczBuNUx6ODk2WkVtenVnM3JWMlhJR25haUloTzZE?=
 =?utf-8?B?OC9zUFBqUkE4ck1mMGNtaDA4cGZvNi8zWDExY2NQeTRaS2J2OFBZSEJiS0x5?=
 =?utf-8?B?Nmo3Z29hbDJNdWlzSU5EREdhY211dUFQWjlOUXZTbi9lWGo5QnVLZ0x4cm9n?=
 =?utf-8?B?b0h3c0g1cXhWbmlIcHRPdWVYMFJKRWJidXBPbWhpY3BPRlk1M0JlR01OVEk0?=
 =?utf-8?B?WDBhaEJVcEtURTd6dmR4SEtBSDVOK3FxZXJpUGNUQkcwMW1nNWk0WlpFK2w1?=
 =?utf-8?B?cnA5eW5QcjU1QUNmbDdlSGNlKy9xMFladWZnSS9RQm5MQVc4ajJXM1JYSEtT?=
 =?utf-8?B?Rm41ejM4TDRBdVk0WDY0Mm5lM0NBbHpYdnhVTGtRV2FsYTg4d1ZWbS8wUW15?=
 =?utf-8?B?SXJsRXNjTXJldDZ3WkI5b2l6TDNDMTA0UW8rRERQN3FieVNyZDk1MnRkWTlo?=
 =?utf-8?B?OEg2azZtQ3gvQ2Z2eFpLZGdZS1hDeEhzU3NaWVpFRkZxMXZSdnBpUmpaSzhN?=
 =?utf-8?B?SnYwaXh4Y1BDT2c5aVFGWEJUOFRicFViNjVsLzJicDlzNGp2Rms1QmgwYm9r?=
 =?utf-8?B?T0JXbmNkcnFIWENOZHUvcjhDdG9jZkNQdjQyUGE3dDdHbFlrSC9nc3Rldito?=
 =?utf-8?B?MUh2ZFB1RzAyS1QvbVl0cUJNQmtldjdINmlKd0puN09ha3NGWmhRU2pnOTAz?=
 =?utf-8?B?ejNkamQvdmlETUU4VEJaOVZ1eGVZYlhFU1FwbUVWaEUrWXdjcnhPMytWcXh0?=
 =?utf-8?B?a0hlTEhOaERkbFQ2RlR1Yy9zdWFObXRhdlBJWHo1OW9GUkduQy9rSTh5VndY?=
 =?utf-8?B?bGg0bnJER1VqYU1FMHdEK2FEVFFERUp3M0dvbGhueE5RM2JnYjVQN2pLNjhJ?=
 =?utf-8?B?SHBKUDYwWGM5VU56VFYxZDR5ajljRW1VRlhSalpCaTJ4ZnM0TmZFZG1WRzVt?=
 =?utf-8?B?WUk4bWFrM1kzUXVBZjVsb3daNk5QN1dYWW1BYVd5aS9WczRINTNOMkJJeFJk?=
 =?utf-8?B?dnJWaWROOW1LR2JDTEN1WDNjYi82TDhGTStGU3A3N1djS2VjWDVFQVlWazd4?=
 =?utf-8?B?QU1pM09tRzZRRy9iNXRzMGgreFlXYlpRcUtFTEhieGhreklhQ1J6OURCWjVC?=
 =?utf-8?B?K3BRSFlrV3UzN0dLSzdFSVpsSGVZSFk3cFBtMjZvZlJlOEpWZDJWQnorbmlM?=
 =?utf-8?B?VThJOWhYK1ZkZG1JeHdDTGtEYTBUaXZ6bCt6OU5zVmkrdDhFMGU1bWJKSUZk?=
 =?utf-8?B?enBVa1ZRWFNBNGk2TVgwVUZ4Z3g3NGJXa3pOdXl5Mm1BbW9iVHhneDFlMFYx?=
 =?utf-8?B?akpaYlNkTnpzMlVsSUkvSVpPWHV2UFN2UUIzYjZEYnJjSnluL1h3SldUbTJ1?=
 =?utf-8?B?RFV0Z0NjTHNCOEdwb1JubncrRXMvdUJxQjFoMTlmQytYL2hzTGxvb1lXMjNN?=
 =?utf-8?B?dzIzWFdMZko2ZDZqU1R1QzA0T0hXQmQwdSs0UUpGOE9kOURCMzlpMWx2UDdH?=
 =?utf-8?B?ZUpZMGtGVDY4Qk9UaW1hR2R0a2Qxc21rOWQzbzJWcU12ckNEOGZaTi9WQ2pP?=
 =?utf-8?B?cUhxTDlndGVTM1o4dGU2WGo1NWdaamRmS0grTElxNkRqdWNzMHF1RzZJN1g2?=
 =?utf-8?B?Smw1SlpnWVZpYytmSlYxb2M1Wnp2Sm43WUk4U2RPcGE0enVBK0VDb3kyUmIv?=
 =?utf-8?B?WTJRaUU3dmFFZTcrNXYvUmtadmRUaXRhdWZWN01kd2ZBa0FlMThmVHpJWWNy?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1qlRSXLDTeamrIi0rmVnNkwqOVhVvOoHVGsXeFf1nGvCObSdcv6gsfsvxDGFQiTAyAkdjiB4255nii29WmB4rnq3CUCF6GW6/5HZcBWKMdyoLVvW0BbdjnbKhiMmro18F3znIzL35NGcc6PhngdgO/EFd045clprWjvfhn0UVVljJT0K89w+GtmTcn5ynqHAwcRNpBZnBwC5vM1fr460xo92t4dJnq3x9SBIVbBrvdO/8HMe/lHJOySK8kYvJkyhXIwp0q+S49GghMyw5mhvmsAaB7xApS22CwvBQ232q9nwnHwY289one4vxrNKr0r/mV4oNyNNQGUfWcHRk302na+bb/aLucLF1AtkHEljETrg/ibslhmzxz4fTndKv/k8U1+9LGbFPH36BmoF11b9u0s7xGv9dyODAml959jbhSSWKSkeoF39o5uesm05hYjCWzVNQUhFCUPPd1H8qP+fN5IlHLwSJy1Hs/CmdiBu+jVklfQ+stIUr/LRhA/XzRz2BHNTI204HiF2n2jf0e7Nns2gYTPmeTb813QSdzOhQdssifcOibHYcQdu1MfTuebZIRlNDsQgXReb6dzL7T1MH0La8FluDUpj1I9Bo6bPjM0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6c8947-049b-4131-7f2d-08dc2c8b9632
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 12:02:01.4162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmWVQdE8KxVBOn8v0EB//kFDZjCq78zL6FkZQtVllGAX4f/H1IdyYaQ5f/bQwMWtjvAKp9EwpiyyKdoHoBpVp0dLWz63N6dOjYE5wP5b/8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=939
 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130095
X-Proofpoint-GUID: y8dn89WGJKDpANG1MRC8JZZAD_p_b_mQ
X-Proofpoint-ORIG-GUID: y8dn89WGJKDpANG1MRC8JZZAD_p_b_mQ
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

On 12/02/2024 13:56, Joao Martins wrote:
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 8486894f1b3f..2970135af4b9 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -211,6 +211,35 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>      return ret;
>  }
>  
> +int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
> +                               uint32_t pt_id, uint32_t flags,
> +                               uint32_t data_type, uint32_t data_len,
> +                               void *data_ptr, uint32_t *out_hwpt)

This function looks to be against the style of the file. Which is to have
IOMMUFDBackend as an argument rather than passing the file descriptor directly.

Likewise for dev_id now that we have IOMMUFDDevice structure.

I've fixed that for the next version (whether or not we require Zhengzhong series).

	Joao

