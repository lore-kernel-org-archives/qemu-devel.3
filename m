Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC2CCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27gS-0004hj-Ux; Fri, 26 Sep 2025 08:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v27gM-0004hL-Bw
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:36:15 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v27gC-0004cE-RE
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1758890165; x=1790426165;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eFqVO5aH/gIuSptY1K8LEE5dCUvBO2GPtMEgf7XJ8LI=;
 b=b0060E98H9OACq7aQgMvM4hrW//6CSohrCkfP2eJKoM/zOgRidsjXZgg
 aJzwPPjAkfqCitTmqyx4i5Qab8PzV48lloyPjXbm3XtWaK9JBcO97kN3T
 K5e+ERYBhiEvz6pnuYwXtN7OoMy0L9ziio5AgNiUQddD7cXygaNVdlCfS
 CXuHq2kM80xPeHO4nEd2ItnqECByaEmWgh42PYkNETSEthsCfts1e3g/R
 +vx7/av2Cm3t+xRmE3pksFz/HuIV8+M4VQyVlnlehfVl1fndZ5bgg9vAV
 J6GAwC4eA8hjqNguarMX6C31JDjU5ZCX5A0WW1E3feIRXiLRqAB84JEpz Q==;
X-CSE-ConnectionGUID: 0r7dhigfQ6eHzJoffTudaA==
X-CSE-MsgGUID: lErbikikRFuYC6wZZeCwVQ==
X-IronPort-AV: E=Sophos;i="6.18,295,1751234400"; d="scan'208";a="43327276"
X-MGA-submission: =?us-ascii?q?MDECtsPl0W112KaYitgBNqU4o/xeZ0mh4StdXc?=
 =?us-ascii?q?ZWqgzSXaIyv4g2OfmjtLdz76zcPHbzZjnAE1Me8LOuzeQMs5CToT53C1?=
 =?us-ascii?q?GW6pXn6gmvUXpNLephvYxpGZwTtzBsG/3XB/t8sAEXyTGtiYz2kvFX5t?=
 =?us-ascii?q?5sWjTWC12E8kyB/ecVH5X65A=3D=3D?=
Received: from mail-northeuropeazon11012065.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.65])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 26 Sep 2025 14:35:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nzjd2sNxyDog1Mf/igPDXKqwnzO02s0JqHHt1NjKLYJGBXN6ct+3ZrYjcOkQM2X7yJctb6uebim92lqlL7/jAqelmqYw0B2aACzB7YbLK5/ObGGLr/jeW1a4N6tLB9OiLkjbhSVag3KYBm/9KVd6+5md/k8xJdj0p+YA0Uf6N/zZVIvi99spIWzrhO0ZHfn0/91lWJw53W3T/ptQzC4fd37zae4OhaOaxoH3jMXsS1NRL9cmNafSVVIuOBqnouzQf3E+aEzIuQfDgQ6gtKHXfTo4DkPAOHt7dZhfDQRbogM414/Hame7gHC/EIZPFmRJhwQrofCYY+812hqo/s8Y+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFqVO5aH/gIuSptY1K8LEE5dCUvBO2GPtMEgf7XJ8LI=;
 b=PpkemE//CUL8GF4hl4vORH5LA+qG0L2507/NnzN+GYLAVJifirebXiOuKJpC03g+SVyDktafB7t8lUITe+OGHXuXYFFciQVqs3PFxGmUL8KS4PXGX12vnEGYEU7G6SmQJ3iZazxMXNZXXHOjTwOigOsE8Ldl91JnnpH9UFs2DsMfJXhjgZR3gMRuN0Eq1gMXkIFQKtNSy/CrK8m5JxhDRj0x+jE9KDIWVYERlvteMdENIdCNpuV7hIUp9Ilqbc4mWntu7C8oAyUPbnA8i3i7mvoFk1xjFTMGR/3n2JJ9xGODBUamangUXQDuwIbBTJVEnqUjZ4Ydr5qb4XpW1I1e7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFqVO5aH/gIuSptY1K8LEE5dCUvBO2GPtMEgf7XJ8LI=;
 b=oVZnd3oqL5ja0S2lHnfC/B2YQiAorCZme8fww49eh3zVJLbat2XX//V9PLQVMz4+72tMXXli+wd5q7e992OsfJQje1LSorE6/tHhTd1lTCbeP7YPcJhCNIqjUq8COX/JOpg6T1z2P9fqhQuTTTHtTu1kE9dkqhGLD0gQVsGnm3RGT5EfFHxUcUugx1Avc4FG8Bcwc3lIWnON1rnlOQzdU4HmIVK6tvHyrJn6b3Yv4lpEf5zytrOCNi2qtT4LZG8/qeXxcDDEMqR5FWZFUOEOkyFWoiv6rMore3IPTs3pWRlcD7x1EvE50yB+3pmxyriAds06QsTSjR/gaQrdPeqFiA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7515.eurprd07.prod.outlook.com (2603:10a6:10:1e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 12:35:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 12:35:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] intel_iommu: Simplify caching mode check with VFIO
 device
Thread-Topic: [PATCH 2/2] intel_iommu: Simplify caching mode check with VFIO
 device
Thread-Index: AQHcKTQDOjN/zBYrn0SVzeEvDu3p+7SlcZgA
Date: Fri, 26 Sep 2025 12:35:52 +0000
Message-ID: <80256c3b36e15faa561934ee1f69da3fad8e7363.camel@eviden.com>
References: <20250919070638.983549-1-zhenzhong.duan@intel.com>
 <20250919070638.983549-3-zhenzhong.duan@intel.com>
In-Reply-To: <20250919070638.983549-3-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7515:EE_
x-ms-office365-filtering-correlation-id: 035480bd-35c4-43cc-0429-08ddfcf93b31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?czc2MzM0eUV6c2VMbEdacTUwRXUrLzhka3N0TUJkbnBGRDIxaGpydFp3WjVO?=
 =?utf-8?B?TW9zd2ZVWkQ3VXQycFFqT1JyQ3JNdTIwVVk2bmFzejQrKzZDdEg5UktrQ0E1?=
 =?utf-8?B?NVZDNlh2cFhrcXh0cTlEQkV2SEJFdy9iRitTaWlYbVUyQU5ZTCtpWUtmelRV?=
 =?utf-8?B?SXJYdTROMzkzcnlpbEcxQWlJSVlpUWw3UHZQdTJxeEh6VGxydGtTSG9COXpN?=
 =?utf-8?B?R2NLaHk2ckdYYUhVY1dMMU44eTVIWXdUUTlJZkxjYTMzbHZZbG9Hcm41TXo2?=
 =?utf-8?B?QW9WbGVMVE1aYVhTYUhVSk85bVRmNVFRNXVybDZUejV5aXRMbGV5UHBzYW1G?=
 =?utf-8?B?SDhLYVNYbjdkaStrVzBNOEpubVY2RmZxbmNxRlB5V0RPSzVHWWFlc1FSLzM5?=
 =?utf-8?B?VGQ1Skd5MDFWZDFHMEROTkJaSTNEaFRobmhna2xwL2dPam1ldkdoTGZkZ0Mv?=
 =?utf-8?B?Zkh5TU1RZzVMMkdoUkZUN2NxakxwVzQreTVlR3lpbWtPR3BlYVpjSTJwWEtj?=
 =?utf-8?B?cDBWaVdJdFlsOGVrVEVacVU4cXYxZ2dtQmJmVWRRamF4cXJYRnNLQVMybFQv?=
 =?utf-8?B?eGhUUXMvT2UrN0wyMCtOM1JYZTZQMExHUXRKL2o2bDFnV1c0RXBadktvTE9X?=
 =?utf-8?B?b3JWV3NPbGxQL1p5MWxGc052MzBDY3lHVUdockUybEpHV1N0d013MWtOc01W?=
 =?utf-8?B?RER5ZXgralNpVlhEeU5PYUhNTjRIUDFOYzNYR3RQL2p4RWZudE1mQTE2bW1P?=
 =?utf-8?B?YkVRZ0hQdEVCTjlFQVo1ZDRPUy91V0FLV2JGKzVhK3Njd3R2WE5kRFBVelhJ?=
 =?utf-8?B?R01pL1RqOTZsN2JKcXE4bzZWeG1oMG9McXNYd2tmakxxTmtoK005T3ZoWjhB?=
 =?utf-8?B?cHM3S0MxRmtEYVVVT2FxV0g2bFpsY0M4bGZBQ3lPWGpFdEhRbjVyR2dFWjlj?=
 =?utf-8?B?ODhtRGsyazBEaXhsTzRDQnpqYWo5ODE0dGpsWjFiZ0ROd2NkdDREMjJCVU43?=
 =?utf-8?B?dDNWWmhYUTNqcGExWFpFdEhKR2JEUTlEVHR4RVE1aGVaN2xQSnJMMWwrd1Ix?=
 =?utf-8?B?MXdjUzBlQjJQNm5hTUQ3NExobXdlaVRkN0RKTnZ2QzMrZlpLMmo4ekJaaFlV?=
 =?utf-8?B?Znd5dWFVQVlyKzFicmZMd0ZBcllSaUIwYlkrQzRaR1J0R3hqbDJlUkFranJN?=
 =?utf-8?B?aWo4Tzd0U2RvUHBCbWp5UGg2Rm14Tzg1RWpobHVPQkx5OVdXQzZFNW9ibWVC?=
 =?utf-8?B?M25FbXNtOXdNRW9UV3hia3liQm9aaGttemd4RWRqVUxkRVhGcVZTSWxEMDl5?=
 =?utf-8?B?Zk4rLzFycEVUQzdsejZ3OWIzYXpBN3ZOUFl3UFViU0V0UDBMN1FEY3NMOCtG?=
 =?utf-8?B?dUtweG5NZ3k0WFpGV3V2eFN2WmxQK3pJMVRJT0RNeW9oNkRlSGFLYkNMcVdr?=
 =?utf-8?B?TGRvZnZ3R2FHRVF3VEdFVWFqU0lYWlNvZGw2Z3Q4MC82b3htWW10dCs0ZkxK?=
 =?utf-8?B?ZWpZTlY1Z0gvZHFqTzY4cWtFdHpBRGF5YlFZMVU3YVkvQkt5SWMrQjkvWHhh?=
 =?utf-8?B?NFFiVzQyUXNwb0NHOHlLRFVkaWMwaVJwR1ZRaXlJbFlJcHRwUlI1dk1FcmI5?=
 =?utf-8?B?QWVrVHh4QTkvYXROTzVQUk11T0lvODZoMFZVajBEOTFKb2YxQXBrVGhUVE9Z?=
 =?utf-8?B?WVpNVTN1bXlqcWt1SGxDUUNzWHRrR3Q4clIvcHVxVW9hUmsyLzh4TDVWbDhV?=
 =?utf-8?B?V1JSUFgyYlA4cFMzSnJ4MCsyNnJYazE4YjZrTjhsMHJlQS9PSXUvdG5Ea0pa?=
 =?utf-8?B?TFAveEhFV3F1cDhDWEFBQnp0MS9VaGwra2dlY3JCMkdKR2t1Wi9HbWhzNmcr?=
 =?utf-8?B?ZHJUNk92TGkxNTRVZzNGOHcralp3d3BOYUZHa0pxWlVjK1BpVksycDVQNUdP?=
 =?utf-8?B?TFlhR3kyNUxqVkU1Q3dzUDNyNDVGOE5UbW5GQjJLN1l5MmxPVStyVnJDZTZ5?=
 =?utf-8?B?T2xQMGtqaG9FZHZPWUUvOEh0UVAvLzRGQ0pQT0x0Qm40Q25NMzhWcjZCY0Fo?=
 =?utf-8?Q?8EmZuW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXZYbDhQdmN3OFM1a0NIY0ozTitDVzV0ZzNxVzhYYm9weE44ak1FQzdQbDl4?=
 =?utf-8?B?QU51SGFqZFlseTFxMEdNaGJPUFV1d3JWVXFwYXZ0Z1lXTWcwWlcwTkgrNVFZ?=
 =?utf-8?B?ZlAxNVZFWG92b2g5TTJUVEFVRUpFQmhkenVZelptdEpFbTNVbGI5TGEreXpo?=
 =?utf-8?B?UEtEUnFWeHY2aEFUWUtvRFNVWWF3NU1Pbi9RL2Zla2xaYUo3WGtmZ1gvaHFY?=
 =?utf-8?B?UzZOdmN0NVdRTXc0S3ptZG9KenNqUzF2NVhNcCtCVk11SmNDZXJRQ1F0dG1j?=
 =?utf-8?B?NTM0NDcrT0kzU2UxOG1YQklrdnNIUzludFRSZkNQaVdUVWFxTXhEYVNkSExY?=
 =?utf-8?B?SVgyMXlHM3FXbi9YYnI4Mm9LRk41ZFF1VU1YSjk2aWdMeG9vMHArUFYrTkJu?=
 =?utf-8?B?eTd3RjRXVFkzOTJKSkptRkdKbTIyMEVXMUVBanFwMzNKTHJQVmcveTdpUVox?=
 =?utf-8?B?Y1ducVpXSnJLdlN5cDdrRk5QVE43MGRiU0ppMzBQeXhrWW9CZG9yaVcxQkoz?=
 =?utf-8?B?VWNHYUxONnprcGpDQnZiNmU4WGQvejdaTUNhN2U0YnBUTEJVNVFVenpRRjJS?=
 =?utf-8?B?TEVqT0F3RiszSmpDSGtjdEVGM3IxckZDTE1ZV1VrMFZScjBOaVBVYktselRM?=
 =?utf-8?B?VE1TazVacE1yblg3T2N6YVNGZytabGVuL0ZCQ2RROVFQVmRjR1pVTHp0Q2xZ?=
 =?utf-8?B?Zk05OWRCSGdwTkVmVlRpN2FNeEtrakYzTHV2ZE5QWXhyT3ZKUEtsV0N2RkpC?=
 =?utf-8?B?THpIYnJLMlRyTC9sZXZvU2tZWHdORlVaV2F3amJ2Vnh2dUYrcmcrRTZQK1cw?=
 =?utf-8?B?MFErdzBEL3Z6UFZaR2FmZnJ3U0ovemJhWnIyRnVWd0s1amN6dDUza3F2NlNy?=
 =?utf-8?B?dllOaGNrQWFiQlNmVjFJZmNPYjhWRmN6K1ZhNWlybFVpdkl1NllWK0VudmVJ?=
 =?utf-8?B?eVVOc1hHT0M5TnlPME5Vb3NtTmcvcTgxSVVGTWRCbnBib1dJbENkc1RSc3BW?=
 =?utf-8?B?S1dFblpYV3BXMnVCc0tBc0VYRThpNDFGQzAxYzFsMzJzaUEyTHM0dzFTR3pB?=
 =?utf-8?B?ZnphL1duMjkzVlJBRG1HQzVqVVlPUWVhaUU1YUtEQlVPZWwzSkR6UjNCVVkv?=
 =?utf-8?B?dlh6U1BuUER1R1plSXJWem1LUHlPV25tOFVlWVlxTnlhYzZGQzZoeUNTRWlI?=
 =?utf-8?B?QWNDYmt1bGFuK3BTQmp2ZWlRSjRmRjBWZU9rcXNEOXlrZzhieUUyNkJLMEdL?=
 =?utf-8?B?eTdNVkFSZGh1ZmFBeklPanJrNkZYYWtNRU1BQThMSWY0dFE0TWR2Mk1HMVYr?=
 =?utf-8?B?WmFFZGpzbTErcEZpTlo5NzY4ZXJBczVXVitSSDd2amFYVDc4MUQrOWtwVWlW?=
 =?utf-8?B?YXFVTTBWTGs1WnBKVWhIb1QzbldxRUZlZnhnYVNBK2ZjVHZEblBlN05zTWFN?=
 =?utf-8?B?OXdRZWtTVVJLUXJxeUZDKzVtNUw1Y1A3aHlBUzVDa2w5bWphcm9WV3pVN0U4?=
 =?utf-8?B?SVBkbXI0NkZUcjlBdEF1U2toMzZKUkNtNHhoM2NZMjE4aW14QmViNWR4V2di?=
 =?utf-8?B?YzViMFdaN2RmUHJVM2dFdjh5ZzJWY09KL09tRzFoay9pR2tWT2hIK0tzM3h0?=
 =?utf-8?B?eG1jUzJtMFRzdUQrRnVoaDIrNlpKL00zZ0c1UUF6K2NLOTRjaEJVV2xWd1Uw?=
 =?utf-8?B?RiszbXkxOWRubndCalNUbW5lU09TOGZlbTM2cC9lNHhDWkkvWVdRRGNBb1hk?=
 =?utf-8?B?ejNySm9RRXFwRjJISEVJV1c4ekVLUm5pM3k0NVRVclBIbmx1WFlGWVp3R3BV?=
 =?utf-8?B?WmtXNU54MUFWejZBNmdLdkhOUEF6WUZGRSs3TG4zRkd2UUgvK09vZmVNQldS?=
 =?utf-8?B?aHFqSDFLMFE5dE9KTCszSHEweU9LK2NVaGpxNDJBWXV6eVg0T0tlZHNtWHlw?=
 =?utf-8?B?dkN0RmV2TmkvSGwzaUowVzBCN0xFUEwvcjZhTFlGaHZobzYyTFV2VjRhOWhj?=
 =?utf-8?B?Q3FmYzVaR2J3TUR6YjFqVzNDeEN6VThrK09ObXlMMURVTklQNFlnNnpVTW1T?=
 =?utf-8?B?QVFqekExMXF5cnprS0lNZ25uSWNQUHMwbVlhOHJmRHZXei92emJqQlRVeTZQ?=
 =?utf-8?B?YXFwR1UvTHYveERYb21UZkFxMHpUSHdJUVZxRHNzOGVNOHVSUjJpRGpNcHJl?=
 =?utf-8?Q?RJmyW/P6kor1IIFF005blQQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A631C1F0357B974FA9A5E7C155886D0A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035480bd-35c4-43cc-0429-08ddfcf93b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 12:35:52.6261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOIvlmF26yhbSnKCojRCUiOEIJl10CT8DvdiVPonDkRvh9GrLgDWO6lxdnadhQxgU7tvUSTpdlJmQjWO4xIGUR2DnA284DiO3kMCUJ4U+Y3ZYxKq1aU19ZWQtZNNZJZn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7515
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

SGkgWmhlbnpobm9nLA0KDQpOaWNlIQ0KDQpSZXZpZXdlZC1ieTogQ2zDqW1lbnQgTWF0aGlldS0t
RHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQoNClRoYW5rcw0KDQpPbiBG
cmksIDIwMjUtMDktMTkgYXQgMDM6MDYgLTA0MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiBD
YXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sg
bGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gSW4gZWFybHkgZGF5cywgd2Ug
aGF2ZSBkaWZmZXJlbnQgdHJpY2tzIHRvIGVuc3VyZSBjYWNoaW5nLW1vZGU9b24gd2l0aCBWRklP
ICANCj4gZGV2aWNlOg0KPiANCj4gMjhjZjU1M2FmZSAoImludGVsX2lvbW11OiBTYW5pdHkgY2hl
Y2sgdmZpby1wY2kgY29uZmlnIG9uIG1hY2hpbmUgaW5pdCBkb25lIikgIA0KPiBjNmNiYzI5ZDM2
ICgicGMvcTM1OiBEaXNhbGxvdyB2ZmlvLXBjaSBob3RwbHVnIHdpdGhvdXQgVlQtZCBjYWNoaW5n
IG1vZGUiKSAgDQo+IGI4ZDc4Mjc3YzAgKCJpbnRlbC1pb21tdTogZmFpbCBNQVAgbm90aWZpZXIg
d2l0aG91dCBjYWNoaW5nIG1vZGUiKQ0KPiANCj4gQmVjYXVzZSB3aXRob3V0IGNhY2hpbmcgbW9k
ZSwgTUFQIG5vdGlmaWVyIHdvbid0IHdvcmsgY29ycmVjdGx5IHNpbmNlIGd1ZXN0ICANCj4gd29u
J3Qgc2VuZCBJT1RMQiB1cGRhdGUgZXZlbnQgd2hlbiBpdCBlc3RhYmxpc2hlcyBuZXcgbWFwcGlu
Z3MgaW4gdGhlIEkvTyBwYWdlICANCj4gdGFibGVzLg0KPiANCj4gTm93IHdpdGggaG9zdCBJT01N
VSBkZXZpY2UgaW50ZXJmYWNlIGJldHdlZW4gVkZJTyBhbmQgdklPTU1VLCB3ZSBjYW4gc2ltcGxp
ZnkgIA0KPiBpdCB3aXRoIGEgc21hbGwgY2hlY2sgaW4gc2V0X2lvbW11X2RldmljZSgpLiBUaGlz
IGFsc28gd29ya3MgZm9yIGZ1dHVyZSBWRFBBICANCj4gaW1wbGVtZW50YXRpb24gd2hpY2ggbWF5
IGFsc28gbmVlZCBjYWNoaW5nIG1vZGUgb24uDQo+IA0KPiBGb3IgY29sZHBsdWcgVkZJTyBkZXZp
Y2U6DQo+IA0KPiBxZW11LXN5c3RlbS14ODZfNjQ6IC1kZXZpY2UgdmZpby1wY2ksaG9zdD0wMDAw
OjNiOjAwLjAsaWQ9aG9zdGRldjMsYnVzPXJvb3QwLGlvbW11ZmQ9aW9tbXVmZDA6IHZmaW8gMDAw
MDozYjowMC4wOiBGYWlsZWQgdG8gc2V0IHZJT01NVTogRGV2aWNlIGFzc2lnbm1lbnQgaXMgbm90
IGFsbG93ZWQgd2l0aG91dCBlbmFibGluZyBjYWNoaW5nLW1vZGU9b24gZm9yIEludGVsIElPTU1V
Lg0KPiANCj4gRm9yIGhvdHBsdWcgVkZJTyBkZXZpY2U6DQo+IA0KPiBFcnJvcjogdmZpbyAwMDAw
OjNiOjAwLjA6IEZhaWxlZCB0byBzZXQgdklPTU1VOiBEZXZpY2UgYXNzaWdubWVudCBpcyBub3Qg
YWxsb3dlZCB3aXRob3V0IGVuYWJsaW5nIGNhY2hpbmctbW9kZT1vbiBmb3IgSW50ZWwgSU9NTVUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8W3poZW56aG9uZy5kdWFuQGlu
dGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSk+ICANCj4gLS0tICANCj4g
wqBody9pMzg2L2ludGVsX2lvbW11LmMgfCA0NyArKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tICANCj4gwqBody9pMzg2L3BjLmPCoMKgwqDCoMKgwqDCoMKgwqAgfCAy
MCAtLS0tLS0tLS0tLS0tLS0tLS0gIA0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspLCA2MSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lv
bW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMgIA0KPiBpbmRleCBmMDQzMDAwMjJlLi41YzY3
YjQyZGRlIDEwMDY0NCAgDQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyAgDQo+ICsrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYyAgDQo+IEBAIC04NSwxMyArODUsNiBAQCBzdHJ1Y3QgdnRk
X2lvdGxiX2tleSB7ICANCj4gwqBzdGF0aWMgdm9pZCB2dGRfYWRkcmVzc19zcGFjZV9yZWZyZXNo
X2FsbChJbnRlbElPTU1VU3RhdGUgKnMpOyAgDQo+IMKgc3RhdGljIHZvaWQgdnRkX2FkZHJlc3Nf
c3BhY2VfdW5tYXAoVlREQWRkcmVzc1NwYWNlICphcywgSU9NTVVOb3RpZmllciAqbik7DQo+IA0K
PiAtc3RhdGljIHZvaWQgdnRkX3BhbmljX3JlcXVpcmVfY2FjaGluZ19tb2RlKHZvaWQpICANCj4g
LXsgIA0KPiAtwqDCoMKgIGVycm9yX3JlcG9ydCgiV2UgbmVlZCB0byBzZXQgY2FjaGluZy1tb2Rl
PW9uIGZvciBpbnRlbC1pb21tdSB0byBlbmFibGUgIiAgDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAiZGV2aWNlIGFzc2lnbm1lbnQgd2l0aCBJT01NVSBwcm90ZWN0aW9uLiIp
OyAgDQo+IC3CoMKgwqAgZXhpdCgxKTsgIA0KPiAtfSAgDQo+IC0gIA0KPiDCoHN0YXRpYyB2b2lk
IHZ0ZF9kZWZpbmVfcXVhZChJbnRlbElPTU1VU3RhdGUgKnMsIGh3YWRkciBhZGRyLCB1aW50NjRf
dCB2YWwsICANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdWludDY0X3Qgd21hc2ssIHVpbnQ2NF90IHcxY21hc2spICANCj4gwqB7ICAN
Cj4gQEAgLTM3MzEsMTMgKzM3MjQsNiBAQCBzdGF0aWMgaW50IHZ0ZF9pb21tdV9ub3RpZnlfZmxh
Z19jaGFuZ2VkKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSwgIA0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiU25vb3AgQ29udHJvbCB3aXRoIHZo
b3N0IG9yIFZGSU8gaXMgbm90IHN1cHBvcnRlZCIpOyAgDQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FTk9UU1VQOyAgDQo+IMKgwqDCoMKgIH0gIA0KPiAtwqDCoMKgIGlmICghcy0+Y2FjaGlu
Z19tb2RlICYmIChuZXcgJiBJT01NVV9OT1RJRklFUl9NQVApKSB7ICANCj4gLcKgwqDCoMKgwqDC
oMKgIGVycm9yX3NldGdfZXJybm8oZXJycCwgRU5PVFNVUCwgIA0KPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJkZXZpY2UgJTAyeC4lMDJ4LiV4IHJl
cXVpcmVzIGNhY2hpbmcgbW9kZSIsICANCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBwY2lfYnVzX251bSh2dGRfYXMtPmJ1cyksIFBDSV9TTE9UKHZ0
ZF9hcy0+ZGV2Zm4pLCAgDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgUENJX0ZVTkModnRkX2FzLT5kZXZmbikpOyAgDQo+IC3CoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVOT1RTVVA7ICANCj4gLcKgwqDCoCB9ICANCj4gwqDCoMKgwqAgaWYgKCF4ODZf
aW9tbXUtPmR0X3N1cHBvcnRlZCAmJiAobmV3ICYgSU9NTVVfTk9USUZJRVJfREVWSU9UTEJfVU5N
QVApKSB7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIEVOT1RT
VVAsICANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgImRldmljZSAlMDJ4LiUwMnguJXggcmVxdWlyZXMgZGV2aWNlIElPVExCIG1vZGUiLCAgDQo+
IEBAIC00Mzc4LDYgKzQzNjQsMTIgQEAgc3RhdGljIGJvb2wgdnRkX2Rldl9zZXRfaW9tbXVfZGV2
aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbiwNCj4gDQo+IMKgwqDCoMKg
IGFzc2VydChoaW9kKTsNCj4gDQo+ICvCoMKgwqAgaWYgKCFzLT5jYWNoaW5nX21vZGUpIHsgIA0K
PiArwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAiRGV2aWNlIGFzc2lnbm1lbnQgaXMg
bm90IGFsbG93ZWQgd2l0aG91dCBlbmFibGluZyAiICANCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAiY2FjaGluZy1tb2RlPW9uIGZvciBJbnRlbCBJT01NVS4iKTsgIA0K
PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOyAgDQo+ICvCoMKgwqAgfSAgDQo+ICsgIA0K
PiDCoMKgwqDCoCB2dGRfaW9tbXVfbG9jayhzKTsNCj4gDQo+IMKgwqDCoMKgIGlmIChnX2hhc2hf
dGFibGVfbG9va3VwKHMtPnZ0ZF9ob3N0X2lvbW11X2RldiwgJmtleSkpIHsgIA0KPiBAQCAtNDkx
MCwzMiArNDkwMiw2IEBAIHN0YXRpYyBib29sIHZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVT
dGF0ZSAqcywgRXJyb3IgKiplcnJwKSAgDQo+IMKgwqDCoMKgIHJldHVybiB0cnVlOyAgDQo+IMKg
fQ0KPiANCj4gLXN0YXRpYyBpbnQgdnRkX21hY2hpbmVfZG9uZV9ub3RpZnlfb25lKE9iamVjdCAq
Y2hpbGQsIHZvaWQgKnVudXNlZCkgIA0KPiAteyAgDQo+IC3CoMKgwqAgSW50ZWxJT01NVVN0YXRl
ICppb21tdSA9IElOVEVMX0lPTU1VX0RFVklDRSh4ODZfaW9tbXVfZ2V0X2RlZmF1bHQoKSk7ICAN
Cj4gLSAgDQo+IC3CoMKgwqAgLyogIA0KPiAtwqDCoMKgwqAgKiBXZSBoYXJkLWNvZGVkIGhlcmUg
YmVjYXVzZSB2ZmlvLXBjaSBpcyB0aGUgb25seSBzcGVjaWFsIGNhc2UgIA0KPiAtwqDCoMKgwqAg
KiBoZXJlLsKgIExldCdzIGJlIG1vcmUgZWxlZ2FudCBpbiB0aGUgZnV0dXJlIHdoZW4gd2UgY2Fu
LCBidXQgc28gIA0KPiAtwqDCoMKgwqAgKiBmYXIgdGhlcmUgc2VlbXMgdG8gYmUgbm8gYmV0dGVy
IHdheS4gIA0KPiAtwqDCoMKgwqAgKi8gIA0KPiAtwqDCoMKgIGlmIChvYmplY3RfZHluYW1pY19j
YXN0KGNoaWxkLCAidmZpby1wY2kiKSAmJiAhaW9tbXUtPmNhY2hpbmdfbW9kZSkgeyAgDQo+IC3C
oMKgwqDCoMKgwqDCoCB2dGRfcGFuaWNfcmVxdWlyZV9jYWNoaW5nX21vZGUoKTsgIA0KPiAtwqDC
oMKgIH0gIA0KPiAtICANCj4gLcKgwqDCoCByZXR1cm4gMDsgIA0KPiAtfSAgDQo+IC0gIA0KPiAt
c3RhdGljIHZvaWQgdnRkX21hY2hpbmVfZG9uZV9ob29rKE5vdGlmaWVyICpub3RpZmllciwgdm9p
ZCAqdW51c2VkKSAgDQo+IC17ICANCj4gLcKgwqDCoCBvYmplY3RfY2hpbGRfZm9yZWFjaF9yZWN1
cnNpdmUob2JqZWN0X2dldF9yb290KCksICANCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZ0ZF9tYWNoaW5lX2Rv
bmVfbm90aWZ5X29uZSwgTlVMTCk7ICANCj4gLX0gIA0KPiAtICANCj4gLXN0YXRpYyBOb3RpZmll
ciB2dGRfbWFjaGluZV9kb25lX25vdGlmeSA9IHsgIA0KPiAtwqDCoMKgIC5ub3RpZnkgPSB2dGRf
bWFjaGluZV9kb25lX2hvb2ssICANCj4gLX07ICANCj4gLSAgDQo+IMKgc3RhdGljIHZvaWQgdnRk
X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKSAgDQo+IMKgeyAgDQo+IMKg
wqDCoMKgIE1hY2hpbmVTdGF0ZSAqbXMgPSBNQUNISU5FKHFkZXZfZ2V0X21hY2hpbmUoKSk7ICAN
Cj4gQEAgLTQ5OTAsNyArNDk1Niw2IEBAIHN0YXRpYyB2b2lkIHZ0ZF9yZWFsaXplKERldmljZVN0
YXRlICpkZXYsIEVycm9yICoqZXJycCkgIA0KPiDCoMKgwqDCoCBwY2lfc2V0dXBfaW9tbXUoYnVz
LCAmdnRkX2lvbW11X29wcywgZGV2KTsgIA0KPiDCoMKgwqDCoCAvKiBQc2V1ZG8gYWRkcmVzcyBz
cGFjZSB1bmRlciByb290IFBDSSBidXMuICovICANCj4gwqDCoMKgwqAgeDg2bXMtPmlvYXBpY19h
cyA9IHZ0ZF9ob3N0X2RtYV9pb21tdShidXMsIHMsIFEzNV9QU0VVRE9fREVWRk5fSU9BUElDKTsg
IA0KPiAtwqDCoMKgIHFlbXVfYWRkX21hY2hpbmVfaW5pdF9kb25lX25vdGlmaWVyKCZ2dGRfbWFj
aGluZV9kb25lX25vdGlmeSk7ICANCj4gwqB9DQo+IA0KPiDCoHN0YXRpYyB2b2lkIHZ0ZF9jbGFz
c19pbml0KE9iamVjdENsYXNzICprbGFzcywgY29uc3Qgdm9pZCAqZGF0YSkgIA0KPiBkaWZmIC0t
Z2l0IGEvaHcvaTM4Ni9wYy5jIGIvaHcvaTM4Ni9wYy5jICANCj4gaW5kZXggYmMwNDhhNmQxMy4u
MDFjZDlhNjdkYiAxMDA2NDQgIA0KPiAtLS0gYS9ody9pMzg2L3BjLmMgIA0KPiArKysgYi9ody9p
Mzg2L3BjLmMgIA0KPiBAQCAtMTcyMCwyNSArMTcyMCw2IEBAIHN0YXRpYyB2b2lkIHBjX21hY2hp
bmVfd2FrZXVwKE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkgIA0KPiDCoMKgwqDCoCBjcHVfc3luY2hy
b25pemVfYWxsX3Bvc3RfcmVzZXQoKTsgIA0KPiDCoH0NCj4gDQo+IC1zdGF0aWMgYm9vbCBwY19o
b3RwbHVnX2FsbG93ZWQoTWFjaGluZVN0YXRlICptcywgRGV2aWNlU3RhdGUgKmRldiwgRXJyb3Ig
KiplcnJwKSAgDQo+IC17ICANCj4gLcKgwqDCoCBYODZJT01NVVN0YXRlICppb21tdSA9IHg4Nl9p
b21tdV9nZXRfZGVmYXVsdCgpOyAgDQo+IC3CoMKgwqAgSW50ZWxJT01NVVN0YXRlICppbnRlbF9p
b21tdTsgIA0KPiAtICANCj4gLcKgwqDCoCBpZiAoaW9tbXUgJiYgIA0KPiAtwqDCoMKgwqDCoMKg
wqAgb2JqZWN0X2R5bmFtaWNfY2FzdCgoT2JqZWN0ICopaW9tbXUsIFRZUEVfSU5URUxfSU9NTVVf
REVWSUNFKSAmJiAgDQo+IC3CoMKgwqDCoMKgwqDCoCBvYmplY3RfZHluYW1pY19jYXN0KChPYmpl
Y3QgKilkZXYsICJ2ZmlvLXBjaSIpKSB7ICANCj4gLcKgwqDCoMKgwqDCoMKgIGludGVsX2lvbW11
ID0gSU5URUxfSU9NTVVfREVWSUNFKGlvbW11KTsgIA0KPiAtwqDCoMKgwqDCoMKgwqAgaWYgKCFp
bnRlbF9pb21tdS0+Y2FjaGluZ19tb2RlKSB7ICANCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiRGV2aWNlIGFzc2lnbm1lbnQgaXMgbm90IGFsbG93ZWQgd2l0aG91
dCAiICANCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJl
bmFibGluZyBjYWNoaW5nLW1vZGU9b24gZm9yIEludGVsIElPTU1VLiIpOyAgDQo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsgIA0KPiAtwqDCoMKgwqDCoMKgwqAgfSAgDQo+
IC3CoMKgwqAgfSAgDQo+IC0gIA0KPiAtwqDCoMKgIHJldHVybiB0cnVlOyAgDQo+IC19ICANCj4g
LSAgDQo+IMKgc3RhdGljIHZvaWQgcGNfbWFjaGluZV9jbGFzc19pbml0KE9iamVjdENsYXNzICpv
YywgY29uc3Qgdm9pZCAqZGF0YSkgIA0KPiDCoHsgIA0KPiDCoMKgwqDCoCBNYWNoaW5lQ2xhc3Mg
Km1jID0gTUFDSElORV9DTEFTUyhvYyk7ICANCj4gQEAgLTE3NTgsNyArMTczOSw2IEBAIHN0YXRp
YyB2b2lkIHBjX21hY2hpbmVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQg
KmRhdGEpICANCj4gwqDCoMKgwqAgeDg2bWMtPmFwaWNfeHJ1cHRfb3ZlcnJpZGUgPSB0cnVlOyAg
DQo+IMKgwqDCoMKgIGFzc2VydCghbWMtPmdldF9ob3RwbHVnX2hhbmRsZXIpOyAgDQo+IMKgwqDC
oMKgIG1jLT5nZXRfaG90cGx1Z19oYW5kbGVyID0gcGNfZ2V0X2hvdHBsdWdfaGFuZGxlcjsgIA0K
PiAtwqDCoMKgIG1jLT5ob3RwbHVnX2FsbG93ZWQgPSBwY19ob3RwbHVnX2FsbG93ZWQ7ICANCj4g
wqDCoMKgwqAgbWMtPmF1dG9fZW5hYmxlX251bWFfd2l0aF9tZW1ocCA9IHRydWU7ICANCj4gwqDC
oMKgwqAgbWMtPmF1dG9fZW5hYmxlX251bWFfd2l0aF9tZW1kZXYgPSB0cnVlOyAgDQo+IMKgwqDC
oMKgIG1jLT5oYXNfaG90cGx1Z2dhYmxlX2NwdXMgPSB0cnVlOyAgDQo+IC0tICANCj4gMi40Ny4x
DQo+IA==

