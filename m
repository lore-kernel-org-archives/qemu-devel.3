Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAB7E9128E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 08:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnv3E-0004KC-BN; Thu, 05 Feb 2026 03:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vnv3A-0004JR-Ca; Thu, 05 Feb 2026 03:49:20 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vnv38-0001SJ-Mq; Thu, 05 Feb 2026 03:49:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmxzWCC6903CAX8bkFPRl8GwdZvJ6wq6S+lqUtEa4CQNMK28Sa9wPh/YecG/KxYWBefKs9gPXl7NbeWrHvRQVVUTFKNqBISeSCjWyPR9RivJee+SZzCtgaeUOQnFMa2hsqlPy+Wcm0KsUdfEwFyDnayEEuj1MCNKAmf2xd4veqpAQ+LdWuh/EQWq9I1kNSQVgSR/hixSX9898x8FnN1ds8uxl+nrVelJAfFTeLkFfNBcnlWfyJXprQZT01kPALkjfRx+cAKIpzt3HCsc4JnCvnv0vUI18Zn9gjzxs5/0UtceH5Z0VWI9CZpA7V3CNK40EktXX25lPqCNiGu+PjvC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEReyUUi0wTSGASIakWYzRfyZQE2VecyoEj6rVAU38U=;
 b=nSmu5fe7a6bAxbLhtb0GFh51+k3Sith75jc4baXEmzL/TYb8MX8GIoBDhCbFdf34+UisyzfY/2kDZ2vaEO6juZl9KKvBhsB/ZTaNt9j2bCUNFN9azhivrhJlxxJnR9SCD/YyfRxOKc4kOZl1Lb+swHR2posZ6VX7JOwInmc+8PeRQi+RwYHQsG5ACKYPRkuUMBZrfIXz02mhjFW9fnJ5Z7Mblt9cNwFkPbSB+7ejmvzvLXD4wSFzHhB2VHIeeBlxS8JuXSXABF68A+gJyqUwGKQd4xp+Oh7pp0zAhmbxdPwhARVUbluHWV8WQrxGeAlL3U/VtrJz+2JHW0fCU/gDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEReyUUi0wTSGASIakWYzRfyZQE2VecyoEj6rVAU38U=;
 b=X6pLx0JamB75O5MCK2VmttYwier78gNrxryn4fCJsgc8Rn17qX4l9rswOqnmxHH2tEuvVw67QGFwHhZ79FlZvQNWyG9f28DCVWwblX+NzzMkfdi+5oIUVhluhSQod+vSPKEo9CzK0eFeVOKQlDL8Dcuxx/Gkn1nnCwgoT+nGHKpQPMsf6SoOBpmx7ib53n6KOJiIUK9yIH75WcsFtE8tyNFhYTZtLwvfzZLCcIc7RzTBKLbEa47arx9HvQsY/UOHTJx1+KkKT6qJStypRcHLMJ07Z0byLip0m8viG+YvmUs30O3oXyJhRZLGZFiKFUcTC0V8uQTsvDjg/tJYUl+Ozw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 08:49:09 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:49:09 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v4 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Topic: [PATCH v4 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Index: AQHclgiuJqSrcAFLYUmoR7tkm7HotrVy+T+AgADQO8A=
Date: Thu, 5 Feb 2026 08:49:08 +0000
Message-ID: <CH3PR12MB7548D243ADF9C3F48A1C2884AB99A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
 <20260204190008.20070-6-skolothumtho@nvidia.com>
 <aYOoS1qpaL4m+NJE@Asurada-Nvidia>
In-Reply-To: <aYOoS1qpaL4m+NJE@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS7PR12MB8274:EE_
x-ms-office365-filtering-correlation-id: c31fba89-4bf2-4d25-6a67-08de64936d49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?MjNoVFZvSFRUMXYreTNmSlM0U2JWak9xTjJLTFRRMVZKaG1rWE9paVpSR2Zk?=
 =?utf-8?B?MGlWSnBHSUlLL3lKUVViZ0xrYy9JT2JCZmp2bTBMdEcyRWtKcVA5MUxUTW9z?=
 =?utf-8?B?ditKcmo4QzA1Q2NqN25aTzBaczkrYTJqdG56ZDNvcHQrMzArVDZOcVQxcUdy?=
 =?utf-8?B?MWpHZVhYcVFCNW9LQ3Y5eVBNbmZVdnVpV2RmUmIwSVBkS3h5ZzJCbmtRak9O?=
 =?utf-8?B?Y1JQUlNiWW0wbU80aVNQWjhGM2g3aUZiZmhISFNYa0t1RVdaRWtHMjU3dzFl?=
 =?utf-8?B?RUhReTRudEZwYjE2NW1XNVlMM2dLQlR4a0dkc1NrUVRIdkg2L0FzL2FIeUJG?=
 =?utf-8?B?YlJ0S3ZmUzc2UWFUSG91UC9qaU9mVktzZUtGbDFYdU1yTGxCT3kydDl6OUk0?=
 =?utf-8?B?ZXc3YUtJL3haSUZFYVE5Q2UwVjUrNG9BclhOSkNBS2ZBUXJZRXRtSWZZTnF5?=
 =?utf-8?B?Ry9uTWZQN1owK2VYRXJaVGtUanRyeUpHUmdOakU1MHh0Q3dtc1dDOXFONjlx?=
 =?utf-8?B?YnpkV01Da1h2eSt0UFkwOG1ZZlllTU9oZS9kTnFOaVkzNU5IamRsUVdjTlZl?=
 =?utf-8?B?bERGWGJBNXlBSW9DZDFPcUFPOVFpWlAyMTRSOGd4Z3B0TFBXTTljS25iTnBS?=
 =?utf-8?B?ZFM2bG1sOHI3WFZwN0tGekd3dis0S2hwOU1LSFdoVEJnVGNQS0RFeS9vMW5Y?=
 =?utf-8?B?SzJJM3B0czhuUW0xbGtNWkdFN3NOSm5vV0R4NWVJejF4RHcxUzREL1pyeCtv?=
 =?utf-8?B?amVFdXQ1T3k5cUxOS1g3U3piRTR3aFFkY1R3cndReWY5L1JYeHVuanpSV1g2?=
 =?utf-8?B?UFJtc0ZLSVlPTlBETFFma2F0eWtKYVR2SXZJZ3ExRm5IbllTZThscDdrRXpJ?=
 =?utf-8?B?cFcvNEJHeE5NdDhpd0VtdWJIR3B6RXlpbGRyQ3VmOElWc3M3LzZybG0vR2k4?=
 =?utf-8?B?RFJNR3puY01NZEpQRjd4WUFEWWxtRG4yZm1EYjhYbzdoVGkrSXI4a1hoS0Q3?=
 =?utf-8?B?RmlLS0NWS2w0RmN0U1Z1ZWZZcjZ5c3hhRk5WNHlCUHlTZHgrOHRZRXV2aHdw?=
 =?utf-8?B?cHowV0dZZkJDWkxSSGtjYStQMm1rakRaSHFjYm03ZTRwZHdYcXdGRUJBTnJT?=
 =?utf-8?B?RHZqdXVpSzZDdlFTZUxQMjIwU25aejNSSE9LRDRaa0E1V0tqTlFIejAyemZ1?=
 =?utf-8?B?bE1kN3Zhc1ZZMzRHVkQ1NnYzb3pCVUdlcGxxRmdsTERHbmZNV2dUZ0E1SUdB?=
 =?utf-8?B?L0VYTGFrR014ajRoemZzTlk5SmRKOElyMzRNQTErak9oSlRlZTZpR1YyclYw?=
 =?utf-8?B?ZzdkbDNZd20xQnlHYjlIUXJSdDFyRm1PSVhzN3NDRk5vQ0trTnlYL0xVUGFF?=
 =?utf-8?B?cDdjcC84UUJ4S2pzQmVvZCtJMGZGZk5CNm9HV29wN3UrWHJHU2kxbGdhaTJF?=
 =?utf-8?B?WGJESWE4SFpSVFJqR29Vb0ZBSUZQVVh6S2VodDRvbkt3SGl4cXJlai96aDlW?=
 =?utf-8?B?SFZlVis3RnNodzh1MzV6d3hoVWhCbEh5ZWc1ZTJyRHV6T09zbmp5TDhxZW9s?=
 =?utf-8?B?T1Y1bXVXcWZJVFB1UkhkS0E3d3JkL2JHWUIrejZ4bkFGWU5FSkNDRS9TMUYz?=
 =?utf-8?B?dks5OXF1N1NFUlF5NEhYR0txeUtFVXZSeis3c2Zoc1oxOHVUb3FCcHBvdlgv?=
 =?utf-8?B?K2JGUmx2RWcxcFNWUC96Q05IZUhobkJ5WXE3c1prWS9tdG41bFozMTN4T01z?=
 =?utf-8?B?NFNQTG5YV3dGMTVjVy9wNitmeUJsbjNuczNyb3EzUGg2K2tqRXMyMzRMbWlP?=
 =?utf-8?B?ZkhpS25YZ2hEd01UVk10cXQ0OFM5ajdDSkF3YjJMcGdwMGhNRkFXcDJJWGU2?=
 =?utf-8?B?V2ZOeXgvMW1MOE1OSE92NG1UZlpPQVRuNFkvNmR1SDFmS1lBUkc4aGRuMWdT?=
 =?utf-8?B?QnNHZ0NoeVdmRGJxVitGbk9yV2xLL3QxY3VVZi9jZzZndDJEeVlVMVdLRDA4?=
 =?utf-8?B?eTFVN0kzclExbHYxWm1UVDBVQ25BZHc1TVhRQ3R4ZkJrQVRsVHZ5bnhaVHg3?=
 =?utf-8?B?N0pvaDk4NkV0NkVEQ05Ed3ZKL0JtZmtoQ1Q3Sld0aDhzM2tVYTRLeE9GcDVw?=
 =?utf-8?B?eUxXaVdoU2RvcEQxbXBpSURsdnExS21CL3lKbXhiMS9TdVVUVjUrK3RGODhl?=
 =?utf-8?Q?PnQZ2SgIeW6Emk9HDIhzob0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUpZa3BHZEE2S0VvbnRMeTU4LzdPOTRTM25qQ1EvU1E5UElLZTQ1TXV3d0lP?=
 =?utf-8?B?bWc0eURkMWtSRFg4TmxvV3JneUNFZUliRitBTm5adG5zMWFEKytoNXNpVVVU?=
 =?utf-8?B?Z25sQWM2bUJzNU9BQWhIQmsrS2lDWmhZaVFWeHRrSjhmSXNZWFNuOFVRRVcz?=
 =?utf-8?B?YlJsNjFNMU5pQkhUWmEyLy9sR3VESHBJRE1pTmRZeGFud1NGbWwrQVEvRTho?=
 =?utf-8?B?QkJFN3NUWlUyemYzcXUrMVhhREVyMmExNmxJbXExWkQrdTZhWTNSWjFucWIx?=
 =?utf-8?B?UVlTRncwVUdmQ1ZIVmM5d09hQTFBV0ltbWV2dEV6ZTRpTHZmY2sxL3lwS0Qw?=
 =?utf-8?B?dnZlcTIwK25vNXBnT3FvZGtvRkVtaFg4TkJOdVBpeFMzL1g4Y0plMUZOYklJ?=
 =?utf-8?B?TXRiTVhpZHB0NEZobHNjYzJ5eHdXL202ZEZYWGtLM21EOVdPMXljS2JENXpp?=
 =?utf-8?B?Q0sya1d5YjBLS2RjL3RCTFFPWGFXSVljNmxsUFY0ZUhLZjRyaWZhQ1pnOHhM?=
 =?utf-8?B?RDhyUXNPckx2QUExTkI3U0ZTUkZHN3BiQ1dPS3BNNll3eUFRdUZHT2Z5a21q?=
 =?utf-8?B?RmxDMVlVQm1kYmhLMDAyRU9ZczZCSTB1bGNTREhiU3lUQTB6YjgzSmxLV25l?=
 =?utf-8?B?RmV3cktiTkg1Q0FaQTlYZDJjWU9FWGVmdVBiY0EvS1FqaVR0bjhVS3NPbnpJ?=
 =?utf-8?B?QjY3RlJkcFNZQ2k1SUZiVW9peVB0UWwxT3VMMjVRT0QwTHg2RU5YeTVTdEtq?=
 =?utf-8?B?S0Jxb2ZRSXNnYy9CekRWVVhMWDVyd0lOREtGSzhKdkk0anBTZ1FMeEQxOWdW?=
 =?utf-8?B?NVIxUG5HVjk1Q0VHckFvbGhFQVd3V2NwTVBzd2IzUWo0VTZpeCtDdEF5dUs2?=
 =?utf-8?B?Z2pUNks0OUVuOGwvVnFSOUJzdjhaTC9YbVFqSENRVlh6azlFYU5RZ0pBSnZK?=
 =?utf-8?B?S3ZuR1dYVEV0K1RlUCtiaTZvYjVTall4RnozcDNTbHR0REJsU2NZRE10eXlI?=
 =?utf-8?B?VUxJSStTTXNEUVhWUCt2bzJEUEdKcU9ybU9TU0hLclZxUXh1K1NxYXB5YTBv?=
 =?utf-8?B?V1hwRjFwVjkxMUcrMHVQRTVhWDFobVAvMFpHamEyUTRJREt6YnJVaE5zWG05?=
 =?utf-8?B?ZkhMQ29JcWg4aVJ3TlA4R0dUQzVYNnBlZGp6M3NhTnpEanozeE1DYkRqU0RR?=
 =?utf-8?B?S0NhM3BTTVU4VkJCUFNCcmdIQnJSOGgrYnBhT2ZhK21YemF0MEUvUEdzZGpt?=
 =?utf-8?B?S2VpRmVqUGdoY0prcUZKOExwUmlCVTA3Z24rd0FRaE9CRkIrd1BQQTNPNnBM?=
 =?utf-8?B?QjViK1RzVGt0ZG5kWHFueitMNnF2RUprT2hvRGJhTmJYM0Y4aDVQb1JEM1F1?=
 =?utf-8?B?a3NSY1dIZlV0RWF2aGR6WnduQ3VtSkd5RFBmUTVBTW5Ud0UwbWQ4dk53VHFS?=
 =?utf-8?B?aFJvT0hjZ2t3WXh0dDV2V1NPbGJDMjkvSHZxOFpidkRvbmxPTkZUZ3pSeC9O?=
 =?utf-8?B?SU1vZGlGQzBaT3VsaXQrQnV0S1Vqd3UvYWU1RTJmWFFhMkYwRDV4T0hkc0lY?=
 =?utf-8?B?ZFVBL0RNMUo1RkNUVlhENFozVmZkSUwxSXMwTHpGNkdzaVlnVmZqeTJJbDJL?=
 =?utf-8?B?dkNrQVVmZFNWakQ2MlM1eldBQ0wyZjF5QkpvUnVYdklIZzNvWGJqR040SkRa?=
 =?utf-8?B?eHp5RFMwelBCVlZXNzF5cUZmZFpFeVU3R3Z5Wm5UbUJSbGpxUjd0MURJQkt5?=
 =?utf-8?B?S0orcnFGT0xleG9ncytMWEYya1ptQVNRbmFwdEtLOVdwNDB3U0tGc2RVSmZs?=
 =?utf-8?B?djV2K3Y0bHhiQUZidDFhUC95TStZMkFPWS9JWmU1SGpBejhHR251SjZsYVk0?=
 =?utf-8?B?SmltSCtzWlNVZlJnejZkMTU1ajYzRVNQcVBDOXV0Tkx6SGhFTkFhanp0Z2U2?=
 =?utf-8?B?dmE0L0hVZHh6bGRWdlhQTDh5R01ZUy81NDFTbEszTWJVWDB2bUU0Ti95NjVh?=
 =?utf-8?B?dUxYb2ZlQWdGQStNTTR2aWIrdDNlS2RZUzc4bktsZHBCVllpQUdTRWx1SUh1?=
 =?utf-8?B?SHNaakpVNjNMV3hvU2lzd3RzM1hDV1ZhU3MvS2xSZ0pBdEpGYTVrWUVEUlpk?=
 =?utf-8?B?dXRadVpEQWtGSld2WjQvQkVxL1ZVMElIeHhqckwvdlhkT0U0UWVmak5oaUR4?=
 =?utf-8?B?a3ZYcTc0Z0h0WVpYSlNQRmdaOXYxdkFKNU5HUXR3b0xlVFNXakRzUUNmRXoz?=
 =?utf-8?B?dGszTzBDZkY1NkVCQ2RUbG5INEphc2xqU3owNEIrWUNUejRHQVc2aDlKVWFl?=
 =?utf-8?B?T0V4V0lnQ2gveFhkc3ZuVUhLK3hkelZ4d2pQd2NqWDhsTTR6OHZ5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31fba89-4bf2-4d25-6a67-08de64936d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 08:49:08.9309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8TrimR6uRDdxhk78ltuDSTAe0Zp9LT+wBY+wmrnU1GmJCnkMy5pgqBOfaSKoORd5obFLtpamYR5P5al8JeiDVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPiBTZW50OiAwNCBGZWJydWFyeSAyMDI2IDIwOjEzDQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gQ2M6
IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gZXJpYy5hdWdl
ckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IE5hdGhhbiBDaGVuDQo+IDxu
YXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKYXNvbiBH
dW50aG9ycGUNCj4gPGpnZ0BudmlkaWEuY29tPjsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29t
Ow0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyBL
cmlzaG5ha2FudCBKYWp1DQo+IDxramFqdUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY0IDUvNV0gaHcvYXJtL3NtbXV2My1hY2NlbDogUmVhZCBhbmQgcHJvcGFnYXRlIGhvc3QN
Cj4gdklPTU1VIGV2ZW50cw0KPiANCj4gT24gV2VkLCBGZWIgMDQsIDIwMjYgYXQgMDc6MDA6MDhQ
TSArMDAwMCwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBJbnN0YWxsIGFuIGV2ZW50IGhh
bmRsZXIgb24gdGhlIHZFVkVOVFEgZmQgdG8gcmVhZCBhbmQgcHJvcGFnYXRlIGhvc3QNCj4gPiBn
ZW5lcmF0ZWQgdklPTU1VIGV2ZW50cyB0byB0aGUgZ3Vlc3QuDQo+ID4NCj4gPiBUaGUgaGFuZGxl
ciBydW5zIGluIFFFTVXigJlzIG1haW4gbG9vcCwgdXNpbmcgYSBub24tYmxvY2tpbmcgZmQNCj4g
PiByZWdpc3RlcmVkDQo+IA0KPiBzL+KAmXMvJ3MNCj4gDQo+ID4gK3N0YXRpYyB2b2lkIHNtbXV2
M19hY2NlbF9ldmVudF9yZWFkKHZvaWQgKm9wYXF1ZSkNCj4gPiArICAgIC8qIENoZWNrIHNlcXVl
bmNlIGluIGhkciBmb3IgbG9zdCBldmVudHMgaWYgYW55ICovDQo+ID4gKyAgICBpZiAoYWNjZWwt
PmV2ZW50X3N0YXJ0ICYmIChidWYuaGRyLnNlcXVlbmNlIC0gbGFzdF9zZXEgIT0gMSkpIHsNCj4g
PiArICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgidkVWRU5UUTogZGV0ZWN0ZWQgbG9zdCAldSBl
dmVudChzKSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgYnVmLmhkci5zZXF1ZW5j
ZSAtIGxhc3Rfc2VxIC0gMSk7DQo+ID4gKyAgICB9DQo+ID4gKyAgICBhY2NlbC0+bGFzdF9ldmVu
dF9zZXEgPSBidWYuaGRyLnNlcXVlbmNlOw0KPiA+ICsgICAgYWNjZWwtPmV2ZW50X3N0YXJ0ID0g
dHJ1ZTsNCj4gPiArICAgIHNtbXV2M19wcm9wYWdhdGVfZXZlbnQocywgKEV2dCAqKSZidWYudmV2
ZW50KTsNCj4gWy4uXQ0KPiA+ICsgICAgLyogU2V0IHVwIGV2ZW50IGhhbmRsZXIgZm9yIHZldmVu
dHEgZmQgKi8NCj4gPiArICAgIHFlbXVfc2V0X2ZkX2hhbmRsZXIodmV2ZW50cV9mZCwgc21tdXYz
X2FjY2VsX2V2ZW50X3JlYWQsIE5VTEwsDQo+ID4gKyBzKTsNCj4gDQo+IEFyZSBjYWxsYmFja3Mg
c2VyaWFsaXplZCBhY3Jvc3MgdGhyZWFkcz8gT3RoZXJ3aXNlLCB3ZSBuZWVkIGEgbXV0ZXg/DQoN
ClRoZSBxZW11X3NldF9mZF9oYW5kbGVyKCkgY2FsbGJhY2tzIHJ1biB2aWEgdGhlIEFpb0NvbnRl
eHQgaW4gUUVNVSdzIG1haW4NCmxvb3AuIEFGQUlDUywgdGhlIEFpb0NvbnRleHQgZGlzcGF0Y2hl
cyBoYW5kbGVycyBvbmUgYXQgYSB0aW1lLCBzbyB0aGUgY2FsbGJhY2sNCmlzIG5ldmVyIGV4ZWN1
dGVkIGNvbmN1cnJlbnRseS4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

