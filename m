Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B752C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qM-0004Xg-1D; Wed, 15 May 2024 03:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qG-0004WE-HD
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:24 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qD-0000oc-P4
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757261; x=1747293261;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=AokO+Y+dmAog8wVRs7/0+s0ZVn9kR7aKuJmrVWyh9P0=;
 b=e8Yb8eFTwRoM1Sex8uV7vJeGt4/S8fbApI0+GeWBSA8tBNCZIMssqLXl
 Y78KC5uXicqSfQ/bZs/2JA+QMST1TtQpjg52n/z2QVCPPirlDwquP07tr
 hEWZaEKvpoouelDHolkOcpdcg8UCoV+6XoaSYSD6gu429M77RtIXyu8ol
 4b58XS0/UaBGuMpFwMaBq2h4JL93FYmLmJAfuV+jghWwju51Gze91ysUU
 +10yxeAwMDf9qVGIY7l+YUY/W/lwrfFqFyKTYm3SOTcFKxisa2EAbidmb
 erkmXBnTwro1Z3be6UxKPDRTyK5QCcL8q0ek6UvA+8Um7ZSLaBxphJFbL A==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12635435"
X-MGA-submission: =?us-ascii?q?MDEvMaYoVmKgfibQ5D99Lv3zNQgHXH26XQ4V8W?=
 =?us-ascii?q?kkvEX/xWX92iLZV43wrb9CXB6kftmQj8Bh/o4D+65zoLc7ow1fdGqXka?=
 =?us-ascii?q?LIAcVA9traemO8FejFIG/s1CgDxh1Cj4EWqZD7sOULvei6qiIS2WJ2fc?=
 =?us-ascii?q?PiOV8zcBun2fir+TSdU7VOyg=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:18 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZWwukd5W8PbCgbqSS2eVtXQtZAXz/rcwkwB99C3GBPvP3HKbh0eAc1C84cnoFWvb1zktzK/GzdbHsTHugmbeIMfatKDWD81tkcZ0QxOTnuOrxnqT9oT43aljS74JR9tBOdXASpMy6Fo2PDrHLgqzdBwfke/JsqEGv/+zydWYv4ZaEuZiV35JNTWSQM29VSdMxViI+7iQbTROLUkdsxRX1yuT82B0+YGvzLUUKu79dohI0vtz4vR+ucmFj9mOHlJ5yZE+pSxVRaE+lWXbEdQsl51I1atsQFy5ToyRW570Qw7Eckd+L04BBFgZdC01SvM8d8vQw53LWgJvI1oeXBwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AokO+Y+dmAog8wVRs7/0+s0ZVn9kR7aKuJmrVWyh9P0=;
 b=DmsKQCm//hOtLmxtA3YAzveB6tiIwLr/fCXIjyl9ynhkKcnwEXYgyvD0x0DMXSEPTyGEgKH2qgE0PJO0OIvCKzGHhk+fMAU0ciU1MaJUphBHMownbKviIEYr3qD5WW2H25gHe7DpRtVRBY1xB4V2GVQQX5CYy2J43jcFYQefoYB6XZ7fNM6pMR1uhCQ/Q9K+9NUSVv6jXBgyJio4DSBIhwFkGj1HsJFNkAxe/8eurRSEj+SjfdSEskr6TZ6Cj+RDZJ/qQBCvdDq4wMn7J48zIQzBWrTwEXwX9VNLvZ6DOPXA2bu6rGrYNcOjZuETpmfEJv9RBwSB+CgV9GYV3aBzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9896.eurprd07.prod.outlook.com (2603:10a6:20b:676::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:14:16 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:16 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 09/25] pcie: add helper to declare PASID capability
 for a pcie device
Thread-Topic: [PATCH ats_vtd v2 09/25] pcie: add helper to declare PASID
 capability for a pcie device
Thread-Index: AQHappd/7uFSi459/0Sy623t6JmRtA==
Date: Wed, 15 May 2024 07:14:16 +0000
Message-ID: <20240515071057.33990-10-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9896:EE_
x-ms-office365-filtering-correlation-id: f7c61076-24be-4780-8b93-08dc74aea190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bjVlZDFsbVJYVExxMnZialhSQm9oYU5VVGIzSk53V3dZSFdvbExuUkFrcDBL?=
 =?utf-8?B?a1NSK1htQ2xNK3djeVlOMUtwT1NxaFhOZ3h5Yll1bVJ0MmlKQzJNSG00Tnhj?=
 =?utf-8?B?QnlEQVp4dnY5clduazM0bzU2dFE3SHlhYklxZjVOK28waUk2TjE0cmFyQWdV?=
 =?utf-8?B?VDNVb3VBWlkwbVRNSTU1Ri92YS9oWW1hSHFyTnJyZDRBM3Fta20vMmsvMzNz?=
 =?utf-8?B?Q21NcWlYV1hJSDZLVnlqRW9oZHZqSlNVL0M2U2dBOC96dFhBRlpLSHR2VnJN?=
 =?utf-8?B?Yk1KNFA3b2s3ZDBjR1pSU0hKSDRQVWNRVS9BWVYwa2duSWhvVXB5RzNobW5N?=
 =?utf-8?B?cWdrTW90SzdYZFVPa3FsU1BoaXpBSGl6RTJwYXVaUUhrMkxNTUwwTjlITTh2?=
 =?utf-8?B?dnoyTjhFY0ZlUWtsbVllTnphK2tyU2VBZzJnREc5cG04Rk5IczBsbDBNSVNZ?=
 =?utf-8?B?Kyt5ZWVSaWhMMCtuMEN1WmtXVlhqV1gvcVdLSVNHNUxhdWZwOUY4amMxYW9U?=
 =?utf-8?B?dGJNQlE3dko5N05iVDNWQ1hLNzJJTTI5WFExVDVZNzcveEJFdlA4cmc3Y3gw?=
 =?utf-8?B?MEZCU0xWVWEzb0cyckhRcWtPcHJ5MVNDTGRYay9ZOERpQmFsTU9rU29lSzM3?=
 =?utf-8?B?ei93ekdwM0FvUzV2U2psV3VnVnIrKzE0SysyUElHdWJCWjYzNHBNd1c5c1ZX?=
 =?utf-8?B?YjJpQ2hRbzh4L3pidlVhTjRNZ0psY2pJOHBnZGljR2cvVmlpWW5KVUVJeVRo?=
 =?utf-8?B?SFZ6c3kxSWtERUVoU0RXelQxOUlUTUd6SkhGM1duVmgyb0piN0trOC84Nkpq?=
 =?utf-8?B?bGZKd3A1YVg0WWtFcld5dVpVOGJqeDg0Q3FvbUpqUmN3UHpWTVcyZTQzY2Jy?=
 =?utf-8?B?TzNsM3NJMkU5ZWFjbWVERWVZRmRZOEZzcmhHb0htRXp5emRZZDJ5a21iMWE3?=
 =?utf-8?B?aTg3Z3lpSDBTcFg0clhtRGxNdHBoa1d2MzBkS1QzQWczYS91YjRaN24xaTB6?=
 =?utf-8?B?d1JnbWgxL1dmM3NubTY1R1A5MzNwa3lUaGsyRXZha0xnMDB3VWhEeFNabE5x?=
 =?utf-8?B?ZVlISHVvTkx3U2JXMjhwbExlaUdiRkRLUHcrcWpJSk1DVFl0bWNKVWFrMTFZ?=
 =?utf-8?B?R3RhSEthU2hWVU1TTk1iTGJiV3U5bVBPVWRTdFIybk9Qd3prcG1NamJLSC9T?=
 =?utf-8?B?ZnhFdFVkOVZndGpEcFd6WTVvOTZPdCtTNkEwaUxOY05ZQmlzZGR0aEw3MVJm?=
 =?utf-8?B?MlFqZGI4TEJicklKR2w0T2RMNWg5cGVXQVJQZXhDNmNGMDJqZ2xlVXdGSnkz?=
 =?utf-8?B?TG4zbHNRWUFTZUtCejhOcVg3bHU3N1VYZ09IRkx1YnFWUUVTVU5aYlNsZWFP?=
 =?utf-8?B?aXRkQUVlMWdqQWYwZXZ5aHlGYWlwNnM3elhyMTc4anAwQVdvSi9JZE5vMVFo?=
 =?utf-8?B?SjNhM05GUXY1eEJZc3F0d0V5M3RmM3liQ3lZdFpvMUtmUFc5UlYvWmJ0M3lQ?=
 =?utf-8?B?MEFkQzBPSmp4L004Qmhlb1J2dXJKQXJ4Z28wUVpEQkdBOFBLUGJ1eENPSDl4?=
 =?utf-8?B?a2QxNjh5WVNMeEVuclpRL2puUE5qQXJuaFBVeHF2UTZMSDZ6OWVsa0RLbFZj?=
 =?utf-8?B?SWR1WGYzTHZvYWpwbWZQK2h5bXRCbkZSSkExWTNlNFNYaCs5Z3MzTGFmbG5r?=
 =?utf-8?B?b2hoQmw0bm1mWFAyeVJoTWlQbFpkSHFicmRZMlY4bDFLRXNCMGlQWGt2UFJj?=
 =?utf-8?B?dEVPcjRFV2J2T3JWbVNTRnR5VHpoYTR6OFdKVE0rYkp4bTZpL0ZkUGg5Unor?=
 =?utf-8?B?di8wWTFETWtCVENNbVhRZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEhIVEJjSW9sUXliWC9OL242aWFPWVYvZmRLM3N5UlFNNmFxU2RQNDYvWVB1?=
 =?utf-8?B?S2taRTdBSVdRbC9xcnk0WWVqemorZVpTTHRlVFN6YXlkVmR4ODlZL2grS3Y4?=
 =?utf-8?B?aktCUExRNnpMK0JVQmN6OTRXam5YQjFpMnhSRmxhMFJkVHhUdkplU2xrSEE2?=
 =?utf-8?B?SkpWUEFBYzhQbUNtc1JlOXlMVzJzcURDQ3Q0djdmU0hGRWFZVlJETVlTSE5m?=
 =?utf-8?B?Rnlkazdvby9kWTNobk1FUFJMMi82UG9tMS82R1o5bVRrejZaUE5URk16Zksr?=
 =?utf-8?B?MVltUG51NEQrNlVLeU0wNENNQloyMkxDMDZVMjhKcWUycVdleVp3RXM3RzNl?=
 =?utf-8?B?VVBSVjNoQVNweVRqdlVIZFgrWHB0NHJKZkpqU3owK2Z3NUtEMWNFaXUyRHRK?=
 =?utf-8?B?Qi9pcjVFUEtscG0ybTZoUDA1U0N0czdHNlFZN3lqMm1HMGQwL3ZVeGdETkZy?=
 =?utf-8?B?OVZVeHlTL3FTQnppSnRFSlF3L3BDeEVUS0ptenpTV0JYUWJZcFdqcEhJY05r?=
 =?utf-8?B?cTNuZjdsT3JkQm50ZC9qaUUxUGFFbTMrZkFSL0Q2L2JWbFNRS2U4NmJBNGI4?=
 =?utf-8?B?R2x5b1BLNmJQVlJWcndLKzVKVnVIRXBSN3B5YmRqZm9QL2JFV1Z2NjFlMkdq?=
 =?utf-8?B?aVBKbTBVL0NKdDhsU1FnZlpHRGRuS2s4L0YrK0xmVDNVQTFZNHRhRTc5Sjkx?=
 =?utf-8?B?UFhRS0xHbDM5dTBEQUFkMnJ1bnFNSWtzOUhmdlZZNFRoT3lHMXZ0bGx2V2FX?=
 =?utf-8?B?cmRjUWJnb0pDMXN5d25reGJrYS9Bdlp3TVg5aXJxWmV2RVhjdzljYy9ZVE5T?=
 =?utf-8?B?WVB0M24yT0UrTnZMTXdXcWdmVC9Cait6Q3VlVGxydDd5SEdVcGN0WWVsbEFY?=
 =?utf-8?B?R2tad3poZjlWb3VrYW9HNFFDR3RSTDhuMzRqT0FEdGNoaG1PLzlQbEpCcGRk?=
 =?utf-8?B?YjlkWVQ5SFlES214bG9OR3hpODRIeWJ6YkZYWldnRXA2QXRzOEgxUEhiYklJ?=
 =?utf-8?B?aE1lRlN1eU9JRkNFNUtnSlFQUUw0bGhkWDF3TUNucWhBeW1LN0tNblRRVElS?=
 =?utf-8?B?Z3ppekE2VUZvMmFTbVB5YkowT2VVSVpISDF5MWpGWklUaXNsVjJlekxHUlNu?=
 =?utf-8?B?NDJhZVQvMnlHTDhFeTlTWkJCYnBWcFdnNUpWMEJQTUsvNEF1Y3ZKMk8vK1Yy?=
 =?utf-8?B?YzJnWXdtdHhzdjN0cVZPOVUwTnRGaHQ4WmtqUzdTY2gvMC93RGxwbElES2Z6?=
 =?utf-8?B?b0JnYjJlY1krdjQyaS9CVDZQTU1RUUo2WWpzUEF2dERTRFk5dzJUeUlKTG5s?=
 =?utf-8?B?b0QraXdGMmdINDBEb053V2NXZ2VidnJiK3N3SUxDSkNQK25Oa1l4cDRTL2dn?=
 =?utf-8?B?YkovdHcrMzV1UFR2bVpzQUhQVlpkdDZhRDhhQ2Q5eXdsSFZzcm9VenFWc2Ix?=
 =?utf-8?B?UnBoMFFpTnc0M2dMOE9rUm9CeHZacGUyTW9KTEsvNkNMMUM5R3hQODdXc1Iv?=
 =?utf-8?B?aE1GRk82ZC8rMHZiVGpzWkUxdVZ2QzFsUFZocllaUEhZTDZEUlBvdHYzdWZT?=
 =?utf-8?B?cUJQVVBXUWRYejdrU1Yrd2ZqTHVNeDhPbHA5SGJUVEJUYWEwSlhUZy9DZkIr?=
 =?utf-8?B?YWU5V1dVb21lbjVVRHNaQlFkanRXRmh5d2dCbHUrd0RnSm5yRmtkVXd6U2F5?=
 =?utf-8?B?UFpRVnpPemgwK2VGQkRPRGFRdm9qdWgvZ1ZPQW14UFJzUU82Z0RCa044ZjVV?=
 =?utf-8?B?d0FLT1BTc1dkVFoxY21KOVp6Q1hsUUpoZENHTE9FYjdMcTVJS0sxUllRSERv?=
 =?utf-8?B?RjZIbWIvK3plazNnR0o4Sklud3BkT2ZOMDJwQVY4MC94Ly9Wb3FsQ1RUZFkr?=
 =?utf-8?B?ODlacGE1d2R6dnpBMGJnbjJ1N2tGekRSMVhvQXcyUVZqRkF0VStYanhLOW0x?=
 =?utf-8?B?cXFwdytwWDhWYnh0eHkyZXUxeUpuTTVLSEgwcVZSRXZBaHJOQkJNOUp3ZTdh?=
 =?utf-8?B?NUJIbUdtaXZHOGZLZ2dHb2NaanpOT1lmcW1DcEExd3owMVgwL1I4cTRQR0JN?=
 =?utf-8?B?eTNBUlNaczhycW5hUnpPTTlURjk2ZzZweVlVajZUVndoZlVPcGRmUXN1a05J?=
 =?utf-8?B?RXpIOCtlVHFPMUZZMENHbXNRdG10cnZVQ1VkSXVxZUVyT1dUTGZCcENrTU9N?=
 =?utf-8?Q?KpSR78yz8xP1GlD5/nDWaCM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90317D1ABB80924C8C5CB9ADFC71C2D7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c61076-24be-4780-8b93-08dc74aea190
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:16.3231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4GfcaMWGY1Uhx8q76lAz9TYdkVKEayaES5iZA7lvyMNtzWZvaymI9L5c3L80VD8pMhzlkLLX0UomOJI6LNH/eRIIlbDYeK/U3emczJnWpyNV+Pgo17qz1880iTW7gWB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpZS5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9ody9wY2kvcGNp
ZS5oICAgICAgICAgICAgICAgICAgICAgfCAgNiArKysrKy0NCiBpbmNsdWRlL2h3L3BjaS9wY2ll
X3JlZ3MuaCAgICAgICAgICAgICAgICB8ICAzICsrKw0KIGluY2x1ZGUvc3RhbmRhcmQtaGVhZGVy
cy9saW51eC9wY2lfcmVncy5oIHwgIDEgKw0KIDQgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaWUuYyBiL2h3L3Bj
aS9wY2llLmMNCmluZGV4IDRiMmYwODA1YzYuLmQ2YTA1MmI2MTYgMTAwNjQ0DQotLS0gYS9ody9w
Y2kvcGNpZS5jDQorKysgYi9ody9wY2kvcGNpZS5jDQpAQCAtMTE3NywzICsxMTc3LDI3IEBAIHZv
aWQgcGNpZV9hY3NfcmVzZXQoUENJRGV2aWNlICpkZXYpDQogICAgICAgICBwY2lfc2V0X3dvcmQo
ZGV2LT5jb25maWcgKyBkZXYtPmV4cC5hY3NfY2FwICsgUENJX0FDU19DVFJMLCAwKTsNCiAgICAg
fQ0KIH0NCisNCisvKiBQQVNJRCAqLw0KK3ZvaWQgcGNpZV9wYXNpZF9pbml0KFBDSURldmljZSAq
ZGV2LCB1aW50MTZfdCBvZmZzZXQsIHVpbnQ4X3QgcGFzaWRfd2lkdGgsDQorICAgICAgICAgICAg
ICAgICAgICAgYm9vbCBleGVjX3Blcm0sIGJvb2wgcHJpdl9tb2QpDQorew0KKyAgICBhc3NlcnQo
cGFzaWRfd2lkdGggPD0gUENJX0VYVF9DQVBfUEFTSURfTUFYX1dJRFRIKTsNCisgICAgc3RhdGlj
IGNvbnN0IHVpbnQxNl90IGNvbnRyb2xfcmVnX3J3X21hc2sgPSAweDA3Ow0KKyAgICB1aW50MTZf
dCBjYXBhYmlsaXR5X3JlZyA9IHBhc2lkX3dpZHRoOw0KKw0KKyAgICBwY2llX2FkZF9jYXBhYmls
aXR5KGRldiwgUENJX0VYVF9DQVBfSURfUEFTSUQsIFBDSV9QQVNJRF9WRVIsIG9mZnNldCwNCisg
ICAgICAgICAgICAgICAgICAgICAgICBQQ0lfRVhUX0NBUF9QQVNJRF9TSVpFT0YpOw0KKw0KKyAg
ICBjYXBhYmlsaXR5X3JlZyA8PD0gUENJX1BBU0lEX0NBUF9XSURUSF9TSElGVDsNCisgICAgY2Fw
YWJpbGl0eV9yZWcgfD0gZXhlY19wZXJtID8gUENJX1BBU0lEX0NBUF9FWEVDIDogMDsNCisgICAg
Y2FwYWJpbGl0eV9yZWcgfD0gcHJpdl9tb2QgID8gUENJX1BBU0lEX0NBUF9QUklWIDogMDsNCisg
ICAgcGNpX3NldF93b3JkKGRldi0+Y29uZmlnICsgb2Zmc2V0ICsgUENJX1BBU0lEX0NBUCwgY2Fw
YWJpbGl0eV9yZWcpOw0KKw0KKyAgICAvKiBFdmVyeXRoaW5nIGlzIGRpc2FibGVkIGJ5IGRlZmF1
bHQgKi8NCisgICAgcGNpX3NldF93b3JkKGRldi0+Y29uZmlnICsgb2Zmc2V0ICsgUENJX1BBU0lE
X0NUUkwsIDApOw0KKw0KKyAgICBwY2lfc2V0X3dvcmQoZGV2LT53bWFzayArIG9mZnNldCArIFBD
SV9QQVNJRF9DVFJMLCBjb250cm9sX3JlZ19yd19tYXNrKTsNCisNCisgICAgZGV2LT5leHAucGFz
aWRfY2FwID0gb2Zmc2V0Ow0KK30NCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2llLmgg
Yi9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCmluZGV4IDExZjVhOTFiYmIuLmM1OTYyN2Q1NTYgMTAw
NjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCisrKyBiL2luY2x1ZGUvaHcvcGNpL3Bj
aWUuaA0KQEAgLTY5LDggKzY5LDkgQEAgc3RydWN0IFBDSUV4cHJlc3NEZXZpY2Ugew0KICAgICB1
aW50MTZfdCBhZXJfY2FwOw0KICAgICBQQ0lFQUVSTG9nIGFlcl9sb2c7DQogDQotICAgIC8qIE9m
ZnNldCBvZiBBVFMgY2FwYWJpbGl0eSBpbiBjb25maWcgc3BhY2UgKi8NCisgICAgLyogT2Zmc2V0
IG9mIEFUUyBhbmQgUEFTSUQgY2FwYWJpbGl0aWVzIGluIGNvbmZpZyBzcGFjZSAqLw0KICAgICB1
aW50MTZfdCBhdHNfY2FwOw0KKyAgICB1aW50MTZfdCBwYXNpZF9jYXA7DQogDQogICAgIC8qIEFD
UyAqLw0KICAgICB1aW50MTZfdCBhY3NfY2FwOw0KQEAgLTE0Nyw0ICsxNDgsNyBAQCB2b2lkIHBj
aWVfY2FwX3Nsb3RfdW5wbHVnX2NiKEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwgRGV2aWNl
U3RhdGUgKmRldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7
DQogdm9pZCBwY2llX2NhcF9zbG90X3VucGx1Z19yZXF1ZXN0X2NiKEhvdHBsdWdIYW5kbGVyICpo
b3RwbHVnX2RldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRGV2aWNl
U3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKTsNCisNCit2b2lkIHBjaWVfcGFzaWRfaW5pdChQQ0lE
ZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50OF90IHBhc2lkX3dpZHRoLA0KKyAgICAg
ICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBib29sIHByaXZfbW9kKTsNCiAjZW5kaWYg
LyogUUVNVV9QQ0lFX0ggKi8NCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2llX3JlZ3Mu
aCBiL2luY2x1ZGUvaHcvcGNpL3BjaWVfcmVncy5oDQppbmRleCA5ZDNiNjg2OGRjLi4wYTg2NTk4
ZjgwIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmgNCisrKyBiL2luY2x1
ZGUvaHcvcGNpL3BjaWVfcmVncy5oDQpAQCAtODYsNiArODYsOSBAQCB0eXBlZGVmIGVudW0gUENJ
RXhwTGlua1dpZHRoIHsNCiAjZGVmaW5lIFBDSV9BUklfVkVSICAgICAgICAgICAgICAgICAgICAg
MQ0KICNkZWZpbmUgUENJX0FSSV9TSVpFT0YgICAgICAgICAgICAgICAgICA4DQogDQorLyogUEFT
SUQgKi8NCisjZGVmaW5lIFBDSV9QQVNJRF9WRVIgICAgICAgICAgICAgICAgICAgMQ0KKyNkZWZp
bmUgUENJX0VYVF9DQVBfUEFTSURfTUFYX1dJRFRIICAgICAyMA0KIC8qIEFFUiAqLw0KICNkZWZp
bmUgUENJX0VSUl9WRVIgICAgICAgICAgICAgICAgICAgICAyDQogI2RlZmluZSBQQ0lfRVJSX1NJ
WkVPRiAgICAgICAgICAgICAgICAgIDB4NDgNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3N0YW5kYXJk
LWhlYWRlcnMvbGludXgvcGNpX3JlZ3MuaCBiL2luY2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51
eC9wY2lfcmVncy5oDQppbmRleCBhMzkxOTMyMTNmLi40MDZkY2U4ZTgyIDEwMDY0NA0KLS0tIGEv
aW5jbHVkZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3BjaV9yZWdzLmgNCisrKyBiL2luY2x1ZGUv
c3RhbmRhcmQtaGVhZGVycy9saW51eC9wY2lfcmVncy5oDQpAQCAtOTM1LDYgKzkzNSw3IEBADQog
I2RlZmluZSAgUENJX1BBU0lEX0NBUF9FWEVDCTB4MDAwMgkvKiBFeGVjIHBlcm1pc3Npb25zIFN1
cHBvcnRlZCAqLw0KICNkZWZpbmUgIFBDSV9QQVNJRF9DQVBfUFJJVgkweDAwMDQJLyogUHJpdmls
ZWdlIE1vZGUgU3VwcG9ydGVkICovDQogI2RlZmluZSAgUENJX1BBU0lEX0NBUF9XSURUSAkweDFm
MDANCisjZGVmaW5lICBQQ0lfUEFTSURfQ0FQX1dJRFRIX1NISUZUICA4DQogI2RlZmluZSBQQ0lf
UEFTSURfQ1RSTAkJMHgwNiAgICAvKiBQQVNJRCBjb250cm9sIHJlZ2lzdGVyICovDQogI2RlZmlu
ZSAgUENJX1BBU0lEX0NUUkxfRU5BQkxFCTB4MDAwMQkvKiBFbmFibGUgYml0ICovDQogI2RlZmlu
ZSAgUENJX1BBU0lEX0NUUkxfRVhFQwkweDAwMDIJLyogRXhlYyBwZXJtaXNzaW9ucyBFbmFibGUg
Ki8NCi0tIA0KMi40NC4wDQo=

