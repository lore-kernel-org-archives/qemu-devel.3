Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E99CC25B7A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 18:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s97mP-0007Bl-CP; Mon, 20 May 2024 14:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s97mI-000796-Vs
 for qemu-devel@nongnu.org; Mon, 20 May 2024 14:30:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s97mC-0002nx-Iv
 for qemu-devel@nongnu.org; Mon, 20 May 2024 14:30:30 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44KFdCvK018605; Mon, 20 May 2024 18:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=L8Jn2/qwd5RqS5mrrY4+aOpwPsa1GG84vptRmkxP7W8=;
 b=Hq+Y74+ddm00NBIh8bxdWF3WLdqY3U+QKjfupouLD2TI9y/7dJDImwlU+Bs5QLUbFaLL
 FxnxJUpG32icgOo+FU3L1d9EHMGJXTVpprrclBRz/hH4PXbkse7VYOZFuezBe/1A5OxW
 faCsVS1ZvS9RtNJw2TZB4RGY5gMR6epYt77xDbdfdh3Go5je25r9EQsxdX7tzCaeCLEa
 zZTxA6F9ki6atlSz/NQ2NQeG5d16R8OY/UHAhGXeKXu8zCr3VhptXPybf1tt0BOq/BU+
 1FkwqQXTE5aa8x7Epgw6nWF/ETsqyAyibuXTV1fixOpncP2xGo7cdphMu5Gu75Z+ukdB 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jrekahp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 May 2024 18:30:19 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44KIKMrD013839; Mon, 20 May 2024 18:30:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3y6js64qux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 May 2024 18:30:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAcBU+FSM9gKTqeSaYSxw3RP0XEKslN3VVad3iRVcIkOccjBDmHJMwgI13rmA+cTnl9D+YglZXm16LQUBix/8g9Epn0CK+qT0qoc6uRRgBNnqFNaY17aGa+fcDUEHsMtEgAWw7HBP1gYnSAmxiyf+qsYVKZaKrAyxkWfyUiYuw5U/IpOPlRxYYDatboJ6Edu00wKMEFOenNxlaJA1KxsM2vSzSjcJOhomgS0OqofgjshocMGfCmVWxjmsKMK51O6xUmKuuHyECXLi0K/W5QWc/WohDO5SoT/z3veA5DP3X0oxMxss8wWOuHnKzCc3YRWZV5XeVjUquLJ0MBiPi6nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8Jn2/qwd5RqS5mrrY4+aOpwPsa1GG84vptRmkxP7W8=;
 b=RuA4uOwLNzkzp0GzU47/w/ce9ri2Y5oTMrg93JqidcKkTxzTgFduVDMxwIRygyt5Dyh9AwZksIjW9gXz9K/wtA4rLTn3E7ylleGSrjXSYqnYV10e29AQYfDiraElVrhjKtZFJCl2kH2GChPaLxApo36FFVZjpjj2OxxhOX7CAEFmA0ZZKnkm+5vtLeNbGC0bWCdr8mfM6AStJLDPWi+b16mI9xDUa3lTJ/HiDBTy0s9ZpGUsfIzPsAoBP1d6fHMm/Sl3f7W6tmG2Yw70RYNhXctDKcnazcqiyiB9lOzxbbQGi9t9JXWQXyh5OjgHdur8QWW7Xrv8dpZVHWAiADKmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Jn2/qwd5RqS5mrrY4+aOpwPsa1GG84vptRmkxP7W8=;
 b=CxqkfJS4G+prTKQJ1K9bROs9Cq/l7AyKxVBMADBYNT72a/+pdHJ/wya6vlwjFfAYQXqwJ808ipIp3XmhzGkSA6jEEgsvmdQeWErfU6yOkPQrMSHk/vYbVRPjAV6SmhxN5rBjBifc8FCJkOombl1GqC+ic+y9m39tLSPVvuvJX+A=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS0PR10MB6077.namprd10.prod.outlook.com (2603:10b6:8:cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 18:30:15 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 18:30:15 +0000
Message-ID: <cf8e13ae-cac6-4a8a-82a2-92b63a32b7b8@oracle.com>
Date: Mon, 20 May 2024 14:30:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 00/26] Live update: cpr-exec
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0245.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::10) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS0PR10MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f2560b-e946-4bbf-08ba-08dc78fae48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2lHZGtMRU5lWHZ0TmRCUHJrc3lOUzhOWTYyRFhFeHcyZXZxd1cvV0tmQkQ1?=
 =?utf-8?B?dkhwOEg2OU5VL2IrTFloQ2ZYeFpsUjlvRjNvRVhleHpxVkxXN2hSdWdFSnZa?=
 =?utf-8?B?eGNXdnFNcGdBdVFickxEc1VNWlJkVXZhRnhFbXNEVHZUSVJLRG9neEpZaWdh?=
 =?utf-8?B?U0wrUnJ4cUtNSkk4OExZSEs1eDRGZEVJN3ZMbmhnTXNWbFM2V0Ewc0NlYkUv?=
 =?utf-8?B?MzJDTkI0bk5OYXJScm03MWtjb2xwcXZWbzJNWTN1Q1pneHA4UzRFY1UzM24z?=
 =?utf-8?B?R2FvS3liY2drZHhaU2RxNHFrM1FURjVaa1ZWN05nWXRNa0JFS3hCR3R2MUR5?=
 =?utf-8?B?MDh4SW5EcmFJZjhyZ3NYcEJvOXplSytETDlwRWU3R2htMEhBZDB2Y29OR1hQ?=
 =?utf-8?B?bnQ0bmlma01aSm9ncER5NFJpcFNBL01uamlNNjVEY0J5bmtUZFlkdnVML1R1?=
 =?utf-8?B?SXhrd3gvVWJyd3A4eUtUYSt1aWJNRHN2TnA1dkQ4V0UvSkM1cWZ1ZEp1cFU2?=
 =?utf-8?B?cC8vTDBwVXJ3TTFKcTZWM0hUOG4zTjgvUkJsNkRobm5NT25FYTlGRStpcHpF?=
 =?utf-8?B?aWhHNit6VWdIcnNzYkxzaVYvcnZLMlRsQ3JDLzlCcEZ0RllMNkNGeFplSFQr?=
 =?utf-8?B?TG9WRlNRSkYrbDFIQ2luQjFRUG5RdGl1TEtUSmt4eXFyNHlISG51cm40bnlB?=
 =?utf-8?B?a05xaWd5YzJtWURTaXdKY21rL09iM2h0UWs0cDBRK1VtNUV5enFKaUNMeG1w?=
 =?utf-8?B?R3ZQdytJNnBNczMxOFNIM09SMmwyZ0dGSjZKSUNUc2NDSytWSVppVHF1bXNt?=
 =?utf-8?B?N3pZRkkxbWQyUHhrcWZ6OWFQa2NvdFh5emlCTnFCaVJQQjN3VzhGSjRzZjl4?=
 =?utf-8?B?Q1huQnRNbERUZ0dhaW16SDdFdUh1WXJ5YkJmT1ZzOVd4N0h1aUVGKzdWUUZ1?=
 =?utf-8?B?MGdXM3dtcEdWYk8vUnhVcjlWT1BSLzQ5Y0dqc3lic3VlM1lCaEt6b0swNEY2?=
 =?utf-8?B?UjFRNGJJWmNScnJ0THJ0Q1R2eFJhWVJkUGM4RlhwMkNOcElGWjY2eDM2dDhS?=
 =?utf-8?B?OXhIaVkxZ0xRMGs4dFN1VWFrR3Z6ZWJiVk9jaGQvdG1Ga3RsaWhFS1NBdjZU?=
 =?utf-8?B?Z0FPY3duNm9KTXlaSTlKbmIyOW9UNFBlNnJzK1hyZWRXN1hObmVZZXFFdFhl?=
 =?utf-8?B?QzBTR3pBMXVzWVJzUStNRVBTMENlOFJ0aFEwVTBLb21DMmhYSHluNWwrTUx3?=
 =?utf-8?B?K3JKZkRvcUVxcUdSNWhIRnROdTJaRHRYTkFrVUVqLzB2Y2ZNMnFRaEw1Ymxh?=
 =?utf-8?B?elBOTmZaTGlOaWR2bWcwcG1PR3BLRnE1K0RtQUdLK1FCbk14eU9WTzNnV1No?=
 =?utf-8?B?NTZUMkZIVGpmZTJxTE5OVHhpbGgrTFZFNU81YUxrMHpVa2J6QmNZWm1nbWNh?=
 =?utf-8?B?RlpoSHRXbFJ5LzdYSlFjd21nMFpXYXlVQmI4aFRURnFaak1yRTg3YjhSNERM?=
 =?utf-8?B?S2NFSlpSaFdxNktHZ1Q2TjJaNUQ1UURVWjlWaUR4OXJtdDhiMk1KMTZoeEFO?=
 =?utf-8?B?V3ROeHozS3JZZXRUV1dWZlkySmVHZDV0R21IUCtpVFBNZnYrZ1FpSStVTTJn?=
 =?utf-8?B?ZDk0Q3ArNVhyVGhpMDhqQkUwd0U0Zk1nTmVhdTloQ2c3bkdkbW13bkpSUGl5?=
 =?utf-8?B?Q3lGdkxXb0VyWmFqZ3hCU1h3SGVQdXVXTDk3dFowOW9oNE9QbExSYzJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnphYVBsU21LNHA4Qm9Qak9xZHQ2ejdFelNIQ1F1L0VqVW94MlU2VWlDdGF6?=
 =?utf-8?B?WWtYZEVTelIzdzZCeTlEK2xHRVoycjM1Mk9seHlFdkZFWFIrcFlUNzlLVzlt?=
 =?utf-8?B?SGpibDZoRFhrUW12UFpic0JqWURZMmRDQUlKaEU4OEVxYStNaEJlOVRHc2VT?=
 =?utf-8?B?bERpR3lhSjJTc0F3aGtpN1JYY2daais4YXI3ZG9Eb2t5UHRDOXVEYzNPMkZ5?=
 =?utf-8?B?N0U0T0g3YUtNWlpzWGtmV2x5Um4ySjJsY2FudDgwVnJJUk9VMHVlbm1jTVN4?=
 =?utf-8?B?bVp2aTlxY2VNV0QvWEJpZnlBVGExNVlVYmFRZHMyS05IWkNPcmV2TE9KNjRQ?=
 =?utf-8?B?RWp6YzZTTEZPL2lRbkpDU2cyS2gzSE8xR1cwK2NobDFYYWgxOGdUcjIyZGRK?=
 =?utf-8?B?akVyZ2lWMzhBS2krQkhaMTZrY1lqRGUyOHJnaEJ3UTVETkplalN4VmorNlc5?=
 =?utf-8?B?czMvU2JpTmxqQ0p1b2VTTlBLVlFIMGR1dHFYTCtLaGEzbm5nZjJ6aTJ4bHZK?=
 =?utf-8?B?Mm5uWWtlaHdvSWpicWVqckg4NG5NWXdCYzFHZmVWWUdSRWg4N2xZYWNXTGg1?=
 =?utf-8?B?elBBQmlMdHJZcVAwRVFEUTRCM0J5YlF3NTVHTE01bk4zdVBOTWc2eXMzSDBp?=
 =?utf-8?B?eFFxeWJGODlGZEgySXExYnMrWU5Sd0tCelJlNnk0VHptR1FzYVd5YUJCOGlu?=
 =?utf-8?B?bFBhUmFKZ24zOW1IUVB1Qnl4bXBFSGNMMVFJN2p2amt6enpIWE5nbDdjWVRN?=
 =?utf-8?B?bDExOGJydU96V0UwTFRlbG5XRUoxZHd1aHdQbURIN2tSMmJDSklGbGtuZFpu?=
 =?utf-8?B?ZU5IRlNFdHkzZWwyR0tLT3NUQXFQeURLN1JoODVlTFVUb0dweEFhT1lEUlRr?=
 =?utf-8?B?SjdZdWtTSDdXY3V4MDRPUnAzRVZ5eE1SVTNrRUdpaEw0T2pvaVRNRFkzVTNJ?=
 =?utf-8?B?NTVNN2xhdStGLzJXRGZ4dTRpcGhWZU9TaGw1WlEvcmNUb0M0Tm8rTnNiRHBn?=
 =?utf-8?B?N2tMR1AxZktHRnFGTlFkSm5rRTRqdVMwaFp4Z1FRK2pzU0Ftdm9qcUsxZ2hm?=
 =?utf-8?B?b212Y0tueksybUkyOGpsRGxCekZxR2tjZWdGVTdYVVhxKzhwUXZUcTh0LzFP?=
 =?utf-8?B?UElMb2RvSGdDcDBQTmNPendnVWxqOXQ5YjRxOUlPNkE2Z0JoUEhRbVBGeWhm?=
 =?utf-8?B?dGFMK1N6QUtHMWhqZzNhblpjZEgrTDhGK1JuRmlPblVvdDV4MDBZUEMzZllq?=
 =?utf-8?B?cTh1STBPUUd5QzdTUnRPRVd5UjdzQjdvcXZPYUMyV1ptc2NtVVJUZEswRk5F?=
 =?utf-8?B?UmwxaU9KSDhzcWpFcVYyN2JlZDRvNnBobDdnNVhZaDRDd0Y2RlZZRFhkQkgz?=
 =?utf-8?B?N0dGV245L2F4QWRyMkNzdGhjQ2J6aE1TSnJaOWk1TjFwT29DTUl0WjJYZzEv?=
 =?utf-8?B?aEk2dVRjMVRmMkU2WCtrcnVjNWovUCtvTUlrY2ZNK3JPOUNjK1l4emYwOXds?=
 =?utf-8?B?YUtVM3p4bkYvWjRHM1VySFJZOFhOSTlTSTQ0WGZIamN3NDdtR0NiS3AvMGxU?=
 =?utf-8?B?TVFkTC9Jb0RtZDNHT2RmM3B4ZXZ0TnVSd0VZZDlKUG9vc2p6OWg3ZUhoclJh?=
 =?utf-8?B?ZVNuMnFxTDV2K2k5cWdVUlpQTVJqcmIyQnZKYVV0SjdVcDVkWGplS3FWMk5t?=
 =?utf-8?B?emVtN29ibEtzcmtxN0NhRlFMdDYwcWFSLzZPNkZwekp0Z0FJalRPZm91RCtr?=
 =?utf-8?B?NnVvVHdhd01Kc2RURHBVQzhmY1dpdks1UU9oU3piZHpTVklqbXhpNmdOMmhi?=
 =?utf-8?B?MHlJdHF6ckNObmpRbnpDdnBoUUVmbFZPaGJIaHpGSWdQMHMvcjV4dDZYWWxH?=
 =?utf-8?B?YVNzbW5UYnFBNWVTTUZ5Um9xYkx6dy8xV0RabjBRaXUyZ0oyK3czZ2FwY0JZ?=
 =?utf-8?B?UDlGWWlVTkhzSDE3ZlJ2R3FWbm9Gd0NJWG51dC9YRktXbmdLQUlQMTFRM3dK?=
 =?utf-8?B?ZHVUakhqTXA3bGdBaldSYy9uVEU1L1gyMC84UWgrNUxQb3lFZWdVOHFtc1ZD?=
 =?utf-8?B?ZyszeXNyN3ZGWWQ3L3NCZW4rRmV2eU84YzZEc0Q1TFlZbGV2YmpjS1E3TU1x?=
 =?utf-8?B?c3laVmRRaGNKV1c1WTlCazd4enNCdWJ0VjZNZ1hkR1gvU1RTRTBTRm9oY0k2?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g/HIcEOWM66TWOGaDKZuulMpAZqY7p/Hn6KlnhDfHHDoybmpWjqZNzQ4CJLPNL9U/EuD2IoAaU5Bsq0qsBp2iZH4sLcsFxzdDV8Mu5JOqZpxo7zSh1XzAF2m6ks7Ii0qN4/TvPvDyJPz4ovE8iRSvCm5EUDEZL6F08wU2J0XXlytzwWbh8dohxC1MA+/VWHb2eoy+FD4ShOhd2XecysEssFjZ3D2UFu/9tTXwTKDjDuYprNPcqEap8hxYWJWu9Ot5Br7xXiMs24CqYikNAozxJuS6lxRhQThCVfTL/rpTxlNwD5MxbyiJ9tOfzflY1B2ggLXpxJ1bof2u1sUxWowbjFdsYVzgteDMgMbsGEER2Wd6pRiMM15PSNUFvmUxv/8H4AbWnWKnyaSfU/bQn+U9GdnbjIbeP9mEte4WWkslJYSUeJBMFjk2GU5kHm9WLDZkxUDjsYMavO0Tdpz2iW6JVvdC0SERi8CYI9lUIXi0dGDWfWeFXE4RkYHIQ7d4qjw2qjheLW5RKWEgYfbi4PE0qXM8W6ipeXfKGPOMBVcYC5SPUfyhi8m6chhgxwHcxh69dB0QYw/aMBhy0qn+7PSCFsZNQ7hGN01LdzFvhZt1eg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f2560b-e946-4bbf-08ba-08dc78fae48d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 18:30:15.3154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uys3i+3Cm+ZQWQkinp5J21jZXvMQ9iXpyczD4BtSA0h7kS2LKVdGJv24m1NW2xviqOhYIdFrRUozQcGYRYasv161Mf2UEKgANIu+yqbRSnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6077
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405200147
X-Proofpoint-GUID: jdShNIiQj5W-Ac6O1l9LvrClHtTGo-kU
X-Proofpoint-ORIG-GUID: jdShNIiQj5W-Ac6O1l9LvrClHtTGo-kU
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Peter, Hi Fabiano,
   Will you have time to review the migration guts of this series any time soon?
In particular:

[PATCH V1 05/26] migration: precreate vmstate
[PATCH V1 06/26] migration: precreate vmstate for exec
[PATCH V1 12/26] migration: vmstate factory object
[PATCH V1 18/26] migration: cpr-exec-args parameter
[PATCH V1 20/26] migration: cpr-exec mode

- Steve

On 4/29/2024 11:55 AM, Steve Sistare wrote:
> This patch series adds the live migration cpr-exec mode.  In this mode, QEMU
> stops the VM, writes VM state to the migration URI, and directly exec's a
> new version of QEMU on the same host, replacing the original process while
> retaining its PID.  Guest RAM is preserved in place, albeit with new virtual
> addresses.  The user completes the migration by specifying the -incoming
> option, and by issuing the migrate-incoming command if necessary.  This
> saves and restores VM state, with minimal guest pause time, so that QEMU may
> be updated to a new version in between.
> 
> The new interfaces are:
>    * cpr-exec (MigMode migration parameter)
>    * cpr-exec-args (migration parameter)
>    * memfd-alloc=on (command-line option for -machine)
>    * only-migratable-modes (command-line argument)
> 
> The caller sets the mode parameter before invoking the migrate command.
> 
> Arguments for the new QEMU process are taken from the cpr-exec-args parameter.
> The first argument should be the path of a new QEMU binary, or a prefix
> command that exec's the new QEMU binary, and the arguments should include
> the -incoming option.
> 
> Memory backend objects must have the share=on attribute, and must be mmap'able
> in the new QEMU process.  For example, memory-backend-file is acceptable,
> but memory-backend-ram is not.
> 
> QEMU must be started with the '-machine memfd-alloc=on' option.  This causes
> implicit RAM blocks (those not explicitly described by a memory-backend
> object) to be allocated by mmap'ing a memfd.  Examples include VGA, ROM,
> and even guest RAM when it is specified without without reference to a
> memory-backend object.   The memfds are kept open across exec, their values
> are saved in vmstate which is retrieved after exec, and they are re-mmap'd.
> 
> The '-only-migratable-modes cpr-exec' option guarantees that the
> configuration supports cpr-exec.  QEMU will exit at start time if not.
> 
> Example:
> 
> In this example, we simply restart the same version of QEMU, but in
> a real scenario one would set a new QEMU binary path in cpr-exec-args.
> 
>    # qemu-kvm -monitor stdio -object
>    memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
>    -m 4G -machine memfd-alloc=on ...
> 
>    QEMU 9.1.50 monitor - type 'help' for more information
>    (qemu) info status
>    VM status: running
>    (qemu) migrate_set_parameter mode cpr-exec
>    (qemu) migrate_set_parameter cpr-exec-args qemu-kvm ... -incoming file:vm.state
>    (qemu) migrate -d file:vm.state
>    (qemu) QEMU 9.1.50 monitor - type 'help' for more information
>    (qemu) info status
>    VM status: running
> 
> cpr-exec mode preserves attributes of outgoing devices that must be known
> before the device is created on the incoming side, such as the memfd descriptor
> number, but currently the migration stream is read after all devices are
> created.  To solve this problem, I add two VMStateDescription options:
> precreate and factory.  precreate objects are saved to their own migration
> stream, distinct from the main stream, and are read early by incoming QEMU,
> before devices are created.  Factory objects are allocated on demand, without
> relying on a pre-registered object's opaque address, which is necessary
> because the devices to which the state will apply have not been created yet
> and hence have not registered an opaque address to receive the state.
> 
> This patch series implements a minimal version of cpr-exec.  Future series
> will add support for:
>    * vfio
>    * chardev's without loss of connectivity
>    * vhost
>    * fine-grained seccomp controls
>    * hostmem-memfd
>    * cpr-exec migration test
> 
> 
> Steve Sistare (26):
>    oslib: qemu_clear_cloexec
>    vl: helper to request re-exec
>    migration: SAVEVM_FOREACH
>    migration: delete unused parameter mis
>    migration: precreate vmstate
>    migration: precreate vmstate for exec
>    migration: VMStateId
>    migration: vmstate_info_void_ptr
>    migration: vmstate_register_named
>    migration: vmstate_unregister_named
>    migration: vmstate_register at init time
>    migration: vmstate factory object
>    physmem: ram_block_create
>    physmem: hoist guest_memfd creation
>    physmem: hoist host memory allocation
>    physmem: set ram block idstr earlier
>    machine: memfd-alloc option
>    migration: cpr-exec-args parameter
>    physmem: preserve ram blocks for cpr
>    migration: cpr-exec mode
>    migration: migrate_add_blocker_mode
>    migration: ram block cpr-exec blockers
>    migration: misc cpr-exec blockers
>    seccomp: cpr-exec blocker
>    migration: fix mismatched GPAs during cpr-exec
>    migration: only-migratable-modes
> 
>   accel/xen/xen-all.c            |   5 +
>   backends/hostmem-epc.c         |  12 +-
>   hmp-commands.hx                |   2 +-
>   hw/core/machine.c              |  22 +++
>   hw/core/qdev.c                 |   1 +
>   hw/intc/apic_common.c          |   2 +-
>   hw/vfio/migration.c            |   3 +-
>   include/exec/cpu-common.h      |   3 +-
>   include/exec/memory.h          |  15 ++
>   include/exec/ramblock.h        |  10 +-
>   include/hw/boards.h            |   1 +
>   include/migration/blocker.h    |   7 +
>   include/migration/cpr.h        |  14 ++
>   include/migration/misc.h       |  11 ++
>   include/migration/vmstate.h    | 133 +++++++++++++++-
>   include/qemu/osdep.h           |   9 ++
>   include/sysemu/runstate.h      |   3 +
>   include/sysemu/seccomp.h       |   1 +
>   include/sysemu/sysemu.h        |   1 -
>   migration/cpr.c                | 131 ++++++++++++++++
>   migration/meson.build          |   3 +
>   migration/migration-hmp-cmds.c |  50 +++++-
>   migration/migration.c          |  48 +++++-
>   migration/migration.h          |   5 +-
>   migration/options.c            |  13 ++
>   migration/precreate.c          | 139 +++++++++++++++++
>   migration/ram.c                |  16 +-
>   migration/savevm.c             | 306 +++++++++++++++++++++++++++++-------
>   migration/savevm.h             |   3 +
>   migration/trace-events         |   7 +
>   migration/vmstate-factory.c    |  78 ++++++++++
>   migration/vmstate-types.c      |  24 +++
>   migration/vmstate.c            |   3 +-
>   qapi/migration.json            |  48 +++++-
>   qemu-options.hx                |  22 ++-
>   replay/replay.c                |   6 +
>   stubs/migr-blocker.c           |   5 +
>   stubs/vmstate.c                |  13 ++
>   system/globals.c               |   1 -
>   system/memory.c                |  19 ++-
>   system/physmem.c               | 346 +++++++++++++++++++++++++++--------------
>   system/qemu-seccomp.c          |  10 +-
>   system/runstate.c              |  29 ++++
>   system/trace-events            |   4 +
>   system/vl.c                    |  26 +++-
>   target/s390x/cpu_models.c      |   4 +-
>   util/oslib-posix.c             |   9 ++
>   util/oslib-win32.c             |   4 +
>   48 files changed, 1417 insertions(+), 210 deletions(-)
>   create mode 100644 include/migration/cpr.h
>   create mode 100644 migration/cpr.c
>   create mode 100644 migration/precreate.c
>   create mode 100644 migration/vmstate-factory.c
> 

