Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB1606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=DKYPvlZG;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=ByPoYwds
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJkE3-0007CU-FO; Thu, 22 Oct 2026 00:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJkE0-0007Bx-W6; Thu, 22 Oct 2026 00:16:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJkDz-0007YZ-9P; Thu, 22 Oct 2026 00:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792642579; x=1824178579;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mYI3jQuazgYzwljEh1urouzDcWEsnPq1yfoZLRo/5Eo=;
 b=DKYPvlZGf2E2bk1yIhyYWotx/ovwmt68BcnEG/sU84DyRNVpzl4VOlkJ
 M18jAjCsq5k6s9tkfqluqYvek3sw89cXSQqvOHMDeO9svcyQpiGqW21iW
 kC8Rpd+b3F7Vdn5FdF4+uMjIBX1adQEqLV4LSWRwbmUxf3qI/wRxZHJvX
 rWfNAK1OQJKnz/2bWgoRdTEW4lDKCX4Wyr97fED7vA2xGBkUJ9E5jK3c2
 1yiSPuyKMoTWSk9qcULqgJAsqVOTyCWTRh0QeQ8koU1Bw8Cxa05ADWLfN
 KKDL/TQwCKgc8bxd4Ws4dLgtRAptrOFiFI/3RG82XK0cf8fUgJDGxL3Zv Q==;
X-CSE-ConnectionGUID: FxGsS++PTMe8sDayqxMbyw==
X-CSE-MsgGUID: bpMKJQocQq6CyZJzLBSqGA==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="158599246"
Received: from mail-westus3azon11010051.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.51])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 12:16:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk7keLulTnt6x7E7EyTXwPtrrVwYCgUUslNUI+BsKSKsx0HqgU1wa2ljTgvff4gYaHIlBesuCH1AvA542JL2q4ShVsneN28O1c0sFcu6bNyxOSgZR/gBJSRNCv5L8ILgEDkGMxtnQIFU+EO9aAECYqQDiFebx8UhzqGuwgJ1dA6hst1jYuJuazb1+wwGT7hxSzC7dJ+qxkxfOLd6arE7B39zEeZjaetNvpsMUQseYQ0aMppQHMEWqnJsW24XUANjLaQ6h6QmIY6jwyjzPt/W7dG45GygA9Stl8QyDPK5l1hpa8Zmj07KfsI2Cpw+5rl3B6etrvBNVgtjZ0p55HRT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYI3jQuazgYzwljEh1urouzDcWEsnPq1yfoZLRo/5Eo=;
 b=UugDCta4/XJKN5VmJHWwq17gNr9W4CLlyR3t5AxGazglXDHiaYDcSPo9PpSAI8+VH2kWRyaS7A2fA4M1U4FhJ0GP6nJROPpbMuXPnmZlPoFPHSJkcsFdrXLKXtO+UZAnepNDhZ82+a0vsbrKaQgS2AzyzLOFymMdP7cUlUA6io2+XsS8VQTCWM2QOnkC9kSsPIT3pFueEL73EKyCRxnBOG73pLvFCPng3neC3pZP/rPQKAjvyn5yGWgk8CyB81JMn6HLJwx3EXY3o2JlKV7BsjNpd5XqNC9C/98k/QFzUkWGectH+DCJgsbOckG98Ms+LHcX2VQKrzTtK+YYb7ZFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYI3jQuazgYzwljEh1urouzDcWEsnPq1yfoZLRo/5Eo=;
 b=ByPoYwdsYElsI7FUhR3mv+MBJf2nrlxLQW5J24EcBEoRFElVTzhlIGpmh/AeF80x4XdEUhTCkA3YKpNUqnP2W7xMh8+IPTD/lS7vOmiZ+A64r0ujqM4PGv9cfxl3+ne9Ynmhn9uhUCWXKeGzeNwcCBR/o38lOnMOtEy9KVruXxs=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MW6PR04MB8916.namprd04.prod.outlook.com (2603:10b6:303:246::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 04:16:15 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 04:16:15 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "sebasjosue84@gmail.com" <sebasjosue84@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 2/2] target/riscv: pmp: reset the derived PMP bounds
 and rule count
Thread-Topic: [PATCH v3 2/2] target/riscv: pmp: reset the derived PMP bounds
 and rule count
Thread-Index: AQHdYdpHMdsftphDnEaTZAlvKEWoibcI9HIA
Date: Thu, 22 Oct 2026 04:16:15 +0000
Message-ID: <8a5910272a5e3686f47b3bf262b2e6bd4bda8dfe.camel@wdc.com>
References: <20261022040258.1509306-1-sebasjosue84@gmail.com>
 <20261022040258.1509306-3-sebasjosue84@gmail.com>
In-Reply-To: <20261022040258.1509306-3-sebasjosue84@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MW6PR04MB8916:EE_
x-ms-office365-filtering-correlation-id: 0ad42056-e3e6-4b7f-6360-08df2ff336ec
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|376014|19092799006|366016|261021121427099003|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: vJ6eSf3kEM5Ila4PJQ86SpVm0VoJnnWOHaoPQQjO44HMtzcGNq6ahOrbNueRFYu6bxIrqVVX7aOmO84OFphdT05wSOqsSGxEzHkAnFUnNWdCQCVlqWEk+wE+GwYu66t2rEFLpXIBE7eak62L/UyV5FCgSYupyjq7pkEflGqFrq6uBlSkyLQJOAVipKmitvBTWBIeAWTCjB9NrZis8DIrML8dXqFCBo2FZlmZqouTDBBDzLeECI+K76/mHI/94S+viLSAIw3sM/Nacd026bT+Gyg2LDSq25rT/Qkt6sjn5KDbJY1Tox9qB+yy7SH/J6XINEn1hJZtz6SSqHpxJJ4K1lPSC9/vvNfYvRV/RlZUuyisyySthIgBDqTMCpokboHn7vUo/8jqP07IBTwITQZaEx2uhB+ziQiz5L1CAksrhYd2B1QJkvPXpQAPf8rYJjDXbjf7MT/bNPtTOXu2mi1y9VGYEUkQkum7fCgr9UVwM83yVGvRn/GYTAlBdd4OPnlK15DmSONIk3wS8T9m9LvTw8MT3Irk35jzriPpzN8rq40Id+dyStv9BqnFS7WbEgXNrSFONIyhyQ0uACWBnzTWmnbdN7HyKfAhYmcWCwfo1pHiYnm8HZJXARv60HezzFjP07vh45/vZHKGDiqMDTRHkwZOHZbcJUj5W7MU3ED5rVZaBoks2uJ4km3i3I1NIja56KwJh+l/YvUz1a3QMza8OiBD1f2n5qbw7aMXslxPIhg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(19092799006)(366016)(261021121427099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWVXZXFMSUtjY2tYdjBTNjQ3RXAwMUxsSlFjSllTSW5XdURxaWNlN0xlSzU3?=
 =?utf-8?B?ditkRG9Ic09uWW1TbXQ1cXdGOXhmVDIyQmxDbXRwbXFTTEtFVVU1R0Zqejlm?=
 =?utf-8?B?VEVPQWxGUG1sbVdINGJrY3RUWFFDMkhtY2hIY3UzVVZNS3ZmWmVqRnFYOVBO?=
 =?utf-8?B?NnhQYjM2dEdRV0tDdU9mUFNaeGFMYmtRQTFxWXh2MkllTFBVM0wxcW8xaDFt?=
 =?utf-8?B?RVhzMjFTUHBmUFRZcmt4SUpqTDZVLzhlWWU2RzFtODlnOEpQa2J5WWJ0MkpB?=
 =?utf-8?B?MU9mNHdoUmZMRnBHdGhUMzRQaElUbzVTbEc2OVB2VnY5bjRIN3RwcVlrVnRa?=
 =?utf-8?B?ZCtRdTV2RTh6SjVSVEhaZ0RvK3I5RjQ1c01NMC96Ylhab0FJZHpDaUNkMG9u?=
 =?utf-8?B?a0xGeTFSSEVtc3ErT3ovME0zOVZKdmQ2WThDbjlsWWl5Mk1CMVh3WFFjWWtz?=
 =?utf-8?B?ZktGWFBMazd5U0x4eDIybnY2YmhiTnpUMWpwcnZzUUtTOGMzMGlRMHJ6RzlI?=
 =?utf-8?B?YzJ6NzF3OWpoZE55eDczZ3lBZEs4T1dYak4zR3EySmVHcG0wUC9kWEZ2NUpY?=
 =?utf-8?B?ZVFwR3ZtWVhHRDVFUTN2U01kdXlRS0xIZmZZYlV1UHlnNlJsZ1psc3ZNclM2?=
 =?utf-8?B?OVdkc0NseUF2Q0tCZUdUMVV5c1FQZ3BsY2kwOVE3WWNyL2Z0ZDViR1BTT3VB?=
 =?utf-8?B?ZzZiSW1WZCtCZUxpVU1mcStEL3lFQnNjSmRnL00rWGhHMFhDV28rZlBHRkQ1?=
 =?utf-8?B?ZFJJUVJxbStmWmx0akNwREJ2Q08zVytzV0JWNVFBY3pyUGs1SmFZanR0L3Na?=
 =?utf-8?B?anJtQUJsTlI3ZDV0b3NlNXE3RWkxQzNZblFEVE5KSzRoQXNlUVM1anVXbXF6?=
 =?utf-8?B?V1RZYVYxUzRVY2xQY2JINEFJYUVkR3ZCb1dVeS9wQkRiY01lSk9Fc1B0QTdi?=
 =?utf-8?B?Y3REUEpGNHB0bDhrRWVuVjhCRGFENTZ2VkZPeE5FSWFXOFNMeVhtKzhtYlgv?=
 =?utf-8?B?ZGdGcXlieWFPVFFWUEVMRW8zQUlhSnZ6dTlGWnhrMEpmU2RKWTZsUnc5akN6?=
 =?utf-8?B?cVRWVE55bnp6RFFuMUdpY0NBQWJQalJZTlY1MU9iK0VJRmRrLzJkdHlCZGs3?=
 =?utf-8?B?TUpWOGw4WE9LNVNicFlxZXlpd0UxczltMmZSbXNlVElEcEFCeEZGL09QVFhl?=
 =?utf-8?B?WTRnbHdpOW9ucS8zdUJNSjFjelluV3VGcWQ0d0d5VTVDcnhHUE53ZDB0RkRk?=
 =?utf-8?B?YjUwV0x0aWNsOHZMNENUMzFRZ3JxWXJWd1hqVlZpZ1RtM0k2NXd0ZFZ5OHJN?=
 =?utf-8?B?QUJITE1mdTBpdjNnRVZEZm10TllvWnVITnE3QzdUaGUwV2V3dU5DOFd6Tkcy?=
 =?utf-8?B?bWxaWHFKeDlVV29kakxGSnVncjZiWVl4SmxOZVF5b0VLb1JjSWRsMnhydUhn?=
 =?utf-8?B?SEJlTjI1ZEV4YVFMOHp2RHZ1RFQ4TTdYdjVlUG9DWUJzcERJaUNPVzNTTlow?=
 =?utf-8?B?OUpLL3RhRUVxWnRyaEFyNlVDWnhQcGp3UVBiYmszd2RXellaWnB2WXJTbUkw?=
 =?utf-8?B?cjZvdFRlUUw1UVVqWE5Ha1FiS05mMlpCdFk2Rkw3azh5aUpZRTZPYm5HRnov?=
 =?utf-8?B?WmorR2tLZUpFSkxNN0o0M3UyT2hFOGxTNk0vU2JDOEJuYXRoTEppT2k2NTFq?=
 =?utf-8?B?UE1nMmlaSzFGQkdHT3NpbUswY0QvK0NKOVRVOElHVStUNFZQbUhFUkZLOFh2?=
 =?utf-8?B?OXpGVU02a3plMzJoUVRPRzFPM1BkREVkTkNGTzNJYTU0dkJmeEkxVVhoN09X?=
 =?utf-8?B?cWNxcGQ3TUxTaWZ0ZVJqSkQ2VzhwYTRCL0xNc0JmbTUwVzdOYnhFSFNOY2NK?=
 =?utf-8?B?OTJFMkdFRTlYQTExVWxlNmtRaUFVSEJVUldKeTRZclY0dkZ6STN3NXQ4UnNX?=
 =?utf-8?B?TTY1N3JPOEdqUFg3dElFNFY3M24rQWVNcUpHSmwxMk1kV20wOGRDM3B0Nk5M?=
 =?utf-8?B?RVU2bXVOUVFrV3dSU1B3Q1lWUC9ONE80NktrNEExVzNoNjY0STVEOVA4NllE?=
 =?utf-8?B?ZE5IUDlqdHZtSkZOZmVLeTJuSXdIR2QyU1ZZMnVnTWNkenNaRnNnSmhSTnF4?=
 =?utf-8?B?TFJwSnNyZnM4bk9KWmpjdzdHdXVjbjc4c2FLcWJweTVEWFhCNFA1SHoralpJ?=
 =?utf-8?B?M3cvOG00Z21zc1pVSVplZTdkWWVEMHdQc2xmaVdaZmZGUGFJN01wKytlR2ky?=
 =?utf-8?B?RUdBazNQanN3Y3JKSGN4WVpCNUowT2ZXQU5kbDlDN2J5Y2Y0dXU1UEVobGNZ?=
 =?utf-8?B?eTErL2FiNkFuaGtYQ1h2bWdFNXFsaEZJMXM4M3JrYUdFcHNYZ2Fzbmt1YTF3?=
 =?utf-8?Q?wc67hErGPwe7Vg/WTvwXZ3teIipavgI6bJKK/wPVAJt0F?=
x-ms-exchange-antispam-messagedata-1: HlQkCJWXb+gVtUf2rE/3fEb02zKXu3iTIU8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <573A1A7AECDC6D42ACF772E7D853A7F0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h/LeQtOf0h4JCEKwJcOa/kWcVBEYGhLHfwl4jL0D4AmGJCL2k9i5HofKCBHfYfBgzWHb7whRpGkz5dWr/JAbphrkb7TGj8Y6yJhSquV3bc3VAXoiCzEkPdM8fEbv74cyU1Dnk9dAFKgkUVm+8fgSzgi2jKJskpoOmSVsDdo75Tmzp6NljDmky6PEmlPrxpE0NXb9knQxzP9WkpR1EzSUpDH2fHb0FG2xkenG8tNB0SYyhAE/gXwQAb0GcxWD2Nv36JnzNikMFvLiR1oRRyXEhe1l7aGEZkWs2q2a2mak4RSDPxni5gogrqE9Nj3NtjOwsDVCW1zySEsP9xvdpp6o6w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Si+gkqC4d6mtPnUTcf+Br/SW882Uydhb6Se/wHPdEV3O7zz9yE/+wYgiU1K3OfB6lOdSQdNsYoGHxYQ6o4rWMf70CEhG3f4//HnNe3QuQozMPvEFSgNYJMmAK5lWIzHb3GmPKxtW4GZ8/ZMPt55NENKvY9XidrLgSVTj34o0RDjICAkETHMyx2eQ5wdIUymdf1vSPHhYoGeEhkwkJtsiOno17NTkz32tsFXL73MRZUWax+QySgqL2luZpEBhoU/W+C4rlpKQ05XKN6JwO37KA5lM6powVcnK6yObwO8ohqEg3KmR2UojyN8C34/k1wtw6nL/TJs7yMVshQmP+AGuxuv0EubkG4FAOIOLMDoRlkkYH/RjGBx9TkHGq97skXyAVcBG2QeMUZD4LajHqlGRhvs0e6olAxZrUBeM5JItpstR+/Pk2Ld/ohodTcQs7R2WTDKyECKVE9wMjE+QxAyE7V8ws/ktIggEKOre5MgQt5PrTwZJKK71yiDFI1VHS0q5W9A8rkXHU/H90bxF1oacmrWyITGFOoHm5HUKkSeSXkac8BX+aBiPJDUCT41aemVLqx6dgk5v36pwfAZV/fnU63cQbzxM/faziF2XOPv2SrNcLnj2gJqgE/hJflO6AKwY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad42056-e3e6-4b7f-6360-08df2ff336ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 04:16:15.4312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCcyo4H5EdIMAY122PCdAgHXEupDgBXJHFR9gGMte+YzwxaihhnWMsBS6R373Wm4mh253x/sg8LUylfj8CS+sn+OBxNxUbbUcRYpHCZlULY=
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTEwLTIxIGF0IDIyOjAyIC0wNjAwLCBTZWJhc3RpYW4gQWxiYSBWaXZlcyB3
cm90ZToNCj4gVGhlIHByaXYgc3BlYyBvbmx5IHJlcXVpcmVzIHRoZSBBIGFuZCBMIGZpZWxkcyB0
byBiZSByZXNldCwgd2hpY2ggdGhlDQo+IHByZXZpb3VzIHBhdGNoIG5vdyBkb2VzIGZvciBldmVy
eSBpbXBsZW1lbnRlZCBlbnRyeS4gUUVNVQ0KPiBhZGRpdGlvbmFsbHkNCj4ga2VlcHMgZGVyaXZl
ZCBzdGF0ZSBuZXh0IHRvIHRoZSBhcmNoaXRlY3R1cmFsIHJlZ2lzdGVyczoNCj4gcG1wX3N0YXRl
LmFkZHJbXSBob2xkcyB0aGUgZGVjb2RlZCBzdGFydCBhbmQgZW5kIGFkZHJlc3Mgb2YgZWFjaA0K
PiBlbnRyeQ0KPiBhbmQgcG1wX3N0YXRlLm51bV9ydWxlcyBjYWNoZXMgdGhlIGFjdGl2ZSBydWxl
IGNvdW50LiBCb3RoIGFyZQ0KPiByZWNvbXB1dGVkIGZyb20gdGhlIHBtcGFkZHIgYW5kIHBtcGNm
ZyB3cml0ZSBwYXRocyBvbmx5LCBuZXZlciBhdA0KPiByZXNldC4NCj4gDQo+IHBtcF9pc19pbl9y
YW5nZSgpIGNvbXBhcmVzIGFnYWluc3QgYWRkcltdLnNhIGFuZCBhZGRyW10uZWEgd2l0aG91dA0K
PiBjb25zdWx0aW5nIHRoZSBBIGZpZWxkLCBhbmQgdGhlIHBhcnRpYWxseS1pbnNpZGUgY2hlY2sg
aW4NCj4gcG1wX2hhcnRfaGFzX3ByaXZzKCkgcnVucyBiZWZvcmUgdGhlIEEgZmllbGQgaXMgdGVz
dGVkLCBzbyBhIHJhbmdlDQo+IGxlZnQgb3ZlciBmcm9tIGJlZm9yZSB0aGUgcmVzZXQgY2FuIHN0
aWxsIGRlbnkgYW4gYWNjZXNzIHRoYXQNCj4gc3RyYWRkbGVzIGl0cyBib3VuZGFyeSBvbmNlIHRo
ZSBndWVzdCBjb25maWd1cmVzIGFueSBlbnRyeSBhZ2Fpbi4NCj4gDQo+IENsZWFyIHRoZSBkZXJp
dmVkIHN0YXRlIGFsb25nc2lkZSB0aGUgYXJjaGl0ZWN0dXJhbCBmaWVsZHMgc28gdGhlIHR3bw0K
PiBjYW5ub3QgZGlzYWdyZWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gQWxiYSBW
aXZlcyA8c2ViYXNqb3N1ZTg0QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZy
YW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4g
wqB0YXJnZXQvcmlzY3YvdGNnL3BtcC5jIHwgOCArKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL3Bt
cC5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuYw0KPiBpbmRleCAwNjFmMGUwNzhkLi4wNGRmNTNj
MjM0IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL3BtcC5jDQo+ICsrKyBiL3Rhcmdl
dC9yaXNjdi90Y2cvcG1wLmMNCj4gQEAgLTIwNyw2ICsyMDcsMTQgQEAgdm9pZCBwbXBfdW5sb2Nr
X2VudHJpZXMoQ1BVUklTQ1ZTdGF0ZSAqZW52KQ0KPiDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwg
cG1wX251bTsgaSsrKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgZW52LT5wbXBfc3RhdGUucG1wW2ld
LmNmZ19yZWcgJj0gfihQTVBfTE9DSyB8IFBNUF9BTUFUQ0gpOw0KPiDCoMKgwqDCoCB9DQo+ICsN
Cj4gK8KgwqDCoCAvKg0KPiArwqDCoMKgwqAgKiBhZGRyW10gYW5kIG51bV9ydWxlcyBhcmUgZGVy
aXZlZCBmcm9tIHRoZSBwbXBhZGRyIGFuZCBwbXBjZmcNCj4gd3JpdGUNCj4gK8KgwqDCoMKgICog
cGF0aHMgYW5kIGFyZSBub3QgcmVjb21wdXRlZCBhdCByZXNldC4gQ2xlYXIgdGhlbSBoZXJlIHNv
DQo+IHRoZXkNCj4gK8KgwqDCoMKgICogY2Fubm90IGRpc2FncmVlIHdpdGggdGhlIGFyY2hpdGVj
dHVyYWwgZmllbGRzIGNsZWFyZWQgYWJvdmUuDQo+ICvCoMKgwqDCoCAqLw0KPiArwqDCoMKgIG1l
bXNldChlbnYtPnBtcF9zdGF0ZS5hZGRyLCAwLCBzaXplb2YoZW52LT5wbXBfc3RhdGUuYWRkcikp
Ow0KPiArwqDCoMKgIGVudi0+cG1wX3N0YXRlLm51bV9ydWxlcyA9IDA7DQo+IMKgfQ0KPiDCoA0K
PiDCoHN0YXRpYyB2b2lkIHBtcF9kZWNvZGVfbmFwb3QoaHdhZGRyIGEsIGh3YWRkciAqc2EsIGh3
YWRkciAqZWEpDQo=

