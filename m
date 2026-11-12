Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACEF606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=ayatdnc9;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=LcfyKvUE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRMsk-000645-F9; Wed, 11 Nov 2026 23:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMsU-00062n-Dj; Wed, 11 Nov 2026 23:57:39 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMsS-0003Zl-7h; Wed, 11 Nov 2026 23:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794459456; x=1825995456;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tU27sYHtCUc0BNGruZuG1tspc75ZNZs4G+pCLo//OcU=;
 b=ayatdnc9sS8Mus7uK3bIuV5UR2S8kM0l/BfBb8dHLTjigYE66AOwQ0Zm
 QrJjw4Q7G+3YiqSNOscQ5YCe2QOrSNLGpSdvD8iLxkqENcjE/af33qIYu
 hseJaOE2dS4AAEOiAER9SG1wHFY/DbKp+e/kBikj4Q+joS2vULG5Uyqzb
 bATuzNVEW4ZHf0nTIIt3pQTjoE3LgH7L899NBnjUkX1muE7aNCFcBrxNs
 0zCO4T8DjYtK7I259Du2RRzGPur2WSJ8XNd88scCjZtep8AA6jv3px/sy
 /H/sNDWAMAN71TGfi4ERSKWG6RfkiyYR8yRRm7665oBgbcWanAwf3XD11 A==;
X-CSE-ConnectionGUID: ILN8pz1dSiqaKdhHAeSfXA==
X-CSE-MsgGUID: 3fU92WB6RXCAbHfRp1bHAw==
X-IronPort-AV: E=Sophos;i="6.27,209,1786982400"; d="scan'208";a="161675570"
Received: from mail-westcentralusazon11010012.outbound.protection.outlook.com
 (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.12])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 12:57:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvC0wbeVY6reyWEd+2FmPFA+VvpZ0d7efM2PkuC2brC4vLpJkmNXPJkDatPOc8fOOpRcP01b/eY5Gtj7HAEYVx7RMseAHEby6VNP2S1iwXhSV4QRXUHhhGYM62mJ1egXMvjnoKaFoO/XK5g1o3VW/3iwHYI4O1zON6NVRhEcRDFQ+U5SbPLwgie41pyd2MuAbzwtPO+p0OoNbtjQfJizqraVIOeUd9PVy16i12imVAUAj3VjPdf0uIZYhSCpu+aEQVGxu94lODK4uRT04BebnOpJ5WP5T4x9Iox6xEtyeF/LBvcX8/TQJ8y+7nKQrYNxhlsMiHKOLR80u+RO4p7VZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU27sYHtCUc0BNGruZuG1tspc75ZNZs4G+pCLo//OcU=;
 b=d+NQckdDzHYEjbWbTmC+LDWynzr81pUADUXjCWPTeGAuOy1uiphKXGldgGyaDv+7rBJteNR1pA4tV0e0+u56tcvM3pgUIHApp5Seu/vF3L8dT5wMWHzY6jfy3rxJCBHVvYjGzXkQnNZ1j9o7haUQw4JV44e61eVOcfw+IYGSLyrKC0E/4xpIVc8ceuOYVJ2XyfQkL9xit58xCQ5wJ3qdQ3sJe4LTdwgVGu5AlNhAnwFHtD0BlrjONSasqg+wXEYqy0Rjd4b313949N0WdnlE8PXcZXNU4Weph4iRX4XyCN0CZ64jHaieHkTCr6BwVsGggqKBSaYroNQ01B9OGlpyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU27sYHtCUc0BNGruZuG1tspc75ZNZs4G+pCLo//OcU=;
 b=LcfyKvUEq2LZIuo3686wvwQ77wLdwQ/z9WQ1+RQAS7JZeNuyaY7WR1mH527F2Sm/hF4XVoPQQ8271JYBZyxlZy/qP+WoUA/Gu50c2NDF65Jn3Tr9vaWU2J+Wd2RGv34LrapABZ30DT6CmkWVIbXTs5iUDf47qyx0Of6QjEmRtDo=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by CH0PR04MB7922.namprd04.prod.outlook.com (2603:10b6:610:ff::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 04:57:31 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 04:57:30 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: report WRS.NTO opcode in tval on illegal
 instruction
Thread-Topic: [PATCH v2] target/riscv: report WRS.NTO opcode in tval on
 illegal instruction
Thread-Index: AQHdbZ/g+veLZz3tmUa32TA5/Uf4q7cp6WOA
Date: Thu, 12 Nov 2026 04:57:29 +0000
Message-ID: <62f8a42f83734d5198f98f07c4985999bb1d0b69.camel@wdc.com>
References: <20261106033457.79020-1-fritchleybohrer@gmail.com>
In-Reply-To: <20261106033457.79020-1-fritchleybohrer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|CH0PR04MB7922:EE_
x-ms-office365-filtering-correlation-id: 153b296e-b0e6-486d-901f-08df4079748c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|23010399003|10070799003|1800799024|18002099003|22082099003|6133799003|3023799007|11063799006|261102123227099003|261026140227099003|56012099006|261028144727099003|261021121427099003|261022105027099003|261021123027099003|10067099003|261022075727099003|261009223027099003|261026121527099003|38070700021|260925021311599003|260925022911599003|260925021911599003;
x-microsoft-antispam-message-info: GpbdkN1/mHprHX7/oGcIFZy67l9Z681HYRolWByY1SR7AZW9lEd5dUPvVHEP/gh3mzmsclGN58woEiKGYfnm2k2zzGb8VbNNlGBeJ+nk4PUd9nWdzM3N41b8dbq5xzzAzib4C98pg+zAPCHOKuvdoZKt6j+5pCQlgOffpBKWrUaVnWdnNMc6P2QFulhZzVxCsmo/dAE1Ill4T1w/Ri89qtHe3RDIg2BCWDxhivrQ2VXZ35CDQFBba2W2g1H9PTA7dGuzpua+yADeWrXurDSr0R583HDWApzXNLROS88jKHCY+all/eRI588vtFzYFlTJ41OHGJrQygVpasPkjfmXciLKKZtCyWyV+aLRJum7MMxf1JyYXveVJLh0FIwwGu8MZKdk5xRHbZbU1L0CCKKS7ol56cKaKB5g/o5dyel/Du4HthowANRpmUpuAeno/rum6cdEAZ8WbvfyO91zwVYCbRoZQDft5FZ12oPIqTfHnm8I8PUauDDnNb06cmKvj/PbdrcuLyyTLNhJCPJ904vzQLzwlLtP7OQjMRkW2BUxSjm/YaDEwG+Ik5/d1Q5uzC0OJsewQSyugdeen8Ns8/fl0ez57LQSpP97Ex4nGYZQUKEtK0qmqCeASUqhMMQ7OpEy/WE3sRa59JfreS8tmjlcPRxJvtANtnNkRJ9dVewgy9dRHdyYHXttpsMkvMs97I6ffSv/Ql92fEpIy0+Ld7BWV5WZJtLmENhZI6j3EKZl2rs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(23010399003)(10070799003)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(261102123227099003)(261026140227099003)(56012099006)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003)(261022075727099003)(261009223027099003)(261026121527099003)(38070700021)(260925021311599003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzJpVTA3QjdBSWRBWWtXRnhjM3ZFTDZ4a3Aza2FJMWN2bTRJc1IrZXhZQkJh?=
 =?utf-8?B?eGdiVDV3cDkxbWl1QjdvNWtWMURXRHk2Und3aGErVUNaTEhrQUowUkJZZmp3?=
 =?utf-8?B?QU9BQmFUWC92ZFo2RVg4b2NZYlJJQXgzZ0JqcWdLTjdQajZmN21LdzlRNjBa?=
 =?utf-8?B?cXRWTkNmeTNoL2IyTExaTXFiY1d2cmJicDFNeWdkQjVjNzI3NFd1SGxKcUYx?=
 =?utf-8?B?VGZWZjVsNks3QmEzY0VsSjhuV1ErdzNqU081Tm4rV0piMEs0RDJwTU5jS3Na?=
 =?utf-8?B?Sm5hUVFmaGNSWlpFZUc3aVhKYTUybUhiQWlTMzlQcTVZWHJGUndxRFcvK1c1?=
 =?utf-8?B?cmYzSUlDZU5teUVTTk4rSU5oVy9HcnJSajNwQVMzQlJ6UXQ0OEd6b0h3N0dC?=
 =?utf-8?B?MnBYeWRLYS9jMUZ5VG45bTZBNUpKNXl6b1ZZU255RWU0N3ZQRTZrM1hCN2Fy?=
 =?utf-8?B?c3VURU1iZmY3WDlnVkRTZW9VYjR3ZHA3eWhVSU1aT3Bac25WZEpqdkt2QTBV?=
 =?utf-8?B?YXBpNjByVW9Pa2o5TitEWmduSTlDQm1wUU9ydEpkLy84M0Rma3FJK3pPSysr?=
 =?utf-8?B?QUIvUFNkZnV6L3owU3hzMlJCcVNldzR3N0IxcFYva1ZqSnZpUTdRYnhlS1Uy?=
 =?utf-8?B?TjlkYW1ueXNLZ1NMYjRObWROY3hyRHl0NW5rZ3ZBY1IzUCtTT2p3c0trUGdk?=
 =?utf-8?B?WVZrMEszaFF0M0haTHF1dTV1M0c5cTY3U05QVDVURUdnenkvbVhGTXJaTlVn?=
 =?utf-8?B?T2pxbTQrZmtxS1EzcWxya1FvNTZqY2hLaGhjS0IzbXZRaDZ3YWRBeWxqNE5C?=
 =?utf-8?B?eWowTzNCUURUaU8xODl4K2pQeDFFQmJGdEt4ckI1dHJwdlltRWFLWWo4RkdM?=
 =?utf-8?B?OFFCalRNbVBFZm5DOHlUMkdlVWYxVGJwQUVLcFI5aXdFTmJVOUxYM3lva1hN?=
 =?utf-8?B?UFQ3Qkl6Z0Rucko0eENPZm5zelFXQ1dzUlExYURzV0pvTHluWUVqekJ6WXJ4?=
 =?utf-8?B?aXB2NjkyTHJFRHc1OVdnR3NkR0ZSeHBxZytrTk5lT2h4dG43Wm1ndkZaR0Nr?=
 =?utf-8?B?U2l6ZnpEcmpiN0JDTmw2MGZoN2UyRE5hWk13WTE2S25hNmJ2dnpyK2kzMU5w?=
 =?utf-8?B?NWZxZnJzcmVBeHNMY2JJY1d0Y3BhbHZEK2NEbnVBRFNacnBnWU14S0tTeHRB?=
 =?utf-8?B?K1BkWnlhM3RmeUVxODIxL2dlT3Nicm45aThmOFFrYll2WU91TzVEUkQxaUpp?=
 =?utf-8?B?aHBKYmppNnNBYitnc016ZlN6NWxjMVUxUU8rM3gvaG1WQnNpWWU3VkNtYk04?=
 =?utf-8?B?VXJsL1pReld4OHM4K3gvcHNKTGIxMXZjM0JZUjJyY2trN21nckNVaVg5QjVH?=
 =?utf-8?B?TjlZY1JHaG1yR1MrNXFHS3FSVlhBY0d0eStXblRJYjNmMGN0dnlGUVZGdTBZ?=
 =?utf-8?B?b2tQV3NHcU9Xem9PNktTaWQvazZvcUxNMExuMEpTNGgvSGdud05qbStHM3RX?=
 =?utf-8?B?QjR0MHBGNjVyblFBc2creXVCTkxlcjNKQTVPdTd1MzY3SlVuUllJWGtZNVZ3?=
 =?utf-8?B?WHlYRWxDNkc2NFB3WFFNUDBnejl1eXVZSXR1WHVwYU9TN2gwTG9GT29VS3RN?=
 =?utf-8?B?T21QdTRDSHoxaXdzUWlqV3pvZ1NmU2JTZEZUOHNLRXN6Skh4UmRmVDM5d0ls?=
 =?utf-8?B?Szh1Q3o4ZHg5eUMzWnJobGVFQzUrTC9HUndDUlpBWHdoNmRFK3RFS0NjSFpi?=
 =?utf-8?B?ZU0yUEpXdEFqSkxOZFo0UStyeFJsTFNWNGdkbFFOelVHSUZReEhrNFI2cHV2?=
 =?utf-8?B?MkhicVh5eGppbHFoVnkwWXVQVVRZQkVIcUtrV1cvZmdiRkhxOTFHaGxYWFlF?=
 =?utf-8?B?UVNQblBkajBOZm4reW4wYldNZHI4V3lPOEhTZzdlb0p1MGxleVh3dUhmcUEy?=
 =?utf-8?B?QkRqR3NhSi8wWGRLUTc4K0N5Mkw2dWt4MjRGdU8xOHJMVnNXa1QyRkdOZU9l?=
 =?utf-8?B?ZFBDVkFIcjR0L3lEdHpTVXlQT29ZTWVoUkxVM213NnR2V2pQZ2FOT1YzQlEw?=
 =?utf-8?B?bnJOSzV5VXRoQkZBd05lWEkrdHZLWHU3TXlqeHJLVFB4bGRRZ250VUkvcGZG?=
 =?utf-8?B?NXAzcXBsR0FGSGRlOEJ1cEUrR1lJcTVLWklXSi84alBSZXEza1RuS25SOUZO?=
 =?utf-8?B?Y0taS3VTWGVxYW1wRnkrTUtPTElWRGZCOWM1U0dGZHNpU0p5cUVlNWNBbmx5?=
 =?utf-8?B?bm1Ba0xRVU50ZVFWT3AzblpEZldBcWFLSlRZMWFmTVBobFg1cDRXalBYb1VY?=
 =?utf-8?B?YU9CVlJDVHgySGRpYncrOEY0bDI3SE5qeG5oV2lSekp4bjRDR04vanJhckV5?=
 =?utf-8?Q?a2bG4Ij+0WTuYzoVPkbuAw9JtgMRwoYWYIQ4UjuIwd3ce?=
x-ms-exchange-antispam-messagedata-1: hUvP6qKPkIXEZcdY+OAbBJxEbOF02OGV6qE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <698AB8B7D0B08B4292BC5D59484E9345@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S6BknZGoPCo8EG+Q5hkanT0PhsSK/qSilWtKxFY5xMDIt/BKN+ju1f3RRA/Mj+KRYeZZAVRQ8bY+jXEatLWJCmqjRu09GlLl56iy7JA5kxfEYiJzfypoLtGS/3kvNwhGGx6/p87JQiIRlEy7RgDwDQBSPtzoMw7Yfy+GoYoNDdnVM+ooJ6b6NUI7YMybHMBd+DP7W9ZAkHTq1jol/5+eSl/FOAqqTGEC+MVvGj0wCfvpYfz96fH292NEKgkvllI7YJoCxMX/ggKNdJvfQ1HUal6LUPtaTM1sHYhH+bmm184hLBOdvTwJwo6KUINT9rOD8CutLpb/10fgUDqlM1dWfg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9yI7ca0hCYti+j7y1eTwTAriG4hmX1NFU7W2oRA4+XF7KGVc0MVpssPOzKjCFzKLWy2YLu0Tp3A+aeXXODfsPn4zWITa06y3KUb/Mtwm19dHdEDynBrSK6WII+YcGY9+7PuQZyz9oh3RA8Mvz9np/2n7l1YTd6SlAjqszk/QNxsTbGCrD0t1RlG2fmH9RzU6pXCK/BDH6++XomEmmKZ8dNl7KNDMXYHf3H+8iE4MEG1xKPTbgVHhV2K3RB74QrDGp+9MRuvBGUtfnbQTzDTbZxawXIGPs2IQNwI2Rhd7IxYDuIJGV7oj8E5CT69okV50YBwGMe4XQ4s9r2cQtqUmc5GHRTnHL1uW+W4yTu9Iv98Mf+T1bD4XdNweT/i64K3Ix3Rl+X6GiE4AXJmwWHwNq1wZSpHBZKTq3in2DuaTndA3a79P/PadcFCBuFQOV9dHJ5AGs2zXtxqmKcQ2ZPCv11PcDeJOl/ir+3Lr3CzrfS11NXuQv81rCEZnLXQ68tmCEkn/EHeNTU0lhUvwd/NJi/2/0YCGBR+APimKZZVhOJ99/8dUOHA8NfHx0IHMEMjGJ0LIBwbI09Mm9bey4o1doCcAecBqPv50pVIhg3Chu7kjoglQQx6unOGfmrETImYJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153b296e-b0e6-486d-901f-08df4079748c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 04:57:30.0095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqAFuwr8BUIJWhLIzSQ3WkW1ukIQvjYxbzkBqO1H+JYV/M4FwnHnPffHmTPb6D2zhFrPhIa/kkIwDxaBc0T/cO+6UkQ64tX3Gi3r7puk0Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7922
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=769f446c1=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTExLTA2IGF0IDExOjM0ICswODAwLCBaZXBoeXIgTGkgd3JvdGU6DQo+IGhl
bHBlcl93cnNfbnRvKCkgbWF5IHJhaXNlIGFuIGlsbGVnYWwgb3IgdmlydHVhbC1pbnN0cnVjdGlv
bg0KPiBleGNlcHRpb24uDQo+IEhvd2V2ZXIsIHRyYW5zX3dyc19udG8oKSBkb2VzIG5vdCBzYXZl
IHRoZSBkZWNvZGVkIG9wY29kZSBiZWZvcmUNCj4gY2FsbGluZw0KPiB0aGUgaGVscGVyLiBBcyBh
IHJlc3VsdCwgZXhjZXB0aW9uIHVud2luZGluZyBsZWF2ZXMgZW52LT5iaW5zIHN0YWxlDQo+IGFu
ZA0KPiB0cmFwIGhhbmRsaW5nIHJlcG9ydHMgYW4gaW5jb3JyZWN0IHZhbHVlIGluIHR2YWwuDQo+
IA0KPiBDYWxsIGRlY29kZV9zYXZlX29wYygpIGJlZm9yZSB0aGUgaGVscGVyIHNvIHRoZSBmYXVs
dGluZyBpbnN0cnVjdGlvbg0KPiBlbmNvZGluZyBpcyByZXN0b3JlZCBmb3IgdHJhcCBoYW5kbGlu
Zy4NCj4gDQo+IEFkZCBhIFRDRyB0ZXN0IHRoYXQgZGVsZWdhdGVzIHRoZSBtc3RhdHVzLlRXLXRy
aWdnZXJlZCBpbGxlZ2FsLQ0KPiBpbnN0cnVjdGlvbg0KPiBleGNlcHRpb24gdG8gUy1tb2RlIGFu
ZCBjaGVja3Mgc2NhdXNlLCBzZXBjIGFuZCBzdHZhbC4NCj4gDQo+IEZpeGVzOiBiNjJlMGNlNzYw
OTggKCJ0YXJnZXQvcmlzY3Y6IFJhaXNlIGV4Y2VwdGlvbnMgb24gd3JzLm50byIpDQo+IFJlc29s
dmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzQw
ODANCj4gU2lnbmVkLW9mZi1ieTogWmVwaHlyIExpIDxmcml0Y2hsZXlib2hyZXJAZ21haWwuY29t
Pg0KDQpUaGFua3MhDQoNCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4dA0KDQpBbGlzdGFp
cg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFJlYmFzZSBvbnRvIGN1cnJlbnQgbWFz
dGVyLg0KPiAtIFJlZ2lzdGVyIHRoZSB0ZXN0IGluIHRlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9t
ZXNvbi5idWlsZCBpbnN0ZWFkDQo+IMKgIG9mIHRoZSByZW1vdmVkIE1ha2VmaWxlLnNvZnRtbXUt
dGFyZ2V0Lg0KPiANCj4gwqAuLi4vcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ6YXdycy5j
LmluY8KgIHzCoCAyICsNCj4gwqB0ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGTC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtemF3
cnMtc3R2YWwuU8KgwqDCoMKgwqDCoMKgwqDCoCB8IDg3DQo+ICsrKysrKysrKysrKysrKysrKysN
Cj4gwqAzIGZpbGVzIGNoYW5nZWQsIDkwIGluc2VydGlvbnMoKykNCj4gwqBjcmVhdGUgbW9kZSAx
MDA2NDQgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC16YXdycy1zdHZhbC5TDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2emF3cnMuYy5pbmMNCj4g
Yi90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ6YXdycy5jLmluYw0KPiBpbmRl
eCAwZWVmMDMzODM4Li5lY2ViZWMwZWVmIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNn
L2luc25fdHJhbnMvdHJhbnNfcnZ6YXdycy5jLmluYw0KPiArKysgYi90YXJnZXQvcmlzY3YvdGNn
L2luc25fdHJhbnMvdHJhbnNfcnZ6YXdycy5jLmluYw0KPiBAQCAtNTQsNiArNTQsOCBAQCBzdGF0
aWMgYm9vbCB0cmFuc193cnNfbnRvKERpc2FzQ29udGV4dCAqY3R4LA0KPiBhcmdfd3JzX250byAq
YSkNCj4gwqDCoMKgwqDCoCAqIGV4Y2VwdGlvbiwgYXMgaGFuZGxlZCBieSB0aGUgd3JzLm50byBo
ZWxwZXIuDQo+IMKgwqDCoMKgwqAgKi8NCj4gwqAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4g
K8KgwqDCoCAvKiBTYXZlIHRoZSBvcGNvZGUgaW4gY2FzZSB0aGUgaGVscGVyIHJhaXNlcyBhbiBl
eGNlcHRpb24uICovDQo+ICvCoMKgwqAgZGVjb2RlX3NhdmVfb3BjKGN0eCwgMCk7DQo+IMKgwqDC
oMKgIGdlbl9oZWxwZXJfd3JzX250byh0Y2dfZW52KTsNCj4gwqAjZW5kaWYNCj4gwqANCj4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5idWlsZA0KPiBiL3Rlc3Rz
L3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5idWlsZA0KPiBpbmRleCAzYzhiMDE4ZDllLi5kMWNi
ZDFiOTdkIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVp
bGQNCj4gKysrIGIvdGVzdHMvdGNnL3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IEBAIC0y
MSw2ICsyMSw3IEBAIHRlc3RzICs9IHsNCj4gwqDCoCAnaW50ZXJydXB0ZWRtZW1vcnkuUyc6IHNl
dHVwICsgeydwbHVnaW5fdGVzdCc6IHsncGx1Z2luJzoNCj4gJ2Rpc2NvbnMnfX0sDQo+IMKgwqAg
J2lzc3VlMTA2MC5TJzogc2V0dXAsDQo+IMKgwqAgJ3Rlc3QtbWVwYy1tYXNraW5nLlMnOiBzZXR1
cCwNCj4gK8KgICd0ZXN0LXphd3JzLXN0dmFsLlMnOiBzZXR1cCArIHsncWVtdV9hcmdzJzogWyct
Y3B1JywgJ21heCcsDQo+IHFlbXVfYXJnc119LA0KPiDCoMKgICd0ZXN0LWNyYzMyLlMnOiBzZXR1
cCArIHsncWVtdV9hcmdzJzogWyctY3B1JywgJ3J2NjQseGxyYnI9dHJ1ZScsDQo+IHFlbXVfYXJn
c119LA0KPiDCoMKgICd0ZXN0LW1pbnN0cmV0LWVjYWxsLlMnOiBzZXR1cCArIHsncWVtdV9hcmdz
JzogWyctaWNvdW50JywNCj4gJ3NoaWZ0PTEnLCBxZW11X2FyZ3NdfSwNCj4gwqDCoCAndGVzdC1t
aW5zdHJldC13ZmkuUyc6IHNldHVwICsgeydxZW11X2FyZ3MnOiBbJy1pY291bnQnLA0KPiAnc2hp
ZnQ9MScsIHFlbXVfYXJnc119LA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL3Jpc2N2NjQvdGVz
dC16YXdycy1zdHZhbC5TDQo+IGIvdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC16YXdycy1zdHZhbC5T
DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAuLjQyYTk5MDFmYTYN
Cj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXphd3JzLXN0
dmFsLlMNCj4gQEAgLTAsMCArMSw4NyBAQA0KPiArLyoNCj4gKyAqIFRlc3QgdGhhdCBXUlMuTlRP
IHdyaXRlcyB0aGUgaW5zdHJ1Y3Rpb24gZW5jb2RpbmcgdG8gc3R2YWwgd2hlbg0KPiArICogbXN0
YXR1cy5UVyBjYXVzZXMgYW4gaWxsZWdhbC1pbnN0cnVjdGlvbiBleGNlcHRpb24gaW4gUy1tb2Rl
Lg0KPiArICoNCj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVy
DQo+ICsgKi8NCj4gKw0KPiArCS5vcHRpb24Jbm9ydmMNCj4gKw0KPiArCS50ZXh0DQo+ICsJLmds
b2JhbAlfc3RhcnQNCj4gK19zdGFydDoNCj4gKwkvKiBVbmV4cGVjdGVkIHRyYXBzIHRvIE0tbW9k
ZSBmYWlsIHRoZSB0ZXN0LiAqLw0KPiArCWxsYQl0MCwgbWFjaGluZV90cmFwDQo+ICsJY3Nydwlt
dHZlYywgdDANCj4gKw0KPiArCS8qIERlbGVnYXRlIGlsbGVnYWwtaW5zdHJ1Y3Rpb24gZXhjZXB0
aW9ucyB0byBTLW1vZGUuICovDQo+ICsJbGkJdDAsIDEgPDwgMg0KPiArCWNzcnMJbWVkZWxlZywg
dDANCj4gKw0KPiArCWxsYQl0MCwgc3VwZXJ2aXNvcl90cmFwDQo+ICsJY3NydwlzdHZlYywgdDAN
Cj4gKw0KPiArCS8qIEdpdmUgUy1tb2RlIHJlYWQsIHdyaXRlIGFuZCBleGVjdXRlIGFjY2VzcyB0
byBhbGwgbWVtb3J5Lg0KPiAqLw0KPiArCWxpCXQwLCAtMQ0KPiArCWNzcncJcG1wYWRkcjAsIHQw
DQo+ICsJbGkJdDAsIDB4Zg0KPiArCWNzcncJcG1wY2ZnMCwgdDANCj4gKw0KPiArCS8qIFNldCBt
c3RhdHVzLlRXIGFuZCBzZWxlY3QgUy1tb2RlIGZvciBtcmV0LiAqLw0KPiArCWxpCXQwLCAzIDw8
IDExDQo+ICsJY3NyYwltc3RhdHVzLCB0MA0KPiArCWxpCXQwLCAoMSA8PCAyMSkgfCAoMSA8PCAx
MSkNCj4gKwljc3JzCW1zdGF0dXMsIHQwDQo+ICsNCj4gKwlsbGEJdDAsIHN1cGVydmlzb3Jfc3Rh
cnQNCj4gKwljc3J3CW1lcGMsIHQwDQo+ICsJbXJldA0KPiArDQo+ICtzdXBlcnZpc29yX3N0YXJ0
Og0KPiArCS8qIFdSUy5OVE8gbXVzdCB0cmFwIGJlY2F1c2UgbXN0YXR1cy5UVyBpcyBzZXQuICov
DQo+ICsJbGkJYTAsIDENCj4gK3dyc19udG86DQo+ICsJLndvcmQJMHgwMGQwMDA3Mw0KPiArCWoJ
X2V4aXQNCj4gKw0KPiArbWFjaGluZV90cmFwOg0KPiArCWxpCWEwLCAyDQo+ICsJaglfZXhpdA0K
PiArDQo+ICtzdXBlcnZpc29yX3RyYXA6DQo+ICsJbGkJYTAsIDMNCj4gKw0KPiArCWNzcnIJdDAs
IHNjYXVzZQ0KPiArCWxpCXQxLCAyDQo+ICsJYm5lCXQwLCB0MSwgX2V4aXQNCj4gKw0KPiArCWNz
cnIJdDAsIHNlcGMNCj4gKwlsbGEJdDEsIHdyc19udG8NCj4gKwlibmUJdDAsIHQxLCBfZXhpdA0K
PiArDQo+ICsJY3Nycgl0MSwgc3R2YWwNCj4gKwlsd3UJdDIsIDAodDApDQo+ICsJYm5lCXQxLCB0
MiwgX2V4aXQNCj4gKwlsaQl0MiwgMHgwMGQwMDA3Mw0KPiArCWJuZQl0MSwgdDIsIF9leGl0DQo+
ICsNCj4gKwlsaQlhMCwgMA0KPiArDQo+ICtfZXhpdDoNCj4gKwlsbGEJYTEsIHNlbWlhcmdzDQo+
ICsJbGkJdDAsIDB4MjAwMjYJLyogQURQX1N0b3BwZWRfQXBwbGljYXRpb25FeGl0ICovDQo+ICsJ
c2QJdDAsIDAoYTEpDQo+ICsJc2QJYTAsIDgoYTEpDQo+ICsJbGkJYTAsIDB4MjAJLyogVEFSR0VU
X1NZU19FWElUX0VYVEVOREVEICovDQo+ICsNCj4gKwkvKiBTZW1paG9zdGluZyBjYWxsIHNlcXVl
bmNlLiAqLw0KPiArCS5iYWxpZ24JMTYNCj4gKwlzbGxpCXplcm8sIHplcm8sIDB4MWYNCj4gKwll
YnJlYWsNCj4gKwlzcmFpCXplcm8sIHplcm8sIDB4Nw0KPiArCWoJLg0KPiArDQo+ICsJLmRhdGEN
Cj4gKwkuYmFsaWduCTE2DQo+ICtzZW1pYXJnczoNCj4gKwkuc3BhY2UJMTYNCg==

