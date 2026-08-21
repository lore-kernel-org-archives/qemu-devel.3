Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F017C5DF8C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxVaj-0004v1-J6; Fri, 21 Aug 2026 16:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wxVah-0004uL-5V
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 16:11:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wxVad-0002gF-Kt
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 16:11:50 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LJMom23106509; Fri, 21 Aug 2026 20:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=UnQnU0FhLRfzfdVBPdY9xzhBcCFaTBLd5KENXqRtQqM=; b=
 J2mHCfbm+R+f+utOvuE6NIFddSZcyR6ShMgK/go/3s+RnEltfW87J4BaDDi4gCD6
 Krs0CXXhnzPS5V/M1pJnD63zFzj3Gfr+Dg/wYuKfICTbSE64f6AgTma0BcoK1nJS
 rYyJaknfxeW8W9MiNZ7N0cw24Y1sGspapTKahXbakRqMAkntF/fN9JPUytl3QUHS
 u1wsv6cLOqAsJ4okHJ86BoyHk1ad0PRtaJMgP65pqGF2Tl77V8fJbiigDqYrb5lX
 W3oe8hu3FEFKsmEUNFVoeonkMzzEZkPqPInvlK6t5zsaUdB1GdFl3gok7JhcDB5r
 oD6gmF4XcviaVh3mDFTF2Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4yd9wr5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2026 20:11:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67LKAewl024746; Fri, 21 Aug 2026 20:11:28 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012070.outbound.protection.outlook.com
 [40.93.195.70])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4g32huueb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Aug 2026 20:11:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbPVuDP02jGQ3QnnG9POz5rZEseST0vdfkw+CM2qYYp5xJeE2bLytDQs7QycI1IGEgJVEHFFAh2duyd1OSqmxC6f+78eMZjFYE1woACqjV09qXowdcTXLcp7tTOsui7B9AjX1toqGdAJ5rp4XfSunZAIgURx5XuhQuATHE6U4boKNvcyr5mGzxYyloxfQG9Kv409hoKLD2+qOCcP1emPQn3u7ynIhmL+aXAN/AddjzPe/XTF/APtORvlwY89mZGI1s9w5Ix4qGIS+MU3FA5OSH6rdbJNL7KGVfKTulJEnlaxp/c+pm20/H+n4LS6uh0PhgYpJ11Rd0xxoJ5s6EGSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnQnU0FhLRfzfdVBPdY9xzhBcCFaTBLd5KENXqRtQqM=;
 b=DTgKv7FM+po8jhTN8qukQLe8uW83D65p1h7gk9AwEVykg4C3XL2ld3MkvWjhOIZkHp/cD+GaermSLDHaEjA1arS1whdITrNp1Pj9zLpfLl8FmSj46peFuXNubCHqUSpkGHnWjWhWLre9jP3WCmgwoNXli3ieSDxyPMB7Ik+5Jj9IsmXxNwllDuWMmyO9zWuTPDo586DNSVuDTSrpi8XzMVtQENVzKKDa4fbIkp6n3OYdMe7GS0zTEFYOAFw1JaT/3vThghB3Kz16NqsQycrpdLLBmliDpbIjHjtIS6OiGFnlZ2xzL6FXiVXKqmVoYR89NtZ9GiCwC5yKkVBEl7CRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnQnU0FhLRfzfdVBPdY9xzhBcCFaTBLd5KENXqRtQqM=;
 b=xzHX4vleypCCTCeDHhybcn9pqlX7aBi5JvpcNoXvrDwV/fNiD5uifcrT480aTPXJBhexdBHccfs0krwSV70fvLJgCyBNrJ3tVaiBAFUT4zSrLF7fikN4V48rcErNwjNcnOeQ6YXuzEU4rLa58npjZV9vn+5JfLPTBV8VDFnlNIc=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by DM4PR10MB7428.namprd10.prod.outlook.com (2603:10b6:8:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 20:11:25 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 20:11:25 +0000
Message-ID: <a23d9e5b-d0ed-4e9d-95ae-e0fda4bb0453@oracle.com>
Date: Fri, 21 Aug 2026 13:11:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] migration/qapi: Add memfd migration transport
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, maciej.szmigiero@oracle.com, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
References: <20260812232842.470225-1-dongli.zhang@oracle.com>
 <20260812232842.470225-2-dongli.zhang@oracle.com>
 <87a4qh46ao.fsf@pond.sub.org>
 <614160f2-2f3e-4489-ac4b-758f162be553@oracle.com>
 <87a4qg0wv9.fsf@pond.sub.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <87a4qg0wv9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::21) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|DM4PR10MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bb082e-5aa8-4f09-c203-08deffc06059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|10067099003|3023799007|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: Bz7ToxfpHv6MUW8AEk3HeOt9ONhzJJiWYAbeXp0htupnCSLi304kGlUxkdTydkWYGPvYitU52TG6ZhXm8EQHN46EGQmqvpctEXKV6BOtRudV+HzGvpnPmD2WiVxF+i7rA54zX/Tn0mE2AQ0y60Lgi9MRcvljIzNDu/2Ik8WlTb1G/B+UaNCzPhBEFcXgSO8W3cK9kWRrYw5qNWtKB5WphLwVk4eFIrJfOBSQm1vNUJuIDyqR8JY38ikutZOr7d5JW4mnGM9rBOl/RP4rSAdX0SQK7Ro1dAkdV3R8Wyk5ZT2N8Xs1KJ4082JMLPX/zlxe+3woVknyrl8AutezfLrpBycvdV4R4vJxGhcpvAK5c8gJEFgcoyCowY0A2m2VYpiwqTJnym2AdcskYjWCf2rlAHDy5qv1BB2v551RO0pOZ37zM135epDoeO816Q6uZie44SiOzymWA3E3sY2JfQgsFr2OGuBM9l5tIOz7mEkmasyeJsuL1lFEaDrmstmYqvFs0YAVKdjNt288zZnU5/w2J5EG59YHvMqjwJLYbuIJAoTnc+ZNQBFjQY79TkJC7sQwV3/McZXhQXb5PjiV70179DOKgbTvZHR2VYFUf8VF0zDM3XUclGVTJjePRB62Ec7rhPlReYAAGxASnPNMxxiKAiy8w9+Pwpd8Yq/V/LeBlig=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHJBYnFNMjAvYmM0TkRvaFhTZmpNNHpSclA2MVladmdYZVBQMmRDd2ZwSVl2?=
 =?utf-8?B?RGVRaUN5bEhNMms1S2ROK3FoM3FlS1Q0MitWUmFXNG5meVUyNUY0cklSZ2dV?=
 =?utf-8?B?R2RZQ0gzb2krUmZ5UURQOU10YXBobEowdzFUYW15U09oSFNRb2MwWHRlbzJH?=
 =?utf-8?B?NEMwQjZLWW1sbnRuV2hJY0dkVTJCNHo2VFVrRUR1ZWhsNGFOUlFWZXNyY0Z6?=
 =?utf-8?B?a3hreUtYWS9iQU5YbW1Ralhycmg5RTdCaXFFSmVMZkxaMVNpUGZuWFhYOFdR?=
 =?utf-8?B?c2hZci9rWDE1RWhkQ1hCUk9MLzcvb2N2bnEyZVkwMHNiUWtIRWVpZ1p1cDlz?=
 =?utf-8?B?V1JqbW5STUxRRE1uQSs5L3Vjd25jQ3ZxdEJEZmZGRU01c3NvQWdJYkdUdVJr?=
 =?utf-8?B?VHhvWnlHb0wrUlAzMUlzYnpxL2NvZFc4ZzVHZVJuYnRTTGVJalFEcnBsOE1m?=
 =?utf-8?B?a0l2b0FPaTZ1WGJxbCsrUGEvV29NNzJEYWxLNmJXenVSM2FpQ3ZsNGZDbkpk?=
 =?utf-8?B?b0RGa1dHOWtRUXBLcnl4YkNDYmxQVFNCNUtVRTZHaUZZTDNsaU5ZK0xGK1JK?=
 =?utf-8?B?K3lYbTFacFVPVmFIK0RXSWE2N0M2MjlrU1B5dVNxVDl3QXhyNEVRTFpIUW5J?=
 =?utf-8?B?VnE5OXNwcWx4MERSZjROVVpyK2VqTmhlbjFGM2hkdUV0REZHZHB4WDlRUFM2?=
 =?utf-8?B?MUdxaGUwaGs4aTBrYXBPQkl5YmNOdjhTMjlvc21tVG45c3RtWVhoczQzdW9r?=
 =?utf-8?B?QUZrRGtQSTE1Qyt2dlF1bzl3RlNYWUszNngvaGh5UGh1RE4vNkt3L09nQlBi?=
 =?utf-8?B?ZWdubjNRL0xoSDdzcytzdmVFTGU3QzNQNk14YUxrRWNydC9MSmJjUURjNEhT?=
 =?utf-8?B?UVdXMkNpMll2Zm1wamxLQVZGb0N6M2h2bFFQZkE5cHZjeFlIVHhLSlpodUxZ?=
 =?utf-8?B?emh0eDFhUjhMcVhzcnBmcVhjMDE2eFJmcDFYYVRUaU9VRHhnTnpaSU9MbVR0?=
 =?utf-8?B?OFJYT2pzOGhXeXlsYjZDYXRVRW16VFc5ZGJrdUp3a3N4WUExVEFqZFN2Wisx?=
 =?utf-8?B?akNGZ2xKcWgvSFg4SnNBZ2RSSWF2WU91YUV1UzBGSVg0bWJYNXRhS0hla0NB?=
 =?utf-8?B?ZmZaa1diUTVvZ09yVlVBUGN3TEtLZVlGTHNxaytMY3lYYzNiRXR3WXdxM01a?=
 =?utf-8?B?aEoyM3dWV0s1bTNhMWQ5VHRRWVpKdThZM1cvQTQ0STYyZ21NSlRySXFWRWNB?=
 =?utf-8?B?TnVGVVBlcE90T1dzWEV1WWcweXFnSjVZbEhXZDB4MHJuKzBXUWZCZmd3cVJq?=
 =?utf-8?B?c29xQlhSM3IvaERRT00yeCs1dXV6VXBPdGpUK0JBYitCaisyOStpT0pHUmdO?=
 =?utf-8?B?RXRheGo3cFl3YkNMVFBTUlhmUnYvRHdmRk9KVWhhNEt0clFMeXdiOTRjUW02?=
 =?utf-8?B?M3JJOEx2S1QwRnA2ZGYrekI2ZWhSVGFIZ1NjdzFHQWZWaG5DZStleUxLaDFY?=
 =?utf-8?B?ZS9mb1orelhEN1g5azdtL3lUWnN2MVMwL0ZLWC9hczNPWWJrQmVVSHIwVHYv?=
 =?utf-8?B?QVYzekFwcWJMaDErclhBQnNCOVNrVnFVbFJ4NVNJZnlqZnpxRVdZcHJJbTNW?=
 =?utf-8?B?bHNNT0pvQk01ZXd2bWdleWR6bmtUeDR6SUphdkxUQ2pCTE5PWFQ0aHVqRWZZ?=
 =?utf-8?B?VERxUDJXc3gzUzV6UW1FVnc4STlabkZyWnEwUlpOZGlXYmZXSFVsaGVobk8w?=
 =?utf-8?B?UHMrOU1jV0NsTHc0TVNGdk1BaTliUmdObGxqVUVGa0wyajB5UWl2RERsaVNV?=
 =?utf-8?B?U3E1bDVHTm02TG1BY3luenJVM2w1cjlYWjhpdURRMjJ5a1VKMlRQQmNuUGlh?=
 =?utf-8?B?ZjNHSVErNlE4UEZsT0Z2OEFKVllQekhrREE5SjQ0OG9pTEJqOTMza2pSaWNn?=
 =?utf-8?B?aTlQRWhxUStNMTk4QU42WjdOR0pnTnFDc1ZjOElQamFTZmVTdVNCaDVHekRx?=
 =?utf-8?B?WDFxRStEMnJVajVUQnFSVm5XMEdpMGdUWlF0NnJ2NVVSdDBjY0tWaW5Ia3Zh?=
 =?utf-8?B?YlFQVFBweW00RVVhRm96aTh3UHlHUTV4Y1U1Q29qYXVtMUxMOVRLbUlyMDhn?=
 =?utf-8?B?VUE0MG1COXdMNlA0U0lmWm9JdGpZbTRIOWZyd21RZTRRbnhLamxMcEtobXhV?=
 =?utf-8?B?UVBUMTMvbDZFYTNudkp2ZHBuaUFXaFdGemthRVE3a0FDeGVIWTZPcDJZTnNk?=
 =?utf-8?B?Sk1mSXlic3dVNnpKOW1QMmhYZ2JabnZjTzlSWUxOb3h6ZzBoZUpFVWc2ak9l?=
 =?utf-8?B?cTFhendKMVVYMStXdUdibXdHMXlPWFZRNDMreUJDdmU0di9JRXQwZz09?=
X-Exchange-RoutingPolicyChecked: YElMwbZ15y0hxa28xaIiMy2eqau3LaXdWwIHSe9X4Gbzj+5gXJ7fhJzEWMR50gDzDemOMZjWea82w7mrBevtrAC53Lr5EKor/4VAA2gwM/aa241AHEtvCLFS15tiYvZj6UdU/vs1X1I/liyYCpvn46BcEoCBCI1Qm4pea8YXqJLslLz5yET3p69SarHeZWosz8NhWSX0LP7pvZvkGHkLad3+rFTlyBzkggo7jjw/S/ncE80hRtqN+7G0LTUJWkw4jiVi5j7K8BEjMEE6I/I+FMn9++w97mCDYXgnxutNXSWds+ccVr/CIdgjffAyvHR31uzOX6YhTT+oozXTQxdyTg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nxuJxRsYq2gQ3nGMEfQpn21dcCygnjoxnX+hdjbx779ay0vMXHRpBHxev4QfC0S+uRCNolv1hHe2SXTUz4WQSJMvqRcWLlKItuDOkyNhDHVqOqHgCgO+obHo+SDGG/a8d60q8vn/tR/wz5iryAtp7uIX0hyL0rWBcwGOEa270n7vV/ycxYKyRuxufsQtpzF7Pr22l3mlCa2zdTQmRblPFnACB1kXOnJJMqX3lSAEyjl8ZaYt7+3KNQe2O/Ev7VX1kK5FS0QgDmf2jZsdWm8PZj8iL4BlYpBfKGzPlm1Yj+Q1j6En4+vKpqY5q3K3abEWF70km7s5y5kRB+6ZpxNuZlaiWXYzpH3fDfQQdd+AjWj9DhMSqa3Zix4x8pEMxaiG8CK2qQLIzigfoOqvJlwHayOLnMKEQzwv6rfmCcWWXIsgtU8WBnvw+RyIwpUus5uYvFlc4GKXYkckEfmzWQOlUHXNRMTnT4ivk5+cDJeWk1XmZX9OED74dcxWe76uB8/EGedO96nqNRWY/Jur9isJzDUPvFymIQRFKUD74E5arZbivgi7XoXxJN2JhLkT8d2xpYAKTJO5UgcLveVOjMCCWZNshu6FfChyQkZift3sUT0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bb082e-5aa8-4f09-c203-08deffc06059
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 20:11:25.0183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNG7looB5AWhoHOqzv6xaZJZsZL/aPqv1dpKX8XPaVcl23V0XJZa1+DZKST44/zrMzye4ZBxZMBXaSGItFmxWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608210161
X-Authority-Analysis: v=2.4 cv=VNvtWdPX c=1 sm=1 tr=0 ts=6a88b0f0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8
 a=vu_B3Ewg_dN7IpeVXVEA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12102
X-Proofpoint-ORIG-GUID: lf59ld5ch0hoHQMzhlT7XCSaX1SZ7oaR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE2MCBTYWx0ZWRfXx214HbAGa9ae
 5liPBQxJyxNn/blcbcvVKVABNKyJHTeVi1lrBm+WGRxooT1dHNa3A6zxGTcYGJpoNXzmMcolvws
 rg+hELoTx0BMwXhKcgkJTF6P3eD1TcSLnL1UnjaBjjtM8PYMfRpwwD4s9CQVqyFBEUUsWBV2keA
 ZvNtMP+2yIFLfpjohrQg+LprBLLxDUvEyXYetL0A28Oqo/KKavRyxYl2qiL0i0sARW6kUwzcjiZ
 MSVtnjvIn9DtaNL+nt+3v9Uh5p+tiRyhl0kLLr1+N5WrhmE9XYHwwMLPRwL7E4Vv1F3YCP1SN7z
 uSCUAs1Wlqdl3x4a3CYKOa7oHeqoGpjMmEeQZJlEWCqzTrLFkrl42+ot5t97pDP5LDTE89Qt1Da
 A0FkZwVbvFmj7Rbx8x8xmCvyB2FMakI6dE09qu3grWHkMhERlyd8IKfx9yg0vrwY8JZ5HwMRUP6
 ojabNkGWfVYfO7aLOjf3uddiJgp0rtKbFSoLu/UE=
X-Proofpoint-GUID: lf59ld5ch0hoHQMzhlT7XCSaX1SZ7oaR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE2MCBTYWx0ZWRfXx7SYBlncms1H
 zUixXXO984PRXEq87TFtuKToHGIjVPsP4GGeqQlUeqIX2NqPet+gQAouMmMK5pnDN7ukDy9VXtY
 ambq5qXRV+uSvc1ec0wKWYTUhh3ajnw35Cm3CK3qPt8tPF0Zw7tP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On Fri, Aug 21, 2026 12:13:30AM -0700, Markus Armbruster wrote:
> Dongli Zhang <dongli.zhang@oracle.com> writes:
> 
>> On Thu, Aug 20, 2026 12:09:19AM -0700, Markus Armbruster wrote:
>>> Dongli Zhang <dongli.zhang@oracle.com> writes:
>>> 
>>>> Add a memfd migration transport to the MigrationAddress QAPI schema. The
>>>> new transport has no user-supplied arguments because QEMU creates and
>>>> passes the backing memfd internally.
>>>>
>>>> The initial user is cpr-exec, where the main VM/device migration stream can
>>>> be stored in an inherited memfd instead of an external file.
>>>>
>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>> ---
>>>>  qapi/migration.json | 32 +++++++++++++++++++++++++++-----
>>>>  1 file changed, 27 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index b1eaf7b054..1505c201ca 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -702,9 +702,11 @@
>>>>  # @cpr-exec: The migrate command stops the VM, saves state to the
>>>>  #     migration channel, directly exec's a new version of QEMU on the
>>>>  #     same host, replacing the original process while retaining its
>>>> -#     PID, and loads state from the channel.  Guest RAM is preserved
>>>> -#     in place.  Devices and their pinned pages are also preserved for
>>>> -#     VFIO and IOMMUFD.
>>>> +#     PID, and loads state from the channel.  With the @memfd
>>>> +#     migration transport, QEMU saves VM/device state to an internal
>>>> +#     memfd instead of an external main migration channel.  Guest RAM
>>>> +#     is preserved in place.  Devices and their pinned pages are also
>>>> +#     preserved for VFIO and IOMMUFD.
>>>>  #
>>>>  #     Old QEMU starts new QEMU by exec'ing the command specified by
>>>>  #     the @cpr-exec-command parameter.  The command may be a direct
>>>> @@ -716,6 +718,13 @@
>>>>  #     as a file, that accepts all data before old QEMU exits.
>>>>  #     Otherwise, old QEMU may quietly block writing to the channel.
>>>>  #
>>>> +#     Alternatively, use the @memfd migration transport to save
>>>> +#     VM/device state to an internal memfd inherited by new QEMU.
>>>> +#
>>> 
>>> Any guidance on when to use @memfd?
>>
>> My objective is to avoid using disks, or running QEMU with writable storage.
>>
>> Both guest I/O and networking can go through VFIO, and everything remains in memory.
>>
>> When I was testing these CPR features, my favorite was cpr-exec because it does
>> not require creating an additional QEMU instance.
>>
>> Based on my understanding, the best approach to live update a running binary is
>> to replace only the code section while keeping everything else in memory, i.e.
>> guest memory, device fds, and device state.
>>
>> Unfortunately, device state cannot simply remain in memory across exec(), so we
>> need to migrate it from the old instance to the new instance. I was thinking:
>> why not use memory instead of storage?
>>
>> Initially, I added the change only for cpr-exec. Later, I reworked the change to
>> make memfd a new migration transport. As a side benefit for me, I also practiced
>> how to add a new transport to the QEMU migration code :)
> 
> This is why you wrote the feature.  Please work it into the commit
> message.

Sure.

> 
> We should also help users decide whether to use the feature.  I gather
> it's useful with migration mode cpr-exec.  Any other use cases?  Does it
> even work with other migration modes?  If yes, which ones, and what
> happens when you try with another one?

So far I only added support for cpr-exec. I have not tried othe modes.

In my opinion, cpr-transfer could also use a memfd-backed channel, but I am not
sure it is necessary.

For cpr-transfer, the source and destination are separate QEMU processes. If we
want to pass a memfd between them, we still need an IPC mechanism that can
transfer file descriptors, such as a Unix domain socket with SCM_RIGHTS. That
reduces the value of using memfd as the migration channel, because we need at
least one Unix domain socket anyway to pass the memfd fd and coordinate the handoff.

If a Unix domain socket is already required, the main benefit of memfd would
likely be performance, especially when the device state is large.

cpr-exec is different. The new QEMU is started via exec(), so the memfd fd can
be preserved across exec by clearing CLOEXEC and passing the fd number through
an environment variable. This allows us to add a memfd-backed migration channel
without needing an external file or socket for the device state.

One potential future use case is LUO/KHO support for QEMU. In that case, device
state could be preserved in memory as a memfd and potentially survive across a
KHO kexec. We won't need to preserve anything on storage. Indeed, I did some
internal tests using memfd to preserve device state across kexec although using
different implementation, and it worked.

For other live migration modes, or even local migration, I do not think this is
useful. For example, saving to and loading from a file won't use memfd, as the
QEMU processes are terminated during the this process.

Thank you very much!

Dongli Zhang

> 
>>>> +#     With @memfd, the new QEMU command may include '-incoming memfd:'
>>>> +#     to load the migration stream automatically, or '-incoming defer'
>>>> +#     to load it later with `migrate-incoming`.
>>>> +#
>>> 
>>> Isn't that the same for any transport?  I.e. old and new QEMU must use a
>>> common transport, and you configure it for the new one with -incoming
>>> right away, or later with migrate-incoming.
>>
>> Yes, it is the same for all transports. I added the explanation only because the
>> memfd transport does not need additional data or a filename, for example, the
>> URI is just "memfd:".
>>
>> Will remove it.
>>
>>> 
>>>>  #     Memory-backend objects must have the share=on attribute, but
>>>>  #     memory-backend-epc is not supported.  The VM must be started
>>>>  #     with the '-machine aux-ram-share=on' option.
> 
> [...]
> 


