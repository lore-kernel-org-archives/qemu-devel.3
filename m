Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D6AD185C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnpC-0001EA-NG; Thu, 08 Jan 2026 06:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vdnpA-0001Dm-Pv; Thu, 08 Jan 2026 06:05:04 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vdnp8-00010d-Qc; Thu, 08 Jan 2026 06:05:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqFexn3erDG8pLu2tvS6BbplrYHmFOSzERVunkBLJ5ZH6ajifkag2uw4NDkL+7pSV2zEVT83EYyPn1vwRtVzi/3+PLKi5SA2yDuDLc8vckJEV1kjtunSf/bvAua6fOrda2USyugQvURwQLxKshrAav1CXJMV48o/3LM357hH3VCZ0zGl/6u7Dy2ouNQEDVwHNwus89bihYkyB3pwqpaq1GXgcLEYU6yg7GdDtWEoluq2Em4uIbSMACOEK7zp1eaaqZTsNiEWLXUd5siEVgQyFKpfAVmk7Fgj8ZSltz4/oizj74KSRxV8zyxcQetIllZsYgahJdNJB83FasIsG7vMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jv0l9T50bCowZJ1nZFAliu/fLFN8es5z0P3GrFWKI38=;
 b=ybhisAb/r/+UI/0DXUxnbWEr7XFxB/pbm8MB/aslUFcxNsrNfvThT6xKY1vh1+XkAilB+zLXzphQejQMAhjqizp7Z8G9jQ1C48qUlHfAiJNDcJEtLpzdIXUcMa4hBzUjFEqChBmInZU1Kfi+ZKLV46g2KqXM+57imSMC7LgSctG0R6cNJKI0T5XYGDbllW8Q2AWzKgYytg6Y8eQHra+upJbJt4NRXUfDvz1q8B675cT5+fvqvFcDkMkt/5r3e7/1fM9ipDB6CP9WZsW+l+LHTNQWsPufNtPfWjUI3mvb/lGOTs5hsQ4I6zHriwRrfPngg8ZEbk+FpARWySGyElY4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jv0l9T50bCowZJ1nZFAliu/fLFN8es5z0P3GrFWKI38=;
 b=tQ4djX9ve/9eWUKLRWZxE/YOQG58Mpj2oAQBqjFrotEeqr5LCs+NM97W7npv54jkQ6sSftawGcOJ8B8kWeIKGdUi+9eDqxtVwDAk+HWMnAGfjtDXN4vQUk8063yOYYUZfi7P8sXxv2o94lKqctTNQ0i5l6v/wxXPWqajNC7gLWaHKnsaT0+z026gs/d0W+cKg1pquOWI5682I5lGRCOCEYReWwurBZbEtjw7I4hyQ05fpZWVVF5a32Q4O2KiUhOp86OqSSjt1YXgDV7SV04S6lFUGJJwz4Q2vzhgQB1QcDt7VVu0RVOLL1MWIx2I1f1U8PAxFF8EUzfhuqmw8GRx1Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 11:04:55 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 11:04:55 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Topic: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Index: AQHcc0r/PShlE7i9HkafE8JAYPcnrrVIH1QAgAAPWOA=
Date: Thu, 8 Jan 2026 11:04:55 +0000
Message-ID: <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
In-Reply-To: <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB6494:EE_
x-ms-office365-filtering-correlation-id: 15e63ece-cf34-4ebd-b99f-08de4ea5c17d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TXRKakMxUEU0amUrMUUvdlBxYjhsa0dnSHphWkY4cElTVmFiTWRZWWRLaURV?=
 =?utf-8?B?TGhPMDFIUzN0TzVqUmVuYmxNMVNaNHZVazNIWUFaeUpnd0VTdnA2bzF2YWs1?=
 =?utf-8?B?VkJHeW1iNU05YTlLdkkwTzhoY0dEL0JQczljQ0NkZHhMUEQ0YmxvZ0ZHS1Rl?=
 =?utf-8?B?U0Y3ek5xV21IY1IxUHFBdTRINUpyTHY4QTk5MWhqbTBQY0ZpbnpnUGVZN2l1?=
 =?utf-8?B?SHZreW14ckRzVjVvM0dxN2VlRjZ0UkxDZHpTeExFYVFBY3pqZWVuNnQ5cjNo?=
 =?utf-8?B?TTFUYXpuSEgzOUhQNUU0UFBrVUlROGdqaUdrQmo0TERnSEtkekh0dEY4aHJs?=
 =?utf-8?B?a3JkOW5zek5Tck1PM0MvTUxBblRqWXdJcHZxa3NlQmgrejNadkNIN2xmQ0F5?=
 =?utf-8?B?bDRkQng1S3g0T1VIN2s5UDVUZXJyeENpWUFOTnV5Ky8xSmxybHN6STF4S0RN?=
 =?utf-8?B?NTd5NHJWQ0wzYm1XZVp3dXExcWZqQVlPMU1xeExnbEVZSXlSSzFGakYvbWRr?=
 =?utf-8?B?ZC9mMk0rK1lwbzIzWEkvWnhXd2lLT3hKVisydUN3NVVtSFNOTEF2VC8zeklL?=
 =?utf-8?B?L2wrZllWUkpGalJaM0NTYlJrL0tKS0lyUjlRa2Z2QThyWEcyVnFPbDFhTUlz?=
 =?utf-8?B?aHBXek9tZ3U0djhLVy9acGJKb1FHVXkxelhXcUVSTGhKMXB4VDBDaFlrYSth?=
 =?utf-8?B?QW5MNHA1YmxDMUU3N3NLRC9KMGozL1lhckQrZ1JJY05VYmRDOXV0Vit0cGVr?=
 =?utf-8?B?MXRZb3p2Ym5KWk4vMHdwOWRCOFZHc3FwajZUcmxkdEdPaENqd3EzWEtHZ2xr?=
 =?utf-8?B?OE9PbUZSdnZydTRmdmQwa3hYTitWbEw1dDBXU2dmTUwvdXk3eXlETzFnSDlr?=
 =?utf-8?B?SDR3QlNGamF2eUUwWTRhQUFJOXdRT0tlUDNvVkZqZmlqbWpGN1I2Z0pkZitI?=
 =?utf-8?B?Q1hqdXN1QjVWNFNkNEdXRk9UK3NZSnJHTklSSCtubmpoaHgxVFZMZHNyV2pS?=
 =?utf-8?B?TVlSenpjZXEwSllIZlF6VzBtdHhsQzBXMWtTa3lZS25VWVY0Rll6T0Uxd2RW?=
 =?utf-8?B?UnZIeVhUZ0dtUk1vektqZVVGMGxwN1hZMW1GZnJ3T3NMTU9OY29SN29Qb1U1?=
 =?utf-8?B?R2N3MXR1NHA2Mkt3V1BQb1dqNmNkMldYMGVOd1lmaTlaU2t1VDIyTWlzQk14?=
 =?utf-8?B?MGRvVC81dmV5bVR2dEtVTTF5aFBwSm01b3hQS2F0cE1pRGdjZHp1ZzJyQ3pr?=
 =?utf-8?B?bm9vZ29DRnROUUFvRG1EbUVUYTJuWHdaRWk3bm5UcmQ0U0w4NDRoN3prUHlt?=
 =?utf-8?B?TU0yTDRvUmZTM1ZESlV4TWlWNTdrK1VGbUlIcVBRRDFKUDhuYVYrb1liU3J0?=
 =?utf-8?B?TkV4a1drd2FWRWs4QzZlc1piVlROYU9QK2FEY0lVcS94MkNWTzFKUzBoQW1U?=
 =?utf-8?B?WWhmUXJzTTgzMVpDYk9CZjk4UzM3SWVHaFhuM0NPRmMvN0JRS3krL1FGTkV5?=
 =?utf-8?B?UVNsa1piN21ha1lSMkg2YTMrMkdNNExtc3VKaDdMbUV5YjB2T3BraHppaWI1?=
 =?utf-8?B?QzgwZ3puOThsSnBENW1nMkFkTkE0dTUxL2hXbVJNVEdZVnFtQmtUUmJrdGwr?=
 =?utf-8?B?b2lIRjZieVprQmxMNmVXR2tGUHlxSElUaGc0NFVFSUJjbkJ0OEtVcVlBaWJl?=
 =?utf-8?B?OXdsTThWSEsrVjNZNG5wQjFCY3BPZEpEVWZ1TnlRRmFCYk9CSU1HTE1mL0tC?=
 =?utf-8?B?bWFnb3BTKzN6RGlnWXhVMTFTMjhiSUk2VU1vbUJJSXdnSlZSOHB5djluaGJu?=
 =?utf-8?B?UkNFc2JpU3c0SGhNQkhUZ3lKZkxoOU5CckJHODk0bUdzQlFPa2Yxa3lqbnVl?=
 =?utf-8?B?NENDSmpGSThtamVYdy9oUjdJUmpNZThvUFBXbXY5ZE9Ma2VwMHpTZzVYOVFh?=
 =?utf-8?B?Qzd2WEVDRFBxcmJOZThiZkZpbHdpYzR3U0ZHUkNxbno3QkwzNjNJb2hlV1V2?=
 =?utf-8?B?TEdHaExiamVTZlNFR0NTOWgyWVk5KzZ4ZEFScXhrWEhrNDdyTzZ2QVpENVZR?=
 =?utf-8?Q?X25Tto?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3puN1ZtT1lyelU2UTlOdXhRbVFFR0VIcmZuTm9lenZ6cEc4cjJ4WDQrUTlS?=
 =?utf-8?B?WlhlQlEwb1BiV3p0QmR5cXlEdm5HMEJFR2h5d0xndzdYcG4yNGU0Y1BYTEVj?=
 =?utf-8?B?S2xjcWh2ZW5SeGE4Vk1WL25zMElJcW8rTFZtY1ZPcjJ4K0tIMXFvOXZhdytr?=
 =?utf-8?B?cytVcEIwa2JSV0FLQllGUnNNWnhweWRLcGlScTRJL1RHYnhXNTN1eXhiT0Ex?=
 =?utf-8?B?NHQzbjhBdFNuQjluZUxLMnFRZzlNRzV0Z0ExcDUzMzdJVWJUOGZYa3lFcUFa?=
 =?utf-8?B?U1VCZEpQbzAwMVJGRDBLZ2hWQjVFcUhUZTFhQ1ptSEl1ODNFRWhLa1lwQUZq?=
 =?utf-8?B?S1M2eFpDa2NKRFgvK3ZiOHVWT2h3T3p5RVlCaXJ5dVc4ZFliQnhCZGNXakhs?=
 =?utf-8?B?S2hzREFWY3pCYVQvNEdjRXk0UHh4TUFqcGYwYk56QUlqUzJ4b2Z2akIvTXZj?=
 =?utf-8?B?T2dIWnFYNHhJR1hzdSsrSUR1NmVzSDQrMXhuNTRneGhPZUtoRTJORzkvYUZH?=
 =?utf-8?B?VllpZDNoa3ZmRW9vbVczTHo3UVBpanhRRGJ4SVBlcXJqMFE4RXdic2VycjJ5?=
 =?utf-8?B?S3FUOFU5SlFYTVFhS0w4WDhUamFxalNkRlVFNE5TSjlZVXlCc2RaVVR6Z1NL?=
 =?utf-8?B?YTVTMytKdUtMVCtKeXh4dll5c3YvRTU3R3pjbXU4TGJ2ZEluUUZvTGl1YmpL?=
 =?utf-8?B?WE5KKyswcm4zYkNZcktFM1pYb2FrQ0dNdmpLd3VHNHNDR3B4NjhJVGt6RmNo?=
 =?utf-8?B?UkUyL2NJOGJVSVFKSTUzbWRhd1g3ZmluUTV2bzlIQzN3NjM4dGlGcEFXM0la?=
 =?utf-8?B?ZXJEcDRSQWJZNVdOQVRPa1ZUMFNrMGI2TERtUkNFT2dCN2ZsMExrVlJNVVhW?=
 =?utf-8?B?Zm1yR0xCdXljaHNwVTlmN3R2OHk2R1pteENJK1FXY0xDZnkvMW9kOUtobEsy?=
 =?utf-8?B?M0N6WVgxUEVwaHd6MmtjVTNsSHNqbUZtYnFlbHNsOHZkaHhUYnZ4NGxEZXY0?=
 =?utf-8?B?ZTdXdnpHZmFhSk51SkowbndxaVhIdW5sUC9CaWZyVDNkSU40dklWK2lHUk95?=
 =?utf-8?B?eU1jUTRhS3JyckhuejlLWG50bWFBZWZhaGpvVThudXRrMW1BQUFmL2FtTzdX?=
 =?utf-8?B?U3R0c0QzbVJxTlR6Zll6YVVrbEVsS3ZNSnFzQVp6L1M1NCs4bUdNWDN4U1FO?=
 =?utf-8?B?cU9XM0ptcDBHVVQ5QUZONW5LVDZmVUlBYWhHYWw4Nkw3VjNnRXN3Y01HcjhI?=
 =?utf-8?B?UExSNVgwNFBRVFk2Y2FlQmJjYUJndmhZVnV4SnJpUzZBTEs5YUhxSk9waWx6?=
 =?utf-8?B?UGN0U1czcHJCdFZwaGs0K0d6eWYrS1RDZkdldGE4WmthOG9Qa1E0RHpsVVpL?=
 =?utf-8?B?YlFrUWY5U3lrNEx1U3FQR0VxdjYwVXMveDJZVVFnYVF4TFdHM096L0xRMDFC?=
 =?utf-8?B?SWRucWRYSnUrbGwwdVZSUXQrNzRPbjNTY08yMXB4NmhrUGVCQjdKeFpYeDVD?=
 =?utf-8?B?TFgybEpNODYxdTBGOHR2THRUY1hZWjBmOU1pYW51T0V4U2M3endRM1dQQzB1?=
 =?utf-8?B?YUpaM0xiRTBiTnFiRXlWQmJmNjQ0YldtSi85Z1NwUGRVT3R0TmttZkwycUs1?=
 =?utf-8?B?WkozZ2p5Mk9naDd6U21aMmpGb3BEQ2hVUmNCOVNiYmdVSzArYVN6VGNITlVq?=
 =?utf-8?B?cVQ3WFRyRjh3bXBtU0xQMjZNcXd2cTZHYWkzZjdxSFRaeFJVczNCUWkzQWVz?=
 =?utf-8?B?V21qTEJCYStsTFZoVGQ5czEzQ2dqYzJVd1F0YUNXcWVLNy8ycEFGRTh6NVU3?=
 =?utf-8?B?Tko4VjVtRThuT3lJZnBMUTVHMmpzYmtRRHVmamdHbXdIYlROOGpaK05UdUVR?=
 =?utf-8?B?dGp0c05SL2krN3VYdkxPYmZTUXNteVNkZzl5L3VwSFkrSXEzcmJBZEtTM3dK?=
 =?utf-8?B?a1piVlFSSS9LdkhtbXlwMk44a3BHaks3OU4yWmtPRDFwcmpJbVozbmlWbEds?=
 =?utf-8?B?bTM3OXVpNXc4a2hEbU1pcE5oMmJIZXhHNG9jcVViMzN5WWs3am9aOTFraEY2?=
 =?utf-8?B?Y3FieU5WL1B5Y0M5bk4wTTFLM1JWODdWRGY3MzNiK2s4MlA0aFpEUTMwbUkx?=
 =?utf-8?B?Vzgyc1gzaTJIUTRpVTNiTnVMR0cvR1d4R2ZyU1l2RFkyN0k5ZUFKSU5GOURu?=
 =?utf-8?B?d3Z3UUJ3ZkFHZjJqYjBFMk1kYzZQQ29VRUZ3SzcyTnZtTTBOUmZwdWF5WUdO?=
 =?utf-8?B?aVNZUUJhTnB6RTFwR2RoSVNwQnd5TEx6a2xGNEM4VGdmMDV5UGZSMlc0ZGNE?=
 =?utf-8?B?UVI0V3JuU0tEYVpzd0xOUlZEdTNZaXN3empDYUR4UzVRdDJGT05kdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e63ece-cf34-4ebd-b99f-08de4ea5c17d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 11:04:55.5383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58cJjP263nc3tQTMQKlTUzWH12B0RJSztSKRvBsUMyvf9RkddfkRHi3CiQPp/LERRuFfobNXloVMbK8j5PR5Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRHVhbiwgWmhlbnpob25n
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IFNlbnQ6IDA4IEphbnVhcnkgMjAyNiAwOTo0
MQ0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11
LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBlcmljLmF1
Z2VyQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IGNsZ0ByZWRoYXQuY29tOw0KPiBjb2h1
Y2tAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZp
ZGlhLmNvbT47DQo+IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMg
PG1vY2hzQG52aWRpYS5jb20+Ow0KPiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsg
S3Jpc2huYWthbnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAzLzNdIGh3L3ZmaW8vcmVnaW9uOiBDcmVhdGUgZG1hYnVmIGZvciBQQ0kgQkFSIHBlcg0KPiBy
ZWdpb24NCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9y
IGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gMTIvMjIvMjAyNSA5OjUzIFBNLCBTaGFtZWVyIEtv
bG90aHVtIHdyb3RlOg0KPiA+IEZyb206IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNv
bT4NCj4gPg0KPiA+IExpbnV4IG5vdyBwcm92aWRlcyBhIFZGSU8gZG1hYnVmIGV4cG9ydGVyIHRv
IGV4cG9zZSBQQ0kgQkFSIG1lbW9yeSBmb3INCj4gPiBQMlAgdXNlIGNhc2VzLiBDcmVhdGUgYSBk
bWFidWYgZm9yIGVhY2ggbWFwcGVkIEJBUiByZWdpb24gYWZ0ZXIgdGhlDQo+ID4gbW1hcCBpcyBz
ZXQgdXAsIGFuZCBzdG9yZSB0aGUgcmV0dXJuZWQgZmQgaW4gdGhlIHJlZ2lvbuKAmXMgUkFNQmxv
Y2suDQo+ID4gVGhpcyBhbGxvd3MgUUVNVSB0byBwYXNzIHRoZSBmZCB0byBkbWFfbWFwX2ZpbGUo
KSwgZW5hYmxpbmcgaW9tbXVmZCB0bw0KPiA+IGltcG9ydCB0aGUgZG1hYnVmIGFuZCBtYXAgdGhl
IEJBUiBjb3JyZWN0bHkgaW4gdGhlIGhvc3QgSU9NTVUgcGFnZQ0KPiB0YWJsZS4NCj4gPg0KPiA+
IElmIHRoZSBrZXJuZWwgbGFja3Mgc3VwcG9ydCBvciBkbWFidWYgc2V0dXAgZmFpbHMsIFFFTVUg
c2tpcHMgdGhlDQo+ID4gc2V0dXAgYW5kIGNvbnRpbnVlcyB3aXRoIG5vcm1hbCBtbWFwIGhhbmRs
aW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0Budmlk
aWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRo
b0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvdmZpby9yZWdpb24uYyAgICAgfCA1Nw0K
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAgaHcv
dmZpby90cmFjZS1ldmVudHMgfCAgMSArDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDU3IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody92ZmlvL3Jl
Z2lvbi5jIGIvaHcvdmZpby9yZWdpb24uYyBpbmRleA0KPiA+IGIxNjVhYjBiOTMuLjY5NDlmNjc3
OWMgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdmZpby9yZWdpb24uYw0KPiA+ICsrKyBiL2h3L3ZmaW8v
cmVnaW9uLmMNCj4gPiBAQCAtMjksNiArMjksNyBAQA0KPiA+ICAgI2luY2x1ZGUgInFlbXUvZXJy
b3ItcmVwb3J0LmgiDQo+ID4gICAjaW5jbHVkZSAicWVtdS91bml0cy5oIg0KPiA+ICAgI2luY2x1
ZGUgIm1vbml0b3IvbW9uaXRvci5oIg0KPiA+ICsjaW5jbHVkZSAic3lzdGVtL3JhbWJsb2NrLmgi
DQo+ID4gICAjaW5jbHVkZSAidmZpby1oZWxwZXJzLmgiDQo+ID4NCj4gPiAgIC8qDQo+ID4gQEAg
LTIzOCwxMyArMjM5LDUyIEBAIHN0YXRpYyB2b2lkIHZmaW9fc3VicmVnaW9uX3VubWFwKFZGSU9S
ZWdpb24NCj4gKnJlZ2lvbiwgaW50IGluZGV4KQ0KPiA+ICAgICAgIHJlZ2lvbi0+bW1hcHNbaW5k
ZXhdLm1tYXAgPSBOVUxMOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgdmZpb19yZWdp
b25fY3JlYXRlX2RtYV9idWYoVkZJT1JlZ2lvbiAqcmVnaW9uKSB7DQo+ID4gKyAgICBnX2F1dG9m
cmVlIHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJlICpmZWF0dXJlID0gTlVMTDsNCj4gPiArICAg
IFZGSU9EZXZpY2UgKnZiYXNlZGV2ID0gcmVnaW9uLT52YmFzZWRldjsNCj4gPiArICAgIHN0cnVj
dCB2ZmlvX2RldmljZV9mZWF0dXJlX2RtYV9idWYgKmRtYV9idWY7DQo+ID4gKyAgICBzaXplX3Qg
dG90YWxfc2l6ZTsNCj4gPiArICAgIGludCBpLCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgZ19hc3Nl
cnQocmVnaW9uLT5ucl9tbWFwcyk7DQo+ID4gKw0KPiA+ICsgICAgdG90YWxfc2l6ZSA9IHNpemVv
ZigqZmVhdHVyZSkgKyBzaXplb2YoKmRtYV9idWYpICsNCj4gPiArICAgICAgICAgICAgICAgICBz
aXplb2Yoc3RydWN0IHZmaW9fcmVnaW9uX2RtYV9yYW5nZSkgKiByZWdpb24tPm5yX21tYXBzOw0K
PiA+ICsgICAgZmVhdHVyZSA9IGdfbWFsbG9jMCh0b3RhbF9zaXplKTsNCj4gPiArICAgICpmZWF0
dXJlID0gKHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJlKSB7DQo+ID4gKyAgICAgICAgLmFyZ3N6
ID0gdG90YWxfc2l6ZSwNCj4gPiArICAgICAgICAuZmxhZ3MgPSBWRklPX0RFVklDRV9GRUFUVVJF
X0dFVCB8DQo+IFZGSU9fREVWSUNFX0ZFQVRVUkVfRE1BX0JVRiwNCj4gPiArICAgIH07DQo+ID4g
Kw0KPiA+ICsgICAgZG1hX2J1ZiA9ICh2b2lkICopZmVhdHVyZS0+ZGF0YTsNCj4gPiArICAgICpk
bWFfYnVmID0gKHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJlX2RtYV9idWYpIHsNCj4gPiArICAg
ICAgICAucmVnaW9uX2luZGV4ID0gcmVnaW9uLT5uciwNCj4gPiArICAgICAgICAub3Blbl9mbGFn
cyA9IE9fUkRXUiwNCj4gPiArICAgICAgICAubnJfcmFuZ2VzID0gcmVnaW9uLT5ucl9tbWFwcywN
Cj4gPiArICAgIH07DQo+ID4gKw0KPiA+ICsgICAgZm9yIChpID0gMDsgaSA8IHJlZ2lvbi0+bnJf
bW1hcHM7IGkrKykgew0KPiA+ICsgICAgICAgIGRtYV9idWYtPmRtYV9yYW5nZXNbaV0ub2Zmc2V0
ID0gcmVnaW9uLT5tbWFwc1tpXS5vZmZzZXQ7DQo+ID4gKyAgICAgICAgZG1hX2J1Zi0+ZG1hX3Jh
bmdlc1tpXS5sZW5ndGggPSByZWdpb24tPm1tYXBzW2ldLnNpemU7DQo+ID4gKyAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgcmV0ID0gdmJhc2VkZXYtPmlvX29wcy0+ZGV2aWNlX2ZlYXR1cmUodmJhc2Vk
ZXYsIGZlYXR1cmUpOw0KPiANCj4gdmJhc2VkZXYtPmlvX29wcy0+ZGV2aWNlX2ZlYXR1cmUgbWF5
IGJlIE5VTEwgZm9yIG90aGVyIGJhY2tlbmQgbGlrZSB2ZmlvLQ0KPiB1c2VyLg0KDQpBaC4uT2su
IEkgd2lsbCBhZGQgYSBjaGVjay4NCg0KPiANCj4gPiArICAgIGZvciAoaSA9IDA7IGkgPCByZWdp
b24tPm5yX21tYXBzOyBpKyspIHsNCj4gPiArICAgICAgICB0cmFjZV92ZmlvX3JlZ2lvbl9kbWFi
dWYocmVnaW9uLT52YmFzZWRldi0+bmFtZSwgcmV0LCByZWdpb24tPm5yLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICByZWdpb24tPm1lbS0+bmFtZSwgcmVnaW9uLT5tbWFw
c1tpXS5vZmZzZXQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ2lv
bi0+bW1hcHNbaV0uc2l6ZSk7DQo+ID4gKyAgICB9DQo+ID4gKyAgICByZXR1cm4gcmV0Ow0KPiA+
ICt9DQo+ID4gKw0KPiA+ICAgaW50IHZmaW9fcmVnaW9uX21tYXAoVkZJT1JlZ2lvbiAqcmVnaW9u
KQ0KPiA+ICAgew0KPiA+ICAgICAgIGludCBpLCByZXQsIHByb3QgPSAwOw0KPiA+ICAgICAgIGNo
YXIgKm5hbWU7DQo+ID4gICAgICAgaW50IGZkOw0KPiA+DQo+ID4gLSAgICBpZiAoIXJlZ2lvbi0+
bWVtKSB7DQo+ID4gKyAgICBpZiAoIXJlZ2lvbi0+bWVtIHx8ICFyZWdpb24tPm5yX21tYXBzKSB7
DQo+IA0KPiBKdXN0IGN1cmlvdXMsIHdoZW4gd2lsbCBhYm92ZSBjaGVjayByZXR1cm4gdHJ1ZT8N
CkkgdGhpbmsgYCFyZWdpb24tPm1lbWAgY292ZXJzIGNhc2VzIHdoZXJlIG5vIE1lbW9yeVJlZ2lv
biB3YXMgY3JlYXRlZA0KKGUuZy4gemVybyBzaXplZCByZWdpb25zKS4gIEFuZCBucl9tbWFwcyBj
aGVja3MgcmVnaW9ucyB3aXRoIG1tYXANCnN1cHBvcnQgZXhpc3RzIChWRklPX1JFR0lPTl9JTkZP
X0ZMQUdfTU1BUC8gX0NBUF9TUEFSU0VfTU1BUCkuDQoNCj4gDQo+ID4gICAgICAgICAgIHJldHVy
biAwOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+IEBAIC0zMDUsNiArMzQ1LDIxIEBAIGludCB2Zmlv
X3JlZ2lvbl9tbWFwKFZGSU9SZWdpb24gKnJlZ2lvbikNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZWdpb24tPm1tYXBzW2ldLnNpemUgLSAxKTsNCj4gPiAgICAgICB9DQo+
ID4NCj4gPiArICAgIHJldCA9IHZmaW9fcmVnaW9uX2NyZWF0ZV9kbWFfYnVmKHJlZ2lvbik7DQo+
ID4gKyAgICBpZiAocmV0IDwgMCkgew0KPiA+ICsgICAgICAgIGlmIChyZXQgPT0gLUVOT1RUWSkg
ew0KPiA+ICsgICAgICAgICAgICB3YXJuX3JlcG9ydF9vbmNlKCJWRklPIGRtYWJ1ZiBub3Qgc3Vw
cG9ydGVkIGluIGtlcm5lbCIpOw0KPiA+ICsgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAg
ICAgIGVycm9yX3JlcG9ydCgiJXM6IGZhaWxlZCB0byBjcmVhdGUgZG1hYnVmOiAlcyIsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICBtZW1vcnlfcmVnaW9uX25hbWUocmVnaW9uLT5tZW0p
LCBzdHJlcnJvcihlcnJubykpOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0gZWxzZSB7DQo+
ID4gKyAgICAgICAgTWVtb3J5UmVnaW9uICptciA9ICZyZWdpb24tPm1tYXBzWzBdLm1lbTsNCj4g
DQo+IERvIHdlIG5lZWQgdG8gc3VwcG9ydCByZWdpb24tPm1tYXBzWzFdPw0KDQpNeSB1bmRlcnN0
YW5kaW5nIGlzIGFsbCByZWdpb24tPm1tYXBzW10gZW50cmllcyBmb3IgYSBWRklPIHJlZ2lvbiBz
aGFyZQ0KdGhlIHNhbWUgUkFNQmxvY2suIEFuZCB0aGUga2VybmVsIHJldHVybnMgYSBzaW5nbGUg
ZG1hYnVmIGZkIHBlciByZWdpb24sDQpub3QgcGVyIHN1YnJhbmdlLg0KDQpUaGFua3MsDQpTaGFt
ZWVyDQo+IA0KPiBUaGFua3MNCj4gDQo+IFpoZW56aG9uZw0KPiANCj4gPiArICAgICAgICBSQU1C
bG9jayAqcmFtX2Jsb2NrID0gbXItPnJhbV9ibG9jazsNCj4gPiArDQo+ID4gKyAgICAgICAgcmFt
X2Jsb2NrLT5mZCA9IHJldDsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gICAgICAgcmV0dXJuIDA7
DQo+ID4NCj4gPiAgIG5vX21tYXA6DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vdHJhY2UtZXZl
bnRzIGIvaHcvdmZpby90cmFjZS1ldmVudHMgaW5kZXgNCj4gPiAxZTg5NTQ0OGNkLi41OTJhMDM0
OWQ0IDEwMDY0NA0KPiA+IC0tLSBhL2h3L3ZmaW8vdHJhY2UtZXZlbnRzDQo+ID4gKysrIGIvaHcv
dmZpby90cmFjZS1ldmVudHMNCj4gPiBAQCAtMTE3LDYgKzExNyw3IEBAIHZmaW9fZGV2aWNlX3B1
dChpbnQgZmQpICJjbG9zZSB2ZGV2LT5mZD0lZCINCj4gPiAgIHZmaW9fcmVnaW9uX3dyaXRlKGNv
bnN0IGNoYXIgKm5hbWUsIGludCBpbmRleCwgdWludDY0X3QgYWRkciwgdWludDY0X3QNCj4gZGF0
YSwgdW5zaWduZWQgc2l6ZSkgIiAoJXM6cmVnaW9uJWQrMHglIlBSSXg2NCIsIDB4JSJQUkl4NjQg
IiwgJWQpIg0KPiA+ICAgdmZpb19yZWdpb25fcmVhZChjaGFyICpuYW1lLCBpbnQgaW5kZXgsIHVp
bnQ2NF90IGFkZHIsIHVuc2lnbmVkIHNpemUsDQo+IHVpbnQ2NF90IGRhdGEpICIgKCVzOnJlZ2lv
biVkKzB4JSJQUkl4NjQiLCAlZCkgPSAweCUiUFJJeDY0DQo+ID4gICB2ZmlvX3JlZ2lvbl9zZXR1
cChjb25zdCBjaGFyICpkZXYsIGludCBpbmRleCwgY29uc3QgY2hhciAqbmFtZSwgdW5zaWduZWQN
Cj4gbG9uZyBmbGFncywgdW5zaWduZWQgbG9uZyBvZmZzZXQsIHVuc2lnbmVkIGxvbmcgc2l6ZSkg
IkRldmljZSAlcywgcmVnaW9uICVkDQo+IFwiJXNcIiwgZmxhZ3M6IDB4JWx4LCBvZmZzZXQ6IDB4
JWx4LCBzaXplOiAweCVseCINCj4gPiArdmZpb19yZWdpb25fZG1hYnVmKGNvbnN0IGNoYXIgKmRl
diwgaW50IGZkLCBpbnQgaW5kZXgsICBjb25zdCBjaGFyICpuYW1lLA0KPiB1bnNpZ25lZCBsb25n
IG9mZnNldCwgdW5zaWduZWQgbG9uZyBzaXplKSAiRGV2aWNlICVzLCBkbWFidWYgZmQgJWQgcmVn
aW9uICVkDQo+IFwiJXNcIiwgb2Zmc2V0OiAweCVseCwgc2l6ZTogMHglbHgiDQo+ID4gICB2Zmlv
X3JlZ2lvbl9tbWFwX2ZhdWx0KGNvbnN0IGNoYXIgKm5hbWUsIGludCBpbmRleCwgdW5zaWduZWQg
bG9uZyBvZmZzZXQsDQo+IHVuc2lnbmVkIGxvbmcgc2l6ZSwgaW50IGZhdWx0KSAiUmVnaW9uICVz
IG1tYXBzWyVkXSwgWzB4JWx4IC0gMHglbHhdLCBmYXVsdDoNCj4gJWQiDQo+ID4gICB2ZmlvX3Jl
Z2lvbl9tbWFwKGNvbnN0IGNoYXIgKm5hbWUsIHVuc2lnbmVkIGxvbmcgb2Zmc2V0LCB1bnNpZ25l
ZCBsb25nDQo+IGVuZCkgIlJlZ2lvbiAlcyBbMHglbHggLSAweCVseF0iDQo+ID4gICB2ZmlvX3Jl
Z2lvbl9leGl0KGNvbnN0IGNoYXIgKm5hbWUsIGludCBpbmRleCkgIkRldmljZSAlcywgcmVnaW9u
ICVkIg0K

