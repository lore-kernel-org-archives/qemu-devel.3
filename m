Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514E1D29C50
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 17:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhsxN-0004Af-SZ; Mon, 19 Jan 2026 12:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vhsxJ-00049b-3C; Mon, 19 Jan 2026 12:22:21 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vhsxG-0007CY-80; Mon, 19 Jan 2026 12:22:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgvToPyhONVNCq3c20X3bASgKKtmepPUsxm4kJHAA7ZjZrbn2h97J31adZ+Ve5+qQqPc1/IQdGHX5D08CPNAE1ql5jijwbRQySFflAl95tC7WVBrdbnBpyHSe/h/66zNrMnXURxLLgLJc+d0Uec/pj944wmsLL8SGUT+O5TEBOki++SOUCsHXYDo9gfnTm7teB90hWZMJMPp8q+LRiIfD9loNTRRceBfgyv9oKOvl0QdtOvg+Mo02fO3rXGJNbh30uHSHkQwDm/t9rUEJONjOj19ha0wHoTdTfGrHrwFG4WXSBa8q1Gp2ssjs/4jH6GrF7/JZNWT7o/oAmmSGZNDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DadAqLBKgUw15LHQVEykjc1A/o3N4QZYP41+PLCvWC0=;
 b=Y4COLsD9CRuuy7ty5TKssG2ryQ/cSw2FppMnaGIu64ioCxTYYgbG7v/5W5t/E0K+erpwYqiR39FNXnZC8nb2ctoV6qVbWhi5sWkxPbeUO7tD8WcewX6O2l9ulBcrYy05Dxt6E5FuPRS4OvwXCVMdVTF9uFShMAT6enoXuZNVCoGnUVk+j4BHnuzKfelx4H7QXq8AY26xBXWtOsak4E7ScoprulG6699LtaFaCKe+K1tiAESHT6TUcOzDfJGDn1RDUEDWZW4Zkmmxcfi6qmMLUXVvNz2RvNpBcJ+YBPMWpOVeyM07XvoOexwrnmgMQ2s5QdfJJ/NMvl+/AO+xpILSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DadAqLBKgUw15LHQVEykjc1A/o3N4QZYP41+PLCvWC0=;
 b=dVNRhaqLTGHQ/cLZBIO+K/XwrJkSLCX0C0nW56uBkkcRXqZokzbfmPHQLw4yXusaA1VuXC8YmcL9f3xB3bgPip4EkqJINvR1ZVMcIXOCXJjB/K3ZuxKTYf9y9rC+rra5/9fjVCaP2jhHtsu5oMACySyJHlVJ8donjIwF9T/LLSpAYprHDREBxy7/nwMXY2oEjtsu7jDov4OJWmUi19V8gZafukh66T7E1vc/KmSErNnSoTOqz+xReQjbmI20UirqK0yWD9apRR0eT9XAE0XQgdAclsoecHzuvi9V0aML0uQibJvoO6kOtrVwOsbaEWBX5jpJ+jYukPDv2Ag8D6lgWg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Mon, 19 Jan
 2026 17:22:11 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 17:22:10 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v7 35/36] hw/vfio/pci: Synthesize PASID capability for
 vfio-pci devices
Thread-Topic: [PATCH v7 35/36] hw/vfio/pci: Synthesize PASID capability for
 vfio-pci devices
Thread-Index: AQHciV8E3jo8a+wKEUiJWDVa5+dzprVZvCRg
Date: Mon, 19 Jan 2026 17:22:10 +0000
Message-ID: <CH3PR12MB7548AB6F73A2143E1B01E5C4AB88A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-36-skolothumtho@nvidia.com>
 <d285998e-0250-40eb-97a3-996d5471abac@redhat.com>
In-Reply-To: <d285998e-0250-40eb-97a3-996d5471abac@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB8064:EE_
x-ms-office365-filtering-correlation-id: b511a317-94fd-44c5-1fa6-08de577f47b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Y2FHclpHSHpLZitVMEtPQTRocEdMSHp5cXBNc0RJTUl3dkxISExTQVNLVEtU?=
 =?utf-8?B?VldHQ0JPS2dMYWxGY2ZBTUpMWjVzTVlCNDBWLy9Gc3dKSkxDdUxnOCtQQ1Np?=
 =?utf-8?B?VXhINWpEd1g0RlVwb3h3d091ajVPdXFJcnhXcHdEMEM0SlQ1clMzS1BiQzBa?=
 =?utf-8?B?RGlkS1lhTFlwU3lxeVJlV204R3lKbjBIYWpNSHgwa2hyNjF2YWQ1a3VZZzNZ?=
 =?utf-8?B?bTBGdDZMMk42bFBPQlpNK0ZieE1ZSG0xYVFtckNVa3NNT1I5STBBOENkQW9m?=
 =?utf-8?B?NjA0b0dQZ3VNekJWSHEycW1GMnd1aXM1amkxUzRZd1dYMHlVT3JRTkpjeDBZ?=
 =?utf-8?B?dkxIYkFKM2xxRmdaVTRrTFhWcXRPd3Joak03VmlWMkwwOHV5Ykk4Zkcrc1NV?=
 =?utf-8?B?bXVLTHVoZW16V3g5WHY1WlY1cjdoS3lIL29uSUpEZW5EQkFNMTFyVjFzZkV0?=
 =?utf-8?B?S0VON2tLeHBiVEFFZEU0c2pZeFlxeTBweDhZUTYvZjRMUEt4ZXBOTS93NzBB?=
 =?utf-8?B?ZityUzQrMmQxZndZaHM2TjM3eDNlTE80dzMwcWJaZjB1aksxNkxjRVZtS3hE?=
 =?utf-8?B?VG54OGpZSmJ6YnZNblpSVytsUENlbkIwYXZrQTNJZHp2dXpVMTY5QjVCbjRM?=
 =?utf-8?B?OFpRVXRXdTBFZ3pOQUFiK21GeEpEUEU4amY0SnNXMW1iL1BBRlg4YXR3MVdz?=
 =?utf-8?B?cXhjVDJDV1MyalJWeE1ldytaakhqS0U0VzJDeCtWVlFyMnlXT2ZsaXJQT0lN?=
 =?utf-8?B?SDNOVUpYMXd5eWUxSVE1NnNYOTNab1lnZkxhYmhGTGdrajJreUFuaTM5bTRC?=
 =?utf-8?B?aUdUcXNFUGt6VXAxYmFMWlM3RWwxQ2xZcFJHbXVHQUhpTk8xc1hwMWJ4b1g0?=
 =?utf-8?B?V1E0ajE0ckkxS3o3Q0JqM0IreEcxdFBNeW1SR1QwS1pnR0JMTDlvUXdKZ01s?=
 =?utf-8?B?ZXdMMS9KTTBpVGd1c0pTeTR0UzhLMDdXRjNRalZFdk5CU3QyWFVWQzB5ZDZR?=
 =?utf-8?B?dE5qSlNwQmhZbXFUbGxYQjMwcXI2YmpDY1JpZ3RENmlHRGZwUlRWNkF5OG1Y?=
 =?utf-8?B?akNtekFTNlNBcTIwUlFwbVM5RCtNb0Y3eVIxR01uTkJDd3JQNG0zUUlxL3pY?=
 =?utf-8?B?UkhsOFlSYXkxOWlvaGwzTDFhSjlpVHhQSlEvekloalhJcVFCMThUZkx6c2VV?=
 =?utf-8?B?bHFpd1RSV0Y1RFNCVUxZL0lmZlBLNWd0d2pSZEt0ZjdRNVNBdTVtUDYreHdH?=
 =?utf-8?B?TEFaejZJeldYUEV1U0xtZzNnN1drS0l4L0FBM2ZYM01uRU90eFcvWGF2NFdx?=
 =?utf-8?B?NTVlS1VabElhbXJKenhlMlhpbWtVSjFuc25tc0xJQWErWUphYmtyOXc4WWY4?=
 =?utf-8?B?cDhaUm5UQTEyUHE2dWNuSnpDMy93aEcveTh2QTNlYWlHelRHT3FzeFBYeVFt?=
 =?utf-8?B?RFU2dmUvVkdzb1o2UHludWZxVE42ZURwTW5UREUrb0hmVHZGNi95cFlFa3ZS?=
 =?utf-8?B?L2crQWhFS1JBQ0ovRHRHdUcvWHhRajZPZ2JJYWN1TCtMYXlqeHl5UEI3Y3oy?=
 =?utf-8?B?Z1JNVXlPcGN6R3FJUllVTVZDTUlGSTJ3alJ4Q1Z4N3dJSTdCRUFjcjBsTWxF?=
 =?utf-8?B?WEhPTHdpZjJWbUNBMjY1MmVqQmxEOFdwZ3J0MmUrdGgyTkp5SVFZVWZGMXlt?=
 =?utf-8?B?VjhUc0xzQWg3Z05CWVVUTkhDMElDTjlIMmxhbzlzOXc5bzJrY3MxNDlkRW00?=
 =?utf-8?B?cmNYd0xsaVJCeHRSVHg1UWswQVgyczZlaFcwWG0zSHJGOEJhV21aRjNlNnpK?=
 =?utf-8?B?RU9YRVBtMTN1a3ZkL0FqdFVYcWMramR0cHJNMkRLMi9mdFhZbWtBQ1ZkV3Jz?=
 =?utf-8?B?czd0d0FUUkNDcTJxQzNjZHZsWmxvYU9YRGREalpEemNoRjRFaUpZTVBpNXR0?=
 =?utf-8?B?cXZFamhrdy85MDFlUkw4dmppczJieWtLaEZITWlmSWZRMlpHc01pdE0zdkpP?=
 =?utf-8?B?UnJYNDN1b1NMSkFKRXpIUjZMVURYbXp4UU9FV0llWU0zUUVpSFNqK28zbzd4?=
 =?utf-8?B?Rms5THVmSEN6akpoL2Ntdm5iYnp1Y051WDZCV3NMNUxGQW1LWGEwZngwZUgx?=
 =?utf-8?B?QnB4STVyY1BrUU9EMVVJL1VPMkk2WWxXSzFCZUU4RWsxM1JHTFFreWRCYVRX?=
 =?utf-8?Q?sWNexKhyrBEDpQFxtnbEeqY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGU5R1J6WDBZWXREdjZ1TGtnMVlKTlJTckcxSTlBdmVaUG1wY3ZLMWpJN3Yw?=
 =?utf-8?B?dVVBaFdPZU5ITHE4RWl4Wk82SXV4dmczZFI0VWpHOE16akVzR0ZQaXlPaXVC?=
 =?utf-8?B?bDQwK2FoYzZVVHJ3QjVyc2ZUNVB1cktqb0Z5WjBUT051cXF3M2kvVXAxMTlt?=
 =?utf-8?B?MXllREFLZjhZdHl5b0M2QklZa2tZc1puSzZoU05pODRNUmZUK3lIUDhuVlNJ?=
 =?utf-8?B?TkJxK1g5TXVBWHAzTUxFa3BSQ1RoRHFQeVJ3OE1NT01rZDYzUnZDdlh2Z3d3?=
 =?utf-8?B?c2NJYnBwMUxUb3Vvc29oRTFJZmJyc01QeGJQQlNscnk0Ri8veFZHZkIxQkNz?=
 =?utf-8?B?UmE2VFllUmtMMTM2ZWNIeDliYnl0cFBZVVdZMXUwM0ZnTkVGRHM2cjM1NWZ3?=
 =?utf-8?B?Sk1uS2YvTHAzMUZ3bTVvV0FCYW1oR0RpRzh1Zm9rclF0bTNDU1o1WkNudDBq?=
 =?utf-8?B?YWROZ1FJRmpVQ1k2aU1Ec0U1NWsrSmsyVE5HMW1tY3ZwUFpQNmwwc2dCVWNY?=
 =?utf-8?B?Rzg3YkFLSkNuTEM2NmdwaTZ2UkFYR3BmeCs4dzd6MkVhSE1BYkJIZWE5K1RI?=
 =?utf-8?B?SlBWUG9DRGo5Wm9YR1FRc0ZIRkU3ZU5IczE1NzB1UTVYNWpxVm1DZUJMWXho?=
 =?utf-8?B?WVpnRUp5TG9SRG9uRTB6b0JzNVlCcDBLMXM5TGJCaCtMa2ZWdGpydm92V3hi?=
 =?utf-8?B?cDZkQVcrS2VhMWpzcGJGbGpoK3h4ZkdoUmpSZVliZVhYRUlSVitJMjFtb1Za?=
 =?utf-8?B?aHA5SUhPc3JwTDdnYmpKTGd0Z0t2czIrdFRFeWYvbExEYytFT2JIZWlNdzdt?=
 =?utf-8?B?ZFRpNHpTdittVjRGSFBBZHgrd0xYK0xtWCtSQUI0RERwT3BacVpoUEFOczdM?=
 =?utf-8?B?eXBKUlZuQW56WkJML0NGaWJ0MmZnRktuUzNlNVNpbWhyeDBWMkdzUjBGUlNq?=
 =?utf-8?B?UXNLQncxb1hyUUVhODlzRldsNmRJK01vVHVHNUtSYnltd2NqQ05ZblBhZ1V5?=
 =?utf-8?B?cE15VFNFdCt1TEc0eXIzSGdnbHE4Q2RVVndxa3JtWWpuQVN2UW5YZWNXY2xn?=
 =?utf-8?B?UlE5alM0cDlEZXh2VkJlS1BvTkZtekVTdUhhd0RDWWNKL2RnR1BXbThlSE1n?=
 =?utf-8?B?Lzluc29KZUE3a1pPMGU4UEdncUNXU2k3amRQU2wxWlhmOVdELyt6cG5mOFJT?=
 =?utf-8?B?U1ZhcHdwZ0E3VWpxTjdXdXN0QTFrK1Y5aVhLeHhOaWt3NmZVVGRUWExmNGRT?=
 =?utf-8?B?c0Q0ZUJvN0hLWkxLRWNiSjJ1SytHbERhY1d5bzJrMEhQQjRPSzZwUFcwQ0hS?=
 =?utf-8?B?TVl4UUZvdUJpcVN6TmJVbUpWMTVwM1hrK3pLcEQ4ZTJFN3RFWTZTMTdINFA2?=
 =?utf-8?B?anV2Z2JubjJEK205bitXb2djZXdMNFRQNDFRb1NCRlRqRHl0NGZvaStCUkk5?=
 =?utf-8?B?ME9zYS9zRDdzMDczSEU2eGh3cC92QUJjbEtxN3RVZ0RxM05Fb0diVU9sbGN3?=
 =?utf-8?B?UXk3SU0vc25lUGgzMWhWNnRpVmlSUldiSzhHNElrM1pFQ2hwUEdnUXB0WVdl?=
 =?utf-8?B?di9DNisxeURPMmZtUnV5OWZ6NmRVTlB5K2FmZFhUK3c3ZEF3eGF4MnRTWTNU?=
 =?utf-8?B?U25ENkNCTmRhRW40dkEydlRqRFY2dTFYUUJIR01vZENWdS9MY0Fic29HRTAz?=
 =?utf-8?B?ZlBtMWpXY0JVVWF4ZlNKaVJuV0NEZklmaEVFdDNybWNmRDdXRjBCY0JBZExq?=
 =?utf-8?B?aHVLRWEzWVgvcTZVUERTTGVHazgxRkIvSjlSVHNtcS9JSUhFM1hocVExWHBU?=
 =?utf-8?B?R1J5NHVhOFJCZVNIK1c1UHZ0d2lUeDByNVR3TDQ3V09YdUJJZ3RkdWFnQWx3?=
 =?utf-8?B?TkVOUXpqYWdiRnBxUTZiL0lhUk5udDJmYmhrYk4ydG85bldpbHQ0Z2ZWVGlM?=
 =?utf-8?B?Z29aL042cW9mRXhxZ08vcUdFejM2YWtVUWc2OHBSU0l6Vllxc0hjZGcwTUtX?=
 =?utf-8?B?QXh6T3VHelRwd01td1huSU9ncStIaVJvVXpHditxSk5EL3V5TmdCQmdwbmt2?=
 =?utf-8?B?Tm8yM1BwM01LYy94V256TWRNdnVrVGx3K0s2Zk5TL1g0MU9XS29tb3VLVXBM?=
 =?utf-8?B?M1NMN2dhb1N5WGR0VGRCcm5VcTExL1VEM3RxVDJEQS9LNEtjK25yb2gwMUY4?=
 =?utf-8?B?dXNyOHhlRFYyU2J6bVNPZytiSGRrbWcvUmFTMjdhdVZ4RkJwWDV0RHUyN3hv?=
 =?utf-8?B?Ujhpa2xpMUhjVG8zdWxqRXVtak83ekxtWjhuNHhKNE1Lc0Y5cEIycnVubDVF?=
 =?utf-8?B?UXplak1rV3AvOS9CQjhFMlBmaU44YlBIcVpVSVlxNGxUNTEyMUgvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b511a317-94fd-44c5-1fa6-08de577f47b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 17:22:10.7425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ub/d2Nhh2jL+pY7MdnuAItBMYWilBybryIC/s6dzxtLuXVCNme5E+gRjZScy8oPDPWvEHFXOu908u9YHJx0tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxOSBKYW51YXJ5IDIwMjYgMTY6MTcNCj4gVG86
IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVtdS0NCj4gYXJt
QG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbg0KPiBD
aGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUBy
ZWRoYXQuY29tOw0KPiBjbGdAcmVkaGF0LmNvbTsgYWxleEBzaGF6Ym90Lm9yZzsgTmF0aGFuIENo
ZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47DQo+IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47
IHNtb3N0YWZhQGdvb2dsZS5jb207DQo+IHdhbmd6aG91MUBoaXNpbGljb24uY29tOyBqaWFuZ2t1
bmt1bkBodWF3ZWkuY29tOw0KPiBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207IHpoYW5nZmVp
Lmdhb0BsaW5hcm8ub3JnOw0KPiB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207IHlpLmwubGl1QGlu
dGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NyAzNS8zNl0gaHcvdmZpby9wY2k6IFN5bnRoZXNpemUgUEFTSUQgY2Fw
YWJpbGl0eSBmb3INCj4gdmZpby1wY2kgZGV2aWNlcw0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVz
ZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBIaSBTaGFt
ZWVyLA0KPiANCj4gT24gMS8xMS8yNiA4OjUzIFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0K
PiA+IEFkZCBzdXBwb3J0IGZvciBzeW50aGVzaXppbmcgYSBQQ0llIFBBU0lEIGV4dGVuZGVkIGNh
cGFiaWxpdHkgZm9yDQo+ID4gdmZpby1wY2kgZGV2aWNlcyB3aGVuIFBBU0lEIGlzIGVuYWJsZWQg
dmlhIGEgdklPTU1VIGFuZCBzdXBwb3J0ZWQgYnkNCj4gPiB0aGUgaG9zdCBJT01NVSBiYWNrZW5k
Lg0KPiA+DQo+ID4gUEFTSUQgY2FwYWJpbGl0eSBwYXJhbWV0ZXJzIGFyZSByZXRyaWV2ZWQgdmlh
IElPTU1VRkQgQVBJcyBhbmQgdGhlDQo+ID4gY2FwYWJpbGl0eSBpcyBpbnNlcnRlZCBpbnRvIHRo
ZSBQQ0llIGV4dGVuZGVkIGNhcGFiaWxpdHkgbGlzdCB1c2luZw0KPiA+IHRoZSBpbnNlcnRpb24g
aGVscGVyLiBBIG5ldyB4LXZwYXNpZC1jYXAtb2Zmc2V0IHByb3BlcnR5IGFsbG93cw0KPiA+IGV4
cGxpY2l0IGNvbnRyb2wgb3ZlciB0aGUgcGxhY2VtZW50OyBieSBkZWZhdWx0IHRoZSBjYXBhYmls
aXR5IGlzDQo+ID4gcGxhY2VkIGF0IHRoZSBlbmQgb2YgdGhlIFBDSWUgZXh0ZW5kZWQgY29uZmln
dXJhdGlvbiBzcGFjZS4NCj4gPg0KPiA+IElmIHRoZSBrZXJuZWwgZG9lcyBub3QgZXhwb3NlIFBB
U0lEIGluZm9ybWF0aW9uIG9yIGluc2VydGlvbiBmYWlscywNCj4gPiB0aGUgZGV2aWNlIGNvbnRp
bnVlcyB3aXRob3V0IFBBU0lEIHN1cHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFt
ZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcv
dmZpby9wY2kuYyAgICAgICAgICAgfCA4NA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICBody92ZmlvL3BjaS5oICAgICAgICAgICB8ICAxICsNCj4gPiAg
aW5jbHVkZS9ody9jb3JlL2lvbW11LmggfCAgMSArDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgODYg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLmMgYi9ody92
ZmlvL3BjaS5jDQo+ID4gaW5kZXggYzczNDQ3MjcyMS4uOTY5OTA1NzZhYyAxMDA2NDQNCj4gPiAt
LS0gYS9ody92ZmlvL3BjaS5jDQo+ID4gKysrIGIvaHcvdmZpby9wY2kuYw0KPiA+IEBAIC0yNCw2
ICsyNCw3IEBADQo+ID4gICNpbmNsdWRlIDxzeXMvaW9jdGwuaD4NCj4gPg0KPiA+ICAjaW5jbHVk
ZSAiaHcvY29yZS9ody1lcnJvci5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvY29yZS9pb21tdS5oIg0K
PiA+ICAjaW5jbHVkZSAiaHcvcGNpL21zaS5oIg0KPiA+ICAjaW5jbHVkZSAiaHcvcGNpL21zaXgu
aCINCj4gPiAgI2luY2x1ZGUgImh3L3BjaS9wY2lfYnJpZGdlLmgiDQo+ID4gQEAgLTI0OTgsOSAr
MjQ5OSw3MSBAQCBzdGF0aWMgaW50IHZmaW9fc2V0dXBfcmViYXJfZWNhcChWRklPUENJRGV2aWNl
DQo+ICp2ZGV2LCB1aW50MTZfdCBwb3MpDQo+ID4gICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+
DQo+ID4gKy8qDQo+ID4gKyAqIFRyeSB0byByZXRyaWV2ZSBQQVNJRCBjYXBhYmlsaXR5IGluZm9y
bWF0aW9uIHZpYSBJT01NVUZEIEFQSXMgYW5kLA0KPiA+ICsgKiBpZiBzdXBwb3J0ZWQsIHN5bnRo
ZXNpemUgYSBQQVNJRCBQQ0llIGV4dGVuZGVkIGNhcGFiaWxpdHkgZm9yIHRoZQ0KPiA+ICsgKiBW
RklPIGRldmljZS4NCj4gPiArICoNCj4gPiArICogVXNlIHVzZXItc3BlY2lmaWVkIFBBU0lEIGNh
cGFiaWxpdHkgb2Zmc2V0IGlmIHByb3ZpZGVkLCBvdGhlcndpc2UNCj4gPiArICogcGxhY2UgaXQg
YXQgdGhlIGVuZCBvZiB0aGUgUENJZSBleHRlbmRlZCBjb25maWd1cmF0aW9uIHNwYWNlLg0KPiA+
ICsgKi8NCj4gPiArc3RhdGljIHZvaWQgdmZpb19wY2lfc3ludGhlc2l6ZV9wYXNpZF9jYXAoVkZJ
T1BDSURldmljZSAqdmRldikNCj4gPiArew0KPiA+ICsgICAgSG9zdElPTU1VRGV2aWNlICpoaW9k
ID0gdmRldi0+dmJhc2VkZXYuaGlvZDsNCj4gPiArICAgIEhvc3RJT01NVURldmljZUNsYXNzICpo
aW9kYzsNCj4gPiArICAgIFBhc2lkSW5mbyBwYXNpZF9pbmZvOw0KPiA+ICsgICAgUENJRGV2aWNl
ICpwZGV2ID0gUENJX0RFVklDRSh2ZGV2KTsNCj4gPiArICAgIHVpbnQxNl90IHBhc2lkX29mZnNl
dDsNCj4gPiArDQo+ID4gKyAgICBpZiAodmRldi0+dmJhc2VkZXYubWRldikgew0KPiA+ICsgICAg
ICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBoaW9kYyA9IEhPU1RfSU9N
TVVfREVWSUNFX0dFVF9DTEFTUyhoaW9kKTsNCj4gPiArICAgIGlmICghaGlvZGMgfHwgIWhpb2Rj
LT5nZXRfcGFzaWRfaW5mbyB8fA0KPiA+ICsgICAgICAgICFoaW9kYy0+Z2V0X3Bhc2lkX2luZm8o
aGlvZCwgJnBhc2lkX2luZm8pIHx8DQo+ID4gKyAgICAgICAgIShwY2lfZGV2aWNlX2dldF92aW9t
bXVfZmxhZ3MocGRldikgJg0KPiBWSU9NTVVfRkxBR19QQVNJRF9TVVBQT1JURUQpKSB7DQo+ID4g
KyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIC8qDQo+ID4gKyAg
ICAgKiBDaGVjayBpZiB1c2VyIGhhcyBzcGVjaWZpZWQgYW4gb2Zmc2V0IHRvIHBsYWNlIFBBU0lE
IENBUCwNCj4gPiArICAgICAqIGVsc2Ugc2VsZWN0IHRoZSBsYXN0IG9mZnNldCBhcyBkZWZhdWx0
DQo+ID4gKyAgICAgKi8NCj4gPiArICAgIGlmICh2ZGV2LT52cGFzaWRfY2FwX29mZnNldCkgew0K
PiA+ICsgICAgICAgIGlmICghUUVNVV9JU19BTElHTkVEKHZkZXYtPnZwYXNpZF9jYXBfb2Zmc2V0
LA0KPiBQQ0lfRVhUX0NBUF9BTElHTikgfHwNCj4gRm9yIG90aGVyIGNoZWNrcyB5b3UgcHV0IGFu
IGFzc2VydCBpIHBjaWVfaW5zZXJ0X2NhcGFiaWxpdHkoKQ0KPiA+ICsgICAgICAgICAgICB2ZGV2
LT52cGFzaWRfY2FwX29mZnNldCA8IFBDSV9DT05GSUdfU1BBQ0VfU0laRSB8fA0KPiA+ICsgICAg
ICAgICAgICB2ZGV2LT52cGFzaWRfY2FwX29mZnNldCArIFBDSV9FWFRfQ0FQX1BBU0lEX1NJWkVP
RiA+DQo+ID4gKyAgICAgICAgICAgICAgICBQQ0lFX0NPTkZJR19TUEFDRV9TSVpFKSB7DQo+ID4g
KyAgICAgICAgICAgIGVycm9yX3JlcG9ydCgidmZpbzogaW52YWxpZCB4LXZwYXNpZC1jYXAtb2Zm
c2V0IDB4JXgsIHNraXBwaW5nIFBBU0lEIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
dmRldi0+dnBhc2lkX2NhcF9vZmZzZXQpOw0KPiA+ICsgICAgICAgICAgICByZXR1cm47DQo+ID4g
KyAgICAgICAgfQ0KPiA+ICsgICAgICAgIHBhc2lkX29mZnNldCA9IHZkZXYtPnZwYXNpZF9jYXBf
b2Zmc2V0Ow0KPiA+ICsgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICBwYXNpZF9vZmZzZXQgPSBQ
Q0lFX0NPTkZJR19TUEFDRV9TSVpFIC0NCj4gUENJX0VYVF9DQVBfUEFTSURfU0laRU9GOw0KPiA+
ICsgICAgICAgIHdhcm5fcmVwb3J0KCJ2ZmlvOiBQQVNJRCBjYXBhYmlsaXR5IG9mZnNldCh4LXZw
YXNpZC1jYXAtb2Zmc2V0KSBub3QNCj4gc3BlY2lmaWVkLCAiDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgInBsYWNpbmcgYXQgdGhlIGRlZmF1bHQgb2Zmc2V0IDB4JXgiLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgIHBhc2lkX29mZnNldCk7DQo+IEkgYW0gbm90IHN1cmUgd2Ugd2FudCBhIHdh
cm5fcmVwb3J0KCkgaWYgdGhpcyBpcyBhIG5vcm1hbCBiZWhhdmlvci4gQWRkDQo+IGEgdHJhY2Ug
cG9pbnQgaW5zdGVhZD8NCg0KT2suIEkgd2lsbCByZXBsYWNlIHRoaXMgd2l0aCBhIGNvbW1vbiB0
cmFjZSBmb3IgdGhpcyBmdW5jdGlvbi4NCg0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGlm
ICghcGNpZV9pbnNlcnRfY2FwYWJpbGl0eShwZGV2LCBQQ0lfRVhUX0NBUF9JRF9QQVNJRCwgUENJ
X1BBU0lEX1ZFUiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYXNpZF9v
ZmZzZXQsIFBDSV9FWFRfQ0FQX1BBU0lEX1NJWkVPRikpIHsNCj4gPiArICAgICAgICBlcnJvcl9y
ZXBvcnQoInZmaW86IFBsYWNpbmcgUEFTSUQgY2FwYWJpbGl0eSBhdCBvZmZzZXQgMHgleCBmYWls
ZWQiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBwYXNpZF9vZmZzZXQpOw0KPiBpbnN0ZWFk
IG9mIGhhdmluZyBhc3NlcnRzIGluIHBjaWVfaW5zZXJ0X2NhcGFiaWxpdHkoKSB5b3UgY291bGQN
Cj4gZmFjdG9yaXplIGFsbCBjaGVja3MgdGhlcmUgaW5jbHVkaW5nIHRoZSA0QiBhbGlnbm1lbnQg
Y2hlY2sgYW5kIHJldHVybg0KPiBmYWxzZSBpZiBhbnkgZmFpbHMuIFRoZW4geW91IGNvdWxkIHBy
b3BhYmx5IGdldCByaWZkIG9mIGFib3ZlIGNoZWNrcw0KPiB3aGljaCBhcmUgcGFydGlhbGx5IHJl
ZHVuZGFudC4gVGhhbmtzIEVyaWMNCg0KQWdyZWVkLCB3aWxsIHJlZmFjdG9yIGFjY29yZGluZ2x5
Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCg==

