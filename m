Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175CBC25B5C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ysh-0004Xi-LR; Thu, 02 May 2024 12:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s2YrP-00048h-5u
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:00:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s2YrJ-0003pi-Qg
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:00:38 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 442Fi2Eu002223; Thu, 2 May 2024 16:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JrgMwAFmHc8pQrwHG7t8IYr2ZYIA9uGx1AXTTbEXurc=;
 b=TZt4CurLRS6nCiB7oOjKAYDIBDxi3y8MZ/uabuyxNOnA89DhO97ki6Mdzu72HjdC3d1Q
 8T1jeGSHVzGdhv0fjmLL06zAeZHovD/zckWKGcnewizb2+lBBzekmiY3Y9vr/tlYIeeP
 C9C+wa76YTDQ47tNZsRkyCitqbcdTVK6uGWjM7GyIUY7UIWH1NIYs8elfu86e5u+h1Ta
 8rH5SMPBiTrM6lDSXeZefakmkfaeOPJ0CR/kLCkNyWNWfbPDkxXWNTbkUQ0sx4Ot1NUu
 3yYh9T2Y5PUqqce8dr2HHuBkV5xGayO1oB/Nwa/nQfCnXh9IpNTqutH0Kofq1xr5HPlP dQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsf603a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 May 2024 16:00:29 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 442Fj9pS019895; Thu, 2 May 2024 16:00:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqtamtd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 May 2024 16:00:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTPsvGFgrm8nvZG2Aommjb6rnUdqt003ZKX3mqzJfsuqOI8eK0FzZGY+WYflMrdv+/qncL4y7B5wKONRw++VWmy984Ss9s1yVoiDsGu73hb2QUuG32RlXkdw5lLLBoL3jmDL1H34SH+EDLrRc2nYcsy7ADNYv5nBAifUSZf4i1de5IlshWd/s/K5NOX1fzkArXbb5zAqoUtN7hX4kx2dgywFckC8mV4QKc8TxYMKEPdcTKu1/hJnqfIkeD0aoOtGlbSuflJoWhk13yzsZNlhYiFBZZzlpQZ/8l2wiFst/g4Tft4ma/QtKxQc8zv3vJI+SJobtx5L85r2K5cFOjYNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrgMwAFmHc8pQrwHG7t8IYr2ZYIA9uGx1AXTTbEXurc=;
 b=nR1Ix1baMpJV0noTzWYAGQgy4VGJI2lKbjGe9kwAouidgE3vejH0rNL0TnNoU00yOi+OfJ9qIfAgvlcVAfrstC5Seey3jiQOTwVImBvRJmyG1B0yKHdfQL5tPiMn//S+t08D4Dmt3wkQMnvKLh/ebIcKJZljb2Q6eO4Py4oCF1TcB0LhtaigUzuKXe2udzKbtF00fs1c0pa1snd8ssPQdyNnwE5z7g3U0MBwEfqvJkBt9NYWnJC19tUqyWsOMq6jk2vUBeaexlqc8Y3ZtQZ57JMA0onBycUHEVGPxoTIXJ2b5mHfizf0Cq5hI21SR6eMi29h9Iph2zMHrNGLdQktRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrgMwAFmHc8pQrwHG7t8IYr2ZYIA9uGx1AXTTbEXurc=;
 b=wMrN2XmwBTgCCTY1MMzp0XTN3Pgex6Kmhj92rYIMLECnQhOTe/rG6Bskpytp/Sp+UXBjzftuipdOgJXUZzrYzmhOhrtbohQ77tJjcRU5VG4eHQU3viKMPBPgmGH8mgqKG1jvjdjIvwgGxaRy703dKXNtcbKzW+r0/H8cwhqFefY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BLAPR10MB4930.namprd10.prod.outlook.com (2603:10b6:208:323::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 16:00:26 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 16:00:26 +0000
Message-ID: <39b6e4b1-1910-4411-a3f0-d96214bcd6d6@oracle.com>
Date: Thu, 2 May 2024 12:00:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 20/26] migration: cpr-exec mode
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-21-git-send-email-steven.sistare@oracle.com>
 <87bk5o7679.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87bk5o7679.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:208:23d::32) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BLAPR10MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c44ac78-c433-415d-2dee-08dc6ac0fb08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlJFWGRBOVdhY3Y5NHZVcFFnN05KY1l4L0pISjJvOHVjQm1aaGhTUEpYVEt4?=
 =?utf-8?B?cTRIVE1LRXpBeVpsWVQvN0hHY0RYZE15bDBBMlBibmR1NTVpa2ZSNng2TmND?=
 =?utf-8?B?RUszazhEN3Vrc3pPMVFmZEJMVWhiemNmQzJ4RGN1d1JJOERqMkFvVnVRSVhm?=
 =?utf-8?B?MWduNm45MUhUWVBuaFI5Ui9ZT2hCZ1ZNaVB1SzhxM08xVnU1dmJzQ1VEMEpW?=
 =?utf-8?B?R1BidnVwMDVxaEpTU01uNS83TzdHbHAxWEYzQmFuRmtobnBJR1VlaWJaNXVq?=
 =?utf-8?B?UTdpT1VTZkFNWmFXUFVhcFBSRW9jZk9MQWtGK3pkN0FtRFRib0FOOHpETEJl?=
 =?utf-8?B?UWd4aXh4M1VURkZUVVg2WWxlWE9FM1N4M3hLblpEaFdRUEVMYzBDMitjUk9u?=
 =?utf-8?B?U3o1aE90aS8vTVZVSi83REp0TG0rWnp0Sm1BWDJ0eDJSa3ZqRndCU3JSdXJQ?=
 =?utf-8?B?dG12c1BPTlRabW1MNlQ4aGZacm81UXF6UGM4N3NDOW1DanEwdFY3Y2lvenl0?=
 =?utf-8?B?a1plTWhTMlZGNk04LzE5NUtKVENYcjhGdHBWYmoraEwydFJYbFcyQ2hPb3RJ?=
 =?utf-8?B?bG56VkNFNWYvOTB1NU1IMlNJclMvSXM0RjVtaHZHeEZhQ05xVUZBeUl4RFI5?=
 =?utf-8?B?QnVkNFp6QlREMG1zbGFZdzVuUXZVbDloQkxSelh5STJHRVQ0ZU5FVENvQkRK?=
 =?utf-8?B?VUcyRnE3TGlsdkJRQzdqeXBlcDRhNWdYWnluQ3lUNGUxcU9zQnJFcUE0Y3Zq?=
 =?utf-8?B?TVdaZFpWWWo2eVhvb2dpaTAxektUL3pvSVI1aWI5UFpRN2ZqbGFrRXJZWXpP?=
 =?utf-8?B?Mk9GbDN5aGhnakRlMzRLUkNsRzFMQ09uM0pTSk42UnpUNEowUXJMV25Gc0Uz?=
 =?utf-8?B?VEVxSVFVaFE5V2kzN0YyNWlQQzA5bG5RSHptY3lqWm1ZNnNTYURlNnRpMEZz?=
 =?utf-8?B?ZnhtbkU5bmd0eERqdjNVbW41Y1NxQm4xZmFyamVJcnVheGljSllrbGVQeGQ1?=
 =?utf-8?B?c2lMZEc3MUlrRUl4SjdmUkFZdUtpbnRkSmh0NjBsdStxR3Fld3lTWGN0RnhN?=
 =?utf-8?B?WUVaeFhpeHNGOFV5TzZVUmRza0p4TXBvU2c0eDVlVHdRV1dOZ2g4SlFxbm9T?=
 =?utf-8?B?VUE3cGdOVVFJL3NNNDVPTEV3cUJ3eHg0YmdEa3hnTkNKUkdtMnJCUHJRWGw4?=
 =?utf-8?B?WGdlakY3SFRMenplUThJN1pYVVJicVRhdk9VeGx3clVyK3ltQVQ1Q2ZVMWwz?=
 =?utf-8?B?RlpKYVMzUkRyL2dPR0g4ajhGT3JkTlo2c0F1ay8xY0wrRzNGLysvcFlBVTMy?=
 =?utf-8?B?N0dBbC9tY0VuZmh0czB6aGVmeG9RbUEyMzZTZi9EUXhNNkRuRnc0WkFHRjZC?=
 =?utf-8?B?VFhlbjdsL0YvamRzeHBoZmJielVYNitKN25Hdjl2TmVBUTBWYXRXKzlCczQ2?=
 =?utf-8?B?MjVHKzBXZmhOd3RjNXhjbmd3T2pkTzdLWVNHb1ZrZGliVTI5cFlVc2NRdThV?=
 =?utf-8?B?MGlmVThKTU1ac0VHM2NGZ2V0a1p4SWlvSTM2eXhYWDdLOXorSitKQkhMbUFn?=
 =?utf-8?B?cEFZNjE4aDlXTkpyL3RodE5mODZ5RDc2YXNhN3diMmh2QnBwZ2F0c0lXUW1N?=
 =?utf-8?B?UTFBRXdGVzFXaGdpSUlLd1VJc0JtcjBZRTh2b3NJd245YVZoK2hycFkySmVx?=
 =?utf-8?B?NWt5Uy9DWWhFME5maHdRNTJhK3JHK3JTQnI2MzUyZjNGVVRqM05iTDRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkY0emNsVEFhUnpaUmxJRWNzdkswWGZTYmFuVVdLbE1rcnNBM25FVDMyQWlr?=
 =?utf-8?B?T1hlK2tuR0lDZ1Y2SjdvejBzcE1GNTh4SVJaS1dIZEcreEsrZGJLbFI2aFNV?=
 =?utf-8?B?TFVqckQ3R1kwSkhXb0Q4SEtjdUkrZ2lNN0lJL09NSUFURFNmWFNtTWxUOFds?=
 =?utf-8?B?L0JRUGIrRzl6NGhJRTJxTVN5akp1SVNFUk0vWjR2bWU3NlRlZTRoWHBYcSth?=
 =?utf-8?B?eVdTbkJnL3ZPM2wwREIvYkVsVzRFMWJQZW53UHhJMk9vaE1hbEYwckdVakxR?=
 =?utf-8?B?YUd0ZlZOSlI3MnNkc2RvY2RwYnFFUEM1UkFSTHJQNE84b2g0aWlkRFJZY3lm?=
 =?utf-8?B?cDg2QTNISjZFMTNrNjI5bkwrQzY5bG5Db0w4d2dJWnpUcUtsbHJoNDUvQTlT?=
 =?utf-8?B?WGh3VzNQcDRRYlZ1NW5qaUd5VjRSMkN6T2QzY2NoNCtzU2RhR1BXYldZdXBW?=
 =?utf-8?B?MGtadTBoMGhnemVuV200aXlLaXFPRVplYzZ2NG5JUDVVdWFDcit0UU11YlJ3?=
 =?utf-8?B?SysrWURsbFQ0S1NtdHR2WndDS1FMRWVKWGZEL1E3RW1CS0JMZWI2eCsrbVR5?=
 =?utf-8?B?M1RYMDBmTiswUXI2U2l1ZE5ndkVKTEtzWkN5R2h2bm8xYXNqb3FKSXNtZ1Vs?=
 =?utf-8?B?Mnk5NUwrZ2JFaFYyOEFjakJ6dEhQNWJEdkNmODd5ZGJBaTNuZHh5NG83R1px?=
 =?utf-8?B?K0RLZWRTaW1NK0VSSTRLRkZYcVlqVGFvWEJySVhmZWhpeVltRjRocURwdDBy?=
 =?utf-8?B?aUNvRVA1dmtXNzdUWmxYNDVKM01NaUtSeVJiUTBwZlg4ZHlvK1A4UERGNWQy?=
 =?utf-8?B?OWpBZldXeDlUVGp5VC9sV05ud1BiY3Y5aFRZZkZIQzZTVEIrYUpMOHNueXVC?=
 =?utf-8?B?VGxWV1pvWHR1S09KV1lFRHVVVEVYYlVDUDNPTmp0RHh1Skh6QmFmeFBUejdC?=
 =?utf-8?B?VlM5cmVzdmlMZG1WSk0zTlg2by8rRXBGb2lVd1hmTnI2Nm1meWtmdTVxSFdH?=
 =?utf-8?B?QWZTUTRCR2dwWG9oZ2FRZjJDNFhKamh1WjV6M2xqaWpXS084dUZ2eDAxc2xV?=
 =?utf-8?B?UlpwZkdVYjBQMlZuOXdPeE91OWdZbEtNKzhxaHNVN0ZSSkdEZWNzTEEyS2ZD?=
 =?utf-8?B?Z2dVbHhiVURvQWRVLzh3aFU4ZDRoQTNIWXNPVVdvR2VCWEdGb1pEVnptbUZT?=
 =?utf-8?B?b3lDY1NoWVJrK2hMcExkdnJXZCtWRW5wb1lnUUhTQTlYQzd0TzhtbmhPalBW?=
 =?utf-8?B?emhDOTRzRFFQRkdNSUUxVk9pKzkxT2FWdVRHUjFHVjNNbHp4clM3ejR2RFFs?=
 =?utf-8?B?QXVxMVA2WjJ1ckZ4eHNUOXdJM0pzcTRpMitoZ0tkcHBRY1FyT2pKQVh2ZDNJ?=
 =?utf-8?B?VTc3bUswWmNKUEFUUytYdVRXd0l3RGxYMS9EcHJrYVlEMGxMSVExbnptNGhD?=
 =?utf-8?B?ZkJ5S1kxMzNjK24xd3RLWFpHQUR5TnBpb1BsSGI5cVFiKzJ1cnRHVW03NVhh?=
 =?utf-8?B?ak9ib0RBd3l3QW8yNXJlRmwreDRxQlJ0QnF0dmRrbHByVFhacERLYVhCdWtx?=
 =?utf-8?B?eEcvM0ZBQVFSN0F0aG5qalJ5dW1KRk1RdFAxZ2FPaTYxVzEyVmpQdlFKbFV2?=
 =?utf-8?B?WFU3QkI1ZGQ5Qjd0SmpMNlIyb2xzQ2toWEdEMEdzSEF0cmhWd3VRb2JURElv?=
 =?utf-8?B?T1FqcmdxaEhLRkIxSTl6V0JRUFZTMitMMitsR3FGN2kwWEZzaFZvWXdieCtl?=
 =?utf-8?B?SjdSSktqWUtxSjA0bE42cHBNQlRFSnh1aTVBNTZRenZURnZ5a1NBSjhhcm1n?=
 =?utf-8?B?RmJ0bTF4YkJTYURxc2ROUWY5dURaQVF4STFDM1BrVU5senBNazZqM3RTR1hB?=
 =?utf-8?B?NHovVS8ybENQWHhsWXZXQXFGWFNKQ1RrM0FjR0VNTmJzYlJBZzYzM3lwYmNu?=
 =?utf-8?B?bkNMenVrZTd6RnQzSm5Ua3hLdkh1Y29VMkJ5UDNQSEJJYm1sMlJVMUpFMEsr?=
 =?utf-8?B?RUg2T054cG5tWWErVlVveHA5Sk9SZWR0eXpCZmkwUGFCV2hwdWZibVpQdkNr?=
 =?utf-8?B?QTlEUUhJUEFBZGw0bmR4a1hCMHJjdWwyVTBVZzl1SmV5R1Z3N1h5RkY0Y0pD?=
 =?utf-8?B?WWgxSDlxTWdCTUdVb2RWMWZwL00xTXkxRmlQc0czRStPb3JTMmhlcTFNdEk2?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rCVRExcPRH0XqGCv1oLol+ddECrr0p8DyrK/3GDtc59SMD6uwr4qmqJu0xsUwQoD3jxpIGOwPOB+6s+lBMDP4P/jJSpgU+5hOSIXNwJF1qztVPPKFclyLclzcd0cfrhfYtGiR8PD5+yF6fpPSQy/5kP7GKjUOaHxF9Osp6RRx2PaB6x4/YfMbaIjpytrtOUE0HSy2BocaNzEN+cUnONeIpzsUt/D6bEqmqOX82uZeY/N6n/x4gqTHiUmfpB7ZhJGkqnKaTvjyUzw1oszepdIlEG9ZY8cUkP9W2frDZT9TQbWDqpMI/13ywOoGkJVhSg8XgAsNL7YAfcfa9M+a7VY4ZZlncxvvlPCa4yfqsRWl7kK2GHK3NDGtVF91SY1KUe6whPQqy6t84N5Ox+ibR5VOWmvWhpt8bHyQ1Spy+Lwo7+QVI+IHwJO4PZae2ibRj2t7VsTG/+1pC35lDULkh5wfIvyvpaXRLDvYVwQ+F9vuElM/ygq0CNGBLAsW1NHWhphvFOGr/aVf6GcEwmByxklU305qb9vIlwNvLcuKCinH0JkDkXeTG3lNHn+QVeg/pEW3eHrq393QveW8lths9L0kuYTCF8T0bKl7ISGayYMf1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c44ac78-c433-415d-2dee-08dc6ac0fb08
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:00:25.9233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAx3T2EgF3prvKavEiTFN1aGH+tDJbZjiVLn7ljWF7fghZkyF1ik6N8rvlY3sYgci1u/GtCZk2ORpIJWwMUW+BR6FedidezZVh5Zdr8MNGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_05,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020106
X-Proofpoint-ORIG-GUID: l1LVD-AlCxUdBTxwWkFOzz6NAfdMVswM
X-Proofpoint-GUID: l1LVD-AlCxUdBTxwWkFOzz6NAfdMVswM
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/2/2024 8:23 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Add the cpr-exec migration mode.  Usage:
>>    qemu-system-$arch -machine memfd-alloc=on ...
>>    migrate_set_parameter mode cpr-exec
>>    migrate_set_parameter cpr-exec-args \
>>      <arg1> <arg2> ... -incoming <uri>
>>    migrate -d <uri>
>>
>> The migrate command stops the VM, saves state to the URI,
>> directly exec's a new version of QEMU on the same host,
>> replacing the original process while retaining its PID, and
>> loads state from the URI.  Guest RAM is preserved in place,
>> albeit with new virtual addresses.
>>
>> Arguments for the new QEMU process are taken from the
>> @cpr-exec-args parameter.  The first argument should be the
>> path of a new QEMU binary, or a prefix command that exec's the
>> new QEMU binary.
>>
>> Because old QEMU terminates when new QEMU starts, one cannot
>> stream data between the two, so the URI must be a type, such as
>> a file, that reads all data before old QEMU exits.
>>
>> Memory backend objects must have the share=on attribute, and
>> must be mmap'able in the new QEMU process.  For example,
>> memory-backend-file is acceptable, but memory-backend-ram is
>> not.
>>
>> The VM must be started with the '-machine memfd-alloc=on'
>> option.  This causes implicit ram blocks (those not explicitly
>> described by a memory-backend object) to be allocated by
>> mmap'ing a memfd.  Examples include VGA, ROM, and even guest
>> RAM when it is specified without a memory-backend object.
>>
>> The implementation saves precreate vmstate at the end of normal
>> migration in migrate_fd_cleanup, and tells the main loop to call
>> cpr_exec.  Incoming qemu loads preceate state early, before objects
>> are created.  The memfds are kept open across exec by clearing the
>> close-on-exec flag, their values are saved in precreate vmstate,
>> and they are mmap'd in new qemu.
>>
>> Note that the memfd-alloc option is not related to memory-backend-memfd.
>> Later patches add support for memory-backend-memfd, and for additional
>> devices, including vfio, chardev, and more.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> [...]
> 
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 49710e7..7c5f45f 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -665,9 +665,37 @@
>>   #     or COLO.
>>   #
>>   #     (since 8.2)
>> +#
>> +# @cpr-exec: The migrate command stops the VM, saves state to the URI,
>> +#     directly exec's a new version of QEMU on the same host,
>> +#     replacing the original process while retaining its PID, and
>> +#     loads state from the URI.  Guest RAM is preserved in place,
>> +#     albeit with new virtual addresses.
> 
> Do you mean the virtual addresses of guest RAM may differ betwen old and
> new QEMU process?

The VA at which a guest RAM segment is mapped in the QEMU process
changes.  The end user would not notice or care, so I'll drop that
detail here.

>> +#
>> +#     Arguments for the new QEMU process are taken from the
>> +#     @cpr-exec-args parameter.  The first argument should be the
>> +#     path of a new QEMU binary, or a prefix command that exec's the
>> +#     new QEMU binary.
> 
> What's a "prefix command"?  A wrapper script, perhaps?

A prefix command is any command of the form:
   command1 command1-args command2 command2-args
where command1 performs some set up before exec'ing command2.
However, I will drop the word "prefix", it adds no meaning here.

>> +#
>> +#     Because old QEMU terminates when new QEMU starts, one cannot
>> +#     stream data between the two, so the URI must be a type, such as
>> +#     a file, that reads all data before old QEMU exits.
> 
> What happens when you specify a URI that doesn't?

Old QEMU will quietly block indefinitely writing to the URI.

>> +#
>> +#     Memory backend objects must have the share=on attribute, and
>> +#     must be mmap'able in the new QEMU process.  For example,
>> +#     memory-backend-file is acceptable, but memory-backend-ram is
>> +#     not.
>> +#
>> +#     The VM must be started with the '-machine memfd-alloc=on'
> 
> What happens when you don't?

If '-only-migratable-modes cpr-exec' is specified, then QEMU will fail
to start, and print a clear error message.

Otherwise, a blocker is registered and any attempt to cpr-exec will fail
with a clear error message.

- Steve

>> +#     option.  This causes implicit ram blocks -- those not explicitly
>> +#     described by a memory-backend object -- to be allocated by
>> +#     mmap'ing a memfd.  Examples include VGA, ROM, and even guest
>> +#     RAM when it is specified without a memory-backend object.
>> +#
>> +#     (since 9.1)
>>   ##
>>   { 'enum': 'MigMode',
>> -  'data': [ 'normal', 'cpr-reboot' ] }
>> +  'data': [ 'normal', 'cpr-reboot', 'cpr-exec' ] }
>>   
>>   ##
>>   # @ZeroPageDetection:
> 
> [...]
> 

