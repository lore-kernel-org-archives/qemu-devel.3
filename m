Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B513606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Hdp8wQoh;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=mdl+Duqy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJild-0005HH-KJ; Wed, 21 Oct 2026 22:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJilZ-0005H8-4c
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 22:42:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJilV-00052h-Jy
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 22:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792636968; x=1824172968;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rhbq7S9YaHxwHbypa1EmpLhNxJpzu1AlITVzPAOnde8=;
 b=Hdp8wQohoo8dYZqgAc65l3usS4BVKCM41PEj7Zjh/SdtPsMYv6a74Uup
 AUiffWOsk7CrrIvWsnzTHoAqgp6InZsgYXA8K8Wiy+N0h0SCUq2nPU7jd
 Zm3hrjTaRa0HFfKvzEf1zvnfpPFy9k6wHGN9Uc+RoWE8NLddVdo65lAtn
 KVYeBc9734lnHkQXjVj2XBbwb0urO1As1ayhw8pYcZertG8KdwHwsHx6U
 d+35tlduw13a9k01659LjgBZmmwWCFqok5YsnHB0nkHkNwp4nrQ8PFxrQ
 HAmktchGYIH+9L0Rnm4Ju+2TuM5O2oTSTDKcBhNgMrX3nlihCqR6yA9L1 A==;
X-CSE-ConnectionGUID: 1kMK7E5pSiOvKEbh06gOLg==
X-CSE-MsgGUID: XZna5YzvSre9o6AoCBClIw==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="154473656"
Received: from mail-eastusazon11012056.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.56])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 10:42:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUV3G45Ki6WGiHGwuPRKp7zQmkaZ4fi9IagRs78NcTh6afJA34hh4Ro/i/yPOFadjmQuGaDKgA6E1WIKxkgssbrSe9wcUnVIu7kHg3s7vfAjsF7Uvqwpn/Kwkrj/Ahtgvo2xIoAkIUI4dljZbygftZQcr404wiblIamZdJMEz96rrSAYC0ycJWeemIqfFWmhAM/pxnHszdsQDR5MBv98j9qZvhUB8uuK6kOX18kGCkthKjnQQRkbDcXG5rwVUnwanNNz47Wzi608gA97pcB+/LtZ1BslbgAhY7N/6gabLXrUd0zM5oaj+ukdATLE5TWCiUJDUqFVQrEjwo8RU0KrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhbq7S9YaHxwHbypa1EmpLhNxJpzu1AlITVzPAOnde8=;
 b=BSqKAGuRsTMF5WfTDPigvutAh9x4u6sGVYQsH8YqJ45Ro3hCSW6uNsEgwIjmYqbJj1/jCO6tjkvlmfSrabNxbjkwQZJbUlm7BuRDhj28LKyb45QzGqtrdPLdGdSAFUq+cJ+pbF8JQsPbgpxwtVL9I00bbp5Tf9I5XLnJbwZ/YnDteKni4eAK9RG+Zfn1LpmX1BuCf9rIfILVOlYbtKQnCxIlqlVJXw8roWS1MAuUIfvOupWVHLi2s08wskjiUw5ZEUyqrupgSvPGcE23TcTTG1ySvBQaGT0uHckfJp+Ad6hBvtu2VLllvLNxvVNfAOu8YYQppbc4gc3hGCVxSY/Q2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhbq7S9YaHxwHbypa1EmpLhNxJpzu1AlITVzPAOnde8=;
 b=mdl+DuqykYDRuHdgMR5YvFmV7nGvDAIMOsFvmJKrbJ4ZYjM4wO/nJD7SUX3R/6C7IHcsBayrD0QcaezKTbV3NANYZIGgswzRZmxcIUcXBDCXYbyWZ0+cA/LICNSQHaQQ2fYQ8pw4cO5S1lzHthPChkUQ1G7TGVjtdvL8VYTg0h0=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CHBPR04MB007031.namprd04.prod.outlook.com (2603:10b6:610:406::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 02:42:45 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 02:42:44 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "luoyonggang@gmail.com" <luoyonggang@gmail.com>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 0/9] multi-target: add riscv64-softmmu
Thread-Topic: [PATCH v2 0/9] multi-target: add riscv64-softmmu
Thread-Index: AQHdXcVSPkrkhww1n0SttjOcokLX9LcIV/WAgAAyjACAAAI7gIAAVb+A
Date: Thu, 22 Oct 2026 02:42:44 +0000
Message-ID: <dc63fd40f14a96f17964ce5c9e47eb5c9efff5b6.camel@wdc.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <929a2b8d-347f-4f6c-82eb-261febfe8db7@oss.qualcomm.com>
 <CAE2XoE88ma_mKg-40_3zOZyH3vtAndezpLp_5V6uM5DEgeo+1w@mail.gmail.com>
 <ebbc9e10-75da-4d8e-b752-4eb2e6637edb@oss.qualcomm.com>
In-Reply-To: <ebbc9e10-75da-4d8e-b752-4eb2e6637edb@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CHBPR04MB007031:EE_
x-ms-office365-filtering-correlation-id: ad4e8071-be20-41af-24d2-08df2fe626b1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|23010399003|10070799003|1800799024|261021123027099003|4143699003|56012099006|11063799006|261009223027099003|38070700021|10067099003|18002099003|22082099003|6133799003|261021135927099003|261021121427099003;
x-microsoft-antispam-message-info: A7ZDbV6hI3AY5ba9Ra6A5rCGwtyNUGkNXAILp1qWmkn1tLfciKWE4hFWVLrlQB/ypZK5PhtkZVLnhpET++b+InuMjWuckro7iIWgV9UHQNsOPqUobjtBqOBsrPldk6uqa90RZg+/DX1zmPD+B6MJFYCumK0pvlQLK63Pl6386Z71MaK2z6Imq3GLeHzRuAnTbgnk67HrHQEx/AfMU5aUu0dLG8DLbWgIpwNtabDvwi+iH3GREQ6sfAOKqc6Gx4xgTr7nbDVXqZyn8inLkKB/e9bYjIRBhXvxKtJf52x1BfjWz/p5V9BjTJea54YD7IgJpNDmpT4cgfO6nMYbtuIvWzDWaEjz41+cM0CDa+mDBjdoTevVHFHvSAlLHM+OlKmGY3fNUOF1R18K3oWQxJbSTJhZIvCOPe/RUsNtGg4OMgCzjDCNcEMxDYad26OB1reMh+2eMoBDGSr6+EYz+gycKLlJb+Rom7EmASlmvOYDQssNwsMkV9X86Yfsv6kM5bf9FT1DJ6Wgj/6TyOq5nXAobDd+53uwz9Ax6fgx5q/zI4zfaP4SEWPW83bKS92BPkZnjgNnbm7Ocl4vujnpIpaxREtgiC89CKm4UYhn4n66PZzJljyf3AuTcPSBZXH2uP8rcqplfIUfHECwhXoD68Yapu5+wqwvTurMcm/fXDMyNJyJJu9+QCQdbcTqF+xXshFyouswWJILG+KDVIDjcvd1Zy2iY495dGyg59vScejP+tM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(10070799003)(1800799024)(261021123027099003)(4143699003)(56012099006)(11063799006)(261009223027099003)(38070700021)(10067099003)(18002099003)(22082099003)(6133799003)(261021135927099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDNsUkhrTlhBSnNURDhHVUNIOTZ6dGUzUzRPQW55cmRqRWdzdXNoNHVZTG5T?=
 =?utf-8?B?dk5Za1AybWpiNjFyM04zUkY2cE9TeVhoT29KdzR2WTRBNVFtcnFmcEFPNks1?=
 =?utf-8?B?ZCtzN29VTGFON203dVJoUEhOMVNGS0NjRjRpRzhuZ1Z0cjZZbnVtNW0zc0RW?=
 =?utf-8?B?TWRKTFk2ek52RWhPN3dTR0RkdjU3dGlIS2ZHbHNlZFBYV2crQlJRbXNDV2Nj?=
 =?utf-8?B?RG9tK2JDSFdsSUdFeXlwcllvM01ISFh2OUxKL2d0YWM1QmwrMkpvL1BsQXBs?=
 =?utf-8?B?eHRoS1NoOUxkT2FpVnpxcHRKcEtZN2JxdG9TKzR1MVVENTcyZ3lhd0VjaTN0?=
 =?utf-8?B?TERKZ1VIV1RwdHovd3drSWpsUDdoTHhBOFErRUNCTE1BYVhtQXlBNUFhRjZp?=
 =?utf-8?B?dmZESlNmQ2Zhd2k4SEZrazJHQm1XZTZ6TjljVkpNQjBIVXB1Y2kxeENZYmxC?=
 =?utf-8?B?TGxnREZaMTZDKzIyL2dGSjh3M2FNekppUitRT2toWS9lc01lSjJ5US9WUTRt?=
 =?utf-8?B?L1RNNWxxYUxFcC8xQnQ3VC9NZVpXVVlMQmxjaWpJZERFbmtKZG5sU0dWYnN1?=
 =?utf-8?B?MVh5Mm1hVHIrL1BHRjJTTXh2a2t0aDc4ckhqSUtzTTVvY05JcktRQ29PL0NI?=
 =?utf-8?B?SHErQU9jS1ZadG9nZmVVcGR3WW1yTnp3UTlEM2I3WXNVOEt1WDBLNE9yUnEw?=
 =?utf-8?B?VVJJN0phQlIwTlZIc0lDMXN0Z3l4U2l3OTNJc1lKWkl6VXlUc1d6TjhucEJX?=
 =?utf-8?B?cUNuK25ZMmZZbUgvUzhJaG1jdGduSVhlYXFhMFJmbFBDUDB2ZGF5N3Y5LzZh?=
 =?utf-8?B?ZVJJQWw2RDdnSDJQazhOZmlKZFVNdXZuQURENml5QTRaQnlLSkljczZqdndC?=
 =?utf-8?B?cjhtRk4yRmZsNGRYM3ZkTXpNV2YrS2FBc0JQNXFxRkNFMjZ0Kzk4bnQybm9V?=
 =?utf-8?B?OUdjSmgvanpjYTZTaFg3NFgvb0tQcitOYkpuVllUcFJCMVR6TDhFeEdUeDVO?=
 =?utf-8?B?UDVuSFd0cGVhM2o3czVlSzJINWpoRGpoUUdpZm9BUXlHN0ZBUzAweDB0RVRy?=
 =?utf-8?B?YmkxSjduRWM5ZlBXS2VYcDZXVlFjbEw5dXRuRFN3MnJBdm9tbnc1TWxNZERn?=
 =?utf-8?B?RkwrL2Z3V2tyRDUwRTJqcUpFUVd1TlNOY3pOUzhFNHl1Rm5PTXlKZXFXSm1y?=
 =?utf-8?B?ZjNHV3JvMXVRRlRheVRONnVvTnI5dldCbVQ3cFlRbG1SMXhaOEJJWldOTUtu?=
 =?utf-8?B?NUtzL0kzYmE4Ri9YdlU3RTZuV2hybkJ2ekRYb21VbGh6bmpaaXVVS2NLRjZP?=
 =?utf-8?B?cGdFVDNsSklmR2lFL0NCMDk2RUdYOU1UaVF5WDBieCtETm9XQjk3cHhOMGhD?=
 =?utf-8?B?QnMzUDJMSUNQd1g1YnAvRVo3aU5iUE5pL1ZqbVJkZm95Y243NXF6ZFJDVVBx?=
 =?utf-8?B?dWNlb2JxbWpVSWZHdWRTTnFybW0wbW9SeEI5K0Ntd2tLVm9JUW5URzhHWXNj?=
 =?utf-8?B?VWlNNmcrQTk4N2FQSmRtLy9iRmlPZmJ2c3AremJCa0RZTVVjekxsMHFtbmZR?=
 =?utf-8?B?VzNCZ203QzBDVVhDWjVEVEM2TFBvQ2Q4VTM5S08xYWh4bXBmNzdhaEZYMUlt?=
 =?utf-8?B?SVE0MWdBNUdTQmZDeUdFSkRqMG1BbnMwVklDUGdYdVl2bWkrWS9TVmg2MHpB?=
 =?utf-8?B?bG0wWGE1eUJTR1Rmek13aVB1L2EzUzFhcnZhZXlsRkRpTGhqNTRjV3FScURq?=
 =?utf-8?B?NmZQSytMM1hTNU5GdTVLa1Z5WnkvUzEwS2J2YlNQUkI0SlpCYVZBdFR2Y3Ju?=
 =?utf-8?B?WVNUbkVQeDUra212bC9JOEJRdS9zaHAvRllFNGZsK0V6UUNGV0VCaWZ5SnVp?=
 =?utf-8?B?ckxYZWJyNE9XK0NjS2FSWXdCb3ZyUEZaRnlVYzU0N1hkTHV5ZFh6bUoyUEdz?=
 =?utf-8?B?SDhCTEMvUk4rUTMxampXTnVaSUZYLzZCZC9Ec1E5NUwxZHhqdUtVVkY3akJQ?=
 =?utf-8?B?V1R5WmNmRkpyVEdQQVBGNWYwcHBFODNmK25saFBKRVhzWHBPSzRGL3JFalJw?=
 =?utf-8?B?OG45dU4zMklUY1pIVy8xc3kxU2VIUWhNZWloWTJsVStSaGMxaFZ2aHF1Q0Zw?=
 =?utf-8?B?YXhmWEtCRVJTRmpKQmUrV1R3bjBNM2VNVmxTY29tdlBjV1lnZ0EzVmwxaVZw?=
 =?utf-8?B?MjgzSFRIVnJjaTVacEVpOVFEM0NIMTUyc3hudFd1TGxRQ0gxakViZzdTaHhi?=
 =?utf-8?B?T3VNcG5LOG1YT2U4aTRsTHcrSTQ2MVJ3MGRKbmNDdC9IaVRFM3N4Z3pITCt1?=
 =?utf-8?B?N2pzZGw2V0E3WEJFa01WcWZNaThZbzY2aDB2YllOQ2ZLMGdGcjU5bFFLRkR2?=
 =?utf-8?Q?GIXW4C4zV5m9qFkrkEKMravmH2T4UquKJ/1ijCJzE1Ivw?=
x-ms-exchange-antispam-messagedata-1: +VsrjJfZ9CIblJwe0CzddC8vJj+C8NAVO10=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82E7459C8152994EA79DF01D1635221D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jfx8Z6QK7K6/QD6DVO6kD45RRwGdTKWiGCuN0lWk6n6d25tQ3jRR7gyEl1ng76d69/IUWtjCgHBTR9j5S/GYqDZCmKoe+Eg6PaX9adZmaXcnaiDx1fpdTrYO4GjwYoPBAtW3VGQO2VCUd/mh8PbMSaT2pmjDZ9bSWFAcSQ8d/Lmpq9Ah6ae0lzwWFO4nxPy9gig8bm1aD2o/mbGNObNE1vH1lj6EZaRlaczptaOSWzv8Gb4m9nQdZ6t435SVnq0ZbgVNLlhK5d9YcXp1PMIG0knZ8pVoJ4nxQOODIV6EtPOZTeZ0JUGx4E7D1dDJL1cc4Ynm4MSRuWrjJbtmfoHwmA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SR8qXAIoHj7MYAfWdabXP/KhUum+WE11kMQc4wC2wm8lil8HA5P/GI6qZMBl8GmhvCLfbw0aKzCaynb1+W2SBm4QXH5DzAz9oUcSGtvLV7mEt85qkAE62LvenQSgDxMyQ82HpPkvXsDaSoq3pvCeSv+SsCOaFzdItY5hm9jkSBPTibFrY/Lyj92nnKddmSZi7QFG3iSInvCXZNnHahvnE0kQc1QcH5zYYqcB2GhMg7csWfcqH+CJYDbznA7oVTGRAmoDxpNhh5SmN31Syhp22QILghcnXAgihB1mRbsp499mafr8HXPTkuMu2Z6oEYGs78XIDPVf95YqqA9IACsMvKoVL3egCO4QMRtTugxvBANftMh4+qChaJ1vwaboEirr+GHMRXwOq/qz7/xXl5dTHVKfTQpqL7iKs33t8exVFMsYP5NaBhcvQsNMNviDM+iaDJ/rBVIMgrkgu1x2lrHuy1UhRFypMUEy6gjHFoxtnz6mM88jdgLubjLFWZ2mAad5W/K0KkrNplikjSedu2WZQH86aimM4mRFB8bJZ6CZQlJ95JDQ+u39Yffy5yEc1Jgk97wABo99j62sF33Jfi8pJDgjfLz2sG4uArM5kiVaWQ1DCww73aVvurk4hmrDVa5Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4e8071-be20-41af-24d2-08df2fe626b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 02:42:44.7713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiabV8AKg7VtTrUY58AqPMaPLjeNMdxxmFwwyTmurxTVzq1edeJqmiTUUtrncCOqrEWAvV3qyj83yDxAPkTdM48E1hXWW39Aqtgbo1B1ozM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR04MB007031
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTEwLTIxIGF0IDE0OjM1IC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiBPbiAxMC8yMS8yMDI2IDI6MjcgUE0sIFlvbmdnYW5nIEx1byB3cm90ZToNCj4gPiBPbiBU
aHUsIE9jdCAyMiwgMjAyNiBhdCAyOjI34oCvQU0gUGllcnJpY2sgQm91dmllcg0KPiA+IDxwaWVy
cmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiAx
MC8xNi8yMDI2IDQ6MjIgUE0sIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+ID4gPiA+IFRoaXMg
c2VyaWVzIGFkZHMgdGhpcyB0YXJnZXQgdG8gc2V0IG9mIG11bHRpLXRhcmdldC4NCj4gPiA+ID4g
Q2hhbmdlcyBhcmUgc3RyYWlnaHRmb3J3YXJkOiBmdW5jdGlvbnMgYW5kIGhlbHBlcnMgcmVuYW1p
bmcsDQo+ID4gPiA+IGFuZCBvbmUgdHlwZQ0KPiA+ID4gPiByZXN0cmljdGlvbiBmb3IgdGhpcyB0
YXJnZXQgb25seS4NCj4gPiA+ID4gDQo+ID4gPiA+IFdoaWxlIHRoZSBzZXJpZXMgYXBwbGllcyBj
bGVhbmx5LCBpdCB3aWxsIG5lZWQgdGhvc2UgYWRkaXRpb25hbA0KPiA+ID4gPiB0d28gc2VyaWVz
IHRvDQo+ID4gPiA+IGJ1aWxkIG11bHRpLXRhcmdldCB0ZXN0IGJpbmFyeToNCj4gPiA+ID4gDQo+
ID4gPiA+IC0gQmFzZWQtb246DQo+ID4gPiA+IDIwMjYxMDE2MTgxNDEwLjE5MTc0My0xLXBpZXJy
aWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbQ0KPiA+ID4gPiAibXVsdGktdGFyZ2V0OiByZW1v
dmUgZHVtcCBmdW5jdGlvbnMgZHVwbGljYXRpb24iDQo+ID4gPiA+IC0gQmFzZWQtb246DQo+ID4g
PiA+IDIwMjYxMDE2MTYyNTA5LjI0ODU0LTEtcGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0u
Y29tDQo+ID4gPiA+ICJtdWx0aS10YXJnZXQ6IHJlbW92ZSBxbXBfcXVlcnlfY3B1X21vZGVsX2V4
cGFuc2lvbg0KPiA+ID4gPiBkdXBsaWNhdGlvbiINCj4gPiA+ID4gDQo+ID4gPiA+IFVzdWFsbHkg
SSBwcmVmZXIgdG8gd2FpdCBmb3Igc2VyaWVzIHRvIGJlIG1lcmdlZCwgYnV0IEkgaGF2ZQ0KPiA+
ID4gPiBnb29kIGhvcGUgdG8gY2F0Y2gNCj4gPiA+ID4gdGhlIGZyZWV6ZSBkYXRlIGlmIGN1cnJl
bnQgc2VyaWVzIGlzIHJldmlld2VkLCBhbmQgc2VuZCBhbGwNCj4gPiA+ID4gdGhyZWUgYXQgb25j
ZS4NCj4gPiA+ID4gDQo+ID4gPiA+IHYyDQo+ID4gPiA+IC0tDQo+ID4gPiA+IA0KPiA+ID4gPiAt
IG1ha2UgdmlydCBtYWNoaW5lIG9ubHkgYXZhaWxhYmxlIGZvciByaXNjdiB0YXJnZXRzDQo+ID4g
PiA+IC0gZW5oYW5jZSBtdWx0aS10YXJnZXQgdGVzdCB0byBkZXRlY3QgZHVwbGljYXRlZCB0eXBl
cyBiZXR3ZWVuDQo+ID4gPiA+IGFsbCB0YXJnZXRzICh3ZQ0KPiA+ID4gPiDCoCBtaXNzZWQgdGhl
IHZpcnQgbWFjaGluZSBzaW5jZSB3ZSB3ZXJlIGFsd2F5cyBwaWNraW5nIHRoZQ0KPiA+ID4gPiBm
aXJzdCB0YXJnZXQgYXZhaWwpDQo+ID4gPiA+IC0gYWRkIGFuIGFkZGl0aW9uYWwgY29tbWl0IHdp
dGggdGhlIHJlc3Qgb2Ygc29mdG1tdSBjb21tZW50ZWQNCj4gPiA+ID4gZm9yIGZ1dHVyZSB3b3Jr
DQo+ID4gPiA+IA0KPiA+ID4gPiBQaWVycmljayBCb3V2aWVyICg5KToNCj4gPiA+ID4gwqAgdGFy
Z2V0LWluZm86IGFkZCB0YXJnZXRfYmFzZV9yaXNjdg0KPiA+ID4gPiDCoCBody9yaXNjdi92aXJ0
OiBtYWtlIG1hY2hpbmUgYXZhaWxhYmxlIGZvciByaXNjdiB0YXJnZXRzIG9ubHkNCj4gPiA+ID4g
wqAgdGVzdC91bml0L211bHRpLXRhcmdldDogY2hlY2sgUU9NIHR5cGVzIGNhbiBiZSBpbml0aWFs
aXplZA0KPiA+ID4gPiB3aXRoIGFueQ0KPiA+ID4gPiDCoMKgwqAgdGFyZ2V0DQo+ID4gPiA+IMKg
IGh3L3Jpc2N2L3ZpcnQ6IHJlc3RyaWN0IHNjb3BlIG9mIHZpcnRfaXNfYWNwaV9lbmFibGVkIHRv
IHRoaXMNCj4gPiA+ID4gZmlsZQ0KPiA+ID4gPiDCoCB0YXJnZXQvcmlzY3Y6IHJlbmFtZSB2aXJ0
X2FjcGlfc2V0dXAgdG8gcmlzY3ZfdmlydF9hY3BpX3NldHVwDQo+ID4gPiA+IMKgIHRhcmdldC9y
aXNjdjogcHJlZml4IGhlbHBlcnMgY29uZmxpY3Rpbmcgd2l0aCBvdGhlciBhcmNoDQo+ID4gPiA+
IMKgIHRhcmdldC9yaXNjdi90Y2c6IHJlc3RyaWN0IHRjZy1hY2NlbC1yaXNjdi1jcHUgdG8gcmlz
Y3YNCj4gPiA+ID4gdGFyZ2V0cw0KPiA+ID4gPiDCoCBtZXNvbi5idWlsZDogYWRkIHJpc2N2NjQt
c29mdG1tdSB0byBtdWx0aS10YXJnZXQNCj4gPiA+ID4gwqAgbWVzb24uYnVpbGQ6IGxpc3QgYWxs
IHJlbWFpbmluZyBzb2Z0bW11IHRhcmdldHMgYXMgY29tbWVudHMNCj4gPiA+ID4gDQo+ID4gPiA+
IMKgaHcvcmlzY3YvdmlydC1hY3BpLWJ1aWxkLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMiArLQ0KPiA+ID4gPiDCoGh3L3Jpc2N2L3ZpcnQuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE0ICsr
KystLS0tDQo+ID4gPiA+IMKgaW5jbHVkZS9ody9yaXNjdi92aXJ0LmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArLQ0KPiA+ID4gPiDCoGluY2x1ZGUv
cWVtdS90YXJnZXQtaW5mby5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDcgKysrKw0KPiA+ID4gPiDCoG1lc29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxOCArKysrKysr
KysrDQo+ID4gPiA+IMKgdGFyZ2V0LWluZm8uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMSArKysrKysNCj4gPiA+ID4g
wqB0YXJnZXQvcmlzY3YvaGVscGVyLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAyNCArKysrKystLS0tLQ0KPiA+ID4gPiAtLQ0KPiA+ID4gPiDCoHRh
cmdldC9yaXNjdi90Y2cvYml0bWFuaXBfaGVscGVyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCA0ICstLQ0KPiA+ID4gPiDCoHRhcmdldC9yaXNjdi90Y2cvZnB1X2hlbHBlci5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNiArKysrLS0tLS0NCj4gPiA+ID4gwqAuLi4vdGNn
L2luc25fdHJhbnMvdHJhbnNfcHJpdmlsZWdlZC5jLmluY8KgwqDCoMKgIHzCoCAyICstDQo+ID4g
PiA+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2ZC5jLmluY8KgwqAgfMKg
IDggKystLS0NCj4gPiA+ID4gwqB0YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZm
LmMuaW5jwqDCoCB8wqAgOCArKy0tLQ0KPiA+ID4gPiDCoHRhcmdldC9yaXNjdi90Y2cvaW5zbl90
cmFucy90cmFuc19ydmkuYy5pbmPCoMKgIHzCoCA0ICstLQ0KPiA+ID4gPiDCoC4uLi90Y2cvaW5z
bl90cmFucy90cmFuc19ydnppY2Zpc3MuYy5pbmPCoMKgwqDCoMKgIHzCoCAyICstDQo+ID4gPiA+
IMKgdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3hscmJyLmMuaW5jIHzCoCA0ICst
LQ0KPiA+ID4gPiDCoHRhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVyLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0ICstLQ0KPiA+ID4gPiDCoHRhcmdldC9yaXNjdi90Y2cv
dGNnLWNwdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0K
PiA+ID4gPiDCoHRhcmdldC9yaXNjdi90Y2cvdHJhbnNsYXRlLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCA0ICstLQ0KPiA+ID4gPiDCoHRlc3RzL3VuaXQvdGVzdC1tdWx0
aS10YXJnZXQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDM0DQo+ID4gPiA+ICsr
KysrKysrKysrKysrLS0tLS0NCj4gPiA+ID4gwqAxOSBmaWxlcyBjaGFuZ2VkLCAxMTMgaW5zZXJ0
aW9ucygrKSwgNTcgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBFeGNlcHQg
aWYgdGhlcmUgYXJlIHNwZWNpZmljIGNvbW1lbnRzLCBJJ2xsIHNlbmQgaXQgYXMgYSBQUg0KPiA+
ID4gdG9tb3Jyb3csDQo+ID4gPiB3aXRoIHRoZSB0d28gY29tcGFuaW9ucyBiYXNlZC1vbiBzZXJp
ZXMsIGFuZCB3aXRoIHRoZSBjdXJyZW50DQo+ID4gPiBoZWxwZXINCj4gPiA+IHJlbmFtaW5nLCBh
cyB0aGVyZSB3YXMgbm8gY29tbWVudCBvbiBnZW5lcmFsIGhlbHBlciByZW5hbWluZy4NCj4gPiA+
IEhlbHBlcnMNCj4gPiA+IHJlbmFtaW5nIGNhbiBiZSByZXZlcnRlZCBhcyBwYXJ0IG9mIGdlbmVy
YWwgaGVscGVyIHNlcmllcy4NCj4gPiANCj4gPiBIaSBQaWVycmljaw0KPiA+IEkgcGVyc29uYWxs
eSBmZWVsIGEgZ2VuZXJhbCBoZWxwZXIgaW50cm9kdWNlZCB0b28gbXVjaCBtYWdpYywgSQ0KPiA+
IHRoaW5rDQo+ID4gaGVscGVycyByZW5hbWluZyBpcyBmaW5lLg0KPiA+IElmIHdlIHdhbnQgc2hh
cmluZyBhIG5hbWUsIGEgbW9yZSBtYWtlIHNlbnNlIHdheSBpcyByZWZhY3RvcmluZw0KPiA+IHRo
ZW0NCj4gPiBoYXZlIHNhbWUgYmVoYXZpb3IsIHN1Y2gNCj4gPiBhcyBhZGQvZGl2L211bC4NCj4g
PiANCj4gDQo+IEhpIFlvbmdnYW5nLA0KPiANCj4gSXQncyBvbmUgb2YgdGhlIHJlYXNvbiBJIHBy
ZWZlcnJlZCB0aGUgYWQgaG9jIHJlbmFtZSBzbyBmYXIsIG5vdA0KPiBiZWluZw0KPiBzdXJlIHRo
ZSBlZmZvcnQgd2FzIHdvcnRoIHRoZSByZXN1bHQuDQoNCkNhbiB3ZSBhdCBsZWFzdCByZW5hbWUg
YWxsIG9mIHRoZW0gdGhlbj8NCg0KQWQgaG9jIHJlbmFtaW5nIGp1c3Qgc2VlbXMgbGlrZSB0aGUg
d29yc3Qgb2YgYWxsIHRoZSBvcHRpb25zDQoNCj4gDQo+IFRoZSBvcmlnaW5hbCBhdHRlbXB0IHlv
dSBzZW50IHRvIGZpeCB0aGlzIGJ5IHJlbmFtaW5nIGJpbmFyeSBzeW1ib2xzDQo+IHVzaW5nIGFz
bSgpIGlzIGRlZmluaXRlbHkgdG9vIG11Y2ggbWFnaWMgdG8gbXkgdGFzdGUuIEkgaG9wZSB0aGUN
Cj4gc2Vjb25kDQo+IGF0dGVtcHQsIHNvdXJjZSBiYXNlZCwgd2lsbCBiZSBtb3JlIHNhdGlzZnlp
bmcsIGFzIGl0IGhhcyB2ZXJ5IGxpdHRsZQ0KPiBtYWdpYyAoanVzdCByZWx5aW5nIG9uIEhFTFBF
UiBhbmQgSEVMUEVSX0lORk8gbWFjcm9zKS4NCj4gDQo+IEluIGFsbCBjYXNlcywgdGhpcyBpcyBh
IGNvbnZlcnNhdGlvbiB0aGF0IGNhbiBoYXBwZW4gaW4gcGFyYWxsZWwgb2YNCj4gZW5hYmxpbmcg
bW9yZSB0YXJnZXRzIHNpbmNlIHJldmVydGluZyB0aG9zZSByZW5hbWVzIGlzIGEgcHJldHR5DQo+
IHNpbXBsZSB0YXNrLg0KDQpBZ3JlZWQNCg0KQWxpc3RhaXINCg0KPiANCj4gUmVnYXJkcywNCj4g
UGllcnJpY2sNCg==

