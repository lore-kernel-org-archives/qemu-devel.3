Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18421C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRo-00084O-BD; Tue, 02 Jul 2024 01:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRg-000820-D6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:52 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRS-0006UP-Vm
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899560; x=1751435560;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CXL1syQpKOIad9/fXMROpkmvZULd+ix6vGmRY6x+ttU=;
 b=rNnfOtnE4i65sHTDqnc5Dt2Hp/bI88w9EJxsNTaoHE+1OkKowfsHHx5c
 yLyj9m/waemxHvmV2aBJMcdCWULJTt7WOek+aT+lu3ASxYD6J1igYVPXd
 zSCqrFgAUIitfidKV7VCRxheOeuQBHo1W0/A1/ej9UatL/ChnL1Y3fW90
 UMkSrIRaGnZVglQYwbe5qhADzm3l7Y1cgknQaOelD0sd8R/vMHcJI7xHB
 Gbhj/FlpozgDVTBERGdFxrWL5Jbz4tLys+JkwzmZBB4KMXyCQF+RqPEEi
 vmFW3Ub5+czk4706BThASBQnheJdydwMKJvFb58gvt1GImLBFrysWmfeg A==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15715672"
X-MGA-submission: =?us-ascii?q?MDGkg2cqgdHq59Re+sCAHUnnCmc+77mfBZ9YWH?=
 =?us-ascii?q?JDTnyBitPCAvJnE23kgVZPjD8btm0VOVSEQZtHFKJzuXpl/cKojkC0Fn?=
 =?us-ascii?q?0iK2WzQUe415277MCV7YCDybbyAzJ30/f6HJHKBlllijBuTtyv+s35z6?=
 =?us-ascii?q?jXgEp/VnqDPdhJXmChRPj1Gg=3D=3D?=
Received: from mail-am6eur05lp2109.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.109])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:39 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGSdBEojPiOsMRwQkUcYv1kqHvk/C7ftLcUMadHK44oZxoN6uhr4Y4nk/0o2M49ZA8YKAwZHk+eyK6kS4qnLBlzXSBcZnb3oqDfEER47IEd7ay+VIG5JvXt0CabC+GmaKxlQO5t/b/7PiQoiwf3/prPCXHvq0m/77XrclJard6jSlZSe3Qw9L6Nbhk4RL31JJXktcUp0cBC+z0wUPLI9g0IAYqw+JaHrLbRmt5E21WV38B+mIBJ4810eHphxpgOTOrg2N9EyZXv6sv+KXizDt+SEjIgRdp1L7cTPsTOVCYoSvA/op6rteGgqv1MlAdu6Vdmu7dIai9tL5i7R1A1ymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXL1syQpKOIad9/fXMROpkmvZULd+ix6vGmRY6x+ttU=;
 b=e0naovyCDPZjV5K+m9faC/l7OlXrNJm2lMGMUjEYXx3sH5egfWBFygA9AcMaHGYQyC7aAKOEk2gvxKGMbezV5wTfSpJDV+YFz6QuZ4bJ6J4M2A+e0fLxAqaefXBY6YkcpqEKGwqTBILuPEY4BCs/deZ/ZOFC2e2qdfzLi45Qjo9Qh8ysy2d+VLlcDphRkBqihowxHK5hXvp1F/9TFWAoScUTX41DkbEZS8fwtYXieaKZXpMmFJH0Qs9Qk14WyP15r/bONu6ipjzEOnW1YnvxcbNvlZTnq2hnSbc3HIX2Vzww/+tUZWfU65Wi+woWjKCmRkS8pczFaP0PAAQzZ+o6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXL1syQpKOIad9/fXMROpkmvZULd+ix6vGmRY6x+ttU=;
 b=bHI+vJQ2R9kqxE5f21vOwWGB7Y7/j14To3ECzeRnJsX4R1YWpifI4Rbyi0oikn62Y6iCKJ9GPp+9XGRYM2pEla2drn1s8RyKWNo7uGCdK/MdpoImZ8NfKywav+4RtcEDGv6dhfceXOyTZXBkjRP4fhPKNR97fA8PZICDAJY1S45RShrKugqa1zCfwv8wONjtRNnYhVsh41/ECww2k4X+TPaEOyJ+PpbIVWjod3GreHw0pbklgf+6BWyEV8NCVSKTfuzBfvjgGbeAJcWxQDjETvZXIMKLr/LqfLrP9RZEfu8BrkaCIcA2Lc/JK8rGfkNp9nSwQahUjY+YIyVigliU1A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:36 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:36 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 07/22] pcie: helper functions to check if PASID and
 ATS are enabled
Thread-Topic: [PATCH ats_vtd v5 07/22] pcie: helper functions to check if
 PASID and ATS are enabled
Thread-Index: AQHazEQKtD49ORo8dkSF9/Zy0QCSqQ==
Date: Tue, 2 Jul 2024 05:52:36 +0000
Message-ID: <20240702055221.1337035-8-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: 53cc36f9-7238-4bd9-9c2e-08dc9a5b2ca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SEFvTGtiWm55VFJtSXJnTFQwMitkTmNwa3loemNGcENJOGY5NmpDQlRPUXZm?=
 =?utf-8?B?V2hCMFdYaGtwVnhBeUMraWJabFE3SXFrai9iYkYvK01GVVpCUVZ3VFYwYmJW?=
 =?utf-8?B?eGhVa1lveXlTTzJHRGpsbEhxU25aNk5CTkJaelJoNGZLZEpTazMraDlFaFBh?=
 =?utf-8?B?OXBuaThsTlgxcWtsbUZKMWJ3cUxYREVvRVNPSnVlTTN6NGFEcVlsSGZVSnFn?=
 =?utf-8?B?eGtWWXpTU0x6cXpPMXlsam9RU2pKQlprOU8vVkJXbUM2ZVNCZlMvUlJtcG0r?=
 =?utf-8?B?RXVJWVNxNGtsY1VoVUdQbXpIY1VJVFE3TWgyVXpUZVIrRGpHZy8vUWNBdEZU?=
 =?utf-8?B?dllvWWlhZFQzaDJGTmNzRUtNWTJuclp1bUhheW85RVVBZlRqM3B2bXdvQTFK?=
 =?utf-8?B?bU1mWk9Zb3BBeTBSSnFSNlpLMVh2QWJmaDhvZ0h5d2JiVllLOFFvbHZJZXZT?=
 =?utf-8?B?dU50eHZrWms3RVExVFVlTHM3OFJFa3NpNDc2emRDNjZkdFBqbldINHFiSDJx?=
 =?utf-8?B?NDJrb1dyRmhHQWc4VXcxb3JFQitPSEo5RTF6TTYvKzdPTFFqb3VPdGxUYWpI?=
 =?utf-8?B?bTVsZXdaY0pPNGxqNFoxZXZLb2V3aEdzK1dUVkFxUzZDclVhamlKS0N4Y0VZ?=
 =?utf-8?B?VDZ0cjZKaWtyd2tVL041eENGeHVsY0tuNzNTWW1qK2pyTkJHN0p6YnpMM1A1?=
 =?utf-8?B?eWZkeSsxMHh0TDZsUFlmRitQeUxESk5RSUpHTlB4YTE2QmtvV29JUm9iTFBp?=
 =?utf-8?B?WkY1SVV6SFJmVTkvWms2ZUhNcHR3TTJ2OWlSL0NxNkNKelVSdit5Mjc3emta?=
 =?utf-8?B?NnpHQkl6ZEkwanVZY1J0NG1lRG01NmNFREpQbkhmandzV1I0OTljaUl0UE1B?=
 =?utf-8?B?NUJUTFRwbnRvQlV0ekFEUi9DLzJiME43ZFZpU1VralBzSkZ2OUI2N3dEKzJZ?=
 =?utf-8?B?R0EwYnZjNzlHTTVpWStURXRxK0JTcnNwcmR2VEc0aEVETUgyVXdCbDZpc2hn?=
 =?utf-8?B?MVZJRC9rcmlQeUdFRDhEUzBVbnFHUHVPSEc4RVV2YWgyWHY1SzNOWmt1OG05?=
 =?utf-8?B?QVh5eXlnZHZkL0VUa0JaNFR5VHBmMFpudllBbXM2cFI1VXFxVDBDNklOMFdX?=
 =?utf-8?B?am5mZU1JOXNSQmpSa1Y3RW1qMi9xcCtXdkFPY2lSM2o4ekFWdUwycmFCNEUz?=
 =?utf-8?B?OHBJdStIS1hiMEgwcGtyc2E0RGZNY2F2Z0M3cDgzMzBub2U0T3FKTnNLdUVz?=
 =?utf-8?B?SjF5cS9PWThvbm00ZktFSFR5S1ZSVXErNXhKZ1BhaEQ2TUVaMW5lSTFBblBG?=
 =?utf-8?B?Z2hPaDQ4ZWo0N1NGMmRibEtGNUFXTnVmczZmMzlselc5T25aejZhZjhKazR0?=
 =?utf-8?B?NlQ5a1FsZ1Z5cGpuSDdGV3pXSE44VDZ3d25KajBBUXluVTZxT3BNMjU4Z0hs?=
 =?utf-8?B?ZVZWcVdNcG9XbEhPTDhPTWN4eTg4REYrakxvK2RZSTdrMjR3eDRqUFFxdTVo?=
 =?utf-8?B?ZVpzby9sUWtBQlptNndaVmpTVlBpbEZscEdLK1FhVXJoZEswUkFHRyt3NDh0?=
 =?utf-8?B?ODRrUGlEbTNyaHpWZkdoM3hXM0RXblBaY3prbUZGd3FMbTlhdkdMbEYvVmxM?=
 =?utf-8?B?ZVN0UlZ1SVRwYXNtUHFFcnhQM3JORm4rNFYzTnpFbVJGUlNrNEFxL1pFN2pC?=
 =?utf-8?B?YnZsYW5vMEpmR0wwVnZUVlBMSDhmdUVNRmYyWEh1Ti9JUjluRTlQTEFRZW5L?=
 =?utf-8?B?QklQSi9tQ0plZzNIYkU1QitMY09WeHJNMUQ0TkUvMmREL0d1QlJlZnRTQ0s3?=
 =?utf-8?B?V2gxaHdLc1R0aHBzME80Q3JFbmdkQmdhRGdEZnJ2ZkV2bTB0NGRCZzhqZmMw?=
 =?utf-8?B?QUJMdUFVK2tPOWtRZ2t3WnhjQVlMMDUrSGtOUis3ang4M3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cndwTGZPazRBNFQ0REZKNFk5MVpCYjRNWTg5VnhxMXlXZlgzWmVhTzBPdUdj?=
 =?utf-8?B?QnR2eitmTkpTQVIrRWVMaC8yTFgrRGxwaDEzWi93RzJ5amNCTEl2MXJ5aENo?=
 =?utf-8?B?L3ArQXZKM29tVkR5d2luM1M5TndBQm1pa2NYYWFjUXlzRGFWY1ZsTEt4RlpO?=
 =?utf-8?B?aldEOGorRXg5a1lTUFZJaS9xaGZ3YTNnM3JVblBKTFlGZFg0ME9WMFNtRFpy?=
 =?utf-8?B?TVBlWEplVmlXdWlvTlVkWUx1RW10OHpqTGxKTzVuYk42VFNEUmhSU3Qyb1ZB?=
 =?utf-8?B?V1hmWkorVHFLbTlmKzJqaWQ1WnAzK2MvcTIzUG9UYWowVjJsZEc1QVpKclhk?=
 =?utf-8?B?V0EvSGswV04xSW1zRzB1aktPUlVrTXRvOGprU3YxYkRHQkJuVC84R3h5SklB?=
 =?utf-8?B?MlI0TFc1dXRKOERVamRuRWZwUFhJL3U5ZzBCTGNpNTBjTGRUZWJnWXhJOUxF?=
 =?utf-8?B?RXdQMGduR24vaWk4MlQvRzdpRlBaa2FlZzZEN0F6SHVrR0Y4MzJ1QmdaS3h3?=
 =?utf-8?B?My81ZjJ3bFE3V2VhQk0xZ1gwaW9EQ2FVWHNHMytHbjNjZGJUanZRbzdsVGNG?=
 =?utf-8?B?YVNGZjF2NFl5RnNWS3p1N1ZHbzAvNGk2MitKcDF1ekRDMTZESVFWWU1kV0Mr?=
 =?utf-8?B?OXVZWnlJQWlCQkdkWnJOMER1SUxJa1pVUkx2VjV3bENZdGdKMXVHcllXUVpT?=
 =?utf-8?B?a0MvNC9iM3YvYVFXNTN4MDNpOHRWZW1XcHdRYkRSNUVmUE1yell2aTd1RCt1?=
 =?utf-8?B?ai9PejFRc1ZubFIvZUR6TEUzbERTbVE2ajdRWVVmZWxLWkhlNWk5YVBpVi8y?=
 =?utf-8?B?QmpJUHFseVpJOUw2eGUzRWpCNEQ1MEU1d1dGNldVWS9tVW8vUlplL21JSkFS?=
 =?utf-8?B?R3dXQWRDMTFvTW1Ka1NqZXl0SGtXMUp1Z0p1VkNpdXdJaHhwdVRQU2lCT2JQ?=
 =?utf-8?B?bE1HWE9hb2NnUU41dkhNdmtBVjVzazViNlV3Y0VaWTQrMjdqV21Yc3NJVDUr?=
 =?utf-8?B?cXVmV0xtOVlJYWRsVVpMSUg0MVJtc2VGWDNldGdYdXVmdlpSdWtHNUtKMGFP?=
 =?utf-8?B?ZUkwbVY4aGh2RzhQWlNkOUUrYmtXQ3JZNmZqT2xaREdTUUw2bUdGWUlDbXow?=
 =?utf-8?B?S1hXYVJTb1J2dUdCb1ZmcEZoREFtcE1DM2hhL281Sm5ocU5KVG5GTTkrTnBr?=
 =?utf-8?B?SzRWQjdvdmhrL25WSjg3aHZ0V0V1SWdkM2owM2xHaVN0c1B6SzFaUENsRXBF?=
 =?utf-8?B?VGpNcmJ0Y3NnNW1IMks0cmsxTWE5TndSMTFEeFJndXYyV3lGYmZJTHVsckJC?=
 =?utf-8?B?LzhtWXhHQXQzOEFaQlFnZjk4RFlIcUVRV01iaXVXcXBuNWI5bjF2TE9mSldJ?=
 =?utf-8?B?SlViTUpKZVY2S3hSOWJtZTlUMnFsbG9abmZrMEF5bWk5RE42Z0cxRU1DMU1o?=
 =?utf-8?B?cExCVTBWMmpyajJCam9DUkFzVEp2UDV3WTZERVc4V3pUZ1ZGRXdUb0tlOWh0?=
 =?utf-8?B?N2ROdmRFRmlNN1g3OHlSYkZLNUkwUjRyUEdNMUl6NDA1dEpTOEYzeTRQengx?=
 =?utf-8?B?NVU2cFpYSEZqTU01VXNURm5BaHNEWXc5RWdDWmtVRloxM2VHL0M5UmQyRzJq?=
 =?utf-8?B?aTJzWVo5RStYZXRWZGlqY0NnK3ZZeStsNXBLcVlYYVhyK1NnVHpaM0pkcGhK?=
 =?utf-8?B?UmJNbGw3QndzQUo1aW5sU3pzZGZFY3QyODVnaDNDYjlxd2JGbG1jMldFcHF4?=
 =?utf-8?B?TDZQOEZHbTQ4VXVrazBUMktrS0ZMckR6d21oWjhOV2RuMXZQQmF6dGZmRWlZ?=
 =?utf-8?B?T3MyR05sZDdYR3dQMzAwZENTWWN6VTlWcnVQYzlndkJWN1ZLbVhVblJjS0xk?=
 =?utf-8?B?aXliaTV6S3BTekVVdVRhUUNjdi9SY1U4dTJBQmozWUpBY0pCbTNrVngvb05P?=
 =?utf-8?B?Q0ZwUVJtTWJEUDF6R25IKzM2dlFodDhQWWZpZlhFY2svQ2ZNc0drNHNlczNs?=
 =?utf-8?B?L0VnZzBBb0ZIZlJ0dkN0V0E4Uk9iaFJXRTVTUjBOeUxneTdJVDlqb2lEQlVN?=
 =?utf-8?B?NTZnV3R0Z0NacC9mNDFScHhUMzRqbzN4S2xNZDhqUE9oNWNOaWF6eEFIbXlm?=
 =?utf-8?B?NUhQUWZFN1hhT3NnUUFUWHNBWVAzRVhLU0M3NExGVzBralQ4WEJKQm9tTnAr?=
 =?utf-8?Q?woAgM9aCy/2v6Gk7iW3GLII=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88132E1221348340876F34DEDBC6DB7C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cc36f9-7238-4bd9-9c2e-08dc9a5b2ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:36.0903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7k03/iX6QVjtNenPtDjjtH4XmYS0cS6U9y33HFE3LozuaEmmG9uorY8Xj0MWzp9HRIYAJyciHf819AgRa55LB1jeagC0t0UjYGMT0ZbQghH6mnLGdkHG9Fhz9dWdF5G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCmF0c19lbmFibGVkIGFuZCBwYXNpZF9lbmFibGVkIGNoZWNrIHdoZXRoZXIgdGhl
IGNhcGFiaWxpdGllcyBhcmUNCnByZXNlbnQgb3Igbm90LiBJZiBzbywgd2UgcmVhZCB0aGUgY29u
ZmlndXJhdGlvbiBzcGFjZSB0byBnZXQNCnRoZSBzdGF0dXMgb2YgdGhlIGZlYXR1cmUgKGVuYWJs
ZWQgb3Igbm90KS4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xl
bWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpZS5jICAgICAg
ICAgfCAxOCArKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2h3L3BjaS9wY2llLmggfCAgMyAr
KysNCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3
L3BjaS9wY2llLmMgYi9ody9wY2kvcGNpZS5jDQppbmRleCBkNmEwNTJiNjE2Li40ZWZkODRmZWQ1
IDEwMDY0NA0KLS0tIGEvaHcvcGNpL3BjaWUuYw0KKysrIGIvaHcvcGNpL3BjaWUuYw0KQEAgLTEy
MDEsMyArMTIwMSwyMSBAQCB2b2lkIHBjaWVfcGFzaWRfaW5pdChQQ0lEZXZpY2UgKmRldiwgdWlu
dDE2X3Qgb2Zmc2V0LCB1aW50OF90IHBhc2lkX3dpZHRoLA0KIA0KICAgICBkZXYtPmV4cC5wYXNp
ZF9jYXAgPSBvZmZzZXQ7DQogfQ0KKw0KK2Jvb2wgcGNpZV9wYXNpZF9lbmFibGVkKGNvbnN0IFBD
SURldmljZSAqZGV2KQ0KK3sNCisgICAgaWYgKCFwY2lfaXNfZXhwcmVzcyhkZXYpIHx8ICFkZXYt
PmV4cC5wYXNpZF9jYXApIHsNCisgICAgICAgIHJldHVybiBmYWxzZTsNCisgICAgfQ0KKyAgICBy
ZXR1cm4gKHBjaV9nZXRfd29yZChkZXYtPmNvbmZpZyArIGRldi0+ZXhwLnBhc2lkX2NhcCArIFBD
SV9QQVNJRF9DVFJMKSAmDQorICAgICAgICAgICAgICAgIFBDSV9QQVNJRF9DVFJMX0VOQUJMRSkg
IT0gMDsNCit9DQorDQorYm9vbCBwY2llX2F0c19lbmFibGVkKGNvbnN0IFBDSURldmljZSAqZGV2
KQ0KK3sNCisgICAgaWYgKCFwY2lfaXNfZXhwcmVzcyhkZXYpIHx8ICFkZXYtPmV4cC5hdHNfY2Fw
KSB7DQorICAgICAgICByZXR1cm4gZmFsc2U7DQorICAgIH0NCisgICAgcmV0dXJuIChwY2lfZ2V0
X3dvcmQoZGV2LT5jb25maWcgKyBkZXYtPmV4cC5hdHNfY2FwICsgUENJX0FUU19DVFJMKSAmDQor
ICAgICAgICAgICAgICAgIFBDSV9BVFNfQ1RSTF9FTkFCTEUpICE9IDA7DQorfQ0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvaHcvcGNpL3BjaWUuaCBiL2luY2x1ZGUvaHcvcGNpL3BjaWUuaA0KaW5kZXgg
Yjg3MDk1OGM5OS4uMGMxMjdiMjlkYyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaWUu
aA0KKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQpAQCAtMTU0LDQgKzE1NCw3IEBAIHZvaWQg
cGNpZV9jYXBfc2xvdF91bnBsdWdfcmVxdWVzdF9jYihIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19k
ZXYsDQogDQogdm9pZCBwY2llX3Bhc2lkX2luaXQoUENJRGV2aWNlICpkZXYsIHVpbnQxNl90IG9m
ZnNldCwgdWludDhfdCBwYXNpZF93aWR0aCwNCiAgICAgICAgICAgICAgICAgICAgICBib29sIGV4
ZWNfcGVybSwgYm9vbCBwcml2X21vZCk7DQorDQorYm9vbCBwY2llX3Bhc2lkX2VuYWJsZWQoY29u
c3QgUENJRGV2aWNlICpkZXYpOw0KK2Jvb2wgcGNpZV9hdHNfZW5hYmxlZChjb25zdCBQQ0lEZXZp
Y2UgKmRldik7DQogI2VuZGlmIC8qIFFFTVVfUENJRV9IICovDQotLSANCjIuNDUuMg==

