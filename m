Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3530C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 04:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seoTj-0003wt-4S; Fri, 16 Aug 2024 00:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1seoTh-0003wC-C3
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 00:22:17 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1seoTe-0005Nv-7K
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 00:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1723782134; x=1755318134;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=M9gDB0ju53iFwX8vwHTcPd0lZ1IzObk6eYMcI8hrDBA=;
 b=e5FDAK02cX1wIskiANOGSiNzzZq9EUMMJCyRQ4uTDgNprhPrw0ZD9qS6
 ffX1d8QNl7CoxzBS0+U7HRUkhSSfwC1xU1oQRPfvfEbgqjIWgHZs5NoX2
 cNeiZ0uZtCFYFZxiJJ93uoR9SfaWf1iY9PYqVOk9sshUyqAdIpUbim9ky
 s3AMy6DygtH7FBz//FDwfWh3wlMdqxR8esFJaP5Zw0jFDX5Izvo4YuJZo
 vNZ4TFZQPqLFdXDKt7RpUolwUT4TS/2ACsIUH242TL4f8toqIyDTR1ISn
 mHK5GLXJmn6HSG2rWhRKsW8VFcgjyqtNsQxj8KkxsEh5gY91FDuYzu8rW A==;
X-IronPort-AV: E=Sophos;i="6.10,150,1719871200"; d="scan'208";a="18443451"
X-MGA-submission: =?us-ascii?q?MDHLhLhO890STp6NN5ZtqKTOvDzAllXC7rthFJ?=
 =?us-ascii?q?suSFm8Ws+KVunKYt2N5QHVUFkUJ+jmrITl2bgnE2d+pIoLKW82DdtlvX?=
 =?us-ascii?q?Ncw/Y92HVuIWILoAISMs4PDl0aGHTQwGTZgwwYxnHqA9ZyLc76YzIz8s?=
 =?us-ascii?q?B/JKEfvmMCNpbJZwEKRDO2Aw=3D=3D?=
Received: from mail-vi1eur05lp2169.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.169])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2024 06:22:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChlDKAhtpVYRpVkdQW1H0fLJrf4pQQDnHik2fsVbkkrcF8c7vn7YD7Q8mdFEYo/fsCAkbwPu+iePuE3SLcYb40jpqjpKr6deDSoR/ms+Q5123lGVk0aHYemIhnIBd5zmaeBC8ZRrA5Rgj7GyQw0aWCZ6hF7RLzCpwb0LYvbfOYjLXNmfyda256bT+WJuhSylva8MbgbEDhGWA5o3yPcLpl8v4jgxgbCTFRgCQh7H1HPYjxdYPvLNpCQEPG2MIZxGqUNBoFOLY4VrLHl6N+P/Lj2Kt6scD43XqVt9nyerEVpywkrqxTAcJ6Oj/du0LLeg1E3Ny76BXJdFeXX9b4CdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9gDB0ju53iFwX8vwHTcPd0lZ1IzObk6eYMcI8hrDBA=;
 b=E2pXYjZZqnbVtsyEOyN7sTQBAjkxMVtP1ATFGoKB2h4fKkWXVUcNPjVxC1cG8IZksSzIsrvoZ/d0Ye3sgcEkmJTi7RiWZoFjXylqQnjahHBKRgddrqMYHishk+ThYRPVntgYqo+4/mzXHZkkt2tv3QM0qzeuoYIAJ5qRHYjqjCVAPMI4RjMZddfpx2e6MqdnQe80y5rGnGY00zxWaIHF4uUUCDwiJshncg301RoM1OWDDpWTjFoJ/mg0ngCHl2WsXrYBHcoWBdLOUyhADMzWGonTrCGgyX8uHe9qUlIqsAusJo5ZxtkLOzdopPPycv27M/5h3VESjPtz7VwswvPRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9gDB0ju53iFwX8vwHTcPd0lZ1IzObk6eYMcI8hrDBA=;
 b=ZVCifTltvOaaQePH8tGep1RJ9Cwp0WihdZ/5mITxYaDaubTCM7zVnB00YiJUZgdosCKQx+jRaAbMEnPBFs+eYKII8ee6afCuSj1jwksfC0LPBv4rQUBB6otSuu2PAAOV5oCHZ9karKOtSLwpRH5zispgAF+QOp7uOO/BedwCdRkmFJntSDfuBJ24TZ6HE56BYy0kiRetSwcdlmsQiOO5ruxXpNh/BfgpHxehS1l5z5t/Dt4a5EBDAj7RJIdkviT/AtwUy9ELSNc0qmgK7y5DwoMiKmbiXiFO4MsorNpgoNVUkqiBZh9FZBAT3PIbxlqVwnmIs+r9TLerCQu0vUIUMA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB6681.eurprd07.prod.outlook.com (2603:10a6:102:66::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 04:22:06 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.021; Fri, 16 Aug 2024
 04:22:04 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "chao.p.peng@intel.com" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
Thread-Topic: [PATCH v2 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
Thread-Index: AQHa5wEDqHVcFd5qEEG5hVAqB55VbLImsP4AgAKongA=
Date: Fri, 16 Aug 2024 04:22:04 +0000
Message-ID: <99b53113-ff21-4b8a-a664-0836e85c70e1@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-9-zhenzhong.duan@intel.com>
 <516fa8d2-ac16-4f2f-b7de-e5ac6b6d8663@intel.com>
In-Reply-To: <516fa8d2-ac16-4f2f-b7de-e5ac6b6d8663@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB6681:EE_
x-ms-office365-filtering-correlation-id: 640305bb-558d-4dbb-34a6-08dcbdaafbe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WFlHbVlBeG1IYitQL251SVJ0aHJ5ZSs0ZG1zRVFBK0puMEc3dlJCeHFPd3FL?=
 =?utf-8?B?YmF0ZSszcXRZNnh0Y1RWalg3dWJPb3c2QkVmN3lZU2h5bVRDLzNvQURzdTc5?=
 =?utf-8?B?L0ZzR2hFWmRZaXdpRHZaV2dSaEIyS25rMmtqa1BFbzlhb3VoR2NvY1VCWmpQ?=
 =?utf-8?B?TlpzdUZnZkRmTWZhVWFmTGpGSHZVM3RnRGpFcFI3MisxSVdjMGRWM1lIL1dD?=
 =?utf-8?B?bVBIb3VJTk44b3cyQktjT1ZzYmlCQk9QTFg5dWtoc1hmbXRyVUhLVk91a1ND?=
 =?utf-8?B?Ym0yQVlBcDg5SWlZNFBmWFB0a09Ka0pYdzVFMzk2eFRsVUphRjlvdWUvSHox?=
 =?utf-8?B?NlhSTTNyMCtBb1RzQUlyM2c4akVuV0p1ZC9zRDlBMFdjNm9tbjNQV2FpTzlD?=
 =?utf-8?B?WGNDTUNxQ3JFMHFYYTFpZFhzSFZXNFQ5VGo4KzF0dWV6cTUvZklGQTVod2pm?=
 =?utf-8?B?YlQyUjVQN0hZaURoeVI5c1NvbkdzbTNycU9RRUxadDJSUE9JOGQ4dWp0NTBE?=
 =?utf-8?B?TSt0cVM4MVgrL1Eva1c3NW1CVHRZU2hIQWdQZTRvYS84OFBRZlVpclBqZE1E?=
 =?utf-8?B?aEhsRTkzbUdqTDVmOHJMQ2hnWVh1YUYxcXFNSkV4U01zbzFMa1NPcFBua2dh?=
 =?utf-8?B?bWxIcEtyVkZlWmZ0ckFVQS9aNFdxbFk5WjRyV0JjN3p0MThnV2lLa2ZDcWow?=
 =?utf-8?B?M1BZZDUvZVNaNHdiek5kUkh4d3FBOFcyS2taeXB0Nmk4b1c2d2gwSUFKV2hH?=
 =?utf-8?B?Rllvakk4TGtKWFNUcUtRRjZUV3V1L3BUMXI4bzRORkRwbFNtb3NLU2NhaGxk?=
 =?utf-8?B?Q2VoSjM1SU54ZEtrK0xTc1U4djR1T3Q3VkZWb2FTVGRnSVJDUXY1Zkp0K3No?=
 =?utf-8?B?SmxwRXpHNUpscmQvOURrNHc2dVNyTDk5V1hpM2dwZ0RxbEZwVm1HR3U3eStl?=
 =?utf-8?B?c0lvKzQ0TUhOU3I5YWZJRFFGTDRMNGkrckVUZEdTZzlqZ0JUT3JQWi9xUDVh?=
 =?utf-8?B?ZE9uYWpyM3RoYjAxalAxRVJZNWRJRUNTZ080QnQ2a3ZrWG9FR0xxYld2SWJ6?=
 =?utf-8?B?NUJOS1BEYWhEVHFXOWFXWlFLUEg0UkJiTHdpNnNJQm1KN0VVUFB2WjJ5cFBC?=
 =?utf-8?B?a0FlellUR3NrbEFwRDdtc3BNa215Zng0Zm9qQnk3Z3h0S0VDQ2ZDYWhuOVNp?=
 =?utf-8?B?UnJzRzRDRHdwRWFWVzdOdVVSU3MyTEhZWFpEL2NtcUExZ3Znd3lkeWpmZzRo?=
 =?utf-8?B?TXBwL2c2clNwbSsydkZkRW91cGNHMEhkVnNmVE10MjNvT2d3Q2FOU202dE1U?=
 =?utf-8?B?aFlJeGQ3c29HbWw4Q0drZk81MkdaR2lFd1hoV3FCQlNCNWZLZW5LMTEyVFRj?=
 =?utf-8?B?a2trb0hGblNjbVlRL3hnTGFiQjZtOHZ1MXdzc0xleFNwOGEwSXVBSy9QK1hj?=
 =?utf-8?B?QVNPNGZtT05aejdJQ0g1aVBYY1VHVHBtTUE4WnlPTVlVQ3ZHZnZHdU5ab0Yr?=
 =?utf-8?B?aUdZcGZCb2ZQWnJvWC82VkhUc0RFWm9yOExQWlR6YkZxK25XY0lOeUE5d3k3?=
 =?utf-8?B?MldNMFhPcUlyVUtOblRhZHlEWW5EWkVuK1B1UnZSdFN0QXdqOE92WjA4Y0tk?=
 =?utf-8?B?YkY3WStHUDZIRnd0OHZqM0c2MzdHVHFrRWE0RElQVWtHVVZuRmdMM2ROUkpu?=
 =?utf-8?B?cnYva1BVY3BOdFZDSFZGRmhlLzJ6UE5sTDhibXVvVHJxYndZQ0tZMXFFNVdI?=
 =?utf-8?B?TzlCZTdCWEVxSitmWEl4SDNDcEhmT1JqUlZjVkIxWk4zcnM1YmlRemlmR0xM?=
 =?utf-8?B?RG0vd0Z1VTZBeE9kckdYR05yQjhnVGtTaFhudUpvQ0YzYjBjNzM3YnFRRHFj?=
 =?utf-8?B?WHhiRkhXeFRlVWFaWTdQQldJL1JnemVVN1dDZ3N4RWFURnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE5ENGRYYVZHVEwyZW0vRllCcFRtMXVRU3pyUHRyaVFtUmJsb3V0emh6bms2?=
 =?utf-8?B?Q0ZWTVVWbndieHBnbitUZGZ4eWZtc3ZiWU9YQ0p0cmw2blV3bGxxc1RLUEY2?=
 =?utf-8?B?RG5XNTJuY0RUV1ZqeDZ1SDI5K0JKRCtWcU1lUFhyQVVkTk8rcVVxUVQ3d0c5?=
 =?utf-8?B?ZS91WVRqZlJWVXVLRVFHdi95SU5WTXJ6Mmh3dTB1ZmVMUDI4dzJCVFl4QmNK?=
 =?utf-8?B?ZVJRRTNFSWxKdlZLdk1GY3VUVTh2VXJ3MytZSVcxaitXSHJLZCs5c1FTNy9X?=
 =?utf-8?B?bW9tOUpwbWtnMW1mQzRiWWkyd092ekpHbkpuOVptWEVIQnpTRlBhR0JUbUJq?=
 =?utf-8?B?VERBV3hMQVNXM0lKVE5ablQyZzZ6dngwaGZyZTNOZ3pWb2xIc24vSlQ3ZHdM?=
 =?utf-8?B?UHBvZ2FndXZtcDRtd1VHMi9ybDA5alpXRkE5SnEyTEp5c25USDVmd3pFc05P?=
 =?utf-8?B?N0Jmby84OWt5OEQyN3pTaDJnTjdRSVF1NGpWc2syazZhTkxEU3ZoaFRGY3hH?=
 =?utf-8?B?c3doTlpta3FzK3REK2QrS3EyNzB0RXVmeXZrTTArelhabG81U2pIUmJFUlJF?=
 =?utf-8?B?Q1ZJa2diVWZyNjd6dU9sSXR3aCtRT3lBOXRjYWFvS1VwR1hOVGJyZDVTRjlr?=
 =?utf-8?B?L0V1aDhxSUo1R2FnTllpNy9FVHVkZHptVjZoemxoWW1vSDRQYzg5bUN5OGRo?=
 =?utf-8?B?MzRsTDhwMGZCWWMrdCtPVlVtdTZ5cFdMWFMxaGM3T3kzaHRxcXRZcjA0eGh0?=
 =?utf-8?B?WFZMNGFTZmhqR2hlcUt6VW11dFQwTFA5SkYzeFE2L3ZWYkR4a21OV1VwSDZ2?=
 =?utf-8?B?WXhjVTlFbE00U2RmN0JBTXhEOVd3WmZ4a0dRbTF0YlZZU28wSGV3aHNoMVVW?=
 =?utf-8?B?a3ZOVlFlZEt2TlA1bXpPWENrTStnVmlnMHlHZ0tiV1V4RUVjS01JSUg1R2tB?=
 =?utf-8?B?djFtUy93dDdYLy9vZWxVZlRyUklQeFJJLy9rS2phL2c5Tlp5aEdKS3RIL2Yv?=
 =?utf-8?B?UFZvdWlqMnF4cFJDY2RZWDJtTnp2c0tVNkRocnlqL09ZTEdCaDRDMnJLMWlD?=
 =?utf-8?B?eDF2QnYyNCtac3YzVCtBajR0Szg1bElXMGh2MUZBa21rdlpaWk9nQ2dsN00z?=
 =?utf-8?B?S3ZjYkcyVm04eFJ4ZkRvOHhFd0RkN3g4SkhGV3dlY0JtcHp3L3hEenJqSlV1?=
 =?utf-8?B?RGV0L21RcmlNSFVHeUE3UjlOTFdISzVRUXZsek52R0loY21BemhZK29Hc1JC?=
 =?utf-8?B?OWFrVUM2ZVpkbUg0K0pBQjFkd3NLSiswSVFMRkpNT3VUT25jeHpZY1FlWWFw?=
 =?utf-8?B?QTNKbmNKamhwR0RKTkZrTjhNUkxYWm9DNllXV013SjRiQzJEZS9GMEt0SXlP?=
 =?utf-8?B?S1o0SHhDbFRrTWlrK0w2TjBsZnpoUUxIMkxnNjZhbmVFeWhjclFSeHZWR2lt?=
 =?utf-8?B?SlNiQWdEVE1GRy95ZXliLy9RNHRra1Myc1daNU1QaGlOdTNmWFUrUDBxTDB3?=
 =?utf-8?B?dm5kOXFnVytSd285SEE5ZTE4eXdBL09GalFsZHNQM0NDTzBoUGdpS1NpMVJJ?=
 =?utf-8?B?VkY5cFZYRThkN3I1bHYwWDF1UStCVFNRNW9qaU13SEdVRzB2eURDMEQyOUFj?=
 =?utf-8?B?anBCbkF4RUZuQnN3dzQ5aUVpVGFPMVRzeVpldVJzYWpUbi9TUnlsUUpqZ1hI?=
 =?utf-8?B?RDk2U0ZJUjRNdTd0WkUzYVpFV1RXbHhleEhUK1Uwd3ptQ3NVSllRN3RQTjla?=
 =?utf-8?B?MWExSzJGWXN1cVhPVlducGJtbnBncGYrVlFVTjJidFJKK3FIUEI1L2I4RS9T?=
 =?utf-8?B?cmd6RnhFRFZSQUxNa1JvRnVPQllhbktySUNyTGxrN3E0elQ2WTZGRklEVlV4?=
 =?utf-8?B?USt2UmJROXI1TllGSmNiVlRWWis0OTVhV0dhcFRScFBXZmFkQUQ2emhJbHlL?=
 =?utf-8?B?KzRpT3FUeUFuWTVLalBLWkRZSVlCWXU3NUVjMHlLZW1xVGVjVVBkaE56V3Rs?=
 =?utf-8?B?czlaOHpRTGI3dUVJZnZQcnFFLzZMbndVZDVDWm1aYldBa3hRS0wzQWhmd1l5?=
 =?utf-8?B?MkJIWjZRTEI2OGRpbmpwdnZZZTkzVXVwSHJMR1ZWbHpkdUhOMGszT3BMZ2x3?=
 =?utf-8?B?THBrTkFIRXl5UDR0TTZ6bTYyV3cvK2N0RnRvbEtyakF6MjJOZVU5dE56Nzlo?=
 =?utf-8?Q?vS/PfYStArLOW/tIFtOjUJs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31C327BE45702742A7A48A8C83356D92@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640305bb-558d-4dbb-34a6-08dcbdaafbe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 04:22:04.7409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzNMvQYjtsOmTKriJwhSA5PiGvNhxLjoFBkkUQ4V7Nv+9kd/ARmJ17hbQVkNZNN/0QVeA/hQYX/mso9vS1yTFzo5B8UHeSzjP2CCPTKkFuSRGcI1rIa+BWM49uMqvOfS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6681
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCk9uIDE0LzA4LzIwMjQgMTM6NDUsIFlpIExpdSB3cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJu
YWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCANCj4gdW5s
ZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQgDQo+IGlzIHNhZmUuDQo+DQo+DQo+IE9uIDIwMjQvOC81IDE0OjI3LCBaaGVuemhv
bmcgRHVhbiB3cm90ZToNCj4+IEZyb206IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENsw6ltZW50
IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+
IC0tLQ0KPj4gwqAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHzCoCAzICsrKw0KPj4g
wqAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjQgKysrKysrKysr
KysrKysrKysrKysrKysrDQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIA0KPj4g
Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IDY2ODU4M2FlY2EuLjc3
ODZlZjc2MjQgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgN
Cj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTMyNCw2ICsz
MjQsNyBAQCB0eXBlZGVmIGVudW0gVlRERmF1bHRSZWFzb24gew0KPj4NCj4+IMKgwqDCoMKgwqAg
LyogT3V0cHV0IGFkZHJlc3MgaW4gdGhlIGludGVycnVwdCBhZGRyZXNzIHJhbmdlIGZvciBzY2Fs
YWJsZSANCj4+IG1vZGUgKi8NCj4+IMKgwqDCoMKgwqAgVlREX0ZSX1NNX0lOVEVSUlVQVF9BRERS
ID0gMHg4NywNCj4+ICvCoMKgwqAgVlREX0ZSX0ZTX0JJVF9VUERBVEVfRkFJTEVEID0gMHg5MSwg
LyogU0ZTLjEwICovDQo+PiDCoMKgwqDCoMKgIFZURF9GUl9NQVgswqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLyogR3VhcmQgKi8NCj4+IMKgIH0gVlRERmF1bHRSZWFzb247DQo+Pg0K
Pj4gQEAgLTU0OSw2ICs1NTAsOCBAQCB0eXBlZGVmIHN0cnVjdCBWVERSb290RW50cnkgVlREUm9v
dEVudHJ5Ow0KPj4gwqAgLyogTWFza3MgZm9yIEZpcnN0IExldmVsIFBhZ2luZyBFbnRyeSAqLw0K
Pj4gwqAgI2RlZmluZSBWVERfRkxfUMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDFVTEwNCj4+IMKgICNkZWZpbmUgVlREX0ZMX1JXX01BU0vCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAoMVVMTCA8PCAxKQ0KPj4gKyNkZWZpbmUgVlREX0ZMX0HCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDIwDQo+PiArI2RlZmluZSBWVERfRkxfRMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4NDANCj4+DQo+PiDCoCAvKiBTZWNvbmQg
TGV2ZWwgUGFnZSBUcmFuc2xhdGlvbiBQb2ludGVyKi8NCj4+IMKgICNkZWZpbmUgVlREX1NNX1BB
U0lEX0VOVFJZX1NMUFRQVFLCoMKgwqDCoCAofjB4ZmZmVUxMKQ0KPj4gZGlmZiAtLWdpdCBhL2h3
L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5kZXggNjEy
MWNjYTRjZC4uM2MyY2VlZDI4NCAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtMTgyMiw2ICsxODIyLDcg
QEAgc3RhdGljIGNvbnN0IGJvb2wgdnRkX3F1YWxpZmllZF9mYXVsdHNbXSA9IHsNCj4+IMKgwqDC
oMKgwqAgW1ZURF9GUl9QQVNJRF9UQUJMRV9FTlRSWV9JTlZdID0gdHJ1ZSwNCj4+IMKgwqDCoMKg
wqAgW1ZURF9GUl9TTV9JTlRFUlJVUFRfQUREUl0gPSB0cnVlLA0KPj4gwqDCoMKgwqDCoCBbVlRE
X0ZSX0ZTX05PTl9DQU5PTklDQUxdID0gdHJ1ZSwNCj4+ICvCoMKgwqAgW1ZURF9GUl9GU19CSVRf
VVBEQVRFX0ZBSUxFRF0gPSB0cnVlLA0KPj4gwqDCoMKgwqDCoCBbVlREX0ZSX01BWF0gPSBmYWxz
ZSwNCj4+IMKgIH07DQo+Pg0KPj4gQEAgLTE5MzksNiArMTk0MCwyMCBAQCBzdGF0aWMgYm9vbCAN
Cj4+IHZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nhbm9uaWNhbChJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQ2
NF90IGlvdmEsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCApOw0KPj4gwqAgfQ0KPj4N
Cj4+ICtzdGF0aWMgTWVtVHhSZXN1bHQgdnRkX3NldF9mbGFnX2luX3B0ZShkbWFfYWRkcl90IGJh
c2VfYWRkciwgDQo+PiB1aW50MzJfdCBpbmRleCwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVp
bnQ2NF90IHB0ZSwgdWludDY0X3QgZmxhZykNCj4+ICt7DQo+PiArwqDCoMKgIGlmIChwdGUgJiBm
bGFnKSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE1FTVRYX09LOw0KPj4gK8KgwqDCoCB9
DQo+PiArwqDCoMKgIHB0ZSB8PSBmbGFnOw0KPj4gK8KgwqDCoCBwdGUgPSBjcHVfdG9fbGU2NChw
dGUpOw0KPj4gK8KgwqDCoCByZXR1cm4gZG1hX21lbW9yeV93cml0ZSgmYWRkcmVzc19zcGFjZV9t
ZW1vcnksDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGJhc2VfYWRkciArIGluZGV4ICogc2l6ZW9mKHB0ZSksDQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZwdGUsIHNpemVv
ZihwdGUpLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVEKTsNCj4NCj4gQ2FuIHdlIGVuc3VyZSB0
aGlzIHdyaXRlIGlzIGF0b21pYz8gQS9EIGJpdCBzZXR0aW5nIHNob3VsZCBiZSBhdG9taWMgZnJv
bQ0KPiBndWVzdCBwLm8udi4NCkFzIHdlIG9ubHkgc2V0IG9uZSBiaXQgYXQgYSB0aW1lLCBJIGRv
bid0IHRoaW5rIHdlIGNhbiBmYWNlIGF0b21pY2l0eSBpc3N1ZXMNCj4NCj4+ICt9DQo+PiArDQo+
PiDCoCAvKg0KPj4gwqDCoCAqIEdpdmVuIHRoZSBAaW92YSwgZ2V0IHJlbGV2YW50IEBmbHB0ZXAu
IEBmbHB0ZV9sZXZlbCB3aWxsIGJlIHRoZSANCj4+IGxhc3QgbGV2ZWwNCj4+IMKgwqAgKiBvZiB0
aGUgdHJhbnNsYXRpb24sIGNhbiBiZSB1c2VkIGZvciBkZWNpZGluZyB0aGUgc2l6ZSBvZiBsYXJn
ZSANCj4+IHBhZ2UuDQo+PiBAQCAtMTk5MCw3ICsyMDA1LDE2IEBAIHN0YXRpYyBpbnQgdnRkX2lv
dmFfdG9fZmxwdGUoSW50ZWxJT01NVVN0YXRlIA0KPj4gKnMsIFZURENvbnRleHRFbnRyeSAqY2Us
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLVZURF9GUl9QQUdJTkdfRU5U
UllfUlNWRDsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pg0KPj4gK8KgwqDCoMKgwqDCoMKg
IGlmICh2dGRfc2V0X2ZsYWdfaW5fcHRlKGFkZHIsIG9mZnNldCwgZmxwdGUsIFZURF9GTF9BKSAh
PSANCj4+IE1FTVRYX09LKSB7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLVZU
RF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxFRDsNCj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+PiArDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHZ0ZF9pc19sYXN0X3B0ZShmbHB0ZSwgbGV2ZWwpKSB7
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaXNfd3JpdGUgJiYNCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHZ0ZF9zZXRfZmxhZ19pbl9wdGUoYWRkciwgb2Zmc2V0
LCBmbHB0ZSwgVlREX0ZMX0QpICE9DQo+PiArIE1FTVRYX09LKSkgew0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtVlREX0ZSX0ZTX0JJVF9VUERBVEVf
RkFJTEVEOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKmZscHRlcCA9IGZscHRlOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKmZscHRlX2xldmVsID0gbGV2ZWw7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gMDsNCj4NCj4gLS0gDQo+IFJlZ2FyZHMsDQo+IFlpIExpdQ0K

