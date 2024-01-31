Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834C3C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 14:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVBZD-0000L8-0i; Wed, 31 Jan 2024 09:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rVBZ7-0000In-18
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:27:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rVBZ2-0004QZ-Qh
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:27:46 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VERgoO008216; Wed, 31 Jan 2024 14:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=NK14kT8yqggg8jyw4mZVedswKTAFEOHZrwBEZFeK71k=;
 b=TL0V3wYPgIMSyn34oaztCTWYD8JIVRdLKnhVdPPe8R60hfn0rmQvnhQZHh8cknj5DwQl
 26t7zqiDqkf5plJew9kzys8H8OtxTBEp1JYE4cQ6+BwLYz2C8/BPpdXmTEhrYvjg922p
 gIz273auToAoaNASeV308tZg8WwHr8aPjEfBU3/IWKrOViaDB03DQeZEZHp8bxK8Y/kb
 cykUqUBBJx4ill6Z5wsnuxmEmwR7DvuAkk1pyLyO9PyZL+jNzt35zELN7q6f+7Wb6fgb
 LEl5R4M7SOR56gASGTY9Sy4q1xTLGaRL8XN15xGCAk6bHh2siImiapTBKEt7XzJ0U0Uq Bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8ehs2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 14:27:42 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40VE8XXI028451; Wed, 31 Jan 2024 14:27:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr993c7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 14:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQa6IkoqtZisorS8Sd/5mv33xEvPLUchY3wC8kw1MSFbjtOIBPzcnZ+6jjEPs5ZVZ/n/AJvYQB6+8mS/PGL7y4kuLOpWv3ZNBaNkfAHjt8VHHia2eEG0tMae8oXxG8A2xdu77lEefzKQ/QBkcfe/1PNMfi+/zyIXGiF9qhkStbKV6t8okJvGSoUPmQEGf4IH5Mml2e8wSkAr83vtknjXWGaI3lS1kiTBnWJE/yiFuthRn11+zQEYFvknI7fp4jeC1zil1PvPlhGUwpOc9PZ6evuqioNu0b4lli1a7klkpx9sX5fs6MsNeC+poYf8N7FPF8b2TrG748L2DEne2iEDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NK14kT8yqggg8jyw4mZVedswKTAFEOHZrwBEZFeK71k=;
 b=EPhxYPL6kTKSlnktdJeoUtErTC4gRxfu2u7XhvpMc921WepQMAFmNJ5pPWteREoayfFOb4MOfs91fwdKCXMHTKPQorfymPG00zKHoc5e9VOmDwZMoSigPBMYDRsxJ/2OF19FaHHNmcOx3+M+INmC8naCJpUR5PvcMxY/MjDsV1sv5wuEr7eMiLyxIfWJc8ZCmZB6Clvub/QPFodCUnW3jDLrloiBnqkLdJmjZJLp2tG5tF7p0WLMFAETr2JZkHP9Qvkl8RgN27gklUAT8E8R+qFgNheDzDS4T4lY1qlljAnU+cqCnEMXVWkpCTmkIQCY/hMuXtzrqRSztIctskJ0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NK14kT8yqggg8jyw4mZVedswKTAFEOHZrwBEZFeK71k=;
 b=WjvosBatmGvA0HMFRinINTgr4q2p21I4g5kTprVzGyqMiEKBwHNVARbpGAMlLx+SIO8/tPuPkER+BNz6kw0cCy/okj/fJcNA3KnAfTv46AmvRSsJmP7gaXNFf5EKYe3c8kj7oI9zCzFxTDD0r6SR0AzVe0K/tVvyCg/XtVtSB8Y=
Received: from SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16)
 by MW4PR10MB6464.namprd10.prod.outlook.com (2603:10b6:303:222::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 14:27:29 +0000
Received: from SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535]) by SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535%7]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 14:27:29 +0000
Message-ID: <578395fd-9538-4d3d-85ea-f5e9b95b8bd7@oracle.com>
Date: Wed, 31 Jan 2024 08:27:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] oslib-posix: initialize backend memory objects in
 parallel
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com
References: <20240131134843.3074922-1-mark.kanda@oracle.com>
 <20240131134843.3074922-2-mark.kanda@oracle.com>
 <46fc0732-8735-4440-b14a-13e2389d7d6c@redhat.com>
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <46fc0732-8735-4440-b14a-13e2389d7d6c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_|MW4PR10MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4f3efc-7235-496e-a1ca-08dc2268c0f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/nSAmZZkRXzc0+CYoyqqD1P0mRXtDObL9Jbr0EDO7V/+GOPIvmj5TrYPv1/y5SN8Dx/PCxDQBF6LyTep9vZFti5VsHNnc5WWK0SP6xo2wIUOmo6WmU17JUytmXPnzM62aC6er93KSlmGmk0xjl5CUlslfniJ3TDr+sP3V1/j3AqMs8E3KTsCCwnBtRTk0qXdZfWfc7mwuP1YV71ecSZYqsQa/8u9b/YMJs3+XZwvJZq2LdC1JoGJntN6WLqEnahsjVOZOHxIfdhrhIaVmzgXXjvDLFojW93ZBma5FNR/lbIwZrVHeLOWb/DblY2IDdNyajiQNR5/zRy+UKkIEVKMIUTX+EykdNj2Z1O8XDTLX4mcc/As77Sx2z5/arGMBVdaZGtuJqI2adYhKhvdqA8X/Kucrh4MR1G7faamVzwaQWlYsqqFfovL22mGb4WLjPaF2NzdffMEzd49lyZfNej1TxNYzpvfhO/DXIT7bp7iU7Xb2Ng41XhrIengerthyeCm86nfW3qEMdF7KzTiToxfG6qDFgg+1McfSKA7OZMW6YUuCje9fVjp2HULO9jm8sf+GokWy5/cjYXFEbudPkprfxoAPZLXTh7XEGMchn85AlscAb7xbRwclH0VRy+h+jjD/ib2jRkPRG0CPrKSiHBVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5841.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(53546011)(6512007)(4326008)(6506007)(478600001)(5660300002)(316002)(26005)(6666004)(8676002)(6486002)(2906002)(83380400001)(8936002)(38100700002)(66556008)(66476007)(66946007)(44832011)(2616005)(31686004)(31696002)(86362001)(36756003)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9IM1cyV00wZVFIdy80UmRta0pGNGRmSmNlMVFIRzc5S0pDVVNSREJmaXZ2?=
 =?utf-8?B?T1BzZ0dGUEtrWmlIaENKbVpqdzVTRUVvRFJwaVN2ejJSWXBmT1V2SEh2VTBy?=
 =?utf-8?B?NlhMaGxWL25NVE9raHlMS01GWGhrVERPS3A3SlhuRWxaMC8rUDdwNWZzOS9h?=
 =?utf-8?B?dnpmc1QxMll6TkVvYVIxbkdkOHloY2hVQXhaWk5LQ2RsZmJxYWRDWGhMOFF4?=
 =?utf-8?B?NXZXcDczSHo3a2dEZjR0Ny9WUVRzNFgxczRMcXRLRDIzWXpmVDQ0d3ZMamk1?=
 =?utf-8?B?TmZnV1laUlBKVElUa3JLcHRNZEJXSEV5NGZ0M1RYbUprejBoQVdBbjYzTlhn?=
 =?utf-8?B?UXRHakdFVnBUQk1WYjUwZzRWcE5hUmovTGNpR3I4N3RDM1dXMHRCZmFxWjh0?=
 =?utf-8?B?K2p6ekkvRmF1Ti9pWFJ3dU0wdXR6anZVaEZMUE1qMk1lcWU0ZGY0RUpwV1h1?=
 =?utf-8?B?QVVReEEwQmV4bGVnNTZJYitGVnhNbU5MOXBtK3NmWStiZittQ0tjWG9CT092?=
 =?utf-8?B?WWhiOFBBS3NYSmtkK3REZFV3YWEzc3lBOWNEZEFlQzI4dHV2MUd0VzUzb3pu?=
 =?utf-8?B?TW1RSkN2UnVUSGJnK2NCQnRBTndJd2VDOG81bnAxQWU4bGFjUHliODJLM3pj?=
 =?utf-8?B?OGYzbmxSaW1KMHdxb3BOTFRWM1EvZ1hYaEpEcUQvN0JpeUJncUlpQnp6WUhv?=
 =?utf-8?B?dVJCN3NOUzV0eVZBQ1krTGJhSjJ0QUNqeitGWkNDUU9yR0VKcUtxZGJIS0VX?=
 =?utf-8?B?OWdpVkUvM1BuUnNySFhjaTZsYklHMGMwejBnekFpVEJZV0RWcUJsbHc1WWk1?=
 =?utf-8?B?Q2FiTzdFY0VqOGJuQythZjZPN0VUb0NSYXRzZ25DeWNjYmVHOTZOWnB2TVRv?=
 =?utf-8?B?Ung0WGNOaEJ5a25wcC9waWlBSmZnOEZjZWpsSHNiT2hWWWp0Uy9ZQ0QvY1N5?=
 =?utf-8?B?L2FhRGR2UzRNWlR3bk1XME9vYmFpMkgvZmx3VjdMNU1sNWgzRVk5WGVJak9h?=
 =?utf-8?B?Q0NsajhIdHl3ek1kazFTOUVaYTBHbmRBR0doR1A5MFY1SUxyS2pBa3I4dHFC?=
 =?utf-8?B?TUpiRzgwK2IrWC9CQnBTVmJwZUJ2VXAySTRyR0NtSDZjVmwzRGZSWEg4VDVF?=
 =?utf-8?B?V3lBMjd6MDFCcHllcEtQMDdKc3l3Rk5CVmVuVlZ5UmxUcHBaUk9mSGdhdm1F?=
 =?utf-8?B?TUdhekU3RW5mb3ZrdFFOcXA0RVdONzk4SzlaNkZrTlJKVjM4L0JMV2xiQ0dn?=
 =?utf-8?B?RFJxb3J5WHo2OVBuMmtseGszNzR2cytrbDFBbnVDYUx5L0lOS2FPcmV4R1J4?=
 =?utf-8?B?THZmMHgyZnRBNU1Tc0NncFdrZ2UzRTRCVnNqcHNkVCtxejgvWWZLYVVoc1lo?=
 =?utf-8?B?bk1ZcGVYUkw4RjlKY1duQW55cHBKaTdjc2NjaTFmdnpnU3Fvc1lLbzJBeVZj?=
 =?utf-8?B?WFRxY1ZGYkNwaWgwRFZVaWtlNVhlRlZVczN5WUgvOUowU1JnaTBLbEtLUmhi?=
 =?utf-8?B?bmhrRnRjLytmWGwzNTBYbUFsTDJnUnlOTlp1UGRNVVJCa2V0RHFDbEpOQ0ht?=
 =?utf-8?B?N1Q1SDZSUklJbDZqMnlkK1ZnUzc0NFRaUXhZMVN3N1g4S2FLRE52bzk4bFAx?=
 =?utf-8?B?b1FxaFVMN1dRUEdDZTk2bFF4Uk5sV1B4a3lnNU1rY2JKaDFhSTVaZ0lvRnNU?=
 =?utf-8?B?MW1sQlE3Yjl2azlRZ2lveEJGN24vcnBLMGg3YmhyVmk1K1F2REkyUjBtRTR6?=
 =?utf-8?B?VngxbTBIcVVibFdDOUNUcXdOK1Nyc3VTNVpkUFo1M0VPVHVSZm1CcytiMS9D?=
 =?utf-8?B?RzZGdzhqaUJkK25VUWJubDZxSmN2ZzlPNVpwejFIeUJyZTNCRDF0THZhZWdU?=
 =?utf-8?B?c1dFbW5BdHVyMjJFSFBRRDliM3lRUTE3cndsMitOK0JQVUh1RFlNRGZaNVlE?=
 =?utf-8?B?dUxQWm1jQzZRcmhpcU9idVpTY3JsVVU3U0NlQWFwZ0ZhRTVOWDVQeUVvMlN1?=
 =?utf-8?B?eUxjL0hoWmRLZ2VoeTQvdmtMWWs1ZmhyMk81M05aR09oRmdVeVFPY3l0K2o0?=
 =?utf-8?B?dktVanBVYm03OHNWUkk2S1F2Y2o3Zk8zNldNdno0bGlIOHhWSHQ0YXo0dG1Q?=
 =?utf-8?Q?jnq1ts9OkbADyRk4hofcoHCVt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YHO/CMvtJjg+O355RUuBgwKsGkLYOmyopZuJxsF3ZAJzhjtykNL8dw+tBlIRTWTr9UvH2s/AztrDognDRhvfJEmOm9WENxzkAoeXrZYqvlG7R/XR5zPfqVYQ6uj4lDZ+OKlYDebVW6UIfEueU4qeqcFRn40RviQDFaMjOH6tZQHDN2x0upNyRch/0tt9kOpBTRAxWKqh2JWzZ6jfQcMO0SzAyTxwvGkaAoz+WY45Hom3nGzYVXo8maBWaYd2PwNCcNwqgo1pv/AyMZVi0ylg4DgCi/PhJ34u8NSDZpyHa+xWQ7as0avGykTG5x+U5ND5qJa+Gs5LyV5TOXZtyyDPHjJ7ag0a9v2DF+JGU/F8T/EItOCDfavWtzP+Ox/8zTF5jicfPcvVN+CPiz71w6OAlByk+1vvh6pWTsJB9B4ratjIlqDRevWUDQ5q+1U6Bv05Xvrg/S/rhpVq9bsy1VcbdfAxe7T21LWHVRbBXSUBRdlbJe11TIrgU8JDHDj6bOOk0TNBI2lKEESBMuBLTWUTnafekqO5r7E+ly2F8R1bNAkOrw5MNt3Uh9ELkvEFEeyMMVdzz5kZIJwI8X0mWwHk+nmyW4v4ukr5w5uU5uQSYKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4f3efc-7235-496e-a1ca-08dc2268c0f8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5841.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:27:29.1605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HYywuut4IyT7/fnJLB7/26efihN+cC/LdHH676rHE5IaHO5qiHzv7mEgEGt1cnV8Y+s4lllmW3vQdeKip9pDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310110
X-Proofpoint-ORIG-GUID: wSOnVvSniuWm1xeJBFiq5ve03jzUvTgR
X-Proofpoint-GUID: wSOnVvSniuWm1xeJBFiq5ve03jzUvTgR
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/31/24 8:04 AM, David Hildenbrand wrote:
> On 31.01.24 14:48, Mark Kanda wrote:
>> QEMU initializes preallocated backend memory as the objects are 
>> parsed from
>> the command line. This is not optimal in some cases (e.g. memory 
>> spanning
>> multiple NUMA nodes) because the memory objects are initialized in 
>> series.
>>
>> Allow the initialization to occur in parallel (asynchronously). In 
>> order to
>> ensure optimal thread placement, asynchronous initialization requires 
>> prealloc
>> context threads to be in use.
>>
>> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   backends/hostmem.c     |   8 ++-
>>   hw/virtio/virtio-mem.c |   4 +-
>>   include/qemu/osdep.h   |  18 +++++-
>>   system/vl.c            |   8 +++
>>   util/oslib-posix.c     | 131 +++++++++++++++++++++++++++++++----------
>>   util/oslib-win32.c     |   8 ++-
>>   6 files changed, 140 insertions(+), 37 deletions(-)
>>
>> diff --git a/backends/hostmem.c b/backends/hostmem.c
>> index 30f69b2cb5..8f602dc86f 100644
>> --- a/backends/hostmem.c
>> +++ b/backends/hostmem.c
>> @@ -20,6 +20,7 @@
>>   #include "qom/object_interfaces.h"
>>   #include "qemu/mmap-alloc.h"
>>   #include "qemu/madvise.h"
>> +#include "hw/qdev-core.h"
>>     #ifdef CONFIG_NUMA
>>   #include <numaif.h>
>> @@ -235,9 +236,10 @@ static void 
>> host_memory_backend_set_prealloc(Object *obj, bool value,
>>           int fd = memory_region_get_fd(&backend->mr);
>>           void *ptr = memory_region_get_ram_ptr(&backend->mr);
>>           uint64_t sz = memory_region_size(&backend->mr);
>> +        bool async = !phase_check(PHASE_MACHINE_INITIALIZED);
>>             if (!qemu_prealloc_mem(fd, ptr, sz, 
>> backend->prealloc_threads,
>> -                               backend->prealloc_context, errp)) {
>> +                               backend->prealloc_context, async, 
>> errp)) {
>>               return;
>>           }
>
> I think we will never trigger that case: we would have to set the 
> propertly after the device was already initialized, which shouldn't 
> happen.
>
> So I guess we can simplify and drop that.
>

Will fix.

>>           backend->prealloc = true;
>
>
> [...]
>
>> +++ b/include/qemu/osdep.h
>> @@ -680,6 +680,8 @@ typedef struct ThreadContext ThreadContext;
>>    * @area: start address of the are to preallocate
>>    * @sz: the size of the area to preallocate
>>    * @max_threads: maximum number of threads to use
>> + * @tc: prealloc context threads pointer, NULL if not in use
>> + * @async: request asynchronous preallocation, requires @tc
>>    * @errp: returns an error if this function fails
>>    *
>>    * Preallocate memory (populate/prefault page tables writable) for 
>> the virtual
>> @@ -687,10 +689,24 @@ typedef struct ThreadContext ThreadContext;
>>    * each page in the area was faulted in writable at least once, for 
>> example,
>>    * after allocating file blocks for mapped files.
>>    *
>> + * When setting @async, allocation might be performed asynchronously.
>> + * qemu_finish_async_mem_prealloc() must be called to finish any 
>> asynchronous
>> + * preallocation.
>> + *
>>    * Return: true on success, else false setting @errp with error.
>>    */
>>   bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
>> -                       ThreadContext *tc, Error **errp);
>> +                       ThreadContext *tc, bool async, Error **errp);
>> +
>> +/**
>> + * qemu_finish_async_mem_prealloc:
>> + * @errp: returns an error if this function fails
>> + *
>> + * Finish all outstanding asynchronous memory preallocation.
>> + *
>> + * Return: true on success, else false setting @errp with error.
>> + */
>> +bool qemu_finish_async_mem_prealloc(Error **errp);
>
> Suboptimal suggestion from my side, guess it woud be better to call this
>
> "qemu_finish_async_prealloc_mem" to match "qemu_prealloc_mem"
>

Will fix.

>>     /**
>>    * qemu_get_pid_name:
>> diff --git a/system/vl.c b/system/vl.c
>> index 788d88ea03..290bb3232b 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2009,6 +2009,14 @@ static void qemu_create_late_backends(void)
>>         object_option_foreach_add(object_create_late);
>>   +    /*
>> +     * Wait for any outstanding memory prealloc from created memory
>> +     * backends to complete.
>> +     */
>> +    if (!qemu_finish_async_mem_prealloc(&error_fatal)) {
>> +        exit(1);
>> +    }
>> +
>
> I'm wondering if we should have a new phase instead, like
>
> PHASE_LATE_OBJECTS_CREATED.
>
> and do here
>
> phase_advance(PHASE_LATE_OBJECTS_CREATED);
>
> and use that instead. Currently, there is a "gap" between both things. 
> I don't think anything is actually broken right now (because any 
> internal memory abckend wouldn't have a thread context), but it might 
> be much cleaner and obvious that way.
>

OK. I'll call it 'PHASE_LATE_BACKENDS_CREATED' (to make it consistent 
with code comments/function name).

> Apart from that LGTM!
>

Thanks/regards,
-Mark


