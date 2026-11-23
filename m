Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E19606A681
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=rOdpI2xg;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=SLiZqPjk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVKiA-0003aE-J9; Sun, 22 Nov 2026 22:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVKi6-0003Zw-3t; Sun, 22 Nov 2026 22:27:19 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVKi3-0005Bq-RE; Sun, 22 Nov 2026 22:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795404443; x=1826940443;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1YMRZAVv7UxRXfM2H/uM4M6931u8F12SD41w1wFdI0k=;
 b=rOdpI2xghgqhlErJ+JT1hKufFGiO7IgmrReQ626jjFQfwQc22HyVpuC8
 SyN19/nqwz2tej5b7hVZ1fOLbCenata0MPyIwJKXnYNL3f77lM2wPZ2FN
 /uyB7wMq3FjsSatkTDssg+1P9P0BQXcDBVWWfCl99uNty+DsRMw644u7Y
 YyzaoibBGBpHOiATsXZ3biF2//KX1ytKPk2RonzgDapCqkYTz75orCHeL
 K/oGMbQj4iWFueSTJPZPlJqTmEdV4jHAMU1/2JnZOJX59+LaIZQT0zplR
 viZnUWcekB2I37r+fGB+sQ/ABQEfdX2rJlfQQkNm0IsPJO6+LIWO/Ivr+ Q==;
X-CSE-ConnectionGUID: IjJafe8sR86w4u6LK5m0cw==
X-CSE-MsgGUID: w6H/l/C8TBuaAEAaQrRtfQ==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="162505861"
Received: from mail-northcentralusazon11013011.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.11])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 11:27:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yqo6jpAVM/o/VM8LOGChmnfRrq0JlUKTkBul5e7vT92rYElv6gQwYHbab+z78H6CbVKUplKhP34tVKg+yLxNIcQ2E+4cXxAN80qBmFjozXyg7etiZ+y0Ew5HWfOcjbCS/UpZ7wbVj+USlJd5DLmR6MBV4dtj0zlv9ZWhY2MDgAMPOAPOdKTA3SyOd4fRcLaFY7RIvUVtKQ98FZxmSqDAXAYcJ+Jx6Nk+Q3cozjyCt/r1Y/nhp8d2ODWkxQXTs91+K1MQ0QWJ+eltPdkF/nIof+bpzkt5Fk4DxGIGhqZ4NEZhpqrTy8S6/XPupr4iGbNCoMifo1Jo6Wp0oYdl1FCbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YMRZAVv7UxRXfM2H/uM4M6931u8F12SD41w1wFdI0k=;
 b=JfJvomwOBMURy8l5+CtgMMg4HCfUROh5OR80QPBztn1cNr1YAIqhoaxeNPopHpbRS5mj8S0UvAbK6x/43W72fSuz+JdKLgn9ZicLPQsUX4zfH0nnngfE8sIKVfy9cH0ePr5IJaz6ai28Ccien5r2o3z3YZD4XtCVzRYi2am3LE8V480xlQWHXw5ceDC0NZakJkXVkRYSjNEve/i4Ob/WnnHb9++/I9keNGXZ4QIiCoPylp/T/jUyhhP4KjTTtndalA19KLjIibOUGU8cMYu6VCfiEJvcLBTbB/BQQ6wmYCPlA2WzNtkP37JTX0oMIJl6dr/yicZQXNOa/+ViyVdEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YMRZAVv7UxRXfM2H/uM4M6931u8F12SD41w1wFdI0k=;
 b=SLiZqPjkSczDebcbomvin2ua1n6VxdUvylEdX0coS5uurjZKp1T+yyF1kP2v6w5EO60GKYbNjrLG5zCwGMtb1yQA8m9tTzDpyB7vXmXxMblds2KUZVbEnZJc1z8dRufrEM+7wlnxfYn3ib97V+3KgGqGUILdVk8QDsNF9qsWlJU=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9453.namprd04.prod.outlook.com (2603:10b6:208:4f1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 03:25:27 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 03:25:27 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: make pmpcfg R=0|W=1 bit combo reserved
 [GL4820]
Thread-Topic: [PATCH] target/riscv: make pmpcfg R=0|W=1 bit combo reserved
 [GL4820]
Thread-Index: AQHdc7nAi4bfLQ5fMEmLaTuyAwBqvLc7DRuA
Date: Mon, 23 Nov 2026 03:25:27 +0000
Message-ID: <b54624d2e61b47a21b8eb9bafb57117bbb013a95.camel@wdc.com>
References: <20261113215537.158118-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261113215537.158118-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9453:EE_
x-ms-office365-filtering-correlation-id: 9cdbc2b3-658d-4594-a708-08df49116b2c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|19092799006|10070799003|261009223027099003|6133799003|260925021311599003|260925021911599003|260925022911599003|18002099003|22082099003|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|56012099006|10067099003|261102123227099003|38070700021|11063799006;
x-microsoft-antispam-message-info: eH5KsT7H7aMmEnG/dBZBBG8D5hyXfNOq3McelvgBPnbzC3IJSaTt9/AsKron+0MsC12IHMbVnEG6g60SJB5e7QQR/8+ibxqFzoz9oRMncosvLfyF/HHavYKTxLiel1dLPuGQJiTdmhG+fcsVKRPQLhARP3dRB3tozBOHBAxWMcvp7brpvS1xP0QgbK0pD66ABoVlQYIfnVNa7lbXN903Oo/oUurlcgQpAgx2tPLXyzHrwOqT69M9Fz+1QUbMvAYji8CnA6gGSQaytx4216hS4iqFoSvnUCIhSlBqjLXyVfUANo8MIUxETMVfLVMJ7zfwCa9PkNyb4lKxyFsGdQtBvI1DSXZgU+YJTZWqxDOv55VSZ/WWbNfiOlZhalyVYqT4biuAZnMPHSd/5eSwKK2SUvQGUgJRG3tuGJt+UiCh8Ufu8W4xVOA6fnMOMKxy7lSNRB6O6f1gEZUdnsdogBw61SeGUtlEzPyX4c6hid6PTu3WrVK37MWJxPP5ZYURnmpUL+YCaQhVrnTgVONgddsTqvoWarOWt6w51JTV79uNGPVkZ9iczj0bcIwUsMwaqevAbDKOhENYeJTNbGH3cS+pMEHX5LuCjvh5g4/DQJutKc0Yw8a/SBnsEkQXGUOu+Kc0TmvZCzy9XYMc4kLBrRhpa7RsmfQSQ7fcnc29Cl+oAvcLyaBDANiKVLSLPphxIE3rw4tk5WjEdBz9gu8KVHdGInyGns2pA0KRx3YZ3kXkltE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(10070799003)(261009223027099003)(6133799003)(260925021311599003)(260925021911599003)(260925022911599003)(18002099003)(22082099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(10067099003)(261102123227099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1h5cUp5d3VjdFlxSlNaZXFyVjVZUFV0VFBqVHBNcWhSWnl1eWNMT29LSWhF?=
 =?utf-8?B?T1BHbm0yeDdGNVcybUVwQlcySXdXejlQSFV2MjlONGc5WmlpVGIxMHQzUzJv?=
 =?utf-8?B?QjZFMlJvTVVKRUJTNDJWbzRUcjhpWlZFbTU1dU1OL2lmZXdUN0ZONUdSK0ZS?=
 =?utf-8?B?Z1FQV1ovRzk3cldrbENLa0djT3cyUVBMZU1JcmJoaHU1QVNTYVhSZ2M5SVRM?=
 =?utf-8?B?T1dleWJoSm5jK1ZiRmhaZUl5VGdqRk80S3ErMVU0YWRLV1ZQYnBPU3FSdS9D?=
 =?utf-8?B?QlpTZEpTeU9lelBvZGF3dmh2TUorcFluV2RKUzA5L1FEVW1NOTN2d3lZdkoy?=
 =?utf-8?B?ektYUjVrbXM0NExvUUVyV3NCdzhDSXRDV3AwYTVPUzJqc2VzMnFGclFDb0Rs?=
 =?utf-8?B?SG9yQ3loM1VVVkluOGZoc1ZVV2JzTWRhekNJL1YxWTZSOWg2RHhPc2o2UkV2?=
 =?utf-8?B?dGs1WEUxYkg3aDRwNy8yVFordkgyWWYzRS82L3U2U3E5ZG5GLzNKT0pXd1Uz?=
 =?utf-8?B?ZDBVeGY2RlB4Tk9iNXB1YVV2WWRPWis2S2VjL3BkbFlnM1RQaktadnhmWGhH?=
 =?utf-8?B?VlRFTUdBSnJ3Szkvci9OSmpUR3duNy9JVGE2aHk2a0Rqb0JDTWtTNTRXZGVH?=
 =?utf-8?B?OFBpNnZLdzR5WkxQYnJicHlwTU1ydFJSUVBzTFBiK0hkdG9PQU51RXVxY1Y2?=
 =?utf-8?B?S1JRS21rdmxyY2lSN0VaTlM0cm5uazlKcFVIc3lwcEh6SnRGR1F3VDRZREFK?=
 =?utf-8?B?eDFMNllMaUVlSi9LZGZXV1FCd3FVSDZVQlpCWTVBcUhERGdTeFRnRU9qV3lk?=
 =?utf-8?B?RmgxMWR2c1JndUxEWFVOUnFoeHZvcjJWUDlJUDE2U0FpZC9RaDNqd3dFOTh2?=
 =?utf-8?B?WTRTcEs5d1F2UkpTbHhONHZzQ1ZhVnFvbXA0a0pZb2FWSlpaREJ4b010U1Bm?=
 =?utf-8?B?bzh3MXF3Ylc2QWJ6Z25UNWFGeFBmTktucmgxb29pWjQ4MjQ3UXByMGZoMTQ4?=
 =?utf-8?B?ZS95dUY4TFJnUUZxSGEvWjlLQWVGeGxheVE2dnJSUERVcG9IZiswQUQrZmUx?=
 =?utf-8?B?M01GbzFLYktGNU5mR2NWamtLNHllR21ZcTZhbGNxUzBDR3VEMUxsMXllcWdC?=
 =?utf-8?B?WFk0N1l6a05tc0oyUm96aHBTUTUvTk5YN3ZCWXRSZ1RDeXNETFVZM1RBR253?=
 =?utf-8?B?cWhRMmM2S0hYTmJpb0dDVE5BeUFRblE4QVFJcFVtN2VOOE92cnhFVCsveTF4?=
 =?utf-8?B?RG9IcG5xOHFnNXJjcnJHZnFDU3ZxaWxCdVlPUndnTzlhejhQRFNoaUpBNTNN?=
 =?utf-8?B?MmZyZ09SS2M1UEFUVTVQeE0xTkt6QStObWg5VW5PTHVoUUt5NkF2a0k3TnhJ?=
 =?utf-8?B?cldZY0dpcCsrOFBiYzdyd0NjNGZXTEpQa0dLSEFvN2RaVGZvOFBHazVWRmFN?=
 =?utf-8?B?N1Yrd1ZOL1ppbjNLV0hneC9reXUrR2tnK0YyVVpjUWd5TTl1VWhxOTFKTlBE?=
 =?utf-8?B?cTZPQW9Mb21LY2FWeXVueGR0eWlqRkZYVjBodUJsc0E1bEI4ZEI4RmN5SEJw?=
 =?utf-8?B?OEZzQllvRFh4U0VFSXQ3cEE0dGsrMHcwVWxnTVRLejlLd2o2dnJ0STk3Q2Iw?=
 =?utf-8?B?UEVEa3RCMityOTRhSjI5bmVIaTBDMTBNYzByVDY3RDBTN0tpTHhVK2gyU2xk?=
 =?utf-8?B?dkt2elptemdVdkZLQlZ2TGVlcmZJVWhUeE1vcWpXWXY2T1dJcHo4ZUo4OEdC?=
 =?utf-8?B?OGVCeDAzMi9yZXExNWI3MDFtMEJIUTc5OUZFOWp3bFM0YmxNeXhlV1pYaWNL?=
 =?utf-8?B?Z3BoMzA0MENJaC9jeEpGUGhYbWVQNDdQVzN5VkhFMlppV0o0eEtEejIvdTlz?=
 =?utf-8?B?REdXdkdUbjhqa1huN1NlU3hXeWpUQVVPMDZBNTUvVjFVelpZb2UxcVpMU1B1?=
 =?utf-8?B?c0wyeDhzejZXVDJHUjkzSmZnN01VTm1sZzZEdURDRmM2VWZ0TWhTdk1zSFV1?=
 =?utf-8?B?ZkVscEUzTmJNVlRuRzdEWjQ3STdPdlVqb3R5RzRmOGVMbDZHRVNQMUtGN2Vq?=
 =?utf-8?B?T0JGZUY3VWp4QWFHaHJIU1QvaGxZZGphcEp1S2gxRzFpcEZEdnZmS1ROeEZn?=
 =?utf-8?B?N0RHeTdpVHVhMHFkbkVjOUlMZHg5aVRpc2RjWXQzRi9sQlJzZHkxRW9sOE4z?=
 =?utf-8?B?UUlES3NpS3dBMEZYYWYxUVZsWVozdDBHWTlPblZ0S1lXR3JBWllVdWtab0Vw?=
 =?utf-8?B?c2hhYXBKMDlKNzlsSkNrVURFRVppQ0pnZUpTUVcvSUpRWUtDWHdudVFQMUZX?=
 =?utf-8?B?ODUrc1dzSzlOQ2s4S0VJa1REcURaRFY2K2VLUW5CWDVTNnVtaDJQRDd4NGkx?=
 =?utf-8?Q?8PPA7Hme0LDd3aUF9IFLf6N2urqVRgPcIQPyyPpeUPRS4?=
x-ms-exchange-antispam-messagedata-1: jTxr4YttPE0NQsjRJ7vv+38JNOIl9N2DCO4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFE8CFA7B0894148B36380A9D42D56B3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b+TTnG7l4TYkGzSjC+KgeRQ7EnxAnZBResRznCq81msL7DNtqtILMAaF8APyD1k/KvY9LhlW8tJOm5a95oeZn+uZBgy2HIrIHHGQYuNTPZjyno65Y3Y6sg9ovV7H0BXSlIrQ1tyzZDeIZq6S1+PzF9HNwhYgMnnZSZSz5qzfhI8h8OUKFqBKpp5QXtqvPhQxP/AEexYiPZ/XhKF1eNc7xEfV6I0EOLKSyxF+6wFNSQcM12buCbXthU3Irf38sOJkeLQq/cFXCoQuW55akzBOpkxAPWE1HsGuS91pVwPn/Jq144NtAPFVUFk6MZx4iNgpztEMigzr/sKwU6tQkKZFFQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Vm0rZWkSjHzsVpEZMor1wkqP290IzyMBkzj61U6zYqN3cFYIF5EJVGVD2kKnsm5xFTofOgo78ls3d8hCPRyECPsKJ7WpgCaRDnD7Hagj6DsxFpjcUjjnBSQxTQ/Q9sc8iqTz63YWtBvd7+l/7kK4a2Kzsf4Ju9R5RdhxUSoAA2K8L2rfTh7zfwrykPdlbdbr8dQEAVGEEUBpKqY6bDbRS/ZpC2ag+0JOpPvH+Bff+JpvPT/9IhbAcFr0r3Sp5eFl2iwRWuHFoXWzmlXAx2gpKktqhbTwAho+0+mJvKwsiaN8OeRq74RppO+JTdtSkN+GHp9EiHU8m6GTOIRyNt0YaeexT7lZ0jI+GOfGeAlaWphja2iH1XgUkREVAfC8YnHjyF/ZCHpIV7ssf5Y8vDWoXSHw3Zv9KWUOqjtSBB4F76xMqxgEX1A+zDvgfpmkUiPDj4fHEQKwqD5wN3WvSl+hg9NFUhXUBEqaUg7jwyT7eZkBO63xtN/0z1XUimmt/9ldlX4/uPa4y2XrdZ9IhBcA5YKzVnob4B3iTPNwlqbBxydXsySmoCV8t6IUUVU/f4J2EUTr8E3KsVKWfo3MqsKs8tUEa/xHrRZH6BRSRu48cKhlIINotRsYDhFyM9n3Mo6L
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdbc2b3-658d-4594-a708-08df49116b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 03:25:27.0636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HMBUUiRsI6mqy6usmI7xfx4o2gkH/vYlGYL6xAOQ+dLXMakIl+Y0mUDYT/KjuKg8c7mgRtmpPolVOQCea1618Cg/f9/wVhdRTWqp1qo8kNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9453
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTExLTEzIGF0IDE4OjU1IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gUHJpdiBzcGVjIHNheXMgaW4gdGhlIFBoeXNpY2FsIE1lbW9yeSBQcm90ZWN0
aW9uIENTUnMgc2VjdGlvbiwgdy5yLnQNCj4gdGhlDQo+IFBNUCBjb25maWd1cmF0aW9uIHJlZ2lz
dGVyOg0KPiANCj4gIlRoZSBSLCBXLCBhbmQgWCBmaWVsZHMgZm9ybSBhIGNvbGxlY3RpdmUgV0FS
TCBmaWVsZCBmb3Igd2hpY2ggdGhlDQo+IGNvbWJpbmF0aW9ucyB3aXRoIFI9MCBhbmQgVz0xIGFy
ZSByZXNlcnZlZC4iDQo+IA0KPiBTbWVwbXAgY2hhbmdlZCB0aGUgbG9naWMgYSBiaXQ6IHRoaXMg
Yml0IGNvbWJvIGlzIG5vdyByZXNlcnZlZCBpZg0KPiB0aGVyZQ0KPiBpcyBubyBzbWVwbXAgb3Ig
aWYgbXNlY2NmZy5NTUwgaXMgY2xlYXJlZC4NCj4gDQo+IEFkZCB0aGlzIGNoZWNrIGluIHBtcF9p
c19pbnZhbGlkX3NtZXBtcF9jZmcoKS4NCj4gDQo+IEZpeGVzOiAxOWNmMWE3ZDllNTkgKCJ0YXJn
ZXQvcmlzY3Y6IHBtcDogZml4IGNoZWNrcyBvbiB3cml0ZXMgdG8NCj4gcG1wY2ZnIGluIFNtZXBt
cCBNTUwgbW9kZSIpDQo+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0
L3FlbXUvLS93b3JrX2l0ZW1zLzQ4MjANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVl
IEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQoNClRoYW5rcyEN
Cg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+
IMKgdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgOCArKw0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5i
dWlsZMKgwqDCoMKgwqDCoMKgIHzCoCA3ICsrDQo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC1w
bXBjZmctcnctcmVzZXJ2ZWQuUyB8IDk2DQo+ICsrKysrKysrKysrKysrKysrKysrKw0KPiDCoDMg
ZmlsZXMgY2hhbmdlZCwgMTExIGluc2VydGlvbnMoKykNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQg
dGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC1wbXBjZmctcnctcmVzZXJ2ZWQuUw0KPiANCj4gZGlmZiAt
LWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvcG1wLmMgYi90YXJnZXQvcmlzY3YvdGNnL3BtcC5jDQo+
IGluZGV4IDA0ZGY1M2MyMzQuLjAyMWVjOTc4YjUgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNj
di90Y2cvcG1wLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuYw0KPiBAQCAtNzcsNiAr
NzcsMTQgQEAgc3RhdGljIGludCBwbXBfaXNfcmVhZG9ubHkoQ1BVUklTQ1ZTdGF0ZSAqZW52LA0K
PiB1aW50MzJfdCBwbXBfaW5kZXgpDQo+IMKgICovDQo+IMKgc3RhdGljIGludCBwbXBfaXNfaW52
YWxpZF9zbWVwbXBfY2ZnKENQVVJJU0NWU3RhdGUgKmVudiwgdWludDhfdA0KPiB2YWwpDQo+IMKg
ew0KPiArwqDCoMKgIGJvb2wgcl93X2JpdHNfcmVzZXJ2ZWQgPSAhcmlzY3ZfY3B1X2NmZyhlbnYp
LT5leHRfc21lcG1wDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8fCAhTVNFQ0NGR19NTUxfSVNTRVQoZW52KTsNCj4gKw0KPiArwqDC
oMKgIGlmIChyX3dfYml0c19yZXNlcnZlZA0KPiArwqDCoMKgwqDCoMKgwqAgJiYgKHZhbCAmIChQ
TVBfV1JJVEUgfCBQTVBfUkVBRCkpID09IDBiMTApIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVy
biAxOw0KPiArwqDCoMKgIH0NCj4gKw0KPiDCoMKgwqDCoCAvKiBObyBjaGVjayBpZiBtc2VjY2Zn
Lk1NTCBpcyBub3Qgc2V0IG9yIGlmIG1zZWNjZmcuUkxCIGlzIHNldA0KPiAqLw0KPiDCoMKgwqDC
oCBpZiAoIU1TRUNDRkdfTU1MX0lTU0VUKGVudikgfHwgTVNFQ0NGR19STEJfSVNTRVQoZW52KSkg
ew0KPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGNn
L3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IGIvdGVzdHMvdGNnL3Jpc2N2NjQvc3lzdGVt
L21lc29uLmJ1aWxkDQo+IGluZGV4IDNjOGIwMThkOWUuLjRiOTA1YTA3NzQgMTAwNjQ0DQo+IC0t
LSBhL3Rlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5idWlsZA0KPiArKysgYi90ZXN0cy90
Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gQEAgLTg5LDYgKzg5LDEzIEBAIHRlc3Rz
ICs9IHsNCj4gwqDCoCB9DQo+IMKgfQ0KPiDCoA0KPiArdGVzdHMgKz0gew0KPiArwqAgJ3Rlc3Qt
cG1wY2ZnLXJ3LXJlc2VydmVkLlMnOiB7DQo+ICvCoMKgwqAgJ2NmbGFncyc6IGNmbGFncywNCj4g
K8KgwqDCoCAncWVtdV9hcmdzJzogWyctY3B1JywgJ21heCcsIHFlbXVfYXJnc10sDQo+ICvCoCB9
DQo+ICt9DQo+ICsNCj4gwqBpZiAncWVtdS1zeXN0ZW0tcmlzY3Y2NCcgaW4gZW11bGF0b3JzDQo+
IMKgwqAgdGNnX3Rlc3RzICs9IHsNCj4gwqDCoMKgwqAgJ3Jpc2N2NjQtc29mdG1tdSc6IHsNCj4g
ZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtcG1wY2ZnLXJ3LXJlc2VydmVkLlMN
Cj4gYi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXBtcGNmZy1ydy1yZXNlcnZlZC5TDQo+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAuLjk0YTBkNmYwMmYNCj4gLS0tIC9k
ZXYvbnVsbA0KPiArKysgYi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXBtcGNmZy1ydy1yZXNlcnZl
ZC5TDQo+IEBAIC0wLDAgKzEsOTYgQEANCj4gKy8qDQo+ICsgKiBUZXN0IHJlc2VydmVkIHBtcGNm
ZyBiaXRzIFIgYW5kIFcuwqAgQ29kZSBkZXJpdmVkIGZyb20NCj4gKyAqIHRoZSBHaXRsYWIgNDgy
MCB0ZXN0Y2FzZS4NCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xv
Z2llcywgSW5jLiBhbmQvb3IgaXRzDQo+IHN1YnNpZGlhcmllcy4NCj4gKyAqIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ICsgKi8NCj4gKw0KPiArLm9wdGlvbiBu
b3J2Yw0KPiArCS50ZXh0DQo+ICsJLmdsb2JhbCBfc3RhcnQNCj4gKw0KPiArX3N0YXJ0Og0KPiAr
CWxsYQl0MCwgdHJhcA0KPiArCWNzcncJbXR2ZWMsIHQwDQo+ICsNCj4gKwkvKg0KPiArCSAqIFdy
aXRlIDB4MiAoUj0wLCBXPTEpIGluIHBtcDdjZmcgKGxhc3QgYnl0ZSBvZiBwbXBjZmcwLA0KPiAr
CSAqIGkuZS4gYSA1NiBzaGlmdCkuwqAgU3RvcmUgdGhlIHJlc3VsdCBpbiBzMC4NCj4gKwkgKi8N
Cj4gKwlsaQl0MCwgMHhmZg0KPiArCXNsbGkJdDAsIHQwLCA1Ng0KPiArCWNzcmMJcG1wY2ZnMCwg
dDANCj4gKwlsaQl0MCwgMHgwMg0KPiArCXNsbGkJdDAsIHQwLCA1Ng0KPiArCWNzcnMJcG1wY2Zn
MCwgdDAJLy8gcG1wN2NmZyA9IDB4MDINCj4gKwljc3JyCXMwLCBwbXBjZmcwDQo+ICsNCj4gKwkv
Kg0KPiArCSAqIExpa2V3aXNlLCBub3cgd3JpdGluZyAweDYgKFI9MCwgVz0xLCBYPTEpIGluIHBt
cDdjZmcgYW5kDQo+ICsJICogc3RvcmluZyB0aGUgcmVzdWx0IGluIHMxLg0KPiArCSAqLw0KPiAr
CWxpCXQwLCAweGZmDQo+ICsJc2xsaQl0MCwgdDAsIDU2DQo+ICsJY3NyYwlwbXBjZmcwLCB0MA0K
PiArCWxpCXQwLCAweDA2DQo+ICsJc2xsaQl0MCwgdDAsIDU2DQo+ICsJY3NycwlwbXBjZmcwLCB0
MAkvLyBwbXA3Y2ZnID0gMHgwNg0KPiArCWNzcnIJczEsIHBtcGNmZzANCj4gKw0KPiArCWxpCXQw
LCAweGZmDQo+ICsJc2xsaQl0MCwgdDAsIDU2DQo+ICsJY3NyYwlwbXBjZmcwLCB0MA0KPiArDQo+
ICsJLyoNCj4gKwkgKiByc2hpZnQgczAgdG8gZ2V0IHRvIHBtcDdjZmcgYW5kIGNvbXBhcmUgdGhl
IGZpcnN0IDINCj4gKwkgKiBiaXRzIChSIGFuZCBXKSB3aXRoIDB4Mi7CoCBUaGV5IG11c3QgYmUg
Y2xlYXIuDQo+ICsJICovDQo+ICsJc3JsaSB0MSwgczAsIDU2DQo+ICsJYW5kaSB0MSwgdDEsIDMN
Cj4gKwlsacKgwqAgdDIsIDINCj4gKwliZXHCoCB0MSwgdDIsIF9mYWlsDQo+ICsNCj4gKwkvKiBE
byB0aGUgc2FtZSB3aXRoIHMxIC0gUiBhbmQgVyBzaG91bGQgYmUgY2xlYXIuwqAgKi8NCj4gKwlz
cmxpIHQxLCBzMSwgNTYNCj4gKwlhbmRpIHQxLCB0MSwgMw0KPiArCWJlccKgIHQxLCB0MiwgX2Zh
aWwNCj4gKw0KPiArCWxpCWEwLCAwDQo+ICsJaglfZXhpdA0KPiArDQo+ICtfZmFpbDoNCj4gKwls
aQlhMCwgMQ0KPiArCWoJX2V4aXQNCj4gKw0KPiArdHJhcDoNCj4gKwkjIEFueSB0cmFwIGlzIGEg
ZmFpbCBjb2RlIDENCj4gKwlsaQlhMCwgMQ0KPiArDQo+ICsjIEV4aXQgY29kZSBpbiBhMA0KPiAr
X2V4aXQ6DQo+ICsJbGxhCWExLCBzZW1pYXJncw0KPiArCWxpCXQwLCAweDIwMDI2CSMgQURQX1N0
b3BwZWRfQXBwbGljYXRpb25FeGl0DQo+ICsJc2QJdDAsIDAoYTEpDQo+ICsJc2QJYTAsIDgoYTEp
DQo+ICsJbGkJYTAsIDB4MjAJIyBUQVJHRVRfU1lTX0VYSVRfRVhURU5ERUQNCj4gKw0KPiArCSMg
U2VtaWhvc3RpbmcgY2FsbCBzZXF1ZW5jZQ0KPiArCS5iYWxpZ24JMTYNCj4gKwlzbGxpCXplcm8s
IHplcm8sIDB4MWYNCj4gKwllYnJlYWsNCj4gKwlzcmFpCXplcm8sIHplcm8sIDB4Nw0KPiArCWoJ
Lg0KPiArDQo+ICsJLmRhdGENCj4gKw0KPiArCS5iYWxpZ24JNjQNCj4gK2Nib19zdGVwOg0KPiAr
CS53b3JkIDANCj4gK2J1ZmZlcjoNCj4gKwkuZmlsbCA2NCwgMSwgMHhhNQ0KPiArDQo+ICsJLmJh
bGlnbgkxNg0KPiArc2VtaWFyZ3M6DQo+ICsJLnNwYWNlCTE2DQo+ICsNCg==

