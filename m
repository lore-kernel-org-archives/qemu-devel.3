Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14FBD74968
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 09:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWWVX-0004pK-Ib; Fri, 19 Dec 2025 04:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vWWVR-0004oJ-Gl; Fri, 19 Dec 2025 04:10:38 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vWWVN-0004Fi-Kj; Fri, 19 Dec 2025 04:10:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9sTQ4gQlxdbZBypGuO1hexmzaESvAbm3YOr1v1CsSMAYjO8bwcFdYF1glhpTefrsg6ME59MRTRStiD+Dt9X6w4qQ7+AQM5rR/yb2WL9/1kMJhF6VH3xRhiWqoTCpGERE+baGQTk7eyIQDNyAzMIj5uaPNWJW6TbPXIQzpspRasLKHOt4pTOJur8ymPRihNgdyFPl3zVANytM5jGPc7xK40iH+XyNTVFdCoUgt0xoeCC4tnFNwiJzPAJFA8LY61AqmHV89o+WhOKhnhioz1chlp7gUQmTBNjkAyEbYKM9y6ATaaS5/DHXV6yVZexhVVHCuxA7N9CeR0xLW+zuUkTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfsQX84AX6pSjjzsYpP3VtSrw3NtcmwGZ8Yz1H4IgjI=;
 b=r2Nk5tXuF6CF9ZpeABfc/M5kWcRK8QSsKkg2MRNvrBJPykL96/WhUHtvEPwHKQyEH/i0qMbf5gaXDYnR/O1ONKLiJEJH1YbxDa5pmRJ4bGaoMwb/24w56+6OFj1WzW9bzo3zfFq0xzHMzIyLJr5n9Xd3VR4yr82ZSe0ymuIiaaGlAjn7QsY1vVyPkPI02n3P8vClSqg/+bybY2l9rTuoMiVBwcdIrRnBmXHRcLGCrGu/L3dG4ne0NGQ93aeEhejzcVq6p5rwl6yWBJrCQwRgzlnrJYMWYrmoV3vXfTAG/HP7gS0IcWMZkyArvmh7Z5xzEZa/vGls+dM7CJTugemuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfsQX84AX6pSjjzsYpP3VtSrw3NtcmwGZ8Yz1H4IgjI=;
 b=icD2TES5DDrsfOIarI1yBM6xv+rQENnt8fPBzLLbUUxHZCFk98AU9mBCOd7wpjNHUwets/A4vcSMXaCOvqsMxfQdwmJUhU3OeT77Mk04aAVIgPti1eeMItKfRIWVEupXcKgsBZed7N+bVPrJDmUFz1Pmnseb60lo4v5CcwtqUsUpAufUSa/v3ct25d89NRT1DFw1l0IXQ+9BoXEwSnh5Iw25wn2RwUeUxp3RCi7X5ttcXcPNRcc45TvR9YWq/e4WC9+jFeMlE4iS6m1WrBj3GOUjTyWveA89F+wWQH2eqSmcqrQ868yTBMRfNKPQrYTs49tIQ0r49U51lm3SsrW+VA==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by JH0PR03MB7323.apcprd03.prod.outlook.com (2603:1096:990:11::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 09:10:15 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e%4]) with mapi id 15.20.9412.011; Fri, 19 Dec 2025
 09:10:15 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Chao Liu <chao.liu@zevorn.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "vivahavey@gmail.com" <vivahavey@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v3 0/2] RISC-V: Initial support versioning of debug
 specification
Thread-Topic: [PATCH v3 0/2] RISC-V: Initial support versioning of debug
 specification
Thread-Index: AQHcYmPYsNbBGMo23UKXImQqaC0+/LUouJyAgAAOabA=
Date: Fri, 19 Dec 2025 09:10:14 +0000
Message-ID: <SEYPR03MB670057426CD1F169681C54C1A8A9A@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20251201014255.230069-1-alvinga@andestech.com>
 <0e543e10-970d-4a7c-aa79-d3a0a6358e72@zevorn.cn>
In-Reply-To: <0e543e10-970d-4a7c-aa79-d3a0a6358e72@zevorn.cn>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|JH0PR03MB7323:EE_
x-ms-office365-filtering-correlation-id: 98efee19-8111-4071-3101-08de3ede6c0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eHBDRHpJbnE2SE5TRW1zSC9ZU0ZyeGlEdnY2b1RwYzBYdFdyVmlXN0xFMU9H?=
 =?utf-8?B?aG1hWWRkT2V4Y0FUck0wTG9ubko5RWVkTG5GOVM0RmZFRHd6cW9vMFd6elZE?=
 =?utf-8?B?VVpNL212MHVKeTVGdldxR3VLTTZIeWJPaHNqNXR0dmUxRkpCNzViL09MRUg4?=
 =?utf-8?B?NnMwQlZ6cSs5V0JzRzhqMVk5eHc4dldQZUJ3OHZBK0FYODY2RWxRVE90VjBV?=
 =?utf-8?B?Y1RDSE5PQldVam5URnJONlFrYkM4OC8vWTltY3NUVU1RRmRTcGl5NzluaktV?=
 =?utf-8?B?OStWL2tyNTNBcm12Q1ZTcGZyeVRVTlBSZklJTHlPa0NBcmlmS0hPQjhHSlBw?=
 =?utf-8?B?dXM4MmNWSXJwbCtaZ2REaE83YXVRMTFtL3dsNmlEL09TZDNyT0FIc1Q0M2Vo?=
 =?utf-8?B?bXB0LzlOcWRLM1RNUjRxUUxqY00rRlg4ZHFsWStKaVdwdGxxRFJpNTBqWGdH?=
 =?utf-8?B?MHFVcnZNUW8vWU9ZR3p0amlDK0dqaTFFdDJmODU4R2pseldyYWQwaFhhVUpO?=
 =?utf-8?B?YURlNzRDWFBrOERtS0lUOUZPb08wLzZESDIrUSsrdmtwSzFJZS9Ma2JTZzV1?=
 =?utf-8?B?V3gvbkk5QlpEWHRkVXBqSnRGSHllcjBsMERIb1Z2WjN2OThKcWwzK0U3Lzla?=
 =?utf-8?B?SERvOEhwVU9nU3diSTJKa24vQzZvdEdYbUJsWksrRWg1ODUzZ3NLcC9hMDBZ?=
 =?utf-8?B?TFB6MjVWaTVDaWdYRkFtaDJDV1ZjRGc0ZnZrRG5aeHc5QndHaUJxcXFraHBJ?=
 =?utf-8?B?c0RvRGVvd3dsUFl6Q0VLdkJjYWt4NzZ5SnM1amlFU3NQeTU3aFRIL1UzWGRK?=
 =?utf-8?B?WjRPaERNSEEzRU5DUjR1M1RSK1Z1UVVVQXUrVUhZRHh0SnY0OUMxNUhtMEdx?=
 =?utf-8?B?QlA2Szk3ZW5uSkh0azZyTHduVjZEWUU5bnAzUmwva2kwOVp5ODBqN1IvYjRO?=
 =?utf-8?B?Q0FVQm9SaXFOTU5QNzRJR0VUMlhzaE4yVTdTVktVT05OeUtaazJNUnh1WFdD?=
 =?utf-8?B?bHlOaGphSDVoSm13TUxHdGQwRWV0bjVLSFlmZ05RWkxQdDcxU3BqTzlYSkta?=
 =?utf-8?B?ajJIRCtBaitBRHI5MjNLSFZnTEszeDdPaXNENkYwdUtHalFBRUY3MStCaW8r?=
 =?utf-8?B?R1poRkRIQWNqZDV1VDFkaUZrOXQvRjV1ekhRdFc5VURsa1RvT0hFNU5sWlN2?=
 =?utf-8?B?VENHT0s3RythV1kyZXlPWGplaUlGMkFibTZJeWladkh5OXFJUTVyOE4ycGs5?=
 =?utf-8?B?bzRmdmU1bWN6V1dvTkF5QWg2RVNZZUV0VDd1SmY1YjBJZDcxUnVsMTdHQ1lk?=
 =?utf-8?B?cGEwZ1RxZTIwTk5RTkF6S25VcTdMQjJoV2JlTkxLQSs0aXhROVRpZDl2Rjk1?=
 =?utf-8?B?VmdXbTZPOEJJT0VTMm0yMDNIKy94bGJwRHJqYlBtWDJiRE1XY21HbkNUV0p0?=
 =?utf-8?B?NE5RWjJ4SHNjMnBPVHVPSFZ4enFLSWFCSDVNVjhEbEJENngraEFlaklkblZW?=
 =?utf-8?B?aVJLOFJ2bzYxZlJiaW1UTEZBN3FuWm1sK0NsV1FyNnQ3N256TDNLQ0RndDRN?=
 =?utf-8?B?RndYbEhFRVVpZ1JxNTVwMEFoYitCa0xxZHNIRjU5d3dyd0ZrY1BubWgxWTkz?=
 =?utf-8?B?a2t2OUNMRnpBTkMvVDZ5b0FGTTRLQ3FvVW5SS09YMWhGOWRPZ1BaTzJOd2g0?=
 =?utf-8?B?c25EMFRVM3U0TWM0TnVta0FjYzJISUNVZlpKeENCK0JpaWc0S0tQRDRLZXRm?=
 =?utf-8?B?dDdtZmNGaHRVM2ZFd0FidWpUeC82RnR0MWtCeVpTait4UExtcTBFZlZoRlJF?=
 =?utf-8?B?bTVtSkdGTEUxTjYwczVVVnJBUHRKWlZOZlJzTXdUUkx4Ynd5MGI1NzRFQVVl?=
 =?utf-8?B?NTl2SC9IWm54dllGYzl4cllHN1ZLME5zNytYMXVMbWpzR0ROTmxVYm1zTlVL?=
 =?utf-8?B?OU5SZ0RwV0F1YkNlZ3ZTNkdRQWlpL1dZamVzTytZVVVLQTE5T2tGNXBwR0Y0?=
 =?utf-8?B?bkM1N0lNL0t4bVA4UzY0OWZHZkNzWE1ueHl1SGZjcnlhYm9LQmNyenBjOUtJ?=
 =?utf-8?Q?UIwhgz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDZYMXg5MHhLMHNhblFWQlhoRWlHU09wZjNQNFAwWmk3cnRhaC9PMVdYY0Vy?=
 =?utf-8?B?eThEVnYrMjVuV0tNNkxsTVhHQ1BXem9MSUFwMnFHNnhwcEtXQzJzZDhmQTFs?=
 =?utf-8?B?STErZUhXTm82VnhDbVp6c21qbWV2VklyUC9WYWpKcFV3eEtUeVR1WmpYK0ph?=
 =?utf-8?B?YU9Qa2V3Vm5yWldkZm0wRTdYZVErUm5YZDAyTnFOaGdNbldMMjd3MjRyTnNk?=
 =?utf-8?B?UXF4WWU1Tjd0VER6TkllM2QvOURERks1alM4NHFuK3dNcXhXRTk0S09oZUZk?=
 =?utf-8?B?WGtKOW4vSExXY1h4RzIvNGV3eHhqZTNXcjJFbVJMK2FtaHVZRHVVckhiNkpl?=
 =?utf-8?B?bmk5SERHbU51S2xhWkFJdWQxL0s0YmRYQ1ZKR3FEK1Z3ZG1OKzgxY1ZBZmN5?=
 =?utf-8?B?ekllck1yRXBrWXl3UUN5dnVPc2JaVThxOG13NURVNmJBblRUUG90QlpVUUYx?=
 =?utf-8?B?blVrWW1nR0pVZWxNVVVNelUrSU1Ea0xvbGtZV2lhMVNmc2pzdy83amVrM1VJ?=
 =?utf-8?B?WE1NYWtEYXh6T1BIUGZjZlVOSHVkaTVvSnN0RllnUlRRcm1JbS9qc0JURE1F?=
 =?utf-8?B?RzBNK01LRWVCSEdvZ2Z6RXdnaUZWVXAwUHd5ejR2N1ZkYm4wK1VoQ3pjS2w3?=
 =?utf-8?B?K3RVdHpySGVkMlU4Z1hkeVpNQklUbVNpcW8vNVpaYzUrZVJQVHpiNFg4VWJn?=
 =?utf-8?B?Ukw5OHdpdFZNU3p6Nlp5dzYrMFdmb2VuY05uTHZ5ZmhLOTZqaVNOK0phQWpD?=
 =?utf-8?B?dGJPa3p4WUVYTUVyZ2lObTQrSi8zRnNTUEtYUVRScUdrUkxqek5IZkdid0dQ?=
 =?utf-8?B?bkQzMEFzdkRNMENPVlJsWGVhblVRTVo3d3BHaStzVmFmOWNwdyt1eXladVNq?=
 =?utf-8?B?VTF5SmdRcHhhNW5XQ1Vjek9NZWx2emlFbFpnaEZPNGVMaE1lVE10UWhFTkd4?=
 =?utf-8?B?ZlY5cXQvZDg1VDg4UGtEWkdCNndva2R4NERHUkpuVnNjdUVnWFFGeURqR1Br?=
 =?utf-8?B?UnA0cnVSN3BFSlAvRVBqWEFZUEcyWmlacWNMN0hoc2lVcXNyZnpCenFFMUpo?=
 =?utf-8?B?NTd0UWMwdC9LUDZyVG10K3RQS0ZNelU2dWM0V2l5Vkh2Z216N3phZDBNUnBl?=
 =?utf-8?B?UnY4NXVQVVlXOFB5ZVFIc29tZmt4VlQ2dEE3cGpCT2dtLzRud2k3bjAycHJQ?=
 =?utf-8?B?RW0wQWMvVnBuUHZqY3doWTdUYUdQbmZsdmdQRkQ1WUlOeFdVZ015enR1eFVG?=
 =?utf-8?B?TE1lanJpZThlWDllUVEyQndKV0QwNUhDdVV3VElxV3kyNkNCenFNMndReUtX?=
 =?utf-8?B?WDJYMFRTK1EzS3BqZ3VrNHY0MXJnNFV4MVhab2xJaUttYTlUTGRGbHcvNCt3?=
 =?utf-8?B?MStJMWFzbWRWWkZMWnEvZTRNbFlOODhXL3dtRlEybWlVS25oT2Z3VzJYOXdr?=
 =?utf-8?B?em1kTGtlcXprT0lOVUtTbDZNUmJTai9JdmtyWE50Mm4zampEa0Z3TVF5eHRq?=
 =?utf-8?B?eDNZU2RpN2xRZzZ0QVFtYk5YMFI4UlN6TEpvckRCNmVidFBCWlpaMGU5ak8v?=
 =?utf-8?B?bytMUUxiZWF5bFdBZjE4NmFUb2pzUGJ6cG5BV21uTThOYTQ3elkvaHdRdDlB?=
 =?utf-8?B?UklMZFZjTHJxMkJ5cExqamd4eDRRWW5ZR2VlTjZHZTllZDRaZ2pRVXZpY1U1?=
 =?utf-8?B?b05RL0hTcmFaOTJMUHN4N3ZXOUxUYm5yY1JUMFV2MXdJR2llUzd4N0xSL1dt?=
 =?utf-8?B?VFFQYUEvT3QrcXo3SFkrVFhMUU9aZmp1SFRxS0ZIRHdnVEJhOWFrUGJncEFr?=
 =?utf-8?B?MnczQktmYnZJNGNlNTZnZ1JLait2ZzBTL2w3cWRZSTJ2Z0t1Z1N4TmJrbkpq?=
 =?utf-8?B?aTg2c1RoYVZ1Und5OTFKV2VvdHlzdnFIaWIzK0J4RGRZdWlJNnB6d2RJV2s3?=
 =?utf-8?B?RW5zN0lVdEh2MkdvZlhid1JvVEk2cm1SaWxhUkJiOHBBKzBDL244RER4RWNq?=
 =?utf-8?B?TzRiWEJjeThRWTFHVzNFRm9lQm4yR04yQkhvM3VxYlc4ZFJTWC9FbUlIc3hD?=
 =?utf-8?B?QlNhZEJDY05IUDdzQlVveUoxeHlZdDNSbk43TnFwV2hjcjBvdTJXT1JsRUk1?=
 =?utf-8?B?NUNJQVlHdzJNTmt1ZENNOGJuUlZKUTJpbGVKZTFITkN2Z2VRS28wZHlEOWtS?=
 =?utf-8?B?U1pod2xtUDVNMzRSSHlPVTA2YTkyb2VKamhwWkRoR243OThEaUJuYnhNVlRG?=
 =?utf-8?B?OUVnTEVtbnpoODdtNU9iSzFHbWRDL1Q4ZG45MCs0N08xRkp2V1pRMUgyOGJL?=
 =?utf-8?Q?2siZUwZXpqIecrPCJ/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: andestech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98efee19-8111-4071-3101-08de3ede6c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 09:10:14.9728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPXtLvHlakMxNZZ3k1d4KzqJTmp01wALYn1MnhMk6b+5sABcUF5A3RvwUrp8ViSIYme2TVKqnXwwpkuHtylKDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7323
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=alvinga@andestech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ2hhbywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGFvIExp
dSA8Y2hhby5saXVAemV2b3JuLmNuPg0KPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDE5LCAyMDI1
IDQ6MDkgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogYWxpc3RhaXIuZnJh
bmNpc0B3ZGMuY29tOyBBbHZpbiBDaGUtQ2hpYSBDaGFuZyjlvLXlk7LlmIkpDQo+IDxhbHZpbmdh
QGFuZGVzdGVjaC5jb20+OyBiaW4ubWVuZ0B3aW5kcml2ZXIuY29tOw0KPiBkYmFyYm96YUB2ZW50
YW5hbWljcm8uY29tOyBsaXdlaTE1MThAZ21haWwuY29tOw0KPiBxZW11LXJpc2N2QG5vbmdudS5v
cmc7IHZpdmFoYXZleUBnbWFpbC5jb207DQo+IHpoaXdlaV9saXVAbGludXguYWxpYmFiYS5jb20N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzJdIFJJU0MtVjogSW5pdGlhbCBzdXBwb3J0IHZl
cnNpb25pbmcgb2YgZGVidWcNCj4gc3BlY2lmaWNhdGlvbg0KPg0KPiBbRVhURVJOQUwgTUFJTF0N
Cj4NCj4gT24gTW9uLCAxIERlYyAyMDI1IDA5OjQyOjUzICswODAwLCBBbHZpbiBDaGFuZyB2aWEg
d3JvdGU6DQo+ID4gVGhpcyBzZXJpZXMgdHJ5IHRvIHN1cHBvcnQgdmVyc2lvbmluZyBvZiBkZWJ1
ZyBzcGVjaWZpY2F0aW9uLiBUaGUNCj4gPiBlYXJseSBkZWJ1ZyBpbXBsZW1lbnRhdGlvbiBzdXBw
b3J0cyBkZWJ1ZyBzcGVjaWZpY2F0aW9uIHYwLjEzLCBhbmQNCj4gPiBsYXRlciBuZXcgdHJpZ2dl
ciB0eXBlcyB3ZXJlIGFkZGVkIHdoaWNoIGFyZSBkZWZpbmVkIGluIGRlYnVnDQo+ID4gc3BlY2lm
aWNhdGlvbiB2MS4wIHZlcnNpb24uIFRvIHN1cHBvcnQgYm90aCB2MC4xMyBhbmQgdjEuMCwgd2Ug
YWRkDQo+ID4gJ2RlYnVnLTEuMCcgYXMgQ1BVIHByb3BlcnR5IHRvIGxldCB1c2VyIGNob29zZSBk
ZWJ1ZyBzcGVjaWZpY2F0aW9uDQo+ID4gdjEuMCBieSBzcGVjaWZ5aW5nICJkZWJ1Zy0xLjA9dHJ1
ZSIuIFRoZSBkZWZhdWx0IHZlcnNpb24gaXMgc3RpbGwgdjAuMTMgaWYNCj4gJ2RlYnVnLTEuMCcg
aXMgbm90IHByb3ZpZGVkIGFuZCBzZXQuDQo+ID4NCj4gPiBGb3IgZXhhbXBsZSwgdG8gZW5hYmxl
IGRlYnVnIHNwZWNpZmljYXRpb24gdjEuMCBvbiBtYXggQ1BVOg0KPiA+ICogLWNwdSBtYXgsZGVi
dWctMS4wPXRydWUNCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgdjI6DQo+ID4gKiBJbXByb3ZlIGNv
bW1pdCBtZXNzYWdlIGFuZCBmaXggdHlwbw0KPiA+ICogQXBwbHkgIlJldmlld2VkLWJ5IiB0YWdz
DQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+ICogQXBwbHkgc3VnZ2VzdGlvbnMgZnJv
bSBEYW5pZWwuIFVzaW5nIGJvb2xlYW4gcHJvcGVydHkgaW5zdGVhZCBvZiBzdHJpbmcuDQo+DQo+
IFRoaXMgaXMgZ3JlYXQgd29yayEgVGhhbmtzIHRvIEFsdmluIENoYW5nIGZvciByZWZpbmluZyB0
aGUgc2RleHQuIEl0IHNlZW1zIHdlDQo+IGFyZSBvbmUgc3RlcCBjbG9zZXIgdG8gbWVyZ2luZyBy
dnNwLXJlZiBpbnRvIHRoZSBtYWlubGluZS4NCg0KVGhhbmsgeW91LCBDaGFvLg0KUGxlYXNlIG5v
dGUgdGhhdCB0aGlzIHNlcmllcyBkb2Vzbid0IGltcGxlbWVudCBTZGV4dCBpbmZyYXN0cnVjdHVy
ZS4NCldlIGhhdmUgc29tZSBwYXRjaGVzIGZvciBTZHRyaWcgYmFzZWQgb24gRGVidWcgc3BlYyB2
MS4wIGFuZCB3ZSB3YW50IHRvIHVwc3RyZWFtIHRob3NlIHBhdGNoZXMuDQpXZSBldmVyIHN1Ym1p
dHRlZCB0aGUgcGF0Y2hlcywgYnV0IHVuZm9ydHVuYXRlbHkgdGhlIHBhdGNoZXMgd2VyZSBibG9j
a2VkLg0KVGhlIG1haW50YWluZXIgdG9sZCBtZSB0aGF0IFFFTVUgc2hvdWxkIHN1cHBvcnQgYm90
aCB2MC4xMyBhbmQgdjEuMCBmb3IgYmFja3dhcmQgY29tcGF0aWJpbGl0eSwgcmF0aGVyIHRoYW4g
ZWxpbWluYXRpbmcgdjAuMTMuDQpUaGF0IHdoeSBJIHN1Ym1pdHRlZCB0aGlzIHNlcmllcywgdHJ5
aW5nIHRvIHJlc29sdmUgdGhlIHZlcnNpb24gaXNzdWUuDQoNCg0KU2luY2VyZWx5LA0KQWx2aW4g
Q2hhbmcNCg0KDQo+DQo+IFdoYXQgYXJlIHlvdXIgdGhvdWdodHMgb24gdGhpcywgRGFuaWVsPw0K
Pg0KPiBUaGFua3MsDQo+IENoYW8NCkNPTkZJREVOVElBTElUWSBOT1RJQ0U6DQoNClRoaXMgZS1t
YWlsIChhbmQgaXRzIGF0dGFjaG1lbnRzKSBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgYW5kIGxl
Z2FsbHkgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbiBvciBpbmZvcm1hdGlvbiBwcm90ZWN0ZWQgZnJv
bSBkaXNjbG9zdXJlLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3Ug
YXJlIGhlcmVieSBub3RpZmllZCB0aGF0IGFueSBkaXNjbG9zdXJlLCBjb3B5aW5nLCBkaXN0cmli
dXRpb24sIG9yIHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpcyBzdHJp
Y3RseSBwcm9oaWJpdGVkLiBJbiB0aGlzIGNhc2UsIHBsZWFzZSBpbW1lZGlhdGVseSBub3RpZnkg
dGhlIHNlbmRlciBieSByZXR1cm4gZS1tYWlsLCBkZWxldGUgdGhlIG1lc3NhZ2UgKGFuZCBhbnkg
YWNjb21wYW55aW5nIGRvY3VtZW50cykgYW5kIGRlc3Ryb3kgYWxsIHByaW50ZWQgaGFyZCBjb3Bp
ZXMuIFRoYW5rIHlvdSBmb3IgeW91ciBjb29wZXJhdGlvbi4NCg0KQ29weXJpZ2h0IEFOREVTIFRF
Q0hOT0xPR1kgQ09SUE9SQVRJT04gLSBBbGwgUmlnaHRzIFJlc2VydmVkLg0K

