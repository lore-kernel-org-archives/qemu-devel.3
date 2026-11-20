Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D59606A337
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Yv1MOzcD;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=jLKDeRv+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUD58-0004Wo-8M; Thu, 19 Nov 2026 20:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7773dcc14=Alistair.Francis@wdc.com>)
 id 1xUD52-0004Vm-6W; Thu, 19 Nov 2026 20:06:21 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7773dcc14=Alistair.Francis@wdc.com>)
 id 1xUD50-0000gD-2g; Thu, 19 Nov 2026 20:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795136786; x=1826672786;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lLPM+3erz7mBVPknGqWVbH6ezSNRofaNap9nRi638BE=;
 b=Yv1MOzcDxKjqcLLYkSvs+aiKZzJVa99ahTdMBO5EanstyCqukdd8EAKR
 +KtTVH1/CmoTBfC71pZvh0/Cq8PxJ1yvJXdfp758FtPxa1uRI9hV5eZHO
 9kBm0c6mb7bhRUw5ZZ6hi90kOIkXqjt2tMgcfuCVBLJ+B0E81Qw9XvxYP
 zxg0PQM7BXr+l0GqZUZB7/s4aP/w7AfeZD0RL7HXVF5jX1kM8TSjuhi/B
 3PPTuNBNKpj3o1cJz6DoLdhIBl+/G6zVF/Uk3zUiPrMh662mw3DteAA+1
 U7SUkYKm05zicEOKcujW1YARc6VO6xHNND8pCrKbV9Pek+62BOsPRcz1G Q==;
X-CSE-ConnectionGUID: ZOxYXS1YQHe5NgLUlfctWA==
X-CSE-MsgGUID: Lgy7VPkmSBeBeDmIshSy5Q==
X-IronPort-AV: E=Sophos;i="6.27,222,1786982400"; d="scan'208";a="159710552"
Received: from mail-westcentralusazon11010051.outbound.protection.outlook.com
 (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.51])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Nov 2026 09:06:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kv0WCWZUDkCajEoZtx4KLSP7oEt3dmVEk3dZr7Tr/wNrDA+aD867ng+jJddquti+kvm3DGDnEJPpyz3vg1ftWHxo/2Cci0nu638rtNsz+F2CtZTyZTmOHQoXtkLD+1mLi24A5HjRoSHU+VlgsF58vxEz2/ZPWPsKYqgsrJWAQS2wh5BJk/aJ6oV3RAhEx29r+SBKYMvqTZHIigPJEh3T/ZoosPGZaqInpKpAEahnV2/rAupzBeVpLWNqonIEuy2BFS8Pu6fGVrlpHDjDLwAGf8n3RSBJbI+O7mvngOHHQ89Mf75uDllEiSl+YM+HzLT/Pka8tE8E5oZpQwJQlVrQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLPM+3erz7mBVPknGqWVbH6ezSNRofaNap9nRi638BE=;
 b=b4iEXTCdmHpgov0iajDldN3NT2fdK3+1UT6OyhNpJugONSormg9vfOK25dIKalIe+Thynl8e45D9M+keOQX94r1WrhPCvRHX8QmbBurxA3cjjsHQjVNHdq8C+C2IhIBfaMyZmzDNXKJ9Z6yKyHt916Q7q7LiASAIaNCo+x5nmc6UBx0KPu5rEjWVxoDZtJxBcjJ6zOmtvd3tX5iQWlQH2FlU9TaJ8ZDxNmIRT90z67Ni4fXtDjqOgx7IbbnIgpBn+HzrDgC6HhDk3t8UY5X03LbGabOCseVJcwoZPpPNruL8kflYr6PB5rgoBZQHW//bTjKfIWlHuBU/tYlauya7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLPM+3erz7mBVPknGqWVbH6ezSNRofaNap9nRi638BE=;
 b=jLKDeRv+d+nj/YeT5pNpCsVdiBsP7YymjztIC1+E2ISOA19QRQYdIN8YMHOZg+I746gfKMlzWUDGhi4KSOgb+PxaqzIFHMjuDO9knh4PGKGbvOI0XGTXo+bzibnOKEK+1XzlOqmKdkcMkHM+VOmjH7W8Kx6LKhE9Oq3JUghn4P0=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by LV0PR04MB440715.namprd04.prod.outlook.com (2603:10b6:408:3fc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 01:06:13 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 01:06:12 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 0/5] hw/riscv: riscv-server-ref refinements
Thread-Topic: [PATCH v3 0/5] hw/riscv: riscv-server-ref refinements
Thread-Index: AQHdd/9c8K/heIFffk6xSLCGg1rKkbc2JqqA
Date: Fri, 20 Nov 2026 01:06:12 +0000
Message-ID: <7a8f7b86bb08bfa390aa65ff396f00625404097d.camel@wdc.com>
References: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|LV0PR04MB440715:EE_
x-ms-office365-filtering-correlation-id: 4df139f8-c38e-49cd-dda8-08df46a2785c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|366016|376014|1800799024|22082099003|18002099003|11063799006|261022075727099003|261026140227099003|261022105027099003|261028144727099003|56012099006|10067099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|38070700021;
x-microsoft-antispam-message-info: Q2ke/ScfluVwAW5Iq+G741HghT86Y1I3F6o+j1hcMX+GZsBCwejs+YDRiAiH7WsA3Bvd21KboqiZ6qp4G04cC5xYYzcB0AqF0VMkG3VQgnM4akf6eOGZP2HGntK/vvleUCi2VxALkEeMlF/RXMakoLxbvbM4Agd6mNBXUzhvyxlstDePisfJSZ2WmoZPwVe2mYqvK2BCATa0Leu6Ynf0TIdc/X31KXu3UavPH3URkFPKnU2pINq8CRwCyLAPNmtFW5oixP89l8kJFxDuMg2Evfox8RVqxPJ7ZK8Lly3KptzZeKYu9ON1VPDGyJbXEBW0f5rMDGyeHBSLkaLdk+cS+9AnT9maT9lxW2mEMyrnI3KUXkjqFe1rlAcP7+w0szgwjvwPulj6n9++Cbop04zfblM4Nd77DntlIJGO8jqipMpE0gRyuolzYhL3GuRwAbDGnc8CawqnBktYN17d7OFstdhqQodtSqWHaEdl6XBvbbvvrD77tVDssXumpcBjeJAQQ+sS6gRE7a6onUNIhLCFhsxZQsTZVorJQsjgGxj4KzaeJHBB39vxUX1bqEucBKA9bFI7F7mYMSRLRL0rO7reYHEnwLoVsDNFV0jVJw+eXwGU0oCULVPS/DNji4Ms9MUVNYHQ8TUGgVe4hLR4KSBdD6IsGNyXLDrFAjq5cAZUCi0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckhDeUpPbUY1cDc0NHFUQUFRNWw3QXdmWFN3TlJ6RGprZVJ1VFUrMmZUbTBU?=
 =?utf-8?B?aExWSHM3TnJyZzdYbmwxN29UeDlCNnJ6ZFJjaGpHak0yZHB5RXRqd3MyNEh1?=
 =?utf-8?B?Yk4vQitwUFo2L2I3ajkyTGJwcG1UTUU4U3VTQWFDcGpzdExIR2swZ3JQWU1H?=
 =?utf-8?B?NkRLRHNSQmpFZ3ZycWwzNFFjSE1qWjQvZnNLcnVUaEozakJNcFRUcFA3cXNI?=
 =?utf-8?B?alhKYTMxSXNxSG1TYUNOY2Y2ZkxjbWJuVVNJRkFlZ3ErL2RYVFdVOGorMVAv?=
 =?utf-8?B?bGRnVEFnbXByNEhOTUtCSXNhbDVCZ2VUVmI5ajFjcjZBQ05PYllEMVhVMzl0?=
 =?utf-8?B?bWo2bVRud1B0U2RBOTBjSjFlaDh3dE00Q1pqQmJoUGZYVFhZU0wwa2xRTUVQ?=
 =?utf-8?B?NXVOTUpqUG4yQStKREVKZkc4ZjhKL1dFUXdYeUwzYklPeXFRQzVEanh1eTVO?=
 =?utf-8?B?OHZ3N3BrWE5kazBiZytLREJzSTdYdFR5aElKbkRtOC9XL0RCNWhkVXZ3UG1t?=
 =?utf-8?B?U0RoRnRDQ2tVd0twdDVtSVNyNmZnNHYycU5tT2lLMUVwR1FUbWU0bytXV0pI?=
 =?utf-8?B?YU4zQ3VaUGs2YklWeXVYa0szZUNwdmwyTGd6UEVuaUs0Z1orbHZnN05iajY5?=
 =?utf-8?B?Q1BnclJwQjhNdEJ6ZGh1ZGxneGlzY1M0ZEhqNDVZTlpEYlRINWd4ZDZMR3NQ?=
 =?utf-8?B?VUtFM0tvc1VGaWVwVHc5aVdWMmwzNW85U1F3RWVyWHd1cU1CM1R1S25ZNTJl?=
 =?utf-8?B?ZjlHZFdQbVhCYnNBbzNQNjVIYUplN0h4NDVtV3F2T2NPOEl0Mzc1UUV1d0lX?=
 =?utf-8?B?WE42RUNaek1TUkZZUEp3YUNwVDJ4c0l4N2tWQndFcm5WbzFZZ3VnOStyK0hT?=
 =?utf-8?B?elFvY2VZUk5jS3c3T0JzRVFnS0g0ZVo2aDBHR3hwZ0xmMDY0QXhOdGhZTUwr?=
 =?utf-8?B?M1RtekJ3OTR1RTd0NEJrdS9FcGMxdnludjNXbE9NNXVRbWVuejEwUVdpTStj?=
 =?utf-8?B?b0p4MFpvT3ZGQ0UwMG1OMGx1bk5hZWVuVFJuOWM3ajFCWldTYU9kOWpCY2ZN?=
 =?utf-8?B?NWJ6dWN3dm5kckFPU3JmT3M0T1dISFhMc1hhRWJUaHhYOUoydDRXYnNRSTJu?=
 =?utf-8?B?ZEdWZUV4T1ZRN3VKVURMQmJPaGlaUWZ6WDduSHRoTnNQMVRZUHRCMFMwWEUw?=
 =?utf-8?B?MXpPUGY4dllnZnBiWEMyMGJ3SmwySGJOV2JqcDFONThVc1FLWEZsV3p0bXFS?=
 =?utf-8?B?dHBiZHVleEc3b3doWFR0QVRLdHQxK2w2MFQ5ODQrTlNyYmswdFJLNXRLTjNo?=
 =?utf-8?B?WGFZenVLYTUyVkN4dXpuYmJJL21sTE5oQXJhOWw0eEIwWE1xMUh0dUt4YTlQ?=
 =?utf-8?B?eHgxQVhHYVVsRkZFVVl4NzQwaWtIdDl2c0g5V3haRzV4OU50N296YllWUXBV?=
 =?utf-8?B?K1l0ZzRvdUlCQ3BBeElWaU1pYXpMUmxjRkVvMHROeTg1MHBtazh5ZVpUNzkx?=
 =?utf-8?B?S1E1UkJPcG1yOENoNUdiWk1JaWpZSXlZalFaeDQ5VFZmMFVab2FERksyRzlx?=
 =?utf-8?B?OGN1bURCcEhacTc1bHZ1NVREazY5aXVBaXc4YkRFMlJlbmhPSVhPVWcxZEJM?=
 =?utf-8?B?SWxmNHRSTnptTXNJT0s1QTVBNlZZeVdhd0NRYnJzTi8wSmdEM0JFMVlOdGxk?=
 =?utf-8?B?UEpKeGxNdkZOYmo1ZEpDUXg3TGp0eEo2cEJsQkx6eGpsdkp2UjJSNFV6Z2hF?=
 =?utf-8?B?Z3V3RjdhYzh3NzRsb0xKWlJOTEJnbkxzcWpWcUNDNFllZXB1dDJWalJVMUhB?=
 =?utf-8?B?Y0hyaG85eVF1TFNoZHdpemFCNk5RcEhuVXpUL2V6QjIxVHMyRmNNSjdJZ0pq?=
 =?utf-8?B?eE9XQk5sNk5kY2VCR1IzNjVSa3BYM2xUY0FRUTFmUjJpcURva2NCdU8ySDBK?=
 =?utf-8?B?RGRXeDhFMGF4Yjc5M29MbDlvUGpNSkJCampnOWllSE5hY0EzVUFCUFQzazNI?=
 =?utf-8?B?b2RiRThScHNvL3c2clZ6dlRPbW56RWRoL0YzelQ4SVNHKzFETXVDMVAzNGIw?=
 =?utf-8?B?TmhOUVNmZUZ4YmJZMFJYTllwbFQvUmNPVHZQQnkxMlZZZFNxQ0M4NXZUZm1s?=
 =?utf-8?B?Zi9EUmhzbDRlYmlQTlZvdUpUUDlWTlhoWE9uVkgwWDYzakF2NzFUaVlyOWhL?=
 =?utf-8?B?UXNVN09LYmpsdG1jdzBPUEhBYjNvN2gxOVdVWC83RGw5NFZSdnhHUmFLY1Rz?=
 =?utf-8?B?RFlWVXdnWmhKdHM1K2o5cGIzMlZqeWdYS01KQTlVa0VBdDgvS2hJUERMd25F?=
 =?utf-8?B?aXZIWFBkME9ZdzlVWW1nUEVPUm1vV2hlSFBPcEExSGdDMUtuMGZEa2NJKzFn?=
 =?utf-8?Q?kyhj8uCLYs1t62roPshJAO4IeB5et7Bj4I0Z763Vi8RK3?=
x-ms-exchange-antispam-messagedata-1: F9yOr8ioqdschMV4JMaoQnzssfsGXFanaxI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40CA1A8F27A37F47834DAD2D2AA9F079@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fONwOQG/MoZpvxTXdllwWpcrBLZvtlXXCi0qjPjwjRqDXwBYuoR/Uh8WGbehfhBH3TIL/NQvf2R4pP0utGQg2qO6DBN0amecRZphJ/k9f3ykVmDedaSV8obRR+AksB7mWf0gVDo+Ie9xRhcDHKZkZpqWTl1v2r+JIaZ9RX9eOSaCFe0/B82u8aFI2du/PFXB8RFtLWk9gmVgshvPrjR6dJx4kYlI2SbMdOTuoHAJGwC3+tnAO3lpeiVPr8qaounBgkkMzhEaSiFfHk5GyWS9lh8BLZkpojIGZe7tqHALdSnUr6BsP5in6N2yl9W1putcfsIehhs1FdQLzqERuQRleQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EduhvR8Ouy/Xih4x4XWun9nKMEJZCLdLFrMriynmu1v1lH2Tu4IWbskjZFd5035LCA2Dn06YLhvJsIxqpYZRU4BlkxI7XinBMD1rU2OEocZP6AusDo+Yd9thE4mdWpS3RThG4pCArITUD4imF9ueRymk9Ti50u96rfiDxzlTgk2FWr7PFVftrfscS6IEFWVa7Cfis1I58m43ydnCkyyZ7XEA2UR6qGBL26cxNrzQw7N5DqYpy0Ngg5QcRwUNIFuCgDfpMBOlMLzTu97co7i5jkxF6o2EkFNgPMCnAZiqRxKynassskKR6AKxVLo1CGJ5nUPiW+M5JIH8fMEOLk5ERVb0RCHi1PqyLrpgzqY2s+ijIuxTkcDdrU/DwSbJ7YSisiSsywTON8nSL+GNGggoMJC8w48yO1vwS1PZWwpzjJsoeAQgjVPMn1HOfyRF2s8Ou8JuekzRxVk3X9nBEicQgNRzYAkxli7zwDGiwD0i0xpeCIMTSM7wBZxPBZ1GjiVfFTP/MqL7pTOkZo2kE4iueuXTv5WPHNyWH+v4F33WsFE0X0skXFpg4tOV0KFAymbPrzndYX9AmtCBOJbJlAVVDIZlzGilZqCtxn/ATFuSMQWv87kBFSPwUM5+3yS2xM/E
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df139f8-c38e-49cd-dda8-08df46a2785c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 01:06:12.7793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTMwpLNg3XdNjhp5fMUdPyfWuoJwxLuOapJBo/7cD20L2DXASuaO6M28+T9LreedTiTjHUWnRb60k2cjsOPr1PeM7umL3WnvKAULaTnxJK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR04MB440715
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=7773dcc14=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTExLTE5IGF0IDA1OjIzIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBIaSwKPiAKPiBTYXNoaWtvIHBvaW50ZWQgb3V0IHRoYXQgcGF0Y2ggMSB3YXMg
bWlzc2luZyBhIEZpeGVzIHRhZy7CoCBXZSdyZQo+IGFkZGluZwo+IGl0IGluIHRoaXMgdmVyc2lv
bi4KPiAKPiBIb3dldmVyLCBTYXNoaWtvIHdhbnRzIHRoZSB0YWcgdG8gcG9pbnQgdG8gYSBjb21t
aXQgdGhhdCBpbnRyb2R1Y2VkCj4gdGhlCj4gcmlzY3ZfY3JlYXRlX2lvbW11X3N5cygpIGhlbHBl
ci7CoCBUaGlzIGlzbid0IGFjY3VyYXRlOiB0aGF0IGNvbW1pdAo+IGFkZGVkCj4gdGhlIGhlbHBl
ciBzdXBwb3J0IGFuZCB1c2UgaW4gdGhlICd2aXJ0JyBtYWNoaW5lLCBhbiB1c2UgdGhhdCBkb2Vz
bid0Cj4gY2FyZSBhYm91dCBocG0gY291bnRlcnMsIHNvIEkgZG9uJ3Qgc2VlIHRoYXQgY29tbWl0
IGFzIGJlaW5nIGZhdWx0eS7CoAo+IEkKPiBwb2ludGVkIHRvIHRoZSBjb21taXQgdGhhdCBpbnRy
b2R1Y2VkIHRoZSByaXNjdi1zZXJ2ZXItcmVmIGVtdWxhdGlvbgo+IGluc3RlYWQgc2luY2UgdGhp
cyBocG0gY291bnRlciBzZXR0aW5nIHNob3VsZCd2ZSBiZWVuIHRoZXJlIGZyb20gdGhlCj4gc3Rh
cnQuCj4gCj4gTm8gb3RoZXIgY2hhbmdlcyBtYWRlLsKgIFBhdGNoZXMgYmFzZWQgb24gbWFzdGVy
Lgo+IAo+IENoYW5nZXMgaW4gdjM6Cj4gLSBwYXRjaCAxOiBhZGRlZCAiRml4ZXMiIHRhZy4KPiAt
IHYyIGxpbms6wqAKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYxMTEy
MTIxNTUzLjQ4NTQzOS0xLWRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20vCj4gCj4gRGFu
aWVsIEhlbnJpcXVlIEJhcmJvemEgKDUpOgo+IMKgIGh3L3Jpc2N2OiBhbGxvdyBtYWNoaW5lcyB0
byBzZXQgJ2hwbS1jb3VudGVycycgZm9yIHJpc2N2LWlvbW11LXN5cwo+IMKgIGh3L3Jpc2N2OiBt
YWtlIFVBUlQgRkRUIGhlbHBlciBjb25zaWRlciBiYXVkIHJhdGUKPiDCoCBody9yaXNjdi9zZXJ2
ZXJfcGxhdGZvcm1fcmVmOiBmaXggVUFSVCBiYXVkIHJhdGUKPiDCoCBody9yaXNjdi92aXJ0LmM6
IGZpeCBiYXNlIGJhdWQgaW4gc2VyaWFsX21tX2luaXQoKQo+IMKgIE1BSU5UQUlORVJTOiBhZGQg
Y29udGFjdCBmb3IgdGhlIFJJU0MtViBzZXJ2ZXItcmVmIG1hY2hpbmUKClRoYW5rcyEKCkFwcGxp
ZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4dAoKQWxpc3RhaXIKCj4gCj4gwqBNQUlOVEFJTkVSU8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDggKysrKysrKysKPiDCoGh3L3Jpc2N2L2ZkdC1jb21tb24uY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTkgKysrKysrKysrKysrKysrKyst
LQo+IMKgaHcvcmlzY3YvcmlzY3YtaW9tbXUtc3lzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCA0ICsrKysKPiDCoGh3L3Jpc2N2L3Jpc2N2LWlvbW11LmjCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKwo+IMKgaHcvcmlzY3Yvc2Vy
dmVyX3BsYXRmb3JtX3JlZi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDkgKysrKysr
Ky0tCj4gwqBody9yaXNjdi92aXJ0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE3ICsrKysrKysrKystLS0tLS0tCj4gwqBpbmNsdWRl
L2h3L3Jpc2N2L2ZkdC1jb21tb24uaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEg
Kwo+IMKgaW5jbHVkZS9ody9yaXNjdi92aXJ0LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCAyICsrCj4gwqB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9z
ZXJ2ZXJfcmVmLnB5IHzCoCAzICsrKwo+IMKgOSBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRpb25z
KCspLCAxMSBkZWxldGlvbnMoLSkK

