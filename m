Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0EBC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 18:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2wrr-0003v6-Sm; Thu, 10 Apr 2025 14:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u2wro-0003uZ-HZ
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 14:43:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u2wrn-0006DA-5C
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 14:43:12 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AHv43Y030910;
 Thu, 10 Apr 2025 18:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=FNzbJQEfQ6TCPwKR7lvUGIaBFcw+Nup3wklEtPq6Uc0=; b=
 hjK0qkTmY8465IHr3Wi4jp06W1D50rdAMUsPJO/+NKVOFghHZIMuxZbff0MR3rgH
 NsS+VtppJ6si/7+cLuBAYDetXCMfHQkIgb1LKAt8tlmd+7ctBK0CzfJBPjn5Wf+U
 Kvenwp0qw0ZwZuxNYUDc03Yv1Y15YmgiQjNhEcGa4hm1u6sUtlY2UMHSey94aaXD
 uOOL0oL8Rd1VakgItu1EU66aSJlrq7PWjJTxoQrS+p2T20hv/QcsMrFa9w2mlM+E
 jvmVOlTEjWNELe1OQdhcbqMYrEnjTzK+WGEmU1XhayB+9Wto7J+6+X7ARmyLbejV
 seunzrLfCyKVmga/RnVDpw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xju3g3ja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 18:43:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53AHLDQ6023763; Thu, 10 Apr 2025 18:43:07 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012032.outbound.protection.outlook.com [40.93.1.32])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttyk0bj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 18:43:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwrikyVgAxueXel4Mw3fGe8JzVhvqOmvA5lt1K9xxqGosK6lxxWzZRfG1bysbI3DWTwjNa+7HXFTXMroA8/RfVrTv256YO537ucfzQMpk9UYIEVXM2pXT75hjh7kiM5Y99CGrQKSArJW5OpdFHU0DRno5tJV+HasOE/6zOTyjfOv1ncj5b/4dHH6brAu5pTmGiK7XCGQGW+9kmBuIYxlNAcQkswrBpyqc9DfRnhKgXwzwrAIQi9ybq84oGonvOYUzfYaJBSS9+Oz7V7mc9ASyYNZsKwSZBOewZGhwcW5thNxvx388modwA/zUVtD9hCnIHibhHUNleWDL95JZ19AcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNzbJQEfQ6TCPwKR7lvUGIaBFcw+Nup3wklEtPq6Uc0=;
 b=UflptliXfDuNtxbsR6Q/sM95rUkjTD+Uk3acWbyey/5QyrRTx6q3RksqP5NQr9Cuf+c0JyOubeaOk+axYVvHqopx2/MzyT0/AxUIAojmP01zdZVaXOL3uEoCwtvmctLm9Z1YbGYFcoqN9UrUtyNoK8aRqD2jRZ3sD8aWmRzqy5jGasT01oXSog5zZyYGbtFUHGPeNiD/93iHElxSIC/ia1PwYPCMQHZRQC4jMgB49B0G43rsEJFtYRlQcQXUxfqAzmd4AHcCXgHEMhWTprdHy/X3FsUL0a7JVmPl4we3yoWOsibsAHLZlMSPGY0yWU0Q4rNUZ92FES9kRB8CmGfmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNzbJQEfQ6TCPwKR7lvUGIaBFcw+Nup3wklEtPq6Uc0=;
 b=epwJ1L/dmeCzirDGTMxy+bjycwpDQpnp4oTBbeXiitNmLsoljseoLfq73ObaWLFnc6oiU4VcTH6QZ3hqJANRDDLDmza8djY2e3Z5vZGnvHCtF6DsdljbZr6JVKbKqsvKXxn5uegmOgDc361QUl68/ZOOc5LkTzSYVgKHc8mLV8U=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN2PR10MB4302.namprd10.prod.outlook.com (2603:10b6:208:199::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 18:43:04 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 18:43:04 +0000
Message-ID: <b408bb63-1cc2-4b2a-a630-b05b4af60004@oracle.com>
Date: Thu, 10 Apr 2025 14:43:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [for-10.1] qtest: introduce qtest_init_ext
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, lvivier@redhat.com, farosas@suse.de
References: <20250410162250.329941-1-vsementsov@yandex-team.ru>
 <3cb0e046-99b4-4f75-86fe-739df57b858a@yandex-team.ru>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <3cb0e046-99b4-4f75-86fe-739df57b858a@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN2PR10MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b61b3b-91e5-494e-b37b-08dd785f8765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTIwb2JtUnNvUm5SOWkyRC9pdElDYzRrN0hBYjVaUzl5UVR1WmFjTEM2dTBi?=
 =?utf-8?B?cWN0VHNxa2dKQUp3Z3owanVzMG8wRVpTd1RwMzQrMFhMSHA0dkNrZ3FFSkov?=
 =?utf-8?B?cmpyM2t5WFh3QXJTaDBWUjZpbVdlTm5RNUh5SENLSjZnMmVVZG9nVWlSTnJy?=
 =?utf-8?B?RlFZTWZDME5TN0ZXYkZzRHN2Ykt0OG43UlNpQXEvOWpUYXl1SU15N0VUMlo1?=
 =?utf-8?B?dkJESjVscTNOSG5wblhRbVZDZTFxMFExNmFuNmVJbWI3MnhuWG94clJLSDZ0?=
 =?utf-8?B?SUU1L1liNjhZLy94dlRETnN5L0ZNVHJZdXh0eElONG91Uytua3ZkVDYralkv?=
 =?utf-8?B?aUlpVG9GOXU3b0JVTWxkOVNGSW5aOUhKYkhSaVdpK1hrOStIRzI0OEwrdzNK?=
 =?utf-8?B?Ny9yVTVWK20xc2phT2JrVGJ1a3hEbzcwQmtuUHd3cFB5TFRmRVgrVXBiajFa?=
 =?utf-8?B?eTFtSFNpMXl3V0tuS09uWkMzZXgxcHYrOFQrMW1ZYWUxY2dFalJybDlraS94?=
 =?utf-8?B?UVV1Ny8vV3ZQTzF1d1Mzai9XM1hoMDlhL1BLNjhFWlJhTXpRQ0JuUmorTzNQ?=
 =?utf-8?B?WGZSUitaeWF0SjNCY2c4L2ZqMmQ5OW5QMk1vTzVpZzg2cVJZckUwYzlqNzhJ?=
 =?utf-8?B?aTU2YmxITlJSYnArcy9wQThrMHprMEEvVnM0eVJJc2J2Tk91S0cyRll0Z3c1?=
 =?utf-8?B?SWhEQ1cxNU9jVUxYSXRPTytlbGZMQi9nWStVUkZFZ09oWG5jQzNpRWIyYmhl?=
 =?utf-8?B?TVgwNDhCeFcwQ0plWSsyOThLL1F4bVh1RlNON3M5dm42MUdCMEVCZkkxVG5H?=
 =?utf-8?B?MElEdzdSd0h5STJjMHZhZjFmeWhPWUFHZXFSUGE1ZTVaUHpOOXV1Vzc5YUxI?=
 =?utf-8?B?YlYzdVJDdHBTTXBKTytPYnR4T2RGNnBhMjhzbzNjbGpYc3gvZ1crNzUvNTc1?=
 =?utf-8?B?M25COXFhTVcrSm5vdFNFdnpkWlBjVFBsY3ZyVnpGbUhvdTdOQ0RZeEU2L3F3?=
 =?utf-8?B?U01OR1RBRjBKdnhHYjBlNGt6em15NXJJSWx5T0hmZEh6MFBvQVVFNFFxZThs?=
 =?utf-8?B?OVVCZmNYNXBMdVVRRzZyNXE5RWFpNFlvc25OZUJNZS8zdUVEcHpYMmExSnJx?=
 =?utf-8?B?NEswdWR6VE00NW1BeERmWklNaFVuVU41UFJmOWFxa0pmbDFuSW1EdnhVSno0?=
 =?utf-8?B?SWdPTEVmWXhNWXR1ZVhCVUlueHJ2cXlQdUw3aWwwVGtsYjdCcXQ2Kzd0ZnFK?=
 =?utf-8?B?QWJXTytrcmlrcUVCcDQ5ZUFvNGNXcDUxeHk1YkJzbUxUSWxKMjRmSlg5aGVT?=
 =?utf-8?B?aVpDVzhScWZQNEh4UGh5eFZRTlNYc3RlZHRTMXowZU5BUkdSa1dWd3c0Ynlv?=
 =?utf-8?B?NHdFd0xWdVN3RngwSHJOODV5cGVReVk0VEo1NXBabi9nKzNnTHZNRkRQTm5I?=
 =?utf-8?B?SGpRWDI3K2M2aTN5VWJsMEh5dG12cHJRM0N6QXRacklEZit4Mm1FbmFSVHdT?=
 =?utf-8?B?bzhFb05rWHRxV25kN1NlbFlQTXJXbXJZN1BvUzAxcHJ0SWhyUGlEL0lKLzBn?=
 =?utf-8?B?R3lVcUwzRm5KeU1qanlmS1o3emxmSzRZWjdwaWlmZGNvSlFmWTlmODljYndY?=
 =?utf-8?B?MlJBM2lHV3ptL01Wd1Zyb0lVUHpWWE1abXpBV2tiL1JBeWhEQmtKMllOcmUr?=
 =?utf-8?B?VlUvN3IwWjRWeVVabFQrVFhyUFE2NzZCT1BweFZQTkh0U1czR0NRSkM0UEYx?=
 =?utf-8?B?L0lOSS8veDBJL1hyNkhmN293M1JrZGNiaE45QitVNXBxMDdNRVpCVmUzdUc5?=
 =?utf-8?B?cVExUGpJNmNESWlKRzZIZ05ORzcvK3ZiWTdDWkF4YUs5UVEwYnMwMjJENU01?=
 =?utf-8?Q?ovHUU+Ui+v9Ia?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2ZVQTFSK2lDc3JLSXhLK0Y4K2wzNkI5dGRJSDZxT0d5QjdoNEZjTU43dTND?=
 =?utf-8?B?b2pjRHlRMHFXM2JUUnQzNHd2OGJFanV2R3dxc1AzNGhEZFBUZFAzMU9NekVu?=
 =?utf-8?B?SllFRTFtRWJ5ZlNRQURWYWNFOS81ZGg2ZkNBemlsd2xvb1ErQ3lkdklURUky?=
 =?utf-8?B?QW51UW9qMTRBVWNiR1FyUmp4c2ZyTUVnMGFJTnQ0a24zM05PZTV5QmR0cVNs?=
 =?utf-8?B?ZmhJRnk1Yjd4T2J1clBOakRFL0Z3NW1RV3ZvRWtJUVk3RjBSdGdJT0xuYnFx?=
 =?utf-8?B?aUt5UFUrTEhSZTg1MzhmR3dER1M0eVdmdlFqaXJBYU92U1ZWL3UyRjhnZ1ls?=
 =?utf-8?B?MEFrWitkWkxHUnY2M1NOaTh0QlI2VVA3U0tKSTZMK1BGb2kxd2hyOHZEODhN?=
 =?utf-8?B?VUNKNzJrUFAzS0lwTlZlRXBKMFFYTkZIcW02aExVSGVQN0RsbFgyV1ZSWGh2?=
 =?utf-8?B?cTlFU1dsd0dmcCtpaGFLSmtZRkhIUmYvYkpZZ2trc0g2Q29jbzdJVkdDcVVs?=
 =?utf-8?B?Rm1mVnhUUis0T0d4SmN6VlVmUFV1SG9aWldhTG9WVVZZQ3NkbEhWSUtMZXJT?=
 =?utf-8?B?VDNSK1g1T28yL0RjNEtGZDVGQlg1Qk13cXpnKzBHbHlzUk1Wc0hYTmwvT0Iz?=
 =?utf-8?B?bUdRRkdpRkJvdWFhaFVQTkJmR1Nnb1RSSTY4L211MVZlU21WRXZudllpWjZ2?=
 =?utf-8?B?SlY0Y0dHQkZNaEhjbWwwSnl1eC92RHlYY3RJcGpNVjFNQmlHaVBjV3ExUU9q?=
 =?utf-8?B?enBMdklJSGtES2dsT2VXdzJ0S0RZWFBjcVJnYkZGOUNaM0hYOTRqZ0JOZENU?=
 =?utf-8?B?TzRpcVd2UkhuVE1FRFNQckR6V2w1ZVprcTR5dFB6d0FzZHo3cStDNVRFa1Fp?=
 =?utf-8?B?QXo3TGpaSVVnMk91WUd2MGk2OXZHMkhNQmlJZWV1UGFjaEdXazdCaVNiQVZp?=
 =?utf-8?B?TTk3MFV6OFY5OXpTOUc2alRPRG5YSVc2cEZqY2lCU2p4cGhKK2h0eE4rU2lN?=
 =?utf-8?B?RWRmMmhZQVRFNEhGMDRmbG1pOEJiQXNpZFdhbHc5NDgvVDU2UmQ3MFZhSDJQ?=
 =?utf-8?B?aG1lZndCM1QwcG5lb3FKc1hjUXRqY2dhUHB6Uy9qd3R5S25uN21FY2xlek5u?=
 =?utf-8?B?Vm4xT3k5UC8weXF4MFh4NGhkOFI4TnZQZUlQaG4wQlpxZWJDc0JNMi9sUFdE?=
 =?utf-8?B?UXBMSk5jMXpseExRbFdURzZ0RXRETDNwbWdkRVRueUY0dFloaTh2a3o4WThl?=
 =?utf-8?B?T2JLRjByVW95UFZNSXBkcjg1SW55VWZWWlJhQldoWUkwdGZ1b2h2YllwZGFl?=
 =?utf-8?B?MVF3TDc2eCtLc2dFUmlwREZzOE4vSWtsYjdnMy9xNWo1bkQ3Z21MMkIyc2d3?=
 =?utf-8?B?UGxoWm5CTTlQNXNIQXdNbDRDSWwwSVpLd1oyejh3anczcG5MOWZyYTRlTHRR?=
 =?utf-8?B?Q3hhM3puTHVCZzVVeCtwQzEyYTVLSFhPWGxWWFRtSnhtU29BaHV4TFcrZVVY?=
 =?utf-8?B?UGdTMzNBVFMxMzdialNhQ3NobTRSallJTjR2c05OZE1WbU94cE1tQW8vV0dv?=
 =?utf-8?B?RTRXWUw2UVR3eTgraC9tcEMxL2R3KzBHNVJENVJYYXVtTXYvOE5EeTdpajB3?=
 =?utf-8?B?NjBjYjdkQnR0OTNtcTBmL2d2bnlBSVpGeHJ4YkJ5Z2MwZjkyOXRGczFCbWVm?=
 =?utf-8?B?VGdVVWdEOEhzOTdzekZqS3ljVmF0VVV1MC9XcVVnUmxobmc3Zlp1Z0Yrdit4?=
 =?utf-8?B?UlFiS3pKMkNrbWJDQmNUQmNPTm9Kbk40Y2hFZW42ZWV4YzZTY01sMFJSNzlI?=
 =?utf-8?B?RFhORGdxVFJib3JoNVhiaHlUVy9JY2l2Y3pocFpxM2wrWlVRM3BzcmtzZjNV?=
 =?utf-8?B?SEtLREVlY1lEK0x2OGszNStkZDdUQ0lqNzJOQlIwaDRKOWRjY2hQYlZRNmRY?=
 =?utf-8?B?S2NGci9CdU5wRWJ5Uzh6WXdzNFU5M3pZb0FuZXhGZUdrbXRHRkNZZER5a0Js?=
 =?utf-8?B?UVNUOHJGVXdabXZLUXcwRmtHZzNzSGpGaUZXeUR4cVlEVDNTcjNINzR6REsr?=
 =?utf-8?B?Umdid2hlRitkcTdxRHlBaFkvT3J0cWRKSng2UE5yM1NVd3hxWlRxbFg0b01M?=
 =?utf-8?B?TkJCdDkwOHp2RmErZDVhSmVMdERWaUs0anlLWCtlcVhoWWF6akpXT3BqZU9u?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gn5l3OXOw7YsktPcHVzfFYiCWtqwkXNDSkO9eiQsWVQiILM/a77hTR+VnlpSci4SiVzknacZUr068gj72WOO/IKdyJv9FqGuRSGIgL3TaUGrMLl2zU7aaELl+/NdRADo/psYfUioKVcikFU2qP3OsalW04iEymwB010tFbwHO8oZkqD6zQmxSjT3BlTwjLavj7CywvugsEG2sF43zr51LerUutiICTQrzayu/fRvsaSlheJSlTQnfpkE86dM2NtnKtYu2Y4MMxiTmIarXflVRCY57Iyc+4aXTRme1/IdqRr9+8Z62EV75jNO6ot7ckNH4xoVTIxmR7lTSyOo+MG12Pv1G4dUNTOw19hx/28ol20yBEn+F8irASR1R7FNXAaY/lhABzov4mtPuiuupSTkPhU3PxOGkdWcXv6aI71iqYctiravj0u7FBtyo7hEW2aPO62tAdj1rRmq8Z7jN7+JXtKDHMsCNcgWE7mIpA9URNRV+iMM20SHSWFSQHB63bNGAReMipqIrfsiT23txevI7Hbp4je6/L6eCWzZCjzM8/57UwB2+h3hbvGth3LL1Q5+sh4vk3dpdBRv5X2R7Hrtax3GnhsjP8iLisfHvj6+4Tw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b61b3b-91e5-494e-b37b-08dd785f8765
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:43:04.6361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsTGqUdN2D59n1kSqrlg2SfvZhU4f2vJXvpT7gh3ZrDOsrMF2mv4s6BXe2GyA624JKNCTus+YXSJO9pmvKo/fkgAWzIX+gz6r6Wxj1Ef0Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100135
X-Proofpoint-GUID: KJGgCiChJAwzbu0UvcVCEwssEvVEycfk
X-Proofpoint-ORIG-GUID: KJGgCiChJAwzbu0UvcVCEwssEvVEycfk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/10/2025 12:24 PM, Vladimir Sementsov-Ogievskiy wrote:
> On 10.04.25 19:22, Vladimir Sementsov-Ogievskiy wrote:
>> Merge qtest_init_with_env_and_capabilities() and qtest_init_with_env()
>> into one qtest_init_ext().
> 
> CC Steve

Good catch on qtest_init_with_env ignoring its do_connect parameter.

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

- Steve


