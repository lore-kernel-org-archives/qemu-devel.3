Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF15606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=aA3rB3K2;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=UUmUSIWI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVMOQ-0003Xs-3l; Mon, 23 Nov 2026 00:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVMO9-0003XP-Kp; Mon, 23 Nov 2026 00:14:49 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVMO4-0001EW-Kp; Mon, 23 Nov 2026 00:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795410884; x=1826946884;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=use5MTwXtZbY+LwxBuD0ZoQO51/BdPetCU5G21LN5Is=;
 b=aA3rB3K2Zk/FWxHKyePTgXud6obAOfmXhtphPhOBRN0b8JyTuKMghX17
 86gvnL8aIoC8yprJZJM7Ed8eleD5bxBj4eF1Cti1E/j2swkLjl3nvVQBp
 pOIXCgGjq9ntJJwZlfHceA9Wz0Sun+N9I2tnw6KrNruPw/aOiQ6RnX0Vi
 ias471PQbNeMByX+kjjXxrZmRJd1y2YhWCxjsxoFsjlxefmKZvLKMnws2
 SIX4OeUYmO070KOMT6YmjuOwjYduG18PHjANsCce7CvfX1irznRN/6xmq
 nfpEzaXEYyhSKMJBHbgO07IbFopNRiPJSOYqGguu0VLlBPjihpTuDjDRS w==;
X-CSE-ConnectionGUID: 7UitUm/uQAOaQx6mm3AW9A==
X-CSE-MsgGUID: OyjN/Y1uQg2c83/jZKML+A==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="161460505"
Received: from mail-westus2azon11012067.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.67])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 13:14:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWebbhXD55IV+HPvJSo0BdCCpTN3p67mqZguHpozB0ZBlEYjN+YODXEsX1SozlS+9KzpGU7OlmeYVd07hsxA4JO4zScX8uF8xE1daYf5DoZDzDIdp8P1jlsFX2U//mvxo4GD5s11ZRm+j6Ic1sBmAFT3o9HkskfRyDCgg/J5YTAHerRaMul06/L0BBJb9u5B2e54ClyCUKJAT0mpTCh1Tejs0vzM+PAjEYU1dJ2u3eIXqJYCPF372TpR9ZE8ALoUelDz21GYPKciJ6zBQfZIV2nnlMM1xqhfBDBgcptJLcndlUz/ss9iBsyBk2R1HHlmPC1juCESnc/Rsz1rWk85zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=use5MTwXtZbY+LwxBuD0ZoQO51/BdPetCU5G21LN5Is=;
 b=YQ5imP+FXnFOFBBNy5jE/vZU9ablLWF3RU4RuHHVfm4O4rKoxFW4j16AegKEt78FEF3Bu+qLIDMjbuTT2clrenhhWsfZvBqC2YkAolFnYWuDZrR7+yTqvUugbr4H8wQc/x/zY7TS59NIwv6E6/z8hYq9iPQf9ZIoItkTwZf+fO79HsJvlsEBqyjvnGaznhJpBZCzEGfi54WUFCnyUg/E7gwxMgbty4bL4Vw22Ak26+p+GPKSnzZNUDeZRw/Dv746zhv+1RW0uQvjUzNqc8ZNULCiZm2KzaNXaSGzznAFDIEr4B0NztWaFuEXnZU3qlzeottiumqyragSGRG3CHbGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=use5MTwXtZbY+LwxBuD0ZoQO51/BdPetCU5G21LN5Is=;
 b=UUmUSIWIUhDXoMY/BS0pwKl7wwshcn5OCgqXDov7K39dSm+kGlCSSm2JS0Ibpc3Ii6VZfZ6guvhAE6jvRCDlOD3MpKJt2emRBsljyBVtTbcCWEONjQATupJ0N59M/ehiEQzOAIo06WmuZ9nwm1NZP5Ytc1auADMcoK3tR7U8TXA=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CO6PR04MB7524.namprd04.prod.outlook.com (2603:10b6:303:b2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 05:14:05 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 05:14:05 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "bin.meng@processmission.com" <bin.meng@processmission.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "sebastian.huber@embedded-brains.de" <sebastian.huber@embedded-brains.de>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "conor@kernel.org"
 <conor@kernel.org>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>
Subject: Re: [PATCH v5 05/26] hw/riscv: pfsoc: Map the SiFive L2CC memory
 windows
Thread-Topic: [PATCH v5 05/26] hw/riscv: pfsoc: Map the SiFive L2CC memory
 windows
Thread-Index: AQHdbHMhn8kVLyupQUOkcWXg45v+a7c7OgKA
Date: Mon, 23 Nov 2026 05:14:04 +0000
Message-ID: <642324b1decc09b02e1417a8e41479c7e8504d86.camel@wdc.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
 <20261104154207.641511-6-bin.meng@processmission.com>
In-Reply-To: <20261104154207.641511-6-bin.meng@processmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CO6PR04MB7524:EE_
x-ms-office365-filtering-correlation-id: dd455bd9-cf07-4f16-7e01-08df49209820
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|10070799003|376014|7416014|1800799024|6133799003|18002099003|22082099003|4143699003|11063799006|38070700021|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|56012099006|261009223027099003|261021123027099003|261022105027099003|261021135927099003|261102123227099003|10067099003;
x-microsoft-antispam-message-info: DXkrriWUkvnZDdbUIbXSndFidVX50zwQVYz1NvlBm5ZuxjeMVJCZ/6VzJzUY/2B4onfyPOFYq0rxaSfFWYOGaLXwOttW3ETpLlB2Bi7pmo4b8kSmytlT7gFCv7Qu+c3tvl4PBa9D4ezxOQIYf1ll8ICulBxVsGJxKdeCa9MmZbajZ8yCPH9ysnOH+RiNONZxPC0wuWQgN52ugn+Q9OhOkZZtCi/a2YsVwsYJGz6CT+lo8TBTJmAEI0UTyxJePaHSjcfiAADMdvPX2yyZezSWLwECW7791AztVRtt/NvYUzaBnCGi6VxweInGPwVyIcL0Gwfb/XyRrGEbmPngJf8Ws5ba20okxAgzsN2Ne/ksOw/K/UKvZ3KnP6+nzmm4fzJ0Fsr8J3dpNy635ZqkvI1F5D/fzkjG1ByOLvkCtxHbZZhOu7aLRVgCbhS8cE/W0TLsxgevL5ESid1lx5uyXu4SS6dKgD4XWtMBhg4FJ7qNKXxD7XhkVryycGdRMa4/H/JFpZIs/04EIPPryUgpsWm+HCXR/xHFSPyoAMWZF5xuzwNoUHDSgWS28oZYCdDwwveDnKRORZmzO4ykSeigJyDMYRDNtxyzByZ8OZVCEoQpo7TaDzjKJcUT8lH2zLxdmVvw0fkOaCrRISO1dEAVBrMkoueVYrixui8PLBaX2YNAOD+CihJPkkah2tZaF+0BSLkLMIZglwtRMfoLn18fSrugzbMybO3Gu6Hi9C1TlcoLjsM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(10070799003)(376014)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(56012099006)(261009223027099003)(261021123027099003)(261022105027099003)(261021135927099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDN0UUNiS2NQbVJlSFJ6dVNIOXovV2krMFZodUJ4bnQrcm9rZkFsZkxjTGVv?=
 =?utf-8?B?YlR2Q1UyKzQyZnM5eGhMQjZxTzU0ZVBlZ0hBcCsyVkpWU2x5ZlA3TDlVYUtT?=
 =?utf-8?B?eFdEZzE4dFQ5VkRKdlNYMjJMUUJnZjVybzhmY1lES0VJdXJEemVXQUdlVlJJ?=
 =?utf-8?B?a0RwbWdyYWNlakRnMmFkaHFDcE05NVFjd2ttNDBpdjFIcHVMc0pYOWFVbkxF?=
 =?utf-8?B?YkVmY0hUdzFwa0NOS1BYVER2d3IzSzg5VEJCcWM5UWhPODlFV3FielFFL1E5?=
 =?utf-8?B?Zjg1MGJYQ2pvYzRTb0Q1RlprYnpRSEljbWQ4MElTbmYwQzlDMElOSkFYNUcv?=
 =?utf-8?B?cm5EVzN5bHR5NVNWVGdRTEh3TUNvZ0twMUErdEtjckc5YTZQZFVnM3B3bXVp?=
 =?utf-8?B?ejVVaE1aRllmcXhwa0VvYzZaWkRUeW82QWVZWThXYmV0Ujc3UnliUFE3b1A3?=
 =?utf-8?B?NW93ZEtCMGk4anlFaHR1QUMxMVhkUEcxVHNCeCszdjFjWkM2ZSsvTmRENUFr?=
 =?utf-8?B?SWtPVUNhRnQ4TEp2V1dRdlNvUm4za1krWnRYYlgycjFtaERENHpJYmNRbUlm?=
 =?utf-8?B?WHg0SGJPbHdXYkJJbjY2dWhNMVovMGhsOTk1azE2Nk41ME9jSVh0Lzdmb3NP?=
 =?utf-8?B?M0swQUlldXh1MjhLOU5aS2xxNUNMeUMxeFdZMnhEMEFWQnk5QUxrTFkvMmlR?=
 =?utf-8?B?TFVFSC8yZ0tUcE5QSitqMXBDdWZVc0pRM2huRHEwVXY5eGlnZkZYSXRTRndX?=
 =?utf-8?B?cjNXOVJEQlB4ZmF5eEhyRk00a29YbkdnTlpkbzlESlRxK0gyOHVGWGRiOVZF?=
 =?utf-8?B?Y0pIWVBRVjFrWG9DZUY1OXQ5N0dySnRqN24zZ3c1b2o0MmFPU3RoSnl2aGdD?=
 =?utf-8?B?SmdvYWsxSEtjSFVlT2JwRTZCUUJJbW95Q0VlNHpVYlA3Yzc4bktHNVA5R1d5?=
 =?utf-8?B?TkQ3aUY1M3JIMi9UQk9WcGpHbzh5b0gvU1l3K3R4MVl5azIwSHpMTEliSWhv?=
 =?utf-8?B?cSszK2xBRklMNG9kQkg3SFRLa3RVMnFCUHcxaitTM0tWVHdGd0JxazRtQm4r?=
 =?utf-8?B?TS83VFNNUnA4aVJEb3RmVUx1ZnF2VG5GQkFtNTJFWUJMbTVvUDBESmxqQ2c5?=
 =?utf-8?B?Nmo5cDhTWEhpNjhlV1FhczQ2MGwybld0MmZEMWI3cXM4cy9TeVpGejk5Q0oz?=
 =?utf-8?B?eC9TQzB1RDBZTEtCTkcwQnNoVUVUaUF1eEdncHNHaEZHeDdVci9nNDQyOXdn?=
 =?utf-8?B?QVh1aEhjVzJBUFQ1REh0UE9FQmFnUFladkRFcXZrNW5LclpsYmtsSm9xUG5i?=
 =?utf-8?B?bWYwWCs4MEtkMTN6dWV1ZkNvc1d0T3B4ejNMelNTRWUvS2NRaEp0dXFzWUMv?=
 =?utf-8?B?NEorQkN0a1dsK3RZZjJvYjNWRStybnJCb21GSmQ3amhyS2tneDRIZEh6dnNp?=
 =?utf-8?B?aE1iT241Tk9yUmdoS0VoL1puTzN3VHRjd0hnQjViZHBENnhqNVQvbE5HOHB6?=
 =?utf-8?B?VlhwQVhHQmJ6UldwNjJkd21oejEzTXdWZDZNRWZ3b29SbGFXMHdvODh1OEFB?=
 =?utf-8?B?MVk1YkpxSWVmcTE2VUs1WmZ0aDFOb0YzSEQzM1VNQXNCbHJIaytHVnlhV3dW?=
 =?utf-8?B?bGEwN3hEYldjb3FONVdNRXFTYlVuL2pJWk45SkE0V1N0QWlicWM4YkRpVWQw?=
 =?utf-8?B?OEdIcGpQU01WOEcxbElNMnJ4d0pBbHFVM2NzOVV5L2U0eERobDlXaXpJazRq?=
 =?utf-8?B?bHluMWVFRmJTN1p1eGEvZENWbXBGUmIyVkNwUzMyakN2cGY2TTNPYVE4bzUv?=
 =?utf-8?B?ckpJYVo2UjRJR3J0U0VJTE9tbnZmdGc1bnFaRUZmbVIrV29DQVNWS1JlbmYw?=
 =?utf-8?B?T3F1ekMvd2t1dDhxSXE3Rlh4RlNlMTdtZGtObzRaNDNSNHVPMjRsMjc4WElM?=
 =?utf-8?B?ZG1hT012WG5OY3JTVHF5NUNScGozTFVKOVlBYTRNaTZtZWNISSs0ZDllenN1?=
 =?utf-8?B?NkliUjRVeVE3QkJKR0NISThiY0tVUGlGR1UvNyt0dTRZMU5zZWVtdFc3MVBz?=
 =?utf-8?B?UXBvVTBJVXhZMW1IWVhPQVM5dHEraTkrUGZteVhKM2RTNVhZUktuaGZnMFd4?=
 =?utf-8?B?U25WRjAxMmVvL2xZZFJKT3pVc3BhSTNiRE5JU1IxcU5ZdzdSTDlnd0RxRWZU?=
 =?utf-8?B?ZnhhalVGbTFrZkpZU3dzTnh1V1dBU0o0R2JObkRLU2FUeEkvbGRjTEE3ekNp?=
 =?utf-8?B?L3FPYnppOExqY1Bsc2NZUmszS2RwSnhTejJhSHFUQ3BXZFk4U2I2bk9BVm1K?=
 =?utf-8?B?RjN5TkVyT1BzelVUQWJ5UWlpYTdQbFpheFl0N1EybWdnSzVOSCtuVGQ4UmFL?=
 =?utf-8?Q?ZXsvcUMQd0Vio4ihGCqKFXFHtZ08R5t+tQFC0R66LFXBR?=
x-ms-exchange-antispam-messagedata-1: lEm1Ujglehng59fN0kxFkHoBM4eqKK+feW8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <998D47C039FA934498CF7084C3EDD2C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dAfQSLkrO0a9ocJWUPvIi+vlyuEkHobM/v1ofesaHjQqV8Z3JKz4glWLjPqEzQr61/tHHtZUP9/ktqpwtRR3gsJPj1V7CftPNjCSIjAlWqFRIHrotrqtsDsiy4x7x4Sh4qHgfBjiAOqmOo7/YBlmQp7fHtLO+cXIR5OVN4T9jrH+h7VBUTn0FgHKWAMvfK+81nIRyoDqn03zzG/Qi4OItRambQ/SMJVj1fmsGdfU8dPUNlkAIAeEeM4emozRsGB0GwqyKvr3DRCUTM/4UEciq5fz+eGbUl0Bkcc+oxpUYNU9nfADKM6BW20JUf0PiDSID9VEttJmWI3/yQDkSoJm+Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 53jDXuQz48jdEcZB/JZOt/GCdQLOZOtstBgXkQi+uGOf+b6Xh/ZwX9xQ/X7XasiiauXNW13MBrGlUb2aubYL6L7GZYTed2ceiHMRAery99AFIB2fNUshzDxvvoopgTMZrC0in3e3heplnivX8eoXs09o+rGXSJhW6n6b8micu4M1L2J3hOZViuKqeJ1seXRUYVtdt0gFlYR/mYgtXdkK5vae8VeznsTTEhHWT2htAQpVaoidyRlZhHW3DHlm9aSM4RFazLzPkIrY2yjd6RiTe4Nz4y5jYFvJdvXLEouaLS5ZWtRt+Wocak6WOlK0PFuMq9yqk6S5VV/gS90kIyeEyOYPAgNYRhISM4ehA1ojraFVWo1tdJRSZboOZeGu/9FpnpPzEhwjhhzS5CWZLMqTY1y0WJe2Rp6Ec6Aqpj3mvIDxOBrgxrDYa31/5GOjYkbPvVxc3utFpWR5tij7NpFE3MBkyjv/umT+RoF0wKljX/RnOyQzUnPWsPf0fJxR482TCu0mNSNyIgnvD2blmwp49M984JoSvZ00SsqJuu+h40hlh4DgU5gXewXVk13Fuui/qgswfCyseA1OG8ESuupY3jYnch4huzqV89AoTxiRoapsvVuAaZvYMqDAz30szPk2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd455bd9-cf07-4f16-7e01-08df49209820
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 05:14:04.9859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1pyB74FiMCLLso2k1BLdVJXh6QBUOTTYWH9shfzkKR1iEY2kLbj1csBMcId0fDfXS5L+bchohjdGczKEu032qumwqVRYTOe5ye45tmMHHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7524
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTExLTA0IGF0IDIzOjQxICswODAwLCBCaW4gTWVuZyB3cm90ZToKPiBMMi1M
SU0gY29uc2lzdHMgb2YgY2FjaGUgU1JBTSB3YXlzIGNvbnRyb2xsZWQgYnkgTDJDQyBXYXlFbmFi
bGUsIGFuZAo+IEwyIFplcm8gaXMgdGhlIGNvbnRyb2xsZXIncyBzY3JhdGNocGFkIGFsbG9jYXRp
b24gaW50ZXJmYWNlLiBDcmVhdGluZwo+IHRoZWlyIFJBTSBzdGFuZC1pbnMgaW4gdGhlIFNvQyBh
bmQgcGFzc2luZyBhIExJTSBsaW5rIHNwbGl0cwo+IG93bmVyc2hpcAo+IG9mIHRoZSByZWdpc3Rl
ciBzdGF0ZSBhbmQgdGhlIG1lbW9yeSB2aWV3cyBpdCBjb250cm9scy4KPiAKPiBJbnN0YW50aWF0
ZSB0aGUgc2hhcmVkIFNpRml2ZSBMMkNDIHdpdGggMTUgbWFzdGVycyBhbmQgdGhlIGV4aXN0aW5n
Cj4gMiBNaUIgbW9kZWxlZCBaZXJvIGFwZXJ0dXJlLiBMZXQgdGhlIGNvbnRyb2xsZXIgb3duIHRo
ZSBiYWNraW5nIGFuZAo+IGJvdGggd2luZG93cywgYW5kIG1hcCBpdHMgcmVnaXN0ZXIsIExJTSwg
YW5kIFplcm8gcmVnaW9ucyBmcm9tIHRoZQo+IFNvQy4KPiBSZW1vdmUgdGhlIGV4dGVybmFsIFJB
TSBhbGxvY2F0aW9ucyBhbmQgdGhlIGwyLWxpbSBsaW5rLgo+IAo+IFRoZSBkZXZpY2UgcmVzdG9y
ZXMgdGhlIHZpc2libGUgTElNIHJhbmdlIGFmdGVyIHJlc2V0IG9yIG1pZ3JhdGlvbi4KPiBMMiBa
ZXJvIGtlZXBzIGl0cyBmaXhlZCBhcGVydHVyZSBhcyBhIFJBTSBhcHByb3hpbWF0aW9uIG9mIHNj
cmF0Y2hwYWQKPiBhY2Nlc3MgcmF0aGVyIHRoYW4gdHJhY2tpbmcgdGhlIHJlbWFpbmluZyBMSU0g
Y2FwYWNpdHkuCj4gCj4gU2lnbmVkLW9mZi1ieTogQmluIE1lbmcgPGJpbi5tZW5nQHByb2Nlc3Nt
aXNzaW9uLmNvbT4KPiBUZXN0ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3Jv
Y2hpcC5jb20+Cj4gUmV2aWV3ZWQtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phCj4gPGRhbmll
bC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+CgpBY2tlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gCj4gLS0tCj4gCj4gKG5vIGNo
YW5nZXMgc2luY2UgdjMpCj4gCj4gQ2hhbmdlcyBpbiB2MzoKPiAtIENvbmZpZ3VyZSBhbmQgaW5z
dGFudGlhdGUgdGhlIHNoYXJlZCBTaUZpdmUgTDJDQwo+IC0gTWFwIHRoZSByZWdpc3RlciwgTElN
LCBhbmQgWmVybyB3aW5kb3dzIGV4cG9zZWQgYnkgdGhlIGNvbnRyb2xsZXIKPiAtIFJlbW92ZSB0
aGUgZXh0ZXJuYWwgUkFNIGFsbG9jYXRpb25zIGFuZCBsMi1saW0gbGluawo+IC0gS2VlcCB0aGUg
UG9sYXJGaXJlIG1hc3RlciBjb3VudCBhbmQgbW9kZWxlZCBaZXJvIGFwZXJ0dXJlIHVuY2hhbmdl
ZAo+IAo+IMKgaW5jbHVkZS9ody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuaCB8wqAgMiArKwo+IMKg
aHcvcmlzY3YvbWljcm9jaGlwX3Bmc29jLmPCoMKgwqDCoMKgwqDCoMKgIHwgNDUgKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLQo+IC0tCj4gwqBody9yaXNjdi9LY29uZmlnwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTcg
aW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
aHcvcmlzY3YvbWljcm9jaGlwX3Bmc29jLmgKPiBiL2luY2x1ZGUvaHcvcmlzY3YvbWljcm9jaGlw
X3Bmc29jLmgKPiBpbmRleCA2MTJmZDJiNjljLi4xOGY1MDAzODUwIDEwMDY0NAo+IC0tLSBhL2lu
Y2x1ZGUvaHcvcmlzY3YvbWljcm9jaGlwX3Bmc29jLmgKPiArKysgYi9pbmNsdWRlL2h3L3Jpc2N2
L21pY3JvY2hpcF9wZnNvYy5oCj4gQEAgLTI3LDYgKzI3LDcgQEAKPiDCoCNpbmNsdWRlICJody9j
cHUvY2x1c3Rlci5oIgo+IMKgI2luY2x1ZGUgImh3L2RtYS9zaWZpdmVfcGRtYS5oIgo+IMKgI2lu
Y2x1ZGUgImh3L21pc2MvbWNocF9wZnNvY19kbWMuaCIKPiArI2luY2x1ZGUgImh3L21pc2Mvc2lm
aXZlX2wyY2MuaCIKPiDCoCNpbmNsdWRlICJody9taXNjL21jaHBfcGZzb2NfaW9zY2IuaCIKPiDC
oCNpbmNsdWRlICJody9taXNjL21jaHBfcGZzb2Nfc3lzcmVnLmgiCj4gwqAjaW5jbHVkZSAiaHcv
bmV0L2NhZGVuY2VfZ2VtLmgiCj4gQEAgLTQzLDYgKzQ0LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgTWlj
cm9jaGlwUEZTb0NTdGF0ZSB7Cj4gwqDCoMKgwqAgUklTQ1ZIYXJ0QXJyYXlTdGF0ZSBlX2NwdXM7
Cj4gwqDCoMKgwqAgUklTQ1ZIYXJ0QXJyYXlTdGF0ZSB1X2NwdXM7Cj4gwqDCoMKgwqAgRGV2aWNl
U3RhdGUgKnBsaWM7Cj4gK8KgwqDCoCBTaUZpdmVMMkNDU3RhdGUgbDJjYzsKPiDCoMKgwqDCoCBN
Y2hwUGZTb0NEZHJTZ21paVBoeVN0YXRlIGRkcl9zZ21paV9waHk7Cj4gwqDCoMKgwqAgTWNocFBm
U29DRGRyQ2ZnU3RhdGUgZGRyX2NmZzsKPiDCoMKgwqDCoCBNY2hwUGZTb0NJb3NjYlN0YXRlIGlv
c2NiOwo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuYyBiL2h3L3Jpc2N2
L21pY3JvY2hpcF9wZnNvYy5jCj4gaW5kZXggYTkxY2E5NTFkZS4uZDc2MTM0OTZmOCAxMDA2NDQK
PiAtLS0gYS9ody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuYwo+ICsrKyBiL2h3L3Jpc2N2L21pY3Jv
Y2hpcF9wZnNvYy5jCj4gQEAgLTE3NSw2ICsxNzUsMTIgQEAgc3RhdGljIHZvaWQKPiBtaWNyb2No
aXBfcGZzb2Nfc29jX2luc3RhbmNlX2luaXQoT2JqZWN0ICpvYmopCj4gwqDCoMKgwqAgb2JqZWN0
X2luaXRpYWxpemVfY2hpbGQob2JqLCAiZG1hLWNvbnRyb2xsZXIiLCAmcy0+ZG1hLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRZUEVf
U0lGSVZFX1BETUEpOwo+IMKgCj4gK8KgwqDCoCBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmos
ICJsMi1jYWNoZS1jb250cm9sbGVyIiwgJnMtPmwyY2MsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUWVBFX1NJRklWRV9MMkNDKTsKPiAr
wqDCoMKgIHFkZXZfcHJvcF9zZXRfdWludDMyKERFVklDRSgmcy0+bDJjYyksICJudW0tbWFzdGVy
cyIsIDE1KTsKPiArwqDCoMKgIHFkZXZfcHJvcF9zZXRfdWludDY0KERFVklDRSgmcy0+bDJjYyks
ICJ6ZXJvLXNpemUiLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAKPiBtaWNyb2NoaXBfcGZzb2NfbWVtbWFwW01JQ1JPQ0hJUF9QRlNPQ19MMlpFUk9d
LnNpemUpOwo+ICsKPiDCoMKgwqDCoCBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJzeXNy
ZWciLCAmcy0+c3lzcmVnLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFRZUEVfTUNIUF9QRlNPQ19TWVNSRUcpOwo+IMKgCj4gQEAgLTIw
MSw4ICsyMDcsNiBAQCBzdGF0aWMgdm9pZAo+IG1pY3JvY2hpcF9wZnNvY19zb2NfcmVhbGl6ZShE
ZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCj4gwqDCoMKgwqAgTWVtb3J5UmVnaW9uICpz
eXN0ZW1fbWVtb3J5ID0gZ2V0X3N5c3RlbV9tZW1vcnkoKTsKPiDCoMKgwqDCoCBNZW1vcnlSZWdp
b24gKnJzdmQwX21lbSA9IGdfbmV3KE1lbW9yeVJlZ2lvbiwgMSk7Cj4gwqDCoMKgwqAgTWVtb3J5
UmVnaW9uICplNTFfZHRpbV9tZW0gPSBnX25ldyhNZW1vcnlSZWdpb24sIDEpOwo+IC3CoMKgwqAg
TWVtb3J5UmVnaW9uICpsMmxpbV9tZW0gPSBnX25ldyhNZW1vcnlSZWdpb24sIDEpOwo+IC3CoMKg
wqAgTWVtb3J5UmVnaW9uICpsMnplcm9fbWVtID0gZ19uZXcoTWVtb3J5UmVnaW9uLCAxKTsKPiDC
oMKgwqDCoCBNZW1vcnlSZWdpb24gKmVudm1fZGF0YSA9IGdfbmV3KE1lbW9yeVJlZ2lvbiwgMSk7
Cj4gwqDCoMKgwqAgTWVtb3J5UmVnaW9uICpxc3BpX3hpcF9tZW0gPSBnX25ldyhNZW1vcnlSZWdp
b24sIDEpOwo+IMKgwqDCoMKgIGNoYXIgKnBsaWNfaGFydF9jb25maWc7Cj4gQEAgLTI2MSwzNSAr
MjY1LDE0IEBAIHN0YXRpYyB2b2lkCj4gbWljcm9jaGlwX3Bmc29jX3NvY19yZWFsaXplKERldmlj
ZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKPiDCoMKgwqDCoMKgwqDCoMKgIFJJU0NWX0FDTElO
VF9ERUZBVUxUX01USU1FQ01QLCBSSVNDVl9BQ0xJTlRfREVGQVVMVF9NVElNRSwKPiDCoMKgwqDC
oMKgwqDCoMKgIGlrcy0+Y2xpbnRfdGltZWJhc2VfZnJlcSwgZmFsc2UpOwo+IMKgCj4gLcKgwqDC
oCAvKiBMMiBjYWNoZSBjb250cm9sbGVyICovCj4gLcKgwqDCoCBjcmVhdGVfdW5pbXBsZW1lbnRl
ZF9kZXZpY2UoIm1pY3JvY2hpcC5wZnNvYy5sMmNjIiwKPiAtwqDCoMKgwqDCoMKgwqAgbWVtbWFw
W01JQ1JPQ0hJUF9QRlNPQ19MMkNDXS5iYXNlLAo+IG1lbW1hcFtNSUNST0NISVBfUEZTT0NfTDJD
Q10uc2l6ZSk7Cj4gLQo+IC3CoMKgwqAgLyoKPiAtwqDCoMKgwqAgKiBBZGQgTDItTElNIGF0IHJl
c2V0IHNpemUuCj4gLcKgwqDCoMKgICogVGhpcyBzaG91bGQgYmUgcmVkdWNlZCBpbiBzaXplIGFz
IHRoZSBMMiBDYWNoZSBDb250cm9sbGVyCj4gV2F5RW5hYmxlCj4gLcKgwqDCoMKgICogcmVnaXN0
ZXIgaXMgaW5jcmVtZW50ZWQuIFVuZm9ydHVuYXRlbHkgSSBkb24ndCBzZWUgYSBuaWNlIChvcgo+
IGFueSkgd2F5Cj4gLcKgwqDCoMKgICogdG8gaGFuZGxlIHJlZHVjaW5nIG9yIGJsb2NraW5nIG91
dCB0aGUgTDIgTElNIHdoaWxlIHN0aWxsCj4gYWxsb3dpbmcgaXQKPiAtwqDCoMKgwqAgKiBiZSBy
ZSByZXR1cm5lZCB0byBhbGwgZW5hYmxlZCBhZnRlciBhIHJlc2V0LiBGb3IgdGhlIHRpbWUKPiBi
ZWluZywganVzdAo+IC3CoMKgwqDCoCAqIGxlYXZlIGl0IGVuYWJsZWQgYWxsIHRoZSB0aW1lLiBU
aGlzIHdvbid0IGJyZWFrIGFueXRoaW5nLCBidXQKPiB3aWxsIGJlCj4gLcKgwqDCoMKgICogdG9v
IGdlbmVyb3VzIHRvIG1pc2JlaGF2aW5nIGd1ZXN0cy4KPiAtwqDCoMKgwqAgKi8KPiAtwqDCoMKg
IG1lbW9yeV9yZWdpb25faW5pdF9yYW0obDJsaW1fbWVtLCBOVUxMLCAibWljcm9jaGlwLnBmc29j
LmwybGltIiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBtZW1tYXBbTUlDUk9DSElQX1BGU09DX0wyTElNXS5zaXplLAo+ICZlcnJvcl9mYXRh
bCk7Cj4gLcKgwqDCoCBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oc3lzdGVtX21lbW9yeSwK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbWVtbWFwW01JQ1JPQ0hJUF9QRlNPQ19MMkxJTV0uYmFzZSwKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbDJs
aW1fbWVtKTsKPiAtCj4gLcKgwqDCoCAvKgo+IC3CoMKgwqDCoCAqIEhTUyBkZWNvbXByZXNzZXMg
aW50byB0aGUgTDIgemVyby1kZXZpY2Ugd2luZG93IGFuZCBleGVjdXRlcwo+IHRoZXJlLgo+IC3C
oMKgwqDCoCAqIE1vZGVsIGl0IGFzIFJBTSBiZWNhdXNlIFFFTVUgZG9lcyBub3QgbW9kZWwgdGhl
IGJhY2tpbmcgTDIKPiBjYWNoZS4KPiAtwqDCoMKgwqAgKi8KPiAtwqDCoMKgIG1lbW9yeV9yZWdp
b25faW5pdF9yYW0obDJ6ZXJvX21lbSwgTlVMTCwKPiAibWljcm9jaGlwLnBmc29jLmwyemVybyIs
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bWVtbWFwW01JQ1JPQ0hJUF9QRlNPQ19MMlpFUk9dLnNpemUsCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVycm9yX2ZhdGFsKTsKPiAtwqDC
oMKgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihzeXN0ZW1fbWVtb3J5LAo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
ZW1tYXBbTUlDUk9DSElQX1BGU09DX0wyWkVST10uYmFzZSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbDJ6ZXJvX21lbSk7
Cj4gK8KgwqDCoCAvKiBUaGUgTDJDQyBvd25zIHRoZSBTUkFNIGJhY2tpbmcgYW5kIGJvdGggc29m
dHdhcmUtdmlzaWJsZQo+IHdpbmRvd3MgKi8KPiArwqDCoMKgIHN5c2J1c19yZWFsaXplKFNZU19C
VVNfREVWSUNFKCZzLT5sMmNjKSwgZXJycCk7Cj4gK8KgwqDCoCBzeXNidXNfbW1pb19tYXAoU1lT
X0JVU19ERVZJQ0UoJnMtPmwyY2MpLCBTSUZJVkVfTDJDQ19NTUlPX1JFR1MsCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbW1hcFtNSUNST0NISVBfUEZTT0NfTDJD
Q10uYmFzZSk7Cj4gK8KgwqDCoCBzeXNidXNfbW1pb19tYXAoU1lTX0JVU19ERVZJQ0UoJnMtPmwy
Y2MpLCBTSUZJVkVfTDJDQ19NTUlPX0xJTSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbWVtbWFwW01JQ1JPQ0hJUF9QRlNPQ19MMkxJTV0uYmFzZSk7Cj4gK8KgwqDC
oCBzeXNidXNfbW1pb19tYXAoU1lTX0JVU19ERVZJQ0UoJnMtPmwyY2MpLCBTSUZJVkVfTDJDQ19N
TUlPX1pFUk8sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbW1h
cFtNSUNST0NISVBfUEZTT0NfTDJaRVJPXS5iYXNlKTsKPiDCoAo+IMKgwqDCoMKgIC8qIGNyZWF0
ZSBQTElDIGhhcnQgdG9wb2xvZ3kgY29uZmlndXJhdGlvbiBzdHJpbmcgKi8KPiDCoMKgwqDCoCBw
bGljX2hhcnRfY29uZmlnID0gcmlzY3ZfcGxpY19oYXJ0X2NvbmZpZ19zdHJpbmcobXMtPnNtcC5j
cHVzKTsKPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvS2NvbmZpZyBiL2h3L3Jpc2N2L0tjb25maWcK
PiBpbmRleCBkODlmZGZjYzg2Li5hMjJlZjk5NGViIDEwMDY0NAo+IC0tLSBhL2h3L3Jpc2N2L0tj
b25maWcKPiArKysgYi9ody9yaXNjdi9LY29uZmlnCj4gQEAgLTIxLDYgKzIxLDcgQEAgY29uZmln
IE1JQ1JPQ0hJUF9QRlNPQwo+IMKgwqDCoMKgIHNlbGVjdCBNQ0hQX1BGU09DX01NVUFSVAo+IMKg
wqDCoMKgIHNlbGVjdCBNQ0hQX1BGU09DX1NZU1JFRwo+IMKgwqDCoMKgIHNlbGVjdCBSSVNDVl9B
Q0xJTlQKPiArwqDCoMKgIHNlbGVjdCBTSUZJVkVfTDJDQwo+IMKgwqDCoMKgIHNlbGVjdCBTSUZJ
VkVfUERNQQo+IMKgwqDCoMKgIHNlbGVjdCBTSUZJVkVfUExJQwo+IMKgwqDCoMKgIHNlbGVjdCBV
TklNUAo=

