Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6194CD6EBE5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvff-0007zB-Ci; Fri, 29 Nov 2024 02:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfS-0007xC-8y
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:43:58 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfP-0002fk-GM
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866235; x=1764402235;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=n8O98KShNuvgHQbN+mh2dS/8MP0Nk7wBFRcwtlVqYDg=;
 b=OcD8DvMoiwsczfgJ4TtCeF8d0c30s2Fvw9A9RKoRbG2L4B4KMoMsFReW
 DfQDiqQho2YeLZCksqjkPjtE6li3IpqYKfhLeYVjsz04UHDWVbUPzFqwz
 tbXJUkRP2vgd5Qv4CxoR254WehImpb8P4EIo+hhya0Jk+mze0mzKJvrkt
 B3ofqy0+Hwxi8WTMOToYqYNEe8t1tLW7Vid6vi91QxGogqNYHbsdsJivV
 hEC+IfD+Wq2PtCg3dxKpSJ9t9h9AYrxpwgtTlTsfAQcNOkQCUSYKtLbMM
 1WgxbNV2ArogcLul7aKyY5PXcLHLmFcMtzXReuOktUflLDZZ1rBnp5vjM Q==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="26377115"
X-MGA-submission: =?us-ascii?q?MDHlI7iHgExURIGa95c/M8LuI2hgkaWQG7n5dN?=
 =?us-ascii?q?MPtOuMxpsNkxXTeTAgqdVP0v5cx9KnFkl/cwg4JXqQ+A1LqXV3xh2omy?=
 =?us-ascii?q?kEMAFLvPJ+OT+GBDrNYxn6GGJlXhgKoKadTHFZtqA2LrwKdD+wrYuN9i?=
 =?us-ascii?q?jsO/CGFcCyjkbYT79yLiEOKw=3D=3D?=
Received: from mail-am6eur05lp2109.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.109])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:43:52 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGUeaSzPDZ1gWrLYtEsgYL9aBcgoBHyVKt+rLly6RCx/e+yS9fZt6pFy+fhOhRSJ9gBStTd3wSpfKQxnVdoOcOq6K+ZibJsBGMJ8CfLL59BIqTeA1fcteGkwlGU8aeJX2T90iLXZ+7BBwwa2JUqqbnS4bBp4cTeC3wBLn7cLQdVQDQ4oaIJ2ob/NNr2RoZOkozCWUBF9KlQX9BfI0SEiMpvcAlFIMjkdmhSMrdM6BKh1ODuJUxai7YSTzF3ugOX0hWopyAKsjx+cppYFcaqy8vmkVF8zDfGBQm2H1wbR1ZDvDA1gvVXuyO6mrGb1eG3E2sEaeOe2sJgLo+m9+vU45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8O98KShNuvgHQbN+mh2dS/8MP0Nk7wBFRcwtlVqYDg=;
 b=RyniU3hIQo/FGQlJ+RCXdkikEJuheheB0PqhLK+n59YHlr2MM7J47Bl02MUlVcTzwFczEsFCcG5qWoLWRbtRaM3mr0vMssYEIrEtmkrpwMjHma/66h1RdsPOKTCjyCdm44WWiu0hcYg8nwGOoPDL9Pe2Wd1mibIuf3LOlHMr+P6f3jfhnaGX3JCIxjXDNsGq5BMcbzO35qI0/evdf1FYzA4RSesprL2Lr7hSgwR1YNq2PJ2ESYKMrpRnTnSYvmoISxvYQlsSQri7CtxF7BonE4AT953lMja7Yvpf99yfzcUDq/5zkx66CdB4+6R9mqoRSNGaX4qwr8ckkUXK9dDZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8O98KShNuvgHQbN+mh2dS/8MP0Nk7wBFRcwtlVqYDg=;
 b=q+jBtZ/UqNNAAc2iJhlN+ot6Kb93bK7COt/vWIO8T7syz4+tdj+cymO5A/C4o7a2FvbOoVOuFOhuSTfVmBMCJAZ94i8ysbjixUiN54zytmHoMlhRLo6+uHNGE2SrFpXJElB0UmBTir1ZSAO2GF3Q46Ab0wXQP1WoAvtfeiTzEmO5Mb/2tgcV+1pTwyZYdLUOBRTnWLjOhv5JLnVU/D2V0znma0R2qVpnzJj+KaXYgtzFxgnrjYUNoqRdCF78GAlp6P0DIKElq/KyDYexsyLoRsACh50KmfcMvNPI3rPjLn9Fc7IjR6YwhROHM1y7yy9nVOiHX0wtzF8JRUVBENif8A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7847.eurprd07.prod.outlook.com (2603:10a6:20b:39e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:43:51 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:43:51 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 03/19] memory: Allow to store the PASID in IOMMUTLBEntry
Thread-Topic: [PATCH v1 03/19] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Index: AQHbQjJuVhzKX0BtCk+R1aLGA9xAJA==
Date: Fri, 29 Nov 2024 07:43:51 +0000
Message-ID: <20241129074332.87535-4-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: ebf6b0d0-9d22-4d73-b24a-08dd10499151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?c1d4UXVEQkJLTVdTSHFLTWE1bHNKZzE4cC9mZkl5VDR0YUxMZi9BQnVJUTB2?=
 =?utf-8?B?MEltSlZGOGc3cW5weC9FYUxXK01QRnUrZGFpNU9BZmthR1c4Z1gzMi80MzJT?=
 =?utf-8?B?Z3dYbWlZWXY4czdvbXlJYlpydGxnbnZpSW11a05zZHVpNFN0Y0k2VWZ5aUh1?=
 =?utf-8?B?NS9ScU5XUURtVFRIR1l3QlhIVmo3MTFyQWxzbEw1UU04Nlp6S0lTaXVrSGhG?=
 =?utf-8?B?UGY1dEt6TEptN0pSK3l0NGlBQnU2NzVNZXQyNzNzMkduUHlpVUhhWHF3L3VC?=
 =?utf-8?B?d0ZURk5tZkxVaURTcDV3cjh2bSsvam0yalU4KytlcUlFbG9YOHlNY3BSRi9i?=
 =?utf-8?B?MG1YMXkrRWtPV0dCR3JaMVQyby9zNWl0cHNvbW50ZXJMMnRhQytGc0YyMWJR?=
 =?utf-8?B?ZE1GTjJpenF3YjAzNmpVWnQzNlBvQjAwZmhGdmYxSllybDBFOEhIdVhFaGFa?=
 =?utf-8?B?RTg4VVNRRTNrWE1SRmR2UTdBV3pRdjFiMFJkZ3FEZVpxSXJya0VkdkwxN3BD?=
 =?utf-8?B?bGVVQWprMFJPR2orOU5aWTVhbkhQd3lRai9SMVFGVEprc05va3N1WExmZGpE?=
 =?utf-8?B?NXpDdklkWXZGSE9wOWdxcTc4S21ZekpsZm1DS0laSDhLcWpCQnpQelVXSTk0?=
 =?utf-8?B?Ym4xTjcyUjR6a0htRWhyY0lPeU9jZnI1VGp1NDM5ME5yM3FTaUhTTFErQWtm?=
 =?utf-8?B?NjB5Tk5MMlQwclFiTllVQTl5VGNLWXUzUFRNMlFKd2NDc0NwWWZ6MnJEa2ps?=
 =?utf-8?B?VGViai9pSnlnTHZvQkJLVTdKSituYit3WlJTa3RJV1BVQm41TmZxZTBqcElQ?=
 =?utf-8?B?bWE5YTVteVdRZmxxc3kyZkZ3YUViU3JVWWpqZTFmekczdEhLU1JtZ1Nnb2Vx?=
 =?utf-8?B?Z1IxaFZFVm14K1FqV3lHeldXS3JEbVhxbUJiWWdLK0lDQVkxQUtwNU5CWHFU?=
 =?utf-8?B?SC9MZ1l0ZVhqUGF5QytmNTdySURCaXREaVRYelAwOW15bmJ6UGIvWXVGazNQ?=
 =?utf-8?B?ZVBPd0grbW9zRWFKKzgrcHlWRDhQUnV1Sksrd20rajYxTmMrYjhvdG9lUzUv?=
 =?utf-8?B?MmZkcE51a0JYalRuU1BRaFZ0ZXE1OHU0cjdQMTcyY2FBVDNheTBmN2NabUly?=
 =?utf-8?B?Y3BmajNhSlNBdmQ5TmUyZHRoc1hHZkQ3YStLdnBRZ1hzWmQxY3RmcUM2MzZv?=
 =?utf-8?B?cURNNHdOZnF2aHpSd1UrU1I0NDhvRG9OQndFYUVva2VvUWwvK0Z4NVVucFJ1?=
 =?utf-8?B?WDFubmRBM0JsV3o1bXR1bm9hWkxSdVo3QnBUdHdmWituaDB5RXJqN2RkM2VI?=
 =?utf-8?B?bGxnME41SUt1a3lGdERBSDd2b0c2eFpUenlXV21vdU5JODNNNE9rcmZrYUdk?=
 =?utf-8?B?d2FzWlRNelFSSU5aKzhxbVN6cTU1UWlwTTZrVm15dkx5WXRKbC92RmIvSGcr?=
 =?utf-8?B?NzVIbk9rV1hKRGZNY1NOMHRHQk1OUDA1WVM5L1pNTkVZUm00Q2ViWmdQaFM3?=
 =?utf-8?B?N21taHhRRkpoYVBKSWh4SUlmRFJWTW1peUZ4QnF4US9EVFpxeHo4alQzNUN5?=
 =?utf-8?B?ZTgrWUdxTFBUb0UxSmpmVkN2Rmp3cHVqUDdOTnRyS2JvSEZOTHljY1daL3Uz?=
 =?utf-8?B?cU9UWkZFOHNkL0QxVU9ObXYvYkpRbUV4cWI2MDQ2UXRIdS91T2x4UE94dzU4?=
 =?utf-8?B?eTNnR0VCeVNKZVhFUHU0dGJFdlJlck9lVTNYYzB3NjZDaTE5WWpyWS9RSlZq?=
 =?utf-8?B?NmxFclRQallXeEg1Y1Z3NjR5d2tXRVZaVkpuSHFFNm41cDkxRDF1VHM4R3FF?=
 =?utf-8?B?SVZKcjZNSzlnWFpCUHVuT3BJZHUzYUIrS2J6Z2VEV0M2dEhRZFdmRGtGajRk?=
 =?utf-8?B?OGNWM0RHU1pTL2J5YXhNTkNEK0tSWHlrS3ZjM0tnTFBRY1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEI0cW51OWxIRENGdU0wMUhPSFAyRm1wTHY5OEc5N25NbFd3N0xpNDVMOVdD?=
 =?utf-8?B?ckY3Z1UzMENxVmZiSWZjRXJqZ3J4alhhQndvejA3NER5dFBtaWo1OHRBd0pz?=
 =?utf-8?B?WWVOK2ZPNDFaWE5UK1NScEJNangzRTZpVUdjZzE4b3dybURJY0x6QlRVQ3Ni?=
 =?utf-8?B?UjlENGRiWVltb21MTm1ILzdtS3VZQUh5N1duU2lNS2VuWkpBK29JNGgxQnJv?=
 =?utf-8?B?MkVXSkhxT0pjUmZpR3RyZVgyd1UzZlZwYVRDbkJocDI0R2gyV0Z5dGFQSi9m?=
 =?utf-8?B?UTZzZ2phQjFGeGgwRHFTRlVuR0dlT3NHVUxscE9taFBCZGlVME9WaUFxbkl4?=
 =?utf-8?B?emM1OHVrMVZ0QWw1KzVlVzE4Qm9rSGN5ZlJRSlh0RU1ETlVpQTB2My9uWEkw?=
 =?utf-8?B?bi9CUCtHbURKTGVwWndGZlk5K1Zadkt6QnR3SVhyRFI0T0oyZzRwYVU3c245?=
 =?utf-8?B?UTVCQ2luYmpobGhzcmJHa0N0K0dDUnNzelZCTHVIN1pWcVRkaGF1eFRrRUl5?=
 =?utf-8?B?NmxuUFJadzE0RnFQN3pOdmZ4UElCMFBnVHBHTUlKS1g4ZHY0RnZRTXdDRDZ0?=
 =?utf-8?B?eW9ESXRwWHI1SXQwRklVZjBoNE5MZGhwNzFBWE1Ob24vcUxYRlJBVXQ0MVo3?=
 =?utf-8?B?MTVZWFlSY3VraTk2VWFiSHFPYXVBc2Fhc202dGNxellMcFhvTzR1MStwQ05T?=
 =?utf-8?B?WmxOWjlUbnZoZVhVU2o1Yy9qeDBuNEJqOHVVWjh1ZW5pb05IUTA4amU2QUZl?=
 =?utf-8?B?UVh5UFNYaTNHc3hkSmRqMkxsVVQyTjNvWmVtQ0N6SkRKRitnWEQzOTFKa2ZV?=
 =?utf-8?B?Wmg0SzNRQnlwWjFHTExtRXRMMERDbDRuVHBrd3lOemdiWEpCU05LNVcyTCtW?=
 =?utf-8?B?Tms1c2xvMmlOd2FSZTRMZzFRT3V3OXJpSUN0L2ZTMVRUaUVma2NBY1M5STVo?=
 =?utf-8?B?aWx4YkJaWVVTQmludXZENTFZRExwYzNWbFVERjdTb25XRHNBdWZQMFptWXBQ?=
 =?utf-8?B?bXdmMkpkbnhzSTAvRVkvc1FsU1grVCtTUmpvRXFmbUlpZmpob0srTmQyV2pW?=
 =?utf-8?B?Y0paNTBIcDhrR2N4ZFZLMzhubVNmdi81UFZNN1k1OGhkYnZuRGxNR0FYSzJS?=
 =?utf-8?B?d0VNaXFEK3NSUWZkdy9rWk8vNXhLOCt6Q3lYd0RZOVptQUxpRE1heHI0NHAr?=
 =?utf-8?B?a1cxMG1oZnY3SXh4eTk1YzZCUkJ0L3AzU3l5YklsR1hSUFRMWGdkbE5XWXlS?=
 =?utf-8?B?U0dobTh4SUEzMGIwMjZua3BVWGdmYnMzcklVbWoyamdCMXQvRDZIRmRjWm41?=
 =?utf-8?B?K3QzWndoWjVMQ04zNGFtMUtsVS9TKzhLTUxhWjA5aFl6SHU2MXR2bldJRy9W?=
 =?utf-8?B?dzVuKyszdXc5QnFRSk5NQ3ZlckhpZkpnUE01SXZpa3ljcVdvV052VzRrTkxZ?=
 =?utf-8?B?RDNocWxDN2YxQnFQTWxGbWpBd2taZXBnb1pnZjVqc21VdDRMZ21COVhQTnZM?=
 =?utf-8?B?aUxTU01JK2Y2YkE4TGFZRXBHUE9VQWN3bEsxWVA0VkdNWC9QdEhpamI4aUxs?=
 =?utf-8?B?Ykk0anZJa1BaNno3SWo4Y1A4R3Ixc3B2aytMSm1QU2dza0h4QzErRU1haUh6?=
 =?utf-8?B?cU82UVh1ZHVYcDZhRDdBUkh0RFNoMlFRWW1VVm9pMVRSUkV0Z2RadHRTSXFK?=
 =?utf-8?B?aDJ0bDdYb3pHN21oS055VGxIMXc3cFVoMldGRnA2bTJRblhFMXJnSVk1NVhq?=
 =?utf-8?B?OGptdVNHb2ZTN3ZoVHJyU0V6MEtaMHA5THdxR1hqYS9IdVJaL2pHMEh4NXI3?=
 =?utf-8?B?OG43V1pUbDRyUDVBdFluZkozNlh5T2NuQ2dqR0FlY1UvVGREMjduME5rM0lk?=
 =?utf-8?B?anpnQkxEQ05XaEtTREFsTUZnVlB5aWptbnpoQXRORDJmTkoxMVVXRzJvbVU3?=
 =?utf-8?B?VllHK0szaVFRY0ROVUJrWUUzcm1peFlKaFpORDh3aVFHOUdKVlR0cU9nUVJo?=
 =?utf-8?B?bkRrRmpQMjA2MGcrVUxYZ29za09HemFTR1MvUEovMTAyMHJxbHBMT21CUVhN?=
 =?utf-8?B?RVh1VlUwKzFtMmQ2dFNZOW9ETGJlbnZwUlU1VmM0MDF0ckVnSXJzTjIxNk5G?=
 =?utf-8?B?c1EzVW5Tb2p4OXlCSVZPUEdWMldZOS9POGkySy9qMFE4M1E0T1BIVHJ1QUE2?=
 =?utf-8?Q?RzsqucckQr1wzBuhtOu6mOw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70E67DE5C74D2747A5ACD2686E753665@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf6b0d0-9d22-4d73-b24a-08dd10499151
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:43:51.2633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOleF5CtLnYf28y4ddTRoJ7uObK/d7t6d266DW5Mm446PdnvCb6GeyJy1TiAZpJYN92vz+S8Mp2HBexsRc4ThLs8cySuHKI4zpOm9gSJ/JdYHbVIKyCIR6TNVzLnQ8qY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7847
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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
bi5jb20+DQoNClRoaXMgd2lsbCBiZSB1c2VmdWwgZm9yIGRldmljZXMgdGhhdCBzdXBwb3J0IEFU
Uw0KYW5kIG5lZWQgdG8gc3RvcmUgZW50cmllcyBpbiBhbiBBVEMgKGRldmljZSBJT1RMQikuDQoN
ClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0t
ZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaW5jbHVkZS9leGVjL21lbW9yeS5oIHwgMSArDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMv
bWVtb3J5LmggYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCmluZGV4IDE1ZmZmNjk0MzIuLjc1NmRk
MmVhN2YgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCisrKyBiL2luY2x1ZGUv
ZXhlYy9tZW1vcnkuaA0KQEAgLTE0NSw2ICsxNDUsNyBAQCBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSB7
DQogICAgIGh3YWRkciAgICAgICAgICAgdHJhbnNsYXRlZF9hZGRyOw0KICAgICBod2FkZHIgICAg
ICAgICAgIGFkZHJfbWFzazsgIC8qIDB4ZmZmID0gNGsgdHJhbnNsYXRpb24gKi8NCiAgICAgSU9N
TVVBY2Nlc3NGbGFncyBwZXJtOw0KKyAgICB1aW50MzJfdCAgICAgICAgIHBhc2lkOw0KIH07DQog
DQogLyoNCi0tIA0KMi40Ny4wDQo=

