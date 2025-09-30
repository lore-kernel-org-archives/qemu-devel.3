Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C938CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 16:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3daq-0007Ca-Lz; Tue, 30 Sep 2025 12:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3dam-0007Bl-Fl
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:52:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3daW-0007QR-En
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:52:44 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UG9x5b009327;
 Tue, 30 Sep 2025 16:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=fVOmY83gXzbA9jsS4NJ9Ty0qGL/W7rFZf28CmAwDZso=; b=
 G4912WAmQDaszVLRon9TMEn553DjB0mrFgXd1UIKbcvC0yKn+zgsWC9IdpyNaltm
 0ZFGChGEDR4bC0VwRL8xLncaFSQNE9PBFMNTuEhb8KSzE8ZdFwKUMQ8tvJbVvqTq
 LVdRtZ6vitIEhNFn6swb3qI6mYZ4dHylrrotuhCXlS8g91HjllHCpdsWKhNncD0o
 SDvlQt5czSXuDw+CKZdgf/tFm3+vID9oHS28amcYXnM2Isu87OYpbTphmqksA1yv
 an7zqSAcRdluMSkbC4+atE3Qx9+PnADhgONz+6YX1Z/WVUSck3HXHb5egXI/blQK
 IX8My4bC4WfMYehciqv60A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gjft03qf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 16:52:24 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58UFeYiT011552; Tue, 30 Sep 2025 16:52:23 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c8m2r8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 16:52:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttjvPcjGN5fQPR5gVNs0HXyzDXLX84JJj1lZCg8SZJOH+A+d3eUaMZmFzrQ6/xRV/BcxifLEIPIFCOEjpZWb7VWOjczi34G2BE5jpTSZpcu/zoQccK2E3EW2andb5Y97SF//BkqnCbXIEGnCj+Twdp/M77zJUqM60dw+C0sablGMedFN8UwBuuCqNai6jtx6hFsv7dwDByzeaSSSeeaH0o6K3J2xx2b0MutHl+6IGlF5HOFH4fkHCgeCM+/ikZiVpND+Rl+gTbMZ+EBjQixv3/Jai+buAew7M4klsFuaEIReDSGib1MWuVq51BjbeAw+DajdJgPR3kfxZ0SLMw9EqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVOmY83gXzbA9jsS4NJ9Ty0qGL/W7rFZf28CmAwDZso=;
 b=DPprMRi5zzfWxRlsk4pCgGJ18tydqP1u0hUmk3EMpgtl/OaR/OMWczuMcoTe4mgb7m8hmoNMW0Vt5yAF1t36S3ave69Lmw0F/YF27/jw+86J54fYZIf/WLhhydCLADdF6INLWKh2bUh8jKA1RKN9qp34FZTy5kZHzvawvk7VoTKe159uLDxeme8CFxFOKEewnaQ8TV4vvJqCM2IpChEkzV8nN4NbzIPoc7BXG+TOz7JXgWAxhkD0dNnpPZKQ7ezikqH3CBNaNPUeSMG+zhaTBT0DxKBfU+vn08E8Eoqcr9ZCqkKbrXi96SHtQt/SZTGzf9kxQMOEdL2rYh665Ok2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVOmY83gXzbA9jsS4NJ9Ty0qGL/W7rFZf28CmAwDZso=;
 b=rfT3MM67EAQ+gfRlXzOepnyT8V1dw74t4kf+VDABKjK675fYu1tnj7VhBC2xH8GxOzS98VWJmPUB2iYQQ8gzbRjYXhCg6N8ML06rV0dW9VjkHd4ioXu4evMSWOM25bpq/TKQA7KflNfEBJKu1gGZ8chuAPlMBS97QNwR2FVDiMM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB4784.namprd10.prod.outlook.com (2603:10b6:a03:2d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 16:52:20 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 16:52:20 +0000
Message-ID: <e2926677-d284-4330-afd3-bf37c0c7f9d8@oracle.com>
Date: Tue, 30 Sep 2025 12:52:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/8] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <7bc0e3f9-f4c4-4088-8ade-4c8cd7c0835c@oracle.com> <aNwIXx_gqvvL1Ouj@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aNwIXx_gqvvL1Ouj@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:a03:114::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB4784:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc4639b-fe60-4f9a-3275-08de0041b83a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L25iQjE4WHYyTTdjbnhGLzBCTmxLdTNrc1BwL0VGdGZLQUJlMzFqZUZoUWYx?=
 =?utf-8?B?Z2ZIejI5K0orRnpCNDNaZUN3RFBmZi8xNi91YlpBczNvb1NVTzhnMVRrK1VR?=
 =?utf-8?B?NGFjbzFyUWYrZjdVQ1VVUUo4U3N2VjF5V3FHVGxNTVJoWlVYM09UK0R4T01a?=
 =?utf-8?B?d0xiTWlBMVpPM2lGZ3dsa2l0Z2gxNXJsaWVJaWJicjM5cEYva09MK281SmNY?=
 =?utf-8?B?ZHV2MmFjbURnbllWcWg0WlQzR1F0MCt1QWpmMVNPWVlKbGRnRmZNQUEzYmQw?=
 =?utf-8?B?RENnS0tibTNEVktjcWZRbURSL0NtS1pIcldPcU8rc3crTWhzZlRCSjR0cGpN?=
 =?utf-8?B?MTdsc3R1VUE3bmNWaFVmZzIxT0xhbVJ6YUxseXNkb1Y1R0YvSUR2dVlDLzVV?=
 =?utf-8?B?YmJ2b2sxU0FDV0pjNDZNYjR3YzhHZXlPMXVTUkhNZ3dLcHkrdnBMQWFqb0Yx?=
 =?utf-8?B?R05IcmovSmkvNmdWcDNaTEhhYUNPNGtmMndyd25CTEc1TmtsSW1nVUI0ZUYz?=
 =?utf-8?B?dWpvZUw1N1ZSUkViTGZvRTZvQ0dpSlVXSjJXdmI3VzY2MmRVb0hBcXJyNlRx?=
 =?utf-8?B?STlpZmlhTExqdXNNR0NRV3pvbjBSTVRudEVWZm1kK0ZOVGRCVWgwRWdKdE0z?=
 =?utf-8?B?bjNlVy9ob1NlRjh2ZWZtdStMbHZDOTh3enNLSHBtUmhHK0cxTmMyem5Sem9r?=
 =?utf-8?B?RitGWjJtK3VCeFF3dWNqYTRFeWdjSk9pRUFLamw5b2JLM0ErYmIrVktDZnBx?=
 =?utf-8?B?VHFGMGhBL2RvQVlDL1Y1YTI1c3NGZjEwMEVoUVBmU3VTRFY4MGtvYXRXVjRZ?=
 =?utf-8?B?a1U5Zm9lcU5BeXFsTXNMMUtYeEFSaFFRUjVXRGtXZEdUaUc0K0lWTlBkZExX?=
 =?utf-8?B?SEhYUUtVbHEyY2x0STJiMmtwTitNODVpL1E3b0VvTFhqU2VUWFV5ZDh6aDdt?=
 =?utf-8?B?N296bld5NEhCQU9SSTZXRlJRQ283Y1k5TDBqMDlHaCtPSkQ3SzVlQUV1NnZo?=
 =?utf-8?B?bmp4WUx1ODUvQ0RlcmFmSkZlbER1MEFFTDUvMW5saFJ2L3JQYzZrZnRSZDUz?=
 =?utf-8?B?elh4TGk4QmxCTmdXcHVIaHU1MFFRUm5EV3B3TnhyQ0pCdUxZVGpoUHljZHFF?=
 =?utf-8?B?UlZyWjNlelA4c1c3UkIrazFrN0FZWDFxOEk5TjRQVWNWOTBFTi9ZMG1MaU5a?=
 =?utf-8?B?TTlnYncvdEVzY1EvNXlRTnB2NGdmVzlDZDlQSitzbEVRWG00WnozQUpEeklN?=
 =?utf-8?B?RGZRSTRjcDY3ZllKc3dYamFZMEZsZjJRbVkxMFErUXJUbFRaS2FqbGpNK0or?=
 =?utf-8?B?WFBhSkYvaXIyYzQ0RkRxMStwajQ1WU84Y2ZjOFI5RDgzMG9tTFU0dmxocWtq?=
 =?utf-8?B?ZUdmRWRXRFAzOFlZTWp3V2kvd0l2cEh3cUVzaUdpQnd1WUE4ZmMzbVhhVXpp?=
 =?utf-8?B?TnpBOTIwRDNIT2FpRWRmTC9ta2NZbzJsOTcySWpzSGhvRmJLcmsxY0FMK3Fw?=
 =?utf-8?B?ay9JTVJXT3lpc2xOTFN6N25xQlcvY2lERXdpTlFmODVPU1Qxd0J6cjB2RG4w?=
 =?utf-8?B?Y0NvdHlkT0NhcWxZUEFZV2ZsMUVpdDcwYmRDaUlraW1LYkVGTXRUWVBUaE5V?=
 =?utf-8?B?dTBPbHJqSEx0MzgyS2pjZHN0aWYxMGpCYkJsQjF1TG5Qc0hmQldLaHlMZ2k0?=
 =?utf-8?B?MHc4c1dib3ZrOVV0VzVJUmdNRFdSRHNIWjBDVkYwbGg0SnNCZWIwS2lSckRa?=
 =?utf-8?B?NDkxVDNGTThoVTA2blVsS1RWQWRtdThCMUpnQzFuQlVtTmFhVnovb091RWIy?=
 =?utf-8?B?MGJTVGdKVXBzSVMvK1NjWkRKK2doUDRaS04vZVBiNk5Cd3Ewcm5kMzJ1ZWR5?=
 =?utf-8?B?ZnNtZkJEQnFUYmpkQThUNkt5MEVnNjF1WC9uVDM3R3RLSUpxNnNycHpIWStB?=
 =?utf-8?Q?2nmhjrOzKQnWaBrAB4DEnHTQ/j4kzsk9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGZCYmhodDBYSlN2elQrdUY3VU9BRVA4UmpKZDVibUE3RjV2dFE4QXJiL1Iv?=
 =?utf-8?B?SUs2WUI3MGVYSm5ORDIydVJscnBSK0pJbVZ4RUJUQTF2Q1NES1AyY2RWM1FJ?=
 =?utf-8?B?aXJPREVxdnNBdC9NNXpSUm9GQmdkTE82WW9UaC82ZTgwTTh0U0N1cGYxYXE0?=
 =?utf-8?B?U3lYVzVIUEVBWEJ6bzBERm9hS0MxQzQveHFNU2p4bVRHbEtqd3dGc1liOC96?=
 =?utf-8?B?KzFNSFA3aVZFbXRjYy9ISU41VlRvYnRjejkvaXVTeEs5YU1mOXR6cWljaVN4?=
 =?utf-8?B?SnNCU2pnL2p5T05JVFVFSEhkNkhkMmp5UXlodlJHYWM1dHJLWU9YSkQ3Y3Yr?=
 =?utf-8?B?ZW9xRVFSeGdMN0c4Z3lxa1dCeFRtZWwrU1ZLZVh5Wmd3YUZTb3QrN2h5Sy9q?=
 =?utf-8?B?UTVvSVVqZjNUeEZnMkZ1b0hPYmlnYmNob3kwcFhFbWlIQzZHSVpOMUNTNGw3?=
 =?utf-8?B?TjlwWlE0NHc2V2VucGEwYVpwTFlwZ1owN2s5aDNMcnlBUzVxWFFOQThLVTc0?=
 =?utf-8?B?eEJETlpvbE1rMEZZSDhsSlRkVnJxbnZ1ZUw1ZjVzNC9neWpMb3pFWitPS3pl?=
 =?utf-8?B?Z2dXLzB5dWV0NEdxNGtUK0NJcFozZUw4L3hCa0t2SGd3eWNVTW1pNzU4c2s3?=
 =?utf-8?B?WkxMR3BGUERwczUyZHlnWXE1Skh0K3YwOFN4em9CRzc1a2xlQUFLY1QrcldD?=
 =?utf-8?B?Rk0xdDJsSklKZE5zMkM3UHNCQTBzU2xvVDFobkJ3cEp3cmRhY1A1c25lMVR1?=
 =?utf-8?B?aWhRa3I1c3RmSjYrYjc5VVNsMFNBQUdsUVh5MTBCZVVuNjAxamtqMVdFNTli?=
 =?utf-8?B?WFVuazUvbm9ZREhZQ0J4MEd2TFNXRXFJc3JsUVQyL0FFYXdHZEVEdkwyWEhL?=
 =?utf-8?B?MFM1SEk0RzZsK0dVZ2tUL0N2VmpBWkMyc0pWNTd6SkVhd2hvU0liMld1Q09v?=
 =?utf-8?B?enlmTEVqODhsS3Y3M3VYb2w5YVdrU3BKc1o4c3huUkJUR0JsRzIxUkQvNjhu?=
 =?utf-8?B?cFlaa0U0SUc1dFkxY0dYY20xa3h5eUZWUWlJQkhtaWxKdlhER2FJRG45ZHBl?=
 =?utf-8?B?blZKVlBuTndHUFBiTVVmb01GbTVPVWVTKzNIRzNteURsd2V4aVhIU01NOW1a?=
 =?utf-8?B?Z1JKTUZCYVdzWEs4VjF0ZzBCSVpaREZHSjBqNDVNMVdmMGkxempzVjk4NExm?=
 =?utf-8?B?VENaMjl0aVRZN083VlpCaXdGM2YrUTliZUZXbHFhT2cxZ0hidnU1cTVaelVt?=
 =?utf-8?B?VFlMN2pleDBtNTFUNitNSVR6WTdZbDJ5d3A1RHhJOVRQRmpNODN6eFNyalFZ?=
 =?utf-8?B?V2dyS2h3aDJVbGZhRzNkUjRnNWNZSmxmakk3dDQ3cjhtVytUZ1crOTJxWmxx?=
 =?utf-8?B?eDhuVGJkVi9WSlhJMTkyTW1ScGs5Z1ZPbDRRZ3RtZnZOdG02U2VFcFZKMTF5?=
 =?utf-8?B?SFpEM0FvZ2RhMEw4dHcwUmhqVktZTTFoVStZNXJ2SEdldm1qeFZIMm0wLzJY?=
 =?utf-8?B?djgwK29iSkJiSEtxQmhCVC9lMmZlNCtmRkFJMThuL2owdGJMcmQ4T29FZmRk?=
 =?utf-8?B?ck1HTlZpai9SdkZWbVRQZTMwVXV5cytHQWNVQnI0TitXMW1oWk5ONEVvbnZx?=
 =?utf-8?B?dHpDSndBVWFMckJjOEVpRTlrVkxoY1g5TTF6U1c2WXR3YjVGNTBxaWJqSHo1?=
 =?utf-8?B?eHYxM0g0OE9WZHYrTFBhK0pLampsRisxUmFEVTlaUmM3YkR4RFpSZlRoR2tl?=
 =?utf-8?B?eDAxTFZRR2U3SVloLzFJdjhkS25EdHg4eVlZZXNZeHJVSzA2Q0d3eE8veURY?=
 =?utf-8?B?Z2VWNDJKOFZkMk1QNk5nVWlxQ2I5QUZZT1JUdTM2cVRvQ3ZoeVBLcnhOWSs3?=
 =?utf-8?B?M2Fsd0xPNnBKS1ViR1c1T1JRWllTdTJiVnVvT0Jpay9yTWRLSWxCMnAwMjNO?=
 =?utf-8?B?QjdwcGMvS1VlSHE5SERvUmRxRkhzWXhWR2cwd3FOUjlzeWZ4VlIvUVVzYzl4?=
 =?utf-8?B?dEthTzBDM3lIK0wwa0tJRW9MV0xjYlN2T213YXArQlpFcVFpTExmS3hXT08v?=
 =?utf-8?B?RGVXY2E4ckljcm52QXdtOFJyMXpsSzYwT08wL0U1V3FEYzJ5NzNLclFaUVJ4?=
 =?utf-8?B?UHFVT1JtclRnbENNcjI4bWx3U3NFSHJQV2FQaDYwY0dYYTFtVmNGaTJpWk91?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OB6CSVfxxJv6AomQicTa50f6ONtWyb0ZsL24DWO4KsJUUcpFbh8i1YRhETumNviR885VgPgPNGalnaSDS+w67HxgfOLtuQnikMHsgSn8xGSinCVlBtcviiD+ehDOBtN7vLteLD/irg9hdrcEpg4nZLQ7wxZJMszMkuXSIJS1/MFAgl+YY6gFulGsAhjBLKrkoNC0k78h4W7u53s/Jl/uDwTn1HDi1ej4b2uXWA0PhEm/ctyIaOpRig4dwUYVLN0Os4wiUwEYwXgSj1n21b/zxeeHu4UrKW2y4muIy9wrrRoMM3/OWM/eC2HqDQ5bjHZz/poX87dmSbLjV+580iJ8DsXJmdRZg9EbmPXE8EDuyHrvev7yGJpM20fThmrKpMcEVvODeMMHW9gvHyGOIiv2AhgEpchFYXzIM2147Fsd2Ib7ILSDGyGwDN2mK2/FsdhqMG4j4jFyvjra+punI+D3IgvPrXEwOEhioc4maYAUku7Z8wyLx/sUoLqPdTKM5TVsaxpKvj6DjP+ApbZMK5UGuay2Fn/M3AJqoocOAnlO7mIfWB5alrdaxUiPBXM60YJizwt//7PSjHZGNoy5IADNJU95BJKOPqnbZ/o9FZJLjos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc4639b-fe60-4f9a-3275-08de0041b83a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 16:52:19.9592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfcReqA/iqxZFDJ4rTU8jOkew8O4m6bIvPz5z/FXKimvDoCqx9NBA5u7dfoNc/1/0mBzE/5bUVKStVk41hXtQC2Q3TGTaAr/ZGSb6Ys7b6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=994 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300151
X-Proofpoint-GUID: xYP1GJ8rxpMEkAFKwSBE7FM8uSpDWMLR
X-Proofpoint-ORIG-GUID: xYP1GJ8rxpMEkAFKwSBE7FM8uSpDWMLR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE0NSBTYWx0ZWRfXyKCv3vkgwSy6
 eb+VUlJLK3p/0lLNuvDEL3qQv8qPdkhwJJMChwI9zNsvk9m7rmW3SHhD2BiRoj255HiVgyfgwE3
 pJADWi2wxIRWPcFvc9DS1m/MfE3W1j/TN5+V8/hO6Hd7yFw64XC5nD75ZiZYocUw1/S1W981Qqt
 tJsjeF1qb1Uq8CVCbQCdspY9cJ+YT+swiDf1449jUoU24qN8NFX+hTm0vgYjjoHkZb/r6Fm6552
 VJyfFi8DR+ojaXr3YBST3mTOSMczCCyXjyaGKP8JpkRjI9a2y3tZdsTdmT7bJoVAPRtjov9ZwYC
 0kVeaiyQjFdGz0cfsPf5VQ+NH+nrRROZTyEaG8CPrF8m8573qUGaMjmzfwIZ9/IidCBpV+1V5LD
 z/Vvwes6O0o1VQUYBqIPwMr4KzacUz4Cj6IOsw0idYgUl7maEdw=
X-Authority-Analysis: v=2.4 cv=EO8LElZC c=1 sm=1 tr=0 ts=68dc0ac8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=SS84QB1fohumvhdZw0wA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13622
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/30/2025 12:42 PM, Peter Xu wrote:
> On Tue, Sep 30, 2025 at 11:28:58AM -0400, Steven Sistare wrote:
>> Just a reminder, these patches still need review from Peter and/or Fabiano:
>>
>>    Patch 5/8: migration: cpr-exec save and load
>>    Patch 6/8: migration: cpr-exec mode
> 
> I read them and left some comments where I have.  For patch 5 please
> remember to include the header that Cedric pointed out, because it does
> break the builds.
> 
> Other than that the series looks OK.  I suggest when you repost, have the
> testcases be together.  I saw Fabiano queued most of the test patches, but
> it shouldn't be an issue no matter which lands first.

Thanks very much Peter.  I will finish responding to your comments and then post V5.

- Steve

