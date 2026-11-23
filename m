Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03253606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 05:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=T1t6VlYb;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=IK987PuK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVMYH-0007f2-Jb; Mon, 23 Nov 2026 00:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVMYC-0007bp-FT; Mon, 23 Nov 2026 00:25:12 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVMYA-0006jb-Gv; Mon, 23 Nov 2026 00:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795411510; x=1826947510;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=BR2Xca0pmqnd5KIwsts7kgrgnGIIRjXUGnXh1jFnGn4=;
 b=T1t6VlYbLbx8ZyhocFZFVxD+8akSCpgFD31eVsdLWk8FeAqgw7O7iRyk
 /L9UHQa7RMN2/DjiRfxZd8CTLugxyP2yg6zfeuaP9/IdZ5MuBAQ/5d9JP
 3v1Enywm0tyF7aJmrq6DuDZ1Yo3peqG96Pw4VXwSOu17NVdAe1vsU+VDd
 XgSRrAXAfUPBC/mYcDhmHHfFcND4akBVMlbtzHN/dc4EnKkEo9CgnUP9m
 /EV7+lfAs62oEY2p1Kef1iJGR+2bqznkbxggTwVUbpJCJAOtobVcVvJwi
 cyPaJPDAtGp/LYubbJmsQa4QwbGBkjuFI9JM1tHr2K++36ldh4XyZ0QSY g==;
X-CSE-ConnectionGUID: nJgfVbfZSKuH38vabajQmQ==
X-CSE-MsgGUID: rejgvh7yS/Gu3cW2UxWO6A==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="161461207"
Received: from mail-eastusazon11011045.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.45])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 13:25:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTP/9CWpjtuqLHzfWMcgZ+8M01tPcnaB7SxxwrpVhgkhwtIFYjgdkssPeCrcVWKb+RWPxVwlyJp4tM8+/43gmcpUfxc3XHSG+8UFJJP+zAz9gQEdM+JyjVZwDr9nr8ZAFneWxM/exAvn6uCirUgDnDiBtqdqT7Qy6QqrEKMYQ06+UnMsb6X8VKn+HjltAKakhwxOVPjOQ1g1mBHG//GfEl/4suHHnI878pW4CmQtLBa6Q9ulpglBeCVUF8isv37An/HfcgQ8KnLy4SgxCmaUgJDd1uPvWpdMCLmHUG/xJFAAEgQQWWoeFzNaJXAGOAJI/eO3yYLH8vOTRnl5QliVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR2Xca0pmqnd5KIwsts7kgrgnGIIRjXUGnXh1jFnGn4=;
 b=BUSKm8CJT2tNknzJx6Qa3xwNUfeGGuVECzJbKG9ZJfAO32BnYTg1Hk+NYN+5ka3J2S3ijMfrqd1clynS1lPgnM0+Hf633eVsTG5TQWhZca/JtozCnb4unGTjuyHaKvgrFydf72MyzQ8CbZ7pQO4ziTIz5VjOra4RXq6hwn5tddJ0y/JOYN9KJw91bc/InWmk9BcSN3CcJkHbMZNjQmnGokP0kXPnwy338/CCAPUOj8w8nc8sA4ydrmXpwQ1XWz7BTVy5yAJIIELXN20ZqtJDGlJc2xW2PEND3Zdz4ekx3UivrVHke9TtwC+j1DKlZ4x/TmMgipBwYawWaT/bbaVSYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR2Xca0pmqnd5KIwsts7kgrgnGIIRjXUGnXh1jFnGn4=;
 b=IK987PuKyTnN94YKFSKzm7vJKzWDJPKQiAWms9B6iVW9icjyT/AZvvNmR+RyxrQ4zorpYZrjjPgLaqvgsCZHkDbr2Pi8V31/kHc2CTbkAvk8oItRv5MrspfLC4yWtS44FTeB0QapJjXntOMzHr0+hOghNhVYj2x7h1GesDubF14=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB7026.namprd04.prod.outlook.com (2603:10b6:a03:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 05:25:04 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 05:25:04 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "bin.meng@processmission.com" <bin.meng@processmission.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "sebastian.huber@embedded-brains.de" <sebastian.huber@embedded-brains.de>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "conor@kernel.org"
 <conor@kernel.org>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v5 21/26] hw/riscv: pfsoc: Default Icicle Kit to five harts
Thread-Topic: [PATCH v5 21/26] hw/riscv: pfsoc: Default Icicle Kit to five
 harts
Thread-Index: AQHdbHMyYyczNndZJUa0o5Q7SKTSGrc7PRQA
Date: Mon, 23 Nov 2026 05:25:04 +0000
Message-ID: <a882c99b0f9b6b73c9a685f1f32725e4b6fcd413.camel@wdc.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
 <20261104154207.641511-22-bin.meng@processmission.com>
In-Reply-To: <20261104154207.641511-22-bin.meng@processmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB7026:EE_
x-ms-office365-filtering-correlation-id: 0ec08554-121b-4b58-d4c0-08df49222153
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|10070799003|261009223027099003|22082099003|18002099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261026121527099003|261026140227099003|261028144727099003|56012099006|4143699003|10067099003|38070700021|261102123227099003|11063799006;
x-microsoft-antispam-message-info: tDxGqrAxIAlU7kM0gPL8AgbsqQpzApWKeVi0Z/oPNCW4b3ALefYQFPg1yG0ZkLs8u3lIFwlhB1vOy+k3tDj3gaGudFfQ1GT8y1HbbU4AB8ZbG4tbeyfV9K5Kn+OYxhcDhc/xP7T7wCtcPlsW1nQf7cYb2vJcF1GqH1v4FwCUYSri+pMaG1fRm+aisX8NeSdLnUx7gB5CgdWoQTzmNyt0znjT0I98PJn1c8LqM8fW19DhuBXrk8UWZkv75k3zJmsXXmcQuIEQOANsaMiYty2vsKF760Dfmykw3o+cYBjBSFWGk2pbwWsqJNGlhFbUb6MC//e+Xe0WgR9t4ua6n+i9Cfyr8nBVEzBML9XJb1ew85mGzzXsRDjGQSMdGtl6R2M12mXgyEBraWCXbCugBTfXzy5+AOgg/vD6B+OcQV1PuWn/xemMP1TaaJpCtmuVNjPx9UV/hKf7+NFV1SMZR5d84rKjBBRjCBpfNAAC72gpKarfpdI8GCyqQeuApdjSS5AEsbaoZ7q9RGnI+F8gDAv4uxrGWQ8D9EnFYfMHJGFv2qQ2kRcC6QgnvZUS6vwGKTUZv8Km8w74sS2/7MKZDzD2afmEiPpVdTBgm80ljjeNyAoV46rHHoXThNywKW5nDWs5bLsub3eQbRgg6icMhEFjSc0BgD72uzl/pWle4VRgJvl1+9UM7hnZQS4lOCYg2osxP2toNrJ1+Ex0yjm4KiohhmIs6Xc8ZFU1xZDxlx5kCq4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(10070799003)(261009223027099003)(22082099003)(18002099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(38070700021)(261102123227099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVZYN1QxdkhKMEpKd0VMVHlpZ0NwZmJ3NWFyaUQxVHhBUlAvMEtwa0l4cHJE?=
 =?utf-8?B?cTBGNEFlbzRMNnVBbW84YUMyVk9jdlpHT0RWUE9RRGlDdGkrdE9ndDJuOVlO?=
 =?utf-8?B?MnQrWUJvSGhKbGVQb0ZCclNlcmZSa3dvdmhiT3N1eGIrbXpzNnFTNzdBdmpw?=
 =?utf-8?B?dVBKd2hNQ29maHorY1lReHgvYzFFcDV6WUFrdXhmbnpHR2tzeThoOUs3Q1po?=
 =?utf-8?B?eUJocjg1YmZJWmgySjY0ak8rZWYrS3FNV0NJc2t2aUlOdlpJcCtoajlseEp4?=
 =?utf-8?B?V3c2MjRnaEc5NVpiTU5kcmZ2Z2lTdDJwc3ZuQTFUcUl6c29PVzBKQ3RUNGta?=
 =?utf-8?B?Ni85ZWJCY1dZZ3hoOG1WUFBuNFhkVFYyZUFJWC9uL1pMdVYxeVl6cFZNdFEx?=
 =?utf-8?B?SmQ2eWtBOXpSVDlhK201S0hHWWlNUW5STkJvY0JleWpER3hiNk00R3lWb0Rs?=
 =?utf-8?B?ZXJtekxZTzBiNFR5TXBacHBFMGgrV2RzMTJtRldJOGlSNkdGUW5NcEtXejBH?=
 =?utf-8?B?d2lUWDk5NjhOaG8rd3JHZ09LcE9MM3YydXByNmQ4dzA4VldIT0preDBSR0RI?=
 =?utf-8?B?SGM2YnZicnRXUkx4RHVTWGFUdHErWUw2bW84YkFmak5FVkRUUUdxU1ZVSFZS?=
 =?utf-8?B?TENVYzJvT1BpbXlKUys5L1YxMmxlZGpiaFRaY09PWnAvOFdhUDRCUFFtM1B5?=
 =?utf-8?B?czZnRHpnNHRGbzJwZ2J4dE5PRk95QzhXVE1KWWczRGpJMEJPWVhBK244ZTJn?=
 =?utf-8?B?ZjVoVjhmTE1zR0dkWnhvWFFBZktlQndjVExRYzJtSlFnaXBuRmluT1BMd1Bw?=
 =?utf-8?B?NExDWUtHbGtMS1A2UGhvZklEUDgwVE9qNHRKd05zL2I3b1FvSkx2NW1uSzZN?=
 =?utf-8?B?MFlqWWZmTVFkNUpIZlpBd0MydEEzMjBCQmJRbzhZdUtPZm5TeUk2R0wzclpM?=
 =?utf-8?B?S0tkVk1OSjdZR1pBRDRVelVIbU5lSCtVQTd2Q2tEN25YK1d6dFR2Qy9hL2NH?=
 =?utf-8?B?N1JYNVJSdnRidHJjRy9pdjdSdmdBb0dtU2pvdTZTYkJyck55SjRFVmVlbnVQ?=
 =?utf-8?B?TUN6Yk1XL01lbzhsdUJlYmNzWENSTlg5a05TSW1FN0ExelV4cmFLQ3Nxdno0?=
 =?utf-8?B?OURIdUhreEcyaGRhbTRoQnY1ZWlOMFYrN0hNbXNVS0lHSVUrSWRCSXJmR2xy?=
 =?utf-8?B?Mnl4bXBiaG9kdEVza0RvRTdrZlg2amJXSy9Pdi9McUtreWd5UVJFNmE5TkRa?=
 =?utf-8?B?K0hIcWREUGh4OXV3MFpZajk2aU53RmlTWmt0bklhdE1YSXJKcWNaZm1Zb2t0?=
 =?utf-8?B?WW5CMmRJcGxkVnJkbzQ2T0w4N0xhcXRuTlp2ZXh5MVZPSHNpMEhFQVNMdmJo?=
 =?utf-8?B?elkwVWRpbG5kQ0gzQmJNaDZ6MjRPZmF6UlptdGUrOHNFaWsvc1BpeXZzVHJX?=
 =?utf-8?B?MHc4cHRCVE5ML3M0c0NtQmZuRjhrQmp4bk1sbHdMRWpFQTM4NkU4NEdmWGZK?=
 =?utf-8?B?bTJEcG9Tb1JFYUNjRHVzZnVUYVV0TjY5c2tBR1BrNzBnT2ZqYmlWdEVxclA3?=
 =?utf-8?B?akVJK095bThBaVJ6SjZIanArWnlMUUI1aWN0WFFwcWwwbXorck9UcTFaS0NL?=
 =?utf-8?B?bEk4dERvWURpVVFMaStyNGdSQXRFQ1l5RHBoUDBZTGpRaVFGSEVXeUNFVTJ4?=
 =?utf-8?B?L2VkWE9xbnN6L29iTUJTUXVsN2RZV3lpUUdPYzVQUnZacE42cGVuZEhmMUpw?=
 =?utf-8?B?QXY5T1dsNzMxRlZML2pkMUZIdDdTWmZWaFprZGRsMWtKREgrS1dRK3VrTC96?=
 =?utf-8?B?ZTZvOFk2SjhyNnBZNWpBU0VrMmowdzhXWXlCdnBMTm9xc0NabFhFVkJVTDlz?=
 =?utf-8?B?WTFnVGMrZnpSNG4xVzZxM3daMnUyVFN3dXR5T3NOd2pjaG5jNzBlYkxkbWVj?=
 =?utf-8?B?dGxEeEU2emlEQVJuekNIR2VWNVUzMGxNWGVTNmw0ZXdjSWdrKzE1M241Z2Zs?=
 =?utf-8?B?Z3Z1TUpmUk9QbXVpTExpU3dYaGJBaWJGMEc3QmJYZ250b3RMaXBLellIaytE?=
 =?utf-8?B?VTQrOER0QlRHa0hjUURvYUhQM2taOUtnS1ZQK0NjMm1iZ0hwK2lrdXhBa2hu?=
 =?utf-8?B?R0NZVFYvOFI4Ly9rR3NNT3VTMnFMaFBvMlBvN3ltL1VCcXFORlNuYWs2d2lm?=
 =?utf-8?B?LzNaS2dULzVtMTQyTmlyY3NaaWE5VGpEYVRzRnFTUitTOUk5M0R2Rmhmd0FF?=
 =?utf-8?B?N3JYcWZkZWd2MjlqV2htVUtIVTlKbmlGd3VOOHRSZU4wcmlWdVMvODVmNDJB?=
 =?utf-8?B?eld2VVZXMnJJQU5tQjd0WjM4RWhwZjRDME9jb0Z1cE84dW9ubEtzZjFpYjli?=
 =?utf-8?Q?PMLkrKsuHMNv19sizVi9sdPu1zRwqHTKbGDP52QV/LFgM?=
x-ms-exchange-antispam-messagedata-1: atwIIeC+qnqBNQ+5m/7WTWbNMI94CVLy584=
Content-Type: text/plain; charset="utf-8"
Content-ID: <714F7426DA77A948A648D883BCFF34CD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mHfkv+fRcapDOpIte2R6Tl41mOQi9nPJJqOhEMv6MTD6evthRdEvE8trjzMbJg90PxWdSCwPhcnn6B6UusiOGH4CQyzkMlC0sQ9CzHTruIz/doiCj9x4+LsZSalNBx3ifWjTmZuy/bPPetUClqh4nWDZnsNLnhviM2NHyytlQ28tcI0vq7/LI0ZPxPQc0J/JsEuwDg0uP4rYohgKZn+X+1KSl6jRxuLO4txPNyGELwdhaT8TlsXabszsi+49pwb30cruml/15HURpTYtI7xQe2ahbyWyYXPEwzSLGhI0BTWkSwZGZ+Jcs7ZmCSeA5mpHKvRt10vWXueEBbYcBy94Lg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YJ5eHYaDbJjwmfIFlvvFEcXm2rlfFzHATl/l+bvFVpNX8CD70G3c+ImdO99d6gOUgV26H78at729fngjxjrRPZ0JiA2EurQfoWJqq+q20/etk9AJ/W7RSMHVKT8wGEHTHNYrhwdo+fCGow3SYGdEF1JLgliGLtFebcqhIAALUQJcVAOE2AtOGUKGC7Yc8momQHCF58WcEWu2P4FFiHMXJFmniFT3kcHAyABKobvQ2b57om0ERInwDpuCQUm412WWOs1osdCHq7n1PwEgyQ/h4NmdL+N8qkRYdSNb7H3nVB0FVbZPh5XeRGLxhjKuzxUvd5Wc+MeLE6l8kvps2Ck8VDhvK9EM9WJq81VYkand6v0vJYBb5ZKjV5pUeeBX17WxZ+cCkaUCed6AIDzrQZC78pGoRVDK3ULCR/ucZvFxu8D5asXQp3aol+A4Y0er/YpcB3i009AVW2/F1CYqZxm+CSrDq0pICCduiXVH6J/p7QDW30PPHOm0zzwsIqwIZsyBkfjnEugrqmVbkmtDadEgNFVR4qJbRsUZkD63aic92EU49JA/TnKj1QY4RgtIT4dZ73rwtSvgvqAOa7TJVtLOcdLlRzplIto/mM7Md4hvEHuM2od+LmxYNDLnYQpRRTFI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec08554-121b-4b58-d4c0-08df49222153
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 05:25:04.6209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8B2QaaRMrmpJktRBk/t7U6B0iJTew3HsarVRbJxZYa00g/ifF4RZFbAuDj8hTRqIfwKpUxOpf7ZsRlyfIEo/kCDOjSOv7pt1LBskXQ5KSto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7026
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTExLTA0IGF0IDIzOjQxICswODAwLCBCaW4gTWVuZyB3cm90ZToNCj4gVGhl
IEljaWNsZSBLaXQgY29udGFpbnMgb25lIEU1MSBtYW5hZ2VtZW50IGhhcnQgYW5kIGZvdXIgVTU0
DQo+IGFwcGxpY2F0aW9uDQo+IGhhcnRzLiBEZWZhdWx0aW5nIHRvIHR3byBoYXJ0cyBjYW4gYWNj
aWRlbnRhbGx5IGJvb3QgZmlybXdhcmUgYW5kIGENCj4gZGV2aWNlIHRyZWUgdGhhdCBleHBlY3Qg
dGhlIGZ1bGwgZml2ZS1oYXJ0IHRvcG9sb2d5Lg0KPiANCj4gRGVmYXVsdCB0byBhbGwgZml2ZSBo
YXJ0cywgd2hpbGUgcmV0YWluaW5nIHRoZSBleGlzdGluZyB0d28tdG8tZml2ZQ0KPiByYW5nZSBm
b3IgdXNlcnMgaW50ZW50aW9uYWxseSBjb25maWd1cmluZyBmZXdlciBhcHBsaWNhdGlvbiBoYXJ0
cy4NCj4gRG9jdW1lbnQgdGhhdCBmaXJtd2FyZSBhbmQgZGV2aWNlIHRyZWVzIG11c3QgbWF0Y2gg
dGhlIHNlbGVjdGVkDQo+IGNvdW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmluIE1lbmcgPGJp
bi5tZW5nQHByb2Nlc3NtaXNzaW9uLmNvbT4NCj4gVGVzdGVkLWJ5OiBDb25vciBEb29sZXkgPGNv
bm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIEhlbnJpcXVl
IEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQoNCkFja2VkLWJ5
OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWly
DQoNCj4gDQo+IC0tLQ0KPiANCj4gKG5vIGNoYW5nZXMgc2luY2UgdjMpDQo+IA0KPiBDaGFuZ2Vz
IGluIHYzOg0KPiAtIENoYW5nZSBvbmx5IHRoZSBkZWZhdWx0IGhhcnQgY291bnQgYW5kIHJldGFp
biB0aGUgbWluaW11bSBvZiB0d28NCj4gLSBEb2N1bWVudCByZWR1Y2VkIHRvcG9sb2dpZXMgYW5k
IG1hdGNoaW5nIGZpcm13YXJlIHJlcXVpcmVtZW50cw0KPiANCj4gwqBkb2NzL3N5c3RlbS9yaXNj
di9taWNyb2NoaXAtaWNpY2xlLWtpdC5yc3QgfCAzICsrKw0KPiDCoGh3L3Jpc2N2L21pY3JvY2hp
cF9wZnNvYy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICstDQo+IMKgMiBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kb2NzL3N5c3RlbS9yaXNjdi9taWNyb2NoaXAtaWNpY2xlLWtpdC5yc3QNCj4gYi9k
b2NzL3N5c3RlbS9yaXNjdi9taWNyb2NoaXAtaWNpY2xlLWtpdC5yc3QNCj4gaW5kZXggYjBhZDI0
ZjE3NC4uMTM4Mjg5YTkxMyAxMDA2NDQNCj4gLS0tIGEvZG9jcy9zeXN0ZW0vcmlzY3YvbWljcm9j
aGlwLWljaWNsZS1raXQucnN0DQo+ICsrKyBiL2RvY3Mvc3lzdGVtL3Jpc2N2L21pY3JvY2hpcC1p
Y2ljbGUta2l0LnJzdA0KPiBAQCAtMjcsNiArMjcsOSBAQCBUaGUgYGBtaWNyb2NoaXAtaWNpY2xl
LWtpdGBgIG1hY2hpbmUgc3VwcG9ydHMgdGhlDQo+IGZvbGxvd2luZyBkZXZpY2VzOg0KPiDCoCog
MSBTREhDIHN0b3JhZ2UgY29udHJvbGxlcg0KPiDCoA0KPiDCoFRoZSBtYWNoaW5lIGhhcyBhIGZp
eGVkIDIgR2lCIG9mIFJBTS4gT3RoZXIgbWVtb3J5IHNpemVzIGFyZQ0KPiByZWplY3RlZC4NCj4g
K1RoZSBtYWNoaW5lIGRlZmF1bHRzIHRvIGFsbCBmaXZlIGhhcnRzLiBgYC1zbXBgYCBtYXkgc2Vs
ZWN0IHR3byB0bw0KPiBmaXZlIGhhcnRzLA0KPiArd2l0aCBvbmUgRTUxIGFuZCBvbmUgdG8gZm91
ciBVNTQgY29yZXMuIFRoZSBmaXJtd2FyZSBhbmQgZGV2aWNlIHRyZWUNCj4gbXVzdCBtYXRjaA0K
PiArdGhlIHNlbGVjdGVkIHRvcG9sb2d5OyB0aGUgSFNTIGJvb3QgZmxvdyBiZWxvdyB1c2VzIGFs
bCBmaXZlIGhhcnRzLg0KPiDCoA0KPiDCoEJvb3Qgb3B0aW9ucw0KPiDCoC0tLS0tLS0tLS0tLQ0K
PiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvbWljcm9jaGlwX3Bmc29jLmMgYi9ody9yaXNjdi9taWNy
b2NoaXBfcGZzb2MuYw0KPiBpbmRleCBmMmE4MzhiZTEzLi45MDM0NWFhMjYyIDEwMDY0NA0KPiAt
LS0gYS9ody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuYw0KPiArKysgYi9ody9yaXNjdi9taWNyb2No
aXBfcGZzb2MuYw0KPiBAQCAtNzUzLDcgKzc1Myw3IEBAIHN0YXRpYyB2b2lkDQo+IG1pY3JvY2hp
cF9pY2ljbGVfa2l0X21hY2hpbmVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsDQo+IMKgwqDC
oMKgIG1jLT5tYXhfY3B1cyA9IE1JQ1JPQ0hJUF9QRlNPQ19NQU5BR0VNRU5UX0NQVV9DT1VOVCAr
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1JQ1JPQ0hJUF9QRlNP
Q19DT01QVVRFX0NQVV9DT1VOVDsNCj4gwqDCoMKgwqAgbWMtPm1pbl9jcHVzID0gTUlDUk9DSElQ
X1BGU09DX01BTkFHRU1FTlRfQ1BVX0NPVU5UICsgMTsNCj4gLcKgwqDCoCBtYy0+ZGVmYXVsdF9j
cHVzID0gbWMtPm1pbl9jcHVzOw0KPiArwqDCoMKgIG1jLT5kZWZhdWx0X2NwdXMgPSBtYy0+bWF4
X2NwdXM7DQo+IMKgwqDCoMKgIG1jLT5kZWZhdWx0X3JhbV9pZCA9ICJtaWNyb2NoaXAuaWNpY2xl
LmtpdC5yYW0iOw0KPiDCoMKgwqDCoCBtYy0+YXV0b19jcmVhdGVfc2RjYXJkID0gdHJ1ZTsNCj4g
wqANCg==

