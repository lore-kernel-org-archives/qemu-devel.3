Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE712C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 22:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmL7l-0003Ls-Pp; Mon, 18 Mar 2024 18:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rmL7i-0003Lk-Tr
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 18:06:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rmL7g-0001EX-WD
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 18:06:26 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42ILxCHb016219; Mon, 18 Mar 2024 22:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YTK78D95k2J3hpOvtICPrEbcFsP/b20AwzAQkM+uAKg=;
 b=gIb9gKUnqG9OVeN2peIZ6IbYSRy9y1wdkaB2IJwjzzrbIbamKv79cPFVPuUwYG9ZC/iC
 aq5uT81GnhwbqF9ihym1hfydDi1Bjy1eilGxtxKVvnnJXfkLAscih1WQ6Vm9a1OpaFMV
 ovx5CAGmpAOzGSQBIx4kIUFd5n4Rlb2wYnozhbSLycqtCdISG/So/+e6yZOZQv04s9nf
 zoKM+5hHhHd/cWYDOdvOJStx+lbwnFhCl+Cq8SAoxQ11X/YWDXumtTKb3C+TgdjMD/sh
 BjqqB7ad+L0u56PRTluMmcKMOKVjXQb04olm58Kv/gIguWppNkYztDBYem5byKzziogH 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww31tm4qk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Mar 2024 22:06:20 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42IL8G9C007524; Mon, 18 Mar 2024 22:06:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ww1v5ekqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Mar 2024 22:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P14aKXzp2k5CxwvaCIOyVf3NhVhZl/5PnTiMvhGLOJMN96VuFEh5xJCpJ44BNRnHU92io6CwaEOUIZXQtmcTjgiGBvjPheLytPTBemeJVTlyMVhIiwkf25AMbif91oay3L6NNRnkP83su2sCFcqJTgYCleRGQLyRicBUvs5mQYxk/1Te2zNZTo+rmOzWqavqvTkAh9nz68ohBHYDxO9ql6Mr7GJDUg8nSuZc2WFbshU5mi5XrLB2UXie6bSk2kCGLZYdWX18PUmpG13ygiiYQAejCVFf++GWpHJ6CwfgYW3glBoryp7/3R8jXNRv7+PNKlewjVZcyK1TFSh4NzG2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTK78D95k2J3hpOvtICPrEbcFsP/b20AwzAQkM+uAKg=;
 b=FN+fIUVAdw8S6YZmGDjdp1gI6heCiFBYK0T6LnUGAXJAagwk0cDItj4y+6vgSTR1IM31Hzy92Q0hphd94LwEPmhsW7mCwXl4Idr0JEbpW8hOMAK9AiTODWsVxaN3o/8GVLc6HxUTBqSDwrxltPDOj6NtuDPL/cwBnXUm+uGHqgnDvwzI4DxKIk3FSB9eapq22yD8tXGOpLTIP7N3ddbDIuXcDe/Z8KCHGl08DK4uqjH7OOy/J0j3YGNKvPKSiZEnClwSWNEgzx3S0nUdVCJvJRBVqRP4WHFNhCdNDsz6cN1Qn9IVx6IutCSpNYt8d47kWyaY6x0n/GKiOpj2K9nHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTK78D95k2J3hpOvtICPrEbcFsP/b20AwzAQkM+uAKg=;
 b=l9ghGA6CZ54R4Lc7azKUHOSELFYHw5kq2dXBewafcsL0b0H25+AEm0IqRXFSfX867rKvmtAcW0W5FaKFbyV9NRxeSFp2KAHO/GYf1OLwNkrBj8St4R1aqdYD5hUKH/TXMIeAAx+CzQOxMvdBbfviY6RjqFwzpONLMG79y2rwLO8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH8PR10MB6575.namprd10.prod.outlook.com (2603:10b6:510:225::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 22:06:17 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 22:06:17 +0000
Message-ID: <7c118fa7-2288-45f1-aa67-5bf650d65b51@oracle.com>
Date: Mon, 18 Mar 2024 15:06:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] vhost: dirty log should be per backend type
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com,
 joao.m.martins@oracle.com
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEt2-naXvHjCcPyQAoSfto44OVaSUqPtg_gvS8-wrhNwZA@mail.gmail.com>
 <9cb9fe47-f173-4cf1-8bc0-01971e47559c@oracle.com>
 <CACGkMEvjB45RzonvWMQ=OnDpm5M04u6ab6tT7b0=sMsEyBB-Vg@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvjB45RzonvWMQ=OnDpm5M04u6ab6tT7b0=sMsEyBB-Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:510:174::7) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH8PR10MB6575:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8P3h/55wPTRJo1hLKRsNiXmoZHRJ0idCIMamBLq9RQDkJLmID9+7B3zxSp7TcaNILwWXTMJbMXXMvkOZ6lrClBSN7FCz47exb9ZV0pfzleE9oUM8gLDGHr5r/iUHBPNiQAUcbyOQ0z7IJLHeB/Z8SQaO2fgqlijF3uyZJvfIU6ZtpDuCoHT86TXtDEgEQwWdlrZU2QM6X9jjnahkGoTpxkdY0LelX9puSsdq80HWb3u4NK+MEKT2ayfS4NSMt8Ec9lWr9VkfB5+O563iEsbhAU/rQWf0ZW4KwgEMpTxgmRCJoDk4hzo6PMUQ0hGuUTKsuzqUEI9fwOsubeTqGE/Wexw3GEvIClVwbBWfP0ci9y+frkv6mBkCBaEwamJM0JxH8DEoMhZzykbCjEs+95tnrC3aFrMubKS037Gagt+6ITMQcQQQ3zka8ay+Wp5scWUc8OYXRvEzu+6c0I8EheB/7h7TR3ih7ovvU5k4wGR8KLFDrxq9iKw0FItx0RDQ6z3YugCsuYk0lG9DpZvuGHd6mD/7PxibLqMhalNZEs2/rg71DK+2IJNQ8dN8yECa0gUQfom1L6bKPs9wlV3aSBVzqCXH/S919wjC/NAG6GCnJ/4DpnFCOGIJtdrTOv5FVcmt7l9l0i+k4YbdJUsLqaYLVQr3dlNF3PxcnHuMu/PfgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUpEWXBNMVEzSmZ1cjZkT0Rma2pVYVFiU1V3ZURYZ1pSYkE1VTlIRmJ0Vkd4?=
 =?utf-8?B?Uk5nM2ZNMnZFN0FxeDJvd1pZcFhyNkZMWHZLWStnUUY5YzFwRlRic04waXVV?=
 =?utf-8?B?azlIdXdISU9JZmV1T2ZXUHBWVnM0UU8xQlpRUGIvWUR4VVhZODdnU2hyaVA3?=
 =?utf-8?B?K08zeUFkUjdYTGx5c1hlV1djMm1KOFI2cnlZOUpHTFo3VFJycjQybEtleXpD?=
 =?utf-8?B?WWc5T25NUEF4d3lwN2twaWdER3RHT3FQVDFJRjQ5RUprUzB0Y2Nhc2RTWVNR?=
 =?utf-8?B?cXFRbzYzRERVMXVrcThvaEJaeGZrLzlWSFV0eFZCbW9vbitDbWFUL3lKZzZm?=
 =?utf-8?B?RGlPYzk4K0J5bWt5WVBEUjJ1eUNaRnFuY2s5RDFTTWV0aHdBTG0vYnV5cTNC?=
 =?utf-8?B?bkRCMURDQURnK2JMOWtqMEx0NDJYVnVBcTE1bExGV3JSNUh0d0dvbzZXZW1y?=
 =?utf-8?B?U3JMUkRNSlhiYXA3RW0vQ3RsYk5jQW0ra1I5RWxnSXBsYnFDbkIyVHl6MDJO?=
 =?utf-8?B?L3VlZGo0WS9uY0Y5SUhURlpTVjRTNi91RVBvZHl6ems0Y1hPRnFCNTJiTlZ5?=
 =?utf-8?B?NGVZbEdkTy95ZGxNa2h1OEJ6Sm1HRGM3ejcvVERMeWFnTENJZC9tb093SG5n?=
 =?utf-8?B?YXJ0SlQyUitFVGVIcDFRS3JFeFJ6TS9VYUR4MHZ6cU03N0hiWnBXMzhKTzYz?=
 =?utf-8?B?V1VvNHZpbllyTUgrVEJUdVZLMWhCOGliZmFOK25RSmhuRXd3UEZIYzVhNkc4?=
 =?utf-8?B?dzcxcmExVEYraWhSd3VYcjhQQ3B5Zm1iK1lkbUw1cVY0Rmp3K25aM0JvdmJ3?=
 =?utf-8?B?VEttVmhkZnBnSU1XK2hsTFhadzJLM0VjajM1QitaMldUc0dTRDYvamprV3cv?=
 =?utf-8?B?SkdBeDZkeExzdDR2KzNoN2xhNDlkaU5aRmxvRTB1dndMY1hsQ2V3SzZjaElm?=
 =?utf-8?B?aCtxak1vSE9VR2JkdXJhYkhkODhTMXhKWXA3a1ZydWQ3cFVjNUYyUE5pS3NU?=
 =?utf-8?B?Q0tHVFVsT3NEWVJocDl5NEdrNVZ0V1RtV0Y4cGN3YWZQSEpGMnYxaHVlMmtP?=
 =?utf-8?B?K3Z2bHlFUExKRU96MFJzVitGSkF5YUFXMzhYN24wZVFIUE5wWDFIQ3RRTEVN?=
 =?utf-8?B?QUJKbnVyS1VMbVpmaEJNeTRjOGJnTVBva01BMlhZQy9yUDJka3U5cS9IQzJF?=
 =?utf-8?B?NUpRbkRJZS9lUlRhQzFwNTg4OGFTRURBL24rbHEralQ0Vm9qQWJpMS9zQ0FB?=
 =?utf-8?B?YzUzdEdwL1JsT3N1THR0ajNZY09xWG5mL3QraTkzSURIaTlEOXRzOUdXUlI2?=
 =?utf-8?B?U1RiS0lpOHFzNGxUMk5DdVZaTFl2SFJSWHJhTk1pam85eGd6RnF5c0VrRkpq?=
 =?utf-8?B?S0JZdzRsenprYkdWRUlaRmU2eE5WeGNYVHVreWhOc3J0Sk1wU0w4ZmJuMWxF?=
 =?utf-8?B?Y0VPVWtHRlZ5Uk1xQ1NtTHFyQTlFdmtuZE1MR2tGVmdNM2dRSUNKL1N2YjdF?=
 =?utf-8?B?MjNrZXl2d1dRWHBtVVBUcHB1VDNxb0xXZ1AzckFqYVFqVjNpcGhVRGdxK2la?=
 =?utf-8?B?QXdFNGdOTXY2WUxwazAzQlJTVDc3R2dRTlg3Sy9Qa3JGdll1ajgyUmVzY2Zl?=
 =?utf-8?B?a2p0a2crSWtqM1RNOUZkdlQxWUdaRGc1USt0dFN3ck9BRW9sbmhjTzJpQ1ll?=
 =?utf-8?B?amF2T2xEWVRSSEphNlF3WjZ6eUZsa2c5UUc0eGpaVXNtY0dGck9ZQWlLK3VY?=
 =?utf-8?B?SS8vQloyNmUwK2VGRkUvSzRiL3liQksyN0ZuT2pVMTRVYllvc2tQelpnRFhx?=
 =?utf-8?B?clM0MG91dHMzRzFCeGEvaTJnSmpIWmdrbk1YTkUzemFSZVpqZXEreHVwOTZY?=
 =?utf-8?B?dzJpM0VSbS9KaDQ4eGpwbis0QVA5V0ZrcEtyRFZNVmhRNlhhNWpwbVlrZjlz?=
 =?utf-8?B?Mk1pLy80aGVOVW0xbjV2bTRucXNzNUt3aFpmQXYvOURJN2RrQmZVam5uUTBq?=
 =?utf-8?B?eFhJVHJMd2l6N2VWdVpzRXJtREphSDU3aURBdy8rRlFacXU0bVZqTG1oWWF2?=
 =?utf-8?B?NG5Md0JHRVRoU3B4a21tU3U1NTBVajAxZk9Gb2lSTUF4SGhPUEw0MTYvQmI2?=
 =?utf-8?Q?bTXra8LvwaYSQQOVm05iECdhp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vRuKUX6UiS9nxEtF8NDtInxYzf121wQD1vqCDSB2nyPkutTJY3QyCWGdYXv9DSCPyn6BYrIIHTL8EwE8+xxnPMCTNhfPHWNhkubd33sg6UOAzwGRKW7349c87CvytSI3fkuuT/yr/IuCMi4GGbMsFHvFgHc9WrZ2f9kN+offDg3230/O/AYqVRBsZlWR3TQdZJLpSF1AU7Vj6I7RQb21GWQZ882XQcE1UG8ilVvC6sH4i0Fgyn5afxMOAxbAMH1smlMwVv3oOrhFOAJwTmY3/zQ0kk94r2MpZVVnrxczV67ZkLrAtFBnyqigFwKpMgqDAMLZuclu7hoYXcsn9VSgM/nWaUk1i5E5ytX23g9KLGUrtQSuQiRbwO6/fbM+WmzR5GFKskC82D+BSpVlt16SZVaiqbTTvfaSNKh+CbsiRx/uoaPE81i4lZ4wF95tZyV3SpG7yP3j9kt96mQbsVaqtA6nNxE5UyeisYwrXcrP0ii1KnzYk8JIywrNb/Fv12K9OrxyH6AzV+oJ+wRHOa7yLFxV6xa3cEdhbi6sh20/KXP4jZ7h2kt3TPBu4zQOQdndf3xwDAkKIY/v2rBn/jbN1z8pvkiu0yWzsyr+Mmk85Fw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10fc5e9-f402-4594-6304-08dc4797a24b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 22:06:17.0256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlZRNgJPsRoZBcvG1IkgrSkxub9bzz3tp6WBh26/2QHBnBOt6tcSFHWGuxUQ6oWFwFTkN1DFerbyZtlfXSBFnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180167
X-Proofpoint-ORIG-GUID: 3lGs9f9aBJyI6M6vglzv2efpof-e3B6q
X-Proofpoint-GUID: 3lGs9f9aBJyI6M6vglzv2efpof-e3B6q
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 3/17/2024 8:20 PM, Jason Wang wrote:
> On Sat, Mar 16, 2024 at 2:33 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 3/14/2024 8:50 PM, Jason Wang wrote:
>>> On Fri, Mar 15, 2024 at 5:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>> There could be a mix of both vhost-user and vhost-kernel clients
>>>> in the same QEMU process, where separate vhost loggers for the
>>>> specific vhost type have to be used. Make the vhost logger per
>>>> backend type, and have them properly reference counted.
>>> It's better to describe what's the advantage of doing this.
>> Yes, I can add that to the log. Although it's a niche use case, it was
>> actually a long standing limitation / bug that vhost-user and
>> vhost-kernel loggers can't co-exist per QEMU process, but today it's
>> just silent failure that may be ended up with. This bug fix removes that
>> implicit limitation in the code.
> Ok.
>
>>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>
>>>> ---
>>>> v3->v4:
>>>>     - remove checking NULL return value from vhost_log_get
>>>>
>>>> v2->v3:
>>>>     - remove non-effective assertion that never be reached
>>>>     - do not return NULL from vhost_log_get()
>>>>     - add neccessary assertions to vhost_log_get()
>>>> ---
>>>>    hw/virtio/vhost.c | 45 +++++++++++++++++++++++++++++++++------------
>>>>    1 file changed, 33 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>> index 2c9ac79..612f4db 100644
>>>> --- a/hw/virtio/vhost.c
>>>> +++ b/hw/virtio/vhost.c
>>>> @@ -43,8 +43,8 @@
>>>>        do { } while (0)
>>>>    #endif
>>>>
>>>> -static struct vhost_log *vhost_log;
>>>> -static struct vhost_log *vhost_log_shm;
>>>> +static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>>>> +static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>>>>
>>>>    /* Memslots used by backends that support private memslots (without an fd). */
>>>>    static unsigned int used_memslots;
>>>> @@ -287,6 +287,10 @@ static int vhost_set_backend_type(struct vhost_dev *dev,
>>>>            r = -1;
>>>>        }
>>>>
>>>> +    if (r == 0) {
>>>> +        assert(dev->vhost_ops->backend_type == backend_type);
>>>> +    }
>>>> +
>>> Under which condition could we hit this?
>> Just in case some other function inadvertently corrupted this earlier,
>> we have to capture discrepancy in the first place... On the other hand,
>> it will be helpful for other vhost backend writers to diagnose day-one
>> bug in the code. I feel just code comment here will not be
>> sufficient/helpful.
> See below.
>
>>>    It seems not good to assert a local logic.
>> It seems to me quite a few local asserts are in the same file already,
>> vhost_save_backend_state,
> For example it has assert for
>
> assert(!dev->started);
>
> which is not the logic of the function itself but require
> vhost_dev_start() not to be called before.
>
> But it looks like this patch you assert the code just a few lines
> above the assert itself?
Yes, that was the intent - for e.g. xxx_ops may contain corrupted 
xxx_ops.backend_type already before coming to this 
vhost_set_backend_type() function. And we may capture this corrupted 
state by asserting the expected xxx_ops.backend_type (to be consistent 
with the backend_type passed in), which needs be done in the first place 
when this discrepancy is detected. In practice I think there should be 
no harm to add this assert, but this will add warranted guarantee to the 
current code.

Regards,
-Siwei

>
> dev->vhost_ops = &xxx_ops;
>
> ...
>
> assert(dev->vhost_ops->backend_type == backend_type)
>
> ?
>
> Thanks
>
>> vhost_load_backend_state,
>> vhost_virtqueue_mask, vhost_config_mask, just to name a few. Why local
>> assert a problem?
>>
>> Thanks,
>> -Siwei
>>
>>> Thanks
>>>


