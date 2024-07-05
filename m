Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CDFC38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 05:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPb6X-0005MX-R8; Fri, 05 Jul 2024 01:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPb6W-0005M0-KO
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:03:28 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPb6R-0003dt-HP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720155804; x=1751691804;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+vlW/HnbLcXMR2jiiiKIos58VNaFzsvBUZnsSR8WMWc=;
 b=c2UwBF2V+agf3SjBFf4lkJJIKedPH1dx8/goqud5n3QySXaiutg5jzpC
 ss07hUZJx+XjniahZlcgk5KcEtn2PGISlf7M5RxVKE5WPymQNvFo8YucR
 d6xthEWucyyXKcFDHnoLCsq8q7Xgzz3EZapx8fzJ0s0/G6oXUurNeBx5B
 umzQOdkKkAO64Oyg8TNH8srVexEoYRX3h/JNZN1opn6SweP4Fk8ySafbq
 wR5y3+h1tFUicqwYAY4+JFRWkMEHR4jbjUzn3ZFgGWnFh9aoe4lJ1cOLg
 wNM3nvO6nMywKjPZscD7rmOqXRHbZmbqy3LkPjMJdqvtZ9B26kA37+ujJ g==;
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208";a="15932577"
X-MGA-submission: =?us-ascii?q?MDEVUNVIeB+2nLfWcbH5HR5ei1ZZqTvmKgKffz?=
 =?us-ascii?q?sv4HmSrZ40dfF3Rm8da38FIdPdgnAkRrmf4en7GlhrkwkQ7uV7gFkxXN?=
 =?us-ascii?q?nm0d6deElYFf6kr8JeDtYTx4s5fL2bT1HypnB3MeInEa5LfT1qJh3OmB?=
 =?us-ascii?q?Z7Hy02n8uPUDR1ddos8A3yaA=3D=3D?=
Received: from mail-vi1eur05lp2168.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.168])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 07:03:20 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlomwKmB21uWsKKaJqfW6zG4a4+OztCtzowJs52w8rTBKsHqS2y4xw7hP7BslZIpTaIWOV1ZMAgYdI7mD0e81vDPlVaNqW2KYq97AqNhqh+SFTlHPXRSFi8Q5Mj7ROomo992YA3rYmfG2jAv/outPuBxBaBA6cqtYMQPEiEgSxjE/i5+R3ajpTa4Ymm9laQjcIj04FVz9XN7W6/V0qFhce1XLyRagDmfVB/afQgbLra6hYLBhX3KQ+nCk8B+Vs7L6byeAV+P/viWJ6aeCdkFaZF4O1JnBs+bznBXF08baPW4DnkY5E3qW5kjHnvs2QfDgkNJW3X+FxND9QOYNffqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vlW/HnbLcXMR2jiiiKIos58VNaFzsvBUZnsSR8WMWc=;
 b=EicSsr0D+fCcnrJpyypDqQYJra3KYDIGstzYoBp8t2WaPeVA+yRY9svcc/8O8XSKQ8RZWZDB0iMztot8UelFve2Et6kYk6QyGk3kV2ISGCNWoXl5tPzU6z4RGe9zK1boBsaP4Vs2sx7SNERxvvWyMl/46qiOJMMUG3RiJXedRPDM3LK24ZSu8B1/98LOvFh/WbSD2/FxRwxkjCp441nFHWxnIVVakM+CAMaFQOSptP33GZGkz5cwmrwP92ZuEjBLGXukRJyX6ABoer6+3BiI5sEF/TqxFw9fj763DYTr7IJqLYrK7enx7iLEMqW4bNLNZolxjCSLLYv0HS/i0Tvr6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vlW/HnbLcXMR2jiiiKIos58VNaFzsvBUZnsSR8WMWc=;
 b=os+2s7hN90coL8gbIOQQEvrrfsa5xp8u588NWQwqqMj0+z76JWziZZyoq/PZSja1XUeI6JLXiLfU8a84jSg8sfOT8B2xo7luWYqG68F/p8zaKsV5DD00hRmej/FtArPrd64SLbI1mdm+SNnCOlITYCYqSkghkcWjYd9kCby7weeLVMGUESVAUFTDJ+bLfWIK/vc+XK/VfbJkvtDAZzPJ4KBVJHLlU71nYIE9Rbp9KpoB6NwwnkKiDKsajrsBlSWaJkpA/cMv+eQRZbq+sVotY3D3OFCubLAbhxEyIr8itfAPrsYaBgkAhWxOje29bDkJLY2ajpZaodg5kIvCcyEzew==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6542.eurprd07.prod.outlook.com (2603:10a6:800:179::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.11; Fri, 5 Jul
 2024 05:03:18 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 05:03:18 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v3 3/3] intel_iommu: make types match
Thread-Topic: [PATCH  v3 3/3] intel_iommu: make types match
Thread-Index: AQHazpimYumHqjSOhEagUatp7yyYIA==
Date: Fri, 5 Jul 2024 05:03:18 +0000
Message-ID: <20240705050213.1492515-4-clement.mathieu--drif@eviden.com>
References: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6542:EE_
x-ms-office365-filtering-correlation-id: 9a1b8379-de84-47e3-947e-08dc9cafc935
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UTBBSjBCZ1NwSzIvV1Rha21yMTVidmdDeExzY0NacFltbEdXRUhqNHYvLzZv?=
 =?utf-8?B?N1FzUE1sWnVMZU01c1p2SU92aWxaRnFaZTB5aVVzK0Y1QzJLWG9YRlRQQlRD?=
 =?utf-8?B?RFh1dVQyejluWXJpOUJ0amRDbzZLZnNNK2tPeXRWQ1Fmblh6SU5IU1NaMU95?=
 =?utf-8?B?dUhTZk9Qdlg1dVNYVHRudjZIZ1hCODd3aW9lak9KZTlCZ250Q09EblRMZnRa?=
 =?utf-8?B?UmZYV1RmTDBkREhaaE1IdUpXTjFONFVWcFlFdDJLQXYwbGxUR0NJM05pWFR6?=
 =?utf-8?B?YzVKQ3NtVEZYbkhqQnlIdHJ0Y245Y2NGM2FXRS9qRytXTnFFa1IyVm8zRHpG?=
 =?utf-8?B?NXBZY0ZCNzRhQ29mWk9XWmc1bnhXeDI2bllqcmYrTU1uczBFT25iVTJ2bUZX?=
 =?utf-8?B?YmhBOTNsK2R5TE9VSWk3UGVMZDg4SDNZY3JOVHlWY2d5c0pXeWpGWFNNalVR?=
 =?utf-8?B?Y0tZZVVKa3VpR09idFJXNW0yWjRVQUwrRUx3QmI3VW9sdW84WlN1YnV1enNP?=
 =?utf-8?B?MzBNeDc3QXEwZnRleDZ3bmRSU1c3QnhmdDFGRHN3S214N3JsN0NoVXhNWnhY?=
 =?utf-8?B?QnphTGh0cmZ3VjdqQWM2T1RxWElSMHBZMEZibklSNnZLM0ZhU0RScHBYT3lz?=
 =?utf-8?B?ejJmeFdUSy9CZC93c0VyemRTQngyak5kN3JNMmlTeHR6YkJyaUYzQm9CcXlZ?=
 =?utf-8?B?dEQ0azdjWlZxNXd6UlFHNkkzUGFrRGFUSTVuT29UYllTVmswVWxDLzZyamtm?=
 =?utf-8?B?TlB1UzYrMkpLTzFvbHVBY0doRndXVC9rak8wb0dYRnhKSUFJTVUvdTlXa2Er?=
 =?utf-8?B?RnlLUGY2ejA1OEllZWtGZEFzaUdCdkxYMGRiWi9DQTlsb1l4ZmV1TDJXOWxU?=
 =?utf-8?B?STJXSlZOaktpRlhoTXQyYWlEejdwNEgwRnJwd2NrMzZGSUV5eDh5RnQvVk00?=
 =?utf-8?B?OHVWR3NDNmlQQkdjNC9wRWFzTTFlN3lHNi92eEM5QTRBNWJjVVNHZ1pLWFZP?=
 =?utf-8?B?VlE1QndISjVUa0l4WnF2T1kreEdSdE9oVXVjaWp5RWVhTGJ0UDM2RG14LzZy?=
 =?utf-8?B?d3NTWngxTGRXaDdjNVpLQ053MlIwOEhNcmJzNTdzV3pTNEh6WEVobXFaRU95?=
 =?utf-8?B?K0MvYUZsZUFHSW8xUmdEUklxK2REUk8vY3JCTEpBWUZkVkRMcHFXWkRuRUZ5?=
 =?utf-8?B?VVN0SVFSWUdLNDIwNlB3aUkrdEhLWDVIVFpQQTdzQ3VDckJJYTBKa01jWWV6?=
 =?utf-8?B?TkJMQk4wQS9LVkxFYkxYZHkzRXRRdXlxWVR1OXJRMmxmelNBQVR4UHc1TG1n?=
 =?utf-8?B?eHF2OVAzSXBVWEJqV0pPS3FTTVNpL3M5M2RUU2lWUG9iaGNFYUEwcjFaM1dz?=
 =?utf-8?B?N3VjL0pYcXY1a1VmdngvZkNFb09yM20vdDVtZVFQK3JSZjRQWWRab3ZOaFla?=
 =?utf-8?B?cnR1WEIrZkVYR3h5bjRma09NQlE4NjhPK3l4dU1ocDB6Smh2TnhjY1FucWdV?=
 =?utf-8?B?U0Qzb0orNmJvSXovV1lVK2hjQ1pPTkVVY0hRV29hNjJnbU92UVVCSUdRMmJQ?=
 =?utf-8?B?V2IyQUhQWWg4WFhVeWJRWkp6S0ljSDdhRndDdU5XYU5QUm5UNmV3ZWlQSERF?=
 =?utf-8?B?cjJJZjFqVGE1TmNTMkV5OFV4NDZxcnArMU15STUvTjJXSEVBK3loM1BxeG9X?=
 =?utf-8?B?U3JoTmJnZCt1ZUw5RWNMQ2JrUTJBcHdXSFJQb3d3UC9TMVZ0MWVSTlFMdUlG?=
 =?utf-8?B?NEIvNkZhME5sd01KNS9Yb2IzS2hLa01pRklzWHFzRk9VN1BQVTBPcjdiY1Ji?=
 =?utf-8?B?aEpzbG5hRDQzT2t1SjhQYnVKejdRUmlNUEh1R3hBSTBqRVJjUXM1NkRKdFhT?=
 =?utf-8?B?U1BtRnV1L282VTl3QndRVEI5RTNlbWw0UTZxdXFkd0R5eWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0p3b3NXNjRpYkpFeEVzWjFGY2wzM0xOQit4UmRRcS9GZkUxNGlrbmhLWnJZ?=
 =?utf-8?B?Z3B5YkV1QzBaellyRGE4a01Ba0pRZWdycC9SR0xIaS84YmdtK25qU25GN1JF?=
 =?utf-8?B?UkVrOS9MbW12RjVPUy81NE90UHNQYWpJR2tXZlZNZkR5S3VMbzFJcE85Q0ov?=
 =?utf-8?B?b2F4YXJyMDArNjVkTDFjeVBURG55QkVHMGNCaUF2RHVySzJDQWRmVFpNMmlF?=
 =?utf-8?B?UlBrdTQ4cU1JZXBFbkxvMlZMZyttVzdWc1YzUTV6SkVNVEhuU04yYnFVRHZZ?=
 =?utf-8?B?L0l2ZkQ2N3hCVVJTV2lrdWNvWEI0bUpHVjMrNzVLbUdaVmsvblRLcUNkS0tZ?=
 =?utf-8?B?QzZObnREWFlTOFQ3QlRQRllRcVdLTHdsSERNMENqTVVwV2E1MGlXMnVKeE40?=
 =?utf-8?B?dWtOa09vYTFmZG9DWG5OZWVKa3QvRnB1Mm1JUEx6cUFGVzE0MVY4MXpQK21L?=
 =?utf-8?B?ZEY5RFNOSDRpNnlqOEVQYjhpVVZYR0J6OS82RERPQ2NGRUdndjhxM3lDdDlq?=
 =?utf-8?B?b3d0RXlYTTRMUmZkVXdBWTE1R05rMlBNbHRZTzlOaUJscDdJSGJjV1BJRWNr?=
 =?utf-8?B?elo5NzZpc1B3Wmc4QzNIRDFOalh5L0JUZkJXaStWdlljTHY1c2djVGY2NXBJ?=
 =?utf-8?B?LzNuOEx4T3FZdEs2WVFuZ1pGaUZJSnhXQXV2UlJPZHVSY2N1ajUrd0FIOFZo?=
 =?utf-8?B?NmQ1U1JzbjdNZ3pkT1dNZmpGT0FVdS9FbWI3NjRRN1hWQjJ0MWozYzY4cHRW?=
 =?utf-8?B?aWNDUlZ4Sml3cyt0WTh4YlFSc3ZWTmpQdEswZnk3TklsQUd0K3MvQmlmOGdu?=
 =?utf-8?B?b1M5alcycVpjQW5TR1pGTHZjNWFuSlpjb1hUNXVOYzE2dVNZNG8yOW1EN3NE?=
 =?utf-8?B?NSt4KzBZejV0aFptYzEzVVRFL2JSMTFMalZXQ2xQRlpsY0ZvWHR4S09DVjg1?=
 =?utf-8?B?bEFReGNObGZsN2w2Y0dES0h1aTlsR2NqUXNyOHNIZFE4UEtFRDRZd0xUemov?=
 =?utf-8?B?bEpTS0ZoLzNraEF0TXEvS1lzOUFXbzBib0EvMG90aW91L2g3end4RHNjSTho?=
 =?utf-8?B?STcza2pCNkoyUXRBejBtSWd3WHhLdXdGUnFIMlU0OUhBU1RkUzFBZnJmR0NN?=
 =?utf-8?B?UVZmNElTTW12emVwUzBBTGZ2T0RtNmZjbVovcDJDbkRLbFFZUTI5c29mc3I4?=
 =?utf-8?B?VUJvWGpxMG54dmtPR1huU3c2K2tZdlhvS0VsNm9DV256bk8vMTRJaEd0Y1R5?=
 =?utf-8?B?aHlLOEwyNU5mSkUwT0o3T0FLNkp3S0Y5N0VUVW9CWGJkMkxjclp4VHNjZFo5?=
 =?utf-8?B?OFZWcVpOMFdjcTNQaGJqNjdnaGUzc2pZUUJsSFdId2RaVWorQmpTd043Rzky?=
 =?utf-8?B?cE85UnNCcGdXaHU4cWxYM2dlanU2L051WllGVjhRRVVzYU9XRmVtSXE0Z2xo?=
 =?utf-8?B?WXNyeTlJVjAyZWNFV29QTTZzbVpIcU9rMGtHUWt1dGVHWkRSNEFYWDEvbHJT?=
 =?utf-8?B?TTJiRjNTV09CMWFzUm5HZUd2VWNsNFNjMkcwOFV5N2swTWFmZnhFa2NsL2hR?=
 =?utf-8?B?ZHhjcmJWY3Rkd2pCTHMrWWxrbUIwRFNZcyttcVJtVnF5SXN4SnFzeHJicVRB?=
 =?utf-8?B?b3dJdWs5NW4zUXpvclFQRXBhSmVCYW9DMDM5SG92WkFhV1dEMU1uY3NkbGxt?=
 =?utf-8?B?dWxhdXFESzRaQklEaTkrT0hoZVFWbS8wS2ZzVFk1QUhneUdBRHV0dHR4WWpV?=
 =?utf-8?B?bldQQjM4MVVFWFUxdnVEbm1qU1REVkQrMzUvQUdoanlrSWRPZ3ZiYVdPbHVM?=
 =?utf-8?B?RjNYR3F3SVRmRTdkSGhzRENhZDZMMkJROTB0WElSL0Q2NUZwVmoxZkpCZVJF?=
 =?utf-8?B?QmZyZ2x2L1czOVAwN0tqeXIzWkNiMVFacmw0QTJpWGQrQjZGVHJPNTJuZlJO?=
 =?utf-8?B?MkpLVy9EN1RHdmVqK3hSTk4wZjR1cHhzTW9tWGN5MThjS3R3YjIwZUJrK0hJ?=
 =?utf-8?B?RkR6TkxnSmxmZWNrMDI0a1htb1NUbndPK2F2ait6VTQ4NzVpZGhoQzNPR1cv?=
 =?utf-8?B?dWFBc1VZZ0d6TStWSmliYTRMK1FrR3l0TXd6RkNtUE9ta0tPeWFJekw3aTZE?=
 =?utf-8?B?UjJKMFo1RTVrc21qRzNPZVdFQmNZcmVwa054NXE1YU9ZUkdwMTE5SEdBVERV?=
 =?utf-8?Q?jrvK7kn5UbkgqslnXfPf3GE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CDF6DCABFAA834885835EF427752511@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1b8379-de84-47e3-947e-08dc9cafc935
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 05:03:18.8503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LI5sklwAeSNQFRJ7ajsYxWZ1yhYBSWMDUZFRzQAmVqI69BAH7xrJq89L0yFImgi7u/rjj0vXp/C0vDyge+Wp8MrEqPcqXcXbOfRzedf/C7QuBEZ3wZDFEdam/nQ5vODk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6542
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
bi5jb20+DQoNClRoZSAnbGV2ZWwnIGZpZWxkIGluIHZ0ZF9pb3RsYl9rZXkgaXMgYW4gdW5zaWdu
ZWQgaW50ZWdlci4NCldlIGRvbid0IG5lZWQgdG8gc3RvcmUgbGV2ZWwgYXMgYW4gaW50IGluIHZ0
ZF9sb29rdXBfaW90bGIuDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYg
PGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9p
b21tdS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jDQppbmRleCAzN2MyMWEwYWVjLi5iZTBjYjM5YjVjIDEwMDY0NA0KLS0tIGEvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC0zNTgs
NyArMzU4LDcgQEAgc3RhdGljIFZURElPVExCRW50cnkgKnZ0ZF9sb29rdXBfaW90bGIoSW50ZWxJ
T01NVVN0YXRlICpzLCB1aW50MTZfdCBzb3VyY2VfaWQsDQogew0KICAgICBzdHJ1Y3QgdnRkX2lv
dGxiX2tleSBrZXk7DQogICAgIFZURElPVExCRW50cnkgKmVudHJ5Ow0KLSAgICBpbnQgbGV2ZWw7
DQorICAgIHVuc2lnbmVkIGxldmVsOw0KIA0KICAgICBmb3IgKGxldmVsID0gVlREX1NMX1BUX0xF
VkVMOyBsZXZlbCA8IFZURF9TTF9QTUw0X0xFVkVMOyBsZXZlbCsrKSB7DQogICAgICAgICBrZXku
Z2ZuID0gdnRkX2dldF9pb3RsYl9nZm4oYWRkciwgbGV2ZWwpOw0KLS0gDQoyLjQ1LjINCg==

