Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9839C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Yrc-00049N-VM; Thu, 02 May 2024 12:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s2YrA-00046H-70
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:00:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s2Yr7-0003h0-KX
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:00:23 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 442FiVGM024093; Thu, 2 May 2024 16:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=PhWggtMNCnWOtnb9zfYFgVY7MqAO/M40gI2WO+1NySc=;
 b=I9/b+WrwjLzWbkqcpv27K3IGIisJ6Js6m+49WdicdOK3Rp6LE71dqIRpoKfgz6kvtAk8
 +sQS0N09Pz9+YeZ6cyznwd/CHCgJIIO+q0A8cyvE79SrKA0xks8Pq4UR1pzsGbbBa1kd
 S53PBcynR0onF5jijn1gZ3zc7iYbEIErVUOFmOAjidcKNWXFsnQhM3dGZiY2G7ev/xbm
 yyBDPaW0QqCUU6xnBbGU39U73d8q2piUAqbdtOxsy4rNUHu20M+QjPDXnS9/jkpZJI8G
 vV9KAjZu6ziEkSRPAocDInSIAOBG0FYt2B3zSJL6BALoqPZ/hVMj0qNbSByF9UMzywVS CA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9cxvfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 May 2024 16:00:11 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 442FixLU019912; Thu, 2 May 2024 16:00:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqtamsju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 May 2024 16:00:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnaeBDzEBFJyjJxsNqZzgCoheuo6lyc5iBT/zQpv5ODl0BTelcCutpeJGUdbYnzR9re32+TPslTvsfo60MIWYLEWbaTZghmwG56J/abFD312yEZXJAtclYUOqpVIDbjumLMb/no8nrJpefg16FmboucWAaI5/Ho5m9JzBeIrBOWSgkj0Uoq0biCvflyVdUlZPFV4uxB9wNvJPbpX1nWj9a//k6ZTscWrqmEqQK4ptP16P6k/OXgqZ1PuyQ1oRZVwXt2pYCldn7fC6NDYE+8rsKSxZy/LYulXyQ6dP91E8hNketCvWVht+lzFaSCZgRez7JE3I2OVq3W4hiAKF1+YNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhWggtMNCnWOtnb9zfYFgVY7MqAO/M40gI2WO+1NySc=;
 b=IWAh2BD1EyZMKYLejbkADf1UAkfpDOTvmCPiTwpdMm6R7fWZ6wt6vDGzWcogKqtImMi/QaFPXKbxv5sKbUXNlLStm45a4DQRBjj2SCQ83UBKlOkancTat6FOXsIDt8snJrN5Us65tatMmF+QtZkReuRYWR497kO3ySvL8nXwSb5BOjSrWGwrfW26Y9QkGX+zxhNF1rBNsP5RjgVxNyfR402C0fnI1dIaXQOw+4FlsFFM+Woab1viVEi6DM8cUrhoOEkfEl2FbczcfwnEtz+osfigLPAIOA6l8kdcj7bf7BBIrFEJcWMIymVMHpimVmqUK1AeJUKSHeqtB6AW8l0zvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhWggtMNCnWOtnb9zfYFgVY7MqAO/M40gI2WO+1NySc=;
 b=gbWRYX6S6MBBw86yGLOiyDFly+MD28BMGB5BdcxsfXSzhUSJIfEXIFmZ3STxWnsgS2mdDUB3k1D2g6DnFV4OM8st56AoJ4qITOcdCjI774jZPralswGwyt+SzsVVwPOdWvEaV4keU+tlbZIh9UDk2fYijlUUCO/MdWIVGYyR3c4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BLAPR10MB4930.namprd10.prod.outlook.com (2603:10b6:208:323::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 16:00:08 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 16:00:08 +0000
Message-ID: <b96d2fe7-2679-42e5-a0cd-a334faa8ad15@oracle.com>
Date: Thu, 2 May 2024 12:00:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 18/26] migration: cpr-exec-args parameter
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-19-git-send-email-steven.sistare@oracle.com>
 <87cyq4767e.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87cyq4767e.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:208:23d::14) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BLAPR10MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: aafae071-355a-4101-c642-08dc6ac0f06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0tKUXRsYzJxQng2LzJrNGpvOGhuanlFZGR0QnhTUnUvNit1YWtjc200eVFj?=
 =?utf-8?B?bVRBSzdIVGVZa0hhV2l4cDgxemlvQjVzbUM1N3Y1eitETmNhY3pNOVVRNkNO?=
 =?utf-8?B?a3lkNW9TZG9FVHZNVWhCd3dhMmkzVlBvSTlFN0hrelVsVGtHME9rQktIeTFo?=
 =?utf-8?B?SzBUQVcwelBKV3kzMTNsVmhoREUrd2ZHTlU4VU9pSWI2QmNxZk9sQkZWMm92?=
 =?utf-8?B?eWxRWE15T1lQd2dFbjBndEhEdk9WQ1VJa1Q2NmtKd3JxVzZGZXduSlZHbU9l?=
 =?utf-8?B?Y0lNY1Z6MTdpOHRNck1KWCtVNUtFbXRFa1BZV3UwWmVRWksxa2dhc2FsNWM5?=
 =?utf-8?B?Q2Mvc0lBUlJtSHgvNWIvUkoyenNmN3Y1a0tER0YxUnNnTVRZc0JUYmwwNWZR?=
 =?utf-8?B?b1kxdE9OU1l5SnZNb092OTNnNHJKZVNRQjRPQytGcGp2bkpRcEhWWGNQZmFu?=
 =?utf-8?B?L2xGeDBtNEVLb0dpeHV5SDhaNDVkQUs3V2s0a3N4WngzSnZsTStzNXdIL0dp?=
 =?utf-8?B?NWIzYmNmajZLYkVjTzk2YzRZTEMwWTltd3RELy8yS0VJQ2hEbnNnV3MxOGV0?=
 =?utf-8?B?TFR2YTc3QUNjS2VBelplT1cxc1FhSVBtakkyUWxucWF1NXlIdXltV0p6RGx6?=
 =?utf-8?B?YXVGSG5IRVBCQzV3alJRSnBFMURycXJ2YnBiSGY2WWZPQ3ZwOWx1T2MwUXdn?=
 =?utf-8?B?MzRNVXNuTHJMdnRDMG96b0ZWWWgvUCtWUCtUVlFFR3NUOVUvZHBEMUQ0M2VZ?=
 =?utf-8?B?eUE5TUFHRWxHbklGZG5CWm9IWnpvdEtvZlJ1RlRQRm9oeHJ3N2xUOFNCdjBj?=
 =?utf-8?B?WmhZbWFEcEVZVUF0Qnp5aFA5eGZlSTdVYldKY2cwRjlMbG1nYys3U1hvNUlB?=
 =?utf-8?B?dG9ndFg5UmJVK0ZyMU1LdzRvT1hyZVlSalVSTzBaejExaVdXNWlaeEZSVVFH?=
 =?utf-8?B?WFpBanJQSThpVDVIazdmK0Q4NXFMYnE1NXB4UWhxTXZhbHFUaGNMM1ZsZmww?=
 =?utf-8?B?bnBFZjNpdUNJZ0h1RmVnYXpVWFRkYStIaUJGMEJXUGpoY2JBZ0JiUjM2U2lX?=
 =?utf-8?B?MWFoQkNQM3lFb3dSeWR3NWdQb0FpZ3R3L0JMdUQyQVNnRkZrTnkzNUFNMGxt?=
 =?utf-8?B?Q1BaRzhQdlh3UWlXL3ZWNkwvdmJSYUNWSzJxVEpTanJrWS8raHJteVhIa3Q5?=
 =?utf-8?B?THllODFaYVZ2eUlhNGlMWlptK0w4aGExT2pZMUtHQnJVL29IeEYzaVRBeHE1?=
 =?utf-8?B?Nm9XVkE0WTFDK0FyMUFTMDFDVS9sa2R3b3BkODRKSGRTdnhMbzFWYnIveXY5?=
 =?utf-8?B?cldXRGc3cmFTVkJrenZubHNFQ2k0ZWViR2IwUDBodkpLUVdtS091MjE1SjFL?=
 =?utf-8?B?a0RxWjZQSmFHVDdES3R4citFZ3p6dURyYWFGUG4za0ZtM0V2aHFWZHViaW9a?=
 =?utf-8?B?OS8zMVFTSGhQa0l5bjFpdFNCMEc4UkxTeCtENmFGcmQ4WjhNNlE1eXIxSjVK?=
 =?utf-8?B?YW56ckJxMXdGNTg4RTVhK3FJTGg1U0EzZE5SV2tWU1VWREw4M1BaREdyK2JQ?=
 =?utf-8?B?Smgvb21UN3RhRmtaZjgxQVRpb2Ztb1BxOUdtOHkvbUxFOWh1eW1HeU9DU2hl?=
 =?utf-8?B?eTRwTGVLa1RaNlo0WEQyOVlzYXRiRmU4MDBBcTdBSVVhRTlPMXJST3B5bUMz?=
 =?utf-8?B?MkxMRk9rRnBXeDFsQTZGRWRyRTBoeDRIbU1xdnZvSkhYbGF6L1BsREd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXZaRStJUW03blF4dVFHS0ZkUjVhem5jcUdBeGQ2NEVVSFc0MVZFYjVtbEhM?=
 =?utf-8?B?NkRJNTY3aU5sZjVNbmV0b04vMUpDRjMweS8wMDI1S1RFZzZaaWpCcHBaakhY?=
 =?utf-8?B?dFJqVmpqaThhL1RCUURsSXoya3BWZEh6a3FvRG9uckhQN1ZvaE9aSE1MSlVx?=
 =?utf-8?B?NUM0NENoL0pzOVIxaHhEZStxc1liQzJ5SkZkQWZlc1EyOHI3RGx2THVhVHE3?=
 =?utf-8?B?ekdJcnptVXVaZllNVjdjQlUxbFRZYWYvM0dvU0c1UDlGYUZWeVI5eGxDQm9h?=
 =?utf-8?B?VUtiN2Q4eEM5MGN3QU9yemo5U1Vsak1jT3FNOXdGS3ZkRDRlQTFXTFo4MERm?=
 =?utf-8?B?bWlWNWx2S2RvdzRhaURWdkJyang2Z2ZEblRWY0JkaDlMalB5RmtqaVVQUkVj?=
 =?utf-8?B?dWZVVnZyZHhFNkpYMXRYaHdDUVE4YXc3RHhkK0IwaWV4SXdtaHU0SXRCMURY?=
 =?utf-8?B?MGh2dmFNdktXZ0JJc2xYK2k4RGJpN20yVFlpTDg0MWQ4RERFZHplME5EaU9C?=
 =?utf-8?B?b0tGRGVmenJjYjFpbTEwMU9KbFNaL2VZc0VXaElMUThZVTBiNDgzNzJ6dGpw?=
 =?utf-8?B?eWJMbCtRMWpPdXBnZFIwbW5QdFkxanBSL2xYdnR6NGtBZVpXbGZOWXNBd01V?=
 =?utf-8?B?SkdaMkRqd1FXdzAvczFmSVpMZkVKQlpOQW8waS9iSzlzT284RGRRdE5aREZL?=
 =?utf-8?B?RFg4aG5aV25QYWQ2c3FHTlZFT2NNeWw1cGlHenJUcENrMTVBWkFhSkZjbXdD?=
 =?utf-8?B?bDdVVTRDRUt2SURWVUJUUXBrN1plYWN3QXJCNnA1eStNVkdHc2p4R05ydnFi?=
 =?utf-8?B?UU5uN2xMOXJLSzZuOWJmSVR4eEZmWVg0NG5vaXluSHBodXBSeXA0S0lMaVQ1?=
 =?utf-8?B?YUlYMWNVZW0xNGdtMHJxcnBUVHdBSkY0dHdpNzdScHJrV3hXUnRkU3FhSmRw?=
 =?utf-8?B?ZlJOb25KNTd2czhsQ3pvVGxaYnh2ZUk1bVd2SW1Senp4NmNkVGsrMEp1aWtr?=
 =?utf-8?B?aU9iUkltdWdocHRFQXZiM1kxMlg0UmxkTjBhMGdGS1hycWFKTUJqbzRYWjZ2?=
 =?utf-8?B?NDZPclNzTGljZjNQTHNMRUk2QS82N29hQ3RkdlNSTUd2RWFoMy9nSE1wcXlh?=
 =?utf-8?B?MTRPZmJhbzVIVTNURDZNdXRHNnZ6SWVVMGNPU3RiZmJRaW4yS2V1ckZwdG1k?=
 =?utf-8?B?TVZHZXRSc0Q5eEtETmhmcVhDbmZhSnBiellCOWxPRFZUUnN5Y1VGWXIwTlBR?=
 =?utf-8?B?TVlSQmY0ZUxnREFZa2VIT2FSczBQcG05dmIyTUd5ZUI1RHRtK05ReG51YXN5?=
 =?utf-8?B?SnZ4dFdHT2c1ZS92b2tkV0c2NlpzRFkvV25IdVEwZEc5eUFQQjk4bm1DNE5z?=
 =?utf-8?B?WkllK1VpT0FqdFpzTENuZStRc0QxL3ZIRUpnSG9SRXVrRTEyeXd5VDRtbnVl?=
 =?utf-8?B?dlhFYis2WXlEM2hGWVpzNDNHc1RReHpCV09DNkRuaDFoSUk2V2ZUNHdRdHJs?=
 =?utf-8?B?a3hIczU3cGMvR3pkVlNiclR0RTVkZU5yQnlFMmtLQm9KRXRPekFiaWpsaHFj?=
 =?utf-8?B?YlY2d3ZwTWhIRXFNeERLWW9WYTU0K3V6L2lwdXUyTzVMT29saFhVZExMRysz?=
 =?utf-8?B?emI2dGwwV0U3SWp2QldDd3VJdklKTzdHVENrODg4TG50aitxN2w0SnBRcnhj?=
 =?utf-8?B?dWhneXYrVlI4dkZJRWtzeDRRbWFqRXpONWN0UkFiSkNSbzdrbHU0K2RHTHY2?=
 =?utf-8?B?VFZEbks1ZjdING5MbldGU052L2hScHAwRHh3M3cwT3JoRE1BQjJ4V0xvKy85?=
 =?utf-8?B?ZHhHazkwQS9nYjAycDVBb09GZ2NhdDlqbWEwcm5jY3pRaFIyMjdsYTcwTTFS?=
 =?utf-8?B?emphS1UyRVVkSGwxK0lIWWR0WWExNnV1SmMwY2xQM2JuN1Z3UkVwYS9waEI3?=
 =?utf-8?B?SnBPTHFjMEJLYkltWXV2TFN3NkNwckU0S1A4cm9HYVJ0bENkNHhvanN3OE5j?=
 =?utf-8?B?ZDRBRzlnSnIxZ0xZbVFubEJxSHpYSDl4a0RIbTNHZ1BtS3JDeDcwakJjYzNl?=
 =?utf-8?B?U1ZvbGR1ekc5MmlKU0czRVgvY3k5dVpmYS9hWTZVdk16NGx2aUdGRnlFQnJ6?=
 =?utf-8?B?My9jNnRLOXFZQm1aQ05WeUw1YTgveWFwNTBWRnp3ZlNsdUtwM1ZGSEcrdisw?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VdvsKuLj6OdyGyaxBR5koQLgPr1C2DMP8UwSnaC0UCTHjH0A/WyBqabNTTlaJEsxSS7obvNZ08ZivnCNckLsKcFpTFUwXrlqtZojyV0aCV8rikIyP4o//HoA3PE/KkrjrcF6lYzxDqL6QbDoOvxvwsqWiKZUBsv1E52H4PEeSIrcqx+5+Lct2BWX0itx7rUXbH9i1N7n36DEX2s/y05bVnRhdmoi6bhVucfc5aKE3PnI6rX3+ABYxUQc/E/RUfrBdmwl08k3CWsrwUinGZF6AEPkUOns6N7ae8baZh2/PEqIjOO9lSxRbHB3bJ/6IAOAHSphwcrtVL3AYXYTw8YUdhnkS0f0YRxz69UW+SeknJ3sjEQL6nUFGlWWO3yPvD2Ib64fwTRRKc654X/Oacmnuo9GfrUNpkrn47Cj8K6t8SUbucrLjOKzVj5g3tZWcXzISwjOpcaqH+Bkrknu61HHdpt+uBB+ikonsuawagck2WQM8hXlCgPP+E7ctEkCbFXj3H30K1CEub9BSKIn1LGWoR1P317hgfussDzz5AeUupIjSVkeWxdvHTIn5f1699Ry9LVtjtMXHiCjo+TL7Ij3Iqoo03Tks7+Yvj9r5rAt0iY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafae071-355a-4101-c642-08dc6ac0f06f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:00:08.1462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oc6J/0OhgMfICTQf/cghcHn8UHt2UeUprtzEsbu7+dEgxPES0HR6V2KTesHkxfTdicli+w70/X/cSqLE8dKXMahYFTIoQVZjoXH+UDDTZh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_05,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020106
X-Proofpoint-GUID: Ri33p5hzWh4C4N48nz2JdY819XxRfjzJ
X-Proofpoint-ORIG-GUID: Ri33p5hzWh4C4N48nz2JdY819XxRfjzJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/2/2024 8:23 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Create the cpr-exec-args migration parameter, defined as a list of
>> strings.  It will be used for cpr-exec migration mode in a subsequent
>> patch.
>>
>> No functional change, except that cpr-exec-args is shown by the
>> 'info migrate' command.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> [...]
> 
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 8c65b90..49710e7 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -914,6 +914,9 @@
>>   #     See description in @ZeroPageDetection.  Default is 'multifd'.
>>   #     (since 9.0)
>>   #
>> +# @cpr-exec-args: Arguments passed to new QEMU for @cpr-exec mode.
>> +#    See @cpr-exec for details.  (Since 9.1)
>> +#
> 
> You mean migration mode @cpr-exec, don't you?
> 
> If yes, dangling reference until PATCH 20 adds it.  Okay, but worth a
> mention in the commit message.
> 
> Suggest "See MigMode @cpr-exec for details."

Yes to all.  Will update as you suggest.

- Steve

>>   # Features:
>>   #
>>   # @deprecated: Member @block-incremental is deprecated.  Use
>> @@ -948,7 +951,8 @@
>>              { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
>>              'vcpu-dirty-limit',
>>              'mode',
>> -           'zero-page-detection'] }
>> +           'zero-page-detection',
>> +           'cpr-exec-args'] }
>>   
>>   ##
>>   # @MigrateSetParameters:
>> @@ -1122,6 +1126,9 @@
>>   #     See description in @ZeroPageDetection.  Default is 'multifd'.
>>   #     (since 9.0)
>>   #
>> +# @cpr-exec-args: Arguments passed to new QEMU for @cpr-exec mode.
>> +#    See @cpr-exec for details.  (Since 9.1)
>> +#
>>   # Features:
>>   #
>>   # @deprecated: Member @block-incremental is deprecated.  Use
>> @@ -1176,7 +1183,8 @@
>>                                               'features': [ 'unstable' ] },
>>               '*vcpu-dirty-limit': 'uint64',
>>               '*mode': 'MigMode',
>> -            '*zero-page-detection': 'ZeroPageDetection'} }
>> +            '*zero-page-detection': 'ZeroPageDetection',
>> +            '*cpr-exec-args': [ 'str' ]} }
>>   
>>   ##
>>   # @migrate-set-parameters:
>> @@ -1354,6 +1362,9 @@
>>   #     See description in @ZeroPageDetection.  Default is 'multifd'.
>>   #     (since 9.0)
>>   #
>> +# @cpr-exec-args: Arguments passed to new QEMU for @cpr-exec mode.
>> +#    See @cpr-exec for details.  (Since 9.1)
>> +#
>>   # Features:
>>   #
>>   # @deprecated: Member @block-incremental is deprecated.  Use
>> @@ -1405,7 +1416,8 @@
>>                                               'features': [ 'unstable' ] },
>>               '*vcpu-dirty-limit': 'uint64',
>>               '*mode': 'MigMode',
>> -            '*zero-page-detection': 'ZeroPageDetection'} }
>> +            '*zero-page-detection': 'ZeroPageDetection',
>> +            '*cpr-exec-args': [ 'str' ]} }
>>   
>>   ##
>>   # @query-migrate-parameters:
> 

