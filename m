Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EA5C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9Uv-0005wI-1p; Tue, 09 Jul 2024 07:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR9Ut-0005s4-Fs
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:59:03 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR9Ur-0007hH-48
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720526341; x=1752062341;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=47++SvRSdwWasr2frv5NWCMwRnE7UHaGRQooq6aZOQs=;
 b=TW5a8Bgbv0Jp5wYZz2G4cnVCEcujElcEUAelGQ+OmrAyp/d9YaoqJy/I
 UFfKxkEr7n3dqkCrWO5UzfAq5lKz0NY5Y6ziHSCXinez2hs/vZucRIGqq
 FkeljD25oiU9mwUcXwySLSNJ6ZtpoWGldLiKUu44k3ZVhu93RGy6RpGx+
 AeZlK+ho2D9Rn16JxHr6IPut+mokQd+IdtRYjtCFyRy9v3ZbryDh+Bd+W
 HduP4L83FQrhu++FjmpBkkLPbFl0CoqVYqj1GLmnxyDODG32j63D0TMSP
 BpHjxol0nu+EdLlflPjfIg31x4ilPiMufCMjiRdEYG2D354x8pqnJxCko g==;
X-IronPort-AV: E=Sophos;i="6.09,194,1716242400"; d="scan'208";a="16267917"
X-MGA-submission: =?us-ascii?q?MDEbcRWYAhsUahkDZWz7A3FXCIJDZs3mFJ4KuN?=
 =?us-ascii?q?VN4erUMbtzEfvIvLnxdO8UCSafg7dyyUR6SSHmoouzDXCozbH66z797B?=
 =?us-ascii?q?7YwuUtFLBHAGUzCWhk608XuPGsHbgMpQb9nGuwdC2cnrSr1AHLG3Kfj7?=
 =?us-ascii?q?7IchYWcIJVo2TDE241Fcl8CQ=3D=3D?=
Received: from mail-vi1eur02lp2041.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.41])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 13:58:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8yS/KMPFYOz5k5qGFo2pw+e1BJzT7KABLJHRpeVSvU/BoXUHfkZPZ5tsA63nZAUIGVOA1NCwFqacqViZD1YqBWA/x7cEVE4N3Q8d5IA8/QRIOYGqLsmAAsdLT4rouE3EzS8s4emBJPn4BOhe4DpUA9e17+Y9ySmLLgkyQIlRXaDBwQX7yAjdQNYKig1w3OoN18vCcpWhlNhdpZXXa4AMheY7t2L3ncgji24j3CiwddeJNwk8g263vsM/eFsBGUXOnMP0JGp9GVJflLXgqC0YW0zJjsRHiX6ckFWxl3Umx1MjhvsMY3TApydph+QazhmPkRYj8kijWPn0pmYnVCj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47++SvRSdwWasr2frv5NWCMwRnE7UHaGRQooq6aZOQs=;
 b=EQqZzmFLQTkq78bj6jMBphnXXt+N+RvfBo9hC5QKSyTF5Lg1kDB3kwhQP01vJLuPhThrEsajlG/mEb5Iss2F+S0ATZzk/s0cpkt2S5AdXYSSnquR/p8pqdeqaT6qGmadPxHMWUZc/kNJ/NfJossr+Ivf7RQMQGEidxgnSV+cVvFEpsAEAviHRePrOszM2YZPq/JZ7AKfkmPiGS/M8169KWIKXriXjwKGGfwQcmPIC2P3kNBa/mxKWf3v/Y1xrJdjA5B+CQXmvLereHqhl7pvUmAcpNOia1skh/JvIZwv97cpZ3iJblp2ik06YRrWTD+DPTpTlLCMVZwVlg6Rm39mMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47++SvRSdwWasr2frv5NWCMwRnE7UHaGRQooq6aZOQs=;
 b=bs4Py+3QsxYTyWKsli7JG8s82zxE50ZX15c/XNOL4TH52k3k5K262BQrycGDrln2xWavMDQKQx45ILkO2DJ5dpmGl6DGNujPZ1cD6/tngXPoCfu4/2L+6BDHc/tcBsay3PLn9vVgaWSapqelFIQX6qx7Wl0DR/nDHMHdusVhv9a6Uh8WMvexdCe5xQrWSUYYgABey4evoqUFvvKkVJ4ajGWEUeHgjeLuiUiRdG7/HnAJzzacA8SNPIQrieqDxyNIW59Qk4DoD0LoAF90V9j49ZH0M/kTy2ZulsVgeL1gvkeKCNk8Gf+OztKWOj+uPDkqsSkoO5dyZSQ2TlsjLHhDdw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB9984.eurprd07.prod.outlook.com (2603:10a6:150:11b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:58:53 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 11:58:53 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Minwoo Im <minwoo.im@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Thread-Topic: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Thread-Index: AQHazEQPZma3+RPBzE6mhYIQQIOAh7HuOTAAgAAdBIA=
Date: Tue, 9 Jul 2024 11:58:53 +0000
Message-ID: <929fc1df-0a19-4da0-8399-5d792dd25684@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <CGME20240702055502epcas2p2f54e3234f35d28e73513a5634a7cb03a@epcas2p2.samsung.com>
 <20240702055221.1337035-21-clement.mathieu--drif@eviden.com>
 <Zo0NpttNP8OkrOG8@localhost>
In-Reply-To: <Zo0NpttNP8OkrOG8@localhost>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB9984:EE_
x-ms-office365-filtering-correlation-id: a9f411ba-c3e7-4f4f-0c96-08dca00e812e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TWI5d1BScFBFMkROZ1pnZG1rRzQ4MmtHdDgxRFNXQ0NMaktCMU9GVGFnWGU3?=
 =?utf-8?B?REljSHYyeUdXS3Zwais4c2JCOTl2ekpEUTRGajJjNG0zZHp1QzJjbnBDWk9P?=
 =?utf-8?B?ZjdDWUExSUl4bVhUblpIWkdkQkFTUXg2d3drdHBtMk5UQjIydE9OTEM1N25V?=
 =?utf-8?B?cUZyaHFFNDFVUmR6YzdvbnVkckhmaVhXblg0SkpxekdUMDFVNTNNTkQ5Ti8y?=
 =?utf-8?B?Wm5GNlRaRWtZRGpkSVpjemhCRzNGSUg5allXVnZsNGRZdVZFeHNIQkR4anpO?=
 =?utf-8?B?bUhZYVhLYXRyb3JRNS9ZRlM5Ujd2dStEbW1XWHZNdCtyV3hBTzhSVWNRTDQz?=
 =?utf-8?B?SHNvSzRkdzRlb1ROQk8rVTVCdnBneUwxZ2VSYklYcU40VXA4ZUorYWlhMWw1?=
 =?utf-8?B?dVhmaHhiTG43TDU3T25LUXkyK29kdzhSRWFnc3AxUnN3SnQ4L1AzODA3TkRq?=
 =?utf-8?B?enVsMVBxL3lPZUVIQ1NqamhQRmRMdVBDc1JSdTF0NmF0bDJOekwwcDd1UEp0?=
 =?utf-8?B?YWR4THZoQUs0akxDV01SN2Ric21QdDJxS1FGci9GM3JXT0JacXlINDBHcVAr?=
 =?utf-8?B?UUZLMC96WW9wOHNtRjJIZFRUNExzeHNWbWhldDFPeEJ4UEdzbXZUZkd6TVR5?=
 =?utf-8?B?VXNIRUxoSTBuUzdHL3craXJsWHBIZ2cwNll5NlAzdGUrUndUc2c1WkwzcW80?=
 =?utf-8?B?Y1VLalREVnJ6MG82RUcyK0FTMkdVRktEdjlEbnU3QUcwL1loMmRnYlJtaGNF?=
 =?utf-8?B?eWlRdWEvWGlTYnZBaUY0TUhVVmk2UkdJd1FPdEI5b1RmYk41K1hWZkNZKzRE?=
 =?utf-8?B?eVJKYUJraWF4eCs3NHU0UXN6eFMvdTd2NnJCMDlranpwYm1nSEMxanpsYmR5?=
 =?utf-8?B?STZUZWRCZy9EbW5pa1UyR3VLdHgzR3pabXdIRGY3UUd4QlpKM1ZzSnFYbktv?=
 =?utf-8?B?ME11SlJtL3YxbUdJbFhuMTNBMndZZTdsWW10UWl2TGErNDVIU0VGQlhOOHVq?=
 =?utf-8?B?M2d2L2hLL2dEa2s2YWNGRGlvOGxuVXl0M0RQczNhNUhpdzUranNCaFd6bTRI?=
 =?utf-8?B?VFVwMmFDVUJHSlBoaEc0Rm1tSmk5R21VM09EcUx5TE5MWU0vbU5zbi9odS93?=
 =?utf-8?B?clBHZ244UFNyYkc2U3pZV1daOFdqcGx6Ym1VV0NocU1wNnRHNDVwZ2pvQ29O?=
 =?utf-8?B?c0YrSVdzV2ozak5vdkdlcWFxRDAzeW9FNVdQZEpibytBU2lkQnA3NzZJTlRM?=
 =?utf-8?B?NzZZOHB2dTI4YmJJOFp1eFF0N2FicVBsR0d5SjV4Q0lEV3FlTk1tNGxBTnNG?=
 =?utf-8?B?MTNHSkQ5NFpKa3JWTUxyU0RSTVpnelBTclRKS0NWbUVQMVkzNlBjd2ZFTXBC?=
 =?utf-8?B?QXBqenU0eUw3cTIzZmgyaWd3ZUxpbXVTY3JEOVNCaTRRT0hNZVVEWWE1ak9v?=
 =?utf-8?B?ckF3bGhTTGt4WUtPYWJHZ2x2ZGlDbmY3Y1o4U1lrRTQ3bTJMTGEyYWtDRWVC?=
 =?utf-8?B?b1VMQTltbnFCSldPa1Rabi9QbEdVNUYxME1KVHVhMXJVcm9FeWxlTndMN2k3?=
 =?utf-8?B?Q3BSVnBFOENUQjlaSTNnZ2t2WDlMYWkxdHM5VElWMXlvZHRLWDRXTVZUZEJ5?=
 =?utf-8?B?OURLM3pvdTgvN2tONU1jMFZ5Nkl6VlVMNS9HbkJKTW1NMlJpNXE2cUgzWnNp?=
 =?utf-8?B?V000dnk0KzEvK200NmpqUkR2RUx0MUV0MFR0dlZFZG9vR1kyYWJQSDcyRlZQ?=
 =?utf-8?B?bnVML2p3S24rbUpNUkY5RU5DSGorN1hrd3pjMGhoaXIveWc1enFDa1lNS1NJ?=
 =?utf-8?B?Y3YzQjVrbVRyUXdhMnpkNmxuYkRkVEwrSXlTY210QllQV1BndkowN1AwWSto?=
 =?utf-8?B?aGtPcnVyRGtocDUwSHZjR2M1WkV3T09JeU42b3htRlYyTkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3EvODN5OE8yZUFheThKelczN3E1TEw4T3dDWFFYbGRtZEFOaGZIVHM4cGVj?=
 =?utf-8?B?aWIrbGRsV1dHNmZTaUdIbmMzb3d2aGRCVTFaWXhRMWlWTm4zYTBzUDJuaHNt?=
 =?utf-8?B?T1BaWEZLUWxmc3JrNHc4VklTU2YvUU5VWjVvbHQ5NTlZdmM1RzhWbUNKOWRT?=
 =?utf-8?B?TXRKSGllYWZsZmNPOWJiRytLQ2MzTkFscGEzdHh2ZDZKdzR2dWw0R1lwT0Zk?=
 =?utf-8?B?YzFlMDVremNFV0Z6U2h1Q0VCRzNOT1liQzhud3oyWksveHFJWDFGZ0E2anR4?=
 =?utf-8?B?SWhTWjJBcHp2bnZncE9UNC83RnJxYWcyK1NlT1ZiMzhia0tBQ2oxNCtOcVd4?=
 =?utf-8?B?Nm5rd3RweGlCbFVRaFhlQmRLVlhCNnpDTXdKSkdBdDRQNWVMMXVhcitocWRE?=
 =?utf-8?B?SnZYQ2c5akdnTCtFdFY5c3Q5V2JyM1cyYTlRL3VPN1ZTMnJ0UXFneWk3Smlu?=
 =?utf-8?B?SDd1cEZUaklVVlU0NDlNUGtRbUk0OCtYbUpuVU9Zb0Rzb29QUDdnaGJqNlRM?=
 =?utf-8?B?a2FKMnR1YlhoRzRtK0RqMXVlWWkzT3JQelRtQS94TDNxODludnlmbS81cnRY?=
 =?utf-8?B?ZWdWNkw4K2pLOTMrR2pBV3IzSndNZGNERUViTjQ0VFc5QjYvMUZOOHlEa0lJ?=
 =?utf-8?B?NWE3bGFBSXF4Y2xHWGR1amI1bGxERkZBMDlaR2l4TmlKUlUxZ3RkY083Z1U4?=
 =?utf-8?B?b1J2dmhyMzJKdDZrUCtnOG4zRHFNemZDSkk1eVQ1bzlPOUVvS2krdGZxRG5C?=
 =?utf-8?B?OG05S0hVWHNNaWRaM2Q3SktaT2h0WXFhQnRuT1R5bVZPU0JCaVVOZHNTOGpC?=
 =?utf-8?B?bG9ETnB0RDEwcmdNMjlWUm5jTkRXNGNXTWczYW1pcFlzeUtkcHBUeDVSTjQz?=
 =?utf-8?B?US9IRk92bHhRcFJsbnE1VDhUQ3dXbG9kN3JZNS8rZkY1WjVSdHZ4OHR2aHIw?=
 =?utf-8?B?SjBPUWVTM1liT3hDc0k5M0RVVCtPaG4rRVZzOFRDUlduc1U3OTZZbHF4OGJs?=
 =?utf-8?B?dXNKZm52TnpCTnpzVGxDVDlFS1dSdlBjNlMxREJtUGdUdzFkRlhucWhpdmg4?=
 =?utf-8?B?NjRzci83bnpXU05ETUlUSDlBTDY4Z2ROR1hYVFFJMy9ZbGJwOW14V3dOL1Zy?=
 =?utf-8?B?ME5tLzZQSjhvc1FERUtLMi9kdDNLdUNiU2pQb0pxbUczajk1ZHJSWWtQbktE?=
 =?utf-8?B?eVI0dVdWRG9wQ1VSejRia0l0NlhQbVo0ZUs5SUN5SWo5QWd5cFd1RCtQRnhw?=
 =?utf-8?B?d1dIRmFNc0VrdENUaVNQVURyaGVnWjh5MGVuT2ZPdWpYcW9Mc05Fcm1zazN4?=
 =?utf-8?B?Y1prbFl0ai9UUERpajRWRkNBT3BYelBXUVVsTjgwWDJqbEZkeElIejRpTHFs?=
 =?utf-8?B?NVVyNEtrUXpZc2l6MUd0U09aNGpSU1BWeGlHNFVnVE8wc1FKbGl0amptNm5S?=
 =?utf-8?B?NjB3aExGOStLbXZlK3ZyYUZpL1pjaTIvSmpYZEhFRGxvOWlZT2x0RTBZa0ZL?=
 =?utf-8?B?L25LL2xRdE1CM1AyaGY4a3lyUnN3M1N6UGMyRi9WSFF0R21UMFg0YXJpS0lT?=
 =?utf-8?B?QnZNeDRjQ2NXamc3L3pyN0hWRWxnK3FZem5wcldoSkR3NmlkY3BMdm80dnJS?=
 =?utf-8?B?S3NzeDhPUVQzdFZoalJoRm9Hc3hEQUlKbVpVYjNXM3dOM3JDeTFwNjBwTnor?=
 =?utf-8?B?ZXMyL2lLbWtZNyt4RFVOUStFa0pYMWl2dU9PY21QWHdCeWw4d0d5ekZMUS9I?=
 =?utf-8?B?dzFCT3F4Q2w5Zk1FYm9RaktxKzFtU21IZkVxeXltNXZuOVBtcXl0d3p4SUdB?=
 =?utf-8?B?Ky9Hblk1enIzWXJ6NWkzVE1LRUtvckwvTnlIajYyczlJNzN6NnA5bzI4UUhx?=
 =?utf-8?B?dFc5d1hkT1cwYlRhMDArd096RDgzbjVGWGFabVlHeitUNW5wTC9zeFcrbzBQ?=
 =?utf-8?B?MVgwTUwyeW4rU0s4VmpDRnRoMk5ydnk0ZklpVVhveit2NXdTQVpDMWlnTUdq?=
 =?utf-8?B?M2tmOUtLU2FMempJSTVjU3R0bWVmTEtqZVpSSTlkam5kSEUzMXdCd2NId1c1?=
 =?utf-8?B?cllUWlliZzY3Z2I4d2FwYlgyNTJ0azk3YjIySFNVUDZxVWIxMFBkZnRJUGo3?=
 =?utf-8?B?VGxkL3pzSGJEZlplZXlvL3Y5V25NU1pwbFVUU1dnckRkTTMzOElhZXFibkI3?=
 =?utf-8?Q?Ep1AwbLWVvL++5I6prmxSfQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BF0A4EC24E4A84F8CEB7A4FA9ABFB45@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f411ba-c3e7-4f4f-0c96-08dca00e812e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 11:58:53.6522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6W9jBrIMG3inms8ZH+LsKE62EKRnQeJ+FMEsItmlnRGutLtUHLzLPE/XxfJ+xK7JdnKqRvj8VHtFdwFRWVrWzZiSlvqe6XqBdradd/JexAS/Q0Gn7rOXb6XpLw/5L/Ve
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9984
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIDA5LzA3LzIwMjQgMTI6MTUsIE1pbndvbyBJbSB3cm90ZToNCj4gQ2F1dGlvbjogRXh0
ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxl
c3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiAyNC0wNy0wMiAwNTo1Mjo0NSwgQ0xFTUVOVCBN
QVRISUVVLS1EUklGIHdyb3RlOg0KPj4gRnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xl
bWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pg0KPj4gRGV2aWNlcyBpbXBsZW1lbnRp
bmcgQVRTIGNhbiBzZW5kIHRyYW5zbGF0aW9uIHJlcXVlc3RzIHVzaW5nDQo+PiBwY2lfYXRzX3Jl
cXVlc3RfdHJhbnNsYXRpb25fcGFzaWQuDQo+Pg0KPj4gVGhlIGludmFsaWRhdGlvbiBldmVudHMg
YXJlIHNlbnQgYmFjayB0byB0aGUgZGV2aWNlIHVzaW5nIHRoZSBpb21tdQ0KPj4gbm90aWZpZXIg
bWFuYWdlZCB3aXRoIHBjaV9yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXIgYW5kDQo+
PiBwY2lfdW5yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXINCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZp
ZGVuLmNvbT4NCj4+IC0tLQ0KPj4gICBody9wY2kvcGNpLmMgICAgICAgICB8IDQ0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgaW5jbHVkZS9ody9wY2kvcGNpLmgg
fCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAy
IGZpbGVzIGNoYW5nZWQsIDk2IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcv
cGNpL3BjaS5jIGIvaHcvcGNpL3BjaS5jDQo+PiBpbmRleCA3YTQ4M2RkMDVkLi45M2I4MTZhZmYy
IDEwMDY0NA0KPj4gLS0tIGEvaHcvcGNpL3BjaS5jDQo+PiArKysgYi9ody9wY2kvcGNpLmMNCj4+
IEBAIC0yODMzLDYgKzI4MzMsNTAgQEAgdm9pZCBwY2lfZGV2aWNlX3Vuc2V0X2lvbW11X2Rldmlj
ZShQQ0lEZXZpY2UgKmRldikNCj4+ICAgICAgIH0NCj4+ICAgfQ0KPj4NCj4+ICtzc2l6ZV90IHBj
aV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbl9wYXNpZChQQ0lEZXZpY2UgKmRldiwgdWludDMyX3Qg
cGFzaWQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9v
bCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBod2FkZHIgYWRkciwgc2l6ZV90IGxlbmd0aCwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIG5vX3dyaXRlLCBJT01NVVRM
QkVudHJ5ICpyZXN1bHQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3VudCkNCj4+ICt7DQo+PiArICAgIGFz
c2VydChyZXN1bHRfbGVuZ3RoKTsNCj4+ICsgICAgSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21y
ID0gcGNpX2RldmljZV9pb21tdV9tZW1vcnlfcmVnaW9uX3Bhc2lkKGRldiwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwYXNpZCk7DQo+PiArICAgIGlmICghaW9tbXVfbXIgfHwgIXBjaWVfYXRzX2VuYWJs
ZWQoZGV2KSkgew0KPj4gKyAgICAgICAgcmV0dXJuIC1FUEVSTTsNCj4+ICsgICAgfQ0KPj4gKyAg
ICByZXR1cm4gbWVtb3J5X3JlZ2lvbl9pb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihpb21t
dV9tciwgcHJpdl9yZXEsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGV4ZWNfcmVxLCBhZGRyLCBsZW5ndGgsDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5vX3dyaXRlLCBy
ZXN1bHQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJlc3VsdF9sZW5ndGgsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVycl9jb3VudCk7DQo+PiArfQ0KPiBDYW4gd2Ug
dXNlIHRoaXMgZnVuY3Rpb24gbm90IGZyb20gdGhlIGVuZHBvaW50IFBDSSBkZXZpY2UsIGJ1dCBp
bnNpZGUgb2YgdGhlIHBjaQ0KPiBzdWJzeXN0ZW0gKGh3L3BjaS9wY2kuYykgdG8gbWFrZSB0cmFu
c3BhcmVudCBhYnN0cmFjdGlvbiBmb3IgQVRTIHJlcXVlc3QgZnJvbQ0KPiBQQ0kgZW5kcG9pbnQg
ZGV2aWNlIFBPVj8gIEkgZ3Vlc3MgaXQgd291bGQgYmUgYmV0dGVyIHRvIGhhdmUgUENJIHN1YnN5
c3RlbSB0bw0KPiBpc3N1ZSBBVFMgcmVxdWVzdCBpZiBwY2llX2F0c19lbmFibGVkKGRldikgcmF0
aGVyIHRoYW4gY2FsbGluZyBmcm9tIHRoZSBlbmRwb2ludA0KPiBzaWRlLg0KSGksDQoNClRoaXMg
c2VyaWVzIGFpbXMgdG8gYnJpbmcgc3VwcG9ydCBmb3IgU1ZNICh3ZSBhcmUgdHJ5aW5nIHRvIGlu
dGVncmF0ZSANCnRoZSBwYXRjaGVzIGJpdCBieSBiaXQpLg0KIEZyb20gYSBzcGVjIHBvaW50IG9m
IHZpZXcsIEkgZG9uJ3Qga25vdyBpZiBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIA0KaW1wbGVtZW50
IHRoZSBTVk0gbG9naWMgYXQgdGhlIFBDSSBsZXZlbA0KYXMgaXQncyBzdXBwb3NlZCB0byBiZSBp
bXBsZW1lbnRlZCBieSBlbmRwb2ludCBkZXZpY2VzLg0KSG93ZXZlciwgd2UgY291bGQgY29uc2lk
ZXIgcHJvdmlkaW5nIGEgcmVmZXJlbmNlL3JldXNhYmxlL2VuY2Fwc3VsYXRlZCANCmltcGxlbWVu
dGF0aW9uIG9mIFNWTSB3aXRoIGEgc2ltcGxpZmllZCBBUEkNCnRoYXQgd291bGQgY2FsbCB0aGUg
cGNpXyogZnVuY3Rpb25zIHVuZGVyIHRoZSBob29kLg0KDQpEbyB5b3UgaGF2ZSBhIHNwZWNpZmlj
IHVzZSBjYXNlIGluIG1pbmQ/DQoNCiA+Y21kDQoNCj4NCg==

