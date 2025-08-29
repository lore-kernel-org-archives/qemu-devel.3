Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748ADCA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNbH-0005X5-4C; Sat, 30 Aug 2025 11:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1us4up-000696-In
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 15:37:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1us4ul-0000Ik-Sh
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 15:37:38 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TGfpem013437;
 Fri, 29 Aug 2025 19:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=aPXVQku18cxl333Kkz
 3BfF3UClbw1PFMEhV3xqaLKCs=; b=mgDve7qBIvm++VggbAlZxWzUqReFSsXF63
 VUaPKiVIiM59jRPVOrQ/5p6w9blEwrOxRrnzooMCJnS+DIfnIU5FYjdLALhevCEe
 vI2TyJJQ37xhyzICeYEPmPTWYGs7Z7BmoscDLYA/lDY4DBNfeW7yHxZLLEmjy0kD
 I7+oG9QB7jO2QKM1mlPvJ1eoDzMksDd0A4+TgmXTP00tvB0ctZkbxAEpA+BhOL93
 JeUR21oBKR/x8grZ/XYUzgIwdpj84oBll/i1HYbMxsg2wKv1ZcyoanJ5BNoQPrP5
 juzSvRqtXu+Lrqfqs7y6apDOLE7ebeWYDs/pOT+mYJUCzW5OP19w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jau589-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Aug 2025 19:37:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57TJ3gt8005142; Fri, 29 Aug 2025 19:37:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48q43dm2vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Aug 2025 19:37:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DON7y66sNnIkUPrfkrK/BCx1QcT7f6QKSlkozy7PNA+4jsHh1DdE6remI1WDbH2d/MUbdLkrm3THPtUg7S3fQCv5nJMvfXcD2vHM1wE94JHiGDtoJvIYbz3ZZ/Xe2xQ+7TPY3prAt3DxeN1YMQ45Nr7cMCAc+HPAzI1ZxzPp8wUbz9aoc05yMElFMS0FYGD3vA/2LCskf9sLonVUjm6lSP4kHkMCCG/PE+bEyTrXFCZ59YlPdIB7vdafLqEsqP5PUGHqDBX0FFTVdgNJpdm78JAy30RjaAOIXrAuZkVZlwXKITL0E3XH6INKMoeT/dVIUk22BAFb/LKaLUL+53/CtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPXVQku18cxl333Kkz3BfF3UClbw1PFMEhV3xqaLKCs=;
 b=LldYnM/Y9c6VSKNaabVtC+SNX1J5G66OFO3OChEooqpiNotx6U/Lh3bpwNf7wzowhIf6CXP2egYrjuq5Wa6cydia06Qej9Y3LilSA//Qs83DL6ryGLnLDuOmyLdV5s2JoLewDee3HNIIuZ53RDOFyidMa7pRZwrGlUlBfiBTkGEkXGcpYfV6QP4k8NdLgmWlDkwEnIxyKVjffGmxHtPm7HbnFe49HvUjKdNrpxf6EkIGiJvw3e+Je+mSlP/osvY26EtI3oaJtFi4k6ca01BQNZeATQ9H/MP3ugsy8Srz3awdgkR4Jx+OuS6OROrbmMCZz7fnv08twtgAZU0Cm+i0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPXVQku18cxl333Kkz3BfF3UClbw1PFMEhV3xqaLKCs=;
 b=bTxmPlHRoGbNU0GR5+9MODr4eJtn6drN/Zas6Rgjptwf+lY+MMXOqaxxkom/JRcs0V+KJlTxlSOq81xcoa5Qpukt17zWYmOUYtRPXHD6i++lj+YGRD/Tlv9vCfygxlBWZKOdLq5V7kxt6z9LQzujBCM2qe6ffGXAI0NLKPgPafk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS4PPFDA2AE39DA.namprd10.prod.outlook.com (2603:10b6:f:fc00::d4f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Fri, 29 Aug
 2025 19:37:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 19:37:15 +0000
Content-Type: multipart/mixed; boundary="------------arQYXqlIxF0D6Gg71hBADYR0"
Message-ID: <3c939b30-2479-4bdd-8fa8-1dcd7adaada5@oracle.com>
Date: Fri, 29 Aug 2025 15:37:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
From: Steven Sistare <steven.sistare@oracle.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Chaney, Ben" <bchaney@akamai.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>,
 qemu-devel@nongnu.org
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <ef7fd47a-f7c0-4bca-823c-07005c5f1959@yandex-team.ru>
 <f3cb36ee-e677-4377-9e4d-652085b205aa@oracle.com>
Content-Language: en-US
In-Reply-To: <f3cb36ee-e677-4377-9e4d-652085b205aa@oracle.com>
X-ClientProxiedBy: PH7P220CA0149.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS4PPFDA2AE39DA:EE_
X-MS-Office365-Filtering-Correlation-Id: 99daada2-c92a-483d-1d7e-08dde733752d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mm1aZ29TWFBWdTYrNDRldExoWmxqMlpZM0tWVzFjMjI4UWgrcVU1cDJDM0hI?=
 =?utf-8?B?c0Q4Ty9QS0xmZ2tkU1ZVc3lsZGhTWnNsNVNBK0t0U24wSjZwcDQzNHVrK0pr?=
 =?utf-8?B?Q2wvSmdWWHNISVl3V0ZBbjkxNG1XZEdLRjU0WlNrVEJkYk9yY2dwZE43QXIw?=
 =?utf-8?B?Zmt1cEYvVDJISFZ5QWdEU2RPd0wvTWdQVkN2cW5QZ2Mra3hJVU95MHJxa0ZK?=
 =?utf-8?B?RWw3UkYyYURrSVlFUzQzeWFoUjhjcksyelhYWERReHJpcnI3K2w5Smt1RVc4?=
 =?utf-8?B?U1lKMHE4K0xJanJjd1l4UmErZUNrMnM2MHFrSTBuUFNhWWVFWlcxQzloVklR?=
 =?utf-8?B?TkNxR0RaUC9aeW9JMWtzY2JVeTRqZTBXa0NsVTk5ODJVd2JnQUM0U0hFY3RL?=
 =?utf-8?B?ajM5WGlCczRWRWIrWkp3RDhkR1dsN2NKNEZPWnVOUFdJUHphN3ova1NkMjho?=
 =?utf-8?B?VmhyUmN4aU1uSEsyOHhtOUZjam5uRHU3V2JPTXVSMnRTMTF2L3RQemZmZTRX?=
 =?utf-8?B?STBBNmpnN2JCS1l1dHRBMzg0Yk5JUWFlL1lSRnZlZ29NUkhmY2xtVDFHcUhj?=
 =?utf-8?B?YVhuNVB1aTVvWXJwN3JlT2hrdEZxa3RHeTZ1NnBCWm55NDVNV21VSmdNV2lj?=
 =?utf-8?B?bFh6YkhpdVlOUDd2NUYwOE9OSFlmSncxazk0d3dYck04NE9ReFZWNklySnlC?=
 =?utf-8?B?cS93dXl4VXV1VUhPVzZ5b0F0TUdTbkhybDNWbFdmZ2hwZ1AwVlFEWUd6RXVw?=
 =?utf-8?B?c0hKTzlRRFVqUHlmREREVW5jZnpyc3ZNRk5zUGVDSmkvTmtxcDRUUTZWVW5u?=
 =?utf-8?B?dDZFQ05iWStoWkh5Wk9LTmZZT3NXb2FPa1JqZ2JidURKT1k5bXVRRkxzcjNQ?=
 =?utf-8?B?RTl5OUx5T2laVkdxbVdKaW9CT1dnUC93OU03dkdXWlhwM056WC95SHBuM0lo?=
 =?utf-8?B?NC95VGxEMHJhSjZyTW9HcXhUMEp2QjAyditTZGgzWjg2eE9hdmF2ZG45bk8z?=
 =?utf-8?B?WURlUXpJTjlBZVh0bi84UFAvRGZ6VnhhR1h1Z3hqWnJQck1WNjJpWWs3WjJa?=
 =?utf-8?B?TnpaRDJPNVdmd0hnaEJzTDNHWGNsVzdXanpLOTlNeHl6SFE5QnJpdXp1Z0Rj?=
 =?utf-8?B?cmNkS0dzYWg1Um9RWXdzU09BcE52bU40WUNicjdzSlUrVE1WSjhHd0J1ZFRo?=
 =?utf-8?B?QWMweTVQcXJhYXVETkQ1THRDbWxUMTU4SmQxMTZldlZSYzhWVWpMWnlNZWlF?=
 =?utf-8?B?QUJXNEZrcnc2Q1Y1SFdidjhveHRicDFqdzdvcUx2Qmloby96TllFWEtXT3Vv?=
 =?utf-8?B?cXhnaXkyQThZRFFXQ0J5WEpPQWkvZGE5bHdESjdheEd1NEtWeE1YYndDbGF3?=
 =?utf-8?B?T0l0OFBvYndhUUdIS2FhNTlTaHhPRDUvdjVlK2t6dUxGcDNhM2NVMHo0WTl0?=
 =?utf-8?B?SngydkVzaGlNa3hmUStsblNwQVV4WjhTK0hvais0azNRNzdmMUlJTzRQVjVn?=
 =?utf-8?B?V1BOOWV1ZGRWV1FEbjBHTjVvUmR4dDhGSzZDdDFkR1g4TlhaTi9vRmJoOVdF?=
 =?utf-8?B?c0FHb3lhY0dyTmJTUmFnR3pEZ3JHeDM5VkdlVUwzUlo0V2lJbEJrYnhxL2Y5?=
 =?utf-8?B?aWFmZ3JRTHJ2ZThhVjlTb09xNGRaQWNJcFI3VkZLNTZPcHo0SERZN3FEbTlB?=
 =?utf-8?B?VFVjcWNsbVpNQnRKWFNNT2JZTDF5L2JKRzNwMmNYWXh2anRXSlRPU1BuSVMz?=
 =?utf-8?B?STlJWnpyQ0VkSHBZL25tbTlHNkpUMU53VnduUkUvN3hOUUg4dmtQWW1IK1l5?=
 =?utf-8?B?S2daekdnNVp1UXVpVG1HNEhjaWlmS2dVek9vQjBrZFdBQmpIb0s1emhnY2xx?=
 =?utf-8?B?RFRWeXVrMVNEZURTOExKRmtyVHhEZ0UySFR0dkxyVzR0ZEZIZG1kSkxaTC9Y?=
 =?utf-8?Q?5Nbsss22cRc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(4053099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEc3MU1WSjBpeGtYWFNPM0VQcEQvY0s2d1BSQkpRdjhZTXhxeFlXazZhUUxY?=
 =?utf-8?B?WVlUMzJObmhub1FPY0lndjlBdjlTRnFvMWNURTkzTVIrZjd5Y3grTVlXWGU1?=
 =?utf-8?B?dkIxSUw5NTVIUWdyaEpaWVBSek5NREMyeU5pcjI1TFNaZDZwWGNuOWMrRFV0?=
 =?utf-8?B?Tk9SZ1RZN1d2eGpWbEorYnY5TWg5MWhBbURucE01SUw0Q2xjdkpMdmlzR2Ew?=
 =?utf-8?B?QkRlaXZaVFptME01T2JiNGwzUmtnZ0pBY1pDcHBlVXZ6OFRPeXpLOWpyRVNj?=
 =?utf-8?B?am1DQ2RKSjFPMUd6b2JiSWhsQjhkL3lGZ05jVDArT0xBL2p6QVFLcDMwSjJE?=
 =?utf-8?B?aTJDZ2JrTE9kVlY0ZHdKbUxJcmM1K0Rrb3J1OGxXZDJ0c1NRT2hiMGxldkdM?=
 =?utf-8?B?OUVZYzBscTV6RlBCOGFLRVVoUzZWYk1QQkhBeVpwSkRtTld0alBKWjFnYjBQ?=
 =?utf-8?B?dlFSVzhCdFExU2dpWm9SUVUwb3EvSlBCTDJVeUY1VmNvTjVJQ1l2OEEvV0N5?=
 =?utf-8?B?S3VGWmtMdWRxekJvT2dRT204clhGd096blJYSHZNbEhIWVpCRmZpbzlFdktD?=
 =?utf-8?B?and6emg2MHl6U0oybVNlQkVNU0pkYTZtRlN0bm5NSE5mUEhtN1VZVUxJd0lW?=
 =?utf-8?B?bmxTcmFHaE9kend2WnhrQm45MGhZVm1MSUVIdmlYMmhFWkhOZWtTdEdSN1p1?=
 =?utf-8?B?UXVxR0J0Y0xqaGVhREJReGdaNWJwSUVjKzVKWWROaVNOYVZ1M2ZiekFrbUo5?=
 =?utf-8?B?Z1FOcCtla0NRWDhQL1BIRWpRNjNibDBBdkRINXFsdjZCWmVtZmF4NU1IQWxB?=
 =?utf-8?B?UVAwUHFiYkdianE2UmhuUHlyaWpjSDVjYkdqWVlkeXBGbk96Lytyd1dhRGl2?=
 =?utf-8?B?WWk5SXlEY0hVcGQ4MXBUMkNNNUNSdzJheGl0eTRXU3NtRFZjSFRVWUN6MGlB?=
 =?utf-8?B?VFc1cXZTZDVxMGEvQW81ZzR6TzBmWnFINVVqR25TWEpGSVpwdkU5Z044bmY1?=
 =?utf-8?B?UjJ2ak8zcmhEZDZDeVMxdCtqSlJWUWtXOC92ckVueFptdmhOOTRsclBndHh2?=
 =?utf-8?B?YW9kbnU3dWhqYXdjUXRiSSt6ZkM3bDFXZVJjM0RocDNQQ21IVEJDRnFIUHRl?=
 =?utf-8?B?eDM1ZXBXNXlvNTg2aWZ0NHhnRWRRMDlVR25HM3F5blVpb3U4Z3EzWmFnL29J?=
 =?utf-8?B?ZmdDT0hmMEl2cU9tWVorUjBxVTdKWDlZMUNJOUZtZ0tYUWxzMHlUY2hBMS9R?=
 =?utf-8?B?Rm9NV1ZoaG5Gb1o1TFdLL0NZZjU3RFg1dGo1eFpERWhRNGNEd1ZpZ21SU24w?=
 =?utf-8?B?WWJ4MjZIVGtDR3FXUlc2OU1NTm5Hb2FpdXRnOUlaMjF6Y2VSUTU1REVtejdY?=
 =?utf-8?B?bFZia0N2TE9BMDl6eU1hdHhJWkhxbmFQMVBxWmNjRDNTTExxYnpNV2FKa1Er?=
 =?utf-8?B?anpwME9yeUZzbFNMbGFad2Flc1oyRVJsYjFvMlY4cFVpdGRoR2JDVWpWWFgr?=
 =?utf-8?B?QVM1VVF1bkx3TVdlUWUwV1B0Z2FMZ2pKdlN6bDdsSWU1NHFwMjRxcVVpZmdz?=
 =?utf-8?B?VGdjWVBhTXZJM0FMakROajZRSEROb1NTNzZwZXVQdDUvUEYvdDlidWw4K2tx?=
 =?utf-8?B?TUFEUGgrU2hJekFGWFlucGxCLzFRanNud0hPK0RRUmlLTWRrTlRmbm9kek9u?=
 =?utf-8?B?NmFyS2k0Y1ZvOHVTaHlZVlJJcXRKZWVTQ2EwQVJjUkZoMkljY3pleVhvd1lk?=
 =?utf-8?B?WVhHNDd1WkFRS0QvbGFmTVAwditVUmg3a2V4NGp0RmE4aDhOeGxYTXo2cG1Q?=
 =?utf-8?B?ZVptbjBHT21leFRGOXkybkpRK01HaUNKYkgyQXY1eXFMakpJb2lPTkw4enNx?=
 =?utf-8?B?SVBiMDlMYThCczZURFk2RzNibU94S3BFN2JGSEJDUkgxbGU1dmtNR05aUjhO?=
 =?utf-8?B?clVmelhIZGluZFFQdU1tTVcvVlBOMS8xMVV4UXAxUzNxZnU0QU9PS0FPeGNh?=
 =?utf-8?B?L3ZOWE14VGthcm1LZGVMaEdjZDhFRWp0cFlZQzQwcWhkK2hNU2crVjlwMHBz?=
 =?utf-8?B?VHorcUovQWlSTk9lQnlhYjNwZ3JFUCttSWJVVktHZWs2NEdvaXpYMmhhbWxU?=
 =?utf-8?B?dUlWZmdNZGp0REt1c3dqRFprYTA2dHA5b2pEM0lJaGZXeW1FRHhRQmRRVk5S?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QmhHCNgQDKSqhdg1G1iwY09/ahF+BeeAx7nS5w6NV+ieEGXZY3ankKZcy79Sz2CwbGCEoHDWOupTmTlJli02dzdWBOm5QFOfZcpLmKHdbuvufZOWaigldKicyiPzYzWwyeLfnQii3r3GUhbT74WCA6wkzcDFJ/v/c/3RyyPyBfZAkibYZ9mO6EFgRaegV22yldVcHPpZeg0vm9SDp1teypAlGbwhRkmsFnv0Qpsd1JN1Ao0hMjUlz778zypSQ3gyk+kEECgC/PCba9UFar85TMIJzZ3Qb5a1DTVfZFGCLIx6l+RrFWpNDhk77g8XyDIVzVUK07LUQZ5Oy+yHGfzNA0RfAScI5r7YP5JpP08zKKN+YFKBtX7LAuCO1zR55bqxU+lNB3SsGG0Ql6R1aThllOimGT3Avf0+pqunQL210df8vnqMOz/8sgrrbH5prgsbuNn3XjRXKnTdjYDl0rkr3BK+JXwYSqoR1Jt/tQgVpku+GhChh7z/AzQu5vJ+ka5DSX14HTvVL4aa9oBtCypYP9QdEWvbmDfRNlfVaQczVJObd6bqRcM9wzz1rmC5SpSwtezt2JB2nKhrkl3SnDs7DG+Fa8it3oDIpR4ZsE5Is0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99daada2-c92a-483d-1d7e-08dde733752d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 19:37:15.8147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3g8+LESUAJcYpMJdopbFtXEcOaI3zu1YByw1tnk/zCRvmsk1Lo7vu76wdsbo259LshqIP6Aeoood7ArgkZBicvLSR+zfHWbBWCl4m1sJTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDA2AE39DA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508290174
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX7CsRvaMu9uBO
 zZaIXS0KoiCHWkRJBA7AZnWs46SMMe6IYFy4Id/sJ1Ld5nw6lR1wBG6qmoQnk0EV8r0mjMFNDa6
 6mFu1UCMXNJ8dZkq3Cc3Z29Qu+t8r+MzyYUrPTYJhPjX9+D9l4r8yre4itwZ/VIZO635QdeC38q
 JJU4Fa2YWw13PdpRD4OyXUlyoF3I8OZJ0Yf9z9eRitsVANq+hVpUUQHlbzxxizNIyDNxzeb78kr
 mUyDwZl9s9xxw72Uya0JiiKGjYgLy/Zd38kVY3oQGRyIvrGlI2ieH4VN03xUyNosXLyPuRTBAtq
 YVLdizGZNTY0Yl3af646dCODpV6SlzKXXRBOFYGmtF1NYSAs+qG4KxkVH/egsYQYXNPLXrszxi3
 4qGERVqP
X-Proofpoint-GUID: rc6Fkm_ruNKkBW_hq4qFRjdyiSldxbVe
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68b20173 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=dzHq3nH22_lch1jbgFcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=C-eOVxJW3LoQiB8EbVoA:9 a=B2y7HmGcmWMA:10
X-Proofpoint-ORIG-GUID: rc6Fkm_ruNKkBW_hq4qFRjdyiSldxbVe
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

--------------arQYXqlIxF0D6Gg71hBADYR0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/28/2025 11:48 AM, Steven Sistare wrote:
> On 8/23/2025 5:53 PM, Vladimir Sementsov-Ogievskiy wrote:
>> On 17.07.25 21:39, Steve Sistare wrote:
>>> Tap and vhost devices can be preserved during cpr-transfer using
>>> traditional live migration methods, wherein the management layer
>>> creates new interfaces for the target and fiddles with 'ip link'
>>> to deactivate the old interface and activate the new.
>>>
>>> However, CPR can simply send the file descriptors to new QEMU,
>>> with no special management actions required.  The user enables
>>> this behavior by specifing '-netdev tap,cpr=on'.  The default
>>> is cpr=off.
>>
>> Hi Steve!
>>
>> First, me trying to test the series:
> 
> Thank-you Vladimir for all the work you are doing in this area.  I have
> reproduced the "virtio_net_set_queue_pairs: Assertion `!r' failed." bug.
> Let me dig into that before I study the larger questions you pose
> about preserving tap/vhost-user-blk in local migration versus cpr.

I have reproduced your journey!  I fixed the assertion, the vnet_hdr, and
the blocking fd problems which you allude to.  The attached patch fixes
them, and will be squashed into the series.

Ben, you also reported the !r assertion failure, so this fix should help
you also.

>> SOURCE:
>>
>> sudo build/qemu-system-x86_64 -display none -vga none -device pxb-pcie,bus_nr=128,bus=pcie.0,id=pcie.1 -device pcie-root-port,id=s0,slot=0,bus=pcie.1 -device pcie-root-port,id=s1,slot=1,bus=pcie.1 -device pcie-root-port,id=s2,slot=2,bus=pcie.1 -hda /home/vsementsov/work/vms/newfocal.raw -m 4G -enable-kvm -M q35 -vnc :0 -nodefaults -vga std -qmp stdio -msg timestamp -S -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -machine memory-backend=ram0 -machine aux-ram-share=on
>>
>> {"execute": "qmp_capabilities"}
>> {"return": {}}
>> {"execute": "netdev_add", "arguments": {"cpr": true, "script": "no", "downscript": "no", "vhostforce": false, "vhost": false, "queues": 4, "ifname": "tap0", "type": "tap", "id": "netdev.1"}}
>> {"return": {}}
>> {"execute": "device_add", "arguments": {"disable-legacy": "off", "bus": "s1", "netdev": "netdev.1", "driver": "virtio-net-pci", "vectors": 18, "mq": true, "romfile": "", "mac": "d6:0d:75:f8:0f:b7", "id": "vnet.1"}}
>> {"return": {}}
>> {"execute": "cont"}
>> {"timestamp": {"seconds": 1755977653, "microseconds": 248749}, "event": "RESUME"}
>> {"return": {}}
>> {"timestamp": {"seconds": 1755977657, "microseconds": 366274}, "event": "NIC_RX_FILTER_CHANGED", "data": {"name": "vnet.1", "path": "/machine/peripheral/vnet.1/virtio-backend"}}
>> {"execute": "migrate-set-parameters", "arguments": {"mode": "cpr-transfer"}}
>> {"return": {}}
>> {"execute": "migrate", "arguments": {"channels": [{"channel-type": "main", "addr": {"path": "/tmp/migr.sock", "transport": "socket", "type": "unix"}}, {"channel-type": "cpr", "addr": {"path": "/tmp/cpr.sock", "transport": "socket", "type": "unix"}}]}}
>> {"timestamp": {"seconds": 1755977767, "microseconds": 835571}, "event": "STOP"}
>> {"return": {}}
>>
>> TARGET:
>>
>> sudo build/qemu-system-x86_64 -display none -vga none -device pxb-pcie,bus_nr=128,bus=pcie.0,id=pcie.1 -device pcie-root-port,id=s0,slot=0,bus=pcie.1 -device pcie-root-port,id=s1,slot=1,bus=pcie.1 -device pcie-root-port,id=s2,slot=2,bus=pcie.1 -hda /home/vsementsov/work/vms/newfocal.raw -m 4G -enable-kvm -M q35 -vnc :1 -nodefaults -vga std -qmp stdio -S -object memory-backend-file,id=ram0,size=4G,mem-p
>> ath=/dev/shm/ram0,share=on -machine memory-backend=ram0 -machine aux-ram-share=on -incoming defer -incoming '{"channel-type": "cpr","addr": { "transport": "socket","type": "unix", "path": "/tmp/cpr.sock"}}'
>>
>> <need to wait until "migrate" on source>
>>
>> {"execute": "qmp_capabilities"}
>> {"return": {}}
>> {"execute": "netdev_add", "arguments": {"cpr": true, "script": "no", "downscript": "no", "vhostforce": false, "vhost": false, "queues": 4, "ifname": "tap0", "type": "tap", "id": "netdev.1"}}
>> {"return": {}}
>> {"execute": "device_add", "arguments": {"disable-legacy": "off", "bus": "s1", "netdev": "netdev.1", "driver": "virtio-net-pci", "vectors": 18, "mq": true, "romfile": "", "mac": "d6:0d:75:f8:0f:b7", "id": "vnet.1"}}
>> could not disable queue
>> qemu-system-x86_64: ../hw/net/virtio-net.c:771: virtio_net_set_queue_pairs: Assertion `!r' failed.
>> fish: Job 1, 'sudo build/qemu-system-x86_64 -…' terminated by signal SIGABRT (Abort)
>>
>> So, it crashes on device_add..
>>
>> Second, I've come a long way, backporting you TAP v1 series together with needed parts of CPR and migration channels to QEMU 7.2, fixing different issues (like, avoid reinitialization of vnet_hdr length on target, avoid simultaneous use of tap on source an target, avoid making the fd blocking again on target), and it finally started to work.
>>
>> But next, I went to support similar migration for vhost-user-blk, and that was a lot more complex. No reason to pass an fd in preliminary stage, when source is running (like in CPR), because:
>>
>> 1. we just can't use the fd on target at all, until we stop use it on source, otherwise we just break vhost-user-blk protocol on the wire (unlike TAP, where some ioctls called on target doesn't break source)
>> 2. we have to pass enough additional variables, which are simpler to pass through normal migration channel (how to pass anything except fds through cpr channel?)

You can pass extra state through the cpr channel.  See for example vmstate_cpr_vfio_device,
and how vmstate_cpr_vfio_devices is defined as a sub-section of vmstate_cpr_state.

>> So, I decided to go another way, and just migrate everything backend-related including fds through main migration channel. Of course, this requires deep reworking of device initialization in case of incoming migration (but for vhost-user-blk we need it anyway). The feature is in my series "[PATCH 00/33] vhost-user-blk: live-backend local migration" (you are in CC).

You did a lot of work in those series!
I suspect much less rework of initialization is required if you pass variables in cpr state.

>> The success with vhost-user-blk (of-course) make me rethink TAP migration too: try to avoid using additional cpr channel and unusual waiting for QMP interface on target. And, I've just sent an RFC: "[RFC 0/7] virtio-net: live-TAP local migration"

Is there a use case for this outside of CPR?
CPR is intended to be the "local migration" solution that does it all :)
But if you do proceed with your local migration tap solution, I would want
to see that CPR could also use your code paths.

- Steve

--------------arQYXqlIxF0D6Gg71hBADYR0
Content-Type: text/plain; charset=UTF-8; name="0001-tap-cpr-fixes.patch"
Content-Disposition: attachment; filename="0001-tap-cpr-fixes.patch"
Content-Transfer-Encoding: base64

RnJvbSAxOTE1MjEyMTAyMjI2Mzg5NDBjMTdkNGRhZWZjMzEzZDRhZDYxYWEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUu
Y29tPgpEYXRlOiBUaHUsIDI4IEF1ZyAyMDI1IDEzOjQ3OjE1IC0wNzAwClN1YmplY3Q6IFtQQVRD
SF0gdGFwOiBjcHIgZml4ZXMKCkZpeCAidmlydGlvX25ldF9zZXRfcXVldWVfcGFpcnM6IEFzc2Vy
dGlvbiBgIXInIGZhaWxlZC4iCkZpeCAidmlydGlvLW5ldDogc2F2ZWQgaW1hZ2UgcmVxdWlyZXMg
dm5ldF9oZHI9b24iCkRvIG5vdCBjaGFuZ2UgYmxvY2tpbmcgbW9kZSBvZiBpbmNvbWluZyBjcHIg
ZmQncy4KClJlcG9ydGVkLWJ5OiBCZW4gQ2hhbmV5IDxiY2hhbmV5QGFrYW1haS5jb20+ClJlcG9y
dGVkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHlhbmRleC10
ZWFtLnJ1PgoKU2lnbmVkLW9mZi1ieTogU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3Jh
Y2xlLmNvbT4KLS0tCiBody9uZXQvdmlydGlvLW5ldC5jIHwgNiArKysrKysKIGlvL2NoYW5uZWwt
c29ja2V0LmMgfCA1ICsrKystCiBuZXQvdGFwLmMgICAgICAgICAgIHwgMiArKwogc3R1YnMvY3By
LmMgICAgICAgICB8IDUgKysrKysKIDQgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2h3L25ldC92aXJ0aW8tbmV0LmMgYi9ody9uZXQv
dmlydGlvLW5ldC5jCmluZGV4IDdjNDBjY2EuLjdkZDhhODAgMTAwNjQ0Ci0tLSBhL2h3L25ldC92
aXJ0aW8tbmV0LmMKKysrIGIvaHcvbmV0L3ZpcnRpby1uZXQuYwpAQCAtMzcsNiArMzcsNyBAQAog
I2luY2x1ZGUgInFhcGkvcWFwaS10eXBlcy1taWdyYXRpb24uaCIKICNpbmNsdWRlICJxYXBpL3Fh
cGktZXZlbnRzLW1pZ3JhdGlvbi5oIgogI2luY2x1ZGUgImh3L3ZpcnRpby92aXJ0aW8tYWNjZXNz
LmgiCisjaW5jbHVkZSAibWlncmF0aW9uL2Nwci5oIgogI2luY2x1ZGUgIm1pZ3JhdGlvbi9taXNj
LmgiCiAjaW5jbHVkZSAic3RhbmRhcmQtaGVhZGVycy9saW51eC9ldGh0b29sLmgiCiAjaW5jbHVk
ZSAic3lzdGVtL3N5c3RlbS5oIgpAQCAtNzU4LDYgKzc1OSwxMSBAQCBzdGF0aWMgdm9pZCB2aXJ0
aW9fbmV0X3NldF9xdWV1ZV9wYWlycyhWaXJ0SU9OZXQgKm4pCiAgICAgaW50IGk7CiAgICAgaW50
IHI7CiAKKyAgICBpZiAoY3ByX2lzX2luY29taW5nKCkpIHsKKyAgICAgICAgLyogcGVlcnMgYXJl
IGFscmVhZHkgYXR0YWNoZWQsIGRvIG5vdGhpbmcgKi8KKyAgICAgICAgcmV0dXJuOworICAgIH0K
KwogICAgIGlmIChuLT5uaWMtPnBlZXJfZGVsZXRlZCkgewogICAgICAgICByZXR1cm47CiAgICAg
fQpkaWZmIC0tZ2l0IGEvaW8vY2hhbm5lbC1zb2NrZXQuYyBiL2lvL2NoYW5uZWwtc29ja2V0LmMK
aW5kZXggM2I3Y2E5Mi4uNzM2ZDM5ZCAxMDA2NDQKLS0tIGEvaW8vY2hhbm5lbC1zb2NrZXQuYwor
KysgYi9pby9jaGFubmVsLXNvY2tldC5jCkBAIC0yNCw2ICsyNCw3IEBACiAjaW5jbHVkZSAiaW8v
Y2hhbm5lbC1zb2NrZXQuaCIKICNpbmNsdWRlICJpby9jaGFubmVsLXV0aWwuaCIKICNpbmNsdWRl
ICJpby9jaGFubmVsLXdhdGNoLmgiCisjaW5jbHVkZSAibWlncmF0aW9uL2Nwci5oIgogI2luY2x1
ZGUgInRyYWNlLmgiCiAjaW5jbHVkZSAicWFwaS9jbG9uZS12aXNpdG9yLmgiCiAjaWZkZWYgQ09O
RklHX0xJTlVYCkBAIC00OTgsNyArNDk5LDkgQEAgc3RhdGljIHZvaWQgcWlvX2NoYW5uZWxfc29j
a2V0X2NvcHlfZmRzKHN0cnVjdCBtc2doZHIgKm1zZywKICAgICAgICAgICAgIH0KIAogICAgICAg
ICAgICAgLyogT19OT05CTE9DSyBpcyBwcmVzZXJ2ZWQgYWNyb3NzIFNDTV9SSUdIVFMgc28gcmVz
ZXQgaXQgKi8KLSAgICAgICAgICAgIHFlbXVfc29ja2V0X3NldF9ibG9jayhmZCk7CisgICAgICAg
ICAgICBpZiAoIWNwcl9pc19pbmNvbWluZygpKSB7CisgICAgICAgICAgICAgICAgcWVtdV9zb2Nr
ZXRfc2V0X2Jsb2NrKGZkKTsKKyAgICAgICAgICAgIH0KIAogI2lmbmRlZiBNU0dfQ01TR19DTE9F
WEVDCiAgICAgICAgICAgICBxZW11X3NldF9jbG9leGVjKGZkKTsKZGlmZiAtLWdpdCBhL25ldC90
YXAuYyBiL25ldC90YXAuYwppbmRleCAyNWZmOTZmLi5mOTVmZmU5IDEwMDY0NAotLS0gYS9uZXQv
dGFwLmMKKysrIGIvbmV0L3RhcC5jCkBAIC0xMDQyLDYgKzEwNDIsOCBAQCBmcmVlX2ZhaWw6CiAg
ICAgICAgICAgICAgICAgaWYgKGNwciAmJiBmZCA+PSAwKSB7CiAgICAgICAgICAgICAgICAgICAg
IGNwcl9zYXZlX2ZkKG5hbWUsIFRBUF9GRF9JTkRFWChpKSwgZmQpOwogICAgICAgICAgICAgICAg
IH0KKyAgICAgICAgICAgIH0gZWxzZSB7CisgICAgICAgICAgICAgICAgdm5ldF9oZHIgPSB0YXAt
Pmhhc192bmV0X2hkciA/IHRhcC0+dm5ldF9oZHIgOiAxOwogICAgICAgICAgICAgfQogICAgICAg
ICAgICAgaWYgKGZkID09IC0xKSB7CiAgICAgICAgICAgICAgICAgcmV0ID0gLTE7CmRpZmYgLS1n
aXQgYS9zdHVicy9jcHIuYyBiL3N0dWJzL2Nwci5jCmluZGV4IDZhNWMzMjAuLjg2YTUwN2MgMTAw
NjQ0Ci0tLSBhL3N0dWJzL2Nwci5jCisrKyBiL3N0dWJzL2Nwci5jCkBAIC0xOSwzICsxOSw4IEBA
IGludCBjcHJfZmluZF9mZChjb25zdCBjaGFyICpuYW1lLCBpbnQgaWQpCiB7CiAgICAgcmV0dXJu
IC0xOwogfQorCitib29sIGNwcl9pc19pbmNvbWluZyh2b2lkKQoreworICAgIHJldHVybiBmYWxz
ZTsKK30KLS0gCjEuOC4zLjEKCg==

--------------arQYXqlIxF0D6Gg71hBADYR0--

