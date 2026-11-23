Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C068A606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=QBFikDnW;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=ViyQg+lK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJO6-0005A3-JU; Sun, 22 Nov 2026 21:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJO5-00059Y-6M; Sun, 22 Nov 2026 21:02:33 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJO2-0003hW-W4; Sun, 22 Nov 2026 21:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795399351; x=1826935351;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=4xjo4qN19gktnn9/VvQhtn46jaMcSq/hWcRqGoVYEDo=;
 b=QBFikDnWJl4Yx8i0IVhXXyLNGCeDJ2tOGig03Km5Zb8NBepufD8cqxcA
 AVS73+zsUlS8/SCYpH2Jp5L93r9BBzYdE24yA8K0QhpxF08zqTwRRD/cB
 KlYCIYVonEU/MRvQDRTDwQSuGrNxd4iuKc8Db0Kc3WyIDCzuAtIb3i2fm
 o3wIqsTIpOj92dcYZSFnDf6Sr9vznOJznEZW0Ybuyk7yyiW3pZ7GdF0Te
 c2pI9yNEkkpDE/Mo8XmV3qPwxO1WALMI30IreTJQCFgZsOihnpvpRiZpF
 0ZvLSI7rJGdjHnmurkY7HiTmxBCcdn5P5PkeD9hAic5YfQToiaKAacBg6 g==;
X-CSE-ConnectionGUID: B/TnEiYXSiaejSuRWOcl0A==
X-CSE-MsgGUID: 1mZDsN/BRUuVNZRJGUbUrA==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="161520485"
Received: from mail-centralusazon11011044.outbound.protection.outlook.com
 (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.44])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 10:02:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPWG74+kiImuM6a97J6CtbEdyfE3sgpZz3ZLC3y/twipIKyPZX9bcZQH5xt4HfBTIGYZAr1bOuuXicWR3m03VJa/D/wfqW1xzXrfrJzTi2L5tdJP+1qGut7banuzAOL9CIGOF02mkjfwaGaX9b34JV6qF+OcZdpfMLyEvy8Ef20ov4YvIvoO1GY3fc0iHXD1OLXads8Z0Cf+f5hUDYKp7eM3BQsgpcddhGXfaXV72uQgBIhHYJo1bj6O/dNwM+Q+2uAKwe0xCABwEYc3hkXfLs9TvigDKbszikT2SxsNuPYNlMOOZznVkasLEmtCGetPNHVRPEQUqmh1lHtgu5szFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xjo4qN19gktnn9/VvQhtn46jaMcSq/hWcRqGoVYEDo=;
 b=aSW6gPcnV8OwGGgUHPlLRbLGrDrm9vfqf6KeKTPbfHJJ9yUpZSf3aIxBhNrBhlrf+YUg3oGVT7Mv230jZft+qaAgqwUj0Y6CGCfUrnKRfk0usMrk44q8ReOO3nkBesN29mRlTQx7MV7KwgXsaj/tj1VXJWF42eFU6kGC/kUSWScAIKhjDg9dFCipWxCDsH1ohaek4CIkX+AXwvryHfF5gyV7peJR3Nx1oXV+K6fr8E/+Z1gZ3212ll+6NVucxk1JMOeFiO2bTi1GVzQfjw51CTVnMYfwy47OGr3vWhM0jlmVKambhc11F73p7Hbu698T65UHhCuHW6C3A18ccRWMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xjo4qN19gktnn9/VvQhtn46jaMcSq/hWcRqGoVYEDo=;
 b=ViyQg+lKRA5e9LLR1CNSjFTAI2r8hhMo26tQ6sTNOdlL8rMIM8raPgTHd53baHxnEKEc4+508PwgF6sT9HXS/5mqtCbs8TE7GzlqrSx08XdTi6c1rjlaQnPJdFIvottkFupTs5ZHQ0/GjZm7smxrObR+2kZ8ACaAXxYnf7Adklg=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BN0PR04MB7919.namprd04.prod.outlook.com (2603:10b6:408:152::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 02:00:25 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 02:00:25 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "christianslima@proton.me" <christianslima@proton.me>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v2] target/riscv: change mstatus bits for read-only if S
 ou U unsupported
Thread-Topic: [PATCH v2] target/riscv: change mstatus bits for read-only if S
 ou U unsupported
Thread-Index: AQHdcWrueFZU6wyThEWU3UUBXQJT9Lc6+fgA
Date: Mon, 23 Nov 2026 02:00:25 +0000
Message-ID: <7b3c4dcf209e7dab09fc017eafd93c6327fc60e1.camel@wdc.com>
References: <20261110232614.83050-1-christianslima@proton.me>
In-Reply-To: <20261110232614.83050-1-christianslima@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BN0PR04MB7919:EE_
x-ms-office365-filtering-correlation-id: 50e16d2f-7b7a-4f2c-8899-08df49058a65
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|10070799003|23010399003|366016|18002099003|22082099003|261009223027099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|38070700021;
x-microsoft-antispam-message-info: /nPJ8T4UsmpsfrTX7DX07SdM0O0Xxw4c2sZPMbwkQ5tILAG4PRC9zmTZtn5u0i7nhOXjOYhtqxk7i8uNrvMWXbv1jHoKhOnNbwOgqPU8EfsFSKhbmCsS492F4/pW270l78sUrY0zaqFU9Nlc0iPUYGDejIh4F0yvs+L/Vy4eMH/1MfCqS+s6MDThC3ynupuA6bgEKxjvJ0Ciidzil/1K65krjtZ3gH4aYWoIm60g6Tk1K32m45k+w3QurHgVL2nOgcI2cHZCCNSeUKm1qHE45LKINv7S65MlcahZ2A8So1MxYU+nMY9biIHKyEGLuYRpzvjQv+3E0M5jCSpiaMWD9fRUW/gSI9T6V5yi5+jYSgAQkQAKKbb/xHnMw0aP8nZeT1YJ0EZvj82RkVnMqKwkTypAix7Ir97DJCTSgDsBoinigCMrpEHkEHBg/33lrBaiVvtJYamFSWoUwz5TpHfuR1cR2uQJfRwUnH8GRcI9URQQlER1WJk4lOBPCrsN5oq7249aepy5MoABBrcaX0PIXmZDx90+zMFA42OGpXsYdaAlL3R5hcIOQ/APB29V3KFynAy+IjzP/ajWLCM7YeZJIZzUAqkj1bNL8jX3E9G9me5kNxhaS6PnQyEYncgGLNoPyF5b5SX3YqBoLJkW7tGvPCiuaRoCv1hg7Dk0viUL8Yc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(10070799003)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3hYc2NGNFJnMW1wTFlvQm94bFl4V21ISzJiTnR6WWgvenhZVDJHTjJPaDFl?=
 =?utf-8?B?TkNRWUJ5eGgxSm92c1FvcDc1bVhLSHBFbFd6U3NSQTVnd0ltcTY0b2tTTmxQ?=
 =?utf-8?B?a0w5aVhic0E5UXJsdU1NbFl6ZkFTVUJPNVhVZk9LM2s2Und1VFFvUHpvZmR6?=
 =?utf-8?B?WXlPL2ZoTWhjY01EY2pYMjRJZ29KRzdpdnlOQVJtQ3NoRHVMZmtUNHU5SmVD?=
 =?utf-8?B?d1IwbWdsN3hzcmFBVUhnLzNScnhWZll6SnF0WmF6MmhUbEdHbUZCOW9GUHFV?=
 =?utf-8?B?NzFFVmpGVW9MRlZXUklOc0NUcDl5OGlBV0ZpQnJ3cy8welZjWFFyWm9IRE9B?=
 =?utf-8?B?QmYybFFEUWd2UnBRbDFlM2c1dkpkUncyMTF6bWgrNURDaEV2TzZiOU5hTEto?=
 =?utf-8?B?T09GL3BkSGhkYXdvY3BwZTN2bG1UQTJHeVhsdEFxaVVNS3ZubVMvU0RkYm1J?=
 =?utf-8?B?MzdrRG1OMjNrM2dTRHhPMXhUMXlicDVjZHBKTmhXS2U2b0xTcW9EaVZXNjlC?=
 =?utf-8?B?by9pVVZnR3NqNDhkSDRXYXNuOXhpem9qVXVYaEw2U0RGMG44aVdrSU9Ld2Iz?=
 =?utf-8?B?OTdvV2ZDYll5ZTNXbG1DcVBtYXZkWWVVcUZ4L1N1QTU4alYvSUdOdjB5L2ZL?=
 =?utf-8?B?TTZ0VzhYVkRrbTQ4QmdLK0IxTGJSemJZK2RRQXkwRFdrZW5BOHdzcWMvV2V3?=
 =?utf-8?B?Y2ltYVFsbWVMZFhpMms5R3Y4a21Wck01akh6bVZBWFoxaUN5UmRrekJLVkhP?=
 =?utf-8?B?eXdQem1sSzdQMll2T05xRDRVL2JTUExkdDROVm9rcU9rUExTbStnS2hMUWNo?=
 =?utf-8?B?ZzBUOTFTa3VEUWNwRzBpdmdmYk1zdjFOdGsvdWVYazdKTkRNQnlRZFArSGh3?=
 =?utf-8?B?K0d3L3dxZE9nTTQzSHRScktzWHR1aEN1NW80S3kxT0RPUVJJTzNrdTc2Z0F0?=
 =?utf-8?B?Vi9hUm9zZ1Ftd1A4MXBoVk5mMmV4V2M0TGhoQUhkOTgwakpiRmJ1QTRJN3pn?=
 =?utf-8?B?WUFhTnV3M2lKLzR2ZE1CS1Iyakl4b2tGemxhRmJobEo3OU0wbStlSWh5MGcx?=
 =?utf-8?B?dW9PL2NPVmpxT0JSK0JNS2J1ZDFYaHhpM0RGYkdlUDlZOFZkTUFhZ3JjdFJs?=
 =?utf-8?B?d2RGYWlhNU9NQlloc2ZRRUllRzNlYnppRm5xK1RRRzlpTUhGc3d3ZjNubTJV?=
 =?utf-8?B?SFZ3cno1QjRIMTB1Qys5YlVRTHREQ2hqdkJxZUxCRjB3bDNwSFZZUzZLdDVN?=
 =?utf-8?B?K1B2dm5NUjltdGt6SnVwTkxrUExmdkltbEdUcFg2dnFqTGVxTXptOU1RNkxV?=
 =?utf-8?B?cElhYjJETHdoZjRXbXA2RFlxcmdBNW5jcHlxbEdySUFjeXZnY3RvUmZqNDhL?=
 =?utf-8?B?emxLa2VCRERqaTVtcVUrdEgrOFY2cjdjVTUrU3NxYXdOdmlPTlhpOFdaYVVR?=
 =?utf-8?B?Ymo1cC9WN0JaUU1LVW9OZSs3NThCMGdpOCswemdHZVFLRjdERmFIa253eDFv?=
 =?utf-8?B?Z3FkZWxCMnVYdVpuTXlsNlhENmFNSGlKUjFrb2xUSXgzNUc4VmhkQlFOK0Fo?=
 =?utf-8?B?SUY5WUx3MVlmcGt0MnVTZ1poUzgwUVpRSTBBWmNDbUljSHlPUXBRbWFaTExK?=
 =?utf-8?B?VVV6aDNQbzE4UGtxYzBOa3NKQ3YyeVJaZ2RUd0FwdXliV2xBZXRjRTBJdjJn?=
 =?utf-8?B?NUEvMnJzSzdlTzNMdmU0aEw2NTlGZThmd2UvaFJYaGFwbUlwbUR3MkVSQmZr?=
 =?utf-8?B?aDVITHk1VTVYUXBjMUw3d0VLMnBRVlJlUVdvUi9jeXU0SUNTVU9pUkVkcHZE?=
 =?utf-8?B?akE4VTZkS0RCeXl0bnc3SkVnM1d1c2dPMjhxN0FjdnJHVUpyakxlSDV0MmRF?=
 =?utf-8?B?UVRyREg5VngyUzNhNDJFYVpBTmIwOUI1RWJhVnlHcFZzWDd3SEQ1SlQ4bVFr?=
 =?utf-8?B?LzBndkFNVmNDNjdNMVM4RFNodFIrbWptR0ZCb2ZrZlFuM0U4amZwQUt5dmRT?=
 =?utf-8?B?d0xxb2ttOG9ETnRwV0pTVWpBd0E4T016VmVIMWtxSmNXajdtNC81OWlobDVP?=
 =?utf-8?B?N3Y3VEZLSjF0NSswa1lBbEM0TFNFSjVKMGEzZ1huOTlJSis1bHY4dTdkOTQ1?=
 =?utf-8?B?dk9Ob2hpUzB6YXIxSnJ1NWNNRDJ2Sjk2R0ViM3BFby96THhmcFZvWDl6dFIy?=
 =?utf-8?B?YmRvQ2E2RFkxNkZkYlRLNDg0WmI1UVdYSUhROGNZT2E1RmpZWGNmOGNyZzQ0?=
 =?utf-8?B?OS9wNksrTHJiN0ZVWWR3LzBZQTNJNDBFTW9CWHJKcGtpeG1CaTdLMFVxblFG?=
 =?utf-8?B?L1dJR2txQTVSd0VWZEdIZzNiRVJmMVFjakIzcDdvZXc4UU85NWVwTVU3TjVU?=
 =?utf-8?Q?n1y7Vt2G+M+FnpA5h8qgqRUo1sky2xIiM/rCbXPmzD7dF?=
x-ms-exchange-antispam-messagedata-1: her1SSGWRmKFbNkICuLbtxvxrUan1MZ24+8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6180F52FCBD8394B9A91633CE57E5A3A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XiDo41olsHkzRDOgu6xWxHYyvUr/Qo4OPzIe+M7sUyKf4Hn7A+kGX4MD/AiJQLWb8iFNV+RBzYuu3Dqo96uY7tHyBSTt9nkXrFY2o161WXWk63fYQH6oN64vsI8xrt09A743cAJCQS8o+cW7tRXrBk2/HbzPuKhTlbxdzCxyulZDEe5VM5ILS5GRQtCvN1AxloQWl1OkkKMGGkO38029WBjY2fbwHnet7TUgmbdBDT+g4kdznq9Tjf62FhYTGwaR2TUvjt+qPeA1CyDwF7Llly/qqK2qomMblkVppyrZFz2cRkoZagMBeakSH60CWlJ4tdmqGy73tsmo+ftqFDAcTQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: po37ZyOdHgN09IlAXexGRDqtuYcGzGYw87Xr474GkMgl7YXACkmFF+/ApGxCXJrL0bzuDwiZuQ+zQWaLl1KmEoE8gTSel/se8fR344ccrex1PZMPcfiJpa5PhPHkPqefl17nzu9RIwLKb/OERkHRq+Cz5cv7JBmJVZ/Zc2HRVYyOaYY4d2jc8CE1jvFJjg3XaZNX43NSmlooYJa4lvdtyZVmtRFDrgGgC2iTveJywRg3lbKTNWpl2WDinXGWu+30d3xy1kJm+CruAtDzFKnjClukdXrAlStwSd/jfFw82uBmeDq4jyk0XtuBn21NP2RpXZVtitfrM8nepFJA9s1rVJ8N6DnJ4Ob6bx2sxuHL5bPQGNjYy7FrKLgejdzNvtchqpq/oy3yfBg27h0CFETjArRX8/Ck6fc9t7elyh/gSMrhmkRFIRPcyuubcX44O1rK5JCejm4mq1R1cg/nez1WLcA2/ECeATzMmPjF1ufv1SPQ+zHwcRxHc0nd5pZGz8svXaf6jqDgL6SnBdLuvoljLqvuthA+DgrkTdjcW85QCR+y62Yd/rGPbeScMszmH6kke2QGXKaKhregXvV4V51YuaPn8bam1/DnuyeyYVIv0aTCqlMLTFbO3C7xhDrcefWz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e16d2f-7b7a-4f2c-8899-08df49058a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 02:00:25.4722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPVAHTlMzf1YEUVnaGk1eTh5b/X58ri2/MCLXTDkua2xPSmeg6iAur/5yYjMUYYVW2epy45Y/zZQBagKF7eSbYMxWa1BwNeH9NfiYjWLpBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7919
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTExLTEwIGF0IDIzOjI2ICswMDAwLCBDaHJpc3RpYW4gUy4gTGltYSB3cm90
ZToKPiBUaGUgcmlzYyB2IHByaXZpbGVnZWQgYXJjaGl0ZWN0dXJlIHNheXMgdGhhdCBtc3RhdHVz
LlNYTCwgVVhMLCBUU1IsCj4gVFZNIGFuZCBNUFZSIHNob3VsZCBiZSByZWFkLW9ubHkgd2hlbiBT
LW1vZGUgb3IgVS1tb2RlIGFyZSBub3QKPiBwcmVzZW50Lgo+IAo+IGNoYW5nZXMgaW4gdjI6Cj4g
LSBEb24ndCBjaGFuZ2UgYml0cyBpbiB0YXJnZXQvcmlzY3YvY3B1X2JpdHMuaAo+IC0gQWRkIGNo
ZWNrcyB0byBTLU1vZGUgaW4gdGhlIG1zdGF0dXMuU1hMIGFuZCBVLW1vZGUgbXN0YXR1cy5VWEwg
aW4KPiB0aGUgdGFyZ2V0L3Jpc2N2L2NwdS5jIGZpbGUgdGhhdCB3ZXJlIHN1Z2dlc3RlZCBieSBE
YW5pZWwgaW4gdGhlCj4gcmV2aWV3IFsxXQo+IAo+IExpbmsgdG8gdjE6Cj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1yaXNjdi8yMDI2MTEwNDIyMzA0OS44NjI4Ni0xLWNocmlzdGlhbnNs
aW1hQHByb3Rvbi5tZS8KPiAKPiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJv
amVjdC9xZW11Ly0vd29ya19pdGVtcy80NDU2Cj4gCj4gWzFdCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcWVtdS1yaXNjdi8yMDI2MTEwNDIyMzA0OS44NjI4Ni0xLWNocmlzdGlhbnNsaW1hQHBy
b3Rvbi5tZS9ULyNtZGRiYjM0YTNlYTgzN2UzYzcwNzEzMWEyZTM1NGM2M2M5ODlhYjAyOQo+IAo+
IFN1dWdlc3RlZC1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEKPiA8ZGFuaWVsLmJhcmJvemFA
b3NzLnF1YWxjb21tLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gUy4gTGltYSA8Y2hy
aXN0aWFuc2xpbWFAcHJvdG9uLm1lPgoKUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFs
aXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKgdGFyZ2V0L3Jpc2N2
L2NwdS5jwqDCoMKgwqAgfCAxMiArKysrKysrKysrLS0KPiDCoHRhcmdldC9yaXNjdi90Y2cvY3Ny
LmMgfCAxNyArKysrKysrKysrKystLS0tLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1
LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMKPiBpbmRleCAxNWMyN2Y0Y2U0Li41MGJkZmJlMDI1IDEw
MDY0NAo+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUuYwo+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHUu
Ywo+IEBAIC05OTcsOCArOTk3LDE2IEBAIHN0YXRpYyB2b2lkIHJpc2N2X2NwdV9yZXNldF9ob2xk
KE9iamVjdCAqb2JqLAo+IFJlc2V0VHlwZSB0eXBlKQo+IMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRo
ZSByZXNldCBzdGF0dXMgb2YgU1hML1VYTCBpcyB1bmRlZmluZWQsIGJ1dCBtc3RhdHVzIGlzCj4g
V0FSTAo+IMKgwqDCoMKgwqDCoMKgwqDCoCAqIGFuZCB3ZSBtdXN0IGVuc3VyZSB0aGF0IHRoZSB2
YWx1ZSBhZnRlciBpbml0IGlzIHZhbGlkIGZvcgo+IHJlYWQuCj4gwqDCoMKgwqDCoMKgwqDCoMKg
ICovCj4gLcKgwqDCoMKgwqDCoMKgIGVudi0+bXN0YXR1cyA9IHNldF9maWVsZChlbnYtPm1zdGF0
dXMsIE1TVEFUVVM2NF9TWEwsIGVudi0KPiA+bWlzYV9teGwpOwo+IC3CoMKgwqDCoMKgwqDCoCBl
bnYtPm1zdGF0dXMgPSBzZXRfZmllbGQoZW52LT5tc3RhdHVzLCBNU1RBVFVTNjRfVVhMLCBlbnYt
Cj4gPm1pc2FfbXhsKTsKPiArwqDCoMKgwqDCoMKgwqAgaWYgKHJpc2N2X2hhc19leHQoZW52LCBS
VlMpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW52LT5tc3RhdHVzID0gc2V0X2ZpZWxk
KGVudi0+bXN0YXR1cywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1TVEFUVVM2NF9TWEwsIGVudi0+bWlz
YV9teGwpOwo+ICvCoMKgwqDCoMKgwqDCoCB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmlz
Y3ZfaGFzX2V4dChlbnYsIFJWVSkpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnYtPm1z
dGF0dXMgPSBzZXRfZmllbGQoZW52LT5tc3RhdHVzLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTVNUQVRV
UzY0X1VYTCwgZW52LT5taXNhX214bCk7Cj4gK8KgwqDCoMKgwqDCoMKgIH0KPiArCj4gwqDCoMKg
wqDCoMKgwqDCoCBpZiAocmlzY3ZfaGFzX2V4dChlbnYsIFJWSCkpIHsKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZW52LT52c3N0YXR1cyA9IHNldF9maWVsZChlbnYtPnZzc3RhdHVzLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgTVNUQVRVUzY0X1NYTCwgZW52LT5taXNhX214bCk7Cj4gZGlmZiAt
LWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMgYi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jCj4g
aW5kZXggYWY0NDRlM2U2Zi4uMjRlZGE1NGJhYyAxMDA2NDQKPiAtLS0gYS90YXJnZXQvcmlzY3Yv
dGNnL2Nzci5jCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYwo+IEBAIC0yMDgxLDE4ICsy
MDgxLDI1IEBAIHN0YXRpYyBSSVNDVkV4Y2VwdGlvbgo+IHdyaXRlX21zdGF0dXMoQ1BVUklTQ1ZT
dGF0ZSAqZW52LCBpbnQgY3Nybm8sCj4gwqDCoMKgwqDCoMKgwqDCoCB0bGJfZmx1c2goZW52X2Nw
dShlbnYpKTsKPiDCoMKgwqDCoCB9Cj4gwqDCoMKgwqAgbWFzayA9IE1TVEFUVVNfU0lFIHwgTVNU
QVRVU19TUElFIHwgTVNUQVRVU19NSUUgfCBNU1RBVFVTX01QSUUgfAo+IC3CoMKgwqDCoMKgwqDC
oCBNU1RBVFVTX1NQUCB8IE1TVEFUVVNfTVBSViB8IE1TVEFUVVNfU1VNIHwKPiAtwqDCoMKgwqDC
oMKgwqAgTVNUQVRVU19NUFAgfCBNU1RBVFVTX01YUiB8IE1TVEFUVVNfVFZNIHwgTVNUQVRVU19U
U1IgfAo+IC3CoMKgwqDCoMKgwqDCoCBNU1RBVFVTX1RXOwo+ICvCoMKgwqDCoMKgwqDCoCBNU1RB
VFVTX1NQUCB8IE1TVEFUVVNfU1VNIHwgTVNUQVRVU19NUFAgfCBNU1RBVFVTX01YUiB8Cj4gTVNU
QVRVU19UVzsKPiDCoAo+IMKgwqDCoMKgIGlmIChyaXNjdl9oYXNfZXh0KGVudiwgUlZGKSkgewo+
IMKgwqDCoMKgwqDCoMKgwqAgbWFzayB8PSBNU1RBVFVTX0ZTOwo+IMKgwqDCoMKgIH0KPiDCoAo+
ICvCoMKgwqAgaWYgKHJpc2N2X2hhc19leHQoZW52LCBSVlMpIHx8IHJpc2N2X2hhc19leHQoZW52
LCBSVlUpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIG1hc2sgfD0gTVNUQVRVU19NUFJWOwo+ICvCoMKg
wqAgfQo+ICsKPiDCoMKgwqDCoCBpZiAocmlzY3ZfY3B1X2NmZyhlbnYpLT5leHRfenZlMzJ4KSB7
Cj4gwqDCoMKgwqDCoMKgwqDCoCBtYXNrIHw9IE1TVEFUVVNfVlM7Cj4gwqDCoMKgwqAgfQo+IMKg
Cj4gK8KgwqDCoCBpZiAocmlzY3ZfaGFzX2V4dChlbnYsIFJWUykpIHsKPiArwqDCoMKgwqDCoMKg
wqAgbWFzayB8PSBNU1RBVFVTX1RTUjsKPiArwqDCoMKgwqDCoMKgwqAgbWFzayB8PSBNU1RBVFVT
X1RWTTsKPiArwqDCoMKgIH0KPiArCj4gwqDCoMKgwqAgaWYgKHJpc2N2X2Vudl9zbW9kZV9kYmx0
cnBfZW5hYmxlZChlbnYsIGVudi0+dmlydF9lbmFibGVkKSkgewo+IMKgwqDCoMKgwqDCoMKgwqAg
bWFzayB8PSBNU1RBVFVTX1NEVDsKPiDCoMKgwqDCoMKgwqDCoMKgIGlmICgodmFsICYgTVNUQVRV
U19TRFQpICE9IDApIHsKPiBAQCAtMjExMSwxMiArMjExOCwxMiBAQCBzdGF0aWMgUklTQ1ZFeGNl
cHRpb24KPiB3cml0ZV9tc3RhdHVzKENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLAo+IMKg
wqDCoMKgwqDCoMKgwqAgaWYgKHJpc2N2X2hhc19leHQoZW52LCBSVkgpKSB7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG1hc2sgfD0gTVNUQVRVU19NUFYgfCBNU1RBVFVTX0dWQTsKPiDCoMKg
wqDCoMKgwqDCoMKgIH0KPiAtwqDCoMKgwqDCoMKgwqAgaWYgKCh2YWwgJiBNU1RBVFVTNjRfU1hM
KSAhPSAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyaXNjdl9oYXNfZXh0KGVudiwgUlZTKSAm
JiAodmFsICYgTVNUQVRVUzY0X1NYTCkgIT0gMCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBtYXNrIHw9IE1TVEFUVVM2NF9TWEw7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCA9
IHJpc2N2X3dyaXRlX3V4bChlbnYsIHZhbCwgTVNUQVRVUzY0X1NYTCk7Cj4gwqDCoMKgwqDCoMKg
wqDCoCB9Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqAgaWYgKCh2YWwgJiBNU1RBVFVTNjRfVVhMKSAh
PSAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyaXNjdl9oYXNfZXh0KGVudiwgUlZVKSAmJiAo
dmFsICYgTVNUQVRVUzY0X1VYTCkgIT0gMCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
YXNrIHw9IE1TVEFUVVM2NF9VWEw7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCA9IHJp
c2N2X3dyaXRlX3V4bChlbnYsIHZhbCwgTVNUQVRVUzY0X1VYTCk7Cj4gwqDCoMKgwqDCoMKgwqDC
oCB9Cg==

