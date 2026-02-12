Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C834EB48FC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 10:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqU5Z-0006wF-VA; Thu, 12 Feb 2026 05:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqU5I-0006un-Gw; Thu, 12 Feb 2026 05:38:10 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqU5G-00076Q-SS; Thu, 12 Feb 2026 05:38:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLK7xvK3JVSEl9X5/U6WHg/RtK6V4zRdz24pOkVGpU6bwvhhFjDzzRle7te0uwkr7hICDorjd6EfHe9LxA2kYg7dQIzvZZ/1OKl/hu8iOrU5QiOLp0LLNaonUmNy3cgop6tdLZvzdYdB0N75VMMf5X4kwxtnmBODoE1yfye6/PI4rGDdzXM2Hnwe46iSqSQcvBgUFhIIULViA6irRO/NaRtH5FfSebfZMqNCSQ5E+5rqPBP8cjqif9Sv5ERgNSELMCn2wTYx4c3+fz/JrXQjbe71VLrmr3pU3cm55Ge6+7sRJhal2umQBEGNDzaT4V5uT2Oo+sATqnic4YzIbwt9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZM6ugmV3SHICK0d18Ng/nSANyIjJR2qAmUuOoudUlN4=;
 b=CETx2znuv/oNXzozPp3HfL1Nmr1wL4H2KJgTD9rsWjZDA/U2GFAef0SIHx+ItfdJLyEuz6DHVOXz6P/POUJ8oYl5CCRxIRkEDJT9XsjX+8Ui2sSx/s5ZT3NFjkERXWu0WJx7BkNZ41VzK2P2A6olpFFKZjF/nuHwNBIHlJyvY0Zo175VJ78zGWU0GE6nnMjM+eYCjlWV2oZ1k8uDmmeaJCxZXhTRKL6BSeYiQij1t8KIIZLn4iQszb5q3Uy+joAhOK/Y4n8crRCc2dWkhhBacwWgtRKh8yfQ6lYx6j3DJhEvM+qwPhthmmYTJADYcYKe/Dl7NoKpjyUmdxINtaYmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZM6ugmV3SHICK0d18Ng/nSANyIjJR2qAmUuOoudUlN4=;
 b=bF5wpFqmcGSiaYUIrcYECbemdMZ+NHKek/znuOGih+YFH0KBZCzXIrBOlAHLBIXunnlaos8qpdRRc6X87Kfn3PhCKlL7aTzO9pzAWEejjLRZikw3pPKIwWL+GbFwlRRT2Xipt8ik5LAUUj50Bg0YiElf1a7CnIqbBE86sqRdgCtJR3rk6zSSsx4a/2ffFXLoEf0zmUmSxaa710bFaHa/O0bxQgcNYH+w8qBdfmN6j+6RjRyxSP6wHHnTxRWBCKOXTaAQly5wYpPjOO/elo1GLHVR27SwnIzDjD4hAIfaMZm10m0rUJ5YLEqrVbFdHkxzxr6nJbXJfhB818SQKidRZA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Thu, 12 Feb
 2026 10:37:58 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:37:58 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Topic: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Index: AQHcmzFk1Etk+2u8DkWzxKPQ5vkZXLV9zEoAgAAB5gCAAALtAIAAA6kQgADIEoCAAENNAA==
Date: Thu, 12 Feb 2026 10:37:58 +0000
Message-ID: <CH3PR12MB75484D5C824BC9A277100CD9AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-4-skolothumtho@nvidia.com>
 <aYzFeMh1szhJlJJk@Asurada-Nvidia>
 <e66e82d6-0953-49f0-9d84-bf2776e8f3ce@redhat.com>
 <aYzJhEFg/zxtrJ8z@Asurada-Nvidia>
 <CH3PR12MB754855AE35A087B900B0C311AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <f053853e-577f-418b-9bee-e9aa8ca0ebb4@redhat.com>
In-Reply-To: <f053853e-577f-418b-9bee-e9aa8ca0ebb4@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS5PPF482CFEB7D:EE_
x-ms-office365-filtering-correlation-id: 3d1b0b6b-5555-49f4-69df-08de6a22c9e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dWNtZThLREh4VldNVzMzOE1hb3lQRmFLZnlHTys3Sk9rN1ZsMHRSb1JuUWI5?=
 =?utf-8?B?VzR2dzVaRFJlRnVhRlpPYSt3YUlJTmNndlN1YzlxVTVqNzQwbU1FeVlkcjZE?=
 =?utf-8?B?dnhXcDI2QS9tZ1RUcE92TFJzME54cW5XOEI0dkcwRkF5NXNYdzZ4UWxnR0Ru?=
 =?utf-8?B?L0hpeStOVERqZ3I4b2JWeFRhaTIxQWlpQjlLLzJiWDZHSzZBRnQ1M2tHeGNB?=
 =?utf-8?B?UDYweUJUTzcrb3pwZng4WEs0S0pLam5SNUJMMk1Rd3h4WTI5Z01hTm9NSnJN?=
 =?utf-8?B?MEh4cUxveVFnMHJhTHhrRUJCeTlHWU5uNzVaN0hMelpvUDNJTncyMitIOFV4?=
 =?utf-8?B?c0VFMG5WTlY4eGR3alhsRkNkd0ZwOGFDbkNWNGNXTXRTMmM1SC9PSWtGeG16?=
 =?utf-8?B?SnRpZVFET3Y1OGEyT1YvcU8xdGZkUVhJVlVvbDNOczhBNzJUdjZwaWp5Wmtu?=
 =?utf-8?B?RlEzOHBQMExqYmJJWmV5YnBWNGdZWHVrZUx5dUNTMlhobFg0QTNLUnIwRHFw?=
 =?utf-8?B?OEN3QUFON3oyMWM1WXhvS3VUNG1qbmlPYkhXa0tKUklGQzBTTE1iUm90amt4?=
 =?utf-8?B?WUI3Qk9sU0tWME5PdWc0V3R5Ny90RFJmazlIQjV6Zzk3Y1NuNnlVMDdjd01v?=
 =?utf-8?B?ZGV6cUVYb3JFVDVRWkJaR0pOZXpMNG5obERYRDRqcFRBUkFwdlhZM2Jna1BH?=
 =?utf-8?B?NE44UWZCTXlSN2dBc21adnNaK2JORzFNTFVZcnhPaDdXalVWeHZlVE0zblJ5?=
 =?utf-8?B?SEVrZGNOUHM4dFVRTThNVU04SjdiNERyWFpoVEFzbHZ3MjBjRVdCTlRzcFJn?=
 =?utf-8?B?RkJOUkU3QkZvS01sOTJ4WmVYMDU0ckM3Q2JwQjVQem5iTkNBcVlRaXZ4S0Zq?=
 =?utf-8?B?eEZCcFFhV3JOcFdEb291L3pPWitseERNMk1PNEdPcGd5MUVtMUQxVldnaUlN?=
 =?utf-8?B?eDBuU21uSFJ0UGRiZXIvbGJBak9RTXMySTZmN1BpWnJpOTZLaHNwK2xyYW9y?=
 =?utf-8?B?eDJpMkt6cGszVkNhak1mbjZwY0FWbzkrM0lKSXpnd09PbmJWbE1iamQ2dFY3?=
 =?utf-8?B?SC84YUhRM0U3UWR2SDBYeUZyZHR6ZVNEMjBOTDhQN2I2bG92U0ZBbTdaTXF5?=
 =?utf-8?B?dnN1MFh1MDFaQ0VWNWcva1NacnhNR2JNOWw4SFk2NVpjczlQa2lrR2UyMTJY?=
 =?utf-8?B?VkcrT0JjY1M1NFZmbDJEODhEaTBzSXpZckJJL25ITHRhRGdUVEJndjBWeXFz?=
 =?utf-8?B?TDFLWExkZUJtbG5VTHJnWEpHZXpIcVg2cGxORDNsNGQ2OFpjK2NuVCt6MTNn?=
 =?utf-8?B?SnVYZ0JGbVlCakxNYUo3dUg4c0p6V01lRWlmUC9zWUdKajJDM2lBTDRHWnRG?=
 =?utf-8?B?NncwNFRNVnplYUM0eGlvQmpNWjBxL3JXVWlBdUxQWHNpYVpxSTcxYmZzOXN4?=
 =?utf-8?B?MDZoYm5QeXN2bVVBWTNoUHdlV3JCa3B2WEhQcWMwbldEanRrbmxVYllaTGtD?=
 =?utf-8?B?elM2K0M0WjBXM2hHZzlFN0pyS2VuYmJMdjZYbGljVm5kTk4rcTlsQlNKeWZl?=
 =?utf-8?B?d1QxUFQ3ckJFL1U1SS95WGlZN0tUK0lXOEVwSTI0dWJGelZGZzdtQjVmN2Zs?=
 =?utf-8?B?YmZUcXJHUWZpVGpaWmlrSUEwQmNmSUlUNTFjSHp5R20vbUNqQ3dZaWNVaW5p?=
 =?utf-8?B?N0JJVmdFR2x5MHNEN1h3NHYrc2o1R09ySjQybHFSRmNveGpiYUFmK21MZFFJ?=
 =?utf-8?B?M0V1N3RhSE4wL1V0c2RjYzRoQncvM3BJL1NhNjNIdS9UaU4vZ3RjVkVneHJs?=
 =?utf-8?B?LzVOajhCTUFPQ1hHdUtvVGZ1WTNMbWJ2Ykxia3hreW1CVmZpTFZKQnIvMFJK?=
 =?utf-8?B?dXdmMW9CdWdDTENGMkRoNk5hTnRXMWtKemwvaDJ3RHRKZy85eXptSmN1Y1dD?=
 =?utf-8?B?MUhxc3JBVXlMcG1SOFJoU0Z2M1ZvZ2o0S0ttYjBseGhpTi9MWXh2STRTUm5T?=
 =?utf-8?B?S1pQbnRUTHBjdVFzbittZjJNamJHbDhLSUJ0enJXSVpCdFNnWXNaNytrZWZU?=
 =?utf-8?B?RXFYVjBUeUdabHBxVU5rZ3B4UXNUWW56N040MDdCaWoya21DY2FNcVJZV0FG?=
 =?utf-8?B?VGxPZGZ0ajRPbitibEdLNDRJK2xSRDdpdTI2RHZmOUdXVlJTUEIxcUt1dTlm?=
 =?utf-8?Q?VGvgwsjIjSQcwbyoZhntLFk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUpZM1JOeGVETVZpdnlCWlFOWmd0azZyekNtR1FpR01PUGNXQmhPQXhXRUJm?=
 =?utf-8?B?a250WlFKUnJFVXJyRnZ1RktwOGFQQUlIcDZiV21hcjdmRTN6d3ZOcXd2dlIx?=
 =?utf-8?B?YUNHMHhnMnVOS2tQelhONTB0aDVmRFBWTHZtOUxMNWN3am10YXdkdGVreDVn?=
 =?utf-8?B?cUN4ZlpVdEJqWjczeVErL29pM2YrZUxTNWZaMzJSTUdoc1dCMEtPaUwyZVlK?=
 =?utf-8?B?RmhWN3pKd25icDA3M3NrRmVjdkhqT3ZVamxIblZ3dDNuVE5QUjhrRnlsbDRP?=
 =?utf-8?B?TFRnWDJuZmx5QmJod1EraE5GOCsrcFZXa2pWWFMvVjAxK3o0MzIyMnA4amJU?=
 =?utf-8?B?R2J3VjRXL2NkbGZCb2VxY1djdUk3MFFJUEwwaEFsbmZsUWVWYnVudXkxN0g1?=
 =?utf-8?B?ajBPSzc0d2c0WGp2cGljT1FkUldPNHNTZ1c0VVVPbWgwVmVYSWJwa3NSb09O?=
 =?utf-8?B?N1hta0N4WElTTlF2dUwzR3o1MDlGd1RaTjBrSlVzOXo4RVNYWGQrYnFyMGZ0?=
 =?utf-8?B?WHhwTTM2RXNZOWtYNThEb3dRcEZPbk1tRDhvSjhMdWFuRkpIa1F6WXNwMGFt?=
 =?utf-8?B?NDc4U1RGeEwxUDJ3SnZLWGZpUEtlWUVqWXA2TXgweUI1anRIVHhTTTZ4VUZT?=
 =?utf-8?B?dUpjWmJta0o1eTdSNVNMMXZUYmt4am9TN21hQW1wQ1YxSmlIQno4a2pENDE0?=
 =?utf-8?B?alFjNzYzN1VjNWdXWURINTl4b1lEWDVyeENlNVFuMmVBZjlPSnNVRm0rRnM3?=
 =?utf-8?B?Y0VxMWJtN2JkR0V0WjBkUXpxdC9oMlh4N0JIWXhJL3VLRHdEOGFVMVFzbmdG?=
 =?utf-8?B?RG8xejI3Q1VjdTMvTSs0YUFyc0xGUXhxemUyVzRVTFlacUhCK3hlbmVVMlpS?=
 =?utf-8?B?Y3B3ejZ5N0VFUVFBdVN2MzJib3NtREtxVkpQNGFtSHk3RVh1NUVTRENxeVVh?=
 =?utf-8?B?UzJ2R09TdlZqcjlKcGdGZFo5OWNUdmY0RHptekRqaExCNU5rRGllc0JnNFEy?=
 =?utf-8?B?VGJlVzZXYzBMM25GVTkxdzBmYXo1Qk9mR3VISVI2ZEVmNnZjUGs5VEZjWFNV?=
 =?utf-8?B?T0JKZGcyajhHb0Jqc2hUa3ROQzd0bmF6cHhGUGJmanhlWWIzbU8vRFU0Zjdh?=
 =?utf-8?B?anQ1QVI5Z0dYV0tqeklPRjc4UGRTLzlDNTBPZTZUYmtuM0k2V0pWWk43a2RR?=
 =?utf-8?B?VlZ0OXozL2VhN3BRVjVsRUl2dEJ5UzNZTm44MFY5ZUo4SFNtSUZab1o1Q3kr?=
 =?utf-8?B?Z0NrRVFZWitQeHRZWnpSNnRoNUh0VjhETm9Samt2N2dMWElpVVZ6clFLV1g4?=
 =?utf-8?B?TjY3RzdjY2pZSzQ0YXhDZDlBM1hRWDlDQWlidHFYNWRQRnVvVzZmRjZlcE5O?=
 =?utf-8?B?TU5rUnRWN2tKZldKTWo4aWlGM2luMXNham1odnRueUxsSHpTVFprSGlnTFRz?=
 =?utf-8?B?aFk1V05FWERTdnFvSE9OcDBXVVdLK2U5bTVxV0ZJRDdNQmFoZTZyblg3UC9a?=
 =?utf-8?B?bEt5SUV0TjhsQi9UN2VRVTZoL3B5blVmc1luSFBtbzBGT1NYVTJ4UlBQcFRp?=
 =?utf-8?B?R1RtQ2hGQ20rcGRlN005TTJmU1JndlVpM1Jyeld6d3lpajI2UFppRXkxTXNI?=
 =?utf-8?B?MXlseldHY1dmTFdPVGtSbTB6ZCt0d3hJSmw0RkdGVGpFN1ZTMmIxazZBeFJp?=
 =?utf-8?B?dkpwcU5ycDAvQ215NXZMWVRvdGF5SGdPVDFyUXFzT3ZtR29Nc0E4YUVwelRn?=
 =?utf-8?B?QkMxV2RXSjRtZExpMU5pY3VybGhJRjBWNmxCRi9DVFpFaHU5bHNGcEJUWklP?=
 =?utf-8?B?VHd2VTVrOGI3TzNWQU5mbUdYMWJ2QzliMGg0YWtRYkQ0cm9VNmhUdWJabDZw?=
 =?utf-8?B?UXU4OVB1K0JydXBra2RyZ0FQVkJ1SVhaTjJvZHFZRHUxeWNpNHZCb3h4ek5l?=
 =?utf-8?B?TjlueldnRU1BdGtpRFdlYjZTdHpqNGdkcFo5YzdEWjRWQTZ5R1U4Q1pYemRq?=
 =?utf-8?B?ODVmYlFDZ0k2RmFldlpmLy9lMTV4SW5MOW1CVHJ3TzJLQzFXbnRGbXl2VmY5?=
 =?utf-8?B?SWt1OEVxWW5rc2w5N1ZHbVU2Y0dvUytYQlhXMjgzMDBQdWNSVUlNblJrRE5H?=
 =?utf-8?B?WlB5ZS82NlFRa3BFVmtDTTg1RUdYU2NLTWczblFLeis4UTlSc1BRcS9hYmpI?=
 =?utf-8?B?dmJFTHl1RWd0VEFyWnExc3IvK1pWK0svMk9nSnZGVzJDRGtaQzZGZmVjQUJH?=
 =?utf-8?B?Uk01MlhOaW5GK3RoanJaVXcxcGVwYXZ0L2RBd3JNZENFeDVWRnZmUFJoYkwx?=
 =?utf-8?B?SGxLL3lkeXdlKzVyd1JLSUNFYU16RU83dUw0RG91SWZEVVhRNVRpdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1b0b6b-5555-49f4-69df-08de6a22c9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 10:37:58.0674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnkUJojtO6sUftmwI4bJBS4CW1Nyff9Ib6oVdY9llILohSMiGyu2H3FeFlbl/E0+qOtJKKbc0fXMoglcEi1Miw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMiBGZWJydWFyeSAyMDI2IDA2OjM0DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IE5pY29s
aW4gQ2hlbg0KPiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gQ2M6IHFlbXUtYXJtQG5vbmdudS5v
cmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBO
YXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzDQo+IDxtb2Noc0Budmlk
aWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZpZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8
amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVp
Lmdhb0BsaW5hcm8ub3JnOyB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEph
anUNCj4gPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMy81XSBo
dy9hcm0vc21tdXYzLWFjY2VsOiBBbGxvY2F0ZSB2RVZFTlRRIGZvcg0KPiBhY2NlbGVyYXRlZCBT
TU1VdjMgZGV2aWNlcw0KDQoNCj4gPj4gUG9pbnQgaXM6IGlmIGxvY2FsX2VyciBpc24ndCBOVUxM
LCB3aHkgY2FuJ3Qgd2UgYWxsb2NhdGUgdkVWRU5UUT8NCj4gPiBUZWNobmljYWxseSBub3RoaW5n
IHByZXZlbnRzIHRoYXQgSSBndWVzcy4NCj4gPg0KPiA+IFRoZSBvbmx5IHRoaW5nIGlzIHdlIGhh
dmUgdG8gY2FsbCBlcnJvcl9yZXBvcnRfZXJyKCkgaWYgbG9jYWxfZXJyICE9IE5VTEwNCj4gPiBh
bmQgdGhlbiBzZXQgbG9jYWxfZXJyID09IE5VTEwgYmVmb3JlIGNhbGxpbmcgIGFsbG9jX3ZldmVu
dHEoKS4NCj4gDQo+IEJlc2lkZXMgdGhlIGltcGxlbWVudGF0aW9uIGRldGFpbHMgYWJvdXQgRXJy
b3IgaGFuZGxlIHVzYWdlIEkgdGhpbmsgd2UNCj4gc2hhbGwgZmlyc3QgYW5zd2VyIHRoZSBxdWVz
dGlvbiBhYm91dCB0aGUgcmVsZXZhbmNlIHRvIGFsbG9jYXRlIHRoZQ0KPiB2ZXZlbnRxIGluIGNh
c2UgdGhlIHNtbXV2M19jbWRxX2NvbnN1bWUoKSBmYWlscy4NCg0KR29pbmcgdGhyb3VnaCB0aGUg
c3BlYywgSSBkb27igJl0IHRoaW5rIHRoZXJlIGFyZSBhbnkgYXJjaGl0ZWN0dXJhbCBkZXBlbmRl
bmN5DQpiZXR3ZWVuIENNRFEgYW5kIEVWRU5UUS4gVGhleSBhcmUgZnVuY3Rpb25hbGx5IGluZGVw
ZW5kZW50IG9mIGVhY2gNCm90aGVyLCBzbyBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gZGVjb3VwbGUg
dGhpcy4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

