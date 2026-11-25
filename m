Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD180606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=FzNw9/P5;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=nBH+16If
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW23P-0002QI-JZ; Tue, 24 Nov 2026 20:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7821f5b77=Alistair.Francis@wdc.com>)
 id 1xW23N-0002Pz-S6; Tue, 24 Nov 2026 20:44:09 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7821f5b77=Alistair.Francis@wdc.com>)
 id 1xW23L-0002Mj-J3; Tue, 24 Nov 2026 20:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795571046; x=1827107046;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UX2j7YBXVdMz98fsZogKBLJBanMETuE/e0YrRgbfjmg=;
 b=FzNw9/P5zdlLvral33a2V8lL2Q3/pnTFVB1/I8911BIrwqMKZpUxaGjU
 9Hu1gU+RLzfwt+s0lgPVMIeFUbwhLD78gw3Azz6LDfW4b+AQAzM/TgeGy
 gINvNGIjeQGut44aX3DoFGaPKJ3/cUxFE6lQVgQ+l//urs5g+rp0sa6ul
 C5sWL0KiiRYnqVPAsSq8xbhsYyuaWrfpTJaDNarxJjWZ4E3fnniJdInMq
 D7CabW1JTnToJX4bG/pYp1VR66C1CPMprgor6gRjuYflbGsbWgc/xcvaG
 MjEdsColUBgCl2Z8LiQoQ/JRhzbENPaiRxezxjxbILvsv+sTsFs2NqGPM w==;
X-CSE-ConnectionGUID: G9kRHQZMTfua54XeA2cqHg==
X-CSE-MsgGUID: tlymbDDvTMuXPgrsNCjXaw==
X-IronPort-AV: E=Sophos;i="6.27,231,1786982400"; d="scan'208";a="157456039"
Received: from mail-westcentralusazon11013033.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.33])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Nov 2026 09:44:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNDRPCaASzpyvrEFjTicoGikApLyd2MeNCIPbktPwSHiA87NZWD1s5H2Suntm9J9eXEwF8wyQamL8n5IJulZyVJ7Oz9HYNGZUsoEFrnpMOX2mgeEB3Jw1SaJxAaMZJm7kLwIWZQ+tptnj7x7Rd5wVZxshZOs53/a5J+H8te/dGVkpM+C94pDfTn3RNsB+8s2c6MnVjTsblyO8IANbPV8/zMi5zBt2+EhjCzL6Z2I+10fedJWgZL5kyBwGnqd2U3PS+6A+1IAmtt+NYAHJLGUJ9xeMY1m0JQigTmmWuRn4HW3IJ7hF+lJAnGr55yum6ghuCBKEYJSd7DIDlo8JjbMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX2j7YBXVdMz98fsZogKBLJBanMETuE/e0YrRgbfjmg=;
 b=VfNC8vpx2+xVEJ4HbpwiR8TiExxWp0d+uZQIkigLQiWfrXEW5uaIx6WA53uTpGrDqMg9DC+OisV3nm8x3bMoVxeoVN/ALx6O1jU3vzXFMeW8W1q8bCwHeatuYEmUfhdku7nv01oVuTiys1GjlgzJJK7T+OBvJGhfmNO5onbAwChSapFNkIRCHBPPdzdaMnsZaMTGw8OQvv/SbrLDlydhgH3vsr4JzLnKKJSJScxSQIk/hDiEMDBVdh/ycikP9geEyCQSpjNXR7hZ5pKrye184u/FoSsR87o8iUjF07VRdHE8DmbarPNKzktNME+osR4aS7SHt/3QNr+9fNLVeiU5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX2j7YBXVdMz98fsZogKBLJBanMETuE/e0YrRgbfjmg=;
 b=nBH+16If8BekXfplZZr7BrbjS4uSfkGLo+2xZQvRfK8lw6KH9q73elagOb+fjPiNMuQgxI1157vkpC3dz4pINaHgfRxFkGgZ4h6+HICrLB9pOgNMRxWazFJuUaFisHePtsROrsNduMZ2MhMCovwkuG/mEoG5rMRzY3wPSfzi8VI=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB6374.namprd04.prod.outlook.com (2603:10b6:a03:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 01:44:00 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 01:44:00 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "b8da8748-a668-4481-b483-66f333a0614b@oss.qualcomm.com"
 <b8da8748-a668-4481-b483-66f333a0614b@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-security@nongnu.org" <qemu-security@nongnu.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "cosmos.xu@synclite.com" <cosmos.xu@synclite.com>, "antikostya2@gmail.com"
 <antikostya2@gmail.com>
Subject: Re: [PATCH v2] target/riscv: add support for the hcontext CSR
Thread-Topic: [PATCH v2] target/riscv: add support for the hcontext CSR
Thread-Index: AQHdeNhQhsWmOXAAGkCGT+xcUTJTxbc9rZYAgABdmoA=
Date: Wed, 25 Nov 2026 01:44:00 +0000
Message-ID: <43780369b396498f1a5c8540255770a345cca8a5.camel@wdc.com>
References: <> <335b83ef-aec7-4345-a95c-6eb669d48a66@outlook.com>
 <b1247c2f-bd06-4b68-adeb-f8b7954d20d0@oss.qualcomm.com>
In-Reply-To: <b1247c2f-bd06-4b68-adeb-f8b7954d20d0@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB6374:EE_
x-ms-office365-filtering-correlation-id: d8230601-aca9-4365-f8f3-08df4a95941e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|19092799006|23010399003|10070799003|18002099003|22082099003|261009223027099003|18092099006|10086099003|261021121427099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|38070700021|261028144727099003|56012099006|4143699003|10067099003|11063799006;
x-microsoft-antispam-message-info: HsarjIqeYY/i+FRShLJ+3zpKPbtqrBhqVE5ZdYnvc4OAF1NgvoLZkSfbnPIIOSgIAlZ3C1DRhXcbq+nXKF+BPQZVCVqG0yViV4mGaizH7u6ZVwVeKnsyk/+l38ikb4rhHQ2jVW1YqoJ3se+vsb8OhswLbvAHlwnlrCCbmBHsg8q2/byCpPpOmnCxlEFCkDhNxH7sGffBqP8StVYoK8EuJAMRmlA0Z5XH4r/D2fv/3yuVa3K/pYJ2bI0hNaoZvf1ul1Ih5HqYrqebjdDhM/TiGdegICFLcar99XLtmNFkcm3VIXoN8r6dVR3ayX4aZv/k0PjKQOZB1O0JgqBZohYmfZoEX4sLc+AFohJ190KAqiM6C86LLNm7ffgtMNu69ZnHWi0TDMf8vLAQvU3YQ4eKaFOaayFiGd4vYNG956Mz6jlKQvKoLvi2lCURVIgWxfC9I/Ct+LPp67zPtLaBTmgWaeUkkvdQZ49t5lwOaHRrGWIGA70yiEfOF4gxiqiyJYapJKzmMw5tCCGDF1U+Y16cPHT7EFujxetPo3okxskWhhl2W+sN4nLIP1wFNhTLMzbpp+dwX+OUfzlwvbTP88jQUNr3djSOSoQOxOXqHMRQRfnO1PiPiDx0Hg7VGKE0zEb21Qepk81K+H0PZs+7GHKvZmT9zq089FEMsYi9ANb3NWs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006)(23010399003)(10070799003)(18002099003)(22082099003)(261009223027099003)(18092099006)(10086099003)(261021121427099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(38070700021)(261028144727099003)(56012099006)(4143699003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGdkRHk3d0VhaDFkbStKMTJpM09pMVZxclE2bnl1LzRnbWNsSXd1UnNmcFB4?=
 =?utf-8?B?dVA5YTBycmNXV3lNdGFPK0ZURTA5WHV2WnZxVnY5RVBtMXdUUFkrRXRjRW9s?=
 =?utf-8?B?TTk4NHdUQ1NxUTBwU3RVTDg0d3R1NldxZmFMSjNXZ3VYUGdHUVRNd0gxQVN1?=
 =?utf-8?B?VmM0dGc2SVBtT1BnaTZRRzljcXdTVGhOYVFRNU9JbGFHRXp5K1MwSmdQb2k2?=
 =?utf-8?B?WFUyeGxmMU5RTUNYSVZEeDRjdkdsZ3R1elJLU3g2ZzhkYjkxckp5Mk9VdzJk?=
 =?utf-8?B?S2lSSHNMSzdVUVg1aXpZRFI2NDZHY2NDMmN2RjdoNi95NEhBK0hZZ1JTU21x?=
 =?utf-8?B?U0hwSWI4R2FZTDdxZXdSbFRMMWhncDZ1eitZSEJRWUQ1S0FZOWhTdzQwUm5z?=
 =?utf-8?B?ZXoxNkZKT3JKQVQ2M2lKY1NST0Rib2JQL01MNEZUUTZxbHorZEJrTHNiSG5n?=
 =?utf-8?B?eE5sZGxrMTROVjViUy9rUkk1bFRXUFpFaHdTS2xnaGl0ekw5UC9xTGFjMVYx?=
 =?utf-8?B?QmYrZTJ4S1Y3OWJnVTdTZFBjdDhJbHFkTjIxWTltS2pWRE93ZklFSFIreENP?=
 =?utf-8?B?aCtsSDlrQzNaUjRoMEgzVHdYZm1zVDNONnJyNkhlM3psN1FXVm91TFJhODVE?=
 =?utf-8?B?RmNYRlZVNE5DSE1BOXV3VmpMSG1PWjY3ZEcyUE1sVDBOdzlUWWU3V0hodlNr?=
 =?utf-8?B?SnI4RnU0VEViVWlhbjNtTm9sbks2WFM3aDVkd1g2S3dPR2Q4N2crTDFOU0hp?=
 =?utf-8?B?YzhOMGVMUWZIQ002UGh6Zys3NzVGcDJRUVZnNVpuVENzL29BckNCcEtXcUlZ?=
 =?utf-8?B?amVFT2EzYUxScVc4MG5NMFRKYlZFMXVEcDl4TmlTSlNscGlQeHczQkdCWXEv?=
 =?utf-8?B?eGhaU3ZISSsrRFlzS0xjNzYrbnVZVDV5NTBYWXZCVVd3bzJ3aVlFelJSZCt1?=
 =?utf-8?B?cjJyakdmcjYybE4yWkF0UndNOHorMkx2RUE5Y1dsVFlJcTc5RGtFUjkvOUk4?=
 =?utf-8?B?WmFDNmp0ejNRZE95dHprWlRNMjl1S3pTcW0xUy9mK2pubEhJc0g0RVM1MlVK?=
 =?utf-8?B?eVBPcVJaVUR5VmpCdlhrNXhKR2hBSllLODVjdW50N0dEd1AzQjAydGlaZDN0?=
 =?utf-8?B?QUxVM21sSkRaWXp5Ykx4dC9KRzhBaDhSNFFLT3BBVEpVREFmUERBaWFNdjRp?=
 =?utf-8?B?RFVhbWl6MUliaGt0MDdBb2VZSjlva3UvdldLUVF4ZXArNk5SY0RaSWIzTFBx?=
 =?utf-8?B?aEN0YzZCMWY4MURibVVCN0ZJNE1ZQWZuWk96ekRLYXJkMkpwMGZKZTlhOGls?=
 =?utf-8?B?VEx5ZHpQUGRxUm5RSHpJcitoSWVYamNTcThKc1dVbnFLUXgyU1Z2NmdmN083?=
 =?utf-8?B?SzJ4bUg1RHl2d2pwUXc0SHE1R3Y4UExSRnVIczVLUVVYMHREdmtmYTZqUFRP?=
 =?utf-8?B?NW1MV1I1aTJKaCt1dTRkTXZmZjVibXNOcDFFR1dZQWprU3FoR1M0b292azJZ?=
 =?utf-8?B?cGhvQTN4MlZDeURGS2NmOU1EUG0zUGlKMHh4YzVxdUFBeUQxaTlyMm9HYXhV?=
 =?utf-8?B?blVsQ3VOZXdqcjVZUGg0aFU1SzRlOVFwbXdFbE5NY3A0VEZBWGtUZGxvN1lo?=
 =?utf-8?B?TXNRSmZ3MTdxelN5Z29HUExlalBrbFZ6T0RWYWFneEl3ekhiQXE5anRKVlhr?=
 =?utf-8?B?WEkySTl3UXpnTDZONHZqRG4vU1VPdUFOeFFZN2ovQVV2OVhTVFBaSTk4WWJW?=
 =?utf-8?B?N3VjWVMwT0ZGdmFCRENCajlrdmpIVGg4SFVYdkxlc1pkVmFlQXBKNDlERDBE?=
 =?utf-8?B?TUlSMEtIM2VZTDQwaExGNWp0ZVdVTVdvNjhSUGNtZ2VWYnFNbW9ObVhEVWRN?=
 =?utf-8?B?MTdnVjBrSFQ4RWErVlVBQ2JTbFVmUGpXWXBuNGppSWR1bzNIcnZmUGlkTktK?=
 =?utf-8?B?ZDYxNkQzWjd6b0NxYTNTVWlKUW1wNDdRamo4SjJjRGFFWURXVGZ6a0VPSTBY?=
 =?utf-8?B?RGxTUXpiY09kamRwV0VkTlljcytkbDhFQ2t6TTRYc1Q3TisxZlNYdlJVck9o?=
 =?utf-8?B?UUtCdnFNN2hDODY1V05jZzM4RGsranZxZGVWQXJTRFYxNTdFL3lNNmNFSlBr?=
 =?utf-8?B?YTdhWXRYMmVUTDlxM1U2ejlsNWdqVjlVSnIyNTJaWXVINk8zdnVCWnRjTzU5?=
 =?utf-8?B?TDNwNVBkdG9GOGdrNUpRTzN3dFMxL21MVlRGT3MyNWplTVVadkc0MjB6eGl2?=
 =?utf-8?B?dUo0bFN0cnphWDZxY0REUmVlcjl0RVJLdmJZSk11WkVEU2czTElTNkhCWmlM?=
 =?utf-8?B?Sk90MWd0d0NocFNHMCtzTTUvWTV1MFlqeFpMZlZUVzlJUUFoTU1VcUdzSWRs?=
 =?utf-8?Q?1h73Qa1TFEv/FgwvOLOlIJpvKRI1gM2u6GopN4h/C1f/R?=
x-ms-exchange-antispam-messagedata-1: 8PzOtgmQijDJGATHB5H3qFpHy9vHpuzWRuY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F3A7C23092F0B429B797D6DCC55841C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q6mC64shSwVWSmX4rcb9wTVJX6S/UgD8d1Wh7BhoWOeWFCEY3MQfiq5Y8iQXFuZ/4lPh+WUL2Q6yEVzLEyEQvV3sa/0oYafIaoPsPVJISbWqomHcIxpTjP9kHJGD0KLFUzZvSJYz64FBOqGp1vz+PY3tO8p4HA8/mEUqcRISXaeWlOR2zBoT0voLMHzRKVFUvXc+ZM54EHkmQgHNJUzrL71ZdYid8un4waLWDQegrtZ/y3Nid5jCS6Uj8K9r5+9bDWKivQ1Cam4HMUys5/O4EtDqZfpKnGvMATN4Da+r8nlZia8jsA0a4ewujRRtkxgb1TtdeNDED9TUnnaECE7XNA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eRfGK7i/MN9n30Stmzo5GeLPjMl/2O6M0El+9AXxdH+zbN5uAMcCPl+HPCcDK1C0fCka3oxsxOxCzwDVs5/Z6eGkIqovxyCwx7Oqb9kwnV+lpIerz2Yke/p1hJ/KJbmr+wngmITnUfWuMajWAjHGAe6nWSxPufzpdC/Jq8dRuJ+KhEGsTMTkWZJvgC5l16pnwXLn3tXjbB3zAdyPmNp/EjLAdikp9AdTXKaIp6DE+wVXxO9kzjZ+3j3w61zaRC2LS7vNxlicYz/HU64CsxLAj2ZiTkEmFV4z/kHeHECmvsKRADaBuzVm6eWC+hnyqFDjQRpNLJeA/dM9y9IXo11DCFA8Es93Cvw5DDFUvjhkQo0fk/+o9adp+aSTgBibw1SB7hrnWDLSfY7evhFAGKWdLdkZILaARDiYHaPPzsFoSzYzTKqTuDSo4hV8Ccs26yoMZQiZ7FA3U0dMCN6Cd7TmV8MgtiAzHp8XqKvSiiJbxoNLI3MemVLW98Q58vGoxfATppOF/UUxCsmoAbzYVbJJN/bhQK5F5blNK6N8MGLQFjhLNMErLmaoV4U51SGB1QfaZ2NCx/zWAFe72abtGU0xbPFBz8ZvNLcCH/r5fpkfp+EZYk3YJNZ58CDKiV6IHXVH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8230601-aca9-4365-f8f3-08df4a95941e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 01:44:00.5146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5+/ufsjPIG+gn392+dFAiw0CiincE99PDpA46/nwX5wO/iKFOXEETJgtbZuJu6VM9LYf5qxjGi2FL2ftoIn4Emu4dyiAvuSJPsgYEbU/SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6374
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=7821f5b77=Alistair.Francis@wdc.com;
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

T24gVHVlLCAyMDI2LTExLTI0IGF0IDE3OjA4IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gSGVsbG8sDQo+IA0KPiBPbiAxMS8yMC8yMDI2IDc6MTggQU0sIEFyc2VuaXkg
U2VtZW5vdiB3cm90ZToNCj4gPiANCj4gPiBJbXBsZW1lbnQgdGhlIGhjb250ZXh0IHJlZ2lzdGVy
IGRlc2NyaWJlZCBpbg0KPiA+ICJUaGUgUklTQy1WIERlYnVnIFNwZWNpZmljYXRpb24iIFZlcnNp
b24gMS4wLiBUaGUgaGNvbnRleHQgQ1NSIGlzDQo+ID4gYWNjZXNzaWJsZSBmcm9tIEggYW5kIE0g
bW9kZSwgZ2F0ZWQgYnkgdGhlIFNtc3RhdGVlbiBIU0NPTlRYVCBiaXQuDQo+ID4gDQo+ID4gQ2hh
bmdlcyBmcm9tIHYxOg0KPiA+IC0gVGhlIFNtc3RhdGVlbiBIU0NPTlRYVCBjaGVjayBpcyBub3cg
b25seSBhcHBsaWVkIHdoZW4gdGhlIGFjY2Vzcw0KPiA+IGlzDQo+ID4gwqDCoMKgIG1hZGUgZnJv
bSBIUy1tb2RlLCBhcyByZXF1aXJlZCBieSB0aGUgU2R0cmlnIHNwZWMuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogQXJzZW5peSBTZW1lbm92IDxhci5zZW1lbm92QG91dGxvb2suY29tPg0KPiA+
IC0tLQ0KPiA+IFRoaXMgc2VyaWVzIGFkZHMgZW11bGF0aW9uIHN1cHBvcnQgZm9yIHRoZSBoeXBl
cnZpc29yIGNvbnRleHQNCj4gPiAoaGNvbnRleHQpDQo+ID4gcmVnaXN0ZXIsIGFzIHNwZWNpZmll
ZCBpbiAiVGhlIFJJU0MtViBEZWJ1ZyBTcGVjaWZpY2F0aW9uIiBWZXJzaW9uDQo+ID4gMS4wLg0K
PiA+IA0KPiA+IFRoZSBoY29udGV4dCBDU1IgKDB4NmE4KSBpcyBhIHJlYWQvd3JpdGUgcmVnaXN0
ZXIgYWNjZXNzaWJsZSBmcm9tIEgNCj4gPiBhbmQgTQ0KPiA+IG1vZGUsIHdob3NlIHZhbHVlIGlz
IGRlcml2ZWQgZnJvbSB0aGUgbWNvbnRleHQgcmVnaXN0ZXIuwqAgQWNjZXNzZXMNCj4gPiBhcmUN
Cj4gPiBnYXRlZCBiZWhpbmQgdGhlIFNtc3RhdGVlbiBIU0NPTlRYVCBlbmFibGUgYml0IGFuZCB3
cml0ZXMgYXJlDQo+ID4gbWFza2VkIHRvDQo+ID4gdGhlIHhsZW4tZGVwZW5kZW50IHdpZHRoIGRl
ZmluZWQgYnkgdGhlIHNwZWMuDQo+ID4gDQo+ID4gTm8gYmVoYXZpb3VyIGNoYW5nZSBvY2N1cnMg
d2hlbiB0aGUgSCBleHRlbnNpb24gaXMgbm90IGVuYWJsZWQuDQo+ID4gLS0tDQo+ID4gwqDCoMKg
IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaCBiL3RhcmdldC9yaXNjdi9jcHVf
Yml0cy5oDQo+ID4gwqDCoMKgIGluZGV4IDM1Nzk3ODlhMWYuLmJmYTEwYWZjYTggMTAwNjQ0DQo+
ID4gwqDCoMKgIC0tLSBhL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oDQo+ID4gwqDCoMKgICsrKyBi
L3RhcmdldC9yaXNjdi9jcHVfYml0cy5oDQo+ID4gwqDCoMKgIEBAIC00NTYsNiArNDU2LDcgQEAN
Cj4gPiDCoMKgwqDCoCAjZGVmaW5lIENTUl9NTlNUQVRVU8KgwqDCoMKgwqDCoMKgIDB4NzQ0DQo+
ID4gwqDCoMKgwqAgDQo+ID4gwqDCoMKgwqAgLyogRGVidWcvVHJhY2UgUmVnaXN0ZXJzIChzaGFy
ZWQgd2l0aCBEZWJ1ZyBNb2RlKSAqLw0KPiA+IMKgwqDCoCArI2RlZmluZSBDU1JfSENPTlRFWFTC
oMKgwqDCoMKgwqDCoCAweDZhOA0KPiA+IMKgwqDCoMKgICNkZWZpbmUgQ1NSX1RTRUxFQ1TCoMKg
wqDCoMKgwqDCoMKgIDB4N2EwDQo+ID4gwqDCoMKgwqAgI2RlZmluZSBDU1JfVERBVEExwqDCoMKg
wqDCoMKgwqDCoMKgIDB4N2ExDQo+ID4gwqDCoMKgwqAgI2RlZmluZSBDU1JfVERBVEEywqDCoMKg
wqDCoMKgwqDCoMKgIDB4N2EyDQo+ID4gwqDCoMKgIGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yv
dGNnL2Nzci5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiA+IMKgwqDCoCBpbmRleCAwNjM1
OTBmNTZhLi5lODE3YjgzODNlIDEwMDY0NA0KPiA+IMKgwqDCoCAtLS0gYS90YXJnZXQvcmlzY3Yv
dGNnL2Nzci5jDQo+ID4gwqDCoMKgICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gPiDC
oMKgwqAgQEAgLTgxNCw2ICs4MTQsMTYgQEAgc3RhdGljIFJJU0NWRXhjZXB0aW9uIGRlYnVnKENQ
VVJJU0NWU3RhdGUNCj4gPiAqZW52LCBpbnQgY3Nybm8pDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gUklTQ1ZfRVhDUF9JTExFR0FMX0lOU1Q7DQo+ID4gwqDCoMKgwqAgfQ0KPiA+IMKgwqDC
oMKgIA0KPiA+IMKgwqDCoCArc3RhdGljIFJJU0NWRXhjZXB0aW9uIGhtb2RlX2RlYnVnKENQVVJJ
U0NWU3RhdGUgKmVudiwgaW50DQo+ID4gY3Nybm8pDQo+ID4gwqDCoMKgICt7DQo+ID4gwqDCoMKg
ICvCoMKgwqAgaWYgKHJpc2N2X2hhc19leHQoZW52LCBSVkgpICYmDQo+ID4gwqDCoMKgICvCoMKg
wqDCoMKgwqDCoCAocmlzY3ZfY3B1X2NmZyhlbnYpLT5kZWJ1ZyB8fCByaXNjdl9jcHVfY2ZnKGVu
diktDQo+ID4gPmV4dF9zZHRyaWcpKSB7DQo+ID4gwqDCoMKgICvCoMKgwqDCoMKgwqDCoCByZXR1
cm4gUklTQ1ZfRVhDUF9OT05FOw0KPiA+IMKgwqDCoCArwqDCoMKgIH0NCj4gDQo+IEkgZG9uJ3Qg
dGhpbmsgd2Ugd2FudCBhIGNoZWNrIGZvciBjZmctPmRlYnVnIGhlcmUuwqAgaGNvbnRleHQgaXMg
YSBDU1INCj4gZnJvbSBEZWJ1Zw0KPiBTcGVjIDEuMCwgYWthIGEgU2R0cmlnIENTUi7CoCBjZmct
PmRlYnVnIGlzIHRoZSBsZWdhY3kgMC4xMyBzdXBwb3J0DQo+IHRoYXQgcHJlZGF0ZXMNCj4gdGhl
IFNkdHJpZyBzcGVjLsKgIFdlIGhhdmUgYSBkb2N1bWVudGF0aW9uIGFib3V0IGl0IGhlcmU6DQo+
IA0KPiBodHRwczovL3d3dy5xZW11Lm9yZy9kb2NzL21hc3Rlci9zcGVjcy9yaXNjdi1kZWJ1Zy5o
dG1sDQo+IA0KPiBXZSBzaG91bGQgcmVtb3ZlIHRoZSBjZmctPmRlYnVnIGNoZWNrIGFuZCB2ZXJp
Znkgb25seSBSVkggJiYNCj4gZXh0X3NkdHJpZy7CoCBUaGFua3MsDQoNCllvdXIgcmlnaHQuIEkg
Y2hlY2tlZCB0byBzZWUgaWYgaGNvbnRleHQgd2FzIGluIDAuMTMgYW5kIHRob3VnaHQgaXQNCndh
cywgYnV0IEkgbXVzdCBoYXZlIGNoZWNrZWQgdGhlIHdyb25nIHNwZWMgdmVyc2lvbiA6KA0KDQpB
bGlzdGFpcg0K

