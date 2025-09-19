Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D76CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 15:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzd9V-0007ev-1A; Fri, 19 Sep 2025 11:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzd9S-0007cj-GA
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:35:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzd9P-0004fT-19
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:35:57 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtwIw017757;
 Fri, 19 Sep 2025 15:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ikGFQzDtNwWhgmMmhD6XrGEYMBut06/f3trrhVocI/4=; b=
 fgsdZWQwFN6+ivotu3m64BYoIJWWOlqMB7anRxuvOUsZfbYwMG9wO/JPPfWgJPpP
 NVjRoX7sGRDpRDYycxWoWuy8bzzi8igzxpaGzchmutUIgugme6pm2YcJnpqunjRf
 k4KXc9QrNuVro+y3btCuCmozU61p12DlpH8a0BsxTY2AkXS9knkrO1rbP+MVaFzA
 1WaeQiSewuSNbbfRudcuuPSEgwtWm4wlinK7hSGCWG5TOLOV6WYM7Bn1jKB0vzsG
 16kLGXRHjCiiD7/Mv3tBOHV17Cnd3rZ/B0vsyTvhCyr8IeLhNyHutXU6G0lnDWc2
 vFT6AqzeL5VF56mrxVBbKw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9wvgx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 15:35:50 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JEiHxB033703; Fri, 19 Sep 2025 15:35:49 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gj8pc-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 15:35:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKtumhk4f1dscKkN/1s5/p+XGLzX8YYdVt168CLON5WnYpyAT66i72dk441KFhaDdsq4B+KoNIgsND6/IpZqmNrUwt+7KJOgp15UwcN+Wt88pqr4mg+LZ6kcH5Wwkm0oYp00yC55+0Gm4SVpPJ36wg4IlaU+jUJI6doRMSYrztVaRhlGGdMCx2aQdVkLFkJLnLWnNxIAt2LAwmHPGjgrsYStt9TSXBwQuaQd1v0nLaSGfu7rO1r4jbdhCDPcnpR2IjaWwI1IUmKlQnkNKc6FQNlExx9pbg9pmKf3hnGW8o/xN2p5l7b8hZnPabQ5IdAIZBFhICadg+i3brElRgPp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikGFQzDtNwWhgmMmhD6XrGEYMBut06/f3trrhVocI/4=;
 b=ZuJJMePsRxhMT5QoGZIx6+Y3UvvbOtF2+upsiMnoeukhgPzMpe1Ds1ul7MNzKuoH7z33sVdSnaB5BdfEWGEznzrMIXUkk/VMNLVhK2zJLTiDib19m6pso6oRiYihkX6mgyCLJ4jJfN+nvaTV/O4WQjcB5XZtmTJ1ptu0/jH6/mhf+AEk0MLIORcK6RGa0bX2X1bnB4itljEkbgXiMnRg6DLCGyPBNPV1M8gwLTRGuuIE3TgN9xBsjBCIaN2Gi3ICMFSGtw1Zqn3kqfSrxIuy2pL85Gubhdmk0xyoZkJm/BBXLOHvu5XXcbT71A4jiPNVM6nnKtYxen2Q5KYs2uG84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikGFQzDtNwWhgmMmhD6XrGEYMBut06/f3trrhVocI/4=;
 b=aEsicWxIPEL/W9dwQhpR9Ckil1Csu9LBZzZUnQ933wfCLgZ0+H+pdt3wBLcAIJjwTNvVKfEiMB2n+I4a+q0QSryQovhhJiTB/chwnPcpp4GxRXiEY9O4him7h7XlEWfxErWGhBDMeYtoKIgjzaAEFcNGiq+IN/XZsYdv8clS+Gg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8663.namprd10.prod.outlook.com (2603:10b6:208:571::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Fri, 19 Sep
 2025 15:35:46 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 15:35:46 +0000
Message-ID: <2bbbca7f-f9a6-4be9-831e-0d0550a18b13@oracle.com>
Date: Fri, 19 Sep 2025 11:35:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 9/9] vfio: cpr-exec mode
From: Steven Sistare <steven.sistare@oracle.com>
To: Cedric Le Goater <clg@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-10-git-send-email-steven.sistare@oracle.com>
 <92976018-2b44-4177-a26b-1f5c7a433d11@oracle.com>
Content-Language: en-US
In-Reply-To: <92976018-2b44-4177-a26b-1f5c7a433d11@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::15) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: eedf3f74-b3df-42b6-95a6-08ddf792338e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vy9Dbi9pdTViaFJqSEliNGVNUDBYU2Y0VEtKcTE1cUEzQXNJQTYveEFrNnBL?=
 =?utf-8?B?TUtsZERZd3hPb3dveVNrQURuQm9pUWp3alg3QVRuNHVpdlVPQkVFcDhZWC92?=
 =?utf-8?B?SXVRcU00SEJvT254YnJ3REx0bVVXODRyMllQOVpIbytHc0ZxUkpDR3pUc3Uw?=
 =?utf-8?B?MXFuQU1COVVWY3Z6TlVkdDZUalV1NndXTThCRTQ3Q3MxemlSZUp0V2ExcWxD?=
 =?utf-8?B?aDdiRHVodDE0MjZvbHY4MExTdk5rdlFQMWEwY3U5S1N2LzErTk0xM09RVExY?=
 =?utf-8?B?MnJ3dHFLRStjYmMwRGJHQXg3WnJpSVUzSDVNYVBoOWp2RDlkcE9YWldBTUky?=
 =?utf-8?B?L05EMDdiRTg4OG85TVd6TFhpRlBiMWZMaHZwUFJ0ditCcGxxZWJvOElVblhX?=
 =?utf-8?B?MFkwVHhFQ09sZUtRQXdXaDgvK0ZtS3o2SGJybDN5K2p6THhMWXpjS2ZZUmhB?=
 =?utf-8?B?YWpzYjhkbEduYTJ2Wk91RTBjMGFic0lWYkozSWJKbEFQUzQva0FZTjJQcWRn?=
 =?utf-8?B?Q1h2T05keUMwMyt4N0VBS3Q3L2RmRkVOZ2VuY2lhdkZ0Y2t0d2lDUEZQbzVH?=
 =?utf-8?B?MHEzb0VVRnZTTkc1QWxhQXBPZi9GZkdXMllCcktHZ0w2OEJsOFZmUTVKOUpZ?=
 =?utf-8?B?aG1tUU9VZ3grZTBiTng1bXkxSDZnK29uUmltblpsQ2l1akpma09wcitVNFE5?=
 =?utf-8?B?dUQ1Zi9EMmo4cmJwVFJ0dzhwUHA1RHZaekRPdUhKZnRNT2pOVzBtZHN4Ynlj?=
 =?utf-8?B?eW1sS2FUR3luckRvUDZCVUxnRmZrNGx0cXZ4N1ZIcmdYYjBGMU12elJ4RkM5?=
 =?utf-8?B?QVhydVY3WkVYYnRlTlpPM2RlRFZEQ3p4SVhLTmMvNG1zaFlRWkgza01uZGQy?=
 =?utf-8?B?UVA0MzBOY2FBdnMrazlGZXR4eTFGQ3E1VUVUdW9jbjNJa0V1TEZzd2huckNr?=
 =?utf-8?B?R2l2Y0xEdHhZeGx2ZjZuS0JES084c25QeU1kK1pnanVYbE85eFVuZ1RFczJV?=
 =?utf-8?B?eXJwL3UweWVwRG4zMmJWQ3lSYjlMSWlpYUh1Y1YzOTY0cmYvUzZMVDEvWkpa?=
 =?utf-8?B?eU44NERseWt6Q1U2RXZ1UldCUGR6YVNsajYyL3BIRWpGQTVBeTE2ZDUyenJJ?=
 =?utf-8?B?NHJ1TWdzV1pRVUNSb2w4S0pYeDRXSWxMcFcrUDhvMTArcGwzQUNPcjlzWUxC?=
 =?utf-8?B?NUNrTnJCK0hjYS9ncHRyb2xWWENkYStXOStYcG5XdmxIOTNBbjF4NnErYnhr?=
 =?utf-8?B?cGw4ZGVNeVY3QTBlYnNxL1dsMzZOaWhpZGZVWmJ3QU9EdUdVYWhidzBaSFVP?=
 =?utf-8?B?Ukp0MitaYjFqL1ZOWnp6OW1uMGl0SElsdEN2dFV3eU5qb3o4VHNSbCtuaXRZ?=
 =?utf-8?B?clFNTUlUeU43aE5LUXlvUWZMQmFIT3FscHhGL3o5aThEbGNYRDBLUGhyM2hv?=
 =?utf-8?B?cE5HTnN4bE1lTlgvZzhKY1RoQ2xwQXVZd0svZjk2ZGEvY2JKTHcwWCtDbVRE?=
 =?utf-8?B?R3BtWUkyeWR1ZHRRbm1mNE1OK3B6Q2Uyd21NYnBYcGFsQ0JGNi82d3RTTU5n?=
 =?utf-8?B?aFUzbTU5SElxaVVTcHpjbmkrTi9nOW5yTTFFNmFyeG8vdGNBTUd4Z01Jb0to?=
 =?utf-8?B?c3J2YitXVEJnVm8yNm9aU2JSc1ljWWtzZWY1UnYwZ2w5anVORDJLNUg0SkRQ?=
 =?utf-8?B?OW5SeGY1V3pyTGYvNm5lNzlnaTZIazVoaDJrZDJHR3prOHF5TG9vVEx1SGF3?=
 =?utf-8?B?WDlRaWRMckZxK2x1OVpGNlBvTk5EOXJ3aS9YWVFJZHlCd1VObCt0VW5QYlF5?=
 =?utf-8?B?MURyWGFCNEN2aUZISVFDb1JZdGg1Wm1kOTB4RHFCOWFOcXpQcXhSSDlWMUlE?=
 =?utf-8?B?RWYvL0gycjhGRzJ5NnBjK3c1TTZQNzVOM2JHbzdzYWpIVXJ5S3ZCUWY3SUhx?=
 =?utf-8?Q?irzvOyzoAsw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGx4OWtzKzI0eVVtekR2aUNTc0NYOXZrTWZWSVZJVktjN3hKTmo5ZnZSMXJt?=
 =?utf-8?B?MXJLL2xrSWozRU5NMEtLeDdMK0tuNW5xaHVxTHlMamdndkVxQWoxVksyREI5?=
 =?utf-8?B?THFWNEw5WEYrU2ZBcFVDRUdUNHR2WFUyc0c5ZytHZHNLY1lSWmxWTGdYZ241?=
 =?utf-8?B?UUUzaXl0ZndVRUV0cy9BUHdHczh5b3VXN01hVXZ3VWhuUzhsNVc0M21xOXVE?=
 =?utf-8?B?RCsvb1pQS29uV3U1NmVEYUhVYTNETllXUk1lbm5sMDl6cllBMmtoWVJQeFdR?=
 =?utf-8?B?TUp4ckttTFhuQkFSSEFhbWFGWkVLL2VwSCtOcDRrNkVrU0ZSem5TSktDZXJH?=
 =?utf-8?B?UU1iLzBJQ05xNnA1OGlSQUV1N3d2d01MQnJURVgyQmlQSUtmVFQ4OXF4d1JR?=
 =?utf-8?B?bGhpQWZaUUEvYnZmOFgwRVNXUkRSYWN5anQzMnhCOUVjZHp6RTB2UlRUNHRZ?=
 =?utf-8?B?Sk9mSUNMTzQrVFZIV0RVM1A0cEtPb0tHY3o1aHlUaTg3RWV5VFFnaWxnSE9X?=
 =?utf-8?B?OUVjMGJPWGcvdENFU2VPUEdaWWdwVGxKQTVESEJSTThKZFN0OXVHTktBdnlv?=
 =?utf-8?B?cG4yeEJaVWNpOGZnNXhBTndhWU1vWGozMVV4WG1Cbm9RaTdBMjBoTWN2R1Jp?=
 =?utf-8?B?WXNuRjZ3TThGSzZyWTFHbEl3Wm80ZXhvMzRlQUdyTVhBL0o2M2hDUzBWSDFY?=
 =?utf-8?B?Mm1KWjZ3VUw2Uk5TZlJUblE5M3VrOTdvVGtMZHp2RlM1TGtvREQrUTg5ajFI?=
 =?utf-8?B?aWFuVVowYVhGSXF6OTZUaHhiQlFyUmZReVpHWDBxUzBkS0kvWER4QkhWZko5?=
 =?utf-8?B?YkVFYThQWEt0aWpNSExVOFBvYVFrSHRqZEw5MmtOeXJLeG1FeStDYWZka0sr?=
 =?utf-8?B?R2lPU05PajFsdzRYeGtHK0hXcTFOL1RMSXdNK2tIdmF2bHNORWJDMFNoSmto?=
 =?utf-8?B?eEJtVmp2dlduQ2E0L05qczlVby9NeFViOElya2s3TEJRbFBNZk1DR00wM3Jy?=
 =?utf-8?B?Ly9VSnpZTGJ5Vkh0WGw3L3FyN1NLUkkzWlVPUTh2MnVTYVJjSnBHQnp4dkpz?=
 =?utf-8?B?LzY0UUs3NVFTaWV0bHhvdjVXSGZpeG9LWmluRjJNNjBrTWxqZWVNcUlpNmJi?=
 =?utf-8?B?SXMyMDIwOWpEZ1oyZ3dCN3kraFlGRUxCeGhvK21zaDNMVjAxT25LRUdFZHVk?=
 =?utf-8?B?SW8zSXdmMzJwVENFNDFkS2dvWEZ6dmEvUGVTcW9QSUFjS3V4UVNzcUd5a1Qr?=
 =?utf-8?B?cTVVMlBTWWxTVFVHNFlSREVzd0UrVnpJRXN4dU9ocUkvc0VYOGtSNEhlTVA5?=
 =?utf-8?B?ZkZTME5RVUpMajY2eHVGN1VpbXMwTnYxUTZxRURSN1pzNldwVVVrbEZZdHpM?=
 =?utf-8?B?TUh5VEFUYmhqU2w4ZDlJTndlb2toZE1rc0c0TE00MDdyVXlXVHUvV3oxWTRQ?=
 =?utf-8?B?emlCKzNlTzBGRWZJTy90Y2gxMStHMzgwd2l2SHN6cWQrZC90UzFZOW5yT0w2?=
 =?utf-8?B?NXFJaFRBbDkrWXUrb3NrUW1tZWR5L2hZRDJLQ2NMVDZONEwyMkp1bzl0b0pY?=
 =?utf-8?B?ZUEybE9BUmQwajZOMkxpTGhXRkZtYnk0ZFpMRjM5OEpZeExlMkt6bTRkZkVO?=
 =?utf-8?B?VytXK0ZsMGc0ZzZsWTlzMXppTDFpRDlrMzVkU2Fxc1VONEFiRDEyTU5vZVE5?=
 =?utf-8?B?MjN2WUI1clIxZTB2UU9wR2NjSUdJbE9XclI5a3kvVVlTZTN1WUdESUh2ZXBO?=
 =?utf-8?B?UDhuZU9YeURMaGhERWxPbHJ5Wk5rNWlXMnZQWVZNUzlWT05LdnpndnRqUXFX?=
 =?utf-8?B?ZEx2ak1IRlQ0U2dqYXVqcXROaVdQMjJmQU9KUFZzYlFva084aHI4T1RwYnBJ?=
 =?utf-8?B?TlhmUjJCZUNwejFDUjBZRU0zY2RVNXBXZm5TZWVwQ3JDUmh1dTNGaVhjQWxB?=
 =?utf-8?B?eGJHaHlmaHplem5ZTkVvUUlPbm1MSXovTytZUElGQU5QWnoyL3dISUQ2RlQz?=
 =?utf-8?B?SzRjVzJuK0lDeCt0ZVdtYjJob0liSW5ENzBTekUrQ0hpUlJyTTQzT1RLdEJs?=
 =?utf-8?B?OWE5dTg3OFFvVGhSMDZMSzM2Lzlwc0t6czJUYUJDVENZdVFzazl1b0JtZ3dM?=
 =?utf-8?B?Vy9yMFFQNElkV2EyaHRIdm11UVJkRmFEcTRKL1dZRXgzeHVreVM0OGp2a3Q0?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ixt0XhTRADUFCSxNLQpv2nFSPe944l6AmrVdbjYQGotPFJxvYKndHT2HSsHCmcFt+P6MsfHIR7T0LfPIhsxIuVbSyor+5xhl2FJ7Gj53ntGhgSyLiyftSbwoutn0+jGLfpkrUcrglqQl6/qjkcZhMKjzM1pfj0tJysin85xj3+F2OyEo2bTbgDLphuDHSC23TjUjOwJ75sI90ND8WZyTjSZhxWdBOG/HPT50RDkvQEqP3HRG/AMx96Hnxlq3ASgeQQu7a/SQO44nIrWtKvlMVjBUTfiUc2wjO8jvReN/FCPBbJl98NCEBXe3T2UUF4DW1QFCCmndSi/wFK4GJRu1pSD547oLTbpahDxOUcEovpev9MDTVC1qasA64zPXtC2dJvLRZ5dr2CePV3bcm31pqf4+WMvefaHCYDLiW9brQfoVyxPfXQStv5nVVZTWLz0aEC9sJkjsOfboGPD6v3m7Ik/WlOFpPSXdU1Nrq1GK06Octbng7Ikdm7DqBFRok3z1nUoOMcyWWCrkY3t8wvnxgb3SZdhtw17wYT6RaVqRPeodi4aAZU6ze5a8zWjPQronOOW08pzDnpMAFeONW263z/THSVtCSjHjIUDHEaLz6nw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedf3f74-b3df-42b6-95a6-08ddf792338e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:35:46.1142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnYIprRUIQpOUWU+fFtt3bzbzhVP/59LhS2p4XufNyrjEAzHTJyHlK/cre7ACTU6uhsNOQi3hDEd5m1qifNGxaxcwmBk3o4bprLviHFWVIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190146
X-Proofpoint-ORIG-GUID: 46RLEUKqctAmfAvSz5oJhZyqZUyK83VR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzVQDrF/GlKhy
 kfi9PZrtWWsiXGYiEtqUdfNNjwnfeZD3oLYqXQUnN4saYRVr/2gvxkXh0qYal3Fkp+daMqQPKIu
 OYBPKXWTgOsUbHSKcRBMTMONuAiRpbGDBDkNgsJQA59/hmwzsJq5MEDGN2dynDAbmdprbLsoqm6
 6CPdKfUBUIfdil6ajbhsjD9pYI0rMPjIpQwt8RuBvyMdzJOfvZ2VyyOaBLUdRzhbV6xvU8vGF9m
 /SxzsQJV7PBwiOZOAEmI/hn0DmF/YLvC+dGdQIhiPDb4YuOlMzIDNt1tajuSvp3LywrWY4FHaWG
 qdACFt9BOAgxYBMiuamz0q1FC9l6WucOOKyWsfVbG3MS/Oyii7GygPGzTfrgC3Zqonr6wN0FP4I
 1ZVS7AJQ
X-Proofpoint-GUID: 46RLEUKqctAmfAvSz5oJhZyqZUyK83VR
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cd7856 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=8yIWoEfZ2jeGwa0seNEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This still needs review - steve

On 8/14/2025 1:20 PM, Steven Sistare wrote:
> cc Cedric and Alex.
> 
> This is the only patch of the series "Live update: cpr-exec" that touches vfio.
> 
> - Steve
> 
> On 8/14/2025 1:17 PM, Steve Sistare wrote:
>> All blockers and notifiers for cpr-transfer mode also apply to cpr-exec.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/container.c   |  3 ++-
>>   hw/vfio/cpr-iommufd.c |  3 ++-
>>   hw/vfio/cpr-legacy.c  |  9 +++++----
>>   hw/vfio/cpr.c         | 13 +++++++------
>>   4 files changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 3e13fea..735b769 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -993,7 +993,8 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>>           error_setg(&vbasedev->cpr.mdev_blocker,
>>                      "CPR does not support vfio mdev %s", vbasedev->name);
>>           if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
>> -                                      MIG_MODE_CPR_TRANSFER, -1) < 0) {
>> +                                      MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
>> +                                      -1) < 0) {
>>               goto hiod_unref_exit;
>>           }
>>       }
>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>> index 148a06d..e1f1854 100644
>> --- a/hw/vfio/cpr-iommufd.c
>> +++ b/hw/vfio/cpr-iommufd.c
>> @@ -159,7 +159,8 @@ bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
>>       if (!vfio_cpr_supported(be, cpr_blocker)) {
>>           return migrate_add_blocker_modes(cpr_blocker, errp,
>> -                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>> +                                         MIG_MODE_CPR_TRANSFER,
>> +                                         MIG_MODE_CPR_EXEC, -1) == 0;
>>       }
>>       vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index 553b203..7c73439 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -176,16 +176,17 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>       if (!vfio_cpr_supported(container, cpr_blocker)) {
>>           return migrate_add_blocker_modes(cpr_blocker, errp,
>> -                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>> +                                         MIG_MODE_CPR_TRANSFER,
>> +                                         MIG_MODE_CPR_EXEC, -1) == 0;
>>       }
>>       vfio_cpr_add_kvm_notifier();
>>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>> -    migration_add_notifier_mode(&container->cpr.transfer_notifier,
>> -                                vfio_cpr_fail_notifier,
>> -                                MIG_MODE_CPR_TRANSFER);
>> +    migration_add_notifier_modes(&container->cpr.transfer_notifier,
>> +                                 vfio_cpr_fail_notifier,
>> +                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
>>       return true;
>>   }
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index a831243..a176971 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -195,9 +195,10 @@ static int vfio_cpr_kvm_close_notifier(NotifierWithReturn *notifier,
>>   void vfio_cpr_add_kvm_notifier(void)
>>   {
>>       if (!kvm_close_notifier.notify) {
>> -        migration_add_notifier_mode(&kvm_close_notifier,
>> -                                    vfio_cpr_kvm_close_notifier,
>> -                                    MIG_MODE_CPR_TRANSFER);
>> +        migration_add_notifier_modes(&kvm_close_notifier,
>> +                                     vfio_cpr_kvm_close_notifier,
>> +                                     MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
>> +                                     -1);
>>       }
>>   }
>> @@ -282,9 +283,9 @@ static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
>>   void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
>>   {
>> -    migration_add_notifier_mode(&vdev->cpr.transfer_notifier,
>> -                                vfio_cpr_pci_notifier,
>> -                                MIG_MODE_CPR_TRANSFER);
>> +    migration_add_notifier_modes(&vdev->cpr.transfer_notifier,
>> +                                 vfio_cpr_pci_notifier,
>> +                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
>>   }
>>   void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)
> 


