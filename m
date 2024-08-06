Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57C5C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 06:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbDnX-0001e0-3x; Tue, 06 Aug 2024 02:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sbDnU-0001HA-4g
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:35:53 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sbDnS-0005O0-05
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1722926150; x=1754462150;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4NMrzkizeVW79EYTvt80xMEvLmOHwqdh5LRg3qNmqZw=;
 b=QWBc5TM89N4ADETr4Kjiukz3nu4IjOCo+SGV2K43e84D5dKkCXkH8UbH
 /W4lz1wth5F7ibuYpJ8h2JIxsuw44bgCKTk0anh1sQZyaUB11Xm7Trrey
 V4Vex/5GydfXt22VDZ+GJoiyiY7b9uPsVcWTljUXVL26JNdrx6x+zx+1Q
 JHvMlx7AxafcjVZkYr12pe90TT1i9oVQmo9wIg4KMG2KsHmsyLXfhCZqg
 26gZeHFRpoaZNvj02EcUmjVO5FUkSwCUOOuWHluGe5PFxpwsyx62LpHVT
 kX1wG4iYDORGZCFGGiVR+gNX3v0eGpNKiHv5T/+ovGOZaic1tKGG38nyE Q==;
X-IronPort-AV: E=Sophos;i="6.09,267,1716242400"; d="scan'208";a="18053188"
X-MGA-submission: =?us-ascii?q?MDHmbsM2x3E0ptklASckGgsNYCxGKqYZQWmwLp?=
 =?us-ascii?q?ima4dmtg8qTKTky9C9Lv1yaLuVCQ10Nm4yP6IvVkd9mqmSB3YFTDR7DW?=
 =?us-ascii?q?A4QRjkaEP2PMabri75y0pp2iq9gdJcQbbANpSBjLyUzB49Ea5DeP4NqR?=
 =?us-ascii?q?2fbgn/Ey3PhISy4yC7JVum+Q=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2024 08:35:47 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKy+6lBEpvVmQH1kqwlYlJmabflraqxur7HYI77hHVWOjdMFzn8R/eWLjDcl/VpFETVklZxHGByom4um1394AvxKjAn/EzPo9A2qf179NIJ01k2JwOnz0gcB2dKqElrkO807pbiLANI6RMOEJ9erSnFxUk3TPOCWhLvO6hiCnk+VAnbTTKzkCE+/toMu1D+Et2i+i8FzJRGvvm3/jdP7/Tpa6oB9wgz1FdkMWQthjjwdyqMIPQ0SwjdkhNCIoH/G84GIvNk0r9WdRDrvDhcorUcEhtzSIzECm9Jh7f/NZ2apwOBgm+DhGuRql0WHx1Gd+KB3d3AwZF/3l9AkI1zTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NMrzkizeVW79EYTvt80xMEvLmOHwqdh5LRg3qNmqZw=;
 b=BkAyYhL/4v/ScqrZBJesDFvsWx2bOYxhNlO6uOxQ7vaxNcBzHHh16YWTgjT6HThwuyLlYjQZTB8+vjma8URaCCimDikY/v2GAmJqMvW4m/95wCoHajPeWFYoP1zFj4vwePqx2udHm4++GbkzeTIeg7j0ii8Z+5vbEjaeQOn7VvGoBNGNdyvFCc7qRneZhIY5cVprOqCNrliJViFxf5flAKioJ3wvdYuJ4AvPwTMIWrSQBvOmBHNkMm5uV02HK2JfpB6XkucNTEoT1COakMkUEd2auDRmnBdHjuiRiXv8eKS3E61nsb8+yjgNXmc++EysYSH2EbCa03BKp5/M/9gjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NMrzkizeVW79EYTvt80xMEvLmOHwqdh5LRg3qNmqZw=;
 b=hqXJYKe/zhlH3JwWNs46ATUruBdioaimNwOmsI86GNc4Q+k6uHWFqRk1VXmMzRQtP/iNlWq2x1vlt0QiRhU2XuMvHxCsnrBBPvaOWxnusng9BiTYlJDmuwDIhK7tqldr3gtArjjBlkJZL61klrZ2rVTzWfRLhVIZYebdzD5qc1b02qANUkNmhS1AIM6kInoYE7Wzdh/0+5Nv/QU/csr++xnlb81Sj/aUZSzM3TKPaGox6Wtx2nHlyo8D1PmE5XqpKohC8hTpphP7598gCtO0zTQjlFb3AururcfxbQmSQFbeLceAneWxMYIj/IwaRLwKQTF+0J1pjJMibuvTFcDFFw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAXPR07MB8000.eurprd07.prod.outlook.com (2603:10a6:102:130::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.10; Tue, 6 Aug
 2024 06:35:45 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 06:35:45 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Index: AQHa5wD3t0aSWs4KZku3dYcmr1ZjXrIZx6uA
Date: Tue, 6 Aug 2024 06:35:45 +0000
Message-ID: <d245008c-ef6e-4a58-bcbc-869aa4901cf4@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-5-zhenzhong.duan@intel.com>
In-Reply-To: <20240805062727.2307552-5-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAXPR07MB8000:EE_
x-ms-office365-filtering-correlation-id: 96fb866a-b943-4230-d0fd-08dcb5e2009f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UWVVNlVoTkRxaDlrdFg3blEvMlBUc1NlK3pMR3JmUU9HRUZ3T001Q3dUVTFq?=
 =?utf-8?B?YzZiVVA5bWlsbWZQdkxjYytIZDAwcmEzNkJNR05tRlRlNnFtNStMMnN4Rkwx?=
 =?utf-8?B?L0orU1YxVEY4T2k4Y3NMdkhudVlBUURPcDVHc05odWEzdmVacGFDbWd6OUY1?=
 =?utf-8?B?S2hmTHltaFprdWV4MDRtTUFtdlZEcUg4SmhMNDAvV0ZlSlhCVU5OK3h5eWFK?=
 =?utf-8?B?aXNrend3eW1tZnM1MHE5TW5nRW1yTUxVMkMwN1NvWjdMZGFIQ0c5NXBPaUpE?=
 =?utf-8?B?aTNzbnU4N1o5UDVld1RBZEE0alo4eG5lQVRMUFFvTzJNazRVZC9IV0tNVjJU?=
 =?utf-8?B?R3dVQWRSbEJGTXJ0RGdwSEhHWW1uY1hTaFoxYkhEMDhXaFhnbTZIWEtuSUNM?=
 =?utf-8?B?aG8rZDJKQUp3dWNqaHFLa2hFRnM4T1FwdUpEMlREOUVsTzZCd1B2RXp2cno0?=
 =?utf-8?B?ZzFMeTA1TDNCQ0dzRE84eWFoSGlHcloyTUQrK1pZaWs4SEJUek4vazJCbk9Z?=
 =?utf-8?B?bjNQa1pBem81YkJoWFpqdHk4ak0vbDBFNkVjNHk2am1rQmdWZ29xRGp6K1pm?=
 =?utf-8?B?aGxKYnhmVnN2czdDdjZFUFlCMDJxY3Znd05WczNUSWdSSmlhemFBR3kzM2xW?=
 =?utf-8?B?N1dSbGwydnZ3V0NpYU5sVGdsQ3BMNzU2RFFCN2d4clJFOXJudjJoN3g4QnIx?=
 =?utf-8?B?WmY3SXp6QmZqbmszWnZpZ3g1YzErcWlYaUNsZUxQelcxQlRDcjNHUnhjZ0tY?=
 =?utf-8?B?SFUvRXUwbVFjeTB4YW1MYTMwNFhsTXJIQTBVYlhoeENadzhEUjUxYXZVcVh5?=
 =?utf-8?B?am1Lb0ZKL1FyMlBXdzhSZUtOc0IraC9FcWcxMlQwaDRyMWhaUVlXWm1ZamhP?=
 =?utf-8?B?NUxoV2tXbXFYRWM2d1d4dDMvMUlRZXBiSm5BT2VPQ0NVOWE5OVEzcXk1VE03?=
 =?utf-8?B?Ym12TkNraVdyTlpJSVl5eFZ5MldTRHhBdXZ0alBxVm1jS09Cd2U1aUtwZGFC?=
 =?utf-8?B?VVBESWplMGZ3bUN3VkxJQ2RpWVJTcjhtUzNqSC9jb0FDWVZ0KzNEeERJQnh5?=
 =?utf-8?B?QjBPeUdHYkg2NkEvUFhCdDc4WkNRUWp4Mnp5RGx0WWMrMzlSa0xIQXZlKzlU?=
 =?utf-8?B?blMrWWtDcHBXZGhLV1pCUjJoeGFzNzVvR1VsT1pCUysvMUVUdExTSWlNMzh3?=
 =?utf-8?B?d01XNGdDcUg1MndMK2loS29tY3ExZmdmYmhIK0pVZVpaZ1l4ZklOUGNBWk0w?=
 =?utf-8?B?VnQ1bml6c0wrNWgrelBRa2RhdHFndjNXNnFBbVRWMDVpZjcrZ25rSDVHckx1?=
 =?utf-8?B?MjFDQXE1YWJCQnVvTlNMemZZeG5xKzdyT1kra1JOUFdZTjQ1bWI1NHJSbnBm?=
 =?utf-8?B?c3Z3dU5XazM1SGdIb01MaE1BcjlidTVlUzFOdnRuK2xBd0J0NlBPUndCRDhv?=
 =?utf-8?B?VXVkQmxFQUNUMmdQY3pXSTdzSXBPTUxZNkx0V0p0K3o2alBKSnNJU01VRGd6?=
 =?utf-8?B?K0xvb1hGMkdRZ1VWOSt4czdPMFdHeW8yeDVQTUFMckhoZC9CNjZ2ckZEYVhW?=
 =?utf-8?B?SCsxVHZqbkxvbkcvUmZHNTdmYnRWTEpuQ2o5M2QveHNWazRUMkNtUUp0NFFj?=
 =?utf-8?B?VTJrOWRLL3JxV3A4TzY3ZTVIa1M1dWhzQ1RnMU5jUXU2NStRQXFCblNmSEtS?=
 =?utf-8?B?UDJyTVdrcTJDbUV5S2JTd3R0azg0NFNJSVdQMkZDdFQrMUFNUVFkN0YxeW5F?=
 =?utf-8?B?TitaeFVaZ1JHL1M2OXpoZFN5YTd1dXR5ZXdJTFAvME0vTEdIa0tDdXd3ajJO?=
 =?utf-8?B?dzdIVDVTbkFQUGU0RWVhR3ZReS9hU2dwNHdTZ2REQjZ3Z0puelNod0liTFdP?=
 =?utf-8?B?ZjVBS3BVNkw5bGlieEljS3FwMTVwcDk3M2toand2MndoRXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2xEZG1HRTQ0cTJMQ2VsbmZ6UGZhOHJiMTk0UHZJYUtxTkxkWUxpUUEzVE5B?=
 =?utf-8?B?eEpWSTFQcXoxSzlwdmVlQVV0cTNsazZEK05naC9sa3dRTDFJREw5T1NlTUhU?=
 =?utf-8?B?UmFrN1lzNG9EUkNDQmRvRU5IT0o5b01lS2E3TVYvTUNWSEIyVXNtSnpBZmpD?=
 =?utf-8?B?VEhNN2w2SFpGcG1ERXdIOEpXaXlvWGdJQ29pZ2F0Smt2SFk2ei9kUHFzRG5B?=
 =?utf-8?B?T1MxeGFUNm9DOGJTS0drUXphZGRwazZJaUVObGd5cWRWa1ZjdEZnUlpSR0tv?=
 =?utf-8?B?Z0l0QU53SjFlbzIvblhseXpvaWdtNUtGWHBORm9GYVg3a1ErbjN0L0REa1oy?=
 =?utf-8?B?b3g0MWRZWEZkMy8yVFk2M3ZEKzlZNzQ3dVdGT2xwalBLVklnOTJJcEdad1p1?=
 =?utf-8?B?YnpxOWdDL21RcGxoUmtlNDlieGV1MGFKQkYrV0xSNE5acmdhSlIxNEVoekdu?=
 =?utf-8?B?aHRGMHYxbkwraGQ0N3hscmtrRzljWFRBUkMvaElOaDJnenBEYmkyczlCVWty?=
 =?utf-8?B?dURXZFhSQW40ZHJhQ210VytnaUIxUTJId2x1QVRzeEJWT20vSlJHaERTZjF0?=
 =?utf-8?B?eWkvQ0tFcWFPbGJVb0VOazUrYWluMWg3dE5vKy94UmVzRERaMTNNVGtmN2cz?=
 =?utf-8?B?WFFOVm9pNkNYc055MTMxTndBb3pIK29BSjRGUERxajFxTGRTcUsvOVl3OWcw?=
 =?utf-8?B?cU5YaW44RjN1a1RickV5Ty9yK2N0Y0k1NWRmeDR6YkRIZmQ2UmRWcXpXSFFZ?=
 =?utf-8?B?eDhHQjhOanU3ZzdzZEk0YTZWUitYTFZGakgxcU1vbjJURWJEK2V5bEF2azF1?=
 =?utf-8?B?OHJMK25LejNHQ3Z4VzRHeDR3MXZyN2ZoQjlVeTZtaERvc2xTSXoyZldnS0pj?=
 =?utf-8?B?bENFR2g5RnJnTXpzcGpkZjJUaXRabWVuMitIVjFGM2Y4WFRnTm9oL3RpbGpS?=
 =?utf-8?B?bXE4bFBPTFEvaWFLelUrYm44SGFHKzY5UmZuZ21mR1B0K3pIZ1RDK1ByaFB0?=
 =?utf-8?B?VjEzUXk0QXBHUXVaeWF4aEZEQ1VTWmhabTdWQkpPeHdGNzdtQXAvRWg0bWV3?=
 =?utf-8?B?bmRVcmE4NWhkV0JibENYSnhzUTBvREVWZlQrdlYxVm9rc2kvZ0p6RWhTQnpm?=
 =?utf-8?B?MXlkYmJ3VGF3UWYzWllLQVlvM2laNEoyWmwwRlZCejZlbURxWC9acEdtMDVP?=
 =?utf-8?B?WVcvZWozRGxmWkxwTkVwdUlDcVEwVEhod01aYk52Z3oveDJsMklRRU9GVzIv?=
 =?utf-8?B?ZHAxeE1VYThGcjZnTktBZmxvenBXTHd3eStja0h0M1dTSEdrVjhETjJ6cmZ5?=
 =?utf-8?B?WVVkY0NSYkpjMHVPK0daMjBOcTF3Wlc4aXFPVVpxeU9UL0wrM1MwWDJaang3?=
 =?utf-8?B?T2VvbWtDK0pvU01jdHo4KzZPeHZsc0MzMyt4V0pIbzBGNCtHenF3cnNZbUIr?=
 =?utf-8?B?ZS9kc0syR1YyUDVFcFhyWHZJYVM1azRra1RQdU14SmV4YW4vWUJvMy9WOU85?=
 =?utf-8?B?WWdpSXd5RlpEYUVRU2xEdzNib3BiUzNMZlZkMGRtTWZmSisxbDVzVm5uVDVT?=
 =?utf-8?B?cUJJV3NBRXV3T1UrSXVTeHpOQS9LUjRKdU00YlkxZkc0b3pYMXNTaVhBd3hK?=
 =?utf-8?B?c2d3b3llRVhsVjYvQUJKM25heWNERzgrdGxCdUNKalc3ZDNjTWFpWDVoUlJi?=
 =?utf-8?B?cWVsL1ZMUkhOQzJrUW40Ykx4MWUrMlJ4ekpXcGV0cXo0anh1OWZ5d1BQOHJL?=
 =?utf-8?B?ZGI0MXh3bnJKV1ByUk1mbDU0dHhGL2lTblZraTBWeE1UV3JPWnhrbndyQmhO?=
 =?utf-8?B?MXprckdHV1VXRUJqaWVtZEVIRG9BUFo3bklxU3YrTU1sS2JYbXd4SGY4bWtZ?=
 =?utf-8?B?TmpKcEsrQ2VkKzViVFdjM0g1WlEzb3c1dUZpbTRjb2k5TUdwVkloT3Q4bk9y?=
 =?utf-8?B?R2JXc2pJb2FTS29NR0tKVkF6SURXWEUyc2wyaDJmbW1HRTR6c0xESEswNXJX?=
 =?utf-8?B?a3VUR0JxR3lzRkZ2TEE0d09tWkMyV1J4QVRCZU50dExRZkgvS01Tc1NqU2lC?=
 =?utf-8?B?Y29xMHBGVzFHcFFxdjVkZStoMjV0WHlQK3JTNFhmc2h5bFRHWUpISWI3a0lk?=
 =?utf-8?B?Z1ZPd3RBOTUwY2EwbkpheTJFd1pucTdhVzUrMGRackd3SmJ0Y2NQWjE5S3o2?=
 =?utf-8?Q?a7pDgXZh4/pBVCUQlWAs1i0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E389026C58728408F91B200257F5BE6@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fb866a-b943-4230-d0fd-08dcb5e2009f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 06:35:45.7189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwLlbEHOlBfPd99tw2ekRzG1hAENcZcPWyCUqwMwNISDG1Wq9osH5UH6jkVBRFJD/REZb3D86oXhXeKYD1aG23d0lrVIbZKvl3gpSNzzA34Y1e5A/T3m5MZnGSoc0v+p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8000
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

DQoNCk9uIDA1LzA4LzIwMjQgMDg6MjcsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiBDYXV0aW9u
OiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3Ms
IHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IFBlciBzcGVjIDYuNS4yLjQsIFBBRElELXNl
bGVjdGl2ZSBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24gd2lsbA0KPiBmbHVzaCBzdGFn
ZS0yIGlvdGxiIGVudHJpZXMgd2l0aCBtYXRjaGluZyBkb21haW4gaWQgYW5kIHBhc2lkLg0KPg0K
PiBXaXRoIHNjYWxhYmxlIG1vZGVybiBtb2RlIGludHJvZHVjZWQsIGd1ZXN0IGNvdWxkIHNlbmQg
UEFTSUQtc2VsZWN0aXZlDQo+IFBBU0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbiB0byBmbHVz
aCBib3RoIHN0YWdlLTEgYW5kIHN0YWdlLTIgZW50cmllcy4NCj4NCj4gQnkgdGhpcyBjaGFuY2Us
IHJlbW92ZSBvbGQgSU9UTEIgcmVsYXRlZCBkZWZpbml0aW9uLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPiAtLS0NCj4gICBo
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAxNCArKystLS0NCj4gICBody9pMzg2L2lu
dGVsX2lvbW11LmMgICAgICAgICAgfCA4MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+IGluZGV4IDhmYTI3YzdmM2IuLjE5ZTRlZDUy
Y2EgMTAwNjQ0DQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiArKysg
Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gQEAgLTQwMiwxMSArNDAyLDYgQEAg
dHlwZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZUREludkRlc2M7DQo+ICAgI2RlZmluZSBWVERfSU5W
X0RFU0NfSU9UTEJfQU0odmFsKSAgICAgICgodmFsKSAmIDB4M2ZVTEwpDQo+ICAgI2RlZmluZSBW
VERfSU5WX0RFU0NfSU9UTEJfUlNWRF9MTyAgICAgIDB4ZmZmZmZmZmYwMDAwZmYwMFVMTA0KPiAg
ICNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1JTVkRfSEkgICAgICAweGY4MFVMTA0KPiAtI2Rl
ZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSURfUEFTSUQgICgyVUxMIDw8IDQpDQo+IC0jZGVm
aW5lIFZURF9JTlZfREVTQ19JT1RMQl9QQVNJRF9QQUdFICAgKDNVTEwgPDwgNCkNCj4gLSNkZWZp
bmUgVlREX0lOVl9ERVNDX0lPVExCX1BBU0lEKHZhbCkgICAoKCh2YWwpID4+IDMyKSAmIFZURF9Q
QVNJRF9JRF9NQVNLKQ0KPiAtI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSURfUlNWRF9M
TyAgICAgIDB4ZmZmMDAwMDAwMDAwMDFjMFVMTA0KPiAtI2RlZmluZSBWVERfSU5WX0RFU0NfSU9U
TEJfUEFTSURfUlNWRF9ISSAgICAgIDB4ZjgwVUxMDQo+DQo+ICAgLyogTWFzayBmb3IgRGV2aWNl
IElPVExCIEludmFsaWRhdGUgRGVzY3JpcHRvciAqLw0KPiAgICNkZWZpbmUgVlREX0lOVl9ERVND
X0RFVklDRV9JT1RMQl9BRERSKHZhbCkgKCh2YWwpICYgMHhmZmZmZmZmZmZmZmZmMDAwVUxMKQ0K
PiBAQCAtNDM4LDYgKzQzMywxNSBAQCB0eXBlZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52RGVz
YzsNCj4gICAgICAgICAgICgweDNmZmZmODAwVUxMIHwgfihWVERfSEFXX01BU0soYXcpIHwgVlRE
X1NMX0lHTl9DT00gfCBWVERfU0xfVE0pKSA6IFwNCj4gICAgICAgICAgICgweDNmZmZmODAwVUxM
IHwgfihWVERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00pKQ0KPg0KPiArLyogTWFza3Mg
Zm9yIFBJT1RMQiBJbnZhbGlkYXRlIERlc2NyaXB0b3IgKi8NCj4gKyNkZWZpbmUgVlREX0lOVl9E
RVNDX1BJT1RMQl9HICAgICAgICAgICAgICgzVUxMIDw8IDQpDQo+ICsjZGVmaW5lIFZURF9JTlZf
REVTQ19QSU9UTEJfQUxMX0lOX1BBU0lEICAoMlVMTCA8PCA0KQ0KPiArI2RlZmluZSBWVERfSU5W
X0RFU0NfUElPVExCX1BTSV9JTl9QQVNJRCAgKDNVTEwgPDwgNCkNCj4gKyNkZWZpbmUgVlREX0lO
Vl9ERVNDX1BJT1RMQl9ESUQodmFsKSAgICAgICgoKHZhbCkgPj4gMTYpICYgVlREX0RPTUFJTl9J
RF9NQVNLKQ0KPiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX1BBU0lEKHZhbCkgICAgKCgo
dmFsKSA+PiAzMikgJiAweGZmZmZmVUxMKQ0KPiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExC
X1JTVkRfVkFMMCAgICAgMHhmZmYwMDAwMDAwMDBmMWMwVUxMDQpXaHkgZGlkIHRoaXMgdmFsdWUg
Y2hhbmdlIHNpbmNlIGxhc3QgcG9zdD8gVGhlICd0eXBlJyBmaWVsZCBzaG91bGQgDQphbHdheXMg
YmUgemVybyBpbiB0aGlzIGRlc2MNCj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZE
X1ZBTDEgICAgIDB4ZjgwVUxMDQo+ICsNCj4gICAvKiBJbmZvcm1hdGlvbiBhYm91dCBwYWdlLXNl
bGVjdGl2ZSBJT1RMQiBpbnZhbGlkYXRlICovDQo+ICAgc3RydWN0IFZURElPVExCUGFnZUludklu
Zm8gew0KPiAgICAgICB1aW50MTZfdCBkb21haW5faWQ7DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2
L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gaW5kZXggYzEzODJhNTY1
MS4uZGY1OTE0MTliNyAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ICsr
KyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBAQCAtMjY1Niw2ICsyNjU2LDgzIEBAIHN0YXRp
YyBib29sIHZ0ZF9wcm9jZXNzX2lvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLCBWVERJbnZE
ZXNjICppbnZfZGVzYykNCj4gICAgICAgcmV0dXJuIHRydWU7DQo+ICAgfQ0KPg0KPiArc3RhdGlj
IGdib29sZWFuIHZ0ZF9oYXNoX3JlbW92ZV9ieV9wYXNpZChncG9pbnRlciBrZXksIGdwb2ludGVy
IHZhbHVlLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBncG9p
bnRlciB1c2VyX2RhdGEpDQo+ICt7DQo+ICsgICAgVlRESU9UTEJFbnRyeSAqZW50cnkgPSAoVlRE
SU9UTEJFbnRyeSAqKXZhbHVlOw0KPiArICAgIFZURElPVExCUGFnZUludkluZm8gKmluZm8gPSAo
VlRESU9UTEJQYWdlSW52SW5mbyAqKXVzZXJfZGF0YTsNCj4gKw0KPiArICAgIHJldHVybiAoKGVu
dHJ5LT5kb21haW5faWQgPT0gaW5mby0+ZG9tYWluX2lkKSAmJg0KPiArICAgICAgICAgICAgKGVu
dHJ5LT5wYXNpZCA9PSBpbmZvLT5wYXNpZCkpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCB2
dGRfcGlvdGxiX3Bhc2lkX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQxNl90IGRvbWFpbl9pZCwgdWlu
dDMyX3QgcGFzaWQpDQo+ICt7DQo+ICsgICAgVlRESU9UTEJQYWdlSW52SW5mbyBpbmZvOw0KPiAr
ICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KPiArICAgIFZURENvbnRleHRFbnRyeSBjZTsN
Cj4gKw0KPiArICAgIGluZm8uZG9tYWluX2lkID0gZG9tYWluX2lkOw0KPiArICAgIGluZm8ucGFz
aWQgPSBwYXNpZDsNCj4gKw0KPiArICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPiArICAgIGdfaGFz
aF90YWJsZV9mb3JlYWNoX3JlbW92ZShzLT5pb3RsYiwgdnRkX2hhc2hfcmVtb3ZlX2J5X3Bhc2lk
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmaW5mbyk7DQo+ICsgICAgdnRk
X2lvbW11X3VubG9jayhzKTsNCj4gKw0KPiArICAgIFFMSVNUX0ZPUkVBQ0godnRkX2FzLCAmcy0+
dnRkX2FzX3dpdGhfbm90aWZpZXJzLCBuZXh0KSB7DQo+ICsgICAgICAgIGlmICghdnRkX2Rldl90
b19jb250ZXh0X2VudHJ5KHMsIHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKSwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnRkX2FzLT5kZXZmbiwgJmNlKSAmJg0KPiAr
ICAgICAgICAgICAgZG9tYWluX2lkID09IHZ0ZF9nZXRfZG9tYWluX2lkKHMsICZjZSwgdnRkX2Fz
LT5wYXNpZCkpIHsNCj4gKyAgICAgICAgICAgIHVpbnQzMl90IHJpZDJwYXNpZCA9IFZURF9DRV9H
RVRfUklEMlBBU0lEKCZjZSk7DQo+ICsNCj4gKyAgICAgICAgICAgIGlmICgodnRkX2FzLT5wYXNp
ZCAhPSBQQ0lfTk9fUEFTSUQgfHwgcGFzaWQgIT0gcmlkMnBhc2lkKSAmJg0KPiArICAgICAgICAg
ICAgICAgIHZ0ZF9hcy0+cGFzaWQgIT0gcGFzaWQpIHsNCj4gKyAgICAgICAgICAgICAgICBjb250
aW51ZTsNCj4gKyAgICAgICAgICAgIH0NCj4gKw0KPiArICAgICAgICAgICAgaWYgKCFzLT5zY2Fs
YWJsZV9tb2Rlcm4pIHsNCj4gKyAgICAgICAgICAgICAgICB2dGRfYWRkcmVzc19zcGFjZV9zeW5j
KHZ0ZF9hcyk7DQo+ICsgICAgICAgICAgICB9DQo+ICsgICAgICAgIH0NCj4gKyAgICB9DQo+ICt9
DQo+ICsNCj4gK3N0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX3Bpb3RsYl9kZXNjKEludGVsSU9NTVVT
dGF0ZSAqcywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZUREludkRl
c2MgKmludl9kZXNjKQ0KPiArew0KPiArICAgIHVpbnQxNl90IGRvbWFpbl9pZDsNCj4gKyAgICB1
aW50MzJfdCBwYXNpZDsNCj4gKw0KPiArICAgIGlmICgoaW52X2Rlc2MtPnZhbFswXSAmIFZURF9J
TlZfREVTQ19QSU9UTEJfUlNWRF9WQUwwKSB8fA0KPiArICAgICAgICAoaW52X2Rlc2MtPnZhbFsx
XSAmIFZURF9JTlZfREVTQ19QSU9UTEJfUlNWRF9WQUwxKSkgew0KPiArICAgICAgICBlcnJvcl9y
ZXBvcnRfb25jZSgiJXM6IGludmFsaWQgcGlvdGxiIGludiBkZXNjIGhpPTB4JSJQUkl4NjQNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgIiBsbz0weCUiUFJJeDY0IiAocmVzZXJ2ZWQgYml0
cyB1bnplcm8pIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGludl9k
ZXNjLT52YWxbMV0sIGludl9kZXNjLT52YWxbMF0pOw0KPiArICAgICAgICByZXR1cm4gZmFsc2U7
DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgZG9tYWluX2lkID0gVlREX0lOVl9ERVNDX1BJT1RMQl9E
SUQoaW52X2Rlc2MtPnZhbFswXSk7DQo+ICsgICAgcGFzaWQgPSBWVERfSU5WX0RFU0NfUElPVExC
X1BBU0lEKGludl9kZXNjLT52YWxbMF0pOw0KPiArICAgIHN3aXRjaCAoaW52X2Rlc2MtPnZhbFsw
XSAmIFZURF9JTlZfREVTQ19QSU9UTEJfRykgew0KPiArICAgIGNhc2UgVlREX0lOVl9ERVNDX1BJ
T1RMQl9BTExfSU5fUEFTSUQ6DQo+ICsgICAgICAgIHZ0ZF9waW90bGJfcGFzaWRfaW52YWxpZGF0
ZShzLCBkb21haW5faWQsIHBhc2lkKTsNCj4gKyAgICAgICAgYnJlYWs7DQo+ICsNCj4gKyAgICBj
YXNlIFZURF9JTlZfREVTQ19QSU9UTEJfUFNJX0lOX1BBU0lEOg0KPiArICAgICAgICBicmVhazsN
Cj4gKw0KPiArICAgIGRlZmF1bHQ6DQo+ICsgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczog
aW52YWxpZCBwaW90bGIgaW52IGRlc2M6IGhpPTB4JSJQUkl4NjQNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgIiwgbG89MHglIlBSSXg2NCIgKHR5cGUgbWlzbWF0Y2g6IDB4JWxseCkiLA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgaW52X2Rlc2MtPnZhbFsxXSwg
aW52X2Rlc2MtPnZhbFswXSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgaW52X2Rlc2Mt
PnZhbFswXSAmIFZURF9JTlZfREVTQ19JT1RMQl9HKTsNCj4gKyAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPiArICAgIH0NCj4gKyAgICByZXR1cm4gdHJ1ZTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBi
b29sIHZ0ZF9wcm9jZXNzX2ludl9pZWNfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZUREludkRlc2MgKmludl9kZXNjKQ0K
PiAgIHsNCj4gQEAgLTI3NzUsNiArMjg1MiwxMCBAQCBzdGF0aWMgYm9vbCB2dGRfcHJvY2Vzc19p
bnZfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMpDQo+ICAgICAgICAgICBicmVhazsNCj4NCj4gICAg
ICAgY2FzZSBWVERfSU5WX0RFU0NfUElPVExCOg0KPiArICAgICAgICB0cmFjZV92dGRfaW52X2Rl
c2MoInAtaW90bGIiLCBpbnZfZGVzYy52YWxbMV0sIGludl9kZXNjLnZhbFswXSk7DQo+ICsgICAg
ICAgIGlmICghdnRkX3Byb2Nlc3NfcGlvdGxiX2Rlc2MocywgJmludl9kZXNjKSkgew0KPiArICAg
ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgICAgICB9DQo+ICAgICAgICAgICBicmVhazsN
Cj4NCj4gICAgICAgY2FzZSBWVERfSU5WX0RFU0NfV0FJVDoNCj4gLS0NCj4gMi4zNC4xDQo+DQo=

