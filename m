Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827FFC52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 20:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbRAK-0005k3-KK; Tue, 06 Aug 2024 16:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sbRAI-0005it-DX
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 16:52:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sbRAG-000152-94
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 16:52:18 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476Eb1vj023462;
 Tue, 6 Aug 2024 20:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=nIITzeQ9v3qpO6OCGRgTrjOoxBLMfqZh37b5vaujB28=; b=
 A1Aoss5xwDVPyCmO/zPUhQCPugInenEJ2JuCAQRbwUh2M/HbH2EVV8H859UNQA3Z
 HoyuvXNaGGCUIrgC1VMO5iedZnNoOc2UENBiizizDpDK20akzCyXz0sSan7xNr9d
 aky9xlWvBE7UeKOcv99eYVBkFPiwd1rSM/lNkNTb8wQ9mfwtE0+H5fKB+WrWKHBL
 8x/v9ET1grKpRpujeH3yPmlCVX4NzUvuhWKovYxu1zmqw3bNFnLfzQkWSSuazKaq
 NCkzlq6ChnUuP8SmKaSJR0YwIi2zcQPYuDrLz5xeIucxsQhqxEYw3/GAJgT/2aaS
 vPO3PAnny0RMmq1b4h01vQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40saye69wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Aug 2024 20:52:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 476JgJWZ019687; Tue, 6 Aug 2024 20:52:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40sb096f5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Aug 2024 20:52:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2YuZO5PnZDJnzVY6VQ24Jk5dNYaYs7d31+WPiRA7R2uZ+D4A/B5PWRuD35mu7Ao/xbENWTLr9NySAf33KVmBVuF9JCVVsnAtXXP0K3gQ9Kx3efrhYWTkF/6fV937VkbDWcOZ3lUEEgWSWXLccZqFt2tAwiwQO1L04sDYY2e3SIdyfoyCgJeUvk2mAI68ROEnoent27z3fPTHH+0r2+erVNuxYpLkTwJ5dO383YxGRyZRGGd4IJk3RuC1XZq740xOa4uy1YVI1fgDcFsWc36OaUacAVPGTmOriHVNslt79qKArQvxlH/Z3YE4lhN+Z/s2oldodnwnKVYDn/Q1QFGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIITzeQ9v3qpO6OCGRgTrjOoxBLMfqZh37b5vaujB28=;
 b=xaEfK/MtOGn7e/R3eRLAYDs2HFi9Blu7IDUA1/WhcF1GnKSsfEphfZhdE/Zb3y9/LqAvH3BdmzNpm6Ll2OnWu43KHKT5+Q9JNFKXC6/CYw3dpzCrku8kxbcC/hBWedfaiL4NTbuFHNoi+z0KBvHN1J268EBakaxVcFkbhERJJGJlgSxSTi4phEuFwoo0n6gs0DkMMhtkYR/T5qGeEtI++vxoILnpPqJUo4JpXawo/03RpzG4dqOT3p8JiAGeE+mx/7j/Y8ZycVAAwtuS8jFHRkliSIVG/TtbHOx9u1bbTWBfPMtFIwW/pfBqbyeLRoi2rytElugqsV8hvOBiZOYTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIITzeQ9v3qpO6OCGRgTrjOoxBLMfqZh37b5vaujB28=;
 b=Ro7ML2RjUUplp2xqgHbh2a8yJtBMK/OcWB2TNJ9/JbXUTCBy3nisIQoHvnDnsnAT6FXLCUTZudVbS56mlxdc+U82tCzoeC5ooiEK8nhguxUqxteg0c1nR34dZDhW2I5551jaCyXqkxloIihCMgnS1rlX2jnc+T0l5lWYIoXi69Q=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6579.namprd10.prod.outlook.com (2603:10b6:510:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 20:52:06 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 20:52:06 +0000
Message-ID: <205005e6-9442-49f0-9856-619429554a33@oracle.com>
Date: Tue, 6 Aug 2024 16:52:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 04/11] migration: stop vm earlier for cpr
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-5-git-send-email-steven.sistare@oracle.com>
 <87sew726b9.fsf@suse.de> <0d1e8314-cc14-4bd2-8d80-93f6291ada1f@oracle.com>
 <87v80xzgoy.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87v80xzgoy.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0947.namprd03.prod.outlook.com
 (2603:10b6:408:108::22) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 396dc04f-9d3f-40c3-0e95-08dcb659a1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVlueTRCVGprSjdqRXZKTXE4eXY1cEEzQzAzYmdjZFkySTZFMWs1dWsyUzFX?=
 =?utf-8?B?YXEyUzFXVzIrUTRTdXliSlNzbWhERzZJMjVFOFBQU000Z2FBMDRNRlJSZTln?=
 =?utf-8?B?SGtNdEZ1dnVpdXVOQjRTbUdOV1JPWXFmbHI0N1lDVG9HNm5ZUzRKUW9BNEVP?=
 =?utf-8?B?ekxLQy94MHprVGE4WkdZL29YbUFROThVUi9oa1l3YWVRK2hZN21GaFlydVFR?=
 =?utf-8?B?M2E4ZmtYcjNZWkhyTG1ZeTh3RmhSbzJvdnZ0UUwraVduaGg5RWhyczFiSlFJ?=
 =?utf-8?B?Tm5vU2RQQXo2aVM3MHdieEVZWTBsb2hUUFdlcndPUkpHWlhiU1RLYS9LdmlC?=
 =?utf-8?B?ZU5tcE5UeW9CelVEeFVGZzdvNlBtQ0pnckhidW5PRjlDb2Y0OXZNanRsZG1s?=
 =?utf-8?B?TTVBdTZERU1SU1dGdXpmOWNNNDN3MnRNelpxZUt6ajdBTGV3c09lNlhkODha?=
 =?utf-8?B?UGYyNWw3aHA5VDVITUxraFNXVmRLQUZpMklwV0JrR3ZtNWcxNzhiSVkwNGR0?=
 =?utf-8?B?TGlCamNXQlBLK2kxVlZ1M3JPdmNraFJTYVk2cnA5Q0lWVWhKeDFyZWNuSkt6?=
 =?utf-8?B?VlNSUDNnMHJGNTdxRVJtUUdXRituR3FMNDVQeDFwZWhwTzNSQ3ZPaHVWbDN5?=
 =?utf-8?B?aHk4SWEvQjVCdzNBWkUxM0JtajFCUlhjQmp5MU4vVTFaZ1FvTDJxZFFtdjI0?=
 =?utf-8?B?eXpsRVdTVitKM3ZOaVMrUmJXczVkbjVrQ2xZYlhkQ0w3RDhiSGw3T2FlbnM0?=
 =?utf-8?B?RU0ySm00MjJKR0p0aDdIN2k5S2F4ekpIZnFZSjZlYjdqcGdUZkRTQjNFRThi?=
 =?utf-8?B?ZURRK1V3TG5PRzhNemNyZDMzbkFUTHV4dHBtYTlybEJHMGRUNFVuNVBhYU1R?=
 =?utf-8?B?b3BwRkJVS3BodVZzTWppcVJXb01kUkV5YjJnUDY0SWtkNjdPaWxKa25yZ1pK?=
 =?utf-8?B?cmRDYXVvbWtQaHRPY05lRTJ2T2llQ3N0YytuWUY0eWRPRTVKemtQM0FZV1N1?=
 =?utf-8?B?eE82N2cwUzlYVFVQUGdBN2xaa0s5dzI5eE9CclYrdVpYV2lPSXJQREw1Ny83?=
 =?utf-8?B?T0ZYY1RaejErTWRnUTNiSnV2NksydXMydFhUYTBKZzc2SnQ3dnJJSC9EOC9S?=
 =?utf-8?B?MnhJTEZTZWQybzIrcGpLSXVlaDArcjFkUHBkK3VST1pnWVZ0OXAyQndYakJq?=
 =?utf-8?B?V2NXNWFCTytpYklZSFlWLzFpYlNVbkZjTDJ1bVY2Um9RVk84Uk5iUXFKTXB3?=
 =?utf-8?B?THRIRnEyMTU4MDVONGZLekUyWS9sbnVQYWhsMTBZN211b1JoNWtjTlB1aldQ?=
 =?utf-8?B?UXRoRkJseHNsU2plNGNITkh0Y3hMS1FzdWtBUWJGb05sZ215SEptbzdmSXd4?=
 =?utf-8?B?NXBXc0xWd2F4aXE5Q1VMRGNTMGozNHJzSGltNzFIZWhnbzg4YnFobnZQdDc2?=
 =?utf-8?B?WG9FOW9HdlRQSy9EbUUrY2lYRWhxNWpkUUZmVk1vdnRCT0dpazU1TmxNN3c5?=
 =?utf-8?B?ZkhvZ20xbzZIbTYzakVKTnExWlpNYm5pQ2FkREVDcFFEVktqWUZEMkZDWWow?=
 =?utf-8?B?WDRlZ0kzTnd4QUdSbkdVVVZpQ3kxSEZ6bGlqaFRodmdsZ3ljdlRReVIvUUFa?=
 =?utf-8?B?bmxFVGdST251MGVvWi9rL3V1VXlBb3Y4Um1pOXdJS0FPUnQxMUVJeVduVTdq?=
 =?utf-8?B?eFR0bkp0eThBanFWTHhrQUtEWW12TGtWQVZNRExhMFdlUWVidWRDeERDOWFr?=
 =?utf-8?B?VjlKZHpPNGp4RklXaEdTMUh5cjZJU0o4OURZa2poblpTWWNxZnZXblFhTXdD?=
 =?utf-8?B?UXU5MUtwTGlyTnlLQngzdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0hHdUxwY21Ha3FuUmtSVXlaUTN0K2xCK0JOekUySStiK0Fab1E2eE5zb0dP?=
 =?utf-8?B?M3poa2NzYUhsL09heGxMK0N5ZG5BWUdwTXkvbWRORHpxd01uR3ptNzdKTm96?=
 =?utf-8?B?WUpWQUxDaWFBOGxsbWhiSHV5U1N5bXFWbDJSRDhqNzlkdm1hcTl4Y2orRHlp?=
 =?utf-8?B?ODg3QjNXRGVNbDlSNitYSmQwWGZnQ2VuM2pRQnhmZVN0cHRuWnQxNEJySGdH?=
 =?utf-8?B?YVBBVmpLc3dvYmNiWUFvODd2YVpuRzlOOVkvMloxNUtpMFBmZzR1ZmV3cXUv?=
 =?utf-8?B?bjZ3MDhpQVZDTVRVa3d6N25aNnAvT3h2OUkzcXptak1HdTB6aWFGOEpXTHdF?=
 =?utf-8?B?SW1pakFJSTY2bXVDaDZzckh0dm9ac1hkb29wMlNDUklnTWZOc24xeEMraXFM?=
 =?utf-8?B?VTlnek1GTVJYYkdSU29OL2FMcGhJQk4rYUV0aTdIYktTM2FQdDFZRXZOYUQ5?=
 =?utf-8?B?L1B2azlOM2swMUlkQUZmWmNuV1JKUFFMdGlKYm5XSFZ6N2pRWTNTQTdsdEdI?=
 =?utf-8?B?R3RTRVM2SFN4MVA0YUh1Q3JoYnNrNE43OXIvMFdreEZtdW9tc0xPV2RmeHZQ?=
 =?utf-8?B?TjNMODEyVDBYK0YzL0VOcXlLRnRoYSs5bG02bmoxUWJVSjh2QzJpbU9CZFRB?=
 =?utf-8?B?cDJGbFpkTXJiTThjb0dSdWFlVkJXWlBLa2IyWWdvbmpPS1djM0VEVGVBQ2ZZ?=
 =?utf-8?B?VEV4R1RibjJMd3NKUEdFaTJqMkZjOUpDWGY0ckpOaUpEZHFmTFpKMWNrZmMr?=
 =?utf-8?B?UElMZkZHeU92UkJrSDZieHorcWpMdmFaQ3lzSEtDVi81bnlod1hhckpKZERU?=
 =?utf-8?B?WVBwT2FQMEovcFcwb3QxdGZ1aEN2YzJha2ZtWTMyeWI0eVkzRU5pNjh0VUFp?=
 =?utf-8?B?cUY1VHRiOG92THlENXJiaWFCa1BaSHhmUEpwZWc2N3JvdUtTbnFpZ09wcE9P?=
 =?utf-8?B?Z3pmNE9nSSt5M0Zra3BrSC95MFRCZDYzaWdheTUrdzg0MkkvSVVuQyt6Yi83?=
 =?utf-8?B?Y1FUUUtJblJnU1I3SnM2YWcyek1RTXVzM3RIMG5FK1FraTFFVDBRa2I0UHVX?=
 =?utf-8?B?cGxsaTJESlkvZFVoeFRQWmY5dmY4Y2RqbktqUWxaZ3pJaE5ZRjNTeC83UkFG?=
 =?utf-8?B?R2Rkd1pMcHl5QytjQnpvanZabEYrWWhIdSt4eDhGU3RnMlRjYUE1L3lWS0p0?=
 =?utf-8?B?VTBNdlYxZXhlMzhJakZ3OVM4elk4YkUrTmhtcm5TUis2VlY5K1NuN0Z5R3BU?=
 =?utf-8?B?eEc2VnYzejF4WURLM2VUZTVCa0xUczVIRnp3TUtIN1F2bG9RbnpodWtycjV3?=
 =?utf-8?B?cFdnRGFhYWV0NVU0RE1YWEtXNjRHaHoyVm1wNGZHTGdUcXY3UWV3b1pjMFRm?=
 =?utf-8?B?dncrK1NMTm9ZNGp3VHd2N3prWm5VWkhjV3IrS3ZJL0RxYUtrdURJSEgzK1lW?=
 =?utf-8?B?UWlMeTd5dW9MM3g1b1EwQkFucGNTalB5RzZMVDFXTk8zREVMOENCQTd3VVVB?=
 =?utf-8?B?SUROMWkydTJaSytISmhBbm1ncXlUSExGdXZLL1V3MkZUcnpFR1RlbWxvTjF4?=
 =?utf-8?B?ZFYzMkUzWEljTjNtOGI5c2JBQUgwN0NjdWtNSkluWVR3WDhUS0cvN1ZqbmJ3?=
 =?utf-8?B?alNzenRRMmlWaTJnNUNlbkhXQzV5Y3kwVkwyU2xaK29XZ0RTVzBYSk5SUXJH?=
 =?utf-8?B?T1J4NU9LNDlvZk8vVEVNR3hhbDYxTi8wTWxTemYvQm43dXdQWExKcWE4V0Fh?=
 =?utf-8?B?L2ExdDFrUkNQOTFQcVY5b05TTzVPYU9YcmtpNUxjc0RHZXp1WFdIU0hWYTJS?=
 =?utf-8?B?YVpDRTZzYlIvYWh3VjZQcC9jdENVb083VVh6LzBlWjNWWDhhMWZPWVVoYXY2?=
 =?utf-8?B?eS94amxQYXBlR1JwT3dSVlh5a0ZGN2tlT2g4cFM5OTBQNTNYSC9kVnVGdUly?=
 =?utf-8?B?WmhCQkxmekFTYTE1MTdkYUV4ZW5EYjRrUm1HSzVPaXEzdi83Z25lZ2VzcE55?=
 =?utf-8?B?M2pSaDFtOVJVeTlmS1V4ZTdxMEZvVzNzMUZGaTNySUZnUTVOU2VMTURIMFdZ?=
 =?utf-8?B?V2lKajdqS0RsblhaeDN6TnVqelhRWFVHQmlRdFduU0J2Q1ZqZ2FIcDk4clpJ?=
 =?utf-8?B?SjI0WTB1Z0F2QXM5ZjlySnpYYlE1SysrZzk4NmZxYm15MUljdlNKa1FMZ1pK?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /qG5NT42OzjNrfMAZ7WoQ30hm8ay6MkZhQa0fpNv/uopdXJbu0+bUK0BH2vc5vRhqVrLVmqwB97aF2zZmobCrD9swNLxN5WCKoiSxyhXzeCWwWrqOxFxphCNN6DKak9Kn6wJ9tjrYSLYA6qgCfrzSsF26skn9F0lnUaa3mfX4X+wVp6zxqR6B/212ZsmAy+MP2R6Vq+Tx2IZCyoy1U8MzEJVRXA3rOOMpct53fUs/L7L9JSWajlHzdi/SVpXpjO46PV4jt69gtfecURNs7y0P/UjB7dV0TFhIxZrgDx6DYwFROYx3BHTGdOkDv9Zy9l3U1379fQkdpMjKt1RPcmjTZjx90QuIORBtzBVyIVxXJvU2FrWD8JbxzJfjlo+/79+6r4a6y7A7AM45eVxvFTVrrPlGd5BgOhejkhmj75dT1VBq51TfoaeM1PfLDAsRgdI7CnmyYH6ZKm6zlUElrgbNrSOlvgYTm/7xcENs+sSSDZIBV6bOdWjeLbz6LSpL20UbBRBl314nYWs8H18Y/1gjvkyK6ogtjS0zgrMJotHKoQBFHCLGAaJcU5O+2fTg3Fk6+WU8Uu59v0S46RFT9kHKiARx0bYCEldHEIIGOxrerw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396dc04f-9d3f-40c3-0e95-08dcb659a1ad
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 20:52:06.2269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNUwk/0E3vxHHytpdB0y08HgyX/a8my1HGOj5y1M6Jr4RuRH/qtMO9PBgZ5Pk8KezbomAnXjcoyQleKyH2eJhpr/TpIjMca/g58QRthLd40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_17,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408060145
X-Proofpoint-ORIG-GUID: S9BtYLNqVgJAWvzf4uUleBkFs7xJOo7E
X-Proofpoint-GUID: S9BtYLNqVgJAWvzf4uUleBkFs7xJOo7E
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 7/22/2024 9:42 AM, Fabiano Rosas wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 7/17/2024 2:59 PM, Fabiano Rosas wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Stop the vm earlier for cpr, to guarantee consistent device state when
>>>> CPR state is saved.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    migration/migration.c | 22 +++++++++++++---------
>>>>    1 file changed, 13 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 0f47765..8a8e927 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -2077,6 +2077,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>>>>        MigrationState *s = migrate_get_current();
>>>>        g_autoptr(MigrationChannel) channel = NULL;
>>>>        MigrationAddress *addr = NULL;
>>>> +    bool stopped = false;
>>>>    
>>>>        /*
>>>>         * Having preliminary checks for uri and channel
>>>> @@ -2120,6 +2121,15 @@ void qmp_migrate(const char *uri, bool has_channels,
>>>>            }
>>>>        }
>>>>    
>>>> +    if (migrate_mode_is_cpr(s)) {
>>>> +        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>>>> +        if (ret < 0) {
>>>> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>>>> +            goto out;
>>>> +        }
>>>> +        stopped = true;
>>>> +    }
>>>> +
>>>>        if (cpr_state_save(&local_err)) {
>>>>            goto out;
>>>>        }
>>>> @@ -2155,6 +2165,9 @@ out:
>>>>            }
>>>>            migrate_fd_error(s, local_err);
>>>>            error_propagate(errp, local_err);
>>>> +        if (stopped && runstate_is_live(s->vm_old_state)) {
>>>> +            vm_start();
>>>> +        }
>>>
>>> What about non-live states? Shouldn't this be:
>>>
>>> if (stopped) {
>>>      vm_resume();
>>> }
>>
>> Not quite.  vm_old_state may be a stopped state, so we don't want to resume.
>> However, I should probably restore the old stopped state here.  I'll try some more
>> error recovery scenarios.
> 
> AIUI vm_resume() does the right thing already:
> 
> void vm_resume(RunState state)
> {
>      if (runstate_is_live(state)) {
>          vm_start();
>      } else {
>          runstate_set(state);
>      }
> }

Yes, thanks, I do need to set vm_old_state if not live.  It should be:

out:
     ...
     if (stopped) {
         vm_resume(s->vm_old_state);
     }

- Steve

>>>>            return;
>>>>        }
>>>>    }
>>>> @@ -3738,7 +3751,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>>>        Error *local_err = NULL;
>>>>        uint64_t rate_limit;
>>>>        bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
>>>> -    int ret;
>>>>    
>>>>        /*
>>>>         * If there's a previous error, free it and prepare for another one.
>>>> @@ -3810,14 +3822,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>>>            return;
>>>>        }
>>>>    
>>>> -    if (migrate_mode_is_cpr(s)) {
>>>> -        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>>>> -        if (ret < 0) {
>>>> -            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>>>> -            goto fail;
>>>> -        }
>>>> -    }
>>>> -
>>>>        if (migrate_background_snapshot()) {
>>>>            qemu_thread_create(&s->thread, "mig/snapshot",
>>>>                    bg_migration_thread, s, QEMU_THREAD_JOINABLE);

