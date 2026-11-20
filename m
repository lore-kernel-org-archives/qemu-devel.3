Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39580606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Z/yHgWW0;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=e2WXe3e9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUCmb-0007ck-LN; Thu, 19 Nov 2026 19:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7773dcc14=Alistair.Francis@wdc.com>)
 id 1xUCmW-0007cV-Nt; Thu, 19 Nov 2026 19:47:13 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7773dcc14=Alistair.Francis@wdc.com>)
 id 1xUCmT-00062n-K4; Thu, 19 Nov 2026 19:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795135628; x=1826671628;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=oSAbFX4dFJj+WKsbtEOY/Jv9W+mELfbuO8IsfLANrLQ=;
 b=Z/yHgWW04fOMqEvVY4gezUU3cpeIrpMstWYkEW7xJucW6EMiCZjjjOYI
 i8PQQTkCJEEiAEjIVv2fbXjFtOp0eia/E8x//G/QKxGyxWWCqBXOzcRhZ
 wkai5B5PHGxorAfBD5SLT4kB1guD39MjzYgBup566MJthls7XksFJM5g+
 t7wcuw6akMNFfusmRam3sl4JaidOpfWG74civ5N/SMrVRDKsR5vCHT9/a
 71kEiYhsN1X70VqNYsev8C2r2XmCGfSAhcetBeyhAIM1Xtfu8bQHJdN6W
 RXtGrJNrDIb03LOaGGIdbF7oPUyrLheWcGLmJFYn60BbqbZ8rXeL6+5+W w==;
X-CSE-ConnectionGUID: 7W5TkupTQpmGyDzpsPVJlQ==
X-CSE-MsgGUID: HHMnZfrkSOeJRNdJVFC+DA==
X-IronPort-AV: E=Sophos;i="6.27,221,1786982400"; d="scan'208";a="157083417"
Received: from mail-westus2azon11012071.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.71])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Nov 2026 08:47:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyvztYqV0TYG4jPjpS7PMx7sOexRNJE8VQgzzIJx86SHTRAA3KGOwFw2RAfbbV729+lptPtLlex2gNs9gCLJIFP2GKjCnVtp+F/5Z5RCYutX4+QMnP+L5iKanI81DViR4a5TRxZGIwr0smB9Lh9UojLG8pFl9NwUp0+k7KvdnPqpvP//lVAIjMziwInksnCnaVpCl2y6HO/HYxFSv34XCm+J/6XwWIJ3d524jrb3meWOP+WZKhrWLwgutC7wz6opvNaWbVbDzYYGyLQ6ngwBzh8hhAaT6Z+nSqFdUHyRBP1Qx9lD2bMmYFXS0oZRZl+gjDxFA3dsD8GCrmIJRKjVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSAbFX4dFJj+WKsbtEOY/Jv9W+mELfbuO8IsfLANrLQ=;
 b=VMeh6YolBCbcX8pg8CMiOxxNmH8y3zR0CUyy8rpOqHwGTcF8Al6XgFNJ/yPhjBMxct1XKBvzfVOdHMah4vIDOGm4L6YLztDkaESbJmPdXZPv7s+Ksw16Z+3pOyXScV1ln4bv4m0XBP99Xg38Hg6tjUhdpxlKj74vdpRzT1eL0wkQCuCqrfPYE3FMj6laAQ0Je9xzZdf+1H4WHCKUFNe5aUOmQYnnVzHD4MU+JVwkrJLu7nqtxcXcAXp80Wb1D7LbWsYT5fAus4d92fi4svNYCepxhagxQb8AjvkwlAZcIknCXiDWQ3rlze83hHY6ll2YG30vdXW1+BSeVgb+y0Yy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSAbFX4dFJj+WKsbtEOY/Jv9W+mELfbuO8IsfLANrLQ=;
 b=e2WXe3e9KKpAw6EvedAO40+3zNGxR1nYCnWd+r+xUhcyq1QgQVijIIcrdPGprri4iYkv9nDKvIz1LIGKOmiV75OmVnz4U3OTqbSmnH2N0cLsZI/7Lux71aMJhPcf7iXy8d9hQXXxTwX1lyyo04McH+ediA4TMCVfcKdCl98+Yn4=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ0PR04MB7453.namprd04.prod.outlook.com (2603:10b6:a03:290::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 00:47:04 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 00:47:03 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "heinrich.schuchardt@canonical.com" <heinrich.schuchardt@canonical.com>
CC: "mail@butz.st" <mail@butz.st>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "qingwei.hu@bytedance.com" <qingwei.hu@bytedance.com>
Subject: Re: [PATCH 1/1] target/riscv/kvm: aia mode is an uint32_t
Thread-Topic: [PATCH 1/1] target/riscv/kvm: aia mode is an uint32_t
Thread-Index: AQHdddGKvac0S0hXhEyHiKTyzAcoSrc2JawA
Date: Fri, 20 Nov 2026 00:47:03 +0000
Message-ID: <a16d45f527336977f949759d53d378c21340aecb.camel@wdc.com>
References: <20261116135102.32508-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261116135102.32508-1-heinrich.schuchardt@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SJ0PR04MB7453:EE_
x-ms-office365-filtering-correlation-id: 075b2704-a531-48d1-9059-08df469fcb89
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|376014|7416014|1800799024|366016|18002099003|22082099003|261009223027099003|261021123027099003|11063799006|56012099006|261026140227099003|261102123227099003|261028144727099003|261021121427099003|38070700021|261022105027099003|10067099003|261026121527099003;
x-microsoft-antispam-message-info: egnO4+LWMlfr6RcCM9uB5KEexrugpZ53SLLt0FB99PGIbTUc3D1/dZLhGJlAUTWkvmo86YoN4JfP5Gi+2AXuQHqWWCm6Yk3+cdXyWj7X/j+5DDUUIatus8P4H893rOdX/V0lVlujHwddktRaxSn1M697xHU/NNBCtS5bwT03QZmPaM2eEWfgmGuDk6Ji5/CcND/u18sjNsPCYBWLdw2l3ciM2hqpWajUEffxNH8lB5+OtuLD3pJ4gGJ8pE4oVqBBK4/E/ISHjU4f6JO/1TFc+6m7xolWRMmXqfu3qkhTgaBZzWC/SErEsM82vRjLLb5H2sTFO8DAq4hZJNmkF77RX6g1Cxt/tJ7SK+uGHfrK7XsFmgEwhJUpgEZZUTIxDoq3fTvIG+Cb7Y1xgyW589itvAjlZzAO3FF50E0Qm3I09Y6J1K77u7WNo5R9jPgwJTxvRlocUH4mLrMMoyJT7CHmIceX/8hMp5JApgLQmBcmSOjcpPorstZdshD8etKZbJ8eOuRzKm84oPk4tdMkJN7Q0B3KlwSgK5jUdZH9CsdW9WjR2o68mheVTGmHmlXFK9a8TWeHCCgLLXBZrSP4wyNjXyf5ux4x6rJB67td/77+SZJZSrLoc/gOSH7n22jOp4lDeSb+DnRjxni/Tmhwsem/Jk/5YPfPzbG1qJpUKdAXswao2aKS3nsJsOGjDiXxRCn46ODtRVFwhSWUIQy4Xz4fHTtvVd0CYcuFo8tu6qE+EhM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(261009223027099003)(261021123027099003)(11063799006)(56012099006)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(38070700021)(261022105027099003)(10067099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TC9paTFUcnhWdjYzcTFvZUJLcERiUSszN3hNQ3RKYi9sRTVneFdYT2tpMHBQ?=
 =?utf-8?B?Y1NJRHRxMk52b2l1VDBsVHhPQ2JpM1M4WHlPQjBFMko2QjFyUTd2MFU1dG9s?=
 =?utf-8?B?K0ZJTlQ0ekRBaXg1dUp1ZDJTTjA0a3R1TEZGblhaeUVWbHRPNmdhYzdCemlz?=
 =?utf-8?B?NlZwVjMxMmxUSjM3QUVFZyt3TGhvMHlBMlVEZHhvQ2Jidi9jbFlna0RVUEdz?=
 =?utf-8?B?VFI3NHUwVEtxNXYxdEhZNXloaU9tVWladGx3d2c2c1h5SGFuVTY1NWJkYk1s?=
 =?utf-8?B?MG4xMWtGZUZmclBNendHMHhpUStvTkFFeEQvQmVKWFBycmRFSkRzN0JXdmJB?=
 =?utf-8?B?TytKSS92TGMzNS9WWVlWQjhtOVJjeXR1TlM1Q2FmeTZFOFErNEtZUlNFK1JG?=
 =?utf-8?B?VkREelAxaG9UaytVY0p1NC9uQzRmc3FibzdOcGZ0aUR1SzdMOVQvOWMySUJO?=
 =?utf-8?B?VlRvem1nTytiQ211MjQ5czNiSDhNZTM1VGdQM25vdXl4MWovSkhDMnJ4YWxK?=
 =?utf-8?B?VE1nR05tNEhXOTJLeU03bDBjOEtYdEtRbzBIRHZKZ0w2YUdTVDhVSGFiWVBv?=
 =?utf-8?B?K2NNbFhoaWZGWkxKOCtPSWxXY3VvSWZwbHZ4bTJwS0N1Q0lua0pzdW5XRDZP?=
 =?utf-8?B?eEhpcVRuOW5BSGVLNFFuM3dBZVU0Z09IelZYTjNOWDN4UGM5bW9FMVhYZktS?=
 =?utf-8?B?M0pERXJ1ZVpIK04xc0pqcFNXZmlPVld2RVJqL2M0Y3A0MkNmbkJSWUxaaFRE?=
 =?utf-8?B?MTBLZHhiOTZPRVBhRDVRejZ1N1BLNmR0ZEdzTEhmVVp5V0V6dDJCRFRDVkZY?=
 =?utf-8?B?T2hURXlVcWxQRzVsTVZOWDlpWHpheHlreG9PanFEcFpab0YrZXBUakNIdUF5?=
 =?utf-8?B?M0l5K3hSYXpmbXR2MlhEejlCaDhCN1NtQ1NiRmxQOHJXK3FPa3drdjJYN2d3?=
 =?utf-8?B?aFM2UEhJS0NJY2hLanlRUlFBcEoycFdPY2lGQTc1R2xDS2REZWJtaloyRmpz?=
 =?utf-8?B?YzhpdUxtTVczSjJ0bzVrRXRHTXAwMStWbkErUXo1Z2JnOHNjajNzTVlLVGdp?=
 =?utf-8?B?NktlN3BTMVdLRWcwY2o3WUtCVU15YXY1M1R4bEFLK2FPRlJzVFhXa20rNTEy?=
 =?utf-8?B?Yldqd1B4WEdML1ZMM1VJS0o2NVpXVUtNZ1c5Mmt4U0lyVVd3cC85OWV6MmNG?=
 =?utf-8?B?eGE3YUZMY3BjUlN3SzdDZm53Z1Z2UG5lV1AxSlNVR09FakRlWWg4YSsxUjE4?=
 =?utf-8?B?SXJBS2I4cXhvczljcG41YmY3MzNEVEN5TUVmeXR3MDhWYVMvR2U2ZmlLMUNn?=
 =?utf-8?B?cCtYYnRVY1ZzUDRxL2toVnlwM2tESGx4TkNhOUtzdXlZYWNlQ3NjeDdSTE93?=
 =?utf-8?B?TC9PU1oyVHI2dHZnanY1OHJQandjbWV6bXFRV21FTmFsckFwQTRld01RRm9W?=
 =?utf-8?B?MnZ6Ukc2VFVtZ1VBOUR4NGlYRlRWZnBlclIvcU01NUJqSFMvSnBZSGlyUkw5?=
 =?utf-8?B?VHgvUmZNa2Jrb2NEbklpb1ZpSEFxWFlTWGNiWTlKT3pBa0N3MktrRVZNUXdX?=
 =?utf-8?B?aVUwRGJ0aXpVVHRVdVlES0JYbXNSZE1VWVFvaUF5UEFrN2JqS0VjN1E0NU81?=
 =?utf-8?B?TTVrT1hXTlNuU3ErNUFqaXVsclM2LzRGd3lEQ1hLSytLT202bHptK2IxbVow?=
 =?utf-8?B?TFBmYzIxMk9DamRha1lpWXRiQlZGMVdHOEwwSjFXVzQ5Z3poZ2x2TUtIYVdF?=
 =?utf-8?B?eW5IdDhJSXE2ZVR5VWgwYXlla1BhcTVkcWtNZ2Y4QlJYbDhHRFJqc1hGcVlR?=
 =?utf-8?B?VThERlhvckhORGtvWVJOb0pqSlBKUkxLcUFPenJ4My90NGcvQWRmbVBsUVFS?=
 =?utf-8?B?RVk3YW5OWVBaNTZTaE1MRkIwNjhDeDF3cnA0N3lTYUs0cTZHSDlQNFkyWG1z?=
 =?utf-8?B?WWVOMDVQSHA4NmZGeE9mWTliMnhaaDB5dlhic1k5UnNFNHVhOW9qWEdjOWh3?=
 =?utf-8?B?V0kydThWRlp6SHA4QjYrR3RITlk1dzhQMUdTSm9JNkpybXZSQnRXamJOQVJr?=
 =?utf-8?B?aW01TFFLVXNwSDEzWWJvWG1Td3VCY0orejVKd1dUZHVYbGtWSnBYWE1pd3lV?=
 =?utf-8?B?a0VaTFFIRkY0dGNHNnJVOTFwcWdRL3o0MzU5eXBJWDAyS1hzd2JBVGxpb3hY?=
 =?utf-8?B?SndQL2lHRGNiRHFBOHFHWlFSK2JoLzZmbXZXK29WcFRjb0VPMDdXanJNRGxK?=
 =?utf-8?B?a1pXVVJXeVJha240VTBGOVV2LzhPWHdjWW81ek5yL2hOajQ3WGRqWWQ2ZWp5?=
 =?utf-8?B?UnpZVmlmY25LUjc2bWJvV09nVFU5b3JVVTBRbS8vc3MvWDVMMFQxSmxQTllP?=
 =?utf-8?Q?GB2I+hij3NAV9SvbKKiJFSVwMyD2T22oi/A4JbMXmvUsA?=
x-ms-exchange-antispam-messagedata-1: RNEMjXmTiAqpS2g1ApuQJiGoP2Mt6aOaWmM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B2C726BE5FDC44C878F6D139A5DD17C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cCd1MidKvPU3RbacsaQgPylShUgos0e2mwhaYd+lyWBHXSUEMD/2DIx9iODIY4eTrkS/+4Vq1vGmHt0n9ap03Vr3ZEvVXuKUYEZ1eJWenfYKEFo0Y0LvRgrB3ndyW4kos+V9CkTYJ+Us5FnUqHsG+jgG5bpeLXjHukGKUafjLWp9FDKEvFJPueUIZT8bq9U3ZSq1FvZxKE5uuirBvW1cBJr+OMd3lsWsWLC0KMGNdySAZrARgO1LZuDuGOUcCSABCOVB0XlF1uC/QwLsbP/OjJCxCbB9Pi/E/vvanHPfC5Ixijd6ChgJ98pDdWqQPr4XyTg3fjTICzlax8qdeXkT9g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hkumlNa49hLUAvIKkEFpsJ6m0WAS2oO9WkoUUEHf8X8aC6WVD0fTLjaTKKQcSogIdb5F67idr1jA9AF2Js14fsC7ar49HONg+wNpjmYDb2gxU+y94Ic/Kol1LsNZ1u6SkFSglgrJVpYxngyv4iUI6YUwqrXuCFjSaal4NHaIL4femq/p5k39xzSWDCMgLcmPIlmYm0LIyfBECch7NnYDXNNDFgKtp4HH2cQ0PNnImB4e2mTbdB4ELNckCuZlXBLXCykHrTsCJyWLO8LbKaIV1QstMosBfk5McKA0PuNA9jfXV4Pd+JMriIhln5Nhsw4FaKm8WHfgQ1crGT3t2otll7kHaS9VwLC/vyOEmKAZY61UkuI1bEA7XIkR+WVHHpU4sfATEC115lpZgZ58Py+jJdS+R0ef6awz5+jz2E4Z+5v1HjvbFcc9k9jhG0ZrfFC8m0ywgO54npRVnoL8ZpLqcQYnwnlb7ZVoTTBJsBVZbWnVHCFfRohqnG2mLhVgUJ9IqkwpWmAUXGzhD2bDFu1btz5PA3YRBiYgvxk46UMDJLgr35v/4zgMTAAgtosRO8PxtWHCkrecfGvDUQUX4FjsDNOqFfhyJA2Ri8HUuEhkXEQFiaFkSjRspnhWr2Zs8o6W
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075b2704-a531-48d1-9059-08df469fcb89
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 00:47:03.8179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zci2z1AJkxDzRdHXv0pjRkBOhnBYh80PeyCbx2rCf4ZuCfU/XrUTzuoJY3E6N0+DO9dgHyiyJZrSoD7SjfrkNDRyk03ISxcg+ATD4hbK8qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7453
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=7773dcc14=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gTW9uLCAyMDI2LTExLTE2IGF0IDE0OjUxICswMTAwLCBIZWlucmljaCBTY2h1Y2hhcmR0IHdy
b3RlOg0KPiBJbiBMaW51eCcgc3RydWN0IGt2bV9haWEgdGhlIGZpZWxkIG1vZGUgaXMgZGVmaW5l
ZCBhcyB1MzIuDQo+IENhbGxpbmcga3ZtX2RldmljZV9hY2Nlc3MoKSBvbmx5IGNvcGllcyB0aGVz
ZSAzMmJpdHMgdG8gdGhlIGZpcnN0DQo+IGZvdXINCj4gYnl0ZXMgaW5kaWNhdGVkIGJ5IHRoZSBh
ZGRyZXNzIHBhc3NlZC4NCj4gDQo+IFRyeWluZyB0byByZWFkIHRoZSBtb2RlIGludG8gdWludDY0
X3QgZGVmYXVsdF9haWFfbW9kZSB3aWxsIG9ubHkNCj4gaW5pdGlhbGl6ZQ0KPiB0aGUgbGVhZGlu
ZyBmb3VyIGJ5dGVzIGFuZCBsZWF2ZSB0aGUgcmVzdCBvZiB0aGUgdmFyaWFibGUgYXMgYSByYW5k
b20NCj4gdmFsdWUNCj4gZnJvbSB0aGUgc3RhY2suDQo+IA0KPiAqIENoYW5nZSB0aGUgZGVmaW5p
dGlvbiBvZiBhaWFfbW9kZSBhbmQgZGVmYXVsdF9haWFfbW9kZSB0byBtYXRjaCB0aGUNCj4gwqAg
dmFyaWFibGUgdHlwZSBpbiB0aGUga2VybmVsLg0KPiAqIEFkanVzdCB0aGUgc2lnbmF0dXJlIG9m
IGt2bV9haWFfbW9kZV9zdHIoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhlaW5yaWNoIFNjaHVj
aGFyZHQNCj4gPGhlaW5yaWNoLnNjaHVjaGFyZHRAY2Fub25pY2FsLmNvbT4NCg0KVGhhbmtzIQ0K
DQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQNCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4g
wqB0YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYyB8IDYgKysrLS0tDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90
YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYyBiL3RhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5jDQo+
IGluZGV4IDViZWI2MDIzMzguLmI5MmY5NjE5NzkgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNj
di9rdm0va3ZtLWNwdS5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5jDQo+IEBA
IC0xODg0LDkgKzE4ODQsOSBAQCB2b2lkIGt2bV9yaXNjdl9zZXRfaXJxKFJJU0NWQ1BVICpjcHUs
IGludCBpcnEsDQo+IGludCBsZXZlbCkNCj4gwqDCoMKgwqAgfQ0KPiDCoH0NCj4gwqANCj4gLXN0
YXRpYyBpbnQgYWlhX21vZGU7DQo+ICtzdGF0aWMgdWludDMyX3QgYWlhX21vZGU7DQo+IMKgDQo+
IC1zdGF0aWMgY29uc3QgY2hhciAqa3ZtX2FpYV9tb2RlX3N0cih1aW50NjRfdCBtb2RlKQ0KPiAr
c3RhdGljIGNvbnN0IGNoYXIgKmt2bV9haWFfbW9kZV9zdHIodWludDMyX3QgbW9kZSkNCj4gwqB7
DQo+IMKgwqDCoMKgIHN3aXRjaCAobW9kZSkgew0KPiDCoMKgwqDCoCBjYXNlIEtWTV9ERVZfUklT
Q1ZfQUlBX01PREVfRU1VTDoNCj4gQEAgLTE5MzcsNyArMTkzNyw3IEBAIHZvaWQga3ZtX3Jpc2N2
X2FpYV9jcmVhdGUoTWFjaGluZVN0YXRlDQo+ICptYWNoaW5lLCB1aW50NjRfdCBncm91cF9zaGlm
dCwNCj4gwqB7DQo+IMKgwqDCoMKgIGludCByZXQsIGk7DQo+IMKgwqDCoMKgIGludCBhaWFfZmQg
PSAtMTsNCj4gLcKgwqDCoCB1aW50NjRfdCBkZWZhdWx0X2FpYV9tb2RlOw0KPiArwqDCoMKgIHVp
bnQzMl90IGRlZmF1bHRfYWlhX21vZGU7DQo+IMKgwqDCoMKgIHVpbnQ2NF90IHNvY2tldF9jb3Vu
dCA9IHJpc2N2X3NvY2tldF9jb3VudChtYWNoaW5lKTsNCj4gwqDCoMKgwqAgdWludDY0X3QgbWF4
X2hhcnRfcGVyX3NvY2tldCA9IDA7DQo+IMKgwqDCoMKgIHVpbnQ2NF90IHNvY2tldCwgYmFzZV9o
YXJ0LCBoYXJ0X2NvdW50LCBzb2NrZXRfaW1zaWNfYmFzZSwNCj4gaW1zaWNfYWRkcjsNCg==

