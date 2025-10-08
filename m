Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B3ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 11:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Rw8-0001Bh-S1; Wed, 08 Oct 2025 07:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v6Rw4-0001BC-2C
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:02:20 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v6Rw0-0001ND-Ke
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1759921336; x=1791457336;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=MIeCm3kE1QdRr7MA/6M0aCQufIuymbNRrsxuWzFvsNg=;
 b=fy+pANiJO5jKpl4LkaJj8r4raS2uAmKVzDUtFKf0nser3UOkE+JsZNex
 JX6HeQuh4qtA9yAhL45DYRFSBGW3y/8DP5dpi0cE+4VAln8x7uaFTq9Qj
 ygWWQI97e2kZfeoPIfmhAPuV62UlWLQ5GwGK3z/2LOBhI89GHB0/JDN80
 rLyBGPbZZLlDYu7Wn5f8cyvVMrF7CI7CvvORHajcJoedsDmhuufHesm4d
 BY1GPzhjir0RA3bho6iYaq2UqirYzZxGuH0kEmo6hRIVYEGA6t/5P0fwN
 G+nauyzt9dAy2KRC8yi+lrC8vEjtfkhIZKMzx1BhM0cu12G+gzfXp4jYB g==;
X-CSE-ConnectionGUID: z26CwKRQRSiatgC2SoQ9wg==
X-CSE-MsgGUID: j/zxgIpDS8mmD3hraTyNPw==
X-IronPort-AV: E=Sophos;i="6.19,323,1754949600"; d="scan'208";a="45771895"
X-MGA-submission: =?us-ascii?q?MDGrYZ9+paJvyXpylHEMG9RmBZEZ8/Y9WeqD5d?=
 =?us-ascii?q?iJo4ozwYiR4Ub0htAGGwWlLjvJmG1/AOGsGdICzpLkHfSSMIDX8TTpiY?=
 =?us-ascii?q?PXHlJ+vrj85ASoCkSqSgGLo2QKgVQFCPBDW49BIKKMZh2vkJaRUIfA+j?=
 =?us-ascii?q?U/r1vMeO+A9v0wL+FjhcOK2w=3D=3D?=
Received: from mail-swedencentralazon11013044.outbound.protection.outlook.com
 (HELO GVXPR05CU001.outbound.protection.outlook.com) ([52.101.83.44])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 08 Oct 2025 13:02:09 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qq8aOSgaMeThAYcYvL2O0cCBpjqOUdoZHGT8S8oMn34O+hTrrLxJvacigKjPrBb/Gbex2cH53QY2y3e26d0bdfRIcJQOcJA2WtBN55AE1N64ofdtyYgPHNuJBa93xC+e9Mu9abWDvcKtS3LltaDnrFgT66GSkWMlSmqG16XwlB6G3Utu4KLfmj3S6T77VkieEr36cEogarLvU6/H3KTg7AT5GrCQO4RO2uStxPsXQ1oB2l/TNm0pKwGHp4dAnyLznGR+BCPlpjOeWSb81JOsMKP/T3hAzIPCP7sI7kC3df+m9xcs2xRBwIiRdJ+dUe6LeOcBIk/ZlbgTOJkLDDlZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIeCm3kE1QdRr7MA/6M0aCQufIuymbNRrsxuWzFvsNg=;
 b=Ecb/TUzJcmM+dHNelIBVhC9poPd6CXWCO5NYEzpw5rN5ltwXCgmCazaBovcPn6wJUx8inVBAjy2B5NgEJsAUO2Dm+k6Akt5+gh5lU5NmdqC/DywlJzhwHMK1Hk7yOV2JTpZrPz9/GwxS1e+C8l1oWV1G2WCuqKY1mAusm7eSI7S0ll4rA654rd+d4/KCKxSlKZOEamMwFHGID6cH5ro5k7YvicOnXsVO1y/Ev4dU8qLGT49A0k6FiSLsPjvfFF1a7Ja/R57KnIZ3ZjaW0MEiN5lrtMgoRCeOmrFpaqjO8Hcnz5QfMh8wn7yUEN8IvLdjKm2+UAbJoP+AWBMVzgzgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIeCm3kE1QdRr7MA/6M0aCQufIuymbNRrsxuWzFvsNg=;
 b=CcUsgKBCrAnD7DNKmdLc9v0xwrBd5cGYOSff8l6PtXIiZuUC9NfLyHeaxtGelaTBEQwaAZraoy8ujJxPHCGN7yepps6mblZj8xfki7ub6s/NJJ6VUypmOaPq3su6mc2C1bUsnHX4P6/CJ5P/satONGv8iF8xeBp2xFvv/jAxnZFNTKmLsfgov2zWJdRJn9ybwD1mVr/gRqFVXMUPe7or9FuPgiipdqWS1SQhK0hAGkbkjzVPDM0sVv0tzp0DQ+LMxBL11jRyULUmWBFMhMQvwERfz64/Cg8fXiF0uIFueaJhrTtmomBNVGHi2b26xfnbHcz8C22htiUXEbR2EASiNg==
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com (2603:10a6:102:c0::19)
 by AM7PR07MB6818.eurprd07.prod.outlook.com (2603:10a6:20b:1c1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 11:02:03 +0000
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393]) by PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393%6]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 11:02:03 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 3/3] pci: Fix wrong parameter passing to
 pci_device_get_iommu_bus_devfn()
Thread-Topic: [PATCH v2 3/3] pci: Fix wrong parameter passing to
 pci_device_get_iommu_bus_devfn()
Thread-Index: AQHcMPMoeRgQPN6eLkedf4ydsrvAu7Ss5leAgAswkQCAAAzxgA==
Date: Wed, 8 Oct 2025 11:02:03 +0000
Message-ID: <7611de4ab83642550dac6f312a2cf3331f548f15.camel@eviden.com>
References: <20250929034206.439266-1-zhenzhong.duan@intel.com>
 <20250929034206.439266-4-zhenzhong.duan@intel.com>
 <a87df072-82a9-4913-a385-0458c3d0994a@redhat.com>
 <IA3PR11MB9136D667E09323B8E2DEF17F92E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136D667E09323B8E2DEF17F92E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7613:EE_|AM7PR07MB6818:EE_
x-ms-office365-filtering-correlation-id: 00a328e2-9c4b-4866-1818-08de065a1cbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ZFRKYzZCbm9XSHBvTWhyY1ZFQlQ2Z3krd2NNSG5CTy9OK0daUDIySFV6bzBo?=
 =?utf-8?B?WWkzUnMxSVhwRk84QmVoYlJSbXQ1dVZJL3B0T2pYQXI3Ky9WTzR0VjJPVEFx?=
 =?utf-8?B?OWFiR0ZEWDF2ZHIrYXR4L3hhVGFMTFVkSlBtNjFIb3htNExJU2ZUTlJUdVVn?=
 =?utf-8?B?cGN3NjQxVlg1ZlVKeTlVQXZ0SGNrVHFodGdTUDdHdmgrSVQ5bE81eldVb0Fv?=
 =?utf-8?B?OGNYNThCRm9VcERVcEt2WU1RbkYwejVMaXZwV2w1NWltRm45NUNPdFRDQm5Q?=
 =?utf-8?B?OFhUSUV1MUJybTVZVTZPSVZUdGd2NjFFbVhxWDNVL3NudFd0VjNKeHpJYWFv?=
 =?utf-8?B?cWsvNEZGWldrazRjT0tlWGRPYXN6R3dPSVpFdzlIREp3ZXdybWl1R2VpMzdM?=
 =?utf-8?B?bE9uOVh2R0xvTGV4aHJVT2JKanJkTHBpS2M4ZUI5YnRiTm02Q016Q3ZlR0dN?=
 =?utf-8?B?NThRVkNmdFBqQ0FJMUMycThOTlJYakxjY1I2dm1RRkFEeEp3akU3eTdGM2J0?=
 =?utf-8?B?TksrWCtzR0RrcDUvcVVMVlpGQWRpVEFUTFdHYjZPQlZOUlVCalZ3ZVdDTElK?=
 =?utf-8?B?QnFTb2lsamtGaGhBUEM3T25zZGFzRHptWVU5SnNRdlU1RVFjNGdieHhmMEJk?=
 =?utf-8?B?L3FDZTd3M2hIQ2hsVldVQlNMcTEvNGZnUU5PdWppV3VBbEt3VzlIYWtEVklS?=
 =?utf-8?B?UFlkRWtESlVMbEZxeVFXUnJZcURUdkV6dmx0WHpTL1l1L0oveHozL0tCdWxF?=
 =?utf-8?B?Zlp6dFdYV0p0WUVVWkpNMlNiRHBENXhyQnZFS3paVjZRSURGOURUMkRXY2xB?=
 =?utf-8?B?d0ZIZFVaWnNNeU5FY2o4WWpFTkFlNGN1emFSSCs4OFhUeHEvVitJZ0xqRVkz?=
 =?utf-8?B?dnovZXRaeGJqVk56ZWtuSlBMMHROOWtoNmY3dVVqQVVxcjZYL2NNUzNYMTYy?=
 =?utf-8?B?N2pQZHNlN1o4QWhEY2tjcmtkdk1STGVkL202ZnhnalE2UTdvUG1pS0ZqTmNN?=
 =?utf-8?B?OXVPM0tkcmpMSmo4RXQvYnJXZGZmRHJkWE1TOGJRcGFuWEg0U0psNWRtYWph?=
 =?utf-8?B?SUVxeVl4RDF4U1gzSERoM0cvU0ZNV1NpUU5udWFvd3pxc0s1RUxHNXV0LzNz?=
 =?utf-8?B?K3hTM2k5ODB4enVuMnM3U09ZNW1tcUR6Q1V5UFhaTm8rcFgvV1ZtemxOUmNv?=
 =?utf-8?B?UVk4RTNVUmZ6bzRzVFdwMisxWFdrSzhKTDNNMHhnYyt0ZFZhMTBOdm1laTh5?=
 =?utf-8?B?UFkvWWp5K09mb2NtRmNZejVzMDZsYXJKdlNwblJSWlhsQVhEbGFaMUhKNzBN?=
 =?utf-8?B?Z1R2UUxRdWNXWDRkUEozeUVLY3NGdzZPejd0Tk1INFJWOENVcFhkT0pvZHZJ?=
 =?utf-8?B?b3FLNW1zQStMa1p0a3VTOHhOSFhyWkhianV1QTJMTnZpcHhrV1dmcDNMM0I1?=
 =?utf-8?B?UkpCdnR1MWRsSjZQZm9ZSDNGdkRjVEo2bmxMTnJXYXI4aER5STdxRjlRZE9Y?=
 =?utf-8?B?bmdCQVRRS1lZTjdZQ3dpQjhKVkFoN0JNbjFpYjd6MDZvTGN4VStzdnVkV3dF?=
 =?utf-8?B?SGorNXVMZVJ2OWMvUG1qc3ZzQ0VYcHR3Mkg0S3VGNmFBYXhhdnpjL0xBc2Jy?=
 =?utf-8?B?dEprU2JKMk85QlJ3d2ZoMSsxd1FVUWJkUkkyNEJFZTE0ckVRbkF5Nmc4ZTBH?=
 =?utf-8?B?dUNoMkpCYjhyb25xWEtkOHYyQlYyWGRDY1IrZWVlOWlxcEtkQ0R6UFJvQmMw?=
 =?utf-8?B?MVZqRXhtUXJENjIrWXBzZ0lqWHZRdzJXcmNYa0ZpRkVPVVd0ZDhDU2k2VkxZ?=
 =?utf-8?B?T1B5TnE5MmUybEhTdWlWaU1XTExYVWNGQVFuOEhpRWdCM3Q5Rk1saitzTFRq?=
 =?utf-8?B?OVFNVldUU0NqVTA2SkRETlJEdTR6bjhSWlhmM1JoM1gxRFpWbjlqTVR5dFJn?=
 =?utf-8?B?eWxDcjgvMUVveXNVUUdoR1ZqeVlKM0FWUllETkN5K1F3YjJZdEkzNlVrSS81?=
 =?utf-8?B?SzFzQ09kRmJNZHk0ZHNVUkFZNzRwOHJlaFB1ek5WUzgyZGRoelgzQk5WdlRi?=
 =?utf-8?Q?UNEq9O?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7613.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1h3Q2VWdUlqVS9ZWXJJZlBnMHJrYnpoVGtYTDlnMGhwOFMyay9wY212WFpH?=
 =?utf-8?B?a3hXVkZZMGFyVDAvbHZmQlhGaDBpRlA2OUQ4NWdsMHlneEdENjNDSDU4MTZx?=
 =?utf-8?B?NTh4NW1YV1pLSUtWaGVPRGRiYmtDMW1NTHV0cE41TSsyRG1wVGlQUi9nc3pQ?=
 =?utf-8?B?T3RUTTYxQmduS3QvaWlJOExOaDAzYTI5TG1LMnovakNSMy9yOHQ5Tmo1NjNt?=
 =?utf-8?B?eHpma2lOS0FVbjVGNjF1dStmMEJScjdVelVqcUk3SFBjNUdRbmJHSUNGY1lh?=
 =?utf-8?B?U3cvdEI2bDhYSDZoWG9iNTVkdE1IMzRsa3NiVk5lYjFGNzNwdFpzWHVvWVpp?=
 =?utf-8?B?RlNQNk8zSjh0amVGY1E3dWNUcUlEc3h2OTNVSUdJMmYwZzU3UzNUaVluNVVl?=
 =?utf-8?B?NG1rZ2x6bWVndndKUjltb3V1Y3hMSlRqT202NGtBemEvclAwRk5UK0J3RmUr?=
 =?utf-8?B?NGhnN0tQbHBwRHR5cXVhaTFqNW8ybEhUZlJtR2t4WWRUUXA5alRSZ3ZZLzFo?=
 =?utf-8?B?cndkN1gxYUdxcS9KMjk4ZGhPeGl2RHM5MmtVSDdnV1VyTmFQTmw0V0hsUllz?=
 =?utf-8?B?ZExqNUdJUE84NW1xMEc1SkpYb0VKL2trVnhtK2wvRWRlcnVVeTEyZS9iYTlX?=
 =?utf-8?B?cXlpK3d2QW5kYXVBbHVHYTdCL3VsNVU4K3NGdHZvajZaNFVxamRsaiszUTBI?=
 =?utf-8?B?WnRIT0E3WUZCTmdQRHVOemVhLzE0bjJmWlhicmZNZWo2QnU0WG9Ic2hqeDJo?=
 =?utf-8?B?bXZLQVRzV3ZtaDBUZC9WY3B0VFVxejNXVk1XNHNnUnN1SldMcy8yMGlMQU4w?=
 =?utf-8?B?ZFArcXM1S3EvQWV2RmFRTDdidkVqS3lWaW4zREtCUEpySlRFcEw5Vzk1ZTJj?=
 =?utf-8?B?OGVrd0Q5NmhLZHJWeFAwZ0x0bzV1cTR2cnpTYVBNdGlWWDhmdEJnWmVJcmVs?=
 =?utf-8?B?Y0l3RFljbUVBaEN4VkZ1QjJzdHJnYUE1OUljRlJrbDdHSDJKV1B4ZUFRWXhG?=
 =?utf-8?B?TEhsK2tmRVcrZnY1c2p6NG1TL1N5eVpxQTZITm5XRC9OdWZVNW5tZjhkU3hI?=
 =?utf-8?B?S3FXWE9DZUw5MFJQa3lnb1hHT0FnajRiVGFRaDkwcGR3VC9vVFdCYS8wL2lu?=
 =?utf-8?B?Y3didmpVM3Q0WWVhWFBkR1pISmpYV1I0bXgyQmhxek9oMnA3VVluYkJyeXZC?=
 =?utf-8?B?bElscXIwTEVZWnJVKzd5djVYcHdMUVhFRGQzMUtRV2RDU3lNMHpDTVVlMkts?=
 =?utf-8?B?UlNrZGRMNS8yR2p4NHFISUprSU1pQTJXTkZIbXQ4WGRZTTV2M3NVZ01sUnBL?=
 =?utf-8?B?eHVJQWJWV2t2RFlwd2hSUzFYbWVCVWhVdkUxalp1Qm41bXNZWXBDTFhFUHc1?=
 =?utf-8?B?NmpVN3dEcXROUGhGa0phNGxVeFJLcWUzK0pLT0hMYUFsMnBxcXg2RU81em9B?=
 =?utf-8?B?M2M5TmVrK3h1YlRXWUZCNGhUZjUvRnkxR1RGNTZwT3VUcTBPVTNsNW1DVTkx?=
 =?utf-8?B?akplRTFLVkZjN0tKNGdFU045bFNDSXRMUEFMYStqZUY1cjEyeitxZEUydDFV?=
 =?utf-8?B?b3dDemk2UnUweThWS215T0Zmb0hCVG54VmV5SUJ4aElrWC9XQyt5RmVEL2hs?=
 =?utf-8?B?Mm9yTHhuOHFDN0pRYU9PalZHMEdnY0hBTWFkTEd1eTU0QjF6TUVMOHp0elRU?=
 =?utf-8?B?d0M3SWg5WDU4ZFRSV0RYSmJYN08vMGFpT1N3b2pvdHpWM3plUHZjcVQ5TkNM?=
 =?utf-8?B?QlZSWTZjSUppVmlmQ1RBMjI0S09YcVhMb1R6NDFoc1VRa3JLaVFjZkU1TU9x?=
 =?utf-8?B?WTI5aEJUVTl0cWxYd215L3hrSHhqRHlqenpDSEsvWmJtODJ0cGE3T0d2Y2lr?=
 =?utf-8?B?MFRKaTJGeVA2Q1dGcHE4NVE5MEJTZFpRZCt0Wk1QeVh5djVWRkhvVW9XOWw1?=
 =?utf-8?B?VHJWSFk2YnNoR2ZiV2RjeWJ3VkhlRmFoYkN2TkZsMDg2NzgxUldFZkFwTzg4?=
 =?utf-8?B?MkRCRDdSQnhldnZWTkJXQ2ZKL3NsY05nRGxOaGdMTy9MYzdsWFBUTGFpcjJo?=
 =?utf-8?B?STNPZVpXQU9hWUpiWHI5dnNqQ3Z4M3FOd1JrSkNFdWE1bFdCdFFvc1c3WWdC?=
 =?utf-8?B?QUNEck14d09LUzU3cy9GMVUvbVdGSktvTGFPWGdyTGoyTGd1N1JBUzRkQjVm?=
 =?utf-8?Q?eIIHBT05QYPO2P5EUHr45HA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B4159D1D7E1044789C6EA56C7F525D5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7613.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a328e2-9c4b-4866-1818-08de065a1cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 11:02:03.1920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDBqA2MXe8r0SjFxe7e9IXqufVj6fXEaSeUyoqziQZeT1twUk1mBXGMOe8gJbSlJv5blTKuUp4H40UsNEs0+UgFjlQOvpxnk9lyhCxNUxicDHQPUVPtvtCwLLEFc5kxh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6818
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

T24gV2VkLCAyMDI1LTEwLTA4IGF0IDEwOjE1ICswMDAwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6
DQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBD
w6lkcmljIExlIEdvYXRlciA8W2NsZ0ByZWRoYXQuY29tXShtYWlsdG86Y2xnQHJlZGhhdC5jb20p
Pg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy8zXSBwY2k6IEZpeCB3cm9uZyBwYXJhbWV0
ZXIgcGFzc2luZyB0bw0KPiA+IHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbigpDQo+ID4g
DQo+ID4gT24gOS8yOS8yNSAwNTo0MiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+ID4gDQo+ID4g
PiBUaGUgMm5kIHBhcmFtZXRlciBvZiBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oKSBh
Ym91dCByb290DQo+ID4gDQo+ID4gUENJQnVzDQo+ID4gDQo+ID4gPiBiYWNrZWQgYnkgYW4gSU9N
TVUgZm9yIHRoZSBQQ0kgZGV2aWNlLCB0aGUgM3JkIGlzIGFib3V0IGFsaWFzZWQgUENJQnVzDQo+
ID4gPiBvZiB0aGUgUENJIGRldmljZS4NCj4gPiA+IA0KPiA+ID4gTWVhbndoaWxlIHRoZSAzcmQg
YW5kIDR0aCBwYXJhbWV0ZXJzIGFyZSBvcHRpb25hbCwgcGFzcyBOVUxMIGlmIHRoZXkNCj4gPiA+
IGFyZSBub3QgbmVlZGVkLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcg
RHVhbiA8W3poZW56aG9uZy5kdWFuQGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbSk+DQo+ID4gDQo+ID4gDQo+ID4gVGhlIGNvbW1pdCBsb2cgc2hvdWxkIG1lbnRpb24g
cG90ZW50aWFsIGNvbnNlcXVlbmNlcyBvZiB0aGlzIGNoYW5nZS4NCj4gDQo+IA0KPiBXaXRob3V0
IGZpeCwgdGhlIGNhbGxiYWNrIGZ1bmN0aW9uIG1heSBub3QgYmUgY2FsbGVkIGFzIGlvbW11X29w
cyBpcyBzZXQgIA0KPiBmb3IgaW9tbXVfYnVzIHJhdGhlciB0aGFuIGJ1cy4gTHVja2lseSwgdGhl
cmUgaXMgbm8gdXNlciBvZiB0aG9zZSAgDQo+IGZ1bmN0aW9ucyB5ZXQsIHNvIG5vIHJlYWwgaXNz
dWUgY3VycmVudGx5Lg0KPiANCj4gDQo+IA0KPiA+IFdpbGwgdGhpcyBmaXggbmVlZCB0byBiZSBi
YWNrcG9ydGVkID8gdXAgdG8gfjkuMQ0KPiANCj4gDQo+IEkgdGhpbmsgbm8gbmVlZCwgQ2xlbWVu
dCBjb3VsZCBjb3JyZWN0IG1lIGlmIGFib3ZlIGV4cGxhbmF0aW9uIGlzIHdyb25nLg0KDQpUaGF0
J3MgY29ycmVjdCwgdGhhbmtzIFpoZW56aG9uZw0KDQo+IA0KPiBUaGFua3MgIA0KPiBaaGVuemhv
bmcNCj4g

