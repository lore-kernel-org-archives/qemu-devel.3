Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2D606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=kjEamKj6;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=LjJISmm6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJQE-0005e7-01; Sun, 22 Nov 2026 21:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJQB-0005dO-VA; Sun, 22 Nov 2026 21:04:44 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJQA-00040Q-Aw; Sun, 22 Nov 2026 21:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795399482; x=1826935482;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=tcboKDN5wW6D9wQOqqDy4PuLcAQZQaqRmTaU4Nga6fg=;
 b=kjEamKj6U/+JjhRDZy2lk3BUnv7Wyk8J7+Nfk1Vy6Abij2eCAJB7FOmI
 kZBXXAiqfMj/NPAm1LINjpiBQsoPMXJonjIXK6YKrjHA32gVxvb4OsdRk
 wlJ/G00P9hCe4JamcxN50E4foImI3aN1H8rEcawO4Lyva9QRZ0awPaNbt
 4QjcW1QSxRiwRFvk8OzYyHYhIXIAe2L3goCHcNa835bXiAN6iZj5ACWQU
 mahuEHO2UhrifPmxBU39W397Xvf89ewOLPebUy0k9Vn6354avZnV3zmgX
 XGHptW0QweWIIrSyF+AG8KWIU5BBXrp/SibnGSfJh2TCNKBmXXAfHPbYB g==;
X-CSE-ConnectionGUID: VWZiAE0tR3m9sNjovw8v5w==
X-CSE-MsgGUID: x7pQDvkuTG+0pnBsR0ihxA==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="159903495"
Received: from mail-westus3azon11012061.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.61])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 10:04:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYbj9e7sNaw7YmmfelVkRKKDNG95xLRwwAC2uzfx6pDEuvqq8q66PGjwFQ1f/QDurbzZ2/phm7CMCaBd7t3RVMe07VL45syARtbF+SAtxw+jzk7Gxn4BKN7GOg6G8X0cUFxUjy99MWu4gWmPe86IP0FnbniDHgFzMnf5alLVNiTgQDJ11zfM99piovsihILV8dBl8zPkkOTKFcEKEWUagYpzSoyKnUYoI2rMutKxBX2TtF7X3FdPnBJ/6tqtJ7nCDs6y/NcmbV+vaa7q4LaVP70biH+pzbVGG2yHYv8Zlcnys01kp2gyaiOm7BuduQ+siDZfMAHX2AqQzQIYV8nMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcboKDN5wW6D9wQOqqDy4PuLcAQZQaqRmTaU4Nga6fg=;
 b=uG8Lj3SjDMT/08F1KpZwMcW0v16flCEvnRXpFoMK3Zxj8ChbFuhxCvCaNOij+AJK5e2MbrRnAz3/1R9W1ZVWvfsMTDjrZDDVIM+z5ZKgU2m7nuiYFkx2dq+NS4O1ePMa02EPeP6fwlQ4h1er1I56JsHwjF9iIGVZHswGipSUobQhuKIhT58P7gQ3WueRw3DbWlpgjW4A5RIq/BoDjC8Sxc6VfIgzpo/yuXFGh2lmaZd8uGduebyTND4riP8Ip8Q5h6FVBf+LhRdAOxuNAu8xuhS+ndZh/bOZGKMdnfx46RGO93S+knOS8HGMIJ6QT1XYFnt5oxj81LPxEEl8msrugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcboKDN5wW6D9wQOqqDy4PuLcAQZQaqRmTaU4Nga6fg=;
 b=LjJISmm6Zm4c+f+Pfs9gYnEo93you4HtSbS1iLQwM1yrVbdsYR50yNpziqzOPwhnIYZnVUrnphRSPgMxsDvugzcKp5TBkpfqUDfMGvPuLnou0j3J2U5ecjVLH49ycqtAKFG8Cjthb/nTh4AnFN+iWJDF/TAmsCk2OwNUW2egpoI=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ0PR04MB7485.namprd04.prod.outlook.com (2603:10b6:a03:328::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 02:03:51 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 02:03:51 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "christianslima@proton.me" <christianslima@proton.me>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: make mstatus.SPELP read-only when
 S-mode is not present
Thread-Topic: [PATCH v2 2/2] target/riscv: make mstatus.SPELP read-only when
 S-mode is not present
Thread-Index: AQHdc7jd3PdnrG1cK0+vguo1O33fMLc69lCA
Date: Mon, 23 Nov 2026 02:03:51 +0000
Message-ID: <83d2297e6ccc452a516a7e8529eba037a03c3015.camel@wdc.com>
References: <20261113214854.40425-1-christianslima@proton.me>
 <20261113214854.40425-3-christianslima@proton.me>
In-Reply-To: <20261113214854.40425-3-christianslima@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SJ0PR04MB7485:EE_
x-ms-office365-filtering-correlation-id: f27e41e0-e22e-44a3-f4cb-08df490604df
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|19092799006|10070799003|18002099003|22082099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261028144727099003|4143699003|56012099006|10067099003|261102123227099003|38070700021|11063799006;
x-microsoft-antispam-message-info: ZVd1jSLzkMDiLovXLC6lYL9qti0jgufBkhOWMErLZvMIWyjGCnGtQ3dkXe7dmt/YbPnfr17rsQ9e/GHNXFlOfupe2AaMnd8FJttCDuzC/86CHaTuir+DAfEpFSh56dBISqlJmeplLEqav1HLnMpfbbiyQqXNpt5OpMmYf+kg6gwTIqNjCe9RGioIzbX293EEwE6AD6295PfZamxXR4HNSIp3+8YGvuM6fV39Dp4rNuZImDZ37pX1KJ/PSEV97vFAYFk+LYiGTzmnOxJCWW367xCJ7FR9yKuIYngVtFH7GzcYB4/+Nv7vC96O/ibVsNMSaskYwr/MenPOY7z+JPz0SA2c6eteexP8ofkgt08tWQcJlHl/IYhxCWtkQI97NRqVwhjOS5w87Ea+PxcsPlVWuweP+mcJHy4XPB4Tv7nUOmkOkfGP8ofRZy9XoQEgYvg0TZ+JOuJNkhGa8qy2iq6D+cq6CEQDbN+QqH+gytHGELuyxBMB/XAu18VFEtp7XBm/BIy2imLklcOd+VUnB4XpWdQFDiLBpYR3kaEjhP4OTBmWRg+CAXGUCDVJiQvKhp42Q5p6pr4r0GPsKj90u8XE85uRd7mJdJyPdGUA6D7Z5VrA9y87EdYu76NeDc1SCbta4o5vEPbB18ySQ2joZBCUsYjR317CldNP1ZQppo5bHow=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(10070799003)(18002099003)(22082099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261028144727099003)(4143699003)(56012099006)(10067099003)(261102123227099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmwvNWNpcXVUK2tBVVNUTzJMOUhWNlFXRGpjWlpQQVU4YTNXdVk4bDlRQk5K?=
 =?utf-8?B?TmRxTDlmc1owUERDTTFMa1FwdmpUQnZkOTAxRW42ZGFUcWxIN3BMeVM4ZWhR?=
 =?utf-8?B?UHlxK1BocnMya2NWSy9LVlRzNkhPM1p1MkNsSVcrQ2trR0R1dDl3YnNZU3pD?=
 =?utf-8?B?cDZEcjc0dTlNVXoxd2duemJzQTlEMlRneG01TkNRV2tzYjRWUi9ic3BXRk0r?=
 =?utf-8?B?QUx1UDNuRnlCOVROZnhQN3Z5aHQxbE13T09EbFpQMktKT1JWSFp2UjNwbng2?=
 =?utf-8?B?R3Zkd3loQ3dKcXFkWThLc0h1SVNzQjhidU5LUFdTbFF6anFYSDhaOXR0aDl0?=
 =?utf-8?B?Z0liQU1xMzFlcEtKZ3FYZ1JqR0o3T2hLWEtEVHh3Ymo5NU9wOGoyZlpsT0RW?=
 =?utf-8?B?ZUtYNHhxdlBMYXVYVHo1cFl5SHRiV3FyUWxoRlVpN21JcFQ5VHErWWZYYlhs?=
 =?utf-8?B?SmkrMmFLOTJLQVlTUVd2dEp2SjJ4bi90aGVTM0pBTVNXN1U3NUlIWU53V1BC?=
 =?utf-8?B?NW5rTjBEbXRzaGhtVWNLSW1wVWpQZDIxS1BnYVA2L1ZTeHNJaXBid1Y2TThV?=
 =?utf-8?B?K083RnA3YjU3dDBkN3FQSUk5NlVFTTJnU1RwNUhtY0JVOTRUV0Y1Sm0zVkox?=
 =?utf-8?B?dHQyaHdMTHdpTzQxS2dGU1V4K1JndUJ5U1JEcFpqc1FFTU55bmU2SXZnUW5a?=
 =?utf-8?B?UWhqQTZKR0tCdkZaTWNKVUk5dWptdG4yb3QyVG1NTVFXV2Erd0Y2am5lQmVI?=
 =?utf-8?B?d1hrbGdsdWdOS3FDWGJ5bDRJcGZDZTE2TjNnY0lpMk9JeHYva0gzenNsM0pn?=
 =?utf-8?B?WjBGRzRrK1lYN25jZ3R1eWtxb2ord0lGZktrMHBMRnI1V25vc0hTd1RQV0Ju?=
 =?utf-8?B?VVhyN3ZZVzY5M3cyQUtCcWNlZCsxM29OTUpQcXI5ZUllVHJ2VW1EYVdLbEFU?=
 =?utf-8?B?UDBTeGp3b29WREpoaFMyVHg4bHFQMVg1L2JtSkpoNnhiWnpEUTdYQzNKYVVH?=
 =?utf-8?B?MiszSU9ML0k3UmZEME02UmVGOVFIaTB4dmVmYnpVdWx0WFR2U3c0MWtWVVU3?=
 =?utf-8?B?VlkvNU1LTGg5N3gxbk1mMXY1VHRtZTY4Q2piSU9wUDJpY1hCVnM2TGp6bmVG?=
 =?utf-8?B?dTdyTjhXYWcrelRPejMxRDEzN2Q1eWVabnI1aFpFZVpmOVQyU0ZhQjhwWUtC?=
 =?utf-8?B?REt0amJKMEpVUG4za1R4aEZ0VGxIcHNmWmpBL2l1KzByTlB2UXQrcXNzcmVJ?=
 =?utf-8?B?VEVYNG96YTJZbVRLMEQrQ0VlK0xOc2dkRGltc2wzRzJrMFI2aTduY3R4WWFD?=
 =?utf-8?B?UFo3OXZjVXBMVTRpcnRRSmxSSStyRUl3cE1sVWNhWUVsdkIrRHBOZC9MYjdQ?=
 =?utf-8?B?UGFRTENNUHNrRjA5VFRzVFhaSG5abnhDMFBZRVVtd1oxL2t5K3NIbjRSWnF0?=
 =?utf-8?B?eitwMWN3L0t4MnZhQVlCK09sYnlaOU1ocHozaHlFUDdsbE5pR2lWeTJ5NThM?=
 =?utf-8?B?cnI0eWtXQm9MYVV0eWFnNkk3dzNBK3VXSUJtQ2JvWTZWczdncVphTjkwSnRH?=
 =?utf-8?B?NzBKb0Zob0FOdTJhVGhJV1QwelE2c2JpV1BZRjU1SG9XeVZPM0FjNVpuUVdB?=
 =?utf-8?B?bHdxYUszR3pJeUNtcnNkYXQrTkVPbWt1NGdVaDNUMms2UTFYenF4Rm9acE12?=
 =?utf-8?B?UEV5SVpzR0VncHZaR1FNa1JzenlRM2pOQ1BiaUw1UkUrazV3WHZmUXdkVFdG?=
 =?utf-8?B?aHk2V0o3K3N0UkhZcWs0NWxyUC83R2R2VnNKT2hTV1pxVTk2eFY1VHM5MjR5?=
 =?utf-8?B?M2gwM0kwdlFJazhtdWp4L0xPdUpEWjRYNFduWDQwa3pkSGkySk5BRytvMDdk?=
 =?utf-8?B?bzdaUVkvZC9hd1RkM1VjK2FTeUlVUDhISmpUTW1qYXVpM25WNW9GY05NU3p5?=
 =?utf-8?B?M3B2V1hZdnI3TU5SNkZqRDNWVXRpL04xdGRCNDhZZXhjeFBwQjUxV3gzRlFZ?=
 =?utf-8?B?NWVNQ1R6NURpbzhJMVJzTmFVdjFqYkx1T2R0RlhuTEdGQUQ4cXcrU3o2UmlJ?=
 =?utf-8?B?YS92Z2ZRazV0dFpBODNvbVYrZEdrU1pwMWdQTVRwNk1Zek82RkEvTUVaeU9v?=
 =?utf-8?B?Tnl6WEhlNkNDbVRuZ1N1THZPaE9pUGNETThHV0RPUVMyU2hlQ3hJN0FVajBx?=
 =?utf-8?B?bmNZaFZWVWN0eVZCSEFMUVB1NnY5R3lSUGxCOFRvTWtpQ3pETisrcUVuTDJh?=
 =?utf-8?B?Rjh6V1dTYnRFMHhjWlRVZkJnTy9jZlRpSmxPK2QxRSsxbjNURjZoYnQ1RXZx?=
 =?utf-8?B?cUovUkRmMUg2dXE5dS9qYUVidkp2TjJUdktsS0NQSG5WQ0ZSTng5ZXhxRitP?=
 =?utf-8?Q?4kyMjUinkJPxdj1aBQ8oP/JGtDlVfqBvETKespBYXXXu1?=
x-ms-exchange-antispam-messagedata-1: iiCZxC0LHSuOMPCNw04EX42JNrcDBV4Grv0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83DD1E5914205440AD705ABABCA4C3C8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DbNIrbPNj3xat/Ob1RUlrS4UDCm9RT1lot+K0pKp3+TE8aSdCZl+VjC2YMETSDMMob0LvQQu2y4wWaUk/gHsRr45en6Atrtgw9EqUu7LmnkwsH6/shd7WDqCHbZ0f2afeqz4qVg2Y73iDJr/g58srdZaV1D9kjKKxmrFd4NiN7rjvlojEUYURhZUNw2K934p0k0y+D+qD4nt3dV8PC9dbThWQ6DnF4iFroGBhrhdS+8nzCo+dZYH5nW2++roJon1PCXUjJAfYWdx0R8MqIX5aFpuGq9Ou3tjVEaeTp8DtL9tHLzDTSryRUbUqh4bYgIryCqmMumad9tae1m4bVQIIA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EhaLikx2l3zfRukZ2tEE0CKXGyw0aP+Fo6SulLptmRrcPfViFfwynC8zHY/4hyJthmXLRbMBIXGrCbUhPDs/LoZSamsXkoIA3gV+VdIR+/Pv2z4JeOjPtYteXn4c5QO9VTf+MVHJQI3SS239LBrf0/gd9Vra9PrJ1tcmfBppvh9L2vSQn1AKnOaePhN3rGyBLA1VRKpcfKR0M2cPkJ9/GAmlSdrhGg1ChzdjIKo3J60O29MqHJgOxXjjM65pgYnWl9F8rZBxsPaT5GUkC6aE+w3pPMO+wXDwBBOExWjjqyKN4WOWZidZ08v/okVNtqZkvbddf2aBqHRPhMyOPhTaiB7IzjpfTDrE5jQIbRdrDEYYr7/Z2WawQy6lgvGEWeUW3fKPmp7CQvE2tHlAk9drHNxILt+qFIhFvTHIifMtkiaIl54oPdnrZa0VZ4P6z4Vg+7dOkzFu3LWw5fFv1ClDNoVrX8zOP4NZUgExSp3ukFjlbYtHfCVOqHratkB1e2iEGjew/q0cf3OlvRYDwLxXlibIj+J2+pmdShmVqu+u+qiKJWDGKGUg5WMrBRYL9TK9WGWKYwkWEGTjzjT39uC30mrzHNd1l36u7H3qKCTpClonDYQWEI0JBiWaareoDVDR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27e41e0-e22e-44a3-f4cb-08df490604df
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 02:03:51.0215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JBI6EJQdjbfziL+SjZE0VJi+D2N+k16ePyboFpDyU9784GUnflpuXjNu8kU9LoKHkM5ucbq9ELC4IUuN0MVYMmO217EzTAxkLuRAhVAufU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7485
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gRnJpLCAyMDI2LTExLTEzIGF0IDIxOjQ5ICswMDAwLCBDaHJpc3RpYW4gUy4gTGltYSB3cm90
ZToNCj4gQWNjb3JkaW5nIHRvIHRoZSBaaWNmaWxwIHNwZWNpZmljYXRpb24gdGhlIGJpdCBTUEVM
UCBpbiB0aGUgbXN0YXR1cw0KPiByZWdpc3RlciBzaG91bGQgYmUgMCAocmVhZC1vbmx5KSB3aGVu
IHMtbW9kZSBpcyBub3QgcHJlc2VudC4NCj4gDQo+IGNoYW5nZXMgaW4gdjI6DQo+IC0gQ2hhbmdl
IHRvIHBhdGNoIHNlcmllcw0KPiAtIE5vdyB0b29saW5nIGNhbiBjbG9zZSB0aGUgaXNzdWUgaW4g
R2l0bGFiIHByb3Blcmx5DQo+IA0KPiBMaW5rIHRvIHYxOg0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LXJpc2N2LzIwMjYxMTEyMjE0ODEwLjc4NzQ3LTItY2hyaXN0aWFuc2xpbWFAcHJv
dG9uLm1lLw0KPiANCj4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3Qv
cWVtdS8tL3dvcmtfaXRlbXMvNDQ1Ng0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIFMu
IExpbWEgPGNocmlzdGlhbnNsaW1hQHByb3Rvbi5tZT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWly
IEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0N
Cj4gwqB0YXJnZXQvcmlzY3YvdGNnL2Nzci5jIHwgNSArKysrLQ0KPiDCoDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJn
ZXQvcmlzY3YvdGNnL2Nzci5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiBpbmRleCAzOThl
MzEyYzlhLi45ZDAzNzhiYzY5IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2Nzci5j
DQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gQEAgLTIxMzEsNyArMjEzMSwxMCBA
QCBzdGF0aWMgUklTQ1ZFeGNlcHRpb24NCj4gd3JpdGVfbXN0YXR1cyhDUFVSSVNDVlN0YXRlICpl
bnYsIGludCBjc3JubywNCj4gwqANCj4gwqDCoMKgwqAgLyogSWYgY2ZpIGxwIGV4dGVuc2lvbiBp
cyBhdmFpbGFibGUsIHRoZW4gYXBwbHkgY2ZpIGxwIG1hc2sgKi8NCj4gwqDCoMKgwqAgaWYgKGVu
dl9hcmNoY3B1KGVudiktPmNmZy5leHRfemljZmlscCkgew0KPiAtwqDCoMKgwqDCoMKgwqAgbWFz
ayB8PSAoTVNUQVRVU19NUEVMUCB8IE1TVEFUVVNfU1BFTFApOw0KPiArwqDCoMKgwqDCoMKgwqAg
bWFzayB8PSBNU1RBVFVTX01QRUxQOw0KPiArwqDCoMKgwqDCoMKgwqAgaWYgKHJpc2N2X2hhc19l
eHQoZW52LCBSVlMpKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1hc2sgfD0gTVNUQVRV
U19TUEVMUDsNCj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiDCoMKg
wqDCoCBtc3RhdHVzID0gKG1zdGF0dXMgJiB+bWFzaykgfCAodmFsICYgbWFzayk7DQo=

