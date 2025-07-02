Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB55FC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxgS-0002bR-Ch; Wed, 02 Jul 2025 09:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWxgN-0002Z6-Qb
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:39:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWxgG-0007Sr-Q2
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:39:27 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Bis8b016811;
 Wed, 2 Jul 2025 13:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=HUNww8Y37bo1z/oQ+gQuKoigsBj+OF6da0Km3jTwZAw=; b=
 M8Cxuk1vpwV0TtqN2QcoS1HgiNTwR8CFLdcGCT6+wehE8xFWWB/4TS5Lt6tXqsf3
 M/MHWJ9k6UhqJzz67SOWJbq/c3dUebpEN0wsDyP0dMDZT88rUELdQk0TMTWF/a7I
 hCUsIwlaJMzuuLK+juXlk+iAHLiBz//xxbH5NsE4j+1JUHVAJGQq9gCuP6aRrJkc
 9BCw2eVpNx4tSmDqOzOd6hUgqOK8zp4lNHlKLiawBO8cDGDhDhde9nG++dU3GPNf
 IQNGOuw07Qxe/o4Me1noCOErJENkq4lxI10xnLqfpGKAXF+4rI+9YhylPupWPjw/
 2/bnze/818HW+/dHIdcMrQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704f09w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 13:39:15 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562CdS7p019262; Wed, 2 Jul 2025 13:39:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47jy1g04s8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 13:39:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LL5gQjZbIRaMjeuWTjm9K/GPM5xl7C6ILzgTCusN8a7g2b8AInbXmY56xTNXN50Kd02nPvNQkY3dBpXhh5mN621KMDYe+uwNN1FPazKILxdNU3C9hB6zrrPS3F5hpf9rN8ByeaSB1HzZ3t5RraH+8ybX6F6TwNlrqGyAb59DVtLc0f4gDjaxwH6PowmRtTAyNd8Sii4j7XDZaBtc+vP7ZdDDe1xoZmASsg/7GPLRYN5Cxa1DS4ciHTbKPEX4RpC3brwWYtyIEnZ1fAkBeii8uPquQwr62sQGDT345u6yd0bRfFGlBj77wxC6+5Fr7dPGJNmUX8P1fjnUmoyrQ7wgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUNww8Y37bo1z/oQ+gQuKoigsBj+OF6da0Km3jTwZAw=;
 b=TujF7OGEa2BrYgcAxB4LFtU6k8LgywE7cr90tlwZ6YjHGaTX+FACY2uWB2i3z2K6QmezAmsM59xiwQ5mLPxAQJX5RItYFenUYVXQnBtITLP2rdAym10YVnBLDHZsYLjORTjY9jPLEOthxH1z6vVuEujg2QDpypeLSMnzLMpwzZCL7DRdPa2lIbA7Y0dRZd5ZqSpRyNP8unWbc6E+JhjHZB7kthVI2YahqmwVAqX4/wf+2Ahangx727HyCoNGfmtePYLyjFq3ko1xXbbX7Umr5VpA/Bx9++PIpvFOttbz6sjbZaKDW3HZ+FhGGCvVA4KuKMK2A3OZ2TCMiDwdsRnvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUNww8Y37bo1z/oQ+gQuKoigsBj+OF6da0Km3jTwZAw=;
 b=xnTVcjOhF72IzUFMObHGPRKX8OIhsIBJOw4IbJb7l0jjTtkw9qjk2nmynU53kBSOsIIY8nhIxNw2xMf71IB36Vbp0kftk5ADBmD3Pwo5FPqn3ZUyEW/xgEUdW35h1Mxvh1I9ebi0Wh/hR6n77VgaKkOzYVpcXOXfiwykJnAQw9g=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB6749.namprd10.prod.outlook.com (2603:10b6:8:11c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Wed, 2 Jul
 2025 13:39:12 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 13:39:12 +0000
Message-ID: <1e523e81-cdee-4331-8799-3d9220ec283f@oracle.com>
Date: Wed, 2 Jul 2025 09:39:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user: do not register vfio-user container with cpr
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, clg@redhat.com,
 john.levon@nutanix.com, qemu-devel@nongnu.org
References: <20250702120043.267634-1-mark.caveayland@nutanix.com>
 <4543142d-de4c-42fa-9309-3f00ad44110f@oracle.com>
 <b2bb792b-183c-439b-90b5-9a2f6bcfe864@nutanix.com>
 <8b751d27-7826-48e8-9821-9a961e2f509b@oracle.com>
 <4d5973e0-b4d7-4201-bac5-495a12972de4@nutanix.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <4d5973e0-b4d7-4201-bac5-495a12972de4@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e9ba05-75f8-47da-b936-08ddb96dd42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWVMOTRtdlJQTXF4aDZwbzRpa25GTndUZ096dm4xQmN4YzZNV0JRN2RLNlJq?=
 =?utf-8?B?REc4V2xSYXNRMjlIZTlVd0xYMXJMV0wxQnhDaHlwWFM1KzVza2VILzFqOHhw?=
 =?utf-8?B?VTY3Z3R6NHZHMVpiN29EQytrNEtkNmxxQ29yUmNoR0NLb2hkZzZvNnZjS1Js?=
 =?utf-8?B?UHlzeFJma1pTbmI3M3RqYmgrYW0va05nMFNXZWpXRnllKzBlWCtjbzY0OE5G?=
 =?utf-8?B?MVR2RlJtMkN6bDVhZDFhS09kR3JYNWdRd3g1czlnMUxTQktFNEE2eGFoUTMv?=
 =?utf-8?B?bExONm45cGI5c0VPT1J1QURSUTNjOTJybmJ4NXRXdWVhUFc0c3gvcmhzNUxr?=
 =?utf-8?B?aUxCbkRYMXE2TysxYmxhUGcvanF6S3VEa0dwcTdxV08ya1NQQTFSNWt2Z2g0?=
 =?utf-8?B?K3l0c2dFTGQwY3h0Q3M0b2NGS3k5Tk1KTzFxaVppMWtXN1FLMklkMFdQVldZ?=
 =?utf-8?B?R0htWWtkWDZRaXVJZGExWjNka3RBd0ZtdXlRSEk1L2NKUXYyaFBhWHJ6aXdx?=
 =?utf-8?B?Ulc4NXNnbTJaOHFjbjh3WFM3SUNsSTlnckx1Q0FQL3R2SmJRSEY2cnB5MTBX?=
 =?utf-8?B?Y0ZRUWFhV3RzRHd2Um14aVlPcmZpSndLeFY4a1pwb0p2a3pPNUs2cmVYQ1pF?=
 =?utf-8?B?cU9KZDFDOThsdkF5SEtYWUxNVzg1QmlNWDV5VW5PWWJhRm1nQ1gwUGVuZVl5?=
 =?utf-8?B?ekdsNy9EeFpRa3E0WHQvMEZvczZRUUhIaVU1ZVBCRnVmNWhORmI2MW0xVzBo?=
 =?utf-8?B?bUNqZXl0d2I1QlRDQmRiTDJPeGFPbXFsdDF5UnI3Y2d4SzR2UW02VXk4R2Fp?=
 =?utf-8?B?YUE2YUhXWDV2ZnRETmp6dnMwbkpSRHFCZzlzaW1VNnFmWGJTZDY3TEhCT1ZL?=
 =?utf-8?B?R2JmbUZPbHNacE5USkUyRENwQy8wem5nL2I5MExGelpxYTh4N2NQZ1A5b01s?=
 =?utf-8?B?VEZJUm5udklyTG9teXc5Q3NqbG1vYlorTHBITS8ycTJRNjdoTXJPK2ZhZWV6?=
 =?utf-8?B?bDFKVnRrSy9rZFlPR3JtUHgwaVhNNmtxcmtkZ2NFVFRqRmwxblVXelJDVFdC?=
 =?utf-8?B?S1dOQzdJanYyTW9kbHBmMzY1MEw3YzlmSjJqL1BBMTREZXlyYVBnWUlMcWlr?=
 =?utf-8?B?bkU5d0pxMFVJTFpVYktlTCt2b3ZwczF3REt1UnF0Q2YzMUJYNnJtMW0rSEYv?=
 =?utf-8?B?aS9ZWkowWSsyRmVzWmpLKzF2YzFUWnMrQnJuVzFiejdVTzlLbkZuL25obUJp?=
 =?utf-8?B?eDJxNXpTdURHVkNTYjF1SjR0R0pWOUdldDFQd2pZekgvNjNxQisrL2VxWEFr?=
 =?utf-8?B?Q003c0FmTTkvQ3ZFOEhVOTRkZUxnaU1IUFdScHczdGpHeUdNUjFLVFRDTHNk?=
 =?utf-8?B?RGY3OG1naldQQ0NLem0zeHBpK0w4NkJsWi9uQXZWS1Z1ZnZBaURvYjI1NEdS?=
 =?utf-8?B?REJHbWRDTnhxNmwrTk9kZ3ZJZXBrS01BdWNialA1L2UrYytpVXlyRUJwQkI1?=
 =?utf-8?B?bUdmSit1TStqeHRDd21aaWpRYmRvOWFlRmZab3hxRTA5TW03d2ZRUWExQmQz?=
 =?utf-8?B?MzV5eC9qNlJMYVhVdVN3cUlVYlVxTFdHdTNmYnBSZWJPSlFoM0lGZ05TMzFG?=
 =?utf-8?B?N1RacENJMi9uYVg3NEcwUDJVVlo1U3B6QzB5cDdKQ2hGU0ZaSEw4VnBkSWdU?=
 =?utf-8?B?WndrTTcxK0VxRFF3bXdRdWhjVHVWV2haOUVNR0tXbGlpeU5EV25ZazhrZ25p?=
 =?utf-8?B?c3VCUC8rZXAzVHBpeHRWRDRUeENieTRhWXM4R25iZ01jVkpWR2Z1Zm5YY1Rx?=
 =?utf-8?B?Nmdtb3IrU3JvOWI4VmhKUkFJeFc5UElRekNyUC9NcGsxcTRQOW1OTysyQmI1?=
 =?utf-8?B?OUQ2SVZGQWpRRDQwbDVVaWl4clg5a0grdmtLcTllQnBsSnFVLzRNS0pmYThY?=
 =?utf-8?Q?zfxwIyKl3nw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHNHaGNyWTljSi9YQ2pVR2lOOWpnbXJEc3JrR1lDK3ppeTUzZ0VMd3hJQjFN?=
 =?utf-8?B?ZWJJaGdVRktVS1lmYkVEQ1VVK2NTZVdXM1d6ZEw0UjA4a1RaclcyektvU2ha?=
 =?utf-8?B?Zkl5ckM2NnJ1MjNueExQRjR5VGIxamVnOVNKa3FRRHlqTkxBMldhSzBGRmN3?=
 =?utf-8?B?RlFqSC9ZVVhWcDV2cURhN0JrZHhEckh5WWZnS29LbU9KR3dEYmx0Ym91aGlV?=
 =?utf-8?B?R2d4U1JjZUhIUExEVzlYNTBRUkRJSDU1TWFyMjlwek5BdTlhQnBKUUJ2YTBv?=
 =?utf-8?B?RCtHS0dLdVp1NTRiaUl4Y2tTcGViV0Y0enlhYlo4cFJVS0x3YkxpVFQ3dk9l?=
 =?utf-8?B?L0dvKzByZkY1Ync3OGFPREF2K2lXR3FzZDNoQ2gwekU1SFJyaWRMNFY4MzQy?=
 =?utf-8?B?eDVzcnJSMGpzN0IwaXVKankvejRrU2ZqVkpzZ1FyUmN2MGxlUXNzUE5US2Rv?=
 =?utf-8?B?NXdVVWJIOFFjWkV1Z2ltM3ZvK3JIUTEwbVl5SUk1a1FFa2tKWnZ1Y2NSUEQ1?=
 =?utf-8?B?L2k2c1BrbCs1K3R2a0RmcmpNdjIvdDByRjZ5L0o5S3MvNWFxU1F6OFhDWE1B?=
 =?utf-8?B?TVhLY1RLMUpYYS9JbjgySVh3emIxS1cxcEpQZ3RVUnlnTDQ0TjJRcFQwR2Nv?=
 =?utf-8?B?aFpZMTY5d2cwbWlhbjMwT3VYMW5yeXo1aFJidlM1RFBOSzBkVHU1LzFsZmg0?=
 =?utf-8?B?UlJKMWY0VUU1RTRPT1h4QkVMOXVRY3IyOUExUFU3VFFsZU9XKzNiT1ZXS1Nl?=
 =?utf-8?B?WjZVekRmR0h4b2locTBDcWpzMGNIRFM5TEQvZUE4a285dDVNYzRhK2lYVjJz?=
 =?utf-8?B?d2llWUMreFFkVmthUTIvVkE4cjhibU95dVJLUCtsQVVzdWtxazRYVW5DTStT?=
 =?utf-8?B?NmpWVkpjenhaTUFqVHFmeFAwSFRFU0FJUXhMODl6RTc4UUtDSDdzWmVlNkM2?=
 =?utf-8?B?ZUNlZ2kvSzBZREtuNnNCbXJpQXZseXFOb3hsTGZaK2JIWWdrY01oaTFwTG95?=
 =?utf-8?B?OWo3QitLS1pKdURLUWZ3aEp4OGJaUHp3cDgxVm5OZldFQ0FUa05BVXhLMnZI?=
 =?utf-8?B?MUYySHQ2Z1h2RkwzR2t1aE1yS1VST09LYmtIZjEyWEl1UDh4YUNSRFNqU3hn?=
 =?utf-8?B?aGRzdkZXM2ZRSHhwR3hBL3Q2aHRhcW9MU21GYi9Nem1lMVlleFJtVFhkYjNP?=
 =?utf-8?B?Tzl3bUZnL0Fhb2RLZTlRV3lQMmFHdDlHVi95blFqam5XWDdyK05pemhiTjNL?=
 =?utf-8?B?SXV0bytmQUVnNk02c1RERkRmcm0zK3FZYm1ZTnJiM1RlQURIN0tYOVg5WU5a?=
 =?utf-8?B?UXIwZWdKL2p5YkNYT21vZVh6K1B4UmFwdUprNWZ1b0NZZkVQRjNHcExYakpi?=
 =?utf-8?B?cFp6dlpFMTJ3ejAyczlnVWFsVkd6MFd4dXZ2RmZIZU8wbWlMQVc4cmNCbjRH?=
 =?utf-8?B?L1MrSHJCZFB4elgyYWFPK01YUmd4UGpCVVBBTWE1NEFnVjBVRlVxSFVKQWhW?=
 =?utf-8?B?Mi8yeHc4SHltbGJWRXBqeWRPWXNqVFZJbUR0MzQyZERrMVVxSmJtUm9LQ1E3?=
 =?utf-8?B?R3lmNWFITlRYdFRCUjRpamh2N2tya3Z2RElMNGVuMGpTN3RFdHRuTnBtVExo?=
 =?utf-8?B?OGZuenkwd1M2UXkxTlZzeDZ5KzNrcG42VHk1SGJDbGVyVExOM0dNOXphZ1Zz?=
 =?utf-8?B?UFdSeHRvVUh0aWNIN0tiZEY0em1VVjByUG1IVURUQXZ3R1NYREdvWkdudDZU?=
 =?utf-8?B?S25LT0w2YUEwS280b2dVbDRIT3V2OGpNbEoyOFgwUXpwSTQxUUZWTDFYUzlI?=
 =?utf-8?B?enF6aSsvNWlsNFFndXljZGxpOWVmSzhnZWpmR1gxb2NDNFhRbEVJM2d1NWxN?=
 =?utf-8?B?c3grenlRcnFyejlkcEw5SmhUdHhMYlRXWG9yWDNTVkhVSlJUN3lTLzZjVE1q?=
 =?utf-8?B?TW0wSVlhYXMrV3BYNzVKSkY3elFuc3pHdlFmOU9QekZacXUrWUVNMC9MWGxp?=
 =?utf-8?B?MzFjRHk4MmRUK041Yk9ySWVEWkVwQlRWc1lWTFVwZXhwRGJDVHlBd1UzbFJH?=
 =?utf-8?B?dERJOE1yMkpaYzdTTXo0WEVCdmtZcWNRVXJlcGxXeURvbjZTNW9YWkNBeHZh?=
 =?utf-8?B?S09jMEF3ZzlwaVhUY01LNlJhU3liSXF4TVVqNjU2RldFZ2dFQWRrdC84VzEy?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HdxxuWqZlhS8fFG052OjQOK4CU4xLukHor+ar9TUwromoC6qm3YRf+dUXxjNXLBwM8QaLYc0d+cOChqrCA6BDXpQh3M81zzsjRz5bqQKnvX9L8eSS2XWLEaXvStpGuWdtvzt/TAL2pyBQesVRAUakVPqXgxhLSuHUuxFsW63hQPcagnakWhDtISFhgL9eqxxYXgIUEVvn+Zphu8ysPnfzZcqOe5kOBa2Zlcv3OGlFvGdbzUQLknEKFd+myWFJEv/yBMoegroB/Ie/R4jMJoDIlvYKJJobQFRuVJy4c38hcLNIJJvdJX44JjwKPwl7Jpm4b6oLyRtXs29C5SY7BrZUESyfU53kKz9Ob35hBp3zp7A9+dYAE0hEBVHMq9LZz0HbsQMcOTCqGcTO2VYwVuEAlq+SBm4u2Ol81SEexMfC+J7NAnTODAYRthOuIdxFQcIxATwKOgcpkBiOqZkEXOHa75pIgd3QlrOtPT8kFjZwIdw8TMIF9nIho4dumMimznW8ZVpTc5bFJcIXRudneS/e9z1wb8FuBP3PcTbyOQyh3Ydwom+X+rRsIirPSTsvTnOwL6sEhJcsZ+KcKW25p35wtUUsG/1ARlSp9iUAdGf6wE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e9ba05-75f8-47da-b936-08ddb96dd42f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:39:12.1111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIxZCW8qbfk6c/CKHvvY7r6sUncc9i6O7AlCX9DMhUJwjKZv6ewO3XXwvZqpFeJ8Ti752ZeOBNlECv+yrG2YK5uJYrO2mbpWqUUZmxt/UXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=860 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDExMSBTYWx0ZWRfX5GmhYOMWfx2j
 R4Ap1Fy/ll5sfag9492HH8GWEVWwVZoWD+rfADeoaKLST94ieCok3JiUhZ4TmRXkWh0R0To/BxT
 D6XNBOn/VpT9cirFAp6byAAuvXjoUNtXgOrGHDGom1I/bCs6nSJGB0T/f13QahC68DgJD9ktrx4
 RKnW/v/JWjrYiYjKoUwLMM7jThfUEotTEQxS+X9Zi3LkCGtGy8i2EXwdk/h7jlOYfe6k9yiAm9s
 UURS8sZMbx1ozkMpqlr8H0Rvvv48V8zSwfcBPYOymW56QmacRBUcKOMzfDyP0dwWz2jcDabytgM
 TKrrCT9fPvZEvup4cB6Ufx9y3dQZ0HFHKGkj9Z7XoDFCHLBKnFS+ragbfCGrVe1ZfFXskRsqobW
 D8Ncw8+fqHn5CdhgMsMiZDEr+emew7PJfdAfR3/Ge3s/pfIfsGyiMknZTfQGoHzvs8MYSMI/
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=68653683 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=64Cc0HZtAAAA:8 a=P0eK9-YUlbrwqS9_dN0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13216
X-Proofpoint-GUID: OHcEdnhFIv8l4_lnkeIOE4zkIa8iE7EN
X-Proofpoint-ORIG-GUID: OHcEdnhFIv8l4_lnkeIOE4zkIa8iE7EN
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/2/2025 9:30 AM, Mark Cave-Ayland wrote:
> On 02/07/2025 14:24, Steven Sistare wrote:
> 
>> On 7/2/2025 9:21 AM, Mark Cave-Ayland wrote:
>>> On 02/07/2025 13:07, Steven Sistare wrote:
>>>
>>>> On 7/2/2025 7:59 AM, Mark Cave-Ayland wrote:
>>>>> As the full cpr implementation is yet to be merged upstream, do not register
>>>>> the vfio-user container with cpr. Full vfio-user support for cpr can be
>>>>> merged later as a follow-up series.
>>>>>
>>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>>
>>>> This is fine, or I could drop my pending patch "vfio/container: delete old cpr register".
>>>> Thus the vfio-user container would be registered for cpr-reboot mode, which is fine
>>>> at this time.
>>>
>>> Have you got a pointer to a commit showing how the registration should be done without using the old register/unregister functions? We are certainly interested in looking at cpr here at Nutanix, but since any work is in its early stages I don't think it matters too much if the old functions were to disappear.
>>
>> No.  cpr-transfer for vfio-user is going to be a bit tricky because of the external process,
>> and the existing registrations will not cover it.
> 
> Got it. In that case I'm happy for Cédric to take my earlier patch to remove the old register/unregister functions from vfio-user to avoid blocking your work.

It will not block my work.  Leaving the old registrations in place in your patch and
mine allows cpr-reboot to work for vfio-user.  I would simply drop my patch that
deletes it, and rework the registration to support all cpr modes in the future.

- Steve

