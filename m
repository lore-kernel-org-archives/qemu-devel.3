Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A32C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 04:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPECw-0001oE-Nz; Thu, 04 Jul 2024 00:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPECv-0001nV-4b
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 00:36:33 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPECs-0002VH-Aa
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 00:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720067790; x=1751603790;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dTVssX81qv1VQECVSvwbocFMY2+JqwIn+b4DVv4X/zg=;
 b=Fp6I8ao7WgMCLTT2KSCew/Jwy+wuQJ3VMWfGZdfnulVAYfBzZviVuu4f
 bGPMIVqKfiIq5oPWoXgbSaDYnxA2LmMtBRjtvEPSgv17jfl7UaUeUgTgd
 JnNKtgpBMP8V8b7eubr3obnsRoZmZDUI8ohIIcvAFdslft/p+4ISqsH2U
 x+Oz0/0E+Yqae/zf3jG0l3hdTbBYPtXSAW6b9cvswd1VEZ32NXZOeU+Ip
 C7twV6SMBB0mUiB20nud90PyOlh+XSob5U3Wky3JP3cB5MeqAOHip9QF1
 4gE/A2AO0Ix9za4SsbltMqfg6kRgSpSv6o9ajqjcGLGdC6xm+qQIz/SQ4 Q==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="15858225"
X-MGA-submission: =?us-ascii?q?MDGRNWn9Ger0l808WNNmxwfAcBMhgHT0ZYYtsM?=
 =?us-ascii?q?/HKZvPjq2+brWjltJCfM9MPwhGyFZ4wPb1xua1N0TzPJwDItaYHBP1j+?=
 =?us-ascii?q?6zk9zID8gzovCrDU+Nl/Y1XRCxUNmNrhABlIv9zRcjRMbsGLeqFuLFV7?=
 =?us-ascii?q?hwdzosi2PF73imhWyLZB2y1w=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 06:36:27 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2MreWk73QuOEul23eIS0grmgRxXYE39W8wGCNVTJ3VWnMEVP3NvjC7U4TbxwZsIJWX+SeHIvn7FdmalN2VJODJSersAkJmrXvdAZd2UO2yaS3UeyOfZVJn0nQbAlChD444CuFNkvfM2sbWfXunBDT1XM00FpS3bEiBhQcVxrL4GFNDJ9PX2VK6psvQ18hfwSCDyzn50hjNEOYWXhKdDR1WtV+5jGqws3Ny0VkvCA+D5oJ+r+73s265wc8vU0ROgvmunPFL4HDvcd7MM9OypngnjbiD5FNdYf4qM79/D0+SSEuFpUCuCCZt8E4yltJUCcOVnJjg491uqkssxR73C8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTVssX81qv1VQECVSvwbocFMY2+JqwIn+b4DVv4X/zg=;
 b=Aj9xd2UtJWFQj+ELzWiSDJo9B+5kjPyMSFj4urQDV82sWvtHZNH/BDgeWRDy7cjUVyleuA6uSicQVtnkiG1FYQjCkE1qRGcrboJoKdfxxKbYjcHS289Hp20mYM/jVgfmR9UyAHDL33JQmdI6DetbYomZVyv4bKjqpaYYdWivK9kVmto5lHWPTDxdmfY4GC2ZQqx7K4giV6dF2vZxYdgERnWGkTkpSia5j/eRC7ObVLAP0sol4MjYh/FwHjIKuPJRs/ht++se098PYBrpzxe9YUeUCNW23MyR0trxC+ovCBAUSB7ZBBi5hkKh1yqxJlClHpGmPCT9ZZfEfpCf0xtvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTVssX81qv1VQECVSvwbocFMY2+JqwIn+b4DVv4X/zg=;
 b=daHeLY5cwXEwJENkUk5tK9MmWWwWFIi+cICoV+wLVXamtHt/q++4WbNoipvN8d+6SS7R5qfbzFkW+VesRrNk/azySQbnn322zQ9s2xEmodxRkd+aM5ZddCGzg0bSuI2QbhxKYQxmBDWN3jB5HQ5+LQ6vxjpkxbHkpFjqGido66vwWonvLKcVxcj3eA3PE4igB1JmTFSZINOjOuQNLOHMOhO8kD+yKc9KHoz5iDrO+FoVUyuRnf/f0DLIFhK2JJccXM3TBCVpDab/vYnEfdJiLg6QMmDfgy3TmNaxjwLGlUObvReagQyNwJulXtjQR+UFCRRE5LC4+Ge7QKSfNXA7qQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6494.eurprd07.prod.outlook.com (2603:10a6:800:18d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 04:36:25 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 04:36:25 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Clement Mathieu--Drif
 <cmdetu@gmail.com>
Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Thread-Topic: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Thread-Index: AQHazEQGTuJM3iTlWUqCZ55Q529ilrHk8acAgAENRYA=
Date: Thu, 4 Jul 2024 04:36:25 +0000
Message-ID: <da9c8ec1-0915-43c7-a4a5-9fb28683fd20@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <1d0c56fe-b821-43c3-9e40-b686573ca840@intel.com>
In-Reply-To: <1d0c56fe-b821-43c3-9e40-b686573ca840@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6494:EE_
x-ms-office365-filtering-correlation-id: 14d043e9-e921-4d32-250c-08dc9be2dd1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V1NqYUpvSUhPOWZxMUd6SlV3cC82MWQ3REIzV3o1YjJmaHNjSER5MUFVMyta?=
 =?utf-8?B?c3ltWFhZUWxvdFYyNjZJb3ZBWkQ4QXppQU1sRGk3UlBYbHpmSTAvYy85ZzFY?=
 =?utf-8?B?OHdVcmRidnRkbXNKOHZqUE5TWkxGNStEUkcyL2lRdWl3dDBCVk9OWDJUQVBZ?=
 =?utf-8?B?V0tQcEpFVXdMYUp1YVYyMDQyeExZNFNzbVF1NlhkNnp2ZDNTZnU5RUJlSnJL?=
 =?utf-8?B?S3hhejdIblp6eVBCNUJLMlpSb2M2L0dNZkpkS1ZwYitubzBLMXpId29zUFNU?=
 =?utf-8?B?bFk4cE8ySDVGQlZ0MFVEdGR5M01RSk9YUVQ2MXVweVMrVkZEeXlRVW5yR3pN?=
 =?utf-8?B?Mk1RVkY0NURZejhpeXRxWXEzblI5WWZsekliNTZXTEZtaGZkRlpYSlZ5bTVO?=
 =?utf-8?B?RGFCaCtQc293eTVyOElaOWF2NHFud0pnMktxL1pEQlo2YnVqcURhNGpHWGpl?=
 =?utf-8?B?alIrNmg2OHNSNGlnT3RJYU9iQy92anlhR0pRK0hFMW50OWNsejAyM1RIcWo0?=
 =?utf-8?B?bTJVOXdBNGp6N2FjTnFiRDNOd2hWTVBFeHlBT09ZNjNRWWd1YVdNUEdac0d5?=
 =?utf-8?B?bllDTDVMQ2dEbXlBSy95eDZBQ3R5WVp5RTVoM3p6Y1E0bGhmM3BvcVBFQmp1?=
 =?utf-8?B?MzJINDVwSXJLUGM1cmpFRHkxZlBjMVR5dE44ZEhabWpjSVJkdmpYUnM5TCto?=
 =?utf-8?B?YVd2am9reUtobEt3OVV4QlRXWkVURHNYcHQ0L0JDd3ZqNXYvUnpIMS82Umg5?=
 =?utf-8?B?eHFsNUFLK1Jja0hCSTBLdDVTVUV4dGxGMEZnNUVUYjR0REdPV2ZweU9sRG5u?=
 =?utf-8?B?dDVPYlUzL2drSWVjaHAyQnBMOWF1YlF0L2QycXNVa1Q1L3JMWnVmblhLRDJD?=
 =?utf-8?B?WXVKVUk4OFlMOU1ZSitzKzZSVXRxcGhjN0lPck8rNTNwWWc4MUltWFFlOGkx?=
 =?utf-8?B?QlFZYjZTTjlZaVJFUWE3MXFPb1ZBTjR6c3BYd2luaDZIV3N6ZDhkVFBHRVI4?=
 =?utf-8?B?TmpiMHRCOGRNTVJKb0llY0FlMmJwS0ZpTHdMQUFUSElqM0dINC92Z1J0MWZN?=
 =?utf-8?B?Y2RFZEZ1cStaa0ZyM2k1ZUxpQ3lFdndrTVd4cXQ3NFhNWDB0bGN4cHR3Q3ZT?=
 =?utf-8?B?N0NGSkxSWkJiZnhNT2RkYnZ4Y3cySzZkZTN3ODlHYmhyTWFhQTAvdlI2Umcr?=
 =?utf-8?B?MjhGWlZkZzczYUR3ZmR4aXZFYjR3U2dPK3p5S1pKSmEzTEoxczdCUzdkaUtq?=
 =?utf-8?B?eFhkTGgwVVFRa1FrUEd6cnVLVDIwSzIwMnp0bW1IK1YwdUc2S0k1bnFoQ00z?=
 =?utf-8?B?RFpKck1hMUt1Z3JKUTNLNGhDNjVaYnUrUUF5M0JvQXhCUXlOWjJLL041cXEw?=
 =?utf-8?B?TnhYVjVYTkJOTmkzNWN4WWIzVzlvT0l5RlVhU3ZsK3ZPNnJUTmJuQ216ZlFi?=
 =?utf-8?B?ZENqWlJBSWFYR3RaYVlsd0xKNWZOdTlhd0QvUjQyd1g1MzFFWVltSC9EdUUz?=
 =?utf-8?B?L29QTHNLZjQ0cWtlRkpBR25JTEJ6cVpwcm1nc2F6LzltVFhsS1AzYmNjeHhw?=
 =?utf-8?B?WWxCQXcrSG9XOUN6N2tTcWR3NXhvOUJEMExpajhCNmRPRmRLcTNNOGdjQk1I?=
 =?utf-8?B?SWNWdXNnNmdJTFYzaUlIVzFMOWNFdmt2RmxrZmRERW14VklseG81d0hMQkda?=
 =?utf-8?B?bHBEdnJEeVkzazRlYU94M1RHNTgrS2lKbG5LRElGSDNJRzNwWUVsVEtXTzhw?=
 =?utf-8?B?YndtcnYwUjVRVWVUcGtoQmN5ODlWOS8zRDdSdkdkSHczS2lDcVRBM0pFTEFV?=
 =?utf-8?Q?ElgLaUbTQQa0V7fg94lSs9vy7y+e8DQPxsyFM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGsvMFpVNkxnVVRzclRNZnNEblc5WlpKaGNCUTVab0oxTHcxN2M2QW9jb2Nh?=
 =?utf-8?B?Y1BUSWs3SHQ1NzZyVkY3alk4VEs4dDI2bXpBN0FwOXEreWo3dTBZUWNzeUd2?=
 =?utf-8?B?a3lSdysraUpTdGUyM0lsRHlBMGlLdnl5K1Y1Ty9BZzBSNUJ0Q2FnQ1JnNjQz?=
 =?utf-8?B?K2xlUTNsZmNydkJweVhoRGRGdnQzS3dxbS9Eb09KQzU1NmZlZlMyUGtiUHhs?=
 =?utf-8?B?YkxzZ3NBR1Q2akdkalhkaVpUQzE5Qk9hVHhTZ2tqbzFGTkVKSngyVWhHYmdG?=
 =?utf-8?B?dTZSb0dkc2RySWhDcFhqV2JaVG9mLzdKenpQWkpoYjhBNkhwK2g5b2trMy92?=
 =?utf-8?B?NGZKLzM3MG8yejMvdm5wVmZjU2o4NzFiRXE1czI0WXF6bUk3cmY0eGh5YUo3?=
 =?utf-8?B?THpLNEo4TWhIV0VLVm0venk1aGY0ZFpnZ1o0ZHdTQThKSTZiNG1YaVVabHd4?=
 =?utf-8?B?QlEwTWR0c1hVMU53NTZxQWMxZU8xaHNVcVFJVXZjbGJBaXB0c29hd3dQcUJZ?=
 =?utf-8?B?bStHUFZqNFFRTVE1RGN5bFltTXVQWWg3S2ZqMm9OQTkzaDFRcTZJbVd5Z0F2?=
 =?utf-8?B?QW15Wk0vUXQzWkJuODFTMTVWcEFhS0lkSnpWMGpETnM0eXhMLzd4RWRhS0VG?=
 =?utf-8?B?Z0FweWx4SDVrNGNSbldoVnoyc2ptcHJDeElZcHhEQzAwZGc3RWRwUlhYRWlj?=
 =?utf-8?B?VGMxTFl2NlNjd3VtZUdISlYyK0xhZ1hTQWFqSUROWjVtOWo3VkJsSWxzaHVH?=
 =?utf-8?B?eWtMZXdLV295UmltYVpxSTQ1U05DN21LUko1RG16MjJVbzNOUjlzMjBIbDJy?=
 =?utf-8?B?aFFyaGlkOWJuaThqNFFSb1RRVFZXSlh5Y1VzdHIxT3I1SGtSUTJWbGxwN0ph?=
 =?utf-8?B?a0JMN3NSVkFSeENTekMxdkdGSkc0bTJ2Z1pBdE1tYUU3eEpiWitYU3U1bFcr?=
 =?utf-8?B?Zzh3dkRvM0RmVGVxREdwVWpXdWFkRHlXYy95amluL2txTGthYVZKQ0JTcHpU?=
 =?utf-8?B?djdvQkRVQXpEVml6VVdwMG4wV3JHSHBsSk0wUEQ1T0M2QWFZYm5PUGhESEM3?=
 =?utf-8?B?N1F3MktwVit4WWlsbzJnUktPNmZaTmZyVXhQeTJMb3Fmb25zbEs5UlAzazZJ?=
 =?utf-8?B?VVpiU2R2RkFGVDgzb0dZQWtMNmZvNFpxeHgxL3dLMkxOd3JFWEZlL2JpcS9P?=
 =?utf-8?B?QU9pWFVqYzU5bFhZUGZISmNsazJidG95ZXRxa0l4b2E5dDBqeVpIV2pQeVNS?=
 =?utf-8?B?Qm5uQmpZYlBSSjVveUlzcnV4Q0ViTlZ0OVpjQjNra3BkeDA2RVlhaE51d01B?=
 =?utf-8?B?S2NzeFJhdUhkeVZZcjZ1b0ZWcmpaOVBWQzdiSlF0Z1lHQSt0YnliWTNLS1RJ?=
 =?utf-8?B?NjR5dVFwVVJ5NW5JbjRuZG1nbmFOaEpMQW40V05yNFVuVzZ2NXNnTUpqNFVK?=
 =?utf-8?B?TFFLTDkxODMvNkd2UHNrYnBvM0tMc3Q1WEk1LytldTB0MXl2TGpPeUpIQUI0?=
 =?utf-8?B?UXdZMmV4bzRubGIwQkRMV0JHM0R4Ukd5T0lWS3JTbEw1dTJIUGladWdHMTQr?=
 =?utf-8?B?dzRLRDJnL01sY1hJa3BvaW9DTXNFcGUzNzNGMmZ4YkVncjIvMm1BTWZ6NlFK?=
 =?utf-8?B?YkJibnQ4RW1URHZLTkZPR0N3UUROZTY5R1lDTXV0c0JlMlV5ajNKNjRNVy8r?=
 =?utf-8?B?c1dVM2MvV09Xd1BZdGd2OVFSOGcrNHlaNWgyVUhCWlJKNzNVV0JZcFh4QzhX?=
 =?utf-8?B?eHc3OUQ3UTUzaVVrRDFSTUVYT3hXbjMraHJ5SVZXeC81Nlp3MmZSVGN6YjNy?=
 =?utf-8?B?eEdKR1dWdUtUaVkrMGNvSVRkeDFmaDNaRlBmRmZMd2FhSjNJNVBYSUJHc01D?=
 =?utf-8?B?RUhXQnY3TkZhTDk2MEFDSmhacjhvNExtWVAvQk9VcEkyQngwWlZ4UGN3dlVi?=
 =?utf-8?B?NXR0RTVGZTh0U2VHY1ZOZlJSK3ZEODR6T1h4M0NpUEJpTjRkOVEyT2dVNXJa?=
 =?utf-8?B?MEdzcnhFQXB6ak5aMTU4b0loM2x2emttaGhTV1VZM1dTclFpdDZQeGRHK2xI?=
 =?utf-8?B?c1VMVDRWdlJRVEFKbEZhdVNveXR0Um8rR09rbm1sTW5YUjhuNzV3UU5kTUhC?=
 =?utf-8?B?VGp0QVFhbEhXTm8xUHJBWElvaVdKZ3FyTFdaMFdVUDgrNmhrTVFhSzlKN3lx?=
 =?utf-8?Q?31AECM2Oa6AeRNCmG9hH39I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7F4C41DBD5F8A4F9588DFFB690DBCF6@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d043e9-e921-4d32-250c-08dc9be2dd1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 04:36:25.4150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HP9tQ2QVY/I7TNJzGZiGsIplbOGtctulFrxisM8w3+XGlbeuOSegC4Ig6mU5Ym0dnVahdDEp4/e1ZMxL3fPMeaA4E9R4W2TEmftdI5se4L9QLE6uEk2nHkR2r7eF7rVy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6494
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

DQpPbiAwMy8wNy8yMDI0IDE0OjMyLCBZaSBMaXUgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywNCj4gdW5sZXNz
IHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNv
bnRlbnQNCj4gaXMgc2FmZS4NCj4NCkhpLCB0aGFua3MgZm9yIHlvdXIgcmV2aWV3ISB2ZXJ5IGVm
ZmljaWVudCENCj4NCj4gSGkgQ01ELA0KPg0KPiBJJ3ZlIHdlbnQgdGhyb3VnaCB0aGUgc2VyaWVz
LiBTb21lIGdlbmVyYWwgc3VnZ2VzdGlvbnMgb24gdGhlIHNlcmllcy4NCj4NCj4gMSkgUGF0Y2gg
MDEsIDAyLCAwNCBjYW4gYmUgc2VudCBzZXBhcmF0ZWx5IGFzIHRoZXkgYXJlIGZpeGVzLg0KV2ls
bCBkbw0KPiAyKSBUaGlzIHNlcmllcyBtaXhlZCB0aGUgQVRTIGFuZCBQQVNJRCBjYXBhYmlsaXR5
IGEgYml0LiBBY3R1YWxseSwNCj4gICAgdGhleSBkb24ndCBoYXZlIGRlcGVuZGVuY3kuIEknZCBz
dWdnZXN0IHlvdSBzcGxpdCB0aGUgc2VyaWVzIGludG8NCj4gICAgICAgLSBzdXBwb3J0IEFUUyBm
b3IgdGhlIHJlcXVlc3RzIHdpdGhvdXQgUEFTSUQNCj4gICAgICAgLSBzdXBwb3J0IEFUUyBmb3Ig
cmVxdWVzdHMgd2l0aCBQQVNJRA0KPiAgICBUaGUgc2Vjb25kIHBhcnQgc2hvdWxkIGJlIGFuIGlu
Y3JlbWVudGFsIGNoYW5nZSBiYXNlZCBvbiB0aGUgZmlyc3QNCj4gICAgcGFydC4gSWYgeW91IGNh
biBtYWtlIHVzZSBvZiB0aGUgZXhpc3RpbmcgdHJhbnNsYXRlKCkgY2FsbGJhY2ssIHRoZW4NCj4g
ICAgaXQgaXMgcG9zc2libGUgdG8gcmVtb3ZlIHRoZSBkZXBlbmRlbmN5IG9uIFpoZW56aG9uZydz
IHN0YWdlLTEgc2VyaWVzLg0KVGhlIGZpbmFsIHB1cnBvc2UgaXMgdG8gc3VwcG9ydCBTVk0sIGNv
bnNlcXVlbnRseSwgd2Ugb25seSBhZGQgc3VwcG9ydA0KZm9yIEFUUyB3aXRoIFBBU0lEIGhlcmUN
Cj4gMykgU29tZSBjb21taXRzIGRvIG5vdCBoYXZlIGNvbW1pdCBtZXNzYWdlLiBJdCB3b3VsZCBi
ZSBnb29kIHRvIGhhdmUNCj4gICAgaXQuDQpPaywgSSB3aWxsIGJlIG1vcmUgdmVyYm9zZSA7KQ0K
PiA0KSBTb21lIGhlbHBlcnMgbG9vayB0byBiZSB1c2VkIGJ5IGRldmljZSBtb2RlbCwgaWYgcG9z
c2libGUsIGl0J3MgYmV0dGVyDQo+ICAgIHRvIHN1Ym1pdCB0aGVtIHdpdGggYSBkZW1vIGRldmlj
ZS4NClRoZSBkZW1vIGRldmljZSBpcyBhbHJlYWR5IGluIG15IEdpdEh1YiByZXBvDQooaHR0cHM6
Ly9naXRodWIuY29tL0J1bGxTZXF1YW5hL3FlbXUvdHJlZS9tYXN0ZXIpDQpJdCB3aWxsIGJlIHNl
bnQgaW4gYSBmdXR1cmUgc2VyaWVzIHRoYXQgYWRkcyB0aGUgbGFzdCBmZWF0dXJlcyByZXF1aXJl
ZA0KZm9yIFNWTSAoc3BsaXR0aW5nIHRoZSBzZXJpZXMgdG8gbWFrZSByZXZpZXdzIGxlc3MgcGFp
bmZ1bCkNCj4gNSkgQSBkZXNpZ24gZGVzY3JpcHRpb24gaW4gdGhlIGNvdmVyLWxldHRlciB3b3Vs
ZCBiZSBoZWxwZnVsLg0KT2ssIEkgd2lsbCBlbGFib3JhdGUNCj4NCj4gT24gMjAyNC83LzIgMTM6
NTIsIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4+IEZyb206IENsZW1lbnQgTWF0aGll
dS0tRHJpZiA8Y21kZXR1QGdtYWlsLmNvbT4NCj4+DQo+PiBUaGlzIHNlcmllcyBiZWxvbmdzIHRv
IGEgbGlzdCBvZiBzZXJpZXMgdGhhdCBhZGQgU1ZNIHN1cHBvcnQgZm9yIFZULWQuDQo+Pg0KPj4g
QXMgYSBzdGFydGluZyBwb2ludCwgd2UgdXNlIHRoZSBzZXJpZXMgY2FsbGVkICdpbnRlbF9pb21t
dTogRW5hYmxlDQo+PiBzdGFnZS0xIHRyYW5zbGF0aW9uJyAocmZjMikgYnkgWmhlbnpob25nIER1
YW4gYW5kIFlpIExpdS4NCj4+DQo+PiBIZXJlIHdlIGZvY3VzIG9uIHRoZSBpbXBsZW1lbnRhdGlv
biBvZiBBVFMgc3VwcG9ydCBpbiB0aGUgSU9NTVUgYW5kDQo+PiBvbiBhIFBDSS1sZXZlbA0KPj4g
QVBJIGZvciBBVFMgdG8gYmUgdXNlZCBieSB2aXJ0dWFsIGRldmljZXMuDQo+Pg0KPj4gVGhpcyB3
b3JrIGlzIGJhc2VkIG9uIHRoZSBWVC1kIHNwZWNpZmljYXRpb24gdmVyc2lvbiA0LjEgKE1hcmNo
IDIwMjMpLg0KPj4gSGVyZSBpcyBhIGxpbmsgdG8gYSBHaXRIdWIgcmVwb3NpdG9yeSB3aGVyZSB5
b3UgY2FuIGZpbmQgdGhlDQo+PiBmb2xsb3dpbmcgZWxlbWVudHMgOg0KPj4gICAgICAtIFFlbXUg
d2l0aCBhbGwgdGhlIHBhdGNoZXMgZm9yIFNWTQ0KPj4gICAgICAgICAgLSBBVFMNCj4+ICAgICAg
ICAgIC0gUFJJDQo+PiAgICAgICAgICAtIERldmljZSBJT1RMQiBpbnZhbGlkYXRpb25zDQo+PiAg
ICAgICAgICAtIFJlcXVlc3RzIHdpdGggYWxyZWFkeSB0cmFuc2xhdGVkIGFkZHJlc3Nlcw0KPj4g
ICAgICAtIEEgZGVtbyBkZXZpY2UNCj4+ICAgICAgLSBBIHNpbXBsZSBkcml2ZXIgZm9yIHRoZSBk
ZW1vIGRldmljZQ0KPj4gICAgICAtIEEgdXNlcnNwYWNlIHByb2dyYW0gKGZvciB0ZXN0aW5nIGFu
ZCBkZW1vbnN0cmF0aW9uIHB1cnBvc2VzKQ0KPj4NCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9CdWxs
U2VxdWFuYS9RZW11LWluLWd1ZXN0LVNWTS1kZW1vDQo+Pg0KPj4NCj4+IHYyDQo+PiAgICAgIC0g
aGFuZGxlIGh1Z2UgcGFnZXMgYmV0dGVyIGJ5IGRldGVjdGluZyB0aGUgcGFnZSB0YWJsZSBsZXZl
bCBhdA0KPj4gd2hpY2ggdGhlIHRyYW5zbGF0aW9uIGVycm9ycyBvY2N1cg0KPj4gICAgICAtIENo
YW5nZXMgYWZ0ZXIgcmV2aWV3IGJ5IFpoZW5aaG9uZyBEdWFuIDoNCj4+ICAgICAgIC0gU2V0IHRo
ZSBhY2Nlc3MgYml0IGFmdGVyIGNoZWNraW5nIHBlcm1pc3Npb25zDQo+PiAgICAgICAtIGhlbHBl
ciBmb3IgUEFTSUQgYW5kIEFUUyA6IG1ha2UgdGhlIGNvbW1pdCBtZXNzYWdlIG1vcmUNCj4+IGFj
Y3VyYXRlICgncHJlc2VudCcgcmVwbGFjZWQgd2l0aCAnZW5hYmxlZCcpDQo+PiAgICAgICAtIHBj
aWVfcGFzaWRfaW5pdDogYWRkIFBDSV9QQVNJRF9DQVBfV0lEVEhfU0hJRlQgYW5kIHVzZSBpdA0K
Pj4gaW5zdGVhZCBvZiBQQ0lfRVhUX0NBUF9QQVNJRF9TSVpFT0YgZm9yIHNoaWZ0aW5nIHRoZSBw
YXNpZCB3aWR0aCB3aGVuDQo+PiBwcmVwYXJpbmcgdGhlIGNhcGFiaWxpdHkgcmVnaXN0ZXINCj4+
ICAgICAgIC0gcGNpOiBkbyBub3QgY2hlY2sgcGNpX2J1c19ieXBhc3NfaW9tbXUgYWZ0ZXIgY2Fs
bGluZw0KPj4gcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuDQo+PiAgICAgICAtIGRvIG5v
dCBhbHRlciBmb3JtYXR0aW5nIG9mIElPTU1VVExCRW50cnkgZGVjbGFyYXRpb24NCj4+ICAgICAg
IC0gdnRkX2lvdmFfZmxfY2hlY2tfY2Fub25pY2FsIDogZGlyZWN0bHkgdXNlIHMtPmF3X2JpdHMg
aW5zdGVhZA0KPj4gb2YgYXcgZm9yIHRoZSBzYWtlIG9mIGNsYXJpdHkNCj4+DQo+PiB2Mw0KPj4g
ICAgICAtIHJlYmFzZSBvbiBuZXcgdmVyc2lvbiBvZiBaaGVuemhvbmcncyBmbHRzIGltcGxlbWVu
dGF0aW9uDQo+PiAgICAgIC0gZml4IHRoZSBhdGMgbG9va3VwIG9wZXJhdGlvbiAoY2hlY2sgdGhl
IG1hc2sgYmVmb3JlIHJldHVybmluZw0KPj4gYW4gZW50cnkpDQo+PiAgICAgIC0gYWRkIGEgdW5p
dCB0ZXN0IGZvciB0aGUgQVRDDQo+PiAgICAgIC0gc3RvcmUgYSB1c2VyIHBvaW50ZXIgaW4gdGhl
IGlvbW11IG5vdGlmaWVycyB0byBzaW1wbGlmeSB0aGUNCj4+IGltcGxlbWVudGF0aW9uIG9mIHN2
bSBkZXZpY2VzDQo+PiAgICAgIENoYW5nZXMgYWZ0ZXIgcmV2aWV3IGJ5IFpoZW56aG9uZyA6DQo+
PiAgICAgICAtIHN0b3JlIHRoZSBpbnB1dCBwYXNpZCBpbnN0ZWFkIG9mIHJpZDJwYXNpZCB3aGVu
IHJldHVybmluZyBhbg0KPj4gZW50cnkgYWZ0ZXIgYSB0cmFuc2xhdGlvbg0KPj4gICAgICAgLSBz
cGxpdCB0aGUgQVRDIGltcGxlbWVudGF0aW9uIGFuZCBpdHMgdW5pdCB0ZXN0cw0KPj4NCj4+IHY0
DQo+PiAgICAgIENoYW5nZXMgYWZ0ZXIgaW50ZXJuYWwgcmV2aWV3DQo+PiAgICAgICAtIEZpeCB0
aGUgbm93cml0ZSBvcHRpbWl6YXRpb24sIGFuIEFUUyB0cmFuc2xhdGlvbiB3aXRob3V0IHRoZQ0K
Pj4gbm93cml0ZSBmbGFnIHNob3VsZCBub3QgZmFpbCB3aGVuIHRoZSB3cml0ZSBwZXJtaXNzaW9u
IGlzIG5vdCBzZXQNCj4NCj4gSXQncyBzdHJhbmdlIHRvIGxpc3QgaW50ZXJuYWwgcmV2aWV3IGhl
cmUuDQo+DQo+PiB2NQ0KPj4gICAgICBDaGFuZ2VzIGFmdGVyIHJldmlldyBieSBQaGlsaXBwZSA6
DQo+PiAgICAgICAtIGNoYW5nZSB0aGUgdHlwZSBvZiAnbGV2ZWwnIHRvIHVuc2lnbmVkIGluIHZ0
ZF9sb29rdXBfaW90bGINCj4NCj4gbGlzdCBjaGFuZ2UgbG9nIGZyb20gbGF0ZXN0IHRvIHRoZSBl
YXJsaWVzdCB3b3VsZCBiZSBuaWNlIHRvby4gTG9vaw0KPiBmb3J3YXJkDQo+IHRvIHlvdXIgbmV4
dCB2ZXJzaW9uLiA6KQ0KPg0KPiBSZWdhcmRzLA0KPiBZaSBMaXUNCj4NCj4+IENsw6ltZW50IE1h
dGhpZXUtLURyaWYgKDIyKToNCj4+ICAgIGludGVsX2lvbW11OiBmaXggRlJDRCBjb25zdHJ1Y3Rp
b24gbWFjcm8uDQo+PiAgICBpbnRlbF9pb21tdTogbWFrZSB0eXBlcyBtYXRjaA0KPj4gICAgaW50
ZWxfaW9tbXU6IHJldHVybiBwYWdlIHdhbGsgbGV2ZWwgZXZlbiB3aGVuIHRoZSB0cmFuc2xhdGlv
biBmYWlscw0KPj4gICAgaW50ZWxfaW9tbXU6IGRvIG5vdCBjb25zaWRlciB3YWl0X2Rlc2MgYXMg
YW4gaW52YWxpZCBkZXNjcmlwdG9yDQo+PiAgICBtZW1vcnk6IGFkZCBwZXJtaXNzaW9ucyBpbiBJ
T01NVUFjY2Vzc0ZsYWdzDQo+PiAgICBwY2llOiBhZGQgaGVscGVyIHRvIGRlY2xhcmUgUEFTSUQg
Y2FwYWJpbGl0eSBmb3IgYSBwY2llIGRldmljZQ0KPj4gICAgcGNpZTogaGVscGVyIGZ1bmN0aW9u
cyB0byBjaGVjayBpZiBQQVNJRCBhbmQgQVRTIGFyZSBlbmFibGVkDQo+PiAgICBpbnRlbF9pb21t
dTogZGVjbGFyZSBzdXBwb3J0ZWQgUEFTSUQgc2l6ZQ0KPj4gICAgcGNpOiBjYWNoZSB0aGUgYnVz
IG1hc3RlcmluZyBzdGF0dXMgaW4gdGhlIGRldmljZQ0KPj4gICAgcGNpOiBhZGQgSU9NTVUgb3Bl
cmF0aW9ucyB0byBnZXQgYWRkcmVzcyBzcGFjZXMgYW5kIG1lbW9yeSByZWdpb25zDQo+PiAgICAg
IHdpdGggUEFTSUQNCj4+ICAgIG1lbW9yeTogc3RvcmUgdXNlciBkYXRhIHBvaW50ZXIgaW4gdGhl
IElPTU1VIG5vdGlmaWVycw0KPj4gICAgcGNpOiBhZGQgYSBwY2ktbGV2ZWwgaW5pdGlhbGl6YXRp
b24gZnVuY3Rpb24gZm9yIGlvbW11IG5vdGlmaWVycw0KPj4gICAgaW50ZWxfaW9tbXU6IGltcGxl
bWVudCB0aGUgZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQgaW9tbXUgb3BlcmF0aW9uDQo+PiAgICBp
bnRlbF9pb21tdTogaW1wbGVtZW50IHRoZSBnZXRfbWVtb3J5X3JlZ2lvbl9wYXNpZCBpb21tdSBv
cGVyYXRpb24NCj4+ICAgIG1lbW9yeTogQWxsb3cgdG8gc3RvcmUgdGhlIFBBU0lEIGluIElPTU1V
VExCRW50cnkNCj4+ICAgIGludGVsX2lvbW11OiBmaWxsIHRoZSBQQVNJRCBmaWVsZCB3aGVuIGNy
ZWF0aW5nIGFuIGluc3RhbmNlIG9mDQo+PiAgICAgIElPTU1VVExCRW50cnkNCj4+ICAgIGF0Yzog
Z2VuZXJpYyBBVEMgdGhhdCBjYW4gYmUgdXNlZCBieSBQQ0llIGRldmljZXMgdGhhdCBzdXBwb3J0
IFNWTQ0KPj4gICAgYXRjOiBhZGQgdW5pdCB0ZXN0cw0KPj4gICAgbWVtb3J5OiBhZGQgYW4gQVBJ
IGZvciBBVFMgc3VwcG9ydA0KPj4gICAgcGNpOiBhZGQgYSBwY2ktbGV2ZWwgQVBJIGZvciBBVFMN
Cj4+ICAgIGludGVsX2lvbW11OiBzZXQgdGhlIGFkZHJlc3MgbWFzayBldmVuIHdoZW4gYSB0cmFu
c2xhdGlvbiBmYWlscw0KPj4gICAgaW50ZWxfaW9tbXU6IGFkZCBzdXBwb3J0IGZvciBBVFMNCj4+
DQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgIHwgMTQ2ICsr
KysrLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggICAgICAgICAgICB8ICAg
NiArLQ0KPj4gICBody9wY2kvcGNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEy
NyArKysrKy0NCj4+ICAgaHcvcGNpL3BjaWUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgNDIgKysNCj4+ICAgaW5jbHVkZS9leGVjL21lbW9yeS5oICAgICAgICAgICAgICAgICAgICAg
fCAgNTEgKystDQo+PiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICAgICAgICAgICAg
IHwgICAyICstDQo+PiAgIGluY2x1ZGUvaHcvcGNpL3BjaS5oICAgICAgICAgICAgICAgICAgICAg
IHwgMTAxICsrKysrDQo+PiAgIGluY2x1ZGUvaHcvcGNpL3BjaV9kZXZpY2UuaCAgICAgICAgICAg
ICAgIHwgICAxICsNCj4+ICAgaW5jbHVkZS9ody9wY2kvcGNpZS5oICAgICAgICAgICAgICAgICAg
ICAgfCAgIDkgKy0NCj4+ICAgaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmggICAgICAgICAgICAg
ICAgfCAgIDMgKw0KPj4gICBpbmNsdWRlL3N0YW5kYXJkLWhlYWRlcnMvbGludXgvcGNpX3JlZ3Mu
aCB8ICAgMSArDQo+PiAgIHN5c3RlbS9tZW1vcnkuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDIwICsNCj4+ICAgdGVzdHMvdW5pdC9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAg
fCAgIDEgKw0KPj4gICB0ZXN0cy91bml0L3Rlc3QtYXRjLmMgICAgICAgICAgICAgICAgICAgICB8
IDUyNyArKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIHV0aWwvYXRjLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgMjExICsrKysrKysrKw0KPj4gICB1dGlsL2F0Yy5oICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDExNyArKysrKw0KPj4gICB1dGlsL21lc29uLmJ1
aWxkICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgIDE3IGZpbGVzIGNoYW5n
ZWQsIDEzMzIgaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0pDQo+PiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0ZXN0cy91bml0L3Rlc3QtYXRjLmMNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHV0
aWwvYXRjLmMNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHV0aWwvYXRjLmgNCj4+DQo+DQo+DQo=

