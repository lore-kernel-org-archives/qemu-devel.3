Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E04CD6EBE5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfj-00081i-Cc; Fri, 29 Nov 2024 02:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfb-0007z7-F9
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:09 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfU-0002l6-C2
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866240; x=1764402240;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JYTIqof7QhuFRW4wADhZR8s7wPY2u4yiamG1OLfdCiQ=;
 b=IFrUYJx8YDNqFtGSAwbOr6c30DgVqJ4c1aqnIuFfxar7gFZSY/x7Q5sr
 /qOWOv0tNIxK30FpBAi2JcllUrz5ZsM+52w0nFwZTQ3FpYuWajV1rbVc6
 np2XmQ/l1CMg6qZJfMExcLLphe65LqqSn1MRfI51bQmWWw8bP6HdBsV3r
 BAWtZFivQOiEh1uSPN4qjTIeQLlVVcPMhkGN//RB73wvxBaIuTw1sTGz0
 W/Kfxm068U0Z1I+bJFKu23itRrKRx2eI8nGHnkt7DPYPB6MQ6pd4x+bn6
 g1K7wSP83eo94r9TCY4WPpYHgr5NiI8fhWTlt+Gu81NSdpjhn6TWSlyIF A==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25664405"
X-MGA-submission: =?us-ascii?q?MDHYsGRhdcfUuLh3lc4jqcYd0pwONASn3+DS+Z?=
 =?us-ascii?q?JCBBXl5aUnpNfMcRnmMeXM5RBnrxo8t+rmXLWUQy2+em8CZ5ptQ7ya05?=
 =?us-ascii?q?2eFCQAxtGHpOx2dtmn0+GzZoJUnZXnWJlo2IEoVdc7cX0Ir2gor602fM?=
 =?us-ascii?q?MtKDtO7sf77hpVjOOEpfNv4Q=3D=3D?=
Received: from mail-am6eur05lp2109.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.109])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:43:58 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxBKPxVbuBgtbSRQTMiErk6c/NRJfG6qjR533Lc8eFKmE1dKpixWIgveQgsvDPar6hhvOxjl05aTUPinXoF90Zl1HoOH+F3LZhpptkdh+/0Wl47wESI+0pM2k5g69bJcn9XkXAqcqgh8Vuzfgm8Hxck+42FGLDVNILeh8YIAg/6v5+wMKqe0V6ANCn994XeRfSmYZVGjH731qpBA959r7BNdDVO/kLFA487yw+Od7mVJuA6fAMnqtbw5SWjSqGFzB9N8cL3YmrX9tMvjssWGxxLJ52+xgb6JL8Sx4tF48gPaVSrgngf0Hp7ttFIc58i60yLuuKkTD3P8s4AotFXScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYTIqof7QhuFRW4wADhZR8s7wPY2u4yiamG1OLfdCiQ=;
 b=LxR/Ym1wRisIc17KZjjUlOh5nT2zwZq2DPlSSWFrBCFrtPAdvPBxuYVgU+qs6y9ZhI/ffUA8KrEn63dmcI4pcgYqlITBhjrAQeaNyszP5nxVLeacQ2ZKrw2qtRvAiIyEiNetFLXgx9uZHvf2/g1gtqtV9mbqFpZcUeOug42Zlml610emiPkkq6LKzCskoWZdWYxD7kOwOQr2iIU1oV424i8p7pNQIUuojn1StQ9v0YC4Sjts2LgJMkjPg8NmR7EgPtW7GTpCeO5J8pLD846QAluB0/QLAJtqlkX9zJB8YHCYcHQDMz6Ibx07Ud/tWqLa+L7uwyq+YxqA/QSxkqTfhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYTIqof7QhuFRW4wADhZR8s7wPY2u4yiamG1OLfdCiQ=;
 b=oc9C2uzQ8x9mD3UOcFC4sTIyPKKTbk77Q5UhnV5s64m3CFu+9ayT2mP/IAres54B5GcNvgP/Y/Mo7d0Qq8akB1r0hgx8pbtNOLfALD6vTI5dgn7NUFS0+w98VbYqYz7XTow1rKfLSyIIcVzvhXClwr0Hm1KBayRJIyfb3awpytipi3icpBXSTlSP/sUAkVrap1s3f+PxQckOZ0ux85lZ2HRKUm6kRWrGXf7ZUfV5avn+ltdSUvDDAdd5EydVDka+0F/Ioli4LyIClX8dDxevvoeIoJJStNIfciqchdeCxq0pa5i/eFGuRKdzHIsCoW9w+hFP6NZqIS2pQZOJsFA0Tw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7847.eurprd07.prod.outlook.com (2603:10a6:20b:39e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:43:56 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:43:56 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 09/19] pci: Add IOMMU operations to get memory regions with
 PASID
Thread-Topic: [PATCH v1 09/19] pci: Add IOMMU operations to get memory regions
 with PASID
Thread-Index: AQHbQjJxlly1mLkXtUGLosCh8+EKPA==
Date: Fri, 29 Nov 2024 07:43:55 +0000
Message-ID: <20241129074332.87535-10-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7847:EE_
x-ms-office365-filtering-correlation-id: b506727f-506c-4449-0fb9-08dd10499445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?R0xacnRmRElvZkwwNXNPaDlhRTkvRFFleTNGc3VmcVR4dG81RjNzT0dLeW5x?=
 =?utf-8?B?ZVZ6d0gwMVg3UC9oTmhJN09TWXppMVBIYzF3NVBRL1Z0bUowRFJwMWZVNW9a?=
 =?utf-8?B?UVcyOGhxMzZ0OG1obG1iZjlzVHM4ZlkvbThRazBnb1RNa3NEWVIvc0JzMmNR?=
 =?utf-8?B?TDVlVWJpb1ovUkkyZCthTGx4SXVGeE91SVpsNjRsMXAzdnh3TVhaMmRuN1FC?=
 =?utf-8?B?aE01VGVob3J1R2k2dVluSWhOUUdnNm8rZnhjaW9RU2hNZVB0cW9Nb282aTgv?=
 =?utf-8?B?Y2x2dDdrc2JPZW02OXV5R1pNdlJvRFl5Zi83NTg0MWNITC9ZNDVqblI2VkI3?=
 =?utf-8?B?eXRwY3lWdGg5dlNLUWIvWXNlbGp3OVJ4VlQyUk5qaTVjOUNhQmx1NVl3RmZI?=
 =?utf-8?B?OW14QWVXOHBaRkFkL0dhdk9hN1hlN29XMEc5TFMwLzJ2WkNCclRoUGNIbFhi?=
 =?utf-8?B?ajZGc3lleHRabW5UUUZYbFB5V0trZk1MRVphZG5YWmtmQlVrV09HdVY5VGww?=
 =?utf-8?B?anBMSkh2c2FNbEZZdzk2eFBGeEFhaDc3NUxjQS9uWU5RZmVYZzdvdFJZYi9u?=
 =?utf-8?B?M3I0akhqbWJxUUNWcE5zY2hzOGFjY0M3MndXSlJOWjM4ZGcwUFh6ZW8wZFoz?=
 =?utf-8?B?MGNCeTd4MGJNOEJKR3p1YmVtd0IwTlNuWVowcUprMkZSY0ZhY3RtK3IzRlBl?=
 =?utf-8?B?L0pudGdySEJKRUF5NE0zYzA2L3VQUm9VcE1xTThMRUhwcHFZNEEybFZRanVj?=
 =?utf-8?B?cGRXOVdtRUhBMjZadGJDWVU1M3dDVGZUb1M4UW5RUHhMeWt1ZkJzYTc2RVk0?=
 =?utf-8?B?elhzRWF3aUN1TkplYURQb2U4eFRhNTdaVFE0T1BiWU55YmNYNHBqMkU0U3lx?=
 =?utf-8?B?TDRrYUhiNThJbDFxYjd1dFBNSHIvR2VsNTJLb05tczc0MnhJMGxNZ2ZkbG1z?=
 =?utf-8?B?VWFUek0wSGtWdW5pUE5wUFRzU0wxblFjMDdZWFVFRW01RzJxWWJzV3cvQ1Qy?=
 =?utf-8?B?VEZRR0Urb2c0OEFicjVvaW9RTDkyUzdHd3huMU9zZGozMGtzUS83SWdYb2s0?=
 =?utf-8?B?eWhSajM2S3dzUjhEdEtNekN1T3Z6ZCttYWxxQUh0V2JuRjF6cmsxSjZkMHcz?=
 =?utf-8?B?Y0YxaUlKV3V6ZG40RXFYUzNGMllCbTlxOHp1UE9ZR0NrOGFndlhNOGpQNzV1?=
 =?utf-8?B?SW1zcEROcmlDZzBFMS9yUHUvY3JHclNueExCSlJ4cFZiMGk2NjZNNEgyb2ZI?=
 =?utf-8?B?Rkc2Y25NVFpzaEdXY0FEVytuM29FR25OSEpZU1MyUGN3WVNrMFkwWGRDWFRR?=
 =?utf-8?B?dWZqUE5OREt1RDI4aHY2dmlaSEcwbWJ6dlkwdzEvQjhOVjE4L2xXcDI0eTFz?=
 =?utf-8?B?TTF1UXoyenRoKzFqRzZSODNSUHIydWpqZ2drdVhuQlJQbHFqZXVHUWphUHRo?=
 =?utf-8?B?aWprU003bGd4T0RPZnRKVCs3ZElGRmY4S0JoeVFmMEVFQytOK3JYSkZyMnEy?=
 =?utf-8?B?L1hQbW9DcFFMZ1VBOFJhUFp1djN0aG1lVk0yRnladEFaMjE0cW9oeTBHSFMz?=
 =?utf-8?B?NEJGQTJvanczdjJhMUU2d1VrN1cvNXhvMkhhY09leHNGeFRQSEJzdkpkYlpy?=
 =?utf-8?B?ZTkzN29wUUl5YSs2a0VxRVNMYmxpaEpQSXpNWUJDa1dOelc1SVRNVUdpMTdM?=
 =?utf-8?B?YVI0SkRURzNEY3IxKy9XUy9TdElNRnpXRWNoaGNzQ0o1YzUxNkc0ZWdsZTlX?=
 =?utf-8?B?a1RsM1l5eG82OEdNaXMvdFV2bVE0OXR1RTJZV1dabUtucndoeG1aN3R3UUh3?=
 =?utf-8?B?d0NCWTNrV0RJanhEN3huaWVXbHlXWkFOaCs3WDZseG8zdGpLbC9VaFZqODVM?=
 =?utf-8?B?enpib0NaZEJ6a0drRk4reC8vWXNDL01OL003aFFCVEtwd1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3M0WmIxQkpicU43OGhpcXRZSk4yZFdrUGt3dUNhQWJxdU1JMzEvWEpqQSt5?=
 =?utf-8?B?bldhd040Z2JTM1huRTJBLzRIb1ZWMG9pSW54Sy9yMS9iendGTVFvTGV2VzdI?=
 =?utf-8?B?cFo2aUVGZzhYRGxqeFFqNjE4eFlmdnJEL3ZyUGJ5eTZYaEVOT3pLVStzN2Y1?=
 =?utf-8?B?K0xIckFEajdEakxXOCtxQXlwT3Z4ckhucitRbFFDYXp6bXpUdnhvRnlXK0VM?=
 =?utf-8?B?WE80enR5c1NnRHFkTGtSdjRwMUtWTFFjQUlmclZuSVBpVXpabUxuWUV1NXQz?=
 =?utf-8?B?RkN5eGN0dXE3U2hLcVg1dVBBNU9OdThMR3Qya0QvcGhjVWRxU3l3MXNscnBX?=
 =?utf-8?B?eFFkOXRFWlBDNDZDZ0JzaUgrZXRuR25OTTdGS052Y0hBUEhiaHpxeDd0R3JF?=
 =?utf-8?B?bWZ2OHdWSnhXRHZsSE5wV0x5Y0FsbmdpNXVLQmgrNDV3Q3hyR2VwUzNFS2s0?=
 =?utf-8?B?TDgxcWxnc2ZKdjBBUmdKbHBlSDhHU0QyT29xZklmdXJBcDNzUUNpT01WVUpl?=
 =?utf-8?B?MkVaV05xN3IyMlh0QTdiOUxpTHpHZFZkUHRnMmxhQkZFZVcyRDFPNkFEL3dC?=
 =?utf-8?B?VThhLzAwZkxuTHUvc2pwRzhKMEs2ZVBPZjc4dVRnYlA0ZGxuc2IvN3I2YWg4?=
 =?utf-8?B?VjZ4ajFmZ1RoMStXbEdTR1l5ZytRQWdQRXBnbmF6WE0yVVJzY0dPd3BTVUN3?=
 =?utf-8?B?RjlOaXNWVDhGWldrRjlzZUJWOHgyWGJ6SWdlby8xNExLNko1cHVwNFFQT2sz?=
 =?utf-8?B?bEt3eCszb0x2R3V1TVRCTTliTEYzMkwzbHhZUnNOZDJCekNtVFBLRmlwRkJ2?=
 =?utf-8?B?T3M0TlFBQ1ZacCs0RDJIUWpManVDa3liNzhnbTNzaVBWUE9GUlZXcUoyL2Q0?=
 =?utf-8?B?OU5yOFpZcURWTzJROHY4SFZ4VVZYMktZekRPaW5hdWllQk92enVLTGJaM0E5?=
 =?utf-8?B?K0Nzd1JidGIyVFUxRmxDT1VWOEQxejFnTUpLekhlRnpSSDY1K1BObWlBMmVY?=
 =?utf-8?B?ZTdGT1BUNFU0enNWOE5mdno4Skg1ZWhid0ZNaElWTlg0ayt5V1k5SkMxVCtI?=
 =?utf-8?B?NUgxLzJ0N0RHT3h4cVFSVkpDaGlWL2ZpTGpPbmFPeHQ2TlhRQ3drTGRqTkRC?=
 =?utf-8?B?anFwNUUxUmFHd3BxSkVFdHVFKzJqS293a215SGRabUQxejcwZmtrNytDUXYw?=
 =?utf-8?B?RlJSWm1BS0NDRDlaV3UxMkhaZ0tyZ0JJWVA5eXRXRmFwcWtaYjl1TWRHVlQ1?=
 =?utf-8?B?WXRMbkUzMkVicEMxY2duMTNHYjBBSFlxcXdRZmtqUnFJOFE0M1dRd2NoSjFG?=
 =?utf-8?B?cDNpMGpyQm9FMzBxSUJrM1gxcG81UTE3UnhkY1pYaHhhZWZxbDhMeFZ1bVI1?=
 =?utf-8?B?TWdJbEVBdDFvMW9LeS95QUhidk5tZlBhT0RsbGFNTVdLbDh2c01lczhGK2pF?=
 =?utf-8?B?MkQ0czBLRCtXVVVvMGVleVNaQlI1OExJYUxyMTl4emJYRlhpMkpha0V2L2o5?=
 =?utf-8?B?dElRUVRJTDJxdHlJQWlzNHdYTXZTak9maHpOdkJ4SHJaWC9EUlI1SXpwQ2JV?=
 =?utf-8?B?TlpyRENWdnZMRzlPbjd4cXVFaTNNb0h4VVRJcGVQOTNmcjJOU3Nzb3FzUUN0?=
 =?utf-8?B?R1lmNVlKWVRJVzN4Y25zMHZxbEFmZGptYS9VNCtYMERCeEJ3Nk5ldDN1OVJG?=
 =?utf-8?B?NFl2a2NWakVDVWZRbEo2Ylg2Mm82bFlYK2I1QjA2K05xWThqeXIxMGlKK29U?=
 =?utf-8?B?Tlc3RVRkdjM3RDJMZFk1ZnZDcHJpT3Fkcm44WjhPU3NmMWwvM2h3NlhkTDFI?=
 =?utf-8?B?YmExNTRMOFpNZTRUK29EdVloYnZYRG1UWHhpSTB6VWlPSVZPR1h0cXY5aXBZ?=
 =?utf-8?B?M2wxajJaeDF4NHZUbnBZMENqZlpFeVZ5endiV3d4ZDhNVXZJbkc2c0Uwdmpt?=
 =?utf-8?B?NGk1R1MySnBQNDl5QTYrZG1zQ3pGaU1tYUdYQi9hMllyaXZuZnpUMTVOWnVX?=
 =?utf-8?B?YnoydStQNFhvNnhZV3QrSTJBQzk4cnJRSWRycW8wQ3BRVWRibWFCR1dFdnMy?=
 =?utf-8?B?VDJXTnJCbjg1aWh5dE92Y3cyS0ZDR205aFlUM3dsRWFuOU9SSFF3TDdZOXlt?=
 =?utf-8?B?Qkw2R0Q2clQxMjR3QWszcTFvK0ZGMWNZTEtWYXF6R1NCWURaVERQekdhV0Ew?=
 =?utf-8?Q?raRBN292Nsk2fK7dD1voo7I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <765DE4BFCF17E0459D9165253C140C9F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b506727f-506c-4449-0fb9-08dd10499445
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:43:55.6714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hu7EfzEH1Klw3ISuQZifV964yZ6q0p4H9KiqW4fyzaE+cApXtwI/NODeKQrUxkzdkiuo5zqbEH9N9CU99eXPZYWzlHooomi85tWbKkTT5SF1mjpfOeR3np/Yh814V++R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7847
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
bi5jb20+DQoNClRoZSByZWdpb24gcmV0dXJuZWQgYnkgdGhpcyBvcGVyYXRpb24gd2lsbCBiZSB1
c2VkIGFzIHRoZSBpbnB1dCByZWdpb24NCmZvciBBVFMuDQoNClNpZ25lZC1vZmYtYnk6IENsw6lt
ZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0t
DQogaW5jbHVkZS9ody9wY2kvcGNpLmggfCAxNiArKysrKysrKysrKysrKysrDQogMSBmaWxlIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3Bj
aS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCmluZGV4IDEzNTY5NWM1NTEuLmMzNGVjNWVhODEg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KKysrIGIvaW5jbHVkZS9ody9wY2kv
cGNpLmgNCkBAIC0zODgsNiArMzg4LDIyIEBAIHR5cGVkZWYgc3RydWN0IFBDSUlPTU1VT3BzIHsN
CiAgICAgICogQGRldmZuOiBkZXZpY2UgYW5kIGZ1bmN0aW9uIG51bWJlcg0KICAgICAgKi8NCiAg
ICAgQWRkcmVzc1NwYWNlICogKCpnZXRfYWRkcmVzc19zcGFjZSkoUENJQnVzICpidXMsIHZvaWQg
Km9wYXF1ZSwgaW50IGRldmZuKTsNCisgICAgLyoqDQorICAgICAqIEBnZXRfbWVtb3J5X3JlZ2lv
bl9wYXNpZDogZ2V0IHRoZSBpb21tdSBtZW1vcnkgcmVnaW9uIGZvciBhIGdpdmVuDQorICAgICAq
IGRldmljZSBhbmQgcGFzaWQNCisgICAgICoNCisgICAgICogQGJ1czogdGhlICNQQ0lCdXMgYmVp
bmcgYWNjZXNzZWQuDQorICAgICAqDQorICAgICAqIEBvcGFxdWU6IHRoZSBkYXRhIHBhc3NlZCB0
byBwY2lfc2V0dXBfaW9tbXUoKS4NCisgICAgICoNCisgICAgICogQGRldmZuOiBkZXZpY2UgYW5k
IGZ1bmN0aW9uIG51bWJlcg0KKyAgICAgKg0KKyAgICAgKiBAcGFzaWQ6IHRoZSBwYXNpZCBhc3Nv
Y2lhdGVkIHdpdGggdGhlIHJlcXVlc3RlZCBtZW1vcnkgcmVnaW9uDQorICAgICAqLw0KKyAgICBJ
T01NVU1lbW9yeVJlZ2lvbiAqICgqZ2V0X21lbW9yeV9yZWdpb25fcGFzaWQpKFBDSUJ1cyAqYnVz
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZv
aWQgKm9wYXF1ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnQgZGV2Zm4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpOw0KICAgICAvKioNCiAgICAgICogQHNldF9p
b21tdV9kZXZpY2U6IGF0dGFjaCBhIEhvc3RJT01NVURldmljZSB0byBhIHZJT01NVQ0KICAgICAg
Kg0KLS0gDQoyLjQ3LjANCg==

