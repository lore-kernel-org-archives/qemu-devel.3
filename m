Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD2606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=daMqJ8PV;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=BaJtCFWN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTG0-0001y4-8A; Wed, 04 Nov 2026 00:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=761a35039=Alistair.Francis@wdc.com>)
 id 1xOTFd-0001ch-Ie; Wed, 04 Nov 2026 00:09:35 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=761a35039=Alistair.Francis@wdc.com>)
 id 1xOTFb-0002Vt-Ne; Wed, 04 Nov 2026 00:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793768971; x=1825304971;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lkFSTVE0+I8+26JtEcYd8VO/N+u9AwBIRa5yfQpD1IE=;
 b=daMqJ8PVQJ9qsQl38/d7gKwnzayE94Nkpu8YSLsTXe894m7+Ib7lP8o0
 KqF9ER6QDbMLZc5HKzyy2UtVdqsGiKr1EEUJDR5oTR4mufbBsXKgMF7EI
 jvfp3j+TKfXaA+683kr6CFFYoSQojA7D9M8+3D54RTvE+uTlU1ZSG5ubz
 J6Ae2iJR598DuqYujLUN/ZOKtZXNQAsyLxxSE/FRe1UmrQxj+4+TWVy0k
 GUc2b0Pc2d5gSMPInfoQiv6Ia1Fkv8ZtgDV4TBI9iQlkC4iaFoWKB92OO
 A5PRxRJ4mGI0SSUN8BabgDGvePln6jkg859RAoYBjXsSV4TntprTNiyso A==;
X-CSE-ConnectionGUID: cE9qJqv7TjecgQTdkwAUOg==
X-CSE-MsgGUID: hk1uLLCBQqGcITFFfWG56A==
X-IronPort-AV: E=Sophos;i="6.27,194,1786982400"; d="scan'208";a="159680493"
Received: from mail-westusazon11012036.outbound.protection.outlook.com (HELO
 SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.36])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Nov 2026 13:09:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svlizalIB70Z5h1SATRSudcWthFegaXH9Pj1UAT88SQN0qoa2PV7wTzFCQqTpZ9rqm8PrhkVgpboIbSNRIseyJJQGGSuZvek4vEf5cN7Xm0zBjBSBrQGQ1AkrkCaHM8+rk8KFWx93wzV9UdBy1/JtHmjvK5FEyUt996++QxaNxw6il8yHVvsc+Wf2ck7Lbfbob84L8OZTcB7refBNSO1SoEtq9ixuCfVJ+JcPaLEiFnxZP9WqUU/5oKLUicszfvcxssjYPNLawWjobtNheAeC5DLu3tOXakUo84sjiPjqx2cdgmG7+BmQy/27yqKB2eUu8+3dKN4v/JVoOo25726DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkFSTVE0+I8+26JtEcYd8VO/N+u9AwBIRa5yfQpD1IE=;
 b=ckhMCW2Fhno+eFWpe+vCmYb+kO04ZMfFYTv8Lt9zPbq8fzlDRprb8RWK8UCqV65KT/Q3ZLkx9ob8TEOxfyXxhUs4d+PoRCkQ37oi8PSEU0jN/sfFB5Fzig/sJsif4bOUiSS7MQWrFZQH25+uz5K3yhaoCrqZYzw/XsDG807JrcSKHaPPuDU4aNaoHqT0gKWPaWQU+Y2fXcxx2aD3Zcij30/PYyX+JFwUZsTcaB+SXs7ZPl5B1Z6ggGcSqkzBW5yWG9pAULgfIvltV+32JsVjzWd3labzBka2kgqAyhb1equBBymDArRd8A+Ukm/86X5XOw/UjU2mbd6neooeJJamhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkFSTVE0+I8+26JtEcYd8VO/N+u9AwBIRa5yfQpD1IE=;
 b=BaJtCFWNVV7Flg1AHYZUq4t5akDjV3RQ8znAg/McXQaLXwyutiE3O6vb1IOMZ6ozgi/qaCJRnvUn/JCHFr5LviaFt9C3Vc8LQ3y9sHUPq/RX+ouzJnlCRoYFXBKD/OLvVM/gb3xgVNKDwBPW4Rgc+JxiA3HVGVvLWdYpKwQyYWo=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DM8PR04MB8005.namprd04.prod.outlook.com (2603:10b6:8:f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.12; Wed, 4 Nov 2026 05:09:27 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 05:09:27 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "tanchi25@mails.ucas.ac.cn" <tanchi25@mails.ucas.ac.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 5/5] hw/riscv: Select SSI for IBEX
Thread-Topic: [PATCH 5/5] hw/riscv: Select SSI for IBEX
Thread-Index: AQHdaa9cpMb6ihAAGU6dCk0X6STIkLcdYfQA
Date: Wed, 4 Nov 2026 05:09:27 +0000
Message-ID: <fd7d1ecfa0f4e1f539e29a8f47a49a9db20cca86.camel@wdc.com>
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-6-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20261101031547.125591-6-tanchi25@mails.ucas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DM8PR04MB8005:EE_
x-ms-office365-filtering-correlation-id: 82271076-2a98-4094-faa4-08df3a31cce4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|10070799003|366016|19092799006|261026140227099003|38070700021|4143699003|56012099006|11063799006|261028144727099003|261026121527099003|261022105027099003|261021121427099003|10067099003|18002099003|261102123227099003|22082099003|6133799003;
x-microsoft-antispam-message-info: HMsc1CBtoZi23fk24K78B2H6FG078jUgbFn6VLJ9caXGRTYCJFEsu1mUCjrPUKNzwa7JEf7KunktYamK1wDO1kM+S42DISpPYWIlxsAoyju7BV0vwtPTU6uKBdsn2NN+o4q97Go0EloVpGZDnWAsiaWIVYdePOZyKcDvx7DqkzSMkL9tkSZ2hSYtIgWKUSFFdp3X/8ZeNeOGB68mNU334iJCPurRFS2rjqSQ1o2QjOwyeDBK4Klm3TbkGWmcwkJX3r1rhGqG0KcjVAIDXVunf6l47guO0kqSnntkMrPRzJGyilHtBfIGMTgvyJ3P/02LgnDhVzPnthcuBQQW6AOOTYeEUIWzcgs/IhxCqcynRGou6ILmQhFSFiNdcUvPsJB642jOXbcsrq7A0ihYLaSUSCrLyUvU9oMXLADpYysXjsKflYYX7L8zLv9SkhsKxWplh6Bb47SwKNt93Wntif2wqZdXWlgoOcSF0gGKf21hIfQrRnTzZ67arXLV+u8ZG1aWujK6hyTz4HeyocSYgYTWldaOiH+WVPcxeQmrroxCwyGX3QeEcoOp6L7FjqnYs0E/1cGKJadjSOGzQWsSQSVNzK+80QB8Yt+G67DkTCSZ+DIgC29jl7p7fwIi0p9VwDM27UAokBa5BcdJxK5djOqXn0e7n6RUN8M3iON6UTMRiyQTTox2Cw2X/3H4nX1NoLo3ZsUWxOiWaV/xe/7wEF8aGXPOw4BCQPrjExFS8YWWmEw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(10070799003)(366016)(19092799006)(261026140227099003)(38070700021)(4143699003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(10067099003)(18002099003)(261102123227099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEhzMy9CTmZ2Y2ZvUU5KejNsOWNUTlVDeHBLNXFhbTRMY2EzcmpSZElQaXlo?=
 =?utf-8?B?TFN2amF0VUV4a0txTmhMcHpjSUc2bm1mOEVtQXBVQjc1ek1YQk05M0ttZGJC?=
 =?utf-8?B?blVIbldKNFFUamJIdTA1azdpbW9wbnBRUmZZMVhuQ1JrcDdhWXdKbi9xd2NR?=
 =?utf-8?B?a1l2VndsVGZjQjdrcmNSRWRYL0JZMUtIc2tPbTlEZ2pzdERFb2tuRy9vWDVP?=
 =?utf-8?B?dGVJVEdySFJDVkFVQkkwOFdaWWdwWm4rcW53bnllMDhQREhmWlExdTh4eGJl?=
 =?utf-8?B?eHhxa2IyVDAxMzRHYUxkNWlxWXk5QS93Q3pSYXF5WStvZStTK0ZXNnA5L21T?=
 =?utf-8?B?VDJyWTJlY3hXV3p2cVdLU09FTHR5T0Qxbm9TbmlXdVhYeXd5NVNrbU5tR2lj?=
 =?utf-8?B?V2xPcFZIRkcrU0pCa1ErNVMwMzNHMHVxVjVBQ2xWWitHOWFDUmlsVHNsV3E3?=
 =?utf-8?B?bWs5bUsvRFFQdlNIU0luRjVKb1NFdklUQU1yemRJdWZhR29OamkxZ3JMNFdR?=
 =?utf-8?B?VzkxM1lkU0hpa1p1VkdVS0JWWlUrdnh5MjR3SnRJaFcyQmhhY1dOVkFHc2dD?=
 =?utf-8?B?VENWYXdOZFFEY04rRWRQQUt3ZWYrUzdWZW5uZUpaa2JHZWw0SUtndW5ORGo0?=
 =?utf-8?B?QzNsUjllbkJ1d2dnMG5vclIwK1NBRmNyWEhOTkdtTFU5M2hjSVdZWXY3aTV5?=
 =?utf-8?B?SyszSEtDTW5LN3VnTWVscFNqTUdSTmNOdFlORUF5Uys4bkk2cUFJbHo5L1N5?=
 =?utf-8?B?MW1IZFhmd0Joak5kcTljNE8vZThId2NsY3VkZkRiYTBVUHUxM0ZKUTJRNS85?=
 =?utf-8?B?ZGNyUHhrNHhtcms0Z3MyZ1lUbUZXaHFDT1lQQkE0RUFLa25hSm96empGSWsy?=
 =?utf-8?B?QmpCUnh5MXU5R2xDNnA0bmVONFM5WC9CQVVyajFYWlJPTzFsSjhLM1ZVUFNh?=
 =?utf-8?B?anB4MDZ1aVhaOHFVQmk5WldaeEtIc05FckpoUGFreDVyaldkODhwcWE5djdm?=
 =?utf-8?B?b3p2S3V5T2h6NW1sMDMxNWtYUitMVUdPaTd3WDc5OE0rbUg3L2F3SzFEUVlw?=
 =?utf-8?B?MlZBYkRUZ1BZQUordVI0aXNGbVByNjlhUWQrb1J2TVFYV1M3bU1KcnQxdG1H?=
 =?utf-8?B?OHpqUnJrMTdabW1hcDd6a2RMbWhuL3RnL0U3Mk4zV1pSRzdkS3RKQVozSjQz?=
 =?utf-8?B?a2FpZXZONVZiRk5KT1VRTUpkUW1Eb2J1UC82cnp3MDJUOU9lWEljS25aRW80?=
 =?utf-8?B?bGNqTnE0SFFuWUVLRGE3MENYaE40SmxuVVh6M1huRGh3bE5waGJEemNlVkR6?=
 =?utf-8?B?aW9wR1RrY2Zhb3dIbDc1MDNZRnpDa3Uwcll3SnBJN0ZYei96U3lrWGdMMnhy?=
 =?utf-8?B?LzRhMWkyRHlYVUVFRFRTajdxczJLd1k2cFBZMlZ4emtHM2Vzei91RmVDZFJN?=
 =?utf-8?B?RHJuVWFaZTd4MjZKOGU5aWw3bU45Um1pOUpxNCtIS1NDOU41VmdMOStlb2ds?=
 =?utf-8?B?RjJ3WG9yMlluRGw2OE12QzNyZEdFcFJtMThNaUVDd0F3U082L3ltM21nSEFC?=
 =?utf-8?B?a0ZQenBwR2RNeFdjRm1UU3ZjcFR4U1ozZEZKVVlpYlcrT1ZxL0hteDVlcEVS?=
 =?utf-8?B?STUrTE8vQ2VEVm96Z3dPRUVjZGlMU3JJWFZoWFVvaWhvVUZYUitHVytuQVEx?=
 =?utf-8?B?Rm54ZWhDVkw3TkVNdFBUb1hUM2xUUjlJQlBxYjVYR0tGUUQ2dUpveWNKYm5H?=
 =?utf-8?B?cDczNzJVUjl1Umkya0JiTUxJMVZHUFZKYk43L2FpQll4UXJvNjY5NE9JVldy?=
 =?utf-8?B?RnVIcEtjemFZZkNmQWlUTmJOQ0tTc3pPVjMrbHZhekx2aTRkY1JYS2hMUUc1?=
 =?utf-8?B?SXIyWG52L1p0emQrcjc5S28xNmVaSGU2SVFlUnJUNHFKLzNMQzZzNHlvUm1u?=
 =?utf-8?B?MUMvWjdQY1ljZzlmTmpFUVM4emRDTHZDdDhJMFZJTklDUkpKcU1MVkF3R2Rm?=
 =?utf-8?B?dUhjdVg2YTdKZXVSU1FDbjJrQUZmMGhSU0k1cU1abFVTQnByelZRb0pEeTNp?=
 =?utf-8?B?ZVdXTTlFai9ROG1yWWpSSmNVVndPNnAvS3gvbEJiVGxldEJqY3BGS04xdlBr?=
 =?utf-8?B?SmdsL0VnZ3VPNjdob2IyMGpURHpudXc2eHhsKzNDcUpBanI5cjN1VWo5Yzh3?=
 =?utf-8?B?RVpDZU9nNVJPOFg4cHFMdTZ6djVXZDAyMDhxa05VSWd6eVRNb0pYQVI0dmE3?=
 =?utf-8?B?NXZKdUN0MHFsNnR4WE5pTnJQWUxXNStQaVMrWmY4YmZaYTZuWm9PTjFhcjJC?=
 =?utf-8?B?WDlPeG91SWxTUTlrNFV1UElQOUxncVZQWDEzRDRiSVlSc3VvRmxEUVM2VlZH?=
 =?utf-8?Q?cy+mE7JojCjGa10R6cuCXSgoMIN+VU9bQ92CpRIcD7wGC?=
x-ms-exchange-antispam-messagedata-1: 7A+XltSSyCmUEB+sYEZ7k+nUC8keZO+WVxM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E4BC6D8BFADC24D91B841EE5D369399@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HGdrG3qoW/iWy6pKyyMHYXprAji411bpk0WHtQpQ5uGyApgYMSluPCp+zHxwqBi8daNO5DsgTB/xCEvZ4JyNBuCrmVV/Ugc/9GzSVy8tuKkubK18B3GFyAj+Wy0DZoP7fBqVTqHwso2PA9qJrVqqXYAFfqU9BsCR+QFx6/1zB98dZ0WQwOhtYTJZD12nf68Qt9c9nBKupnwhbZZgPnFgl7+7sT0cBHHq8UR/qkRzOsF9A6HI1xnyrVYoxLx2t0mp3s/13b840rRUU5YgMF5/0FEJqdnmpN5uMFjwDS5gjv0nspSrMg+5cQ1xhrRmWU4fihrd2+4AUMMy/DKo/SCx/g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rcFINubyZ5bpYcFMF7G2y7oa7VSXVY62bI7SZv0F5v6YoJGrAP0M4U0/ebSq4FBnNys0p4KVe6Y8S8zFlf/A+06xrGgat34YGy+uaqwzjasGG4fWfMiD2HgbE7Or28QzH/+GMHUV1ArfosfSb0dRttyx/cWhCakoBcp2GYnd8kyVEIZcaPzerFSckuC1Nz4p8gHHvSIPbqPf/LscvEwwsLPWRtNMjXf8okMj69l2azmX6b3HB51WctTsE6yDqpzp4FWe4BZFiErIfXPg82lmVo427FURhgjWskQ4zDuTy3bONR/7sqjQjhQfP0KWw3FZv85dZkjjaSKN2c/m1ZMF3+QdKcL38ubfcgCWJ8IB1Y5JnwguK+6GPerv9pWwlWpTtMnZlpMNjGfAdF9wmAu43S3Jh4ljC7AXsQAPg47+43EI8lV1sErVaNzgkN/XTm5F6wYmPkg5qOtNnDQn1WRfl9Oedwu4HlywolYSSa5iFexSCv7MnnSHGul/qnTFSYkrxqddUiDjiQ69qQK3eo75V/GXF8S7fUYEh0glS4Qze+A3aIbRgu0UEnCN8gHiFy3IYBJ8XSM13ypUX1b58JrRH5Ifo5HcGKqJfoGyFLl8jvEV7VnizRw/bSWrI1jtphXS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82271076-2a98-4094-faa4-08df3a31cce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 05:09:27.4860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWdmnnIgRiWQIWyzWcOm65mZXswcRnUYr1mVpgCy1CNwGsJkWd2DbfwMf82foDlstIAn48GT7vfCSrsxdkwVXOIw4dLDd+tEwG1B1tLvhz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8005
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=761a35039=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gU3VuLCAyMDI2LTExLTAxIGF0IDExOjE1ICswODAwLCBUYW4gQ2hpIHdyb3RlOg0KPiBUaGUg
SWJleCBTUEkgaG9zdCBjb250cm9sbGVyIHVzZXMgdGhlIFNTSSBidXMgaW5mcmFzdHJ1Y3R1cmUs
DQo+IGJ1dCBDT05GSUdfSUJFWCBkb2VzIG5vdCBzZWxlY3QgQ09ORklHX1NTSS4NCj4gDQo+IFRo
aXMgY2F1c2VzIHVuZGVmaW5lZCByZWZlcmVuY2VzIHRvIFNTSSBmdW5jdGlvbnMsIGluY2x1ZGlu
Zw0KPiBzc2lfdHJhbnNmZXIoKSwgd2hlbiBidWlsZGluZyBhIG1pbmltYWwgUlYzMiBPcGVuVGl0
YW4gdGFyZ2V0DQo+IHdpdGhvdXQgZGVmYXVsdCBkZXZpY2VzLg0KPiANCj4gU2VsZWN0IFNTSSBm
cm9tIElCRVggdG8gZW5zdXJlIHRoYXQgdGhlIHJlcXVpcmVkIGJ1cw0KPiBpbXBsZW1lbnRhdGlv
biBpcyBidWlsdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRhbiBDaGkgPHRhbmNoaTI1QG1haWxz
LnVjYXMuYWMuY24+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgaHcvcmlzY3YvS2NvbmZp
ZyB8IDEgKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2h3L3Jpc2N2L0tjb25maWcgYi9ody9yaXNjdi9LY29uZmlnDQo+IGluZGV4IDI3ZjAz
YjY4N2MuLmQ5OWZlZTBmZDcgMTAwNjQ0DQo+IC0tLSBhL2h3L3Jpc2N2L0tjb25maWcNCj4gKysr
IGIvaHcvcmlzY3YvS2NvbmZpZw0KPiBAQCAtNiw2ICs2LDcgQEAgY29uZmlnIFJJU0NWX05VTUEN
Cj4gwqANCj4gwqBjb25maWcgSUJFWA0KPiDCoMKgwqDCoCBib29sDQo+ICvCoMKgwqAgc2VsZWN0
IFNTSQ0KPiDCoA0KPiDCoGNvbmZpZyBSSVNDVl9ERVZJQ0VfQ09NTU9ODQo+IMKgwqDCoMKgIGJv
b2wNCg==

