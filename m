Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97538C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 10:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE4gJ-0003bG-R9; Mon, 03 Jun 2024 06:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE4gH-0003ax-8l
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 06:12:45 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE4gC-0001Kf-K3
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 06:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717409560; x=1748945560;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=52vqckrxpCYlQpH7+P2fVOJUI9fft1nL7/YJ0UksRlo=;
 b=ovvF8xU7xkkrJubnYju3szkybZI3MuQoHjKJUHMiW+JGukyg0JzIxChE
 1VpToYrjDNRqF6jA3Ix/DvUDbfX/+HO1cK28IeAgwucqL0EY97TtKipn7
 jqaeSSIs3aOZknNyZ4tyJuVG4lphRnjb3h4AJAq4U0esU945EXBX/V0AX
 MXEUtMp4dntWhg/BfblXRlK8hocsFxINBGInXONmQWa2Bbitwe+05UDMf
 hLoHqCUlEpvEwAzYm2Ta2tMJioJOikzhnn0fZPM5A5QITpm2MZKSoyv3j
 KbkDtXftP+F+5UiBVB+pC9209biBbcxPaY0jFDc6jCKA1Hsol75NgINXe A==;
X-IronPort-AV: E=Sophos;i="6.08,211,1712613600"; d="scan'208";a="13786346"
X-MGA-submission: =?us-ascii?q?MDE8YmYVCDhKHulg4b+qXzzQOOxIwlX+Jp0DPr?=
 =?us-ascii?q?hjYcbT5jdnbNk2q6pi0URROCZOCgYmAqheEcEYKQqLSA10UmRLWjKNBk?=
 =?us-ascii?q?mf4BBy0zMepfzFKaCUZxgJoyr6zjahWXVrdZcqu33OBv/9HggieutvSa?=
 =?us-ascii?q?rX5EvSKMmX7qKbTPL0P3nerg=3D=3D?=
Received: from mail-db3eur04lp2050.outbound.protection.outlook.com (HELO
 EUR04-DB3-obe.outbound.protection.outlook.com) ([104.47.12.50])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 12:12:36 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1AfohDil1BVuzjGavHAadnT9ohl/Dz6ba3GvOfJ2Qwmdltrhm8SW5RbleaF76BFGxfwVmN4LXMz2FZtT2ozY8/NGRbSD5ctAB8M9lmsXGgo5G/GDT11JVfLQKoUeoGmTgKxyh6Z9rsI24j/LKBvJbHaWKROlYO64RZ6MPnbdNAJpHcAb2/vOcUGNdgqE9lV74rdQSX1n5tm3UKYSLQp9sZb59lzHE5jNjT1KqybLmKGKGTtZ2FOSjBYjdV+a1YDrdCpl++NICj19s7mWBPwx5og+Punp3yOopXfYfH/9EsRVQuEuGPLj6v+GaOViRbejoZkgPEidl3hmOrHwisH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52vqckrxpCYlQpH7+P2fVOJUI9fft1nL7/YJ0UksRlo=;
 b=nGAQma7OsCDg2VzopvkQqvcYHzRW9MpScPeSaN7C1TtobgN7E9OX6CQO608O4Tgl4y+rn65rdrYGFAqEEHF4fJJoE8+8LJnLEFa2SyikWoEkmOoIGWcC3nR6S2vRnpeaz6ancmgWqRAxk5poRP4T2NdErEtE+5hVI7co3E7wIYf8Urmp1GQ/Q7RV9cS2gJMU2NdKFCIz9oad8vdRbAgivUuuVBzsrGtrNiU+VKcK8zh+h1zpAZVV9tGgRGqiFWngHJV+PiIhMsSETTSgZm78vcvYKL9grVN9DEA09We+2WeJl4/iJGbomlEchxKVT65juq+0vPA0CVnn98/jl+tDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52vqckrxpCYlQpH7+P2fVOJUI9fft1nL7/YJ0UksRlo=;
 b=pbygZ5b4zICit8OCbPoIVvmF5p9+3dV1fIOsEAgseIeO0TZoEuxpmQhNMK9KPFKQNmKAOMxfEKdKz/b68o40SRhW1gy9K5msfHMdpW6MgGm48xyE8Za86S161ZuJPx5Ir3GPC048LqrmilXHNRaw1TIBcZoWeSDldMv8zBTwBGkjav8LrWvbQ8Ab1jvElh/8ujuWaLIsSRI7M4nlQQMTB3l/cXyZq+ZpEQqZurvKQCJUDi+WUea7PBCyDF/HRB1y5cV9gqst4i/jfmvaiEWwgDtYZl9lHMPGiOCAnYKMz11ex6PcxUGH4BISQdWoZl+LjOEfNIfKPJx29lh62h3tKQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB10132.eurprd07.prod.outlook.com (2603:10a6:20b:676::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 10:12:34 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 10:12:34 +0000
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
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Topic: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Index: AQHatX1M5omyke+Or0Cx3s0mBbmSvrG10hEA
Date: Mon, 3 Jun 2024 10:12:34 +0000
Message-ID: <6cfdde68-a138-4ac3-ab3c-29f6a94a1045@eviden.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-19-zhenzhong.duan@intel.com>
In-Reply-To: <20240603061023.269738-19-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB10132:EE_
x-ms-office365-filtering-correlation-id: 4215c6be-21af-4426-251b-08dc83b5b038
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|7416005|376005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?R01aSGcrOHQ5VXEwb2RCaWpmNWFld0tCRHIvTnp4cHJ1RVFlVytYaEEyZ3ZR?=
 =?utf-8?B?bFFMMXNtSjZZSEQ2dGttOUJaSVFpTUk4ZWRYMWNkenlpakZXZkUwVG9aMy85?=
 =?utf-8?B?NGRSUG83TWtjc1IwVFJ1a1dPdGNYQXlZbHZrcThnaXpPalFBUU9BcHl5M0I5?=
 =?utf-8?B?cHI1eE05SjRmRnY3SmRLSzI4RkJBQldiQVh2bm5vZjRDNEl6MDB4bzlmUU0y?=
 =?utf-8?B?Mmx2Wno5WHdWUEY3MEkyTWNJbDY5bU9NVHRIbm9MQUZxRk9FOUpod3MxMU9T?=
 =?utf-8?B?U09TVEtjZU4zdnd4SW4rUWdEd0lhdTE5MkRmT2ZhRkIzL0M2WUVkMkdtaHl6?=
 =?utf-8?B?YWRaa1FmMnJMa2RtWUtuclRqSUg3WlVFM1lKM2FoNkhwY3lWbm9zcHNSUURC?=
 =?utf-8?B?ZG5lclhPbW5FYkdYdTNkNUtpalVpQ2dNd1ErSTZzSzJtMzRzR3BEb3IvT3BE?=
 =?utf-8?B?RUN6ck1wNjhWVTUzbkNYTVpOb25ZV2RRaDQxK3lTQzNVY2ZlYVRBRmFOUU1x?=
 =?utf-8?B?WEZ4Rm5XM0VvZ0I3cE5EU3NMb2NkRmdoVVFUeXZrSUh5NUN1bGJ3OWRxQmJW?=
 =?utf-8?B?UDF6Zmh3SlduMEptY1dPUGQrYlVvS0l4UjVuTldsNWtWam5pb3JqTFNROEZi?=
 =?utf-8?B?b2FjM0RweC9EaFBHRFhVWGtTajBYQ2hERXMydFFRVjZGT1hvU3ArQm81ZVN6?=
 =?utf-8?B?ZUtpalZ4cS9Uem55MDZ3QjZYbzQvN1NvR1pjMVdEZUpjdERUUE9PYW5WU0dx?=
 =?utf-8?B?TkF4dTRtZnNaMnc3YlkrMnhyenlrS1JtY2sxWHV5YWtYUGFtSGNXZDRyc2cz?=
 =?utf-8?B?WVlpSnZHcDVwRTFVOTlyb0EvWVlRenNuLzRpckE1T0VuN2dyZjI5RDJOQXVj?=
 =?utf-8?B?TW5ta2VibDArRXlxWGZ6cXd4TldXNXFnN3hmcTFsVjFDdEJHRjJ0WXl5bkh0?=
 =?utf-8?B?UnFDamN4RFJyTllCd3pBK2JaVHBBWkZPa0Z3SXNSRE5XMFYzbml4NUs0aWtI?=
 =?utf-8?B?K3RDckNPakwycFFOWm9yZXd2dldoWmlYRjlDYXZwUVpJZWthWFNZOW5NT2Jy?=
 =?utf-8?B?WUFKcy9OYU85UHZsdXg1cWxSc0gwTU5jWWFXbVJrcDlyaEFXRm9YQndIRTJn?=
 =?utf-8?B?ZUJ3dXFqbGY3YzlnbzViUFpPNzBWMDJ4Rm5WV0IrOTB5cnFZTGNQT1phVEdm?=
 =?utf-8?B?c2JmNUZKbVM5YWVWdGczeWVINlo3TG9WZHUzQ0hBWm5sT0R0Ti9Na3p2Vlpi?=
 =?utf-8?B?aGVjS1ZlVnNCeGU1cVQxM0M5V1JqVUYzK1RzbnBRbytLWEwvOFB6dytBQmVS?=
 =?utf-8?B?UlRyVTNrK0tVTTFYcmVvUzdIbFV6K3ZIVmM5NWZyaHV3eGpzcXpaS3lsNFNz?=
 =?utf-8?B?UDM5Rzl3Y21iVVVoclBSczVMemt2WFJlZy9GS3p2dVpwNmlFK3N4dkhhNDY3?=
 =?utf-8?B?Vnl3UThTazNxUkVxTldUV0poaFoyWUs3Z0JPZ210Z0xnNEVEMW9zNEhhQWhk?=
 =?utf-8?B?N2IyTUJKTXM4S0ZNcHNmdnFpc2ZwZHdkU3lWcG5WMjJyZU0xRG5xUkNkbDhn?=
 =?utf-8?B?ZXhXeFMvR3pFS1VOOXFhZmJTdWZKeVBYZXpad3N0R01zVjBoODhPRmd1NGlu?=
 =?utf-8?B?blVwd0pCanlZT3VzbUNNUUpIOVNsZWwrM0h0NEhmRk9tNUE5WW5HMFdjbVNI?=
 =?utf-8?B?WGozUUdvSng1MDNYZzdaS05WeWlaSi9RSWxuU3BWYTc0QkpKR2Rlam16WlJk?=
 =?utf-8?B?VmVnU1RjRy95VnpqZ201a2l2aFFBeHZaVS9HYVpuREJIRTV0elBCYzFCbk80?=
 =?utf-8?B?MlRTdm9pOUdDbE43TGNXUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emtCczhMcFlYTU5GT2ZCbGZsTUhYSDVIVkhEdUR4MFgyVE1KVkxVNWVPVGp4?=
 =?utf-8?B?bVQ5L3VzNFNJT2RtNDArTHhJVHBzTnJJMitDNVRaYmZPK296NzE2clc0cmU4?=
 =?utf-8?B?NUJzL0lRb0VhZ0JhZDF3MjRLL0xOMXRXUjArbDhVcm5HaFg5SjNLMnV5THNt?=
 =?utf-8?B?aERWT0pWNGZrSlo1bzBzNkxhV0p3cVRwQVdJeUdMV3FiYUhhMVRsZEw3WkhQ?=
 =?utf-8?B?bG81RkRob01JMkFLREJwSG5kSmxiQ2Z6YmE4cS9qN1g3RzBrdHhtdVdZTEZx?=
 =?utf-8?B?UnoxL2tiM3drVnE0N1RNWmFqOHBwZTA3TnJjbno3a0hqTHh2Q002Rkw3MkpE?=
 =?utf-8?B?ZTExN3JUQWF2T0pwVU5pVk5sbTFOQk1yeDcybVk5L0oyK1prQ0gzU1Fzam5v?=
 =?utf-8?B?Uy84WnpPUlFtRGJWTHpSeHBBUm4zblAyNDRPbm5hZ2E0cjdSNzdKUmF4VFN5?=
 =?utf-8?B?cURLaHVIVC9jNG1MMlVodVc5S0h5TWhQVHdGRkdlcHZKVDZSem9YUG5vdmU2?=
 =?utf-8?B?YWYwdmVPN2c1SHZtOW9LZ1poNzRNNlBDaHFxN1pBNXk3YWQvRHNhWnJLbjZX?=
 =?utf-8?B?S0NHSEkxWllyNHk0aHB0UUFOK1F6b0FhZWk0c2xNSldJcEhzWnpBT1R0L1Bo?=
 =?utf-8?B?L3pXNCtHc3NzY2x2L0sxWlZrdm5HQ2d1cmUyd25VMEJzK2pQN24vQytkMktP?=
 =?utf-8?B?djJqLzliSWdHaVdCZnQzVTc1QUJrcWVtbklMMG1hMGw1Q0s2ajFxeC9PdkRC?=
 =?utf-8?B?R2ZzY1hpMTN4dkxDQkR1elNWOW9LTDBkcjA0UVgvSUlibFh4WEI5UUVjTGlr?=
 =?utf-8?B?bkxVbnRmTlI0L1hBNldldGpmV290Y1B3MDFZMHkyUmUwR3pYZUVFd1VMbWcy?=
 =?utf-8?B?U1ZweUx2YW1ORXhNaE1RWWE3UmVXUE9WcURNajJBdE0zRGt6TUprNHlzMk1k?=
 =?utf-8?B?QURLb0NndTJablJzM210OUxaQ0lwVUZFRGNlQ0x5VTdaU3VUMlh2Tzg2ZkNJ?=
 =?utf-8?B?Zi9PUUxOQkRCZEQyTmh6djhRd0RmU1NCS3FQVUlmNXRHWFRUS2lVNFJZb1pU?=
 =?utf-8?B?YlBITE5JZ3RiWkd4NTc3VVZKWS91U2N1TWEweVZCaXpZZWw4NGQxQm5MWi9w?=
 =?utf-8?B?VmtSbTlNT1BRK25qZjdicVowZ3JpRTFIRk5zVmUxUlBJWVJGTHlmYW9JNXh6?=
 =?utf-8?B?VjdDbE1TTm9vTnpaZStEVmZOTDIrV0lsN0Jpb1JOV3Y0cGNsS0J0RXBBVnJI?=
 =?utf-8?B?N3IxY0gxOXJ4VVFqSC9EQ2FSbWwwSXhoS0ZXMkFuVitvR05Dbm00TDRBaUJH?=
 =?utf-8?B?czFmZ3EvcWZwMjhzT1VHQlZ1ZmtCaXA5a1NaN2NQZGd5azM2WHJUVGt5c1dn?=
 =?utf-8?B?MmZNMUtTMExZSXg1cXh0bHZORElDL0MvRVdBbG1rY014Uk9rWGlxR0RNbXhE?=
 =?utf-8?B?OWQ4aGloazdoWGZNOG8rdnN6ZllTQXpOcyt6dldLS3RjVUIrbGFXMmxJQWxZ?=
 =?utf-8?B?NVZ3L3hoaUZQeU95YWlpS1hUaS9zOFJubWptRE1nY2g1VWFTWmxwaWxZNFZI?=
 =?utf-8?B?WTNVUSs0T0tRbWJteW5GdURYdlRpL2pOejFHVHFVaThENVZKTHNrRHBlSS9i?=
 =?utf-8?B?UDlqTW1sTmNFalNXYnpjOXdWSFhVVGFTdDFlRndxUDhUTTNKdFpNQjljWHc5?=
 =?utf-8?B?dUtkdE9xR1JGazJYdmxKT1ZJZ0hKSjcrSHA0Qkp5L1hyYzgrTktGb2l0dHVO?=
 =?utf-8?B?MmF1NWM1d0FEK2x3ODRzZkoyOHU5OFlpdWV3SHlhNFY4Q3pBRjUzY3hRUHJC?=
 =?utf-8?B?dUlBZFRuazFJV080SGNFdEVoQ2RMUmdLWXF4d2Qzc1dpTVM2NVBXWDJ5NEVB?=
 =?utf-8?B?TkwyYld3RmtoUXZJMFFjK0xwUXZwQ2hwMzRLbzRrUGs5b2t4eXQrMjQ2SUtI?=
 =?utf-8?B?a0d2Y0EzeUgyYnBTaktob0dSemFRUm9JcFdBbENvcEJWRzl5RmJuS0tPdXFH?=
 =?utf-8?B?dnpFRkZhdWJ5a05tMDJuUWdDSmc4UWVhRHBORDNkKy9IalExUlVtMHZFZjhr?=
 =?utf-8?B?dm1sUC9hOWZIaXhSdTNKUzEzMlBBclhGYWV5SkJKaHdITHpUNGk2cWxFZGds?=
 =?utf-8?B?aGh6Z0ZqYjlsS3dYQXBVVTJrNFZhTE54QWJoeVFEaXh6Mk9hd3JaRjBlL3JB?=
 =?utf-8?Q?UYwj/iU2kUyKnljc3u7HWC4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AE0306D3C5D3847941CF5D469C3DEBA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4215c6be-21af-4426-251b-08dc83b5b038
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 10:12:34.8468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrgYFpf5pI+qjEaQT7Nt9YYv6hZJKeKfAMrqsw04zGYVS/phuqzvyU4YgN4HMKTONVZLsx3QVq1dU7A2eLORgyBK4p5klPtBCV/wfTm7G74uf3AtwVPG0CnssH0VWZ9M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10132
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQpPbiAwMy8wNi8yMDI0IDA4OjEwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4gQ2F1dGlvbjog
RXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1
bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBGcm9tOiBZaSBMaXUgPHlpLmwubGl1QGludGVs
LmNvbT4NCj4NCj4gSW1wbGVtZW50IFtzZXR8dW5zZXRdX2lvbW11X2RldmljZSgpIGNhbGxiYWNr
cyBpbiBJbnRlbCB2SU9NTVUuDQo+IEluIHNldCBjYWxsLCBhIG5ldyBzdHJ1Y3R1cmUgVlRESG9z
dElPTU1VRGV2aWNlIHdoaWNoIGhvbGRzDQo+IGEgcmVmZXJlbmNlIHRvIEhvc3RJT01NVURldmlj
ZSBpcyBzdG9yZWQgaW4gaGFzaCB0YWJsZQ0KPiBpbmRleGVkIGJ5IFBDSSBCREYuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWmhl
bnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4gLS0tDQo+ICAgaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDkgKysrKw0KPiAgIGluY2x1ZGUvaHcvaTM4Ni9p
bnRlbF9pb21tdS5oICB8ICAyICsNCj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAg
fCA3NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMyBmaWxlcyBjaGFu
Z2VkLCA4NyBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gaW5kZXgg
ZjhjZjk5YmRkZi4uYjgwMGQ2MmNhMCAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiBA
QCAtMjgsNiArMjgsNyBAQA0KPiAgICNpZm5kZWYgSFdfSTM4Nl9JTlRFTF9JT01NVV9JTlRFUk5B
TF9IDQo+ICAgI2RlZmluZSBIV19JMzg2X0lOVEVMX0lPTU1VX0lOVEVSTkFMX0gNCj4gICAjaW5j
bHVkZSAiaHcvaTM4Ni9pbnRlbF9pb21tdS5oIg0KPiArI2luY2x1ZGUgInN5c2VtdS9ob3N0X2lv
bW11X2RldmljZS5oIg0KPg0KPiAgIC8qDQo+ICAgICogSW50ZWwgSU9NTVUgcmVnaXN0ZXIgc3Bl
Y2lmaWNhdGlvbg0KPiBAQCAtNTM3LDQgKzUzOCwxMiBAQCB0eXBlZGVmIHN0cnVjdCBWVERSb290
RW50cnkgVlREUm9vdEVudHJ5Ow0KPiAgICNkZWZpbmUgVlREX1NMX0lHTl9DT00gICAgICAgICAg
ICAgIDB4YmZmMDAwMDAwMDAwMDAwMFVMTA0KPiAgICNkZWZpbmUgVlREX1NMX1RNICAgICAgICAg
ICAgICAgICAgICgxVUxMIDw8IDYyKQ0KPg0KPiArDQo+ICt0eXBlZGVmIHN0cnVjdCBWVERIb3N0
SU9NTVVEZXZpY2Ugew0KPiArICAgIEludGVsSU9NTVVTdGF0ZSAqaW9tbXVfc3RhdGU7DQo+ICsg
ICAgUENJQnVzICpidXM7DQo+ICsgICAgdWludDhfdCBkZXZmbjsNCj4gKyAgICBIb3N0SU9NTVVE
ZXZpY2UgKmRldjsNCj4gKyAgICBRTElTVF9FTlRSWShWVERIb3N0SU9NTVVEZXZpY2UpIG5leHQ7
DQo+ICt9IFZUREhvc3RJT01NVURldmljZTsNCj4gICAjZW5kaWYNCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11
LmgNCj4gaW5kZXggN2Q2OTRiMDgxMy4uMmJiZGU0MWU0NSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lv
bW11LmgNCj4gQEAgLTI5Myw2ICsyOTMsOCBAQCBzdHJ1Y3QgSW50ZWxJT01NVVN0YXRlIHsNCj4g
ICAgICAgLyogbGlzdCBvZiByZWdpc3RlcmVkIG5vdGlmaWVycyAqLw0KPiAgICAgICBRTElTVF9I
RUFEKCwgVlREQWRkcmVzc1NwYWNlKSB2dGRfYXNfd2l0aF9ub3RpZmllcnM7DQo+DQo+ICsgICAg
R0hhc2hUYWJsZSAqdnRkX2hvc3RfaW9tbXVfZGV2OyAgICAgICAgICAgICAvKiBWVERIb3N0SU9N
TVVEZXZpY2UgKi8NCj4gKw0KPiAgICAgICAvKiBpbnRlcnJ1cHQgcmVtYXBwaW5nICovDQo+ICAg
ICAgIGJvb2wgaW50cl9lbmFibGVkOyAgICAgICAgICAgICAgLyogV2hldGhlciBndWVzdCBlbmFi
bGVkIElSICovDQo+ICAgICAgIGRtYV9hZGRyX3QgaW50cl9yb290OyAgICAgICAgICAgLyogSW50
ZXJydXB0IHJlbWFwcGluZyB0YWJsZSBwb2ludGVyICovDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2
L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gaW5kZXggNTE5MDYzYzhm
OC4uNzQ3Yzk4OGJjNCAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ICsr
KyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBAQCAtMjM3LDYgKzIzNywxMyBAQCBzdGF0aWMg
Z2Jvb2xlYW4gdnRkX2FzX2VxdWFsKGdjb25zdHBvaW50ZXIgdjEsIGdjb25zdHBvaW50ZXIgdjIp
DQo+ICAgICAgICAgICAgICAoa2V5MS0+cGFzaWQgPT0ga2V5Mi0+cGFzaWQpOw0KPiAgIH0NCj4N
Cj4gK3N0YXRpYyBnYm9vbGVhbiB2dGRfYXNfaWRldl9lcXVhbChnY29uc3Rwb2ludGVyIHYxLCBn
Y29uc3Rwb2ludGVyIHYyKQ0KPiArew0KPiArICAgIGNvbnN0IHN0cnVjdCB2dGRfYXNfa2V5ICpr
ZXkxID0gdjE7DQo+ICsgICAgY29uc3Qgc3RydWN0IHZ0ZF9hc19rZXkgKmtleTIgPSB2MjsNCj4g
Kw0KPiArICAgIHJldHVybiAoa2V5MS0+YnVzID09IGtleTItPmJ1cykgJiYgKGtleTEtPmRldmZu
ID09IGtleTItPmRldmZuKTsNCj4gK30NCj4gICAvKg0KPiAgICAqIE5vdGUgdGhhdCB3ZSB1c2Ug
cG9pbnRlciB0byBQQ0lCdXMgYXMgdGhlIGtleSwgc28gaGFzaGluZy9zaGlmdGluZw0KPiAgICAq
IGJhc2VkIG9uIHRoZSBwb2ludGVyIHZhbHVlIGlzIGludGVuZGVkLiBOb3RlIHRoYXQgd2UgZGVh
bCB3aXRoDQo+IEBAIC0zODEyLDYgKzM4MTksNzAgQEAgVlREQWRkcmVzc1NwYWNlICp2dGRfZmlu
ZF9hZGRfYXMoSW50ZWxJT01NVVN0YXRlICpzLCBQQ0lCdXMgKmJ1cywNCj4gICAgICAgcmV0dXJu
IHZ0ZF9kZXZfYXM7DQo+ICAgfQ0KPg0KPiArc3RhdGljIGJvb2wgdnRkX2Rldl9zZXRfaW9tbXVf
ZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbiwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIb3N0SU9NTVVEZXZpY2UgKmhpb2QsIEVycm9y
ICoqZXJycCkNCj4gK3sNCj4gKyAgICBJbnRlbElPTU1VU3RhdGUgKnMgPSBvcGFxdWU7DQo+ICsg
ICAgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGRldjsNCj4gKyAgICBzdHJ1Y3QgdnRkX2FzX2tl
eSBrZXkgPSB7DQo+ICsgICAgICAgIC5idXMgPSBidXMsDQo+ICsgICAgICAgIC5kZXZmbiA9IGRl
dmZuLA0KPiArICAgIH07DQo+ICsgICAgc3RydWN0IHZ0ZF9hc19rZXkgKm5ld19rZXk7DQo+ICsN
Cj4gKyAgICBhc3NlcnQoaGlvZCk7DQo+ICsNCj4gKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4g
Kw0KPiArICAgIHZ0ZF9oZGV2ID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT52dGRfaG9zdF9pb21t
dV9kZXYsICZrZXkpOw0KPiArDQo+ICsgICAgaWYgKHZ0ZF9oZGV2KSB7DQo+ICsgICAgICAgIGVy
cm9yX3NldGcoZXJycCwgIklPTU1VRkQgZGV2aWNlIGFscmVhZHkgZXhpc3QiKTsNCj4gKyAgICAg
ICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAg
IH0NCj4gKw0KPiArICAgIHZ0ZF9oZGV2ID0gZ19tYWxsb2MwKHNpemVvZihWVERIb3N0SU9NTVVE
ZXZpY2UpKTsNCj4gKyAgICB2dGRfaGRldi0+YnVzID0gYnVzOw0KPiArICAgIHZ0ZF9oZGV2LT5k
ZXZmbiA9ICh1aW50OF90KWRldmZuOw0KPiArICAgIHZ0ZF9oZGV2LT5pb21tdV9zdGF0ZSA9IHM7
DQo+ICsgICAgdnRkX2hkZXYtPmRldiA9IGhpb2Q7DQo+ICsNCj4gKyAgICBuZXdfa2V5ID0gZ19t
YWxsb2Moc2l6ZW9mKCpuZXdfa2V5KSk7DQo+ICsgICAgbmV3X2tleS0+YnVzID0gYnVzOw0KPiAr
ICAgIG5ld19rZXktPmRldmZuID0gZGV2Zm47DQo+ICsNCj4gKyAgICBvYmplY3RfcmVmKGhpb2Qp
Ow0KPiArICAgIGdfaGFzaF90YWJsZV9pbnNlcnQocy0+dnRkX2hvc3RfaW9tbXVfZGV2LCBuZXdf
a2V5LCB2dGRfaGRldik7DQo+ICsNCj4gKyAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPiArDQo+
ICsgICAgcmV0dXJuIHRydWU7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIHZ0ZF9kZXZfdW5z
ZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbikNCj4g
K3sNCj4gKyAgICBJbnRlbElPTU1VU3RhdGUgKnMgPSBvcGFxdWU7DQo+ICsgICAgVlRESG9zdElP
TU1VRGV2aWNlICp2dGRfaGRldjsNCj4gKyAgICBzdHJ1Y3QgdnRkX2FzX2tleSBrZXkgPSB7DQo+
ICsgICAgICAgIC5idXMgPSBidXMsDQo+ICsgICAgICAgIC5kZXZmbiA9IGRldmZuLA0KPiArICAg
IH07DQo+ICsNCj4gKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4gKw0KPiArICAgIHZ0ZF9oZGV2
ID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT52dGRfaG9zdF9pb21tdV9kZXYsICZrZXkpOw0KPiAr
ICAgIGlmICghdnRkX2hkZXYpIHsNCj4gKyAgICAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4g
KyAgICAgICAgcmV0dXJuOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGdfaGFzaF90YWJsZV9yZW1v
dmUocy0+dnRkX2hvc3RfaW9tbXVfZGV2LCAma2V5KTsNCj4gKyAgICBvYmplY3RfdW5yZWYodnRk
X2hkZXYtPmRldik7DQpOb3Qgc3VyZSBidXQgaXNuJ3QgdGhhdCBhIHBvdGVudGlhbCB1c2UgYWZ0
ZXIgZnJlZT8NCj4gKw0KPiArICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+ICt9DQo+ICsNCj4g
ICAvKiBVbm1hcCB0aGUgd2hvbGUgcmFuZ2UgaW4gdGhlIG5vdGlmaWVyJ3Mgc2NvcGUuICovDQo+
ICAgc3RhdGljIHZvaWQgdnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXAoVlREQWRkcmVzc1NwYWNlICph
cywgSU9NTVVOb3RpZmllciAqbikNCj4gICB7DQo+IEBAIC00MTE2LDYgKzQxODcsOCBAQCBzdGF0
aWMgQWRkcmVzc1NwYWNlICp2dGRfaG9zdF9kbWFfaW9tbXUoUENJQnVzICpidXMsIHZvaWQgKm9w
YXF1ZSwgaW50IGRldmZuKQ0KPg0KPiAgIHN0YXRpYyBQQ0lJT01NVU9wcyB2dGRfaW9tbXVfb3Bz
ID0gew0KPiAgICAgICAuZ2V0X2FkZHJlc3Nfc3BhY2UgPSB2dGRfaG9zdF9kbWFfaW9tbXUsDQo+
ICsgICAgLnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3NldF9pb21tdV9kZXZpY2UsDQo+ICsg
ICAgLnVuc2V0X2lvbW11X2RldmljZSA9IHZ0ZF9kZXZfdW5zZXRfaW9tbXVfZGV2aWNlLA0KPiAg
IH07DQo+DQo+ICAgc3RhdGljIGJvb2wgdnRkX2RlY2lkZV9jb25maWcoSW50ZWxJT01NVVN0YXRl
ICpzLCBFcnJvciAqKmVycnApDQo+IEBAIC00MjM1LDYgKzQzMDgsOSBAQCBzdGF0aWMgdm9pZCB2
dGRfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdfZnJlZSwgZ19mcmVlKTsNCj4gICAgICAgcy0+
dnRkX2FkZHJlc3Nfc3BhY2VzID0gZ19oYXNoX3RhYmxlX25ld19mdWxsKHZ0ZF9hc19oYXNoLCB2
dGRfYXNfZXF1YWwsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBn
X2ZyZWUsIGdfZnJlZSk7DQo+ICsgICAgcy0+dnRkX2hvc3RfaW9tbXVfZGV2ID0gZ19oYXNoX3Rh
YmxlX25ld19mdWxsKHZ0ZF9hc19oYXNoLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB2dGRfYXNfaWRldl9lcXVhbCwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19mcmVlLCBnX2ZyZWUpOw0K
PiAgICAgICB2dGRfaW5pdChzKTsNCj4gICAgICAgcGNpX3NldHVwX2lvbW11KGJ1cywgJnZ0ZF9p
b21tdV9vcHMsIGRldik7DQo+ICAgICAgIC8qIFBzZXVkbyBhZGRyZXNzIHNwYWNlIHVuZGVyIHJv
b3QgUENJIGJ1cy4gKi8NCj4gLS0NCj4gMi4zNC4xDQo+

