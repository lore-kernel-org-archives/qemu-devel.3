Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CBCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 18:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf1mR-0007Fm-I9; Fri, 16 Aug 2024 14:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sf1mQ-0007F0-3s
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 14:34:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sf1mN-0002NM-TQ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 14:34:29 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GHtY92001025;
 Fri, 16 Aug 2024 18:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=W3a9sDmcPddfgEetUAgiy3BwweChvDzPx8bT5W16x1k=; b=
 nGnCRTcE8UgRs+zbMok6MnrlpXWvU5ovKseAWj/jv7RSC+E5BV1IvFpaFkQEsGAP
 jw17H3R8NooyU9D1q0Rtu1qHekFtFlKEDBfSJCUC6+zVJE6fOgqzAaqbzphHJbD1
 k5v90m+mRANdJp+OSU9dUuN7UubUnFuL70ny8q08ifjTEY6uG42bls1LMOo/8X76
 SEPgEnRdWyG7TpJAQ6c/9YkUmX5OhG7tb5UbWupnxe+RVsvDeM8Jz2Adr+3AMCRH
 uZ+2sE4iGcZSRAdbgBOJTz9ypPThF+bN2A3gegkaD9WZFHlFdP2sQ1Gbk6bTLCs0
 Re9/drn6sCZ/9Y4nvBIa6A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxmd50wk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 18:34:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47GHVnMt003446; Fri, 16 Aug 2024 18:34:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxnckhps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 18:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hndXXcPphhjQk21qCa4oTjOb1vjfsPdqk8vcfvnLa01ZPTT2ytUFklaOuWaYq845UwEbqeOGUUkSIPqhMDPSk9kClulQUNv6sMd+Mpka2wYXvKJHvnwDzgFRcjmctQzZCLTiA2TNrLZhtzJQXLfWduDysEZ7E3GHgs7iMWolyc//RRGhH1kHtms2M4uxoehP/iOb5v5g/PQ5pRA0JHxP10L74trKu1ST1B+b8K8HhYc006IXRgd2db5HgmLN5BjIQm7hEFoaoqhEQp7yifjadwqWiJQKmZ98YsQuGKEOOGoOg1OcKp4Y3HtrFfExHA3TguKKxzgfH2p3VV8okcoJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3a9sDmcPddfgEetUAgiy3BwweChvDzPx8bT5W16x1k=;
 b=XjpDp4sBQCo8HX7E3brNXiWmqn249EWCeT2R4U4XpqY2yBNyLlIwXwRyiqs7ScmHi1CzGTsiXT2ZHTu7vGNJudevCOyu8jk8pzLI3kwbmeUhC0kM3BJUjKwivjL+etaK6XA1EZz5b04wqpe/WvSvQjHV5BonS4hUjLPh0+mrVqVHxpmTgc6x7uxcdg1jOS1PISXhDOO2J5xgeTknbSG71Ak9ma3+xHF8VV8Y4kyJwqhFEsXt2MDl46cjZD+RJVZNa8JUMsHcB2tbv0Cj/fO0Zzk/SESBfbOEv17nMslT3C7W7tAKRHIfbPuURUvWyfKAXHi29lodMbY1XRAor60W7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3a9sDmcPddfgEetUAgiy3BwweChvDzPx8bT5W16x1k=;
 b=Tg0PsqfXyK4xZEhONKJabGtwd0QV02jqty4a1+05v5mULd1j96UIyz0a5hoBuJISTIdIqoDmrJsha+gjOFzNJEFgf4IeE95uwE1jQzdocHkjfsInObFq205lk6y4NaBA3QFpX3CutMPQh48qOQYvWcjTHmB9LFAjKWgEnW7v8nw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN6PR10MB8046.namprd10.prod.outlook.com (2603:10b6:208:4fe::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.9; Fri, 16 Aug
 2024 18:34:22 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 18:34:22 +0000
Message-ID: <dfc000d3-3728-4d1a-9558-943438abf2e6@oracle.com>
Date: Fri, 16 Aug 2024 14:34:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n> <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
 <Zr5lC9ryCsn9FjE2@x1n> <94478262-034d-48db-bd4d-c74ca3c315a6@oracle.com>
 <Zr9u1YV4m9Uzvj7Z@x1n> <Zr9yGoXBpHIzrDak@redhat.com> <Zr93bOr1zrSZadf5@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zr93bOr1zrSZadf5@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::43) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN6PR10MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 40aba1f6-a0d7-467f-ea17-08dcbe220c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkNLVllHbTZHM3dtSEZuM1lXby81VEoyU09RWXVVSnRCOUFwbVBkUk02YUxZ?=
 =?utf-8?B?em5qQ29jOW9BbmZVenRDdXhNdlVwQmUxMmZrcXo0WHRMdU1EV0ZLYUFCQUht?=
 =?utf-8?B?QUR4LzNhK2JzMTkrb1NtckFWWEx2Y3dncVZXWEpnYVNWSFNrNm9XWGdUL2Ey?=
 =?utf-8?B?TThzR2VBSCtoMzBPb2pSU1kyeWxyeU4rNGsrajhYVFZ5bTRlYXBCaFpiNWFp?=
 =?utf-8?B?SkFHaXUyc0NvNXViWG9wSFpXYkVCd3ZMNlN0WnVVSWpiTUpaN2gwZkNjV25V?=
 =?utf-8?B?OGQwclZxa1gzWG5NYVMwMmtXY1pXYmx6U3QrdHVNZ2RZc2NMYjB5bUZ6UThQ?=
 =?utf-8?B?MFVnWUZWMTM2OVcvWnhCWWU5UHVjWlh4anV5MHh2dWRDaUFUSUgrVkRWbk1O?=
 =?utf-8?B?K0k0M05SRkNSWTl1ZGkxM2I3a3ZTWFl2aEovbllMTkxXazZxTkJSa1cxZEV0?=
 =?utf-8?B?MUlqa2hxaGZ4Y2tNMUVSbVVUVCtuVEJtT2Vtd3p6Z1JxMlpNQUgrUFl4RFZM?=
 =?utf-8?B?K214UDBURUwxdU1QbTBkbFZTQysreElKNDlySmwwLzB5aFR4M0xjS1VFYXcx?=
 =?utf-8?B?aUNjWWZtcjBEVmFFYUJYckNjMW5FN1dYTWZGanJ6cVE1bjAwQkhTM2VtRjMx?=
 =?utf-8?B?cU0zSUh5R0NxbDRjcTduZ3FFei9FRE53V1BYMW1UWm5DOWtzcDJuS2RxUEN1?=
 =?utf-8?B?R05QV1RQZnBGZVB6VGlDc1I3ampRbE5lN2tTaytTVUt5YWpUdGFIaXFqSGRr?=
 =?utf-8?B?UFdNM1JkZlhWSWIzNUhXYm9xcGp3U1h6WUNnUXZLMlM4QjdRMzBaSWxDVHJM?=
 =?utf-8?B?bXhkdWRRREZkQTlpM0t4WnVURG4zWFZPbmVUeHJHSFE2MEdKQTZyTUlxaGRv?=
 =?utf-8?B?QWdabDAwcldicXJoT3R0UnZnR1h1VEVnYVBjQUFwZEFTTldEaFRNd2NQajVr?=
 =?utf-8?B?dk94cXdsZitjWHh5Qy9iaGpTS1FSSUE1RFJ0cmhnRG9Vd1JwUWFZVVVEUllk?=
 =?utf-8?B?OCtMRGZvVEpWT3VUWmRObzlvMytZYzNzNzh0bXByUkM3Tll3ekpodU0vaWlt?=
 =?utf-8?B?UXNrS005YUF6aENIN1pyV3lNaWUxcHJpZnMrMm5yUXhjZzJRRTJQWGRrZFNk?=
 =?utf-8?B?aWZuY2xQaFZGV09CSXFNeTNuakRiaFVzbHhvRGp6RU9yQzcvVHJ1ejZmUTZC?=
 =?utf-8?B?MXN4QzgvVktqd2Q3eGZDclVSa2d3eHJwa01nd0U1Umt0Vmhxa2t5WmZvQzZa?=
 =?utf-8?B?REd3dTVLUmtYbFFFdkJUY1ZjMnNsMmorYURSQnY5NlU5MW1pcFRyVk4xU2g2?=
 =?utf-8?B?RmZqektYcG9XUVo0UjVDT2dKTW9Eb2hSOVR6bjhCYnl1WVp0ZTJzNmpKZ1J6?=
 =?utf-8?B?K3dESTdzZmxCaHphTllnYTNBbnlzNnhYVTJza3MrUXNYK29EMCtvR05zZkN2?=
 =?utf-8?B?OGtIZHpqSEtBUVNqdURtQS9zdGEwaGdhbG9jUW1kdFJuL0pmZmMweEZRY2Jl?=
 =?utf-8?B?RnRia2lNbEUzOEw2d1FDSkdEOUJjNVFHZjBZNVYwbnJQWG1XMjkzckFuTXdT?=
 =?utf-8?B?VExDMVAxOUNFZi83eUNXRmVTWTRVY1BTRXpoT3JiaDVUejU0RWtwOG9rc2RF?=
 =?utf-8?B?Y05OTmVZL1B5Z1NZaFZ6Ylo4VmJSZ1pmK0FXMHpjcjlPbTRtcXMrK2hkcHVN?=
 =?utf-8?B?M1pEcmd5QWp5N0RBRjkwWkZWanZSYmh3a3hhaTgxTkdoWjJQc1dEVFIwck5S?=
 =?utf-8?B?bUc4OTlXTE5WR3VFdnQyMGo2Wk54emxqWk1MTHEzNTBqZHh6NkNqa3FqYjFp?=
 =?utf-8?B?Rmd0N2hxaHVzc3hsbUUwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NksvbzBNbm9ma0Y5NTg5WVozd2NlSE00UmtORzFZNzdpVzM3SllqckoyQzk0?=
 =?utf-8?B?cVdzSlV0NG1PSnMxTXl4cVpVckVnMVdyK3VERlNQVm9meGNWRE9BQThmNE1R?=
 =?utf-8?B?TVplQitlMUZSWGFaMGZ5UnFUL0JZa3Q4UGR0VlA1TDBUZXhQd3hjTGhGTHhS?=
 =?utf-8?B?V25DNEVnS2VmVlBzTjB4eHJ0TlhVTkUzTm9SVXFRZG5MUWVaT0djeTduUjBo?=
 =?utf-8?B?T3l4RC9lVG5KeEJib3ArdXlLelZGZ25kNEdtS0FxMWQ2QWZmbkNhQkV2OGQ3?=
 =?utf-8?B?NDBQZVAydWFWWXJtRXAwT2RoR1hwUGdrVnhYbTFPSnF1eVZjeGp4K2t3bmcw?=
 =?utf-8?B?NUVFSFFxMURvK1BWcmZFSjBjOGtWVFcwaUNwWGkrNklGREhwb2o1YjJmS1JJ?=
 =?utf-8?B?TGdqLzJqYnJlRnpFdGNhT1QxVVZ6UXlBNW9xb1pZMU9TL2RvWFRxRDNiN2Fr?=
 =?utf-8?B?aVBCQjJTcTY4aHhGcjRnVHhqanZGeXZkRlhicUZiemhXMDV1NVpwalczeEc3?=
 =?utf-8?B?Y0N5Q1BweEI2YTBhMjE1NmRqWk5FclFjWGZIa1lYTGJwNWxqc3NqUmpBT0N6?=
 =?utf-8?B?Z29pbmJIMVYxbWpGYlgrUlh3MFpWRjhwT0Y1NHlWWThUNGh6OEdFOE45SHdJ?=
 =?utf-8?B?Q00yc0w5UGZOeTlZa0xVakdzeFFqM2hQSFRJUTBVWk9rNzl3L1o4RFVYbXpt?=
 =?utf-8?B?OHNHSEQyL3EyTU9lV0g4TjJoVzByWVJHZWNIcWs4Um5qRnYycXRzVmpHTENM?=
 =?utf-8?B?WUdhTzlDUXA2V3JIMC9SeXFQRVE2dXNMeEg3SUxSYVhTcitzNUgwbk1kV2hq?=
 =?utf-8?B?NTNqMzR4Tit0UU5NNE9BRVByMXNMdDIxSS9mUmFSQS9EMm04ZDU0Y2grQWZK?=
 =?utf-8?B?d1hMcFBseWk0VUdHcjBCN1BORmhoaFQ1VDNXRDhZSHVRREc4bjFpcFBWOWpJ?=
 =?utf-8?B?alJxSWU0Y2lwNTVvRmxLcU5mUDNDOFhUS1ZkUEFqUFB1UjBpNUlROHhmMVl0?=
 =?utf-8?B?QVpyRTN2RHhyRkJBWE9vUFNtMGluRXpuL1FCdU9ybDVFY2JEZVV6b2ZRdHh5?=
 =?utf-8?B?WFdzUlBNYU9PdWY5b05NTUUzV3BHcERnTXNhVWxxalBybGNnVmRTTFEyRlpG?=
 =?utf-8?B?VWxQZ3N1VWFiaEl2L0dlZWdzMDY1Vk9BajZ5SWhkMnNkdDN4MlhUZE5aTHky?=
 =?utf-8?B?cjFUOFpKM0NvRHg5bE95OWxXUEROZXp5T05nUVcrVmNQdU50MGlTd3krSGdD?=
 =?utf-8?B?djVKUjlRY1ZqV3F1ckhRUGptOTVPR1lJRUlGUkFVTU9ZNzZiMXFXdXRDengv?=
 =?utf-8?B?NXBoK3lILzZGNkYwL2M1VzRiQ05OZXk2bXEya3MwbGNHYjlZaVQ1bnNhK210?=
 =?utf-8?B?aXZwcEdqdGhSb1NBeHF3TDlmTnptSkRUWkVuZHp2Ny9CbDFFWGVjR1JMd0Nv?=
 =?utf-8?B?M21KR0VtZjNEdEtFNStEQXEveGF1V3Mza2xIc29HUEw4cE9LL3o4T25VUUpN?=
 =?utf-8?B?bWZNOHVXYUFTZjZxQmU1dERVenJRNDNBelRHNU5WQlZ5WVBvdklPVUdRdjA2?=
 =?utf-8?B?VWZoWjkxY21pY3N0ZVZaVmdlVGxqODV2TDA3SEgzalZoa0pqTnpIZ0E4RzYr?=
 =?utf-8?B?RU5jcSs1cW41eDdNb2hkdDN4bTJzb0JrMG92WHR2WURVMS83VWMzZEhZZjNl?=
 =?utf-8?B?dmY1UU5aR2o4SWlVUlNOcXdyblpkYmhrbUFVUHN3cG1TUFNld0FRbG9ydGFP?=
 =?utf-8?B?dVgxV1p6cFRIZ2toQm9TN0ZlZjNKZDB6djlXMXVLUG84ejJtdW5QRXMzL1d1?=
 =?utf-8?B?L2tYM3pxWFNxZWE1WFhqWjkxZ3ZoYlp0YXJON0F0b1ZGalR5OGIyNGxYdkhw?=
 =?utf-8?B?TS9tcEIvbnNvZEo1RGVlVkZWU240ZklrQnRFTWUvc1NhUUMzZDZYakdXNk9w?=
 =?utf-8?B?elJWVkYzSHBxSnBuUElWRE1POGtROEtDTnFtSTJnTXNOSnMwQmNWaXlhaTdt?=
 =?utf-8?B?MEU4b3lMb1llS0F0TGh5M01yM2tGYkJlMHdtTDluNVdYTTVxMXE5eVljSHI4?=
 =?utf-8?B?Sm1sd01sQ1ZkOUNQdXhVUDJLcUthaHAvRisyOXRuT25hQ1NKOVdRbFY0K3lF?=
 =?utf-8?B?Kzg2VnhKWkF4Zjhkd1QySTdNMmxMSWJIekczdWFqRlh2a09LdTZMMWZCSkhV?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wps3+Qny+9RkSGODigZJggQKDZI25B8oQB5j/7N+odeTQYCEkgUgGFade+VC2DqrTwNe6lamZjr1BF5BCu79G/jv5A9Ellku7hSrEYbgb6iQK1CWvKwmFo8Gn8hMbkY8/VcR+RdChMlpiEloe17L+GDFTKH5Mgkj2i8mYypHenBGN2uiGy9emJFGfN9WIzRtXHjsgesDHIE2943MAqjzcOnB1Zc/jSTRISJpQWpJVc/cQo2+sT65Ys/WnShhNeZNkRJTyZMHXB/eBTfQTmGzN88Trg7ImKXxCJxyKt5x4P4k5fsIfMrib3IJENvkHaHRhZ3aFDgRjI+QNor5u1jP5nd+QUYgKAALlPfADbYfVw1wJsekbBzODoGZiQtcB+uZX1eCv+V57dKp1Cpi6cGjYjAjzINLnmpW/kF5m4gbo+p0PpwiZhP90G5oh2SQaZKAsMcnkOHey0MFTUt85kJIMwaV1wQCsNv2JydHPatRt71dJZhldPRJD8J1lkhJ1fq0J6nXz2B3/AofQ1aWNL4Zbm++ODRM8zk61ESmjpQk2TgsH5zJ9v2WdJzrHDTQ8UrgpkieDTd5pg7AmoSA0nTONcyW29XhyEzILbxm8inx3kI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40aba1f6-a0d7-467f-ea17-08dcbe220c4c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 18:34:22.6035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxe39geo/QV2hICcsiscapJhha4UKuMIfkEwDyp7DiMSMxMkvhYZkXdoK+q2NTYvHsUODxsizN0Sz5fo910o/DJFWHP1kcCN4cuV/6b9uAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_13,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408160131
X-Proofpoint-ORIG-GUID: PwqPyenIJS0iPDQLUwc0YkcRDM8U11xX
X-Proofpoint-GUID: PwqPyenIJS0iPDQLUwc0YkcRDM8U11xX
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/16/2024 11:59 AM, Peter Xu wrote:
> On Fri, Aug 16, 2024 at 04:36:58PM +0100, Daniel P. Berrangé wrote:
>> On Fri, Aug 16, 2024 at 11:23:01AM -0400, Peter Xu wrote:
>>> On Fri, Aug 16, 2024 at 11:13:36AM -0400, Steven Sistare wrote:
>>>> On 8/15/2024 4:28 PM, Peter Xu wrote:
>>>>> On Sat, Jul 20, 2024 at 04:07:50PM -0400, Steven Sistare wrote:
>>>>>>>> The new user-visible interfaces are:
>>>>>>>>      * cpr-transfer (MigMode migration parameter)
>>>>>>>>      * cpr-uri (migration parameter)
>>>>>>>
>>>>>>> I wonder whether this parameter can be avoided already, maybe we can let
>>>>>>> cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
>>>>>>> in the same channel?
>>>>>>
>>>>>> You saw the answer in another thread, but I repeat it here for others benefit:
>>>>>>
>>>>>>     "CPR state cannot be sent over the normal migration channel, because devices
>>>>>>      and backends are created prior to reading the channel, so this mode sends
>>>>>>      CPR state over a second migration channel that is not visible to the user.
>>>>>>      New QEMU reads the second channel prior to creating devices or backends."
>>>>>
>>>>> Today when looking again, I wonder about the other way round: can we make
>>>>> the new parameter called "-incoming-cpr", working exactly the same as
>>>>> "cpr-uri" qemu cmdline, but then after cpr is loaded it'll be automatically
>>>>> be reused for migration incoming ports?
>>>>>
>>>>> After all, cpr needs to happen already with unix sockets.  Having separate
>>>>> cmdline options grants user to make the other one to be non-unix, but that
>>>>> doesn't seem to buy us anything.. then it seems easier to always reuse it,
>>>>> and restrict cpr-transfer to only work with unix sockets for incoming too?
>>>>
>>>> This idea also occurred to me, but I dislike the loss of flexibility for
>>>> the incoming socket type.  The exec URI in particular can do anything, and
>>>> we would be eliminating it.
>>>
>>> Ah, I would be guessing that if Juan is still around then exec URI should
>>> already been marked deprecated and prone to removal soon.. while I tend to
>>> agree that exec does introduce some complexity meanwhile iiuc nobody uses
>>> that in production systems.
>>>
>>> What's the exec use case you're picturing?  Would that mostly for debugging
>>> purpose, and would that be easily replaceable with another tunnelling like
>>> "ncat" or so?
>>
>> Conceptually "exec:" is a nice thing, but from a practical POV it
>> introduces difficulties for QEMU. QEMU doesn't know if the exec'd
>> command will provide a unidirectional channel or bidirectional
>> channel, so has to assume the worst - unidirectional. It also can't
>> know if it is safe to run the exec multiple times, or is only valid
>> to run it once - so afgai nhas to assume once only.
>>
>> We could fix those by adding further flags in the migration address
>> to indicate if its bi-directional & multi-channel safe.
>>
>> Technically "exec" is obsolete given "fd", but then that applies to
>> literally all protocols. Implementing them in QEMU is a more user
>> friendly thing.
>>
>> Exec was more compelling when QEMU's other protocols were less
>> mature, lacking TLS for example, but I still find it interesting
>> as a facility.
> 
> Right, it's an interesting idea on its own.  It's just that when QEMU grows
> into not only a tool anymore it adds burden on top as you discussed, in
> which case we consider dropping things as wins (and we already started
> doing so at least in migration, but iiuc it's not limited to migration).
> 
> Again, it looks reasonable to drop because I think it's too easy to tool-up
> the same "exec:" function with ncat or similar things.  E.g. kubevirt does
> TLS even today without qemu's TLS, and AFAIU that's based on unix sockets
> not exec, and it tunnels to the daemon for TLS encryption (which is prone
> of removal, though).  So even that is not leveraged as we thought.

Also, the "fd" URI would not work.  We could not read from it once for cpr state,
reopen it, and read again for migration state.

Nor multifd.

- Steve

