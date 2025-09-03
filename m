Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23CECA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utjAn-0003Un-DZ; Wed, 03 Sep 2025 04:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utjAd-0003N8-6j; Wed, 03 Sep 2025 04:48:48 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utjAZ-0007OT-Cu; Wed, 03 Sep 2025 04:48:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U99Bd053WpRr+cXzus5kgUpf5C3VEqZ3rR5gsNcGBFDQ4Gn2sD97o6wToLpRRmMcmopOwN0L/mZqfCZyxLjp/x3Uz0znn3EB+BFs99EAXe6gEETh0TyRTjyoOKWAwxQunVcrg4reLbe4raLb98EbGRcPL2JMSpJMEjVHvWjiV+BAcYOmiBj4eLvK9S1h59AdW4y75J+8nqONqkjxZvUQ87vCo8GD9N/a4XU6QTmQveET4DdFIprnfZct3lVTXNU1j+IJJKl4q9s5Mz+Dw0MivUddkorB9rcLrWTUxpUkofGD9jWiHhTLOhYMm+wJEct3QybTXb7dRTOB1LnlWUks5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihJDRBp68aWXqcTRD5IXzlR4m2x0sMvL8Rd9VbHQkiQ=;
 b=EEkQ5Xc+XjH34H1vnEcXsH/C2MbwV6rPXd95H41u4NHSHzuGaOh5wr5xwDixya0d+6SPunPuYwGUm27TsN0m92Eu/CYhI6pexZpGTYbmo3gNAexq4ezjQwe+yApQvusndc1FLP0bxWCt4vQv5Qwt2qdCN2DrT93xgW2tWfk0dSx8mD9fbWOpHRwo3o90ZVyfdZx0PIJ4j0xuWuJ5on9NRgoQO2RnndrNqdhj083lZ4rViZQc1Pp6V3dzuaTx9//5tvTnnDA578tA0pk5H+mdWD+CsQ9C/VQ1+5EVDfZaUpGIyuap6hu2LjMhFw9ssFLK8S/+OFZbhRHzlOMOR3RY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihJDRBp68aWXqcTRD5IXzlR4m2x0sMvL8Rd9VbHQkiQ=;
 b=sCWGOHdNaZtXLb6hdDpbrauyYhv4L6d9o/MhzyHjfXBFwSp0wIhmwfG8GiA2ebp4M9cMYj9ln+6Z30n1Fr+JgRrFRycUsW6fNEy7yKc8i/C6DawUOYlwvQNCNxBdqHjfbElM91431RCgwKL9VoarrMneKTWSX1qEtykmo0OattK/1BA2FneMj+5rFDxL65IgrRnr17dLXVYkz1aAG7uZrZDoC1XKo3aiTDRLfdVulc6AQDRKQEXZG78A27mqLmEsQPCbHwuwcQi7G8U5f2Oga9wL4cZNIGrEEqACsqBNej9mww8B342IwwJrSEF8MvVVAsMAgaJcoCrNmDdHwY1Erw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB5887.apcprd06.prod.outlook.com (2603:1096:301:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 08:48:35 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 08:48:34 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 01/21] hw/arm/aspeed_ast27x0-fc: Support VBootRom
Thread-Topic: [SPAM] [PATCH v1 01/21] hw/arm/aspeed_ast27x0-fc: Support
 VBootRom
Thread-Index: AQHb9sydZv8OumUorEiKpzfB6N2+/rR/sJSAgAAmBtCAAFVPAIABBzXQgAA9vjA=
Date: Wed, 3 Sep 2025 08:48:34 +0000
Message-ID: <SI2PR06MB5041D4C5CBB1C214FE76C10AFC01A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-2-jamin_lin@aspeedtech.com>
 <9e7ec38d-7bb9-4f1e-b75b-96c3eec97024@kaod.org>
 <SI2PR06MB5041202A90343458D2BE7724FC06A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <f17784ea-80dc-4ca5-ae46-b73752e40905@kaod.org>
 <SI2PR06MB5041FC53142AA1F6461BB0ADFC01A@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041FC53142AA1F6461BB0ADFC01A@SI2PR06MB5041.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB5887:EE_
x-ms-office365-filtering-correlation-id: bfd73f5a-31aa-4ec6-c87e-08ddeac6aa9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?VTNoWXBMa2U1TE16TVU1ZDRlbGpRMUp6c2o4dEtzWEpMMjFDK0tNYkFkRXps?=
 =?utf-8?B?Z28xZjNTUWdST3hBZU9adG5IdFdrWEFjYW1BNUFQVjRobWNCblJxSmFaUURx?=
 =?utf-8?B?RU1nMEh5VjZQb3FsTlJILytQcWtZTTNYRnFzbDBSVnJRdGlvaHRLWGZRejhM?=
 =?utf-8?B?YmRNd01TT0ZSaTU1TzhrTFFtb0F6WWQ5cVFMaGliY0dXMnNXTWNXU2FYREV1?=
 =?utf-8?B?T3JPQlBDditoSkVla0EzUUNqcW1YbkhsZkZTZHEybU5PMHArWDZocXFlemtU?=
 =?utf-8?B?ak1JTUJnZm5sR01TRkI1QlFGUTRsalVOWG1HSnJUS3FKWkxGZTd4d2lxUzZk?=
 =?utf-8?B?Ry9ZYTVBeHpSUW5NMG4rYVo3Z2N1ZkxoK1ZDQ0xmYmtpemo5RXJEU20vaGtw?=
 =?utf-8?B?bzM5VlFwam5qcWUzMVhVRm5JaUR3blo0b0xBRnhlanJJNGdnK1NjWmJ1OXNY?=
 =?utf-8?B?bHFTOUYrQWY5OW5hMjRrL1llcG9GcUFicDNsMHVla2JOc2d1SG9PeTRsamFn?=
 =?utf-8?B?c3BSNmh2UGRjQS9RVDAxQ05SenRhUmYxVXRXOVM4TWRVbnlYM3Q3d3JYYlJK?=
 =?utf-8?B?cDhiM2ZMSGdpcE82VWZvdXFyNlRVNTNLUnZnRXZRdEdEYThPQXY5UlVjY0R4?=
 =?utf-8?B?Z1VaQkJCa0hJS0FienNyTndNS3UzY2MxWlI3ZkV3empzaWNmdGdqbCtqSlpM?=
 =?utf-8?B?WFpXblpPdkY5WHlkUmtJSDgweDFwQzU4L2JoTStKdWF5aVFKTGRQNkVQQ1Fi?=
 =?utf-8?B?ZElnODgvRFY3N281bjRPbmhkK3VUMklGYlpLQnZoL2RmL0Y5SUhFNitLSlVj?=
 =?utf-8?B?TVZocHZPbFQ2ajRySWx2enh0VnVydElzMDdQVWdCdmhkZ2VOUGo2NzgvOU5m?=
 =?utf-8?B?RU9FREFoZnM4bVdrT0dCL1BJZHJFYmg2MUV4YWhlMlMzdklsL2RiVWc3U0lX?=
 =?utf-8?B?MXZ2Y0pzTXNoZm00R3MxdHRxclZtUDV4Zkh3SHBZbnNqVU9MNzFWVENIRms0?=
 =?utf-8?B?Zld6TEF0ZDcrb253dE1XR1pvcWp5bytRajZwQlQ1anJ5bUs2NUlSU0l2Szgz?=
 =?utf-8?B?RGg5SzNoVDlCclNhK0VEUTBkK3NuUTdOUFFiQ2swUUVGbjRQczR5NnBLWnpo?=
 =?utf-8?B?RUduVWRDNDlmSWRMM2FYQzJ1bE91WUthUWNQVGwwODBLcnRWU2cwdnlYejVn?=
 =?utf-8?B?LzRPM1g2cWpmdXI3bHZsVXFnRmdJMm9lNStNZWN2UXYzRkJhejBuTWVuT0tO?=
 =?utf-8?B?ZW5KVlk1TWsxdDlLeVVRcGJZeEg5WkZvSFQ3T1J0NitQa0pjdkc1T292RjV3?=
 =?utf-8?B?NjJpaytvWjJQYnp0eStuNStmVTNrTDJXNDgwQ0dzRmFtdWpaTldxTFN1TDFl?=
 =?utf-8?B?YXRPeWVLUHJBVVVYbnMzcjBodHJiY1Jlc0lDUTgyelp4VVVVWHJOa2pvcnY3?=
 =?utf-8?B?Y3VqbGhDbG4wNHBKTjBmTzdENHMvOWxweDgyU3FwODAxbWZOV0JNMkluSnRB?=
 =?utf-8?B?VWt6elNvaGFVSFNTeXJHRWc4c0liaWQ4dFM1b0Zhbmd1Z3pjNExOelJlZWFp?=
 =?utf-8?B?TGFCV0pPVDNzOGNTTmkyZ1BEclpYRXFpYnk5Tm5KVmRDK0RoWjVjTzdsSkhX?=
 =?utf-8?B?R3JPV0NHSTdMMTJGYWkvL213REdnR3FjVkFyazBjdXZkOFhFVHVwVFU3eFZH?=
 =?utf-8?B?SHRlaEJFa2ZGWVBQb0Q5MFRxT0g4R0dUVzk3bnB5UU1IUHYxSkt1Rm9sRjFG?=
 =?utf-8?B?ME44aVhyNDk0a2thellGV2p2YWx6cEFSYnA0OFczeGVBaHJqQ2VzYkRVa1I1?=
 =?utf-8?B?RjZJblJsOEJiVGFoWjM5SWxtRWs5YnZhZHliMTRNNDh4R3M4a2Zpa25VcXlo?=
 =?utf-8?B?dzVPWEdqbEpCS1lGY3BHcVpSeEVOUHQzRUVQUllWcHF1YXNGeXk2V0JEejhO?=
 =?utf-8?B?VFRXcEc4MTZSV3puUmNYS2FVYVpwRzQvZ2ZxNElBQnRHZ3c4NWdqd2tLVUk2?=
 =?utf-8?B?K012WTN1RTAwUHVkTWo0K0pqUkxmdXA4UTBMMkFjRWRLZEdBd2xtcC8wL3kr?=
 =?utf-8?Q?UT3FhH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2VyRi9wSjBRRlBrcks2dForaG9nZGJBd0U3NVNRNEVTSm82eEVoZkMrTkpR?=
 =?utf-8?B?K3N4blZWWHEvY1hYUCtGYVhwU3NaRC83Z3ZEdjYxUGpRNEYzZFU0ZlVpRXFm?=
 =?utf-8?B?TEg4NDlsVno5UngvUTdPbERFODlpMkxTQXRQZFdXUVNTOFVxT3FpY3JNTDdY?=
 =?utf-8?B?WXBxS3Z1cUxKTkh3Vll0Ykg0b1lrL1hDMHF0TlAyckN4dXJOMGFYbWk0YWFP?=
 =?utf-8?B?VmY4czEvd0hienBTRHJNTHJCWTZoUUtCOUhtdHVERElCcHRrWXRxWWd4RkJB?=
 =?utf-8?B?OEhoWUQ2UWN4RkZiSFh6b0x1OGMzbC9uRkxZZS8wMGltV25Ub0hBY1RodWRp?=
 =?utf-8?B?cXNOVE1PNXZoYUZURGN2Y2pjQk1ZalpKcFlrdlhGbFhXcjBZU1NyN0ZsU0ZC?=
 =?utf-8?B?NW0ydDdBSm1rVUU2ck13TG5lUnZKamNIdEpXK29UbXI2KzZIaDQwczV0TXhD?=
 =?utf-8?B?ZExPUEVwTjI5SS9PZXpCaHJHYkJoMERmMk4rYzA4YStQUG93MnkzYmtLbVla?=
 =?utf-8?B?bE9BVk52VFZIdDl6YlY1Sjg3a3RzQUpuRE9Mem1QTGczOWgwTTFIQVMwYVYz?=
 =?utf-8?B?VTRnQmdkUHVzcENoVUZNeHkwRzJmQnZJWFRnSTlGTHltMTEwTGQxV3NmQzZz?=
 =?utf-8?B?MFI1VGFENnFRbGRpUXRqQzZ3YTdBMko5cHp3eGZVU2J2QXhOTE5EMFZGSW1z?=
 =?utf-8?B?cUdzL2VCbWpXSXNjUEtIYUxUNkd0bmp2c0xnMVRieDJ2R1pWZXdJRnl2QnFZ?=
 =?utf-8?B?c0hIUXY4ZGxvQXlmdVVmUlVtamlwZjhlTFZlSFFmcFJ5UEdjbFF5ck9lR1dZ?=
 =?utf-8?B?VjgxcTB6cEhpZTk5TFhQOEk2TFptTUhyZ09rYUJLcytxMjYyT2t1SlY1NEw1?=
 =?utf-8?B?TXRPendQM2tLem0wMEJXMUNYZmRINThuMnBQL05jeHBjd2Q5UGVTU0o4b214?=
 =?utf-8?B?YTIzUk10ckFtbFA2czltTUhnSFhPMHh4SnNuV1NEd29xNGRheGlWMFA3d0hs?=
 =?utf-8?B?UHNsVmIxWmV4OWVtY2RnUUJJa25nU0ZxNEMzL2thcE5hWXRjZlExSkVQeVFG?=
 =?utf-8?B?V3JuRmFubGMxaEhuNUVHUVAzdk5pMUpPVnJZT0dMc2pJZlRqNTI4cmxzSjRk?=
 =?utf-8?B?QjdRS01sRUU5dUNQbXliVkx6ZElkWWpOcnV6K29jdTN1dTIrMlJvREdzVnUz?=
 =?utf-8?B?eFBiQlJ4NGgvbzAva05UOXlIS2JzZG1HVS8yOVFHOFVVQmNDK1FDWHVEc2RP?=
 =?utf-8?B?Z2EzN3lER3kzN2w2MnovZWo0VER3MVJVNkFBdi9lZkF3OG1NUG9IZllibW5C?=
 =?utf-8?B?UDdwaDh6MlMvckpwNkhXeks0RnBlTVlLZEh5VGV0QVk0cVk3c1J5MDB1VHFk?=
 =?utf-8?B?VEE2RlFsWUhVUWdVRzRrQmxabDA1NDRqOER4KytSZjZXRngwZy9jeXFZMkFH?=
 =?utf-8?B?M2lUQnpGU0d6Ykp2a1FBclJiVjlDSk1hNU1xcHhYZ1FTMDUzSmx0K295WHJ2?=
 =?utf-8?B?TUVPZkFUQ1Z4WUJWdGlaTFhoZG9IWStlWWFOU0V2dzI4RXN3RHV5V2tIRWwv?=
 =?utf-8?B?OXh3LzYvVTNHK3hEaWRkSk8rV2VjTGVJQ3dRUVN1UmpvcjFlcjVDN0g5R2Nu?=
 =?utf-8?B?YkszZEgxTGY4QjdRY2I1dDZQZDR1dUlRK3FoTXVlZ0ErUW80YXhSdnBRZ1RT?=
 =?utf-8?B?VnZOcEtpQWJtUXh1dGp1RTc4SDNDc3NtWjFicXU1bi9na215U1Y0cjFXZ2Rk?=
 =?utf-8?B?OVVIa3ZvNnVzMHJMZ2dXbXFIbGY4YWVydi9DRkE5QVkyRjZoUG1Dd3lvc3Yv?=
 =?utf-8?B?T09tMDZNeVBYWmhEeDBiQy9BaVdWUjhoSmxaL2lSbTJjRW0xNXg4Y3c5eXM2?=
 =?utf-8?B?MzlZVVlXNFZCK0xubDNhZHlRdnlzMEZjOVJ4Z1hMQ3g3RDQ1QkYxNlJvTXRy?=
 =?utf-8?B?TGJOb1hzcUliaThRQUM3UURZN2ljWjZkM1Btc3lPZyszWjdKci9KME1XL1Fh?=
 =?utf-8?B?MFlIbGlEa3l5UWpDRjJQY0lNRkEzUWYzc1YrN3BMV1ZVZ09SNXlEN1RYMmxj?=
 =?utf-8?B?bUc2MUcvNldwc3Y1OURrWkZHRXhiQ1ZubDJyWnNQbzZiWExCTnkzalZKK0xO?=
 =?utf-8?Q?NzfiM6QicWF5fOLh5b4rxhlfJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd73f5a-31aa-4ec6-c87e-08ddeac6aa9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 08:48:34.3088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lSmbNTKqA3kFM0iElbYnRB7ghISgvwoOcP0v0z/8fWy/7/xNvx5VEXcIhtSNyshbYqJ8sq8EIhD6pUJthny1McN1gPCcM3fwase/6o5h0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5887
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJFOiBbU1BBTV0gW1BBVENIIHYxIDAxLzIxXSBody9h
cm0vYXNwZWVkX2FzdDI3eDAtZmM6IFN1cHBvcnQNCj4gVkJvb3RSb20NCj4gDQo+IEhpIEPDqWRy
aWMsDQo+IA0KPiA+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDAxLzIxXSBody9hcm0v
YXNwZWVkX2FzdDI3eDAtZmM6IFN1cHBvcnQNCj4gPiBWQm9vdFJvbQ0KPiA+DQo+ID4gT24gOS8y
LzI1IDEwOjI4LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gPiBIaSBDw6lkcmljDQo+ID4gPg0KPiA+
ID4+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDAxLzIxXSBody9hcm0vYXNwZWVkX2Fz
dDI3eDAtZmM6DQo+ID4gPj4gU3VwcG9ydCBWQm9vdFJvbQ0KPiA+ID4+DQo+ID4gPg0KPiA+ID4g
VGhhbmtzIGZvciB5b3VyIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCj4gPiA+DQo+ID4gPiBQZXIg
b3VyIGVhcmxpZXIgZGlzY3Vzc2lvbiwgd2UgcGxhbiB0byByZWZhY3RvciBody9hcm0vYXNwZWVk
LmMuIEFzDQo+ID4gPiBhIGZpcnN0IHN0ZXAsIEkgY2FuIG1vdmUgdGhlIHZib290cm9tIGhlbHBl
cnMgaW50byBhIGNvbW1vbiBzb3VyY2UNCj4gPiA+IGZpbGUgc28gdGhleSBjYW4gYmUgcmV1c2Vk
IGJ5IG90aGVyIGJvYXJkcy4NCj4gPiA+DQo+ID4gPiBEbyB5b3UgaGF2ZSBhIHByZWZlcmVuY2Ug
Zm9yIHRoZSBmaWxlbmFtZT8NCj4gPiA+IGh3L2FybS9hc3BlZWRfdXRpbHMuYyAod2l0aCBhIHNt
YWxsIGhlYWRlciBpbg0KPiA+ID4gaW5jbHVkZS9ody9hcm0vYXNwZWVkX3V0aWxzLmgpLA0KPiA+
DQo+ID4NCj4gPiBUaGVyZSBpcyBhIGFzcGVlZF9zb2NfY29tbW9uLmMgZmlsZSBmb3Igc3VjaCBo
ZWxwZXJzLg0KPiA+DQo+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb25zLg0KPiANCg0KU29ycnks
IHBsZWFzZSBpZ25vcmUgbXkgcHJldmlvdXMgY29tbWVudHMuICANCkkgcmVhbGl6ZWQgdGhhdCBJ
IGNhbiByZXBsYWNlIEFzcGVlZE1hY2hpbmVTdGF0ZSB3aXRoIEFzcGVlZFNvQ1N0YXRlIHRvIG1h
a2UgdGhlIEFQSSBtb3JlIGdlbmVyaWMuICANCkFwb2xvZ2llcyBmb3IgdGhlIGluY29udmVuaWVu
Y2UuDQoNCkphbWluDQoNCj4gSXQgc2VlbXMgdGhhdCBhc3BlZWRfc29jX2NvbW1vbi5jIGlzIG1l
YW50IGZvciBjb2RlIHNoYXJlZCBhY3Jvc3MgYWxsDQo+IEFTUEVFRCBTb0NzIHJhdGhlciB0aGFu
IHRoZSBib2FyZC1zcGVjaWZpYyBjb2RlLg0KPiBJIGFtIHBsYW5uaW5nIHRvIG1vdmUgdGhlIGZv
bGxvd2luZyBBUElzIGludG8gYSBjb21tb24gZmlsZS4NCj4gDQo+IHN0YXRpYyB2b2lkIGFzcGVl
ZF9sb2FkX3Zib290cm9tKEFzcGVlZE1hY2hpbmVTdGF0ZSAqYm1jLCBjb25zdCBjaGFyDQo+ICpi
aW9zX25hbWUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJy
cCkgc3RhdGljIHZvaWQNCj4gYXNwZWVkX2luc3RhbGxfYm9vdF9yb20oQXNwZWVkTWFjaGluZVN0
YXRlICpibWMsIEJsb2NrQmFja2VuZCAqYmxrLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1aW50NjRfdCByb21fc2l6ZSkgc3RhdGljIHZvaWQNCj4gd3JpdGVfYm9vdF9y
b20oQmxvY2tCYWNrZW5kICpibGssIGh3YWRkciBhZGRyLCBzaXplX3Qgcm9tX3NpemUsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4gDQo+IFRvIGJ1aWxkIHN1
Y2Nlc3NmdWxseSwgdGhlIEFzcGVlZE1hY2hpbmVTdGF0ZSBzdHJ1Y3QgYWxzbyBuZWVkcyB0byBi
ZSBtb3ZlZA0KPiBpbnRvIGFzcGVlZC5oLg0KPiANCj4gc3RydWN0IEFzcGVlZE1hY2hpbmVTdGF0
ZSB7DQo+ICAgICAvKiBQcml2YXRlICovDQo+ICAgICBNYWNoaW5lU3RhdGUgcGFyZW50X29iajsN
Cj4gICAgIC8qIFB1YmxpYyAqLw0KPiANCj4gICAgIEFzcGVlZFNvQ1N0YXRlICpzb2M7DQo+ICAg
ICBNZW1vcnlSZWdpb24gYm9vdF9yb207DQo+ICAgICBib29sIG1taW9fZXhlYzsNCj4gICAgIHVp
bnQzMl90IHVhcnRfY2hvc2VuOw0KPiAgICAgY2hhciAqZm1jX21vZGVsOw0KPiAgICAgY2hhciAq
c3BpX21vZGVsOw0KPiAgICAgdWludDMyX3QgaHdfc3RyYXAxOw0KPiB9Ow0KPiANCj4gSWYgSSBw
bGFjZSB0aGUgYWJvdmUgQVBJcyBpbiBhc3BlZWRfc29jX2NvbW1vbi5oIHRoYXQgaGVhZGVyIHdv
dWxkIGFsc28NCj4gbmVlZCB0byBpbmNsdWRlIGFzcGVlZC5oLg0KPiBUbyBhdm9pZCBtaXhpbmcg
U09DLWxldmVsIGFuZCBib2FyZC1sZXZlbCBjb2RlLCBJIHByb3Bvc2UgY3JlYXRpbmcgYSBuZXcg
Yy9oDQo+IGZpbGUgdG8gcGxhY2UgdGhlbSBzdWNoIGFzIGFzcGVlZF9ib2FyZF9jb21tb24uYyBh
bmQNCj4gYXNwZWVkX2JvYXJkX2NvbW1vbi5oIERvIHlvdSBoYXZlIGFueSBjb25jZXJucyBvciBj
b3VsZCB5b3UgcGxlYXNlIGdpdmUNCj4gbWUgYW55IHN1Z2dlc3Rpb24/DQo+IA0KPiBUaGFua3Mt
SmFtaW4NCj4gDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4NCj4gPiBDLg0K

