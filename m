Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33020106FD61
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 00:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0qWM-0008C9-RC; Thu, 12 Mar 2026 20:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w0qWK-0008Bp-8D
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 20:36:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w0qWG-0006Rj-OZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 20:36:51 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62CLIsoN2023004; Fri, 13 Mar 2026 00:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=KPjWKGVNLl5zEjPKfE6bduHjp2pCASuYDa/+fJDl0gU=; b=
 sPyJ4OIwTz6F2rhZD4O43ucwk5e8dMi0vd6WpBZ0w9irdTJkehYcahFJip1wkgCk
 wRi0WtBhOBqKT/gijdtuJaVRK5VwTh0msZcEfFv2sd80G5iutlnxlRLqCsJfWXuA
 suWqH0DNoPftQFzuvO2Qwqm8zdhgAa08iXRZ0c1h33k1c3/Tio04J2BJ8fcKXy1C
 92YWLkxSM7M/C+ePLGFezXBjIIfn07sSZ/0Y8+tdwnCXNhUFNIP5TqrHqP4b4VE1
 4p8OAqA8ijnklGAJBDtGH51CbRMO5xglM6jaXyxCpdjstSNJqpVWF9ULYuqDnk6s
 bfyi9LEFCqDOLhfrHYwXJw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cuh4kj2hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 00:36:35 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62CMDLiH002002; Fri, 13 Mar 2026 00:36:34 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4cuh5u9s07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 00:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ew2vun4gEIFwGScR4R5VvubzPs8/lUvyaNRPZoK4EZdTO1g/x9GpTQQF7tC2A6YsABsAYmjNVtVvOC9yQZKeXANe2QrVcdjkDFfz7srB1ua/YR0DNWA+Qd4+RzCUSod7MnOWUbHupLn6r86J4YTmWEVGF8bYPT83PW89AC/aXoo++7G2DideyyDZePTw37ei2Sx/4UYgsqPBBg36mDUn+PLryHrZA4mdAflswtk441OluswJJksHcj5jTvyI3RRWV1Ni+Z07EKac+b0iEO15synR2H6XC2Gme66OzIQmv5fu7Wq6+hbHXI3wPwld93AhWvPYV902Hk4+L9wnLKkH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPjWKGVNLl5zEjPKfE6bduHjp2pCASuYDa/+fJDl0gU=;
 b=rOFk1SqwNEA1T767mGwbfjvDM/HcL7InDA1vx0dohflBM6QrtD0LQSEB+qSxxP0HSfDS/I5TJ7+V5Lh+WK6EyUKuPbcPpACCH3IuqcGrJkw4ObR8lSigPG6I892r3poCdYqCiG9wXee2yR8oyWylGnFkgN1cVVnocCiITpJnH8hEnlfJHbZMfrev1RiuTs5WjOOpbk38WOuamddC/Fp8p1+xxmpztyqVW/BCGWe0OeyB6T7w2KwYRFQj86uxiqVffRkeJmjMxzACK1WoQ0A4TNKPvtPDgWk0hGtL11vOkLCQfyoXPpXc3cOatqmtntdv8q9dd8zwCZAEEfrcpHMUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPjWKGVNLl5zEjPKfE6bduHjp2pCASuYDa/+fJDl0gU=;
 b=DEiQDsjLT0oxCrSxzlD+wyCsMNuJhDMn66j5NTx7fvZ/X4MrlIsXD/7lVtn2QHJ8iBDKVPCHft84bGcNEOPQ5EjIcPX69d6lOJE1xHGrNW3EqHz06osRt1GvJ04JQrGndzIoLNKSTEBMGJ+gSExGHzRaIDDbsvX2gerzeOJfBvY=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SA2PR10MB4555.namprd10.prod.outlook.com (2603:10b6:806:115::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 00:36:31 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.9700.013; Fri, 13 Mar 2026
 00:36:31 +0000
Message-ID: <6578a71e-dcd1-4a3e-8c6e-f86ee9095392@oracle.com>
Date: Thu, 12 Mar 2026 20:36:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] amd_iommu: Use switch case to determine mmio
 register name
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, vasant.hegde@amd.com,
 clement.mathieu--drif@eviden.com
References: <20260302115130.5903-1-sarunkod@amd.com>
 <20260302115130.5903-2-sarunkod@amd.com>
 <913090df-f03b-4b56-837e-cff31c617a58@oracle.com>
Content-Language: en-US
In-Reply-To: <913090df-f03b-4b56-837e-cff31c617a58@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:930:1e::7) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SA2PR10MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a6bfee-325b-404a-1205-08de80989288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WC8Uw9ImLlmkdY6o1SgDE/uhT/rCwFtoS0ZU5VYNJ8XnTSPJbllNww9RjwIMjAKiXkHQnhynQaTxm9Ayzo+LV/9twjH+UkRSHFT33Dvyv+wKLwf81ivHeW/l357ObRl/87ayUSef8CrdAFxvP15aZT5DNg8LAFheR3h5He3Li41JQkb/U4NIvb6W1oMJ/w09bJ8QgBHciT/00TxlsEoF3V6mTNL/ajgyvSIP2iN30F2GWySoSnh+ohFCf7GNvHow1Jvy8+St9zgI0NmdrR3idp9n8Ak1bSH7/5bYGIGx2zBBBQSfIw+jlb/5Jp0eYrO7KTnvldhQYJ9+q0+jbzpfZvpFG9Zo1E0WccppaEeFJaowbuNmSennfngyOJzkXqGQU1RMG/eQkPTARQpFVqt9zwNvult6VMCG7KPfraZoG4gRd7ue3RdP8wjHJdWGG9wkUNB0UmOZmxjXxt4x78PNkkQozopKGW2MakbHUbd/EFXmosWHoGwxclvvLAZEzrEPjPIEslukMkuByMCWPlngPnBlgB868ISJii9dLRSGKP4d7dKmnVU5yzqrUZf5Xi++VT1D0k3EapcdDfF7C+NwZprMOcBXuSpxvk+g6rUa5SfgALmXA+2EsbHgy7+jI7ASDmmDEzLOoonVtiSDIuZnNSemvM4ZSG5R8gegxKFQbayt5r1fcZx3oiKYNInCWxx0FjvajjewtAbVEqSPnD2e3/yqxenhfkiHd4fdCiDSjyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmM2V0hxK3pHTUZObmU5ZUVZZHZXdUpRUW5zbDVYZVljNGNBcWdTb1psTWVI?=
 =?utf-8?B?azljVnM2RkFFajhlVW9uOWpDVDRRM3Eyc0pHL3ZlcGd1R3dEaDNIdGRDMXFM?=
 =?utf-8?B?NDNNUHZ3UnZXUk45SlJ2MzB6bTFPZE5ZUUpQQlpubnc3TWRPS2NBaWpOYlhn?=
 =?utf-8?B?bTM0M3RQSTV6T0ErSFNRRm9VZlBFT3dsYStxYUcyTGIvOElaYVJUQW9xRVk5?=
 =?utf-8?B?THREbzVHQzh6L21YQXExaDd1OWYzOE5CUWF3VTBnWm5tRG0xWFhVb2ZwMUhR?=
 =?utf-8?B?ejFDSDRFQktlTFQvVDlvVVdTUnNVUnVpVTlnbjlDemNxM1NIV0psZnAvRkxV?=
 =?utf-8?B?YW9FR1h6VXhLSUlhMTNMREcvYVhpaGVjcGtsclg4d3pmZ3ptSG1rQWE1V1dU?=
 =?utf-8?B?REZFWERWQlVnOHFPRmhZQ3padnJBQ1dHM1FUU0tXbU5jRHJCVjVacFAxZUF3?=
 =?utf-8?B?K2FqWk1oQlg0b0JxME91M09PNlIrc0g2SXJrM3NHWXpWYXBMdkNMdDdxN3Q4?=
 =?utf-8?B?cUN3TFRCN3M0WXRMbUZpTDdtZG1hUktZSlo1UE1ZMGw1bUdQaWV6YmNzVEFT?=
 =?utf-8?B?YzhGSUNOY3lTOUtZdjQrRjhTUnVHZDVJeGJoSEZVZ0VPZzJ0UEdSU1lOTnZD?=
 =?utf-8?B?VzFyUGFWUDJwT3NCWkt2aVpDVjAvQytOUWVXVUxDdnF6TXBUSUdQNDMwU0VB?=
 =?utf-8?B?RXJsaGk2ZHVjVE1SaVBCTVVNL0ZnYkFvV3MzUVRGMnpnUjZ1NTBtQkxkc0E0?=
 =?utf-8?B?OXU4QUowWTZFQkhLclVnYXcyK2xEbHlWK255Z1lkajhuQ083TzBiS0lUYVRv?=
 =?utf-8?B?bVBaNlFrN0lEUURFZERnNGI3S2dpSjFSN0EwMDZTUU5NR0RzeUl3VUwyRlBL?=
 =?utf-8?B?MVQ0bVBEMHhPdkRXWTg2blRCVVd1dlhGdHhhdlVvaWdKdllTa21yMHQ1L3Ni?=
 =?utf-8?B?RWZjZTZrandFMXJQSU1uVlRmKzNGWEl1U0J2a1RRTzgxaEx5KzBxT0REWVZO?=
 =?utf-8?B?b043TXBwK3A4RkZXVU9WSk8wMHZHeWYvamp6NUJSb1B0Q3RONGpTUC9OTDY4?=
 =?utf-8?B?N0Q1NGs0RG5UMnpQMW9sTmR4WnM5bXErOG9IVllTc0hSa3FSaDcvSkNXUTM3?=
 =?utf-8?B?eGJUNHM3WlZwaUx5V25EMVErSlZhaXB0U1ZUaE9ZcHBIb0YvZUhTbnpGS0tv?=
 =?utf-8?B?NUVmTVRWL1ExalRNRnNtWnZnT3JiSERBY2ZtaHkrMFNDUmxZTWZLaDZJc1V1?=
 =?utf-8?B?cFI3MjYxRjZnVkFwVGJKbi9weTNZMVdHY04xL2F6NjdXVVNBTUg0TWxYZlpj?=
 =?utf-8?B?bzk2cjN0WVRRNExBSVc3NXVrV3RRc3JUWjdkcnIxL1VGZHYzYXhqQWdaOG44?=
 =?utf-8?B?MUpaUThaVHJZWUhuQWM2NmY1anJMN1FzSUY1RVR6cW1Id2h2dFpnT3poQzZs?=
 =?utf-8?B?bXRQWDFkSW5NZjRkdmV6RmdOUTRxR1pvWUhMQm1ZWEhWekgrOU5nYzJ6VitQ?=
 =?utf-8?B?aTZybCtlQnd1aTdMbXcwU3lPcFZMTENZanFUbU5Tc2xhamQ3N0pLSldjR3pj?=
 =?utf-8?B?WmVFTEFNTmNWWGp5UXl6ZWRTZTBCTmZuQVEwVVBzM05qV283ditESzRJQVJC?=
 =?utf-8?B?KzJ3NTR1QU5wV1E0eUpoZ3ZvTGZrYzdvZVplTzZqaWR1L1Z2dzQ1THBhdERN?=
 =?utf-8?B?dzRjMUZjdTVwNVZrNiszRjJldUd5SnB0bjB2VldnNFd1aG80MUEwOHhYVlpx?=
 =?utf-8?B?UW5JSGdNUmJwMWNkMlZHVGYrU2hMMzlYK1gxeTFVYlNYVnNpWU0xNGhLSjJO?=
 =?utf-8?B?RTlDZWh3czVXUk4vdUVwQlVQQTltVElOcHdMcjNFSFBORVh3N2J1YWhkdjFE?=
 =?utf-8?B?K3hTUDZHQW94Wi9yaGdXb1I0QlJKMUgxUFVjMWN2a3NnOFoxZDFzZm9wemlk?=
 =?utf-8?B?WnVEUlhkWXdSd3lmeFlFdmtRQnpHdXE1VUV3WWVoSTJvdnM2VDJnd1MzVDFZ?=
 =?utf-8?B?T3RCUk9kcHUyclVjbktrd0lGek5RSVJKRXllVitsb1ArZGtyYVRwWmorQ1V0?=
 =?utf-8?B?QTEzZjFRNmhGME4wK0dGdUwxRFdHV3I1ODlvai9pQnJYM1JNd3lHOTc1amdT?=
 =?utf-8?B?c1pDY1pNUkZhbVIxS3MvRm5STzhSNkY4QlV2b0J1bEpFSHMzU3NqejNpOFA2?=
 =?utf-8?B?SzN1MjJ2T3MyeUU5aDZGY2xodU4zUFZwb1ZHT1ZXOXQ3WDd5VFl3T290cHZK?=
 =?utf-8?B?NXFHQnNOcUo2TzZlbjg5b3p2OXlKa25NUThDT0N0TnBGNzIrdlQxcngyVTlr?=
 =?utf-8?B?enVZdkxmL1VTakp0K045cVAxRDNkN3pQVzh4Q2NXS0hJOHMwVmdBcU5PQjdT?=
 =?utf-8?Q?0YT+dds3/vHMD8l4=3D?=
X-Exchange-RoutingPolicyChecked: cJuUn1ixXX34K7PYaNEplR4XnyAM8tVJDo56iEVWaF9eEKk/Y1NWoUtb6DyltRrXB4dXneRp0sXEmVHUcq1go/N6abVK++OnR/ImBWJvURixkbDP9hV5i39gW8f/CIbno7y13WXnZeYfoUZksSrBnmkRkcwShbXgF0+cTrgRVF/vZ40icnW+U9lSKUtc12dzTC2ssKEtVbD9W+YLcTTkrwYdk67XnT7M/WoTwcUDT5rtjeeh4RgkX394wDVwCzGCXNLk1ak3JCaB6O7tUSL42ynYyJry6H+eMWNTLmsR60ymnOLXVgEb6LBu2pXbDrUVX6wVDttoSaYnb02e6/DlBw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J3LodjkiYglUs/smylMyNYolnqRSDzlpmMQLiizHhHaYMDyuvJ4/u3o9/PS+eWGLdjX/zsvr+vnkkHE99/cd8OHf4kEPF2CWRl18cgAz3WL6P+PmuhWIrixQvf5IcHyyMVH96XoYO1n7uI1hNh6yCkEwIekfYSPKdbRCRM8H+Bchl9ktsLMa6RY+IklPGzoY7K8TPGFK23wsyNBygPaThq6ABOzqHS668vdoTwdLQCgn3aRm20GJwbDbelnGkwb6MgdL2+gqGhDgLu+AhDDHnVWgm1/3zXM9fO08yVyaw/ULvdX0YrYsf0t/wFG2sH2jJyZgKGqasLV4zwv5T2lyB1DZOK9pcwSFGXyCmZwQzEAvsl3wzdU55SF9IbD45D6ika5MV8VnHuncbUe8RbGaYAC6+oEWfN0YBs9vBKHM6Oz4YtN5iJpWXtEN9kauh9O7L7Wv2eEopwSSONn8C1XATUVn6Pz6kZgO+iZNd9wC2z6t5axcnm2mSznOqhdk5/lathgympR+eWoN0WLswxgqzSHv0MhApXL7BhYbQc6+GN3pfNeyyWsTSHzQunKRpVIdEVypysR53m5ftW2swPI+9ooG6cl2OzuQydwr33QwIlo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a6bfee-325b-404a-1205-08de80989288
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 00:36:31.6895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TetE4r8Ybw2Z+JPwBq6nQcdvYU7OLTy8nhkJfTeBl0W71IK9ncQwqEP8QH7X8Vp8BHszFtvcwzrSO2DjWLhgfjOuirJKeN5YVjXAyvXCUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603130003
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDAwMyBTYWx0ZWRfX39Fjq6hCD0Ok
 BeXq5jwr5lZz2PbvOmAE75sQApYNRV+ON76ALqPCLjpdCKfNYf5ITiV0UnXkSaanxX/uxULE63N
 Ps3cO39vGXUeUt99wBjf2/UPvYoPYTVnqeTqG4J7x3je2u9o7js340Yr22AHpJqO3YNGdJ3XkZY
 ySF5S4oAFe+xnV6ISZPl2TOKYkgMuH14vLT1SNxrN1fj/wuHz2Q9UBiJAfErYTb67JIOMiIfLte
 dd0CFJFAXe2BbwVADqHsYbrn0+YtTHHPGS7aZvNRtThJDBmPhRdj76LX7Rga2bQqsB+IKsSUU6t
 LhjOVAnBalCctAKU+5gdfU9uAdIQ/s1I+p7cvQgrZC6AyGSWzh4t7MafMIddsPb8UtLUxL6+V5u
 8EdsUTCXlOaZopRBOKYHrjlckEhwrU6hcW7SjBKmsLJPh64ngNrY1R3Px8dn4X/uB2C3GNM+3NE
 hNMW9mcyRFwIGUAcE5gDOh19E9Mea4wylJxt9rEQ=
X-Proofpoint-GUID: n1WB0pt86mhon3b_HUEwnUVTa-8vpDHX
X-Proofpoint-ORIG-GUID: n1WB0pt86mhon3b_HUEwnUVTa-8vpDHX
X-Authority-Analysis: v=2.4 cv=Ob2VzxTY c=1 sm=1 tr=0 ts=69b35c13 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=zd2uoN0lAAAA:8
 a=yPCof4ZbAAAA:8 a=oH6mpLotDHutegNendMA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12271
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/12/26 5:59 PM, Alejandro Jimenez wrote:
> Hi Sairaj,
> 
> On 3/2/26 6:51 AM, Sairaj Kodilkar wrote:
>> This makes it easier to add new MMIO registers for tracing and removes
>> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>  hw/i386/amd_iommu.c | 76 ++++++++++++++++-----------------------------
>>  hw/i386/amd_iommu.h |  4 ---
>>  2 files changed, 27 insertions(+), 53 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 789e09d6f2bc..f5aa9c763d02 100644
> 
> [...]
> 
>> -
>> -static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
>> -{
>> -    uint8_t index = amdvi_mmio_get_index(addr);
>> -    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
>> -}
>> -
>> -static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
>> -{
>> -    uint8_t index = amdvi_mmio_get_index(addr);
>> -    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
>> -                           addr & ~0x07);
>>  }
>>  
>>  static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
>> @@ -1528,7 +1505,7 @@ static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
>>      } else if (size == 8) {
>>          val = amdvi_readq(s, addr);
>>      }
>> -    amdvi_mmio_trace_read(addr, size);
>> +    trace_amdvi_mmio_read(amdvi_mmio_get_name(addr), addr, size, addr & ~0x07);
>>  
>>      return val;
>>  }
>> @@ -1684,7 +1661,8 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>>          return;
>>      }
>>  
>> -    amdvi_mmio_trace_write(addr, size, val);
>> +    trace_amdvi_mmio_write(amdvi_mmio_get_name(addr), addr, size, val, offset);
>> +
> 
> There is a small change in the trace output here from the previous patches,
> and it is because the use of offset in the last argument vs the previous
> patches which still use (addr & ~0x07).
> My understanding is that the offset the trace uses is the MMIO offset
> (which gives a mapping between the name of the register we print and its
> offset in the MMIO space).
> 
> The offset variable that amdvi_mmio_write() calculates earlier is the byte
> offset within the MMIO register, and it is needed for those special cases
> (i.e. hacks) where a guest driver does not write with a full 64-bit write
> to the register, so that we need to delay the side effect until the MMIO
> register has been fully updated. That is my understanding of the code that
> does:
> 
> 1709         if (offset || (size == 8)) {
> 
> 1710             amdvi_handle_devtab_write(s);
> 
> 1711         }
> 
> 
> i.e. don't apply the architectural side effects unless we write to the full
> 64-bit register at once, or offset is not zero. This last condition meaning
> we do word writes, and write to the high word last i.e. offset !=0.
> 
To clarify because I made a mistake above and this is confusing enough:

I should have written dword (i.e. 32-bits) instead of word. So the hack is
accounting for two 32-bit writes, first to low and then to higher 32bits of
these registers mapped to the MMIO space. We should probably guard against
more finely grained accesses, since IIUC the spec says byte accesses are
possible... but that is a different can of worms.

Hopefully less confusing that before...
Alejandro

> So in short, I will fix the call to trace_amdvi_mmio_write() to continue to
> use (addr & ~0x07), and will also change the switch condition in
> amdvi_mmio_get_name() to use the same.
> No need to send another revision, but I just wanted to highlight the
> difference so you are aware of the change.
> 
> Thank you,
> Alejandro
> 
> 
>>      switch (addr & ~0x07) {
>>      case AMDVI_MMIO_CONTROL:
>>          amdvi_mmio_reg_write(s, size, val, addr);
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index 302ccca5121f..ca4ff9fffee3 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -45,10 +45,6 @@
>>  #define AMDVI_CAPAB_FLAG_IOTLBSUP     (1 << 24)
>>  #define AMDVI_CAPAB_INIT_TYPE         (3 << 16)
>>  
>> -/* No. of used MMIO registers */
>> -#define AMDVI_MMIO_REGS_HIGH  7
>> -#define AMDVI_MMIO_REGS_LOW   8
>> -
>>  /* MMIO registers */
>>  #define AMDVI_MMIO_DEVICE_TABLE       0x0000
>>  #define AMDVI_MMIO_COMMAND_BASE       0x0008
> 
> 


