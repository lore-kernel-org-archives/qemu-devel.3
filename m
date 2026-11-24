Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FF606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Sws0f4+X;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=kKtOq2Mb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVgee-0000ky-ES; Mon, 23 Nov 2026 21:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=781b605ec=Alistair.Francis@wdc.com>)
 id 1xVgeV-0000kO-0k
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 21:53:05 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=781b605ec=Alistair.Francis@wdc.com>)
 id 1xVgeS-0006tk-7G
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 21:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795488780; x=1827024780;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7kUaodDKiFsoINwsOmVvln5KAZw3n6L6vnEY7uiRE18=;
 b=Sws0f4+X27SY5yfkak9n1H6eAieL6jtz47UUW9v8+RlMQleD/7BEdMgG
 jPNRkJO41IXdb0mc+XWIqtv8LQxGXMjS4/CoL+OV6qADcd7qBnqVJjceM
 7q0NPN2nG6qx8csZIkQL/nk6eisuS9ldSOed/lQSsUFWo6pL6ghiBp1+I
 UodKjiMWFKefrPjU1c3QXVScGsVPlrXx+QR8WRnnJ/qxkrMOBfmoG16pF
 6pmotUSw3uX9Zve7dugV1Y7O7J5WkjzC6XMgUwWaadNBcn78gk7PrtHR+
 ItJQv8eLLuzgtqtYVi/U/3f0f4NdZ9uK4TyD94Wh3a7sRNT4zOt26zuV+ w==;
X-CSE-ConnectionGUID: 9nozQJp9R+e/6+anvekwAA==
X-CSE-MsgGUID: cxFmMt8ETpqCLmcnZ5WkKg==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; d="scan'208";a="161609974"
Received: from mail-westusazon11010002.outbound.protection.outlook.com (HELO
 BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.2])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 24 Nov 2026 10:52:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1WUOsv+PBH/A+QckhCBXNna642IK+GHJWe5MYfzDZRZkAxbgADnHKRQlG1azcsss2A9OdCoY9MDZnbTm3iFAtxcCRzWFmJRPaKruK7nW/Gsli9kTQbj0jT7tTlW6KznPaOEZfyenvwwIDiQ+kRXXuLunznRNLqa6Rd2f1fnbVwNzC/0hl+6EzJ+lK3pUByoDYhfe1bF+JxlBXupw3baAXumjmgv6FOf95A5V+NMnAP4eEdH2W7vziq09pp7EUVdj5Rk3NnbjHL/jBZa05CKfx/FGxgCoH/g72M3y/1MjUZaHxPaj1vMe3XkZ6kIVxkcbBuVfyZ+NQa5xGyRP3NXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kUaodDKiFsoINwsOmVvln5KAZw3n6L6vnEY7uiRE18=;
 b=SIihEv80Cwqv4LmrEIklikSTD1SuiMP9p+Uuiiosq9J8d3Msf3A3FwCwuot04OJLcOKxHRggO+0KrBP3PkrxgLU5xWMUHf46sNM3GB8CuRC3Nar5SLyRa79gklmj2Hslx/lPqUPuBNA4k2NiN9T/G19daXCGfdohOFiRAEpCZweyOa3blGqWQYiM6xGcwAHRfD0Vl4Y0ALR9yZkPp3wyeCxo98es7hWsdyQZMFllJLJ5ON0dYIYRK0UXO8jPFQUage8Buks6Lmu18Qi0uBwpYPEz6w8gk83ONpuZlc3gSP4J5hmkxXrHf8SUdQ2kfPWoujmW8i8L9D2lQWdVEQMt/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kUaodDKiFsoINwsOmVvln5KAZw3n6L6vnEY7uiRE18=;
 b=kKtOq2MbSUGbk4p7HYyWs/UYF2p3jngAD2/Uqa3Joz6kiZdvbZv/zuY7UsRGOn5prLNTg/dPDeWdVNUcIrezBGs3A1UoWClDjCrjPyBuW0giBpSx9ZX72yhCwDrT//UlgzlDvdSR0mVbIT3fZnpEH4yG+5C9A/g6faMMQ1dgi10=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9478.namprd04.prod.outlook.com (2603:10b6:208:4ef::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 02:52:52 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 02:52:52 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "armbru@redhat.com"
 <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "balaton@eik.bme.hu" <balaton@eik.bme.hu>,
 "mst@redhat.com" <mst@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "imp@bsdimp.com" <imp@bsdimp.com>, "farosas@suse.de"
 <farosas@suse.de>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Thread-Topic: [PATCH 1/4] docs/devel: relax policy on AI-generated
 contributions
Thread-Index: AQHdULlaeC0y17ozrkOGjC9ruIHNorbonWOAgAG8rQCAQcvDeYAH572AgAfLtwCAAB/qVYAAMaiAgAADmgCAAK3kgA==
Date: Tue, 24 Nov 2026 02:52:52 +0000
Message-ID: <33923453a2b9ebbf336f210b15c0b54cf78d51a6.camel@wdc.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <ar_FXE5rzVqKcTc4@redhat.com> <87ik21vy11.fsf@pond.sub.org>
 <CABgObfagz=EvmYtNFBo2xyDdXNkFPK8k0-YGDs7aVS6xRKEJTw@mail.gmail.com>
 <awQisiKRYpQSTmVy@redhat.com> <87a4mzwuqp.fsf@pond.sub.org>
 <CABgObfaELn80BU_b9CjaTqiHx_tCj+8hSh+59FpUk33+osBvDQ@mail.gmail.com>
 <CAFEAcA-sKg9G5ghHgrmEPZe2=fpUpwnGa-F7tScgj0vHgKF+kQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-sKg9G5ghHgrmEPZe2=fpUpwnGa-F7tScgj0vHgKF+kQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9478:EE_
x-ms-office365-filtering-correlation-id: 2ce1e5f7-2795-46ed-da19-08df49d608b0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|10070799003|23010399003|19092799006|261028144727099003|38070700021|10067099003|4143699003|11063799006|261021121427099003|56012099006|261022105027099003|261021123027099003|261022075727099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|18002099003|22082099003|6133799003|4133799003;
x-microsoft-antispam-message-info: hDRncMPgZL8bHWzM0Mf+jgc8ir5VTzIJfrWcmONtfWS0+6bc25JJkUsJQaWioro7xVSSskOw3CJJqnIvloznlndI3z8HYPuGVP8u/bLLbyRRqWl7RizTGfo0PXNEZCxI/ocKBs//4K8SP7JGVqusP8KhsAgaKS6NA/PB12wrNYHcMTIk3hyesKMk0REWATImzmdh3EH6deyAS3zXzSlBv61EdvfIfPdX0pEdL90XItpkToYtn+i2PfDlH+LhuIKehDfmSQfVkBpuPgJOlUpetWFySdUKwid4wpOs2nnLcncUIHCgwSXDO8zkc1ns7IQgJ+p43R+YDX3lJXc0DuAnm2bsyYmlhIUTCjCbb0BRijxjWy3NRK797UnEF8y0A649LK/wj3VOqf5yP77st27ip26aPgfKUyKoG2fZavGviS3A30CizKXShM7ri0WzazVUJuk0cuSqHivkbMM39k2V9VGAdDP4Yk1TkNL8jOdnEi8QNxCcalwnMJ8pzJi9aswnBF7+SpLk7RoHqaSNYfCfShnmyz3fu55q0mKxwAVHSpetZ8aQlYyiYDj6iw+fhO7sG0y9K/JwML79VyUUFZQXtX8Xuoj4W5MJC4fbZs3s05UlodFvHrMWqWrxf87FZzj/0eStlQY/o//sAepSOqr14iV5ew3aj1DU+/nPaz1DdZY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(10070799003)(23010399003)(19092799006)(261028144727099003)(38070700021)(10067099003)(4143699003)(11063799006)(261021121427099003)(56012099006)(261022105027099003)(261021123027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(18002099003)(22082099003)(6133799003)(4133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnZqMXdVU3Zpb1ptK2prWHlUdk5Fd005VmpNVHlKZ2Y4ZW5IMEI0aHUwTEdL?=
 =?utf-8?B?cXMyN0VNa2duUVM4Q2c1U1NhNC9EUU5QODdHZTVab1dBWElqaGtnVWI5WTcv?=
 =?utf-8?B?aWtvOUdtVS9MQjZtZjRxSVZ5NjZ2VUJpa1Z3RzQ3V1NQYi9aRDZXeHE0L25q?=
 =?utf-8?B?dWFyRjYrWk1wbmEraDVBSlYxbGQzZWJQd0tQYzAzb0U2c2xjMEpWcGI2NTZG?=
 =?utf-8?B?bDRncWswT29icWxZMVJnV3dyN3B3b05FRHhmdGJyam9HTjIwaEMzQnluUWJ6?=
 =?utf-8?B?UXFYSU4zdENRSEc0V2VpUHgydVZwUWswcUczZDdhbk4wOE4rcHRLVFpyRWV5?=
 =?utf-8?B?R2grTGNRU3VLWm5jTnNLN0Y2SE5WSWlHc3JSQTlYWlhCaEZwNllRRGxYTzdu?=
 =?utf-8?B?dGxYdy82R3IwMDFPRzJ5NldWTFROVHRjRmhjWm1TanB0MEhLMTBpOFdXTmlq?=
 =?utf-8?B?VUJ1eGloTlRiTFQvVHpnSlczK3RHeW9FQXdJRVVsYm1LeHBUNFQ3UEppWndX?=
 =?utf-8?B?OHRGTm5vbUNjZXZzRmI1NWJhbWRDWFQ1V2ZLejltdmxJeHFCMy9JVTBqbmJG?=
 =?utf-8?B?azAvbkVxb0JaN21YSkhwU0Q2VmIwK0NBaGVyQllwZmdSOFEyVGtYSmU4WTZ5?=
 =?utf-8?B?MWRURGI2Qzk5UDhaNXRKTGJObEdNMG1PTm1BbXFEV21GUjYxb1hOalArTzdm?=
 =?utf-8?B?dTJNbEdENFR0TnN4N29iQUkvUkZkVkNBY3NQTUMxd0FwTmlxcUxualE5M1R6?=
 =?utf-8?B?eHd2Mjhld2hCeUJPenFLS1V4MTNEVld1K2pQc1p4cll5dFlUSkpOMldGV01R?=
 =?utf-8?B?SFM4bzJOL01PK3RoT24vQVZsRlFNdlQ2ZC9MNEIwWjJka2tnakVlT2xKYk1V?=
 =?utf-8?B?L3czaDA0b1BzSW5TV3NVR1k1b29qb0VhQ216Ny9hZjdoZUQra1UwS3E1NUhq?=
 =?utf-8?B?cG5mdE9wYVRWUG5NMm1OVGlVdEo2YWhzV242MlQ5UTUvQVJHQ0ZmNlRuQmRP?=
 =?utf-8?B?ZkZTYVU4SCtxOHZpQ0RURGF3dSs5T0o5NkRVck93MXZHbi9YT3N0WlBVck43?=
 =?utf-8?B?bWVxdEhrVDZ0Z0pVN3h0bDVXYXNVK0dUN2tKU2hLYmRXNUovaFlGWXAvanVK?=
 =?utf-8?B?NWt1TXBzQ2VOTGVYSkd6RzFpNDJoa01BckZkNkNZVDZWaFlKYXNCdWx1SXZr?=
 =?utf-8?B?U0U4UjV6ZEVRMUhJU2JrZ3Y5bjAwc3YrZk55aWlUS0hBK0N5YUFla3RyeUhG?=
 =?utf-8?B?MEl3U25aUnltc1dQVGwwWWc0ZytVc203TGpQS2c4YkU5dFQxcjJtWWkyUHg4?=
 =?utf-8?B?OStLL3RKMTRqT2VEU3p2WGl5d2NoM3RsZnp0TUJlaFJvemNaQzJDZFVnRDJW?=
 =?utf-8?B?MWNXanZKQW0wOTc5dTVOU3FoejdzZEZZdUx5aWI0d2RVVnVrb2xTamRyVENH?=
 =?utf-8?B?K1FhcjQ1d0NtZFVLWWFHSWNPS1NhVG12bW9SeFByUFZIVm4wWWcraFBoU1Zp?=
 =?utf-8?B?T3lOVkdROVE0b0Mwbkx1SExMM1RQZ2pzMEhDY1hzaEcyeGZRaE0yK2tiemlP?=
 =?utf-8?B?SjFYVGVVUFZBQk5aRW9laHlTMURtUml4TkhPVDkwMElQWWVnNGgyUkFGcXp0?=
 =?utf-8?B?RWIxTXcyUkIwYmlLUEN6d1pKRmwxWWZZTlFYMWVmOGwzd1lpMXZQdUpYZk1Z?=
 =?utf-8?B?cytLa09vN2dOanZvYnpwNGhKUGNDeEJab0xoWG1JYjA0eW1nVUlXZ21WaVlE?=
 =?utf-8?B?NDAvQ0ZoQTUrMXJmN3lKaElIdTNxT1dYTXN5ZXFCd0lPUkh6cjVXU1Q0K2J1?=
 =?utf-8?B?T2N1SlRtV1c4ODVsR1RoOXlWK09QSlZzNmZOUHk4K2UyWGRqekV2aHRMVGxP?=
 =?utf-8?B?c2l0MzQxSDl3WFYvbnRuSlpLcU52cEdXRHpDWnlxcUVCaDJsYURRaDlOUG9q?=
 =?utf-8?B?cGdUWks3K2JkUkxwem51ZGVjTWpBMmYxTHhzM3NmQmhjanBXbUJHaEEybmV3?=
 =?utf-8?B?K0pzOFYyNzFxb0YwT3pNU3FSNlRSYjlYdHVDM1dHeVBpQ1BSOEc0TGdwcDdJ?=
 =?utf-8?B?dDNWQ2Q1Nmh0S29xb3lsSjFhNkhsdGV6SnBic2hnU3lJaWpGelpaNUtiek9u?=
 =?utf-8?B?ZUY4NmlybE9PbUJZR1NZeTdYWlJubVZtN2dPaW9vTGpNLzFnTzlYTEJxRi9L?=
 =?utf-8?B?c1laNkwrbUlSVVU2czE2L0pZUU9jQ3N0WlBlQUl0T1o4WmJ3dG8zbHU3eXRI?=
 =?utf-8?B?VUtWMkQwbW5BaHh3WHo0RWl4RTZhaXd1YkhZZHpwdzJTQnZFUFNsZkFmY1lU?=
 =?utf-8?B?VFRvVk1RTExITkFnM0loWVUvRkdqaU5wSWJwTkdJOHIzSzV5OE11WVdSenZa?=
 =?utf-8?Q?OFadtkw8Y5T/ZHD6Sj0MMX5hUV2KCFSvvAC5mlWFWs6QP?=
x-ms-exchange-antispam-messagedata-1: 2SkqY5ZirAj53k4AhiBVFnnscuKZ9b9k7vw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6216AC7B8DFAFB4B937AE9D39683F5A7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SkxLw1gRwc3bZYS7DGUaqLDWgj3wUk5SiAuQZ520OhVws6KJLeqQL5POruboAi9SGiccIIIWx03T5cqBcniIVxyEv6A9mT2GnBhyiDgOWKTzBfdL9P2Jj2h8TsvhNPXziF7+BYlGfCjLp1528xJIKF4vteeE0qNg/Ow7pWIWpe0qjdN2zTzKJK0SDrMSDaFCELPh02+ZGKWNPrqyjRKnAnSIcywguyWR9FZfagK1Auaj1D73fqOK9JZVUickczuyv/g49CxdMqxot2hREno3325bebiQO03V1Y3JDMM8viKFQbPFY5wifH2v7boI66NA4maMU9wCvc1b9jUv+LQ2tQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7hXfzuSygD0NXYD/HKB553KE+xiDPfdPQf9oKUIwb8VXQKwsde3hH8kMnV7dGb4g90k2p12NK9nOBUCaqQ9xkuQAacZuInR0GOF8152ghS8ElJJY7kQceqT8+XXuH6NinedwSRzOpCO/7I/F+NQIkqU5AuXU2RQ08UtDdfqkYPOwb+SdQDxinge9Olo0ZhMthBXGXSPcremdFCFcv/W0szdT3Wh8a+gDR+hY8Nhk48zMBftP6c33jgaupZzrTI/4OyVFp4WxRY3fvha+oyiVJRWb1OAC2w8IN1eQwQPt2PrenJa9xnJOXwdjzitIiYE0rjckVvAsqyNAvEncNvDgdkjMz634hR/HeSvlJbCdNhPsZG29FlNBS/bljFAZ/YEth+DIDDlLcrT1X4EgPHN+cSgTOvb/YPreIoECD5WSMA0neqBPc6Tv1JxFhJHNZOqlqC0p9c2zvjqe1eSsS9TpuUXW/cZ5n8viE8IHaMTYiTZm/fDcBScqVEuyeetuG9mg8CQExY6YoxHmNGgl3J2peEMmrVQlxeMyFmksrSm/xhK5QMP7jr2znsaBVk9bgL5NxxqYvaJRXSxRxmcjZrwJjvSv/EktchqG6XdhpQumaU3ze8FYuxvcFjKgKFKdIFGJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce1e5f7-2795-46ed-da19-08df49d608b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 02:52:52.7114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Itb8/cX64kJShGDgFgPGsgsoWbbd+/2pieSBBTxHQwuk5YtY0Ppa7Com7XazwGOxSxQZqcYMiz/5wewxzTj/jrqAWN7rQbBhENMjBhU1HY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9478
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=781b605ec=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTExLTIzIGF0IDE2OjMwICswMDAwLCBQZXRlciBNYXlkZWxsIHdyb3RlOg0K
PiBPbiBNb24sIDIzIE5vdiAyMDI2IGF0IDE2OjE3LCBQYW9sbyBCb256aW5pIDxwYm9uemluaUBy
ZWRoYXQuY29tPg0KPiB3cm90ZToNCj4gPiBPbiB0aGUgb3RoZXIgaGFuZDogcGVvcGxlIGFyZSBh
bHJlYWR5IHJldmlld2luZyAqY2xlYXJseSogTExNLQ0KPiA+IHByb2R1Y2VkDQo+ID4gcGF0Y2gg
c2VyaWVzIChleGFtcGxlDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9D
QUJnT2JmYktLU29PMU5zeXlnWFVUNE8xYithUFowU1JOVUdVNTVwY1FwaFI1czgxYVFAbWFpbC5n
bWFpbC5jb20vVC8NCj4gPiApLg0KPiA+IERvZXNuJ3QgdGhhdCBwcm9kdWNlIHRoZSBzYW1lIGtp
bmQgb2YgcGVlciBwcmVzc3VyZSBvbiBjb3JlDQo+ID4gbWFpbnRhaW5lcnMsIGluIGZhY3QgZXZl
biBtb3JlIHNvIGJlY2F1c2UgdGhleSBhcmUgbm90IHdhcm5lZCBpbg0KPiA+IGFkdmFuY2U/DQo+
IA0KPiBJZiBwZW9wbGUgYXJlIGFscmVhZHkgcG9zdGluZyBMTE0tZ2VuZXJhdGVkIHNlcmllcyBk
ZXNwaXRlIHRoZQ0KPiBmYWN0IHRoZXkncmUgYWdhaW5zdCBvdXIgcG9saWN5LCB3aHkgd291bGQg
dGhleSBzdG9wIGRvaW5nIHRoYXQNCj4gYW5kIGluc3RlYWQgZm9sbG93IGEgbmV3IHBvbGljeSB0
aGF0IHNheXMgInlvdSBzaG91bGQgZ2V0IG91cg0KPiBhZ3JlZW1lbnQgaW4gYWR2YW5jZSIgPw0K
DQpJIHNlZSB5b3VyIHBvaW50IGhlcmUuIEkgYWxzbyBzZWUgdGhlIGlkZWEgdGhhdCBqdXN0IGJl
Y2F1c2UgcGVvcGxlIGFyZQ0KYnJlYWtpbmcgdGhlIGN1cnJlbnQgcnVsZXMgZG9lc24ndCBuZWNl
c3NhcmlseSBtZWFuIHdlIHNob3VsZCBjaGFuZ2UNCnRoZSBydWxlcywgbWF5YmUgaW5zdGVhZCBw
ZW9wbGUgc2hvdWxkbid0IGJyZWFrIHRoZW0uDQoNCk9uIHRoZSBvdGhlciBoYW5kIHRob3VnaCwg
b3Zlcmx5IG9uZXJvdXMvc3RyaWN0IHJ1bGVzIG1lYW5zIHRoZXJlIHdpbGwNCmJlIGxlc3MgY29t
cGxpYW5jZS4gSWYgdGhlIHJ1bGVzIGFyZSBtb3JlIGZsZXhpYmxlIHRoZW4gcGVvcGxlIGFyZSBt
b3JlDQpsaWtlbHkgdG8gZm9sbG93IHRoZW0uDQoNCkkgc3VzcGVjdCBwZW9wbGUgd2lsbCBiZSBt
b3JlIGxpa2VseSB0byBmbGFnIHRoZWlyIHdvcmsgYXMgTExNDQphc3Npc3RhbnRlZC9nZW5lcmF0
ZWQgaWYgdGhhdCBkb2Vzbid0IGZvcmJpZCB0aGVtIGZyb20gYmVpbmcgbWVyZ2VkLg0KVGhlIGN1
cnJlbnQgc3RyaWN0IGFwcHJvYWNoIHB1c2hlcyBwZW9wbGUgaW50byBzZWNyZWN5LCB3aGljaCBk
b2Vzbid0DQplbmQgdXAgYmVpbmcgZ29vZCBmb3IgYW55b25lLg0KDQpBbGlzdGFpcg0KDQo+IA0K
PiB0aGFua3MNCj4gLS0gUE1NDQo=

