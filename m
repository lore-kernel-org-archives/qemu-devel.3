Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA4606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=kTZI0Ryu;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=WElzp0QB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVMZg-0008EX-MS; Mon, 23 Nov 2026 00:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVMZf-0008EH-1G; Mon, 23 Nov 2026 00:26:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVMZc-0008Bz-Tq; Mon, 23 Nov 2026 00:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795411601; x=1826947601;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eB0XtaERVvjHNOIeAGWwBo2q4k/Wg6xxgQ5JmweRUJY=;
 b=kTZI0Ryu0K4y5G8tIKJBCNZJPnTx4VCkv8zaOGnLTPwA3vg1oGHx1A8P
 HXoRQyrFFVAzIBHJQYWfCsqFTMNX5lXiRQBWwBMoWBmdQd0zyWnBMqgk9
 /C74fpN2bW0jk/vTCq08jhSr/aEXh1KfpHQgbw8U00J5ERNbxVErppwv1
 RvUcHyOcKW29hkBKRXuKd8hDi2HcibrB34tzyiapVBN1XbDoHxHDcP3bd
 mR+ThIswcIHSqmLG1jsPys0gcHvzr1n7hDQNgwOL6rjUnZ++Zn2+QqMPS
 0p4btS36VCkqMTWVkgAqqSOkGn/y3H7/CvMTErSEp/bBWl6XyZieTUKdF w==;
X-CSE-ConnectionGUID: BukphGllRmS6/E6whJUIEQ==
X-CSE-MsgGUID: 1qy2k1esRyaeDYULxqTpaQ==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="161532436"
Received: from mail-southcentralusazon11011047.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.47])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 13:26:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tfxaw2G8RzKzbr2f9lB9M8Mn7pk+qAFdvgTnPeKUIK1X7ZL58MFo5dlhnArPYjnAU3CjeKDKBqkLALz01e5zV2IxlD04pO4xSEi/TVqxasiu776ZM75bcYXV/8JQ/PhCmraMbRYuBF/cO03p/bGm2Mm1gK8vqkvixxVDmt+H91cuM8LBYuVg1p7dlGkFi8AQZD/kk0BqhVx++UDyV5SjUJTyMWAkkr5O+eJknrDWMCXZVLnFqPvyLBRm3EACLduCfucdFrH1pJk51yIFvyvJAUpeb0AYSwVHdGzbDpRTe/dXxesqLi4VvPXgHiWRimms1xSL9hNCmC27MNyKNoxG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eB0XtaERVvjHNOIeAGWwBo2q4k/Wg6xxgQ5JmweRUJY=;
 b=Gigd9+z1AQIKIEbsvaXHeAMxeC6XWvZNs67r1LtWwyXNL4E8j8DQBJ8YOX1ab3MqfvTdQYLZkzd4HVyN/OiY3DxvfwbaK3fxBSQpBHfAZoAWe3paZxis9m/xBEJUUWt7Zcbf28RL8cl0nG8Q3S46Uxr3WqdOVpvqux7KGr2quNnmYXiN+gjlf6BPzdbGNkK4H7XmvyxTS6T9UxP2+uFrWA2MONrBNPlTvuNmcEOu225DU54Bxwk4yKgIwCa0cwb4pzX46HWba5HKklCi0cDzHOZbgxigU9SbPLVdEraXq/yw7ViwhMvlHsufGVOoI4WX+rLOXYRivpLJnFJCB9K5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eB0XtaERVvjHNOIeAGWwBo2q4k/Wg6xxgQ5JmweRUJY=;
 b=WElzp0QBadBfLXPui61kdcpUMI5g+yolsGV+9Ck+brFyd4bT3dnO5OHUtnmeHYVJKe5XP/MhGK5R/NRw02EkxZEt8/tIf37H1dXC0yVyL9mAM19+pZLvuAiu79ClYFlwMQ6JJyvNoEIEsENpuLHRp4iZnl9fiWmBDjDMjkPdcjs=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB7026.namprd04.prod.outlook.com (2603:10b6:a03:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 05:26:36 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 05:26:35 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "bin.meng@processmission.com" <bin.meng@processmission.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "sebastian.huber@embedded-brains.de" <sebastian.huber@embedded-brains.de>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "conor@kernel.org"
 <conor@kernel.org>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v5 24/26] tests/functional/riscv64: Add Icicle Kit
 firmware boot test
Thread-Topic: [PATCH v5 24/26] tests/functional/riscv64: Add Icicle Kit
 firmware boot test
Thread-Index: AQHdbHNAmJFyoe47bUyuvxYH6kh6w7c7PYKA
Date: Mon, 23 Nov 2026 05:26:35 +0000
Message-ID: <e8721b4e381f6159d320e953a471e28282be1509.camel@wdc.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
 <20261104154207.641511-25-bin.meng@processmission.com>
In-Reply-To: <20261104154207.641511-25-bin.meng@processmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB7026:EE_
x-ms-office365-filtering-correlation-id: 690ff4d0-5204-41d8-c7c7-08df492257bc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|10070799003|261009223027099003|6133799003|260925021311599003|260925021911599003|260925022911599003|22082099003|18002099003|3023799007|261021121427099003|261022115727099003|261022075727099003|261022105027099003|261021123027099003|261026121527099003|261026140227099003|261028144727099003|56012099006|4143699003|10067099003|38070700021|261102123227099003|5023799004|11063799006;
x-microsoft-antispam-message-info: ieLoVBIejZ1xtCbGpBSPtnpziTn+Absy+O8lMfTzJaxnLY7ZS5n9LaGa73EB19DkbzobwHwNiNMXZMlDLnrehGMj0TUOlfN7OYXWh8tpP3Krg+n4oIZn0uvZhn91+z5ddzbMKt9YYhCg9naFuQiAkcXfymN5SYti/NjYv7DFzJb6OsK6+PmSKbwvnKGh/PXo27+UfGDh91W0p1SnwjWlll2K7wlBe92tOEGlhD1jdowMA2I9VX0yBGFkNgEOJL/PI9roT4ci4KQUmudWsbRgIO8Cto9Mf5JjNXvxnc+tkeBzlg5jEvjp2UpzQlTahAAMdUTkHpUI3nKvs/PPvhyIQO2kBSnnFxbPsI+LQMrl37ce3PzosmWGw8q4VdvDN9BIt1FBRQ0yfveQGP0/WasgakQx10oEwM9cdysSlEtVxc/OxTq4Gb22ZI8dRRBVz16turwQ+DwaEz7snZYTvwndJHGMoiIMOAs6AySNE2hmUruapVEliqfZKrvhZd8aoc0Qf+7mOyckePAFqCvPfZ2AIca1SIToEl3szp+a0iAx2DGUVzoX6btSWzZhVSR980HLhmgHoPWDCPIymfoFTL8jYFaKyAWabuBfrTv6fmgEcDgVDZxZFoDzzF0LxjntAjv1jnCXcHWZLd0plOYNdC1n1OPIDT7LQFSZi0DnUvj++YzhMDHYxxc+rwmGhXm/6r3FMVeyMCwECPuhc+efj9tcgTnrkeLrxbtYFeofejUYu2k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(10070799003)(261009223027099003)(6133799003)(260925021311599003)(260925021911599003)(260925022911599003)(22082099003)(18002099003)(3023799007)(261021121427099003)(261022115727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(38070700021)(261102123227099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qjh5TzdNbFdFQVMxNGd2a1o0WUxKbytweFFrT3RvZmE3MGdZWlA1TDA2Rmxa?=
 =?utf-8?B?Zis1UENMZUFyNk9COXZHSUZBRWJuUFBEcDV3bDlxMnFKUnlTMzRybzR2VVFo?=
 =?utf-8?B?UkgrVFgwMXY1SndCNDVreXFVVUdKN2FrdFlLVGJpWGhiMlZYbGNvU2NWNVRr?=
 =?utf-8?B?WUZweWQ1RmlkRlNIRkZSY09vMXQzQ2VUYmk2N1J6Y0tjWnVyZ2JsOVZndnNi?=
 =?utf-8?B?YURkOFZFaHN4cnNnSHljWm9Gbjl2U2R1NmlldGJDWU96UEZuQ2J1SC8zcXVl?=
 =?utf-8?B?eHVJN25yUEhidHFPNURGSDRDRmx1dW1wM3Q5dy8zQ3duNTFqeEM3OGd5UEZR?=
 =?utf-8?B?VXFUUUk2a3ZvRGJxRjJmYy9MUFJjSFlaRGgyVm5zY0QxdmFkaUdRa0tWakRu?=
 =?utf-8?B?c3dNeisxU1dZK3BVQktHMk41OERRZkl6VVY0SGFEVVZIQXg3dkY2dVB5emV1?=
 =?utf-8?B?WWJMYXBqVFdjQVVCbnl4djdDZlY1SndWaXlXazhlZzJ6bUtHb1NURFBXNmsx?=
 =?utf-8?B?aDl6VnZoTFFNcS9uWm5ZSVgyUmlVZmVHcHE0K0VRMkYzTWd4clNFMGdEbzdJ?=
 =?utf-8?B?S1Q3QU9lV0tMcWd5eVUyR1RnRGJ4V3BrUVZuTDdqaFQwK0FTOHEraG1nS0l1?=
 =?utf-8?B?WUdLa09hTXlLVTNacnNjbktPTi9LVmRGTGN3QlB1K0E5Z1lTMm9Md29PREd0?=
 =?utf-8?B?M1RtTUwzZUVGY2lGOEI0WG9wT25FWmFERzBIakZxMFBjS0pQcnVIbGZFK2ZN?=
 =?utf-8?B?aGhSZkpSVnpCaWkzbTVHRnZUZzJHWWlBVXRvYU9xUjZNZmR3SERuNE1EdHVi?=
 =?utf-8?B?SkRsWUlBdTRzWDl2ZTI5eCt6MkM3YkkvbTNaNmJEcnVkanBpbkRTWDJkNXNI?=
 =?utf-8?B?UFEzWjdPZ3dxWUJTR0pHV1ZIVzZpaDZzR2FtNExCRXF5SHZFQVA4QXVOOE1Z?=
 =?utf-8?B?dVExTi9hS0Zmb0FRckw4RktmUzdUUE44emd2RTNDOUZ0Mi9rZ3phNGxrWGxl?=
 =?utf-8?B?SGlIbFhWUjhObWRHbGF4NHNpOG9pcVcrRnIzbEdUQTVUakkwcDV0T1lHcFRX?=
 =?utf-8?B?R3NWcWRCa09Ya0lhZFZPcVZPMnFSbkc0S3NLNjZIRU1aWUZRQUZ3eVBSeUdN?=
 =?utf-8?B?cUplMDFhbUN4WFg2OEVIeXZMOFZDYWxseTMyMDBlMWhhMWozNVNvejV0czdF?=
 =?utf-8?B?b1VycUZWcmEwazVBWFpoZ1pPSkFUdWFQS2IrZ0J4dWNrYTVQQW5ja01nZTQ0?=
 =?utf-8?B?Um8zaE51dStDdUNnTS9jZDBQZlhCK1UyMnZ0U2R0YUF5MlBIb0Q2U3BjOW5H?=
 =?utf-8?B?Vko5ejJrcUpRaDNTUmE5U01MakNLOEJJWFhYYTROY05kbEZlbzlPdjZ6TzU0?=
 =?utf-8?B?bU5UcENoMkhTbWZlcUFGa2tvVitXZDE4TkFpR0pEN1lmSjYrLzdaOTM2KzJx?=
 =?utf-8?B?eUh5UEVMOVNHTllNUlFsd0VyQ3d5aFdQNk9ldVhXcGJuandvTGVEY0k4OEdJ?=
 =?utf-8?B?SXhKN3FrUlh3eEJPa2l2V1BnMG5ucnQ4Ry9nL05vZHhweEkxenRNemhaL2Vn?=
 =?utf-8?B?a1VJUzQwbFpJRkZkekR1U1N5c0tXTndRVzZIa0YzclpZbGlRdG9lSVR4Qk5u?=
 =?utf-8?B?ZEZySTFRaTJlN0hkYVhjM1JoQVdSYmdxVVNocVVCaS9ZVmp4U0tJdVd4RUkr?=
 =?utf-8?B?dmR1U1IyVnZZSDBxYlZ2b0dhb3RnRzQ0ZzFESkVDOUxKb3c1Y3BJRmRiaDBM?=
 =?utf-8?B?VjFNbFBWTFBERzlJcDAxMXNOV2E4LzJOWDVqWU1pb2Q5NlF2MlZlU0tsVVQw?=
 =?utf-8?B?UlRSLzVzTGJnMkJSTlowWW5aNUZmblJ0R0ltS3JQemN1UXBqWll0RldxVktT?=
 =?utf-8?B?UlpKSkRxUHozUGxSa1pZOU5zR0pNeTZ4OThoSUVjM2lrbmF3NDZXZklneEEv?=
 =?utf-8?B?dHk0cGpPUm9PRVAvaUhJTTNMankybzNvbFFpTHFsQUUraHNVdmlHam54bTQz?=
 =?utf-8?B?WXVCb01UUTlSazFnc09MMlBTN3A0Zk1RNXV4SnNFQXUwdmxqZkpBTkFJamJh?=
 =?utf-8?B?Y2ZTbTN2QzVOTEQzY2JEN1BwbE5UNW5NbTVJNVR4VFNFNWFCRDZXOG13S2ZC?=
 =?utf-8?B?MDdXcG1ZRWNMZEcvUjdULzI3a2l4L2xaUnQ4QU5JNURUS0I3MXBmMGpjQnA5?=
 =?utf-8?B?QjdyZnpoU2FKRDc0YXUyMk1QekJkbzZNSWZBQXY2K09aRFVKcHg1VXBkcWVj?=
 =?utf-8?B?MC9KckcwaFM5a3NqdWd1UHFZZnY5cDFQbXl3M3NsaHlaOVlmTm5GNXlFVGJq?=
 =?utf-8?B?aVF4ek85OEdHdFVrVTRFeCtlbTFMS1pOUDNQUTgrTDVrSHJxa1NmRUlZZGMx?=
 =?utf-8?Q?NKlD8h2GYhSZ6AZWiwkBIKJKF6NrXedCFAMrX3InkosLN?=
x-ms-exchange-antispam-messagedata-1: kliIzJizXM6++jzyiTBQgzhsaqxQXsg4goM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F36FA7E464A7884295B5E07A49FE6ED2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MBtYfCZBYpg01jq1pf6UFgA3vULKPK8Y6RRwarFf+Bb7Ca6vzgSq8dsbkBbDLaBcCTL714avlrHiVHhCBmfxx3eruSTnDoXk61YrQWK+tYzDJHnzMQVpFcXWU8Nvw7bDmgcSWYVv1OEGyKK3kIBzbh8WEAOkIPUzJe0eAdsj/tJEENZKpZJqhPtUxKZKmUfAtvh18Nqcg/VRgVoJb5sqoilqEYEfZaugVh/cnHZOw3EYqgXce4IeQxz3R2JOFTgrNmAIlAzkHaG8NZoIZrEVaLveR8vuBX8AdFZI4NQaNQDpnYq+pO7OjkPB/sfJZBTuCqpZmCnHYAGv0bkIjc7cDg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7dEUvwUrAAld+pMnOPbYXypAE7Q02MY7BwPBNyZjO0/60t4cvATR0qV6IAlsWA23aIVFoE1qBAk5VYSwufNAMZKPypa1ne0vU2UB9y3oOpQoehHz8hBqUlMq2n+TUI9j/q0HaKgJmFKISgHQweI63ygJq3O6jTvZtVwDyO8uKHcmdyAnuVDDc2N4XRg++O1TL/CKznrOdsWtl15rShjql9aUNd62AY04M2q5zPIoAkPZUTYesnJEUmX6D5kPeaNK4BHY6pFGjtPpJWGewa9Ekmb9qwTmRwLSjeAfivwX92OO2S2bYaj4MqPKuo7qh8upN+l6662/+nVJ1kSBUACLP6Ihe7ioJEXEiH6bcqNYIFLUDw1zxTSM9RYAn12DOG+3XDKaZYqbgEKARz6shU2vf16MX8FjWbScJzhx/bs9Wg+4pqQBO+NWXtUSchuPXj4/7xofvGvmRdvnpmfTda8EAjt0hdcKx8iOyQhpAupKtP2xILuP7zWFpv4ht35U5ahHofohxexz9kZNV8ak0FkcogjRA+5M7Fj9vz9in38iGGkxuYAkM/pD9oM/9o4z72RbImeBKxS8BChDUj4AeAErW/wY5bmFps1dE1+t58PNjXxx7RXwalK/5iRYLjbFjIWQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690ff4d0-5204-41d8-c7c7-08df492257bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 05:26:35.9514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQdMZ31Nt1avKxwOSHjT2b7TpCXXp2gQvwHx/cVqeiNKPhumkTS3B5RjvnZANmwZwXGDI46jDDj9mFleu/na06trG4bjvTYMqP4B4+9py/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7026
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

T24gV2VkLCAyMDI2LTExLTA0IGF0IDIzOjQxICswODAwLCBCaW4gTWVuZyB3cm90ZToNCj4gQWRk
IGZ1bmN0aW9uYWwgY292ZXJhZ2UgdXNpbmcgdGhlIHYxLjEuMSBIU1MgYW5kIFNEIGNhcmQgaW1h
Z2VzLg0KPiANCj4gQm9vdCBIU1MgdjIwMjYuMDQuMSBhbmQgVS1Cb290IHdpdGggZml2ZSBoYXJ0
cyBhbmQgMiBHaUIgb2YgUkFNLg0KPiBDb25uZWN0DQo+IHRoZSB0ZXN0IGNvbnNvbGUgdG8gTU1V
QVJUMSBhbmQgbGV0IFUtQm9vdCBzdGFydCBMaW51eC4NCj4gDQo+IFRoZSBjb21wbGV0ZSBib290
IGV4ZXJjaXNlcyB0aGUgU0RIQ0kgY29udHJvbGxlciBpbiB0aGUgRE1BIG1vZGVzDQo+IHVzZWQg
YXQgZWFjaCBzdGFnZS4gSFNTIHVzZXMgVmVyc2lvbiA0IDY0LWJpdCBTRE1BIHRvIGxvYWQgVS1C
b290Lg0KPiBVLUJvb3QgdXNlcyBBRE1BMi02NCB0byByZWFkIHRoZSBib290IHNjcmlwdCBhbmQg
dGhlIGxhcmdlIEZJVA0KPiBpbWFnZS4gTGludXggdGhlbiBzZWxlY3RzIDY0LWJpdCBBRE1BIGZv
ciBTRCBjYXJkIGFuZCByb290ZnMgSS9PLg0KPiANCj4gQ2hlY2sgdGhlIG1hY2hpbmUgaWRlbnRp
dHksIGtlcm5lbCBBRE1BIGluaXRpYWxpemF0aW9uLCByb290DQo+IGZpbGVzeXN0ZW0gbW91bnQs
IGFuZCBsb2dpbiBwcm9tcHQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaW4gTWVuZyA8YmluLm1l
bmdAcHJvY2Vzc21pc3Npb24uY29tPg0KPiBSZXZpZXdlZC1ieTogQ2hhbyBMaXUgPGNoYW8ubGl1
QHByb2Nlc3NtaXNzaW9uLmNvbT4NCg0KQWNrZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0
YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiANCj4gLS0tDQo+IA0KPiAobm8g
Y2hhbmdlcyBzaW5jZSB2NCkNCj4gDQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0gVXNlIHRoZSB2MS4x
LjEgdGVzdCBpbWFnZXMgd2l0aCBIU1MgdjIwMjYuMDQuMQ0KPiAtIEFkZCB0aGUgZXhlY3V0aW9u
IGJpdCB0byB0aGUgcHl0aG9uIHNjcmlwdA0KPiANCj4gwqBNQUlOVEFJTkVSU8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxICsNCj4gwqB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGTCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDIgKw0KPiDCoC4uLi9yaXNjdjY0L3Rlc3RfbWljcm9jaGlwX2ljaWNs
ZV9raXQucHnCoMKgwqDCoMKgIHwgNTYNCj4gKysrKysrKysrKysrKysrKysrKw0KPiDCoDMgZmls
ZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDc1NQ0KPiB0
ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9taWNyb2NoaXBfaWNpY2xlX2tpdC5weQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggYTgzNDNl
M2Q1NS4uNmM3NDM3ZjhhNSAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJ
TlRBSU5FUlMNCj4gQEAgLTE4MzQsNiArMTgzNCw3IEBAIEY6IGluY2x1ZGUvaHcvbWlzYy9tY2hw
X3Bmc29jX2RtYy5oDQo+IMKgRjogaW5jbHVkZS9ody9taXNjL21jaHBfcGZzb2NfaW9zY2IuaA0K
PiDCoEY6IGluY2x1ZGUvaHcvbWlzYy9tY2hwX3Bmc29jX3N5c3JlZy5oDQo+IMKgRjogaW5jbHVk
ZS9ody9ydGMvbWNocF9wZnNvY19ydGMuaA0KPiArRjogdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0
L3Rlc3RfbWljcm9jaGlwX2ljaWNsZV9raXQucHkNCj4gwqBGOiB0ZXN0cy9xdGVzdC9tY2hwX3Bm
c29jX3J0Y190ZXN0LmMNCj4gwqANCj4gwqBTaGFrdGkgQyBjbGFzcyBTb0MNCj4gZGlmZiAtLWdp
dCBhL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZA0KPiBiL3Rlc3RzL2Z1bmN0
aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZA0KPiBpbmRleCAyMTFlYTlhY2ZjLi4yMzFhMWU0OWY2
IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGQNCj4g
KysrIGIvdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L21lc29uLmJ1aWxkDQo+IEBAIC0zLDYgKzMs
NyBAQA0KPiDCoHRlc3RfcmlzY3Y2NF90aW1lb3V0cyA9IHsNCj4gwqDCoCAnYm9zdG9uJyA6IDEy
MCwNCj4gwqDCoCAnazIzMCcgOiAxMjAsDQo+ICvCoCAnbWljcm9jaGlwX2ljaWNsZV9raXQnIDog
MTgwLA0KPiDCoMKgICdzZXJ2ZXJfcmVmJyA6IDEyMCwNCj4gwqDCoCAndHV4cnVuJyA6IDEyMCwN
Cj4gwqB9DQo+IEBAIC0xNiw2ICsxNyw3IEBAIHRlc3RzX3Jpc2N2NjRfc3lzdGVtX3Rob3JvdWdo
ID0gWw0KPiDCoMKgICdlbmRpYW5uZXNzJywNCj4gwqDCoCAnYm9zdG9uJywNCj4gwqDCoCAnazIz
MCcsDQo+ICvCoCAnbWljcm9jaGlwX2ljaWNsZV9raXQnLA0KPiDCoMKgICdzZXJ2ZXJfcmVmJywN
Cj4gwqDCoCAnc2lmaXZlX3UnLA0KPiDCoMKgICd0dF9hdGxhbnRpcycsDQo+IGRpZmYgLS1naXQg
YS90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9taWNyb2NoaXBfaWNpY2xlX2tpdC5weQ0K
PiBiL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X21pY3JvY2hpcF9pY2ljbGVfa2l0LnB5
DQo+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+IGluZGV4IDAwMDAwMDAwMDAuLmVlNjI3YTg3YTgN
Cj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9t
aWNyb2NoaXBfaWNpY2xlX2tpdC5weQ0KPiBAQCAtMCwwICsxLDU2IEBADQo+ICsjIS91c3IvYmlu
L2VudiBweXRob24zDQo+ICsjDQo+ICsjIEZ1bmN0aW9uYWwgdGVzdCB0aGF0IGJvb3RzIEhTUywg
VS1Cb290LCBhbmQgTGludXggb24gYW4gSWNpY2xlDQo+IEtpdC4NCj4gKyMNCj4gKyMgQ29weXJp
Z2h0IChjKSAyMDI2IFByb2Nlc3MgTWlzc2lvbg0KPiArIw0KPiArIyBBdXRob3I6DQo+ICsjwqDC
oCBCaW4gTWVuZyA8YmluLm1lbmdAcHJvY2Vzc21pc3Npb24uY29tPg0KPiArIw0KPiArIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPiArDQo+ICtmcm9tIHFlbXVf
dGVzdCBpbXBvcnQgQXNzZXQsIExpbnV4S2VybmVsVGVzdCwgc2tpcElmTWlzc2luZ0NvbW1hbmRz
DQo+ICsNCj4gKw0KPiArY2xhc3MgTWljcm9jaGlwSWNpY2xlS2l0TWFjaGluZShMaW51eEtlcm5l
bFRlc3QpOg0KPiArDQo+ICvCoMKgwqAgQVNTRVRfSU1BR0VTID0gQXNzZXQoDQo+ICvCoMKgwqDC
oMKgwqDCoA0KPiAoJ2h0dHBzOi8vZ2l0aHViLmNvbS9wcm9jZXNzbWlzc2lvbi9xZW11LW1hY2hp
bmUtaW1hZ2VzL3JlbGVhc2VzLycNCj4gK8KgwqDCoMKgwqDCoMKgwqAgJ2Rvd25sb2FkL3YxLjEu
MS8nDQo+ICvCoMKgwqDCoMKgwqDCoMKgICdyaXNjdjY0LW1pY3JvY2hpcC1pY2ljbGUta2l0LXYx
LjEuMS50YXIuenN0JyksDQo+ICvCoMKgwqDCoMKgwqDCoA0KPiAnMjI2ZTQzMjJlNWVjNTM1MTNl
Y2NkZjE2ZTRlOTY3Y2RlZjdkNTdhMGJhMTk0MzE0NzBjYTY4Yjg4MzQ1NzUzOCcpDQo+ICsNCj4g
K8KgwqDCoCBAc2tpcElmTWlzc2luZ0NvbW1hbmRzKCd6c3RkJykNCj4gK8KgwqDCoCBkZWYgdGVz
dF9taWNyb2NoaXBfaWNpY2xlX2tpdF9ib290KHNlbGYpOg0KPiArwqDCoMKgwqDCoMKgwqAgc2Vs
Zi5zZXRfbWFjaGluZSgnbWljcm9jaGlwLWljaWNsZS1raXQnKQ0KPiArDQo+ICvCoMKgwqDCoMKg
wqDCoCBhcmNoaXZlX3BhdGggPSBzZWxmLnVuY29tcHJlc3MoDQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNlbGYuQVNTRVRfSU1BR0VTLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXJn
ZXQ9J21pY3JvY2hpcF9pY2ljbGVfa2l0X2ltYWdlcy50YXInLA0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBmb3JtYXQ9J3pzdGQnKQ0KPiArwqDCoMKgwqDCoMKgwqAgc2VsZi5hcmNoaXZlX2V4
dHJhY3QoYXJjaGl2ZV9wYXRoLCBmb3JtYXQ9J3RhcicpDQo+ICvCoMKgwqDCoMKgwqDCoCBmaXJt
d2FyZV9wYXRoID0gc2VsZi5zY3JhdGNoX2ZpbGUoJ2ltYWdlcycsICdoc3MuYmluJykNCj4gK8Kg
wqDCoMKgwqDCoMKgIHNkY2FyZF9wYXRoID0gc2VsZi5zY3JhdGNoX2ZpbGUoJ2ltYWdlcycsICdz
ZGNhcmQuaW1nJykNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqAgc2VsZi52bS5zZXRfY29uc29sZShj
b25zb2xlX2luZGV4PTEpDQo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLnZtLmFkZF9hcmdzKA0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAnLXNtcCcsICc1JywNCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgJy1tJywgJzJHJywNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJy1kaXNwbGF5Jywg
J25vbmUnLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAnLWJpb3MnLCBmaXJtd2FyZV9wYXRo
LA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAnLXNuYXBzaG90JywNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgJy1kcml2ZScsDQo+IGYnZmlsZT17c2RjYXJkX3BhdGh9LGZvcm1hdD1yYXcs
aWY9c2QsaW5kZXg9MCcsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICctbm8tcmVib290JykN
Cj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYudm0ubGF1bmNoKCkNCj4gKw0KPiArwqDCoMKgwqDCoMKg
wqAgc2VsZi53YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oJ1UtQm9vdCAnKQ0KPiArwqDCoMKgwqDC
oMKgwqAgc2VsZi53YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oJ1N0YXJ0aW5nIGtlcm5lbCAuLi4n
KQ0KPiArwqDCoMKgwqDCoMKgwqAgc2VsZi53YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oDQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICdNYWNoaW5lIG1vZGVsOiBNaWNyb2NoaXAgUG9sYXJGaXJl
LVNvQyBJY2ljbGUgS2l0JykNCj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYud2FpdF9mb3JfY29uc29s
ZV9wYXR0ZXJuKCd1c2luZyBBRE1BIDY0LWJpdCcpDQo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLndh
aXRfZm9yX2NvbnNvbGVfcGF0dGVybignVkZTOiBNb3VudGVkIHJvb3QnKQ0KPiArwqDCoMKgwqDC
oMKgwqAgc2VsZi53YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oJ21wZnNfaWNpY2xlIGxvZ2luOicp
DQo+ICsNCj4gKw0KPiAraWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoNCj4gK8KgwqDCoCBMaW51
eEtlcm5lbFRlc3QubWFpbigpDQo=

