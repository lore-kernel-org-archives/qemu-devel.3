Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F64606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=jnoatI0+;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Ds+1gThv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJin7-0005gr-PO; Wed, 21 Oct 2026 22:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJin5-0005gZ-LC; Wed, 21 Oct 2026 22:44:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJin2-000567-LJ; Wed, 21 Oct 2026 22:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792637064; x=1824173064;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=DwcdGXPjUkFQFtwom9lkZUpP5x3vFTuwqpttyAT+JPY=;
 b=jnoatI0+/6isPH6z0g3XY38pHbvr4Lj7fm8mvtaMp1u6Nz0/9mcjbzYy
 +MdFXhGhgsO+KJTXyw6w2I2AsD5/UVGHCujs1hpEY/nO1E6ZIHsHcWoZC
 maTnYjLE0h9v4Nh+r8AqffBJ3WQlPj0TX+uu1fqy0ccNwqvACVwDmCQ/R
 6TkcetlnNr6415HGTLsro5QM56y7l8MyUfIxkK7cV3Jyf5cu3boXlwwj6
 B3d2B10WkVLil2yRUAMpTcaa6eWke1/fbK5OwxfnlTsqyPCLHA65VTtgB
 Qb4Y7Fa828lVBHcoDG5cE77Jg7n8IBSmDTf7liSwbgu1Qxu5e8Dwy8Y1C Q==;
X-CSE-ConnectionGUID: DeCeShIBSPiwjvxKqLdZVg==
X-CSE-MsgGUID: QqTrjHM2QMmLDlevjb/+ew==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="157736871"
Received: from mail-westcentralusazon11013038.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.38])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 10:44:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tolUTfUeO/mAGz/aBKrCdADsXZpAJnBvdZfAbyNAkEabmbDXFf8AbCGnJUodndIRak+udHVg7wUm2N9nIXoKvd0LVQBTDsm38EkqAneIX0ucBW3eY8W63yxKiBxT4/pehDzx1DqCjrxAd/bfGNLDvLskQIWq7+8NtzuAa9NOWF3dPl6aBm2U90PqclqlTGZBrXpm6aLgC3SfYoPfl4FG3HPtTl9kdwU4kZsU4wQxWfINBeMGrxjqbBUpCKRi/V9rbgc56y15UbrbCPU8OKqiuN7qvVAExjkuwrFRZqx6lhwKE36z0zKR6EYuL/Ew2eJ2DqndTsOcLqQSti0BvQ7uiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwcdGXPjUkFQFtwom9lkZUpP5x3vFTuwqpttyAT+JPY=;
 b=OFnywkTOoNXxvuzaAgmCJlLKtZgTr7ipIEUNPAe67eCDYpOi3PyZbnWmLVvJIfmAjcG8s9fFbJxcbksbcv75AEg+RoERO3OdaUhwyPTQGzknbciDrNT7uaRcMRG7VRCPTs5Ag+JUEfL4Y0oBvtcMj/tJZnMDuLJdTPtxXF87kR0/usxUECp4BfXCJMI1YRlSP1ANf5SPvq63k7MdLqwwToJc9d8RB38h6h/7PYArBFwLRXZKmluBfUFVsERbbhdtYAoxnV6XS72bNA4talZWCL5Wnfto5WQJZLFCb/eyCH08juac4uxhYBrBjMI+VZtj8k9mPRBw26qNJ86BJ5pniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwcdGXPjUkFQFtwom9lkZUpP5x3vFTuwqpttyAT+JPY=;
 b=Ds+1gThvL6yceTMrUz01DV7dYGTPTaPLEV4ShEVVsgyLgTGJ38fZLnj1mFQNElCx7uyha0/PYdlGPs41yuvrne2JaKNNMDHdCP1LNUzIJQzNiCu+Bbdn2rYXkMLcvPbT+Jzl3qNmC30nISaNs9/NKfaGswD49XN+Fa9P/vacRhY=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CHBPR04MB007031.namprd04.prod.outlook.com (2603:10b6:610:406::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 02:44:21 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 02:44:20 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>
Subject: Re: [PATCH v2] docs: Move RISC-V 'Z' CPU properties section to
 removed features
Thread-Topic: [PATCH v2] docs: Move RISC-V 'Z' CPU properties section to
 removed features
Thread-Index: AQHdYGjy9djC1WNW30qynIPF6wQJzrcI3agA
Date: Thu, 22 Oct 2026 02:44:20 +0000
Message-ID: <c334ee2460b523e294924c400a5c2a9d42e6e497.camel@wdc.com>
References: <20261020075927.56983-1-philmd@oss.qualcomm.com>
In-Reply-To: <20261020075927.56983-1-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CHBPR04MB007031:EE_
x-ms-office365-filtering-correlation-id: 0421785b-3cfc-4fe9-7b1a-08df2fe66000
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|23010399003|10070799003|1800799024|261021123027099003|56012099006|11063799006|261009223027099003|38070700021|10067099003|18002099003|22082099003|261021121427099003;
x-microsoft-antispam-message-info: A6rVriBthNKPfPh2NwKMFE9jCHsqDCmBmi/sEjpw6B3JE+Ssse7cJFiKMEt3Ex26VlZUfb5MNLLIomDfPC9eLeIdRCZaWfGD3CEuax5l4ea82Lpil5RDUFjwdBib8mQCb3xy1QzT1we5JeAMuIagBFyQ58nDD/+L4PW8Q6IPr1G5coxxy4LLrtFbJzw7g6ABDkL0b684A5DuKCFv7dGHeQAw0U4enDdh19Q9qCzihFd3O8rhwLFar366WtgkQkbC4hpzFKNJrO0TIRAanD+5MeMyLMMjjD3Fykc31qkIj+zjrxmvE+GX2e3wVt2i4XprWTXC2vH8/VDefT7SDFICjjFo/5buKR/PxJ3e2dBdMoi7YlUVu/OqKlnAVce46ROU1i7UCwg6kG409R6n3EFT3VhoP1/j8bnK3SDMXgjltpsf1k9IrCUk75HJWFiGdo0zWR3cAgk0cdgh58C8N5UR+DKGHOmXMqghok1c/ijxdhzIs389sQA9tc9hID49p4sZrhdcrLUQZzaB1v2xXvr1XKGyb5MCDL6+K8vy+x+ddIAfVdnLti6+8rZBXiDt64h3HJ7OTq4lP2a/P1fF/Nz0QpWJUiLIUde4zK95q1VDZHK2+n7IpPIUcy1UcXReuHk8WnGwfrEVLks9S+qhAdO0WL61FPylESU7lpUDPIve31F72RLxq8XpY77CKgY6GZ8JrhHUUMFDp3dbyoevwgx48FQgxSovh1MjkZG0yEz0t3Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(10070799003)(1800799024)(261021123027099003)(56012099006)(11063799006)(261009223027099003)(38070700021)(10067099003)(18002099003)(22082099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXZ1S1lOYnVob2RMU2xhdXB6SkVLMWpQZHh3K0hReEZkVTJMV1cwWktGcjYy?=
 =?utf-8?B?RFlxdS9wRFZBendiUUw5NTBYZGVUMDVTa0xxUU8xSVlySVhFSDE5aFNLaXBw?=
 =?utf-8?B?ay9HeWJabG12bDc4UHpuTWhSemZQL1U1NFpyNHgrQmxRZ0pSNFdYcUtmY1Mx?=
 =?utf-8?B?SE5rQVl2ZXN6YmNRdmNnakdweFM0R0JzNE5VZk93YzBRSnZXV1Q3TnN2K3NC?=
 =?utf-8?B?Nm42cUg5MitaS1dRbzFMa2tuYTIveUkvZVpYZytLTHZCdmtMQXEyNUxzR2Ux?=
 =?utf-8?B?dlBCWmpJVDVZMWMybzRmRTBlYVIwM3NhZGdtYW84aE1wazRsbGpsODNvbzVW?=
 =?utf-8?B?cmdRa3RyM2tyRTF4M1hhWFpRTjNWejZxMDNvTWF2aGVyWW9zRis2U3Fjalht?=
 =?utf-8?B?Y3BmZnlDaG04Ujl1UmdFU2RjRE1vc2JoMlZiL0JXb1U1dlNpOFM2cyt5cTA2?=
 =?utf-8?B?b01PMzJaa1FiYjNVKzRheGRTYitjdmxxT3VJa28xK1RtRkR0aW5OeGd4SDRt?=
 =?utf-8?B?cFdMd05xa2M5Q09FWHp0bFJSd3J5cVpGTnVZNGx3VUZRa1FGOTVCT2VlcXRX?=
 =?utf-8?B?aFBKdlhySi9zd2NQK0NDcEZ5ejFzUEJtUzFraGkxNi83bng3Y2trRTJuYWZa?=
 =?utf-8?B?NXhCTFhWQTNJSHlVSzMwMmduRnpxQUliM2RCT0F6SXBuVWJneUw5QjRtOFh4?=
 =?utf-8?B?NlRXcEorcTlHMy8zWGxnekFGOGdkajEyb2RzVm9veWoyY2FCYzM5c2N5Qi9E?=
 =?utf-8?B?a3h4bjNZL2dPTG80QmFZZWpSdElmRmJaVE5mRXQvS0tuWTZuMVpNMzFObnBx?=
 =?utf-8?B?dUxDTDVYYkhxN25OOHkxZEVYTGkyQnpEMElFZCtTQXdiUU9FMnQ1c0tNUWpI?=
 =?utf-8?B?N0ZHWXlQWnFCT2tndkZHK2RIcHBBSWQzam9nSVJBS0d6aGo4N2QvblZjS1ZJ?=
 =?utf-8?B?cjMwTnd5aGxycXVzUEtLUCtzcWhRTjlDK2dLL2RsSGpLc2haOUp0cW1wT3ZT?=
 =?utf-8?B?Rklmcnl2U2FCY00ydXU1OWdwb0p5SVcyNCtMMVV2TnE3NjMrQVAxOE5jQnpy?=
 =?utf-8?B?VXlZOUN6QTV6VHRHVTN1SldqSkcweFBQaVU5RVBtNHJxd1c1NXFpQ0wzR1Qw?=
 =?utf-8?B?MUtLMG81Y2xSa2tZeXkvQ3k0dXpCTmg3Q29iYnBZYlZkaGIxRURvS2FUeDNG?=
 =?utf-8?B?M2x3aitva2RWd3BsNk9pVmYxczU5K25Tb2E1SUF2WjNBUko1Sm1tbkJlQ1pK?=
 =?utf-8?B?RnJxT2NnNGR1VDhvU3NVL0lFTXU5eS9aWTJzazRRdXlBNVAySC9COHBiUis4?=
 =?utf-8?B?Zko3NkdueFc0K2xLbHdDVkllUENkVnNCMmhUR2dmaVJ1NjRBTHBKT1RIVXRT?=
 =?utf-8?B?OEJsQTZLTERIVVZIL0t3b1Q2K0I5MkFxNXcycFRMZmE4TWE1WExobXRQckQv?=
 =?utf-8?B?RVdXbktraU9ELytpSUVJSlhBdnMzdEFueEtFUys1c0VHdXcrS0VuL1ovNy9M?=
 =?utf-8?B?THdrNWJoZXQxNmhsZXVXZDFaU2t2Y3BIdU41bllOeTJzSkFkWmFRYUc2eTlz?=
 =?utf-8?B?UGh3ei94UWlFYkg1Zm5mTG5lVFFFSUgranVGMkVKa3R5bTB4TWk2MGhDTEg4?=
 =?utf-8?B?SjJTOENpbmFDVXMyd0ZhZDFXZzZmL2dCOUpaZ0FqSStRVGVzQldaL0FSTEpV?=
 =?utf-8?B?WStRUGZzNThOcGtObncyVVlFWjJyZ2E5Zm91a0xHRHBJSWo3VnpzNjB4L3ha?=
 =?utf-8?B?RWwwcmNwMWZmU0RmSVN2dWdNOGh3NlRxa2U5TW92anJZMUJkSDhLeEE1M0lh?=
 =?utf-8?B?ZlgzRTY0aVFiQjBhUzBxcENsbVhiRzJCYkJ5ZGllallhNGordlYyTXNPOStI?=
 =?utf-8?B?Tm90RHora2MreEtZYVVXQzcxSEt1TUFsbGdyYkJobHNRei9JQjByUFpsZnNR?=
 =?utf-8?B?SW9rMFZxVVZEV3FrbEZwTnBOZng1d0VLRlhLYUorSDhVaWV2eGFNZUpMMmVI?=
 =?utf-8?B?WHFVZm9TaXlnWm1LM1dhMkU2TlZyemppenUzMTQ0UUhZYkhua1hrck9CR1FM?=
 =?utf-8?B?Q0lyRGF3UGRveU9RbjhJMEpGM0s0VHpxNWlxMzlVN1FBM1lEdGtJOW5wUUR5?=
 =?utf-8?B?MnhGM0ZXdjNkT01SOXBMYnljOUNGNGxlYzEvMkJQRFV0L3FxdnRLV0N2a1NQ?=
 =?utf-8?B?SVdnM1dnci96cWNkZUlHZ2dobHhzSVNKRFNEMnhYTVVGVDNrRFRzcnlUb21m?=
 =?utf-8?B?VWlpVy9QMFh3THQwZ2NObGtIMndKK0txRlgydTlpaEs4eFJ5cEhqTkJSU0tj?=
 =?utf-8?B?U1hoTFAxdzFDZTNmd2RXRFNiWlRER2phVTRRSVVBUStpY3NQdVdOZGtBUWM5?=
 =?utf-8?Q?btFeEUcCZZB0AjcPZqRu7Ipv+znSpb4Nm0HRirIiRYRZ9?=
x-ms-exchange-antispam-messagedata-1: ZV3DPuIzzUIyOFGOxpvi+8DvIJorqZGQmwA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C1A08CE8101174B9C705360BE838DC5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T+SJCB/NIgmeCVKd3pIseCoFiU4GOjOetL/cVj4BxxkmS165fEK5l4U6IGBFq7cXn2PhcCeKG9z1DJHvKY5B91cYOiHw1TQYqKT2fjhEv7+jpnkJyobbEwp5NlK69nNVUxmj27At75hOkdtjoO+8JmM0NCQtGhr5pYAXCQQlbYFuQY7U7BdrE8d9VnyqOklGRGH60No3U7zBOItD+dDrJS9AeXvy+YgbQ9CgbDFqBB313d1mNclAT/NjddiDS2s1Apg/4gxyyBwyodcVnbhW/mikuykosVbguUIyy6XOxkY7W4f8S3//hhFoKq8DRs5MXQjCGaCQt+fylBbo0j2cBA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BFOGwGSajIpdjkndYYZt+IDtRsr3Zslih+EthXBamF0Sw45TIrVVjW3NSzV98DSLhcqoeYtFHwcwcSwV7etMRmYpPnK8ajdwnZPC7ySasAhjrYQ3bWhI3RXNuL8SS6HV7mD3cPUIA/u9qs/asH5Y75fE+pO5Fp7SIjffFkVxA0WN/Zbwmyxk8hVXnJ5RXntX8041+NFZGaO4qr3/EouGqBgXelOsTEt10L0WuQeJ2EuGpKQvh7CQZhJWV57es7tfaqWuFNJowOBcYrRfFddL6fkQL09qSzGLbznSrnIKziGtH6IzrhFOKm3aDIQdxsh+OJCXCYlzWkxEv2hUlUgBjkO3+6BlmjIzHNqehKODzaZnY0Bv54nnLNk7bM+oLgaUCiLdwtDpuUDIwg+NryloH6PUUDdeRS4SG65HouaHE9Bo4YMGeBPHaUdl0qa3DBQJnMI8kXJWkRLDQpPfsTg7KwIqm+o8mUZkiQAQs/WqMjmqMBhoUG1jlpBenfEihHKInnU3OBMAmlbk/Ml4mZy0aWc1bZ/x0Ok20qjePb8949NgE5ttf8fjwSQX6mSgsomgT9f69Y3tDwdN6Jrrecrq6AnKrPFxuskY0g8BliHuIsI2wqSKEQmG6IIMc1JBvARX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0421785b-3cfc-4fe9-7b1a-08df2fe66000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 02:44:20.9499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjioHC7Nug68pQQmje/ugh0i73gouBkqoXeQAAK9eoH2COL7088KxtSTX6Hhs9URzbsCGECZH4fdWbIl0iPawL2M610lUNPmKxUipoh1qnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR04MB007031
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTEwLTIwIGF0IDA5OjU5ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gUklTQy1WICdaJyBDUFUgcHJvcGVydGllcyB3ZXJlIHJlbW92ZWQgaW4gY29t
bWl0IDQ1NWMwZmE5ZWVmLA0KPiBmb3IgdGhlIHJlbGVhc2UgdjEwLjEuMC4gTW92ZSB0aGUgY29y
cmVzcG9uZGluZyBzZWN0aW9uIGZyb20NCj4gZGVwcmVjYXRlZC5yc3QgdG8gcmVtb3ZlZC1mZWF0
dXJlcy5yc3QsIGFkanVzdGluZyB0aGUgd29yZGluZw0KPiBhY2NvcmRpbmdseS4NCj4gDQo+IEZp
eGVzOiA0NTVjMGZhOWVlZiAoInRhcmdldC9yaXNjdjogcmVtb3ZlIGNhcGl0YWwgJ1onIENQVQ0K
PiBwcm9wZXJ0aWVzIikNCj4gUmV2aWV3ZWQtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phDQo+
IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0KPiBSZXZpZXdlZC1ieTogQWxpc3Rh
aXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+DQoNClRoYW5r
cyENCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0DQoNCkFsaXN0YWlyDQoNCj4gLS0t
DQo+IMKgZG9jcy9hYm91dC9kZXByZWNhdGVkLnJzdMKgwqDCoMKgwqDCoCB8IDI0IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiDCoGRvY3MvYWJvdXQvcmVtb3ZlZC1mZWF0dXJlcy5yc3QgfMKg
IDcgKysrKysrKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyNCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kb2NzL2Fib3V0L2RlcHJlY2F0ZWQucnN0IGIv
ZG9jcy9hYm91dC9kZXByZWNhdGVkLnJzdA0KPiBpbmRleCBjY2JjNDIxOTQ5Ny4uMzY4ZmExYjRl
ZDMgMTAwNjQ0DQo+IC0tLSBhL2RvY3MvYWJvdXQvZGVwcmVjYXRlZC5yc3QNCj4gKysrIGIvZG9j
cy9hYm91dC9kZXByZWNhdGVkLnJzdA0KPiBAQCAtMzQ5LDMwICszNDksNiBAQCB0aGUgYWRkaXRp
b24gb2Ygdm9sYXRpbGUgbWVtb3J5IHN1cHBvcnQsIGl0IGlzDQo+IG5vdyBuZWNlc3NhcnkgdG8g
ZGlzdGluZ3Vpc2gNCj4gwqBiZXR3ZWVuIHBlcnNpc3RlbnQgYW5kIHZvbGF0aWxlIG1lbW9yeSBi
YWNrZW5kcy7CoCBBcyBzdWNoLCBtZW1kZXYgaXMNCj4gZGVwcmVjYXRlZA0KPiDCoGluIGZhdm9y
IG9mIHBlcnNpc3RlbnQtbWVtZGV2Lg0KPiDCoA0KPiAtDQo+IC1SSVNDLVYgQ1BVIHByb3BlcnRp
ZXMgd2hpY2ggc3RhcnQgd2l0aCBjYXBpdGFsICdaJyAoc2luY2UgOC4yKQ0KPiAtXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl4NCj4g
LQ0KPiAtQWxsIFJJU0MtViBDUFUgcHJvcGVydGllcyB3aGljaCBzdGFydCB3aXRoIGNhcGl0YWwg
J1onIGFyZSBiZWluZw0KPiBkZXByZWNhdGVkDQo+IC1zdGFydGluZyBpbiA4LjIuIFRoZSByZWFz
b24gaXMgdGhhdCB0aGV5IHdlcmUgd3JvbmdseSBhZGRlZCB3aXRoDQo+IGNhcGl0YWwgJ1onDQo+
IC1pbiB0aGUgcGFzdC4gQ1BVIHByb3BlcnRpZXMgd2VyZSBsYXRlciBhZGRlZCB3aXRoIGxvd2Vy
LWNhc2UgbmFtZXMsDQo+IHdoaWNoDQo+IC1pcyB0aGUgZm9ybWF0IHdlIHdhbnQgdG8gdXNlIGZy
b20gbm93IG9uLg0KPiAtDQo+IC1Vc2VycyB3aGljaCB0cnkgdG8gdXNlIHRoZXNlIGRlcHJlY2F0
ZWQgcHJvcGVydGllcyB3aWxsIHJlY2VpdmUgYQ0KPiB3YXJuaW5nDQo+IC1yZWNvbW1lbmRpbmcg
dG8gc3dpdGNoIHRvIHRoZWlyIHN0YWJsZSBjb3VudGVycGFydHM6DQo+IC0NCj4gLS0gIlppZmVu
Y2VpIiBzaG91bGQgYmUgcmVwbGFjZWQgd2l0aCAiemlmZW5jZWkiDQo+IC0tICJaaWNzciIgc2hv
dWxkIGJlIHJlcGxhY2VkIHdpdGggInppY3NyIg0KPiAtLSAiWmloaW50bnRsIiBzaG91bGQgYmUg
cmVwbGFjZWQgd2l0aCAiemloaW50bnRsIg0KPiAtLSAiWmloaW50cGF1c2UiIHNob3VsZCBiZSBy
ZXBsYWNlZCB3aXRoICJ6aWhpbnRwYXVzZSINCj4gLS0gIlphd3JzIiBzaG91bGQgYmUgcmVwbGFj
ZWQgd2l0aCAiemF3cnMiDQo+IC0tICJaZmEiIHNob3VsZCBiZSByZXBsYWNlZCB3aXRoICJ6ZmEi
DQo+IC0tICJaZmgiIHNob3VsZCBiZSByZXBsYWNlZCB3aXRoICJ6ZmgiDQo+IC0tICJaZmhtaW4i
IHNob3VsZCBiZSByZXBsYWNlZCB3aXRoICJ6ZmhtaW4iDQo+IC0tICJadmUzMmYiIHNob3VsZCBi
ZSByZXBsYWNlZCB3aXRoICJ6dmUzMmYiDQo+IC0tICJadmU2NGYiIHNob3VsZCBiZSByZXBsYWNl
ZCB3aXRoICJ6dmU2NGYiDQo+IC0tICJadmU2NGQiIHNob3VsZCBiZSByZXBsYWNlZCB3aXRoICJ6
dmU2NGQiDQo+IC0NCj4gwqBCbG9jayBkZXZpY2Ugb3B0aW9ucw0KPiDCoCcnJycnJycnJycnJycn
JycnJycnDQo+IMKgDQo+IGRpZmYgLS1naXQgYS9kb2NzL2Fib3V0L3JlbW92ZWQtZmVhdHVyZXMu
cnN0IGIvZG9jcy9hYm91dC9yZW1vdmVkLQ0KPiBmZWF0dXJlcy5yc3QNCj4gaW5kZXggNmE5OTQ0
YTBjNzkuLjIyNTg0MWJkOWJiIDEwMDY0NA0KPiAtLS0gYS9kb2NzL2Fib3V0L3JlbW92ZWQtZmVh
dHVyZXMucnN0DQo+ICsrKyBiL2RvY3MvYWJvdXQvcmVtb3ZlZC1mZWF0dXJlcy5yc3QNCj4gQEAg
LTEwMzgsNiArMTAzOCwxMyBAQCBpbml0aWFsIFJJU0MtViBRRU1VIHBvcnQuIEl0cyB1c2FnZSB3
YXMgYWx3YXlzDQo+IGJlZW4gdW5jbGVhcjogdXNlcnMgZG9uJ3Qga25vdw0KPiDCoHdoYXQgdG8g
ZXhwZWN0IGZyb20gYSBDUFUgY2FsbGVkICdhbnknLCBhbmQgaW4gZmFjdCB0aGUgQ1BVIGRvZXMg
bm90DQo+IGRvIGFueXRoaW5nDQo+IMKgc3BlY2lhbCB0aGF0IGlzbid0IGFscmVhZHkgZG9uZSBi
eSB0aGUgZGVmYXVsdCBDUFVzIHJ2MzIvcnY2NC4NCj4gwqANCj4gK1JJU0MtViBDUFUgcHJvcGVy
dGllcyB3aGljaCBzdGFydCB3aXRoIGNhcGl0YWwgJ1onIChyZW1vdmVkIGluIDEwLjEpDQo+ICsn
JycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycn
JycnJycnJycnJw0KPiArDQo+ICtBbGwgUklTQy1WIENQVSBwcm9wZXJ0aWVzIHdoaWNoIHN0YXJ0
IHdpdGggY2FwaXRhbCAnWicgaGF2ZSBiZWVuDQo+IHJlbW92ZWQuDQo+ICtUaGV5IHdlcmUgd3Jv
bmdseSBhZGRlZCB3aXRoIGNhcGl0YWwgJ1onIGluIHRoZSBwYXN0LiBDUFUgcHJvcGVydGllcw0K
PiArd2l0aCBsb3dlci1jYXNlIG5hbWVzIGFyZSB1c2VkIGluc3RlYWQuDQo+ICsNCj4gwqBQb3dl
cjhFIGFuZCBQb3dlcjhOVkwgQ1BVcyAocmVtb3ZlZCBpbiAxMS4xKQ0KPiDCoCcnJycnJycnJycn
JycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnDQo+IMKgDQo=

