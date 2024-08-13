Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45650C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 18:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdwh1-0005RV-9W; Tue, 13 Aug 2024 14:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdwgz-0005Qy-5K
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 14:56:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdwgu-0001th-5Q
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 14:56:24 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBTYY022125;
 Tue, 13 Aug 2024 18:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=QIPZip4WBihlnsB4VyYS1YOB4zHWnvRpfdHzVbE8EKQ=; b=
 jsBAOWJMmTsJQ2BVjWDLJyh2c+7J9pA4JbLCGLPXBJx6H+n8OHSlu73AYKu/1o7F
 MPCyuVAvVbV3SZwKfoJE5R9rSrg+R2ssuOP2Ag4wNS6mY429p3QDUQowMd8MP8ZW
 MtwkcWk3QEz9BSKkzdE+9QgXbnPq6O9Sjv4fAgoT8tdx/v8V1xvGbj6BpIuSCP70
 HN4pWy7bnUUj1SkwVsMvKHYiSMFhtgUywTfhtco1u4YA0/QErCI/mM1Ix02gUVUq
 NLz/uwRHAC+0f9+rTapX1Zonuw/0pNvB47qF57tOiWlgJvutHEMzq8gAWp8veSGN
 Gv79fzEduDl7II4Q2N3CHA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0396kqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 18:56:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47DHR1Yx017649; Tue, 13 Aug 2024 18:56:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxn9uvff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 18:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msholw00nc66iVWkfnMx1gLU0F52Enuy0ySEnMpHo6B8gKJGe6JDFZ6Ih6S/N+qwmIe/yM6SDTDgf21JBUY879VAP6aHaxzl51C4xy9p75OlL/xF+sYmlrT1bnFHL3E9ZI/CJ0WDoaY8h3tSnpfzR/1vHRd9RHDvOF90XOBvzgrGukGO9JHnt/QlQdiEJPb2luAhlFwOuVNGkneNfahL/H7Zhiw4D1M1xTtQgJhk4EAeuEpU42rhfqiBzMuBjoPRRSGiEc9VNAPO6W1TBY6m+gJnh0Emcv7cdkQrcGUoprXTSiGvUPoo7fAloAsfPJrKMtvTU9t2X5bEFInXvsPxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIPZip4WBihlnsB4VyYS1YOB4zHWnvRpfdHzVbE8EKQ=;
 b=D/+si0nsFuoAfwEZ+bxEW73Zfsl2Xwqz/9S5XmYzCvY6AjlILD8R+ejqiooVywPRxlq67ltH5SEUFBMCLKUlSdT1o+eGSsUR/TyuKY/8tXywHbVf2/k+ggR8TCDQ3fxiorYdzvIv+UxWZAgPhZCubLKApZwuCdZEYgT9Ctrhc2dmU19ICMOoHyaUyfJPF15kl1tVmE/2FeuK7uz1K8rOTY2rReoyirrY8kLnp5Chf4rhQxv9ly08j85+NpexdN22bhXUpgpzBJcy6gcRld5SO7ksL/8xzgjZjHiPit4yj6EdxCkt29y1obmJN+w+9M5p0l0dcbVgEMNludupJ1rDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIPZip4WBihlnsB4VyYS1YOB4zHWnvRpfdHzVbE8EKQ=;
 b=ppyloQUUMe7ciowPgKbvUem/AsNJGnmleqvWURIRo3N8EVeQtmF8iQy/MMZFNAdGPkdy5qEdNWpuu9vMDBrRpEdISRp+4JrjPOfxS39DqKehhehbVstOOIQjt5VdYRILmg3yTPXcPrtZLznKg9xdc15RrIIQU1iUYYm5AME/UQk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN6PR10MB7542.namprd10.prod.outlook.com (2603:10b6:208:46d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Tue, 13 Aug
 2024 18:56:11 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Tue, 13 Aug 2024
 18:56:11 +0000
Message-ID: <e3c8a5e9-cc78-4c65-b2c9-56291a1ca7bb@oracle.com>
Date: Tue, 13 Aug 2024 14:56:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
To: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
 <20240729142932.6667c5b5@imammedo.users.ipa.redhat.com>
 <369f6786-1146-4d5e-a9a5-c0b0b5f45bf7@oracle.com>
 <64b8934e-2655-4224-aaf1-e125e6469f87@oracle.com> <Zrt9M00rDk3EUdNM@x1n>
 <20240813110037.6f04ffe9.alex.williamson@redhat.com> <Zrup3sYW7XgsnThy@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zrup3sYW7XgsnThy@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN6PR10MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3dca13-79d6-45a8-8da2-08dcbbc998f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVpkeFRiNDdUWkVFRmh0d3ovTStwNHgwZys0WjlSUmliVDZZdnNMT2k1Vklw?=
 =?utf-8?B?RnhYZ216Y254Y1B4dWV2VENaN0ZLd0JBTlg5RUNlNVlaTWZxM2JFbkNTMndm?=
 =?utf-8?B?VW1qeUY3aXhaR2MrSWNkNHRrRUFBSzlLclZFdVo1OVYySWU3SEZhcXQzZjNr?=
 =?utf-8?B?MitHY0dnRVVsSFVQY0JsZUY0KzdieGMxZWQ5MUJ0RVNsbmt5bldyQTQyQVNt?=
 =?utf-8?B?MmtTcDBHT1hvWmlWODRyVi85NEpsTGd2ZTVQWnF1TlVWWFhIcERtRXR6YzZL?=
 =?utf-8?B?bjJ2UVpiZWJCa0tsRldZb2xXb2lBeUljdXN5YXltdnVST0FTNnpWY3RzcVR6?=
 =?utf-8?B?Mi9kcWE1WE13UXp4MTRmTHBISUJsNGEyZXh2cmNXcHZ0Q3lhMGt2OWVYYzM1?=
 =?utf-8?B?cnAzd3JLUmRRNVgzdWtaSHc3Zlc4ZER4cHZXeWJVa3M5bngyNSt5Z1ZqMnh6?=
 =?utf-8?B?QUFiMU0zM0Q1NmtaTWR1YkdITkxjYTRIeVFlYWxkaDlla1lXTVpyQmdWNUpM?=
 =?utf-8?B?dFhTWGcxQXVjK3UyM3p4UVRleHQ4MWpXOW9HaTRySFVhQ3NrZVdBK2xOTTcx?=
 =?utf-8?B?ZGwwOWJxTVR0RlFFRmNKU3JVU0NPc3RxT3FEakoxSm1SY2p5QTFmZ1FVY2Js?=
 =?utf-8?B?dURrZE1zckE1NFhpNExQMmlFbXh4ZFlZSmNlWk1sTkpOeU54UERQN0NvaVAv?=
 =?utf-8?B?bE1oL3dWa3ZUUnpjS3ZSTm1XNVNYZ0RyOHF1MlUvY0lMU1Y0UW13Y3lJM3hp?=
 =?utf-8?B?VnhydE9Ob3hROHNVSlF1Z0I0L2JTMTBPK2lmR2ZZZEw1bGZ1UmxzUm4zc0s5?=
 =?utf-8?B?S0xOZTNOaDFGdWVnYWIyZjRMV0RraEpHNGRPYzI2RDVVeUJTRnV4UXppSkpJ?=
 =?utf-8?B?SjQ1NWRiTndXLysxam05TnBMV0N2RUhpL2xrc1RwQzdXSVhlUFExbTBBTzdr?=
 =?utf-8?B?NHlETjg1ZS9mNmx0RzR2YzJWaEU3ZkFHbHFreWk0Qk5uZUg3VHhuYWdvRDdo?=
 =?utf-8?B?Y0ZjOXI1RnE2Y0U5QVY2ZmpMYzdXN1J0dnI4SlEwdDNFZVdCRE4vbU55ekxJ?=
 =?utf-8?B?SC8vVWk4SHNZcnRmWXl2WFdpZEdwN2poR2lDSlhLMEgrMXkwWmUvcGVUT0tM?=
 =?utf-8?B?bmM5Q2N2ZnZVaEhYTmV0ak5kZjBnRmdURkJmbHBPUHBmaGVyOGVnZFpNNnBy?=
 =?utf-8?B?SDBGZzl3S2pLUzhhVVY4dFJBYkJyWHJVc3crSTN3K1p4K0NadGJsV2xuUDJU?=
 =?utf-8?B?RzY4OWJTUTc0SE14Tk9scyt1aUJJdUNQVWVCK3E1QnpTblR3cldTcFhsc1B3?=
 =?utf-8?B?QzE2L0N3Yi9KM3YxMU1CaktSSWZ4K0ZoMnJXb0J1bDYwa3FrT29aKzN1RitO?=
 =?utf-8?B?WXBUalJGKzR4RWh5YlpTbTNrYXNlSUtCdmt6bFFjZ3YxYlNaSTZrYS9OdGRH?=
 =?utf-8?B?K2FoVXpxZjZPL1ZQNkJqT05HWnUra3RMUEpPRjIvL0VpSlltSnlhQzhQeVpS?=
 =?utf-8?B?VWdpM3F2bnpWWTcwTVNtdzZIN1RXMFZmOWxTUmpKeTIrTkdpZk1HZVg1bVNu?=
 =?utf-8?B?TGVaQzNtcUJRNlVERXBZUU5TU01wMXdOZERObG1qMFFRV2ZrT2lmakRtRmFH?=
 =?utf-8?B?NzZWRjREL28zcC9ZTkJwWEQ4bENQWlRZd3NpbUcyRkNuVW9kTTBiV2dxZUdM?=
 =?utf-8?B?QWI0MEUrMklHZ0oxS28vaXpQVkxEUFExQ0VDNWZBWnV4RjhuNm9OOEdUcnFC?=
 =?utf-8?B?MFNtS05yZVJxOWNnbHFVTGJJdDQ1SktTSFdiMllhWi91djkxUnhQWTlzVGhj?=
 =?utf-8?B?ejRkS1MzWUtnS3RPT3RIdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VktRQTBhK1BUVFRmcXdCRTZYRUZhS05hZ25DTHF4dTN1SkR5eXFYMFYwSVph?=
 =?utf-8?B?MkNIWHJkdjJFdm00amxGSzViSitSVjNLTm1SbURNaTR1UW1zekdIVnVaNWRE?=
 =?utf-8?B?elZtK3pIQndCeTRIaGNVZ2J3RXJwL0NJVURvMVBWYVM3VXlqWWNZajVrbG91?=
 =?utf-8?B?aWlmdFJBZ1pGc3RWWEtNY0RuYXNKR3ducGdXR0o2NWRjMkYyOHdSWVdiVllG?=
 =?utf-8?B?bnhJWDcvR2VGcGpsd0l0aEFlUHhTTWhwa25NaGJZaHUxQndGOFlwK2gxUVhr?=
 =?utf-8?B?cmNzK0pjRmJXRkhRTnhYeCs3N2lVK0xMRlhiK2I2cjA2MDRuRStsbXl1bmhC?=
 =?utf-8?B?Si8wbk1oS0JobGVJbVU3VTJ2RGg0VGlpVWJoR0pkWVF2S01JdjlNT0xOMTMz?=
 =?utf-8?B?Y0h3a3NwdFI1Vjh0MjBLdE5PeXkyOHN4UXlTcmRYQngzRXJ5c1NmMWJMSkZp?=
 =?utf-8?B?cUpzb3VyRWxPWmpUZjBxU3crVnU0MVF4SmZtbUVsdnhjcUt5L2JuKzZEb0tt?=
 =?utf-8?B?RitROFFIWGlBRElBcGNHMVIzRzE1bVBVZVNtbmdJSDhka1g5cDVzdVJVWldI?=
 =?utf-8?B?c0NPY2xqSWJuT1d6amNlSVpkcHZOUzRjeUNkYkovd0NvWTlxMUFESklxU1lE?=
 =?utf-8?B?NENiMXJqWUNjZUJzZ01lVlh4WmlxcVV5THcwR3RTM043SThhZStVd0xtNXpm?=
 =?utf-8?B?TkdGUGNRZFBTMWJMWjFUNjEwT0xLVkJkM1R6NlJoa3F0Ri8zV3BnU1FkUCtE?=
 =?utf-8?B?MU5scTA4QWp2QTE3K244K2g0ck9GVVM2QTN2MzUxMGo4alJ4c3J4MHl5ais2?=
 =?utf-8?B?R2hTVER3SnFBN2RaRmdSSWZLbENwYVVQNzVraG9KcWRaQjVNRDRHSmhoU0lJ?=
 =?utf-8?B?RXdNY05ha3R0cTZ3Yk1Meng0cmlEWWcvTEVtLytaMFk2NzFrRVQvTTAyUmtw?=
 =?utf-8?B?cFdsNEllVm9WYld5ZE1YRW1rL0ZYU2F3TittaTBLSzhxWHBzSDBnN3MySXcz?=
 =?utf-8?B?ODIzZGtsUzZOU0lFTVdQOXQyUjNtRVFOQ1RlL2tteHhzOVVmb0hkdmVDdDBE?=
 =?utf-8?B?YVp4S2xYYmk0RXNJVTZpcDh5UXdVeURkb1RaREdsOTBmMytSYXJIVmFjU0RE?=
 =?utf-8?B?SU9rdml4L1c5dCsyb2hQMUloeHA3T0FaTytKWktNVm00KzJsOWluSUNUckZw?=
 =?utf-8?B?VXMvSllrRHBZTHpjOHpGWnRMa3d3WEtvOFRyNjVlUWpTdUpKSFp5Vi9oMStr?=
 =?utf-8?B?SzB0amhIVzRsTG1XaU1PNXI5QnFHTlpSVmttQnNNL0tQMjVIL3FmZFhDanpl?=
 =?utf-8?B?b0JzQ0pQUjh6NCt3Y3NCbFhFOU4wdmE0dHN1dndqUys0YlZDMkhDVGVXZHdP?=
 =?utf-8?B?cUZjV1BZWXkvVEN4cmI0UU9SZ0twTm9DY1FaNjRvdHFuWFdNd29TS1UzYU5k?=
 =?utf-8?B?eEFZVkxmeXRNLy9ZZG5HOUQ0SmE0SisyRk4rRktPc3c3dURkMEk2VkdXa2FR?=
 =?utf-8?B?NlBVVWo3MzNBeUV4eC9DZ0VMbCtRUThTNklVS05aZmY1K0ZSb0JvcWZaWnQ2?=
 =?utf-8?B?ZlVDc0o3SXVHb3U5eXVrMWRmVTk3aUpFcldxbWkvODcwOXVrT2wyUElKUFpi?=
 =?utf-8?B?NHFJTEZubS9KSG5ZRHRua0NmUDZmT0M5TlJTRTBsTDgvZlhod2gvRWhVK3JH?=
 =?utf-8?B?OXZJa29WandWdlV0R1JVa1JJZXBvVTZPZDZ1OS80WWdVcURLdHNvWnk0TkJl?=
 =?utf-8?B?TThFTlF5dnFLWHFyTjUweTR5ZGR3UWlVbHN2SzdqTEdpbGdoV2VnQjZ1Z2FV?=
 =?utf-8?B?T3cyaDRrR3BnYS84RTd6YmtUbGk4eG1HZjBLRkowNmlYT2NSZDFZWU05eWs0?=
 =?utf-8?B?N0xyK0lmY3p4ZUZvNG1xT1M0b21qNkRVTWt2eTVNejFUWnJKT0QvQjRaZGJv?=
 =?utf-8?B?K2d6WVhqTGxGc3FHTTd6WTE2dTJFMkJtc2dDOTByT2ViakJOVEcwUTFncktM?=
 =?utf-8?B?OUx4dVBZclZhZTVHSmg0VlJqZm9WdUM0endyRGtuMlFuSk9oN1BTNHdURTQ2?=
 =?utf-8?B?ckNyVmdZQTNWZTQ5MERPWFZFSHlCaGZEalhBbEIzeWkxdGkvdGNOUmxRVUJo?=
 =?utf-8?B?WnpqaGtMcGd0b1JQZkNZZFFtdTAvTlJYdjlxWUJtWTBzWVFuKzRkNUVEMGl6?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QxRxsCOWNnZ2JwFOEV220zzLpdJdB+mzfaKxh50+piVYzOap/FQPv0eFkzUGjNwrh/jUloABCduBLlNE0VIMYEwZX2ujyPjjCO3Kt4XzRgEuVWQ/IB+PxHK/XcUCPerRc6WxxR+aPoZZDBppcHdKjoJ7a/99bvDgys5mPlotqkITFzeZ8r/5SA3P53SbU2r6+DRktr6gOOXh1fxjPGFPx49aQ0XgmizBqF6j9qvuBn4kpgSXpjGBmvjaA6fz5bzOO5Yl7lS8b7Tkof73YADiRWttYb8mVLfuPUlzfbWqU9qdh4tflAjTPhnYLD8G6kcrSE/yUu4aYS1WcKL3sfmfRFYiLW9alcH3BO7Qe+sYfgVvLtiyZOGORvhVhWu1hS5J9+SSTQLHmYi81HyBZgYOOvfR5mLXfEA1Qp9F8gqqx8OXgViThXnhJBxvhGmMIR9219GixQW6hK0zZD9s2II29ZdrlxbxriftgN4c63HbBCZQnRRb78fB/K4+h4XIdLMioY3V0uemDGAsRbONEiizAzlKMCnq0oLDrTkgAflHgoepQDyRWCmSxSS2lkhzIes+NdUo9vZ1LGaLbol7GOjaVMFjYPf8h0KnmsFDCNnbIhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3dca13-79d6-45a8-8da2-08dcbbc998f4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 18:56:11.0349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DAKgVMl+n6HdXOV8CxZ/eT5QwB9Lh4wcH2MKsSr67wU7yNR/l7o0Sh860p6qXRCQHVEjlY1qYvW4q1vpKNPYm3QZzWVM548v1O/aED/baI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_09,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130136
X-Proofpoint-ORIG-GUID: M8QmUiWZpAcKOOm_N4FNsNrTE9sH7a1x
X-Proofpoint-GUID: M8QmUiWZpAcKOOm_N4FNsNrTE9sH7a1x
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/13/2024 2:45 PM, Peter Xu wrote:
> On Tue, Aug 13, 2024 at 11:00:37AM -0600, Alex Williamson wrote:
>>>> Note that the old-QEMU contents of all ramblocks must be preserved, just like
>>>> in live migration.  Live migration copies the contents in the stream.  Live update
>>>> preserves the contents in place by preserving the memfd.  Thus memfd serves
>>>> two purposes: preserving old contents, and preserving DMA mapped pinned pages.
>>>
>>> IMHO the 1st purpose is a fake one.  IOW:
>>>
>>>    - Preserving content will be important on large RAM/ROM regions.  When
>>>      it's small, it shouldn't matter a huge deal, IMHO, because this is
>>>      about "how fast we can migrate / live upgrade'.  IOW, this is not a
>>>      functional requirement.
>>
>> Regardless of the size of a ROM region, how would it ever be faster to
>> migrate ROMs rather that reload them from stable media on the target?
>> Furthermore, what mechanism other than migrating the ROM do we have to
>> guarantee the contents of the ROM are identical?
> 
> IIRC we need to migrate ROMs in some form because they can be different on
> src/dst, e.g., ROM files can upgrade after QEMU upgrades.  Here either
> putting them onto migration stream, or making that fd-based should work.

Agreed.

> Frankly I don't solidly know the details on why they can't be different.

Any ramblock may change if the contents are read from a file in
the QEMU distribution, or if the contents are composed by QEMU code.

> My current understanding was that if one device boots with one version of
> ROM/firmware, then it's possible the device keep interacting with the ROM
> region in some way (in the form of referring addresses in this specific
> version of ROM?), so that it may stop working if the ROM content changed.

Yes, the guest may continue to read data or execute code from the block.

> IOW, if my understanding is correct, new ROM files won't get used after
> migration automatically, but it requires one system reset.  When a system
> reset triggered after VM migrated to destination host, it'll reload device
> ROMs with the files specified (which will start to point to the upgraded
> version of ROM files), and IIUC that's where the devices will boostrap with
> the new ROM / BIOS files.

Agreed.

>> I have a hard time accepting that ROMs are only migrated for
>> performance
> 
> AFAICT, it's never about performance or making it faster when putting ROM
> data on wire.  Even in this context where Steve wanted to use fd backing
> the ROMs, then putting that on wire is still slower than sharing fds.
> 
> Here my previous comment / point was that this should be a small region, so
> it shouldn't matter a huge deal for ROMs to migrate either through the wire
> or via the fd page cache.  I wanted to remove one more dependency that we
> may even need the new -alloc-anon parameter as it doesn't sound required
> for ROM migrations.

Agreed that performance is not the issue.  I use memfd for correctness.

Also note that my new proposal deletes the alloc-anon parameter.  I allocate
non-command-line ramblocks unconditionally using memfd_create.

- Steve

>> and there isn't some aspect of migrating them to ensure the
>> contents remain identical, and by that token CPR would also need to
>> preserve the contents to provide the same guarantee.  Thanks,
> 
> Thanks,
> 

