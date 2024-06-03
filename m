Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B37C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jd-0006fc-8y; Mon, 03 Jun 2024 01:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jb-0006eo-8e
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:55 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jV-00071T-VL
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394390; x=1748930390;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=SIeu1ywuoHGYO6QCaomSD+w6mCyRsjhBCta6xVoRJDk=;
 b=PVhGLbxE139HRDl7Gi5VsMURoOp89jMVly3joxwiZU1nzq1Gi8wbaT8V
 jCfA/0RshWYcW42omVBUoy3nPL6S3lYXbtP5iaCM713FluKDFJ4ZN/SmX
 PBBTJfF3WKAuwTUUk0lmyYCFVV5Dp9RMdeY8EDJU2kZSLy3yFzW4JEXmg
 cN6yavIhPc84+j09FkODW4JQOuCRQ73bJkh6/D+fvOn+CsSBptRdPDi4Y
 Zxd56OE6icT5/2OnB8jLl34IPeL8ByuHWaC8JH7dVHxz/0zvBXnviSejQ
 LQG7iqftz7dcyHyu75VlEsZFQLLmgD5/WgmTYTKne3MsqBCmk+ENgYAzC w==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815872"
X-MGA-submission: =?us-ascii?q?MDHFqjOjsc91RhfCD0/klwUmYDoYGk8/qStO5D?=
 =?us-ascii?q?Ar0SE3WnpUt7l3ADOYgYucoaof+GKxAa/MpCtdpEwGwu5WPXn/yt27aL?=
 =?us-ascii?q?S6yiXyFPoG7ci9RSPKEThnyETd1r7EXhatDGuSbpPCmwNyPjyVzrl8mP?=
 =?us-ascii?q?mYq5PFift25ktpWxnfpYKtCw=3D=3D?=
Received: from mail-he1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.50])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:45 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffovNp6ucwDyl1+r40lLUXzUgEJljMQSiMOaCohwvcoYN4/KOD37dnlxI+DEA3d3N8gZ3/3sEcl03xFYg0TRX7JXXTNLNveMeTpRbrPHN35Ax1Rdra9KTWo1jJi/xQuzkbtUZ/QfMVDN9QqM/KPeDmwVrpcsWDPge4Fiq79PX63sudOxajngiHRUAcnddpCC6mRCDYKR8FvoneT3xgSRH+XtVwZg5KynJwe4fw+vyiEeZxvf2dLAu/Ed+TOjvhl9ZZLoVKlXZMG3ReO0tv5AoKDmen5jhh1ksRAU+lZIv6U5AAGJFJazxc/nf2M1gAcCUGVrmbFlhKKTHe2T6ODnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIeu1ywuoHGYO6QCaomSD+w6mCyRsjhBCta6xVoRJDk=;
 b=I0EZD/em49GW5DkMyT0sxktO5ytLuApph28epCPuySBPOJfPdP5/ApSKp2+W7WfTcG8As64+3lwqMSyaZd6Ma+gGidgToVVcLn32uYyudKGZKjiuoRLGIfQbu7IR39gBMUG/MU96kdnd5B65AviHNK50dkP1Gt2PMgj7YK2BkwSI04P2bYGrkVdYwnhJwzTW7P/4W1dGkGl++UUMibOHJqi62D9Gbt05cMicHJwDgoLqxuNuNUoEoqXtnqrUhAED+Ym9RyEDVBsTIqeqFfqdDS1xxhd4rAYN+VRwbuScDj/hgT6ofJXJpOTG7u2GnZJLVN3GhdfNYurnU3NAxhFzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIeu1ywuoHGYO6QCaomSD+w6mCyRsjhBCta6xVoRJDk=;
 b=qEVqHazRcfn5VZxs16Cggc4pWkC1ShxUc44P8aj9LAFUkU0t5TVW+8s5OGXNf0iJqe+5iih3QCWoJN3RlkSQ+ix9FAzdxRisau38X2MZ0T6r4ZS7YfRrEtuUW8nrrTc/lpNA+gn9MXYUOjTHhyBKmtToKnuD5/EbGDOikFMx74lvx5ABOH5Y3nwEWzOcJS3M2ULe0WCgbZsY3w1yk40J7HASmVpH24TcpM7qS+EuaWO3hXxB2o6dv7M4G/rUEU+IjbROveGbiJWsiZ2EOYC5BVoI6nCvgja32IR4caaOqzmoU/BdfS/fX7rLTxvFjITaH7LXv9GNg51R8Ln7lfROXg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:38 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Thread-Topic: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Thread-Index: AQHatXs42Vo/2A63BES9fBhuPzCosQ==
Date: Mon, 3 Jun 2024 05:59:38 +0000
Message-ID: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: e06d7e04-1fdd-4b26-eaa0-08dc83925aaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TkdHVUNkUnhvYVJXUVdyWmd2R25venl5cGlYeE1QZCttZWROWWFCbTRDN3Nm?=
 =?utf-8?B?ZmFBRmxVa24rM2QzZStNNHY1M3hOVG1DYkdVby9kVzJhUDBKN3ZhVXVBS0Uy?=
 =?utf-8?B?eER1NUNTMTRjbkE4RzluTVRaZVJTR2VGenZnRkZtVzBYR0c2Z3h5a2JMUEZG?=
 =?utf-8?B?VjM1VEtPMGZNK2pmOUVWVTF4R1lNVk0wRVZWY2xGZGg1aHpza1FEa3FvbXNo?=
 =?utf-8?B?Rk8veXA5ZzFiM0tkVTRDbUl3eU9ybllvakVyL3d6YUhSSGc0Y3NiR3ZjQmZr?=
 =?utf-8?B?MTJ2cWRRRzFnTnBVSFU3bVp4Y2tEM3o4aGNlbndsVU9STkNIYVlkK3E0Q2ZU?=
 =?utf-8?B?aEFzemVuKzdmK0Y0MGFINEVhbm1YZGx3cmtUYWpQWGkrZTZmNitXREJzMTBF?=
 =?utf-8?B?cTRpVW1zSVZXcVhvOGFveWE3Yjd6RHY2Ymw3b3VtcXlvRVRZbXh0aENCNk5R?=
 =?utf-8?B?d09CMTRmOUI4UzI5YWxrT2pTMzdXYXQ4bVhuSDhPdXdsY2pycUREdUVSQmE2?=
 =?utf-8?B?VzZmZW9waFdhdkh2YjdYRVNPdkdoUERFV0wvaVdYTEZjMjVYMTZpQUthelg3?=
 =?utf-8?B?VktNSFF3R0tnY2N1Qm05WXhIcG1hY2J3TFNmNDBQZlJrWWpzeXUxb3JBK09U?=
 =?utf-8?B?ZldpS0IxTTFqV0FabDJLSlBoMW9NQzFjVHQvYURaU04rdHJZeFRPWjhDNkR2?=
 =?utf-8?B?dnhpUUhlaUxmMHJiWStBYldoTTNiR3ZKSlJsK0JySWErd0RCZUI2c1VkakF0?=
 =?utf-8?B?SkRmZzZJQkRXNk9aNkpPd3JrRHNJRFVEMlpYdW9mczBUemJZdGxnUVZVTkE3?=
 =?utf-8?B?dTUvK0FoMWcvZnZoOTQ3QmRZdDVBbUlYUGZoZDZUTDlSem9PU2F2Y3dPVTFQ?=
 =?utf-8?B?THV2SDVNZEpjVDBFaG1kVHBjWTE3Tmt6L2huUXl4ZE5INGdQZk5LU3dqR2xX?=
 =?utf-8?B?cHJPSVdaOW5uKzlhcWxxYmQ5TlE2elMrNUhQc0dXcjdpcU5ONm1uOTZ3YjlI?=
 =?utf-8?B?ckxacUVGK0UwcVJDVFRQY0lOOE9GY3N0bFBWd3BwRmMvcURlWnM3OE9IeDF0?=
 =?utf-8?B?NDlyeEhqNFgyWDBLOTR1bFl1UVZBbEx2VUwrYzd6SFlJWVdZVUdkMG9XL0Vl?=
 =?utf-8?B?RHVnMFRUU3o3VXA1L1NEa3ZlV1kvOENqQ2xuUE9qQ0s5amZWSGFYNjQ2OG42?=
 =?utf-8?B?ZTlQdVJaQUhVSktHdndONTZVVk51M2h3R1ozYXVrYUVYejlJbkZSQ0NFaHVM?=
 =?utf-8?B?aHg2UTJzaGNDa081UlcwRkkwa3gxeDNoMis2SUZ3VDlRZVQ4UzhWWFRxeEVC?=
 =?utf-8?B?L0hJT1JLZEJHS2xhckhmTTZFOVNtc2JrZEJ1VG1rbG1jbTU1eVdCTW5PaGh1?=
 =?utf-8?B?U0lFRm9Qdzlrc2JUbURPaUlqMUVFZE9vS2JyK0plVFlPek1zTUxnU0c2SHB6?=
 =?utf-8?B?MmtkUnBXclRsTjdDZ0FQY1JVMVZmbTZIeDVZN0o3ZWtLR2p5OGRjaStRQTBh?=
 =?utf-8?B?SWRleW5IcFR4VTJRZHNYTFZlTTRnZHcxZVZ2aWdPUXZPcHRXRWdoODQwa213?=
 =?utf-8?B?eXNhUWtNdHltYldvdVFYSnJDTkxtc1R4YWJ2NXA3UnNFZnFiTjE2bjhEMXZl?=
 =?utf-8?B?Z2N5WkFRUHNDc2N6aUFYTlVQNm9lcDZhclAwTklqbEFKRGdyTXdrZUZBallX?=
 =?utf-8?B?UTExSmEzSDRkUTd2NGc5anNBZE9oTldoSUtuQjE0Z3pvWEV0RWM5d1UxV3JW?=
 =?utf-8?B?SUlRZFJQYXRaZlRCZUFsMXk3bEZEVHNpUldYMm1Ld3kzWDV3cE41RUdBWmpT?=
 =?utf-8?B?VHU0ZEJ3cGlYeUQ5K2c3dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGNIamt1ZThZckdwS3E5NnNsZytnYTVMYVpielpiSDNnSWtOMEpsL0lxNDV0?=
 =?utf-8?B?bCtsWm13TklBRyt4a1p2T0pGeEEyS1RXQkFhY3JMMFkybVFGZk81Yzk5OWtq?=
 =?utf-8?B?Zjk1WVdMNlZqdXM3SGtRVEJzTVJrRnZIaE82cUV4b0VLZTc1bEhtV2MxNUls?=
 =?utf-8?B?TGVLYzdpTzdJdnBHckRzTGthaG5YWHR5K29xckFTaXhaOEFpZjhSeHdIVDhG?=
 =?utf-8?B?bEhnM24wNFJOK29NeE9rYU03am1BRmozSGc3UkQwRmMrYjk5Z1RWd2d0bnVp?=
 =?utf-8?B?bTJ4R0JMajYvZGhpZGlBUkhNR2xUK1h6RXRaYVp3ZUQvRmREeFFFdWY1Q1p1?=
 =?utf-8?B?THpvUURtMXlndGNTT09pSHZhbnJ5bTNkTnFiWE0wUEx0VkxkaGx4VVVmQkEz?=
 =?utf-8?B?WHJPSnNEenZ0M1lhR3hYaXR4NXdLUm1wT2k2OXpnQ3E3dGpiSHVtN2VSb3pE?=
 =?utf-8?B?NmZkZ2hKcWhKR0c5Y2QySVcxWUIvOGdFTk5GTm1EYjQ1cTRzU1FyMFUzL1RR?=
 =?utf-8?B?Y2dSS3FBMEJQUFpucmRYMnh3aExVSkZaQlM0V3U2bzFIOWplWHRtVjMwSUR2?=
 =?utf-8?B?OW04emFJUVBnYkQ3WEFQZlBHWWhiSUtPaWh3L2k2T3JxNnJuaUplSzkzc0xB?=
 =?utf-8?B?ZmlLdkplTEhneVdiV0QvV05HRXBwZjlpMDlsSEpQWVkwZzZoekVJR0p4Zkwx?=
 =?utf-8?B?MEVubml0dlh0VU1Nbnd2SG8rbzRGUTdhTTJvOEJpVDlZblZPN1ZWUW1hSUhY?=
 =?utf-8?B?b3dGZWlrNEtYUFhQWGVxVWYzd0Jua1RZMm9scWh5SUNnS2J6dWs5K21pQ0pk?=
 =?utf-8?B?Zk81RWRXMVhFQVRtUUw5WXlZRTY5eERkcEhVNFRBVGVUWkd1bzJkUjdwNXNX?=
 =?utf-8?B?YVNjU3BmTmMzeXBtMnQzS0R6U1RtMzVXdnB3dFNzd1FRSzRCWlhzL0NpNzYv?=
 =?utf-8?B?OEkxZnRxaC96bVFQMUY5UVJNWGMxWndvOWM1aGd1alRwdGQ1YUE1cGtacUpQ?=
 =?utf-8?B?bDByV1VRbTZrRTlJQ1hFZ2J5YlRYZkk0K3JiUm5vRGQ2Nmw1N2pNeXppeUxh?=
 =?utf-8?B?a1hNcHVIWENDd0QwTW4rZTNNUnIwdGRkclFMaTlrTHBYd1dmSUF2UlZKUmhv?=
 =?utf-8?B?dHpSVHJFN3RRU1o3N0RhVUVkeitMTHhWOXkvaWZtQTZDWHQwU2x3bzRtZWwy?=
 =?utf-8?B?MDFGRkp5aU9RbzNlYU9HTldub2FQUGlnUkoyQVJaOGpvQUU2Z0tUU1RDYjBU?=
 =?utf-8?B?aE1UL3lPMU1USldqcDJscFd2OFZhVWJxQ0RGU2VRakR3WTBCTnQ0SjRRa2NF?=
 =?utf-8?B?Q1M5VURjOC9wZGtKMm1ocGdLYlRJcGZBNTN6bW5aRlJNTG41L2hkSzBFK1JD?=
 =?utf-8?B?VzJnRk5hMHl5Z1BNVXRvenVlZ3BnWC8xNXV2ZEVhQmpsTXIwT0VFaXBRQWZJ?=
 =?utf-8?B?eHEwbXVETGVxTmI3ei9HQlVRMU9idzU5REFicFExNlVXbUVuYUtzWnRWb2JG?=
 =?utf-8?B?UVJyRmtNdXNnb003cDkvdDMrWW15Z2ExR24zeTBMdVp5ckY4WVo2bWZhWE5U?=
 =?utf-8?B?b2w3S1NWb214ZldBd1U1Q2tMRzE5TVpGZXYyWFJFOW5ZRklUTUtwcjF6NEU5?=
 =?utf-8?B?RFkvMysvYXp3WnF3TXRPRyt6UkJ3dG5NYm03N3dESjVDWmE2OUgzMi81SnNG?=
 =?utf-8?B?VUovWjBCVTBUODJ0b2laTTN0TGFROTdMR0FSRFRpNFFmV0QyaE9KN1BWZkg2?=
 =?utf-8?B?QWh1eUpvVlZiWUJiTlNoZEQyQ2pJMWIwY3FpTmxjUjl3REhDeW44WFhSb0t4?=
 =?utf-8?B?a05WaTlRdTZsRFlwZkpJeEdjZ1lzSXNNWWFZWjJDREkxd3dLUXB1VE9WaEd3?=
 =?utf-8?B?SEFnWll4RlVFTkRwalJ6WWhrM2x6WmxyMi9vUDNOdDN1a2VwMmI0VVdQL1pJ?=
 =?utf-8?B?eEg1OW4rdmplTlA2WHhJdmsyWGxPVkIyY1pHT0ptbkRjRGVnQkdDUGI0U0dL?=
 =?utf-8?B?SDRycDBHSE9MbEN4anZvaXhSODRiU3gwRHkwc0lFK3Azanl6bVM5NXcyY0V5?=
 =?utf-8?B?UjY1eVdzTGFRVFBrd2dKVHQ5R0QxZmFpN054U2FFeFRWcjFTQkZiK2ExaDY2?=
 =?utf-8?B?cDJMOHJiS0VxRFcyM2g1ZXIxZkpFRlc1SHlvZnM4U0xxYVFIUXdsVFBCNTBI?=
 =?utf-8?Q?tTOI2JQj31dbYTRSgKqsZWI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F16B28ACC8568A4E8E78D38A6A60F550@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06d7e04-1fdd-4b26-eaa0-08dc83925aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:38.9442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ih9MbTU4qJE65odQ34mPriZjYMS9g7koDaf+vKHyQUF29FRyhg2lwGjC3UKkdtigQZ4kUjup/Muu13xqMwJlMETnKODHsjy9FQIoSnb2H6/f7JHU6R8H4hcicCJ16Ctn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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
bi5jb20+DQoNClRoaXMgc2VyaWVzIGJlbG9uZ3MgdG8gYSBsaXN0IG9mIHNlcmllcyB0aGF0IGFk
ZCBTVk0gc3VwcG9ydCBmb3IgVlQtZC4NCg0KQXMgYSBzdGFydGluZyBwb2ludCwgd2UgdXNlIHRo
ZSBzZXJpZXMgY2FsbGVkICdpbnRlbF9pb21tdTogRW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRpb24n
IChyZmMyKSBieSBaaGVuemhvbmcgRHVhbiBhbmQgWWkgTGl1Lg0KDQpIZXJlIHdlIGZvY3VzIG9u
IHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBBVFMgc3VwcG9ydCBpbiB0aGUgSU9NTVUgYW5kIG9uIGEg
UENJLWxldmVsDQpBUEkgZm9yIEFUUyB0byBiZSB1c2VkIGJ5IHZpcnR1YWwgZGV2aWNlcy4NCg0K
VGhpcyB3b3JrIGlzIGJhc2VkIG9uIHRoZSBWVC1kIHNwZWNpZmljYXRpb24gdmVyc2lvbiA0LjEg
KE1hcmNoIDIwMjMpLg0KSGVyZSBpcyBhIGxpbmsgdG8gYSBHaXRIdWIgcmVwb3NpdG9yeSB3aGVy
ZSB5b3UgY2FuIGZpbmQgdGhlIGZvbGxvd2luZyBlbGVtZW50cyA6DQogICAgLSBRZW11IHdpdGgg
YWxsIHRoZSBwYXRjaGVzIGZvciBTVk0NCiAgICAgICAgLSBBVFMNCiAgICAgICAgLSBQUkkNCiAg
ICAgICAgLSBEZXZpY2UgSU9UTEIgaW52YWxpZGF0aW9ucw0KICAgICAgICAtIFJlcXVlc3RzIHdp
dGggYWxyZWFkeSB0cmFuc2xhdGVkIGFkZHJlc3Nlcw0KICAgIC0gQSBkZW1vIGRldmljZQ0KICAg
IC0gQSBzaW1wbGUgZHJpdmVyIGZvciB0aGUgZGVtbyBkZXZpY2UNCiAgICAtIEEgdXNlcnNwYWNl
IHByb2dyYW0gKGZvciB0ZXN0aW5nIGFuZCBkZW1vbnN0cmF0aW9uIHB1cnBvc2VzKQ0KDQpodHRw
czovL2dpdGh1Yi5jb20vQnVsbFNlcXVhbmEvUWVtdS1pbi1ndWVzdC1TVk0tZGVtbw0KDQp2Mg0K
ICAgIC0gaGFuZGxlIGh1Z2UgcGFnZXMgYmV0dGVyIGJ5IGRldGVjdGluZyB0aGUgcGFnZSB0YWJs
ZSBsZXZlbCBhdCB3aGljaCB0aGUgdHJhbnNsYXRpb24gZXJyb3JzIG9jY3VyDQogICAgLSBDaGFu
Z2VzIGFmdGVyIHJldmlldyBieSBaaGVuWmhvbmcgRHVhbiA6DQogICAgCS0gU2V0IHRoZSBhY2Nl
c3MgYml0IGFmdGVyIGNoZWNraW5nIHBlcm1pc3Npb25zDQogICAgCS0gaGVscGVyIGZvciBQQVNJ
RCBhbmQgQVRTIDogbWFrZSB0aGUgY29tbWl0IG1lc3NhZ2UgbW9yZSBhY2N1cmF0ZSAoJ3ByZXNl
bnQnIHJlcGxhY2VkIHdpdGggJ2VuYWJsZWQnKQ0KICAgIAktIHBjaWVfcGFzaWRfaW5pdDogYWRk
IFBDSV9QQVNJRF9DQVBfV0lEVEhfU0hJRlQgYW5kIHVzZSBpdCBpbnN0ZWFkIG9mIFBDSV9FWFRf
Q0FQX1BBU0lEX1NJWkVPRiBmb3Igc2hpZnRpbmcgdGhlIHBhc2lkIHdpZHRoIHdoZW4gcHJlcGFy
aW5nIHRoZSBjYXBhYmlsaXR5IHJlZ2lzdGVyDQogICAgCS0gcGNpOiBkbyBub3QgY2hlY2sgcGNp
X2J1c19ieXBhc3NfaW9tbXUgYWZ0ZXIgY2FsbGluZyBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNf
ZGV2Zm4NCiAgICAJLSBkbyBub3QgYWx0ZXIgZm9ybWF0dGluZyBvZiBJT01NVVRMQkVudHJ5IGRl
Y2xhcmF0aW9uDQogICAgCS0gdnRkX2lvdmFfZmxfY2hlY2tfY2Fub25pY2FsIDogZGlyZWN0bHkg
dXNlIHMtPmF3X2JpdHMgaW5zdGVhZCBvZiBhdyBmb3IgdGhlIHNha2Ugb2YgY2xhcml0eQ0KDQp2
Mw0KICAgIC0gcmViYXNlIG9uIG5ldyB2ZXJzaW9uIG9mIFpoZW56aG9uZydzIGZsdHMgaW1wbGVt
ZW50YXRpb24NCiAgICAtIGZpeCB0aGUgYXRjIGxvb2t1cCBvcGVyYXRpb24gKGNoZWNrIHRoZSBt
YXNrIGJlZm9yZSByZXR1cm5pbmcgYW4gZW50cnkpDQogICAgLSBhZGQgYSB1bml0IHRlc3QgZm9y
IHRoZSBBVEMNCiAgICAtIHN0b3JlIGEgdXNlciBwb2ludGVyIGluIHRoZSBpb21tdSBub3RpZmll
cnMgdG8gc2ltcGxpZnkgdGhlIGltcGxlbWVudGF0aW9uIG9mIHN2bSBkZXZpY2VzDQogICAgQ2hh
bmdlcyBhZnRlciByZXZpZXcgYnkgWmhlbnpob25nIDoNCiAgICAJLSBzdG9yZSB0aGUgaW5wdXQg
cGFzaWQgaW5zdGVhZCBvZiByaWQycGFzaWQgd2hlbiByZXR1cm5pbmcgYW4gZW50cnkgYWZ0ZXIg
YSB0cmFuc2xhdGlvbg0KICAgIAktIHNwbGl0IHRoZSBBVEMgaW1wbGVtZW50YXRpb24gYW5kIGl0
cyB1bml0IHRlc3RzDQoNCnY0DQogICAgQ2hhbmdlcyBhZnRlciBpbnRlcm5hbCByZXZpZXcNCiAg
ICAJLSBGaXggdGhlIG5vd3JpdGUgb3B0aW1pemF0aW9uLCBhbiBBVFMgdHJhbnNsYXRpb24gd2l0
aG91dCB0aGUgbm93cml0ZSBmbGFnIHNob3VsZCBub3QgZmFpbCB3aGVuIHRoZSB3cml0ZSBwZXJt
aXNzaW9uIGlzIG5vdCBzZXQNCg0KdjUNCiAgICBDaGFuZ2VzIGFmdGVyIHJldmlldyBieSBQaGls
aXBwZSA6DQogICAgCS0gY2hhbmdlIHRoZSB0eXBlIG9mICdsZXZlbCcgdG8gdW5zaWduZWQgaW4g
dnRkX2xvb2t1cF9pb3RsYg0KDQoNCg0KQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiAoMjIpOg0KICBp
bnRlbF9pb21tdTogZml4IEZSQ0QgY29uc3RydWN0aW9uIG1hY3JvLg0KICBpbnRlbF9pb21tdTog
bWFrZSB0eXBlcyBtYXRjaA0KICBpbnRlbF9pb21tdTogcmV0dXJuIHBhZ2Ugd2FsayBsZXZlbCBl
dmVuIHdoZW4gdGhlIHRyYW5zbGF0aW9uIGZhaWxzDQogIGludGVsX2lvbW11OiBkbyBub3QgY29u
c2lkZXIgd2FpdF9kZXNjIGFzIGFuIGludmFsaWQgZGVzY3JpcHRvcg0KICBtZW1vcnk6IGFkZCBw
ZXJtaXNzaW9ucyBpbiBJT01NVUFjY2Vzc0ZsYWdzDQogIHBjaWU6IGFkZCBoZWxwZXIgdG8gZGVj
bGFyZSBQQVNJRCBjYXBhYmlsaXR5IGZvciBhIHBjaWUgZGV2aWNlDQogIHBjaWU6IGhlbHBlciBm
dW5jdGlvbnMgdG8gY2hlY2sgaWYgUEFTSUQgYW5kIEFUUyBhcmUgZW5hYmxlZA0KICBpbnRlbF9p
b21tdTogZGVjbGFyZSBzdXBwb3J0ZWQgUEFTSUQgc2l6ZQ0KICBwY2k6IGNhY2hlIHRoZSBidXMg
bWFzdGVyaW5nIHN0YXR1cyBpbiB0aGUgZGV2aWNlDQogIHBjaTogYWRkIElPTU1VIG9wZXJhdGlv
bnMgdG8gZ2V0IGFkZHJlc3Mgc3BhY2VzIGFuZCBtZW1vcnkgcmVnaW9ucw0KICAgIHdpdGggUEFT
SUQNCiAgbWVtb3J5OiBzdG9yZSB1c2VyIGRhdGEgcG9pbnRlciBpbiB0aGUgSU9NTVUgbm90aWZp
ZXJzDQogIHBjaTogYWRkIGEgcGNpLWxldmVsIGluaXRpYWxpemF0aW9uIGZ1bmN0aW9uIGZvciBp
b21tdSBub3RpZmllcnMNCiAgaW50ZWxfaW9tbXU6IGltcGxlbWVudCB0aGUgZ2V0X2FkZHJlc3Nf
c3BhY2VfcGFzaWQgaW9tbXUgb3BlcmF0aW9uDQogIGludGVsX2lvbW11OiBpbXBsZW1lbnQgdGhl
IGdldF9tZW1vcnlfcmVnaW9uX3Bhc2lkIGlvbW11IG9wZXJhdGlvbg0KICBtZW1vcnk6IEFsbG93
IHRvIHN0b3JlIHRoZSBQQVNJRCBpbiBJT01NVVRMQkVudHJ5DQogIGludGVsX2lvbW11OiBmaWxs
IHRoZSBQQVNJRCBmaWVsZCB3aGVuIGNyZWF0aW5nIGFuIGluc3RhbmNlIG9mDQogICAgSU9NTVVU
TEJFbnRyeQ0KICBhdGM6IGdlbmVyaWMgQVRDIHRoYXQgY2FuIGJlIHVzZWQgYnkgUENJZSBkZXZp
Y2VzIHRoYXQgc3VwcG9ydCBTVk0NCiAgYXRjOiBhZGQgdW5pdCB0ZXN0cw0KICBtZW1vcnk6IGFk
ZCBhbiBBUEkgZm9yIEFUUyBzdXBwb3J0DQogIHBjaTogYWRkIGEgcGNpLWxldmVsIEFQSSBmb3Ig
QVRTDQogIGludGVsX2lvbW11OiBzZXQgdGhlIGFkZHJlc3MgbWFzayBldmVuIHdoZW4gYSB0cmFu
c2xhdGlvbiBmYWlscw0KICBpbnRlbF9pb21tdTogYWRkIHN1cHBvcnQgZm9yIEFUUw0KDQogaHcv
aTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgICAgICAgICAgICAgfCAxNDIgKysrKystDQogaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oICAgICAgICAgICAgfCAgIDYgKy0NCiBody9wY2kv
cGNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEyNyArKysrKy0NCiBody9wY2kv
cGNpZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0MiArKw0KIGluY2x1ZGUvZXhl
Yy9tZW1vcnkuaCAgICAgICAgICAgICAgICAgICAgIHwgIDUxICsrLQ0KIGluY2x1ZGUvaHcvaTM4
Ni9pbnRlbF9pb21tdS5oICAgICAgICAgICAgIHwgICAyICstDQogaW5jbHVkZS9ody9wY2kvcGNp
LmggICAgICAgICAgICAgICAgICAgICAgfCAxMDEgKysrKysNCiBpbmNsdWRlL2h3L3BjaS9wY2lf
ZGV2aWNlLmggICAgICAgICAgICAgICB8ICAgMSArDQogaW5jbHVkZS9ody9wY2kvcGNpZS5oICAg
ICAgICAgICAgICAgICAgICAgfCAgIDkgKy0NCiBpbmNsdWRlL2h3L3BjaS9wY2llX3JlZ3MuaCAg
ICAgICAgICAgICAgICB8ICAgMyArDQogaW5jbHVkZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3Bj
aV9yZWdzLmggfCAgIDEgKw0KIHN5c3RlbS9tZW1vcnkuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDIwICsNCiB0ZXN0cy91bml0L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICB8
ICAgMSArDQogdGVzdHMvdW5pdC90ZXN0LWF0Yy5jICAgICAgICAgICAgICAgICAgICAgfCA1Mjcg
KysrKysrKysrKysrKysrKysrKysrKw0KIHV0aWwvYXRjLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgMjExICsrKysrKysrKw0KIHV0aWwvYXRjLmggICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMTE3ICsrKysrDQogdXRpbC9tZXNvbi5idWlsZCAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDEgKw0KIDE3IGZpbGVzIGNoYW5nZWQsIDEzMzAgaW5zZXJ0aW9ucygr
KSwgMzIgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3VuaXQvdGVzdC1h
dGMuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB1dGlsL2F0Yy5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IHV0aWwvYXRjLmgNCg0KLS0gDQoyLjQ1LjENCg==

