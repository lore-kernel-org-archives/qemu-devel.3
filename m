Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517AF606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VrUx14/g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ2wC-0004MT-E8; Tue, 20 Oct 2026 02:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xJ2w9-0004MH-8A
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:03:01 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xJ2w6-0005Wl-96
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792476178; x=1824012178;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZaJ+rAYu5982K4yhtgjNY7RXhg3pW/cijtfoW5EKnU8=;
 b=VrUx14/gIASJWqlNpCG3iTcEn+0t6mmyPN2lD8iXXEr3jlaUDERaz9Dp
 qLoZJ8ZQNli0Ck3LFialQtigJGSpkiwWIrcAq0oRQ2g/dkqWfYvwTfjSN
 kbY4dY8tt8mtzAeylPEf+g0aDaKJVlswBSpTq2T96zsN/DiGXZuvAreUw
 FYYDkryphqnFOJzQ9uBRw0EPNSHGAvvd9lGJ8GzE9QzME8c+758bDMts+
 DRsrUbkPkKIyPX2Z9fKGVsSlikefcld9ubuGJdW1TWkOd+GRuAvkI5mLX
 5WCNABsYoLCHmAZ/CeY6ugrOhgdnR8j6n9LOREGf+T2SNEST+HadYcdle A==;
X-CSE-ConnectionGUID: ZDPE82mjS5+a0w0G1XWZpA==
X-CSE-MsgGUID: v2MhHd/xQRu4UlIPi9WIfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1048361"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1048361"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 23:02:51 -0700
X-CSE-ConnectionGUID: B4dEAIbvTxy+81ZjvEn65w==
X-CSE-MsgGUID: Z+TEAuLGSde4TXmzh02vlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2684910"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 23:02:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 23:02:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 23:02:50 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 23:02:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAkPg9jJNBasXq20a+Y2tn3och9ucgeJ8hOWDaFljWPEpiwoGATwvYUIz5oG0Tfwfym4r1B/kjjmSW/jkoVwiNjFa6h5G8nZk1IzCwxOqlp1079GFNcsziDcf4tQSiLb0QJKGUUhPOznV0Ywn1lkLN8OTYtdTi65925ghpC3ax08CyGVuEfX7OY5E5XFzRU5X1WxVKci35v96aeQuHj0hfGUUDP+c1farcVcn9g0mHmS/CP9sghGNH01hftjKkRKP6zxOM640JPWMdMJj3CmJjEO6C8DLhZyPyUnxlv8HUyjW5UNAsDiTt6iuP7U4nMn+Z23Fusr4u2iV2qL9MkdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xoja78d2bBr2b0v79y777OLLiO8aiYAaxbRTpgm+mmM=;
 b=fgTVoOOET36HQY7QQVb2c3oPFBHFabI2o7PBYh+yaM1vb3J3SQr2P9HE4O3O8Kr0ufFAy8bdM2ZfZICso2Rxxp0UEr/7nUFkkFL8YjKTdTrbRRJeG7GedpXzOdSeJrK0vBvlntKXAwrl3eXrjHdir7hjxYp6IvGYEtRwvc/aAmhQu0r91fVtlEEpzoflTQZDkVrK+dvhPdE87zFK9Vok4wDlXf/AsbpQ3Ct1BrUaOqpUhzhRvFHSQDtBRWgbWKCO58NDu8SZl8EhctgZUTjpZW9ydSu1rX+z5KByyaoGCgbAYm7Vnewdq4TdU5KVfPxKHLErl6jZyXoxCYIYFDZDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by CH3PR11MB012418.namprd11.prod.outlook.com (2603:10b6:610:39e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 06:02:43 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 06:02:42 +0000
Message-ID: <e3956581-9915-49ac-9870-0157f01d0eca@intel.com>
Date: Tue, 20 Oct 2026 14:11:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] intel_iommu_accel: teardown FAULTQ resources in
 bottom half
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20261009090737.3930000-1-zhenzhong.duan@intel.com>
 <20261009090737.3930000-7-zhenzhong.duan@intel.com>
 <d7b37c65-7234-4eb4-b960-454572f447a5@intel.com>
 <IA3PR11MB91360BE8D6DA1C1F7239873092982@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91360BE8D6DA1C1F7239873092982@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:295::19) To SA0PR11MB4527.namprd11.prod.outlook.com
 (2603:10b6:806:72::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|CH3PR11MB012418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac23053-4655-42dd-fec1-08df2e6fc0c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|42112799006|23010399003|1800799024|366016|10067099003|18002099003|22082099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DK4YTAZA5StZIGGOnX66gyAn23E1oAKr0KxsCCApl7+9CZdntLDbLRPVROo9/ugZO/cFa8NvprRGONgsaEvZYzZVHsjtN6n8FWs16jDqY6724WK2SO7bfgM63yJzpjuCzLOsDH5FRYiQVTl7I23bOBbgR/ERAmSkX375WVTpON4APNIdbHXq55EyM9WGM80olyIRtnXtlUpHLzeXAZmbUJnAFPiPfU1XesxAlC4BKulN6Vi7pzlu/rW5zOvks1h3nwxqx5JC1vppNLCf7kvAIypCoGDiM7ax99U09ZD+YJqAPHyQorcXxXz1dkLmfOVM6ZbnYdtbpe3cp7vbl8ZCxUDZ/zsyVFTEWER42yjdvOSrNs4CE7WBGNLYuEKMRXuAkvAMKoo+StgcOXZi/FN6/jHlGX7FwaD4WtjjBecfaEns8Y5JBHVZ8igsT2+HYZc823WTrUYGEy6Dao0CFfHxpDW2U9MgRr+aLWoKbaNM0E+MPHyCatS3DpuN0Q5SV2iD7SpvEj9nxllo7sTVSdjx/yTuyJS7BaI3+sbhGH+EevOBlVuy6zTNurnVl5UuK1W/RKWpEdSTqFiDBgRgnWP5VrBaZ3n84FQMRToGb1eM82u3TUbTfU0Z8zZEdGnGrVY19i44irwwL6nsesHa+Gpe0UfEFk9P2WWcgpH/5Wey73k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR11MB4527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(42112799006)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVArNWl5NjJoazMwNFhMUm9yUXViRXdpdTdHbU95djYrdUMrcEJZYTZIT1FK?=
 =?utf-8?B?UVk0YTYwbnZxNER0cFk3TDZhMUJuZWY2eksxVGRMcDlMbjdCTHJDbDRkV1Mw?=
 =?utf-8?B?RTJ1c3AyM2NLVWkrMXZkR1AvWUNUaEFpQmdtSG5oSFFpY0tqcmgyeWY3a2RK?=
 =?utf-8?B?S1RMeUcxQmlQRjRLVWg2Sys2Rk1YeGJvbWlQWWhEbUtBRXA0aUZIcVVxb3ZU?=
 =?utf-8?B?Z0JjdEwwQ2s4NjV6QXMzN2JYU2ZuMjF1ZDFWWG9NbDhBaTcyTjZwWjUxaWxo?=
 =?utf-8?B?ajN0Yi82QkZ6SG1NS2FueldoejlkTEdNMzR3NHhHMHBxTXhtaGdVS095Y1po?=
 =?utf-8?B?cFVxTUJ4WmJxL21nMVNEbDc1cG1MWFhHL0JTak5kNXhlOTJ6OXNRV1p5ZDYr?=
 =?utf-8?B?L2lyc21uVHFJTUo1Q3hsemI5a0pFdjNWeUlwcUFabFg0MXhyWjJVUkQ1OVNG?=
 =?utf-8?B?eVFEdUhEcEpUVUNLMENjd3R6QmI2ZlJzeVRHaVk1TEtPZGZ1SU9MdUVSbC9T?=
 =?utf-8?B?VnJwMS8yWERJdjZ5UEM1QnVTRkZvdUF3YmozV2thRnVuT2c2M1BvQkptWUZM?=
 =?utf-8?B?bWhqVDlzYXB4T1RkYlhGV3hCaFgxb25CUS9YRGtKWDUxSi9TQTc4RjNJVmNL?=
 =?utf-8?B?OUluQitNdzYxeTlvZUc0SWx3RjVpQUxXR0o2Z1BMNVVuNm5ObERKanNnamc2?=
 =?utf-8?B?L2c4OGJ1RVB6YnFNenJ3ZWhnQ29CNXZQK2RsbFcwWE1oa3R3LzFyWmI5bzhE?=
 =?utf-8?B?V0h4UHpHRmpIU1dqczRpUXZBM0k0Vy9PNG5TdFYzTkRHazBWeDluTlhRVTly?=
 =?utf-8?B?ZnNNdXhLVG1lbkVnVE9ZTHk4RHo1RXpCNTI5RUp6OE9idHBtVU1WS2VQS0Vn?=
 =?utf-8?B?dlZWNHFka08wS0ptZXNVNEI1RDI2VlNoNURYWXpLeVd6L2h5bDk0dFRWeTBz?=
 =?utf-8?B?MlRxWTdQY2lTbTR0SytrRjI0Wlh4b2tZTjVCOXZZWnZtY3dycjU1bEthVnBs?=
 =?utf-8?B?c1BiSTduSXpqZ3RJZlVrV3hSSnVqNDN6REVBYW5jVmJCK1pzUC9saUQ4QUlh?=
 =?utf-8?B?ZENNUGdFbTNDdEI2bVBQWDN5OGk0Q2Z3a1NmN1BSUGNKWUNwVThjTnMzRHNV?=
 =?utf-8?B?Z24xTklucEovd3NUN09LN3ZYNFFQdmhGSHhlWVRWaWZ4NXF5ZUlDc2t4eWZm?=
 =?utf-8?B?aWlURVFkdU1zdlJyVW53QkE5cWprNzhKQ2IraWJzeHdXSEtwMzd0SFQ5cS9s?=
 =?utf-8?B?RC92TUt4czBOS0JpU0E5UGplNzNxQ0E1cGZnVHhlN2RNSmFSREJGMkJQUXdG?=
 =?utf-8?B?d3NUTU9GVmpvNmxPeXlZMEVuSy9rUWpVT2trdUVyS0hROXJHSWJ3OG8rT2V2?=
 =?utf-8?B?TWdQb0gwT1pLc29zS2oxblhKSVFpNWw1NExsYmlHci8wNXNGVUlZK0RudVZ5?=
 =?utf-8?B?UVFrVnNhK0lqTzZDd2JrMlBVanJESU5HU202RVJkZHhWdHFhYkp2WWUrczd0?=
 =?utf-8?B?em1tTE1pSVEyR1pWaU9IZjBSb1hvYmRRK3diaUNVS2tnZ3VYb1BPSVkwbjZD?=
 =?utf-8?B?c0t6UlVyVVovc2x6d0o1bXp5b2ptQjNmTmlBVjBMWmFEd2lnQ2NncEdIa01u?=
 =?utf-8?B?M0NSS1diSDZ0Wi9XR0F0WFN5dS8yZFk2RWFTSlBkZVhNRzVlTlBoWDVQOUg5?=
 =?utf-8?B?SEE3WFkwWGUrOWozb0loTE1oRmZPNEFSWk9sbWgwSHVDRmU0K1pnT2pNLysr?=
 =?utf-8?B?Z3podFZsWTFuMjJFbWhDK3djbVk1aHorQjNjVURZSkxRK2RnWG1XcHlWTmV6?=
 =?utf-8?B?UldnNEpLY3p4Vk1RUm1UcGFiNGtrZ3VBUVlyOThPdHZWMW5YV25Pb29zOWxv?=
 =?utf-8?B?TWc1VWI2S2ZoWHdyVE05OVZqOEtYVDIzODgyTnNmVWtHNDBiZWNyQUV2Y2VI?=
 =?utf-8?B?ZzRhVk52SFN5V3BJVEQvZXRudllJMEFaQTkzYVYzRnp1dGRlUTYxZ0dNTENn?=
 =?utf-8?B?d211RFZnQndtc2JUZytydnhWcnZkMlRqK0RZdlJvSGZmMWRFN0Y3NzBER3JW?=
 =?utf-8?B?bVc1T0RJaDBIb3hOQ05iQjB1TkhqVVR4bldORVNZRHhnYkZjUGxCZzlEK3pZ?=
 =?utf-8?B?Q0pFUXpadVc5dXp5bG5DakFzUVQ5bm1FMWVkOTA0VmhYaGlNK3dTM3dGNHBO?=
 =?utf-8?B?czRwY3c5YUNTUndYKzBUSGpXT3RLRWF3eUdmNGlDMTRKeHFpSG5kT1FoNkFK?=
 =?utf-8?B?NUd0dThtVG51eTQ1azJqc1pjdjl6UHlwSmpLNWxWWkZQL2ZkMlFOWUtMUkNn?=
 =?utf-8?B?ME1uYnhDRGlzTGdFeGVjTHdtMnFQaHhWU1l6bGgrRmpSUmppWjljZz09?=
X-Exchange-RoutingPolicyChecked: jXyjtP+EiBiJxosCipFDwrS4i+SaQFvl1goo4RNR8qu0nQqFqKiTdrErv5OEJGuZD/wNOWKchv+qmaSO7aQ7YqaDdT4m0z9KXUY0LU2AJVA1IEBae9pJTCBCK1DkVR3zGA2SyWeBX1/A2DDTrjzpWl7TE8oNyMuG1W7TLo4Q3WUUvDe9JSGf8RFcqbMJRwdVgKdRY+t5kPv2xgpXdSwhFAauSplkFSw/8W9VUxfrfXup/Z3y9AjQGnvZWWg3Imd2MjWtotfPEkxZoom2E7ld1IRZGjGmbGc0NoOKrDrf3ewyvuFRlVi/VxmJLmOjImlnkVCXSLR7rk0rRNE4o1BJwg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac23053-4655-42dd-fec1-08df2e6fc0c6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 06:02:42.4143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRQqmzIX2bLsyQDQlYB/R5WjB1iFWcCW0sQ1Vo6mQ1Elht4+6x6DjXXd9qFhLWsAgscnl4CRESZ7exBqAlHHwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB012418
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 16:48, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v8 6/6] intel_iommu_accel: teardown FAULTQ resources in
>> bottom half
>>
>> On 10/9/26 17:07, Zhenzhong Duan wrote:
>>> When a pasid entry becomes invalid, we need to release all resources
>>> allocated for that entry including FAULTQ object and fault_fd.
>>>
>>> We call qemu_set_fd_handler() to detach fault_fd's io_read handler and
>>> wakes up main thread from poll(), but there could still be a small
>>> window we call iommufd_backend_free_id(fault_id) before poll() exit
>>> and release fault_id file reference. In this rare case, FAULTQ object
>>> free return -EBUSY because opened fault_id file keeps reference of
>>> FAULTQ object.
>>>
>>> Teardown FAULTQ resources in bottom half to ensure poll() has released
>>> fault_id file reference.
>>>
>>> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_accel.c | 40 ++++++++++++++++++++++++++++++++++---
>>>    1 file changed, 37 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>>> index cd227315da..c07ffa68e0 100644
>>> --- a/hw/i386/intel_iommu_accel.c
>>> +++ b/hw/i386/intel_iommu_accel.c
>>> @@ -268,17 +268,51 @@ free_faultq:
>>>        return false;
>>>    }
>>>
>>> +typedef struct IOMMUFaultQueue {
>>> +    IOMMUFDBackend *iommufd;
>>> +    uint32_t id;
>>> +    int fd;
>>> +    QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
>>> +} IOMMUFaultQueue;
>>> +
>>> +static void faultq_teardown_bh(void *opaque)
>>> +{
>>> +    IOMMUFaultQueue *fq = opaque;
>>> +    VTDPRQEntry *prqe, *next;
>>> +
>>> +    QLIST_FOREACH_SAFE(prqe, &fq->vtd_prq_list, next, next) {
>>> +        QLIST_REMOVE(prqe, next);
>>> +        g_free(prqe);
>>> +    }
>>> +
>>> +    qemu_set_fd_handler(fq->fd, NULL, NULL, NULL);
>>> +    close(fq->fd);
>>> +    iommufd_backend_free_id(fq->iommufd, fq->id);
>>> +
>>
>> a nit: any reason that you open code instead of reusing
>> vtd_destroy_fs_faultq() as the existing code? If no special
>> reason, may be better reusing it.
> 
> Imaging when we unplug a vfio device, the bottom half can
> run after vfio device are already freed, if we reuse
> vtd_destroy_fs_faultq() with vtd_hiod as input, vtd_hiod
> can be garbage itself and we crash qemu.

got it.

