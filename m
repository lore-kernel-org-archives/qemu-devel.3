Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED6606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Av4s4GSH;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Gev2gADz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJkIW-0008P9-Vh; Thu, 22 Oct 2026 00:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJkIR-0008Oe-1Q; Thu, 22 Oct 2026 00:20:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJkIN-00081d-Ry; Thu, 22 Oct 2026 00:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792642851; x=1824178851;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uNCOUO03T6LJ4HI/NGh6X1f5Puw0hiqD6ONVsvY7vxE=;
 b=Av4s4GSHMwdPDdnbZWwN4SnUDdntv+/fWKcjDF6XpM74ssRHIEfEvvF+
 oOdu7Sz7pQRQDIoSWETQR4D+u39mdHM0gkxXEwxFAjZNZuDTl1GPzPXD7
 agJVLyKVHxhVSXQghMG3ZTNl3WriUVxE+um9/m6Ows7Y5Z9oMzDjV/ZI5
 MKOKF0YrM3PMdV/z7rWxaqO0ZmsyR4GYV3zYfQWXrYhqCkrkst2g7KZy7
 74J/CdusDiafziVdiodlz1iKcHKvo2Jzv+JAKACHangQGMCzYB6ANFh0V
 5EAer6T7laP7lQCHttnATRUvE0wzNLHLOLNf8ibz75TiUZcf/6zzivTri A==;
X-CSE-ConnectionGUID: Kk+CFaOCT6SJdYTtBcBSpw==
X-CSE-MsgGUID: n90wBkKES26ZirWmajAIFg==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="158599517"
Received: from mail-southcentralusazon11013055.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.55])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 12:20:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6/gz2nuLqkij5/lrAJCwITfI7Jb8LmorwHfcl0kwBOP/F9kK5V6/5HSzrxZbnulLXVKyYorGL+FZ6nX3S6+RvQJqvCprs+smzuQjQK4eCSRSDbgAN9gkfxe5QaXYPTG1TRbWWkfBGkPD4GM5c3F8K0O/weauOlw2c9ZmjexqO5sBLUd/svAbndCuQEhNrTU8nwAF0ar7oDT7lu5ce+vA869+d0G1u0xJQK9oRvOwhrgx9gkAVAXmK0HKGbQnaWVsiOEfRcb0f1ALYViqrnYbJcDzQbtZlOUeRo+6kSCma894OLtndsBQjv7WK7tACqdJCFdRsBD/zd0OgNQgZ2sZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNCOUO03T6LJ4HI/NGh6X1f5Puw0hiqD6ONVsvY7vxE=;
 b=tzw2dB+MUq7kCTJFflCesEPNTZRdDRv6lLNF4/cuT3M9cIJI5bGOVipXV5HqRZtRAJ8XOhs/5CKbyJoUUraWHEuFz4d3WT6ceu6I4Z4vkabYP6/M7vHWlNjGncmNJmfMLHApPkP69E798E6jFcDh+ghxwWtNMuFXbhLHBAGdKZpa0+XvL5Yo8TbXU75WUOhrPOrMG2je4oxHF/lnUNODPw/g7wNz4mMgzcZDJR3eEJMNjyT8ONOTYRcMVHslhxYVFxwIvZUi9OT3d/mbD/bPPAe1b3IBA1oMd8JELMVopbDp0XvP88jf/khQ4dca3ssCxuVge4gCGHpsKTfRVKmhWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNCOUO03T6LJ4HI/NGh6X1f5Puw0hiqD6ONVsvY7vxE=;
 b=Gev2gADz1kS+Wuzotl3zux6jAPNqHK9LRWiL50xgtE7bVwSxpU0gGIe0xLAUsg7Ql5JO+3UvkSv1MKxu6OH0SSFDeTHtd/n92eCmjs0tuNGVMbnCPr8xpK3Id0LBA2WUNGkbbYLdHAFfNFQCBonc5pebc2LlZdGNFFWy9UcE7F4=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MW6PR04MB8916.namprd04.prod.outlook.com (2603:10b6:303:246::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 04:20:46 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 04:20:46 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "sebasjosue84@gmail.com" <sebasjosue84@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 0/2] target/riscv: pmp: fix stale PMP state across reset
Thread-Topic: [PATCH v3 0/2] target/riscv: pmp: fix stale PMP state across
 reset
Thread-Index: AQHdYdpHBnrcYjGJ4U2prFK8MytUdrcI9bWA
Date: Thu, 22 Oct 2026 04:20:45 +0000
Message-ID: <7451ed9bc536f242b715e27a947bbe99edcf4136.camel@wdc.com>
References: <20261022040258.1509306-1-sebasjosue84@gmail.com>
In-Reply-To: <20261022040258.1509306-1-sebasjosue84@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MW6PR04MB8916:EE_
x-ms-office365-filtering-correlation-id: fa72ada5-f669-4ce0-7743-08df2ff3d82a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|376014|19092799006|366016|261021121427099003|38070700021|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|261021123027099003;
x-microsoft-antispam-message-info: kGwb/2/f9omn8/OyRkM9C61r1TzTv+wnEOQY07ln6McYNigynU4/E5WIu+yWlMdkbJP/X7kiqOKWfLfFYOB6YcwoRj3/ikoPCurTFt2yQ4iyVl9f8lxLeqmojLz7btgay8YfMN+p1yzyp7nSWPjnDzNDrx/fj8shxI/e/8CkniPCBNRtPRk1EUNZCE2fYQZ4bCYQu5mnmC4/ctwJbyTCRp6uWTa1RUzAx1eWvKChix5KhTCt44j/sW8tUoMLlZhA8k0t3MS2q1C7weSmkLZdP1KvGVBxJv7sKi5RHwDGiZCimvAATS3VxOmhkJffaM3/zOLSKiwO6ghyplA+gaBhd69mppmA9EVCehCGALIVdzJNeA5Ls25lPUsKyO3FMaCSIigbS4z6/w6NmJxyPg7BZyhwFj+a3OZQceXXp2KTLAtRkCis/Gqy0wATcXrHsL5Dwvt6NpkhxLa2CtgPhBgHD/vKgt74gVxBtKEbB5FuMSe1KJmvXofnr+HSVf878xU3dPNkMRucy9H1WE+WFb0veUfjpa6FxxqJynqjlnzv4ngLVlfcl80aekGhsNppo7psWJv5EUi6rRuyTMli9J9rjWqxG5v5EPm0FWdMWkXQ0PU5knXET50HfhefpF90lqEoPYKalXzkEnP06IW7B4L8ui3dd71yibOqW1smAmHIvIM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(19092799006)(366016)(261021121427099003)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDNBdVN2V3FKWmtMVHdRU3N4RC8zc2QzYjFoQ1lYWHYyWmJsU0xvaE9DSWov?=
 =?utf-8?B?cVAreWQ5bmhOUHUvdDI0UzRMeHdTcU5qTERvakhZQ0FQdDZiTktNMkxHVThY?=
 =?utf-8?B?VjMydjhMYkkwQ25lczE2S0tscEZuYWRUVXd0NnNqTzhqNVZncnlIWWhIaHVn?=
 =?utf-8?B?UzJPRXduL2hZbmI3b0ZBTHdPRHhNVkxBTmhLVmpHM01uU21Kc0wya00xSStI?=
 =?utf-8?B?NWZGTEV3d0trUHRvV2EydDVrQXdqVzBiYnNFcTJ3T0N4VzhKcUQ5cWFCQW5I?=
 =?utf-8?B?SlpEQ0toN210TzM5dC9tU1FVWmh6UDF2YmVGclgyekRCbUdpRlc4bEZLd0NC?=
 =?utf-8?B?SDVYd284Vno5aDJIVVhDRCt2RWxTRXBUaU9wUm9NekFnS2hnWnlwRXQ0NWta?=
 =?utf-8?B?cklDeS9CNjBuZll2LzBoVmpOcVk3bUJaUzdsT3dZSjkwd2VqTmZNa3A4NHhh?=
 =?utf-8?B?WHN0ZThYTTN0Z0VQOVdjSUtJdFpybVVWTlBFSlZyL3AxN2d2b3psQ3ZOVU9o?=
 =?utf-8?B?WUYxYTNKT1FYRkt5SmYrbzljRUhYK283KzdWLzRyWDdpYmk0c3RBMVpHSnBV?=
 =?utf-8?B?bXN3TTcrUmdrdFJJRUdIUy9sa09GUHhFMGNsTUF0TnVudFRkSTlnZFR3WERQ?=
 =?utf-8?B?bVY0Z0Z5UEVkbkhPZkMrdkRVREwrVzFEWm9zbVpaRVI5MlcvZm5LNUVnczho?=
 =?utf-8?B?M0dDVm40a2o1bk84UFZRQVJxNFJHeDFEMDl0eS9NNCt1NEpGS0lkSXU2VVgv?=
 =?utf-8?B?cXQ3cWU0NFVoT0pnMmpRYnEwV3BRdzNBbUFVZkVLbGo4TGd4WFMvbXJNNVYx?=
 =?utf-8?B?V0JGV24xREhXSXY1cDQxNytYemkzZHJRR21kUXFWTUt0bmROS3FJREhqRElN?=
 =?utf-8?B?Wi9oUGhkY2pEQWJRc3QvVzVaSUlsRmhhbnowbGNBdXphamk3MklKRllKTllt?=
 =?utf-8?B?WHZaMzJZYlYwWjgvZHYvWnVUYmhLYldPTjZ4MG1aQkU3OEJGRDVOTUF2eUgy?=
 =?utf-8?B?RWtTSGtxelBDb2QvOGZyY291T1hJbFhzckYyeUJLc3JVUG9yNHJmdHQyUmwr?=
 =?utf-8?B?dGpWWG5ENm5wR0JER3Rld2RhWDQwU25wN3ZFUFdtZE5jVzA4QXJXY2JaVC9s?=
 =?utf-8?B?U2VXbGVFeFU3akdVQzlydVprTUQxY0VSdHV0UTk5VFYzTjdraE1WYnV2d3Qw?=
 =?utf-8?B?RktLbW5VbjNIdDh1Q1BKbjgwNVg2TzJUS1c3QzJTL0huOTFUSk5FVXV1YkM1?=
 =?utf-8?B?SzlhVmxHaXZMZTNSWmhJOHJXSnFRYytyMFIxS0hVL3NTOWJtOE9IcFJ3RkJL?=
 =?utf-8?B?TFNybmx3ZmJWVEtoS2ZuaVUyUDhxVXJzYStqQXVKd0lkVlF4blBZK2JyVXJz?=
 =?utf-8?B?K0RodXROSGlROWRrWFFvbTgvYkhIVExQY2xIS25aNTREY2c3S01UNTI1bTBH?=
 =?utf-8?B?d1diVE5XQnlFcHZBWVBNV24yU2VEbFZ6aG1kUm5EUjY5VEs0Ni95Ym0xY3M1?=
 =?utf-8?B?c3o5Z1NrTFRkZ28xWC9yTENzeEtxMVlvNjdpdnZhbllpc1A3QU9tM0JEN2VS?=
 =?utf-8?B?WmpDdVA2UVVqR1E3YmhjWUt0Mis1dW1IeFlCRzRGekZqa1lzNUZIa09tSlBj?=
 =?utf-8?B?MW9pbms0SjFITGFkb29DSjVQa2tscW0yYURXVFlJYUpaZDdYd1o5QTg5cGR0?=
 =?utf-8?B?ZWc1WEtEMmpET0dpemlYT1hqNWgxUSt2aHhqbkJ0RTJuY01kQis2aVIzR1Zh?=
 =?utf-8?B?MnJMZ2VuQWQwU3hNVzMzWWtYY2pwRmppVmZCdjBqWTVKVkFMTnNQV2RDREFP?=
 =?utf-8?B?VW9FdmdNOGtiSkhYNDlyeGVTQWg2RGtOaE10YXZNUytTK2dmMFdGdUFWTjVQ?=
 =?utf-8?B?VFliQ1ZRbW9nb0MrZ3BrRldyU01kZXg1cXVreW52SUtwaDVaTjB0OU5ncDFp?=
 =?utf-8?B?cVJ3L0J0b3REbEVUbXAwVHlKMmlDd3FBVVRYbi9ONlh5RFEwY3hLV1ZEL3Zr?=
 =?utf-8?B?OGtMNFNPc1BSNnZuTUMwY2FNNlFMZzVLdE8wM1BWMy9UamlSTXVEZjBKWUdM?=
 =?utf-8?B?TlpvcTMwSG5BdVl3SEc3WnVDMFI3TzNRMldoZ2NLdHd6R204bDlaYklMSmJD?=
 =?utf-8?B?cXYwc2V0aUZ0NGxsRks4Uzh6VE13a3ZiK3FaTWJhejVEK1VrUmNUbC9mRTB3?=
 =?utf-8?B?Sjl6UmhWYitYWjdZZDJ4enRIazk3MnlkOXlQZTNQQThheWQxSjRldXljWWlZ?=
 =?utf-8?B?VThmTXAwWS9YTURTamFTNEZ2QnhRb1NHQ1NUSmM2QjJvclFwOXM4cWVhWW0v?=
 =?utf-8?B?bUk1UUN0a2tkTW9FbzZlaGZ2KzVmbHlyUVlSRURHcVlYVmgyN2pON2E1YSsy?=
 =?utf-8?Q?kzpBusKsF/5RSlaqsA3lPRdtQgD0bsMZFuhQLrUTAVxHq?=
x-ms-exchange-antispam-messagedata-1: j7zZfrZXxbg2kNXhNk6+yBsNpPEdVXnNBmg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE206FBC12DACC4F8B2D3FA71E3E9011@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Wqp95BVSpJXwu0gb1zusoeqml1Dm2s4/iOT0vMnMqqxGt7HEJq9hzv0BbE12D+9pE/omnv8vurWbpae58rEnz8breKrYxoQLEmmaLwYZ8D9kWPY6rB9snFwLcnsOFxX2hUHtBQSu3Ith3AHL2/buEvvBgd4vYkDAI/ebRnN7of7xYtEcvnaWE1G+3ZYz75t90XNWWywbY/HN3bRpwY0ypJ/fsj34JqbmcnxSiUDkquHCxwh4qSXMWofSf7Pi/09Hq0CnbdjnWZVJxz6WvGdCwW9TwYui0z+TPs+JBUBEJc7zWLtWiV1I/q1tC7+om3xneePN84MzqYulacV8gTD76g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0RSi9xJM3INRUkDkycVfAvsSonrMCfUv4iVXAgRnW2j01adcG1AI/Urm6OJWdIToWBGDD41wCONzKdNFNyjl1Axeps1z84s0QtTbH1t1bUJmU14qn0w+gTI5PlyhGjN3nMEOzRZcV//X98pWZh02kp9y+98QuNNtWFNj+/IvwlerU6V26mAfIc9x5J39wHEXlvq4ul/wy9k3xh4hV1feTIs9Q038xTQl0q3bD/+1DMF1iVOv3nixXymYJvC77QGvAi1adqmseGjdqhbNkzOLD/zTORv6Uqtpum8NzIfqPjEcnOpt7zhGlx2Qgueyxt2Ason+67BBqW3LHG8AbyzwSCCn6s4VT5aj/1fGQ/MEr/tIOXBpNbTE/XhFitKXDISR+8QopCpW1NjmPfkxU+kLG+1Yj3CLdMbLjfDy6ePLQDA7IGlVka0B+x2FXHadwgXmhHkJMdbCVYjk0vC+azVN0+Yt4SA34uJgK/cLCUFnYeJ2ob5WJ+gcSNBp0Dcm6kTOKErPtQkAFbngct7dTcgj0lgtzJWgN2rEQysIU2Gu3ro+wn6NHCZENN2c/6SGbYN0VaoWj1PtW69gqCOlvZBqUo3hxy2rmNroXGTDeV7Jpro342bDLf5JFqTP1GXh1JWJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa72ada5-f669-4ce0-7743-08df2ff3d82a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 04:20:45.9757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3uQrFyMcTsCs1hqvO4MgQ6wo2JAL3ZFFKcovTdNH+Dp7ARHGXViIAiZHoZK6Nvwfszgh0L+Pc8nFE3TPsfBbjRoi4lSNfs5cGLHj9Ia01Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8916
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTEwLTIxIGF0IDIyOjAyIC0wNjAwLCBTZWJhc3RpYW4gQWxiYSBWaXZlcyB3
cm90ZToNCj4gdjIgY2xlYXJlZCB0aGUgd2hvbGUgcG1wX3N0YXRlIHdpdGggYSBtZW1zZXQuIEFs
aXN0YWlyIHBvaW50ZWQgb3V0DQo+IHRoYXQNCj4gdGhlIHByaXYgc3BlYyBvbmx5IHJlcXVpcmVz
IHRoZSBBIGFuZCBMIGZpZWxkcyB0byBiZSByZXNldCwgc28gdjMNCj4gc3BsaXRzDQo+IHRoZSBj
aGFuZ2U6IDEvMiBzdGF5cyB3aXRoaW4gd2hhdCB0aGUgc3BlYyBtYW5kYXRlcywgYW5kIDIvMiBo
YW5kbGVzDQo+IHRoZQ0KPiBkZXJpdmVkIHN0YXRlIFFFTVUga2VlcHMgYWxvbmdzaWRlIHRoZSBh
cmNoaXRlY3R1cmFsIHJlZ2lzdGVycy4NCj4gDQo+IDEvMiBpcyB0aGUgdjEgZml4LiBJdCBib3Vu
ZHMgdGhlIGxvb3AgYnkgdGhlIG51bWJlciBvZiBpbXBsZW1lbnRlZA0KPiByZWdpb25zIHJhdGhl
ciB0aGFuIHBtcF9nZXRfbnVtX3J1bGVzKCksIHNvIGVudHJpZXMgcGFzdCB0aGUgbGFzdA0KPiBh
Y3RpdmUNCj4gcnVsZSBhcmUgbm8gbG9uZ2VyIHNraXBwZWQuDQo+IA0KPiAyLzIgY2xlYXJzIHBt
cF9zdGF0ZS5hZGRyW10gYW5kIHBtcF9zdGF0ZS5udW1fcnVsZXMuIFRob3NlIGFyZSBub3QNCj4g
YXJjaGl0ZWN0dXJhbCwgc28gdGhlIHNwZWMgZG9lcyBub3Qgc3BlYWsgdG8gdGhlbSwgYnV0IHRo
ZXkgYXJlDQo+IHJlY29tcHV0ZWQgb24gdGhlIHBtcGFkZHIgYW5kIHBtcGNmZyB3cml0ZSBwYXRo
cyBvbmx5IGFuZCBuZXZlciBhdA0KPiByZXNldC4NCj4gDQo+IFRoZSBzZWNvbmQgb25lIGlzIG9i
c2VydmFibGUgZnJvbSBhIGd1ZXN0LiBBIGJhcmUtbWV0YWwgTS1tb2RlDQo+IHByb2dyYW0NCj4g
Y29uZmlndXJlcyBQTVAgZW50cnkgMCBhcyBOQTQgb3ZlciBbMHg4MDEwMDAwMCwgMHg4MDEwMDAw
M10sIHJlc2V0cw0KPiB0aHJvdWdoIHNpZml2ZV90ZXN0LCBhbmQgb24gdGhlIHNlY29uZCBib290
IHBlcmZvcm1zIGFuIDgtYnl0ZSBsb2FkDQo+IGF0DQo+IDB4ODAxMDAwMDAsIHdoaWNoIHN0YXJ0
cyBpbnNpZGUgdGhlIG9sZCByYW5nZSBhbmQgZW5kcyBvdXRzaWRlIGl0Og0KPiANCj4gwqAgdHJl
ZcKgwqDCoMKgwqDCoMKgwqDCoCBwbXBjZmcwIGFmdGVyIHJlc2V0wqDCoCA4LWJ5dGUgbG9hZCBh
dCAweDgwMTAwMDAwDQo+IMKgIDEvMiBvbmx5wqDCoMKgwqDCoCAweDAwMDAwMDAxwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBsb2FkIGFjY2VzcyBmYXVsdA0KPiDCoCAxLzIgKyAyLzLCoMKgwqDCoCAw
eDAwMDAwMDAxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdWNjZWVkcw0KPiANCj4gVGhlIGFyY2hp
dGVjdHVyYWwgc3RhdGUgaXMgaWRlbnRpY2FsIGluIGJvdGggcnVucy4gVGhlIGRpZmZlcmVuY2Ug
aXMNCj4gdGhhdCB3aXRoIDEvMiBhbG9uZSBudW1fcnVsZXMgaXMgc3RpbGwgMSBhbmQgYWRkclsw
XSBzdGlsbCBob2xkcyB0aGUNCj4gb2xkDQo+IGJvdW5kcywgc28gcG1wX2hhcnRfaGFzX3ByaXZz
KCkgc2tpcHMgdGhlIG5vLXJ1bGVzIHNob3J0IGN1dCBhbmQNCj4gcmVhY2hlcw0KPiB0aGUgcGFy
dGlhbGx5LWluc2lkZSBjaGVjay4gVGhhdCBjaGVjayBjYWxscyBwbXBfaXNfaW5fcmFuZ2UoKSwg
d2hpY2gNCj4gY29tcGFyZXMgYWdhaW5zdCBhZGRyW10uc2EgYW5kIGFkZHJbXS5lYSBvbmx5LCBh
bmQgcmV0dXJucyBiZWZvcmUgdGhlDQo+IEENCj4gZmllbGQgaXMgZXZlciB0ZXN0ZWQuDQo+IA0K
PiB2MjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTAxMTA0MDYx
Ny44MDc1MDQtMS1zZWJhc2pvc3VlODRAZ21haWwuY29tLw0KPiB2MToNCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDkxNjAzNDMzMS4yMzkwNDI3LTEtc2ViYXNqb3N1
ZTg0QGdtYWlsLmNvbS8NCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5l
eHQNCg0KQWxpc3RhaXINCg0KPiANCj4gU2ViYXN0aWFuIEFsYmEgVml2ZXMgKDIpOg0KPiDCoCB0
YXJnZXQvcmlzY3Y6IHBtcDogY2xlYXIgQSBhbmQgTCBvbiBldmVyeSBpbXBsZW1lbnRlZCBQTVAg
ZW50cnkgYXQNCj4gwqDCoMKgIHJlc2V0DQo+IMKgIHRhcmdldC9yaXNjdjogcG1wOiByZXNldCB0
aGUgZGVyaXZlZCBQTVAgYm91bmRzIGFuZCBydWxlIGNvdW50DQo+IA0KPiDCoHRhcmdldC9yaXNj
di90Y2cvcG1wLmMgfCAxMCArKysrKysrKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K

