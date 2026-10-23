Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C4606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=EHOeliog;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=VEOJQGqn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK7WC-0005Gq-TF; Fri, 23 Oct 2026 01:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK7WA-0005GH-LM
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 01:08:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK7W8-0005Xx-IT
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 01:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792732116; x=1824268116;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mz3afZfNSd5tL20+Ydmr2i3AMw8eWOSOWi80kfMPWBk=;
 b=EHOeliog4VxkEArtENu0JSmp05PEespzk7xBXCY0+rIMSsTYwAE/zwq5
 V/fpiBcooaSRZN27IJHSNFyftQ7tHlmwedWSLoEh08G+G0JONt4ilTl81
 lkuRVXIAU/tioq3JGQK0xdrpq8KeyVT9DT8WugRTq5DAcbDWNUMhKP4nO
 PedEokM9/deY99C4t2ZilZGIViZzWK1R82ori0WIuLXubef+Qxma7w8Ia
 ca4O892eJo4nmathhTXP+KdrY2VhraYEBlOAGJ8cqp3KyBEA1RSU8H4F0
 gutKbiPcCLNdW18Oz6OlvG+7NKHHgy+F0MHsfUTc7nypkIKjZPskoRHyF Q==;
X-CSE-ConnectionGUID: oRVelX+kRwC/6MhUmh3TRQ==
X-CSE-MsgGUID: qXLmONbRQaGIhtlERhB2zg==
X-IronPort-AV: E=Sophos;i="6.27,173,1786982400"; d="scan'208";a="157200216"
Received: from mail-southcentralusazon11011051.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.51])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Oct 2026 13:08:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD4pJEf2ezeYC/Gcy1uqa3cruGzITSAtfRllRHDPUzXsDxOGb61j13MZcng1rddrsczOep858cp3yFZOHv3mR9KDKSLduGxQESrtiK9y7Oqhg1zHXLhfi0teUIjwvXLcsht7ViTZmigUcWjAAsJMNDZimEX9GjbYFmiCsc42eTFNXwuqMgjHad8oSghC4PeiH3Di74kFjMIuVYP4eeD8xefChs4aPqzvZRlfHe1XcufyCvapxgCNrsUIsh8shY9t85AA6djjgWk/9JM7z4louaAIZ2HSWyrLa854U7sg5EkFBEOZAXrkdhDyCTU4BMO8f5zbsR6aqcLtvBNfpQdVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz3afZfNSd5tL20+Ydmr2i3AMw8eWOSOWi80kfMPWBk=;
 b=iYg1Zmj3wTp+b/pPtKHV4pb+bvylmfgu1LfBDDk1s7pZWojPgDoEa+Pry93fbkaE0XMWQ11CH7196ASGZf6I0/531QJ16pgkCPj1VlNgxZdJXwYta3ca9BcFkPlnT8bBhlMo3nbaqla+9F5j/4zPOyzXvRm0XNI9nHhBE/y25/xXm9QARTmh8pKJvL3kgnVEs6oQAUPjXU3Vl6GzJ9shxPgt5utKQImSwmYEsFDarcPkrmRPXXjxO3dSyX3sHj0nL+Qz6eD0UIUan1khzN+GJnsY4gd0ZOssh5irKdQfXq7879DUKf67eDWV4qIjKVhOMcGRE50XaJOqGoXjJuMAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz3afZfNSd5tL20+Ydmr2i3AMw8eWOSOWi80kfMPWBk=;
 b=VEOJQGqnTUKIkdTTUzjoEv9opYeZz8wmzCKU887krMpyYGbhUPYMR+oZ4H4B5ZQF9cGPWVcWvngGUjyeltaK81r6MElUnIEMg8q5QGdvWWAUCBNdv27tDtcrfj5d7N8IAUh7Rhuf8or7ceeCy87jAmcpnrZU8NXDv6nZzTkv1Ek=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by PH0PR04MB8227.namprd04.prod.outlook.com (2603:10b6:510:106::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 23 Oct
 2026 05:08:32 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 05:08:32 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "luoyonggang@gmail.com" <luoyonggang@gmail.com>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 0/9] multi-target: add riscv64-softmmu
Thread-Topic: [PATCH v2 0/9] multi-target: add riscv64-softmmu
Thread-Index: AQHdXcVSPkrkhww1n0SttjOcokLX9LcIV/WAgAAyjACAAAI7gIAAVb+AgABOE4CAAWz+gA==
Date: Fri, 23 Oct 2026 05:08:32 +0000
Message-ID: <2ad1ac9ac54245f9b40d443590b3d28fb353673f.camel@wdc.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <929a2b8d-347f-4f6c-82eb-261febfe8db7@oss.qualcomm.com>
 <CAE2XoE88ma_mKg-40_3zOZyH3vtAndezpLp_5V6uM5DEgeo+1w@mail.gmail.com>
 <ebbc9e10-75da-4d8e-b752-4eb2e6637edb@oss.qualcomm.com>
 <dc63fd40f14a96f17964ce5c9e47eb5c9efff5b6.camel@wdc.com>
 <8a514978-6f76-42cc-a2a2-eb3fbe029159@oss.qualcomm.com>
In-Reply-To: <8a514978-6f76-42cc-a2a2-eb3fbe029159@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|PH0PR04MB8227:EE_
x-ms-office365-filtering-correlation-id: 10cd67b7-fcdf-4b03-b400-08df30c3af19
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|376014|366016|1800799024|6133799003|18002099003|261021123027099003|22082099003|261022105027099003|261022075727099003|261021135927099003|10067099003|4143699003|11063799006|38070700021|261021121427099003|261009223027099003|261022115727099003|56012099006;
x-microsoft-antispam-message-info: pDV6lp+TquQ/ojI9h23inu7ozDIabWqAKNbZEtD1gg7hBqUXHMj9mGAyUyBFwjeB8lfGaql3B+2YPrmP5T0eNDo9ahJL1a3D5UWrfjNPBprFWc0+YxMMKJzKz17OrIC4RixHKeLLVnP338hu+gQuTM3+pAXj4VAsAdxTCfRM//SyW74P2WDbVDiVNonOmofDeLw5cmu7V6+XFp3JWJEDcbh27h/esJlrqCEGV2/JG+emXuEI5GwAL6dcfcqxT+QWevs+es0s5XpukPbbTWazcGlk6zL9y2TEZOTuV2hknHELgoqTqGxUWgmu1BYRMq+BucANgMBlT/jhPvNB/Zr3LjhxmnkVOnziiGsLeJ5S6TQEYum3mK4omQY6RwwYZXxdFzcmCBnkDnNNEhqdzYg5ZIapARWdpOdLmLXxDKmG4UCFeIs+Die12A1MDgp58uSY1BEPP6dSkvJ3v+UKNwBgPWEzKbpO0QHNnFXxgmNbFfZb2i03v6hX5HCF1bPrAs/2z8rUGusUBBGzekchuA2nIya+8Q24Qhi5vxyx2fN4fQmqI3F3sD/UpBWrfj0Vhw0IU7PB2IUa0FjVxqex98czBKE+syFaG3gABRiMuCJVboqUlfyvJlxItgEoA95vRPK8LcRr5zpN1UfyyXqnO7/3WhA09VIc/gYGqJhce7vgh42vyc7kbaPKgyhbTwiq3dJifjKd4aeFQHyzbaQaLxW7hUfY9dhjpGaXOZ3uxzFSY3o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(376014)(366016)(1800799024)(6133799003)(18002099003)(261021123027099003)(22082099003)(261022105027099003)(261022075727099003)(261021135927099003)(10067099003)(4143699003)(11063799006)(38070700021)(261021121427099003)(261009223027099003)(261022115727099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEF5azR3T3ZFT2haTG9VbGNlTkpKVkhxbVJiNW5OdmYrbWtZN2FDZ3N1ZzF0?=
 =?utf-8?B?b3lXRnBlQ0Y4SXhyeXYvelc3eEt2OWpEVWFwSEpQRVV1eGhGU29lNGJLL1Nw?=
 =?utf-8?B?Sm9oYTBEaEsrd0twSUdxT0pLSzVFVUZlMU5SNlRockpTZU4vRVpJaHg3L0M0?=
 =?utf-8?B?RHFlbUduQ2RiZGlLcTFiSit2N092bTVCaUlBWjZjaG1JR1dFdVgrbHR4Ylcx?=
 =?utf-8?B?Y3M0bDRiYnVuQzNqOWtZdDRURHorUlpLb0NKNm9FcXdHVEpRSGl0Ym1uT1JH?=
 =?utf-8?B?REVaTUl1SVp6cW4rL3VaZ2xOUlhZTmZ6N1o5OW80YnpSdzdUSlBQcHZRY0Uz?=
 =?utf-8?B?Z05pZVJTb0tJNitlWXkvKzJidER4amRwSnluaFRYT1ZOdFR3bTJiSVI5L3B1?=
 =?utf-8?B?WGFsTjJ0VWJXNzJ3YVBiRW1TWEJPNFRIbnFDUFFReWtGMEY2VXpuSmJNQWxl?=
 =?utf-8?B?RWRjZ0grb2tYRFlNWjB6T2xMb0h2a0dvQ2syb21mcTBMbzlyVTB4MFo5Uk5x?=
 =?utf-8?B?UUtOQnJWNzE3RWdMSmhtaDlwUkpOUU1YVkRIdHVNeGNRWllLaklzVjkrZnR5?=
 =?utf-8?B?VVpXU3dabFcrM1IvQXhjYU10OVQzMVMxOElyZXZXQ3NhNXJiTFlPR1hUM0Rh?=
 =?utf-8?B?SmVMVGFady9lRFhGNStnVTExMjJwT2pvV0x4Q0wxUFJkQkNQZUtDaXBDSDEy?=
 =?utf-8?B?YjNyMlY0cGpKTjF3aitTeEpaa0Vneml0UCtVdVZkdWJDMzQ1cFhBaVU1YkQ2?=
 =?utf-8?B?d1J4aTZqSmlIVHNiWUFNcGdsSnB6NWVKSm1mQ2g3RnZBZFVCdEg1dFVVNER2?=
 =?utf-8?B?cERseC9FVW81cmVpYXdDOEw2Y2U3UFJTVklSbU45ZTJqSER0Zmp1UndZYnQz?=
 =?utf-8?B?a3RmWVlETlY5UEQvWTRZSU9WRmQ2ZWtMcktyVDYxbXRsbW1sZXUrNURQUUVV?=
 =?utf-8?B?K1I4eHd0cm5vNWJnbWNkdmxOVnVWdVJhWjVydjFZYnZvcjA2V0REMzE3VlZI?=
 =?utf-8?B?aEE4ZDBTMlhsdjBmQ2pUa2g1VVRFTFdVanAzUThuSEtmbTBSR0d1Y2pNUVhq?=
 =?utf-8?B?VGZkMmRKMWtmUCs2ZXJPVWNzR0tXbnhSUi9FZGc0OExoaE5lSkwzUHBIVmN3?=
 =?utf-8?B?YmltS0xWT0lZR2tHcVUzQUgyRWdKdHpEcGRwV0NWTFJiUlM2eUh6QWJaSVFP?=
 =?utf-8?B?cFUyN2pkN2pkc216NnYvY1IwdXMrMXFvejNVZlZUQy8vdTJpYTRiWTFtZHdr?=
 =?utf-8?B?eXQwdXl3SGdnTU9UME50aWwyYlJUYzR6WENtaHNZRHQwZEF2RFdFOEkyMjBl?=
 =?utf-8?B?TGorRlBQbHJQeU1NQTEwWUZhbUVwbFVCTGMwVEE3c2JZNHJLQy9aWGQ3UVBr?=
 =?utf-8?B?Z2lMMU83R3hPNzlrUjNHVHBpRHFkbENWRUliZXdIRHZVeUhmQkJ4dW5rNDNs?=
 =?utf-8?B?U3k5Y2hLNm9aS25TekIrRHpxa1d4dERhRVVFS2RNYzVLOE5PTFpqVlFPUU4y?=
 =?utf-8?B?YjRKRmpaTEV6ajBBK3N3OC9UYmFRU3VpUUh1SUZZajNrV1pZUVdNOEQxZkR1?=
 =?utf-8?B?Mi9TVENIWWV2dUlXNkhheE9sRDRoUXZTQmU4b3pjNlJqNHJpaG96R1VxN3hC?=
 =?utf-8?B?UjlhczFVRnRwakV5cEJDVTVZOEUyRkJ3elc2eW80bHRyY1A4SHZDL0xoRnc5?=
 =?utf-8?B?am1lWVl6MFVES3c2YitNb1NYQzRhWHJUcE9TejVFanM0QWphN0E3Qkt2aEoz?=
 =?utf-8?B?UmxRN1ZDWE91eHhzemlkRzlNUE1zQTRFWVIvY2pOUlB3Y2hsM0FweEdnSmM2?=
 =?utf-8?B?b1pJK0Nia2dianhCL0dXc2hkV0dJV29WWFl5LzBUM29XMDFxemdQNGVrZFBT?=
 =?utf-8?B?NEI0TkhqUjRMb1ZHWjZwcGRGc3NrN3dNbmU1RU5pTk03NWlnTFpZR3RIaUhO?=
 =?utf-8?B?akFWNkNWWjNPSU8rN1NrSVd2V2R0NW1Cb0JyN29WTVpwUGw5Z3l3RXowaGw1?=
 =?utf-8?B?dUpBWFoyb3VRTkFPaDh3QWE0ZWg3Ujd3dzJ1TVN3LzVhNTBDUHpHblhtRVNx?=
 =?utf-8?B?VFpPbXl1Q2lIQTY4UDFyVzlTRHRjSUgyYzNKUXd6MVFNUXZUWlc3a3FNVnlD?=
 =?utf-8?B?cExMWnlzeXFrODdNUmpmVWRpODllWmpIVWpqV3ZOaXh5T3hPbFQ2RWl5WHhz?=
 =?utf-8?B?enh4YTJldDAxTEV3TDhYSWJPQ2cybGluWjRMZWJJU1lKMmRkc0pBVWh6ZE8z?=
 =?utf-8?B?NG44a24wWGZJOXEwNTQzSy9sZE90YXdYVFMzMC9uOUpZUVlYVHhlL1VPS29S?=
 =?utf-8?B?S2NmcHBaT1FaT2R4MXdlR05CeGpia3pOdDBwVUtWWFFpcllqSEhPWCt3NTJ2?=
 =?utf-8?Q?WUGOE4jln/Ict1gs+Y+HAqKsPjYdpXAqRseMn7gqWtyBk?=
x-ms-exchange-antispam-messagedata-1: 9rqXExHQDnlIaPR48/Cf8dkOHnbDzBSJo/w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B38E90533E73340BC22C4AB695EB2FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uxwI4g547F7mZPBTLBnofXyNjdLdls4amJcsDwu8vyublDG4lBeA65HDT1quvU5RwTuyruHuCngW0oNC3kGRq+xOlux3rxC9kEoTRI4qr7bPvqfLbvmgqouHLgys9y5fTzXr4FeORsbkl1Pyx/qtcikEAtbXXsnpQODTkcs9dGtNSYFKeW8VeCNJ8oTia7MPD0dYb7xuNWvSYNQOSR1zZD0Xyx2/7CfOA3tihhknp1+05wwJRnhkEC+hGWrO6xhR26YTrectuddYKtEG1jYJ4Va85a3QmqwRHmOvKyEkUN8Gju6bQXfo0GnKchddaiE1VJbhYHRm8QDnM+aCJPht/g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NhFR7O+p82l+GZmjCWOHTHzxC9I5g9Q/wRRxvvG8ed8RqJsXdjk1VcCTreICmP2g7/WpyFqeAPBoBDvZCR43NNw+jldRcI+qd5zmlRzLwrWUSV0Fzw2BOgSABIOwXE92W2gI2a32GnPhy3CVDTEghD6zuwXsyVG2Ypjf4ADOCBejvBWRTqcN3pgTYf3Fe9dU7Duqd/lnV/mb1MlaWTcl0LJGxbBwhRqPvp6Jc8JOdBtdd/mDEBpzutQbVTaE+Aw9eJZjvtxuimSaV3RGNbCA3n2+DekP3cIqDkAKgyy4kyigZ3YOBtAfq7HML8VElPCY8pVWPZZJQCv/B1AUW0cRDxVv2KXRHiyV4/UhTlyNXSGquH+VUyjpiM50Uk72oErcn4Xd8OzsMgD+oBOq7sc5CY1lX1r8/NnctfFIemt87cQmvKycRu6ivOuNZ0UbY3HfFAbVu/A2e9jcVZi6r5m0kO2kmD/SnqoWFjrgwOs4TSlkoLVSPLKCllK7stPbhfOdIXkSo+Q8R/4SNbfOc2rJh4ql6YDEvWp5rF3KP5TOnJx/7boJa6Gkbz+XETwQHYJcnG8jN7oboDZII7UfK5ba6F2SuRZDxxkI1bNhksk3AhFDZhiDFTKWWyOdZkrIk8JK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cd67b7-fcdf-4b03-b400-08df30c3af19
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 05:08:32.4191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRP7/RD8XRnDczyjiqfQxwb8V8X+Xq4sMIWqJBrzSe3fbvBDR6eVMJpTjIRqRNv2NYPAxGQwltd02syu7gKVWTgg8zTPsCLY9DPHG+xLEMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8227
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=749f58b73=Alistair.Francis@wdc.com;
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDAwOjIyIC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiBPbiAxMC8yMS8yMDI2IDc6NDIgUE0sIEFsaXN0YWlyIEZyYW5jaXMgd3JvdGU6DQo+ID4g
T24gV2VkLCAyMDI2LTEwLTIxIGF0IDE0OjM1IC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiA+ID4gT24gMTAvMjEvMjAyNiAyOjI3IFBNLCBZb25nZ2FuZyBMdW8gd3JvdGU6DQo+ID4g
PiA+IE9uIFRodSwgT2N0IDIyLCAyMDI2IGF0IDI6MjfigK9BTSBQaWVycmljayBCb3V2aWVyDQo+
ID4gPiA+IDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IE9uIDEwLzE2LzIwMjYgNDoyMiBQTSwgUGllcnJpY2sgQm91dmllciB3
cm90ZToNCj4gPiA+ID4gPiA+IFRoaXMgc2VyaWVzIGFkZHMgdGhpcyB0YXJnZXQgdG8gc2V0IG9m
IG11bHRpLXRhcmdldC4NCj4gPiA+ID4gPiA+IENoYW5nZXMgYXJlIHN0cmFpZ2h0Zm9yd2FyZDog
ZnVuY3Rpb25zIGFuZCBoZWxwZXJzDQo+ID4gPiA+ID4gPiByZW5hbWluZywNCj4gPiA+ID4gPiA+
IGFuZCBvbmUgdHlwZQ0KPiA+ID4gPiA+ID4gcmVzdHJpY3Rpb24gZm9yIHRoaXMgdGFyZ2V0IG9u
bHkuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFdoaWxlIHRoZSBzZXJpZXMgYXBwbGllcyBj
bGVhbmx5LCBpdCB3aWxsIG5lZWQgdGhvc2UNCj4gPiA+ID4gPiA+IGFkZGl0aW9uYWwNCj4gPiA+
ID4gPiA+IHR3byBzZXJpZXMgdG8NCj4gPiA+ID4gPiA+IGJ1aWxkIG11bHRpLXRhcmdldCB0ZXN0
IGJpbmFyeToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gLSBCYXNlZC1vbjoNCj4gPiA+ID4g
PiA+IDIwMjYxMDE2MTgxNDEwLjE5MTc0My0xLXBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21t
LmNvbQ0KPiA+ID4gPiA+ID4gIm11bHRpLXRhcmdldDogcmVtb3ZlIGR1bXAgZnVuY3Rpb25zIGR1
cGxpY2F0aW9uIg0KPiA+ID4gPiA+ID4gLSBCYXNlZC1vbjoNCj4gPiA+ID4gPiA+IDIwMjYxMDE2
MTYyNTA5LjI0ODU0LTEtcGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tDQo+ID4gPiA+
ID4gPiAibXVsdGktdGFyZ2V0OiByZW1vdmUgcW1wX3F1ZXJ5X2NwdV9tb2RlbF9leHBhbnNpb24N
Cj4gPiA+ID4gPiA+IGR1cGxpY2F0aW9uIg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBVc3Vh
bGx5IEkgcHJlZmVyIHRvIHdhaXQgZm9yIHNlcmllcyB0byBiZSBtZXJnZWQsIGJ1dCBJDQo+ID4g
PiA+ID4gPiBoYXZlDQo+ID4gPiA+ID4gPiBnb29kIGhvcGUgdG8gY2F0Y2gNCj4gPiA+ID4gPiA+
IHRoZSBmcmVlemUgZGF0ZSBpZiBjdXJyZW50IHNlcmllcyBpcyByZXZpZXdlZCwgYW5kIHNlbmQg
YWxsDQo+ID4gPiA+ID4gPiB0aHJlZSBhdCBvbmNlLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiB2Mg0KPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gLSBtYWtlIHZp
cnQgbWFjaGluZSBvbmx5IGF2YWlsYWJsZSBmb3IgcmlzY3YgdGFyZ2V0cw0KPiA+ID4gPiA+ID4g
LSBlbmhhbmNlIG11bHRpLXRhcmdldCB0ZXN0IHRvIGRldGVjdCBkdXBsaWNhdGVkIHR5cGVzDQo+
ID4gPiA+ID4gPiBiZXR3ZWVuDQo+ID4gPiA+ID4gPiBhbGwgdGFyZ2V0cyAod2UNCj4gPiA+ID4g
PiA+IMKgIG1pc3NlZCB0aGUgdmlydCBtYWNoaW5lIHNpbmNlIHdlIHdlcmUgYWx3YXlzIHBpY2tp
bmcgdGhlDQo+ID4gPiA+ID4gPiBmaXJzdCB0YXJnZXQgYXZhaWwpDQo+ID4gPiA+ID4gPiAtIGFk
ZCBhbiBhZGRpdGlvbmFsIGNvbW1pdCB3aXRoIHRoZSByZXN0IG9mIHNvZnRtbXUNCj4gPiA+ID4g
PiA+IGNvbW1lbnRlZA0KPiA+ID4gPiA+ID4gZm9yIGZ1dHVyZSB3b3JrDQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+IFBpZXJyaWNrIEJvdXZpZXIgKDkpOg0KPiA+ID4gPiA+ID4gwqAgdGFyZ2V0
LWluZm86IGFkZCB0YXJnZXRfYmFzZV9yaXNjdg0KPiA+ID4gPiA+ID4gwqAgaHcvcmlzY3Yvdmly
dDogbWFrZSBtYWNoaW5lIGF2YWlsYWJsZSBmb3IgcmlzY3YgdGFyZ2V0cw0KPiA+ID4gPiA+ID4g
b25seQ0KPiA+ID4gPiA+ID4gwqAgdGVzdC91bml0L211bHRpLXRhcmdldDogY2hlY2sgUU9NIHR5
cGVzIGNhbiBiZQ0KPiA+ID4gPiA+ID4gaW5pdGlhbGl6ZWQNCj4gPiA+ID4gPiA+IHdpdGggYW55
DQo+ID4gPiA+ID4gPiDCoMKgwqAgdGFyZ2V0DQo+ID4gPiA+ID4gPiDCoCBody9yaXNjdi92aXJ0
OiByZXN0cmljdCBzY29wZSBvZiB2aXJ0X2lzX2FjcGlfZW5hYmxlZCB0bw0KPiA+ID4gPiA+ID4g
dGhpcw0KPiA+ID4gPiA+ID4gZmlsZQ0KPiA+ID4gPiA+ID4gwqAgdGFyZ2V0L3Jpc2N2OiByZW5h
bWUgdmlydF9hY3BpX3NldHVwIHRvDQo+ID4gPiA+ID4gPiByaXNjdl92aXJ0X2FjcGlfc2V0dXAN
Cj4gPiA+ID4gPiA+IMKgIHRhcmdldC9yaXNjdjogcHJlZml4IGhlbHBlcnMgY29uZmxpY3Rpbmcg
d2l0aCBvdGhlciBhcmNoDQo+ID4gPiA+ID4gPiDCoCB0YXJnZXQvcmlzY3YvdGNnOiByZXN0cmlj
dCB0Y2ctYWNjZWwtcmlzY3YtY3B1IHRvIHJpc2N2DQo+ID4gPiA+ID4gPiB0YXJnZXRzDQo+ID4g
PiA+ID4gPiDCoCBtZXNvbi5idWlsZDogYWRkIHJpc2N2NjQtc29mdG1tdSB0byBtdWx0aS10YXJn
ZXQNCj4gPiA+ID4gPiA+IMKgIG1lc29uLmJ1aWxkOiBsaXN0IGFsbCByZW1haW5pbmcgc29mdG1t
dSB0YXJnZXRzIGFzDQo+ID4gPiA+ID4gPiBjb21tZW50cw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiDCoGh3L3Jpc2N2L3ZpcnQtYWNwaS1idWlsZC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4gPiA+ID4gPiA+IMKgaHcvcmlzY3YvdmlydC5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgMTQgKysrKy0tLQ0KPiA+ID4gPiA+ID4gLQ0KPiA+ID4gPiA+ID4gwqBpbmNsdWRlL2h3L3Jp
c2N2L3ZpcnQuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCAzICstDQo+ID4gPiA+ID4gPiDCoGluY2x1ZGUvcWVtdS90YXJnZXQtaW5mby5owqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcgKysrKw0KPiA+ID4gPiA+ID4gwqBt
ZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTgNCj4gPiA+ID4gPiA+ICsrKysrKysrKysNCj4gPiA+
ID4gPiA+IMKgdGFyZ2V0LWluZm8uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMSArKysrKysNCj4gPiA+ID4gPiA+IMKg
dGFyZ2V0L3Jpc2N2L2hlbHBlci5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgMjQgKysrKysrLQ0KPiA+ID4gPiA+ID4gLS0tLQ0KPiA+ID4gPiA+ID4g
LS0NCj4gPiA+ID4gPiA+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9iaXRtYW5pcF9oZWxwZXIuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKy0tDQo+ID4gPiA+ID4gPiDCoHRhcmdldC9yaXNjdi90
Y2cvZnB1X2hlbHBlci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNiArKysr
LS0tDQo+ID4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+ID4gwqAuLi4vdGNnL2luc25fdHJhbnMvdHJh
bnNfcHJpdmlsZWdlZC5jLmluY8KgwqDCoMKgIHzCoCAyICstDQo+ID4gPiA+ID4gPiDCoHRhcmdl
dC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydmQuYy5pbmPCoMKgIHzCoCA4ICsrLS0tDQo+
ID4gPiA+ID4gPiDCoHRhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydmYuYy5pbmPC
oMKgIHzCoCA4ICsrLS0tDQo+ID4gPiA+ID4gPiDCoHRhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFu
cy90cmFuc19ydmkuYy5pbmPCoMKgIHzCoCA0ICstLQ0KPiA+ID4gPiA+ID4gwqAuLi4vdGNnL2lu
c25fdHJhbnMvdHJhbnNfcnZ6aWNmaXNzLmMuaW5jwqDCoMKgwqDCoCB8wqAgMiArLQ0KPiA+ID4g
PiA+ID4gwqB0YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfeGxyYnIuYy5pbmMgfMKg
IDQgKy0tDQo+ID4gPiA+ID4gPiDCoHRhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVyLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0ICstLQ0KPiA+ID4gPiA+ID4gwqB0YXJn
ZXQvcmlzY3YvdGNnL3RjZy1jcHUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCAxICsNCj4gPiA+ID4gPiA+IMKgdGFyZ2V0L3Jpc2N2L3RjZy90cmFuc2xhdGUuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKy0tDQo+ID4gPiA+ID4gPiDC
oHRlc3RzL3VuaXQvdGVzdC1tdWx0aS10YXJnZXQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8IDM0DQo+ID4gPiA+ID4gPiArKysrKysrKysrKysrKy0tLS0tDQo+ID4gPiA+ID4gPiDC
oDE5IGZpbGVzIGNoYW5nZWQsIDExMyBpbnNlcnRpb25zKCspLCA1NyBkZWxldGlvbnMoLSkNCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEV4Y2VwdCBpZiB0aGVyZSBhcmUgc3Bl
Y2lmaWMgY29tbWVudHMsIEknbGwgc2VuZCBpdCBhcyBhIFBSDQo+ID4gPiA+ID4gdG9tb3Jyb3cs
DQo+ID4gPiA+ID4gd2l0aCB0aGUgdHdvIGNvbXBhbmlvbnMgYmFzZWQtb24gc2VyaWVzLCBhbmQg
d2l0aCB0aGUgY3VycmVudA0KPiA+ID4gPiA+IGhlbHBlcg0KPiA+ID4gPiA+IHJlbmFtaW5nLCBh
cyB0aGVyZSB3YXMgbm8gY29tbWVudCBvbiBnZW5lcmFsIGhlbHBlciByZW5hbWluZy4NCj4gPiA+
ID4gPiBIZWxwZXJzDQo+ID4gPiA+ID4gcmVuYW1pbmcgY2FuIGJlIHJldmVydGVkIGFzIHBhcnQg
b2YgZ2VuZXJhbCBoZWxwZXIgc2VyaWVzLg0KPiA+ID4gPiANCj4gPiA+ID4gSGkgUGllcnJpY2sN
Cj4gPiA+ID4gSSBwZXJzb25hbGx5IGZlZWwgYSBnZW5lcmFsIGhlbHBlciBpbnRyb2R1Y2VkIHRv
byBtdWNoIG1hZ2ljLCBJDQo+ID4gPiA+IHRoaW5rDQo+ID4gPiA+IGhlbHBlcnMgcmVuYW1pbmcg
aXMgZmluZS4NCj4gPiA+ID4gSWYgd2Ugd2FudCBzaGFyaW5nIGEgbmFtZSwgYSBtb3JlIG1ha2Ug
c2Vuc2Ugd2F5IGlzIHJlZmFjdG9yaW5nDQo+ID4gPiA+IHRoZW0NCj4gPiA+ID4gaGF2ZSBzYW1l
IGJlaGF2aW9yLCBzdWNoDQo+ID4gPiA+IGFzIGFkZC9kaXYvbXVsLg0KPiA+ID4gPiANCj4gPiA+
IA0KPiA+ID4gSGkgWW9uZ2dhbmcsDQo+ID4gPiANCj4gPiA+IEl0J3Mgb25lIG9mIHRoZSByZWFz
b24gSSBwcmVmZXJyZWQgdGhlIGFkIGhvYyByZW5hbWUgc28gZmFyLCBub3QNCj4gPiA+IGJlaW5n
DQo+ID4gPiBzdXJlIHRoZSBlZmZvcnQgd2FzIHdvcnRoIHRoZSByZXN1bHQuDQo+ID4gDQo+ID4g
Q2FuIHdlIGF0IGxlYXN0IHJlbmFtZSBhbGwgb2YgdGhlbSB0aGVuPw0KPiA+IA0KPiANCj4gSSdt
IG5vdCBzdXJlIHRvIHVuZGVyc3RhbmQgd2hhdCBpcyBzdWdnZXN0ZWQuIElzIGl0IHRvIHJlbmFt
ZSAqYWxsKg0KPiByaXNjdiBoZWxwZXJzIHRvIHByZWZpeCB0aGVtIHdpdGggcmlzY3ZfLCBhbmQg
bm90IG9ubHkgdGhlIG9uZQ0KPiByZXF1aXJlZD8NCg0KWWVhaCwgZXZlcnl0aGluZyBzaG91bGQg
YmUgY29uc2lzdGVudC4gSSBkb24ndCByZWFsbHkgY2FyZSB3aGF0IHRoZQ0KYW5zd2VyIGlzLCBq
dXN0IHRoYXQgaXQncyBjb25zaXN0ZW50DQoNCj4gDQo+ID4gQWQgaG9jIHJlbmFtaW5nIGp1c3Qg
c2VlbXMgbGlrZSB0aGUgd29yc3Qgb2YgYWxsIHRoZSBvcHRpb25zDQo+ID4gDQo+IA0KPiBDb21w
aWxhdGlvbiAoYW5kIGxpbmtpbmcpIGFjdCBhcyBhIHNhZmUgYmFycmllciwgc28gd2hpbGUgaXQn
cyBub3QNCj4gY29uc2lzdGVudCwgd2UgY2FuJ3QgaW50cm9kdWNlIHJlZ3Jlc3Npb24uIEFsc28s
IGl0J3MgdGVtcG9yYXJ5Lg0KPiBJdCB3aWxsIGJlIGdvbmUgaW4gYSBmZXcgd2Vla3MuDQoNCk9o
LCB0aGF0J3Mgbm90IHRvbyBiYWQgdGhlbiBJIGd1ZXNzDQoNCkFsaXN0YWlyDQoNCj4gDQo+ID4g
PiANCj4gPiA+IFRoZSBvcmlnaW5hbCBhdHRlbXB0IHlvdSBzZW50IHRvIGZpeCB0aGlzIGJ5IHJl
bmFtaW5nIGJpbmFyeQ0KPiA+ID4gc3ltYm9scw0KPiA+ID4gdXNpbmcgYXNtKCkgaXMgZGVmaW5p
dGVseSB0b28gbXVjaCBtYWdpYyB0byBteSB0YXN0ZS4gSSBob3BlIHRoZQ0KPiA+ID4gc2Vjb25k
DQo+ID4gPiBhdHRlbXB0LCBzb3VyY2UgYmFzZWQsIHdpbGwgYmUgbW9yZSBzYXRpc2Z5aW5nLCBh
cyBpdCBoYXMgdmVyeQ0KPiA+ID4gbGl0dGxlDQo+ID4gPiBtYWdpYyAoanVzdCByZWx5aW5nIG9u
IEhFTFBFUiBhbmQgSEVMUEVSX0lORk8gbWFjcm9zKS4NCj4gPiA+IA0KPiA+ID4gSW4gYWxsIGNh
c2VzLCB0aGlzIGlzIGEgY29udmVyc2F0aW9uIHRoYXQgY2FuIGhhcHBlbiBpbiBwYXJhbGxlbA0K
PiA+ID4gb2YNCj4gPiA+IGVuYWJsaW5nIG1vcmUgdGFyZ2V0cyBzaW5jZSByZXZlcnRpbmcgdGhv
c2UgcmVuYW1lcyBpcyBhIHByZXR0eQ0KPiA+ID4gc2ltcGxlIHRhc2suDQo+ID4gDQo+ID4gQWdy
ZWVkDQo+ID4gDQo+ID4gQWxpc3RhaXINCj4gPiANCj4gPiA+IA0KPiA+ID4gUmVnYXJkcywNCj4g
PiA+IFBpZXJyaWNrDQo+IA0K

