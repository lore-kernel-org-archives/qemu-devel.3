Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3D6606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 00:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Xf4whXI/;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=zw6rnoFb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLVK7-0005uZ-Oz; Mon, 26 Oct 2026 20:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=75324c598=Alistair.Francis@wdc.com>)
 id 1xLVK4-0005uC-HY; Mon, 26 Oct 2026 20:45:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=75324c598=Alistair.Francis@wdc.com>)
 id 1xLVK2-0007mn-7z; Mon, 26 Oct 2026 20:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793061957; x=1824597957;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KP1AEuITznID4DIRooaMem2npQImPR/njJ6A6VG7SaE=;
 b=Xf4whXI/e+/LgYL/7xy3MO6Ly5Ww4YGB5Q2IuTaYtblX1CRcISOmAFRu
 JBQ6t9YtdIl+BZF+/zOo+bdVG3fxzeZ4qOvmYCEWWihcX5eX+4342bzL1
 xF/79lNikGBG+IVMrcO4fI2yRnLRN0R8k1JQfdm/4Qt6J97eIieN9bvux
 bRFDQ7/tsn/HRgU198vxSGnK5oNRYJrmq3JPKsVdwE1tsRXva8ijILbZZ
 V9piONgp+duMrydM6mgrvMuhjqKMLG0uXn5CcWp8ZjT8R7fTOL1Icnw1P
 vLtcm5OmTY082I3kmAfqZZQ8EK9mrf8wgFh3/xqbEsNbXWWNbbk4Efo0R A==;
X-CSE-ConnectionGUID: KiANX8NrSmS53mjDadWs+w==
X-CSE-MsgGUID: yb8UO6WLRDmTrzhgXteh5Q==
X-IronPort-AV: E=Sophos;i="6.27,180,1786982400"; d="scan'208";a="159064244"
Received: from mail-westus3azon11012006.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.6])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Oct 2026 08:45:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUZ6l3dMppBsdYHJSFHOOt/9lH1zx6hmEPradUKEgQSVN4QfbKcqZIvg+4IsH65+sXIJXQmD3Psnic78KKMmJQopovbc5wRO7vRlKWUqXwAjY38R3qo6gi6A//7zPZ/HzBxgWAYlFaCnEUrnaNNH8+jH5Z5S+Sgk25NQg+fSdBTlV1DXyw0+hH0N/K1sYFmIKTMwMZyxtPiYxtnWDJHvqA3+x/iP17rMXIWurYF4bYZnBoO6FQV3cKqr14xPDfbhsYYa7nJJdpMSZGnQ1eY8hbVxdrLBzWMJLFKJxo/IBdRzF2qkYrokrP7XlPUYbXkmAKPfp6GNGY2apodjmxpy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP1AEuITznID4DIRooaMem2npQImPR/njJ6A6VG7SaE=;
 b=bhlUC2x5/oWO0yq2vGPZihlc7iYbLnYsMFvRm9ytpQy8afYM4jb0mFbw49GWbZZFKSWsuwrYTlvhUif3zMheJoKoZ4BEg3Yf9wPlq71WJFjcwtVqESw2WiyrIskfXwoUFU9mow8qu3IbDMjInH+XjQGcTuPu2xypCmOgNmcAo+Q0aGYrK7CBBHDxQXOvoa5SSYGABaqYV4FpvNTi1Zu7JMDXTryQi9cJ2SAakn/a7JJSCBjRkDZtl/zJn4nm6zEV6qXs0sZ5xVlQ6agEbloRDrP9+nC3y5ayuN+HvOQhZxGw5cSp5VayPExhTN+cUkLNWZRhEJNm4VNIfZ4PSRWirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP1AEuITznID4DIRooaMem2npQImPR/njJ6A6VG7SaE=;
 b=zw6rnoFbzF1kgcdPNx2WDIacSPW/5hbPy53x22T9NXlv3P4bza01YjBsC1IifrKjnv7mpZ04LdE3B1k52j0ltKn1oBGQqvOxbdPKyms0SE9kkfmPNLgcHZZJTfiv9PFti+d+ORlFJ3z1ZBNAO2dANEEGE/01rFPFGPXPO9MfLdQ=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB6788.namprd04.prod.outlook.com (2603:10b6:a03:219::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Tue, 27 Oct
 2026 00:45:45 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 00:45:44 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "palmer@dabbelt.com" <palmer@dabbelt.com>, "wang.yechao255@zte.com.cn"
 <wang.yechao255@zte.com.cn>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: Remove unused MMU_USER_IDX macro
Thread-Topic: [PATCH v2] target/riscv: Remove unused MMU_USER_IDX macro
Thread-Index: AQHdZPgCL2dCZtEmR0+ZRKog0GBNTLcQjwwA
Date: Tue, 27 Oct 2026 00:45:44 +0000
Message-ID: <57ea9e7e3e7c826110e6a1c6b27d80561c1a532f.camel@wdc.com>
References: <20261026031144.631964-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20261026031144.631964-1-wang.yechao255@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB6788:EE_
x-ms-office365-filtering-correlation-id: 09b8836e-caf4-4553-d969-08df33c3a238
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|10070799003|1800799024|23010399003|38070700021|261026140227099003|56012099006|11063799006|261009223027099003|10067099003|261021123027099003|22082099003|18002099003|261022105027099003;
x-microsoft-antispam-message-info: 6/0ZzgPLM5Rx635NiXxFohwrJ28ox5RsakFf4YO+p0Iu5/6SoP5i3UiwDLKRQrwFuksmcwccbZTzMud61bht9bj+A9sRRjXDjFL9U/DRuZOu4BvG01xmBkZahT3wvei/JXWeozK1EZj4HV7/pa/Y6OKL7dZTY+Y1AssSUvKrExlrr29f4uTue4W/MXMq45wVST7pKTzPbp8HkcoIHMiQDPXbEYcgVjBoxry833jV4MMcyorwuNDBxUv8RFyRFyr7R8PmrBNxcxy2n8G76Fds9bsGvZKoGsUCwRVVOBajtsGvdYEM+2j3kuOoIToL2aGyxh82/DTQZTAKcIIioFphUJwzHyBjsuUaABqqMwoyjvDkCnyz5FXjw8/OLQZhAL6p+BoK8jjrv7phJt8SBwlAIi0mlJLi9qDYk+1/BytFI5eDHA2TI7gNy4j33zcl3JfWPuRrU0IUFDk3qHn4dkFBbMUYBYloqjsjoqlpelzyftnOaHFv87eqAzFEAeJHFtwn17beLHvfbZNlDyO3UPCZK0CYtdECFi7A6aS+yX+f0mMfCpDpENEMoHTWs4A+DuZJLgxXaOCcSk6ZGZqgEFkYVyv9jfHIensJPvLok7Zte/H5qSnJlFYKau+U3FffMzC7WBGZi7TmOzSNWREYccWEP6z0WeR8lmg9UVm9kkuYSwU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(10070799003)(1800799024)(23010399003)(38070700021)(261026140227099003)(56012099006)(11063799006)(261009223027099003)(10067099003)(261021123027099003)(22082099003)(18002099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlBsTTFQcWlrNDNsdFlzemQ1U1JCYytXb0dpRFpEUmhBazFQQmxhc2pHdXpr?=
 =?utf-8?B?QTMvYlpLSldKMGZZc3pBK2NrUWcyclZWYTVFNzlwWlg2Y1lxRmhRajl1OTBJ?=
 =?utf-8?B?MjlmMFhvMUQvTDBOOGtuUU9LaTNZYVVoL3FZRkJrYTR3L0RSdE4vN0VEL0p5?=
 =?utf-8?B?a3FlellTWnVvV2pZK2ZZNGgwRlRhY1lKNVNDUThIL2tKMXZONmZSa0hBV1Zi?=
 =?utf-8?B?OTZ3M1cxU2dMamI2SmsyWHp6bERXRXJYdjJESDQxQ25OQ3kxRHZmS09YYUZr?=
 =?utf-8?B?Y2JxTjZENCtJSml0NmFKRkQ2UWJjSC9XSDk3R1NOSzVKYzZrS1BONU1Kak9Q?=
 =?utf-8?B?NHlYa1p6alRYdjQ2VkRFTXdJOHcvRjVyQytMUHZacjhxS2Z1cVZDWHBTVkZ0?=
 =?utf-8?B?MmVKR0Y0aGg2eFdLNERRTWFTNFp6WE1qLzhPekpKREJIamZrTzliTi9MN3Rr?=
 =?utf-8?B?YTIzdHdtbzhZWWdheStMN0NFeXh5QkgxdFAxaU1rK0RhR0ZaT3RHYzRXbEFY?=
 =?utf-8?B?V1lNQjhpTGNrTnNDUWN5MDdWVnl4ZllUaWxxT3ZRNVErOWdPSjFZdEFmaDJJ?=
 =?utf-8?B?TlJTa09ONDYwbGdqVU1kaXE3QjVxZ3NMVzNqZ2Jjbnc3ZDFqYzZBay9Dd3Bi?=
 =?utf-8?B?ZmZBaGdFeTRlNW9JVldSNm14UVlVaWpTTXF5eU1nYWVFZEZrbGZETm9Zbkcx?=
 =?utf-8?B?R2YvVnNRaHNCQ2Y4QVcvY05sTDVBZE5aZmNlWVh4Q0FVZDRYdXUyYkh2dUVJ?=
 =?utf-8?B?em9MSHMzbng1aWRMYnpwNDFBdXJjR3ppR2xkK3JEekxZT2p2bk1HVUIyelhv?=
 =?utf-8?B?Z2l4T3pXY25ocUdBeUY5Q21SZFVMU3pDRzNxVERobHliU1hvUHpRN1l0aEZ6?=
 =?utf-8?B?aVl0amJEWWU3R3NBMk12OHpZYS9hZDlCRFdkOVV4YmE1WnBjcmNFTmZtNGlr?=
 =?utf-8?B?REZqWTZFN3FJRjZ4c1VuZU5aY3hhVEt1WlVzaFdwRlhQSVdYR2ErYjdmakM5?=
 =?utf-8?B?ZG1MaHJ6cGp1QU1vZUtsY1g2ZTRuSTVqMlIvQUlIT0xOZ0VYSG5BYnYvQlh1?=
 =?utf-8?B?Z25ITURXODlrRDFzUlJVWVlLeDRja2NBYm9Va0lqMk4rRVdIRDdLZUFQNloy?=
 =?utf-8?B?TU9RajRiR0k2ZmwrMHcva1hSTlFsMTQ1RW5vRmlZb1h0SEg4cm5JbTQ2c0Zw?=
 =?utf-8?B?Q3NrQlVSV01IcFFkRzNQRHpmNzg4dU5IMHFmZ3lRSGR3aFVBNmtMNnNWeGE4?=
 =?utf-8?B?Vkh0YmRpc3RlSFNWWEJZanpZbElTYUU2ZEU1TnBVeHZmTTJ6NjJuVEc4NHA4?=
 =?utf-8?B?QmV4L2xFNGd3VXFlRnVuamFDdHQwVDNCNlVJL0t1eW5paW8weUNzSDQ5blFO?=
 =?utf-8?B?eHNrNmwzMVJ3SGorc2tjSnZneU94U0JXSzRxTTM0S2pXeG9vVVhFVjBvQTlT?=
 =?utf-8?B?YW5lMHVJNlFKeHFVR05lMyt5czNhOU9seFRhV2gxWmQwV05kMFdjUTJxbzN5?=
 =?utf-8?B?bkwxUWRmamRzT3RmT1hoZTgxaTE4eDUxL3M2WjhGZEV2ZVp5aDRJcENDUUV0?=
 =?utf-8?B?RXk3dndrTVkrbXZRVFNYZnpiMWpMdzhqL0VGSW5tQkVGVklVRmhuL2hzN0k4?=
 =?utf-8?B?dEdMZGhId2dTUFVuMWVqTzc0YUFxL3JTUVpydURXUUsvZE11N1NKZ1pQNHJo?=
 =?utf-8?B?YUJpVVEra2cwQlFqN1lHZnlKUmFzT3h6TUhUUitLNXAreHUvQklISXd3UWxk?=
 =?utf-8?B?d3RxM01PbGZnZ1dNTkE4Q0Q0NGFkUnFoN3NaZWV2Z2s2MnFsZGpGN3k0eDJj?=
 =?utf-8?B?YUpGVXBLZHJ3azFUMlc5VFZFd1dMZ0RDT1lvM1VSQjNPUTBGQVZqeDJOcEVj?=
 =?utf-8?B?UjNpVDM3S3BSTEhxai9hODIvRVFoTVpWN0RiNlJJTWIxTUtSa01mM0FERFor?=
 =?utf-8?B?RWZVZjUrVFV5dDVJL3J4bE44Qk5FcVRKNDVEK09BU0ZzMWg1aE0xMkpOOXVW?=
 =?utf-8?B?R1YyQzdvdVgxRVZLbUhkaGZkQ2lmdjJ4WXlPVGZNa0JCSnluQlRaZFJSTGEy?=
 =?utf-8?B?aFFDRUlZSzJkcjF6WkQyZHQxaytFQVhjdVdDZTByNmtvKzZieXR6MVBPWEV6?=
 =?utf-8?B?VnpoTnJQY0JaVU5Qd3VYdkdNeW15NU1haGh2Y3BYNzRXcTZTdXNEcHowdVNL?=
 =?utf-8?B?eU8rckV2TWNFMWwrR3dtVURaaHN2TWRKUGVwZ0JsU243OWJCcCtUUUhGd2M5?=
 =?utf-8?B?b0RPKzZ6Um90blIvWVNKNjRpQjdiWHpiU0dnZnhhWVByOU1RTytTTHVJZXI0?=
 =?utf-8?B?c3BmRnVQSmZyQ2RSYlpmbWRmMGtnbktjZ3J1Q3hOZDBCMmlzMjlxeE9DTktJ?=
 =?utf-8?Q?ZRYsxtf4hJ8ioziK4tRzck38ooIcUApOYqrBhkoUhLOgC?=
x-ms-exchange-antispam-messagedata-1: oZxiyjpJfzbhLcF4a+njhCxVoXNmqcu6CDQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23D39FDE6769B247B8A14715175BBC4B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: feZNbMFq7yUYafCuWvEK0taQJor6UhkldVAp2/vB3DoqcHFLYvhLPasTT67dQNVwozlhVBHq0g+X0dUiz7RdzdDZUn9OBCGkJblb0IJJIgG6Q2a4lKVvhIUt7ykyxjiaF9dkz0rOrtiiH9edg+hp7Ov2aP7jbBK+3TDSDN6YbtBu0Yvq31EJF0YagU/2ll8ON2wn01OlLkH2rUKSVuBdW+AW/VeGQlAoSnxswGFqcIKilaNVhTksFaUedZiD2NjVj6SDFerDqsCzBXzRjolcqflTeK6DNYuIFkE3BDVAdvodmFfJd9B+at5/4N3wMAasVxjY6nLD2jjEfIz7VBWtdw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RZGWN+yhz2aCgSs2SuUmI9Sy72AEerxEMol1WQf4VHKeoH8kK3D5byHOvejsFAImK8Fc+ziPPacua/URxBoNC8lxjBDvvgmu4zVN05cDl+4ry8RxCHVOpN62dpzCiLwnc++5h4FM7STaTHRHfIhwT+X7feHnNWaPEvMQMN4v9L3HxIqpl6vy/GsovA4qNjcoUbpKFPoMGD9Af3wZt19HnGJtAZNFHdHBlNGFhGT0pDpSFLY3VGy/YCl4aMNWLr0NjwaTm6jUlw/M9le70PlVASrDtoQlYfKB7smO+TsIJFSCIZHYOyto4729bwBCG/onsAdEnMAIDBNm2AYwNR1DhTi3ya+SbutvZfdqx7gJxI8fRIFUaiijgfsR858QVYG+bgoSHofd8Ser2opWm46VFCX1PTJ9Q+jC1657jP4orJEukfB7H+pqRGO+HgeSFTyN3NMZtqvKahWK0vf6zQZ6xyg+S79C8q0sY0fXRKaNM1a60fUPic6NHpjOUN2CdUjhl+cDflrj/GLLrWo6wLeRsk5ow3Fs4MZyFEwR1ylFC8bClAni2bMeKvzhbjV1wzE/YSdmJcsbwzpi4YuwJsjFeNPPxb78CZ8k8oN9KOA5HYOHdPWWsskGQBA5j4L5TRNy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b8836e-caf4-4553-d969-08df33c3a238
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 00:45:44.2739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxPc3SmkgDLxv2ix6ybHTck6mZklM4jxdKosh3r5/7aYs/K85AN0j4+1RLpeGqWKttx/2JDAOYdwRfWgUtnFjDCNXSOTbtS915tax22xIZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6788
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=75324c598=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjExICswODAwLCBXYW5nIFllY2hhbyB3cm90ZToNCj4g
TU1VX1VTRVJfSURYIGlzIG5vdCB1c2VkIGFueXdoZXJlIGluIHRoZSB0cmVlLiBJdHMgdmFsdWUg
aXMgYWxzbw0KPiBpbmNvcnJlY3Q6IGl0IGlzIGRlZmluZWQgYXMgMywgd2hpbGUgdGhlIHVzZXIt
bW9kZSBNTVUgaW5kZXggaXMNCj4gTU1VSWR4X1UoMCksIGFzIGRlZmluZWQgaW4gdGFyZ2V0L3Jp
c2N2L2ludGVybmFscy5oLg0KPiANCj4gU2luY2UgdGhlIG1hY3JvIGlzIGJvdGggdW51c2VkIGFu
ZCB3cm9uZywgcmVtb3ZlIGl0IHJhdGhlciB0aGFuDQo+IGZpeCBpdHMgdmFsdWUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiB5ZWNoYW8tdyA8d2FuZy55ZWNoYW8yNTVAenRlLmNvbS5jbj4NCj4gUmV2
aWV3ZWQtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3Mu
cXVhbGNvbW0uY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBBZGp1c3QgdGhlIHBh
dGNoIGRlc2NyaXB0aW9ucyBhbmQgcmViYXNlZCBvbiByaXNjdi10by1hcHBseS5uZXh0Lg0KPiAt
IExpbmsgdG8gdjE6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjAx
MDcxNjEzMzYxMDhSYnZnSUVKMXB3d19mS1p0TXJlRnBAenRlLmNvbS5jbi8NCj4gDQo+IMKgdGFy
Z2V0L3Jpc2N2L2NwdS5oIHwgMiAtLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuaCBiL3RhcmdldC9yaXNjdi9j
cHUuaA0KPiBpbmRleCBiNjVkNjMxOTk0Li5kZjc0NzdmYzVmIDEwMDY0NA0KPiAtLS0gYS90YXJn
ZXQvcmlzY3YvY3B1LmgNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+IEBAIC0xODAsOCAr
MTgwLDYgQEAgZXh0ZXJuIFJJU0NWQ1BVSW1wbGllZEV4dHNSdWxlDQo+ICpyaXNjdl9tdWx0aV9l
eHRfaW1wbGllZF9ydWxlc1tdOw0KPiDCoA0KPiDCoCNkZWZpbmUgUklTQ1ZfSU1QTElFRF9FWFRT
X1JVTEVfRU5EIC0xDQo+IMKgDQo+IC0jZGVmaW5lIE1NVV9VU0VSX0lEWCAzDQo+IC0NCg0KRmFp
bHMgdG8gYnVpbGQ6DQoNCkluIGZpbGUgaW5jbHVkZWQgZnJvbQ0KL3Zhci9tbnQvc2NyYXRjaC9h
bGlzdGFpci9zb2Z0d2FyZS9xZW11L2luY2x1ZGUvYWNjZWwvdGNnL2NwdS0NCmxkc3QuaDo3MCwN
CiAgICAgICAgICAgICAgICAgZnJvbSAuLi9saW51eC11c2VyL3FlbXUuaDo1LA0KICAgICAgICAg
ICAgICAgICBmcm9tIC4uL2xpbnV4LXVzZXIvcmlzY3YvY3B1X2xvb3AuYzoyMjoNCi92YXIvbW50
L3NjcmF0Y2gvYWxpc3RhaXIvc29mdHdhcmUvcWVtdS9pbmNsdWRlL2FjY2VsL3RjZy9jcHUtbW11
LQ0KaW5kZXguaDogSW4gZnVuY3Rpb24g4oCYY3B1X21tdV9pbmRleOKAmToNCi92YXIvbW50L3Nj
cmF0Y2gvYWxpc3RhaXIvc29mdHdhcmUvcWVtdS9pbmNsdWRlL2FjY2VsL3RjZy9jcHUtbW11LQ0K
aW5kZXguaDozNzoxMjogZXJyb3I6IOKAmE1NVV9VU0VSX0lEWOKAmSB1bmRlY2xhcmVkIChmaXJz
dCB1c2UgaW4gdGhpcw0KZnVuY3Rpb24pDQogICAzNyB8ICAgICByZXR1cm4gTU1VX1VTRVJfSURY
Ow0KICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+fn5+fg0KL3Zhci9tbnQvc2NyYXRjaC9hbGlz
dGFpci9zb2Z0d2FyZS9xZW11L2luY2x1ZGUvYWNjZWwvdGNnL2NwdS1tbXUtDQppbmRleC5oOjM3
OjEyOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5IG9u
Y2UNCmZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4NCm5pbmphOiBidWlsZCBzdG9wcGVk
OiBzdWJjb21tYW5kIGZhaWxlZC4NCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTcwOiBydW4tbmluamFd
IEVycm9yIDENCg0KDQo+IMKgI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpDQo+IMKgI2lu
Y2x1ZGUgInRjZy9wbXAuaCINCj4gwqAjZW5kaWYNCg==

