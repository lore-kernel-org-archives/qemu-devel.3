Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A05C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRd-0007zX-8K; Tue, 02 Jul 2024 01:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRb-0007xz-2A
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:47 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRW-0006Ul-Tk
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899563; x=1751435563;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zkJMhn6Ml9XGShA6gJ/fp2L2yFf66JtkXA9Arp7muWQ=;
 b=mDzDwKNcf4OrkP7692aNIlIIHgaIAeIYmVab1pZycJ2fJoB/mKdm5MhB
 Gn0gpdB9Akik2glCUbeTnyOS/6whym7LuFV4vgL+ImucKBP9kkcqcPfXA
 CSG5XFPkR2MX11Bu7f24EbfnIXnX8KD8u21jxhB4I+Auj26bfsEKInk9l
 v/ViV8C3v/tgjWtYfp89dnAXhJf/jEXbpyAhuLiy75MISByLylJaUkDtt
 8Dmk7p6lsDmAerdIA0+dm68QudLKFYjXdwK/HBlXFMZrIDrleun6/B2TQ
 vxymLPnljEOoP77PipQnfWu/09DnFGRMWOi1UU39X+a241ukAz1cW1nwl Q==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15813261"
X-MGA-submission: =?us-ascii?q?MDHhY7anJcmo5OK/qn8qVgNTqarJdUYnIcuCAi?=
 =?us-ascii?q?mnxmaqPmm+vu5l0CNJ3vwygVe8W13B9V3M8ZZwAOCdGD17FVTLxFufwJ?=
 =?us-ascii?q?2cmhSYiXgHwiwqZkdKgQxCl4pJ267H57F1gTlbNWP6av0PCAU31r21KI?=
 =?us-ascii?q?WH2A5kzam70QYp2mP+MlVqxQ=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:39 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bph7u7PLUJgHgTtDcQeROqT9uJOj2Ge9lg2XHhyWNew4n2bJjMex3Vsjkw78UwR4vVCv3pcENf+ZNeaz1mZGrZe62nKqdxWKZbjpvHUzto8jQSybItiDQxGgmi80U8Yd5iAjhEE1kU7qu9HDfy+/F7PbJwS4XY3xMxSjjqjvLG6MiBTG41yMqQOF4nhWTXBpFDHiEGRi6DUqpYdtGbWKbED4fxjNqo37uaQtXJxQihIaBDcf55SJ2rVWXqGAvFGIYzTEqlUOdqiz3pYaQgoIlya/rLwe57HTX17iY3z+y+d76t3kKaO08XbgRMDTKCM/0RKCAWfcXRkcBqSsCkV79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkJMhn6Ml9XGShA6gJ/fp2L2yFf66JtkXA9Arp7muWQ=;
 b=Oijsr3KA+JeR/E138Wi8F/dJ5YaitbfFoZGI7yF34Mz+zi4UX5X7+tU4kYQxkmIWyZiGqmtaRVy7/XnhterFzOBnlOYLQxoxeB1IKzdoR9wB7JAlLU0rGjMrqMGPkU9jgMv2eRV8ewhJ/akV2bGSo7muaLuRN8ys4PaVq1eQmToDqtELIg2MJstxr2jG+Qm1PXo8IFLb9pCCR7rgX6kmr8AYcIQp1hYbiqNoLsSo2MtiZWJh0+M4FdIl9+dB8s0o6RP4uLgJQfNfcJnidIj1Eu6HG84CihdEZz8rCSEAk54ErOeuTBau7Xf38ream0/cBUa3jO1x3JA3MVDPeS6gbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkJMhn6Ml9XGShA6gJ/fp2L2yFf66JtkXA9Arp7muWQ=;
 b=Trcd7FWltE0pwvccyGdQ2/5xGOfX9935uqpdGlpmxUVuO3Vf1OmNruR2dZHCeV3zWCGaKxBycaql8idv+R1KT165xau21vBEGfc0Rn+v/aaIOtvLKQQvAjcb3qsA0gWjKlQWnln7z86DNT3bhSGF72hZUbQmjFzgTN+fjTolQW3fDh8xidrRGtDelZw5b8Fp4fdOT4Fdig7lzlKwO1LaudfAvx5d8Y8o9JpxWKlpxB3rPOUj3avPuMNcAC+aoDBKjc5ciUxe5mF8+la42dC7XEXi4Fklk/hrRobENuuu8SJ3ibLwwQ3IRvIchYzO/xWdRhgmWKx87rO5D4sRdDLn3A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:38 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:38 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 10/22] pci: add IOMMU operations to get address
 spaces and memory regions with PASID
Thread-Topic: [PATCH ats_vtd v5 10/22] pci: add IOMMU operations to get
 address spaces and memory regions with PASID
Thread-Index: AQHazEQLkXBRqmEjB0WGDgHUwGi0UQ==
Date: Tue, 2 Jul 2024 05:52:38 +0000
Message-ID: <20240702055221.1337035-11-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 51228d4c-2914-45ac-390e-08dc9a5b2de7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L0ZLVUdZd3VQeGJUTDdkRE4xV3dzb25GcHpnUjhXTHBpSzlPYS9rcHVwRlF5?=
 =?utf-8?B?bFVjQTdzdUFCUHRmNmFvcWZZUmpGaVQ3ZUhkdmhvcmIvYk8yL1BSblRXOGdx?=
 =?utf-8?B?QmxhcGNlZzk5aEV4RXYxdjNselZSK0xUZUhSYnJBNzY0SVRPSTFnenl5dFVC?=
 =?utf-8?B?TERZYjhCMzVUeU1aekIrYkdoZkh5T25rbDlZalA2TmFuTVdqYzBUWW92eVpy?=
 =?utf-8?B?NTROS3ZqUVlpWGZsak1pRlI0Z0RtZ00wOTdXQi9ySFJEeG1KV1A0T0J4a2VO?=
 =?utf-8?B?cEdielF6UEVnOWRWZFhQMzFKRjJldGVxTUFJNGgyVVE3SWt3dVpYM3JWQzYr?=
 =?utf-8?B?bGU2ZVJnS0dMSk9OQnJQQWM1NzFuM3JRQnk2eGdvYnppUnZQTERIaXNhaUZv?=
 =?utf-8?B?RDl1NFgrakl6WUorN2VzUTlyT2RONE9CcVNOa2lHelFieHMxVDE4aXBDMTBh?=
 =?utf-8?B?QWZkUTFMdGV0bCtJYkM3dlZPYkZqN3F1bjN4b2Q1OEp2Zm5ldHdHSjExZTR2?=
 =?utf-8?B?S3VpU2dWZ0hrRTJSK0RxaHRMNXpEMFc4RDNTZzdVTVVZTTZWSFREK3FwMmZN?=
 =?utf-8?B?ZmtUZzNkajdaWXlQS1Fkc2dtMkRRbkhyRVFjejQ0U0Exa1VNcVRza2d4UXlI?=
 =?utf-8?B?dzUyUGZiMThMR1pIaFVJU2JSblEyWnYwYURKbjMzeGg1Z2l0dDNYOHMvdXNt?=
 =?utf-8?B?bjRESGVOUGF1VXd2OWw4YWxHKzhGRUI3eFhNeGkvSEw0MEZCYjE2d2svb2lL?=
 =?utf-8?B?QWVKYkZIMnd4eFJOZHZFK1lEM2x0L3Q5RWR4THVDSTZJVTZ1UE9RSkk3QnF3?=
 =?utf-8?B?M2l1VEI2VEtESVFUd3I4QjA0bmFLUDVxNWxkRTBVQ1hDZmJudFhXejRYMUVj?=
 =?utf-8?B?MzAydU5pbXFvSW8yZzJWbi81U1kzOU55d2R6R3hCZzc3Mi9COXZlSS84M213?=
 =?utf-8?B?cFFhTGltbGlFbk1oQjZ2bFNEVmppbGdkR3B5UEJzdGt6N3VNNCtsdmxoM0xX?=
 =?utf-8?B?ZXB5TDA0UzJxNndpeG5wM0FraUpiMDVEWlhtYStXUmZFdE4wdGpJQ0JWd3Ax?=
 =?utf-8?B?UFpxMERLbGtCM1dSTTEyQnpQcGRlOUpkdkhhRnAwdTZ4LzVuSFdKT0VOd2hq?=
 =?utf-8?B?Uk1kQU16Q1FKSkpNeHlHaDlpK0pGSFQ1dFFJNXh0QkdCQnNMRVBTa1lvbUM3?=
 =?utf-8?B?Zy9tR0o2RjRNQ05sc05kMVArM252bTRGbEVQaXJuQlA5N0F1QzU5MXhPbFor?=
 =?utf-8?B?Z09qQW0rNVJOZkt0ZmQ1TWl1NmlsQXpRZ1Z1VXJvL1BYWmViTlVwL2k4bjk4?=
 =?utf-8?B?S3Evb3NFVW5WZUIvZzUySCtlbHhNZUljZTdrZjVaN3hNYkUvbk4yeVlzRnUx?=
 =?utf-8?B?aVV0RmovNWtpamFuVkFON2JjbW1EemllaTVoR1F4Sk43ZzhjSDZuUlhjM0tZ?=
 =?utf-8?B?dmJsZVBGS1pMRzNsbXFmbUkzSXJnNk5lY2hWbTFVNFc3Qm1DaXdUWmJ1a0Z2?=
 =?utf-8?B?M1hlNU53SXFyK2JQa244UHl4NHRjTEgrdmNTd0VteDA5dTBaVzlWVEZSc2Zu?=
 =?utf-8?B?ZzYraE5kSVdJdktsRjh1blhlUCs0TzVZaUVZWmtOeURFN2ZTZ0VTTkowL282?=
 =?utf-8?B?Z2M5VFE2b3ZZY1FoRVg3eEpza2tDa3lxSGcxazJLdVhReG5DUXVaYW91dlVC?=
 =?utf-8?B?ZFFPNWVnblR3SldTMjBUb2VQZ2pDTlRrUkxhbFBFeGhjTjYxWnNzTlhNeS8w?=
 =?utf-8?B?Zm96dFB1SGtSTDdTVktzN05ub1JEa3VCeElzTCthelRhclJ0WWNMTzE0MmU5?=
 =?utf-8?B?SE5VZEJvcDFpYlRPc3l1YWJHVmNPSExiS2d6T2xodmxsRzArOUtIQ3VPSFJ2?=
 =?utf-8?B?QjVKWkovTmVWMkNlWm1FUUFsRkNRZXkwaTBBc0RVTHBUdmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEhzc1N1YklZKzdUUDhpMDZNa2N6R0R1eXRCMHdvM1R4UjdTTUFDaWJHT2Jw?=
 =?utf-8?B?aUxGTGRQdzRwNlo4UllZMnArbTFEdzVUbnd3dXJTODRlaTVmam0rT0FlbTNw?=
 =?utf-8?B?YXlwMGhYdzJYTHpCZ0p3RGNua08vQWlQOWErcW5sTWZYRlcrVHNGdWY3S21T?=
 =?utf-8?B?aUF0MHJaWEdOaXdqUUhkaG5sQnJ0MHdqN0lIL3NWaC9JSy9QZkFDc3AwdHZF?=
 =?utf-8?B?TlBzZ3N2WUI3bUhuNDE2QURpdTB5Sk40Z0NHOHdHeWcwS1pjYi9rVGlINVZr?=
 =?utf-8?B?RS9nMkJRUjl3ekFGMklTRVRoeXowNFFIMzMzNUFRbnZmMzY5YlFkWjZGNEJw?=
 =?utf-8?B?KzRJb3g4dnp2ZkNDbVdTeFNZZTVWWmJmOWtycEUySEpscHRxNEpWODlLSGI5?=
 =?utf-8?B?NHAyOVUvZmpFVGtnWUhNWTRtL0dTTHoyUCtNVzFPVEdZY2hwSEJKSHdFdzlJ?=
 =?utf-8?B?dnRuMk1scWpUWGxUQUQ3VEQvaWZBMU94SkFIT2lpSGZZTDQ3dXRkRDJXNzVN?=
 =?utf-8?B?dTR5UkJ4ZldPS1hyeDFLaXdHcDVTbTNPS1doWUszQmlRemRiY25qOWRPY3cv?=
 =?utf-8?B?UGlXQ3lCR0tXU1o2VHBpTE1vMVUrd0lmYzJydlcrUXVIb2RYVnRvSTBkQW5R?=
 =?utf-8?B?a0ovcEZ6Sy9rWnBleTNkYXlrNnFYU3VNTEVPYU5BT0hjeC9ZL1hkTk9vcGZL?=
 =?utf-8?B?VmI5dlJQNi93VCtsY0J0Q3BxTjZWNmZybzhRQzV1VHBQckExVWlzbmJrSjBO?=
 =?utf-8?B?d28vS05jQzNNMkR6T1FDaUhvQ25BVE80Q1h6emlDM3dJaTYyN0RzOTJlampu?=
 =?utf-8?B?NWlEUUNSYUNjWnovRjEwSitSUUY3RTdRTThEUVgxVVV1N0RTL0ZaSFBVRlNx?=
 =?utf-8?B?LzRFSnNGbVVFd01KcEJJRnJuSnZ5dDFTZHdaREJ5cWdXYVpqUzdFell0YU9i?=
 =?utf-8?B?RjhOdHY5b0JvSWx5MEdNUHVmeFhFdzBFYlN1eTRUaGx4TFYvQU1KWjUvU0tW?=
 =?utf-8?B?NFUyd0FWYjZ2U0VpdEw1QTNKbytNZG9TMDB0Q3ZjZHVVOFJnQWtNd29GOEVW?=
 =?utf-8?B?MUdCb0xUZjRPaE9EZnp5a0hZUnk0VFBUbGZHUVFlMFJWRXdHVHhLZ1ArWGVh?=
 =?utf-8?B?ZlFTVThTTWU1ZzRRNmFLV0x0U3I4b0FtMkx4OFBKMmprTGZTdWRsTDhuNDVM?=
 =?utf-8?B?RGhtaityY2tsQ3BSd1FSZnhELzg3aDZlbXZlK1pIMUI2Z1BZMmVtdktKMENL?=
 =?utf-8?B?bnY4T3VYRGI5YlFCWUc5cE5FK1d2NEpDUGJSYWVHR0Q0SlZweVV2Tit3RzBP?=
 =?utf-8?B?NU50QjEwK3ZTYlZyZk1xSXpIZ0V2UDRsclFrR1QvM0lWdU4vQnpTRkJ2cFRs?=
 =?utf-8?B?aHdKbDFNeVhuMlNnQ2hBbi9nZm1PVmkwUEppNzVXbXk0MXVTNEtZTEgxa2lO?=
 =?utf-8?B?dE9ETk9CNEIzOXlrSTVRU01oek9pZmJPdlFhZ01ZdTlLZ3gySjhybDRiSmhk?=
 =?utf-8?B?VnFsKzdURnEvNHdlZzlpWDdWY1dKZkpvaG9KWVpjQ2VWRGwySFNWY0F2SDBm?=
 =?utf-8?B?TGdyRXY0TG1jbjRiMU5EQkJWOHBkODl1b0t2QWFHaE4xTUxkVThIeVNOSE1v?=
 =?utf-8?B?MHJCdmJRWHJIUk1LQzhOdngvV3J2YytxT25QYVR0ZjFJbUR5WEl0REI2eXFT?=
 =?utf-8?B?OEVJV2dEWjlVMmlBcDU0aVp5bkltVTgzd3pXVjJFOThVSWdrSFRCRkJ2OC9K?=
 =?utf-8?B?U0VCKzRuVnZ4ZVBySFRUYlBBbUUzY1QyMjRzUSt2RlBrbWh2cmROQmduYmt3?=
 =?utf-8?B?VGQ5d1ZkOFlQaTlyWUhrOW1NeWdyK1Z2bUs1T1ZibFBwcldqcUV1aUltZkJJ?=
 =?utf-8?B?RW9HNE9ZeFc1MTN2OU8wUHdRZlduQlVrS2J2clVibjBBQzBDUHlBUFBoTTlZ?=
 =?utf-8?B?ZkdnWmpYaVFoWGdtS0UzNU9KVnhhVER4WWdDWkVPcGtGckhOQk1SMnZPRGNN?=
 =?utf-8?B?OVV1T3BOVTJmN2R3aXA2azB6emdIWElrbDlLbWJvc2p1L3QxR0RiVVF1TGNC?=
 =?utf-8?B?WTR0NGowblZBakRUVFY1TTg0bzlXSjNLd2dFZ0g2SmQ5QTB6MXVKMVcyV0dz?=
 =?utf-8?B?U3pHOTBFWDVMVE52aWtKMWc4Q2tsSWhSNnpIeFNuT25YRXZLNzBXZ2xheTlq?=
 =?utf-8?Q?9ZrP+VVjkYVVSN0itBfFOwk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D60804810805E4A842D5B7FB3914E87@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51228d4c-2914-45ac-390e-08dc9a5b2de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:38.2540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQi6M1npZ/wGHKBukoSa7cz8gBLe4aE5Ysap9vhZ9a6n37vqrolx6rOQWtL1hcgtjwK+AqI0MU5Be3RCzZJ815LI0TRAtIHjdKh5QvzJqjFCXQlGoePrT4/YYw63ZBh2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvcGNpL3BjaS5jICAgICAgICAgfCAx
OSArKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9ody9wY2kvcGNpLmggfCAzNCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMNCmluZGV4
IDUxZmVlZGUzY2YuLjNmZTQ3ZDQwMDIgMTAwNjQ0DQotLS0gYS9ody9wY2kvcGNpLmMNCisrKyBi
L2h3L3BjaS9wY2kuYw0KQEAgLTI3NDcsNiArMjc0NywyNSBAQCBBZGRyZXNzU3BhY2UgKnBjaV9k
ZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldikNCiAgICAgcmV0dXJuICZh
ZGRyZXNzX3NwYWNlX21lbW9yeTsNCiB9DQogDQorQWRkcmVzc1NwYWNlICpwY2lfZGV2aWNlX2lv
bW11X2FkZHJlc3Nfc3BhY2VfcGFzaWQoUENJRGV2aWNlICpkZXYsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpDQorew0K
KyAgICBQQ0lCdXMgKmJ1czsNCisgICAgUENJQnVzICppb21tdV9idXM7DQorICAgIGludCBkZXZm
bjsNCisNCisgICAgaWYgKCFkZXYtPmlzX21hc3RlciB8fCAhcGNpZV9wYXNpZF9lbmFibGVkKGRl
dikgfHwgcGFzaWQgPT0gUENJX05PX1BBU0lEKSB7DQorICAgICAgICByZXR1cm4gTlVMTDsNCisg
ICAgfQ0KKw0KKyAgICBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAmYnVzLCAm
aW9tbXVfYnVzLCAmZGV2Zm4pOw0KKyAgICBpZiAoaW9tbXVfYnVzICYmIGlvbW11X2J1cy0+aW9t
bXVfb3BzLT5nZXRfYWRkcmVzc19zcGFjZV9wYXNpZCkgew0KKyAgICAgICAgcmV0dXJuIGlvbW11
X2J1cy0+aW9tbXVfb3BzLT5nZXRfYWRkcmVzc19zcGFjZV9wYXNpZChidXMsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW9tbXVfYnVzLT5pb21tdV9vcGFxdWUsIGRldmZu
LCBwYXNpZCk7DQorICAgIH0NCisgICAgcmV0dXJuIE5VTEw7DQorfQ0KKw0KIGJvb2wgcGNpX2Rl
dmljZV9zZXRfaW9tbXVfZGV2aWNlKFBDSURldmljZSAqZGV2LCBIb3N0SU9NTVVEZXZpY2UgKmhp
b2QsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KIHsN
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2kuaCBiL2luY2x1ZGUvaHcvcGNpL3BjaS5o
DQppbmRleCBlYjI2Y2FjODEwLi5hZDdiZDJhZGU1IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9w
Y2kvcGNpLmgNCisrKyBiL2luY2x1ZGUvaHcvcGNpL3BjaS5oDQpAQCAtMzg1LDYgKzM4NSwzOCBA
QCB0eXBlZGVmIHN0cnVjdCBQQ0lJT01NVU9wcyB7DQogICAgICAqIEBkZXZmbjogZGV2aWNlIGFu
ZCBmdW5jdGlvbiBudW1iZXINCiAgICAgICovDQogICAgIEFkZHJlc3NTcGFjZSAqICgqZ2V0X2Fk
ZHJlc3Nfc3BhY2UpKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbik7DQorICAg
IC8qKg0KKyAgICAgKiBAZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQ6IHNhbWUgYXMgZ2V0X2FkZHJl
c3Nfc3BhY2UgYnV0IHJldHVybnMgYW4NCisgICAgICogYWRkcmVzcyBzcGFjZSB3aXRoIHRoZSBy
ZXF1ZXN0ZWQgUEFTSUQNCisgICAgICoNCisgICAgICogVGhpcyBjYWxsYmFjayBpcyByZXF1aXJl
ZCBmb3IgUEFTSUQtYmFzZWQgb3BlcmF0aW9ucw0KKyAgICAgKg0KKyAgICAgKiBAYnVzOiB0aGUg
I1BDSUJ1cyBiZWluZyBhY2Nlc3NlZC4NCisgICAgICoNCisgICAgICogQG9wYXF1ZTogdGhlIGRh
dGEgcGFzc2VkIHRvIHBjaV9zZXR1cF9pb21tdSgpLg0KKyAgICAgKg0KKyAgICAgKiBAZGV2Zm46
IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyDQorICAgICAqDQorICAgICAqIEBwYXNpZDogdGhl
IHBhc2lkIGFzc29jaWF0ZWQgd2l0aCB0aGUgcmVxdWVzdGVkIG1lbW9yeSByZWdpb24NCisgICAg
ICovDQorICAgIEFkZHJlc3NTcGFjZSAqICgqZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQpKFBDSUJ1
cyAqYnVzLCB2b2lkICpvcGFxdWUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludCBkZXZmbiwgdWludDMyX3QgcGFzaWQpOw0KKyAgICAvKioNCisgICAg
ICogQGdldF9tZW1vcnlfcmVnaW9uX3Bhc2lkOiBnZXQgdGhlIGlvbW11IG1lbW9yeSByZWdpb24g
Zm9yIGEgZ2l2ZW4NCisgICAgICogZGV2aWNlIGFuZCBwYXNpZA0KKyAgICAgKg0KKyAgICAgKiBA
YnVzOiB0aGUgI1BDSUJ1cyBiZWluZyBhY2Nlc3NlZC4NCisgICAgICoNCisgICAgICogQG9wYXF1
ZTogdGhlIGRhdGEgcGFzc2VkIHRvIHBjaV9zZXR1cF9pb21tdSgpLg0KKyAgICAgKg0KKyAgICAg
KiBAZGV2Zm46IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyDQorICAgICAqDQorICAgICAqIEBw
YXNpZDogdGhlIHBhc2lkIGFzc29jaWF0ZWQgd2l0aCB0aGUgcmVxdWVzdGVkIG1lbW9yeSByZWdp
b24NCisgICAgICovDQorICAgIElPTU1VTWVtb3J5UmVnaW9uICogKCpnZXRfbWVtb3J5X3JlZ2lv
bl9wYXNpZCkoUENJQnVzICpidXMsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBkZXZmbiwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwYXNpZCk7DQogICAg
IC8qKg0KICAgICAgKiBAc2V0X2lvbW11X2RldmljZTogYXR0YWNoIGEgSG9zdElPTU1VRGV2aWNl
IHRvIGEgdklPTU1VDQogICAgICAqDQpAQCAtNDIwLDYgKzQ1Miw4IEBAIHR5cGVkZWYgc3RydWN0
IFBDSUlPTU1VT3BzIHsNCiB9IFBDSUlPTU1VT3BzOw0KIA0KIEFkZHJlc3NTcGFjZSAqcGNpX2Rl
dmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKFBDSURldmljZSAqZGV2KTsNCitBZGRyZXNzU3BhY2Ug
KnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZV9wYXNpZChQQ0lEZXZpY2UgKmRldiwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJf
dCBwYXNpZCk7DQogYm9vbCBwY2lfZGV2aWNlX3NldF9pb21tdV9kZXZpY2UoUENJRGV2aWNlICpk
ZXYsIEhvc3RJT01NVURldmljZSAqaGlvZCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFcnJvciAqKmVycnApOw0KIHZvaWQgcGNpX2RldmljZV91bnNldF9pb21tdV9kZXZpY2Uo
UENJRGV2aWNlICpkZXYpOw0KLS0gDQoyLjQ1LjI=

