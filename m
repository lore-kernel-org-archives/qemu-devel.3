Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466E1CFA459
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 17:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3fFv-0001Zr-VC; Wed, 23 Oct 2024 13:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3fFs-0001Z5-Fv
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:34:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3fFq-0008GF-1R
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:34:44 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfe90011117;
 Wed, 23 Oct 2024 17:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=GQmorql24E+ujRkHkx02NZtcBbLjDsq7DK0T+rNXWxo=; b=
 aFjN7QM2GFYLmUMH2RlVss9YVWBsXbng3X47SUDOv6E/JAa6nvm+iwEWeSEK/1vP
 LGPMiEOqSxwsvtwc3Amf/Tv6fMAvQfw+x+hDK8nUnIkqq9Hni8qzT9LMw9axbPbg
 ZKj1rEvC/jHWRu2OOfavqOfEWmElg67lB9fFDbd/Jj9sWoYJ3Pk6V96RziEYEw6G
 CzpiHiLnMGyJSNuNEqBiJyFDN0rotg2ROeU2Jkei2i8+L0U0/12PrylWAxU7B/aA
 At27P6MoEotibBDoYvDqnw5XPgxJhECPta1nCtqUDEsTzLttbUMoYmQ4HbqwfI35
 H/KmSrqa3j+/dZ97I8HS+g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3fvgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 17:34:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49NGKiCP031058; Wed, 23 Oct 2024 17:34:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh1twmg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 17:34:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwaKZz50Ju/BJJww4QJovuGMbUBW3AMitaf+jKelQK6uKi+HVfo24kRL/ph+wZuXd8K+LPrJ0857oPWjm7lB3ODjzYgQHtnjZXJCst3C7b1dzWksmndB9ZccUrPSD7tktclDdp7oUB0Asa+uuEOt8XKMkSbDRmLfKbeGCj6a/ff0bk8NKqyYCdtnZSlJssO4XsgKhBmZLAipgB+lTu/uktpYSYHU33fB9Z7swq+VyDBlpQJzLh7UfSUkc8oPiCeMTc7gaE7LULiEO1nzfHaIbptp1lWRHFEYMMduTfba1ZbDe7bW43bzqOLLonAXX80wLz0crsp27fEHfrNydXrGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQmorql24E+ujRkHkx02NZtcBbLjDsq7DK0T+rNXWxo=;
 b=vLEPVWQSZS6u/wR2IsZ9YzBiQDNLnObNLmcDW+gDSXuqSBlQ5bKV4iQH6Ubkzl/H3hF9jR15FW9rH5Xm8BbzLL5xCF1351K3jFEZdt9JITj+X/Ow56uLqzVIVkX79uZjOagVdxjDtO29Aq9VxBZqS4M+OBbacPEAG0lL4NNKFC2OhIbgHlcIAI1vTcGU4DBBFFCeonNA5xVZra41AY24Kc9lVEH6W5r4sI9B6e2tYH6/pD9k98MDV+uzQvhAroSdXBAjIhvKTLAm+NPyYqGCJyndglUewQAXs/Nx0N4nv36WCe1B9YffgPZWuYA4wGzuP2E5vK+CsB5WqDsT2Za2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQmorql24E+ujRkHkx02NZtcBbLjDsq7DK0T+rNXWxo=;
 b=IRQPAQKtMcOuFHN1Q8Qia38nZXiydtdOIw4+3tzBSv3bZu8VIsk3zwAHCQdL+KGeok/McCB/elVjmm0KA0s4HOJoXl1VHid9ZlzSjlBjBLgqX/BMSruaUp8NshuYkh66zYuV0VER+oWVMifk+jjj3/g8qkU7Rsn5WjJ9J7avlj8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB7146.namprd10.prod.outlook.com (2603:10b6:930:74::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 17:34:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 17:34:32 +0000
Message-ID: <f2330805-9eea-45b3-8f8a-de22ebf22d52@oracle.com>
Date: Wed, 23 Oct 2024 13:34:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 11/14] monitor: connect in precreate
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-12-git-send-email-steven.sistare@oracle.com>
 <ZxarSUBGD7LpK_v6@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxarSUBGD7LpK_v6@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f43950-16fb-4307-3ca4-08dcf388f462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHBTYlFuSFFxWUV5d0h4MmI0WGEzY0tLNEowT2tSOVpxL0xsNDVwTWJCalBQ?=
 =?utf-8?B?am5rbWNxQzNUak9wNXR0d0NGVlBoczI0Z1cwVG1NVldHVmwyeUZ2cXQ3Rkt6?=
 =?utf-8?B?WnNGMk1rZlFwYU8wRkVkdVpvbHBhaGZrWitzZk4vSFFDVFZiRlVRMm11WU1E?=
 =?utf-8?B?QTMyaWVodjdBQkJNZndUZk50ODBPK3I5MktGWDRKZnlVRTNieHpNY3hPSmVj?=
 =?utf-8?B?eUNuZ3JlaFh5QVlsSEd4NDRNWkQ1Z1M1MWdkMEJ2ZW1DYjVDZnUzUmp6M3Y1?=
 =?utf-8?B?THZFQk4xME5PeTYzZ0tFSTkwSkRlNFFVM0k3V2FjZUU0QUJ3S2dxNVQ0RXF5?=
 =?utf-8?B?WXVBYXJINXdVWEkvQk81NnhOUjFtUlpIbUd2VU05djlnbHl0Nk8xZzZkK1RN?=
 =?utf-8?B?RFVydVA0VVR2MFhubDMyVjQ1dlp3a0N3UWRRSUkwejEvOGhEYmdRZW5SOTdD?=
 =?utf-8?B?elFMVUYyd2Y1Mm9oMEdmU0tKY0FxcWNrQjFIOVRNV0Y5TzNrcG1hS0xhZnk2?=
 =?utf-8?B?QW5nVWN5TDRvcnRDMnZmbjJJNWhUbjJsZ0VhTjdaUjgvNFN6NmFRWkFQa28y?=
 =?utf-8?B?Z254T3VtYmhERjFZcUJ3ak5ITVRQT1lMZFovOG5nQU5FSGFLZkptZzdyc0VI?=
 =?utf-8?B?YkFnK3EzR3V3VjNXVk94YXJHYldLTUphT28weDljUUEvald2RHNUN0tzaVAv?=
 =?utf-8?B?Tm1mV1BValpPTG1oNXh2R2lweENkTWk1VG9aR2RBd01SeElhMUdIUDRQbFhG?=
 =?utf-8?B?YVdpdCs0QXlhV0dwMElDUHRUMm4vWlhVeWlSR0RoUDRlTnp6N0xZMmZhS0k4?=
 =?utf-8?B?NHNXdURGVmlLaDIvSE1hcFVRaDZXWWszU01RSkJNVEhuWGhxTU5DN0crVzJC?=
 =?utf-8?B?eDJhSE85ejNXblJXWmdYUS92aTVwU3lzMExIUEI1Zk1PS2ZBRmRseXRkelJk?=
 =?utf-8?B?cGduRU0vdTc4NSthT0taNzdhZlg1NXB2b3BUc0lhKzVmTnNTdlpPMElvUDly?=
 =?utf-8?B?bHNWOVJQZ3NzMG1MOVhBNlFEYjJoS0ZhRmtIR3g5dkFSSjlZV2ZibmZkMWt2?=
 =?utf-8?B?STZtTVRmYWZjNm5mU01KN1I2aGN5RHBlNjZLNW9lcUgvV29rTXFaNXZEc2Zp?=
 =?utf-8?B?K3d3RitLZE9CY1ZRdUtmRURLTUZ0ejFQUlAzR3FXcXpkZDUwWVlpVDlIRm13?=
 =?utf-8?B?czNOSnZMZG15eXAzeDhjK2dzdWI3cldiVHdIMmxxVTRmckF2bFFVVm1CY3Nl?=
 =?utf-8?B?bDZiZ2w3VFk4dGp4a2xESFA3U2ljaVd3WHdpWUl1UkxnaTUrNG0vd3Q1V3dv?=
 =?utf-8?B?MGcydmgxblk2cXVKcmhxd1dZeFZPVnNZaUdHZmRhYjZGeDBaekUxZFBJWDJo?=
 =?utf-8?B?UmJYMTlqUXpMRGw2UDNGMmpmc0FjeDhvNnVETU8rYmNRWlROQ05KNXVJTXhj?=
 =?utf-8?B?L1ZTTXFJc3M2TkxPVHRLeWxLVFdibXUrZGVXVzZ4dW1xWnNKcjRneFg2dHkz?=
 =?utf-8?B?NnZrdUNqZlZUczlGSDB2VHgyZXZ0Q21IN1ZJRVR4S0x3YmNUdWc2d3pzZHhp?=
 =?utf-8?B?M1oxY3RlSDhTTDBLV1Bxd1A2OUNiWjhZU0hKMUkrVHUwNG92cDVGZy9lZVVx?=
 =?utf-8?B?MHlBZWRaS0JnRFlTNzZvSTNvSjlFUXJzclE1L1pSK2RpN1hOZmllR0VVbmEx?=
 =?utf-8?B?Skp2Ukk1TUc3WFdLeHVzMkFXNWFGejVjclpoUlNlREtITHpHYkl6dlZ4WVZR?=
 =?utf-8?Q?97Lm+ahtx8rFFtF7xRBEGWgK5pKzjoTmQhapE0M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmdwa0VwRnNpVzdhajE4Q0l5VVcwbnpweEpCK0ZZbUNtWU1CSUlmTzZ0aklh?=
 =?utf-8?B?czFoMUJpNWFmcDNzN0s2ZXVhUVZSMjJjTTB2NFppNC9HMXlNcWR3UWRFdlEx?=
 =?utf-8?B?dmJZOHFtc3JZanNtMjRaSEJZTzUyMWt5ZXFsb2lPbXI4TnR2YnM5NnVqbUF4?=
 =?utf-8?B?M2VTRHc0c0dMV2lSOU53eGtHYTFKMmhGNStsTHIwYU95OGRtdU9UamJQTzNw?=
 =?utf-8?B?RzhldGtrL1FnamtXajFkYTFWZTRaZ3VRYWZmZGdyNUg2OWRreDdGVG4vWmNh?=
 =?utf-8?B?K1dLTHVrOVVzQWZnQXZmcFRPT3NLbzBENXo4R3JwZjl2TTZkN0xHZVNrd1BM?=
 =?utf-8?B?aURGN2krVTZUaG9PUWpDUHhVVnFXYTF0L3dPVWdoMUo0aHhhOWZaL3ZERkhR?=
 =?utf-8?B?YngyOVc0V2ZYQ0xpazVtSVNqWjlORlNlcFVFVkxrQUJ2RE5qRU1BRGJJZUFS?=
 =?utf-8?B?WTZidHZ1NWdXVjZvM2F5a2xPZDZ2N1RyYWdUQnRyd3YxVEtVbUllaUtMWVhV?=
 =?utf-8?B?V0xXbXpGaHo1Z1FhQUJkUzR4Q3lWR2czNUE0ZjZlZlNHYmN4NVdlNHZacjgw?=
 =?utf-8?B?VkNucHRRdFAwVW1GSGw5bFp5SWpVZi9DQmZUVmNadEJBQW9MeWQ3OFRKSTRU?=
 =?utf-8?B?bUc2VDY1WmdoZGVja2U4YjFqUHQxc2o1M1o3WUlGblljU1h0THJqaElKYUIx?=
 =?utf-8?B?OEFhOUdob3Q5cmhuQ0FvdmJBSTlIUi9ldW8ycjVtVDdjRjhlWG1MekJnSXZP?=
 =?utf-8?B?N0tGUWdZRUtILzkzU1VOOCtHMmJTOW92WERQMDJVQlNUR3AwTFBNNXJ3cmVQ?=
 =?utf-8?B?eCtidERVYTZsM0FvL0dLcTVrcm1tZlFLSWVESVduNVJBMTlBM3VuZ0xnYzJN?=
 =?utf-8?B?VnJHQXlnMzhMcFp2dlVGZjhObnlJb2haRTFjZ25LS3ZkVjF4Y1ZqQzVjV3V2?=
 =?utf-8?B?eEJUQ3RwTjFVNS9tWGRVT1BybnZPc3hlcUlFdWZ1QzVESCs4Njdtczc5VHYv?=
 =?utf-8?B?OUFDNkdvY2xkS2NhVXlNdG5PVkJYZFJXMXEvZGVWanJSUEZFUDV4VzlVZDlB?=
 =?utf-8?B?bE8va0E3UnEzVldYdzA5TjhabkxLc0p2a2lpQnZNNkxmZWZ5NlBMK01NelJp?=
 =?utf-8?B?ZndudC9yOU1aYzhvMlhxUUozQ1JxVDJLT3R4RmhZUzNyMVdjWElJditybCtZ?=
 =?utf-8?B?QkE4M21SY1lJbGh2VVY5ZVdXVHhsK2l0Mk1oTWcwVVpFQVErMVZKRWd3OG9S?=
 =?utf-8?B?MkZyTUVITE9SR2pYWVJIMkgyT1M1UzYzMFFHWWZhZnh6UjE4WStNU0o2SVRh?=
 =?utf-8?B?N2kxL1JSM1krdjR6OGlxL2RUcmNCMTNRVnBLbFFyZ3JIUElyVkl0NzNSMGdp?=
 =?utf-8?B?SFJZUFQ0cDFxL1R6WmduazkxeFhsRVlrRVNWQTBJWkVNQ2tIdVRjUDRzY2FK?=
 =?utf-8?B?UG03eEZCaTJBYW51VXBReW4rcE9TSllzNnFIQnlyOTBEZ3FiMVpKVmV4UU1v?=
 =?utf-8?B?SUxvanVTcDZId3dLZXQxTzNwaTRXTEF3UWZkRTNGSFhEbHYrd3BSRFNzeWJL?=
 =?utf-8?B?WEpKVThQaWdJeVc4ZkZkbTZsMXIzYnJZREt1QnpJVDluTGRXbE1HNWVZYmVG?=
 =?utf-8?B?ZWQvRXNhWmF5a29mUnhSMGlpaWxvdXRWRjRzVFJsSUkyenFDMnI0anoyYzdt?=
 =?utf-8?B?MSthV3lJNW1zbjZkWXNuYUNIQUZ6amd5VW0wQzdLR1NIdUF2T1lTcjhZbDI1?=
 =?utf-8?B?R0FIanhFdjBEeHRUbHdlRVFOUEMxUlA0WW55a0V1TDcwL2FaOS9qdG9xY0Qr?=
 =?utf-8?B?REExa01ZaERWdnNBOGp0WUtrbERrdWcrQm5PL2FrVXBST0kxMEpoVis4clA4?=
 =?utf-8?B?OXdhM1p2ZzgwZ0d5b1ducUpsUnR1UVBzTC9jSmN3U2FaVGpnTVN3dlJvZjlI?=
 =?utf-8?B?Zm5GaytoYUY3UnJMUkFLaUtHaTZPRTQvblZYMlcrK1lGbTlOS0ZDQW1HQmQ3?=
 =?utf-8?B?dVBQcVBXUTJDU0hibkdDQnU4UnJmL2hLUk0yWjJueTZXZ3JaSDhUMVQwSXli?=
 =?utf-8?B?a3B2L1J0YnoxWnlpakdlenovYkF6dXRHVExpMjNwVjJGckhjWVJvNmxOMFZM?=
 =?utf-8?B?L2RNZmk3NkVSOWg5VGZQQkJYMm9JejRJNUNhMW5RVjMxN05la0p3Q0thL1dY?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a7hO14QrAjBf4K5rZ+ZplpMNMjBMEuapmvfULoSyJpzjHHXGlxTiN3k63FAjgGmbupTD3D48LwAQKPPKSGpSk2BPzJsxom1L8Ecfzlc8fdZs9i+Q2wnEKk35BEUoRnqF+56tXqkb+LSr1fpK/8nF2Tibwapcgih46UiEsWjDJASLkxsH5BLmOhJKUGTpiKISdmHlr5GMtoPcQEVnBhb37EbZXUHVEi8uMnU9mx+X+uJCue2W/W5AkMFa4BrOqrAe2H4ssCfUd+dHvuLynOXqcNtkDCtIpgST/vaRAvR8Pv8aduEbR5Q1BSj+QvAvKqk+u7EZXTh4pCBAQhiAhpCuQKRv8aUgC3HGQ5XNYTLt7EYU9KDcJYrCM1BXkyELDO7c8R0CzvXTp8u/39FkSIzhRvqAkUJVyaN2Z9xcIfr8dtfKBNSThZz7S70Ts38NWYcXxuRCq3ZSSqjPssImC0Yr1ztzj9ig5zy/2beNjoA/gsWQ+5LHXX09ONHJywBk4MKsc+6Z57MKzowXxFWMGKoS3vs47kn4Hhuagu92OnUHpJZmW+1b0TIcM1rhsZt/MUd4rTw5FCK8zY5AL06HfcsIiWh6QzDJYO0TEBbbTYNOH/g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f43950-16fb-4307-3ca4-08dcf388f462
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:34:32.3020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLJxkG2ECnwC7dphaMuTX7qc7S1WbFCpqpnTFYsgY9eNOCMLS9tNoVK8Eib4fTKAMUm/HNSJcMBzVkawcpsbknXr/ySZF1QDepSlQ72D7KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230111
X-Proofpoint-ORIG-GUID: RQStbmUK2VjSleoQWzRu7D8SCYwf1LqF
X-Proofpoint-GUID: RQStbmUK2VjSleoQWzRu7D8SCYwf1LqF
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

On 10/21/2024 3:28 PM, Peter Xu wrote:
> On Thu, Oct 17, 2024 at 08:14:12AM -0700, Steve Sistare wrote:
>> Complete monitor connections as early as possible, prior to
>> qemu_create_early_backends, so the user can issue commands during the
>> precreate phase.
>>
>> Make a list of the chardev's referenced by all monitors.  Create the
>> chardevs, then create the monitors.  Exclude monitor chardevs and
>> monitors from the later creation phases.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   system/vl.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 77 insertions(+), 4 deletions(-)
>>
>> diff --git a/system/vl.c b/system/vl.c
>> index 3c592b9..a985ab8 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -1939,6 +1939,11 @@ static bool object_create_early(const ObjectOption *opt)
>>           return false;
>>       }
>>   
>> +    /* Reason: already created. */
>> +    if (g_str_equal(type, "mon")) {
>> +        return false;
>> +    }
> 
> Why monitor are part of "object"s?  I thought it was only registered on
> qemu_find_opts("mon").
> 
> Same question to object_create_late() below.

Thanks, my mistake, I'll delete it in both places.

>> +
>>       return true;
>>   }
>>   
>> @@ -1956,6 +1961,68 @@ static void qemu_apply_machine_options(QDict *qdict)
>>       }
>>   }
>>   
>> +typedef struct NamedElement {
>> +    char *name;
>> +    QTAILQ_ENTRY(NamedElement) next;
>> +} NamedElement;
>> +
>> +static QTAILQ_HEAD(, NamedElement) monitor_chardevs =
>> +    QTAILQ_HEAD_INITIALIZER(monitor_chardevs);
>> +
>> +static void chardev_add(const char *name)
>> +{
>> +    NamedElement *elem = g_new0(NamedElement, 1);
>> +
>> +    elem->name = g_strdup(name);
>> +    QTAILQ_INSERT_TAIL(&monitor_chardevs, elem, next);
>> +}
>> +
>> +static bool chardev_find(const char *name)
>> +{
>> +    NamedElement *elem;
>> +
>> +    QTAILQ_FOREACH(elem, &monitor_chardevs, next) {
>> +        if (g_str_equal(elem->name, name)) {
>> +            return true;
>> +        }
>> +    }
>> +    return false;
>> +}
>> +
>> +static int monitor_add_chardev(void *opaque, QemuOpts *opts, Error **errp)
>> +{
>> +    g_autofree char *chardev = NULL;
>> +    int ret = monitor_chardev_name(opts, &chardev, errp);
>> +
>> +    if (!ret && chardev) {
>> +        chardev_add(chardev);
>> +    }
>> +    return ret;
>> +}
>> +
>> +static bool option_is_monitor_chardev(void *opaque, QemuOpts *opts)
>> +{
>> +    return chardev_find(qemu_opts_id(opts));
>> +}
>> +
>> +static bool option_is_not_monitor_chardev(void *opaque, QemuOpts *opts)
>> +{
>> +    return !chardev_find(qemu_opts_id(opts));
>> +}
>> +
>> +static void qemu_create_monitors(void)
> 
> Would be good to add some generic comment on why monitors' chardev can be
> created earlier before the rest.
> 
> PS: I'm not yet sure this is required for the initial support for
> cpr-transfer, as there's no chardev fds involved yet?  IOW, I am curious
> what happens if this code init all chardevs instead of monitor-only.

Sure, for now I will simplify this and init all chardevs early, and add
the filter in the future series when CPR preserves chardevs.

>> +{
>> +    qemu_opts_foreach(qemu_find_opts("mon"),
>> +                      monitor_add_chardev, NULL, &error_fatal);
>> +
>> +    qemu_opts_filter_foreach(qemu_find_opts("chardev"),
>> +                      option_is_monitor_chardev,
>> +                      chardev_init_func, NULL, &error_fatal);
>> +
>> +    qemu_opts_foreach(qemu_find_opts("mon"),
>> +                      mon_init_func, NULL, &error_fatal);
>> +}
>> +
>>   static void qemu_create_early_backends(void)
>>   {
>>       MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
>> @@ -1994,7 +2061,8 @@ static void qemu_create_early_backends(void)
>>       /* spice must initialize before chardevs (for spicevmc and spiceport) */
>>       qemu_spice.init();
>>   
>> -    qemu_opts_foreach(qemu_find_opts("chardev"),
>> +    qemu_opts_filter_foreach(qemu_find_opts("chardev"),
>> +                      option_is_not_monitor_chardev,
>>                         chardev_init_func, NULL, &error_fatal);
>>   
>>   #ifdef CONFIG_VIRTFS
>> @@ -2020,6 +2088,11 @@ static void qemu_create_early_backends(void)
>>    */
>>   static bool object_create_late(const ObjectOption *opt)
>>   {
>> +    /* Reason: already created. */
>> +    if (g_str_equal(ObjectType_str(opt->opts->qom_type), "mon")) {
>> +        return false;
>> +    }
>> +
>>       return !object_create_early(opt) && !object_create_pre_sandbox(opt);
>>   }
>>   
>> @@ -2045,9 +2118,6 @@ static void qemu_create_late_backends(void)
>>           exit(1);
>>       }
>>   
>> -    qemu_opts_foreach(qemu_find_opts("mon"),
>> -                      mon_init_func, NULL, &error_fatal);
>> -
>>       if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
>>           exit(1);
>>       if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
>> @@ -3730,6 +3800,9 @@ void qemu_init(int argc, char **argv)
>>   
>>       accel = configure_accelerators(argv[0]);
>>   
>> +    os_setup_signal_handling();
> 
> Didn't immediately see why this line.  Some explanations / comments could
> be helpful..

The TERM handler must be installed before the qtest monitor connects, to
catch failure during precreate.  Previously it was not installed until
qemu_init_displays -> os_setup_signal_handling.  The latter is still called,
because of the comment "must be after terminal init, SDL library changes
signal handlers".  It is harmless to call os_setup_signal_handling twice.

- Steve

>> +    qemu_create_monitors();
>> +
>>       /*
>>        * QOM objects created after this point see all global and
>>        * compat properties.
>> -- 
>> 1.8.3.1
>>
> 


