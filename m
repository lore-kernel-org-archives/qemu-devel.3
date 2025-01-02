Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C9CE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSpJ-0004pu-Ka; Thu, 02 Jan 2025 16:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTSpC-0004ot-1s; Thu, 02 Jan 2025 16:33:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTSp9-0002sk-IB; Thu, 02 Jan 2025 16:33:49 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Kfqkf011684;
 Thu, 2 Jan 2025 21:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=wzP1DrWTOX1PLUuY0K68J0jOSTDCNgc8yhpqytAsTB8=; b=
 iqdLKuj82L2K3aK52+dIps4d/JT+vojKR5ihWmYRrmCewB0KVnWQxJlM1jQy9R9w
 dt74R10OYISUWmX+2LJR7tqRJU6xl9PcHHcdTZd35qDW908vEFRQGV1dA+6VF3c9
 eUEf2pWGuiqwJwvku2ePew5KDOi5ilIE2/Z7OGR36C0ddV/Kf1dwmg5pWryEv4Vb
 69YKiwcXndp2eu3jGF86XoizDLoqqjFW9LZ+ycL7WCY5r4acC33q0oBp7dez9YBh
 pOgOX0cexjViCY3W0wl8xrMfS7SwPIEEqAEm0GVUEcuQE396vFsqBV6WsekMPoF8
 sX+d1WgSU+EqnOjVSsuHeg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t841y9v3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 21:33:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 502KKPJl012303; Thu, 2 Jan 2025 21:33:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43t7s929c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 21:33:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDlaTjr+gD5aHhpJ3Erl6Jvqm6YefQA367KP+7k8nZwLwOzNpREMA2onadlbfOw+hkN2gMigH6NLmBHOqAggQVHQU3ulQGU2Y9+/uSnpdu5C+rDBvCg3ISs9QY3KZwx+pjhnp67aKyDA/iECfIYFIr/f5EmE4hUsrnRTlR43CjhaALG4U6rg4FkyS6FVWp1s1Xf1PgwVmZ3TE8NO3TG54DkrNPc2vk/S23VuF4djIAptb+G+xkk/9Vn3Gn00MFkLSeJtPH37viWscdQlgSZp3SXtQMg/ruV2TLNcvAuMOBhtEINhpDsrSgUNMcSrc6ntAZNjUix9ewxm4L71mBUe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzP1DrWTOX1PLUuY0K68J0jOSTDCNgc8yhpqytAsTB8=;
 b=dCliZICMdCrZ5a3xVW6o5EbkcMDFgqoePDKdddoMkHQJ0C/E1kRd7NDq8y8McZcb6SCMM5vLbcMRuIXukmajSJo90wUjPPQDLT5Qx7w8MMD48Wf4gsSX+4TtqV4rjPniI/RPVojRFR/jegeCdg/QqRIwZ8pCytCda9NmvviGnxn1xfUPsXCH/GtJi+0B1y7MFcUb78KTJbka66SzZ7m0OTCOJPcQqAgF0qABRFwU4Gf9zGj3FuiUHpfp1G3TGGNd0Hz5v6KRaQgVXy5gWd+w1sRnnVQ7seXIQXhmiPwIKybGOzDcH38++9tLZvxxsWY9GdmbxA3t3yff2+bRvNmw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzP1DrWTOX1PLUuY0K68J0jOSTDCNgc8yhpqytAsTB8=;
 b=sbsIvEoCGvbz60DXwxDlPlIBJliHu5pj61c+UpvjRul2SHdhEp9qpgL/AWkzK4KKMWXmQl5+FyFpvwOIPcKJkvA+0j+UNcB5Kv8iIcRDBmuySThKeV5vwcr0fFf70fRqSlyw5bFmwb2WHI+dPhPufenwHJBYKEG4aLF1/jzPC94=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8089.namprd10.prod.outlook.com (2603:10b6:208:504::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 2 Jan
 2025 21:33:37 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 21:33:37 +0000
Message-ID: <10f05b81-49e8-4fa2-a331-fa135380e92c@oracle.com>
Date: Thu, 2 Jan 2025 16:33:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] physmem: fix qemu_ram_alloc_from_fd size calculation
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1735850090-329906-1-git-send-email-steven.sistare@oracle.com>
 <Z3cB0TehNey27uNZ@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z3cB0TehNey27uNZ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:408:e1::25) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1b29cf-10de-4e10-a0e4-08dd2b751de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkNWRE1Xck9vcVdzQ3JEcHRTL1Y5aXJMMjR3eWRRbkNBTnBRNHB4aElIUjRq?=
 =?utf-8?B?MEt6OEdrT1djMWt6ZzF1ckV3ZXFiR3NSVWI2ZmtKUUNQY0RIZGdkeXBIM0pO?=
 =?utf-8?B?Mi92Y2VERFJabFBsRzdDZUUzYUxZQndnOE5PUDJjRUtsbERxUnJrWmdCKzZK?=
 =?utf-8?B?RXMxZkZ3b3lUbFpBVjlMS0hxTzg1L2pvY3ZUWWkwSzdDNlcvb2RiZEJ4WndN?=
 =?utf-8?B?anBOcll6dWdPVkkxZTg1MC9BVnhHSXMxOGc5amI4NGUvZWIvSFhqQjE2azhN?=
 =?utf-8?B?NC9rWXNhK0J2KzBMS0NhUU14a3Uyb09IY1FQZUhXQVY4MHVua1NJQjZ0NlFn?=
 =?utf-8?B?b0ppU01MNXJIQWxScXFrK1VzeERma2t6dzhMMG90Z1lwYkQ2SThLSnVqaWMr?=
 =?utf-8?B?WkxZOWp4UVlSMVZFMFZGdFNuWVZyb1NLNXZtOVEzSXJZdE5LL2dFUXZJNEU5?=
 =?utf-8?B?aDF1Tk9OaVVWc0FKYkc1VnRkQVF3Wk0wVnVnZHdaVkJNQi9mVUFGSXkwdm1t?=
 =?utf-8?B?U1hFaHNEenVlSmVqQkorVnlnWHNZRmx1YWdma2hlcWNXWXFIUkE3QTVXWnRh?=
 =?utf-8?B?clZtcGZnRGJCSXM2Z0J5YjluVk9XOGxpbDV3QXNkdDRqc09nbEFlT25FRE5O?=
 =?utf-8?B?QTBrcUJqVGZUcTBtdkZzUUpDNnBpSFV1Vk9PNnNGcWlkelVvTVM0TlJELzZQ?=
 =?utf-8?B?WGEzdWJVSEd6dlFZdFFZeGxkSlc5a2YzbEk2aG1LRm84Nkoxc2VQY29kcEpP?=
 =?utf-8?B?MlJuMk1BT2h2eGlENEYzTWlvV3ZxNlNzWXZjWlJQcy9mMTdnSW5LZHZ4Y1VB?=
 =?utf-8?B?UXdoV1J6dFFIQ2R4elExd0crYlVSMW95T08yY1JSQmJwRkk0UHEvTk1mSEow?=
 =?utf-8?B?a2YzWUxqTTlLTkdDQ21Ia2lQMWoxNWpnM1pwL1phQmRNbFowQWhBWExvbnY1?=
 =?utf-8?B?SFRBR3VKWGtwemRXRDEydXdOUGVFQk1xYTBCVngrMmFiRnJlRWhncVVJMnhX?=
 =?utf-8?B?c1N0VTg4YTZBbmZwZXBQVmVPM3prVTRnWGVRMWN1OTJlSThwVHBCelkxL1N1?=
 =?utf-8?B?QVZIamhDUVBXUTFjN2NkQkRKUThSY3lkZllqd0ZJcHhsdWpreTUreGFrZG9a?=
 =?utf-8?B?VXZ1YzdGRklYSWRwSWdGMWZMS1F5TG41d3ljZ3BPVnFIeUg2M2EvUG0rWTc0?=
 =?utf-8?B?OFdEeS9tT0h3emIwYytSWjY4NE5wc2hmcllTOWlhU2VoSnl2SjVJZkFDWExx?=
 =?utf-8?B?b0l5NHVBTXVuUHJjakQvaC9PVGFpR2hrZnlvenJlckNURm5jbWl4dGRnbkcw?=
 =?utf-8?B?OFhsU3RwRlhUZll4VXc5Nkx3bGUzMEFCR3JoYmdsMUNWcTVYUElJUEVtUWRq?=
 =?utf-8?B?elpNN3lmUmVUaVZwOGpaQ3Frb0F6c3Ivb2pWMjRoeVUxNHdEd2hVNEhOY1U2?=
 =?utf-8?B?ME1QZENMbGViZXYvV0lPNXVtSzdtR2lucGl0OXkzSm5pUEt4MWgvK2Q3MktW?=
 =?utf-8?B?MThrSDhjRTZBQ3pSaCtBb3RtRS9tWTNLMFhvdkFIZmtjYysxdFVSK1VxVXhr?=
 =?utf-8?B?cGp0cGxpcXp1YTNWbTYrWU5ydGN6ejRVQkM2YlhKUm1FY0xGb3NzMlFtZWVY?=
 =?utf-8?B?cnp2SjVCSHFVU1FoMVVsdGsreEwycjgvNHlZNDIzU1VGaEFQNlROdWNyOUdI?=
 =?utf-8?B?RFpxV2VDSy94ejNCOGdMZ09MdjhwZE9UekZhUjlRc2JrcDduZHNTMmx5cENI?=
 =?utf-8?B?UmF0bHBSSGEzMFNUZVNuSVVFMk91aHYzUUhiY240d3I0d2I5dHVzMDJjTkhO?=
 =?utf-8?B?UWhNYTR6aSsxSGYxVUNmNVBCTTZTMEE0RS9QQXBhQ250U25YZXNxaVg5RDhI?=
 =?utf-8?Q?aGG6vE3o9/bUR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWlqWnBsTE84VUxmT3ArRGpNSzFPZ1ZnbjVkdS9tWkFOeUpJeUZXZXlvelZ6?=
 =?utf-8?B?cVFKZXA2eVE0RGVkK1p6Qk9TZG5Bam1VdUVYZmdIRXBpWURZb3dsdHRPb1hh?=
 =?utf-8?B?cU5DMHAxYXhCV0ZrWS9sZlFnWVNNYTBwV0IxbUdZQWcwQnZydXJDSnZoekNE?=
 =?utf-8?B?eDJTS2thd1l0UlU0M1B1SWNTMTZYTnVkTHNMb04rbVUrS2ExRDVXSFdTUUZR?=
 =?utf-8?B?b2cyVDl3ZDhCRWdWNjUyclNrRGgzQnNUTjFnSFliYjVoc243M2tKemVoNnV1?=
 =?utf-8?B?U1FnYkRsbS8rZlUvYXpPM1ZnL2FIZzMvTGJJNXAzc1dSR1dndnBRbHNCYlZn?=
 =?utf-8?B?YS94RXpQaEJvNEprR3gwWEtxazVHbFF6OHJVaFRPYkJnenFqVFo1MUtMbHdr?=
 =?utf-8?B?aUtHNjErWXc2aUZwRFdwMWlBRGNiZGJTTy9qSHl0L0JZZWwwRm5hYkp2VytD?=
 =?utf-8?B?cUlqWEZ5Qm81ZnRCcWFZcTRsSVI4V1FCZFlDTHE5YU9Pd21FTWhvU1BLTktr?=
 =?utf-8?B?VEd3U1JCVkxpWll1dWRLVm4zeWtablF4UUhxRld5ckM3cXgvb3F4MmF5bGlK?=
 =?utf-8?B?cVNuYUxLUHlXTHhHVHNSVy9yVmN0aDd2VnJ5eHk5R212TkhhM2M2UThoRUxK?=
 =?utf-8?B?STJ6UUZJeU4rMVVUTDRZYTBrYzFCNGloWEc5aUhmaUVQWExHOEZFK2NncHFY?=
 =?utf-8?B?aVRhL0tHUjlTZXZGWGNWZjdXOUhWZWI2b1hkU0hhTjdpUmMreWpPWlRFOFhM?=
 =?utf-8?B?TG5oTldIZVZ5L1Q2TzVRQmxDTlNHV1h0RzQyVVNibUZaVHdsM2NnbzJWZDZY?=
 =?utf-8?B?NVMrazUzZjRKV1hSVVpjQWIyZjRXQ1AvaXo3QWowNDUza0hyZE96Njk3Tk9y?=
 =?utf-8?B?TnRkcXk4bmhiOGxNdk9FUlBoSS82d3RaZlE4K1pXWlJsY0xacTU2dy9TN3Ez?=
 =?utf-8?B?WTJDeCtKaGlCTHh1YU5DaEl1eGxjb0tYT0xhYjh2ZVhmYnZDWHhKdkhKSlhM?=
 =?utf-8?B?bkFEOTN0dHJoR3k3RGRuMnZIWW02Y1VjdGVGTHZCa0ljdHkwZW14RHhIMi9K?=
 =?utf-8?B?ZEFrNWllSXh5ay91WjZUUXpZTCtGaGtWT09zcW8ySGJSdEg2c1lHVUdiNmQ2?=
 =?utf-8?B?WFJsN2c5Q2c4eDkyY3RtSVFBMmMwMndNTzdRVFU4OE50cDRVTElTcnE2WmZD?=
 =?utf-8?B?T0tYZXltRVlNa1l2S2dHeHg0R0MxWjg0U0Ixa0JQZ0h5SHE3VERGVEFLelRF?=
 =?utf-8?B?NjNYa25rOUJyMit4OXNCbktiMUZ2SHB0bDBCWTc1MkR1ZFJFTXo1RmNvTWcr?=
 =?utf-8?B?VHA2bU56UXBtVzV3T1BNU0YvMDlNOWRUdUtYbnZqdzVQNUNJMTBKSkxHY1Nu?=
 =?utf-8?B?dzBNQTM2bFZZbU5xZFlLdU9oOGNLNk5ndFNHRG9HNEF2bXcwV3BTN0Vidno2?=
 =?utf-8?B?ekpnSkhOMy9vUllTMDUrQkVMNmVSU1FXa1V2TGhRMDJJNnY0NFRkL3VvRnhO?=
 =?utf-8?B?N1ZTSnc2SDJnbTlYcUdPWUdjTmVTdHlxQm1PMk95aTVoTTBGbThiUjQ0RGs0?=
 =?utf-8?B?cjRHUDhWUTNBRzlMRmU2ZldjaFF0NUthN2pHOHk1Y1J4TlhCSDJ1YTNFcWcv?=
 =?utf-8?B?OFE2UU1LT09McmMwSVJDdWhZNm94THZVOTV1OEVyaEFqdmNCZGZkOVVaVitO?=
 =?utf-8?B?aEFhNC81QkNKaU1sV25VdVArcEtLbE9CR3NUcFpGYS96QW10UzYwOVNzUVpw?=
 =?utf-8?B?Rmx3dUgvM2FiREVhUUorVUxURStScmdGb2hWL0xyMmwrNy9EUk5Wbmo5dGNh?=
 =?utf-8?B?UW5mRFU2WXRtSzhiK0VsbDBqb3Rmd1dxdjVMaDBubDF5TWM2TVBMbk0zN0JH?=
 =?utf-8?B?Mm5YUTBZRVFRMVl6UkR1d3J5T2VOMGtOTU1YRG5ldGlvWU5oWHlxN003bzh3?=
 =?utf-8?B?U0NpOXl2cWE4TlFTWjBlREdvS0lhVjJBSlRIZUFaR0tGVDRFM0VZS2lhanVE?=
 =?utf-8?B?eFB0YkppTWs4cndRRVhjZ2gzR3JXZDg4bEp3enJ5Qlc3UEltVlJkYjZQOTRh?=
 =?utf-8?B?MFNDYi9qQUlXbSttUmwyU0hseVdEdWFEWHBPSlZiK2tHZ0hCOWZZNy8zUjBx?=
 =?utf-8?B?M2prV3F1SmVCT1gvbVFrWUJ2YVdMSHBKcXcrR3ZCU1VpeDJUT1RSa1RzVW1J?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z2vrqGqb9Lc5kHuEdSp0BR0Iqub+APvf6M7pFY4fgL49+p8ZlHjxnhQbd7kaQ9NIMig19nK9+W0sqBZgvI2I/V1B7r0hthS2AXYZo/8mv1G+I5y2fQieTAfFqfbxCrrHlabQ0VE1+P4QQL4oyvKGSANDiYzu3BjY7eegkzdETvy3bVZmZPWS3Istgrdp6QfT45psPoP5adP+N7HQ2d947bN0JF4n+ye6y5W8IBV6/AZ5Gv9WPKlNsM1EFTA9vfM8gYvUOSUnkjsrqc38Si3nFkD6f07awGQtJORHXrP4NIqcJcWprpNVFl7zl2221rYXFHiTMxWp0PMXcFgJIb03nPMELYCpQyel/nDNr+7j2I50OpBe1lccWloN9TjH3mrojixK62ONYwNiv0MkiT0ahVRKkA21uJjDp2BzkUy9q1oHK35ATicUlYe7CBL+STvdhDjjiHZuH5TWFWWNkV11M0emtzASKjB4OMPPhc8tP3WCdCyQtGfbfP9RCaaUP9sC5zjKoFDuGV3J74dNbWlegZNJ9pPlHEWwMfEMY+RalMG8/rnYaMGW7wkvXtG0M2HgaZ0s3uJRo7SfpsPj/deaNUcl6aGONtc054RhRWZro4U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1b29cf-10de-4e10-a0e4-08dd2b751de6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 21:33:37.0351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7okPyvXTWRGKaCzes4fwktSFmR8w58R++BreaG70vZcMzeYKPm2GPAArTPWgSZN7AHuuBTMAIssRkwJ32beoDUvi13W9JNMa6353Yj+9MQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020188
X-Proofpoint-ORIG-GUID: OlSt7C4SVDEd2YDTJswnoMbd-DL2SUM8
X-Proofpoint-GUID: OlSt7C4SVDEd2YDTJswnoMbd-DL2SUM8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 1/2/2025 4:14 PM, Peter Xu wrote:
> On Thu, Jan 02, 2025 at 12:34:50PM -0800, Steve Sistare wrote:
>> qemu_ram_alloc_from_fd allocates space if file_size == 0.  If non-zero,
>> it uses the existing space and verifies it is large enough, but the
>> verification was broken when the offset parameter was introduced.  As
>> a result, a file smaller than offset passes the verification and causes
>> errors later.  Fix that, and update the error message to include offset.
>>
>> Peter provides this concise reproducer:
>>
>>    $ touch ramfile
>>    $ truncate -s 64M ramfile
>>    $ ./qemu-system-x86_64 -object memory-backend-file,mem-path=./ramfile,offset=128M,size=128M,id=mem1,prealloc=on
>>    qemu-system-x86_64: qemu_prealloc_mem: preallocating memory failed: Bad address
>>
>> With the fix, the error message is:
>>    qemu-system-x86_64: mem1 backing store size 0x4000000 is too small for 'size' option 0x8000000 plus 'offset' option 0x8000000
>>
> 
> Can have the cc tag here too to be super clear:
> 
> Cc: qemu-stable@nongnu.org

Done and resubmitted.

>> Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Please also feel free to attach this patch as the 1st patch when repost
> cpr-transfer, it could make dependency easier no matter how this would
> land.

Will do - steve

> Maybe it'll be still easier to go via a migration pull that collects cpr
> transfer as a whole. May depend on whether there'll be a memory API pull
> before that..


