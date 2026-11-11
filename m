Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D92F606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=bC1a5ZMa;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=TgUtbHFQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR0UN-0003Pk-KV; Wed, 11 Nov 2026 00:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR0UB-0003OQ-F2; Wed, 11 Nov 2026 00:03:03 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR0U9-000539-IC; Wed, 11 Nov 2026 00:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794373381; x=1825909381;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=WsLuW8p+cKphvxwj00oWC1W1ZevVwtszIsd8Z0KlpKs=;
 b=bC1a5ZMaKwmOLyBFVV3I1o0Wks77mN8u81/M0JJYbzZ+8tqcu8qU8Htn
 ABTmQs3gxsfURuAotksTIp8Tqbe+cebFhRyQq7kycM4WeejdgAtuMzpw9
 48o94o1xHukcxkp/vIN7DWezfJB83QJ/g/9mopsnj1vvmM6BGi7xkSE9E
 Le7xZEVWhyU0fCkGBfCHd3L/r4iEdL5KevHgTXM0OhsiPosepLquYp84W
 tCLco9QyPZ+YwIoi39e9Ngb5vhWOoqXgJl8RW1LcON9Q9v+aAYfC8bX1O
 6LUsl9dN8X1QDuSJ8uZ63Wj38pRIkSemCnN3PZuLniyFjJJCXdfIJ0hzW w==;
X-CSE-ConnectionGUID: 8GWKGfakQquus00kcvGsUg==
X-CSE-MsgGUID: JT6CuPGRRjmtTmPfDu0vaw==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="161577413"
Received: from mail-southcentralusazon11012050.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.50])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 13:02:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXy0hJXRUElVfIx3DTmZOf1zd7KSiyzyiPD+4h4ZpZUzselQHCOaL9772BtRz1WeI1Z8GPRbdP+F5BBh4L1oR14raiY0FL8Mz6gVXswlVrDx+zVnODg0Vw8GjqR7IEGssk+mlmpBlnk7FdjWM3Vt3N2CYKTKeBGuTQtYFSkp/vY4fgMOQ39hnX5UC+8Y3lZ45OMda1ht4Ab6J2ALWOljBw4Uz8+dl3YbY8zjTiZxP4/Nhwm3A3wZREDTTnfy1y4t6bd6aoNVhOrJj5jwOKQPejZbtJmXlSRQc4JSuhENTTKK6mtVqrKK9TjOnZ/LkJgokKqjRH0PM6G2R90i3+zvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsLuW8p+cKphvxwj00oWC1W1ZevVwtszIsd8Z0KlpKs=;
 b=qaQVwSa0eE6cWqvBinjkaogFD5E82rBAux0otdloaM8JUYwD+vkj1229Cl2zlQ+kcQ51Ys9+gkFKnwT6BDkTZZ0ZGef5bf1D7d8vwlPgJfo9+pKxWAyMk4dXf+DOkluaCap3xwjmA7G8ZjyQ3+bT/Ex3vo1HklqSBQqovv2Jgs45vqAbEO+P5sKgfciohZsAH8MRoAteYBT/3SHlGXEejTiH9ffPQliwE33SomANImOJEKjq4M7ILIAhLWKdo4rrBcfqhfmWV/oqK8rQ5id8K1UB0iE0NiSIV8WVXNJ2IAtAgaiuaDwGFkOjXki9iHY4gQ5mbPDOxUeHt+PCPBG9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsLuW8p+cKphvxwj00oWC1W1ZevVwtszIsd8Z0KlpKs=;
 b=TgUtbHFQE0KRetSjOuxJOmFCq+o1Kx8NpdKShGrFk7Hr3p6FVNcNt52IkLPVRFKuAE9DHEy2XuwkG9CDEZYimU8LXEe2B2ytb3Hqhm85PPh0DpCOMqII/He1LFl0lT/QQK6pUURdG4YZRNb/D5dyxKxaqsyyQheo+7VWDFsAllI=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by PH8PR04MB994610.namprd04.prod.outlook.com (2603:10b6:510:706::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 05:02:57 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 05:02:57 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "palmer@dabbelt.com" <palmer@dabbelt.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "wang.yechao255@zte.com.cn" <wang.yechao255@zte.com.cn>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "liu.xuemei1@zte.com.cn" <liu.xuemei1@zte.com.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v5 3/4] include/qemu/bitops: Move BITS_TO_U64S to bitops.h
Thread-Topic: [PATCH v5 3/4] include/qemu/bitops: Move BITS_TO_U64S to bitops.h
Thread-Index: AQHdZPOp1EdVjWXDzEO6IS5FJAe5urcoaewA
Date: Wed, 11 Nov 2026 05:02:57 +0000
Message-ID: <df789d421c7e8e2df61cf7348f13fe6e885a29e1.camel@wdc.com>
References: <20261026024048.630015-1-wang.yechao255@zte.com.cn>
 <20261026024048.630015-4-wang.yechao255@zte.com.cn>
In-Reply-To: <20261026024048.630015-4-wang.yechao255@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|PH8PR04MB994610:EE_
x-ms-office365-filtering-correlation-id: 03704654-763f-4565-0e1a-08df3fb10d65
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|7416014|23010399003|366016|19092799006|4143699003|261009223027099003|10067099003|261028144727099003|261102123227099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|56012099006|38070700021|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 3VQfqJcjATc8yYW4upor9fwejTXHxDARhGP0ca7g179DE4jduHUpvEXYENUM1Q3+CChEewp9hsHjDrOgeCU6P+zkw3VVSNI6Pfj8z8IXNHLgUq4AHrM86zacEJHmvxx8QtGaSb9hViUndIIAVzt/75YrZsfsVg0pcEf3f1uCQk/WxJYyw1V95CT19H2vNamZO2u1IQ5gGxN3gWK7Mh2dlfxtvrjZ5aZ0NLPHhuBD3PQvnC3DiG+inFyFTskcoej6tmjBol8tpT7cGlqEIfjUsxAkJ2ynZacMj0pOrWWbd0JhdxITu0WdVUqC8JrJLwa32zoqo/WJuTTUA7QqJc5KhcEqT2+hmMqz+xibvIVPJunQ+Rk0FWm/ri8Zm8xFt610UBVMy3TYiRs4RsvaFyGGxFBQCR/s9RwSoPDEw482etmFLZw+LRlBGgnQaNctHvhuQPM206w3Uk8lZ2ESI/xSme8AmoVwM4qVXeYO9IWrfir2Un4C7lXF6N8jFiGcQPBGIusMzK2SprIdHlaimxp5hYcHPj0PAqYZ8SWorutTaS+ZBDwwy+N46iX/2WgUOk377FrCBM/3ch9ODbt+cDcNvG3/KXxIMoKX/Nbru1WjRUugMIWTqSPrzrOT4xG53AuPmvU7DGxQhxjCZkJZ178Jcd3gSHydCBYQtCmSVydKM/IIdraBj43FlDiL/WBUs/y4FeBPeQhwgDauiLU79nBeia4dzde93kEi1QwNJVaJwbQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(23010399003)(366016)(19092799006)(4143699003)(261009223027099003)(10067099003)(261028144727099003)(261102123227099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(38070700021)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjFNYVdTTjNLbHEyeXNVaThKZlJTVjZiYXp1alRDVmlkYjY0UzhyRmFDVGRl?=
 =?utf-8?B?VEl4bVZvK3FxT2orME1CbDRKREtGNTd0T1VRcm1LZ1hlNXcyZGdqR0hMNkdp?=
 =?utf-8?B?blYvS28wdGpFRnh0T0xCdldvdktDRmhCcWlUejFqdDRhdUZ1eTlqMnVtV1lt?=
 =?utf-8?B?bzUyQ2tNc3d5ckJmQ0VOblVVWkYrNWFNUSt1NEZkSHl1WS85OHZMbTZEWUlP?=
 =?utf-8?B?MC95d2FvKy9wZmZDZUxSMWZWdHd4V2NBVTdQQ05UQlUzOVpTZTdhVUNRMkhC?=
 =?utf-8?B?S0JWMnNBR3VpQm52aVdBZWZNNnB1Z2k2RUxRcFAxRjN5cDhKaUhSU2o2WVND?=
 =?utf-8?B?bFpBQ2xNaU1VMS8za3BpV20zbWRQWHh5UWhvTE1yUC9VZGd6S1F5bnRrVzMz?=
 =?utf-8?B?M1NvWlJJcmdmbUMwKzhuUTk0UGUzVlBzZ0F3S1ZnTXdUOGRidExjczE3YVN1?=
 =?utf-8?B?OXdhcjEwMXYvRGhTQU42N3MwYTNvQ1NzSzEvQmhwYTJsY1pQTDZzMkZTYUpF?=
 =?utf-8?B?R0lLZFNjQlVNSXk0R1did096TXlNaDh4eHpCR2RtcGcxTm1Weit6ZUJ4aWlG?=
 =?utf-8?B?NGxsQkI5UXhCYkgwaDhRbmt0dlF5b04rWlE0aE1WQm5FRnRLTms0M0NxWFlj?=
 =?utf-8?B?UzBNMGdnaGV4VUs0dGEyVmNIeHpUUGMwRmhsMXhLS2RtMGErbWdoNnN1UTFQ?=
 =?utf-8?B?bGs5dGcvaERSbjlINUVCY1lBNHNnM29hRENwcTJUS091R2FleXhxQXgzT1dm?=
 =?utf-8?B?d0FNK05ndEVoOHBob3FqZVE2RGV1THM3bnBXUXdFeXJlYVM2aTEzMGZZWFV2?=
 =?utf-8?B?akhuU1JLbTJIK1gwYVNFSkZialM3dHVRZG05RU8wczJZS2lBVmRiYldjNit0?=
 =?utf-8?B?V2JCbFdhQ2padE56RlZHY0ZXN2drSDhzTW5NU3lUUDl6MFFBbFFpa25ySFR0?=
 =?utf-8?B?R1RVTjJ1VVFiZnNHb2FhdUhUZTMzT0tzTStIRHBnMGdReG16TTI0Sjhza01z?=
 =?utf-8?B?R3l2eFYvTlk0U2VGa0hsbTcxSjd6L0dNK0luUFN4ZUFQZ0Erdm84cktKVlh1?=
 =?utf-8?B?OWliZ2t3bXFEcmgvMGtSZndVMnhSaEo1V2xLWVBMY2tQSTlFREVUdGNIZWlo?=
 =?utf-8?B?TUVnNCtDRDEzMUExTXJhVDErSklqenRIUXpEZnlrelJjNU1DRkFUbkZQamt2?=
 =?utf-8?B?bEZaTjFDTjRWdUsvUTlONXdDTWtuRWYrSHcwelY4SlplQ1ZCc2psU1RvSERm?=
 =?utf-8?B?RDVxMHFUNjFGbHR6bExVVWFVclpTMWEyK3YrOUowNXREVkZuaFEwR0hWZlYz?=
 =?utf-8?B?UDVVQ1JqcXJuRGIzb051L1d5b2ZjMmlrN1dkMEo3Nm5xQ3FTZlloZVgrZ0xJ?=
 =?utf-8?B?bVFOTk5EcG81Q1U5T1FidXBnQ2pSNnNDZFcreEZpY2RYblVqdnhqVkIzVUYv?=
 =?utf-8?B?T0xabXpZa1VScUJMU1FXbTlrQXBWbUlDUWIremxFemwyMVhldzdrZlpxL2I5?=
 =?utf-8?B?QlNuQ2dNNmVwM0tOZnRoQ24yOTN4eFd4aXBPTzBDTWRWK04yQy9jM05FYW4r?=
 =?utf-8?B?cVlHK29zUW1tM0VRZFZpREdKNG1oYVB2NDBiangraE05U1lLSHhQc29lbExw?=
 =?utf-8?B?aGJ2and0U0V3TlhIMGx0Q25lTjgrK0ZFaE1ONDJsNld1d1JFL2d3NlorcE4x?=
 =?utf-8?B?M0FvTXVZQUdxOHB3TG9KWDZwZ1YyQkg3RDFMd2JmRldSTVJVYUZLSUJ5S05T?=
 =?utf-8?B?RDgzVVdJYlVHYkdMcVk2Z0E3ZjFpdFNJcUFSUzNmWDVoWkkrbElSZkZqdnh0?=
 =?utf-8?B?Z2pQUFJFenVBUUUxQ2NzWG02SU4rVjYranA3MWpPcFRqL1ZWaXUxL1RXQ0VD?=
 =?utf-8?B?ajFmYVgrNTE0c3M3ZHh1S2c5cm5jM1BSYmM5MmEwRkhEZkR1VmhSeGp4akVS?=
 =?utf-8?B?MC9oYktLcTJrV084VXpadUJyandUT1pHM2drajlOSFlkLy9PcXBQTUtLY3ZL?=
 =?utf-8?B?TStZdnRQUXhKUXdGQkhINWlMU01ESFpZUURmN2hndkFrZVhZdVBUZVNBKytt?=
 =?utf-8?B?NHBhMVFHWk5lUC9pNEVleFRjdkp6bUgzVVUrSXhRTDM2TDJ2Wmg0VTJwOE55?=
 =?utf-8?B?T2xOUzM3Mks3S2tpdFpmMlk2RGdST3ZSWWhUd1I5SVBocjJNVWJ5WGVuR3d4?=
 =?utf-8?B?MDV2VWIxd0hzMGV1QTdMNnoxdklQZjlIMVI1TnBJYVFNZ2UzR3pzRThOL2lG?=
 =?utf-8?B?cTRUbmp5V2RqNjg5clJ5a3phTXFzYnJ5c01Yazl2ZkdOZkZwSTR6c1NCYlFi?=
 =?utf-8?B?bm0vbUF3Q3A1cXNmeU1menVZYnVYYjNUWmFMaUxnWjdrZXl5bStBN2QwYXg3?=
 =?utf-8?Q?1y/X/QtD5An5XvtWmJRs7seekydchVjoXstbU8H37xt7e?=
x-ms-exchange-antispam-messagedata-1: p4lF36HF6Wpx7QRr0/lcIcQq0QzobYoKrXo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC0286F5A4E25A4186E22596E5CABBAF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MktTkPPtVVU6zCIVzhl1xt2rVFqcoSJLg6/pvKq/RTKQFfeCKnbdgvNijm13A3tikat1e1GlCERhRw+IWqHXTE25jHLvNxb0UHmjSr5V4ECiALFEjpS/iYnOBNM9TMT4/vj4ClJm3b8oPEneXQK+wnAsTXXexdoIQYwl3ZqmNdO28P/vJGoYJHYrce1cXzZsJ/OkAlHYwRILZNhZ58fuapCTV1MPg7UEz9e6XlKAMA6J4+vLv+Gv7BtFaVMWz39c+pjZqYJ4Vfr2Dv7iheG7c3PwYyKDPa/5FcYxCQCYOIcz7lqCCYau+9BQMYMVfqxOK8yCcq1XRuFg8N1GYXbF8Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O0uLyLbjzQDhvfpICWrQX3SCzsTha0quY8Cxn5xp51eui00dPmpQC9lb6AegH9IBIUCMPU6mtEidZDunjQ//vHN4qVaj1rbTyTwZRMwvaFYsuUecDvIG7TMvTyx9cC8IBYrM9QIBivkcNVSbb66GXVr1sEruUw2kjfffQeBewwCCfDhfYxjZ74POuOtTNm7sak9japeLShgcL7Hboz2SmYVbaGhABcSy2AvwC+5TgmIeWGIyS2fQaZgllRkn2GS+rv4FKezhwArUPdlyi57C5ilZPetslMLyt35Hkonei2WyXVdBQOvq0ij8YB6aOZEnWbvnF4NjiXiqK40sqnZeq239qjLI0iWwVoGEYrlSVnLPIlIS522ROklUTvewSXA2ALSv7E+wor0ZviMiJYNf6xGc5x1+dsaTyNurQgnHuNVtF4nG0R5+WcTIor/oPD3DmS0aoNn0OfltBD99iM3bh8Ajq8anp8vIIjVjktn8yT7N2QBz3qYyNVGFr7ixcweWl73W79hTGbV+xVR8H+ygm7H+n7Q6oegtdJfs6bh5OuQYMqorG3m0mrz56qctbfhmUu9pYLEdSDCNLwNFmzKMFW3Pv+hcs3rXNgh97e9Uh31IeIp21+nkELjPTfAM57Pe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03704654-763f-4565-0e1a-08df3fb10d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 05:02:57.6238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjGU1o8CNmDrxJEM7FrGR1kwrneZ9mRxn9XkegGJzRc7HgpYAPfdsYYD01mijbR0F3ldTkGCcCvBdakyREGVtoDKcdqAdR/AvNd+pm8G1/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB994610
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDEwOjQwICswODAwLCBXYW5nIFllY2hhbyB3cm90ZToNCj4g
QklUU19UT19VNjRTIHdhcyBhIHByaXZhdGUgbWFjcm8gaW4gbWlncmF0aW9uL3Ztc3RhdGUtdHlw
ZXMuYywNCj4gZGVmaW5pbmcgdGhlIG51bWJlciBvZiA2NC1iaXQgd29yZHMgdXNlZCBvbiB0aGUg
d2lyZSBmb3IgYml0bWFwcy4NCj4gTW92ZSBpdCB0byBpbmNsdWRlL3FlbXUvYml0b3BzLmggYWxv
bmdzaWRlIHRoZSBleGlzdGluZw0KPiBCSVRTX1RPX1UzMlMgc28gaXQgY2FuIGJlIHNoYXJlZCB3
aXRoIG90aGVyIGNvZGUuDQo+IA0KPiBXaGlsZSBtb3ZpbmcgaXQsIGV4cHJlc3MgdGhlIGRpdmlz
b3Igd2l0aCBzaXplb2YodWludDY0X3QpIGluc3RlYWQNCj4gb2YgdGhlIGhhcmRjb2RlZCA2NCwg
a2VlcGluZyBpdCBjb25zaXN0ZW50IHdpdGggQklUU19UT19VMzJTLiBUaGlzDQo+IGlzIHNlbWFu
dGljYWxseSBlcXVpdmFsZW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2FuZyBZZWNoYW8gPHdh
bmcueWVjaGFvMjU1QHp0ZS5jb20uY24+DQo+IFNpZ25lZC1vZmYtYnk6IFh1ZW1laSBMaXUgPGxp
dS54dWVtZWkxQHp0ZS5jb20uY24+DQo+IFJldmlld2VkLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFy
Ym96YQ0KPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXIN
Cg0KPiAtLS0NCj4gwqBpbmNsdWRlL3FlbXUvYml0b3BzLmjCoMKgwqDCoCB8IDEgKw0KPiDCoG1p
Z3JhdGlvbi92bXN0YXRlLXR5cGVzLmMgfCAzICstLQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
cWVtdS9iaXRvcHMuaCBiL2luY2x1ZGUvcWVtdS9iaXRvcHMuaA0KPiBpbmRleCBmNzM2M2E1NDc5
Li4zODM2NDhmZTU5IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3FlbXUvYml0b3BzLmgNCj4gKysr
IGIvaW5jbHVkZS9xZW11L2JpdG9wcy5oDQo+IEBAIC0yMCw2ICsyMCw3IEBADQo+IMKgI2RlZmlu
ZSBCSVRTX1BFUl9MT05HwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNpemVvZiAodW5zaWduZWQgbG9u
ZykgKg0KPiBCSVRTX1BFUl9CWVRFKQ0KPiDCoCNkZWZpbmUgQklUU19UT19MT05HUyhucinCoMKg
wqDCoMKgwqAgRElWX1JPVU5EX1VQKG5yLCBCSVRTX1BFUl9CWVRFICoNCj4gc2l6ZW9mKGxvbmcp
KQ0KPiDCoCNkZWZpbmUgQklUU19UT19VMzJTKG5yKcKgwqDCoMKgwqDCoMKgIERJVl9ST1VORF9V
UChuciwgQklUU19QRVJfQllURSAqDQo+IHNpemVvZih1aW50MzJfdCkpDQo+ICsjZGVmaW5lIEJJ
VFNfVE9fVTY0UyhucinCoMKgwqDCoMKgwqDCoCBESVZfUk9VTkRfVVAobnIsIEJJVFNfUEVSX0JZ
VEUgKg0KPiBzaXplb2YodWludDY0X3QpKQ0KPiDCoA0KPiDCoCNkZWZpbmUgQklUKG5yKcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUwgPDwgKG5yKSkNCj4gwqAjZGVmaW5lIEJJ
VF9VTEwobnIpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IChucikpDQo+IGRpZmYg
LS1naXQgYS9taWdyYXRpb24vdm1zdGF0ZS10eXBlcy5jIGIvbWlncmF0aW9uL3Ztc3RhdGUtdHlw
ZXMuYw0KPiBpbmRleCBjMmQ0NjQ1ZjMxLi44MDk0ZDc2ZjFiIDEwMDY0NA0KPiAtLS0gYS9taWdy
YXRpb24vdm1zdGF0ZS10eXBlcy5jDQo+ICsrKyBiL21pZ3JhdGlvbi92bXN0YXRlLXR5cGVzLmMN
Cj4gQEAgLTE2LDYgKzE2LDcgQEANCj4gwqAjaW5jbHVkZSAibWlncmF0aW9uLmgiDQo+IMKgI2lu
Y2x1ZGUgIm1pZ3JhdGlvbi92bXN0YXRlLmgiDQo+IMKgI2luY2x1ZGUgIm1pZ3JhdGlvbi9jbGll
bnQtb3B0aW9ucy5oIg0KPiArI2luY2x1ZGUgInFlbXUvYml0b3BzLmgiDQo+IMKgI2luY2x1ZGUg
InFlbXUvZXJyb3ItcmVwb3J0LmgiDQo+IMKgI2luY2x1ZGUgInFlbXUvcXVldWUuaCINCj4gwqAj
aW5jbHVkZSAidHJhY2UuaCINCj4gQEAgLTU5Niw4ICs1OTcsNiBAQCBjb25zdCBWTVN0YXRlSW5m
byB2bXN0YXRlX2luZm9fdG1wID0gew0KPiDCoCAqIGJpdCB3b3JkcyB3aXRoIHRoZSBiaXRzIGlu
IGJpZyBlbmRpYW4gb3JkZXIuIFRoZSBpbi1tZW1vcnkgZm9ybWF0DQo+IMKgICogaXMgYW4gYXJy
YXkgb2YgJ3Vuc2lnbmVkIGxvbmcnLCB3aGljaCBtYXkgYmUgZWl0aGVyIDMyIG9yIDY0DQo+IGJp
dHMuDQo+IMKgICovDQo+IC0vKiBUaGlzIGlzIHRoZSBudW1iZXIgb2YgNjQgYml0IHdvcmRzIHNl
bnQgb3ZlciB0aGUgd2lyZSAqLw0KPiAtI2RlZmluZSBCSVRTX1RPX1U2NFMobnIpIERJVl9ST1VO
RF9VUChuciwgNjQpDQo+IMKgc3RhdGljIGJvb2wgbG9hZF9iaXRtYXAoUUVNVUZpbGUgKmYsIHZv
aWQgKnB2LCBzaXplX3Qgc2l6ZSwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbnN0IFZNU3RhdGVGaWVsZCAqZmllbGQsIEVycm9yICoqZXJycCkN
Cj4gwqB7DQo=

