Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E140CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 17:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3e0G-0007ei-2T; Tue, 30 Sep 2025 13:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3e0C-0007eQ-5h
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 13:19:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3e01-0000lU-T1
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 13:18:59 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UHFLGV030434;
 Tue, 30 Sep 2025 17:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=7B4Gv1GhActCKbGFINm/VcWF//s71y5PE2BsqyL0wGQ=; b=
 jIuQ9GK9hgRuwKpjPnDAjcWihqQCtQyIgw9gWsRbNPXaQ2mXUhobQjrCIt4h3Mdb
 Xdu9p8Sdz1fpXu97OfQyBUIN1uZiXzSeCh76SrxmubZ2gnBGHiApo76oGVzo/NzJ
 zDJeMbsTdDDjp8gBle26s1pSWP+GViriVmZN6WYE74UBSzmpig3fApqQ8My0WLJq
 T7ghCORgybh00RdyJy3DTR4+PkPrqWgdB7NvgqU8pM5FTfOS4mauCNECtC6ywnE6
 fqDb4+8F8xrfGhbXwZstxBFCJ95Aj22SYf/dUnnwCpnCq1Z/4XA2XBV/xJZUD7uq
 So5SC6UyeVETGgbIwBDT7w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gke880aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 17:18:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58UGp7oD011534; Tue, 30 Sep 2025 17:18:44 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c8n5m6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 17:18:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewkozi/ymx2br9IhbT5m/T3BjdrV4k0ZfV+/FZVg10CC4VV2/LiQm1Ox9VBTJetZ/DE16infEs7V5p/qtquEAEmNs7G01aZKtD0uKKgcay7ylJAysj3hTI7ETMsyp5MBavRjwYcFWfhSeMy8ZMVYpAkW4rzIiaoZat43ALW2f9FE9d/3oEr+TTE1D3t0WyfjUj6P3cyTtGDccv/fKwbCP0waFTA5m1EBfV02fEZWvJQNpRX2WpVF3QWX8eUGDBL3YM0qg1GzRXlzzAdqErsywB0XXbeSnzw31doZOtW9cr5DqAW/IvLhN3lgoXlPLEVhuo8Xlc2gvZPkLJodZ4UbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7B4Gv1GhActCKbGFINm/VcWF//s71y5PE2BsqyL0wGQ=;
 b=S6L/w/Ww/Haecr0wSAOHvpyjYcPLIZCAxV2qPrsOyOaKeuk50qpFqXf96/ohMGNXYB4V6WpJG4jRtpPVtIOD0Dc0j1oQ+raY0lbll4G2P/zQ/AOzZjjieZ0Ctym51kE/rIY0iVu4bgv1d5kUtaKU7CN8CzNHQEnXXgtWu/oRSd+EGIHA7ZdX4ogtwrAKnvnqy/AkrJe48BQdyXGEPDTSyyrm3EkviNYy9MXhk+6TpvO+TCwp+Fng10NAwQFB1XUjZvBDs2cEzitUv4IDpxiXDrzCD+pyD0tuNkxL7gycW9wp8/SchE66lWismomg2h88ZXbHNac7KwelbC2xoBthlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7B4Gv1GhActCKbGFINm/VcWF//s71y5PE2BsqyL0wGQ=;
 b=arZPup1iY6rHKQAP8KvJ3pZnWXa8pzPmZ1wwILxRLawNnk50khBJdQ8IoM9gvzC9tD9XLWYYItuQSqT/7gZFJ9dowwzVbztSM7EXyMvrI5JEhrthFcKdzIVi6hhFMkOtLvX5KHpyHyrbDU9vi6tFi5N1Q4a6mbtPV6Dr2CIJVBU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM3PPFBBE6F5DB9.namprd10.prod.outlook.com (2603:10b6:f:fc00::c45)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Tue, 30 Sep
 2025 17:18:38 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 17:18:38 +0000
Message-ID: <56116ed1-a299-48b6-b6af-af36ddc9a16b@oracle.com>
Date: Tue, 30 Sep 2025 13:18:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 6/8] migration: cpr-exec mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-7-git-send-email-steven.sistare@oracle.com>
 <aNwHz39FkYIq7DgX@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aNwHz39FkYIq7DgX@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM3PPFBBE6F5DB9:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb6546f-1ba5-48dc-b3dd-08de004564ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekp5Z2RJb3hwWGU5UG9PUEsyZXNBa2NtR2hZbW82NmtzWWRodS9ESHVsRExj?=
 =?utf-8?B?eFpKSEpRK0JwU0paUHZHbGNZTU5DSzZqNmtJaEtOVzgrWTBiNmxlOFNqQUJn?=
 =?utf-8?B?TDNzbURvZHg4aHVvSWVXWk1BcUtIdjZqR2M2MVNnZDh1alhSTmRETmxRMlBS?=
 =?utf-8?B?THpuMzlTaEh6aDFORE81MWZSSDRJUVhkRThNKytRcjIxSHBwWVZ1Z2xtL3pM?=
 =?utf-8?B?V3ovb2kyNzhaSGxGbEFHZjF1RVBhNW5oUG52TTZwTWM0Vk84aDNRN3FwNWZ6?=
 =?utf-8?B?aTRuQzNSdUtMSUZZcmF5empWa2wrRDd3MU1YYmI4c2ZlZkZjZ3pzdk0vaDBF?=
 =?utf-8?B?NmFjMGV0NzNLcWFHMU0ySGUwM25tWEE0UUhrajFid0FTMExrSDdtK00zVXdO?=
 =?utf-8?B?cTlEZkNRQ1BCQkY4aXhKNlp3eUFJNStBWkFxOHlQZGc1SEs1dm1jMFpDaGdy?=
 =?utf-8?B?cUlxWXQ0NHZDeW1JMkdoNzFHaCtyOWkrbWowdlJodlhndnE4ZlBnd3BnREpP?=
 =?utf-8?B?RjRYUmpIQjFiOUpzTjNyS1ROeUk5OFVFRWM1d2I1L3ZKaTdyd1dMaWp5czUx?=
 =?utf-8?B?VGF5dHY1aDhvdFVHSDV2NkZoZ2pWU2dDUEQwYkpOZ1FHamNMVzFDMXcyem9r?=
 =?utf-8?B?Wit4QlhqRDFndk52ZERYQ1JpOTVRVFF6dXZSUGpXWUtGczJ6eFlOUDZGeW45?=
 =?utf-8?B?RzdUc0Z6QnZWRm1WMHYwRXNYWTVvMWxvVGxXbjFNYm9lb0k0dlhsaDlVVkdn?=
 =?utf-8?B?cmxPOC9mUkZhRUpYbmh2WjFBVjMray9EaEpyNnV4K2ZXaVFlYndkRHNhUFJG?=
 =?utf-8?B?S1ZBOERpbnZndHNpWnRnL1RHYm1IYU1odHc4NmlIa2pnTHF3MjZ3RVh1ekVM?=
 =?utf-8?B?cmxmNzhrQ29zV2tIenNGRjRLMGVvNndqTVE1VEJFUklhZjU1Tld5b0dnV1VP?=
 =?utf-8?B?WTUyMnkyWEtiTlQvMDFZb0FOUUlzV3MxUEo3UnhUL2hlREhjZ0tjY2ZFS1hp?=
 =?utf-8?B?SUY0dGxyTGtQUWQ4L0l6T2dtWWdMckUrbWU4TlpIT3hWK2prcEpmb3ZWQyt3?=
 =?utf-8?B?SlZPUnBsOUNoOHlSak9QT1Q3d3JZVXZzZ1o2MnlWcG5Vd0RBZnRuQ281QXJl?=
 =?utf-8?B?TCtDSVc2NVA1QXYyeW5rRVhlQ3ZIWTdwUFpSdzFBV0xTRWJtSURsY2NuOVhX?=
 =?utf-8?B?eVY3L2poSUtXM3liUUlQeVd1SFl6Z1NYQzFBcTliNkpacVNhUmZLQnpaZ0xk?=
 =?utf-8?B?cEJZTTNaMEZvUEdka1hoRTl4eUxMVkxRQzBTUDF5NXBtUUdPWTNqeWNCS203?=
 =?utf-8?B?ankxVzBCSzczaVZCekZqRWdQdU1oYkpDNHorL3pvZlBuWmhicHFhRjNEYWdm?=
 =?utf-8?B?QmRhK0dJbnUrSzVPZ3VpZ3NjTkNNN2c2UkEyMjVWMWVyZWdYdG5WK0dNbGh5?=
 =?utf-8?B?bE9FZC92RWRFbnBxUHdsM0U1em9QWmlFcWVncmZ1UklWcmt0S1ZqY2svb1Zm?=
 =?utf-8?B?ZkNReDUvei9zSGhEeDFCbGM1N1IrQjlVYzh6K1RZZTFZT1QwbnlSUWJaSSs3?=
 =?utf-8?B?aEdsdHVlVHQ1U3NRS2lOUW5aczBZamZUM0UrcVc2eE9renVLZmZTS0xVZVhh?=
 =?utf-8?B?YkJ1Nkhxdmt2MmxzV1U1ZXc3TlBTU3lhZW1QNFdNMW1wNXVrQmYyeVMwNUEy?=
 =?utf-8?B?MzZ4R1Yxa213Vll1cjNYSDArWDc2bVRFeEtUaWYzNmVTc2JlT3BjY3EycWN2?=
 =?utf-8?B?RmZhNy9GQ1pNaUx4WDZ3OEUyRm5SdVhBMWhqWmhIVWsyOE0xQ2xlMjlTR09r?=
 =?utf-8?B?cW44c2lRMlVYUmZDbjh5U2haa290OFBpUjdRcUFISEIwMWh0WXRLaUs3dVNT?=
 =?utf-8?B?N1FPM1JOM0ZiMHZpMU91bmVsMXBHS2JnTjZySGtNdnJ1N2xIWHUwWEtwZkJR?=
 =?utf-8?Q?ebd5rSd2ErlhONw4uKZoacomaW3mP1bo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3o2RTFZT1BlV1lDWnFhdmw4bTBFZkNJOFU2dVc0OVBQV2V0Y3k0Z1EzbWdu?=
 =?utf-8?B?SVFiaW5NbkFrRHY2Wld0UUFzNHBPVG53dE16T0Y2cXVYQldneGdTM0g2Z1Br?=
 =?utf-8?B?OXQzYXZEVzZUMlRSWkJ0bGZlWHE1UktTWi9kaCt2b2tEVVRUbnl2dVgxeTAy?=
 =?utf-8?B?N0JFNnYrUC9oYUh1aEF0TjRhSFBIQWhKaUhTMFNjdnI5Q1RycWVPOFltQmFS?=
 =?utf-8?B?djlJc3Awa2ZhZW9HV3hWV0lLNWFQMlhQMGVySnZPWVBIMmpGbFJwK2ZUS3NK?=
 =?utf-8?B?Z1F2Z2lSNmxiaHFzcmhmcCt6Q2x2a1o4VFd0QU11bGp3MlozTWNoTzB2VnRk?=
 =?utf-8?B?RTI2bDJpNmpvL09zcE1PUE5qcVQ3aFQ2WDRMQzNieG8rTnFLZnNUY2NkQm1X?=
 =?utf-8?B?dDhwc0pYNEFBRW5aVXFLc1ZGc1Q2QlZMOG05d2FGaWF5Q2ZsNFJkeUhUU0Vs?=
 =?utf-8?B?VUJ3Y0htMzlCN1gzQVgvVlMwaVZkMmVnLzJ4Z3g5K0JWQTNwek1pVTNyM1Jn?=
 =?utf-8?B?RTFPajRsa3BOMEZjMXBMaEhOTER6RTJwbUh2NlQyOWZ6N2JLMUdQaVByUUgy?=
 =?utf-8?B?N3llSjFVcFd2MzAvdG1uZDg3eVVHSCsyY2RDM0NzMzBtajBOUFZSdTZCZS9P?=
 =?utf-8?B?a1dUemxoL3R6TXl3MnVpek03MUxxZS82S0pqeHhqZHZ6VGM0OFZtS2NpSjEr?=
 =?utf-8?B?cnUvRTcxQkVwaHE2d0VkVTh5RnRvTm1aZUo4cHZBR01nanNwdnJkdTc2aU0w?=
 =?utf-8?B?bEVQRjNVL0tiK09XNVNTNXBPeDF4NnJoNThrS0JuMWZrcEUwUjIwNkdXaW05?=
 =?utf-8?B?Mk45TFRmTmdRMEE2TnB5Tm95ODkzK3BUNFprdHpRamh3bGVFR2NjeGU1ak9i?=
 =?utf-8?B?YXZleTRrR241QndoRVpsMS9GcWl3WStlQVY5aXhXc0hyK1poUHFSRk42V3BP?=
 =?utf-8?B?ck9jWlpGU3JOdXFvejFNQzJEcFJXNmdZQWMyRkFOQWc2WGxTUWNIWWhpV0dI?=
 =?utf-8?B?RC9JZ1ZsQTM4WEI2WXEwTXBlUlBNQ3FYVjZ3Znd6VWUwTU1wcE1CNUxsMVND?=
 =?utf-8?B?MjkxaUhHZ3Y4Si9IRzJMampkWmsxL25Nb2NoWVZKSUZpU295UGw1bXRMaXV0?=
 =?utf-8?B?QWNMOTJ0bVd4SjRyZlZ0a0pjNWVMc3VVVWNCV0VEK0tOMzB4VGd2ZVdDZjRN?=
 =?utf-8?B?b1RMY0d1MVVGeDN3WGhzeWE2NDQrSnVCTTB5eldwaDZYOTFNamNrM1hScGd0?=
 =?utf-8?B?aDJRbnRhb0ducERMWXpwZkxKc01PQmVGRllXejlCMkxXTmdoYnZKb1kvTWEy?=
 =?utf-8?B?WWF5Rmt4YjcvVVltWnlOTGhtamcwVld0MXlLbTdURTM0UlpMeDJnbUtpQkVG?=
 =?utf-8?B?SHgwQlFZNFJ6NkpHbkFaT3U3SElnSGpZaXYyZUkyZGJKQ1BxbWhMWDRkc3pF?=
 =?utf-8?B?dnFBRStHbVh3UnB3R0p1azQzbVJPZXdBY0JsYXJPbVZ1MnFHSTd3WWpCWG1C?=
 =?utf-8?B?NExHSThkcUF1a1I1OHhoQnFPc010ZUFQMHhzbXQwRWxWSitrcmhBbUNyVHNR?=
 =?utf-8?B?c2I5cys4T3FSM0tYM2JUaXlieDVLS3VGL0tqV2d0K0g1M05iTHl4VWQvVnQx?=
 =?utf-8?B?a3VuejFINjE1TzZrWTlydGdpRFkzQ21qM0xxZ2Fudk9paVp2M01IMFNKRVFM?=
 =?utf-8?B?WDJOWDB1RHg1VmFiaVNtUEVtMUNzUkZlaXBWMnBuTjl6UXI2SFphTXZXbzRE?=
 =?utf-8?B?SUNSNkNISURaNUtJWjJSL2ZSSGJVcUNEenpwYjlURkhtbUlNN3E2dGxFZHJH?=
 =?utf-8?B?YUxWWjlzb281WFhNUitTejhyd3lLNmYwS3hYdDJBZXA1WjhIako2Q1hVeE16?=
 =?utf-8?B?WXRXcnU5MzRUR0VEcHQxd1I3QjYxVVlBUTdZSTRKbmJDSWlwOVJRd1lDa2NH?=
 =?utf-8?B?aEhZZWxCQXBTNHRPWnNHTXlvR29adWNjUWwyZnlXYzlCZ1dDRmJ2SzlMQits?=
 =?utf-8?B?VG5XeUF4amtiQzFnQWFlREwwM29YOU11SlJGVmRtVkx6RFBQQmpUeFo3Mm51?=
 =?utf-8?B?ZnM1cjJFZXFrcXBwMkhCRG1mSTZhMS9YU3hJNXgxWHMwR0hXOUNsQ0JLdWpX?=
 =?utf-8?B?N3VzY3NhcDh2aWUyVFdlbnVkaFMrL0hxK1hSaFRnVjZ5QU9yUXk0TEpWbHRX?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nkrX2nmKe178bjdBbeEop7vnyR5BXTCHNcxQT4stAjmaeQXUoDxg7eG7IQzgampSABD5EJ5/Plo9zmAMA/7CXITNcpNSIgxvOxbEs1stqmxtJ8rZdP6+UnEXRRuhJDmLN7D/qZ5nFjYnV7xUG2IF8YFHQFIdAjw+TA6d4mXJCIp68Uf+PNtdLqqANl5l+yaN6lB9VWzBAkn7p3NgRf5AadOKobX6ur12ePaKDqeU6b8VI4Gw2qFj4FUMPDnip6gCKU5TYBmzNeHf3iHQjcfI8KHzINt85lm7h0TdeeQjOjg47RsrMDayHYtLYTV2pF+BDiqtT9bItwx6gNHo6AxpGmQrS6DMPfbmFuVlBtpweH+NknVhitujFzccFfx+9hdJOAEwDaNrUIYQqtovzf+A0YTFHaK5YW8sQOGDhFzDb/JLURg/5hwm0283Q4+mOZbRU4u34rfeSMg2cevAwKD4D5sFpiex7rfQabv/CtTKby45MGkvetOy3ytyMq/l239c4JzwUX+aD2V41TEfWt5iMewbqOdgeNwU+j2q/NlwDvAkTozlO5zpoevpdhUqnDvCHrSzajlg0vbZk8l31RJtivWYXy5m1WL3HwdebuNDOzI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb6546f-1ba5-48dc-b3dd-08de004564ef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 17:18:38.5985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQDatMyS0Ce6+Vcae1SbfjtPljBFwaqKt7IWln4t7ciW2gExn70zk7MR694bzeedWcIWyTuStTNHpdkstaB9KsEhlS30rvCxfK1swSPfW40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFBBE6F5DB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE1NiBTYWx0ZWRfXxj4Zl5OGI7/X
 adcKJRebwNO9EXWFOGL9cAOeEBIKyLTosAYNaqI//5aHAxfkQN5kYFHfisnQQj4C1aWBLdtRkcN
 oSoIcQxP8SC4ojQ4XSKbSSE2oxSriRwJz+45WdJhyRn5M7/9FyHAPhnE+FxF8AbOpB2mv8l8Jmy
 xJFm+ZlkeT0lu+4IZ4s5dXhy2bkzNA/ne+yA1nN1dYBQ/Zi3+LlcEOTmU9A1aMyeJznbdeURFY2
 4bafdLVRKOxQ4ggHlV3VYxDhj6vK+RkuEhXi8V0DOMre5ur5q+3QTjiVKdK2pFKzBzSc71klM8p
 1MZmSSYEK52vToMNbvWsZsA9epRrFatIGVB4CqUzbbXBbCeey0nzhB0f4IAHR2lBjuTNIfSlk6P
 gtjYVCZW2lSupmWH0qjEMbnxHIcS0JZ97FPXpG2aqVZ/JcI+u7s=
X-Authority-Analysis: v=2.4 cv=ZLPaWH7b c=1 sm=1 tr=0 ts=68dc10f5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=3y1C9Ajv0D7amGgn8E0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13622
X-Proofpoint-ORIG-GUID: znuDvSIY686DdYq0kGraV0-b70-G1HYS
X-Proofpoint-GUID: znuDvSIY686DdYq0kGraV0-b70-G1HYS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/30/2025 12:39 PM, Peter Xu wrote:
> On Mon, Sep 22, 2025 at 06:49:43AM -0700, Steve Sistare wrote:
>> Add the cpr-exec migration mode.  Usage:
>>    qemu-system-$arch -machine aux-ram-share=on ...
>>    migrate_set_parameter mode cpr-exec
>>    migrate_set_parameter cpr-exec-command \
>>      <arg1> <arg2> ... -incoming <uri-1> \
>>    migrate -d <uri-1>
>>
>> The migrate command stops the VM, saves state to uri-1,
>> directly exec's a new version of QEMU on the same host,
>> replacing the original process while retaining its PID, and
>> loads state from uri-1.  Guest RAM is preserved in place,
>> albeit with new virtual addresses.
>>
>> The new QEMU process is started by exec'ing the command
>> specified by the @cpr-exec-command parameter.  The first word of
>> the command is the binary, and the remaining words are its
>> arguments.  The command may be a direct invocation of new QEMU,
>> or may be a non-QEMU command that exec's the new QEMU binary.
>>
>> This mode creates a second migration channel that is not visible
>> to the user.  At the start of migration, old QEMU saves CPR state
>> to the second channel, and at the end of migration, it tells the
>> main loop to call cpr_exec.  New QEMU loads CPR state early, before
>> objects are created.
>>
>> Because old QEMU terminates when new QEMU starts, one cannot
>> stream data between the two, so uri-1 must be a type,
>> such as a file, that accepts all data before old QEMU exits.
>> Otherwise, old QEMU may quietly block writing to the channel.
>>
>> Memory-backend objects must have the share=on attribute, but
>> memory-backend-epc is not supported.  The VM must be started with
>> the '-machine aux-ram-share=on' option, which allows anonymous
>> memory to be transferred in place to the new process.  The memfds
>> are kept open across exec by clearing the close-on-exec flag, their
>> values are saved in CPR state, and they are mmap'd in new QEMU.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qapi/migration.json       | 25 +++++++++++++-
>>   include/migration/cpr.h   |  1 +
>>   migration/cpr-exec.c      | 84 +++++++++++++++++++++++++++++++++++++++++++++++
>>   migration/cpr.c           | 28 ++++++++++++++--
>>   migration/migration.c     | 10 +++++-
>>   migration/ram.c           |  1 +
>>   migration/vmstate-types.c |  8 +++++
>>   system/vl.c               |  4 ++-
>>   migration/trace-events    |  1 +
>>   9 files changed, 157 insertions(+), 5 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 2be8fa1..be0f3fc 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -694,9 +694,32 @@
>>   #     until you issue the `migrate-incoming` command.
>>   #
>>   #     (since 10.0)
>> +#
>> +# @cpr-exec: The migrate command stops the VM, saves state to the
>> +#     migration channel, directly exec's a new version of QEMU on the
>> +#     same host, replacing the original process while retaining its
>> +#     PID, and loads state from the channel.  Guest RAM is preserved
>> +#     in place.  Devices and their pinned pages are also preserved for
>> +#     VFIO and IOMMUFD.
>> +#
>> +#     Old QEMU starts new QEMU by exec'ing the command specified by
>> +#     the @cpr-exec-command parameter.  The command may be a direct
>> +#     invocation of new QEMU, or may be a wrapper that exec's the new
>> +#     QEMU binary.
>> +#
>> +#     Because old QEMU terminates when new QEMU starts, one cannot
>> +#     stream data between the two, so the channel must be a type,
>> +#     such as a file, that accepts all data before old QEMU exits.
>> +#     Otherwise, old QEMU may quietly block writing to the channel.
>> +#
>> +#     Memory-backend objects must have the share=on attribute, but
>> +#     memory-backend-epc is not supported.  The VM must be started
>> +#     with the '-machine aux-ram-share=on' option.
>> +#
>> +#     (since 10.2)
>>   ##
>>   { 'enum': 'MigMode',
>> -  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
>> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
>>   
>>   ##
>>   # @ZeroPageDetection:
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index b84389f..beed392 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -53,6 +53,7 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>>   
>> +void cpr_exec_init(void);
>>   QEMUFile *cpr_exec_output(Error **errp);
>>   QEMUFile *cpr_exec_input(Error **errp);
>>   void cpr_exec_persist_state(QEMUFile *f);
>> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
>> index 2c32e9c..8cf55a3 100644
>> --- a/migration/cpr-exec.c
>> +++ b/migration/cpr-exec.c
>> @@ -6,15 +6,21 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qemu/cutils.h"
>> +#include "qemu/error-report.h"
>>   #include "qemu/memfd.h"
>>   #include "qapi/error.h"
>> +#include "qapi/type-helpers.h"
>>   #include "io/channel-file.h"
>>   #include "io/channel-socket.h"
>> +#include "block/block-global-state.h"
>> +#include "qemu/main-loop.h"
>>   #include "migration/cpr.h"
>>   #include "migration/qemu-file.h"
>> +#include "migration/migration.h"
>>   #include "migration/misc.h"
>>   #include "migration/vmstate.h"
>>   #include "system/runstate.h"
>> +#include "trace.h"
>>   
>>   #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
>>   
>> @@ -92,3 +98,81 @@ QEMUFile *cpr_exec_input(Error **errp)
>>       lseek(mfd, 0, SEEK_SET);
>>       return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
>>   }
>> +
>> +static bool preserve_fd(int fd)
>> +{
>> +    qemu_clear_cloexec(fd);
>> +    return true;
>> +}
>> +
>> +static bool unpreserve_fd(int fd)
>> +{
>> +    qemu_set_cloexec(fd);
>> +    return true;
>> +}
>> +
>> +static void cpr_exec_cb(void *opaque)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +    char **argv = strv_from_str_list(s->parameters.cpr_exec_command);
>> +    Error *err = NULL;
>> +
>> +    /*
>> +     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
>> +     * earlier because they should not persist across miscellaneous fork and
>> +     * exec calls that are performed during normal operation.
>> +     */
>> +    cpr_walk_fd(preserve_fd);
>> +
>> +    trace_cpr_exec();
>> +    execvp(argv[0], argv);
>> +
>> +    /*
>> +     * exec should only fail if argv[0] is bogus, or has a permissions problem,
>> +     * or the system is very short on resources.
>> +     */
>> +    g_strfreev(argv);
>> +    cpr_walk_fd(unpreserve_fd);
>> +
>> +    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
>> +    error_report_err(error_copy(err));
>> +    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> 
> I believe this is the only place we can have the state machine from
> COMPLETED->FAILED.  It's pretty hacky.  Maybe add a quick comment?

OK.
>> +    migrate_set_error(s, err);
>> +
>> +    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
>> +
>> +    err = NULL;
>> +    if (!migration_block_activate(&err)) {
>> +        /* error was already reported */
>> +        return;
>> +    }
>> +
>> +    if (runstate_is_live(s->vm_old_state)) {
>> +        vm_start();
>> +    }
> 
> We have rollback logic in migration_iteration_finish().  Make a small
> helper and reuse the code?
Hmm.  There is some overlap, but also subtle differences.  For so littlecode, it does not feel worth any risk of regression (or worth the time to
test and verify all conditions).
>> +}
>> +
>> +static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
>> +                             Error **errp)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +
>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>> +        QEMUBH *cpr_exec_bh = qemu_bh_new(cpr_exec_cb, NULL);
>> +        assert(s->state == MIGRATION_STATUS_COMPLETED);
>> +        qemu_bh_schedule(cpr_exec_bh);
>> +        qemu_notify_event();
>> +
> 
> Newline can be dropped.
OK.

>> +    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
>> +        cpr_exec_unpersist_state();
>> +    }
>> +    return 0;
>> +}
>> +
>> +void cpr_exec_init(void)
>> +{
>> +    static NotifierWithReturn exec_notifier;
>> +
>> +    migration_add_notifier_mode(&exec_notifier, cpr_exec_notifier,
>> +                                MIG_MODE_CPR_EXEC);
>> +}
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index d3e370e..eea3773 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -185,6 +185,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>       if (mode == MIG_MODE_CPR_TRANSFER) {
>>           g_assert(channel);
>>           f = cpr_transfer_output(channel, errp);
>> +    } else if (mode == MIG_MODE_CPR_EXEC) {
>> +        f = cpr_exec_output(errp);
>>       } else {
>>           return 0;
>>       }
>> @@ -202,6 +204,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>           return ret;
>>       }
>>   
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        cpr_exec_persist_state(f);
>> +    }
>> +
>>       /*
>>        * Close the socket only partially so we can later detect when the other
>>        * end closes by getting a HUP event.
>> @@ -213,6 +219,12 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>       return 0;
>>   }
>>   
>> +static bool unpreserve_fd(int fd)
>> +{
>> +    qemu_set_cloexec(fd);
>> +    return true;
>> +}
> 
> Is this function defined twice?

Yes, since it is tiny.  I judged that defining this small helper twice, near each
of its call sites, was better for the reader.

- Steve
>> +
>>   int cpr_state_load(MigrationChannel *channel, Error **errp)
>>   {
>>       int ret;
>> @@ -220,7 +232,13 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>>       QEMUFile *f;
>>       MigMode mode = 0;
>>   
>> -    if (channel) {
>> +    if (cpr_exec_has_state()) {
>> +        mode = MIG_MODE_CPR_EXEC;
>> +        f = cpr_exec_input(errp);
>> +        if (channel) {
>> +            warn_report("ignoring cpr channel for migration mode cpr-exec");
>> +        }
>> +    } else if (channel) {
>>           mode = MIG_MODE_CPR_TRANSFER;
>>           cpr_set_incoming_mode(mode);
>>           f = cpr_transfer_input(channel, errp);
>> @@ -232,6 +250,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>>       }
>>   
>>       trace_cpr_state_load(MigMode_str(mode));
>> +    cpr_set_incoming_mode(mode);
>>   
>>       v = qemu_get_be32(f);
>>       if (v != QEMU_CPR_FILE_MAGIC) {
>> @@ -253,6 +272,11 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>>           return ret;
>>       }
>>   
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        /* Set cloexec to prevent fd leaks from fork until the next cpr-exec */
>> +        cpr_walk_fd(unpreserve_fd);
>> +    }
>> +
>>       /*
>>        * Let the caller decide when to close the socket (and generate a HUP event
>>        * for the sending side).
>> @@ -273,7 +297,7 @@ void cpr_state_close(void)
>>   bool cpr_incoming_needed(void *opaque)
>>   {
>>       MigMode mode = migrate_mode();
>> -    return mode == MIG_MODE_CPR_TRANSFER;
>> +    return mode == MIG_MODE_CPR_TRANSFER || mode == MIG_MODE_CPR_EXEC;
>>   }
>>   
>>   /*
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 08a98f7..2515bec 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -333,6 +333,7 @@ void migration_object_init(void)
>>   
>>       ram_mig_init();
>>       dirty_bitmap_mig_init();
>> +    cpr_exec_init();
>>   
>>       /* Initialize cpu throttle timers */
>>       cpu_throttle_init();
>> @@ -1796,7 +1797,8 @@ bool migrate_mode_is_cpr(MigrationState *s)
>>   {
>>       MigMode mode = s->parameters.mode;
>>       return mode == MIG_MODE_CPR_REBOOT ||
>> -           mode == MIG_MODE_CPR_TRANSFER;
>> +           mode == MIG_MODE_CPR_TRANSFER ||
>> +           mode == MIG_MODE_CPR_EXEC;
>>   }
>>   
>>   int migrate_init(MigrationState *s, Error **errp)
>> @@ -2145,6 +2147,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>>           return false;
>>       }
>>   
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC &&
>> +        !s->parameters.has_cpr_exec_command) {
>> +        error_setg(errp, "cpr-exec mode requires setting cpr-exec-command");
>> +        return false;
>> +    }
>> +
>>       if (migration_is_blocked(errp)) {
>>           return false;
>>       }
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 7208bc1..6730a41 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -228,6 +228,7 @@ bool migrate_ram_is_ignored(RAMBlock *block)
>>       MigMode mode = migrate_mode();
>>       return !qemu_ram_is_migratable(block) ||
>>              mode == MIG_MODE_CPR_TRANSFER ||
>> +           mode == MIG_MODE_CPR_EXEC ||
>>              (migrate_ignore_shared() && qemu_ram_is_shared(block)
>>                                       && qemu_ram_is_named_file(block));
>>   }
>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> index 741a588..1aa0573 100644
>> --- a/migration/vmstate-types.c
>> +++ b/migration/vmstate-types.c
>> @@ -321,6 +321,10 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
>>                     const VMStateField *field)
>>   {
>>       int32_t *v = pv;
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        qemu_get_sbe32s(f, v);
>> +        return 0;
>> +    }
>>       *v = qemu_file_get_fd(f);
>>       return 0;
>>   }
>> @@ -329,6 +333,10 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
>>                     const VMStateField *field, JSONWriter *vmdesc)
>>   {
>>       int32_t *v = pv;
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        qemu_put_sbe32s(f, v);
>> +        return 0;
>> +    }
>>       return qemu_file_put_fd(f, *v);
>>   }
>>   
>> diff --git a/system/vl.c b/system/vl.c
>> index 4c24073..f395d04 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -3867,6 +3867,8 @@ void qemu_init(int argc, char **argv)
>>       }
>>       qemu_init_displays();
>>       accel_setup_post(current_machine);
>> -    os_setup_post();
>> +    if (migrate_mode() != MIG_MODE_CPR_EXEC) {
>> +        os_setup_post();
>> +    }
>>       resume_mux_open();
>>   }
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 706db97..e8edd1f 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -354,6 +354,7 @@ cpr_state_save(const char *mode) "%s mode"
>>   cpr_state_load(const char *mode) "%s mode"
>>   cpr_transfer_input(const char *path) "%s"
>>   cpr_transfer_output(const char *path) "%s"
>> +cpr_exec(void) ""
>>   
>>   # block-dirty-bitmap.c
>>   send_bitmap_header_enter(void) ""
>> -- 
>> 1.8.3.1
>>
> 



