Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE46FC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOf9q-0002OB-U8; Tue, 02 Jul 2024 11:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOf9j-0002Ev-SE
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:10:56 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOf9f-0006DO-FF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719933051; x=1751469051;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=WPaVtriUCpE394wwlm089y58DfeH3Z6286Lqnv/7GZQ=;
 b=Q/zAskZGJh7r41bgermI5ZvaJD2zBthbvsl1CY/euxzPR2pUNqnPb5i1
 uGa73xMM1ce6+YMPHNrC/xT6wCMHQn2DQe1gjhLXejHrau6v/njbt51M+
 n6sqifcTCF3AouOv7/5ixX7RsjdXHErVBoMrYqal9nzXuAnXr5FWtrgXk
 9qGWPS6uHVsKS+EfScxtrm80JDZhUJGrYut6vYlRj+QL9LbFupVDWnvMQ
 Llo4tafJnrGho4TddcCG2mOB4kK2nj5r26Ve9fYIfE5Q6D95oHSPaiag1
 aX1phGTMjFyNqvsCqNMMiJNxFxwR8LJ3EeKrELMguiH3fMRiK4hhTUUhB Q==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15768863"
X-MGA-submission: =?us-ascii?q?MDEc1cKyFzOWDbC7URp1vnntm6qUcZ7CJ+zdM5?=
 =?us-ascii?q?dTmmsv8XqSWJuflXYVda4l2pNdSvU059xYUC/O6aNcNtBfWGa6ogYjSD?=
 =?us-ascii?q?0IsE9IuHubbdRKFydJ++JuZBLWq51nApjCYzLjZnWCrQ762gXDN1fqn7?=
 =?us-ascii?q?pS0cwaNklxkJhIuAwXRoQJFw=3D=3D?=
Received: from mail-am6eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.110])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 17:10:48 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5Ix5QpDPQnZQuN9GwfTkbjgTwSU7TT6MtIMqGrnTiyQSuR9hluGeDI0Thiolkw+2igaMHR/p7KXXtl2dUfApsoIzQrMoAEB7OR93MM0FVp26dLabVMRQ1Z+IFjNq9uuXDzeRlW2T+otvvbt42am2FtPDInIuOeuOboX1u/KY+dQn5Bf3sfFFFyMSOv18ZSSRb4hnunlWLpf1TVn27JiBuJoj/883KAdvV/j+OS7wB8hh6NMOWYMXXXOuCpAf6SwpMYtqGvXKW80QgS+QERf4eHI2SgiaupZhgT9JXcAd4B3fDu0rOmSCfRL6KZItVZv9hbuwgUjW8Hlj/kNX8xKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPaVtriUCpE394wwlm089y58DfeH3Z6286Lqnv/7GZQ=;
 b=Lu2rT29MjkkyfQ4BTLtwW0lJNgeLJh4u+AHFuuXqBHoYoTQvP2FhHItQpBLxhjBkwTDC+zh0fCZh6QN9nFCIhUYRpRmELAtTGMtwCdbcwtr9lZyVzQ88vNUvZYaP3PFXswlAJNhro9n/72GGfhfcJqYKyAwan33b0YLgbLXUUqMwtiUs04WqLX7BAIE+zhLNwZdSqE6lJKmwXH+cOQDaulNg0tmD4RS31SahJtiSe9f45P8Ti7h9rLN9fAem+095epDhtak0XcCiwiNYrEXDTvuYNchAXwUkAYdSIAfe7oHWtelIEZYI7Mgf6gt8WZ1by6rj/9MWMzOIELraTffwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPaVtriUCpE394wwlm089y58DfeH3Z6286Lqnv/7GZQ=;
 b=s6FTeq65y3w1OcmGeNUMwcSmeVHEEF/spuXr77iKS1fQWwSZ9oQq3U5clfZmIKSvFA6uCSxg0f9myAn13rF6M4sgrytoPM9YjH0pMNJFgJ72nPWlkucQRBdQH0DRaQJeUhN9acDDaXoW9nZz/tEJLP/Qperz+fIYxlJVtIlCOUnaw6NGixS/bXeacyy7WQfCLbzs+Zmop1Z1nAsKCwkVgvnYWxJoS4NbTue/Ubc4RxV9xdbclQUBuIEnBtDBYnqdpiDbfq2zLakGE3aTNr+ESC0MHZs6sn6ZaXWn2VigbnNziiM0VCXFChPwKqnTI062HzWtT/r1cpbi9Ueigg9zBQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU2PR07MB8077.eurprd07.prod.outlook.com (2603:10a6:10:2b6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 15:10:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 15:10:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH ats_vtd v5 01/22] intel_iommu: fix FRCD construction macro.
Thread-Topic: [PATCH ats_vtd v5 01/22] intel_iommu: fix FRCD construction
 macro.
Thread-Index: AQHazEQHGsQhBlP7LEGqilns4McPCLHjZ0qAgAAkNoA=
Date: Tue, 2 Jul 2024 15:10:47 +0000
Message-ID: <cfa73158-82cc-452c-9a48-fc119df9919b@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-2-clement.mathieu--drif@eviden.com>
 <83d1fbf5-1559-4a4a-9a48-6a44e11d2164@intel.com>
In-Reply-To: <83d1fbf5-1559-4a4a-9a48-6a44e11d2164@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU2PR07MB8077:EE_
x-ms-office365-filtering-correlation-id: 86c2ced9-193a-4b63-9811-08dc9aa9271c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?REpkV1BndENSQWtEb2xSUlFFS21GUmJXc3VPYlh0elpXQ2dkd3JhNCsxVUFs?=
 =?utf-8?B?eHYrUTk5QTNiSFYzMDhYVm9PekMxOFR6VXFGN05DWHlRalF0UFhoMWdObEND?=
 =?utf-8?B?UkJ4TENBMENlV2JGKzNreWs0OXU3UHpucnpaQU9oSjJuQmwwMzZzWnVaZWw1?=
 =?utf-8?B?QkVhYk14NXdtQ1BvVnhMclJTZk0vWnI4WGI0dmR6MGlPa1pRdXZ5anRaQVRO?=
 =?utf-8?B?VEpHait0ZTVmT1RIN3l6dVVGNVhVcW9YY2dJdlFSQlNsWFFSdE8vRi9kUDQ1?=
 =?utf-8?B?c3BXVEkzdTgvenJpWW9POFBsbU8zeEk4TEIyYjdrTEJHNWdObVcraEdBUjlC?=
 =?utf-8?B?bnhLZzFNVzMvYWxGcmxiQmpCMXZjNjVKbE5KUWVOWXpRV3pEV0ExVUIvS3JO?=
 =?utf-8?B?MXA2cTBOZyttUDlpcW9UZUlBN0VLLzUzUXFpSkd5RTg2VkRyZUFacEpkQ0lw?=
 =?utf-8?B?RUlpZU5ETXFmVXVCSE1wQUZZMTQxZUNoVktiQ0N2V3hka0lobUxpRE1PaDNN?=
 =?utf-8?B?MlplZVRITEszNGFKVFFjR3YrSmhwcmFTT3RUbUhOYVpYSVIxc0RtcThnNmVx?=
 =?utf-8?B?bG5zcFJoZWxzSEd4NHBGbVF5V21tK2g5aG1rbmR4THBQY2RiMGFIUmhJK3ZO?=
 =?utf-8?B?L0dqcVRZQjFKTU5CbFZWRkNCbmZDeDlMMFFpclEvV0pmTnQvMHB1WGJtcE5p?=
 =?utf-8?B?RVVKVENMZlc5STRrcGtqOERLUzVwSERYZ05BUWl5bU8rUVUwUDBTUjhWOUl5?=
 =?utf-8?B?TjlEcFBJa3lmcDRGVVpYakw4R0J3cjhQWitQc2VMOS9mMjNlb2l3OUlEdHZp?=
 =?utf-8?B?YWVtNjBSZ1VEVFU0bFNHcjM0RHVZMThkLzhuUVdNbFYxb0FrYXo0bStGa1cx?=
 =?utf-8?B?UVhuSHdDVGFMNUkvWHdUeDZuY1RpYjNlSDlYWE1yOFJtL1crNk5xR2lJMjB3?=
 =?utf-8?B?ai9vdUJpbU5rdm4rSnJnY2hyZkJBWFpueGRWWi9HN25DeUp5OFZac1pEbXpX?=
 =?utf-8?B?OWpYbmRkcE54VzZsZG9KcUhYOU8wekI5d3pvOE4rS1phUnMrdlR1MjlpRjVB?=
 =?utf-8?B?VWczdStVRXdXbVVHWktEUFRJREkweG5tTGJuUEwzZGhWZHVKRUsvVGU4ajJj?=
 =?utf-8?B?b0NYWnFVZGx4Z3dueG9XQjZtd0l1Q09YaGE4SDBYNGlHN0Q4Wi84U3p3eWFQ?=
 =?utf-8?B?UlVTSnNPUGFhMjVNRkZ2V1RJRmt5RWF5OUxZY3BZMXo3S0QydElubWJYU0Z1?=
 =?utf-8?B?QnNPK2JQLzVHazJLUTFyOW41Y3p0UGpJSnh1UXBHVm80YkdUWjczVmVuT04w?=
 =?utf-8?B?aUNJbWpBY0oybHpDWGJVcXJvS2ZPSnpxREpKS2tRVlBxOTg5TjBuMkthdWNE?=
 =?utf-8?B?alNoNDhOTXJrbzR0ekhaUXJxNy9MZlBranlDR0JhUjZUbWdFODVzK3VoTUt5?=
 =?utf-8?B?MnVRSGYvb2xlZnBZOUpSNGZRWUdsRzdqVThLNWczR0U2QUxZVTNSaGVqMEls?=
 =?utf-8?B?NkpCNWtTbWhQY0FEYktOM2UzTEdaN0ZvM1hnS0EvKzYzMkw3UlE1M2FXdGpp?=
 =?utf-8?B?S2hJRnlyWHBaWW95bGkyMVBpcUs4cC9pU3VHUk4yVXN0SUw3Q3EvZm9DZFFY?=
 =?utf-8?B?ZGlTYXBLN2sxNUJHZDB3R3N3MVVqckd4anJNckc5UzdzSERQYStvcHVUNHE2?=
 =?utf-8?B?K0VFVy9vWkx4SGhhZHIwc0Q3L1BwU0hONUlQcEJ2Q0U2UHQxczI5L0g0eDZS?=
 =?utf-8?B?eFFtZkNPTXMyeDYrcDhvS21NSWFZcXJwejFvbzRscm1taU1NRjFwSVkwOVh3?=
 =?utf-8?B?RGlaQThqVTlDZFRXejFvMEZab2pNOCtrMGwyN2pRZGNQN3A5a2tOWTB2RG8y?=
 =?utf-8?B?MmsxRkt4MHJvaXYzUmlmQW4zWk9tT1Bqd0VySm54QWpDcXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K01tbW81WVUxTmlNc3FnenUvL1lQclhtVU5ydDdweFlwVy8yTU56K3h6TEdk?=
 =?utf-8?B?dkFzMzl1R2cyMmJ3SGVka1ZQam81cFBBUEZJaFE5TXVqeWcvc2RZaDdhNmo5?=
 =?utf-8?B?S1hucUVDTnNPcStUUTBPVUxtaGR4WklObnlOb1lRRSsxVklVbGk5USswRFBp?=
 =?utf-8?B?QkhZWkhKUlprK1JpQ2YxQ0xjbGJueHVaVWR1K3BaVFpQWXRrNXJhODBuWFBv?=
 =?utf-8?B?L1ZWV3RHTW5vcGg5cHFDVDFLU2ZiTmlwRE1JV09TTllzbGNHWHdYd1orN3BG?=
 =?utf-8?B?Z2dLb1hIS1ZXSzBOSFp3T1FMRVhLNnZ4ZWNuK3VOb1hibU5LUVpXVFR6TUlU?=
 =?utf-8?B?c3RtTWlKYnJ1emFRemR1dDdoOHk4anBpdGppNFhJN3p0NFJqczlDRFBGcFpp?=
 =?utf-8?B?d05ybERvRHhhZGxiK3lpZnN0VVNhMHhYeXF6aUxxYjdwcTdsYk5hcy8xY1E2?=
 =?utf-8?B?UW5ZNmhNS2V6RmZQVDlvZ25GVWJ3WEVUUWlpVmlSSUJYZFp2NVh3bU5Ja0Jr?=
 =?utf-8?B?bWhSL1loRStXaVNQQ0pKR3BCR1lXU3FobzErWjZNTmtLV1R4ZGc0Y3c4YVpB?=
 =?utf-8?B?U1gxZ2dWeTQ1RmFYRGliK254MjQxR2dFVk04bXpIMWRQZlpiTXRBaDZ1czVa?=
 =?utf-8?B?bFBucWhmOUw0b3dRU2lqNDVsTStqb3pjNHE4cURaU0swRGNETnJocXZnTFdU?=
 =?utf-8?B?Ny92NlFNUWNVL1FBSE5RZjZmSjFWWituSElHQVRnNS9rSC9CMHdwZHdZZUZh?=
 =?utf-8?B?NFBaUFRiWFowK3dRcW5ibkwvNThqcDVIT29PNGxyYzVRWDhtT2dkRlJKc05z?=
 =?utf-8?B?T3RJcGp0WE43QXVxYms3QkowZFQxRjcxU2tBK2g3UTVSWnRoUHZObjVxK0tS?=
 =?utf-8?B?UjRXWXR1UlR3R2JFZjNLYlJrZEV3V1lVSzRoOGZ4SjAxSWZjb21hSjVGc2F3?=
 =?utf-8?B?b2ltOC9MWCsreGtZazQ5czN2TVZnNmJYUXVjUDRFQ2xYeHd0T0xuQkZiTFlP?=
 =?utf-8?B?dXJEQUZnblhtd25HTVhjQVZFNFVaTGhGOHA5TVdvTENxNEpsV0Rabm45eW1Z?=
 =?utf-8?B?ODJ4Q3JjcGVtU2U4VVVXYUI0enBVQ0ZScGd5QWhra0gzdTh0Yko4dFIyckt0?=
 =?utf-8?B?NDNHVG1CMHRydjFRWTlPVEJxeVlxWHRPN0l2Q1NXNVNMZklCK3NmRndNMjBC?=
 =?utf-8?B?aGNpZnJCblVTNGI2d2kzZ3haOHF6RmVtNnNRUGVHRjdpUU9lNnlLTmxzcUMr?=
 =?utf-8?B?RlBQMXh1QldHMzF3dFpEdWUydlI2MFhzaldYN0w3RXZTak96MTUrY1dhRnY5?=
 =?utf-8?B?cTFpUVZkM2FFMjBVK2ZRc0dDVlQ0YWZBZlIwZlROYXlaRFpHVUc3M2hBU2ov?=
 =?utf-8?B?clVQQ3RVdjhjME9FQnZzZ0xPcnkvbHNxYm5yS25NM0pRcEtXWEk0dGN6TitR?=
 =?utf-8?B?RUhhalExdUpYMmk4bDBHdXJTTlQzc2lKbVdCUmpWRzk5eEZjTmhPOFBOUjVU?=
 =?utf-8?B?MTYzbnJJOWxNemd2dS9RS3drUU5MSFcyUEU3azJoZHhFam83WEE3TzRsdXBj?=
 =?utf-8?B?aXJaSkFhTjJSdUxLRHIxTFVNL0xBdXdPYk1RKzh5QkhMSllOUVJtdlZrcFBW?=
 =?utf-8?B?UDh1SDRyL2pIYThsclNvcnNVMDVkSFBQL21KbnRoSHpodkltZm5NYzhnOUZo?=
 =?utf-8?B?ak9qeWpjU3htU0FYWFNkMlNhaVlya2pPdEl0dXhSeGdndHVLMlIyMVpmR0RB?=
 =?utf-8?B?SmNxcEp3ZGVjcng2dFpwYjNCSGZQWnEyTVFIUk1rZ1lyMW9aVFFXeVZKOFRD?=
 =?utf-8?B?S2RTbHdRWmlVZnYzSW9ENjY2OU1NNlRxaUVWN1lzTmwvZytrU2duK2RTamxV?=
 =?utf-8?B?engxRjh0eWdYM2FCVzFYUkRLb2hsVjZSc2xJaWhkWVdGbmZxS1d0YlU1T2Vi?=
 =?utf-8?B?U1FxM3RJZFg5cDhHNmNDU1V5ZmtYdkhoeTlWODl6b0ljemVjSlNBZ1RhSEkx?=
 =?utf-8?B?Y05ldHFDUklydHVwNHViSklSeDczODl1MXdRL1ZDSHFDUnNINzdSSUJsN2p2?=
 =?utf-8?B?QzZjQUhJOUxGY0xERVRMaWlvdEkwL09VQWhMZHMyaVAwY0twRlFzWng5REY4?=
 =?utf-8?B?Sm0zUHhPNmJRNzBmQ1lIcHdhUGFpeHJzZlFJR2RIeWJ4NUZuOFdHUXAwZ3Zv?=
 =?utf-8?Q?235PGj/fKQS/CCwxXGWtVHo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1038786F7A955345B3B4273FB587B1B5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c2ced9-193a-4b63-9811-08dc9aa9271c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 15:10:47.5770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VdHWTYHRGnqHJmgoPDFIHg2uDxCiGuSLmtKuGVYiXSBwdBt+wG8MhysOiHrvcwm2MYCqPFiFK/1zHiy11eTs8lk47shKwW0N+agUBjkEAQIO4eR80oCIWRHU9e8/6wO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8077
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

DQpPbiAwMi8wNy8yMDI0IDE1OjAxLCBZaSBMaXUgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgDQo+IHVubGVz
cyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBj
b250ZW50IA0KPiBpcyBzYWZlLg0KPg0KPg0KPiBPbiAyMDI0LzcvMiAxMzo1MiwgQ0xFTUVOVCBN
QVRISUVVLS1EUklGIHdyb3RlOg0KPj4gRnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xl
bWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pg0KPj4gVGhlIGNvbnN0YW50IG11c3Qg
YmUgdW5zaWduZWQsIG90aGVyd2lzZSB0aGUgdHdvJ3MgY29tcGxlbWVudA0KPj4gb3ZlcnJpZGVz
IHRoZSBvdGhlciBmaWVsZHMgd2hlbiBhIFBBU0lEIGlzIHByZXNlbnQNCj4NCj4gZG9lcyBpdCBu
ZWVkIGEgZml4IHRhZyBzaW5jZSBpdCBvdmVycmlkZXMgdGhlIG90aGVyIGZpZWxkcz8NCnllcywg
d2lsbCBhZGQgdGhlIHRhZw0KPg0KPiBSZXZpZXdlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVt
ZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+IC0tLQ0KPj4gwqAgaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oIHwgMiArLQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxf
aW9tbXVfaW50ZXJuYWwuaCANCj4+IGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+
PiBpbmRleCBlODM5NjU3NWViLi5iMTlmMTRlZjYzIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9p
bnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmgNCj4+IEBAIC0yNzIsNyArMjcyLDcgQEANCj4+IMKgIC8qIEZvciB0aGUgbG93IDY0LWJp
dCBvZiAxMjgtYml0ICovDQo+PiDCoCAjZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCnCoMKgwqDCoMKg
wqDCoCAoKHZhbCkgJiB+MHhmZmZVTEwpDQo+PiDCoCAjZGVmaW5lIFZURF9GUkNEX1BWKHZhbCnC
oMKgwqDCoMKgwqDCoCAoKCh2YWwpICYgMHhmZmZmVUxMKSA8PCA0MCkNCj4+IC0jZGVmaW5lIFZU
RF9GUkNEX1BQKHZhbCnCoMKgwqDCoMKgwqDCoCAoKCh2YWwpICYgMHgxKSA8PCAzMSkNCj4+ICsj
ZGVmaW5lIFZURF9GUkNEX1BQKHZhbCnCoMKgwqDCoMKgwqDCoCAoKCh2YWwpICYgMHgxVUxMKSA8
PCAzMSkNCj4+IMKgICNkZWZpbmUgVlREX0ZSQ0RfSVJfSURYKHZhbCnCoMKgwqAgKCgodmFsKSAm
IDB4ZmZmZlVMTCkgPDwgNDgpDQo+Pg0KPj4gwqAgLyogRE1BIFJlbWFwcGluZyBGYXVsdCBDb25k
aXRpb25zICovDQo+DQo+IC0tIA0KPiBSZWdhcmRzLA0KPiBZaSBMaXU=

