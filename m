Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A0EC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 15:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcrh-0000Rl-GP; Tue, 01 Jul 2025 11:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWcre-0000Qt-RV
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:25:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWcrZ-0004Xf-P5
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:25:42 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9W2h031410;
 Tue, 1 Jul 2025 15:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=U7/etctmJcQMEwrbOvq+plgonflv+J1iOa0C3PqMjfI=; b=
 AdbuIhp19qAxcSTJJGkcWRH68eSXgYHcU//XzvtGz1PGhLM5jMND9Rv5mhacqJyD
 /uLeieQW7fA5KgEZy1T8NYJbWooRldmAhvgBhKcrl8joHd6KnOqsEgJ7kAqjSoi8
 o4F4sUUt28z6Q4eppTuYcYVe+SUmt77lUrJi2DdnUohp5WSGjrbuPaMg4eyqTSig
 Nc+Ryr1M+YOwsRwBTMdmnnhVPltdA0RP8bl9m/AR2t+YOEhtlhVMY5TgcNfIK/3T
 dqFhvt5/uVTRDnefVYTjM+WnuphEZXdtCUpYAcu4Tp1fG2+EmbtI7aPx+6f01MXH
 W4ta+681GP+vv5RHvE23ZA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af51j8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 15:25:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 561F2Ipb019262; Tue, 1 Jul 2025 15:25:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47jy1epfs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 15:25:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPK12BIgasv7wN/Pe/MdznswwGYYFu2U1xGPitHgYfhmjw0anVbNAsZgjgj0/xR87T9gV8m6btN6akZJEuvG6HSdgUQbFO6Oe1UUsNL72rlutJr60/g1pfFscfFln/BB7cifBE6DgIHp9e1ZNOv19thYroe6yKLeqvgz75NZbrseLM1OluC7HVxifyPNzMY+5zzejSqP9NB+Ir7VlCDdjcoggrI1FLmjG4DZexjgrP5fVUlthuyh1LNGx8KcpiM4azwpNelxvN37LvKU2TanNU1EI5cC8+BQdDFTxYyiI3K4pUctjceAvG3dhiokJ4mKBCHNtLkquzqo8U7iZhyJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7/etctmJcQMEwrbOvq+plgonflv+J1iOa0C3PqMjfI=;
 b=JR2JcVXqoaxzJ6ttMxYfENEivJHZ3CThXZrR1mcsdl3afV174y27s0LwwKYzQHPCG//9YqzQlJZVSVSOg+vpUmAVQHp/UYTMQqAP7M2uv2Q6XfFanF9BOhv1KJbkymCfjm1jn7NDiI56QXB5lm08Oz628DxOQDF8kLhMFmVU26brNnLw5m/c/sFvlnxCL8lr8Vk4cX8Ph1P+5d+YA/b3j0JSidGNSx9xrrFRlW8hKqV+hKuPxVnR2KfzMDSCktYmEVfHZHfJajRsFDoeA4SE8TJZxhB6VUJdrDFj1835e0beDrwolIf9OPqPp/psO9tBVIHeKtsJHWKCwrfH4FPH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7/etctmJcQMEwrbOvq+plgonflv+J1iOa0C3PqMjfI=;
 b=Q5dpgkYsv/lX2pZg39SaIPD4HTHPmVM69JlIs0yYuBl8cssBLnxuhFHa2EVfQtksg8sJLNsBcRk7oaDW6KEiTjLj57LfFY7YnmU9jK66SspDJs8Ko5xyVmQWsJYZ7+DnY6tsfK81EZNgluVxNhTYaHlT+yXksoys9FaIoYwHP8c=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6481.namprd10.prod.outlook.com (2603:10b6:510:1ec::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 1 Jul
 2025 15:25:28 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 15:25:28 +0000
Message-ID: <9dfc0dae-f048-4d41-9b6e-02b6e7dbc215@oracle.com>
Date: Tue, 1 Jul 2025 11:25:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 20/38] migration: close kvm after cpr
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-21-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-21-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8aca0f-9bc9-4806-0a3d-08ddb8b3824e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWlwb1I4NXFOMHJqTU4yQ3JENk1Wb0FjaW4rZCtZb0J5MmRjUkdCL05UYk9i?=
 =?utf-8?B?V05FY2czMzNubk52UVN5dm9FUVpKc24wS1lpZlNqQytGSlIycGIxNGhFNnBx?=
 =?utf-8?B?alRSSVRpMXlJeURlbTk3ajU5ajdzRmxaNDMzYm83TmFweW0rYml3RSttTzJl?=
 =?utf-8?B?Q1FnQkRqRFk5QVVJQVRwZWxJOVBzU1htaDZvZnpBQXRjTDJXU3lRUWk0QlA1?=
 =?utf-8?B?SGozMlFDR1RCcXNzcWFRVjRWNWxvYjZ3aFo0YjhUaFJxN1NtLzJONUFBTytM?=
 =?utf-8?B?T0hqdWhmR011cjJxMllIcFFOcDliNmJRVE43TGQ3Y0JzY2FjcFh4RFdsbWlQ?=
 =?utf-8?B?VmRuUGRjMWQ4ME94bm5jSkIzazdHU3hlcDl3K1FiMk9NSkQ3NlJGajdDNExT?=
 =?utf-8?B?SENKajFqdnpER3dwQy92ZGdUbUN6dzNRbm5IM1g3R1hTVjNlY3l1T25aSlNV?=
 =?utf-8?B?YXovZnlTSmhCVzBMZ0NIM0FlWmJ0K3lGMmgwMHV0N3JjbnpuRTREK0xlSG1O?=
 =?utf-8?B?Vk5YbVE1UWpwbjZRU3RHeTF5ZkFWeFZMdU5kMkZhcVBPamtyU3NaVzArc1Uw?=
 =?utf-8?B?akhxTjFHSjhZU0RCNmNnRXkvSzRoUytyZzRIc0ZSTDFzZ2NxOC9JaWlJR0Ft?=
 =?utf-8?B?VU5Rc0tqSjFSOEc2MnZjb3N2S3NJaHJyNzY3ZG9pL2tjTE1wQmhLamlMM3pt?=
 =?utf-8?B?SjM2OW1VVjhWT2NxSVBGSGM0ZlUyb1g2d3ZQMUJXSlpySnBRUHJBckphNHNK?=
 =?utf-8?B?RXJsY3BZcWZXOU5NeE9TTHZ5YTJtcmZxSTByN0kyWHdYNWhlNkhjKzg0RVRC?=
 =?utf-8?B?KzBBYlozdzJhckpNcU1HbVpIUk8yU2k1dzNLUDdWMEJpb3ZNbEhWY1VVZCtn?=
 =?utf-8?B?ZjJma3VqMlNYNGV5ckJuU3I1dGJETnBKT0pQVDNQV29FUHArWjNlaWMyUHZr?=
 =?utf-8?B?cEdYTjBISm43R2dtRzFHSlc0QWFzSmZydW9DcEhPZEJURHNNeWQ0MmFqVkxv?=
 =?utf-8?B?M1Bobjl1OU1CWEhxRmN0ZFlBT3dUZllRdWQ5dDVIK3poZXF5c2VXM2FaWWtt?=
 =?utf-8?B?bE43UlJaM3FON0g1MVJKMjdhcmZXMUNnUjFNRHBoMXdPQzhlTWFwZElIcU1y?=
 =?utf-8?B?L0VEYnlQYTczTGU1ZWpLcExUSFVwcmNiYWtaWDRwZ21SNFNVVDQ3elBvMFNH?=
 =?utf-8?B?VXhsV0FaaGYyY2p4eWd4dllvNnR0U1R1YVBLYUNTbWViYi9SbWtnYm03ZVVi?=
 =?utf-8?B?ZjA0MTd5dzRIZGtqOUVtVGNWUHAwR0pSV1Y2UWprR3c5MnY4d1Fmb05kVHpJ?=
 =?utf-8?B?UWRMalRIdHdBZFlhUXA3VDhSM2xhTWxaa0xkS3YyNEw2QXFoM3p6QUdxWitW?=
 =?utf-8?B?YTdrWGE0MHVubXJ5eTE2UDJIRFBwZWdDZThnVGdUY3BsSW5lRTBIZm95a3p4?=
 =?utf-8?B?N1NBaHhjV3RDU0VOWjgyYWVqeU1yQWNOTjk0c1htV1VsNnRUSUNvMW41VVRl?=
 =?utf-8?B?ZERLNGVVY3ZQR0hraXczVnVZMG9pWGxkM2N2dFovUklzU2RrMjh5Y0gwSGV0?=
 =?utf-8?B?aGZ0Z2h3VUVRMFJ1NTB6SGM2U0NRWC91VjdKTHpFclFianViV2EwVEx0QndM?=
 =?utf-8?B?WkJLLzFEVzBQWHJNVmd4R0RuUE5xY2drWDc0Tkxmd1c4TTJ5T3JPMnlkYnhR?=
 =?utf-8?B?TXZXWGNFMnFYSkszWlFqaEwyLzZhSzB5V05leGp0SFE2QVVzako0NE9FUmVC?=
 =?utf-8?B?K0dkSDgrdzR1YlliTmZFZjAycUs1VTRmY3M4UEFrZTBzWEJRdWxYSTVrUzdO?=
 =?utf-8?B?WnhnTGZwZGdJNXoyS2dqYWpZZFM0UENYZ1Z4S1hHWUpjQXNLc0E2OHNlN05n?=
 =?utf-8?B?WmJVZ21Tc2UzUTJPanR2ejRCYlZVOCtHNGY5eExlVE4xWVc2aU5IQXhTUnMr?=
 =?utf-8?Q?qj1NcnYur6o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxQZmZLUjlyOUxvd3ZMTG1rUFltR1lxbVhYZnVyd2VVbGtLV0lHUGlteEFl?=
 =?utf-8?B?RVZBVktteFU2bVh5S2hvSWhMcTkvdmVIeTBjOEpqYjR1NHhkb3BjT0pkNUh1?=
 =?utf-8?B?L0trUm1vZ2h2ZFpCN2hhQ2d2NFZKR2hLZEo1SW5DQU9lZVorcGplUHp4dlRN?=
 =?utf-8?B?SGY3TS8xaHYxOXhHS1ZWYWhObVc0TVJ6a0ovVVFNWW9jTzNIVHc5dUN0OEpN?=
 =?utf-8?B?Y1RaNjlvMjhscmpmbG1Wd1Vwbm0yZFl4ZU9vaHpySU5pZXdXcHVkb01rQjlh?=
 =?utf-8?B?UlZya0NuSjJGOU9SYVdtVTR5SmtZYjVWSmVrTUduRnJ0TC92RWxWc0FhZVZY?=
 =?utf-8?B?cGJBNU54ajczWkthRjBrQU01SW1hcWdUaHhXdmNzZ3VmYUFJZ3hydmg5bXhr?=
 =?utf-8?B?VWQ4QXF3WHRDZFBUeCtjaG5POWdFT0dGdjV5UTA3Y0J1SEw4TXpvcW1PR2U3?=
 =?utf-8?B?YU1vUUxMU3cwajBsZ0J2TkV2eTEwVWpUR3BnV0w1RHF2dUMwVVpKS2VzYXJ5?=
 =?utf-8?B?NS81YWtMZWtiY21zUnVkVGIxNFBmU2JQMkZndkY2b01pTmFQYkhWWmExYXBm?=
 =?utf-8?B?bjBsc3ZGQkF1ZGRpVVNMYS9nSWFYWFNHT25JYXFyOHpaY1JKNVU5N2V2WFZ1?=
 =?utf-8?B?V0VORzdWYWVSM2sxbXBKTWpxdlZtQS84WnBldTRtRWp1TmZhS1dDZ2hJYnZw?=
 =?utf-8?B?NVZ3bS83aURqUzl3c3Ficmg5emN4Wis2aXc1WTk5V3lmU3NvdFdYaEV4OUJS?=
 =?utf-8?B?bWc0d2VzdGpPVnVhdzdnMjNpNDIrNXZ4bTFRdXJDdlBOQVJ6TTlEVkZsL3gy?=
 =?utf-8?B?T2xVU2RpOHB3SFlIRGE3OTlieDBEai9BVFNubTVsWjhLZmpYaGdVejNmRVpy?=
 =?utf-8?B?Q2tvelRtSVM1T3RVdjZubzQzQ21SUHZIcnFTNlJTdzZFVGdtOCthN2NVamlp?=
 =?utf-8?B?SkcvcnZnSEd1cFp0SXNvZDJiTE12YUl0SUxiaEJnUTZwRVlRL0hGMGlVLzRW?=
 =?utf-8?B?MDcxTFJLOC9PY0p1eEorMzFwdk55RGwyUklZY0hudzcvTFVJSUhNTFBsd25B?=
 =?utf-8?B?YlNvSE9DMC9sMkdocjJrVkNmK1IyL2YyMDZJUkFGL0kxdmZCSzJhTXZ5VnlF?=
 =?utf-8?B?NjkvTFhrOFFQK0F6bG84NldyYUpkTHF6MTM5cndPVTg3RVI3bHZWQ05Ja2V5?=
 =?utf-8?B?cG5xbUpkdUVBNTdaZGZwUWpoNkluK3p6NVYyOWVCTVJBVjg4RjYrQS9WZCtC?=
 =?utf-8?B?anR3UW8vSGJic3ZwajU4N0RkVmwrMDlDelZhbCtJd2twcElUaXNkczAxNlR4?=
 =?utf-8?B?YnBYS0F6RndZY0dMY2M1QUlqTmwvb0gxL2w1MFgwbENiSWdlTjA0SnZRVlE2?=
 =?utf-8?B?a2pQMHkwc2Nzb1NqdDN5RmR6RUlYNGNneDlmTlo2ZGxvK1VGVmxxYnJJOVU2?=
 =?utf-8?B?bkVmODhGcE0rbExKZTZ5S1pLd1F0UWxyUTJaQnhGbE5nNWhMbVRuNm9YemlI?=
 =?utf-8?B?cFZ0MnBhZGhTdGl4Z2Y5SGhFSGlyY1VJdWgybDVlMFZCb0phV3ZXdHU0SUE0?=
 =?utf-8?B?MC85Nk54K2U4OFFPWDgzZ3FhdGhIbFdOMEUwYnYvWFhSTEF3QUpGTFJTRnZp?=
 =?utf-8?B?WG1tMEpLdFJINnNvOEVPSm5TV1JDbWpCckNFaTVWWVF4QkJkZHhZYzlaUE96?=
 =?utf-8?B?TVVtUEFCUnpuc0VqVUdqd1pobndIenFvekxyczA4emFIOEdvb0xwRGIzQUxV?=
 =?utf-8?B?T3cza3VBOHhaYnBjOTVXb3JRS05XU3daSEl1OC9BUXpWY2paWXJtMmQvWjRC?=
 =?utf-8?B?TVhFd0s2OGZrckxFbGxadDRSbzQ4UmxyYU9lWllDM080RWtGY2JSUXQ4SXRD?=
 =?utf-8?B?WkFPbTlQSlRrVEtLTDBBVFl3MTE3RTRGRGREeW1ZSG1sV2dVZVpDTjhYaG13?=
 =?utf-8?B?NFlVNkhOcEl4aDZwZmJGMWg5N0YvbWdrTUU0RUFKRWtYeE1vZzY3R0ljT015?=
 =?utf-8?B?Z24zUks0Um05alZCV1N2c0l3TEFkdEFzaFRIVUZGdWlDQTF6d1A4aGNJcVFC?=
 =?utf-8?B?M0R4K01yM0NZUk1NZ2tIOUNqUmtKamJBQTRUQzZXNTBiOUxYY2lBZ2ZDejgz?=
 =?utf-8?B?RWdJVTk4a3V0QzFUR2NRRklmSzlWeC9NRkxYQ1NlRkN6anZ2bTNBd3BhN0hz?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nXs3AL2k5PUbbCSxUJc9xZmGz+hJk8AwSS4DTshP98AHPpMIOfn7COY7Qc8dBv5fvwHV7yXR4jKN2Ee5j21+OuLKoxgJUKz970AEV+3gIqgn++Iy8sVNBWh2XFPvmB6BhN4RE2g+VkLJUvRjULOJcBiuFn4R3lQ+T2riaSSsuGR0Dw3uMUXrCv3SCCe4yn0WWT5u4POnowFvzvr3fgRyMHxHC8wgaGwjOIILkIUr4OXtlviw5XIgYNIr1Ktb4uFvnOSvxNaktDHCsBHKkbKe6kJigwUwwbKyUrRicBu9L+/S0py+AHwEeM2yt6C2lEPmLpcCxTTfTTHSElCDjJNGC4qBISrBBY2QeNPe4es/78qaGb07dYIAyjDKXURYN3aeV3ZgQYURkBf6NKkykM7Q2mF/EVhzG/+ruCgt0OMnKqBN3Ju1w6IV0lkSf5xw3xZVosVEDs08vCROf/3OYd/Mf4/eb8Tw7bGQFu/RJdM6DYQ5oTC1ZiiaKoJLavBDb04FhRash2szKCNxcOwd3uZMU9vpIpG7N5PHBUxZcUwkZ3O9uwoCew3vdBOeN/ppgPEFZH/VbjM2jIx2wAopus5I3UlqxXHRTlamhwWnaeciAbk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8aca0f-9bc9-4806-0a3d-08ddb8b3824e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:25:28.3412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQ3avg4+2xsPEkBSk0vUXqLEswAH8u9LqRI6CjYFQkMo1XoIGVpwEGcdDHXHAxD0a5S7IOKtcK4jPZZWInIkFCoRDxD09exnCr8qC0B+ad8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010103
X-Proofpoint-ORIG-GUID: W0IYUq9-q9UmKBCcn-Ch71L6gKFPTPX7
X-Proofpoint-GUID: W0IYUq9-q9UmKBCcn-Ch71L6gKFPTPX7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEwMSBTYWx0ZWRfX0/7zFDmXRGrI
 X6EQ1tT7L7mF9be9HTdYLEkSPdLu6tH3x+zLxJ6dfPl3hfEWI0kAmHV0R2Y9sMH2IhNRtGo5QVt
 IvWoRpjJgT80SLwuGfgVNHXFkgBKaATn+Gkj1EsjhTfAONU38f5EE3/+vfxDsVtOVkrKPt3t6DF
 tqGjX1/Ddke+T0Y17QSw8e6P6pGpvyPqHQIST1bu5mtBjYZU6igTTAI+tm83vIz9j65duqXyKFC
 lNfWq14Zr7SC3beENb8TMZ2F+QoJqSb6b/rd1u2JWVtK9ISiFvDgBdfK+PGOMDVh3FIj5XFW3Z6
 k3k/+EMRtTF2Kh1m+uanj00g0W9l1sTa2/dRreRjzDAzcmvg4M6cOTWCI5B/9zBEtsinNbyVdw1
 tYHTTJhE7AHG0xjEdBoH4FMCjsqzks+BUBIAkRx/C4WUjxCPAtFUIhGrPFNMnstwuoeBTZQe
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6863fded b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=gy99LRYsvtxog7nuP0UA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13216
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Hi Paolo, Peter, Fabiano,

This patch needs review.  CPR for vfio is broken without it.
Soft feature freeze July 15.

- Steve

On 6/10/2025 11:39 AM, Steve Sistare wrote:
> cpr-transfer breaks vfio network connectivity to and from the guest, and
> the host system log shows:
>    irq bypass consumer (token 00000000a03c32e5) registration fails: -16
> which is EBUSY.  This occurs because KVM descriptors are still open in
> the old QEMU process.  Close them.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   include/hw/vfio/vfio-device.h |  2 ++
>   include/migration/cpr.h       |  2 ++
>   include/system/kvm.h          |  1 +
>   accel/kvm/kvm-all.c           | 32 ++++++++++++++++++++++++++++++++
>   accel/stubs/kvm-stub.c        |  5 +++++
>   hw/vfio/helpers.c             | 10 ++++++++++
>   hw/vfio/vfio-stubs.c          | 13 +++++++++++++
>   migration/cpr-transfer.c      | 18 ++++++++++++++++++
>   migration/cpr.c               |  8 ++++++++
>   migration/migration.c         |  1 +
>   hw/vfio/meson.build           |  2 ++
>   11 files changed, 94 insertions(+)
>   create mode 100644 hw/vfio/vfio-stubs.c
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 4e4d0b6..6eb6f21 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -231,4 +231,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>                         DeviceState *dev, bool ram_discard);
>   int vfio_device_get_aw_bits(VFIODevice *vdev);
> +
> +void vfio_kvm_device_close(void);
>   #endif /* HW_VFIO_VFIO_COMMON_H */
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index 07858e9..d09b657 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -32,7 +32,9 @@ void cpr_state_close(void);
>   struct QIOChannel *cpr_state_ioc(void);
>   
>   bool cpr_incoming_needed(void *opaque);
> +void cpr_kvm_close(void);
>   
> +void cpr_transfer_init(void);
>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>   
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 7cc60d2..4896a3c 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -195,6 +195,7 @@ bool kvm_has_sync_mmu(void);
>   int kvm_has_vcpu_events(void);
>   int kvm_max_nested_state_length(void);
>   int kvm_has_gsi_routing(void);
> +void kvm_close(void);
>   
>   /**
>    * kvm_arm_supports_user_irq
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index a317783..3d3a557 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -515,16 +515,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>           goto err;
>       }
>   
> +    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
> +    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
> +        s->coalesced_mmio_ring = NULL;
> +    }
> +
>       ret = munmap(cpu->kvm_run, mmap_size);
>       if (ret < 0) {
>           goto err;
>       }
> +    cpu->kvm_run = NULL;
>   
>       if (cpu->kvm_dirty_gfns) {
>           ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
>           if (ret < 0) {
>               goto err;
>           }
> +        cpu->kvm_dirty_gfns = NULL;
>       }
>   
>       kvm_park_vcpu(cpu);
> @@ -608,6 +615,31 @@ err:
>       return ret;
>   }
>   
> +void kvm_close(void)
> +{
> +    CPUState *cpu;
> +
> +    if (!kvm_state || kvm_state->fd == -1) {
> +        return;
> +    }
> +
> +    CPU_FOREACH(cpu) {
> +        cpu_remove_sync(cpu);
> +        close(cpu->kvm_fd);
> +        cpu->kvm_fd = -1;
> +        close(cpu->kvm_vcpu_stats_fd);
> +        cpu->kvm_vcpu_stats_fd = -1;
> +    }
> +
> +    if (kvm_state && kvm_state->fd != -1) {
> +        close(kvm_state->vmfd);
> +        kvm_state->vmfd = -1;
> +        close(kvm_state->fd);
> +        kvm_state->fd = -1;
> +    }
> +    kvm_state = NULL;
> +}
> +
>   /*
>    * dirty pages logging control
>    */
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index ecfd763..97dacb3 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -134,3 +134,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>   {
>       return -ENOSYS;
>   }
> +
> +void kvm_close(void)
> +{
> +    return;
> +}
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index d0dbab1..af1db2f 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -117,6 +117,16 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>   int vfio_kvm_device_fd = -1;
>   #endif
>   
> +void vfio_kvm_device_close(void)
> +{
> +#ifdef CONFIG_KVM
> +    if (vfio_kvm_device_fd != -1) {
> +        close(vfio_kvm_device_fd);
> +        vfio_kvm_device_fd = -1;
> +    }
> +#endif
> +}
> +
>   int vfio_kvm_device_add_fd(int fd, Error **errp)
>   {
>   #ifdef CONFIG_KVM
> diff --git a/hw/vfio/vfio-stubs.c b/hw/vfio/vfio-stubs.c
> new file mode 100644
> index 0000000..a4c8b56
> --- /dev/null
> +++ b/hw/vfio/vfio-stubs.c
> @@ -0,0 +1,13 @@
> +/*
> + * Copyright (c) 2025 Oracle and/or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/vfio/vfio-device.h"
> +
> +void vfio_kvm_device_close(void)
> +{
> +    return;
> +}
> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
> index e1f1403..396558f 100644
> --- a/migration/cpr-transfer.c
> +++ b/migration/cpr-transfer.c
> @@ -17,6 +17,24 @@
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   
> +static int cpr_transfer_notifier(NotifierWithReturn *notifier,
> +                                 MigrationEvent *e,
> +                                 Error **errp)
> +{
> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> +        cpr_kvm_close();
> +    }
> +    return 0;
> +}
> +
> +void cpr_transfer_init(void)
> +{
> +    static NotifierWithReturn notifier;
> +
> +    migration_add_notifier_mode(&notifier, cpr_transfer_notifier,
> +                                MIG_MODE_CPR_TRANSFER);
> +}
> +
>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>   {
>       MigrationAddress *addr = channel->addr;
> diff --git a/migration/cpr.c b/migration/cpr.c
> index a50a57e..49fb0a5 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -7,12 +7,14 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "migration/cpr.h"
>   #include "migration/misc.h"
>   #include "migration/options.h"
>   #include "migration/qemu-file.h"
>   #include "migration/savevm.h"
>   #include "migration/vmstate.h"
> +#include "system/kvm.h"
>   #include "system/runstate.h"
>   #include "trace.h"
>   
> @@ -264,3 +266,9 @@ bool cpr_incoming_needed(void *opaque)
>       MigMode mode = migrate_mode();
>       return mode == MIG_MODE_CPR_TRANSFER;
>   }
> +
> +void cpr_kvm_close(void)
> +{
> +    kvm_close();
> +    vfio_kvm_device_close();
> +}
> diff --git a/migration/migration.c b/migration/migration.c
> index 4098870..8f23cff 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -337,6 +337,7 @@ void migration_object_init(void)
>   
>       ram_mig_init();
>       dirty_bitmap_mig_init();
> +    cpr_transfer_init();
>   
>       /* Initialize cpu throttle timers */
>       cpu_throttle_init();
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 73d29f9..98134a7 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -17,6 +17,8 @@ vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
>   
>   specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
>   
> +system_ss.add(when: 'CONFIG_VFIO', if_false: files('vfio-stubs.c'))
> +
>   system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>   system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>   system_ss.add(when: 'CONFIG_VFIO', if_true: files(


