Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E9606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=qegqfoxt;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=EPTI9POO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUCjI-0006WD-0M; Thu, 19 Nov 2026 19:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7773dcc14=Alistair.Francis@wdc.com>)
 id 1xUCjF-0006Vo-Jy; Thu, 19 Nov 2026 19:43:50 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7773dcc14=Alistair.Francis@wdc.com>)
 id 1xUCjD-0008N5-MQ; Thu, 19 Nov 2026 19:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795135427; x=1826671427;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=cH+vCOzIV/Cs1V25OgJNq7RLkZSoe0IqsZlzp5WM9ZI=;
 b=qegqfoxtgTyTxtVXik6uif//+6VKrPmjSD+nGBnjFH6eUEFO2x/8UrcG
 mTc+LS3kIUzKspCmng2LOSwhimuTal07F3OdCzcc2gcMwr7k1mKsegZz+
 dz6LUqajDSQ+TZkXqUHdFkXDMa1VBKXzO1ML37Ghvdq/2qZ1mGMWPzRpi
 lznrW4FJhyLBEWDWLqhuMTGSV0oOE8n4HDFKTnvr0i5FTPvCWJgOz0yjJ
 q8MWSsjCIQdzNdymSILWzfoArBoNug79oTGKg0gPoNlhaQ6rb7V/vON+B
 yuwV1zJhtZh3VGEJJwMr73EsLYx7e8tbIdgxDLSImNi48t+JvINZFAg+N w==;
X-CSE-ConnectionGUID: O8aqo0GASwCqtbrdwmCYPw==
X-CSE-MsgGUID: 7Ys8tUe0Ss2hn+QKEe/kAg==
X-IronPort-AV: E=Sophos;i="6.27,221,1786982400"; d="scan'208";a="162304732"
Received: from mail-westus3azon11012042.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.42])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Nov 2026 08:43:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGy0gFTrNLvk6gmK/aCHLgS/GjIs4n9QpXkx6XQIgB1+Y7jHBN1qKnKiaIA53HiEcCWNSnu/FqRQsb2/6pkOpfK0OfzoolC8VYQPKnyG57WfvXoaLr11weW5yaIQR5l11SDlciwUKCndIKGYWndTEy2cswiX8sLPw0jiNP8Nh7cQTXeuinSr/VygwsGGH6jTCo2XUrN4naiuVDnGNNZJN69skiu25B0QtMDxb1F1a3BagiwdplDLCUcZzY/izypG4pPq3pq9gq6Fr5uN2FE1oQOi9knj2Y0FwPSCEdjmlbTdm1X0WKKo0HP5SZLrNGq0E+0oBlPJxkbec3umi6Dy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH+vCOzIV/Cs1V25OgJNq7RLkZSoe0IqsZlzp5WM9ZI=;
 b=EyTBN0i/OMrP2lpCy/Omsfuvm9KflbIDu2lVV1BXJelxKS9yjl1CxJoYhdJm/uA94p6adSqmpRvzbaGAz3yO9RnZvTZYi+powxC5JSfGT6a3baL2VG0ztmjV2gVTAXv5QPoB6u6b5usBg0TurIvQkV6CuJFMKPJeRACcUabBUA0+HsTrbCedlgX+sQcSEW8BMrOJUeR62WQofjJqAez40AGl9zeIoxDsd+4kwZIpNIT29Qnd1Y8MeR5AZ5NihZ+56sMpybIv1iM83gbTOGJNdLAdVfiSjRNc7kZw2WcEDvcamwHgmCvUpA8uBDw0iG80N8K6bw4F2L0frsZTmbiAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH+vCOzIV/Cs1V25OgJNq7RLkZSoe0IqsZlzp5WM9ZI=;
 b=EPTI9POO2AE6igoAZQU+KjtY6uLLIYwr0n5+0dyOWQP30n6CWPwV8uSEgUTI8/usfzsyQ9BvtFSbgDhpGfzPUHCa/VyorKogZiJY7+ZlbbDlyp9lq8CJ+6GU2N3wAH6aZLOkxHgcJX4isamV8Ip90eqynZMEl+JFAIh7UjGbZfM=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ0PR04MB7453.namprd04.prod.outlook.com (2603:10b6:a03:290::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 00:43:41 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 00:43:39 +0000
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
Thread-Index: AQHdddGKvac0S0hXhEyHiKTyzAcoSrc2JLkA
Date: Fri, 20 Nov 2026 00:43:39 +0000
Message-ID: <c74952bc365a1da74fff59c5d4c3abb7ed7dc098.camel@wdc.com>
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
x-ms-office365-filtering-correlation-id: e9ed8e55-c6e8-4c55-1f24-08df469f51d5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|376014|7416014|1800799024|366016|18002099003|22082099003|261009223027099003|261021123027099003|11063799006|56012099006|261026140227099003|261102123227099003|261028144727099003|261021121427099003|38070700021|261022105027099003|10067099003|261026121527099003;
x-microsoft-antispam-message-info: dDh+c92+AQVHisoMz5q3FZuIvOJyyuDBbLwuMmo8LPekVYPirbFYwVFP8BYLNkqRFPbTFmoPg7CDFF2svZCN86b9xHHvfMJ+UCmXWKiDPTuszbHKOF4EaTKv/K1FrWKDcRW32jFjSbjOkaccVlIWyeaby2XK2DLQfmBuDzos10j0CZqo5kPBTE4cFsdT9Rl+80bWifgZ/ouf5cikTLO/bQm3eboEuwFlLnAh3JsYhKka1T/zbG4t38YF2hOWtvgOjiIr86Tq/YCepC/rPCJNL47ez3qcaozNlP5GZNR0kAkuT2HknqaeH3QKcivEMV5ffUjNgfcIOdTw11WXuzEgA/Vbcx/jDrhnwe9Nq0fBQJEW/f0l7WNfWNwN24Ma8AdQJ+7uZh8KxptEwb1EvLltp/gpXiT5LT3h3C9fYclUrhO6L+JqCjMIZddmRY2vk8tNq5WlW0xWkm0vnWSm4p4qz2AZTf+q0ATW1UuLsSbb3jlaWuzLc+A2mGrL2y00t/sPJUX9GAvUFP38q9NpBwbVqKJyun39SZSCCVKfKx5AExUCV2qNdaBI/53WIP3yt3vE9dO54TXSUQgz7w3NnvEb9w51uc7bXj0TrdLbGNYwJFOG6UOEfNUqh5ReAd7mTwFuxTbIFZC9kTBUbcsuJpIrlTA83JSlhxBD0WvN01ipkKYto1gHiTU/29cCz7jgKlfMNsKVLoBHcGwy8cTiclFKA3zoJ5df0w6DlLPdRNHXAQ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(261009223027099003)(261021123027099003)(11063799006)(56012099006)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(38070700021)(261022105027099003)(10067099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3AvKzZ6Vkt6NmhncDg5TkFqU3AvL050SGc1alZvcDZxdkZKN3dJV0tneUZi?=
 =?utf-8?B?c0VlMk93MUNod2ZuWmwxQ0tPblBCQk5oSU01VUtuTHZKRjQ3NTR0T0xRQ2Yy?=
 =?utf-8?B?ZERDYkF4THltSnlkc080dFIzaFZJeWphVXVJblNhWmVPZXdnN2huWi9ZMG9Z?=
 =?utf-8?B?RVE0Y3FMN0ZkYm5PTDVSbUhqVEc0UXUyYlQ1WmtTbmhUT2lya0JaR3VyREhP?=
 =?utf-8?B?dVhaaUdJdjk5ZU1OVDA2cGxkMDJRcVYxdU9zUmhWZHdXY1FhYW54QUNNU2tS?=
 =?utf-8?B?ajNWckNPU2dKMjBPeDNCVzFKZnJsK1pUWEgxUGpuQmVSakNzR2Qrdm4rSzlP?=
 =?utf-8?B?NjhDZHh3NFgvODNKZzZLQWprcDRIWXl1TStxdkIzRzArMWY1Z3V5MXhkcFVw?=
 =?utf-8?B?RjNldXBYZ2VRdUxHN2FkUDBTYXU5OWR6QUtzdXlJM0FjUEF4NXNIL1FScjB5?=
 =?utf-8?B?UUplcCsrOS9jV08vM20zTHRGb2l4em8xNGFnUHVWS0Y2WDNHcmVXdC9wbVp3?=
 =?utf-8?B?Um9ncGFuYjBiTURVZTBGR01uR3lVcGIzMTViYzZaVHYzMkhzTG5EQVY1VGFs?=
 =?utf-8?B?N3hUQlp1R1ArY2ZWb1FLNHQybk5zbG80YUNwTHhZM0VxUi9WWi9KZVNXdkU5?=
 =?utf-8?B?Mys5YnYwRUlrUG5NNHZ3U3ozZEV2M1hwT0JWNEJPbEpvVVVtTHhEaVdSZzlV?=
 =?utf-8?B?S0MyVUZyTGNyY2NKQTdZbHM1VjZqTWUxL283VlNHUWc2dFp4RDhYM0JaNXpl?=
 =?utf-8?B?bTBEeVFiSXhBaTJWd3dNSlFseEpMSGw2eXliM1RwMlllUDFNeEk4R0dlMG5o?=
 =?utf-8?B?V0lWK0prY3ZQam45ekdKampPeEpyMnhCRWVkaHNSUEFXOG1HNWtOVTM2ZG01?=
 =?utf-8?B?MHI3cU5lSmhtSW5FOVlGd2Nmd0xrVG5JMjFia1hnUlFmZXJHK0I1RkJZMkxQ?=
 =?utf-8?B?dC8rMHNHVDBXZEp4MmY3YitCa0ZwUld5Snc2MVNLM3RGWXZQKzJmL3M4eFpN?=
 =?utf-8?B?VkRVR05hVTIxTU5ybE1BcFgrK25vNHhCL3lydXpEaC9JS2hnMTNndCtabEc4?=
 =?utf-8?B?c2FvRzNYSytDNE85WEwvN3NMc2dSUDJNZXpKejBsMDJ5VGFzNmF2eVY4M3lJ?=
 =?utf-8?B?T0pEVkFqQ1drOXk2bU96T1ZTYU43aEtjODhQbjVPUEIwYVlsL2swYVFpQldM?=
 =?utf-8?B?dE1XcFpCQTEwOGZlQkxMVGRzWExPbUZhZ1JtdGdKQ3V1ZVFEaEd6Q3ZJSC9u?=
 =?utf-8?B?ZDhyZlZveWRSd3JMd3ZGckp3QWtVVnhiRnRlaWJGUkNaTDkycVp2dDNVRU5H?=
 =?utf-8?B?NGZkOGlaQUVyTWRyOEcvaTIwdGc3M3NnUHp4UnlsaWFTbGdaS0FyM3U3cHRu?=
 =?utf-8?B?a1lzdzJTcmRRanNJZFFYbHdWOWZ3eXhaVEZiQmhJQlRwNHp3L3JtbnM0UlB6?=
 =?utf-8?B?NVFocE1Icks4QW90emZwd0I1VEJwOVJ6aUNEbXlBR0NoY1NFeTQ1WFRTenRJ?=
 =?utf-8?B?dlZnMlE4VE5LcEwyaHlTY3lyU3k4a1FsZEFabVhBa0szYk5IalRqbEFYWngv?=
 =?utf-8?B?OEwzSENzdTBvY2hzeDR6OXRUaHE4L1FnUmQ3OEhCSHVXejg5MTNuRUZtVFZQ?=
 =?utf-8?B?M2lsUklWMEs2Wk1kZGx2T2xTN09ZQ2FaWjMyNVV1WEZYTEk0WnpTOHRQVTB0?=
 =?utf-8?B?d3o3cit4WWUrTXRRZFhGVjFGMkg5WlI3TkFNMzAzYWFZU3Z4UkZHZGRRRTd5?=
 =?utf-8?B?REd5cXE4MGtzVkFCV1RDRnlOaEd5NW5PaG94SjhldE82MEsrYStEbktJclpG?=
 =?utf-8?B?endFZ1hnR2RtZlhpS0JXclVwR1BNeUJlaFNMRHBpWkFJVktXYUlRdmdReEVh?=
 =?utf-8?B?dkQ0NGZsLzQxWjJvNWtQTkNkT0h3V2NRQnlsNHFxWTFYWmlRRWd5NWV3dC8x?=
 =?utf-8?B?Vy92cWVBekRUN3VQd0haa0hCNjRCaHE3N1hrZnl1aGtxdEs3Y0o1MFMzQXZn?=
 =?utf-8?B?Tlh5ajJtZXd2bEtsUVpTTjFBczZYdVVNT0Rsb21VbmhwNVIwcCtNaDZ4VlFo?=
 =?utf-8?B?cm1IeHZ2Z2JhckhrRWZmcXo3WE1oRUQ1YlJvTXRBbHByV21PRUhyYVdEdzY3?=
 =?utf-8?B?aDZ0NjVocXlXcmtKNVVmTTFldVM3TnBHMHU2ZVEwVndRZDRwWkROS2Q5VFl3?=
 =?utf-8?B?UmRua0hMYStackZRdEE3bTJ4K1VjMFZIaFFoUFcxZXVwK0FwUjlIc0c2YU5C?=
 =?utf-8?B?RUhtcHl4UFFHQ1lXcDRZRFpJTXBRRjlKSGU3U3M5c3lTc2V3bzZsOWxLWng0?=
 =?utf-8?B?VytXaVdNaWNLU0xmTHlXL3JRbmhQK3Y0Y2ZWZzE3NDdtc0c3U3pZRHFTNmM2?=
 =?utf-8?Q?yQo+4G5oaSv2sjdo0I/jwNag9dLhoLtQLujv7VyGfIP8t?=
x-ms-exchange-antispam-messagedata-1: EBTkc92/4jM3Eq2CHHNKSMcBh9zPtBvqk9k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94E18EFFDAA7A842B3B4B5679BCAE38D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: u639ByDw4P05QoUKzSNOr5S1L07vngq2JyX2fkoKUk1KafFfQy3PlyjxMwhE+zsmhpKql2YKUfGCaplJGCGh0ApBP1ufoECHQxegE9oklF/YW3qV9X6uWbZYKaK44FObyczeCY6AHPie39qG/9dlYqlQOJJ6f/qNOD9AENttXjlYlV9OhhxFzdGz7iT9l9U4M7S596yTaYUMnzvA+KRseuT+WDoV93xJEVK4AZTSXi0IEp+zg7zWvHKY8wdMUnbEVU5OAv4/intk4upXQmuAegn4YOeP2b43hVEChoI2EUQFP+I+uOzslvr1zkBg+onBwfRu1s0otUmn0H7MUSez5g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3PgNp8g1srysHKRxiWoSkORKJS2kLK7oBfx4Ofj3RrgU0FPpDq9K0kQVncNQcnJdr9ADy9P7ZQXNgyVDrhU8ihVjA2L9Cx0bNm09KmcsPV0FwcL2PrWSvOLBT8mPBxJtwg/wiI6gcMDGOHCD4OUo6G+6Gop/R38NwzwWJiRfdnLz2HK/co8Hy98RuBEgvfrHj652YGBhbCXcAAr6b256TsiSselzfdSsXwb9S8/qijCceylOPQlYTlG3nph/gsGOiXxRGpYjPgd1XEIKBdOmFtN+2Ldl8EcNKWwS5ECY+BEQHMV0CraKNGv0Nc48bK67jW5BRzUNw+9FzI+nqpgMhefnpekJYxrJPxgGM+TDS5oVJtu33kYNjqGm//MxK1sIiJDHQNaz6kwz3x3ozxlPplGr6PaBIGapCeUuUGdttmpJshlEEss61dzv8G6AIlQxfj+Oj3ySbTCIyCemQUG6t0SDQqJJ86FOtz/TTTR3r+XIalfQRLuZl7YoG/YscFBbAKfM4AwTpB/huLiE9xqJYglEIFfOnBrk3JV5KY2aY++PnGaPUU7mLJJw0dvlvK/BxX8KPDrDZUwM86CV6ESJDvVIjvOhdl1aYTsJCvPT2a+fTae426fbGh/qsAqTL7JC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ed8e55-c6e8-4c55-1f24-08df469f51d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 00:43:39.6190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1PhPWzq6UwDKk/Qbrc0FoDi0s6S4cwYZHwCd9TSfRlxUFmmYzE/p+wsLB130IF+IbiZQVi5XS4VqvBSkphmZFAjzjiKOK7OrUzHW5F7LbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7453
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=7773dcc14=Alistair.Francis@wdc.com;
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
aGFyZHQNCj4gPGhlaW5yaWNoLnNjaHVjaGFyZHRAY2Fub25pY2FsLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3Rh
aXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYyB8IDYgKysrLS0tDQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYyBiL3RhcmdldC9yaXNjdi9r
dm0va3ZtLWNwdS5jDQo+IGluZGV4IDViZWI2MDIzMzguLmI5MmY5NjE5NzkgMTAwNjQ0DQo+IC0t
LSBhL3RhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi9rdm0v
a3ZtLWNwdS5jDQo+IEBAIC0xODg0LDkgKzE4ODQsOSBAQCB2b2lkIGt2bV9yaXNjdl9zZXRfaXJx
KFJJU0NWQ1BVICpjcHUsIGludCBpcnEsDQo+IGludCBsZXZlbCkNCj4gwqDCoMKgwqAgfQ0KPiDC
oH0NCj4gwqANCj4gLXN0YXRpYyBpbnQgYWlhX21vZGU7DQo+ICtzdGF0aWMgdWludDMyX3QgYWlh
X21vZGU7DQo+IMKgDQo+IC1zdGF0aWMgY29uc3QgY2hhciAqa3ZtX2FpYV9tb2RlX3N0cih1aW50
NjRfdCBtb2RlKQ0KPiArc3RhdGljIGNvbnN0IGNoYXIgKmt2bV9haWFfbW9kZV9zdHIodWludDMy
X3QgbW9kZSkNCj4gwqB7DQo+IMKgwqDCoMKgIHN3aXRjaCAobW9kZSkgew0KPiDCoMKgwqDCoCBj
YXNlIEtWTV9ERVZfUklTQ1ZfQUlBX01PREVfRU1VTDoNCj4gQEAgLTE5MzcsNyArMTkzNyw3IEBA
IHZvaWQga3ZtX3Jpc2N2X2FpYV9jcmVhdGUoTWFjaGluZVN0YXRlDQo+ICptYWNoaW5lLCB1aW50
NjRfdCBncm91cF9zaGlmdCwNCj4gwqB7DQo+IMKgwqDCoMKgIGludCByZXQsIGk7DQo+IMKgwqDC
oMKgIGludCBhaWFfZmQgPSAtMTsNCj4gLcKgwqDCoCB1aW50NjRfdCBkZWZhdWx0X2FpYV9tb2Rl
Ow0KPiArwqDCoMKgIHVpbnQzMl90IGRlZmF1bHRfYWlhX21vZGU7DQo+IMKgwqDCoMKgIHVpbnQ2
NF90IHNvY2tldF9jb3VudCA9IHJpc2N2X3NvY2tldF9jb3VudChtYWNoaW5lKTsNCj4gwqDCoMKg
wqAgdWludDY0X3QgbWF4X2hhcnRfcGVyX3NvY2tldCA9IDA7DQo+IMKgwqDCoMKgIHVpbnQ2NF90
IHNvY2tldCwgYmFzZV9oYXJ0LCBoYXJ0X2NvdW50LCBzb2NrZXRfaW1zaWNfYmFzZSwNCj4gaW1z
aWNfYWRkcjsNCg==

