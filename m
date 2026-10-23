Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F0606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=LmIm0QIs;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=YthyqalB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4dV-0008GM-CQ; Thu, 22 Oct 2026 22:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK4dT-0008G0-AA; Thu, 22 Oct 2026 22:03:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK4dR-0007ed-0X; Thu, 22 Oct 2026 22:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792721037; x=1824257037;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JvVvvZLknF0SjpVl2sfOovtnZYgnL5mPx7B8cCq66O8=;
 b=LmIm0QIsdfAfuAIQMAkPJZXqL+3kn9kGZerTWL9X2t3UmhOsp4oYBhuV
 ECmM67jT7VmiYPP/QUqRayvL7IDFnmsx8Z3GUCcDJkebAqlMDrcJ7xPqR
 HGMEse7IzUFJxA9gvLtQCrMTK7YDd/Zj9rlYIQ2a3hgEi/vB0cbc3S03X
 pv0taL5weOBCKWwULKvCdxD9tf5qqEtnJu80dk2mzDD821BM14BTDBC+k
 xI5BqgRawOSIWPPWaaY0jd6l4eJr/Wqnn/zNnP4MYCbr3QsNIf6kvQI8+
 mDecybTybn90GSKCiJppBDxSMU2AOYO+UBfOqvDoNM9BZ370pegD0zo4v A==;
X-CSE-ConnectionGUID: tfzqU0NmTxe5jZ4VAHofyw==
X-CSE-MsgGUID: 4vRaVtJJQiC7+LhKbaYUBw==
X-IronPort-AV: E=Sophos;i="6.27,173,1786982400"; d="scan'208";a="158692771"
Received: from mail-northcentralusazon11012053.outbound.protection.outlook.com
 (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.53])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Oct 2026 10:03:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leJAXWkxjhvt4s25cz5sPZfc/e58mEATPqjUDMxXTbuaumt6epulnSgbUAR1ZoggOFbIUysOCHVPg1LEhUWNZVMsvC34cwfjuzaQg7GfzRjuoCG6zA8WN1b6BOY8hYQ6wjGoYDz2XfC5S7hfYz9UYH276NgJSOkk495E0ymGt1Rs5EWRbvn/yrVTnc/SWhd8rc+UWo9sycggG6NoNvHwvejZ2K7+pAxCfC07fo5zMqnPQeEHpgQw5oHzVg5+f3BuAuxf+OlIeTKm+n2AwHMANwELyH4mgC05i6fxfg1k+LVUWuMc1/MdpouLbQNBbdyPOy+42gr/m8MNKgJ0PeGaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvVvvZLknF0SjpVl2sfOovtnZYgnL5mPx7B8cCq66O8=;
 b=KesiGtrB9Y8jcN8jV/GvG2VJt1LI+GCYYb5nirQfsTFstJAo0FZ35k+IKFDaZc5nI0k+w4JSZ8LBd5Uek6enklFxFGgFXNa3buxgmpgF6DwgIo7LyulK6uG6LRN+fCd5kvxM+irfjxqik7FUnoKT+G8Hn0iKOfclRGjXHCQ9ZJWfSJXWbFZnbzsT58Fdo9hDsKsZOQcdLsMty3y9tpMO/RsU0vxKKyFFZEIiQZgjO7NNS/YjMxDgevjPna3Ub0TsJEjcLdqH/IWzmW4yi+6HajYpe91Ol7ordXk2E/zgy/gcTejE+65ygJCmnqWWXyD0GH5X8FzpBbra8CKpZ1vsmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvVvvZLknF0SjpVl2sfOovtnZYgnL5mPx7B8cCq66O8=;
 b=YthyqalB128OTznGrwPdxl/V78iQajz3TUhY3QtrsMtKre2A6mRPCDjyOv8XY6q4+NZcQ/nirK5xtBz+ASq1M5Pq6X7OfcGx70lIgdWPNXWkTV2wAo5mDeh/ogfabW1/aqc7DvIjLNMVnsKKxA3DT0hYXHe0q3wNRFpGWSQ/Btw=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CO6PR04MB7634.namprd04.prod.outlook.com (2603:10b6:303:a7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 02:03:48 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 02:03:47 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: Use 1ULL for a value we're going to shift
 by 63
Thread-Topic: [PATCH] target/riscv: Use 1ULL for a value we're going to shift
 by 63
Thread-Index: AQHdYmFsp9hoB5X5A0qrFnLRQji2WrcKYLYA
Date: Fri, 23 Oct 2026 02:03:47 +0000
Message-ID: <41ee23f846c650f94d11979ad7057cf47e92b5c3.camel@wdc.com>
References: <20261022201037.764619-1-peter.maydell@linaro.org>
In-Reply-To: <20261022201037.764619-1-peter.maydell@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CO6PR04MB7634:EE_
x-ms-office365-filtering-correlation-id: e82013f0-6aad-4915-397e-08df30a9dfc4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|376014|366016|10070799003|1800799024|18002099003|22082099003|38070700021|11063799006|56012099006|261022105027099003|10067099003|261021123027099003|261021121427099003;
x-microsoft-antispam-message-info: e4nhjL40Hf//6cs9+yVcRcbQHpg8zs+NtCpxa2YEnrdL9nRx/L1oONd8n+fdOGFgaYBFVfg5y1esQ4b8/ao/MQqa3gYBi5823MxUnDowFlZcu86uIgqWLchbRX1DRaIYWpsD/g7BCTQPAiwPL6esz5FhxndkkbprAV51HqM6HI36yGulcSItpb5HLlsgu3q9j8O/p6/bgxWkshVqHCLuhlpYXgOo2izY/DdgLY0U4Y1HRuh5iOshAgcONUDMJdY4ZR3CpVVpwa99S5VOxpOk48HXPGPYS7Tc8PsabPdz/6h7hNDfXw0QkrsM+Vx7rp/TdZYOTb4u/OiIlL6Gb60s0Qf0+5P2P3XZm++wSxbbt/8rH30RBneyY4ignRkMH/jy8tWIBraNGGWFaLZLDQFhxIcElHiZ/LYErF63v7r1xwrId2hZ8egcHXDBLFduXX0v0NkzN+QZbyk410QlXRFWICKWEUP2hr4QjrvRJaKWN8GLSqO1IV8dsTspjeRjsJ/FXAQ+XFA6VPxmwWwZ74RFFNHZakZaJ06SwuY4LPS297Sb4/3aMyqKsPXxvCIpBMs54625wu71rTcPB7Dq57g41VfhwCEyY8L7LeNczQLTKaisENCO8AqKcENNQEC1nYy2okjGvDUwhr09bmDEK4GiB2GWsPbGSUVCMbYQ6uZZug6nxUT88cGrNcbiX7AekVUbjE1kfc3GWsBM2vber0roSGE485cT7pFWflzMNh9n2HA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(376014)(366016)(10070799003)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(261022105027099003)(10067099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFJOL1V4ck91azl0Slk0eENxMTl5S045NEF1Yk9EUjhlc2IvbFFFNkNvZ3Ax?=
 =?utf-8?B?cVR6aStPaHZpUmI3b3BrRVVGV3NQblVJK0RJQWZ6TWN2K3M1RDBVRGdjcGll?=
 =?utf-8?B?SkdndDRjeHNUZXhMUVJwWE4wM1JFaGhmTmVTMHE0VHVLTXZlMXRoMVJvVnE0?=
 =?utf-8?B?RVpVWmhaYlRpbGoyb3B0U0JlSjBGbTBIWW5ROUE5elRCZWxUeXVrdG9IelN6?=
 =?utf-8?B?cENMcVBEekxDaVRBSnd5dTRSS3EzOTUzM3ZkaXVjNDBWd0ZIcTVqbHZUbWg4?=
 =?utf-8?B?d3NLd0F1WG1vcWQ1UnNLYk9KTzNHMlUrODBpdm9ac0ExU3JoRVdhc2NaMFhl?=
 =?utf-8?B?QytSUWIvcHlRNHUzOGNydmhOWWQrdis2RzAybkdGM3daUld2dDQ0VnBCcW9u?=
 =?utf-8?B?Wi95SVVSNmo0TkJjZkJEd1ZubnFBL1JkZnd6YVBRdGRkTXk1SERQd1BsbE1W?=
 =?utf-8?B?RGlLWVQrK2dsaklsNDNyMlkyOWc0eEV3QlYwKzVlMWNZbkdYaHIxN0VLVXow?=
 =?utf-8?B?OGJmSnhWZnMzQmRNUHVLaHFJTkt6NWlWSlU5dFNEY1B4UjgrRmczSXRES2Fp?=
 =?utf-8?B?QW5MdkNLV2FLeEJYTkdKZzZIQ0JTZHgvVExmTm00YUtiZUtzQUdQc0twS0NX?=
 =?utf-8?B?cVRlNzNyLytyRnlOd3FRU3oyb09RRWw2K2djUWtsazhqbzJMZHNWRWI3U291?=
 =?utf-8?B?cjRkbTZPNzFLRUxuSEdVWk9IVWF6RFM1VWQ3TXBtUjJrTVY5V2cwVnA2Undn?=
 =?utf-8?B?clpvTHl3VDBJc1RpZWF4OXRMSGVJcDNVWWJPZGVxWlZLZlF3N2ROVmZWQjhV?=
 =?utf-8?B?NHAwV042UWxHeGdCdWlqTGlld3NmeFR4ZzNoNldOWk51N2FJcnhzSm1lcklt?=
 =?utf-8?B?QUw1QThzZmVRSDczMGZ2ZUVCQ1dTUWcrZzZOWldXbG5lUGVwdlVMam43VjZY?=
 =?utf-8?B?aFBiVkpKYjNIc3pUbGRRckU2N21ZWWJHZ1ZEMWpndGdaRHFYdW8yWW9HL2NH?=
 =?utf-8?B?dEhwNmpkT0h1ZzUveUhjSllRbktWRzMyelArYUVPMHQzNTBMSUJOWmZWeWtD?=
 =?utf-8?B?RkdGSXA4M2RCWXhwck9GSDhNWHFlMEYxdDdPQ0dCMllSNjBlbytGazQvTzU3?=
 =?utf-8?B?T2xLVWZMdVRhTzhFdGNjVm9oRTFMTHk3S1lwZDlUTHlkL0xxQ2NoRzhTbHcv?=
 =?utf-8?B?WGZHcmlVY2lVNHZMcDkvRWdiZDNuSGZUaitCdFQ0RnhmazNuNS9hc3VHYUc0?=
 =?utf-8?B?czQ0TU9SWEQvMHB4RWRwR1FSZVRDK2Rzb3FiVElsK1RBL0d4eG9DZVgvOVdz?=
 =?utf-8?B?VXJzNWpNdExlSHBienVUWUNrajdVTHFudlVaZnBkTGZDOVN0T0d1eFpPZlpH?=
 =?utf-8?B?V0w2TDJwMTZYS0YxWVArb2E0Y0d6OCtDV1lQRU50QjZjcWswSDh5a3dLYVV0?=
 =?utf-8?B?T2tyY2hySXp2Qmt0cDBSMGFCTXBlKzJzK0xMNGlYWVRCS0pSeWhiMU9US3A4?=
 =?utf-8?B?N0lPR0NqelYzS3BMdUZvcjUxRTNCZlhnZGx3WklEWmg2N01TR0pOWW5QK082?=
 =?utf-8?B?SEtkczRIbWtiZzRSd1h1ZDNaZEd5Mk4ycDFMbVZNYnVPcjkzYUNrMnhlQUdS?=
 =?utf-8?B?bWVDUGZQeHJVbkdUT1lucUxzcldqQ0RVeWFxSlBZbU40MEZJOGMyOEN6anVN?=
 =?utf-8?B?dmxERjBTeC9nMlRhK2NyVUp4a1N2OCtwaUNqUzdQS21vcW9zUnpPMU5mWTJy?=
 =?utf-8?B?b1lwczVwWWxob2RRZUNlUENBUFJkbk1HcXV1R2lFMGV3Vi9XK1pKZ05rWTFv?=
 =?utf-8?B?YXJTMnlwUTRURERjRmNPWG4vMmh0SkZheDF4WUxzQ1JYQUpPM2NySG1iSDgw?=
 =?utf-8?B?MjF1QmNqZUpXNWoveUl3bWdTZEg2WCtuS3B0cmFrUzhGYWo2ajc5N3dnRk1p?=
 =?utf-8?B?cXRvdjh4RCtXNlpoQlBIUjBiMWxiaFpQMysyb1FPaDZ5UmJraGRPa2ZLZC9O?=
 =?utf-8?B?d0gwbFRLUWorRi9BenRBUi9jc3FZTjNPQWJIYjVsWWk2V0JnMTdHeGxSWGZM?=
 =?utf-8?B?OFdFOUM3d2N1Q3F2ZGdqS0dIQXpSNG5KRXJkRzhmNFFjc2dOZ1dOblZoa0M5?=
 =?utf-8?B?bmxzckkxRFJyNG5tZ3I0azBkRGpIM1QrOGRzcnA1cnpwbEsrMDJheVdxS2kv?=
 =?utf-8?B?eTI4ejhVVEpibEtVYUJQeTZlMVpKNUJtWEtsa1dpbnlUTndWVHd5U2VYMmpl?=
 =?utf-8?B?L1RPUVdkV0MxOXRBbUhzTDBqeW1TR05KdTRjY0pBZThKT3pNQ1g4VEJyblR2?=
 =?utf-8?B?MjJVSElRcjB5V1MvUXlmekxwVHhRU0tOVStrN3FwdU1scFlHSXNrT3hIUkVi?=
 =?utf-8?Q?Ot4ejnBLfhNNLPxylkonjUwk1xmmn2t6KxkbKhOd1OiaA?=
x-ms-exchange-antispam-messagedata-1: PAo9i00a3zm+VM9oQ/tWvs6wzxl2Jc20c78=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6B37CB913783B408110C9AD12608551@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QDeO49975agGvaurl6F81uq7pDBkfXN+H+8AtLCVeCDU4NqFlpT7PJUZsGavDrbokcG+rMsDExo60gzofG3UvkRDipsm4yweOCz9xEswKkAK0oT8GKWyCtkpiH4+mx+4ZhC7GAQ1hLcVuGRBdsFUYldfUVu3Tzezef2aOuZgSyc7O6bclLAR4Fr+NNWNBl7y0CrxLbpB8LLsZ6H0P0RYvr1tivTFiDsYJrZBT9hJodoS3OzbI7dlGkJ+LKd9spq8/DeNGxCMYHv3MeANPgZ6fy77Wwg3yCS18parPLmzOdAEI7FniDi2ty50caMI8iQ84KQ9Kt0NpKhrlb0M2aP1pw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 83wBV6d/dBsVe5odlXQ8V76mLxvrLyfcuos/rROl+0/sE0c4EFNXAxqnUcAagYEWSQ9mFEoARSO15clu2sTWOLRYTPkRjeJqcGyNvw4bXNFaLK1B4fCcmGRscIKx90cg90K0dkp88PFtpET6PIdUFTR7f4UTME1DFurrz/neP76Bn8R/OxaC+7dDQ2bBXUlfiL+JaP8syDB4OnZiaasfMMhv5Ws2p/Nd5SBAHn8FTqqYHZhuyLLjnrUZD2t4zP8KTQHzFm9IYt1JNjpy4pIdskp/Rusc9JzUq0NqiQPuDckGnjPsyCa2xhu9N2QaPj0EpQyCxzisDrz4yAn9lO4FHDV3KRctDXcfWUjZ/oo2D8a0AcFczeeLOjMb6liew1fzDZI/6NwH1NV8pEQjIBgC2qVrUrJELX0UjAFMRcsFu7IVLG9wud/lhVxNQT1Ln7ZDOU8O1A/7BzEKmz4SVnYxZLi4ypcTGADm4CWgf5jRY7mUE3qv86mOWGXWTuXleH+t51uNYL9mQKXLyzxKajghHXZDZobl0BPUfvAm97kJXVQSHrH3MhOQbUMeUwJPejVCSHtsNb4xeepU+gzdaTRdOHntWeNr/feUn/PYNT+bRC6qIK5pf2u29Dj9LdVuS47q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82013f0-6aad-4915-397e-08df30a9dfc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 02:03:47.1612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIi+t9YGT2x84A83fkEUorD5Ryp3iG7mLEcl4KAokZSBXLU6FTXhTsRYhjYTy2Q8JDuQ7bSsDQW/iC/Ph1HzW67ZUnuAPQ+lBQGaRWZThUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7634
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=749f58b73=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDIxOjEwICswMTAwLCBQZXRlciBNYXlkZWxsIHdyb3RlOg0K
PiBJbiBwcm9wX21hcmNoaWRfc2V0KCkgd2Ugc2V0IG14bGVuIHRvIGVpdGhlciAzMiBvciA2NCwg
YW5kIHRoZW4NCj4gY2FsY3VsYXRlDQo+IMKgaW52YWxpZF92YWwgPSAxTEwgPDwgKG14bGVuIC0g
MSk7DQo+IA0KPiB3aGljaCBzaGlmdHMgdGhlIHNpZ25lZCB2YWx1ZSAxTEwgdXAgaW50byBpdHMg
c2lnbiBiaXQgd2hlbiBteGxlbiBpcw0KPiA2NCwgd2hpY2ggQ292ZXJpdHkgY29tcGxhaW5zIGFi
b3V0Lg0KPiANCj4gVGhpcyBpcyBub3QgVUIgZm9yIFFFTVUgYmVjYXVzZSB3ZSB1c2UgLWZ3cmFw
diwgYnV0IGl0IG1ha2VzIG1vcmUNCj4gc2Vuc2UgdG8gdXNlIGFuIGV4cGxpY2l0bHkgdW5zaWdu
ZWQgMVVMTCBoZXJlIHdoZW4gd2UgY2xlYXJseSB3YW50IHRvDQo+IGJlIHRyZWF0aW5nIGl0IGFz
IGFuIHVuc2lnbmVkIHZhbHVlIGFuZCB0aGUgJ2ludmFsaWRfdmFsJyB2YXJpYWJsZSBpcw0KPiBv
ZiB0eXBlIHVpbnQ2NF90Lg0KPiANCj4gUmVzb2x2ZXM6IENvdmVyaXR5IENJRCAxNTQ3NTUyDQo+
IEZpeGVzOiBkNmE0MjdlMmMwYjI0ICgidGFyZ2V0L3Jpc2N2L2NwdS5jOiByZXN0cmljdCAnbWFy
Y2hpZCcgdmFsdWUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFp
ci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2
L2NwdS5jIHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuYyBiL3RhcmdldC9y
aXNjdi9jcHUuYw0KPiBpbmRleCAwOGE0ZDE0ZWExZi4uZDQ3YTY5YmVhN2QgMTAwNjQ0DQo+IC0t
LSBhL3RhcmdldC9yaXNjdi9jcHUuYw0KPiArKysgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4gQEAg
LTIyOTgsNyArMjI5OCw3IEBAIHN0YXRpYyB2b2lkIHByb3BfbWFyY2hpZF9zZXQoT2JqZWN0ICpv
YmosDQo+IFZpc2l0b3IgKnYsIGNvbnN0IGNoYXIgKm5hbWUsDQo+IMKgwqDCoMKgwqDCoMKgwqAg
Z19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiAtwqDCoMKgIGlu
dmFsaWRfdmFsID0gMUxMIDw8IChteGxlbiAtIDEpOw0KPiArwqDCoMKgIGludmFsaWRfdmFsID0g
MVVMTCA8PCAobXhsZW4gLSAxKTsNCj4gwqANCj4gwqDCoMKgwqAgaWYgKHZhbHVlID09IGludmFs
aWRfdmFsKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAiVW5hYmxlIHRv
IHNldCBtYXJjaGlkIHdpdGggTVNCICgldSkgYml0DQo+IHNldCAiDQo=

