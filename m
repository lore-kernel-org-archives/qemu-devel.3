Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2431CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIAq-0000W3-4k; Tue, 04 Nov 2025 09:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGIAo-0000Ve-5K; Tue, 04 Nov 2025 09:38:14 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGIAk-00065o-5X; Tue, 04 Nov 2025 09:38:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyli9MyA2C98E292y5PwCjuX/wAqDn0+kAVQSjzmwbJN2elzHoQP9/v9eXAerL/HmqJMHJmYHxYopK05nfci4OVLYv5zsMNwLYVPsSRzWQ9CjeNxzkBhjdPxXkuv1EAwbcDJW5APBM93x/q2mUmpngPsB4MgA9Dr7hMG0BRELZzu6KldRPODf08obTPSu35j8B6yUH/RlbSiyif9BdmA3ymGY3HtziP53A3zrXW6z3clA6dD4KKfZnyg9aJREYwynLvA30QWXSJAEFLEGMa1o8dvvRgtD0nrpQ7DQe/APERg5c4OVn+/FRTXT/p/dtSCUrgW+lOWoifEBflRGWY1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdKwjHuVS4INx0fTYhRxN6D6gKg1dSgVmC7zPG1VZ18=;
 b=ZrInL7+lnkiZ8RSQ6oRsdMYaqGE0qwsDLcJS2cMsPs8S7463wD/k5SjG87eLuXQIWyYDKeBG8pkO0qYvOCONFWGqlbsxZzu+W+42HNbVZJ6RP1ZeOoieI721/khMJprxH1XFc5Y9plGt48XrJGjjrN+RJrcK2dFf1OH9EKd9XXv6LHZ6aq+imvSVxblSw7tF0fD9GGnnOP3ieS2m4z549mCNw501mA3byTdMzoM7PuFUqo6f3cLTntVO95PbaFjRmkCGiAmuNOz0coYZaoDHH6ClecO+7rbVOuO0B5UO61Ljzmt0OWLGZFiJWxrz1Jew3ZJczf1mE8KcKSEafkabTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdKwjHuVS4INx0fTYhRxN6D6gKg1dSgVmC7zPG1VZ18=;
 b=V1Qv9HF0u0wG2Or8hIocxA6BrzvB7OHFjHyDQ9WWvRu1bonHDeOzzVmRib4HLhPXrh3msxRfzX91dI89MCKSzMHqPFTyiN4NfS4AAUPKPwfS1FkhWsYwWOAVF3cpJl5ab4nvdKwyyMbX9X764HQP1XYfGEuhjHWaZd+sPqk+Q8VzalIShN/D0buNsgEKNzsilUyMTZXmCzuHUlJ1FssuwwgxrTxhsJvO/bwvD0AXDmiyxgcMCxe+vodOd7KP607ZimcPsawbEXCTkapoY4bsekOKK1ckOwj8XEOYb01S2u/4y5VR3GyNiMS3UTuT8Lo2Yj+Ecwt/HRbIdGFCkhSyAA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:37:40 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:37:39 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Topic: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Index: AQHcTZUAOcFtPNqTvke2OSuQhL/9/rTik/BQ
Date: Tue, 4 Nov 2025 14:37:39 +0000
Message-ID: <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
In-Reply-To: <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB6495:EE_
x-ms-office365-filtering-correlation-id: 5d3106d2-69a7-454e-dac8-08de1bafb4a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?czRnK1N2dm84ZDBLY0x3ZGtZb0NnUTkvcUlZZXNrcFJiRXlFRVdCdERUSnhU?=
 =?utf-8?B?czlxdlNPaFVXM1JpQUYyWHM0NVNTaU4rR0lJSkpPcmNMeGZkTGNDWHhlcEtT?=
 =?utf-8?B?bjNMKzhBQmRaUnFjOWJrMzI0Wk1UWUFRWkVJdjNnWDV5QjBiaER6eld4bUE0?=
 =?utf-8?B?UDh0dXM1c2VNQ25Vc1N5R2RseXpKaC9WODhLazhoZ1RlSmNDZFhIVElyVjQ5?=
 =?utf-8?B?amdWRUVwbHZTcWh6cTNmV1o5VDhsV3Q1cDdBYTRUYzYrK1o3M3hYMkMxZ1lJ?=
 =?utf-8?B?SDFlU1BSdGJQMEpjWDNzSkJjeTJDTjFKaTNQV1JMYURvSnFUSXRLNHdPcnha?=
 =?utf-8?B?Y21mdXVoZkFZanNLOE1lYWN5cGVheUY5RnRvMmRjTWZDT2ZITzA0RmxmNk82?=
 =?utf-8?B?RDBCcTdHNTBLTnp0RmFpUlBYeTdtM2RxNUZ4TnhNc1ZhVUUwTGZSNkN0SUE1?=
 =?utf-8?B?YnFUNFNwQmxrQ1FXV25qWnFQR2RxS0V0L0o2cDFxU2FleGFuN3ZUQVMxQzVv?=
 =?utf-8?B?a2pxSDY5Y1Evb2pCV1NOT3FOWHQ4UHBxRlZIZjVqUHk0MTdPWXYweG9lUjVp?=
 =?utf-8?B?dlhob3VUOVA0dWJQVDMvVXFjaGVWRVBaOXcwdVB0c3ZrREVKSE5PU0hWSGtQ?=
 =?utf-8?B?UDBwZ1c3T1hrQmc4WC9ZbXRJVDc4VzdPamxEczJOcXpmL25KcWUyb2FiM1Mz?=
 =?utf-8?B?bDVlU0NBTWNkaHpibktWRXBacllZRzRKMkRyMVVueXBGRWdyUU1nNkR6S3gv?=
 =?utf-8?B?K2Y3Tm5OdE5lbUE3blRXSlFEbXR2eStQeWFUR1ZJV25JVDVCNC9zcTFjN1Bs?=
 =?utf-8?B?NmJkRTAwclJGcktIVWYvTzl1NnBraW5zZG9tTzIrUkEwbmIwNzlGckMxMWpU?=
 =?utf-8?B?TWlVOFlXSjFjQndRU0g0blR2YU92UWlETjBBcTBwOUF2YTFKN0UvLzY2bkdl?=
 =?utf-8?B?UkhLYmZYR092bEtReXM1N1lKYWg3ZmZ5NSs0d2dBQ2R5UVFuTlBJRUd4UkRQ?=
 =?utf-8?B?MXVjL2FLblJUdnlUcTcvSGloTDloRWR1YlpCUGU0KzFpU0JDYWt3VkFJVFFZ?=
 =?utf-8?B?Sy82Y1ZoSDJIVFFRMFZsV0pvWDRxU0EzWFQwOGFwaFJ5KzQ4UkZLQnBieWll?=
 =?utf-8?B?NmZ6YVdaVDQ4SnZTaWE2dGdsWGNHZ0JjOXN3VWhUL20yYnpTZ0FsOUdsWmQy?=
 =?utf-8?B?VnFBeDlYbTNaOFowTnhLN3lxQVVRUktRSFR2dnVwZHBIemhxN0RSMDFEN2Ns?=
 =?utf-8?B?bGZSSHRnaWJoWGRxd09NZXh3UzErMGZFMzU0NFk2YmpCVkZIOTlWdElaRDBy?=
 =?utf-8?B?YzZrWHQ4a0ttRWVQUVBrdFJBVzVCQTd2RFFSbWFBN0VLUUxrdEdpTDBGZ09u?=
 =?utf-8?B?MWZsUGtMVjluSG55ZUpITVBteWYvbXFOaEsvYTVOdkluSXZma1NSeU5Ma3lt?=
 =?utf-8?B?NmNYNk1na1hsL3pqV2M0UmpNcWVjQ1JGSVZ2S2d0aTdWNi9kUTAzVmtoS2h4?=
 =?utf-8?B?NGc4Tzl3S091RG9KOFc3TlNkdm5vSE9NZHUwU1c3emhEenQyWjB1bzJCRFVw?=
 =?utf-8?B?eVNUYWVqZDd3b25uSnJOaHRycVNNV0g4LzFPTTFmaUN5Mk9LNTdjeTEzRWl3?=
 =?utf-8?B?Y3p4dEpEOWVKVXFVclAxaVpwLzY5QUI0c2Z5VFA4L2VReUw3Qkp4Q2hmaVh0?=
 =?utf-8?B?R2xzRmYxeGxPdDVyZ2ZCb215T2g5di81RjFpazZMOEN2dDJBcGNNcytUZjMr?=
 =?utf-8?B?QWdqck9MM3FySklWbmI1Y1RyeDRIVHpaWWo0UGR3b25kV3h1TTA3ZkpxWVVh?=
 =?utf-8?B?bUVwZ1g0aEVmNlF1MTdqNlYzejZ4WmdGWDBYYXNrdW9oblU0eEtxUDNPMlFH?=
 =?utf-8?B?M1V3QklTNmc3NCt1S2ExZnR3TzBvZUFhckRsdjRpa2ZiYmZtOCtmR3IzanFr?=
 =?utf-8?B?ZXJFdEYxdkFWbU4xUG9hMGF2WExPZW5ZMzUya1FqekVNVEZyeUtXOWFsTnZG?=
 =?utf-8?B?bzljNHZwT1JpN3RPcUwrbW5ZOFBEWGY0K1F4c1BkdkFiN1JSVGVYMTBDc3gw?=
 =?utf-8?Q?cxhlsh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KytjSTcrdTRoSVVMRnpPRHplbUozd21IY1NxQ3NjTUlKam5pL0pvZ1BSOFlI?=
 =?utf-8?B?WVZqc1VCcER0UzNrTlZUZE9KeCtiT05xUGljbDd3cVFvZG9JbmNPeDN1d09I?=
 =?utf-8?B?YVZadnNXckhzeHpyTUpzQmZXUk01ak92OWVJcm1RNllhNDFCbktMQVpkU3dV?=
 =?utf-8?B?RDVOMHNjV2VZUjh0dW1vQlBtV2NHcVVKL0NmQnViUlBTL1NYUC9YdUNydklP?=
 =?utf-8?B?OWcvb0JVQml2TE1qVUZzZnlvMnhSay8vc09QbG0vVlQ2NFVaYkNGTGJ5ck0r?=
 =?utf-8?B?ek5SM3NMcmRqU3NmUm9NaHFzZ1ZBN0ZWaXN1ZGxBL1h4NkxBNUE0T05VdC9N?=
 =?utf-8?B?b0o4eWxvNTdySnFIYzgwWnc3MWVsUEEzU2dCRjlVZk90NzdhVUlTSE5Bc1R0?=
 =?utf-8?B?ai9KdWhsaHZXNEJ1V1dQQWlpbFJ6UnRvTnhtUFJXKzRybkE1ZjNQQ1hoNDYw?=
 =?utf-8?B?UnhXYytmNElvWGNtalZBdnZaaHBVbUVRZmRPQWdCTkhvRzBBcTZiM0Vvd1l4?=
 =?utf-8?B?d0IvUEFIKzFlTXBkR1JKcU5KaWsvRGtjRkQ1aUxlVERnSkRuQ2Z0ZzIrbGN5?=
 =?utf-8?B?TTdoL3phcHd3UXpPc2cxb1hQckxOcHBkZDVUelpFeFJWS1N6d3VHNWxrOE5W?=
 =?utf-8?B?UkhtR3RHbmRzbkhYbDk1N25HMjd0Z1JvVW8yUTJ2cFdWbTBvRWpNN0ovTHR5?=
 =?utf-8?B?TzJ1Nm1Ea2Z2YXh2ZVBNZDFScHVrQTloVkNDVG90Rm1uUXprQjJ6ckJlbFY1?=
 =?utf-8?B?c3JKZ3BhR2dMeGpjZFdROUxNdkkzMEIwRU5Kb1BZakpKU1FYaUs4ZDlFM3Vv?=
 =?utf-8?B?NEFMSlhNWFlNTkI3dzZSTTV5T3NkRk9EQnpzaFgxVjRYd09kV1o1K1NlNFJ2?=
 =?utf-8?B?c3N2cEVmSk4zeDJTZitaeFFEd3lvL29xR1FheTJEUkJPeDFlS1U4NWZTWUxT?=
 =?utf-8?B?c3A2NGtGY2hUTEx4VSt4Nk9CNkVZci9TT3RhT1luekQ4KzJZYjhXamsxYU04?=
 =?utf-8?B?Q2czKzFCaUo4KzBITVNXZVN2TVRsdFMwb1pmeGd6dWdKL1F0aDVSQXV1Y0pw?=
 =?utf-8?B?OGJVZ29aNTlEOHM3dlFNV3N1QnV3cUswdHJSd3Q5VnpBZUNPMzBseUZGNm1p?=
 =?utf-8?B?czlPZ2h1VjU4S2pqSHcxUmxhSzBuRHBPN2lmcE1rZkZIa3FvbWxqZlMvRXQ4?=
 =?utf-8?B?aVV6RzZXRFgyMExHTlIwT09xUXlKQ2NVcXltaWFNanc4djk2czFMVUlyVXBF?=
 =?utf-8?B?a2xpYVhZSlhCaEhDeHloK0tSZWZIck95dnZuclNKWVZqVlM1SU4yL05mZGh0?=
 =?utf-8?B?eU96ZXpLN0hRZHlkam1qWlVtNEEyWDd2SzJxOFdkYWJzeGJNMm1wdFllR0VF?=
 =?utf-8?B?cUQzYTgyeW9TdUhGMVR2WXExejVrMUJqa093TWg2Z29GTWs4c29sR01ab1I3?=
 =?utf-8?B?dlNzZVlGNURjVFNSZlg2cHdnK1ZlK29kUnFsZTJpSkN3QkdzMS90UWNuZndJ?=
 =?utf-8?B?N0VubWFZVW5IZFFPc3NCTjMwUVEvaFhFQ0NVTW4yOG54TWNWRzZrVVBqYzVG?=
 =?utf-8?B?SFN3MENSK3FTWEJmTWxBNllxdFA1SW9ZNTJ3dFhXSWo4WDFyekU3a01Ma0FJ?=
 =?utf-8?B?NnpNZGRQZE8yTExmdkV6WldSZzcxNm11VzIzQkdvQmNROFUraDM5dnAxbUlD?=
 =?utf-8?B?SGF6a3FCOEtxZTRYZkFWa25uOWpsdjRqKzlyL1N1V2VQbWhQMlRROEc4VFE5?=
 =?utf-8?B?M2QwenVuVUhXUzRFd2l3WFZicUNWQTltZVVTdHRBOEltamtiOFRjVGlGZFNO?=
 =?utf-8?B?a1RRUmRDdDZjRVRpRkswQWFVbjVTZkNWb29FWEx0dWtJRC9pQWRCMnoxbnBw?=
 =?utf-8?B?NW1CUEU0dXhNYThFNTducGFzUjJyclRPeDhGN2F3QTdFMDVzRWdIdFFhM2F1?=
 =?utf-8?B?azdCUEcvVHJWSE9TOUVXUG42UGJ5anllLzlxVnpxS1R5akpTdkMxOEx0bytl?=
 =?utf-8?B?QzBNTVRiYnVTSk9HUUtRblFJSDdaMVhoWjArajhEWXNFeWY3V294Z1ZpbnVZ?=
 =?utf-8?B?UURsbmd3ZnBzRDdKc3JUdVhsNFNjWnExK3g1dVZzWHNPckVocXhRNm1GSG9F?=
 =?utf-8?Q?HcIckCd8wgNARpdV5NhLzk3QY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3106d2-69a7-454e-dac8-08de1bafb4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 14:37:39.6856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4BivFZNg38E2CoPuuSNKxCegVU1rIJrsRE5JHsveHV6aCx9Yz+fGY7dE8ZoVm5Yq6SW8PBacT9QQurICOihkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA0IE5vdmVtYmVyIDIwMjUgMTQ6
MTINCj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVt
dS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmlj
b2xpbg0KPiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOyBi
ZXJyYW5nZUByZWRoYXQuY29tOw0KPiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsg
TWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsNCj4gc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2Fu
Z3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0KPiBLcmlzaG5ha2FudCBKYWp1
IDxramFqdUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDE1LzMyXSBody9w
Y2kvcGNpOiBJbnRyb2R1Y2Ugb3B0aW9uYWwNCj4gZ2V0X21zaV9hZGRyZXNzX3NwYWNlKCkgY2Fs
bGJhY2sNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9y
IGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gSGkgU2hhbWVlciwgTmljb2xpbiwNCj4gDQo+IE9uIDEw
LzMxLzI1IDExOjQ5IEFNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IE9uIEFSTSwgZGV2
aWNlcyBiZWhpbmQgYW4gSU9NTVUgaGF2ZSB0aGVpciBNU0kgZG9vcmJlbGwgYWRkcmVzc2VzDQo+
ID4gdHJhbnNsYXRlZCBieSB0aGUgSU9NTVUuIEluIG5lc3RlZCBtb2RlLCB0aGlzIHRyYW5zbGF0
aW9uIGhhcHBlbnMgaW4NCj4gPiB0d28gc3RhZ2VzIChnSU9WQSDihpIgZ1BBIOKGkiBJVFMgcGFn
ZSkuDQo+ID4NCj4gPiBJbiBhY2NlbGVyYXRlZCBTTU1VdjMgbW9kZSwgYm90aCBzdGFnZXMgYXJl
IGhhbmRsZWQgYnkgaGFyZHdhcmUsIHNvDQo+ID4gZ2V0X2FkZHJlc3Nfc3BhY2UoKSByZXR1cm5z
IHRoZSBzeXN0ZW0gYWRkcmVzcyBzcGFjZSBzbyB0aGF0IFZGSU8NCj4gPiBjYW4gc2V0dXAgc3Rh
Z2UtMiBtYXBwaW5ncyBmb3Igc3lzdGVtIGFkZHJlc3Mgc3BhY2UuDQo+IA0KPiBTb3JyeSBidXQg
SSBzdGlsbCBkb24ndCBjYXRjaCB0aGUgYWJvdmUuIENhbiB5b3UgZXhwbGFpbiAobW9zdCBwcm9i
YWJseQ0KPiBhZ2Fpbikgd2h5IHRoaXMgaXMgYSByZXF1aXJlbWVudCB0byByZXR1cm4gdGhlIHN5
c3RlbSBhcyBzbyB0aGF0IFZGSU8NCj4gY2FuIHNldHVwIHN0YWdlLTIgbWFwcGluZ3MgZm9yIHN5
c3RlbSBhZGRyZXNzIHNwYWNlLiBJIGFtIHNvcnJ5IGZvcg0KPiBpbnNpc3RpbmcgKGF0IHRoZSBy
aXNrIG9mIGJlaW5nIHN0dWJib3JuIG9yIGR1bWIpIGJ1dCBJIGZhaWwgdG8NCj4gdW5kZXJzdGFu
ZCB0aGUgcmVxdWlyZW1lbnQuIEFzIGZhciBhcyBJIHJlbWVtYmVyIHRoZSB3YXkgSSBpbnRlZ3Jh
dGVkIGl0DQo+IGF0IHRoZSBvbGQgdGltZXMgZGlkIG5vdCByZXF1aXJlIHRoYXQgY2hhbmdlOg0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMTA0MTExMjA5MTIuMTU3NzAtMS0NCj4g
ZXJpYy5hdWdlckByZWRoYXQuY29tLw0KPiBJIHVzZWQgYSB2ZmlvX3ByZXJlZ19saXN0ZW5lciB0
byBmb3JjZSB0aGUgUzIgbWFwcGluZy4NCg0KWWVzIEkgcmVtZW1iZXIgdGhhdC4NCg0KPiANCj4g
V2hhdCBoYXMgY2hhbmdlZCB0aGF0IGZvcmNlcyB1cyBub3cgdG8gaGF2ZSB0aGlzIGd5bQ0KDQpU
aGlzIGFwcHJvYWNoIGFjaGlldmVzIHRoZSBzYW1lIG91dGNvbWUsIGJ1dCB0aHJvdWdoIGEgDQpk
aWZmZXJlbnQgbWVjaGFuaXNtLiBSZXR1cm5pbmcgdGhlIHN5c3RlbSBhZGRyZXNzIHNwYWNlDQpo
ZXJlIGVuc3VyZXMgdGhhdCBWRklPIHNldHMgdXAgdGhlIFN0YWdlLTIgbWFwcGluZ3MgZm9yIA0K
ZGV2aWNlcyBiZWhpbmQgdGhlIGFjY2VsZXJhdGVkIFNNTVV2My4NCg0KSSB0aGluaywgdGhpcyBt
YWtlcyBzZW5zZSBiZWNhdXNlLCBpbiB0aGUgYWNjZWxlcmF0ZWQgY2FzZSwgdGhlDQpkZXZpY2Ug
aXMgbm8gbG9uZ2VyIG1hbmFnZWQgYnkgUUVNVeKAmXMgU01NVXYzIG1vZGVsLiBUaGUNCmd1ZXN0
IG93bnMgdGhlIFN0YWdlLTEgY29udGV4dCwgYW5kIHRoZSBob3N0IChWRklPKSBpcyByZXNwb25z
aWJsZQ0KZm9yIGVzdGFibGlzaGluZyB0aGUgU3RhZ2UtMiBtYXBwaW5ncyBhY2NvcmRpbmdseS4g
DQoNCkRvIHlvdSBzZWUgYW55IGlzc3VlcyB3aXRoIHRoaXMgYXBwcm9hY2g/DQoNClRoYW5rcywN
ClNoYW1lZXINCg==

