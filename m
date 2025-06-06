Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA9CC61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 19:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNctM-0007bl-80; Fri, 06 Jun 2025 15:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uNctG-0007Wt-GY
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:38:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uNctE-0006dT-2R
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:38:10 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556IMZ1p021398;
 Fri, 6 Jun 2025 19:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=xzaQsJI9ZYPHPpS1rh8pKrEWLfnCH3gZRWo6HczjNYs=; b=
 rdan988flT1ZNrSdW4tj9jqbqjsB9hR87iVhNOVLYY8DMddJAqtgxzzAK9U+E5F2
 Vfz1/XgFBch5sXJEsIu8+fE/rFDVIMCMKe1DnX4qNM1mFDT93l3nx2MztSWkW051
 TkP3W7HK5OvGagtvsd8TEaDgVXroYjVVrcafrWA5+GK7Ts6KMtSeQrfUp1Y4b6L7
 8VuUFKWi7sStxqan/o582ch6mtmY+G7mSs+auSW601xGDtWAPjbJKgrh68wo0yFQ
 XGo4rwHqRn2mns2FaJD+9PzNTHI6H5iyjYG4m/aFYEpjOJk8wQyrCkDO3qEiJ4j7
 OddJJS97hWzVXAXaO7SRrg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gggtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Jun 2025 19:38:02 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 556Ht4Yx016149; Fri, 6 Jun 2025 19:38:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7dn9a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Jun 2025 19:38:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnxUgVnayyny93okQj4ETXd6/niRmXxYHkJLkBjOv/Bx2ZY5szYrbxrVrZ5KuHme6Dm6vBQySsVLhI9wvbc5mwgumOY6LSeE4masBYcd/F4cLaT7nbRB0RDOHMSVhGCTFvmxT656RVgOmMjFOWxGl3tJqalNzRDFsGcoxuwLlCLhAB8VUluI0ABY97164K4Q9I1ecBjhfs5/tpzZAW5RQFtADR6JIaBWsGQffpsVlMFbB7xXjvwMHz3cZkxUfzvEMQ23Uidn41v8w/+n7UHXwwQC+Y1B7en4fGXxQaSrYH9+kT5L3sSf6OrEJjvOVcmQaGOj7Z3wKFh76QGRK5SK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzaQsJI9ZYPHPpS1rh8pKrEWLfnCH3gZRWo6HczjNYs=;
 b=DYVFEiwtgbWql5qXkhznl0Irp8yyV/zVqZ3rTIHUJlKpj4VW8X4kM6RcPHQFRVCO6Ojg6YLyRAouO13COb8/KkKKGPVL+HiolG9OoDbl65B/qnClUVsRSbM2DzVkMTl3xoDs2sAth/yWuB8XDAFSGcswm5f9NZ19wA+qQP/qxNht3AMqdD2LHrOHgFvnqgHpZdrKTaTbPBiG8yCxn1ggYbGnzLpsnDH0qerFSl+Ezmf7Q0wXe8X1XfkoCfEqYAAWMhWC+BSGwi9PAWxew8xa8ig/5YwNLanzv4byUaSfd/J1kkBFMkH1olwUR3UrX9hx/f0rEgluzCs7dDZMbl7s7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzaQsJI9ZYPHPpS1rh8pKrEWLfnCH3gZRWo6HczjNYs=;
 b=FDyNOGQTfHcLl0GtvId3MSArtZsbj21KMYR8f4ag0lUJYjsqBGZuhSGwjl0clyWEo16aGhDqSvHMJYP1eL3AX/FnEUpQ3JJj3urQ24d2oKcyVKBBJE2VBg7cBUnBMw3vB1fEYpv4oCwcSFYJ0kX9ZKk1n7+lqG+oMuKgh5vhI3k=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6146.namprd10.prod.outlook.com (2603:10b6:208:3aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 19:37:58 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 19:37:58 +0000
Message-ID: <ad638089-af36-4f3e-8f3d-61549e9bed06@oracle.com>
Date: Fri, 6 Jun 2025 15:37:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: JAEHOON KIM <jhkim@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, peterx@redhat.com,
 farosas@suse.de
References: <20250605230808.1278840-1-jhkim@linux.ibm.com>
 <aELy8_1ssb1jTSTa@redhat.com>
 <2f36bf89-9664-4552-86c0-646db01b7f1f@oracle.com>
 <2c8d3cb2-b3ee-4738-871a-0dea2bff0e84@linux.ibm.com>
 <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
 <760af012-1265-4845-b7d2-793fe75c3a51@linux.ibm.com>
 <aEMMjtsKZLX_Bi03@redhat.com>
 <7dc8d42d-47f1-49c1-9bff-ab2d09d0b6f3@oracle.com>
 <aEMR6Xjs8tRJ8_sp@redhat.com>
 <b2d90921-0991-4a57-a141-ad0c830f8618@oracle.com>
 <5f211f67-17f7-4b1d-a60a-4ff62645fbfa@linux.ibm.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <5f211f67-17f7-4b1d-a60a-4ff62645fbfa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0548.namprd03.prod.outlook.com
 (2603:10b6:408:138::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b508f9-6090-4985-417c-08dda531a44e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uzh2MlNiSlp4RFM4SGh3Mk9uSUxRUm1rOFg4ZTVrZGJzYVJmZGVyQlZOTXRL?=
 =?utf-8?B?bEF2WGpNTGVPK3lmNFVIZE9QY0tyZmZsY1pGWGdmQlg2VmFsZzhLV0crT1pk?=
 =?utf-8?B?Smh0WkdNZ2p3OENaRUpmMy9kci9Fb2k5Mnk1R2ZzVjFRYXRaUmxScUIxS2d4?=
 =?utf-8?B?RWYzYkJyNFNpYU1KZWlKQlp3Y2IvaTltQjBhTm5HZXEzdnhSd0RXbVhTVWRG?=
 =?utf-8?B?N3JJTlJQeUhPeE9DRWNNZlFuMFRjbmFYUXcyclgzVmdrOVVQd0htZXdRQlM4?=
 =?utf-8?B?UkJZa0F2T1ZrMzMrZ01OU0FXSUpMU3pyVjNlSENsVkp2WDl2ZFEyRFRrTWJT?=
 =?utf-8?B?WVJqaTNtQ2ZxcXdDWEJsOGJIRTM1eVFBWVF4VTBicnZiVnJuUmZTRU5MbDZK?=
 =?utf-8?B?VDNxWlVWT1V1TE1pRlI2MXRIc05NTDFnK2M2MU1rQ3pISlgyU0Q4ckhwUmhM?=
 =?utf-8?B?Wk5pekh2eWl5WkNlRmVlSXlaZncva2lkOVlkUVVlTDFQUkdEVnZyVDFMMlU0?=
 =?utf-8?B?ZzlaY1Z1Q2htcEtmYmoxSTAvTm9FdVZLdjdJRCthcXR3Tml6SEZOZ2FHV1Qx?=
 =?utf-8?B?SFZNQ1diOTRrRkQ1K1phTjdqWXJ4UUtyYWtBay9HZ3dkMllkOHFKWXl5UTdP?=
 =?utf-8?B?LzNRZktNMFE3UnNlK2RQNjBKby83SysvWjVqV0NNUHlIUkhGV05FOXcybnhS?=
 =?utf-8?B?UFZPbk9BT1UxOWVRRnVZc2FpcEkwdW0wdTZEQlpkeHFiSlV1UkxtVkRPY1cz?=
 =?utf-8?B?cG9QVXg1R1JFUXY3TUVpdG5kSkJoQ29rUXFGd1RJV2hhWkoyV2VGVElTalhn?=
 =?utf-8?B?enpWUkZmMFVUWHJZVFVtRytzK1NFRGdZOWhCNWtKWDIwVXNGOVRqWlRwMnVp?=
 =?utf-8?B?VUVXUDBOeS9aZGcrM3lDeDB1UFVULzBDQ3ZUeGJNd2ZzL0dsekwzdTFSeWt0?=
 =?utf-8?B?cWlTSEZWVVdxbG1jMy8veXpiSWZWNVBER1JydnJyNDhaSXR1WTJGNTdqdFZl?=
 =?utf-8?B?eXdjeGhOQjQxdi9wa3NKWlpHOFZreitxclk4ZXFaWHV5aWhTa0FxRU80cmFO?=
 =?utf-8?B?bDFtMVFsZlorVjFNenA3ckwwM2V4cFVzNkx4MFZOWTBZOEczVU5JVUdwRDho?=
 =?utf-8?B?REJhWThoMVdpazFnRVJmZElIc1dlYk9KbGhQVUNCMWl3cTQ5NFNZekk1ZDVi?=
 =?utf-8?B?ZEg3NFB3d2NPdHVjWnIrbHNYZG9ncGZjbi9abzM3SjRWUDArUUZlcks2amJl?=
 =?utf-8?B?SVNwUDVraXRrZ0lSRGNJRGxBbWtNSE10aVFvdkhjRmRqZTY1RmpvbGg2OWRQ?=
 =?utf-8?B?bWtkWmlnb3BtUUc4dDQ0aGN0UEw4dWlnaitwVytESW9ZbHpJME9kREEzUlll?=
 =?utf-8?B?SDFvQzV0T3puNlJrMlE2Zk4xVExHamhzcG1zc3RNWnpYRlRpYVg3ZnBIblkw?=
 =?utf-8?B?SFZZQ21HS2JGQVpMNWRUSENaYUVDV2VBaWp2VjdQQ0hycnBLbGFKY0xaTDZv?=
 =?utf-8?B?NHg3SG03eUVrMDc0YmtRN1JLSzhsSXcwUjZGcFpaa2NDLzdROUx6RXpaTUhI?=
 =?utf-8?B?aWMvd1I2SFM0U3hyQ0VVcGtNT0pqTXNmQ0s5U29QUWpab09Vbk9waVkvZFNU?=
 =?utf-8?B?TUJ1ZWNob1doR2JOVUtUM1FnMm5ubWtrNVplM3ZVMnZpemE1NVJBMTVsb0pE?=
 =?utf-8?B?QzVpOVA2S0ZsckRacitxVC85VHFwb3JEMFlpSTZsbTdIVkU2elZ2aE5tWGRx?=
 =?utf-8?B?bmRUeHRvbXhpSjUvOWRpRGVZUGNXMjdCeVhYLzVvNm8xd3FNTFFsQWUwVW41?=
 =?utf-8?B?aWIvbEFrSkxGRTUzZDFXTFE1TUJXd24vYVhnNEhpRXhZQ2RnRzhlbkRRNU85?=
 =?utf-8?B?OXkvTytmUkJlbmdvVjdmdFhXbVE1c3hiVGdTLzZjWSt1SXB4RWFiek1rbkN5?=
 =?utf-8?Q?UtFNr847JEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXcxMXBZaTVLRE5aY2pJN0NqeTlHK2tBVU41RlV3VDgvT2hRQ0RydW5OTVRr?=
 =?utf-8?B?MStUQU4yWU9aVksrY1NSeUxkNWxaMExNSi9vYzdSeDlDbFQwNnB3a1gxa1ZB?=
 =?utf-8?B?SnYvOGoxTUdLYm5iQWZSbzdCNzJjcUI5MU55dkplb0YyWmQwK3BsY1ZNTWJ4?=
 =?utf-8?B?SnZpYXRIVWJwZVl4Z0s0SnFRV21vaWVWZHJiTXN5c0pHSnBQTUNPakV4Y2Vo?=
 =?utf-8?B?ZUdBeEJ5NzVEL3dSRjFzd0lJckw3aUhIc3NVRC9yYi8rSUE0VTNWMGhMeXJW?=
 =?utf-8?B?M0ZFS1QrUm1LT2c3SmlxVjhPNE9RaFVyVEo5ekJFYmp6YkZrckZpSGIreTl6?=
 =?utf-8?B?RzhYaENIdW9FYW1PMEwwMWVkKytWazhzUW1VdDFlMVZZQnNzNzhRQmgvYk1I?=
 =?utf-8?B?YStHTWRCRXgrbkVIcWIya0ZEcHpFWG1DcnpaODFua29FSG4vZnlzalgrSTNR?=
 =?utf-8?B?K1haK3FZcmxNdFhuZFNlVk1wcDc2SUx3MGpmaEhFdFladFc2K1M5OWw5VDdw?=
 =?utf-8?B?aklhNTFlajhqSHorRm1jSXJtNnZvTWJYaTR0bmQyRmxLd0lVckxrc1MrcGlN?=
 =?utf-8?B?dVFDWVB5cDVjTm55RENWSHgwSk05VDdPZ3h4UGZ2RG1YaGV1Y1Q0UXA3RzNr?=
 =?utf-8?B?V0grYzZETEVwUWd4NytaemhsZTU4cDdaamFhUG14NFZqeW5sbnlNc211UVVr?=
 =?utf-8?B?amVrVnNhWmR5T2IvT0IrTkpiNEdiRENvc04xNDRObklkTDBkY1RCSFNPbTBS?=
 =?utf-8?B?S3RlUjg1bnhWUG01bWExY0JwWXRXR3djRkpyOXh6VHFzSndIVGozbHpwNUpt?=
 =?utf-8?B?eXpKbWhXNjBPZ3NNeGNGZno4SlpGNzNCbko4WUtuK0ZWVHdPa1c2SnFYTm1a?=
 =?utf-8?B?bkRnbWFMTWN4cnN5R0N1UG1EVXhxYW1ocTNRTXQ1VFpDZ0dORmNhZXE5cjJq?=
 =?utf-8?B?eUN1aFFJZVhwV1I5Z3NOcXFaNDdhTXVoaTkzc2E5S2dtRzk2ZzVKcGIzQkw3?=
 =?utf-8?B?Y01JcU11VnJBaGV0WEJZbUlSYnhEMFd6MGVxNE1NaEl2S1ZiUHZnVVo4VWdm?=
 =?utf-8?B?MmI3cUJCNmxpZEV2dmpUdllZOUpiR0FPTjVyUXllcGlFNzRmbHF3T0ZqTnkw?=
 =?utf-8?B?S3VRYS9UWFlQc1E3RUVpbURpbldBcjhiQjZVYkdZa2VwZ3FxRnFtVnQyMnoy?=
 =?utf-8?B?QXZydmRYU243d2hKQnBhTHBibm1QRUh0VHN4eWJicG1LbXFEZGNoVUVCSHA4?=
 =?utf-8?B?L0N3TGF5MUxHWm5KRTNiYXlsOXFwei80NlV5Vm9mT3N0TzJNZkZsSUZUY0Y1?=
 =?utf-8?B?UTEraG05Q04xQkloN2NvUkN3UWFObFAydWFRbk1NNFdBN2dHWkxmbW5GWjVX?=
 =?utf-8?B?N1g0WjVyNGI4Z2JhRXlqWkNzVjlQUUdrTDEveXVSODdPRXRobG1tK3k1Mkxi?=
 =?utf-8?B?ZEUwOW5sK1RHSThiTnBsZTBBd0t6dmNuSzlPdjFiWXlLZkxYUEdWQ1RZdm16?=
 =?utf-8?B?YzlQbVBtWjR6d3gvQklSM0t3S3ZQM25ETCt4S3Uxb3BKcjF5UUpFQW01M2tI?=
 =?utf-8?B?VnRlRHZzaldFbmRGd1pnR0JNMytMNGwvNXM4NEZnVHZoQjJ5SERwUG9KSnNn?=
 =?utf-8?B?ekhhcnE2dzVSYTQ2K0JtZUs4MThNWUgwY0FudDhSL0xuRGJIbWVsZ1NYT2Ev?=
 =?utf-8?B?VzF3aUlHWlpOb0YwbWJMWCtoYldPVlAvbFRQLzlYUUxxTzhYMHZTdW1qMkpm?=
 =?utf-8?B?L2JxVFhCTVpDOWV0eWgzNm5oL1B2Qm9FR1JUSlpsK25zQlUzN1ZaM0hTUVM3?=
 =?utf-8?B?MzVEV1ZoYW5XakdrVXJPZVorUG1Od3JId0pram1DV3pGM21YWmVLL1VyNHJ2?=
 =?utf-8?B?Nm1xTFREZ3BKdnlPRTFDUmlOcm1INW9BTFlMcHl5ZjdxdGJuNmUzMW4rakNM?=
 =?utf-8?B?d0hIVGl1ejc4UWsyc1FWNGh5aldKalZiWGpTT2Y0dXFWK2djU2tPZ1FVclB1?=
 =?utf-8?B?YXkxYWg3Y3NqZVJPUDJyVTJYWm5LaDl1ZFVtakdQV0hjb1JpNjdwN3FCQmp5?=
 =?utf-8?B?VWphVTRWNTd6ZHNVcVV4RVl2Tk5rODZiNkpJK1pDYkFZeXVIb1FlZDNYRWhx?=
 =?utf-8?B?QXpnMG56clVWSXVtOGQ2NjdxMFdqN2pZNkJEaEdsL2JjUGJ2U2F6WWJHazc2?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PwXMpZsKeEgypVJaA44Upuzm8Uk9waN7DmsYnirchiw2scqsLgBLV5Gs6oJ0dG9lt1iRg7yL3EFeq4RwXm+zCNGuh6m0ro75Ws5qPMkZK2UwfUYL3Zesg+N/ZWK5xCOn+//as8FdpKPHAijJMLnXlSGSDyiFGwESjcn3aPPIyzLlTKtk4VDOo33/ph8gu78zFnXWA0tuv6JaXXJnTOyqmiPvOy8ACNb0+obxnt8MHZxgHXcZqvO0j8EN2uc8q56JHyDdXxuxCko/0le/85uZkGykkMWZiNV2k6lFic4ydKBHEoKXQcZWpDLAhElhTBIcNytgioE5WuX1RoijEYeHDDj63QR1x3WXehztefiajqeuj6Q2BTwMcsUTXKXG9ZJ8rQ/G/xExwP0TSN0W7r+OPgEKd/Ma5mLH5TeDgpr2JOZjne1u7m0t2bbcJr16blqoqU0RM53x2NsL1FApgUbg8Ekaw+HPuMq918fLGMKanKu0r4s3N4qYjk7wL7GySyOHsKcyxthzeEq7KrUfbVlr0BcK/SXhH7d92TxgQI5I86voWdZ+apy2sCKOqY/GGx4tIbUZLkJyXKc/kzNaJ4EtM56FuYzqiPSPVLafDegPsG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b508f9-6090-4985-417c-08dda531a44e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 19:37:58.6577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMhOc9amnUgKFbAU2VxxIy8cC6Nq9j7QQliQ02MlV8+5kq99fEwRh/INYWC3DIdsGU5IGyjV2wO/9bGTjAbmAKutTZCG223RNv4q/s+eQL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_07,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506060168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE2OCBTYWx0ZWRfX8FeROlw0KMbY
 kCescR5DCNCwygJS2gyBkBfyy6Xi3hgM+X17LKFGAR8qvfgyLduV9t7uROBzZg4xFHmH/r3FQwt
 EKOsAcz44QoOKjB8+YAsM5p+QL/zVFd1Q8GcX70U8PhpG0N7DztEHDyRwRu8quJrRIHGSIbC0rC
 SJL2yE9jnmxyRvhpAbG8K0k+uZtzl1NP1rmrv4EBgmAChFRPfkDnMN2AJCk3v3B/34pQf9jfAvf
 OkxCjPoI7oaEI3d2GLrz+KWsELoEP1mPE77fMDUV78NVSZtuToyxO+eC1WTLGvGH0Amyb0wp19+
 cqzokK0PM2JwnLy5DKkQvNUhWbZUQl8g9s/TDaLutWYf+BxzXuFct578Gnfouhl+iZvZtdid3bQ
 2pvHyj7cYRxbhKZVRIxmuVJScbKBhEnJlDOZKeNgw/1Qaflokn6XDw9hRMlXX4w2a7xNoQYm
X-Proofpoint-GUID: cfuV-eedJ3cEawwd4Sa14uwF7dIYujE1
X-Proofpoint-ORIG-GUID: cfuV-eedJ3cEawwd4Sa14uwF7dIYujE1
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=6843439a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=UYW0Jxzn9Q7OhXqiHtsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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

On 6/6/2025 2:06 PM, JAEHOON KIM wrote:
> On 6/6/2025 12:04 PM, Steven Sistare wrote:
>> On 6/6/2025 12:06 PM, Daniel P. Berrangé wrote:
>>> On Fri, Jun 06, 2025 at 11:50:10AM -0400, Steven Sistare wrote:
>>>> On 6/6/2025 11:43 AM, Daniel P. Berrangé wrote:
>>>>> On Fri, Jun 06, 2025 at 10:37:28AM -0500, JAEHOON KIM wrote:
>>>>>> On 6/6/2025 10:12 AM, Steven Sistare wrote:
>>>>>>> On 6/6/2025 11:06 AM, JAEHOON KIM wrote:
>>>>>>>> On 6/6/2025 9:14 AM, Steven Sistare wrote:
>>>>>>>>> On 6/6/2025 9:53 AM, Daniel P. Berrangé wrote:
>>>>>>>>>> On Thu, Jun 05, 2025 at 06:08:08PM -0500, Jaehoon Kim wrote:
>>>>>>>>>>> When the source VM attempts to connect to the destination VM's Unix
>>>>>>>>>>> domain socket(cpr.sock) during CPR transfer, the socket
>>>>>>>>>>> file might not
>>>>>>>>>>> yet be exist if the destination side hasn't completed the bind
>>>>>>>>>>> operation. This can lead to connection failures when
>>>>>>>>>>> running tests with
>>>>>>>>>>> the qtest framework.
>>>>>>>>>>
>>>>>>>>>> This sounds like a flawed test impl to me - whatever is initiating
>>>>>>>>>> the cpr operation on the source has done so prematurely - it should
>>>>>>>>>> ensure the dest is ready before starting the operation.
>>>>>>>>>>
>>>>>>>>>>> To address this, add cpr_validate_socket_path(), which wait for the
>>>>>>>>>>> socket file to appear. This avoids intermittent qtest
>>>>>>>>>>> failures caused by
>>>>>>>>>>> early connection attempts.
>>>>>>>>>>
>>>>>>>>>> IMHO it is dubious to special case cpr in this way.
>>>>>>>>>
>>>>>>>>> I agree with Daniel, and unfortunately it is not just a test issue;
>>>>>>>>> every management framework that supports cpr-transfer must add logic to
>>>>>>>>> wait for the cpr socket to appear in the target before proceeding.
>>>>>>>>>
>>>>>>>>> This is analogous to waiting for the monitor socket to appear before
>>>>>>>>> connecting to it.
>>>>>>>>>
>>>>>>>>> - Steve
>>>>>>>>
>>>>>>>> Thank you very much for your valuable review and feedback.
>>>>>>>>
>>>>>>>> Just to clarify, the added cpr_validate_socket_path() function is
>>>>>>>> not limited to the test framework.
>>>>>>>> It is part of the actual CPR implementation and is intended to
>>>>>>>> ensure correct behavior in all cases, including outside of tests.
>>>>>>>>
>>>>>>>> I mentioned the qtest failure simply as an example where this issue
>>>>>>>> became apparent.
>>>>>>>
>>>>>>> Yes, I understand that you understand :)
>>>>>>> Are you willing to move your fix to the qtest?
>>>>>>>
>>>>>>> - Steve
>>>>>>
>>>>>> Thank you for your question and feedback.
>>>>>>
>>>>>> I agree that the issue could be addressed within the qtest framework to
>>>>>> improve stability.
>>>>>>
>>>>>> However, this socket readiness check is a fundamental part of CPR transfer
>>>>>> process,
>>>>>> and I believe that incorporating cpr_validate_socket_path() directly into
>>>>>> the CPR implementation helps ensure more reliable behavior
>>>>>> across all environments - not only during testing.
>>>>>>
>>>>>> Just from my perspective, adding this logic to the CPR code does not
>>>>>> introduce significant overhead or side effects.
>>>>>> I would appreciate if you could share more details about your concerns, so I
>>>>>> can better address them.
>>>>>
>>>>> Requiring a busy wait like this is a sign of a design problem.
>>>>>
>>>>> There needs to be a way to setup the incoming socket listener
>>>>> without resorting to busy waiting - that's showing a lack of
>>>>> synchronization.
>>>>
>>>> How is this a design problem?  If I start a program that creates a listening unix
>>>> domain socket, I cannot attempt to connect to it until the socket is created and
>>>> listening. Clients face the same issue when starting qemu and connecting to the
>>>> monitor socket.
>>>
>>> Yes, the monitor has the same conceptual problem, and this caused problems
>>> for libvirt starting QEMU for many years.
>>>
>>> With the busy wait you risk looping forever if the child (target) QEMU
>>> already exited for some reason without ever creating the socket. You
>>> can mitigate this by using 'kill($PID, 0)' in the loop and looking
>>> for -ERSCH, but this only works if you know the pid involved.
>>>
>>> One option is to use 'daemonize' such that when the parent sees the initial
>>> QEMU process leader exit, the parent has a guarantee that the daemonized
>>> QEMU already has the UNIX listener open, and any failure indicates QEMU
>>> already quit.
>>>
>>> The other option is to use FD passing such that QEMU is not responsible
>>> for opening the listener socket - it gets passed a pre-opened listener
>>> FD, so the parent has a guarantee it can successfull connect immediately
>>> and any failure indicates QEMU already quit.
>>>
>>> For the tests, passing a pre-opened UNIX socket FD could work, but I'm
>>> still curious why this is only a problem for the CPR tests, and not
>>> the other migration tests which don't use 'defer'. What has made CPR
>>> special to expose a race ?
>>
>> For normal migration, target qemu listens on the migration socket, then listens
>> on the monitor.  After the client connects to the monitor (waiting for it to appear
>> as needed), them the migration socket already exists.
>>
>> For cpr, target qemu creates the cpr socket and listens before the monitor is
>> started, which is necessary because cpr state is needed before backends or
>> devices are created.
>>
>> A few months back I sent a series to start the monitor first (I think I called
>> it the precreate phase), but it was derailed over discussions about allowing
>> qemu to start with no arguments and be configured exclusively via the monitor.
>>
>> - Steve
> 
> Thank you for sharing your thoughts.
> 
> I agree that busy waiting is not ideal.
> However, considering the timing of when target QEMU creates and begins listening on the socket,
> I think there is currently no reliable way for the host to check the socket's listening state.
> This also implies that FD passing is not a viable option in this case.
> 
> As for the 'defer' option in qtest,
> it doesn't cause race-condition issues because the target enters the listening state during the option processing.
> 
> Of course, to address this issue,
> I could create a wait_for_socket() function similar to wait_for_serial() in qtest framework.
> Since the socket might already be created, I cannot simply wait for the file to appear using file system notification APIs like inotify,
> so busy-waiting would still be necessary.
> 
> I would appreciate hearing any further thoughts you might have on this.

The easiest solution, with no interface changes, is adding wait_for_socket() in qtest,
with this addition from Daniel:

   "With the busy wait you risk looping forever if the child (target) QEMU
   already exited for some reason without ever creating the socket. You
   can mitigate this by using 'kill($PID, 0)' in the loop and looking
   for -ERSCH, but this only works if you know the pid involved."

Daniel also suggested:
   "For the tests, passing a pre-opened UNIX socket FD could work"

Note we can not use any of the standard chardev options to specify such a socket,
because the cpr socket is created before chardevs are created.

Perhaps we could specify the fd in an extension of the MigrationChannel MigrationAddress.
{ 'union': 'MigrationAddress',
   'base': { 'transport' : 'MigrationAddressType'},
   'discriminator': 'transport',
   'data': {
     'socket': 'SocketAddress',
     'exec': 'MigrationExecCommand',
     'rdma': 'InetSocketAddress',
     'file': 'FileMigrationArgs',
     'fd':   'FdMigrationArgs' } }           <-- add this

That would be useful for all clients, but this is asking a lot from you,
when you are just trying to fix the tests.

- Steve


