Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955AAC8303A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWbwP-0005TC-8p; Tue, 01 Jul 2025 10:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwL-0005Ru-PK
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwH-000279-HN
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9Uuf027100;
 Tue, 1 Jul 2025 14:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=YCXL4IlTeDwUdjbYBessnLch+W9GT/7ujXOw551yB0o=; b=
 KaEBzKRfdkrXfLDhKnK4IAezbJTmUyqIg/MU7lpLMqTT3cOjzaWeLjmuM7iiOE9V
 BLGt+8T89moQsdqzGkQPrh7Tv0lZybFtV4sxOHhKz1T/0e+seGi7Jq0gBCt9aOLL
 Fg1SAfKnhlVVKT0wLp0qTl128YVpyxbNSB9cmm11x0Zn5+Mmm9lfEib+Xsk6ZFNA
 4xhcUiqs5nG+1PZg1dyjb8IaHYqLuJe3z8uEDF36l9EwvuG6ZZZxHrlJB80Dg9vw
 WYStw2w7NbeUuOYHptWpUYl0HbDb6RU9LmIhpuJQlojBPcSCpNEqq4mENHO6QKe4
 ckkbSEjlN0YymmFCMFxClw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7v6jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 561DWIS8019320; Tue, 1 Jul 2025 14:25:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47jy1ekn2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:25:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQM1BTfaRU4roISpgI0ZAIVtPJ283y+chcXQY9G4oIR+H6Nqid5xRjmhy/giZprzjMPya2iCAajC6/LqtIx83tNbFIcZVqmEABzYaLMYxdyV5SGYNL5TfhtGNjDVN4aBbAap7KV5ofw82HTmW4d6JsumV+RuFmB2xDNDeyF70G4ifq+aOUrH2kTCxgrCdroDi9Xlktnaykg8uYBWoM026gUPYxPvnzYM+O9kjHRA5zPN2E/RhFP5dc/hlCsvfgZQR6AvmlbDIZQY+Vq6l6RQ7+UEho9tNt0pSaRrxWE++I8uDwfTl3KekCuraVo48DaUpR+6vjhqlJfr0425sJaNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCXL4IlTeDwUdjbYBessnLch+W9GT/7ujXOw551yB0o=;
 b=jeYgxPw+dT/6Pc1C8o/2OerCRW0empFkeQOBnK5jixaD0rLODV39IgkvB6qtu2hrUboi7a/San45aKBTCF4SJesFecyvcIzEDh8hPw8aDeQqVKMcxLLOsnkQGmaLeA/tmLqxiUMiaW7tnrztj7AmxcTqxdg+PUYuSM1Yg7xRZ07T5yChSB24VhMl3f1Ey2m/V9jRpVlgiRBkKHTaHslTuB1VXl9Svck34v87RZp2QlxuBnFocVk5xJSj4rYJ7L/mfLpyzrOcmCEQUGJahWrBZ2LgCcW+oNwN/UXwMKx1pRKqQsSfsMW2957TCc8F1r7rFsWw338SNBIf+COWwPTshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCXL4IlTeDwUdjbYBessnLch+W9GT/7ujXOw551yB0o=;
 b=Iq6w7t6bQ3Y+x1L9h0Ad070CKJsHlklrX1AOvxw1Etzi2CGaaBFKhDmDLnTYd9GaD/9SP0e8HlklF03IKNAS/tAk+p+30k4SKKVyUsZs20f00GML4kZRPsAJbSir1o2GG65KiSAVKZKo3Iu6VfRDx3fBLUoGTUBtwbDAt7lwgGM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7088.namprd10.prod.outlook.com (2603:10b6:510:268::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 14:25:50 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 14:25:50 +0000
Message-ID: <9386dfd2-6793-46ab-a2a0-c50f98379530@oracle.com>
Date: Tue, 1 Jul 2025 10:25:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 04/38] vfio/container: preserve descriptors
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-5-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136FA577AEC8E5D138B0E249279A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136FA577AEC8E5D138B0E249279A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: c91143ea-8310-47bd-f49e-08ddb8ab2dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K01TaUlHNEZkaU9EWWdwRFh0dE01KzlhUnNnN1NPVHpzdXBxRmNIK2dJQlBG?=
 =?utf-8?B?ckw0YUw2L1NrZW14dHFjbnpta0JOTTc5NVhaOVlSUTFSK09TMjhQTEF0Yisv?=
 =?utf-8?B?NUpxSitJRHc4aFVPMFR2ZHRFV0Z1M0JTSHV1dWxOazFxcnNvNG55NDRnODNW?=
 =?utf-8?B?VlhXQS9BQ0tLR3V4MVZ6Z0ZMVng3TWY1Zk9Ka2UwQkhGQXVoL0lTRVE1NU9O?=
 =?utf-8?B?OGRpMnM3Yld6UmpFRC83S0RlYlRqTnRvalRaM0tZdXZYTUdNdHZhRlJXMWxX?=
 =?utf-8?B?dHRCNUl3V0gyWUdURWc3T2dqYXYzVHFLU240Sll1MzRDcE50SytpYUtheTNv?=
 =?utf-8?B?anVSeXNWZVlOZnNBNVpGVHRGQVlQSXJCb25CajNiZGo4amROQ2JNMU8rczFk?=
 =?utf-8?B?dXJXcXVGekdhN085V3BwTTd4YkVIajNIbkl0UUdmK3NudUdyL3BoNUlQN3V3?=
 =?utf-8?B?YmJ3b2V5SGRvTVEzbEVickY5WmpxY09RU05uS1JtaHJneGFpM1RpVVZQNTlp?=
 =?utf-8?B?bUhpNUNONTIxNzVla1ZLMnhadksvUHJVOXBHMUZqSzZ6djFwY3VpUlprdWZM?=
 =?utf-8?B?aW0wa0dQWXhvdXZjVk9lbXUzbmVLT2xCME5kb2ZEMDhGdEhuYzF0aDkwdkxR?=
 =?utf-8?B?aFgyNStxSk12SjVpeVVqTXZucVRmbUZPWlZ0WDRRTUw4SkFqc3JMMVY2WGJq?=
 =?utf-8?B?T0tkTm1jbEN1WUUyVDlQUHNsYlBpcFZiUzRTVkNuUWRadHNhM1phMVJkRTNS?=
 =?utf-8?B?Ti9UaEVibUV4VjVvaUhseXNzZnY3Y3prTWNLaVRJZVRzdzZSb29Bc21EVnBJ?=
 =?utf-8?B?N1lGRDd5SUFmUVI3Zy8vR0Q1T0N1eXh3S3BXY09vYjRIMzR5N0laTldpa0o2?=
 =?utf-8?B?Tk5WeDNkbFRSZmxNT04vSGVSbmV6a3U3bGdRUXVwaDA1aU85UE1LREdNdUJ0?=
 =?utf-8?B?Z3paSUZSNFgreEJMT2s0cndhb3V1U3RESXVLdHIvcHpJOHo4d1Z2cUhINm9N?=
 =?utf-8?B?T2RuWk5RU1NFT0lhUVR1THhDNDFNcWp1SENRSzhDQ3plbzRVUzVCRGhyUWlw?=
 =?utf-8?B?ODB0bTB6bnVkOXEzMzdWS1VkcDNXd3JTQU04VWQwS2pVZHZWQ1IyQWoxQXMv?=
 =?utf-8?B?TUJBSTE4ODFHR0xxUzA4TkNrZ3ZNS1F1bVM3eXFnQWJmdUZPc0JVUlV1TGly?=
 =?utf-8?B?dkdHeVBvelFkTU9QVE5vc0VNM2dzcjV4NU1EajBnZkZQZzhySDl4L1A2b2Zi?=
 =?utf-8?B?K1F6VXZ3V2huTnRxR2c1dFpUbmx4NWNUM09rVldUdjAyVWppZHlvVlZ4djR6?=
 =?utf-8?B?VEVrUHRJb1lSY000Y0JJdjhQODlkeUozZ3FLTk9McFUwL1paUU90M093Wmdh?=
 =?utf-8?B?ZlVReUpFa2tyVW8zUkVmK2dNUHlESVl2K3V3ZXIyMUpaMjIxcHlEZmMrNkw1?=
 =?utf-8?B?a2xvdjlrRVhzZnNnQmIyRGtQT1ZKd00yOXExem43b1JNMXBCcDZvYTdJYjRO?=
 =?utf-8?B?Y3ZUSHA0aHdwVytSa0JrZExxbWhHSElWczNCNUw0emdNdkE5cTBXM2RibXRQ?=
 =?utf-8?B?TDY4c3c4ekdtQStGUFJoNG93MTVtYlZPeWxWK2t6QlUrRHRkZGJVL1p4TTk4?=
 =?utf-8?B?ZzhuaE5WUE5nL2t4OTlMNVB4SUVsa05NWnNXUElyekEzQWZrTzBTVDFHYTAv?=
 =?utf-8?B?QVc1cWsvVGwzU3IxSmZ1VTBzUS8yS0ZLYW0xM3RCUk9FWk9TaEJDTzRPVkFo?=
 =?utf-8?B?eEJmRElVRk9Xakk4ck83K2dCdnNVRks5dkVnazVmWk1ndnJ4THF1YkRycHkz?=
 =?utf-8?B?bk8rYnVUUEdlTUpzNVRvdnBXdG5RUXhGYzkrTnhRSUp0RWZyemhVQ3Jkb3VR?=
 =?utf-8?B?OFhHcWk3aUNZQ2NRdXNTV0xjaGNJMW8wM1pFaDczUUV0WFJ5ZGVtdHlaT25n?=
 =?utf-8?Q?ziQwPR401+I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZWcE95emdSSjAvN0FUV2ZpbUM5S2Z1cmxac3YyWXpyVzZyanRLL0FMSGhl?=
 =?utf-8?B?ZkdmNlNqOWtoZDNTVmJaWkpTQ3VjaVN1RmlGMnBPcysrcll5UTE2L3BHMlhr?=
 =?utf-8?B?WkduQ2lsU3dIQXdCMW5FWlkwTnBHZ1J6aGU0YXR3UkZXTTNRR3NYa1dPajdM?=
 =?utf-8?B?NTZXcHVpU3J4WGovU0J2RExYdGVBNXM0VmlEU2RlVC9MeXlGMVNjMEFDaC90?=
 =?utf-8?B?V21ML0lnUkRjcU10VkxScWtBV1UwemRQcG81TnZaOXAyVFBiNEVlazZaZ1V3?=
 =?utf-8?B?SFZtNytqenV4OHlBQkR2VkNlRTlYSkFUYWV1OGorMVJWL1dUUTNwWHlsUUJk?=
 =?utf-8?B?dFBrZ0t4ckx0VXIvNTJJVFlweEgrK2sxeGYyMkRMRTZmMms2YVJYSndxa1Qv?=
 =?utf-8?B?ZDRKTk93WUZyN2FHVWptK1BmcXBkeTdOWjArbmlLckZRZWVxSExsQzFScXBs?=
 =?utf-8?B?VCtOM3A3OHZlQmRVemVCVXZ5SzFTckk5MFVhZjN4YjlkaWp1aXVxbXdnT0Qx?=
 =?utf-8?B?eFIzcSt2VWNQRkwzOFdjMWs3d0lHckQvSngwVzhmbWhtQnh6T3Zkb0tyN1VX?=
 =?utf-8?B?YUJ4QXBlbWxyY1ZIR0MzaGQycjQ1R0RMa2tBbi85OFFCSUIrNitRc044VGxD?=
 =?utf-8?B?eStTNlh6T21XYnFHcG1wTkt5bmN1WlRKYnZKU25zZ0hSVnpvUGlsRWhScWNH?=
 =?utf-8?B?eUMrRVE4T0JFWEhFUmU3Z2taTGQ5T1BHNGZHbUNQUWVZVU01d2Z1TklTUjFp?=
 =?utf-8?B?SlJaZm8yOUp0UENWc0twMENldXpDRnFYSWh4WWZ3enlBRGFKU1ZoU1RGOHJq?=
 =?utf-8?B?M1NFTmFQS0UxS1dOVkVhTTc5WkZDM0YvSFY4OHNsR0tqcDRZQmN6SGI2VFFa?=
 =?utf-8?B?V0l3OWVRaktBVE1Uam1OQjZmOEkycSsvTktMaVZIeHJBanlrcnZtN2RJd0hF?=
 =?utf-8?B?NWJ2THNubVp3MWxldUVRb3pCNytXQ25mQW42ZmJObXFMc01vSnRlZE00aXd3?=
 =?utf-8?B?VXhJeVg1VFZBLzdsZzlPSkdqNGNKZTgxbkd2Nmk0K2FTWCtla2N3cTBQVlpr?=
 =?utf-8?B?Q0NHSmd0TU5SN21WdmxwQmpsK2JOR0JSQ0w5aEJsTGhiWFBHUktmKzFXazZx?=
 =?utf-8?B?QWVHeTNKOXRPSVl1QnFubFNWRVowRjEzMnc5RWhZZUQxWmYvY0tnejJTbGVr?=
 =?utf-8?B?OWJIQ0lNL3RpbEgzMkhaUnR3WE44YkZiMEZWakFqa0JiL0ZBK1FyNVNLd2Nr?=
 =?utf-8?B?R0QxdnJrR1B2VmJiZEZOcnlRNzBUOTVGWEo4ckxFM2g3ZWRxOEpZcndKYUtx?=
 =?utf-8?B?TnY1OFhiUy9MQXVML0l3SmRKUnRuUDdJYTM2dWhJNUIrWllQNE5NS3ByekFC?=
 =?utf-8?B?a3JTWnpFcVUyQ0lRcWJiQkpaMXg4eU1qWWIyeDZBQjJacDhuUy96Yk1QWnVP?=
 =?utf-8?B?K3lBQ0JUZjRMck5EakV4OTFFRkV1eEJFODhjRDN6ekt0eHc1QWtiTU5aYUhK?=
 =?utf-8?B?cFJWZVhMdXBnYW5LNHJaRjNRZnE2aUV5QU94d1JtaG85UFUvdFBlK2trQjNG?=
 =?utf-8?B?Y3ptc1NiUEVCaXg2cEpEakpxTnh4UENldUc4ckdIYUhiZHI3eS83cGY0ZGRG?=
 =?utf-8?B?a2pRNk90RVZCQTZoelpPcFJWbTRxdzY4bXVnM2xQTDhYeWJWRCtzTmtQRXZw?=
 =?utf-8?B?RlAzQzlWMFl1SkFkNmlNK3ZYNlJTd3hrZVJOMWc0dGg2b21ERXdzWGkyMG5U?=
 =?utf-8?B?bXdyY0grMit1N083dUkvZzcvODNYK282elBpNVkzVUptK0xLNkQ5ekhzRGdh?=
 =?utf-8?B?dUNENEF4SFpHWmprNnBCWUQydDY1TEEzazh4aWVDRWgzLy94Z0VLSW5yZG96?=
 =?utf-8?B?VExXZmxhZnRzU0h3TC9UV1ZLbGFkeXJxeElCOEZoajZSaXFPcWZ5QjBXZEtB?=
 =?utf-8?B?OThHTlFsMHFLMmJZWURocU9PSmhzMy82c2x2Y2JjdUxWMDdxc2h1WHNJVjNz?=
 =?utf-8?B?R1ZxT1pNaVdoNmFydmQ1eGthM0luUURrSUpxVlAwK0J6Qzg3amdBd08vdm5J?=
 =?utf-8?B?ako1WVc5MXRiUDRJbXlzclNlRGc1TW9PbFdUblkwNmRLNVpJSFVWaTJvVnht?=
 =?utf-8?B?eVJBS2FDcHlTd2VjNGExU0psZ1krUlZESTFPZll3NUdoNmM4TFU2ZitWeGxi?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uCrdULiSNxXRtdRm1zlFAU/h+6b0pbYo3dozYNw+57uAKE3oeOxpQrmgD//cLZKgLaITkyva4icpSa5D0dlhQO9fYjAnnWRNsvhEEpOl78PjXOdtlGiscVBq6HVLlYMvAEzMF3BM417jxo9vIzLA9NYs5UtjkYE81xx7RLjnX11g7APhwn9IfmMw8IxmfPVTMEQigqph3Q8kQqUuEkcJgI4fNzHEY1KmKluF9ur7tkUyDl+Mg8ydDftRvpD082vLf5fh+SiuKDYAwlWDf+GGjpDgCUXkTMCmwFmuC3kuwk/aETTKfs5R0KTmAV0DH3iwpSDUc+h1OGUe7/cLX59SjebTwPaSuZOsc0ewI8gWaBAMzcxW9SfkFrw2uU+VjrcH/b2It4w9mxqlc8JblnIJaSsTYZGelXol3U11MWAqEmTdjVK0QpFln6vJIiydW9mYO0bpv1ff0YSNXypwKgpbYyfFkDod+K5aV4zxYQGQn5U62e+g7L7tPVhzHtq0n5bLExToX8D0ff4FTOsDH+svbVUGxZ0fk1aZeMPmZVSFLyzus0N3fbUu2ZvIbJpL4YdPRyXQds84CHzhrlM4W9qwYcMPQYlKTJtYhd+B3gBm0vk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91143ea-8310-47bd-f49e-08ddb8ab2dd8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:25:50.6961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtHE4j8hypGXbJ+AugyZK//OMVgB5MzcHtySpUV38PrQHcX/WG9slbsEJ50rZeH1DF9M0EX6oesENRRVOz5xmahYmiupEP53szAZxGa3HIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA5NSBTYWx0ZWRfX3sCSTTRR+VpQ
 figDPaXyFuFaHbKpWLNO6NnSTnxUOEpBOFT6uU6n8JERvlOdTlGK053imDCztEsZjZ0/2DdhJyb
 SzlpWOHtoPoTzfLJA4gw+r7WgQylAjlggl1m9QeCnVd2TZUKWk1KilFQvhND3U0nQZeosTFSdCq
 HzLyhU/HokwuEBgQFspYvziCx1pJ3eAJRf6DqaVBuc3oEJo5kk6bb0WeDMyLvlrcSq/5hOXHc5o
 JImndzy0fs8qksb1FJ5GWp0xQ0t+I4zncQR4VE6pJmqRVheCEwWBLJo7O/O2eTgYU3TkR733KwF
 gBq8EBVDJRgZHDv7vKuBW4kmfVMBqdEU5vRRRZjds32m1PP564FAdSXbRg+IZzfouSrkbEUECxn
 0XmyKwG6Isdi17Ft1uSf3+Ruam0h5KrI97PxLrVUBaW+wHlEJEs6oHrGVwXNI1XZyiHPYG2y
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6863f00a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=QyXUC8HyAAAA:8 a=nBBuJgXPqx_nvrQxjDgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13216
X-Proofpoint-ORIG-GUID: xN_Q83yjVINAKVLuckOAzWa1PY3LAzGx
X-Proofpoint-GUID: xN_Q83yjVINAKVLuckOAzWa1PY3LAzGx
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/23/2025 5:07 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V5 04/38] vfio/container: preserve descriptors
>>
>> At vfio creation time, save the value of vfio container, group, and device
>> descriptors in CPR state.  On qemu restart, vfio_realize() finds and uses
>> the saved descriptors.
>>
>> During reuse, device and iommu state is already configured, so operations
>> in vfio_realize that would modify the configuration, such as vfio ioctl's,
>> are skipped.  The result is that vfio_realize constructs qemu data
>> structures that reflect the current state of the device.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>> include/hw/vfio/vfio-cpr.h |  6 +++++
>> hw/vfio/container.c        | 67 +++++++++++++++++++++++++++++++++++----------
>> -
>> hw/vfio/cpr-legacy.c       | 42 +++++++++++++++++++++++++++++
>> 3 files changed, 100 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index d4e0bd5..5a2e5f6 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -13,6 +13,7 @@
>>
>> struct VFIOContainer;
>> struct VFIOContainerBase;
>> +struct VFIOGroup;
>>
>> typedef struct VFIOContainerCPR {
>>      Error *blocker;
>> @@ -30,4 +31,9 @@ bool vfio_cpr_register_container(struct VFIOContainerBase
>> *bcontainer,
>>                                   Error **errp);
>> void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>>
>> +int vfio_cpr_group_get_device_fd(int d, const char *name);
>> +
>> +bool vfio_cpr_container_match(struct VFIOContainer *container,
>> +                              struct VFIOGroup *group, int fd);
>> +
>> #endif /* HW_VFIO_VFIO_CPR_H */
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 93cdf80..5caae4c 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -31,6 +31,8 @@
>> #include "system/reset.h"
>> #include "trace.h"
>> #include "qapi/error.h"
>> +#include "migration/cpr.h"
>> +#include "migration/blocker.h"
>> #include "pci.h"
>> #include "hw/vfio/vfio-container.h"
>> #include "vfio-helpers.h"
>> @@ -425,7 +427,12 @@ static VFIOContainer *vfio_create_container(int fd,
>> VFIOGroup *group,
>>          return NULL;
>>      }
>>
>> -    if (!vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>> +    /*
>> +     * During CPR, just set the container type and skip the ioctls, as the
>> +     * container and group are already configured in the kernel.
>> +     */
>> +    if (!cpr_is_incoming() &&
>> +        !vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>>          return NULL;
>>      }
>>
>> @@ -592,6 +599,11 @@ static bool vfio_container_group_add(VFIOContainer
>> *container, VFIOGroup *group,
>>      group->container = container;
>>      QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>>      vfio_group_add_kvm_device(group);
>> +    /*
>> +     * Remember the container fd for each group, so we can attach to the same
>> +     * container after CPR.
>> +     */
>> +    cpr_resave_fd("vfio_container_for_group", group->groupid, container->fd);
> 
> I know this is already merged. Just out of curious, It looks cpr_save_fd is enough?

vfio_container_group_add is called from multiple places.  In some, we know that the fd
is being saved for the first time, in others we do not know.  resave avoids creating
a duplicate entry.

- Steve


