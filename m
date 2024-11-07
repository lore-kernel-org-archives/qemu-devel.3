Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FD9D43379
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95ZI-0003Lq-8j; Thu, 07 Nov 2024 11:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t95ZG-0003LY-L3
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:41:10 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t95ZB-0005lD-QM
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:41:10 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7GMYpb000710;
 Thu, 7 Nov 2024 16:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=xPD6T4UKDyUO0CAq1f7cR0/PjCWeCDhKoUeYGYUUXqg=; b=
 GaxTleqtuuC2uwqVg3tjKEuC+IbknK/g6fT5IX4gG6yDuKeZYIjA9drI2mwfNWpk
 3quo58HSLj62UYzLiwGDOTN9boevXU3CwH+rMRZgYDiGnLR9jFsk82ylpKFAi+Jz
 3yuQ5xNmxrx942nAWSeLJ4unLkpsjkqtKnysEje7VBDowLRRGA9x5Wlj0qw1F+YY
 CEGX+nqMbfm/jBZm6pnKGveCqrgxAYKDRQs0mCKnnwOJjEhVSLrwob13PDVr67rM
 AowB2cNtbwvRSKXINupofdLHeAIfBic6Z1bcOcfuWqriuKvGARJH+qJjwcFXc67J
 Sk+e1GqvOPa0a8MErNcdSg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nagcb0kg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 16:41:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A7FY6jM036479; Thu, 7 Nov 2024 16:41:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42nahgkb3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 16:41:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2CJdUFnMZLPNtlpVOCrKPfPSmPqkHro7eS2WhDedFbwJo+aXHQZ3yEcS70xKXDSOZ8PUszplP7T3nT77EHBaLdIAJ6H/CACpE+U2V8cHMePuKZJdlV1d1vSTmTWzQYOGtBoStPUDRqe7kkCggg+JxY/ZNPNp6mKo+SSpOswI9R7Y6YofVGQADN9RqMFFtVsFKIjeVWo2iWO98jvwaIe5AElui2a6YqEv+4jDNeMwK9e4PSS42mEJfQYKljAUConPoi8Yr6W4QZ9mHCyXN+qlILkKEPFW7h2kw/eup1NSqhmI1n6r2JyhQ3J0cAWcF1OMcOTgICG0fe3iB+EhjDNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPD6T4UKDyUO0CAq1f7cR0/PjCWeCDhKoUeYGYUUXqg=;
 b=GmTzssnpu916xBEPuhlhZb7HnZqmXuDmKrZ70g4YIece/tYVzWJrcZsRINxPGc6SBnaQ8tTf4+Nb6DpKCBtwowx6lVTgGk1RwvUz1Vqic+NvLJEKARqNToREQiTxtvNT91HYrpWTzGQ3I+fQU5yOWA7RQhLKNP/7T1X8q0i3egDvAoFt2L1aU32yeNVYrBMmlDlZgk04WDB0LpuynwEeuYCM9f7GoVTP9w/k5uCHiIBvpj9qPP9/+xyebVUNFA7I6Uzt5vnmHht2Zm7DnNQWpxZkO6LSrlq+9kQqSgrsO2SmqkQmAmfIv7bQH2b7N0mPhIAvZ5YGwLNswsFxhyrj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPD6T4UKDyUO0CAq1f7cR0/PjCWeCDhKoUeYGYUUXqg=;
 b=kQgHjlKMpd54mWqhAzDAm0dU8ZbpnbNiRDzzEog4RZNcMuGO9fUGoYbnJpb6FEQIsT6+gYykAg4B8tmx5j6VitseYjZic9g6J1Hno7A7UakktCX9hAkR2ypGiYDCEK6ILtzWRcYJ2+MOc8ILxHFhRwR9JeWWl5VntPs1XGC8/Ss=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH0PR10MB5035.namprd10.prod.outlook.com (2603:10b6:610:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 16:40:58 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:40:57 +0000
Message-ID: <00261b15-3eef-439a-8501-574e3bb50d95@oracle.com>
Date: Thu, 7 Nov 2024 11:40:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <053dd9b6-e4f7-41c8-abe9-ed02214f0639@redhat.com>
 <cce158c4-3bb1-4771-b2c5-f3ae8a2285d5@oracle.com>
 <5b192b5e-943c-4b2f-ab40-ef54ea578363@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <5b192b5e-943c-4b2f-ab40-ef54ea578363@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0111.namprd02.prod.outlook.com
 (2603:10b6:208:35::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH0PR10MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: 68103f1b-85ee-4ee5-bdce-08dcff4af4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXF4OXJIU1Jtc1lqRk5OT2tlRWlUR0ZCMS85NSs4NXlmUVlabmMyb2tXbDNs?=
 =?utf-8?B?MExudXJhcmd3am9VcmVNd1lzeUVWTDJ2SW5TNzE0czgrZkZEWmE4ZVdHSUJ3?=
 =?utf-8?B?M1Y4Z2xQcHAwbXhtdFI2d014d21iZTIyaWNGK0NFQmw1bG5jaURKNEh5QnBD?=
 =?utf-8?B?c0IwYmRCVzN6R0NQK1BCTFBpaVBhb0R3ZWlDWXF1dTg2M0dweDFhcWRvdzdG?=
 =?utf-8?B?U21xd1pSREk5K1RjWkFYdkFWbFVWT2x3ald1enArZEYwTHk4bUYzMEt0b3Rw?=
 =?utf-8?B?VWtucVdaMEN1dnM2TWRjZnVpMUJwZkRqVEJzdlRRMlBZNEw3RWZ2RUVNdGR2?=
 =?utf-8?B?eCtaWllUQmVCSVMwektFOEhBUU9ERExZaS85WGYvL2ZLWUlsc1hIYnp4QTU3?=
 =?utf-8?B?NW00eXEzSDU2dTQ0Y3NYdzVJSzJBaVF1VFh4dFF6VkZrUldOdzJRcHRQWU0v?=
 =?utf-8?B?VTcvSG94WDNWa3o4SHlIVENFZ0FXQi8wUXYvN1pmelQ1OUhGUU9Rbzh5UWI4?=
 =?utf-8?B?STVhOEF4RmRpcFBmVnRIZlJMVDZnK282dkR0ZFBnaTFFMGM1YkZNOHpQYUFH?=
 =?utf-8?B?QjB2S1orOGxKU3o0aStKbEtsWk03aDY5Yy9TS1NucEd2VTVIMndXNEFZeFIv?=
 =?utf-8?B?SDkydWJISU1EM09hc1gyRGkxM2hTZ01vTk9LRTFCYnY3VVBxVkZ5Ynlyb1Jw?=
 =?utf-8?B?bDF3TnZRRlArZWR0ZXJ1SWc1bmsyMnlQeUZ0VUJBdkpRTnJRVnd4MXBabVNl?=
 =?utf-8?B?bkxXc1VXNnhEbWRYNEV6RkkyVG9rV1haMDlPRGFQSDA4Rk1MS2VvcU5MV3gy?=
 =?utf-8?B?dTM5dGtidU5LU294OG9VVW5hOWpaTUxjb1pHY0lzRFozdWpaRE1weGFJVFBv?=
 =?utf-8?B?dE55M0xqRklzOWNPUXRBTG1iQzF3QTBrNmFhM3kycTlYdkNzSlFrSXZTNUNF?=
 =?utf-8?B?VlhtV0hIMTA3WDBPQVFqVzhIRzFpVW83NkZSOFBBZ0NBWXNuUDdrc2VGeWNv?=
 =?utf-8?B?aVpQVGhkbVlQRzQ5ZU55NkF2RjBmT1lOSVdpMW1uWlFkMktMckpLVnVpWHlD?=
 =?utf-8?B?bHVsR2RUcm9OK2xLVUpOYUZTbnk4VXJOSmhpZzJGYXpMVmRYb0pYbkFidWlj?=
 =?utf-8?B?TUN1SlRXS3pKOVN2S2NVOFJwb29ra1E1cFFqNllOeE9OU2ttVXJ1K0llTWsv?=
 =?utf-8?B?anh5OWdWSUFhM1B6dHl1U0cwOEd3U04zdGlWMmNwd2l0QnhQWStXWm1OeWo4?=
 =?utf-8?B?cjlzR0ljSUtvTHdvaDkzRWQ4ZFRyYjQ0NGZmbm1rVjczY01HNXNtS2ZXbjFw?=
 =?utf-8?B?ZDFnWUJscXROVEQ3cS9tOTBQQjN3WkVvMDN2SmJ4bE16ODZQRi84aThOd0Rm?=
 =?utf-8?B?cTFpbVJSUHZKOUI2d2xnbzA3a3VpUjVkeENKVU5Ea1NPdDJybWZrSlRCZE9x?=
 =?utf-8?B?SmtybjBFUGkralpCY2NubWtHY1p5RUpHaUtPWkM0d2dLS2ljb1g0d2RRTzhY?=
 =?utf-8?B?a2tCSzZIcjNLRlY1bHo0S3VPOWFRcTEwdHloVWQzVVhnMm1hcTVwajdmK3BM?=
 =?utf-8?B?Wkp6WTFwNTBJcXBBVC92YzZkVm1Ya1VIanhEWE85bzZzQnp0ZjdDVHRNSkYy?=
 =?utf-8?B?SVg3dnVyUG5VQXUya2JtK1FpTGNaZDM5V3JyVUFOdEdZNUh3RENMTFdjYXFq?=
 =?utf-8?B?bUQ4bEtoY1F1TDBOL2djUUZycXh6QU9VQkc1MGdlNVVpU3dGYVZKcWJlYUM4?=
 =?utf-8?Q?QqGllLP/4d3WBqU/WhQecAUREMCZ/7WlWFuw6tU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Jmb3dneWtoL2w3MlJaUVlHU0lZVDllaXdRTWo2ZG9Lb1dXWjBlVDRMUUk1?=
 =?utf-8?B?Nmx6Q1FBM2RocW1abWtrMmpKL3ZMNkUvOXQ2bHhnektPMUFaaXk2K0NHTm1h?=
 =?utf-8?B?Z2gvK1pBMFRDaDRoVjV4Wk5Zek9vVjc0WU1aS3hwc2VwMDc1bEM4M3UwRkxr?=
 =?utf-8?B?em5HV2ZFK0hyOUNGaVFIS3dCM1RQYzh4Sm42Y2ZmMW1OcWhSWDlKME5PSGhk?=
 =?utf-8?B?dWVydndOQWFwb2RJakk1TE04SUErTk9OSG1sQWFmWlY5RFhpWGtkb20xUlV3?=
 =?utf-8?B?WHdzUTY0cDB6VTBHcWFMb1RibXBQS0djYVBhQUVYSWQ3UWF3Mk1SQlZtak5a?=
 =?utf-8?B?eHJNQnN6ZVJvdG5tbG9NVXhERGUvSVV3ZDBDK3A4eE43MXIxOGRkdWRoc3BF?=
 =?utf-8?B?SjhDaEJVRCtJUXRzNjNjaTFoVFgzQjJvb1k4L04yT0tDWk9QMFZHeEhKaUho?=
 =?utf-8?B?TU9aaFFudzNla0svMFlucjg4Z1BSM2p4ZDRFc1NWZEZPUUNadHNYWmEreklJ?=
 =?utf-8?B?ZmJaeFhUaDRWQjFYWERCay9sdnJ4R2FTZWZzaDJzK3dFYW1lODdVZnJPclps?=
 =?utf-8?B?R0ZPbVgzWU9nMklQMzViMkJKMnJnelFxMHV2SmlFckp3aUYvTnBtbHBoZE8r?=
 =?utf-8?B?NklMQ3E0Zm9hZm9lNVUwWWNSTlp1elN5L20yNGhjZFljMWhuZ25tMURwbmxw?=
 =?utf-8?B?MkdpcUx4UWMrZ2pzdDBiYXhkN1o5N1JXTU4vWE1tNGVtYWdyZUdGZmViYUU1?=
 =?utf-8?B?WUVtNUt1b3ZuRU1mZXdnQlBWcmVUajVLbnFSY0EwTnl3VUxjMEhJNFlSbWFs?=
 =?utf-8?B?ZXc5dXVGMVlFRzFWQXpqUkw0QWdFN05kNVE1VWNnQVhpa09IWUF3NTJ0eUlV?=
 =?utf-8?B?Ykt1T01qaXNUUTRKa1VwVVE5VHYwQ2paRis0WnhrUXBoSGcwS1dqYjZvblRB?=
 =?utf-8?B?cGhNVFc4YzFJbW9oR1BldjlmcHhHRHVNV05tbGt1aGo0dkMrcW50OFBDME44?=
 =?utf-8?B?NGQreVhBcFpTTWlxbkNLL0ZRMldQVk1yN1BiOWxNQWpBaTNUUTc2dHpBRjNl?=
 =?utf-8?B?UnhPSk1QelZTSVZVOENsZTN4R3kzajJ3c25LN2N3N25GbkRhdS9qb2JRMklX?=
 =?utf-8?B?YWJ2czRrQUs0Uzc2OURyTkFXVldpcXVKZis3a0QwY21Wd3k3YytQRXJBWGNE?=
 =?utf-8?B?VjRQWndpN09JcENUYWxGbFIwdVN1YURkcDZ2dFM0TnkvV0xPbHRaNUU2bmN1?=
 =?utf-8?B?R1F6NE5idlVWeVdMMUY3U0VhUWRRNG9kMG8yWHZMbXQ3Q0xqNmtNK1luYk14?=
 =?utf-8?B?eGM2VnJYWkFVbFZLS1dLT0RxeFBXL3RJN1pnSFhRYnJQMjJjbUhCOGpSQmQr?=
 =?utf-8?B?QlI1Ujd6a1VPSVBZREtSNE5UZjdMcU5vRElzVkxlR2hRR0pHTCtmbUlXUmtP?=
 =?utf-8?B?VHdJQVAzSUtYM1VrQmJXS055UkNQQWNrdGhObytvZ0dlYUhNdXZlQ1BzVnhC?=
 =?utf-8?B?eWNVVDNtZ2FQRTlRVkd2aUhmeGd6ejZDS2NnVitzUHJsR2l1SHAwSmMvUk5m?=
 =?utf-8?B?ekg4UU5oWlZ5dHkwT2JEVnBnQ0hpRkpPdDBHWVA1OHR4aHJFOXp1aFJYbFI1?=
 =?utf-8?B?V2poaG0vM0VUSU0xbHNFeHl2dnhORUNzMnhSK1FJK2FhSndSM3lGVnVSakY4?=
 =?utf-8?B?V2QrSlRwUmhXS3Q5bG1HekJDSG5UeGF5Slk5S2xwOGd0UGtLakkrOG5jNnlh?=
 =?utf-8?B?NjhxU1dZRUc2b3FkK0RFZGFPUFhlWTNaN0RCQ3pzUTdZT2FyS0hydWlBM0pz?=
 =?utf-8?B?SFVCZkVqa0JzZktJMnM4ZmVUSEtjSDJqUXkvdDVqL3EwNXVlSldJT2UxR3c1?=
 =?utf-8?B?M0tiV2RsMVBrUS9SOUE5WS9UVUdIUndNY1lzTTJHaUx1akNpOFlNM09oenhH?=
 =?utf-8?B?UGF1TFRaU1VMMWdGWjVLa2lXcituZkxaeTFlQ1JMaTIrUkQ4MmkzU0UrK0lh?=
 =?utf-8?B?YlBZMlZRMEZYYUNicFAzektQeVc5T2ZyT0xuTHFxK3NRRDljb29pSlpBckJU?=
 =?utf-8?B?TjFsQU9IQnZTTGlFSVVPUHZpUmhpckNzVE5lVlE2NGJxdm8zK2pra2xvdDVs?=
 =?utf-8?B?cUZxRFhOc1czZzYvZDVXT2I0RXBxK0hHZ0RVWWhMcjl1L3FwOEN1NjlxS2pp?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xTI8PkI0ACNFScL4Xh0zaDoHkRIeQNod9V27IUYhvNUXYecponTF2OnaWe2KbEFfaNYTfqrNmq3Gwzii+y0BEBuPltQd1FkfBRb1GI42ICtdUa2FW7m2xNCeXKDuY+g/+gBsukYgY5hunojx8P+Yyih8bXx7OWnlqM9y48Fbj3hLLowwn/N8/JV+B59hI6NbMcQqxgLF2UeyS1k796uQwhCZJd7peZHfxN0KVaxNhCbUU6SZc6fy7ei7fFQx/KyUR+u0AINCjIvfFwHuxXYi62NND1uf4EoDZEArJ+Ug6lKMDJugI+dWhIsK6MJQJF/gki/bk9BM2u+/9ePgkaa08YFdb9OwrdAHx/29zcLSAZ9PAnynSUNGIksf2duu0+Ty5Q7ZiNQ9QxPi7M51Yf3Q7EefMKjSVhj+AtA7C7YJxJDMT019IZm8b79fpB4cOKzm78yR8CkX+DxqHNw4FN1aoNVq/r1/sElx7lAjeO7l45L/KltZsh8QPcHEjMlhLIec9ipqmoQ+e3CQKe578+Z/qGOVhwurXflQ1BfKSDaMTrVKYPyfB+ATUO86U4siBCpHlGsntczliibYnDLQGo6R4W9lQCSp0UJIcf3wYJHcR5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68103f1b-85ee-4ee5-bdce-08dcff4af4ab
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:40:57.8704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OJ4TGnwlXOy820fyOUgGlgvDVavBMlRM84m1KZ7TMwczR2h0SzdC/mvLEPisiGz/HvuSJ7WaTRf/T6IO+xrNyJ985Dq6xbCpq9f+XKEYhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_07,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070130
X-Proofpoint-ORIG-GUID: 4FzLS_Ffo210QUksdxwv82yYWrM3VKRu
X-Proofpoint-GUID: 4FzLS_Ffo210QUksdxwv82yYWrM3VKRu
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/7/2024 11:26 AM, David Hildenbrand wrote:
> On 07.11.24 17:02, Steven Sistare wrote:
>> On 11/7/2024 8:23 AM, David Hildenbrand wrote:
>>> On 06.11.24 21:12, Steven Sistare wrote:
>>>> On 11/4/2024 4:36 PM, David Hildenbrand wrote:
>>>>> On 04.11.24 21:56, Steven Sistare wrote:
>>>>>> On 11/4/2024 3:15 PM, David Hildenbrand wrote:
>>>>>>> On 04.11.24 20:51, David Hildenbrand wrote:
>>>>>>>> On 04.11.24 18:38, Steven Sistare wrote:
>>>>>>>>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>>>>>>>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>>>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>>>>>>>> memory allocated as a side effect of creating various devices. It does
>>>>>>>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>>>>>>>> the command line, or implicitly created by the -m command line option.
>>>>>>>>>>>
>>>>>>>>>>> The memfd option is intended to support new migration modes, in which the
>>>>>>>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>>>>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>>>>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>>>>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>>>>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>>>>>>>
>>>>>>>>>> A more portable, non-Linux specific variant of this will be using shm,
>>>>>>>>>> similar to backends/hostmem-shm.c.
>>>>>>>>>>
>>>>>>>>>> Likely we should be using that instead of memfd, or try hiding the
>>>>>>>>>> details. See below.
>>>>>>>>>
>>>>>>>>> For this series I would prefer to use memfd and hide the details.  It's a
>>>>>>>>> concise (and well tested) solution albeit linux only.  The code you supply
>>>>>>>>> for posix shm would be a good follow on patch to support other unices.
>>>>>>>>
>>>>>>>> Unless there is reason to use memfd we should start with the more
>>>>>>>> generic POSIX variant that is available even on systems without memfd.
>>>>>>>> Factoring stuff out as I drafted does look quite compelling.
>>>>>>>>
>>>>>>>> I can help with the rework, and send it out separately, so you can focus
>>>>>>>> on the "machine toggle" as part of this series.
>>>>>>>>
>>>>>>>> Of course, if we find out we need the memfd internally instead under
>>>>>>>> Linux for whatever reason later, we can use that instead.
>>>>>>>>
>>>>>>>> But IIUC, the main selling point for memfd are additional features
>>>>>>>> (hugetlb, memory sealing) that you aren't even using.
>>>>>>>
>>>>>>> FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
>>>>>>
>>>>>> Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
>>>>>> To do so using shm_open requires configuration on the mount.  One step harder to use.
>>>>>
>>>>> Yes.
>>>>>
>>>>>>
>>>>>> This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
>>>>>> if memory-backend-ram has hogged all the memory.
>>>>>>
>>>>>>> Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
>>>>>>
>>>>>> Yes, and if that is a good idea, then the same should be done for internal RAM
>>>>>> -- memfd if available and fallback to shm_open.
>>>>>
>>>>> Yes.
>>>>>
>>>>>>
>>>>>>> I'm hoping we can find a way where it just all is rather intuitive, like
>>>>>>>
>>>>>>> "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
>>>>>>>
>>>>>>> "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
>>>>>>>
>>>>>>> Thoughts?
>>>>>>
>>>>>> Agreed, though I thought I had already landed at the intuitive specification in my patch.
>>>>>> The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
>>>>>> controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
>>>>>> of options and words to describe them.
>>>>>
>>>>> Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
>>>>
>>>> Hi David and Peter,
>>>>
>>>> I have implemented and tested the following, for both qemu_memfd_create
>>>> and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
>>>> for simplicity.
>>>>
>>>> Any comments before I submit a complete patch?
>>>>
>>>> ----
>>>> qemu-options.hx:
>>>>        ``aux-ram-share=on|off``
>>>>            Allocate auxiliary guest RAM as an anonymous file that is
>>>>            shareable with an external process.  This option applies to
>>>>            memory allocated as a side effect of creating various devices.
>>>>            It does not apply to memory-backend-objects, whether explicitly
>>>>            specified on the command line, or implicitly created by the -m
>>>>            command line option.
>>>>
>>>>            Some migration modes require aux-ram-share=on.
>>>>
>>>> qapi/migration.json:
>>>>        @cpr-transfer:
>>>>             ...
>>>>             Memory-backend objects must have the share=on attribute, but
>>>>             memory-backend-epc is not supported.  The VM must be started
>>>>             with the '-machine aux-ram-share=on' option.
>>>>
>>>> Define RAM_PRIVATE
>>>>
>>>> Define qemu_shm_alloc(), from David's tmp patch
>>>>
>>>> ram_backend_memory_alloc()
>>>>        ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>>>>        memory_region_init_ram_flags_nomigrate(ram_flags)
>>>>
>>>> qemu_ram_alloc_internal()
>>>>        ...
>>>>        if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
>>>>            new_block->flags |= RAM_SHARED;
>>>>
>>>>        if (!host && (new_block->flags & RAM_SHARED)) {
>>>>            qemu_ram_alloc_shared(new_block);
>>>>        } else
>>>>            new_block->fd = -1;
>>>>            new_block->host = host;
>>>>        }
>>>>        ram_block_add(new_block);
>>>>
>>>> qemu_ram_alloc_shared()
>>>>        if qemu_memfd_check()
>>>>            new_block->fd = qemu_memfd_create()
>>>>        else
>>>>            new_block->fd = qemu_shm_alloc()
>>>
>>> Yes, that way "memory-backend-ram,share=on" will just mean "give me the best shared memory for RAM to be shared with other processes, I don't care about the details", and it will work on Linux kernels even before we had memfds.
>>>
>>> memory-backend-ram should be available on all architectures, and under Windows. qemu_anon_ram_alloc() under Linux just does nothing special, not even bail out.
>>>
>>> MAP_SHARED|MAP_ANON was always weird, because it meant "give me memory I can share only with subprocesses", but then, *there are not subprocesses for QEMU*. I recall there was a trick to obtain the fd under Linux for these regions using /proc/self/fd/, but it's very Linux specific ...
>>>
>>> So nobody would *actually* use that shared memory and it was only a hack for RDMA. Now we can do better.
>>>
>>>
>>> We'll have to decide if we simply fallback to qemu_anon_ram_alloc() if no shared memory can be created (unavailable), like we do on Windows.
>>>
>>> So maybe something like
>>>
>>> qemu_ram_alloc_shared()
>>>       fd = -1;
>>>
>>>       if (qemu_memfd_avilable()) {
>>>           fd = qemu_memfd_create();
>>>           if (fd < 0)
>>>               ... error
>>>       } else if (qemu_shm_available())
>>>           fd = qemu_shm_alloc();
>>>           if (fd < 0)
>>>               ... error
>>>       } else {
>>>           /*
>>>            * Old behavior: try fd-less shared memory. We might
>>>            * just end up with non-shared memory on Windows, but
>>>            * nobody can make sure of this shared memory either way
>>>            * ... should we just use non-shared memory? Or should
>>>            * we simply bail out? But then, if there is no shared
>>>            * memory nobody could possible use it.
>>>            */
>>>           qemu_anon_ram_alloc(share=true)
>>>       }
>>
>> Good catch.  We need that fallback for backwards compatibility.  Even with
>> no use case for memory-backend-ram,share=on since the demise of rdma, users
>> may specify it on windows, for no particular reason, but it works, and should
>> continue to work after this series.  CPR would be blocked.
> 
> Yes, we should keep Windows working in the weird way it is working right now.
> 
>  > > More generally for backwards compatibility for share=on for no particular reason,
>> should we fallback if qemu_shm_alloc fails?  If /dev/shm is mounted with default
>> options and more than half of ram is requested, it will fail, whereas current qemu
>> succeeds using MAP_SHARED|MAP_ANON.
> 
> Only on Linux without memfd, of course. Maybe we should just warn when qemu_shm_alloc() fails (and comment that we continue for compat reasons only) and fallback to the stupid qemu_anon_ram_alloc(share=true). We could implement a fallback to shmget() but ... let's not go down that path.
> 
> But we should not fallback to qemu_shm_alloc()/MAP_SHARED|MAP_ANON if memfd is available and that allocating the memfd failed. Failing to allocate a memfd might highlight a bigger problem.

Agreed on all.

One more opinion from you please, if you will.

RAM_PRIVATE is only checked in qemu_ram_alloc_internal, and only needs to be
set in
   ram_backend_memory_alloc -> ... -> qemu_ram_alloc_internal

None of the other backends reach qemu_ram_alloc_internal.

To be future proof, do you prefer I also set MAP_PRIVATE in the other backends,
everywhere MAP_SHARED may be set, eg:
     file_backend_memory_alloc()
           ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;

Or omit RAM_PRIVATE in those cases where it will not be checked, to minimize
exposure of this new flag?

- Steve


