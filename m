Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F602C4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 19:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZbnd-00068Y-UT; Mon, 12 Feb 2024 14:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZbnb-00068N-Ka
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 14:17:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZbnZ-0003n0-RK
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 14:17:03 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CI7rG6003419; Mon, 12 Feb 2024 19:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vfC/03FqAeGThPSWWmESlaMzWl6cHCGqkzy1rTiQIeo=;
 b=D0NCYS3eMV/A/kmkj5BjneX7aV8ytwl+UMQHSpHmKF5ZOcmnV99/LqQ1WZzXty/07lCS
 qgktcc2dfVEFVlHNV4M4mOqJXkqeuYFc+fcP6K8EBB0nP80JK48MbGFW2bknKpLmBf12
 PIDc0Y9Zm5pd6f5pWHicE8ESzwEFIi5xkXslNqTB28RlXhhKcUXNrw/X1QF7XAAPzEo7
 wiqHYfgCsSOvyQj6eqAR3qm27EXq8a6eOCJ3IJzHmsIK6Jv9b4Ysw4/oqGy8Hx7jZ0xY
 vF16fdtJ2t9IjYHxi0FTSaw/vUE/rDtbGB9aU95nVihzKZFS6DFkr5skMP6hLxpJaRzu kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7mpqgtce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 19:16:58 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41CJ84UG013970; Mon, 12 Feb 2024 19:16:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3w6ap8uw5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 19:16:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SexZzRx6y5xEYiZ1hpq2ndvphH9RsYPYyld/XgW41qgY9DmAqUzHlcYCtaWbhhq7NP3RRXXIUH0FozSRy0ttOnt8QLKLyHSmouJszg7nG6/HCE/qGC0lxqVYUmzrgrisliN2K8Nzh/Cz8k0WYsHzmub+0RCVZQDh0WMfd8veKNqpYHpzT1yXWWRtyPr/1XmKunssH24UyCSHzOhnt5K+lb+hv51xGfM8sJIC5Jf1KC0xfien9BNUmFjSSRueATPGw+lA4SmYwFobld6I7ENvzOdHavhe9gqsjdwhYDMWrSb+j0iW/SKgF1Byjye3C4yfu46EbIfodJv8aGYKGehJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfC/03FqAeGThPSWWmESlaMzWl6cHCGqkzy1rTiQIeo=;
 b=gEUFggfrg8mXplqIUAjknOaW1E6csfL+rKLGD+LogMUK7i5rrQapsMFfFVyup9qwTsJbzTp3LF7I0GUkFpDfVeHtHJFTcr3owS6jP8JR+Qv0/abvZdbI2rQ8f5qiSXkExkmL08mnnshdqMco+0eI/xCXNysSo+uTfBo7+CwxXGAszuY6ltAVoCTBXxxl/CcyPJ8VdKKSUSWNrcP9YX/+HIc/K2yb/VhNf0xIpN2Bs9/djAmz4uIcudnHS8DQO9xjCY3cr3fdDXmH7p9t6UwUtrt+00uPu/SNkFaIDgiUX7nowJ+0sWgQLr3GyNjkrmTsHCcwqvScsj8l1pB7NAVzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfC/03FqAeGThPSWWmESlaMzWl6cHCGqkzy1rTiQIeo=;
 b=AP0jVl+8sqvI5+AW22KunsFKqn/7zWBVWFODLTd+odUtYcpYR7+a3gz7lw53FnIZR4tLZx+KGg3jGtN3BmHUmgo7X0qzrT+sYOyeWcegr5m2ygq/6RLWRjQNV6NxM7ZyY632ZZK/sNSxuB2L3zSW+YLZHpWHaCCdIEffyLjoN+0=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 12 Feb
 2024 19:16:54 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 19:16:54 +0000
Message-ID: <554dff6d-85eb-4168-960b-c50dec1fcd93@oracle.com>
Date: Mon, 12 Feb 2024 19:16:47 +0000
Subject: Re: [PATCH RFCv2 6/8] backends/iommufd: Add ability to disable
 hugepages
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-7-joao.m.martins@oracle.com>
 <87zfw5a9g5.fsf@pond.sub.org>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <87zfw5a9g5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::15) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a758ed-0085-42ee-28b5-08dc2bff2c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiCzMr/UgqA7hQ4AphkAJDOgo12R3OVntsez+cKmuYppfijirl3nhB2BLBHOnX6lhELDiDRfXFwIL6uYRoho9csES7PfFIj/pHdRiYRGrFI7BURXEXGq1xXfydBGOdOIfZUJID7yh2OMEe0w+pOHOmu0/HhFNzd8ZuIGrXaG+xoxVBMjjY44P4enVtA1YrOcSPFSLElvD8bdf4sba/fbkWy2hv+EzA64x1j5jZOX5C5TqUz0DhdsDcIUgVIVbwuNmMh+YgpqWm8SQTIm9+2rbzoQ9XA/eIpPIZMAZilBpAYGOTWfCymzku+WwMas6bjViz3rLuiTr8xsv3DcXKieYb9qFmXBMXLY6UHkeHxNgtU89Cf+UsR+gPl1ly/mUbIPDJGKHa6Y9uXu31er/Mdo+OWxml1elT6qszzlKLo3sydldIZ3rSJ7g2X1PlkI4R/jqQMUBecqGbEGn5ApzpRl1X3kCjpEHmi4nPzhbRJWCQ7mlUPyuuG/0z2VgPMZqKLsDerPzwC59h2/+db6Vu1YNag4bXvOGlds5IKKunm0lgVfWVJjgWjarclfmijB/i9N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(36756003)(41300700001)(31686004)(316002)(66946007)(6916009)(54906003)(66476007)(66556008)(86362001)(6486002)(4326008)(31696002)(8676002)(8936002)(6506007)(6666004)(5660300002)(7416002)(478600001)(2906002)(4744005)(38100700002)(2616005)(26005)(53546011)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHhrdDlEQWg0bHZBa1NwNkV0ZjI1bUVsc2hZS3dVaGoyZXpmMjl5SlowRGFI?=
 =?utf-8?B?TUxWbG5vOWxPSDRaMERyL0VmZUZJeWZ4ZktwWk1BV0dHZUx6bFlSQmYvdytB?=
 =?utf-8?B?MEVHWFprRTZkNVdOL21KSllzdDJEVHArZk91TWlCUDRmUituOUhTdlJEQ0wv?=
 =?utf-8?B?U3ZydXFseU95ZjR0c0dDS1RHdUFBRSthbXkyTjFjUE9CVmxUV3o4Zzl2QVJ2?=
 =?utf-8?B?dlR6NG9JaWdXT2RnNWtZY0M2Um9Lem5scFBLUFBVbUhiZjF6MHhlNWVaYkRT?=
 =?utf-8?B?R2NZazRxelo2SHZXZjR5U0V3UzhncVVvV3NqK3h4K29ENXJqU0tCWkVDeERG?=
 =?utf-8?B?N1VNV090OXVCc1lWRytZcmtiOVN5SU50TlFqbk5MVUZNSndOYUIxZHV2VFI0?=
 =?utf-8?B?S3JRamo1eVhXbFBWQmJsbWJNYWlLTUZOYWhIWVJ1NytUUjJ5TXBHWFFvV0pE?=
 =?utf-8?B?MCsyQm9GWFJCN3h0ZXFBcENYMWJRNXpUV092Q1F2VEFDSmV1d1RYZTJkbG9I?=
 =?utf-8?B?RUZrTHFEc0RSaXNqbjYxTm1TOHpFVk4zQXJ4SVFiWk5aQlBVRjRTM2dzZDlU?=
 =?utf-8?B?enBpMjFnSnN0Q0lCbFM1NVdvWHVYYVc3VVg4OGNzTTVVWTRXMUUvbk5lTUM0?=
 =?utf-8?B?d051cGJBT0o4M2F3TjRVTCs0cW1lckJUM01CaFlmL3owKzRiVE5tRnpuTWNE?=
 =?utf-8?B?ZFVadzRKTUdoclZWL3A4U0QyL3N2NUxBTWpSNGp6SmZScURXK084N2N6RFFI?=
 =?utf-8?B?UEZQSjVzMTczZWhKNWRNMXdORXF0dkZ1S041ZkhXQUwxSEJCSW5qVnY0bWtL?=
 =?utf-8?B?UTNNUXJoWXR5U0ZPVVBEN3dGOXdlcnhCdkNHdWtXc1Uxalh1WlloZUFKSU5F?=
 =?utf-8?B?azZGN2NmMGYwZmFGL28rR1Vib0tZamo0bzVHODdXcStReUh0ZWtzYkMvSDZo?=
 =?utf-8?B?TGZPZmxTL0NQdGtFMlRncjlBVTdZc1liSUY3cjFLV2Rxa3AzejNXRUMyUEFG?=
 =?utf-8?B?WWs2RnA3Ui94Y2tKdWxZVnZOcmowL2h0UnJ3SHpYRUpvVjBpSm45UVhyRWY1?=
 =?utf-8?B?bS95V0JiK0x1ZGhxRmZWUWh3T1VJU0t2c2JrTDFlYTIvUkZnNytCejdzODlU?=
 =?utf-8?B?bE1lRFphWUcwQWNDZ0NrSlZ0NnNXVjNPTVRLTWNydDB5V0lscHV4b3lzL1Yx?=
 =?utf-8?B?cE9MNXZJc3dLSlFTdUNyU0o5cWJOc3JSOWQ1Q3grcUx0cEU2blIrOW1QdDk2?=
 =?utf-8?B?V2hNOVdGdUVyeVNFMlNkbTIxelgwYkFHVjFpUlpXcE9XS05ibzdwMDNaUGNz?=
 =?utf-8?B?Q0szMStQZWlSMVJ5Nmg5cTdQYTUvb25Cbk1mWHdxMHNrcHJaTHl2MklTeDM0?=
 =?utf-8?B?T0VPVjU0VmtSRHBQd0ZFcjU0aWZ4aFBWaDlXZk5ZQ1RTWldqMEEwZVFYQ0w3?=
 =?utf-8?B?ZW9yUWdVM2llTmtKdzRVL0JMaXlaUVArK3NyOWE1bnNNRy9BVDdFZ05xaCtm?=
 =?utf-8?B?bFZnNlVMaEN0a1EyUWp0cnRDMjlXVStxcVdqUEUvUWtGVDlEL25Da3hTQnA1?=
 =?utf-8?B?N3VBYVgreWhuQmxER1EzK3k5c29BVnhDak93blo3dDdjbHN4RTRDVjE5eFp0?=
 =?utf-8?B?RmpJbHFTd3JBemJYUHFEZmVScXpZK3UrYktpbUQ2eWtQZ1RNaGNtNks1K0cw?=
 =?utf-8?B?bHJTMDhZRlRWbm9SVVJaYnE3MHZvQXdYSjEwZ0pUcENhQUlPYXBybnVaNEh1?=
 =?utf-8?B?eklPMGg0aVhUeUdxWmdMT080MXVneWZSYkhaOVcvYlBnTE5VcHpKQkE5czhK?=
 =?utf-8?B?SGNzRXdaNXViNldZODRuTDJMcEZvZzlnVEVOeEJBQ3l0SzdQYUlma0NleWdh?=
 =?utf-8?B?cGVVTjBsV1dLUWFnRi9PNzBHVUpjS0twaU5OMWRCL1VlWG9ZTlZCcDRBQ0Ny?=
 =?utf-8?B?YWs5UjRPMFh6Mk1LTmI4VXh1UHN1Z013Mno0d1o3dDJIRlhuZ2xxdjVkcDhq?=
 =?utf-8?B?Vll4bWlLQWF0NStwVWIxS05vcGtNSUJ3YmJrd1E4NFV0eTZXblNjK0UvVWdj?=
 =?utf-8?B?MVNKZzBlRmhvdms3WFhDeWVFQmF2YUNnMVdFRTRBZkY3TmR3a3UvNWZGMkYw?=
 =?utf-8?B?NWV6dExqcDkzWFdPNmpzMm82UjVNeDU3VzJJc0xWYzh2dlN0Vm9URnhFMGNs?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4gPRExtyqPGi/lbHYsXhz2nBplWNkpMTf7KBpoczebgB7ngF8VmnTYYhJw063LaZqmQYl0cb503eyL4ytWmNzZWhb7XRR6iXnQsB6wPMhO2uRxA9uavERIxVgVOMRQgbaYqK0Tu4KuAJlhCYwB1PC0GJ/eV3Vecr1+RmFbx+vJmcs6AaWRI0NHLEXqEo4kTW0czDh4TesMundcYNcj1erPMoo2LqGENZk3NvPgPgE2iFxGlFzF0GrF2vYV4d3FFW1w/P0JLxxvyOtC794d+FKl5HNt9KGHnpLS94oWiBy+U0o0mXHTahe9EwJdDNivqBP6RjD7pzYjj0t0tLg4mFoOFZi5dQ38tnsmNOL3qlHQd2aK5dbxWpR2KdGlj7PmMmYkYrdkqCCYYJaCfZ0yCqGsgvtydzP+u3QO8bE9GMFwzzXgszIpD3Cidm4xeGgD51eouuETgri+LlrH/fcK3hFDTyEJJ0tCRpZXyK0I5JUtZy5Qh1Di2lnh4uIcj0MV9iX1w10xLgnZdX67dUtMxJhUmTq4UlZNA7vTfzn8RTsHZU/Od7Jw3Iwl6ybzuAgST3x/2l0ibjH3j8rajfGPW915Uuhi+8x3yu6C6GUo6S6X4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a758ed-0085-42ee-28b5-08dc2bff2c7c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 19:16:54.5376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOpoucUyUi+61O72NKUbIUeJswjnXgapZiUIjqzLClusUMdCxhlcTvGVLIQ5DdwnC2myATPUwdNrwvoWYT4Sv9JaMFJANW3OYJGg9bCNsJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120148
X-Proofpoint-GUID: -lMQ00YKtcyhCyaGN4ClZ4YGRQ5nWnxH
X-Proofpoint-ORIG-GUID: -lMQ00YKtcyhCyaGN4ClZ4YGRQ5nWnxH
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 12/02/2024 17:17, Markus Armbruster wrote:
> Joao Martins <joao.m.martins@oracle.com> writes:
> 
>> Allow disabling hugepages to be dirty track at base page
>> granularity in similar vein to vfio_type1_iommu.disable_hugepages
>> but per IOAS.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> 
> [...]
> 
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 84af23fe245d..9ad27e2b939b 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -809,7 +809,7 @@
>>  # Since: 9.0
>>  ##
>>  { 'struct': 'IOMMUFDProperties',
>> -  'data': { '*fd': 'str' } }
>> +  'data': { '*fd': 'str', '*hugepages': 'bool' } }
>>  
>>  ##
>>  # @RngProperties:
> 
> Missing documentation for the new member.
> 
> The latest QAPI PR is making this a hard error.
> 

Gah, sorry. I think I didn't have that PR yet as I didn't hit any build errors.
Missing the doc was pure distraction.

Will fix it for the next version.

	Joao

