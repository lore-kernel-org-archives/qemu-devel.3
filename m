Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4969ECAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 18:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1U2t-0003Qi-Ik; Wed, 24 Sep 2025 14:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v1U2p-0003Pc-AQ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:16:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v1U2a-0003H1-Cs
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:16:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OHtuNJ010671;
 Wed, 24 Sep 2025 18:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=eNVE5XYu3Yos4GoD51a4GMD2hEZ6H0DkDh1aDeZWJjo=; b=
 Jr1lralvPEh9LaxHLjt0icg4mvG+uxvNQg8Ux32GxdwqS+iy2xQOhin59eejI6xy
 EQQdExhqtG8NuHrsO1GjpR/bgj+oOlMI5m1NIvIK+KzgAutln4uFaVxA4f0bg/4K
 yYhJnm4bhxBHmCTvf2BP6muPnj1xJb+ODLQOAprcUPO/ETA9l4S9W8iMVNhXxdpa
 kYL1jHC0aTTTp+vftNkp9o/9ee2/h4T9qD7M3bjV6iREXtOeXsxJ1rbUTat737El
 RwV5MFwlmVcoFQX6kJ9zHjbQH3eDzgDUMxtdf67DTTCh5/QaSmESpY0FBEQ2Wq5G
 okGz4tqZxA4EnxPFiWKIGA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mtt8dan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Sep 2025 18:16:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58OGtSaJ035626; Wed, 24 Sep 2025 18:16:27 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 499jqaa293-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Sep 2025 18:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrMC1QR3evPKqhxCnn0imorja825CziqUVLCYbKJuL72eOUPgrNqnK62g/FJ3BKuvUuBpfpB2TX8AB43U6vnuoq4OWSyp69wWL063sdeyKWYS/Pv+Y6rlQUQyKKpgfeXh47CuWF26Wmb5QEEOQlACLzdEZEu+yl7KCQmMU/gCIoqb40tmeYPAqG7dydhcBoznlEaFdqGY40soK0nt1ngDch+f8grzDUNY1O/oxZIg1Sal8F+qkYg57Bn53cZFLw9zTqYiCr+IIl/RQpOJsineuWwcI381wDEQCnb3yj6Lp5v+7AsmgHIZDD51/Cygi7mbxkKIYY95mwUnibE8021iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNVE5XYu3Yos4GoD51a4GMD2hEZ6H0DkDh1aDeZWJjo=;
 b=H45eD8OPQLLGoH9MQkYGnYsT2Ebwx4dGB6Eqi0wI0NPxBQdPxnc+rFKlrx3aOfS24W5lOGx679bow4L4JF+68uHlfgL8b16qM4hCwkysmTGUKxfO8aue7FsaXARA9sXm0jfu1s1ieeuWA0STBlzTMDoxEIwuEkWQXtQs30qMh1TvkjrKOLbvpkgFCYHpeWBKInBstqR0efSx7OsMehNRMegyKCD56ILlXrpc36OBx5BKZpBB1LMUxK5HyachgRFkUtgXfKc0iMiKJZ7l7b/knY3DdNjI/aMR4/6qq0LbbG5xLYKZX/b3su2Ifa4W/n4buFn4jw3HZOq4E8rdZbbqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNVE5XYu3Yos4GoD51a4GMD2hEZ6H0DkDh1aDeZWJjo=;
 b=bVI7ciI4IzGsfxVhzq5M1utODi+B/FnsaXgUXohwBIwDcv8qecWab7cKemf2md/voutLbfXleADP8+1IJKPg4UD0P0Tu/yxxlRV736Cqa1mQuykRPgL/AjXD/BEedaFRED1E7IKkaJQUhoZ7Q4es/vmCJsFYqsrgOzC2+2WOh3Q=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB4453.namprd10.prod.outlook.com (2603:10b6:510:37::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 18:16:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 18:16:23 +0000
Message-ID: <7e7b7fda-b156-4ca7-a2ae-61f8b5c351af@oracle.com>
Date: Wed, 24 Sep 2025 14:16:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 6/8] migration: cpr-exec mode
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-7-git-send-email-steven.sistare@oracle.com>
 <c76d4944-280b-49e1-a324-36429a5513cb@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <c76d4944-280b-49e1-a324-36429a5513cb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c329b10-a0d8-4ddd-adea-08ddfb967837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZThka1NLUnFhQys3R3U5STRaaW90V3hMU0JUR2lVK29xZFFpbFp6LzNQK2dy?=
 =?utf-8?B?MkFqZlRINEdTTm1yT05MZkRKMzJMb3F5eUc0RmxoamFybEZmZkR5VXYvWWdk?=
 =?utf-8?B?d2Mxc25wUExTMnVVdDl4bFZFWnZldWlsaHJVNVZadjhQLzAzS200bXM3eCtK?=
 =?utf-8?B?WUxXS1NUUktMUUhNeDFDVDR2K1Y5NWp2MXNKUlYwUWlUdEpld25mMVpNZlNM?=
 =?utf-8?B?YVgzZnRZbkVCclV0bW9mejkyZU52Q0diTEN3K3NtTitTWmJQakNnMzZOS1pn?=
 =?utf-8?B?cGpUVUZZakZ2TFhZTi9zYkxtL09xSFlnbjVHamdZYnUxUzdSQVYyYlJDWDla?=
 =?utf-8?B?R21lV1dJZnZJZFdHOFU0ODFtazFuZkU3V2hkeDVycWx1ZmdkQ1MrUVc0clkv?=
 =?utf-8?B?dVA5SHBvbTQ3NjBVWVdvYk9Vc0pvZEU3aWZsenp5UXB0RjM5bjE0ZXdCaUZt?=
 =?utf-8?B?R1hyck5NQ0p6ZTJOenMyWGVTcDVyc0U1RTNuc0VJb0owaEFPMkxtd3k2VXp2?=
 =?utf-8?B?Rkw1TEUydDNxWHVjd2RYazIwLzdocHo0RUNFTURaTHY4aVBCUUx2N2hrNk1q?=
 =?utf-8?B?OXM4YVFyY1F3TzMwWDQyUFpzQzgwdStWTHhSQ0dLdndZVSs5NDk5SE1sbGcx?=
 =?utf-8?B?Vm0zUjlRV1lrVjJOaUhnNFYveGRMSFdDQW5aRVh2T1k1eG9sQXg3Yy8weEFh?=
 =?utf-8?B?ZEFJelJVL1FiRzVFV3VIcS8vLzIraW1ZSUtlTG1xL0VRU0locWxSaUtIQ0lK?=
 =?utf-8?B?R3cyWXl5dnJPMmE2NkFWOEs4NTdQWVVtSmtleFJvWHRvbW56SXpNaG8yam9Z?=
 =?utf-8?B?WEJzMHloTDNQY2kyd3NlSWFrKzJOS1JVUzVzR09ObnNxRGJJY1lzY3hGRGUw?=
 =?utf-8?B?ampXdm4zTnJEQmJJYktLbFdRbzEvV2NBRjdDSFZjSDlaUkhONmFNeE5SS3pF?=
 =?utf-8?B?Mzh5czJtSFlHTGl4TEF5QVFuRHNiSVZzcFJYVTJUN2F4R1FHK0FrYk5BdUpS?=
 =?utf-8?B?WFdvT1YwK0Zrek1uT2ZQbWdyVk11U2dpbkJnNmhwaU5UNGp2N3YrQjcrd0hQ?=
 =?utf-8?B?ak9aNmQxMUQ3MTYyUHhFZkwzTTdxTEZFYUNHdVViTm1VcVYxMjIraVFCdTIr?=
 =?utf-8?B?c0dmbjQxOVgxc3Z1WEUwUzAwajE2QWZuZ0o5OVUyTytLZXFQU1QvSEd4M3ZU?=
 =?utf-8?B?RWRxbXQzcDVydmdyaHpvNG50T01RdTdsOFdYeFVyWXIrdDVrcm5FS3VSNk03?=
 =?utf-8?B?UHVWVWpvdW5Pb0NVeUFPZWdSNDBTVmlrYkVmUy9DOE5SbC9ma3prSExoeXkw?=
 =?utf-8?B?eXhCQU0yS0NMcVVseXJHcDZWSmE4YkNEM1pSV2thYzN2eXgrSXpHenJCSjM1?=
 =?utf-8?B?SGpWeGJHTFYyTHJjMGFXb2xEdWQwYVJaUm8zaTJYRE1LblgzOUMwa29kcFNn?=
 =?utf-8?B?VTE2WnExcEVxWk5WME9Xb1RDMjM2SWpZbm1ZM0tnd2hZQ2ExZkpGS1NpV0My?=
 =?utf-8?B?ZDQ0S1hRWElaTDRJSkpvUXNISGxUMnFEVklzRWxXR1pRLzFTWE9YSG9qVDZE?=
 =?utf-8?B?RFZON2h1S01yS0NQY0RHNnJrLzdQRUdJOXhOdmFEdHRmcm45blk1S21ja0pu?=
 =?utf-8?B?Nmt2SHpKM1RGUGNCaDlTZTc4TXhwUXhjWlJLeExjVGdSTEZTUXAxTi85NHpT?=
 =?utf-8?B?Sm1aY3ByUzZkNTFQaGM4VGkzb3RvVlhITHN2NXdnMnMwd0U2MTc2TnU1MDhO?=
 =?utf-8?B?VUlVTFJ1UTI2TU9qZTRSdFdzRmNIdE1lNWh1MnI0WEpnaXQ0dzNqQXRZcUNt?=
 =?utf-8?B?cFdDQUYrZzJnbWgxVnE0R0w2alhtUHIwbnZvQzA0TGpzR1NkWU1rVkltbktS?=
 =?utf-8?B?cUIvbW1VN2JiNEJaalc3a05aWkFwUXZhU0toMUQ5WHg2dnFLV0E3RHJSSEI4?=
 =?utf-8?Q?sMrDcBu8Pn0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHoya2JkdHZlQm9zeGp6ZkZaUmVkc2tGVlNtYVNpNE9mNWpheVZCK3lyblJk?=
 =?utf-8?B?bHBORVN0OUk5ZG9vSmdyaTh0WWRUaVg0c2NHSUluUkZKcDQxWVRQYVgwRHdT?=
 =?utf-8?B?NDhoYitITElEUjlKK0paRXhWcWo5bjBnQmxmWWFtNDd4aXlmam9ENTlBMHZE?=
 =?utf-8?B?YXhDalN2ZkdqcURWbHVYYmhjOXowbkFaUDUrcEJVY0QxVWd2aTJJbnRHbGVj?=
 =?utf-8?B?QlVtU2Z1K20zMVZMNHY5NDhYNzBCc0o0V0pPUzRjZkRyRVhFOUE2b2ZvQThX?=
 =?utf-8?B?MnF0REt4QndOVVZrOTdFMDNLeXowd1N1VzVSYTZNWm82MWttRUYrcVZqSXIx?=
 =?utf-8?B?ZkFCeVB1WWxUSkFXdXRSMXdBTEQ2M3dvOHBmYU54ZlM1cmljUnZKMnhhR3dI?=
 =?utf-8?B?RlJySWlUS2FqTFBTc2gwSlc5eEloSHFaSkp3VHZQMldQRkYzVFZDdlBEWlJP?=
 =?utf-8?B?TWEzejkwNTNVK25PbW9pRnNZVjdmanY2d3Zkbm8zejZhbUZHVW9BVktJL25z?=
 =?utf-8?B?K0wyM3ppaGgySWxkdlNJR1N0QnMwTGhaOTB2SkExWVVtWWsvclY4U1UxNHU2?=
 =?utf-8?B?VjhrWDMvQm9udUdVeDltMXZObzFGRXcrVzN6VU9ud05ES3ZJUnJTaCtha3Jj?=
 =?utf-8?B?Q0xnQ2F2TFl1TlpkVnJ4L0VmOXgyQmZRVEE0ZVVkaXdhRFY2cDBFZTJVZURu?=
 =?utf-8?B?aFYzRWowUWVHN1RMS2ppcmR3NStZbHlCVFpQdEw3eUJHWFprNUptZTV3YmRo?=
 =?utf-8?B?TkpMcHcwTnZiUE11Q3NFMytGenJ3SjNEdFplVThhSWJIeEw3ZGlROUpFbXZS?=
 =?utf-8?B?akZwQllGSUpLZ253TkdoQ0E0Zmk4bmRCenR1Q2NnT1JoNjVLTXpFb0JxUWhT?=
 =?utf-8?B?M3R3SDl3UENsMExndWlZc0VWUjViNXA2Z2pmMU12OHNXTC9WMzZOSFVPVjUw?=
 =?utf-8?B?NXpjVUNCcVFtZVg2UllQY2V3dmFCSW55bk4vRkl3WkpjV01NNUFnbmtWZUxm?=
 =?utf-8?B?eWF3bW55dzlyVUJoSERvUkVaVjdLR2dIcmRiZnBWS2cyWkY0bzNUa0hiaVl4?=
 =?utf-8?B?cUIvazlwNUxFU0htMnNvM25BWEppa3QxSHFtdStPZURURWtEZXAvclNHRjlu?=
 =?utf-8?B?V3k5SEtLM2p2NHdaT3orWG1qM0ZldTdqbXZLTDcrWFRmdlZaQ3dYQysva0V4?=
 =?utf-8?B?dmRxUGlDai9sd1FHeXdzc051b0wydkFLemxrMlhGSDJqVVBteTFrbGUrcFda?=
 =?utf-8?B?V0oxc0I5L0ZueUhZcnE2UG9ZVW1SNERKVW0vc2oxWGIvYnplYThpUFRWUkNY?=
 =?utf-8?B?ZFIxYysrU1phSFNEbTZkcCs1NkRXZEtvbXp0TlBINWM3T1RIQjY3SVpWd0hw?=
 =?utf-8?B?RmtKUWloakdTSnY0SHJHczFNMlNydUt5dzJHMVREeWorYnhlQldzNG84TnZY?=
 =?utf-8?B?c05sZk9wL0VjZjlSZ3pMc2FmZW15SjdUc3VJK0Jpa0psdE5CNmcvRVlDVjNJ?=
 =?utf-8?B?VklzMGwyOTcvWUxQaHdvTDk3dU81WlVFNmQ5ZU5YeUwwbzluZXR3a0puRHNk?=
 =?utf-8?B?U2h6Y0Zjb2pGRFdxMTJOMXRIcVNYYVhiajYxSG1zeVYzK1RmTldoS1YyK2RN?=
 =?utf-8?B?dmVqaXdyS3poMWR5RVVLWlNORGtMQmlVblNJczVyVVk1UnN3a1VYS1daZTFs?=
 =?utf-8?B?UldjMzJVVnB5akRCWTFsMGkrVk9WSkNXbTN4Wlh0WmRXczJrcW1VelB2SlZR?=
 =?utf-8?B?OUNJSThzZ2VSSGlCejdJeXFBS2I0OFJFSkNqcWtlNUkxRklhN3I0M3RQemg2?=
 =?utf-8?B?TEJTcXNzc0FjQ2RuUHpmR2VZSE9VUlBPbUFTWndzUng1SVlJZE9WcmJxWEVD?=
 =?utf-8?B?M0J2VS9nbGNTWnhhVElwSG5YbzhuMDZ0Wm5CWjFsMWlzZTVEZ0FwV2oyOUYv?=
 =?utf-8?B?QW56aUNWaGQ4d0FmRnBtZEFWODRmZTkydktoTkpDbUtqRnQzYmpnY01kN1BQ?=
 =?utf-8?B?ZmdPdmlNRkpHZHByVHB2eEszelhYTGc5QktiSjY4cDByOXNORkVNSmJIc1Z2?=
 =?utf-8?B?a01VRzdxbTQxNWpkdWpyR3phR2RBdWNxRThaSHJRM1ZFNGZBYXM3VVE2T1kr?=
 =?utf-8?B?dlB0eVBhenVKSzdIQ0ZpVjRFd3pLc2pEYnF0dGZRY2dMbllOME5wcXV6Mmlh?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eJDIcz9uZftryOMWoLKlwlNX3OCq3sPxsgDXGov9r86k8mrrhhkVlqo/H6gXeUvk6U8ubgB0Kyk4ngkLhhcKotpprXPrnbX9iGcI2LpKUyVtDWUqUf2CWQogixhRSXLVrNClulUpiBNodex3ABZAxmUi4yv7jPTeUzo49mxbA+58P+Fm3fn/Z+jA6JeDfpL4uQgmW8VqOT5ZdgJPpOJLgbD1YVqTaG2+P7tUmS0k6DhJwHYhJTqZuEHZxhpeexI5/Ig0Pm6oiwy2ciNTalpLt97iKlzNj0h0milOF6NXEV4sMCeDtgObRj+AB8To/eDm71wrK1Q2AFup0Iq4kmb8sToTMHmnLC4gTkO2bCCjpWOv8eq9rUooROa/qv1MvMJ+YYahwaAklVJzzifKomPyHsdYADhwi1xNdRvwZGSgSD+T97RxnKEUI8FewCcRBXlvlR3RX3k1wxYruUoaQM2GfcnF3PRcnbRWzinrKRR3MVCfseq73MBdSZp58VKXxrXfaY7fOOnP8Hr+kYv201LZjW8gTZgUb5N+z0hF1fjGVQIJzcVzuOGQkNxRO+mEq97S8q1/NWeVuguBpClXaxBGoID9o9YxwI3BsO5cWbn8GZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c329b10-a0d8-4ddd-adea-08ddfb967837
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:16:23.8684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK6igBBGp8xGNE8ac1v8vobZTL8v4gUw5M0cwHQ9PbzxZf/DDynEd0qQBzRNfLRrbGeJS5vTMiCQd508IW8e4NAMNSzBuYBR82NQ0xz5cl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4453
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509240158
X-Authority-Analysis: v=2.4 cv=fd2ty1QF c=1 sm=1 tr=0 ts=68d4357c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=kJ1Mwjs3QBgs3QrDmDoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P_AX0hyIerxMyhRxdeoNN1oaXh-G25Hh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNCBTYWx0ZWRfXya3amJHIpSs3
 jHkHjB8Ca5zNVwGcy8xK/BcyF5BkyDpF1IKK8kexQjDQFT/kUV2kMEO4D5VBoIwuy6ujG+RbPXG
 xA3fvu9xpGP3mwMoxHJsNKu/aIrrt+9V5YYHQYDFW/qTdB4Y/1u/7Vrx3hKjXApBAHqaulk7UFq
 KY9cmRVA6jWqe5FqpDYVA+D46cDHBRNzUIlYAisN6WCikjq/FcU91RTsWibFEJzFoDu/xe9Jz9m
 4sl8fzyXL95PsqZedNGn5W+VubEWbaPFQjylVS1BdnYwuptkTQlnT0Dww2kC48GLiIMPIno64sU
 AVwoc51k6zi0rFlIzK/HL27y659QxmqL2LkDhrVnObXFqj+UqBVUK9IAxsDWPxZIIyUBSPZwzxA
 UkJL0FVZ
X-Proofpoint-GUID: P_AX0hyIerxMyhRxdeoNN1oaXh-G25Hh
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

On 9/22/2025 11:28 AM, Cédric Le Goater wrote:
> On 9/22/25 15:49, Steve Sistare wrote:
>> Add the cpr-exec migration mode.  Usage:
>>    qemu-system-$arch -machine aux-ram-share=on ...
>>    migrate_set_parameter mode cpr-exec
>>    migrate_set_parameter cpr-exec-command \
>>      <arg1> <arg2> ... -incoming <uri-1> \
>>    migrate -d <uri-1>
>>
>> The migrate command stops the VM, saves state to uri-1,
>> directly exec's a new version of QEMU on the same host,
>> replacing the original process while retaining its PID, and
>> loads state from uri-1.  Guest RAM is preserved in place,
>> albeit with new virtual addresses.
>>
>> The new QEMU process is started by exec'ing the command
>> specified by the @cpr-exec-command parameter.  The first word of
>> the command is the binary, and the remaining words are its
>> arguments.  The command may be a direct invocation of new QEMU,
>> or may be a non-QEMU command that exec's the new QEMU binary.
>>
>> This mode creates a second migration channel that is not visible
>> to the user.  At the start of migration, old QEMU saves CPR state
>> to the second channel, and at the end of migration, it tells the
>> main loop to call cpr_exec.  New QEMU loads CPR state early, before
>> objects are created.
>>
>> Because old QEMU terminates when new QEMU starts, one cannot
>> stream data between the two, so uri-1 must be a type,
>> such as a file, that accepts all data before old QEMU exits.
>> Otherwise, old QEMU may quietly block writing to the channel.
>>
>> Memory-backend objects must have the share=on attribute, but
>> memory-backend-epc is not supported.  The VM must be started with
>> the '-machine aux-ram-share=on' option, which allows anonymous
>> memory to be transferred in place to the new process.  The memfds
>> are kept open across exec by clearing the close-on-exec flag, their
>> values are saved in CPR state, and they are mmap'd in new QEMU.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qapi/migration.json       | 25 +++++++++++++-
>>   include/migration/cpr.h   |  1 +
>>   migration/cpr-exec.c      | 84 +++++++++++++++++++++++++++++++++++++++++++++++
>>   migration/cpr.c           | 28 ++++++++++++++--
>>   migration/migration.c     | 10 +++++-
>>   migration/ram.c           |  1 +
>>   migration/vmstate-types.c |  8 +++++
>>   system/vl.c               |  4 ++-
>>   migration/trace-events    |  1 +
>>   9 files changed, 157 insertions(+), 5 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 2be8fa1..be0f3fc 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -694,9 +694,32 @@
>>   #     until you issue the `migrate-incoming` command.
>>   #
>>   #     (since 10.0)
>> +#
>> +# @cpr-exec: The migrate command stops the VM, saves state to the
>> +#     migration channel, directly exec's a new version of QEMU on the
>> +#     same host, replacing the original process while retaining its
>> +#     PID, and loads state from the channel.  Guest RAM is preserved
>> +#     in place.  Devices and their pinned pages are also preserved for
>> +#     VFIO and IOMMUFD.
>> +#
>> +#     Old QEMU starts new QEMU by exec'ing the command specified by
>> +#     the @cpr-exec-command parameter.  The command may be a direct
>> +#     invocation of new QEMU, or may be a wrapper that exec's the new
>> +#     QEMU binary.
>> +#
>> +#     Because old QEMU terminates when new QEMU starts, one cannot
>> +#     stream data between the two, so the channel must be a type,
>> +#     such as a file, that accepts all data before old QEMU exits.
>> +#     Otherwise, old QEMU may quietly block writing to the channel.
>> +#
>> +#     Memory-backend objects must have the share=on attribute, but
>> +#     memory-backend-epc is not supported.  The VM must be started
>> +#     with the '-machine aux-ram-share=on' option.
>> +#
>> +#     (since 10.2)
>>   ##
>>   { 'enum': 'MigMode',
>> -  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
>> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
>>   ##
>>   # @ZeroPageDetection:
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index b84389f..beed392 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -53,6 +53,7 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>> +void cpr_exec_init(void);
>>   QEMUFile *cpr_exec_output(Error **errp);
>>   QEMUFile *cpr_exec_input(Error **errp);
>>   void cpr_exec_persist_state(QEMUFile *f);
>> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
>> index 2c32e9c..8cf55a3 100644
>> --- a/migration/cpr-exec.c
>> +++ b/migration/cpr-exec.c
>> @@ -6,15 +6,21 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/cutils.h"
>> +#include "qemu/error-report.h"
>>   #include "qemu/memfd.h"
>>   #include "qapi/error.h"
>> +#include "qapi/type-helpers.h"
>>   #include "io/channel-file.h"
>>   #include "io/channel-socket.h"
>> +#include "block/block-global-state.h"
>> +#include "qemu/main-loop.h"
>>   #include "migration/cpr.h"
>>   #include "migration/qemu-file.h"
>> +#include "migration/migration.h"
>>   #include "migration/misc.h"
>>   #include "migration/vmstate.h"
>>   #include "system/runstate.h"
>> +#include "trace.h"
>>   #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
>> @@ -92,3 +98,81 @@ QEMUFile *cpr_exec_input(Error **errp)
>>       lseek(mfd, 0, SEEK_SET);
>>       return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
>>   }
>> +
>> +static bool preserve_fd(int fd)
>> +{
>> +    qemu_clear_cloexec(fd);
>> +    return true;
>> +}
>> +
>> +static bool unpreserve_fd(int fd)
>> +{
>> +    qemu_set_cloexec(fd);
>> +    return true;
>> +}
>> +
>> +static void cpr_exec_cb(void *opaque)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +    char **argv = strv_from_str_list(s->parameters.cpr_exec_command);
>> +    Error *err = NULL;
>> +
>> +    /*
>> +     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
>> +     * earlier because they should not persist across miscellaneous fork and
>> +     * exec calls that are performed during normal operation.
>> +     */
>> +    cpr_walk_fd(preserve_fd);
>> +
>> +    trace_cpr_exec();
>> +    execvp(argv[0], argv);
>> +
>> +    /*
>> +     * exec should only fail if argv[0] is bogus, or has a permissions problem,
>> +     * or the system is very short on resources.
>> +     */
>> +    g_strfreev(argv);
>> +    cpr_walk_fd(unpreserve_fd);
>> +
>> +    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
>> +    error_report_err(error_copy(err));
>> +    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>> +    migrate_set_error(s, err);
>> +
>> +    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
>> +
>> +    err = NULL;
>> +    if (!migration_block_activate(&err)) {
>> +        /* error was already reported */
>> +        return;
>> +    }
>> +
>> +    if (runstate_is_live(s->vm_old_state)) {
>> +        vm_start();
>> +    }
>> +}
>> +
>> +static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
>> +                             Error **errp)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +
>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>> +        QEMUBH *cpr_exec_bh = qemu_bh_new(cpr_exec_cb, NULL);
>> +        assert(s->state == MIGRATION_STATUS_COMPLETED);
>> +        qemu_bh_schedule(cpr_exec_bh);
>> +        qemu_notify_event();
>> +
>> +    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
>> +        cpr_exec_unpersist_state();
>> +    }
>> +    return 0;
>> +}
>> +
>> +void cpr_exec_init(void)
>> +{
>> +    static NotifierWithReturn exec_notifier;
>> +
>> +    migration_add_notifier_mode(&exec_notifier, cpr_exec_notifier,
>> +                                MIG_MODE_CPR_EXEC);
>> +}
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index d3e370e..eea3773 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -185,6 +185,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>       if (mode == MIG_MODE_CPR_TRANSFER) {
>>           g_assert(channel);
>>           f = cpr_transfer_output(channel, errp);
>> +    } else if (mode == MIG_MODE_CPR_EXEC) {
>> +        f = cpr_exec_output(errp);
>>       } else {
>>           return 0;
>>       }
>> @@ -202,6 +204,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>           return ret;
>>       }
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        cpr_exec_persist_state(f);
>> +    }
>> +
>>       /*
>>        * Close the socket only partially so we can later detect when the other
>>        * end closes by getting a HUP event.
>> @@ -213,6 +219,12 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>       return 0;
>>   }
>> +static bool unpreserve_fd(int fd)
>> +{
>> +    qemu_set_cloexec(fd);
>> +    return true;
>> +}
>> +
>>   int cpr_state_load(MigrationChannel *channel, Error **errp)
>>   {
>>       int ret;
>> @@ -220,7 +232,13 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>>       QEMUFile *f;
>>       MigMode mode = 0;
>> -    if (channel) {
>> +    if (cpr_exec_has_state()) {
>> +        mode = MIG_MODE_CPR_EXEC;
>> +        f = cpr_exec_input(errp);
>> +        if (channel) {
>> +            warn_report("ignoring cpr channel for migration mode cpr-exec");
> 
> migration/cpr.c does not include "qemu/error-report.h"

It builds just fine because it is included indirectly, but I will include it
directly.

- Steve
>> +        }
>> +    } else if (channel) {
>>           mode = MIG_MODE_CPR_TRANSFER;
>>           cpr_set_incoming_mode(mode);
>>           f = cpr_transfer_input(channel, errp);
>> @@ -232,6 +250,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>>       }
>>       trace_cpr_state_load(MigMode_str(mode));
>> +    cpr_set_incoming_mode(mode);
>>       v = qemu_get_be32(f);
>>       if (v != QEMU_CPR_FILE_MAGIC) {
>> @@ -253,6 +272,11 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>>           return ret;
>>       }
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        /* Set cloexec to prevent fd leaks from fork until the next cpr-exec */
>> +        cpr_walk_fd(unpreserve_fd);
>> +    }
>> +
>>       /*
>>        * Let the caller decide when to close the socket (and generate a HUP event
>>        * for the sending side).
>> @@ -273,7 +297,7 @@ void cpr_state_close(void)
>>   bool cpr_incoming_needed(void *opaque)
>>   {
>>       MigMode mode = migrate_mode();
>> -    return mode == MIG_MODE_CPR_TRANSFER;
>> +    return mode == MIG_MODE_CPR_TRANSFER || mode == MIG_MODE_CPR_EXEC;
>>   }
>>   /*
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 08a98f7..2515bec 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -333,6 +333,7 @@ void migration_object_init(void)
>>       ram_mig_init();
>>       dirty_bitmap_mig_init();
>> +    cpr_exec_init();
>>       /* Initialize cpu throttle timers */
>>       cpu_throttle_init();
>> @@ -1796,7 +1797,8 @@ bool migrate_mode_is_cpr(MigrationState *s)
>>   {
>>       MigMode mode = s->parameters.mode;
>>       return mode == MIG_MODE_CPR_REBOOT ||
>> -           mode == MIG_MODE_CPR_TRANSFER;
>> +           mode == MIG_MODE_CPR_TRANSFER ||
>> +           mode == MIG_MODE_CPR_EXEC;
>>   }
>>   int migrate_init(MigrationState *s, Error **errp)
>> @@ -2145,6 +2147,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>>           return false;
>>       }
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC &&
>> +        !s->parameters.has_cpr_exec_command) {
>> +        error_setg(errp, "cpr-exec mode requires setting cpr-exec-command");
>> +        return false;
>> +    }
>> +
>>       if (migration_is_blocked(errp)) {
>>           return false;
>>       }
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 7208bc1..6730a41 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -228,6 +228,7 @@ bool migrate_ram_is_ignored(RAMBlock *block)
>>       MigMode mode = migrate_mode();
>>       return !qemu_ram_is_migratable(block) ||
>>              mode == MIG_MODE_CPR_TRANSFER ||
>> +           mode == MIG_MODE_CPR_EXEC ||
>>              (migrate_ignore_shared() && qemu_ram_is_shared(block)
>>                                       && qemu_ram_is_named_file(block));
>>   }
>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> index 741a588..1aa0573 100644
>> --- a/migration/vmstate-types.c
>> +++ b/migration/vmstate-types.c
>> @@ -321,6 +321,10 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
>>                     const VMStateField *field)
>>   {
>>       int32_t *v = pv;
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        qemu_get_sbe32s(f, v);
>> +        return 0;
>> +    }
>>       *v = qemu_file_get_fd(f);
>>       return 0;
>>   }
>> @@ -329,6 +333,10 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
>>                     const VMStateField *field, JSONWriter *vmdesc)
>>   {
>>       int32_t *v = pv;
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        qemu_put_sbe32s(f, v);
>> +        return 0;
>> +    }
>>       return qemu_file_put_fd(f, *v);
>>   }
>> diff --git a/system/vl.c b/system/vl.c
>> index 4c24073..f395d04 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -3867,6 +3867,8 @@ void qemu_init(int argc, char **argv)
>>       }
>>       qemu_init_displays();
>>       accel_setup_post(current_machine);
>> -    os_setup_post();
>> +    if (migrate_mode() != MIG_MODE_CPR_EXEC) {
>> +        os_setup_post();
>> +    }
>>       resume_mux_open();
>>   }
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 706db97..e8edd1f 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -354,6 +354,7 @@ cpr_state_save(const char *mode) "%s mode"
>>   cpr_state_load(const char *mode) "%s mode"
>>   cpr_transfer_input(const char *path) "%s"
>>   cpr_transfer_output(const char *path) "%s"
>> +cpr_exec(void) ""
>>   # block-dirty-bitmap.c
>>   send_bitmap_header_enter(void) ""
> 


