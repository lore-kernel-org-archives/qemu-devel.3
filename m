Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D542CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNzT-0006CY-Ie; Tue, 19 Aug 2025 11:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uoNzG-0006B0-7R
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:10:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uoNzD-0004U9-4r
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:10:57 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JDiwbN029555;
 Tue, 19 Aug 2025 15:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=vvEB0dnVxqErKvSBT4XtAhYp+Q+K8WLjEuTneDIYFyw=; b=
 PA5eIYi5pqMzMBZ646S/2YunQ1wCeY+Bsi12G2irjr5Dr7tSXAp0yMlW2bJJdu+h
 oF9REdZxXe9vNkogT3j6pvhLdYfxiQwtRzZYOVN4BglQC6pEy2+/MpAAw9wqwNQ4
 XydKFESt9eCl1Erg38LwQFiDVOCkoPDRYEznEg/BIN1b41HhkbWriuuHX6vDWWe0
 yvMhDaw3ELYJgj2KUbb3klxccyxqVx+DAISdzMH+pKG25d0v3WbULNc42Rb+o+kw
 /W31WODC+KN91PzvhxoUlWRWwwx0wD2dr7s/PCgdhpNqVuE3X5CqDXeYbO+Ukxb1
 J350LzB0uosO9qjT0NumIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jjhwwjg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Aug 2025 15:10:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57JE8cKV016843; Tue, 19 Aug 2025 15:10:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48jgeajggr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Aug 2025 15:10:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltm54nunyB8A5W2Hv6/h0JQ8ScqanHx7YC2S/XUs92hk1xXgUjNaerRzT1ONv/LBRI3iGWQbXlsezI6gkN1O7F8hdVgVmsNwND7E+jhZcEQxvtQmWawabjCADPeO9XZaCGoyDe+vP2YStuGMj+6NvSZ+4UORgrQkX1rai27NORP2RxrvQh7c7zCMpfz79r7JNB24OAdZrB/s3JARyF/om460r7zOCmgKbZUPK1RiNg6n81PQJS3bRpSM/jCe50wY4QKDRflFN7bEZoRiwF5vl2APDUxmUF6dsIPLPafugYoNb401N/dE2sK5O8hHvrtg5GYpV/60d71gndPeSNnOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvEB0dnVxqErKvSBT4XtAhYp+Q+K8WLjEuTneDIYFyw=;
 b=N1eW4rQEUf3T8wJzQA5+sc/uD+/Z+L5MPCPAWCaHpDV43WuNBcKgydmPzZew2w2LwvCTFcWbh4ADil2XvEVY9uAEDXMkOc/Cu8DNmMxkaGAjfOlgVDfkfuZ+mKPqgmTRKwGX0bWW2OLnwmBboEbKTK+f4e28G45ShV2oJ8sw1lodzmJBVIm3Vw19QXfF1dyUxXgnVO2OwYR7mjzlP7YwnseS/3jQWKQhQZFkdX1Qr4+vjpU7xCr+ie8AaydAY7wW3qFIjsO0NysEOfyeU9uhDbnd9J8Qg3rEGe+3BFLIlD9gwdEWOa8g45+aQG5S+t4BeYJSy+V4LfJbrtmkgQqClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvEB0dnVxqErKvSBT4XtAhYp+Q+K8WLjEuTneDIYFyw=;
 b=m7osC7/CYiVYUnzTaVIURbprVOh4j7L5pt+SnLABfsLzcOz32tvxSnoAKNhDe0JOcKsoB0eSRq+3rekdJIMPwnYvCP8RaJD21yTUxjCiLYnMTKw832CZAGuwZVDmuU6wfr6q4tIOLCUTOS7K/CXXANZVz0mQJdgfGsMnE1nv1Oo=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by LV3PR10MB8178.namprd10.prod.outlook.com (2603:10b6:408:28c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 19 Aug
 2025 15:10:10 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8989.018; Tue, 19 Aug 2025
 15:10:10 +0000
Message-ID: <4f067326-6c80-4768-886b-2b819e7184d3@oracle.com>
Date: Tue, 19 Aug 2025 11:10:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com,
 mst@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 Dragos Tatulea DE <dtatulea@nvidia.com>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local> <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local> <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local> <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
 <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
 <aJyb6n9Vf4BhHqpb@x1.local>
 <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
 <59317419-e832-4590-ad4f-cfe7d21e8fd4@oracle.com>
 <CAJaqyWfc3G5NLnxqXvZFxw2aRnVvOcZbLds5LHzcdoLjVGmOsw@mail.gmail.com>
 <c5b97e10-a8bb-4d59-b509-734eab7d5be3@oracle.com>
 <CAJaqyWc-vKsqs2boiktJn_cO3fSVk=-EfP3G8QN-z=n59VCoHA@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWc-vKsqs2boiktJn_cO3fSVk=-EfP3G8QN-z=n59VCoHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|LV3PR10MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: e331a64f-1e6d-484a-7288-08dddf327d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1Rhdk80UE5jRmlYMWRpTnVvVVlab21uSHVydUNjM2xxeXczYkI1RlI0Qysz?=
 =?utf-8?B?TXlHY3pscHVVS1NTU0FyZ2lRM0JWb3VDNlV3aWVLZVBvWGJOdWV4RW5YenZU?=
 =?utf-8?B?K1ppNkFnK0trYjB2MzI3U3hZWXlUT3ZkTWxHemthTUdENVNqN3JsWGpxNDVY?=
 =?utf-8?B?Q1JraWtqNXJDb0NkcisraGhaT2RHUU1aa2lrS3ZRT2xTUnJrRWpUTUxWdW12?=
 =?utf-8?B?WDE2N1VnRmI3UjRVbThOTWtpKzZLU05DK0JOUmxlZmpsWEY3VTh2RU5yaGpI?=
 =?utf-8?B?dGlxM2ZPU2ZySDZ1bTZQUW9aUWQwWWpFSUdvM0dLTmNvM05zblErdjFudisz?=
 =?utf-8?B?ZUpnQVNUakFmUWRuVFgyMG5vVzFxN0VYTjdieHlBQXRUUFpXU3RQWldWMExa?=
 =?utf-8?B?Mm0vZ0d3Y0hHL2FOeU80czZLZDVqcDRxVU92SldGWllYUkQyUXg2Uk1SMHFH?=
 =?utf-8?B?dWtjeTRJUzBPVFQ3SVB3KzV4clk1K0VyT2tRbXBSMlNvZTh3L3JsV2xva2dr?=
 =?utf-8?B?WU1Hc3VSdjNmRVJ1QzB0Z1ExOU9hYU5SVWdLQklGcHZmYWVJWUFiUWRIVHN2?=
 =?utf-8?B?d3NoTFpPaHFhdGJGblgydHZuLzdsWkhlOXJYVUpqYXVkMmVJeXgxQThyNW1E?=
 =?utf-8?B?Z2xvOWZQNCt4YTRxS09obURLanc4eDhXZVJPU2FSdjg3RjVIQzV6MnBwbFVw?=
 =?utf-8?B?UDNQVVBtM3d5eTd0RFlzSkJSN1NMYUNORi82YmdWYS9QVEV2QVlCanNseTR1?=
 =?utf-8?B?OVZrdytOeFphUUhpY2p0ZVBYdHF3WXVGc3NpdnNYWE5XRnpmZ3NXbUVCY0x0?=
 =?utf-8?B?NkxsWGxVeDB6VitEM24vVkhKeUx3TWZjczBLSWdQeVd5d0pjYzVvTDJGWTJW?=
 =?utf-8?B?Wk8yWEozSVM5Wm91VEhsOHZaYS92dUYwUW04Q2o4MzZxcmZubjVMWmEwOXha?=
 =?utf-8?B?WTJqL3pYclkvaTRodkpZbnlScWtzWXRoYkdnb2xwR3pVK2FoRFkzY1U0cTlW?=
 =?utf-8?B?QmJseWZ5UzU3TXJZWnM3NmxHYVp6MFV6UWkwVTJXTFF0TVJDME56NFNrTlhK?=
 =?utf-8?B?Rmk1UnR5M2hqeGJHdlZJZ3QydWpLeUlWZkdDelcxeldYN3RNT1NudWFKbHZS?=
 =?utf-8?B?eVRNb1dOWUhOTEFnVVpFaWV2d096SU9tcVZuL04ybnNiamlRUDAvdU9HRk9X?=
 =?utf-8?B?Y3VxRWdRZ1NFL2RlTGZURk43eGNkQUNtN2R6eTVUb1RBYVNuSGhnalErQkNy?=
 =?utf-8?B?cmc3dTIxdUs2ZHc5OTVwYmcraXU5Y1NUM1IzamM3c3YybE5HL3JVc0tveG5Y?=
 =?utf-8?B?Z1dQN0VPSXNReHRTbVk0V1luSzcwSnJjamdLNlRPVWtwTkFrTUtmeW0xQzNa?=
 =?utf-8?B?RmtLL202VzhlODVWUDcrOWs0Y2o4dHdQTlpIUnA5aXkvNGRPYktqWjJlUnQw?=
 =?utf-8?B?NS9OZURheVZKVGo0akhIcTc0cU9HWEtaM1hZRnl3eTNrMWp6TFA3OWZCd2xF?=
 =?utf-8?B?T1JOUkpnYmUrSEdYV0V3UDZrYzFGY0xEa3pqWXFLeFM4eVFQa1IvVVFhMGJl?=
 =?utf-8?B?UllwRVpDTDRvd0lPU0E0bG4wTkZja1c5QWJkUjFIYmhwc2pWYml0anVWblVM?=
 =?utf-8?B?QVJ0NS85ZFkrQlRGNDVaT21BRVA1UjJXQmlIMmlHZTNmeG9CMlRhN0FMVTVy?=
 =?utf-8?B?OHBBUERDcHVMTmN4enlWS0FrRkVBNCs0N1crUHNaOTJaOW1UY28wTkFtdDhK?=
 =?utf-8?B?RTJwdE81ZEJwVEF1MjZrUUpHYkJiNU1UTS94a28xTUVGbTlPamErRUVjbDZO?=
 =?utf-8?B?dVFpWkhuUGduK294dEh0YnRWSVc0SFpKZVRkREJlb0Z5cTM3Z1ozMGNQekIw?=
 =?utf-8?Q?LgbolVdz7mmK7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFhmbmlpd1BPdk1QYjdPeEQ1Q295cnZ1RnRqbExLSnBlTGUvZkpyRlVBNWdm?=
 =?utf-8?B?eW9hcTFjc1JORmpVTmZFUjhDMVZKMXE3K2laVVN1M3ZZZ1k2bjlPb0FQUmcx?=
 =?utf-8?B?UVN5NVZtSE9IczJNVldrMm1RYU9UNlc0NmtKRTdWVW5teGN6UDUzMC9aQjVW?=
 =?utf-8?B?a1VCZjdvei9zMzRibUVWejRscU9tYW5OU1hmZ0ZQMnZ1NjJKNnBuR1MzMU15?=
 =?utf-8?B?Ulp3LzFvdnNBS3BERGVpNTBObjQ0ZXNaRHFkaFVIZVExdStSejROTTVFdjBj?=
 =?utf-8?B?eWYxaXI2c2lxd1R3T3pSZm02SFU5TDZxckl4YXBvUzBxWFFaUmljSzVOUElV?=
 =?utf-8?B?dkt0MDBvQkJ4TmdBU24ybGtsbmJlVXpxZCs4WkZiMW1XMWRqNVZtTlcvRUdS?=
 =?utf-8?B?MEI3ajNJSk5ZTVlsUTc4TmVjNzRrVFBZUlhUYnhCeHpxcTdYOGY0d3ozQU9I?=
 =?utf-8?B?N0swRXJRdFVoLzVOeEk3T2lJYTVBQTl2NW5zWENvMWIxM3ZQK3NTei9Fb29o?=
 =?utf-8?B?NlNjSktjZWg3TTN5alBhcjNxUHlscUY5NUtGbnZoV1hlUFRONlhFL3IvbEpD?=
 =?utf-8?B?ZDkvdEVvR1V3V2ZsbW5DaVR4YjZZejRjY0ZxamV3dHZvNmdidzhOV29VUnJj?=
 =?utf-8?B?QTBBTWNWcGtSeWRHR1ZiaXZsRVZyeFJmRnMwVnF4QlVheFM0a1RHVGlPcU85?=
 =?utf-8?B?d0QrT25pSExDeWFiZmVYQzZ1WnBIc1F0Nmk1Z3ZIa1A1cVN0cCtDeURoSkZn?=
 =?utf-8?B?L2N0L0dlNUEzVjlUQ3FHSlBLL3ZVbVZvK3NoSHEyNDZlUzFvZCtpUVRNWXpR?=
 =?utf-8?B?QlZBaVVWR2ZCdW81bVQ4eWk0Z0YrVkQ0cnlRZ2VpSGtId053MWQ0ZlpuUVlw?=
 =?utf-8?B?M3BuOHBwc2V5VHNmcFFiTEhIbWQvRmhpdWxDYURycWhuWjNwUFZVQ05EZXFl?=
 =?utf-8?B?LzNubjI5WFZkWmFrYnoydVIzdEFQNHorV05ia0NnaGhDOU80TEZ3bnFRek0w?=
 =?utf-8?B?VmNTdG8zWHh0ekZHZDBiY2pOT3p1bFNXL25nOStWVGdvVzJYTTBLWmJ5cElN?=
 =?utf-8?B?ZW53bXBCYlVTbUhaZGs0MlBFSlo5SXZRRno0V3lOUGN2dGpKVWtUOGNQNzBy?=
 =?utf-8?B?Kzk0dm5XbDNRRTRoZVlleFFNQmkwQU1tWFVsTHdXdzlPdEg1UzJMRDd2KzEz?=
 =?utf-8?B?RWFrS1JSNW5OVDh3QTJYR004VSs4cVA4Mkw4bWxHcStyZFh3eSsxZEdoYnhC?=
 =?utf-8?B?S0g3T3NZL2Mwc2czNFZ1d3NVQTZCRUQxVWxHV2s5SzE4VDFtcVRsT2ZCbmlB?=
 =?utf-8?B?dmduNjB4R3V1RURvYnh2UDd0Nlc3M3BLaVZpUm5iQUhNMmE4em5mWHYwTVVO?=
 =?utf-8?B?SnRvR0ZoQ0tlSjhXVDhNNTZuNVVNK0o5c1QvTS9TNDBGSmIxQ2VuUUdVZkEx?=
 =?utf-8?B?WlNHRzRlSFpwT3Y3T0NsRmMxM2QzK2hHdVlRWGtQSDNHV3Z1TjEvSEVvYWlv?=
 =?utf-8?B?Zk0rcy9JMVFjTGYwYUplM2JyaXlIS1JsVTFjZ1hkM3N4bHZRKzh3eHA2UW1O?=
 =?utf-8?B?bHNHUUdIWU1yYUlycUxRWTBJSjNRSEdGajBlU2w3alBlVytvN1FjcWdqZ3Vu?=
 =?utf-8?B?dFNOYVZkNXBPMmU0SEFtdjQ3cU5ZczFBWkFWREJIRlFLRCtMeFdTN0FBa1ZH?=
 =?utf-8?B?Zm1wQ2w5cGhsN25oOXZHVTZYclVvVXB3cGRRTmZaa3U0bHVMZkpEOWo4Tk1u?=
 =?utf-8?B?dEV6Q0IvMGltWXhBa3M2MW9UUkE2UUJqbFU3bnhPS1Vadmtwakp5Q3V3S2F2?=
 =?utf-8?B?Q1pjSFZMbUpDdnowT2c2OXBGQm9xZCtoeUg5QUZvVm9CSytQTWZDSXRoY3lY?=
 =?utf-8?B?K203cXA0QlNVS2Q0V2wzNWQrVnZOdjRTL0hQNmxlUC9zcGdpOWd5c0Rnc3o3?=
 =?utf-8?B?U2l0QTlSNGlDK2FYc0ZJdm80L3Q4SzBycU9NdEJGc09lNi9ndjkvQUlZOXps?=
 =?utf-8?B?YXZNT2p0V29Ud0thK0lDeTJrci8rRFNacU1DUTFiTENvdDVURW5HL0FWZTJ6?=
 =?utf-8?B?eG9RYWNwTHBMS1BtWHpyR2xmZlUzU0lyNGp1TDVJSlVreVp2eXlvWVJMLzRW?=
 =?utf-8?B?VTNxUE9RbEh4WjlLcjYwWEt0d3lsNHVmelJKSVNad0RNOFVmcUVrK1ZQQW1a?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +LCRLohNfI2oGKUvCptWPVKF+nw8bJnyfvKjujxZToRixWIssXa7uyUWWs7L1Aczwp/AFL639digDnc3kRHIbPrz7WkF29bUti2qSABUYo07An8ihbEhcF/F63vwrv0zcIHPYJgWqZp3OSQk2gsXBR70NR/rk2UIlVu1RtVaf5GeJ1hg6H2gdVO32bjiXxzuSxwrc3c1c5qN77YQA1AgnkxXwxqIHzwJiJACmeIyA4G3xS2NeJsMPZ3mp6MuOhAASh0S9XxCzHDtTcMreJNeKIlUM/Q9IJoc6UkHI79F638pILDjxp0qNpKk7kdklmL7umakXXXH+xn07UE8jxg+wkJOmcEig+catgbGNGrYwR6Y7VuKGmBffJQyMY5o02EjbaABwOKtJVUmDpSfUVW56caPH+P1JKDRuNJ3RHabDzXtb6jN9monhq3ZmFeUPKqR4ve2leNz//iSMj7jcVFOj/zLhZOldO5ixuTC7m0wJD5WE+yjq0c8srYQDN2u53pnFiUQ14FNHGbVy9wiiRroVZG0sbP8xp5s5kgGm3cXYwwNEybOgvqDaI+HH8nfqOEW4Cb0kMTZ2QG8cZz725jxVkPVz02tGy92ydeXlG97Xfw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e331a64f-1e6d-484a-7288-08dddf327d52
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:10:10.2475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wu6DM5FgCf2gzpKi6C2ZDMg6SNWIlbW66T0SAfly76eK1rwfGcqYD+J9Q2i3DWBgHMxNk4TpvsIq0C0BbAaGxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508190141
X-Proofpoint-GUID: M_yGh1nHEi9UjkBExP8KkBAsIXOGyoyb
X-Proofpoint-ORIG-GUID: M_yGh1nHEi9UjkBExP8KkBAsIXOGyoyb
X-Authority-Analysis: v=2.4 cv=G4wcE8k5 c=1 sm=1 tr=0 ts=68a493dc cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=FlPDm959NFjkRufDEskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE0MSBTYWx0ZWRfX3DoSZazil9Uq
 YoCA+pM0aw441icoy4E28aS1Ks+VPVRk4XXt6t7Hf1XKYevkiGO1m8FeKmRh4Qk3zwNwPwEbX2M
 fY2CtU6olSpNyADxgYHKS33MyGkbT7NNHz03/EXBnQgbDzcsiu7qApGlDMxuNjf5z0+3++2pYOd
 nUcHVSFbPQhvm8P6lyg1JK4WIfsMm29bYyn2TcZ8SVcZ0RhqVo/SJKsnzE2Oy6+qjYtqGT+hcW1
 0fI84OqiYjzlEJv0KDXdEGnJ97FvvF2mXd19Y+XNypqvC6mfyotf6xn5WHDRh0SVR9vGXgEYBXi
 oCSOX/fl5WrAs7/XqJAXIi0uwar0cdnXDYVbo+JF7UB4bL46I3lGcmCdFEKIogY95hCZ0qH6uOD
 pox152r+3pZmQy7Rm7qNvvShKA4g8jd68ZQFhL6cvFdIxjHGXFvi9ufMZU5UNM/4kGPrdG1j
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 8/19/25 3:10 AM, Eugenio Perez Martin wrote:
> On Mon, Aug 18, 2025 at 4:46 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 8/18/25 2:51 AM, Eugenio Perez Martin wrote:
>>> On Fri, Aug 15, 2025 at 4:50 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
>>>>> On Wed, Aug 13, 2025 at 4:06 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>>
>>>>>> On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote:
>>>>>>> On Mon, Aug 11, 2025 at 11:56 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>>>>
>>>>>>>> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
>>>>>>>>> This effort was started to reduce the guest visible downtime by
>>>>>>>>> virtio-net/vhost-net/vhost-vDPA during live migration, especially
>>>>>>>>> vhost-vDPA.
>>>>>>>>>
>>>>>>>>> The downtime contributed by vhost-vDPA, for example, is not from having to
>>>>>>>>> migrate a lot of state but rather expensive backend control-plane latency
>>>>>>>>> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters, offload
>>>>>>>>> settings, MTU, etc.). Doing this requires kernel/HW NIC operations which
>>>>>>>>> dominates its downtime.
>>>>>>>>>
>>>>>>>>> In other words, by migrating the state of virtio-net early (before the
>>>>>>>>> stop-and-copy phase), we can also start staging backend configurations,
>>>>>>>>> which is the main contributor of downtime when migrating a vhost-vDPA
>>>>>>>>> device.
>>>>>>>>>
>>>>>>>>> I apologize if this series gives the impression that we're migrating a lot
>>>>>>>>> of data here. It's more along the lines of moving control-plane latency out
>>>>>>>>> of the stop-and-copy phase.
>>>>>>>>
>>>>>>>> I see, thanks.
>>>>>>>>
>>>>>>>> Please add these into the cover letter of the next post.  IMHO it's
>>>>>>>> extremely important information to explain the real goal of this work.  I
>>>>>>>> bet it is not expected for most people when reading the current cover
>>>>>>>> letter.
>>>>>>>>
>>>>>>>> Then it could have nothing to do with iterative phase, am I right?
>>>>>>>>
>>>>>>>> What are the data needed for the dest QEMU to start staging backend
>>>>>>>> configurations to the HWs underneath?  Does dest QEMU already have them in
>>>>>>>> the cmdlines?
>>>>>>>>
>>>>>>>> Asking this because I want to know whether it can be done completely
>>>>>>>> without src QEMU at all, e.g. when dest QEMU starts.
>>>>>>>>
>>>>>>>> If src QEMU's data is still needed, please also first consider providing
>>>>>>>> such facility using an "early VMSD" if it is ever possible: feel free to
>>>>>>>> refer to commit 3b95a71b22827d26178.
>>>>>>>>
>>>>>>>
>>>>>>> While it works for this series, it does not allow to resend the state
>>>>>>> when the src device changes. For example, if the number of virtqueues
>>>>>>> is modified.
>>>>>>
>>>>>> Some explanation on "how sync number of vqueues helps downtime" would help.
>>>>>> Not "it might preheat things", but exactly why, and how that differs when
>>>>>> it's pure software, and when hardware will be involved.
>>>>>>
>>>>>
>>>>> By nvidia engineers to configure vqs (number, size, RSS, etc) takes
>>>>> about ~200ms:
>>>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7sGaBlbXhcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2pA$
>>>>>
>>>>> Adding Dragos here in case he can provide more details. Maybe the
>>>>> numbers have changed though.
>>>>>
>>>>> And I guess the difference with pure SW will always come down to PCI
>>>>> communications, which assume it is slower than configuring the host SW
>>>>> device in RAM or even CPU cache. But I admin that proper profiling is
>>>>> needed before making those claims.
>>>>>
>>>>> Jonah, can you print the time it takes to configure the vDPA device
>>>>> with traces vs the time it takes to enable the dataplane of the
>>>>> device? So we can get an idea of how much time we save with this.
>>>>>
>>>>
>>>> Let me know if this isn't what you're looking for.
>>>>
>>>> I'm assuming by "configuration time" you mean:
>>>>     - Time from device startup (entry to vhost_vdpa_dev_start()) to right
>>>>       before we start enabling the vrings (e.g.
>>>>       VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).
>>>>
>>>> And by "time taken to enable the dataplane" I'm assuming you mean:
>>>>     - Time right before we start enabling the vrings (see above) to right
>>>>       after we enable the last vring (at the end of
>>>>       vhost_vdpa_net_cvq_load())
>>>>
>>>> Guest specs: 128G Mem, SVQ=on, CVQ=on, 8 queue pairs:
>>>>
>>>> -netdev type=vhost-vdpa,vhostdev=$VHOST_VDPA_0,id=vhost-vdpa0,
>>>>            queues=8,x-svq=on
>>>>
>>>> -device virtio-net-pci,netdev=vhost-vdpa0,id=vdpa0,bootindex=-1,
>>>>            romfile=,page-per-vq=on,mac=$VF1_MAC,ctrl_vq=on,mq=on,
>>>>            ctrl_vlan=off,vectors=18,host_mtu=9000,
>>>>            disable-legacy=on,disable-modern=off
>>>>
>>>> ---
>>>>
>>>> Configuration time:    ~31s
>>>> Dataplane enable time: ~0.14ms
>>>>
>>>
>>> I was vague, but yes, that's representative enough! It would be more
>>> accurate if the configuration time ends by the time QEMU enables the
>>> first queue of the dataplane though.
>>>
>>> As Si-Wei mentions, is v->shared->listener_registered == true at the
>>> beginning of vhost_vdpa_dev_start?
>>>
>>
>> Ah, I also realized that Qemu I was using for measurements was using a
>> version before the listener_registered member was introduced.
>>
>> I retested with the latest changes in Qemu and set x-svq=off, e.g.:
>> guest specs: 128G Mem, SVQ=off, CVQ=on, 8 queue pairs. I ran testing 3
>> times for measurements.
>>
>> v->shared->listener_registered == false at the beginning of
>> vhost_vdpa_dev_start().
>>
> 
> Let's move out the effect of the mem pinning from the downtime by
> registering the listener before the migration. Can you check why is it
> not registered at vhost_vdpa_set_owner?
> 

Sorry I was profiling improperly. The listener is registered at 
vhost_vdpa_set_owner initially and v->shared->listener_registered is set 
to true, but once we reach the first vhost_vdpa_dev_start call, it shows 
as false and is re-registered later in the function.

Should we always expect listener_registered == true at every 
vhost_vdpa_dev_start call during startup? This is what I traced during 
startup of a single guest (no migration). Tracepoint is right at the 
start of the vhost_vdpa_dev_start function:

vhost_vdpa_set_owner() - register memory listener
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
...
* VQs are now being enabled *

I'm also seeing that when the guest is being shutdown, 
dev->vhost_ops->vhost_get_vring_base() is failing in 
do_vhost_virtqueue_stop():

...
[  114.718429] systemd-shutdown[1]: Syncing filesystems and block devices.
[  114.719255] systemd-shutdown[1]: Powering off.
[  114.719916] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  114.724826] ACPI: PM: Preparing to enter system sleep state S5
[  114.725593] reboot: Power down
vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
qemu-system-x86_64: vhost VQ 2 ring restore failed: -1: Operation not 
permitted (1)
qemu-system-x86_64: vhost VQ 3 ring restore failed: -1: Operation not 
permitted (1)
vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
qemu-system-x86_64: vhost VQ 4 ring restore failed: -1: Operation not 
permitted (1)
qemu-system-x86_64: vhost VQ 5 ring restore failed: -1: Operation not 
permitted (1)
vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
qemu-system-x86_64: vhost VQ 6 ring restore failed: -1: Operation not 
permitted (1)
qemu-system-x86_64: vhost VQ 7 ring restore failed: -1: Operation not 
permitted (1)
vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
qemu-system-x86_64: vhost VQ 8 ring restore failed: -1: Operation not 
permitted (1)
qemu-system-x86_64: vhost VQ 9 ring restore failed: -1: Operation not 
permitted (1)
vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
qemu-system-x86_64: vhost VQ 10 ring restore failed: -1: Operation not 
permitted (1)
qemu-system-x86_64: vhost VQ 11 ring restore failed: -1: Operation not 
permitted (1)
vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
qemu-system-x86_64: vhost VQ 12 ring restore failed: -1: Operation not 
permitted (1)
qemu-system-x86_64: vhost VQ 13 ring restore failed: -1: Operation not 
permitted (1)
vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
qemu-system-x86_64: vhost VQ 14 ring restore failed: -1: Operation not 
permitted (1)
qemu-system-x86_64: vhost VQ 15 ring restore failed: -1: Operation not 
permitted (1)
vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0

However when x-svq=on, I don't see these errors on shutdown.

>> ---
>>
>> Configuration time: Time from first entry into vhost_vdpa_dev_start() to
>> right after Qemu enables the first VQ.
>>    - 26.947s, 26.606s, 27.326s
>>
>> Enable dataplane: Time from right after first VQ is enabled to right
>> after the last VQ is enabled.
>>    - 0.081ms, 0.081ms, 0.079ms
>>
> 


