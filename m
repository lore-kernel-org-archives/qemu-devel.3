Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E77AC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 22:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmLHo-0005b6-D8; Mon, 18 Mar 2024 18:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rmLHl-0005as-S6
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 18:16:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rmLHj-000324-Jl
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 18:16:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42ILxCgk016199; Mon, 18 Mar 2024 22:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=AfAcoALQNTMx09l3Z4Lq4PhrvVfmAlTWZYakdarEHGU=;
 b=K8s6JXZuKCypBufQECJroOP5CYILGOmNCHVOF40Bdh2hPz+dKKDNRkq+0kP3WgD/W2Js
 mFDpfezNOc0Ov5Gj2aAaxwSHdKX3sqwGDgzKhRl0FoulrlThzJh7qqWbslZO/PBw7MqJ
 QEuuNLi8tLjcX4YPProGgU/uA/ko49VFXl1Q6rW21Mc8LV44GAhGmJT82ivgxGW8LhBp
 1YELDlbcku30IVRbh1g0WM0OGVWllkfgq/pKYMTQSMk2gd5fd0a7xZVcww/yoNfE5qbH
 atsRpAr23Eoj1VWCuEyxclcDLd22s7eWaaXtIUDhXcGKiM7AWKuVUSy/vH8SVxn6HdCd KA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww31tm53g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Mar 2024 22:16:44 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42ILGfVQ024305; Mon, 18 Mar 2024 22:16:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ww1v5q2tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Mar 2024 22:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/6cGPuf0t74EQ4dZU0EArzOCvvZIxgVzYEwbewGCJejTAQAMe5Pk2kikkLH2B9eNSu9Z1cll0UuzFE3xVsyMxl5GoDo+mTiYDp3tVFNSQm4sr/nIIIV08kV2GgPfXA8tSx41Rha97EU73QdOMtvwVB4G7/PcpQWfE2W6rDT+skW6ZkwXRfOr94QwDTYuPvOam9p9j8I2xM0ynRGw15dgZJsCyLKzr6ls2z4yfH+wnqhXw2mU4ffBtkUt6EzcuVMhJtavlEkKJ7AXKZLTdqHaY4JjFyfLJQ6KoKyNfrn79ipkOqaYaFAR1F1sXQTrIKbXMH0+8Mi7q96g7Necnwr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfAcoALQNTMx09l3Z4Lq4PhrvVfmAlTWZYakdarEHGU=;
 b=gSOkLpINFUnrJCKNDd+I7MujidIbHneJQ2wh9K7WCTBmzqa0C9GZV2LxdxAFhBLZr6AESkTgYRdqczfaC/KSWSL0Y62KAa91v1i64MLmfEpRIfdrCl62WX1GgLm6xGDZmSxQKTIlnnIq5vbsp/iEDnJO6aNR5P6W+evvhpD8WAX2NDW57E3t7rcs58Yrd6ESi+YK6Y5m2bRyYr2akTZVGSyFPgJg/3yNBWIEtKB+OmDa+cNBVJ+Qs5wtCWi/nTlQfwJTlV9GHR9EoyZf0UTK8biTCgxILEnIUABd4OZHatZ0K57cBaPrpZJmH4FhdkZfkuEajHHBYnKNAfNDILLxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfAcoALQNTMx09l3Z4Lq4PhrvVfmAlTWZYakdarEHGU=;
 b=xOMw2tVXjfYUokH0o+936Gdj8O1PVYH0hTSpUl8WNanAHE8J6Sd0MdvpQKviiKXTnSZWg3O6uH2VsJwHT3hu6ZvQpVHBUoASdHeRGCwSS+kq7cGMRGlt3jnHDO6foB2yi3Ss5IpjCsvFEVwmy+wa3TUixNfbRyLryX2Lc8Fbjc8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BN0PR10MB5174.namprd10.prod.outlook.com (2603:10b6:408:126::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 22:16:41 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 22:16:41 +0000
Message-ID: <0dec84ec-289b-4026-8098-010ec4c5c315@oracle.com>
Date: Mon, 18 Mar 2024 15:16:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] vhost: Perform memory section dirty scans once per
 iteration
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com,
 joao.m.martins@oracle.com
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <1710448055-11709-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEukLmTSfuXxSMsZuO_B7o7623x=gmLD5s-xoinEq=dWYQ@mail.gmail.com>
 <d6c1769c-049e-47a3-8705-bdfe1b2a6fd8@oracle.com>
 <CACGkMEtEtmOZB53xibp5G7ZeVdKpZogEnetfnfj1QCSX-RWY8w@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtEtmOZB53xibp5G7ZeVdKpZogEnetfnfj1QCSX-RWY8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::14) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BN0PR10MB5174:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwJyaCO/v9s1+VpCq07W4hZC+W4o4Mzhcb6avZgsuxXxYXzPlG0CK/MbzrKp5Xmu3ynIbS6fyjN/7YNNrv7N/T3GeidHSzt7WPr1zkuOs0jaWBC/5pECJ0qK3LK9fR/pkK88JW4FXlDNbRWs9DCcskcbMOS8baDCcd86AuKz5nKWe1eb6GYKiqOrhjAa66T7WfDWkWzLxeHMZgXSjRmLPx+9iGCHq29AeCwXebOL1Uf5iILgxCRz/F/UJ87kpeCwxBhakb9CTDTzrjbTGGNIh3ulQvN6m0IEfZDMpKlUO3L7wmK7QdRl1Hs0Ir+Huwoo8b9Win5KT0vclb8BCLbszA30uA17R0v5Pn7YpGJ4YhwrxxOaLEtOm+9SrIekOMxNUIdNbDSz2Jn0w3M35ERs4KCH/XHlJy8umTPnRDzOD9Ey+PUlkQBkQrcZnn3f3VNZuoBIjo4nIsZNeLZg7fM6GfSkh8L9BWY4/Mw2MmWGBdjQX6nDQ2kqq9GDVuvzWkHQG/AKJLqOB6t4wc4iLcmgO7sbsp3ngP4IkLpWcPXKxKjsbpSuwn+Q42b5PnOS4ycwR6pswm2e1mrBTGmsU0T9KHDHivKYP3uZdva9TTDkgu5FMJADTCktQwYd66+oH53mpeXZm7v0yTeqH2vLxybtigRYGGG7mlc+wvhQDh2I46w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXl2YmM4VWlQdHVsR2tFNFc1WHpJK3NlQjh1bCttOG1qekhtNS9iV0h0cVUx?=
 =?utf-8?B?R0VuMVgvNlJrNmtxaWxLNS85VHNCOEFma1hKdmRqYUU3bWdnNXdpVHQ1WDVj?=
 =?utf-8?B?OTduakVpUVArWkRIVEZQYlpzak1uS2JVNU9hU1llN1NOTnUzRng4MEZteStj?=
 =?utf-8?B?RXpmVDZRbW9jY2xlNEs4N0hTNGlXdWhMcEVUdjJoYzFjdU1jT0ozNXVKdTFv?=
 =?utf-8?B?ajRPdjNOVWFSYXpvSXlVRmI2MWJPRU01Z3JqZG1vMU5UcGl5UjZ3aktWaUJB?=
 =?utf-8?B?SWpybTlzT1VpMzViWjhsTW1RTTRKQkRaQjlyWXVNTFdkSzl3VzcwNU94QXhO?=
 =?utf-8?B?SmN5ZTVodkh3TGVjSUh5R1BkRlk0RWRiWlMxaE5QNWpvWmExZXVneUNqc3pa?=
 =?utf-8?B?bEg0TktnMTg0ZjlPcjVQYWdmSXdHa1RQZHV1MDFwREUxOU0rTUpkRXdBZmgr?=
 =?utf-8?B?UG5FVkl5OHluWGliNURrVExBNnlpcEFHQTk2R0pEeGlHOUdFOGx0clIvZEZY?=
 =?utf-8?B?QkhpZkRnV1k1RWJ5a1VjSHNVM1hJNEVqQWpKTTlHL0lFTW9jRzhRaHN1S09R?=
 =?utf-8?B?Wjk0ZWIxWnQrNjFOdVVSZ0RJaWRuYmk3ZldQL3U4RmYvZ3Y5MTU5SWY2a0d2?=
 =?utf-8?B?UFRETVdvbU02TFdDTVNhUFp2TUR5WFFiWC9ZN0h5KytOS1BGOExUTUtzbVI2?=
 =?utf-8?B?NmtidTdCbGpXZmR6T2t6TWJjUEM1NDRINWRtZXpNZTcrbzV2MzNxWXhxdmJX?=
 =?utf-8?B?TlRWaUVvY0hRNVU5UGc4c3k1MzBSV0wrK1FwUmNHSkE0WDhxbldiMFdTSE43?=
 =?utf-8?B?ZjVnRWRDQW9mZnpIM1NkcnJ1OFdYeUpLcXpDMWh6QWlreTd2ZHI3b2ovRXpM?=
 =?utf-8?B?VTQrSDBxWkhqazNLellWNFlLeGZCWFA0dENRbDVJaWM5U091dzRhR0xWNjhV?=
 =?utf-8?B?dnJ4c3hyemFpVm5GRXJzRitzUEJUUkZUN3RlT2dsVzdzTlVBanVmWDE4dnR5?=
 =?utf-8?B?MFRDdXdld0x3SUVIVGh2UDg2UkNBWWg2b1JCc0RwNFluWWFIN3UxQ3lYZGVM?=
 =?utf-8?B?OFl0Y05aa1JiR0pUSGpIdFg3bGl1d2dtVnBzTlZ6aGcvVDBwK2hrNDRsQzdM?=
 =?utf-8?B?bXNodllmVUNvaFpoNFVjZEp6aDRFWngxY3RwMjUwYVZQNlRCcVdObDZEQmZY?=
 =?utf-8?B?Q0lWaGFtS1RlR2IzSGg0cmxLU0dQV01kOVFyaE9oeW8xYmhUSkVhM3haUE1P?=
 =?utf-8?B?b3Y1L0J6M0pFNEVVYmhGai9ycDczZUxMdWxzQVVRU0JZeDRmbnBZVTNLR3BJ?=
 =?utf-8?B?WDZRYnJxK0FSeFh5dXJXNzJ6Q0V6QTFoZUEvdUNkaGdmQkp0K2ZMeXdDeEhi?=
 =?utf-8?B?VTZ0aWpuRXN0QjlpbFd3VkorN2xRbEFoamo3NnBncWFUVXc0SFRJMk44dlNV?=
 =?utf-8?B?a21RZWVLOCtpYXdtQ05PeWlDNE5yUW9ONVEyZ3hkanJDd0svWThKQ2o4bnNp?=
 =?utf-8?B?MVNTRWc3WnhnY0kxMWczT1F2MjgzRWlqRDVHcXQ1Rnd0SUpwUXVEWXQ5Zkkw?=
 =?utf-8?B?NHQ3eHN2UjJwYlJUWGJ6REloejRrbFpuSVZJSEtzTmppalYyVzRWenNiVEFN?=
 =?utf-8?B?dlk3OGlnWjczbDNKSFFFdkY0TDlmU0VCaFZDWTZtL0duT3pzUXo3dkxITEFB?=
 =?utf-8?B?NS9NalBBOW5DVy9YL2twbTNTNGc1SDJ3SXpkZW5jWUxibGFsZUNoQXhHTFdv?=
 =?utf-8?B?R2RPYk1sRnZOcGRtWW5XYS9Vd2w1REhiMWVoc1A1SzVBM3EwR1kzbDlEVUty?=
 =?utf-8?B?RXEvTWhMcyt1Q0pkN05KN29yNE5EeXdnU2FIVzErRkxlQ21sbUZOYUdVS1V2?=
 =?utf-8?B?OGVGeGNwOG51NnlidW14UzVYWmlGNk5tcHBuNHdIQ2JxSlpRcTBsdjY5aEt1?=
 =?utf-8?B?VDFLNVRjOVJ2eUJha0pUcnFBSVJIaEI2cnc2WDdocHJjdlNsWTdKSjBBSDkv?=
 =?utf-8?B?RTQrbFlTd3J3djZkUWt4NW1PRTFaWTBTVGhSNnJqQU44cEF1ekhSa1QzZVVD?=
 =?utf-8?B?d0tFS3lqQTRTSFZNdGZCckpjUzQrRWRWalFRN2lzakZSU1VZZUpDQ3lOV0pS?=
 =?utf-8?Q?B0ehHxJ8thI0elZUXoX3ii5da?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8bXgkQ/8A9ZKufX1XjN5/MQ/8h5wzvxNaAuiWZ1X9ASh+wOiTtoe9sEPV+ElBPJvnMj+WoOjZVlv7x0moD3RtSYGtNWgTZx7M6/sA0/Jj/EuK27KaybFky/Ks8M03x85QRBiSekmFBawL5t8uhg7ZxrDDduVxFu95P4fCI6jIhtwTIckI9rtRATjyAtRmXH8PAlGg1WFDDIXzNXPSkKVQ6i1Ulhadru0V8Z2NyDzNGqccvcpY1jyglmpSI//rV/dcAg4exX7MrLeBtFpGrIk+hcbj+04Th2Ax/5ex2zadgv/xVPDkcBk+uBMH2gl6Z9CUlHK7Uir7bn8Cwm3gJGuFrYkERQetymHiqouDgowL8p3vfRLJ0I8ZuYut4gdDuiUa+ahhOizLekyUi/uKilfo2tLLtJcuQkdt48qhsUD66FF+Q/vQAlKEmW620oPcwCbfp1mTWT6qqTmbGHjBnpH5D2q17uBu8gDS7x+vw8XuovI0esuvHob/W8eSDUwxeMIDZXCfGRbB6JVspqpP0veaDgYn/wWBIu/MxxiafFnXa2iFwwvl0hDD7C8YyQBUXcTjiS6lBXpbGbg2NolboNb1ik01jbqTcrFMXJhqDH7VY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169312ce-c703-410e-f566-08dc47991663
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 22:16:41.3200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KClTSNYZNEEXMjxdWiAgJR4Ct8j723vjSCTthGloogIxAHRbhYwng1pef6fBpOiYf19B2bkY/200BwnSPvh2lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180168
X-Proofpoint-ORIG-GUID: uHRIuyhah6hHZHdMeSzIGuWm1ScwEmh4
X-Proofpoint-GUID: uHRIuyhah6hHZHdMeSzIGuWm1ScwEmh4
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



On 3/17/2024 8:22 PM, Jason Wang wrote:
> On Sat, Mar 16, 2024 at 2:45 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 3/14/2024 9:03 PM, Jason Wang wrote:
>>> On Fri, Mar 15, 2024 at 5:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>> On setups with one or more virtio-net devices with vhost on,
>>>> dirty tracking iteration increases cost the bigger the number
>>>> amount of queues are set up e.g. on idle guests migration the
>>>> following is observed with virtio-net with vhost=on:
>>>>
>>>> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
>>>> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
>>>> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
>>>> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
>>>>
>>>> With high memory rates the symptom is lack of convergence as soon
>>>> as it has a vhost device with a sufficiently high number of queues,
>>>> the sufficient number of vhost devices.
>>>>
>>>> On every migration iteration (every 100msecs) it will redundantly
>>>> query the *shared log* the number of queues configured with vhost
>>>> that exist in the guest. For the virtqueue data, this is necessary,
>>>> but not for the memory sections which are the same. So essentially
>>>> we end up scanning the dirty log too often.
>>>>
>>>> To fix that, select a vhost device responsible for scanning the
>>>> log with regards to memory sections dirty tracking. It is selected
>>>> when we enable the logger (during migration) and cleared when we
>>>> disable the logger. If the vhost logger device goes away for some
>>>> reason, the logger will be re-selected from the rest of vhost
>>>> devices.
>>>>
>>>> After making mem-section logger a singleton instance, constant cost
>>>> of 7%-9% (like the 1 queue report) will be seen, no matter how many
>>>> queues or how many vhost devices are configured:
>>>>
>>>> 48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
>>>> 2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14
>>>>
>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>
>>>> ---
>>>> v3 -> v4:
>>>>     - add comment to clarify effect on cache locality and
>>>>       performance
>>>>
>>>> v2 -> v3:
>>>>     - add after-fix benchmark to commit log
>>>>     - rename vhost_log_dev_enabled to vhost_dev_should_log
>>>>     - remove unneeded comparisons for backend_type
>>>>     - use QLIST array instead of single flat list to store vhost
>>>>       logger devices
>>>>     - simplify logger election logic
>>>> ---
>>>>    hw/virtio/vhost.c         | 67 ++++++++++++++++++++++++++++++++++++++++++-----
>>>>    include/hw/virtio/vhost.h |  1 +
>>>>    2 files changed, 62 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>> index 612f4db..58522f1 100644
>>>> --- a/hw/virtio/vhost.c
>>>> +++ b/hw/virtio/vhost.c
>>>> @@ -45,6 +45,7 @@
>>>>
>>>>    static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>>>>    static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>>>> +static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
>>>>
>>>>    /* Memslots used by backends that support private memslots (without an fd). */
>>>>    static unsigned int used_memslots;
>>>> @@ -149,6 +150,47 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
>>>>        }
>>>>    }
>>>>
>>>> +static inline bool vhost_dev_should_log(struct vhost_dev *dev)
>>>> +{
>>>> +    assert(dev->vhost_ops);
>>>> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
>>>> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
>>>> +
>>>> +    return dev == QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->backend_type]);
>>> A dumb question, why not simple check
>>>
>>> dev->log == vhost_log_shm[dev->vhost_ops->backend_type]
>> Because we are not sure if the logger comes from vhost_log_shm[] or
>> vhost_log[]. Don't want to complicate the check here by calling into
>> vhost_dev_log_is_shared() everytime when the .log_sync() is called.
> It has very low overhead, isn't it?
Whether this has low overhead will have to depend on the specific 
backend's implementation for .vhost_requires_shm_log(), which the common 
vhost layer should not assume upon or rely on the current implementation.

>
> static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
> {
>      return dev->vhost_ops->vhost_requires_shm_log &&
>             dev->vhost_ops->vhost_requires_shm_log(dev);
> }
>
> And it helps to simplify the logic.
Generally yes, but when it comes to hot path operations the performance 
consideration could override this principle. I think there's no harm to 
check against logger device cached in vhost layer itself, and the 
current patch does not create a lot of complexity or performance side 
effect (actually I think the conditional should be very straightforward 
to turn into just a couple of assembly compare and branch instructions 
rather than indirection through another jmp call).

-Siwei

>
> Thanks
>
>> -Siwei
>>> ?
>>>
>>> Thanks
>>>


