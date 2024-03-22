Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67D7C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 21:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnmDK-00006U-23; Fri, 22 Mar 2024 17:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rnmDG-00005m-Et
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 17:14:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rnmDC-0002Gk-Vm
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 17:14:06 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42MKsbEh014217; Fri, 22 Mar 2024 21:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9kqzuQ0R9HJoKxmlXUb0libW9s3MezqILptBFCaVjFI=;
 b=Pb+8hrAH74h5VrIg9+F85MaeOGop4qwKFVcJBqkQtgPJ4s9hf1KAmPFgqT08MIe0Et8E
 SQcBHu5R0TJuqsuyKuTrhYYYa6zl6nPmz/tJjXtCYRGAHrjH8OKhHdSX1xcxXsG2zTDy
 Ne9rxBr7ZNNyh9pxQ8PTZou5TSoEspLYw4lfo+2SOMKM4MY1sSLZLW2xRLjsVeY6RijZ
 7RJwEoMey/fAlTEiqvgWVoyM0phmkCEOlE8sSohuivyylTs8PL4X8AS2naRqwqo2/vkn
 QBNfrn0AlfUGolAoJ4gj9HYdpeWrZCnFBfYpivNKh6iAJE0RGmRWbEBmbx5NxrRjgsTd pQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvmj3t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Mar 2024 21:14:01 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42MKXuCe014885; Fri, 22 Mar 2024 21:14:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3x0wvkswa6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Mar 2024 21:14:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR72EYLAZAI1DBHzMiqczS5lUPm86el79g7aCq+zzfKZz5R3b5/rw5Naz1QLYtT8ZXrNeiTh+/QPjLR7pvTJDtchhuGRHCHoVAB5E9t26Uh22RxcELZMUBpRiAtE/6YrbI1fLe96rnkLH8l8vBnvWjORaHJfUnc3f5opZ7qc3fKVBP4JAIuCrgnHlhvXX3UybLHc8EqFc2ue1bqRwCPLQ/cb1oI4FwPG6J4VNkqmlaYnI8bjT81pdogo3OVNaJjP5LW/Jak87Jq42H75nrzgDeOXg8tResyd80qK6OzF7uG9pofvc8Etq/89Bn+uUl/bADfzGQyBi+jeBndws1TsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kqzuQ0R9HJoKxmlXUb0libW9s3MezqILptBFCaVjFI=;
 b=a3aN2mvhMeDk3paV4YNAVU6Xc0+8qRYzaXl88lw+tOOLT33yjOLdQGV2OZIPl86qRMge1zBashiROF8ll6ZadjL7v7FE/AontrlVj2lM3zfiRqiU9oz/hvE1+F2Sg7IuLnf/4gaMfMu82i2v4rsgvMC8BIH3Hv2MGOPkQ0BUtLt2p79f3joUX7TKQaKMufx+LzdXFOe7bmHLX6WCxztdYbrq3G+ULQn+imxXskhN2dVeInEMUtxLKr/Pz5XIHVbslIkHfil56co2aS1D+kqxFpiimXgmgb+rCNQdMPpW7cGe1EiFh9d7k/QOxzvmPAdLt8Boxljx2tdMV/ciwsA5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kqzuQ0R9HJoKxmlXUb0libW9s3MezqILptBFCaVjFI=;
 b=Ud3i0gY7Axx/qQDeJ2ZfvoWFM7NPyv+DZw+xX7pF09KiBxdPNU3YSIoEFgI/c/KFnw3nCNvnt9aRCJCR2yKB4nh/Axjghscbi2o2TbPTP3D/XbftffYhDlt7GAeqmogY64faFRxUdg535yit7d0W5nwX5TVKuhtp054EFyNfnL8=
Received: from SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8)
 by IA0PR10MB7255.namprd10.prod.outlook.com (2603:10b6:208:40c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 21:13:58 +0000
Received: from SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::56d3:4146:6cc5:5c51]) by SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::56d3:4146:6cc5:5c51%5]) with mapi id 15.20.7409.022; Fri, 22 Mar 2024
 21:13:58 +0000
Message-ID: <fbda06f9-59d2-4d39-bf56-bf8242b4768b@oracle.com>
Date: Fri, 22 Mar 2024 14:13:51 -0700
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
 <0dec84ec-289b-4026-8098-010ec4c5c315@oracle.com>
 <CACGkMEtWe59mNWORwS=OMg3MXFRdkPwmjJu8wR2rTXBr4w2_MQ@mail.gmail.com>
 <35fc446d-61e3-49a3-b79d-c44aa2e65fea@oracle.com>
 <CACGkMEsbsqpw4NLJkkoNh8xfbpKgz9Usm5YO_qjF3JyB2K0frw@mail.gmail.com>
 <99ac7902-57ba-41b2-9f1b-368f4563fbc2@oracle.com>
 <CACGkMEus=LsocdQPR6UE4HrXyCJFyGQRcpHKBYX89VKOckwW7g@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEus=LsocdQPR6UE4HrXyCJFyGQRcpHKBYX89VKOckwW7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0130.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::9) To SA1PR10MB6519.namprd10.prod.outlook.com
 (2603:10b6:806:2b1::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6519:EE_|IA0PR10MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ade11bc-2711-4b05-fa89-08dc4ab4fcfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auFj6OEUv8oUmR3xKCQ4Mx444eXpUZVN0Y5iU8I0ecMa5zNg8BAyiLFUBeriCBzSOq6BFYUzsFwvcS1ItjgE+nHWmjKgTad0GfPYiUXIpT/ZuDpXt9R0fbVxwEGs8d+EAun58BkW398ezDNKQZsPWvqLqUqhRKqOAraN0UHMgQC9GkpU96GHHB/u25vWYC50/oa9kUsWCE1EFTYOTmBq3EzCmoCCpbjfjS2axWK5HD33T5+w4TG+PBa/zHjPNWcOpblpDfn3u4mw4rQwAcIsHYbqvz8hQSd2yw8ELJT6GqeNxiSIewZ2BJd68T4doA0cHAMviKL4eWZrT/pvVD0phuoYJlkONxht7v/rXU61FMH9mHw5q8rUldS/D55EROECAQFUkmOFQdw4xsBhv0ql3FK+x4rkvsvhdgqj+AMVNHqR1gyE+VI5y4evJn3kaY42/EdjdrB0PbWbBX9x9wp020dGnZd0AAW5U67XK/OLcLit334z85L2bV20tWgA8Urk9m5hpzL5HEs6Qvyar72dZGTdZYpIbxLzZn9hs4LAGC4BDOyyOT2h1wOnnoR0LsAP8euJqUTA0dcE+Ng6T4NwDRNwU78WvdEnYlBC5GO0pK5Ikhh9nuXZej0S5GMpy99FE8GVJ6A+jr1rLnkteAOwNT1nFOwUa2EhSgKgVs/F5Po=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB6519.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXplNHY3U2RiZnYrMmJTWUgwWCt2eGNFSjR3YlhGRDMxR3NNVjJwdTgxN0hX?=
 =?utf-8?B?U1VkelpzbGpvNlAycEl1dXBBWXNpS1pRZTk0ODh1UWNTb2JYdzJtVlg4bDMz?=
 =?utf-8?B?a0k0MjhOcmxPaXF3dGVWZE9zOTRNWmhNVDlTdkpPWGVEb1E4aU9XRGFucG13?=
 =?utf-8?B?YnBKZnlGdUJrVjdscmtMZlBwN1VvUDdLWTE4aHJhMkMxWUo0U29sbGZEOEpN?=
 =?utf-8?B?dUVCQW16UUZtMXhSd01zL1BERGk1QytaMWFLcGNZd2RiRHBLVjk5Y0RNakJR?=
 =?utf-8?B?d0ZYV25mMUxqNG12blNaU2NFQUhweXphM0kzdVhmb3c2TlB5dzZFTUdYc1pt?=
 =?utf-8?B?VFRYdGY4NDZ2MVZzTGlTc2ZUMWY1NDRBaGx0MFU5SmlXUjVrancvWGgxWTF6?=
 =?utf-8?B?Z3RVdWU2M1lsQ2Uyc0RTT3JVRmV1RWJITHVoakxFWG1UQmRsWWhESlh6L3Bx?=
 =?utf-8?B?TVdRTHJiYzNQd3crUWEvRUI1Q1AzalJVcGdPcXJ6VWViaDlxbC9CRnpGK1c2?=
 =?utf-8?B?VXZWZnFKR1dtclFYTGpnc1FMdmZjNDBvenZkcFlKWktzcGlmUWtRbFJSdXlI?=
 =?utf-8?B?WVAzbjA2R0JiMDdWaTJhK3dpNm16Z3E1WUNTQnFYRmJTUjJnVE9JUzE5d25q?=
 =?utf-8?B?bHVOaU5tMmxIMmFSUTJ2eTZGTGNBczgyeSt6ZnY0WURTbkVvNE9vVDJIdlpU?=
 =?utf-8?B?YWVyUkdXQnhGM2lBZm9yVmZsditvbHFyTXc4WVBocWJMRnZWYlFsaVkwbXRX?=
 =?utf-8?B?WkVUcG9SUW16ZmNoZUIwWlZiOTBka0hHcWpoL2YvR1orNFMvS0JPM2ZLY0hs?=
 =?utf-8?B?bG1BSkdaNmgvU0dIUUtYY1BVdnF1eFh5TzU1K1YwOGdhcGZzTlpHb0NRbTBW?=
 =?utf-8?B?TzNSNFN0MmJlWGlSYSt3K09YNFk2UzU4T2I2b3ZsaTFibXVudzExZmhVcGM5?=
 =?utf-8?B?RjZaQ2l6S0p6Z2FDODZlbFBSc3dRL0tKWXh6QzZ6cTVCRytYUVg0L2k1aDFR?=
 =?utf-8?B?eE0wWDlqdldMYS9wZ1RQTGpqdDBYYXcydnVSN2hFemFFR1FWOUZ4aW1WZm4w?=
 =?utf-8?B?eWtnT3c5SWZXUHB0c21DeXpHY0VFclQ0V3BRd244OEtUMU5MR0kxNnIrZXFH?=
 =?utf-8?B?M1ZZdDdnZnJBd2RyMkFCeExUdlkvSkV6SmUzVHJYUXpBUXdsK3pVRE5jeDJW?=
 =?utf-8?B?RndwRjJvWEZEL2tjRExIblRxM0syeXo3MWNXNHc0YUZZZG9UWTY5UnZRenps?=
 =?utf-8?B?ZTVveks2M3RNZWF6N2VTc1YxS3VHVmNqVExkZGZvR1dOM1JzK2hQU0YvaFIv?=
 =?utf-8?B?OXV5d2NWamppQzFwRVR3VmlYOHhBQkxISWhxS1E4OE81Y0Z2b2lOakZwVTdS?=
 =?utf-8?B?eXZUb0RWcW5DZVE1c3dvSEZId3lGZWlXTzdQdkoxMUR6MmRaaVZIaC85Ukh0?=
 =?utf-8?B?Nk9ncVpvK2F6UW1jRlpGcS9iZm5aT1VsMVdoU0E4WEZvV1doclEyL1Irek5S?=
 =?utf-8?B?L2l2bmVlWjM3ZzNKQk1tdFU0U3RVRTVvTzZhQStoYi9Vc01iY0owRGhCcTBl?=
 =?utf-8?B?em9vcGdKNGVQalRqckhZYUhIVmpod3JKN2JaRjR6TVBsQkVhc242YkpkS2Ir?=
 =?utf-8?B?RnVtdnFDMDRjSFNJZzNGa0FzdEEraTFlNUsvRERXMEo4czFyVUo5dSt3eElS?=
 =?utf-8?B?N1RNb3pQdk9FdXNsdXVRbnpOTTFySkRCbW5qVmR2SEt2cXJpeng5MzF0dWlR?=
 =?utf-8?B?bjVSU0tnZGpwdjROOFlBT0Y2YURyODFNK1Roa3o1MTUyKzN6TkhHaW1pUDVW?=
 =?utf-8?B?RUJQd2ROWGJ2SDFmcGovTkNzQTJJdy9pTmQ1REpJZWp3dDlqL3g0dmlIVTFX?=
 =?utf-8?B?WlRSaWZRaDVCa1RENXNoRlNjVWREQURiblFicUVmSW0wUnJZc25lTnRHQWd1?=
 =?utf-8?B?Q1BoQWdUOElLMElPWDJxQzc3cVpGUURJZUVFSXkwLzVsZERKRG1oSzd2UXZZ?=
 =?utf-8?B?c3N4eHpXcGVBendRdmlZcEhKU0dYWEpXQk44aWxIWmRyMDJaRiswcXE5UUx5?=
 =?utf-8?B?cE91bXVOT1oyV3ptOWR2a01sMFlOVzhLT0FaaTRzZnNQZkFibEd5SEE3dWZL?=
 =?utf-8?Q?rdrGpV8eyj+qd5mKwXEec19ut?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MYqdLzMSHfgn56zhHRYD5D9kF33ByPT7qz8tfLNed8nmri9ozMqc6k6mc1h4MDoC9sLaDsop7Qw8lY7XSKWS18Al5Y3OUqxWC10rY9TGNYzA9/Zx/bvxYo6RevuRPfBEt0v9CAGMmSY5zu4aGfJRPQKzQkXEb/GSkVP0CoH9ujfpxlQ8F4uZ3BLSoh3hEaXw7rji5DXAhgvQTBm5XBzxVTyvJsrNIBXxvIHuoxfNX8Ktqm6V9HPk3es7tuPLKnsPb+HU/WO1tkI3n1vTNg1OaUlYiUo2wA+OkEtoiKud17vYc2d3la9/bUa5EHVDopvxtPJoZ+xXIM2RcYg2LXS/JvcuqPA1A7Y3zcU/fdGo94D1Bm7t3OIMljcB3GvXdzdEE/cm/d/DdahunDkleZ5P2K00OL7uu/CTzTeAmsZ47/9RThz/jut4ej5WW7nVwgWWqRG4N9EWtHxZ4xeItVY8KOd9DtPgtVzah/Zw0j56/GBPWU0slMBvblvdHQzT5V7dVXqaIu4R/esg/ZqP5vg9cOwIzVjX77wLI8ISmid4AiLf+DDUIA8qKLerAb+0QqfmZqVj4Fa5yDoaXG8fMcOlXAczrQBUsepQIrTDHiMXFZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ade11bc-2711-4b05-fa89-08dc4ab4fcfb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6519.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 21:13:58.0827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVffRfMq5ZPulAw1Cx3+rqlz7dp+Y6bQekp8Z+F1fobYfVgMU8cWdpP4Dv+GeC6oAx53kbi8ET6PfTm9TwJzoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_13,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220154
X-Proofpoint-GUID: ukS6BMm9jQYZOgLouF6wC0bs-xZViJ7i
X-Proofpoint-ORIG-GUID: ukS6BMm9jQYZOgLouF6wC0bs-xZViJ7i
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 3/21/2024 10:08 PM, Jason Wang wrote:
> On Fri, Mar 22, 2024 at 5:43 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 3/20/2024 8:56 PM, Jason Wang wrote:
>>> On Thu, Mar 21, 2024 at 5:03 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 3/19/2024 8:27 PM, Jason Wang wrote:
>>>>> On Tue, Mar 19, 2024 at 6:16 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 3/17/2024 8:22 PM, Jason Wang wrote:
>>>>>>> On Sat, Mar 16, 2024 at 2:45 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>> On 3/14/2024 9:03 PM, Jason Wang wrote:
>>>>>>>>> On Fri, Mar 15, 2024 at 5:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>>> On setups with one or more virtio-net devices with vhost on,
>>>>>>>>>> dirty tracking iteration increases cost the bigger the number
>>>>>>>>>> amount of queues are set up e.g. on idle guests migration the
>>>>>>>>>> following is observed with virtio-net with vhost=on:
>>>>>>>>>>
>>>>>>>>>> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
>>>>>>>>>> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
>>>>>>>>>> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
>>>>>>>>>> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
>>>>>>>>>>
>>>>>>>>>> With high memory rates the symptom is lack of convergence as soon
>>>>>>>>>> as it has a vhost device with a sufficiently high number of queues,
>>>>>>>>>> the sufficient number of vhost devices.
>>>>>>>>>>
>>>>>>>>>> On every migration iteration (every 100msecs) it will redundantly
>>>>>>>>>> query the *shared log* the number of queues configured with vhost
>>>>>>>>>> that exist in the guest. For the virtqueue data, this is necessary,
>>>>>>>>>> but not for the memory sections which are the same. So essentially
>>>>>>>>>> we end up scanning the dirty log too often.
>>>>>>>>>>
>>>>>>>>>> To fix that, select a vhost device responsible for scanning the
>>>>>>>>>> log with regards to memory sections dirty tracking. It is selected
>>>>>>>>>> when we enable the logger (during migration) and cleared when we
>>>>>>>>>> disable the logger. If the vhost logger device goes away for some
>>>>>>>>>> reason, the logger will be re-selected from the rest of vhost
>>>>>>>>>> devices.
>>>>>>>>>>
>>>>>>>>>> After making mem-section logger a singleton instance, constant cost
>>>>>>>>>> of 7%-9% (like the 1 queue report) will be seen, no matter how many
>>>>>>>>>> queues or how many vhost devices are configured:
>>>>>>>>>>
>>>>>>>>>> 48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
>>>>>>>>>> 2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14
>>>>>>>>>>
>>>>>>>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>> v3 -> v4:
>>>>>>>>>>        - add comment to clarify effect on cache locality and
>>>>>>>>>>          performance
>>>>>>>>>>
>>>>>>>>>> v2 -> v3:
>>>>>>>>>>        - add after-fix benchmark to commit log
>>>>>>>>>>        - rename vhost_log_dev_enabled to vhost_dev_should_log
>>>>>>>>>>        - remove unneeded comparisons for backend_type
>>>>>>>>>>        - use QLIST array instead of single flat list to store vhost
>>>>>>>>>>          logger devices
>>>>>>>>>>        - simplify logger election logic
>>>>>>>>>> ---
>>>>>>>>>>       hw/virtio/vhost.c         | 67 ++++++++++++++++++++++++++++++++++++++++++-----
>>>>>>>>>>       include/hw/virtio/vhost.h |  1 +
>>>>>>>>>>       2 files changed, 62 insertions(+), 6 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>>>>>>>> index 612f4db..58522f1 100644
>>>>>>>>>> --- a/hw/virtio/vhost.c
>>>>>>>>>> +++ b/hw/virtio/vhost.c
>>>>>>>>>> @@ -45,6 +45,7 @@
>>>>>>>>>>
>>>>>>>>>>       static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>>>>>>>>>>       static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>>>>>>>>>> +static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
>>>>>>>>>>
>>>>>>>>>>       /* Memslots used by backends that support private memslots (without an fd). */
>>>>>>>>>>       static unsigned int used_memslots;
>>>>>>>>>> @@ -149,6 +150,47 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
>>>>>>>>>>           }
>>>>>>>>>>       }
>>>>>>>>>>
>>>>>>>>>> +static inline bool vhost_dev_should_log(struct vhost_dev *dev)
>>>>>>>>>> +{
>>>>>>>>>> +    assert(dev->vhost_ops);
>>>>>>>>>> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
>>>>>>>>>> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
>>>>>>>>>> +
>>>>>>>>>> +    return dev == QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->backend_type]);
>>>>>>>>> A dumb question, why not simple check
>>>>>>>>>
>>>>>>>>> dev->log == vhost_log_shm[dev->vhost_ops->backend_type]
>>>>>>>> Because we are not sure if the logger comes from vhost_log_shm[] or
>>>>>>>> vhost_log[]. Don't want to complicate the check here by calling into
>>>>>>>> vhost_dev_log_is_shared() everytime when the .log_sync() is called.
>>>>>>> It has very low overhead, isn't it?
>>>>>> Whether this has low overhead will have to depend on the specific
>>>>>> backend's implementation for .vhost_requires_shm_log(), which the common
>>>>>> vhost layer should not assume upon or rely on the current implementation.
>>>>>>
>>>>>>> static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
>>>>>>> {
>>>>>>>         return dev->vhost_ops->vhost_requires_shm_log &&
>>>>>>>                dev->vhost_ops->vhost_requires_shm_log(dev);
>>>>>>> }
>>>>> For example, if I understand the code correctly, the log type won't be
>>>>> changed during runtime, so we can endup with a boolean to record that
>>>>> instead of a query ops?
>>>> Right now the log type won't change during runtime, but I am not sure if
>>>> this may prohibit future revisit to allow change at the runtime,
>>> We can be bothered when we have such a request then.
>>>
>>>> then
>>>> there'll be complex code involvled to maintain the state.
>>>>
>>>> Other than this, I think it's insufficient to just check the shm log
>>>> v.s. normal log. The logger device requires to identify a leading logger
>>>> device that gets elected in vhost_dev_elect_mem_logger(), as all the
>>>> dev->log points to the same logger that is refenerce counted, that we
>>>> have to add extra field and complex logic to maintain the election
>>>> status.
>>> One thing I don't understand here (and in the changelog) is why do we
>>> need an election here?
>> vhost_sync_dirty_bitmap() not just scans the guest memory sections but
>> the specific one for virtqueues (used rings) also. To save more CPU
>> cycles to the best extend, the guest memory must be scanned only once in
>> each log iteration, though the logging for used rings would still have
>> to use the specific vhost instance, so all vhost_device instance still
>> keeps the dev->log pointer to the shared log as-is. Generally the shared
>> memory logger can be picked from an arbitrary vhost_device instance, but
>> to keep the code simple, performant and predictable
> This is the point, I don't see why election is simpler than picking an
> arbitrary shared log in this case.
Maybe I missed your point, but I am confused and fail to understand why 
electing a fixed vhost_dev is not as simple? Regardless of the 
specifics, I think the point is one _fixed_ vhost_dev has to be picked 
amongst all the instances per backend type in charge of logging guest 
memory, no matter if it's at the start on the list or not.

>
>> , logger selection is
>> made on the control path at the vhost add/remove time rather than be
>> determined at the dirty log collection runtime, the latter of which is
>> in the hotpath.
>>
>>>> I thought that Eugenio's previous suggestion tried to simplify
>>>> the logic in vhost_dev_elect_mem_logger(), as the QLIST_FIRST macro that
>>>> gets expanded to use the lh_first field for the QLIST would simply
>>>> satisfy the basic need. Why extra logic to make the check ever more
>>>> complex, is there any benefit by adding more fields to the vhost_dev?
>>> I don't get here, the idea is to just pick one shared log which should
>>> be much more simpler than what is proposed here.
>> The code you showed earlier won't work as all vhost_device instance
>> points to the same dev->log device...
> This part I don't understand.

vhost_log_get() has the following:

     log = share ? vhost_log_shm[backend_type] : vhost_log[backend_type];

     if (!log || log->size != size) {
         log = vhost_log_alloc(size, share);
         if (share) {
             vhost_log_shm[backend_type] = log;
         } else {
             vhost_log[backend_type] = log;
         }
     } else {
         ++log->refcnt;
     }

So for a specific backend type, vhost_log_get() would return the same 
logger device (stored at either vhost_log_shm[] or vhost_log[]) to all 
vhost_dev instances, and the check you suggested earlier:

dev->log == vhost_log_shm[dev->vhost_ops->backend_type]

will always hold true if the vhost_dev instance (representing the 
specific virtqueue) is active.

Regards,
-Siwei
>
> Thanks
>
>> Regards,
>> -Siwei
>>> Thanks
>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>>>> And it helps to simplify the logic.
>>>>>> Generally yes, but when it comes to hot path operations the performance
>>>>>> consideration could override this principle. I think there's no harm to
>>>>>> check against logger device cached in vhost layer itself, and the
>>>>>> current patch does not create a lot of complexity or performance side
>>>>>> effect (actually I think the conditional should be very straightforward
>>>>>> to turn into just a couple of assembly compare and branch instructions
>>>>>> rather than indirection through another jmp call).
>>>>> Thanks
>>>>>
>>>>>> -Siwei
>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>>> -Siwei
>>>>>>>>> ?
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>


