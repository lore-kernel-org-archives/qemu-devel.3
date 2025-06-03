Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82166C61CE5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMSKn-0007Np-PK; Tue, 03 Jun 2025 10:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uMSKk-0007NX-CZ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:09:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uMSKc-0005xv-Pd
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:09:40 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553AExxG003907;
 Tue, 3 Jun 2025 14:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=3kH/dFuPnCCmn7tu2UuZocMxSCTl7enQfrMM2I/Nqd0=; b=
 JbmhMJ789tSIShKtc2L/SLaJnzPtR/9P4ptKF6pJsq3Vgm0HRP6pvAsRTR++1StC
 mFJAP3Vl2OrUwxDJKOu2Hg4tgHnCANuKrU2Ke0jbQli0nKs8O+IcX+51zmMREvGx
 fXnw4Pmm5u1SEdZ8e6HIZHDGYlAPVND96mAxJ/xJCSfAS1tWLZ1iHmL0eItRkfRa
 WoGzI3YeRbjKSaq4ty5oQteVfRXA8YylaubKDbKUfBlIlaCCuHbkfSSAFiM1tT2v
 OY3PmFHmj+IOVPZGy94VTag0nxNAu4+vxlxih6A5aHRDw4JPYfL0yQT/ESG6lWPW
 mXrpJk9MGVjuQASWG9WVYw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8bhxwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 14:09:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 553DHZZj038572; Tue, 3 Jun 2025 14:09:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr79e0tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 14:09:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJV+rk96En0flwnsqc3eUK9qutEkB0ihXPaQJ8SBoSYY2AAm5mJMIdvKd7uNNeCgxAvDXlNbRTp720uDSrD2u5KYoneJocx/eu/5Uyy5eGC6iWwSD4HmjXOB25+fmo5xw3wPcJfGd62nC1KG5DrpkUtuLnB6zlGiWjvOJ3p65/H8d2X5qfnBeZT4yni1RTybe3HjmI20EL7/ymivvqC+saEL/ADnBmG/OsjsKBm4j4Qoczb57z3D0NL8NhL/OVuNi2Xxd3v7VYn+08zbXxnX+iLIu1wUuxuXRCrabZBI0b+LuYwo+yrWmaKBHSv5TqF1ttbGjH5SRk28dOU1wh2u/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kH/dFuPnCCmn7tu2UuZocMxSCTl7enQfrMM2I/Nqd0=;
 b=U99R5WiNrJwRxj5bUK/BV6Cpe33knyiCeBjTCqzTby/H7a6ho66mDwbQBEpynk6MF6VlbnNAiKvGuPKb+HPxB2WzkIW7ZoOCUHmrejawbw/98Wu0TJLBFrhztDHh9NFUg22jkzNxdhJE5/mUWZjggZ+uCTNGcL2Bok0EpRN42GgCXI1Jx8NxCTmsdk2AsW3Ykl4sSekpy3M+YP+PySVMmTPvp3wP32DBw3bWCtO7ia8V+glRqsxDJt+KmCGjLfrtVCaM/o+qjShwtIN9WtRBYPvP2RvRJaUufGDAfec6w1UmESUXuklqrf7qM/yaLbIhAmex6X5ozbOuGkeie/PfTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kH/dFuPnCCmn7tu2UuZocMxSCTl7enQfrMM2I/Nqd0=;
 b=U5Udxk4qEHZ3XURXSAEomM8Q7AeKNFcJYRFZHqcEmVclBKMYqlrOi6iSCOHnCz61iHB6457kIOT4chxPghpmwJpS42uJjY7C2xu0UEBlWoNKiFgJz2tQeXUNxVZrUnYp0L7Plz4GaNLpAy71m6/333TVFEHsNS/wdY8yKrcfhmU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB6679.namprd10.prod.outlook.com (2603:10b6:303:227::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Tue, 3 Jun
 2025 14:09:21 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.035; Tue, 3 Jun 2025
 14:09:21 +0000
Message-ID: <124997ac-6c0d-4c84-8089-0df869963a4f@oracle.com>
Date: Tue, 3 Jun 2025 10:09:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/43] Live update: vfio and iommufd
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136B5264D8B651B5FB33F5C926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136B5264D8B651B5FB33F5C926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:a03:54::39) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 453c0011-e0c6-4586-073b-08dda2a83cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aENrNm0xNEpRUEpwUFVpSFR3b1hWNExpMDhJZm9sVDJ5K2srOUhycWZFUFlN?=
 =?utf-8?B?OERmMmlxTGphenFEMlEyT0s5eUNpY3NlNU9JNEJJQWRINVozb3ZHWFhsYk1Q?=
 =?utf-8?B?dXJqdnJ4cWRubE1DTUJ0R0VXMDJVZHQrYWpaK2k3bVA0Wk9ndWxNU1VTMVBt?=
 =?utf-8?B?akZNalJWaERhanliUTJRdXpyM3hFQURPblg3bG1iQTlBUGcvYmpHejMrZWJC?=
 =?utf-8?B?WVpVN1I4ajRKRVVnM2NoRTJPR1pNN0tpT2VTZmV0NEJZbEJ0STRyTkZMdjFr?=
 =?utf-8?B?RXRHaFV0UTBTZDVDc2wzR285WWlqZUZXSTJ1S2Q4TUl4SGNsMkZsbmNMdC9m?=
 =?utf-8?B?ZjFuUmo1V2FzN1pVQ090a2VjSSt0VnRYcmw3SDdBSDNMMWRPeWpjQXdOSlVl?=
 =?utf-8?B?YUJBdlY2QmZpWGFCNWErb2tGaVZWVFI1eGh6T3FOZVNZV1J0UXdBR1h1N1di?=
 =?utf-8?B?Y1VaTVhsR3IyWDFaWEt6RjhQaWk4RUxuTU5TalhKWVRSQ1VyY2lUZHZSMStP?=
 =?utf-8?B?YjAzUUtVM1BrR1VOY3BnU1ZCazAzTWdtMUI5N3MxR0hzSXRJYzhpeUwzVytL?=
 =?utf-8?B?WXYwZ0Q3TmhJRFVFMjBWMWI1cStTUlRBUG00ZjZlZ1dzYmZTZ0tremFnMHZh?=
 =?utf-8?B?MjJlNW5VR05wajF6NmZSY2RpczYyTi82aGJkQXBFZjNQa1dBaFJ4TUl0UnNC?=
 =?utf-8?B?TzZNVVV3TS9IdGpKTXB1dmZMaUJQRmR6blI4cjhTNjV6WmFHVENybmRaNzhs?=
 =?utf-8?B?UlV4bEgwOHVLQWNZd3lTcmZsMEJ1NnFESHdXQm43cStIZVhoNUdxZU5rL2l1?=
 =?utf-8?B?ZVgxNWlDQWo3cDJQMWtQdDczcFlMQWNSRVFuTnZYVzQ4N2NybEhuOVRQeW9h?=
 =?utf-8?B?bHRiM0MzcUtKcGNTOEtWb01VTnBtV1luY0YwVFo5MW0vcjVEVkhyRWNzcWZS?=
 =?utf-8?B?TVpPSFErRE1WcE12VDBxRzdlMkZvTHl1WDZSZUxPZStpWHFITmhkQXhsZWd3?=
 =?utf-8?B?TVRNQ1VSZ1BBdWVjVW8zb1RKdmpnMzdKY09KSiszRTY5Yk83bmRHeW1uRlp1?=
 =?utf-8?B?dHJoM3M1czJEYzlvdVBJMHd0YWhRY3hPc0s3YklsTHRVUEQvVFdBZHBkQ042?=
 =?utf-8?B?V3VOMS9ucFI0cTdRV29oQjg3K3IvYndVdlVCUmRYY3lwR1Q2cjBQK0VaN3Y0?=
 =?utf-8?B?WE52WHZOakMrNzE2SVMzcVREeS9ORTl0eGpWTkpGNnlrZXpxNjAwU3dkMmYw?=
 =?utf-8?B?TFFZa3NBeVY4cTlBbFp1VU5udlhFNkhBTW9CaEc1SWpaWjdNSVZjbXpPYVVh?=
 =?utf-8?B?NTlzblg2UVZpVnNNYklGR01HamQ2bkgvQVZTd2ltUC9pTzlBRjNzc21scitQ?=
 =?utf-8?B?aGN4YTE4ZWZMcTdvV2xyQUJWSmJZTFNXSzhXRG1neHgzeGRzUEpqZHpTV0xV?=
 =?utf-8?B?aW82Q2o5TExqZ1VBZkM3Tk5FcFpuaCtuWEN0N2REdnRMQUx2YUZjLzdUTHlo?=
 =?utf-8?B?VWVVQ3dJNWpYSmNkOWw4QkswZFozN2ZWUzQyN3F5SVVZaDB4RzNWTUhBUVhN?=
 =?utf-8?B?QlRLa3YySlNGVGFJMWVGcHovRHl5ZCsrSWdEaElCbkY1WGh3ZG9JSFFXZjZX?=
 =?utf-8?B?RHVNU1FBdDAzOVluSDZWd2I5R0R6MzMvN1c1VVAybi9iQUlqcTZ1RWZ1T09i?=
 =?utf-8?B?RkI2OE10UDVzaW1BWi9XakVzM1JySSs1Sk9sWnFJS2dlWFk4clFLRnU5bkhh?=
 =?utf-8?B?L0RNTlhlT0R6UUExQjZESmpSRmJ5cWczZmViR0dLUzMrSDBGZkhWYURrQmMy?=
 =?utf-8?B?dGYxYlhiQVdNZFpZNGNHZmlIL3hEdjdEQlRTSW5hR2Fla0pNQWIzdE9jS0l1?=
 =?utf-8?B?dXEwcXZ3TUZNVjM1OUtNRS82RUJWUGVVaS9iNGY1dEpqaFVUN0wyMmZDM2E3?=
 =?utf-8?Q?ZYcN03+7vu8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFYxMUR0SE8zR3A3Q1Z3TmNmSktzN0wwYmRFVzNXd1ZLNUJ2NG94SnhXam5Z?=
 =?utf-8?B?WVBTamJCeU9CdWRoZXBObzEzSWNmNGk4a2ZEckRycTlhYmxzMjRFbW81Y0Uv?=
 =?utf-8?B?dDF2d3NaYXlpOEx2OSt3SjU3dU1DaW5VSGdSSkdiaGxzY2F1Q2JWTlhPdVVV?=
 =?utf-8?B?OGNLaUpMTmJVZDd4MFlucWtEY1E5T2dyaU5tbVV0bjRRRnlsLzIrUTM1WWpN?=
 =?utf-8?B?UVNNZmY1RU5tQ0Uwa3J4ejFHL0JNdG95c3plY1phaHp3bXRWSDdXY1ZRUnBq?=
 =?utf-8?B?VzM4bVlrYXRvdWFzeDRhMlZ2U3VQanh4MGlQc1BJSURkeUx3VjhHWm5Ldk40?=
 =?utf-8?B?TjV3akNjTjU3eWpNb2g1MmFIYVVJMmg4YnpzS1djdm9GRzhLQWJiRXR6cjZQ?=
 =?utf-8?B?L0gwVzFtbGtzRWM1cG1CbjVSMDUwbjVZaFFvZGZ0dVAvZTcwM2N2dlhpR3Av?=
 =?utf-8?B?Q1BScTZvTnh4TWxIcThhemQ4TjQwNVNibzkxa1JGVUd2QnJhWG9TbWYzTmMz?=
 =?utf-8?B?eU9vR0VFZTduTWF1VlQrbGV1ZXY4YXQwb09EeUhHaXhJeUhlZ2hqbnBSbndB?=
 =?utf-8?B?WEh4S1hvMjlHTC9jRkZpbVhtbUVtZkxrN0dGdXUxeXhXOXJBajFuWUlCYUlF?=
 =?utf-8?B?N0Q2NEx2WEVBdjhNMXM0bDdDeVN2Mkt2ZVhuYWlkZVY4S2FtaS85OEdsb0lZ?=
 =?utf-8?B?NjUzVHV5T3lwU09tYnpLdkQyTkZ0ZHBqK0tiM3l5cmYwQmhyWjFOOFVVMXdl?=
 =?utf-8?B?Q3NXTmpkL3hGM3VJNG9KdGVkZnd1MXE5MTY5aTBMaGpCVm5rZFBDUUxqVTI5?=
 =?utf-8?B?eGNlRjNSdFJEZFRPZXNIZkJpbFpqWmMxTERHM0d6UEZhdmZvRnJGY3BYVlBB?=
 =?utf-8?B?ZUhNTXpMV3lsMmJnOG9WaGxyWEpWeG1GbFN6am8yd2FmV3RPdVRXZkk3QVdW?=
 =?utf-8?B?dDB3ZGh0U0ZvUTcvelFCOGtMRE9nM0t5RThJMFNNVHhYOFhDdktzL2o4Z2pX?=
 =?utf-8?B?OUIvejRSMU5HYWk2OUpmN2dTdUU2WHc4TzA3cHB1OEJhdjdDckJZVkdPUDJH?=
 =?utf-8?B?dWx5SkEzQnM2S25IVlMvZThxTDBEOE9zSTlWMkkyWHB3QUFYUjdNdFNud0xz?=
 =?utf-8?B?QkVwa2lRWEc0bFBXS1dIUlp3RG1KVXFvbDRyYnpQcS9HODR4WGRTdDdnZXVR?=
 =?utf-8?B?OTJrNWRYMTZ0U2QwSkFnZUdLWHVDWGtsTWczNzZFblVUMzJSdTRDeHFoNnRE?=
 =?utf-8?B?TnRmcjJ3SU1oazZLSlovdVRLNmMwWXJWL2F1b09pUC9lNFk5dEZoRDJteGxw?=
 =?utf-8?B?a05UaFduUmUyN29wamdsQXJVblJhUW8rUmxnSERLSXJ0RjN2SW8zcFBramVV?=
 =?utf-8?B?VzNnWWc2VG1aVFo1Qm1lOHYyZkVtSEZEdlNhL2FwTDZXa0lEWUY0dFNXSWw3?=
 =?utf-8?B?dWhRRE1kbTZrNHlKRlFiaHpsclBOb3N2K3hqaWx3SDR4L2hhRUh4Y0NHOWNv?=
 =?utf-8?B?d3F5NkhVN1hjOUdEb3E3dTFyeTNzbU1tYnZ2eXdwKzZKd29zemF3ZlB3bFRt?=
 =?utf-8?B?ZmoxRzVQdy8rTFVUNnFSWjZQc0hGeTdraDhla1o3QWRzQ3VteCtMOWRCc0pw?=
 =?utf-8?B?bVV4RGlwQWNXSERmcDl6eXVFRjByUEJBeE1WNjZKNkx1KzBmMWw0aGxDUHQx?=
 =?utf-8?B?cUh1UmFiZzlUYk9Td2xkU0RGRmxJTjQ2eWVBT1ZzNXhCbWhvM25WNWVCbmk5?=
 =?utf-8?B?RUNCR0JnRW1oZkN4djU3ZWVrSDJuelplQWdPdlkzTXhOY0dvdlNZUFJxTFRZ?=
 =?utf-8?B?eEZCRTlKeXd3RGRrazdqcTUzL2tpTjdRTlBpazBlRDlRNzdXczFoSUlndmlS?=
 =?utf-8?B?TTVHNnkyMmlnSmJ3TE11Tk9RbUtTYUJ2TUZBZVhLcTZSWElITkRxMVFlZHFk?=
 =?utf-8?B?KzN6c3MxWjVhcDczU0VtNERpT0ZsZzVsamtNMFZZa094cE5razhNei9oaXU2?=
 =?utf-8?B?cFAzSkQ5RkdaK0FqbXhqYzVhN2NNNUNXMkhQZm0yTUpWcWx4TVBENFFrTVhV?=
 =?utf-8?B?TXdLNlFJSzAvWXVlcFNaOVp4VjBzQmhMYWgvTElsVWFDTzhMa1d6MVMyeThs?=
 =?utf-8?B?NGlqZitRWU03VU9tRGZzUXBXYjVEK3Y0RlE0MTVYanB5akwyNkpIZ00yVERV?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +usRBLaRKa9wvp2eWPy81OlfsRayIWBu3eR5mQb/g/7MaUKCD0EDdXBL3B7+EABKf+jMFIYT5ni5UtRrqHb8HLltWF19lxPGa8VTbnOKnK7tsECh3DrmQttFBfSPD71HgEcG5OeoLFT2D+SY+Pl2FluwAzVOZj3nIBSBFr4NzOCB+1vXXZUmhC6Y6vtuMfo4JFxg/zlmh83NMlOxcmxVqBbq76ZSl+romXrmtqI4kiXLNiJToyNNisAIRwyvyXnkVy2LrMNqd64t1lMcmlFzC7n0rq2fUbSRxrol1aVDlASNZAiVEthtXuL5TOnSo77YU1DZKoQ9iJn8+jvobebaGlDNDYaK4IKV1i32K+KC1TN7jT+i4GHruvoneiSwKlpM0xr5OdFlVMkOcC+Nrj/EbXgfwAi5sI1Nypt0bjxa9SAv86Zq+4/52rP3UinTIycwdjXw74uwYwIWu/ySBgbiwiekrHWVKiKRzalQrkjHuBifwmTcRoQqd2IcrNPHABd1Jieyj8i1kVM6Y1XGW6pLn75Im7qPWykzYMlDoD4fxHrh3BI35dA659vNhBJf03Tt1qqW2keb7M4adUsX2TPm1OK/w6BTvnUe6EoYSvSkOhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453c0011-e0c6-4586-073b-08dda2a83cb4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:09:21.5781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQMIYUshaNm1jQXjqdpjKxhRy5Tu42Z/uDBPgCZvcxi5PtplS49QLZiy9KzkjskAGiE25lggInreTt9PwxrzKVpgm/qqB9sC7kc03XdQrIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEyMyBTYWx0ZWRfXzQrBB/m3swvf
 Uu8xx0kYjEtvFcBNCyMbbquYuzZYjYFI+9WMxzdaO9n8jnNp0bUi2H++8xyAcWebm34P46vBin6
 4+IIFec8OvrR4RFqFKxfDcEMtogTEMIrLFrE+qfOcqEYmwfG8wTP9Ret0LzBFwtloisRjzQ36lC
 eHn9ME2LTDVo8+JJryE2qI1oZki4iBJzbQVu2hLCOVwQ7qe03TXl0YxshtZ0xgT8hAPwOdHksbd
 AnXwEiazCcgs3aOuCJbnKU5jDatfAmKLMuyPwyvX0891lejKhV/eaLIvoizRheV6rSZ6f07W36M
 jYIo6oDvYq5+/E8snK3Yndb5P9ZaQIe5r8xVsnNBh4auVQvfn1uT4GEzJ44WlAgStEIodAjFR7R
 RAa6+QNOPSa24+4wqpWEx8W6dMxcZ5daEdd35xh7RshimMBX5ioS9Z0aCV3vy78VqJbFkTf3
X-Proofpoint-GUID: Im9cKERunwxu9dBltmT3ncLeHR-0g89b
X-Proofpoint-ORIG-GUID: Im9cKERunwxu9dBltmT3ncLeHR-0g89b
X-Authority-Analysis: v=2.4 cv=H+Dbw/Yi c=1 sm=1 tr=0 ts=683f0216 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=otaNSMoNpq1j5l2he0YA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/3/2025 8:09 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V4 00/43] Live update: vfio and iommufd
>>
>> Support vfio and iommufd devices with the cpr-transfer live migration mode.
>> Devices that do not support live migration can still support cpr-transfer,
>> allowing live update to a new version of QEMU on the same host, with no loss
>> of guest connectivity.
> 
> Just curious. My understanding is: for device not supporting live migration, device
> will not be stopped during cpr-transfer and there is no device state saving/restore.

Yes.

> But for device supporting live migration, it will be stopped and device state is saved
> in source and restored in destination, it that right?

As currently written, yes.
However, it may be faster and more reliable if I disable savevm_vfio_handlers and the
associated notifiers during CPR, and only use the CPR mechanism for preserving the device.

- Steve

