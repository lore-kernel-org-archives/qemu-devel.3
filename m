Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37496606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 05:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=AchnL2xE;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=eZANo/RI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOpa7-00045p-36; Thu, 05 Nov 2026 00:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xOpa2-00045K-Uz; Thu, 05 Nov 2026 00:00:07 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xOpa0-0004if-LZ; Thu, 05 Nov 2026 00:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793854804; x=1825390804;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YbU1hljY1XlCd5b+OLu0v7zp25/W7KJlHc7u3paGwh8=;
 b=AchnL2xE59oDkIgdaVzZ6DYoNYERae3dkV/giPatjw5NfxObxOPYBzek
 vD20++ZO4N6kBHXnczb/jWoxg321uClK7nLxfreEhuGz5sItSgzb+fbmv
 iFxtdDcWkmLQA2jyAF4KNiIBragmwZjXiJuK5fUAU59MLEYQ+iVVpfiE6
 LNQ0eGwK2F5eoirApRYWoJdA+caQ8ncCmKCxgOlKUSVBuNTgwqxZ0oyM9
 DQ9fWD361BRnohPtFH1RQCHwNdlYP0DSnYgJ2KpRtvgxsp2L2M5XaSiQB
 UBia3O2LDmwBPpbe5gLvzNevxmTRh9O5wTDAnYcPZzPgmk70CvWFKwwRz w==;
X-CSE-ConnectionGUID: XNSwVr0dTpyHSWuaaL+E6Q==
X-CSE-MsgGUID: wWMPJpzfTCKdLsEs6+kJVA==
X-IronPort-AV: E=Sophos;i="6.27,196,1786982400"; d="scan'208";a="159773437"
Received: from mail-westus3azon11010025.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.25])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 05 Nov 2026 13:00:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wost3PsCti9l5bDIQLgS7CCWmpaq/0KQvFXLnA0PItyWUK0/UZz8/S3IB6DmI0BKkOARANOTKBKscVPMIYx/pB612p/Y0ig6Uluf1MSCfCe33BNkRrhfHJ8S7qut1LCt4rft8klUD97FRW0pmGxyTX1tFCvwkNNqQQtQworm8mdv0HgBeL9AKDGwkw5U9JiC6+x78YmYIdS3qpIwtyWjaNjtxhMjzpcTeVJMb+AgcwTA6i9XtLDrp7XMs1L1UcZcJhBvO9i8ZDDyUU/nJUGOT60RM1F0+Z93P5IsGFyIuaj5ZeJ+EYCGuZ+flPiQG1+hslxiGrOjSZ22bQMKucQCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbU1hljY1XlCd5b+OLu0v7zp25/W7KJlHc7u3paGwh8=;
 b=Zy1yDdIDki9QimANrdP3hkrwYWGQgW/I4PBh2yQlsPKaqBj0JPAE4hGNyjNhoOAazxbwz7FG4yLYKdkJIdomgjrK/8Cd0pkYMGEtyAesJeaipzPtrCmN3/MS52Q8KSBQ8tLJZNbvqcL8+oYpQhIecpymbpj+m7UH7Sb7EGTf5iFaex3ORTsJN9C+dk5bep5kYqPe8J0euufOFqAvtGeZZeE0j5KNUgyDJiqLJJuW1Iv44Mev5BrIL9DN9pBm4i1qPMerTUC5ytn1I+Ue0Xp4/J0apfCvz3933bN7Dw3OlN8V7pMw3afsuovUHFu/KtolrxQRDlCV2s1cs6L5HgKkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbU1hljY1XlCd5b+OLu0v7zp25/W7KJlHc7u3paGwh8=;
 b=eZANo/RII6VGPdA47Yvg+64hnnRvFzvu53OnaFG1LvizEZrdig+Ag9B/oHWPaBKAfiTUal3mQIoKVbqqAlmL5/wfTQgsoMyvWYENIvt1qwREZrgcjE7eKlhdn4fVus6Bzd3lJllFydnZLitWVVrlfDRWtW54PXvMkVsmR3n57cs=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by PH8PR04MB993683.namprd04.prod.outlook.com (2603:10b6:510:40f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 05:00:01 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 04:59:54 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 3/6] hw/riscv: make UART FDT helper consider baud rate
Thread-Topic: [PATCH 3/6] hw/riscv: make UART FDT helper consider baud rate
Thread-Index: AQHdYwjll4WxQq/WzUO7pb8V/F1HO7ce/uuA
Date: Thu, 5 Nov 2026 04:59:54 +0000
Message-ID: <8b1c95a100018febf8f5e65a1ebc9e618400edc6.camel@wdc.com>
References: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
 <20261023160913.24992-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261023160913.24992-4-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|PH8PR04MB993683:EE_
x-ms-office365-filtering-correlation-id: 833b442a-c143-45b6-8438-08df3af9a1e9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|376014|19092799006|38070700021|261021123027099003|261022105027099003|11063799006|56012099006|4143699003|261021121427099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|261022075727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: TQxABl8Rd/xgyxZmj7ncILBaW5bo2Jrfu7Qbyy7Ked+ahj4HpZqNPOy2FovEerVxqDqBU2aytuTTshta7f4J0SyXaTK5ukKkLsHoW0w4mgk/9dIWlEyaX+jv2VVPxSTLOhy+F/IZ8iP1bBD1jZIBxCXubWVvEOwWbq9gYfQgdC+cgMXO9US7upIn4eXz9Jgm5M0vqgBu3pXy9QAaKP/Hw9NDm19IjpVkw+92lmP6PL98TVvrcAwNNXBg6FqXmJW3CbVN1C50DXUfYSJ1F/fuMOfk/l3WEzcrkyAgf8rvIzoxrqLIxnX1DjjaxRmCpgpjPjG45EV6u9/3rThRh11CbOMlcflSc87qjPx7u9uQJdPgjuWMsEjTxW4FIaLgTGKhNID0AicmxnnFn7EqnuETaa5bWWQFIGe0HW8aGn9Pd6avEnnoPhdmKcskeDrZJcHHK6gOsbKFtrw3BQNrwgMkWSvvqpUoG6tmAW2eHvPJVJgkVIHxbOJ9G3FL2852TkjYtbzlc+Ei8LfcDc6NcbWQITfsbjwPbdO8ATbDJqhdnaOxzJjRnW7ojU98tiZlcDaxaYkukQC2Q42eEJYJ5w2chvaNlo9+hyN8+cCFrZltLiSMuMLIfIKiiNhHZsuR5zS1jfEmTNqWi9FDw4c7Bym13aRvA2hWFxJMGv0JUIVVhSHadhlAUEzUQcLH+qmSYduEwhzVDg2PGk1MsGrb27AZLW8eEYnCLk+rtpyMcyq1lL8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(19092799006)(38070700021)(261021123027099003)(261022105027099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M29iWnAxMGJEQTI5KzZ2UmdxVWo5eGgvTWRTTU5OR1VGd3BFbEdhMmlwZ0Ix?=
 =?utf-8?B?em5XS1pHRVZWQ08wMUJ5V3FoRm9CWVNmMEhrcXdpTUY4YVhoTnJEcXVEM0xX?=
 =?utf-8?B?cFRxRTJoU1NQakYzbGNVU2lMMkVGZVhIMnlsTSsxREJMYWJDdDlLbElLZmFn?=
 =?utf-8?B?OVkzeVEwYU5iTkhzSGFzTGdnMjVqRUJFV2NRMVJtem1JaDBNVkloTlBuQ1di?=
 =?utf-8?B?NGs1S0ZrZmhhc1ZBRWlGUEd0YzNRbDdYKzVqRURhRXUwdmtYd1pQMWlpWUNS?=
 =?utf-8?B?VFlCRDN2YTBtbS9DSGZOMVg1RVU5MDlIeXhpRVZIdWxmdyt4dHBPeklvdzFV?=
 =?utf-8?B?ZXFwNWpNRkErRVA2cnJ6dmRVeXRzMGNoeU44dlhIRFRySXdESGVYVTdJQ1gz?=
 =?utf-8?B?UTk5UG5NRVQxRmt3U3BBTUp5RUNVMnVtaGg1WSszSnd5amFySTNSSXFvS05v?=
 =?utf-8?B?dTIxdFpzZHlZYjNPYWRWakxOWjE5eVpoTWJQYVVoL2ZIZVJQam1yYmlVTTgr?=
 =?utf-8?B?cVRKYU5BYXZwUFRSanpsVmNDN3VQbi9EMS9MSGNZK3hXMDBKN3Q4bUdPb01S?=
 =?utf-8?B?aEJscFE4OEVJM1FJTWFBMTFFTm5LMGl6dnNkaStaa09PZElDVlhyUStkb2Rq?=
 =?utf-8?B?YXRtWk5qNnhoZWNEOFdBUjhxbFB0eHNDdmRIeVNVQ3RWK2dDMCt1ZjNSTDUr?=
 =?utf-8?B?YVlmSXJhcU9Iek5iZ3VrL1JjV3dZZ3F3YXVsRHFkQ2VPbTUyazJBeTFGWmVm?=
 =?utf-8?B?dTRUZUkyQzcyZCt4VStWZmFhT1pyMUszVHVzQjJNWDExS21Tcjd2ajlnN1c4?=
 =?utf-8?B?bUlFYTVEZmprMndXQitFUnNRcU4rbC90d1dlTnNONWlwWkg4NitWazZCTHZR?=
 =?utf-8?B?R0dMRnc2cEhlRUNUVGJMeEtrR29yN2NkTGRaR0pYV3kreTRKeGZPbnJkeElK?=
 =?utf-8?B?aU85MUFqY0Vla2xneEphTlFaY2ZHTnZnemhnVFczSldoYUVUd2pLSFR6RWxN?=
 =?utf-8?B?dWJLSDhGdE44bHprRkNqSDNtSDhyU29jZHl2ZkZsZ3p5Um1NRStmLytmOEw2?=
 =?utf-8?B?TnExR3hPeXNHNit2RVBPQWRZWWhMVmIzckFrSWRobHJubGJnQVlBbUFsa3Jx?=
 =?utf-8?B?bkpPRUh3cUloMXl4UU1XL2JJTEdaVGdydGt4K3BCSXd3RlpGdzVJQTRvRkxy?=
 =?utf-8?B?VE15ZmxVanMxVjhKS1hzdUR2eVNqNjl0OUhvcVJFc3ZZalA3cVFDQ01oc3E5?=
 =?utf-8?B?Q3JrQXREWFNQME4wQ3Q2YzZHSzlPMisweisyempUYzk4TkJEUlBSU2J2T0Zj?=
 =?utf-8?B?OHh6T3ZjNDNZbnhDZTZnME8wZUJKcjY0ektmZWdGYWwrMDU2VXNjRGJiQWxM?=
 =?utf-8?B?SlNoQUNZb1EvQ3hmRVJUM05pdkRvY0RJODNDMjBMRE8yZitubWxJdkFhYnkr?=
 =?utf-8?B?S20vSDRFT2trMGgxN01CVTV2NTBaVDQvVVVmbWNuWVJlWjlQWWhwMEJWNzdz?=
 =?utf-8?B?eG1xdjdMZjVHU1dEY1lCMTNuZmpBZTNzK1BJejBCY2g2dXp4UmxHVVJZaGky?=
 =?utf-8?B?U3BFWC9LakZWOTcxdDhxK3E2R2ptYVVnSDAyZU16NWkrVjgzbHVCNVMycjd0?=
 =?utf-8?B?TUJJUnJXMFJ4UXlJSm16RFlmOVR6bGJWMTV2VEd6LzlDeEhzdTRPWVBwdGdT?=
 =?utf-8?B?eW1uWFRYTVgzUGNyclhRWVFvVk1IbzFuRkV6L0phTi9hMDV6TGZHUXJiaitK?=
 =?utf-8?B?NHZxSnpYSFFTZXk2azZQVVhoT3R1OTJZcTFtdW5Ea2ExYk1LMitNTytTM1Vt?=
 =?utf-8?B?SFM0Tys4dDRNaFNaSklTcWhiUkJaN05rNnNQd0p6UlVySmhRTWlQbDh6WDE0?=
 =?utf-8?B?K3hQNGNKTW9OUzVHWXFSYjBRZGdqY2xRR2Q4S1ZESGJlS2U0QkpiVnNYQUxG?=
 =?utf-8?B?UWhyajBVTjBrTzhweUxUeGYyeGpJUFRYcjdZb2FyK0o5aUp3U2lheXlCTVFX?=
 =?utf-8?B?aXJXcWdQYytiRkxNTHhsVUdHRjFZYS91bFB5emhXNWNwZjFjLzR4YW5VRzkw?=
 =?utf-8?B?bXhBVTl3RXQ5dklKQVFPeDgwUytVYjVuY2wrelZUbm05eVhUQ2dPakduOUF5?=
 =?utf-8?B?K1dEVzl1NG1jN3Ewbm90WTdqTyt2c2l2amFyY3FRenZtbW9ybkdZaDBkZXhB?=
 =?utf-8?B?Rk5UOGdjVEVoYjhGcmVEVWorWTVRa203aWsvT2lvTUZ2dHpGTkhubVJBZnRI?=
 =?utf-8?B?R2cyb3Z2QjlHNDJaZmo4ZnNUSncwV2d1S1JkYVU5Q1M3TEgySW1nMWtxeWxp?=
 =?utf-8?B?cHhkYlZxNFM5bU01b2xoSk5BSERkMTBJd2hNQk5DSU05U1ZyV0YyNUoyS1I5?=
 =?utf-8?Q?FpdFGP+ZEUlioXIvHAfZODPuvblq2xIUfoz15eoYp4Su5?=
x-ms-exchange-antispam-messagedata-1: QtHkVEJtkwfM8n49ICvX/2fAE7PBLpnG5Go=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C659213E3EF8664580448F84EDDDAB5E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PTY+tykfeoGgtrh4FfE3aVnzqA3RmiBRByIJgO0TFniICS4pT3PzdPzR3LI/6Qod/nYOgJ4hzBvdBcQ6tE+xH0RrLZU2pM01Qj+USTN5z3ptpfnxi6k8R+JGMrdK6kx1osu/9C1gJFcgHRi8s3UZ+PNJVbiMRylydXYPiknig1D7c4o32TY14Vrh4DyD3+wtx/iVDsHX2q5RWOaFGxYSRlvzOknDFq0tU596+dUHoA0v3+R+7QQLEddY6UpmfHh3yq4nU5IiWzMTFwk2avTOPd4SXFWc6OBYDuqTjVjUlb/0MiDRnydZgzusHSJShHC1a4XhYt49cf+oagEERck7iQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gnMcVcEA2JunYIOLerxFCISsB2XBXXxKo3N9ezOMC0AGC5EIjFMp7cWoKaNHJM9TqcfKFk8698kLw4xgqT5eYnGE3Le0vtwBOkJIgsOHTYA5cV15cNdm1auQnOpT0+wT/i0woH/qEr/9cu2RFbKqLtWSyn6Aq0iV67OFfqiP0zTO2IaYP+MUymHcqqGOoMJsrkTJYlEUl477XqswTrAHLmSoVmYM+2No1GdJBWfbO4R6OVCubRCp0NVfvsLyt6gdh7wdD29w7T7lA2RdF3x4lTuIiSUWqpPDuLD9CeFBU88EiT4g2TXaBZmge4sb8CavyAlnCIltLjOwb6/4O4c3lbzL68HW3T6GYVJt86cfmjLtuX+mZLq5/jjbsnw+QdlTRk2vDuPEBNHwXCbeoGR1PAka5voJRaxHsiuG3jslZEwUwy1JUeEh7fRupn/5aPPXxBu7vi5lXqDAEj2ZaRrXq+cwcWdtHD2IfOULo8V8MdlepJiffHyQnGq2x88OhmgaXChju9EH3pVe3m9lCQEJhXt8p77ZAc5wKzJg+feTyCDTgLb796c4KCsrZwjYdf5NqkeWCcu8+BC+Xpq0l1OxG3J1/GzVimQG5gpo30MMxcmu9US11J4fI/L2A1ugDoa1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833b442a-c143-45b6-8438-08df3af9a1e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 04:59:54.6718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oTbi+VV47Zzd0/nDZuOArAttkiAKt4ZmTSosdjYIEtxGLiR7PKIPPpE5HjjXXzYGcqf5KXzFtkl8Vs9TEXgZ21x0HKWGd2fCTEXYTnoIVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB993683
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=7622369f3=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDEzOjA5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiByaXNjdl9jcmVhdGVfZmR0X3VhcnQoKSBpcyBkZWZhdWx0aW5nIHRvIGEgMy42
ODY0IE1oeiBjbG9jaywgd2hpY2gKPiBMaW51eAo+IHdpbGwgaW50ZXJwcmV0IGFzIGEgMjMwNDAw
IGJhc2UgYmF1ZCBzZXJpYWwuCj4gCj4gV2UgbmVlZCBtb3JlIGZsZXhpYmlsaXR5IHRvIHNldCBh
IGRpZmZlcmVudCBiYXVkIHJhdGUgZm9yIFVBUlQKPiBkZXZpY2VzLgo+IEFkZCBhbiBvcHRpb25h
bCAnYmFzZV9iYXVkJyBwYXJhbWV0ZXIgdGhhdCBhbGxvd3MgY2FsbGVycyB0byBzZXQgYQo+IGJh
dWQKPiByYXRlIGZvciB0aGUgcmVsYXRlZCBkZXZpY2UuwqAgV2UncmUga2VlcGluZyB0aGUgZXhp
c3RpbmcgZGVmYXVsdCBpbgo+IGNhc2UKPiB0aGUgY2FsbGVyIGRvZXMgbm90IGNhcmUgdG8gcHJv
dmlkZSBhIGJhc2UgYmF1ZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFy
Ym96YQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPgoKUmV2aWV3ZWQtYnk6IEFs
aXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0t
LQo+IMKgaHcvcmlzY3YvZmR0LWNvbW1vbi5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTkgKysrKysr
KysrKysrKysrKystLQo+IMKgaHcvcmlzY3Yvc2VydmVyX3BsYXRmb3JtX3JlZi5jIHzCoCAxICsK
PiDCoGh3L3Jpc2N2L3ZpcnQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCAr
Ky0tCj4gwqBpbmNsdWRlL2h3L3Jpc2N2L2ZkdC1jb21tb24uaMKgIHzCoCAxICsKPiDCoDQgZmls
ZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvaHcvcmlzY3YvZmR0LWNvbW1vbi5jIGIvaHcvcmlzY3YvZmR0LWNvbW1vbi5jCj4gaW5k
ZXggY2UyZGNiNDNiNC4uYWJiOTEzZmFlYyAxMDA2NDQKPiAtLS0gYS9ody9yaXNjdi9mZHQtY29t
bW9uLmMKPiArKysgYi9ody9yaXNjdi9mZHQtY29tbW9uLmMKPiBAQCAtMjIsNyArMjIsMTEgQEAK
PiDCoCNpbmNsdWRlICJody9wY2kvcGNpZV9ob3N0LmgiCj4gwqAjaW5jbHVkZSAiaHcvcmlzY3Yv
YWlhLmgiCj4gwqAKPiAtI2RlZmluZSBVQVJUX1NURF9DTE9DS19GUkVRIDM2ODY0MDAgLyogMy42
ODY0IE1IeiAqLwo+ICsgLyoKPiArwqAgKiBUaGlzIDMuNjg2NCBNSHogZGVmYXVsdCBjbG9jayBy
ZXN1bHRzIGluIGEgYmFzZQo+ICvCoCAqIGJhdWQgb2YgMjMwNDAwIHN5bWJvbHMvc2Vjb25kLgo+
ICvCoCAqLwo+ICsjZGVmaW5lIFVBUlRfU1REX0NMT0NLX0ZSRVEgMzY4NjQwMAo+IMKgCj4gwqB2
b2lkICpyaXNjdl9jcmVhdGVfYm9hcmRfZGV2aWNlX3RyZWUoY29uc3QgY2hhciAqbW9kZWwsIGNv
bnN0IGNoYXIKPiAqY29tcGF0aWJsZSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgKmZkdF9zaXpl
KQo+IEBAIC04MDcsMTEgKzgxMSwxNCBAQCBjaGFyICpyaXNjdl9mZHRfZ2V0X3VhcnRfbm9kZW5h
bWUoaHdhZGRyIGFkZHIpCj4gwqDCoMKgwqAgcmV0dXJuIGdfc3RyZHVwX3ByaW50ZigiL3NvYy9z
ZXJpYWxAJSJIV0FERFJfUFJJeCwgYWRkcik7Cj4gwqB9Cj4gwqAKPiArLyogSWYgYmFzZV9iYXVk
ID0gMCB0aGlzIGZ1bmN0aW9uIGFzc3VtZXMgYSBiYXNlIGJhdWQgb2YgMjMwNDAwLsKgICovCj4g
wqB2b2lkIHJpc2N2X2NyZWF0ZV9mZHRfdWFydCh2b2lkICpmZHQsIGNvbnN0IE1lbU1hcEVudHJ5
ICp1YXJ0X21lbSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaW50IHVhcnRfaXJxLCBpbnQgYWlhX3R5cGUsCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGJhc2VfYmF1ZCwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWlu
dDMyX3QgaXJxX3BoYW5kbGUpCj4gwqB7Cj4gwqDCoMKgwqAgZ19hdXRvZnJlZSBjaGFyICpuYW1l
ID0gcmlzY3ZfZmR0X2dldF91YXJ0X25vZGVuYW1lKHVhcnRfbWVtLQo+ID5iYXNlKTsKPiArwqDC
oMKgIHVpbnQ2NF90IGNsb2NrX2ZyZXEgPSBVQVJUX1NURF9DTE9DS19GUkVROwo+IMKgCj4gwqDC
oMKgwqAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUoZmR0LCBuYW1lKTsKPiDCoMKgwqDCoCBxZW11X2Zk
dF9zZXRwcm9wX3N0cmluZyhmZHQsIG5hbWUsICJjb21wYXRpYmxlIiwgIm5zMTY1NTBhIik7Cj4g
QEAgLTgxOSw3ICs4MjYsMTUgQEAgdm9pZCByaXNjdl9jcmVhdGVfZmR0X3VhcnQodm9pZCAqZmR0
LCBjb25zdAo+IE1lbU1hcEVudHJ5ICp1YXJ0X21lbSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMiwgdWFydF9tZW0t
PmJhc2UsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDIsIHVhcnRfbWVtLT5zaXplKTsKPiDCoAo+IC3CoMKgwqAgcWVt
dV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgbmFtZSwgImNsb2NrLWZyZXF1ZW5jeSIsCj4gVUFSVF9T
VERfQ0xPQ0tfRlJFUSk7Cj4gK8KgwqDCoCBpZiAoYmFzZV9iYXVkICE9IDApIHsKPiArwqDCoMKg
wqDCoMKgwqAgLyoKPiArwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSBiYXNlIGJhdWQgZm9ybXVsYSBp
cyBiYXNlX2JhdWQgPSBjbG9ja19mcmVxIC8gMTYsCj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBlcmdv
IGNsb2NrX2ZyZXEgPSBiYXNlX2JhdWQgKiAxNi4KPiArwqDCoMKgwqDCoMKgwqDCoCAqLwo+ICvC
oMKgwqDCoMKgwqDCoCBjbG9ja19mcmVxID0gYmFzZV9iYXVkICogMTY7Cj4gK8KgwqDCoCB9Cj4g
Kwo+ICvCoMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgbmFtZSwgImNsb2NrLWZyZXF1
ZW5jeSIsIGNsb2NrX2ZyZXEpOwo+IMKgwqDCoMKgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQs
IG5hbWUsICJpbnRlcnJ1cHQtcGFyZW50IiwKPiBpcnFfcGhhbmRsZSk7Cj4gwqAKPiDCoMKgwqDC
oCBpZiAoYWlhX3R5cGUgPT0gQUlBX1RZUEVfTk9ORSkgewo+IGRpZmYgLS1naXQgYS9ody9yaXNj
di9zZXJ2ZXJfcGxhdGZvcm1fcmVmLmMKPiBiL2h3L3Jpc2N2L3NlcnZlcl9wbGF0Zm9ybV9yZWYu
Ywo+IGluZGV4IGVhMjQ3MjBhMDguLjMxOTE2MTVjMDIgMTAwNjQ0Cj4gLS0tIGEvaHcvcmlzY3Yv
c2VydmVyX3BsYXRmb3JtX3JlZi5jCj4gKysrIGIvaHcvcmlzY3Yvc2VydmVyX3BsYXRmb3JtX3Jl
Zi5jCj4gQEAgLTMxNSw2ICszMTUsNyBAQCBzdGF0aWMgdm9pZAo+IGZpbmFsaXplX2ZkdChSSVND
VlNlcnZlclJlZk1hY2hpbmVTdGF0ZSAqcykKPiDCoAo+IMKgwqDCoMKgIHJpc2N2X2NyZWF0ZV9m
ZHRfdWFydChtcy0+ZmR0LAo+ICZydnNlcnZlcl9yZWZfbWVtbWFwW1JWU0VSVkVSX1VBUlQwXSwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJW
U0VSVkVSX1VBUlQwX0lSUSwgQUlBX1RZUEVfQVBMSUNfSU1TSUMsCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpcnFfbW1pb19waGFuZGxlKTsK
PiDCoMKgwqDCoCBuYW1lID0KPiByaXNjdl9mZHRfZ2V0X3VhcnRfbm9kZW5hbWUocnZzZXJ2ZXJf
cmVmX21lbW1hcFtSVlNFUlZFUl9VQVJUMF0uYmFzZSkKPiA7Cj4gwqDCoMKgwqAgcWVtdV9mZHRf
c2V0cHJvcF9zdHJpbmcobXMtPmZkdCwgIi9jaG9zZW4iLCAic3Rkb3V0LXBhdGgiLAo+IG5hbWUp
Owo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi92aXJ0LmMgYi9ody9yaXNjdi92aXJ0LmMKPiBpbmRl
eCAzOTM4MWNiMjFkLi5jNDQ0N2Q5NzFiIDEwMDY0NAo+IC0tLSBhL2h3L3Jpc2N2L3ZpcnQuYwo+
ICsrKyBiL2h3L3Jpc2N2L3ZpcnQuYwo+IEBAIC0zODUsMTEgKzM4NSwxMSBAQCBzdGF0aWMgdm9p
ZCBjcmVhdGVfZmR0X3VhcnRzKFJJU0NWVmlydFN0YXRlICpzLAo+IHVpbnQzMl90IGlycV9tbWlv
X3BoYW5kbGUpCj4gwqAKPiDCoMKgwqDCoCBpZiAocy0+dWFydDFfcHJlc2VudCkgewo+IMKgwqDC
oMKgwqDCoMKgwqAgcmlzY3ZfY3JlYXRlX2ZkdF91YXJ0KG1zLT5mZHQsICZzLT5tZW1tYXBbVklS
VF9VQVJUMV0sCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgVUFSVDFfSVJRLCBzLT5haWFfdHlwZSwKPiBpcnFfbW1pb19waGFuZGxl
KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBVQVJUMV9JUlEsIDAsIHMtPmFpYV90eXBlLAo+IGlycV9tbWlvX3BoYW5kbGUpOwo+
IMKgwqDCoMKgIH0KPiDCoAo+IMKgwqDCoMKgIHJpc2N2X2NyZWF0ZV9mZHRfdWFydChtcy0+ZmR0
LCAmcy0+bWVtbWFwW1ZJUlRfVUFSVDBdLAo+IFVBUlQwX0lSUSwKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+YWlhX3R5cGUsIGlycV9tbWlv
X3BoYW5kbGUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzLT5haWFfdHlwZSwgMCwgaXJxX21taW9fcGhhbmRsZSk7Cj4gwqAKPiDCoMKgwqDC
oCBuYW1lID0gcmlzY3ZfZmR0X2dldF91YXJ0X25vZGVuYW1lKHMtPm1lbW1hcFtWSVJUX1VBUlQw
XS5iYXNlKTsKPiDCoMKgwqDCoCBxZW11X2ZkdF9zZXRwcm9wX3N0cmluZyhtcy0+ZmR0LCAiL2No
b3NlbiIsICJzdGRvdXQtcGF0aCIsCj4gbmFtZSk7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcv
cmlzY3YvZmR0LWNvbW1vbi5oIGIvaW5jbHVkZS9ody9yaXNjdi9mZHQtCj4gY29tbW9uLmgKPiBp
bmRleCBlYjlkYjgyNzhkLi5lZTY2NDk4M2Y0IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvaHcvcmlz
Y3YvZmR0LWNvbW1vbi5oCj4gKysrIGIvaW5jbHVkZS9ody9yaXNjdi9mZHQtY29tbW9uLmgKPiBA
QCAtMTMyLDYgKzEzMiw3IEBAIHZvaWQgcmlzY3ZfY3JlYXRlX2ZkdF9zb2NrZXRfYWNsaW50KHZv
aWQgKmZkdCwKPiBBQ0xJTlRGZHRQcm9wcyAqcHJvcHMsCj4gwqBjaGFyICpyaXNjdl9mZHRfZ2V0
X3VhcnRfbm9kZW5hbWUoaHdhZGRyIGFkZHIpOwo+IMKgdm9pZCByaXNjdl9jcmVhdGVfZmR0X3Vh
cnQodm9pZCAqZmR0LCBjb25zdCBNZW1NYXBFbnRyeSAqdWFydF9tZW0sCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCB1YXJ0X2lycSwg
aW50IGFpYV90eXBlLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGludCBiYXNlX2JhdWQsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGlycV9waGFuZGxlKTsKPiDCoHZv
aWQgcmlzY3ZfY3JlYXRlX2ZkdF9ydGModm9pZCAqZmR0LCBjb25zdCBNZW1NYXBFbnRyeSAqcnRj
X21lbSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGludCBydGNfaXJxLCBpbnQgYWlhX3R5cGUsCg==

