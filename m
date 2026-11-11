Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1865D606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=AQvVTGK+;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=mS+/rpuE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQyCn-00073V-Ru; Tue, 10 Nov 2026 21:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQyCk-00072j-Ad; Tue, 10 Nov 2026 21:36:55 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQyCi-0006Ze-0O; Tue, 10 Nov 2026 21:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794364619; x=1825900619;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fwc5pXrX1QLWwOpLng+wlq/AaRirf0NRd0vDLGTfGks=;
 b=AQvVTGK+Zrc6h961Ry1TmNXNPs2ZGwLun5tIpQQdbwePBOIaj7i8B69Z
 sQHizXLkluglXQNYw+Oi/TMxPkzu7kEvwBfrwTWMWKuu38OzNHOxRnYaF
 gBpfuvxzA10ovVVYUT/hdyjiZIs60t2B5RSzzfBWX3QZEoI5vwmgy2qTB
 YOj6BGQOdthbyOFRObhBegUD/OC+NDwZIDbA92X6/lXatGshSBPgw11iF
 ZCL0XS4Mjg9Q43lfMVSp9CZQRhr4LNYvyWR/khEkOh8IkmvZvHPfUqDmY
 zuZMbu6SeBgmikSxuxxF/zXH1ntFrFdNFMHbIDzauyIFiZ8upe9o7YrAV Q==;
X-CSE-ConnectionGUID: ve1VhZKvQk2VG2ttUa6YFw==
X-CSE-MsgGUID: Y8BlhRAeSaqySxccR1RC8g==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="160592850"
Received: from mail-westus2azon11012008.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.8])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 10:36:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEyBH6tM32BNSeb88Nq+2tYvDAu52fMHEy9ywV3fSULzGWOhPd78m1dcInpQ/lP+F7ch/OC7tha9pyQ1x2LZ1UebQ5QeMn7nqTpr+dMXxTNXLLgdMyUo1r2ilbrSzUK6uZMIzZ9+WN6AL5HwypMsnvkQagmQL8kiOht5tFsAwQcgZPzMHDMBqCVC5hnQTMVaX2iuOmK+7TvAwjGE2HD8ZM4gQMSG/1Hgi3gqT6JCjzK8fpBOZs3fOOa/Y84Ap3SlhiAvU1wvOKPESzMHbOrqFGSojPs/jQjkX3pOhijQLKz0mdIuExmuvpnqmLMJI/C1UA5XOMjakMmP90y0f2aKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwc5pXrX1QLWwOpLng+wlq/AaRirf0NRd0vDLGTfGks=;
 b=h8SuBLIxV/hMqQ+Cdbhw4G6fgbjmtIUBM1QZuYWneMKWVWPJZ/7xYg8f2PqGQTGyD2nGjPTfz6XPqlUqXNosUOysn1PmFtQIJp+INtmkShz904Kp8Won4uD4ZVXa61S/GvrWZ3ER8IU8nb7SIB/k8+ITZScsFUlSFzEXFDWaYUysWRIedpGOTQFelYoz1N3bHsOJ4qTUHAJMbvDCZkr9XjxI4yUrSdOuriShDluI2Yq1abS4uDqvInfR9VGwnUdRasuAAWBPt2QmvbRHF3NgVAuw3gibTDSP12sRqKL4fEj3whze2STt1vDnprf5uxHCF6NOIkrjmtq8bRLk8Y7tgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwc5pXrX1QLWwOpLng+wlq/AaRirf0NRd0vDLGTfGks=;
 b=mS+/rpuEVZqQ/cMsO+wCmt5868FIv8ssVVNNxHmUui/nOU6j/IYis2BUf9Ngnnh7GdfWPfXZkeL7xm8s8PFSKxpgZHZw214MCnt88SfTVGrsKdjZr+5/wjWxyrZYlD6OWZvpNx2xWBntKjhkr9Dauvjasv2sSUHMf2/oASdO+C0=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by LV8PR04MB9295.namprd04.prod.outlook.com (2603:10b6:408:25b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 02:36:44 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 02:36:44 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] tcg/riscv64: Fix vector constant matching for logical
 ops
Thread-Topic: [PATCH v2] tcg/riscv64: Fix vector constant matching for logical
 ops
Thread-Index: AQHdWN9/XK8RIZPnBU6LIVVeL3bFb7cNAI+AgAUKUICAFk5aAA==
Date: Wed, 11 Nov 2026 02:36:44 +0000
Message-ID: <d230ae93a44b63138389d07c355c2e8d3154acd7.camel@wdc.com>
References: <20261010174742.3552498-1-aurelien@aurel32.net>
 <9ca6f711-e886-46a5-80ea-a6c750696a93@oss.qualcomm.com>
 <auEeif_51q1K9XOz@aurel32.net>
In-Reply-To: <auEeif_51q1K9XOz@aurel32.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|LV8PR04MB9295:EE_
x-ms-office365-filtering-correlation-id: c3661a1c-f12d-41e8-a8a5-08df3f9c9ff9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|1800799024|366016|19092799006|38070700021|261026121527099003|4143699003|261009223027099003|11063799006|261021121427099003|261022075727099003|261021123027099003|261026140227099003|261022105027099003|56012099006|261028144727099003|261102123227099003|22082099003|18002099003|6133799003|10067099003|3023799007;
x-microsoft-antispam-message-info: tVjVXRYccW5lzufod9UyXYvxX0rg2Eh55h4uDboHNOmQEDhWIEiFgfHmzA0sHw28NDHmEYVb9uZdUodAthLszt7kP5U0nYrE4wKexNAfkNS7qKXswSrbb8Im4GFJDKS60nlsXAxn+GO0gxqcw7UL9L4v4fU91s7s1BPRKAhujw3mL/dIM/q7Zc4V4R9PorHn4XxXFcNBIUWILHtIpeLT06oLHtBZ0TcatqeQDXtCTY2TROna4VJZPbhA0lw4edXqR12hBS4mDi5ITjJcuii4ky/i47P7O9tvoSUP+kYSg+wzQQQ5gkldqtEeprN9FHuc+jmL/OXjkb++NdC5cFJ4zHzcEcDyS+ALxzWIQ6hjbYiHcbYe16BQS09u5ZzFesVeBaaKpmE6n05C64OnMKlkDdTU8e871uNjHmKA55AB5f3O0lOfqlwQiFKOo4T5Gtc3JBvdVY7n8CdVefx1294YbXx+alFudTjJyoEQ6IsvlHaHprfcSz+tgGmfEQ+Q9bGo3UUrh/+WNqyVth4077UTRH9LVA9rSQcCY/fK+ltbzUp3DWvBAoKx86Y7zOlTe6rZEJ9YSmXQllnTEk3rykVwWYSx29A7KHYdVq0M++49RqgiGAh/0oVRCrETjCRL6Wz0Unvb5GYPupZ+7n31twrp+GH7QIFVnR6qHeoYSLq9n7tP777BVHqpF+X5mFjp/sne7qa8ap3fCzc49c4iKVlLk2oA7ppyDGjbileG0K2T1jE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(19092799006)(38070700021)(261026121527099003)(4143699003)(261009223027099003)(11063799006)(261021121427099003)(261022075727099003)(261021123027099003)(261026140227099003)(261022105027099003)(56012099006)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmxxRDZpd25QWllZRmUxSlJOcW9TanBTeWhlb2JIY2JUejlROGFGMU10dEEz?=
 =?utf-8?B?a1prRWd1N0lrZWVQTDVTRmpLQW92cm4rcXIyQS9NZnpiZ3BFanFPK1ZlUCtr?=
 =?utf-8?B?Z1VZWmhleFJyWElKR0IvMFFsamhRN0xQNmZIdzFwNUppTDV3NElDTEdEa2Fo?=
 =?utf-8?B?SEZSTTJiNUliRUJ4YU83QklaUGRRUEs0T2NQb0RVVElkRUdPVWNrZ0VEQ09y?=
 =?utf-8?B?UmZBZUs5eXoydkpvSDNmNWJXa1JRVTNCaXFYODZ5OEpDOERaU3h6UW1HZ3Nq?=
 =?utf-8?B?QWszMTNRSWtlcnBvb2xhT28zV0VBVzVkWWtoaWVnRmNITlMvcjlIb09yNDY3?=
 =?utf-8?B?Qk52MnVHZVA3VHVmUk91UXlDc0JoNEwybXpxYys2WndhUnpkL1pVdm4yM0Fr?=
 =?utf-8?B?ZWxmY3k1Ui8zTHN3cDFaMmJLelJLTU9RU1VoUGs5MHFpWHRSZFk4a2RMcVlY?=
 =?utf-8?B?MlM4eFFjZnFwdGJIOExINVJZMHN5SjE0MkwvNjkxTDFZbWFQTUZpTm5WMm9K?=
 =?utf-8?B?SlJ5WXp0RkNpTU9hVUJIVEUweElacGN1QWE3cDBmSThQTHE2Rk9YUUJWVW9T?=
 =?utf-8?B?YmlOZlN3ODd3TE5RU2tISkJXSE9BcXkrWSs4MXdxYWZDWFU2ZWFjNElIeXFB?=
 =?utf-8?B?TU5Rblh6ZCtINS9NOG5pNWxTMitQUnhQN2pseGFXa2VFNXZIKzZodW50MGdZ?=
 =?utf-8?B?WlNHMXVSMTFBYVJhY0U5d0tNSjd6V3dWNjNUZC9pdXhxcFZsOFVHZ0tBQm16?=
 =?utf-8?B?Q0FVc2g5QUcyVkRidGdxWWk1WkJxaTcxRzVYWHJ1aWZ4UXpONVB5VWdmK25M?=
 =?utf-8?B?T2NtN25wbWR0OFMvYm9MWjYycHhpTjdIeXJYYjlEL2dCSHNOV0RKRlRNNS9T?=
 =?utf-8?B?NDV4Ynh1eVRadU9yNjhHM2ZpZFlGUCtHWTdobWFxejNxWDgxVE5lNGRyczA0?=
 =?utf-8?B?QkcyODBMQ2hGMkNGMTRTLys5RlFCTlZVZkxtWkZTSlFNZFdNL25zUXJnUi9r?=
 =?utf-8?B?bWU5MzR6K0Fzb3IxWEVTTTlwc2ZVQldqUk9zdHBOU2ZLRW9xdFNlTldPTW91?=
 =?utf-8?B?bGJ2Nm1DekhlS2VkZ3QvazJ6N1BnKytTZGwzS1poY200UnVTV0VzNWk2QURh?=
 =?utf-8?B?aGU1N09xa3U1akR2N0V2MS9RUTlGN0JvaDZibGhNOU53OTJhdDNFSC85VlRy?=
 =?utf-8?B?eXZXMHJlQlowL0NuY1FXYm5yZk5yMkttVlpacTZ5V2liQm56MUxoT1NEZUhv?=
 =?utf-8?B?YWtLd0JtaDhMWUE2aWJxTktMNmJWK1FoeU9XSktlbWVDb3cyZjh0Uk1MMkF0?=
 =?utf-8?B?Rlk4ZzQxazNkMC9ZVlk5RFdoNkVHMlZzSkd1b0ZiUlZ0SDlzZHZuUEJKdzJV?=
 =?utf-8?B?Mms4TnplQnlHRGE4allpWlUxellyNzFrT1hVb2Rma2lOWDdraUxUMmVRSDEy?=
 =?utf-8?B?NW43TnlCZ1g4ZlJYdS9ocHRSKzJ0NXoyZFRYOXY3RUVOY09manNKd2UrUnBQ?=
 =?utf-8?B?RGd3KzZQUWpsakd2bklrSDVtQWRBUHQwMjlSamhhQzV0elVSdExhZXI5bWFp?=
 =?utf-8?B?VUhiRS9obllrRFE2bWNtV1hoTlc1MUREK0I0TUE3U0YyY2UxblNlM2xsZ1A5?=
 =?utf-8?B?dXAxdEFLZjBHeVgxM1BKS3ZzSW52ZmZsMDFmcU5TMGRqTnN3em9UY3I2aUZT?=
 =?utf-8?B?YmpRa0t1cDdySDBWREF2R0k5cVFwNUNFL2NoOU01d3RKQWkxR0lWMGFqc2dR?=
 =?utf-8?B?Y3NlQlFuSndSUEVrSnZGeTd1a3JIdnpHUXYyRFBDOVNEVkkzTXVnUmJxNDNR?=
 =?utf-8?B?amc5VTF1RzRHdlpYZEU1N0ZDMGQyYWwxRUtwMVh6ZW5DWE9UdlB0S0xUWmtD?=
 =?utf-8?B?ZEU3U09laWI5bVppTlpyTVpwMlg2M3JoL2p4cHRxbDFPTEhQNjRlSHMyeHZ2?=
 =?utf-8?B?YWhmN3VxTUdHTnlqaEZUYmpiWXNldkpRVWZ0ZUdETitOY2FreWRaUWFUV3pj?=
 =?utf-8?B?NFloZXl6cXhoNWlxV09qWHpSMXFGcVNFMXk1VU5qY0pueVAwYm94TmptSGVV?=
 =?utf-8?B?VXB6MmFvWTNjSk0vTkpUVTRYdEhieE40NzFIYnlpUVAzaWIza0VweTBmVVho?=
 =?utf-8?B?bmQ5MTNIZ1JaakgyU2x3TVZNY0hmU0l6Sm8vMWUvUWRvMkdRNlhsdkN3OU5z?=
 =?utf-8?B?WEd0Y2hISU9ISDc0N3VCSUpCV0JVeWFqbm9XOVZZUWNHMkNHTEE3SzR0amFo?=
 =?utf-8?B?a3BMZ3hxWnRxamwxWkVDQ1QwVU5kVDhoQmJBS3ArMWJTUHN0QnZnMnpQa0do?=
 =?utf-8?B?ZGdJMFdvdnpqZ0VwZ20vcmVVaTdoWHFuNXBSRVNQRUtGaGNCTFg1RzdmYm9t?=
 =?utf-8?Q?aSppLtI+t4AGQDrypvu1J9yZ/rgcYgh0CcEBxGwaCx4f5?=
x-ms-exchange-antispam-messagedata-1: j4hyUvUK/dwHX9KMpTq0E6f/+MEwivpn0cU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83967097C378D946818F2C0952D97F10@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OpQ01ayppt+Y+6Fm4yp/d0ZNoBG7JRl18ysn5ACXcdTmZ7O+IHTuAwYefqY3Ebjvx4UZfFnWBQt30V6G7xD24TripZZbqPyf0ln9Rm6nDgVqY8X0eKCGk8YgUSasG+N9dPrdrzlk2HfTwFaUlARddygT/s0zKYQNvDPNhXZywT8wZkzdrzX924Q/hCUwzQhTgTGOEXBvMQKMh0xfdvpZU3v1pRQgOgPthwe8oTBO6V/SPoTK/dYYQPzOJt+m6/FvuHKthIYhwgtRK0N9Qg6nF7vH03ABM8u65Cr21F9F9P2GrVj/AvUGCSF+zVrnNBPaNZFZcib/g04ooEvq81mm8w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U3d6MpBW1g3v4JyS1I1tsIAJIaHde6Br6x03VgrPHnvFD4zeyN37qMNKzES2WJd598htg3bl2G2UqJ3zoNXUTSOvxc7GnZBVIYVfaHxOtPailv4Ysr4V04qetewq4t1hQFQZrRElJtSnZy+Z6As5kVDtgMVIwcYlEcuv7b0v//r819hrXlU81376m4pc++Lnt4zLW2ifKHkXt7qmf458Q7v1Bm2lMST3baAwYsp0GFZOitv6SFKhD/XTaSgil3uncsBt7tRTXWHrzNMrJKDpGmdxNk5gxxFBuGcSTBdnnLr8Yx5nmKDzfP4u81aIHv+m+s5UPq4ZgvEzjvU5OIS1O6P4wK+VgZG1hvPaWEQKzRm6Odw7vomD/is8hBW0ynnf6hpj462xZRbrP2cvmiMGuPQn/kV12XYtOYi77SlcV2C31+vJ4VqW8R/3YFGFyIpE7iL36Bi1ZIkKa0rIKByt0HVWe+9T0Y49jdjGvg8HnCa6kVht+adMscyWx5rGhw/zXBP3l9qN5K5a5Zli3NXFct6ZKLpjqs4mQSh8tF+ZfWWY/s4g5iIORylnZW4sTFhiQKUanOcq/zsBydsM/QsAKJU3avofMIVRX891SRFj55fq/wLu1QF6cFGnGnWb4MeE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3661a1c-f12d-41e8-a8a5-08df3f9c9ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 02:36:44.0855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56mQB0kAtbXZnsweSoif1Tm4EEMHjd65fVZCXBSmYl3N+aY+yo7cv+bEEUcnNF5d8/zc2uQO49PCLekd3p9u4sAlTsr9fKO15b4OtbxvLds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9295
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTEwLTI3IGF0IDIyOjU4ICswMTAwLCBBdXJlbGllbiBKYXJubyB3cm90ZToN
Cj4gSGkgUGhpbGlwcGUsDQo+IA0KPiBPbiAyMDI2LTEwLTI0IDE5OjAwLCBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSB3cm90ZToNCj4gPiBPbiAxMC8xMC8yNiAxOTo0NiwgQXVyZWxpZW4gSmFybm8g
d3JvdGU6DQo+ID4gPiBGb3IgbG9naWNhbCB2ZWN0b3Igb3BlcmF0aW9ucyAoaW4gdGhlIGNhc2Ug
b2YgdGhlIFJJU0MtViBiYWNrZW5kDQo+ID4gPiB0aGF0DQo+ID4gPiBjb3JyZXNwb25kcyB0byBh
bmRfdmVjLCBvcl92ZWMgYW5kIHhvcl92ZWMpLCBWRUNFIGlzIHVudXNlZC4NCj4gPiA+IEhvd2V2
ZXIsDQo+ID4gPiB0Y2dfdGFyZ2V0X2NvbnN0X21hdGNoKCkgYWx3YXlzIHRyZWF0IGl0IGFzIGFu
IGVsZW1lbnQgc2l6ZSB0bw0KPiA+ID4gZXh0cmFjdA0KPiA+ID4gdGhlIGNvcnJlc3BvbmRpbmcg
Y29uc3RhbnQgZWxlbWVudCBmcm9tIHRoZSB3aG9sZSBjb25zdGFudC4NCj4gPiA+IA0KPiA+ID4g
VGhpcyBjYXVzZXMgdGhlIGZvbGxvd2luZyBhYXJjaDY0IGluc3RydWN0aW9uDQo+ID4gPiDCoMKg
IGJpYyB2NC44aCwgIzB4ZjANCj4gPiA+IHRvIGJlIHRyYW5zbGF0ZWQgaW50byB0aGUgZm9sbG93
aW5nIG9wOg0KPiA+ID4gwqDCoCAuLi4NCj4gPiA+IMKgwqAgYW5kX3ZlYyB2MTI4LGU4LHRtcDUs
dG1wNCx2MTI4JDB4ZmYwZmZmMGZmZjBmZmYwZg0KPiA+ID4gwqDCoCAuLi4NCj4gPiA+IHdoaWNo
IGlzIHRoZW4gdHJhbnNsYXRlZCB0byB0aGUgZm9sbG93aW5nIFJJU0MtViBpbnN0cnVjdGlvbjoN
Cj4gPiA+IMKgwqAgdmFuZC52aSB2MSx2MSwxNQ0KPiA+ID4gDQo+ID4gPiBGaXggdGhhdCBieSwg
d2hlbiBWRUNFIGlzIDAgYWthIE1PXzgsIG9ubHkgZXh0cmFjdGluZyB0aGUgZWxlbWVudA0KPiA+
ID4gaWYgdGhlDQo+ID4gPiBpdCBjYW4gYWN0dWFsbHkgYmUgcmVwcmVzZW50ZWQgYXMgYSBkdXBs
aWNhdGVkIGNvbnN0YW50Lg0KPiA+ID4gDQo+ID4gPiBGaXhlczogNWE2M2Y1OTk4NzkxICgidGNn
L3Jpc2N2OiBBZGQgc3VwcG9ydCBmb3IgYmFzaWMgdmVjdG9yDQo+ID4gPiBvcGNvZGVzIikNCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IEF1cmVsaWVuIEphcm5vIDxhdXJlbGllbkBhdXJlbDMyLm5ldD4N
Cj4gPiA+IC0tLQ0KPiA+ID4gwqAgdGNnL3Jpc2N2NjQvdGNnLXRhcmdldC5jLmluYyB8IDExICsr
KysrKysrKy0tDQo+ID4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBDaGFuZ2VzIHYxIC0+IHYyOg0KPiA+ID4gLSBVc2Ug
ZHVwX2NvbnN0KCkgaW5zdGVhZCBvZiBvcGVuIGNvZGluZyB0aGUgY29uc3RhbnQNCj4gPiA+IGR1
cGxpY2F0aW9uLg0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvdGNnL3Jpc2N2NjQvdGNnLXRh
cmdldC5jLmluYyBiL3RjZy9yaXNjdjY0L3RjZy0NCj4gPiA+IHRhcmdldC5jLmluYw0KPiA+ID4g
aW5kZXggMTRhMzk3MTE3YS4uMTI2MmI3MWE2MiAxMDA2NDQNCj4gPiA+IC0tLSBhL3RjZy9yaXNj
djY0L3RjZy10YXJnZXQuYy5pbmMNCj4gPiA+ICsrKyBiL3RjZy9yaXNjdjY0L3RjZy10YXJnZXQu
Yy5pbmMNCj4gPiA+IEBAIC0zOTIsOCArMzkyLDE1IEBAIHN0YXRpYyBib29sIHRjZ190YXJnZXRf
Y29uc3RfbWF0Y2goaW50NjRfdA0KPiA+ID4gdmFsLCBpbnQgY3QsDQo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIDE7DQo+ID4gPiDCoMKgwqDCoMKgIH0NCj4gPiA+IMKgwqDCoMKgwqAg
aWYgKHR5cGUgPj0gVENHX1RZUEVfVjY0KSB7DQo+ID4gPiAtwqDCoMKgwqDCoMKgwqAgLyogVmFs
IGlzIHJlcGxpY2F0ZWQgYnkgVkVDRTsgZXh0cmFjdCB0aGUgaGlnaGVzdA0KPiA+ID4gZWxlbWVu
dC4gKi8NCj4gPiA+IC3CoMKgwqDCoMKgwqDCoCB2YWwgPj49ICgtOCA8PCB2ZWNlKSAmIDYzOw0K
PiA+ID4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoCAqIEZvciB2
ZWN0b3IgbG9naWNhbCBvcGVyYXRpb25zLCBWRUNFIGlzIHVudXNlZCBhbmQNCj4gPiA+IGVxdWFs
cyB0byAwLCBzbw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqAgKiB3ZSBuZWVkIHRvIGNoZWNrIHRo
YXQgdGhlIGNvbnN0YW50IGNhbiBwcm9wZXJseSBiZQ0KPiA+ID4gcmVwcmVzZW50ZWQgYWZ0ZXIN
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgICogcmVwbGljYXRpb24uDQo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoCAqLw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgIGlmICgodmVjZSAhPSBNT184KSB8fCAo
dmFsID09IGR1cF9jb25zdCh2ZWNlLCB2YWwpKSkgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLyogVmFsIGlzIHJlcGxpY2F0ZWQgYnkgVkVDRTsgZXh0cmFjdCB0aGUgaGlnaGVzdA0K
PiA+ID4gZWxlbWVudC4gKi8NCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCA+Pj0g
KC04IDw8IHZlY2UpICYgNjM7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gwqDCoMKg
wqDCoCB9DQo+ID4gDQo+ID4gVGhpcyBmaXhlcyB0aGUgQklDIGNhc2UsIGJ1dCBJIGRvbid0IHRo
aW5rIGl0IGlzIHN1ZmZpY2llbnQuDQo+ID4gDQo+ID4gSSB0ZXN0ZWQgd2l0aCBxZW11LWFhcmNo
NjQgYnVpbHQgZm9yIGEgcmlzY3Y2NCBob3N0LCBydW4gdW5kZXINCj4gPiBxZW11LXJpc2N2NjQg
LWNwdSBtYXgsIGd1ZXN0IC1jcHUgbWF4LHN2ZS1kZWZhdWx0LXZlY3Rvci1sZW5ndGg9MTYuDQo+
ID4gDQo+ID4gTkVPTiBiaWMgdjAuOGgsICMweGYwIC8vIGZhaWwgb24gbWFzdGVyLCBub3cgT0sN
Cj4gPiANCj4gPiBhZGQgejEuYjsgYW5kIHowLmQsICMweGYgLy8gRkFJTA0KPiA+IGFkZCB6MS5k
OyBhbmQgejAuYiwgIzB4ZiAvLyBGQUlMDQo+ID4gYWRkIHoxLmI7IG9yciB6MC5kLCAjLTE2IC8v
IEZBSUwNCj4gPiBhZGQgejEuZDsgZW9yIHowLmIsICMweGYgLy8gRkFJTA0KPiANCj4gVGhpcyBp
bmRlZWQgZG9lc24ndCB3b3JrLiBUaGUgcHJvYmxlbSBpcyB0aGF0IHdoaWxlIHRoZSBjb25zdGFu
dCANCj4gbWF0Y2hpbmcgaXMgYmVpbmcgcGFzc2VkIFZFQ0UgPSAwIChhcyBpdCBpcyB1bnVzZWQg
Zm9yIGxvZ2ljYWwgb3BzKSwNCj4gdGhlIA0KPiBjb2RlIGdlbmVyYXRpb24gaXMgc3RpbGwgYmVp
bmcgcGFzc2VkIGEgNjQtYml0IHNpemUuIFRoZXJlZm9yZSBmb3INCj4gdGhlIA0KPiBlb3IsIGl0
IGVtaXRzOg0KPiDCoCB2c2V0aXZsacKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB6ZXJv
LDIsZTY0LG0xLHRhLG1hDQo+IMKgIGx1acKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdDYsMw0KPiDCoCBhZGRpd8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB0Nix0NiwtNDQ4DQo+IMKgIGFkZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdDYsdDYsczANCj4gwqAgdmxlNjQudsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHYxLCh0NikNCj4gwqAgdnhvci52acKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHYxLHYxLDE1DQo+IA0KPiBJdCB3b3VsZCBtYWtlIG1vcmUgc2Vuc2UgdG8gdXNlIDE2IGU4
IGVsZW1lbnRzIGxpa2UgaW4gdGhlIG9yaWdpbmFsDQo+IEFSTSANCj4gU1ZFIGNvZGUsIGJ1dCBp
dCBzZWVtcyB0aGF0IGluZm8gaXMgbG9zdCBhdCB0aGlzIHN0YWdlLg0KPiANCj4gPiBOb3QgYWNj
ZXB0aW5nIGNvbnN0YW50cyBmb3IgYW5kL29yL3hvcl92ZWMgYXQgYWxsDQo+ID4gKHVzaW5nIENf
TzFfSTIodiwgdiwgdikgdG8gZ2V0IHRoZW0gbG9hZGVkIGludG8gcmVnaXN0ZXJzKQ0KPiA+IG1h
a2VzIGFsbCBmaXZlIGNhc2VzIHBhc3MgKEknbSBub3Qgc3VyZSB3ZSB3YW50IHRvIGtlZXANCj4g
PiB0aGUgLnZpIGZvcm1zKToNCj4gPiANCj4gPiAtLSA+OCAtLQ0KPiA+IGRpZmYgLS1naXQgYS90
Y2cvcmlzY3Y2NC90Y2ctdGFyZ2V0LmMuaW5jIGIvdGNnL3Jpc2N2NjQvdGNnLQ0KPiA+IHRhcmdl
dC5jLmluYw0KPiA+IC0tLSBhL3RjZy9yaXNjdjY0L3RjZy10YXJnZXQuYy5pbmMNCj4gPiArKysg
Yi90Y2cvcmlzY3Y2NC90Y2ctdGFyZ2V0LmMuaW5jDQo+ID4gQEAgLTI3NzksMTUgKzI3NzksMTUg
QEAgc3RhdGljIHZvaWQgdGNnX291dF92ZWNfb3AoVENHQ29udGV4dCAqcywNCj4gPiBUQ0dPcGNv
ZGUNCj4gPiBvcGMsDQo+ID4gwqDCoMKgwqAgY2FzZSBJTkRFWF9vcF9hbmRfdmVjOg0KPiA+IMKg
wqDCoMKgwqDCoMKgwqAgc2V0X3Z0eXBlX2xlbihzLCB0eXBlKTsNCj4gPiAtwqDCoMKgwqDCoMKg
wqAgdGNnX291dF9vcGNfdnZfdmkocywgT1BDX1ZBTkRfVlYsIE9QQ19WQU5EX1ZJLCBhMCwgYTEs
IGEyLA0KPiA+IGMyKTsNCj4gPiArwqDCoMKgwqDCoMKgwqAgdGNnX291dF9vcGNfdnYocywgT1BD
X1ZBTkRfVlYsIGEwLCBhMSwgYTIpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+ID4g
wqDCoMKgwqAgY2FzZSBJTkRFWF9vcF9vcl92ZWM6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBzZXRf
dnR5cGVfbGVuKHMsIHR5cGUpOw0KPiA+IC3CoMKgwqDCoMKgwqDCoCB0Y2dfb3V0X29wY192dl92
aShzLCBPUENfVk9SX1ZWLCBPUENfVk9SX1ZJLCBhMCwgYTEsIGEyLA0KPiA+IGMyKTsNCj4gPiAr
wqDCoMKgwqDCoMKgwqAgdGNnX291dF9vcGNfdnYocywgT1BDX1ZPUl9WViwgYTAsIGExLCBhMik7
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4gPiDCoMKgwqDCoCBjYXNlIElOREVYX29w
X3hvcl92ZWM6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBzZXRfdnR5cGVfbGVuKHMsIHR5cGUpOw0K
PiA+IC3CoMKgwqDCoMKgwqDCoCB0Y2dfb3V0X29wY192dl92aShzLCBPUENfVlhPUl9WViwgT1BD
X1ZYT1JfVkksIGEwLCBhMSwgYTIsDQo+ID4gYzIpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoCB0Y2df
b3V0X29wY192dihzLCBPUENfVlhPUl9WViwgYTAsIGExLCBhMik7DQo+ID4gwqDCoMKgwqDCoMKg
wqDCoCBicmVhazsNCj4gPiDCoMKgwqDCoCBjYXNlIElOREVYX29wX25vdF92ZWM6DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoCBzZXRfdnR5cGVfbGVuKHMsIHR5cGUpOw0KPiA+IEBAIC0yOTc2LDE1ICsy
OTc2LDE1IEBAIHRjZ190YXJnZXRfb3BfZGVmKFRDR09wY29kZSBvcCwgVENHVHlwZQ0KPiA+IHR5
cGUsDQo+ID4gdW5zaWduZWQgZmxhZ3MpDQo+ID4gwqDCoMKgwqAgY2FzZSBJTkRFWF9vcF9yb3Rs
aV92ZWM6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gQ19PMV9JMSh2LCB2KTsNCj4gPiDC
oMKgwqDCoCBjYXNlIElOREVYX29wX2FkZF92ZWM6DQo+ID4gLcKgwqDCoCBjYXNlIElOREVYX29w
X2FuZF92ZWM6DQo+ID4gLcKgwqDCoCBjYXNlIElOREVYX29wX29yX3ZlYzoNCj4gPiAtwqDCoMKg
IGNhc2UgSU5ERVhfb3BfeG9yX3ZlYzoNCj4gPiDCoMKgwqDCoCBjYXNlIElOREVYX29wX3NzYWRk
X3ZlYzoNCj4gPiDCoMKgwqDCoCBjYXNlIElOREVYX29wX3Nzc3ViX3ZlYzoNCj4gPiDCoMKgwqDC
oCBjYXNlIElOREVYX29wX3VzYWRkX3ZlYzoNCj4gPiDCoMKgwqDCoCBjYXNlIElOREVYX29wX3Vz
c3ViX3ZlYzoNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBDX08xX0kyKHYsIHYsIHZLKTsN
Cj4gPiDCoMKgwqDCoCBjYXNlIElOREVYX29wX3N1Yl92ZWM6DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gQ19PMV9JMih2LCB2Sywgdik7DQo+ID4gK8KgwqDCoCBjYXNlIElOREVYX29wX2Fu
ZF92ZWM6DQo+ID4gK8KgwqDCoCBjYXNlIElOREVYX29wX29yX3ZlYzoNCj4gPiArwqDCoMKgIGNh
c2UgSU5ERVhfb3BfeG9yX3ZlYzoNCj4gPiDCoMKgwqDCoCBjYXNlIElOREVYX29wX211bF92ZWM6
DQo+ID4gwqDCoMKgwqAgY2FzZSBJTkRFWF9vcF9zaGx2X3ZlYzoNCj4gPiDCoMKgwqDCoCBjYXNl
IElOREVYX29wX3NocnZfdmVjOg0KPiA+IMKgwqDCoMKgIGNhc2UgSU5ERVhfb3Bfc2Fydl92ZWM6
DQo+ID4gwqDCoMKgwqAgY2FzZSBJTkRFWF9vcF9yb3Rsdl92ZWM6DQo+ID4gwqDCoMKgwqAgY2Fz
ZSBJTkRFWF9vcF9yb3Rydl92ZWM6DQo+ID4gwqDCoMKgwqAgY2FzZSBJTkRFWF9vcF9zbWF4X3Zl
YzoNCj4gPiDCoMKgwqDCoCBjYXNlIElOREVYX29wX3NtaW5fdmVjOg0KPiA+IMKgwqDCoMKgIGNh
c2UgSU5ERVhfb3BfdW1heF92ZWM6DQo+ID4gwqDCoMKgwqAgY2FzZSBJTkRFWF9vcF91bWluX3Zl
YzoNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBDX08xX0kyKHYsIHYsIHYpOw0KPiANCj4g
SSBiZWxpZXZlIHRoYXQgdW50aWwgVENHIGlzIGFibGUgdG8gcHJvcGFnYXRlIFZFQ0UgZXZlbiBm
b3IgbG9naWNhbA0KPiBvcHMsIA0KPiB0aGlzIGlzIHRoZSB0aGluZyB0byBkby4gSXQgZ2VuZXJh
dGVzIHN1Ym9wdGltYWwgY29kZSwgYnV0IGNvcnJlY3QNCj4gb25lLiANCg0KQXJlIHlvdSBhYmxl
IHRvIHVwZGF0ZSB0aGlzIHBhdGNoIGFuZCBzZW5kIGEgdjMgdGhhdCBpbmNsdWRlIHRoZXNlDQpm
aXhlcywgb3IgaWRlYWxseSB3aGF0IFJpY2hhcmQgc2FpZD8NCg0KQWxpc3RhaXINCg0KPiBUaGVy
ZWZvcmUNCj4gDQo+IFJldmlld2VkLWJ5OiBBdXJlbGllbiBKYXJubyA8YXVyZWxpZW5AYXVyZWwz
Mi5uZXQ+DQo+IFRlc3RlZC1ieTogQXVyZWxpZW4gSmFybm8gPGF1cmVsaWVuQGF1cmVsMzIubmV0
Pg0KPiANCj4gQ2hlZXJzDQo+IEF1cmVsaWVuDQo=

