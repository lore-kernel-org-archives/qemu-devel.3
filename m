Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEFBD24442
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 20:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syzRg-0005Jl-1B; Thu, 10 Oct 2024 16:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syzRX-0005FZ-TA
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 16:07:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syzRW-0003EO-Ag
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 16:07:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtdpV012147;
 Thu, 10 Oct 2024 20:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2023-11-20; bh=Kzf74o4M92NVaHi3
 /THlpaXfYi2wsTB9qBNa7i6SQIo=; b=ILdjsIlPJjPPVTlInrQZnQG6sLdvGpbl
 iVyZ0cfkoStpEG0I/JJZl3yMTq6iupo8DGq3o2J4yvGdrBlf2M1kuK1nI9nA8lmw
 YvC7lbKMeAtQmUI7Op5zvMo/+izUa5GiHRZDNjtbYctwM1HS70Rer0Ta78/s7Rja
 7sOFUhpoi/G/RZK+6BFRfiw1SS3TFIJbNaxVqkUWOTGbGEtJuz9oxYFjcyuVuX4Z
 BjnLON6Yg8KeSHULq1RmicX6PTCqgtPwps1XHxjoLql0KDvRN+11/eOK2usisOQP
 kYr+KZP31OZAFVNWrDH3BxBBjRnzUud/YktnLbhdfDt7jZKvoo2Ssg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pkf3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 20:07:24 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49AIYSCt005826; Thu, 10 Oct 2024 20:07:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwguueh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 20:07:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEewA2vmXkkoHhcIP9UWvYNw5PaMpyST60Qyj+Av/WLFcCVPTYAKcdpI4r4ginI0ZKH0CommzfnzQt5ITqV1sjAO9Y/w5nihaPqsvdnoWOYQuJIJrpM554v1IC2J7Wpbz9uB0vZOh11LfBv1qTp+DBhVuYo4VJ8hSOTA2wg+uG5Au2+hEVvb5f+yDu9VaFI0N8HxSEjEjqocf8DgRcp1fe4Z20DHbgN5xG6U3VFW+3X3MANG0hNjsVhFK4ZKsw85puT2h4v4v7gkg5XbWbXyOAuXR0Ee7JsBzm7mdXLAzjwN2FfXS1m5U8YBIDLxh9CdUHgk/Io0BillVPr0wR45cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kzf74o4M92NVaHi3/THlpaXfYi2wsTB9qBNa7i6SQIo=;
 b=aj5f/56hxPW1hkWw2etqL8/V564wLn9PUU63PaPG/Wsv1I/KxsrSFVURYeJiYNdKbyhnayDCY9epRwmufGjYIqXhKJD5gcIRVAD2t20jeXaJzGIfajmussPctR7Ww3MZcGzygtF+E9KRePHNgKotAboGMJEKF+WlhiRVIoUr3z+P+qRv0Qf3Myicd9sPq8BPNehhylP3ftCBZ7XcjF9kBxj/EbjGD/gpXrWDHvZJ2ggYJI7dI3Yc2uUZYvgGgF9DyhJoR18PjnRcv5bEj1KDBisHkDMunns5hbecMuxFMWjRULR27UEYmjrRhE9/ueTAafYPqiFpEVcDRx6oQ5FM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kzf74o4M92NVaHi3/THlpaXfYi2wsTB9qBNa7i6SQIo=;
 b=yvjVKGlyipTucORTRl/wRXPq6r6wZ/HN69HkuRhi5Uyz5ud02pKbW+SCL/rUYmAjdxLmVXuLqQnLjbdRcKho8AbBooUK23wgVuJzXoDarjrSqLnrtHZqCsXjVyWHO6jRx9rR/UQKB2TEehsvU4RcK4cYGNWQ5o15DVM0QrqXBhM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB7814.namprd10.prod.outlook.com (2603:10b6:806:3a7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 20:07:21 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 20:07:21 +0000
Message-ID: <b57f8eda-d0ec-469f-8ac2-635f3c8d238b@oracle.com>
Date: Thu, 10 Oct 2024 16:07:15 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
From: Steven Sistare <steven.sistare@oracle.com>
Subject: precreate phase
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ebda22c-7e20-4065-6231-08dce96725fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWM2TUtncUg2TTlFVHUrdytPSXlLQ1V1eUNPMXk2bnREZlhSdlBZRlp0dHda?=
 =?utf-8?B?ak9rYW5IMHFTaDRQV0czTUlPYlJBbitwMW9XblMxTkk1ckMzTEwwdGF4cWdL?=
 =?utf-8?B?MlpQenZLaHdvdTJzTFhkMjR1Zk92dlFkK0c4Tm1xNFhaT1ZjaStUakZlcFJF?=
 =?utf-8?B?alJzZm00azgrbWxqU3dSVDJuZDJZTHRwbWJuOTFBcXdCV2VVcmRIYXl5WEdV?=
 =?utf-8?B?bCtGN1JMSEdFVGRiWXl3VWNuS0MzNTBmT3pqbFFTWjVHdDJqSVRYRDQ2bUoz?=
 =?utf-8?B?OVowcG5sSk5XKzRGblplcGpuYkZUVXV5Zk5Dc0w3WVNjTUhzeXp4RG1qajc4?=
 =?utf-8?B?V1BmWGpOSG1Obm5MWFVmN09TYStEZUZlNWh1R2FQU0FXRmVXaDVRdzg2cWN5?=
 =?utf-8?B?eEVZcWJjSkdqbi84eGQxb3luQnFiRVV4ek5yMitIeXBXeEUvaEZQVUJYWTA3?=
 =?utf-8?B?WmRKNzh3VDlrUzVTSzBLUG5Gc0xtblhPRWIrbEFCc1ZkeEhNalk4OXdiMDRn?=
 =?utf-8?B?cEZvODg1QVRFbVdQbUVObFV6aEFTTWxSRnFJd2Q4SHc5aVJUallQMkNpdXlo?=
 =?utf-8?B?Ym1CQ01wcHRTMEhyMXpaa1F0V2RYL0JtUmlnTzYxZXN0LzBoNXpZRFdHN09t?=
 =?utf-8?B?dVYxa3N5eEZjQ0lhdzUweGNNaDZKd0pRS0dhemMxb0Nkc01nZzA1V3VwZ1Zp?=
 =?utf-8?B?RlhGRVlKZzdDUHBxU01xbWhTWjdsc3o3dWFjSm1UbGhxN0lwd2ltcjJZRHM1?=
 =?utf-8?B?QjFFYW9CMHdOaWczdVJuWW1SRlNpUEp3QVlwMU03SVFvVU1rcC9tR0txaEtM?=
 =?utf-8?B?eEpLZGVJN3pCa0NxQlFTeDJlcThhTExDY0Y5UmR3VGlPbG9IQ3ZldEt6WG5S?=
 =?utf-8?B?bS8wOWJyWE1Zek9IVnk3MC9SYVRGRnRGQVFTSVZJNWtaTUo1d3J3dENaL0R1?=
 =?utf-8?B?b3lZenlmVzVVbVBxbEhOVzdJcW9iMGludnZtWUNIUjVXVGpWVzRHNjFzYzBq?=
 =?utf-8?B?K1FjalExOUNkRE91UnovSFFmNlE1MlMzMmpaWGVEeGQ5YlBkZ2NsRnpMc0FD?=
 =?utf-8?B?TGk1YjN6d1YwYWJEY2dZdXVzMlpRZjNkbEkwNkxoZXU3cG1ubDhRVDcxZEZx?=
 =?utf-8?B?UTN4N0N2Z3dYQkIzSUgwWFVTMHgyWjlHR0ZEOG5laUx3U25nYXVmR016NitX?=
 =?utf-8?B?cUJ1RUNnc2hXSWg2VjN4M1UwMXJxaHEyRzZianFBdlZLNTFwM29PSENjMXFJ?=
 =?utf-8?B?V0x5SVZBSzIrRFRoRHk1L1VzbVNyTWNiR2FCZk9PUWF3eXhqRHVrYkQ1TzI1?=
 =?utf-8?B?WURQZTNkR1I3OUprUHlWU0Qra1dHQk52N2RWRGhRbmxZaThPWVphSjNPNlRB?=
 =?utf-8?B?b3hmTTZKMklaTkRGdDB2eFJIUHd2RG5HTkU2RExpcjJPNHE3SC9wQmNOZmtW?=
 =?utf-8?B?WnJmZmVZWGs2OWgxc2JZSGtrNkFTR1MyLy9RditVZ2lZSmVSb0F6cjcwblB4?=
 =?utf-8?B?UkpaSXN5RDd5N1h0VEk2WUs3RU5kUXFyakU2QjYzYStwaEg5RE9wSFcrcDJ2?=
 =?utf-8?B?aXZBSUZ3ZFhXNmVST2pRWVZ5enJWL0Y0U3JBeXNMdTVqSUxxOHdHcjBXcHQw?=
 =?utf-8?B?RjJxVDBUaUorbko2NmJuc0pxajN5cnJLcVljcEIwWTBNK0ZPa29TTzdVaEQx?=
 =?utf-8?B?WkMxRTU4dFphanNCQllpTSsrMnJCei9rSnpIQS83K3IrT29YUWdiWjJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE5mVmNyNlhJYWVRZWJ6Yk9OMUFnUG1SejBoeDhMWDZ3b0hVTVFiSXFFVWxj?=
 =?utf-8?B?MDcrRVhsMVlDZHM2WHlFQWdaWGQxZ3N3MzVIZ2tsbm0yaFZ4ZitidXV5eTJp?=
 =?utf-8?B?ejAvN0RpQVJCUmtpaWt3WkVuWTJPeTUrWldPWGRYRWNXNWl3S01yZEdWemQ0?=
 =?utf-8?B?aEpNdE14ZnVDSUFHMGI2aFlBdnI2RGFZYUtZZFZ2UXZMdk5IKzFtSk9zQkVR?=
 =?utf-8?B?TlViQkJiSW5ycnhnSlhlUnVYUlZ0bytKQTZDckU0SlFRQlFyYVZWZzRIRHp0?=
 =?utf-8?B?dytkMHg4cFdsTUtFNW9DSlBQSUdnOTR4ajJHaU9DREF2MTlGa3lmMXY4UXhx?=
 =?utf-8?B?ZlRoYzVQQlk1UWl3RStBMDdheFhHQUVVejI2MGM3eEM3b09zMWRBOXFKT2dC?=
 =?utf-8?B?dUFFb1hIcGUyNDEzbGlObm5ETHNIYmtSa25sS2RHZFpVZ3JScjVueGI0NjEz?=
 =?utf-8?B?SWlpQVN4MHJCZ3JPTkFxWkJqRzVMUTZNdUlBcWVqcHpiRFVTd0tXSnlyQTNw?=
 =?utf-8?B?MldZblh2cGlVbnVoeGthMDBJdThmYjFMT21tYy95c3ZYQ2QyMU1kVEd0SlVB?=
 =?utf-8?B?dkZLUzgvZjVDWGY1eXcvb1RoVzhoTFdhMDJKZnpFbjRHdXhwd010R3RnN2w3?=
 =?utf-8?B?L09ub3Q0WFlqQnhYYWNlZlhFNnpFU1p0RVdDSjhib0w1a0xDOHBrZlloOXVS?=
 =?utf-8?B?NlpadlRRY1ZveFlJUEh5YTBnZzVDZ1hMcU16aVl2NW1tQ3FQckV4VEZFbFNi?=
 =?utf-8?B?cUdWdFFjRHVJV1N6REdjQTZueUhFQmpGeHdqcTIzMUI1ditZeC9Edm9Kb2lQ?=
 =?utf-8?B?SkprMGdKbnpTSlBnTGtKZlQxWG52OGxXTlIrSnJ2WGUvOXRoYldsTStZTnU4?=
 =?utf-8?B?NHFJcy9oamZVdXY4VEhaMHRLY0xEOHVaQjdwQjRkc3hFSHZSd1hsT2lCdlNy?=
 =?utf-8?B?MXNuZkpOdE85ZFZnWFNYUDB1SDJYMjNTbyt5N2NrQlVOT3VoRG1ZRGdRL2lq?=
 =?utf-8?B?M1ZWdUo5ZWJlU1lYRUpteWhqeGg4eWgxSW5aZ0pvdFhObEp5UWZXN1dkUjg3?=
 =?utf-8?B?VUtwblArWXpLT0xUUkVVK3JNci9wYnVyRERPcUhId0NuaUZpRDgxUzdveU1J?=
 =?utf-8?B?QnhwUEk3REVIRWMycWY4UXNFTUZiQTJZUnU0NG1VQWpxb3pZdWN5endaYXZu?=
 =?utf-8?B?UXBoQlJ4dTV5ZXZUc3AvbDFTUTJyTTF5QTNKc0VrVmpYMjBYc2xBZFU5OWtt?=
 =?utf-8?B?cEFmWlJoVUR6cDBKM1B0MFdETVIyemdkOXNzV0VwVE1tWG9nVktScmllSFRm?=
 =?utf-8?B?anB3L3JTYUIxczZ4c2ZBZ0VMcCtCSmF1TmFrVUZiQjdGd0huTkV0OWRMbzRY?=
 =?utf-8?B?ZytCeG5nRlFqemw4dUNPUk1PY0pFOTR4emE0RWoxa1UvT0NMMGJlRWJycnNW?=
 =?utf-8?B?alVqeUhseGE5aFRwakhvSGFCMFNIMGJINTJUVzIwazA4OCtzLys0Mzk2bUFv?=
 =?utf-8?B?QUo0bnZDeFhiTGdHMmFjSmdHV1dLejdxM3lOaUxnVGpxY284M1BKKzMrTnVp?=
 =?utf-8?B?NmtKcUVZclJHWUpIUmVlY3l6Z3RmNUYreFplR2U1VXBZVmdjblZndVF1eEdB?=
 =?utf-8?B?alkzVzNuQ2IxK3FJMEo0bEJmVWxZcHhmYkZURFJzSnZjU0NSMlBMWlRiKzU4?=
 =?utf-8?B?MXhTcnoyS1pNZXJaOGxpbjNnQXFyVFVKQkwxUVVsMmVtVmo1WGU1K1V1ZFFL?=
 =?utf-8?B?NnE3bFZuRjFYQ0h5SjV5ZE1iV1k4ZWhZdDlMb3U4NWIxclFwNDM4SlIrRS96?=
 =?utf-8?B?SUUzMW93cUpSNjhpZ3lIQlZrOUswbnhaZGxWZnd0WjJvejJWb2g5V05TcE1R?=
 =?utf-8?B?bWh3a3lWbWZSUHVackxnTmZJRWJuWDVFaFN0NHVOS2RCaFdLTVl1Y0pJZEtX?=
 =?utf-8?B?cGpGTWtMZ1FNSUpSWUNJUTJHZ2RxN3JpWmNZNG5uNkdOYXFyRlRINTFRZ3d2?=
 =?utf-8?B?b3U3Y2xHemkvdVZrcDUwbjYybmNBQU9INVdFV0R1aTlkRzNJVjRtb2pzVG1V?=
 =?utf-8?B?N0tVejJqZzRNcVhrbVRWM2EwSjhwaTVRZjVEL2ZCRVowRHdDOVpMS3pTRFV2?=
 =?utf-8?B?YjlualpRbk5GdW8zU0RqV0xPelRwb1V1Wkc3Q3VsSTFoTGxtUmVJdjZWUE92?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zPbpes1Id2AOaGebz9gRTclw2x5bM1j0sD+JI79CWjb+5J87xfSLhvXzDFyy5LFWqCrnizzl2ayMnw9QJQiWbrfw/9SBHcBD6YwfuoS0DCnbWF5ZytXwQVZJ3Rru4jw4TgOTl+doPzA9GxobtuThrn0qTn2/Wx1E18DxmlmgqB2YhxUQUJjCo9mVNsmI5pK0yNtqxwkwPXfK8x7OXvivOE+VGQNDjfZju8Yt9RzPvgxQ0oxrsit9ts7wUbE4QxpJ3BPjeNq/7ItnYuwsM96Umbc+oyvuwjfOzZIP2zDQMhGLnq2vw64WhPL1XLfi3S+1GtJ9K3PBcpeCoIMaYKTBbrIIiC0amOEUdX6+j+9tbaiuiMmO0OXUQBQMyhOOzIlaD4+8/Qzhu+ojgaU4FZ/CwgKkjrz3Vnq795On+Baii/u7u4SKmZXLTAfR38xzSseALZ6xz5wkV/K8To4ykR+DVxaVpBN0mk6E6zwJtllhNKKmHSQH9Dj3VdMmk4ab/U8b7X3dl/4D/aOYd2ibLDm1921qns4rOPvHOeqBjNNvHk+HQYM+OvcNu1UoWTsmoeJL2BGp+PtEs6dxvwqVbI9Ui3H1at20/EAkE1L2hnaSCKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebda22c-7e20-4065-6231-08dce96725fa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 20:07:20.9323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fj6RUohSjYxFUx6bjeHR+FniKDLTLzgkwYFmJt08HWg7aAmnFBJnpHXeVzP73E3OJjpN4gABQxdPXlOBP8QHma+ObLAPkMEKOZqS970kfHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_14,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410100131
X-Proofpoint-ORIG-GUID: -w85ZOHRY-TXrkjVKTEWG6cqH4g4iELJ
X-Proofpoint-GUID: -w85ZOHRY-TXrkjVKTEWG6cqH4g4iELJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter, Fabiano,

I have a nice solution that allows dest qemu configuration with cpr-transfer.
I define a new qemu initialization phase called 'precreate' which occurs
before most backends or devices have been created.  The only exception
is monitor devices and the qtest device and their chardevs, which are created.
I untangled dependencies so that that migration_object_init can be called
before this phase.  The monitor accepts commands during this phase and can
receive migration configuration commands.  qemu starts listening on the
normal migration URI during this phase (which can come from either the
qemu command line or from a migrate_incoming command) so the user can
issue query-migrate to get the socket-address for dynamically allocated
port numbers.

qemu enters the phase if qemu is started with the -precreate option.
The phase ends when the user sends a precreate-exit command.
Qemu then calls cpr_load_state and reads from the normal migration connection
as in the existing design, including the HUP.

(This sounds like the preconfig phase, but that occurs too late, after
backends have been created.)

I implemented this scheme for another reason but abandoned it, so I need
a few days to rebase it and test.  It is not small, and requires approvals
from additional maintainers.  Let me know if you think this is the right
solution, and I will revive it.

Preview:

   0725d70 vl: precreate phase
   edd2dee net: cleanup for precreate phase
   4733c00 accel: encapsulate search state
   6d26ea4 accel: accel preinit function
   518e737 accel: split configure_accelerators
   8ef936b accel: delete accelerator and machine props
   b5c2a84 accel: set accelerator and machine props earlier
   56890a0 migration: init early
   76506b2 monitor: chardev name
   e85111d qom: get properties
   8356f7e qemu-option: filtered foreach
   fb6cc98 qemu-options: pass object to filter
   bdfec1b monitor: connect in precreate
   8f2f292 qtest: connect in precreate
   629cb50 migration: connect URI early
   0ae530e migration: allow commands during precreate and preconfig

  accel/accel-system.c            |   2 -
  accel/kvm/kvm-all.c             |  58 +++++---
  accel/xen/xen-all.c             |  11 +-
  hmp-commands.hx                 |  20 +++
  include/migration/misc.h        |   2 +
  include/monitor/hmp.h           |   1 +
  include/monitor/monitor.h       |   1 +
  include/qapi/visitor.h          |   1 +
  include/qemu/accel.h            |   1 +
  include/qemu/option.h           |   5 +
  include/qom/object_interfaces.h |   2 +
  include/sysemu/sysemu.h         |   3 +
  migration/migration.c           |  31 +++++
  monitor/hmp-cmds.c              |   8 ++
  monitor/monitor.c               |  21 +++
  net/net.c                       |   4 +-
  qapi/migration.json             |  16 ++-
  qapi/misc.json                  |  23 +++-
  qemu-options.hx                 |  13 ++
  qom/object_interfaces.c         |  27 ++--
  system/vl.c                     | 291 +++++++++++++++++++++++++++++++---------
  target/i386/nvmm/nvmm-all.c     |  10 +-
  target/i386/whpx/whpx-all.c     |  14 +-
  util/qemu-option.c              |  25 ++++
  24 files changed, 471 insertions(+), 119 deletions(-)



