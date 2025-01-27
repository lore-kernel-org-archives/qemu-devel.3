Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BB6C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 16:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcS5v-0006g3-SZ; Mon, 27 Jan 2025 11:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tcS5t-0006ei-Lo
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:36:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tcS5q-0005Vx-Bi
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:36:13 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RG8hIN016073;
 Mon, 27 Jan 2025 16:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=K8+QR/LZD0K9r8CUrUsdnWpN8gKaGtisAaFxZRpD9mo=; b=
 IYGvWOuaF7tAeyIfBdMU+xhqeSKy40PxFdiKUf7QiAMNZXRkWClvZp+3a/XreA/0
 W4gvqUTAAiW6AIlf3tkP91kAoyo6N8vH2mblkuDgfWBMHIQsQKaDIeZfmvBdxH8L
 uOOhVvhXtZKB1ddjelVkEpR5N5hveOFN9VcG1erGA7cz//jSK0pPYhovs+3s3ANS
 zgl35eLU/JLF9Ym298Q4ucDz1d010pDDf3EMfSXRalby9NNP2K8xUX5LGKoPrbRX
 QFINLPKkmjzsI2x6/GkdzRUC5Ej5gddzZIvB4nt4qHkRfUzMAZZBydj79GuSxvGr
 f9cMItIWYrA1/2bDX3ZxMg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44e900rp6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 16:36:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50RGLF00036392; Mon, 27 Jan 2025 16:36:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd75xvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 16:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TixlKjmkBGp4BtLnUS8ML62QClEyYz9X9mHTXoBJxbrIGx1lAYGDhcJtGndVho9K2qXqWPr/wroWp551THHPNqzzWRUDdNiv+TPkrU30r4OnCWb7ARqjf2jZ6zJeH3ogNsOl3HjcnJ0fzPoUuX40ChvuEVhGJlMdfEEaHewnsjujYZnQaPijDRyszLPdl3UpU1Ma7Y1WDuWUeqEHeuzl/AIfh2+MUx2rZBA72tbSyAE6EDSM/Qsaip7meNAAIRoaHHw4hcGZD0iKaSTKFDvHUfP3tbLoE2vLX0IyO87BfoAs2NYE56jw1AyrRVxEolVbgYt7o7u8uXyLmP2cx6xiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8+QR/LZD0K9r8CUrUsdnWpN8gKaGtisAaFxZRpD9mo=;
 b=RAPlmB93rZTWKL/LGxD9PYLIfoD9Gr7tOt8ppKgZtsqmrzcrljv9o5qzZ8Ld5xSmFjaVHziaFa0H6ZYVLzdfcjWR+tsJC10IArZvtPdi53TqN3TVV6geoV0g01v8PDWS+eCJ2rOFjEV//QA8HdLKHsY/MMELrBnGfTNkRG1zm5ex43xYjuQAmQmDOgOec/uiNM02EPqtuEQH0WVCaXarnmeUlgrP21iFjTYCNIbFsU1yw8ES4VlEgQy6RPOrLVyq8yDbappCQ+3jm5xWyssKfRMd8ELRQgvVsXK7lKAI+BlUKKa8LnXY0rO0X6AsyB04gMSNRIuKYd8R5UaphYG5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8+QR/LZD0K9r8CUrUsdnWpN8gKaGtisAaFxZRpD9mo=;
 b=A9pyT6Rta3NJBAYTSfo69G5G+R5FmeN0Um0cWM9Yk2O39AEupCZAAetikg5tiMQZ8jGQoAAq0/ryD/TeV0knCt3xT6ZO+AFm8iMmeyOV8cTJboYLkbpztTmDcOiRmwieX5mK5LCyPXM762MIrxnUjBxkSDxtLrV4Ox8+KXWPlfI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6336.namprd10.prod.outlook.com (2603:10b6:510:1b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Mon, 27 Jan
 2025 16:35:55 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 16:35:55 +0000
Message-ID: <3c5ef58e-8f2d-401f-9cbf-42598ab6287d@oracle.com>
Date: Mon, 27 Jan 2025 11:35:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 15/23] migration: cpr-transfer mode
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
 <87ed1eakxr.fsf@pond.sub.org>
 <2ae6c272-837c-4d88-bcfa-fc7719cc447d@oracle.com>
 <87bjw5tv08.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87bjw5tv08.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb0f985-ec1d-4ce6-1dd9-08dd3ef0abac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXA1K21NT0tJTXBHQVJ6VEROV2FXanZweWxNTWR6VVhvWGduR0JVcXVrR2hq?=
 =?utf-8?B?NjdLTVYzQlZ6ZFN6azBSendjZU5HRjIva2VScXNYb0tQV20yM3RzYnRJaDJO?=
 =?utf-8?B?Mit5YXJaQVlHdlY5NGhQT2VaK243WDFpZmwxUytYZUk2aCtZYjc1K29ySGwy?=
 =?utf-8?B?YlZleHIzOExxV3hOMkpLYXY4bCs3V0J0a0FnajRNMUdtMXFFZGhHRmNwbXVy?=
 =?utf-8?B?ZCtUZEk4bm9yeWFxSS9YKzArT3A0bHJKL1FQWVNCM3ViOGdmdnZJSkttc1BP?=
 =?utf-8?B?K3JabHFCNEdNaU9DOVcwMy9mU2Y2NWFXOUFZdW1qQTl4OFJKQUd0QjRoZmtm?=
 =?utf-8?B?bFcwSVhFYXdOMFR6UVRGWmVXcjFqczloMXdjazlEY1VOOHNzZlE4SGRhRE1V?=
 =?utf-8?B?Y25sRStOaUxYNXRPcERlRTM0a1ZGZGZPTTZjRVEwa3FsMlhDS3U5Q0Nmd09V?=
 =?utf-8?B?Qk5vc2ZSZkt0VUczNkVIKzNaVG9NeWhmSlBacmJzbDlISlZFcW5PSGdFczYr?=
 =?utf-8?B?NkVqNldHRXAvaTR0UVJpWGZidEhOczJ3SlJkVGRrWnhucTE1L3dmTUNObzRz?=
 =?utf-8?B?MXlQZ0lxckZMdU9MVmtidEF1TTJlYXdFMDh0Nk5iZXMxOXBTc01jSGQyN2dj?=
 =?utf-8?B?N0pDVmxqMzBBaDUxMlVNQllTclRFWEc1L0Z5ZHNvZmE1MFRNb09ZUU1YM0E1?=
 =?utf-8?B?STBUcE4wbXFIUHdidDJSc3NuenhlRDNGRXMwSjB0blZxNmtzT2JDQm93dVVz?=
 =?utf-8?B?OTVHZmh3NWdVNnlzTCtlMFU0NnU1ZEM5QUdleWcycjVNWVc3TG1pL3Q4bUV3?=
 =?utf-8?B?emhBUmhGVWp4dktGS0RkZG5RS1JjekFmWnRVOUJneDBXUHVHZWlCbzdSSzNB?=
 =?utf-8?B?a0g2eURJQ2NEb3pIa2MzaXVNME5ld1R1cHI4V3ZUZWR5R3p5QnlXVFB5QTBv?=
 =?utf-8?B?VWUyUmF5VGxZZiswTmpKaGZKQzFDQlFzRWpmaTVSSjR5S2F5c3l1QzdselFB?=
 =?utf-8?B?T1VNZVhpUXFkSWtEM3MrcDh2Y2ZaUDZvTU15R3o3WXFUN0tGYzhEaGNpeVFC?=
 =?utf-8?B?alNycGZ4RWFCNG9OSlNRNjliY2hacUt3RXJPbCtJOGgzSDIyU2lXMm95Yk1Z?=
 =?utf-8?B?cDNmbE8rNXdlQ1NOcElEakhaMVBvd0dwenNvTGtYdkRYOGZkcnpRY3JMTEFW?=
 =?utf-8?B?eXBpeVp3dk9tcHgwdVBKd28vUDROampJL1JOSWhveFJmWEN6UGNhSTFmOEpW?=
 =?utf-8?B?dkwvWW5SemhFU3I4dE8zeFUrNW9zTXdBeTFudjF1WHVxKzc1R2JrTGh5WE9O?=
 =?utf-8?B?YTJUMHFmNWtiMnhRREhpVDBMRlc1aTNKVEJHSi9XNzBLNk5aWTRvNjJkYkJP?=
 =?utf-8?B?OUFtRGlPZjZtNWcwVldmMTUyRTY5V2dKQkJ6OHpvU21FWC9aUUxnL0lwejZl?=
 =?utf-8?B?TmdNaWRPV3ZNZ2xWRUpEd2JYbyswOTRWK3hma3lEWW9MNkxxQldEdUVCTnF1?=
 =?utf-8?B?bi9NVHdkL0Rqa1Z4Zisxbks2aEd6MFQ2MTVWRURGc1dZTE1qdzRoYTZCZ3lQ?=
 =?utf-8?B?cmR6aVpCQ2h5cG9CcDByTk1xU1ArdGVJUTVxdS9wUnZ0RTFzMWtJTW0zb01N?=
 =?utf-8?B?NGpJUEZLV0dlQ3BwOWt4aEQzQjdkQm1razJsK0MvaXMwclpONWE0eDQ2YmFD?=
 =?utf-8?B?cTdST1pLTHVGZXpkUitJWVgrOTFuQlZ4dW5QU0pyWFRiMGViblNQaWljOUFC?=
 =?utf-8?B?NktyWXgwcDhhZTVyQlpheXc3VSsvcDlwNEd4NTB5T1FEM3hYWXFUZzE0UU54?=
 =?utf-8?B?KzdzNHB5NzV3RWtackFhck5JeERjZUJQbUlkOVVjenJaV2REVEliWUFob0xu?=
 =?utf-8?Q?cxsMrdRv3KOon?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEgzdktUSmVtUUpiUnRVdkJhRTNOdXNFUDg0MnM0Zi95QkcyS0pWVCtnV2t1?=
 =?utf-8?B?eCswRVBkNWlaSVY3YTdjWExTUVV6cnNBVk1EQXRvVVpoVTJYSUo1RHAydm42?=
 =?utf-8?B?ODhDY28xR21wd3ZVTkxuemExcnNleVVxV3NLYVltMjI0TFBldmcvWHRxclk0?=
 =?utf-8?B?UUNnc0JHNFF3UTV2MmZtOG5QYlc0OWh3dDhmbVpqQ0p5cTlXVzN3UGc4VGZM?=
 =?utf-8?B?U0NOWDcxUVV3SDBHRFk3ZmE3Y0NkbytBY2IyS1FJckd6c1Rya3E2UjgzSVA3?=
 =?utf-8?B?S0kvdzU1SmllWmNMVlpFNUxSSW5OQThhc0JwdUJMeWphTEtxaDlMcGVob0dq?=
 =?utf-8?B?b3NvREJJNGxIL0tCQjJSV0tVcWI0dHNPMWdWR3BuOVV5K2NiMENTRVN0aStY?=
 =?utf-8?B?V1ViR3dmUG8vM1RSMURiUE8rZHVEMEIyUmZuQnlFcG9BczhuL0pvNitocU5E?=
 =?utf-8?B?ZVVzNmswWEdzbEwrcWtMY0pjS2RBaksxQmx0Ti9xQkppRVNXVXZDaU5lZUhF?=
 =?utf-8?B?K1lWZC9IZzY1SE9oSjRQUStSMDBMK3NXWWxYV2o4blpBN25YbU9SbC9WRDIr?=
 =?utf-8?B?OGV4NXVLV3A0NDdxd2VydUVQdWdLMUhjczRkTXpLNkI0bnhGbkJabFpTZ1RU?=
 =?utf-8?B?c0VaNU5Fam5LNUdBcDRHTjBGaWxodUFaS2lpWDV3ZnptV3NCTWU0NnJPNmhF?=
 =?utf-8?B?OS9OUWkycWNIb0ZlYVNvdE53ZFVIRU5RMkZ3TmsxaTkvalpUcUVsUUNFUHpZ?=
 =?utf-8?B?aGRxTnZ6d0xJd0ZFZ0RucVAzZHJJRUN0eEQvaWdubGJHdE1qbHdSRzdNL3k1?=
 =?utf-8?B?VFRGVEpYYm9pRGU0UFpOVnVpYjRnd1p4Rk9aZnZYT2x0YmpwQ1BYMzNqcU5s?=
 =?utf-8?B?MDRBbG0xSlNKUDVEZmk2MElXZWo5SERNL29CT3oxWWNLbWdSbzVrNFZrOEE1?=
 =?utf-8?B?a21LendHSFJNWjF0OXNlV1dma3pwa3RqQk1vd0ZSWUQvODZvUHZ4U2hJd1cx?=
 =?utf-8?B?N0RFWGF4QXBuTW8wM1dYU1VjUHBDNHVwMGI3ZTFIL2tXMFVFYWYrMGhhL3ZJ?=
 =?utf-8?B?M0E5cUNBM2ltVmtVTHJwQ0hGSHpqYm52elRHVXhOazNKRjNmY0c1TEV5c0lr?=
 =?utf-8?B?YVBJT0c1Sm1rVktucHZzU3liOVRrekNxNDZ0c1VRTFdERGhkaDJiWko2cmJ2?=
 =?utf-8?B?eW93bmY0SmNRTjR0VnByMU9UdGsxbm5nQUVKY214NmZqRDFlMUNicUVsN1pI?=
 =?utf-8?B?ZkVaYU5UWjZkVUl4bGZ4azhjYkdNYmp2dVYxYnAvWHR2dFU2YUtRbEt3QUJn?=
 =?utf-8?B?UklJTlNoek9ZdE5LVG9NZFhHVzZzQnJHRU9pbEZrQ3RJSDEwL2NiNnkzZlZ5?=
 =?utf-8?B?cUdiVVdtSklOYkFtczZ2aks5SlNGVVIvS3l2N21Bb1dGR0Q1dk5IZDgxL2VS?=
 =?utf-8?B?aGxIUDF0V24zNFhLOXhLYlNiTjNQbCtFc3J1a1R1U1pSdmlvYi9ZcDM3V0tS?=
 =?utf-8?B?WGVEaElCanY3RjlmUTkrN1RidjVMU3F3UWxWdzhvVlpYazRYSFBpeEJZOFAr?=
 =?utf-8?B?ZFpMaXcxVTdDTlhYazArUW45TG40MzljRmsxSWM3ckRLaXVKYUdycXFYakNh?=
 =?utf-8?B?ZGlFVFhpN3ZjaUtOa3FEN05PT2RWZDlEeHNGdmRQdmlUcVBYWUJObUllMStq?=
 =?utf-8?B?OUkxUnBSKy9DY3p0VkNnV1lKSmR3ZHNLZG1zYUljd0FVeDJoNVZXOThHQlpJ?=
 =?utf-8?B?VzhoK09VSnhWR1NRRXAzOGZNOHJMYk9MU09wMXVzelRsUzdNd0lIT1g4K1FF?=
 =?utf-8?B?S1R5cUdMNlZubENVVkNDc2pHK0JvS2Q5dis1aXVmQytRcXFJOHVaei8wT0p2?=
 =?utf-8?B?ZnhtbXg5VEJDUVpZdG1mRXdRVFg3blpnVTFRZEtuNTZjdmltWFVUTkRKSWZi?=
 =?utf-8?B?R0FkUnFlbEVWVUEzRmMzNllneW1hZmM5d3BPRnZlZEZpOWdqNTlJb3RpZFlx?=
 =?utf-8?B?dWtkcWt4eWdQQzN1SFQvY0FmQkpUcGhZV2tXM2RXVTJrc1dNWTBMd2xsZzJz?=
 =?utf-8?B?UmwxTTFLT0JCejRYK2c0WlFkaTJpZzlaU05RQ1hGUmR4OTNzc1IvNFhhUVAv?=
 =?utf-8?B?b0hpL2RleG45Smx2dG5WT3IxeUsxMytxaEVZaG00aUNvaFVIRXpOTnNMMXly?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lH6UiIx5+qWLbv/5vJcUR2H4vrQJQet8fOH1G1hb2DqucxEvu077qp/uvbxADDaaUcsQdLbNvz+aW6nSv7mvObMoQgUC+PAySw1NvARryP/3HBa0poaLFz2+zMk2nw9ppX68ZEaTahs0T2KoQ6+ClHe9k5xPnxhe5oZaf8SmRF8F0H0uC0Guz2sx1qj8f9MqyAfTAkI91rfBXjLTmZ3g0jDFqCp+tS+DtljkCh7ciFdeTJ7XKc962exfQ6+ZK76yLRAu0QzZUjPFI5nU50ohrDwVBQ5DiNwp0CSjyoJmzyK/KNFR0vROmTEke2+2ZoXKm5Z37JSiYqteMb9QzQoYq8hQsIWUrroi2PwkQCzfzWFwakeb+JVJ0xxi0szE+9PFEdAcuawrJuhGR7DD+8aFR43x6mGPTDNsZxUdL7fEkkqn1Zy+g/9sOPM4dDJwRPJt0CqXqLcY5j3aAFvOjqhoCqvCGMDusLibhyubCy2tP/zyxbM0zDh/4tMjpwiA0+RfmM6WkDYa+UxQmBvEAStKY5Z6OQuByVkIa6uxGL0r57fhkKojZFz268s/ylW3gcW9geKi5RHabT4I3Chi67UhPZLxwSIFeymo7ZPbt9O0xwU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb0f985-ec1d-4ce6-1dd9-08dd3ef0abac
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 16:35:55.2202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X56ai8zLwOZcZciMmzlsoXC4uoP09LFiOwSv9DK3sEYJzRP95MxYpmd/OU7P7elCjcQ3UVmEmOW+v9uLF45Ey6AoLbGWBVWD5FpkerSaI2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_08,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270132
X-Proofpoint-GUID: I6D_khVPy7dm5VXxLuO481d713HW-7fh
X-Proofpoint-ORIG-GUID: I6D_khVPy7dm5VXxLuO481d713HW-7fh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/17/2025 8:44 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 1/7/2025 7:05 AM, Markus Armbruster wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Add the cpr-transfer migration mode, which allows the user to transfer
>>>> a guest to a new QEMU instance on the same host with minimal guest pause
>>>> time, by preserving guest RAM in place, albeit with new virtual addresses
>>>> in new QEMU, and by preserving device file descriptors.  Pages that were
>>>> locked in memory for DMA in old QEMU remain locked in new QEMU, because the
>>>> descriptor of the device that locked them remains open.
>>>>
>>>> cpr-transfer preserves memory and devices descriptors by sending them to
>>>> new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
>>>> be sent over the normal migration channel, because devices and backends
>>>> are created prior to reading the channel,
>>>
>>> Is that an artifact of the way QEMU starts up, or is it fundamental?
>>
>> Hi Markus, welcome back and Happy New Year!
> 
> Thank you!  A late happy new year for you, too!

Sorry for the delay, I have been heads down preparing a new series.

>> This is a deeply ingrained artifact.  Changing it would require radically
>> refactoring the information passed on the command line vs the information
>> passed via monitor.
> 
> More on this below.
> 
>>>>                                              so this mode sends CPR state
>>>> over a second "cpr" migration channel.  New QEMU reads the cpr channel
>>>> prior to creating devices or backends.  The user specifies the cpr channel
>>>> in the channel arguments on the outgoing side, and in a second -incoming
>>>> command-line parameter on the incoming side.
>>>>
>>>> The user must start old QEMU with the the '-machine aux-ram-share=on' option,
>>>> which allows anonymous memory to be transferred in place to the new process
>>>> by transferring a memory descriptor for each ram block.  Memory-backend
>>>> objects must have the share=on attribute, but memory-backend-epc is not
>>>> supported.
>>>>
>>>> The user starts new QEMU on the same host as old QEMU, with command-line
>>>> arguments to create the same machine, plus the -incoming option for the
>>>> main migration channel, like normal live migration.  In addition, the user
>>>> adds a second -incoming option with channel type "cpr".  The CPR channel
>>>> address must be a type, such as unix socket, that supports SCM_RIGHTS.
>>>>
>>>> To initiate CPR, the user issues a migrate command to old QEMU, adding
>>>> a second migration channel of type "cpr" in the channels argument.
>>>> Old QEMU stops the VM, saves state to the migration channels, and enters
>>>> the postmigrate state.  New QEMU mmap's memory descriptors, and execution
>>>> resumes.
>>>>
>>>> The implementation splits qmp_migrate into start and finish functions.
>>>> Start sends CPR state to new QEMU, which responds by closing the CPR
>>>> channel.  Old QEMU detects the HUP then calls finish, which connects the
>>>> main migration channel.
>>>>
>>>> In summary, the usage is:
>>>>
>>>>     qemu-system-$arch -machine aux-ram-share=on ...
>>>>
>>>>     start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
>>>>
>>>>     Issue commands to old QEMU:
>>>>       migrate_set_parameter mode cpr-transfer
>>>>
>>>>       {"execute": "migrate", ...
>>>>           {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> [...]
>>>
>>>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>>>> index f31deb3..2210f0c 100644
>>>> --- a/migration/vmstate-types.c
>>>> +++ b/migration/vmstate-types.c
>>>> @@ -15,6 +15,7 @@
>>>>    #include "qemu-file.h"
>>>>    #include "migration.h"
>>>>    #include "migration/vmstate.h"
>>>> +#include "migration/client-options.h"
>>>>    #include "qemu/error-report.h"
>>>>    #include "qemu/queue.h"
>>>>    #include "trace.h"
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index a605dc2..35309dc 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -614,9 +614,47 @@
>>>>    #     or COLO.
>>>>    #
>>>>    #     (since 8.2)
>>>> +#
>>>> +# @cpr-transfer: This mode allows the user to transfer a guest to a
>>>> +#     new QEMU instance on the same host with minimal guest pause
>>>> +#     time, by preserving guest RAM in place, albeit with new virtual
>>>> +#     addresses in new QEMU.  Devices and their pinned pages will also
>>>> +#     be preserved in a future QEMU release.
>>>
>>> Maybe "@cpr-transfer: Checkpoint and restart migration mode minimizes
>>> guest pause time by transferring guest RAM without copying it."
>>
>> "Checkpoint and restart migration mode" is ambiguous.  It would be
>> "Checkpoint and restart transfer migration mode".  That's a mouthful!
>> "This mode" is unambiguous, and matches the concise style of describing
>> options in this file.  Few if any of the options in this file repeat the
>> name of the option in the description.
> 
> True.  But will readers understand what "CPR" stands for?  Do they need
> to understand?

No, IMO they do not need to know the full spelling of the acronym to use the
functionality.  It is spelled out in a few places now.  It could be spelled
out in more places in the future.

>>> If you want to mention the guest RAM mapping differs between old and new
>>> QEMU, that's fine, but it's also detail, so I'd do it further down.
>>
>> I'll strike it.  I agree the user does not need to know.
>>
>>>> +#
>>>> +#     The user starts new QEMU on the same host as old QEMU, with
>>>> +#     command-line arguments to create the same machine, plus the
>>>> +#     -incoming option for the main migration channel, like normal
>>>> +#     live migration.  In addition, the user adds a second -incoming
>>>> +#     option with channel type "cpr".  The CPR channel address must
>>>> +#     be a type, such as unix socket, that supports SCM_RIGHTS.
>>>
>>> Permit me to indulge in a bit of pedantry...  A channel address doesn't
>>> support SCM_RIGHTS, only a channel may.  A channel supports it when it
>>> is backed by a UNIX domain socket.  The channel's socket's transport
>>> type need not be 'unix' for that, it could also be 'fd'.
>>>
>>> Suggest something like "This CPR channel must be a UNIX domain socket."
>>>
>>> If you want to say why, that's fine: "This CPR channel must support file
>>> descriptor transfer, i.e. it must be a UNIX domain socket."
>>>
>>> If you want to mention SCM_RIGHTS, that's fine, too: "This CPR channel
>>> must support file descriptor transfer with SCM_RIGHTS, i.e. it must be a
>>> UNIX domain socket."
>>
>> OK.
>>
>>>> +#
>>>> +#     To initiate CPR, the user issues a migrate command to old QEMU,
>>>> +#     adding a second migration channel of type "cpr" in the channels
>>>
>>> in the channel's
>>>
>>>> +#     argument.  Old QEMU stops the VM, saves state to the migration
>>>> +#     channels, and enters the postmigrate state.  Execution resumes
>>>> +#     in new QEMU.
>>>> +#
>>>> +#     New QEMU reads the CPR channel before opening a monitor, hence
>>>> +#     the CPR channel cannot be specified in the list of channels for
>>>> +#     a migrate-incoming command.  It may only be specified on the
>>>> +#     command line.
>>>
>>> This is a restriction that could conceivably be lifted in the future,
>>> right?
>>
>> Yes, but lifting it requires the big command-line vs monitor restructuring
>> I mentioned earlier.  IMO that is far enough in the future (and possibly never)
>> that adding a "Currently" disclaimer would be deceptive.
> 
> Now I'm confused.
> 
> Earlier, you explained why we can't simply send CPR state via the normal
> migration channel: we create devices and backends much earlier long
> before we receive from the migration channel.  Correct?

Correct.

> Here, you're documenting that the CPR channel can only be specified on
> the command line, not with migrate-incoming.  Isn't that a different
> problem?

They are entangled problems.

* cpr state must loaded before backends are created
* monitor must be created after backends are created
   (because the chardevs that define a monitor are backends).
* migrate-incoming must come after the monitor is created
==> migrate-incoming cannot specify the cpr-state channel

This restriction is unlikely to change any time soon, if ever.
I have documented it as is, without speculating about future state.
If users do not like it they can request changes.

>>> What happens if a user tries to specify it with migrate-incoming?  Fails
>>> cleanly?  What's the error message?
>>
>> It fails cleanly with a pre-existing error message that could be more
>> descriptive, so I will improve it, thanks.
>>
>>> Maybe simply:
>>>
>>>            Currently, the CPR channel can only be specified on the command
>>>            line, not with the migrate-incoming command.
>>>
>>> with a big, fat comment explaining the restriction next to the spot
>>> that reports the error.
>>>
>>>> +#
>>>> +#     The main channel address cannot be a file type, and for the tcp
>>>> +#     type, the port cannot be 0 (meaning dynamically choose a port).
>>>
>>> What's "the tcp type"?  URI "tcp:..." / channel
>>> addr.transport=socket,addr.type=inet?
>>
>> I will clarify.
>>
>>>> +#
>>>> +#     Memory-backend objects must have the share=on attribute, but
>>>> +#     memory-backend-epc is not supported.  The VM must be started
>>>> +#     with the '-machine aux-ram-share=on' option.
>>>> +#
>>>> +#     When using -incoming defer, you must issue the migrate command
>>>> +#     to old QEMU before issuing any monitor commands to new QEMU.
>>>> +#     However, new QEMU does not open and read the migration stream
>>>> +#     until you issue the migrate incoming command.
>>>
>>> I think some (all?) instances of "old QEMU" and "new QEMU" would read
>>> better as "the old QEMU" and "the new QEMU".
>>
>> Maybe slightly,
> 
> A second opinion from a native speaker would be nice.

I have appreciated all your feedback and made many changes, and it has made
the code and documentation better.  Thanks for that. But right now, the V9
patches are queued, pass CI, and are ready to roll. I would hope at this point
that no one would consider "old QEMU" vs "the old QEMU" to be a showstopper
that requires new patches to be posted.

- Steve

>>                  but I consciously standardized on the terms old QEMU and
>> new QEMU to be concise, and they are used everywhere: cover letter, commits,
>> comments, API, user documentation, and in already-committed cpr-reboot patches.
>> Adding "the" would require changes in all those places, for consistency.
>> IMO it is acceptable with or without the article.
> 
> Yes, consistency is desirable.
> 
> Thanks!
> 
> [...]
> 


