Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036EDC369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 12:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5OYP-0004C7-M9; Thu, 17 Apr 2025 08:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u5OYG-0003xy-Nk
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:41:09 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u5OYB-0003Z4-D4
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1744893663; x=1776429663;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=n54Ys7yAfwROWa8t6leKkBSWYrZsHlOGlKAt3umZdi4=;
 b=oEWIqfvQ5nSvahtxUFLVBl5t3UFitNSnCIFPc2HqzA5AwSewRqbRMmRc
 yY85B/5SjIwmecBOVTgduPDIYRnTYGwTDOGVDyqBU2deQsXH9P0JIpc4U
 34gKb30P7Z6A+GkVQ2L0BeuPL4Sw307r/f0WNCx6sOd3/olJBI+CNJce5
 j+UjuBrMgP2gINVLLNKipPmLyiYHi1nIKPlCyJ8vVoxvQqVr3k7v0t1wa
 JqrjvUP24KAMAZGhJYjJcaawVxN34DnjbIA5JVOdGF/nd6+Jb3CRimVUu
 SnthslsKxuoGHU4BswCsR8sJFKvSdfa6Uyg5hCmGV1Q/XGivgu0BDZ/wY A==;
X-CSE-ConnectionGUID: 9dCckO5tQiSAeqQXzaStpA==
X-CSE-MsgGUID: UAr/3xAJTXmV1pRKZb0q1Q==
X-IronPort-AV: E=Sophos;i="6.15,219,1739833200"; d="scan'208";a="35235405"
X-MGA-submission: =?us-ascii?q?MDF9rZn2iBylCk6AymKYm8PszzICwZ4QB8VuxC?=
 =?us-ascii?q?w1YkDhm+m0yhinU0gjZQzZL/mmpPqpoiKIsS2qdhsi/4Ar1bJLlcFLZK?=
 =?us-ascii?q?ZGsKUHo2q9r+nSjhFW+HHbq0Ehr1QEFhl/THdhz7Vdq1h2hqBfL5fcPV?=
 =?us-ascii?q?EmFmStTi0SYYaH0mLnJZYYgg=3D=3D?=
Received: from mail-francecentralazlp17013078.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.93.76.78])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 17 Apr 2025 14:40:58 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4fFxFJuk/AVIpPypgiOwwEw31QLYF3smNsevB9peyBrIyK+a6P00lkldaCNim7qTasIZl6iT21lkaVMo4axtcz89IJRLaH5GesFvNXNbzL0svyPSvizeankzTk7heWjZ1lEuXZsehCjz4BNi2Wh7o/dp053UREwX7rB8Ejzac843q7g3rcqqKz5JIwZPyi84xogdiIsTZFMv/vmtixBOkJrt3EAWjVuZyF4QLyny9K1L6nIuHmyQhj1dUDkDyXVflzyvnKxtH3spcc4LxsMf2Y1f6txsdzA8zrXjj5kEnrdqkVfxaVEaaZbKwBcX1PPVX9zPc2pp/dICkGqLsQYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n54Ys7yAfwROWa8t6leKkBSWYrZsHlOGlKAt3umZdi4=;
 b=quT8LtFlKIMSQnWClo2elDb72wmEUHmIML5ieix7cIFIKyzvEtHgUHqojdvTSwUYEyvOFrtMpAkk5jicRiwWFYdAjoxpWMMsEEujLWMmdhkvDe8xzN64ebWM0AamhW3yxTnsKNbV8+QYFcv9ZrzfoELtbC53yNzCEfMSCeRJNMMaG/oywAtKE8YVK4MatmRz4xS1Fecg3FhV6Ut98upiwXB0Zabk9JJfkUDf8gPQHtodap7EVxZ0utPNzFUJMeNG/2hrPFUxrZH4vC8c/g3e2/douu+cxJy7cBVKj2ccxagtFvFPpPxTRbuDUFgxZshu7vvg73ZIGdcu7XNoHla5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n54Ys7yAfwROWa8t6leKkBSWYrZsHlOGlKAt3umZdi4=;
 b=qXlJldUpgqBHpqEQYBLKjJjLvs43wuyMjAcSCVmzZsgRcH6Sm30l1MYMJSIUa96k1DbPhBAo3ooc4dtb1sQFUUNLtnPTUzPobbuzLx75GvLUmMbnEh2paPDK/JsYg6lhwK/HvpM5n7DXgehT6eggH7Xb2VTGInst2D2u/mNoWOZgDvSZP66OqiNnNCr/EJx2kuk2My4gTfp5E0bgmQf4c5NiizenY2SN+rwPQ+9e+nJRLI+hO2wEYCt0RZkWJQFOVA2wvnhbk0LBi+RiMk5030/wKmr7lsdjOi+KiTDKVNQmJyF3EBBzvILo1/1EiFmnYPL66o5YNieLeTcsDqB/nw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB9885.eurprd07.prod.outlook.com (2603:10a6:10:4c8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 12:40:56 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 12:40:56 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>, "sarunkod@amd.com"
 <sarunkod@amd.com>, "Wei.Huang2@amd.com" <Wei.Huang2@amd.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 09/18] amd_iommu: Add helpers to walk AMD v1 Page Table
 format
Thread-Topic: [PATCH 09/18] amd_iommu: Add helpers to walk AMD v1 Page Table
 format
Thread-Index: AQHbrOHNJ7qsCoLeIE2XJ/ZEyor2drOn0iQA
Date: Thu, 17 Apr 2025 12:40:56 +0000
Message-ID: <32609749-864c-4fe2-8c00-8dd8e0ab2efc@eviden.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-10-alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250414020253.443831-10-alejandro.j.jimenez@oracle.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB9885:EE_
x-ms-office365-filtering-correlation-id: 1ea336f9-5eb7-44df-3dc4-08dd7dad191c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Qkc4STB5bDMwd1E3Zk5zZzZBSTZ3VUdwUzBFUlJodCtPUk1UVVhxUFNSN1dY?=
 =?utf-8?B?aGI4TU02UVlyVUVham40SDV1RVpwRkFwZWRGZmtWZHhBMWhHQlpCeXhUbHlj?=
 =?utf-8?B?cmFxWE42aUFrUmZNUHpScXRRWVVENWNrTHpwUGVoNDJIMlVxV2ZxY1dNMUp0?=
 =?utf-8?B?NXZyWHJ0cEtCYm8rYlNNNkRibXlEUVg0UFVRTVMyWmJvRU9xWHNRSU5Nall5?=
 =?utf-8?B?S3IvWThFRWhGQnBLRzBZUW5OdkdzSHBac0c3TkVjd2tmQVFpSTBiclJqWFps?=
 =?utf-8?B?dFh3MEk3Tjh3REdvK21ZRlVjNlFET1pWVmVRb1NKRlc2T20vVnJCL2RBbWtF?=
 =?utf-8?B?KzR4K2Y5YkIyOGsyeiszYlA4dkJFQ21Rb1ErTWp3MzBlbHdnRVEzS1NvZVpM?=
 =?utf-8?B?L0hmRjZSeXhaYjdMWmIrbEx5ZmU2L1pUNFQrSmY5TVd6V2lsSkRvL2M2Z1Rw?=
 =?utf-8?B?cHB1Z1NNejVxY2NMWnRWUGJGbmtPbkkyK2sxN0JzSmNRSENXTFB0OVk4czlu?=
 =?utf-8?B?WDMyNWZJZ1NUMWRRemRMZno5RXNsMFN6WEYxSXB1ZVQyWUVDcVlOaUhTSk1X?=
 =?utf-8?B?RU1KT0xLcGhYSTdYWDFVQ3FEUXpVSHNpbHBOTVh6ZXlJd0wxTTZiNloySkdW?=
 =?utf-8?B?MjRiaXB4cDBBdHdiRWxCeXRmcTE0NjYwUEV2bmpaNUIwK2JZMzVnZ29HSXhy?=
 =?utf-8?B?K2YrbTd5UTY5MFRuSWNVdFBPeitOUVdMdU44N1hxQ3pFQkpVa2dRTVRQMEtO?=
 =?utf-8?B?aXhIc0tiZ014cVNTeXB6ZnIyZUlmMkkrVFdybDBaUkJDZlNvUmR1ZzZzMWhZ?=
 =?utf-8?B?aVk4ZDYzcWJGckpzYVY3ZTFIMHlYaVFtSE5NWVpLalpOcXBxMnlRTWlJSmNz?=
 =?utf-8?B?aVlsWmZaRDNqSEdUMEh6NTRNMWFLd3hzNk55QnBvMXlqT0E5QmM5OTFFckRH?=
 =?utf-8?B?cjYzTTI1MEZaZ2x3dFNRV00zMzdMTDUwSDcwUm1HQnIzQ3hxK0ZFK01aWnU2?=
 =?utf-8?B?NmR5aWI4eWpjQ0E1MktpWko5VTdNL0ErK0hEcnJ2bkNyVnZHb0k2bjA0OHFo?=
 =?utf-8?B?ay9ja1lBaVJzMXhXVEhJL3k3S1NjbDdVVzhOY0UrdTc1U3pUcUlDTGFRTGxM?=
 =?utf-8?B?OHpTSzlQTE52dUhTY1VpbXI4UHJCU2NGV1Z5ZnhDeWxwUjJaekk5UU5NUFpR?=
 =?utf-8?B?UjdNNDJiOUxpNUpZN05jRC9mNnBiNnBzQ29VRGhnSnA4ckNrY0JsNmc4VGly?=
 =?utf-8?B?Sm95Q1lFZHZqSW1Ndm9wU3RtWmFmUW0yQlpMTG1ZSHpod25QdWszeWxLYlJY?=
 =?utf-8?B?UkJmczI0TldLcVF4RzZTTkEwU3BZQURQOUVXR2pHRHVIUVJXclQxQ3Z6WGlW?=
 =?utf-8?B?ZFJVRlV1V3FSQmZYOTBRZjBCVkxJSWhHWS9ZYnJOUWJLZ25RRWNKTTZSMlNK?=
 =?utf-8?B?N21Dc0FtUzJTdGRmbUN1b1NubS91OWZzUGNrL3V0aU1UNWlndGk1bVR2bXVR?=
 =?utf-8?B?N3g0RTd4MWpMbStTV2UzVnREMFdPQmlvR2laRVUrbUptaUJqMjl4UmNyWU9v?=
 =?utf-8?B?YmRkZXBmRzNzY25UYnp1WXRocG9ZajVWUWVYTFdvbWJjTDZ5Y2JJb0ZTL2Fu?=
 =?utf-8?B?R1hpeE9jb2hVYXlRNEZDYkVqUTZ3bTRFN2E3SWU3Vm9HcHNFVVV2MSszNlY0?=
 =?utf-8?B?dElpWVhyU084NWc3clVjTEFzdExOczB4WHRBeG1wc2c2bXFlMVhReXNlS3Zo?=
 =?utf-8?B?QnlQM0NYTkw3dHBzdU1wY0FNaTlOelp2aFR5WXJqNk9kY0gycVcxR3VUS2lU?=
 =?utf-8?B?RmZVeXltQlYwbVloVjF2M3p3b2VDNERYVzFRT2c4UWZMUHI4V2ZFcXNHSzZj?=
 =?utf-8?B?UzhkeHY4WEhCRnRtbUtrNDdhaWlwWWJXWDd1cXZGVTVkeHNYdkpkaEpzVEZE?=
 =?utf-8?B?NXhNanBEZjBob3laTHRlWTNGVE9EREt2WWR1WVR2TFRJNTgrc0kzYXhNV3Nk?=
 =?utf-8?B?RE5WQmJhZXhnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmkvclJ3QnlBVnB6S3lzeXBoTFlna1l0aW1CcU1OK0VMakU0bHo2cDcyZ2JY?=
 =?utf-8?B?eXQxdXZRb29rVkVJcUxqbElBVS92d0pnQnNEdDFQMmVPOUFNcjhGTkJFTUhi?=
 =?utf-8?B?Uk9sYnNqMEJjZ1dsa2VLWXBxeDE2aVd6MXZYZjlxRXF5bjNydTVuMTdjUEI2?=
 =?utf-8?B?Ty9rZjdoZko2aFAyUXpjQkMvSmppbDN1bU5zSmlvVzJoU2ZJdG1CdHpnZjVz?=
 =?utf-8?B?SVRJWnNEaWQveXZMazdCZGhnZjd5OTNXV3VhbHdwMzBpZGM3MHhrRGVYYnJp?=
 =?utf-8?B?UE00K0JJUU1vdkNyS0oyQzBoYnRRekp6WWpDaXlVZnV5TG5ZUEl3N2JkOERL?=
 =?utf-8?B?UTdiVzJRR3pZNndrYWlFZDVsaHJtSno4TmxLMlhhQnpQbkJ3QlpuOWs0bGFi?=
 =?utf-8?B?andJMitWeHVpWExsZnkrMU5VcnJvbTdxTndwOFJqSlFtS3k2ck52RzUycGZt?=
 =?utf-8?B?eDVKcWtiMUNYS3ZFR1dpMDRnZ2pRRDdiQUsyc3FqYTRZbzA0QlZxS2VVRHRl?=
 =?utf-8?B?cUJ2a2lKTUw1TGFIamhzVnpEVlJTVGpGR0JJN1RacGdvbE9Cb0plaC9ZYXhK?=
 =?utf-8?B?ZWZ3elNrbTdjWHA2WTd1dzFNRUZjZVh0U2EzUDl0NVh3UFdoaFBJbUNKbDhh?=
 =?utf-8?B?VmFucjhrbG5tVWxIL3JYME0rV0c0MWxkUDJVN1BhOGJ6WnhsTmtrNlptUDZl?=
 =?utf-8?B?Yyt3Znc3WE43cEM5NXBTSTNyRWRoS0pXTmJFVTZnOG14QkkyemMrdGM2ZzEy?=
 =?utf-8?B?cXFuWm4vMC85RmN5YUJtWHhDWEJEbWwxOUwrbGM1RjBnVGFicjdzWEhVVXFS?=
 =?utf-8?B?bjRqUVZOU1VNN1g1ZlNjK3h2MHc4ZERDb2hUa21pTXplTU13cFlTTStWSm41?=
 =?utf-8?B?VWlLMExpdm5RbGFDZER6Z1diM292djhnTU14S1gxb1dUbVdBMWF6Q3V1L3JW?=
 =?utf-8?B?bGcwcll3ejhTSkc1dk5KVW53M0dXbm0yU0JNcEF4RCtXSGt4TnllQ2cvQ2RQ?=
 =?utf-8?B?WnEvb0ZSd3pFSERqd3dlekR0clpPcm9IaGViM2xJaGoxSENCZGVHMXdrYnJG?=
 =?utf-8?B?RzFpLzl0anFwT0RqeE9jRUlyQTdrMVNIY3duak9hTzdjbUNFQUExc1B2T3dj?=
 =?utf-8?B?M3o3dldjZUcwYTBSYjdQblBtN2tzYm5jYnRnRG9LcFNWdjdxMytwbHhheDZj?=
 =?utf-8?B?N3RoejVuYWJpU2w4RVFJeFg5YUhrUGFsVndyNkdFSmg4QlNrSk9BN0drT0lz?=
 =?utf-8?B?OENzQ0k3UTMzRjZNWmJ0ZTE3Z3QzVGRvS0tNdVVucjAvQzhvU2R1WFRvU1ds?=
 =?utf-8?B?KzArMkx3dDMvYUhxWERNVWVJTTdpWkc0UkcvaFlySGVrRFhtZXhiZGhjR3VP?=
 =?utf-8?B?dWZ1czZRZXQzTWRhc0pKbnRDK2VPdVF5Sy8vaUVlajBiS2c1V1lpcjE0WWFI?=
 =?utf-8?B?c1VwMG5uM3lvdXM3dmFFTXJNQ001L0xxMXBvWmMyNkE3dkxoNmxrS1YrenR4?=
 =?utf-8?B?aVBuOENZNENSQkpjcEtQeUFlbExmR2RLcnFHSmJwelY3MGhSaUkyNkdGZWdU?=
 =?utf-8?B?S2pocW9STTE3RVcrY2ZMMXlyVEhVbFFRVGRGUUc2azZpSVV5UkJicnlNVklY?=
 =?utf-8?B?R3BhY1ZJeWpEcHN6bC95WFNrclJXa01iWHorU3JUeHhzVXhXYmJqMjZycWo4?=
 =?utf-8?B?cGMrR2F6T256ZnBlaDViN1g2eVNVT0RLNGtpeStQbktJcEZXMnBWVklCTFhD?=
 =?utf-8?B?SkNPQk1rZm5jUlJSRXpJcm5sN0JzNG5JaUFHVXpkVDJ0NXIxL0hHS2tqVVdx?=
 =?utf-8?B?VlNvSGpGMXd6cGZ3QzkvTG9rZXg1V1p2Wm5NWWFoendnYmN2Nm5GcjFXd2hB?=
 =?utf-8?B?UEliNVRtRTNEdlZsMHkxbnZ0WktwMnZhL0dreG1XSXY3clAxN2wyaFFBU1Jj?=
 =?utf-8?B?NzJ1M0N6bktpczA1MHZMOUpWYndZQldIMjJEdzZIWUJkUDl1Y0o4eU5OM2F5?=
 =?utf-8?B?L0k5ZjZ3aDdidVUzS0VraGhOV3R0NVpPcUVkcDRuZDBWa05CbVY3WnJlSkR2?=
 =?utf-8?B?dWFtVEFabGZHN29pR2dIT0Vob1hCTXB1WjRSRlNGTU9vSmVGY2xBbnZ2QjYv?=
 =?utf-8?B?UTVtQlVIZXl2RGZWSHNkRUZtRGhuTzE4TmRtbmdhNEVvNG05eUtrTmdmVnJN?=
 =?utf-8?Q?MIc6busz3/4rHW0gocv3Hb0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <413AD7ABF0D6E743A09723C3B06A0AC2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea336f9-5eb7-44df-3dc4-08dd7dad191c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 12:40:56.0389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pasEUM96DPpaXkwohUi0C399Yj6IZsShzkGPEFePDyUodaeIqRoYfpubIC7RmNzDA6a5V1uWJMqPHDu6fNBQG3lbvN7vEoC96IbJvu+/Vk/SbgCRNuYIc87saxLQw234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9885
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

DQoNCk9uIDE0LzA0LzIwMjUgNDowMiBhbSwgQWxlamFuZHJvIEppbWVuZXogd3JvdGU6DQo+IENh
dXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBs
aW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBUaGUgY3VycmVudCBhbWR2aV9w
YWdlX3dhbGsoKSBpcyBkZXNpZ25lZCB0byBiZSBjYWxsZWQgYnkgdGhlIHJlcGxheSgpDQo+IG1l
dGhvZC4gUmF0aGVyIHRoYW4gZHJhc3RpY2FsbHkgYWx0ZXJpbmcgaXQsIGludHJvZHVjZSBoZWxw
ZXJzIHRvIGZldGNoDQo+IGd1ZXN0IFBURXMgdGhhdCB3aWxsIGJlIHVzZWQgYnkgYSBwYWdlIHdh
bGtlciBpbXBsZW1lbnRhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZWphbmRybyBKaW1l
bmV6IDxhbGVqYW5kcm8uai5qaW1lbmV6QG9yYWNsZS5jb20+DQo+IC0tLQ0KPiAgIGh3L2kzODYv
YW1kX2lvbW11LmMgfCAxMjUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gICBody9pMzg2L2FtZF9pb21tdS5oIHwgIDQyICsrKysrKysrKysrKysrKw0KPiAg
IDIgZmlsZXMgY2hhbmdlZCwgMTY3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9o
dy9pMzg2L2FtZF9pb21tdS5jIGIvaHcvaTM4Ni9hbWRfaW9tbXUuYw0KPiBpbmRleCAwYWY4NzNi
NjZhMzEuLmQwODlmZGMyOGVmMSAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9hbWRfaW9tbXUuYw0K
PiArKysgYi9ody9pMzg2L2FtZF9pb21tdS5jDQo+IEBAIC0xNTYzLDYgKzE1NjMsMTMxIEBAIHN0
YXRpYyBjb25zdCBNZW1vcnlSZWdpb25PcHMgYW1kdmlfaXJfb3BzID0gew0KPiAgICAgICB9DQo+
ICAgfTsNCj4gDQo+ICsvKg0KPiArICogRm9yIGEgUFRFIGVuY29kaW5nIGEgbGFyZ2UgcGFnZSwg
cmV0dXJuIHRoZSBwYWdlIHNpemUgaXQgZW5jb2RlcyBhcyBkZXNjcmliZWQNCj4gKyAqIGJ5IHRo
ZSBBTUQgSU9NTVUgU3BlY2lmaWNhdGlvbiBUYWJsZSAxNDogRXhhbXBsZSBQYWdlIFNpemUgRW5j
b2RpbmdzLg0KPiArICogTm8gbmVlZCB0byBhZGp1c3QgdGhlIHZhbHVlIG9mIHRoZSBQVEUgdG8g
cG9pbnQgdG8gdGhlIGZpcnN0IFBURSBpbiB0aGUgbGFyZ2UNCj4gKyAqIHBhZ2Ugc2luY2UgdGhl
IGVuY29kaW5nIGd1YXJhbnRlZXMgYWxsICJiYXNlIiBQVEVzIGluIHRoZSBsYXJnZSBwYWdlIGFy
ZSB0aGUNCj4gKyAqIHNhbWUuDQo+ICsgKi8NCj4gK3N0YXRpYyB1aW50NjRfdCBsYXJnZV9wdGVf
cGFnZV9zaXplKHVpbnQ2NF90IHB0ZSkNCj4gK3sNCj4gKyAgICBhc3NlcnQoUFRFX05FWFRfTEVW
RUwocHRlKSA9PSA3KTsNCj4gKw0KPiArICAgIC8qIERldGVybWluZSBzaXplIG9mIHRoZSBsYXJn
ZS9jb250aWd1b3VzIHBhZ2UgZW5jb2RlZCBpbiB0aGUgUFRFICovDQo+ICsgICAgcmV0dXJuIFBU
RV9MQVJHRV9QQUdFX1NJWkUocHRlKTsNCj4gK30NCj4gKw0KPiArLyoNCj4gKyAqIEhlbHBlciBm
dW5jdGlvbiB0byBmZXRjaCBhIFBURSB1c2luZyBBTUQgdjEgcGd0YWJsZSBmb3JtYXQuDQo+ICsg
KiBSZXR1cm5zOg0KPiArICogLTI6ICBUaGUgUGFnZSBUYWJsZSBSb290IGNvdWxkIG5vdCBiZSBy
ZWFkIGZyb20gRFRFLCBvciBJT1ZBIGlzIGxhcmdlciB0aGFuDQo+ICsgKiAgICAgIHN1cHBvcnRl
ZCBieSBjdXJyZW50IHBhZ2UgdGFibGUgbGV2ZWwgZW5jb2RlZGluIERURVtNb2RlXS4NCj4gKyAq
IC0xOiAgUFRFIGNvdWxkIG5vdCBiZSByZWFkIGZyb20gZ3Vlc3QgbWVtb3J5IGR1cmluZyBhIHBh
Z2UgdGFibGUgd2Fsay4NCj4gKyAqICAgICAgVGhpcyBtZWFucyB0aGF0IHRoZSBEVEUgaGFzIHZh
bGlkIGRhdGEsIGFuZCBvbmUgb2YgdGhlIGxvd2VyIGxldmVsDQo+ICsgKiAgICAgIGVudHJpZXMg
aW4gdGhlIFBhZ2UgVGFibGUgY291bGQgbm90IGJlIHJlYWQuDQo+ICsgKiAgMDogIFBURSBpcyBt
YXJrZWQgbm90IHByZXNlbnQsIG9yIGVudHJ5IGlzIDAuDQo+ICsgKiA+MDogIExlYWYgUFRFIHZh
bHVlIHJlc29sdmVkIGZyb20gd2Fsa2luZyBHdWVzdCBJTyBQYWdlIFRhYmxlLg0KPiArICovDQoN
ClRoaXMgc2VlbXMgdG8gYmUgYSBiaXQgZXJyb3IgcHJvbmUgYXMgYW55IHN0YXRlbWVudCBsaWtl
ICJpZiAocHRlIDwgMCkiIA0KbWlnaHQgYmUgY29tcGxldGVseSByZW1vdmVkIGJ5IHRoZSBjb21w
aWxlciBkdXJpbmcgb3B0aW1pemF0aW9uIHBoYXNlcy4NCklmIHlvdSB3YW50IHRvIHJldXNlIHN1
Y2ggImhpZ2giIHZhbHVlcywgZGVmaW5lcyBjb3VsZCBoZWxwLg0KT3RoZXJ3aXNlLCBwdGUgY291
bGQgYmUgYW4gb3V0IHBhcmFtZXRlci4NCg0KPiArc3RhdGljIHVpbnQ2NF90IF9fYXR0cmlidXRl
X18oKHVudXNlZCkpDQo+ICtmZXRjaF9wdGUoQU1EVklBZGRyZXNzU3BhY2UgKmFzLCBjb25zdCBo
d2FkZHIgYWRkcmVzcywgdWludDY0X3QgZHRlLA0KPiArICAgICAgICAgIGh3YWRkciAqcGFnZV9z
aXplKQ0KPiArew0KPiArICAgIElPTU1VQWNjZXNzRmxhZ3MgcGVybXMgPSBhbWR2aV9nZXRfcGVy
bXMoZHRlKTsNCj4gKw0KPiArICAgIHVpbnQ4X3QgbGV2ZWwsIG1vZGU7DQo+ICsgICAgdWludDY0
X3QgcHRlID0gZHRlLCBwdGVfYWRkcjsNCj4gKw0KPiArICAgICpwYWdlX3NpemUgPSAwOw0KPiAr
DQo+ICsgICAgaWYgKHBlcm1zID09IElPTU1VX05PTkUpIHsNCj4gKyAgICAgICAgcmV0dXJuICh1
aW50NjRfdCktMjsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICAvKg0KPiArICAgICAqIFRoZSBMaW51
eCBrZXJuZWwgZHJpdmVyIGluaXRpYWxpemVzIHRoZSBkZWZhdWx0IG1vZGUgdG8gMywgY29ycmVz
cG9uZGluZw0KPiArICAgICAqIHRvIGEgMzktYml0IEdQQSBzcGFjZSwgd2hlcmUgZWFjaCBlbnRy
eSBpbiB0aGUgcGFnZXRhYmxlIHRyYW5zbGF0ZXMgdG8gYQ0KPiArICAgICAqIDFHQiAoMl4zMCkg
cGFnZSBzaXplLg0KPiArICAgICAqLw0KPiArICAgIGxldmVsID0gbW9kZSA9IGdldF9wdGVfdHJh
bnNsYXRpb25fbW9kZShkdGUpOw0KPiArICAgIGFzc2VydChtb2RlID4gMCAmJiBtb2RlIDwgNyk7
DQo+ICsNCj4gKyAgICAvKg0KPiArICAgICAqIElmIElPVkEgaXMgbGFyZ2VyIHRoYW4gdGhlIG1h
eCBzdXBwb3J0ZWQgYnkgdGhlIGN1cnJlbnQgcGd0YWJsZSBsZXZlbCwNCj4gKyAgICAgKiB0aGVy
ZSBpcyBub3RoaW5nIHRvIGRvLiBUaGlzIHNpZ25hbHMgdGhhdCB0aGUgcGFnZXRhYmxlIGxldmVs
IHNob3VsZCBiZQ0KPiArICAgICAqIGluY3JlYXNlZCwgb3IgaXMgYW4gYWRkcmVzcyBtZWFudCB0
byBoYXZlIHNwZWNpYWwgYmVoYXZpb3IgbGlrZQ0KPiArICAgICAqIGludmFsaWRhdGluZyB0aGUg
ZW50aXJlIGNhY2hlLg0KPiArICAgICAqLw0KPiArICAgIGlmIChhZGRyZXNzID4gUFRfTEVWRUxf
TUFYX0FERFIobW9kZSAtIDEpKSB7DQo+ICsgICAgICAgIC8qIElPVkEgdG9vIGxhcmdlIGZvciB0
aGUgY3VycmVudCBEVEUgKi8NCj4gKyAgICAgICAgcmV0dXJuICh1aW50NjRfdCktMjsNCj4gKyAg
ICB9DQo+ICsNCj4gKyAgICBkbyB7DQo+ICsgICAgICAgIGxldmVsIC09IDE7DQo+ICsNCj4gKyAg
ICAgICAgLyogVXBkYXRlIHRoZSBwYWdlX3NpemUgKi8NCj4gKyAgICAgICAgKnBhZ2Vfc2l6ZSA9
IFBURV9MRVZFTF9QQUdFX1NJWkUobGV2ZWwpOw0KPiArDQo+ICsgICAgICAgIC8qIFBlcm1pc3Np
b24gYml0cyBhcmUgQU5EZWQgYXQgZXZlcnkgbGV2ZWwsIGluY2x1ZGluZyB0aGUgRFRFICovDQo+
ICsgICAgICAgIHBlcm1zICY9IGFtZHZpX2dldF9wZXJtcyhwdGUpOw0KPiArICAgICAgICBpZiAo
cGVybXMgPT0gSU9NTVVfTk9ORSkgew0KPiArICAgICAgICAgICAgcmV0dXJuIHB0ZTsNCj4gKyAg
ICAgICAgfQ0KPiArDQo+ICsgICAgICAgIC8qIE5vdCBQcmVzZW50ICovDQo+ICsgICAgICAgIGlm
ICghSU9NTVVfUFRFX1BSRVNFTlQocHRlKSkgew0KPiArICAgICAgICAgICAgcmV0dXJuIDA7DQo+
ICsgICAgICAgIH0NCj4gKw0KPiArICAgICAgICAvKiBMYXJnZSBvciBMZWFmIFBURSBmb3VuZCAq
Lw0KPiArICAgICAgICBpZiAoUFRFX05FWFRfTEVWRUwocHRlKSA9PSA3IHx8IFBURV9ORVhUX0xF
VkVMKHB0ZSkgPT0gMCkgew0KPiArICAgICAgICAgICAgLyogTGVhZiBQVEUgZm91bmQgKi8NCj4g
KyAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgLyoNCj4g
KyAgICAgICAgICogSW5kZXggdGhlIHBndGFibGUgdXNpbmcgdGhlIElPVkEgYml0cyBjb3JyZXNw
b25kaW5nIHRvIGN1cnJlbnQgbGV2ZWwNCj4gKyAgICAgICAgICogYW5kIHdhbGsgZG93biB0byB0
aGUgbG93ZXIgbGV2ZWwuDQo+ICsgICAgICAgICAqLw0KPiArICAgICAgICBwdGVfYWRkciA9IE5F
WFRfUFRFX0FERFIocHRlLCBsZXZlbCwgYWRkcmVzcyk7DQo+ICsgICAgICAgIHB0ZSA9IGFtZHZp
X2dldF9wdGVfZW50cnkoYXMtPmlvbW11X3N0YXRlLCBwdGVfYWRkciwgYXMtPmRldmZuKTsNCj4g
Kw0KPiArICAgICAgICBpZiAocHRlID09ICh1aW50NjRfdCktMSkgew0KPiArICAgICAgICAgICAg
LyoNCj4gKyAgICAgICAgICAgICAqIEEgcmV0dXJuZWQgUFRFIG9mIC0xIGluZGljYXRlcyBhIGZh
aWx1cmUgdG8gcmVhZCB0aGUgcGFnZSB0YWJsZQ0KPiArICAgICAgICAgICAgICogZW50cnkgZnJv
bSBndWVzdCBtZW1vcnkuDQo+ICsgICAgICAgICAgICAgKi8NCj4gKyAgICAgICAgICAgIGlmIChs
ZXZlbCA9PSBtb2RlIC0gMSkgew0KPiArICAgICAgICAgICAgICAgIC8qIEZhaWx1cmUgdG8gcmV0
cmlldmUgdGhlIFBhZ2UgVGFibGUgZnJvbSBSb290IFBvaW50ZXIgKi8NCj4gKyAgICAgICAgICAg
ICAgICAqcGFnZV9zaXplID0gMDsNCj4gKyAgICAgICAgICAgICAgICByZXR1cm4gKHVpbnQ2NF90
KS0yOw0KPiArICAgICAgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgICAvKiBGYWls
dXJlIHRvIHJlYWQgUFRFLiBQYWdlIHdhbGsgc2tpcHMgYSBwYWdlX3NpemUgY2h1bmsgKi8NCj4g
KyAgICAgICAgICAgICAgICByZXR1cm4gcHRlOw0KPiArICAgICAgICAgICAgfQ0KPiArICAgICAg
ICB9DQo+ICsgICAgfSB3aGlsZSAobGV2ZWwgPiAwKTsNCj4gKw0KPiArICAgIC8qDQo+ICsgICAg
ICogUGFnZSB3YWxrIGVuZHMgd2hlbiBOZXh0IExldmVsIGZpZWxkIG9uIFBURSBzaG93cyB0aGF0
IGVpdGhlciBhIGxlYWYgUFRFDQo+ICsgICAgICogb3IgYSBzZXJpZXMgb2YgbGFyZ2UgUFRFcyBo
YXZlIGJlZW4gcmVhY2hlZC4gSW4gdGhlIGxhdHRlciBjYXNlLCByZXR1cm4NCj4gKyAgICAgKiB0
aGUgcG9pbnRlciB0byB0aGUgZmlyc3QgUFRFIG9mIHRoZSBzZXJpZXMuDQo+ICsgICAgICovDQo+
ICsgICAgYXNzZXJ0KGxldmVsID09IDAgfHwgUFRFX05FWFRfTEVWRUwocHRlKSA9PSAwIHx8IFBU
RV9ORVhUX0xFVkVMKHB0ZSkgPT0gNyk7DQo+ICsNCj4gKyAgICAvKg0KPiArICAgICAqIEluIGNh
c2UgdGhlIHJhbmdlIHN0YXJ0cyBpbiB0aGUgbWlkZGxlIG9mIGEgY29udGlndW91cyBwYWdlLCBu
ZWVkIHRvDQo+ICsgICAgICogcmV0dXJuIHRoZSBmaXJzdCBQVEUNCj4gKyAgICAgKi8NCj4gKyAg
ICBpZiAoUFRFX05FWFRfTEVWRUwocHRlKSA9PSA3KSB7DQo+ICsgICAgICAgIC8qIFVwZGF0ZSBw
YWdlX3NpemUgd2l0aCB0aGUgbGFyZ2UgUFRFIHBhZ2Ugc2l6ZSAqLw0KPiArICAgICAgICAqcGFn
ZV9zaXplID0gbGFyZ2VfcHRlX3BhZ2Vfc2l6ZShwdGUpOw0KPiArICAgIH0NCj4gKw0KPiArICAg
IHJldHVybiBwdGU7DQo+ICt9DQo+ICsNCj4gICAvKg0KPiAgICAqIFRvZ2dsZSBiZXR3ZWVuIGFk
ZHJlc3MgdHJhbnNsYXRpb24gYW5kIHBhc3N0aHJvdWdoIG1vZGVzIGJ5IGVuYWJsaW5nIHRoZQ0K
PiAgICAqIGNvcnJlc3BvbmRpbmcgbWVtb3J5IHJlZ2lvbnMuDQo+IGRpZmYgLS1naXQgYS9ody9p
Mzg2L2FtZF9pb21tdS5oIGIvaHcvaTM4Ni9hbWRfaW9tbXUuaA0KPiBpbmRleCBjODllN2RjOTk0
N2QuLmZjNGQyZjdhNDU3NSAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9hbWRfaW9tbXUuaA0KPiAr
KysgYi9ody9pMzg2L2FtZF9pb21tdS5oDQo+IEBAIC0yNSw2ICsyNSw4IEBADQo+ICAgI2luY2x1
ZGUgImh3L2kzODYveDg2LWlvbW11LmgiDQo+ICAgI2luY2x1ZGUgInFvbS9vYmplY3QuaCINCj4g
DQo+ICsjZGVmaW5lIEdFTk1BU0s2NChoLCBsKSAgKCgofjBVTEwpID4+ICg2MyAtIChoKSArIChs
KSkpIDw8IChsKSkNCj4gKw0KPiAgIC8qIENhcGFiaWxpdHkgcmVnaXN0ZXJzICovDQo+ICAgI2Rl
ZmluZSBBTURWSV9DQVBBQl9CQVJfTE9XICAgICAgICAgICAweDA0DQo+ICAgI2RlZmluZSBBTURW
SV9DQVBBQl9CQVJfSElHSCAgICAgICAgICAweDA4DQo+IEBAIC0xNzQsNiArMTc2LDQ2IEBADQo+
ICAgI2RlZmluZSBBTURWSV9HQVRTX01PREUgICAgICAgICAgICAgICAgICgyVUxMIDw8ICAxMikN
Cj4gICAjZGVmaW5lIEFNRFZJX0hBVFNfTU9ERSAgICAgICAgICAgICAgICAgKDJVTEwgPDwgIDEw
KQ0KPiANCj4gKy8qIFBhZ2UgVGFibGUgZm9ybWF0ICovDQo+ICsNCj4gKyNkZWZpbmUgQU1EVklf
UFRFX1BSICAgICAgICAgICAgICAgICAgICAoMVVMTCA8PCAwKQ0KPiArI2RlZmluZSBBTURWSV9Q
VEVfTkVYVF9MRVZFTF9NQVNLICAgICAgIEdFTk1BU0s2NCgxMSwgOSkNCj4gKw0KPiArI2RlZmlu
ZSBJT01NVV9QVEVfUFJFU0VOVChwdGUpICAgICAgICAgICgocHRlKSAmIEFNRFZJX1BURV9QUikN
Cj4gKw0KPiArLyogVXNpbmcgbGV2ZWw9MCBmb3IgbGVhZiBQVEUgYXQgNEsgcGFnZSBzaXplICov
DQo+ICsjZGVmaW5lIFBUX0xFVkVMX1NISUZUKGxldmVsKSAgICAgICAgICAgKDEyICsgKChsZXZl
bCkgKiA5KSkNCj4gKw0KPiArLyogUmV0dXJuIElPVkEgYml0IGdyb3VwIHVzZWQgdG8gaW5kZXgg
dGhlIFBhZ2UgVGFibGUgYXQgc3BlY2lmaWMgbGV2ZWwgKi8NCj4gKyNkZWZpbmUgUFRfTEVWRUxf
SU5ERVgobGV2ZWwsIGlvdmEpICAgICAoKChpb3ZhKSA+PiBQVF9MRVZFTF9TSElGVChsZXZlbCkp
ICYgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdFTk1BU0s2
NCg4LCAwKSkNCj4gKw0KPiArLyogUmV0dXJuIHRoZSBtYXggYWRkcmVzcyBmb3IgYSBzcGVjaWZp
ZWQgbGV2ZWwgaS5lLiBtYXhfb2FkZHIgKi8NCj4gKyNkZWZpbmUgUFRfTEVWRUxfTUFYX0FERFIo
eCkgICAgKCgoeCkgPCA1KSA/IFwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KCgxVUxMIDw8IFBUX0xFVkVMX1NISUZUKCh4ICsgMSkpKSAtIDEpIDogXA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAofigwVUxMKSkpDQo+ICsNCj4gKy8qIEV4dHJhY3QgdGhl
IE5leHRMZXZlbCBmaWVsZCBmcm9tIFBURS9QREUgKi8NCj4gKyNkZWZpbmUgUFRFX05FWFRfTEVW
RUwocHRlKSAgICAgKCgocHRlKSAmIEFNRFZJX1BURV9ORVhUX0xFVkVMX01BU0spID4+IDkpDQo+
ICsNCj4gKy8qIFRha2UgcGFnZSB0YWJsZSBsZXZlbCBhbmQgcmV0dXJuIGRlZmF1bHQgcGFnZXRh
YmxlIHNpemUgZm9yIGxldmVsICovDQo+ICsjZGVmaW5lIFBURV9MRVZFTF9QQUdFX1NJWkUobGV2
ZWwpICAgICAgKDFVTEwgPDwgKFBUX0xFVkVMX1NISUZUKGxldmVsKSkpDQo+ICsNCj4gKy8qDQo+
ICsgKiBSZXR1cm4gYWRkcmVzcyBvZiBsb3dlciBsZXZlbCBwYWdlIHRhYmxlIGVuY29kZWQgaW4g
UFRFIGFuZCBzcGVjaWZpZWQgYnkNCj4gKyAqIGN1cnJlbnQgbGV2ZWwgYW5kIGNvcnJlc3BvbmRp
bmcgSU9WQSBiaXQgZ3JvdXAgYXQgc3VjaCBsZXZlbC4NCj4gKyAqLw0KPiArI2RlZmluZSBORVhU
X1BURV9BRERSKHB0ZSwgbGV2ZWwsIGlvdmEpICgoKHB0ZSkgJiBBTURWSV9ERVZfUFRfUk9PVF9N
QVNLKSArIFwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoUFRf
TEVWRUxfSU5ERVgobGV2ZWwsIGlvdmEpICogOCkpDQo+ICsNCj4gKy8qDQo+ICsgKiBUYWtlIGEg
UFRFIHZhbHVlIHdpdGggbW9kZT0weDA3IGFuZCByZXR1cm4gdGhlIHBhZ2Ugc2l6ZSBpdCBlbmNv
ZGVzLg0KPiArICovDQo+ICsjZGVmaW5lIFBURV9MQVJHRV9QQUdFX1NJWkUocHRlKSAgICAoMVVM
TCA8PCAoMSArIGN0bzY0KCgocHRlKSB8IDB4ZmZmVUxMKSkpKQ0KPiArDQo+ICsvKiBSZXR1cm4g
bnVtYmVyIG9mIFBURXMgdG8gdXNlIGZvciBhIGdpdmVuIHBhZ2Ugc2l6ZSAoZXhwZWN0ZWQgcG93
ZXIgb2YgMikgKi8NCj4gKyNkZWZpbmUgUEFHRV9TSVpFX1BURV9DT1VOVChwZ3N6KSAgICAgICAo
MVVMTCA8PCAoKGN0ejY0KHBnc3opIC0gMTIpICUgOSkpDQo+ICsNCj4gICAvKiBJT1RMQiAqLw0K
PiAgICNkZWZpbmUgQU1EVklfSU9UTEJfTUFYX1NJWkUgMTAyNA0KPiAgICNkZWZpbmUgQU1EVklf
REVWSURfU0hJRlQgICAgMzYNCj4gLS0NCj4gMi40My41DQo+IA0KPiANCg==

