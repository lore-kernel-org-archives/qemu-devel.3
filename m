Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBF606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=KoE7oKPq;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=ZErCB17l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzKw-0006K3-Al; Tue, 10 Nov 2026 22:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQzKu-0006Ie-6R; Tue, 10 Nov 2026 22:49:24 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQzKs-0005Eb-Fl; Tue, 10 Nov 2026 22:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794368962; x=1825904962;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gCMA7V4Q8tbHLVpdWOLkJeZD9BKXzI6faW3QIRe45gc=;
 b=KoE7oKPqsUI9uwp6cQtQwv5+kXy782+OvWKIMklhOM0Cv5c3F2RLUmUB
 P3rOT+8YYMTcgbIqNk1lm+fNuVyxn0UuGunolo29ppcQ9OHKLzud1NSjb
 qtUpCUuHCcKmb+7ELDODChqEwhZWKXuPeMkzO+PputFAPxRLyYf/NEaJi
 OtBefJ3GjzSuiTeps4AV9ZNElj6HqAMP6oQFkWrN8ke63IMDQG0Kc/bJ9
 mXXr/Sbdydm0hwzs6zjmttiuRb8C2xcMvpGwApqL+oI0PBMmChpxiIbaQ
 v9s1DEjoyA1IUiGHKT37raWkypNmgpASf1M6+JbVQzwHfO5qr/6X1MIKp A==;
X-CSE-ConnectionGUID: 1RicnVSsTAa7Fs3zP21IuQ==
X-CSE-MsgGUID: VvJ2i6H2T4CnOlR+qjNZZQ==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="161572440"
Received: from mail-northcentralusazon11013052.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.52])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 11:49:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVx4qRHflGJgHi1pE3XeGcdrplrrPjHkDgqI42IuWY+b+XDXjRlCgaSjjZnP3aa84iFsNxCbT058oGgQNSqJKRfTagUGeUmHKUSlSvYNGt+zhi8EaMNjDa5rTnILEUsex+xfbbT55BArvWVPemklWDe4qvilJjhav1lSqYRgYQvodqhV2GTK+4zBMifop9oqMHYSNMFj+Q71yafGpph2nG41atxtMwS6UMSRfYeyc1Iz7aRls+oYZmv03U15MZrDG1GO8+DIFNeHitO32SOTZGI0xZjrwpPJMQbtdQ88gDjKnhznagR5NObZ+QcEoN8LMYRdydNxBLN9CFgbERwKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCMA7V4Q8tbHLVpdWOLkJeZD9BKXzI6faW3QIRe45gc=;
 b=h+q+yZ+5Ow0jWLj7NbmhLc4mXNdplQBfOSiBPXKdfykUODVasmf9dVNT4aHNnbviLI2vV/CzxdFcYEc0htPQE3wVLmoi+psTaMXS0eAyDqteSo2krqy7zXfelkvrtMKJUyH+TIzl5sadyiFuBmp/xRnPFdavUU+G0EYlKNP0r827Bva2/px+DA5XCfXqs5qMs0gpxwl+gON3AiGgnqTUovGFk+N59iofKMl9x/yUitmnNTMJk70oqoieA1c1cIC6GGckNCA4MPCqVr0FW766gERhlDvXHi4Gxz9xWdnykPfFqrpX1kZRcB9PdNiTdqvYVuc0Fe1euY3zEpqZZGjjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCMA7V4Q8tbHLVpdWOLkJeZD9BKXzI6faW3QIRe45gc=;
 b=ZErCB17laTHutdJKjnTdS+MeoJWQ8xvmzqAxpMGZ0gkwO9KiLOIXz4YZmUSPeeT8y0yQ3Px3po7DQMRZvxPOASeya0MFUXGHsausGlI2M2Pyyj0K/D0PBmtr7NPDhXia1itlhlW9vbIkJZ92xgiZRxCXspEWOxlme8TW6bLc5bA=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by PH0PR04MB8280.namprd04.prod.outlook.com (2603:10b6:510:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:49:18 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 03:49:18 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "wang.yechao255@zte.com.cn" <wang.yechao255@zte.com.cn>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 0/3] target/riscv/kvm: Add SBI STA register sync and
 migration support
Thread-Topic: [PATCH v2 0/3] target/riscv/kvm: Add SBI STA register sync and
 migration support
Thread-Index: AQHdYczOp44N8ji6wUK9L95HNjHR1bcoW6UA
Date: Wed, 11 Nov 2026 03:49:17 +0000
Message-ID: <6aeda36870789bdd83909fa4345355f43dee6d4d.camel@wdc.com>
References: <20261022022535.437892-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20261022022535.437892-1-wang.yechao255@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|PH0PR04MB8280:EE_
x-ms-office365-filtering-correlation-id: 50074965-f9d6-43a2-7a78-08df3fa6c311
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|10070799003|366016|376014|18002099003|22082099003|6133799003|38070700021|56012099006|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261102123227099003|261021121427099003|11063799006|261009223027099003|10067099003;
x-microsoft-antispam-message-info: 5+mQpiUbU7Entj7f1dOlTCnn9XLHMrg4GmPTw0T4H8UY/fvKABy5TU1pT0fM4V/SDbpmFIgfTiXV99U9AFL7NEC1URS3TcGVAsYTAS52vuyeSGTOK3WBG5KwuhlZxtPRtLMIRna3v0C4HscJGqKtnGwjhb+LP2HGV/XugC4CPfqfSp8uUz2tVttKQ6tLStgofdVI7DltjcbJAFqd1hbkLu2brh61bXTJLI2tOYmkaQ9BVtwIB1F/8/bEV0tsUirMKshQi5rCARpb0KwLvLl5vecDq3XkWzhfeuqFDfKjxS1optmjGk8+o9X26KYYkdXpUIWLvlL1tsYH43aCDqDswEWGL8kUzb7Sn4YwdYKoUgGUItp7y+wLsoPKLVCcqpnF0MmPGfTUAIOwVz/LE9EjSblUnyFekEg8lBJW6+rc3zsTxqUsxmw1xKys31fMbUausWG7svb+ngIbfQVEfUvMZfDl/rLtTue6eMx9tylrkf+aWexnOu9DLFSaB8szmeOyRhQWfdmqB/jUASvwyAeGrsLRoFNBdWuThhTd5c5cJqKYVJXvXFOVNXT+1XikGhayc/EvKDzNwUpK5Zc16L/pQTet/j/sXTP97893hVc4uXyzkD7WujLQ/Jr47Q74HHrwZCRTkfrgxrAPV3uJAfyxJGIxvid0haYUSKSR/hRIkPw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(6133799003)(38070700021)(56012099006)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261102123227099003)(261021121427099003)(11063799006)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjNkK3cwOEV6LzNwTDRWSUdPc3ZLODNJMkRpalJMcUhYU3BHNDBUeFFjMFYz?=
 =?utf-8?B?aWoxQ1lSeFNIcUZVU3dsbVdLTmhENEhQMmwxcm9md2pPbmx4RHRRRkpEVEEv?=
 =?utf-8?B?MS9pb0lKWEhCUnhjY3dWZXVDK0Y3N1VTaHZSbHVyK1FGYnBUMU8wc3YzRnNK?=
 =?utf-8?B?KzA4aVBDSHUzZU5TWGlJTi9NZE4yMnA4VUo1QWYzTXpUY0ZiNjRuQzdvNk1j?=
 =?utf-8?B?d0ZvZ05hTHUzTW1HR1A2bEcxY0Q2UzcwWkFvN0wzUi9icnNyd25POFo3MVlG?=
 =?utf-8?B?NVhLbVJONWIrR1o1OStUOFgzYXBieXpYdFZBdXM1cVNMdVJoQkE0bkpxY3R6?=
 =?utf-8?B?T0dXaWt5dGZvMTBDWHR4NkhTa0FrNE5aNDU2eVVHQnNFeUhFZ2JYSjhpTXRo?=
 =?utf-8?B?SzJVcy96Mkg4NTc0cVdQM01tdDFlQmlDVHVlZFppYmFra0VYbFJhd292WnFG?=
 =?utf-8?B?WCtHdFAwZlZUSTFXZDhZNXplTkpNbTN1QlFubDBBcDV1eGUzVXA5UEJPQjhT?=
 =?utf-8?B?WHlrR0I5SXhSMzQzSHRTRTJsclU2U25RUGd2eUg0QmFDRnBJQUpJZ1VRQllj?=
 =?utf-8?B?ZUFSQ3FGdVlGd000bWxyejNGbFQvNXZmMG16Q05NZitzRCt2OE9mSlVFMmNu?=
 =?utf-8?B?eFdaelFmRHp1STdMaGhSdzBKMmNzTjhGOHJEeUxZV0x4d2d4VzNFWWg5Qm1j?=
 =?utf-8?B?blRaUDZWbkFhVXdWVXNLKzRsTmt6UXBCM3BpYjVENFlFTVFBSjFwc1hNd29y?=
 =?utf-8?B?RnJyR1l3dEJCSG9iVDVJaTFsSlJCaEdudXRMK3NNTnUwVndLcVNBVjhIdUZE?=
 =?utf-8?B?Skh4eXpSNkZDbWltbFJBdGoxVExHOC9DQmRpdkZ3bVJtK285NjZITmxwOVMv?=
 =?utf-8?B?OC95OEZtdS9KamcvcldUYjJYWHNrbkVPQ2VmNWx0M3dFY2dHWjR4eUdZYmhG?=
 =?utf-8?B?OTVFVjJHc0s5L3hiMTJFdHZ6U24vNUtEcE11TE1TekJIRllmVyt0RW5TaHFB?=
 =?utf-8?B?Mm5OQnhLZ09FcGtaYWJJV0NDSUdJQzR3U3Y0QWJZTVY1NC9xb3k2bDM4cTFH?=
 =?utf-8?B?U1cyVUU2YUd3Y2p3c1BJL2lGKzJXWVVFQld3Zkw1NW1HS2k4S3JrUkkrUjhw?=
 =?utf-8?B?K0dLRHJ3T3o3U25wYmVjZ2svY0MrZzc1VHZya29Za1RBZUFwY0crSUZCQXFK?=
 =?utf-8?B?OFlKcC96WE1CSCtBL1pCZ3ovQzBPUnV1QkJ6R2FBUkMvcnVsYUphUDdRekhJ?=
 =?utf-8?B?dVRCbUJMc2lGSkk1dW14ZnA2bWt0Q0ZDTURIM3FPRFA2WkpUcFhhTkthdE16?=
 =?utf-8?B?MC82eWZBbkJSY1dXVTZWRjBIMkFxUEpTZmxncHFtNEFGeWlFK0cyUk1sSGJM?=
 =?utf-8?B?bkdpTzBIdkRzQ3NyTnpUMTlhSVZoYjUzVjJkRlFONlVnMFI3RkEzQWNOZlBi?=
 =?utf-8?B?Qy9HSkNvZ0hVOUtDUktjZm9HT0NKYUJ1eG5acFJpRC9iTlE2ZXI5OGdPa3Av?=
 =?utf-8?B?K2RHT0kycmRJa09nRFRXdzIzVVdGZlIrNGFWMEQzczQ0UkVZYXQzUVkxeGov?=
 =?utf-8?B?Q25FZzRST241ZFFFcnh6VUJNTnN3cEJHSWNOYThYblpTOVNacXlyeHlEa2p5?=
 =?utf-8?B?TXNCRTJPMTJtbmNQMUN3QjQzZ3k2WGhISCtxazRBRVVPaXpFbUsyUTZZblFv?=
 =?utf-8?B?M3pERzhxM3BOT0NUV3BpSllMbUlyZzZFMnFSVmJjYWVzcXdYVGlmSFBMcGg4?=
 =?utf-8?B?WW8wUHdqWjRMbm9DMEp5U2VVV3oyTlQweWZtcGNqd083TjBXWDcxUjgyRzNE?=
 =?utf-8?B?UGN1N3hCWGtyS0d5TjFjU0FvSUlHMVlIUlRSL0pzK05SRld6NTFWWmF1aHhh?=
 =?utf-8?B?YmZ6d3lBT012Z3RJdHRxSGJTdEx1OE5JbHRxRGxsYzJmaTRaSVY0a0xwYlJF?=
 =?utf-8?B?d2FHK3Y2clk2S3pOenF0R21PTU5ycDh3czNUOGEvS1R0Z1NtWTBKVkptczVP?=
 =?utf-8?B?S1ZMTnFvR3lNMUcrQzFySWs0eko0VHhPblUvVXFud2szU3ZXVk5Sd2dMb3ZT?=
 =?utf-8?B?Rkp6T1hTZW80Wk10R24xRHNES25ZS0ovcWthWW9XNnFqdTdmMzJJS0NGOGxu?=
 =?utf-8?B?N09NaXR4VG9iVVBDNHJkeWN0WmZxQVdnVERYMTRDVm1oZ1MvQVZoMXI5S1Ry?=
 =?utf-8?B?WWxFY2llM3Z3aElIZ3lTWGUrSHdvczZrby9DUzV1ZG1iNVU0QTQyZTFWTlh1?=
 =?utf-8?B?RWJKNEJ5b0VTN3c0V01jaTRHcTJ1aGt4aU9IN0RhNTIxa3pPcTRXS3dHTS95?=
 =?utf-8?B?cjJ6VEZodC9WMnZacWNsaUxxejdEYS9pUVBEdGw1YitPRC9ZUldWZTJWK0pT?=
 =?utf-8?Q?Ir/d/ozDK4tQY+bButIggQrl4A9ZlxASu7sl/tAoVCwYO?=
x-ms-exchange-antispam-messagedata-1: 8bsXvMQT4d/HNPCtvQNzFOXrFfw2ymUXLic=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D07AB16178B1543A896E750B93C09CC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sr4CdqERM0fHqKUGFz4oV2jN9PMaSejjQ9cVN9/IKoG/KFRrnAAuJda1V1m7g+QAAxc/f/RSh0xZkDWFBbhS3tMkjUlg4Vp6einLrmNOMEoTOgXWa58Dkt1XCxEE1kszr48RUmJfCgbhbPpPQkDXhQloKGOcbXPyfWbl5Hvrw4vf/vQ7sAD+hfIKTReTSbuvod7BmG9Vkqy0iPCl4kVmG1JPIqGHva5XdIQJLVAMghptseleGcApIzuqaYRxLObrW0WcveNpk4hbt7eLAsTtceI4UC4eG0adfGMcM+OX+dMzWNoKDQKYaV5PApLJw03Rz+pYq4Jix0uDjbXo11ONCg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bcxxWVYI4MtuboQhzenEfdIsOD3pLFWFneaqwm0zELIAifJ/0wiGHQJ4ny5hTlCH+ICxRkW9FFqkSy6k7aai+cSMB627+GCkNtyXJe7L7xjCKbq2P09Kj2nb4gIhagHNYVzLG0Cak9J4XWEvJu0lwIty23YWsg+sVED8bncfqFX7N1OKuMIqvy1T5hcAWwumOLQi8WJDri+zX8QpLXMdYfd8+olgSQrWBGXvakkwgYvE9gbTgiEKoM6sQ/BR9i+K5WU00VPNKnEN3U/SoP6Pb+Y4rP4B7BBb1bTt5ZH++fW6EY3aYze/XjO+xi7Zqu9Nw2STomQ7GBqpEghrxOFWXrD3XhtJ/NVdLT6kOSkUezKWGPbSVVIUvxRd7dYP3pbAycCuOUXYbBN7beJqoWFVpDKd54maeFh6c2kvWrOVUU/gjfR8lt4VmO+cM86S3VmbWP1FvVKVmPd+CFJfai+NSQMVh/FCO7zO6p97odJTIzE1Qc2tHAeflFuGVX+7Ji0k10UCYQ5L0Js4X1Hj0XiSdprqnG9C2977VYbw5/h++eiw95xhp62aL7+MKR9CJ8fhE/esSBdpyj0JMR6xo+XiKuou8oOtWx3NxDK1D7imx2+eHDY69SLx+rdijpDpINsu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50074965-f9d6-43a2-7a78-08df3fa6c311
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 03:49:17.9370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/WcjzoikOt7acQ9hvb0vg+O1s9h8GkR8My2eo1iCcCSw59nMTcEDF2QGw1wmF3ywPQIftE6NsNs2X5IOBY1idda18Ex63iZ2JQDo1gvA84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8280
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDEwOjI1ICswODAwLCBXYW5nIFllY2hhbyB3cm90ZToNCj4g
S1ZNIGFscmVhZHkgZXhwb3NlcyB0aGUgU0JJIFNUQSBleHRlbnNpb24gYW5kIGl0cyBzaG1lbSBh
ZGRyZXNzDQo+IHRocm91Z2gNCj4gdGhlIG9uZS1yZWcgaW50ZXJmYWNlLCBidXQgUUVNVSBkb2Vz
IG5vdCBjb25zdW1lIGl0LiBBcyBhIHJlc3VsdCwgdGhlDQo+IGd1ZXN0LWNvbmZpZ3VyZWQgc2ht
ZW0gYWRkcmVzcyBpcyBub3Qga2VwdCBpbiBzeW5jIGJldHdlZW4gS1ZNIGFuZA0KPiBRRU1VLA0K
PiBhbmQgaXMgbG9zdCBvbiBtaWdyYXRpb24sIGJyZWFraW5nIFNUQSBmb3IgdGhlIGd1ZXN0IGFm
dGVyIGxpdmUNCj4gbWlncmF0aW9uLg0KPiANCj4gVGhpcyBzZXJpZXMgcHJvYmVzIGZvciBTQkkg
U1RBIHN1cHBvcnQgdmlhIGdldC1yZWctbGlzdCwgc3luY2hyb25pemVzDQo+IHRoZSBzaG1lbSBh
ZGRyZXNzIChzaG1lbV9sby9zaG1lbV9oaSkgYmV0d2VlbiBLVk0gYW5kIFFFTVUgKHNraXBwaW5n
DQo+IHRoZQ0KPiBwdXQgYXQgcmVzZXQsIHNpbmNlIHRoZSBhZGRyZXNzIGlzIGNvbmZpZ3VyZWQg
YnkgdGhlIGd1ZXN0KSwgYW5kDQo+IHNhdmVzDQo+IHRoZSBhZGRyZXNzIGluIHZtc3RhdGUgc28g
U1RBIGtlZXBzIHdvcmtpbmcgYWZ0ZXIgbGl2ZSBtaWdyYXRpb24uDQo+IE9ubHkNCj4gdGhlIFNU
QSBzaG1lbSBhZGRyZXNzIGlzIHNhdmVkIGZvciBub3c7IG90aGVyIFNCSSBzdGF0ZSBjYW4gYmUN
Cj4gYXBwZW5kZWQNCj4gdG8ga3ZtX3NiaV9zdGF0ZSBsYXRlci4NCj4gDQo+IENoYW5nZXMgaW4g
djI6DQo+IMKgLSBwYXRjaDAzLCBvbmx5IHNhdmUgdGhlIHNiaSBzdGEgc3RhdGUgaWYga3ZtIHNi
aSBzdGEgc3VwcG9ydGVkLg0KPiDCoC0gcmViYXNlIG9uIHJpc2N2LXRvLWFwcGx5Lm5leHQuDQo+
IA0KPiDCoC0gTGluayB0byB2MToNCj4gwqANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVt
dS1kZXZlbC8yMDI2MTAxNzE0NTIxMS4yMTkyNTgtMS13YW5nLnllY2hhbzI1NUB6dGUuY29tLmNu
DQo+IC8NCj4gDQo+IFdhbmcgWWVjaGFvICgzKToNCj4gwqAgdGFyZ2V0L3Jpc2N2L2t2bTogRGV0
ZWN0IFNCSSBTVEEgZXh0ZW5zaW9uIHN1cHBvcnQNCj4gwqAgdGFyZ2V0L3Jpc2N2L2t2bTogU3lu
YyBTQkkgU1RBIHNobWVtIHJlZ2lzdGVycyB3aXRoIEtWTQ0KPiDCoCB0YXJnZXQvcmlzY3Y6IEFk
ZCBTQkkgU1RBIHN0YXRlIHRvIHZtc3RhdGUNCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2
LXRvLWFwcGx5Lm5leHQNCg0KQWxpc3RhaXINCg0KPiANCj4gwqB0YXJnZXQvcmlzY3YvY3B1LmjC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICsrDQo+IMKgdGFyZ2V0L3Jpc2N2L2t2bS9rdm0t
Y3B1LmPCoMKgIHwgMTIyDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
IMKgdGFyZ2V0L3Jpc2N2L2t2bS9rdm1fcmlzY3YuaCB8wqDCoCAxICsNCj4gwqB0YXJnZXQvcmlz
Y3YvbWFjaGluZS5jwqDCoMKgwqDCoMKgIHzCoCAxOCArKysrKysNCj4gwqA0IGZpbGVzIGNoYW5n
ZWQsIDE0NyBpbnNlcnRpb25zKCspDQo=

